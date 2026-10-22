package com.oftenenough.app.ui.plus

import androidx.activity.compose.LocalActivity
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.rounded.AddCircleOutline
import androidx.compose.material.icons.rounded.Refresh
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
import androidx.compose.foundation.selection.selectable
import androidx.compose.foundation.selection.selectableGroup
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.RadioButton
import androidx.compose.material3.RadioButtonDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.layout.onSizeChanged
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import com.oftenenough.app.app.BuyResult
import com.oftenenough.app.app.PlusOwned
import com.oftenenough.app.app.PlusProduct
import com.oftenenough.app.app.PlusStore
import com.oftenenough.app.app.RestoreResult
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.newhabit.FormPage
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch

/**
 * **Plus** — the menu's third row (Figma `12:5259`).
 *
 * Plus is a one-time purchase on Google Play, and **Google Play is the only thing that ever grants it** (Rulebook
 * D16; the user, 22 Oct 2026). There is no account, no family record on a server of ours and no code to type in:
 * Cloudflare is gone. What this page can do is therefore exactly what Play can do — show what Plus unlocks, buy it,
 * and ask Play again what this Google account already owns.
 *
 * The user is designing this screen; until that arrives this is the plain, native version of it.
 */
@Composable
fun PlusPage(store: HabitStore, plus: PlusStore, onGetPlus: () -> Unit, onBack: () -> Unit, onSaid: (String) -> Unit) {
    val c = appColors
    val scope = rememberCoroutineScope()
    var asking by remember { mutableStateOf(false) }
    val owned = plus.owned
    FormPage("Plus", chip = null, onBack = onBack) {
        Spacer(Modifier.height(12.dp))
        Column(verticalArrangement = Arrangement.spacedBy(20.dp), modifier = Modifier.semantics { testTag = "plus-page" }) {
            Row(Modifier.padding(start = 4.dp), verticalAlignment = Alignment.CenterVertically) {
                AppIconTile(48.dp)
                Spacer(Modifier.width(16.dp))
                Column(Modifier.semantics(mergeDescendants = true) { heading() }, verticalArrangement = Arrangement.spacedBy(2.dp)) {
                    Text(if (owned == PlusOwned.FAMILY) "Plus Family" else "Plus", style = AppType.titleLargeEmphasized, color = c.ink)
                    Text(
                        when (owned) {
                            PlusOwned.NONE -> "One payment, yours forever."
                            else -> "Yours. Thank you."
                        },
                        style = AppType.bodyMedium, color = c.secondary,
                    )
                }
            }
            WhiteCard {
                CheckLine("Unlimited habits", "Free keeps ${HabitStore.FREE_HABIT_LIMIT} going at once.")
                CheckLine("Sync across all your devices", "Through your own Google Drive. We never see your habits.")
                CheckLine("More widgets")
                HorizontalDivider(color = c.tonal)
                WorksOn()
            }
            if (owned == PlusOwned.NONE) {
                val used = store.habits.count { !it.archived && it.kind != com.oftenenough.app.data.HabitKind.Task }
                val limit = HabitStore.FREE_HABIT_LIMIT
                Text(
                    if (used >= limit) "You’re using all $limit free habits." else "$used of $limit free habits used.",
                    Modifier.padding(start = 16.dp), style = AppType.bodyMedium, color = c.secondary,
                )
                MainButton("Get Plus", "plus-get", onClick = onGetPlus)
            }
            QuietButton(if (asking) "Checking with Google Play…" else "Check Google Play again", "plus-restore") {
                if (asking) return@QuietButton
                scope.launch {
                    asking = true
                    val answer = plus.restore()
                    asking = false
                    onSaid(
                        when (answer) {
                            RestoreResult.FOUND -> "Plus is on this phone."
                            RestoreResult.NONE -> "No Plus on this Google account. Open the Play Store and switch to the account you bought it with."
                            RestoreResult.COULD_NOT_CONNECT -> "Couldn’t reach Google Play. Check your internet connection, then try again."
                        },
                    )
                }
            }
            Text(
                "Plus comes from Google Play, and only from Google Play. Your habits stay on this phone and in your own Google Drive — we never see them, and we keep no account for you.",
                Modifier.padding(horizontal = 16.dp), style = AppType.bodySmall, color = c.secondary,
            )
        }
        Spacer(Modifier.height(24.dp))
    }
}

/**
 * Get Plus: the plan first, then what it unlocks and where it works; the button at the bottom names the plan and its
 * price. Buying opens **Google Play's own sheet**, and Play's answer is the only thing that turns Plus on.
 */
@Composable
fun GetPlusScreen(plus: PlusStore, upgrade: Boolean, onDone: (String?) -> Unit, onBack: () -> Unit) {
    val c = appColors
    val activity = LocalActivity.current
    val scope = rememberCoroutineScope()
    var family by rememberSaveable { mutableStateOf(upgrade) }
    var pending by rememberSaveable { mutableStateOf(false) }
    var notCompleted by rememberSaveable { mutableStateOf(false) }
    var buying by rememberSaveable { mutableStateOf(false) }
    var bottomHeight by remember { mutableIntStateOf(0) }
    val product = if (upgrade) PlusProduct.FAMILY_UPGRADE else if (family) PlusProduct.FAMILY else PlusProduct.PLUS

    fun buy() {
        val a = activity ?: return
        if (buying) return
        scope.launch {
            buying = true
            val result = plus.buy(a, product)
            buying = false
            when (result) {
                BuyResult.BOUGHT -> onDone("Plus is yours. Thank you.")
                BuyResult.PENDING -> pending = true
                BuyResult.NOT_COMPLETED -> notCompleted = true
                BuyResult.CANCELLED -> Unit
                BuyResult.UNAVAILABLE -> onDone("Buying isn’t available on this version yet. Everything you have stays yours.")
            }
        }
    }

    // A payment Play confirms while this screen is open turns Plus on by itself.
    LaunchedEffect(pending, plus.owned) {
        if (pending && plus.owned != PlusOwned.NONE) onDone("Plus is yours. Thank you.")
    }

    if (pending) {
        CenterScreen("Waiting for your payment", "Plus turns on as soon as Google Play confirms it.", "Close", "plus-pending", { onDone(null) })
    } else Box(Modifier.fillMaxSize().background(c.screen)) {
        FormPage(if (upgrade) "Plus Family" else "Get Plus", chip = null, onBack = onBack) {
            Spacer(Modifier.height(12.dp))
            Column(verticalArrangement = Arrangement.spacedBy(20.dp)) {
                Row(Modifier.padding(start = 4.dp), verticalAlignment = Alignment.CenterVertically) {
                    AppIconTile(48.dp)
                    Spacer(Modifier.width(16.dp))
                    Column(Modifier.semantics(mergeDescendants = true) { heading() }, verticalArrangement = Arrangement.spacedBy(2.dp)) {
                        Text(if (upgrade) "Plus Family" else "Plus", style = AppType.titleLargeEmphasized, color = c.ink)
                        Text(
                            if (upgrade) "You have Plus. Pay only the difference." else "One payment, yours forever.",
                            style = AppType.bodyMedium, color = c.secondary,
                        )
                    }
                }
                if (!upgrade) PlanChoice(plus, family) { family = it }
                WhiteCard {
                    if (upgrade) {
                        CheckLine("Plus for up to 5 more people")
                        CheckLine("Everyone’s habits stay their own", "Nobody sees anyone else’s.")
                    } else {
                        CheckLine("Unlimited habits")
                        CheckLine("Sync across all your devices", "Through your own Google Drive.")
                        CheckLine("More widgets")
                    }
                    HorizontalDivider(color = c.tonal)
                    WorksOn()
                }
            }
            Spacer(Modifier.height(with(LocalDensity.current) { bottomHeight.toDp() }))
        }
        Column(
            Modifier.align(Alignment.BottomCenter).fillMaxWidth().background(c.screen).navigationBarsPadding()
                .padding(start = 16.dp, end = 16.dp, top = 12.dp, bottom = 8.dp).onSizeChanged { bottomHeight = it.height },
            verticalArrangement = Arrangement.spacedBy(4.dp),
        ) {
            val price = plus.price(product)
            MainButton(
                (if (product == PlusProduct.PLUS) "Get Plus" else "Get Plus Family") + (price?.let { " · $it" } ?: ""),
                "plus-buy", enabled = plus.canBuy && !buying,
            ) { buy() }
        }
    }
    if (notCompleted) PlusDialog(
        Symbols.Error, "Payment not completed",
        "Nothing was charged. Check your payment method in Google Play, then try again.", "Try again",
        { notCompleted = false; buy() }, { notCompleted = false }, tag = "dialog-payment",
    )
}

/** Just you or Family: radio rows in one white card, the price on the right. */
@Composable
private fun PlanChoice(plus: PlusStore, family: Boolean, onFamily: (Boolean) -> Unit) {
    val c = appColors
    Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.surface).padding(vertical = 4.dp).selectableGroup()) {
        for ((i, plan) in listOf(PlusProduct.PLUS, PlusProduct.FAMILY).withIndex()) {
            if (i == 1) HorizontalDivider(color = c.tonal2)
            val selected = family == (plan == PlusProduct.FAMILY)
            Row(
                Modifier.fillMaxWidth().selectable(selected, role = Role.RadioButton) { onFamily(plan == PlusProduct.FAMILY) }
                    .padding(start = 16.dp, end = 20.dp, top = 12.dp, bottom = 12.dp)
                    .semantics { testTag = "plan-" + plan.name.lowercase() },
                verticalAlignment = Alignment.CenterVertically,
            ) {
                RadioButton(selected, null, colors = RadioButtonDefaults.colors(selectedColor = c.ink, unselectedColor = c.secondary))
                Spacer(Modifier.width(16.dp))
                Column(Modifier.weight(1f)) {
                    Text(if (plan == PlusProduct.PLUS) "Just you" else "Family", style = AppType.titleMedium, color = c.ink)
                    Text(if (plan == PlusProduct.PLUS) "On all your devices" else "You + 5 people", style = AppType.bodyMedium, color = c.secondary)
                }
                Text(plus.price(plan) ?: "—", style = AppType.titleMedium, color = c.ink)
            }
        }
    }
}
