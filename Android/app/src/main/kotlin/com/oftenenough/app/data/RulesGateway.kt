package com.oftenenough.app.data

import app.habits.core.RulesInput
import app.habits.rules.DayRange
import app.habits.rules.DaySettings
import app.habits.rules.EntryIndex
import app.habits.rules.HabitData
import app.habits.rules.HabitRules
import app.habits.rules.Period
import app.habits.rules.Rows
import app.habits.rules.Zone

// THE ADAPTER (Android build prompt §0): every call into the shared habit rules (Core/rules, `app.habits.rules`, and the
// core's `RulesInput` / `Rows`) goes through this file and its extensions beside it (`RulesGateway+*.kt`), and only them. Screens, view models and the store never import the rules;
// when the other agent's `claude/shared-habit-rules-switch` lands on main and changes the rules' API (`LiveRules`,
// `RulesInput`, `Rows`), only this file changes.

/** One habit's day (G-9): done, part (with the share reached), not done, open, or neutral. */
data class Outcome(val kind: Kind, val share: Double) {
    enum class Kind { DONE, PART, NOT_DONE, OPEN, NEUTRAL }
}

/** One day across habits (P-3). */
data class DayScore(val done: Int = 0, val part: Double = 0.0, val partCount: Int = 0, val planned: Int = 0) {
    val fraction: Double get() = if (planned == 0) 0.0 else minOf(1.0, (done + part) / planned)
    val isFull: Boolean get() = planned > 0 && done == planned
}

/** How a day reads in a habit's calendar (never a harsh mark, U3). */
enum class DayMark { DONE, SOME, MISSED, OPEN, SKIPPED, PAUSED, NOT_ITS_DAY, UPCOMING, BEFORE }

/** A run of met days (or weeks, months, years). */
data class Run(val start: Int, val end: Int, val length: Int, val isCurrent: Boolean)

/** One run of a quit habit ([end] null: going on now). */
data class QuitRun(val start: Long, val end: Long?, val ending: Ending) {
    enum class Ending { SLIP, PAUSE, ONGOING }
    fun seconds(now: Long): Double = maxOf(0L, (end ?: now) - start) / 1000.0
}

/** Where a habit shows on Today: a time of day and the times that belong to that row, earliest first on the person's day. */
data class Placement(val section: String, val slot: String?, val times: List<ReminderTime>)

enum class PeriodKind { WEEK, MONTH, YEAR }

class RulesGateway(private val clock: () -> Long) {
    private val logs = EntryIndex()
    /** The shared rules. Only the adapter's files (`RulesGateway*.kt`) read it. */
    internal var rules = HabitRules(HabitData(emptyList(), logs), DaySettings(), clock = clock); private set
    /** The rules' copy of each saved habit, with the app's habit it was made from (a changed habit is made again). */
    private var known = HashMap<String, Pair<Habit, app.habits.rules.Habit>>()

    /** Habits or the settings the rules read changed (rare): read again. [settings] are the setting rows exactly as saved. */
    fun reload(habits: List<Habit>, settings: Map<String, String>, timeZone: String, defaultWeekStart: Int) {
        val records = habits.mapIndexed { i, h -> h.record(i, h.createdAt) }
        val loaded = Rows.load(
            records.map(RulesInput::habitRow),
            habits.flatMap { it.stepRecords() }.map(RulesInput::stepRow),
            habits.flatMap { it.reminderRecords() }.map(RulesInput::reminderRow),
            emptyList(), settings, timeZone, defaultWeekStart,
        )
        val d = loaded.data
        rules = HabitRules(HabitData(d.habits, logs, d.skips, d.moves, d.pauses, d.rules, d.archivedOn, d.timers, d.sections, d.cardOrder), loaded.settings, reuse = rules.zone, clock = clock)
        known = HashMap()
        for (h in habits) d.habitById[h.id]?.let { known[h.id] = h to it }
    }

    // ------------------------------------------------------------------ Logs, one at a time (S5)

    fun setEntries(entries: List<Entry>) {
        logs.clear()
        for (e in entries.sortedBy { it.createdAt }) rulesEntry(e)?.let { logs.add(it) }
    }
    fun addEntry(e: Entry) { rulesEntry(e)?.let { logs.add(it) } }
    fun insertEntry(e: Entry, position: Int) { rulesEntry(e)?.let { logs.insert(it, position) } }
    fun removeEntry(id: String, habitId: String) { logs.remove(id, habitId) }
    fun replaceEntry(e: Entry) { rulesEntry(e)?.let { logs.replace(it) } }

    private fun rulesEntry(e: Entry) = RulesInput.entry(e.record)

    /** The rules' habit for [habit]: the saved one, or a draft made from it (a form's preview, an edit not saved yet). */
    internal fun r(habit: Habit): app.habits.rules.Habit {
        known[habit.id]?.let { (app, rule) -> if (app === habit || app == habit) return rule }
        return RulesInput.habit(habit.record(0, habit.createdAt), habit.stepRecords(), habit.reminderRecords())
            ?: RulesInput.habit(habit.copy(frequency = Frequency.Daily).record(0, habit.createdAt), habit.stepRecords(), habit.reminderRecords())!!
    }

    internal fun range(r: DayRange) = r.first..r.last
    internal fun range(r: IntRange) = DayRange(r.first, r.last)

    // ------------------------------------------------------------------ The day (spec/day.md)

    val dayEndHour: Int get() = rules.settings.dayEndHour
    val weekStart: Int get() = rules.settings.weekStart

    fun today(now: Long = clock()): Int = rules.today(now)
    /** The first and last moment of a day ([zone] the log's own, when it isn't the phone's). */
    fun dayBounds(day: Int, zone: String? = null): LongRange =
        (if (zone == null) rules.dayBounds(day) else rules.dayBounds(day, Zone(zone))).let { it[0]..it[1] }
    fun dayStart(day: Int): Long = rules.dayStart(day)
    fun dayStartMoment(day: Int): Long = rules.dayStartMoment(day)
    fun period(kind: PeriodKind, day: Int): IntRange = range(rules.period(Period.valueOf(kind.name), day))
    fun periodRange(habit: Habit, day: Int): IntRange? = rules.periodRange(r(habit), day)?.let(::range)
    fun periodKind(habit: Habit): GoalPeriod = GoalPeriod.valueOf(rules.periodKind(r(habit)).name)
    fun startDay(habit: Habit): Int = rules.startDay(r(habit))
    fun quitStartDay(habit: Habit): Int = rules.quitStartDay(r(habit))
    /** Which calendar day a moment falls on in the phone's zone (midnight to midnight). */
    fun calendarDayOf(ms: Long): Int = rules.zone.dayOf(ms)

    // ------------------------------------------------------------------ Schedules (spec/schedules.md)

    fun isDue(habit: Habit, day: Int, now: Long = clock(), countingSkips: Boolean = true, followingMoves: Boolean = true) =
        rules.isDue(r(habit), day, now, countingSkips, followingMoves)
    fun isSkipped(habit: Habit, day: Int) = rules.isSkipped(r(habit), day)
    fun isPaused(habit: Habit, day: Int) = rules.isPaused(r(habit), day)
    fun isArchived(habit: Habit, day: Int) = rules.isArchived(r(habit), day)
    fun canSkip(habit: Habit) = rules.canSkip(r(habit))
    fun canPause(habit: Habit) = rules.canPause(r(habit))

    // ------------------------------------------------------------------ Goals (spec/goals.md)

    fun dayGoal(habit: Habit) = rules.dayGoal(r(habit))
    fun dayProgress(habit: Habit, day: Int, now: Long = clock()) = rules.dayProgress(r(habit), day, now)
    fun isDayMet(habit: Habit, day: Int) = rules.isDayMet(r(habit), day)
    fun isTotal(habit: Habit) = rules.isTotal(r(habit))
    fun loggedTotal(habit: Habit, days: IntRange) = rules.loggedTotal(r(habit), range(days))
    fun periodTotal(habit: Habit, days: IntRange, now: Long = clock()) = rules.periodTotal(r(habit), range(days), now)
    fun periodCount(habit: Habit, days: IntRange) = rules.periodCount(r(habit), range(days))
    fun progress(habit: Habit, day: Int, now: Long = clock()) = rules.progress(r(habit), day, now)
    fun goal(habit: Habit) = rules.goal(r(habit))
    fun isDone(habit: Habit, day: Int) = rules.isDone(r(habit), day)
    fun flexibleProgress(habit: Habit, day: Int): Int? = rules.flexibleProgress(r(habit), day)
    fun isComplete(habit: Habit, day: Int) = rules.isComplete(r(habit), day)
    fun isSatisfied(habit: Habit, day: Int) = rules.isSatisfied(r(habit), day)
    fun isPeriodMet(habit: Habit, day: Int) = rules.isPeriodMet(r(habit), day)
    fun countsUp(habit: Habit, day: Int) = rules.countsUp(r(habit), day)
    fun dayFraction(habit: Habit, day: Int) = rules.dayFraction(r(habit), day)
    fun isStepDone(stepId: String, habit: Habit, day: Int) = rules.isStepDone(stepId, r(habit), day)

    // ------------------------------------------------------------------ How a day counts (spec/progress.md)

    fun outcome(habit: Habit, day: Int, today: Int = today()): Outcome {
        val o = rules.outcome(r(habit), day, today)
        return Outcome(Outcome.Kind.valueOf(o.kind.name), o.share)
    }

    fun dayScore(day: Int, habits: List<Habit>, today: Int = today()): DayScore {
        val s = rules.dayScore(day, habits.map(::r), today)
        return DayScore(s.done, s.part, s.partCount, s.planned)
    }

    fun dayMark(habit: Habit, day: Int, reference: Int = today()): DayMark = DayMark.valueOf(rules.dayMark(r(habit), day, reference).name)

    // ------------------------------------------------------------------ Streaks (spec/streaks.md)

    fun streak(habit: Habit, day: Int) = rules.streak(r(habit), day)
    fun runBefore(day: Int, habit: Habit) = rules.runBefore(day, r(habit))
    fun runs(habit: Habit, today: Int = today(), kind: GoalPeriod? = null): List<Run> =
        rules.runs(r(habit), today, kind?.let { Period.valueOf(it.name) }).map { Run(it.start, it.end, it.length, it.isCurrent) }
    fun bestStreak(habit: Habit) = rules.bestStreak(r(habit))

    fun slips(habit: Habit, now: Long = clock()): List<Long> = rules.slips(r(habit), now)
    fun quitHistory(habit: Habit, now: Long = clock()): List<QuitRun> =
        rules.quitHistory(r(habit), now).map { QuitRun(it.start, it.end, QuitRun.Ending.valueOf(it.ending.name)) }
    /** The current and best run, in seconds. */
    fun quitRuns(habit: Habit, now: Long = clock()): Pair<Double, Double> = rules.quitRuns(r(habit), now).let { it[0] to it[1] }

    // ------------------------------------------------------------------ Where habits show (P-1, P-2)

    fun dayMinute(minute: Int) = rules.dayMinute(minute)
    fun sectionForMinute(minute: Int): String = rules.sectionForMinute(minute).id
    fun placements(habit: Habit): List<Placement> = rules.placements(r(habit)).map { p ->
        Placement(p.section, p.slot, p.times.mapNotNull { m -> habit.reminders.firstOrNull { it.minuteOfDay == m } })
    }
    fun todayCards(): List<String> = rules.todayCards()
    /** Every habit and task each card holds, whatever the day, in the person's order: card → habit IDs. */
    fun cardMembers(): Map<String, List<String>> = rules.cardMembers().mapValues { (_, list) -> list.map { it.id } }
}
