package com.oftenenough.app.ui.today

import com.oftenenough.app.ui.theme.AppType

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ExperimentalLayoutApi
import androidx.compose.foundation.layout.FlowRow
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowRight
import androidx.compose.material.icons.outlined.Category
import androidx.compose.material.icons.outlined.Delete
import androidx.compose.material.icons.outlined.Edit
import androidx.compose.material.icons.outlined.PauseCircle
import androidx.compose.material.icons.rounded.Add
import androidx.compose.material.icons.rounded.Check
import androidx.compose.material.icons.rounded.CheckCircle
import androidx.compose.material.icons.rounded.Edit
import androidx.compose.material.icons.rounded.RadioButtonUnchecked
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.ModalBottomSheet
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.rememberModalBottomSheetState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.selected
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.text.input.KeyboardCapitalization
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.oftenenough.app.app.Prefs
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HabitGroup
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.TextLimit
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.Segment
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.newhabit.FormPage
import com.oftenenough.app.ui.newhabit.GroupTitle
import com.oftenenough.app.ui.newhabit.InkSwitch
import com.oftenenough.app.ui.newhabit.Note
import com.oftenenough.app.ui.theme.appColors

/** How many of a group's habits (null: every habit) show on Today on [day]; null when the group has none at all. */
fun groupCount(store: HabitStore, groupId: String?, day: Int): Int? {
    val habits = store.habits.filter { !it.archived && it.kind != HabitKind.Task }
    val members = if (groupId == null) habits else {
        val g = store.groups.firstOrNull { it.id == groupId } ?: return null
        habits.filter { it.id in g.habits }.ifEmpty { return null }
    }
    return members.count { store.rules.isDue(it, day) }
}

/**
 * Today's Filter (Figma 3, "Show on Today"): All or one group as filter chips ("Health · 5": how many it shows on the day
 * open), Edit groups and New group, then Hide done habits and Hide done tasks. With no groups yet (Figma 3.2) the top says
 * what groups are, with New group and Not now; the two switches stay below it, so hiding done rows never needs a group.
 * Only "show less" lives here; arranging the day is Today's ✏.
 */
@OptIn(ExperimentalMaterial3Api::class, ExperimentalLayoutApi::class)
@Composable
fun FilterSheet(store: HabitStore, prefs: Prefs, day: Int, onNewGroup: () -> Unit, onEditGroups: () -> Unit, onDismiss: () -> Unit) {
    val c = appColors
    val state = rememberModalBottomSheetState(skipPartiallyExpanded = true)
    // Worked out only while the sheet is open.
    val counts = remember(store.dataVersion, day) { store.groups.associate { it.id to groupCount(store, it.id, day) } }
    val current = prefs.todayGroup.takeIf { id -> store.groups.any { it.id == id } }
    ModalBottomSheet(onDismiss, sheetState = state, containerColor = c.surface, shape = RoundedCornerShape(topStart = 28.dp, topEnd = 28.dp)) {
        Column(Modifier.fillMaxWidth().verticalScroll(rememberScrollState()).padding(horizontal = 24.dp).padding(bottom = 40.dp)
            .semantics { testTag = "filter-sheet"; testTagsAsResourceId = true },
            verticalArrangement = Arrangement.spacedBy(16.dp)) {
            if (store.groups.isEmpty()) {
                // Figma 3.2: what groups are, and New group.
                Column(Modifier.fillMaxWidth(), horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(16.dp)) {
                    Icon(Icons.Outlined.Category, null, Modifier.size(32.dp), tint = c.ink)
                    Text("Group your habits", style = AppType.titleLarge, color = c.ink)
                    Text("Put habits together, then filter Today and Progress by group.", style = AppType.bodyMedium, color = c.secondary,
                        textAlign = androidx.compose.ui.text.style.TextAlign.Center)
                    Box(Modifier.fillMaxWidth().heightIn(min = 56.dp).clip(RoundedCornerShape(28.dp)).background(c.ink).clickable(onClick = onNewGroup)
                        .semantics { testTag = "group-new" }, contentAlignment = Alignment.Center) {
                        Text("New group", style = AppType.titleMedium, color = c.onInk)
                    }
                    Box(Modifier.fillMaxWidth().heightIn(min = 48.dp).clip(RoundedCornerShape(24.dp)).clickable(onClick = onDismiss)
                        .semantics { testTag = "groups-not-now" }, contentAlignment = Alignment.Center) {
                        Text("Not now", style = AppType.titleMedium, color = c.ink)
                    }
                }
            } else {
                Text("Show on Today", style = AppType.titleLarge, color = c.ink)
                FlowRow(horizontalArrangement = Arrangement.spacedBy(8.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
                    Chip("All", current == null, "group-chip-all") { prefs.todayGroup = "" }
                    for (g in store.groups) {
                        val n = counts[g.id]
                        Chip(if (n != null) "${g.name} · $n" else g.name, current == g.id, "group-chip-${g.name}") { prefs.todayGroup = g.id }
                    }
                }
                Column {
                    SheetRow(Icons.Outlined.Edit, "Edit groups", "groups-edit", onEditGroups)
                    SheetRow(Icons.Rounded.Add, "New group", "group-new", onNewGroup)
                }
                Text("Groups change only what Today and Progress show.", style = AppType.bodySmall, color = c.secondary)
            }
            Box(Modifier.fillMaxWidth().height(1.dp).background(c.line))
            Column {
                SwitchRow("Hide done habits", prefs.hideDoneHabits, "hide-done-habits") { prefs.hideDoneHabits = it }
                SwitchRow("Hide done tasks", prefs.hideDoneTasks, "hide-done-tasks") { prefs.hideDoneTasks = it }
            }
        }
    }
}

/** A filter chip (Figma 3): the chosen one tonal with a ✓, the others outlined; corners 8. */
@Composable
private fun Chip(title: String, selected: Boolean, tag: String, onClick: () -> Unit) {
    val c = appColors
    Row(Modifier.clip(RoundedCornerShape(8.dp)).background(if (selected) c.behind else Color.Transparent)
        .let { if (selected) it else it.border(1.dp, c.line, RoundedCornerShape(8.dp)) }
        .clickable(onClick = onClick)
        .semantics(mergeDescendants = true) { testTag = tag; this.selected = selected }
        .heightIn(min = 32.dp).padding(start = if (selected) 8.dp else 12.dp, end = 16.dp, top = 6.dp, bottom = 6.dp),
        verticalAlignment = Alignment.CenterVertically) {
        if (selected) { Icon(Icons.Rounded.Check, null, Modifier.size(18.dp), tint = c.ink); Spacer(Modifier.width(8.dp)) }
        Text(title, style = AppType.labelLarge, color = c.ink, maxLines = 1)
    }
}

/** A row in a sheet: a grey 24 dp icon, 16 dp, the words (Body Large). */
@Composable
private fun SheetRow(icon: androidx.compose.ui.graphics.vector.ImageVector, text: String, tag: String, onClick: () -> Unit) {
    val c = appColors
    Row(Modifier.fillMaxWidth().heightIn(min = 48.dp).clip(RoundedCornerShape(12.dp)).clickable(onClick = onClick).semantics { testTag = tag }
        .padding(vertical = 12.dp), verticalAlignment = Alignment.CenterVertically) {
        Icon(icon, null, tint = c.secondary)
        Spacer(Modifier.width(16.dp))
        Text(text, style = AppType.bodyLarge, color = c.ink)
    }
}

@Composable
private fun SwitchRow(text: String, on: Boolean, tag: String, onChange: (Boolean) -> Unit) {
    val c = appColors
    Row(Modifier.fillMaxWidth().heightIn(min = 56.dp).clickable { onChange(!on) }.semantics { testTag = tag },
        verticalAlignment = Alignment.CenterVertically) {
        Text(text, Modifier.weight(1f), style = AppType.bodyLarge, color = c.ink)
        InkSwitch(on)
    }
}

// ------------------------------------------------------------------ Groups

/** Edit groups: every group with how many habits it holds; tap to edit; New group. A to Z unless the person reordered. */
@Composable
fun GroupsScreen(store: HabitStore, onEdit: (String?) -> Unit, onBack: () -> Unit) {
    val c = appColors
    FormPage("Groups", chip = null, onBack = onBack) {
        Spacer(Modifier.height(8.dp))
        SegmentedList {
            val n = store.groups.size + 1
            store.groups.forEachIndexed { i, g ->
                val members = g.habits.count { id -> store.habit(id)?.archived == false }
                Segment(i, n, Modifier.semantics { testTag = "groups-row-${g.name}" }, onClick = { onEdit(g.id) }) {
                    Box(Modifier.size(12.dp).clip(CircleShape).background(c.habit(g.color)))
                    Spacer(Modifier.width(20.dp))
                    Column(Modifier.weight(1f).padding(vertical = 4.dp)) {
                        Text(g.name, style = MaterialTheme.typography.bodyLarge, color = c.ink)
                        Text(when (members) { 0 -> "No habits yet"; 1 -> "1 habit"; else -> "$members habits" }, style = MaterialTheme.typography.bodyMedium, color = c.secondary)
                    }
                    Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = c.secondary)
                }
            }
            Segment(store.groups.size, n, Modifier.semantics { testTag = "groups-new" }, onClick = { onEdit(null) }) {
                Icon(Icons.Rounded.Add, null, tint = c.ink); Spacer(Modifier.width(24.dp))
                Text("New group", style = MaterialTheme.typography.bodyLarge, color = c.ink)
            }
        }
        Note(if (store.groupsManual) "Your order, the same on Today, Progress and the habit form." else "A to Z, the same on Today, Progress and the habit form.")
    }
}

/**
 * New group and Edit group: its name, colour, and which habits are in it. A habit is in one group at a time, so choosing
 * one that's in another moves it. Pause these habits… and Delete group (its habits stay, with no group).
 */
@Composable
fun GroupFormScreen(store: HabitStore, groupId: String?, onPause: (List<Habit>) -> Unit, onClose: () -> Unit) {
    val c = appColors
    val original = groupId?.let { id -> store.groups.firstOrNull { it.id == id } }
    if (groupId != null && original == null) { onClose(); return }
    var name by rememberSaveable { mutableStateOf(original?.name ?: "") }
    var color by rememberSaveable { mutableStateOf(original?.color ?: suggestedGroupColor(store)) }
    var chosen by rememberSaveable { mutableStateOf(original?.habits?.toSet() ?: emptySet()) }
    var deleting by remember { mutableStateOf(false) }
    val trimmed = TextLimit.clean(name, TextLimit.GROUP)
    val taken = store.groups.any { it.id != original?.id && it.name.equals(trimmed, ignoreCase = true) }
    val candidates = store.habits.filter { !it.archived }
    val changed = original == null || trimmed != original.name || color != original.color || chosen != original.habits.toSet()
    fun save() {
        if (trimmed.isEmpty() || taken) return
        val archived = store.habits.filter { it.archived }.map { it.id }.toSet()
        val base = original ?: HabitGroup(name = trimmed, color = color)
        // Archived members stay in it; the rest follow the habits' own order.
        store.saveGroup(base.copy(name = trimmed, color = color,
            habits = base.habits.filter { it in archived } + candidates.map { it.id }.filter { it in chosen }))
        onClose()
    }
    FormPage(if (original == null) "New group" else "Edit group", chip = null, onBack = onClose, close = changed, actions = {
        Button(::save, Modifier.padding(end = 8.dp).semantics { testTag = "group-save" }, enabled = trimmed.isNotEmpty() && !taken && changed,
            colors = ButtonDefaults.buttonColors(containerColor = c.ink, contentColor = c.onInk, disabledContainerColor = c.tonal, disabledContentColor = c.secondary)) {
            Text(if (original == null) "Add" else "Save")
        }
    }) {
        val focus = remember { FocusRequester() }
        LaunchedEffect(Unit) { if (original == null) runCatching { focus.requestFocus() } }
        Box(Modifier.fillMaxWidth().padding(top = 8.dp).clip(RoundedCornerShape(24.dp)).background(c.surface).heightIn(min = 64.dp).padding(16.dp), contentAlignment = Alignment.CenterStart) {
            BasicTextField(name, { name = it.replace("\n", "").take(TextLimit.GROUP) },
                Modifier.fillMaxWidth().focusRequester(focus).semantics { testTag = "group-name-field"; contentDescription = "Group name" },
                textStyle = MaterialTheme.typography.titleLarge.copy(color = c.ink), singleLine = true, cursorBrush = SolidColor(c.ink),
                keyboardOptions = KeyboardOptions(capitalization = KeyboardCapitalization.Sentences),
                decorationBox = { inner -> Box { if (name.isEmpty()) Text("Name, like Health or Work", style = MaterialTheme.typography.titleLarge, color = c.secondary); inner() } })
        }
        if (taken) Note("You already have a group called $trimmed.") else TextLimit.note(name, TextLimit.GROUP)?.let { Note(it) }
        GroupTitle("Colour")
        Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.surface).padding(16.dp)) {
            for (row in HabitColor.entries.chunked(7)) {
                Row(Modifier.fillMaxWidth().padding(bottom = 8.dp), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    for (hc in row) {
                        val on = hc == color
                        Box(Modifier.weight(1f).aspectRatio(1f).clip(CircleShape)
                            .border(if (on) 3.dp else 0.dp, if (on) c.ink else Color.Transparent, CircleShape)
                            .padding(if (on) 5.dp else 0.dp).clip(CircleShape).background(c.habit(hc)).clickable { color = hc }
                            .semantics { contentDescription = hc.key.replaceFirstChar { it.uppercase() } + if (on) ", chosen" else ""; testTag = "group-colour-${hc.key}" })
                    }
                    repeat(7 - row.size) { Spacer(Modifier.weight(1f)) }
                }
            }
        }
        if (candidates.isNotEmpty()) {
            GroupTitle("Habits")
            SegmentedList {
                candidates.forEachIndexed { i, h ->
                    val isIn = h.id in chosen
                    val elsewhere = store.groupOf(h.id)?.takeIf { it.id != original?.id }
                    Segment(i, candidates.size, Modifier.semantics(mergeDescendants = true) { testTag = "group-habit-${h.name}"; selected = isIn },
                        onClick = { chosen = if (isIn) chosen - h.id else chosen + h.id }) {
                        HabitIcon(h.symbol, h.color)
                        Spacer(Modifier.width(16.dp))
                        Column(Modifier.weight(1f)) {
                            Text(h.name, style = MaterialTheme.typography.bodyLarge, color = c.ink, maxLines = 1)
                            if (elsewhere != null) Text(if (isIn) "Moves from ${elsewhere.name}" else "In ${elsewhere.name}", style = MaterialTheme.typography.bodyMedium, color = c.secondary)
                        }
                        Icon(if (isIn) Icons.Rounded.CheckCircle else Icons.Rounded.RadioButtonUnchecked, null, tint = if (isIn) c.ink else c.secondary)
                    }
                }
            }
            Note("A habit is in one group at a time. Habits with no group still show under All habits.")
        }
        if (original != null) {
            val members = original.habits.mapNotNull { store.habit(it) }.filter { !it.archived && store.rules.canPause(it) }
            Spacer(Modifier.height(16.dp))
            SegmentedList {
                val n = if (members.isNotEmpty()) 2 else 1
                if (members.isNotEmpty()) Segment(0, n, Modifier.semantics { testTag = "group-pause" }, onClick = { onPause(members) }) {
                    Icon(Icons.Outlined.PauseCircle, null, tint = c.ink); Spacer(Modifier.width(24.dp))
                    Text("Pause these habits…", style = MaterialTheme.typography.bodyLarge, color = c.ink)
                }
                Segment(n - 1, n, Modifier.semantics { testTag = "group-delete" }, onClick = { deleting = true }) {
                    Icon(Icons.Outlined.Delete, null, tint = c.error); Spacer(Modifier.width(24.dp))
                    Text("Delete group", style = MaterialTheme.typography.bodyLarge, color = c.error)
                }
            }
        }
        Spacer(Modifier.height(24.dp))
    }
    if (deleting && original != null) {
        val n = original.habits.count { id -> store.habit(id) != null }
        AlertDialog({ deleting = false }, title = { Text("Delete ${original.name}?") },
            text = { Text(when (n) { 0 -> "No habits are in it."; 1 -> "Its habit stays, with no group. Its history isn't touched."; else -> "Its $n habits stay, with no group. Their history isn't touched." }) },
            confirmButton = { TextButton({ deleting = false; store.deleteGroup(original.id); onClose() }, Modifier.semantics { testTag = "group-delete-confirm" }) { Text("Delete group", color = c.error) } },
            dismissButton = { TextButton({ deleting = false }) { Text("Cancel", color = c.ink) } })
    }
}

/** The first colour no group uses yet. */
fun suggestedGroupColor(store: HabitStore): HabitColor {
    val used = store.groups.map { it.color }.toSet()
    return HabitColor.entries.firstOrNull { it !in used && it != HabitColor.GRAY } ?: HabitColor.GREEN
}
