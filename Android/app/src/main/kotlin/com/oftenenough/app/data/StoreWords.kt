package com.oftenenough.app.data

import java.time.ZoneId

// MOVE TO CORE: the store's words (the iPhone's Words.swift: rowLine, DayStatus, a log's description and Undo), ported
// unchanged. See Words.kt.

/** The line under a row's name: what today asks of this habit, then its time. */
fun HabitStore.rowLine(habit: Habit, day: Int, slot: String?, time: ReminderTime?, progress: Double, goal: Double, running: Boolean): String {
    if (habit.kind == HabitKind.Task) return taskLine(habit, day, weekStart)
    val t = time?.let { " · " + DayWords.clockMinute(it.minuteOfDay) } ?: ""
    if (isSkipped(habit, day)) return (if (day == today()) "Skipped today" else "Skipped") + t
    val f = habit.frequency
    if (f is Frequency.Flexible) {
        val count = rules.flexibleProgress(habit, day)
        if (count != null) {
            val days = "$count/${f.n} ${if (f.n == 1) "day" else "days"} this ${f.period.noun}"
            return (if (habit.kind == HabitKind.Check) days else goalLine(habit, progress, goal, running) + " · " + days) + t
        }
    }
    if (habit.kind == HabitKind.Check && f.isDayBased && (slot != null || goal <= 1)) {
        return HabitCopy.capitalized(HabitCopy.rhythm(f, weekStart, short = true)) + t
    }
    // A limit says where it stands in words, never in red (Figma 1.12, 1.12.1; U3).
    if (habit.atMost && goal > 0 && progress >= goal) {
        val counted = goalLine(habit, progress, goal, running).replace(" max", "")
        return (if (progress > goal) "Over the limit · " else "Limit reached · ") + counted + t
    }
    return goalLine(habit, progress, goal, running) + t
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

/** "Logged with Log manually.": where it came from, in the Log view's footer. */
fun Entry.originLine(slip: Boolean): String? {
    val s = source ?: return null
    val verb = if (slip) "Recorded" else "Logged"
    return when (s) {
        // Figma 1.8, 9.3: "Logged by hand.", "Recorded by hand."
        EntrySource.MANUAL -> if (slip) "Recorded by hand." else "Logged by hand."
        EntrySource.TODAY -> "$verb from Today."
        EntrySource.ROUTINE -> "$verb in the routine player."
        EntrySource.REMINDER -> "$verb from a reminder."
        EntrySource.TIMER -> "$verb with the timer."
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
data class DayStatus(val title: String, val detail: String? = null, val running: Long? = null) {
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
                return DayStatus("Paused", if (entries.isEmpty()) "Paused days don't count toward your streak" else "Progress already recorded stays in your history")
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
                    return if (n == 0) DayStatus("No slips recorded") else DayStatus("$n ${if (n == 1) "slip" else "slips"} recorded", "Tap a slip to see or change it")
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
                        // Met: the week's or month's goal is reached, in words (Figma 5.1, 6.1).
                        val periodName = periodWord(r.frequency).trim().removePrefix("this ").replaceFirstChar { it.uppercase() }
                        return DayStatus(HabitCopy.amount(progress, unit) + " " + dayWord,
                            if (period >= goal && periodName.isNotEmpty()) "$periodName goal reached"
                            else "${HabitCopy.number(period)} of ${HabitCopy.amount(goal, unit)}" + periodWord(r.frequency))
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
                        return DayStatus("${today(saved)} $dayWord",
                            if (r.atMost) "${text(total)}$period · limit ${text(goal)}"
                            else "${bare(total)} of ${bare(goal)}$period" + (if (total >= goal) " · Goal reached" else ""), running)
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
