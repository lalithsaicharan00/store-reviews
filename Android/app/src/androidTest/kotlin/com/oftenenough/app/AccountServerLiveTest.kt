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
import app.habits.account.Account
import app.habits.account.AccountPlus
import app.habits.account.Answer
import app.habits.account.HttpAccountServer
import app.habits.account.InviteLook
import app.habits.account.StorePurchase
import app.habits.account.SignIn
import app.habits.account.SignInReply
import app.habits.account.SignInWith
import com.oftenenough.app.app.account.StandInSignIn
import kotlinx.coroutines.runBlocking
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

/**
 * The app against the real account Worker's dev (api-dev.oftenenough.com), end to end: the app's own client, and then
 * the screens (Figma 1476:2). Signing in uses dev's test secret instead of Google's sheet (`accountTestSecret`, passed as
 * an instrumentation argument from ~/.gradle/gradle.properties, never in the repository); purchases are the debug
 * build's stand-in, which only dev counts. Every account a test makes is deleted at its end.
 *
 *   ./gradlew :app:connectedDebugAndroidTest -Pandroid.testInstrumentationRunnerArguments.class=com.oftenenough.app.AccountServerLiveTest \
 *     -Pandroid.testInstrumentationRunnerArguments.accountTestSecret=$(grep accountTestSecret ~/.gradle/gradle.properties | cut -d= -f2-)
 */
@RunWith(AndroidJUnit4::class)
class AccountServerLiveTest {
    @get:Rule val compose = createEmptyComposeRule()
    private var scenario: ActivityScenario<MainActivity>? = null
    private val server = com.oftenenough.app.app.account.androidAccountServer(HttpAccountServer.DEV)
    private val secret: String = InstrumentationRegistry.getArguments().getString("accountTestSecret").orEmpty()
    private val run = "android-${System.currentTimeMillis()}"
    /** Every account made here, with the proof that deletes it. */
    private val made = mutableListOf<Pair<SignIn, () -> Account?>>()

    @Before fun needsTheSecret() {
        // A run without the secret fails rather than skipping: a skip is never a pass (T20).
        assertTrue("Pass -Pandroid.testInstrumentationRunnerArguments.accountTestSecret=… (account-server/README.md)", secret.length >= 32)
    }

    @After fun cleanUp() {
        scenario?.close()
        runBlocking {
            for ((proof, account) in made) {
                val a = account() ?: (server.signIn(proof) as? Answer.Ok)?.value.let { (it as? SignInReply.Found)?.account } ?: continue
                server.delete(a, proof)
            }
        }
    }

    private fun proof(name: String) = SignIn(SignInWith.GOOGLE, HttpAccountServer.TEST_PREFIX + secret, "$run-$name", name)
    private fun <T> Answer<T>.ok(): T = (this as? Answer.Ok ?: throw AssertionError("Couldn't reach dev's Worker")).value

    private suspend fun account(name: String, purchase: StorePurchase? = null): Account {
        val p = proof(name)
        val a = server.create(p, purchase).ok()
        var latest: Account? = a
        made += p to { latest }
        return a
    }

    // ---------------------------------------------------------------- The app's client against dev

    @Test fun theClientRunsAWholeFamilyOnDev() = runBlocking {
        val lee = account("Lee", StorePurchase("com.oftenenough.app.plusfamily", "stand-in-$run-lee"))
        assertEquals(AccountPlus.FAMILY_OWNER, lee.plus)
        assertEquals("Lee", lee.family!!.ownerName)
        val invited = server.invite(lee).ok()
        val invite = invited.family!!.invite!!
        assertEquals("https://oftenenough.com/join/${invite.token}", invite.link)
        assertEquals(java.time.LocalDate.now(java.time.ZoneOffset.UTC).toEpochDay() + 7, invite.endsDay)
        assertTrue(server.lookInvite(invite.token).ok() is InviteLook.Open)

        val priya = account("Priya")
        val joined = server.join(priya, invite.token).ok()
        assertEquals(AccountPlus.FAMILY_MEMBER, joined.plus)
        assertEquals("Lee", joined.family!!.ownerName)
        assertTrue(server.lookInvite(invite.token).ok() is InviteLook.Used)

        val leeNow = server.refresh(lee).ok()!!
        assertEquals(listOf("Lee", "Priya"), leeNow.family!!.people.map { it.name })
        assertNull("the invite is used", leeNow.family!!.invite)

        val second = server.invite(lee).ok().family!!.invite!!.token
        server.cancelInvite(lee).ok()
        assertTrue(server.lookInvite(second).ok() is InviteLook.Cancelled)

        val priyaId = joined.family!!.people.single { it.you }.id
        assertEquals(1, server.remove(lee, priyaId).ok().family!!.people.size)
        assertEquals(AccountPlus.NONE, server.refresh(priya).ok()!!.plus)

        // Deleting needs the same person; then the session is gone everywhere.
        assertEquals(Answer.Ok(false), server.delete(priya, proof("Somebody")))
        assertEquals(Answer.Ok(true), server.delete(priya, proof("Priya")))
        assertNull(server.refresh(priya).ok())
        // Signing out ends the session too.
        server.signOut(lee)
        assertNull(server.refresh(lee).ok())
        val back = (server.signIn(proof("Lee")).ok() as SignInReply.Found).account
        assertEquals(AccountPlus.FAMILY_OWNER, back.plus)
        made.removeAll { it.first.email == "$run-Lee" }
        made += proof("Lee") to { back }
    }

    // ---------------------------------------------------------------- The screens against dev

    private fun launch() {
        val intent = Intent(ApplicationProvider.getApplicationContext(), MainActivity::class.java)
            .putExtra(TestLaunch.UITEST, true).putExtra(TestLaunch.CLOCK_HOUR, 10).putExtra(TestLaunch.DEMO, "today")
            .putExtra(TestLaunch.ACCOUNT_SERVER, "dev")
        TestDevice.clear()
        scenario = ActivityScenario.launch(intent)
        waitFor(hasTestTag("row-Read"), "the demo on Today")
    }

    private fun screen(): String = compose.onAllNodes(SemanticsMatcher("anything") { true }, useUnmergedTree = true).fetchSemanticsNodes().mapNotNull { n ->
        (n.config.getOrNull(SemanticsProperties.Text)?.joinToString(" ") { it.text } ?: n.config.getOrNull(SemanticsProperties.TestTag))?.takeIf { it.isNotBlank() }
    }.distinct().joinToString(" | ").take(3000)
    private fun has(m: SemanticsMatcher) = compose.onAllNodes(m, useUnmergedTree = true).fetchSemanticsNodes().isNotEmpty()
    private fun waitFor(m: SemanticsMatcher, what: String, timeout: Long = 20_000) {
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

    @Test fun theScreensBuyAFamily_invite_seeSomeoneJoin_remove_andDelete() {
        launch()
        assertTrue("this launch talks to dev's Worker", AppGraph.accounts.server is HttpAccountServer)
        val leeProof = proof("Lee")
        made += leeProof to { AppGraph.accounts.account }
        onMain { (AppGraph.signIn as StandInSignIn).nextGoogle = leeProof }
        tapTag("menu-button"); tapTag("menu-plus")
        waitFor(hasTestTag("plus-state-free"), "1 Free")
        tapTag("plus-see"); tapTag("plan-family"); tapTag("plus-buy")
        waitFor(hasTestTag("plus-family-thanks"), "2.6 Plus Family is yours.")
        tapTag("family-thanks-google")
        waitFor(hasTestTag("plus-state-family_owner"), "1.4 from dev's Worker")
        val lee = AppGraph.accounts.account!!
        assertTrue("a real session", lee.session.length >= 40)
        assertEquals(AccountPlus.FAMILY_OWNER, lee.plus)

        // Add a person: the sheet shows dev's invite.
        tapTag("family-add")
        waitFor(hasTestTag("sheet-invite"), "7 Invite someone")
        val token = AppGraph.accounts.account!!.family!!.invite!!.token
        text("Works once, for 7 days")
        TestDevice.device.pressBack()

        // Priya joins on her phone (the client, as her app would); Lee's page shows her after a refresh.
        val priya = runBlocking { account("Priya") }
        val joined = runBlocking { server.join(priya, token).ok() }
        assertEquals(AccountPlus.FAMILY_MEMBER, joined.plus)
        runBlocking { AppGraph.accounts.refresh() }
        waitFor(hasTestTag("family-person-Priya"), "Priya in Lee's family")
        text("Joined", "4 places free")

        // Remove Priya (7.3).
        tapTag("family-person-Priya"); tapTag("dialog-remove-confirm")
        try { compose.waitUntil(20_000) { !has(hasTestTag("family-person-Priya")) } } catch (e: Throwable) { throw AssertionError("Priya stayed; on screen: ${screen()}") }
        assertEquals(AccountPlus.NONE, runBlocking { server.refresh(priya).ok() }!!.plus)

        // Opening an invite link on this phone reads dev's answer (5.7: an owner keeps their family).
        val other = runBlocking { account("Sam", StorePurchase("com.oftenenough.app.plusfamily", "stand-in-$run-sam")) }
        val samToken = runBlocking { server.invite(other).ok() }.family!!.invite!!.token
        onMain { AppGraph.inviteToOpen = samToken }
        waitFor(hasTestTag("invite-have-plus"), "5.7 You have Plus.")
        tapTag("invite-done")

        // Delete the account (7.2): Google's sign-in again as Lee, then 1.2 with "Your account was deleted".
        tapTag("plus-delete-account"); tapTag("dialog-delete-account-confirm")
        waitFor(hasText("Your account was deleted"), "7.2.2")
        waitFor(hasTestTag("plus-state-plus_no_account"), "1.2: Plus stays with Google Play")
        assertNull(AppGraph.accounts.account)
        assertEquals("gone from dev too", SignInReply.NoAccount, runBlocking { server.signIn(leeProof).ok() })
        made.removeAll { it.first == leeProof }
        assertNotNull(other)
    }
}
