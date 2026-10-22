package com.oftenenough.app.ui.restore

import android.content.Context
import android.content.Intent
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.net.Uri
import android.os.Build
import androidx.activity.compose.BackHandler
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.RowScope
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowRight
import androidx.compose.material.icons.outlined.Description
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
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import app.habits.core.BackupProblem
import app.habits.core.RestoreMode
import com.oftenenough.app.R
import com.oftenenough.app.app.PlusStore
import com.oftenenough.app.app.RestoreResult
import com.oftenenough.app.app.backup.BackupCenter
import com.oftenenough.app.app.backup.DriveLook
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.backup.FileProblem
import com.oftenenough.app.ui.backup.WaitScreen
import com.oftenenough.app.ui.backup.driveEmail
import com.oftenenough.app.ui.components.Segment
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.backup.StepHeading
import com.oftenenough.app.ui.backup.countText
import com.oftenenough.app.ui.plus.FlowScreen
import com.oftenenough.app.ui.plus.MainButton
import com.oftenenough.app.ui.plus.QuietButton
import com.oftenenough.app.ui.settings.Support
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch

/**
 * **Restore from a backup** — the whole of the new Figma file's onboarding page (`sJptV3HAKYauEIGUxYS3qs`, `1:5`),
 * which replaced the old welcome on 22 October 2026: there is no onboarding any more, so this is the only way back in.
 * Someone opens the app, sees the empty Today (`36:32`), taps **Restore from a backup**, and lands here (`39:1590`).
 *
 * Two ways back, and only two (**Google Drive** and **a backup file**): the move code and its relay went with the
 * server. Each way ends on Today with "Your habits are back: N habits, M logs", or on one of the screens the twelve
 * flows draw — no internet (`39:4741`, `43:2999`), no backup in that Google account (`39:6065`), not a backup
 * (`39:6596`), from a newer version (`39:7095`), or **Plus isn't on this phone** (`43:1776`, `43:2689`).
 *
 * **Plus is never unlocked here.** A backup records whether the device that made it had Plus, but that flag only
 * chooses which words this screen shows: the habits above the free limit come back only when *this phone's Google
 * Play account* has Plus (Rulebook D16; the user, 22 Oct 2026). Nothing is written until that is settled.
 */
@Composable
fun RestoreFlow(
    center: BackupCenter,
    store: HabitStore,
    plus: PlusStore,
    hasPlus: () -> Boolean,
    onBack: () -> Unit,
    onRestored: (String) -> Unit,
) {
    val context = LocalContext.current
    val scope = rememberCoroutineScope()

    // One step at a time, kept by name so a rotation lands back where it was.
    var step by rememberSaveable { mutableStateOf(WHERE) }
    var problem by rememberSaveable { mutableStateOf(BackupProblem.NOT_A_BACKUP) }
    /** The backup this phone would take: "android" or "ios", and whether that device had Plus. Words only. */
    var madeOn by rememberSaveable { mutableStateOf("") }
    var madeWithPlus by rememberSaveable { mutableStateOf(false) }
    /** Which way is being tried, so Restoring and Try again say and repeat the right thing. */
    var fromDrive by rememberSaveable { mutableStateOf(false) }
    // A checked file holds the whole backup in memory, so it is never written into the saved state.
    val pending = remember { mutableStateOf<BackupCenter.Pending?>(null) }

    val email = driveEmail(center)

    // ---------------------------------------------------------------- Doing the work

    /**
     * A file or a Drive copy needs Plus when it holds more habits **than the free plan keeps going at once** — the
     * same count a device makes of its own (not archived, not a task). Counting tasks or archived habits here would
     * stop a free person restoring their own backup, which is the opposite of the point.
     */
    fun needsPlus(activeHabits: Int) = activeHabits > HabitStore.FREE_HABIT_LIMIT

    /**
     * Asks Google Play again what this phone's Google account owns — the only place Plus ever comes from (D16). A
     * backup's flag, a file, a setting or a code never unlock it. Null means Play couldn't be reached.
     */
    suspend fun playHasPlus(): Boolean? = when (plus.restore()) {
        RestoreResult.FOUND -> true
        RestoreResult.NONE -> false
        RestoreResult.COULD_NOT_CONNECT -> null
    }

    fun finish() = onRestored("Your habits are back: " + countText(store.habits.count { !it.archived }, store.entryCount))

    /** A file that has been read and checked: the Plus gate first, then the restore. Nothing is written before. */
    fun restoreFile(p: BackupCenter.Pending) {
        val preview = p.check.preview ?: return
        madeOn = preview.platform
        madeWithPlus = preview.plus
        fromDrive = false
        pending.value = p
        if (preview.fileHabits == 0 && preview.fileEntries == 0) {
            onRestored("That backup has no habits in it, so nothing changed.")
            return
        }
        step = RESTORING
        scope.launch {
            if (needsPlus(preview.fileActiveHabits) && !hasPlus()) {
                when (playHasPlus()) {
                    null -> { step = NO_INTERNET_PLUS; return@launch }
                    false -> { step = NEEDS_PLUS; return@launch }
                    true -> Unit
                }
            }
            center.restore(p, RestoreMode.REPLACE)
            finish()
        }
    }

    /** Google Drive: the copy comes down (nothing goes up), then the same gate; without Plus it is put back. */
    fun restoreFromDrive() {
        fromDrive = true
        step = RESTORING
        scope.launch {
            val emptyBefore = store.habits.isEmpty()
            when (val look = center.lookInDrive()) {
                is DriveLook.Offline -> step = NO_INTERNET_DRIVE
                is DriveLook.NotConnected, is DriveLook.Problem, is DriveLook.Nothing -> step = NO_BACKUP
                is DriveLook.Found -> {
                    madeOn = "android"
                    madeWithPlus = needsPlus(look.activeHabits)
                    if (needsPlus(look.activeHabits) && !hasPlus() && playHasPlus() != true) {
                        // Checked before anything is kept: this phone goes back as it was (it was empty — the only
                        // place this flow starts), and Drive keeps everything, because nothing ever went up.
                        val offline = !online(context)
                        if (emptyBefore) center.eraseThisPhone()
                        step = if (offline) NO_INTERNET_PLUS else NEEDS_PLUS
                        return@launch
                    }
                    finish()
                }
            }
        }
    }

    /** Android's own file picker; the file is read and checked before anything else happens. */
    val open = rememberLauncherForActivityResult(ActivityResultContracts.OpenDocument()) { uri: Uri? ->
        if (uri != null) scope.launch {
            val p = center.check(uri)
            val reason = p?.check?.problem
            when {
                p == null -> { problem = BackupProblem.NOT_A_BACKUP; step = PROBLEM }
                reason != null -> { problem = reason; step = PROBLEM }
                else -> restoreFile(p)
            }
        }
    }
    fun pickFile() = open.launch(arrayOf("application/zip", "application/octet-stream", "*/*"))

    /** Google Drive needs the internet before Android's account chooser is worth opening (8.4). */
    fun chooseDrive() {
        if (!online(context)) { fromDrive = true; step = NO_INTERNET_DRIVE; return }
        scope.launch { if (center.link.connect(context)) restoreFromDrive() }
    }

    fun tryAgain() {
        when {
            step == NO_INTERNET_DRIVE -> chooseDrive()
            fromDrive -> restoreFromDrive()
            else -> pending.value?.let { restoreFile(it) } ?: pickFile()
        }
    }

    // ---------------------------------------------------------------- The screens

    when (step) {
        // 39:1755, 39:3949 · Restoring your habits. Cancel leaves it; nothing is ever half-written.
        RESTORING -> WaitScreen(
            "Restoring your habits",
            if (fromDrive) "From " + (email?.plus("’s") ?: "your") + " Google Drive" else "From your backup file",
            "restoring",
        )

        // 39:4741 · No internet, before Google Drive is even asked.
        NO_INTERNET_DRIVE -> Centred(
            Icons.Outlined.WifiOff, "No internet", "Connect to the internet to restore from Google Drive.",
            "no-internet-drive", onTryAgain = { tryAgain() }, onCancel = { step = WHERE },
        )

        // 43:2999 · The same, while this phone's Plus is checked with Google Play.
        NO_INTERNET_PLUS -> Centred(
            Icons.Outlined.WifiOff, "No internet", "Connect to the internet to check your Plus.",
            "no-internet-plus", onTryAgain = { tryAgain() }, onCancel = { step = WHERE },
        )

        // 39:6065 · That Google account holds no backup. A file is still a way back.
        NO_BACKUP -> FlowScreen(onBack = { step = WHERE }, tag = "no-backup", top = true, bottom = {
            MainButton("Try another Google account", "no-backup-another") {
                scope.launch { center.disconnectDrive(); chooseDrive() }
            }
        }) {
            StepHeading(
                "No backup found.",
                "There’s no Often Enough backup in " + (email?.plus("’s") ?: "that") + " Google Drive.",
            )
            SegmentedList { FileChoice(0, 1) { pickFile() } }
        }

        // 39:6596, 39:7095 · Not one of our files, or made by a newer Often Enough. Nothing has changed.
        PROBLEM -> FileProblem(problem, onChoose = { pickFile() }, onBack = { step = WHERE })

        // 43:1776, 43:2689 · Plus isn't on this phone. The ways on are Google Play itself, or us.
        NEEDS_PLUS -> {
            val fromIphone = madeOn == "ios"
            FlowScreen(onBack = { step = WHERE }, tag = "needs-plus", top = true, bottom = {
                if (fromIphone) {
                    MainButton("Contact us", "needs-plus-contact") { writeToUs(context, true, madeOn, madeWithPlus) }
                } else {
                    MainButton("Check again", "needs-plus-check") { tryAgain() }
                    QuietButton("Contact us", "needs-plus-contact") { writeToUs(context, false, madeOn, madeWithPlus) }
                }
            }) {
                StepHeading(
                    "Plus isn’t on this phone.",
                    if (fromIphone)
                        "This backup was made on an iPhone with Plus. Plus can’t move from iPhone to Android on its own, so contact us and we’ll move it for you."
                    else
                        "This backup was made with Plus. Open the Play Store, switch to the Google account you bought Plus with, then come back and tap Check again.",
                )
            }
        }

        // 39:1590 · Where is it? Google Drive, or a file you saved.
        else -> FlowScreen(onBack = onBack, tag = "restore-where", top = true) {
            StepHeading("Restore from a backup.", "Choose where your backup is.")
            SegmentedList {
                Segment(0, 2, Modifier.semantics { testTag = "restore-drive" }, onClick = { chooseDrive() }) {
                    Box(Modifier.size(40.dp).clip(CircleShape).background(appColors.tonal), contentAlignment = Alignment.Center) {
                        Image(painterResource(R.drawable.ic_drive_logo), null, Modifier.size(22.dp))
                    }
                    Spacer(Modifier.width(16.dp))
                    ChoiceWords("Google Drive", "Backed up automatically")
                }
                FileChoice(1, 2) { pickFile() }
            }
        }
    }
}

// ==================================================================== Parts

private const val WHERE = "where"
private const val RESTORING = "restoring"
private const val NO_INTERNET_DRIVE = "no-internet-drive"
private const val NO_INTERNET_PLUS = "no-internet-plus"
private const val NO_BACKUP = "no-backup"
private const val PROBLEM = "problem"
private const val NEEDS_PLUS = "needs-plus"

/** "A backup file · A file you saved" — the same row wherever a file is a way back (39:1590, 39:6065). */
@Composable
private fun FileChoice(index: Int, count: Int, onClick: () -> Unit) {
    Segment(index, count, Modifier.semantics { testTag = "restore-file" }, onClick = onClick) {
        Box(Modifier.size(40.dp).clip(CircleShape).background(appColors.tonal), contentAlignment = Alignment.Center) {
            Icon(Icons.Outlined.Description, null, Modifier.size(22.dp), tint = appColors.ink)
        }
        Spacer(Modifier.width(16.dp))
        ChoiceWords("A backup file", "A file you saved")
    }
}

@Composable
private fun RowScope.ChoiceWords(title: String, line: String) {
    Column(Modifier.weight(1f)) {
        Text(title, style = AppType.titleMedium, color = appColors.ink)
        Text(line, style = AppType.bodyMedium, color = appColors.secondary)
    }
    Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = appColors.secondary)
}

/**
 * A whole-screen message: its icon in a 64 tonal circle, the words in the middle, its two buttons at the bottom
 * (`39:4741`, `43:2999`). Nothing has changed when one of these shows, so Cancel is a real way out.
 */
@Composable
private fun Centred(icon: ImageVector, title: String, line: String, tag: String, onTryAgain: () -> Unit, onCancel: () -> Unit) {
    val c = appColors
    BackHandler(onBack = onCancel)
    Column(Modifier.fillMaxSize().background(c.screen).statusBarsPadding().navigationBarsPadding().semantics { testTag = tag }) {
        Column(
            Modifier.weight(1f).fillMaxWidth().padding(horizontal = 40.dp),
            horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.Center,
        ) {
            Box(Modifier.size(64.dp).clip(CircleShape).background(c.tonal), contentAlignment = Alignment.Center) {
                Icon(icon, null, Modifier.size(28.dp), tint = c.ink)
            }
            Spacer(Modifier.height(24.dp))
            Text(title, style = AppType.titleLargeEmphasized, color = c.ink, textAlign = TextAlign.Center)
            Spacer(Modifier.height(8.dp))
            Text(line, style = AppType.bodyMedium, color = c.secondary, textAlign = TextAlign.Center)
        }
        Column(
            Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 12.dp),
            verticalArrangement = Arrangement.spacedBy(8.dp), horizontalAlignment = Alignment.CenterHorizontally,
        ) {
            MainButton("Try again", tag + "-again", onClick = onTryAgain)
            QuietButton("Cancel", tag + "-cancel", onClick = onCancel)
        }
    }
}

/** Is there a network at all? Asked before Google Drive, so the account chooser never opens for nothing (8.4). */
internal fun online(context: Context): Boolean {
    val manager = context.getSystemService(ConnectivityManager::class.java) ?: return true
    val capabilities = manager.getNetworkCapabilities(manager.activeNetwork) ?: return false
    return capabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
}

/**
 * Contact us from the Plus screens (`43:2413`, `43:2723`): the person's own email app, filled in, so they only add
 * their order number. We answer with a Google Play promo code — the only way Plus is ever given (D16).
 */
private fun writeToUs(context: Context, fromIphone: Boolean, madeOn: String, madeWithPlus: Boolean) {
    val made = "Backup made on " + (if (madeOn == "ios") "iPhone" else "Android") +
        ", " + (if (madeWithPlus) "with Plus" else "without Plus")
    val footer = "\n\n—\nOften Enough " + Support.appVersion + " (free) · Android " + Build.VERSION.RELEASE +
        " · " + Build.MODEL + "\n" + made
    val subject = if (fromIphone) "Move my Plus from iPhone to Android" else "My Plus didn’t come back"
    val body = if (fromIphone)
        "Hi,\n\nI bought Plus on my iPhone and I’m now on Android. Please move my Plus.\n\nMy Apple receipt (order ID): " + footer
    else
        "Hi,\n\nI bought Plus on Google Play, but it didn’t come back on this phone.\n\nMy Google Play order number: " + footer
    val mail = Intent(Intent.ACTION_SENDTO, Uri.parse("mailto:")).apply {
        putExtra(Intent.EXTRA_EMAIL, arrayOf(Support.EMAIL))
        putExtra(Intent.EXTRA_SUBJECT, subject)
        putExtra(Intent.EXTRA_TEXT, body)
    }
    runCatching { context.startActivity(mail) }
}
