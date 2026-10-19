package com.oftenenough.app.ui.habit

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
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyListScope
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.outlined.OpenInNew
import androidx.compose.material.icons.automirrored.rounded.ArrowBack
import androidx.compose.material.icons.outlined.Archive
import androidx.compose.material.icons.outlined.Cancel
import androidx.compose.material.icons.outlined.Delete
import androidx.compose.material.icons.outlined.Edit
import androidx.compose.material.icons.outlined.PauseCircle
import androidx.compose.material.icons.outlined.PlayCircle
import androidx.compose.material.icons.outlined.Unarchive
import androidx.compose.material.icons.rounded.Add
import androidx.compose.material.icons.rounded.History
import androidx.compose.material.icons.rounded.KeyboardArrowDown
import androidx.compose.material.icons.rounded.KeyboardArrowUp
import androidx.compose.material.icons.rounded.MoreVert
import androidx.compose.material.icons.rounded.PlayArrow
import androidx.compose.material.icons.rounded.Upload
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.ExtendedFloatingActionButton
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.PrimaryTabRow
import androidx.compose.material3.Tab
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.derivedStateOf
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.runtime.withFrameNanos
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitMilestones
import com.oftenenough.app.data.HabitOverall
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.HistoryMonth
import com.oftenenough.app.data.habitMilestones
import com.oftenenough.app.data.habitRecord
import com.oftenenough.app.data.history
import com.oftenenough.app.data.pageDayDate
import com.oftenenough.app.data.pageGoalLine
import com.oftenenough.app.data.doneEntry
import com.oftenenough.app.data.isOneTimeTask
import com.oftenenough.app.data.isTask
import com.oftenenough.app.data.taskDetailsLine
import com.oftenenough.app.data.taskMoveRange
import com.oftenenough.app.data.taskOpenDay
import androidx.compose.material.icons.automirrored.outlined.Undo
import androidx.compose.material.icons.outlined.EditCalendar
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.TonalButton
import com.oftenenough.app.ui.newhabit.DayDialog
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch

// Habit details (Figma 1373:2, 19 Oct 2026; the iPhone's HabitPageView.swift): a header (icon, name, the goal in words, the
// description cut at two lines), then two jobs on tabs: **Progress** (the record, milestones, week, month and year), where
// the page opens, and **History** (every day with its logs and its note, search, Add). On scroll the name moves into a
// small top bar and the tabs stay. A task has History only, no tabs (U20). Editing, pausing, archiving and deleting are
// in the ⋮ menu. It's never the way to check off: a tap on Today's row keeps logging.

/** Where Habit details goes: the app's routes own these screens. */
interface HabitDetailsNav {
    /** Day details for [day] (a History row, Add's day, a calendar square). */
    fun openDay(habit: Habit, day: Int)
    /** The habit's Add screen (Add log, Add a check, Mark a day done, Tick steps, Add slip) for [day]. */
    fun addLog(habit: Habit, day: Int)
    /** The note of [day]: its view when there is one, Add note when there isn't. */
    fun note(habit: Habit, day: Int)
    fun edit(habit: Habit)
    /** The Pause… sheet. */
    fun pause(habit: Habit)
    /** Another habit's page: the earlier or the new one after a type change (Figma 6.3, 6.4). */
    fun openHabit(habit: Habit)
}

/** Progress · History: two jobs, one control. */
enum class HabitTab(val title: String, val tag: String) {
    PROGRESS("Progress", "habit-tab-progress"),
    HISTORY("History", "habit-tab-history");

    companion object {
        /** A task has no Progress: its history is all there is, with no tabs (Figma 6.5). */
        fun tabs(habit: Habit): List<HabitTab> = if (habit.kind == HabitKind.Task) listOf(HISTORY) else entries.toList()
    }
}

/**
 * What the page shows, worked out when the habit's data changes and kept while the page is open, so switching tabs
 * never works it out again (Rulebook S5). Each part is worked out the first time its tab is shown.
 */
private class HabitPageModel {
    private var historyKey: Any? = null
    private var history: List<HistoryMonth> = emptyList()
    private var recordKey: Any? = null
    private var record: HabitOverall? = null
    private var milestones: HabitMilestones = HabitMilestones.none

    fun history(store: HabitStore, habit: Habit, revision: Int, today: Int): List<HistoryMonth> {
        val key = Triple(habit, revision, today)
        if (key != historyKey) { historyKey = key; history = store.history(habit, today) }
        return history
    }

    /** The Overall record (null for a quit habit, which has its own card) and the milestones. */
    fun progress(store: HabitStore, habit: Habit, revision: Int, today: Int): Pair<HabitOverall?, HabitMilestones> {
        val key = Triple(habit, revision, today)
        if (key != recordKey) {
            recordKey = key
            if (habit.kind == HabitKind.Task) { record = null; milestones = HabitMilestones.none }
            else if (habit.kind == HabitKind.Quit) {
                // A quit habit's record is its own card; its milestones come from its runs alone.
                record = null
                milestones = store.habitMilestones(habit, HabitOverall("", "", "", 0, 0, "", null, null, null, "", null, emptyList(), emptySet()), today)
            } else {
                val made = store.habitRecord(habit, today)
                record = made
                milestones = store.habitMilestones(habit, made, today)
            }
        }
        return record to milestones
    }
}

/** Progress's view options, shared with Today ("progress.showStreaks", "progress.showPercentages"; on unless set off). */
private const val SHOW_STREAKS = "progress.showStreaks"
private const val SHOW_PERCENTAGES = "progress.showPercentages"

@OptIn(ExperimentalMaterial3Api::class, ExperimentalFoundationApi::class)
@Composable
fun HabitDetailsScreen(habitId: String, store: HabitStore, nav: HabitDetailsNav, onBack: () -> Unit) {
    BackHandler(onBack = onBack)
    val c = appColors
    val habit = store.habits.firstOrNull { it.id == habitId }
    if (habit == null) {
        // Deleted from another device while open.
        Column(Modifier.fillMaxSize().background(c.screen)) {
            TopAppBar(
                title = {},
                navigationIcon = { IconButton(onBack, Modifier.semantics { testTag = "page-back" }) { Icon(Icons.AutoMirrored.Rounded.ArrowBack, "Back") } },
                colors = TopAppBarDefaults.topAppBarColors(containerColor = c.screen, navigationIconContentColor = c.ink),
            )
            Text("Habit deleted", Modifier.padding(16.dp), style = AppType.titleLarge, color = c.secondary)
        }
        return
    }
    val revision = store.revision(habit.id)
    val today = store.today()
    val model = remember(habitId) { HabitPageModel() }
    val tabs = HabitTab.tabs(habit)
    // The page opens on Progress (Figma 1.1); a task has History only.
    var tab by rememberSaveable(habitId) { mutableStateOf(tabs.first()) }
    val shown = if (tab in tabs) tab else tabs.first()

    var menuOpen by remember { mutableStateOf(false) }
    var confirmDelete by remember { mutableStateOf(false) }
    var noRoom by remember { mutableStateOf(false) }
    var goToDate by remember { mutableStateOf(false) }
    var adding by remember { mutableStateOf(false) }
    var searching by rememberSaveable(habitId) { mutableStateOf(false) }
    var filter by rememberSaveable(habitId) { mutableStateOf(HistoryFilter.ALL) }
    // Opened at All milestones by a landmark's pop-up (Figma 14.1).
    var allMilestones by rememberSaveable(habitId) { mutableStateOf(HabitPageOpen.milestones == habitId.also { HabitPageOpen.milestones = null }) }
    var allStreaks by rememberSaveable(habitId) { mutableStateOf(false) }
    // This visit's "What the squares mean".
    var keyShown by rememberSaveable(habitId) { mutableStateOf<Boolean?>(null) }
    val keyOpen = keyShown ?: (store.setting(HEAT_KEY_FOLDED) != "true")
    val toggleKey: () -> Unit = {
        val open = !keyOpen
        keyShown = open
        // Folding it anywhere folds it everywhere from now on; written once (S15).
        if (!open && store.setting(HEAT_KEY_FOLDED) != "true") store.saveAppSetting(HEAT_KEY_FOLDED, "true")
    }
    var historyToggled by remember(habitId) { mutableStateOf(emptySet<Int>()) }
    val showStreaks = store.setting(SHOW_STREAKS) != "false"
    val showPercentages = store.setting(SHOW_PERCENTAGES) != "false"
    val sentence = remember(habit, store.sections, store.weekStart, today, revision, store.taskMoves) {
        if (habit.isTask) store.taskDetailsLine(habit, today) else store.pageGoalLine(habit, today)
    }
    var moving by remember { mutableStateOf(false) }
    val listState = rememberLazyListState()
    val scope = rememberCoroutineScope()
    // The header has scrolled away: its name moves into the top bar and the tabs stay under it (Figma 1.5).
    val collapsed by remember { derivedStateOf { listState.firstVisibleItemIndex > 0 } }
    // Progress's cards show their shapes for the first frame, then their numbers: the header never waits (Figma 6.7).
    var ready by remember(habitId) { mutableStateOf(false) }
    LaunchedEffect(habitId) { withFrameNanos { }; ready = true }
    val first = if (habit.kind == HabitKind.Quit) store.rules.quitStartDay(habit) else store.rules.startDay(habit)

    val progress = if ((shown == HabitTab.PROGRESS && ready) || allMilestones || allStreaks) model.progress(store, habit, revision, today) else null
    if (allMilestones && progress != null) {
        AllMilestonesPage(habit.name, progress.second.shown(showStreaks), habit.color) { allMilestones = false }
        return
    }
    if (allStreaks) {
        StreaksPage(habit, store, today, revision) { allStreaks = false }
        return
    }
    val months = if (shown == HabitTab.HISTORY && !habit.isTask) model.history(store, habit, revision, today) else emptyList()
    if (searching) {
        HistorySearchPage(months, habit.color, today, onBack = { searching = false }) { day -> nav.openDay(habit, day) }
        return
    }
    val earlier = remember(habit, store.habits) { store.earlierOf(habit.id) }
    val barColor = if (collapsed) c.tonal else c.screen
    // Another tab starts at its own top, just under the pinned tabs, wherever the last one was scrolled to.
    LaunchedEffect(shown) { if (listState.firstVisibleItemIndex > 1) listState.scrollToItem(1) }

    Box(Modifier.fillMaxSize().background(c.screen).semantics { testTag = "habit-details" }) {
        Column(Modifier.fillMaxSize()) {
            TopAppBar(
                title = { if (collapsed) Text(habit.name, maxLines = 1, overflow = TextOverflow.Ellipsis, style = AppType.titleLarge) },
                navigationIcon = { IconButton(onBack, Modifier.semantics { testTag = "page-back" }) { Icon(Icons.AutoMirrored.Rounded.ArrowBack, "Back") } },
                actions = {
                    Box {
                        IconButton({ menuOpen = true }, Modifier.semantics { testTag = "habit-menu" }) { Icon(Icons.Rounded.MoreVert, "More") }
                        if (habit.isTask) TaskMenu(habit, store, menuOpen, onDismiss = { menuOpen = false }, onEdit = { nav.edit(habit) },
                            onMove = { moving = true }, onDelete = { confirmDelete = true }, onArchive = { store.archive(listOf(habit)); onBack() })
                        else HabitMenu(habit, store, today, menuOpen, onDismiss = { menuOpen = false }, nav = nav,
                            onDelete = { confirmDelete = true }, onArchive = { store.archive(listOf(habit)); onBack() },
                            onNoRoom = { noRoom = true })
                    }
                },
                colors = TopAppBarDefaults.topAppBarColors(containerColor = barColor, titleContentColor = c.ink,
                    navigationIconContentColor = c.ink, actionIconContentColor = c.ink),
            )
            LazyColumn(Modifier.fillMaxWidth().weight(1f).semantics { testTag = "habit-details-list" }, state = listState) {
                item(key = "header") { Header(habit, sentence, store.descriptions[habit.id]) }
                if (tabs.size > 1) stickyHeader(key = "tabs") {
                    PrimaryTabRow(
                        selectedTabIndex = tabs.indexOf(shown),
                        modifier = Modifier.background(barColor).semantics { testTag = "habit-tabs" },
                        containerColor = barColor,
                        contentColor = c.ink,
                        indicator = {
                            androidx.compose.material3.TabRowDefaults.PrimaryIndicator(
                                Modifier.tabIndicatorOffset(tabs.indexOf(shown), matchContentSize = true), width = 56.dp, color = c.ink)
                        },
                        divider = { HorizontalDivider(color = c.line) },
                    ) {
                        for (t in tabs) {
                            Tab(
                                selected = t == shown,
                                onClick = { tab = t },
                                modifier = Modifier.heightIn(min = 48.dp).semantics { testTag = t.tag },
                                text = { Text(t.title, style = AppType.labelLarge, maxLines = 1) },
                                selectedContentColor = c.ink,
                                unselectedContentColor = c.secondary,
                            )
                        }
                    }
                }
                item(key = "tabs-gap") { Spacer(Modifier.height(16.dp)) }
                when (shown) {
                    HabitTab.PROGRESS -> {
                        stateCards(habit, store, today, onRestore = { if (!store.restore(habit)) noRoom = true }, onOpen = nav::openHabit)
                        if (progress == null) loadingItems()
                        else progressItems(
                            habit = habit, store = store, today = today, revision = revision, record = progress.first, milestones = progress.second,
                            showStreaks = showStreaks, showPercentages = showPercentages, keyOpen = keyOpen, onToggleKey = toggleKey,
                            onSeeAll = { allMilestones = true }, onSeeAllStreaks = { allStreaks = true }, onOpenDay = { day -> nav.openDay(habit, day) },
                            onAddSlip = { nav.addLog(habit, today) },
                        )
                    }
                    HabitTab.HISTORY -> {
                        if (earlier != null) item(key = "earlier") { EarlierCard(habit, earlier, store) { nav.openHabit(earlier) } }
                        if (habit.isTask) taskHistoryItems(store, habit, today) { day -> nav.openDay(habit, day) }
                        else historyItems(
                            color = habit.color, months = months, filter = filter, toggled = historyToggled,
                            onSearch = { searching = true }, onFilter = { filter = it }, onGoToDate = { goToDate = true },
                            onToggleMonth = { m -> historyToggled = if (m in historyToggled) historyToggled - m else historyToggled + m },
                            onOpenDay = { day -> nav.openDay(habit, day) },
                        )
                    }
                }
                // Room for Add over the last row.
                item(key = "end") { Spacer(Modifier.navigationBarsPadding().height(if (shown == HabitTab.HISTORY) 88.dp else 8.dp)) }
            }
        }
        // Add (Figma 2.1, 2.11): on History, while the habit can be logged (an archived one can't, Figma 6.2).
        if (shown == HabitTab.HISTORY && !habit.archived) {
            ExtendedFloatingActionButton({ adding = true },
                Modifier.align(Alignment.BottomEnd).navigationBarsPadding().padding(16.dp).semantics { testTag = "history-add" },
                containerColor = c.ink, contentColor = c.onInk) {
                Icon(Icons.Rounded.Add, null)
                Spacer(Modifier.width(12.dp))
                Text("Add", style = AppType.titleMedium)
            }
        }
    }

    if (adding) AddToWhichDay(habit.name, minOf(first, today), today, onDismiss = { adding = false }) { day -> nav.openDay(habit, day) }
    if (goToDate) {
        // Any day from the habit's start to today; OK scrolls History there (Figma 2.7), opening its month if folded.
        DayDialog(today, { it in minOf(first, today)..today }, onDismiss = { goToDate = false }) { day ->
            filter = HistoryFilter.ALL
            val list = model.history(store, habit, revision, today)
            val at = list.indexOfFirst { day >= it.first }
            if (at >= 0 && !historyMonthOpen(at, list[at], historyToggled)) historyToggled = historyToggled + list[at].first
            val toggled = historyToggled
            val index = historyIndexOf(day, list, toggled)
            if (index != null) {
                // The header, the tabs and the gap come first; then the earlier habit's card, if any.
                val lead = 3 + (if (earlier != null) 1 else 0)
                scope.launch { listState.animateScrollToItem(lead + index) }
            }
        }
    }
    if (confirmDelete) {
        AlertDialog(
            onDismissRequest = { confirmDelete = false },
            title = { Text("Delete ${habit.name}?") },
            text = { Text(if (habit.isTask) "Its history and notes are deleted too. To keep them, archive it instead."
                else "Its history and notes are deleted too, and this can't be undone. Archiving stops it and keeps its history.") },
            confirmButton = {
                TextButton({
                    confirmDelete = false
                    // The page leaves first, then the habit goes (U27).
                    onBack()
                    store.delete(listOf(habit))
                }, Modifier.semantics { testTag = "delete-confirm" }) { Text("Delete", color = c.error) }
            },
            dismissButton = {
                Row {
                    // A task asks with two buttons only (Tasks, Figma 3.6).
                    if (!habit.archived && !habit.isTask) {
                        TextButton({
                            confirmDelete = false
                            store.archive(listOf(habit))
                            onBack()
                        }, Modifier.semantics { testTag = "delete-archive-instead" }) { Text("Archive instead", color = c.ink) }
                    }
                    TextButton({ confirmDelete = false }, Modifier.semantics { testTag = "delete-cancel" }) { Text("Cancel", color = c.ink) }
                }
            },
            containerColor = c.surface,
            titleContentColor = c.ink,
            textContentColor = c.secondary,
        )
    }
    if (moving) {
        // Another day for a task (Figma 10): a one-time task any day from today; a repeating one's open day before its next.
        val range = store.taskMoveRange(habit, today) ?: (today..today)
        val from = store.taskOpenDay(habit, today)
        DayDialog(minOf(range.last, today + 1), { it in range && it != from }, onDismiss = { moving = false }) { day ->
            moving = false
            if (habit.isOneTimeTask) store.moveTask(habit, day) else if (from != null) store.moveOccurrence(habit, from, day)
        }
    }
    if (noRoom) {
        AlertDialog(
            onDismissRequest = { noRoom = false },
            title = { Text("No room for another habit") },
            text = { Text("The free plan keeps ${HabitStore.FREE_HABIT_LIMIT} habits going at once. Archive one, or get Plus, to bring ${habit.name} back.") },
            confirmButton = { TextButton({ noRoom = false }) { Text("OK", color = c.ink) } },
            containerColor = c.surface,
            titleContentColor = c.ink,
            textContentColor = c.secondary,
        )
    }
}

/**
 * What the habit is, in a glance (Figma 1.1–1.4): its icon, name and goal in words, then its description, cut at two
 * lines with More when longer (Less folds it again). No numbers: they belong to Progress.
 */
@Composable
private fun Header(habit: Habit, sentence: String, description: String?) {
    val c = appColors
    Column(Modifier.fillMaxWidth().padding(horizontal = 16.dp).padding(top = 4.dp, bottom = 16.dp).semantics { testTag = "habit-header" }) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            HabitIcon(habit.symbol, habit.color, 56.dp, CircleShape)
            Spacer(Modifier.width(16.dp))
            Column(Modifier.weight(1f).semantics(mergeDescendants = true) { heading() }) {
                Text(habit.name, style = AppType.headlineMedium, color = c.ink, maxLines = 2, overflow = TextOverflow.Ellipsis)
                Text(sentence, style = AppType.bodyMedium, color = c.secondary)
            }
        }
        description?.takeIf { it.isNotBlank() }?.let { text ->
            var open by rememberSaveable(habit.id) { mutableStateOf(false) }
            var cut by remember(text) { mutableStateOf(false) }
            Spacer(Modifier.height(12.dp))
            Text(text, Modifier.semantics { testTag = "habit-description" }, style = AppType.bodyLarge, color = c.ink,
                maxLines = if (open) Int.MAX_VALUE else 2, overflow = TextOverflow.Ellipsis,
                onTextLayout = { if (!open) cut = it.hasVisualOverflow })
            if (open || cut) {
                Row(
                    Modifier.padding(top = 4.dp).clip(RoundedCornerShape(8.dp)).clickable { open = !open }.heightIn(min = 40.dp)
                        .semantics(mergeDescendants = true) { testTag = "habit-description-more" },
                    verticalAlignment = Alignment.CenterVertically,
                ) {
                    Text(if (open) "Less" else "More", style = AppType.labelLarge, color = c.ink)
                    Spacer(Modifier.width(4.dp))
                    Icon(if (open) Icons.Rounded.KeyboardArrowUp else Icons.Rounded.KeyboardArrowDown, null, Modifier.size(20.dp), tint = c.ink)
                }
            }
        }
    }
}

/**
 * Progress's first card while the habit isn't running as usual (Figma 6.1, 6.2, 6.4): paused (until when, what it means,
 * Resume) or archived (when, that everything is kept, Restore; or, after a type change, a link to the new habit).
 */
private fun LazyListScope.stateCards(habit: Habit, store: HabitStore, today: Int, onRestore: () -> Unit, onOpen: (Habit) -> Unit) {
    if (habit.archived) {
        val on = store.archivedOn[habit.id]?.let { DayWords.dayMonth(it) }
        val replaced = store.replacedBy(habit.id)
        item(key = "state-archived") {
            if (replaced != null) StateCard(Icons.Outlined.Archive, "Archived" + (on?.let { " on $it" } ?: "") + ", when ${habit.name} changed to " + countedIn(replaced),
                "Everything it recorded is kept here.", "Open the new ${replaced.name}", Icons.AutoMirrored.Outlined.OpenInNew, "habit-archived") { onOpen(replaced) }
            else StateCard(Icons.Outlined.Archive, "Archived" + (on?.let { " on $it" } ?: ""),
                "Everything it recorded is kept. Restore it to log again.", "Restore", Icons.Rounded.Upload, "habit-archived", onRestore)
        }
        return
    }
    val pause = store.pause(habit, today)
    if (pause != null && today in pause) item(key = "state-paused") {
        StateCard(Icons.Outlined.PauseCircle, pause.through?.let { "Paused until " + pageDayDate(it + 1) } ?: "Paused until you resume it",
            "Nothing is expected while it's paused, and those days don't count against it.", "Resume", Icons.Rounded.PlayArrow, "habit-paused") {
            store.resume(habit)
        }
    }
}

/** History's first card after a type change (Figma 6.3): what the habit counted before, and the way to that history. */
@Composable
private fun EarlierCard(habit: Habit, earlier: Habit, store: HabitStore, onOpen: () -> Unit) {
    val on = store.archivedOn[earlier.id]
    val until = on?.let { (if (it == store.today()) "today, " else "") + DayWords.dayMonth(it) }
    StateCard(Icons.Rounded.History, "${habit.name} was counted in ${countedIn(earlier)}" + (until?.let { " until $it" } ?: ""),
        "That history stays with the earlier ${earlier.name}, in Archived habits.", "Open earlier ${earlier.name}",
        Icons.AutoMirrored.Outlined.OpenInNew, "habit-earlier", onOpen)
}

/** "glasses", "minutes", "checks", "steps": what a habit counted. */
private fun countedIn(habit: Habit): String = when (val k = habit.kind) {
    is HabitKind.Amount -> com.oftenenough.app.data.HabitCopy.unitWord(2.0, k.unit).ifEmpty { "amounts" }
    HabitKind.Duration -> "minutes"
    HabitKind.Checklist -> "steps"
    HabitKind.Quit -> "slips"
    else -> "checks"
}

/** A card with an icon, a title, what it means and one action (Figma 6.1–6.4). */
@Composable
private fun StateCard(icon: ImageVector, title: String, text: String, action: String, actionIcon: ImageVector, tag: String, onAction: () -> Unit) {
    val c = appColors
    Row(Modifier.pageItem().fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.surface).padding(20.dp).semantics { testTag = tag }) {
        Icon(icon, null, Modifier.size(24.dp), tint = c.ink)
        Spacer(Modifier.width(16.dp))
        Column(Modifier.weight(1f), verticalArrangement = Arrangement.spacedBy(4.dp)) {
            Text(title, style = AppType.titleMedium, color = c.ink)
            Text(text, style = AppType.bodyMedium, color = c.secondary)
            Spacer(Modifier.height(8.dp))
            TonalButton(action, onAction, Modifier.semantics { testTag = "$tag-action" }, icon = actionIcon, height = 40.dp)
        }
    }
}

/** The cards' shapes while the record is read (Figma 6.7): never an empty 0 shown as true. */
private fun LazyListScope.loadingItems() {
    item(key = "loading") {
        val c = appColors
        Column(Modifier.semantics { testTag = "habit-loading" }) {
            Column(Modifier.pageItem().fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.surface).padding(20.dp),
                verticalArrangement = Arrangement.spacedBy(12.dp)) {
                Box(Modifier.width(120.dp).height(20.dp).clip(RoundedCornerShape(6.dp)).background(c.tonal))
                Box(Modifier.width(180.dp).height(40.dp).clip(RoundedCornerShape(8.dp)).background(c.tonal))
                for (row in 0..1) Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    Box(Modifier.weight(1f).height(100.dp).clip(RoundedCornerShape(20.dp)).background(c.tonal))
                    Box(Modifier.weight(1f).height(100.dp).clip(RoundedCornerShape(20.dp)).background(c.tonal))
                }
            }
            Column(Modifier.pageItem().fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.surface).padding(20.dp),
                verticalArrangement = Arrangement.spacedBy(16.dp)) {
                Box(Modifier.width(110.dp).height(20.dp).clip(RoundedCornerShape(6.dp)).background(c.tonal))
                Box(Modifier.fillMaxWidth().height(8.dp).clip(RoundedCornerShape(4.dp)).background(c.tonal))
            }
        }
    }
}

/** Editing the habit, pausing, archiving and deleting: less frequent actions in the ⋮ menu. Logs are corrected in History,
 *  notes with the note. */
@Composable
private fun HabitMenu(
    habit: Habit, store: HabitStore, today: Int, expanded: Boolean, onDismiss: () -> Unit, nav: HabitDetailsNav,
    onDelete: () -> Unit, onArchive: () -> Unit, onNoRoom: () -> Unit,
) {
    val c = appColors
    val pause = store.pause(habit, today)
    DropdownMenu(expanded, onDismiss, containerColor = c.surface) {
        // An archived habit's ⋮ holds Restore and Delete habit… only (Habits, Figma 6.6).
        if (!habit.archived) DropdownMenuItem(
            text = { Text(if (habit.kind == HabitKind.Task) "Edit task" else "Edit habit", color = c.ink) },
            onClick = { onDismiss(); nav.edit(habit) },
            leadingIcon = { Icon(Icons.Outlined.Edit, null, tint = c.ink) },
            modifier = Modifier.semantics { testTag = "habit-menu-edit" },
        )
        if (!habit.archived && (store.rules.canPause(habit) || pause != null)) {
            if (pause != null && today in pause) {
                DropdownMenuItem(
                    text = { Text("Resume", color = c.ink) },
                    onClick = { onDismiss(); store.resume(habit) },
                    leadingIcon = { Icon(Icons.Outlined.PlayCircle, null, tint = c.ink) },
                    modifier = Modifier.semantics { testTag = "habit-menu-resume" },
                )
            } else if (pause != null) {
                DropdownMenuItem(
                    text = { Text("Cancel pause from " + DayWords.short(pause.from), color = c.ink) },
                    onClick = { onDismiss(); store.resume(habit) },
                    leadingIcon = { Icon(Icons.Outlined.Cancel, null, tint = c.ink) },
                    modifier = Modifier.semantics { testTag = "habit-menu-cancel-pause" },
                )
            } else {
                DropdownMenuItem(
                    text = { Text("Pause…", color = c.ink) },
                    onClick = { onDismiss(); nav.pause(habit) },
                    leadingIcon = { Icon(Icons.Outlined.PauseCircle, null, tint = c.ink) },
                    modifier = Modifier.semantics { testTag = "habit-menu-pause" },
                )
            }
        }
        if (habit.archived) {
            DropdownMenuItem(
                text = { Text("Restore", color = c.ink) },
                onClick = { onDismiss(); if (!store.restore(habit)) onNoRoom() },
                leadingIcon = { Icon(Icons.Outlined.Unarchive, null, tint = c.ink) },
                modifier = Modifier.semantics { testTag = "habit-menu-restore" },
            )
        } else {
            DropdownMenuItem(
                text = { Text("Archive", color = c.ink) },
                onClick = { onDismiss(); onArchive() },
                leadingIcon = { Icon(Icons.Outlined.Archive, null, tint = c.ink) },
                modifier = Modifier.semantics { testTag = "habit-menu-archive" },
            )
        }
        HorizontalDivider(color = c.tonal)
        DropdownMenuItem(
            text = { Text("Delete", color = c.error) },
            onClick = { onDismiss(); onDelete() },
            leadingIcon = { Icon(Icons.Outlined.Delete, null, tint = c.error) },
            modifier = Modifier.semantics { testTag = "habit-menu-delete" },
        )
    }
}

/**
 * A task's ⋮ (Tasks, Figma 10, 8.6, 9.4): Edit task, Move to another day…, Mark as not done once a one-time task is done,
 * Archive, Delete task…; archived: Restore and Delete task….
 */
@Composable
private fun TaskMenu(
    task: Habit, store: HabitStore, expanded: Boolean, onDismiss: () -> Unit, onEdit: () -> Unit, onMove: () -> Unit,
    onDelete: () -> Unit, onArchive: () -> Unit,
) {
    val c = appColors
    val done = if (task.isOneTimeTask) store.doneEntry(task) else null
    @Composable
    fun item(text: String, icon: androidx.compose.ui.graphics.vector.ImageVector, tag: String, danger: Boolean = false, act: () -> Unit) =
        DropdownMenuItem(text = { Text(text, color = if (danger) c.error else c.ink) }, onClick = { onDismiss(); act() },
            leadingIcon = { Icon(icon, null, tint = if (danger) c.error else c.ink) }, modifier = Modifier.semantics { testTag = tag })
    DropdownMenu(expanded, onDismiss, containerColor = c.surface) {
        if (task.archived) item("Restore", Icons.Outlined.Unarchive, "habit-menu-restore") { store.restore(task) }
        else {
            item("Edit task", Icons.Outlined.Edit, "habit-menu-edit", act = onEdit)
            if (done != null) item("Mark as not done", Icons.AutoMirrored.Outlined.Undo, "habit-menu-not-done") { store.undoEntry(done.id) }
            else if (store.taskMoveRange(task, store.today()) != null)
                item("Move to another day…", Icons.Outlined.EditCalendar, "habit-menu-move", act = onMove)
            item("Archive", Icons.Outlined.Archive, "habit-menu-archive", act = onArchive)
        }
        HorizontalDivider(color = c.tonal)
        item("Delete task…", Icons.Outlined.Delete, "habit-menu-delete", danger = true, act = onDelete)
    }
}

/** Asks the next habit page to open at All milestones (the landmark pop-up's button). */
object HabitPageOpen { var milestones: String? = null }
