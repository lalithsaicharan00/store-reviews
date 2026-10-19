package com.oftenenough.app.ui.habit

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
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.ArrowBack
import androidx.compose.material.icons.outlined.Delete
import androidx.compose.material.icons.outlined.Unarchive
import androidx.compose.material.icons.rounded.Close
import androidx.compose.material.icons.rounded.Inventory2
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.SnackbarDuration
import androidx.compose.material3.SnackbarHost
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.SnackbarResult
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
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
fun ArchivedHabitsScreen(store: HabitStore, nav: ArchivedNav) {
    val c = appColors
    val scope = rememberCoroutineScope()
    val snackbar = remember { SnackbarHostState() }
    var chosen by rememberSaveable { mutableStateOf(emptySet<String>()) }
    var hidden by remember { mutableStateOf(emptySet<String>()) }
    var deleting by remember { mutableStateOf<List<Habit>>(emptyList()) }
    val selecting = chosen.isNotEmpty()
    BackHandler { if (selecting) chosen = emptySet() else nav.back() }
    val archived = store.habits.filter { it.archived && it.kind != HabitKind.Task && it.id !in hidden }
        .sortedByDescending { store.archivedOn[it.id] ?: Int.MIN_VALUE }
    val marked = archived.filter { it.id in chosen }
    fun named(list: List<Habit>) = if (list.size == 1) list[0].name else "${list.size} habits"
    fun restore(list: List<Habit>) {
        val back = mutableListOf<Habit>()
        for (h in list) if (store.restore(h)) back += h
        val missed = list - back.toSet()
        if (back.isNotEmpty()) scope.launch {
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
            if (selecting) TopAppBar(
                title = { Text("${chosen.size} selected") },
                navigationIcon = { IconButton({ chosen = emptySet() }) { Icon(Icons.Rounded.Close, "Stop selecting") } },
                actions = {
                    val everything = chosen.size == archived.size
                    TextButton({ chosen = if (everything) emptySet() else archived.map { it.id }.toSet() }, Modifier.padding(end = 4.dp)) {
                        Text(if (everything) "Deselect all" else "Select all", style = AppType.labelLarge, color = c.ink)
                    }
                },
                colors = TopAppBarDefaults.topAppBarColors(containerColor = c.tonal, titleContentColor = c.ink, navigationIconContentColor = c.ink),
            ) else TopAppBar(
                title = { Text("Archived habits") },
                navigationIcon = { IconButton(nav::back, Modifier.semantics { testTag = "page-back" }) { Icon(Icons.AutoMirrored.Rounded.ArrowBack, "Back") } },
                colors = TopAppBarDefaults.topAppBarColors(containerColor = c.screen, titleContentColor = c.ink, navigationIconContentColor = c.ink),
            )
            if (archived.isEmpty()) {
                Column(Modifier.weight(1f).fillMaxWidth().padding(horizontal = 32.dp), horizontalAlignment = Alignment.CenterHorizontally,
                    verticalArrangement = Arrangement.Center) {
                    CookieIcon(Icons.Rounded.Inventory2, 112.dp)
                    Spacer(Modifier.height(24.dp))
                    Text("Nothing archived", style = AppType.titleLarge, color = c.ink)
                    Spacer(Modifier.height(12.dp))
                    Text("Habits you archive keep their history here, and you can restore them any time.", style = AppType.bodyLarge,
                        color = c.secondary, textAlign = TextAlign.Center)
                    Spacer(Modifier.height(96.dp))
                }
            } else LazyColumn(Modifier.weight(1f).fillMaxWidth().padding(horizontal = 16.dp).semantics { testTag = "archived-list" }) {
                item(key = "note") {
                    Text("Archived habits keep all their history and send no reminders." +
                        if (store.isPlus) "" else " They don't count toward your five free habits.",
                        Modifier.padding(start = 16.dp, end = 16.dp, top = 8.dp, bottom = 16.dp), style = AppType.bodyMedium, color = c.secondary)
                }
                archived.forEachIndexed { i, h ->
                    item(key = h.id) {
                        HabitsRow(h, store.archivedLine(h), i, archived.size, selecting, h.id in chosen,
                            onClick = { if (selecting) chosen = if (h.id in chosen) chosen - h.id else chosen + h.id else nav.open(h) },
                            onLongClick = { chosen = if (h.id in chosen) chosen - h.id else chosen + h.id },
                            menu = if (selecting) null else { habit, dismiss ->
                                MenuItem("Restore", Icons.Outlined.Unarchive, "archived-menu-restore") { dismiss(); restore(listOf(habit)) }
                                HorizontalDivider(color = c.tonal)
                                MenuItem("Delete habit…", Icons.Outlined.Delete, "archived-menu-delete", danger = true) { dismiss(); deleting = listOf(habit) }
                            })
                    }
                }
                item { Spacer(Modifier.height(96.dp)) }
            }
            if (selecting) Surface(color = c.surface, tonalElevation = 3.dp) {
                Row(Modifier.fillMaxWidth().navigationBarsPadding().padding(8.dp), horizontalArrangement = Arrangement.SpaceEvenly) {
                    BarAction("Restore", Icons.Outlined.Unarchive, true, "archived-restore", { restore(marked); chosen = emptySet() })
                    BarAction("Delete", Icons.Outlined.Delete, true, "archived-delete", { deleting = marked }, danger = true)
                }
            }
        }
        SnackbarHost(snackbar, Modifier.align(Alignment.BottomCenter).navigationBarsPadding().padding(4.dp).padding(bottom = if (selecting) 88.dp else 0.dp))
    }
    if (deleting.isNotEmpty()) {
        val list = deleting
        AlertDialog({ deleting = emptyList() },
            title = { Text(if (list.size == 1) "Delete ${list[0].name}?" else "Delete ${list.size} habits?") },
            text = { Text(if (list.size == 1) "Its history and notes are deleted too." else "Their history and notes are deleted too.") },
            confirmButton = { TextButton({ deleting = emptyList(); chosen = emptySet(); delete(list) }, Modifier.semantics { testTag = "delete-confirm" }) { Text("Delete", color = c.error) } },
            dismissButton = { TextButton({ deleting = emptyList() }) { Text("Cancel", color = c.ink) } },
            containerColor = c.menu, titleContentColor = c.ink, textContentColor = c.secondary)
    }
}
