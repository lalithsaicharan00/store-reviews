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
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

/**
 * The Habits page (Figma 2106:2, 19 Oct 2026), on the design's own habits (`demo habits`): a row's ⋮ with Undo for
 * Archive, Delete (deleted only once Undo has gone, D6), Pause and Resume; Duplicate right after its habit; selection and
 * Group; search's New habit; Show by group, remembered; Archived habits' Restore; the first-visit coach mark; the free
 * plan's + opening Add a 6th habit. Test launches only (D8) at 10:30 (T11); a failure says what was on screen (T14).
 */
@OptIn(androidx.compose.ui.test.ExperimentalTestApi::class)
@RunWith(AndroidJUnit4::class)
class HabitsPageTest {
    @get:Rule val compose = createEmptyComposeRule()
    private var scenario: ActivityScenario<MainActivity>? = null

    @After fun close() { scenario?.close() }

    private val store: HabitStore get() = AppGraph.store

    private fun launch(plus: Boolean = true, coach: Boolean = false) {
        val intent = Intent(ApplicationProvider.getApplicationContext(), MainActivity::class.java)
            .putExtra(TestLaunch.UITEST, true).putExtra(TestLaunch.CLOCK_HOUR, 10).putExtra(TestLaunch.DEMO, "habits")
            .putExtra(TestLaunch.PLUS, plus)
        TestDevice.clear()
        scenario = ActivityScenario.launch(intent)
        waitFor(hasTestTag("row-Stretch"), "the demo on Today")
        tapTag("menu-button")
        tapTag("menu-habits")
        waitHere(hasTestTag("habits-list"), "the Habits page")
        // The coach mark hangs under the first row: wait for it where it is, never scrolling the list away from it.
        waitHere(hasTestTag("habits-coach-ok"), "the coach mark")
        if (!coach) { compose.onAllNodes(hasTestTag("habits-coach-ok"), useUnmergedTree = true)[0].performClick(); waitGone(hasTestTag("habits-coach-ok"), "the coach mark") }
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
                for (list in listOf("today-list", "habits-list", "archived-list", "habits-search-results"))
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
    /** A row's ⋮, then one of its items: waited for where the menu is (scrolling the list would close it). */
    private fun menuFor(name: String, item: String) {
        tapTag("habits-row-more-$name")
        waitHere(hasTestTag("habits-menu-$item"), "the menu's $item")
        compose.onAllNodes(hasTestTag("habits-menu-$item"), useUnmergedTree = true)[0].performClick()
    }
    private fun habit(name: String) = store.habits.first { it.name == name }

    @Test fun archiveFromTheRowsMenuSaysSoAndUndoBringsItBack() {
        launch()
        menuFor("Water", "archive")
        waitFor(hasText("Water archived"), "the snackbar")
        assertTrue(habit("Water").archived)
        waitFor(hasText("4 habits"), "Archived counting 4")
        tapText("Undo")
        waitUntil("Water back") { !habit("Water").archived }
    }

    @Test fun deleteAsksFirstAndDeletesOnlyOnceUndoHasGone() {
        launch()
        menuFor("Water", "delete")
        waitFor(hasText("Delete Water?"), "the question")
        tapTag("delete-confirm")
        waitFor(hasText("Water deleted"), "the snackbar")
        assertTrue("kept while Undo shows", store.habits.any { it.name == "Water" })
        tapText("Undo")
        waitFor(hasTestTag("habits-row-Water"), "Water back on the list")
        menuFor("Water", "delete")
        tapTag("delete-confirm")
        waitGone(hasText("Water deleted"), "the snackbar", 20_000)
        waitUntil("Water deleted") { store.habits.none { it.name == "Water" } }
    }

    @Test fun pauseFromTheSheetMovesItToPausedAndUndoTakesItBack() {
        launch()
        val today = store.today()
        menuFor("Water", "pause")
        waitFor(hasTestTag("pause-sheet"), "the Pause sheet")
        tapTag("pause-two-weeks")
        tapTag("confirm-pause")
        waitFor(hasText("Water paused until", substring = true), "the snackbar")
        assertTrue(store.isPaused(habit("Water"), today))
        waitFor(hasText("Back on", substring = true), "Back on in Water's line")
        tapText("Undo")
        waitUntil("Water not paused") { !store.isPaused(habit("Water"), today) }
    }

    @Test fun resumeTakesAPausedHabitBackToItsSection() {
        launch()
        val today = store.today()
        assertTrue(store.isPaused(habit("Meditate"), today))
        menuFor("Meditate", "resume")
        waitFor(hasText("Meditate resumed"), "the snackbar")
        assertFalse(store.isPaused(habit("Meditate"), today))
        waitGone(hasTestTag("habits-section-Paused"), "the Paused section")
    }

    @Test fun duplicateFillsTheFormAndAddsTheCopyRightAfter() {
        launch()
        menuFor("Water", "duplicate")
        waitFor(hasText("Water (copy)"), "the form filled in")
        tapTag("form-add")
        waitFor(hasTestTag("habits-row-Water (copy)"), "the copy on Habits")
        val order = store.habits.map { it.name }
        assertEquals(order.indexOf("Water") + 1, order.indexOf("Water (copy)"))
        assertEquals("no history comes with it", 0, store.entries(habit("Water (copy)").id).size)
    }

    @Test fun selectingSeveralPutsThemInAGroup() {
        launch()
        compose.onNodeWithTag("habits-row-Walk", useUnmergedTree = true).performTouchInput { longClick() }
        waitFor(hasText("1 selected"), "one selected")
        tapTag("habits-row-Study")
        waitFor(hasText("2 selected"), "two selected")
        tapTag("habits-group")
        waitFor(hasText("Put 2 habits in a group"), "the group question")
        for (t in listOf("group-Mind", "group-move")) {
            waitHere(hasTestTag(t), t)
            compose.onAllNodes(hasTestTag(t), useUnmergedTree = true)[0].performClick()
        }
        waitUntil("both in Mind") { listOf("Walk", "Study").all { store.groupOf(habit(it).id)?.name == "Mind" } }
        waitGone(hasText("2 selected"), "the selection")
    }

    @Test fun searchFindsArchivedToo_andNoMatchOffersANewHabit() {
        launch()
        tapTag("habits-search")
        compose.onNodeWithTag("habits-search-field", useUnmergedTree = true).performTextInput("wa")
        waitFor(hasTestTag("habits-row-Water plants"), "an archived match")
        waitFor(hasText("Archived " + com.oftenenough.app.data.DayWords.dayMonth(store.today() - 46)), "when it was archived")
        tapTag("habits-search-clear")
        compose.onNodeWithTag("habits-search-field", useUnmergedTree = true).performTextInput("yoga")
        waitFor(hasText("No habits called “yoga”"), "no match")
        tapTag("habits-search-new")
        tapTag("new-build")
        tapTag("type-check")
        waitFor(hasTestTag("name-field"), "the form")
        waitFor(hasText("yoga"), "the name filled in")
    }

    @Test fun showByGroupIsRemembered() {
        launch()
        tapTag("habits-more")
        waitHere(hasTestTag("habits-show-by"), "Show by…")
        compose.onAllNodes(hasTestTag("habits-show-by"), useUnmergedTree = true)[0].performClick()
        waitHere(hasTestTag("show-by-group"), "the Show by dialog")
        compose.onAllNodes(hasTestTag("show-by-group"), useUnmergedTree = true)[0].performClick()
        waitFor(hasTestTag("habits-section-Health"), "Health")
        waitFor(hasTestTag("habits-section-No group"), "No group")
        assertEquals("group", store.setting("habits.show_by"))
    }

    /** The top ⋮'s way into Archived habits (Figma 2106:2, added 19 Oct 2026), beside the list's last row. */
    @Test fun theTopMenuOpensArchivedHabits() {
        launch()
        tapTag("habits-more")
        waitHere(hasTestTag("habits-menu-archived"), "Archived habits in the menu")
        compose.onAllNodes(hasTestTag("habits-menu-archived"), useUnmergedTree = true)[0].performClick()
        waitHere(hasTestTag("archived-list"), "Archived habits")
        waitFor(hasTestTag("habits-row-Gym"), "an archived habit")
    }

    @Test fun archivedHabitsRestoreOne() {
        launch()
        tapTag("habits-archived")
        waitFor(hasText("Archived habits"), "Archived habits")
        tapTag("habits-row-more-Gym")
        waitHere(hasTestTag("archived-menu-restore"), "Restore")
        compose.onAllNodes(hasTestTag("archived-menu-restore"), useUnmergedTree = true)[0].performClick()
        waitFor(hasText("Gym restored"), "the snackbar")
        assertFalse(habit("Gym").archived)
        waitGone(hasTestTag("habits-row-Gym"), "Gym leaving the page")
    }

    @Test fun theCoachMarkShowsOnceAndGotItPutsItAway() {
        launch(coach = true)
        waitHere(hasText("Select several at once"), "the coach mark")
        compose.onAllNodes(hasTestTag("habits-coach-ok"), useUnmergedTree = true)[0].performClick()
        waitGone(hasText("Select several at once"), "the coach mark")
        assertEquals("1", store.setting("habits.coach_seen"))
    }

    @Test fun onTheFreePlanPlusOpensAddASixthHabitFirst() {
        launch(plus = false)
        tapTag("habits-add")
        waitFor(hasTestTag("sixth-habit"), "Add a 6th habit")
    }
}
