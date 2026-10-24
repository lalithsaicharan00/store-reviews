package com.oftenenough.app

import com.oftenenough.app.data.DayMark
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HeatCell
import com.oftenenough.app.data.ProgressRange
import com.oftenenough.app.data.ProgressWords
import com.oftenenough.app.data.WeekCardDay
import com.oftenenough.app.data.YearMonthLabel
import com.oftenenough.app.data.title
import java.time.LocalDate
import java.util.Locale
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Before
import org.junit.Test

/**
 * Progress's own words and day arithmetic, MOVE TO CORE, ported from the iPhone (HabitStore+WeekCards.swift,
 * HabitStore+Progress.swift): the year's caption and layout, the week's columns, the short numbers under a day and the
 * words TalkBack reads for a card. (The cards' headlines and squares are the habit page's, checked in HabitPageWordsTest.)
 */
class ProgressWordsTest {
    @Before fun english() = Locale.setDefault(Locale.US)

    private fun day(y: Int, m: Int, d: Int) = LocalDate.of(y, m, d).toEpochDay().toInt()

    private fun habit(kind: HabitKind, goal: Double = 1.0) = Habit(name = "Read", symbol = "book.fill", color = HabitColor.ORANGE, kind = kind, goal = goal)

    private fun cardDay(day: Int, mark: DayMark, extra: Boolean = false, slip: Boolean = false) =
        WeekCardDay(day, mark, if (mark == DayMark.DONE) 1.0 else 0.0, false, extra, slip, false, HeatCell.Blank)

    @Test fun titles() {
        assertEquals("Week", ProgressRange.WEEK.title)
        assertEquals("Month", ProgressRange.MONTH.title)
        assertEquals("Year", ProgressRange.YEAR.title)
    }

    @Test fun yearCaptions() {
        val today = day(2026, 10, 12)
        assertEquals("This year", ProgressWords.yearCaption(day(2026, 1, 1), day(2026, 12, 31), today))
        assertEquals("Last year", ProgressWords.yearCaption(day(2025, 1, 1), day(2025, 12, 31), today))
        assertNull(ProgressWords.yearCaption(day(2024, 1, 1), day(2024, 12, 31), today))
    }

    @Test fun weekColumns() {
        val columns = ProgressWords.weekColumns(day(2026, 10, 11), day(2026, 10, 17), day(2026, 10, 12))
        assertEquals(listOf("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"), columns.map { it.short })
        assertEquals("S", columns[0].letter)
        assertEquals("Monday 12 October", columns[1].spoken)
        assertEquals(listOf(false, true, false, false, false, false, false), columns.map { it.isToday })
    }

    @Test fun yearLayout() {
        // 1 January 2026 is a Thursday: four empty places in a Sunday week.
        val layout = ProgressWords.yearLayout(day(2026, 1, 1), day(2026, 12, 31), day(2026, 10, 12), 1)
        assertEquals(4, layout.lead)
        assertEquals(285, layout.shown)
        // 12 October 2026 is a Monday: the second row in a Sunday week.
        assertEquals(1, layout.todayRow)
        assertEquals(42, layout.columns)
        assertEquals(listOf("S", "M", "T", "W", "T", "F", "S"), layout.letters)
        assertEquals(YearMonthLabel(1, "Jan"), layout.months.first())
        assertEquals(YearMonthLabel(40, "Oct"), layout.months.last())
        // A Monday week: three empty places, and Monday is the first row.
        val monday = ProgressWords.yearLayout(day(2026, 1, 1), day(2026, 12, 31), day(2026, 10, 12), 2)
        assertEquals(3, monday.lead)
        assertEquals(0, monday.todayRow)
        // A past year shows every day and no today.
        val past = ProgressWords.yearLayout(day(2025, 1, 1), day(2025, 12, 31), day(2026, 10, 12), 1)
        assertEquals(365, past.shown)
        assertNull(past.todayRow)
        assertEquals(12, past.months.size)
        // A year still to come shows nothing.
        assertEquals(0, ProgressWords.yearLayout(day(2027, 1, 1), day(2027, 12, 31), day(2026, 10, 12), 1).shown)
    }

    @Test fun shortNumbers() {
        assertEquals("8", ProgressWords.compactNumber(8.0))
        assertEquals("2.5", ProgressWords.compactNumber(2.5))
        assertEquals("9.1k", ProgressWords.compactNumber(9100.0))
        assertEquals("10k", ProgressWords.compactNumber(10_000.0))
        assertEquals("123k", ProgressWords.compactNumber(123_000.0))
        assertEquals("1.2M", ProgressWords.compactNumber(1_200_000.0))
        assertEquals("25m", ProgressWords.compactMinutes(25.0))
        assertEquals("2h", ProgressWords.compactMinutes(120.0))
        assertEquals("1h30", ProgressWords.compactMinutes(90.0))
        assertEquals("1h05", ProgressWords.compactMinutes(65.0))
    }

    @Test fun dayValues() {
        assertEquals("", ProgressWords.weekValue(0.0, habit(HabitKind.Duration, 20.0), 20.0, DayMark.MISSED))
        assertEquals("32m", ProgressWords.weekValue(32.0, habit(HabitKind.Duration, 20.0), 20.0, DayMark.DONE))
        // A plain tick says nothing a mark doesn't; several in a day say how many.
        assertEquals("", ProgressWords.weekValue(1.0, habit(HabitKind.Check), 1.0, DayMark.DONE))
        assertEquals("3", ProgressWords.weekValue(3.0, habit(HabitKind.Check, 3.0), 3.0, DayMark.DONE))
        assertEquals("2/4", ProgressWords.weekValue(2.0, habit(HabitKind.Checklist), 4.0, DayMark.SOME))
        assertEquals("", ProgressWords.weekValue(4.0, habit(HabitKind.Checklist), 4.0, DayMark.DONE))
        assertEquals("8.2k", ProgressWords.weekValue(8200.0, habit(HabitKind.Amount("steps", 1000.0), 8000.0), 8000.0, DayMark.DONE))
    }

    @Test fun spokenCards() {
        assertEquals("Within the limit", ProgressWords.markWords(DayMark.DONE, atMost = true))
        assertEquals("Not scheduled", ProgressWords.markWords(DayMark.NOT_ITS_DAY))
        val days = listOf(
            cardDay(day(2026, 10, 10), DayMark.BEFORE),
            cardDay(day(2026, 10, 11), DayMark.DONE),
            cardDay(day(2026, 10, 12), DayMark.OPEN),
        )
        assertEquals("Read. Reached on 1 of 1 day so far. 32 min this week. Sunday done, 32m, Monday today, still open.",
            ProgressWords.spoken("Read", "Reached on 1 of 1 day so far", "32 min this week", days, listOf("", "32m", ""), false))
        // Month and Year say their numbers only.
        assertEquals("Read. Met 1 of 2 weeks so far.", ProgressWords.spoken("Read", "Met 1 of 2 weeks so far", null, emptyList(), emptyList(), false))
        // A quit habit's slip day, and an extra day.
        val quit = listOf(cardDay(day(2026, 10, 11), DayMark.MISSED, slip = true), cardDay(day(2026, 10, 12), DayMark.DONE, extra = true))
        assertEquals("Smoking. No slips. Sunday slip, 2×, Monday extra, done.",
            ProgressWords.spoken("Smoking", "No slips", null, quit, listOf("2×"), false))
    }
}
