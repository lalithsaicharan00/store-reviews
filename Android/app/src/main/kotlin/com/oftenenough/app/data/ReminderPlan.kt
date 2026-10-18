package com.oftenenough.app.data

import java.time.LocalDate
import java.time.ZoneId

// MOVE TO CORE: which reminders are wanted and what they say, ported from the iPhone's ReminderScheduler.swift (plan,
// fireDate, the words). Android delivers them with its own alarms; the plan is the same on both phones.

object ReminderPlan {
    const val MAX_FOLLOW_UPS = 3
    const val HORIZON_DAYS = 30

    /** One reminder wanted at [fire]: a habit's time on a day (and which part of the day), or one of its repeats. */
    data class Alert(
        val id: String, val fire: Long, val habit: Habit, val day: Int, val placement: Placement, val time: ReminderTime,
        val followUp: Int, val section: DaySection,
    )

    /** When a reminder time rings for a tracked [day]: a time before the day's start belongs to the night after it (D7). */
    fun fireMoment(time: ReminderTime, day: Int, dayEndHour: Int, zone: ZoneId = ZoneId.systemDefault()): Long {
        val actual = if (time.minuteOfDay < dayEndHour * 60) day + 1 else day
        return LocalDate.ofEpochDay(actual.toLong()).atTime(time.hour, time.minute).atZone(zone).toInstant().toEpochMilli()
    }

    private fun dayEnd(day: Int, dayEndHour: Int, zone: ZoneId): Long =
        LocalDate.ofEpochDay(day + 1L).atTime(dayEndHour, 0).atZone(zone).toInstant().toEpochMilli()

    /** Every reminder wanted from [now] over the next days, nearest first. [days] limits how far ahead. */
    fun plan(store: HabitStore, now: Long, days: Int = HORIZON_DAYS, zone: ZoneId = ZoneId.systemDefault()): List<Alert> {
        val rules = store.rules
        val today = rules.today(now)
        val dayEndHour = rules.dayEndHour
        val alerts = ArrayList<Alert>()
        for (habit in store.habits) {
            if (habit.archived || habit.kind == HabitKind.Quit || !habit.remind || habit.reminders.isEmpty()) continue
            val placements = rules.placements(habit)
            for (offset in 0 until days) {
                val day = today + offset
                if (!rules.isDue(habit, day, now)) continue
                if (store.isPaused(habit, day)) continue
                val seenFires = HashSet<Long>()
                for (placement in placements) {
                    // A limit is never "not done", so it always reminds. Anything else stops once its row is done;
                    // for week and month rules, once the period's goal is met.
                    if (!habit.atMost) {
                        val done = placement.slot?.let { store.isSlotDone(habit, it, day) } ?: rules.isSatisfied(habit, day)
                        if (done) continue
                    }
                    val seenTimes = HashSet<Int>()
                    val times = placement.times.sortedWith(compareBy({ it.minuteOfDay }, { it.id }))
                        .filter { it.hour in 0..23 && it.minute in 0..59 && seenTimes.add(it.minuteOfDay) }
                        .sortedBy { rules.dayMinute(it.minuteOfDay) }
                        .mapNotNull { t -> fireMoment(t, day, dayEndHour, zone).takeIf { seenFires.add(it) }?.let { t to it } }
                    for ((i, pair) in times.withIndex()) {
                        val (time, fire) = pair
                        val section = store.section(rules.sectionForMinute(time.minuteOfDay))
                        val base = "reminder.${habit.id}.${time.id}.${dayKey(day)}"
                        if (fire > now) alerts += Alert(base, fire, habit, day, placement, time, 0, section)
                        // Remind again: today and tomorrow only; repeats stop at the row's next time and at the day's end.
                        val every = habit.followUpMinutes ?: continue
                        if (every <= 0 || every > 1440 || habit.atMost || offset > 1) continue
                        val stop = if (i + 1 < times.size) times[i + 1].second else dayEnd(day, dayEndHour, zone)
                        for (k in 1..MAX_FOLLOW_UPS) {
                            val again = fire + k * every * 60_000L
                            if (again >= stop) break
                            if (again > now) alerts += Alert("$base.f$k", again, habit, day, placement, time, k, section)
                        }
                    }
                }
            }
        }
        val order = store.habits.withIndex().associate { it.value.id to it.index }
        return alerts.sortedWith(compareBy({ it.fire }, { order[it.habit.id] ?: 0 }, { it.id }))
    }

    /** A single reminder's words: the habit's name, and "Reminder says…" or the usual line (U3: never "missed"). */
    fun words(alert: Alert, store: HabitStore, hideNames: Boolean): Pair<String, String> {
        val habit = alert.habit
        val clock = DayWords.clockMinute(alert.time.minuteOfDay)
        if (hideNames) {
            if (alert.followUp > 0) return "Still open · $clock" to (habit.reminderText ?: "")
            return (habit.reminderText ?: "Reminder · $clock") to ""
        }
        var body = habit.reminderText ?: body(habit, store)
        if (alert.placement.slot != null) body = "${store.section(alert.placement.section).name} · $body"
        if (alert.followUp > 0) body = "Not done yet · $body"
        return habit.name to body
    }

    /** Same-minute reminders share one notification: "Morning" · "Meds, Stretch +2"; names hidden: "3 reminders · 8:00". */
    fun groupWords(alerts: List<Alert>, hideNames: Boolean): Pair<String, String> {
        val first = alerts.first()
        if (hideNames) return "${alerts.size} reminders · ${DayWords.clockMinute(first.time.minuteOfDay)}" to ""
        val names = alerts.map { it.habit.name }
        return first.section.name to (names.take(3).joinToString(", ") + if (names.size > 3) " +${names.size - 3}" else "")
    }

    fun body(habit: Habit, store: HabitStore): String {
        val ws = store.weekStart
        return when (val k = habit.kind) {
            is HabitKind.Amount -> if (habit.atMost) "No more than ${HabitCopy.amount(store.rules.goal(habit), k.unit)} today" else HabitCopy.capitalized(HabitCopy.plan(habit, ws))
            HabitKind.Duration -> HabitCopy.capitalized(HabitCopy.plan(habit, ws))
            HabitKind.Checklist -> if (habit.steps.size == 1) "1 step" else "${habit.steps.size} steps"
            HabitKind.Task -> "To-do"
            else -> "Time for ${habit.name.lowercase()}"
        }
    }

    /** The button a reminder has: "Done" for a check or a to-do, "+1 glass" for an amount with a step, none otherwise. */
    fun action(habit: Habit, hideNames: Boolean): String? = when (val k = habit.kind) {
        HabitKind.Check, HabitKind.Task -> "Done"
        is HabitKind.Amount -> habit.quickIncrement?.let { "+" + if (hideNames) Format.amount(it) else HabitCopy.amount(it, k.unit) }
        else -> null
    }
}
