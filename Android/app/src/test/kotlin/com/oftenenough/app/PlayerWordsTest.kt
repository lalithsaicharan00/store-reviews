package com.oftenenough.app

import com.oftenenough.app.data.Frequency
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.PlayerAction
import com.oftenenough.app.data.PlayerWords
import java.util.Locale
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Before
import org.junit.Test

/** The routine player's words and main action, as the iPhone's RoutinePlayer.swift says them (and the Android designs show). */
class PlayerWordsTest {
    @Before fun english() = Locale.setDefault(Locale.US)

    private fun habit(kind: HabitKind, goal: Double = 1.0, f: Frequency = Frequency.Daily, atMost: Boolean = false, name: String = "Water", checkUnit: String? = null) =
        Habit(name = name, symbol = "drop.fill", color = HabitColor.BLUE, kind = kind, goal = goal, frequency = f, atMost = atMost, checkUnit = checkUnit)

    @Test fun position() {
        assertEquals("4 of 12", PlayerWords.position(3, 12))
        assertEquals("12 of 12", PlayerWords.position(12, 12))
        assertEquals("3 done earlier today. Starting at Water.", PlayerWords.startingAt(3, "Water"))
        assertEquals("3 already done. Starting at Water.", PlayerWords.startingAt(3, "Water", today = false))
        assertEquals("Anytime routine, habit 4 of 12", PlayerWords.routineSpoken("Anytime", 3, 12))
        assertEquals("Anytime routine, summary", PlayerWords.routineSpoken("Anytime", 12, 12))
        assertEquals("3 of 12 habits covered", PlayerWords.segmentsSpoken(3, 12))
    }

    @Test fun targets() {
        assertEquals("of 8 glasses", PlayerWords.target(habit(HabitKind.Amount("glasses", 1.0), 8.0), 8.0))
        assertEquals("of 1 glass", PlayerWords.target(habit(HabitKind.Amount("glasses", 1.0), 1.0), 1.0))
        assertEquals("of 15 kilometres this week", PlayerWords.target(habit(HabitKind.Amount("kilometres", 2.5), 15.0, Frequency.PerWeek(1)), 15.0))
        assertEquals("of £200 this month", PlayerWords.target(habit(HabitKind.Amount("£", 0.0), 200.0, Frequency.PerMonth(1)), 200.0))
        assertEquals("of 2 cups max", PlayerWords.target(habit(HabitKind.Amount("cups", 1.0), 2.0, atMost = true), 2.0))
        assertEquals("of 20 min", PlayerWords.target(habit(HabitKind.Duration, 20.0), 20.0))
        assertEquals("of 30 min max", PlayerWords.target(habit(HabitKind.Duration, 30.0, atMost = true), 30.0))
        assertEquals("of 1 h 30 min", PlayerWords.target(habit(HabitKind.Duration, 90.0), 90.0))
        assertEquals("of 3 steps", PlayerWords.target(habit(HabitKind.Checklist, 3.0), 3.0))
        assertEquals("of 1", PlayerWords.target(habit(HabitKind.Check), 1.0))
        assertEquals("of 3", PlayerWords.target(habit(HabitKind.Check, 3.0), 3.0))
        assertEquals("of 3 this week", PlayerWords.target(habit(HabitKind.Check, 3.0, Frequency.PerWeek(3)), 3.0))
        assertEquals("of 8 glasses", PlayerWords.target(habit(HabitKind.Check, 8.0, checkUnit = "glasses"), 8.0))
        assertEquals("of 1", PlayerWords.target(habit(HabitKind.Task), 1.0))
    }

    @Test fun values() {
        assertEquals("2", PlayerWords.value(habit(HabitKind.Amount("glasses", 1.0)), 2.0))
        assertEquals("2.5", PlayerWords.value(habit(HabitKind.Amount("km", 2.5)), 2.5))
        assertEquals("10,000", PlayerWords.value(habit(HabitKind.Amount("steps", 1000.0)), 10_000.0))
        assertEquals("£0", PlayerWords.value(habit(HabitKind.Amount("£", 0.0)), 0.0))
        assertEquals("5:24", PlayerWords.value(habit(HabitKind.Duration), 5.4))
        assertEquals("0:00", PlayerWords.value(habit(HabitKind.Duration), 0.0))
    }

    private fun action(h: Habit, goal: Double = h.goal, done: Boolean = false, skipped: Boolean = false, last: Boolean = false, running: Boolean = false, started: Boolean = false) =
        PlayerWords.mainAction(h, goal, done, skipped, last, running, started)

    @Test fun mainActions() {
        val check = habit(HabitKind.Check, name = "Take vitamins")
        assertEquals(PlayerAction.MARK_DONE, action(check).action)
        assertEquals("Mark done", action(check).label)
        assertEquals("Mark Take vitamins done", action(check).spoken)
        assertEquals("Next", action(check, done = true).label)
        assertEquals("Finish routine", action(check, done = true, last = true).label)
        assertEquals(PlayerAction.FINISH, action(check, done = true, last = true).action)

        val several = habit(HabitKind.Check, 3.0, name = "Stretch breaks")
        assertEquals(PlayerAction.LOG_ONE, action(several).action)
        assertEquals("Log one", action(several).label)

        val water = habit(HabitKind.Amount("glasses", 1.0), 8.0)
        assertEquals("+1", action(water).label)
        assertEquals("Add 1 glass to Water", action(water).spoken)
        assertEquals("+2.5", action(habit(HabitKind.Amount("kilometres", 2.5), 15.0, Frequency.PerWeek(1), name = "Run")).label)

        val savings = habit(HabitKind.Amount("£", 0.0), 200.0, Frequency.PerMonth(1), name = "Savings")
        assertEquals(PlayerAction.LOG_AMOUNT, action(savings).action)
        assertEquals("Log", action(savings).label)
        assertEquals("Log an amount for Savings", action(savings).spoken)

        val coffee = habit(HabitKind.Amount("cups", 1.0), 2.0, atMost = true, name = "Coffee")
        assertEquals("+1", action(coffee).label)
        // A limit is never done: it keeps logging, whatever "done" says.
        assertEquals(PlayerAction.LOG_STEP, action(coffee, done = true).action)

        val read = habit(HabitKind.Duration, 20.0, name = "Read")
        assertEquals("Start", action(read).label)
        assertEquals("Pause", action(read, running = true).label)
        assertEquals("Stop Read timer", action(read, running = true).spoken)
        assertEquals("Resume", action(read, started = true).label)
        assertEquals("Next", action(read, done = true).label)
        // At the goal the clock keeps counting: Pause stays until it's paused (Figma 4.3).
        assertEquals("Pause", action(read, done = true, running = true).label)
        // Another day has no clock: its time is typed (Figma 1.4).
        val otherDay = PlayerWords.mainAction(read, 20.0, false, false, false, false, false, today = false)
        assertEquals(PlayerAction.LOG_AMOUNT, otherDay.action)
        assertEquals("Log", otherDay.label)

        assertEquals(PlayerAction.NONE, action(habit(HabitKind.Checklist, 3.0)).action)
        assertEquals("Mark done", action(habit(HabitKind.Task, name = "Pay the phone bill")).label)
        // Skipped moves on, even for a checklist.
        assertEquals("Next", action(habit(HabitKind.Checklist, 3.0), skipped = true).label)
    }

    @Test fun endPage() {
        assertEquals("End of the routine", PlayerWords.endTitle(2, "Anytime"))
        assertEquals("Anytime is done", PlayerWords.endTitle(0, "Anytime"))
        assertEquals("2 left for later. Your progress is saved.", PlayerWords.endText(2, 12))
        assertEquals("All 12 done today.", PlayerWords.endText(0, 12))
        assertEquals("1 skipped for today. Skipped days don't count against you.", PlayerWords.skippedLine(1))
        assertNull(PlayerWords.skippedLine(0))
        assertEquals("1 limit check-in. Your limits keep tracking through the day.", PlayerWords.limitsLine(1))
        assertEquals("2 limit check-ins. Your limits keep tracking through the day.", PlayerWords.limitsLine(2))
    }

    @Test fun queue() {
        assertEquals("Done", PlayerWords.queueStatus(atMost = false, reviewed = false, doneToday = true, skipped = false))
        assertEquals("Skipped for today", PlayerWords.queueStatus(atMost = false, reviewed = false, doneToday = false, skipped = true))
        assertEquals("Not done", PlayerWords.queueStatus(atMost = false, reviewed = false, doneToday = false, skipped = false))
        assertEquals("Here now", PlayerWords.queueStatus(atMost = false, reviewed = false, doneToday = false, skipped = false, here = true))
        assertEquals("Limit check-in", PlayerWords.queueStatus(atMost = true, reviewed = false, doneToday = false, skipped = false))
        assertEquals("Checked in", PlayerWords.queueStatus(atMost = true, reviewed = true, doneToday = false, skipped = false))
        assertEquals("Close, the timer keeps running", PlayerWords.timerClose(true))
    }
}
