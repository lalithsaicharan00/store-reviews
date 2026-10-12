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

    // Moments already read, each as its day and hour, in a table indexed by the moment itself: the same moments come
    // back again and again (now, each habit's first moment, every log's), and reading a zone's clock is most of what a
    // rule costs on the iPhone and the Watch (Current Work 92, checkpoint 2). A slot taken by another moment is read
    // again. One instance is used from one thread (the app's main thread), like the rules that own it.
    private val seenMs = LongArray(CACHE) { Long.MIN_VALUE }
    private val seenDayHour = IntArray(CACHE)

    /** The day (days since 1970) and hour on this zone's clock at a moment, packed as day * 32 + hour. */
    private fun dayHour(ms: Long): Int {
        val slot = ((ms xor (ms ushr 29)).toInt() * 0x9E3779B1.toInt()) ushr (32 - CACHE_BITS)
        if (seenMs[slot] == ms) return seenDayHour[slot]
        val local = Instant.fromEpochMilliseconds(ms).toLocalDateTime(zone)
        val packed = Day.of(local.year, local.month.ordinal + 1, local.day) * 32 + local.hour
        seenMs[slot] = ms
        seenDayHour[slot] = packed
        return packed
    }

    /** The calendar day a moment falls on, on this zone's clock (midnight to midnight). */
    fun dayOf(ms: Long): Int = dayHour(ms).floorDiv(32)

    /** The hour on this zone's clock at a moment, 0…23. */
    fun hourOf(ms: Long): Int = dayHour(ms).mod(32)

    /** The moment the clock reads [hour]:00 on [day]; on the night the clocks go forward past it, the first moment that
     *  exists after it (as the iPhone's `Calendar.date(bySettingHour:…)`); when an hour happens twice, the first. */
    fun at(day: Int, hour: Int): Long {
        val key = day * 32 + hour
        val slot = (key * 0x9E3779B1.toInt()) ushr (32 - CACHE_BITS)
        if (seenAtKey[slot] == key) return seenAt[slot]
        val (y, m, d) = Day.ymd(day).let { Triple(it[0], it[1], it[2]) }
        val ms = LocalDateTime(y, m, d, hour, 0).toInstant(zone).toEpochMilliseconds()
        seenAtKey[slot] = key
        seenAt[slot] = ms
        return ms
    }
    private val seenAtKey = IntArray(CACHE) { Int.MIN_VALUE }
    private val seenAt = LongArray(CACHE)

    private companion object {
        const val CACHE_BITS = 9
        const val CACHE = 1 shl CACHE_BITS
    }
}
