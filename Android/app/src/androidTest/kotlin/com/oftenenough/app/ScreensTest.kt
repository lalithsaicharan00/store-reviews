package com.oftenenough.app

import android.content.Intent
import androidx.compose.ui.semantics.SemanticsProperties
import androidx.compose.ui.semantics.getOrNull
import androidx.compose.ui.test.SemanticsMatcher
import androidx.compose.ui.test.hasContentDescription
import androidx.compose.ui.test.hasTestTag
import androidx.compose.ui.test.hasText
import androidx.compose.ui.test.junit4.createEmptyComposeRule
import androidx.compose.ui.test.longClick
import androidx.compose.ui.test.onNodeWithTag
import androidx.compose.ui.test.performClick
import androidx.compose.ui.test.performCustomAccessibilityActionWithLabel
import androidx.compose.ui.test.isSelected
import androidx.compose.ui.test.performScrollTo
import androidx.compose.ui.test.performScrollToNode
import androidx.compose.ui.test.performTextInput
import androidx.compose.ui.test.performTouchInput
import androidx.test.core.app.ActivityScenario
import androidx.test.core.app.ApplicationProvider
import androidx.test.espresso.Espresso
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.app.TestLaunch
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Checkpoint 2's screens on the emulator: Habit details, Progress, the routine player, Pause, the Habits list, the
 * Filter and groups, Arrange your day, Help, Plus without buying for real, and App lock. Every launch is a test launch
 * (D8) at 10:30 (T11); a failure says, on one line, what was on screen (T14).
 */
@OptIn(androidx.compose.ui.test.ExperimentalTestApi::class)
@RunWith(AndroidJUnit4::class)
class ScreensTest {
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

    /** The real back key. It goes to the focused window, so a failure names the window that had the focus (T14). */
    private fun back() {
        try { Espresso.pressBack() } catch (e: Throwable) {
            throw AssertionError("Back didn't reach the app (${e.javaClass.simpleName}); ${TestDevice.state()}", e)
        }
    }

    private fun screen(): String = compose.onAllNodes(SemanticsMatcher("anything") { true }, useUnmergedTree = true).fetchSemanticsNodes().mapNotNull { n ->
        (n.config.getOrNull(SemanticsProperties.Text)?.joinToString(" ") { it.text } ?: n.config.getOrNull(SemanticsProperties.ContentDescription)?.joinToString(" "))
            ?.takeIf { it.isNotBlank() }
    }.distinct().joinToString(" | ").take(3000)

    private fun has(m: SemanticsMatcher) = compose.onAllNodes(m, useUnmergedTree = true).fetchSemanticsNodes().isNotEmpty()

    /** Waits for [m], scrolling a list that may hold it (a lazy row past the edge isn't composed). */
    private fun waitFor(m: SemanticsMatcher, what: String, timeout: Long = 15_000) {
        try {
            compose.waitUntil(timeout) {
                for (list in listOf("today-list", "habits-list", "habit-details-list"))
                    if (has(hasTestTag(list))) runCatching { compose.onNodeWithTag(list).performScrollToNode(m) }
                has(m)
            }
        } catch (e: Throwable) { throw AssertionError("Waited for $what; on screen: ${screen()}") }
    }

    private fun waitGone(m: SemanticsMatcher, what: String, timeout: Long = 15_000) {
        try { compose.waitUntil(timeout) { !has(m) } } catch (e: Throwable) { throw AssertionError("Waited for $what to go; on screen: ${screen()}") }
    }

    private fun tap(m: SemanticsMatcher, what: String) {
        waitFor(m, what)
        compose.waitForIdle()
        // A row below the fold of a scrolling page is in the tree but takes no touch: bring it on screen first.
        runCatching { compose.onAllNodes(m, useUnmergedTree = true)[0].performScrollTo() }
        compose.waitForIdle()
        compose.onAllNodes(m, useUnmergedTree = true)[0].performClick()
    }

    private fun tapTag(tag: String) = tap(hasTestTag(tag), "tag $tag")
    private fun tapText(text: String) = tap(hasText(text), "\"$text\"")
    private fun menu(item: String) { tapTag("menu-button"); tapTag("menu-$item") }
    private fun onMain(block: () -> Unit) = InstrumentationRegistry.getInstrumentation().runOnMainSync(block)

    @Test fun habitDetailsOpensFromDayDetailsWithItsTabs() {
        launch()
        tapTag("row-Read")
        tapTag("day-identity")
        waitFor(hasTestTag("habit-details"), "Habit details")
        // It opens on Progress; History is the other tab (Figma 1373:2, 1.1).
        waitFor(hasText("Overall record"), "the Progress tab's record")
        tapTag("habit-tab-history")
        waitGone(hasText("Overall record"), "the record")
        waitFor(hasTestTag("history-search"), "History's Search notes")
    }

    @Test fun aLongPressOnARowOpensItsMenu() {
        launch()
        compose.onNodeWithTag("row-Water", useUnmergedTree = true).performTouchInput { longClick() }
        // Figma 1.4: Edit habit, Arrange…, Pause…, Add note, Skip today.
        waitFor(hasText("Edit habit"), "the row's menu")
        waitFor(hasText("Arrange…"), "Arrange…")
        tapText("Pause…")
        waitFor(hasText("Pause Water"), "the Pause page")
    }

    @Test fun theIconsShortcutStartsTheNextRoutine() {
        launch()
        // At 10:30 the time of day that is now is Morning, with two habits left.
        val next = com.oftenenough.app.ui.nextRoutine(AppGraph.store)
        assertEquals("morning", next?.first)
        onMain { AppGraph.widgetRoute = "routine|-1" }
        waitFor(hasText("1 of ${next!!.second.size}"), "the player on Morning")
    }

    @Test fun theIconsShortcutOpensNewHabit() {
        launch()
        onMain { AppGraph.widgetRoute = "new|-1" }
        waitFor(hasText("What do you want to do?"), "New")
        // Its three choices, each with its line (5.7.1, Figma 1061:2016).
        waitFor(hasText("A habit you want to start or keep doing."), "Build or maintain")
        waitFor(hasText("A habit you want to stop or do less."), "Quit or cut down")
        waitFor(hasText("Something to get done, once or on repeat."), "Add a task")
    }

    /** Keep reminders coming (5.8.1, Figma 804:192; A40, A70): one Permissions list, this phone's steps, the footer. */
    @Test fun keepRemindersComingListsThePermissions() {
        launch()
        menu("settings")
        tapTag("settings-reminders")
        waitFor(hasText("Keep reminders coming"), "the page")
        waitFor(hasTestTag("keep-reminders-lead"), "its lead line")
        waitFor(hasText("Permissions"), "Permissions")
        waitFor(hasTestTag("check-notifications"), "Allow notifications")
        waitFor(hasTestTag("check-exact"), "Allow alarms & reminders")
        waitFor(hasText("These change only Often Enough. Other apps keep saving battery."), "the footer")
    }

    /** Times of day (5.8.4, Figma 1176:356264): a deleted time of day comes back with its habits on Undo. */
    @Test fun deletingATimeOfDayCanBeUndone() {
        launch()
        menu("settings")
        tapTag("settings-times-of-day")
        waitFor(hasText("Morning, Afternoon, Evening, or your own, like Before work. Each one ends when the next one starts."), "the footer")
        val store = AppGraph.store
        val morning = store.sections.first { it.name == "Morning" }
        val inMorning = store.habits.filter { morning.id in it.parts }.map { it.id to it.parts }
        tapTag("section-Morning")
        tapTag("section-delete")
        waitFor(hasText("Delete Morning?"), "the question")
        tapTag("section-delete-confirm")
        waitFor(hasText("Morning deleted"), "the snackbar")
        compose.waitUntil(15_000) { store.sections.none { it.id == morning.id } }
        tapText("Undo")
        compose.waitUntil(15_000) { store.sections.any { it.id == morning.id } && inMorning.all { (id, parts) -> store.habit(id)?.parts == parts } }
        waitFor(hasTestTag("section-Morning"), "Morning back on Times of day")
    }

    @Test fun progressShowsTheWeek() {
        launch()
        menu("progress")
        waitFor(hasText("This week"), "this week on Progress")
        tapText("Month")
        waitFor(hasText("This month"), "this month")
    }

    @Test fun aRoutineStartsAtItsFirstHabitAndCloses() {
        launch()
        tap(hasContentDescription("Start Morning"), "Morning's Start")
        // The whole routine, in Today's order; it opens on the first unfinished habit (Figma 1.2).
        waitFor(hasTestTag("routine-player"), "the player")
        val morning = com.oftenenough.app.ui.routineHabits(AppGraph.store, "morning", AppGraph.store.today())
        waitFor(hasText(" of ${morning.size}", substring = true), "the player's position")
        back()
        waitFor(hasTestTag("today-list"), "Today again")
    }

    @Test fun pausingAHabitTakesItOffTodayIntoPaused() {
        launch()
        tapTag("row-Water")
        tapTag("day-more")
        tapText("Pause…")
        waitFor(hasText("Pause Water"), "the Pause page")
        tapTag("pause-two-weeks")
        tapTag("confirm-pause")
        waitFor(hasText("Paused"), "the Paused card")
        val water = AppGraph.store.habits.first { it.name == "Water" }
        assertTrue("Water is paused today", AppGraph.store.isPaused(water, AppGraph.store.today()))
    }

    /** Habits & Tasks (5.5.1): a card's ⋮ archives it, with no question (A54); nothing selects several (A55). */
    @Test fun aHabitsCardArchivesFromItsMenu() {
        launch()
        menu("habits")
        tapTag("habits-row-more-Water")
        // The menu is a popup: wait for it where it is, never scrolling the list away from it.
        compose.waitUntil(15_000) { has(hasTestTag("habits-menu-archive")) }
        compose.onAllNodes(hasTestTag("habits-menu-archive"), useUnmergedTree = true)[0].performClick()
        waitFor(hasText("Water archived"), "the snackbar")
        waitFor(hasTestTag("habits-archived"), "the Archived row")
        assertTrue("Water archived", AppGraph.store.habits.first { it.name == "Water" }.archived)
    }

    @Test fun arrangingMovesAHabitAndTodayFollows() {
        launch()
        tap(hasContentDescription("Arrange your day"), "Edit")
        waitFor(hasTestTag("arrange-row-Water"), "Water in Arrange")
        compose.onNodeWithTag("arrange-row-Water").performCustomAccessibilityActionWithLabel("Move up")
        compose.waitForIdle()
        val anytime = AppGraph.store.rules.cardMembers()["anytime"]!!.mapNotNull { AppGraph.store.habit(it)?.name }
        assertEquals("Anytime's order after Move up; on screen: ${screen()}", listOf("Read", "Water", "Call family"), anytime.filter { it in setOf("Read", "Water", "Call family") })
    }

    @Test fun plusBuysWithTheStandInStore() {
        launch()
        menu("plus")
        waitFor(hasText("free habits used", substring = true), "the free habits line")
        tapTag("plus-see")
        tapTag("plus-buy")
        waitFor(hasText("Plus is yours."), "Plus is yours.")
        assertTrue("the store's free limit is lifted", AppGraph.store.isPlus)
    }

    @Test fun appLockWithAPasscodeLocksAndOpens() {
        launch()
        menu("privacy")
        tapTag("privacy-app-lock")
        tapTag("app-lock-switch")
        tapTag("setup-passcode")
        tapTag("setup-continue")
        repeat(6) { tapTag("key-4") }
        waitFor(hasText("Confirm the app passcode"), "Confirm")
        repeat(6) { tapTag("key-4") }
        waitFor(hasTestTag("app-lock-switch"), "App lock, on")
        assertTrue("App lock is on", AppGraph.lock.isOn)
        onMain { AppGraph.lock.phoneLocked() }
        waitFor(hasTestTag("lock-screen"), "the lock screen")
        repeat(6) { tapTag("key-1") }
        waitFor(hasText("That's not your app passcode."), "a wrong code said")
        repeat(6) { tapTag("key-4") }
        waitGone(hasTestTag("lock-screen"), "the lock screen")
    }
}
