package com.oftenenough.app.ui.player

import com.oftenenough.app.ui.components.belowStatusBar
import com.oftenenough.app.ui.components.sheetInsets
import com.oftenenough.app.data.dayResult
import com.oftenenough.app.ui.components.SegmentedListGap
import com.oftenenough.app.ui.components.ListChevron
import com.oftenenough.app.ui.components.AppListItem
import androidx.compose.ui.unit.Dp
import com.oftenenough.app.ui.components.MilestonePopup
import com.oftenenough.app.ui.components.SnackbarAction
import com.oftenenough.app.ui.components.AppSnackbar
import com.oftenenough.app.ui.components.AppMenuItem
import com.oftenenough.app.ui.components.AppGroupedMenu
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.ButtonSize
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import androidx.compose.material3.LinearProgressIndicator
import com.oftenenough.app.ui.components.AppAssistChip
import com.oftenenough.app.ui.components.MilestoneRibbon
import com.oftenenough.app.ui.components.MilestoneRibbonArrival
import com.oftenenough.app.ui.components.StepRow
import com.oftenenough.app.ui.components.StepRowPlace
import com.oftenenough.app.ui.components.StandardIconButton
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.semantics.customActions
import androidx.compose.ui.semantics.CustomAccessibilityAction
import androidx.compose.foundation.gestures.detectDragGestures
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.zIndex
import androidx.compose.runtime.mutableFloatStateOf
import androidx.compose.runtime.key
import com.oftenenough.app.data.GoalPeriod
import com.oftenenough.app.data.Frequency
import com.oftenenough.app.data.Format
import com.oftenenough.app.data.pageIsTotal
import androidx.compose.foundation.layout.wrapContentHeight
import androidx.compose.ui.geometry.Offset
import androidx.compose.foundation.layout.offset
import com.oftenenough.app.ui.theme.AppType

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.BoxWithConstraints
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.pager.HorizontalPager
import androidx.compose.foundation.pager.PagerState
import androidx.compose.foundation.pager.rememberPagerState
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Button
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.ModalBottomSheet
import androidx.compose.material3.Text
import com.oftenenough.app.ui.components.rememberWholeSheetState
import com.oftenenough.app.ui.components.AppLargeIconButton
import com.oftenenough.app.ui.components.LargeIconWidth
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.MutableIntState
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.State
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.runtime.snapshotFlow
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.LocalView
import androidx.compose.ui.semantics.ProgressBarRangeInfo
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.progressBarRangeInfo
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleEventObserver
import androidx.lifecycle.compose.LocalLifecycleOwner
import com.oftenenough.app.data.EntrySource
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.MainAction
import com.oftenenough.app.data.PlayerAction
import com.oftenenough.app.data.PlayerWords
import com.oftenenough.app.data.Step
import com.oftenenough.app.ui.components.Card
import com.oftenenough.app.ui.components.CookieIcon
import com.oftenenough.app.ui.components.CookieShape
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.WavyProgress
import com.oftenenough.app.ui.components.segmentShape
import com.oftenenough.app.ui.theme.appColors
import com.oftenenough.app.ui.today.rememberTicker
import androidx.compose.ui.draw.drawWithContent
import androidx.compose.ui.graphics.graphicsLayer
import com.oftenenough.app.data.MilestoneCenter
import com.oftenenough.app.data.MilestoneFront
import com.oftenenough.app.data.MilestoneTier
import com.oftenenough.app.data.MilestoneTrack
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Job
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

/** Where the routine player hands over: the screens it opens. */
interface PlayerNav {
    /** Day details for this habit and day, full height: the same sheet a row opens on Today (U23). */
    fun openDay(habit: Habit, day: Int)
    /** The habit's Add screen (an amount typed each time, or time typed by hand), U22. */
    fun addLog(habit: Habit, day: Int)
    /** The full-screen timer. Not used by the player itself: it shows its own clock (the iPhone's player does too). */
    fun openTimer(habit: Habit)
    /** The save message's Add note. By default Day details, which holds the day's note; a host can open the note directly. */
    fun writeNote(habit: Habit, day: Int) = openDay(habit, day)
    /** A milestone pop-up's All milestones (or See the year): the habit's page. */
    fun habitPage(habit: Habit, milestones: Boolean) {}
}

/**
 * The routine player: a time of day's habits one at a time (the iPhone's `RoutinePlayer`, iOS/Habits/Today/RoutinePlayer.swift),
 * in the Android designs' Material 3 Expressive form (Android/Docs/Designs/README.md §10): a top bar with ✕, "Anytime ▾ /
 * Habit 4 of 12" (opens Your routine) and ⋮; thin routine segments; one large hero card per habit (the cookie icon, the
 * name, the "Today ›" chip that opens Day details, the count and the wavy bar); a button group ‹ · main action · ›.
 *
 * Moving never logs, skips or asks; nothing advances by itself. Habit logs and timers stay the source of truth: a timed
 * habit's clock starts on arrival and its time is saved on leaving (the iPhone's P1, "Next, Skip and Close save before
 * leaving"). Only the clock ticks (S3). A slide the player starts never takes the pages it passes as choices (U24).
 */
@Composable
fun RoutinePlayer(
    store: HabitStore, part: String, day: Int, habitIds: List<String>, nav: PlayerNav,
    /** The habit to open on (a running timer's Live Update, Figma 10.5); otherwise the first unfinished one (1.2). */
    startAt: String? = null,
    onClose: () -> Unit,
) {
    val c = appColors
    val scope = rememberCoroutineScope()
    // The session lives through Add log and Day details (and a rotation): kept as saveable text, never in the database.
    val orderText = rememberSaveable { mutableStateOf(joinIds(habitIds)) }
    // Where it opens: the habit asked for, else the first unfinished (1.2), else the end page when all are done (1.3).
    val indexState = rememberSaveable { mutableIntStateOf(openingIndex(store, part, day, habitIds, startAt)) }
    // The position the end page's bar shows: where the person was when the routine ended (8.1 "12 of 12", 8.3 "5 of 12").
    val endFrom = rememberSaveable { mutableIntStateOf(if (indexState.intValue >= habitIds.size) habitIds.size else indexState.intValue + 1) }
    // Only a routine opened on its own day ends when the day does; one opened for another day logs to that day (1.4).
    val forToday = rememberSaveable { mutableStateOf(day == store.today()) }
    val reviewedText = rememberSaveable { mutableStateOf("") }
    val expiredState = rememberSaveable { mutableStateOf(false) }
    val manualText = rememberSaveable { mutableStateOf("") }
    val opened = rememberSaveable { mutableStateOf(false) }
    var showQueue by rememberSaveable { mutableStateOf(false) }
    var queueEditing by rememberSaveable { mutableStateOf(false) }
    val pager = rememberPagerState(initialPage = indexState.intValue) { idCount(orderText.value) + 1 }
    val session = remember(store, part, day) {
        PlayerSession(store, part, day, orderText, indexState, reviewedText, expiredState, manualText, pager, scope, endFrom)
    }
    val view = LocalView.current
    val lifecycle = LocalLifecycleOwner.current.lifecycle
    // Milestones reached here are the player's (Figma RP.1–RP.3): the ribbon on the hero card, never a bar; a landmark's
    // pop-up waits for the end. Kept through Add log and Day details (and a rotation) as saveable text.
    val center = store.milestones
    val reachedText = rememberSaveable { mutableStateOf("") }
    val endPopupText = rememberSaveable { mutableStateOf("") }
    var endPopupDone by rememberSaveable { mutableStateOf(false) }
    var ribbonFor by remember { mutableStateOf<String?>(null) }
    DisposableEffect(orderText.value) {
        val mine = MilestoneFront.Player(splitIds(orderText.value).toSet())
        val before = center.front
        center.front = mine
        onDispose { if (center.front == mine) center.front = before }
    }
    val waiting = center.next(MilestoneCenter.Surface.PLAYER)
    LaunchedEffect(waiting) {
        val hit = waiting ?: return@LaunchedEffect
        val shown = center.claim(hit, MilestoneCenter.Surface.PLAYER) ?: return@LaunchedEffect
        reachedText.value = joinIds(splitIds(reachedText.value).filter { it != shown.habitId } + shown.habitId)
        if (shown.tier == MilestoneTier.POPUP && endPopupText.value.isEmpty()) endPopupText.value = shown.habitId
        ribbonFor = shown.habitId
    }

    // On first opening only: a routine partly done says where it starts (Figma 1.2). A timer waits for Start (4).
    LaunchedEffect(session) {
        if (opened.value) return@LaunchedEffect
        opened.value = true
        val at = session.index
        val habit = session.current
        if (startAt == null && habit != null && at > 0) {
            val before = session.order.take(at).count { session.covered(it, emptySet()) }
            if (before > 0) session.say(PlayerWords.startingAt(before, habit.name, today = day == store.today()))
        }
    }
    // A new day ends the session on its own day; checked twice a minute, never per frame.
    LaunchedEffect(session) {
        if (!forToday.value) return@LaunchedEffect
        while (true) {
            if (!session.expired && store.today() != day) session.expire()
            delay(30_000)
        }
    }
    // A swipe of the person's own chooses a habit once it settles; the player's own slides never do (U24).
    LaunchedEffect(session) {
        snapshotFlow { pager.settledPage }.collect { page -> session.pagerSettled(page) }
    }
    // Back from Add log: what was saved shows with Undo, and a timer paused for it runs again (as the iPhone's sheet).
    DisposableEffect(lifecycle, session) {
        val observer = LifecycleEventObserver { _, event -> if (event == Lifecycle.Event.ON_RESUME) session.pickUpManualLog() }
        lifecycle.addObserver(observer)
        onDispose { lifecycle.removeObserver(observer) }
    }
    BackHandler { session.close(onClose) }

    val order = session.order
    val index = session.index
    val expired = session.expired
    val reviewed = session.reviewed
    val revisions = order.map { store.revision(it) }
    val covered = remember(order, revisions, reviewed, store.habits) { order.map { session.covered(it, reviewed) } }
    val coveredCount = covered.count { it }
    val current = session.current
    val sectionName = store.section(part).name

    // The screen stays awake while a timer runs in the player (the iPhone's P13).
    val awake = !expired && current != null && store.timers.containsKey(current.id)
    DisposableEffect(view, awake) {
        view.keepScreenOn = awake
        onDispose { view.keepScreenOn = false }
    }

    // The save message goes after four seconds, like Android's own short snackbar, so it never sits over the card.
    val feedback = session.feedback
    LaunchedEffect(feedback?.serial) {
        val shown = feedback?.serial ?: return@LaunchedEffect
        delay(4_000)
        session.clearFeedback(shown)
    }

    // Skip today happens in Day details; back in the player it says so, with Undo and Add note (design 13). It stays
    // on the skipped habit: nothing advances by itself.
    val currentSkipped = current != null && session.skipped(current)
    val skipSeen = remember { mutableStateOf<Pair<String, Boolean>?>(null) }
    LaunchedEffect(current?.id, currentSkipped) {
        val id = current?.id
        val before = skipSeen.value
        if (id != null && before != null && before.first == id && !before.second && currentSkipped) session.saySkipped(id)
        skipSeen.value = if (id == null) null else id to currentSkipped
    }

    val firstUnfinished = covered.indexOfFirst { !it }.takeIf { it >= 0 }
    Column(Modifier.fillMaxSize().background(c.screen).statusBarsPadding().navigationBarsPadding().semantics { testTag = "routine-player" }) {
        PlayerTopBar(
            title = sectionName,
            spoken = PlayerWords.routineSpoken(sectionName, index, order.size),
            enabled = !expired,
            canGoToFirst = firstUnfinished != null && firstUnfinished != index,
            onClose = { session.close(onClose) },
            onQueue = { queueEditing = false; showQueue = true },
            onChangeOrder = { queueEditing = true; showQueue = true },
            onFirstUnfinished = { firstUnfinished?.let { session.navigate(it) } },
            onEnd = { session.navigate(order.size) },
        )
        val position = if (index < order.size) index + 1 else endFrom.intValue.coerceIn(0, order.size)
        RoutineProgress(position, order.size, PlayerWords.segmentsSpoken(coveredCount, order.size))
        if (expired) {
            NewDayCard(Modifier.weight(1f)) { session.close(onClose) }
        } else {
            Box(Modifier.weight(1f).fillMaxWidth()) {
                HorizontalPager(
                    state = pager,
                    modifier = Modifier.fillMaxSize().semantics { testTag = "routine-pager" },
                    contentPadding = PaddingValues(horizontal = 16.dp),
                    // Wider than the side margin, so the next card never peeks in (Figma shows one card).
                    pageSpacing = 24.dp,
                ) { page ->
                    val id = order.getOrNull(page)
                    if (id != null) HabitPage(id, session, nav, playRibbon = ribbonFor == id)
                    else EndPage(
                        name = sectionName,
                        count = order.size,
                        done = order.indices.filter { covered[it] }.mapNotNull { store.habit(order[it]) },
                        later = order.indices.filter { !covered[it] }.mapNotNull { i -> store.habit(order[i])?.let { i to it } },
                        result = { h -> store.dayResult(h, day) },
                        onOpen = { i -> session.navigate(i) },
                        reached = splitIds(reachedText.value).mapNotNull { hid ->
                            val h = store.habit(hid) ?: return@mapNotNull null
                            center.visible(h)?.let { h to center.words(it, h) }
                        },
                    )
                }
                if (feedback != null) {
                    // Over the card's foot, as Figma draws it (2, 3.1, 6.1): 16 from the sides, 4 past the card.
                    FeedbackBar(
                        feedback,
                        onUndo = { session.undo(feedback) },
                        onNote = { store.habit(feedback.habitId)?.let { nav.writeNote(it, day) } },
                        modifier = Modifier.align(Alignment.BottomCenter).padding(horizontal = 16.dp).offset(y = 4.dp),
                    )
                }
            }
            if (index >= order.size) {
                EndButtons(onDone = { session.close(onClose) })
            } else {
                HabitButtons(session, current, nav)
            }
        }
    }
    if (showQueue && !expired) {
        RoutineSheet(session, covered, queueEditing, onEditing = { queueEditing = it },
            onJump = { position -> showQueue = false; session.navigate(position) }, onDismiss = { showQueue = false })
    }
    // A landmark reached in the routine: its pop-up rises over the end screen, once (Figma RP.3).
    if (!endPopupDone && index >= order.size && endPopupText.value.isNotEmpty() && pager.currentPage >= order.size) {
        val h = store.habit(endPopupText.value)
        val shown = h?.let { center.visible(it) }
        if (h == null || shown == null) endPopupDone = true
        else {
            val w = remember(shown) { center.words(shown, h) }
            val others = splitIds(reachedText.value).count { it != h.id && store.habit(it)?.let { o -> center.visible(o) } != null }
            MilestonePopup(w.number, w.popupTitle, w.popupSubtitle.replace("reached today", "reached in this routine"), h.color, w.next,
                second = w.second, more = if (others > 0) "and $others more in this routine" else null,
                onClose = { endPopupDone = true },
                onAll = { endPopupDone = true; nav.habitPage(h, milestones = shown.track != MilestoneTrack.ANNIVERSARY) })
        }
    }
}

// ---------------------------------------------------------------------------------------------- The session

private const val SEP = ","
/** A timed habit waits for Start (Figma 4: "Not started", Start → 4.1); arriving never starts a clock. */
private const val START_TIMER_ON_ARRIVAL = false

/** Covered: done for today or skipped (what the bar, Your routine and the end page count). A limit is never in a routine. */
private fun routineCovered(store: HabitStore, part: String, day: Int, habit: Habit): Boolean {
    if (habit.atMost) return false
    val slot = store.placements(habit).firstOrNull { it.section == part }?.slot
    val done = slot?.let { store.isSlotDone(habit, it, day) } ?: store.rules.isSatisfied(habit, day)
    return done || store.isSkipped(habit, day)
}

/** Where a routine opens: [startAt] if it's in it, the first unfinished habit, or the end page when all are done. */
private fun openingIndex(store: HabitStore, part: String, day: Int, ids: List<String>, startAt: String?): Int {
    startAt?.let { id -> ids.indexOf(id).takeIf { it >= 0 }?.let { return it } }
    val first = ids.indexOfFirst { id -> store.habit(id)?.let { !routineCovered(store, part, day, it) } ?: false }
    return if (first >= 0) first else ids.size
}

private fun splitIds(text: String): List<String> = if (text.isEmpty()) emptyList() else text.split(SEP)
private fun joinIds(ids: Collection<String>): String = ids.joinToString(SEP)
private fun idCount(text: String): Int = if (text.isEmpty()) 0 else text.count { it == ',' } + 1

/** "Saved · Undo · Add note": the iPhone's banner, as Material's snackbar. [serial] tells one message from the next. */
private data class Feedback(val message: String, val habitId: String, val undoEntry: String?, val unskip: Boolean, val serial: Int) {
    val canUndo: Boolean get() = undoEntry != null || unskip
}

/** The slide the player started (‹ ›, the queue, a Left for later row), until it ends. Not observed: nothing redraws for it. */
private class PagerSlide {
    var job: Job? = null
    val running: Boolean get() = job?.isActive == true
}

/**
 * The routine's own state: the order (this session only), the habit on screen, the limits checked in on and the save
 * message. Every change of a habit goes through the store, at once, the write following (S7).
 */
private class PlayerSession(
    val store: HabitStore,
    val part: String,
    val day: Int,
    private val orderText: MutableState<String>,
    private val indexState: MutableIntState,
    private val reviewedText: MutableState<String>,
    private val expiredState: MutableState<Boolean>,
    private val manualText: MutableState<String>,
    val pager: PagerState,
    private val scope: CoroutineScope,
    private val endFrom: MutableIntState,
) {
    val slide = PagerSlide()
    var feedback by mutableStateOf<Feedback?>(null)
        private set
    private var serial = 0
    private var cachedText: String? = null
    private var cachedOrder: List<String> = emptyList()

    val order: List<String>
        get() {
            val text = orderText.value
            if (text != cachedText) { cachedText = text; cachedOrder = splitIds(text) }
            return cachedOrder
        }
    var index: Int
        get() = indexState.intValue
        set(value) { indexState.intValue = value }
    val reviewed: Set<String> get() = splitIds(reviewedText.value).toSet()
    val expired: Boolean get() = expiredState.value
    /** Changes are made on the routine's own day, today or an earlier one (1.4), never after a new day ends it. */
    val live: Boolean get() = !expired && day <= store.today()
    val isToday: Boolean get() = day == store.today()
    val current: Habit? get() = order.getOrNull(index)?.let { store.habit(it) }

    /** The tick of this time of day, for a check ticked in several times of day (the iPhone's `slots(of:)`). */
    fun slotOf(habit: Habit): String? = store.placements(habit).firstOrNull { it.section == part }?.slot

    /**
     * Nothing more is asked: the main button moves on. A check counted by the week or month is done for today once ticked
     * today (Figma 2.4, "✓ Done for today", Next); other kinds when today's goal is met.
     */
    fun done(habit: Habit): Boolean {
        if (habit.atMost) return false
        slotOf(habit)?.let { return store.isSlotDone(habit, it, day) }
        val ruled = store.rule(habit, day)
        return if (ruled.kind == HabitKind.Check && !ruled.frequency.isDayBased) store.rules.isSatisfied(habit, day)
        else store.rules.isComplete(habit, day)
    }

    /** Done for today: what the segments and Your routine show (a week or month goal, once something is logged today). */
    fun doneToday(habit: Habit): Boolean =
        !habit.atMost && (slotOf(habit)?.let { store.isSlotDone(habit, it, day) } ?: store.rules.isSatisfied(habit, day))

    fun skipped(habit: Habit): Boolean = store.isSkipped(habit, day)

    fun covered(id: String, reviewed: Set<String>): Boolean {
        val habit = store.habit(id) ?: return true
        return if (habit.atMost) id in reviewed else routineCovered(store, part, day, habit)
    }

    // ------------------------------------------------------------------ Moving (U24)

    /** Puts the pager on [index]: a tap slides it; a tap while a slide still runs jumps straight to its habit. */
    fun showPage() {
        val target = index
        val sliding = slide.running
        if (!sliding && pager.currentPage == target && pager.currentPageOffsetFraction == 0f) return
        slide.job?.cancel()
        slide.job = scope.launch {
            if (sliding) pager.scrollToPage(target) else pager.animateScrollToPage(target)
        }
    }

    /** The pager came to rest on [page]. Only a swipe of the person's own, outside the player's slide, chooses a habit. */
    fun pagerSettled(page: Int) {
        if (page == index || slide.running) return
        // A report from before the latest slide, delivered late: the pager is elsewhere now.
        if (page != pager.settledPage || pager.isScrollInProgress) return
        val leaving = current
        navigate(page, if (page > index && leaving?.atMost == true) leaving.id else null)
    }

    /** To a habit (or the end page, [order]'s size). Never waits for storage; a running timer is saved on leaving. */
    fun navigate(to: Int, reviewing: String? = null) {
        if (!live) { showPage(); return }
        val destination = to.coerceIn(0, order.size)
        if (destination == index) { showPage(); return }
        current?.let { habit -> if (store.timers.containsKey(habit.id)) store.stopTimer(habit, day, source = EntrySource.ROUTINE) }
        if (reviewing != null) reviewedText.value = joinIds(reviewed + reviewing)
        feedback = null
        if (destination == order.size) endFrom.intValue = minOf(index + 1, order.size)
        index = destination
        showPage()
        startCurrentTimer()
    }

    /** Next habit (or the end page). Leaving a limit counts as having checked in on it. */
    fun advance() {
        val leaving = current
        navigate(index + 1, if (leaving?.atMost == true) leaving.id else null)
    }

    fun startCurrentTimer() {
        if (!START_TIMER_ON_ARRIVAL || !live) return
        val habit = current ?: return
        if (habit.kind != HabitKind.Duration || habit.atMost || skipped(habit) || done(habit) || store.timers.containsKey(habit.id)) return
        store.toggleTimer(habit, slotOf(habit))
    }

    /** Your routine's order, for this session only (the iPhone's queue `onMove`): the habit on screen stays on screen. */
    fun move(from: Int, to: Int) {
        val list = order.toMutableList()
        if (from !in list.indices || to !in list.indices || from == to) return
        val shown = order.getOrNull(index)
        list.add(to, list.removeAt(from))
        orderText.value = joinIds(list)
        if (shown != null) index = list.indexOf(shown)
        val target = index
        slide.job?.cancel()
        // On the next frame: scrolling at once forced a layout inside the one Your routine's move started (a crash,
        // "performMeasureAndLayout called during measure layout", found by PlayerTest's Move down).
        slide.job = scope.launch { androidx.compose.runtime.withFrameNanos { }; pager.scrollToPage(target) }
    }

    // ------------------------------------------------------------------ Changing a habit (S7)

    /** The screen changes at once and the write follows; the message offers Undo for exactly what this tap added. */
    fun change(habit: Habit, message: String, captureUndo: Boolean = true, action: () -> Unit) {
        if (!live) return
        val before = store.entries(habit.id, day).map { it.id }.toHashSet()
        action()
        val added = if (captureUndo) store.entries(habit.id, day).lastOrNull { it.id !in before }?.id else null
        feedback = Feedback(message, habit.id, added, unskip = false, serial = ++serial)
    }

    /** Pause and Resume: no message and no Undo (an Undo there deleted the session's time, found by hand on the iPhone). */
    fun startTimer(habit: Habit) {
        if (!live || !isToday) return
        feedback = null
        if (!store.timers.containsKey(habit.id)) store.toggleTimer(habit, slotOf(habit))
        // Its Live Update opens this routine at this habit (Figma 10.5).
        com.oftenenough.app.app.reminders.TimerNotice.startedInRoutine(habit.id, part, day)
    }

    fun pauseTimer(habit: Habit) {
        if (!live) return
        feedback = null
        store.stopTimer(habit, day, source = EntrySource.ROUTINE)
    }

    fun saySkipped(habitId: String) {
        feedback = Feedback(PlayerWords.SKIPPED, habitId, null, unskip = true, serial = ++serial)
    }

    /** A message alone, with no Undo or Add note ("3 done earlier today. Starting at Water.", Figma 1.2). */
    fun say(message: String) {
        feedback = Feedback(message, "", null, unskip = false, serial = ++serial)
    }

    /** A checklist's step: ticked or unticked at once, with no message, so nothing covers the steps (Figma 5.2). */
    fun toggleStep(habit: Habit, step: Step) {
        if (!live) return
        feedback = null
        store.toggleStep(step, habit, day, source = EntrySource.ROUTINE)
    }

    fun undo(f: Feedback) {
        val habit = store.habit(f.habitId)
        if (habit == null || !live) { feedback = null; return }
        val entry = f.undoEntry
        if (f.unskip) {
            store.setSkipped(habit, day, false)
            feedback = null
            val position = order.indexOf(habit.id)
            if (position >= 0 && position != index) navigate(position)
        } else if (entry != null) {
            store.undoEntry(entry)
            feedback = Feedback(PlayerWords.UNDONE, habit.id, null, unskip = false, serial = ++serial)
        }
    }

    fun clearFeedback(shown: Int) {
        if (feedback?.serial == shown) feedback = null
    }

    /** Typing time pauses a running timer first, so the same minutes are never counted twice; it runs again after. */
    fun openLog(habit: Habit, nav: PlayerNav) {
        if (!live) return
        var resume = false
        if (habit.kind == HabitKind.Duration && store.timers.containsKey(habit.id)) {
            store.stopTimer(habit, day, source = EntrySource.ROUTINE)
            resume = true
        }
        feedback = null
        manualText.value = habit.id + "|" + (if (resume) "1" else "0") + "|" + joinIds(store.entries(habit.id, day).map { it.id })
        nav.addLog(habit, day)
    }

    fun pickUpManualLog() {
        val text = manualText.value
        if (text.isEmpty()) return
        manualText.value = ""
        val parts = text.split("|")
        if (parts.size < 3) return
        val habit = store.habit(parts[0]) ?: return
        val before = splitIds(parts[2]).toHashSet()
        val added = store.entries(habit.id, day).lastOrNull { it.id !in before }
        if (added != null) feedback = Feedback(PlayerWords.SAVED, habit.id, added.id, unskip = false, serial = ++serial)
        if (parts[1] == "1" && live && habit.kind == HabitKind.Duration && !store.timers.containsKey(habit.id) && !done(habit)) {
            store.toggleTimer(habit, slotOf(habit))
        }
    }

    /**
     * ✕, Done and back: the player goes and a running timer keeps running (Figma 8.4): Today's row keeps its clock, and
     * outside the app its Live Update (10).
     */
    fun close(onClose: () -> Unit) {
        onClose()
    }

    /** A routine stays on its day: a timer still running is stopped at that day's end, never counting into the next. */
    fun expire() {
        if (expiredState.value) return
        expiredState.value = true
        feedback = null
        val habit = current ?: return
        if (store.timers.containsKey(habit.id)) {
            store.stopTimer(habit, day, end = minOf(store.clock(), store.rules.dayBounds(day).last), source = EntrySource.ROUTINE)
        }
    }
}

// ---------------------------------------------------------------------------------------------- The top

/**
 * ✕ · "Anytime ▾" (one line; it opens Your routine, as Calendar's "October ▾") · ⋮ with Go to first unfinished, Change
 * order and End routine (Figma 7; Day details is the card's chip, Your routine the title). 64 high, 4 at the sides;
 * the title in Title Large Emphasized On surface, 4 in, with ▾ in On surface variant (Figma's Routine player, 5.4.1).
 */
@Composable
private fun PlayerTopBar(
    title: String, spoken: String, enabled: Boolean, canGoToFirst: Boolean,
    onClose: () -> Unit, onQueue: () -> Unit, onChangeOrder: () -> Unit, onFirstUnfinished: () -> Unit, onEnd: () -> Unit,
) {
    val c = appColors
    var menu by remember { mutableStateOf(false) }
    Row(Modifier.fillMaxWidth().heightIn(min = 64.dp).padding(horizontal = 4.dp), verticalAlignment = Alignment.CenterVertically) {
        StandardIconButton(Symbols.Close, "Close", onClose, Modifier.semantics { testTag = "player-close" })
        Box(Modifier.weight(1f).padding(start = 4.dp)) {
            Row(
                Modifier.clip(RoundedCornerShape(12.dp))
                    .clickable(enabled = enabled, onClickLabel = "View and reorder the routine", role = Role.Button, onClick = onQueue)
                    .heightIn(min = 48.dp).padding(end = 4.dp)
                    .semantics(mergeDescendants = true) { contentDescription = spoken; testTag = "routine-queue" },
                verticalAlignment = Alignment.CenterVertically,
            ) {
                Text(title, Modifier.weight(1f, fill = false), style = AppType.titleLargeEmphasized,
                    color = c.ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
                Icon(Symbols.ArrowDropDown, null, tint = c.secondary)
            }
        }
        Box {
            StandardIconButton(Symbols.MoreVert, "Routine options", { menu = true }, Modifier.semantics { testTag = "player-more" }, enabled = enabled)
            @Composable fun item(text: String, icon: ImageVector, tag: String, on: Boolean = true, action: () -> Unit) =
                AppMenuItem(text, { menu = false; action() }, icon = icon, enabled = on, tag = tag)
            // Two groups, 2 apart (Figma's Grouped menu): moving through the routine, then ending it.
            AppGroupedMenu(menu, { menu = false }, listOf(
                {
                    item("Go to first unfinished", Symbols.FirstPage, "player-menu-first", canGoToFirst, onFirstUnfinished)
                    item("Change order", Symbols.SwapVert, "player-menu-order", action = onChangeOrder)
                },
                { item("End routine", Symbols.StopCircle, "player-menu-end", action = onEnd) },
            ))
        }
    }
}

/**
 * Where the routine is (Figma's Routine progress, 5.4.1): Material's own linear progress indicator (1.20, Style=Flat), 4
 * high with a 4 gap and a stop dot, and "4 of 12" 12 after it in Label Medium On surface variant; 16 at the sides, 4
 * above, 12 below. One bar works for 25 habits, where 25 segments don't.
 */
@Composable
private fun RoutineProgress(position: Int, count: Int, spoken: String) {
    val c = appColors
    val fraction = if (count == 0) 0f else (position.toFloat() / count).coerceIn(0f, 1f)
    Row(
        // At least 16 high; larger text grows the row rather than clipping "5 of 12" (Figma 1.5).
        Modifier.fillMaxWidth().padding(start = 16.dp, end = 16.dp, top = 4.dp, bottom = 12.dp).heightIn(min = 16.dp)
            .semantics(mergeDescendants = true) { contentDescription = spoken; testTag = "routine-segments" },
        verticalAlignment = Alignment.CenterVertically,
    ) {
        LinearProgressIndicator({ fraction }, Modifier.weight(1f))
        Spacer(Modifier.width(12.dp))
        Text(PlayerWords.position(position - 1, count), style = AppType.labelMedium, color = c.secondary, maxLines = 1,
            modifier = Modifier.semantics { testTag = "routine-position" })
    }
}

// ---------------------------------------------------------------------------------------------- A habit's page

@Composable
private fun HabitPage(id: String, session: PlayerSession, nav: PlayerNav, playRibbon: Boolean = false) {
    val store = session.store
    val day = session.day
    val habit = store.habit(id)
    if (habit == null) {
        GoneCard()
        return
    }
    val rev = store.revision(habit.id)
    val live = session.live
    val skipped = session.skipped(habit)
    val ruled = remember(habit, rev) { store.rule(habit, day) }
    val timed = ruled.kind == HabitKind.Duration
    // A milestone reached today: a ribbon slides into the top of the hero card and stays on this habit's page (RP.1).
    val shown = store.milestones.shown(habit.id)
    val milestone = remember(rev, shown) { if (day == store.today()) store.milestones.visible(habit) else null }
    HeroCard(
        habit = habit, ruled = ruled, day = day, store = store, rev = rev, skipped = skipped,
        milestone = milestone?.let { remember(it) { store.milestones.words(it, habit).band } }, playMilestone = playRibbon,
        onDay = { nav.openDay(habit, day) },
        // A tap on the clock types time (the iPhone's FocusClock).
        onCountTap = if (timed && live && !skipped) ({ session.openLog(habit, nav) }) else null,
        description = store.descriptions[habit.id],
        onStep = if (live && !skipped) ({ step: Step, _: Boolean -> session.toggleStep(habit, step) }) else null,
    )
}

/**
 * The Expressive hero card (Figma's Routine player, 5.4.1), shared with the timer screen: Surface container lowest,
 * corners 32; the habit's icon in the cookie, its name, its description, the day chip, the count ("2 of 8 glasses", a
 * running clock, or "Not done" / "Done") and the wavy bar. A checklist's card holds only its header, and its steps
 * follow under it. Only the count and the bar read the ticking clock, and only while the timer runs (S3).
 */
@Composable
internal fun HeroCard(
    habit: Habit, ruled: Habit, day: Int, store: HabitStore, rev: Int, skipped: Boolean,
    onDay: (() -> Unit)?, onCountTap: (() -> Unit)?, onStep: ((Step, Boolean) -> Unit)?, modifier: Modifier = Modifier,
    /** "30 days in a row · reached today": the ribbon across the card's top (RP.1); [playMilestone]: it was just reached. */
    milestone: String? = null, playMilestone: Boolean = false,
    /** The habit's description, under its name: two lines at most, then … (Figma 1.6). */
    description: String? = null,
    /** Between the cookie and the name, and between the name, the description and the day chip: Figma's Routine player
     *  draws 24 and 8 (5.4.1), its Timer screen 28 and 12 (5.3.7). */
    identityGap: Dp = 24.dp, namingGap: Dp = 8.dp,
    /** The Timer screen's filled day chip with its › (Figma 705:7745); the player's is outlined. */
    filledDayChip: Boolean = false,
) {
    val c = appColors
    val running = ruled.kind == HabitKind.Duration && day == store.today() && store.timers.containsKey(habit.id)
    // A single check or a task says Not done / Done in place of "0 of 1" (Figma's Value, 5.4.1).
    val single = ruled.kind == HabitKind.Task ||
        (ruled.kind == HabitKind.Check && ruled.frequency.isDayBased && store.rules.goal(ruled) <= 1.0 && ruled.checkUnit == null)
    val tick = rememberTicker(running, store.clock)
    val goal = remember(ruled, rev) { store.rules.goal(ruled) }
    // Today, or the day named in full on any other ("Mon 13 Oct", Figma 1.4): the logs go to it.
    val dayText = if (day == store.today()) "Today" else com.oftenenough.app.data.pageDayDate(day)
    val checklist = ruled.kind == HabitKind.Checklist
    // Just reached: the cookie pops with a burst of twelve dots as Mark done fills it (RP.1, 0.18–1.0 s of 2.4 s).
    val pop = com.oftenenough.app.ui.today.rememberPlay(if (playMilestone && milestone != null) "pop-${habit.id}" else null, playMilestone && milestone != null, 2400)
    val cookie = Modifier.graphicsLayer {
        val sc = com.oftenenough.app.ui.components.track(pop, com.oftenenough.app.ui.components.Key(0f, 1f), com.oftenenough.app.ui.components.Key(0.075f, 1f, PopEaseOut),
            com.oftenenough.app.ui.components.Key(0.167f, 1.12f, PopEaseInOut), com.oftenenough.app.ui.components.Key(0.258f, 1f))
        scaleX = sc; scaleY = sc
    }.cookieBurst(pop, c.habit(habit.color))
    val ribbon: @Composable () -> Unit = {
        if (milestone != null) key("ribbon-${habit.id}-$milestone") {
            MilestoneRibbonArrival(playMilestone) { MilestoneRibbon(milestone, habit.color, play = playMilestone) }
        }
    }
    val status = playerStatus(habit, ruled, day, store, goal, rev, tick, running, skipped)
    if (checklist) {
        // Figma's Checklist (any number of steps): the card holds the header, 20 by 24 in: the cookie (72), 12, the name
        // in Headline Medium Emphasized, the description and the day chip 6 apart, 16, the wave with "1 of 4 steps" 12
        // after it. The steps are the action: their own group 12 under the card, scrolling when they don't fit.
        Column(modifier.fillMaxSize().padding(bottom = 16.dp), verticalArrangement = Arrangement.spacedBy(12.dp)) {
            Card(Modifier.fillMaxWidth().semantics { testTag = "player-hero" }, shape = RoundedCornerShape(32.dp)) {
                ribbon()
                Column(Modifier.fillMaxWidth().padding(horizontal = 24.dp, vertical = 20.dp), horizontalAlignment = Alignment.CenterHorizontally) {
                    HabitIcon(habit.symbol, habit.color, size = 72.dp, shape = CookieShape(), modifier = cookie, glyph = 0.44f)
                    Spacer(Modifier.height(12.dp))
                    HabitName(habit.name, AppType.headlineMediumEmphasized, TextAlign.Center, maxLines = 2)
                    if (!description.isNullOrBlank()) {
                        Spacer(Modifier.height(6.dp))
                        Description(description)
                    }
                    // The chip's 48 dp target already gives 8 above and below it.
                    DayChip(dayText, onDay)
                    Spacer(Modifier.height(8.dp))
                    val total = ruled.steps.size
                    val done = remember(habit, rev) { ruled.steps.count { store.isStepDone(it, habit, day) } }
                    Row(Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
                        ProgressLine(habit, ruled, day, store, goal, rev, tick, running, neutral = status?.neutral == true, Modifier.weight(1f), inset = 0.dp)
                        Spacer(Modifier.width(12.dp))
                        Text("$done of $total ${if (total == 1) "step" else "steps"}", Modifier.semantics { testTag = "player-count" },
                            style = AppType.labelLarge, color = c.secondary, maxLines = 1)
                    }
                    if (status != null) {
                        Spacer(Modifier.height(12.dp))
                        StatusLine(status)
                    }
                }
            }
            val scroll = rememberScrollState()
            Box(Modifier.weight(1f, fill = false).fillMaxWidth()) {
                Column(Modifier.verticalScroll(scroll)) { StepRows(habit, ruled, day, store, rev, c.habit(habit.color), onStep) }
                if (scroll.canScrollForward) {
                    Box(Modifier.align(Alignment.BottomCenter).fillMaxWidth().height(56.dp)
                        .background(Brush.verticalGradient(listOf(c.screen.copy(alpha = 0f), c.screen))))
                }
            }
        }
        return
    }
    Card(modifier.fillMaxSize().semantics { testTag = "player-hero" }, shape = RoundedCornerShape(32.dp)) {
        ribbon()
        // Figma's Habit (and the Timer screen, 5.3.7): 32 above and below, 24 at the sides; the cookie (144, its glyph 64),
        // [identityGap], the name, the description and the day chip [namingGap] apart; 32; the count; 32; the wave, and a
        // status line 12 under it; all centred in the card. Large text (Figma's Habit · 200% text, from Android's font
        // scale 1.5): the cookie 96, 24 by 16 in, 16 under the cookie and 20 between the parts; the card scrolls.
        val large = LocalDensity.current.fontScale >= 1.5f
        val part = if (large) 20.dp else 32.dp
        BoxWithConstraints(Modifier.weight(1f).fillMaxWidth()) {
            val minHeight = maxHeight
            Column(
                Modifier.fillMaxWidth().verticalScroll(rememberScrollState()).heightIn(min = minHeight)
                    .padding(horizontal = if (large) 16.dp else 24.dp, vertical = if (large) 24.dp else 32.dp),
                verticalArrangement = Arrangement.Center, horizontalAlignment = Alignment.CenterHorizontally,
            ) {
                HabitIcon(habit.symbol, habit.color, size = if (large) 96.dp else 144.dp, shape = CookieShape(), modifier = cookie, glyph = 0.44f)
                Spacer(Modifier.height(if (large) 16.dp else identityGap))
                HabitName(habit.name, AppType.headlineLargeEmphasized, TextAlign.Center, maxLines = 2)
                if (!description.isNullOrBlank()) {
                    Spacer(Modifier.height(namingGap))
                    Description(description)
                }
                // The chip is 32 high with a 48 target: the gap above it is [namingGap] less the target's 8.
                Spacer(Modifier.height(namingGap - 8.dp))
                DayChip(dayText, onDay, filled = filledDayChip)
                // [part] under the chip, less its target's 8.
                Spacer(Modifier.height(part - 8.dp))
                if (single) SingleState(habit, day, store, rev)
                else CountLine(habit, ruled, day, store, goal, rev, tick, running, center = true, baseStyle = AppType.displayLarge, onTap = onCountTap)
                Spacer(Modifier.height(part))
                ProgressLine(habit, ruled, day, store, goal, rev, tick, running, neutral = status?.neutral == true)
                if (status != null) {
                    Spacer(Modifier.height(12.dp))
                    StatusLine(status)
                }
            }
        }
    }
}

/** A single check or a task: "Not done" or "Done", Display Large On surface (Figma's Value, 5.4.1). */
@Composable
private fun SingleState(habit: Habit, day: Int, store: HabitStore, rev: Int) {
    val c = appColors
    val done = remember(habit, rev) { store.rules.isComplete(habit, day) }
    Text(if (done) PlayerWords.DONE else PlayerWords.NOT_DONE, Modifier.heightIn(min = 64.dp).wrapContentHeight().semantics { testTag = "player-count" },
        style = AppType.displayLarge, color = c.ink, textAlign = TextAlign.Center)
}

/** The line under the count: an icon and a few neutral words (U3). [neutral]: the bar turns grey (over a limit, 9.2). */
private data class PlayerStatus(val icon: ImageVector, val text: String, val neutral: Boolean = false, val tag: String)

/**
 * Which status line a habit shows, if any: skipped (6.1); a time limit gone over (9.2); a timer at its goal (4.3) or
 * paused (4.2, 9.1); a week total of time ("1 h 45 min of 3 h this week", 4.5); N days a week ("1 of 3 days this week",
 * 4.4); a check by the week done for today (2.4). Only the timer's lines read the ticking clock (S3).
 */
@Composable
private fun playerStatus(habit: Habit, ruled: Habit, day: Int, store: HabitStore, goal: Double, rev: Int, tick: State<Long>,
                         running: Boolean, skipped: Boolean): PlayerStatus? {
    if (skipped) return PlayerStatus(Symbols.FastForward, PlayerWords.SKIPPED, tag = "player-skipped")
    val today = day == store.today()
    val f = ruled.frequency
    if (ruled.kind == HabitKind.Duration) {
        if (pageIsTotal(ruled)) {
            val total = if (running) store.rules.progress(habit, day, tick.value) else remember(habit, rev) { store.rules.progress(habit, day) }
            return PlayerStatus(Symbols.DateRange, Format.minutes(total) + " of " + Format.minutes(goal) + PlayerWords.period(f), tag = "player-status")
        }
        val now = if (running) store.rules.dayProgress(habit, day, tick.value) else remember(habit, rev) { store.rules.dayProgress(habit, day) }
        val dayGoal = remember(ruled, rev) { store.rules.dayGoal(ruled) }
        if (ruled.atMost && dayGoal > 0 && now > dayGoal) return PlayerStatus(Symbols.Info, PlayerWords.OVER_LIMIT, neutral = true, tag = "player-status")
        if (!ruled.atMost && dayGoal > 0 && now >= dayGoal) return PlayerStatus(Symbols.Check, PlayerWords.GOAL_MET, tag = "player-status")
        if (today && !running && now > 0) return PlayerStatus(Symbols.Filled.Pause, PlayerWords.PAUSED, tag = "player-status")
    }
    if (f is Frequency.Flexible && ruled.kind != HabitKind.Check && ruled.kind != HabitKind.Task) {
        val days = remember(habit, rev) { store.rules.flexibleProgress(habit, day) } ?: 0
        return PlayerStatus(Symbols.EventAvailable, "$days of ${f.n} days " + (if (f.period == GoalPeriod.MONTH) "this month" else "this week"), tag = "player-status")
    }
    if (ruled.kind == HabitKind.Check && !f.isDayBased) {
        val doneToday = remember(habit, rev) { store.rules.isSatisfied(habit, day) && !store.rules.isPeriodMet(habit, day) }
        if (doneToday) return PlayerStatus(Symbols.Check, PlayerWords.DONE_FOR_TODAY, tag = "player-status")
    }
    return null
}

/** The status line (Figma's Status, Timer screen 5.3.7): an 18 dp icon, 4, the words in Label Large, On surface variant. */
@Composable
private fun StatusLine(s: PlayerStatus) {
    val c = appColors
    Row(Modifier.heightIn(min = 20.dp).semantics(mergeDescendants = true) { testTag = s.tag }, verticalAlignment = Alignment.CenterVertically) {
        Icon(s.icon, null, Modifier.size(18.dp), tint = c.secondary)
        Spacer(Modifier.width(4.dp))
        Text(s.text, style = AppType.labelLarge, color = c.secondary, maxLines = 2, textAlign = TextAlign.Center)
    }
}

private val PopEaseOut = androidx.compose.animation.core.CubicBezierEasing(0f, 0f, 0.58f, 1f)
private val PopEaseInOut = androidx.compose.animation.core.CubicBezierEasing(0.42f, 0f, 0.58f, 1f)
private val PopEaseIn = androidx.compose.animation.core.CubicBezierEasing(0.42f, 0f, 1f, 1f)

/** RP.1's burst round the cookie: a ring growing 0.8 → 1.3 and twelve dots flying out 24 dp, each a little later. */
private fun Modifier.cookieBurst(t: Float, color: Color): Modifier = drawWithContent {
    drawContent()
    if (t <= 0.125f || t >= 0.43f) return@drawWithContent
    val centre = androidx.compose.ui.geometry.Offset(size.width / 2, size.height / 2)
    val radius = size.minDimension / 2
    val ra = com.oftenenough.app.ui.components.track(t, com.oftenenough.app.ui.components.Key(0f, 0f), com.oftenenough.app.ui.components.Key(0.125f, 0f, PopEaseOut),
        com.oftenenough.app.ui.components.Key(0.146f, 0.6f, PopEaseOut), com.oftenenough.app.ui.components.Key(0.354f, 0f))
    val rs = com.oftenenough.app.ui.components.track(t, com.oftenenough.app.ui.components.Key(0f, 0.8f), com.oftenenough.app.ui.components.Key(0.125f, 0.8f, PopEaseOut), com.oftenenough.app.ui.components.Key(0.354f, 1.3f))
    if (ra > 0f) drawCircle(color.copy(alpha = ra), radius * rs, centre, style = androidx.compose.ui.graphics.drawscope.Stroke(2.dp.toPx()))
    for (i in 0 until 12) {
        val start = 0.125f + 0.0042f * i
        val a = Math.toRadians(15.0 + 30.0 * i)
        val da = com.oftenenough.app.ui.components.track(t, com.oftenenough.app.ui.components.Key(0f, 0f), com.oftenenough.app.ui.components.Key(start, 0f, PopEaseOut),
            com.oftenenough.app.ui.components.Key(start + 0.033f, 1f, PopEaseIn), com.oftenenough.app.ui.components.Key(start + 0.25f, 0f))
        val ds = com.oftenenough.app.ui.components.track(t, com.oftenenough.app.ui.components.Key(0f, 0.6f), com.oftenenough.app.ui.components.Key(start, 0.6f, PopEaseOut),
            com.oftenenough.app.ui.components.Key(start + 0.0625f, 1f, PopEaseIn), com.oftenenough.app.ui.components.Key(start + 0.25f, 0.3f))
        val r = radius + com.oftenenough.app.ui.components.track(t, com.oftenenough.app.ui.components.Key(0f, 0f), com.oftenenough.app.ui.components.Key(start, 0f, PopEaseOut),
            com.oftenenough.app.ui.components.Key(start + 0.167f, 24f)) * density
        if (da > 0f) drawCircle(color.copy(alpha = da), (if (i % 2 == 0) 3.5f else 2.5f) * density * ds,
            androidx.compose.ui.geometry.Offset(centre.x + (kotlin.math.cos(a) * r).toFloat(), centre.y + (kotlin.math.sin(a) * r).toFloat()))
    }
}

/** The habit's description under its name: Body Large On surface variant, centred, two lines at most, then … */
@Composable
private fun Description(text: String) =
    Text(text, Modifier.fillMaxWidth().semantics { testTag = "player-description" },
        style = AppType.bodyLarge, color = appColors.secondary, textAlign = TextAlign.Center, maxLines = 2, overflow = TextOverflow.Ellipsis)

@Composable
private fun HabitName(name: String, style: TextStyle, align: TextAlign, maxLines: Int) {
    Text(
        name, style = style,
        color = appColors.ink, textAlign = align, maxLines = maxLines, overflow = TextOverflow.Ellipsis,
        modifier = Modifier.semantics { heading(); testTag = "player-name" },
    )
}

/** "📅 Today": an assist chip (1.16) that opens Day details for this habit and day (also first in ⋮). */
@Composable
internal fun DayChip(text: String, onClick: (() -> Unit)?, filled: Boolean = false) =
    AppAssistChip(text, onClick ?: {}, enabled = onClick != null, tag = "player-day-chip", filled = filled)

/** The count, large, with what it's out of beside it on the same baseline. While a timer runs, only this and the bar tick. */
@Composable
private fun CountLine(
    habit: Habit, ruled: Habit, day: Int, store: HabitStore, goal: Double, rev: Int, tick: State<Long>, running: Boolean,
    center: Boolean, baseStyle: TextStyle, onTap: (() -> Unit)?,
) {
    val c = appColors
    // A week total of time shows today's time big, "today" beside it, and the week under it (Figma 4.5).
    val weekTime = ruled.kind == HabitKind.Duration && pageIsTotal(ruled)
    val dayGoal = remember(ruled, rev) { store.rules.dayGoal(ruled) }
    // N days a week counts today's time against the day's goal (4.4).
    val byDay = ruled.kind == HabitKind.Duration && ruled.frequency is Frequency.Flexible
    val progress = when {
        weekTime || byDay -> if (running) store.rules.dayProgress(habit, day, tick.value) else remember(habit, rev) { store.rules.dayProgress(habit, day) }
        running -> store.rules.progress(habit, day, tick.value)
        else -> remember(habit, rev) { store.rules.progress(habit, day) }
    }
    val value = PlayerWords.value(ruled, progress)
    val target = when {
        weekTime -> "today"
        byDay -> "of " + Format.minutes(dayGoal)
        else -> PlayerWords.target(ruled, goal)
    }
    // A long clock ("1:23:45") steps down one style rather than shrinking to a size of its own.
    val style = if (value.length > 5) (if (baseStyle == AppType.displayLarge) AppType.displayMedium else AppType.displaySmall) else baseStyle
    Row(
        Modifier.fillMaxWidth()
            .let { if (onTap != null) it.clip(RoundedCornerShape(16.dp)).clickable(onClickLabel = "Log time manually", role = Role.Button, onClick = onTap) else it }
            .semantics(mergeDescendants = true) { contentDescription = "$value $target"; testTag = "player-count" },
        horizontalArrangement = if (center) Arrangement.Center else Arrangement.Start,
        verticalAlignment = Alignment.Bottom,
    ) {
        Text(value, Modifier.alignByBaseline(), style = style.copy(fontFeatureSettings = "tnum"),
            color = c.ink, maxLines = 1)
        Spacer(Modifier.width(8.dp))
        Text(target, Modifier.alignByBaseline().weight(1f, fill = false), style = AppType.bodyLarge,
            color = c.secondary, maxLines = 2, overflow = TextOverflow.Ellipsis)
    }
}

/**
 * Expressive's wavy bar in the habit's colour (a limit's too: its words say "max", never red, U3). Over a limit it's a
 * full grey line (Figma 9.2); a week total fills toward the week (4.5). 8 in from the card's content, as Figma (32 of 328).
 */
@Composable
private fun ProgressLine(habit: Habit, ruled: Habit, day: Int, store: HabitStore, goal: Double, rev: Int, tick: State<Long>, running: Boolean, neutral: Boolean,
                         modifier: Modifier = Modifier, inset: Dp = 8.dp) {
    val c = appColors
    val color = c.habit(habit.color)
    val byDay = ruled.kind == HabitKind.Duration && ruled.frequency is Frequency.Flexible
    val progress = when {
        byDay -> if (running) store.rules.dayProgress(habit, day, tick.value) else remember(habit, rev) { store.rules.dayProgress(habit, day) }
        running -> store.rules.progress(habit, day, tick.value)
        else -> remember(habit, rev) { store.rules.progress(habit, day) }
    }
    val target = if (byDay) remember(ruled, rev) { store.rules.dayGoal(ruled) } else goal
    val fraction = (progress / maxOf(target, 0.001)).toFloat().coerceIn(0f, 1f)
    val bar = modifier.fillMaxWidth().padding(horizontal = inset).height(16.dp)
        .semantics { progressBarRangeInfo = ProgressBarRangeInfo(fraction, 0f..1f); testTag = "player-bar" }
    if (neutral) {
        Box(bar, contentAlignment = Alignment.Center) {
            Box(Modifier.fillMaxWidth().height(4.dp).clip(CircleShape).background(c.secondary))
        }
    } else if (ruled.atMost) {
        // A limit isn't a goal: its wave stays neutral, Outline on Outline variant (Figma's Today, flow 45).
        val s = MaterialTheme.colorScheme
        WavyProgress(fraction, bar, s.outline, s.outlineVariant)
    } else {
        WavyProgress(fraction, bar, color, c.habitFill(habit.color))
    }
}

/**
 * A checklist's steps: the work itself, under the card (Figma's player checklist; molecule 4.3): each a [StepRow] of
 * its own, a white segment 2 apart with the group's corners, the ticked box in the habit's colour.
 */
@Composable
private fun StepRows(habit: Habit, ruled: Habit, day: Int, store: HabitStore, rev: Int, color: Color, onStep: ((Step, Boolean) -> Unit)?) {
    val count = ruled.steps.size
    Column(Modifier.fillMaxWidth().semantics { testTag = "player-steps" }, verticalArrangement = Arrangement.spacedBy(2.dp)) {
        ruled.steps.forEachIndexed { i, step ->
            val done = store.isStepDone(step, habit, day)
            StepRow(step.name, done, color, place = StepRowPlace.Player, enabled = onStep != null, shape = segmentShape(i, count),
                tag = "player-step-$i", onToggle = { onStep?.invoke(step, done) })
        }
    }
}

/** A habit archived or deleted while the routine runs. */
@Composable
internal fun GoneCard() {
    Card(Modifier.fillMaxSize(), shape = RoundedCornerShape(32.dp)) {
        Box(Modifier.fillMaxSize().padding(24.dp), contentAlignment = Alignment.Center) {
            Text("This habit is no longer here", style = MaterialTheme.typography.titleLarge, color = appColors.secondary, textAlign = TextAlign.Center)
        }
    }
}

// ---------------------------------------------------------------------------------------------- The buttons

/** ‹ · the main action · ›, 96 high, like media controls. A checklist has no main action: ‹ and › share the row. */
@Composable
private fun HabitButtons(session: PlayerSession, habit: Habit?, nav: PlayerNav) {
    val store = session.store
    val day = session.day
    val index = session.index
    val order = session.order
    val action: MainAction? = if (habit == null) null else {
        val rev = store.revision(habit.id)
        val timers = store.timers
        val isToday = session.isToday
        remember(habit, rev, timers, index, order.size, isToday) {
            val ruled = store.rule(habit, day)
            PlayerWords.mainAction(ruled, store.rules.goal(ruled), session.done(habit), session.skipped(habit), index == order.size - 1,
                timers.containsKey(habit.id), store.rules.dayProgress(habit, day) > 0, today = isToday)
        }
    }
    val next = order.getOrNull(index + 1)?.let { store.habit(it) }
    val wide = action == null || action.action == PlayerAction.NONE

    fun perform(a: PlayerAction, h: Habit) {
        val slot = if (h.kind == HabitKind.Check && !h.atMost) session.slotOf(h) else null
        when (a) {
            PlayerAction.NEXT, PlayerAction.FINISH -> session.advance()
            PlayerAction.MARK_DONE -> session.change(h, PlayerWords.SAVED) {
                if (slot != null) store.toggleSlot(h, slot, day, EntrySource.ROUTINE) else store.toggleCheck(h, day, EntrySource.ROUTINE)
            }
            // "Log one" adds one, as it says: a ✓ toggles its day (U14), so it never takes the first one back.
            PlayerAction.LOG_ONE -> session.change(h, if (h.atMost) PlayerWords.LOGGED else PlayerWords.SAVED) {
                if (slot != null) store.toggleSlot(h, slot, day, EntrySource.ROUTINE) else store.addProgress(h, 1.0, day, source = EntrySource.ROUTINE)
            }
            PlayerAction.LOG_STEP -> session.change(h, if (h.atMost) PlayerWords.LOGGED else PlayerWords.SAVED) {
                store.increment(h, day, EntrySource.ROUTINE)
            }
            PlayerAction.LOG_AMOUNT -> session.openLog(h, nav)
            PlayerAction.START, PlayerAction.RESUME -> session.startTimer(h)
            PlayerAction.PAUSE -> session.pauseTimer(h)
            PlayerAction.NONE -> {}
        }
    }

    // Figma's Bottom bar: 12 above and below, 16 at the sides, 8 apart.
    Row(Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 12.dp).height(96.dp), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
        AppLargeIconButton(Symbols.KeyboardArrowLeft, "Previous habit", { session.navigate(index - 1) },
            if (wide) Modifier.weight(1f) else Modifier, tonal = true, width = if (wide) LargeIconWidth.Fill else LargeIconWidth.Narrow,
            enabled = index > 0, tag = "player-previous")
        if (!wide && action != null && habit != null) {
            // "+1" and "Log" are words alone (Figma 3, 3.3).
            MainButton(actionIcon(action.action), action.label, action.spoken, "player-main", Modifier.weight(1f)) { perform(action.action, habit) }
        }
        AppLargeIconButton(Symbols.KeyboardArrowRight, next?.let { "Next habit: ${it.name}" } ?: "Finish routine",
            { session.advance() }, if (wide) Modifier.weight(1f) else Modifier, tonal = true,
            width = if (wide) LargeIconWidth.Fill else LargeIconWidth.Narrow, tag = "player-next")
    }
}

private fun actionIcon(a: PlayerAction): ImageVector? = when (a) {
    PlayerAction.NEXT -> Symbols.ArrowForward
    PlayerAction.FINISH, PlayerAction.MARK_DONE, PlayerAction.LOG_ONE, PlayerAction.NONE -> Symbols.Check
    PlayerAction.LOG_STEP, PlayerAction.LOG_AMOUNT -> null
    PlayerAction.START, PlayerAction.RESUME -> Symbols.Filled.PlayArrow
    PlayerAction.PAUSE -> Symbols.Filled.Pause
}

/**
 * The one main action: the Large square Filled button (2.1, Figma's Screen=Habit, Checklist, End). Its label is one line
 * and ends in … when long; TalkBack reads the whole of [spoken].
 */
@Composable
internal fun MainButton(icon: ImageVector?, label: String, spoken: String, tag: String, modifier: Modifier, onClick: () -> Unit) =
    AppButton(label, onClick, modifier.fillMaxHeight().semantics { contentDescription = spoken }, size = ButtonSize.Large,
        icon = icon, square = true, tag = tag)

/** A tonal button beside [MainButton] ("Log time": Large square Tonal, Figma's Timer screen). */
@Composable
internal fun TonalBigButton(icon: ImageVector?, label: String, tag: String, modifier: Modifier, onClick: () -> Unit) =
    AppButton(label, onClick, modifier, style = ButtonStyle.Tonal, size = ButtonSize.Large, icon = icon, square = true, tag = tag)

// ---------------------------------------------------------------------------------------------- The save message

@Composable
private fun FeedbackBar(f: Feedback, onUndo: () -> Unit, onNote: () -> Unit, modifier: Modifier) =
    // The note belongs right after logging, next to Undo; never asked for.
    AppSnackbar(f.message,
        if (f.canUndo) listOf(SnackbarAction("Undo", "player-undo", onUndo), SnackbarAction("Add note", "player-add-note", onNote)) else emptyList(),
        modifier.semantics { testTag = "player-snackbar" })

// ---------------------------------------------------------------------------------------------- The end

/**
 * The end (Figma's Routine player, Screen=End): the card (Surface container lowest, corners 32, 28 by 24 in), the
 * cookie (112, Inverse surface, done_all, or history with some left) 16 over the title ("Morning is done", Headline
 * Medium Emphasized On surface) and what it means ("All 3 done today.", Body Large On surface variant), 8 apart; then,
 * 24 apart, the sections, each its title in Label Large Primary 16 in, 8 over its rows (two-line List items on Surface
 * bright, 2 apart: the habit's icon, its name, how its day went): Done; Left for later, each row opening that habit
 * again (›); Reached in this routine, each milestone with its medal. Scrolls when it doesn't fit.
 */
@Composable
private fun EndPage(name: String, count: Int, done: List<Habit>, later: List<Pair<Int, Habit>>, result: (Habit) -> String,
    onOpen: (Int) -> Unit, reached: List<Pair<Habit, com.oftenenough.app.data.MilestoneWords>> = emptyList()) {
    val c = appColors
    val s = MaterialTheme.colorScheme
    val remaining = later.size
    Column(Modifier.fillMaxSize().verticalScroll(rememberScrollState()).padding(bottom = 16.dp), verticalArrangement = Arrangement.spacedBy(24.dp)) {
        Card(Modifier.fillMaxWidth().semantics { testTag = "player-end" }, shape = RoundedCornerShape(32.dp)) {
            Column(Modifier.fillMaxWidth().padding(horizontal = 24.dp, vertical = 28.dp), horizontalAlignment = Alignment.CenterHorizontally) {
                // Not a pause symbol: it read as a media button (found by hand on the iPhone, 29 Sep).
                CookieIcon(if (remaining == 0) Symbols.DoneAll else Symbols.History, size = 112.dp, container = s.inverseSurface,
                    tint = s.inverseOnSurface, glyph = 0.5f)
                Spacer(Modifier.height(16.dp))
                Text(PlayerWords.endTitle(remaining, name), style = AppType.headlineMediumEmphasized,
                    color = s.onSurface, textAlign = TextAlign.Center, modifier = Modifier.semantics { heading(); testTag = "player-end-title" })
                Spacer(Modifier.height(8.dp))
                Text(PlayerWords.endText(remaining, count), style = AppType.bodyLarge, color = s.onSurfaceVariant, textAlign = TextAlign.Center)
            }
        }
        @Composable fun section(title: String, tag: String, rows: @Composable () -> Unit) =
            Column(Modifier.fillMaxWidth().semantics { testTag = tag }) {
                Text(title, Modifier.padding(start = 16.dp, bottom = 8.dp).semantics { heading() }, style = AppType.labelLarge, color = s.primary)
                Column(verticalArrangement = Arrangement.spacedBy(SegmentedListGap)) { rows() }
            }
        if (done.isNotEmpty()) section("Done", "player-end-done") {
            done.forEachIndexed { i, h ->
                AppListItem(h.name, i, done.size, supporting = result(h), leading = { HabitIcon(h.symbol, h.color) },
                    containerColor = s.surfaceBright, headlineLines = 1, tag = "player-end-done-${h.name}")
            }
        }
        if (later.isNotEmpty()) section("Left for later", "player-later") {
            later.forEachIndexed { i, (at, h) ->
                AppListItem(h.name, i, later.size, supporting = result(h), leading = { HabitIcon(h.symbol, h.color) },
                    trailing = { ListChevron() }, onClick = { onOpen(at) }, containerColor = s.surfaceBright, headlineLines = 1,
                    tag = "player-later-${h.name}")
            }
        }
        // Every milestone the routine's steps reached, once (Figma RP.2), with the same medal as everywhere.
        if (reached.isNotEmpty()) section("Reached in this routine", "player-reached") {
            reached.forEachIndexed { i, (h, w) ->
                AppListItem(w.title, i, reached.size, supporting = h.name,
                    leading = { com.oftenenough.app.ui.components.Medal(w.number, 40.dp, h.color) },
                    containerColor = s.surfaceBright, headlineLines = 1)
            }
        }
    }
}

/** The end's one way out: Done, the Large square Filled button the full width, in the bottom bar (12 / 16). */
@Composable
private fun EndButtons(onDone: () -> Unit) {
    Box(Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 12.dp).height(96.dp)) {
        MainButton(Symbols.Check, "Done", "Done", "player-done", Modifier.fillMaxWidth(), onClick = onDone)
    }
}

/** The routine's day ended while it was open: its progress stays on that day. */
@Composable
private fun NewDayCard(modifier: Modifier, onBack: () -> Unit) {
    val c = appColors
    Column(modifier.fillMaxWidth().padding(16.dp).verticalScroll(rememberScrollState())) {
        Card(Modifier.fillMaxWidth().semantics { testTag = "player-new-day" }, shape = RoundedCornerShape(32.dp)) {
            Column(Modifier.fillMaxWidth().padding(24.dp), horizontalAlignment = Alignment.CenterHorizontally) {
                CookieIcon(Symbols.WbTwilight, size = 96.dp)
                Spacer(Modifier.height(24.dp))
                Text(PlayerWords.NEW_DAY_TITLE, style = MaterialTheme.typography.headlineMedium, color = c.ink, textAlign = TextAlign.Center,
                    modifier = Modifier.semantics { heading() })
                Spacer(Modifier.height(12.dp))
                Text(PlayerWords.NEW_DAY_TEXT, style = MaterialTheme.typography.bodyLarge, color = c.secondary, textAlign = TextAlign.Center)
                Spacer(Modifier.height(24.dp))
                AppButton("Back to Today", onBack, Modifier.fillMaxWidth(), size = ButtonSize.Medium)
            }
        }
    }
}

// ---------------------------------------------------------------------------------------------- Your routine

/**
 * 5.4.2, **Your routine sheet** (Figma 907:29174, Mode Your routine · Change order; Components — Atoms Build Plan): from
 * the routine's name (Morning ▾) in the player, every habit in this run with where it stands; a tap goes to it (moving
 * never marks anything done). Material's sheet on Surface container with its drag handle; the header, 24 in, 12 at the
 * end, 12 under it: "Your routine" in Title Large Emphasized On surface and Edit (Text); then the habits, 16 at the
 * sides, two-line List items 2 apart on Surface bright (the habit's icon, its name, "Here now" / "Done" / "Not done"),
 * ▶ on the one on screen and ✓ on a done one, in On surface; the footer 12 under them, 24 in, Body Small On surface
 * variant; 24 under it all. Change order: the title "Change order", Done, and a drag handle on every row: drag to
 * change the order for this run only; Today's order stays. TalkBack moves a habit with the row's Move up and Move down.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun RoutineSheet(session: PlayerSession, covered: List<Boolean>, editing: Boolean, onEditing: (Boolean) -> Unit,
                         onJump: (Int) -> Unit, onDismiss: () -> Unit) {
    val s = MaterialTheme.colorScheme
    val store = session.store
    val state = rememberWholeSheetState()
    val order = session.order
    val index = session.index
    val density = LocalDensity.current
    val rowStep = with(density) { (72.dp + SegmentedListGap).toPx() }
    var dragging by remember { mutableStateOf<String?>(null) }
    var dragOffset by remember { mutableFloatStateOf(0f) }
    ModalBottomSheet(onDismiss, Modifier.belowStatusBar(), sheetState = state, containerColor = s.surfaceContainer, contentWindowInsets = { sheetInsets() }) {
        Column(Modifier.fillMaxWidth().verticalScroll(rememberScrollState(), enabled = dragging == null).padding(bottom = 24.dp)
            .semantics { testTag = "routine-sheet" }) {
            Row(Modifier.fillMaxWidth().padding(start = 24.dp, end = 12.dp, bottom = 12.dp).heightIn(min = 40.dp), verticalAlignment = Alignment.CenterVertically) {
                Text(if (editing) "Change order" else "Your routine", Modifier.weight(1f).semantics { heading() },
                    style = AppType.titleLargeEmphasized, color = s.onSurface)
                AppButton(if (editing) "Done" else "Edit", { onEditing(!editing) }, Modifier.semantics { testTag = "routine-edit" }, style = ButtonStyle.Text)
            }
            Column(Modifier.fillMaxWidth().padding(horizontal = 16.dp), verticalArrangement = Arrangement.spacedBy(SegmentedListGap)) {
                order.forEachIndexed { i, id ->
                    val habit = store.habit(id) ?: return@forEachIndexed
                    key(id) {
                        val skipped = session.skipped(habit)
                        val doneToday = session.doneToday(habit)
                        val status = PlayerWords.queueStatus(doneToday, here = i == index)
                        val lifted = dragging == id
                        AppListItem(
                            habit.name, i, order.size,
                            Modifier.zIndex(if (lifted) 1f else 0f)
                                .graphicsLayer { translationY = if (lifted) dragOffset else 0f; shadowElevation = if (lifted) 8f else 0f }
                                .semantics {
                                    if (editing) customActions = listOfNotNull(
                                        if (i > 0) CustomAccessibilityAction("Move up") { session.move(i, i - 1); true } else null,
                                        if (i < order.size - 1) CustomAccessibilityAction("Move down") { session.move(i, i + 1); true } else null,
                                    )
                                },
                            supporting = status,
                            leading = { HabitIcon(habit.symbol, habit.color) },
                            trailing = {
                                if (editing) {
                                    // The handle: a drag here moves the row, one place for each row's height it passes.
                                    Box(
                                        Modifier.size(48.dp).pointerInput(id) {
                                            detectDragGestures(
                                                onDragStart = { dragging = id; dragOffset = 0f },
                                                onDragEnd = { dragging = null; dragOffset = 0f },
                                                onDragCancel = { dragging = null; dragOffset = 0f },
                                            ) { change, amount ->
                                                change.consume()
                                                dragOffset += amount.y
                                                val now = session.order.indexOf(id)
                                                if (dragOffset > rowStep / 2 && now < session.order.size - 1) {
                                                    session.move(now, now + 1); dragOffset -= rowStep
                                                } else if (dragOffset < -rowStep / 2 && now > 0) {
                                                    session.move(now, now - 1); dragOffset += rowStep
                                                }
                                            }
                                        }.semantics { testTag = "queue-drag-${habit.name}" },
                                        contentAlignment = Alignment.Center,
                                    ) {
                                        Icon(Symbols.DragIndicator, "Drag to move ${habit.name}", tint = s.onSurface)
                                    }
                                } else when {
                                    i == index -> Icon(Symbols.Filled.PlayArrow, "Current habit", tint = s.onSurface)
                                    skipped -> Icon(Symbols.FastForward, "Skipped", tint = s.onSurfaceVariant)
                                    covered.getOrNull(i) == true -> Icon(Symbols.Check, "Done", tint = s.onSurface)
                                }
                            },
                            onClick = if (editing) null else ({ onJump(i) }),
                            containerColor = s.surfaceBright,
                            headlineLines = 1,
                            tag = "queue-${habit.name}",
                        )
                    }
                }
            }
            Text(if (editing) PlayerWords.QUEUE_FOOTER_EDIT else PlayerWords.QUEUE_FOOTER, Modifier.padding(start = 24.dp, end = 24.dp, top = 12.dp),
                style = AppType.bodySmall, color = s.onSurfaceVariant)
        }
    }
}
