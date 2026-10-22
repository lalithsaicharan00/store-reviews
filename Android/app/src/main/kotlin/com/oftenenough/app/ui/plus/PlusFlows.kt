package com.oftenenough.app.ui.plus

import androidx.activity.compose.LocalActivity
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.rounded.Email
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.drawBehind
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.onSizeChanged
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.unit.dp
import com.oftenenough.app.app.BuyResult
import com.oftenenough.app.app.PlusOwned
import com.oftenenough.app.app.PlusProduct
import com.oftenenough.app.app.PlusStore
import com.oftenenough.app.app.RestoreResult
import com.oftenenough.app.ui.newhabit.FormPage
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch

/** Where a Plus flow goes when it's finished. */
interface PlusFlowNav {
    /** Back to the Plus page (closing the flow), with words for a snackbar there. */
    fun toPage(message: String? = null)
    /** Back to the Plus page, showing "No Plus found" over it (Figma 4.2). */
    fun toPageNoPlusFound()
    fun getPlus()
    fun restore()
}

// ==================================================================== 2 · Get Plus, and buying

/**
 * Get Plus (Figma 2): what you get and where it works; the button pinned at the bottom names its price. Buying opens
 * Google Play's own sheet (2.1); then back to the Plus page with thanks, Play's wait for a payment (2.1.1) or "Payment
 * not completed" (2.1.2). No accounts and no Plus Family since 21 Oct 2026 (D16).
 */
@Composable
fun GetPlusScreen(plus: PlusStore, nav: PlusFlowNav, onBack: () -> Unit) {
    val c = appColors
    val activity = LocalActivity.current
    val scope = rememberCoroutineScope()
    var step by rememberSaveable { mutableStateOf("choose") }
    var notCompleted by rememberSaveable { mutableStateOf(false) }
    var buying by rememberSaveable { mutableStateOf(false) }
    var bottomHeight by androidx.compose.runtime.remember { mutableIntStateOf(0) }
    val product = PlusProduct.PLUS

    fun buy() {
        val a = activity ?: return
        if (buying) return
        scope.launch {
            buying = true
            val result = plus.buy(a, product)
            buying = false
            when (result) {
                BuyResult.BOUGHT -> nav.toPage("Plus is yours. Thank you.")
                BuyResult.PENDING -> step = "pending"
                BuyResult.NOT_COMPLETED -> notCompleted = true
                BuyResult.CANCELLED -> {}
                BuyResult.UNAVAILABLE -> nav.toPage("Buying isn’t available on this version yet. Everything you have stays yours.")
            }
        }
    }

    // A pending payment Play confirms while this screen is open turns into the thanks by itself (2.1.1: "Plus turns on by itself").
    LaunchedEffect(step, plus.owned) {
        if (step == "pending" && plus.owned != PlusOwned.NONE) nav.toPage("Plus is yours. Thank you.")
    }

    when (step) {
        "pending" -> CenterScreen("Waiting for your payment", "Plus turns on as soon as Google Play confirms it.", "Close", "plus-pending", { nav.toPage() })
        "choose" -> Box(Modifier.fillMaxSize().background(c.screen)) {
            FormPage("Get Plus", chip = null, onBack = onBack) {
                Spacer(Modifier.height(12.dp))
                Column(verticalArrangement = Arrangement.spacedBy(20.dp)) {
                    Row(Modifier.padding(start = 4.dp), verticalAlignment = Alignment.CenterVertically) {
                        AppIconTile(48.dp)
                        Spacer(Modifier.width(16.dp))
                        Column(Modifier.semantics(mergeDescendants = true) { heading() }, verticalArrangement = Arrangement.spacedBy(2.dp)) {
                            Text("Plus", style = AppType.titleLargeEmphasized, color = c.ink)
                            Text("One payment, yours forever.", style = AppType.bodyMedium, color = c.secondary)
                        }
                    }
                    WhiteCard {
                        CheckLine("Unlimited habits")
                        CheckLine("Sync across all your devices", "Through your own Google Drive.")
                        CheckLine("More widgets")
                        HorizontalDivider(color = c.tonal)
                        WorksOn()
                    }
                }
                Spacer(Modifier.height(with(LocalDensity.current) { bottomHeight.toDp() }))
            }
            Column(Modifier.align(Alignment.BottomCenter).fillMaxWidth()
                // Figma 2: a soft shadow cast upward over the content scrolling under it (0, -4, blur 12, black 6 %).
                .drawBehind {
                    val h = 16.dp.toPx()
                    drawRect(Brush.verticalGradient(listOf(Color.Transparent, Color.Black.copy(alpha = 0.06f)), startY = -h, endY = 0f),
                        topLeft = Offset(0f, -h), size = Size(size.width, h))
                }
                .background(c.screen).navigationBarsPadding()
                .padding(start = 16.dp, end = 16.dp, top = 12.dp, bottom = 8.dp).onSizeChanged { bottomHeight = it.height },
                verticalArrangement = Arrangement.spacedBy(4.dp)) {
                val price = plus.price(product)
                MainButton("Get Plus" + (price?.let { " · $it" } ?: ""), "plus-buy",
                    enabled = plus.canBuy && !buying) { buy() }
                QuietButton("I already have Plus", "plus-already", height = 40.dp) { nav.restore() }
            }
        }
    }
    if (notCompleted) PlusDialog(Symbols.Error, "Payment not completed",
        "Nothing was charged. Check your payment method in Google Play, then try again.", "Try again",
        { notCompleted = false; buy() }, { notCompleted = false }, tag = "dialog-payment")
}

// ==================================================================== 4 · Restore from Google Play

/** 4 · Looking for your purchase, then 4.1 Plus is back, 4.2 No Plus found (over the page) or 4.3 Couldn't connect. */
@Composable
fun RestoreFlow(plus: PlusStore, nav: PlusFlowNav) {
    var step by rememberSaveable { mutableStateOf("looking") }
    var attempt by rememberSaveable { mutableIntStateOf(0) }
    LaunchedEffect(attempt) {
        if (step != "looking") return@LaunchedEffect
        when (plus.restore()) {
            RestoreResult.FOUND -> step = "found"
            RestoreResult.NONE -> nav.toPageNoPlusFound()
            RestoreResult.COULD_NOT_CONNECT -> step = "offline"
        }
    }
    when (step) {
        "found" -> FlowScreen(onBack = { nav.toPage() }, tag = "restore-found", showBack = false, bottom = { MainButton("Done", "restore-done") { nav.toPage() } }) {
            Hero(HeroArt.AppIcon, "Plus is back.", "Bought with this Google account.")
            Spacer(Modifier.height(28.dp))
            PointsCard(listOf(
                Point(Symbols.Devices, "Plus on your Android phones", "Signed in to this Google account."),
                Point(Icons.Rounded.Email, "Moving to an iPhone?", "Write to us and we’ll move Plus across."),
            ))
        }
        "offline" -> CenterScreen("Couldn’t connect", "We couldn’t reach Google Play. Check your internet connection, then try again.", "Cancel", "restore-offline",
            { nav.toPage() }, icon = Symbols.WifiOff, main = "Try again", onMain = { step = "looking"; attempt++ })
        else -> CenterScreen("Looking for your purchase", "On this Google account", "Cancel", "restore-looking", { nav.toPage() })
    }
}
