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
import app.habits.account.Answer
import app.habits.account.CloudDevice
import app.habits.account.CloudKind
import app.habits.account.CloudPlace
import app.habits.account.PlusProducts
import app.habits.account.SignIn
import app.habits.account.SignInWith
import app.habits.account.StandInAccountServer
import app.habits.account.StorePurchase
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.app.TestLaunch
import com.oftenenough.app.app.backup.StandInLink
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.runBlocking
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
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

    /** A Plus account made on another phone (the stand-in server), and where it says the habits live. */
    private fun plusAccount(with: SignInWith, email: String, place: CloudPlace?) = runBlocking(Dispatchers.Main) {
        val server = AppGraph.accounts.server as StandInAccountServer
        val made = server.create(SignIn(with, "stand-in", email, "Sam Kim"), StorePurchase(PlusProducts.PLUS, "stand-in-plus")) as Answer.Ok
        if (place != null) server.setCloud(made.value, place)
    }

    /** The Google account the stand-in Drive's chooser gives next. */
    private fun chooserGives(email: String) = onMain { (AppGraph.backup.link as StandInLink).nextAccount = email }

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
        for (t in listOf("back-google", "back-drive", "back-phone", "back-file")) waitFor(hasTestTag(t), t)
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

    @Test fun aGoogleAccountWithoutPlusSaysSoAndOffersTheOtherWays() {
        launch()
        tapTag("onboarding-returning")
        tapTag("back-google")
        waitFor(hasText("No account found."), "No account found")
        waitFor(hasTestTag("another-google"), "Another Google account")
        waitFor(hasTestTag("back-file"), "a backup file")
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

    // ------------------------------------------------------------------ Where the account says the habits live (D16, 138)

    @Test fun habitsInAnIphonesICloudAreMovedAcrossWithACode() {
        launch()
        plusAccount(SignInWith.GOOGLE, "sam@gmail.com", CloudPlace(CloudKind.ICLOUD, "icloud:_sam", CloudDevice.IPHONE))
        plusAccount(SignInWith.APPLE, "sam@privaterelay.appleid.com", CloudPlace(CloudKind.ICLOUD, "icloud:_sam", CloudDevice.IPAD))
        tapTag("onboarding-returning")
        // 2.3: signed in with Google.
        tapTag("back-google")
        waitFor(hasText("They’re on your iPhone."), "2.3 They're on your iPhone")
        for (t in listOf("Open the app on your iPhone", "Choose Move to a new phone", "Type its code on this phone")) waitFor(hasText(t), t)
        tapTag("enter-code")
        waitFor(hasText("From your old phone."), "the move code")
        // Back returns to the screen that offered the code, never further.
        tapTag("flow-back")
        waitFor(hasTestTag("on-your-iphone"), "2.3 again")
        tapTag("flow-back")
        // 3.3: signed in with Apple, the same screen.
        tapTag("back-apple")
        waitFor(hasTestTag("on-your-iphone"), "3.3 They're on your iPhone")
        // Start fresh asks first, and leaves the habits where they are.
        tapTag("start-fresh")
        waitFor(hasText("Your habits stay where they are, so you can bring them back later."), "Start fresh?")
        tapTag("start-fresh-dialog-confirm")
        waitFor(hasText("Your days and weeks."), "Your days and weeks")
    }

    @Test fun aDifferentGoogleAccountIsChosenAndCheckedBeforeAnythingIsRead() {
        launch()
        plusAccount(SignInWith.GOOGLE, "sam@gmail.com", CloudPlace(CloudKind.GOOGLE_DRIVE, StandInAccountServer.driveKey("work@gmail.com"), CloudDevice.ANDROID))
        tapTag("onboarding-returning")
        tapTag("back-google")
        waitFor(hasText("Your habits are in a different Google Drive account", substring = true), "2.5 Plus is back")
        assertNone(hasText("work@gmail.com", substring = true), "the other account named")
        // The wrong account: nothing is read from it, and 2.5 asks again.
        chooserGives("other@gmail.com")
        tapTag("choose-drive")
        assertNone(hasText("Looking for your habits"), "looking in the wrong Drive")
        waitFor(hasTestTag("plus-other-drive"), "2.5 again")
        assertNull("the wrong Drive is let go", AppGraph.backup.link.accountKey)
        // The right one: looked in at once.
        chooserGives("work@gmail.com")
        tapTag("choose-drive")
        waitFor(hasText("We didn’t find your habits in work@gmail.com’s Google Drive", substring = true), "the Drive on record, looked in")
    }

    @Test fun theSignInAccountsOwnDriveIsOpenedWithNoChooser() {
        launch()
        plusAccount(SignInWith.GOOGLE, "sam@gmail.com", CloudPlace(CloudKind.GOOGLE_DRIVE, StandInAccountServer.driveKey("sam@gmail.com"), CloudDevice.ANDROID))
        chooserGives("other@gmail.com") // a chooser would give another account: none is shown
        tapTag("onboarding-returning")
        tapTag("back-google")
        waitFor(hasText("We didn’t find your habits in sam@gmail.com’s Google Drive", substring = true), "Sam's own Drive")
    }

    @Test fun aPlusAccountRemembersTheGoogleDriveItBacksUpTo() {
        launch(onboarding = false, demo = "today")
        runBlocking(Dispatchers.Main) { AppGraph.accounts.create(SignIn(SignInWith.GOOGLE, "stand-in", "sam@gmail.com", "Sam Kim"), StorePurchase(PlusProducts.PLUS, "stand-in-plus")) }
        assertNull("nothing until a device has synced", AppGraph.accounts.account!!.cloud)
        chooserGives("sam@gmail.com")
        runBlocking(Dispatchers.Main) { AppGraph.backup.connectDrive() }
        compose.waitUntil(10_000) { AppGraph.accounts.account?.cloud != null }
        val cloud = AppGraph.accounts.account!!.cloud!!
        assertEquals(CloudPlace(CloudKind.GOOGLE_DRIVE, StandInAccountServer.driveKey("sam@gmail.com"), CloudDevice.ANDROID), cloud.place)
        assertTrue("Sam's own Google account", cloud.signInAccount)
        // Deleting the Drive copy: the account no longer points at it.
        runBlocking(Dispatchers.Main) { AppGraph.backup.deleteFromDrive() }
        compose.waitUntil(10_000) { AppGraph.accounts.account?.cloud == null }
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
