@file:OptIn(androidx.compose.material3.ExperimentalMaterial3Api::class)

package com.oftenenough.app.ui.backup

import com.oftenenough.app.ui.components.CentredMessage
import com.oftenenough.app.ui.components.AppSnackbarHost
import androidx.compose.ui.graphics.Color
import com.oftenenough.app.ui.components.ListChevron
import com.oftenenough.app.ui.components.ListAvatar
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.CardNotice
import androidx.compose.foundation.layout.WindowInsets
import com.oftenenough.app.ui.components.NavigationIcon
import com.oftenenough.app.ui.components.AppTopBar
import android.net.Uri
import androidx.activity.compose.BackHandler
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.MaterialTheme
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
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import app.habits.core.BackupProblem
import app.habits.core.DriveState
import app.habits.core.RestoreChanges
import com.oftenenough.app.app.backup.BackupCenter
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.components.ExpressiveLoadingIndicator
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.plus.FlowScreen
import com.oftenenough.app.ui.components.AppDialog
import androidx.compose.ui.semantics.heading
import androidx.compose.foundation.layout.Arrangement
import com.oftenenough.app.ui.plus.MainButton
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import com.oftenenough.app.ui.plus.QuietButton
import kotlinx.coroutines.launch

/** "Today at 9:14 AM", "Just now", "Yesterday at 9:14 AM"; Settings' row joins with ", " ("Today, 9:14 AM", Figma 1173:547). */
private fun whenText(ms: Long?, store: HabitStore, join: String = " at "): String {
    if (ms == null) return "Not yet"
    val now = System.currentTimeMillis()
    if (now - ms < 120_000) return "Just now"
    val day = store.rules.calendarDayOf(ms)
    val today = store.rules.calendarDayOf(now)
    val time = DayWords.clock(ms)
    return when (day) { today -> "Today"; today - 1 -> "Yesterday"; else -> DayWords.short(day) } + join + time
}

/**
 * Settings' Backup & Sync row (5.8.3, Figma 1173:547): the page's card in a few words, with its icon, following it all
 * the way (Figma's flows: "Settings' Backup & Sync row follows the same status"). Figma draws Backed up · Today, 9:14 AM
 * (cloud_done), Backed up · Just now and Not backed up yet (cloud_off); the other states keep the card's own titles.
 */
fun backupSummary(center: BackupCenter, store: HabitStore): Pair<ImageVector, String> {
    val status = center.status
    val last = status?.lastSent
    return when {
        !center.link.available || center.link.accountName == null -> Symbols.CloudOff to "Not backed up yet"
        center.working -> Symbols.CloudUpload to "Backing up…"
        status?.state == DriveState.OFFLINE -> Symbols.CloudOff to "Waiting for the internet"
        status?.state == DriveState.FULL -> Symbols.CloudOff to "Google Drive is full"
        status?.state == DriveState.NOT_CONNECTED -> Symbols.LinkOff to "Google Drive isn’t connected"
        status?.state == DriveState.REMOVED -> Symbols.CloudAlert to "Your Google Drive backup was deleted"
        last == null -> Symbols.CloudOff to "Not backed up yet"
        else -> Symbols.CloudDone to "Backed up · " + whenText(last, store, ", ")
    }
}

/** "12 habits, 840 logs". */
fun countText(habits: Int, logs: Int) = "$habits ${if (habits == 1) "habit" else "habits"}, $logs ${if (logs == 1) "log" else "logs"}"

/** "sam@gmail.com" from the link's "Google Drive (sam@gmail.com)"; null for the stand-in. */
fun driveEmail(center: BackupCenter): String? = center.link.accountName?.let { Regex("\\(([^)]+@[^)]+)\\)").find(it)?.groupValues?.get(1) }

/** A page with ← and its title in the top bar (Backup & Sync's own pages). */
@Composable
private fun TitledPage(title: String, onBack: () -> Unit, tag: String, content: @Composable androidx.compose.foundation.layout.ColumnScope.() -> Unit) {
    val c = appColors
    BackHandler(onBack = onBack)
    Column(Modifier.fillMaxSize().background(c.screen).statusBarsPadding().semantics { testTag = tag }) {
        AppTopBar(title, navigationIcon = {
            NavigationIcon(Symbols.ArrowBack, "Back", onBack, Modifier.semantics { testTag = "page-back" })
        }, windowInsets = WindowInsets(0))
        Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).navigationBarsPadding().padding(start = 16.dp, end = 16.dp, top = 8.dp, bottom = 40.dp),
            verticalArrangement = Arrangement.spacedBy(24.dp), content = content)
    }
}

/** A section: its heading (Label Large, Primary, 16 in) 8 above its one list; no heading for the deletions. */
@Composable
private fun Section(title: String?, rows: @Composable androidx.compose.foundation.layout.ColumnScope.() -> Unit) =
    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
        if (title != null) Text(title, Modifier.padding(horizontal = 16.dp).semantics { heading() }, style = AppType.labelLarge,
            color = MaterialTheme.colorScheme.primary)
        SegmentedList(content = rows)
    }

/** A row (List item, Two lines, Surface bright): its icon in a circle, a title over its line; [danger] turns the words and icon Error (D9). */
@Composable
private fun PageRow(icon: ImageVector, title: String, line: String?, index: Int, count: Int, tag: String, danger: Boolean = false, chevron: Boolean = true, onClick: (() -> Unit)?) {
    val c = appColors
    AppListItem(title, index, count, supporting = line, onClick = onClick, tag = tag, headlineColor = if (danger) c.error else Color.Unspecified,
        leading = { ListAvatar(icon, tint = if (danger) c.error else null) },
        trailing = if (onClick != null && chevron && !danger) ({ ListChevron() }) else null,
        containerColor = MaterialTheme.colorScheme.surfaceBright)
}

/** Android's save picker can put a file anywhere: "saved to Downloads" only when it went there (D4: the truth). */
private fun inDownloads(uri: Uri): Boolean = uri.authority == "com.android.providers.downloads.documents" ||
    (uri.authority == "com.android.externalstorage.documents" &&
        runCatching { android.provider.DocumentsContract.getDocumentId(uri) }.getOrNull()?.startsWith("primary:Download") == true)

/**
 * 5.8.5, **Backup & Sync** (Figma 1178:960, Screen Backed up · Not backed up · Backed up · end of the list; the settings
 * page's flows: Back up now, Backing up for the first time, Change account, Back up now with no internet, Restore from
 * Google Drive, Restore from a backup file, Save a backup file, Export a spreadsheet, Delete the Google Drive backup,
 * Erase all my data). From Settings. On Surface container: the Top app bar (← "Backup & Sync"); scrolling, 8 above, 16
 * at the sides, 40 under, 24 between:
 *
 * - **Google Drive:** the Card notice saying where things stand (D4: always the truth), its one action a Tonal button
 *   under the words (Back up now; Back up to Google Drive); connected, 8 under it, Change account ("Backing up to
 *   sam@gmail.com").
 * - **Restore:** Restore from a backup ("From Google Drive or a file", ›).
 * - **Export:** Save a backup file ("To restore later, on any phone"), Export a spreadsheet (CSV) ("To open in Google
 *   Sheets or Excel"), each through Android's save picker, then a snackbar.
 * - The deletions, words and icons in Error: Delete Google Drive backup… ("This phone keeps everything", connected only),
 *   Erase all my data… ("From this phone"). Each asks first, Cancel and the one action only (D9). After Erase the app
 *   starts again on Today ([onErased]).
 *
 * Rows are List items on Surface bright, the icon in its circle. Rulebook D4, D10: backup and export are free and visible.
 */
@Composable
fun BackupScreen(center: BackupCenter, store: HabitStore, onRestore: () -> Unit, onErased: () -> Unit, onBack: () -> Unit, snackbar: SnackbarHostState? = null) {
    val scope = rememberCoroutineScope()
    val snack = snackbar ?: remember { SnackbarHostState() }
    var confirm by remember { mutableStateOf<String?>(null) }
    val save = rememberLauncherForActivityResult(ActivityResultContracts.CreateDocument("application/zip")) { uri: Uri? ->
        if (uri != null) scope.launch {
            snack.showSnackbar(if (!center.saveFile(uri)) "Couldn't save the file. Your habits are safe on this phone."
                else if (inDownloads(uri)) "Backup file saved to Downloads" else "Backup file saved")
        }
    }
    val csv = rememberLauncherForActivityResult(ActivityResultContracts.CreateDocument("text/csv")) { uri: Uri? ->
        if (uri != null) scope.launch {
            snack.showSnackbar(if (!center.exportCsv(uri)) "Couldn't export. Your habits are safe on this phone."
                else if (inDownloads(uri)) "Spreadsheet saved to Downloads" else "Spreadsheet saved")
        }
    }
    LaunchedEffect(center) { center.refreshStatus() }
    val status = center.status
    val connected = center.link.accountName != null
    val email = driveEmail(center)
    val offline = connected && status?.state == DriveState.OFFLINE
    Box(Modifier.fillMaxSize()) {
        TitledPage("Backup & Sync", onBack, "backup-page") {
            // The state, said plainly (D4: always the truth), as a Card notice (molecule 4.7), its one action a tonal
            // button under the words; then, connected, which Google account it backs up to.
            Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                var count by remember { mutableStateOf<Pair<Int, Int>?>(null) }
                val again: () -> Unit = { scope.launch { center.backUpEverythingAgain { saved, of -> count = saved to of }; count = null } }
                // Offline, Back up now says so (Figma's "Back up now with no internet"); it backs up by itself once online.
                val now: () -> Unit = { scope.launch { if (center.syncNow()?.state == DriveState.OFFLINE) snack.showSnackbar("No internet. It backs up once you’re online.") } }
                val last = status?.lastSent?.let { whenText(it, store) }
                val m = Modifier.semantics { testTag = "backup-state" }
                when {
                    // No Google Play services: Drive can't be reached from this phone at all. Say so (D4: the truth).
                    !center.link.available -> CardNotice(Symbols.CloudOff, "Not backed up",
                        "Backing up to Google Drive needs Google Play services, which this phone doesn’t have. Save a backup file below to keep a copy.", m)
                    connected && center.working -> CardNotice(Symbols.CloudUpload, "Backing up…", "You can leave this page; it carries on.", m,
                        working = true, progress = count?.let { (saved, of) -> if (of == 0) 0f else saved / of.toFloat() })
                    !connected -> CardNotice(Symbols.CloudOff, "Not backed up",
                        "Your habits are only on this phone. Back them up to your own Google Drive to keep them safe.", m,
                        action = "Back up to Google Drive", onAction = { scope.launch { center.connectDrive() } }, actionUnder = true, actionTag = "drive-connect")
                    offline -> CardNotice(Symbols.CloudOff, "Waiting for the internet",
                        (last?.let { "Last backed up " + it.replaceFirstChar { ch -> ch.lowercase() } + ". " } ?: "") +
                            "Nothing is lost: it backs up by itself once you’re online.", m)
                    status?.state == DriveState.FULL -> CardNotice(Symbols.CloudOff, "Google Drive is full",
                        "Your habits are safe on this phone. Make room in your Google Drive, and it carries on by itself.", m,
                        action = "Back up now", onAction = now, actionUnder = true, actionEnabled = !center.working, actionTag = "drive-now")
                    status?.state == DriveState.NOT_CONNECTED -> CardNotice(Symbols.LinkOff, "Google Drive isn’t connected",
                        "Your habits are safe on this phone. Connect it again to keep backing up.", m,
                        action = "Back up now", onAction = now, actionUnder = true, actionEnabled = !center.working, actionTag = "drive-now")
                    // A39: the app's files aren't in Drive any more. Nothing goes up until the person chooses; then
                    // everything again, every year (a backup saves only what changed, so untouched years would stay missing).
                    status?.state == DriveState.REMOVED -> CardNotice(Symbols.CloudAlert, "Your Google Drive backup was deleted",
                        "Your habits are still safe on this phone. Back them up again to keep a copy in Google Drive.", m,
                        action = "Back up again", onAction = again, actionUnder = true, actionEnabled = !center.working, actionTag = "drive-again")
                    else -> CardNotice(Symbols.CloudDone, "Backed up", (last ?: "Not yet") + ". It backs up by itself as you go.", m,
                        action = "Back up now", onAction = now, actionUnder = true, actionEnabled = !center.working, actionTag = "drive-now")
                }
                if (connected) SegmentedList {
                    PageRow(Symbols.SwitchAccount, "Change account", "Backing up to " + (email ?: "your Google Drive"), 0, 1, "drive-change", chevron = false) {
                        confirm = "switch"
                    }
                }
            }
            // Devices waits for the second device: this release is phones only and nothing syncs between devices yet
            // (A24), so a list of them would promise what the app doesn't do.
            Section("Restore") {
                val count = if (center.undoAvailable) 2 else 1
                PageRow(Symbols.SettingsBackupRestore, "Restore from a backup", "From Google Drive or a file", 0, count, "restore-row", onClick = onRestore)
                // Not in Figma: the 30-day undo file's only way back once the restore's snackbar has gone (D5; Decisions needed D-23).
                if (center.undoAvailable) PageRow(Symbols.Undo, "Undo last restore", "Back to how this phone was just before", 1, count, "undo-restore", chevron = false) {
                    scope.launch { if (center.undoRestore()) snack.showSnackbar("This phone is back to how it was before the restore.") }
                }
            }
            Section("Export") {
                PageRow(Symbols.Save, "Save a backup file", "To restore later, on any phone", 0, 2, "save-file") { save.launch(center.fileName()) }
                PageRow(Symbols.Table, "Export a spreadsheet (CSV)", "To open in Google Sheets or Excel", 1, 2, "export-csv") { csv.launch(center.csvName()) }
            }
            Section(null) {
                val count = if (connected) 2 else 1
                if (connected) PageRow(Symbols.Delete, "Delete Google Drive backup…", "This phone keeps everything", 0, count, "delete-drive", danger = true) { confirm = "drive" }
                PageRow(Symbols.DeleteForever, "Erase all my data…", "From this phone", count - 1, count, "erase-all", danger = true) { confirm = "erase" }
            }
        }
        AppSnackbarHost(snack, Modifier.align(Alignment.BottomCenter).navigationBarsPadding())
    }
    val who = email?.let { "$it’s" } ?: "your"
    when (confirm) {
        // Delete your Google Drive backup? Cancel and Delete only (D9); says plainly where the habits stay.
        "drive" -> AppDialog("Delete your Google Drive backup?",
            "Your backup in $who Google Drive is deleted. Your habits stay on this phone, and nothing is backed up until you turn it on again.", "Delete",
            { confirm = null; scope.launch { center.deleteFromDrive(); snack.showSnackbar("Google Drive backup deleted") } },
            { confirm = null }, Modifier.semantics { testTag = "delete-drive-dialog" }, destructive = true, confirmTag = "delete-drive-confirm")
        // Erase all your data? Cancel and Erase only (D9); then the app starts again on Today, as a fresh install.
        "erase" -> AppDialog("Erase all your data?",
            "Your habits, logs and notes are removed from this phone. " +
                if (connected) "Your Google Drive backup stays, so you can bring them back." else "They aren’t backed up anywhere, so they can’t be brought back.",
            "Erase", { confirm = null; scope.launch { center.eraseThisPhone(); onErased() } },
            { confirm = null }, Modifier.semantics { testTag = "erase-dialog" }, destructive = true, confirmTag = "erase-confirm")
        // Back up to another Drive? Asked before Google's own chooser: the Drive link chooses and connects in one step
        // (Figma asks after it, naming the account; Decisions needed D-22).
        "switch" -> AppDialog("Back up to another Drive?",
            "From now on, your habits back up to the Google Drive you choose. The backup in $who Drive stays there until you delete it.",
            "Choose account", { confirm = null; scope.launch { center.disconnectDrive(); center.connectDrive() } }, { confirm = null },
            Modifier.semantics { testTag = "switch-dialog" }, confirmTag = "switch-confirm")
    }
}

/**
 * A waiting moment (Restoring, 582:7893). Cancel (and Back) are offered only while nothing has been written yet;
 * once habits are being written, there is no way out: a restore is never stopped halfway.
 */
@Composable
fun WaitScreen(title: String, line: String, tag: String, onCancel: (() -> Unit)? = null) {
    BackHandler { onCancel?.invoke() }
    CentredMessage(title, line, tag,
        mark = { ExpressiveLoadingIndicator(MaterialTheme.colorScheme.surfaceContainerHighest, MaterialTheme.colorScheme.onSurface) },
        bottom = { if (onCancel != null) QuietButton("Cancel", "$tag-cancel", onClick = onCancel) })
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
        StepHeading("From a newer version.", "This backup is from a newer Often Enough. Update the app to bring it back. Nothing has changed yet.")
    } else FlowScreen(onBack = onBack, tag = "file-not-backup", top = true, bottom = { MainButton("Choose another file", "file-choose", onClick = onChoose) }) {
        // 582:8484 · one sentence for every file that isn't one of ours, repacked or damaged alike.
        StepHeading("That isn’t a backup.", "Choose a file whose name starts with “Often Enough backup”.")
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

