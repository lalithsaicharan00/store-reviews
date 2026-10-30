package com.oftenenough.app.app

import android.app.Activity
import android.content.SharedPreferences
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue

/** Plus, a one-time purchase with the iPhone's own product ID. No Plus Family since 21 Oct 2026 (D16). */
enum class PlusProduct(val id: String, val title: String) {
    PLUS("com.oftenenough.app.plus", "Plus"),
}

/** What this phone's Google Play account owns: nothing, or Plus. */
enum class PlusOwned { NONE, PLUS }

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
 * debug builds and tests until then. Plus bought on an iPhone is moved across by support, by hand (D16); a code
 * ([PlusCodes]) also gives it. An ended or missing purchase never hides data (D10): it only stops adding a 6th habit
 * and the Plus widgets.
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

    @Suppress("UNUSED_PARAMETER")
    private fun own(product: PlusProduct) {
        sp.edit().putString(KEY, PlusOwned.PLUS.name).apply()
        owned = PlusOwned.PLUS
    }

    override suspend fun restore(): RestoreResult =
        kotlinx.coroutines.delay(latencyMs).let { nextRestore }?.also { nextRestore = null } ?: if (owned == PlusOwned.NONE) RestoreResult.NONE else RestoreResult.FOUND

    /** Back to the free plan (tests). */
    fun reset() { sp.edit().remove(KEY).apply(); owned = PlusOwned.NONE; pending = null }

    companion object { private const val KEY = "owned" }
}

/*
 * **No code unlocks Plus on this phone.** There used to be a `PlusCodes` class here that turned Plus on when a
 * reviewer typed a fingerprinted code into Plus & Account. It is gone (22 Oct 2026, the user: "nothing unlocks a
 * Plus on device. A Plus should be always and only unlocked through Google Play Store"). Reviewers and anyone whose
 * Plus did not come back are given a **Google Play promo code** instead, which Play redeems, so Plus still arrives
 * the one way it ever does (Rulebook D16; the restore flows 3.7 and 5.6).
 */
