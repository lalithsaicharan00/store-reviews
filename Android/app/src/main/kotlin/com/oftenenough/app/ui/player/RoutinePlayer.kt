package com.oftenenough.app.ui.player

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
import androidx.compose.foundation.selection.toggleable
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.ArrowForward
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowLeft
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowRight
import androidx.compose.material.icons.automirrored.rounded.List
import androidx.compose.material.icons.automirrored.rounded.Undo
import androidx.compose.material.icons.rounded.Add
import androidx.compose.material.icons.rounded.ArrowDropDown
import androidx.compose.material.icons.rounded.CalendarMonth
import androidx.compose.material.icons.rounded.CalendarToday
import androidx.compose.material.icons.rounded.Check
import androidx.compose.material.icons.rounded.Close
import androidx.compose.material.icons.rounded.Edit
import androidx.compose.material.icons.rounded.FastForward
import androidx.compose.material.icons.rounded.Flag
import androidx.compose.material.icons.rounded.History
import androidx.compose.material.icons.rounded.KeyboardArrowDown
import androidx.compose.material.icons.rounded.KeyboardArrowUp
import androidx.compose.material.icons.rounded.MoreVert
import androidx.compose.material.icons.rounded.Pause
import androidx.compose.material.icons.rounded.PlayArrow
import androidx.compose.material.icons.rounded.WbTwilight
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Checkbox
import androidx.compose.material3.CheckboxDefaults
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.ModalBottomSheet
import androidx.compose.material3.Snackbar
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.rememberModalBottomSheetState
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
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.TextUnit
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleEventObserver
import androidx.lifecycle.compose.LocalLifecycleOwner
import com.oftenenough.app.data.DayWords
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
import com.oftenenough.app.ui.components.InkButton
import com.oftenenough.app.ui.components.Segment
import com.oftenenough.app.ui.components.SegmentedList
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
import com.oftenenough.app.ui.day.LandmarkPopup
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
fun RoutinePlayer(store: HabitStore, part: String, day: Int, habitIds: List<String>, nav: PlayerNav, onClose: () -> Unit) {
    val c = appColors
    val scope = rememberCoroutineScope()
    // The session lives through Add log and Day details (and a rotation): kept as saveable text, never in the database.
    val orderText = rememberSaveable { mutableStateOf(joinIds(habitIds)) }
    val indexState = rememberSaveable { mutableIntStateOf(0) }
    val reviewedText = rememberSaveable { mutableStateOf("") }
    val expiredState = rememberSaveable { mutableStateOf(false) }
    val manualText = rememberSaveable { mutableStateOf("") }
    val opened = rememberSaveable { mutableStateOf(false) }
    var showQueue by rememberSaveable { mutableStateOf(false) }
    val pager = rememberPagerState(initialPage = indexState.intValue) { idCount(orderText.value) + 1 }
    val session = remember(store, part, day) {
        PlayerSession(store, part, day, orderText, indexState, reviewedText, expiredState, manualText, pager, scope)
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

    // On first opening only: the first habit's clock starts if it's timed (P1).
    LaunchedEffect(session) {
        if (!opened.value) { opened.value = true; session.startCurrentTimer() }
    }
    // A new day ends the session on its own day; checked twice a minute, never per frame.
    LaunchedEffect(session) {
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
            subtitle = if (index < order.size) PlayerWords.position(index, order.size) else PlayerWords.covered(coveredCount, order.size),
            spoken = PlayerWords.routineSpoken(sectionName, index, order.size),
            enabled = !expired,
            current = current,
            showFirstUnfinished = firstUnfinished != null && firstUnfinished != index,
            onClose = { session.close(onClose) },
            onQueue = { showQueue = true },
            onDay = { current?.let { nav.openDay(it, day) } },
            onFirstUnfinished = { firstUnfinished?.let { session.navigate(it) } },
            onEnd = { session.navigate(order.size) },
        )
        if (!expired && index < order.size) RoutineSegments(covered, index, PlayerWords.segmentsSpoken(coveredCount, order.size))
        else Spacer(Modifier.height(SEGMENTS_HEIGHT))
        if (expired) {
            NewDayCard(Modifier.weight(1f)) { session.close(onClose) }
        } else {
            Box(Modifier.weight(1f).fillMaxWidth()) {
                HorizontalPager(
                    state = pager,
                    modifier = Modifier.fillMaxSize().semantics { testTag = "routine-pager" },
                    contentPadding = PaddingValues(horizontal = 16.dp),
                    pageSpacing = 8.dp,
                ) { page ->
                    val id = order.getOrNull(page)
                    if (id != null) HabitPage(id, session, nav, playRibbon = ribbonFor == id)
                    else EndPage(
                        remaining = covered.count { !it },
                        skipped = order.count { habitId -> store.habit(habitId)?.let { session.skipped(it) } == true },
                        reviewed = reviewed.size,
                        onReview = { showQueue = true },
                        reached = splitIds(reachedText.value).mapNotNull { hid ->
                            val h = store.habit(hid) ?: return@mapNotNull null
                            center.visible(h)?.let { h to center.words(it, h) }
                        },
                    )
                }
                if (feedback != null) {
                    FeedbackBar(
                        feedback,
                        onUndo = { session.undo(feedback) },
                        onNote = { store.habit(feedback.habitId)?.let { nav.writeNote(it, day) } },
                        modifier = Modifier.align(Alignment.BottomCenter).padding(horizontal = 16.dp, vertical = 8.dp),
                    )
                }
            }
            Spacer(Modifier.height(16.dp))
            if (index >= order.size) {
                EndButtons(
                    hasRemaining = firstUnfinished != null,
                    onReturn = { firstUnfinished?.let { session.navigate(it) } },
                    onDone = { session.close(onClose) },
                )
            } else {
                HabitButtons(session, current, nav)
            }
        }
    }
    if (showQueue && !expired) {
        RoutineSheet(session, covered, onJump = { position -> showQueue = false; session.navigate(position) }, onDismiss = { showQueue = false })
    }
    // A landmark reached in the routine: its pop-up rises over the end screen, once (Figma RP.3).
    if (!endPopupDone && index >= order.size && endPopupText.value.isNotEmpty() && pager.currentPage >= order.size) {
        val h = store.habit(endPopupText.value)
        val shown = h?.let { center.visible(it) }
        if (h == null || shown == null) endPopupDone = true
        else {
            val w = remember(shown) { center.words(shown, h) }
            val others = splitIds(reachedText.value).count { it != h.id && store.habit(it)?.let { o -> center.visible(o) } != null }
            LandmarkPopup(w.number, w.popupTitle, w.popupSubtitle.replace("reached today", "reached in this routine"), h.color, w.next,
                second = w.second, more = if (others > 0) "and $others more in this routine" else null,
                onClose = { endPopupDone = true },
                onAll = { endPopupDone = true; nav.habitPage(h, milestones = shown.track != MilestoneTrack.ANNIVERSARY) })
        }
    }
}

// ---------------------------------------------------------------------------------------------- The session

private const val SEP = ","
/** Habits with more steps than this get the compact header and their steps scroll inside the card (design 05). */
private const val COMPACT_STEPS = 3
/** A timed habit's clock starts when you arrive on it, and the screen says so (the iPhone's P1). */
private const val START_TIMER_ON_ARRIVAL = true
private val SEGMENTS_HEIGHT: Dp = 30.dp

private fun splitIds(text: String): List<String> = if (text.isEmpty()) emptyList() else text.split(SEP)
private fun joinIds(ids: Collection<String>): String = ids.joinToString(SEP)
private fun idCount(text: String): Int = if (text.isEmpty()) 0 else text.count { it == ',' } + 1

/** "Saved · Undo · Add note": the iPhone's banner, as Material's snackbar. [serial] tells one message from the next. */
private data class Feedback(val message: String, val habitId: String, val undoEntry: String?, val unskip: Boolean, val serial: Int) {
    val canUndo: Boolean get() = undoEntry != null || unskip
}

/** The slide the player started (‹ ›, the queue, Return to unfinished), until it ends. Not observed: nothing redraws for it. */
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
    /** Changes are made only on the routine's own day, before a new day starts. */
    val live: Boolean get() = !expired && day == store.today()
    val current: Habit? get() = order.getOrNull(index)?.let { store.habit(it) }

    /** The tick of this time of day, for a check ticked in several times of day (the iPhone's `slots(of:)`). */
    fun slotOf(habit: Habit): String? = store.placements(habit).firstOrNull { it.section == part }?.slot

    /** Nothing more is asked: the main button moves on. A "3 times a week" habit ticked once today still offers "Log one". */
    fun done(habit: Habit): Boolean =
        !habit.atMost && (slotOf(habit)?.let { store.isSlotDone(habit, it, day) } ?: store.rules.isComplete(habit, day))

    /** Done for today: what the segments and Your routine show (a week or month goal, once something is logged today). */
    fun doneToday(habit: Habit): Boolean =
        !habit.atMost && (slotOf(habit)?.let { store.isSlotDone(habit, it, day) } ?: store.rules.isSatisfied(habit, day))

    fun skipped(habit: Habit): Boolean = store.isSkipped(habit, day)

    fun covered(id: String, reviewed: Set<String>): Boolean {
        val habit = store.habit(id) ?: return true
        return if (habit.atMost) id in reviewed else doneToday(habit) || skipped(habit)
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
        slide.job = scope.launch { pager.scrollToPage(target) }
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
        if (!live) return
        feedback = null
        if (!store.timers.containsKey(habit.id)) store.toggleTimer(habit, slotOf(habit))
    }

    fun pauseTimer(habit: Habit) {
        if (!live) return
        feedback = null
        store.stopTimer(habit, day, source = EntrySource.ROUTINE)
    }

    fun saySkipped(habitId: String) {
        feedback = Feedback(PlayerWords.SKIPPED, habitId, null, unskip = true, serial = ++serial)
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
        if (added != null) {
            val message = if (habit.kind == HabitKind.Duration) PlayerWords.TIME_SAVED else PlayerWords.AMOUNT_SAVED
            feedback = Feedback(message, habit.id, added.id, unskip = false, serial = ++serial)
        }
        if (parts[1] == "1" && live && habit.kind == HabitKind.Duration && !store.timers.containsKey(habit.id) && !done(habit)) {
            store.toggleTimer(habit, slotOf(habit))
        }
    }

    /** ✕, Done and back: the habit on screen's time is saved, then the player goes. */
    fun close(onClose: () -> Unit) {
        val habit = current
        if (habit != null && !expired && store.timers.containsKey(habit.id)) store.stopTimer(habit, day, source = EntrySource.ROUTINE)
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

@Composable
private fun PlayerTopBar(
    title: String, subtitle: String, spoken: String, enabled: Boolean, current: Habit?, showFirstUnfinished: Boolean,
    onClose: () -> Unit, onQueue: () -> Unit, onDay: () -> Unit, onFirstUnfinished: () -> Unit, onEnd: () -> Unit,
) {
    val c = appColors
    var menu by remember { mutableStateOf(false) }
    Row(Modifier.fillMaxWidth().heightIn(min = 72.dp).padding(horizontal = 4.dp), verticalAlignment = Alignment.CenterVertically) {
        IconButton(onClose, Modifier.semantics { testTag = "player-close" }) { Icon(Icons.Rounded.Close, "Close", tint = c.ink) }
        Box(Modifier.weight(1f)) {
            // "Anytime ▾ / Habit 4 of 12": one button that opens Your routine.
            Column(
                Modifier.clip(RoundedCornerShape(12.dp))
                    .clickable(enabled = enabled, onClickLabel = "View and reorder the routine", role = Role.Button, onClick = onQueue)
                    .padding(horizontal = 8.dp, vertical = 4.dp)
                    .semantics(mergeDescendants = true) { contentDescription = spoken; testTag = "routine-queue" },
            ) {
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Text(title, Modifier.weight(1f, fill = false), style = AppType.headlineSmall,
                        color = c.ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
                    Icon(Icons.Rounded.ArrowDropDown, null, tint = c.ink)
                }
                Text(subtitle, style = MaterialTheme.typography.bodyLarge, color = c.secondary, maxLines = 1,
                    modifier = Modifier.semantics { testTag = "routine-position" })
            }
        }
        Box {
            IconButton({ menu = true }, Modifier.semantics { testTag = "player-more" }, enabled = enabled) {
                Icon(Icons.Rounded.MoreVert, "Routine options", tint = c.ink)
            }
            DropdownMenu(menu, { menu = false }) {
                @Composable fun item(text: String, icon: ImageVector, tag: String, action: () -> Unit) = DropdownMenuItem(
                    text = { Text(text, style = MaterialTheme.typography.bodyLarge, color = c.ink) },
                    onClick = { menu = false; action() },
                    leadingIcon = { Icon(icon, null, tint = c.ink) },
                    modifier = Modifier.semantics { testTag = tag },
                )
                if (current != null) item("Day details", Icons.Rounded.CalendarMonth, "player-menu-day", onDay)
                item("View routine", Icons.AutoMirrored.Rounded.List, "player-menu-routine", onQueue)
                if (showFirstUnfinished) item("Go to first unfinished", Icons.AutoMirrored.Rounded.Undo, "player-menu-first", onFirstUnfinished)
                item("End routine", Icons.Rounded.Flag, "player-menu-end", onEnd)
            }
        }
    }
}

/** Done / current / left: the thin segments under the title. */
@Composable
private fun RoutineSegments(covered: List<Boolean>, index: Int, spoken: String) {
    val c = appColors
    Row(
        Modifier.fillMaxWidth().height(SEGMENTS_HEIGHT).padding(horizontal = 24.dp).semantics { contentDescription = spoken; testTag = "routine-segments" },
        horizontalArrangement = Arrangement.spacedBy(4.dp), verticalAlignment = Alignment.CenterVertically,
    ) {
        covered.forEachIndexed { i, done ->
            val color = when {
                i == index -> c.ink
                done -> c.ink.copy(alpha = 0.45f)
                else -> c.tonal
            }
            Box(Modifier.weight(1f).height(if (i == index) 6.dp else 5.dp).clip(CircleShape).background(color))
        }
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
        onStep = if (live && !skipped) ({ step: Step, wasDone: Boolean ->
            session.change(habit, if (wasDone) PlayerWords.STEP_UNCHECKED else PlayerWords.STEP_SAVED, captureUndo = !wasDone) {
                store.toggleStep(step, habit, day, source = EntrySource.ROUTINE)
            }
        }) else null,
    )
}

/**
 * The Expressive hero card, shared with the timer screen: the habit's icon in the cookie, its name, the day chip, the
 * count ("2 of 8 glasses", or a running clock) and the wavy bar; a checklist's steps below. Only the count and the bar
 * read the ticking clock, and only while the timer runs (S3).
 */
@Composable
internal fun HeroCard(
    habit: Habit, ruled: Habit, day: Int, store: HabitStore, rev: Int, skipped: Boolean,
    onDay: (() -> Unit)?, onCountTap: (() -> Unit)?, onStep: ((Step, Boolean) -> Unit)?, modifier: Modifier = Modifier,
    /** "30 days in a row · reached today": the ribbon across the card's top (RP.1); [playMilestone]: it was just reached. */
    milestone: String? = null, playMilestone: Boolean = false,
) {
    val c = appColors
    val running = ruled.kind == HabitKind.Duration && day == store.today() && store.timers.containsKey(habit.id)
    val tick = rememberTicker(running, store.clock)
    val goal = remember(ruled, rev) { store.rules.goal(ruled) }
    val dayText = DayWords.day(day, store.today())
    val checklist = ruled.kind == HabitKind.Checklist
    val compact = checklist && ruled.steps.size > COMPACT_STEPS
    // Just reached: the cookie pops with a burst of twelve dots as Mark done fills it (RP.1, 0.18–1.0 s of 2.4 s).
    val pop = com.oftenenough.app.ui.today.rememberPlay(if (playMilestone && milestone != null) "pop-${habit.id}" else null, playMilestone && milestone != null, 2400)
    val cookie = Modifier.graphicsLayer {
        val sc = com.oftenenough.app.ui.day.track(pop, com.oftenenough.app.ui.day.Key(0f, 1f), com.oftenenough.app.ui.day.Key(0.075f, 1f, PopEaseOut),
            com.oftenenough.app.ui.day.Key(0.167f, 1.12f, PopEaseInOut), com.oftenenough.app.ui.day.Key(0.258f, 1f))
        scaleX = sc; scaleY = sc
    }.cookieBurst(pop, c.habit(habit.color))
    Card(modifier.fillMaxSize().semantics { testTag = "player-hero" }, shape = RoundedCornerShape(32.dp)) {
      Column(Modifier.fillMaxSize()) {
        if (milestone != null) com.oftenenough.app.ui.day.MilestoneRibbon(milestone, habit.color, "ribbon-${habit.id}-$milestone", play = playMilestone, strip = true)
      Box(Modifier.weight(1f).fillMaxWidth()) {
        if (compact) {
            // Many steps (design 05): a compact header, then the steps scroll inside the card with a fade at the end.
            Column(Modifier.fillMaxSize().padding(start = 24.dp, end = 24.dp, top = 24.dp)) {
                Row(verticalAlignment = Alignment.CenterVertically) {
                    HabitIcon(habit.symbol, habit.color, size = 64.dp, shape = CookieShape(), modifier = cookie)
                    Spacer(Modifier.width(16.dp))
                    Column(Modifier.weight(1f)) {
                        HabitName(habit.name, AppType.headlineMediumEmphasized, TextAlign.Start, maxLines = 1)
                        Spacer(Modifier.height(8.dp))
                        DayChip(dayText, onDay)
                    }
                }
                Spacer(Modifier.height(16.dp))
                CountLine(habit, ruled, day, store, goal, rev, tick, running, center = false, baseStyle = AppType.displayMedium, onTap = onCountTap)
                Spacer(Modifier.height(8.dp))
                if (skipped) SkippedLine(center = false) else ProgressLine(habit, day, store, goal, rev, tick, running)
                Spacer(Modifier.height(16.dp))
                val scroll = rememberScrollState()
                Box(Modifier.weight(1f).fillMaxWidth()) {
                    Column(Modifier.fillMaxSize().verticalScroll(scroll).padding(bottom = 24.dp)) {
                        StepRows(habit, ruled, day, store, rev, c.habit(habit.color), onStep)
                    }
                    if (scroll.canScrollForward) {
                        Box(Modifier.align(Alignment.BottomCenter).fillMaxWidth().height(56.dp)
                            .background(Brush.verticalGradient(listOf(c.surface.copy(alpha = 0f), c.surface))))
                    }
                }
            }
        } else {
            BoxWithConstraints(Modifier.fillMaxSize()) {
                val minHeight = maxHeight
                Column(
                    Modifier.fillMaxWidth().verticalScroll(rememberScrollState()).heightIn(min = minHeight).padding(24.dp),
                    verticalArrangement = Arrangement.Center, horizontalAlignment = Alignment.CenterHorizontally,
                ) {
                    HabitIcon(habit.symbol, habit.color, size = if (checklist) 96.dp else 136.dp, shape = CookieShape(), modifier = cookie)
                    Spacer(Modifier.height(if (checklist) 16.dp else 32.dp))
                    HabitName(habit.name, AppType.headlineLargeEmphasized, TextAlign.Center, maxLines = 2)
                    Spacer(Modifier.height(12.dp))
                    DayChip(dayText, onDay)
                    Spacer(Modifier.height(if (checklist) 16.dp else 32.dp))
                    CountLine(habit, ruled, day, store, goal, rev, tick, running, center = true, baseStyle = if (checklist) AppType.displayMedium else AppType.displayLarge, onTap = onCountTap)
                    Spacer(Modifier.height(if (checklist) 8.dp else 24.dp))
                    if (skipped) SkippedLine(center = true) else ProgressLine(habit, day, store, goal, rev, tick, running)
                    if (checklist) {
                        Spacer(Modifier.height(16.dp))
                        StepRows(habit, ruled, day, store, rev, c.habit(habit.color), onStep)
                    }
                }
            }
        }
      }
      }
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
    val ra = com.oftenenough.app.ui.day.track(t, com.oftenenough.app.ui.day.Key(0f, 0f), com.oftenenough.app.ui.day.Key(0.125f, 0f, PopEaseOut),
        com.oftenenough.app.ui.day.Key(0.146f, 0.6f, PopEaseOut), com.oftenenough.app.ui.day.Key(0.354f, 0f))
    val rs = com.oftenenough.app.ui.day.track(t, com.oftenenough.app.ui.day.Key(0f, 0.8f), com.oftenenough.app.ui.day.Key(0.125f, 0.8f, PopEaseOut), com.oftenenough.app.ui.day.Key(0.354f, 1.3f))
    if (ra > 0f) drawCircle(color.copy(alpha = ra), radius * rs, centre, style = androidx.compose.ui.graphics.drawscope.Stroke(2.dp.toPx()))
    for (i in 0 until 12) {
        val start = 0.125f + 0.0042f * i
        val a = Math.toRadians(15.0 + 30.0 * i)
        val da = com.oftenenough.app.ui.day.track(t, com.oftenenough.app.ui.day.Key(0f, 0f), com.oftenenough.app.ui.day.Key(start, 0f, PopEaseOut),
            com.oftenenough.app.ui.day.Key(start + 0.033f, 1f, PopEaseIn), com.oftenenough.app.ui.day.Key(start + 0.25f, 0f))
        val ds = com.oftenenough.app.ui.day.track(t, com.oftenenough.app.ui.day.Key(0f, 0.6f), com.oftenenough.app.ui.day.Key(start, 0.6f, PopEaseOut),
            com.oftenenough.app.ui.day.Key(start + 0.0625f, 1f, PopEaseIn), com.oftenenough.app.ui.day.Key(start + 0.25f, 0.3f))
        val r = radius + com.oftenenough.app.ui.day.track(t, com.oftenenough.app.ui.day.Key(0f, 0f), com.oftenenough.app.ui.day.Key(start, 0f, PopEaseOut),
            com.oftenenough.app.ui.day.Key(start + 0.167f, 24f)) * density
        if (da > 0f) drawCircle(color.copy(alpha = da), (if (i % 2 == 0) 3.5f else 2.5f) * density * ds,
            androidx.compose.ui.geometry.Offset(centre.x + (kotlin.math.cos(a) * r).toFloat(), centre.y + (kotlin.math.sin(a) * r).toFloat()))
    }
}

@Composable
private fun HabitName(name: String, style: TextStyle, align: TextAlign, maxLines: Int) {
    Text(
        name, style = style,
        color = appColors.ink, textAlign = align, maxLines = maxLines, overflow = TextOverflow.Ellipsis,
        modifier = Modifier.semantics { heading(); testTag = "player-name" },
    )
}

/** "📅 Today ›": opens Day details for this habit and day (also first in ⋮). */
@Composable
internal fun DayChip(text: String, onClick: (() -> Unit)?) {
    val c = appColors
    Row(
        Modifier.clip(RoundedCornerShape(10.dp)).background(c.tonal)
            .let { if (onClick != null) it.clickable(onClickLabel = "Open Day details", role = Role.Button, onClick = onClick) else it }
            .heightIn(min = 40.dp).padding(start = 12.dp, end = if (onClick != null) 6.dp else 14.dp)
            .semantics { testTag = "player-day-chip" },
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Icon(Icons.Rounded.CalendarToday, null, Modifier.size(20.dp), tint = c.ink)
        Spacer(Modifier.width(10.dp))
        Text(text, style = AppType.titleMedium, color = c.ink, maxLines = 1)
        if (onClick != null) {
            Spacer(Modifier.width(4.dp))
            Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, Modifier.size(20.dp), tint = c.secondary)
        }
    }
}

/** The count, large, with what it's out of beside it on the same baseline. While a timer runs, only this and the bar tick. */
@Composable
private fun CountLine(
    habit: Habit, ruled: Habit, day: Int, store: HabitStore, goal: Double, rev: Int, tick: State<Long>, running: Boolean,
    center: Boolean, baseStyle: TextStyle, onTap: (() -> Unit)?,
) {
    val c = appColors
    val progress = if (running) store.rules.progress(habit, day, tick.value) else remember(habit, rev) { store.rules.progress(habit, day) }
    val value = PlayerWords.value(ruled, progress)
    val target = PlayerWords.target(ruled, goal)
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
        Spacer(Modifier.width(12.dp))
        Text(target, Modifier.alignByBaseline().weight(1f, fill = false), style = AppType.titleLarge,
            color = c.secondary, maxLines = 2, overflow = TextOverflow.Ellipsis)
    }
}

/** Expressive's wavy bar in the habit's colour (a limit's too: its words say "max", never red, U3). */
@Composable
private fun ProgressLine(habit: Habit, day: Int, store: HabitStore, goal: Double, rev: Int, tick: State<Long>, running: Boolean) {
    val color = appColors.habit(habit.color)
    val progress = if (running) store.rules.progress(habit, day, tick.value) else remember(habit, rev) { store.rules.progress(habit, day) }
    val fraction = (progress / maxOf(goal, 0.001)).toFloat().coerceIn(0f, 1f)
    WavyProgress(fraction, color, color.copy(alpha = 0.25f),
        Modifier.fillMaxWidth().padding(horizontal = 4.dp).height(16.dp).semantics { progressBarRangeInfo = ProgressBarRangeInfo(fraction, 0f..1f) })
}

/** Where the bar was: "⏩ Skipped for today" (neutral, U3). */
@Composable
private fun SkippedLine(center: Boolean) {
    val c = appColors
    Row(Modifier.fillMaxWidth().heightIn(min = 24.dp).semantics(mergeDescendants = true) { testTag = "player-skipped" },
        horizontalArrangement = if (center) Arrangement.Center else Arrangement.Start, verticalAlignment = Alignment.CenterVertically) {
        Icon(Icons.Rounded.FastForward, null, Modifier.size(20.dp), tint = c.secondary)
        Spacer(Modifier.width(8.dp))
        Text(PlayerWords.SKIPPED, style = AppType.bodyLarge, color = c.secondary)
    }
}

/** A checklist's steps: the work itself, in the card (Material checkboxes in the habit's colour). */
@Composable
private fun StepRows(habit: Habit, ruled: Habit, day: Int, store: HabitStore, rev: Int, color: Color, onStep: ((Step, Boolean) -> Unit)?) {
    val c = appColors
    val count = ruled.steps.size
    val enabled = onStep != null
    Column(Modifier.fillMaxWidth().semantics { testTag = "player-steps" }, verticalArrangement = Arrangement.spacedBy(4.dp)) {
        ruled.steps.forEachIndexed { i, step ->
            val done = store.isStepDone(step, habit, day)
            Row(
                Modifier.fillMaxWidth().clip(segmentShape(i, count, outer = 20.dp)).background(c.screen)
                    .toggleable(value = done, enabled = enabled, role = Role.Checkbox, onValueChange = { onStep?.invoke(step, done) })
                    .heightIn(min = 52.dp).padding(horizontal = 12.dp)
                    .semantics { testTag = "player-step-$i" },
                verticalAlignment = Alignment.CenterVertically,
            ) {
                Checkbox(checked = done, onCheckedChange = null, enabled = enabled,
                    colors = CheckboxDefaults.colors(checkedColor = color, uncheckedColor = c.ink, checkmarkColor = Color.White))
                Spacer(Modifier.width(12.dp))
                Text(step.name, style = AppType.bodyLarge, color = c.ink, maxLines = 2, overflow = TextOverflow.Ellipsis)
            }
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
        remember(habit, rev, timers, index, order.size) {
            val ruled = store.rule(habit, day)
            PlayerWords.mainAction(ruled, store.rules.goal(ruled), session.done(habit), session.skipped(habit), index == order.size - 1,
                timers.containsKey(habit.id), store.rules.progress(habit, day) > 0)
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

    Row(Modifier.fillMaxWidth().height(96.dp).padding(horizontal = 16.dp), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
        SideButton(Icons.AutoMirrored.Rounded.KeyboardArrowLeft, "Previous habit", enabled = index > 0, tag = "player-previous",
            modifier = if (wide) Modifier.weight(1f) else Modifier.width(56.dp)) { session.navigate(index - 1) }
        if (!wide && action != null && habit != null) {
            MainButton(actionIcon(action.action), action.label, action.spoken, "player-main", Modifier.weight(1f)) { perform(action.action, habit) }
        }
        SideButton(Icons.AutoMirrored.Rounded.KeyboardArrowRight, next?.let { "Next habit: ${it.name}" } ?: "Finish routine", enabled = true,
            tag = "player-next", modifier = if (wide) Modifier.weight(1f) else Modifier.width(56.dp)) { session.advance() }
    }
    Spacer(Modifier.height(16.dp))
}

private fun actionIcon(a: PlayerAction): ImageVector = when (a) {
    PlayerAction.NEXT -> Icons.AutoMirrored.Rounded.ArrowForward
    PlayerAction.FINISH, PlayerAction.MARK_DONE, PlayerAction.LOG_ONE, PlayerAction.NONE -> Icons.Rounded.Check
    PlayerAction.LOG_STEP -> Icons.Rounded.Add
    PlayerAction.LOG_AMOUNT -> Icons.Rounded.Edit
    PlayerAction.START, PlayerAction.RESUME -> Icons.Rounded.PlayArrow
    PlayerAction.PAUSE -> Icons.Rounded.Pause
}

/** ‹ or ›: tonal, as tall as the group. */
@Composable
private fun SideButton(icon: ImageVector, spoken: String, enabled: Boolean, tag: String, modifier: Modifier, onClick: () -> Unit) {
    val c = appColors
    Button(
        onClick, modifier.fillMaxHeight().semantics { contentDescription = spoken; testTag = tag }, enabled = enabled,
        shape = RoundedCornerShape(28.dp),
        colors = ButtonDefaults.buttonColors(containerColor = c.tonal, contentColor = c.ink, disabledContainerColor = c.tonal, disabledContentColor = c.ink.copy(alpha = 0.3f)),
        contentPadding = PaddingValues(0.dp),
    ) {
        Icon(icon, null, Modifier.size(28.dp))
    }
}

/** The one main action, in ink. Its label is one line and ends in … when long; TalkBack reads the whole of [spoken]. */
@Composable
internal fun MainButton(icon: ImageVector?, label: String, spoken: String, tag: String, modifier: Modifier, onClick: () -> Unit) {
    val c = appColors
    Button(
        onClick, modifier.fillMaxHeight().semantics { contentDescription = spoken; testTag = tag },
        shape = RoundedCornerShape(40.dp),
        colors = ButtonDefaults.buttonColors(containerColor = c.ink, contentColor = c.onInk),
        contentPadding = PaddingValues(horizontal = 20.dp),
    ) {
        if (icon != null) {
            Icon(icon, null, Modifier.size(28.dp))
            Spacer(Modifier.width(12.dp))
        }
        Text(label, Modifier.weight(1f, fill = false), style = AppType.title20,
            maxLines = 1, overflow = TextOverflow.Ellipsis)
    }
}

/** A tonal button as tall as the group, beside [MainButton] ("Log manually", "Return to unfinished"). */
@Composable
internal fun TonalBigButton(icon: ImageVector?, label: String, tag: String, modifier: Modifier, onClick: () -> Unit) {
    val c = appColors
    Button(
        onClick, modifier.semantics { testTag = tag }, shape = RoundedCornerShape(32.dp),
        colors = ButtonDefaults.buttonColors(containerColor = c.tonal, contentColor = c.ink),
        contentPadding = PaddingValues(horizontal = 16.dp),
    ) {
        if (icon != null) {
            Icon(icon, null, Modifier.size(24.dp))
            Spacer(Modifier.width(12.dp))
        }
        Text(label, Modifier.weight(1f, fill = false), style = AppType.title20,
            maxLines = 1, overflow = TextOverflow.Ellipsis)
    }
}

// ---------------------------------------------------------------------------------------------- The save message

@Composable
private fun FeedbackBar(f: Feedback, onUndo: () -> Unit, onNote: () -> Unit, modifier: Modifier) {
    val actionColors = ButtonDefaults.textButtonColors(contentColor = MaterialTheme.colorScheme.inversePrimary)
    val actions: @Composable () -> Unit = {
        Row {
            TextButton(onUndo, Modifier.semantics { testTag = "player-undo" }, colors = actionColors) { Text("Undo") }
            // The note belongs right after logging, next to Undo; never asked for.
            TextButton(onNote, Modifier.semantics { testTag = "player-add-note" }, colors = actionColors) { Text("Add note") }
        }
    }
    Snackbar(
        modifier = modifier.semantics { testTag = "player-snackbar" },
        shape = RoundedCornerShape(4.dp),
        action = if (f.canUndo) actions else null,
    ) {
        Text(f.message, maxLines = 1, overflow = TextOverflow.Ellipsis)
    }
}

// ---------------------------------------------------------------------------------------------- The end

@Composable
private fun EndPage(remaining: Int, skipped: Int, reviewed: Int, onReview: () -> Unit,
    reached: List<Pair<Habit, com.oftenenough.app.data.MilestoneWords>> = emptyList()) {
    val c = appColors
    Column(Modifier.fillMaxSize().verticalScroll(rememberScrollState())) {
        Card(Modifier.fillMaxWidth().semantics { testTag = "player-end" }, shape = RoundedCornerShape(32.dp)) {
            Column(Modifier.fillMaxWidth().padding(horizontal = 24.dp, vertical = 32.dp), horizontalAlignment = Alignment.CenterHorizontally) {
                // Not a pause symbol: it read as a media button (found by hand on the iPhone, 29 Sep).
                CookieIcon(if (remaining == 0) Icons.Rounded.Check else Icons.Rounded.History, size = 112.dp, container = c.ink, tint = c.onInk)
                Spacer(Modifier.height(24.dp))
                Text(PlayerWords.endTitle(remaining), style = AppType.headlineLarge,
                    color = c.ink, textAlign = TextAlign.Center, modifier = Modifier.semantics { heading(); testTag = "player-end-title" })
                Spacer(Modifier.height(12.dp))
                Text(PlayerWords.endText(remaining, reviewed), style = AppType.bodyLarge,
                    color = c.secondary, textAlign = TextAlign.Center)
                PlayerWords.skippedLine(skipped)?.let {
                    Spacer(Modifier.height(16.dp))
                    Text(it, style = MaterialTheme.typography.bodyLarge, color = c.secondary, textAlign = TextAlign.Center)
                }
                PlayerWords.limitsLine(reviewed)?.let {
                    Spacer(Modifier.height(8.dp))
                    Text(it, style = MaterialTheme.typography.bodyLarge, color = c.secondary, textAlign = TextAlign.Center)
                }
                // Every milestone the routine's steps reached, once (Figma RP.2).
                if (reached.isNotEmpty()) {
                    Spacer(Modifier.height(20.dp))
                    Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(20.dp)).background(c.screen).padding(16.dp)
                        .semantics { testTag = "player-reached" }, verticalArrangement = Arrangement.spacedBy(12.dp)) {
                        Text("Reached in this routine", style = AppType.titleMedium, color = c.ink)
                        for ((h, w) in reached) Row(verticalAlignment = Alignment.CenterVertically) {
                            // The same medal as everywhere (Figma RP.2: 32).
                            com.oftenenough.app.ui.habit.MilestoneMedal(w.number, 32.dp, h.color)
                            Spacer(Modifier.width(12.dp))
                            Column {
                                Text(w.title, style = AppType.bodyLarge, color = c.ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
                                Text(h.name, style = AppType.bodySmall, color = c.secondary, maxLines = 1, overflow = TextOverflow.Ellipsis)
                            }
                        }
                    }
                }
                Spacer(Modifier.height(12.dp))
                TextButton(onReview, Modifier.semantics { testTag = "player-review" }) {
                    Icon(Icons.AutoMirrored.Rounded.List, null, Modifier.size(22.dp), tint = c.ink)
                    Spacer(Modifier.width(12.dp))
                    Text("Review routine", style = AppType.titleMedium, color = c.ink)
                }
            }
        }
    }
}

/** Done is the main way out (large, ink); going back to what's left is the second choice (tonal). */
@Composable
private fun EndButtons(hasRemaining: Boolean, onReturn: () -> Unit, onDone: () -> Unit) {
    Column(Modifier.fillMaxWidth().padding(start = 16.dp, end = 16.dp, bottom = 16.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
        if (hasRemaining) {
            TonalBigButton(Icons.AutoMirrored.Rounded.Undo, "Return to unfinished", "player-return", Modifier.fillMaxWidth().height(64.dp), onReturn)
        }
        MainButton(Icons.Rounded.Check, "Done", "Done", "player-done", Modifier.fillMaxWidth().height(96.dp), onDone)
    }
}

/** The routine's day ended while it was open: its progress stays on that day. */
@Composable
private fun NewDayCard(modifier: Modifier, onBack: () -> Unit) {
    val c = appColors
    Column(modifier.fillMaxWidth().padding(16.dp).verticalScroll(rememberScrollState())) {
        Card(Modifier.fillMaxWidth().semantics { testTag = "player-new-day" }, shape = RoundedCornerShape(32.dp)) {
            Column(Modifier.fillMaxWidth().padding(24.dp), horizontalAlignment = Alignment.CenterHorizontally) {
                CookieIcon(Icons.Rounded.WbTwilight, size = 96.dp)
                Spacer(Modifier.height(24.dp))
                Text(PlayerWords.NEW_DAY_TITLE, style = MaterialTheme.typography.headlineMedium, color = c.ink, textAlign = TextAlign.Center,
                    modifier = Modifier.semantics { heading() })
                Spacer(Modifier.height(12.dp))
                Text(PlayerWords.NEW_DAY_TEXT, style = MaterialTheme.typography.bodyLarge, color = c.secondary, textAlign = TextAlign.Center)
                Spacer(Modifier.height(24.dp))
                InkButton("Back to Today", onBack, Modifier.fillMaxWidth())
            }
        }
    }
}

// ---------------------------------------------------------------------------------------------- Your routine

/** Your routine: jump to any habit, or change the order for this routine (a modal bottom sheet: Edit, ✓, ▶). */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun RoutineSheet(session: PlayerSession, covered: List<Boolean>, onJump: (Int) -> Unit, onDismiss: () -> Unit) {
    val c = appColors
    val store = session.store
    val state = rememberModalBottomSheetState()
    var editing by remember { mutableStateOf(false) }
    val order = session.order
    val index = session.index
    val reviewed = session.reviewed
    ModalBottomSheet(onDismiss, sheetState = state, containerColor = c.screen) {
        Column(Modifier.fillMaxWidth().verticalScroll(rememberScrollState()).padding(horizontal = 16.dp).padding(bottom = 16.dp)
            .semantics { testTag = "routine-sheet" }) {
            Row(Modifier.fillMaxWidth().padding(start = 8.dp, bottom = 16.dp), verticalAlignment = Alignment.CenterVertically) {
                Text("Your routine", Modifier.weight(1f).semantics { heading() }, style = MaterialTheme.typography.headlineMedium, color = c.ink)
                TextButton({ editing = !editing }, Modifier.semantics { testTag = "routine-edit" }) {
                    Text(if (editing) "Done" else "Edit", style = MaterialTheme.typography.titleMedium, color = c.ink)
                }
            }
            SegmentedList {
                order.forEachIndexed { i, id ->
                    val habit = store.habit(id)
                    if (habit != null) {
                        val skipped = session.skipped(habit)
                        val doneToday = session.doneToday(habit)
                        val status = PlayerWords.queueStatus(habit.atMost, id in reviewed, doneToday, skipped)
                        val jump: () -> Unit = { onJump(i) }
                        val click: (() -> Unit)? = if (editing) null else jump
                        Segment(i, order.size, Modifier.semantics { testTag = "queue-${habit.name}" }, onClick = click) {
                            HabitIcon(habit.symbol, habit.color, size = 40.dp)
                            Spacer(Modifier.width(16.dp))
                            Column(Modifier.weight(1f)) {
                                Text(habit.name, style = AppType.bodyLarge, color = c.ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
                                Text(status, style = AppType.bodyMedium, color = c.secondary, maxLines = 1)
                            }
                            if (editing) {
                                IconButton({ session.move(i, i - 1) }, enabled = i > 0) {
                                    Icon(Icons.Rounded.KeyboardArrowUp, "Move ${habit.name} up", tint = c.ink)
                                }
                                IconButton({ session.move(i, i + 1) }, enabled = i < order.size - 1) {
                                    Icon(Icons.Rounded.KeyboardArrowDown, "Move ${habit.name} down", tint = c.ink)
                                }
                            } else {
                                Spacer(Modifier.width(8.dp))
                                when {
                                    i == index -> Icon(Icons.Rounded.PlayArrow, "Current habit", tint = c.ink)
                                    skipped -> Icon(Icons.Rounded.FastForward, "Skipped", tint = c.secondary)
                                    covered.getOrNull(i) == true -> Icon(Icons.Rounded.Check, if (doneToday) "Done" else "Checked in", tint = c.ink)
                                }
                            }
                        }
                    }
                }
            }
            Text(PlayerWords.QUEUE_FOOTER, Modifier.padding(start = 16.dp, end = 16.dp, top = 16.dp),
                style = MaterialTheme.typography.bodyMedium, color = c.secondary)
        }
    }
}
