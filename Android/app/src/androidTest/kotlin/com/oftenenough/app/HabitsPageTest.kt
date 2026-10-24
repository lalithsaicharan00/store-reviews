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
 * The Habits tab of **Habits & Tasks** (Figma 269:148, 23 Oct 2026), on the design's own habits (`demo habits`): the
 * period's cards, a card's ⋮ with Undo for Archive, Pause and Resume and Delete (deleted only once Undo has gone, D6),
 * the two tabs, the Archived row, the one search over habits and tasks, Archived habits' Restore, and the free plan's +
 * opening Add a 6th habit. Nothing is selected here (A68). Test launches only (D8) at 10:30 (T11); a failure says what
 * was on screen (T14).
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

    /** A habit's card, by the tag the page gives it. */
    private fun card(name: String) = hasTestTag("habits-card-" + name.trim().lowercase().replace(Regex("\\s+"), "-"))

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
    /** Taps something in a popup, a dialog or the snackbar where it is: scrolling the cards first would outlast it. */
    private fun here(tag: String) {
        waitHere(hasTestTag(tag), "tag $tag")
        compose.onAllNodes(hasTestTag(tag), useUnmergedTree = true)[0].performClick()
    }
    private fun undo() {
        waitHere(hasText("Undo"), "Undo")
        compose.onAllNodes(hasText("Undo"), useUnmergedTree = true)[0].performClick()
    }
    private fun tapText(text: String) = tap(hasText(text), "\"$text\"")
    /** A card's ⋮, then one of its items: waited for where the menu is (scrolling the list would close it). */
    private fun menuFor(name: String, item: String) {
        tapTag("habits-row-more-$name")
        waitHere(hasTestTag("habits-menu-$item"), "the menu's $item")
        compose.onAllNodes(hasTestTag("habits-menu-$item"), useUnmergedTree = true)[0].performClick()
    }
    private fun habit(name: String) = store.habits.first { it.name == name }

    @Test fun theTabsAndThePeriodAreThePagesOwn() {
        launch()
        waitFor(hasText("This week"), "the week's own name")
        waitFor(card("Water"), "Water's card")
        tapText("Month")
        waitFor(hasText("This month"), "the month")
        tapTag("habits-tasks-tab-1")
        waitFor(hasTestTag("tasks-tabs"), "One-time | Repeating on the Tasks tab")
        tapTag("habits-tasks-tab-0")
        waitFor(card("Water"), "Water's card again")
    }

    @Test fun archiveFromTheRowsMenuSaysSoAndUndoBringsItBack() {
        launch()
        menuFor("Water", "archive")
        waitHere(hasText("Water archived"), "the snackbar")
        assertTrue(habit("Water").archived)
        undo()
        waitUntil("Water back") { !habit("Water").archived }
        waitFor(hasText("3 habits"), "the Archived row counting 3 again")
    }

    @Test fun deleteAsksFirstAndDeletesOnlyOnceUndoHasGone() {
        launch()
        menuFor("Water", "delete")
        waitHere(hasText("Delete Water?"), "the question")
        here("delete-confirm")
        waitHere(hasText("Water deleted"), "the snackbar")
        assertTrue("kept while Undo shows", store.habits.any { it.name == "Water" })
        undo()
        waitFor(card("Water"), "Water back on the list")
        menuFor("Water", "delete")
        here("delete-confirm")
        waitGone(hasText("Water deleted"), "the snackbar", 20_000)
        waitUntil("Water deleted") { store.habits.none { it.name == "Water" } }
    }

    @Test fun pauseFromTheSheetMovesItToPausedAndUndoTakesItBack() {
        launch()
        val today = store.today()
        menuFor("Water", "pause")
        waitHere(hasTestTag("pause-sheet"), "the Pause sheet")
        here("pause-two-weeks")
        here("confirm-pause")
        waitHere(hasText("Water paused until", substring = true), "the snackbar")
        assertTrue(store.isPaused(habit("Water"), today))
        undo()
        waitUntil("Water not paused") { !store.isPaused(habit("Water"), today) }
    }

    @Test fun resumeTakesAPausedHabitBackToItsSection() {
        launch()
        val today = store.today()
        assertTrue(store.isPaused(habit("Meditate"), today))
        menuFor("Meditate", "resume")
        waitHere(hasText("Meditate resumed"), "the snackbar")
        assertFalse(store.isPaused(habit("Meditate"), today))
        waitGone(hasTestTag("habits-section-Paused"), "the Paused section")
    }

    @Test fun searchFindsArchivedToo_andNoMatchOffersANewHabit() {
        launch()
        tapTag("habits-search")
        compose.onNodeWithTag("habits-search-field", useUnmergedTree = true).performTextInput("wa")
        waitFor(hasTestTag("habits-row-Water plants"), "an archived match")
        waitFor(hasText("Archived " + com.oftenenough.app.data.DayWords.dayMonth(store.today() - 46)), "when it was archived")
        tapTag("habits-search-clear")
        compose.onNodeWithTag("habits-search-field", useUnmergedTree = true).performTextInput("yoga")
        waitFor(hasText("Nothing called “yoga”"), "no match")
        tapTag("habits-search-new")
        tapTag("new-build")
        tapTag("type-check")
        waitFor(hasTestTag("name-field"), "the form")
        waitFor(hasText("yoga"), "the name filled in")
    }

    /** Archived habits opens from the list's last row; the page's top bar has no ⋮ any more (A63). */
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
        waitHere(hasTestTag("archived-menu-restore"), "Restore")
        compose.onAllNodes(hasTestTag("archived-menu-restore"), useUnmergedTree = true)[0].performClick()
        waitHere(hasText("Gym restored"), "the snackbar")
        assertFalse(habit("Gym").archived)
        waitGone(hasTestTag("habits-row-Gym"), "Gym leaving the page")
    }

    @Test fun onTheFreePlanPlusOpensAddASixthHabitFirst() {
        launch(plus = false)
        tapTag("habits-add")
        waitFor(hasTestTag("sixth-habit"), "Add a 6th habit")
    }
}
