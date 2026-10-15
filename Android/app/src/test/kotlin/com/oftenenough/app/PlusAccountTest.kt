package com.oftenenough.app

import com.oftenenough.app.app.account.AccountCenter
import com.oftenenough.app.app.account.AccountFile
import com.oftenenough.app.app.account.AccountPlus
import com.oftenenough.app.app.account.Answer
import com.oftenenough.app.app.account.EmailWords
import com.oftenenough.app.app.account.InviteLink
import com.oftenenough.app.app.account.InviteLook
import com.oftenenough.app.app.account.PlayPurchase
import com.oftenenough.app.app.account.SignIn
import com.oftenenough.app.app.account.SignInReply
import com.oftenenough.app.app.account.SignInWith
import com.oftenenough.app.app.account.StandInAccountServer
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Test

/**
 * The Plus account's rules (Rulebook D15, D16; Current Work 110), on the Worker's stand-in: the same rules the Worker
 * keeps. One account per Google or Apple account; a family of six at most; an invite works once, for 7 days; joining
 * another family leaves the first; deleting an owner ends the family; every call is safe to repeat.
 */
class PlusAccountTest {
    private var today = 20_000L
    private val serverPrefs = MemoryPrefs()
    private val server = StandInAccountServer(serverPrefs) { today }
    private fun center() = AccountCenter(MemoryPrefs(), server)
    private fun google(email: String, name: String) = SignIn(SignInWith.GOOGLE, "stand-in", email, name)
    private val family = PlayPurchase("com.oftenenough.app.plusfamily", "t")
    private val plus = PlayPurchase("com.oftenenough.app.plus", "t")

    private fun <T> Answer<T>.ok(): T = (this as Answer.Ok<T>).value

    @Test fun signingInWithNoAccountFindsNone_andMakingOneTwiceMakesOne() = runTest {
        val sam = google("sam@gmail.com", "Sam")
        val c = center()
        assertEquals(SignInReply.NoAccount, c.signIn(sam).ok())
        val first = c.create(sam, plus).ok()
        val again = c.create(sam, plus).ok()
        assertEquals("a repeat never makes two accounts", first.id, again.id)
        assertEquals(AccountPlus.PLUS, again.plus)
        val other = center()
        assertTrue("another phone finds it", other.signIn(sam).ok() is SignInReply.Found)
        assertEquals(AccountPlus.PLUS, other.account?.plus)
    }

    @Test fun aFamilyIsSixAtMost_andAnInviteWorksOnce() = runTest {
        val lee = center().also { it.create(google("lee@gmail.com", "Lee"), family) }
        assertEquals(5, lee.account!!.family!!.placesFree)
        val joined = mutableListOf<AccountCenter>()
        for (i in 1..5) {
            val token = lee.invite().ok().family!!.invite!!.token
            assertEquals("one invite at a time", token, lee.invite().ok().family!!.invite!!.token)
            val p = center().also { it.create(google("p$i@gmail.com", "P$i"), null) }
            assertTrue(p.lookInvite(token).ok() is InviteLook.Open)
            assertEquals(AccountPlus.FAMILY_MEMBER, p.join(token).ok().plus)
            assertEquals("joining twice keeps one place", AccountPlus.FAMILY_MEMBER, p.join(token).ok().plus)
            assertTrue("used once", p.lookInvite(token).ok() is InviteLook.Used)
            joined += p
        }
        lee.refresh()
        assertEquals(6, lee.account!!.family!!.people.size)
        assertEquals(0, lee.account!!.family!!.placesFree)
        assertNull("no room, no invite", lee.invite().ok().family!!.invite)
        assertEquals("Lee", joined[0].account!!.family!!.ownerName)
    }

    @Test fun anInviteEnds_isCancelled_orFindsTheFamilyFull() = runTest {
        val lee = center().also { it.create(google("lee@gmail.com", "Lee"), family) }
        val token = lee.invite().ok().family!!.invite!!.token
        today += 8
        assertTrue(center().lookInvite(token).ok() is InviteLook.Ended)
        val again = lee.invite().ok().family!!.invite!!.token
        lee.cancelInvite()
        val priya = center().also { it.create(google("priya@gmail.com", "Priya"), null) }
        assertTrue(priya.lookInvite(again).ok() is InviteLook.Cancelled)
        assertEquals("a cancelled invite gives nothing", AccountPlus.NONE, priya.join(again).ok().plus)
        val full = server.seedFamily("Ana", "ana@gmail.com", (1..5).map { "M$it" to "m$it@gmail.com" })
        assertTrue(priya.lookInvite(full).ok() is InviteLook.Full)
    }

    @Test fun joiningAnotherFamilyLeavesTheFirst_andLeavingKeepsNothingButTheAccount() = runTest {
        val sam = server.seedFamily("Sam", "sam@gmail.com")
        val lee = server.seedFamily("Lee", "lee@gmail.com")
        val priya = center().also { it.create(google("priya@gmail.com", "Priya"), null) }
        priya.join(sam)
        assertEquals("Sam", priya.account!!.family!!.ownerName)
        priya.join(lee)
        assertEquals("Lee", priya.account!!.family!!.ownerName)
        val samView = center().also { it.signIn(google("sam@gmail.com", "Sam")) }
        assertEquals("Sam's family no longer lists her", 1, samView.account!!.family!!.people.size)
        priya.leave()
        assertEquals(AccountPlus.NONE, priya.account!!.plus)
        assertNull(priya.account!!.family)
    }

    @Test fun deletingAnOwnerEndsTheFamily_andNeedsTheSameAccountToConfirm() = runTest {
        val leeProof = google("lee@gmail.com", "Lee")
        val lee = center().also { it.create(leeProof, family) }
        val token = lee.invite().ok().family!!.invite!!.token
        val priya = center().also { it.create(google("priya@gmail.com", "Priya"), null); it.join(token) }
        assertFalse("another account can't delete it", lee.delete(google("someone@gmail.com", "X")).ok())
        assertNotNull(lee.account)
        assertTrue(lee.delete(leeProof).ok())
        assertNull("signed out once deleted", lee.account)
        priya.refresh()
        assertEquals("the family's Plus ends; the account stays", AccountPlus.NONE, priya.account!!.plus)
        assertTrue("Lee can make a new account later", center().signIn(leeProof).ok() is SignInReply.NoAccount)
    }

    @Test fun offlineChangesNothing_andSignOutKeepsNothingOnThePhone() = runTest {
        val c = center()
        c.create(google("sam@gmail.com", "Sam"), family)
        server.offline = true
        assertEquals(Answer.Offline, c.invite())
        c.refresh()
        assertEquals("kept as it was while offline", AccountPlus.FAMILY_OWNER, c.account!!.plus)
        server.offline = false
        c.signOut()
        assertNull(c.account)
    }

    @Test fun aPlayPurchaseReachesTheAccountOnce() = runTest {
        val c = center()
        c.create(google("sam@gmail.com", "Sam"), null)
        assertEquals(AccountPlus.NONE, c.account!!.plus)
        c.syncPurchase(plus)
        assertEquals(AccountPlus.PLUS, c.account!!.plus)
        c.syncPurchase(family)
        assertEquals(AccountPlus.FAMILY_OWNER, c.account!!.plus)
        c.syncPurchase(family)
        assertEquals("one family", 1, c.account!!.family!!.people.size)
    }

    @Test fun theAccountFileRoundTrips() = runTest {
        val c = center()
        c.create(google("lee@gmail.com", "Lee"), family)
        c.invite()
        val a = c.account!!
        assertEquals(a, AccountFile.decode(AccountFile.encode(a)))
        val prefs = MemoryPrefs()
        AccountFile.write(prefs, a)
        assertEquals(a, AccountFile.read(prefs))
    }

    @Test fun inviteLinksAndEmails() {
        assertEquals("abcdefgh12", InviteLink.token("https://oftenenough.com/join/abcdefgh12"))
        assertEquals("abcdefgh12", InviteLink.token("https://oftenenough.com/join/abcdefgh12?utm=x"))
        assertNull(InviteLink.token("https://example.com/join/abcdefgh12"))
        assertNull(InviteLink.token("https://oftenenough.com/join/a b"))
        assertNull(InviteLink.token(null))
        assertEquals("alexa…@gmail.com", EmailWords.short("alexandra.montgomery@gmail.com"))
        assertEquals("sam@gmail.com", EmailWords.short("sam@gmail.com"))
    }

    @Test fun aCodeUnlocksPlusWhateverItsCaseOrDashes_andAWrongOneDoesNot() {
        val good = com.oftenenough.app.app.PlusCodes.fingerprint("K7QF2M9XTR4B")
        val prefs = MemoryPrefs()
        val codes = com.oftenenough.app.app.PlusCodes(prefs, setOf(good))
        assertFalse(codes.redeem("K7QF2M9XTR4C"))
        assertFalse(codes.redeemed)
        assertTrue("case, spaces and dashes don't matter", codes.redeem(" k7qf-2m9x-tr4b "))
        assertTrue(codes.redeemed)
        assertTrue("kept after a restart", com.oftenenough.app.app.PlusCodes(prefs, setOf(good)).redeemed)
        assertFalse("a retired code turns it off", com.oftenenough.app.app.PlusCodes(prefs, emptySet()).redeemed)
    }
}
