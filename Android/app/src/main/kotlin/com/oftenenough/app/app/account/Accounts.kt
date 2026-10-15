package com.oftenenough.app.app.account

import android.content.SharedPreferences
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import org.json.JSONArray
import org.json.JSONObject

/*
 * The Plus account (Rulebook D15, D16; Android A15; Current Work 110; Figma "Settings: Plus & Account", 1476:2).
 *
 * An account holds only the purchase, the family and which cloud holds the habits; never a habit. It is offered to
 * everyone and required of no one, and it is made only with Google or Apple (no email, no password). The server is one
 * Cloudflare Worker (D1 for accounts); until it exists, [AccountServer] has a stand-in on the phone (debug builds and
 * tests) and none in a release build, so every screen and its states can be built and tested now and the real server
 * slots in behind the same calls.
 */

enum class SignInWith { GOOGLE, APPLE }

/** What the account gives: nothing yet (free with an account), its own Plus, a family it owns, or a place in one. */
enum class AccountPlus { NONE, PLUS, FAMILY_OWNER, FAMILY_MEMBER }

/** Plus Family is the buyer and 5 more, six in all (the user, 14 Oct 2026). */
const val FAMILY_SIZE = 6

/** How long an invite works (Figma 7: "Works once, for 7 days"). */
const val INVITE_DAYS = 7

data class FamilyPerson(val id: String, val name: String, val owner: Boolean, val you: Boolean, val joinedDay: Long?)

/** One single-use invite: a link, shown as a QR code too, that ends after [INVITE_DAYS]. */
data class FamilyInvite(val token: String, val link: String, val endsDay: Long)

data class Family(val ownerName: String, val people: List<FamilyPerson>, val invite: FamilyInvite?) {
    /** Places left to invite into: six, less the people in it and an invite waiting. */
    val placesFree: Int get() = (FAMILY_SIZE - people.size - (if (invite != null) 1 else 0)).coerceAtLeast(0)
}

/**
 * The signed-in account, as this phone keeps it. [email] is shown on this phone only ("Signed in as …"); the server keeps
 * Google's fixed account ID and a masked hint, never the full email (D16).
 */
data class Account(val id: String, val with: SignInWith, val email: String, val plus: AccountPlus, val family: Family?) {
    val givesPlus: Boolean get() = plus != AccountPlus.NONE
}

/** What Google or Apple handed back after the person chose an account: proof for the server, and who it is. */
data class SignIn(val with: SignInWith, val idToken: String, val email: String, val name: String)

/** A purchase made on this phone through Google Play, sent with a new account so the server can check it with Google. */
data class PlayPurchase(val product: String, val token: String)

/** Every server call either answers or couldn't connect (Figma 3.5, 4.3: "Couldn't connect"). */
sealed interface Answer<out T> {
    data class Ok<T>(val value: T) : Answer<T>
    data object Offline : Answer<Nothing>
}

/** Signing in (Figma 3.2): an account was found, or none uses that Google or Apple account (3.4). */
sealed interface SignInReply {
    data class Found(val account: Account) : SignInReply
    data object NoAccount : SignInReply
}

/** What an invite link says when it's opened (Figma 5.2–5.6). */
sealed interface InviteLook {
    val ownerName: String
    data class Open(override val ownerName: String) : InviteLook
    data class Ended(override val ownerName: String) : InviteLook
    data class Used(override val ownerName: String) : InviteLook
    data class Cancelled(override val ownerName: String) : InviteLook
    data class Full(override val ownerName: String) : InviteLook
}

/** The Worker's calls. Every one is safe to repeat (a retry after a lost answer changes nothing twice). */
interface AccountServer {
    /** False in a build with no server yet: the account rows say so instead of failing. */
    val available: Boolean
    suspend fun signIn(proof: SignIn): Answer<SignInReply>
    /** Makes the account (or returns the one that already uses [proof], so a repeat never makes two). */
    suspend fun create(proof: SignIn, purchase: PlayPurchase?): Answer<Account>
    suspend fun refresh(account: Account): Answer<Account?>
    /** A purchase made on this phone after the account was made: the server checks it with Google and adds it. */
    suspend fun addPurchase(account: Account, purchase: PlayPurchase): Answer<Account>
    /** Deletes the account and, for an owner, the family; purchases stay with Google and Apple (D16, Current Work 110). */
    suspend fun delete(account: Account, proof: SignIn): Answer<Boolean>
    suspend fun invite(account: Account): Answer<Account>
    suspend fun cancelInvite(account: Account): Answer<Account>
    suspend fun remove(account: Account, personId: String): Answer<Account>
    suspend fun leave(account: Account): Answer<Account>
    suspend fun lookInvite(token: String): Answer<InviteLook?>
    suspend fun join(account: Account, token: String): Answer<Account>
}

/** A release build before the Worker exists: nothing to sign in to yet, and nothing is ever taken away. */
object NoAccountServer : AccountServer {
    override val available = false
    override suspend fun signIn(proof: SignIn) = Answer.Offline
    override suspend fun create(proof: SignIn, purchase: PlayPurchase?) = Answer.Offline
    override suspend fun refresh(account: Account) = Answer.Offline
    override suspend fun addPurchase(account: Account, purchase: PlayPurchase) = Answer.Offline
    override suspend fun delete(account: Account, proof: SignIn) = Answer.Offline
    override suspend fun invite(account: Account) = Answer.Offline
    override suspend fun cancelInvite(account: Account) = Answer.Offline
    override suspend fun remove(account: Account, personId: String) = Answer.Offline
    override suspend fun leave(account: Account) = Answer.Offline
    override suspend fun lookInvite(token: String) = Answer.Offline
    override suspend fun join(account: Account, token: String) = Answer.Offline
}

/** The invite link's form: `https://oftenenough.com/join/<token>` (the app opens it; the website explains it otherwise). */
object InviteLink {
    private const val PREFIX = "https://oftenenough.com/join/"
    fun of(token: String) = PREFIX + token
    /** The token in a link, a scanned QR code or a typed code; null when it isn't one of ours. */
    fun token(text: String?): String? {
        val t = text?.trim() ?: return null
        val raw = if (t.startsWith(PREFIX)) t.removePrefix(PREFIX) else if (t.startsWith("oftenenough.com/join/")) t.removePrefix("oftenenough.com/join/") else return null
        return raw.substringBefore('?').substringBefore('#').takeIf { it.matches(Regex("[A-Za-z0-9_-]{8,64}")) }
    }
}

/** "alexandra.montgomery@gmail.com" → "alexa…@gmail.com" where room is short (Figma 1.4's header), whole elsewhere. */
object EmailWords {
    fun short(email: String, keep: Int = 5): String {
        val at = email.indexOf('@')
        if (at <= keep + 1) return email
        return email.take(keep) + "…" + email.substring(at)
    }
}

/** The account kept on this phone between launches (its own file; a test launch's own file, D8). */
internal object AccountFile {
    private const val KEY = "account"

    fun read(sp: SharedPreferences): Account? = runCatching { sp.getString(KEY, null)?.let { decode(JSONObject(it)) } }.getOrNull()

    /** Written at once (commit): an account that signed in must still be there after the process is stopped. */
    fun write(sp: SharedPreferences, account: Account?) {
        if (account == null) sp.edit().remove(KEY).commit() else sp.edit().putString(KEY, encode(account).toString()).commit()
    }

    fun encode(a: Account): JSONObject = JSONObject().put("id", a.id).put("with", a.with.name).put("email", a.email)
        .put("plus", a.plus.name).put("family", a.family?.let { f ->
            JSONObject().put("owner", f.ownerName)
                .put("people", JSONArray().also { arr -> f.people.forEach { p ->
                    arr.put(JSONObject().put("id", p.id).put("name", p.name).put("owner", p.owner).put("you", p.you).put("joined", p.joinedDay ?: -1))
                } })
                .put("invite", f.invite?.let { JSONObject().put("token", it.token).put("link", it.link).put("ends", it.endsDay) })
        })

    fun decode(o: JSONObject): Account = Account(
        o.getString("id"), SignInWith.valueOf(o.getString("with")), o.getString("email"), AccountPlus.valueOf(o.getString("plus")),
        o.optJSONObject("family")?.let { f ->
            val arr = f.getJSONArray("people")
            Family(f.getString("owner"), (0 until arr.length()).map { i ->
                val p = arr.getJSONObject(i)
                FamilyPerson(p.getString("id"), p.getString("name"), p.getBoolean("owner"), p.getBoolean("you"), p.getLong("joined").takeIf { it >= 0 })
            }, f.optJSONObject("invite")?.let { FamilyInvite(it.getString("token"), it.getString("link"), it.getLong("ends")) })
        },
    )
}

/**
 * The account on this phone: what it gives, and every change to it through [server]. Compose reads [account]; a change
 * is saved to the phone's file only after the server agreed, so the phone never shows a family or Plus the server
 * doesn't have.
 */
class AccountCenter(private val sp: SharedPreferences, val server: AccountServer) {
    var account by mutableStateOf(AccountFile.read(sp)); private set

    private fun keep(a: Account?) { AccountFile.write(sp, a); account = a }

    suspend fun signIn(proof: SignIn): Answer<SignInReply> =
        server.signIn(proof).also { if (it is Answer.Ok && it.value is SignInReply.Found) keep((it.value as SignInReply.Found).account) }

    suspend fun create(proof: SignIn, purchase: PlayPurchase?): Answer<Account> =
        server.create(proof, purchase).also { if (it is Answer.Ok) keep(it.value) }

    /** On this phone only: Plus bought through Google Play stays (Figma 7.1). */
    fun signOut() = keep(null)

    suspend fun delete(proof: SignIn): Answer<Boolean> {
        val a = account ?: return Answer.Ok(true)
        return server.delete(a, proof).also { if (it is Answer.Ok && it.value) keep(null) }
    }

    /** Asks the server for the account again (a family member removed, Plus refunded); kept as it was when offline. */
    suspend fun refresh() {
        val a = account ?: return
        val reply = server.refresh(a)
        if (reply is Answer.Ok) keep(reply.value)
    }

    private suspend fun change(call: suspend (Account) -> Answer<Account>): Answer<Account> {
        val a = account ?: return Answer.Offline
        return call(a).also { if (it is Answer.Ok) keep(it.value) }
    }

    suspend fun addPurchase(purchase: PlayPurchase) = change { server.addPurchase(it, purchase) }

    /**
     * A Play purchase the account doesn't show yet (bought after signing in, or while offline) is added, so Plus reaches
     * the person's other devices. Safe to repeat; offline, it's tried again on the next launch.
     */
    suspend fun syncPurchase(purchase: PlayPurchase?) {
        val a = account ?: return
        val p = purchase ?: return
        val family = p.product.startsWith("com.oftenenough.app.plusfamily")
        val missing = if (family) a.plus != AccountPlus.FAMILY_OWNER else a.plus == AccountPlus.NONE
        if (missing) addPurchase(p)
    }
    suspend fun invite() = change { server.invite(it) }
    suspend fun cancelInvite() = change { server.cancelInvite(it) }
    suspend fun remove(personId: String) = change { server.remove(it, personId) }
    suspend fun leave() = change { server.leave(it) }
    suspend fun join(token: String) = change { server.join(it, token) }
    suspend fun lookInvite(token: String) = server.lookInvite(token)

    companion object { const val FILE = "account" }
}
