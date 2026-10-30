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

/**
 * The line under a repeating task's name (Figma's Tasks page, Repeating; Search): how often, then its day: "Every 3 days ·
 * Next 25 Oct", "Tuesdays · Next Tue 27 Oct", "Every 2 months · Next 9 Dec". Under Every day the time says more than the
 * rhythm ("8:00 AM · Next today"). Done today and not due again today: "Done today". Waiting since an earlier day it
 * wasn't done: "Waiting since Mon, 19 Oct" (never "missed", U3).
 */
fun HabitStore.repeatingLine(task: Habit, today: Int): String {
    val n = taskNext(task, today)
    if (!n.today && n.waitingSince == null && entries(task.id).any { it.day == today }) return "Done today"
    val time = task.dueMinute?.let { DayWords.clockMinute(it) }
    val first = if (taskRhythm(task.frequency) == TaskRhythm.DAY && time != null) time
        else HabitCopy.capitalized(HabitCopy.rhythm(task.frequency, weekStart))
    val second = when {
        n.waitingSince != null -> "Waiting since " + taskDay(n.waitingSince)
        n.today -> "Next today"
        n.next != null -> "Next " + taskDay(n.next, today)
        else -> null
    }
    return listOfNotNull(first, second).joinToString(" · ")
}

/**
 * The line under a task's name on its Task details (Figma 1136:9271): "One-time · Tue 4 Nov, Morning", "One-time · done
 * today", "One-time · No date"; a repeating task's rhythm and day, "Every 2 months · Next Wed 9 Dec" (never "missed", U3).
 */
fun HabitStore.taskDetailsLine(task: Habit, today: Int): String {
    if (task.isRepeatingTask) {
        val n = taskNext(task, today)
        val second = when {
            n.waitingSince != null -> "Waiting since " + taskDay(n.waitingSince, today)
            n.today -> "Next today"
            n.next != null -> "Next " + taskDay(n.next, today)
            else -> null
        }
        return listOfNotNull(HabitCopy.capitalized(HabitCopy.rhythm(task.frequency, weekStart)), second).joinToString(" · ")
    }
    doneEntry(task)?.let { return "One-time · done " + if (it.day == today) "today" else taskDay(it.day, today) }
    return "One-time · " + (taskPlannedFor(task, today) ?: "No date")
}

/** A one-time task's day with its time and time of day: "Tue 4 Nov, Morning", "Today, 5:00 PM, Evening"; null with No date. */
fun HabitStore.taskPlannedFor(task: Habit, today: Int): String? {
    val due = task.dueDay?.takeIf { it != NO_DATE_DAY } ?: return null
    val part = task.parts.firstOrNull()?.takeIf { it != DaySection.ANYTIME }?.let { section(it).name }
    val time = task.dueMinute?.let { DayWords.clockMinute(it) }
    return listOfNotNull(if (due == today) "Today" else taskDay(due, today), time, part).joinToString(", ")
}
