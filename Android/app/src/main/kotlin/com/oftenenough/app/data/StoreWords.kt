package com.oftenenough.app.data

import java.time.ZoneId
import kotlin.math.floor

// MOVE TO CORE: the store's words (the iPhone's Words.swift: rowLine, DayStatus, a log's description and Undo), ported
// unchanged. See Words.kt.

/**
 * The line under a row's name (Figma's Today, flow 49 "What a row's second line says"): the goal for its period, never
 * the schedule — Not done (a check), 5/8 glasses, 4/10 min, 1/4 steps, 2/3 times, 2/3 this week. With a reminder still
 * to come today, " | " and the next one's time; once done the line says Done (or 8/8 glasses) and the time goes,
 * because there's nothing left to remind.
 */
fun HabitStore.rowLine(habit: Habit, day: Int, slot: String?, time: ReminderTime?, progress: Double, goal: Double, running: Boolean): String {
    if (habit.kind == HabitKind.Task) return taskLine(habit, day, weekStart)
    if (isSkipped(habit, day)) return if (day == today()) "Skipped today" else "Skipped"
    val done = slot?.let { isSlotDone(habit, it, day) } ?: (rules.isDone(habit, day) && !habit.atMost)
    val t = if (time == null || done) "" else " | " + DayWords.clockMinute(nextReminder(habit, day, time).minuteOfDay)
    val f = habit.frequency
    if (f is Frequency.Flexible) {
        val count = rules.flexibleProgress(habit, day)
        if (count != null) {
            val days = "$count/${f.n} ${if (f.n == 1) "day" else "days"} this ${f.period.noun}"
            return (if (habit.kind == HabitKind.Check) days else goalLine(habit, progress, goal, running) + " · " + days) + t
        }
    }
    if (habit.kind == HabitKind.Check && f.isDayBased && (slot != null || goal <= 1)) return (if (done) "Done" else "Not done") + t
    // A limit says where it stands in words, never in red (Figma 1.12, 1.12.1; U3): "0 of 2 cups · 2 left",
    // "Limit reached · 2 of 2 cups", "Over the limit · 3 of 2 cups"; a running timer "12:40 · 17 min left".
    if (habit.atMost && goal > 0 && day <= today()) return limitLine(habit, progress, goal, running) + t
    return goalLine(habit, progress, goal, running) + t
}

private fun limitLine(habit: Habit, progress: Double, goal: Double, running: Boolean): String {
    val period = when (habit.frequency) { is Frequency.PerWeek -> " this week"; is Frequency.PerMonth -> " this month"; is Frequency.PerYear -> " this year"; else -> "" }
    val minutes = habit.kind == HabitKind.Duration
    val done = if (minutes) floor(progress) else progress
    val counted = if (minutes) "${Format.amount(done)} of ${Format.minutes(goal)}$period"
        else when (val k = habit.kind) {
            is HabitKind.Amount -> if (k.unit in HabitCopy.currencies) "${k.unit}${Format.amount(done)} of ${k.unit}${Format.amount(goal)}$period"
                else "${Format.amount(done)} of ${Format.amount(goal)}${if (k.unit.isEmpty()) "" else " " + k.unit}$period"
            else -> "${Format.amount(done)} of ${Format.amount(goal)}${habit.checkUnit?.let { " $it" } ?: ""}$period"
        }
    return when {
        progress > goal -> "Over the limit · " + if (running) Format.clock(progress) else counted
        progress >= goal -> "Limit reached · " + if (running) Format.clock(progress) else counted
        running -> Format.clock(progress) + " · " + Format.minutes(floor(goal - progress)) + " left"
        else -> "$counted · ${Format.amount(goal - done)} left"
    }
}

/** With several reminders, the next one still to come today (Skincare's 9:00 PM after its 8:00 AM); else [first]. */
private fun HabitStore.nextReminder(habit: Habit, day: Int, first: ReminderTime): ReminderTime {
    if (day != today() || habit.reminders.size < 2) return first
    val zone = java.time.ZoneId.systemDefault()
    val nowTime = java.time.Instant.ofEpochMilli(clock()).atZone(zone).toLocalTime()
    val minute = nowTime.hour * 60 + nowTime.minute
    return habit.reminders.sortedBy { it.minuteOfDay }.firstOrNull { it.minuteOfDay > minute } ?: first
}

/** One day's result, never a weekly total labelled Today. */
fun HabitStore.dayResult(habit: Habit, day: Int): String {
    if (isPaused(habit, day)) return "Paused"
    if (isSkipped(habit, day)) return "Skipped"
    if (day < rules.startDay(habit)) return "Before it started"
    val r = rule(habit, day)
    val progress = rules.dayProgress(r, day)
    val goal = rules.dayGoal(r)
    if (!r.frequency.isDayBased && !r.frequency.isFlexible) {
        when (val k = r.kind) {
            is HabitKind.Amount -> return HabitCopy.amount(progress, k.unit) + " logged"
            HabitKind.Duration -> return Format.minutes(progress) + " logged"
            HabitKind.Check -> return HabitCopy.amount(progress, r.checkUnit ?: "times") + " logged"
            else -> {}
        }
    }
    if (r.atMost) {
        if (r.kind == HabitKind.Duration) return "${Format.minutes(progress)} logged · limit ${Format.minutes(goal)}"
        (r.kind as? HabitKind.Amount)?.let { return "${HabitCopy.amount(progress, it.unit)} logged · limit ${HabitCopy.amount(goal, it.unit)}" }
    }
    return when (r.kind) {
        HabitKind.Quit -> if (entries(habit.id, day).isEmpty()) "No slips" else "Slipped"
        HabitKind.Task -> if (progress > 0) "Done" else "Not done"
        HabitKind.Check -> if (goal <= 1) (if (progress > 0) "Done" else "Not done") else goalLine(r.copy(frequency = Frequency.Daily), progress, goal)
        else -> goalLine(r.copy(frequency = Frequency.Daily), progress, goal)
    }
}

/** What one log is: "2 glasses", "20 min", "Slip", "Check", "Done", or a step's name. */
fun Entry.description(habit: Habit): String {
    if (stepId != null) return habit.steps.firstOrNull { it.id == stepId }?.name ?: "Checklist step"
    return when (val k = habit.kind) {
        is HabitKind.Amount -> HabitCopy.amount(value, k.unit)
        HabitKind.Duration -> if (value < 1) "${HabitCopy.number(kotlin.math.floor(value * 60))} sec" else Format.minutes(kotlin.math.floor(value))
        HabitKind.Quit -> "Slip"
        HabitKind.Check -> if (value == 1.0) "Check" else HabitCopy.amount(value, habit.checkUnit ?: "checks")
        HabitKind.Task -> "Done"
        HabitKind.Checklist -> "Step checked"
    }
}

/** Says what Undo takes back: "Undo +1 glass", "Undo 20 min", "Undo Done", "Undo Slip", "Undo Last Step". */
fun Entry.undoLabel(habit: Habit): String {
    if (stepId != null) return "Undo Last Step"
    return when (habit.kind) {
        is HabitKind.Amount -> "Undo +" + description(habit)
        HabitKind.Duration -> "Undo " + description(habit)
        HabitKind.Check -> if (habit.frequency.isDayBased && habit.goal > 1)
            "Undo +" + (habit.checkUnit?.let { HabitCopy.amount(value, it) } ?: HabitCopy.number(value)) else "Undo Done"
        HabitKind.Task -> "Undo Done"
        HabitKind.Quit -> "Undo Slip"
        HabitKind.Checklist -> "Undo"
    }
}

/** Whether this log has a fact of its own to see and correct in the Log view (U19). */
fun Entry.opensRecord(habit: Habit): Boolean {
    if (stepId != null) return false
    return when (habit.kind) {
        is HabitKind.Amount, HabitKind.Duration, HabitKind.Quit -> true
        HabitKind.Check -> value != 1.0
        HabitKind.Task, HabitKind.Checklist -> false
    }
}

/** Where a log came from, in the Log view's footer: "Added by hand at 2:05 PM.", "From the timer. Started 2:09 PM.". */
fun Entry.originLine(slip: Boolean): String? {
    // Figma's Log screen, View (687:829): a slip says what it did; a log by hand when it was added; a timer's when it began.
    if (slip) return "Your run started again from this slip."
    val s = source ?: return null
    val verb = "Logged"
    return when (s) {
        EntrySource.MANUAL -> "Added by hand at ${DayWords.clock(createdAt)}."
        EntrySource.TIMER -> "From the timer. Started ${DayWords.clock(createdAt - (value * 60_000).toLong())}."
        EntrySource.TODAY -> "$verb from Today."
        EntrySource.ROUTINE -> "$verb in the routine player."
        EntrySource.REMINDER -> "$verb from a reminder."
        EntrySource.DAY_SHEET -> "$verb in Day details."
        EntrySource.SHORTCUT -> "$verb with Google Assistant or a shortcut."
        EntrySource.WIDGET -> "$verb from a widget."
        EntrySource.WATCH -> "$verb on a watch."
    }
}

/** A log's clock time where it was recorded, with that zone's name when it isn't the phone's own. */
fun clockText(entry: Entry): String {
    val zone = runCatching { ZoneId.of(entry.timeZone) }.getOrDefault(ZoneId.systemDefault())
    val text = DayWords.clock(entry.createdAt, zone)
    return if (zone.normalized() == ZoneId.systemDefault().normalized()) text else text + " " + zone.id
}

/** The day's status in Day details: its title ("4 of 8 glasses"), the line under it, and a running timer's start. */
/**
 * [words]: the title is one headline, its number never set apart ("1 slip recorded", Figma's Day details). [label]: what
 * the card says above it instead of "This day" ("Back on Wed, 28 Oct" for a paused day).
 */
data class DayStatus(val title: String, val detail: String? = null, val running: Long? = null, val words: Boolean = false, val label: String? = null) {
    companion object {
        fun periodWord(f: Frequency): String = when (f) {
            is Frequency.PerWeek -> " this week"
            is Frequency.PerMonth -> " this month"
            is Frequency.PerYear -> " this year"
            is Frequency.Flexible -> when (f.period) { GoalPeriod.WEEK -> " this week"; GoalPeriod.MONTH -> " this month"; GoalPeriod.YEAR -> " this year"; GoalPeriod.DAY -> "" }
            else -> ""
        }

        fun make(habit: Habit, day: Int, store: HabitStore): DayStatus {
            val isToday = day == store.today()
            val dayWord = if (isToday) "today" else "this day"
            val shortDay = DayWords.short(day)
            val r = store.rule(habit, day)
            val rules = store.rules
            val entries = store.entries(habit.id, day).filter { it.stepId == null }
            if (store.isPaused(habit, day)) {
                // When it's back, in the card's label (Figma's Day details, Paused): "Back on Wed, 28 Oct", or "Until you resume it".
                val back = store.pause(habit, day)?.through?.let { "Back on " + DayWords.short(it + 1) } ?: "Until you resume it"
                return DayStatus("Paused", label = back)
            }
            if (store.isSkipped(habit, day)) {
                val total = entries.sumOf { it.value }
                val saved = if (entries.isEmpty()) null else when (val k = r.kind) {
                    is HabitKind.Amount -> HabitCopy.amount(total, k.unit) + " saved"
                    HabitKind.Duration -> Format.minutes(kotlin.math.floor(total)) + " saved"
                    HabitKind.Check -> if (rules.countsUp(habit, day)) HabitCopy.amount(total, r.checkUnit ?: "checks") + " saved" else null
                    else -> null
                }
                return DayStatus("Skipped", (saved?.let { "$it · " } ?: "") + "Doesn't count toward your streak")
            }
            if (day < rules.startDay(habit)) return DayStatus("Before it started")
            // A later day plans (Figma 1.4): what the day asks, "For Tue, 13 Oct"; logging waits for the day.
            if (day > store.today()) {
                val goal = rules.dayGoal(r)
                val planned = when (val k = r.kind) {
                    is HabitKind.Amount -> if (r.frequency.isDayBased && !r.atMost) HabitCopy.amount(goal, k.unit) + " planned" else "Planned"
                    HabitKind.Duration -> if (r.frequency.isDayBased && !r.atMost) Format.minutes(goal) + " planned" else "Planned"
                    HabitKind.Checklist -> "${r.steps.size} ${if (r.steps.size == 1) "step" else "steps"} planned"
                    HabitKind.Check -> if (rules.countsUp(habit, day)) HabitCopy.amount(goal, r.checkUnit ?: "times") + " planned" else "Planned"
                    else -> "Planned"
                }
                return DayStatus(planned, "For $shortDay")
            }
            // A day it isn't planned (Figma 3.3): said plainly, and it can still be logged.
            if (r.kind != HabitKind.Task && r.kind != HabitKind.Quit && r.frequency.isDayBased && !r.frequency.isFlexible &&
                !rules.isDue(habit, day, countingSkips = false)) {
                // Figma: "Run is planned on Mon, Wed and Fri."; "every day except Sun" and "on weekdays" stay as they are.
                val days = HabitCopy.rhythm(r.frequency, store.weekStart, short = true)
                val on = if (days.startsWith("every ") && !days.startsWith("every day")) "on " + days.removePrefix("every ") else days
                return DayStatus("Not planned", "${habit.name} is planned $on. You can still log it.")
            }
            when (r.kind) {
                HabitKind.Quit -> {
                    val n = entries.size
                    return if (n == 0) DayStatus("No slips recorded") else DayStatus("$n ${if (n == 1) "slip" else "slips"} recorded", "Tap a slip to see or change it", words = true)
                }
                HabitKind.Task -> {
                    val done = rules.isDone(habit, day)
                    val last = (if (r.dueDay == null) entries else store.entries(habit.id)).lastOrNull()
                    if (!done || last == null) return DayStatus(if (done) "Done" else "Not done")
                    val whenText = if (last.day == day) clockText(last) else DayWords.short(last.day) + " at " + clockText(last)
                    return DayStatus("Done", "Completed " + (if (last.day == day) "at " else "on ") + whenText)
                }
                HabitKind.Checklist -> {
                    val done = rules.dayProgress(r, day).toInt()
                    val all = r.steps.size
                    val left = all - done
                    return DayStatus("$done of $all steps done", if (left <= 0) "All steps done" else if (left == 1) "One step left" else "$left steps left")
                }
                HabitKind.Check -> {
                    val unit = r.checkUnit ?: "times"
                    val progress = rules.dayProgress(r, day)
                    if (!r.frequency.isDayBased) {
                        val period = rules.progress(habit, day)
                        val goal = rules.goal(habit)
                        val periodText = periodWord(r.frequency)
                        // Once a week or month (Deep clean): Not done yet, any day in it; or Done this month and when.
                        if (goal <= 1) {
                            val span = rules.period(when (r.frequency) { is Frequency.PerWeek -> PeriodKind.WEEK; is Frequency.PerMonth -> PeriodKind.MONTH; else -> PeriodKind.YEAR }, day)
                            val last = store.entries(habit.id).filter { it.value > 0 && it.day in span }.maxByOrNull { it.createdAt }
                            val month = java.time.LocalDate.ofEpochDay(day.toLong()).month.getDisplayName(java.time.format.TextStyle.FULL, java.util.Locale.ENGLISH)
                            if (last == null) return DayStatus("Not done yet", "Any day " + (if (r.frequency is Frequency.PerMonth) "in $month" else periodText.trim()))
                            val at = if (last.day == store.today()) "today at " + clockText(last) else "on " + DayWords.short(last.day)
                            return DayStatus("Done" + periodText, "Done $at")
                        }
                        // Several times a week or month (Call family): "2 of 3 this week", "1 to go" (Figma's Day details).
                        return DayStatus("${HabitCopy.number(period)} of ${HabitCopy.number(goal)}$periodText",
                            if (period >= goal) "Goal reached" else "${HabitCopy.number(goal - period)} to go")
                    }
                    if (rules.countsUp(habit, day)) {
                        val goal = rules.dayGoal(r)
                        val left = goal - progress
                        val detail = if (left <= 0) "Goal reached" else if (isToday) (if (left == 1.0) "One more reaches today's goal" else "${HabitCopy.number(left)} more reach today's goal") else "For $shortDay"
                        return DayStatus("${HabitCopy.number(progress)} of ${HabitCopy.amount(goal, unit)}", detail)
                    }
                    val done = rules.isDayMet(r, day)
                    val f = r.frequency
                    if (f is Frequency.Flexible) {
                        val count = rules.flexibleProgress(habit, day)
                        if (count != null) return DayStatus(if (done) "Done" else "Not done", "$count of ${f.n} ${if (f.n == 1) "day" else "days"}" + periodWord(f))
                    }
                    val last = entries.lastOrNull()
                    if (done && last != null) return DayStatus("Done", "Checked at " + clockText(last))
                    return DayStatus(if (done) "Done" else "Not done")
                }
                is HabitKind.Amount, HabitKind.Duration -> {
                    val timed = r.kind == HabitKind.Duration
                    val unit = r.unit
                    fun text(v: Double) = if (timed) Format.minutes(kotlin.math.floor(v)) else HabitCopy.amount(v, unit)
                    // A period's total says its numbers only ("150 of 300 this week"; money keeps its sign; Figma 16–18).
                    fun bare(v: Double) = if (timed) Format.minutes(kotlin.math.floor(v)) else if (unit.trim() in HabitCopy.currencies) HabitCopy.amount(v, unit) else HabitCopy.number(v)
                    // Today's time, in minutes, so the big number reads "90 min today" (Figma 18).
                    fun today(v: Double) = if (timed) "${kotlin.math.floor(v).toLong()} min" else HabitCopy.amount(v, unit)
                    val saved = entries.sumOf { it.value }
                    val running = if (timed && isToday) store.timers[habit.id] else null
                    val goal = rules.dayGoal(r)
                    if (rules.isTotal(r)) {
                        val total = rules.progress(habit, day)
                        val period = periodWord(r.frequency)
                        if (r.atMost) return DayStatus("${today(saved)} $dayWord", "${text(total)}$period · limit ${text(goal)}", running)
                        // Figma's Day details for a week's or month's total (Push-ups, Savings, Piano): the card is This
                        // week or This month, the period's total over its goal — "140 of 300 this week", "$250 of $500",
                        // "1 h 40 of 3 h" — and what's left at the end of the line: "160 to go", or Goal reached.
                        val money = unit.trim() in HabitCopy.currencies
                        fun short(v: Double) = if (timed) Format.minutes(kotlin.math.floor(v)).removeSuffix(" min").let { if (it.contains(" h ")) it else Format.minutes(kotlin.math.floor(v)) } else bare(v)
                        val title = "${short(total)} of ${short(goal)}" + (if (timed || money) "" else period)
                        return DayStatus(title, if (running != null) null else if (total >= goal) "Goal reached" else "${short(goal - total)} to go", running)
                    }
                    // A limit says where it stands in words, never in red (Figma 10–11.3, U3).
                    if (r.atMost) return DayStatus("${today(saved)} $dayWord", "Limit ${text(goal)} · " + when {
                        saved > goal -> "Over the limit"; saved >= goal -> "Limit reached"; else -> "within max"
                    }, running)
                    val title = if (timed) {
                        if (goal < 60 && saved < 60) "${kotlin.math.floor(saved).toInt()} of ${Format.minutes(goal)}" else "${text(saved)} of ${Format.minutes(goal)}"
                    } else if (unit.trim() in HabitCopy.currencies) "${HabitCopy.amount(saved, unit)} of ${HabitCopy.amount(goal, unit)}"
                    else "${HabitCopy.number(saved)} of ${HabitCopy.amount(goal, unit)}"
                    var detail: String? = if (running != null) null else if (saved >= goal) "Goal reached" else if (isToday) "${text(goal - (if (timed) kotlin.math.floor(saved) else saved))} to go" else "For $shortDay"
                    val f = r.frequency
                    if (f is Frequency.Flexible) {
                        val count = rules.flexibleProgress(habit, day)
                        if (count != null) {
                            val days = "$count of ${f.n} ${if (f.n == 1) "day" else "days"}" + periodWord(f)
                            detail = detail?.let { "$it · $days" } ?: days
                        }
                    }
                    return DayStatus(title, detail, running)
                }
            }
        }
    }
}
