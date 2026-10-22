package com.oftenenough.app.app

import android.app.Activity
import android.content.SharedPreferences
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue

/** Plus and Plus Family, one-time purchases with the iPhone's own product IDs (the shared core's [app.habits.account.PlusProducts]). */
enum class PlusProduct(val id: String, val title: String, val who: String) {
    PLUS(app.habits.account.PlusProducts.PLUS, "Plus", "Just you"),
    FAMILY(app.habits.account.PlusProducts.FAMILY, "Plus Family", "You + 5 people, each with their own habits"),
    /** Plus → Plus Family, for the difference. */
    FAMILY_UPGRADE(app.habits.account.PlusProducts.FAMILY_UPGRADE, "Plus Family upgrade", "Upgrade from Plus"),
}

/** What this phone's Google Play account owns: nothing, Plus, or Plus Family. */
enum class PlusOwned { NONE, PLUS, FAMILY }

/** How a purchase ended (Figma 2.1, 2.1.1, 2.1.2). */
enum class BuyResult {
    /** Play confirmed it: Plus is on. */
    BOUGHT,
    /** Play is waiting for the payment (a cash or bank payment): Plus turns on by itself when Play confirms it. */
    PENDING,
    /** Play said it didn't go through: nothing was charged. */
    NOT_COMPLETED,
    /** The person closed Play's sheet. Nothing to say. */
    CANCELLED,
    /** This build can't buy yet (before the Play Console app exists). */
    UNAVAILABLE,
}

/** Restore from Google Play (Figma 4, 4.1, 4.2, 4.3). */
enum class RestoreResult { FOUND, NONE, COULD_NOT_CONNECT }

/**
 * Where purchases come from (build prompt §5): Google Play Billing once the Play Console app exists, a stand-in store in
 * debug builds and tests until then. Plus bought on an iPhone, or shared by a family, comes from the account instead
 * (`account/Accounts.kt`); [AppGraph.hasPlus] joins the two. An ended or missing purchase never hides data (D10): it only
 * stops adding a 6th habit and the Plus widgets.
 */
interface PlusStore {
    val owned: PlusOwned
    /** A purchase Play is still waiting to be paid for (Figma 2.1.1); it turns into [owned] by itself. */
    val pending: PlusProduct?
    /** The price Play shows for [product] ("$24.99"), or null before Play has answered. */
    fun price(product: PlusProduct): String?
    /** Opens Play's own purchase sheet (Figma 2.1, 2.5, 8.1). */
    suspend fun buy(activity: Activity, product: PlusProduct): BuyResult
    /** Asks Play again what this Google account owns. */
    suspend fun restore(): RestoreResult
    /** Whether buying works on this build at all. */
    val canBuy: Boolean
    /** What this Google account bought, with Play's token, for the account's server to check with Google (D16). */
    fun purchase(): app.habits.account.StorePurchase?
    /**
     * Every purchase this Google account owns, Plus first: the Plus Family upgrade counts on the account only beside Plus
     * (account-server, `paidFor`), so the account is sent all of them, not just the best one.
     */
    fun purchases(): List<app.habits.account.StorePurchase> = listOfNotNull(purchase())
}

/**
 * The stand-in store: Play's sheet is skipped and buying succeeds at once, with US prices, remembered in its own file (a
 * test launch's is emptied each launch, D8). Never in a release build. [nextBuy] and [nextRestore] let a test or a debug
 * build show the other outcomes (pending, not completed, couldn't connect).
 */
class FakePlusStore(private val sp: SharedPreferences) : PlusStore {
    override var owned by mutableStateOf(runCatching { PlusOwned.valueOf(sp.getString(KEY, "NONE")!!) }.getOrDefault(PlusOwned.NONE)); private set
    override var pending by mutableStateOf<PlusProduct?>(null); private set
    override val canBuy = true
    var nextBuy: BuyResult = BuyResult.BOUGHT
    var nextRestore: RestoreResult? = null
    /** How long the stand-in "talks to Play" (ms), so the waiting screens show as they will; 0 in tests. */
    var latencyMs = 0L

    override fun price(product: PlusProduct): String = when (product) {
        PlusProduct.PLUS -> "$24.99"
        PlusProduct.FAMILY -> "$59.99"
        PlusProduct.FAMILY_UPGRADE -> "$35.00"
    }

    override suspend fun buy(activity: Activity, product: PlusProduct): BuyResult {
        kotlinx.coroutines.delay(latencyMs)
        val result = nextBuy.also { nextBuy = BuyResult.BOUGHT }
        when (result) {
            BuyResult.BOUGHT -> own(product)
            BuyResult.PENDING -> pending = product
            else -> {}
        }
        return result
    }

    /** A test launch that asks for Plus (TestLaunch.PLUS): owned from the start, as if bought. */
    fun ownForTest() = own(PlusProduct.PLUS)

    /** Play confirmed a pending payment (what the real store hears from Play's purchase updates). */
    fun confirmPending() { pending?.let { own(it); pending = null } }

    private fun own(product: PlusProduct) {
        val now = if (product == PlusProduct.PLUS) PlusOwned.PLUS else PlusOwned.FAMILY
        sp.edit().putString(KEY, now.name).apply()
        owned = now
    }

    override suspend fun restore(): RestoreResult =
        kotlinx.coroutines.delay(latencyMs).let { nextRestore }?.also { nextRestore = null } ?: if (owned == PlusOwned.NONE) RestoreResult.NONE else RestoreResult.FOUND

    override fun purchase() = when (owned) {
        PlusOwned.NONE -> null
        PlusOwned.PLUS -> app.habits.account.StorePurchase(PlusProduct.PLUS.id, token())
        PlusOwned.FAMILY -> app.habits.account.StorePurchase(PlusProduct.FAMILY.id, token())
    }

    /**
     * This install's stand-in purchase token, "stand-in-<random>": the dev Worker counts it as bought, and gives one
     * purchase to one account, as Google's real tokens are; production never counts it.
     */
    private fun token(): String = sp.getString(TOKEN, null) ?: ("stand-in-" + java.util.UUID.randomUUID()).also { sp.edit().putString(TOKEN, it).apply() }

    /** Back to the free plan (tests). */
    fun reset() { sp.edit().remove(KEY).apply(); owned = PlusOwned.NONE; pending = null }

    companion object { private const val KEY = "owned"; private const val TOKEN = "token" }
}

/** A release build before Play Billing is connected: nothing can be bought yet, and nothing is ever taken away. */
object NoPlusStore : PlusStore {
    override val owned = PlusOwned.NONE
    override val pending: PlusProduct? = null
    override val canBuy = false
    override fun price(product: PlusProduct): String? = null
    override suspend fun buy(activity: Activity, product: PlusProduct) = BuyResult.UNAVAILABLE
    override suspend fun restore() = RestoreResult.COULD_NOT_CONNECT
    override fun purchase(): app.habits.account.StorePurchase? = null
}

/*
 * **No code unlocks Plus on this phone.** There used to be a `PlusCodes` class here that turned Plus on when a
 * reviewer typed a fingerprinted code into Plus & Account. It is gone (22 Oct 2026, the user: "nothing unlocks a
 * Plus on device. A Plus should be always and only unlocked through Google Play Store"). Reviewers and anyone whose
 * Plus did not come back are given a **Google Play promo code** instead, which Play redeems, so Plus still arrives
 * the one way it ever does (Rulebook D16; the restore flows 3.7 and 5.6).
 */
