package com.oftenenough.app.ui.habit

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.combinedClickable
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
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.ArrowBack
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowRight
import androidx.compose.material.icons.automirrored.rounded.List
import androidx.compose.material.icons.outlined.Archive
import androidx.compose.material.icons.outlined.Delete
import androidx.compose.material.icons.outlined.PauseCircle
import androidx.compose.material.icons.rounded.Add
import androidx.compose.material.icons.rounded.Checklist
import androidx.compose.material.icons.rounded.Close
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Checkbox
import androidx.compose.material3.CheckboxDefaults
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.clip
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.stateDescription
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.pageSentence
import com.oftenenough.app.ui.components.CookieIcon
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.segmentShape
import com.oftenenough.app.ui.newhabit.GroupTitle
import com.oftenenough.app.ui.newhabit.Note
import com.oftenenough.app.ui.theme.appColors

interface AllHabitsNav {
    fun open(habit: Habit)
    fun pause(habits: List<Habit>)
    fun addTask()
}

/**
 * ≡ › Habits (habits and quit habits) and ≡ › Tasks (the iPhone's AllHabitsView): every one in the person's order, grouped
 * as Today groups them, then Archived. Tap one for its page. Touch and hold to choose several, then Pause, Archive or
 * Delete them together; Delete asks first and offers Archive (U14: never a delete on a swipe). Archive keeps all history
 * and frees a place on the free plan (D6).
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AllHabitsScreen(tasks: Boolean, store: HabitStore, nav: AllHabitsNav, onBack: () -> Unit) {
    val c = appColors
    var chosen by rememberSaveable { mutableStateOf(emptySet<String>()) }
    val selecting = chosen.isNotEmpty()
    var deleting by remember { mutableStateOf<List<Habit>>(emptyList()) }
    BackHandler { if (selecting) chosen = emptySet() else onBack() }
    val shown = store.habits.filter { (it.kind == HabitKind.Task) == tasks }
    val active = shown.filter { !it.archived }
    val archived = shown.filter { it.archived }
    val today = store.today()
    val toggle: (Habit) -> Unit = { h -> chosen = if (h.id in chosen) chosen - h.id else chosen + h.id }
    val groups: List<Pair<String?, List<Habit>>> = if (tasks) listOf(null to active) else {
        val habits = active.filter { it.kind != HabitKind.Quit }
        val byGroup = if (store.groups.isEmpty()) listOf("Habits" to habits) else
            store.groups.map { g -> g.name to habits.filter { store.groupOf(it.id)?.id == g.id } } + ("No group" to habits.filter { store.groupOf(it.id) == null })
        byGroup + ("Quitting" to active.filter { it.kind == HabitKind.Quit })
    }.filter { it.second.isNotEmpty() }
    val picked = shown.filter { it.id in chosen }

    Column(Modifier.fillMaxSize().background(c.screen)) {
        TopAppBar(
            title = { Text(if (selecting) "${chosen.size} chosen" else if (tasks) "Tasks" else "Habits", maxLines = 1) },
            navigationIcon = {
                if (selecting) IconButton({ chosen = emptySet() }, Modifier.semantics { testTag = "habits-done-choosing" }) { Icon(Icons.Rounded.Close, "Stop choosing") }
                else IconButton(onBack, Modifier.semantics { testTag = "page-back" }) { Icon(Icons.AutoMirrored.Rounded.ArrowBack, "Back") }
            },
            actions = {
                if (tasks && !selecting) IconButton(nav::addTask, Modifier.semantics { testTag = "tasks-add" }) { Icon(Icons.Rounded.Add, "Add task") }
            },
            colors = TopAppBarDefaults.topAppBarColors(containerColor = c.screen, titleContentColor = c.ink, navigationIconContentColor = c.ink, actionIconContentColor = c.ink),
        )
        if (shown.isEmpty()) {
            Column(Modifier.fillMaxWidth().weight(1f).padding(32.dp), horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.Center) {
                CookieIcon(if (tasks) Icons.AutoMirrored.Rounded.List else Icons.Rounded.Checklist, 72.dp)
                Spacer(Modifier.height(16.dp))
                Text(if (tasks) "No tasks yet" else "No habits yet", style = MaterialTheme.typography.titleLarge, color = c.ink)
                Spacer(Modifier.height(8.dp))
                Text(if (tasks) "Tap + to add a task." else "Tap + on Today to add one.", style = MaterialTheme.typography.bodyLarge, color = c.secondary)
            }
        } else {
            LazyColumn(Modifier.fillMaxWidth().weight(1f).padding(horizontal = 16.dp).semantics { testTag = "habits-list" }) {
                for ((title, list) in groups) {
                    item(key = "title-$title") { if (title != null) GroupTitle(title) else Spacer(Modifier.height(8.dp)) }
                    list.forEachIndexed { i, h ->
                        item(key = h.id) {
                            HabitListRow(h, store, today, i, list.size, selecting, h.id in chosen, onOpen = { if (selecting) toggle(h) else nav.open(h) }, onChoose = { toggle(h) })
                        }
                    }
                }
                if (archived.isNotEmpty()) {
                    item(key = "title-archived") { GroupTitle("Archived") }
                    archived.forEachIndexed { i, h ->
                        item(key = h.id) {
                            HabitListRow(h, store, today, i, archived.size, selecting, h.id in chosen, onOpen = { if (selecting) toggle(h) else nav.open(h) }, onChoose = { toggle(h) })
                        }
                    }
                    item(key = "archived-note") {
                        Note(if (tasks) "Archived tasks keep their history." else "Archived habits keep their history and don't count toward the free limit.")
                    }
                }
                item(key = "end") { Spacer(Modifier.height(if (selecting) 96.dp else 24.dp)) }
            }
        }
        if (selecting) {
            Surface(color = c.surface, tonalElevation = 3.dp) {
                Row(Modifier.fillMaxWidth().navigationBarsPadding().padding(horizontal = 8.dp, vertical = 8.dp), horizontalArrangement = Arrangement.SpaceEvenly) {
                    val canPause = picked.any { !it.archived && store.rules.canPause(it) }
                    BarAction("Pause", Icons.Outlined.PauseCircle, canPause, "habits-pause") {
                        nav.pause(picked.filter { !it.archived && store.rules.canPause(it) }); chosen = emptySet()
                    }
                    BarAction("Archive", Icons.Outlined.Archive, picked.any { !it.archived }, "habits-archive") {
                        store.archive(picked.filter { !it.archived }); chosen = emptySet()
                    }
                    BarAction("Delete", Icons.Outlined.Delete, picked.isNotEmpty(), "habits-delete") { deleting = picked }
                }
            }
        }
    }

    if (deleting.isNotEmpty()) {
        val one = deleting.size == 1
        val noun = if (tasks) "tasks" else "habits"
        AlertDialog(
            onDismissRequest = { deleting = emptyList() },
            title = { Text(if (one) "Delete ${deleting[0].name}?" else "Delete ${deleting.size} $noun?") },
            text = { Text((if (one) "Its" else "Their") + " history and notes are deleted too, and this can't be undone. Archiving stops it and keeps its history.") },
            confirmButton = {
                TextButton({ store.delete(deleting); deleting = emptyList(); chosen = emptySet() }, Modifier.semantics { testTag = "delete-confirm" }) { Text("Delete", color = c.error) }
            },
            dismissButton = {
                Row {
                    if (deleting.any { !it.archived }) TextButton({
                        store.archive(deleting.filter { !it.archived }); deleting = emptyList(); chosen = emptySet()
                    }, Modifier.semantics { testTag = "delete-archive-instead" }) { Text("Archive instead", color = c.ink) }
                    TextButton({ deleting = emptyList() }) { Text("Cancel", color = c.ink) }
                }
            },
            containerColor = c.surface, titleContentColor = c.ink, textContentColor = c.secondary,
        )
    }
}

/** One habit: its icon (faded while archived or paused), name and goal in words; › opens its page. */
@OptIn(ExperimentalFoundationApi::class)
@Composable
private fun HabitListRow(
    habit: Habit, store: HabitStore, today: Int, index: Int, count: Int, selecting: Boolean, chosen: Boolean,
    onOpen: () -> Unit, onChoose: () -> Unit,
) {
    val c = appColors
    val faded = habit.archived || store.isPaused(habit, today)
    val sentence = remember(habit, store.sections, store.weekStart) { store.pageSentence(habit) }
    Row(
        Modifier.padding(bottom = 2.dp).fillMaxWidth().clip(segmentShape(index, count)).background(if (chosen) c.tonal else c.surface)
            .combinedClickable(onClick = onOpen, onLongClick = onChoose, role = if (selecting) Role.Checkbox else Role.Button)
            .semantics(mergeDescendants = true) {
                testTag = "habits-row-" + habit.name
                if (selecting) stateDescription = if (chosen) "Chosen" else "Not chosen"
            }
            .heightIn(min = 72.dp).padding(horizontal = 16.dp, vertical = 12.dp),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        if (selecting) {
            Checkbox(chosen, null, colors = CheckboxDefaults.colors(checkedColor = c.ink, checkmarkColor = c.onInk))
            Spacer(Modifier.width(8.dp))
        }
        Box(Modifier.alpha(if (faded) 0.5f else 1f)) { HabitIcon(habit.symbol, habit.color) }
        Spacer(Modifier.width(16.dp))
        Column(Modifier.weight(1f)) {
            Text(habit.name, style = MaterialTheme.typography.bodyLarge, color = c.ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
            Text(sentence, style = MaterialTheme.typography.bodyMedium, color = c.secondary, maxLines = 1, overflow = TextOverflow.Ellipsis)
        }
        if (!selecting) Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = c.secondary)
    }
}

@Composable
private fun BarAction(text: String, icon: androidx.compose.ui.graphics.vector.ImageVector, enabled: Boolean, tag: String, onClick: () -> Unit) {
    val c = appColors
    TextButton(onClick, Modifier.semantics { testTag = tag }, enabled = enabled) {
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            Icon(icon, null, tint = if (enabled) (if (text == "Delete") c.error else c.ink) else c.secondary.copy(alpha = 0.5f))
            Text(text, style = MaterialTheme.typography.labelMedium, color = if (enabled) (if (text == "Delete") c.error else c.ink) else c.secondary.copy(alpha = 0.5f))
        }
    }
}
