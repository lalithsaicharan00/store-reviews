package com.oftenenough.app.ui.habit

import com.oftenenough.app.ui.components.EmptyState
import androidx.compose.ui.semantics.heading
import com.oftenenough.app.ui.components.AppDialog
import com.oftenenough.app.ui.components.AppSnackbarHost
import com.oftenenough.app.ui.components.AppMenu
import com.oftenenough.app.ui.components.AppMenuItem
import androidx.compose.material3.MaterialTheme
import com.oftenenough.app.ui.components.SegmentedListGap
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.AppConnectedButtons
import com.oftenenough.app.ui.components.StandardIconButton
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
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
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.SnackbarDuration
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.SnackbarResult
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.NO_DATE_DAY
import com.oftenenough.app.data.TaskRhythm
import com.oftenenough.app.data.doneEntry
import com.oftenenough.app.data.isOneTimeTask
import com.oftenenough.app.data.isRepeatingTask
import com.oftenenough.app.data.isTask
import com.oftenenough.app.data.oneTimeLine
import com.oftenenough.app.data.repeatingLine
import com.oftenenough.app.data.taskDay
import com.oftenenough.app.data.taskHeading
import com.oftenenough.app.data.taskMoveRange
import com.oftenenough.app.data.taskOpenDay
import com.oftenenough.app.data.taskRhythm
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.components.ListChevron
import com.oftenenough.app.ui.components.segmentShape
import com.oftenenough.app.ui.newhabit.DayDialog
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch

/** Where the Tasks tab goes. */
interface TasksNav {
    fun open(task: Habit)
    fun edit(task: Habit)
    fun duplicate(task: Habit)
    fun newTask(name: String? = null)
    fun completed()
    fun archived()
    /** A task moved to today: the snackbar's Show, which opens Today. */
    fun showToday()
}

/** One section of a tab: its heading, an optional note, and its tasks. */
private class TaskSection(val key: String, val title: String, val tasks: List<Habit>, val note: String? = null)

/** What a row's ⋮ offers, by the kind of row. */
internal enum class RowKind { ONE_TIME, DONE, NO_DATE, REPEATING }

/**
 * 5.5.4, **Tasks page** (Figma 999:1061; Components — Atoms Build Plan; A55, A57, A58): Habits & Tasks' Tasks tab,
 * under the page's top bar, tabs and search. The list, 16 in, 16 above and 80 under, 12 between its parts: One-time ·
 * Repeating (the Connected button group, scrolling away, A57); then the sections, each title in Label Large Primary, 16
 * in (No date's with its note in Body Small On surface variant, 2 under), over one rounded list of two-line List items 2
 * apart on Surface container lowest: the task's icon in its colour, its name in Title Medium (On surface variant once
 * done), its line in Body Medium On surface variant ("Planned for Wed, 21 Oct", "5:00 PM · Evening", "Done 9:12 AM",
 * "No date"; a repeating one's "Every 3 days · Next 25 Oct" or "Done today"), and ⋮. **One-time**: Today (carried
 * over first, then today's, then the ones done today), Tomorrow, the next days by name, later by month, No date.
 * **Repeating**: by how often each comes. At the end of both, Completed ("6 tasks done") and Archived. A row opens its
 * Task details; ticking happens on Today only. Its ⋮: Edit task; Move to another day… (the date picker at once, A58),
 * Skip this time for a repeating one, Do today and Pick a day… for one with No date, Mark as not done for one done
 * today; Duplicate; Archive; Delete (asks, Cancel | Delete). Moving to today says so with Show (Today); every other
 * change says so with Undo, and a delete waits for its Undo to go (D6). No selecting several, and a still hold does
 * nothing (A55). Nothing to show: the Empty state with New task.
 */
@OptIn(ExperimentalMaterial3Api::class, ExperimentalFoundationApi::class)
@Composable
fun TasksPage(store: HabitStore, nav: TasksNav) {
    val s = MaterialTheme.colorScheme
    val scope = rememberCoroutineScope()
    val snackbar = remember { SnackbarHostState() }
    val today = store.today()
    var tab by rememberSaveable { mutableIntStateOf(0) }
    var hidden by remember { mutableStateOf(emptySet<String>()) }
    var deleting by remember { mutableStateOf<Habit?>(null) }
    var picking by remember { mutableStateOf<Habit?>(null) }
    val oneTimeList = rememberLazyListState()
    val repeatingList = rememberLazyListState()

    // A task deleted from its Task details stays away while the snackbar there offers Undo.
    val all = store.habits.filter { it.isTask && it.id !in hidden && it.id !in PendingDelete.ids }
    val open = all.filter { !it.archived }
    val archived = all.filter { it.archived }
    val oneTime = open.filter { it.isOneTimeTask }
    val repeating = open.filter { it.isRepeatingTask }
    val oneTimeSections = remember(all, today, store.dataVersion, store.skips, store.taskMoves) { oneTimeSections(store, oneTime, today) }
    val repeatingSections = remember(all, today, store.dataVersion, store.skips, store.taskMoves) { repeatingSections(repeating) }
    val sections = if (tab == 0) oneTimeSections else repeatingSections
    // What Completed lists: each one-time task done, and each time a repeating one was done.
    val completed = remember(all, store.dataVersion) { open.sumOf { t -> if (t.isOneTimeTask) (if (store.doneEntry(t) != null) 1 else 0) else store.entries(t.id).size } }

    fun say(text: String, action: String = "Undo", onAction: () -> Unit) {
        scope.launch {
            snackbar.currentSnackbarData?.dismiss()
            if (snackbar.showSnackbar(text, action, duration = SnackbarDuration.Short) == SnackbarResult.ActionPerformed) onAction()
        }
    }
    /** Moves a one-time task to [day] (null: No date) and a repeating task's open day to [day]; says where. */
    fun move(t: Habit, day: Int?) {
        val moves = store.taskMoves[t.id] ?: emptyMap()
        if (t.isOneTimeTask) store.moveTask(t, day)
        else if (day != null) {
            val from = store.taskOpenDay(t, today)
            if (from != null && from != day && day in (store.taskMoveRange(t, today) ?: IntRange.EMPTY)) store.moveOccurrence(t, from, day)
        }
        // On Today now (Figma's Moved to Today): Show goes there. Elsewhere it says where, with Undo.
        if (day == today) say("${t.name} is on Today", "Show") { nav.showToday() }
        else {
            val where = when (day) { null -> "No date"; today + 1 -> "Tomorrow"; else -> taskDay(day) }
            say("Moved to $where") { if (t.isOneTimeTask) store.update(t) else store.setTaskMoves(t, moves) }
        }
    }
    fun archive(t: Habit) {
        store.archive(listOf(t))
        say("${t.name} archived") { store.restore(t) }
    }
    fun delete(t: Habit) {
        hidden = hidden + t.id
        scope.launch {
            snackbar.currentSnackbarData?.dismiss()
            var undone = false
            try {
                undone = snackbar.showSnackbar("${t.name} deleted", "Undo", duration = SnackbarDuration.Short) == SnackbarResult.ActionPerformed
            } finally {
                if (!undone) store.habit(t.id)?.let { store.delete(listOf(it)) }
                hidden = hidden - t.id
            }
        }
    }
    fun skip(t: Habit) {
        val day = store.taskOpenDay(t, today) ?: return
        store.setSkipped(t, day, true)
        say("${t.name} skipped this time") { store.setSkipped(t, day, false) }
    }
    fun notDone(t: Habit) {
        val e = store.doneEntry(t) ?: return
        store.undoEntry(e.id)
        say("${t.name} is back in Today") { store.putBack(e) }
    }

    val rowMenu: @Composable (Habit, RowKind, () -> Unit) -> Unit = { t, kind, dismiss ->
        TaskMenuItems(kind, dismiss, onEdit = { nav.edit(t) }, onDuplicate = { nav.duplicate(t) }, onToday = { move(t, today) },
            onPick = { picking = t }, onSkip = { skip(t) }, onNotDone = { notDone(t) }, onArchive = { archive(t) }, onDelete = { deleting = t })
    }

    // One-time · Repeating: a connected button group at the top of the list, scrolling away with it (A57), never pinned
    // tabs. The empty states keep it, so the other kind is one tap away.
    val kinds: @Composable (Modifier) -> Unit = { m ->
        AppConnectedButtons(listOf(0 to "One-time", 1 to "Repeating"), tab, m, tag = "tasks-tab") { tab = it }
    }
    Box(Modifier.fillMaxSize().background(s.surfaceContainer)) {
        when {
            all.isEmpty() -> EmptyTasks(kinds, "No tasks yet", "Tasks you add show here by their day, and on Today when it comes.") { nav.newTask() }
            tab == 1 && repeating.isEmpty() -> EmptyTasks(kinds, "No repeating tasks",
                "A task that comes back, like watering the plants every 3 days, shows here. Choose Repeat when you add it.") { nav.newTask() }
            else -> {
                // Each tab keeps its own place in its list.
                val list = if (tab == 0) oneTimeList else repeatingList
                LazyColumn(Modifier.fillMaxSize().padding(horizontal = 16.dp).semantics { testTag = if (tab == 0) "tasks-list" else "tasks-repeating-list" },
                    state = list) {
                    item(key = "kinds") { kinds(Modifier.padding(top = 16.dp)) }
                    for ((n, sec) in sections.withIndex()) {
                        item(key = "title-${sec.key}") { TaskSectionTitle(sec.title, sec.note, first = n == 0) }
                        sec.tasks.forEachIndexed { i, t ->
                            item(key = t.id) {
                                val done = t.isOneTimeTask && store.doneEntry(t) != null
                                val kind = when { t.isRepeatingTask -> RowKind.REPEATING; done -> RowKind.DONE; t.dueDay == NO_DATE_DAY -> RowKind.NO_DATE; else -> RowKind.ONE_TIME }
                                val line = if (t.isRepeatingTask) store.repeatingLine(t, today)
                                    else store.oneTimeLine(t, today).ifEmpty { if (t.dueDay == NO_DATE_DAY) "No date" else "" }
                                TaskRow(t, listOf(line).filter { it.isNotEmpty() }, done, i, sec.tasks.size, { nav.open(t) },
                                    { task, dismiss -> rowMenu(task, kind, dismiss) })
                            }
                        }
                    }
                    // Completed and Archived, at the end of both kinds (Figma's End of the list): 20 under the last task, 12 apart.
                    if (completed > 0) item(key = "completed") {
                        AppListItem("Completed", 0, 1, Modifier.padding(top = 18.dp),
                            if (completed == 1) "1 task done" else "$completed tasks done",
                            leading = { Icon(Symbols.TaskAlt, null) }, trailing = { ListChevron() },
                            onClick = { nav.completed() }, containerColor = s.surfaceContainerLowest, tag = "tasks-completed")
                    }
                    if (archived.isNotEmpty()) item(key = "archived") {
                        Box(Modifier.padding(top = if (completed > 0) 12.dp else 18.dp).semantics { testTag = "tasks-archived" }) {
                            ArchivedRow(archived.size, enabled = true, noun = "task") { nav.archived() }
                        }
                    }
                    item(key = "end") { Spacer(Modifier.navigationBarsPadding().height(80.dp)) }
                }
            }
        }
        AppSnackbarHost(snackbar, Modifier.align(Alignment.BottomCenter).navigationBarsPadding().padding(4.dp))
    }

    picking?.let { t ->
        // A repeating task's day moves only before its next one; a one-time task to any day from today (A58).
        val last = if (t.isRepeatingTask) store.taskMoveRange(t, today)?.last else null
        DayDialog(maxOf(today, t.dueDay?.takeIf { it != NO_DATE_DAY } ?: today), { it >= today && (last == null || it <= last) },
            { picking = null }, title = "Select date") { day ->
            picking = null; move(t, day)
        }
    }
    deleting?.let { t ->
        AppDialog("Delete ${t.name}?", "Its history and notes are deleted too. To keep them, archive it instead.",
            "Delete", { deleting = null; delete(t) }, { deleting = null }, destructive = true, confirmTag = "delete-confirm", dismissTag = "delete-cancel")
    }
}

/**
 * A section's title (Figma's Section): Label Large Primary, 16 in; 20 under what comes before it and 12 over its list;
 * [note] (No date's) in Body Small On surface variant, 2 under it.
 */
@Composable
private fun TaskSectionTitle(title: String, note: String?, first: Boolean) {
    val s = MaterialTheme.colorScheme
    Column(Modifier.fillMaxWidth().padding(start = 16.dp, end = 16.dp, top = if (first) 20.dp else 18.dp, bottom = 12.dp)
        .semantics(mergeDescendants = true) { heading(); testTag = "habits-section-$title" }, verticalArrangement = Arrangement.spacedBy(2.dp)) {
        Text(title, style = AppType.labelLarge, color = s.primary)
        note?.let { Text(it, style = AppType.bodySmall, color = s.onSurfaceVariant) }
    }
}

/** One-time sections (Figma 1): Today (carried first, then today's, then the ones done today), the next days, the months, No date. */
private fun oneTimeSections(store: HabitStore, oneTime: List<Habit>, today: Int): List<TaskSection> {
    val open = oneTime.filter { store.doneEntry(it) == null }
    val doneToday = oneTime.mapNotNull { t -> store.doneEntry(t)?.takeIf { it.day == today }?.let { t to it } }.sortedBy { it.second.createdAt }.map { it.first }
    val out = mutableListOf<TaskSection>()
    val todays = open.filter { (it.dueDay ?: 0) < today }.sortedBy { it.dueDay } + open.filter { it.dueDay == today }
    if (todays.isNotEmpty() || doneToday.isNotEmpty()) out += TaskSection("today", "Today", todays + doneToday)
    val later = open.filter { val d = it.dueDay ?: 0; d > today && d != NO_DATE_DAY }.sortedBy { it.dueDay }
    for ((heading, list) in later.groupBy { taskHeading(it.dueDay!!, today) }) out += TaskSection("d-" + heading.first, heading.first, list)
    val noDate = open.filter { it.dueDay == NO_DATE_DAY }
    if (noDate.isNotEmpty()) out += TaskSection("nodate", "No date", noDate, "They stay here and don't show on Today until you give them a day.")
    return out
}

/** Repeating sections (Figma 7): by how often each comes, in the person's order within a group. */
private fun repeatingSections(repeating: List<Habit>): List<TaskSection> =
    TaskRhythm.entries.mapNotNull { r -> repeating.filter { taskRhythm(it.frequency) == r }.takeIf { it.isNotEmpty() }?.let { TaskSection("r-" + r.name, r.title, it) } }

/**
 * One task (Figma's task row, 5.5.4): its icon in its colour, its name in Title Medium (On surface variant once done),
 * its lines in Body Medium On surface variant, and ⋮. It looks like the List item atom (2.4: Surface container lowest,
 * its corners). A tap opens the task; a hold does nothing (A55), and there's no drag to reorder (Figma has none; cleanup
 * 6.9): the order is each task's day.
 */
@Composable
internal fun TaskRow(
    task: Habit, lines: List<String>, done: Boolean, index: Int, count: Int,
    onClick: () -> Unit, menu: (@Composable (Habit, () -> Unit) -> Unit)?,
) {
    val c = appColors
    var open by remember { mutableStateOf(false) }
    Box {
        Row(
            Modifier.padding(bottom = SegmentedListGap).fillMaxWidth().clip(segmentShape(index, count)).background(MaterialTheme.colorScheme.surfaceContainerLowest)
                .clickable(role = Role.Button, onClick = onClick)
                .semantics(mergeDescendants = true) { testTag = "tasks-row-" + task.name }
                .heightIn(min = 72.dp).padding(start = 16.dp, end = 4.dp, top = 8.dp, bottom = 8.dp),
            verticalAlignment = Alignment.CenterVertically,
        ) {
            HabitIcon(task.symbol, task.color)
            Spacer(Modifier.width(16.dp))
            Column(Modifier.weight(1f).padding(end = if (menu == null) 12.dp else 0.dp)) {
                Text(task.name, style = AppType.titleMedium, color = if (done) c.secondary else c.ink)
                for (l in lines) Text(l, style = AppType.bodyMedium, color = c.secondary)
            }
            if (menu != null) Box {
                StandardIconButton(Symbols.MoreVert, "More for ${task.name}", { open = true }, Modifier.semantics { testTag = "tasks-row-more-" + task.name })
                AppMenu(open, { open = false }, modifier = Modifier.semantics { testTagsAsResourceId = true }) { menu(task) { open = false } }
            }
        }
    }
}

/**
 * A row's ⋮ (README, 23 Oct; Figma's Menu open): Edit task; then Move to another day… (the date picker at once, A58),
 * Skip this time for a repeating task, Do today and Pick a day… for one with No date, or Mark as not done for one done
 * today; then Duplicate, Archive and Delete (Error).
 */
@Composable
internal fun TaskMenuItems(
    kind: RowKind, dismiss: () -> Unit, onEdit: () -> Unit, onDuplicate: () -> Unit, onToday: () -> Unit,
    onPick: () -> Unit, onSkip: () -> Unit, onNotDone: () -> Unit, onArchive: () -> Unit, onDelete: () -> Unit,
) {
    AppMenuItem("Edit task", { dismiss(); onEdit() }, icon = Symbols.Edit, tag = "tasks-menu-edit")
    when (kind) {
        RowKind.NO_DATE -> {
            AppMenuItem("Do today", { dismiss(); onToday() }, icon = Symbols.Today, tag = "tasks-menu-today")
            AppMenuItem("Pick a day…", { dismiss(); onPick() }, icon = Symbols.Event, tag = "tasks-menu-pick")
        }
        RowKind.DONE -> AppMenuItem("Mark as not done", { dismiss(); onNotDone() }, icon = Symbols.Undo, tag = "tasks-menu-not-done")
        RowKind.REPEATING -> AppMenuItem("Skip this time", { dismiss(); onSkip() }, icon = Symbols.Redo, tag = "tasks-menu-skip")
        RowKind.ONE_TIME -> AppMenuItem("Move to another day…", { dismiss(); onPick() }, icon = Symbols.Event, tag = "tasks-menu-move")
    }
    AppMenuItem("Duplicate", { dismiss(); onDuplicate() }, icon = Symbols.ContentCopy, tag = "tasks-menu-duplicate")
    AppMenuItem("Archive", { dismiss(); onArchive() }, icon = Symbols.Archive, tag = "tasks-menu-archive")
    AppMenuItem("Delete", { dismiss(); onDelete() }, icon = Symbols.Delete, destructive = true, tag = "tasks-menu-delete")
}

/**
 * A tab with nothing to show (Figma's No tasks yet, No repeating tasks): [kinds] still at the top (16 in, 16 above, 8
 * under), then centred in the rest the Empty state (5.1.2: task_alt in its cookie, [title], [body]) with New task.
 */
@Composable
private fun EmptyTasks(kinds: @Composable (Modifier) -> Unit, title: String, body: String, onNew: () -> Unit) {
    Column(Modifier.fillMaxSize()) {
        kinds(Modifier.padding(start = 16.dp, end = 16.dp, top = 16.dp, bottom = 8.dp))
        Box(Modifier.weight(1f).fillMaxWidth(), contentAlignment = Alignment.Center) {
            EmptyState(Symbols.TaskAlt, title, body, Modifier.semantics { testTag = "tasks-empty" }) {
                AppButton("New task", onNew, Modifier.semantics { testTag = "tasks-empty-new" }, icon = Symbols.Add)
            }
        }
    }
}
