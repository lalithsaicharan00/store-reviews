package com.oftenenough.app.ui.backup

import android.net.Uri
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
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.Undo
import androidx.compose.material.icons.outlined.CloudOff
import androidx.compose.material.icons.outlined.CloudDone
import androidx.compose.material.icons.outlined.CloudSync
import androidx.compose.material.icons.outlined.CloudUpload
import androidx.compose.material.icons.outlined.DeleteForever
import androidx.compose.material.icons.outlined.DriveFolderUpload
import androidx.compose.material.icons.outlined.PhoneAndroid
import androidx.compose.material.icons.outlined.TableChart
import androidx.compose.material.icons.rounded.AddToDrive
import androidx.compose.material.icons.rounded.Devices
import androidx.compose.material.icons.rounded.Restore
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.SnackbarHost
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.SnackbarResult
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
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
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import app.habits.core.BackupProblem
import app.habits.core.DriveState
import app.habits.core.RestoreChanges
import app.habits.core.RestoreMode
import com.oftenenough.app.app.backup.BackupCenter
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.components.Card
import com.oftenenough.app.ui.components.InkButton
import com.oftenenough.app.ui.components.Segment
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.components.TonalButton
import com.oftenenough.app.ui.newhabit.FormPage
import com.oftenenough.app.ui.newhabit.GroupTitle
import com.oftenenough.app.ui.newhabit.Note
import com.oftenenough.app.ui.newhabit.OpenRow
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

/** "12 habits, 840 logs". */
fun countText(habits: Int, logs: Int) = "$habits ${if (habits == 1) "habit" else "habits"}, $logs ${if (logs == 1) "log" else "logs"}"

/**
 * ≡ › Google Drive & Backup: the state first (backed up or synced, when, where; or only on this phone), then devices,
 * restore, export, and the two deliberate deletions (Rulebook D4, D9, D10: backup and export are free and visible).
 */
@Composable
fun BackupScreen(center: BackupCenter, store: HabitStore, onRestore: () -> Unit, onPlus: () -> Unit, onBack: () -> Unit, snackbar: SnackbarHostState? = null) {
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
    Box(Modifier.fillMaxSize()) {
        FormPage("Google Drive & Backup", chip = null, onBack = onBack) {
            Spacer(Modifier.height(8.dp))
            Card(Modifier.fillMaxWidth().semantics { testTag = "backup-state" }) {
                Column(Modifier.padding(20.dp)) {
                    val (icon, title, line) = when {
                        !connected -> Triple(Icons.Outlined.CloudOff, "Not backed up", "Your habits are only on this phone")
                        status?.state == DriveState.OFFLINE -> Triple(Icons.Outlined.CloudUpload, "Waiting to back up", "${status?.waiting ?: 0} changes waiting · offline")
                        status?.state == DriveState.FULL -> Triple(Icons.Outlined.CloudOff, "Google Drive is full", "Nothing is lost; it backs up when there's room")
                        status?.state == DriveState.NOT_CONNECTED -> Triple(Icons.Outlined.CloudOff, "Google Drive isn't connected", "Your habits are safe on this phone")
                        store.isPlus -> Triple(Icons.Outlined.CloudSync, "Synced", whenText(status?.lastSynced, store) + " · Google Drive (" + center.link.accountName + ")")
                        else -> Triple(Icons.Outlined.CloudDone, "Backed up", whenText(status?.lastSent, store) + " · Google Drive (" + center.link.accountName + ")")
                    }
                    Row(verticalAlignment = Alignment.CenterVertically) {
                        Box(Modifier.size(56.dp).clip(CircleShape).background(if (connected) appColors.ink else appColors.tonal), contentAlignment = Alignment.Center) {
                            Icon(icon, null, tint = if (connected) appColors.onInk else appColors.ink)
                        }
                        Spacer(Modifier.width(16.dp))
                        Column {
                            Text(title, style = MaterialTheme.typography.headlineSmall.copy(fontWeight = FontWeight.Medium), color = appColors.ink)
                            Text(line, style = MaterialTheme.typography.bodyMedium, color = appColors.secondary)
                        }
                    }
                    Spacer(Modifier.height(12.dp))
                    if (!connected) {
                        Text("Back up to your own Google Drive, automatically, as you go. Only Often Enough can read its backup there; we never see your habits.",
                            style = MaterialTheme.typography.bodyLarge, color = appColors.secondary)
                        Spacer(Modifier.height(16.dp))
                        InkButton("Back up to Google Drive", { scope.launch { center.connectDrive() } }, Modifier.semantics { testTag = "drive-connect" },
                            icon = Icons.Rounded.AddToDrive, height = 48.dp)
                    } else {
                        if (!store.isPlus) Text("Backs up as you go: when you leave the app, after a widget or notification log, and at least daily.",
                            style = MaterialTheme.typography.bodyMedium, color = appColors.secondary)
                        Spacer(Modifier.height(12.dp))
                        Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                            TonalButton(if (store.isPlus) "Sync now" else "Back up now", { scope.launch { center.syncNow() } },
                                Modifier.semantics { testTag = "drive-now" }, enabled = !center.working)
                            TonalButton("Change account", { scope.launch { center.disconnectDrive(); center.connectDrive() } })
                        }
                    }
                }
            }
            if (connected) {
                GroupTitle("Devices")
                SegmentedList {
                    val devices = status?.devices.orEmpty()
                    val count = maxOf(1, devices.size) + if (store.isPlus) 0 else 1
                    if (devices.isEmpty()) InfoRow(Icons.Outlined.PhoneAndroid, "This phone", center.info.deviceName, 0, count)
                    devices.forEachIndexed { i, d ->
                        InfoRow(Icons.Outlined.PhoneAndroid, if (d.thisDevice) "This phone" else d.name,
                            (if (d.thisDevice) d.name + " · " else "") + "synced " + whenText(d.lastCheckIn, store).replaceFirstChar { it.lowercase() }, i, count)
                    }
                    if (!store.isPlus) OpenRow("Use on more devices", "Keep a tablet or a second phone the same, with Plus", Icons.Rounded.Devices, count - 1, count, "more-devices", onPlus)
                }
                if (store.isPlus) Note("Anything logged on a device shows on the others once it next syncs.")
            }
            GroupTitle("Restore")
            SegmentedList {
                val count = if (center.undoAvailable) 2 else 1
                OpenRow("Restore from a backup", "From Google Drive or a backup file you saved", Icons.Rounded.Restore, 0, count, "restore-row", onRestore)
                if (center.undoAvailable) OpenRow("Undo last restore", "Back to how this phone was just before", Icons.AutoMirrored.Rounded.Undo, 1, count, "undo-restore") {
                    scope.launch { if (center.undoRestore()) snack.showSnackbar("This phone is back to how it was before the restore.") }
                }
            }
            GroupTitle("Export")
            SegmentedList {
                OpenRow("Save a backup file", "To restore later, here or on another device", Icons.Outlined.DriveFolderUpload, 0, 2, "save-file") { save.launch(center.fileName()) }
                OpenRow("Export a spreadsheet (CSV)", "To open in Google Sheets or Excel", Icons.Outlined.TableChart, 1, 2, "export-csv") { csv.launch(center.csvName()) }
            }
            Spacer(Modifier.height(24.dp))
            SegmentedList {
                val count = if (connected) 2 else 1
                if (connected) DangerRow("Delete my data from Google Drive…", Icons.Outlined.CloudOff, 0, count, "delete-drive") { confirm = "drive" }
                DangerRow("Erase all my data…", Icons.Outlined.DeleteForever, count - 1, count, "erase-all") { confirm = "erase" }
            }
            Spacer(Modifier.height(72.dp))
        }
        SnackbarHost(snack, Modifier.align(Alignment.BottomCenter).navigationBarsPadding())
    }
    when (confirm) {
        "drive" -> AlertDialog({ confirm = null }, title = { Text("Delete your data from Google Drive?") },
            text = { Text("Everything Often Enough keeps in your Google Drive is deleted, for every device. This phone keeps everything, and nothing goes to Google Drive until you turn it on again.") },
            confirmButton = { TextButton({ confirm = null; scope.launch { center.deleteFromDrive(); snack.showSnackbar("Deleted from Google Drive. This phone keeps everything.") } },
                Modifier.semantics { testTag = "delete-drive-confirm" }) { Text("Delete from Google Drive", color = appColors.error) } },
            dismissButton = { TextButton({ confirm = null }) { Text("Cancel", color = appColors.ink) } })
        "erase" -> AlertDialog({ confirm = null }, title = { Text("Erase everything?") },
            text = { Text("Every habit, log and note on this phone is erased, and Google Drive backup is turned off first so they don't come back. This can't be undone; save a backup file first if you might want them.") },
            confirmButton = { TextButton({ confirm = null; scope.launch { center.eraseThisPhone(); snack.showSnackbar("Everything on this phone is erased. You're starting fresh.") } },
                Modifier.semantics { testTag = "erase-confirm" }) { Text("Erase everything", color = appColors.error) } },
            dismissButton = { TextButton({ confirm = null }) { Text("Cancel", color = appColors.ink) } })
    }
}

@Composable
private fun InfoRow(icon: ImageVector, title: String, line: String, index: Int, count: Int) {
    Segment(index, count) {
        Icon(icon, null, tint = appColors.secondary)
        Spacer(Modifier.width(24.dp))
        Column(Modifier.padding(vertical = 6.dp)) {
            Text(title, style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
            Text(line, style = MaterialTheme.typography.bodyMedium, color = appColors.secondary)
        }
    }
}

@Composable
private fun DangerRow(title: String, icon: ImageVector, index: Int, count: Int, tag: String, onClick: () -> Unit) {
    Segment(index, count, Modifier.semantics { testTag = tag }, onClick = onClick) {
        Icon(icon, null, tint = appColors.error)
        Spacer(Modifier.width(24.dp))
        Text(title, style = MaterialTheme.typography.bodyLarge, color = appColors.error)
    }
}

/**
 * Restore from a backup: where it is (Google Drive, or a backup file through Android's own picker), then what's in it
 * against what's here, and Replace or Merge. Nothing changes until the person chooses; a restore can be undone for 30
 * days (D5); a file with nothing in it is never shown as restored.
 */
@Composable
fun RestoreScreen(center: BackupCenter, store: HabitStore, onBack: () -> Unit, onRestored: (String) -> Unit) {
    val scope = rememberCoroutineScope()
    var pending by remember { mutableStateOf<BackupCenter.Pending?>(null) }
    var problem by remember { mutableStateOf<String?>(null) }
    val open = rememberLauncherForActivityResult(ActivityResultContracts.OpenDocument()) { uri: Uri? ->
        if (uri != null) scope.launch {
            val p = center.check(uri)
            when {
                p == null -> problem = "Couldn't open that file."
                p.check.problem != null -> problem = problemText(p.check.problem!!)
                else -> pending = p
            }
        }
    }
    val p = pending
    val preview = p?.check?.preview
    if (preview == null) {
        FormPage("Restore from a backup", chip = null, onBack = onBack) {
            GroupTitle("Where is your backup?")
            SegmentedList {
                OpenRow("Google Drive", if (center.link.accountName != null) "Your habits come back from Google Drive as it syncs" else "Connect Google Drive, and what's there comes back",
                    Icons.Rounded.AddToDrive, 0, 2, "restore-drive") {
                    scope.launch {
                        val ok = if (center.link.accountName == null) center.connectDrive() else center.syncNow() != null
                        if (ok) onRestored("Your habits from Google Drive are here.")
                    }
                }
                OpenRow("A backup file", "Open a backup file you've saved", Icons.Outlined.DriveFolderUpload, 1, 2, "restore-file") {
                    open.launch(arrayOf("application/zip", "application/octet-stream", "*/*"))
                }
            }
            Note("Restoring replaces the habits on this phone. You can undo it for 30 days.")
        }
    } else {
        FormPage("Restore", chip = null, onBack = { pending = null }) {
            Spacer(Modifier.height(8.dp))
            Card(Modifier.fillMaxWidth().semantics { testTag = "restore-preview" }) {
                Column(Modifier.padding(20.dp)) {
                    Row(verticalAlignment = Alignment.CenterVertically) {
                        Box(Modifier.size(56.dp).clip(CircleShape).background(appColors.tonal), contentAlignment = Alignment.Center) {
                            Icon(Icons.Rounded.Restore, null, tint = appColors.ink)
                        }
                        Spacer(Modifier.width(16.dp))
                        Column {
                            Text(countText(preview.fileHabits, preview.fileEntries), style = MaterialTheme.typography.headlineSmall.copy(fontWeight = FontWeight.Medium), color = appColors.ink)
                            Text("From “${preview.deviceName}”, " + DayWords.short(store.rules.calendarDayOf(preview.createdAt)) + ", " + DayWords.clock(preview.createdAt),
                                style = MaterialTheme.typography.bodyMedium, color = appColors.secondary)
                        }
                    }
                    Spacer(Modifier.height(16.dp))
                    Row {
                        Text("On this phone now", Modifier.weight(1f), style = MaterialTheme.typography.bodyLarge, color = appColors.secondary)
                        Text(countText(preview.phoneHabits, preview.phoneEntries), style = MaterialTheme.typography.bodyLarge.copy(fontWeight = FontWeight.Medium), color = appColors.ink)
                    }
                }
            }
            Spacer(Modifier.height(24.dp))
            if (preview.fileHabits == 0 && preview.fileEntries == 0) {
                // A backup with nothing in it is never shown as restored (D5).
                Note("This backup has no habits in it, so there's nothing to restore. Your habits on this phone are unchanged.")
            } else {
                fun go(mode: RestoreMode) = scope.launch {
                    val changes = center.restore(p!!, mode)
                    onRestored(if (changes.changesNothing) "Everything in it is already here." else "Restored: " + countText(preview.fileHabits, preview.fileEntries))
                }
                InkButton("Replace what's on this phone", { go(RestoreMode.REPLACE) }, Modifier.fillMaxWidth().semantics { testTag = "restore-replace" }, enabled = !center.working)
                Note("This phone becomes exactly the backup. " + changesText(preview.replace))
                Spacer(Modifier.height(16.dp))
                TonalButton("Merge", { go(RestoreMode.MERGE) }, Modifier.fillMaxWidth().heightIn(min = 56.dp).semantics { testTag = "restore-merge" }, enabled = !center.working)
                Note("Adds what's missing and keeps everything here. " + changesText(preview.merge))
                Spacer(Modifier.height(8.dp))
                Note("You can undo a restore for 30 days in Google Drive & Backup.")
            }
        }
    }
    problem?.let { text ->
        AlertDialog({ problem = null }, title = { Text("Can't restore this file") }, text = { Text(text) },
            confirmButton = { TextButton({ problem = null }) { Text("OK", color = appColors.ink) } })
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

private fun problemText(reason: String) = when (reason) {
    BackupProblem.NOT_A_BACKUP -> "This isn't an Often Enough backup file. Choose the .zip file you saved from Often Enough."
    BackupProblem.REPACKED -> "This file was unzipped and zipped again by another app. Use the original file."
    BackupProblem.DAMAGED -> "This file is damaged: something in it doesn't match. Try another copy."
    BackupProblem.NEWER_VERSION -> "This backup was made by a newer version of Often Enough. Update the app, then restore it."
    else -> "This file can't be restored."
}

@Suppress("unused") private val keepSp = 1.sp
@Suppress("unused") private val keepResult = SnackbarResult.Dismissed
