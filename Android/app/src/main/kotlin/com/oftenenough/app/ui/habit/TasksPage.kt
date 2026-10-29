package com.oftenenough.app.ui.habit

import com.oftenenough.app.ui.components.AppDialog
import com.oftenenough.app.ui.components.AppSnackbarHost
import com.oftenenough.app.ui.components.AppMenu
import com.oftenenough.app.ui.components.AppMenuItem
import androidx.compose.material3.MaterialTheme
import com.oftenenough.app.ui.components.SegmentedListGap
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.MenuDivider
import com.oftenenough.app.ui.components.SearchHeader
import com.oftenenough.app.ui.components.AppConnectedButtons
import com.oftenenough.app.ui.components.scrolledTopBarColor
import com.oftenenough.app.ui.components.AppTopBar
import com.oftenenough.app.ui.components.StandardIconButton
import androidx.activity.compose.BackHandler
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
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
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.SnackbarDuration
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.SnackbarResult
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
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
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.shadow
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

private const val TASKS_COACH_SEEN = "tasks.coach_seen"

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
fun TasksPage(store: HabitStore, nav: TasksNav) {
    val c = appColors
    val scope = rememberCoroutineScope()
    val snackbar = remember { SnackbarHostState() }
    val today = store.today()
    var tab by rememberSaveable { mutableIntStateOf(0) }
    var selecting by rememberSaveable { mutableStateOf(false) }
    var chosen by rememberSaveable { mutableStateOf(emptySet<String>()) }
    var searching by rememberSaveable { mutableStateOf(false) }
    var query by rememberSaveable { mutableStateOf("") }
    var hidden by remember { mutableStateOf(emptySet<String>()) }
    var coachSeen by remember { mutableStateOf(store.setting(TASKS_COACH_SEEN) != null) }
    var topMenu by remember { mutableStateOf(false) }
    var deleting by remember { mutableStateOf<List<Habit>>(emptyList()) }
    var picking by remember { mutableStateOf<List<Habit>>(emptyList()) }
    var barMove by remember { mutableStateOf(false) }
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
    val marked = all.filter { it.id in chosen }

    fun endSelection() { selecting = false; chosen = emptySet() }
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
    fun toggle(t: Habit) { chosen = if (t.id in chosen) chosen - t.id else chosen + t.id }
    fun seeCoach() { if (!coachSeen) { coachSeen = true; store.saveAppSetting(TASKS_COACH_SEEN, "1") } }

    BackHandler(enabled = selecting || searching) { if (selecting) endSelection() else { searching = false; query = "" } }

    val rowMenu: @Composable (Habit, RowKind, () -> Unit) -> Unit = { t, kind, dismiss ->
        TaskMenuItems(t, kind, today, dismiss, onEdit = { nav.edit(t) }, onDuplicate = { nav.duplicate(t) }, onMove = { day -> move(listOf(t), day) },
            onPick = { picking = listOf(t) }, onSkip = { skip(t) }, onNotDone = { notDone(t) }, onArchive = { archive(listOf(t)) }, onDelete = { deleting = listOf(t) })
    }
    val onRow: (Habit) -> Unit = { t -> if (selecting) toggle(t) else nav.open(t) }
    val onLong: (Habit) -> Unit = { t -> seeCoach(); if (!selecting) { selecting = true; chosen = setOf(t.id) } else toggle(t) }

    val scroll = TopAppBarDefaults.pinnedScrollBehavior()
    val barColor = if (selecting) c.tonal else lerp(c.screen, scrolledTopBarColor, scroll.state.overlappedFraction.coerceIn(0f, 1f))
    Box(Modifier.fillMaxSize().background(c.screen)) {
        Column(Modifier.fillMaxSize()) {
            if (searching) SearchHeader(query, { query = it.take(40) }, onBack = { searching = false; query = "" }, "Search tasks",
                fieldTag = "habits-search-field", backTag = "habits-search-back", clearTag = "habits-search-clear")
            else {
                if (selecting) AppTopBar(
                    if (chosen.isEmpty()) "Select tasks" else "${chosen.size} selected",
                    navigationIcon = { IconButton(::endSelection, Modifier.semantics { testTag = "tasks-end-selection" }) { Icon(Symbols.Close, "Stop selecting") } },
                    actions = {
                        val ids = (if (tab == 0) oneTime else repeating).map { it.id }.toSet()
                        val everything = ids.isNotEmpty() && chosen.containsAll(ids)
                        AppButton(if (everything) "Deselect all" else "Select all", { chosen = if (everything) emptySet() else ids }, Modifier.padding(end = 4.dp).semantics { testTag = "tasks-select-all" }, style = ButtonStyle.Text)
                    },
                    containerColor = barColor,
                ) else AppTopBar(
                    "Tasks",
                    navigationIcon = { nav.openMenu?.let { o -> IconButton(o, Modifier.semantics { testTag = "tasks-menu" }) { Icon(Symbols.Menu, "Menu") } } },
                    actions = {
                        IconButton({ searching = true }, Modifier.semantics { testTag = "tasks-search" }) { Icon(Symbols.Search, "Search tasks") }
                        IconButton({ nav.newTask() }, Modifier.semantics { testTag = "tasks-add" }) { Icon(Symbols.Add, "New task") }
                        Box {
                            IconButton({ topMenu = true }, Modifier.semantics { testTag = "tasks-more" }) { Icon(Symbols.MoreVert, "More") }
                            AppMenu(topMenu, { topMenu = false }, modifier = Modifier.semantics { testTagsAsResourceId = true }) {
                                AppMenuItem("Select", { topMenu = false; seeCoach(); selecting = true; chosen = emptySet() }, icon = Symbols.CheckBox, tag = "tasks-select")
                                AppMenuItem("Completed tasks", { topMenu = false; nav.completed() }, icon = Symbols.CheckCircle, tag = "tasks-completed")
                                AppMenuItem("Archived tasks", { topMenu = false; nav.archived() }, icon = Symbols.Archive, tag = "tasks-archived-menu")
                            }
                        }
                    },
                    containerColor = barColor,
                )
            }
            // One-time · Repeating: a connected button group at the top of the list, scrolling away with it (A57, Figma
            // List, Group wrap), never pinned tabs. The empty states keep it, so the other kind is one tap away.
            val kinds: @Composable (Modifier) -> Unit = { m ->
                AppConnectedButtons(listOf(0 to "One-time", 1 to "Repeating"), tab, m, tag = "tasks-tab") { tab = it; chosen = emptySet() }
            }
            Box(Modifier.weight(1f).fillMaxWidth()) {
                when {
                    // Results open (Figma 5.1); selecting several is the list's, not the search's.
                    searching -> TaskSearch(store, query, open, archived, today, onRow, {}, rowMenu) { nav.newTask(query.trim()) }
                    all.isEmpty() -> Column {
                        kinds(Modifier.padding(start = 16.dp, end = 16.dp, top = 16.dp, bottom = 8.dp))
                        EmptyTasks(Symbols.Checklist, "No tasks yet", "Every task you make lives here: for today, a later day, or no day at all.") {
                            AppButton("New task", { nav.newTask() }, Modifier.semantics { testTag = "tasks-empty-new" }, icon = Symbols.Add)
                        }
                    }
                    tab == 1 && repeating.isEmpty() -> Column {
                        kinds(Modifier.padding(start = 16.dp, end = 16.dp, top = 16.dp, bottom = 8.dp))
                        EmptyTasks(Symbols.Repeat, "No repeating tasks",
                            "Tasks that come back on their own show here, by how often they come. Choose Repeat when you add a task.") {}
                    }
                    else -> {
                        // Each tab keeps its own place in its list (Figma 1.1, 7.1).
                        val list = if (tab == 0) oneTimeList else repeatingList
                        LazyColumn(Modifier.fillMaxSize().nestedScroll(scroll.nestedScrollConnection).padding(horizontal = 16.dp)
                            .semantics { testTag = if (tab == 0) "tasks-list" else "tasks-repeating-list" }, state = list) {
                            item(key = "kinds") { kinds(Modifier.padding(top = 16.dp, bottom = 4.dp)) }
                            var first = true
                            for ((n, s) in sections.withIndex()) {
                                item(key = "title-${s.key}") {
                                    SectionTitle(s.title, n == 0)
                                    s.note?.let { Text(it, Modifier.padding(start = 16.dp, end = 16.dp, bottom = 12.dp), style = AppType.bodyMedium, color = c.secondary) }
                                }
                                s.tasks.forEachIndexed { i, t ->
                                    val coach = first && !coachSeen && !selecting && open.size >= 2
                                    first = false
                                    item(key = t.id) {
                                        val done = t.isOneTimeTask && store.doneEntry(t) != null
                                        val kind = when { t.isRepeatingTask -> RowKind.REPEATING; done -> RowKind.DONE; t.dueDay == NO_DATE_DAY -> RowKind.NO_DATE; else -> RowKind.ONE_TIME }
                                        val lines = if (t.isRepeatingTask) store.repeatingLines(t, today) else listOf(store.oneTimeLine(t, today)).filter { it.isNotEmpty() }
                                        TaskRow(t, lines, done, i, s.tasks.size, selecting, t.id in chosen, { onRow(t) }, { onLong(t) },
                                            if (selecting) null else { task, dismiss -> rowMenu(task, kind, dismiss) },
                                            coach = if (coach) ({ seeCoach() }) else null,
                                            drag = if (s.drag && !done && !selecting) s.tasks.filter { store.doneEntry(it) == null }.map { it.id } else null,
                                            onDrop = { ids -> store.reorder(ids) })
                                    }
                                }
                            }
                            if (tab == 0 && archived.isNotEmpty()) item(key = "archived") {
                                Spacer(Modifier.height(22.dp))
                                Box(Modifier.semantics { testTag = "tasks-archived" }) { ArchivedRow(archived.size, enabled = !selecting, noun = "task") { nav.archived() } }
                            }
                            item(key = "end") { Spacer(Modifier.height(if (selecting) 120.dp else 88.dp)) }
                        }
                    }
                }
            }
            if (selecting) Surface(color = c.surface, tonalElevation = 3.dp) {
                Row(Modifier.fillMaxWidth().navigationBarsPadding().padding(horizontal = 8.dp, vertical = 8.dp), horizontalArrangement = Arrangement.SpaceEvenly) {
                    val any = marked.isNotEmpty()
                    Box {
                        BarAction("Move", Symbols.EditCalendar, any, "tasks-move", { barMove = true })
                        AppMenu(barMove, { barMove = false }, modifier = Modifier.semantics { testTagsAsResourceId = true }) {
                            AppMenuItem("Tomorrow · " + taskDay(today + 1), {
                                barMove = false; move(marked, today + 1); endSelection()
                            }, icon = Symbols.CalendarMonth, tag = "tasks-move-tomorrow")
                            AppMenuItem("Pick a day…", { barMove = false; picking = marked }, icon = Symbols.Event, tag = "tasks-move-pick")
                            if (marked.all { it.isOneTimeTask }) AppMenuItem("No date", { barMove = false; move(marked, null); endSelection() }, icon = Symbols.EventBusy, tag = "tasks-move-none")
                        }
                    }
                    BarAction("Archive", Symbols.Archive, any, "tasks-archive", { archive(marked); endSelection() })
                    BarAction("Delete", Symbols.Delete, any, "tasks-delete", { deleting = marked }, danger = true)
                }
            }
        }
        AppSnackbarHost(snackbar, Modifier.align(Alignment.BottomCenter).navigationBarsPadding().padding(4.dp).padding(bottom = if (selecting) 88.dp else 0.dp))
    }

    if (picking.isNotEmpty()) {
        val list = picking
        // A repeating task's day moves only before its next one (Figma 3.2).
        val last = list.filter { it.isRepeatingTask }.mapNotNull { store.taskMoveRange(it, today)?.last }.minOrNull()
        DayDialog(today + 1, { it >= today && (last == null || it <= last) }, { picking = emptyList() }, title = "Select date") { day ->
            picking = emptyList(); move(list, day); endSelection()
        }
    }
    if (deleting.isNotEmpty()) {
        val list = deleting
        val one = list.size == 1
        AppDialog(if (one) "Delete ${list[0].name}?" else "Delete ${list.size} tasks?",
            if (one) "Its history and notes are deleted too. To keep them, archive it instead." else "Their history and notes are deleted too. To keep them, archive them instead.",
            "Delete", { deleting = emptyList(); endSelection(); delete(list) }, { deleting = emptyList() },
            destructive = true, confirmTag = "delete-confirm", dismissTag = "delete-cancel")
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
 * One task: icon (a check mark when selected), name (struck through once done today) and its lines, and ⋮. With [drag]
 * (its day's open tasks, in order), touch and hold lifts it to move within its day; let go without moving and it's
 * selected instead (Figma 1.10). It looks like the List item atom (2.4: Surface, its corners, a Title Medium name) but keeps
 * its own gestures, because a hold lifts it to drag and must not also open it (T22).
 */
@OptIn(ExperimentalFoundationApi::class)
@Composable
internal fun TaskRow(
    task: Habit, lines: List<String>, done: Boolean, index: Int, count: Int, selecting: Boolean, marked: Boolean,
    onClick: () -> Unit, onLongClick: () -> Unit, menu: (@Composable (Habit, () -> Unit) -> Unit)?, coach: (() -> Unit)? = null,
    drag: List<String>? = null, onDrop: (List<String>) -> Unit = {},
) {
    val c = appColors
    var open by remember { mutableStateOf(false) }
    var dy by remember { mutableFloatStateOf(0f) }
    var lifted by remember { mutableStateOf(false) }
    var height by remember { mutableIntStateOf(1) }
    val order by rememberUpdatedState(drag)
    val long by rememberUpdatedState(onLongClick)
    val drop by rememberUpdatedState(onDrop)
    val slop = with(LocalDensity.current) { 8.dp.toPx() }
    // A hold that ends where it began selects; the release that ends it isn't also a tap (it opened the task).
    var heldUntil by remember { mutableStateOf(0L) }
    val dragModifier = if (drag == null) Modifier else Modifier.pointerInput(task.id) {
        detectDragGesturesAfterLongPress(
            // The tap handler sees the release first: from the hold on, no tap until it's over.
            onDragStart = { heldUntil = Long.MAX_VALUE; lifted = true; dy = 0f },
            onDrag = { change, amount -> change.consume(); dy += amount.y },
            onDragEnd = {
                heldUntil = android.os.SystemClock.uptimeMillis() + 500
                val ids = order
                if (kotlin.math.abs(dy) < slop || ids == null) long()
                else {
                    val from = ids.indexOf(task.id)
                    val to = (from + (dy / height).roundToInt()).coerceIn(0, ids.size - 1)
                    if (from >= 0 && to != from) drop(ids.toMutableList().also { it.removeAt(from); it.add(to, task.id) })
                }
                lifted = false; dy = 0f
            },
            // The tap handler takes a release that hasn't moved, so a still hold ends here, not in onDragEnd: it selects.
            // Only while held: the detector is also cancelled when selecting removes it, between gestures.
            onDragCancel = {
                if (lifted) heldUntil = android.os.SystemClock.uptimeMillis() + 500
                if (lifted && kotlin.math.abs(dy) < slop) long()
                lifted = false; dy = 0f
            },
        )
    }
    Box(Modifier.graphicsLayer { translationY = if (lifted) dy else 0f }.let { if (lifted) it.shadow(8.dp, segmentShape(index, count)) else it }) {
        Row(
            Modifier.padding(bottom = SegmentedListGap).fillMaxWidth().clip(segmentShape(index, count)).background(if (marked) c.tonal else MaterialTheme.colorScheme.surface)
                .onSizeChanged { height = it.height.coerceAtLeast(1) }
                .then(dragModifier)
                .combinedClickable(onClick = { if (android.os.SystemClock.uptimeMillis() > heldUntil) onClick() }, onLongClick = if (drag == null) onLongClick else null, role = if (selecting) Role.Checkbox else Role.Button)
                .semantics(mergeDescendants = true) {
                    testTag = "tasks-row-" + task.name
                    if (selecting) stateDescription = if (marked) "Selected" else "Not selected"
                }
                .heightIn(min = 72.dp).padding(start = 16.dp, end = 4.dp, top = 8.dp, bottom = 8.dp),
            verticalAlignment = Alignment.CenterVertically,
        ) {
            if (marked) Box(Modifier.size(40.dp).clip(CircleShape).background(c.ink), contentAlignment = Alignment.Center) {
                Icon(Symbols.Check, null, Modifier.size(20.dp), tint = c.onInk)
            } else HabitIcon(task.symbol, task.color)
            Spacer(Modifier.width(16.dp))
            Column(Modifier.weight(1f).padding(end = if (menu == null) 12.dp else 0.dp)) {
                Text(task.name, style = AppType.titleMedium.copy(textDecoration = if (done) TextDecoration.LineThrough else null),
                    color = if (done) c.secondary else c.ink)
                for (l in lines) Text(l, style = AppType.bodyMedium, color = c.secondary)
            }
            if (menu != null) Box {
                StandardIconButton(Symbols.MoreVert, "More for ${task.name}", { open = true }, Modifier.semantics { testTag = "tasks-row-more-" + task.name })
                AppMenu(open, { open = false }, modifier = Modifier.semantics { testTagsAsResourceId = true }) { menu(task) { open = false } }
            }
        }
        if (coach != null) Popup(alignment = Alignment.TopStart, offset = IntOffset(0, with(LocalDensity.current) { 68.dp.roundToPx() }), onDismissRequest = coach) {
            Column(Modifier.semantics { testTag = "tasks-coach"; testTagsAsResourceId = true }) {
                Box(Modifier.padding(start = 28.dp).size(12.dp).graphicsLayer { rotationZ = 45f; translationY = 6.dp.toPx() }.background(c.ink))
                Column(Modifier.widthIn(max = 312.dp).clip(RoundedCornerShape(12.dp)).background(c.ink).padding(start = 16.dp, end = 16.dp, top = 12.dp, bottom = 4.dp)) {
                    Text("Select several at once", style = AppType.labelLarge, color = c.onInk)
                    Spacer(Modifier.height(4.dp))
                    Text("Touch and hold a task to move, archive or delete several together. Or use Select in the menu at the top right.",
                        style = AppType.bodyMedium, color = c.onInk.copy(alpha = 0.85f))
                    TextButton(coach, Modifier.semantics { testTag = "tasks-coach-ok" }) { Text("Got it", style = AppType.labelLarge, color = c.onInk) }
                }
            }
        }
    }
}

/**
 * A row's ⋮ (Figma 3, 3.2, 3.7, 3.8). One-time: Edit task, Move to another day… (Tomorrow, Pick a day…, No date), Duplicate,
 * Archive, Delete task…. Repeating adds Skip this time. No date: Do today and Pick a day…. Done today: Mark as not done.
 */
@Composable
private fun TaskMenuItems(
    t: Habit, kind: RowKind, today: Int, dismiss: () -> Unit, onEdit: () -> Unit, onDuplicate: () -> Unit, onMove: (Int?) -> Unit,
    onPick: () -> Unit, onSkip: () -> Unit, onNotDone: () -> Unit, onArchive: () -> Unit, onDelete: () -> Unit,
) {
    val c = appColors
    var moving by remember { mutableStateOf(false) }
    if (moving) {
        AppMenuItem("Tomorrow · " + taskDay(today + 1), { dismiss(); onMove(today + 1) }, icon = Symbols.CalendarMonth, tag = "tasks-menu-tomorrow")
        AppMenuItem("Pick a day…", { dismiss(); onPick() }, icon = Symbols.Event, tag = "tasks-menu-pick")
        if (kind != RowKind.REPEATING) AppMenuItem("No date", { dismiss(); onMove(null) }, icon = Symbols.EventBusy, tag = "tasks-menu-nodate")
        return
    }
    AppMenuItem("Edit task", { dismiss(); onEdit() }, icon = Symbols.Edit, tag = "tasks-menu-edit")
    when (kind) {
        RowKind.NO_DATE -> {
            AppMenuItem("Do today", { dismiss(); onMove(today) }, icon = Symbols.Today, tag = "tasks-menu-today")
            AppMenuItem("Pick a day…", { dismiss(); onPick() }, icon = Symbols.Event, tag = "tasks-menu-pick")
        }
        RowKind.DONE -> AppMenuItem("Mark as not done", { dismiss(); onNotDone() }, icon = Symbols.Undo, tag = "tasks-menu-not-done")
        else -> AppMenuItem("Move to another day…", { moving = true }, icon = Symbols.Event, tag = "tasks-menu-move")
    }
    AppMenuItem("Duplicate", { dismiss(); onDuplicate() }, icon = Symbols.ContentCopy, tag = "tasks-menu-duplicate")
    if (kind == RowKind.REPEATING) AppMenuItem("Skip this time", { dismiss(); onSkip() }, icon = Symbols.Redo, tag = "tasks-menu-skip")
    MenuDivider()
    AppMenuItem("Archive", { dismiss(); onArchive() }, icon = Symbols.Archive, tag = "tasks-menu-archive")
    AppMenuItem("Delete task…", { dismiss(); onDelete() }, icon = Symbols.Delete, destructive = true, tag = "tasks-menu-delete")
}

/** Search (Figma 5–5.3): open tasks first with their day, then Completed and Archived, each saying so; no match offers a new task. */
@Composable
private fun TaskSearch(
    store: HabitStore, query: String, open: List<Habit>, archived: List<Habit>, today: Int,
    onRow: (Habit) -> Unit, onLong: (Habit) -> Unit, menu: @Composable (Habit, RowKind, () -> Unit) -> Unit, onNew: () -> Unit,
) {
    val c = appColors
    val q = query.trim().lowercase()
    if (q.isEmpty()) return
    fun hit(t: Habit) = t.name.lowercase().contains(q)
    val tasks = open.filter { hit(it) && !(it.isOneTimeTask && store.doneEntry(it) != null) }
    val done = open.filter { hit(it) && it.isOneTimeTask && store.doneEntry(it) != null }
    val old = archived.filter { hit(it) }
    if (tasks.isEmpty() && done.isEmpty() && old.isEmpty()) {
        Column(Modifier.fillMaxWidth().padding(top = 72.dp, start = 32.dp, end = 32.dp), horizontalAlignment = Alignment.CenterHorizontally) {
            Text("No tasks called “${query.trim()}”", style = AppType.titleMedium, color = c.ink, textAlign = TextAlign.Center)
            Spacer(Modifier.height(16.dp))
            Text("Check the spelling, or add it as a new task.", style = AppType.bodyMedium, color = c.secondary, textAlign = TextAlign.Center)
            Spacer(Modifier.height(16.dp))
            AppButton("New task “${query.trim()}”", onNew, style = ButtonStyle.Tonal, icon = Symbols.Add, tag = "tasks-search-new")
        }
        return
    }
    fun line(t: Habit): String = when {
        t.isRepeatingTask -> store.repeatingLines(t, today).first()
        t.dueDay == NO_DATE_DAY -> "No date"
        (t.dueDay ?: today) < today -> "Today · planned " + taskDay(t.dueDay!!).substringAfter(' ')
        t.dueDay == today -> "Today · " + store.taskWhen(t)
        else -> taskDay(t.dueDay!!) + store.taskWhen(t).let { if (it == "Anytime") "" else " · $it" }
    }
    LazyColumn(Modifier.fillMaxSize().padding(horizontal = 16.dp).semantics { testTag = "tasks-search-results" }) {
        fun LazyListScope.group(title: String, list: List<Habit>, first: Boolean, kind: (Habit) -> RowKind, words: (Habit) -> String, struck: Boolean) {
            if (list.isEmpty()) return
            item(key = "t-$title") { SectionTitle(title, first) }
            list.forEachIndexed { i, t ->
                item(key = t.id) {
                    TaskRow(t, listOf(words(t)), struck, i, list.size, false, false, { onRow(t) }, { onLong(t) }, { task, dismiss -> menu(task, kind(task), dismiss) })
                }
            }
        }
        group("Tasks", tasks, true, { if (it.isRepeatingTask) RowKind.REPEATING else if (it.dueDay == NO_DATE_DAY) RowKind.NO_DATE else RowKind.ONE_TIME }, ::line, false)
        group("Completed", done, tasks.isEmpty(), { RowKind.DONE }, { t -> "Done " + taskDay(store.doneEntry(t)!!.day) }, true)
        group("Archived", old, tasks.isEmpty() && done.isEmpty(), { RowKind.ONE_TIME }, { store.archivedLine(it) }, false)
        item { Spacer(Modifier.height(88.dp)) }
    }
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
