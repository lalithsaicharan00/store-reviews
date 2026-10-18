package app.habits.account

import kotlinx.coroutines.delay
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.buildJsonArray
import kotlinx.serialization.json.buildJsonObject
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive
import kotlinx.serialization.json.put
import kotlin.random.Random

/**
 * The Worker's stand-in, on the device (debug builds and tests only, like the stand-in Drive and the fake store): the
 * same rules the Worker keeps (Architecture 02, Current Work 110), in its own [storage], so every screen and state of
 * Plus & Account can be used and tested without the server. A test launch gets its own, emptied (D8).
 *
 * Rules kept here and on the Worker: one account per Google or Apple account; a family is its owner and up to 5 more;
 * one waiting invite per family, used once, for [INVITE_DAYS] days; joining another family leaves the first; deleting an
 * owner's account ends the family; the upgrade makes a family only beside Plus; nothing here ever holds a habit.
 */
class StandInAccountServer(private val storage: AccountStorage, private val today: () -> Long, private val random: Random = Random.Default) : AccountServer {
    override val available = true
    /** A test (or a debug menu) turns this on to see "Couldn't connect". */
    var offline = false
    /** How long the stand-in "talks to the server" (ms), so the waiting screens show as they will; 0 in tests. */
    var latencyMs = 0L

    private fun newId(bytes: Int = 16): String {
        val alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"
        return (0 until (bytes * 4 + 2) / 3).map { alphabet[random.nextInt(64)] }.joinToString("")
    }

    // ------------------------------------------------------------------ The stored state, one JSON text

    private class Person(val key: String, val id: String, val with: SignInWith, val email: String, val name: String, var plus: AccountPlus, var family: String?, var joined: Long?)
    private class Fam(val id: String, val owner: String, val members: MutableList<String>, var invite: String?)
    private class Inv(val token: String, val family: String, val ends: Long, var state: String)

    private val people = LinkedHashMap<String, Person>()
    private val families = LinkedHashMap<String, Fam>()
    private val invites = LinkedHashMap<String, Inv>()

    init { load() }

    private fun load() = runCatching {
        val o = Json.parseToJsonElement(storage.read() ?: return@runCatching).jsonObject
        (o["people"] as JsonArray).map { it.jsonObject }.forEach { p ->
            people[p.stringAt("key")!!] = Person(p.stringAt("key")!!, p.stringAt("id")!!, SignInWith.valueOf(p.stringAt("with")!!), p.stringAt("email")!!,
                p.stringAt("name")!!, AccountPlus.valueOf(p.stringAt("plus")!!), p.stringAt("family")?.ifEmpty { null }, p.longAt("joined")?.takeIf { it >= 0 })
        }
        (o["families"] as JsonArray).map { it.jsonObject }.forEach { f ->
            families[f.stringAt("id")!!] = Fam(f.stringAt("id")!!, f.stringAt("owner")!!,
                (f["members"] as JsonArray).map { it.jsonPrimitive.content }.toMutableList(), f.stringAt("invite")?.ifEmpty { null })
        }
        (o["invites"] as JsonArray).map { it.jsonObject }.forEach { i ->
            invites[i.stringAt("token")!!] = Inv(i.stringAt("token")!!, i.stringAt("family")!!, i.longAt("ends")!!, i.stringAt("state")!!)
        }
    }

    private fun save() {
        val o = buildJsonObject {
            put("people", buildJsonArray {
                people.values.forEach { p -> add(buildJsonObject {
                    put("key", p.key); put("id", p.id); put("with", p.with.name); put("email", p.email); put("name", p.name)
                    put("plus", p.plus.name); put("family", p.family ?: ""); put("joined", p.joined ?: -1)
                }) }
            })
            put("families", buildJsonArray {
                families.values.forEach { f -> add(buildJsonObject {
                    put("id", f.id); put("owner", f.owner); put("members", JsonArray(f.members.map(::JsonPrimitive))); put("invite", f.invite ?: "")
                }) }
            })
            put("invites", buildJsonArray {
                invites.values.forEach { i -> add(buildJsonObject { put("token", i.token); put("family", i.family); put("ends", i.ends); put("state", i.state) }) }
            })
        }
        storage.write(o.toString())
    }

    private fun key(proof: SignIn) = proof.with.name + ":" + proof.email.lowercase()

    /** The account as [p] sees it: their family with "You" marked. */
    private fun view(p: Person): Account {
        val fam = p.family?.let { families[it] }
        return Account(p.id, p.with, p.email, p.plus, fam?.let { f ->
            val owner = people[f.owner]
            Family(owner?.name ?: "", (listOf(f.owner) + f.members).mapNotNull { k -> people[k] }.map { q ->
                FamilyPerson(q.id, q.name, q.key == f.owner, q.key == p.key, if (q.key == f.owner) null else q.joined)
            }, if (p.key == f.owner) f.invite?.let { t -> invites[t] }?.takeIf { it.state == OPEN && it.ends >= today() }
                ?.let { FamilyInvite(it.token, InviteLink.of(it.token), it.ends) } else null)
        })
    }

    private fun byId(id: String) = people.values.firstOrNull { it.id == id }

    private suspend inline fun <T> answer(block: () -> T): Answer<T> {
        delay(latencyMs)
        return if (offline) Answer.Offline else Answer.Ok(block().also { save() })
    }

    // ------------------------------------------------------------------ The calls

    override suspend fun signIn(proof: SignIn): Answer<SignInReply> = answer {
        people[key(proof)]?.let { SignInReply.Found(view(it)) } ?: SignInReply.NoAccount
    }

    override suspend fun create(proof: SignIn, purchase: StorePurchase?): Answer<Account> = answer {
        val p = people.getOrPut(key(proof)) { Person(key(proof), newId(), proof.with, proof.email, proof.name, AccountPlus.NONE, null, null) }
        purchase?.let { add(p, it) }
        view(p)
    }

    override suspend fun addPurchase(account: Account, purchase: StorePurchase): Answer<Account> = answer {
        val p = byId(account.id) ?: error("No account")
        add(p, purchase)
        view(p)
    }

    /**
     * A checked purchase on the account (the Worker checks the token with the store first). Plus over a family place:
     * their own. The upgrade is only the difference, so it makes a family only beside Plus, as the Worker's `paidFor`
     * (the apps send Plus first).
     */
    private fun add(p: Person, purchase: StorePurchase) {
        when (purchase.product) {
            PlusProducts.FAMILY -> ownFamily(p)
            PlusProducts.FAMILY_UPGRADE -> if (p.plus == AccountPlus.PLUS) ownFamily(p)
            PlusProducts.PLUS -> if (p.plus == AccountPlus.NONE || p.plus == AccountPlus.FAMILY_MEMBER) p.plus = AccountPlus.PLUS
        }
    }

    /** Plus Family bought: the buyer owns a family of their own (leaving one they were in). */
    private fun ownFamily(p: Person) {
        if (p.plus == AccountPlus.FAMILY_OWNER) return
        leaveFamily(p)
        val f = Fam(newId(8), p.key, mutableListOf(), null)
        families[f.id] = f
        p.family = f.id; p.plus = AccountPlus.FAMILY_OWNER
    }

    private fun leaveFamily(p: Person) {
        val f = p.family?.let { families[it] } ?: return
        if (f.owner == p.key) return
        f.members.remove(p.key)
        p.family = null; p.joined = null
        if (p.plus == AccountPlus.FAMILY_MEMBER) p.plus = AccountPlus.NONE
    }

    override suspend fun refresh(account: Account): Answer<Account?> = answer { byId(account.id)?.let(::view) }

    override suspend fun delete(account: Account, proof: SignIn): Answer<Boolean> = answer {
        val p = byId(account.id)
        if (p == null || p.key != key(proof)) return@answer false
        p.family?.let { families[it] }?.takeIf { it.owner == p.key }?.let { f ->
            // An owner's family ends with the account: everyone in it loses Plus, keeps their habits (Figma 7.9).
            for (k in f.members) people[k]?.let { m -> m.family = null; m.joined = null; m.plus = AccountPlus.NONE }
            f.invite?.let { invites[it]?.state = CANCELLED }
            families.remove(f.id)
        } ?: leaveFamily(p)
        people.remove(p.key)
        true
    }

    private fun ownersFamily(account: Account): Fam? = byId(account.id)?.let { p -> p.family?.let { families[it] }?.takeIf { it.owner == p.key } }

    override suspend fun invite(account: Account): Answer<Account> = answer {
        val p = byId(account.id) ?: error("No account")
        val f = ownersFamily(account) ?: return@answer view(p)
        val waiting = f.invite?.let { invites[it] }?.takeIf { it.state == OPEN && it.ends >= today() }
        if (waiting == null && 1 + f.members.size < FAMILY_SIZE) {
            val token = newId()
            invites[token] = Inv(token, f.id, today() + INVITE_DAYS, OPEN)
            f.invite = token
        }
        view(p)
    }

    override suspend fun cancelInvite(account: Account): Answer<Account> = answer {
        val p = byId(account.id) ?: error("No account")
        ownersFamily(account)?.let { f -> f.invite?.let { invites[it]?.state = CANCELLED }; f.invite = null }
        view(p)
    }

    override suspend fun remove(account: Account, personId: String): Answer<Account> = answer {
        val p = byId(account.id) ?: error("No account")
        ownersFamily(account)?.let { _ -> byId(personId)?.takeIf { it.key != p.key }?.let(::leaveFamily) }
        view(p)
    }

    override suspend fun leave(account: Account): Answer<Account> = answer {
        val p = byId(account.id) ?: error("No account")
        if (p.plus == AccountPlus.FAMILY_MEMBER) leaveFamily(p)
        view(p)
    }

    override suspend fun lookInvite(token: String): Answer<InviteLook?> = answer {
        val i = invites[token] ?: return@answer null
        val f = families[i.family]
        val owner = f?.let { people[it.owner]?.name } ?: ""
        when {
            f == null || i.state == CANCELLED -> InviteLook.Cancelled(owner)
            i.state == USED -> InviteLook.Used(owner)
            i.ends < today() -> InviteLook.Ended(owner)
            1 + f.members.size >= FAMILY_SIZE -> InviteLook.Full(owner)
            else -> InviteLook.Open(owner)
        }
    }

    override suspend fun join(account: Account, token: String): Answer<Account> = answer {
        val p = byId(account.id) ?: error("No account")
        val i = invites[token]
        val f = i?.let { families[it.family] }
        // Joining twice with the same invite (a retry) keeps the place it already gave.
        if (f != null && p.family == f.id) return@answer view(p)
        if (i == null || f == null || i.state != OPEN || i.ends < today() || 1 + f.members.size >= FAMILY_SIZE || f.owner == p.key) return@answer view(p)
        // Someone who owns a family keeps it; the app never offers them another (Figma 5.7).
        if (p.plus == AccountPlus.FAMILY_OWNER) return@answer view(p)
        leaveFamily(p)
        f.members.add(p.key)
        p.family = f.id; p.joined = today()
        if (p.plus == AccountPlus.NONE) p.plus = AccountPlus.FAMILY_MEMBER
        i.state = USED; f.invite = null
        view(p)
    }

    /** For tests and the debug build: someone else's family with an invite waiting, as if their phone had made it. */
    fun seedFamily(ownerName: String, ownerEmail: String, members: List<Pair<String, String>> = emptyList()): String {
        val owner = SignIn(SignInWith.GOOGLE, "stand-in", ownerEmail, ownerName)
        val p = people.getOrPut(key(owner)) { Person(key(owner), newId(), SignInWith.GOOGLE, ownerEmail, ownerName, AccountPlus.NONE, null, null) }
        ownFamily(p)
        val f = families[p.family]!!
        for ((name, email) in members) {
            val m = SignIn(SignInWith.GOOGLE, "stand-in", email, name)
            val q = people.getOrPut(key(m)) { Person(key(m), newId(), SignInWith.GOOGLE, email, name, AccountPlus.FAMILY_MEMBER, f.id, today()) }
            if (q.key !in f.members) f.members.add(q.key)
        }
        val token = newId()
        invites[token] = Inv(token, f.id, today() + INVITE_DAYS, OPEN)
        f.invite = token
        save()
        return token
    }

    /** For tests: an invite's state changed elsewhere (ended, used, cancelled). */
    fun setInvite(token: String, state: String? = null, endsDay: Long? = null) {
        val i = invites[token] ?: return
        if (state != null) i.state = state
        if (endsDay != null) invites[token] = Inv(i.token, i.family, endsDay, i.state)
        save()
    }

    companion object {
        const val OPEN = "open"
        const val USED = "used"
        const val CANCELLED = "cancelled"
    }
}
