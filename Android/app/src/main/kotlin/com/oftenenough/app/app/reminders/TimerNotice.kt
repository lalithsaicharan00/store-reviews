package com.oftenenough.app.app.reminders

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import androidx.compose.ui.graphics.toArgb
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import com.oftenenough.app.R
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.app.widgets.HabitIconBitmaps
import com.oftenenough.app.data.EntrySource
import com.oftenenough.app.data.Format
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.theme.AppColors
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

/**
 * A running timer, outside the app: Android 16's Live Update (A11 D4; Figma 1328:2, row 10). An ongoing notification asks
 * to be promoted, so Android shows a chip in the status bar with the clock in the habit's colour (10), the notification in
 * the shade (10.1: *Often Enough · Timer*, the habit, its goal, a progress bar, Pause) and on the lock screen (10.3).
 * Android draws the clock from the timer's start, so nothing in the app ticks; the bar moves on once a minute while the
 * app is alive, and at the goal it says so (10.4). Pause saves the time without opening the app, even locked (D13), and
 * leaves the notification paused with Resume (10.2). A tap opens the timer, or the routine it was started in at that habit
 * (10.5). Appearance › Show in notifications turns it off.
 */
object TimerNotice {
    const val CHANNEL = "timers"
    private const val ACTION_PAUSE = "com.oftenenough.app.TIMER_STOP"
    private const val ACTION_RESUME = "com.oftenenough.app.TIMER_RESUME"
    private const val ACTION_DISMISS = "com.oftenenough.app.TIMER_DISMISS"
    private const val EXTRA_HABIT = "habit"
    private const val PREFS = "timer_notice"
    private const val KEY_PAUSED = "paused"
    private const val KEY_ROUTINE = "routine"

    /** A test that checks the Live Update itself turns this on; test launches otherwise never post (D8). */
    var showInTests = false

    /** What each notification shows now ("run", "goal", "paused"), so a change of state posts it again. */
    private val shown = HashMap<String, String>()
    private var ticker: Job? = null

    fun channel(context: Context) {
        appContext = context.applicationContext
        context.getSystemService(NotificationManager::class.java)?.createNotificationChannel(
            NotificationChannel(CHANNEL, "Running timers", NotificationManager.IMPORTANCE_LOW).apply {
                description = "A timer you started, while it runs."
                setShowBadge(false)
            })
    }

    // ------------------------------------------------------------------ What it remembers (this phone only)

    private fun prefs(context: Context) = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
    private var appContext: Context? = null

    /** Paused from the notification: "habitId|slot", kept until Resume, the timer runs again, or it's swiped away. */
    private fun paused(context: Context): Map<String, String> =
        prefs(context).getStringSet(KEY_PAUSED, emptySet())!!.associate { it.substringBefore("|") to it.substringAfter("|", "") }

    private fun savePaused(context: Context, map: Map<String, String>) =
        prefs(context).edit().putStringSet(KEY_PAUSED, map.map { (id, slot) -> "$id|$slot" }.toSet()).apply()

    /** Timers started in a routine: "habitId" to "part|day", so a tap opens that routine at that habit (10.5). */
    private fun routines(context: Context): Map<String, String> =
        prefs(context).getStringSet(KEY_ROUTINE, emptySet())!!.associate { it.substringBefore("=") to it.substringAfter("=") }

    /** The routine player started [habitId]'s timer (in [part], for [day]). */
    fun startedInRoutine(habitId: String, part: String, day: Int) {
        val context = appContext ?: return
        val now = routines(context) + (habitId to "$part|$day")
        prefs(context).edit().putStringSet(KEY_ROUTINE, now.map { (k, v) -> "$k=$v" }.toSet()).apply()
        shown.remove(habitId)
    }

    // ------------------------------------------------------------------ Showing

    /** Shows a notification for each running or paused timer and removes the rest. Cheap: called after every change. */
    fun sync(context: Context, store: HabitStore) {
        appContext = context.applicationContext
        if (AppGraph.isTest && !showInTests) return
        val manager = NotificationManagerCompat.from(context)
        val allowed = AppGraph.prefs.timerNotification && Reminders.canPost(context)
        val running = if (allowed) store.timers else emptyMap()
        var paused = paused(context).filterKeys { it !in store.timers && store.habit(it) != null }
        if (!allowed) paused = emptyMap()
        savePaused(context, paused)
        // A routine is remembered only while its timer runs or waits paused.
        val routines = routines(context).filterKeys { it in running || it in paused }
        prefs(context).edit().putStringSet(KEY_ROUTINE, routines.map { (k, v) -> "$k=$v" }.toSet()).apply()
        for (id in shown.keys.toList()) if (id !in running && id !in paused) { manager.cancel(id.hashCode()); shown.remove(id) }
        val now = store.clock()
        for ((id, start) in running) {
            val habit = store.habit(id) ?: continue
            val ruled = store.rule(habit, store.today())
            val goal = store.rules.dayGoal(ruled)
            val done = store.rules.dayProgress(habit, store.today(), now)
            val state = when { goal <= 0 -> "run"; ruled.atMost -> if (done > goal) "over" else "run"; done >= goal -> "goal"; else -> "run" }
            // The bar moves once a minute; the state's words change at the goal.
            val minute = ((now - start) / 60_000).toString()
            val sig = "$state|$minute"
            if (shown[id] == sig) continue
            post(context, store, id, start, state, done, goal, ruled.atMost, routines[id])
            shown[id] = sig
        }
        for (id in paused.keys) {
            if (shown[id] == "paused") continue
            val habit = store.habit(id) ?: continue
            val ruled = store.rule(habit, store.today())
            post(context, store, id, null, "paused", store.rules.dayProgress(habit, store.today(), now), store.rules.dayGoal(ruled), ruled.atMost, routines[id])
            shown[id] = "paused"
        }
        // Once a minute while a timer runs and the app is alive: the bar and the goal's words catch up.
        if (running.isEmpty()) { ticker?.cancel(); ticker = null }
        else if (ticker?.isActive != true) ticker = CoroutineScope(Dispatchers.Main).launch {
            while (true) {
                delay(60_000 - store.clock() % 60_000)
                if (store.timers.isEmpty()) break
                sync(context, store)
            }
        }
    }

    private fun post(context: Context, store: HabitStore, id: String, start: Long?, state: String, done: Double, goal: Double,
                     atMost: Boolean, routine: String?) {
        val habit = store.habit(id) ?: return
        val hidden = AppGraph.hidesNames
        val name = if (hidden) "Timer" else habit.name
        val goalText = Format.minutes(goal)
        val title = if (state == "paused") "$name · Paused" else name
        val text = when (state) {
            "paused" -> if (goal > 0) Format.clock(done) + " of " + goalText + (if (atMost) " max" else "") else Format.clock(done)
            "goal" -> "Goal met · $goalText"
            "over" -> "Over the limit · $goalText max"
            else -> if (goal <= 0) "Timing" else if (atMost) "Limit $goalText" else "Goal $goalText"
        }
        val color = AppColors.light.habit(habit.color).toArgb()
        val px = (48 * context.resources.displayMetrics.density).toInt()
        // A tap opens what started it: the routine at this habit, or the timer (10.5).
        val route = routine?.let { r -> "player/" + android.net.Uri.encode(r.substringBefore("|")) + "/" + r.substringAfter("|") + "/" + id } ?: "timer/$id"
        val open = PendingIntent.getActivity(context, id.hashCode(),
            Intent(context, MainActivity::class.java).setFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP)
                .putExtra(MainActivity.WIDGET_ROUTE, route),
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
        val action = if (state == "paused") ACTION_RESUME else ACTION_PAUSE
        val act = PendingIntent.getBroadcast(context, id.hashCode() + action.hashCode(),
            Intent(context, TimerStopReceiver::class.java).setAction(action).putExtra(EXTRA_HABIT, id),
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
        val builder = NotificationCompat.Builder(context, CHANNEL).setSmallIcon(R.drawable.ic_notification)
            .setSubText("Timer").setContentTitle(title).setContentText(text).setColor(color)
            .setOnlyAlertOnce(true).setCategory(NotificationCompat.CATEGORY_STOPWATCH)
            .setVisibility(if (hidden) NotificationCompat.VISIBILITY_PRIVATE else NotificationCompat.VISIBILITY_PUBLIC)
            .setContentIntent(open)
            .addAction(if (state == "paused") R.drawable.ic_notification else 0, if (state == "paused") "Resume" else "Pause", act)
        if (!hidden) builder.setLargeIcon(HabitIconBitmaps.get(habit.symbol, habit.color.key, false, px))
        if (goal > 0) builder.setProgress(1000, ((done / goal).coerceIn(0.0, 1.0) * 1000).toInt(), false)
        if (start != null) {
            // Running: Android draws the clock, in the shade and in the status bar's chip. It counts today's whole time
            // (12:58, as the app's clock), so it starts that long before now.
            builder.setWhen(System.currentTimeMillis() - (done * 60_000).toLong()).setUsesChronometer(true).setShowWhen(true)
                .setOngoing(true).setRequestPromotedOngoing(true)
        } else {
            // Paused: still, and it can be swiped away.
            builder.setShowWhen(false).setOngoing(false).setDeleteIntent(PendingIntent.getBroadcast(context, id.hashCode() + 7,
                Intent(context, TimerStopReceiver::class.java).setAction(ACTION_DISMISS).putExtra(EXTRA_HABIT, id),
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE))
        }
        try { NotificationManagerCompat.from(context).notify(id.hashCode(), builder.build()) } catch (_: SecurityException) {}
    }

    // ------------------------------------------------------------------ The notification's buttons (D13: no unlock)

    fun act(context: Context, store: HabitStore, intent: Intent) {
        val habit = store.habit(intent.getStringExtra(EXTRA_HABIT) ?: return) ?: return
        when (intent.action) {
            ACTION_PAUSE -> {
                if (!store.timers.containsKey(habit.id)) return
                val slot = store.timerSlots[habit.id] ?: ""
                store.stopTimer(habit, store.today(), source = EntrySource.TIMER)
                savePaused(context, paused(context) + (habit.id to slot))
                shown.remove(habit.id)
            }
            ACTION_RESUME -> {
                val slot = paused(context)[habit.id]
                savePaused(context, paused(context) - habit.id)
                shown.remove(habit.id)
                if (!store.timers.containsKey(habit.id)) store.toggleTimer(habit, slot?.takeIf { it.isNotEmpty() })
            }
            ACTION_DISMISS -> {
                savePaused(context, paused(context) - habit.id)
                shown.remove(habit.id)
            }
        }
        sync(context, store)
    }
}

/** Pause, Resume and swiping a paused timer away, from the Live Update (the name is kept: the manifest declares it). */
class TimerStopReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val result = goAsync()
        CoroutineScope(Dispatchers.Main.immediate).launch {
            try {
                AppGraph.open(context.applicationContext)
                val store = AppGraph.store
                var waited = 0
                while (!store.isLoaded && waited < 8_000) { delay(20); waited += 20 }
                if (store.isLoaded) { TimerNotice.act(context, store, intent); store.flush() }
            } finally {
                result.finish()
            }
        }
    }
}
