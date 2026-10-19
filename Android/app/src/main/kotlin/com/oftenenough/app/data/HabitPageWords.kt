package com.oftenenough.app.data

import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.Locale
import kotlin.math.max
import kotlin.math.min

// MOVE TO CORE: Habit details' numbers and words, ported unchanged from the iPhone's
// iOS/Habits/Model/HabitStore+HabitPage.swift (History, Overall record, comparisons, milestones),
// HabitStore+WeekCards.swift (a habit's Week, Month and Year card: headline, detail and squares),
// HabitStore+Progress.swift (progressShape, progressValue, progressPeriodResults), HabitStore+Phase2.swift (quit
// numbers and milestones), Milestones.swift (StreakUnit.word), AllHabits/HabitPageParts.swift (NoteMonth) and
// AllHabits/HabitPageView.swift (the header's sentence). Everything is worked out here, once per data change (the page
// keys its `remember`s on the habit's revision), never while drawing (Rulebook S5, S8). Nothing here is stored, so an
// edit, an undo or a restored backup can never leave a number that disagrees with the history (D6). Checked in
// HabitPageWordsTest.

// ---------------------------------------------------------------------------------------------------------- Days

private val monthShort = listOf("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
private val spokenFormat = DateTimeFormatter.ofPattern("d MMMM", Locale.ENGLISH)
private val spokenYearFormat = DateTimeFormatter.ofPattern("d MMMM yyyy", Locale.ENGLISH)

internal fun pageDate(day: Int): LocalDate = LocalDate.ofEpochDay(day.toLong())
/** 1 = Sunday … 7 = Saturday, as the iPhone's weekdays. */
internal fun pageWeekday(day: Int): Int = pageDate(day).dayOfWeek.value % 7 + 1
internal fun pageYear(day: Int): Int = pageDate(day).year
internal fun pageMonth(day: Int): Int = pageDate(day).monthValue
internal fun pageDayOfMonth(day: Int): Int = pageDate(day).dayOfMonth
internal fun pageFirstOfMonth(day: Int): Int = pageDate(day).withDayOfMonth(1).toEpochDay().toInt()
internal fun pageMonthLength(day: Int): Int = pageDate(day).lengthOfMonth()
internal fun pageDay(year: Int, month: Int, dayOfMonth: Int): Int = LocalDate.of(year, month, dayOfMonth).toEpochDay().toInt()

/** "Jan" … "Dec". */
fun pageMonthShort(month: Int): String = monthShort[(month - 1 + 12) % 12]

/** "October 2026": a History or Notes month's title. */
fun historyMonthTitle(first: Int): String = HabitCopy.monthNames[pageMonth(first) - 1] + " " + pageYear(first)

/** "Mon 12": a History or Notes row's date. */
fun historyDayTitle(day: Int): String = HabitCopy.shortDays[pageWeekday(day) - 1] + " " + pageDayOfMonth(day)

/** "Mon 12 Oct": a day with its month (History's search results, Add's Open button, a paused card). */
fun pageDayDate(day: Int): String = historyDayTitle(day) + " " + pageMonthShort(pageMonth(day))

/** "8 Oct", or "8 Oct 2025" in another year. */
fun pageShortDate(day: Int, today: Int): String =
    if (pageYear(day) == pageYear(today)) DayWords.dayMonth(day) else DayWords.long(day)

/** "28 September", or "28 September 2025" in another year (TalkBack). */
fun pageSpokenDate(day: Int, today: Int): String =
    pageDate(day).format(if (pageYear(day) == pageYear(today)) spokenFormat else spokenYearFormat)

/** "26 September to 1 October". */
fun pageSpokenSpan(first: Int, last: Int, today: Int): String =
    if (first == last) pageSpokenDate(first, today) else pageSpokenDate(first, today) + " to " + pageSpokenDate(last, today)

/** "8 Oct", "23–29 Aug", "20 Sep – 12 Oct"; with the year when it isn't this year. */
fun pageDaySpan(first: Int, last: Int, today: Int): String {
    if (first == last) return pageShortDate(first, today)
    val a = pageDate(first)
    val b = pageDate(last)
    val thisYear = a.year == pageYear(today) && b.year == pageYear(today)
    if (a.year != b.year) return "${a.dayOfMonth} ${pageMonthShort(a.monthValue)} ${a.year} – ${b.dayOfMonth} ${pageMonthShort(b.monthValue)} ${b.year}"
    val year = if (thisYear) "" else " ${b.year}"
    if (a.monthValue == b.monthValue) return "${a.dayOfMonth}–${b.dayOfMonth} ${pageMonthShort(b.monthValue)}$year"
    return "${a.dayOfMonth} ${pageMonthShort(a.monthValue)} – ${b.dayOfMonth} ${pageMonthShort(b.monthValue)}$year"
}

/** "21–27 Sep", "27 Sep – 3 Oct"; with the year when the week isn't in the current one (the Week card's title). */
fun pageWeekTitle(first: Int, last: Int, today: Int): String {
    val a = pageDate(first)
    val b = pageDate(last)
    val year = pageYear(today)
    if (a.year != b.year) return "${a.dayOfMonth} ${pageMonthShort(a.monthValue)} ${a.year} – ${b.dayOfMonth} ${pageMonthShort(b.monthValue)} ${b.year}"
    val tail = if (a.year != year || b.year != year) " ${b.year}" else ""
    if (a.monthValue == b.monthValue) return "${a.dayOfMonth}–${b.dayOfMonth} ${pageMonthShort(b.monthValue)}$tail"
    return "${a.dayOfMonth} ${pageMonthShort(a.monthValue)} – ${b.dayOfMonth} ${pageMonthShort(b.monthValue)}$tail"
}

/** "October", or "October 2025" in another year (the Month card's title). */
fun pageMonthTitle(first: Int, today: Int): String {
    val name = HabitCopy.monthNames[pageMonth(first) - 1]
    return if (pageYear(first) == pageYear(today)) name else "$name ${pageYear(first)}"
}

/** "This week", "Last week", or null for older weeks. */
fun pageWeekCaption(span: IntRange, today: Int): String? = when {
    today in span -> "This week"
    today - 7 in span -> "Last week"
    else -> null
}

/** "This month", "Last month", or null for older months. */
fun pageMonthCaption(span: IntRange, today: Int): String? = when {
    today in span -> "This month"
    pageFirstOfMonth(today) - 1 in span -> "Last month"
    else -> null
}

/** The month grid's empty places before the 1st, in the person's week order (1 = Sunday). */
fun pageMonthLead(first: Int, weekStart: Int): Int = (pageWeekday(first) - weekStart + 7) % 7

/** The weekday letters in the person's week order: "S M T W T F S". */
fun pageWeekdayLetters(weekStart: Int): List<String> = (0 until 7).map { HabitCopy.shortDays[(weekStart - 1 + it) % 7].substring(0, 1) }

/** "Sun" … "Sat" in the person's week order. */
fun pageWeekdayNames(weekStart: Int): List<String> = (0 until 7).map { HabitCopy.shortDays[(weekStart - 1 + it) % 7] }

// ---------------------------------------------------------------------------------------------------------- Squares

/** Why a day asks nothing: not scheduled, skipped or paused (never a failure, U3). */
enum class HeatOff { NOT_SCHEDULED, SKIPPED, PAUSED }

/**
 * One day's square in History, Week, Month and Year (the iPhone's `HeatCell`): one rule for every habit type, colour
 * strength is how much of what the day asked for was done.
 *   Blank     before the habit began: nothing is drawn
 *   Upcoming  asked, but not over yet: plain grey
 *   Off       not scheduled (dashed); skipped or paused (grey with ⏩ / ⏸)
 *   Level 0   asked and not done, once the day is over: grey with ✕
 *   Level 1–3 part of the day's goal: up to a third, up to two thirds, more than that
 *   Level 4   the day's goal met (✓); Level 5 more than the day's goal (✓, deeper)
 */
sealed class HeatCell {
    data object Blank : HeatCell()
    data object Upcoming : HeatCell()
    data class Off(val why: HeatOff) : HeatCell()
    data class Level(val n: Int) : HeatCell()

    companion object {
        private val levels = (0..5).map { Level(it) }
        fun level(n: Int): HeatCell = levels[n.coerceIn(0, 5)]
        val notScheduled: HeatCell = Off(HeatOff.NOT_SCHEDULED)
        val skipped: HeatCell = Off(HeatOff.SKIPPED)
        val paused: HeatCell = Off(HeatOff.PAUSED)

        /** The step for a share of the day's goal: 0, then three part steps, then met. */
        fun share(fraction: Double): HeatCell = when {
            fraction <= 0 -> level(0)
            fraction >= 1 -> level(4)
            fraction <= 1.0 / 3 -> level(1)
            fraction <= 2.0 / 3 -> level(2)
            else -> level(3)
        }
    }
}

// ---------------------------------------------------------------------------------------------------------- Shapes

/** Week, Month or Year (a habit page card's range). */
enum class ProgressRange(val noun: String, val goalPeriod: GoalPeriod, val kind: PeriodKind) {
    WEEK("week", GoalPeriod.WEEK, PeriodKind.WEEK),
    MONTH("month", GoalPeriod.MONTH, PeriodKind.MONTH),
    YEAR("year", GoalPeriod.YEAR, PeriodKind.YEAR),
}

/** How a habit's numbers are shown: ten shapes cover every type and rule (the iPhone's `ProgressShape`). */
enum class ProgressShape { ONCE, TIMES, AMOUNT, TIME, CHECKLIST, PERIOD_TIMES, PERIOD_TOTAL, PERIOD_DAYS, LIMIT_DAY, LIMIT_PERIOD }

/** G-1, as the shared rules count it: the day's goal of a rule (a habit as judged on a day). */
fun pageDayGoal(rule: Habit): Double = when (rule.kind) {
    HabitKind.Checklist -> max(rule.steps.size, 1).toDouble()
    HabitKind.Task -> 1.0
    else -> rule.goal
}

/** G-4: amounts and minutes on a week, month or year rule are a total for the whole period. */
fun pageIsTotal(rule: Habit): Boolean = (rule.kind is HabitKind.Amount || rule.kind == HabitKind.Duration) && !rule.frequency.isDayBased

/** The goal's own period. */
fun pagePeriodKind(rule: Habit): GoalPeriod = when (val f = rule.frequency) {
    is Frequency.PerWeek -> GoalPeriod.WEEK
    is Frequency.PerMonth -> GoalPeriod.MONTH
    is Frequency.PerYear -> GoalPeriod.YEAR
    is Frequency.Flexible -> f.period
    else -> GoalPeriod.DAY
}

/** A period goal's target: N a week, a total, or the day's goal. */
fun pageGoal(rule: Habit): Double {
    if (pageIsTotal(rule)) return rule.goal
    return when (val f = rule.frequency) {
        is Frequency.PerWeek -> f.n.toDouble()
        is Frequency.PerMonth -> f.n.toDouble()
        is Frequency.PerYear -> f.n.toDouble()
        else -> pageDayGoal(rule)
    }
}

fun progressShape(rule: Habit): ProgressShape {
    val f = rule.frequency
    if (rule.atMost) return if (f.isDayBased) ProgressShape.LIMIT_DAY else ProgressShape.LIMIT_PERIOD
    if (f.isFlexible) return ProgressShape.PERIOD_DAYS
    if (!f.isDayBased) return if (pageIsTotal(rule)) ProgressShape.PERIOD_TOTAL else ProgressShape.PERIOD_TIMES
    return when (rule.kind) {
        is HabitKind.Amount -> ProgressShape.AMOUNT
        HabitKind.Duration -> ProgressShape.TIME
        HabitKind.Checklist -> ProgressShape.CHECKLIST
        else -> if (pageDayGoal(rule) > 1) ProgressShape.TIMES else ProgressShape.ONCE
    }
}

/** An amount in the habit's own words: "46 glasses", "3 h 20 min", "12". */
fun progressValue(value: Double, rule: Habit): String =
    if (rule.kind == HabitKind.Duration) HabitCopy.minutes(value) else HabitCopy.amount(value, rule.unit)

private fun rank(k: GoalPeriod): Int = when (k) { GoalPeriod.DAY -> 0; GoalPeriod.WEEK -> 1; GoalPeriod.MONTH -> 2; GoalPeriod.YEAR -> 3 }

/** A value as a large number and a small unit: "46" / "glasses", "21" / "min"; hours and minutes, and a currency,
 *  stay one ("2 h 43 min", "$40"). */
fun amountParts(value: Double, rule: Habit): Pair<String, String> {
    if (rule.kind == HabitKind.Duration) {
        val rounded = Math.rint(value)
        return if (rounded < 60) HabitCopy.number(rounded) to "min" else HabitCopy.minutes(value) to ""
    }
    val unit = (if (rule.kind == HabitKind.Check) (rule.checkUnit ?: "times") else rule.unit).trim()
    if (unit.isEmpty() || unit in HabitCopy.currencies) return HabitCopy.amount(value, unit) to ""
    return HabitCopy.number(value) to HabitCopy.unitWord(value, unit)
}

/** "day" or "days" for [n]: a streak's length in its own unit. */
fun StreakUnit.word(n: Int): String = when (this) {
    StreakUnit.DAYS -> if (n == 1) "day" else "days"
    StreakUnit.TIMES -> if (n == 1) "time" else "times"
    StreakUnit.WEEKS -> if (n == 1) "week" else "weeks"
    StreakUnit.MONTHS -> if (n == 1) "month" else "months"
    StreakUnit.YEARS -> if (n == 1) "year" else "years"
}

// ---------------------------------------------------------------------------------------------------------- Header

/** "morning and evening", keeping a renamed time of day as the person wrote it. */
fun partsPhrase(names: List<String>): String {
    val usual = setOf("morning", "afternoon", "evening", "night")
    return HabitCopy.join(names.map { if (it.lowercase() in usual) it.lowercase() else it })
}

/** The habit in one sentence, with its parts of the day: "Water 8 glasses a day, anytime"; "Quitting since 2 Sep
 *  2026"; "Call the bank on Mon, 13 Oct". [quitSince] is the calendar day a quit habit counts from. */
fun pageSentenceOf(habit: Habit, weekStart: Int, partNames: List<String>, quitSince: Int): String {
    if (habit.kind == HabitKind.Quit) return "Quitting since " + DayWords.long(quitSince)
    if (habit.kind == HabitKind.Task && habit.dueDay == NO_DATE_DAY) return habit.name + ", no date yet"
    if (habit.kind == HabitKind.Task && habit.dueDay != null) return habit.name + " on " + DayWords.short(habit.dueDay)
    val parts = if (habit.parts == listOf(DaySection.ANYTIME)) "anytime" else partsPhrase(partNames)
    return HabitCopy.sentence(habit, weekStart) + ", " + parts
}

/**
 * Habit details' line under the name (Figma 1373:2, 1.1, 6.1, 6.2): "8 glasses a day, anytime", "Quit since 2 Sep", then
 * " · Paused" or " · Archived". The name is just above it, so it isn't said again.
 */
fun HabitStore.pageGoalLine(habit: Habit, today: Int): String {
    val line = if (habit.kind == HabitKind.Quit) "Quit since " + DayWords.dayMonth(rules.quitStartDay(habit))
    else {
        val parts = if (habit.parts == listOf(DaySection.ANYTIME)) "anytime" else partsPhrase(habit.parts.map { section(it).name })
        HabitCopy.capitalized(HabitCopy.plan(habit, weekStart)) + ", " + parts
    }
    val pause = pause(habit, today)
    return line + when {
        habit.archived -> " · Archived"
        pause != null && today in pause -> " · Paused"
        else -> ""
    }
}

fun HabitStore.pageSentence(habit: Habit): String {
    val since = rules.calendarDayOf(habit.quitSince ?: habit.createdAt)
    return pageSentenceOf(habit, weekStart, habit.parts.map { section(it).name }, since)
}

// ---------------------------------------------------------------------------------------------------------- Period cards

/** One day on a card's strip (the iPhone's `WeekCardDay`). */
data class WeekCardDay(
    val day: Int,
    val mark: DayMark,
    val fraction: Double,
    val over: Boolean,
    /** Done on a day it wasn't due (shown, never dropped). */
    val extra: Boolean,
    /** A quit habit's day with a slip. */
    val slip: Boolean,
    /** Done, and more than the day's goal. */
    val more: Boolean,
    val heat: HeatCell,
)

/** A habit's week, month or year: the headline on the goal's own clock, one further fact, and each day. */
data class PeriodCard(val headline: String, val detail: String?, val days: List<WeekCardDay>)

/** A week, month or year of a period goal (the iPhone's `ProgressPeriodResult`); [met] null while it's still open. */
data class PeriodResult(val period: IntRange, val value: Double, val goal: Double, val met: Boolean?)

/** A period goal's range holding [day], or null for a day goal. */
fun HabitStore.goalPeriodRange(rule: Habit, day: Int): IntRange? = when (val kind = pagePeriodKind(rule)) {
    GoalPeriod.DAY -> if (rule.frequency is Frequency.Flexible) day..day else null
    else -> rules.period(PeriodKind.valueOf(kind.name), day)
}

/** One habit's card for a week, month or year, or null when it has nothing to say (a past period before it began, or
 *  an archived habit with nothing in it). */
fun HabitStore.periodCard(habit: Habit, span: IntRange, range: ProgressRange, today: Int): PeriodCard? {
    val noun = range.noun
    val start = rules.startDay(habit)
    val running = today in span
    if (start > today) {
        if (!running || habit.archived) return null
        val strip = span.map { WeekCardDay(it, DayMark.BEFORE, 0.0, false, false, false, false, HeatCell.Blank) }
        return PeriodCard("Starts " + DayWords.short(start), null, strip)
    }
    if (start > span.last) return null
    val last = min(span.last, today)
    val rule = rule(habit, max(last, start))
    val shape = progressShape(rule)
    val unit = rule.unit

    val strip = ArrayList<WeekCardDay>(span.last - span.first + 1)
    val amounts = HashMap<Int, Double>()
    val limitTotals = HashMap<Int, Pair<Int, Double>>()
    for (day in span) {
        var mark = rules.dayMark(habit, day, today)
        val dayRule = this.rule(habit, day)
        val amount = if (day in start..today) rules.dayProgress(habit, day) else 0.0
        amounts[day] = amount
        // A week, month or year goal names no day, so a day still to come isn't "coming up": nothing is asked of it.
        if (mark == DayMark.UPCOMING && (!dayRule.frequency.isDayBased || dayRule.frequency.isFlexible)) mark = DayMark.NOT_ITS_DAY
        var extra = false
        if (mark == DayMark.NOT_ITS_DAY && amount > 0 && dayRule.frequency.isDayBased && !dayRule.frequency.isFlexible && !dayRule.atMost) {
            extra = true
            mark = if (rules.isDayMet(habit, day)) DayMark.DONE else DayMark.SOME
        }
        val goal = pageDayGoal(dayRule)
        val fraction = if (mark == DayMark.DONE) 1.0 else if (mark == DayMark.SOME) min(1.0, amount / max(goal, 1.0)) else 0.0
        val more = mark == DayMark.DONE && !dayRule.atMost && dayRule.kind != HabitKind.Checklist &&
            dayRule.frequency.isDayBased && !dayRule.frequency.isFlexible && goal > 0 && amount > goal
        val heat = heatCell(habit, day, mark, fraction, more, dayRule, amount, today, limitTotals)
        strip.add(WeekCardDay(day, mark, fraction, mark == DayMark.MISSED && dayRule.atMost, extra, false, more, heat))
    }

    val counted = strip.filter { !it.extra && (it.mark == DayMark.DONE || (it.day < today && (it.mark == DayMark.SOME || it.mark == DayMark.MISSED))) }
    val doneDays = counted.count { it.mark == DayMark.DONE }
    val extraDays = strip.count { it.extra && it.mark == DayMark.DONE }
    val soFar = if (running) " so far" else ""
    val whenText = if (running) "this $noun" else "that $noun"
    val total = strip.sumOf { amounts[it.day] ?: 0.0 }
    fun dayCount(n: Int) = if (n == 1) "1 day" else "$n days"
    fun of(done: Int, all: Int) = "$done of ${dayCount(all)}$soFar"
    fun plusExtra(): String? = if (extraDays == 0) null else if (extraDays == 1) "+1 extra day" else "+$extraDays extra days"

    var headline: String
    var detail: String?
    when (shape) {
        ProgressShape.ONCE -> { headline = of(doneDays, counted.size); detail = plusExtra() }
        ProgressShape.TIMES -> {
            headline = "Full on " + of(doneDays, counted.size)
            detail = if (total > 0) HabitCopy.amount(total, unit.ifEmpty { "times" }) + " " + whenText else plusExtra()
        }
        ProgressShape.AMOUNT, ProgressShape.TIME -> {
            headline = "Reached on " + of(doneDays, counted.size)
            detail = if (total > 0) progressValue(total, rule) + " " + whenText else plusExtra()
        }
        ProgressShape.CHECKLIST -> {
            headline = "Every step on " + of(doneDays, counted.size)
            detail = checklistDetail(habit, counted.map { it.day })
        }
        ProgressShape.LIMIT_DAY -> {
            // Judged once each day is over: today waits.
            val judged = counted.filter { it.day < today }
            val within = judged.count { it.mark == DayMark.DONE }
            headline = if (judged.isEmpty()) {
                val now = amounts[today] ?: 0.0
                if (running) "${progressValue(now, rule)} of ${progressValue(rule.goal, rule)} so far today" else "Nothing judged that $noun"
            } else "Within limit on $within of ${dayCount(judged.size)}"
            detail = if (total > 0 && judged.isNotEmpty()) progressValue(total, rule) + " " + whenText else null
        }
        else -> {
            val text = periodText(habit, rule, shape, span, range, today, strip, amounts, total)
            headline = text.first
            detail = text.second
        }
    }

    // Day goals with nothing to count yet: say what the period holds instead of "0 of 0 days".
    if (counted.isEmpty() && shape != ProgressShape.LIMIT_DAY && rule.frequency.isDayBased && !rule.frequency.isFlexible) {
        val next = strip.firstOrNull { it.mark == DayMark.UPCOMING || it.mark == DayMark.OPEN || (it.day == today && it.mark == DayMark.SOME && !it.extra) }
        if (start == today && running) {
            headline = "Started today"
        } else if (next != null) {
            headline = if (next.day == today) "Planned for today"
            else if (range == ProgressRange.WEEK) "Planned for " + HabitCopy.fullDays[pageWeekday(next.day) - 1]
            else "Planned for " + DayWords.short(next.day)
        } else {
            headline = if (running) "Not planned this $noun" else "Not planned that $noun"
            if (extraDays == 0 && total == 0.0) detail = if (running) nextDueText(habit, span.last) else null
        }
    }
    if (running && !habit.archived) {
        val p = pause(habit, today)
        if (p != null && today in p) { headline = DayWords.paused(p); detail = null }
    }
    val anything = strip.any { it.mark == DayMark.DONE || it.mark == DayMark.SOME || it.mark == DayMark.MISSED }
    if (habit.archived && !anything && total == 0.0) return null
    return PeriodCard(headline, detail, strip)
}

/** The day's square, from its mark. A week or month total colours a day by its share of a fair day's part; a week or
 *  month limit stays full while the period's running total is within it, and turns grey from the day it went over. */
private fun HabitStore.heatCell(
    habit: Habit, day: Int, mark: DayMark, fraction: Double, more: Boolean, rule: Habit, amount: Double, today: Int,
    limitTotals: HashMap<Int, Pair<Int, Double>>,
): HeatCell {
    val periodLimit = rule.atMost && !rule.frequency.isDayBased
    // A day still to come: grey when it's due, dashed when nothing will be asked of it.
    if (day > today) return when (mark) {
        DayMark.BEFORE -> HeatCell.Blank
        DayMark.SKIPPED -> HeatCell.skipped
        DayMark.PAUSED -> HeatCell.paused
        DayMark.NOT_ITS_DAY -> if (periodLimit) HeatCell.Upcoming else HeatCell.notScheduled
        else -> HeatCell.Upcoming
    }
    when (mark) {
        DayMark.BEFORE -> return HeatCell.Blank
        DayMark.SKIPPED -> return HeatCell.skipped
        DayMark.PAUSED -> return HeatCell.paused
        DayMark.UPCOMING -> return HeatCell.Upcoming
        DayMark.NOT_ITS_DAY -> if (!periodLimit) return HeatCell.notScheduled
        DayMark.OPEN -> {
            // Today, still open: grey, never ✕, until the day is over. A week or month goal asks nothing of one day.
            val periodGoal = (!rule.frequency.isDayBased || rule.frequency.isFlexible) && !rule.atMost
            return if (periodGoal) HeatCell.notScheduled else HeatCell.Upcoming
        }
        else -> {}
    }
    if (periodLimit) {
        if (day >= today) return HeatCell.Upcoming
        val period = goalPeriodRange(rule, day) ?: return HeatCell.notScheduled
        var known = limitTotals[period.first] ?: ((period.first - 1) to 0.0)
        while (known.first < day) {
            val next = known.first + 1
            known = next to (known.second + rules.dayProgress(habit, next))
        }
        limitTotals[period.first] = known
        return if (known.second <= rule.goal) HeatCell.level(4) else HeatCell.level(0)
    }
    return when (mark) {
        DayMark.DONE -> {
            if (rule.atMost) return if (day < today) HeatCell.level(4) else HeatCell.Upcoming
            val share = if (progressShape(rule) == ProgressShape.PERIOD_TOTAL) fairShare(rule) else null
            if (share != null && share > 0) HeatCell.share(amount / share) else HeatCell.level(if (more) 5 else 4)
        }
        DayMark.SOME -> if (rule.atMost) (if (day < today) HeatCell.level(0) else HeatCell.Upcoming) else HeatCell.share(fraction)
        else -> HeatCell.level(0)
    }
}

/** A week or month total's fair day: the goal spread over the period's days. */
private fun fairShare(rule: Habit): Double? = when (pagePeriodKind(rule)) {
    GoalPeriod.WEEK -> rule.goal / 7
    GoalPeriod.MONTH -> rule.goal / 30.4
    GoalPeriod.YEAR -> rule.goal / 365
    GoalPeriod.DAY -> null
}

/** Each week, month or year of a period goal that ends inside [range] and has begun. A period that wasn't met but had a
 *  pause, or ended after archiving, doesn't count against anyone and is left out. */
fun HabitStore.periodResults(habit: Habit, range: IntRange, today: Int): List<PeriodResult> {
    val start = rules.startDay(habit)
    val last = min(range.last, today)
    if (last < start) return emptyList()
    val goalPeriod = pagePeriodKind(rule(habit, last))
    if (goalPeriod == GoalPeriod.DAY) return emptyList()
    val kind = PeriodKind.valueOf(goalPeriod.name)
    val results = ArrayList<PeriodResult>()
    var cursor = range.first
    while (cursor <= range.last) {
        val p = rules.period(kind, cursor)
        cursor = p.last + 1
        if (p.last !in range || p.last < start || p.first > today) continue
        val judgeDay = min(p.last, today)
        val r = rule(habit, judgeDay)
        if (pagePeriodKind(r) != goalPeriod) continue
        if (rules.isArchived(habit, max(p.first, start))) continue
        val f = r.frequency
        val value: Double
        val goal: Double
        if (f is Frequency.Flexible) {
            value = (rules.flexibleProgress(habit, judgeDay) ?: 0).toDouble()
            goal = f.n.toDouble()
        } else if (pageIsTotal(r)) {
            value = rules.periodTotal(habit, p)
            goal = r.goal
        } else {
            value = rules.periodCount(r, p)
            goal = pageGoal(r)
        }
        val reached = if (r.atMost) value <= goal else value >= goal
        val met: Boolean?
        if (p.last >= today) {
            // Running: a goal counts once met; a limit waits for the period to end.
            met = if (!r.atMost && reached) true else null
        } else {
            if (!reached && (rules.hasPause(habit, p) || rules.isArchived(habit, p.last))) continue
            met = reached
        }
        results.add(PeriodResult(p, value, goal, met))
    }
    return results
}

/** Week, month and year goals seen in a week, month or year. */
private fun HabitStore.periodText(
    habit: Habit, rule: Habit, shape: ProgressShape, span: IntRange, range: ProgressRange, today: Int,
    strip: List<WeekCardDay>, amounts: Map<Int, Double>, total: Double,
): Pair<String, String?> {
    val running = today in span
    val kind = pagePeriodKind(rule)
    val noun = range.noun
    val thisText = if (running) " this $noun" else ""
    val thisOrThat = if (running) " this $noun" else " that $noun"
    val loggedDays = strip.count { (amounts[it.day] ?: 0.0) > 0 }
    fun count(v: Double) = HabitCopy.number(v)
    fun pv(v: Double) = progressValue(v, rule)
    fun onDays(n: Int): String? = if (n == 0) null else if (n == 1) "on 1 day" else "on $n days"
    val isAmount = rule.kind is HabitKind.Amount || rule.kind == HabitKind.Duration

    if (kind == range.goalPeriod) {
        val result = periodResults(habit, span, today).lastOrNull()
            ?: return (if (running) "Nothing yet this $noun" else "Nothing that $noun") to null
        val v = result.value
        val g = result.goal
        val daysLeft = if (running) span.last - today + 1 else 0
        fun toGo(left: Double, word: String): String {
            val rest = if (daysLeft == 1) "1 day left" else "$daysLeft days left"
            return "${count(left)} $word · $rest"
        }
        return when (shape) {
            ProgressShape.LIMIT_PERIOD -> {
                val head = "${pv(v)} of ${pv(g)}$thisText"
                val over = if (v > g) pv(v - g) + " over" else null
                val tail = listOfNotNull(over, onDays(loggedDays)).joinToString(" · ")
                head to tail.ifEmpty { null }
            }
            ProgressShape.PERIOD_TOTAL -> "${pv(v)} of ${pv(g)}" to onDays(loggedDays)
            ProgressShape.PERIOD_DAYS -> {
                val head = "${count(min(v, g))} of ${count(g)} days$thisText"
                when {
                    isAmount && total > 0 -> head to pv(total) + thisOrThat
                    v > g -> head to (if (v - g == 1.0) "+1 extra day" else "+${count(v - g)} extra days")
                    running && v < g -> head to toGo(g - v, "to go")
                    else -> head to null
                }
            }
            else -> {
                val head = "${count(min(v, g))} of ${count(g)}$thisText"
                when {
                    v > g -> head to "+${count(v - g)} extra"
                    running && v < g -> head to toGo(g - v, "to go")
                    else -> head to null
                }
            }
        }
    }

    // A shorter goal seen over a longer view (a week goal on Month): how many of its weeks were met, and what was done.
    if (rank(kind) < rank(range.goalPeriod)) {
        val results = periodResults(habit, span, today)
        val met = results.count { it.met == true }
        val judged = results.count { it.met != null }
        fun periods(n: Int) = if (kind == GoalPeriod.WEEK) (if (n == 1) "week" else "weeks") else (if (n == 1) "month" else "months")
        val open = results.lastOrNull()?.takeIf { it.met == null && today in it.period }
        val head = if (shape == ProgressShape.LIMIT_PERIOD) "Within the limit $met of $judged ${periods(judged)}"
        else if (judged == 0 && open != null) {
            (if (shape == ProgressShape.PERIOD_TOTAL) "${pv(open.value)} of ${pv(open.goal)}"
            else "${count(min(open.value, open.goal))} of ${count(open.goal)}") + " this ${periods(1)}"
        } else "Met $met of $judged ${periods(judged)}" + (if (running) " so far" else "")
        val done: String? = when (shape) {
            ProgressShape.PERIOD_TOTAL, ProgressShape.LIMIT_PERIOD -> if (total > 0) pv(total) + thisOrThat else null
            ProgressShape.PERIOD_DAYS -> if (isAmount && total > 0) pv(total) + thisOrThat
                else if (loggedDays == 0) null else (if (loggedDays == 1) "1 day" else "$loggedDays days") + thisOrThat
            else -> {
                val times = rules.periodCount(rule, span)
                if (times == 0.0) null else (if (times == 1.0) "1 time" else "${count(times)} times") + thisOrThat
            }
        }
        return (if (results.isEmpty()) (if (running) "Nothing yet this $noun" else "Nothing that $noun") else head) to done
    }

    // A longer goal (a month or year goal on Week, a year goal on Month): the period that holds today, named.
    val anchor = if (running) today else span.last
    val periodSpan = rules.period(if (kind == GoalPeriod.YEAR) PeriodKind.YEAR else PeriodKind.MONTH, anchor)
    val name = if (kind == GoalPeriod.YEAR) pageYear(periodSpan.first).toString() else HabitCopy.monthNames[pageMonth(periodSpan.first) - 1]
    val detail: String? = when (shape) {
        ProgressShape.PERIOD_TIMES -> {
            val times = rules.periodCount(rule, span)
            if (times == 0.0) null else (if (times == 1.0) "1 time" else "${count(times)} times") + thisOrThat
        }
        ProgressShape.PERIOD_DAYS -> if (isAmount && total > 0) pv(total) + thisOrThat
            else if (loggedDays == 0) null else (if (loggedDays == 1) "1 day" else "$loggedDays days") + thisOrThat
        else -> if (total > 0) pv(total) + thisOrThat else null
    }
    val result = periodResults(habit, periodSpan, today).lastOrNull() ?: return "$name: nothing yet" to detail
    val value: String
    val goal: String
    if (shape == ProgressShape.PERIOD_TOTAL || shape == ProgressShape.LIMIT_PERIOD) {
        value = pv(result.value); goal = pv(result.goal)
    } else {
        value = count(result.value); goal = count(result.goal)
    }
    return "$name: $value of $goal" to detail
}

/** "22 of 24 steps · SPF not done twice"; null when every step was done on every counted day. */
private fun HabitStore.checklistDetail(habit: Habit, counted: List<Int>): String? {
    var done = 0
    var planned = 0
    val missed = HashMap<String, Int>()
    val names = HashMap<String, String>()
    val order = ArrayList<String>()
    for (day in counted) {
        val dayRule = rule(habit, day)
        val ticked = entries(habit.id, day).mapNotNull { it.stepId }.toHashSet()
        for (step in dayRule.steps) {
            planned++
            if (step.id in ticked) { done++; continue }
            if (!names.containsKey(step.id)) { names[step.id] = step.name; order.add(step.id) }
            missed[step.id] = (missed[step.id] ?: 0) + 1
        }
    }
    if (planned == 0 || done >= planned) return null
    val steps = "$done of $planned steps"
    val most = missed.values.maxOrNull() ?: return steps
    val first = order.firstOrNull { missed[it] == most } ?: return steps
    val name = names[first]
    if (name.isNullOrEmpty()) return steps
    return "$steps · $name not done " + (if (most == 1) "once" else if (most == 2) "twice" else "$most times")
}

/** "Next planned for Mon, 12 Oct" for a schedule whose next planned day is after this period; null when none within
 *  four months. */
private fun HabitStore.nextDueText(habit: Habit, after: Int): String? {
    for (cursor in after + 1..after + 124) if (rules.isDue(habit, cursor)) return "Next planned for " + DayWords.short(cursor)
    return null
}

// ---------------------------------------------------------------------------------------------------------- Quit habits

/** A quit habit's numbers for a range: slips (moments), clean days, days that count, the longest run inside it and the
 *  mean of runs that ended in a slip (seconds), and each day's mark. */
data class QuitStats(
    val slips: List<Long>,
    val cleanDays: Int,
    val days: Int,
    val longestRun: Double,
    val averageRun: Double?,
    val marks: List<Pair<Int, DayMark>>,
)

fun HabitStore.quitStats(habit: Habit, range: IntRange, now: Long = clock()): QuitStats {
    val today = this.today(now)
    val start = rules.quitStartDay(habit)
    val allSlips = rules.slips(habit, now)
    val slipDays = allSlips.map { this.today(it) }.toHashSet()
    var clean = 0
    var counted = 0
    val marks = ArrayList<Pair<Int, DayMark>>()
    for (day in range) {
        val mark = when {
            day < start -> DayMark.BEFORE
            day > today -> DayMark.NOT_ITS_DAY
            isPaused(habit, day) -> DayMark.PAUSED
            day in slipDays -> { counted++; DayMark.MISSED }
            else -> { clean++; counted++; DayMark.DONE }
        }
        marks.add(day to mark)
    }
    val history = rules.quitHistory(habit, now)
    val lower = rules.dayStartMoment(range.first)
    val upper = rules.dayStartMoment(range.last + 1)
    val inRange = history.mapNotNull { run ->
        val from = max(run.start, lower)
        val to = min(run.end ?: now, upper)
        if (to > from) (to - from) / 1000.0 else null
    }
    val ended = history.filter { it.ending == QuitRun.Ending.SLIP }
    return QuitStats(
        slips = allSlips.filter { this.today(it) in range },
        cleanDays = clean, days = counted,
        longestRun = inRange.maxOrNull() ?: 0.0,
        averageRun = if (ended.isEmpty()) null else ended.sumOf { it.seconds(now) } / ended.size,
        marks = marks,
    )
}

/** A quit habit's card: the run going on now, and the period's slips. */
fun HabitStore.quitPeriodCard(habit: Habit, span: IntRange, range: ProgressRange, today: Int, now: Long = clock()): PeriodCard {
    val stats = quitStats(habit, span, now)
    val running = today in span
    val perDay = HashMap<Int, Int>()
    for (s in stats.slips) { val d = this.today(s); perDay[d] = (perDay[d] ?: 0) + 1 }
    val strip = stats.marks.map { (day, mark) ->
        val n = perDay[day] ?: 0
        // A day still to come is "coming up" for a quit habit too (every day counts), not "not scheduled".
        val shown = if (day > today && mark == DayMark.NOT_ITS_DAY) DayMark.UPCOMING else mark
        val heat = when {
            shown == DayMark.BEFORE -> HeatCell.Blank
            shown == DayMark.PAUSED -> HeatCell.paused
            day > today -> HeatCell.Upcoming
            n > 0 || shown == DayMark.MISSED -> HeatCell.level(0)
            shown == DayMark.DONE -> HeatCell.level(4)
            else -> HeatCell.Upcoming
        }
        WeekCardDay(day, shown, if (mark == DayMark.DONE) 1.0 else 0.0, false, false, n > 0, false, heat)
    }
    val count = stats.slips.size
    val whenText = if (running) "this ${range.noun}" else "that ${range.noun}"
    val slips = if (count == 0) "No slips $whenText" else if (count == 1) "1 slip $whenText" else "$count slips $whenText"
    val paused = running && isPaused(habit, today)
    if (running && !paused) {
        val current = rules.quitHistory(habit, now).lastOrNull()?.takeIf { it.ending == QuitRun.Ending.ONGOING }?.start
        val headline = current?.let { "Current run " + Format.run((now - it) / 1000.0) } ?: slips
        return PeriodCard(headline, if (current == null) null else slips, strip)
    }
    return PeriodCard(if (paused) "Paused" else slips, if (paused) slips else null, strip)
}

/** "187 clean days since 2 Jan 2026 · 5 slips": a total a slip can't take away. */
fun HabitStore.quitTotalLine(habit: Habit, now: Long = clock()): String {
    val start = rules.quitStartDay(habit)
    val stats = quitStats(habit, start..today(now), now)
    val clean = if (stats.cleanDays == 1) "1 clean day" else "${stats.cleanDays} clean days"
    val slips = if (stats.slips.size == 1) "1 slip" else "${stats.slips.size} slips"
    return "$clean since ${DayWords.long(start)} · $slips"
}

/** "Saved so far: £312": clean days since the start times what it cost a day. Null with no cost. */
fun HabitStore.moneySaved(habit: Habit, now: Long = clock()): String? {
    val cost = costs[habit.id] ?: return null
    if (cost.amount <= 0) return null
    val clean = quitStats(habit, rules.quitStartDay(habit)..today(now), now).cleanDays
    return "Saved so far: " + HabitCopy.amount(Math.rint(clean * cost.amount), cost.currency)
}

/** The live run: "12 d 4 h 31 min 07 s", "4 h 31 min 07 s", "31 min 07 s". */
fun quitClock(seconds: Double): String {
    val s = max(0L, seconds.toLong())
    val d = s / 86400
    val h = s % 86400 / 3600
    val m = s % 3600 / 60
    val sec = s % 60
    val tail = "%d min %02d s".format(m, sec)
    return if (d > 0) "$d d $h h $tail" else if (h > 0) "$h h $tail" else tail
}

/** Milestones for a quit run: 1, 3, 7 … 730 days, then every year after two, up to at least a year past [days]. */
fun quitMilestoneLadder(days: Int): List<Int> {
    val ladder = mutableListOf(1, 3, 7, 10, 14, 30, 45, 60, 90, 120, 180, 270, 365, 500, 730)
    var year = 1095
    while (year <= max(days, 730) + 365) { ladder.add(year); year += 365 }
    return ladder
}

/** "1 day", "30 days", "1 year", "3 years". */
fun quitMilestoneName(days: Int): String {
    if (days >= 365 && days % 365 == 0) return if (days == 365) "1 year" else "${days / 365} years"
    return if (days == 1) "1 day" else "$days days"
}

// ---------------------------------------------------------------------------------------------------------- History

/** One row of a habit's History: a day that was scheduled, or has a log, a skip or a note. */
data class HistoryDay(
    val day: Int,
    val heat: HeatCell,
    /** "Sat 3". */
    val title: String,
    /** "Today", "Yesterday", or null. */
    val relative: String?,
    /** "8/8 glasses · 2 logs", "Skipped", "Not done". */
    val detail: String,
    /** The day's note, shown under it (Figma 2.1: each day's logs, then its note). */
    val note: String?,
) {
    val hasNote: Boolean get() = note != null
}

/** One month's card in History, newest first. */
data class HistoryMonth(
    val first: Int,
    /** "October 2026". */
    val title: String,
    /** The month on the goal's own clock: "Reached on 12 of 12 days so far". */
    val summary: String,
    /** Newest first. */
    val days: List<HistoryDay>,
) {
    val key: String get() = "history-" + dayKey(first)
}

/** Every month with a row, newest first. A row for each scheduled day before today, and every day with a log, a skip
 *  or a note (Figma 2.1–2.3: today joins once something is logged or written). A quit habit has no scheduled days: its
 *  rows are slips and notes. A past planned day with nothing logged says "Not done" (Figma 2.2), neutral grey (U3). */
fun HabitStore.history(habit: Habit, today: Int): List<HistoryMonth> {
    val quit = habit.kind == HabitKind.Quit
    val start = if (quit) rules.quitStartDay(habit) else rules.startDay(habit)
    if (start > today) return emptyList()
    val now = clock()
    val months = ArrayList<HistoryMonth>()
    var first = pageFirstOfMonth(today)
    while (true) {
        val span = rules.period(PeriodKind.MONTH, first)
        if (span.last < start) break
        val card = if (quit) quitPeriodCard(habit, span, ProgressRange.MONTH, today, now) else periodCard(habit, span, ProgressRange.MONTH, today)
        val count = span.last - span.first + 1
        val heat = card?.days?.takeIf { it.size == count }?.map { it.heat }
        val rows = ArrayList<HistoryDay>()
        var day = min(span.last, today)
        val earliest = max(span.first, start)
        while (day >= earliest) {
            val logs = entries(habit.id, day)
            val note = note(habit, day)?.takeIf { it.isNotBlank() }
            val skipped = isSkipped(habit, day)
            val due = !quit && day < today && rule(habit, day).frequency.isDayBased && rules.isDue(habit, day)
            if (due || logs.isNotEmpty() || note != null || skipped) {
                rows.add(HistoryDay(day, heat?.getOrNull(day - span.first) ?: HeatCell.Blank, historyDayTitle(day),
                    DayWords.relative(day, today), historyDetail(habit, day, logs, skipped, today), note))
            }
            day--
        }
        if (rows.isNotEmpty()) months.add(HistoryMonth(first, historyMonthTitle(first), card?.headline ?: "", rows))
        first = pageFirstOfMonth(span.first - 1)
    }
    return months
}

/** What a History row says about its day ("logs", never "entries": U21). */
private fun HabitStore.historyDetail(habit: Habit, day: Int, logs: List<Entry>, skipped: Boolean, today: Int): String {
    if (isPaused(habit, day) && logs.isEmpty()) return "Paused"
    if (skipped) return "Skipped"
    if (logs.isEmpty()) {
        if (habit.kind == HabitKind.Quit) return "Note only"
        return if (day == today) "Nothing logged yet" else "Not done"
    }
    if (habit.kind == HabitKind.Quit) return if (logs.size == 1) "1 slip" else "${logs.size} slips"
    val result = dayResult(habit, day)
    val counted = logs.count { it.stepId == null }
    val rule = rule(habit, day)
    return when (rule.kind) {
        is HabitKind.Amount, HabitKind.Duration -> result + (if (counted == 1) " · 1 log" else " · $counted logs")
        HabitKind.Check -> if (pageDayGoal(rule) > 1 && counted > 1) "$result · $counted logs" else result
        else -> result
    }
}

// ---------------------------------------------------------------------------------------------------------- Notes

/** One day's note in the Notes tab. */
data class NoteItem(val day: Int, val text: String, val title: String, val relative: String?)

/** One month of notes, newest first: a card like History's month. */
data class NoteMonth(val first: Int, val title: String, val notes: List<NoteItem>) {
    /** Never the same as a History month's key: both tabs share one lazy list. */
    val key: String get() = "notes-" + dayKey(first)
    /** "3 notes". */
    val summary: String get() = if (notes.size == 1) "1 note" else "${notes.size} notes"
}

/** [notes] (newest first, as `HabitStore.notes`) by month. */
fun noteMonths(notes: List<Pair<Int, String>>, today: Int): List<NoteMonth> {
    val months = ArrayList<NoteMonth>()
    for ((day, text) in notes) {
        val first = pageFirstOfMonth(day)
        val item = NoteItem(day, text, historyDayTitle(day), DayWords.relative(day, today))
        val last = months.lastOrNull()
        if (last != null && last.first == first) months[months.size - 1] = last.copy(notes = last.notes + item)
        else months.add(NoteMonth(first, historyMonthTitle(first), listOf(item)))
    }
    return months
}

/** The notes whose text has [query], by month; every note while the query is empty. */
fun matchingNotes(months: List<NoteMonth>, query: String): List<NoteMonth> {
    val q = query.trim()
    if (q.isEmpty()) return months
    return months.mapNotNull { m ->
        val notes = m.notes.filter { it.text.contains(q, ignoreCase = true) }
        if (notes.isEmpty()) null else m.copy(notes = notes)
    }
}

// ---------------------------------------------------------------------------------------------------------- Overall record

/** One box of the Overall record: its label, the number with its unit after it, and an optional line under it. */
data class RecordFact(val title: String, val number: String, val unit: String, val detail: String?, val spoken: String)

/** The Overall record card: the accumulated record since the habit began, with the streaks in it. */
data class HabitOverall(
    /** The main fact in parts: "Done on" · "196" · "days", "" · "184" · "glasses recorded". */
    val lead: String,
    val value: String,
    val trail: String,
    val met: Int,
    val eligible: Int,
    /** "Since 2 Sep 2026". */
    val since: String,
    val current: RecordFact?,
    val best: RecordFact?,
    val goalMet: RecordFact?,
    /** "of planned days", "of days", "of weeks". */
    val percentNoun: String,
    val bestPeriod: RecordFact?,
    /** `metDates[k]` is the day the goals met reached k + 1. */
    val metDates: List<Int>,
    /** Every kind of goal period the habit has had. */
    val kinds: Set<GoalPeriod>,
) {
    val headline: String get() = listOf(lead, value, trail).filter { it.isNotEmpty() }.joinToString(" ")
}

/** Goals met in a kind's periods, out of those that could be met. */
class GoalTally {
    var met = 0
    var eligible = 0
    val dates = ArrayList<Int>()
    var bestValue = 0.0
    var bestRange: IntRange? = null
}

/** Goals met in [kind]'s periods: each planned day (or week, month, year) that has ended, and the running one once met.
 *  Only periods of that kind count, each dated the day its goal was reached. [best]: also the period with the most
 *  recorded. */
fun HabitStore.goalTally(habit: Habit, kind: GoalPeriod, today: Int, best: Boolean = false): GoalTally {
    val tally = GoalTally()
    val start = rules.startDay(habit)
    var day = start
    if (kind == GoalPeriod.DAY) {
        while (day <= today) {
            val r = rule(habit, day)
            if (pagePeriodKind(r) == GoalPeriod.DAY && !isPaused(habit, day) && !isSkipped(habit, day) && rules.isDue(habit, day)) {
                val isMet = rules.isDayMet(habit, day)
                if (day < today || isMet) {
                    tally.eligible++
                    if (isMet) { tally.met++; tally.dates.add(day) }
                }
            }
            day++
        }
        return tally
    }
    while (day <= today) {
        val r = rule(habit, day)
        val range = goalPeriodRange(r, day)
        if (pagePeriodKind(r) != kind || range == null) { day++; continue }
        val ended = range.last < today
        val isMet = !(r.atMost && !ended) && rules.isPeriodMet(habit, day)
        if ((ended && !rules.hasPause(habit, range)) || isMet) {
            tally.eligible++
            if (isMet) { tally.met++; tally.dates.add(metDay(habit, r, range, today)) }
        }
        if (best) {
            var value = 0.0
            for (d in max(range.first, start)..min(range.last, today)) value += rules.dayProgress(habit, d)
            if (value > tally.bestValue) { tally.bestValue = value; tally.bestRange = range }
        }
        day = range.last + 1
    }
    return tally
}

/** The day a week's (month's, year's) goal was reached: the day of the log that met it. A limit is kept when its period
 *  ends. */
private fun HabitStore.metDay(habit: Habit, rule: Habit, range: IntRange, today: Int): Int {
    val last = min(range.last, today)
    if (rule.atMost) return last
    val f = rule.frequency
    val needed = if (f is Frequency.Flexible) f.n.toDouble() else if (pageIsTotal(rule)) rule.goal else pageGoal(rule)
    val countsDays = f.isFlexible || !(pageIsTotal(rule) || rule.kind == HabitKind.Check)
    var sum = 0.0
    var day = max(range.first, rules.startDay(habit))
    while (day <= last) {
        if (countsDays) { if (rules.isDayMet(habit, day)) sum += 1 }
        else for (e in entries(habit.id, day)) if (e.stepId == null) sum += e.value
        if (sum >= needed) return day
        day++
    }
    return last
}

/** The habit's accumulated record since it began, walked once per data change. */
fun HabitStore.habitRecord(habit: Habit, today: Int): HabitOverall {
    val start = rules.startDay(habit)
    val since = "Since " + DayWords.long(start)
    val now = rule(habit, today)
    val shape = progressShape(now)
    val kind = pagePeriodKind(now)
    if (start > today) {
        return HabitOverall("", "Not started yet", "", 0, 0, since, null, null, null, "", null, emptyList(), setOf(kind))
    }
    var total = 0.0
    var bestValue = 0.0
    var bestDay: Int? = null
    var doneDays = 0
    val kinds = HashSet<GoalPeriod>()
    val hasHistory = !goalRules[habit.id].isNullOrEmpty()
    if (!hasHistory) kinds.add(kind)
    for (day in start..today) {
        if (hasHistory) kinds.add(pagePeriodKind(rule(habit, day)))
        val value = rules.dayProgress(habit, day)
        total += value
        if (value > bestValue) { bestValue = value; bestDay = day }
        if (value > 0) doneDays++
    }
    val tally = goalTally(habit, kind, today, best = kind != GoalPeriod.DAY && !now.atMost)

    var lead = ""
    val value: String
    val trail: String
    when (shape) {
        ProgressShape.ONCE -> { lead = "Done on"; value = HabitCopy.number(doneDays.toDouble()); trail = if (doneDays == 1) "day" else "days" }
        ProgressShape.CHECKLIST -> { value = HabitCopy.number(total); trail = HabitCopy.unitWord(total, "steps") + " done" }
        else -> {
            val parts = amountParts(total, now)
            value = parts.first
            trail = if (parts.second.isEmpty()) "recorded" else parts.second + " recorded"
        }
    }

    // The streak, in today's goal's unit, as Today's row counts it.
    val unit = now.frequency.streakUnit
    val runs = rules.runs(habit, today)
    val current = runs.lastOrNull()?.let { if (it.isCurrent) it.length else 0 } ?: 0
    val best = runs.maxOfOrNull { it.length } ?: 0
    val bestRun = if (best > 0) runs.lastOrNull { it.length == best } else null
    // A period goal's running week (month, year), so "3 weeks" doesn't look stale midweek; limits wait for the end.
    var thisPeriod: String? = null
    val periodRange = goalPeriodRange(now, today)
    if (kind != GoalPeriod.DAY && !now.atMost && periodRange != null) {
        val name = "This " + kind.noun + ": "
        val f = now.frequency
        thisPeriod = when {
            rules.isPeriodMet(habit, today) -> name + "done"
            f is Frequency.Flexible -> name + "${rules.flexibleProgress(habit, today) ?: 0} of ${f.n} days"
            pageIsTotal(now) -> name + progressValue(rules.periodTotal(habit, periodRange), now) + " of " + progressValue(now.goal, now)
            else -> name + HabitCopy.number(rules.periodCount(now, periodRange)) + " of " + HabitCopy.number(pageGoal(now))
        }
    }
    // Figma 1373:2, 1.1: the run going on now says when it began ("Since 20 Sep").
    val runSince = runs.lastOrNull()?.takeIf { it.isCurrent && it.length > 0 }?.let { "Since " + pageShortDate(it.start, today) }
    val currentFact = RecordFact("Current streak", HabitCopy.number(current.toDouble()), unit.word(current), thisPeriod ?: runSince,
        "Current streak, $current ${unit.word(current)}" + (thisPeriod?.let { ". $it" } ?: ""))
    val bestFact = RecordFact("Best streak", HabitCopy.number(best.toDouble()), unit.word(best),
        bestRun?.let { pageDaySpan(it.start, it.end, today) },
        "Best streak, $best ${unit.word(best)}" + (bestRun?.let { ", " + pageSpokenSpan(it.start, it.end, today) } ?: ""))

    fun periods(n: Int): String = when (kind) {
        GoalPeriod.DAY -> if (n == 1) "day" else "days"
        GoalPeriod.WEEK -> if (n == 1) "week" else "weeks"
        GoalPeriod.MONTH -> if (n == 1) "month" else "months"
        GoalPeriod.YEAR -> if (n == 1) "year" else "years"
    }
    val goalTitle = if (shape == ProgressShape.CHECKLIST) "Every step" else if (now.atMost) "Within the limit" else "Goal met"
    val goalMet = if (tally.eligible > 0) RecordFact(goalTitle, HabitCopy.number(tally.met.toDouble()),
        "of ${tally.eligible} ${periods(tally.eligible)}", null, "$goalTitle, ${tally.met} of ${tally.eligible} ${periods(tally.eligible)}") else null
    // "58% of days" (Figma 1373:2, 1.1): the days counted are the planned ones, as "of 40 days" above it says.
    val percentNoun = if (kind == GoalPeriod.DAY) "of days" else "of " + periods(2)

    // Best day: only where a day can hold more than one (amounts, time, several checks a day). Best week, month or year
    // for a period goal: the period with the most recorded. Limits have neither.
    var bestPeriod: RecordFact? = null
    val countsAmounts = now.kind == HabitKind.Duration || now.kind is HabitKind.Amount || (now.kind == HabitKind.Check && pageDayGoal(now) > 1)
    val bestRange = tally.bestRange
    if (kind == GoalPeriod.DAY && bestDay != null && countsAmounts && !now.atMost && bestValue > 0) {
        val parts = amountParts(bestValue, rule(habit, bestDay))
        val words = listOf(parts.first, parts.second).filter { it.isNotEmpty() }.joinToString(" ")
        bestPeriod = RecordFact("Best day", parts.first, parts.second, pageShortDate(bestDay, today),
            "Best day, $words, " + pageSpokenDate(bestDay, today))
    } else if (kind != GoalPeriod.DAY && bestRange != null && tally.bestValue > 0) {
        val parts = amountParts(tally.bestValue, now)
        val words = listOf(parts.first, parts.second).filter { it.isNotEmpty() }.joinToString(" ")
        val dates: String
        val spoken: String
        when (kind) {
            GoalPeriod.WEEK -> { dates = pageDaySpan(bestRange.first, bestRange.last, today); spoken = pageSpokenSpan(bestRange.first, bestRange.last, today) }
            GoalPeriod.MONTH -> {
                val year = if (pageYear(bestRange.first) == pageYear(today)) "" else " ${pageYear(bestRange.first)}"
                dates = pageMonthShort(pageMonth(bestRange.first)) + year
                spoken = HabitCopy.monthNames[pageMonth(bestRange.first) - 1] + year
            }
            else -> { dates = pageYear(bestRange.first).toString(); spoken = dates }
        }
        bestPeriod = RecordFact("Best " + kind.noun, parts.first, parts.second, dates, "Best ${kind.noun}, $words, $spoken")
    }
    return HabitOverall(lead, value, trail, tally.met, tally.eligible, since, currentFact, bestFact, goalMet, percentNoun,
        bestPeriod, tally.dates, kinds)
}

// ---------------------------------------------------------------------------------------------------------- Comparisons

/** This period against the one before, on the same footing. [note] replaces the rows when there's nothing to compare. */
data class PeriodComparison(
    val title: String,
    val thisLabel: String,
    val previousLabel: String,
    val thisText: String,
    val previousText: String,
    val thisValue: Double?,
    val previousValue: Double?,
    val note: String?,
)

/** [span] against the period before it. While [span] is running, both sides cover the same completed days (today, still
 *  open, is left out of both); a habit that began after the earlier period started has nothing to compare. */
fun HabitStore.periodComparison(habit: Habit, span: IntRange, week: Boolean, today: Int): PeriodComparison? {
    val noun = if (week) "week" else "month"
    val start = if (habit.kind == HabitKind.Quit) rules.quitStartDay(habit) else rules.startDay(habit)
    if (span.first > today) return null
    val previousStart = if (week) span.first - 7 else rules.period(PeriodKind.MONTH, span.first - 1).first
    val previousFull = rules.period(if (week) PeriodKind.WEEK else PeriodKind.MONTH, previousStart)
    val running = today in span
    val completed = if (running) today - span.first else span.last - span.first + 1
    val monthName = { d: Int -> HabitCopy.monthNames[pageMonth(d) - 1] }
    val thisLabel = if (running) "This $noun" else if (week) "That week" else monthName(span.first)
    val previousLabel = if (week) (if (running) "Last week" else "The week before") else monthName(previousFull.first)
    if (previousFull.first < start) {
        val note = if (start <= previousFull.last) "Started on ${DayWords.dayMonth(start)}, partway through ${if (week) previousLabel.lowercase() else previousLabel}"
        else "No earlier $noun to compare"
        return PeriodComparison("Compared with the $noun before", thisLabel, previousLabel, "", "", null, null, note)
    }
    if (completed <= 0) {
        return PeriodComparison("Compared with last $noun", thisLabel, previousLabel, "", "", null, null, "Compared once today is over")
    }
    val thisRange = span.first..(span.first + completed - 1)
    val previousLength = previousFull.last - previousStart + 1
    val previousRange = previousStart..(previousStart + min(completed, previousLength) - 1)
    val title = if (running) (if (completed == 1) "Same first day last $noun" else "Same $completed days last $noun")
    else "Compared with the $noun before"
    val rule = rule(habit, min(thisRange.last, today))
    if (habit.kind == HabitKind.Quit) {
        val a = thisRange.sumOf { entries(habit.id, it).size }
        val b = previousRange.sumOf { entries(habit.id, it).size }
        fun slips(n: Int) = if (n == 1) "1 slip" else "$n slips"
        return PeriodComparison(title, thisLabel, previousLabel, slips(a), slips(b), a.toDouble(), b.toDouble(), null)
    }
    return when (progressShape(rule)) {
        ProgressShape.ONCE, ProgressShape.CHECKLIST -> {
            fun goalDays(range: IntRange): Pair<Int, Int> {
                var met = 0
                var planned = 0
                for (day in range) if (rules.isDue(habit, day)) { planned++; if (rules.isDayMet(habit, day)) met++ }
                return met to planned
            }
            fun text(x: Pair<Int, Int>) = "${x.first} of ${if (x.second == 1) "1 day" else "${x.second} days"}"
            val a = goalDays(thisRange)
            val b = goalDays(previousRange)
            PeriodComparison(title, thisLabel, previousLabel, text(a), text(b), a.first.toDouble(), b.first.toDouble(), null)
        }
        else -> {
            val a = thisRange.sumOf { rules.dayProgress(habit, it) }
            val b = previousRange.sumOf { rules.dayProgress(habit, it) }
            val text = { v: Double -> if (rule.kind == HabitKind.Check) HabitCopy.amount(v, rule.checkUnit ?: "times") else progressValue(v, rule) }
            PeriodComparison(title, thisLabel, previousLabel, text(a), text(b), a, b, null)
        }
    }
}

/** The amount recorded each day of a month (amounts, time, counts), for "Recorded each day"; 0 on days before the
 *  habit began or still to come. Null when the habit records no amounts or nothing was recorded. Also the day goal for
 *  the dashed line, where a day has one. */
fun HabitStore.recordedEachDay(habit: Habit, span: IntRange, today: Int): Pair<List<Double>, Double?>? {
    if (habit.kind == HabitKind.Quit) return null
    val first = rules.startDay(habit)
    val rule = rule(habit, min(span.last, today))
    val shape = progressShape(rule)
    if (shape !in setOf(ProgressShape.TIMES, ProgressShape.AMOUNT, ProgressShape.TIME, ProgressShape.PERIOD_TOTAL, ProgressShape.LIMIT_DAY)) return null
    val values = span.map { day -> if (day <= today && day >= first) rules.dayProgress(habit, day) else 0.0 }
    if (values.none { it > 0 }) return null
    val goal = if (rule.frequency.isDayBased && !rule.frequency.isFlexible && pageDayGoal(rule) > 0) pageDayGoal(rule) else null
    return values to goal
}

// ---------------------------------------------------------------------------------------------------------- Milestones

/** One milestone reached: a medal. Worked out from the records each time (never stored); a value is reached once,
 *  dated by the first run that reached it, and earlier goals keep theirs in their own unit. */
data class Milestone(
    val track: Track,
    val value: Int,
    val reached: Int,
    /** On the medal: "30", or "1" for a year since a slip. */
    val number: String,
    /** "3 days in a row", "10 weeks of goals met", "30 days since a slip". */
    val title: String,
    val shelfTop: String,
    val shelfBottom: String,
    val pageCaption: String,
    val pageDate: String,
    /** "Reached 28 Sep". */
    val reachedText: String,
    val spoken: String,
    val id: String,
) {
    enum class Track(val key: String) { IN_A_ROW("inARow"), IN_TOTAL("inTotal"), ANNIVERSARY("anniversary"), SINCE_SLIP("sinceSlip") }
}

/** A track's next milestone: only the next one is drawn, never the ones after it. */
data class MilestoneNext(
    val track: Milestone.Track,
    /** The ring's number; null once every milestone of the track is reached. */
    val target: Int?,
    val number: String,
    val title: String,
    /** The All milestones page's row: "Next: 50 days in a row". */
    val pageTitle: String,
    /** "7 to go · now 23", "2 to go · 23 so far". */
    val detail: String?,
    /** Current ÷ target. */
    val fraction: Double,
    val spoken: String,
)

data class HabitMilestones(val reached: List<Milestone>, val next: List<MilestoneNext>, val totalLabel: String = "In total") {
    /** Show Streaks off: no in-a-row medals or Next row, and no days since a slip; totals and anniversaries stay. */
    fun shown(streaks: Boolean): HabitMilestones = if (streaks) this
    else copy(reached = reached.filter { it.track.keepsWithoutStreaks }, next = next.filter { it.track.keepsWithoutStreaks })

    companion object {
        val none = HabitMilestones(emptyList(), emptyList())
    }
}

private val Milestone.Track.keepsWithoutStreaks: Boolean
    get() = this == Milestone.Track.IN_TOTAL || this == Milestone.Track.ANNIVERSARY

/** "7 days in a row", "8 weeks in a row". */
fun milestoneRowTitle(n: Int, unit: StreakUnit): String = "$n ${unit.word(n)} in a row"

/** What a total counts: "times" for day goals, days within a day limit, else the goal's period. */
fun milestonePeriodWord(n: Int, kind: GoalPeriod, atMost: Boolean): String = when (kind) {
    GoalPeriod.DAY -> if (atMost) (if (n == 1) "day" else "days") else (if (n == 1) "time" else "times")
    GoalPeriod.WEEK -> if (n == 1) "week" else "weeks"
    GoalPeriod.MONTH -> if (n == 1) "month" else "months"
    GoalPeriod.YEAR -> if (n == 1) "year" else "years"
}

/** "10 times in total", "10 weeks of goals met", "10 days within the limit". */
fun milestoneTotalTitle(n: Int, kind: GoalPeriod, atMost: Boolean): String {
    val word = milestonePeriodWord(n, kind, atMost)
    if (atMost) return "$n $word within the limit"
    return if (kind == GoalPeriod.DAY) "$n $word in total" else "$n $word of goals met"
}

/** A track's next milestone, measured from where the person is now (current ÷ target). */
fun milestoneNextRow(track: Milestone.Track, target: Int?, number: String, title: String, current: Int, best: Int?): MilestoneNext {
    if (target == null) {
        val detail = "${HabitCopy.number(current.toDouble())} so far"
        return MilestoneNext(track, null, "", "Every milestone reached", "Every milestone reached", detail, 1.0,
            "Every milestone reached, $detail.")
    }
    val toGo = max(0, target - current)
    var detail = "${HabitCopy.number(toGo.toDouble())} to go"
    var spoken = "Next: $title, $toGo to go."
    if (track == Milestone.Track.IN_TOTAL) {
        if (current > 0) { detail += " · ${HabitCopy.number(current.toDouble())} so far"; spoken += " $current so far." }
    } else if (current > 0) {
        if (best != null && best > current) { detail += " · now $current, best $best"; spoken += " Now $current, best $best." }
        else { detail += " · now $current"; spoken += " Now $current." }
    }
    return MilestoneNext(track, target, number, title, "Next: $title", detail, min(1.0, current.toDouble() / max(1, target)), spoken)
}

/** One medal's words, made once. */
fun pageMilestone(
    track: Milestone.Track, n: Int, key: String, number: String, title: String, shelfTop: String, shelfBottom: String?,
    pageCaption: String, day: Int, today: Int,
): Milestone {
    val thisYear = pageYear(day) == pageYear(today)
    val short = if (thisYear) DayWords.dayMonth(day) else pageMonthShort(pageMonth(day)) + " " + pageYear(day)
    return Milestone(track, n, day, number, title, shelfTop, shelfBottom ?: short, pageCaption, DayWords.long(day),
        "Reached " + pageShortDate(day, today), title + ", reached " + pageDate(day).format(spokenYearFormat),
        "${track.key}-$key-$n")
}

private val newestFirst = Comparator<Milestone> { a, b ->
    when {
        a.reached != b.reached -> b.reached.compareTo(a.reached)
        a.track != b.track -> if (a.track == Milestone.Track.IN_A_ROW) -1 else if (b.track == Milestone.Track.IN_A_ROW) 1 else 0
        else -> b.value.compareTo(a.value)
    }
}

/** The milestones a habit has reached and the next of each track: in a row, from the runs; in total, from the goals
 *  met; for a quit habit, days since a slip. Earlier goals keep what was reached in them, in their own unit; the Next
 *  rows follow today's goal. */
fun HabitStore.habitMilestones(habit: Habit, record: HabitOverall, today: Int): HabitMilestones {
    if (habit.kind == HabitKind.Quit) return quitMilestones(habit, today)
    if (habit.kind == HabitKind.Task || rules.startDay(habit) > today) return HabitMilestones.none
    val now = rule(habit, today)
    // The decided rule (Milestones, 17 Oct 2026; Figma 1373:2, 1735:4), the pop-ups' own: in a row and in total by the
    // habit's bucket, plus anniversaries. A cut-down habit keeps counting days within the limit, below.
    if (!now.atMost) return decidedMilestones(habit, now, today)
    val kind = pagePeriodKind(now)
    val unit = now.frequency.streakUnit
    val runs = rules.runs(habit, today)
    val current = runs.lastOrNull()?.let { if (it.isCurrent) it.length else 0 } ?: 0
    val best = runs.maxOfOrNull { it.length } ?: 0
    val reached = ArrayList<Milestone>()
    reached += rowMilestones(habit, runs, unit, today)
    reached += totalMilestones(record.metDates, kind, now.atMost, today)
    // Earlier goals of another kind (a week goal changed to a day goal): their runs and totals in their own unit.
    for (other in (record.kinds - kind).sortedBy { it.key }) {
        val theirs = rules.runs(habit, today, other)
        theirs.firstOrNull()?.let { reached += rowMilestones(habit, theirs, rule(habit, it.start).frequency.streakUnit, today) }
        val tally = goalTally(habit, other, today)
        tally.dates.firstOrNull()?.let { reached += totalMilestones(tally.dates, other, rule(habit, it).atMost, today) }
    }
    reached.sortWith(newestFirst)

    val target = rules.nextMilestone(unit, best)
    val row = milestoneNextRow(Milestone.Track.IN_A_ROW, target, "$target", milestoneRowTitle(target, unit), current, best)
    val totalTarget = rules.totalMilestones(kind).firstOrNull { it > record.met }
    val total = milestoneNextRow(Milestone.Track.IN_TOTAL, totalTarget, totalTarget?.toString() ?: "",
        totalTarget?.let { milestoneTotalTitle(it, kind, now.atMost) } ?: "", record.met, null)
    return HabitMilestones(reached, listOf(row, total))
}

/** Each in-a-row milestone reached, dated by the first run that reached it: a run only adds the values above every run
 *  before it, so it's walked once for all of them. */
private fun HabitStore.rowMilestones(habit: Habit, runs: List<Run>, unit: StreakUnit, today: Int): List<Milestone> {
    val reached = ArrayList<Milestone>()
    var longest = 0
    for (run in runs) {
        if (run.length <= longest) continue
        val values = rules.milestonesUpTo(unit, run.length).filter { it > longest }
        longest = run.length
        if (values.isEmpty()) continue
        val days = countedDays(habit, run, values, today)
        for (n in values) {
            val day = days[n] ?: continue
            val daily = unit == StreakUnit.DAYS || unit == StreakUnit.TIMES
            reached.add(pageMilestone(Milestone.Track.IN_A_ROW, n, unit.name.lowercase(), "$n", milestoneRowTitle(n, unit),
                if (daily) "$n in a row" else "$n ${unit.word(n)}", if (daily) null else "in a row", "$n ${unit.word(n)}", day, today))
        }
    }
    return reached
}

/** The total milestones reached: `dates[k]` is the day the goals met reached k + 1. */
private fun HabitStore.totalMilestones(dates: List<Int>, kind: GoalPeriod, atMost: Boolean, today: Int): List<Milestone> =
    rules.totalMilestones(kind).filter { it <= dates.size }.map { n ->
        val word = milestonePeriodWord(n, kind, atMost)
        pageMilestone(Milestone.Track.IN_TOTAL, n, kind.key + (if (atMost) "-limit" else ""), "$n", milestoneTotalTitle(n, kind, atMost),
            if (kind == GoalPeriod.DAY) "$n in total" else "$n $word",
            if (kind == GoalPeriod.DAY) null else if (atMost) "within limit" else "goals met", "$n $word", dates[n - 1], today)
    }

/** The day a run reached each of [values] counted days (or weeks, months), in one walk from its start. */
private fun HabitStore.countedDays(habit: Habit, run: Run, values: List<Int>, today: Int): Map<Int, Int> {
    val wanted = values.toHashSet()
    val found = HashMap<Int, Int>()
    var count = 0
    var day = run.start
    while (day <= run.end && wanted.isNotEmpty()) {
        val r = rule(habit, day)
        if (pagePeriodKind(r) == GoalPeriod.DAY) {
            if ((rules.isDue(habit, day) || day == today) && rules.isDayMet(habit, day)) {
                count++
                if (wanted.remove(count)) found[count] = day
            }
            day++
        } else {
            val range = goalPeriodRange(r, day)
            if (range == null) { day++; continue }
            if (rules.isPeriodMet(habit, day)) {
                count++
                if (wanted.remove(count)) found[count] = metDay(habit, r, range, today)
            }
            day = range.last + 1
        }
    }
    return found
}

/** A quit habit's one track, days since a slip: each value reached in the first run long enough, at its start plus that
 *  many days. */
private fun HabitStore.quitMilestones(habit: Habit, today: Int): HabitMilestones {
    val now = clock()
    val history = rules.quitHistory(habit, now)
    val current = history.lastOrNull()?.let { if (it.ending == QuitRun.Ending.ONGOING) (it.seconds(now) / 86400).toInt() else 0 } ?: 0
    val best = ((history.maxOfOrNull { it.seconds(now) } ?: 0.0) / 86400).toInt()
    val ladder = quitMilestoneLadder(best)
    fun number(n: Int) = if (n >= 365 && n % 365 == 0) "${n / 365}" else "$n"
    val reached = ArrayList<Milestone>()
    for (n in ladder) {
        if (n > best) continue
        val run = history.firstOrNull { (it.seconds(now) / 86400).toInt() >= n } ?: continue
        val day = this.today(run.start + n * 86_400_000L)
        val name = quitMilestoneName(n)
        reached.add(pageMilestone(Milestone.Track.SINCE_SLIP, n, "days", number(n), "$name since a slip", name, "since a slip", name, day, today))
    }
    reached.sortWith(newestFirst)
    val target = ladder.firstOrNull { it > best }
    val next = milestoneNextRow(Milestone.Track.SINCE_SLIP, target, target?.let { number(it) } ?: "",
        target?.let { quitMilestoneName(it) + " since a slip" } ?: "", current, best)
    return HabitMilestones(reached, listOf(next))
}

// ---------------------------------------------------------------------------------------------------------- Habit details, 19 Oct 2026

/** The days of [span] that have a note, as indexes into it (a dot under the square, Figma 1373:2, 3.3, 3.6). */
fun HabitStore.noteIndexes(habit: Habit, span: IntRange): Set<Int> {
    val out = HashSet<Int>()
    for ((day, text) in notes(habit)) if (day in span && text.isNotBlank()) out.add(day - span.first)
    return out
}

/**
 * What an amount habit recorded each day of [span], under its square (Figma 3.5: "22", "0", "12"): from the start to
 * today; nothing for days to come or before it began. Null for a habit that isn't counted in amounts or minutes.
 */
fun HabitStore.amountsUnder(habit: Habit, span: IntRange, today: Int): List<String>? {
    val rule = rule(habit, today)
    if (rule.kind !is HabitKind.Amount && rule.kind != HabitKind.Duration) return null
    val start = rules.startDay(habit)
    return span.map { day -> if (day < start || day > today) "" else HabitCopy.number(Math.rint(rules.dayProgress(habit, day))) }
}

/**
 * A week goal's Week column on the month (Figma 3.4: "Met", "1 of 3"), one label per row of the grid; each row is a week
 * on the person's week start. Null for a goal that isn't counted by the week. Weeks to come say nothing.
 */
fun HabitStore.weekLabels(habit: Habit, span: IntRange, lead: Int, today: Int): List<String>? {
    val rule = rule(habit, today)
    if (pagePeriodKind(rule) != GoalPeriod.WEEK) return null
    val start = rules.startDay(habit)
    val rows = (lead + (span.last - span.first + 1) + 6) / 7
    return (0 until rows).map { r ->
        val day = span.first - lead + r * 7
        val week = rules.period(PeriodKind.WEEK, day)
        if (week.first > today || week.last < start) return@map ""
        val r0 = rule(habit, minOf(week.last, today))
        val f = r0.frequency
        when {
            rules.isPeriodMet(habit, minOf(week.last, today)) -> "Met"
            f is Frequency.Flexible -> "${rules.flexibleProgress(habit, minOf(week.last, today)) ?: 0} of ${f.n}"
            pageIsTotal(r0) -> progressValue(rules.periodTotal(habit, week), r0) + " of " + progressValue(r0.goal, r0)
            else -> HabitCopy.number(rules.periodCount(r0, week)) + " of " + HabitCopy.number(pageGoal(r0))
        }
    }
}

/** One run on the Streaks page (Figma 3.2): its length in words, its dates, and how long it is beside the longest. */
data class StreakRow(val length: String, val dates: String, val fraction: Float, val isCurrent: Boolean, val spoken: String)

/** Every run worth a row (3 days, weeks … or more), longest first; for a quit habit every run, longest first. */
data class StreakList(val title: String, val since: String, val count: String, val rows: List<StreakRow>, val note: String)

fun HabitStore.streakList(habit: Habit, today: Int): StreakList {
    if (habit.kind == HabitKind.Quit) {
        val now = clock()
        val runs = rules.quitHistory(habit, now).filter { it.seconds(now) >= 60 }.sortedByDescending { it.seconds(now) }
        val longest = runs.firstOrNull()?.seconds(now) ?: 1.0
        val rows = runs.map { r ->
            val first = today(r.start)
            val last = r.end?.let { today(it) } ?: today
            val days = Format.run(r.seconds(now))
            val dates = pageDaySpan(first, last, today) + (if (r.end == null) " · now" else "")
            StreakRow(days, dates, (r.seconds(now) / longest).toFloat(), r.end == null, "$days, " + pageSpokenSpan(first, last, today) + (if (r.end == null) ", going on now" else ""))
        }
        return StreakList("Runs", "Since " + DayWords.long(rules.quitStartDay(habit)), if (rows.size == 1) "1 run" else "${rows.size} runs", rows,
            "Every run, longest first. A slip ends a run.")
    }
    val unit = rule(habit, today).frequency.streakUnit
    val runs = rules.runs(habit, today).filter { it.length >= 3 }.sortedWith(compareByDescending<Run> { it.length }.thenByDescending { it.start })
    val longest = runs.firstOrNull()?.length?.toFloat() ?: 1f
    val rows = runs.map { r ->
        val words = HabitCopy.number(r.length.toDouble()) + " " + unit.word(r.length)
        val dates = pageDaySpan(r.start, r.end, today) + (if (r.isCurrent) " · now" else "")
        StreakRow(words, dates, r.length / longest, r.isCurrent, "$words, " + pageSpokenSpan(r.start, r.end, today) + (if (r.isCurrent) ", going on now" else ""))
    }
    val noun = unit.word(3)
    return StreakList("Streaks", "Since " + DayWords.long(rules.startDay(habit)), if (rows.size == 1) "1 run" else "${rows.size} runs", rows,
        "Runs of 3 $noun or more, longest first. Skipped and paused days don't end a run.")
}

/** A quit habit's record (Figma 3.9): the run now, the longest, the slips and the days with none. */
data class QuitRecord(
    val since: String, val runStart: Long?, val current: RecordFact, val longest: RecordFact, val slips: RecordFact, val clean: RecordFact,
)

fun HabitStore.quitRecord(habit: Habit, today: Int): QuitRecord {
    val now = clock()
    val start = rules.quitStartDay(habit)
    val history = rules.quitHistory(habit, now)
    val ongoing = history.lastOrNull()?.takeIf { it.ending == QuitRun.Ending.ONGOING }
    val currentDays = ongoing?.let { (it.seconds(now) / 86400).toInt() } ?: 0
    val best = history.maxByOrNull { it.seconds(now) }
    val bestDays = best?.let { (it.seconds(now) / 86400).toInt() } ?: 0
    val stats = quitStats(habit, start..today, now)
    val lastSlip = stats.slips.maxOrNull()?.let { today(it) }
    fun days(n: Int) = if (n == 1) "day" else "days"
    val current = RecordFact("Current run", HabitCopy.number(currentDays.toDouble()), days(currentDays),
        ongoing?.let { "Since " + pageShortDate(today(it.start), today) }, "Current run, $currentDays ${days(currentDays)}")
    val longest = RecordFact("Longest run", HabitCopy.number(bestDays.toDouble()), days(bestDays),
        best?.let { pageDaySpan(today(it.start), it.end?.let { e -> today(e) } ?: today, today) }, "Longest run, $bestDays ${days(bestDays)}")
    val n = stats.slips.size
    val slips = RecordFact("Slips", HabitCopy.number(n.toDouble()), "since " + DayWords.dayMonth(start),
        lastSlip?.let { "Last on " + pageShortDate(it, today) }, "$n ${if (n == 1) "slip" else "slips"} since " + DayWords.dayMonth(start))
    val total = stats.days
    val clean = RecordFact("Days with no slip", HabitCopy.number(stats.cleanDays.toDouble()), "of $total ${days(total)}",
        if (total > 0) "${Math.round(stats.cleanDays * 100.0 / total)}% of days" else null, "Days with no slip, ${stats.cleanDays} of $total")
    return QuitRecord("Since " + DayWords.long(start), ongoing?.start, current, longest, slips, clean)
}

// ---------------------------------------------------------------------------------------------------------- Milestones, the decided rule

/** The goal for one period: a day's for set days, a week's or month's for a goal over one (ST-8; MilestoneCenter too). */
fun HabitStore.milestonePeriodGoal(ruled: Habit): Double {
    val day = if (ruled.kind == HabitKind.Checklist) 1.0 else rules.dayGoal(ruled)
    return when (val f = ruled.frequency) {
        is Frequency.Flexible -> f.n * day
        is Frequency.PerWeek, is Frequency.PerMonth, is Frequency.PerYear ->
            if (ruled.kind == HabitKind.Checklist) (f as? Frequency.PerWeek)?.n?.toDouble() ?: (f as? Frequency.PerMonth)?.n?.toDouble() ?: 1.0
            else rules.goal(ruled)
        else -> day
    }
}

/** "200 glasses in total", "500 minutes in total", "30 times in total": a total in the habit's own unit. */
fun milestoneTotalWords(ruled: Habit, v: Double): String = when {
    ruled.kind is HabitKind.Amount -> HabitCopy.amount(v, (ruled.kind as HabitKind.Amount).unit) + " in total"
    ruled.kind == HabitKind.Duration -> if (v >= 600 && v % 60 == 0.0) "${Format.amount(v / 60)} hours in total" else "${Format.amount(v)} minutes in total"
    ruled.kind == HabitKind.Check && ruled.checkUnit != null -> "${Format.amount(v)} ${ruled.checkUnit} in total"
    else -> "${Format.amount(v)} times in total"
}

/** "Glasses in total" (Figma 1735:4): the total track's name on All milestones. */
private fun milestoneTotalLabel(ruled: Habit): String = HabitCopy.capitalized(milestoneTotalWords(ruled, 2.0).removePrefix("2 "))

/** A medal's number: "80", "250", "1.5k", "100k": short enough for the badge. */
private fun medalNumber(v: Double): String = when {
    v >= 1_000_000 -> Format.amount(Math.round(v / 100_000) / 10.0) + "M"
    v >= 10_000 -> Format.amount(Math.round(v / 100) / 10.0) + "k"
    else -> Format.amount(v)
}

/** Everything logged up to each day, in the habit's own unit (a checklist: the days all its steps were done), by day. */
private fun HabitStore.totalsByDay(habit: Habit, ruled: Habit, today: Int): List<Pair<Int, Double>> {
    val all = entries(habit.id).filter { it.day <= today }
    if (ruled.kind == HabitKind.Checklist) return all.map { it.day }.distinct().sorted().filter { rules.isDayMet(habit, it) }.map { it to 1.0 }
    return all.filter { it.stepId == null }.groupBy { it.day }.toSortedMap().map { (d, list) -> d to list.sumOf { it.value } }
}

private fun HabitStore.decidedMilestones(habit: Habit, now: Habit, today: Int): HabitMilestones {
    val bucket = rules.milestoneBucket(now)
    val unit = now.frequency.streakUnit
    val runs = rules.runs(habit, today)
    val current = runs.lastOrNull()?.let { if (it.isCurrent) it.length else 0 } ?: 0
    val best = runs.maxOfOrNull { it.length } ?: 0
    val reached = ArrayList<Milestone>()
    val next = ArrayList<MilestoneNext>()
    if (bucket != MilestoneBucket.YEARS) {
        // In a row: each value of the bucket's list, dated by the first run that reached it.
        var longest = 0
        for (run in runs) {
            if (run.length <= longest) continue
            val values = (longest + 1..run.length).filter { bucket.isRowMilestone(it) }
            longest = run.length
            if (values.isEmpty()) continue
            val days = countedDays(habit, run, values, today)
            for (n in values) {
                val day = days[n] ?: continue
                reached.add(pageMilestone(Milestone.Track.IN_A_ROW, n, unit.name.lowercase(), "$n", milestoneRowTitle(n, unit),
                    "$n in a row", null, milestoneRowTitle(n, unit), day, today))
            }
        }
        bucket.nextRow(best)?.let { target ->
            next.add(milestoneNextRow(Milestone.Track.IN_A_ROW, target, "$target", milestoneRowTitle(target, unit), current, best))
        }
        // In total: everything logged, even on a day the goal wasn't met, × one period's goal; dated by the day it crossed.
        val goal = milestonePeriodGoal(now)
        val byDay = totalsByDay(habit, now, today)
        var total = 0.0
        var target = bucket.nextTotal(goal, 0.0)
        for ((day, value) in byDay) {
            total += value
            while (target != null && total >= target) {
                val words = milestoneTotalWords(now, target)
                reached.add(pageMilestone(Milestone.Track.IN_TOTAL, target.toInt(), "total", medalNumber(target), words,
                    words.removeSuffix(" in total"), null, words, day, today))
                target = bucket.nextTotal(goal, target)
            }
        }
        target?.let { v ->
            val words = milestoneTotalWords(now, v)
            val toGo = Format.amount(max(0.0, v - total))
            val detail = "$toGo to go" + (if (total > 0) " · ${Format.amount(total)} so far" else "")
            next.add(MilestoneNext(Milestone.Track.IN_TOTAL, v.toInt(), medalNumber(v), words, words, detail, min(1.0, total / v),
                "Next: $words, $toGo to go."))
        }
    }
    // Anniversaries: each year since the first log, when the goal was met in the 30 days before it.
    val first = entries(habit.id).minOfOrNull { it.day } ?: rules.startDay(habit)
    var years = 0
    while (true) {
        val day = pageDate(first).plusYears((years + 1).toLong()).toEpochDay().toInt()
        if (day > today) break
        years++
        if ((day - 29..day).any { rules.isComplete(habit, it) }) {
            val name = if (years == 1) "1 year" else "$years years"
            reached.add(pageMilestone(Milestone.Track.ANNIVERSARY, years, "years", "${years}y", name, name, null, name, day, today))
        }
    }
    val lastYear = pageDate(first).plusYears(years.toLong()).toEpochDay().toInt()
    val nextYear = pageDate(first).plusYears((years + 1).toLong()).toEpochDay().toInt()
    val name = if (years + 1 == 1) "1 year" else "${years + 1} years"
    val left = nextYear - today
    next.add(MilestoneNext(Milestone.Track.ANNIVERSARY, years + 1, "${years + 1}y", name, name,
        DayWords.long(nextYear) + " · " + (if (left == 1) "1 day to go" else "$left days to go"),
        ((today - lastYear).toDouble() / max(1, nextYear - lastYear)).coerceIn(0.0, 1.0), "Next: $name, on ${DayWords.long(nextYear)}."))
    reached.sortWith(newestFirst)
    return HabitMilestones(reached, next, milestoneTotalLabel(now))
}
