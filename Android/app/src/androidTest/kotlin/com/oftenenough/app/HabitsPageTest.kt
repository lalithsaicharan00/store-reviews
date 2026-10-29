package com.oftenenough.app

import android.content.Intent
import androidx.compose.ui.semantics.SemanticsProperties
import androidx.compose.ui.semantics.getOrNull
import androidx.compose.ui.test.SemanticsMatcher
import androidx.compose.ui.test.hasTestTag
import androidx.compose.ui.test.hasText
import androidx.compose.ui.test.junit4.createEmptyComposeRule
import androidx.compose.ui.test.onNodeWithTag
import androidx.compose.ui.test.performClick
import androidx.compose.ui.test.performScrollTo
import androidx.compose.ui.test.performScrollToNode
import androidx.compose.ui.test.performTextInput
import androidx.test.core.app.ActivityScenario
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.app.TestLaunch
import com.oftenenough.app.data.HabitStore
import org.junit.After
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Habits & Tasks' Habits tab (5.5.1, Figma 986:150825; A54, A55), on the design's own habits (`demo habits`): a card's
 * ⋮ with Undo for Archive, Delete (asked first, deleted only once Undo has gone, D6), Pause and Resume; Week · Month ·
 * Year and the period's ‹ with Back to this week; search's archived matches and New habit; the Archived row and Archived
 * habits' Restore; the free plan's + opening Add a 6th habit. Test launches only (D8) at 10:30 (T11); a failure says
 * what was on screen (T14).
 */
@OptIn(androidx.compose.ui.test.ExperimentalTestApi::class)
@RunWith(AndroidJUnit4::class)
class HabitsPageTest {
    @get:Rule val compose = createEmptyComposeRule()
    private var scenario: ActivityScenario<MainActivity>? = null

    @After fun close() { scenario?.close() }

    private val store: HabitStore get() = AppGraph.store

    private fun launch(plus: Boolean = true) {
        val intent = Intent(ApplicationProvider.getApplicationContext(), MainActivity::class.java)
            .putExtra(TestLaunch.UITEST, true).putExtra(TestLaunch.CLOCK_HOUR, 10).putExtra(TestLaunch.DEMO, "habits")
            .putExtra(TestLaunch.PLUS, plus)
        TestDevice.clear()
        scenario = ActivityScenario.launch(intent)
        waitFor(hasTestTag("row-Stretch"), "the demo on Today")
        tapTag("menu-button")
        tapTag("menu-habits")
        waitHere(hasTestTag("habits-list"), "the Habits tab")
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
    /** Taps what's on screen now, never scrolling a list (a popup closes when the list behind it moves). */
    private fun here(tag: String) {
        waitHere(hasTestTag(tag), tag)
        compose.onAllNodes(hasTestTag(tag), useUnmergedTree = true)[0].performClick()
    }
    /** A card's ⋮, then one of its items. */
    private fun menuFor(name: String, item: String) {
        tapTag("habits-row-more-$name")
        here("habits-menu-$item")
    }
    private fun habit(name: String) = store.habits.first { it.name == name }

    @Test fun archiveFromTheCardsMenuSaysSoAndUndoBringsItBack() {
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
        waitFor(hasTestTag("habits-row-Water"), "Water's card back")
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
        waitFor(hasTestTag("habits-section-Paused"), "the Paused section")
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

    /** Week · Month · Year, and ‹ to an earlier period with "Back to this …" to come back (Figma's Another week). */
    @Test fun anEarlierPeriodOffersTheWayBack() {
        launch()
        waitHere(hasTestTag("habits-period"), "the period")
        tapTag("habits-previous")
        waitHere(hasText("Back to this week"), "Back to this week")
        tapText("Back to this week")
        waitGone(hasText("Back to this week"), "Back to this week")
        tapTag("habits-range-1")
        waitHere(hasText("This month"), "the month")
        tapTag("habits-range-0")
        waitHere(hasText("This week"), "the week again")
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

    @Test fun theArchivedRowOpensArchivedHabits() {
        launch()
        tapTag("habits-archived")
        waitHere(hasTestTag("archived-list"), "Archived habits")
        waitFor(hasTestTag("habits-row-Gym"), "an archived habit")
    }

    @Test fun archivedHabitsRestoreOne() {
        launch()
        tapTag("habits-archived")
        waitFor(hasText("Archived habits"), "Archived habits")
        tapTag("habits-row-more-Gym")
        here("archived-menu-restore")
        waitFor(hasText("Gym restored"), "the snackbar")
        assertFalse(habit("Gym").archived)
        waitGone(hasTestTag("habits-row-Gym"), "Gym leaving the page")
        // Undo archives it again (Figma's Restored).
        tapText("Undo")
        waitUntil("Gym archived again") { habit("Gym").archived }
    }

    @Test fun onTheFreePlanPlusOpensAddASixthHabitFirst() {
        launch(plus = false)
        tapTag("habits-add")
        waitFor(hasTestTag("sixth-habit"), "Add a 6th habit")
    }
}
