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
    private const val ACTION_ALARM = "com.oftenenough.app.REMINDER_ALARM"
    const val ACTION_DONE = "com.oftenenough.app.REMINDER_DONE"
    const val ACTION_ADD = "com.oftenenough.app.REMINDER_ADD"
    private const val EXTRA_HABIT = "habit"
    private const val EXTRA_DAY = "day"
    private const val EXTRA_SLOT = "slot"
    private const val EXTRA_NOTIFICATION = "notification"
    private const val PREFS = "reminders"
    private const val LAST = "lastFired"

    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.Main.immediate)
    private var pending: Job? = null

    fun channel(context: Context) {
        val manager = context.getSystemService(NotificationManager::class.java) ?: return
        manager.createNotificationChannel(NotificationChannel(CHANNEL, "Reminders", NotificationManager.IMPORTANCE_HIGH).apply {
            description = "Your habits' reminders, at the times you chose."
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
        if (next == null) { alarms.cancel(intent); return }
        if (canBeExact(context)) alarms.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, next.fire, intent)
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
        if (canPost(context)) post(context, store, due)
        replan(context, store)
    }

    private fun post(context: Context, store: HabitStore, due: List<ReminderPlan.Alert>) {
        val hide = AppGraph.prefs.hideNames
        val manager = NotificationManagerCompat.from(context)
        val singles = due.filter { it.followUp > 0 } + due.filter { it.followUp == 0 }.groupBy { it.fire }.values.filter { it.size == 1 }.map { it[0] }
        val groups = due.filter { it.followUp == 0 }.groupBy { it.fire }.values.filter { it.size > 1 }
        for (alert in singles) {
            val (title, body) = ReminderPlan.words(alert, store, hide)
            val id = alert.id.hashCode()
            val builder = base(context, title, body, alert.habit.id, alert.day, alert.section.id)
            ReminderPlan.action(alert.habit, hide)?.let { label ->
                val action = if (alert.habit.kind is HabitKind.Amount) ACTION_ADD else ACTION_DONE
                builder.addAction(0, label, actionIntent(context, action, alert.habit.id, alert.day, alert.placement.slot, id))
            }
            try { manager.notify(id, builder.build()) } catch (_: SecurityException) {}
        }
        for (bucket in groups) {
            val (title, body) = ReminderPlan.groupWords(bucket, hide)
            val first = bucket[0]
            try { manager.notify(("group." + first.fire).hashCode(), base(context, title, body, null, first.day, first.section.id).build()) } catch (_: SecurityException) {}
        }
    }

    private fun base(context: Context, title: String, body: String, habit: String?, day: Int, section: String): NotificationCompat.Builder {
        val open = Intent(context, MainActivity::class.java).setFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
            .putExtra(MainActivity.OPEN_HABIT, habit).putExtra(MainActivity.OPEN_DAY, day)
        val content = PendingIntent.getActivity(context, (habit ?: section).hashCode() + day, open, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
        return NotificationCompat.Builder(context, CHANNEL).setSmallIcon(R.drawable.ic_notification).setContentTitle(title)
            .apply { if (body.isNotEmpty()) setContentText(body) }
            .setContentIntent(content).setAutoCancel(true).setGroup(section).setCategory(NotificationCompat.CATEGORY_REMINDER)
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
                store.rules.countsUp(habit) -> store.addProgress(habit, 1.0, day, source = EntrySource.REMINDER)
                else -> if (!store.isTicked(habit, day)) store.toggleCheck(habit, day, EntrySource.REMINDER)
            }
            ACTION_ADD -> store.increment(habit, day, EntrySource.REMINDER)
        }
        NotificationManagerCompat.from(context).cancel(intent.getIntExtra(EXTRA_NOTIFICATION, 0))
    }

    fun isAlarm(intent: Intent) = intent.action == ACTION_ALARM
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
