package com.oftenenough.app

import android.content.Intent
import androidx.compose.ui.semantics.SemanticsProperties
import androidx.compose.ui.semantics.getOrNull
import androidx.compose.ui.test.SemanticsMatcher
import androidx.compose.ui.test.hasAnyAncestor
import androidx.compose.ui.test.hasContentDescription
import androidx.compose.ui.test.hasTestTag
import androidx.compose.ui.test.hasText
import androidx.compose.ui.test.isEnabled
import androidx.compose.ui.test.isNotEnabled
import androidx.compose.ui.test.isSelected
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

    private fun launch(plus: Boolean = false) {
        val intent = Intent(ApplicationProvider.getApplicationContext(), MainActivity::class.java)
            .putExtra(TestLaunch.UITEST, true).putExtra(TestLaunch.CLOCK_HOUR, 10).putExtra(TestLaunch.DEMO, "today")
        if (plus) intent.putExtra(TestLaunch.PLUS, true)
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

    /** Colour (5.7.5, Figma 1074:161496): a sheet of 13; tapping one chooses it and closes the sheet. */
    @Test fun aColourIsChosenAsItIsTapped() {
        launch()
        tapTag("new-habit")
        tapTag("new-build")
        tapTag("type-check")
        tapTag("colour-row")
        waitFor(hasTestTag("colour-gray"), "the last of the 13")
        tapTag("colour-orange")
        waitGone(hasTestTag("colour-gray"), "the sheet")
        tapTag("colour-row")
        waitFor(hasTestTag("colour-orange").and(isSelected()), "orange chosen")
    }

    /**
     * How often (5.7.6, Figma 1075:161386, flow "How often: several a day, or a number of times"): no group titles; the
     * chosen option says what it means and opens its own settings; ← and the form's row says it.
     */
    @Test fun howOftenSaysEachChoiceAsItIsSet() {
        launch()
        tapTag("new-habit")
        tapTag("new-build")
        tapTag("type-check")
        tapTag("how-often-row")
        waitFor(hasText("Several times a day"), "the options")
        assertTrue("no group titles", !has(hasText("Daily")) && !has(hasText("A number of times")))
        tapTag("often-times-a-day")
        waitFor(hasText("Twice a day"), "Twice a day")
        tap(hasContentDescription("More").and(hasAnyAncestor(hasTestTag("often-per-day"))), "+")
        waitFor(hasText("3 times a day"), "3 times a day")
        tapTag("often-times")
        waitFor(hasText("times a week", substring = true), "a number of times a week")
        tapTag("page-back")
        waitFor(hasTestTag("how-often-row").and(hasContentDescription("times a week", substring = true)), "the form's row saying it")
    }

    /**
     * Reminders (5.7.8, Figma 1100:2996): off as every habit starts, saying what turning it on does; on, Remind me at with
     * a time, How with its footer, and Reminder says. On the free plan, remind again is Plus (A73).
     */
    @Test fun remindersTurnOnWithFigmasGroups() {
        launch()
        tapTag("new-habit")
        tapTag("new-build")
        tapTag("type-check")
        tapTag("reminders-row")
        waitFor(hasText("Reminders are off. Turning on Remind me asks Android once if Often Enough may send notifications."), "the off footer")
        tapTag("remind-me")
        waitFor(hasText("Remind me at"), "Remind me at")
        waitFor(hasTestTag("reminder-0"), "a time")
        waitFor(hasText("Not sent on a day it’s already done."), "How's footer")
        waitFor(hasText("Shown instead of the name when names are hidden outside the app."), "Reminder says' footer")
        waitFor(hasTestTag("follow-up").and(hasContentDescription("Plus", substring = true)), "remind again marked Plus")
    }

    /**
     * How much (5.7.9, Figma 1102:2782; flow "A new habit: track an amount"): the number, its footer, and When you log it,
     * which the form says back ("8 · each tap adds 1", or typed each time).
     */
    @Test fun howMuchChoosesHowItIsLogged() {
        launch()
        tapTag("new-habit")
        tapTag("new-build")
        tapTag("type-amount")
        tapTag("how-much-row")
        waitFor(hasText("Up to 2 decimal places. The unit is optional."), "the footer")
        type("much-number", "8")
        waitFor(hasText("When you log it"), "When you log it")
        waitFor(hasTestTag("tap-step"), "Each tap adds")
        tapTag("page-back")
        waitFor(hasTestTag("how-much-row").and(hasContentDescription("each tap adds 1", substring = true)), "the form saying what a tap adds")
        tapTag("how-much-row")
        tapTag("tap-asks")
        tapTag("page-back")
        waitFor(hasTestTag("how-much-row").and(hasContentDescription("typed each time", substring = true)), "the form saying it's typed")
    }

    /** Unit (5.7.10, Figma 1102:3316): search shows only matching units; your own unit is made with Done. */
    @Test fun unitSearchesAndMakesYourOwn() {
        launch()
        tapTag("new-habit")
        tapTag("new-build")
        tapTag("type-amount")
        tapTag("how-much-row")
        tapTag("much-unit")
        waitFor(hasText("Search units"), "the search bar")
        waitFor(hasText("Your own"), "Your own")
        type("unit-search", "bo")
        waitFor(hasTestTag("unit-bottles"), "bottles")
        waitFor(hasTestTag("unit-books"), "books")
        waitGone(hasTestTag("unit-glasses"), "glasses")
        type("unit-search", "")
        tapTag("create-unit")
        type("custom-unit", "prayers")
        tapTag("custom-unit-done")
        waitFor(hasText("prayers"), "How much with prayers")
        tapTag("much-unit")
        waitFor(hasContentDescription("Remove prayers"), "prayers with ✕ in Your own")
    }

    /** Steps (5.7.12, Figma 1104:163327): Add step opens a field to type in; the form counts the steps. */
    @Test fun stepsAreTypedOneByOne() {
        launch(plus = true)
        tapTag("new-habit")
        tapTag("new-build")
        tapTag("type-checklist")
        waitFor(hasTestTag("steps-row").and(hasContentDescription("None yet", substring = true)), "Steps not set yet")
        tapTag("steps-row")
        waitFor(hasText("Up to 24 letters a step. Each step is ticked on its own."), "the footer")
        tapTag("add-step")
        type("step-field-0", "Dishes")
        tapTag("add-step")
        type("step-field-1", "Sink")
        tapTag("page-back")
        waitFor(hasTestTag("steps-row").and(hasContentDescription("2 steps", substring = true)), "the form saying 2 steps")
    }

    /**
     * Limit (5.7.13, Figma 1105:3190; A67): Amount · Time. Amount: at most a number and its unit; Time: at most hours and
     * minutes with quick picks, which the form's Limit says back.
     */
    @Test fun aLimitIsAnAmountOrATime() {
        launch()
        tapTag("new-habit")
        tapTag("new-quit")
        tapTag("type-cut_down")
        tapTag("how-much-row")
        waitFor(hasText("At most"), "At most")
        waitFor(hasText("Log it only when it happens. At or under the limit counts as a good day."), "Amount's footer")
        tapTag("limit-kind-1")
        waitFor(hasText("Quick picks"), "Time's quick picks")
        tapTag("limit-pick-60")
        waitFor(hasText("Log time spent, or use the timer. At or under the limit counts as a good day."), "Time's footer")
        tapTag("page-back")
        waitFor(hasTestTag("how-much-row").and(hasContentDescription("1 h", substring = true)), "the form's Limit saying 1 h")
    }

    /** What kind of task? (5.7.14): On repeat opens the repeating task form, with How often and no Date or Repeat row. */
    @Test fun aRepeatingTaskIsChosenBeforeTheForm() {
        launch()
        tapTag("new-habit")
        tapTag("new-task")
        waitFor(hasText("Comes back on the days you pick, or a while after it’s done."), "On repeat")
        tapTag("task-repeat")
        waitFor(hasText("New task"), "the task form")
        waitFor(hasTestTag("how-often-row"), "How often")
        waitFor(hasText("It comes back on the days you pick."), "its footer")
        assertTrue("no Date", !has(hasTestTag("task-date")))
        assertTrue("no Repeat row", !has(hasTestTag("repeat-row")))
        tapTag("form-back")
        waitFor(hasText("What kind of task?"), "back on What kind of task?")
    }

    /**
     * How do you want to track it? (5.7.16, Figma 1208:375097): four ways with their examples; on the free plan a new
     * Checklist is Plus (A73), its label beside the name, and its tap doesn't open the form.
     */
    @Test fun aNewChecklistIsPlusOnTheFreePlan() {
        launch()
        tapTag("new-habit")
        tapTag("new-build")
        waitFor(hasText("One habit, several steps."), "Checklist's line")
        waitFor(hasText("e.g. Workout: push-ups, squats"), "Checklist's example")
        waitFor(hasText("Plus").and(hasAnyAncestor(hasTestTag("type-checklist"))), "the Plus label beside Checklist")
        tapTag("type-checklist")
        compose.waitForIdle()
        assertTrue("no checklist form on the free plan", !has(hasTestTag("steps-row")))
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
        // Time of day (5.7.7, Figma 1098:2480): its title, and no line under it repeating the choice (A64).
        waitFor(hasText("Time of day"), "the title")
        tapTag("part-set")
        waitFor(hasText("Pick one or more"), "At set times of day")
        assertTrue("no line under the choice", !has(hasText("It shows in", substring = true)))
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
        waitFor(hasTestTag("part-$id"), "Before work on the Time of day page")
    }

    @Test fun howLongTakesAQuickPickAndATasksTimeWaitsForOk() {
        launch()
        tapTag("new-habit")
        tapTag("new-build")
        tapTag("type-time")
        waitFor(hasText("Not set yet"), "How long not set yet")
        tapTag("how-much-row")
        // How long (5.7.11, Figma 1103:3208): Hours and Minutes, Quick picks and the footer.
        waitFor(hasText("Quick picks"), "Quick picks")
        waitFor(hasText("The timer on Today counts up to it."), "the footer")
        tapTag("pick-30")
        tapTag("page-back")
        waitFor(hasText("30 min"), "How long 30 min on the form")
        // Nothing typed: ← leaves without asking (Figma 2.1.9 asks only after typing).
        tapTag("form-back")
        waitFor(hasText("How do you want to track it?"), "the choices")
        tapTag("page-back")
        tapTag("new-task")
        tapTag("task-once")
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
