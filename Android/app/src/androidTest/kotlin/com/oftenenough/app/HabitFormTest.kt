package com.oftenenough.app

import android.content.Intent
import androidx.compose.ui.semantics.SemanticsProperties
import androidx.compose.ui.semantics.getOrNull
import androidx.compose.ui.test.SemanticsMatcher
import androidx.compose.ui.test.hasContentDescription
import androidx.compose.ui.test.hasTestTag
import androidx.compose.ui.test.hasText
import androidx.compose.ui.test.isEnabled
import androidx.compose.ui.test.isNotEnabled
import androidx.compose.ui.test.junit4.createEmptyComposeRule
import androidx.compose.ui.test.longClick
import androidx.compose.ui.test.onNodeWithTag
import androidx.compose.ui.test.performClick
import androidx.compose.ui.test.performScrollTo
import androidx.compose.ui.test.performScrollToNode
import androidx.compose.ui.test.performTextClearance
import androidx.compose.ui.test.performTextInput
import androidx.compose.ui.test.performTouchInput
import androidx.test.core.app.ActivityScenario
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.app.TestLaunch
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

/**
 * The New habit and Edit habit flows (Create new form, 5.7.3, Figma 1065:2597): Edit has no Type row (A68) and asks
 * before leaving with changes, a goal change says it starts today, the 6th habit and Make room, a new time of day set by its start alone
 * (Current Work 108), How long's quick picks and a task's Time. Every launch is a test launch (D8) at 10:30 (T11); a
 * failure says, on one line, what was on screen (T14).
 */
@OptIn(androidx.compose.ui.test.ExperimentalTestApi::class)
@RunWith(AndroidJUnit4::class)
class HabitFormTest {
    @get:Rule val compose = createEmptyComposeRule()
    private var scenario: ActivityScenario<MainActivity>? = null

    @After fun close() { scenario?.close() }

    private fun launch() {
        val intent = Intent(ApplicationProvider.getApplicationContext(), MainActivity::class.java)
            .putExtra(TestLaunch.UITEST, true).putExtra(TestLaunch.CLOCK_HOUR, 10).putExtra(TestLaunch.DEMO, "today")
        TestDevice.clear()
        scenario = ActivityScenario.launch(intent)
        waitFor(hasTestTag("row-Read"), "the demo on Today")
    }

    private val store: HabitStore get() = AppGraph.store

    private fun screen(): String = compose.onAllNodes(SemanticsMatcher("anything") { true }, useUnmergedTree = true).fetchSemanticsNodes().mapNotNull { n ->
        (n.config.getOrNull(SemanticsProperties.Text)?.joinToString(" ") { it.text } ?: n.config.getOrNull(SemanticsProperties.ContentDescription)?.joinToString(" "))
            ?.takeIf { it.isNotBlank() }
    }.distinct().joinToString(" | ").take(3000)

    private fun has(m: SemanticsMatcher) = compose.onAllNodes(m, useUnmergedTree = true).fetchSemanticsNodes().isNotEmpty()

    private fun waitFor(m: SemanticsMatcher, what: String, timeout: Long = 15_000) {
        try {
            compose.waitUntil(timeout) {
                if (has(hasTestTag("today-list"))) runCatching { compose.onNodeWithTag("today-list").performScrollToNode(m) }
                has(m)
            }
        } catch (e: Throwable) { throw AssertionError("Waited for $what; on screen: ${screen()}") }
    }

    private fun waitGone(m: SemanticsMatcher, what: String, timeout: Long = 15_000) {
        try { compose.waitUntil(timeout) { !has(m) } } catch (e: Throwable) { throw AssertionError("Waited for $what to go; on screen: ${screen()}") }
    }

    private fun waitUntil(what: String, timeout: Long = 15_000, check: () -> Boolean) {
        try { compose.waitUntil(timeout) { check() } } catch (e: Throwable) { throw AssertionError("Waited for $what; on screen: ${screen()}") }
    }

    private fun tap(m: SemanticsMatcher, what: String) {
        waitFor(m, what)
        compose.waitForIdle()
        // A row below the fold of a scrolling page is in the tree but takes no touch: bring it on screen first (T22).
        runCatching { compose.onAllNodes(m, useUnmergedTree = true)[0].performScrollTo() }
        compose.waitForIdle()
        compose.onAllNodes(m, useUnmergedTree = true)[0].performClick()
    }

    private fun tapTag(tag: String) = tap(hasTestTag(tag), "tag $tag")
    private fun tapText(text: String) = tap(hasText(text), "\"$text\"")
    private fun onMain(block: () -> Unit) = InstrumentationRegistry.getInstrumentation().runOnMainSync(block)

    private fun type(tag: String, text: String) {
        waitFor(hasTestTag(tag), "tag $tag")
        compose.onNodeWithTag(tag, useUnmergedTree = true).performTextClearance()
        compose.onNodeWithTag(tag, useUnmergedTree = true).performTextInput(text)
    }

    private fun editWater() {
        compose.onNodeWithTag("row-Water", useUnmergedTree = true).performTouchInput { longClick() }
        tapText("Edit habit")
        waitFor(hasTestTag("how-much-row"), "Edit habit's How much")
    }

    private fun water() = store.habits.filter { it.name == "Water" }

    /**
     * Edit habit (5.7.3, Figma's Edit habit): the same form, filled in, with Save; no Type row (A68), no Group and no
     * preview (A64). ← with changes asks; Keep editing stays, Discard leaves the habit as it was.
     */
    @Test fun editHasNoTypeRowAndLeavingWithChangesAsks() {
        launch()
        val before = water().single()
        editWater()
        waitFor(hasText("Edit habit"), "the title")
        waitFor(hasText("Save"), "Save")
        assertTrue("no Type row", !has(hasTestTag("type-row")))
        assertTrue("no Group row", !has(hasTestTag("group-row")))
        assertTrue("no preview", !has(hasTestTag("today-preview")))
        type("description-field", "Before lunch")
        tapTag("form-back")
        waitFor(hasText("Discard your changes?"), "the discard question")
        tapText("Keep editing")
        waitGone(hasText("Discard your changes?"), "the discard question")
        tapTag("form-back")
        tapText("Discard")
        waitFor(hasTestTag("row-Water"), "Today")
        assertEquals(listOf(before), water())
    }

    /** New habit (5.7.3): Figma's rows for Check it off, Add quiet until there's a name, and a quit habit's footer. */
    @Test fun theNewFormHasFigmasRows() {
        launch()
        tapTag("new-habit")
        tapTag("new-build")
        tapTag("type-check")
        waitFor(hasText("New habit"), "the title")
        for (tag in listOf("name-field", "description-field", "icon-row", "colour-row", "how-often-row", "time-of-day-row", "reminders-row", "starts-row", "ends-row"))
            waitFor(hasTestTag(tag), "the row $tag")
        waitFor(hasTestTag("form-add").and(isNotEnabled()), "Add quiet with no name")
        type("name-field", "Journal")
        waitFor(hasTestTag("form-add").and(isEnabled()), "Add ready")
        tapTag("form-back")
        tapText("Discard")
        tapTag("page-back")
        tapTag("new-quit")
        tapTag("type-quit")
        waitFor(hasTestTag("quit-started"), "Started | At")
        waitFor(hasText("The run counts up from here. A slip starts it again."), "its footer")
        assertTrue("a quit habit has no How often", !has(hasTestTag("how-often-row")))
    }

    /** The Icon picker (5.7.4, Figma 1074:932): kinds with search; Done keeps the one tapped, ✕ leaves it as it was. */
    @Test fun theIconPickerKeepsATappedIconOnlyWithDone() {
        launch()
        tapTag("new-habit")
        tapTag("new-build")
        tapTag("type-check")
        tapTag("icon-row")
        waitFor(hasText("Search icons"), "the search bar")
        waitFor(hasText("Health"), "the first kind")
        tapTag("icon-figure.walk")
        tapTag("icon-done")
        tapTag("icon-row")
        waitFor(hasTestTag("icon-figure.walk").and(hasContentDescription("chosen", substring = true)), "the walk chosen")
        tapTag("icon-figure.run")
        tapTag("page-back")
        tapTag("icon-row")
        waitFor(hasTestTag("icon-figure.walk").and(hasContentDescription("chosen", substring = true)), "still the walk after ✕")
    }

    @Test fun aGoalChangeSaysItStartsTodayAndSaves() {
        launch()
        editWater()
        tapTag("how-much-row")
        type("much-number", "10")
        tapTag("page-back")
        waitUntil("the goal note") { screen().contains("The new goal starts today") }
        tapTag("form-add")
        waitUntil("Water's goal saved as 10") { water().single().goal == 10.0 }
    }

    @Test fun aSixthHabitAsksForPlusOrRoomAndMakeRoomAddsIt() {
        launch()
        // The free plan's five: archive the demo's other habits.
        onMain { store.archive(store.habits.filter { !it.archived && it.kind != HabitKind.Task }.drop(HabitStore.FREE_HABIT_LIMIT)) }
        waitUntil("five habits") { store.activeHabitCount == HabitStore.FREE_HABIT_LIMIT && !store.canAddHabit }
        tapTag("new-habit")
        tapTag("new-build")
        tapTag("type-check")
        type("name-field", "Stretch")
        tapTag("form-add")
        waitFor(hasTestTag("sixth-habit"), "Add a 6th habit")
        waitFor(hasText("5 of 5 free habits used"), "the count")
        tapTag("sixth-make-room")
        waitFor(hasText("Make room"), "Make room")
        val first = store.habits.first { !it.archived && it.kind != HabitKind.Task }
        tapTag("room-archive-${first.name}")
        waitUntil("Stretch added after making room") { store.habits.any { it.name == "Stretch" && !it.archived } }
        assertTrue(store.habits.first { it.id == first.id }.archived)
    }

    /** Quit or cut down (5.7.2, Figma 1061:2101): ←, the question, Quit and Cut down with their lines and examples. */
    @Test fun quitOrCutDownOffersBothWithTheirExamples() {
        launch()
        tapTag("new-habit")
        tapTag("new-quit")
        waitFor(hasText("Stop completely. Track the time since you stopped."), "Quit")
        waitFor(hasText("e.g. Smoking"), "Quit's example")
        waitFor(hasText("Set a maximum and log how much."), "Cut down")
        waitFor(hasText("e.g. Coffee, 2 a day"), "Cut down's example")
        tapTag("page-back")
        waitFor(hasTestTag("new-quit"), "back on What do you want to do?")
    }

    @Test fun aNewTimeOfDayIsSetByItsStartAndChosenForTheHabit() {
        launch()
        tapTag("new-habit")
        tapTag("new-build")
        tapTag("type-check")
        tapTag("time-of-day-row")
        tapTag("part-set")
        tapTag("new-time-of-day")
        waitFor(hasText("Ends 6:00 AM, when Morning starts"), "the worked-out end")
        waitFor(hasText("New"), "the + New chip")
        assertTrue("no Ends tile", !has(hasTestTag("section-end")))
        type("section-name-field", "Before work")
        tapTag("section-save")
        waitUntil("Before work saved at 4:00 AM, nothing else changed") {
            store.sections.any { it.name == "Before work" && it.start == 4 * 60 } &&
                store.sections.first { it.name == "Morning" }.start == 6 * 60
        }
        val id = store.sections.first { it.name == "Before work" }.id
        waitFor(hasTestTag("part-$id"), "Before work on the Time of Day page")
    }

    @Test fun howLongTakesAQuickPickAndATasksTimeWaitsForOk() {
        launch()
        tapTag("new-habit")
        tapTag("new-build")
        tapTag("type-time")
        waitFor(hasText("Not set yet"), "How long not set yet")
        tapTag("how-much-row")
        tapTag("pick-30")
        tapTag("page-back")
        waitFor(hasText("30 min"), "How long 30 min on the form")
        // Nothing typed: ← leaves without asking (Figma 2.1.9 asks only after typing).
        tapTag("form-back")
        waitFor(hasText("How do you want to track it?"), "the choices")
        tapTag("page-back")
        tapTag("new-task")
        tapTag("task-time")
        waitFor(hasText("Enter time"), "the time picker")
        tapText("Cancel")
        waitGone(hasText("Enter time"), "the time picker")
        assertTrue("Time stays off after Cancel", !has(hasTestTag("task-time-pill")))
        tapTag("task-time")
        tapText("OK")
        waitFor(hasTestTag("task-time-pill"), "Time on after OK")
    }
}
