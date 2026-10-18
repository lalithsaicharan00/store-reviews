package app.habits.account

import kotlinx.coroutines.test.runTest
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertFalse
import kotlin.test.assertIs
import kotlin.test.assertNull
import kotlin.test.assertTrue

/** The shared Plus account (Core `app.habits.account`): the file, the Worker's protocol, the device's state, the stand-in. */
class AccountTest {
    private class Memory(var text: String? = null) : AccountStorage {
        override fun read() = text
        override fun write(text: String?) { this.text = text }
    }

    private val google = SignIn(SignInWith.GOOGLE, "id-token", "sam@gmail.com", "Sam", "nonce-1")

    // ------------------------------------------------------------------ The file on the device

    @Test fun anAccountSavedByTheAndroidAppBeforeTheMoveStillLoads() {
        // Exactly what Android's org.json wrote (no "family" key for none; "joined": -1 for the owner).
        val old = """{"id":"a1","with":"GOOGLE","email":"sam@gmail.com","session":"s1","plus":"FAMILY_OWNER","family":{"owner":"Sam",""" +
            """"people":[{"id":"a1","name":"Sam","owner":true,"you":true,"joined":-1},{"id":"b2","name":"Priya","owner":false,"you":false,"joined":20377}],""" +
            """"invite":{"token":"abcdefgh12","link":"https://oftenenough.com/join/abcdefgh12","ends":20384}}}"""
        val a = AccountFile.decode(old)!!
        assertEquals(AccountPlus.FAMILY_OWNER, a.plus)
        assertEquals("s1", a.session)
        assertEquals(listOf(null, 20377L), a.family!!.people.map { it.joinedDay })
        assertEquals(20384L, a.family!!.invite!!.endsDay)
        assertEquals(a, AccountFile.decode(AccountFile.encode(a)))
        val noFamily = AccountFile.decode("""{"id":"a1","with":"APPLE","email":"x@privaterelay.appleid.com","plus":"NONE"}""")!!
        assertEquals("", noFamily.session)
        assertNull(noFamily.family)
        assertNull(AccountFile.decode("not json"))
        assertNull(AccountFile.decode(null))
    }

    // ------------------------------------------------------------------ The Worker's protocol

    /** The Worker, as a list of answers; records every request. Null answers mean "no answer came". */
    private class FakeHttp(vararg answers: AccountResponse?) : AccountHttp {
        val queue = ArrayDeque(answers.toList())
        val sent = mutableListOf<AccountRequest>()
        override suspend fun send(request: AccountRequest): AccountResponse? { sent += request; return queue.removeFirstOrNull() }
    }

    private fun ok(json: String) = AccountResponse(200, json)
    private val accountJson = """{"id":"a1","plus":"PLUS","family":null}"""

    @Test fun signInFindsTheAccountOrSaysThereIsNone() = runTest {
        val http = FakeHttp(ok("""{"found":true,"session":"s9","account":$accountJson}"""), ok("""{"found":false}"""))
        val server = HttpAccountServer("https://api.test", http)
        val found = server.signIn(google)
        assertEquals(Account("a1", SignInWith.GOOGLE, "sam@gmail.com", AccountPlus.PLUS, null, "s9"), ((found as Answer.Ok).value as SignInReply.Found).account)
        assertEquals(SignInReply.NoAccount, (server.signIn(google) as Answer.Ok).value)
        val body = Json.parseToJsonElement(http.sent[0].body!!).jsonObject
        assertEquals("google", body["provider"]!!.jsonPrimitive.content)
        assertEquals("nonce-1", body["nonce"]!!.jsonPrimitive.content)
        assertEquals("https://api.test/v1/sign-in", http.sent[0].url)
    }

    @Test fun creatingSendsThePurchaseAndEveryCallCarriesTheSession() = runTest {
        val http = FakeHttp(ok("""{"session":"s1","account":$accountJson}"""), ok("""{"account":$accountJson}"""))
        val server = HttpAccountServer("https://api.test", http)
        val made = (server.create(google, StorePurchase(PlusProducts.PLUS, "tok")) as Answer.Ok).value
        val purchase = Json.parseToJsonElement(http.sent[0].body!!).jsonObject["purchase"]!!.jsonObject
        assertEquals(PlusProducts.PLUS, purchase["product"]!!.jsonPrimitive.content)
        server.invite(made)
        assertEquals("s1", http.sent[1].session)
        assertEquals("https://api.test/v1/family/invite", http.sent[1].url)
    }

    @Test fun aLostAnswerIsTriedOnceMoreThenItSaysCouldNotConnect() = runTest {
        val account = Account("a1", SignInWith.GOOGLE, "sam@gmail.com", AccountPlus.NONE, null, "s1")
        val once = FakeHttp(null, ok("""{"account":$accountJson}"""))
        assertIs<Answer.Ok<Account?>>(HttpAccountServer("https://api.test", once).refresh(account))
        assertEquals(2, once.sent.size)
        assertEquals(Answer.Offline, HttpAccountServer("https://api.test", FakeHttp(null, null)).refresh(account))
        // Anything but 200 changes nothing: "Couldn't connect".
        assertEquals(Answer.Offline, HttpAccountServer("https://api.test", FakeHttp(AccountResponse(503, """{"error":"store_unavailable"}"""))).invite(account))
    }

    @Test fun aSessionTheWorkerNoLongerKnowsSignsTheDeviceOut() = runTest {
        val account = Account("a1", SignInWith.GOOGLE, "sam@gmail.com", AccountPlus.PLUS, null, "gone")
        assertEquals(Answer.Ok(null), HttpAccountServer("https://api.test", FakeHttp(AccountResponse(401, ""))).refresh(account))
    }

    @Test fun invitesReadTheirStateAndAMadeUpTokenNeverReachesTheWorker() = runTest {
        val http = FakeHttp(ok("""{"state":"full","owner":"Lee"}"""), AccountResponse(404, """{"error":"no_invite"}"""))
        val server = HttpAccountServer("https://api.test", http)
        assertEquals(InviteLook.Full("Lee"), (server.lookInvite("abcdefgh12") as Answer.Ok).value)
        assertNull((server.lookInvite("abcdefgh13") as Answer.Ok).value)
        assertNull((server.lookInvite("bad token!") as Answer.Ok).value)
        assertEquals(2, http.sent.size)
    }

    @Test fun theWorkersFamilyIsReadWithTheOwnersNullJoinDay() {
        val o = Json.parseToJsonElement("""{"id":"a1","plus":"FAMILY_OWNER","family":{"owner":"Lee","people":[""" +
            """{"id":"a1","name":"Lee","owner":true,"you":true,"joinedDay":null},{"id":"b2","name":"Priya","owner":false,"you":false,"joinedDay":20377}],""" +
            """"invite":{"token":"abcdefgh12","link":"https://oftenenough.com/join/abcdefgh12","endsDay":20384}}}""").jsonObject
        val a = HttpAccountServer.parse(o, SignInWith.GOOGLE, "lee@gmail.com", "s1")
        assertEquals(listOf(null, 20377L), a.family!!.people.map { it.joinedDay })
        assertEquals(3, a.family!!.placesFree) // six, less two people and the waiting invite
    }

    // ------------------------------------------------------------------ The device's state

    @Test fun theDeviceKeepsTheAccountOnlyOnceTheServerAgreed() = runTest {
        val storage = Memory()
        val standIn = StandInAccountServer(Memory(), today = { 20000 })
        val center = AccountCenter(storage, standIn)
        standIn.offline = true
        assertEquals(Answer.Offline, center.create(google, null as StorePurchase?))
        assertNull(center.account)
        assertNull(storage.text)
        standIn.offline = false
        center.create(google, null as StorePurchase?)
        assertEquals("sam@gmail.com", center.account!!.email)
        assertEquals(center.account, AccountFile.decode(storage.text)) // saved, so it's there after a restart
        assertEquals(center.account, AccountCenter(storage, standIn).account)
        center.signOut()
        assertNull(center.account)
        assertNull(storage.text)
    }

    @Test fun purchasesGoPlusFirstAndOnlyWhatTheAccountDoesntShowYet() = runTest {
        val standIn = StandInAccountServer(Memory(), today = { 20000 })
        val center = AccountCenter(Memory(), standIn)
        center.create(google, listOf(StorePurchase(PlusProducts.PLUS, "p1"), StorePurchase(PlusProducts.FAMILY_UPGRADE, "u1")))
        assertEquals(AccountPlus.FAMILY_OWNER, center.account!!.plus)
        assertFalse(PlusProducts.missingFrom(center.account!!, PlusProducts.FAMILY_UPGRADE))
        assertFalse(PlusProducts.missingFrom(center.account!!, PlusProducts.PLUS))
    }

    // ------------------------------------------------------------------ The stand-in keeps the Worker's rules

    @Test fun theUpgradeAloneGivesNothingAndMakesAFamilyBesidePlus() = runTest {
        val standIn = StandInAccountServer(Memory(), today = { 20000 })
        val a = (standIn.create(google, StorePurchase(PlusProducts.FAMILY_UPGRADE, "u1")) as Answer.Ok).value
        assertEquals(AccountPlus.NONE, a.plus)
        val withPlus = (standIn.addPurchase(a, StorePurchase(PlusProducts.PLUS, "p1")) as Answer.Ok).value
        assertEquals(AccountPlus.PLUS, withPlus.plus)
        assertEquals(AccountPlus.FAMILY_OWNER, (standIn.addPurchase(withPlus, StorePurchase(PlusProducts.FAMILY_UPGRADE, "u1")) as Answer.Ok).value.plus)
    }

    @Test fun aFamilyIsSixAtMostAndJoiningTwiceKeepsThePlace() = runTest {
        val storage = Memory()
        val standIn = StandInAccountServer(storage, today = { 20000 })
        val token = standIn.seedFamily("Lee", "lee@gmail.com", (1..4).map { "M$it" to "m$it@gmail.com" })
        val priya = (standIn.create(SignIn(SignInWith.GOOGLE, "t", "priya@gmail.com", "Priya"), null) as Answer.Ok).value
        val joined = (standIn.join(priya, token) as Answer.Ok).value
        assertEquals(AccountPlus.FAMILY_MEMBER, joined.plus)
        assertEquals(6, joined.family!!.people.size)
        assertEquals(joined, (standIn.join(joined, token) as Answer.Ok).value)
        // The family is full: a new invite isn't made, and it says so when opened.
        assertTrue(StandInAccountServer(storage, today = { 20000 }).let { it.lookInvite(token) } is Answer.Ok)
    }

    @Test fun inviteLinksAreReadFromALinkAQrCodeOrATypedCode() {
        assertEquals("abcdefgh12", InviteLink.token("https://oftenenough.com/join/abcdefgh12?x=1"))
        assertEquals("abcdefgh12", InviteLink.token(" oftenenough.com/join/abcdefgh12 "))
        assertNull(InviteLink.token("https://example.com/join/abcdefgh12"))
        assertNull(InviteLink.token("https://oftenenough.com/join/short"))
        assertEquals("alexa…@gmail.com", EmailWords.short("alexandra.montgomery@gmail.com"))
    }
}
