package com.oftenenough.app

import android.content.Intent
import androidx.compose.ui.test.ExperimentalTestApi
import androidx.compose.ui.test.hasContentDescription
import androidx.compose.ui.test.hasTestTag
import androidx.compose.ui.test.hasText
import androidx.compose.ui.test.junit4.createEmptyComposeRule
import androidx.compose.ui.test.performClick
import androidx.compose.ui.test.performScrollToNode
import androidx.test.core.app.ActivityScenario
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.app.TestLaunch
import com.oftenenough.app.data.EntrySource
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitKind
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import kotlin.random.Random

/**
 * A streak follows the logs, whatever changes them and wherever it shows (the user, 4 Nov 2026: "once the streak is
 * increased, it should get back when the log is deleted … if I go back to yesterday and log something, it should update
 * today's streak as well"). Every launch is a test launch (D8) at 10:30 (T11).
 */
@OptIn(ExperimentalTestApi::class)
@RunWith(AndroidJUnit4::class)
class StreakTest {
    @get:Rule val compose = createEmptyComposeRule()
    private var scenario: ActivityScenario<MainActivity>? = null

    @After fun close() { scenario?.close() }

    private fun launch() {
        val intent = Intent(ApplicationProvider.getApplicationContext(), MainActivity::class.java)
            .putExtra(TestLaunch.UITEST, true).putExtra(TestLaunch.CLOCK_HOUR, 10).putExtra(TestLaunch.DEMO, "design")
        TestDevice.clear()
        scenario = ActivityScenario.launch(intent)
        compose.waitUntilAtLeastOneExists(hasTestTag("row-Meds"), 20_000)
    }

    private val store get() = AppGraph.store
    private fun habit(name: String) = store.habits.first { it.name == name }
    private fun <T> onMain(work: () -> T): T = compose.runOnIdle(work)

    /** The remembered numbers against the rules worked out now, and the current run against the streak (ST-4). */
    private fun assertAgrees(h: Habit, day: Int, said: String) {
        assertEquals("$said: ${h.name}'s streak on $day is what the rules say now", store.rules.streak(h, day), store.streak(h, day))
        assertEquals("$said: ${h.name}'s best is what the rules say now", store.rules.bestStreak(h), store.bestStreak(h))
        val today = store.today()
        if (day == today && h.kind != HabitKind.Quit && h.kind != HabitKind.Task && !h.isQuitOrLimit && store.rule(h, today).frequency == h.frequency) {
            val current = store.rules.runs(h, today).lastOrNull { it.isCurrent }?.length ?: 0
            assertEquals("$said: ${h.name}'s current run is its streak", current, store.streak(h, today))
        }
    }

    @Test fun aWeekGoalsStreakRisesWithTheGoalAndFallsWithItsUndo() = onMainTest {
        val h = habit("Call family")
        val today = store.today()
        val left = store.rules.goal(store.rule(h, today)) - store.rules.progress(h, today)
        val before = store.streak(h, today)
        assertTrue("the demo's week isn't met yet", left > 0)
        repeat(left.toInt() - 1) { store.addProgress(h, 1.0, today, source = EntrySource.TODAY) }
        assertEquals("not met yet, nothing added", before, store.streak(h, today))
        store.addProgress(h, 1.0, today, source = EntrySource.TODAY)
        assertEquals("met: one more", before + 1, store.streak(h, today))
        store.addProgress(h, 1.0, today, source = EntrySource.TODAY)
        assertEquals("past the goal: the week counts once", before + 1, store.streak(h, today))
        store.undoLast(h, today)
        assertEquals("still met", before + 1, store.streak(h, today))
        store.undoLast(h, today)
        assertEquals("under the goal: back where it was", before, store.streak(h, today))
        assertAgrees(h, today, "after both Undos")
    }

    @Test fun undoOnTheRowTakesTheNumberBackOnScreen() {
        launch()
        val h = habit("Call family")
        val today = onMain { store.today() }
        val before = onMain { store.streak(h, today) }
        val goal = onMain { store.rules.goal(store.rule(h, today)) }
        onMain { repeat((goal - store.rules.progress(h, today)).toInt() - 1) { store.addProgress(h, 1.0, today, source = EntrySource.TODAY) } }
        compose.onNode(hasTestTag("today-list")).performScrollToNode(hasTestTag("row-Call family"))
        compose.onNode(hasContentDescription("Add a check to Call family")).performClick()
        compose.waitUntilAtLeastOneExists(hasContentDescription("Goal met ${before + 1} weeks in a row"), 5_000)
        compose.onNode(hasText("Undo")).performClick()
        compose.waitUntilAtLeastOneExists(hasContentDescription("Goal met $before weeks in a row"), 5_000)
    }

    @Test fun yesterdaysLogMovesTodaysStreakBothWays() = onMainTest {
        val h = habit("Meds")
        val today = store.today()
        val yesterday = today - 1
        val before = store.streak(h, today)
        assertTrue("Meds has a run in the demo", before > 1 && store.rules.isDone(h, yesterday))
        store.setDayDone(false, h, yesterday)
        assertEquals("no log yesterday: the run has ended", 0, store.streak(h, today))
        assertEquals("yesterday's own row counts nothing", 0, store.shownStreak(h, yesterday))
        store.setDayDone(true, h, yesterday)
        assertEquals("logged again: the run is back", before, store.streak(h, today))
        assertEquals("yesterday's row counts it", before, store.shownStreak(h, yesterday))
        assertAgrees(h, today, "after yesterday's log")
    }

    @Test fun anOlderWeeksLogMovesThisWeeksStreak() = onMainTest {
        val h = habit("Call family")
        val today = store.today()
        val range = store.rules.periodRange(h, today)!!
        val lastWeek = range.first - 1
        val before = store.streak(h, today)
        assertTrue("the demo has weeks met", before > 0 && store.rules.isPeriodMet(h, lastWeek))
        val goalLeft = store.rules.periodRange(h, lastWeek)!!.let { r -> store.entries(h.id).filter { it.day in r } }
        val taken = goalLeft.toList()
        taken.forEach { store.undoEntry(it.id) }
        assertEquals("last week no longer met: this week's streak has nothing before it", 0, store.streak(h, today))
        assertEquals("a past week not met shows none", 0, store.shownStreak(h, lastWeek))
        taken.forEach { store.addProgress(h, it.value, it.day, source = EntrySource.MANUAL) }
        assertEquals("the logs back, the streak back", before, store.streak(h, today))
    }

    @Test fun aLogMovedOrChangedMovesTheStreak() = onMainTest {
        val h = habit("Meds")
        val today = store.today()
        val before = store.streak(h, today)
        val yesterday = store.entries(h.id, today - 1).first()
        store.editEntry(yesterday.id, yesterday.value, store.logTime(store.sameClockTime(yesterday.createdAt, today), today, null), today)
        assertEquals("yesterday's log moved to today: the run before today has ended", 1, store.streak(h, today))
        store.editEntry(yesterday.id, yesterday.value, yesterday.createdAt, today - 1)
        assertEquals("moved back", before, store.streak(h, today))
        assertAgrees(h, today, "after moving a log")
    }

    @Test fun aSkippedDayIsNeutralAndItsUndoCountsAgain() = onMainTest {
        val h = habit("Meds")
        val today = store.today()
        val yesterday = today - 1
        val before = store.streak(h, today)
        store.setDayDone(false, h, yesterday)
        assertEquals("not done: ended", 0, store.streak(h, today))
        store.setSkipped(h, yesterday, true)
        assertEquals("skipped: neutral, the run before it counts", before - 1, store.streak(h, today))
        assertEquals("a skipped day's row keeps the run", before - 1, store.shownStreak(h, yesterday))
        store.setSkipped(h, yesterday, false)
        assertEquals("not skipped: ended again", 0, store.streak(h, today))
    }

    /** Hundreds of logs, Undos, edits, moves and skips, on any day of the last six weeks, on every habit: nothing goes stale. */
    @Test fun nothingGoesStaleAcrossEveryChange() = onMainTest {
        val random = Random(20261104)
        val today = store.today()
        val habits = store.habits.filter { it.kind != HabitKind.Task && !it.archived }
        repeat(400) { step ->
            val h = habits[random.nextInt(habits.size)]
            val day = today - random.nextInt(42)
            val logs = store.entries(h.id)
            when (random.nextInt(6)) {
                0, 1 -> store.addProgress(h, 1.0, day, source = EntrySource.MANUAL)
                2 -> store.undoLast(h, day)
                3 -> logs.randomOrNull(random)?.let { store.undoEntry(it.id) }
                4 -> logs.randomOrNull(random)?.let { store.editEntry(it.id, it.value, store.logTime(store.sameClockTime(it.createdAt, day), day, null), day) }
                5 -> if (store.rules.canSkip(store.rule(h, day))) store.setSkipped(h, day, !store.isSkipped(h, day))
            }
            for (each in habits) {
                assertAgrees(each, today, "step $step")
                assertAgrees(each, today - 1, "step $step")
            }
        }
    }

    private fun onMainTest(body: () -> Unit) {
        launch()
        onMain(body)
    }

}
