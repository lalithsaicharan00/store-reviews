package com.oftenenough.app.ui.habit

import com.oftenenough.app.ui.components.AppSnackbarHost
import com.oftenenough.app.ui.components.AppMenuItem
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.MenuDivider
import com.oftenenough.app.ui.components.AppTopBar
import androidx.activity.compose.BackHandler
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
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material3.AlertDialog
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
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.archivedLine
import com.oftenenough.app.ui.components.CookieIcon
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch

interface ArchivedNav {
    fun open(habit: Habit)
    /** Restoring would make a sixth habit on the free plan (Figma 6.4): Restore a 6th habit, then this one comes back. */
    fun restoreNoRoom(habit: Habit)
    fun back()
}

/**
 * Archived habits (Figma 2106:2, 6–6.9): newest first, each with when it was archived (or what it started over as) and its
 * ⋮, Restore or Delete habit…. Restored, a habit goes back to its old section and place on Habits with all its history.
 * Long press selects several. Nothing archived says so.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ArchivedHabitsScreen(store: HabitStore, nav: ArchivedNav, tasks: Boolean = false) {
    val c = appColors
    val scope = rememberCoroutineScope()
    val snackbar = remember { SnackbarHostState() }
    var chosen by rememberSaveable { mutableStateOf(emptySet<String>()) }
    var hidden by remember { mutableStateOf(emptySet<String>()) }
    var deleting by remember { mutableStateOf<List<Habit>>(emptyList()) }
    val selecting = chosen.isNotEmpty()
    BackHandler { if (selecting) chosen = emptySet() else nav.back() }
    // Archived tasks (Tasks, Figma 9–9.4) are the same page for tasks.
    val archived = store.habits.filter { it.archived && (it.kind == HabitKind.Task) == tasks && it.id !in hidden }
        .sortedByDescending { store.archivedOn[it.id] ?: Int.MIN_VALUE }
    val marked = archived.filter { it.id in chosen }
    val noun = if (tasks) "task" else "habit"
    fun named(list: List<Habit>) = if (list.size == 1) list[0].name else "${list.size} ${noun}s"
    fun restore(list: List<Habit>) {
        val back = mutableListOf<Habit>()
        for (h in list) if (store.restore(h)) back += h
        val missed = list - back.toSet()
        // A task goes back under its day, or Today when its day has passed (Figma 9.2); Undo archives it again.
        if (tasks && back.isNotEmpty()) scope.launch {
            snackbar.currentSnackbarData?.dismiss()
            val today = store.today()
            val where = if (back.size == 1 && back[0].dueDay != null && back[0].dueDay!! > today) "back in Tasks" else "back in Today"
            val text = if (back.size == 1) "${back[0].name} is $where" else "${back.size} tasks are back"
            if (snackbar.showSnackbar(text, "Undo", duration = SnackbarDuration.Short) == SnackbarResult.ActionPerformed) store.archive(back)
        } else if (back.isNotEmpty()) scope.launch {
            snackbar.currentSnackbarData?.dismiss()
            if (snackbar.showSnackbar("${named(back)} restored", "View", duration = SnackbarDuration.Short) == SnackbarResult.ActionPerformed) nav.back()
        }
        missed.firstOrNull()?.let { nav.restoreNoRoom(it) }
    }
    fun delete(list: List<Habit>) {
        val ids = list.map { it.id }.toSet()
        hidden = hidden + ids
        scope.launch {
            snackbar.currentSnackbarData?.dismiss()
            var undone = false
            try {
                undone = snackbar.showSnackbar("${named(list)} deleted", "Undo", duration = SnackbarDuration.Short) == SnackbarResult.ActionPerformed
            } finally {
                if (!undone) store.delete(ids.mapNotNull { store.habit(it) })
                hidden = hidden - ids
            }
        }
    }

    Box(Modifier.fillMaxSize().background(c.screen)) {
        Column(Modifier.fillMaxSize()) {
            if (selecting) AppTopBar(
                "${chosen.size} selected",
                navigationIcon = { IconButton({ chosen = emptySet() }) { Icon(Symbols.Close, "Stop selecting") } },
                actions = {
                    val everything = chosen.size == archived.size
                    AppButton(if (everything) "Deselect all" else "Select all", { chosen = if (everything) emptySet() else archived.map { it.id }.toSet() }, Modifier.padding(end = 4.dp), style = ButtonStyle.Text)
                },
                containerColor = c.tonal,
            ) else AppTopBar(
                if (tasks) "Archived tasks" else "Archived habits",
                navigationIcon = { IconButton(nav::back, Modifier.semantics { testTag = "page-back" }) { Icon(Symbols.ArrowBack, "Back") } },
            )
            if (archived.isEmpty()) {
                Column(Modifier.weight(1f).fillMaxWidth().padding(horizontal = 32.dp), horizontalAlignment = Alignment.CenterHorizontally,
                    verticalArrangement = Arrangement.Center) {
                    CookieIcon(Symbols.Inventory2, 112.dp)
                    Spacer(Modifier.height(24.dp))
                    Text("Nothing archived", style = AppType.titleLarge, color = c.ink)
                    Spacer(Modifier.height(12.dp))
                    Text(if (tasks) "Tasks you archive keep their history here, and you can restore them any time."
                        else "Habits you archive keep their history here, and you can restore them any time.", style = AppType.bodyLarge,
                        color = c.secondary, textAlign = TextAlign.Center)
                    Spacer(Modifier.height(96.dp))
                }
            } else LazyColumn(Modifier.weight(1f).fillMaxWidth().padding(horizontal = 16.dp).semantics { testTag = "archived-list" }) {
                item(key = "note") {
                    Text(if (tasks) "Archived tasks keep their history and stay off Today and Tasks. Restore one to bring it back."
                        else "Archived habits keep all their history and send no reminders." +
                        if (store.isPlus) "" else " They don't count toward your five free habits.",
                        Modifier.padding(start = 16.dp, end = 16.dp, top = 8.dp, bottom = 16.dp), style = AppType.bodyMedium, color = c.secondary)
                }
                archived.forEachIndexed { i, h ->
                    item(key = h.id) {
                        HabitsRow(h, store.archivedLine(h), i, archived.size, selecting, h.id in chosen,
                            onClick = { if (selecting) chosen = if (h.id in chosen) chosen - h.id else chosen + h.id else nav.open(h) },
                            onLongClick = { chosen = if (h.id in chosen) chosen - h.id else chosen + h.id },
                            menu = if (selecting) null else { habit, dismiss ->
                                AppMenuItem("Restore", { dismiss(); restore(listOf(habit)) }, icon = Symbols.Unarchive, tag = "archived-menu-restore")
                                MenuDivider()
                                AppMenuItem(if (tasks) "Delete task…" else "Delete habit…", { dismiss(); deleting = listOf(habit) }, icon = Symbols.Delete, destructive = true, tag = "archived-menu-delete")
                            })
                    }
                }
                item { Spacer(Modifier.height(96.dp)) }
            }
            if (selecting) Surface(color = c.surface, tonalElevation = 3.dp) {
                Row(Modifier.fillMaxWidth().navigationBarsPadding().padding(8.dp), horizontalArrangement = Arrangement.SpaceEvenly) {
                    BarAction("Restore", Symbols.Unarchive, true, "archived-restore", { restore(marked); chosen = emptySet() })
                    BarAction("Delete", Symbols.Delete, true, "archived-delete", { deleting = marked }, danger = true)
                }
            }
        }
        AppSnackbarHost(snackbar, Modifier.align(Alignment.BottomCenter).navigationBarsPadding().padding(4.dp).padding(bottom = if (selecting) 88.dp else 0.dp))
    }
    if (deleting.isNotEmpty()) {
        val list = deleting
        AlertDialog({ deleting = emptyList() },
            modifier = Modifier.semantics { testTagsAsResourceId = true },
            title = { Text(if (list.size == 1) "Delete ${list[0].name}?" else "Delete ${list.size} ${noun}s?") },
            text = { Text(if (list.size == 1) "Its history and notes are deleted too." else "Their history and notes are deleted too.") },
            confirmButton = { AppButton("Delete", { deleting = emptyList(); chosen = emptySet(); delete(list) }, Modifier.semantics { testTag = "delete-confirm" }, style = ButtonStyle.Text, destructive = true) },
            dismissButton = { AppButton("Cancel", { deleting = emptyList() }, style = ButtonStyle.Text) },
            containerColor = c.menu, titleContentColor = c.ink, textContentColor = c.secondary)
    }
}
