package app.habits.rules

/** What a streak counts (spec/streaks.md ST-1): its number is never mistaken for days. */
enum class StreakUnit { DAYS, TIMES, WEEKS, MONTHS, YEARS;

    companion object {
        /** A habit's streak unit from its schedule, as the iPhone's `Frequency.streakUnit`. */
        fun of(frequency: Frequency): StreakUnit = when (frequency) {
            Frequency.Daily -> DAYS
            is Frequency.Weekdays -> if (frequency.days.size == 7) DAYS else TIMES
            is Frequency.EveryNDays, is Frequency.EveryNWeeks, is Frequency.MonthDates, is Frequency.Calendar,
            is Frequency.AfterCompletion -> TIMES
            is Frequency.Flexible -> when (frequency.period) {
                Period.WEEK -> WEEKS
                Period.MONTH -> MONTHS
                Period.YEAR -> YEARS
                Period.DAY -> DAYS
            }
            is Frequency.PerWeek -> WEEKS
            is Frequency.PerMonth -> MONTHS
            is Frequency.PerYear -> YEARS
        }
    }
}

/** Milestones (spec/streaks.md ST-7): worked out from the streak, never stored. */
object Milestones {
    val dayLadder = setOf(3, 7, 10, 14, 30, 50, 75, 100, 150, 200, 250, 365, 500, 730, 1000)
    val weekLadder = setOf(2, 3, 4, 6, 8, 10, 12, 16, 20, 26, 39, 52, 78, 104)
    val monthLadder = setOf(2, 3, 4, 5, 6, 9, 12, 15, 18, 24, 30, 36)
    val totalCommon = listOf(10, 25, 50, 100, 250, 500, 1000, 2500, 5000)

    fun isMilestone(unit: StreakUnit, n: Int): Boolean = when (unit) {
        StreakUnit.DAYS, StreakUnit.TIMES -> n in dayLadder || (n > 730 && n % 365 == 0)
        StreakUnit.WEEKS -> n in weekLadder || (n > 104 && n % 52 == 0)
        StreakUnit.MONTHS -> n in monthLadder || (n > 36 && n % 12 == 0)
        StreakUnit.YEARS -> n >= 1
    }

    fun upTo(unit: StreakUnit, n: Int): List<Int> = if (n < 1) emptyList() else (1..n).filter { isMilestone(unit, it) }

    fun next(unit: StreakUnit, after: Int): Int {
        var k = maxOf(after, 0) + 1
        while (!isMilestone(unit, k)) k++
        return k
    }

    /** Goals met in total: month goals add 3 and 6 first, year goals 2 and 5. */
    fun totalLadder(period: Period): List<Int> = when (period) {
        Period.MONTH -> listOf(3, 6) + totalCommon
        Period.YEAR -> listOf(2, 5) + totalCommon
        Period.DAY, Period.WEEK -> totalCommon
    }
}
