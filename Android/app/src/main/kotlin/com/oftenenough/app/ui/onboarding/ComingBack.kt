package com.oftenenough.app.ui.onboarding

import android.app.Activity
import android.net.Uri
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowRight
import androidx.compose.material.icons.outlined.Description
import androidx.compose.material.icons.outlined.MobileScreenShare
import androidx.compose.material.icons.outlined.WifiOff
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
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
import androidx.compose.ui.graphics.ColorFilter
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import app.habits.account.Answer
import app.habits.account.CloudKind
import app.habits.account.SignIn
import app.habits.account.SignInReply
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
import com.oftenenough.app.ui.move.StepsCard
import com.oftenenough.app.ui.move.fromLine
import com.oftenenough.app.ui.plus.CenterScreen
import com.oftenenough.app.ui.plus.ContinueWith
import com.oftenenough.app.ui.plus.FlowScreen
import com.oftenenough.app.ui.plus.MainButton
import com.oftenenough.app.ui.plus.PlusDialog
import com.oftenenough.app.ui.plus.QuietButton
import com.oftenenough.app.ui.settings.DayAndWeekRows
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch

/**
 * Onboarding: coming back (Figma `1549:2`). One question, "how do you want to bring your habits back?": **with your Plus
 * account** (Continue with Google, Continue with Apple: the account always brings Plus back, then the habits from its
 * Google Drive), or **without an account** (Google Drive, your old phone with the move code, a backup file). Every
 * "Start fresh" goes to Your days and weeks (8), then the empty Today; nothing here deletes a copy anywhere (the Drive
 * copy stays, D3). Nothing found is said plainly, never a blank Today that looks like loss (D16).
 *
 * The account says where the habits live (D16, Current Work 138): its own Google account's Drive (straight there, no
 * chooser), a different Google account's Drive (2.5: the person chooses it), or an iPhone's iCloud (2.3, 3.3: moved
 * across with a code, as Android can't open iCloud). A Drive chosen is checked against the one on record before
 * anything is read; the wrong one asks again. Another account is never named.
 */
@Composable
fun ComingBackFlow(store: HabitStore, onBack: () -> Unit, onFinished: (String?) -> Unit) {
    val center = AppGraph.backup
    val context = LocalContext.current
    val scope = rememberCoroutineScope()
    var step by rememberSaveable { mutableStateOf("start") }
    var email by rememberSaveable { mutableStateOf("") }
    var retry by rememberSaveable { mutableStateOf("") }
    var counts by remember { mutableStateOf(0 to 0) }
    var pending by remember { mutableStateOf<BackupCenter.Pending?>(null) }
    var fileName by remember { mutableStateOf("") }
    var problem by remember { mutableStateOf<String?>(null) }
    var askFresh by remember { mutableStateOf(false) }
    // The Drive the account has on record (its private ID), and the screen that asks for it again after a wrong pick.
    var recordKey by rememberSaveable { mutableStateOf<String?>(null) }
    var driveAgain by rememberSaveable { mutableStateOf("plus-other-drive") }
    // Where Back from the move code returns: the screen that offered it.
    var phoneFrom by rememberSaveable { mutableStateOf("start") }
    val back = { step = "start" }

    fun backMessage(h: Int, e: Int) = "Your habits are back: " + countText(h, e)

    /** 4.2 · Looking in Google Drive: what came down, or why not. */
    fun lookInDrive(plus: Boolean) {
        step = if (plus) "plus-looking" else "drive-looking"
        scope.launch {
            val found = center.lookInDrive()
            when {
                found == null -> { retry = if (plus) "google" else "drive"; step = "offline" }
                found.first > 0 -> { counts = found; step = if (plus) "plus-found" else "drive-found" }
                else -> step = if (plus) "plus-empty" else "drive-empty"
            }
        }
    }

    /**
     * 4 · Google Drive: Android's own account chooser, Google's permission screen the first time, then looking. [account]:
     * the Google account just signed in with, asked for with no chooser. With Plus, a Drive on record is checked first
     * ([check]: off for "Try another Google Drive" after the one on record was empty, 2.6).
     */
    fun chooseDrive(plus: Boolean, another: Boolean = false, account: String? = null, check: Boolean = true) {
        scope.launch {
            val want = if (plus && check) recordKey else null
            val connected = center.link.accountKey
            if (another || (want != null && connected != null && connected != want)) center.disconnectDrive()
            if (center.link.accountName == null && !center.link.connect(context, account)) return@launch
            if (want != null && center.link.accountKey != want) {
                // Not the account the habits are in: nothing is read from it, and the screen asks again.
                center.disconnectDrive()
                step = driveAgain
                return@launch
            }
            email = driveEmail(center) ?: email
            lookInDrive(plus)
        }
    }

    /** 2, 3 · Continue with Google or Apple: Plus comes back from the account; the habits from its Google Drive. */
    fun signIn(google: Boolean) {
        val activity = context as? Activity ?: return
        scope.launch {
            val proof: SignIn = (if (google) AppGraph.signIn.google(activity) else AppGraph.signIn.apple(activity)) ?: return@launch
            email = proof.email
            step = if (google) "google-looking" else "apple-looking"
            when (val reply = AppGraph.accounts.signIn(proof)) {
                Answer.Offline -> { retry = if (google) "google" else "apple"; step = "offline" }
                is Answer.Ok -> when (val found = reply.value) {
                    SignInReply.NoAccount -> step = if (google) "google-none" else "apple-none"
                    is SignInReply.Found -> {
                        val cloud = found.account.cloud
                        recordKey = cloud?.place?.takeIf { it.kind == CloudKind.GOOGLE_DRIVE }?.key
                        driveAgain = if (google) "plus-other-drive" else "apple-found"
                        when {
                            // In an iPhone's iCloud: Android can't open it, so the code (2.3, 3.3).
                            cloud?.place?.kind == CloudKind.ICLOUD -> step = if (google) "plus-icloud" else "apple-icloud"
                            // Signed in with Apple: an Apple sign-in can't open a Google Drive, so the person chooses
                            // the account that holds them (3.2).
                            !google -> step = "apple-found"
                            // That Google account's own Drive, or nothing on record yet: straight there (2.1, 2.2).
                            cloud == null || cloud.signInAccount -> chooseDrive(plus = true, account = proof.email)
                            // Backed up to a different Google account (2.5).
                            else -> step = "plus-other-drive"
                        }
                    }
                }
            }
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

    // The ways back without an account, as rows: shown on Welcome back and on every "not found" screen.
    @Composable
    fun WithoutAccount(drive: Boolean = true) = SegmentedList {
        val rows = buildList {
            if (drive) add("drive")
            add("phone"); add("file")
        }
        rows.forEachIndexed { i, r ->
            when (r) {
                "drive" -> WayRow({ Image(painterResource(R.drawable.ic_drive_logo), null, Modifier.size(22.dp)) }, "Google Drive", "Your backups there", i, rows.size, "back-drive") { chooseDrive(plus = false) }
                "phone" -> WayRow({ Icon(Icons.Outlined.MobileScreenShare, null, Modifier.size(22.dp), tint = appColors.ink) }, "Your old phone", "Move them with a code", i, rows.size, "back-phone") { phoneFrom = step; step = "phone" }
                else -> WayRow({ Icon(Icons.Outlined.Description, null, Modifier.size(22.dp), tint = appColors.ink) }, "A backup file", "A file you saved", i, rows.size, "back-file") { chooseFile() }
            }
        }
    }

    when (step) {
        // ------------------------------------------------------------ 1 · Welcome back
        "start" -> FlowScreen(onBack = onBack, tag = "coming-back", top = true) {
            StepHeading("Welcome back.", "Choose how to bring your habits back.")
            Label("With your Plus account")
            ContinueWith(google = true, tag = "back-google") { signIn(true) }
            Spacer(Modifier.height(8.dp))
            if (AppGraph.signIn.canSignInWithApple) AppleButton { signIn(false) }
            Label("Without an account")
            WithoutAccount()
        }
        // ------------------------------------------------------------ 2 · Continue with Google
        "google-looking" -> CenterScreen("Looking for your habits", "Signed in with Google", "Cancel", "looking", back)
        "plus-looking" -> CenterScreen("Looking for your habits", "Signed in with Google", "Cancel", "looking", back)
        "plus-found" -> FlowScreen(onBack = back, tag = "plus-found", top = true, bottom = {
            MainButton("Bring them back", "bring-back") { bring(backMessage(counts.first, counts.second)) }
            QuietButton("Start fresh instead", "start-fresh") { askFresh = true }
        }) {
            StepHeading("We found your habits.", "Plus is on, and your habits are in your Google Drive.")
            CountCard(counts.first, counts.second, driveLine(center, store))
        }
        "plus-empty" -> FlowScreen(onBack = back, tag = "plus-empty", top = true, bottom = {
            MainButton("Try another Google Drive", "try-drive") { chooseDrive(plus = true, another = true, check = false) }
            QuietButton("Start fresh", "start-fresh") { step = "fresh" }
        }) {
            StepHeading("Plus is back.", "We didn’t find your habits in ${owner(email)} Google Drive. Bring them another way:")
            Label("Other ways")
            WithoutAccount(drive = false)
        }
        // 2.5 · Plus is back, the habits in a different Google account: chosen in Google's chooser (2.5.1), then checked.
        "plus-other-drive" -> FlowScreen(onBack = back, tag = "plus-other-drive", top = true, bottom = {
            MainButton("Choose the Drive account", "choose-drive") { chooseDrive(plus = true, another = true) }
            QuietButton("Start fresh instead", "start-fresh") { askFresh = true }
        }) {
            StepHeading("Plus is back.", "Your Plus is on the account you signed in with. Your habits are in a different Google Drive account: choose the one that holds them.")
        }
        // 2.3, 3.3 · They're on your iPhone: Android can't open iCloud, so the move code (then 5).
        "plus-icloud", "apple-icloud" -> FlowScreen(onBack = back, tag = "on-your-iphone", top = true, bottom = {
            MainButton("Enter the code", "enter-code") { phoneFrom = step; step = "phone" }
            QuietButton("Start fresh instead", "start-fresh") { askFresh = true }
        }) {
            StepHeading("They’re on your iPhone.", "Plus is on. Android can’t open iCloud, so move your habits across with a code.")
            StepsCard(listOf(
                "Open the app on your iPhone" to "Or on your iPad",
                "Choose Move to a new phone" to "In ≡ › iCloud & Backup",
                // Figma said "It works for 24 hours"; the move as built needs both phones online at once (D15).
                "Type its code on this phone" to "Keep the app open on both",
            ))
            Text("No iPhone? Any iPhone or iPad on your Apple Account can make the code.",
                Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 12.dp), style = AppType.bodySmall, color = appColors.secondary)
        }
        "google-none" -> NoAccount("No Plus account uses $email.", other = {
            WayRow({ Image(painterResource(R.drawable.ic_google_logo), null, Modifier.size(20.dp)) }, "Another Google account", "Choose a different one", 0, 2, "another-google") { signIn(true) }
            WayRow({ Image(painterResource(R.drawable.ic_apple_logo), null, Modifier.size(width = 17.dp, height = 21.dp), colorFilter = ColorFilter.tint(appColors.ink)) },
                "Continue with Apple", "If you made it with Apple", 1, 2, "other-apple") { signIn(false) }
        }, without = { WithoutAccount() }, onBack = back) { step = "fresh" }
        // ------------------------------------------------------------ 3 · Continue with Apple
        "apple-looking" -> CenterScreen("Looking for your habits", "Signed in with Apple", "Cancel", "looking", back)
        "apple-found" -> FlowScreen(onBack = back, tag = "apple-found", top = true, bottom = {
            MainButton("Choose the Drive account", "choose-drive") { chooseDrive(plus = true) }
            QuietButton("Start fresh instead", "start-fresh") { step = "fresh" }
        }) {
            StepHeading("Plus is back.", "Your habits are in Google Drive. Choose the Google account that holds them.")
        }
        "apple-none" -> NoAccount("No Plus account for this Apple Account.", other = {
            WayRow({ Image(painterResource(R.drawable.ic_apple_logo), null, Modifier.size(width = 17.dp, height = 21.dp), colorFilter = ColorFilter.tint(appColors.ink)) },
                "Another Apple Account", "Try a different one", 0, 2, "another-apple") { signIn(false) }
            WayRow({ Image(painterResource(R.drawable.ic_google_logo), null, Modifier.size(20.dp)) }, "Continue with Google", "If you made it with Google", 1, 2, "other-google") { signIn(true) }
        }, without = { WithoutAccount() }, onBack = back) { step = "fresh" }
        // ------------------------------------------------------------ 4 · Google Drive, without an account
        "drive-looking" -> CenterScreen("Looking for your habits", "In ${owner(email)} Google Drive", "Cancel", "looking", back)
        "drive-found" -> FlowScreen(onBack = back, tag = "drive-found", top = true, bottom = {
            MainButton("Bring them back", "bring-back") { bring(backMessage(counts.first, counts.second)) }
            QuietButton("Start fresh instead", "start-fresh") { askFresh = true }
        }) {
            StepHeading("We found your habits.", "Your habits are in ${owner(email)} Google Drive.")
            CountCard(counts.first, counts.second, driveLine(center, store))
        }
        "drive-empty" -> FlowScreen(onBack = back, tag = "drive-empty", top = true, bottom = {
            MainButton("Try another Google Drive", "try-drive") { chooseDrive(plus = false, another = true) }
            QuietButton("Start fresh", "start-fresh") { step = "fresh" }
        }) {
            StepHeading("No habits found.", "Nothing in ${owner(email)} Drive.")
            Label("Other ways")
            WithoutAccount(drive = false)
        }
        // 4.2.1 · Couldn't connect (also from 2.1 and 3.1)
        "offline" -> CenterScreen("Couldn’t connect", "We couldn’t reach Google. Check your internet connection, then try again.", "Cancel", "offline", back,
            icon = Icons.Outlined.WifiOff, main = "Try again", onMain = {
                when (retry) { "google" -> signIn(true); "apple" -> signIn(false); else -> chooseDrive(plus = false) }
            })
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

/** 2.4, 3.4 · No account found: the account just used (never another), other accounts to try, then the ways without one. */
@Composable
private fun NoAccount(line: String, other: @Composable () -> Unit, without: @Composable () -> Unit, onBack: () -> Unit, onFresh: () -> Unit) {
    FlowScreen(onBack = onBack, tag = "no-account", top = true, bottom = { QuietButton("Start fresh", "start-fresh", onClick = onFresh) }) {
        StepHeading("No account found.", line)
        Label("Try another account")
        SegmentedList { other() }
        Label("Without an account")
        without()
    }
}

/** Continue with Apple: Apple's black button with its logo (Figma 1549:3; Apple's sign-in branding). */
@Composable
private fun AppleButton(onClick: () -> Unit) {
    Button(onClick, Modifier.fillMaxWidth().heightIn(min = 56.dp).semantics { testTag = "back-apple" },
        colors = ButtonDefaults.buttonColors(containerColor = androidx.compose.ui.graphics.Color.Black, contentColor = androidx.compose.ui.graphics.Color.White),
        contentPadding = PaddingValues(horizontal = 24.dp, vertical = 12.dp)) {
        Image(painterResource(R.drawable.ic_apple_logo), null, Modifier.size(width = 17.dp, height = 21.dp), colorFilter = ColorFilter.tint(androidx.compose.ui.graphics.Color.White))
        Spacer(Modifier.width(12.dp))
        Text("Continue with Apple", style = AppType.titleMedium)
    }
}

