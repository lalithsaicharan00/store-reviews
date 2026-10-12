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

    /** The calendar day a moment falls on, on this zone's clock (midnight to midnight). */
    fun dayOf(ms: Long): Int {
        val local = Instant.fromEpochMilliseconds(ms).toLocalDateTime(zone)
        return Day.of(local.year, local.month.ordinal + 1, local.day)
    }

    /** The hour on this zone's clock at a moment, 0…23. */
    fun hourOf(ms: Long): Int = Instant.fromEpochMilliseconds(ms).toLocalDateTime(zone).hour

    /** The moment the clock reads [hour]:00 on [day]; on the night the clocks go forward past it, the first moment that
     *  exists after it (as the iPhone's `Calendar.date(bySettingHour:…)`); when an hour happens twice, the first. */
    fun at(day: Int, hour: Int): Long {
        val (y, m, d) = Day.ymd(day).let { Triple(it[0], it[1], it[2]) }
        return LocalDateTime(y, m, d, hour, 0).toInstant(zone).toEpochMilliseconds()
    }
}
