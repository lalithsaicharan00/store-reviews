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
import androidx.test.core.app.ActivityScenario
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.app.TestLaunch
import com.oftenenough.app.app.backup.StandInLink
import org.junit.After
import org.junit.Assert.assertTrue
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

/**
 * **The first run, the restore flow and the menu** — the new Figma file's onboarding page
 * (`sJptV3HAKYauEIGUxYS3qs`, `1:5`), 22 October 2026.
 *
 * There is no onboarding to test any more: the app opens on Today. What these check is that someone new lands on
 * "No habits yet" with the two things worth offering, that **Restore from a backup** shows the two ways back and no
 * others, that the Google Drive way says plainly when that account holds nothing, and that the menu is the six rows
 * the design draws. The Plus gate on a restore is checked in `DataSafetyTest`, where the data is.
 */
@RunWith(AndroidJUnit4::class)
class FirstRunTest {
    @get:Rule val compose = createEmptyComposeRule()
    private var scenario: ActivityScenario<MainActivity>? = null

    @After fun close() { scenario?.close() }

    private fun launch(demo: String? = null) {
        val intent = Intent(ApplicationProvider.getApplicationContext(), MainActivity::class.java)
            .putExtra(TestLaunch.UITEST, true).putExtra(TestLaunch.CLOCK_HOUR, 10)
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

    /** The Google account the stand-in Drive's chooser gives next. */
    private fun chooserGives(email: String) = onMain { (AppGraph.backup.link as StandInLink).nextAccount = email }

    // ------------------------------------------------------------------ The first run (36:32)

    @Test fun theAppOpensStraightOnTodayWithNoOnboarding() {
        launch()
        waitFor(hasText("No habits yet"), "an empty Today")
        waitFor(hasText("Add something you’d like\nto do often enough."), "the lead line")
        waitFor(hasTestTag("new-habit"), "+ in the top bar")
        waitFor(hasTestTag("menu-button"), "the menu button")
        // Nothing to arrange or filter before there is a habit (Figma 36:32: only menu and add).
        assertNone(hasTestTag("arrange-button"), "the arrange button on an empty Today")
        assertNone(hasTestTag("filter-button"), "the filter button on an empty Today")
    }

    @Test fun theEmptyTodayOffersANewHabitAndARestore() {
        launch()
        waitFor(hasText("New habit"), "New habit")
        waitFor(hasText("Restore from a backup"), "Restore from a backup")
        tapTag("new-habit")
        waitFor(hasText("What do you want to do?"), "the habit form's first question")
    }

    // ------------------------------------------------------------------ Restore from a backup (39:1590)

    @Test fun restoreOffersGoogleDriveAndAFileAndNothingElse() {
        launch()
        waitFor(hasText("Restore from a backup"), "the empty Today")
        compose.onAllNodes(hasText("Restore from a backup"), useUnmergedTree = true)[0].performClick()
        waitFor(hasText("Restore from a backup."), "the restore question")
        waitFor(hasText("Choose where your backup is."), "its lead")
        waitFor(hasTestTag("restore-drive"), "the Google Drive way")
        waitFor(hasTestTag("restore-file"), "the backup file way")
        // The move code went with the server: there is no third way (22 Oct 2026).
        assertNone(hasText("Your old phone"), "the old-phone way")
        tapTag("flow-back")
        waitFor(hasText("No habits yet"), "Today again")
    }

    @Test fun aGoogleDriveWithNoBackupSaysSoAndStillOffersAFile() {
        launch()
        chooserGives("sam@gmail.com")
        compose.onAllNodes(hasText("Restore from a backup"), useUnmergedTree = true)[0].performClick()
        waitFor(hasTestTag("restore-drive"), "the Google Drive way")
        tapTag("restore-drive")
        waitFor(hasText("No backup found."), "No backup found")
        waitFor(hasTestTag("restore-file"), "a backup file, still offered")
        waitFor(hasTestTag("no-backup-another"), "Try another Google account")
    }

    // ------------------------------------------------------------------ The menu (12:5259)

    @Test fun theMenuIsTheSixRowsTheDesignDraws() {
        launch(demo = "today")
        tapTag("menu-button")
        waitFor(hasTestTag("menu-drawer"), "the drawer")
        for (tag in listOf("menu-today", "menu-habits", "menu-plus", "menu-settings", "menu-contact", "menu-feedback")) {
            waitFor(hasTestTag(tag), tag)
        }
        waitFor(hasText("Often Enough"), "the app's name")
        waitFor(hasText("Habits & Tasks"), "Habits & Tasks")
        // Everything the old menu listed separately is inside Settings now.
        assertNone(hasTestTag("menu-progress"), "a Progress row")
        assertNone(hasTestTag("menu-backup"), "a Backup & Sync row")
        assertNone(hasTestTag("menu-about"), "an About row")
    }

    /** Settings (5.8.3, Figma 1173:547): one page, five sections, every row with its value. */
    @Test fun settingsHasItsFiveSections() {
        launch(demo = "today")
        tapTag("menu-button")
        tapTag("menu-settings")
        waitFor(hasTestTag("settings-page"), "Settings")
        for (text in listOf("Backup", "Your day", "Reminders", "General", "About", "Backup & Sync", "Times of day", "New day starts at",
            "Week starts on", "Keep reminders coming", "Theme", "System default", "Vibration", "A light buzz as you log", "Sound when done",
            "Plays when a goal is met", "Privacy policy", "Opens in your browser", "Open-source licences", "The libraries we use", "Version")) {
            waitFor(hasText(text), text)
        }
        tapTag("settings-backup-and-sync")
        waitFor(hasTestTag("restore-row"), "Backup & Sync's restore row")
        // Backup & Sync reaches the same restore flow as the empty Today.
        tapTag("restore-row")
        waitFor(hasText("Choose where your backup is."), "the restore question")
    }

    @Test fun theMenuOpensHabitsAndTasks() {
        launch(demo = "today")
        tapTag("menu-button")
        tapTag("menu-habits")
        waitFor(hasTestTag("habits-add"), "the Habits & Tasks page")
    }

    // ------------------------------------------------------------------ The backup that was deleted (A39)

    /**
     * **Today says the Google Drive backup was deleted, and Back up again sends everything from the card** (A39).
     * The person watches it happen where they tapped: the card turns into "Backing up to Google Drive…" with a line
     * that fills, then says "Backed up", then folds away by itself. Nothing is sent until they tap it.
     */
    @Test fun theRemovedBackupNoticeSendsEverythingFromTheCard() {
        launch(demo = "today")
        waitFor(hasText("Today"), "Today")
        kotlinx.coroutines.runBlocking {
            AppGraph.store.flush()
            assertTrue("the stand-in Drive connects", AppGraph.backup.connectDrive())
            val drive = AppGraph.backup.link.api()!!
            assertTrue("something was backed up", drive.list().isNotEmpty())
            // The person empties the app's folder in their Google Drive.
            AppGraph.backup.link.deleteAll()
            AppGraph.backup.syncNow()
            assertTrue("nothing is in Drive now", drive.list().isEmpty())
        }
        waitFor(hasTestTag("notice-removed"), "the removed-backup notice")
        waitFor(hasText("Your Google Drive backup was deleted"), "what it says")
        assertTrue("it never blames the person; on screen: ${screen()}", screen().contains("safe on this phone"))

        tapTag("notice-action")
        waitFor(hasText("Everything is in your Google Drive again."), "the card saying it's done")
        kotlinx.coroutines.runBlocking {
            val chains = AppGraph.backup.link.api()!!.list().mapNotNull { it.properties["chain"] }
            assertTrue("base and every year are back; got $chains", chains.contains("base") && chains.size >= 2)
        }
        // And it folds away by itself.
        compose.waitUntil(10_000) { !has(hasTestTag("notice-removed")) }
    }

    // ------------------------------------------------------------------ Plus comes from Google Play alone (D16)

    /** The menu's Plus (5.9.1): Plus stays with the Google Play account; nothing to sign in to or redeem. */
    @Test fun thePlusScreenSaysPlusStaysWithGooglePlay() {
        launch(demo = "today")
        tapTag("menu-button")
        tapTag("menu-plus")
        waitFor(hasTestTag("plus-screen"), "the Plus screen")
        waitFor(hasText("No subscription, no account.", substring = true), "that there's no account")
        waitFor(hasText("Plus stays with your Google Play account.", substring = true), "that Plus stays with Google Play")
        // No account, no family, no code: nothing on the device unlocks Plus (D16; the user, 22 Oct 2026).
        assertNone(hasText("Sign in with Google"), "a sign-in")
        assertNone(hasText("Redeem a code"), "a code to redeem")
        assertNone(hasText("Plus Family"), "a family plan")
    }
}
