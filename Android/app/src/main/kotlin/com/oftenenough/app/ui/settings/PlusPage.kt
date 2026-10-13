package com.oftenenough.app.ui.settings

import android.app.Activity
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.outlined.Email
import androidx.compose.material.icons.outlined.FamilyRestroom
import androidx.compose.material.icons.outlined.Restore
import androidx.compose.material.icons.rounded.AllInclusive
import androidx.compose.material.icons.rounded.Computer
import androidx.compose.material.icons.rounded.Sync
import androidx.compose.material.icons.rounded.TabletAndroid
import androidx.compose.material.icons.rounded.Watch
import androidx.compose.material.icons.rounded.Widgets
import androidx.compose.material3.Icon
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.oftenenough.app.R
import com.oftenenough.app.app.PlusOwned
import com.oftenenough.app.app.PlusProduct
import com.oftenenough.app.app.PlusStore
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.components.InkButton
import com.oftenenough.app.ui.components.ListRow
import com.oftenenough.app.ui.components.Segment
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.components.TonalButton
import com.oftenenough.app.ui.newhabit.FormPage
import com.oftenenough.app.ui.newhabit.GroupTitle
import com.oftenenough.app.ui.newhabit.Note
import com.oftenenough.app.ui.newhabit.RadioRow
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch

/** What Plus adds, one list (design §20; A13–A14: the Wear OS and Windows apps are listed though built later). */
private val plusGives: List<Triple<ImageVector, String, String>> = listOf(
    Triple(Icons.Rounded.AllInclusive, "Unlimited habits", "Free has ${HabitStore.FREE_HABIT_LIMIT}. Add as many as you like."),
    Triple(Icons.Rounded.Widgets, "More widgets", "Today's list and This week"),
    Triple(Icons.Rounded.TabletAndroid, "Tablet", "The whole app on your Android tablet"),
    Triple(Icons.Rounded.Watch, "Wear OS watch", "Tick off habits from your wrist"),
    Triple(Icons.Rounded.Computer, "Windows app", "Your habits on your PC"),
    Triple(Icons.Rounded.Sync, "Synced through Google Drive", "A change on one shows on all of them"),
)

/**
 * ≡ › Plus (design §20; W6: state before offers). Without Plus: the price first, how many free habits are used, the two
 * plans, what Plus adds, then Get Plus and Restore purchases pinned (Restore only where you buy, Current Work 103). With
 * Plus: what you have, and Plus Family for the difference.
 */
@Composable
fun PlusPage(store: HabitStore, plus: PlusStore, snackbar: SnackbarHostState, onContact: () -> Unit, onBack: () -> Unit) {
    val c = appColors
    val activity = LocalContext.current as? Activity
    val scope = rememberCoroutineScope()
    var chosen by rememberSaveable { mutableStateOf(PlusProduct.PLUS) }
    val say: (String) -> Unit = { m -> scope.launch { snackbar.showSnackbar(m) } }
    val owned = plus.owned
    Box(Modifier.fillMaxSize().background(c.screen)) {
        FormPage("Plus", chip = null, onBack = onBack) {
            Spacer(Modifier.height(8.dp))
            Row(verticalAlignment = Alignment.CenterVertically) {
                Box(Modifier.size(80.dp).clip(RoundedCornerShape(20.dp)).background(c.surface), contentAlignment = Alignment.Center) {
                    Image(painterResource(if (c.dark) R.drawable.mark_dark else R.drawable.mark_light), null, Modifier.size(60.dp))
                }
                Spacer(Modifier.width(16.dp))
                Column(Modifier.semantics(mergeDescendants = true) { heading() }) {
                    Text(if (owned == PlusOwned.NONE) "Plus" else if (owned == PlusOwned.FAMILY) "Plus Family is yours" else "Plus is yours",
                        style = MaterialTheme.typography.headlineMedium.copy(fontSize = 32.sp), color = c.ink)
                    Text(if (owned == PlusOwned.NONE) "One payment, yours forever." else "Yours forever", style = MaterialTheme.typography.bodyLarge, color = c.secondary)
                }
            }
            Spacer(Modifier.height(16.dp))
            if (owned == PlusOwned.NONE) {
                val used = store.activeHabitCount
                Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.surface).padding(20.dp).semantics(mergeDescendants = true) { testTag = "plus-used" }) {
                    Row {
                        Text("${minOf(used, HabitStore.FREE_HABIT_LIMIT)} of ${HabitStore.FREE_HABIT_LIMIT} free habits used", Modifier.weight(1f),
                            style = MaterialTheme.typography.bodyLarge.copy(fontWeight = FontWeight.Medium), color = c.ink)
                        Text(maxOf(0, HabitStore.FREE_HABIT_LIMIT - used).let { if (it == 0) "None left" else "$it left" }, style = MaterialTheme.typography.bodyLarge, color = c.secondary)
                    }
                    Spacer(Modifier.height(12.dp))
                    LinearProgressIndicator({ minOf(1f, used / HabitStore.FREE_HABIT_LIMIT.toFloat()) }, Modifier.fillMaxWidth().height(6.dp),
                        color = c.ink, trackColor = c.tonal, strokeCap = StrokeCap.Round, gapSize = 0.dp, drawStopIndicator = {})
                }
                Spacer(Modifier.height(16.dp))
                SegmentedList {
                    PlanRow(PlusProduct.PLUS, plus, chosen == PlusProduct.PLUS, 0) { chosen = PlusProduct.PLUS }
                    PlanRow(PlusProduct.FAMILY, plus, chosen == PlusProduct.FAMILY, 1) { chosen = PlusProduct.FAMILY }
                }
                GroupTitle("What you get with Plus")
                Gives()
                if (!plus.canBuy) Note("Buying isn't available on this version yet. Everything you have stays yours.")
                Spacer(Modifier.height(160.dp))
            } else {
                GroupTitle("What you have with Plus")
                Gives()
                Note("Nothing to sign in to: Plus comes with your Google account, on every phone, tablet and computer signed in to it.")
                if (owned == PlusOwned.PLUS) {
                    Spacer(Modifier.height(16.dp))
                    Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(28.dp)).background(c.surface).padding(20.dp).semantics { testTag = "plus-family-upgrade" }) {
                        Row(verticalAlignment = Alignment.CenterVertically) {
                            Icon(Icons.Outlined.FamilyRestroom, null, tint = c.ink)
                            Spacer(Modifier.width(12.dp))
                            Text("Plus Family", style = MaterialTheme.typography.titleLarge.copy(fontWeight = FontWeight.Medium), color = c.ink)
                        }
                        Spacer(Modifier.height(8.dp))
                        Text("Add up to 5 people from your Google family, each with their own habits.", style = MaterialTheme.typography.bodyLarge, color = c.secondary)
                        Spacer(Modifier.height(16.dp))
                        Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(16.dp)).background(c.screen).padding(16.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
                            PriceLine("Plus Family", plus.price(PlusProduct.FAMILY) ?: "", false)
                            PriceLine("You paid for Plus", "– " + (plus.price(PlusProduct.PLUS) ?: ""), false)
                            PriceLine("You pay", plus.price(PlusProduct.FAMILY_UPGRADE) ?: "", true)
                        }
                        Spacer(Modifier.height(16.dp))
                        InkButton("Upgrade for " + (plus.price(PlusProduct.FAMILY_UPGRADE) ?: ""), {
                            activity?.let { a -> plus.buy(a, PlusProduct.FAMILY_UPGRADE) { m -> say(m ?: "Plus Family is yours.") } }
                        }, Modifier.fillMaxWidth().semantics { testTag = "plus-upgrade" }, enabled = plus.canBuy)
                    }
                }
                Spacer(Modifier.height(16.dp))
                SegmentedList { ListRow("Contact us", 0, 1, icon = Icons.Outlined.Email, chevron = false, onClick = onContact) }
                Spacer(Modifier.height(24.dp))
            }
        }
        if (owned == PlusOwned.NONE) {
            Column(Modifier.align(Alignment.BottomCenter).fillMaxWidth().background(c.screen).navigationBarsPadding().padding(16.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
                val price = plus.price(chosen)
                InkButton(if (chosen == PlusProduct.PLUS) "Get Plus" + (price?.let { " · $it" } ?: "") else "Get Plus Family" + (price?.let { " · $it" } ?: ""), {
                    activity?.let { a -> plus.buy(a, chosen) { m -> say(m ?: (if (chosen == PlusProduct.PLUS) "Plus is yours." else "Plus Family is yours.")) } }
                }, Modifier.fillMaxWidth().semantics { testTag = "plus-buy" }, enabled = plus.canBuy)
                TonalButton("Restore purchases", { plus.restore(say) }, Modifier.fillMaxWidth().semantics { testTag = "plus-restore" }, icon = Icons.Outlined.Restore, height = 56.dp)
            }
        }
    }
}

@Composable
private fun PlanRow(product: PlusProduct, plus: PlusStore, selected: Boolean, index: Int, onClick: () -> Unit) {
    val c = appColors
    Segment(index, 2, Modifier.semantics(mergeDescendants = true) { testTag = "plan-" + product.name.lowercase() }, onClick = onClick, color = if (selected) c.tonal else c.surface) {
        androidx.compose.material3.RadioButton(selected, null, colors = androidx.compose.material3.RadioButtonDefaults.colors(selectedColor = c.ink, unselectedColor = c.secondary))
        Spacer(Modifier.width(16.dp))
        Column(Modifier.weight(1f).padding(vertical = 4.dp)) {
            Text(product.title, style = MaterialTheme.typography.titleMedium.copy(fontSize = 18.sp), color = c.ink)
            Text(product.who, style = MaterialTheme.typography.bodyMedium, color = c.secondary)
        }
        Column(horizontalAlignment = Alignment.End) {
            Text(plus.price(product) ?: "—", style = MaterialTheme.typography.titleLarge.copy(fontWeight = FontWeight.Medium), color = c.ink)
            Text("one-time", style = MaterialTheme.typography.bodySmall, color = c.secondary)
        }
    }
}

@Composable
private fun Gives() {
    SegmentedList {
        plusGives.forEachIndexed { i, (icon, title, line) -> ListRow(title, i, plusGives.size, line, icon, iconDisc = true) }
    }
}

@Composable
private fun PriceLine(label: String, amount: String, total: Boolean) {
    val c = appColors
    Row(Modifier.fillMaxWidth().heightIn(min = 28.dp), verticalAlignment = Alignment.CenterVertically) {
        val style = if (total) MaterialTheme.typography.titleMedium.copy(fontWeight = FontWeight.Medium) else MaterialTheme.typography.bodyLarge
        Text(label, Modifier.weight(1f), style = style, color = if (total) c.ink else c.secondary)
        Text(amount, style = style, color = if (total) c.ink else c.secondary)
    }
}
