package com.oftenenough.app.ui.backup

import android.net.Uri
import androidx.activity.compose.BackHandler
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.ArrowBack
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowRight
import androidx.compose.material.icons.automirrored.rounded.Undo
import androidx.compose.material.icons.outlined.AddToDrive
import androidx.compose.material.icons.outlined.CloudDone
import androidx.compose.material.icons.outlined.CloudOff
import androidx.compose.material.icons.outlined.CloudSync
import androidx.compose.material.icons.outlined.CloudUpload
import androidx.compose.material.icons.outlined.DeleteForever
import androidx.compose.material.icons.outlined.Description
import androidx.compose.material.icons.outlined.DriveFolderUpload
import androidx.compose.material.icons.outlined.MobileScreenShare
import androidx.compose.material.icons.outlined.PhoneAndroid
import androidx.compose.material.icons.outlined.Restore
import androidx.compose.material.icons.outlined.Sync
import androidx.compose.material.icons.outlined.SwapVert
import androidx.compose.material.icons.outlined.TableChart
import androidx.compose.material.icons.outlined.TabletAndroid
import androidx.compose.material.icons.outlined.WifiOff
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.SnackbarHost
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import app.habits.core.BackupProblem
import app.habits.core.DriveState
import app.habits.core.RestoreChanges
import app.habits.core.RestoreMode
import com.oftenenough.app.app.backup.BackupCenter
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.components.ExpressiveLoadingIndicator
import com.oftenenough.app.ui.components.InkButton
import com.oftenenough.app.ui.components.Segment
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.components.TonalButton
import com.oftenenough.app.ui.components.StepHeading
import com.oftenenough.app.ui.plus.FlowScreen
import com.oftenenough.app.ui.plus.MainButton
import com.oftenenough.app.ui.plus.PlusDialog
import com.oftenenough.app.ui.plus.QuietButton
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch

/** "Today 9:14 AM", "Just now", "Yesterday 9:14 AM". */
private fun whenText(ms: Long?, store: HabitStore): String {
    if (ms == null) return "Not yet"
    val now = System.currentTimeMillis()
    if (now - ms < 120_000) return "Just now"
    val day = store.rules.calendarDayOf(ms)
    val today = store.rules.calendarDayOf(now)
    val time = DayWords.clock(ms)
    return when (day) { today -> "Today $time"; today - 1 -> "Yesterday $time"; else -> DayWords.short(day) + ", " + time }
}

/** "sam@gmail.com" from the link's "Google Drive (sam@gmail.com)"; null for the stand-in. */
fun driveEmail(center: BackupCenter): String? = center.link.accountName?.let { Regex("\\(([^)]+@[^)]+)\\)").find(it)?.groupValues?.get(1) }

/** A page with ← and its title in the top bar (Backup & Sync's own pages). */
@Composable
private fun TitledPage(title: String, onBack: () -> Unit, tag: String, content: @Composable androidx.compose.foundation.layout.ColumnScope.() -> Unit) {
    val c = appColors
    BackHandler(onBack = onBack)
    Column(Modifier.fillMaxSize().background(c.screen).statusBarsPadding().semantics { testTag = tag }) {
        Row(Modifier.heightIn(min = 64.dp).padding(start = 4.dp), verticalAlignment = Alignment.CenterVertically) {
            IconButton(onBack, Modifier.semantics { testTag = "page-back" }) { Icon(Icons.AutoMirrored.Rounded.ArrowBack, "Back", tint = c.ink) }
            Text(title, style = AppType.titleLargeEmphasized, color = c.ink)
        }
        Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 16.dp).navigationBarsPadding(), content = content)
    }
}

@Composable
private fun SectionLabel(text: String) =
    Text(text, Modifier.padding(start = 16.dp, top = 24.dp, bottom = 8.dp), style = AppType.labelLarge, color = appColors.secondary)

/** A settings row: a 40 tonal circle, a title over its line, ›. */
@Composable
private fun PageRow(icon: ImageVector, title: String, line: String?, index: Int, count: Int, tag: String, danger: Boolean = false, chevron: Boolean = true, onClick: (() -> Unit)?) {
    val c = appColors
    Segment(index, count, Modifier.semantics { testTag = tag }, onClick = onClick) {
        Box(Modifier.size(40.dp).clip(CircleShape).background(c.tonal), contentAlignment = Alignment.Center) {
            Icon(icon, null, Modifier.size(22.dp), tint = if (danger) c.error else c.ink)
        }
        Spacer(Modifier.width(16.dp))
        Column(Modifier.weight(1f).padding(vertical = 6.dp)) {
            Text(title, style = AppType.titleMedium, color = if (danger) c.error else c.ink)
            if (line != null) Text(line, style = AppType.bodyMedium, color = c.secondary)
        }
        if (onClick != null && chevron && !danger) Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = c.secondary)
    }
}

/**
 * ≡ › Backup & Sync (Figma `1461:2`, 1–1.3): where the habits are first (backed up, synced with Plus, not backed up, no
 * internet), devices with Plus, then Move and restore, Export, and the two deliberate deletions, each asking with two
 * buttons only (5, 6; D9). Rulebook D4, D10: backup and export are free and visible.
 */
@Composable
fun BackupScreen(center: BackupCenter, store: HabitStore, onRestore: () -> Unit, onBack: () -> Unit, snackbar: SnackbarHostState? = null) {
    val c = appColors
    val scope = rememberCoroutineScope()
    val snack = snackbar ?: remember { SnackbarHostState() }
    var confirm by remember { mutableStateOf<String?>(null) }
    val save = rememberLauncherForActivityResult(ActivityResultContracts.CreateDocument("application/zip")) { uri: Uri? ->
        if (uri != null) scope.launch { snack.showSnackbar(if (center.saveFile(uri)) "Backup file saved and checked." else "Couldn't save the file. Your habits are safe on this phone.") }
    }
    val csv = rememberLauncherForActivityResult(ActivityResultContracts.CreateDocument("text/csv")) { uri: Uri? ->
        if (uri != null) scope.launch { snack.showSnackbar(if (center.exportCsv(uri)) "Spreadsheet saved." else "Couldn't export. Your habits are safe on this phone.") }
    }
    LaunchedEffect(center) { center.refreshStatus() }
    val status = center.status
    val connected = center.link.accountName != null
    val email = driveEmail(center)
    val offline = connected && status?.state == DriveState.OFFLINE
    Box(Modifier.fillMaxSize()) {
        TitledPage("Backup & Sync", onBack, "backup-page") {
            Spacer(Modifier.height(8.dp))
            // 1–1.3: the state, said plainly (D4: always the truth).
            Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(28.dp)).background(c.surface).padding(20.dp).semantics { testTag = "backup-state" }) {
                data class S(val icon: ImageVector, val filled: Boolean, val title: String, val line: String, val text: String)
                val who = email?.let { " · $it" } ?: ""
                val s = when {
                    !connected -> S(Icons.Outlined.CloudOff, false, "Not backed up", "Only on this phone for now",
                        "Back up to your own Google Drive as you go. Only Often Enough can open it, and we never see your habits.")
                    offline -> S(Icons.Outlined.WifiOff, false, "No internet", "${status?.waiting ?: 0} ${if (status?.waiting == 1) "change" else "changes"} waiting to sync",
                        "Everything works offline and is saved on this phone. Your changes sync as soon as you’re back online.")
                    status?.state == DriveState.FULL -> S(Icons.Outlined.CloudOff, false, "Google Drive is full", "Nothing is lost; it backs up when there’s room",
                        "Your habits are safe on this phone. Make room in your Google Drive, and it carries on by itself.")
                    status?.state == DriveState.NOT_CONNECTED -> S(Icons.Outlined.CloudOff, false, "Google Drive isn’t connected", "Your habits are safe on this phone",
                        "Connect it again to keep backing up.")
                    store.isPlus -> S(Icons.Outlined.CloudSync, true, "Synced", whenText(status?.lastSynced, store) + who,
                        "Your habits sync through your own Google Drive. Only Often Enough can open them, and we never see them.")
                    else -> S(Icons.Outlined.CloudDone, true, "Backed up", whenText(status?.lastSent, store) + who,
                        "Your habits are in your own Google Drive. Only Often Enough can open them, and we never see them. It backs up as you go, at least daily.")
                }
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Box(Modifier.size(56.dp).clip(CircleShape).background(if (s.filled) c.ink else c.tonal), contentAlignment = Alignment.Center) {
                        Icon(s.icon, null, Modifier.size(28.dp), tint = if (s.filled) c.onInk else c.ink)
                    }
                    Spacer(Modifier.width(16.dp))
                    Column {
                        Text(s.title, style = AppType.titleLarge, color = c.ink)
                        Text(s.line, style = AppType.bodyMedium, color = c.secondary)
                    }
                }
                Spacer(Modifier.height(12.dp))
                Text(s.text, style = AppType.bodyMedium, color = c.secondary)
                Spacer(Modifier.height(16.dp))
                when {
                    !connected -> InkButton("Back up to Google Drive", { scope.launch { center.connectDrive() } }, Modifier.semantics { testTag = "drive-connect" },
                        icon = Icons.Outlined.AddToDrive, height = 48.dp, textStyle = AppType.labelLarge)
                    offline -> TonalButton("Try again", { scope.launch { center.syncNow() } }, Modifier.semantics { testTag = "drive-now" }, icon = Icons.Outlined.Sync)
                    else -> Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                        TonalButton(if (store.isPlus) "Sync now" else "Back up now", { scope.launch { center.syncNow() } }, Modifier.semantics { testTag = "drive-now" },
                            enabled = !center.working, icon = if (store.isPlus) Icons.Outlined.Sync else Icons.Outlined.CloudUpload)
                        TonalButton("Change account", { confirm = "switch" }, Modifier.semantics { testTag = "drive-change" })
                    }
                }
            }
            // Devices: with Plus, every device on this Google Drive (1.2).
            if (connected && store.isPlus) {
                SectionLabel("Devices")
                SegmentedList {
                    val devices = status?.devices.orEmpty().ifEmpty { null }
                    if (devices == null) PageRow(Icons.Outlined.PhoneAndroid, "This phone", center.info.deviceName, 0, 1, "device-this", onClick = null)
                    else devices.forEachIndexed { i, d ->
                        PageRow(if (d.platform == "android" && d.name.contains("Tablet", true)) Icons.Outlined.TabletAndroid else Icons.Outlined.PhoneAndroid,
                            if (d.thisDevice) "This phone" else d.name,
                            if (d.thisDevice) d.name + " · " + (if (offline) "${status?.waiting ?: 0} changes not sent yet" else "synced " + whenText(d.lastCheckIn, store).replaceFirstChar { it.lowercase() })
                            else "Last synced at " + DayWords.clock(d.lastCheckIn), i, devices.size, "device-$i", onClick = null)
                    }
                }
                Text("Anything logged on a device shows on the others once it next syncs.", Modifier.padding(start = 16.dp, end = 16.dp, top = 8.dp),
                    style = AppType.bodySmall, color = c.secondary)
            }
            SectionLabel("Restore")
            SegmentedList {
                val count = if (center.undoAvailable) 2 else 1
                PageRow(Icons.Outlined.Restore, "Restore from a backup", "From Google Drive or a backup file", 0, count, "restore-row", onClick = onRestore)
                if (center.undoAvailable) PageRow(Icons.AutoMirrored.Rounded.Undo, "Undo last restore", "Back to how this phone was just before", 1, count, "undo-restore", chevron = false) {
                    scope.launch { if (center.undoRestore()) snack.showSnackbar("This phone is back to how it was before the restore.") }
                }
            }
            SectionLabel("Export")
            SegmentedList {
                PageRow(Icons.Outlined.DriveFolderUpload, "Save a backup file", "To restore later, on any phone", 0, 2, "save-file") { save.launch(center.fileName()) }
                PageRow(Icons.Outlined.TableChart, "Export a spreadsheet (CSV)", "To open in Google Sheets or Excel", 1, 2, "export-csv") { csv.launch(center.csvName()) }
            }
            Spacer(Modifier.height(24.dp))
            SegmentedList {
                val count = if (connected) 2 else 1
                if (connected) PageRow(Icons.Outlined.CloudOff, "Delete Google Drive backup…", null, 0, count, "delete-drive", danger = true) { confirm = "drive" }
                PageRow(Icons.Outlined.DeleteForever, "Erase all my data…", null, count - 1, count, "erase-all", danger = true) { confirm = "erase" }
            }
            Spacer(Modifier.height(72.dp))
        }
        SnackbarHost(snack, Modifier.align(Alignment.BottomCenter).navigationBarsPadding())
    }
    val who = email?.let { "$it’s" } ?: "your"
    when (confirm) {
        // 5 · Delete your Google Drive backup? (two buttons only, D9)
        "drive" -> PlusDialog(Icons.Outlined.CloudOff, "Delete your Google Drive backup?",
            "Your habits are removed from $who Google Drive. This phone keeps everything.", "Delete",
            { confirm = null; scope.launch { center.deleteFromDrive(); snack.showSnackbar("Deleted from Google Drive. This phone keeps everything.") } },
            { confirm = null }, destructive = true, tag = "delete-drive-dialog")
        // 6 · Erase all your data?
        "erase" -> PlusDialog(Icons.Outlined.DeleteForever, "Erase all your data?",
            if (connected) "Your habits, logs and notes are removed from this phone. Your Google Drive backup stays, so you can bring them back."
            else "Your habits, logs and notes are removed from this phone. This can’t be undone; save a backup file first if you might want them.",
            "Erase", { confirm = null; scope.launch { center.eraseThisPhone(); snack.showSnackbar("Everything on this phone is erased. You’re starting fresh.") } },
            { confirm = null }, destructive = true, tag = "erase-dialog")
        // 2.2 · Switch Google Drive? (after Google's own chooser on a real Drive; here before it)
        "switch" -> PlusDialog(Icons.Outlined.SwapVert, "Switch Google Drive?",
            "Your habits are copied to the Google Drive you choose and backed up there from now on. The copy in $who Drive stays until you delete it.",
            "Choose account", { confirm = null; scope.launch { center.disconnectDrive(); center.connectDrive() } }, { confirm = null }, tag = "switch-dialog")
    }
}

/** A waiting moment with no way out (Restoring, Bringing them back): writing habits isn't stopped halfway. */
@Composable
fun WaitScreen(title: String, line: String, tag: String) {
    val c = appColors
    BackHandler { }
    Column(Modifier.fillMaxSize().background(c.screen).statusBarsPadding().navigationBarsPadding().padding(horizontal = 40.dp).semantics { testTag = tag },
        horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.Center) {
        ExpressiveLoadingIndicator(c.tonal, c.ink)
        Spacer(Modifier.height(24.dp))
        Text(title, style = AppType.titleLargeEmphasized, color = c.ink, textAlign = TextAlign.Center)
        Spacer(Modifier.height(8.dp))
        Text(line, style = AppType.bodyMedium, color = c.secondary, textAlign = TextAlign.Center)
    }
}

/** A backup file that can't be brought in (coming back 6.1.1, 6.1.2; Restore 4.2): why, and what to do. */
@Composable
fun FileProblem(problem: String, onChoose: () -> Unit, onBack: () -> Unit) {
    val context = androidx.compose.ui.platform.LocalContext.current
    if (problem == BackupProblem.NEWER_VERSION) FlowScreen(onBack = onBack, tag = "file-newer", top = true, bottom = {
        MainButton("Update Often Enough", "file-update") {
            runCatching { context.startActivity(android.content.Intent(android.content.Intent.ACTION_VIEW, Uri.parse("market://details?id=com.oftenenough.app"))) }
        }
    }) {
        StepHeading("From a newer version.", "This backup is from a newer Often Enough. Update the app to bring it back; nothing has changed yet.")
    } else FlowScreen(onBack = onBack, tag = "file-not-backup", top = true, bottom = { MainButton("Choose another file", "file-choose", onClick = onChoose) }) {
        StepHeading("That isn’t a backup.", when (problem) {
            BackupProblem.REPACKED -> "This file was unzipped and zipped again by another app. Choose the original file, whose name starts with “Often Enough backup”."
            BackupProblem.DAMAGED -> "Something in this file doesn’t match, so it may be damaged. Choose another copy, whose name starts with “Often Enough backup”."
            else -> "Choose a file whose name starts with “Often Enough backup”."
        })
    }
}

/** "2 habits added, 28 logs added", or "Nothing changes." */
fun changesText(c: RestoreChanges): String {
    if (c.changesNothing) return "Nothing changes: everything in it is already here."
    val parts = buildList {
        if (c.habitsAdded > 0) add("${c.habitsAdded} ${if (c.habitsAdded == 1) "habit" else "habits"} added")
        if (c.habitsRemoved > 0) add("${c.habitsRemoved} ${if (c.habitsRemoved == 1) "habit" else "habits"} removed")
        if (c.habitsUpdated > 0) add("${c.habitsUpdated} ${if (c.habitsUpdated == 1) "habit" else "habits"} changed")
        if (c.entriesAdded > 0) add("${c.entriesAdded} ${if (c.entriesAdded == 1) "log" else "logs"} added")
        if (c.entriesRemoved > 0) add("${c.entriesRemoved} ${if (c.entriesRemoved == 1) "log" else "logs"} removed")
        if (c.settingsChanged > 0 && isEmpty()) add("settings updated")
    }
    return parts.joinToString(", ").replaceFirstChar { it.uppercase() } + "."
}

