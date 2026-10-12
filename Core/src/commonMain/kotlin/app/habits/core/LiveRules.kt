package app.habits.core

import app.habits.rules.DaySection
import app.habits.rules.EntryIndex
import app.habits.rules.Habit
import app.habits.rules.HabitData
import app.habits.rules.HabitRules
import app.habits.rules.Rows
import app.habits.rules.StreakUnit
import app.habits.rules.Zone

/**
 * A habit as the rules see it, for Swift to hold (Current Work 92): a saved habit (by its ID) or a form's draft.
 */
class RuleHabit internal constructor(internal val habit: Habit) {
    val id: String get() = habit.id
}

/**
 * The habit rules as the apps call them (Core/spec/): the shared [HabitRules] over one live copy of the data, kept in
 * step by the app (Current Work 92, checkpoint 2). Logs change one at a time ([addEntry], [removeEntry], [replaceEntry]);
 * habits and settings are handed over whole when they change ([update]), which is rare. Everything crosses as plain
 * values (IDs, day numbers, epoch ms), so a call costs about as much as a Swift function call.
 *
 * Main thread only, like the store that owns it. Nothing here remembers an answer: the store keeps what it worked out
 * (Rulebook S5).
 */
class LiveRules(snapshot: Snapshot, settings: Map<String, String>, timeZone: String, private val clock: () -> Long) {
    private val logs = EntryIndex()
    private lateinit var rules: HabitRules
    private var handles = HashMap<String, RuleHabit>()

    init {
        for (r in snapshot.entries) if (r.deletedAt == null) RulesInput.entry(r)?.let { logs.add(it) }
        rules = build(snapshot.habits, snapshot.steps, snapshot.reminders, settings, timeZone)
    }

    private fun build(
        habits: List<HabitRecord>, steps: List<StepRecord>, reminders: List<ReminderRecord>, settings: Map<String, String>,
        timeZone: String,
    ): HabitRules {
        // The logs stay where they are: only habits and settings are read again.
        val loaded = Rows.load(habits.map(RulesInput::habitRow), steps.map(RulesInput::stepRow),
            reminders.map(RulesInput::reminderRow), emptyList(), settings, timeZone, settings["week_start"]?.toIntOrNull() ?: 1)
        val d = loaded.data
        val data = HabitData(d.habits, logs, d.skips, d.moves, d.pauses, d.rules, d.archivedOn, d.timers, d.sections, d.cardOrder)
        handles = HashMap()
        // The zone, with what it has read, carries over (habits and settings come again after many a change).
        return HabitRules(data, loaded.settings, if (::rules.isInitialized) rules.zone else null, clock)
    }

    /** Habits or settings changed. [settings] are the setting rows the rules read, exactly as saved (spec/README.md),
     *  with `day_end_hour` and `week_start` as the store counts them, and every archived habit's `archived.<id>`. */
    fun update(habits: List<HabitRecord>, steps: List<StepRecord>, reminders: List<ReminderRecord>, settings: Map<String, String>, timeZone: String) {
        rules = build(habits, steps, reminders, settings, timeZone)
    }

    fun addEntry(r: EntryRecord) { RulesInput.entry(r)?.let { logs.add(it) } }
    fun insertEntry(r: EntryRecord, position: Int) { RulesInput.entry(r)?.let { logs.insert(it, position) } }
    fun removeEntry(id: String, habitId: String) { logs.remove(id, habitId) }
    fun replaceEntry(r: EntryRecord) { RulesInput.entry(r)?.let { logs.replace(it) } }

    /** A saved habit, or null when the rules don't know it (a draft: use [draft]). */
    fun habit(id: String): RuleHabit? = handles[id] ?: rules.data.habitById[id]?.let { RuleHabit(it).also { h -> handles[id] = h } }

    /** A habit that isn't saved as it is: a form's draft, or a saved habit judged by an earlier rule. */
    fun draft(record: HabitRecord, steps: List<StepRecord>, reminders: List<ReminderRecord>): RuleHabit? =
        RulesInput.habit(record, steps, reminders)?.let { RuleHabit(it) }

    // The day (spec/day.md)
    fun today(now: Long): Int = rules.today(now)
    fun dayBounds(day: Int, zone: String?): LongArray = if (zone == null) rules.dayBounds(day) else rules.dayBounds(day, Zone(zone))
    fun dayStart(day: Int): Long = rules.dayStart(day)
    fun dayStartMoment(day: Int): Long = rules.dayStartMoment(day)
    fun startDay(h: RuleHabit): Int = rules.startDay(h.habit)
    fun quitStartDay(h: RuleHabit): Int = rules.quitStartDay(h.habit)
    /** [kind]: 1 week, 2 month, 3 year. The first and last day. */
    fun period(kind: Int, day: Int): IntArray = rules.period(app.habits.rules.Period.entries[kind], day).let { intArrayOf(it.first, it.last) }
    /** The goal's week, month or year holding [day] (the habit's own schedule), or null for a day-by-day goal. */
    fun periodRange(h: RuleHabit, day: Int): IntArray? = rules.periodRange(h.habit, day)?.let { intArrayOf(it.first, it.last) }
    /** 0 day, 1 week, 2 month, 3 year. */
    fun periodKind(h: RuleHabit): Int = rules.periodKind(h.habit).ordinal
    /** 0 days, 1 times, 2 weeks, 3 months, 4 years. */
    fun streakUnit(h: RuleHabit): Int = StreakUnit.of(h.habit.frequency).ordinal

    // Schedules (spec/schedules.md)
    fun isDue(h: RuleHabit, day: Int, now: Long, countingSkips: Boolean, followingMoves: Boolean) =
        rules.isDue(h.habit, day, now, countingSkips, followingMoves)
    fun isSkipped(h: RuleHabit, day: Int) = rules.isSkipped(h.habit, day)
    fun isPaused(h: RuleHabit, day: Int) = rules.isPaused(h.habit, day)
    fun isArchived(h: RuleHabit, day: Int) = rules.isArchived(h.habit, day)
    fun hasPause(h: RuleHabit, first: Int, last: Int) = rules.hasPause(h.habit, app.habits.rules.DayRange(first, last))

    // Goals (spec/goals.md)
    fun dayGoal(h: RuleHabit) = rules.dayGoal(h.habit)
    fun dayProgress(h: RuleHabit, day: Int, now: Long) = rules.dayProgress(h.habit, day, now)
    fun isDayMet(h: RuleHabit, day: Int) = rules.isDayMet(h.habit, day)
    fun isTotal(h: RuleHabit) = rules.isTotal(h.habit)
    fun loggedTotal(h: RuleHabit, first: Int, last: Int) = rules.loggedTotal(h.habit, app.habits.rules.DayRange(first, last))
    fun periodTotal(h: RuleHabit, first: Int, last: Int, now: Long) = rules.periodTotal(h.habit, app.habits.rules.DayRange(first, last), now)
    fun periodCount(h: RuleHabit, first: Int, last: Int) = rules.periodCount(h.habit, app.habits.rules.DayRange(first, last))
    fun progress(h: RuleHabit, day: Int, now: Long) = rules.progress(h.habit, day, now)
    fun goal(h: RuleHabit) = rules.goal(h.habit)
    fun isDone(h: RuleHabit, day: Int) = rules.isDone(h.habit, day)
    /** -1 for a goal that isn't N days a period. */
    fun flexibleProgress(h: RuleHabit, day: Int): Int = rules.flexibleProgress(h.habit, day) ?: -1
    fun isComplete(h: RuleHabit, day: Int) = rules.isComplete(h.habit, day)
    fun isSatisfied(h: RuleHabit, day: Int) = rules.isSatisfied(h.habit, day)
    fun isPeriodMet(h: RuleHabit, day: Int) = rules.isPeriodMet(h.habit, day)
    fun countsUp(h: RuleHabit, day: Int) = rules.countsUp(h.habit, day)
    fun dayFraction(h: RuleHabit, day: Int) = rules.dayFraction(h.habit, day)
    fun canSkip(h: RuleHabit) = rules.canSkip(h.habit)
    fun canPause(h: RuleHabit) = rules.canPause(h.habit)

    /** G-9: 0 done, 1 part, 2 not done, 3 open, 4 neutral; the share is [outcomeShare]. */
    fun outcome(h: RuleHabit, day: Int, today: Int): Int {
        val o = rules.outcome(h.habit, day, today)
        lastShare = o.share
        return o.kind.ordinal
    }
    /** The share reached by the last [outcome] that was part done. */
    var lastShare = 0.0
        private set

    /** P-3 over [habits]: done, planned, part count; the part is [lastPart]. */
    fun dayScore(day: Int, habits: List<RuleHabit>, today: Int): IntArray {
        val s = rules.dayScore(day, habits.map { it.habit }, today)
        lastPart = s.part
        return intArrayOf(s.done, s.planned, s.partCount)
    }
    var lastPart = 0.0
        private set

    /** P-3 for every day [first]…[last] in one call (a month of the calendar): done, planned, part count each. */
    fun dayScores(first: Int, last: Int, habits: List<RuleHabit>, today: Int): IntArray {
        val list = habits.map { it.habit }
        val count = maxOf(0, last - first + 1)
        val out = IntArray(count * 3)
        for (i in 0 until count) {
            val s = rules.dayScore(first + i, list, today)
            out[i * 3] = s.done
            out[i * 3 + 1] = s.planned
            out[i * 3 + 2] = s.partCount
        }
        return out
    }

    /** G-9: the index of the mark in done, some, missed, open, skipped, paused, not its day, upcoming, before. */
    fun dayMark(h: RuleHabit, day: Int, reference: Int): Int = rules.dayMark(h.habit, day, reference).ordinal

    /**
     * One habit's days [first]…[last] in one call, for a strip of days (the habit page's history, Progress's cards):
     * crossing into the core once per day and rule cost more than the rules themselves (Current Work 92, checkpoint 2).
     * [DAY_FIELDS] numbers a day, as [HabitRules.strip] gives them.
     */
    fun days(h: RuleHabit, first: Int, last: Int, reference: Int, now: Long): DoubleArray =
        rules.strip(h.habit, first, last, reference, now)

    // Streaks (spec/streaks.md)
    fun streak(h: RuleHabit, day: Int) = rules.streak(h.habit, day)
    fun runBefore(day: Int, h: RuleHabit) = rules.runBefore(day, h.habit)
    /** Every run, four numbers each: first day, last day, length, 1 when current. [kind]: -1 for today's goal's. */
    fun runs(h: RuleHabit, today: Int, kind: Int): IntArray {
        val list = rules.runs(h.habit, today, if (kind < 0) null else app.habits.rules.Period.entries[kind])
        val out = IntArray(list.size * 4)
        for ((i, r) in list.withIndex()) {
            out[i * 4] = r.start; out[i * 4 + 1] = r.end; out[i * 4 + 2] = r.length; out[i * 4 + 3] = if (r.isCurrent) 1 else 0
        }
        return out
    }
    fun bestStreak(h: RuleHabit) = rules.bestStreak(h.habit)

    /** ST-5: the slips, oldest first (ms). */
    fun slips(h: RuleHabit, now: Long): LongArray = rules.slips(h.habit, now).toLongArray()
    /** ST-5: every run, three numbers each: start, end (-1 while going on), ending (0 slip, 1 pause, 2 going on). */
    fun quitHistory(h: RuleHabit, now: Long): LongArray {
        val list = rules.quitHistory(h.habit, now)
        val out = LongArray(list.size * 3)
        for ((i, r) in list.withIndex()) { out[i * 3] = r.start; out[i * 3 + 1] = r.end ?: -1; out[i * 3 + 2] = r.ending.ordinal.toLong() }
        return out
    }
    /** ST-5: the current and best run, in seconds. */
    fun quitRuns(h: RuleHabit, now: Long): DoubleArray = rules.quitRuns(h.habit, now)

    // Where habits show (spec/progress.md)
    fun dayMinute(minute: Int) = rules.dayMinute(minute)
    /** P-1: the rows: each a section ID and its times (minutes after midnight, earliest first on the person's day). */
    fun placementSections(h: RuleHabit): List<String> = rules.placements(h.habit).map { it.section }
    fun placementTimes(h: RuleHabit): List<IntArray> = rules.placements(h.habit).map { it.times.toIntArray() }
    /** The section a clock minute falls in (P-1). */
    fun sectionForMinute(minute: Int): String = rules.sectionForMinute(minute).id
    fun todayCards(): List<String> = rules.todayCards()

    /** Sections the rules know, for checks: their IDs in order. */
    fun sectionIds(): List<String> = rules.data.sections.map(DaySection::id)

    internal val current: HabitRules get() = rules

    companion object {
        /** Numbers per day in [days]. */
        const val DAY_FIELDS = app.habits.rules.STRIP_FIELDS
    }
}
