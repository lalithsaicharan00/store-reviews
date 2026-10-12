package app.habits.rules

import kotlin.time.ExperimentalTime
import kotlin.time.Instant
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.TimeZone
import kotlinx.datetime.toInstant
import kotlinx.datetime.toLocalDateTime

/**
 * Where moments meet days: a time zone's wall clock (spec/day.md). The only place the rules read a time zone; every
 * other rule works on day numbers. Moments are epoch milliseconds.
 */
@OptIn(ExperimentalTime::class)
class Zone(val id: String) {
    private val zone: TimeZone = try { TimeZone.of(id) } catch (_: Exception) { TimeZone.UTC }

    // The last few moments read, each as its day and hour: the same few come back again and again (now, each habit's
    // first moment), and reading a zone's clock is most of what a rule costs on the iPhone and the Watch (Current Work
    // 92, checkpoint 2). One instance is used from one thread (the app's main thread), like the rules that own it.
    private val seenMs = LongArray(CACHE) { Long.MIN_VALUE }
    private val seenDayHour = IntArray(CACHE)
    private var next = 0

    /** The day (days since 1970) and hour on this zone's clock at a moment, packed as day * 32 + hour. */
    private fun dayHour(ms: Long): Int {
        for (i in 0 until CACHE) if (seenMs[i] == ms) return seenDayHour[i]
        val local = Instant.fromEpochMilliseconds(ms).toLocalDateTime(zone)
        val packed = Day.of(local.year, local.month.ordinal + 1, local.day) * 32 + local.hour
        seenMs[next] = ms
        seenDayHour[next] = packed
        next = (next + 1) % CACHE
        return packed
    }

    /** The calendar day a moment falls on, on this zone's clock (midnight to midnight). */
    fun dayOf(ms: Long): Int = dayHour(ms).floorDiv(32)

    /** The hour on this zone's clock at a moment, 0…23. */
    fun hourOf(ms: Long): Int = dayHour(ms).mod(32)

    /** The moment the clock reads [hour]:00 on [day]; on the night the clocks go forward past it, the first moment that
     *  exists after it (as the iPhone's `Calendar.date(bySettingHour:…)`); when an hour happens twice, the first. */
    fun at(day: Int, hour: Int): Long {
        val (y, m, d) = Day.ymd(day).let { Triple(it[0], it[1], it[2]) }
        return LocalDateTime(y, m, d, hour, 0).toInstant(zone).toEpochMilliseconds()
    }

    private companion object {
        const val CACHE = 16
    }
}
