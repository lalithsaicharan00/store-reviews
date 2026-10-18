package com.oftenenough.app

import android.content.Intent
import androidx.compose.ui.test.SemanticsMatcher
import androidx.compose.ui.test.hasContentDescription
import androidx.compose.ui.test.hasTestTag
import androidx.compose.ui.test.hasText
import androidx.compose.ui.test.junit4.createEmptyComposeRule
import androidx.compose.ui.test.onNodeWithTag
import androidx.compose.ui.test.performClick
import androidx.compose.ui.test.performScrollToNode
import androidx.compose.ui.semantics.SemanticsProperties
import androidx.compose.ui.semantics.getOrNull
import androidx.test.core.app.ActivityScenario
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.app.TestLaunch
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HabitKind
import org.junit.After
import org.junit.Assert.assertNotEquals
import org.junit.Assert.assertEquals
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Checkpoint 1's flows on the emulator: the welcome both ways, an empty Today, and logging and undo for every kind of
 * habit. Every launch is a test launch (D8) at 10:30 (T11); a failure says, on one line, what was on screen (T14).
 */
@RunWith(AndroidJUnit4::class)
class TodayTest {
    @get:Rule val compose = createEmptyComposeRule()
    private var scenario: ActivityScenario<MainActivity>? = null

    @After fun close() { scenario?.close() }

    private fun launch(demo: String? = null, onboarding: Boolean = false, clockHour: Int = 10) {
        val intent = Intent(ApplicationProvider.getApplicationContext(), MainActivity::class.java)
            .putExtra(TestLaunch.UITEST, true).putExtra(TestLaunch.CLOCK_HOUR, clockHour)
        if (demo != null) intent.putExtra(TestLaunch.DEMO, demo)
        if (onboarding) intent.putExtra(TestLaunch.ONBOARDING, true)
        scenario = ActivityScenario.launch(intent)
    }

    /** Every text and label on screen, on one line (T14). */
    private fun screen(): String = compose.onAllNodesWith(SemanticsMatcher("anything") { true }).let { nodes ->
        nodes.mapNotNull { n ->
            (n.config.getOrNull(SemanticsProperties.Text)?.joinToString(" ") { it.text }
                ?: n.config.getOrNull(SemanticsProperties.ContentDescription)?.joinToString(" "))?.takeIf { it.isNotBlank() }
        }.distinct().joinToString(" | ").take(4000)
    }

    private fun androidx.compose.ui.test.junit4.ComposeTestRule.onAllNodesWith(m: SemanticsMatcher) =
        onAllNodes(m, useUnmergedTree = true).fetchSemanticsNodes()

    private fun waitFor(m: SemanticsMatcher, what: String, timeout: Long = 15_000) {
        try {
            compose.waitUntil(timeout) {
                // A row the list pushed past its edge isn't composed (a step under the after-log line): bring it on screen.
                if (compose.onAllNodes(hasTestTag("today-list")).fetchSemanticsNodes().isNotEmpty())
                    runCatching { compose.onNodeWithTag("today-list").performScrollToNode(m) }
                compose.onAllNodes(m, useUnmergedTree = true).fetchSemanticsNodes().isNotEmpty()
            }
        } catch (e: Throwable) {
            throw AssertionError("Waited for $what; on screen: ${screen()}")
        }
    }

    private fun waitGone(m: SemanticsMatcher, what: String, timeout: Long = 15_000) {
        try {
            compose.waitUntil(timeout) { compose.onAllNodes(m, useUnmergedTree = true).fetchSemanticsNodes().isEmpty() }
        } catch (e: Throwable) {
            throw AssertionError("Waited for $what to go; on screen: ${screen()}")
        }
    }

    private fun tap(m: SemanticsMatcher, what: String) {
        waitFor(m, what)
        // A row composed just past the list's edge (steps shown under the last row) takes no touch: bring it on screen.
        runCatching { compose.onNodeWithTag("today-list").performScrollToNode(m) }
        compose.waitForIdle()
        compose.onAllNodes(m, useUnmergedTree = true)[0].performClick()
    }

    private fun tapLabel(label: String) = tap(hasContentDescription(label), "\"$label\"")
    private fun tapTag(tag: String) = tap(hasTestTag(tag), "tag $tag")

    /** Scrolls Today's list to a row (the list is lazy: an unseen row isn't on screen yet). */
    private fun showRow(name: String) {
        waitFor(hasTestTag("today-list"), "Today's list")
        compose.onNodeWithTag("today-list").performScrollToNode(hasTestTag("row-$name"))
    }

    private fun line(name: String): String = compose.onAllNodes(hasTestTag("line-$name"), useUnmergedTree = true).fetchSemanticsNodes()
        .firstOrNull()?.config?.getOrNull(SemanticsProperties.Text)?.joinToString(" ") { it.text } ?: ""

    @Test fun aNewPersonGoesThroughTheWelcomeToAnEmptyToday() {
        launch(onboarding = true)
        tapTag("onboarding-new")
        waitFor(hasText("Your habit. Your goal."), "the first page")
        tapTag("onboarding-continue")
        waitFor(hasText("Quit or cut down."), "the quit page")
        tapTag("onboarding-continue")
        waitFor(hasText("Tasks, once or on repeat."), "the tasks page")
        tapTag("onboarding-continue")
        waitFor(hasText("Your days and weeks."), "days and weeks")
        waitFor(hasText("12:00 AM"), "the day start")
        waitFor(hasText("Sunday"), "the week start")
        tapTag("onboarding-continue")
        waitFor(hasText("Your first habit."), "the ideas")
        tapTag("skip-setup")
        waitFor(hasText("No habits yet"), "an empty Today")
    }

    @Test fun someoneComingBackCanStartWithoutRestoring() {
        launch(onboarding = true)
        tapTag("onboarding-returning")
        waitFor(hasText("Welcome back."), "Welcome back")
        tapTag("start-without-restoring")
        waitFor(hasText("No habits yet"), "an empty Today")
    }

    @Test fun anIdeaOpensTheFormWithItsName() {
        launch(onboarding = true)
        tapTag("onboarding-new")
        repeat(4) { tapTag("onboarding-continue") }
        tapTag("idea-Exercise")
        waitFor(hasTestTag("name-field"), "the New Habit form")
        waitFor(hasText("Exercise 3 times a week, anytime"), "the idea's sentence")
        tapTag("form-add")
        waitFor(hasTestTag("row-Exercise"), "Exercise on Today")
    }

    @Test fun aCheckTicksAndUndoes() {
        launch(demo = "today")
        showRow("Meds")
        // The demo has Meds ticked today: its ✓ takes it back first (U14: ✓ toggles a once-a-day tick).
        tapLabel("Undo Meds")
        waitFor(hasContentDescription("Mark Meds done"), "Meds unticked by its ✓")
        tapLabel("Mark Meds done")
        waitFor(hasContentDescription("Undo Meds"), "Meds ticked")
        tapTag("undo-Meds")
        waitFor(hasContentDescription("Mark Meds done"), "Meds unticked")
    }

    @Test fun anAmountAddsItsStepAndUndoNamesIt() {
        launch(demo = "today")
        showRow("Water")
        val before = line("Water")
        tapLabel("Add 1 glass to Water")
        waitFor(hasTestTag("undo-Water"), "Water's Undo")
        waitFor(hasText("Undo +1 glass", substring = true), "Undo naming the glass")
        assertNotEquals("Water's line after +1; on screen: ${screen()}", before, line("Water"))
        tapTag("undo-Water")
        waitGone(hasTestTag("undo-Water"), "Water's Undo")
        assertEquals("Water's line after Undo; on screen: ${screen()}", before, line("Water"))
    }

    @Test fun aWeekCountAddsOneAndNeverTakesBack() {
        launch(demo = "today")
        showRow("Call family")
        val before = line("Call family")
        tapLabel("Add 1 to Call family")
        waitFor(hasTestTag("undo-Call family"), "Call family's Undo")
        assertNotEquals("Call family's line after ✓; on screen: ${screen()}", before, line("Call family"))
        tapTag("undo-Call family")
        waitGone(hasTestTag("undo-Call family"), "Call family's Undo")
        assertEquals("Call family's line after Undo; on screen: ${screen()}", before, line("Call family"))
    }

    @Test fun aChecklistTicksAStep() {
        launch(demo = "today")
        showRow("Skincare")
        tapLabel("Show Skincare steps")
        // The demo has Cleanser ticked today; Serum isn't.
        tapLabel("Mark Serum done")
        waitFor(hasContentDescription("Undo Serum"), "Serum ticked")
        tapLabel("Undo Serum")
        waitFor(hasContentDescription("Mark Serum done"), "Serum unticked")
        tapLabel("Hide Skincare steps")
        waitGone(hasContentDescription("Mark Serum done"), "the steps")
    }

    @Test fun aTimerStartsAndStops() {
        launch(demo = "today")
        showRow("Read")
        tapLabel("Start Read timer")
        waitFor(hasContentDescription("Stop Read timer"), "Read's timer running")
        tapLabel("Stop Read timer")
        waitFor(hasContentDescription("Start Read timer"), "Read's timer stopped")
    }

    @Test fun aQuitHabitShowsItsRun() {
        launch(demo = "today")
        showRow("Smoking")
        waitFor(hasTestTag("row-Smoking"), "Smoking under Quit or cut down")
    }

    @Test fun aTaskTicksAndUnticks() {
        launch(demo = "today")
        waitFor(hasTestTag("today-list"), "Today")
        InstrumentationRegistry.getInstrumentation().runOnMainSync {
            AppGraph.store.add(Habit(name = "Pay rent", symbol = "calendar", color = HabitColor.BLUE, kind = HabitKind.Task, dueDay = AppGraph.store.today()))
        }
        showRow("Pay rent")
        tapLabel("Mark Pay rent done")
        waitFor(hasContentDescription("Undo Pay rent"), "Pay rent ticked")
        tapLabel("Undo Pay rent")
        waitFor(hasContentDescription("Mark Pay rent done"), "Pay rent unticked")
    }

    @Test fun theDayBarGoesBackADayAndReturns() {
        launch(demo = "today")
        waitFor(hasTestTag("day-bar"), "the day bar")
        tapLabel("Previous day")
        waitFor(hasText("Back to today", substring = true), "Back to today")
        tapTag("back-to-today")
        waitGone(hasTestTag("back-to-today"), "Back to today")
    }
}
