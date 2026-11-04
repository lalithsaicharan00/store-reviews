package com.oftenenough.app.ui.today

import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.CardNotice
import com.oftenenough.app.ui.settings.canDismiss
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.provider.Settings
import androidx.compose.runtime.Composable
import androidx.compose.runtime.derivedStateOf
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
 * first time of day; [dismiss] ("Not now") hides it for 7 days, a missed reminder's ("Dismiss") ends that one. A
 * notice with no [dismiss] stays until Android says what it asks for is done (reminders, alarms, battery: A109).
 */
class TodayNotice(
    val key: String, val icon: ImageVector, val title: String, val body: String,
    val dismiss: String?, val action: String,
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
    /** Keep Often Enough awake (A109). */
    fun battery()
}

object TodayNotices {
    /** A test launch keeps its own (D8): its Not now never hides a notice from the person. */
    private val PREFS: String get() = if (AppGraph.isTest) "uitest-today-notices" else "today-notices"
    private const val HIDDEN_MS = 7 * 24 * 3_600_000L

    /** Test launches: the notice to show whatever the phone's state ("full", "off", "removed", "missed", "late", "notifications", "alarms", "battery", "pending"). */
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
    fun current(context: Context, store: HabitStore, nav: NoticeNav, now: Long, say: (String) -> Unit = {}, turnOn: () -> Unit = {}): TodayNotice? {
        if (!AppGraph.isOpen) return null
        val all = candidates(context, store, nav, now, say, turnOn)
        // "late" is the missed reminder's late form (Today flow 39).
        forced?.let { f -> return all.firstOrNull { it.key == (if (f == "late") "missed" else f) } }
        return all.firstOrNull { !hidden(context, it.key, now) }
    }

    /** [say] shows a snackbar on Today (a notice fixed from its own button says so); [turnOn] asks for notifications. */
    private fun candidates(context: Context, store: HabitStore, nav: NoticeNav, now: Long, say: (String) -> Unit, turnOn: () -> Unit): List<TodayNotice> {
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
            "Often Enough can no longer reach your Google Drive. Your habits are safe on this phone.", "Not now", "Reconnect") {
            // Google's account chooser rises over Today (Figma's Today, flow 36: the person may pick another account),
            // then Google's Drive permission only if it was removed. Reconnected: the notice goes, and the snackbar
            // names the account the habits now back up to.
            AppGraph.scope.launch {
                if (runCatching { AppGraph.backup.connectDrive(pick = true) }.getOrDefault(false)) {
                    if (forced == "off") TodayNotices.forced = null
                    AppGraph.backup.link.email?.let { say("Google Drive connected · $it") }
                }
            }
        }
        if (state == DriveState.FULL || forced == "full") list += TodayNotice("full", Symbols.CloudOff, "Backup is paused",
            "Your Google Drive is full. Your habits are safe on this phone, but new changes aren’t backed up.", "Not now", "Manage storage") {
            open(context, Intent(Intent.ACTION_VIEW, Uri.parse("https://one.google.com/storage")))
        }
        val wantsReminders = store.habits.any { !it.archived && it.remind && it.reminders.isNotEmpty() }
        if ((wantsReminders && !Reminders.canPost(context)) || forced == "notifications") list += TodayNotice("notifications", Symbols.NotificationsOff,
            // Android's own question, or its notification settings once it won't ask again (Today flows 41, 42).
            // A109: no Not now: while a reminder needs them, the card stays until notifications are on.
            "Reminders can’t come", "Notifications for Often Enough are off in your phone’s settings, so your reminders can’t come.", null, "Turn on") { turnOn() }
        // A106: an alarm can't ring without Alarms & reminders, however it came to be set (turned off later, a restore).
        val wantsAlarms = store.habits.any { !it.archived && it.remind && it.reminders.isNotEmpty() && it.alert == "alarm" }
        if ((wantsAlarms && Reminders.canPost(context) && !Reminders.canBeExact(context)) || forced == "alarms") list += TodayNotice("alarms", Symbols.Alarm,
            // A109: no Not now: while an alarm needs it, the card stays until it's allowed.
            "Alarms can’t ring", "Alarms & reminders is off for Often Enough in your phone’s settings, so alarms can’t ring at their time.", null, "Turn on") {
            if (forced == "alarms") TodayNotices.forced = null
            open(context, Intent(Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM, Uri.parse("package:" + context.packageName)))
        }
        // A109 (the user, 3 Nov 2026): once battery matters (a reminder, a widget on the home screen, or a Google Drive
        // backup) and it isn't Unrestricted, the phone may put the app to sleep, on any phone. So this card has no Not
        // now: it stays until Android says battery is Unrestricted. Show me how opens Keep Often Enough awake.
        val needsAwake = wantsReminders || Reminders.hasWidgets(context) || AppGraph.backup.link.email != null
        if ((needsAwake && Reminders.notUnrestricted(context)) || forced == "battery") list += TodayNotice(
            "battery", Symbols.BatteryFull, "Let Often Enough run in the background",
            "Your phone can put Often Enough to sleep to save battery. Then reminders come late or not at all, widgets stop " +
                "updating and backups wait. Set battery to Unrestricted to keep it awake.",
            null, "Show me how") {
            if (forced == "battery") TodayNotices.forced = null
            nav.battery()
        }
        val missed = Reminders.missed(context, now)
        // The user, 3 Nov 2026: the button goes straight to what's left to fix, named for where it goes (Show me how only
        // for battery, Open settings for a settings page), and the notice stays until Android says it's done; only a
        // step no app can read has Dismiss, and opening its page counts. Nothing left: the notice goes, and the
        // reminder it was about with it (notices end when the problem is fixed elsewhere).
        val showMissed = missed != null || forced == "missed" || forced == "late"
        val missedId = missed?.let { "${it.at}|${it.habitId}" } ?: "forced"
        val fix = if (showMissed) com.oftenenough.app.ui.settings.missedFix(context, opened(context, missedId)) else null
        if (showMissed && fix == null) {
            if (missed != null) Reminders.dismissMissed(context)
            if (forced == "missed" || forced == "late") TodayNotices.forced = null
            clearOpened(context)
        }
        if (fix != null) {
            // Figma's words: whose reminder, and why, by this phone's maker (A40); a late one says how late, and one
            // held back by Alarms & reminders says what to allow.
            val name = missed?.let { store.habit(it.habitId)?.name }
            val time = missed?.let { DayWords.clockMinute(it.minute) } ?: "8:00 AM"
            val whose = name?.let { (if (it.endsWith("s")) "$it'" else "$it's") + " $time reminder" } ?: "Your $time reminder"
            val late = missed?.lateMinutes ?: if (forced == "late") 40L else null
            val title = if (late != null) "$whose came $late ${if (late == 1L) "minute" else "minutes"} late" else "$whose didn't arrive"
            val why = if (fix is com.oftenenough.app.ui.settings.MissedFix.Exact)
                "Android sends reminders at the exact time only when Alarms & reminders is allowed for Often Enough."
                else makerReason(android.os.Build.MANUFACTURER ?: "")
            val (action, act) = when (fix) {
                is com.oftenenough.app.ui.settings.MissedFix.Notifications -> "Turn on" to turnOn
                is com.oftenenough.app.ui.settings.MissedFix.Exact -> "Open settings" to {
                    open(context, Intent(Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM, Uri.parse("package:" + context.packageName)))
                }
                is com.oftenenough.app.ui.settings.MissedFix.Battery -> "Show me how" to { nav.battery() }
                // A page the app can't read back: opened from here, it counts as done for this reminder.
                is com.oftenenough.app.ui.settings.MissedFix.Step -> "Open settings" to {
                    markOpened(context, missedId, fix.step.key)
                    open(context, fix.step.intent(context))
                }
            }
            // A late one has the clock (Figma's Today, flow 39); one that didn't come, the paused bell (flow 38).
            list += TodayNotice("missed", if (late != null) Symbols.Schedule else Symbols.NotificationsPaused, title, why,
                // Dismiss only where the app can't read what's left (Xiaomi's Autostart); otherwise it stays until Android says it's done.
                if (fix.canDismiss) "Dismiss" else null, action, act = act)
        }
        if (AppGraph.plus.pending != null || forced == "pending") list += TodayNotice("pending", Symbols.HourglassTop,
            "Plus is waiting for your payment", "Google Play hasn’t finished it yet. Plus turns on by itself when it does.", "Not now", "Open Google Play") {
            open(context, Intent(Intent.ACTION_VIEW, Uri.parse("https://play.google.com/store/account/orderhistory")))
        }
        return list
    }

    /** "Not now": hidden for 7 days; a missed reminder's Dismiss ends that one (the next one shows again). */
    fun dismiss(context: Context, notice: TodayNotice, now: Long) {
        if (notice.key == "missed") {
            Reminders.dismissMissed(context)
            clearOpened(context)
        } else hide(context, notice.key, now)
        if (forced == notice.key || forced == "late" && notice.key == "missed") forced = null
    }

    /** The maker's pages opened from a missed reminder's notice, for that reminder only: the next one asks again. */
    private fun opened(context: Context, missedId: String): Set<String> {
        val raw = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE).getString(OPENED, null) ?: return emptySet()
        return if (raw.substringBefore('#') == missedId) raw.substringAfter('#').split(',').filter { it.isNotEmpty() }.toSet() else emptySet()
    }

    private fun markOpened(context: Context, missedId: String, key: String) {
        val keys = opened(context, missedId) + key
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE).edit().putString(OPENED, missedId + "#" + keys.joinToString(",")).apply()
    }

    private fun clearOpened(context: Context) =
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE).edit().remove(OPENED).apply()

    private const val OPENED = "missedOpened"

    // A phone without that page opens App info (U40).
    private fun open(context: Context, intent: Intent) = com.oftenenough.app.ui.settings.openSettingsPage(context, intent)
}

/** Today's notice, worked out again whenever the app comes back (a setting may have changed) and when backup's state does. */
@Composable
fun rememberTodayNotice(store: HabitStore, nav: NoticeNav, say: (String) -> Unit): Pair<TodayNotice?, () -> Unit> {
    val context = LocalContext.current
    var refresh by remember { mutableIntStateOf(0) }
    // Turned on: the notice goes and Today says so (Figma's Today, flows 41 and 42: "Reminders are on").
    val turnOn = com.oftenenough.app.ui.settings.rememberTurnOnNotifications { on ->
        if (on) {
            if (TodayNotices.forced == "notifications") TodayNotices.forced = null
            say("Reminders are on")
        }
        refresh++
    }
    LifecycleEventEffect(Lifecycle.Event.ON_RESUME) { refresh++ }
    val status = if (AppGraph.isOpen) AppGraph.backup.status else null
    val pending = if (AppGraph.isOpen) AppGraph.plus.pending else null
    // Whether any habit wants reminders, read once per change of the habits (S5): the first reminder, or a restore that
    // brings some, shows Reminders can't come at once rather than on the next return to the app (Today flow 41).
    val wantsReminders by remember { derivedStateOf { store.habits.any { !it.archived && it.remind && it.reminders.isNotEmpty() } } }
    val wantsAlarms by remember { derivedStateOf { store.habits.any { !it.archived && it.remind && it.reminders.isNotEmpty() && it.alert == "alarm" } } }
    val notice = remember(refresh, status, pending, store.dataVersion / 50, wantsReminders, wantsAlarms, TodayNotices.forced, TodayNotices.holding) {
        TodayNotices.current(context, store, nav, store.clock(), say, turnOn)
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
        // Material's moving wave until the files are counted, then the line fills as each is saved (Figma's Today, flow 37).
        "working" -> CardNotice(Symbols.CloudUpload, work.working, work.workingBody, working = true, progress = if (of == 0) null else saved / of.toFloat(), tag = tag)
        "done" -> CardNotice(Symbols.CloudDone, work.done, work.doneBody, tag = tag)
        "failed" -> CardNotice(notice.icon, notice.title, work.failed, dismiss = notice.dismiss, onDismiss = { TodayNotices.holding = null; onDismiss() },
            action = work.retry, onAction = start, tag = tag)
        else -> CardNotice(notice.icon, notice.title, notice.body, dismiss = notice.dismiss, onDismiss = onDismiss, action = notice.action, onAction = start, tag = tag)
    }
}

/** Why a reminder can be held back, by the phone's maker (Figma's notices: "Samsung phones put apps to sleep …"). */
internal fun makerReason(manufacturer: String): String {
    val tail = "to save battery, and that can stop reminders."
    return when (manufacturer.lowercase()) {
        "samsung" -> "Samsung phones put apps to sleep $tail"
        "xiaomi", "redmi", "poco" -> "Xiaomi phones stop apps in the background $tail"
        "vivo", "iqoo" -> "vivo phones stop apps in the background $tail"
        "oneplus" -> "OnePlus phones stop apps in the background $tail"
        "oppo" -> "OPPO phones stop apps in the background $tail"
        "realme" -> "realme phones stop apps in the background $tail"
        "huawei", "honor" -> manufacturer.replaceFirstChar { it.uppercase() } + " phones stop apps in the background $tail"
        else -> "Your phone can stop apps in the background $tail"
    }
}
