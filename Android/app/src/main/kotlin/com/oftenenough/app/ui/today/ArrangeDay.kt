package com.oftenenough.app.ui.today

import androidx.compose.foundation.background
import androidx.compose.foundation.gestures.detectDragGestures
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.outlined.Delete
import androidx.compose.material.icons.rounded.Add
import androidx.compose.material.icons.rounded.DragHandle
import androidx.compose.material.icons.rounded.MoreVert
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.OutlinedTextFieldDefaults
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableFloatStateOf
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.semantics.CustomAccessibilityAction
import androidx.compose.ui.semantics.customActions
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.IntOffset
import androidx.compose.ui.unit.dp
import androidx.compose.ui.zIndex
import com.oftenenough.app.data.DaySection
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.TextLimit
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.segmentShape
import com.oftenenough.app.ui.newhabit.FormPage
import com.oftenenough.app.ui.newhabit.Note
import com.oftenenough.app.ui.theme.appColors
import kotlin.math.roundToInt

/** The card's habits sorted A to Z (the iPhone's sortCard .name). */
fun sortedByName(list: List<Habit>): List<Habit> = list.sortedWith(compareBy(String.CASE_INSENSITIVE_ORDER) { it.name })

/** The card's habits by their first reminder time there (on the person's day); those without keep their order, last. */
fun sortedByReminder(list: List<Habit>, card: String, store: HabitStore): List<Habit> {
    fun first(h: Habit): Int = store.placements(h).firstOrNull { it.section == card }?.times?.firstOrNull()?.let { store.rules.dayMinute(it.minuteOfDay) } ?: Int.MAX_VALUE
    return list.withIndex().sortedWith(compareBy<IndexedValue<Habit>> { first(it.value) }.thenBy { it.index }).map { it.value }
}

/** [list] with the item at [from] moved to [to]. */
fun <T> List<T>.moved(from: Int, to: Int): List<T> {
    if (from !in indices || to !in indices || from == to) return this
    return toMutableList().also { it.add(to, it.removeAt(from)) }
}

/**
 * Edit on Today: Arrange your day (the iPhone's ArrangeDayView; the user, 3 Oct 2026, U13). Every habit in each time of
 * day, not only today's, in the person's order: drag ≡ to change it (TalkBack: Move up / Move down). Each card's ⋮
 * renames, retimes, sorts or deletes a time of day, and moves Anytime and Quit or cut down. Timed cards follow their
 * times. Nothing here logs.
 */
@Composable
fun ArrangeDayScreen(store: HabitStore, onEditSection: (String?) -> Unit, onBack: () -> Unit) {
    val cards = store.todayCards()
    val members = androidx.compose.runtime.remember(store.dataVersion, store.habits, store.sections, store.cardOrder) {
        store.rules.cardMembers().mapValues { (_, ids) -> ids.mapNotNull { store.habit(it) } }
    }
    var renaming by remember { mutableStateOf<DaySection?>(null) }
    var deleting by remember { mutableStateOf<DaySection?>(null) }
    FormPage("Arrange your day", chip = null, onBack = onBack) {
        Note("All your habits, not only today's. Drag ≡ to change their order in a time of day. Use ⋮ to rename, retime, sort or delete a time of day, or to move Anytime and Quit or cut down up or down.")
        for (card in cards) {
            val habits = members[card] ?: emptyList()
            if (card == DaySection.QUITTING && habits.isEmpty()) continue
            ArrangeCard(card, habits, cards, store, onRename = { renaming = it }, onRetime = { onEditSection(it.id) }, onDelete = { deleting = it })
            Spacer(Modifier.height(16.dp))
        }
        Row(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(appColors.surface)
            .let { it }.heightIn(min = 56.dp).padding(horizontal = 4.dp), verticalAlignment = Alignment.CenterVertically) {
            TextButton({ onEditSection(null) }, Modifier.semantics { testTag = "arrange-add-section" }) {
                Icon(Icons.Rounded.Add, null, tint = appColors.ink); Spacer(Modifier.width(12.dp))
                Text("Add time of day", style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
            }
        }
        Note("A new time of day that overlaps others splits them; you'll see how first.")
        Spacer(Modifier.height(24.dp))
    }
    renaming?.let { section ->
        var name by remember(section.id) { mutableStateOf(section.name) }
        AlertDialog({ renaming = null }, title = { Text("Rename ${section.name}") },
            text = {
                OutlinedTextField(name, { name = it.take(TextLimit.SECTION) }, singleLine = true, label = { Text("Name") },
                    supportingText = { Text("Up to ${TextLimit.SECTION} letters.") },
                    modifier = Modifier.semantics { testTag = "arrange-rename-field" },
                    colors = OutlinedTextFieldDefaults.colors(focusedBorderColor = appColors.ink, focusedLabelColor = appColors.ink, cursorColor = appColors.ink))
            },
            confirmButton = { TextButton({
                renaming = null
                val clean = TextLimit.clean(name, TextLimit.SECTION)
                if (clean.isNotEmpty() && clean != section.name) store.saveSections(store.sections.map { if (it.id == section.id) it.copy(name = clean) else it })
            }, Modifier.semantics { testTag = "arrange-rename" }) { Text("Rename", color = appColors.ink) } },
            dismissButton = { TextButton({ renaming = null }) { Text("Cancel", color = appColors.ink) } })
    }
    deleting?.let { section ->
        AlertDialog({ deleting = null }, title = { Text("Delete ${section.name}?") }, text = { Text("Its habits move to Anytime. Nothing else changes.") },
            confirmButton = { TextButton({ deleting = null; store.saveSections(store.sections.filter { it.id != section.id }) }) { Text("Delete time of day", color = appColors.error) } },
            dismissButton = { TextButton({ deleting = null }) { Text("Cancel", color = appColors.ink) } })
    }
}

@Composable
private fun ArrangeCard(
    card: String, habits: List<Habit>, cards: List<String>, store: HabitStore,
    onRename: (DaySection) -> Unit, onRetime: (DaySection) -> Unit, onDelete: (DaySection) -> Unit,
) {
    val c = appColors
    val section = if (card == DaySection.QUITTING) null else store.section(card)
    val title = section?.name ?: "Quit or cut down"
    val count = habits.size + 1
    var menu by remember { mutableStateOf(false) }
    Column(Modifier.fillMaxWidth().semantics { testTag = "arrange-card-$title" }, verticalArrangement = Arrangement.spacedBy(2.dp)) {
        Row(Modifier.fillMaxWidth().clip(segmentShape(0, count)).background(c.surface).heightIn(min = 64.dp).padding(start = 20.dp, end = 4.dp),
            verticalAlignment = Alignment.CenterVertically) {
            Text(title, Modifier.weight(1f).semantics { heading() }, style = MaterialTheme.typography.titleLarge, color = c.ink)
            Box {
                IconButton({ menu = true }, Modifier.semantics { testTag = "arrange-menu-$title" }) { Icon(Icons.Rounded.MoreVert, "$title options", tint = c.ink) }
                DropdownMenu(menu, { menu = false }, containerColor = c.surface) {
                    @Composable fun item(text: String, tag: String, action: () -> Unit) =
                        DropdownMenuItem({ Text(text, color = c.ink) }, { menu = false; action() }, Modifier.semantics { testTag = tag })
                    if (section != null && !section.isAnytime) {
                        item("Rename", "arrange-rename-$title") { onRename(section) }
                        item("Change time", "arrange-retime-$title") { onRetime(section) }
                    }
                    if (habits.size > 1) {
                        if (habits.any { h -> store.placements(h).any { it.section == card && it.times.isNotEmpty() } })
                            item("Sort by reminder time", "arrange-sort-time-$title") { store.reorder(sortedByReminder(habits, card, store).map { it.id }) }
                        item("Sort A to Z", "arrange-sort-az-$title") { store.reorder(sortedByName(habits).map { it.id }) }
                    }
                    if (card == DaySection.ANYTIME || card == DaySection.QUITTING) {
                        val i = cards.indexOf(card)
                        if (i > 0) {
                            item("Move to top", "arrange-top-$title") { store.moveCard(card, HabitStore.CardMove.TOP) }
                            item("Move up", "arrange-up-$title") { store.moveCard(card, HabitStore.CardMove.UP) }
                        }
                        if (i < cards.size - 1) {
                            item("Move down", "arrange-down-$title") { store.moveCard(card, HabitStore.CardMove.DOWN) }
                            item("Move to bottom", "arrange-bottom-$title") { store.moveCard(card, HabitStore.CardMove.BOTTOM) }
                        }
                    }
                    if (section != null && !section.isAnytime) {
                        HorizontalDivider(color = c.tonal)
                        DropdownMenuItem({ Text("Delete", color = c.error) }, { menu = false; onDelete(section) },
                            leadingIcon = { Icon(Icons.Outlined.Delete, null, tint = c.error) })
                    }
                }
            }
        }
        if (habits.isEmpty()) {
            Box(Modifier.fillMaxWidth().clip(segmentShape(1, 2)).background(c.surface).padding(20.dp)) {
                Text("No habits here yet.", style = MaterialTheme.typography.bodyMedium, color = c.secondary)
            }
        } else DraggableRows(habits, store) { from, to -> store.reorder(habits.moved(from, to).map { it.id }) }
    }
}

/**
 * The card's rows, dragged by their ≡ handle. The row follows the finger; the others make room; the new order is saved
 * once, when the finger lifts (S7: the screen first, the write after).
 */
@Composable
private fun DraggableRows(habits: List<Habit>, store: HabitStore, onMove: (Int, Int) -> Unit) {
    val c = appColors
    val rowPx = with(LocalDensity.current) { (ROW_HEIGHT + 2.dp).toPx() }
    var dragging by remember { mutableIntStateOf(-1) }
    var dy by remember { mutableFloatStateOf(0f) }
    // Worked out from the live drag, never captured: the gesture's handlers outlive the composition they were made in.
    fun targetOf(from: Int, offset: Float) = if (from < 0) -1 else (from + (offset / rowPx).roundToInt()).coerceIn(0, habits.lastIndex)
    val target = targetOf(dragging, dy)
    habits.forEachIndexed { i, h ->
        // Where each row sits while one is dragged: the dragged one under the finger, the rest shifted one place.
        val shift = when {
            dragging < 0 || i == dragging -> 0f
            i in (dragging + 1)..target -> -rowPx
            i in target until dragging -> rowPx
            else -> 0f
        }
        val y = if (i == dragging) dy else shift
        Row(Modifier.zIndex(if (i == dragging) 1f else 0f).offset { IntOffset(0, y.roundToInt()) }
            .let { if (i == dragging) it.shadow(6.dp, segmentShape(i + 1, habits.size + 1)) else it }
            .fillMaxWidth().clip(segmentShape(i + 1, habits.size + 1)).background(c.surface).height(ROW_HEIGHT).padding(start = 16.dp, end = 4.dp)
            .semantics(mergeDescendants = true) {
                testTag = "arrange-row-${h.name}"
                customActions = listOfNotNull(
                    if (i > 0) CustomAccessibilityAction("Move up") { onMove(i, i - 1); true } else null,
                    if (i < habits.lastIndex) CustomAccessibilityAction("Move down") { onMove(i, i + 1); true } else null,
                )
            },
            verticalAlignment = Alignment.CenterVertically) {
            HabitIcon(h.symbol, h.color)
            Spacer(Modifier.width(16.dp))
            Text(h.name, Modifier.weight(1f), style = MaterialTheme.typography.bodyLarge, color = c.ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
            Box(Modifier.size(48.dp).semantics { testTag = "arrange-handle-${h.name}" }.pointerInput(h.id, i, habits.size) {
                detectDragGestures(
                    onDragStart = { dragging = i; dy = 0f },
                    onDragEnd = { val from = dragging; val to = targetOf(from, dy); dragging = -1; dy = 0f; if (from >= 0 && to != from) onMove(from, to) },
                    onDragCancel = { dragging = -1; dy = 0f },
                ) { change, amount -> change.consume(); dy += amount.y }
            }, contentAlignment = Alignment.Center) {
                Icon(Icons.Rounded.DragHandle, "Drag to reorder", tint = c.secondary)
            }
        }
    }
}

private val ROW_HEIGHT = 64.dp
