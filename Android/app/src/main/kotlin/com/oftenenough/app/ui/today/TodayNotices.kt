package com.oftenenough.app.ui.today

import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.WavyProgress
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.provider.Settings
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.compose.LifecycleEventEffect
import app.habits.core.DriveState
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.reminders.Reminders
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
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
 * animation … so it create that worker illusion"). The card turns into [working] with a line that fills as each file
 * is saved, then [done] for a moment, then folds away; if it doesn't finish, [failed] with [retry].
 */
class NoticeWork(
    val working: String, val done: String, val failed: String, val retry: String,
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

    /** Test launches: the notice to show whatever the phone's state ("full", "off", "held", "removed", "missed", "notifications", "pending"). */
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
        if (state == DriveState.HELD || forced == "held") list += TodayNotice("held", Symbols.DeleteSweep, "Deleted on another device",
            "Nothing has changed here yet. Check them before anything is removed from this phone.", "Later", "Review") { nav.backup() }
        // A39: the Drive copy is gone (the person cleared the folder, say). Nothing has gone up since, and nothing
        // does until they choose Back up again, which sends every file. `holding` keeps the card here while it works.
        if (state == DriveState.REMOVED || holding == "removed" || forced == "removed") list += TodayNotice(
            "removed", Symbols.CloudOff, "Your Google Drive backup was removed",
            "Your habits are safe on this phone. Nothing has been backed up since.", "Not now", "Back up again",
            act = { nav.backup() },
            work = NoticeWork(
                working = "Backing up to Google Drive…",
                done = "Everything is in your Google Drive again",
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

    private fun open(context: Context, intent: Intent) {
        runCatching { context.startActivity(intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)) }
    }
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

/**
 * The notice card (Figma 1.9): white, corners 24; a 40 dp disc (#E2E2E7) with the icon; the title (Title Medium) over the
 * words (Body Medium, grey); the two text buttons at the end, the action last.
 */
@Composable
fun NoticeCard(notice: TodayNotice, onDismiss: () -> Unit) {
    val work = notice.work
    if (work != null) WorkingNoticeCard(notice, work, onDismiss) else PlainNoticeCard(notice, notice.title, notice.body, onDismiss)
}

/**
 * A notice whose action happens here (A39): the same card turns into the work, with a turning circle and a line that
 * fills as each file is saved, then says it is done for a moment and folds away. Nothing else on Today moves (U4):
 * the card keeps its place and its shape, only its words and its end change.
 */
@Composable
private fun WorkingNoticeCard(notice: TodayNotice, work: NoticeWork, onDismiss: () -> Unit) {
    val c = appColors
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
    when (state) {
        "working" -> NoticeShape(notice.key) {
            Row(horizontalArrangement = Arrangement.spacedBy(16.dp), verticalAlignment = Alignment.CenterVertically) {
                Box(Modifier.size(40.dp).clip(CircleShape).background(c.behind), contentAlignment = Alignment.Center) {
                    CircularProgressIndicator(Modifier.size(20.dp), color = c.ink, strokeWidth = 2.dp)
                }
                Column(Modifier.weight(1f), verticalArrangement = Arrangement.spacedBy(8.dp)) {
                    Text(work.working, style = AppType.titleMedium, color = c.ink)
                    WavyProgress(if (of == 0) 0f else saved / of.toFloat())
                }
            }
            Spacer(Modifier.height(8.dp))
        }
        "done" -> NoticeShape(notice.key) {
            Row(horizontalArrangement = Arrangement.spacedBy(16.dp), verticalAlignment = Alignment.CenterVertically) {
                Box(Modifier.size(40.dp).clip(CircleShape).background(c.ink), contentAlignment = Alignment.Center) {
                    Icon(Symbols.CloudDone, null, tint = c.onInk)
                }
                Text(work.done, Modifier.weight(1f).padding(vertical = 10.dp), style = AppType.titleMedium, color = c.ink)
            }
            Spacer(Modifier.height(8.dp))
        }
        "failed" -> PlainNoticeCard(notice, notice.title, work.failed, { TodayNotices.holding = null; onDismiss() }, work.retry, start)
        else -> PlainNoticeCard(notice, notice.title, notice.body, onDismiss, notice.action, start)
    }
}

/** The card's shape: the surface, corners 24, the row then whatever ends it. */
@Composable
private fun NoticeShape(key: String, content: @Composable ColumnScope.() -> Unit) {
    val c = appColors
    Column(
        Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.surface)
            .padding(start = 16.dp, end = 12.dp, top = 16.dp, bottom = 8.dp).semantics { testTag = "notice-$key" },
        verticalArrangement = Arrangement.spacedBy(4.dp),
        content = content,
    )
}

@Composable
private fun PlainNoticeCard(
    notice: TodayNotice, title: String, body: String, onDismiss: () -> Unit,
    action: String = notice.action, act: () -> Unit = notice.act,
) {
    val c = appColors
    Column(
        Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.surface)
            .padding(start = 16.dp, end = 12.dp, top = 16.dp, bottom = 8.dp).semantics { testTag = "notice-${notice.key}" },
        verticalArrangement = Arrangement.spacedBy(4.dp),
    ) {
        Row(horizontalArrangement = Arrangement.spacedBy(16.dp)) {
            Box(Modifier.size(40.dp).clip(CircleShape).background(c.behind), contentAlignment = Alignment.Center) {
                Icon(notice.icon, null, tint = c.ink)
            }
            Column(Modifier.weight(1f), verticalArrangement = Arrangement.spacedBy(2.dp)) {
                Text(title, style = AppType.titleMedium, color = c.ink)
                Text(body, style = AppType.bodyMedium, color = c.secondary)
            }
        }
        Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(8.dp, Alignment.End)) {
            AppButton(notice.dismiss, onDismiss, Modifier.semantics { testTag = "notice-dismiss" }, style = ButtonStyle.Text)
            AppButton(action, act, Modifier.semantics { testTag = "notice-action" }, style = ButtonStyle.Text)
        }
    }
}
