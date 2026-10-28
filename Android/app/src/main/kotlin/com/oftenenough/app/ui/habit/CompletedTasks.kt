package com.oftenenough.app.ui.habit

import com.oftenenough.app.ui.components.AppSnackbarHost
import com.oftenenough.app.ui.components.AppMenuItem
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.SearchHeader
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
 * Completed tasks (Tasks, Figma 8–8.6): every task finished, by the day it was done, newest first, one-time and repeating
 * together; each with the time done and the day it was for when that's another day. Its ⋮ takes it back (Mark as not
 * done, with Undo). A long press selects completed one-time tasks to delete them (a repeating task's done times are its
 * history and stay with it). Nothing here is ever deleted by the app.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun CompletedTasksScreen(store: HabitStore, nav: CompletedNav) {
    val c = appColors
    val scope = rememberCoroutineScope()
    val snackbar = remember { SnackbarHostState() }
    var chosen by rememberSaveable { mutableStateOf(emptySet<String>()) }
    var selecting by rememberSaveable { mutableStateOf(false) }
    var searching by rememberSaveable { mutableStateOf(false) }
    var query by rememberSaveable { mutableStateOf("") }
    var hidden by remember { mutableStateOf(emptySet<String>()) }
    var deleting by remember { mutableStateOf<List<Habit>>(emptyList()) }
    val today = store.today()
    fun endSelection() { selecting = false; chosen = emptySet() }
    BackHandler { if (selecting) endSelection() else if (searching) { searching = false; query = "" } else nav.back() }

    val all = remember(store.habits, store.dataVersion, hidden, today) {
        store.habits.filter { it.isTask && !it.archived && it.id !in hidden }.flatMap { t ->
            val list = if (t.isOneTimeTask) listOfNotNull(store.doneEntry(t)) else store.entries(t.id)
            list.map { e -> Done(t, e, store.today(e.createdAt)) }
        }.sortedByDescending { it.entry.createdAt }
    }
    val q = query.trim().lowercase()
    val shown = if (q.isEmpty()) all else all.filter { it.task.name.lowercase().contains(q) }
    val deletable = all.filter { it.task.isOneTimeTask }.map { it.task.id }.toSet()
    val marked = all.filter { it.task.id in chosen }.map { it.task }.distinctBy { it.id }

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
    fun toggle(t: Habit) { if (t.id in deletable) chosen = if (t.id in chosen) chosen - t.id else chosen + t.id }

    Box(Modifier.fillMaxSize().background(c.screen)) {
        Column(Modifier.fillMaxSize()) {
            when {
                searching -> SearchHeader(query, { query = it.take(40) }, onBack = { searching = false; query = "" }, "Search completed tasks",
                    fieldTag = "habits-search-field", backTag = "habits-search-back", clearTag = "habits-search-clear")
                selecting -> AppTopBar(
                    if (chosen.isEmpty()) "Select tasks" else "${chosen.size} selected",
                    navigationIcon = { IconButton(::endSelection, Modifier.semantics { testTag = "completed-end-selection" }) { Icon(Symbols.Close, "Stop selecting") } },
                    actions = {
                        val everything = deletable.isNotEmpty() && chosen.containsAll(deletable)
                        AppButton(if (everything) "Deselect all" else "Select all", { chosen = if (everything) emptySet() else deletable }, Modifier.padding(end = 4.dp).semantics { testTag = "completed-select-all" }, style = ButtonStyle.Text)
                    },
                    containerColor = c.tonal,
                )
                else -> AppTopBar(
                    "Completed",
                    navigationIcon = { IconButton(nav::back, Modifier.semantics { testTag = "page-back" }) { Icon(Symbols.ArrowBack, "Back") } },
                    actions = {
                        if (all.isNotEmpty()) IconButton({ searching = true }, Modifier.semantics { testTag = "completed-search" }) { Icon(Symbols.Search, "Search completed tasks") }
                    },
                )
            }
            if (all.isEmpty()) {
                Column(Modifier.weight(1f).fillMaxWidth().padding(horizontal = 32.dp).semantics { testTag = "completed-empty" },
                    horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.Center) {
                    CookieIcon(Symbols.TaskAlt, 112.dp)
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
                            TaskRow(d.task, listOf(line(d)), true, i, list.size, selecting, d.task.id in chosen,
                                onClick = { if (selecting) toggle(d.task) else nav.open(d.task) },
                                onLongClick = { if (d.task.id in deletable) { selecting = true; toggle(d.task) } },
                                menu = if (selecting) null else { _, dismiss ->
                                    AppMenuItem("Mark as not done", { dismiss(); notDone(d) }, icon = Symbols.Undo, tag = "completed-menu-not-done")
                                })
                        }
                    }
                }
                item { Spacer(Modifier.height(96.dp)) }
            }
            if (selecting) Surface(color = c.surface, tonalElevation = 3.dp) {
                Row(Modifier.fillMaxWidth().navigationBarsPadding().padding(8.dp), horizontalArrangement = Arrangement.SpaceEvenly) {
                    BarAction("Delete", Symbols.Delete, marked.isNotEmpty(), "completed-delete", { deleting = marked }, danger = true)
                }
            }
        }
        AppSnackbarHost(snackbar, Modifier.align(Alignment.BottomCenter).navigationBarsPadding().padding(4.dp).padding(bottom = if (selecting) 88.dp else 0.dp))
    }
    if (deleting.isNotEmpty()) {
        val list = deleting
        val one = list.size == 1
        AlertDialog({ deleting = emptyList() },
            modifier = Modifier.semantics { testTagsAsResourceId = true },
            title = { Text(if (one) "Delete ${list[0].name}?" else "Delete ${list.size} completed tasks?") },
            text = { Text(if (one) "It's gone for good once the next screen closes, with its notes. Your open tasks aren't touched."
                else "They're gone for good once the next screen closes, with their notes. Your open tasks aren't touched.") },
            confirmButton = { AppButton("Delete", { deleting = emptyList(); endSelection(); delete(list) }, Modifier.semantics { testTag = "delete-confirm" }, style = ButtonStyle.Text, destructive = true) },
            dismissButton = { AppButton("Cancel", { deleting = emptyList() }, Modifier.semantics { testTag = "delete-cancel" }, style = ButtonStyle.Text) },
            containerColor = c.menu, titleContentColor = c.ink, textContentColor = c.secondary)
    }
}
