package com.oftenenough.app.ui.habit

import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.material3.MaterialTheme
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.AppMenu
import com.oftenenough.app.ui.components.StandardIconButton
import com.oftenenough.app.ui.components.SegmentedListGap
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.components.EmptyState
import com.oftenenough.app.ui.components.AppDialog
import com.oftenenough.app.ui.components.AppSnackbarHost
import com.oftenenough.app.ui.components.AppMenuItem
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.AppTopBar
import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.SnackbarDuration
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.SnackbarResult
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.archivedLine
import com.oftenenough.app.ui.theme.AppType
import kotlinx.coroutines.launch

interface ArchivedNav {
    fun open(habit: Habit)
    /** Restoring would make a sixth habit on the free plan (Figma 6.4): Restore a 6th habit, then this one comes back. */
    fun restoreNoRoom(habit: Habit)
    fun back()
}

/**
 * 5.5.2, **Archived habits page** (Figma 988:7736, Screen Archived · Menu open · Restored · Nothing archived; Components
 * — Atoms Build Plan): from Habits › Archived. The Top app bar (← and "Archived habits") on Surface container; the
 * content 16 at the sides, 8 above, 40 under: the intro in Body Large On surface variant, 16 in, then 24 under it one
 * rounded list, newest first (two-line List items 2 apart on Surface bright: the habit's icon in its colour, its name,
 * "Archived 12 Oct", ⋮ with Restore and Delete, Delete in Error). A row opens its Habit details, read-only. Restore says
 * so with Undo; Delete asks first and waits for its Undo (D6). Nothing archived: the empty page (inventory_2 in its
 * cookie, "No archived habits", what it means), centred, no button. No selecting several (A55).
 *
 * 5.5.5, **Archived tasks page** (Figma 1001:178, Screen Archived · Menu open · Restored · Nothing archived): the same
 * page for tasks ([tasks]), from Tasks › Archived, with its own words: "Archived tasks keep their history. They're off
 * Today and the Tasks list."; each row "Archived 10 Oct" and opens its Task details, read-only; Restore says "<name>
 * restored" with Undo; nothing archived: "No archived tasks", "When you archive a task, it waits here with its history."
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ArchivedHabitsScreen(store: HabitStore, nav: ArchivedNav, tasks: Boolean = false) {
    val s = MaterialTheme.colorScheme
    val scope = rememberCoroutineScope()
    val snackbar = remember { SnackbarHostState() }
    var hidden by remember { mutableStateOf(emptySet<String>()) }
    var deleting by remember { mutableStateOf<Habit?>(null) }
    BackHandler { nav.back() }
    val archived = store.habits.filter { it.archived && (it.kind == HabitKind.Task) == tasks && it.id !in hidden }
        .sortedByDescending { store.archivedOn[it.id] ?: Int.MIN_VALUE }
    fun say(text: String, onUndo: () -> Unit) {
        scope.launch {
            snackbar.currentSnackbarData?.dismiss()
            if (snackbar.showSnackbar(text, "Undo", duration = SnackbarDuration.Short) == SnackbarResult.ActionPerformed) onUndo()
        }
    }
    fun restore(h: Habit) {
        if (!store.restore(h)) { nav.restoreNoRoom(h); return }
        // Undo archives it again.
        say("${h.name} restored") { store.archive(listOf(h)) }
    }
    fun delete(h: Habit) {
        hidden = hidden + h.id
        scope.launch {
            snackbar.currentSnackbarData?.dismiss()
            var undone = false
            try {
                undone = snackbar.showSnackbar("${h.name} deleted", "Undo", duration = SnackbarDuration.Short) == SnackbarResult.ActionPerformed
            } finally {
                if (!undone) store.habit(h.id)?.let { store.delete(listOf(it)) }
                hidden = hidden - h.id
            }
        }
    }

    Box(Modifier.fillMaxSize().background(s.surfaceContainer)) {
        Column(Modifier.fillMaxSize()) {
            AppTopBar(
                if (tasks) "Archived tasks" else "Archived habits",
                navigationIcon = { IconButton(nav::back, Modifier.semantics { testTag = "page-back" }) { Icon(Symbols.ArrowBack, "Back") } },
            )
            if (archived.isEmpty()) {
                Box(Modifier.weight(1f).fillMaxWidth().padding(start = 16.dp, end = 16.dp, top = 8.dp), contentAlignment = Alignment.Center) {
                    EmptyState(Symbols.Inventory2, if (tasks) "No archived tasks" else "No archived habits",
                        "When you archive a ${if (tasks) "task" else "habit"}, it waits here with its history.")
                }
            } else LazyColumn(Modifier.weight(1f).fillMaxWidth().padding(horizontal = 16.dp).semantics { testTag = "archived-list" }) {
                item(key = "note") {
                    Text(if (tasks) "Archived tasks keep their history. They're off Today and the Tasks list."
                        else "Archived habits keep everything they had. They're off Today and send no reminders." +
                        if (store.isPlus) "" else " They don't count toward your five free habits.",
                        Modifier.padding(start = 16.dp, end = 16.dp, top = 8.dp, bottom = 24.dp), style = AppType.bodyLarge, color = s.onSurfaceVariant)
                }
                archived.forEachIndexed { i, h ->
                    item(key = h.id) {
                        var open by remember { mutableStateOf(false) }
                        AppListItem(h.name, i, archived.size, Modifier.padding(bottom = SegmentedListGap), store.archivedLine(h),
                            leading = { HabitIcon(h.symbol, h.color) },
                            trailing = {
                                Box {
                                    StandardIconButton(Symbols.MoreVert, "More for ${h.name}", { open = true }, Modifier.semantics { testTag = "habits-row-more-" + h.name })
                                    AppMenu(open, { open = false }, modifier = Modifier.semantics { testTagsAsResourceId = true }) {
                                        AppMenuItem("Restore", { open = false; restore(h) }, icon = Symbols.Unarchive, tag = "archived-menu-restore")
                                        AppMenuItem("Delete", { open = false; deleting = h }, icon = Symbols.Delete, destructive = true, tag = "archived-menu-delete")
                                    }
                                }
                            },
                            onClick = { nav.open(h) }, containerColor = s.surfaceBright, headlineLines = 1, tag = "habits-row-" + h.name)
                    }
                }
                item { Spacer(Modifier.navigationBarsPadding().height(40.dp)) }
            }
        }
        AppSnackbarHost(snackbar, Modifier.align(Alignment.BottomCenter).navigationBarsPadding().padding(4.dp))
    }
    deleting?.let { h ->
        AppDialog("Delete ${h.name}?", "Its history and notes are deleted too.", "Delete", { deleting = null; delete(h) }, { deleting = null },
            destructive = true, confirmTag = "delete-confirm")
    }
}
