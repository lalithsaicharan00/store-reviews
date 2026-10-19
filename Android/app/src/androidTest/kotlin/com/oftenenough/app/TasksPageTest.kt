package com.oftenenough.app

import android.content.Intent
import androidx.compose.ui.semantics.SemanticsProperties
import androidx.compose.ui.semantics.getOrNull
import androidx.compose.ui.test.SemanticsMatcher
import androidx.compose.ui.test.hasTestTag
import androidx.compose.ui.test.hasText
import androidx.compose.ui.test.junit4.createEmptyComposeRule
import androidx.compose.ui.test.longClick
import androidx.compose.ui.test.onNodeWithTag
import androidx.compose.ui.test.performClick
import androidx.compose.ui.test.performScrollTo
import androidx.compose.ui.test.performScrollToNode
import androidx.compose.ui.test.performTextInput
import androidx.compose.ui.test.performTouchInput
import androidx.test.core.app.ActivityScenario
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.app.TestLaunch
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.NO_DATE_DAY
import com.oftenenough.app.data.doneEntry
import com.oftenenough.app.data.taskDay
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

/**
 * The Tasks page (Figma 2373:2, 19 Oct 2026), on the design's own tasks (`demo tasks`): the One-time tab's days (carried
 * first, done today struck at the end, No date last) and the Repeating tab's lines; a row's ⋮ (Move with Undo, Do today,
 * Skip this time, Delete only once Undo has gone, D6); a long press selecting (never opening) and the bar's Move; search
 * with its groups and New task; Completed's Mark as not done; Archived tasks' Restore; a new task with No date; the coach
 * mark; the menu's count. Test launches only (D8) at 10:30 (T11); a failure says what was on screen (T14).
 */
@OptIn(androidx.compose.ui.test.ExperimentalTestApi::class)
@RunWith(AndroidJUnit4::class)
class TasksPageTest {
    @get:Rule val compose = createEmptyComposeRule()
    private var scenario: ActivityScenario<MainActivity>? = null

    @After fun close() { scenario?.close() }

    private val store: HabitStore get() = AppGraph.store
    private val today: Int get() = store.today()

    private fun launch(coach: Boolean = false) {
        val intent = Intent(ApplicationProvider.getApplicationContext(), MainActivity::class.java)
            .putExtra(TestLaunch.UITEST, true).putExtra(TestLaunch.CLOCK_HOUR, 10).putExtra(TestLaunch.DEMO, "tasks")
            .putExtra(TestLaunch.PLUS, true)
        TestDevice.clear()
        scenario = ActivityScenario.launch(intent)
        waitFor(hasTestTag("row-Pay electricity bill"), "the demo on Today")
        tapTag("menu-button")
        tapTag("menu-tasks")
        waitHere(hasTestTag("tasks-list"), "the Tasks page")
        // The coach mark hangs under the first row: wait for it where it is, never scrolling the list away from it.
        waitHere(hasTestTag("tasks-coach-ok"), "the coach mark")
        if (!coach) { here("tasks-coach-ok"); waitGone(hasTestTag("tasks-coach-ok"), "the coach mark") }
    }

    private fun waitHere(m: SemanticsMatcher, what: String) {
        try { compose.waitUntil(15_000) { has(m) } } catch (e: Throwable) { throw AssertionError("Waited for $what; on screen: ${screen()}") }
    }

    private fun screen(): String = compose.onAllNodes(SemanticsMatcher("anything") { true }, useUnmergedTree = true).fetchSemanticsNodes().mapNotNull { n ->
        (n.config.getOrNull(SemanticsProperties.Text)?.joinToString(" ") { it.text } ?: n.config.getOrNull(SemanticsProperties.ContentDescription)?.joinToString(" "))
            ?.takeIf { it.isNotBlank() }
    }.distinct().joinToString(" | ").take(3000)

    private fun has(m: SemanticsMatcher) = compose.onAllNodes(m, useUnmergedTree = true).fetchSemanticsNodes().isNotEmpty()

    private fun waitFor(m: SemanticsMatcher, what: String, timeout: Long = 15_000) {
        try {
            compose.waitUntil(timeout) {
                for (list in listOf("today-list", "tasks-list", "tasks-repeating-list", "tasks-search-results", "completed-list", "archived-list"))
                    if (has(hasTestTag(list))) runCatching { compose.onNodeWithTag(list).performScrollToNode(m) }
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
        runCatching { compose.onAllNodes(m, useUnmergedTree = true)[0].performScrollTo() }
        compose.waitForIdle()
        compose.onAllNodes(m, useUnmergedTree = true)[0].performClick()
    }

    private fun tapTag(tag: String) = tap(hasTestTag(tag), "tag $tag")
    private fun tapText(text: String) = tap(hasText(text), "\"$text\"")
    /** Taps a popup's item (a menu, a coach mark, a dialog) where it is: scrolling the list behind would close it (T22). */
    private fun here(tag: String) {
        waitHere(hasTestTag(tag), "tag $tag")
        compose.onAllNodes(hasTestTag(tag), useUnmergedTree = true)[0].performClick()
    }
    /** A row's ⋮, then one of its items. */
    private fun menuFor(name: String, vararg items: String) {
        tapTag("tasks-row-more-$name")
        for (item in items) here("tasks-menu-$item")
    }
    /** The snackbar's Undo, where it is: looking through a long list for it outlasts the snackbar. */
    private fun undo() {
        waitHere(hasText("Undo"), "Undo")
        compose.onAllNodes(hasText("Undo"), useUnmergedTree = true)[0].performClick()
    }
    private fun task(name: String) = store.habits.first { it.name == name }
    private fun longPress(name: String) {
        waitFor(hasTestTag("tasks-row-$name"), name)
        compose.onAllNodes(hasTestTag("tasks-row-$name"))[0].performTouchInput { longClick() }
    }

    @Test fun theOneTimeTabListsTasksByWhenWithCarriedFirstAndDoneLast() {
        launch()
        // Today's order, measured before anything scrolls: carried first, then today's, then done, as Figma 1.
        val order = listOf("Call the dentist", "Pay electricity bill", "Pick up dry cleaning", "Book flights").map { name ->
            waitHere(hasTestTag("tasks-row-$name"), name)
            compose.onAllNodes(hasTestTag("tasks-row-$name"))[0].fetchSemanticsNode().boundsInRoot.top
        }
        assertEquals(order.sorted(), order)
        waitFor(hasText("Planned for " + taskDay(today - 2)), "Call the dentist carried, saying its day")
        waitFor(hasText("Done 9:12 AM"), "Book flights done today")
        waitFor(hasTestTag("habits-section-Tomorrow"), "Tomorrow")
        waitFor(hasText("They stay here and don't show on Today until you give them a day."), "No date's note")
        waitFor(hasText("3 tasks"), "Archived counting 3")
        // No date never shows on Today (Figma 6).
        assertFalse(store.rules.isDue(task("Fix the bike light"), today))
    }

    @Test fun moveToTomorrowSaysSoAndUndoPutsItBack() {
        launch()
        menuFor("Pay electricity bill", "move", "tomorrow")
        waitFor(hasText("Moved to Tomorrow"), "the snackbar")
        assertEquals(today + 1, task("Pay electricity bill").dueDay)
        undo()
        waitUntil("the task back on today") { task("Pay electricity bill").dueDay == today }
    }

    @Test fun doTodayGivesANoDateTaskToday() {
        launch()
        menuFor("Fix the bike light", "today")
        waitFor(hasText("Fix the bike light moved to Today"), "the snackbar")
        assertEquals(today, task("Fix the bike light").dueDay)
        assertTrue(store.rules.isDue(task("Fix the bike light"), today))
    }

    @Test fun repeatingTasksSayWhenTheyComeAndSkipThisTimeIsUndone() {
        launch()
        tapTag("tasks-tab-1")
        waitFor(hasText("Waiting since " + taskDay(today - 2)), "Water plants waiting")
        waitFor(hasTestTag("habits-section-Every few months or longer"), "the longest group")
        menuFor("Water plants", "skip")
        waitFor(hasText("Water plants skipped this time"), "the snackbar")
        assertTrue(store.isSkipped(task("Water plants"), today - 2))
        undo()
        waitUntil("the skip undone") { !store.isSkipped(task("Water plants"), today - 2) }
    }

    @Test fun deleteAsksFirstAndDeletesOnlyOnceUndoHasGone() {
        launch()
        menuFor("Pick up dry cleaning", "delete")
        waitHere(hasText("Its history and notes are deleted too. To keep them, archive it instead."), "the question")
        here("delete-confirm")
        waitFor(hasText("Pick up dry cleaning deleted"), "the snackbar")
        // Still there until Undo has gone (D6): Undo keeps it.
        assertTrue(store.habits.any { it.name == "Pick up dry cleaning" })
        undo()
        waitFor(hasTestTag("tasks-row-Pick up dry cleaning"), "the row back")
        menuFor("Pick up dry cleaning", "delete")
        here("delete-confirm")
        waitUntil("the task gone once the snackbar has", timeout = 20_000) { store.habits.none { it.name == "Pick up dry cleaning" } }
    }

    @Test fun aLongPressSelectsAndTheBarMovesThemAll() {
        launch()
        longPress("Call the dentist")
        waitHere(hasText("1 selected"), "selection, not the task's page")
        assertFalse(has(hasTestTag("habit-details")))
        tapTag("tasks-row-Clean the fridge")
        waitHere(hasText("2 selected"), "two selected")
        tapTag("tasks-move")
        here("tasks-move-tomorrow")
        waitFor(hasText("2 tasks moved to Tomorrow"), "the snackbar")
        assertEquals(today + 1, task("Call the dentist").dueDay)
        assertEquals(today + 1, task("Clean the fridge").dueDay)
    }

    @Test fun searchGroupsTasksArchivedAndOffersANewTask() {
        launch()
        tapTag("tasks-search")
        compose.onNodeWithTag("habits-search-field").performTextInput("den")
        waitFor(hasText("Today · planned " + taskDay(today - 2).substringAfter(' ')), "Call the dentist with its day")
        waitFor(hasText("Dentist check-up"), "Dentist check-up")
        waitFor(hasTestTag("habits-section-Archived"), "Archived")
        waitFor(hasText("Find a new dentist"), "the archived one")
        compose.onNodeWithTag("habits-search-field").performTextInput("plumber")
        waitFor(hasText("No tasks called “denplumber”"), "no match")
        tapTag("tasks-search-new")
        waitFor(hasTestTag("name-field"), "the task form")
        waitFor(hasText("denplumber"), "its name filled in")
    }

    @Test fun completedTakesATaskBackAndUndoKeepsItDone() {
        launch()
        tapTag("tasks-more")
        here("tasks-completed")
        waitFor(hasText("Every task you finish, by the day you did it. To bring one back, use its ⋮ menu."), "Completed's note")
        tapTag("tasks-row-more-Send the parcel")
        here("completed-menu-not-done")
        waitFor(hasText("Send the parcel is back in Today"), "the snackbar")
        assertNull(store.doneEntry(task("Send the parcel")))
        undo()
        waitUntil("done again") { store.doneEntry(task("Send the parcel")) != null }
    }

    @Test fun archivedTasksRestoreWithUndo() {
        launch()
        tapTag("tasks-archived")
        waitFor(hasText("Archived tasks keep their history and stay off Today and Tasks. Restore one to bring it back."), "the note")
        tapTag("habits-row-more-Plan the garage sale")
        here("archived-menu-restore")
        waitFor(hasText("Plan the garage sale is back in Today"), "the snackbar")
        waitUntil("restored") { !task("Plan the garage sale").archived }
        undo()
        waitUntil("archived again") { task("Plan the garage sale").archived }
    }

    @Test fun aNewTaskWithNoDateStaysOffToday() {
        launch()
        tapTag("tasks-add")
        compose.onNodeWithTag("name-field").performTextInput("Mend the fence")
        tapTag("task-date")
        here("task-date-none")
        waitGone(hasTestTag("task-time"), "the Time row")
        waitFor(hasText("It shows on the Tasks page under No date, not on Today."), "the preview's note")
        tapTag("form-add")
        waitHere(hasTestTag("tasks-list"), "back on Tasks")
        waitUntil("saved") { store.habits.any { it.name == "Mend the fence" } }
        val t = task("Mend the fence")
        assertEquals(NO_DATE_DAY, t.dueDay)
        assertNull(t.dueMinute)
        assertFalse(store.rules.isDue(t, today))
        waitFor(hasTestTag("tasks-row-Mend the fence"), "under No date")
    }

    @Test fun theCoachMarkGoesForGood() {
        launch(coach = true)
        here("tasks-coach-ok")
        waitGone(hasTestTag("tasks-coach-ok"), "the coach mark")
        assertNotNull(store.setting("tasks.coach_seen"))
    }

    @Test fun theMenuCountsTasksStillOpenToday() {
        launch()
        // Call the dentist (carried), Pay electricity bill and Pick up dry cleaning: Book flights is done (Figma 10.1).
        scenario!!.onActivity { it.onBackPressedDispatcher.onBackPressed() }
        tapTag("menu-button")
        waitHere(hasTestTag("menu-tasks"), "the menu")
        val words = compose.onAllNodes(hasTestTag("menu-tasks"))[0].fetchSemanticsNode().config.getOrNull(SemanticsProperties.Text)?.map { it.text }
        assertEquals(listOf("Tasks", "3"), words)
    }
}
