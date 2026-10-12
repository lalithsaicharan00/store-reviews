package app.habits.rules

/**
 * Calendar days as plain numbers: days since 1 January 1970 in the Gregorian calendar (spec/day.md DAY-8). A day is the
 * person's own date ("2026-09-27"), independent of time zone; every rule counts, steps and compares days this way, so a
 * year of history is a year of integer steps, never calendar calls (Rulebook S5, S8).
 */
object Day {
    /** Days since 1 January 1970 (H. Hinnant's `days_from_civil`), the same arithmetic as the iPhone's `LocalDay`. */
    fun of(year: Int, month: Int, day: Int): Int {
        val y = if (month <= 2) year - 1 else year
        val era = (if (y >= 0) y else y - 399) / 400
        val yearOfEra = y - era * 400
        val dayOfYear = (153 * ((month + 9) % 12) + 2) / 5 + day - 1
        val dayOfEra = yearOfEra * 365 + yearOfEra / 4 - yearOfEra / 100 + dayOfYear
        return era * 146_097 + dayOfEra - 719_468
    }

    /** The year, month and day of a day number (`civil_from_days`). */
    fun ymd(n: Int): IntArray {
        val z = n + 719_468
        val era = (if (z >= 0) z else z - 146_096) / 146_097
        val dayOfEra = z - era * 146_097
        val yearOfEra = (dayOfEra - dayOfEra / 1460 + dayOfEra / 36524 - dayOfEra / 146_096) / 365
        val dayOfYear = dayOfEra - (365 * yearOfEra + yearOfEra / 4 - yearOfEra / 100)
        val mp = (5 * dayOfYear + 2) / 153
        val month = if (mp < 10) mp + 3 else mp - 9
        return intArrayOf(yearOfEra + era * 400 + (if (month <= 2) 1 else 0), month, dayOfYear - (153 * mp + 2) / 5 + 1)
    }

    fun year(n: Int) = ymd(n)[0]
    fun month(n: Int) = ymd(n)[1]
    fun dayOfMonth(n: Int) = ymd(n)[2]

    /** 1 = Sunday … 7 = Saturday. 1 January 1970 was a Thursday (5). */
    fun weekday(n: Int): Int = ((n % 7 + 7 + 4) % 7) + 1

    fun isLeap(year: Int) = year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)

    fun daysInMonth(year: Int, month: Int): Int = when (month) {
        2 -> if (isLeap(year)) 29 else 28
        4, 6, 9, 11 -> 30
        else -> 31
    }

    /** "2026-09-27". */
    fun key(n: Int): String {
        val (y, m, d) = ymd(n).let { Triple(it[0], it[1], it[2]) }
        return y.toString().padStart(4, '0') + "-" + m.toString().padStart(2, '0') + "-" + d.toString().padStart(2, '0')
    }

    /** A day key, or null when it isn't a real date (as the iPhone's `LocalDay(key:)`). */
    fun parse(key: String?): Int? {
        if (key == null) return null
        // Read in one pass, with no strings split off: a load parses every log's day (Current Work 92, checkpoint 2).
        // Three parts of ASCII digits split by "-", none empty; a part too large for any valid date is out of range.
        val n = intArrayOf(0, 0, 0)
        var part = 0
        var digits = 0
        for (c in key) {
            if (c == '-') {
                if (digits == 0 || part == 2) return null
                part++
                digits = 0
            } else if (c in '0'..'9') {
                digits++
                n[part] = minOf(n[part] * 10 + (c - '0'), 1_000_000)
            } else {
                return null
            }
        }
        if (part != 2 || digits == 0) return null
        val (y, m, d) = n
        if (y !in 1..9999 || m !in 1..12 || d !in 1..daysInMonth(y, m)) return null
        return of(y, m, d)
    }

    /** The same date `months` later, on the month's last day when it is shorter (as `Calendar` adds months). */
    fun addMonths(n: Int, months: Int): Int {
        val (y, m, d) = ymd(n).let { Triple(it[0], it[1], it[2]) }
        val total = y * 12 + (m - 1) + months
        val ny = floorDiv(total, 12)
        val nm = total - ny * 12 + 1
        return of(ny, nm, minOf(d, daysInMonth(ny, nm)))
    }

    /** The first day of the week holding [n], for weeks that start on [weekStart] (1 = Sunday … 7 = Saturday). */
    fun weekStart(n: Int, weekStart: Int): Int = n - ((weekday(n) - weekStart + 7) % 7)

    fun monthStart(n: Int): Int = ymd(n).let { of(it[0], it[1], 1) }
    fun monthEnd(n: Int): Int = ymd(n).let { of(it[0], it[1], daysInMonth(it[0], it[1])) }
    fun yearStart(n: Int): Int = of(year(n), 1, 1)
    fun yearEnd(n: Int): Int = of(year(n), 12, 31)

    internal fun floorDiv(a: Int, b: Int): Int {
        val q = a / b
        return if ((a % b != 0) && ((a < 0) != (b < 0))) q - 1 else q
    }
}

/** A closed range of days, `first..last`. */
data class DayRange(val first: Int, val last: Int) {
    operator fun contains(day: Int) = day in first..last
}
