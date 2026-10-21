package com.oftenenough.app

import android.content.Intent
import androidx.compose.ui.semantics.SemanticsProperties
import androidx.compose.ui.semantics.getOrNull
import androidx.compose.ui.test.SemanticsMatcher
import androidx.compose.ui.test.hasTestTag
import androidx.compose.ui.test.hasText
import androidx.compose.ui.test.junit4.createEmptyComposeRule
import androidx.compose.ui.test.performClick
import androidx.compose.ui.test.performScrollTo
import androidx.compose.ui.test.performTextInput
import androidx.test.core.app.ActivityScenario
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.app.TestLaunch
import org.junit.After
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

/**
 * The welcome (Figma 1548:2), coming back (1549:2) and Backup & Sync (1461:2): an idea adds with its own details, Back
 * returns to the ideas and asks only after a change, every way back says what it found, and the move's screens never
 * leave someone stuck. The move itself, between two phones, is checked against the relay in `MoveLiveTest` and on two
 * emulators (Build Results); here the relay is a closed port, so the screens' failures are what's tested.
 */
@RunWith(AndroidJUnit4::class)
class OnboardingTest {
    @get:Rule val compose = createEmptyComposeRule()
    private var scenario: ActivityScenario<MainActivity>? = null

    @After fun close() { scenario?.close() }

    private fun launch(onboarding: Boolean = true, demo: String? = null) {
        val intent = Intent(ApplicationProvider.getApplicationContext(), MainActivity::class.java)
            .putExtra(TestLaunch.UITEST, true).putExtra(TestLaunch.CLOCK_HOUR, 10)
            // Nothing listens on port 9: the move can't reach a relay, whatever the network.
            .putExtra(TestLaunch.MOVE_SERVER, "http://127.0.0.1:9")
        if (onboarding) intent.putExtra(TestLaunch.ONBOARDING, true)
        if (demo != null) intent.putExtra(TestLaunch.DEMO, demo)
        scenario = ActivityScenario.launch(intent)
    }

    /** Every text and label on screen, on one line (T14). */
    private fun screen(): String = compose.onAllNodes(SemanticsMatcher("anything") { true }, useUnmergedTree = true).fetchSemanticsNodes()
        .mapNotNull { n ->
            (n.config.getOrNull(SemanticsProperties.Text)?.joinToString(" ") { it.text }
                ?: n.config.getOrNull(SemanticsProperties.ContentDescription)?.joinToString(" "))?.takeIf { it.isNotBlank() }
        }.distinct().joinToString(" | ").take(3000)

    private fun has(m: SemanticsMatcher) = compose.onAllNodes(m, useUnmergedTree = true).fetchSemanticsNodes().isNotEmpty()

    private fun waitFor(m: SemanticsMatcher, what: String, timeout: Long = 15_000) {
        try { compose.waitUntil(timeout) { has(m) } } catch (e: Throwable) { throw AssertionError("Waited for $what; on screen: ${screen()}") }
    }

    private fun tapTag(tag: String) {
        waitFor(hasTestTag(tag), "tag $tag")
        compose.onAllNodes(hasTestTag(tag), useUnmergedTree = true)[0].let { n ->
            runCatching { n.performScrollTo() }
            n.performClick()
        }
        compose.waitForIdle()
    }

    private fun assertNone(m: SemanticsMatcher, what: String) {
        compose.waitForIdle()
        Thread.sleep(500)
        if (has(m)) throw AssertionError("Didn't expect $what; on screen: ${screen()}")
    }

    private fun onMain(block: () -> Unit) = InstrumentationRegistry.getInstrumentation().runOnMainSync(block)

    private fun toTheIdeas() {
        tapTag("onboarding-new")
        repeat(4) { tapTag("onboarding-continue") }
        waitFor(hasText("Your first habit."), "the ideas")
    }

    // ------------------------------------------------------------------ the welcome (1548:2)

    @Test fun anIdeaAddsStraightAwayWithItsDetails() {
        launch()
        toTheIdeas()
        tapTag("idea-Drink water")
        waitFor(hasTestTag("name-field"), "the New Habit form")
        tapTag("form-add")
        waitFor(hasTestTag("row-Drink water"), "Drink water on Today")
    }

    @Test fun backFromAnUntouchedIdeaGoesBackToTheIdeasWithoutAsking() {
        launch()
        toTheIdeas()
        tapTag("idea-Exercise")
        waitFor(hasTestTag("name-field"), "the New Habit form")
        tapTag("form-back")
        assertNone(hasTestTag("discard"), "the discard question for an untouched idea")
        waitFor(hasText("Your first habit."), "the ideas again")
        // Back again, and again: the days, then the intro pages, never out of the app.
        tapTag("idea-Read")
        waitFor(hasTestTag("name-field"), "Read's form")
        tapTag("form-back")
        waitFor(hasText("Your first habit."), "the ideas after a second idea")
    }

    @Test fun backAfterAChangeAsksFirst() {
        launch()
        toTheIdeas()
        tapTag("idea-Floss")
        waitFor(hasTestTag("name-field"), "the New Habit form")
        compose.onAllNodes(hasTestTag("name-field"), useUnmergedTree = true)[0].performTextInput(" daily")
        tapTag("form-back")
        waitFor(hasTestTag("discard"), "the discard question after a change")
        tapTag("keep-editing")
        waitFor(hasTestTag("name-field"), "the form, kept")
        tapTag("form-back")
        tapTag("discard")
        waitFor(hasText("Your first habit."), "the ideas after discarding")
    }

    @Test fun createMyOwnAsksWhatKindThenBackReturns() {
        launch()
        toTheIdeas()
        tapTag("onboarding-continue")
        waitFor(hasText("What do you want to do?"), "the kind of habit")
        compose.onAllNodes(androidx.compose.ui.test.hasContentDescription("Close"), useUnmergedTree = true)[0].performClick()
        waitFor(hasText("Your first habit."), "the ideas")
        // The system Back does the same, never leaving the app.
        tapTag("onboarding-continue")
        waitFor(hasText("What do you want to do?"), "the kind of habit again")
        androidx.test.espresso.Espresso.pressBack()
        waitFor(hasText("Your first habit."), "the ideas after Back")
    }

    // ------------------------------------------------------------------ coming back (1549:2)

    @Test fun comingBackShowsEveryWayBack() {
        launch()
        tapTag("onboarding-returning")
        waitFor(hasText("Welcome back."), "Welcome back")
        for (t in listOf("back-drive", "back-phone", "back-file")) waitFor(hasTestTag(t), t)
        tapTag("flow-back")
        waitFor(hasTestTag("onboarding-returning"), "the welcome again")
    }

    @Test fun anEmptyGoogleDriveSaysSoAndStartFreshReachesAnEmptyToday() {
        launch()
        tapTag("onboarding-returning")
        tapTag("back-drive")
        waitFor(hasText("No habits found."), "No habits found")
        waitFor(hasTestTag("back-phone"), "the other ways back")
        tapTag("start-fresh")
        waitFor(hasText("Your days and weeks."), "Your days and weeks")
        tapTag("onboarding-continue")
        waitFor(hasText("No habits yet"), "an empty Today")
    }

    @Test fun theOldPhoneCodeTakesSixDigitsAndSaysWhenItCantConnect() {
        launch()
        tapTag("onboarding-returning")
        tapTag("back-phone")
        waitFor(hasText("From your old phone."), "From your old phone")
        tapTag("move-type")
        waitFor(hasText("Type the code."), "Type the code")
        // The sixth digit checks it by itself; with no relay, the move stops and says so, with Try again.
        compose.onAllNodes(hasTestTag("move-code-field"), useUnmergedTree = true)[0].performTextInput("123456")
        waitFor(hasText("The move stopped"), "The move stopped", timeout = 30_000)
        tapTag("move-stopped-main")
        waitFor(hasText("From your old phone."), "From your old phone again")
    }

    // ------------------------------------------------------------------ Backup & Sync (1461:2)

    @Test fun backupAndSyncSaysWhereTheHabitsAreAndOffersEveryWay() {
        launch(onboarding = false, demo = "today")
        tapTag("menu-button")
        tapTag("menu-backup")
        waitFor(hasTestTag("backup-page"), "Backup & Sync")
        waitFor(hasText("Not backed up"), "the state")
        for (t in listOf("drive-connect", "move-row", "restore-row", "save-file", "export-csv", "erase-all")) waitFor(hasTestTag(t), t)
        // Erase asks with two buttons only (D9); Cancel leaves everything.
        tapTag("erase-all")
        waitFor(hasText("Erase all your data?"), "the erase question")
        tapTag("erase-dialog-dismiss")
        assertNone(hasText("Erase all your data?"), "the erase question after Cancel")
        // Restore offers the three places.
        tapTag("restore-row")
        for (t in listOf("restore-drive", "restore-file", "restore-phone")) waitFor(hasTestTag(t), t)
        tapTag("page-back")
        waitFor(hasTestTag("backup-page"), "Backup & Sync again")
    }

    @Test fun moveToANewPhoneSaysWhenItCantConnect() {
        launch(onboarding = false, demo = "today")
        tapTag("menu-button")
        tapTag("menu-backup")
        tapTag("move-row")
        waitFor(hasText("Couldn’t connect"), "Couldn't connect", timeout = 30_000)
        waitFor(hasTestTag("move-offline-main"), "Try again")
    }
}
