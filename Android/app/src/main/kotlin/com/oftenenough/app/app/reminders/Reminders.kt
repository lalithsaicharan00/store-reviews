package com.oftenenough.app.app.reminders

import android.Manifest
import android.app.AlarmManager
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.content.ContextCompat
import com.oftenenough.app.R
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.EntrySource
import com.oftenenough.app.data.ReminderPlan
import com.oftenenough.app.data.Format
import com.oftenenough.app.data.HabitCopy
import com.oftenenough.app.ui.theme.AppColors
import androidx.compose.ui.graphics.toArgb
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

/**
 * Reminders that arrive (what Android people ask for most): one exact alarm for the next reminder time, re-planned
 * after every change (300 ms after the last, S16) and after each alarm; at the alarm, every reminder due then is posted,
 * same-minute ones together. A reminder's Done or +1 saves from the notification shade, on a locked phone too, without
 * opening the app (D13). Without the exact-alarm permission Android may deliver a few minutes late, and Reminders says so.
 */
object Reminders {
    const val CHANNEL = "reminders"
    /** Alarm style (A11 D3): rings on the phone's alarm sound, again and again until answered; never a full screen. */
    const val ALARM_CHANNEL = "alarms"
    private const val ACTION_ALARM = "com.oftenenough.app.REMINDER_ALARM"
    const val ACTION_DONE = "com.oftenenough.app.REMINDER_DONE"
    const val ACTION_ADD = "com.oftenenough.app.REMINDER_ADD"
    /** An amount or minutes typed in the notification (direct reply), saved with ➤. */
    const val ACTION_LOG = "com.oftenenough.app.REMINDER_LOG"
    /** A time habit's Start: the timer runs and its Live Update takes the reminder's place. */
    const val ACTION_START = "com.oftenenough.app.REMINDER_START"
    /** A checklist's next step, by its ID. */
    const val ACTION_TICK = "com.oftenenough.app.REMINDER_TICK"
    /** Takes back exactly the log the notification made, by its ID. */
    const val ACTION_UNDO = "com.oftenenough.app.REMINDER_UNDO"
    private const val EXTRA_STEP = "step"
    private const val EXTRA_ENTRY = "entry"
    private const val EXTRA_SECTION = "section"
    private const val EXTRA_ALARM = "alarm"
    private const val EXTRA_FOLLOW_UP = "followUp"
    private const val EXTRA_PLACE = "place"
    /** The direct reply's text. */
    private const val REPLY = "reply"
    /** How long an updated reminder stays once its goal is met (Figma: "it goes away after a few seconds"). */
    private const val GOES_AFTER_MS = 4_000L
    private const val EXTRA_HABIT = "habit"
    private const val EXTRA_DAY = "day"
    private const val EXTRA_SLOT = "slot"
    private const val EXTRA_NOTIFICATION = "notification"
    private const val PREFS = "reminders"
    private const val LAST = "lastFired"
    /** The alarm last set: when it should fire, and the habit and time it was for ("ms|habitId|minute"). */
    private const val PLANNED = "planned"
    /** A reminder that arrived more than [LATE_MS] late, or never: "ms|habitId|minute" (Reminders shows it until dismissed). */
    private const val MISSED = "missed"
    private const val DISMISSED = "missedDismissed"
    const val LATE_MS = 10 * 60_000L

    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.Main.immediate)
    private var pending: Job? = null

    fun channel(context: Context) {
        val manager = context.getSystemService(NotificationManager::class.java) ?: return
        manager.createNotificationChannel(NotificationChannel(CHANNEL, "Reminders", NotificationManager.IMPORTANCE_HIGH).apply {
            description = "Your habits' reminders, at the times you chose."
        })
        manager.createNotificationChannel(NotificationChannel(ALARM_CHANNEL, "Alarms", NotificationManager.IMPORTANCE_HIGH).apply {
            description = "Reminders you set to ring as an alarm."
            setSound(android.media.RingtoneManager.getDefaultUri(android.media.RingtoneManager.TYPE_ALARM),
                android.media.AudioAttributes.Builder().setUsage(android.media.AudioAttributes.USAGE_ALARM)
                    .setContentType(android.media.AudioAttributes.CONTENT_TYPE_SONIFICATION).build())
            enableVibration(true)
        })
    }

    fun canPost(context: Context): Boolean = NotificationManagerCompat.from(context).areNotificationsEnabled() &&
        (Build.VERSION.SDK_INT < 33 || ContextCompat.checkSelfPermission(context, Manifest.permission.POST_NOTIFICATIONS) == PackageManager.PERMISSION_GRANTED)

    fun canBeExact(context: Context): Boolean =
        Build.VERSION.SDK_INT < 31 || context.getSystemService(AlarmManager::class.java)?.canScheduleExactAlarms() == true

    /** Plans again once the changes stop (300 ms, S16). */
    fun replanSoon(context: Context, store: HabitStore) {
        pending?.cancel()
        pending = scope.launch {
            delay(300)
            replan(context.applicationContext, store)
        }
    }

    /** Sets the one alarm for the next reminder time (none when nothing is wanted). */
    fun replan(context: Context, store: HabitStore) {
        if (!store.isLoaded || AppGraph.isTest) return
        // The milestone notifications (quit and cut down, when asked) follow every change too.
        MilestoneAlerts.replan(context, store)
        val next = ReminderPlan.plan(store, store.clock(), days = 3).firstOrNull()
        val alarms = context.getSystemService(AlarmManager::class.java) ?: return
        val intent = PendingIntent.getBroadcast(context, 0, Intent(context, ReminderReceiver::class.java).setAction(ACTION_ALARM),
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        if (next == null) { alarms.cancel(intent); prefs.edit().remove(PLANNED).apply(); return }
        // An alarm planned earlier that never fired (the phone put the app to sleep) is kept before it's replaced.
        noteNeverFired(context, store.clock())
        prefs.edit().putString(PLANNED, "${next.fire}|${next.habit.id}|${next.fire.minuteOfDay()}").apply()
        // An alarm is set as Android's alarm clock (it shows in the status bar and fires through Doze, D3).
        if (canBeExact(context) && next.habit.alert == "alarm") {
            val show = PendingIntent.getActivity(context, 1, Intent(context, MainActivity::class.java), PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
            alarms.setAlarmClock(AlarmManager.AlarmClockInfo(next.fire, show), intent)
        } else if (canBeExact(context)) alarms.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, next.fire, intent)
        else alarms.setAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, next.fire, intent)
    }

    /** The alarm: post every reminder due since the last one (a late alarm still posts, never twice), then plan again. */
    fun fire(context: Context, store: HabitStore) {
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        val now = store.clock()
        val since = maxOf(prefs.getLong(LAST, 0L), now - 15 * 60_000L)
        val yesterday = now - 24 * 3_600_000L
        val due = ReminderPlan.plan(store, yesterday, days = 3).filter { it.fire in (since + 1)..(now + 30_000) }
        prefs.edit().putLong(LAST, now + 30_000).apply()
        due.minByOrNull { it.fire }?.let { first ->
            if (now - first.fire > LATE_MS) prefs.edit().putString(MISSED, "${first.fire}|${first.habit.id}|${first.fire.minuteOfDay()}").apply()
        }
        if (canPost(context)) post(context, store, due)
        replan(context, store)
    }

    private fun post(context: Context, store: HabitStore, due: List<ReminderPlan.Alert>) {
        val hide = AppGraph.hidesNames
        val manager = NotificationManagerCompat.from(context)
        val singles = due.filter { it.followUp > 0 } + due.filter { it.followUp == 0 }.groupBy { it.fire }.values.filter { it.size == 1 }.map { it[0] }
        val groups = due.filter { it.followUp == 0 }.groupBy { it.fire }.values.filter { it.size > 1 }
        for (alert in singles) {
            val id = alert.id.hashCode()
            val alarm = alert.habit.alert == "alarm"
            val words = if (hide) ReminderPlan.words(alert, store, true) else null
            val notification = notice(context, store, Shown(alert.habit.id, alert.day, alert.placement.slot, alert.section.id, id, alarm, alert.followUp,
                alert.placement.section.takeIf { alert.placement.slot != null }),
                undo = null, update = false, hidden = words) ?: continue
            // An alarm keeps ringing until it's answered (a button, a tap or a swipe).
            if (alarm) notification.flags = notification.flags or android.app.Notification.FLAG_INSISTENT
            try { manager.notify(id, notification) } catch (_: SecurityException) {}
        }
        for (bucket in groups) {
            val (title, body) = ReminderPlan.groupWords(bucket, hide)
            val first = bucket[0]
            try { manager.notify(("group." + first.fire).hashCode(), base(context, title, body, null, first.day, first.section.id).build()) } catch (_: SecurityException) {}
        }
    }

    /** Which reminder a notification is: its habit, day and time of day, its ID, and how it rang. */
    private class Shown(
        val habit: String, val day: Int, val slot: String?, val section: String, val id: Int, val alarm: Boolean, val followUp: Int,
        /** For a reminder of one time of day ([slot]), that time of day's section ("Morning · …"). */
        val place: String? = null,
    )

    /** Opens the habit's day (or Today, for a group). */
    private fun openIntent(context: Context, habit: String?, day: Int, section: String): PendingIntent {
        val open = Intent(context, MainActivity::class.java).setFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
            .putExtra(MainActivity.OPEN_HABIT, habit).putExtra(MainActivity.OPEN_DAY, day)
        return PendingIntent.getActivity(context, (habit ?: section).hashCode() + day, open, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
    }

    private fun base(context: Context, title: String, body: String, habit: String?, day: Int, section: String, alarm: Boolean = false): NotificationCompat.Builder {
        val content = openIntent(context, habit, day, section)
        return NotificationCompat.Builder(context, if (alarm) ALARM_CHANNEL else CHANNEL).setSmallIcon(R.drawable.ic_notification).setContentTitle(title)
            .apply { if (body.isNotEmpty()) setContentText(body) }
            .setContentIntent(content).setAutoCancel(true).setGroup(section)
            .setCategory(if (alarm) NotificationCompat.CATEGORY_ALARM else NotificationCompat.CATEGORY_REMINDER)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
    }

    /**
     * 5.11.2, **Reminder notification** (Figma 1268:127, Collapsed · Expanded · Reply, and "Reminder notification · every
     * kind", K.1–K.21), in Android's own template: the app's icon in a circle of the habit's colour (setColor), the
     * habit's name, one line of where it stands, today's progress (setProgress; none for a once-a-day check, a task or a
     * limit, A41), and at most three buttons, each saving in the background as Today's round button would (U14):
     *
     * - A check: **Done** ("Not done yet"); counted several a day ("1 of 3 today"), each Done adds one and **Undo** takes
     *   it back; a week or month goal ("1 of 3 this week") updates and goes after a few seconds.
     * - An amount with a step: **+1 glass** ("3 of 8 glasses") and **Undo +1 glass**; at the goal, "· Goal met", Undo only,
     *   gone after a few seconds. Without a step: **Log**, a field in the notification ("How many steps?", ➤).
     * - Time: **Start** (the timer runs; its Live Update takes the reminder's place) and **Log time** ("How many minutes?").
     * - A checklist: its steps (Android's inbox lines, ✓ or ○), **Tick** and the next step's name, **Open**, and Undo.
     * - A task: **Done** ("Task · for today").
     *
     * A follow-up says "Still to do today". Updates are quiet (setOnlyAlertOnce). [hidden]: the words when names are
     * hidden outside the app (no step names, no units). Null when the habit has gone.
     */
    private fun notice(context: Context, store: HabitStore, shown: Shown, undo: String?, update: Boolean, hidden: Pair<String, String>? = null,
                       goesAfter: Long? = null): android.app.Notification? {
        val habit = store.habit(shown.habit)?.takeIf { !it.archived } ?: return null
        val day = shown.day
        val hide = hidden != null || AppGraph.hidesNames
        val rule = store.rule(habit, day)
        val complete = !rule.atMost && store.rules.isComplete(habit, day)
        val item = com.oftenenough.app.data.widgets.WidgetItems.item(store, habit, day, store.clock(), isToday = day == store.today())
        val dayBased = rule.frequency.isDayBased
        val progress = when (rule.kind) {
            HabitKind.Task -> "Task · for today"
            HabitKind.Check -> when {
                !dayBased -> item.line
                store.rules.countsUp(habit, day) -> "${Format.amount(store.rules.progress(habit, day))} of ${Format.amount(store.rules.goal(habit))} today"
                else -> "Not done yet"
            }
            else -> item.line + if (complete && rule.kind != HabitKind.Checklist) " · Goal met" else ""
        }
        val once = rule.kind == HabitKind.Task || (rule.kind == HabitKind.Check && dayBased && !store.rules.countsUp(habit, day))
        var text = habit.reminderText ?: when {
            shown.followUp > 0 && once -> "Still to do today"
            shown.followUp > 0 -> "Still to do today · $progress"
            else -> progress
        }
        shown.place?.let { text = "${store.section(it).name} · $text" }
        // Names hidden outside the app: the reminder's own words or "Reminder", never the habit's name or its steps.
        val (title, body) = hidden ?: if (hide) ((habit.reminderText ?: "Reminder") to "") else (habit.name to text)
        val builder = base(context, title, body, habit.id, day, shown.section, shown.alarm)
            .setColor(AppColors.light.habit(habit.color).toArgb())
            .setOnlyAlertOnce(update)
        goesAfter?.let { builder.setTimeoutAfter(it) }
        // Progress: how far toward the goal, as Today's row fills (none where Today's row has no fill).
        val fraction = (item.cardFraction ?: item.fraction)?.coerceIn(0.0, 1.0)
        if (!once && !rule.atMost && rule.kind != HabitKind.Checklist && fraction != null) builder.setProgress(100, (fraction * 100).toInt(), false)
        fun button(label: String, action: String, extras: Intent.() -> Unit = {}) =
            builder.addAction(0, label, actionIntent(context, action, shown, extras))
        val undoLabel = if (rule.kind is HabitKind.Amount && habit.quickIncrement != null && !hide)
            "Undo +" + HabitCopy.amount(habit.quickIncrement!!, (rule.kind as HabitKind.Amount).unit) else "Undo"
        when (val k = rule.kind) {
            HabitKind.Check, HabitKind.Task -> if (!complete || !dayBased) button("Done", ACTION_DONE)
            is HabitKind.Amount -> if (!complete) {
                val step = habit.quickIncrement
                if (step != null) button("+" + if (hide) Format.amount(step) else HabitCopy.amount(step, k.unit), ACTION_ADD)
                else builder.addAction(reply(context, "Log", if (hide || k.unit.isEmpty()) "How many?" else "How many ${k.unit}?", shown))
            }
            HabitKind.Duration -> if (!complete) {
                if (!store.timers.containsKey(habit.id)) button("Start", ACTION_START)
                builder.addAction(reply(context, "Log time", "How many minutes?", shown))
            }
            HabitKind.Checklist -> {
                val next = habit.steps.firstOrNull { !store.isStepDone(it, habit, day) }
                if (!hide) builder.setStyle(NotificationCompat.InboxStyle().also { style ->
                    habit.steps.forEach { st -> style.addLine((if (store.isStepDone(st, habit, day)) "✓  " else "○  ") + st.name) }
                }.setSummaryText(text))
                if (next != null) button(if (hide) "Tick next step" else "Tick ${next.name}", ACTION_TICK) { putExtra(EXTRA_STEP, next.id) }
                builder.addAction(0, "Open", openIntent(context, habit.id, day, shown.section))
            }
            HabitKind.Quit -> {}
        }
        if (undo != null) button(undoLabel, ACTION_UNDO) { putExtra(EXTRA_ENTRY, undo) }
        return builder.build()
    }

    /** A button that opens a field in the notification itself (Android's direct reply); ➤ sends what was typed. */
    private fun reply(context: Context, label: String, ask: String, shown: Shown): NotificationCompat.Action {
        val input = androidx.core.app.RemoteInput.Builder(REPLY).setLabel(ask).build()
        // A reply needs a mutable intent (Android fills in the typed text); it's explicit, to our own receiver.
        val intent = PendingIntent.getBroadcast(context, shown.id + ACTION_LOG.hashCode() + label.hashCode(), extras(context, ACTION_LOG, shown),
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_MUTABLE)
        return NotificationCompat.Action.Builder(0, label, intent).addRemoteInput(input).setAllowGeneratedReplies(false).build()
    }

    private fun extras(context: Context, action: String, shown: Shown): Intent =
        Intent(context, ReminderReceiver::class.java).setAction(action).putExtra(EXTRA_HABIT, shown.habit).putExtra(EXTRA_DAY, shown.day)
            .putExtra(EXTRA_SLOT, shown.slot).putExtra(EXTRA_NOTIFICATION, shown.id).putExtra(EXTRA_SECTION, shown.section)
            .putExtra(EXTRA_ALARM, shown.alarm).putExtra(EXTRA_FOLLOW_UP, shown.followUp).putExtra(EXTRA_PLACE, shown.place)

    private fun actionIntent(context: Context, action: String, shown: Shown, more: Intent.() -> Unit): PendingIntent =
        PendingIntent.getBroadcast(context, shown.id + action.hashCode(), extras(context, action, shown).apply(more),
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)

    /**
     * A reminder's button: saved in the store's order, idempotently (Done on a day already done changes nothing; Undo
     * takes back only the log the notification made, by its ID), then the notification is shown again as it now stands
     * (quietly, with Undo) or goes: at once for a once-a-day check, a task, a time of day, a checklist finished or a
     * timer started; after a few seconds once a goal is met or a week or month goal has counted the tap.
     */
    fun act(context: Context, store: HabitStore, intent: Intent) {
        val manager = NotificationManagerCompat.from(context)
        val shown = Shown(intent.getStringExtra(EXTRA_HABIT) ?: return, intent.getIntExtra(EXTRA_DAY, store.today()), intent.getStringExtra(EXTRA_SLOT),
            intent.getStringExtra(EXTRA_SECTION) ?: "", intent.getIntExtra(EXTRA_NOTIFICATION, 0), intent.getBooleanExtra(EXTRA_ALARM, false),
            intent.getIntExtra(EXTRA_FOLLOW_UP, 0), intent.getStringExtra(EXTRA_PLACE))
        val habit = store.habit(shown.habit)
        val day = shown.day
        if (habit == null || habit.archived || day > store.today()) return manager.cancel(shown.id)
        val before = store.entries(habit.id).mapTo(HashSet()) { it.id }
        val slot = shown.slot
        when (intent.action) {
            ACTION_DONE -> when {
                slot != null -> if (!store.isSlotDone(habit, slot, day)) store.toggleSlot(habit, slot, day, EntrySource.REMINDER)
                habit.kind == HabitKind.Task -> if (!store.isTicked(habit, day)) store.toggleCheck(habit, day, EntrySource.REMINDER)
                store.rules.countsUp(habit, day) -> store.addProgress(habit, 1.0, day, source = EntrySource.REMINDER)
                else -> if (!store.isTicked(habit, day)) store.toggleCheck(habit, day, EntrySource.REMINDER)
            }
            ACTION_ADD -> store.increment(habit, day, EntrySource.REMINDER)
            ACTION_LOG -> {
                val typed = androidx.core.app.RemoteInput.getResultsFromIntent(intent)?.getCharSequence(REPLY)?.toString()
                typed?.let(::number)?.let { store.addProgress(habit, it, day, source = EntrySource.REMINDER) }
            }
            ACTION_START -> {
                if (!store.timers.containsKey(habit.id)) store.toggleTimer(habit, slot)
                return manager.cancel(shown.id)
            }
            ACTION_TICK -> habit.steps.firstOrNull { it.id == intent.getStringExtra(EXTRA_STEP) }?.let { step ->
                if (!store.isStepDone(step, habit, day)) store.toggleStep(step, habit, day, source = EntrySource.REMINDER)
            }
            ACTION_UNDO -> intent.getStringExtra(EXTRA_ENTRY)?.let(store::undoEntry)
        }
        val added = store.entries(habit.id).lastOrNull { it.id !in before && it.source == EntrySource.REMINDER }?.id
        val rule = store.rule(habit, day)
        val dayBased = rule.frequency.isDayBased
        val once = slot != null || rule.kind == HabitKind.Task || (rule.kind == HabitKind.Check && dayBased && !store.rules.countsUp(habit, day))
        val complete = !rule.atMost && store.rules.isComplete(habit, day)
        val goes = when {
            intent.action == ACTION_UNDO -> null
            once -> return manager.cancel(shown.id)
            rule.kind == HabitKind.Checklist && complete -> return manager.cancel(shown.id)
            rule.kind == HabitKind.Check && dayBased && complete -> return manager.cancel(shown.id)
            rule.kind == HabitKind.Check && !dayBased -> GOES_AFTER_MS
            complete -> GOES_AFTER_MS
            else -> null
        }
        val undo = if (rule.kind == HabitKind.Check && !dayBased) null else added
        val notification = notice(context, store, shown, undo, update = true, goesAfter = goes) ?: return manager.cancel(shown.id)
        try { manager.notify(shown.id, notification) } catch (_: SecurityException) {}
    }

    /** A number typed in the phone's own way ("3000", "8,000", "2,5"); nothing that isn't one. */
    private fun number(text: String): Double? {
        val clean = text.trim()
        if (clean.isEmpty()) return null
        val position = java.text.ParsePosition(0)
        val parsed = java.text.NumberFormat.getNumberInstance(java.util.Locale.getDefault()).parse(clean, position)
        return if (parsed != null && position.index == clean.length) parsed.toDouble() else clean.toDoubleOrNull()
    }

    fun isAlarm(intent: Intent) = intent.action == ACTION_ALARM

    /** A planned alarm whose time is more than [LATE_MS] gone and that never fired is a reminder that didn't arrive. */
    fun noteNeverFired(context: Context, now: Long) {
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        val planned = prefs.getString(PLANNED, null) ?: return
        val at = planned.substringBefore("|").toLongOrNull() ?: return
        if (now - at > LATE_MS && prefs.getLong(LAST, 0L) < at) prefs.edit().putString(MISSED, planned).apply()
    }

    /** The reminder that didn't arrive on time, if any and not dismissed: its habit ID, its time (minute of day) and when. */
    data class Missed(val at: Long, val habitId: String, val minute: Int)

    fun missed(context: Context, now: Long): Missed? {
        noteNeverFired(context, now)
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        val raw = prefs.getString(MISSED, null) ?: return null
        if (raw == prefs.getString(DISMISSED, null)) return null
        val parts = raw.split("|")
        val at = parts.getOrNull(0)?.toLongOrNull() ?: return null
        // Only a recent one is worth saying: older than two days, it's history.
        if (now - at > 2 * 24 * 3_600_000L) return null
        return Missed(at, parts.getOrNull(1) ?: return null, parts.getOrNull(2)?.toIntOrNull() ?: return null)
    }

    fun dismissMissed(context: Context) {
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        prefs.edit().putString(DISMISSED, prefs.getString(MISSED, null)).apply()
    }

    private fun Long.minuteOfDay(): Int = java.time.Instant.ofEpochMilli(this).atZone(java.time.ZoneId.systemDefault()).let { it.hour * 60 + it.minute }

    /** Whether the phone may stop the app in the background to save battery (Android's "optimised" battery use). */
    fun batteryRestricted(context: Context): Boolean =
        context.getSystemService(android.os.PowerManager::class.java)?.isIgnoringBatteryOptimizations(context.packageName) != true
}

/** The reminder alarm, a reminder's buttons, and the phone restarting or changing its clock. */
class ReminderReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val result = goAsync()
        CoroutineScope(Dispatchers.Main.immediate).launch {
            try {
                AppGraph.open(context.applicationContext)
                val store = AppGraph.store
                var waited = 0
                while (!store.isLoaded && waited < 8_000) { delay(20); waited += 20 }
                if (!store.isLoaded) return@launch
                when (intent.action) {
                    Reminders.ACTION_DONE, Reminders.ACTION_ADD, Reminders.ACTION_LOG, Reminders.ACTION_START, Reminders.ACTION_TICK,
                    Reminders.ACTION_UNDO -> {
                        Reminders.act(context, store, intent)
                        store.flush()
                        Reminders.replan(context, store)
                    }
                    else -> when {
                        Reminders.isAlarm(intent) -> Reminders.fire(context, store)
                        MilestoneAlerts.isAlarm(intent) -> MilestoneAlerts.fire(context, store)
                        else -> Reminders.replan(context, store)
                    }
                }
            } finally {
                result.finish()
            }
        }
    }
}
