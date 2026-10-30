package com.oftenenough.app.data

import java.time.LocalDate
import kotlin.math.floor
import kotlin.math.log10
import kotlin.math.pow

// MOVE TO CORE: the New Habit form's "How often" and the plan it makes, ported from the iPhone's HowOften.swift and
// HabitDefaults.swift (OftenDraft). The form's words and rules, so a habit made on Android is the same habit as on the
// iPhone.

/** The form's "How often", in the words people use; each choice maps onto the saved [Frequency]. */
sealed class HowOften {
    data object EveryDay : HowOften()
    data class TimesADay(val n: Int) : HowOften()
    data class Times(val period: GoalPeriod, val n: Int) : HowOften()
    data class Days(val period: GoalPeriod, val n: Int) : HowOften()
    data class Total(val period: GoalPeriod) : HowOften()
    data class Weekdays(val days: Set<Int>) : HowOften()
    data class EveryWeeks(val n: Int) : HowOften()
    data class Calendar(val rule: CalendarRule) : HowOften()
    data class AfterDone(val n: Int, val unit: GoalPeriod) : HowOften()

    fun label(hasAmount: Boolean, checklist: Boolean = false, weekStart: Int) = HabitCopy.capitalized(phrase(hasAmount, checklist, weekStart))

    fun phrase(hasAmount: Boolean, checklist: Boolean = false, weekStart: Int): String = when (this) {
        EveryDay -> "every day"
        is TimesADay -> "${HabitCopy.times(n)} a day"
        is Times -> if (hasAmount || checklist) Days(period, n).phrase(hasAmount, false, weekStart) else "${HabitCopy.times(n)} a ${period.noun}"
        is Days -> if (n == 1) "once a ${period.noun}" else (if (hasAmount) "on " else "") + "$n days a ${period.noun}"
        is Total -> "a ${period.noun}"
        is Weekdays -> HabitCopy.dayText(days, weekStart)
        is EveryWeeks -> HabitCopy.everyN(n, "week")
        is Calendar -> HabitCopy.calendarText(rule, weekStart)
        is AfterDone -> HabitCopy.rhythm(Frequency.AfterCompletion(n, unit), weekStart)
    }

    fun frequency(hasAmount: Boolean, checklist: Boolean): Frequency = when (this) {
        EveryDay, is TimesADay -> Frequency.Daily
        is Times -> if (hasAmount || checklist) Frequency.Flexible(period, n) else perPeriod(period, n)
        is Days -> Frequency.Flexible(period, n)
        is Total -> perPeriod(period, 1)
        is Weekdays -> if (days.size >= 7) Frequency.Daily else Frequency.Weekdays(days)
        is EveryWeeks -> Frequency.EveryNWeeks(n)
        is Calendar -> Frequency.Calendar(rule)
        is AfterDone -> Frequency.AfterCompletion(n, unit)
    }

    companion object {
        fun perPeriod(p: GoalPeriod, n: Int): Frequency = when (p) {
            GoalPeriod.DAY -> Frequency.Daily; GoalPeriod.WEEK -> Frequency.PerWeek(n); GoalPeriod.MONTH -> Frequency.PerMonth(n); GoalPeriod.YEAR -> Frequency.PerYear(n)
        }

        /** A saved habit's How often, the choice the form would have made. */
        fun of(habit: Habit): HowOften {
            val counts = habit.kind is HabitKind.Amount || habit.kind == HabitKind.Duration
            val isCheck = habit.kind == HabitKind.Check
            return when (val f = habit.frequency) {
                Frequency.Daily -> if (isCheck && habit.goal > 1) TimesADay(habit.goal.toInt()) else EveryDay
                is Frequency.Weekdays -> Weekdays(f.days)
                is Frequency.EveryNDays -> Calendar(CalendarRule(unit = GoalPeriod.DAY, interval = f.n))
                is Frequency.EveryNWeeks -> EveryWeeks(f.n)
                is Frequency.MonthDates -> Calendar(CalendarRule(unit = GoalPeriod.MONTH, interval = 1, dates = f.dates, pattern = "Dates"))
                is Frequency.PerWeek -> if (counts) Total(GoalPeriod.WEEK) else Times(GoalPeriod.WEEK, if (isCheck) habit.goal.toInt() else f.n)
                is Frequency.PerMonth -> if (counts) Total(GoalPeriod.MONTH) else Times(GoalPeriod.MONTH, if (isCheck) habit.goal.toInt() else f.n)
                is Frequency.PerYear -> if (counts) Total(GoalPeriod.YEAR) else Times(GoalPeriod.YEAR, if (isCheck) habit.goal.toInt() else f.n)
                is Frequency.Flexible -> if (counts) Days(f.period, f.n) else Times(f.period, f.n)
                is Frequency.Calendar -> Calendar(f.rule)
                is Frequency.AfterCompletion -> AfterDone(f.n, f.unit)
            }
        }
    }
}

/** Everything the form knows about how much and how often; [apply] writes it into a habit. */
data class HabitPlan(
    val amount: Double? = null,
    val unit: String = "",
    val step: Double? = null,
    val asks: Boolean = false,
    val often: HowOften = HowOften.EveryDay,
    val atMost: Boolean = false,
    val checklist: Boolean = false,
) {
    val isTimed: Boolean get() = amount != null && unit == TIME_UNIT
    val hasAmount: Boolean get() = amount != null
    val stepValue: Double get() = step ?: suggestedStep(amount, unit, often)

    fun apply(habit: Habit): Habit {
        var h = habit.copy(checkUnit = null, atMost = atMost)
        h = when {
            checklist -> h.copy(kind = HabitKind.Checklist, goal = 1.0)
            amount != null -> h.copy(kind = if (isTimed) HabitKind.Duration else HabitKind.Amount(TextLimit.clean(unit, TextLimit.UNIT), if (asks) 0.0 else stepValue), goal = amount)
            else -> h.copy(kind = HabitKind.Check, goal = 1.0)
        }
        h = h.copy(frequency = often.frequency(hasAmount, checklist))
        if (amount == null && !checklist) when (often) {
            is HowOften.TimesADay -> h = h.copy(goal = often.n.toDouble())
            is HowOften.Times -> h = h.copy(goal = often.n.toDouble())
            else -> {}
        }
        return h
    }

    /** "Just do it", "2 chapters", "30 min", "At most 3 coffees". */
    val howMuchLabel: String get() {
        val a = amount ?: return if (checklist) "Steps" else "Just do it"
        val text = if (isTimed) HabitCopy.minutes(a) else HabitCopy.amount(a, unit)
        return if (atMost) "At most $text" else text
    }

    companion object {
        const val TIME_UNIT = "minutes"

        /** What one + adds when the person didn't say (the iPhone's `suggestedStep`). */
        fun suggestedStep(amount: Double?, unit: String, often: HowOften): Double {
            if (amount == null || amount <= 0) return 1.0
            when (unit.trim().lowercase()) {
                "ml" -> return minOf(250.0, amount)
                "l", "litre", "litres", "liter", "liters" -> return minOf(0.25, amount)
                "oz" -> return minOf(8.0, amount)
                "cl" -> return minOf(25.0, amount)
            }
            if (often is HowOften.Days || often is HowOften.Times) return amount
            if (amount < 1) return amount
            if (unit.trim().lowercase() in setOf("km", "kms", "mile", "miles", "mi")) return 1.0
            if (amount == Math.rint(amount) && amount <= 20) return 1.0
            val tenth = amount / 10
            val power = 10.0.pow(floor(log10(tenth)))
            val scaled = tenth / power
            val nice = if (scaled < 1.5) 1.0 else if (scaled < 3.5) 2.0 else if (scaled < 7.5) 5.0 else 10.0
            return maxOf(1.0, nice * power)
        }
    }
}

/** What the How often page remembers while choosing, so switching choices never loses a number already set. */
data class OftenDraft(
    val choice: Choice = Choice.EVERY_DAY,
    val perDay: Int = 2,
    val count: Int = 3,
    val countPeriod: GoalPeriod = GoalPeriod.WEEK,
    val countsDays: Boolean = false,
    val totalPeriod: GoalPeriod = GoalPeriod.WEEK,
    val weekdays: Set<Int> = emptySet(),
    val daysInterval: Int = 2,
    val weeksInterval: Int = 2,
    val weeksDays: Set<Int> = emptySet(),
    val monthsInterval: Int = 3,
    val afterCount: Int = 1,
    val afterUnit: GoalPeriod = GoalPeriod.WEEK,
    val startDate: Int = 1,
    val anchorWeekStart: Int = 2,
    val dateRule: CalendarRule = CalendarRule(unit = GoalPeriod.MONTH, interval = 1),
    val seeded: Boolean = false,
) {
    enum class Choice { EVERY_DAY, TIMES_A_DAY, TIMES, TOTAL, WEEKDAYS, EVERY_DAYS, EVERY_WEEKS, EVERY_MONTHS, DATE, AFTER_DONE }

    /** The chosen days start as the start date's own day, date and month. */
    fun seed(start: Int, weekStart: Int): OftenDraft {
        if (seeded) return this
        val d = LocalDate.ofEpochDay(start.toLong())
        val weekday = d.dayOfWeek.value % 7 + 1
        val date = d.dayOfMonth
        return copy(seeded = true, weekdays = setOf(weekday), startDate = date, anchorWeekStart = weekStart,
            dateRule = dateRule.copy(dates = setOf(date), day = date, month = d.monthValue, weekday = weekday, ordinal = minOf(5, (date - 1) / 7 + 1), anchorWeekStart = weekStart))
    }

    fun often(hasAmount: Boolean): HowOften = when (choice) {
        Choice.EVERY_DAY -> HowOften.EveryDay
        Choice.TIMES_A_DAY -> if (hasAmount) HowOften.EveryDay else HowOften.TimesADay(maxOf(2, perDay))
        Choice.TIMES -> if (hasAmount) HowOften.Days(countPeriod, maxOf(1, count)) else HowOften.Times(countPeriod, maxOf(1, count))
        Choice.TOTAL -> if (hasAmount) HowOften.Total(totalPeriod) else HowOften.Times(totalPeriod, 1)
        Choice.WEEKDAYS -> HowOften.Weekdays(weekdays)
        Choice.EVERY_DAYS -> HowOften.Calendar(CalendarRule(unit = GoalPeriod.DAY, interval = maxOf(2, daysInterval)))
        Choice.EVERY_WEEKS -> if (weeksDays.isEmpty()) HowOften.EveryWeeks(maxOf(1, weeksInterval))
            else HowOften.Calendar(CalendarRule(unit = GoalPeriod.WEEK, interval = maxOf(1, weeksInterval), weekdays = weeksDays, anchorWeekStart = anchorWeekStart))
        Choice.EVERY_MONTHS -> HowOften.Calendar(CalendarRule(unit = GoalPeriod.MONTH, interval = maxOf(1, monthsInterval), dates = setOf(startDate), pattern = "Dates", anchorWeekStart = anchorWeekStart))
        Choice.DATE -> HowOften.Calendar(dateRule)
        Choice.AFTER_DONE -> HowOften.AfterDone(maxOf(1, afterCount), afterUnit)
    }

    fun choose(o: HowOften): OftenDraft = when (o) {
        HowOften.EveryDay -> copy(choice = Choice.EVERY_DAY)
        is HowOften.TimesADay -> copy(choice = Choice.TIMES_A_DAY, perDay = o.n)
        is HowOften.Times -> copy(choice = Choice.TIMES, countPeriod = o.period, count = o.n, countsDays = false)
        is HowOften.Days -> copy(choice = Choice.TIMES, countPeriod = o.period, count = o.n, countsDays = true)
        is HowOften.Total -> copy(choice = Choice.TOTAL, totalPeriod = o.period)
        is HowOften.Weekdays -> copy(choice = Choice.WEEKDAYS, weekdays = o.days)
        is HowOften.EveryWeeks -> copy(choice = Choice.EVERY_WEEKS, weeksInterval = o.n, weeksDays = emptySet())
        is HowOften.AfterDone -> copy(choice = Choice.AFTER_DONE, afterCount = o.n, afterUnit = o.unit)
        is HowOften.Calendar -> when (o.rule.unit) {
            GoalPeriod.DAY -> copy(choice = Choice.EVERY_DAYS, daysInterval = o.rule.interval)
            GoalPeriod.WEEK -> copy(choice = Choice.EVERY_WEEKS, weeksInterval = o.rule.interval, weeksDays = o.rule.weekdays)
            else -> copy(choice = Choice.DATE, dateRule = o.rule)
        }
    }

    /** The most a count can be: 7 days a week, 31 a month, 366 a year; ticks can go higher. */
    fun countMaximum(days: Boolean): Int = when (countPeriod) {
        GoalPeriod.WEEK -> if (days) 7 else 99
        GoalPeriod.MONTH -> if (days) 31 else 999
        GoalPeriod.YEAR -> if (days) 366 else 9999
        GoalPeriod.DAY -> 99
    }
}
