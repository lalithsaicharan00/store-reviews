package com.oftenenough.app.ui.habit

import com.oftenenough.app.ui.components.AppSnackbarHost
import com.oftenenough.app.ui.components.AppMenu
import com.oftenenough.app.ui.components.AppMenuItem
import androidx.compose.ui.graphics.Color
import com.oftenenough.app.ui.components.SegmentedListGap
import com.oftenenough.app.ui.components.ListChevron
import com.oftenenough.app.ui.components.ListAvatar
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.MenuDivider
import com.oftenenough.app.ui.components.SearchHeader
import com.oftenenough.app.ui.components.AppTopBar
import com.oftenenough.app.ui.components.StandardIconButton
import androidx.activity.compose.BackHandler
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
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyListScope
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.RadioButton
import androidx.compose.material3.SnackbarDuration
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.SnackbarResult
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
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
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.stateDescription
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.IntOffset
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.Popup
import com.oftenenough.app.data.DaySection
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitPause
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.listLine
import com.oftenenough.app.ui.components.CookieIcon
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.newhabit.NewGroupDialog
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch

/** Where the Habits page goes. [openMenu] is null where the menu is a sidebar beside the page. */
interface HabitsNav {
    val openMenu: (() -> Unit)?
    fun open(habit: Habit)
    fun edit(habit: Habit)
    fun duplicate(habit: Habit)
    fun newHabit(name: String? = null)
    fun ideas()
    fun archived()
    fun arrange()
    fun editGroups()
    fun openGroup(id: String)
    /**
     * Tasks and Progress, from this page's ⋮. The menu is six rows now (Figma `12:5259`) and **Habits & Tasks**
     * opens here, so until that one page exists these two keep their way in from the page they belong with.
     */
    fun tasks()
    fun progress()
}

private const val SHOW_BY = "habits.show_by"
private const val COACH_SEEN = "habits.coach_seen"

/** A section of the list: its title and its habits, in the person's order. */
private class HabitSection(val key: String, val title: String, val habits: List<Habit>)

/**
 * ≡ › Habits (Figma 2106:2): every habit by time of day, in the person's order as on Today (or by group), then Quitting,
 * Paused, and the Archived row. Each row's ⋮ edits, duplicates, pauses or resumes, archives or deletes it; a long press
 * (or ⋮ › Select) selects several; search finds any habit, archived ones too. Pause, Resume, Archive and Delete each say
 * what happened with Undo (D6: a delete only happens once its Undo has gone).
 */
@OptIn(ExperimentalMaterial3Api::class, ExperimentalFoundationApi::class)
@Composable
fun HabitsPage(store: HabitStore, nav: HabitsNav) {
    val c = appColors
    val scope = rememberCoroutineScope()
    val snackbar = remember { SnackbarHostState() }
    val today = store.today()
    var selecting by rememberSaveable { mutableStateOf(false) }
    var chosen by rememberSaveable { mutableStateOf(emptySet<String>()) }
    var searching by rememberSaveable { mutableStateOf(false) }
    var query by rememberSaveable { mutableStateOf("") }
    var hidden by remember { mutableStateOf(emptySet<String>()) }
    var showBy by remember { mutableStateOf(store.setting(SHOW_BY) ?: "time") }
    var coachSeen by remember { mutableStateOf(store.setting(COACH_SEEN) != null) }
    var topMenu by remember { mutableStateOf(false) }
    var showByDialog by remember { mutableStateOf(false) }
    var newGroup by remember { mutableStateOf(false) }
    var pausing by remember { mutableStateOf<List<Habit>>(emptyList()) }
    var deleting by remember { mutableStateOf<List<Habit>>(emptyList()) }
    var grouping by remember { mutableStateOf<List<Habit>>(emptyList()) }

    val all = store.habits.filter { it.kind != HabitKind.Task && it.id !in hidden }
    val active = all.filter { !it.archived }
    val archived = all.filter { it.archived }
    val paused = active.filter { store.isPaused(it, today) }
    val byGroup = showBy == "group" && store.groups.isNotEmpty()
    val sections = remember(all, store.sections, store.groups, byGroup, today, store.pauses) {
        habitSections(store, active, paused, byGroup)
    }
    val marked = all.filter { it.id in chosen }

    fun endSelection() { selecting = false; chosen = emptySet() }
    fun say(text: String, action: String, onAction: () -> Unit) {
        scope.launch {
            snackbar.currentSnackbarData?.dismiss()
            if (snackbar.showSnackbar(text, action, duration = SnackbarDuration.Short) == SnackbarResult.ActionPerformed) onAction()
        }
    }
    fun named(list: List<Habit>) = if (list.size == 1) list[0].name else "${list.size} habits"
    fun archive(list: List<Habit>) {
        store.archive(list)
        say("${named(list)} archived", "Undo") { list.forEach { store.restore(it) } }
    }
    fun resume(list: List<Habit>) {
        val before = list.associate { it.id to (store.pauses[it.id] ?: emptyList<HabitPause>()) }
        list.forEach { store.resume(it) }
        say("${named(list)} resumed", "Undo") { list.forEach { h -> store.setPauses(h, before[h.id] ?: emptyList()) } }
    }
    // Deleted only once its Undo has gone (Figma 2.6.1): till then the rows are hidden, and leaving the page deletes them.
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
    fun toggle(h: Habit) { chosen = if (h.id in chosen) chosen - h.id else chosen + h.id }
    fun seeCoach() { if (!coachSeen) { coachSeen = true; store.saveAppSetting(COACH_SEEN, "1") } }

    BackHandler(enabled = selecting || searching) {
        if (selecting) endSelection() else { searching = false; query = "" }
    }

    val rowMenu: @Composable (Habit, () -> Unit) -> Unit = { h, dismiss ->
        RowMenuItems(h, store, today, dismiss, onEdit = { nav.edit(h) }, onDuplicate = { nav.duplicate(h) },
            onPause = { pausing = listOf(h) }, onResume = { resume(listOf(h)) }, onArchive = { archive(listOf(h)) }, onDelete = { deleting = listOf(h) })
    }
    val onRow: (Habit) -> Unit = { h -> if (selecting) toggle(h) else nav.open(h) }
    val onLong: (Habit) -> Unit = { h -> seeCoach(); if (!selecting) { selecting = true; chosen = setOf(h.id) } else toggle(h) }

    val scroll = TopAppBarDefaults.pinnedScrollBehavior()
    Box(Modifier.fillMaxSize().background(c.screen)) {
        Column(Modifier.fillMaxSize()) {
            when {
                searching -> SearchHeader(query, { query = it.take(40) }, onBack = { searching = false; query = "" }, "Search habits",
                    fieldTag = "habits-search-field", backTag = "habits-search-back", clearTag = "habits-search-clear")
                selecting -> AppTopBar(
                    if (chosen.isEmpty()) "Select habits" else "${chosen.size} selected",
                    navigationIcon = { IconButton(::endSelection, Modifier.semantics { testTag = "habits-end-selection" }) { Icon(Symbols.Close, "Stop selecting") } },
                    actions = {
                        val allIds = active.map { it.id }.toSet()
                        val everything = chosen.containsAll(allIds) && allIds.isNotEmpty()
                        AppButton(if (everything) "Deselect all" else "Select all", { chosen = if (everything) emptySet() else allIds }, Modifier.padding(end = 4.dp).semantics { testTag = "habits-select-all" }, style = ButtonStyle.Text)
                    },
                    containerColor = c.tonal,
                )
                else -> AppTopBar(
                    "Habits",
                    navigationIcon = {
                        nav.openMenu?.let { open -> IconButton(open, Modifier.semantics { testTag = "habits-menu" }) { Icon(Symbols.Menu, "Menu") } }
                    },
                    actions = {
                        IconButton({ searching = true }, Modifier.semantics { testTag = "habits-search" }) { Icon(Symbols.Search, "Search habits") }
                        IconButton({ nav.newHabit() }, Modifier.semantics { testTag = "habits-add" }) { Icon(Symbols.Add, "New habit") }
                        Box {
                            IconButton({ topMenu = true }, Modifier.semantics { testTag = "habits-more" }) { Icon(Symbols.MoreVert, "More") }
                            AppMenu(topMenu, { topMenu = false }, modifier = Modifier.semantics { testTagsAsResourceId = true }) {
                                AppMenuItem("Select", { topMenu = false; seeCoach(); selecting = true; chosen = emptySet() }, icon = Symbols.CheckBox, tag = "habits-select")
                                if (store.groups.isNotEmpty()) AppMenuItem("Show by…", { topMenu = false; showByDialog = true }, icon = Symbols.ViewAgenda, tag = "habits-show-by")
                                AppMenuItem("Arrange…", { topMenu = false; nav.arrange() }, icon = Symbols.SwapVert, tag = "habits-arrange")
                                if (store.groups.isNotEmpty()) AppMenuItem("Edit groups", { topMenu = false; nav.editGroups() }, icon = Symbols.Folder, tag = "habits-edit-groups")
                                else AppMenuItem("New group", { topMenu = false; newGroup = true }, icon = Symbols.CreateNewFolder, tag = "habits-new-group")
                                // Figma 5, 5.3 (19 Oct 2026): Archived habits from the menu too; the list's last row stays.
                                AppMenuItem("Archived habits", { topMenu = false; nav.archived() }, icon = Symbols.Archive, tag = "habits-menu-archived")
                                // Until Habits and Tasks are one page, this is the way to the other half, and to Progress.
                                AppMenuItem("Tasks", { topMenu = false; nav.tasks() }, icon = Symbols.List, tag = "habits-menu-tasks")
                                AppMenuItem("Progress", { topMenu = false; nav.progress() }, icon = Symbols.BarChart, tag = "habits-menu-progress")
                            }
                        }
                    },
                    scrollBehavior = scroll,
                )
            }
            val list = rememberLazyListState()
            Box(Modifier.weight(1f).fillMaxWidth()) {
                when {
                    searching -> SearchResults(store, query, active, archived, today, onRow, onLong, rowMenu) { nav.newHabit(query.trim()) }
                    active.isEmpty() -> EmptyHabits(archived.size, nav)
                    else -> LazyColumn(Modifier.fillMaxSize().nestedScroll(scroll.nestedScrollConnection).padding(horizontal = 16.dp)
                        .semantics { testTag = "habits-list" }, state = list) {
                        var first = true
                        for ((n, s) in sections.withIndex()) {
                            item(key = "title-${s.key}") { SectionTitle(s.title, n == 0) }
                            s.habits.forEachIndexed { i, h ->
                                val coach = first && !coachSeen && !selecting && active.size >= 2
                                first = false
                                item(key = h.id) {
                                    HabitsRow(h, store.listLine(h, today), i, s.habits.size, selecting, h.id in chosen, { onRow(h) }, { onLong(h) },
                                        if (selecting) null else rowMenu, coach = if (coach) ({ seeCoach() }) else null)
                                }
                            }
                        }
                        if (archived.isNotEmpty()) item(key = "archived") {
                            Spacer(Modifier.height(22.dp))
                            ArchivedRow(archived.size, enabled = !selecting) { nav.archived() }
                        }
                        item(key = "end") { Spacer(Modifier.height(if (selecting) 120.dp else 88.dp)) }
                    }
                }
            }
            if (selecting) SelectionBar(marked, store, today,
                onPause = { pausing = marked.filter { !store.isPaused(it, today) && store.rules.canPause(it) } },
                onResume = { resume(marked.filter { store.isPaused(it, today) }); endSelection() },
                onArchive = { archive(marked); endSelection() },
                onGroup = { grouping = marked },
                onDelete = { deleting = marked })
        }
        AppSnackbarHost(snackbar, Modifier.align(Alignment.BottomCenter).navigationBarsPadding().padding(4.dp).padding(bottom = if (selecting) 88.dp else 0.dp))
    }

    if (pausing.isNotEmpty()) {
        val list = pausing
        val before = list.associate { it.id to (store.pauses[it.id] ?: emptyList<HabitPause>()) }
        PauseSheet(list, store, { pausing = emptyList() }) { back ->
            pausing = emptyList()
            endSelection()
            val until = back?.let { " until " + DayWords.dayMonth(it) } ?: ""
            say("${named(list)} paused$until", "Undo") { list.forEach { h -> store.setPauses(h, before[h.id] ?: emptyList()) } }
        }
    }
    if (deleting.isNotEmpty()) {
        val list = deleting
        val one = list.size == 1
        AlertDialog({ deleting = emptyList() },
            modifier = Modifier.semantics { testTagsAsResourceId = true },
            title = { Text(if (one) "Delete ${list[0].name}?" else "Delete ${list.size} habits?") },
            text = { Text(if (one) "Its history and notes are deleted too. To keep them, archive it instead." else "Their history and notes are deleted too. To keep them, archive them instead.") },
            confirmButton = { AppButton("Delete", { deleting = emptyList(); endSelection(); delete(list) }, Modifier.semantics { testTag = "delete-confirm" }, style = ButtonStyle.Text, destructive = true) },
            dismissButton = { AppButton("Cancel", { deleting = emptyList() }, Modifier.semantics { testTag = "delete-cancel" }, style = ButtonStyle.Text) },
            containerColor = c.menu, titleContentColor = c.ink, textContentColor = c.secondary)
    }
    if (grouping.isNotEmpty()) GroupDialog(grouping, store, { grouping = emptyList() }) { groupId ->
        grouping.forEach { store.setGroup(groupId, it.id) }
        grouping = emptyList()
        endSelection()
    }
    if (showByDialog) ShowByDialog(store, showBy, { showByDialog = false }) { pick ->
        showBy = pick; showByDialog = false; store.saveAppSetting(SHOW_BY, pick)
    }
    if (newGroup) NewGroupDialog(store, { newGroup = false }) { id -> newGroup = false; nav.openGroup(id) }
}

/** Sections by time of day as on Today (then Quitting), or by group; then Paused. */
private fun habitSections(store: HabitStore, active: List<Habit>, paused: List<Habit>, byGroup: Boolean): List<HabitSection> {
    val pausedIds = paused.map { it.id }.toSet()
    val going = active.filter { it.id !in pausedIds }
    val out = mutableListOf<HabitSection>()
    if (byGroup) {
        for (g in store.groups) out += HabitSection("g-${g.id}", g.name, going.filter { store.groupOf(it.id)?.id == g.id })
        out += HabitSection("g-none", "No group", going.filter { store.groupOf(it.id) == null })
    } else {
        val members = store.rules.cardMembers()
        val placed = HashSet<String>()
        for (card in store.todayCards()) {
            val ids = members[card] ?: emptyList()
            val list = ids.mapNotNull { id -> going.firstOrNull { it.id == id } }.filter { placed.add(it.id) }
            out += HabitSection(card, if (card == DaySection.QUITTING) "Quitting" else store.section(card).name, list)
        }
        // Anything no card holds (shouldn't happen) still shows, under Anytime.
        val rest = going.filter { it.id !in placed }
        if (rest.isNotEmpty()) out += HabitSection("rest", store.section(DaySection.ANYTIME).name, rest)
    }
    out += HabitSection("paused", "Paused", paused)
    return out.filter { it.habits.isNotEmpty() }
}

@Composable
internal fun SectionTitle(text: String, first: Boolean) =
    Text(text, Modifier.padding(start = 16.dp, top = if (first) 8.dp else 24.dp, bottom = 8.dp).semantics { testTag = "habits-section-$text" },
        style = AppType.bodyMedium, color = appColors.secondary)

/** One habit: icon, name, the line under it, and ⋮; selected, the icon becomes a ✓ and the row tonal (Figma 1, 3). */
@OptIn(ExperimentalFoundationApi::class)
@Composable
fun HabitsRow(
    habit: Habit, line: String, index: Int, count: Int, selecting: Boolean, marked: Boolean, onClick: () -> Unit, onLongClick: () -> Unit,
    menu: (@Composable (Habit, () -> Unit) -> Unit)?, coach: (() -> Unit)? = null,
) {
    val c = appColors
    var open by remember { mutableStateOf(false) }
    Box {
        AppListItem(
            habit.name, index, count,
            Modifier.padding(bottom = SegmentedListGap).semantics(mergeDescendants = true) { if (selecting) stateDescription = if (marked) "Selected" else "Not selected" },
            line, onClick = onClick, onLongClick = onLongClick, containerColor = if (marked) c.tonal else Color.Unspecified, tag = "habits-row-" + habit.name,
            leading = { if (marked) ListAvatar(Symbols.Check, done = true) else HabitIcon(habit.symbol, habit.color) },
            trailing = menu?.let { m -> {
                Box {
                    StandardIconButton(Symbols.MoreVert, "More for ${habit.name}", { open = true }, Modifier.semantics { testTag = "habits-row-more-" + habit.name })
                    AppMenu(open, { open = false }, modifier = Modifier.semantics { testTagsAsResourceId = true }) { m(habit) { open = false } }
                }
            } },
        )
        // First visit (Figma 3.8): Material's rich tooltip under the first row.
        if (coach != null) Popup(alignment = Alignment.TopStart, offset = IntOffset(0, with(androidx.compose.ui.platform.LocalDensity.current) { 68.dp.roundToPx() }),
            onDismissRequest = coach) {
            Column(Modifier.semantics { testTag = "habits-coach"; testTagsAsResourceId = true }) {
            // The caret, pointing up at the row (Material's rich tooltip).
            Box(Modifier.padding(start = 28.dp).size(12.dp).graphicsLayer { rotationZ = 45f; translationY = 6.dp.toPx() }.background(c.ink))
            Column(Modifier.widthIn(max = 312.dp).clip(RoundedCornerShape(12.dp)).background(c.ink).padding(start = 16.dp, end = 16.dp, top = 12.dp, bottom = 4.dp)) {
                Text("Select several at once", style = AppType.labelLarge, color = c.onInk)
                Spacer(Modifier.height(4.dp))
                Text("Touch and hold a habit to group, pause, archive or delete several together. Or use Select in the menu at the top right.",
                    style = AppType.bodyMedium, color = c.onInk.copy(alpha = 0.85f))
                TextButton(coach, Modifier.semantics { testTag = "habits-coach-ok" }) { Text("Got it", style = AppType.labelLarge, color = c.onInk) }
            }
            }
        }
    }
}

/** A row's ⋮ (Figma 2, 2.4): Edit habit, Duplicate, Pause… or Resume, then Archive and Delete habit… (red). */
@Composable
private fun RowMenuItems(
    h: Habit, store: HabitStore, today: Int, dismiss: () -> Unit,
    onEdit: () -> Unit, onDuplicate: () -> Unit, onPause: () -> Unit, onResume: () -> Unit, onArchive: () -> Unit, onDelete: () -> Unit,
) {
    val c = appColors
    AppMenuItem("Edit habit", { dismiss(); onEdit() }, icon = Symbols.Edit, tag = "habits-menu-edit")
    AppMenuItem("Duplicate", { dismiss(); onDuplicate() }, icon = Symbols.ContentCopy, tag = "habits-menu-duplicate")
    if (store.isPaused(h, today)) AppMenuItem("Resume", { dismiss(); onResume() }, icon = Symbols.PlayCircle, tag = "habits-menu-resume")
    else if (store.rules.canPause(h)) AppMenuItem("Pause…", { dismiss(); onPause() }, icon = Symbols.PauseCircle, tag = "habits-menu-pause")
    MenuDivider()
    AppMenuItem("Archive", { dismiss(); onArchive() }, icon = Symbols.Archive, tag = "habits-menu-archive")
    AppMenuItem("Delete habit…", { dismiss(); onDelete() }, icon = Symbols.Delete, destructive = true, tag = "habits-menu-delete")
}

/** The Archived row (Figma 1): its count; it opens Archived habits (List item, 2.4, on its own). */
@Composable
internal fun ArchivedRow(count: Int, enabled: Boolean, noun: String = "habit", onClick: () -> Unit) =
    AppListItem("Archived", 0, 1, Modifier.semantics(mergeDescendants = true) {}, if (count == 1) "1 $noun" else "$count ${noun}s",
        leading = { ListAvatar(Symbols.Inventory2) }, trailing = { ListChevron() }, onClick = onClick, enabled = enabled, tag = "habits-archived")

/** The selection's bottom bar (Figma 3–3.7, 5.6): each action with its word; Pause and Resume show only when they'd act. */
@Composable
private fun SelectionBar(
    marked: List<Habit>, store: HabitStore, today: Int,
    onPause: () -> Unit, onResume: () -> Unit, onArchive: () -> Unit, onGroup: () -> Unit, onDelete: () -> Unit,
) {
    val c = appColors
    val any = marked.isNotEmpty()
    val canPause = marked.any { !store.isPaused(it, today) && store.rules.canPause(it) }
    val canResume = marked.any { store.isPaused(it, today) }
    Surface(color = c.surface, tonalElevation = 3.dp) {
        Row(Modifier.fillMaxWidth().navigationBarsPadding().padding(horizontal = 8.dp, vertical = 8.dp), horizontalArrangement = Arrangement.SpaceEvenly) {
            if (canPause || !any) BarAction("Pause", Symbols.PauseCircle, any, "habits-pause", onPause)
            if (canResume) BarAction("Resume", Symbols.PlayCircle, true, "habits-resume", onResume)
            BarAction("Archive", Symbols.Archive, any, "habits-archive", onArchive)
            BarAction("Group", Symbols.Folder, any, "habits-group", onGroup)
            BarAction("Delete", Symbols.Delete, any, "habits-delete", onDelete, danger = true)
        }
    }
}

@Composable
fun BarAction(text: String, icon: androidx.compose.ui.graphics.vector.ImageVector, enabled: Boolean, tag: String, onClick: () -> Unit, danger: Boolean = false) {
    val c = appColors
    val color = (if (danger) c.error else c.ink).let { if (enabled) it else it.copy(alpha = 0.38f) }
    Column(Modifier.clip(RoundedCornerShape(16.dp)).clickable(enabled = enabled, role = Role.Button, onClick = onClick)
        .semantics(mergeDescendants = true) { testTag = tag }.widthIn(min = 64.dp).padding(horizontal = 8.dp, vertical = 6.dp),
        horizontalAlignment = Alignment.CenterHorizontally) {
        Icon(icon, null, tint = color)
        Spacer(Modifier.height(4.dp))
        Text(text, style = AppType.labelMedium, color = color)
    }
}

/** Matches as rows (Figma 4.1): Habits, then Archived; nothing listed until a letter is typed; no match offers a new habit (4.2). */
@Composable
private fun SearchResults(
    store: HabitStore, query: String, active: List<Habit>, archived: List<Habit>, today: Int,
    onRow: (Habit) -> Unit, onLong: (Habit) -> Unit, menu: @Composable (Habit, () -> Unit) -> Unit, onNew: () -> Unit,
) {
    val c = appColors
    val q = query.trim().lowercase()
    if (q.isEmpty()) return
    val found = active.filter { it.name.lowercase().contains(q) }
    val old = archived.filter { it.name.lowercase().contains(q) }
    if (found.isEmpty() && old.isEmpty()) {
        Column(Modifier.fillMaxWidth().padding(top = 72.dp, start = 32.dp, end = 32.dp), horizontalAlignment = Alignment.CenterHorizontally) {
            Text("No habits called “${query.trim()}”", style = AppType.titleMedium, color = c.ink, textAlign = TextAlign.Center)
            Spacer(Modifier.height(16.dp))
            Text("Check the spelling, or add it as a new habit.", style = AppType.bodyMedium, color = c.secondary, textAlign = TextAlign.Center)
            Spacer(Modifier.height(16.dp))
            AppButton("New habit “${query.trim()}”", onNew, style = ButtonStyle.Tonal, icon = Symbols.Add, tag = "habits-search-new")
        }
        return
    }
    LazyColumn(Modifier.fillMaxSize().padding(horizontal = 16.dp).semantics { testTag = "habits-search-results" }) {
        fun LazyListScope.group(title: String, list: List<Habit>) {
            if (list.isEmpty()) return
            item(key = "t-$title") { SectionTitle(title, title == "Habits" || found.isEmpty()) }
            list.forEachIndexed { i, h -> item(key = h.id) { HabitsRow(h, store.listLine(h, today), i, list.size, false, false, { onRow(h) }, { onLong(h) }, menu) } }
        }
        group("Habits", found)
        group("Archived", old)
        item { Spacer(Modifier.height(88.dp)) }
    }
}

/** No habits yet (Figma 1.3), or every habit archived (1.4, the Archived row kept one tap away). */
@Composable
private fun EmptyHabits(archivedCount: Int, nav: HabitsNav) {
    val c = appColors
    Column(Modifier.fillMaxSize().padding(horizontal = 16.dp)) {
        Column(Modifier.weight(1f).fillMaxWidth().padding(horizontal = 16.dp), horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.Center) {
            CookieIcon(if (archivedCount > 0) Symbols.Inventory2 else Symbols.Checklist, 112.dp)
            Spacer(Modifier.height(24.dp))
            Text(if (archivedCount > 0) "No habits right now" else "No habits yet", style = AppType.titleLarge, color = c.ink, textAlign = TextAlign.Center)
            Spacer(Modifier.height(12.dp))
            Text(if (archivedCount > 0) "Your archived habits keep all their history. Bring one back, or add a new habit."
                else "Every habit you make lives here. Add one, or start from an idea.",
                style = AppType.bodyLarge, color = c.secondary, textAlign = TextAlign.Center)
            Spacer(Modifier.height(24.dp))
            AppButton("New habit", { nav.newHabit() }, Modifier.semantics { testTag = "habits-empty-new" }, icon = Symbols.Add)
            if (archivedCount == 0) {
                Spacer(Modifier.height(8.dp))
                AppButton("Start from an idea", { nav.ideas() }, style = ButtonStyle.Tonal, icon = Symbols.Lightbulb, tag = "habits-empty-ideas")
            }
        }
        if (archivedCount > 0) {
            ArchivedRow(archivedCount, enabled = true) { nav.archived() }
            Spacer(Modifier.height(24.dp))
        }
    }
}

/** Put N habits in a group (Figma 3.3): No group, each group, New group; Cancel | Move. */
@Composable
private fun GroupDialog(habits: List<Habit>, store: HabitStore, onDismiss: () -> Unit, onMove: (String?) -> Unit) {
    val c = appColors
    val common = habits.map { store.groupOf(it.id)?.id }.distinct().singleOrNull()
    var pick by remember { mutableStateOf(common) }
    var creating by remember { mutableStateOf(false) }
    AlertDialog(onDismiss,
        title = { Text(if (habits.size == 1) "Put ${habits[0].name} in a group" else "Put ${habits.size} habits in a group") },
        text = {
            Column {
                GroupOption("No group", pick == null, "group-none") { pick = null }
                for (g in store.groups) GroupOption(g.name, pick == g.id, "group-${g.name}") { pick = g.id }
                Row(Modifier.fillMaxWidth().heightIn(min = 48.dp).clickable { creating = true }.semantics(mergeDescendants = true) { testTag = "group-new" },
                    verticalAlignment = Alignment.CenterVertically) {
                    Box(Modifier.size(40.dp), contentAlignment = Alignment.Center) { Icon(Symbols.Add, null, tint = c.ink) }
                    Spacer(Modifier.width(12.dp))
                    Text("New group", style = AppType.bodyLarge, color = c.ink)
                }
            }
        },
        confirmButton = { AppButton("Move", { onMove(pick) }, Modifier.semantics { testTag = "group-move" }, style = ButtonStyle.Text) },
        dismissButton = { AppButton("Cancel", onDismiss, style = ButtonStyle.Text) },
        containerColor = c.menu, titleContentColor = c.ink, textContentColor = c.ink)
    if (creating) NewGroupDialog(store, { creating = false }) { id -> creating = false; pick = id }
}

@Composable
private fun GroupOption(text: String, selected: Boolean, tag: String, onClick: () -> Unit) {
    val c = appColors
    Row(Modifier.fillMaxWidth().heightIn(min = 48.dp).clickable(role = Role.RadioButton, onClick = onClick).semantics(mergeDescendants = true) { testTag = tag },
        verticalAlignment = Alignment.CenterVertically) {
        RadioButton(selected, null)
        Spacer(Modifier.width(12.dp))
        Text(text, style = AppType.bodyLarge, color = c.ink)
    }
}

/** Show habits by (Figma 5.1): a simple dialog; a tap chooses, closes it and is remembered. */
@Composable
private fun ShowByDialog(store: HabitStore, current: String, onDismiss: () -> Unit, onPick: (String) -> Unit) {
    val c = appColors
    val parts = store.sections.filter { !it.isAnytime }.map { it.name } + store.section(DaySection.ANYTIME).name
    AlertDialog(onDismiss,
        title = { Text("Show habits by") },
        text = {
            Column {
                ShowByOption("Time of day", parts.joinToString(", ") + ", as on Today", current != "group", "show-by-time") { onPick("time") }
                ShowByOption("Group", store.groups.joinToString(", ") { it.name } + ", then No group", current == "group", "show-by-group") { onPick("group") }
            }
        },
        confirmButton = { AppButton("Cancel", onDismiss, style = ButtonStyle.Text) },
        containerColor = c.menu, titleContentColor = c.ink, textContentColor = c.ink)
}

@Composable
private fun ShowByOption(title: String, line: String, selected: Boolean, tag: String, onClick: () -> Unit) {
    val c = appColors
    Row(Modifier.fillMaxWidth().clickable(role = Role.RadioButton, onClick = onClick).semantics(mergeDescendants = true) { testTag = tag }.padding(vertical = 8.dp),
        verticalAlignment = Alignment.CenterVertically) {
        RadioButton(selected, null)
        Spacer(Modifier.width(12.dp))
        Column {
            Text(title, style = AppType.bodyLarge, color = c.ink)
            Text(line, style = AppType.bodyMedium, color = c.secondary)
        }
    }
}
