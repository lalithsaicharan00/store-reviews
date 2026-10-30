package com.oftenenough.app.ui.today

import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.CardNotice
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.provider.Settings
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.LocalContext
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.compose.LifecycleEventEffect
import app.habits.core.DriveState
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.reminders.Reminders
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.HabitStore
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

/**
 * One notice on Today (Figma 1.9–1.9.7): something the person should know about their data, their reminders or their
 * purchase, in plain words, with what to do about it. One at a time, the most important first; only on today, above the
 * first time of day; [dismiss] ("Not now", "Later", "Dismiss") hides it for 7 days (a missed reminder, until the next).
 */
class TodayNotice(
    val key: String, val icon: ImageVector, val title: String, val body: String,
    val dismiss: String, val action: String,
    /** Work the card does itself (A39), instead of opening a page. */
    val work: NoticeWork? = null,
    val act: () -> Unit,
)

/**
 * Work a notice does in the card (A39, the user's words: "the pop-up should turn into something like a small
 * animation … so it create that worker illusion"). The card turns into [working] over [workingBody] with a line that
 * fills as each file is saved, then [done] over [doneBody] for a moment, then folds away; if it doesn't finish,
 * [failed] with [retry].
 */
class NoticeWork(
    val working: String, val workingBody: String, val done: String, val doneBody: String, val failed: String, val retry: String,
    /** Does it, telling the card how many files of how many are saved. False when it didn't finish. */
    val run: suspend ((Int, Int) -> Unit) -> Boolean,
)

/** Where a notice's action goes on Today's side (the pages are Today's to open). */
interface NoticeNav {
    fun backup()
    fun reminders()
}

object TodayNotices {
    /** A test launch keeps its own (D8): its Not now never hides a notice from the person. */
    private val PREFS: String get() = if (AppGraph.isTest) "uitest-today-notices" else "today-notices"
    private const val HIDDEN_MS = 7 * 24 * 3_600_000L

    /** Test launches: the notice to show whatever the phone's state ("full", "off", "removed", "missed", "notifications", "pending"). */
    var forced: String? = null

    /** A notice doing its own work stays on Today until its card folds away, even once the state it reported is gone. */
    var holding by mutableStateOf<String?>(null)

    fun hide(context: Context, key: String, now: Long) {
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE).edit().putLong(key, now + HIDDEN_MS).apply()
    }

    private fun hidden(context: Context, key: String, now: Long): Boolean =
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE).getLong(key, 0L) > now

    /**
     * The notice to show now, the most important first: anything that could cost data (deletes held from another device,
     * backup off, backup paused), then reminders that can't come or didn't, then a payment Google Play hasn't finished.
     */
    fun current(context: Context, store: HabitStore, nav: NoticeNav, now: Long): TodayNotice? {
        if (!AppGraph.isOpen) return null
        val all = candidates(context, store, nav, now)
        forced?.let { f -> return all.firstOrNull { it.key == f } }
        return all.firstOrNull { !hidden(context, it.key, now) }
    }

    private fun candidates(context: Context, store: HabitStore, nav: NoticeNav, now: Long): List<TodayNotice> {
        val list = ArrayList<TodayNotice>()
        val forced = forced
        val status = AppGraph.backup.status
        val state = status?.state
        // A39: the Drive copy is gone (the person cleared the folder, say). Nothing has gone up since, and nothing
        // does until they choose Back up again, which sends every file. `holding` keeps the card here while it works.
        if (state == DriveState.REMOVED || holding == "removed" || forced == "removed") list += TodayNotice(
            "removed", Symbols.CloudAlert, "Your Google Drive backup was deleted",
            "Your habits are still safe on this phone. Back them up again to keep a copy in Google Drive.", "Not now", "Back up again",
            act = { nav.backup() },
            work = NoticeWork(
                working = "Backing up to Google Drive…",
                workingBody = "Everything goes again: your habits, notes and every year of logs.",
                done = "Backed up",
                doneBody = "Everything is in your Google Drive again.",
                failed = "Couldn’t back up just now. Your habits are safe on this phone.",
                retry = "Try again",
            ) { progress -> AppGraph.backup.backUpEverythingAgain(progress) },
        )
        if (state == DriveState.NOT_CONNECTED || forced == "off") list += TodayNotice("off", Symbols.LinkOff, "Backup is off",
            "The app can no longer reach your Google Drive. Your habits are safe on this phone.", "Not now", "Reconnect") {
            AppGraph.scope.launch { runCatching { AppGraph.backup.connectDrive() } }
        }
        if (state == DriveState.FULL || forced == "full") list += TodayNotice("full", Symbols.CloudOff, "Backup is paused",
            "Your Google Drive is full. Your habits are safe on this phone, but new changes aren’t backed up.", "Not now", "Manage storage") {
            open(context, Intent(Intent.ACTION_VIEW, Uri.parse("https://one.google.com/storage")))
        }
        val wantsReminders = store.habits.any { !it.archived && it.remind && it.reminders.isNotEmpty() }
        if ((wantsReminders && !Reminders.canPost(context)) || forced == "notifications") list += TodayNotice("notifications", Symbols.NotificationsOff,
            "Reminders can’t come", "Notifications for the app are off in your phone’s settings.", "Not now", "Turn on") {
            open(context, Intent(Settings.ACTION_APP_NOTIFICATION_SETTINGS).putExtra(Settings.EXTRA_APP_PACKAGE, context.packageName))
        }
        val missed = Reminders.missed(context, now)
        if (missed != null || forced == "missed") {
            val name = missed?.let { store.habit(it.habitId)?.name }
            val time = missed?.let { DayWords.clockMinute(it.minute) } ?: "8:00 AM"
            list += TodayNotice("missed", Symbols.NotificationsPaused, "A reminder didn’t arrive",
                "Your $time reminder" + (name?.let { " for $it" } ?: "") + " didn’t show. Your phone may be stopping the app in the background.",
                "Dismiss", "Show me how") { nav.reminders() }
        }
        if (AppGraph.plus.pending != null || forced == "pending") list += TodayNotice("pending", Symbols.HourglassTop,
            "Plus is waiting for your payment", "Google Play hasn’t finished it yet. Plus turns on by itself when it does.", "Not now", "Open Google Play") {
            open(context, Intent(Intent.ACTION_VIEW, Uri.parse("https://play.google.com/store/account/orderhistory")))
        }
        return list
    }

    /** "Not now": hidden for 7 days; a missed reminder's Dismiss ends that one (the next one shows again). */
    fun dismiss(context: Context, notice: TodayNotice, now: Long) {
        if (notice.key == "missed") Reminders.dismissMissed(context) else hide(context, notice.key, now)
        if (forced == notice.key) forced = null
    }

    // A phone without that page opens App info (U40).
    private fun open(context: Context, intent: Intent) = com.oftenenough.app.ui.settings.openSettingsPage(context, intent)
}

/** Today's notice, worked out again whenever the app comes back (a setting may have changed) and when backup's state does. */
@Composable
fun rememberTodayNotice(store: HabitStore, nav: NoticeNav): Pair<TodayNotice?, () -> Unit> {
    val context = LocalContext.current
    var refresh by remember { mutableIntStateOf(0) }
    LifecycleEventEffect(Lifecycle.Event.ON_RESUME) { refresh++ }
    val status = if (AppGraph.isOpen) AppGraph.backup.status else null
    val pending = if (AppGraph.isOpen) AppGraph.plus.pending else null
    val notice = remember(refresh, status, pending, store.dataVersion / 50, TodayNotices.forced, TodayNotices.holding) {
        TodayNotices.current(context, store, nav, store.clock())
    }
    return notice to { notice?.let { TodayNotices.dismiss(context, it, store.clock()) }; refresh++ }
}

/** The notice card (molecule 4.7, [CardNotice]): its words, then Not now and what to do about it. */
@Composable
fun NoticeCard(notice: TodayNotice, onDismiss: () -> Unit) {
    val work = notice.work
    if (work != null) WorkingNoticeCard(notice, work, onDismiss)
    else CardNotice(notice.icon, notice.title, notice.body, dismiss = notice.dismiss, onDismiss = onDismiss,
        action = notice.action, onAction = notice.act, tag = "notice-${notice.key}")
}

/**
 * A notice whose action happens here (A39): the same card turns into the work (Card notice's Progress: "Backing up to
 * Google Drive…" and a line that fills as each file is saved), then Done for a moment, then folds away. Nothing else
 * on Today moves (U4): the card keeps its place, only its words and its end change.
 */
@Composable
private fun WorkingNoticeCard(notice: TodayNotice, work: NoticeWork, onDismiss: () -> Unit) {
    val scope = rememberCoroutineScope()
    var state by remember { mutableStateOf("ask") }
    var saved by remember { mutableIntStateOf(0) }
    var of by remember { mutableIntStateOf(0) }
    val start: () -> Unit = {
        state = "working"
        saved = 0
        of = 0
        TodayNotices.holding = notice.key
        scope.launch {
            val ok = work.run { s, n -> saved = s; of = n }
            state = if (ok) "done" else "failed"
        }
    }
    // Done: the person sees it, then the card folds away by itself.
    LaunchedEffect(state) {
        if (state == "done") {
            delay(1_600)
            TodayNotices.holding = null
            onDismiss()
        }
    }
    val tag = "notice-${notice.key}"
    when (state) {
        "working" -> CardNotice(Symbols.CloudUpload, work.working, work.workingBody, working = true, progress = if (of == 0) 0f else saved / of.toFloat(), tag = tag)
        "done" -> CardNotice(Symbols.CloudDone, work.done, work.doneBody, tag = tag)
        "failed" -> CardNotice(notice.icon, notice.title, work.failed, dismiss = notice.dismiss, onDismiss = { TodayNotices.holding = null; onDismiss() },
            action = work.retry, onAction = start, tag = tag)
        else -> CardNotice(notice.icon, notice.title, notice.body, dismiss = notice.dismiss, onDismiss = onDismiss, action = notice.action, onAction = start, tag = tag)
    }
}
