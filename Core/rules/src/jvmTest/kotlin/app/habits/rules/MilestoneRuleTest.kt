package app.habits.rules

import app.habits.rules.MilestoneRule.Bucket
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertFalse
import kotlin.test.assertNull
import kotlin.test.assertTrue

/** The decided rule, case by case from Figma *Milestones: one simple rule* and Android/Docs/Milestones (ST-8). */
class MilestoneRuleTest {
    @Test fun twoQuestionsPickTheBucket() {
        assertEquals(Bucket.WEEKS, MilestoneRule.bucket(Frequency.PerWeek(3)))
        assertEquals(Bucket.MONTHS, MilestoneRule.bucket(Frequency.PerMonth(2)))
        assertEquals(Bucket.YEARS, MilestoneRule.bucket(Frequency.PerYear(2)))
        assertEquals(Bucket.WEEKS, MilestoneRule.bucket(Frequency.Flexible(Period.WEEK, 3)))
        assertEquals(Bucket.DAYS, MilestoneRule.bucket(Frequency.Daily))
        // Mon / Wed / Fri: 2–3 days apart. Weekdays: at most 3 (Fri to Mon).
        assertEquals(Bucket.DAYS, MilestoneRule.bucket(Frequency.Weekdays(setOf(2, 4, 6))))
        assertEquals(Bucket.DAYS, MilestoneRule.bucket(Frequency.Weekdays(setOf(2, 3, 4, 5, 6))))
        assertEquals(Bucket.DAYS, MilestoneRule.bucket(Frequency.EveryNDays(3)))
        // Every Monday, every other Saturday, the 1st and 15th: Weeks.
        assertEquals(Bucket.WEEKS, MilestoneRule.bucket(Frequency.Weekdays(setOf(2))))
        assertEquals(Bucket.WEEKS, MilestoneRule.bucket(Frequency.EveryNWeeks(2)))
        assertEquals(Bucket.WEEKS, MilestoneRule.bucket(Frequency.MonthDates(setOf(1, 15))))
        // The 1st of the month, the first Saturday, every 4 weeks: Months. A yearly date: Years.
        assertEquals(Bucket.MONTHS, MilestoneRule.bucket(Frequency.MonthDates(setOf(1))))
        assertEquals(Bucket.MONTHS, MilestoneRule.bucket(Frequency.Calendar(CalendarSchedule(unit = Period.MONTH, interval = 1, pattern = "Weekday"))))
        assertEquals(Bucket.MONTHS, MilestoneRule.bucket(Frequency.EveryNWeeks(4)))
        assertEquals(Bucket.YEARS, MilestoneRule.bucket(Frequency.Calendar(CalendarSchedule(unit = Period.YEAR, interval = 1))))
    }

    @Test fun eachBucketsInARowList() {
        fun list(b: Bucket, upTo: Int) = (1..upTo).filter { MilestoneRule.isRowMilestone(b, it) }
        assertEquals(listOf(3, 7, 14, 30, 60, 90, 180, 365, 730, 1095), list(Bucket.DAYS, 1100))
        assertEquals(listOf(2, 4, 8, 13, 26, 52, 104), list(Bucket.WEEKS, 110))
        assertEquals(listOf(2, 3, 6, 9, 12, 24, 36), list(Bucket.MONTHS, 40))
        assertEquals(emptyList(), list(Bucket.YEARS, 10))
        assertEquals(60, MilestoneRule.nextRow(Bucket.DAYS, 30))
        assertNull(MilestoneRule.nextRow(Bucket.YEARS, 1))
    }

    @Test fun popUpsAtAMonthSixMonthsAndEachYear() {
        fun pops(b: Bucket, upTo: Int) = (1..upTo).filter { MilestoneRule.isLandmark(b, it) }
        assertEquals(listOf(30, 180, 365, 730), pops(Bucket.DAYS, 800))
        assertEquals(listOf(4, 26, 52, 104), pops(Bucket.WEEKS, 110))
        assertEquals(listOf(6, 12, 24), pops(Bucket.MONTHS, 30))
        assertFalse(MilestoneRule.isLandmark(Bucket.DAYS, 60))
    }

    @Test fun totalsAreTheGoalTimesTheList() {
        // Water, 8 glasses a day: 80, 200, 400 glasses.
        assertEquals(80.0, MilestoneRule.totalCrossed(Bucket.DAYS, 8.0, 79.0, 80.0))
        assertNull(MilestoneRule.totalCrossed(Bucket.DAYS, 8.0, 80.0, 81.0))
        assertEquals(200.0, MilestoneRule.totalCrossed(Bucket.DAYS, 8.0, 195.0, 203.0))
        // A big typed amount crossing two: the higher one.
        assertEquals(200.0, MilestoneRule.totalCrossed(Bucket.DAYS, 8.0, 70.0, 210.0))
        // An undo crosses nothing.
        assertNull(MilestoneRule.totalCrossed(Bucket.DAYS, 8.0, 80.0, 79.0))
        // Gym, 3 a week: 30, 75, 150 visits; Call family, 2 a month: 10, 20, 50 calls.
        assertEquals(30.0, MilestoneRule.totalCrossed(Bucket.WEEKS, 3.0, 29.0, 30.0))
        assertEquals(10.0, MilestoneRule.totalCrossed(Bucket.MONTHS, 2.0, 9.0, 10.0))
        // Days go on every 500 after 1,000; Weeks stop at 250.
        assertEquals(1500.0, MilestoneRule.totalCrossed(Bucket.DAYS, 1.0, 1499.0, 1500.0))
        assertNull(MilestoneRule.totalCrossed(Bucket.WEEKS, 1.0, 499.0, 500.0))
        assertEquals(250.0, MilestoneRule.nextTotal(Bucket.DAYS, 1.0, 100.0))
        assertNull(MilestoneRule.nextTotal(Bucket.WEEKS, 1.0, 250.0))
    }

    @Test fun inARowAndInTotalNeverShareANumberForADailyHabit() {
        val row = (1..2000).filter { MilestoneRule.isRowMilestone(Bucket.DAYS, it) }.toSet()
        val total = MilestoneRule.totalMultiples(Bucket.DAYS, 2000).toSet()
        assertTrue((row intersect total).isEmpty())
    }

    @Test fun anniversaries() {
        val first = Day.of(2025, 10, 17)
        assertEquals(1, MilestoneRule.anniversaryYears(first, Day.of(2026, 10, 17)))
        assertEquals(2, MilestoneRule.anniversaryYears(first, Day.of(2027, 10, 17)))
        assertNull(MilestoneRule.anniversaryYears(first, Day.of(2026, 10, 18)))
        assertNull(MilestoneRule.anniversaryYears(first, first))
        val leap = Day.of(2024, 2, 29)
        assertEquals(1, MilestoneRule.anniversaryYears(leap, Day.of(2025, 2, 28)))
        assertEquals(4, MilestoneRule.anniversaryYears(leap, Day.of(2028, 2, 29)))
    }
}
