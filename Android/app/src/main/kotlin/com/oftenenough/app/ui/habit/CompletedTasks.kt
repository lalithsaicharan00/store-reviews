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
import androidx.compose.material.icons.automirrored.outlined.Undo
import androidx.compose.material.icons.automirrored.rounded.ArrowBack
import androidx.compose.material.icons.outlined.Delete
import androidx.compose.material.icons.outlined.DeleteSweep
import androidx.compose.material.icons.rounded.MoreVert
import androidx.compose.material.icons.rounded.TaskAlt
import androidx.compose.material.icons.rounded.Search
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.SnackbarDuration
import androidx.compose.material3.SnackbarHost
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.SnackbarResult
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
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.foundation.shape.RoundedCornerShape
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Entry
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.NO_DATE_DAY
import com.oftenenough.app.data.doneEntry
import com.oftenenough.app.data.isOneTimeTask
import com.oftenenough.app.data.isTask
import com.oftenenough.app.ui.components.CookieIcon
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.Locale

interface CompletedNav {
    fun open(task: Habit)
    fun back()
}

/** One finished task: a one-time task's done log, or one time a repeating task was done. */
private class Done(val task: Habit, val entry: Entry, val doneOn: Int) {
    val key get() = entry.id
}

private val doneHeading = DateTimeFormatter.ofPattern("EEEE, d MMM", Locale.ENGLISH)
private val doneHeadingYear = DateTimeFormatter.ofPattern("EEEE, d MMM yyyy", Locale.ENGLISH)
private val forDay = DateTimeFormatter.ofPattern("d MMM", Locale.ENGLISH)

/**
 * Completed tasks (Habits & Tasks, flows 28–29): every task finished, by the day it was done, newest first, one-time and
 * repeating together; each with the time done and the day it was for when that's another day. A row's ⋮ takes it back
 * (**Mark as not done**, with Undo) or deletes it (**Delete**, red, asking first). The page's one action is in the top
 * bar's ⋮: **Delete all completed**, which asks how many and says that open and repeating tasks stay; nothing is
 * selected here (A68). Nothing is ever deleted by the app.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun CompletedTasksScreen(store: HabitStore, nav: CompletedNav) {
    val c = appColors
    val scope = rememberCoroutineScope()
    val snackbar = remember { SnackbarHostState() }
    var searching by rememberSaveable { mutableStateOf(false) }
    var query by rememberSaveable { mutableStateOf("") }
    var hidden by remember { mutableStateOf(emptySet<String>()) }
    var deleting by remember { mutableStateOf<List<Habit>>(emptyList()) }
    var clearing by remember { mutableStateOf(false) }
    var topMenu by remember { mutableStateOf(false) }
    val today = store.today()
    BackHandler { if (searching) { searching = false; query = "" } else nav.back() }

    val all = remember(store.habits, store.dataVersion, hidden, today) {
        store.habits.filter { it.isTask && !it.archived && it.id !in hidden }.flatMap { t ->
            val list = if (t.isOneTimeTask) listOfNotNull(store.doneEntry(t)) else store.entries(t.id)
            list.map { e -> Done(t, e, store.today(e.createdAt)) }
        }.sortedByDescending { it.entry.createdAt }
    }
    val q = query.trim().lowercase()
    val shown = if (q.isEmpty()) all else all.filter { it.task.name.lowercase().contains(q) }
    // A repeating task's done times are its history and stay with it: only a one-time task is deleted from here.
    val deletable = all.filter { it.task.isOneTimeTask }.map { it.task }.distinctBy { it.id }

    fun heading(day: Int): String = when (day) {
        today -> "Today"
        today - 1 -> "Yesterday"
        else -> LocalDate.ofEpochDay(day.toLong()).let { d ->
            d.format(if (d.year == LocalDate.ofEpochDay(today.toLong()).year) doneHeading else doneHeadingYear)
        }
    }
    fun line(d: Done): String {
        val planned = if (d.task.isOneTimeTask) d.task.dueDay?.takeIf { it != NO_DATE_DAY } else d.entry.day
        return "Done " + DayWords.clock(d.entry.createdAt) +
            (planned?.takeIf { it != d.doneOn }?.let { " · for " + LocalDate.ofEpochDay(it.toLong()).format(forDay) } ?: "")
    }
    fun notDone(d: Done) {
        store.undoEntry(d.entry.id)
        val due = d.task.dueDay
        val where = when {
            !d.task.isOneTimeTask || due == null || due <= today -> "back in Today"
            due == NO_DATE_DAY -> "back under No date"
            else -> "open again"
        }
        scope.launch {
            snackbar.currentSnackbarData?.dismiss()
            if (snackbar.showSnackbar("${d.task.name} is $where", "Undo", duration = SnackbarDuration.Short) == SnackbarResult.ActionPerformed) store.putBack(d.entry)
        }
    }
    fun delete(list: List<Habit>) {
        val ids = list.map { it.id }.toSet()
        hidden = hidden + ids
        scope.launch {
            snackbar.currentSnackbarData?.dismiss()
            var undone = false
            try {
                val text = if (list.size == 1) "${list[0].name} deleted" else "${list.size} completed tasks deleted"
                undone = snackbar.showSnackbar(text, "Undo", duration = SnackbarDuration.Short) == SnackbarResult.ActionPerformed
            } finally {
                if (!undone) store.delete(ids.mapNotNull { store.habit(it) })
                hidden = hidden - ids
            }
        }
    }

    Box(Modifier.fillMaxSize().background(c.screen)) {
        Column(Modifier.fillMaxSize()) {
            when {
                searching -> SearchBar(query, { query = it }, onBack = { searching = false; query = "" }, placeholder = "Search completed tasks")
                else -> TopAppBar(
                    title = { Text("Completed") },
                    navigationIcon = { IconButton(nav::back, Modifier.semantics { testTag = "page-back" }) { Icon(Icons.AutoMirrored.Rounded.ArrowBack, "Back") } },
                    actions = {
                        if (all.isNotEmpty()) IconButton({ searching = true }, Modifier.semantics { testTag = "completed-search" }) { Icon(Icons.Rounded.Search, "Search completed tasks") }
                        // The page's one action (flow 29): one go, no selecting.
                        if (deletable.isNotEmpty()) Box {
                            IconButton({ topMenu = true }, Modifier.semantics { testTag = "completed-more" }) { Icon(Icons.Rounded.MoreVert, "More") }
                            DropdownMenu(topMenu, { topMenu = false }, containerColor = c.menu, shape = RoundedCornerShape(16.dp),
                                modifier = Modifier.semantics { testTagsAsResourceId = true }) {
                                MenuItem("Delete all completed", Icons.Outlined.DeleteSweep, "completed-menu-delete-all", danger = true) { topMenu = false; clearing = true }
                            }
                        }
                    },
                    colors = TopAppBarDefaults.topAppBarColors(containerColor = c.screen, titleContentColor = c.ink,
                        navigationIconContentColor = c.ink, actionIconContentColor = c.ink),
                )
            }
            if (all.isEmpty()) {
                Column(Modifier.weight(1f).fillMaxWidth().padding(horizontal = 32.dp).semantics { testTag = "completed-empty" },
                    horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.Center) {
                    CookieIcon(Icons.Rounded.TaskAlt, 112.dp)
                    Spacer(Modifier.height(24.dp))
                    Text("Nothing completed yet", style = AppType.titleLarge, color = c.ink)
                    Spacer(Modifier.height(12.dp))
                    Text("Tasks you finish are kept here, by the day you did them.", style = AppType.bodyLarge, color = c.secondary, textAlign = TextAlign.Center)
                    Spacer(Modifier.height(96.dp))
                }
            } else LazyColumn(Modifier.weight(1f).fillMaxWidth().padding(horizontal = 16.dp).semantics { testTag = "completed-list" }) {
                if (!searching) item(key = "note") {
                    Text("Every task you finish, by the day you did it. To bring one back, use its ⋮ menu.",
                        Modifier.padding(start = 16.dp, end = 16.dp, top = 8.dp, bottom = 8.dp), style = AppType.bodyMedium, color = c.secondary)
                }
                val days = shown.groupBy { it.doneOn }
                var first = true
                for ((day, list) in days) {
                    item(key = "day-$day") { SectionTitle(heading(day), first) }
                    first = false
                    list.forEachIndexed { i, d ->
                        item(key = d.key) {
                            TaskRow(d.task, listOf(line(d)), true, i, list.size, onClick = { nav.open(d.task) },
                                menu = { _, dismiss ->
                                    MenuItem("Mark as not done", Icons.AutoMirrored.Outlined.Undo, "completed-menu-not-done") { dismiss(); notDone(d) }
                                    if (d.task.isOneTimeTask) MenuItem("Delete", Icons.Outlined.Delete, "completed-menu-delete", danger = true) { dismiss(); deleting = listOf(d.task) }
                                })
                        }
                    }
                }
                item { Spacer(Modifier.height(96.dp)) }
            }
        }
        SnackbarHost(snackbar, Modifier.align(Alignment.BottomCenter).navigationBarsPadding().padding(4.dp))
    }
    if (deleting.isNotEmpty()) {
        val list = deleting
        val one = list.size == 1
        AlertDialog({ deleting = emptyList() },
            modifier = Modifier.semantics { testTagsAsResourceId = true },
            title = { Text(if (one) "Delete ${list[0].name}?" else "Delete ${list.size} completed tasks?") },
            text = { Text(if (one) "It's gone for good once the next screen closes, with its notes. Your open tasks aren't touched."
                else "They're gone for good once the next screen closes, with their notes. Your open tasks aren't touched.") },
            confirmButton = { TextButton({ deleting = emptyList(); delete(list) }, Modifier.semantics { testTag = "delete-confirm" }) { Text("Delete", color = c.error) } },
            dismissButton = { TextButton({ deleting = emptyList() }, Modifier.semantics { testTag = "delete-cancel" }) { Text("Cancel", color = c.ink) } },
            containerColor = c.menu, titleContentColor = c.ink, textContentColor = c.secondary)
    }
    // Delete all completed (flow 29): how many go, what stays, two buttons; then the page is empty and Undo is in the snackbar.
    if (clearing) {
        val list = deletable
        AlertDialog({ clearing = false },
            modifier = Modifier.semantics { testTagsAsResourceId = true },
            title = { Text(if (list.size == 1) "Delete 1 completed task?" else "Delete all ${list.size} completed tasks?") },
            text = { Text("Their notes go with them. Your open tasks and your repeating tasks stay as they are.") },
            confirmButton = { TextButton({ clearing = false; delete(list) }, Modifier.semantics { testTag = "delete-confirm" }) { Text("Delete", color = c.error) } },
            dismissButton = { TextButton({ clearing = false }, Modifier.semantics { testTag = "delete-cancel" }) { Text("Cancel", color = c.ink) } },
            containerColor = c.menu, titleContentColor = c.ink, textContentColor = c.secondary)
    }
}
