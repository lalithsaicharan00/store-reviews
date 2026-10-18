package app.habits.account

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.buildJsonArray
import kotlinx.serialization.json.buildJsonObject
import kotlinx.serialization.json.jsonArray
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.put
import kotlin.coroutines.CoroutineContext
import kotlin.coroutines.EmptyCoroutineContext

/**
 * Where the device keeps the account between launches: one text, written at once (an account that signed in must still
 * be there after the process is stopped). Android: SharedPreferences; iPhone: UserDefaults. A test launch has its own (D8).
 */
interface AccountStorage {
    fun read(): String?
    fun write(text: String?)
}

/**
 * Holds the account the screens read, so each platform's screens redraw when it changes: Android gives a Compose
 * `mutableStateOf`, the iPhone an `@Observable` box. [PlainAccountHolder] is enough where nothing redraws (tests).
 */
interface AccountHolder {
    var value: Account?
}

class PlainAccountHolder(override var value: Account? = null) : AccountHolder

/** The account's file on the device, in the format Android has always written (an account saved before still loads). */
object AccountFile {
    fun encode(a: Account): String = buildJsonObject {
        put("id", a.id); put("with", a.with.name); put("email", a.email); put("session", a.session); put("plus", a.plus.name)
        a.family?.let { f ->
            put("family", buildJsonObject {
                put("owner", f.ownerName)
                put("people", buildJsonArray {
                    f.people.forEach { p ->
                        add(buildJsonObject { put("id", p.id); put("name", p.name); put("owner", p.owner); put("you", p.you); put("joined", p.joinedDay ?: -1) })
                    }
                })
                f.invite?.let { put("invite", buildJsonObject { put("token", it.token); put("link", it.link); put("ends", it.endsDay) }) }
            })
        }
    }.toString()

    /** Null for no text, or text that isn't an account (never a crash on a damaged file). */
    fun decode(text: String?): Account? = runCatching {
        val o = Json.parseToJsonElement(text ?: return null).jsonObject
        Account(
            o.stringAt("id")!!, SignInWith.valueOf(o.stringAt("with")!!), o.stringAt("email")!!, AccountPlus.valueOf(o.stringAt("plus")!!),
            o.objectAt("family")?.let { f ->
                Family(
                    f.stringAt("owner")!!,
                    (f["people"] as? JsonArray ?: JsonArray(emptyList())).map { it.jsonObject }.map { p ->
                        FamilyPerson(p.stringAt("id")!!, p.stringAt("name")!!, p.boolAt("owner"), p.boolAt("you"), p.longAt("joined")?.takeIf { it >= 0 })
                    },
                    f.objectAt("invite")?.let { FamilyInvite(it.stringAt("token")!!, it.stringAt("link")!!, it.longAt("ends")!!) },
                )
            },
            o.stringAt("session") ?: "",
        )
    }.getOrNull()
}

/**
 * The account on this device: what it gives, and every change to it through [server]. Screens read [account]; a change
 * is saved only after the server agreed, so the device never shows a family or Plus the server doesn't have. Every call
 * comes back on [ui] (the main thread in the apps), whatever thread the server answered on, so what follows it (the
 * account the screen reads, the navigation) is on the main thread too (Rulebook T22).
 */
class AccountCenter(
    private val storage: AccountStorage,
    val server: AccountServer,
    private val holder: AccountHolder = PlainAccountHolder(),
    private val ui: CoroutineContext = EmptyCoroutineContext,
    private val background: CoroutineScope = CoroutineScope(SupervisorJob() + Dispatchers.Default),
) {
    init { holder.value = AccountFile.decode(storage.read()) }

    val account: Account? get() = holder.value

    private fun keep(a: Account?) {
        storage.write(a?.let(AccountFile::encode))
        holder.value = a
    }

    private suspend fun <T> onUi(block: suspend () -> T): T = withContext(ui) { block() }

    suspend fun signIn(proof: SignIn): Answer<SignInReply> = onUi {
        server.signIn(proof).also { if (it is Answer.Ok && it.value is SignInReply.Found) keep((it.value as SignInReply.Found).account) }
    }

    suspend fun create(proof: SignIn, purchase: StorePurchase?): Answer<Account> = onUi {
        server.create(proof, purchase).also { if (it is Answer.Ok) keep(it.value) }
    }

    /** Makes the account with the first purchase, then adds the rest (Plus first: the upgrade counts only beside it). */
    suspend fun create(proof: SignIn, purchases: List<StorePurchase>): Answer<Account> =
        create(proof, purchases.firstOrNull()).also { if (it is Answer.Ok) syncPurchases(purchases.drop(1)) }

    /** This device forgets the account at once, and the server ends this device's session; a store purchase stays (Figma 7.1). */
    fun signOut() {
        val a = account ?: return
        keep(null)
        background.launch { runCatching { server.signOut(a) } }
    }

    suspend fun delete(proof: SignIn): Answer<Boolean> = onUi {
        val a = account ?: return@onUi Answer.Ok(true)
        server.delete(a, proof).also { if (it is Answer.Ok && it.value) keep(null) }
    }

    /** Asks the server for the account again (a family member removed, Plus refunded); kept as it was when offline. */
    suspend fun refresh() = onUi {
        val a = account ?: return@onUi
        val reply = server.refresh(a)
        // Only the account this answer is about (a sign-out or a new sign-in meanwhile wins).
        if (reply is Answer.Ok && account?.id == a.id && account?.session == a.session) keep(reply.value)
    }

    private suspend fun change(call: suspend (Account) -> Answer<Account>): Answer<Account> = onUi {
        val a = account ?: return@onUi Answer.Offline
        call(a).also { if (it is Answer.Ok && account?.session == a.session) keep(it.value) }
    }

    suspend fun addPurchase(purchase: StorePurchase) = change { server.addPurchase(it, purchase) }

    /** Every purchase on this device's store account, in order (Plus first: the upgrade counts only beside it). */
    suspend fun syncPurchases(purchases: List<StorePurchase>) { for (p in purchases) syncPurchase(p) }

    /**
     * A store purchase the account doesn't show yet (bought after signing in, or while offline) is added, so Plus
     * reaches the person's other devices. Safe to repeat; offline, it's tried again on the next launch.
     */
    suspend fun syncPurchase(purchase: StorePurchase?) {
        val a = account ?: return
        val p = purchase ?: return
        if (PlusProducts.missingFrom(a, p.product)) addPurchase(p)
    }

    suspend fun invite() = change { server.invite(it) }
    suspend fun cancelInvite() = change { server.cancelInvite(it) }
    suspend fun remove(personId: String) = change { server.remove(it, personId) }
    suspend fun leave() = change { server.leave(it) }
    suspend fun join(token: String) = change { server.join(it, token) }
    suspend fun lookInvite(token: String) = onUi { server.lookInvite(token) }

    companion object { const val FILE = "account" }
}
