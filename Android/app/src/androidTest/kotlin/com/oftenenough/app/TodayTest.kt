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
import androidx.compose.ui.test.performSemanticsAction
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

    private fun launch(demo: String? = null, clockHour: Int = 10) {
        val intent = Intent(ApplicationProvider.getApplicationContext(), MainActivity::class.java)
            .putExtra(TestLaunch.UITEST, true).putExtra(TestLaunch.CLOCK_HOUR, clockHour)
        if (demo != null) intent.putExtra(TestLaunch.DEMO, demo)
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

    /**
     * Milestones (Android/Docs/Milestones): first come, first served, within the day's limits. The days demo has Floss
     * at 29 days, Take vitamins at 13, Water at its 200th glass in total today, and Smoking 30 days clean since yesterday.
     */
    @Test fun milestonesTakeThePopUpThenTheBarThenTheRow() {
        launch(demo = "days")
        // Judged at the day's end: the band, never a pop-up when the app opens (R.9).
        waitFor(hasText("30 days clean"), "Smoking's band")
        // A landmark, the day's first: its pop-up at once; closed, its band stays in the row (P.2, R.1).
        tapLabel("Mark Floss done")
        waitFor(hasTestTag("landmark-popup"), "Floss's pop-up")
        tapTag("landmark-close")
        waitGone(hasTestTag("landmark-popup"), "Floss's pop-up")
        waitFor(hasText("30 days in a row"), "Floss's band")
        // Another first: the bar (V3.1). The test's clock runs the bar's 5 s at once, so its record is checked.
        // The sheet's window goes a moment after it's closed; a touch before then is the sheet's.
        Thread.sleep(1_000)
        tapLabel("Mark Take vitamins done")
        val vitamins = AppGraph.store.habits.first { it.name == "Take vitamins" }
        try {
            compose.waitUntil(15_000) { AppGraph.store.milestones.shown(vitamins.id)?.tier == com.oftenenough.app.data.MilestoneTier.BAR }
        } catch (e: Throwable) {
            throw AssertionError("Take vitamins' bar: ${AppGraph.store.milestones.shown(vitamins.id)}; streak ${AppGraph.store.streak(vitamins, AppGraph.store.today())}; on screen: ${screen()}")
        }
        // Two big moments used: Water's 200th glass is just the row (card 4 B).
        repeat(4) { tapLabel("Add 1 glass to Water") }
        waitFor(hasText("200 glasses in total"), "Water's band")
        // Undo takes it back; done again, it's back without a second moment. The row can sit behind the floating day bar,
        // so Undo is pressed through its click action, as TalkBack presses it.
        waitFor(hasTestTag("undo-Water"), "Water's Undo")
        compose.onAllNodes(hasTestTag("undo-Water"), useUnmergedTree = true)[0]
            .performSemanticsAction(androidx.compose.ui.semantics.SemanticsActions.OnClick)
        waitGone(hasText("200 glasses in total"), "Water's band")
        tapLabel("Add 1 glass to Water")
        waitFor(hasText("200 glasses in total"), "Water's band again")
        waitGone(hasTestTag("landmark-popup"), "a second pop-up")
    }

    @Test fun aNewPersonLandsStraightOnAnEmptyToday() {
        // No onboarding since 22 Oct 2026 (Figma `36:32`): the splash, then Today, and nothing asked.
        launch()
        waitFor(hasText("No habits yet"), "an empty Today")
        waitFor(hasText("New habit"), "New habit")
        waitFor(hasText("Restore from a backup"), "Restore from a backup")
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
        // The chip reads "Undo" (Figma 1350:2); TalkBack hears what it takes back (U14).
        waitFor(hasContentDescription("Undo +1 glass"), "Undo naming the glass")
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
        // Each step is a checkbox named by the step, Done or Not done.
        fun serum(state: String) = hasTestTag("step-Serum") and SemanticsMatcher.expectValue(SemanticsProperties.StateDescription, state)
        waitFor(serum("Not done"), "Serum not done")
        tapTag("step-Serum")
        waitFor(serum("Done"), "Serum ticked")
        tapTag("step-Serum")
        waitFor(serum("Not done"), "Serum unticked")
        tapLabel("Hide Skincare steps")
        waitGone(hasTestTag("step-Serum"), "the steps")
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
