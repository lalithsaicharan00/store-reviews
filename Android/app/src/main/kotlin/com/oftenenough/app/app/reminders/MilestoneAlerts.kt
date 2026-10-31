package com.oftenenough.app.app.reminders

import android.app.AlarmManager
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import com.oftenenough.app.R
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Format
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitCopy
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.MilestoneBucket
import com.oftenenough.app.data.QuitRun
import com.oftenenough.app.data.isLandmark
import com.oftenenough.app.data.milestoneBucket
import java.time.Instant
import java.time.LocalDate
import java.time.ZoneId

/**
 * The milestone notification, for quit and cut-down habits only, off until the person turns on *Tell me at milestones*
 * on the habit's form (Figma N.1–N.6, the user, 18 Oct 2026). It comes for the pop-up lengths only (30 days, 180 days,
 * a year and each year after, as the habit's bucket counts them), a length reached for the first time: a quit habit's
 * on the day, a cut-down habit's the day after its day closed, around midday, never at night. Tapping it opens Today
 * with that milestone's pop-up, which counts as the day's pop-up.
 */
object MilestoneAlerts {
    const val CHANNEL = "milestones"
    private const val ACTION = "com.oftenenough.app.MILESTONE_ALERT"
    private const val PREFS = "milestone-alerts"
    private const val SENT = "sent"
    private const val MIDDAY = 12
    private const val NIGHT = 21

    /** The habit's switch, kept as one of its settings (synced like its others). */
    fun key(habitId: String) = "milestones.notify.$habitId"
    fun wanted(store: HabitStore, habit: Habit) = store.setting(key(habit.id)) == "true"

    fun channel(context: Context) {
        context.getSystemService(NotificationManager::class.java)?.createNotificationChannel(
            NotificationChannel(CHANNEL, "Milestones", NotificationManager.IMPORTANCE_DEFAULT).apply {
                description = "When a quit or cut-down habit reaches a milestone, if you turned it on for that habit."
            })
    }

    /** A notification to come: the habit, the length, and when. */
    class Due(val habit: Habit, val value: Int, val fire: Long, val quit: Boolean) {
        val id get() = "${habit.id}:$value"
    }

    private fun midday(day: Int, zone: ZoneId = ZoneId.systemDefault()): Long =
        LocalDate.ofEpochDay(day.toLong()).atTime(MIDDAY, 0).atZone(zone).toInstant().toEpochMilli()

    /** Never at night: a moment after 9 PM moves to the next day's midday. */
    private fun daytime(moment: Long, zone: ZoneId = ZoneId.systemDefault()): Long {
        val local = Instant.ofEpochMilli(moment).atZone(zone)
        return if (local.hour >= NIGHT) midday(local.toLocalDate().toEpochDay().toInt() + 1, zone) else moment
    }

    /** Every notification still to come for the habits that asked, soonest first. */
    fun plan(store: HabitStore, now: Long, also: Habit? = null): List<Due> {
        val list = ArrayList<Due>()
        for (habit in store.habits) {
            if (habit.archived || !(wanted(store, habit) || habit.id == also?.id)) continue
            val today = store.today(now)
            if (store.isPaused(habit, today)) continue
            if (habit.kind == HabitKind.Quit) quitNext(store, habit, now)?.let { list += it }
            else if (habit.atMost) limitNext(store, habit, today)?.let { list += it }
        }
        return list.sortedBy { it.fire }
    }

    private fun quitNext(store: HabitStore, habit: Habit, now: Long): Due? {
        val history = store.rules.quitHistory(habit, now)
        val run = history.lastOrNull()?.takeIf { it.ending == QuitRun.Ending.ONGOING } ?: return null
        val best = history.dropLast(1).maxOfOrNull { ((it.end ?: now) - it.start) / DAY_MS }?.toInt() ?: 0
        val days = ((now - run.start) / DAY_MS).toInt()
        // The next pop-up length after today's, from 30 days; one reached in an earlier run doesn't come again.
        var n = days
        do n++ while (!(MilestoneBucket.DAYS.isLandmark(n) && n > best) && n < days + 3 * 366)
        if (!MilestoneBucket.DAYS.isLandmark(n)) return null
        val reached = run.start + n * DAY_MS
        val day = store.rules.calendarDayOf(reached)
        return Due(habit, n, daytime(maxOf(midday(day), reached)), quit = true)
    }

    private fun limitNext(store: HabitStore, habit: Habit, today: Int): Due? {
        val ruled = store.rule(habit, today)
        val period = store.rules.periodRange(ruled, today) ?: (today..today)
        // Only while today's period holds: within the limit so far, and it closes today.
        if (period.last != today || store.rules.progress(habit, today) > store.rules.goal(ruled)) return null
        val n = store.streak(habit, period.first - 1) + 1
        val runs = store.rules.runs(habit, today)
        val best = runs.filter { it.end < period.first - 1 }.maxOfOrNull { it.length } ?: 0
        if (!store.rules.milestoneBucket(ruled).isLandmark(n) || n <= best) return null
        return Due(habit, n, midday(today + 1), quit = false)
    }

    /** Sets the one alarm for the next notification (none when nothing is asked). */
    fun replan(context: Context, store: HabitStore) {
        if (!store.isLoaded || AppGraph.isTest) return
        val alarms = context.getSystemService(AlarmManager::class.java) ?: return
        val intent = PendingIntent.getBroadcast(context, 7, Intent(context, ReminderReceiver::class.java).setAction(ACTION),
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
        val sent = sent(context)
        val next = plan(store, store.clock()).firstOrNull { it.id !in sent }
        if (next == null) { alarms.cancel(intent); return }
        // "Around midday": Android may move it a little to save battery.
        alarms.setAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, next.fire, intent)
    }

    fun isAlarm(intent: Intent) = intent.action == ACTION

    private fun sent(context: Context): Set<String> =
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE).getStringSet(SENT, emptySet()) ?: emptySet()

    /** The alarm: whatever has come due is checked again (a slip or a cup since cancels it) and posted, once. */
    fun fire(context: Context, store: HabitStore) {
        val now = store.clock()
        val sent = sent(context).toMutableSet()
        // Planned from a moment before now, so what's due now is still in the plan.
        val due = plan(store, now - 18 * 3_600_000L).filter { it.fire <= now + 60_000 && it.id !in sent && stillDue(store, it, now) }
        for (d in due) {
            if (Reminders.canPost(context)) post(context, store, d)
            sent += d.id
        }
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE).edit().putStringSet(SENT, sent.toList().takeLast(200).toSet()).apply()
        replan(context, store)
    }

    private fun stillDue(store: HabitStore, d: Due, now: Long): Boolean {
        if (d.quit) {
            val run = store.rules.quitHistory(d.habit, now).lastOrNull()?.takeIf { it.ending == QuitRun.Ending.ONGOING } ?: return false
            return (now - run.start) / DAY_MS >= d.value
        }
        // A cut-down day closed within the limit: its streak, through yesterday, is the length.
        return store.streak(d.habit, store.today(now)) == d.value
    }

    /** The words (Figma N.5): "30 days clean" · "Smoking · since 12 Oct. Tap to see your milestone." */
    fun words(store: HabitStore, d: Due, hideNames: Boolean): Pair<String, String> {
        if (hideNames) return "A milestone reached" to "Open Often Enough to see it."
        val habit = d.habit
        if (d.quit) {
            val since = store.rules.quitHistory(habit, store.clock()).lastOrNull()?.start ?: habit.createdAt
            return "${d.value} days clean" to "${habit.name} · since ${DayWords.dayMonth(store.rules.calendarDayOf(since))}. Tap to see your milestone."
        }
        val ruled = store.rule(habit, store.today())
        val unit = ruled.frequency.streakUnit
        val limit = com.oftenenough.app.data.MilestoneCenter.limitAmount(ruled)
        val per = when (unit) { com.oftenenough.app.data.StreakUnit.WEEKS -> "a week"; com.oftenenough.app.data.StreakUnit.MONTHS -> "a month"; else -> "a day" }
        val word = when (unit) { com.oftenenough.app.data.StreakUnit.WEEKS -> "weeks"; com.oftenenough.app.data.StreakUnit.MONTHS -> "months"; else -> "days" }
        return "${d.value} $word within the limit" to "${habit.name} · no more than $limit $per, ${d.value} $word in a row. Tap to see it."
    }

    private fun post(context: Context, store: HabitStore, d: Due) {
        val (title, body) = words(store, d, AppGraph.hidesNames)
        val open = Intent(context, MainActivity::class.java).setFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
            .putExtra(MainActivity.OPEN_MILESTONE, "${d.habit.id}|${d.value}")
        val content = PendingIntent.getActivity(context, d.id.hashCode(), open, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
        val notification = NotificationCompat.Builder(context, CHANNEL).setSmallIcon(R.drawable.ic_notification)
            .setContentTitle(title).setContentText(body).setStyle(NotificationCompat.BigTextStyle().bigText(body))
            .setContentIntent(content).setAutoCancel(true).setCategory(NotificationCompat.CATEGORY_EVENT).build()
        try { NotificationManagerCompat.from(context).notify(d.id.hashCode(), notification) } catch (_: SecurityException) {}
    }

    /** "Next: 30 days clean, around midday on 11 Nov" for the form, once the switch is on (Figma N.3). */
    fun nextText(store: HabitStore, habit: Habit): String? {
        val d = plan(store, store.clock(), also = habit).firstOrNull { it.habit.id == habit.id } ?: return null
        val title = if (d.quit) "${d.value} days clean" else "${d.value} days within the limit"
        return "Next: $title, around midday on ${DayWords.dayMonth(store.rules.calendarDayOf(d.fire))}."
    }

    private const val DAY_MS = 86_400_000L
}
