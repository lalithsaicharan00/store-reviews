package com.oftenenough.app.ui.onboarding

import android.net.Uri
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowRight
import androidx.compose.material.icons.outlined.Description
import androidx.compose.material.icons.outlined.MobileScreenShare
import androidx.compose.material.icons.outlined.WifiOff
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import app.habits.core.BackupProblem
import app.habits.core.RestoreMode
import com.oftenenough.app.R
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.backup.BackupCenter
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.backup.FileProblem
import com.oftenenough.app.ui.backup.WaitScreen
import com.oftenenough.app.ui.backup.countText
import com.oftenenough.app.ui.backup.driveEmail
import com.oftenenough.app.ui.components.Segment
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.move.CountCard
import com.oftenenough.app.ui.move.FromOldPhoneFlow
import com.oftenenough.app.ui.move.MoveEntry
import com.oftenenough.app.ui.move.StepHeading
import com.oftenenough.app.ui.move.fromLine
import com.oftenenough.app.ui.plus.CenterScreen
import com.oftenenough.app.ui.plus.FlowScreen
import com.oftenenough.app.ui.plus.MainButton
import com.oftenenough.app.ui.plus.PlusDialog
import com.oftenenough.app.ui.plus.QuietButton
import com.oftenenough.app.ui.settings.DayAndWeekRows
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch

/**
 * Onboarding: coming back (Figma `1549:2`). One question, "how do you want to bring your habits back?": Google Drive,
 * your old phone with the move code, or a backup file. There are no accounts (D16, 21 Oct 2026); Plus comes back from
 * Google Play by itself. Every "Start fresh" goes to Your days and weeks (8), then the empty Today; nothing here deletes
 * a copy anywhere (the Drive copy stays, D3). Nothing found is said plainly, never a blank Today that looks like loss.
 */
@Composable
fun ComingBackFlow(store: HabitStore, onBack: () -> Unit, onFinished: (String?) -> Unit) {
    val center = AppGraph.backup
    val context = LocalContext.current
    val scope = rememberCoroutineScope()
    var step by rememberSaveable { mutableStateOf("start") }
    var email by rememberSaveable { mutableStateOf("") }
    var counts by remember { mutableStateOf(0 to 0) }
    var pending by remember { mutableStateOf<BackupCenter.Pending?>(null) }
    var fileName by remember { mutableStateOf("") }
    var problem by remember { mutableStateOf<String?>(null) }
    var askFresh by remember { mutableStateOf(false) }
    // Where Back from the move code returns: the screen that offered it.
    var phoneFrom by rememberSaveable { mutableStateOf("start") }
    val back = { step = "start" }

    fun backMessage(h: Int, e: Int) = "Your habits are back: " + countText(h, e)

    /** 4.2 · Looking in Google Drive: what came down, or why not. */
    fun lookInDrive() {
        step = "drive-looking"
        scope.launch {
            val found = center.lookInDrive()
            when {
                found == null -> step = "offline"
                found.first > 0 -> { counts = found; step = "drive-found" }
                else -> step = "drive-empty"
            }
        }
    }

    /** 4 · Google Drive: Android's own account chooser, Google's permission screen the first time, then looking. */
    fun chooseDrive(another: Boolean = false) {
        scope.launch {
            if (another) center.disconnectDrive()
            if (center.link.accountName == null && !center.link.connect(context, null)) return@launch
            email = driveEmail(center) ?: email
            lookInDrive()
        }
    }

    fun bring(message: String) { step = "bringing"; scope.launch { onFinished(message) } }

    val file = rememberLauncherForActivityResult(ActivityResultContracts.OpenDocument()) { uri: Uri? ->
        if (uri != null) scope.launch {
            fileName = runCatching {
                context.contentResolver.query(uri, arrayOf(android.provider.OpenableColumns.DISPLAY_NAME), null, null, null)?.use { if (it.moveToFirst()) it.getString(0) else null }
            }.getOrNull() ?: "Your backup file"
            val p = center.check(uri)
            when {
                p == null -> { problem = BackupProblem.NOT_A_BACKUP; step = "file-problem" }
                p.check.problem != null -> { problem = p.check.problem; step = "file-problem" }
                else -> { pending = p; step = "file-found" }
            }
        }
    }
    fun chooseFile() = file.launch(arrayOf("application/zip", "application/octet-stream", "*/*"))

    /** Bring a file or a move in: replace (a new phone has nothing to merge with), with its undo file kept (D5). */
    fun restore(p: BackupCenter.Pending) {
        val preview = p.check.preview ?: return
        step = "bringing"
        counts = preview.fileHabits to preview.fileEntries
        scope.launch {
            center.restore(p, RestoreMode.REPLACE)
            onFinished(backMessage(preview.fileHabits, preview.fileEntries))
        }
    }

    // The ways back, as rows: shown on Welcome back and on every "not found" screen.
    @Composable
    fun WaysBack(drive: Boolean = true) = SegmentedList {
        val rows = buildList {
            if (drive) add("drive")
            add("phone"); add("file")
        }
        rows.forEachIndexed { i, r ->
            when (r) {
                "drive" -> WayRow({ Image(painterResource(R.drawable.ic_drive_logo), null, Modifier.size(22.dp)) }, "Google Drive", "Your backups there", i, rows.size, "back-drive") { chooseDrive() }
                "phone" -> WayRow({ Icon(Icons.Outlined.MobileScreenShare, null, Modifier.size(22.dp), tint = appColors.ink) }, "Your old phone", "Move them with a code", i, rows.size, "back-phone") { phoneFrom = step; step = "phone" }
                else -> WayRow({ Icon(Icons.Outlined.Description, null, Modifier.size(22.dp), tint = appColors.ink) }, "A backup file", "A file you saved", i, rows.size, "back-file") { chooseFile() }
            }
        }
    }

    when (step) {
        // ------------------------------------------------------------ 1 · Welcome back
        "start" -> FlowScreen(onBack = onBack, tag = "coming-back", top = true) {
            StepHeading("Welcome back.", "Choose how to bring your habits back.")
            Spacer(Modifier.height(16.dp))
            WaysBack()
        }
        // ------------------------------------------------------------ 4 · Google Drive
        "drive-looking" -> CenterScreen("Looking for your habits", "In ${owner(email)} Google Drive", "Cancel", "looking", back)
        "drive-found" -> FlowScreen(onBack = back, tag = "drive-found", top = true, bottom = {
            MainButton("Bring them back", "bring-back") { bring(backMessage(counts.first, counts.second)) }
            QuietButton("Start fresh instead", "start-fresh") { askFresh = true }
        }) {
            StepHeading("We found your habits.", "Your habits are in ${owner(email)} Google Drive.")
            CountCard(counts.first, counts.second, driveLine(center, store))
        }
        "drive-empty" -> FlowScreen(onBack = back, tag = "drive-empty", top = true, bottom = {
            MainButton("Try another Google Drive", "try-drive") { chooseDrive(another = true) }
            QuietButton("Start fresh", "start-fresh") { step = "fresh" }
        }) {
            StepHeading("No habits found.", "Nothing in ${owner(email)} Drive.")
            Label("Other ways")
            WaysBack(drive = false)
        }
        // 4.2.1 · Couldn't connect
        "offline" -> CenterScreen("Couldn’t connect", "We couldn’t reach Google. Check your internet connection, then try again.", "Cancel", "offline", back,
            icon = Icons.Outlined.WifiOff, main = "Try again", onMain = { chooseDrive() })
        // ------------------------------------------------------------ 5 · Your old phone
        "phone" -> FromOldPhoneFlow(center, MoveEntry.WELCOME, onBack = { step = phoneFrom }) { p -> pending = p; step = "phone-here" }
        "phone-here" -> pending?.check?.preview?.let { p ->
            FlowScreen(onBack = back, tag = "phone-here", top = true, bottom = { MainButton("Bring them back", "bring-back") { restore(pending!!) } }) {
                StepHeading("Your habits are here.", "Everything your old phone sent.")
                CountCard(p.fileHabits, p.fileEntries, fromLine(p.deviceName, p.createdAt, store))
            }
        }
        // ------------------------------------------------------------ 6 · A backup file
        "file-found" -> pending?.check?.preview?.let { p ->
            FlowScreen(onBack = back, tag = "file-found", top = true, bottom = {
                MainButton("Bring them back", "bring-back") { restore(pending!!) }
                QuietButton("Choose another file", "choose-file") { chooseFile() }
            }) {
                StepHeading("Your backup file.", fileName)
                CountCard(p.fileHabits, p.fileEntries, fromLine(p.deviceName, p.createdAt, store), Icons.Outlined.Description)
            }
        }
        "file-problem" -> FileProblem(problem ?: BackupProblem.NOT_A_BACKUP, onChoose = { chooseFile() }, onBack = back)
        "bringing" -> WaitScreen("Bringing back your habits", countText(counts.first, counts.second), "bringing")
        // ------------------------------------------------------------ 8 · Start fresh: Your days and weeks, then Today
        "fresh" -> FlowScreen(onBack = back, tag = "start-fresh-days", top = true, bottom = { MainButton("Continue", "onboarding-continue") { onFinished(null) } }) {
            StepHeading("Your days and weeks.", "Choose when your day and week start.")
            DayAndWeekRows(store)
            Text("You can change these later.", Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 12.dp), style = AppType.bodySmall, color = appColors.secondary)
        }
    }
    // 4.3.3 · Start fresh? Nothing is deleted anywhere: the copy stays in Drive; this phone forgets what came down.
    if (askFresh) PlusDialog(Icons.Outlined.Description, "Start fresh?", "Your habits stay where they are, so you can bring them back later.", "Start fresh",
        { askFresh = false; scope.launch { center.eraseThisPhone(); step = "fresh" } }, { askFresh = false }, tag = "start-fresh-dialog")
}

/** "sam@gmail.com’s", or "your" when the account isn't known. */
private fun owner(email: String) = if (email.isBlank()) "your" else "$email’s"

/** The Drive copy's line: the newest other device that sent, and when ("From a Pixel 9 · today, 9:14 AM"). */
private fun driveLine(center: BackupCenter, store: HabitStore): String {
    val other = center.status?.devices?.filter { !it.thisDevice }?.maxByOrNull { it.lastSent ?: it.lastCheckIn }
    return other?.let { fromLine(it.name, it.lastSent ?: it.lastCheckIn, store) } ?: "In your Google Drive"
}

@Composable
private fun Label(text: String) =
    Text(text, Modifier.fillMaxWidth().padding(start = 16.dp, top = 16.dp, bottom = 8.dp), style = AppType.labelLarge, color = appColors.secondary)

/** One way back: a tonal circle with its logo or icon, its name and line, ›. */
@Composable
private fun WayRow(icon: @Composable () -> Unit, title: String, line: String, index: Int, count: Int, tag: String, onClick: () -> Unit) {
    Segment(index, count, Modifier.semantics { testTag = tag }, onClick = onClick) {
        Box(Modifier.size(40.dp).clip(CircleShape).background(appColors.tonal), contentAlignment = Alignment.Center) { icon() }
        Spacer(Modifier.width(16.dp))
        Column(Modifier.weight(1f).padding(vertical = 6.dp)) {
            Text(title, style = AppType.titleMedium, color = appColors.ink)
            Text(line, style = AppType.bodyMedium, color = appColors.secondary)
        }
        Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = appColors.secondary)
    }
}
