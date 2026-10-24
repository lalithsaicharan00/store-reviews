package com.oftenenough.app.ui.habit

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.combinedClickable
import androidx.compose.foundation.gestures.detectDragGesturesAfterLongPress
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
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyListScope
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowRight
import androidx.compose.material.icons.outlined.Archive
import androidx.compose.material.icons.outlined.CalendarMonth
import androidx.compose.material.icons.outlined.CheckBox
import androidx.compose.material.icons.outlined.CheckCircle
import androidx.compose.material.icons.outlined.ContentCopy
import androidx.compose.material.icons.outlined.Delete
import androidx.compose.material.icons.outlined.Edit
import androidx.compose.material.icons.outlined.EditCalendar
import androidx.compose.material.icons.outlined.EventBusy
import androidx.compose.material.icons.outlined.Today
import androidx.compose.material.icons.outlined.Undo
import androidx.compose.material.icons.rounded.Add
import androidx.compose.material.icons.rounded.Check
import androidx.compose.material.icons.rounded.Checklist
import androidx.compose.material.icons.rounded.Close
import androidx.compose.material.icons.rounded.Menu
import androidx.compose.material.icons.rounded.MoreVert
import androidx.compose.material.icons.rounded.Repeat
import androidx.compose.material.icons.rounded.Search
import androidx.compose.material.icons.rounded.SkipNext
import androidx.compose.material.icons.rounded.TaskAlt
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.PrimaryTabRow
import androidx.compose.material3.SnackbarDuration
import androidx.compose.material3.SnackbarHost
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.SnackbarResult
import androidx.compose.material3.Surface
import androidx.compose.material3.Tab
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableFloatStateOf
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.rememberUpdatedState
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.drawBehind
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.graphics.lerp
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.layout.onSizeChanged
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.stateDescription
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextDecoration
import androidx.compose.ui.unit.IntOffset
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.Popup
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.NO_DATE_DAY
import com.oftenenough.app.data.TaskRhythm
import com.oftenenough.app.data.archivedLine
import com.oftenenough.app.data.doneEntry
import com.oftenenough.app.data.isOneTimeTask
import com.oftenenough.app.data.isRepeatingTask
import com.oftenenough.app.data.isTask
import com.oftenenough.app.data.oneTimeLine
import com.oftenenough.app.data.repeatingLines
import com.oftenenough.app.data.taskDay
import com.oftenenough.app.data.taskHeading
import com.oftenenough.app.data.taskMoveRange
import com.oftenenough.app.data.taskOpenDay
import com.oftenenough.app.data.taskRhythm
import com.oftenenough.app.data.taskWhen
import com.oftenenough.app.ui.components.CookieIcon
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.ConnectedButtons
import com.oftenenough.app.ui.components.InkButton
import com.oftenenough.app.ui.components.segmentShape
import com.oftenenough.app.ui.newhabit.DayDialog
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch
import kotlin.math.roundToInt

/** Where the Tasks page goes. [openMenu] is null where the menu is a sidebar beside the page. */
interface TasksNav {
    val openMenu: (() -> Unit)?
    fun open(task: Habit)
    fun edit(task: Habit)
    fun duplicate(task: Habit)
    fun newTask(name: String? = null)
    fun completed()
    fun archived()
}


/** One section of a tab: its heading, an optional note, and its tasks. */
private class TaskSection(val key: String, val title: String, val tasks: List<Habit>, val note: String? = null, val drag: Boolean = false)

/** What a row's ⋮ offers, by the kind of row (Figma 3, 3.7, 3.8). */
private enum class RowKind { ONE_TIME, DONE, NO_DATE, REPEATING }

/**
 * ≡ › Tasks (Figma 2373:2): two tabs. **One-time** lists every one-time task by when (Today with the ones carried over
 * and the ones done today, struck, at its end; Tomorrow; the next days by name; later by month; No date last), then the
 * Archived row. **Repeating** lists every repeating task once, by how often it comes, with its next day and when it was
 * last done. Ticking happens on Today only. Each row's ⋮ edits, moves, duplicates, skips (repeating), archives or
 * deletes; a long press selects several (or drags a row within its day); every change says so with Undo, and a delete
 * waits for its Undo to go (D6). Completed tasks and Archived tasks are in the top bar's ⋮.
 */
@OptIn(ExperimentalMaterial3Api::class, ExperimentalFoundationApi::class)
@Composable
fun TasksTab(store: HabitStore, nav: TasksNav) {
    val c = appColors
    val scope = rememberCoroutineScope()
    val snackbar = remember { SnackbarHostState() }
    val today = store.today()
    var tab by rememberSaveable { mutableIntStateOf(0) }
    var hidden by remember { mutableStateOf(emptySet<String>()) }
    var deleting by remember { mutableStateOf<List<Habit>>(emptyList()) }
    var picking by remember { mutableStateOf<List<Habit>>(emptyList()) }
    val oneTimeList = rememberLazyListState()
    val repeatingList = rememberLazyListState()

    val all = store.habits.filter { it.isTask && it.id !in hidden }
    val open = all.filter { !it.archived }
    val archived = all.filter { it.archived }
    val oneTime = open.filter { it.isOneTimeTask }
    val repeating = open.filter { it.isRepeatingTask }
    val oneTimeSections = remember(all, today, store.dataVersion, store.skips, store.taskMoves) { oneTimeSections(store, oneTime, today) }
    val repeatingSections = remember(all, today, store.dataVersion, store.skips, store.taskMoves) { repeatingSections(repeating) }
    val sections = if (tab == 0) oneTimeSections else repeatingSections
    // The two pages at the end of the list (flows 20, 21): how many are finished, and how many are put away.
    // How many tasks have been finished, not how many times: a repeating task is one task, however often it was done.
    val completed = remember(all, store.dataVersion) {
        all.count { !it.archived && if (it.isOneTimeTask) store.doneEntry(it) != null else store.entries(it.id).isNotEmpty() }
    }

    fun say(text: String, action: String = "Undo", onAction: () -> Unit) {
        scope.launch {
            snackbar.currentSnackbarData?.dismiss()
            if (snackbar.showSnackbar(text, action, duration = SnackbarDuration.Short) == SnackbarResult.ActionPerformed) onAction()
        }
    }
    fun named(list: List<Habit>) = if (list.size == 1) list[0].name else "${list.size} tasks"
    /** Moves one-time tasks to [day] (null: No date) and a repeating task's open day to [day]; says where, with Undo. */
    fun move(list: List<Habit>, day: Int?) {
        val before = list.map { it to (store.taskMoves[it.id] ?: emptyMap()) }
        for (t in list) {
            if (t.isOneTimeTask) store.moveTask(t, day)
            else if (day != null) {
                val from = store.taskOpenDay(t, today)
                if (from != null && from != day && day in (store.taskMoveRange(t, today) ?: IntRange.EMPTY)) store.moveOccurrence(t, from, day)
            }
        }
        val where = when (day) { null -> "No date"; today -> "Today"; today + 1 -> "Tomorrow"; else -> taskDay(day) }
        val text = if (list.size == 1 && day == today) "${list[0].name} moved to Today" else if (list.size == 1) "Moved to $where" else "${list.size} tasks moved to $where"
        say(text) { for ((t, moves) in before) if (t.isOneTimeTask) store.update(t) else store.setTaskMoves(t, moves) }
    }
    fun archive(list: List<Habit>) {
        store.archive(list)
        say("${named(list)} archived") { list.forEach { store.restore(it) } }
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
        TaskMenuItems(t, kind, today, dismiss, onEdit = { nav.edit(t) }, onDuplicate = { nav.duplicate(t) }, onMove = { day -> move(listOf(t), day) },
            onPick = { picking = listOf(t) }, onSkip = { skip(t) }, onNotDone = { notDone(t) }, onArchive = { archive(listOf(t)) }, onDelete = { deleting = listOf(t) })
    }
    val onRow: (Habit) -> Unit = { t -> nav.open(t) }

    Box(Modifier.fillMaxSize().background(c.screen)) {
        Column(Modifier.fillMaxSize()) {
            Box(Modifier.weight(1f).fillMaxWidth()) {
                when {
                    all.isEmpty() -> Column(Modifier.fillMaxSize()) {
                        TaskKinds(tab) { tab = it }
                        EmptyTasks(Icons.Rounded.Checklist, "No tasks yet", "Every task you make lives here: for today, a later day, or no day at all.") {
                            InkButton("New task", { nav.newTask() }, Modifier.semantics { testTag = "tasks-empty-new" }, icon = Icons.Rounded.Add, height = 48.dp, textStyle = AppType.labelLarge)
                        }
                    }
                    tab == 1 && repeating.isEmpty() -> Column(Modifier.fillMaxSize()) {
                        TaskKinds(tab) { tab = it }
                        EmptyTasks(Icons.Rounded.Repeat, "No repeating tasks",
                            "Tasks that come back on their own show here, by how often they come. Choose Repeat when you add a task.") {}
                    }
                    else -> {
                        // Each tab keeps its own place in its list (Figma 1.1, 7.1).
                        val list = if (tab == 0) oneTimeList else repeatingList
                        LazyColumn(Modifier.fillMaxSize().padding(horizontal = 16.dp)
                            .semantics { testTag = if (tab == 0) "tasks-list" else "tasks-repeating-list" }, state = list) {
                            item(key = "kinds", contentType = "kinds") { TaskKinds(tab) { tab = it } }
                            for ((n, s) in sections.withIndex()) {
                                item(key = "title-${s.key}") {
                                    SectionTitle(s.title, n == 0)
                                    s.note?.let { Text(it, Modifier.padding(start = 16.dp, end = 16.dp, bottom = 12.dp), style = AppType.bodyMedium, color = c.secondary) }
                                }
                                s.tasks.forEachIndexed { i, t ->
                                    item(key = t.id) {
                                        val done = t.isOneTimeTask && store.doneEntry(t) != null
                                        val kind = when { t.isRepeatingTask -> RowKind.REPEATING; done -> RowKind.DONE; t.dueDay == NO_DATE_DAY -> RowKind.NO_DATE; else -> RowKind.ONE_TIME }
                                        val lines = if (t.isRepeatingTask) store.repeatingLines(t, today) else listOf(store.oneTimeLine(t, today)).filter { it.isNotEmpty() }
                                        TaskRow(t, lines, done, i, s.tasks.size, { onRow(t) },
                                            { task, dismiss -> rowMenu(task, kind, dismiss) },
                                            drag = if (s.drag && !done) s.tasks.filter { store.doneEntry(it) == null }.map { it.id } else null,
                                            onDrop = { ids -> store.reorder(ids) })
                                    }
                                }
                            }
                            if (completed > 0) item(key = "completed") {
                                Spacer(Modifier.height(22.dp))
                                EndRow("Completed", if (completed == 1) "1 task done" else "$completed tasks done", Icons.Rounded.TaskAlt, "tasks-completed") { nav.completed() }
                            }
                            if (archived.isNotEmpty()) item(key = "archived") {
                                Spacer(Modifier.height(if (completed > 0) 2.dp else 22.dp))
                                Box(Modifier.semantics { testTag = "tasks-archived" }) { ArchivedRow(archived.size, enabled = true, noun = "task") { nav.archived() } }
                            }
                            item(key = "end") { Spacer(Modifier.height(88.dp)) }
                        }
                    }
                }
            }
        }
        SnackbarHost(snackbar, Modifier.align(Alignment.BottomCenter).navigationBarsPadding().padding(4.dp))
    }

    if (picking.isNotEmpty()) {
        val list = picking
        // A repeating task's day moves only before its next one (Figma 3.2).
        val last = list.filter { it.isRepeatingTask }.mapNotNull { store.taskMoveRange(it, today)?.last }.minOrNull()
        DayDialog(today + 1, { it >= today && (last == null || it <= last) }, { picking = emptyList() }, title = "Select date") { day ->
            picking = emptyList(); move(list, day)
        }
    }
    if (deleting.isNotEmpty()) {
        val list = deleting
        val one = list.size == 1
        AlertDialog({ deleting = emptyList() },
            modifier = Modifier.semantics { testTagsAsResourceId = true },
            title = { Text(if (one) "Delete ${list[0].name}?" else "Delete ${list.size} tasks?") },
            text = {
                Text(when {
                    one && list[0].isRepeatingTask -> "Its history and notes go too, and every time it would come back. To keep them, archive it instead."
                    one -> "Its history and notes are deleted too. To keep them, archive it instead."
                    else -> "Their history and notes are deleted too. To keep them, archive them instead."
                })
            },
            confirmButton = { TextButton({ deleting = emptyList(); delete(list) }, Modifier.semantics { testTag = "delete-confirm" }) { Text("Delete", color = c.error) } },
            dismissButton = { TextButton({ deleting = emptyList() }, Modifier.semantics { testTag = "delete-cancel" }) { Text("Cancel", color = c.ink) } },
            containerColor = c.menu, titleContentColor = c.ink, textContentColor = c.secondary)
    }
}

/** One-time | Repeating (Habits & Tasks, `369:28`): the same connected buttons as Week · Month · Year. */
@Composable
private fun TaskKinds(tab: Int, onPick: (Int) -> Unit) =
    ConnectedButtons(listOf("One-time", "Repeating"), tab, "tasks-tab-",
        Modifier.fillMaxWidth().padding(top = 8.dp, bottom = 8.dp), onPick)

/** A row at the end of the list that opens a page of its own: Completed, beside Archived (flows 20, 21). */
@Composable
private fun EndRow(title: String, line: String, icon: androidx.compose.ui.graphics.vector.ImageVector, tag: String, onClick: () -> Unit) {
    val c = appColors
    Row(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.surface).clickable(onClick = onClick)
        .semantics(mergeDescendants = true) { testTag = tag }.heightIn(min = 72.dp).padding(start = 16.dp, end = 16.dp),
        verticalAlignment = Alignment.CenterVertically) {
        Box(Modifier.size(40.dp).clip(CircleShape).background(c.tonal), contentAlignment = Alignment.Center) {
            Icon(icon, null, Modifier.size(20.dp), tint = c.ink)
        }
        Spacer(Modifier.width(16.dp))
        Column(Modifier.weight(1f)) {
            Text(title, style = AppType.bodyLarge, color = c.ink)
            Text(line, style = AppType.bodyMedium, color = c.secondary)
        }
        Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = c.ink)
    }
}

/** One-time sections (Figma 1): Today (carried first, then today's, then the ones done today), the next days, the months, No date. */
private fun oneTimeSections(store: HabitStore, oneTime: List<Habit>, today: Int): List<TaskSection> {
    val open = oneTime.filter { store.doneEntry(it) == null }
    val doneToday = oneTime.mapNotNull { t -> store.doneEntry(t)?.takeIf { it.day == today }?.let { t to it } }.sortedBy { it.second.createdAt }.map { it.first }
    val out = mutableListOf<TaskSection>()
    val todays = open.filter { (it.dueDay ?: 0) < today }.sortedBy { it.dueDay } + open.filter { it.dueDay == today }
    if (todays.isNotEmpty() || doneToday.isNotEmpty()) out += TaskSection("today", "Today", todays + doneToday, drag = true)
    val later = open.filter { val d = it.dueDay ?: 0; d > today && d != NO_DATE_DAY }.sortedBy { it.dueDay }
    for ((heading, list) in later.groupBy { taskHeading(it.dueDay!!, today) }) out += TaskSection("d-" + heading.first, heading.first, list, drag = heading.second)
    val noDate = open.filter { it.dueDay == NO_DATE_DAY }
    if (noDate.isNotEmpty()) out += TaskSection("nodate", "No date", noDate, "They stay here and don't show on Today until you give them a day.", drag = true)
    return out
}

/** Repeating sections (Figma 7): by how often each comes, in the person's order within a group. */
private fun repeatingSections(repeating: List<Habit>): List<TaskSection> =
    TaskRhythm.entries.mapNotNull { r -> repeating.filter { taskRhythm(it.frequency) == r }.takeIf { it.isNotEmpty() }?.let { TaskSection("r-" + r.name, r.title, it) } }

/**
 * One task: its icon, name (struck through once done today), its lines and ⋮. With [drag] (its day's open tasks, in
 * order), touch and hold lifts it to move within its day; let go without moving and nothing happens (A68).
 */
@OptIn(ExperimentalFoundationApi::class)
@Composable
internal fun TaskRow(
    task: Habit, lines: List<String>, done: Boolean, index: Int, count: Int,
    onClick: () -> Unit, menu: (@Composable (Habit, () -> Unit) -> Unit)?,
    drag: List<String>? = null, onDrop: (List<String>) -> Unit = {},
) {
    val c = appColors
    val line = c.tonal
    var open by remember { mutableStateOf(false) }
    var dy by remember { mutableFloatStateOf(0f) }
    var lifted by remember { mutableStateOf(false) }
    var height by remember { mutableIntStateOf(1) }
    val order by rememberUpdatedState(drag)
    val drop by rememberUpdatedState(onDrop)
    val slop = with(LocalDensity.current) { 8.dp.toPx() }
    // The release that ends a hold isn't also a tap (it would open the task).
    var heldUntil by remember { mutableStateOf(0L) }
    val dragModifier = if (drag == null) Modifier else Modifier.pointerInput(task.id) {
        detectDragGesturesAfterLongPress(
            // The tap handler sees the release first: from the hold on, no tap until it's over.
            onDragStart = { heldUntil = Long.MAX_VALUE; lifted = true; dy = 0f },
            onDrag = { change, amount -> change.consume(); dy += amount.y },
            onDragEnd = {
                heldUntil = android.os.SystemClock.uptimeMillis() + 500
                val ids = order
                if (kotlin.math.abs(dy) >= slop && ids != null) {
                    val from = ids.indexOf(task.id)
                    val to = (from + (dy / height).roundToInt()).coerceIn(0, ids.size - 1)
                    if (from >= 0 && to != from) drop(ids.toMutableList().also { it.removeAt(from); it.add(to, task.id) })
                }
                lifted = false; dy = 0f
            },
            // The tap handler takes a release that hasn't moved, so a still hold ends here, not in onDragEnd.
            onDragCancel = {
                if (lifted) heldUntil = android.os.SystemClock.uptimeMillis() + 500
                lifted = false; dy = 0f
            },
        )
    }
    Box(Modifier.graphicsLayer { translationY = if (lifted) dy else 0f }.let { if (lifted) it.shadow(8.dp, segmentShape(index, count)) else it }) {
        Row(
            Modifier.fillMaxWidth().clip(segmentShape(index, count, outer = 16.dp, inner = 0.dp)).background(c.surface)
                // One card per day: a hairline between its rows, nothing under the last (305:616).
                .then(if (index == count - 1) Modifier else Modifier.drawBehind {
                    val h = 1.dp.toPx()
                    drawLine(line, Offset(0f, size.height - h), Offset(size.width, size.height - h), h)
                })
                .onSizeChanged { height = it.height.coerceAtLeast(1) }
                .then(dragModifier)
                .combinedClickable(onClick = { if (android.os.SystemClock.uptimeMillis() > heldUntil) onClick() }, role = Role.Button)
                .semantics(mergeDescendants = true) { testTag = "tasks-row-" + task.name }
                .heightIn(min = 72.dp).padding(start = 16.dp, end = 4.dp, top = 8.dp, bottom = 8.dp),
            verticalAlignment = Alignment.CenterVertically,
        ) {
            // Done today: the icon fades with the name, so the row reads as finished without shouting (305:641).
            Box(Modifier.alpha(if (done) 0.45f else 1f)) { HabitIcon(task.symbol, task.color) }
            Spacer(Modifier.width(16.dp))
            Column(Modifier.weight(1f).padding(end = if (menu == null) 12.dp else 0.dp)) {
                Text(task.name, style = AppType.bodyLarge.copy(textDecoration = if (done) TextDecoration.LineThrough else null),
                    color = if (done) c.secondary else c.ink)
                for (l in lines) Text(l, style = AppType.bodyMedium, color = c.secondary)
            }
            if (menu != null) Box {
                IconButton({ open = true }, Modifier.semantics { testTag = "tasks-row-more-" + task.name }) { Icon(Icons.Rounded.MoreVert, "More for ${task.name}", tint = c.ink) }
                DropdownMenu(open, { open = false }, containerColor = c.menu, shape = RoundedCornerShape(16.dp),
                    modifier = Modifier.semantics { testTagsAsResourceId = true }) { menu(task) { open = false } }
            }
        }
    }
}

/**
 * A row's ⋮ (Figma 3, 3.2, 3.7, 3.8). One-time: Edit task, Move to another day… (Tomorrow, Pick a day…, No date), Duplicate,
 * Archive, Delete. Repeating adds Skip this time. No date: Do today and Pick a day…. Done today: Mark as not done.
 */
@Composable
private fun TaskMenuItems(
    t: Habit, kind: RowKind, today: Int, dismiss: () -> Unit, onEdit: () -> Unit, onDuplicate: () -> Unit, onMove: (Int?) -> Unit,
    onPick: () -> Unit, onSkip: () -> Unit, onNotDone: () -> Unit, onArchive: () -> Unit, onDelete: () -> Unit,
) {
    val c = appColors
    MenuItem("Edit task", Icons.Outlined.Edit, "tasks-menu-edit") { dismiss(); onEdit() }
    when (kind) {
        RowKind.NO_DATE -> {
            MenuItem("Do today", Icons.Outlined.Today, "tasks-menu-today") { dismiss(); onMove(today) }
            MenuItem("Pick a day…", Icons.Outlined.CalendarMonth, "tasks-menu-pick") { dismiss(); onPick() }
        }
        RowKind.DONE -> MenuItem("Mark as not done", Icons.Outlined.Undo, "tasks-menu-not-done") { dismiss(); onNotDone() }
        // A repeating task's turn is skipped, not moved (flow 25); a one-time task's picker opens straight away (flow 22).
        RowKind.REPEATING -> MenuItem("Skip this time", Icons.Rounded.SkipNext, "tasks-menu-skip") { dismiss(); onSkip() }
        else -> MenuItem("Move to another day…", Icons.Outlined.EditCalendar, "tasks-menu-move") { dismiss(); onPick() }
    }
    MenuItem("Duplicate", Icons.Outlined.ContentCopy, "tasks-menu-duplicate") { dismiss(); onDuplicate() }
    HorizontalDivider(color = c.tonal)
    MenuItem("Archive", Icons.Outlined.Archive, "tasks-menu-archive") { dismiss(); onArchive() }
    MenuItem("Delete", Icons.Outlined.Delete, "tasks-menu-delete", danger = true) { dismiss(); onDelete() }
}

/** One task's line in the page's search (flows 14, 31): its day, No date, Done or Archived. */
internal fun taskSearchLine(store: HabitStore, t: Habit, today: Int): String = when {
    t.archived -> store.archivedLine(t)
    t.isOneTimeTask && store.doneEntry(t) != null -> "Done " + taskDay(store.doneEntry(t)!!.day)
    t.isRepeatingTask -> store.repeatingLines(t, today).first()
    t.dueDay == NO_DATE_DAY -> "No date"
    (t.dueDay ?: today) < today -> "Today · planned " + taskDay(t.dueDay!!).substringAfter(' ')
    t.dueDay == today -> "Today · " + store.taskWhen(t)
    else -> taskDay(t.dueDay!!) + store.taskWhen(t).let { if (it == "Anytime") "" else " · $it" }
}

/** An empty tab (Figma 1.3, 7.2): its icon in a cookie, what goes here, and how to start. */
@Composable
private fun EmptyTasks(icon: androidx.compose.ui.graphics.vector.ImageVector, title: String, body: String, action: @Composable () -> Unit) {
    val c = appColors
    Column(Modifier.fillMaxSize().padding(horizontal = 32.dp).semantics { testTag = "tasks-empty" }, horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center) {
        CookieIcon(icon, 112.dp)
        Spacer(Modifier.height(24.dp))
        Text(title, style = AppType.titleLarge, color = c.ink, textAlign = TextAlign.Center)
        Spacer(Modifier.height(12.dp))
        Text(body, style = AppType.bodyLarge, color = c.secondary, textAlign = TextAlign.Center)
        Spacer(Modifier.height(24.dp))
        action()
        Spacer(Modifier.height(64.dp))
    }
}
