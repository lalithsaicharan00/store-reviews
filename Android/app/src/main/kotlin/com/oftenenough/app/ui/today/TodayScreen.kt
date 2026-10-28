package com.oftenenough.app.ui.today

import com.oftenenough.app.ui.components.MilestonePopup
import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.EnterTransition
import androidx.compose.animation.ExitTransition
import androidx.compose.animation.core.MutableTransitionState
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.animation.slideInVertically
import androidx.compose.animation.slideOutVertically
import androidx.compose.runtime.key
import androidx.compose.ui.platform.LocalDensity
import com.oftenenough.app.ui.components.MilestoneBar
import com.oftenenough.app.ui.components.animationsOn
import com.oftenenough.app.ui.components.SectionHabit
import com.oftenenough.app.ui.components.SectionHeader
import com.oftenenough.app.ui.components.AppSnackbarHost
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.AppTopBar
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
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
import androidx.compose.material3.DatePicker
import androidx.compose.material3.DatePickerDialog
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.ExperimentalMaterial3ExpressiveApi
import androidx.compose.material3.IconButton
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Snackbar
import androidx.compose.material3.SnackbarDuration
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.SnackbarResult
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.rememberDatePickerState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import com.oftenenough.app.app.Prefs
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.DaySection
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.Placement
import com.oftenenough.app.ui.components.CookieIcon
import com.oftenenough.app.ui.components.DayNavigation
import com.oftenenough.app.ui.components.segmentShape
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import java.time.Instant
import java.time.LocalDate
import java.time.ZoneOffset
import androidx.compose.foundation.gestures.awaitEachGesture
import androidx.compose.foundation.gestures.awaitFirstDown
import androidx.compose.ui.input.pointer.PointerEventPass
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.layout.boundsInRoot
import androidx.compose.ui.layout.onGloballyPositioned
import com.oftenenough.app.data.MilestoneCenter
import com.oftenenough.app.data.MilestoneShown
import com.oftenenough.app.data.MilestoneTier
import com.oftenenough.app.data.MilestoneTrack
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

/** What Today's top bar and empty states open. */
interface TodayNav : NoticeNav {
    fun openMenu()
    fun newHabit()
    fun ideas()
    fun restore()
    fun help()
    fun arrange()
    fun newGroup()
    fun editGroups()
    fun startRoutine(part: String, day: Int, habits: List<Habit>)
    /** The Habits page, where archived habits are (the start-over snackbar's View, Figma 6.3.2). */
    fun archivedHabits() {}
}

/** "Starts 6 AM". */
fun startsText(section: DaySection): String? = section.start?.let { "Starts " + DayWords.hourShort(it) }

/** A habit as a folded section header draws it: a disc of its Colour with its filled icon. */
private fun Habit.inSection() = SectionHabit(name, symbol, color)

/** Today's day: moves on at the day's start and once a minute (the Now section), never per second (S3). */
@Composable
private fun rememberNow(store: HabitStore): Long {
    var now by remember { mutableStateOf(store.clock()) }
    LaunchedEffect(Unit) {
        while (true) {
            val t = store.clock()
            now = t
            delay(60_000 - t % 60_000)
        }
    }
    return now
}

/**
 * The home screen (Figma `1260:2`, "Today"): one card per time of day, then Quitting and Paused; the day bar floats at
 * the bottom over a fade. Light is Figma's; dark is the same layout in the app's dark colours.
 */
@OptIn(ExperimentalMaterial3Api::class, ExperimentalMaterial3ExpressiveApi::class)
@Composable
fun TodayScreen(store: HabitStore, prefs: Prefs, nav: TodayNav, appActions: TodayActions, snackbar: SnackbarHostState, kept: TodayLayout? = null) {
    val c = appColors
    // A milestone's pop-up, asked for from its band or its bar's See (never counted against the day's limits).
    var popup by remember { mutableStateOf<MilestoneShown?>(null) }
    val actions = remember(appActions) {
        object : TodayActions by appActions {
            override fun seeMilestone(habit: Habit) { popup = store.milestones.shown(habit.id) }
        }
    }
    val now = rememberNow(store)
    val today = store.today(now)
    var shownDay by rememberSaveable { mutableStateOf<Int?>(null) }
    val day = shownDay ?: today
    val isToday = day == today
    val scope = rememberCoroutineScope()
    // Kept above Today by the app, so the cards and steps opened stay open while a note or Add log is on top.
    val layout = kept ?: remember { TodayLayout(scope) }
    var calendar by remember { mutableStateOf(false) }
    var filtering by rememberSaveable { mutableStateOf(false) }
    var lit by remember { mutableStateOf<String?>(null) }
    // Another day: the buttons under the last log go, and every card follows its rule again (Figma 1.2). Coming back to
    // Today from a page it opened (a note, Add log) is not another day.
    var lastDay by rememberSaveable { mutableStateOf(day) }
    LaunchedEffect(day) { if (lastDay != day) { lastDay = day; layout.reset(); store.afterLog = null } }

    // The ✏ tip (Figma 2.0): once, after Today has been opened on three different days and a time of day holds two habits.
    LaunchedEffect(today) {
        val seen = prefs.todayDaysSeen.split(",").filter { it.isNotEmpty() }
        if (seen.size < 3 && today.toString() !in seen) prefs.todayDaysSeen = (seen + today.toString()).joinToString(",")
    }
    val tipShows = !prefs.arrangeTipDone && isToday && prefs.todayDaysSeen.split(",").count { it.isNotEmpty() } >= 3 &&
        store.rules.cardMembers().any { (card, ids) -> card != DaySection.QUITTING && ids.size >= 2 }

    // A habit just added: Today says where it went, with Move, and lights its row briefly (Figma 1.6).
    LaunchedEffect(store.justAdded) {
        val (id, at) = store.justAdded ?: return@LaunchedEffect
        store.justAdded = null
        val habit = store.habit(id) ?: return@LaunchedEffect
        if (store.clock() - at > 15_000) return@LaunchedEffect
        val placement = store.placements(habit).firstOrNull() ?: return@LaunchedEffect
        if (!store.rules.isDue(habit, today)) return@LaunchedEffect
        shownDay = null
        lit = id
        layout.setOpen(placement.section, true)
        val where = if (placement.section == DaySection.QUITTING) "Quitting" else store.section(placement.section).name
        // Shown from Today's own scope: clearing justAdded above restarts this effect, which would cancel it.
        scope.launch { delay(1600); if (lit == id) lit = null }
        scope.launch {
            val result = snackbar.showSnackbar("Added to the end of $where", actionLabel = "Move", duration = SnackbarDuration.Short)
            if (result == SnackbarResult.ActionPerformed) actions.arrange(habit)
        }
    }

    // A task moved from Day details (Do tomorrow, Another day…) has left the day: Today says where it went, with Undo.
    LaunchedEffect(store.justMoved) {
        val moved = store.justMoved ?: return@LaunchedEffect
        store.justMoved = null
        val habit = store.habit(moved.habitId) ?: return@LaunchedEffect
        if (store.clock() - moved.at > 15_000) return@LaunchedEffect
        val where = if (moved.to == today + 1) "tomorrow" else DayWords.short(moved.to)
        scope.launch {
            val result = snackbar.showSnackbar("${habit.name} moved to $where", actionLabel = "Undo", duration = SnackbarDuration.Short)
            if (result == SnackbarResult.ActionPerformed) moved.undo()
        }
    }

    // A habit started over with a new type (Figma 6.3.2): the snackbar says where the old one went; View opens it.
    LaunchedEffect(store.startedOver) {
        val name = store.startedOver ?: return@LaunchedEffect
        store.startedOver = null
        scope.launch {
            val r = snackbar.showSnackbar("Old $name is in Archived habits", actionLabel = "View", duration = SnackbarDuration.Short)
            if (r == SnackbarResult.ActionPerformed) nav.archivedHabits()
        }
    }

    // Milestones (Android/Docs/Milestones, decided 17 Oct 2026): quit and cut-down habits judged once a day; the others
    // shown at once as they're reached here, first come first served: a pop-up, the bar, or the row (MilestoneCenter).
    val center = store.milestones
    // Again when the habits change (a load, a restore, a new habit), never per log.
    LaunchedEffect(store.isLoaded, today, store.habits) { if (store.isLoaded) center.dayCheck() }
    var bar by remember { mutableStateOf<MilestoneShown?>(null) }
    var barLeaving by remember { mutableStateOf(false) }
    var barBox by remember { mutableStateOf<androidx.compose.ui.geometry.Rect?>(null) }
    var todayBox by remember { mutableStateOf<androidx.compose.ui.geometry.Rect?>(null) }
    fun barGone() { if (bar != null) barLeaving = true }
    LaunchedEffect(barLeaving) {
        if (!barLeaving) return@LaunchedEffect
        delay(200)
        bar = null
        center.barHabit = null
        barLeaving = false
    }
    // A milestone notification tapped: its pop-up (Figma N.6).
    LaunchedEffect(com.oftenenough.app.app.AppGraph.milestoneToOpen, store.isLoaded) {
        val asked = com.oftenenough.app.app.AppGraph.milestoneToOpen ?: return@LaunchedEffect
        if (!store.isLoaded) return@LaunchedEffect
        com.oftenenough.app.app.AppGraph.milestoneToOpen = null
        val (id, value) = asked.split("|").let { it[0] to (it.getOrNull(1)?.toIntOrNull() ?: return@LaunchedEffect) }
        shownDay = null
        center.opened(id, value)?.let { popup = it }
    }
    val waiting = if (isToday) center.next(MilestoneCenter.Surface.TODAY) else null
    LaunchedEffect(waiting) {
        val hit = waiting ?: return@LaunchedEffect
        val shown = center.claim(hit, MilestoneCenter.Surface.TODAY) ?: return@LaunchedEffect
        when (shown.tier) {
            MilestoneTier.POPUP -> { bar = null; center.barHabit = null; popup = shown }
            // One bar at a time: the next one takes the place of the last (V3.2), whose band then shows in its row.
            MilestoneTier.BAR -> { barLeaving = false; bar = shown; center.barHabit = shown.habitId }
            MilestoneTier.ROW -> {}
        }
    }

    val hasHabits = store.habits.isNotEmpty()
    val group = prefs.todayGroup.takeIf { id -> store.groups.any { it.id == id } }
    val filterOn = group != null || prefs.hideDoneHabits || prefs.hideDoneTasks
    if (filtering) FilterSheet(store, prefs, day, { filtering = false; nav.newGroup() }, { filtering = false; nav.editGroups() }) { filtering = false }
    val (notice, dismissNotice) = rememberTodayNotice(store, nav)
    Scaffold(
        containerColor = c.screen,
        topBar = {
            AppTopBar(
                null,
                // Beside a sidebar (tablets) there's no menu to open.
                navigationIcon = { if (!com.oftenenough.app.ui.LocalSidebar.current) IconButton(nav::openMenu, Modifier.semantics { testTag = "menu-button" }) { Icon(Symbols.Menu, "Menu") } },
                actions = {
                    if (hasHabits) {
                        TopIcon(Symbols.Edit, "Arrange your day", tipShows, "arrange-button") { prefs.arrangeTipDone = true; nav.arrange() }
                        TopIcon(Symbols.FilterList, if (filterOn) "Filter, on" else "Filter", filterOn, "filter-button") { filtering = true }
                    }
                    IconButton(nav::newHabit, Modifier.semantics { testTag = "new-habit" }) { Icon(Symbols.Add, "New habit") }
                },
            )
        },
    ) { padding ->
        Box(Modifier.fillMaxSize().padding(top = padding.calculateTopPadding())
            .onGloballyPositioned { todayBox = it.boundsInRoot() }
            // Any other touch sends the bar away (V3.4); it never blocks the touch.
            .pointerInput(Unit) {
                awaitEachGesture {
                    val down = awaitFirstDown(requireUnconsumed = false, pass = PointerEventPass.Initial)
                    val box = barBox
                    val origin = todayBox
                    if (bar != null && box != null && origin != null && !box.contains(down.position + origin.topLeft)) barGone()
                }
            }) {
            when {
                !store.isLoaded -> {}
                !hasHabits -> NoHabitsYet(nav)
                else -> {
                    val content = remember(store.dataVersion, day, today, now / 60_000, prefs.doneOrder, prefs.hideDoneHabits, prefs.hideDoneTasks, prefs.todayGroup, layout.holding) {
                        TodayContent.make(store, day, today, now, prefs)
                    }
                    if (content.isEmpty) Column(Modifier.fillMaxSize()) {
                        Box(Modifier.padding(horizontal = 16.dp)) { TodayChips(store, prefs, group) }
                        if (group != null) NothingInGroup(store.groups.first { it.id == group }.name, isToday) { prefs.todayGroup = "" }
                        else NothingPlanned(nav, isToday)
                    }
                    else Column(Modifier.fillMaxSize()) {
                    // The filter's chips stay under the top bar (Figma 3.1, 3.4), never scrolled away above the list.
                    Box(Modifier.padding(horizontal = 16.dp)) { TodayChips(store, prefs, group) }
                    val listState = rememberLazyListState()
                    val index = remember { ItemIndex() }
                    // A habit just added comes into view, lit (Figma 1.6).
                    LaunchedEffect(lit) {
                        val id = lit ?: return@LaunchedEffect
                        delay(100)
                        index.at.entries.firstOrNull { it.key.startsWith("row-") && it.key.contains(id) }?.value?.let { listState.animateScrollToItem(maxOf(0, it - 1)) }
                    }
                    // A notice that comes while Today is at its top is brought into view, not left above it.
                    LaunchedEffect(notice?.key) { if (notice != null && isToday && listState.firstVisibleItemIndex <= 1) listState.animateScrollToItem(0) }
                    LazyColumn(
                        Modifier.fillMaxSize().semantics { testTag = "today-list" },
                        state = listState,
                        // Room under the last card for the day bar, and Back to today above it on another day.
                        contentPadding = PaddingValues(start = 16.dp, end = 16.dp, top = 0.dp, bottom = if (isToday) 132.dp else 192.dp),
                    ) {
                        index.reset()
                        if (isToday && notice != null) indexed(index, "notice-${notice.key}") {
                            NoticeCard(notice, dismissNotice)
                            Spacer(Modifier.height(16.dp))
                        }
                        todayItems(content, store, layout, actions, nav, prefs, lit, index)
                    }
                    }
                    BottomFade(Modifier.align(Alignment.BottomCenter))
                    Column(Modifier.align(Alignment.BottomCenter).navigationBarsPadding().padding(bottom = 16.dp), horizontalAlignment = Alignment.CenterHorizontally) {
                        bar?.let { shown ->
                            store.habit(shown.habitId)?.let { h ->
                                val w = remember(shown) { center.words(shown, h) }
                                // Each milestone its own bar (molecule 4.8): it rises over the day bar and fades in, and
                                // leaves fading up (Figma's Milestone · Motion: 24 dp in 250 ms, Material's fast springs).
                                key("${shown.habitId}|${shown.value}") {
                                    val visible = remember { MutableTransitionState(false) }.apply { targetState = !barLeaving }
                                    val motion = MaterialTheme.motionScheme
                                    val density = LocalDensity.current
                                    val on = animationsOn()
                                    AnimatedVisibility(
                                        visible,
                                        enter = if (on) fadeIn(motion.fastEffectsSpec()) + slideInVertically(motion.fastSpatialSpec()) { with(density) { 24.dp.roundToPx() } } else EnterTransition.None,
                                        exit = if (on) fadeOut(motion.fastEffectsSpec()) + slideOutVertically(motion.fastSpatialSpec()) { with(density) { -16.dp.roundToPx() } } else ExitTransition.None,
                                    ) {
                                        MilestoneBar(w.number, w.title, h.name, h.color, onSee = { popup = shown; barGone() }, onGone = { barGone() },
                                            modifier = Modifier.padding(start = 16.dp, end = 16.dp, bottom = 8.dp).onGloballyPositioned { barBox = it.boundsInRoot() })
                                    }
                                }
                            }
                        }
                        TodaySnackbars(snackbar)
                        if (!isToday) BackToToday { shownDay = null }
                        DayBar(store, day, today, onPrevious = { shownDay = (day - 1).takeIf { it != today } }, onNext = { shownDay = (day + 1).takeIf { it != today } }, onPick = { calendar = true })
                    }
                }
            }
            if (tipShows && hasHabits) ArrangeTip(Modifier.align(Alignment.TopEnd)) { prefs.arrangeTipDone = true }
            if (!hasHabits) Box(Modifier.align(Alignment.BottomCenter).navigationBarsPadding().padding(bottom = 16.dp)) { TodaySnackbars(snackbar) }
        }
    }
    popup?.let { shown ->
        val h = store.habit(shown.habitId)
        if (h == null) popup = null
        else {
            val w = remember(shown) { center.words(shown, h) }
            MilestonePopup(w.number, w.popupTitle, w.popupSubtitle, h.color, w.next, second = w.second,
                onClose = { popup = null },
                onAll = {
                    popup = null
                    if (shown.track != MilestoneTrack.ANNIVERSARY) com.oftenenough.app.ui.habit.HabitPageOpen.milestones = h.id
                    actions.openHabitPage(h)
                })
        }
    }
    // Back on another day returns to today first (Figma 4.2).
    androidx.activity.compose.BackHandler(enabled = !isToday) { shownDay = null }
    if (calendar) {
        val state = rememberDatePickerState(initialSelectedDateMillis = LocalDate.ofEpochDay(day.toLong()).atStartOfDay(ZoneOffset.UTC).toInstant().toEpochMilli())
        DatePickerDialog(
            onDismissRequest = { calendar = false },
            confirmButton = {
                AppButton("Go", {
                    state.selectedDateMillis?.let { ms ->
                        val picked = Instant.ofEpochMilli(ms).atZone(ZoneOffset.UTC).toLocalDate().toEpochDay().toInt()
                        shownDay = if (picked == today) null else picked
                    }
                    calendar = false
                }, Modifier.semantics { testTag = "calendar-go" }, style = ButtonStyle.Text)
            },
            dismissButton = { AppButton("Cancel", { calendar = false }, style = ButtonStyle.Text) },
        ) {
            DatePicker(state, title = { Text("Go to a day", Modifier.padding(start = 24.dp, top = 16.dp)) })
        }
    }
}

/** A top bar icon button; [on] gives it the tonal circle (the filter while it filters, ✏ while its tip shows: Figma 3.1, 2.0). */
@Composable
private fun TopIcon(icon: androidx.compose.ui.graphics.vector.ImageVector, label: String, on: Boolean, tag: String, onClick: () -> Unit) {
    val c = appColors
    IconButton(onClick, Modifier.semantics { testTag = tag }) {
        Box(Modifier.size(48.dp).clip(CircleShape).background(if (on) c.behind else Color.Transparent), contentAlignment = Alignment.Center) {
            Icon(icon, label)
        }
    }
}

/**
 * What Today is filtered by, as input chips under the top bar (Figma 3.1, 3.4): the group ("Health ✕") and "Done hidden
 * ✕"; ✕ clears it.
 */
@Composable
private fun TodayChips(store: HabitStore, prefs: Prefs, group: String?) {
    val hides = prefs.hideDoneHabits || prefs.hideDoneTasks
    if (group != null || hides) Row(Modifier.fillMaxWidth().padding(bottom = 16.dp),
        horizontalArrangement = Arrangement.spacedBy(8.dp)) {
        group?.let { id -> store.groups.firstOrNull { it.id == id }?.let { g -> InputChip(g.name, "chip-group") { prefs.todayGroup = "" } } }
        if (hides) InputChip("Done hidden", "chip-done-hidden") { prefs.hideDoneHabits = false; prefs.hideDoneTasks = false }
    }
}

/** An input chip (Figma 1960:484): #E2E2E7, corners 8, the label (Label Large) and ✕ 18 dp. */
@Composable
private fun InputChip(label: String, tag: String, onClear: () -> Unit) {
    val c = appColors
    Row(
        Modifier.heightIn(min = 34.dp).clip(RoundedCornerShape(8.dp)).background(c.behind).clickable(onClickLabel = "Clear $label", onClick = onClear)
            .padding(start = 12.dp, end = 8.dp, top = 6.dp, bottom = 6.dp).semantics { testTag = tag },
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Text(label, style = AppType.labelLarge, color = c.ink, maxLines = 1)
        Spacer(Modifier.width(8.dp))
        Icon(Symbols.Close, "Clear $label", Modifier.size(18.dp), tint = c.ink)
    }
}

/** The fade under the day bar (Figma "Bottom fade"): the screen's colour from clear to solid over 170 dp. */
@Composable
private fun BottomFade(modifier: Modifier) {
    val s = appColors.screen
    Box(modifier.fillMaxWidth().height(170.dp).background(Brush.verticalGradient(0f to s.copy(alpha = 0f), 0.5f to s.copy(alpha = 0.85f), 1f to s)))
}

/** Today's messages, 12 dp above the day bar (Figma 1.5, 1.6): the Snackbar (2.6). */
@Composable
private fun TodaySnackbars(snackbar: SnackbarHostState) = AppSnackbarHost(snackbar, Modifier.padding(horizontal = 4.dp))

/** "Back to today" (Figma 1985:173): the day bar's own surface, floating 8 dp above it. */
@Composable
private fun BackToToday(onClick: () -> Unit) {
    val c = appColors
    Row(
        Modifier.padding(bottom = 12.dp).shadow(6.dp, RoundedCornerShape(24.dp)).clip(RoundedCornerShape(24.dp)).background(c.surface)
            .border(1.dp, c.ink.copy(alpha = 0.08f), RoundedCornerShape(24.dp)).clickable(onClick = onClick)
            .padding(start = 16.dp, end = 20.dp, top = 10.dp, bottom = 10.dp).semantics { testTag = "back-to-today" },
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Icon(Symbols.Today, null, Modifier.size(20.dp), tint = c.ink)
        Spacer(Modifier.width(8.dp))
        Text("Back to today", style = AppType.labelLarge, color = c.ink)
    }
}

/** The ✏ tip (Figma 2.0): a rich tooltip under the button, "Got it" ends it for good. */
@Composable
private fun ArrangeTip(modifier: Modifier, onDone: () -> Unit) {
    val c = appColors
    Column(
        modifier.padding(end = 16.dp, top = 0.dp).widthIn(max = 280.dp).shadow(8.dp, RoundedCornerShape(12.dp)).clip(RoundedCornerShape(12.dp))
            .background(c.surface).padding(start = 16.dp, end = 16.dp, top = 12.dp, bottom = 8.dp).semantics { testTag = "arrange-tip" },
        verticalArrangement = Arrangement.spacedBy(4.dp),
    ) {
        Text("Arrange your day", style = AppType.titleMedium, color = c.ink)
        Text("Put habits in your own order, or move one to another time of day.", style = AppType.bodyMedium, color = c.secondary)
        Box(Modifier.fillMaxWidth(), contentAlignment = Alignment.CenterEnd) {
            AppButton("Got it", onDone, Modifier.semantics { testTag = "arrange-tip-done" }, style = ButtonStyle.Text)
        }
    }
}

/** Where each of Today's list items is, by key, as the list is built (to bring a new habit's row into view). */
class ItemIndex {
    var n = 0
    val at = HashMap<String, Int>()
    fun reset() { n = 0; at.clear() }
}

/** An item, counted in [ix]. */
private fun LazyListScope.indexed(ix: ItemIndex, key: String, content: @Composable androidx.compose.foundation.lazy.LazyItemScope.() -> Unit) {
    ix.at[key] = ix.n++
    item(key = key, content = content)
}

/** One row on Today: a habit in one time of day. */
class TodayItem(val habit: Habit, val placement: Placement)

/** Everything Today shows for a day, worked out once per change (S5, S8), never while drawing a row. */
class TodayContent(
    val cards: List<Pair<String, List<TodayItem>>>, val restraint: List<Habit>, val paused: List<Habit>,
    /** The time of day it is now by the clock (on today and earlier days: those cards open; Figma 4.2). */
    val nowPart: String?, val day: Int, val today: Int, val dayNote: String?, val done: Map<String, Boolean>,
) {
    val isEmpty: Boolean get() = cards.isEmpty() && restraint.isEmpty() && paused.isEmpty()
    /** Everything planned is done (or skipped): "All done for today." (Figma 1.8). */
    val allDone: Boolean get() = day == today && cards.any { it.second.isNotEmpty() } && cards.all { (_, items) -> items.all { done[it.habit.id] == true } }

    companion object {
        fun make(store: HabitStore, day: Int, today: Int, now: Long, prefs: Prefs): TodayContent {
            val isToday = day == today
            val rules = store.rules
            val group = prefs.todayGroup.takeIf { it.isNotEmpty() }?.let { id -> store.groups.firstOrNull { it.id == id } }
            val active = store.habits.filter { !it.archived && rules.startDay(it) <= day && (group == null || it.id in group.habits) }
            val restraint = active.filter { h ->
                if (h.kind == HabitKind.Quit) isToday && !store.isPaused(h, today)
                else h.isQuitOrLimit && rules.isDue(h, day, now, countingSkips = false) && !store.isPaused(h, day)
            }
            val paused = active.filter { store.isPaused(it, day) && (it.kind != HabitKind.Quit || isToday) }
            val tracked = active.filter { !it.isQuitOrLimit && rules.isDue(it, day, now, countingSkips = false) && !store.isPaused(it, day) }
            val rows = LinkedHashMap<String, MutableList<TodayItem>>()
            for (h in tracked) for (p in store.placements(h)) rows.getOrPut(p.section) { ArrayList() }.add(TodayItem(h, p))
            val done = HashMap<String, Boolean>()
            for (h in tracked) done[h.id] = store.isSkipped(h, day) || rules.isSatisfied(h, day)
            val cards = store.todayCards().mapNotNull { card ->
                if (card == DaySection.QUITTING) card to emptyList<TodayItem>() else rows[card]?.takeIf { it.isNotEmpty() }?.let { card to it }
            }.filter { (card, items) -> card == DaySection.QUITTING && restraint.isNotEmpty() || items.isNotEmpty() }
            return TodayContent(cards, restraint, paused, if (day <= today) store.nowSection(now)?.id else null, day, today,
                if (day <= today) store.dayNote(day) else null, done)
        }
    }
}

private fun LazyListScope.todayItems(content: TodayContent, store: HabitStore, layout: TodayLayout, actions: TodayActions, nav: TodayNav, prefs: Prefs, lit: String?, ix: ItemIndex) {
    val day = content.day
    val today = content.today
    // The line above the cards: everything done today (Figma 1.8), or what a later day is (4.3).
    val line = when {
        day > today -> "Planned for ${DayWords.short(day)}. Habits are logged on their day."
        content.allDone -> "All done for today."
        else -> null
    }
    if (line != null) indexed(ix, "line") {
        Text(line, Modifier.fillMaxWidth().padding(horizontal = 16.dp).padding(bottom = 16.dp).semantics { testTag = "today-line" },
            style = AppType.bodyMedium, color = appColors.secondary)
    }
    content.dayNote?.let { note ->
        indexed(ix, "day-note") {
            Row(Modifier.fillMaxWidth().padding(bottom = 16.dp).clip(RoundedCornerShape(24.dp)).background(appColors.surface)
                .clickable { actions.writeNote(null, day) }.padding(16.dp)) {
                Icon(Symbols.StickyNote2, null, tint = appColors.secondary)
                Spacer(Modifier.width(12.dp))
                Text(note, style = AppType.bodyMedium, color = appColors.ink)
            }
        }
    }
    for ((card, items) in content.cards) {
        if (card == DaySection.QUITTING) quitting(content.restraint, store, layout, actions, day, today, prefs, ix)
        else section(card, items, content, store, layout, actions, nav, prefs, lit, ix)
    }
    if (content.paused.isNotEmpty()) {
        val open = layout.choice("paused") ?: false
        indexed(ix, "header-paused") {
            // Figma's Paused header has no time line; each paused row says when it comes back.
            SectionHeader("Paused", null, open, if (open) segmentShape(0, content.paused.size + 1) else RoundedCornerShape(24.dp),
                onToggle = { layout.setOpen("paused", !open) }, habits = content.paused.map { it.inSection() }, tag = "header-Paused")
        }
        if (open) content.paused.forEachIndexed { i, h ->
            indexed(ix, "paused-${h.id}") { Spacer(Modifier.height(2.dp)); PausedRow(h, segmentShape(i + 1, content.paused.size + 1), store, actions) }
        }
        indexed(ix, "gap-paused") { Spacer(Modifier.height(16.dp)) }
    }
    if (day <= today && content.dayNote == null) {
        indexed(ix, "add-day-note") {
            Box(Modifier.fillMaxWidth(), contentAlignment = Alignment.Center) {
                AppButton("Note for the day", { actions.writeNote(null, day) }, style = ButtonStyle.Text)
            }
        }
    }
}

private fun LazyListScope.section(
    card: String, items: List<TodayItem>, content: TodayContent, store: HabitStore, layout: TodayLayout, actions: TodayActions,
    nav: TodayNav, prefs: Prefs, lit: String?, ix: ItemIndex,
) {
    val day = content.day
    val future = day > content.today
    val isNow = card == content.nowPart
    val left = items.count { content.done[it.habit.id] != true }
    // Open: the time of day it is now and Anytime, while they have something left; a later day opens Anytime only (4.3).
    val open = layout.isOpen(card, if (future) card == DaySection.ANYTIME else left > 0 && (isNow || card == DaySection.ANYTIME))
    val hides = prefs.hideDoneHabits || prefs.hideDoneTasks
    val shown = if (!hides || layout.holding) items else items.filter { item ->
        content.done[item.habit.id] != true || !(if (item.habit.kind == HabitKind.Task) prefs.hideDoneTasks else prefs.hideDoneHabits)
    }
    val fresh = if (prefs.doneOrder != "inPlace") shown.filter { content.done[it.habit.id] != true } + shown.filter { content.done[it.habit.id] == true } else shown
    val ordered = layout.order(card, fresh) { it.habit.id }
    // Every piece of the card, a checklist's steps block included, so the corners are right.
    val pieces = ArrayList<Pair<TodayItem, Boolean>>()
    for (item in ordered) {
        pieces.add(item to false)
        if (item.habit.kind == HabitKind.Checklist && layout.choice("steps-${item.habit.id}") == true && item.habit.steps.isNotEmpty()) pieces.add(item to true)
    }
    val count = if (open) pieces.size + 1 else 1
    val section = store.section(card)
    val start: (() -> Unit)? = if (!future && left > 0) {
        { nav.startRoutine(card, day, layout.order(card, items) { it.habit.id }.map { it.habit }.filter { !it.isQuitOrLimit }) }
    } else null
    val badge = when {
        future -> "${items.size} planned"
        left == 0 -> "Done"
        else -> "$left left"
    }
    indexed(ix, "header-$card") {
        SectionHeader(section.name, startsText(section), open, if (open) segmentShape(0, count) else RoundedCornerShape(24.dp),
            onToggle = { layout.setOpen(card, !open) }, count = badge, habits = items.map { it.habit.inSection() }, onStart = start,
            tag = "header-${section.name}")
    }
    if (open) pieces.forEachIndexed { i, (item, steps) ->
        val habit = item.habit
        indexed(ix, "row-$card-${habit.id}-${if (steps) "steps" else ""}") {
            Spacer(Modifier.height(2.dp))
            val shape = segmentShape(i + 1, count)
            val stepsKey = "steps-${habit.id}"
            if (!steps) {
                HabitRow(habit, day, content.today, item.placement.slot, item.placement.times.firstOrNull(), shape, store, layout, actions,
                    stepsOpen = layout.choice(stepsKey) == true, onToggleSteps = { layout.setOpen(stepsKey, layout.choice(stepsKey) != true) },
                    lit = lit == habit.id, haptics = prefs.vibration)
            } else StepsBlock(habit, day, shape, store, layout)
        }
    }
    indexed(ix, "gap-$card") { Spacer(Modifier.height(16.dp)) }
}

private fun LazyListScope.quitting(habits: List<Habit>, store: HabitStore, layout: TodayLayout, actions: TodayActions, day: Int, today: Int, prefs: Prefs, ix: ItemIndex) {
    val open = layout.choice(DaySection.QUITTING) ?: true
    val count = if (open) habits.size + 1 else 1
    indexed(ix, "header-quitting") {
        SectionHeader("Quitting", "Stop, or do less", open, if (open) segmentShape(0, count) else RoundedCornerShape(24.dp),
            onToggle = { layout.setOpen(DaySection.QUITTING, !open) }, habits = habits.map { it.inSection() }, tag = "header-Quitting")
    }
    if (open) habits.forEachIndexed { i, h ->
        indexed(ix, "quit-${h.id}") {
            Spacer(Modifier.height(2.dp))
            val shape = segmentShape(i + 1, count)
            if (h.kind == HabitKind.Quit) QuitRow(h, shape, store, layout, actions, haptics = prefs.vibration)
            else HabitRow(h, day, today, null, null, shape, store, layout, actions, false, {}, haptics = prefs.vibration)
        }
    }
    indexed(ix, "gap-quitting") { Spacer(Modifier.height(16.dp)) }
}

/** The day bar (Day navigation, 4.18): the day open, how much of it is done, ‹ › and Go to a day. */
@Composable
fun DayBar(store: HabitStore, day: Int, today: Int, onPrevious: () -> Unit, onNext: () -> Unit, onPick: () -> Unit) {
    val score = remember(store.dataVersion, day, today) { store.daySummary(day) }
    val label = when (day) { today -> "Today"; today - 1 -> "Yesterday"; today + 1 -> "Tomorrow"; else -> DayWords.short(day) }
    DayNavigation(label, if (score.planned > 0) "${score.done}/${score.planned}" else null, score.fraction.toFloat(),
        "$label, ${score.done} of ${score.planned} done. Go to a day", onPrevious, onNext, onPick)
}

/**
 * No habits yet (Figma `36:32`, 22 October 2026). **This is the first screen of the app**: there is no onboarding any
 * more, so someone who opens Often Enough for the first time lands on Today and sees exactly this. It is shown only
 * while there are no habits at all, and it offers the only two things worth offering then — make one, or bring back
 * the ones you already had. Never a dead end (onboarding report §4).
 */
@Composable
private fun NoHabitsYet(nav: TodayNav) {
    Column(Modifier.fillMaxSize().padding(horizontal = 32.dp), horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.Center) {
        CookieIcon(Symbols.Checklist, size = 112.dp)
        Spacer(Modifier.height(16.dp))
        Text("No habits yet", style = AppType.headlineSmallEmphasized, color = appColors.ink)
        Spacer(Modifier.height(8.dp))
        Text("Add something you’d like to do often enough.", Modifier.widthIn(max = 268.dp), style = AppType.bodyLarge,
            color = appColors.secondary, textAlign = TextAlign.Center)
        Spacer(Modifier.height(24.dp))
        AppButton("New habit", nav::newHabit, icon = Symbols.Add)
        Spacer(Modifier.height(8.dp))
        AppButton("Restore from a backup", nav::restore, style = ButtonStyle.Tonal, icon = Symbols.SettingsBackupRestore)
    }
}

/** Habits exist, none on this day (Figma 1551:195): neutral words, never "missed" or "no habits due" (U3, Current Work 106). */
@Composable
private fun NothingPlanned(nav: TodayNav, isToday: Boolean) {
    Column(Modifier.fillMaxSize().padding(horizontal = 32.dp).padding(bottom = 96.dp), horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.Center) {
        CookieIcon(Symbols.EventAvailable, size = 112.dp)
        Spacer(Modifier.height(24.dp))
        Text(if (isToday) "Nothing planned today" else "Nothing planned this day", style = AppType.headlineSmallEmphasized, color = appColors.ink, textAlign = TextAlign.Center)
        Spacer(Modifier.height(8.dp))
        Text("Your habits are planned for other days. Each shows up on its days.", style = AppType.bodyLarge,
            color = appColors.secondary, textAlign = TextAlign.Center)
        Spacer(Modifier.height(24.dp))
        AppButton("New habit", nav::newHabit, style = ButtonStyle.Tonal, icon = Symbols.Add)
    }
}

/** A group with nothing on the day open (Figma 3.5): says so, with Show all; never a blank Today. */
@Composable
private fun NothingInGroup(name: String, isToday: Boolean, onShowAll: () -> Unit) {
    Column(Modifier.fillMaxSize().padding(horizontal = 32.dp).padding(bottom = 96.dp).semantics { testTag = "nothing-in-group" },
        horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.Center) {
        CookieIcon(Symbols.FilterList, size = 112.dp)
        Spacer(Modifier.height(24.dp))
        Text(if (isToday) "Nothing from $name today" else "Nothing from $name this day", style = AppType.headlineSmallEmphasized, color = appColors.ink, textAlign = TextAlign.Center)
        Spacer(Modifier.height(8.dp))
        Text("$name’s habits are planned for other days.", style = AppType.bodyLarge, color = appColors.secondary, textAlign = TextAlign.Center)
        Spacer(Modifier.height(24.dp))
        AppButton("Show all", onShowAll, style = ButtonStyle.Tonal)
    }
}
