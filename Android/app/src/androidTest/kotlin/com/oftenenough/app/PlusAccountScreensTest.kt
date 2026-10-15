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
import com.oftenenough.app.app.BuyResult
import com.oftenenough.app.app.FakePlusStore
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.app.PlusOwned
import com.oftenenough.app.app.RestoreResult
import com.oftenenough.app.app.TestLaunch
import com.oftenenough.app.app.account.AccountPlus
import com.oftenenough.app.app.account.SignIn
import com.oftenenough.app.app.account.SignInWith
import com.oftenenough.app.app.account.StandInAccountServer
import com.oftenenough.app.app.account.StandInSignIn
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Plus & Account on the emulator (Figma 1476:2): every state of the page and every flow, with the stand-in Play store,
 * sign-in and server (a test launch's own, D8). A failure says, on one line, what was on screen (T14).
 */
@RunWith(AndroidJUnit4::class)
class PlusAccountScreensTest {
    @get:Rule val compose = createEmptyComposeRule()
    private var scenario: ActivityScenario<MainActivity>? = null

    @After fun close() { scenario?.close() }

    private val store get() = AppGraph.plus as FakePlusStore
    private val server get() = AppGraph.accounts.server as StandInAccountServer
    private val signIn get() = AppGraph.signIn as StandInSignIn

    private fun launch() {
        val intent = Intent(ApplicationProvider.getApplicationContext(), MainActivity::class.java)
            .putExtra(TestLaunch.UITEST, true).putExtra(TestLaunch.CLOCK_HOUR, 10).putExtra(TestLaunch.DEMO, "today")
        TestDevice.clear()
        scenario = ActivityScenario.launch(intent)
        waitFor(hasTestTag("row-Read"), "the demo on Today")
    }

    private fun screen(): String = compose.onAllNodes(SemanticsMatcher("anything") { true }, useUnmergedTree = true).fetchSemanticsNodes().mapNotNull { n ->
        (n.config.getOrNull(SemanticsProperties.Text)?.joinToString(" ") { it.text } ?: n.config.getOrNull(SemanticsProperties.TestTag))?.takeIf { it.isNotBlank() }
    }.distinct().joinToString(" | ").take(3000)

    private fun has(m: SemanticsMatcher) = compose.onAllNodes(m, useUnmergedTree = true).fetchSemanticsNodes().isNotEmpty()
    private fun waitFor(m: SemanticsMatcher, what: String, timeout: Long = 15_000) {
        try { compose.waitUntil(timeout) { has(m) } } catch (e: Throwable) { throw AssertionError("Waited for $what; on screen: ${screen()}") }
    }
    private fun tap(m: SemanticsMatcher, what: String) {
        waitFor(m, what)
        compose.waitForIdle()
        runCatching { compose.onAllNodes(m, useUnmergedTree = true)[0].performScrollTo() }
        compose.waitForIdle()
        compose.onAllNodes(m, useUnmergedTree = true)[0].performClick()
    }
    private fun tapTag(tag: String) = tap(hasTestTag(tag), "tag $tag")
    private fun text(t: String) = waitFor(hasText(t, substring = true), "\"$t\"")
    private fun onMain(block: () -> Unit) = InstrumentationRegistry.getInstrumentation().runOnMainSync(block)
    private fun openPage() { tapTag("menu-button"); tapTag("menu-plus"); waitFor(hasTestTag("plus-state-free"), "Plus & Account, free") }

    @Test fun freeBuysPlus_thenSkipsTheAccount_thenCreatesOne() {
        launch(); openPage()
        text("No sign-in needed")
        tapTag("plus-see")
        tapTag("plus-buy")
        waitFor(hasTestTag("plus-thanks"), "2.2 Plus is yours.")
        tapTag("thanks-not-now")
        waitFor(hasTestTag("plus-state-plus_no_account"), "1.2 Plus, no account yet")
        text("Upgrade to Plus Family")
        tapTag("plus-create-account")
        tapTag("create-google")
        waitFor(hasTestTag("plus-state-plus"), "1.3 Plus with an account")
        text("Signed in as sam@gmail.com")
        assertEquals(AccountPlus.PLUS, AppGraph.accounts.account?.plus)
    }

    @Test fun aFamilyIsBought_signedInTo_andSomeoneInvited() {
        launch(); openPage()
        tapTag("plus-see")
        tapTag("plan-family")
        text("Get Plus Family · $59.99")
        tapTag("plus-buy")
        waitFor(hasTestTag("plus-family-thanks"), "2.6 Plus Family is yours.")
        assertTrue("no Not now: inviting needs the account", !has(hasTestTag("thanks-not-now")))
        tapTag("family-thanks-google")
        waitFor(hasTestTag("plus-state-family_owner"), "1.4 Plus Family, you manage it")
        tapTag("family-add")
        waitFor(hasTestTag("sheet-invite"), "7 Invite someone")
        text("Works once, for 7 days")
        assertTrue("an invite is waiting", AppGraph.accounts.account?.family?.invite != null)
    }

    @Test fun pendingPayment_thenPlayConfirmsIt() {
        launch(); openPage()
        store.nextBuy = BuyResult.PENDING
        tapTag("plus-see"); tapTag("plus-buy")
        waitFor(hasTestTag("plus-pending"), "2.1.1 Waiting for your payment")
        onMain { store.confirmPending() }
        waitFor(hasTestTag("plus-thanks"), "Plus turns on by itself")
    }

    @Test fun paymentNotCompleted_saysNothingWasCharged() {
        launch(); openPage()
        store.nextBuy = BuyResult.NOT_COMPLETED
        tapTag("plus-see"); tapTag("plus-buy")
        waitFor(hasTestTag("dialog-payment"), "2.1.2 Payment not completed")
        text("Nothing was charged")
        assertEquals(PlusOwned.NONE, store.owned)
        tapTag("dialog-payment-confirm")
        waitFor(hasTestTag("plus-thanks"), "bought on the second try")
    }

    @Test fun restoreFindsNothing_thenSignInFindsNoAccount_thenCantConnect() {
        launch(); openPage()
        tapTag("plus-restore")
        waitFor(hasTestTag("dialog-no-plus"), "4.2 No Plus found")
        tapTag("dialog-no-plus-confirm")
        waitFor(hasTestTag("signin-start"), "3 Sign in")
        tapTag("signin-google")
        waitFor(hasTestTag("signin-none"), "3.4 No account found")
        text("No Plus account uses sam@gmail.com.")
        onMain { server.offline = true }
        tapTag("none-google")
        waitFor(hasTestTag("signin-offline"), "3.5 Couldn't connect")
        onMain { server.offline = false }
        tapTag("signin-offline-quiet")
        waitFor(hasTestTag("signin-start"), "back to 3")
    }

    @Test fun restoreFindsAPurchase() {
        launch(); openPage()
        onMain { store.nextRestore = RestoreResult.FOUND }
        tapTag("plus-restore")
        waitFor(hasTestTag("restore-found"), "4.1 Plus is back")
        tapTag("restore-done")
        waitFor(hasTestTag("plus-state-free"), "back on the page")
    }

    @Test fun signInBringsBackPlusFromAnotherPhone() {
        launch()
        onMain {
            // Bought on an iPhone: the account has Plus, this phone's Play account has nothing.
            kotlinx.coroutines.runBlocking { server.create(SignIn(SignInWith.APPLE, "stand-in", "sam@privaterelay.appleid.com", "Sam"), com.oftenenough.app.app.account.PlayPurchase("com.oftenenough.app.plus", "x")) }
        }
        openPage()
        tapTag("plus-sign-in")
        tapTag("signin-apple")
        waitFor(hasTestTag("signin-found"), "3.3 Plus is back")
        text("Plus is back.")
        assertTrue("Plus from the account lifts the free limit", AppGraph.hasPlus && AppGraph.store.isPlus)
        tapTag("signin-done")
        waitFor(hasTestTag("plus-state-plus"), "1.3")
    }

    @Test fun anInviteLinkJoinsAFamily_andLeavingKeepsTheHabits() {
        launch()
        val token = server.seedFamily("Lee", "lee@gmail.com")
        onMain { signIn.nextGoogle = SignIn(SignInWith.GOOGLE, "stand-in", "priya@gmail.com", "Priya"); AppGraph.inviteToOpen = token }
        waitFor(hasTestTag("join-sign-in"), "5.1 Sign in to join")
        text("Lee’s family shares Plus with you.")
        tapTag("signin-google")
        waitFor(hasTestTag("invite-join"), "5.2 Join Lee's family?")
        tapTag("invite-join-family")
        waitFor(hasTestTag("plus-state-family_member"), "1.5 Plus from a family")
        text("Leave Lee’s family")
        // The "You joined" snackbar sits over the bottom rows until it goes.
        try { compose.waitUntil(15_000) { !has(hasText("You joined", substring = true)) } } catch (e: Throwable) { throw AssertionError("The snackbar stayed; on screen: ${screen()}") }
        val habits = AppGraph.store.habits.size
        tapTag("family-leave")
        tapTag("dialog-leave-confirm")
        waitFor(hasTestTag("plus-state-free_signed_in"), "free, still signed in")
        assertEquals("habits untouched", habits, AppGraph.store.habits.size)
    }

    @Test fun anEndedOrUsedInviteSaysWhy() {
        launch()
        val token = server.seedFamily("Lee", "lee@gmail.com")
        server.setInvite(token, endsDay = java.time.LocalDate.now().toEpochDay() - 1)
        onMain { AppGraph.inviteToOpen = token }
        waitFor(hasTestTag("invite-ended"), "5.3 This invite has ended")
        tapTag("invite-ended-done")
        val used = server.seedFamily("Ana", "ana@gmail.com")
        server.setInvite(used, state = StandInAccountServer.USED)
        onMain { AppGraph.inviteToOpen = used }
        waitFor(hasTestTag("invite-used"), "5.4 This invite was already used")
    }

    @Test fun deletingTheAccountAsksAndConfirmsItsYou() {
        launch(); openPage()
        tapTag("plus-see"); tapTag("plus-buy"); tapTag("thanks-google")
        waitFor(hasTestTag("plus-state-plus"), "1.3")
        tapTag("plus-delete-account")
        waitFor(hasTestTag("dialog-delete-account"), "7.2 Delete your account?")
        tapTag("dialog-delete-account-confirm")
        waitFor(hasTestTag("plus-state-plus_no_account"), "7.2.2 back to Plus, no account")
        assertNull(AppGraph.accounts.account)
        assertEquals("the purchase stays with Google Play", PlusOwned.PLUS, store.owned)
    }
}
