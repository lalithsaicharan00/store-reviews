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

    /** Play confirmed a pending payment (what the real store hears from Play's purchase updates). */
    fun confirmPending() { pending?.let { own(it); pending = null } }

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

/** A release build before Play Billing is connected: nothing can be bought yet, and nothing is ever taken away. */
object NoPlusStore : PlusStore {
    override val owned = PlusOwned.NONE
    override val pending: PlusProduct? = null
    override val canBuy = false
    override fun price(product: PlusProduct): String? = null
    override suspend fun buy(activity: Activity, product: PlusProduct) = BuyResult.UNAVAILABLE
    override suspend fun restore() = RestoreResult.COULD_NOT_CONNECT
}

/**
 * Plus from a code (Play's "Sign in details": reviewers must be able to "fully and freely access and review the app
 * behind the paywall"). Entering a valid code in Plus & Account › Redeem a code unlocks Plus on this phone, kept in its
 * own file (a test launch's own, D8). Only each code's SHA-256 is in the app, never the code itself (the repository is
 * public, D11): the user chooses a code, keeps it in their password manager and gives it only to Google's reviewers.
 * A code is retired by removing its fingerprint in an update. Codes are letters and digits; spaces, dashes and case
 * don't matter.
 */
class PlusCodes(private val sp: SharedPreferences, private val valid: Set<String> = VALID) {
    var redeemed by mutableStateOf(sp.getString(KEY, null)?.let { it in valid } == true); private set

    /** True when [code] is one of ours; Plus is then on for good on this phone (until the code is retired). */
    fun redeem(code: String): Boolean {
        val fingerprint = fingerprint(code)
        if (fingerprint !in valid) return false
        sp.edit().putString(KEY, fingerprint).commit()
        redeemed = true
        return true
    }

    companion object {
        private const val KEY = "redeemed"
        /** The fingerprints of the codes that unlock Plus (SHA-256 of the normalized code, lowercase hex). */
        val VALID: Set<String> = setOf(
            // Google Play's reviewers (Sign in details). The codes are in Play Console and the user's password manager only.
            // The random code (15 Oct 2026), for Production:
            "8eaa5ce9c8252991256157e21204146ab6ae23c4eff0732214eb4028531086bb",
            // The first, guessable code: kept only until Sign in details has the random one and a version with it is
            // live; then remove it (Google Play — Setup and Declarations, "Still open").
            "aa51aff518a8db3d72a25d5ababccbec9d8713c5ecf66139b8a43ac28767cb0d",
        )

        fun normalize(code: String) = code.uppercase().filter { it in 'A'..'Z' || it in '0'..'9' }
        fun fingerprint(code: String): String =
            java.security.MessageDigest.getInstance("SHA-256").digest(normalize(code).toByteArray()).joinToString("") { "%02x".format(it) }
    }
}
