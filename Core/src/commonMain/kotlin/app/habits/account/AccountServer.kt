package app.habits.account

import kotlinx.serialization.json.JsonNull
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.booleanOrNull
import kotlinx.serialization.json.buildJsonObject
import kotlinx.serialization.json.contentOrNull
import kotlinx.serialization.json.jsonArray
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive
import kotlinx.serialization.json.longOrNull
import kotlinx.serialization.json.put

/** The Worker's calls. Every one is safe to repeat (a retry after a lost answer changes nothing twice). */
interface AccountServer {
    /** False in a build with no server yet: the account rows say so instead of failing. */
    val available: Boolean
    suspend fun signIn(proof: SignIn): Answer<SignInReply>
    /** Makes the account (or returns the one that already uses [proof], so a repeat never makes two). */
    suspend fun create(proof: SignIn, purchase: StorePurchase?): Answer<Account>
    /** The account as it is now; null when the server no longer knows this device's session (the device signs out). */
    suspend fun refresh(account: Account): Answer<Account?>
    /** A purchase made on this device after the account was made: the server checks it with the store and adds it. */
    suspend fun addPurchase(account: Account, purchase: StorePurchase): Answer<Account>
    /** Deletes the account and, for an owner, the family; purchases stay with Google and Apple (D16, Current Work 110). */
    suspend fun delete(account: Account, proof: SignIn): Answer<Boolean>
    suspend fun invite(account: Account): Answer<Account>
    suspend fun cancelInvite(account: Account): Answer<Account>
    suspend fun remove(account: Account, personId: String): Answer<Account>
    suspend fun leave(account: Account): Answer<Account>
    suspend fun lookInvite(token: String): Answer<InviteLook?>
    suspend fun join(account: Account, token: String): Answer<Account>
    /** Ends this device's session on the server (best effort: the device forgets the account either way). */
    suspend fun signOut(account: Account) {}
}

/** A build before the Worker exists: nothing to sign in to yet, and nothing is ever taken away. */
object NoAccountServer : AccountServer {
    override val available = false
    override suspend fun signIn(proof: SignIn) = Answer.Offline
    override suspend fun create(proof: SignIn, purchase: StorePurchase?) = Answer.Offline
    override suspend fun refresh(account: Account) = Answer.Offline
    override suspend fun addPurchase(account: Account, purchase: StorePurchase) = Answer.Offline
    override suspend fun delete(account: Account, proof: SignIn) = Answer.Offline
    override suspend fun invite(account: Account) = Answer.Offline
    override suspend fun cancelInvite(account: Account) = Answer.Offline
    override suspend fun remove(account: Account, personId: String) = Answer.Offline
    override suspend fun leave(account: Account) = Answer.Offline
    override suspend fun lookInvite(token: String) = Answer.Offline
    override suspend fun join(account: Account, token: String) = Answer.Offline
}

/** One HTTPS call to the Worker: [session] goes as `Authorization: Bearer`, [body] is JSON. */
class AccountRequest(val method: String, val url: String, val session: String?, val body: String?)

/** What the Worker answered: its status and body (JSON, or empty). */
class AccountResponse(val status: Int, val body: String)

/**
 * Sending one request, which is all a platform does for the account (Android: `HttpURLConnection`; iPhone:
 * `URLSession`): the core speaks the Worker's protocol. Null when no answer came at all (offline, timed out, cut off);
 * every status is an answer. Never logs a body, a session or an invite token (D11).
 */
fun interface AccountHttp {
    suspend fun send(request: AccountRequest): AccountResponse?
}

/**
 * The real account server: the Cloudflare Worker in `account-server/` (Rulebook D16, Current Work 110). Debug builds
 * talk to [DEV], release builds to [PRODUCTION]. Sign-in hands back a session token for this device, kept with the
 * account ([Account.session]) and sent with every call.
 *
 * Answers: anything the Worker couldn't do (no network, a server error, too many tries, the store not reachable) is
 * [Answer.Offline], so the screens say "Couldn't connect" and nothing changes; a session the Worker no longer knows
 * (signed out elsewhere, the account deleted) makes [refresh] answer null, and the device signs out.
 */
class HttpAccountServer(private val base: String, private val http: AccountHttp) : AccountServer {
    override val available = true

    private class Reply(val status: Int, val body: JsonObject?)

    /**
     * One call, tried a second time if no answer came (a kept-alive connection the network or Cloudflare had already
     * closed: "connection abort", seen on the emulator). Every Worker call is safe to repeat.
     */
    private suspend fun call(method: String, path: String, session: String? = null, body: JsonObject? = null): Reply? {
        val request = AccountRequest(method, base + path, session, body?.toString())
        val response = (runCatching { http.send(request) }.getOrNull() ?: runCatching { http.send(request) }.getOrNull()) ?: return null
        val json = response.body.takeIf { it.isNotBlank() }?.let { runCatching { kotlinx.serialization.json.Json.parseToJsonElement(it).jsonObject }.getOrNull() }
        return Reply(response.status, json)
    }

    /** The proof of who's signing in: Google's or Apple's ID token and the raw nonce it carries the hash of. */
    private fun proof(p: SignIn): JsonObject = buildJsonObject {
        if (p.idToken.startsWith(TEST_PREFIX)) {
            // Debug builds' end-to-end tests only: dev takes the test secret instead of Google's sheet; production refuses it.
            put("provider", "test"); put("secret", p.idToken.removePrefix(TEST_PREFIX)); put("subject", p.email); put("name", p.name)
        } else {
            put("provider", if (p.with == SignInWith.APPLE) "apple" else "google"); put("idToken", p.idToken); put("nonce", p.nonce); put("name", p.name)
        }
    }

    private fun purchaseJson(p: StorePurchase) = buildJsonObject { put("product", p.product); put("token", p.token) }

    override suspend fun signIn(proof: SignIn): Answer<SignInReply> {
        val r = call("POST", "/v1/sign-in", body = proof(proof)) ?: return Answer.Offline
        val body = r.body ?: return Answer.Offline
        if (r.status != 200) return Answer.Offline
        if (body["found"]?.jsonPrimitive?.booleanOrNull != true) return Answer.Ok(SignInReply.NoAccount)
        val account = body.objectAt("account") ?: return Answer.Offline
        val session = body.stringAt("session") ?: return Answer.Offline
        return Answer.Ok(SignInReply.Found(parse(account, proof.with, proof.email, session)))
    }

    override suspend fun create(proof: SignIn, purchase: StorePurchase?): Answer<Account> {
        val body = JsonObject(proof(proof) + (purchase?.let { mapOf("purchase" to purchaseJson(it)) } ?: emptyMap()))
        val r = call("POST", "/v1/accounts", body = body) ?: return Answer.Offline
        val reply = r.body
        if (r.status != 200 || reply == null) return Answer.Offline
        val account = reply.objectAt("account") ?: return Answer.Offline
        val session = reply.stringAt("session") ?: return Answer.Offline
        return Answer.Ok(parse(account, proof.with, proof.email, session))
    }

    override suspend fun refresh(account: Account): Answer<Account?> {
        val r = call("GET", "/v1/account", account.session) ?: return Answer.Offline
        if (r.status == 401) return Answer.Ok(null)
        return changed(r, account)
    }

    override suspend fun addPurchase(account: Account, purchase: StorePurchase): Answer<Account> =
        changed(call("POST", "/v1/account/purchases", account.session, purchaseJson(purchase)), account)

    override suspend fun delete(account: Account, proof: SignIn): Answer<Boolean> {
        val r = call("POST", "/v1/account/delete", account.session, proof(proof)) ?: return Answer.Offline
        return when (r.status) {
            200 -> Answer.Ok(r.body?.get("deleted")?.jsonPrimitive?.booleanOrNull == true)
            // A different Google or Apple account chosen in the sheet, or this device's session is gone: not deleted.
            401, 403 -> Answer.Ok(false)
            else -> Answer.Offline
        }
    }

    override suspend fun signOut(account: Account) {
        call("POST", "/v1/sign-out", account.session)
    }

    override suspend fun invite(account: Account) = changed(call("POST", "/v1/family/invite", account.session), account)
    override suspend fun cancelInvite(account: Account) = changed(call("POST", "/v1/family/invite/cancel", account.session), account)
    override suspend fun remove(account: Account, personId: String) =
        changed(call("POST", "/v1/family/remove", account.session, buildJsonObject { put("person", personId) }), account)
    override suspend fun leave(account: Account) = changed(call("POST", "/v1/family/leave", account.session), account)

    override suspend fun lookInvite(token: String): Answer<InviteLook?> {
        if (InviteLink.token(InviteLink.of(token)) == null) return Answer.Ok(null)
        val r = call("GET", "/v1/invites/$token") ?: return Answer.Offline
        if (r.status == 404) return Answer.Ok(null)
        val body = r.body
        if (r.status != 200 || body == null) return Answer.Offline
        val owner = body.stringAt("owner") ?: ""
        return Answer.Ok(when (body.stringAt("state")) {
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
        val account = r?.body?.objectAt("account")
        if (r == null || r.status != 200 || account == null) return Answer.Offline
        return runCatching { Answer.Ok(parse(account, was.with, was.email, was.session)) }.getOrElse { Answer.Offline }
    }

    companion object {
        const val DEV = "https://api-dev.oftenenough.com"
        const val PRODUCTION = "https://api.oftenenough.com"
        /** A [SignIn.idToken] beginning with this carries dev's test secret instead of a Google token (debug tests only). */
        const val TEST_PREFIX = "test-secret:"

        /** The Worker's account, as the device keeps it. The email isn't the server's: it's what the sign-in sheet showed. */
        fun parse(o: JsonObject, with: SignInWith, email: String, session: String): Account {
            val family = o.objectAt("family")?.let { f ->
                Family(
                    f.stringAt("owner") ?: "",
                    f["people"]?.jsonArray?.map { it.jsonObject }?.map { p ->
                        FamilyPerson(p.stringAt("id")!!, p.stringAt("name") ?: "", p.boolAt("owner"), p.boolAt("you"), p.longAt("joinedDay"))
                    } ?: emptyList(),
                    f.objectAt("invite")?.let { inv -> FamilyInvite(inv.stringAt("token")!!, inv.stringAt("link")!!, inv.longAt("endsDay")!!) },
                )
            }
            val plus = runCatching { AccountPlus.valueOf(o.stringAt("plus")!!) }.getOrDefault(AccountPlus.NONE)
            return Account(o.stringAt("id")!!, with, email, plus, family, session)
        }
    }
}

// Small readers for the Worker's JSON: a missing or null field reads as null.
internal fun JsonObject.objectAt(key: String): JsonObject? = (this[key] as? JsonObject)
internal fun JsonObject.stringAt(key: String): String? = (this[key] as? JsonPrimitive)?.takeIf { it !is JsonNull }?.contentOrNull
internal fun JsonObject.longAt(key: String): Long? = (this[key] as? JsonPrimitive)?.takeIf { it !is JsonNull }?.longOrNull
internal fun JsonObject.boolAt(key: String): Boolean = (this[key] as? JsonPrimitive)?.booleanOrNull == true
