package com.oftenenough.app

import app.habits.account.Account
import app.habits.account.AccountPlus
import app.habits.account.Answer
import app.habits.account.HttpAccountServer
import app.habits.account.InviteLook
import com.oftenenough.app.app.account.Nonce
import com.oftenenough.app.app.account.androidAccountServer
import app.habits.account.StorePurchase
import app.habits.account.SignIn
import app.habits.account.SignInReply
import app.habits.account.SignInWith
import com.sun.net.httpserver.HttpServer
import kotlinx.coroutines.test.runTest
import org.json.JSONObject
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Before
import org.junit.Test
import java.net.InetSocketAddress

/**
 * The app's client for the account Worker ([HttpAccountServer]) against a small local server that answers as the Worker
 * does (account-server/src/worker.ts): what it sends, and how it reads every kind of answer, failures included.
 */
class HttpAccountServerTest {
    private lateinit var http: HttpServer
    private lateinit var client: HttpAccountServer
    /** What the next request is answered with, by "METHOD /path". */
    private val answers = mutableMapOf<String, Pair<Int, String>>()
    /** Every request seen: method, path, authorization header, body. */
    private val seen = mutableListOf<Triple<String, String?, JSONObject?>>()

    @Before fun start() {
        http = HttpServer.create(InetSocketAddress("127.0.0.1", 0), 0)
        http.createContext("/") { ex ->
            val body = ex.requestBody.readBytes().toString(Charsets.UTF_8)
            val key = "${ex.requestMethod} ${ex.requestURI.path}"
            seen += Triple(key, ex.requestHeaders.getFirst("authorization"), body.takeIf { it.isNotBlank() }?.let { JSONObject(it) })
            val (status, text) = answers[key] ?: (404 to """{"error":"not_found"}""")
            val bytes = text.toByteArray()
            ex.responseHeaders.add("content-type", "application/json")
            ex.sendResponseHeaders(status, if (bytes.isEmpty()) -1 else bytes.size.toLong())
            if (bytes.isNotEmpty()) ex.responseBody.use { it.write(bytes) } else ex.close()
        }
        http.start()
        client = androidAccountServer("http://127.0.0.1:${http.address.port}", timeoutMs = 2_000)
    }

    @After fun stop() = http.stop(0)

    private val sam = SignIn(SignInWith.GOOGLE, "google-id-token", "sam@gmail.com", "Sam", "raw-nonce")
    private val familyJson = """{"id":"acc-lee","plus":"FAMILY_OWNER","family":{"owner":"Lee","people":[
        {"id":"acc-lee","name":"Lee","owner":true,"you":true,"joinedDay":null},
        {"id":"acc-priya","name":"Priya","owner":false,"you":false,"joinedDay":20376}],
        "invite":{"token":"AbCdEfGhIjKlMnOpQrStUv","link":"https://oftenenough.com/join/AbCdEfGhIjKlMnOpQrStUv","endsDay":20383}}}"""
    private fun signedIn(plus: AccountPlus = AccountPlus.NONE) = Account("acc-1", SignInWith.GOOGLE, "sam@gmail.com", plus, null, "session-token-0123456789abcdef")

    @Test fun signingInSendsGooglesTokenAndTheNonce_andKeepsTheSession() = runTest {
        answers["POST /v1/sign-in"] = 200 to """{"found":false}"""
        assertEquals(SignInReply.NoAccount, (client.signIn(sam) as Answer.Ok).value)
        val sent = seen.last().third!!
        assertEquals("google", sent.getString("provider"))
        assertEquals("google-id-token", sent.getString("idToken"))
        assertEquals("raw-nonce", sent.getString("nonce"))
        assertNull("no session before signing in", seen.last().second)

        answers["POST /v1/sign-in"] = 200 to """{"found":true,"session":"new-session-token-abcdefghij","account":$familyJson}"""
        val found = ((client.signIn(sam) as Answer.Ok).value as SignInReply.Found).account
        assertEquals("new-session-token-abcdefghij", found.session)
        assertEquals("sam@gmail.com", found.email) // the phone's own, never the server's
        assertEquals(AccountPlus.FAMILY_OWNER, found.plus)
        assertEquals(listOf("Lee", "Priya"), found.family!!.people.map { it.name })
        assertNull(found.family!!.people[0].joinedDay)
        assertEquals(20376L, found.family!!.people[1].joinedDay)
        assertEquals("https://oftenenough.com/join/AbCdEfGhIjKlMnOpQrStUv", found.family!!.invite!!.link)
        assertEquals(20383L, found.family!!.invite!!.endsDay)
    }

    @Test fun makingAnAccountSendsThePurchase() = runTest {
        answers["POST /v1/accounts"] = 200 to """{"session":"s-0123456789abcdefghij","account":{"id":"acc-1","plus":"PLUS","family":null}}"""
        val made = (client.create(sam, StorePurchase("com.oftenenough.app.plus", "play-token")) as Answer.Ok).value
        assertEquals(AccountPlus.PLUS, made.plus)
        val sent = seen.last().third!!.getJSONObject("purchase")
        assertEquals("com.oftenenough.app.plus", sent.getString("product"))
        assertEquals("play-token", sent.getString("token"))
    }

    @Test fun everyCallAfterSignInCarriesTheSession() = runTest {
        val a = signedIn()
        answers["GET /v1/account"] = 200 to """{"account":{"id":"acc-1","plus":"NONE","family":null}}"""
        answers["POST /v1/family/invite"] = 200 to """{"account":$familyJson}"""
        answers["POST /v1/family/remove"] = 200 to """{"account":$familyJson}"""
        client.refresh(a); client.invite(a); client.remove(a, "acc-priya")
        assertTrue(seen.all { it.second == "Bearer session-token-0123456789abcdef" })
        assertEquals("acc-priya", seen.last().third!!.getString("person"))
        // The changed account keeps this device's session and email.
        val after = (client.invite(a) as Answer.Ok).value
        assertEquals(a.session, after.session)
        assertEquals(a.email, after.email)
    }

    @Test fun aSessionTheServerNoLongerKnowsSignsThePhoneOut() = runTest {
        answers["GET /v1/account"] = 401 to """{"error":"signed_out"}"""
        assertEquals(Answer.Ok(null), client.refresh(signedIn()))
    }

    @Test fun failuresAreCouldntConnect_andChangeNothing() = runTest {
        val a = signedIn(AccountPlus.PLUS)
        for (status in listOf(500, 503, 429)) {
            answers["POST /v1/family/invite"] = status to """{"error":"x"}"""
            assertEquals("HTTP $status", Answer.Offline, client.invite(a))
            answers["GET /v1/account"] = status to """{"error":"x"}"""
            assertEquals("HTTP $status", Answer.Offline, client.refresh(a))
        }
        // Nothing listening at all.
        val nowhere = androidAccountServer("http://127.0.0.1:9", timeoutMs = 1_000)
        assertEquals(Answer.Offline, nowhere.signIn(sam))
        assertEquals(Answer.Offline, nowhere.refresh(a))
        // An answer that isn't the Worker's.
        answers["POST /v1/sign-in"] = 200 to "not json"
        assertEquals(Answer.Offline, client.signIn(sam))
    }

    @Test fun deletingSaysWhetherItWasDeleted() = runTest {
        val a = signedIn()
        answers["POST /v1/account/delete"] = 200 to """{"deleted":true}"""
        assertEquals(Answer.Ok(true), client.delete(a, sam))
        assertEquals("the fresh proof goes with it", "google-id-token", seen.last().third!!.getString("idToken"))
        answers["POST /v1/account/delete"] = 403 to """{"error":"wrong_account"}"""
        assertEquals(Answer.Ok(false), client.delete(a, sam))
        answers["POST /v1/account/delete"] = 503 to """{"error":"x"}"""
        assertEquals(Answer.Offline, client.delete(a, sam))
    }

    @Test fun invitesReadAsTheScreensNeed() = runTest {
        val token = "AbCdEfGhIjKlMnOpQrStUv"
        for ((state, kind) in listOf("open" to InviteLook.Open::class, "ended" to InviteLook.Ended::class, "used" to InviteLook.Used::class,
            "cancelled" to InviteLook.Cancelled::class, "full" to InviteLook.Full::class)) {
            answers["GET /v1/invites/$token"] = 200 to """{"state":"$state","owner":"Lee"}"""
            val look = (client.lookInvite(token) as Answer.Ok).value!!
            assertEquals(kind, look::class)
            assertEquals("Lee", look.ownerName)
        }
        answers["GET /v1/invites/$token"] = 404 to """{"error":"no_invite"}"""
        assertNull((client.lookInvite(token) as Answer.Ok).value)
        // A token that isn't one of ours never leaves the phone.
        val before = seen.size
        assertNull((client.lookInvite("../../v1/account") as Answer.Ok).value)
        assertEquals(before, seen.size)
        answers["POST /v1/invites/$token/join"] = 200 to """{"account":{"id":"acc-1","plus":"FAMILY_MEMBER","family":null}}"""
        assertEquals(AccountPlus.FAMILY_MEMBER, (client.join(signedIn(), token) as Answer.Ok).value.plus)
    }

    @Test fun signingOutEndsTheSessionOnTheServer() = runTest {
        answers["POST /v1/sign-out"] = 204 to ""
        client.signOut(signedIn())
        assertEquals("POST /v1/sign-out", seen.last().first)
        assertEquals("Bearer session-token-0123456789abcdef", seen.last().second)
    }

    @Test fun theNonceIsRandom_andItsHashIsWhatGoogleCarries() {
        val a = Nonce.make()
        assertFalse(a == Nonce.make())
        assertTrue(a.length >= 43)
        // SHA-256 of "abc", lowercase hex (what the Worker computes).
        assertEquals("ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad", Nonce.hash("abc"))
    }

    @Test fun theDevTestSignInSendsTheSecretNotAGoogleToken() = runTest {
        answers["POST /v1/sign-in"] = 200 to """{"found":false}"""
        client.signIn(SignIn(SignInWith.GOOGLE, HttpAccountServer.TEST_PREFIX + "s3cret", "tess-1", "Tess"))
        val sent = seen.last().third!!
        assertEquals("test", sent.getString("provider"))
        assertEquals("s3cret", sent.getString("secret"))
        assertEquals("tess-1", sent.getString("subject"))
        assertFalse(sent.has("idToken"))
    }

    @Test fun theAccountFileKeepsTheSession() {
        val a = signedIn().copy(session = "kept-session-token-0123456789")
        val back = app.habits.account.AccountFile.decode(app.habits.account.AccountFile.encode(a))
        assertEquals(a, back)
        // An account file from before sessions reads as no session.
        val old = """{"id":"acc-1","with":"GOOGLE","email":"sam@gmail.com","plus":"PLUS"}"""
        assertEquals("", app.habits.account.AccountFile.decode(old)!!.session)
    }
}
