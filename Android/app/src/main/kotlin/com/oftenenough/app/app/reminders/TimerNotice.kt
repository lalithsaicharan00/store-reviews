package com.oftenenough.app.app.reminders

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import com.oftenenough.app.R
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.data.EntrySource
import com.oftenenough.app.data.Format
import com.oftenenough.app.data.HabitStore
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

/**
 * A running timer, outside the app: an ongoing notification in the shade, on the lock screen and in the status bar,
 * with the clock counting up from its start (Android draws it; nothing in the app ticks) and Stop and save, which
 * saves without opening the app (D13). Appearance › Show in notifications turns it off.
 */
object TimerNotice {
    const val CHANNEL = "timers"
    private const val ACTION_STOP = "com.oftenenough.app.TIMER_STOP"
    private const val EXTRA_HABIT = "habit"
    private val shown = HashSet<String>()

    fun channel(context: Context) {
        context.getSystemService(NotificationManager::class.java)?.createNotificationChannel(
            NotificationChannel(CHANNEL, "Running timers", NotificationManager.IMPORTANCE_LOW).apply {
                description = "A timer you started, while it runs."
                setShowBadge(false)
            })
    }

    /** Shows a notification for each running timer and removes the ones that stopped. Cheap: called after every change. */
    fun sync(context: Context, store: HabitStore) {
        if (AppGraph.isTest) return
        val manager = NotificationManagerCompat.from(context)
        val wanted = if (AppGraph.prefs.timerNotification && Reminders.canPost(context)) store.timers else emptyMap()
        for (id in shown.toList()) if (id !in wanted) { manager.cancel(id.hashCode()); shown.remove(id) }
        for ((id, start) in wanted) {
            if (id in shown) continue
            val habit = store.habit(id) ?: continue
            val goal = store.rules.dayGoal(store.rule(habit, store.today()))
            val title = if (AppGraph.hidesNames) "Timer" else habit.name
            val open = PendingIntent.getActivity(context, id.hashCode(),
                Intent(context, MainActivity::class.java).setFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
                    .putExtra(MainActivity.OPEN_HABIT, id).putExtra(MainActivity.OPEN_DAY, store.today()),
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
            val stop = PendingIntent.getBroadcast(context, id.hashCode(),
                Intent(context, TimerStopReceiver::class.java).setAction(ACTION_STOP).putExtra(EXTRA_HABIT, id),
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
            val notice = NotificationCompat.Builder(context, CHANNEL).setSmallIcon(R.drawable.ic_notification)
                .setContentTitle(title).setContentText(if (goal > 0) "Goal " + Format.minutes(goal) else "Timing")
                .setWhen(start).setUsesChronometer(true).setShowWhen(true).setOngoing(true).setOnlyAlertOnce(true)
                .setCategory(NotificationCompat.CATEGORY_STOPWATCH).setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
                .setContentIntent(open).addAction(0, "Stop and save", stop).build()
            try { manager.notify(id.hashCode(), notice); shown += id } catch (_: SecurityException) {}
        }
    }

    fun stop(context: Context, store: HabitStore, intent: Intent) {
        val habit = store.habit(intent.getStringExtra(EXTRA_HABIT) ?: return) ?: return
        if (store.timers.containsKey(habit.id)) store.stopTimer(habit, store.today(), source = EntrySource.TIMER)
        NotificationManagerCompat.from(context).cancel(habit.id.hashCode())
        shown.remove(habit.id)
    }
}

/** Stop and save from the running timer's notification. */
class TimerStopReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val result = goAsync()
        CoroutineScope(Dispatchers.Main.immediate).launch {
            try {
                AppGraph.open(context.applicationContext)
                val store = AppGraph.store
                var waited = 0
                while (!store.isLoaded && waited < 8_000) { delay(20); waited += 20 }
                if (store.isLoaded) { TimerNotice.stop(context, store, intent); store.flush() }
            } finally {
                result.finish()
            }
        }
    }
}
