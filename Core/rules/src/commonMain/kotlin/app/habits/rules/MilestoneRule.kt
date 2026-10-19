package app.habits.rules

/**
 * The decided milestone rule (spec/streaks.md ST-8; the user, 17 Oct 2026, Figma *Milestones: one simple rule*): four
 * buckets picked by two questions, an in-a-row list and an in-total list for each, and anniversaries. Which surface a
 * milestone gets (pop-up, bar or the row) starts here: [isLandmark] says which in-a-row lengths are pop-ups.
 *
 * It replaces ST-7's ladders ([Milestones]) once the iPhone and the habit page move to it; until then [Milestones] stays,
 * with its golden answers (Rulebook T21).
 */
object MilestoneRule {
    enum class Bucket { DAYS, WEEKS, MONTHS, YEARS }

    /**
     * Question 1: is the goal for a week, a month or a year? That's the bucket. Question 2: otherwise, how far apart
     * are its set days? Under 7 days, Days; 7 to 27, Weeks; 28 up to a year, Months; a year, Years.
     */
    fun bucket(f: Frequency): Bucket = when (f) {
        is Frequency.PerWeek -> Bucket.WEEKS
        is Frequency.PerMonth -> Bucket.MONTHS
        is Frequency.PerYear -> Bucket.YEARS
        is Frequency.Flexible -> when (f.period) {
            Period.DAY -> Bucket.DAYS
            Period.WEEK -> Bucket.WEEKS
            Period.MONTH -> Bucket.MONTHS
            Period.YEAR -> Bucket.YEARS
        }
        else -> byGap(gap(f))
    }

    fun byGap(days: Int): Bucket = when {
        days < 7 -> Bucket.DAYS
        days < 28 -> Bucket.WEEKS
        days < 365 -> Bucket.MONTHS
        else -> Bucket.YEARS
    }

    /** The longest gap between a set-day schedule's days, in days (a month counts 30, a year 365). */
    fun gap(f: Frequency): Int = when (f) {
        Frequency.Daily -> 1
        is Frequency.Weekdays -> cyclicGap(f.days.filter { it in 1..7 }, 7)
        is Frequency.EveryNDays -> maxOf(1, f.n)
        is Frequency.EveryNWeeks -> 7 * maxOf(1, f.n)
        is Frequency.MonthDates -> cyclicGap(f.dates.filter { it in 1..31 }, 30)
        is Frequency.AfterCompletion -> maxOf(1, f.n) * periodDays(f.unit)
        is Frequency.Calendar -> with(f.rule) {
            val every = maxOf(1, interval)
            when (unit) {
                Period.DAY -> every
                Period.WEEK -> if (weekdays.size <= 1) 7 * every else cyclicGap(weekdays.toList(), 7 * every)
                Period.MONTH -> if (pattern == "Dates" && dates.size > 1) cyclicGap(dates.toList(), 30 * every) else 30 * every
                Period.YEAR -> 365 * every
            }
        }
        is Frequency.PerWeek, is Frequency.PerMonth, is Frequency.PerYear, is Frequency.Flexible -> 1
    }

    private fun periodDays(p: Period) = when (p) { Period.DAY -> 1; Period.WEEK -> 7; Period.MONTH -> 30; Period.YEAR -> 365 }

    /** The longest gap between the given positions repeating every [cycle] (one position: the whole cycle). */
    private fun cyclicGap(positions: List<Int>, cycle: Int): Int {
        val p = positions.distinct().sorted()
        if (p.size <= 1) return cycle
        var gap = cycle - p.last() + p.first()
        for (i in 1 until p.size) gap = maxOf(gap, p[i] - p[i - 1])
        return gap
    }

    // ---------------------------------------------------------------------------------------------------- In a row

    private val dayRow = listOf(3, 7, 14, 30, 60, 90, 180, 365)
    private val weekRow = listOf(2, 4, 8, 13, 26, 52)
    private val monthRow = listOf(2, 3, 6, 9, 12)

    /** The in-a-row list: Days 3 … 365 then every 365; Weeks 2 … 52 then every 52; Months 2 … 12 then every 12; Years none. */
    fun isRowMilestone(bucket: Bucket, n: Int): Boolean = when (bucket) {
        Bucket.DAYS -> n in dayRow || (n > 365 && n % 365 == 0)
        Bucket.WEEKS -> n in weekRow || (n > 52 && n % 52 == 0)
        Bucket.MONTHS -> n in monthRow || (n > 12 && n % 12 == 0)
        Bucket.YEARS -> false
    }

    /** A pop-up length: a month, six months and each year (Days 30, 180, 365 … · Weeks 4, 26, 52 … · Months 6, 12 …). */
    fun isLandmark(bucket: Bucket, n: Int): Boolean = isRowMilestone(bucket, n) && when (bucket) {
        Bucket.DAYS -> n == 30 || n == 180 || n >= 365
        Bucket.WEEKS -> n == 4 || n == 26 || n >= 52
        Bucket.MONTHS -> n >= 6 && n != 9
        Bucket.YEARS -> false
    }

    /** The next in-a-row length after [n], or null for Years (anniversaries only). */
    fun nextRow(bucket: Bucket, n: Int): Int? {
        if (bucket == Bucket.YEARS) return null
        var k = maxOf(n, 0) + 1
        while (!isRowMilestone(bucket, k)) k++
        return k
    }

    // ---------------------------------------------------------------------------------------------------- In total

    private val dayTotal = listOf(10, 25, 50, 100, 250, 500, 1000)
    private val weekTotal = listOf(10, 25, 50, 100, 250)
    private val monthTotal = listOf(5, 10, 25, 50, 100)

    /** The in-total list, as times the goal for one period: Days 10 … 1,000 then every 500; Weeks 10 … 250; Months 5 … 100. */
    fun totalMultiples(bucket: Bucket, upTo: Int): List<Int> = when (bucket) {
        Bucket.DAYS -> dayTotal.filter { it <= upTo } + (1500..maxOf(1500, upTo) step 500).filter { it <= upTo }
        Bucket.WEEKS -> weekTotal.filter { it <= upTo }
        Bucket.MONTHS -> monthTotal.filter { it <= upTo }
        Bucket.YEARS -> emptyList()
    }

    fun isTotalMultiple(bucket: Bucket, m: Int): Boolean = m > 0 && m in totalMultiples(bucket, m)

    /**
     * The in-total milestone crossed going from [before] to [after] (both in the habit's own unit), as its value: the
     * goal for one period × the list's multiple. The highest one crossed, or null. A total that falls (an undo) crosses
     * nothing.
     */
    fun totalCrossed(bucket: Bucket, periodGoal: Double, before: Double, after: Double): Double? {
        if (periodGoal <= 0 || after <= before) return null
        val top = (after / periodGoal + 1e-9).toInt()
        return totalMultiples(bucket, top).lastOrNull { m -> val v = m * periodGoal; v > before + 1e-9 && v <= after + 1e-9 }
            ?.let { it * periodGoal }
    }

    /** The next in-total value after [total], or null when the list has ended (Weeks after 250, Months after 100). */
    fun nextTotal(bucket: Bucket, periodGoal: Double, total: Double): Double? {
        if (periodGoal <= 0 || bucket == Bucket.YEARS) return null
        val reached = (total / periodGoal + 1e-9).toInt()
        val last = when (bucket) { Bucket.DAYS -> Int.MAX_VALUE; Bucket.WEEKS -> 250; Bucket.MONTHS -> 100; Bucket.YEARS -> 0 }
        var m = reached + 1
        while (m <= last && !isTotalMultiple(bucket, m)) m++
        return if (m <= last) m * periodGoal else null
    }

    // ---------------------------------------------------------------------------------------------------- Anniversaries

    /**
     * Whole years from [first] to [day] when [day] is that date a year or more on, or null. Day numbers count days
     * since 1 Jan 1970; a 29 February start has its anniversary on 28 February in other years.
     */
    fun anniversaryYears(first: Int, day: Int): Int? {
        if (day <= first) return null
        val a = Day.ymd(first)
        val b = Day.ymd(day)
        val years = b[0] - a[0]
        if (years < 1) return null
        val date = if (a[1] == 2 && a[2] == 29 && !Day.isLeap(b[0])) 28 else a[2]
        return if (b[1] == a[1] && b[2] == date) years else null
    }
}
