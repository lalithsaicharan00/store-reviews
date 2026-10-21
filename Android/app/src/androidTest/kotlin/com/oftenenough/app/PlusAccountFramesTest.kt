// TO BE DELETED (the user, 21 Oct 2026): no accounts; Plus moves between iPhone and Android by hand. The server side was deleted the same day (account-server/README.md, "The accounts, deleted 21 Oct 2026").
package com.oftenenough.app

import android.content.Intent
import android.graphics.Bitmap
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
import com.oftenenough.app.app.BuyResult
import com.oftenenough.app.app.FakePlusStore
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.app.RestoreResult
import com.oftenenough.app.app.TestLaunch
import app.habits.account.Answer
import app.habits.account.StorePurchase
import app.habits.account.SignIn
import app.habits.account.SignInWith
import app.habits.account.StandInAccountServer
import com.oftenenough.app.app.account.StandInSignIn
import kotlinx.coroutines.runBlocking
import org.junit.After
import org.junit.Assert.assertTrue
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import java.io.File

/**
 * Every frame of Figma's "Settings: Plus & Account" (1476:2), brought about on the emulator through its own flow, with a
 * picture of each (named by the frame's number) for the side-by-side check against Figma: light, dark and 200 % text
 * are the same run with the emulator's own settings changed. Each step also checks the frame's words are there, so the
 * run is a test of every state and arrow too. Pictures: the app's files, `plus-shots/<prefix>/` (the `shots` argument).
 */
@RunWith(AndroidJUnit4::class)
class PlusAccountFramesTest {
    @get:Rule val compose = createEmptyComposeRule()
    private var scenario: ActivityScenario<MainActivity>? = null

    @After fun close() { scenario?.close() }

    private val store get() = AppGraph.plus as FakePlusStore
    private val server get() = AppGraph.accounts.server as StandInAccountServer
    private val signIn get() = AppGraph.signIn as StandInSignIn
    private val context get() = InstrumentationRegistry.getInstrumentation().targetContext
    private val folder: File by lazy {
        val prefix = InstrumentationRegistry.getArguments().getString("shots") ?: "light"
        File(context.getExternalFilesDir(null), "plus-shots/$prefix").also { it.mkdirs() }
    }

    private fun launch(drive: Boolean = true) {
        val intent = Intent(ApplicationProvider.getApplicationContext(), MainActivity::class.java)
            .putExtra(TestLaunch.UITEST, true).putExtra(TestLaunch.CLOCK_HOUR, 10).putExtra(TestLaunch.DEMO, "today")
        TestDevice.clear()
        scenario = ActivityScenario.launch(intent)
        waitFor(hasTestTag("row-Read"), "the demo on Today")
        // Figma's page shows Backup as connected (1); 1.1 is the same page before Drive is connected.
        if (drive) runBlocking { AppGraph.backup.link.connect(context) }
    }

    private fun screen(): String = compose.onAllNodes(SemanticsMatcher("anything") { true }, useUnmergedTree = true).fetchSemanticsNodes().mapNotNull { n ->
        (n.config.getOrNull(SemanticsProperties.Text)?.joinToString(" ") { it.text } ?: n.config.getOrNull(SemanticsProperties.TestTag))?.takeIf { it.isNotBlank() }
    }.distinct().joinToString(" | ").take(3000)

    private fun has(m: SemanticsMatcher) = compose.onAllNodes(m, useUnmergedTree = true).fetchSemanticsNodes().isNotEmpty()
    private fun waitFor(m: SemanticsMatcher, what: String, timeout: Long = 15_000) {
        try { compose.waitUntil(timeout) { has(m) } } catch (e: Throwable) { throw AssertionError("Waited for $what; on screen: ${screen()}") }
    }
    private fun tapTag(tag: String) {
        val m = hasTestTag(tag)
        waitFor(m, "tag $tag")
        compose.waitForIdle()
        runCatching { compose.onAllNodes(m, useUnmergedTree = true)[0].performScrollTo() }
        compose.waitForIdle()
        compose.onAllNodes(m, useUnmergedTree = true)[0].performClick()
    }
    private fun text(vararg words: String) = words.forEach { waitFor(hasText(it, substring = true), "\"$it\"") }
    private fun onMain(block: () -> Unit) = InstrumentationRegistry.getInstrumentation().runOnMainSync(block)
    private fun back() = TestDevice.device.pressBack()

    /** A picture of the screen as it is now, once it has settled. */
    private fun shot(frame: String, settle: Long = 700) {
        compose.waitForIdle()
        Thread.sleep(settle)
        val bitmap = InstrumentationRegistry.getInstrumentation().uiAutomation.takeScreenshot() ?: error("No screenshot")
        File(folder, "$frame.png").outputStream().use { bitmap.compress(Bitmap.CompressFormat.PNG, 100, it) }
    }

    /** The rest of a page longer than the screen: scrolled to [m], its last part, and pictured as "<frame> end". */
    private fun shotEnd(frame: String, m: SemanticsMatcher) {
        compose.onAllNodes(m, useUnmergedTree = true)[0].performScrollTo()
        shot("$frame end")
        compose.onAllNodes(hasTestTag("plus-state-" + state()), useUnmergedTree = true)[0].performScrollTo()
    }
    private fun state() = compose.onAllNodes(SemanticsMatcher("state card") { n -> n.config.getOrNull(SemanticsProperties.TestTag)?.startsWith("plus-state-") == true }, useUnmergedTree = true)
        .fetchSemanticsNodes().first().config[SemanticsProperties.TestTag].removePrefix("plus-state-")
    private val lastFooter = hasText("Plus bought on this Google account also comes back by itself when you open the app.")

    private fun openPage(state: String = "free") {
        tapTag("menu-button"); tapTag("menu-plus")
        waitFor(hasTestTag("plus-state-$state"), "Plus & Account, $state")
    }

    @Test fun free_restore_and_signIn() {
        launch(drive = false)
        openPage()
        text("No sign-in needed", "Not backed up", "Only on this phone for now", "Back up to Google Drive")
        shot("1.1")
        shotEnd("1.1", lastFooter)
        runBlocking { AppGraph.backup.link.connect(context) }
        text("Backed up to Google Drive", "We never see your habits.", "Join a family", "Already have Plus?",
            "Plus bought on this Google account also comes back by itself when you open the app.")
        shot("1")
        shotEnd("1", lastFooter)
        tapTag("plus-redeem")
        waitFor(hasTestTag("dialog-code"), "Redeem a code")
        shot("x-redeem")
        tapTag("dialog-code-dismiss")
        tapTag("plus-join-family")
        text("Join a family.", "Use the invite you were sent.", "Got a link?", "Scan QR code")
        shot("5")
        back()
        // 4 → 4.2 (over 1)
        onMain { store.latencyMs = 2500 }
        tapTag("plus-restore")
        text("Looking for your purchase", "On this Google account")
        shot("4", settle = 300)
        waitFor(hasTestTag("dialog-no-plus"), "4.2 No Plus found")
        text("If you bought it on an iPhone, or have an account, sign in instead.")
        shot("4.2")
        tapTag("dialog-no-plus-dismiss")
        // 4 → 4.3 → Cancel → 1
        onMain { store.latencyMs = 0; store.nextRestore = RestoreResult.COULD_NOT_CONNECT }
        tapTag("plus-restore")
        waitFor(hasTestTag("restore-offline"), "4.3")
        text("We couldn’t reach Google Play. Check your internet connection, then try again.", "Try again")
        shot("4.3")
        tapTag("restore-offline-quiet")
        waitFor(hasTestTag("plus-state-free"), "back on 1")
        // 1 Sign in → 3 → 3.2 → 3.4 → 3.5 → Cancel → 3
        tapTag("plus-sign-in")
        waitFor(hasTestTag("signin-start"), "3 Sign in")
        text("Sign in.", "Bring Plus back from your account.", "Plus comes back", "Your family too", "Your habits stay in your Drive",
            "Made your account on an iPhone? Sign in the same way you did there.", "Continue with Google", "Continue with Apple")
        shot("3")
        onMain { server.latencyMs = 2500 }
        tapTag("signin-google")
        text("Looking for your Plus", "Signed in with Google")
        shot("3.2", settle = 300)
        waitFor(hasTestTag("signin-none"), "3.4 No account found")
        text("No account found.", "No Plus account uses sam@gmail.com.", "Try another account", "Another Google account", "Don’t have Plus?", "Get Plus")
        shot("3.4")
        onMain { server.latencyMs = 0; server.offline = true }
        tapTag("none-google")
        waitFor(hasTestTag("signin-offline"), "3.5")
        text("We couldn’t reach Google. Check your internet connection, then try again.")
        shot("3.5")
        onMain { server.offline = false }
        tapTag("signin-offline-quiet")
        waitFor(hasTestTag("signin-start"), "back to 3")
        // 3 → 3.3 (an account made on an iPhone) → Done → 1.3
        runBlocking { server.create(SignIn(SignInWith.APPLE, "stand-in", "sam@privaterelay.appleid.com", "Sam"), StorePurchase("com.oftenenough.app.plus", "x")) }
        tapTag("signin-apple")
        waitFor(hasTestTag("signin-found"), "3.3")
        text("Plus is back.", "Signed in as sam@privaterelay.appleid.com.", "Your habits sync through Drive")
        shot("3.3")
        tapTag("signin-done")
        waitFor(hasTestTag("plus-state-plus"), "1.3 after signing in")
    }

    @Test fun restoreFindsAPurchase() {
        launch()
        openPage()
        onMain { store.nextRestore = RestoreResult.FOUND }
        tapTag("plus-restore")
        waitFor(hasTestTag("restore-found"), "4.1")
        text("Plus is back.", "Bought with this Google account.", "Plus on your Android devices", "Want it on an iPhone or iPad too?", "Create one in Plus & Account.")
        shot("4.1")
        tapTag("restore-done")
        waitFor(hasTestTag("plus-state-free"), "back on the page")
    }

    @Test fun buyPlus_account_signOut_delete_upgrade() {
        launch()
        openPage()
        tapTag("plus-see")
        text("Get Plus", "One payment, yours forever.", "Just you", "On all your devices", "You + 5 people", "Unlimited habits",
            "Through your own Google Drive.", "More widgets", "Works on", "Wear OS watch", "Get Plus · $24.99", "I already have Plus")
        shot("2")
        tapTag("plan-family")
        text("Get Plus Family · $59.99")
        shot("2.4")
        tapTag("plan-plus")
        onMain { store.nextBuy = BuyResult.NOT_COMPLETED }
        tapTag("plus-buy")
        waitFor(hasTestTag("dialog-payment"), "2.1.2")
        text("Payment not completed", "Nothing was charged. Check your payment method in Google Play, then try again.")
        shot("2.1.2")
        tapTag("dialog-payment-dismiss")
        onMain { store.nextBuy = BuyResult.PENDING }
        tapTag("plus-buy")
        waitFor(hasTestTag("plus-pending"), "2.1.1")
        text("Waiting for your payment", "Plus turns on as soon as Google Play confirms it.", "Close")
        shot("2.1.1", settle = 300)
        onMain { store.confirmPending() }
        waitFor(hasTestTag("plus-thanks"), "2.2")
        text("Plus is yours.", "Thank you. Keep it on all your devices with an account.", "Your purchase stays safe",
            "Without an account, Plus stays with your Google Play account, on Android only. You can create one later.", "Not now")
        shot("2.2")
        tapTag("thanks-not-now")
        waitFor(hasTestTag("plus-state-plus_no_account"), "1.2")
        text("Plus is yours", "No account yet", "Create an account", "Upgrade to Plus Family", "Add up to 5 people for $35.00, the difference")
        shot("1.2")
        tapTag("plus-upgrade-family")
        text("Plus Family", "You have Plus. Pay only the difference.", "Plus for up to 5 more people", "Invite with a link or a QR code", "Get Plus Family · $35.00")
        assertTrue("8 has no I already have Plus", !has(hasTestTag("plus-already")))
        shot("8")
        back()
        tapTag("plus-create-account")
        waitFor(hasTestTag("account-create"), "6")
        text("Create an account.", "It takes Plus to all your devices.")
        shot("6")
        tapTag("create-google")
        waitFor(hasTestTag("plus-state-plus"), "1.3")
        text("Signed in as sam@gmail.com", "Your account holds only your Plus purchase", "Delete my account…")
        shot("1.3")
        shotEnd("1.3", hasTestTag("plus-delete-account"))
        tapTag("plus-sign-out")
        waitFor(hasTestTag("dialog-sign-out"), "7.1")
        text("Plus stays on this phone through Google Play. Your habits stay here and in your Google Drive.")
        shot("7.1")
        tapTag("dialog-sign-out-dismiss")
        // An account with Plus opening someone's invite (5.7)
        val ana = server.seedFamily("Lee", "lee@gmail.com")
        onMain { AppGraph.inviteToOpen = ana }
        waitFor(hasTestTag("invite-have-plus"), "5.7")
        text("You have Plus.", "You don’t need Lee’s family for it. Keep the place for someone else?", "Join anyway")
        shot("5.7")
        tapTag("invite-done")
        waitFor(hasTestTag("plus-state-plus"), "back on 1.3")
        tapTag("plus-delete-account")
        waitFor(hasTestTag("dialog-delete-account"), "7.2")
        text("Your account is deleted. Your purchase stays with Google Play. Your habits stay on this phone and in your Google Drive.")
        shot("7.2")
        tapTag("dialog-delete-account-confirm")
        waitFor(hasText("Your account was deleted"), "7.2.2's snackbar")
        waitFor(hasTestTag("plus-state-plus_no_account"), "7.2.2 back to 1.2")
        shot("7.2.2", settle = 300)
        // 1.2 → 8 → 8.1 → 8.2 (no account yet: sign in to invite) → 8.3 → 1.4
        tapTag("plus-upgrade-family")
        tapTag("plus-buy")
        waitFor(hasTestTag("plus-family-thanks"), "8.2")
        text("Plus Family is yours.", "Thank you. Sign in to invite people to your family.", "Your account holds your purchase and your family, never your habits.")
        assertTrue("no Not now on 8.2", !has(hasTestTag("thanks-not-now")))
        shot("8.2")
        tapTag("family-thanks-google")
        waitFor(hasTestTag("plus-state-family_owner"), "1.4 after 8.3")
    }

    @Test fun upgradeWithAnAccount_saysDone() {
        launch()
        openPage()
        tapTag("plus-see"); tapTag("plus-buy"); tapTag("thanks-google")
        waitFor(hasTestTag("plus-state-plus"), "1.3")
        tapTag("plus-upgrade-family"); tapTag("plus-buy")
        waitFor(hasTestTag("family-thanks-done"), "8.2 with an account: Done")
        text("Thank you. Invite people from Your family.")
        shot("8.2-signed-in")
        tapTag("family-thanks-done")
        waitFor(hasTestTag("plus-state-family_owner"), "1.4")
    }

    @Test fun aFamilyOwner_invites_removes_cancels() {
        launch()
        openPage()
        tapTag("plus-see"); tapTag("plan-family"); tapTag("plus-buy")
        waitFor(hasTestTag("plus-family-thanks"), "2.6")
        text("Plus Family is yours.", "Invite up to 5 people", "Everyone’s habits stay their own")
        shot("2.6")
        tapTag("family-thanks-google")
        waitFor(hasTestTag("plus-state-family_owner"), "1.4")
        tapTag("family-add")
        waitFor(hasTestTag("sheet-invite"), "7")
        text("Invite someone", "They join with their own account. Their habits stay their own.", "With them? They scan it with their camera.",
            "Share invite link", "Works once, for 7 days. Cancel it in Your family.")
        shot("7", settle = 1200)
        back()
        try { compose.waitUntil(5_000) { !has(hasTestTag("sheet-invite")) } } catch (e: Throwable) { throw AssertionError("Back didn't close 7; on screen: ${screen()}") }
        // Lee uses the invite on their phone; then a second invite waits.
        runBlocking {
            val token = AppGraph.accounts.account!!.family!!.invite!!.token
            val lee = (server.create(SignIn(SignInWith.GOOGLE, "stand-in", "lee@gmail.com", "Lee"), null) as Answer.Ok).value
            server.join(lee, token)
            AppGraph.accounts.invite()
        }
        waitFor(hasTestTag("family-invite-sent"), "Invite sent")
        text("You", "Owner", "Lee", "Joined", "Invite sent", "Add a person", "3 places free",
            "Plus Family · up to 6 people. Each person has their own habits. Nobody sees anyone else’s.")
        shot("1.4")
        shotEnd("1.4", hasTestTag("plus-delete-account"))
        tapTag("family-person-Lee")
        waitFor(hasTestTag("dialog-remove"), "7.3")
        text("Remove Lee?", "Lee keeps their habits. Plus stops on their devices, and their place opens for someone else.")
        shot("7.3")
        tapTag("dialog-remove-dismiss")
        tapTag("family-invite-sent")
        waitFor(hasTestTag("sheet-invite-sent"), "7.5")
        text("Nobody has used it yet.", "Share again", "Cancel invite", "It works once. They join with their own account.")
        shot("7.5", settle = 1200)
        tapTag("invite-cancel")
        waitFor(hasTestTag("dialog-cancel-invite"), "7.6")
        text("Cancel this invite?", "The link and the QR code stop working, and the place is free again.", "Keep it")
        shot("7.6")
        assertTrue("7.6 is asked over the page, the sheet closed", !has(hasTestTag("sheet-invite-sent")))
        tapTag("dialog-cancel-invite-dismiss")
        // Keep it: back on the page, the invite still waiting.
        waitFor(hasTestTag("family-invite-sent"), "the invite kept")
        assertTrue("the invite is still waiting", AppGraph.accounts.account?.family?.invite != null)
        // Back closes 7.5 too.
        tapTag("family-invite-sent")
        waitFor(hasTestTag("sheet-invite-sent"), "7.5 again")
        compose.waitForIdle()
        back()
        try { compose.waitUntil(5_000) { !has(hasTestTag("sheet-invite-sent")) } } catch (e: Throwable) { throw AssertionError("Back didn't close 7.5; on screen: ${screen()}") }
        tapTag("plus-sign-out")
        waitFor(hasTestTag("dialog-sign-out"), "7.7")
        text("Plus stays on this phone through Google Play, and your family keeps Plus. Your habits stay here and in your Google Drive.")
        shot("7.7")
        tapTag("dialog-sign-out-dismiss")
        tapTag("plus-delete-account")
        waitFor(hasTestTag("dialog-delete-account"), "7.9")
        text("Your account and your family are deleted, so Lee loses Plus. Your purchase stays with Google Play, and your habits stay here and in your Google Drive.")
        shot("7.9")
        tapTag("dialog-delete-account-dismiss")
        // Each dialog does what it says: Remove (7.3), Cancel invite (7.6), Sign out (7.7).
        tapTag("family-person-Lee"); tapTag("dialog-remove-confirm")
        try { compose.waitUntil(5_000) { !has(hasTestTag("family-person-Lee")) } } catch (e: Throwable) { throw AssertionError("Lee stayed; on screen: ${screen()}") }
        text("4 places free")
        tapTag("family-invite-sent"); tapTag("invite-cancel"); tapTag("dialog-cancel-invite-confirm")
        try { compose.waitUntil(5_000) { !has(hasTestTag("family-invite-sent")) } } catch (e: Throwable) { throw AssertionError("The invite stayed; on screen: ${screen()}") }
        text("5 places free")
        assertTrue("no invite waiting", AppGraph.accounts.account?.family?.invite == null)
        tapTag("plus-sign-out"); tapTag("dialog-sign-out-confirm")
        waitFor(hasTestTag("plus-state-plus_no_account"), "signed out: Plus stays through Google Play")
        text("Invite your family", "Create an account first, then invite up to 5 people")
    }

    @Test fun aMember_andEveryInviteState() {
        launch()
        val token = server.seedFamily("Lee", "lee@gmail.com")
        onMain { signIn.nextGoogle = SignIn(SignInWith.GOOGLE, "stand-in", "priya@gmail.com", "Priya"); AppGraph.inviteToOpen = token }
        waitFor(hasTestTag("join-sign-in"), "5.1")
        text("Sign in to join.", "Lee’s family shares Plus with you.", "At no cost to you.", "Your account keeps your place", "Lee never sees them.")
        shot("5.1")
        tapTag("signin-google")
        waitFor(hasTestTag("invite-join"), "5.2")
        text("Join Lee’s family?", "Lee invited you to share Plus.", "Unlimited habits, at no cost to you.", "Neither of you sees the other’s.", "Leave whenever you like")
        shot("5.2")
        tapTag("invite-join-family")
        waitFor(hasTestTag("plus-state-family_member"), "1.5")
        try { compose.waitUntil(15_000) { !has(hasText("You joined", substring = true)) } } catch (e: Throwable) { throw AssertionError("The snackbar stayed; on screen: ${screen()}") }
        text("Signed in as priya@gmail.com", "Your account holds only your place in Lee’s family", "Owner", "Leave Lee’s family", "Your habits stay; only Plus stops",
            "Each person has their own habits. Nobody sees anyone else’s.")
        shot("1.5")
        shotEnd("1.5", hasTestTag("plus-delete-account"))
        tapTag("plus-sign-out")
        waitFor(hasTestTag("dialog-sign-out"), "7.8")
        text("Plus from Lee’s family stops on this phone until you sign in again. Your habits stay on this phone and in your Google Drive.")
        shot("7.8")
        tapTag("dialog-sign-out-dismiss")
        tapTag("family-leave")
        waitFor(hasTestTag("dialog-leave"), "7.4")
        text("Leave Lee’s family?", "Your habits stay on this phone and in your Google Drive. Plus stops until you get it again.")
        shot("7.4")
        tapTag("dialog-leave-dismiss")
        tapTag("plus-delete-account")
        waitFor(hasTestTag("dialog-delete-account"), "7.10")
        text("Your account is deleted and you leave Lee’s family, so Plus stops on this phone. Your habits stay here and in your Google Drive.")
        shot("7.10")
        tapTag("dialog-delete-account-dismiss")
        // 5.8: already in Lee's family, opening Sam's invite
        val sams = server.seedFamily("Sam", "sam.k@gmail.com")
        onMain { AppGraph.inviteToOpen = sams }
        waitFor(hasTestTag("invite-in-family"), "5.8")
        text("Already in a family.", "You’re in Lee’s family. Leave it to join Sam’s. Your habits stay with you.", "Leave and join Sam’s", "Not now")
        shot("5.8")
        tapTag("invite-not-now")
        // 5.3–5.6: invites that can't be used
        val ended = server.seedFamily("Ana", "ana@gmail.com").also { server.setInvite(it, endsDay = java.time.LocalDate.now().toEpochDay() - 1) }
        onMain { AppGraph.inviteToOpen = ended }
        waitFor(hasTestTag("invite-ended"), "5.3")
        text("This invite has ended.", "Invites work for 7 days. Ask Ana for a new one.")
        shot("5.3")
        tapTag("invite-ended-done")
        val used = server.seedFamily("Bo", "bo@gmail.com").also { server.setInvite(it, state = StandInAccountServer.USED) }
        onMain { AppGraph.inviteToOpen = used }
        waitFor(hasTestTag("invite-used"), "5.4")
        text("This invite was already used.", "Each invite works once. Ask Bo for a new one.")
        shot("5.4")
        tapTag("invite-used-done")
        val cancelled = server.seedFamily("Cy", "cy@gmail.com").also { server.setInvite(it, state = StandInAccountServer.CANCELLED) }
        onMain { AppGraph.inviteToOpen = cancelled }
        waitFor(hasTestTag("invite-cancelled"), "5.5")
        text("Invite cancelled.", "Cy cancelled it. To join, ask Cy for a new one.")
        shot("5.5")
        tapTag("invite-cancelled-done")
        val full = server.seedFamily("Di", "di@gmail.com", (1..5).map { "M$it" to "m$it@gmail.com" })
        onMain { AppGraph.inviteToOpen = full }
        waitFor(hasTestTag("invite-full"), "5.6")
        text("Di’s family is full.", "It already has 6 people. Di can make room in Plus & Account.")
        shot("5.6")
        tapTag("invite-full-done")
    }
}
