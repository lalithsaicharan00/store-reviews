// TO BE DELETED (the user, 21 Oct 2026): no accounts; Plus moves between iPhone and Android by hand. The server side was deleted the same day (account-server/README.md, "The accounts, deleted 21 Oct 2026").
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

    // ------------------------------------------------------------------ Where the habits live (D16, Current Work 138)

    @Test fun googleDrivesPrivateIdIsTheSameAsTheWorkers() {
        // The Worker's googleDriveKey: "gdrive:" + SHA-256("google:" + sub), hex. Never an email.
        val sha = java.security.MessageDigest.getInstance("SHA-256").digest("google:1098765432101234567890".toByteArray())
        assertEquals("gdrive:" + sha.joinToString("") { "%02x".format(it) }, CloudKeys.googleDrive("1098765432101234567890"))
        assertTrue(CloudKeys.googleDrive("x").matches(Regex("gdrive:[0-9a-f]{64}")))
    }

    @Test fun theWorkerIsToldWhereTheHabitsAreAndItsAnswerIsRead() = runTest {
        val cloudJson = """{"id":"a1","plus":"PLUS","family":null,"cloud":{"kind":"icloud","key":"icloud:_abc","device":"iphone","syncedAt":1760000000000,"signInAccount":false}}"""
        val http = FakeHttp(ok("""{"account":$cloudJson}"""), ok("""{"account":$accountJson}"""))
        val server = HttpAccountServer("https://api.test", http)
        val me = Account("a1", SignInWith.GOOGLE, "sam@gmail.com", AccountPlus.PLUS, null, "s1")
        val drive = CloudPlace(CloudKind.GOOGLE_DRIVE, CloudKeys.googleDrive("g1"), CloudDevice.ANDROID)
        val told = (server.setCloud(me, drive) as Answer.Ok).value
        assertEquals(CloudRecord(CloudPlace(CloudKind.ICLOUD, "icloud:_abc", CloudDevice.IPHONE), 1760000000000, false), told.cloud)
        val sent = Json.parseToJsonElement(http.sent[0].body!!).jsonObject
        assertEquals("/v1/account/cloud", http.sent[0].url.removePrefix("https://api.test"))
        assertEquals("s1", http.sent[0].session)
        assertEquals(mapOf("cloud" to "google_drive", "key" to drive.key, "device" to "android"), sent.mapValues { it.value.jsonPrimitive.content })
        assertNull((server.setCloud(me, null) as Answer.Ok).value.cloud)
        assertEquals("null", Json.parseToJsonElement(http.sent[1].body!!).jsonObject["cloud"].toString())
        // A kind of cloud or device this version doesn't know reads as nothing, never a crash.
        assertNull(HttpAccountServer.cloud(Json.parseToJsonElement("""{"kind":"dropbox","key":"d:1","device":"android","syncedAt":1}""").jsonObject))
        assertNull(HttpAccountServer.cloud(Json.parseToJsonElement("""{"kind":"icloud","key":"icloud:1","device":"mac","syncedAt":1}""").jsonObject))
    }

    @Test fun theRecordIsKeptOnTheDeviceWithTheAccount() {
        val a = Account("a1", SignInWith.APPLE, "x@privaterelay.appleid.com", AccountPlus.PLUS, null, "s1",
            CloudRecord(CloudPlace(CloudKind.ICLOUD, "icloud:_abc", CloudDevice.IPAD), 1760000000000, false))
        assertEquals(a, AccountFile.decode(AccountFile.encode(a)))
        val none = a.copy(cloud = null)
        assertEquals(none, AccountFile.decode(AccountFile.encode(none)))
    }

    @Test fun aDeviceTellsTheAccountOnlyWhenThePlaceChangesOrOnceADay() = runTest {
        val http = FakeHttp(*Array(6) { ok("""{"account":{"id":"a1","plus":"PLUS","family":null,"cloud":{"kind":"google_drive","key":"${CloudKeys.googleDrive("g1")}","device":"android","syncedAt":1000,"signInAccount":true}}}""") })
        val storage = Memory(AccountFile.encode(Account("a1", SignInWith.GOOGLE, "sam@gmail.com", AccountPlus.PLUS, null, "s1")))
        val center = AccountCenter(storage, HttpAccountServer("https://api.test", http))
        val drive = CloudPlace(CloudKind.GOOGLE_DRIVE, CloudKeys.googleDrive("g1"), CloudDevice.ANDROID)
        center.noteCloud(drive, nowMs = 1000)
        assertEquals(1, http.sent.size)
        assertTrue(center.account!!.cloud!!.signInAccount)
        center.noteCloud(drive, nowMs = 1000 + 60_000)
        center.noteCloud(drive, nowMs = 1000 + AccountCenter.CLOUD_EVERY_MS - 1)
        assertEquals(1, http.sent.size, "the same place within a day isn't sent again")
        center.noteCloud(drive, nowMs = 1000 + AccountCenter.CLOUD_EVERY_MS)
        assertEquals(2, http.sent.size, "once a day, so the account says when it last synced")
        center.noteCloud(drive.copy(key = CloudKeys.googleDrive("g2")), nowMs = 2000)
        assertEquals(3, http.sent.size, "another Google account is sent at once")
        center.noteCloud(null, nowMs = 3000)
        assertEquals(4, http.sent.size, "the Drive copy deleted: the account forgets it")
        // No account (free): nothing is ever sent.
        val free = AccountCenter(Memory(), HttpAccountServer("https://api.test", http))
        free.noteCloud(drive, nowMs = 1000)
        assertEquals(4, http.sent.size)
    }

    @Test fun theStandInKnowsItsOwnGoogleAccountsDriveAndNeverAnAppleOnes() = runTest {
        val standIn = StandInAccountServer(Memory(), today = { 20000 }, nowMs = { 1_728_000_000_000 })
        val sam = (standIn.create(google, null) as Answer.Ok).value
        assertNull(sam.cloud)
        val own = (standIn.setCloud(sam, CloudPlace(CloudKind.GOOGLE_DRIVE, StandInAccountServer.driveKey("Sam@gmail.com"), CloudDevice.ANDROID)) as Answer.Ok).value
        assertTrue(own.cloud!!.signInAccount)
        assertEquals(1_728_000_000_000, own.cloud!!.syncedAt)
        val other = (standIn.setCloud(sam, CloudPlace(CloudKind.GOOGLE_DRIVE, StandInAccountServer.driveKey("work@gmail.com"), CloudDevice.ANDROID)) as Answer.Ok).value
        assertFalse(other.cloud!!.signInAccount)
        // A new phone signing in is told where they are.
        val found = (standIn.signIn(google) as Answer.Ok).value as SignInReply.Found
        assertEquals(other.cloud, found.account.cloud)
        val apple = (standIn.create(SignIn(SignInWith.APPLE, "t", "sam@gmail.com", "Sam"), null) as Answer.Ok).value
        assertFalse((standIn.setCloud(apple, CloudPlace(CloudKind.GOOGLE_DRIVE, StandInAccountServer.driveKey("sam@gmail.com"), CloudDevice.ANDROID)) as Answer.Ok).value.cloud!!.signInAccount)
        assertNull((standIn.setCloud(apple, null) as Answer.Ok).value.cloud)
    }

    @Test fun inviteLinksAreReadFromALinkAQrCodeOrATypedCode() {
        assertEquals("abcdefgh12", InviteLink.token("https://oftenenough.com/join/abcdefgh12?x=1"))
        assertEquals("abcdefgh12", InviteLink.token(" oftenenough.com/join/abcdefgh12 "))
        assertNull(InviteLink.token("https://example.com/join/abcdefgh12"))
        assertNull(InviteLink.token("https://oftenenough.com/join/short"))
        assertEquals("alexa…@gmail.com", EmailWords.short("alexandra.montgomery@gmail.com"))
    }
}
