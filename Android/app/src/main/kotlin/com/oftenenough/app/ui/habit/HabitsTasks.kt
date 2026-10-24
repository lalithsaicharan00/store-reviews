package com.oftenenough.app.ui.habit

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.ui.draw.clip
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.outlined.Archive
import androidx.compose.material.icons.outlined.Delete
import androidx.compose.material.icons.outlined.Edit
import androidx.compose.material.icons.outlined.PauseCircle
import androidx.compose.material.icons.outlined.PlayCircle
import androidx.compose.material.icons.rounded.Add
import androidx.compose.material.icons.rounded.Menu
import androidx.compose.material.icons.rounded.Search
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.PrimaryTabRow
import androidx.compose.material3.SnackbarDuration
import androidx.compose.material3.SnackbarHost
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.SnackbarResult
import androidx.compose.material3.Tab
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.derivedStateOf
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.DaySection
import com.oftenenough.app.data.DayWords

import com.oftenenough.app.data.archivedLine
import com.oftenenough.app.data.listLine
import com.oftenenough.app.data.weekGoalText
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitPause
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.progress.HabitCard
import com.oftenenough.app.ui.progress.HeatKeyVisit
import com.oftenenough.app.ui.progress.PeriodBar
import com.oftenenough.app.ui.progress.ProgressNav
import com.oftenenough.app.ui.progress.ProgressRangeMemory
import com.oftenenough.app.ui.progress.RangePicker
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch

/**
 * **Habits & Tasks** (Figma `269:148`, 23 Oct 2026): one page, two tabs. **Habits** is every habit by time of day as a
 * card with its week, month or year of squares — the headline on the habit's own clock, one more fact, and a square
 * per day; the card opens Habit details, a square opens that day, and the card's ⋮ edits, pauses, archives or deletes
 * it. Paused habits wait at the end, then the Archived row and What the squares mean. **Tasks** is the Tasks list,
 * One-time and Repeating. The top bar is ☰ · Habits & Tasks · search · +, with no ⋮, and search covers both.
 *
 * Nothing here is selected or held: a long press does nothing, and every action is one row in a menu (A63).
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun HabitsTasksPage(store: HabitStore, nav: HabitsNav, tasksNav: TasksNav) {
    val c = appColors
    var tab by rememberSaveable { mutableIntStateOf(if (HabitsTasksOpen.onTasks) 1 else 0) }
    LaunchedEffect(tab) { HabitsTasksOpen.onTasks = tab == 1 }
    var searching by rememberSaveable { mutableStateOf(false) }
    var query by rememberSaveable { mutableStateOf("") }

    BackHandler(enabled = searching) { searching = false; query = "" }

    Box(Modifier.fillMaxSize().background(c.screen)) {
        if (searching) {
            BothSearch(store, query, { query = it }, onBack = { searching = false; query = "" }, nav = nav, tasksNav = tasksNav)
        } else Column(Modifier.fillMaxSize()) {
            TopAppBar(
                title = { Text("Habits & Tasks", maxLines = 1) },
                navigationIcon = {
                    nav.openMenu?.let { open -> IconButton(open, Modifier.semantics { testTag = "habits-menu" }) { Icon(Icons.Rounded.Menu, "Menu") } }
                },
                actions = {
                    IconButton({ searching = true }, Modifier.semantics { testTag = "habits-search" }) { Icon(Icons.Rounded.Search, "Search habits and tasks") }
                    // + makes what the tab is for: a habit on Habits, a task on Tasks (flows 16 and 33).
                    IconButton({ if (tab == 0) nav.newHabit() else tasksNav.newTask() }, Modifier.semantics { testTag = "habits-add" }) {
                        Icon(Icons.Rounded.Add, if (tab == 0) "New habit" else "New task")
                    }
                },
                colors = TopAppBarDefaults.topAppBarColors(containerColor = c.screen, scrolledContainerColor = c.tonal,
                    titleContentColor = c.ink, navigationIconContentColor = c.ink, actionIconContentColor = c.ink),
            )
            PrimaryTabRow(tab, containerColor = c.screen, contentColor = c.ink, modifier = Modifier.semantics { testTag = "habits-tasks-tabs" }) {
                for ((i, t) in listOf("Habits", "Tasks").withIndex()) {
                    Tab(tab == i, { tab = i }, Modifier.semantics { testTag = "habits-tasks-tab-$i" },
                        text = { Text(t, style = AppType.labelLarge) }, selectedContentColor = c.ink, unselectedContentColor = c.secondary)
                }
            }
            Box(Modifier.fillMaxWidth().weight(1f)) {
                if (tab == 0) HabitsTab(store, nav) else TasksTab(store, tasksNav)
            }
        }
    }
}

/** Which tab Habits & Tasks opens on, kept while the app runs so coming back lands where you left it. */
object HabitsTasksOpen {
    var onTasks: Boolean = false
}

/**
 * The Habits tab: the period's cards by time of day. Its numbers come from one snapshot, worked out when the data, the
 * period or the day changes and kept for the app's life, so moving between periods is instant (S5).
 */
@Composable
private fun HabitsTab(store: HabitStore, nav: HabitsNav) {
    val c = appColors
    val scope = androidx.compose.runtime.rememberCoroutineScope()
    val snackbar = remember { SnackbarHostState() }
    val visit = remember(store) { HeatKeyVisit(store) }
    val range = ProgressRangeMemory.range
    var anchor by rememberSaveable { mutableStateOf<Int?>(null) }
    val today = com.oftenenough.app.ui.progress.rememberToday(store)
    var pausing by remember { mutableStateOf<List<Habit>>(emptyList()) }
    var deleting by remember { mutableStateOf<Habit?>(null) }
    var hidden by remember { mutableStateOf(emptySet<String>()) }

    val snap = com.oftenenough.app.ui.progress.rememberProgressSnapshot(store, range, anchor, today, null)
    val move: (Int) -> Unit = { step ->
        val day = if (step < 0) snap.first - 1 else snap.last + 1
        anchor = if (today in store.rules.period(range.kind, day)) null else day
    }

    fun say(text: String, action: String = "Undo", onAction: () -> Unit) {
        scope.launch {
            snackbar.currentSnackbarData?.dismiss()
            if (snackbar.showSnackbar(text, action, duration = SnackbarDuration.Short) == SnackbarResult.ActionPerformed) onAction()
        }
    }
    fun archive(h: Habit) {
        store.archive(listOf(h))
        say("${h.name} archived") { store.restore(h, undoing = true) }
    }
    fun resume(h: Habit) {
        val before = store.pauses[h.id] ?: emptyList()
        store.resume(h)
        say("${h.name} resumed") { store.setPauses(h, before) }
    }
    // Deleted only once its Undo has gone (D6): till then the card is hidden, and leaving the page deletes it.
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

    val all = store.habits.filter { it.kind != HabitKind.Task && it.id !in hidden }
    val active = all.filter { !it.archived }
    val archived = all.filter { it.archived }
    val paused = active.filter { store.isPaused(it, today) }
    val sections = remember(all, store.sections, today, store.pauses) { habitSections(store, active, paused, byGroup = false) }
    val byId = remember(snap) { snap.cards.associateBy { it.habit.id } }

    val progressNav = remember(nav) {
        object : ProgressNav {
            override fun openHabit(habit: Habit) = nav.open(habit)
            override fun openDay(habit: Habit, day: Int) = nav.openDay(habit, day)
        }
    }

    Box(Modifier.fillMaxSize()) {
        // Nothing going: the same empty state as Today, and the archive stays one tap away (flow 18).
        if (active.isEmpty()) EmptyHabits(archived.size, nav)
        else {
            val list = rememberLazyListState()
            val pinned by remember(list) {
                derivedStateOf { list.firstVisibleItemIndex > 0 }
            }
            Box(Modifier.fillMaxSize()) {
                LazyColumn(Modifier.fillMaxSize().semantics { testTag = "habits-list" }, state = list,
                    contentPadding = PaddingValues(bottom = 24.dp)) {
                    item(key = "range", contentType = "range") { RangePicker(range) { ProgressRangeMemory.range = it } }
                    item(key = "period", contentType = "period") { PeriodBar(snap, move) { anchor = null } }
                    for (s in sections) {
                        item(key = "title-" + s.key, contentType = "title") {
                            Text(s.title, Modifier.padding(start = 32.dp, end = 24.dp, top = 16.dp, bottom = 4.dp)
                                .semantics { heading(); testTag = "habits-section-" + s.title }, style = AppType.labelLarge, color = c.secondary)
                        }
                        items(s.habits, key = { "card-" + it.id }, contentType = { "card" }) { h ->
                            val card = byId[h.id]
                            if (card != null) HabitCard(card, snap, store, progressNav, Modifier.padding(horizontal = 16.dp, vertical = 8.dp),
                                tagPrefix = "habits-card-", menuTag = "habits-row-more-" + h.name) { dismiss ->
                                CardMenuItems(h, store, today, dismiss, onEdit = { nav.edit(h) }, onPause = { pausing = listOf(h) },
                                    onResume = { resume(h) }, onArchive = { archive(h) }, onDelete = { deleting = h })
                            }
                        }
                    }
                    if (archived.isNotEmpty()) item(key = "archived", contentType = "archived") {
                        Spacer(Modifier.height(16.dp))
                        Box(Modifier.padding(horizontal = 16.dp)) { ArchivedRow(archived.size, enabled = true) { nav.archived() } }
                    }
                    item(key = "key", contentType = "key") {
                        HeatKeyCard(visit.isOpen, { visit.toggle() }, Modifier.padding(start = 16.dp, end = 16.dp, top = 16.dp, bottom = 8.dp))
                    }
                    item(key = "end", contentType = "end") { Spacer(Modifier.navigationBarsPadding().height(24.dp)) }
                }
                // The period stays in sight while the cards scroll under it (flow 4).
                if (pinned) PeriodBar(snap, move) { anchor = null }
            }
        }
        SnackbarHost(snackbar, Modifier.align(Alignment.BottomCenter).navigationBarsPadding().padding(4.dp))
    }

    if (pausing.isNotEmpty()) {
        val list = pausing
        val before = list.associate { it.id to (store.pauses[it.id] ?: emptyList<HabitPause>()) }
        PauseSheet(list, store, { pausing = emptyList() }) { back ->
            pausing = emptyList()
            val until = back?.let { " until " + DayWords.short(it) } ?: ""
            say("${list[0].name} paused$until") { list.forEach { h -> store.setPauses(h, before[h.id] ?: emptyList()) } }
        }
    }
    deleting?.let { h ->
        // Two buttons only, and the body points at Archive, which keeps everything (D9).
        AlertDialog({ deleting = null },
            modifier = Modifier.semantics { testTagsAsResourceId = true },
            title = { Text("Delete ${h.name}?") },
            text = { Text("Its logs, notes and streak go too. To keep them, choose Archive in the same menu instead.") },
            confirmButton = { TextButton({ deleting = null; delete(h) }, Modifier.semantics { testTag = "delete-confirm" }) { Text("Delete", color = c.error) } },
            dismissButton = { TextButton({ deleting = null }, Modifier.semantics { testTag = "delete-cancel" }) { Text("Cancel", color = c.ink) } },
            containerColor = c.menu, titleContentColor = c.ink, textContentColor = c.secondary)
    }
}

/** A card's ⋮: Edit habit, Pause… (or Resume), Archive, and Delete last, in red (flow 7). */
@Composable
private fun CardMenuItems(habit: Habit, store: HabitStore, today: Int, dismiss: () -> Unit, onEdit: () -> Unit,
                          onPause: () -> Unit, onResume: () -> Unit, onArchive: () -> Unit, onDelete: () -> Unit) {
    MenuItem("Edit habit", Icons.Outlined.Edit, "habits-menu-edit") { dismiss(); onEdit() }
    if (store.rules.canPause(habit)) {
        if (store.isPaused(habit, today)) MenuItem("Resume", Icons.Outlined.PlayCircle, "habits-menu-resume") { dismiss(); onResume() }
        else MenuItem("Pause…", Icons.Outlined.PauseCircle, "habits-menu-pause") { dismiss(); onPause() }
    }
    MenuItem("Archive", Icons.Outlined.Archive, "habits-menu-archive") { dismiss(); onArchive() }
    MenuItem("Delete", Icons.Outlined.Delete, "habits-menu-delete", danger = true) { dismiss(); onDelete() }
}

/**
 * One search over both halves (flows 14, 15, 31, 32): Android's full-screen search view, "Search habits and tasks",
 * the keyboard up. Habits first with their count, then Tasks; archived and completed ones are in it and say so.
 * Nothing matching offers a new habit and a new task, each opening with the typed word as its name.
 */
@Composable
private fun BothSearch(store: HabitStore, query: String, onChange: (String) -> Unit, onBack: () -> Unit,
                       nav: HabitsNav, tasksNav: TasksNav) {
    val c = appColors
    val today = store.today()
    val q = query.trim()
    val needle = q.lowercase()
    val all = store.habits
    val habits = if (needle.isEmpty()) emptyList() else all.filter { it.kind != HabitKind.Task && it.name.lowercase().contains(needle) }
    val tasks = if (needle.isEmpty()) emptyList() else all.filter { it.kind == HabitKind.Task && it.name.lowercase().contains(needle) }
    Column(Modifier.fillMaxSize().background(c.screen)) {
        SearchBar(query, onChange, onBack, placeholder = "Search habits and tasks")
        if (needle.isEmpty()) return@Column
        if (habits.isEmpty() && tasks.isEmpty()) {
            Column(Modifier.fillMaxWidth().padding(top = 72.dp, start = 32.dp, end = 32.dp),
                horizontalAlignment = Alignment.CenterHorizontally) {
                Text("Nothing called \u201c$q\u201d", style = AppType.titleMedium, color = c.ink)
                Spacer(Modifier.height(8.dp))
                Text("Check the spelling, or make it now.", style = AppType.bodyMedium, color = c.secondary)
                Spacer(Modifier.height(16.dp))
                NewPill("New habit \u201c$q\u201d", "habits-search-new") { nav.newHabit(q) }
                Spacer(Modifier.height(8.dp))
                NewPill("New task \u201c$q\u201d", "tasks-search-new") { tasksNav.newTask(q) }
            }
            return@Column
        }
        LazyColumn(Modifier.fillMaxSize().padding(horizontal = 16.dp).semantics { testTag = "habits-search-results" }) {
            if (habits.isNotEmpty()) {
                item(key = "h-title") { SearchGroupTitle(if (habits.size == 1) "1 habit" else "${habits.size} habits", first = true) }
                itemsIndexed(habits, key = { _, h -> "h-" + h.id }) { i, h ->
                    HabitsRow(h, searchLine(store, h, today), i, habits.size, false, false, { nav.open(h) }, {}, null)
                }
            }
            if (tasks.isNotEmpty()) {
                item(key = "t-title") { SearchGroupTitle(if (tasks.size == 1) "1 task" else "${tasks.size} tasks", first = habits.isEmpty()) }
                itemsIndexed(tasks, key = { _, t -> "t-" + t.id }) { i, t ->
                    HabitsRow(t, searchLine(store, t, today), i, tasks.size, false, false, { tasksNav.open(t) }, {}, null)
                }
            }
            item(key = "end") { Spacer(Modifier.height(88.dp)) }
        }
    }
}

/** A search result's line: a habit's time of day and plan, a task's day, and plainly when either is put away (flow 14). */
private fun searchLine(store: HabitStore, h: Habit, today: Int): String = when {
    h.kind == HabitKind.Task -> taskSearchLine(store, h, today)
    h.archived -> store.archivedLine(h)
    else -> {
        val part = h.parts.firstOrNull()?.takeIf { it != DaySection.ANYTIME }?.let { store.section(it).name } ?: "Anytime"
        // The same words as the card's own goal line: "Afternoon \u00b7 30 min a day" (296:400).
        part + " \u00b7 " + store.weekGoalText(h)
    }
}

@Composable
private fun SearchGroupTitle(text: String, first: Boolean) =
    Text(text, Modifier.padding(start = 16.dp, top = if (first) 8.dp else 24.dp, bottom = 8.dp)
        .semantics { heading(); testTag = "search-group-" + text.substringBefore(" ") },
        style = AppType.labelLarge, color = appColors.secondary)

@Composable
private fun NewPill(text: String, tag: String, onClick: () -> Unit) {
    val c = appColors
    Row(Modifier.clip(androidx.compose.foundation.shape.RoundedCornerShape(20.dp)).background(c.tonal)
        .clickable(onClick = onClick).semantics(mergeDescendants = true) { testTag = tag }
        .padding(start = 16.dp, end = 24.dp).height(40.dp), verticalAlignment = Alignment.CenterVertically) {
        Icon(Icons.Rounded.Add, null, Modifier.size(18.dp), tint = c.ink)
        Spacer(Modifier.width(8.dp))
        Text(text, style = AppType.labelLarge, color = c.ink, maxLines = 1)
    }
}
