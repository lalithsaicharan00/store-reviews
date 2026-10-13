package com.oftenenough.app

import com.oftenenough.app.data.ReminderPlan
import com.oftenenough.app.data.ReminderTime
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.ZoneId
import org.junit.Assert.assertEquals
import org.junit.Test

/** When a reminder rings, as the iPhone's ReminderScheduler.fireDate works it out (MOVE TO CORE). */
class ReminderPlanTest {
    private val zone = ZoneId.of("America/New_York")
    private fun at(ms: Long) = LocalDateTime.ofInstant(java.time.Instant.ofEpochMilli(ms), zone)
    private val day = LocalDate.of(2026, 10, 13).toEpochDay().toInt()

    @Test fun aTimeRingsOnItsDay() {
        assertEquals(LocalDateTime.of(2026, 10, 13, 9, 0), at(ReminderPlan.fireMoment(ReminderTime(hour = 9, minute = 0), day, 0, zone)))
    }

    @Test fun aTimeBeforeTheDayStartsBelongsToTheNightAfter() {
        // With the day starting at 3 AM, a 1:00 AM reminder for the 13th rings early on the 14th (D7).
        assertEquals(LocalDateTime.of(2026, 10, 14, 1, 0), at(ReminderPlan.fireMoment(ReminderTime(hour = 1, minute = 0), day, 3, zone)))
        assertEquals(LocalDateTime.of(2026, 10, 13, 3, 0), at(ReminderPlan.fireMoment(ReminderTime(hour = 3, minute = 0), day, 3, zone)))
    }

    @Test fun aSkippedHourRingsWhenTheClockComesBack() {
        // 8 March 2026: New York's clocks skip 2:00–3:00. A 2:30 reminder rings at 3:30, never the next day.
        val springForward = LocalDate.of(2026, 3, 8).toEpochDay().toInt()
        assertEquals(LocalDateTime.of(2026, 3, 8, 3, 30), at(ReminderPlan.fireMoment(ReminderTime(hour = 2, minute = 30), springForward, 0, zone)))
    }
}
