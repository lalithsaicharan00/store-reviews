package com.oftenenough.app

import android.content.Intent
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.semantics.SemanticsProperties
import androidx.compose.ui.semantics.getOrNull
import androidx.compose.ui.test.SemanticsMatcher
import androidx.compose.ui.test.click
import androidx.compose.ui.test.hasContentDescription
import androidx.compose.ui.test.hasTestTag
import androidx.compose.ui.test.hasClickAction
import androidx.compose.ui.test.isEnabled
import androidx.compose.ui.test.hasText
import androidx.compose.ui.test.isSelected
import androidx.compose.ui.test.junit4.createEmptyComposeRule
import androidx.compose.ui.test.onNodeWithTag
import androidx.compose.ui.test.performClick
import androidx.compose.ui.test.performScrollTo
import androidx.compose.ui.test.performScrollToNode
import androidx.compose.ui.test.performTextInput
import androidx.compose.ui.test.performTextReplacement
import androidx.compose.ui.test.performTouchInput
import androidx.test.core.app.ActivityScenario
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.app.TestLaunch
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.dayKey
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertTrue
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Habit details as Figma 1373:2 (19 Oct 2026, Current Work 139): the page opens on Progress with two tabs; the description
 * folds at two lines; History lists each day with its note, filters and searches notes, and Add asks for the day; the
 * record's See all streaks; paused, archived and type-changed habits; a calendar square opens its day; a past day's +1
 * says what it added with Undo; a note read from History; Started can't pass the first log. Test launches only (D8), at
 * 10:30 (T11); a failure says, on one line, what was on screen (T14).
 */
@OptIn(androidx.compose.ui.test.ExperimentalTestApi::class)
@RunWith(AndroidJUnit4::class)
class HabitDetailsTest {
    @get:Rule val compose = createEmptyComposeRule()
    private var scenario: ActivityScenario<MainActivity>? = null

    @After fun close() { scenario?.close() }

    private fun launch(demo: String = "today") {
        val intent = Intent(ApplicationProvider.getApplicationContext(), MainActivity::class.java)
            .putExtra(TestLaunch.UITEST, true).putExtra(TestLaunch.CLOCK_HOUR, 10).putExtra(TestLaunch.DEMO, demo)
        TestDevice.clear()
        scenario = ActivityScenario.launch(intent)
        waitFor(hasTestTag("row-Water"), "the demo on Today")
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
                for (list in listOf("today-list", "habit-details-list", "search-results", "all-milestones-list"))
                    if (has(hasTestTag(list))) runCatching { compose.onNodeWithTag(list).performScrollToNode(m) }
                has(m)
            }
        } catch (e: Throwable) { throw AssertionError("Waited for $what; on screen: ${screen()}") }
    }

    private fun waitGone(m: SemanticsMatcher, what: String, timeout: Long = 10_000) {
        try { compose.waitUntil(timeout) { !has(m) } } catch (e: Throwable) { throw AssertionError("Waited for $what to go; on screen: ${screen()}") }
    }

    private fun tap(m: SemanticsMatcher, what: String) {
        waitFor(m, what)
        compose.waitForIdle()
        runCatching { compose.onAllNodes(m, useUnmergedTree = true)[0].performScrollTo() }
        compose.waitForIdle()
        compose.onAllNodes(m, useUnmergedTree = true)[0].performClick()
        compose.waitForIdle()
    }

    private fun tapTag(tag: String) = tap(hasTestTag(tag), "tag $tag")
    private fun onMain(block: () -> Unit) = InstrumentationRegistry.getInstrumentation().runOnMainSync(block)
    private val store get() = AppGraph.store
    private fun habit(name: String): Habit = store.habits.first { it.name == name && !it.archived }

    /** Opens [name]'s page from its Today row and its Day details' identity. */
    private fun openPage(name: String) {
        tapTag("row-$name")
        tapTag("day-identity")
        waitFor(hasTestTag("habit-details"), "Habit details for $name")
    }

    // ------------------------------------------------------------------ 1 · The page and its header

    /**
     * Milestones (Figma 2475:75, 1735:4; the rule of 17 Oct 2026): Floss in the days demo has 29 in a row and 30 times in
     * total. The card shows the latest and the earlier ones, Next for each track; All milestones lists the tracks.
     */
    @Test fun milestonesShowTheLatestEarlierAndNext_andAllMilestonesListsEachTrack() {
        launch("days")
        openPage("Floss")
        waitFor(hasTestTag("habit-milestone-latest"), "the latest milestone")
        waitFor(hasTestTag("habit-milestone-shelf"), "the earlier ones")
        waitFor(hasTestTag("habit-milestone-next-inARow"), "Next in a row")
        waitFor(hasTestTag("habit-milestone-next-inTotal"), "Next in total")
        waitFor(hasTestTag("habit-milestone-next-anniversary"), "the next anniversary")
        waitFor(hasContentDescription("Next: 30 days in a row, 1 to go. Now 29.", substring = true), "the next in a row, spoken")
        tapTag("habit-milestones-see-all")
        waitFor(hasTestTag("all-milestones"), "All milestones")
        waitFor(hasText("Floss · ", substring = true), "the habit and how many it reached")
        for (track in listOf("In a row", "Times in total", "Anniversaries")) waitFor(hasText(track), "the track $track")
        waitFor(hasTestTag("habit-milestone-next-inARow"), "the next in a row")
        waitFor(hasTestTag("milestone-reached"), "a reached milestone with its medal")
        // A reached one opens its pop-up again (Figma's details pages, flow 4); Close returns to the list.
        tapTag("milestone-reached")
        waitFor(hasTestTag("landmark-popup"), "its pop-up again")
        tapTag("landmark-close")
        waitGone(hasTestTag("landmark-popup"), "the pop-up")
        // How milestones work ›, at the end (5.6.6): its page, and ← back to All milestones.
        tapTag("how-milestones-work")
        waitFor(hasTestTag("how-milestones"), "How milestones work")
        for (part in listOf("In a row", "In total", "Which ones get a pop-up")) waitFor(hasText(part), "the part $part")
        tapTag("how-milestones-back")
        waitFor(hasTestTag("all-milestones"), "back on All milestones")
        tapTag("milestones-back")
        waitFor(hasTestTag("habit-details"), "back on the page")
    }

    @Test fun thePageOpensOnProgressWithTwoTabsAndTheRecord() {
        launch()
        openPage("Water")
        waitFor(hasTestTag("habit-tab-progress").and(isSelected()), "Progress, selected")
        waitFor(hasTestTag("habit-tab-history"), "the History tab")
        if (has(hasText("Notes"))) throw AssertionError("Notes is part of History now; on screen: ${screen()}")
        waitFor(hasText("Overall record"), "the record")
        waitFor(hasText("8 glasses a day | Anytime"), "the goal and its time of day, without the name")
        tapTag("habit-see-all-streaks")
        waitFor(hasTestTag("streaks-page"), "the Streaks page")
        waitFor(hasText(" run", substring = true), "how many runs")
        tapTag("page-back")
        waitFor(hasTestTag("habit-details"), "back on the page")
    }

    @Test fun aLongDescriptionIsCutAtTwoLinesWithMoreAndLess() {
        launch()
        onMain {
            store.setDescription("Why: on the days I forget, I have a headache by 4 pm. How: a glass when I wake up, one with each meal, " +
                "one between meals, and the last before 8 pm so it doesn't wake me at night. A bottle on the desk helps.", habit("Water").id)
        }
        openPage("Water")
        waitFor(hasText("More"), "More under the cut description")
        tapTag("habit-description-more")
        waitFor(hasText("Less"), "Less once it's open")
        tapTag("habit-description-more")
        waitFor(hasText("More"), "More again")
    }

    // ------------------------------------------------------------------ 2 · History

    @Test fun historyShowsEachDaysNoteFiltersThemAndSearchesThem() {
        launch()
        val today = store.today()
        onMain {
            store.setNote("Felt thirsty after the run, drank two glasses before lunch.", habit("Water"), today - 1)
            store.setNote("Office bottle again. Two refills before 3 PM.", habit("Water"), today - 3)
        }
        openPage("Water")
        tapTag("habit-tab-history")
        waitFor(hasText("Felt thirsty after the run", substring = true), "yesterday's note under its day")
        tapTag("history-with-notes")
        waitFor(hasText("2 notes", substring = true), "the month counting its notes")
        waitGone(hasTestTag("habit-day-" + dayKey(today - 2)), "a day without a note")
        tapTag("history-all")
        waitFor(hasTestTag("habit-day-" + dayKey(today - 2)), "every day again")
        // Search: the days whose note has the words.
        tapTag("history-search")
        waitFor(hasTestTag("notes-search"), "the search field")
        waitFor(hasText("Search Water’s notes by any word."), "what it searches, before anything is typed")
        compose.onNodeWithTag("notes-search").performTextInput("bottle")
        waitFor(hasText("1 note"), "one note found")
        waitFor(hasTestTag("habit-day-" + dayKey(today - 3)), "the day of that note")
        compose.onNodeWithTag("notes-search").performTextReplacement("lemon")
        waitFor(hasText("No notes with “lemon”"), "nothing found, said plainly")
        waitFor(hasText("Search looks through this habit’s notes. To find a day, use Go to date."), "where to look instead")
        tapTag("search-back")
        waitFor(hasTestTag("history-search"), "History again")
    }

    @Test fun addAsksWhichDayThenOpensThatDay_andGoToDateStaysInHistory() {
        launch()
        openPage("Water")
        tapTag("habit-tab-history")
        tapTag("history-add")
        waitFor(hasText("Add to which day?"), "Add to which day?")
        // No day is chosen when it opens (A81): Open is off until one is picked.
        waitFor(hasText("Selected date"), "nothing chosen yet")
        if (compose.onAllNodes(hasTestTag("add-day-open").and(isEnabled()), useUnmergedTree = true).fetchSemanticsNodes().isNotEmpty())
            throw AssertionError("Open is on with no day chosen; on screen: ${screen()}")
        // Today is in the month it opens on; the day picked names the button.
        tap(hasText(java.time.LocalDate.ofEpochDay(store.today().toLong()).dayOfMonth.toString()).and(hasClickAction()), "today in the calendar")
        waitFor(hasText("Open " + com.oftenenough.app.data.pageDayDate(store.today())), "Open, naming the day")
        tapTag("add-day-open")
        waitFor(hasTestTag("day-details"), "that day's details")
        tapTag("day-close")
        waitGone(hasTestTag("day-details"), "Day details")
        tapTag("history-go-to-date")
        tapTag("date-ok")
        waitFor(hasTestTag("habit-day-" + dayKey(store.today() - 1)), "History at that day")
    }

    @Test fun aNewHabitSaysNothingHereYet() {
        launch()
        onMain { store.add(Habit(name = "Journal", symbol = "book.fill", color = com.oftenenough.app.data.HabitColor.BROWN, kind = HabitKind.Check)) }
        openPage("Journal")
        // Progress (Figma's New habit): No progress yet, then its first week.
        waitFor(hasText("No progress yet"), "No progress yet")
        waitFor(hasText("Your first week"), "its first week")
        tapTag("habit-tab-history")
        waitFor(hasText("Nothing here yet"), "Nothing here yet")
        waitFor(hasTestTag("history-add"), "Add, to log any day")
        if (has(hasTestTag("history-search"))) throw AssertionError("No search with nothing to search; on screen: ${screen()}")
    }

    @Test fun aNoteReadFromHistoryShowsItsHabitAndDay() {
        launch()
        val day = store.today() - 2
        onMain { store.setNote("Travel day, the flight ran late.", habit("Water"), day) }
        openPage("Water")
        tapTag("habit-tab-history")
        tapTag("habit-day-" + dayKey(day))
        waitFor(hasTestTag("day-details"), "that day")
        tapTag("day-edit-note")
        waitFor(hasTestTag("note-day"), "the note's date")
        waitFor(hasText("Water"), "the habit")
        waitFor(hasTestTag("note-delete"), "Delete note")
    }

    // ------------------------------------------------------------------ 3, 4 · Progress and fixing a past day

    @Test fun aTapOnTheWeekOpensThatDay_andAPastPlusOneSaysWhatItAdded() {
        launch()
        openPage("Water")
        val strip = hasTestTag("week-strip")
        waitFor(strip, "the week's squares")
        compose.onAllNodes(strip, useUnmergedTree = true)[0].performScrollTo()
        // The week's first day: a day before today at 10:30 on any weekday but the first.
        val first = store.rules.period(com.oftenenough.app.data.PeriodKind.WEEK, store.today()).first
        if (first == store.today()) return
        compose.onAllNodes(strip, useUnmergedTree = true)[0].performTouchInput { click(Offset(width / 14f, height / 2f)) }
        waitFor(hasTestTag("day-details"), "the first day of the week")
        val before = store.entries(habit("Water").id, first).size
        tapTag("day-add-step")
        waitFor(hasText("Added 1 glass to", substring = true), "what was added, and to which day")
        assertEquals(before + 1, store.entries(habit("Water").id, first).size)
        tap(hasText("Undo"), "Undo")
        compose.waitUntil(5_000) { store.entries(habit("Water").id, first).size == before }
    }

    @Test fun aQuitHabitShowsItsRunsAndSeeAllRuns() {
        launch()
        openPage("Smoking")
        waitFor(hasText("Quit since", substring = true), "Quit since …")
        waitFor(hasTestTag("habit-streak-best").and(hasContentDescription("Longest run", substring = true)), "the longest run")
        waitFor(hasTestTag("habit-quit-clean").and(hasContentDescription("Days with no slip", substring = true)), "the days with no slip")
        tapTag("habit-see-all-runs")
        waitFor(hasTestTag("streaks-page"), "Runs")
        waitFor(hasText("Runs"), "its title")
    }

    // ------------------------------------------------------------------ 5 · The start date

    @Test fun startedSaysWhatItMeansAndStopsAtTheFirstLog() {
        launch()
        openPage("Water")
        tapTag("habit-menu")
        tapTag("habit-menu-edit")
        waitFor(hasText("the first log", substring = true), "the line under Started")
        tapTag("starts-row")
        waitFor(hasText("Up to", substring = true), "the picker saying why it stops")
    }

    // ------------------------------------------------------------------ 6 · Other states

    @Test fun pausedAndArchivedSayWhatTheyMean() {
        launch()
        openPage("Water")
        val today = store.today()
        onMain { store.pause(habit("Water"), today, today + 6) }
        waitFor(hasText("Paused until", substring = true), "the paused card")
        waitFor(hasText("Off Today, no reminders. Paused days don’t count."), "what it means")
        tapTag("habit-paused-action")
        waitGone(hasTestTag("habit-paused"), "the paused card")
        // Archive never asks first: the page stays, says so with Undo, and the card shows.
        tapTag("habit-menu")
        tapTag("habit-menu-archive")
        waitFor(hasText("Water archived"), "the snackbar")
        assertTrue(habit("Water").archived)
        waitFor(hasText("Archived today"), "the archived card")
        waitFor(hasContentDescription("Streak when archived", substring = true), "the streak, as it was")
        tapTag("habit-tab-history")
        waitGone(hasTestTag("history-add"), "Add on an archived habit")
    }

    @Test fun afterATypeChangeEachWaterLinksToTheOther() {
        launch()
        openPage("Water")
        val old = habit("Water")
        val fresh = old.copy(id = com.oftenenough.app.data.newId(), kind = HabitKind.Duration, goal = 10.0, createdAt = System.currentTimeMillis())
        onMain { store.startOver(old, fresh, "Time it") }
        // This page is the old Water's: archived, with the way to the new one.
        waitFor(hasText("when Water changed to minutes", substring = true), "the old page's card")
        tapTag("habit-archived-action")
        waitFor(hasText("10 min a day | Anytime"), "the new Water's page")
        tapTag("habit-tab-history")
        waitFor(hasText("Water was counted in glasses until today", substring = true), "the new page's card")
        tapTag("habit-earlier-action")
        waitFor(hasText("Open the new Water"), "the earlier Water again")
        assertNotNull(store.replacedBy(old.id))
    }
}
