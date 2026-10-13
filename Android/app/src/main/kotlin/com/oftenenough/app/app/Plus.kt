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
    FAMILY_UPGRADE("com.oftenenough.app.plusfamily.upgrade", "Plus Family", "Upgrade from Plus"),
}

/** What this phone's Google account owns: nothing, Plus, or Plus Family. */
enum class PlusOwned { NONE, PLUS, FAMILY }

/**
 * Where purchases come from (build prompt §5): Google Play Billing once the Play Console app exists, a fake store in
 * debug builds and tests until then. The cross-store entitlement record (D16, later) is another source behind the same
 * seam. An ended or missing purchase never hides data (D10): it only stops adding a 6th habit and the Plus widgets.
 */
interface PlusStore {
    val owned: PlusOwned
    /** The price Play shows for [product] ("$24.99"), or null before Play has answered. */
    fun price(product: PlusProduct): String?
    /** Opens Play's purchase sheet; [done] says what happened, in words for the person, or null when it went through. */
    fun buy(activity: Activity, product: PlusProduct, done: (String?) -> Unit)
    /** Asks Play again what this account owns. [done] gets the words to show. */
    fun restore(done: (String) -> Unit)
    /** Whether buying works on this build at all. */
    val canBuy: Boolean
}

/**
 * The stand-in store: buying succeeds at once, with US prices, and is remembered in its own file (a test launch's is
 * emptied each launch, D8). Never in a release build.
 */
class FakePlusStore(private val sp: SharedPreferences) : PlusStore {
    override var owned by mutableStateOf(runCatching { PlusOwned.valueOf(sp.getString(KEY, "NONE")!!) }.getOrDefault(PlusOwned.NONE)); private set
    override val canBuy = true

    override fun price(product: PlusProduct): String = when (product) {
        PlusProduct.PLUS -> "$24.99"
        PlusProduct.FAMILY -> "$59.99"
        PlusProduct.FAMILY_UPGRADE -> "$35.00"
    }

    override fun buy(activity: Activity, product: PlusProduct, done: (String?) -> Unit) {
        val now = if (product == PlusProduct.PLUS) PlusOwned.PLUS else PlusOwned.FAMILY
        sp.edit().putString(KEY, now.name).apply()
        owned = now
        done(null)
    }

    override fun restore(done: (String) -> Unit) {
        done(if (owned == PlusOwned.NONE) "No purchase found for this Google account." else "Plus is on this phone.")
    }

    /** Back to the free plan (tests). */
    fun reset() { sp.edit().remove(KEY).apply(); owned = PlusOwned.NONE }

    companion object { private const val KEY = "owned" }
}

/** A release build before Play Billing is connected: nothing can be bought yet, and nothing is ever taken away. */
object NoPlusStore : PlusStore {
    override val owned = PlusOwned.NONE
    override val canBuy = false
    override fun price(product: PlusProduct): String? = null
    override fun buy(activity: Activity, product: PlusProduct, done: (String?) -> Unit) = done("Buying isn't available on this version yet.")
    override fun restore(done: (String) -> Unit) = done("Buying isn't available on this version yet.")
}
