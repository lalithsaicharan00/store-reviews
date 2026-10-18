package com.oftenenough.app

import com.oftenenough.app.data.CalendarRule
import com.oftenenough.app.data.DaySection
import com.oftenenough.app.data.Frequency
import com.oftenenough.app.data.GoalPeriod
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitPause
import com.oftenenough.app.data.HabitRule
import com.oftenenough.app.data.Step
import com.oftenenough.app.data.SwiftJson
import com.oftenenough.app.data.dayKey
import com.oftenenough.app.data.parseDay
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Test

/** Settings and schedules read and write exactly as the iPhone saves them (Swift's JSONEncoder). */
class SwiftJsonTest {
    @Test fun daysRoundTrip() {
        val day = parseDay("2026-10-12")!!
        assertEquals("2026-10-12", dayKey(day))
        assertNull(parseDay("2026-02-30"))
        assertNull(parseDay("12-10-2026x"))
    }

    @Test fun plainFrequenciesUseTheDatabaseWords() {
        assertEquals("daily", SwiftJson.storageKey(Frequency.Daily))
        assertEquals("weekdays:2,4,6", SwiftJson.storageKey(Frequency.Weekdays(setOf(6, 2, 4))))
        assertEquals("week:3", SwiftJson.storageKey(Frequency.PerWeek(3)))
        for (f in listOf(Frequency.Daily, Frequency.Weekdays(setOf(1, 7)), Frequency.EveryNDays(3), Frequency.EveryNWeeks(2),
            Frequency.MonthDates(setOf(1, 15)), Frequency.PerWeek(3), Frequency.PerMonth(4), Frequency.PerYear(6))) {
            assertEquals(f, SwiftJson.frequency(SwiftJson.storageKey(f)))
        }
    }

    @Test fun newerFrequenciesAreSwiftEnumJson() {
        val flexible = Frequency.Flexible(GoalPeriod.WEEK, 3)
        assertEquals("""{"flexible":{"_0":"week","_1":3}}""", SwiftJson.frequencyJson(flexible).toString())
        assertEquals(flexible, SwiftJson.frequency(SwiftJson.storageKey(flexible)))
        val calendar = Frequency.Calendar(CalendarRule(unit = GoalPeriod.MONTH, interval = 1, pattern = "Weekday", ordinal = 2, weekday = 3))
        assertEquals(calendar, SwiftJson.frequency(SwiftJson.storageKey(calendar)))
        val after = Frequency.AfterCompletion(7, GoalPeriod.DAY)
        assertEquals(after, SwiftJson.frequency(SwiftJson.storageKey(after)))
        // What the iPhone wrote for "every other week on Saturday" (a v2 key made by Swift's JSONEncoder).
        val swift = """{"calendar":{"_0":{"unit":"week","interval":2,"weekdays":[7],"dates":[],"pattern":"Dates","ordinal":1,"weekday":1,"month":1,"day":1,"useLastDay":true,"anchorWeekStart":1}}}"""
        assertEquals(Frequency.Calendar(CalendarRule(GoalPeriod.WEEK, 2, setOf(7), emptySet(), "Dates", 1, 1, 1, 1, true, 1)),
            SwiftJson.frequency(SwiftJson.parse(swift)!!))
    }

    @Test fun pausesKeepSwiftMoments() {
        val from = parseDay("2026-10-01")!!
        val list = listOf(HabitPause(from, from + 3, 1_790_000_000_000, null), HabitPause(from + 10, null, 1_790_900_000_123, 1_791_000_000_000))
        val text = SwiftJson.pauses(list)
        assertEquals(list, SwiftJson.pauses(text))
        // Seconds since 1 January 2001.
        val swift = """[{"from":{"year":2026,"month":10,"day":1},"pausedAt":811692800}]"""
        assertEquals(listOf(HabitPause(from, null, 1_790_000_000_000, null)), SwiftJson.pauses(swift))
    }

    @Test fun goalHistoryRoundTrips() {
        val rules = listOf(
            HabitRule(parseDay("2026-09-30")!!, 8.0, Frequency.Daily, HabitKind.Amount("glasses", 1.0), null, emptyList()),
            HabitRule(parseDay("2026-10-05")!!, 1.0, Frequency.Weekdays(setOf(2, 4)), HabitKind.Checklist, null, listOf(Step("S1", "Cleanser"))),
            HabitRule(parseDay("2026-10-06")!!, 2.0, Frequency.Daily, HabitKind.Check, "glasses", emptyList()),
        )
        assertEquals(rules, SwiftJson.rules(SwiftJson.rules(rules)))
        val swift = """[{"until":{"year":2026,"month":9,"day":30},"goal":8,"frequency":{"daily":{}},"kind":{"amount":{"unit":"glasses","increment":1}},"steps":[]}]"""
        assertEquals(listOf(rules[0]), SwiftJson.rules(swift))
    }

    @Test fun timesOfDayRoundTrip() {
        val list = DaySection.defaults + DaySection("ABC", "Before work", 7 * 60 + 30, null)
        assertEquals(list, SwiftJson.sections(SwiftJson.sections(list)))
    }
}
