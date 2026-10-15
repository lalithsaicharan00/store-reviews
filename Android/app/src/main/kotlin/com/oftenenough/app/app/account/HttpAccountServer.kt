package com.oftenenough.app.app.account

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import org.json.JSONArray
import org.json.JSONObject
import java.io.IOException
import java.net.HttpURLConnection
import java.net.URL

/**
 * The real account server: the Cloudflare Worker in `account-server/` (Rulebook D16, Current Work 110). Debug builds
 * talk to dev (api-dev.oftenenough.com), release builds to production (api.oftenenough.com). Sign-in hands back a
 * session token for this device, kept with the account on this phone ([Account.session]) and sent with every call.
 *
 * Answers: anything the Worker couldn't do (no network, a server error, too many tries, Google Play not reachable) is
 * [Answer.Offline], so the screens say "Couldn't connect" and nothing changes; a session the Worker no longer knows
 * (signed out elsewhere, the account deleted) makes [refresh] answer null, and the phone signs out.
 */
class HttpAccountServer(private val base: String, private val timeoutMs: Int = 15_000) : AccountServer {
    override val available = true

    /** What a call came back with: a status and its JSON, or no answer at all. */
    private class Reply(val status: Int, val body: JSONObject?)

    /**
     * One call, tried a second time if the connection dropped (a kept-alive connection the network or Cloudflare had
     * already closed: "connection abort", seen on the emulator). Every Worker call is safe to repeat.
     */
    private suspend fun call(method: String, path: String, session: String? = null, body: JSONObject? = null): Reply? =
        (once(method, path, session, body) ?: once(method, path, session, body)).also { r ->
            // Debug builds: which call answered what (never a token: invite tokens are cut from the path).
            if (com.oftenenough.app.BuildConfig.DEBUG) android.util.Log.d("AccountServer", "$method ${path.replace(Regex("/invites/[^/]+"), "/invites/…")} → ${r?.status ?: "no answer"}")
        }

    private suspend fun once(method: String, path: String, session: String?, body: JSONObject?): Reply? = withContext(Dispatchers.IO) {
        try {
            val connection = (URL(base + path).openConnection() as HttpURLConnection).apply {
                requestMethod = method
                connectTimeout = timeoutMs
                readTimeout = timeoutMs
                useCaches = false
                setRequestProperty("accept", "application/json")
                if (session != null) setRequestProperty("authorization", "Bearer $session")
                if (body != null) {
                    doOutput = true
                    setRequestProperty("content-type", "application/json")
                }
            }
            try {
                if (body != null) connection.outputStream.use { it.write(body.toString().toByteArray(Charsets.UTF_8)) }
                val status = connection.responseCode
                val stream = if (status in 200..299) connection.inputStream else connection.errorStream
                val text = stream?.use { it.readBytes().toString(Charsets.UTF_8) }.orEmpty()
                Reply(status, text.takeIf { it.isNotBlank() }?.let { runCatching { JSONObject(it) }.getOrNull() })
            } finally {
                connection.disconnect()
            }
        } catch (e: IOException) {
            // Android's HttpURLConnection throws this on a 401 that has no WWW-Authenticate header (the Worker sends one).
            if (e.message?.contains("authentication challenge", ignoreCase = true) == true) Reply(401, null) else null
        }
    }

    /** The proof of who's signing in: Google's or Apple's ID token and the raw nonce it carries the hash of. */
    private fun proof(p: SignIn): JSONObject =
        if (p.idToken.startsWith(TEST_PREFIX)) {
            // Debug builds' end-to-end tests only: dev takes the test secret instead of Google's sheet; production refuses it.
            JSONObject().put("provider", "test").put("secret", p.idToken.removePrefix(TEST_PREFIX)).put("subject", p.email).put("name", p.name)
        } else {
            JSONObject().put("provider", if (p.with == SignInWith.APPLE) "apple" else "google").put("idToken", p.idToken).put("nonce", p.nonce).put("name", p.name)
        }

    override suspend fun signIn(proof: SignIn): Answer<SignInReply> {
        val r = call("POST", "/v1/sign-in", body = proof(proof)) ?: return Answer.Offline
        val body = r.body ?: return Answer.Offline
        if (r.status != 200) return Answer.Offline
        if (!body.optBoolean("found")) return Answer.Ok(SignInReply.NoAccount)
        return Answer.Ok(SignInReply.Found(account(body.getJSONObject("account"), proof, body.getString("session"))))
    }

    override suspend fun create(proof: SignIn, purchase: PlayPurchase?): Answer<Account> {
        val body = proof(proof).also { b -> purchase?.let { b.put("purchase", JSONObject().put("product", it.product).put("token", it.token)) } }
        val r = call("POST", "/v1/accounts", body = body) ?: return Answer.Offline
        if (r.status != 200 || r.body == null) return Answer.Offline
        return Answer.Ok(account(r.body.getJSONObject("account"), proof, r.body.getString("session")))
    }

    override suspend fun refresh(account: Account): Answer<Account?> {
        val r = call("GET", "/v1/account", account.session) ?: return Answer.Offline
        if (r.status == 401) return Answer.Ok(null)
        return changed(r, account)
    }

    override suspend fun addPurchase(account: Account, purchase: PlayPurchase): Answer<Account> =
        changed(call("POST", "/v1/account/purchases", account.session, JSONObject().put("product", purchase.product).put("token", purchase.token)), account)

    override suspend fun delete(account: Account, proof: SignIn): Answer<Boolean> {
        val r = call("POST", "/v1/account/delete", account.session, proof(proof)) ?: return Answer.Offline
        return when {
            r.status == 200 -> Answer.Ok(r.body?.optBoolean("deleted") == true)
            // A different Google or Apple account chose in the sheet, or this device's session is gone: not deleted.
            r.status == 403 || r.status == 401 -> Answer.Ok(false)
            else -> Answer.Offline
        }
    }

    override suspend fun signOut(account: Account) {
        call("POST", "/v1/sign-out", account.session)
    }

    override suspend fun invite(account: Account) = changed(call("POST", "/v1/family/invite", account.session), account)
    override suspend fun cancelInvite(account: Account) = changed(call("POST", "/v1/family/invite/cancel", account.session), account)
    override suspend fun remove(account: Account, personId: String) =
        changed(call("POST", "/v1/family/remove", account.session, JSONObject().put("person", personId)), account)
    override suspend fun leave(account: Account) = changed(call("POST", "/v1/family/leave", account.session), account)

    override suspend fun lookInvite(token: String): Answer<InviteLook?> {
        if (InviteLink.token(InviteLink.of(token)) == null) return Answer.Ok(null)
        val r = call("GET", "/v1/invites/$token") ?: return Answer.Offline
        if (r.status == 404) return Answer.Ok(null)
        val body = r.body
        if (r.status != 200 || body == null) return Answer.Offline
        val owner = body.optString("owner")
        return Answer.Ok(when (body.optString("state")) {
            "open" -> InviteLook.Open(owner)
            "ended" -> InviteLook.Ended(owner)
            "used" -> InviteLook.Used(owner)
            "cancelled" -> InviteLook.Cancelled(owner)
            "full" -> InviteLook.Full(owner)
            else -> return Answer.Offline
        })
    }

    override suspend fun join(account: Account, token: String): Answer<Account> {
        if (InviteLink.token(InviteLink.of(token)) == null) return Answer.Ok(account)
        return changed(call("POST", "/v1/invites/$token/join", account.session), account)
    }

    /** A call that answers the account as it is now: the new one, kept with this device's session and email. */
    private fun changed(r: Reply?, was: Account): Answer<Account> {
        val body = r?.body
        if (r == null || r.status != 200 || body == null) return Answer.Offline
        return Answer.Ok(parse(body.getJSONObject("account"), was.with, was.email, was.session))
    }

    private fun account(o: JSONObject, proof: SignIn, session: String) = parse(o, proof.with, proof.email, session)

    companion object {
        const val DEV = "https://api-dev.oftenenough.com"
        const val PRODUCTION = "https://api.oftenenough.com"
        /** A [SignIn.idToken] beginning with this carries dev's test secret instead of a Google token (debug tests only). */
        const val TEST_PREFIX = "test-secret:"

        /** The Worker's account, as the phone keeps it. The email isn't the server's: it's what Google showed on this phone. */
        fun parse(o: JSONObject, with: SignInWith, email: String, session: String): Account {
            val f = o.optJSONObject("family")
            val family = f?.let {
                val people: JSONArray = it.getJSONArray("people")
                Family(it.getString("owner"), (0 until people.length()).map { i ->
                    val p = people.getJSONObject(i)
                    FamilyPerson(p.getString("id"), p.getString("name"), p.getBoolean("owner"), p.getBoolean("you"),
                        if (p.isNull("joinedDay")) null else p.getLong("joinedDay"))
                }, it.optJSONObject("invite")?.let { inv -> FamilyInvite(inv.getString("token"), inv.getString("link"), inv.getLong("endsDay")) })
            }
            val plus = runCatching { AccountPlus.valueOf(o.getString("plus")) }.getOrDefault(AccountPlus.NONE)
            return Account(o.getString("id"), with, email, plus, family, session)
        }
    }
}
