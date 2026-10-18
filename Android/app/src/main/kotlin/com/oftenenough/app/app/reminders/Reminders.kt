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
            val (title, body) = ReminderPlan.words(alert, store, hide)
            val id = alert.id.hashCode()
            val alarm = alert.habit.alert == "alarm"
            val builder = base(context, title, body, alert.habit.id, alert.day, alert.section.id, alarm)
            ReminderPlan.action(alert.habit, hide)?.let { label ->
                val action = if (alert.habit.kind is HabitKind.Amount) ACTION_ADD else ACTION_DONE
                builder.addAction(0, label, actionIntent(context, action, alert.habit.id, alert.day, alert.placement.slot, id))
            }
            val notification = builder.build()
            // An alarm keeps ringing until it's answered (Done, +1, a tap or a swipe).
            if (alarm) notification.flags = notification.flags or android.app.Notification.FLAG_INSISTENT
            try { manager.notify(id, notification) } catch (_: SecurityException) {}
        }
        for (bucket in groups) {
            val (title, body) = ReminderPlan.groupWords(bucket, hide)
            val first = bucket[0]
            try { manager.notify(("group." + first.fire).hashCode(), base(context, title, body, null, first.day, first.section.id).build()) } catch (_: SecurityException) {}
        }
    }

    private fun base(context: Context, title: String, body: String, habit: String?, day: Int, section: String, alarm: Boolean = false): NotificationCompat.Builder {
        val open = Intent(context, MainActivity::class.java).setFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
            .putExtra(MainActivity.OPEN_HABIT, habit).putExtra(MainActivity.OPEN_DAY, day)
        val content = PendingIntent.getActivity(context, (habit ?: section).hashCode() + day, open, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
        return NotificationCompat.Builder(context, if (alarm) ALARM_CHANNEL else CHANNEL).setSmallIcon(R.drawable.ic_notification).setContentTitle(title)
            .apply { if (body.isNotEmpty()) setContentText(body) }
            .setContentIntent(content).setAutoCancel(true).setGroup(section)
            .setCategory(if (alarm) NotificationCompat.CATEGORY_ALARM else NotificationCompat.CATEGORY_REMINDER)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
    }

    private fun actionIntent(context: Context, action: String, habit: String, day: Int, slot: String?, notification: Int): PendingIntent {
        val intent = Intent(context, ReminderReceiver::class.java).setAction(action).putExtra(EXTRA_HABIT, habit).putExtra(EXTRA_DAY, day)
            .putExtra(EXTRA_SLOT, slot).putExtra(EXTRA_NOTIFICATION, notification)
        return PendingIntent.getBroadcast(context, notification, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
    }

    /**
     * Done or +1 from a reminder: saved in the store's order, idempotently (Done on a day already done changes nothing),
     * then the notification goes and reminders re-plan.
     */
    fun act(context: Context, store: HabitStore, intent: Intent) {
        val habit = store.habit(intent.getStringExtra(EXTRA_HABIT) ?: return) ?: return
        val day = intent.getIntExtra(EXTRA_DAY, store.today())
        val slot = intent.getStringExtra(EXTRA_SLOT)
        if (!habit.archived && day <= store.today()) when (intent.action) {
            ACTION_DONE -> when {
                slot != null -> if (!store.isSlotDone(habit, slot, day)) store.toggleSlot(habit, slot, day, EntrySource.REMINDER)
                habit.kind == HabitKind.Task -> if (!store.isTicked(habit, day)) store.toggleCheck(habit, day, EntrySource.REMINDER)
                store.rules.countsUp(habit, day) -> store.addProgress(habit, 1.0, day, source = EntrySource.REMINDER)
                else -> if (!store.isTicked(habit, day)) store.toggleCheck(habit, day, EntrySource.REMINDER)
            }
            ACTION_ADD -> store.increment(habit, day, EntrySource.REMINDER)
        }
        NotificationManagerCompat.from(context).cancel(intent.getIntExtra(EXTRA_NOTIFICATION, 0))
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
                    Reminders.ACTION_DONE, Reminders.ACTION_ADD -> {
                        Reminders.act(context, store, intent)
                        store.flush()
                        Reminders.replan(context, store)
                    }
                    else -> if (Reminders.isAlarm(intent)) Reminders.fire(context, store) else Reminders.replan(context, store)
                }
            } finally {
                result.finish()
            }
        }
    }
}
