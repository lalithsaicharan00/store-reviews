@file:OptIn(androidx.compose.material3.ExperimentalMaterial3Api::class)

package com.oftenenough.app.ui.newhabit

import com.oftenenough.app.ui.components.AppMenuItem
import com.oftenenough.app.ui.components.AppMenu
import com.oftenenough.app.ui.components.ListAvatar
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.ButtonSize
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import androidx.compose.foundation.layout.WindowInsets
import com.oftenenough.app.ui.components.NavigationIcon
import com.oftenenough.app.ui.components.AppTopBar
import com.oftenenough.app.ui.components.StandardIconButton
import androidx.activity.compose.BackHandler
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
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.BuyResult
import com.oftenenough.app.app.PlusProduct
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch

// ------------------------------------------------------------------ 6.3 · Change the type

/**
 * Change the type (Figma 6.3, 6.4.1), from Edit: the same choices as New habit, the current one outlined and saying
 * "Current type". A build habit chooses among the four ways to track; a quit or cut-down habit between Quit and Cut down.
 * Choosing another returns to the form, already showing it; saving then asks before starting over (6.3.1).
 */
@Composable
fun TypePage(form: FormState, onBack: () -> Unit) {
    val current = form.original?.let { ItemType.of(it) } ?: form.type
    val types = if (current == ItemType.QUIT || current == ItemType.CUT_DOWN) listOf(ItemType.QUIT, ItemType.CUT_DOWN)
        else listOf(ItemType.CHECK, ItemType.AMOUNT, ItemType.TIME, ItemType.CHECKLIST)
    BackHandler(onBack = onBack)
    ChoicePage("Change the type", close = false, onBack = onBack) {
        types.forEachIndexed { i, t ->
            ChoiceCard(icon(t), t.title, if (t == current) "Current type" else t.summary, t.example, i, types.size, "type-${t.name.lowercase()}",
                outlined = t == form.type) { form.changeType(t); onBack() }
        }
    }
}

// ------------------------------------------------------------------ 5 · Add a 6th habit

/**
 * Add a 6th habit (Figma 5): the free plan's five habits at once are used. Plus makes room for as many as you like (the
 * plan, what you get, Get Plus with its price), or Make room instead (5.1). Once there's room, the habit goes ahead.
 */
@Composable
fun SixthHabitPage(store: HabitStore, onBack: () -> Unit, onMakeRoom: () -> Unit, onPlus: () -> Unit, onBought: () -> Unit, title: String = "Add a 6th habit") {
    val c = appColors
    val plus = AppGraph.plus
    val activity = LocalActivity.current
    val scope = rememberCoroutineScope()
    var buying by remember { mutableStateOf(false) }
    var said by remember { mutableStateOf<String?>(null) }
    val product = PlusProduct.PLUS
    BackHandler(onBack = onBack)
    // Plus on (bought here, or a pending payment confirmed): the habit goes ahead.
    LaunchedEffect(store.canAddHabit) { if (store.canAddHabit) onBought() }
    val habits = store.habits.filter { !it.archived && it.kind != HabitKind.Task }
    Column(Modifier.fillMaxSize().background(c.screen).statusBarsPadding().navigationBarsPadding()) {
        AppTopBar(null, navigationIcon = {
            NavigationIcon(Symbols.Close, "Close", onBack, Modifier.semantics { testTag = "sixth-close" })
        }, windowInsets = WindowInsets(0))
        Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 16.dp).semantics { testTag = "sixth-habit" },
            verticalArrangement = Arrangement.spacedBy(16.dp)) {
            Column(Modifier.padding(horizontal = 8.dp, vertical = 8.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
                Text(title, Modifier.semantics { heading() }, style = AppType.headlineMedium, color = c.ink)
                Text("You're using all ${HabitStore.FREE_HABIT_LIMIT} free habits. Plus makes room for as many as you like.", style = AppType.bodyLarge, color = c.secondary)
            }
            // The five, and the + that has no room yet.
            Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.surface).padding(16.dp), verticalArrangement = Arrangement.spacedBy(12.dp)) {
                Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    habits.take(HabitStore.FREE_HABIT_LIMIT).forEach { HabitIcon(it.symbol, it.color, 40.dp) }
                    Box(Modifier.size(40.dp).clip(CircleShape).background(c.ink), contentAlignment = Alignment.Center) { Icon(Symbols.Add, null, tint = c.onInk) }
                }
                Row {
                    Text("${habits.size} of ${HabitStore.FREE_HABIT_LIMIT} free habits used", Modifier.weight(1f), style = AppType.labelLarge, color = c.ink)
                    Text("Plus: no limit", style = AppType.bodyMedium, color = c.secondary)
                }
                Box(Modifier.fillMaxWidth().height(4.dp).clip(RoundedCornerShape(2.dp)).background(c.ink))
            }
            // Plus alone since 21 Oct 2026 (no Plus Family, D16): its name and price, no choice to make.
            Row(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.surface)
                .padding(start = 20.dp, end = 20.dp, top = 14.dp, bottom = 14.dp).semantics(mergeDescendants = true) { testTag = "sixth-plus-price" },
                verticalAlignment = Alignment.CenterVertically) {
                Column(Modifier.weight(1f)) {
                    Text(product.title, style = AppType.titleMedium, color = c.ink)
                    Text("Just you", style = AppType.bodyMedium, color = c.secondary)
                }
                Column(horizontalAlignment = Alignment.End) {
                    Text(plus.price(product) ?: "", style = AppType.titleLarge, color = c.ink)
                    Text("one-time", style = AppType.bodySmall, color = c.secondary)
                }
            }
            Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                Text("What you get with Plus", Modifier.padding(start = 16.dp), style = AppType.labelLarge, color = c.secondary)
                Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
                    val rows = listOf(
                        Triple(Symbols.AllInclusive, "Unlimited habits", "Free has ${HabitStore.FREE_HABIT_LIMIT}. Add as many as you like."),
                        Triple(Symbols.Widgets, "More widgets", "Today’s list and This week"),
                        Triple(Symbols.Sync, "Synced through Google Drive", "A change on one shows on all of them"),
                    )
                    rows.forEachIndexed { i, (icon, title, line) -> GetRow(icon, title, line, i, rows.size) }
                }
            }
            Spacer(Modifier.height(8.dp))
        }
        Column(Modifier.fillMaxWidth().background(c.screen).padding(start = 16.dp, end = 16.dp, top = 12.dp, bottom = 8.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
            said?.let { Text(it, Modifier.fillMaxWidth().padding(horizontal = 8.dp), style = AppType.bodySmall, color = c.secondary) }
            val price = plus.price(product)
            AppButton("Get Plus" + (price?.let { " · $it" } ?: ""), {
                    val a = activity ?: return@AppButton
                    scope.launch {
                        buying = true
                        val result = plus.buy(a, product)
                        buying = false
                        said = when (result) {
                            BuyResult.BOUGHT -> null
                            BuyResult.PENDING -> "Waiting for your payment. Plus turns on as soon as Google Play confirms it."
                            BuyResult.NOT_COMPLETED -> "Payment not completed. Nothing was charged."
                            BuyResult.CANCELLED -> null
                            BuyResult.UNAVAILABLE -> { onPlus(); null }
                        }
                    }
                }, Modifier.fillMaxWidth(), size = ButtonSize.Medium, enabled = plus.canBuy && !buying, tag = "sixth-plus")
            AppButton("Make room instead", onMakeRoom, Modifier.fillMaxWidth(), style = ButtonStyle.Tonal, size = ButtonSize.Medium,
                icon = Symbols.Archive, tag = "sixth-make-room")
            Text("Archive a habit (it keeps its progress) or delete one.", Modifier.fillMaxWidth(), style = AppType.bodySmall, color = c.secondary,
                textAlign = androidx.compose.ui.text.style.TextAlign.Center)
        }
    }
}

@Composable
private fun GetRow(icon: ImageVector, title: String, line: String, index: Int, count: Int) =
    AppListItem(title, index, count, supporting = line, leading = { ListAvatar(icon) })

// ------------------------------------------------------------------ 5.1 · Make room

/**
 * Make room (Figma 5.1, the iPhone's `MakeRoomView`): archive or delete one of the five; once there's room, the habit
 * being added goes ahead. Delete asks first (5.1.1) and says archiving makes room just the same.
 */
@Composable
fun MakeRoomPage(store: HabitStore, onBack: () -> Unit, onRoom: () -> Unit) {
    val c = appColors
    var deleting by remember { mutableStateOf<Habit?>(null) }
    BackHandler(onBack = onBack)
    // An archive or a delete leaves room: the new habit goes ahead.
    LaunchedEffect(store.canAddHabit) { if (store.canAddHabit) onRoom() }
    val habits = store.habits.filter { !it.archived && it.kind != HabitKind.Task }
    FormPage("Make room", chip = null, onBack = onBack) {
        Text("Archive or delete one of your ${habits.size} habits to add a new one.", Modifier.padding(start = 16.dp, end = 16.dp, top = 4.dp, bottom = 16.dp),
            style = AppType.bodyLarge, color = c.secondary)
        Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
            habits.forEachIndexed { i, h ->
                var menu by remember { mutableStateOf(false) }
                Row(Modifier.fillMaxWidth().clip(com.oftenenough.app.ui.components.segmentShape(i, habits.size)).background(c.surface).heightIn(min = 72.dp)
                    .padding(start = 16.dp, end = 4.dp).semantics { testTag = "room-${h.name}" }, verticalAlignment = Alignment.CenterVertically) {
                    HabitIcon(h.symbol, h.color, 40.dp)
                    Spacer(Modifier.width(16.dp))
                    Text(h.name, Modifier.weight(1f), style = AppType.titleMedium, color = c.ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
                    AppButton("Archive", { store.archive(listOf(h)) }, style = ButtonStyle.Outlined, tag = "room-archive-${h.name}")
                    Box {
                        StandardIconButton(Symbols.MoreVert, "More for ${h.name}", { menu = true }, Modifier.semantics { testTag = "room-more-${h.name}" })
                        AppMenu(menu, { menu = false }) {
                            AppMenuItem("Delete…", { menu = false; deleting = h }, icon = Symbols.Delete, destructive = true)
                        }
                    }
                }
            }
        }
        Note("Archived habits keep all their progress, and you can bring them back any time.")
    }
    deleting?.let { h ->
        AlertDialog({ deleting = null }, title = { Text("Delete ${h.name}?") },
            text = { Text("Its history and notes are deleted too. Archiving keeps them and makes room just the same.") },
            confirmButton = { AppButton("Delete", { deleting = null; store.delete(listOf(h)) }, Modifier.semantics { testTag = "room-delete" }, style = ButtonStyle.Text, destructive = true) },
            dismissButton = { AppButton("Cancel", { deleting = null }, style = ButtonStyle.Text) })
    }
}

