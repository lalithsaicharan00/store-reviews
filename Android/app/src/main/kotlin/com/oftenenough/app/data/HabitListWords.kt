package com.oftenenough.app.data

// MOVE TO CORE (words): the Habits page's line under each name (Figma 2106:2, frames 1.7 and 1.8).

/**
 * The line under a habit's name on the Habits page. A status comes first when there is one (paused, starts later, ended),
 * said plainly and never in red (U3); otherwise the goal, then How often, then the first reminder time:
 * "8 glasses · Every day", "Every day · 8:00 AM", "3 times a week", "Quit", "At most 2 cups a day".
 */
fun HabitStore.listLine(habit: Habit, today: Int = today()): String {
    if (habit.archived) return archivedLine(habit)
    if (isPaused(habit, today)) {
        val p = pause(habit, today)
        return p?.through?.let { "Back on " + DayWords.dayMonth(it + 1) } ?: "Paused until you resume"
    }
    val plan = habitPlanLine(habit, weekStart)
    habit.endsOn?.let { end -> if (end < today) return "Ended " + DayWords.dayMonth(end) }
    val start = habit.startsOn
    val parts = mutableListOf<String>()
    if (start != null && start > today) parts += "Starts " + DayWords.dayMonth(start)
    parts += plan
    habit.endsOn?.let { parts += "Ends " + DayWords.dayMonth(it) }
    return parts.joinToString(" · ")
}

/** "Archived 3 Sep", or "Started over as Time it" for a habit a type change archived (Figma 6, 6.7). */
fun HabitStore.archivedLine(habit: Habit): String =
    startedOverAs(habit.id)?.let { "Started over as $it" } ?: archivedOn[habit.id]?.let { "Archived " + DayWords.dayMonth(it) } ?: "Archived"

/** The goal, How often and the first reminder, joined by " · " (no status). */
fun habitPlanLine(habit: Habit, weekStart: Int): String {
    if (habit.kind == HabitKind.Quit) return "Quit"
    if (habit.atMost) return HabitCopy.capitalized(HabitCopy.plan(habit, weekStart))
    val f = habit.frequency
    val parts = mutableListOf<String>()
    val much = when (val k = habit.kind) {
        HabitKind.Duration -> durationWords(habit.goal)
        is HabitKind.Amount -> HabitCopy.amount(habit.goal, k.unit)
        HabitKind.Checklist -> habit.steps.size.let { if (it == 1) "1 step" else "$it steps" }
        HabitKind.Check -> habit.checkUnit?.takeIf { it.isNotEmpty() }?.let { HabitCopy.amount(habit.goal, it) }
        else -> null
    }
    val period = when (f) { is Frequency.PerWeek -> f.n to "week"; is Frequency.PerMonth -> f.n to "month"; is Frequency.PerYear -> f.n to "year"; else -> null }
    when {
        // A count over a week, month or year: "3 times a week", or the amount: "300 push-ups a week".
        period != null -> parts += if (much != null && habit.kind != HabitKind.Checklist) "$much a ${period.second}" else countWords(period.first) + " a ${period.second}"
        f is Frequency.Flexible -> parts += HabitCopy.capitalized(HabitCopy.plan(habit, weekStart))
        // Several checks a day: "5 times a day".
        habit.kind == HabitKind.Check && habit.goal > 1 && much == null && f == Frequency.Daily -> parts += countWords(habit.goal.toInt()) + " a day"
        else -> {
            much?.let { parts += it }
            if (habit.kind == HabitKind.Check && habit.goal > 1 && much == null) parts += countWords(habit.goal.toInt()) + " a day"
            parts += if (f is Frequency.Weekdays && f.days.size in 1..6) weekdayList(f.days, weekStart)
                else HabitCopy.capitalized(HabitCopy.rhythm(f, weekStart, short = true))
        }
    }
    if (habit.remind) habit.reminders.minByOrNull { it.minuteOfDay }?.let { parts += DayWords.clockMinute(it.minuteOfDay) }
    return parts.filter { it.isNotEmpty() }.joinToString(" · ")
}

/** The days in the week's order, as Figma 1.8 lists them: "Mon, Wed, Fri". [days]: 1 is Sunday. */
private fun weekdayList(days: Set<Int>, weekStart: Int): String {
    val names = listOf("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
    return (0 until 7).map { (weekStart - 1 + it) % 7 + 1 }.filter { it in days }.joinToString(", ") { names[it - 1] }
}

/** "Once", "3 times": the Habits page says the number (Figma 1.7: "2 times a month", never "twice"). */
private fun countWords(n: Int): String = if (n == 1) "Once" else "$n times"

/** "10 min", "1 hour", "2 hours", "1 h 30 min". */
fun durationWords(minutes: Double): String {
    val total = Math.rint(minutes).toInt()
    if (total >= 60 && total % 60 == 0) return (total / 60).let { if (it == 1) "1 hour" else "$it hours" }
    return Format.minutes(minutes)
}
