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
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.ArrowBack
import androidx.compose.material.icons.outlined.Archive
import androidx.compose.material.icons.outlined.Cancel
import androidx.compose.material.icons.outlined.Delete
import androidx.compose.material.icons.outlined.Edit
import androidx.compose.material.icons.outlined.PauseCircle
import androidx.compose.material.icons.outlined.PlayCircle
import androidx.compose.material.icons.outlined.Unarchive
import androidx.compose.material.icons.rounded.MoreVert
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.PrimaryTabRow
import androidx.compose.material3.Tab
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
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
import com.oftenenough.app.data.NoteMonth
import com.oftenenough.app.data.habitMilestones
import com.oftenenough.app.data.habitRecord
import com.oftenenough.app.data.history
import com.oftenenough.app.data.matchingNotes
import com.oftenenough.app.data.noteMonths
import com.oftenenough.app.data.pageSentence
import com.oftenenough.app.ui.components.CookieShape
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.TonalButton
import com.oftenenough.app.ui.newhabit.DayDialog
import com.oftenenough.app.ui.theme.appColors
import com.oftenenough.app.ui.today.addTitle

// Habit details (the iPhone's HabitPageView.swift; the user, 3 Oct 2026; research "Habit Details Research"; designs
// §11): a small header (icon, name, the goal in words, a paused banner while paused), then three jobs on tabs:
// **History** (find a day, fix an exact log), **Notes** (the habit's dated notes) and **Progress** (the record,
// milestones, week, month and year). A task has no Progress and no streak (U20). Editing, pausing, archiving and deleting
// are in the ⋮ menu. It's never the way to check off: a tap on Today's row keeps logging.

/** Where Habit details goes: the app's routes own these screens. */
interface HabitDetailsNav {
    /** Day details for [day] (a History row, Go to date, Year in Pixels' Open day). */
    fun openDay(habit: Habit, day: Int)
    /** The habit's Add screen (Add log, Add a check, Mark a day done, Tick steps, Add slip) for [day]. */
    fun addLog(habit: Habit, day: Int)
    /** The note of [day]: its view when there is one, Add note when there isn't. */
    fun note(habit: Habit, day: Int)
    fun edit(habit: Habit)
    /** The Pause… sheet. */
    fun pause(habit: Habit)
}

/** History · Notes · Progress: three jobs, one control. */
enum class HabitTab(val title: String, val tag: String) {
    HISTORY("History", "habit-tab-history"),
    NOTES("Notes", "habit-tab-notes"),
    PROGRESS("Progress", "habit-tab-progress");

    companion object {
        /** A task has no Progress: its history and notes are all there is. */
        fun tabs(habit: Habit): List<HabitTab> = if (habit.kind == HabitKind.Task) listOf(HISTORY, NOTES) else entries.toList()
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
    private var notesKey: Any? = null
    private var notes: List<NoteMonth> = emptyList()

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

    fun notes(store: HabitStore, habit: Habit, revision: Int, today: Int): List<NoteMonth> {
        val key = Triple(habit.id, revision, today)
        if (key != notesKey) { notesKey = key; notes = noteMonths(store.notes(habit), today) }
        return notes
    }
}

/** Progress's view options, shared with Today ("progress.showStreaks", "progress.showPercentages"; on unless set off). */
private const val SHOW_STREAKS = "progress.showStreaks"
private const val SHOW_PERCENTAGES = "progress.showPercentages"

@OptIn(ExperimentalMaterial3Api::class)
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
            Text("Habit deleted", Modifier.padding(16.dp), style = MaterialTheme.typography.titleLarge, color = c.secondary)
        }
        return
    }
    val revision = store.revision(habit.id)
    val today = store.today()
    val model = remember(habitId) { HabitPageModel() }
    val tabs = HabitTab.tabs(habit)
    var tab by rememberSaveable(habitId) { mutableStateOf(HabitTab.HISTORY) }
    val shown = if (tab in tabs) tab else HabitTab.HISTORY

    var menuOpen by remember { mutableStateOf(false) }
    var confirmDelete by remember { mutableStateOf(false) }
    var noRoom by remember { mutableStateOf(false) }
    var goToDate by remember { mutableStateOf(false) }
    // Opened at All milestones by a landmark's pop-up (Figma 14.1).
    var allMilestones by rememberSaveable(habitId) { mutableStateOf(HabitPageOpen.milestones == habitId.also { HabitPageOpen.milestones = null }) }
    // This visit's "What the squares mean": History and Progress share it.
    var keyShown by rememberSaveable(habitId) { mutableStateOf<Boolean?>(null) }
    val keyOpen = keyShown ?: (store.setting(HEAT_KEY_FOLDED) != "true")
    val toggleKey: () -> Unit = {
        val open = !keyOpen
        keyShown = open
        // Folding it anywhere folds it everywhere from now on; written once (S15).
        if (!open && store.setting(HEAT_KEY_FOLDED) != "true") store.saveAppSetting(HEAT_KEY_FOLDED, "true")
    }
    var historyToggled by remember(habitId) { mutableStateOf(emptySet<Int>()) }
    var notesToggled by remember(habitId) { mutableStateOf(emptySet<Int>()) }
    var query by remember(habitId) { mutableStateOf("") }
    val showStreaks = store.setting(SHOW_STREAKS) != "false"
    val showPercentages = store.setting(SHOW_PERCENTAGES) != "false"
    val sentence = remember(habit, store.sections, store.weekStart) { store.pageSentence(habit) }
    val listState = rememberLazyListState()

    val progress = if (shown == HabitTab.PROGRESS || allMilestones) model.progress(store, habit, revision, today) else null
    if (allMilestones && progress != null) {
        AllMilestonesPage(progress.second.shown(showStreaks), habit.color) { allMilestones = false }
        return
    }

    Column(Modifier.fillMaxSize().background(c.screen).semantics { testTag = "habit-details" }) {
        TopAppBar(
            title = {},
            navigationIcon = { IconButton(onBack, Modifier.semantics { testTag = "page-back" }) { Icon(Icons.AutoMirrored.Rounded.ArrowBack, "Back") } },
            actions = {
                Box {
                    IconButton({ menuOpen = true }, Modifier.semantics { testTag = "habit-menu" }) { Icon(Icons.Rounded.MoreVert, "More") }
                    HabitMenu(habit, store, today, menuOpen, onDismiss = { menuOpen = false }, nav = nav,
                        onDelete = { confirmDelete = true }, onArchive = { store.archive(listOf(habit)); onBack() },
                        onNoRoom = { noRoom = true })
                }
            },
            colors = TopAppBarDefaults.topAppBarColors(containerColor = c.screen, navigationIconContentColor = c.ink, actionIconContentColor = c.ink),
        )
        LazyColumn(Modifier.fillMaxWidth().weight(1f).semantics { testTag = "habit-details-list" }, state = listState) {
            item(key = "header") { Header(habit, sentence, store, today) }
            item(key = "tabs") {
                PrimaryTabRow(
                    selectedTabIndex = tabs.indexOf(shown),
                    modifier = Modifier.padding(bottom = 16.dp).semantics { testTag = "habit-tabs" },
                    containerColor = c.screen,
                    contentColor = c.ink,
                ) {
                    for (t in tabs) {
                        Tab(
                            selected = t == shown,
                            onClick = { tab = t },
                            modifier = Modifier.semantics { testTag = t.tag },
                            text = { Text(t.title, style = MaterialTheme.typography.titleSmall, maxLines = 1) },
                            selectedContentColor = c.ink,
                            unselectedContentColor = c.secondary,
                        )
                    }
                }
            }
            when (shown) {
                HabitTab.HISTORY -> {
                    val months = model.history(store, habit, revision, today)
                    historyItems(
                        color = habit.color, months = months, addLabel = addTitle(habit, store, today), toggled = historyToggled,
                        keyOpen = keyOpen, onToggleKey = toggleKey,
                        onToggleMonth = { first -> historyToggled = if (first in historyToggled) historyToggled - first else historyToggled + first },
                        onAdd = { nav.addLog(habit, today) }, onGoToDate = { goToDate = true }, onOpenDay = { day -> nav.openDay(habit, day) },
                    )
                }
                HabitTab.NOTES -> {
                    val months = model.notes(store, habit, revision, today)
                    notesItems(
                        months = months, shown = matchingNotes(months, query), query = query, toggled = notesToggled,
                        onQuery = { query = it },
                        onToggleMonth = { first -> notesToggled = if (first in notesToggled) notesToggled - first else notesToggled + first },
                        onAdd = { nav.note(habit, today) }, onOpen = { day -> nav.note(habit, day) },
                    )
                }
                HabitTab.PROGRESS -> {
                    val (record, milestones) = progress ?: (null to HabitMilestones.none)
                    progressItems(
                        habit = habit, store = store, today = today, revision = revision, record = record, milestones = milestones,
                        showStreaks = showStreaks, showPercentages = showPercentages, keyOpen = keyOpen, onToggleKey = toggleKey,
                        onSeeAll = { allMilestones = true }, onOpenDay = { day -> nav.openDay(habit, day) },
                        onAddSlip = { nav.addLog(habit, today) },
                    )
                }
            }
            item(key = "end") { Spacer(Modifier.navigationBarsPadding().height(8.dp)) }
        }
    }

    if (goToDate) {
        // Any day from the habit's start to today, logged or not.
        val first = minOf(if (habit.kind == HabitKind.Quit) store.rules.quitStartDay(habit) else store.rules.startDay(habit), today)
        DayDialog(today, { it in first..today }, onDismiss = { goToDate = false }) { day -> nav.openDay(habit, day) }
    }
    if (confirmDelete) {
        AlertDialog(
            onDismissRequest = { confirmDelete = false },
            title = { Text("Delete ${habit.name}?") },
            text = { Text("Its history and notes are deleted too, and this can't be undone. Archiving stops it and keeps its history.") },
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
                    if (!habit.archived) {
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

/** What the habit is, in a glance: its icon, name and goal in words, its description, and a paused banner while paused.
 *  No numbers: they belong to Progress. */
@Composable
private fun Header(habit: Habit, sentence: String, store: HabitStore, today: Int) {
    val c = appColors
    Column(Modifier.fillMaxWidth().padding(horizontal = 16.dp).padding(top = 4.dp, bottom = 16.dp).semantics { testTag = "habit-header" }) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            HabitIcon(habit.symbol, habit.color, 56.dp, CookieShape())
            Spacer(Modifier.width(16.dp))
            Column(Modifier.weight(1f).semantics(mergeDescendants = true) { heading() }) {
                Text(habit.name, style = MaterialTheme.typography.headlineMedium, color = c.ink, maxLines = 2, overflow = TextOverflow.Ellipsis)
                Text(sentence, style = MaterialTheme.typography.bodyMedium, color = c.secondary)
            }
        }
        store.descriptions[habit.id]?.takeIf { it.isNotBlank() }?.let { description ->
            Spacer(Modifier.height(12.dp))
            Text(description, style = MaterialTheme.typography.bodyLarge, color = c.ink)
        }
        val pause = store.pause(habit, today)
        if (pause != null && today in pause) {
            Spacer(Modifier.height(12.dp))
            Row(
                Modifier.fillMaxWidth().clip(RoundedCornerShape(20.dp)).background(c.surface).padding(start = 16.dp, end = 8.dp, top = 8.dp, bottom = 8.dp)
                    .semantics { testTag = "habit-paused" },
                verticalAlignment = Alignment.CenterVertically,
            ) {
                Icon(Icons.Outlined.PauseCircle, null, Modifier.size(22.dp), tint = c.ink)
                Spacer(Modifier.width(12.dp))
                Text(DayWords.paused(pause), Modifier.weight(1f), style = MaterialTheme.typography.bodyMedium, color = c.ink)
                Spacer(Modifier.width(8.dp))
                TonalButton("Resume", { store.resume(habit) }, Modifier.semantics { testTag = "habit-resume" }, height = 40.dp)
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
        DropdownMenuItem(
            text = { Text(if (habit.kind == HabitKind.Task) "Edit task" else "Edit habit", color = c.ink) },
            onClick = { onDismiss(); nav.edit(habit) },
            leadingIcon = { Icon(Icons.Outlined.Edit, null, tint = c.ink) },
            modifier = Modifier.semantics { testTag = "habit-menu-edit" },
        )
        if (store.rules.canPause(habit) || pause != null) {
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

/** Asks the next habit page to open at All milestones (the landmark pop-up's button). */
object HabitPageOpen { var milestones: String? = null }
