package com.oftenenough.app.ui.habit

import com.oftenenough.app.data.isRepeatingTask
import com.oftenenough.app.data.isOneTimeTask
import com.oftenenough.app.data.isTask
import com.oftenenough.app.data.doneEntry
import com.oftenenough.app.data.taskWhen
import com.oftenenough.app.data.repeatingLine
import com.oftenenough.app.data.taskDay
import com.oftenenough.app.data.NO_DATE_DAY
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.PaddingValues
import com.oftenenough.app.ui.components.AppDialog
import com.oftenenough.app.ui.components.AppSnackbarHost
import com.oftenenough.app.ui.components.AppMenu
import com.oftenenough.app.ui.components.AppMenuItem
import androidx.compose.ui.graphics.Color
import com.oftenenough.app.ui.components.SegmentedListGap
import com.oftenenough.app.ui.components.ListChevron
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.MenuDivider
import com.oftenenough.app.ui.components.SearchHeader
import com.oftenenough.app.ui.components.AppTopBar
import com.oftenenough.app.ui.components.StandardIconButton
import androidx.activity.compose.BackHandler
import androidx.compose.animation.animateColorAsState
import androidx.compose.foundation.background
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
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyListScope
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.SnackbarDuration
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.SnackbarResult
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.derivedStateOf
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.DaySection
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitPause
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.HeatCell
import com.oftenenough.app.data.ProgressRange
import com.oftenenough.app.data.ProgressSnapshot
import com.oftenenough.app.data.ProgressWeekCard
import com.oftenenough.app.data.archivedLine
import com.oftenenough.app.data.listLine
import com.oftenenough.app.data.title
import com.oftenenough.app.ui.components.AppConnectedButtons
import com.oftenenough.app.ui.components.EmptyState
import com.oftenenough.app.ui.components.HabitHistoryCard
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.HistoryHabitHeader
import com.oftenenough.app.ui.components.HistoryMonth
import com.oftenenough.app.ui.components.HistorySummary
import com.oftenenough.app.ui.components.HistoryWeek
import com.oftenenough.app.ui.components.HistoryYear
import com.oftenenough.app.ui.components.PrimaryTabs
import com.oftenenough.app.ui.progress.HeatKeyVisit
import com.oftenenough.app.ui.progress.ProgressRangeMemory
import com.oftenenough.app.ui.progress.QuitRunClock
import com.oftenenough.app.ui.progress.movedAnchor
import com.oftenenough.app.ui.progress.rememberProgressSnapshot
import com.oftenenough.app.ui.progress.rememberToday
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.tabular
import com.oftenenough.app.ui.theme.appColors
import com.oftenenough.app.ui.today.BackToButton
import kotlinx.coroutines.launch

/** Habits deleted from their own page (Habit details' Delete): hidden here while the snackbar offers Undo (D6). */
object PendingDelete { val ids = androidx.compose.runtime.mutableStateListOf<String>() }

interface HabitsNav {
    val openMenu: (() -> Unit)?
    /** Habit details. */
    fun open(habit: Habit)
    /** Day details for one of a habit's days (a square in Week or Month). */
    fun openDay(habit: Habit, day: Int)
    fun edit(habit: Habit)
    fun newHabit(name: String? = null)
    fun archived()
    /** Search's Add “word”: What do you want to do?, the word as the name (A72). */
    fun add(name: String)
    /** The Tasks tab's way out. */
    val tasks: TasksNav
}

/** A section of the list: its title and its habits, in the person's order. */
private class HabitSection(val key: String, val title: String, val habits: List<Habit>)

/**
 * 5.5.1, **Habits page** (Figma 986:150825; Components — Atoms Build Plan; Android A54, A55, A57): Habits & Tasks, one
 * page from the menu, scaffolded like Today on Surface container. The Top app bar (☰ · Habits & Tasks · search · +, the
 * + acting on the tab you're on), then Primary tabs Habits · Tasks, which stay.
 *
 * Habits is the Progress page (A54): Week · Month · Year (a connected button group, 16 in, 16 above and 8 below,
 * scrolling away); the period row (the dates in Title Medium On surface over "This week" in Body Small On surface
 * variant, 16 in; ‹ › at the end, › off on the latest period), which stays pinned under the tabs; then by Today's times
 * of day, Quitting and Paused, each title in Label Large Primary 16 in, the Habit history cards (4.15), 12 apart, 16
 * from the edges: a card opens Habit details, a square in Week or Month that day's Day details (Year's are too small,
 * so the card opens), its ⋮ Edit habit, Pause… (Resume when paused), Archive (Undo, no question) and Delete (asks,
 * Cancel | Delete). At the end, the Archived row and What the squares mean, 80 under them. Scrolled, the top bar, the
 * tabs and the pinned period row turn Surface container high. On an earlier period, "Back to this week" (month, year)
 * floats 16 above the gesture bar, as Today's Back to today. No habits: the empty page (New habit), with the Archived
 * row under it when every habit is archived. No selecting several, and a long press does nothing (A55).
 *
 * A habit just added (or duplicated) scrolls into view, where it goes plain at the end of its time of day (A47).
 * Speed: one snapshot, kept for the app's life, worked out a few cards a frame (S5, S16); cards are a lazy list with
 * stable keys, each card's squares one drawing (S12, S13).
 */
@Composable
fun HabitsPage(store: HabitStore, nav: HabitsNav) {
    val s = MaterialTheme.colorScheme
    val c = appColors
    val scope = rememberCoroutineScope()
    val snackbar = remember { SnackbarHostState() }
    val today = rememberToday(store)
    var tab by rememberSaveable { mutableIntStateOf(0) }
    var searching by rememberSaveable { mutableStateOf(false) }
    var query by rememberSaveable { mutableStateOf("") }
    var hidden by remember { mutableStateOf(emptySet<String>()) }
    var pausing by remember { mutableStateOf<List<Habit>>(emptyList()) }
    var deleting by remember { mutableStateOf<List<Habit>>(emptyList()) }
    /** A day in the period on screen; null means the current one, so the page always opens on it. */
    var anchor by rememberSaveable { mutableStateOf<Int?>(null) }
    val range = ProgressRangeMemory.range
    val visit = remember(store) { HeatKeyVisit(store) }

    val all = store.habits.filter { it.kind != HabitKind.Task && it.id !in hidden && it.id !in PendingDelete.ids }
    val active = all.filter { !it.archived }
    val archived = all.filter { it.archived }
    val paused = active.filter { store.isPaused(it, today) }
    val sections = remember(all, store.sections, today, store.pauses) { habitSections(store, active, paused) }
    val snap = rememberProgressSnapshot(store, range, anchor, today)

    fun say(text: String, action: String, onAction: () -> Unit) {
        scope.launch {
            snackbar.currentSnackbarData?.dismiss()
            if (snackbar.showSnackbar(text, action, duration = SnackbarDuration.Short) == SnackbarResult.ActionPerformed) onAction()
        }
    }
    fun archive(h: Habit) {
        store.archive(listOf(h))
        say("${h.name} archived", "Undo") { store.restore(h) }
    }
    fun resume(h: Habit) {
        val before = store.pauses[h.id] ?: emptyList<HabitPause>()
        store.resume(h)
        say("${h.name} resumed", "Undo") { store.setPauses(h, before) }
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
    val menu: @Composable (Habit, () -> Unit) -> Unit = { h, dismiss ->
        HabitMenuItems(h, store, today, dismiss, onEdit = { nav.edit(h) }, onPause = { pausing = listOf(h) }, onResume = { resume(h) },
            onArchive = { archive(h) }, onDelete = { deleting = listOf(h) })
    }

    BackHandler(enabled = searching) { searching = false; query = "" }

    // The list's items, by key, so a habit just added can be found and scrolled to.
    val cards = remember(snap) { snap.cards.associateBy { it.habit.id } }
    val keys = buildList {
        add("range"); add("period")
        for (sec in sections) {
            val shown = sec.habits.filter { it.id in cards }
            if (shown.isEmpty()) continue
            add("title-" + sec.key)
            shown.forEach { add("card-" + it.id) }
        }
        if (archived.isNotEmpty()) add("archived")
        add("key"); add("end")
    }
    val list = rememberLazyListState()
    val scrolled by remember(list) { derivedStateOf { list.firstVisibleItemIndex > 0 || list.firstVisibleItemScrollOffset > 0 } }
    // The period row stays under the tabs once the buttons above it have scrolled away (read through derivedStateOf: the
    // page redraws only when it comes or goes, never per scrolled pixel, S6).
    val pinned by remember(list) { derivedStateOf { list.firstVisibleItemIndex > 1 || (list.firstVisibleItemIndex == 1 && list.firstVisibleItemScrollOffset > 0) } }
    val raised = tab == 0 && !searching && active.isNotEmpty() && scrolled
    val bar by animateColorAsState(if (raised) s.surfaceContainerHigh else s.surfaceContainer, MaterialTheme.motionScheme.defaultEffectsSpec(), label = "bar")

    // A habit that wasn't here before (just added or duplicated): its card scrolls into view once it's drawn.
    var known by rememberSaveable { mutableStateOf<List<String>?>(null) }
    val activeIds = active.map { it.id }
    var pending by remember { mutableStateOf<String?>(null) }
    LaunchedEffect(activeIds) {
        val before = known
        known = activeIds
        if (before != null) activeIds.firstOrNull { it !in before }?.let { pending = it }
    }
    LaunchedEffect(pending, keys) {
        val id = pending ?: return@LaunchedEffect
        val at = keys.indexOf("card-$id")
        if (at >= 0) { pending = null; list.animateScrollToItem(at) }
    }

    Box(Modifier.fillMaxSize().background(s.surfaceContainer)) {
        Column(Modifier.fillMaxSize()) {
            if (searching) {
                SearchHeader(query, { query = it.take(40) }, onBack = { searching = false; query = "" }, "Search habits and tasks",
                    fieldTag = "habits-search-field", backTag = "habits-search-back", clearTag = "habits-search-clear")
            } else {
                AppTopBar(
                    "Habits & Tasks",
                    navigationIcon = {
                        nav.openMenu?.let { open -> IconButton(open, Modifier.semantics { testTag = "habits-menu" }) { Icon(Symbols.Menu, "Menu") } }
                    },
                    actions = {
                        IconButton({ searching = true }, Modifier.semantics { testTag = "habits-search" }) {
                            Icon(Symbols.Search, "Search habits and tasks")
                        }
                        IconButton({ if (tab == 0) nav.newHabit() else nav.tasks.newTask() }, Modifier.semantics { testTag = "habits-add" }) {
                            Icon(Symbols.Add, if (tab == 0) "New habit" else "New task")
                        }
                    },
                    containerColor = bar,
                )
                PrimaryTabs(tab, listOf("Habits", "Tasks"), { tab = it }, containerColor = bar,
                    tag = { i -> if (i == 0) "habits-tab-habits" else "habits-tab-tasks" })
            }
            Box(Modifier.weight(1f).fillMaxWidth()) {
                when {
                    searching -> PageSearch(store, query, today, sections,
                        onHabit = { h ->
                            // A habit going on: back to its card on Habits (Figma's Scrolled to Water); archived: its details.
                            if (h.archived) nav.open(h) else { searching = false; query = ""; tab = 0; pending = h.id }
                        },
                        onTask = { nav.tasks.open(it) },
                        onAdd = { nav.add(query.trim()) })
                    tab == 1 -> TasksPage(store, nav.tasks)
                    active.isEmpty() -> EmptyHabits(archived.size, nav)
                    else -> {
                        val move: (Int) -> Unit = { step -> anchor = movedAnchor(store, snap, step) }
                        LazyColumn(Modifier.fillMaxSize().semantics { testTag = "habits-list" }, state = list) {
                            items(keys, key = { it }, contentType = { it.substringBefore('-') }) { key ->
                                when {
                                    key == "range" -> AppConnectedButtons(ProgressRange.entries.map { it to it.title }, range,
                                        Modifier.padding(start = 16.dp, end = 16.dp, top = 16.dp, bottom = 8.dp), tag = "habits-range") {
                                        ProgressRangeMemory.range = it
                                    }
                                    key == "period" -> PeriodRow(snap, Color.Transparent, move)
                                    key.startsWith("title-") -> CardSectionTitle(sections.first { "title-" + it.key == key }.title, first = keys.getOrNull(2) == key)
                                    key.startsWith("card-") -> cards[key.removePrefix("card-")]?.let { card ->
                                        HabitCard(card, snap, store, nav, menu, Modifier.padding(horizontal = 16.dp, vertical = 6.dp))
                                    }
                                    key == "archived" -> Box(Modifier.padding(start = 16.dp, end = 16.dp, top = 14.dp, bottom = 6.dp)) {
                                        ArchivedRow(archived.size, enabled = true) { nav.archived() }
                                    }
                                    key == "key" -> HeatKeyCard(visit.isOpen, { visit.toggle() },
                                        Modifier.padding(start = 16.dp, end = 16.dp, top = if (archived.isEmpty()) 14.dp else 6.dp))
                                    key == "end" -> Spacer(Modifier.navigationBarsPadding().height(80.dp))
                                }
                            }
                        }
                        if (pinned) PeriodRow(snap, bar, move)
                        if (!snap.isRunning) Box(Modifier.align(Alignment.BottomCenter).navigationBarsPadding()) {
                            BackToButton("Back to this ${range.noun}", "habits-back-to-now") { anchor = null }
                        }
                    }
                }
                if (tab == 0) AppSnackbarHost(snackbar, Modifier.align(Alignment.BottomCenter).navigationBarsPadding().padding(4.dp))
            }
        }
    }

    if (pausing.isNotEmpty()) {
        val list1 = pausing
        val before = list1.associate { it.id to (store.pauses[it.id] ?: emptyList<HabitPause>()) }
        PauseSheet(list1, store, { pausing = emptyList() }) { back ->
            pausing = emptyList()
            say(pausedWords(list1, back), "Undo") { list1.forEach { h -> store.setPauses(h, before[h.id] ?: emptyList()) } }
        }
    }
    if (deleting.isNotEmpty()) {
        val h = deleting[0]
        AppDialog("Delete ${h.name}?", "Its history and notes are deleted too. To keep them, archive it instead.",
            "Delete", { deleting = emptyList(); delete(h) }, { deleting = emptyList() },
            destructive = true, confirmTag = "delete-confirm", dismissTag = "delete-cancel")
    }
}

/**
 * The period row (Figma's Period row): 56 high, 16 in at the start and 4 at the end; the dates ("18–24 Oct") in Title
 * Medium On surface over which period it is ("This week") in Body Small On surface variant, then ‹ and › (Material's
 * standard icon buttons, On surface variant; off, at 38 %, where there's nothing to go to). Pinned, it's [background].
 */
@Composable
private fun PeriodRow(snap: ProgressSnapshot, background: Color, move: (Int) -> Unit) {
    val s = MaterialTheme.colorScheme
    val noun = snap.range.noun
    Row(Modifier.fillMaxWidth().background(background).heightIn(min = 56.dp).padding(start = 16.dp, end = 4.dp),
        verticalAlignment = Alignment.CenterVertically) {
        Column(Modifier.weight(1f)) {
            Text(tabular(snap.title), Modifier.semantics { testTag = "habits-period" }, maxLines = 1,
                style = AppType.titleMedium, color = s.onSurface)
            snap.caption?.let { Text(it, maxLines = 1, style = AppType.bodySmall, color = s.onSurfaceVariant) }
        }
        StandardIconButton(Symbols.ChevronLeft, "Previous $noun", { move(-1) }, Modifier.semantics { testTag = "habits-previous" }, enabled = snap.canGoBack)
        StandardIconButton(Symbols.ChevronRight, "Next $noun", { move(1) }, Modifier.semantics { testTag = "habits-next" }, enabled = snap.canGoForward)
    }
}

/**
 * A section's title over its cards (Figma's Section): Label Large Primary, 16 in from the cards; 20 under the card
 * before it (the list's 12 and the title's 8), 16 under the period row when [first], and 12 over its first card.
 */
@Composable
private fun CardSectionTitle(text: String, first: Boolean) =
    Text(text, Modifier.padding(start = 32.dp, end = 16.dp, top = if (first) 16.dp else 14.dp, bottom = 6.dp)
        .semantics { heading(); testTag = "habits-section-$text" },
        style = AppType.labelLarge, color = MaterialTheme.colorScheme.primary)

/**
 * One habit's card: the Habit history card (4.15) with the habit's header (its icon, name, goal and ⋮), the period's
 * summary and one more fact, and the period's squares. The card opens the habit; a square of a day up to today in Week
 * or Month opens that day's details.
 */
@Composable
private fun HabitCard(card: ProgressWeekCard, snap: ProgressSnapshot, store: HabitStore, nav: HabitsNav,
                      menu: @Composable (Habit, () -> Unit) -> Unit, modifier: Modifier) {
    val habit = card.habit
    val onCell: (Int?) -> Unit = { i ->
        val d = i?.let { card.days.getOrNull(it) }
        if (d != null && d.heat != HeatCell.Blank && d.day <= snap.today) nav.openDay(habit, d.day) else nav.open(habit)
    }
    var open by remember { mutableStateOf(false) }
    HabitHistoryCard(modifier.semantics { testTag = "habits-row-" + habit.name }, onClick = { nav.open(habit) }, onClickLabel = "Opens the habit") {
        HistoryHabitHeader(habit.symbol, habit.color, habit.name, card.goal) {
            Box {
                StandardIconButton(Symbols.MoreVert, "More for ${habit.name}", { open = true }, Modifier.semantics { testTag = "habits-row-more-" + habit.name })
                AppMenu(open, { open = false }, modifier = Modifier.semantics { testTagsAsResourceId = true }) { menu(habit) { open = false } }
            }
        }
        val start = card.runStart
        if (start != null) HistorySummary(card.detail) { QuitRunClock(start, store.clock) } else HistorySummary(card.headline, card.detail)
        val todayIndex = snap.columns.indexOfFirst { it.isToday }.takeIf { it >= 0 }
        when (snap.range) {
            ProgressRange.WEEK -> if (snap.columns.size == card.heat.size)
                HistoryWeek(snap.columns.map { it.short }, card.heat, todayIndex, habit.color, onTap = onCell)
            ProgressRange.MONTH -> if (snap.columns.size == card.heat.size)
                HistoryMonth(snap.letters, snap.monthLead, card.heat, todayIndex, habit.color, onTap = onCell)
            // A year's squares are too small to aim at: a tap opens the habit.
            ProgressRange.YEAR -> snap.year?.let { year ->
                if (card.heat.size >= year.shown) HistoryYear(year, card.heat, habit.color) { nav.open(habit) }
            }
        }
    }
}

/** Sections by time of day as on Today, then Quitting; then Paused. */
private fun habitSections(store: HabitStore, active: List<Habit>, paused: List<Habit>): List<HabitSection> {
    val pausedIds = paused.map { it.id }.toSet()
    val going = active.filter { it.id !in pausedIds }
    val out = mutableListOf<HabitSection>()
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
    out += HabitSection("paused", "Paused", paused)
    return out.filter { it.habits.isNotEmpty() }
}

/** A habit's ⋮ (A54): Edit habit, Pause… or Resume, then Archive and Delete (red). */
@Composable
private fun HabitMenuItems(
    h: Habit, store: HabitStore, today: Int, dismiss: () -> Unit,
    onEdit: () -> Unit, onPause: () -> Unit, onResume: () -> Unit, onArchive: () -> Unit, onDelete: () -> Unit,
) {
    AppMenuItem("Edit habit", { dismiss(); onEdit() }, icon = Symbols.Edit, tag = "habits-menu-edit")
    if (store.isPaused(h, today)) AppMenuItem("Resume", { dismiss(); onResume() }, icon = Symbols.PlayCircle, tag = "habits-menu-resume")
    else if (store.rules.canPause(h)) AppMenuItem("Pause…", { dismiss(); onPause() }, icon = Symbols.PauseCircle, tag = "habits-menu-pause")
    MenuDivider()
    AppMenuItem("Archive", { dismiss(); onArchive() }, icon = Symbols.Archive, tag = "habits-menu-archive")
    AppMenuItem("Delete", { dismiss(); onDelete() }, icon = Symbols.Delete, destructive = true, tag = "habits-menu-delete")
}

/**
 * The Archived row (Figma's Archived, a List item on its own): inventory_2, "Archived" over its count ("3 habits"), ›,
 * on Surface container lowest; it opens Archived habits (or tasks).
 */
@Composable
internal fun ArchivedRow(count: Int, enabled: Boolean, noun: String = "habit", onClick: () -> Unit) =
    AppListItem("Archived", 0, 1, Modifier.semantics(mergeDescendants = true) {}, if (count == 1) "1 $noun" else "$count ${noun}s",
        leading = { Icon(Symbols.Inventory2, null) }, trailing = { ListChevron() }, onClick = onClick, enabled = enabled,
        containerColor = MaterialTheme.colorScheme.surfaceContainerLowest, tag = "habits-archived")

/**
 * 5.5.3, **Search page** (Figma 991:8050, Screen Start · Results · No match · Tasks only, each with the keyboard down;
 * Components — Atoms Build Plan; A59, A72): one search for the whole page, from either tab, under the Search view header
 * (1.9, "Search habits and tasks"). Nothing until a letter is typed; then 16 in, the habits that match and then the
 * tasks, each group only when something in it matches: a subheader ("4 habits") in Label Large Primary, 16 in, 8 over
 * one rounded list of two-line List items 2 apart on Surface bright (the icon in its colour, the name, a line: a
 * habit's time of day and plan or "Archived 12 Oct"; a task's day, its rhythm and next day, or "Completed Wed, 21 Oct"),
 * the tasks' group 16 under the habits'. A habit going on goes back to its card on Habits; an archived one, and a task,
 * open their details. Nothing matching: "Nothing matches “yoga”" in Title Medium and one Tonal button, Add “yoga”, which
 * opens What do you want to do? with the name filled in (the person, not the app, says what it is).
 */
@Composable
private fun PageSearch(
    store: HabitStore, query: String, today: Int, sections: List<HabitSection>,
    onHabit: (Habit) -> Unit, onTask: (Habit) -> Unit, onAdd: () -> Unit,
) {
    val s = MaterialTheme.colorScheme
    val q = query.trim().lowercase()
    if (q.isEmpty()) return
    fun hit(h: Habit) = h.name.lowercase().contains(q)
    val where = sections.flatMap { sec -> sec.habits.map { it.id to sec.title } }.toMap()
    val habits = sections.flatMap { it.habits }.filter(::hit) + store.habits.filter { it.archived && !it.isTask && hit(it) }
    val tasks = store.habits.filter { it.isTask && !it.archived && hit(it) }
        .sortedBy { if (it.isOneTimeTask && store.doneEntry(it) != null) 1 else 0 } +
        store.habits.filter { it.isTask && it.archived && hit(it) }
    if (habits.isEmpty() && tasks.isEmpty()) {
        Column(Modifier.fillMaxWidth().padding(start = 16.dp, end = 16.dp, top = 40.dp).semantics { testTag = "habits-search-none" },
            verticalArrangement = Arrangement.spacedBy(16.dp)) {
            Text("Nothing matches “${query.trim()}”", Modifier.padding(horizontal = 16.dp), style = AppType.titleMedium, color = s.onSurface)
            AppButton("Add “${query.trim()}”", onAdd, Modifier.padding(horizontal = 16.dp), style = ButtonStyle.Tonal, icon = Symbols.Add, tag = "habits-search-add")
        }
        return
    }
    fun habitLine(h: Habit): String = if (h.archived) store.archivedLine(h) else listOfNotNull(where[h.id], store.listLine(h, today)).joinToString(" · ")
    fun taskLine(t: Habit): String {
        if (t.archived) return store.archivedLine(t)
        if (t.isRepeatingTask) return store.repeatingLine(t, today)
        store.doneEntry(t)?.let { return "Completed " + taskDay(it.day) }
        val due = t.dueDay ?: return ""
        return when {
            due == NO_DATE_DAY -> "No date"
            due < today -> "Today · planned for " + taskDay(due)
            due == today -> "Today · " + store.taskWhen(t)
            else -> taskDay(due) + store.taskWhen(t).let { if (it == "Anytime") "" else " · $it" }
        }
    }
    LazyColumn(Modifier.fillMaxSize().padding(horizontal = 16.dp).semantics { testTag = "habits-search-results" },
        contentPadding = PaddingValues(top = 16.dp, bottom = 16.dp)) {
        fun LazyListScope.group(title: String, list: List<Habit>, first: Boolean, line: (Habit) -> String, open: (Habit) -> Unit, tag: String) {
            if (list.isEmpty()) return
            item(key = "t-$title") {
                Text(title, Modifier.padding(start = 16.dp, end = 16.dp, top = if (first) 0.dp else 16.dp, bottom = 8.dp)
                    .semantics { heading(); testTag = "habits-search-$tag" }, style = AppType.labelLarge, color = s.primary)
            }
            list.forEachIndexed { i, h ->
                item(key = h.id) {
                    AppListItem(h.name, i, list.size, Modifier.padding(bottom = if (i < list.lastIndex) SegmentedListGap else 0.dp), line(h),
                        leading = { HabitIcon(h.symbol, h.color) }, onClick = { open(h) }, containerColor = s.surfaceBright,
                        headlineLines = 1, tag = "habits-row-" + h.name)
                }
            }
        }
        group(if (habits.size == 1) "1 habit" else "${habits.size} habits", habits, true, ::habitLine, onHabit, "habits")
        group(if (tasks.size == 1) "1 task" else "${tasks.size} tasks", tasks, habits.isEmpty(), ::taskLine, onTask, "tasks")
    }
}

/**
 * No habits (Figma's No habits yet and All archived): the empty page, centred: the checklist in its cookie, "No habits
 * yet" (or "No habits right now") and what it means, New habit (Filled). Every habit archived: the Archived row under
 * it, 16 at the sides and 24 under.
 */
@Composable
private fun EmptyHabits(archivedCount: Int, nav: HabitsNav) {
    Column(Modifier.fillMaxSize()) {
        Box(Modifier.weight(1f).fillMaxWidth(), contentAlignment = Alignment.Center) {
            EmptyState(Symbols.Checklist,
                if (archivedCount > 0) "No habits right now" else "No habits yet",
                if (archivedCount > 0) "Every habit is archived. Restore one, or add a new habit." else "Habits you add show here, with how each one is going.",
                Modifier.semantics { testTag = "habits-empty" }) {
                AppButton("New habit", { nav.newHabit() }, Modifier.semantics { testTag = "habits-empty-new" }, icon = Symbols.Add)
            }
        }
        if (archivedCount > 0) Box(Modifier.padding(start = 16.dp, end = 16.dp, bottom = 24.dp)) {
            ArchivedRow(archivedCount, enabled = true) { nav.archived() }
        }
    }
}
