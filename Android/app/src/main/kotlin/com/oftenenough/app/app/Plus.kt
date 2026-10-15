package com.oftenenough.app.app

import android.app.Activity
import android.content.SharedPreferences
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue

/** Plus and Plus Family, one-time purchases with the iPhone's own product IDs (iOS/Habits/Plus/PlusProduct.swift). */
enum class PlusProduct(val id: String, val title: String, val who: String) {
    PLUS("com.oftenenough.app.plus", "Plus", "Just you"),
    FAMILY("com.oftenenough.app.plusfamily", "Plus Family", "You + 5 people, each with their own habits"),
    /** Plus → Plus Family, for the difference. */
    FAMILY_UPGRADE("com.oftenenough.app.plusfamily.upgrade", "Plus Family upgrade", "Upgrade from Plus"),
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
    fun purchase(): com.oftenenough.app.app.account.PlayPurchase?
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
        PlusOwned.PLUS -> com.oftenenough.app.app.account.PlayPurchase(PlusProduct.PLUS.id, "stand-in")
        PlusOwned.FAMILY -> com.oftenenough.app.app.account.PlayPurchase(PlusProduct.FAMILY.id, "stand-in")
    }

    /** Back to the free plan (tests). */
    fun reset() { sp.edit().remove(KEY).apply(); owned = PlusOwned.NONE; pending = null }

    companion object { private const val KEY = "owned" }
}

/** A release build before Play Billing is connected: nothing can be bought yet, and nothing is ever taken away. */
object NoPlusStore : PlusStore {
    override val owned = PlusOwned.NONE
    override val pending: PlusProduct? = null
    override val canBuy = false
    override fun price(product: PlusProduct): String? = null
    override suspend fun buy(activity: Activity, product: PlusProduct) = BuyResult.UNAVAILABLE
    override suspend fun restore() = RestoreResult.COULD_NOT_CONNECT
    override fun purchase(): com.oftenenough.app.app.account.PlayPurchase? = null
}
