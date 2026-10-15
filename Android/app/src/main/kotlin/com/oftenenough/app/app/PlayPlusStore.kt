package com.oftenenough.app.app

import android.app.Activity
import android.content.Context
import android.content.SharedPreferences
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import com.android.billingclient.api.AcknowledgePurchaseParams
import com.android.billingclient.api.BillingClient
import com.android.billingclient.api.BillingClientStateListener
import com.android.billingclient.api.BillingFlowParams
import com.android.billingclient.api.BillingResult
import com.android.billingclient.api.PendingPurchasesParams
import com.android.billingclient.api.ProductDetails
import com.android.billingclient.api.Purchase
import com.android.billingclient.api.QueryProductDetailsParams
import com.android.billingclient.api.QueryPurchasesParams
import com.android.billingclient.api.acknowledgePurchase
import com.android.billingclient.api.queryProductDetails
import com.android.billingclient.api.queryPurchasesAsync
import com.oftenenough.app.app.account.PlayPurchase
import kotlinx.coroutines.CompletableDeferred
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.withTimeoutOrNull

/**
 * Plus through Google Play Billing (Billing Library 9): Play's own purchase sheet, prices in the buyer's currency,
 * pending payments, restore, and every purchase **acknowledged** (Play refunds one that isn't within 3 days).
 *
 * - **What's owned comes from Play**, asked on every launch and return; the last answer is kept in a small file so
 *   Plus shows at once on an offline start. A refunded or revoked purchase disappears from Play's answer and Plus goes
 *   with it, but nothing else changes (D10: an ended purchase never hides data).
 * - Plus Family, or the upgrade to it, owns Family; Plus alone owns Plus.
 * - The Plus account's server checks each purchase with Google later (D16); the phone never trusts anything but Play.
 */
class PlayPlusStore(context: Context, private val scope: CoroutineScope, private val sp: SharedPreferences) : PlusStore {
    override var owned by mutableStateOf(runCatching { PlusOwned.valueOf(sp.getString(KEY_OWNED, "NONE")!!) }.getOrDefault(PlusOwned.NONE)); private set
    override var pending by mutableStateOf<PlusProduct?>(null); private set
    override val canBuy = true

    private var details by mutableStateOf<Map<String, ProductDetails>>(emptyMap())
    private var purchases: List<Purchase> = emptyList()
    /** The purchase sheet open now: its answer comes back through [onPurchasesUpdated]. */
    private var buying: CompletableDeferred<BillingResult>? = null

    private val client: BillingClient = BillingClient.newBuilder(context.applicationContext)
        .setListener { result, list -> onPurchasesUpdated(result, list.orEmpty()) }
        .enablePendingPurchases(PendingPurchasesParams.newBuilder().enableOneTimeProducts().build())
        .enableAutoServiceReconnection()
        .build()

    init { scope.launch { refresh() } }

    // ------------------------------------------------------------------ Connection

    private suspend fun connected(): Boolean {
        if (client.isReady) return true
        val done = CompletableDeferred<Boolean>()
        client.startConnection(object : BillingClientStateListener {
            override fun onBillingSetupFinished(result: BillingResult) { done.complete(result.responseCode == BillingClient.BillingResponseCode.OK) }
            override fun onBillingServiceDisconnected() { if (!done.isCompleted) done.complete(false) }
        })
        return withTimeoutOrNull(10_000) { done.await() } ?: false
    }

    // ------------------------------------------------------------------ Prices and products

    override fun price(product: PlusProduct): String? = details[product.id]?.oneTimePurchaseOfferDetails?.formattedPrice

    private suspend fun loadDetails(): Boolean {
        if (details.size == PlusProduct.entries.size) return true
        if (!connected()) return false
        val params = QueryProductDetailsParams.newBuilder().setProductList(PlusProduct.entries.map {
            QueryProductDetailsParams.Product.newBuilder().setProductId(it.id).setProductType(BillingClient.ProductType.INAPP).build()
        }).build()
        val result = client.queryProductDetails(params)
        if (result.billingResult.responseCode != BillingClient.BillingResponseCode.OK) return false
        details = result.productDetailsList.orEmpty().associateBy { it.productId }
        return details.isNotEmpty()
    }

    // ------------------------------------------------------------------ What's owned

    /** Asks Play what this Google account owns, acknowledges anything new and updates [owned]. False when offline. */
    suspend fun refresh(): Boolean {
        if (!connected()) return false
        loadDetails()
        val result = client.queryPurchasesAsync(QueryPurchasesParams.newBuilder().setProductType(BillingClient.ProductType.INAPP).build())
        if (result.billingResult.responseCode != BillingClient.BillingResponseCode.OK) return false
        apply(result.purchasesList)
        return true
    }

    private suspend fun apply(list: List<Purchase>) {
        purchases = list
        for (p in list) if (p.purchaseState == Purchase.PurchaseState.PURCHASED && !p.isAcknowledged) acknowledge(p)
        val bought = list.filter { it.purchaseState == Purchase.PurchaseState.PURCHASED }.flatMap { it.products }.toSet()
        val now = when {
            PlusProduct.FAMILY.id in bought || PlusProduct.FAMILY_UPGRADE.id in bought -> PlusOwned.FAMILY
            PlusProduct.PLUS.id in bought -> PlusOwned.PLUS
            else -> PlusOwned.NONE
        }
        if (now != owned) { owned = now; sp.edit().putString(KEY_OWNED, now.name).apply() }
        pending = if (now != PlusOwned.NONE) null else list.firstOrNull { it.purchaseState == Purchase.PurchaseState.PENDING }
            ?.products?.firstNotNullOfOrNull { id -> PlusProduct.entries.firstOrNull { it.id == id } }
    }

    private suspend fun acknowledge(p: Purchase) {
        // Repeating it is harmless; a failure is tried again on the next refresh (within Play's 3 days).
        runCatching { client.acknowledgePurchase(AcknowledgePurchaseParams.newBuilder().setPurchaseToken(p.purchaseToken).build()) }
    }

    override fun purchase(): PlayPurchase? {
        val bought = purchases.filter { it.purchaseState == Purchase.PurchaseState.PURCHASED }
        val best = bought.firstOrNull { p -> p.products.any { it == PlusProduct.FAMILY.id || it == PlusProduct.FAMILY_UPGRADE.id } }
            ?: bought.firstOrNull { PlusProduct.PLUS.id in it.products } ?: return null
        return PlayPurchase(best.products.first(), best.purchaseToken)
    }

    // ------------------------------------------------------------------ Buying

    override suspend fun buy(activity: Activity, product: PlusProduct): BuyResult {
        if (!loadDetails()) return BuyResult.NOT_COMPLETED
        val item = details[product.id] ?: return BuyResult.UNAVAILABLE
        val params = BillingFlowParams.newBuilder().setProductDetailsParamsList(listOf(
            BillingFlowParams.ProductDetailsParams.newBuilder().setProductDetails(item).build(),
        )).build()
        val answer = CompletableDeferred<BillingResult>().also { buying = it }
        val launched = client.launchBillingFlow(activity, params)
        if (launched.responseCode != BillingClient.BillingResponseCode.OK) { buying = null; return map(launched) }
        val result = answer.await()
        buying = null
        return when (result.responseCode) {
            BillingClient.BillingResponseCode.OK -> when {
                owned != PlusOwned.NONE -> BuyResult.BOUGHT
                pending != null -> BuyResult.PENDING
                else -> BuyResult.NOT_COMPLETED
            }
            BillingClient.BillingResponseCode.ITEM_ALREADY_OWNED -> { refresh(); if (owned != PlusOwned.NONE) BuyResult.BOUGHT else BuyResult.NOT_COMPLETED }
            else -> map(result)
        }
    }

    private fun map(result: BillingResult): BuyResult = when (result.responseCode) {
        BillingClient.BillingResponseCode.USER_CANCELED -> BuyResult.CANCELLED
        BillingClient.BillingResponseCode.BILLING_UNAVAILABLE, BillingClient.BillingResponseCode.FEATURE_NOT_SUPPORTED -> BuyResult.UNAVAILABLE
        else -> BuyResult.NOT_COMPLETED
    }

    /** Play's answer to the purchase sheet, and to a pending payment completing later (even after the app restarted). */
    private fun onPurchasesUpdated(result: BillingResult, list: List<Purchase>) {
        scope.launch {
            if (result.responseCode == BillingClient.BillingResponseCode.OK) {
                // Play gives only the purchases that changed: ask again for the whole picture.
                if (!refresh()) apply(purchases + list)
            }
            buying?.complete(result)
        }
    }

    override suspend fun restore(): RestoreResult = when {
        !refresh() -> RestoreResult.COULD_NOT_CONNECT
        owned != PlusOwned.NONE -> RestoreResult.FOUND
        else -> RestoreResult.NONE
    }

    companion object { private const val KEY_OWNED = "owned" }
}
