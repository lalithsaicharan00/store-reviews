package com.oftenenough.app

import android.content.Intent
import androidx.compose.ui.semantics.SemanticsActions
import androidx.compose.ui.semantics.SemanticsProperties
import androidx.compose.ui.semantics.getOrNull
import androidx.compose.ui.test.SemanticsMatcher
import androidx.compose.ui.test.hasContentDescription
import androidx.compose.ui.test.hasTestTag
import androidx.compose.ui.test.hasText
import androidx.compose.ui.test.isEnabled
import androidx.compose.ui.test.junit4.createEmptyComposeRule
import androidx.compose.ui.test.performClick
import androidx.compose.ui.test.performCustomAccessibilityActionWithLabel
import androidx.compose.ui.test.performScrollToNode
import androidx.test.core.app.ActivityScenario
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.app.TestLaunch
import com.oftenenough.app.data.Habit
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

/**
 * The routine player and the timer as Figma 1328:2 (19 Oct 2026, Current Work 140), on the days demo's Anytime routine
 * (Water 4 of 8, Read 12:34 of 20, Take vitamins, Floss, Stretch breaks 2 of 3, Call family ticked today, Deep clean,
 * Gym, Tidy desk 2 of 3 steps, Pay the phone bill, Meditate, Push-ups, Savings). Test launches only (D8), at 10:30 (T11);
 * a failure says, on one line, what was on screen (T14).
 */
@OptIn(androidx.compose.ui.test.ExperimentalTestApi::class)
@RunWith(AndroidJUnit4::class)
class PlayerTest {
    @get:Rule val compose = createEmptyComposeRule()
    private var scenario: ActivityScenario<MainActivity>? = null

    @After fun close() { scenario?.close() }

    private fun launch() {
        val intent = Intent(ApplicationProvider.getApplicationContext(), MainActivity::class.java)
            .putExtra(TestLaunch.UITEST, true).putExtra(TestLaunch.CLOCK_HOUR, 10).putExtra(TestLaunch.DEMO, "days")
        TestDevice.clear()
        scenario = ActivityScenario.launch(intent)
        waitFor(hasTestTag("today-list"), "Today")
    }

    private fun screen(): String = compose.onAllNodes(SemanticsMatcher("anything") { true }, useUnmergedTree = true).fetchSemanticsNodes().mapNotNull { n ->
        (n.config.getOrNull(SemanticsProperties.Text)?.joinToString(" ") { it.text } ?: n.config.getOrNull(SemanticsProperties.ContentDescription)?.joinToString(" "))
            ?.takeIf { it.isNotBlank() }
    }.distinct().joinToString(" | ").take(3000)

    private fun has(m: SemanticsMatcher) = compose.onAllNodes(m, useUnmergedTree = true).fetchSemanticsNodes().isNotEmpty()

    private fun waitFor(m: SemanticsMatcher, what: String, timeout: Long = 15_000) {
        try {
            compose.waitUntil(timeout) {
                if (has(hasTestTag("today-list"))) runCatching { compose.onAllNodes(hasTestTag("today-list"))[0].performScrollToNode(m) }
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
        compose.onAllNodes(m, useUnmergedTree = true)[0].performClick()
        compose.waitForIdle()
    }

    private fun tapTag(tag: String) = tap(hasTestTag(tag), "tag $tag")
    private fun onMain(block: () -> Unit) = InstrumentationRegistry.getInstrumentation().runOnMainSync(block)
    private val store get() = AppGraph.store
    private fun habit(name: String): Habit = store.habits.first { it.name == name && !it.archived }

    /** True for a node whose centre is on the screen: the pager composes its neighbours just off it. */
    private fun onScreen(n: androidx.compose.ui.semantics.SemanticsNode): Boolean {
        val width = compose.onAllNodes(hasTestTag("routine-player"), useUnmergedTree = true).fetchSemanticsNodes().firstOrNull()?.size?.width ?: return false
        // A page the pager hasn't placed reports empty bounds at 0, 0.
        return n.boundsInRoot.width > 0f && n.boundsInRoot.center.x in 0f..width.toFloat()
    }

    /** The habit on screen: the page the pager rests on. */
    private fun current(): String = compose.onAllNodes(hasTestTag("player-name"), useUnmergedTree = true).fetchSemanticsNodes()
        .firstOrNull { onScreen(it) }?.config?.getOrNull(SemanticsProperties.Text)?.joinToString { it.text } ?: ""

    private fun position(): String = compose.onAllNodes(hasTestTag("routine-position"), useUnmergedTree = true).fetchSemanticsNodes()
        .firstOrNull()?.config?.getOrNull(SemanticsProperties.Text)?.joinToString { it.text } ?: ""

    private fun start() {
        tap(hasContentDescription("Start Anytime"), "Anytime's Start")
        waitFor(hasTestTag("routine-player"), "the player")
    }

    /** Moves on with › until [name] is on screen. */
    private fun goTo(name: String) {
        repeat(16) {
            compose.waitForIdle()
            if (current() == name) return
            tapTag("player-next")
            Thread.sleep(400)
        }
        throw AssertionError("Never reached $name; on screen: ${screen()}")
    }

    private fun mainLabel(): String = compose.onAllNodes(hasTestTag("player-main"), useUnmergedTree = true).fetchSemanticsNodes()
        .firstOrNull { onScreen(it) }?.let { n ->
            n.config.getOrNull(SemanticsProperties.ContentDescription)?.joinToString() ?: ""
        } ?: ""

    // ------------------------------------------------------------------ 1 · Starting, and the page

    @Test fun startOpensOnTheFirstUnfinishedHabitAndSaysWhatWasDoneEarlier() {
        launch()
        // Water's goal met earlier today: the routine starts at Read, 2 of N, and says so (Figma 1.2).
        onMain { store.addProgress(habit("Water"), 4.0, store.today()) }
        start()
        waitFor(hasText("1 done earlier today. Starting at Read."), "the message")
        assertEquals("Read", current())
        assertTrue("the position, 2 of …: ${position()}", position().startsWith("2 of "))
        // The title is one line, the routine's name (no "Habit 2 of …" under it).
        if (has(hasText("Habit 2 of", substring = true))) throw AssertionError("A subtitle under the title; on screen: ${screen()}")
    }

    @Test fun aTimerWaitsForStart_pausesAndResumes_andCloseLeavesItRunning() {
        launch()
        start()
        goTo("Read")
        // Arriving never starts the clock (Figma 4): Read has 12:34 from earlier, so it's paused, with Resume (4.2).
        assertTrue("Read isn't running", habit("Read").id !in store.timers)
        waitFor(hasText("Paused"), "Paused")
        waitFor(hasText("Resume"), "Resume")
        tapTag("player-main")
        waitFor(hasText("Pause"), "Pause (4.1)")
        assertTrue("Read runs", habit("Read").id in store.timers)
        tapTag("player-main")
        waitFor(hasText("Resume"), "Resume again")
        tapTag("player-main")
        waitFor(hasText("Pause"), "Pause")
        // ✕ with a timer running: Today, and the timer keeps running (8.4).
        tapTag("player-close")
        waitFor(hasTestTag("today-list"), "Today again")
        assertTrue("Read's timer still runs after ✕", habit("Read").id in store.timers)
    }

    @Test fun eachKindHasItsOwnMainButtonAndStatus() {
        launch()
        start()
        // An amount with a step: "+1" (U16).
        goTo("Water")
        assertEquals("Add 1 glass to Water", mainLabel())
        waitFor(hasText("+1"), "+1")
        // A single check: Not done yet → Mark done → Done, Saved with Undo and Add note, then Next (Figma 1, 2).
        goTo("Take vitamins")
        waitFor(hasText("Not done yet"), "Not done yet")
        tapTag("player-main")
        waitFor(hasText("Done"), "Done")
        waitFor(hasTestTag("player-undo"), "Undo")
        waitFor(hasTestTag("player-add-note"), "Add note")
        waitFor(hasText("Next"), "Next")
        // A check by the week, ticked today: ✓ Done for today and Next (2.4).
        goTo("Call family")
        waitFor(hasText("Done for today"), "Done for today")
        waitFor(hasText("Next"), "Next")
        // A checklist: its steps in the card, and a tick says nothing (5.2).
        goTo("Tidy desk")
        tapTag("player-step-2")
        compose.waitForIdle()
        if (has(hasTestTag("player-snackbar"))) throw AssertionError("A message after a step; on screen: ${screen()}")
        waitFor(hasText("Next"), "Next once every step is ticked")
        // A habit typed each time: "Log", the word alone (3.3).
        goTo("Savings")
        waitFor(hasText("Log"), "Log")
        if (has(hasText("Log amount"))) throw AssertionError("Log amount; on screen: ${screen()}")
    }

    // ------------------------------------------------------------------ 7 · ⋮ and Your routine

    @Test fun theMenuGoesToFirstUnfinished_changesOrderAndEnds() {
        launch()
        start()
        tapTag("player-more")
        waitFor(hasTestTag("player-menu-first"), "Go to first unfinished")
        waitFor(hasTestTag("player-menu-order"), "Change order")
        waitFor(hasTestTag("player-menu-end"), "End routine")
        // On the first unfinished already: it's there, and off.
        if (has(hasTestTag("player-menu-first") and isEnabled())) throw AssertionError("Go to first unfinished is on at the first; on screen: ${screen()}")
        // Change order opens Your routine in Edit: drag handles, and Move down moves Water for this routine only (7.2).
        tapTag("player-menu-order")
        waitFor(hasTestTag("routine-sheet"), "Your routine")
        waitFor(hasText("Drag to change the order for this routine. Today keeps its own order."), "the Edit footer")
        waitFor(hasTestTag("queue-drag-Water"), "Water's handle")
        val before = AppGraph.store.rules.cardMembers()["anytime"]
        compose.onAllNodes(hasTestTag("queue-Water"), useUnmergedTree = true)[0].performCustomAccessibilityActionWithLabel("Move down")
        compose.waitForIdle()
        assertEquals("Today's own order stays", before, AppGraph.store.rules.cardMembers()["anytime"])
        tapTag("routine-edit")
        waitFor(hasText("Jump to any habit, or change the order for this routine. Moving on never marks a habit done."), "out of Edit")
        androidx.test.espresso.Espresso.pressBack()
        waitGone(hasTestTag("routine-sheet"), "Your routine")
        // Water moved down: the player is still on Water, now 2 of N.
        assertEquals("Water", current())
        assertTrue("Water is second now: ${position()}", position().startsWith("2 of "))
        // Go to first unfinished: back to Read, first now.
        tapTag("player-more")
        tapTag("player-menu-first")
        compose.waitUntil(5_000) { current() == "Read" }
        // End routine: the end page with what's left; the bar keeps where the person was (8.3).
        tapTag("player-more")
        tapTag("player-menu-end")
        waitFor(hasText("End of the routine"), "the end page")
        waitFor(hasText("left for later. Your progress is saved.", substring = true), "what's left")
        waitFor(hasTestTag("player-return"), "Return to unfinished")
        assertTrue("the bar at 1 of …: ${position()}", position().startsWith("1 of "))
        tapTag("player-done")
        waitFor(hasTestTag("today-list"), "Today")
    }

    // ------------------------------------------------------------------ 10 · The Live Update

    @Test fun theLiveUpdatePausesResumesAndOpensTheRoutineAtItsHabit() {
        val device = androidx.test.uiautomator.UiDevice.getInstance(InstrumentationRegistry.getInstrumentation())
        device.executeShellCommand("pm grant com.oftenenough.app android.permission.POST_NOTIFICATIONS")
        com.oftenenough.app.app.reminders.TimerNotice.showInTests = true
        try {
            launch()
            start()
            goTo("Read")
            tapTag("player-main")
            waitFor(hasText("Pause"), "Pause")
            tapTag("player-close")
            waitFor(hasTestTag("today-list"), "Today")
            // A test launch connects no notification to the store (T22): show it as a change would.
            onMain { com.oftenenough.app.app.reminders.TimerNotice.sync(ApplicationProvider.getApplicationContext(), store) }
            device.pressHome()
            device.openNotification()
            val pause = device.wait(androidx.test.uiautomator.Until.findObject(androidx.test.uiautomator.By.text("Pause")), 10_000)
                ?: throw AssertionError("No Pause in the shade")
            pause.click()
            device.wait(androidx.test.uiautomator.Until.findObject(androidx.test.uiautomator.By.text("Read · Paused")), 10_000)
                ?: throw AssertionError("No paused notification")
            assertTrue("Read stopped from the notification", habit("Read").id !in store.timers)
            device.findObject(androidx.test.uiautomator.By.text("Resume"))?.click() ?: throw AssertionError("No Resume")
            compose.waitUntil(10_000) { habit("Read").id in store.timers }
            // A tap opens the routine it was started in, at Read (10.5).
            device.wait(androidx.test.uiautomator.Until.findObject(androidx.test.uiautomator.By.text("Read")), 10_000)?.click()
                ?: throw AssertionError("No Read notification to tap")
            waitFor(hasTestTag("routine-player"), "the routine")
            compose.waitUntil(5_000) { current() == "Read" }
        } finally {
            onMain {
                store.habits.firstOrNull { it.name == "Read" }?.let { if (it.id in store.timers) store.toggleTimer(it) }
                com.oftenenough.app.app.reminders.TimerNotice.sync(ApplicationProvider.getApplicationContext(), store)
            }
            com.oftenenough.app.app.reminders.TimerNotice.showInTests = false
        }
    }

    // ------------------------------------------------------------------ 1.4 · Another day

    @Test fun aRoutineOnAnotherDayNamesTheDayAndLogsToIt() {
        launch()
        tapTag("day-previous")
        start()
        val yesterday = store.today() - 1
        waitFor(hasText(com.oftenenough.app.data.pageDayDate(yesterday)), "the day on the chip")
        // Water, Read, Take vitamins and Floss were done yesterday: it starts at Stretch breaks and says so.
        waitFor(hasText("4 already done. Starting at Stretch breaks."), "the message")
        assertEquals("Stretch breaks", current())
        val todayBefore = store.rules.dayProgress(habit("Stretch breaks"), store.today())
        tapTag("player-main")
        compose.waitUntil(5_000) { store.rules.dayProgress(habit("Stretch breaks"), yesterday) == 1.0 }
        assertEquals("Today's count is untouched", todayBefore, store.rules.dayProgress(habit("Stretch breaks"), store.today()), 0.001)
    }
}
