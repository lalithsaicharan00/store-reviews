package com.oftenenough.app

import com.oftenenough.app.data.DaySection
import com.oftenenough.app.data.Frequency
import com.oftenenough.app.data.GoalPeriod
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitPlan
import com.oftenenough.app.data.HowOften
import com.oftenenough.app.data.OftenDraft
import com.oftenenough.app.data.SectionPlan
import java.util.Locale
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Before
import org.junit.Test

/**
 * The New Habit form's rules ported from the iPhone (HowOften.swift, SectionPlan.swift), MOVE TO CORE: what each
 * How often choice saves, what + adds when the person doesn't say, and how a new time of day fits the day.
 */
class FormRulesTest {
    @Before fun english() = Locale.setDefault(Locale.US)

    private val base = Habit(name = "Read", symbol = "book.fill", color = HabitColor.BLUE, kind = HabitKind.Check)

    @Test fun suggestedSteps() {
        assertEquals(1.0, HabitPlan.suggestedStep(8.0, "glasses", HowOften.EveryDay), 0.0)
        assertEquals(250.0, HabitPlan.suggestedStep(2000.0, "ml", HowOften.EveryDay), 0.0)
        assertEquals(0.25, HabitPlan.suggestedStep(2.0, "litres", HowOften.EveryDay), 0.0)
        assertEquals(1000.0, HabitPlan.suggestedStep(10_000.0, "steps", HowOften.EveryDay), 0.0)
        assertEquals(1.0, HabitPlan.suggestedStep(5.0, "km", HowOften.EveryDay), 0.0)
        assertEquals(2.0, HabitPlan.suggestedStep(30.0, "pages", HowOften.EveryDay), 0.0)
        // On a number of days, one tap does the day's amount.
        assertEquals(5.0, HabitPlan.suggestedStep(5.0, "km", HowOften.Days(GoalPeriod.WEEK, 3)), 0.0)
        assertEquals(1.0, HabitPlan.suggestedStep(null, "", HowOften.EveryDay), 0.0)
    }

    @Test fun howOftenSavesAndReadsBack() {
        val cases = listOf(
            HabitPlan(often = HowOften.TimesADay(3)) to Frequency.Daily,
            HabitPlan(often = HowOften.Times(GoalPeriod.WEEK, 3)) to Frequency.PerWeek(3),
            HabitPlan(amount = 8.0, unit = "glasses", often = HowOften.Total(GoalPeriod.WEEK)) to Frequency.PerWeek(1),
            HabitPlan(amount = 5.0, unit = "km", often = HowOften.Days(GoalPeriod.MONTH, 4)) to Frequency.Flexible(GoalPeriod.MONTH, 4),
            HabitPlan(often = HowOften.Weekdays(setOf(2, 4, 6))) to Frequency.Weekdays(setOf(2, 4, 6)),
            HabitPlan(often = HowOften.Weekdays((1..7).toSet())) to Frequency.Daily,
            HabitPlan(often = HowOften.EveryWeeks(2)) to Frequency.EveryNWeeks(2),
        )
        for ((plan, frequency) in cases) {
            val habit = plan.apply(base)
            assertEquals("$plan saves", frequency, habit.frequency)
        }
        // Several times a day is a goal of that many ticks; the form reads it back as it was chosen.
        val thrice = HabitPlan(often = HowOften.TimesADay(3)).apply(base)
        assertEquals(3.0, thrice.goal, 0.0)
        assertEquals(HowOften.TimesADay(3), HowOften.of(thrice))
        assertEquals(HowOften.Times(GoalPeriod.WEEK, 3), HowOften.of(HabitPlan(often = HowOften.Times(GoalPeriod.WEEK, 3)).apply(base)))
        assertEquals(HowOften.Total(GoalPeriod.WEEK), HowOften.of(HabitPlan(amount = 8.0, unit = "glasses", often = HowOften.Total(GoalPeriod.WEEK)).apply(base)))
        // An amount with a step; typed each time is a step of 0.
        val water = HabitPlan(amount = 2000.0, unit = "ml").apply(base)
        assertEquals(HabitKind.Amount("ml", 250.0), water.kind)
        assertEquals(HabitKind.Amount("ml", 0.0), HabitPlan(amount = 2000.0, unit = "ml", asks = true).apply(base).kind)
        assertEquals(HabitKind.Duration, HabitPlan(amount = 20.0, unit = HabitPlan.TIME_UNIT).apply(base).kind)
    }

    @Test fun oftenDraftKeepsNumbersAcrossChoices() {
        var d = OftenDraft().seed(LocalDateDay.of(2026, 10, 12), 1)
        assertEquals(setOf(2), d.weekdays) // 12 Oct 2026 is a Monday
        d = d.copy(choice = OftenDraft.Choice.TIMES, count = 4, countPeriod = GoalPeriod.MONTH)
        d = d.copy(choice = OftenDraft.Choice.EVERY_DAY).copy(choice = OftenDraft.Choice.TIMES)
        assertEquals(HowOften.Times(GoalPeriod.MONTH, 4), d.often(false))
        assertEquals(HowOften.Days(GoalPeriod.MONTH, 4), d.often(true))
        assertEquals(7, d.copy(countPeriod = GoalPeriod.WEEK).countMaximum(true))
    }

    @Test fun aNewTimeOfDayRunsUntilTheNextOne() {
        val subject = DaySection("work", "Before work", null, null)
        val plan = SectionPlan.make(DaySection.defaults, subject, 8 * 60, 9 * 60)
        assertNull(plan.problem)
        assertEquals(listOf("Morning 360-480", "Before work 480-720", "Afternoon 720-1080", "Evening 1080-1440"),
            plan.rows.map { "${it.name} ${it.start}-${it.end}" })
        assertEquals(listOf("Morning"), plan.split.map { it.name })
        assertEquals(listOf(null, 360, 480, 720, 1080), plan.sections.map { it.start })
    }

    @Test fun editingATimeOfDayMovesOnlyItself() {
        val morning = DaySection.defaults[1]
        val plan = SectionPlan.make(DaySection.defaults, morning, 5 * 60, 12 * 60)
        assertNull(plan.problem)
        assertEquals(emptyList<String>(), plan.split.map { it.name })
        assertEquals("Morning 300-720", plan.rows.first().let { "${it.name} ${it.start}-${it.end}" })
    }

    @Test fun timesThatCoverAnotherOrAreTooShortSaySo() {
        val subject = DaySection("x", "Long", null, null)
        assertEquals("That covers all of Afternoon. Choose shorter times, or delete it first.",
            SectionPlan.make(DaySection.defaults, subject, 11 * 60, 19 * 60).problem)
        assertEquals("Give it at least 15 minutes.", SectionPlan.make(DaySection.defaults, subject, 600, 610).problem)
    }

    @Test fun aTimeOfDayIsSetByItsStartAlone() {
        val subject = DaySection("work", "Before work", null, null)
        val row = { p: SectionPlan -> p.rows.joinToString { "${it.name} ${it.start}-${it.end}" } }
        // Before the first: runs until Morning starts, and nothing changes.
        val early = SectionPlan.fromStart(DaySection.defaults, subject, 4 * 60)
        assertEquals("Before work 240-360, Morning 360-720, Afternoon 720-1080, Evening 1080-1440", row(early))
        assertEquals(emptyList<String>(), early.split.map { it.name })
        // Between two: splits the one it starts in and runs until the next.
        val mid = SectionPlan.fromStart(DaySection.defaults, subject, 8 * 60)
        assertEquals("Morning 360-480, Before work 480-720, Afternoon 720-1080, Evening 1080-1440", row(mid))
        // After the last: takes the day's end.
        assertEquals("Morning 360-720, Afternoon 720-1080, Evening 1080-1320, Before work 1320-1440",
            row(SectionPlan.fromStart(DaySection.defaults, subject, 22 * 60)))
        // On an existing start.
        assertEquals("Another time of day starts then.", SectionPlan.fromStart(DaySection.defaults, subject, 12 * 60).problem)
        // After midnight with a 3 AM day start: the end of the day.
        assertEquals("Morning 360-720, Afternoon 720-1080, Evening 1080-1500, Before work 1500-1620",
            row(SectionPlan.fromStart(DaySection.defaults, subject, 60, 27 * 60)))
    }

    @Test fun aNewTimeOfDayOpensInFreeTime() {
        assertEquals(4 * 60, SectionPlan.freeStart(DaySection.defaults))
        val all = DaySection.defaults.mapIndexed { i, s -> if (i == 3) s.copy(end = 6 * 60 + 24 * 60) else s }
        assertNull(SectionPlan.freeStart(all))
        val late = DaySection.defaults.mapIndexed { i, s -> if (i == 3) s.copy(end = 5 * 60 + 24 * 60) else s }
        assertEquals(5 * 60, SectionPlan.freeStart(late))
    }

    private object LocalDateDay {
        fun of(y: Int, m: Int, d: Int): Int = java.time.LocalDate.of(y, m, d).toEpochDay().toInt()
    }
}
