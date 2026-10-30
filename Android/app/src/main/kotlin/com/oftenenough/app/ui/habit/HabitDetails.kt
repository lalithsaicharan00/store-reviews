package com.oftenenough.app.ui.habit

import com.oftenenough.app.ui.components.AppDialog
import com.oftenenough.app.ui.components.AppSnackbarHost
import com.oftenenough.app.ui.components.ButtonSize
import com.oftenenough.app.ui.components.CardNotice
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.SnackbarDuration
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.SnackbarResult
import com.oftenenough.app.data.HabitColor
import androidx.compose.foundation.layout.ColumnScope
import com.oftenenough.app.ui.components.Skeleton
import com.oftenenough.app.ui.components.AppMenuItem
import com.oftenenough.app.ui.components.AppMenu
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.AppExtendedFab
import com.oftenenough.app.ui.components.MenuDivider
import com.oftenenough.app.ui.components.PrimaryTabs
import com.oftenenough.app.ui.components.scrolledTopBarColor
import com.oftenenough.app.ui.components.AppTopBar
import androidx.activity.compose.BackHandler
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
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
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Text
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
import com.oftenenough.app.data.isTask
import com.oftenenough.app.ui.components.HabitIcon
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
    /** The habit's Add screen (Add log or Add slip) for [day]. */
    fun addLog(habit: Habit, day: Int)
    /** The note of [day]: its view when there is one, Add note when there isn't. */
    fun note(habit: Habit, day: Int)
    fun edit(habit: Habit)
    /** The Pause… sheet. */
    fun pause(habit: Habit)
    /** Another habit's page: the earlier or the new one after a type change (Figma 6.3, 6.4). */
    fun openHabit(habit: Habit)
    /** Delete, confirmed: the page closes and the page under it says "Water deleted" with Undo; it goes once Undo has
     *  (Figma's Delete flow, D6). */
    fun deleted(habit: Habit)
    /** A task's Duplicate: New task, filled in from it. */
    fun duplicate(habit: Habit)
    /** The Plus screen, from the free plan's locked Year in pixels card (Reason=Year in Pixels, A73). */
    fun plus()
}

/** Progress · History: two jobs, one control. */
enum class HabitTab(val title: String, val tag: String) {
    PROGRESS("Progress", "habit-tab-progress"),
    HISTORY("History", "habit-tab-history");
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
            AppTopBar(
                null,
                navigationIcon = { IconButton(onBack, Modifier.semantics { testTag = "page-back" }) { Icon(Symbols.ArrowBack, "Back") } },
            )
            Text("Habit deleted", Modifier.padding(16.dp), style = AppType.titleLarge, color = c.secondary)
        }
        return
    }
    // A task has its own page, with no tabs: only its days (5.6.5). A type never changes (A68), so neither does the page.
    if (habit.isTask) { TaskDetailsScreen(habit, store, nav, onBack); return }
    val revision = store.revision(habit.id)
    val today = store.today()
    val model = remember(habitId) { HabitPageModel() }
    val tabs = HabitTab.entries
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
    var howMilestones by rememberSaveable(habitId) { mutableStateOf(false) }
    // "What the squares mean" starts folded (Figma's details pages: "it stays folded everywhere"); open for this visit only.
    var keyOpen by rememberSaveable(habitId) { mutableStateOf(false) }
    val toggleKey: () -> Unit = { keyOpen = !keyOpen }
    var historyToggled by remember(habitId) { mutableStateOf(emptySet<Int>()) }
    val showStreaks = store.setting(SHOW_STREAKS) != "false"
    val showPercentages = store.setting(SHOW_PERCENTAGES) != "false"
    val sentence = remember(habit, store.sections, store.weekStart, today, revision) { store.pageGoalLine(habit) }
    // Go to date's day, lit in the habit's colour for a moment (Figma 2.7, "History · gone to a date").
    var lit by remember(habitId) { mutableStateOf<Int?>(null) }
    val listState = rememberLazyListState()
    val scope = rememberCoroutineScope()
    val snackbar = remember { SnackbarHostState() }
    fun archive() {
        // Archive never asks first (Figma): the page stays, now archived, and says so with Undo.
        store.archive(listOf(habit))
        scope.launch {
            snackbar.currentSnackbarData?.dismiss()
            if (snackbar.showSnackbar("${habit.name} archived", "Undo", duration = SnackbarDuration.Short) == SnackbarResult.ActionPerformed) {
                store.habit(habit.id)?.let { store.restore(it) }
            }
        }
    }
    // The header has scrolled away: its name moves into the top bar and the tabs stay under it (Figma 1.5).
    val collapsed by remember { derivedStateOf { listState.firstVisibleItemIndex > 0 } }
    // Progress's cards show their shapes for the first frame, then their numbers: the header never waits (Figma 6.7).
    var ready by remember(habitId) { mutableStateOf(false) }
    LaunchedEffect(habitId) { withFrameNanos { }; ready = true }
    val first = if (habit.kind == HabitKind.Quit) store.rules.quitStartDay(habit) else store.rules.startDay(habit)

    val progress = if ((shown == HabitTab.PROGRESS && ready) || allMilestones || allStreaks) model.progress(store, habit, revision, today) else null
    if (howMilestones) {
        // Over All milestones: ← goes back there.
        HowMilestonesWorkPage(habit.kind == HabitKind.Quit || habit.atMost) { howMilestones = false }
        return
    }
    if (allMilestones && progress != null) {
        AllMilestonesPage(habit.name, progress.second.shown(showStreaks), habit.color, onHowTheyWork = { howMilestones = true }) { allMilestones = false }
        return
    }
    if (allStreaks) {
        StreaksPage(habit, store, today, revision) { allStreaks = false }
        return
    }
    val months = if (shown == HabitTab.HISTORY) model.history(store, habit, revision, today) else emptyList()
    if (searching) {
        HistorySearchPage(habit.name, months, habit.color, onBack = { searching = false }) { day -> nav.openDay(habit, day) }
        return
    }
    val earlier = remember(habit, store.habits) { store.earlierOf(habit.id) }
    val barColor = if (collapsed) scrolledTopBarColor else MaterialTheme.colorScheme.surfaceContainer
    val fresh = !habit.archived && store.entries(habit.id).isEmpty()
    // Another tab starts at its own top, just under the pinned tabs, wherever the last one was scrolled to.
    LaunchedEffect(shown) { if (listState.firstVisibleItemIndex > 1) listState.scrollToItem(1) }

    Box(Modifier.fillMaxSize().background(MaterialTheme.colorScheme.surfaceContainer).semantics { testTag = "habit-details" }) {
        Column(Modifier.fillMaxSize()) {
            AppTopBar(
                if (collapsed) habit.name else null,
                navigationIcon = { IconButton(onBack, Modifier.semantics { testTag = "page-back" }) { Icon(Symbols.ArrowBack, "Back") } },
                actions = {
                    Box {
                        IconButton({ menuOpen = true }, Modifier.semantics { testTag = "habit-menu" }) { Icon(Symbols.MoreVert, "More") }
                        HabitMenu(habit, store, today, menuOpen, onDismiss = { menuOpen = false }, nav = nav,
                            onDelete = { confirmDelete = true }, onArchive = ::archive,
                            onNoRoom = { noRoom = true })
                    }
                },
                containerColor = barColor,
            )
            LazyColumn(Modifier.fillMaxWidth().weight(1f).semantics { testTag = "habit-details-list" }, state = listState) {
                item(key = "header") { Header(habit, sentence, store.descriptions[habit.id]) }
                if (tabs.size > 1) stickyHeader(key = "tabs") {
                    PrimaryTabs(tabs.indexOf(shown), tabs.map { it.title }, { tab = tabs[it] },
                        Modifier.semantics { testTag = "habit-tabs" }, containerColor = barColor, tag = { tabs[it].tag })
                }
                item(key = "tabs-gap") { Spacer(Modifier.height(16.dp)) }
                when (shown) {
                    HabitTab.PROGRESS -> {
                        stateCards(habit, store, today, onRestore = { if (!store.restore(habit)) noRoom = true }, onOpen = nav::openHabit)
                        if (progress == null) loadingItems(habit.color, keyOpen, toggleKey)
                        else if (fresh) freshItems(habit, store, today, revision, keyOpen, toggleKey) { day -> nav.openDay(habit, day) }
                        else progressItems(
                            habit = habit, store = store, today = today, revision = revision, record = progress.first, milestones = progress.second,
                            showStreaks = showStreaks, showPercentages = showPercentages, keyOpen = keyOpen, onToggleKey = toggleKey,
                            onSeeAll = { allMilestones = true }, onSeeAllStreaks = { allStreaks = true }, onOpenDay = { day -> nav.openDay(habit, day) },
                            onAddSlip = { nav.addLog(habit, today) }, onPlus = nav::plus,
                        )
                    }
                    HabitTab.HISTORY -> {
                        if (earlier != null) item(key = "earlier") { EarlierCard(habit, earlier, store) { nav.openHabit(earlier) } }
                        historyItems(
                            color = habit.color, months = months, filter = filter, toggled = historyToggled,
                            onSearch = { searching = true }, onFilter = { filter = it }, onGoToDate = { goToDate = true },
                            onToggleMonth = { m -> historyToggled = if (m in historyToggled) historyToggled - m else historyToggled + m },
                            onOpenDay = { day -> nav.openDay(habit, day) }, lit = lit,
                        )
                    }
                }
                // Room for Add over the last row.
                item(key = "end") { Spacer(Modifier.navigationBarsPadding().height(if (shown == HabitTab.HISTORY) 88.dp else 8.dp)) }
            }
        }
        // Add (Figma 2.1, 2.11): on History, while the habit can be logged (an archived one can't, Figma 6.2).
        if (shown == HabitTab.HISTORY && !habit.archived) {
            AppExtendedFab("Add", Symbols.Add, { adding = true },
                Modifier.align(Alignment.BottomEnd).navigationBarsPadding().padding(16.dp), tag = "history-add")
        }
        AppSnackbarHost(snackbar, Modifier.align(Alignment.BottomCenter).navigationBarsPadding().padding(4.dp))
    }

    if (adding) AddToWhichDay(minOf(first, today), today, onDismiss = { adding = false }) { day -> nav.openDay(habit, day) }
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
                lit = day
            }
        }
    }
    if (confirmDelete) {
        AppDialog("Delete ${habit.name}?",
            "Its logs, notes, streaks and milestones go too. To keep them, archive it instead: Archive is in the same menu.",
            "Delete", {
                confirmDelete = false
                // The page leaves first (U27); the page under it deletes once its Undo has gone.
                nav.deleted(habit)
            }, { confirmDelete = false }, destructive = true, confirmTag = "delete-confirm", dismissTag = "delete-cancel")
    }
    if (noRoom) {
        AppDialog("No room for another habit",
            "The free plan keeps ${HabitStore.FREE_HABIT_LIMIT} habits going at once. Archive one, or get Plus, to bring ${habit.name} back.",
            "OK", { noRoom = false }, { noRoom = false }, dismiss = null)
    }
}

/**
 * What the habit is, in a glance (Figma's Large title · habit, 1020:4052): its icon (56, the habit's colour), 16, its name
 * in Headline Medium Emphasized over the goal and time of day in Body Medium On surface variant ("8 glasses a day |
 * Anytime"), 16 at the sides and under. A description follows, 12 under, in Body Medium On surface variant, two lines at
 * most, then More (a Text button, its label lined up with the words); More opens the whole of it in place, Less folds
 * it again. No numbers: they belong to Progress. On scroll the name moves into the top bar.
 */
@Composable
private fun Header(habit: Habit, sentence: String, description: String?) {
    val s = MaterialTheme.colorScheme
    val text = description?.takeIf { it.isNotBlank() }
    Column(Modifier.fillMaxWidth().semantics { testTag = "habit-header" }) {
        Row(Modifier.padding(start = 16.dp, end = 16.dp, bottom = if (text != null) 12.dp else 16.dp), verticalAlignment = Alignment.CenterVertically) {
            HabitIcon(habit.symbol, habit.color, 56.dp, CircleShape, glyph = 0.5f)
            Spacer(Modifier.width(16.dp))
            Column(Modifier.weight(1f).semantics(mergeDescendants = true) { heading() }) {
                Text(habit.name, style = AppType.headlineMediumEmphasized, color = s.onSurface, maxLines = 2, overflow = TextOverflow.Ellipsis)
                Text(sentence, style = AppType.bodyMedium, color = s.onSurfaceVariant)
            }
        }
        if (text != null) {
            var open by rememberSaveable(habit.id) { mutableStateOf(false) }
            var cut by remember(text) { mutableStateOf(false) }
            Text(text, Modifier.padding(horizontal = 16.dp).semantics { testTag = "habit-description" }, style = AppType.bodyMedium, color = s.onSurfaceVariant,
                maxLines = if (open) Int.MAX_VALUE else 2, overflow = TextOverflow.Ellipsis,
                onTextLayout = { if (!open) cut = it.hasVisualOverflow })
            if (open || cut) {
                // The Text button's 12 of padding, from 4 in: its label starts where the words do.
                Row(Modifier.padding(start = 4.dp, bottom = 8.dp).heightIn(min = 48.dp), verticalAlignment = Alignment.CenterVertically) {
                    AppButton(if (open) "Less" else "More", { open = !open }, style = ButtonStyle.Text, size = ButtonSize.Small, tag = "habit-description-more")
                }
            } else Spacer(Modifier.height(16.dp))
        }
    }
}

/**
 * Progress's first card while the habit isn't running as usual (Figma: Archived notice, the Paused flow): the Card
 * notice (4.7): archived ("Archived today", that everything is kept, Restore; or, after a type change, a link to the new
 * habit) or paused (until when, what it means, Resume).
 */
private fun LazyListScope.stateCards(habit: Habit, store: HabitStore, today: Int, onRestore: () -> Unit, onOpen: (Habit) -> Unit) {
    if (habit.archived) {
        val on = store.archivedOn[habit.id]?.let { if (it == today) "today" else DayWords.dayMonth(it) }
        val replaced = store.replacedBy(habit.id)
        item(key = "state-archived") {
            if (replaced != null) CardNotice(Symbols.Archive, "Archived" + (on?.let { " $it" } ?: "") + ", when ${habit.name} changed to " + countedIn(replaced),
                "Everything it recorded is kept here.", Modifier.pageItem(), action = "Open the new ${replaced.name}", onAction = { onOpen(replaced) },
                actionTag = "habit-archived-action", tag = "habit-archived")
            else CardNotice(Symbols.Archive, "Archived" + (on?.let { " $it" } ?: ""), "Everything it recorded is kept. Restore it to log again.",
                Modifier.pageItem(), action = "Restore", onAction = onRestore, actionTag = "habit-archived-action", tag = "habit-archived")
        }
        return
    }
    val pause = store.pause(habit, today)
    if (pause != null && today in pause) item(key = "state-paused") {
        CardNotice(Symbols.PauseCircle, pause.through?.let { "Paused until " + pageDayDate(it + 1) } ?: "Paused until you resume it",
            "Off Today, no reminders. Paused days don’t count.", Modifier.pageItem(), action = "Resume", onAction = { store.resume(habit) },
            actionTag = "habit-paused-action", tag = "habit-paused")
    }
}

/** History's first card after a type change (Figma 6.3): what the habit counted before, and the way to that history. */
@Composable
private fun EarlierCard(habit: Habit, earlier: Habit, store: HabitStore, onOpen: () -> Unit) {
    val on = store.archivedOn[earlier.id]
    val until = on?.let { (if (it == store.today()) "today, " else "") + DayWords.dayMonth(it) }
    CardNotice(Symbols.History, "${habit.name} was counted in ${countedIn(earlier)}" + (until?.let { " until $it" } ?: ""),
        "That history stays with the earlier ${earlier.name}, in Archived habits.", Modifier.pageItem(), action = "Open earlier ${earlier.name}",
        onAction = onOpen, actionTag = "habit-earlier-action", tag = "habit-earlier")
}

/** "glasses", "minutes", "checks", "steps": what a habit counted. */
private fun countedIn(habit: Habit): String = when (val k = habit.kind) {
    is HabitKind.Amount -> com.oftenenough.app.data.HabitCopy.unitWord(2.0, k.unit).ifEmpty { "amounts" }
    HabitKind.Duration -> "minutes"
    HabitKind.Checklist -> "steps"
    HabitKind.Quit -> "slips"
    else -> "checks"
}

/**
 * The cards' shapes while the record is read (Figma's Progress, Loading): Overall record, Milestones, What the squares
 * mean (the real card), Week and Month, each drawn in Skeletons (3.4); never an empty 0 shown as true.
 */
private fun LazyListScope.loadingItems(color: HabitColor, keyOpen: Boolean, onToggleKey: () -> Unit) {
    item(key = "loading") {
        Column(Modifier.semantics { testTag = "habit-loading" }) {
            LoadingCard {
                Skeleton(Modifier.size(120.dp, 20.dp))
                Skeleton(Modifier.size(180.dp, 40.dp))
                repeat(2) {
                    Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                        repeat(2) { Skeleton(Modifier.weight(1f).height(96.dp), RoundedCornerShape(16.dp)) }
                    }
                }
            }
            LoadingCard {
                Skeleton(Modifier.size(110.dp, 20.dp))
                Skeleton(Modifier.fillMaxWidth().height(104.dp), RoundedCornerShape(20.dp))
                Row(Modifier.fillMaxWidth().padding(horizontal = 20.dp), horizontalArrangement = Arrangement.SpaceBetween) {
                    repeat(3) { Skeleton(Modifier.size(52.dp), CircleShape) }
                }
            }
            HabitKeyCard(keyOpen, onToggleKey, color, Modifier.pageItem())
            repeat(2) {
                LoadingCard {
                    Skeleton(Modifier.size(100.dp, 20.dp))
                    Skeleton(Modifier.size(200.dp, 28.dp))
                    Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) { repeat(7) { Skeleton(Modifier.weight(1f).height(36.dp)) } }
                }
            }
        }
    }
}

/** One loading card: the page's white card, 24 corners, 20 inside, its pieces 12 apart. */
@Composable
private fun LoadingCard(content: @Composable ColumnScope.() -> Unit) =
    Column(Modifier.pageItem().fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(appColors.surface).padding(20.dp),
        verticalArrangement = Arrangement.spacedBy(12.dp), content = content)

/** Editing the habit, pausing, archiving and deleting: less frequent actions in the ⋮ menu. Logs are corrected in History,
 *  notes with the note. */
@Composable
private fun HabitMenu(
    habit: Habit, store: HabitStore, today: Int, expanded: Boolean, onDismiss: () -> Unit, nav: HabitDetailsNav,
    onDelete: () -> Unit, onArchive: () -> Unit, onNoRoom: () -> Unit,
) {
    val pause = store.pause(habit, today)
    @Composable
    fun item(text: String, icon: ImageVector, tag: String, danger: Boolean = false, act: () -> Unit) =
        AppMenuItem(text, { onDismiss(); act() }, icon = icon, destructive = danger, tag = tag)
    AppMenu(expanded, onDismiss) {
        // An archived habit's ⋮ holds Restore and Delete habit… only (Habits, Figma 6.6).
        if (!habit.archived) item("Edit habit", Symbols.Edit, "habit-menu-edit") { nav.edit(habit) }
        if (!habit.archived && (store.rules.canPause(habit) || pause != null)) {
            if (pause != null && today in pause) item("Resume", Symbols.PlayCircle, "habit-menu-resume") { store.resume(habit) }
            else if (pause != null) item("Cancel pause from " + DayWords.short(pause.from), Symbols.Cancel, "habit-menu-cancel-pause") { store.resume(habit) }
            else item("Pause…", Symbols.PauseCircle, "habit-menu-pause") { nav.pause(habit) }
        }
        // Figma's ⋮: Edit habit, Pause…, a line, Archive, Delete (red); archived: Restore and Delete.
        if (habit.archived) item("Restore", Symbols.Unarchive, "habit-menu-restore") { if (!store.restore(habit)) onNoRoom() }
        else { MenuDivider(); item("Archive", Symbols.Archive, "habit-menu-archive", act = onArchive) }
        item("Delete", Symbols.Delete, "habit-menu-delete", danger = true, act = onDelete)
    }
}

/** Asks the next habit page to open at All milestones (the landmark pop-up's button). */
object HabitPageOpen { var milestones: String? = null }
