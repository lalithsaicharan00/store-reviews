package com.oftenenough.app.ui.habit

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
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.SnackbarDuration
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.SnackbarResult
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Entry
import com.oftenenough.app.data.HabitCopy
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.NO_DATE_DAY
import com.oftenenough.app.data.doneEntry
import com.oftenenough.app.data.isOneTimeTask
import com.oftenenough.app.data.isTask
import com.oftenenough.app.ui.components.AppDialog
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.components.AppMenu
import com.oftenenough.app.ui.components.AppMenuItem
import com.oftenenough.app.ui.components.AppSnackbarHost
import com.oftenenough.app.ui.components.AppTopBar
import com.oftenenough.app.ui.components.EmptyState
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.SegmentedListGap
import com.oftenenough.app.ui.components.StandardIconButton
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.Symbols
import kotlinx.coroutines.launch
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.Locale

interface CompletedNav {
    fun open(task: Habit)
    fun back()
}

/** One finished task: a one-time task's done log, or one time a repeating task was done. */
private class Done(val task: Habit, val entry: Entry, val doneOn: Int)

private val dayHeading = DateTimeFormatter.ofPattern("EEE, d MMM", Locale.ENGLISH)
private val dayHeadingYear = DateTimeFormatter.ofPattern("EEE, d MMM yyyy", Locale.ENGLISH)
private val weekday = DateTimeFormatter.ofPattern("EEE", Locale.ENGLISH)
private val dayMonth = DateTimeFormatter.ofPattern("d MMM", Locale.ENGLISH)

/**
 * 5.5.6, **Completed tasks page** (Figma 1002:230, Screen Completed · Menu open · Open again · Nothing completed ·
 * Deleted; Components — Atoms Build Plan): from Tasks › Completed. The Top app bar (←, "Completed tasks", and ⋮ with
 * the page's one action, **Delete all completed**) on Surface container. The content 16 at the sides, 8 above, 40 under,
 * 24 between the days: every task finished, by the day it was done, newest first, one-time and repeating together. A
 * day's subheader ("Today", "Thu, 22 Oct") in Label Large Primary, 16 in, 8 above its rounded list of two-line List
 * items 2 apart on Surface bright: the task's icon in its colour, its name, "Done 9:12 AM" with "· planned for Wed" when
 * it was planned for another day, or "· every day" for a repeating task, and ⋮ with **Mark as not done** (Undo) and
 * **Delete** (red, asked first). A row opens its Task details. Delete all completed asks "Delete 14 completed tasks?"
 * (Cancel | Delete) and says so with Undo; repeating tasks and tasks still to do stay. Nothing completed: the Empty
 * state (task_alt in its cookie), no ⋮. No search and no selecting several (A55).
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun CompletedTasksScreen(store: HabitStore, nav: CompletedNav) {
    val s = MaterialTheme.colorScheme
    val scope = rememberCoroutineScope()
    val snackbar = remember { SnackbarHostState() }
    var hidden by remember { mutableStateOf(emptySet<String>()) }
    var deleting by remember { mutableStateOf<List<Habit>>(emptyList()) }
    var deletingAll by remember { mutableStateOf(false) }
    var menu by remember { mutableStateOf(false) }
    val today = store.today()
    BackHandler { nav.back() }

    val all = remember(store.habits, store.dataVersion, hidden, today) {
        store.habits.filter { it.isTask && !it.archived && it.id !in hidden }.flatMap { t ->
            val list = if (t.isOneTimeTask) listOfNotNull(store.doneEntry(t)) else store.entries(t.id)
            list.map { e -> Done(t, e, store.today(e.createdAt)) }
        }.sortedByDescending { it.entry.createdAt }
    }
    // Delete all completed takes the one-time tasks only: a repeating task's done times are its history (Figma's
    // "Tasks still to do and repeating tasks stay").
    val finished = all.filter { it.task.isOneTimeTask }.map { it.task }.distinctBy { it.id }

    fun heading(day: Int): String = when (day) {
        today -> "Today"
        else -> LocalDate.ofEpochDay(day.toLong()).let { d ->
            d.format(if (d.year == LocalDate.ofEpochDay(today.toLong()).year) dayHeading else dayHeadingYear)
        }
    }
    fun line(d: Done): String {
        val done = "Done " + DayWords.clock(d.entry.createdAt)
        if (!d.task.isOneTimeTask) return HabitCopy.rhythm(d.task.frequency, store.weekStart, short = true).takeIf { it.isNotEmpty() }?.let { "$done · $it" } ?: done
        val planned = d.task.dueDay?.takeIf { it != NO_DATE_DAY && it != d.doneOn } ?: return done
        val p = LocalDate.ofEpochDay(planned.toLong())
        return "$done · planned for " + p.format(if (planned in d.doneOn - 6 until d.doneOn) weekday else dayMonth)
    }
    fun notDone(d: Done) {
        store.undoEntry(d.entry.id)
        scope.launch {
            snackbar.currentSnackbarData?.dismiss()
            if (snackbar.showSnackbar("${d.task.name} is open again", "Undo", duration = SnackbarDuration.Short) == SnackbarResult.ActionPerformed) store.putBack(d.entry)
        }
    }
    // Hidden at once; deleted only once Undo has gone (D6).
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

    Box(Modifier.fillMaxSize().background(s.surfaceContainer)) {
        Column(Modifier.fillMaxSize()) {
            AppTopBar(
                "Completed tasks",
                navigationIcon = { IconButton(nav::back, Modifier.semantics { testTag = "page-back" }) { Icon(Symbols.ArrowBack, "Back") } },
                actions = {
                    if (finished.isNotEmpty()) Box {
                        StandardIconButton(Symbols.MoreVert, "More", { menu = true }, Modifier.semantics { testTag = "completed-more" })
                        AppMenu(menu, { menu = false }, modifier = Modifier.semantics { testTagsAsResourceId = true }) {
                            AppMenuItem("Delete all completed", { menu = false; deleting = finished; deletingAll = true }, icon = Symbols.Delete, destructive = true, tag = "completed-delete-all")
                        }
                    }
                },
            )
            if (all.isEmpty()) {
                Box(Modifier.weight(1f).fillMaxWidth().padding(start = 16.dp, end = 16.dp, top = 8.dp).semantics { testTag = "completed-empty" }, contentAlignment = Alignment.Center) {
                    EmptyState(Symbols.TaskAlt, "Nothing completed yet", "Tasks you tick off on Today come here when the day ends.")
                }
            } else LazyColumn(Modifier.weight(1f).fillMaxWidth().padding(horizontal = 16.dp).semantics { testTag = "completed-list" }) {
                val days = all.groupBy { it.doneOn }
                var first = true
                for ((day, list) in days) {
                    val top = if (first) 8.dp else 24.dp
                    first = false
                    item(key = "day-$day") {
                        Text(heading(day), Modifier.padding(start = 16.dp, end = 16.dp, top = top, bottom = 8.dp).semantics { heading() },
                            style = AppType.labelLarge, color = s.primary)
                    }
                    list.forEachIndexed { i, d ->
                        item(key = d.entry.id) {
                            var open by remember { mutableStateOf(false) }
                            AppListItem(d.task.name, i, list.size, Modifier.padding(bottom = SegmentedListGap), line(d),
                                leading = { HabitIcon(d.task.symbol, d.task.color) },
                                trailing = {
                                    Box {
                                        StandardIconButton(Symbols.MoreVert, "More for ${d.task.name}", { open = true }, Modifier.semantics { testTag = "tasks-row-more-" + d.task.name })
                                        AppMenu(open, { open = false }, modifier = Modifier.semantics { testTagsAsResourceId = true }) {
                                            AppMenuItem("Mark as not done", { open = false; notDone(d) }, icon = Symbols.Undo, tag = "completed-menu-not-done")
                                            // A repeating task's Delete isn't drawn (Figma's menu is a one-time task's): held for the user.
                                            if (d.task.isOneTimeTask) AppMenuItem("Delete", { open = false; deleting = listOf(d.task); deletingAll = false }, icon = Symbols.Delete, destructive = true, tag = "completed-menu-delete")
                                        }
                                    }
                                },
                                onClick = { nav.open(d.task) }, containerColor = s.surfaceBright, headlineLines = 1, tag = "tasks-row-" + d.task.name)
                        }
                    }
                }
                item { Spacer(Modifier.navigationBarsPadding().height(40.dp)) }
            }
        }
        AppSnackbarHost(snackbar, Modifier.align(Alignment.BottomCenter).navigationBarsPadding().padding(4.dp))
    }
    if (deleting.isNotEmpty()) {
        val list = deleting
        val one = list.size == 1
        AppDialog(
            when {
                !deletingAll -> "Delete ${list[0].name}?"
                one -> "Delete 1 completed task?"
                else -> "Delete ${list.size} completed tasks?"
            },
            (if (one) "It goes for good, with its notes." else "They go for good, with their notes.") +
                if (deletingAll) " Tasks still to do and repeating tasks stay." else "",
            "Delete", { deleting = emptyList(); delete(list) }, { deleting = emptyList() },
            destructive = true, confirmTag = "delete-confirm", dismissTag = "delete-cancel")
    }
}
