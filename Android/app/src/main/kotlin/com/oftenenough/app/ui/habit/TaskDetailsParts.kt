package com.oftenenough.app.ui.habit

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyListScope
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.SnackbarDuration
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.SnackbarResult
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.derivedStateOf
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.stateDescription
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.text.AnnotatedString
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Entry
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.HeatCell
import com.oftenenough.app.data.NO_DATE_DAY
import com.oftenenough.app.data.doneEntry
import com.oftenenough.app.data.isOneTimeTask
import com.oftenenough.app.data.isRepeatingTask
import com.oftenenough.app.data.pageDayDate
import com.oftenenough.app.data.taskDetailsLine
import com.oftenenough.app.data.taskMoveRange
import com.oftenenough.app.data.taskDay
import com.oftenenough.app.data.taskOpenDay
import com.oftenenough.app.data.taskPlannedFor
import com.oftenenough.app.ui.components.AppDatePicker
import com.oftenenough.app.ui.components.AppDialog
import com.oftenenough.app.ui.components.AppExtendedFab
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.components.AppMenu
import com.oftenenough.app.ui.components.AppMenuItem
import com.oftenenough.app.ui.components.AppSnackbarHost
import com.oftenenough.app.ui.components.AppTopBar
import com.oftenenough.app.ui.components.CardNotice
import com.oftenenough.app.ui.components.DayCell
import com.oftenenough.app.ui.components.DayCellSize
import com.oftenenough.app.ui.components.EmptyState
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.ListChevron
import com.oftenenough.app.ui.components.ListNote
import com.oftenenough.app.ui.components.scrolledTopBarColor
import com.oftenenough.app.ui.newhabit.DayDialog
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.Symbols
import kotlinx.coroutines.launch
import java.time.LocalDate

/**
 * 5.6.5, **Task details page** (Figma 1136:9271, Screen One-time · not done yet · One-time · done · Repeating · Menu
 * open; Components — Atoms Build Plan): a tap on a task's row (anywhere but ⋮) opens it. On Surface container: the Top
 * app bar (←, ⋮ with the same actions as the task's ⋮ on Tasks; the name moves into it on scroll), then the large
 * title (the icon 56 in the task's colour, its name in Headline Medium Emphasized, a line in Body Medium On surface
 * variant: "One-time · Tue 4 Nov, Morning", "One-time · done today", "Every 2 months · Next Wed 9 Dec"). No tabs: a task
 * has no Progress, only its days (16 at the sides and above, 16 apart):
 *
 * - **A one-time task not done yet:** the Card notice (event, "Planned for Tue 4 Nov, Morning", "It shows on Today that
 *   day; tick it there.") over the Empty state (task_alt, "Nothing done yet", "When it’s done, the day shows here, with
 *   any note."). A task is ticked on Today, never here (U38).
 * - **Done:** a rounded list on Surface container lowest: "Done" (a one-line List item that folds it), then the day it
 *   was done ("Fri 23 Oct", "Done at 9:12 AM", its note, ›).
 * - **Repeating:** every time it was done, newest first, a list per year ("2026", "Done 4 times", folding it).
 *
 * A day's row opens that day's Day details. Add note (an Extended FAB, edit_note) writes a note for a day.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
internal fun TaskDetailsScreen(task: Habit, store: HabitStore, nav: HabitDetailsNav, onBack: () -> Unit) {
    BackHandler(onBack = onBack)
    val s = MaterialTheme.colorScheme
    val today = store.today()
    val revision = store.revision(task.id)
    val scope = rememberCoroutineScope()
    val snackbar = remember { SnackbarHostState() }
    val listState = rememberLazyListState()
    val collapsed by remember { derivedStateOf { listState.firstVisibleItemIndex > 0 } }
    var menuOpen by remember { mutableStateOf(false) }
    var confirmDelete by remember { mutableStateOf(false) }
    var picking by remember { mutableStateOf(false) }
    var noteDay by remember { mutableStateOf(false) }
    var folded by rememberSaveable(task.id) { mutableStateOf(emptySet<String>()) }
    val line = remember(task, revision, today, store.sections, store.weekStart, store.taskMoves) { store.taskDetailsLine(task, today) }
    val done = remember(task, revision) {
        (if (task.isOneTimeTask) listOfNotNull(store.doneEntry(task)) else store.entries(task.id)).sortedByDescending { it.createdAt }
    }
    fun say(text: String, undo: () -> Unit) {
        scope.launch {
            snackbar.currentSnackbarData?.dismiss()
            if (snackbar.showSnackbar(text, "Undo", duration = SnackbarDuration.Short) == SnackbarResult.ActionPerformed) undo()
        }
    }
    // The same actions, words and Undo as the task's ⋮ on Tasks (Figma: "⋮ holds the same five actions").
    fun move(day: Int) {
        val moves = store.taskMoves[task.id] ?: emptyMap()
        if (task.isOneTimeTask) store.moveTask(task, day)
        else {
            val from = store.taskOpenDay(task, today)
            if (from != null && from != day && day in (store.taskMoveRange(task, today) ?: IntRange.EMPTY)) store.moveOccurrence(task, from, day)
        }
        val undo = { if (task.isOneTimeTask) store.update(task) else store.setTaskMoves(task, moves) }
        if (day == today) say("${task.name} is on Today", undo)
        else say("Moved to " + if (day == today + 1) "Tomorrow" else taskDay(day), undo)
    }
    val kind = when {
        task.isRepeatingTask -> RowKind.REPEATING
        done.isNotEmpty() -> RowKind.DONE
        task.dueDay == NO_DATE_DAY -> RowKind.NO_DATE
        else -> RowKind.ONE_TIME
    }
    // Add note: a one-time task's own day (the day it was done, else its planned day once it has come, else today); a
    // repeating task's day is asked for, with no day chosen (as History's Add, A81).
    val addNote: () -> Unit = {
        if (task.isRepeatingTask) noteDay = true
        else nav.note(task, done.firstOrNull()?.day ?: task.dueDay?.takeIf { it != NO_DATE_DAY && it <= today } ?: today)
    }

    Box(Modifier.fillMaxSize().background(s.surfaceContainer).semantics { testTag = "habit-details" }) {
        Column(Modifier.fillMaxSize()) {
            AppTopBar(
                if (collapsed) task.name else null,
                navigationIcon = { IconButton(onBack, Modifier.semantics { testTag = "page-back" }) { Icon(Symbols.ArrowBack, "Back") } },
                actions = {
                    Box {
                        IconButton({ menuOpen = true }, Modifier.semantics { testTag = "habit-menu" }) { Icon(Symbols.MoreVert, "More") }
                        AppMenu(menuOpen, { menuOpen = false }, modifier = Modifier.semantics { testTagsAsResourceId = true }) {
                            val dismiss = { menuOpen = false }
                            if (task.archived) {
                                AppMenuItem("Restore", { dismiss(); store.restore(task) }, icon = Symbols.Unarchive, tag = "habit-menu-restore")
                                AppMenuItem("Delete", { dismiss(); confirmDelete = true }, icon = Symbols.Delete, destructive = true, tag = "tasks-menu-delete")
                            } else TaskMenuItems(kind, dismiss,
                                onEdit = { nav.edit(task) }, onDuplicate = { nav.duplicate(task) }, onToday = { move(today) }, onPick = { picking = true },
                                onSkip = {
                                    store.taskOpenDay(task, today)?.let { day ->
                                        store.setSkipped(task, day, true)
                                        say("${task.name} skipped this time") { store.setSkipped(task, day, false) }
                                    }
                                },
                                onNotDone = {
                                    store.doneEntry(task)?.let { e -> store.undoEntry(e.id); say("${task.name} is open again") { store.putBack(e) } }
                                },
                                onArchive = { store.archive(listOf(task)); say("${task.name} archived") { store.habit(task.id)?.let { store.restore(it) } } },
                                onDelete = { confirmDelete = true })
                        }
                    }
                },
                containerColor = if (collapsed) scrolledTopBarColor else s.surfaceContainer,
            )
            LazyColumn(Modifier.fillMaxWidth().weight(1f).semantics { testTag = "habit-details-list" }, state = listState) {
                item(key = "header") { TaskHeader(task, line) }
                taskDays(task, store, today, kind, done, folded, { key -> folded = if (key in folded) folded - key else folded + key }) { day -> nav.openDay(task, day) }
                // Room for Add note over the last row.
                item(key = "end") { Spacer(Modifier.navigationBarsPadding().height(if (task.archived) 40.dp else 88.dp)) }
            }
        }
        if (!task.archived) AppExtendedFab("Add note", Symbols.EditNote, addNote,
            Modifier.align(Alignment.BottomEnd).navigationBarsPadding().padding(16.dp), tag = "task-add-note")
        AppSnackbarHost(snackbar, Modifier.align(Alignment.BottomCenter).navigationBarsPadding().padding(4.dp))
    }

    if (picking) {
        // As the Tasks page's: a repeating task's day moves only before its next one; a one-time task to any day from today (A58).
        val last = if (task.isRepeatingTask) store.taskMoveRange(task, today)?.last else null
        DayDialog(maxOf(today, task.dueDay?.takeIf { it != NO_DATE_DAY } ?: today), { it >= today && (last == null || it <= last) },
            { picking = false }) { day -> picking = false; move(day) }
    }
    if (noteDay) {
        val first = store.rules.calendarDayOf(task.createdAt)
        AppDatePicker(null, { it in minOf(first, today)..today }, { noteDay = false }, title = "Add a note to which day?", confirmTag = "note-day-open",
            confirmFor = { picked -> picked?.let { "Open " + pageDayDate(it) } ?: "Open" }, dismissTag = "note-day-cancel") { day -> nav.note(task, day) }
    }
    if (confirmDelete) {
        AppDialog("Delete ${task.name}?",
            // A repeating task goes whole, with every time it was done (A80).
            if (task.isRepeatingTask) "It's a repeating task: it goes for good, with every time it was done and its notes. Its progress can't come back."
            else "Its history and notes are deleted too. To keep them, archive it instead.",
            "Delete", {
                confirmDelete = false
                // The page leaves first (U27); the page under it says so with Undo and deletes once Undo has gone (D6).
                nav.deleted(task)
            }, { confirmDelete = false }, destructive = true, confirmTag = "delete-confirm", dismissTag = "delete-cancel")
    }
}

/** The task in a glance: its icon (56), its name in Headline Medium Emphasized and its line, 16 at the sides and under. */
@Composable
private fun TaskHeader(task: Habit, line: String) {
    val s = MaterialTheme.colorScheme
    Row(Modifier.fillMaxWidth().padding(start = 16.dp, end = 16.dp, bottom = 16.dp).semantics { testTag = "habit-header" },
        verticalAlignment = Alignment.CenterVertically) {
        HabitIcon(task.symbol, task.color, 56.dp, CircleShape, glyph = 0.5f)
        Spacer(Modifier.width(16.dp))
        Column(Modifier.weight(1f).semantics(mergeDescendants = true) { heading() }) {
            Text(task.name, style = AppType.headlineMediumEmphasized, color = s.onSurface, maxLines = 3, overflow = TextOverflow.Ellipsis)
            Text(line, style = AppType.bodyMedium, color = s.onSurfaceVariant)
        }
    }
}

/**
 * The task's days: an archived one's Card notice; a one-time task not done yet, the Planned notice and Nothing done yet;
 * done, "Done" and the day; repeating, a list per year of every time it was done. Each list folds from its first row.
 */
private fun LazyListScope.taskDays(
    task: Habit, store: HabitStore, today: Int, kind: RowKind, done: List<Entry>, folded: Set<String>, onFold: (String) -> Unit, onOpenDay: (Int) -> Unit,
) {
    if (task.archived) item(key = "task-archived") {
        val on = store.archivedOn[task.id]?.let { if (it == today) "today" else DayWords.dayMonth(it) }
        CardNotice(Symbols.Archive, "Archived" + (on?.let { " $it" } ?: ""), "It’s off Today and Tasks, and keeps its history. Restore it to plan it again.",
            Modifier.pageItem(), action = "Restore", onAction = { store.restore(task) }, actionTag = "habit-archived-action", tag = "habit-archived")
    }
    if (done.isEmpty()) {
        val due = task.dueDay
        if (kind == RowKind.ONE_TIME && due != null && !task.archived) item(key = "task-planned") {
            CardNotice(Symbols.Event, "Planned for " + store.taskPlannedFor(task, today), "It shows on Today that day; tick it there.",
                Modifier.pageItem(), tag = "task-planned")
        }
        item(key = "task-nothing-done") {
            EmptyState(Symbols.TaskAlt, "Nothing done yet", "When it’s done, the day shows here, with any note.",
                Modifier.padding(top = 8.dp, bottom = 16.dp).semantics { testTag = "task-nothing-done" })
        }
        return
    }
    val groups: List<Triple<String, String?, List<Entry>>> =
        if (task.isOneTimeTask) listOf(Triple("Done", null, done))
        else done.groupBy { LocalDate.ofEpochDay(it.day.toLong()).year }.toSortedMap(compareByDescending { it })
            .map { (year, list) -> Triple("$year", if (list.size == 1) "Done once" else "Done ${list.size} times", list) }
    for ((title, summary, list) in groups) {
        val open = title !in folded
        val count = if (open) list.size + 1 else 1
        item(key = "task-group-$title") {
            AppListItem(title, 0, count,
                Modifier.pagePiece(0, count).semantics(mergeDescendants = true) { stateDescription = if (open) "Open" else "Folded" }, summary,
                trailing = { Icon(if (open) Symbols.ExpandLess else Symbols.ExpandMore, if (open) "Fold" else "Show", tint = MaterialTheme.colorScheme.onSurfaceVariant) },
                onClick = { onFold(title) }, containerColor = MaterialTheme.colorScheme.surfaceContainerLowest, tag = "task-group-$title")
        }
        if (open) list.forEachIndexed { i, e ->
            item(key = "task-done-" + e.id) {
                val note = store.note(task, e.day)?.takeIf { it.isNotBlank() }
                AppListItem(taskDay(e.day, today), i + 1, count, Modifier.pagePiece(i + 1, count).semantics(mergeDescendants = true) {},
                    "Done at " + DayWords.clock(e.createdAt),
                    leading = { Box(Modifier.size(40.dp), contentAlignment = Alignment.Center) { DayCell(HeatCell.level(4), task.color, size = DayCellSize.small) } },
                    below = note?.let { { ListNote(AnnotatedString(it)) } }, trailing = { ListChevron() },
                    onClick = { onOpenDay(e.day) }, containerColor = MaterialTheme.colorScheme.surfaceContainerLowest, tag = "task-event")
            }
        }
    }
}
