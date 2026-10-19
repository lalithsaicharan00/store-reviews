package com.oftenenough.app.data

import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.Locale

// MOVE TO CORE: the Tasks page's days, lines and groups (Figma 2373:2, 19 Oct 2026).

/**
 * A one-time task with no day yet (Figma 6): it stays on the Tasks page under No date and never shows on Today. Stored
 * as the last day there is (9999-12-31), so every rule that asks "is it due?" answers no without a change to the core
 * (the core's own `dueDay` stays a plain day; `isDue` is true only on the day itself or when carried to today).
 */
const val NO_DATE_DAY = 2932896

val Habit.isTask: Boolean get() = kind == HabitKind.Task
val Habit.isOneTimeTask: Boolean get() = kind == HabitKind.Task && dueDay != null
val Habit.isRepeatingTask: Boolean get() = kind == HabitKind.Task && dueDay == null
val Habit.hasNoDate: Boolean get() = kind == HabitKind.Task && dueDay == NO_DATE_DAY

private val dayName = DateTimeFormatter.ofPattern("EEEE, d MMM", Locale.ENGLISH)
private val monthName = DateTimeFormatter.ofPattern("MMMM", Locale.ENGLISH)
private val monthYear = DateTimeFormatter.ofPattern("MMMM yyyy", Locale.ENGLISH)
private val shortDay = DateTimeFormatter.ofPattern("EEE d MMM", Locale.ENGLISH)

/** "Thu 16 Oct": the Tasks page's short day, without a comma (Figma 1); with its year when that isn't [today]'s ("Fri 28 Nov 2025"). */
fun taskDay(day: Int, today: Int? = null): String {
    val d = LocalDate.ofEpochDay(day.toLong())
    val sameYear = today == null || LocalDate.ofEpochDay(today.toLong()).year == d.year
    return d.format(shortDay) + if (sameYear) "" else " " + d.year
}

/**
 * The One-time tab's heading for a day (Figma 1): Today, Tomorrow, the next days by name ("Monday, 20 Oct"), then by
 * month ("November"; with its year when it isn't this year). [byDay] is false for the month headings.
 */
fun taskHeading(day: Int, today: Int): Pair<String, Boolean> {
    val d = LocalDate.ofEpochDay(day.toLong())
    val t = LocalDate.ofEpochDay(today.toLong())
    return when {
        day <= today -> "Today" to true
        day == today + 1 -> "Tomorrow" to true
        day <= today + 6 -> d.format(dayName) to true
        d.year == t.year -> d.format(monthName) to false
        else -> d.format(monthYear) to false
    }
}

/** A one-time task's done log, if it's done (its newest log). */
fun HabitStore.doneEntry(task: Habit): Entry? = entries(task.id).maxByOrNull { it.createdAt }

/** The time or time of day a task is for: "5:00 PM · Evening", "Morning", "10:30 AM", "Anytime". */
fun HabitStore.taskWhen(task: Habit): String {
    val part = task.parts.firstOrNull()?.takeIf { it != DaySection.ANYTIME }?.let { section(it).name }
    val time = task.dueMinute?.let { DayWords.clockMinute(it) }
    return listOfNotNull(time, part).joinToString(" · ").ifEmpty { "Anytime" }
}

/**
 * The line under a one-time task's name (Figma 1.7): the day only when its heading doesn't say it, then the time or time
 * of day. Carried from an earlier day: "Planned for Thu 16 Oct" (never red, never "overdue", U3). Done today: "Done 9:12 AM".
 */
fun HabitStore.oneTimeLine(task: Habit, today: Int): String {
    val due = task.dueDay ?: return ""
    doneEntry(task)?.let { return "Done " + DayWords.clock(it.createdAt) }
    if (due == NO_DATE_DAY) return ""
    if (due < today) return "Planned for " + taskDay(due)
    val (_, byDay) = taskHeading(due, today)
    return if (byDay) taskWhen(task) else taskDay(due) + " · " + taskWhen(task).let { if (it == "Anytime") "" else it }.ifEmpty { "Anytime" }
}

/** How often a repeating task comes, for the Repeating tab's groups (Figma 7). */
enum class TaskRhythm(val title: String) {
    DAY("Every day"), FEW_DAYS("Every few days"), WEEK("Every week"), MONTH("Every month"), LONGER("Every few months or longer")
}

fun taskRhythm(f: Frequency): TaskRhythm = when (f) {
    Frequency.Daily -> TaskRhythm.DAY
    is Frequency.EveryNDays -> if (f.n <= 1) TaskRhythm.DAY else if (f.n < 7) TaskRhythm.FEW_DAYS else if (f.n < 28) TaskRhythm.WEEK else TaskRhythm.MONTH
    is Frequency.Weekdays -> if (f.days.size >= 7) TaskRhythm.DAY else if (f.days.size > 1) TaskRhythm.FEW_DAYS else TaskRhythm.WEEK
    is Frequency.EveryNWeeks -> if (f.n <= 2) TaskRhythm.WEEK else TaskRhythm.MONTH
    is Frequency.MonthDates -> TaskRhythm.MONTH
    is Frequency.Calendar -> when (f.rule.unit) {
        GoalPeriod.DAY -> if (f.rule.interval <= 1) TaskRhythm.DAY else TaskRhythm.FEW_DAYS
        GoalPeriod.WEEK -> if (f.rule.interval <= 2) TaskRhythm.WEEK else TaskRhythm.MONTH
        GoalPeriod.MONTH -> if (f.rule.interval <= 1) TaskRhythm.MONTH else TaskRhythm.LONGER
        GoalPeriod.YEAR -> TaskRhythm.LONGER
    }
    is Frequency.AfterCompletion -> when (f.unit) {
        GoalPeriod.DAY -> if (f.n <= 1) TaskRhythm.DAY else if (f.n < 7) TaskRhythm.FEW_DAYS else TaskRhythm.WEEK
        GoalPeriod.WEEK -> if (f.n <= 2) TaskRhythm.WEEK else TaskRhythm.MONTH
        GoalPeriod.MONTH -> if (f.n <= 1) TaskRhythm.MONTH else TaskRhythm.LONGER
        GoalPeriod.YEAR -> TaskRhythm.LONGER
    }
    is Frequency.PerWeek -> TaskRhythm.WEEK
    is Frequency.PerMonth -> TaskRhythm.MONTH
    is Frequency.PerYear, is Frequency.Flexible -> TaskRhythm.LONGER
}

/** A repeating task's day now: waiting since an earlier day it wasn't done, due today, or its next day (Figma 7, 1.8). */
data class TaskNext(val waitingSince: Int?, val today: Boolean, val next: Int?, val skipped: Int?)

/** Worked out on a tap or when the page's data changes, never per frame (S5): at most 90 days back. */
fun HabitStore.taskNext(task: Habit, today: Int): TaskNext {
    var lastDue: Int? = null
    var skipped: Int? = null
    for (d in today - 1 downTo today - 90) {
        if (d < rules.startDay(task)) break
        if (rules.isDue(task, d, countingSkips = false)) {
            if (isSkipped(task, d)) { if (skipped == null) skipped = d; continue }
            lastDue = d; break
        }
    }
    val doneSince = lastDue?.let { from -> entries(task.id).any { it.day >= from } } ?: true
    val dueToday = rules.isDue(task, today) && !rules.isDone(task, today)
    val waiting = if (lastDue != null && !doneSince && !dueToday) lastDue else null
    val next = if (waiting != null || dueToday) null else nextOccurrence(task, today)
    return TaskNext(waiting, dueToday, next, skipped?.takeIf { s -> lastDue == null || s > lastDue })
}

/** A repeating task's open day: the day it waits since, today, or its next day (what Move and Skip act on). */
fun HabitStore.taskOpenDay(task: Habit, today: Int): Int? {
    val n = taskNext(task, today)
    return n.waitingSince ?: if (n.today) today else n.next
}

/**
 * The days a task can move to (Figma 3.2, 3.2.1): a one-time task any day from today; a repeating task's open day any day
 * from today until the day before its next one (the schedule itself never moves).
 */
fun HabitStore.taskMoveRange(task: Habit, today: Int): IntRange? {
    if (task.isOneTimeTask) return today..today + 3650
    val from = taskOpenDay(task, today) ?: return null
    val last = nextOccurrence(task, maxOf(from, today))?.let { it - 1 } ?: task.endsOn ?: (today + 365)
    return if (last >= today) today..last else null
}

/** The three lines under a repeating task's name (Figma 7, 2.1, 3.4.1): how often (with its time), then its day, then the last time it was done. */
fun HabitStore.repeatingLines(task: Habit, today: Int): List<String> {
    val rhythm = HabitCopy.capitalized(HabitCopy.rhythm(task.frequency, weekStart)).let { r ->
        task.dueMinute?.let { "$r, " + DayWords.clockMinute(it) } ?: r
    }
    val n = taskNext(task, today)
    val second = when {
        n.waitingSince != null -> "Waiting since " + taskDay(n.waitingSince)
        n.today -> "Today"
        n.next != null -> "Next " + taskDay(n.next, today)
        else -> null
    }
    val last = entries(task.id).maxByOrNull { it.createdAt }
    val lastWords = when {
        last == null -> null
        last.day == today -> "Last done today, " + DayWords.clock(last.createdAt)
        else -> "Last done " + taskDay(last.day, today)
    }
    val third = n.skipped?.let { s -> "Skipped " + taskDay(s) + (lastWords?.let { " · " + it.replaceFirstChar { c -> c.lowercase() } } ?: "") } ?: lastWords
    return listOfNotNull(rhythm, second, third)
}

/** The heading line on a task's details (Figma 10, 7.3, 8.6): "Today · Morning", "Every 3 days, anytime", "A task · Anytime". */
fun HabitStore.taskDetailsLine(task: Habit, today: Int): String {
    val part = task.parts.firstOrNull()?.takeIf { it != DaySection.ANYTIME }?.let { section(it).name } ?: "Anytime"
    if (task.isRepeatingTask) return HabitCopy.capitalized(HabitCopy.rhythm(task.frequency, weekStart)) + ", " + part.lowercase()
    val due = task.dueDay
    if (task.archived || doneEntry(task) != null || due == null || due == NO_DATE_DAY) return "A task · $part"
    val (heading, byDay) = taskHeading(maxOf(due, today), today)
    return (if (byDay) heading else taskDay(due)) + " · " + part
}

/** One line of a task's History (Figma 7.3, 8.6, 9.4, 10): what happened on a day, newest first. */
data class TaskEvent(val kind: Kind, val title: String, val line: String, val day: Int? = null) {
    enum class Kind { WAITING, PLANNED, DONE, SKIPPED, CREATED }
}

/** A task's History, grouped: Waiting first (a repeating task's open day), then Done (each time, done or skipped), then when it was made. */
fun HabitStore.taskHistory(task: Habit, today: Int): List<Pair<String?, List<TaskEvent>>> {
    val out = mutableListOf<Pair<String?, List<TaskEvent>>>()
    val created = TaskEvent(TaskEvent.Kind.CREATED, "Task created", taskDay(rules.calendarDayOf(task.createdAt), today) + ", " + DayWords.clock(task.createdAt))
    if (task.isRepeatingTask) {
        taskNext(task, today).waitingSince?.let { out += "Waiting" to listOf(TaskEvent(TaskEvent.Kind.WAITING, taskDay(it, today), "Not done yet", it)) }
        val done = entries(task.id).map { e -> e.day to TaskEvent(TaskEvent.Kind.DONE, taskDay(e.day, today), "Done " + DayWords.clock(e.createdAt), e.day) }
        val skips = (skips[task.id] ?: emptySet()).map { d -> d to TaskEvent(TaskEvent.Kind.SKIPPED, taskDay(d, today), "Skipped", d) }
        val all = (done + skips).sortedByDescending { it.first }.map { it.second }
        if (all.isNotEmpty()) out += "Done" to all
        out += null to listOf(created)
        return out
    }
    val due = task.dueDay
    val part = taskWhen(task)
    val events = mutableListOf<TaskEvent>()
    val e = doneEntry(task)
    if (e != null) events += TaskEvent(TaskEvent.Kind.DONE, "Done " + taskDay(e.day, today) + ", " + DayWords.clock(e.createdAt),
        (due?.takeIf { it != NO_DATE_DAY }?.let { "Planned for " + taskDay(it, today) + " · " } ?: "") + part, e.day)
    else if (due != null && due != NO_DATE_DAY) events += TaskEvent(TaskEvent.Kind.PLANNED, "Planned for " + taskDay(due, today),
        if (task.archived) "Not done" else "$part · not done yet", due)
    events += created
    out += null to events
    return out
}
