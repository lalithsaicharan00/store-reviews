package app.habits.rules

import kotlin.math.max
import kotlin.math.min

/**
 * The habit rules (Core/spec/): which day a moment belongs to, which days a habit is due, what its goal is and whether it
 * was met, streaks and runs, quit runs, how a day counts across habits, and where a habit shows on Today. One copy for
 * iPhone, iPad, Apple Watch, Mac and Android (Architecture/Shared Core Decision.md).
 *
 * Pure: everything comes from [data], [settings] and [clock] ("now", epoch ms). Each function answers exactly as the
 * iPhone's `HabitStore` function of the same name did on 12 October 2026 (Core/fixtures/ proves it). Nothing here
 * remembers anything: the caller works a number out once per change and keeps it (Rulebook S5).
 */
class HabitRules(val data: HabitData, val settings: DaySettings, val clock: () -> Long) {
    val zone = Zone(settings.timeZone)
    private val dayEnd = settings.dayEndHour.coerceIn(0, 12)

    // ------------------------------------------------------------------ The day (spec/day.md)

    /** DAY-1, DAY-2: the person's day at a moment: its calendar date, or the day before while the clock is before the
     *  day's start hour. On the wall clock, never by subtracting hours (DAY-3). */
    fun today(now: Long = clock()): Int {
        val day = zone.dayOf(now)
        if (dayEnd == 0) return day
        return if (zone.hourOf(now) < dayEnd) day - 1 else day
    }

    /** DAY-5: the first and last moment (ms; the last is one second before the next day starts) of a day. */
    fun dayBounds(day: Int, recording: Zone = zone): LongArray {
        val start = recording.at(day, dayEnd)
        val end = recording.at(day + 1, dayEnd) - 1000
        return longArrayOf(start, end)
    }

    /** DAY-11: when a day begins on the clock (a quit habit's resumed run starts here). */
    fun dayStart(day: Int): Long = zone.at(day, dayEnd)

    /** DAY-11: the habit page's "day start" for quit statistics: midnight plus the day-start hours (not on the clock). */
    fun dayStartMoment(day: Int): Long = zone.at(day, 0) + dayEnd * 3_600_000L

    /** DAY-6: the week, month or year holding [day]. */
    fun period(kind: Period, day: Int): DayRange = when (kind) {
        Period.WEEK -> Day.weekStart(day, settings.weekStart).let { DayRange(it, it + 6) }
        Period.MONTH -> DayRange(Day.monthStart(day), Day.monthEnd(day))
        Period.YEAR -> DayRange(Day.yearStart(day), Day.yearEnd(day))
        Period.DAY -> DayRange(day, day)
    }

    /** DAY-9: the first day a habit counts: its start date, or the calendar date it was made (not moved by the day start). */
    fun startDay(habit: Habit): Int = habit.startsOn ?: zone.dayOf(habit.createdAt)

    /** DAY-10: the first day a quit habit counts from. */
    fun quitStartDay(habit: Habit): Int = today(min(habit.createdAt, habit.quitSince ?: habit.createdAt))

    // ------------------------------------------------------------------ Goal history (spec/schedules.md S-6)

    /** The habit as it was judged on [day]: the first earlier rule whose last day is on or after it, else today's. */
    fun rule(habit: Habit, day: Int): Habit {
        val list = data.rules[habit.id] ?: return habit
        val r = list.firstOrNull { day <= it.until } ?: return habit
        return habit.judgedBy(r.judging)
    }

    fun periodKind(habit: Habit): Period = when (val f = habit.frequency) {
        is Frequency.PerWeek -> Period.WEEK
        is Frequency.PerMonth -> Period.MONTH
        is Frequency.PerYear -> Period.YEAR
        is Frequency.Flexible -> f.period
        else -> Period.DAY
    }

    fun periodRange(habit: Habit, day: Int): DayRange? = when (val f = habit.frequency) {
        is Frequency.Flexible -> period(f.period, day)
        is Frequency.PerWeek -> period(Period.WEEK, day)
        is Frequency.PerMonth -> period(Period.MONTH, day)
        is Frequency.PerYear -> period(Period.YEAR, day)
        else -> null
    }

    // ------------------------------------------------------------------ Days off (spec/schedules.md S-7)

    fun isSkipped(habit: Habit, day: Int) = data.skips[habit.id]?.contains(day) == true
    fun isPaused(habit: Habit, day: Int) = data.pauses[habit.id]?.any { day in it } == true
    fun isArchived(habit: Habit, day: Int): Boolean {
        if (!habit.archived) return false
        val from = data.archivedOn[habit.id] ?: return false
        return day >= from
    }

    /** Whether any pause touches [range] (a week or month with a paused day can't end a streak). */
    fun hasPause(habit: Habit, range: DayRange): Boolean = data.pauses[habit.id]?.any { p ->
        p.from <= range.last && (p.through == null || p.through >= range.first) && (p.through ?: p.from) >= p.from
    } == true

    fun canSkip(habit: Habit): Boolean {
        if (habit.atMost || habit.kind == Kind.QUIT) return false
        return habit.frequency.let { it !is Frequency.PerWeek && it !is Frequency.PerMonth && it !is Frequency.PerYear }
    }

    fun canPause(habit: Habit) = !(habit.kind == Kind.TASK && habit.dueDay != null) && !habit.archived

    // ------------------------------------------------------------------ Schedules (spec/schedules.md)

    /** S-1…S-5: whether [day] is one of the habit's days. [countingSkips] false asks whether it was planned at all;
     *  [followingMoves] false asks a repeating task's own schedule. */
    fun isDue(habit: Habit, day: Int, now: Long = clock(), countingSkips: Boolean = true, followingMoves: Boolean = true): Boolean {
        if ((countingSkips && isSkipped(habit, day)) || isPaused(habit, day) || isArchived(habit, day)) return false
        val h = rule(habit, day)
        val created = startDay(h)
        if (h.endsOn != null && day > h.endsOn && h.kind != Kind.QUIT) return false
        when (h.kind) {
            Kind.QUIT -> return false
            Kind.TASK -> {
                val due = h.dueDay
                if (due == null) {
                    val moves = data.moves[h.id]
                    if (followingMoves && moves != null) {
                        if (moves.values.contains(day)) return true
                        if (moves.containsKey(day)) return false
                    }
                } else {
                    if (day == due) return true
                    return due < day && day == today(now) && !isDone(h, day)
                }
            }
            else -> {}
        }
        if (day < created) return false
        return when (val f = h.frequency) {
            is Frequency.Calendar -> matches(f.rule, day, created)
            is Frequency.AfterCompletion -> {
                val completions = data.entries(h.id).filter { it.day <= day }
                if (completions.any { it.day == day }) return true
                val last = completions.maxOfOrNull { it.day }
                val next = if (last != null) add(last, f.n, f.unit) else created
                day >= next
            }
            Frequency.Daily, is Frequency.PerWeek, is Frequency.PerMonth, is Frequency.PerYear, is Frequency.Flexible -> true
            is Frequency.Weekdays -> f.days.contains(Day.weekday(day))
            is Frequency.EveryNDays -> f.n <= 1 || (day - created) % f.n == 0
            is Frequency.EveryNWeeks -> (day - created) % (7 * max(f.n, 1)) == 0
            is Frequency.MonthDates -> {
                val ymd = Day.ymd(day)
                val last = Day.daysInMonth(ymd[0], ymd[1])
                f.dates.contains(ymd[2]) || (ymd[2] == last && f.dates.any { it > last })
            }
        }
    }

    /** [n] days, weeks, months or years after [day], as the iPhone's calendar adds them (a month or year lands on the
     *  month's last day when the date doesn't exist). */
    fun add(day: Int, n: Int, unit: Period): Int = when (unit) {
        Period.DAY -> day + n
        Period.WEEK -> day + 7 * n
        Period.MONTH -> Day.addMonths(day, n)
        Period.YEAR -> Day.addMonths(day, 12 * n)
    }

    /** S-3: whether a calendar rule falls on [date], counted from the habit's first day [start]. */
    fun matches(rule: CalendarSchedule, date: Int, start: Int): Boolean {
        if (date < start) return false
        val n = max(1, rule.interval)
        val (y, m, d) = Day.ymd(date).let { Triple(it[0], it[1], it[2]) }
        val last = Day.daysInMonth(y, m)
        return when (rule.unit) {
            Period.DAY -> (date - start) % n == 0
            Period.WEEK -> {
                val week = Day.weekStart(start, rule.anchorWeekStart)
                val gap = date - week
                (gap / 7) % n == 0 && rule.weekdays.contains(Day.weekday(date))
            }
            Period.MONTH -> {
                val s = Day.ymd(start)
                val gap = (y - s[0]) * 12 + m - s[1]
                if (gap % n != 0) return false
                when (rule.pattern) {
                    "Dates" -> rule.dates.contains(d) || (rule.useLastDay && d == last && rule.dates.any { it > last })
                    "Last day" -> d == last
                    else -> {
                        if (Day.weekday(date) != rule.weekday) return false
                        if (rule.ordinal == -1) d + 7 > last else (d - 1) / 7 + 1 == rule.ordinal
                    }
                }
            }
            Period.YEAR -> {
                val s = Day.ymd(start)
                if ((y - s[0]) % n != 0 || m != rule.month) return false
                d == (if (rule.useLastDay) min(rule.day, last) else rule.day)
            }
        }
    }

    // ------------------------------------------------------------------ Goals (spec/goals.md)

    /** Today's ticks per time of day: always none since times only place a habit (P-1), kept for the iPhone's shape. */
    fun slots(habit: Habit): List<String> = emptyList()

    /** G-1: the day's goal: times, amount, minutes, or the number of checklist steps. */
    fun dayGoal(habit: Habit): Double = when (habit.kind) {
        Kind.CHECKLIST -> max(habit.steps.size, 1).toDouble()
        Kind.TASK -> 1.0
        else -> habit.goal
    }

    /** G-2: what was logged on a day (a checklist counts its ticked steps; a running timer counts up to now). */
    fun dayProgress(habit: Habit, day: Int, now: Long = clock()): Double {
        val h = rule(habit, day)
        if (h.kind == Kind.CHECKLIST) {
            val ticked = data.entries(h.id, day).mapNotNullTo(HashSet()) { it.stepId }
            return h.steps.count { it in ticked }.toDouble()
        }
        if (h.kind == Kind.TASK) {
            if (h.dueDay == null) return if (data.entries(h.id, day).isNotEmpty()) 1.0 else 0.0
            return if (data.entries(h.id).isNotEmpty()) 1.0 else 0.0
        }
        var total = 0.0
        for (e in data.entries(h.id, day)) if (e.stepId == null) total += e.value
        val start = data.timers[h.id]
        if (start != null && day == today(now)) total += max(0L, now - start) / 1000.0 / 60
        return total
    }

    /** G-3: the day's goal met (at most: within it). */
    fun isDayMet(habit: Habit, day: Int): Boolean {
        val h = rule(habit, day)
        val p = dayProgress(h, day)
        return if (h.atMost) p <= dayGoal(h) else p >= dayGoal(h)
    }

    /** G-4: amounts and minutes on a week, month or year rule are a total for the whole period. */
    fun isTotal(habit: Habit) = (habit.kind == Kind.AMOUNT || habit.kind == Kind.DURATION) && !habit.frequency.isDayBased

    /** G-5: what was logged in a range, step ticks aside. */
    fun loggedTotal(habit: Habit, range: DayRange): Double {
        val all = data.entries(habit.id)
        var total = 0.0
        // A week or month is read day by day from the per-day index, not by walking every log the habit ever had (as the
        // iPhone does: a widget asks this for seven days of every habit, S5); a range longer than the history walks it once.
        if (range.last - range.first + 1 < all.size) {
            for (day in range.first..range.last) for (e in data.entries(habit.id, day)) if (e.stepId == null) total += e.value
            return total
        }
        for (e in all) if (e.stepId == null && e.day in range) total += e.value
        return total
    }

    fun periodTotal(habit: Habit, range: DayRange, now: Long = clock()): Double {
        var total = loggedTotal(habit, range)
        val start = data.timers[habit.id]
        if (start != null && today(now) in range) total += max(0L, now - start) / 1000.0 / 60
        return total
    }

    /** G-5: completions in a week or month: ticks for a check counted N times, met days for everything else. */
    fun periodCount(habit: Habit, range: DayRange): Double {
        if (habit.kind == Kind.CHECK && !habit.frequency.isFlexible) return loggedTotal(habit, range)
        var count = 0.0
        val start = startDay(habit)
        val end = habit.endsOn ?: range.last
        for (day in range.first..range.last) {
            if (day >= start && day <= end && isDayMet(habit, day)) count += 1
        }
        return count
    }

    /** G-6: what a row shows: the day's amount, a period's total, or a period's count. */
    fun progress(habit: Habit, day: Int, now: Long = clock()): Double {
        val h = rule(habit, day)
        val range = periodRange(h, day)
        if (!h.frequency.isFlexible && range != null) return if (isTotal(h)) periodTotal(h, range, now) else periodCount(h, range)
        return dayProgress(h, day, now)
    }

    fun goal(habit: Habit): Double {
        if (isTotal(habit)) return habit.goal
        return when (val f = habit.frequency) {
            is Frequency.PerWeek -> f.n.toDouble()
            is Frequency.PerMonth -> f.n.toDouble()
            is Frequency.PerYear -> f.n.toDouble()
            else -> dayGoal(habit)
        }
    }

    /** G-7: done: the day's goal, or a week, month or year count or total. */
    fun isDone(habit: Habit, day: Int): Boolean {
        val h = rule(habit, day)
        when (h.kind) {
            Kind.QUIT -> return false
            Kind.TASK -> return dayProgress(h, day) >= 1
            else -> {}
        }
        val range = periodRange(h, day)
        if (!h.frequency.isFlexible && range != null) {
            if (!isTotal(h)) return periodCount(h, range) >= goal(h)
            val total = periodTotal(h, range)
            return if (h.atMost) total <= h.goal else total >= h.goal
        }
        return isDayMet(h, day)
    }

    /** G-7: days met so far in a flexible goal's period ("2 of 3 days"); null for other goals. */
    fun flexibleProgress(habit: Habit, day: Int): Int? {
        val h = rule(habit, day)
        if (!h.frequency.isFlexible) return null
        val range = periodRange(h, day) ?: return null
        return periodCount(h, range).toInt()
    }

    fun isComplete(habit: Habit, day: Int) = isDone(habit, day) || (habit.frequency.isFlexible && isPeriodMet(habit, day))

    /** G-7: done for the day as Today, reminders and the player count it. */
    fun isSatisfied(habit: Habit, day: Int): Boolean {
        if (isComplete(habit, day)) return true
        val r = rule(habit, day)
        return !r.frequency.isDayBased && !r.atMost && dayProgress(r, day) > 0
    }

    fun isPeriodMet(habit: Habit, day: Int): Boolean {
        val h = rule(habit, day)
        val f = h.frequency
        if (f is Frequency.Flexible) return (flexibleProgress(h, day) ?: 0) >= f.n
        return isDone(h, day)
    }

    /** G-8: a check habit whose button adds one each tap (several a day, or N a week, month or year). */
    fun countsUp(habit: Habit, day: Int): Boolean {
        val r = rule(habit, day)
        if (r.kind != Kind.CHECK) return false
        return !r.frequency.isDayBased || dayGoal(r) > 1
    }

    fun isStepDone(step: String, habit: Habit, day: Int) = data.entries(habit.id, day).any { it.stepId == step }
    fun isSlotDone(habit: Habit, slot: String, day: Int) = data.entries(habit.id, day).any { it.slot == slot }

    /** G-9: the share of the day's goal reached, 0…1. */
    fun dayFraction(habit: Habit, day: Int): Double {
        val r = rule(habit, day)
        val goal = dayGoal(r)
        return if (goal > 0) min(1.0, max(0.0, dayProgress(r, day) / goal)) else 0.0
    }

    // ------------------------------------------------------------------ How a day counts (spec/progress.md)

    /** G-9: one habit's day in the rings and Progress's numbers. */
    fun outcome(habit: Habit, day: Int, today: Int = today()): Outcome {
        if (habit.kind == Kind.QUIT || day < startDay(habit) || !isDue(habit, day)) return Outcome.NEUTRAL
        val r = rule(habit, day)
        if (r.kind == Kind.TASK) return if (isDone(r, day)) Outcome.DONE else if (day < today) Outcome.NOT_DONE else Outcome.OPEN
        if (!r.frequency.isDayBased) {
            if (r.atMost) return Outcome.NEUTRAL
            if (dayProgress(r, day) > 0) return Outcome.DONE
            return if (day == today && !isPeriodMet(habit, day)) Outcome.OPEN else Outcome.NEUTRAL
        }
        if (r.frequency.isFlexible) {
            if (dayProgress(r, day) > 0) return if (isDayMet(r, day)) Outcome.DONE else Outcome.part(dayFraction(r, day))
            return if (day == today && !isPeriodMet(habit, day)) Outcome.OPEN else Outcome.NEUTRAL
        }
        if (r.atMost) return if (day < today) (if (isDayMet(r, day)) Outcome.DONE else Outcome.NOT_DONE) else Outcome.NEUTRAL
        if (isDayMet(r, day)) return Outcome.DONE
        if (day > today) return Outcome.OPEN
        if (dayProgress(r, day) > 0) return Outcome.part(dayFraction(r, day))
        return if (day == today) Outcome.OPEN else Outcome.NOT_DONE
    }

    /** P-3: one day across [habits]. */
    fun dayScore(day: Int, habits: List<Habit>, today: Int = today()): DayScore {
        var done = 0; var part = 0.0; var partCount = 0; var planned = 0
        for (h in habits) {
            val o = outcome(h, day, today)
            when (o.kind) {
                Outcome.Kind.DONE -> { planned++; done++ }
                Outcome.Kind.PART -> { planned++; part += o.share; partCount++ }
                Outcome.Kind.NOT_DONE, Outcome.Kind.OPEN -> planned++
                Outcome.Kind.NEUTRAL -> {}
            }
        }
        return DayScore(done, part, partCount, planned)
    }

    /** P-3: the day as Today counts it: every habit and task that isn't archived. */
    fun todayScore(day: Int) = dayScore(day, data.habits.filter { !it.archived })

    /** G-9: how a day reads in a habit's calendar. */
    fun dayMark(habit: Habit, day: Int, reference: Int = today()): DayMark {
        val today = reference
        if (day < startDay(habit)) return DayMark.BEFORE
        if (isPaused(habit, day)) return DayMark.PAUSED
        if (isSkipped(habit, day)) return DayMark.SKIPPED
        if (day > today) return if (isDue(habit, day)) DayMark.UPCOMING else DayMark.NOT_ITS_DAY
        val r = rule(habit, day)
        if (!r.frequency.isDayBased || r.frequency.isFlexible) {
            if (dayProgress(r, day) > 0) {
                if (r.atMost) return DayMark.SOME
                return if (isDayMet(r, day) || !r.frequency.isFlexible) DayMark.DONE else DayMark.SOME
            }
            return if (day == today && isDue(habit, day)) DayMark.OPEN else DayMark.NOT_ITS_DAY
        }
        if (!isDue(habit, day)) return DayMark.NOT_ITS_DAY
        if (r.atMost) {
            if (day == today) return if (dayProgress(r, day) > 0) DayMark.SOME else DayMark.OPEN
            return if (isDayMet(r, day)) DayMark.DONE else DayMark.MISSED
        }
        if (isDayMet(r, day)) return DayMark.DONE
        if (dayProgress(r, day) > 0) return DayMark.SOME
        return if (day == today) DayMark.OPEN else DayMark.MISSED
    }

    // ------------------------------------------------------------------ Streaks (spec/streaks.md)

    /** ST-1: days (or weeks, months, years) met in a row up to [day]; the current one counts only once met, and a
     *  limit's only once it's over. */
    fun streak(habit: Habit, day: Int): Int {
        if (habit.kind == Kind.QUIT || habit.kind == Kind.TASK) return 0
        val r = rule(habit, day)
        val today = today()
        val range = periodRange(r, day)
        val current = if (range != null) isPeriodMet(r, day) && !(r.atMost && today in range)
        else isDone(r, day) && !(r.atMost && day >= today)
        return (if (current) 1 else 0) + runBefore(day, r)
    }

    /** ST-2, ST-3: the run before the day (or period) holding [day], as [streak] counts it. Callers keep it per day. */
    fun runBefore(day: Int, habit: Habit): Int {
        val created = startDay(habit)
        val kind = periodKind(habit)
        val current = periodRange(habit, day)
        var count = 0
        if (current != null) {
            var cursor = current.first - 1
            while (cursor >= created && periodKind(rule(habit, cursor)) == kind) {
                val range = periodRange(habit, cursor) ?: break
                if (isPeriodMet(habit, cursor)) count++ else if (!hasPause(habit, range)) break
                cursor = range.first - 1
            }
            return count
        }
        var cursor = day - 1
        while (cursor >= created && periodKind(rule(habit, cursor)) == kind) {
            if (isDue(habit, cursor)) {
                if (!isDayMet(habit, cursor)) break
                count++
            }
            cursor--
        }
        return count
    }

    /** ST-4: every run of met days (or periods), oldest first; the last is current when nothing has ended it. */
    fun runs(habit: Habit, today: Int = today(), kind: Period? = null): List<Run> {
        if (habit.kind == Kind.QUIT || habit.kind == Kind.TASK) return emptyList()
        val wanted = kind ?: periodKind(rule(habit, today))
        val runs = ArrayList<Run>()
        var start = -1; var end = -1; var length = 0
        fun close() {
            if (start >= 0 && length > 0) runs.add(Run(start, end, length, false))
            start = -1; end = -1; length = 0
        }
        fun extend(from: Int, to: Int) {
            if (start < 0) start = from
            end = to
            length++
        }
        val first = startDay(habit)
        var day = first
        if (wanted != Period.DAY) {
            while (day <= today) {
                val r = rule(habit, day)
                val range = periodRange(r, day)
                if (periodKind(r) != wanted || range == null) {
                    close(); day++; continue
                }
                val running = range.last >= today
                if (!(r.atMost && running) && isPeriodMet(habit, day)) extend(max(range.first, first), min(range.last, today))
                else if (!running && !hasPause(habit, range)) close()
                day = range.last + 1
            }
        } else {
            while (day <= today) {
                val r = rule(habit, day)
                if (periodKind(r) != Period.DAY) close()
                else if (day == today) { if (!r.atMost && isDayMet(habit, day)) extend(day, day) }
                else if (isDue(habit, day)) { if (isDayMet(habit, day)) extend(day, day) else close() }
                day++
            }
        }
        if (start >= 0 && length > 0) runs.add(Run(start, end, length, true))
        return runs
    }

    fun bestStreak(habit: Habit): Int {
        if (habit.kind == Kind.QUIT || habit.kind == Kind.TASK) return 0
        return runs(habit).maxOfOrNull { it.length } ?: 0
    }

    // ------------------------------------------------------------------ Quit habits (spec/streaks.md ST-5)

    /** A quit habit's slips, oldest first: each log's moment, and a later "Started" counted as one more. */
    fun slips(habit: Habit, now: Long = clock()): List<Long> {
        val start = habit.quitSince ?: habit.createdAt
        val slips = data.entries(habit.id).map { it.createdAt }.filter { it <= now }.toMutableList()
        if (start > habit.createdAt && !slips.contains(start)) slips.add(start)
        return slips.sorted()
    }

    /** Every run of a quit habit, oldest first: a slip ends one, a pause ends one and turning it back on starts one. */
    fun quitHistory(habit: Habit, now: Long = clock()): List<QuitRun> {
        val start = habit.quitSince ?: habit.createdAt
        class Edge(val at: Long, val starts: Boolean, val ending: QuitRun.Ending)
        val edges = slips(habit, now).map { Edge(it, true, QuitRun.Ending.SLIP) }.toMutableList()
        var pausedNow = false
        for (p in data.pauses[habit.id] ?: emptyList()) {
            if (p.pausedAt > now) continue
            edges.add(Edge(p.pausedAt, false, QuitRun.Ending.PAUSE))
            val back = resumeMoment(p)
            if (back != null && back <= now) edges.add(Edge(back, true, QuitRun.Ending.PAUSE)) else pausedNow = true
        }
        val sorted = edges.sortedBy { it.at }
        val origin = min(habit.createdAt, start)
        var runStart: Long? = origin
        val runs = ArrayList<QuitRun>()
        for (edge in sorted) {
            if (edge.at <= origin) continue
            val s = runStart
            if (s != null && edge.at > s) runs.add(QuitRun(s, edge.at, edge.ending))
            runStart = if (edge.starts) edge.at else null
        }
        val s = runStart
        if (!pausedNow && s != null) runs.add(QuitRun(max(start, s), null, QuitRun.Ending.ONGOING))
        return runs
    }

    /** When a pause gave the habit back: by hand, or when the day after its last day began. */
    fun resumeMoment(p: Pause): Long? = p.resumedAt ?: p.through?.let { dayStart(it + 1) }

    /** ST-5: the current run and the best run, in seconds. */
    fun quitRuns(habit: Habit, now: Long = clock()): DoubleArray {
        val history = quitHistory(habit, now)
        val current = history.lastOrNull()?.let { if (it.ending == QuitRun.Ending.ONGOING) it.seconds(now) else 0.0 } ?: 0.0
        return doubleArrayOf(current, history.maxOfOrNull { it.seconds(now) } ?: 0.0)
    }

    // ------------------------------------------------------------------ Where habits show (spec/progress.md P-1, P-2)

    fun section(id: String): DaySection = data.sections.firstOrNull { it.id == id } ?: data.sections[0]

    /** Timed sections in order, each with the minute it ends (the next one's start, or its own end). */
    fun timedSections(): List<Pair<DaySection, Int>> {
        val timed = data.sections.filter { !it.isAnytime }
        return timed.mapIndexed { i, s -> s to (if (i + 1 < timed.size) timed[i + 1].start!! else (s.end ?: (24 * 60 + dayEnd * 60))) }
    }

    /** A clock minute on the person's day: times before the day's start come after midnight (1:00 AM with a 3 AM start is 25:00). */
    fun dayMinute(minute: Int) = if (minute < dayEnd * 60) minute + 24 * 60 else minute

    fun sectionForMinute(minute: Int): DaySection {
        val timed = timedSections()
        if (timed.isEmpty()) return section(DaySection.ANYTIME)
        val m = dayMinute(minute)
        if (m < timed.first().first.start!!) return timed.first().first
        return timed.firstOrNull { it.first.start!! <= m && m < it.second }?.first ?: timed.last().first
    }

    /** P-1: where a habit shows on Today: a row per chosen time of day, each with its own times, earliest first. */
    fun placements(habit: Habit): List<Placement> {
        if (habit.kind == Kind.QUIT) return emptyList()
        val times = habit.times.sortedBy { dayMinute(it) }
        val seen = HashSet<String>()
        val chosen = habit.parts.map { section(it).id }.filter { seen.add(it) }
        val order = data.sections.map { it.id }
        fun rank(id: String) = order.indexOf(id).let { if (it < 0) 99 else it }
        val parts = chosen.sortedBy { rank(it) }
        if (parts.size < 2) return listOf(Placement(chosen.firstOrNull() ?: DaySection.ANYTIME, null, times))
        val starts = parts.map { p -> section(p).start?.let { dayMinute(it) } ?: 0 }
        val byPart = HashMap<String, MutableList<Int>>()
        for (time in times) {
            val own = sectionForMinute(time).id
            val m = dayMinute(time)
            val home = if (parts.contains(own)) own else (parts.indices.lastOrNull { starts[it] <= m }?.let { parts[it] } ?: parts[0])
            byPart.getOrPut(home) { ArrayList() }.add(time)
        }
        return parts.map { Placement(it, null, byPart[it] ?: emptyList()) }
    }

    /** P-2: Today's cards from top to bottom: the times of day in time order, with Anytime and Quitting where the person put them. */
    fun todayCards(): List<String> {
        val timed = data.sections.filter { !it.isAnytime }.map { it.id }
        val known = timed.toSet()
        val slots = data.cardOrder.filter { it == DaySection.ANYTIME || it == DaySection.QUITTING || it in known }.toMutableList()
        for (card in listOf(DaySection.QUITTING, DaySection.ANYTIME).reversed()) if (card !in slots) slots.add(0, card)
        for ((i, id) in timed.withIndex()) {
            if (id in slots) continue
            val after = if (i > 0) slots.indexOf(timed[i - 1]) else -1
            if (i > 0 && after >= 0) slots.add(after + 1, id)
            else {
                val first = slots.indexOfFirst { it in known }
                if (first >= 0) slots.add(first, id) else slots.add(id)
            }
        }
        val next = timed.iterator()
        return slots.map { if (it in known) next.next() else it }
    }

    /** P-2: every habit and task each card holds, whatever the day, in the person's order. */
    fun cardMembers(): Map<String, List<Habit>> {
        val cards = LinkedHashMap<String, MutableList<Habit>>()
        for (habit in data.habits) {
            if (habit.archived) continue
            if (habit.isQuitOrLimit) { cards.getOrPut(DaySection.QUITTING) { ArrayList() }.add(habit); continue }
            val due = habit.dueDay
            if (habit.kind == Kind.TASK && due != null && isDone(habit, due)) continue
            val seen = HashSet<String>()
            for (p in placements(habit)) if (seen.add(p.section)) cards.getOrPut(p.section) { ArrayList() }.add(habit)
        }
        return cards
    }
}

/** One habit's day (G-9): done, part (with the share reached), not done, open (today or later), or neutral. */
class Outcome private constructor(val kind: Kind, val share: Double) {
    enum class Kind { DONE, PART, NOT_DONE, OPEN, NEUTRAL }

    companion object {
        val DONE = Outcome(Kind.DONE, 1.0)
        val NOT_DONE = Outcome(Kind.NOT_DONE, 0.0)
        val OPEN = Outcome(Kind.OPEN, 0.0)
        val NEUTRAL = Outcome(Kind.NEUTRAL, 0.0)
        fun part(share: Double) = Outcome(Kind.PART, share)
    }
}

/** How a day reads in a habit's calendar (never a harsh mark, U3). */
enum class DayMark { DONE, SOME, MISSED, OPEN, SKIPPED, PAUSED, NOT_ITS_DAY, UPCOMING, BEFORE;

    /** The iPhone's name for it ("notItsDay"). */
    val key: String get() = when (this) {
        NOT_ITS_DAY -> "notItsDay"
        else -> name.lowercase()
    }
}

data class DayScore(val done: Int, val part: Double, val partCount: Int, val planned: Int) {
    val fraction get() = if (planned == 0) 0.0 else min(1.0, (done + part) / planned)
    val isFull get() = planned > 0 && done == planned
    fun isFull(share: Double) = if (share >= 1) isFull else planned > 0 && done.toDouble() / planned >= share - 0.000_001
}

/** A run of met days (or periods): [end] is the last day of its last met period, up to today. */
data class Run(val start: Int, val end: Int, val length: Int, val isCurrent: Boolean)

/** One run of a quit habit, from a start to the slip or pause that ended it ([end] null: going on now). Epoch ms. */
data class QuitRun(val start: Long, val end: Long?, val ending: Ending) {
    enum class Ending { SLIP, PAUSE, ONGOING;

        val key: String get() = name.lowercase()
    }

    fun seconds(now: Long) = max(0L, (end ?: now) - start) / 1000.0
}

/** Where a habit shows on Today: a section, and the times that belong to that row. */
data class Placement(val section: String, val slot: String?, val times: List<Int>)
