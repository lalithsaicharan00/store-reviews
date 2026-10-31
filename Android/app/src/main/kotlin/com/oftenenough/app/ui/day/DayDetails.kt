package com.oftenenough.app.ui.day

import com.oftenenough.app.ui.components.belowStatusBar
import com.oftenenough.app.ui.components.sheetInsets
import com.oftenenough.app.ui.components.AppDatePicker
import com.oftenenough.app.ui.components.AppDialog
import com.oftenenough.app.ui.components.AppTopBar
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.ui.graphics.Color
import androidx.compose.material3.MaterialTheme
import com.oftenenough.app.ui.components.ListAvatar
import com.oftenenough.app.ui.components.SegmentedListGap
import com.oftenenough.app.ui.components.segmentShape
import com.oftenenough.app.ui.components.MilestonePopup
import com.oftenenough.app.ui.components.AppSnackbarHost
import com.oftenenough.app.ui.components.AppMenuItem
import com.oftenenough.app.ui.components.AppMenu
import com.oftenenough.app.ui.components.ListChevron
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.ButtonSize
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.EqualButtons
import com.oftenenough.app.ui.components.MenuDivider
import com.oftenenough.app.ui.components.StepRow
import com.oftenenough.app.ui.components.StepRowPlace
import com.oftenenough.app.ui.components.StandardIconButton
import kotlinx.coroutines.launch
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.material3.SnackbarResult
import androidx.compose.material3.SnackbarDuration
import androidx.compose.material3.SnackbarHostState
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.tabular

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.BoxWithConstraints
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.ModalBottomSheet
import androidx.compose.material3.Text
import com.oftenenough.app.ui.components.rememberWholeSheetState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.text.rememberTextMeasurer
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.DayStatus
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Entry
import com.oftenenough.app.data.EntrySource
import com.oftenenough.app.data.Format
import com.oftenenough.app.data.Frequency
import com.oftenenough.app.data.GoalPeriod
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitCopy
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.clockText
import com.oftenenough.app.data.description
import com.oftenenough.app.data.MilestoneCenter
import com.oftenenough.app.data.MilestoneFront
import com.oftenenough.app.data.MilestoneShown
import com.oftenenough.app.data.MilestoneTier
import com.oftenenough.app.data.opensRecord
import com.oftenenough.app.data.undoLabel
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.HabitProgress
import com.oftenenough.app.ui.theme.appColors
import com.oftenenough.app.ui.today.rememberTicker

/** Where Day details hands over: the screens it opens. */
interface DayNav {
    fun habitPage(habit: Habit)
    fun addLog(habit: Habit, day: Int)
    fun note(habit: Habit, day: Int)
    fun log(habit: Habit, entry: Entry)
    fun allLogs(habit: Habit, day: Int)
    fun edit(habit: Habit)
    fun pause(habit: Habit)
    /** Resumed from here (Figma's Today, flow 16): the sheet closes and the page under it says so, with [undo]. */
    fun resumed(habit: Habit, undo: () -> Unit) {}
    /** The habit's page, open at All milestones (the landmark pop-up's button, Figma 14.1). */
    fun allMilestones(habit: Habit) = habitPage(habit)
    /** The full-screen timer, just started (Day details 13: the same timer as ▶ on Today); ⌄ comes back here. */
    fun timer(habit: Habit) {}
}

/**
 * "8 glasses a day · Anytime", "Every day · 8:00 AM" (a habit with reminders says when they are, Figma's Day details),
 * "Quitting since 19 Sep 2026", "Task · Planned for Sat, 4 Oct" (the iPhone's DayIdentityRow).
 */
fun planLine(habit: Habit, store: HabitStore): String = when (habit.kind) {
    HabitKind.Quit -> "Quitting since " + DayWords.long(store.rules.calendarDayOf(habit.quitSince ?: habit.createdAt))
    // "Task · Today" on its day (Figma 926:110121), "Task · Tomorrow", else the day it's planned for.
    HabitKind.Task -> habit.dueDay?.let { if (it == com.oftenenough.app.data.NO_DATE_DAY) "Task · No date" else when (it - store.today()) { 0 -> "Task · Today"; 1 -> "Task · Tomorrow"; else -> "Task · Planned for " + DayWords.short(it) } } ?: ("Task · " + HabitCopy.capitalized(HabitCopy.plan(habit, store.weekStart)))
    else -> {
        // A unit that only repeats the name is left out beside it: Push-ups, "300 a week" (Figma 915:106625).
        val unit = (habit.kind as? HabitKind.Amount)?.unit?.trim().orEmpty()
        // A checklist says how many steps first: "4 steps, every day" (Figma 919:112323).
        val steps = if (habit.kind == HabitKind.Checklist) "${habit.steps.size} ${if (habit.steps.size == 1) "step" else "steps"}, " else ""
        val plan = shortDays(habit, store.weekStart).ifEmpty { HabitCopy.capitalized(steps + HabitCopy.plan(habit, store.weekStart)) }
            .let { if (unit.isNotEmpty() && unit.equals(habit.name.trim(), ignoreCase = true)) it.replaceFirst(" $unit ", " ") else it }
            // Whole hours in words: "3 hours a week" (Figma 919:31077).
            .let { Regex("^(\\d+) h (a|on|every)\\b").replace(it) { m -> m.groupValues[1] + (if (m.groupValues[1] == "1") " hour " else " hours ") + m.groupValues[2] } }
        // A cut-down habit sits in Quitting, not in a time of day: its plan alone ("At most 2 cups a day", Figma's Today,
        // flow 44), or with its reminder times.
        val where = if (habit.remind && habit.reminders.isNotEmpty()) habit.reminders.sortedBy { it.minuteOfDay }.joinToString(", ") { DayWords.clockMinute(it.minuteOfDay) }
            else if (habit.atMost) null
            else if (habit.parts == listOf("anytime")) "Anytime" else HabitCopy.capitalized(HabitCopy.join(habit.parts.map { store.section(it).name }))
        if (where == null) plan else "$plan · $where"
    }
}

/** A check on set days names them short, in week order (Figma 3.3: "Mon, Wed, Fri · Morning"); otherwise empty. */
private fun shortDays(habit: Habit, weekStart: Int): String {
    val f = habit.frequency as? Frequency.Weekdays ?: return ""
    if (habit.kind != HabitKind.Check || f.days.size !in 1..6 || f.days == setOf(2, 3, 4, 5, 6) || f.days == setOf(1, 7)) return ""
    return f.days.sortedBy { ((it - weekStart) % 7 + 7) % 7 }.joinToString(", ") { HabitCopy.shortDays[(it - 1 + 7) % 7] }
}


/**
 * Day details (Figma `2308:2`): one habit (or task) on one day, a modal bottom sheet. Its top bar is ✕, the day and ⋮; the
 * habit opens its page; This day holds the status, the logging buttons and the note; the day's logs follow (at most
 * three rows); Skip last, outlined (U14–U17).
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun DayDetailsSheet(habitId: String, day: Int, store: HabitStore, nav: DayNav, onDismiss: () -> Unit) {
    val habit = store.habit(habitId) ?: run { onDismiss(); return }
    // While it's open, milestones logged here are this sheet's, not Today's underneath.
    DisposableEffect(habitId) {
        val mine = MilestoneFront.Sheet(habitId)
        val before = store.milestones.front
        store.milestones.front = mine
        onDispose { if (store.milestones.front == mine) store.milestones.front = before }
    }
    val c = appColors
    val state = rememberWholeSheetState()
    ModalBottomSheet(onDismiss, Modifier.belowStatusBar(), sheetState = state, contentWindowInsets = { sheetInsets() }) {
        // A sheet is its own window: its tags reach UI Automator only if it says so too.
        val snackbar = com.oftenenough.app.ui.components.LocalAppSnackbar.current ?: remember { SnackbarHostState() }
        val scope = rememberCoroutineScope()
        Box(Modifier.fillMaxHeight().semantics { testTagsAsResourceId = true }) {
            DayDetailsContent(habit, day, store, nav, onDismiss) { words ->
                // A log added to a past day says what it added and where, with Undo (Habit details, Figma 1373:2, 4.3).
                scope.launch {
                    snackbar.currentSnackbarData?.dismiss()
                    if (snackbar.showSnackbar(words, actionLabel = "Undo", duration = SnackbarDuration.Short) == SnackbarResult.ActionPerformed) {
                        store.entries(habit.id, day).filter { it.stepId == null }.maxByOrNull { it.createdAt }?.let { store.undoEntry(it.id) }
                    }
                }
            }
            AppSnackbarHost(snackbar, Modifier.align(Alignment.BottomCenter).navigationBarsPadding().padding(16.dp))
        }
    }
}

@Composable
fun DayDetailsContent(habit: Habit, day: Int, store: HabitStore, nav: DayNav, onDismiss: () -> Unit, onAdded: ((String) -> Unit)? = null) {
    val c = appColors
    val today = store.today()
    val rev = store.revision(habit.id)
    var menu by remember { mutableStateOf(false) }
    var confirmDelete by remember { mutableStateOf(false) }
    var reschedule by remember { mutableStateOf(false) }
    val isTask = habit.kind == HabitKind.Task
    val started = day >= store.rules.startDay(habit)
    val editable = day <= today && started
    Column(Modifier.verticalScroll(rememberScrollState()).navigationBarsPadding().semantics { testTag = "day-details" }) {
        // The top bar (Figma: the Top app bar, 64, on the sheet's colour): ✕, the day, ⋮.
        AppTopBar(if (day == today + 1) "Tomorrow" else DayWords.day(day, today), containerColor = Color.Transparent, windowInsets = WindowInsets(0),
            navigationIcon = { IconButton(onDismiss, Modifier.semantics { testTag = "day-close" }) { Icon(Symbols.Close, "Close") } },
            actions = {
                Box {
                    StandardIconButton(Symbols.MoreVert, if (isTask) "Task actions" else "Habit actions", { menu = true }, Modifier.semantics { testTag = "day-more" })
                    DayMenu(menu, { menu = false }, habit, store, today, nav, onDismiss) { confirmDelete = true }
                }
            })
        Column(Modifier.padding(horizontal = 16.dp), verticalArrangement = Arrangement.spacedBy(16.dp)) {
            IdentityCard(habit, store, nav)
            DayActivity(habit, day, editable, started, rev, store, nav, onAdded, onDismiss)
            if (isTask && store.canReschedule(habit, day)) {
                SectionList("Reschedule") {
                    // Figma 926:110121: "Do tomorrow · Thu, 22 Oct ›", "Another day… ›"; no icons.
                    RowAction("Do tomorrow", DayWords.short(today + 1), 0, 2, "day-do-tomorrow") { store.reschedule(habit, day, today + 1); onDismiss() }
                    RowAction("Another day…", null, 1, 2, "day-another-day") { reschedule = true }
                }
            } else if (!isTask && habit.kind != HabitKind.Quit && started && !habit.atMost && !store.isPaused(habit, day)) {
                val skipped = store.isSkipped(habit, day)
                val planned = store.rules.isDue(habit, day, countingSkips = false) || !store.rule(habit, day).frequency.isDayBased || store.rule(habit, day).frequency.isFlexible
                // A once-a-day check that's done has nothing to skip (Figma 906:92686); a count at its goal keeps Skip.
                // A checklist with every step done the same (Figma 919:113195: "Skip today goes").
                val r = store.rule(habit, day)
                val ticked = ((r.kind == HabitKind.Check && !store.rules.countsUp(habit, day)) || r.kind == HabitKind.Checklist) && store.rules.isDayMet(r, day)
                if (skipped || (planned && !ticked && store.rules.canSkip(store.rule(habit, day)))) {
                    SkipButton(if (skipped) "Undo skip" else if (day == today) "Skip today" else "Skip this day") { store.setSkipped(habit, day, !skipped, offer = !skipped) }  // Today then offers Undo · Note (Figma's Today, flow 19)
                }
            }
        }
        Spacer(Modifier.height(24.dp))
    }
    if (confirmDelete) AppDialog("Delete ${habit.name}?", "Its history and notes are deleted too, and this can't be undone. Archiving stops it and keeps its history.",
        if (isTask) "Delete task" else "Delete habit", { confirmDelete = false; onDismiss(); store.delete(listOf(habit)) }, { confirmDelete = false },
        destructive = true, confirmTag = "day-delete-confirm")
    if (reschedule) RescheduleDialog(habit, day, store, { reschedule = false }) { reschedule = false; onDismiss() }
}

/** Resume: the habit is back in its place, the sheet closes, and the page under it says "Meds resumed" with Undo. */
private fun resume(habit: Habit, store: HabitStore, nav: DayNav, close: () -> Unit) {
    val before = store.pauses[habit.id] ?: emptyList()
    store.resume(habit)
    close()
    nav.resumed(habit) { store.setPauses(habit, before) }
}

/** ⋮ (Figma 1.5): View habit, Edit habit, Pause…, then Archive and Delete habit…, each with its icon; only Delete red. */
@Composable
private fun DayMenu(open: Boolean, onDismiss: () -> Unit, habit: Habit, store: HabitStore, today: Int, nav: DayNav, onClose: () -> Unit, onDelete: () -> Unit) {
    val isTask = habit.kind == HabitKind.Task
    AppMenu(open, onDismiss) {
        @Composable fun item(text: String, icon: ImageVector, red: Boolean = false, tag: String, action: () -> Unit) =
            AppMenuItem(text, { onDismiss(); action() }, icon = icon, destructive = red, tag = tag)
        if (!isTask) item("View habit", Symbols.Visibility, tag = "day-menu-view") { nav.habitPage(habit) }
        item(if (isTask) "Edit task" else "Edit habit", Symbols.Edit, tag = "day-menu-edit") { nav.edit(habit) }
        if (!isTask && store.rules.canPause(habit)) {
            if (store.isPaused(habit, today)) item("Resume habit", Symbols.PlayCircle, tag = "day-menu-resume") { resume(habit, store, nav, onClose) }
            else item("Pause…", Symbols.PauseCircle, tag = "day-menu-pause") { nav.pause(habit) }
        }
        MenuDivider()
        if (habit.archived) item("Restore", Symbols.Unarchive, tag = "day-menu-restore") { store.restore(habit) }
        else item("Archive", Symbols.Archive, tag = "day-menu-archive") { store.archive(listOf(habit)); onClose() }
        item(if (isTask) "Delete task…" else "Delete habit…", Symbols.Delete, red = true, tag = "day-menu-delete") { onDelete() }
    }
}

/**
 * The habit (Figma's List item, Single, two lines, on Surface container lowest): its 40 dp avatar in its colour, the
 * name in Title Medium over the plan in Body Medium, ›; opens its page (a task has no page, so no ›).
 */
@Composable
private fun IdentityCard(habit: Habit, store: HabitStore, nav: DayNav) {
    val isTask = habit.kind == HabitKind.Task
    AppListItem(habit.name, 0, 1, supporting = planLine(habit, store), headlineLines = 2, containerColor = MaterialTheme.colorScheme.surfaceContainerLowest,
        // The card opens the habit's page, a task's Task details (Figma 926:110121's note).
        leading = { HabitIcon(habit.symbol, habit.color, size = 40.dp) }, trailing = { ListChevron() },
        onClick = { nav.habitPage(habit) }, tag = "day-identity")
}

/** A section under This day (Figma's Today's logs): its title in Label Large On surface variant, 16 in, 8 over its rows. */
@Composable
private fun SectionList(title: String, rows: @Composable () -> Unit) {
    Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
        Text(title, Modifier.padding(start = 16.dp, end = 16.dp, bottom = 6.dp), style = AppType.labelLarge, color = MaterialTheme.colorScheme.onSurfaceVariant)
        rows()
    }
}

@Composable
private fun RowAction(text: String, trailingText: String?, index: Int, count: Int, tag: String, onClick: () -> Unit) =
    AppListItem(text, index, count, onClick = onClick, containerColor = MaterialTheme.colorScheme.surfaceContainerLowest, tag = tag,
        trailing = {
            Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(16.dp)) {
                trailingText?.let { Text(it, style = AppType.bodyMedium) }
                ListChevron()
            }
        })

/** Skip today, last and plain (Figma: the Medium Outlined button): skipping isn't an action to invite (U17). */
@Composable
private fun SkipButton(text: String, onClick: () -> Unit) =
    AppButton(text, onClick, Modifier.fillMaxWidth(), style = ButtonStyle.Outlined, size = ButtonSize.Medium, tag = "day-skip")

private class DayAction(val title: String, val prominent: Boolean = false, val enabled: Boolean = true, val spoken: String? = null, val tag: String, val run: () -> Unit)

/**
 * This day (Figma: white, corners 28): the ribbon on a milestone day; "This day"; the count (Display Medium) with its
 * words, or the state (28 Medium); the bar toward the goal (wavy while its timer runs, A90); the logging buttons (52 high) or a checklist's steps;
 * the note behind a divider. The day's logs follow below the card.
 */
@Composable
private fun DayActivity(habit: Habit, day: Int, editable: Boolean, started: Boolean, rev: Int, store: HabitStore, nav: DayNav, onAdded: ((String) -> Unit)? = null, close: () -> Unit = {}) {
    val c = appColors
    val today = store.today()
    val ruled = store.rule(habit, day)
    val running = day == today && store.timers.containsKey(habit.id)
    val tick = rememberTicker(running, store.clock)
    val status = remember(rev, day, store.timers, store.skips, store.pauses) { DayStatus.make(habit, day, store) }
    // A week's, month's or year's goal lists that period's logs, with their days (Figma 912:26587, 915:106625).
    val period = remember(rev, day) { logPeriod(ruled, day, store) }
    val logs = remember(rev, day) { if (period != null) store.periodLogs(habit, period) else if (showsLogs(ruled, habit, day, store)) store.dayLogs(habit, day) else emptyList() }
    val actions = dayActions(habit, ruled, day, editable, logs.isNotEmpty(), store, nav, onAdded, close)
    val skipped = store.isSkipped(habit, day)
    val paused = store.isPaused(habit, day)
    val future = day > today
    val planned = store.rules.isDue(habit, day, countingSkips = false) || !ruled.frequency.isDayBased || ruled.frequency.isFlexible
    val showsBar = started && !skipped && !paused && planned && !ruled.atMost && ruled.kind != HabitKind.Quit && ruled.kind != HabitKind.Task &&
        !(ruled.kind == HabitKind.Check && !store.rules.countsUp(habit, day) && ruled.frequency.isDayBased) &&
        !(ruled.kind == HabitKind.Check && ruled.frequency.isFlexible)
    // A milestone reached here is this sheet's (Android/Docs/Milestones): its pop-up at once when it's a landmark and the
    // day still has room, else the bar over everything, Day details too (Figma's "Milestones from Day details": the bar
    // and the pop-up); never a ribbon in This day (cleanup 6.7).
    val center = store.milestones
    var popup by remember { mutableStateOf<MilestoneShown?>(null) }
    var bar by remember { mutableStateOf<MilestoneShown?>(null) }
    val waiting = center.next(MilestoneCenter.Surface.SHEET)
    LaunchedEffect(waiting) {
        val hit = waiting?.takeIf { it.habitId == habit.id } ?: return@LaunchedEffect
        val s = center.claim(hit, MilestoneCenter.Surface.SHEET) ?: return@LaunchedEffect
        when (s.tier) { MilestoneTier.POPUP -> popup = s; MilestoneTier.BAR -> bar = s; MilestoneTier.ROW -> {} }
    }
    // The bar rises over the sheet (its own window, so above Day details), goes after its time, on See or on a touch
    // elsewhere (Figma: "goes on any other touch, a swipe or the next milestone").
    bar?.let { shown ->
        val w = remember(shown) { center.words(shown, habit) }
        androidx.compose.ui.window.Popup(alignment = Alignment.TopCenter, onDismissRequest = { bar = null }) {
            com.oftenenough.app.ui.components.MilestoneBar(w.number, w.title, habit.name, habit.color, onSee = { popup = shown; bar = null },
                onGone = { bar = null }, modifier = Modifier.statusBarsPadding().padding(start = 16.dp, end = 16.dp, top = 8.dp))
        }
    }

    // This day and the day's note are one group of two (Figma's Day card): This day on top (24 / 4 corners), 2, the note.
    Column(Modifier.fillMaxWidth()) {
    Column(Modifier.fillMaxWidth().clip(segmentShape(0, 2)).background(MaterialTheme.colorScheme.surfaceContainerLowest)
        .padding(horizontal = 16.dp, vertical = 20.dp)) {
        // A week's or month's goal counts the period, so its card says so (Figma's Day details: This week, This month).
        // A paused day names when it's back instead ("Back on Wed, 28 Oct", Figma's Day details, Paused).
        val cardName = status.label ?: when (ruled.frequency) { is Frequency.PerWeek -> "This week"; is Frequency.PerMonth -> "This month"; is Frequency.PerYear -> "This year"; else -> "This day" }
        Text(cardName, style = AppType.labelMedium, color = MaterialTheme.colorScheme.onSurfaceVariant)
        Spacer(Modifier.height(4.dp))
        // While it runs, the day's whole time ticks in the count (6:42 of 10 min), and the line says Running (Figma 906:86998).
        // A limit keeps saying where it stands, live: "42:10 today · Limit 30 min · Over the limit" (Figma 924:38295).
        val detail = if (running && status.running != null) {
            if (ruled.atMost) {
                val p = kotlin.math.floor(store.rules.progress(habit, day, tick.value))
                val limit = store.rules.dayGoal(ruled)
                "Limit " + Format.minutes(limit) + " · " + when {
                    p > limit -> "Over the limit"
                    p >= limit -> "Limit reached"
                    else -> Format.minutes(maxOf(1.0, limit - p)) + " left"
                }
            } else "Running"
        } else status.detail
        // Under an hour it ticks by the second ("6:42 of 10 min"); past an hour by the minute ("1 h 52 of 3 h", Figma 919:31554).
        val title = if (running && status.running != null) {
            val p = store.rules.progress(habit, day, tick.value)
            val goal = Format.minutes(store.rules.goal(ruled))
            if (ruled.atMost) Format.clock(p) + " today"
            else if (p < 60) Format.clock(p) + " of " + goal
            else Format.minutes(kotlin.math.floor(p)).removeSuffix(" min") + " of " + goal.removeSuffix(" min").let { if (it.contains(" h")) it else "$it min" }
        } else status.title
        StatusLine(title, detail, status.words)
        if (showsBar) {
            val goal = maxOf(store.rules.goal(ruled), 1e-9)
            val progress = if (future) 0.0 else if (running) store.rules.progress(habit, day, tick.value) else store.rules.progress(habit, day)
            Spacer(Modifier.height(8.dp))
            HabitProgress((progress / goal).toFloat(), running, color = c.habit(habit.color), trackColor = c.habitFill(habit.color))
        }
        if (future && !skipped) {
            Spacer(Modifier.height(12.dp))
            Text("You can log this on the day.", style = AppType.bodyMedium, color = c.secondary)
        }
        if (actions.isNotEmpty()) {
            Spacer(Modifier.height(24.dp))
            EqualButtons(actions.map { it.title }, ButtonSize.Medium, compact = true) { i, m -> DayButton(actions[i], m) }
        }
        // A checklist's steps: Step rows in the card (molecule 4.3), the ticked box in the habit's colour.
        if (ruled.kind == HabitKind.Checklist && started) {
            val locked = !editable || skipped || paused
            Spacer(Modifier.height(24.dp))
            ruled.steps.forEachIndexed { i, step ->
                val done = remember(rev, day) { store.isStepDone(step, ruled, day) }
                StepRow(step.name, done, c.habit(habit.color), place = StepRowPlace.Card, enabled = !locked, tag = "day-step-$i",
                    onToggle = { store.toggleStep(step, ruled, day, source = EntrySource.DAY_SHEET) })
            }
        }
    }
    Spacer(Modifier.height(SegmentedListGap))
    // The day's note (Figma's Note: a List item, Last): Add a note…, or "Note" over the note's first line.
    val note = store.note(habit, day)
    AppListItem(if (note == null) "Add a note…" else "Note", 1, 2, supporting = note?.let { it.lineSequence().first() }, supportingLines = 1, headlineLines = 1,
        containerColor = MaterialTheme.colorScheme.surfaceContainerLowest,
        leading = { ListAvatar(Symbols.StickyNote2) }, trailing = { ListChevron() },
        onClick = { nav.note(habit, day) }, enabled = editable || note != null || future, tag = if (note == null) "day-add-note" else "day-edit-note")
    }
    if (logs.isNotEmpty()) {
        val shown = if (logs.size <= 3) logs else logs.take(2)
        val rows = shown.size + if (logs.size > 3) 1 else 0
        SectionList(logsTitle(ruled, day, today, period)) {
            shown.forEachIndexed { i, e -> LogRow(e, ruled, i, rows, store, nav, if (period != null) today else null) }
            if (logs.size > 3) AppListItem("All " + logCount(logs.size, ruled) + periodWords(ruled, today, period), rows - 1, rows, trailing = { ListChevron() },
                containerColor = MaterialTheme.colorScheme.surfaceContainerLowest,
                onClick = { nav.allLogs(habit, day) }, tag = "day-all-logs")
        }
    }
    popup?.let { s ->
        val w = remember(s) { center.words(s, habit) }
        MilestonePopup(w.number, w.popupTitle, w.popupSubtitle, habit.color, w.next, second = w.second,
            onClose = { popup = null }, onAll = { popup = null; nav.allMilestones(habit) })
    }
}

/** A logging button (Figma's This day: the Medium button): Filled when it's what the goal asks (U16), else Tonal. */
@Composable
private fun DayButton(a: DayAction, modifier: Modifier) =
    AppButton(a.title, a.run, modifier.semantics { a.spoken?.let { contentDescription = it } },
        style = if (a.prominent) ButtonStyle.Filled else ButtonStyle.Tonal, size = ButtonSize.Medium, enabled = a.enabled, compact = true, tag = a.tag)

/**
 * The count or the state, with its words (Figma "Count and to go"): "4" (Display Medium) "of 8 glasses" (Body Large, grey),
 * or "Done" (28 Medium); the detail at the end of the same line when it fits, else on its own line under it.
 */
@Composable
private fun StatusLine(title: String, detail: String?, words: Boolean = false) {
    val c = appColors
    val match = if (words) null else Regex("^([$€£₹]?\\d[\\d,.:]*(?: h(?: \\d+)?)?)\\s*(.*)$").find(title)
    val measurer = rememberTextMeasurer()
    val density = LocalDensity.current
    BoxWithConstraints(Modifier.fillMaxWidth()) {
        val room = with(density) { maxWidth.toPx() }
        fun w(text: String, style: androidx.compose.ui.text.TextStyle) = measurer.measure(text, style).size.width.toFloat()
        val headWidth = if (match != null) w(match.groupValues[1], AppType.displayMedium) + with(density) { 8.dp.toPx() } + w(match.groupValues[2], AppType.bodyLarge)
            else w(title, AppType.headlineMediumEmphasized)
        val fits = detail != null && headWidth + with(density) { 16.dp.toPx() } + w(detail, AppType.bodyMedium) <= room
        Column {
            Row(Modifier.fillMaxWidth(), verticalAlignment = Alignment.Bottom) {
                if (match != null) {
                    Text(match.groupValues[1], Modifier.alignByBaseline().semantics { testTag = "day-result" }, style = AppType.displayMedium, color = c.ink, maxLines = 1)
                    Spacer(Modifier.width(8.dp))
                    Text(match.groupValues[2], Modifier.alignByBaseline(), style = AppType.bodyLarge, color = c.secondary, maxLines = 1)
                } else Text(title, Modifier.alignByBaseline().semantics { testTag = "day-result" }, style = AppType.headlineMediumEmphasized, color = c.ink)
                if (fits && detail != null) {
                    Spacer(Modifier.weight(1f))
                    Text(detail, Modifier.alignByBaseline().semantics { testTag = "day-detail" }, style = AppType.bodyMedium, color = c.secondary, maxLines = 1)
                }
            }
            if (!fits && detail != null) Text(detail, Modifier.semantics { testTag = "day-detail" }, style = AppType.bodyMedium, color = c.secondary)
        }
    }
}

/** One log (List item, 2.4): what it is, its time, ›; a check has its own Undo instead (U19: checks correct here). */
@Composable
private fun LogRow(entry: Entry, habit: Habit, index: Int, count: Int, store: HabitStore, nav: DayNav, today: Int? = null) {
    val opens = entry.opensRecord(habit)
    AppListItem(entry.description(habit), index, count, headlineLines = 1, tag = "log-${entry.id}", containerColor = MaterialTheme.colorScheme.surfaceContainerLowest,
        onClick = if (opens) ({ nav.log(habit, entry) }) else null,
        trailing = { LogTrailing(entry, habit, opens, today) { store.undoEntry(entry.id) } })
}

/** A log row's end (Figma's List item: Trailing text, then its icon, 16 apart): its time (tabular figures), then › when it opens, or a check's named Undo. */
@Composable
internal fun LogTrailing(entry: Entry, habit: Habit, opens: Boolean, today: Int? = null, onUndo: () -> Unit) =
    Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(16.dp)) {
        // A period's list says the day too: "Today, 2:05 PM", "Tue, 6:40 PM" in a week; in a month or year an earlier
        // day by its date alone, "Mon, 12 Oct" (Figma 917:30014).
        val text = when {
            today == null -> clockText(entry)
            entry.day == today -> "Today, " + clockText(entry)
            habit.frequency.periodNoun == "week" -> DayWords.short(entry.day).substringBefore(",") + ", " + clockText(entry)
            else -> DayWords.short(entry.day)
        }
        Text(tabular(text), style = AppType.bodyMedium)
        if (opens) ListChevron()
        else AppButton("Undo", onUndo, Modifier.semantics { contentDescription = entry.undoLabel(habit) + " at " + clockText(entry) }, style = ButtonStyle.Text)
    }

fun logsTitle(habit: Habit, day: Int, today: Int, period: IntRange? = null): String {
    val short = DayWords.short(day).replace(",", "")
    // "This week’s checks", "This month’s logs" (Figma's week and month goals); an earlier one by when it began.
    if (period != null) {
        val what = when (habit.kind) { HabitKind.Check -> "checks"; HabitKind.Quit -> "slips"; else -> "logs" }
        val noun = habit.frequency.periodNoun
        return if (today in period) "This $noun’s $what" else "${what.replaceFirstChar { it.uppercase() }}, $noun of ${DayWords.short(period.first)}"
    }
    return when (habit.kind) {
        HabitKind.Quit -> if (day == today) "Slips today" else if (day == today - 1) "Slips yesterday" else "Slips on $short"
        // "Yesterday’s logs" (Figma 930:42775); an older day by its date.
        else -> if (day == today) "Today’s logs" else if (day == today - 1) "Yesterday’s logs" else "Logs for $short"
    }
}

fun logCount(n: Int, habit: Habit): String = "$n " + when (habit.kind) {
    HabitKind.Quit -> if (n == 1) "slip" else "slips"
    else -> if (n == 1) "log" else "logs"
}

/** The week, month or year a period goal's logs are listed for (a week's, month's or year's goal; "3 days a week"). */
fun logPeriod(ruled: Habit, day: Int, store: HabitStore): IntRange? {
    val f = ruled.frequency
    val counted = f is Frequency.PerWeek || f is Frequency.PerMonth || f is Frequency.PerYear || (f is Frequency.Flexible && f.period != GoalPeriod.DAY)
    if (!counted || ruled.kind is HabitKind.Quit || ruled.kind == HabitKind.Task || ruled.kind == HabitKind.Checklist) return null
    // Done once a period, its one check is said in This month ("Done today at 2:05 PM"); no list (Figma 913:27794).
    if (ruled.kind == HabitKind.Check && !f.isFlexible && store.rules.goal(ruled) <= 1) return null
    return store.rules.periodRange(ruled, day)
}

/** " this week" after "All 5 logs" (Figma 915:106625); " that week" for an earlier one. */
fun periodWords(habit: Habit, today: Int, period: IntRange?): String =
    if (period == null) "" else (if (today in period) " this " else " that ") + habit.frequency.periodNoun

private fun showsLogs(ruled: Habit, habit: Habit, day: Int, store: HabitStore): Boolean = when (ruled.kind) {
    is HabitKind.Amount, HabitKind.Duration, HabitKind.Quit -> true
    // Once a week, month or year, its one check is said in the card, never listed (Figma 913:27794).
    HabitKind.Check -> store.rules.countsUp(habit, day) && !(!ruled.frequency.isDayBased && !ruled.frequency.isFlexible && store.rules.goal(ruled) <= 1)
    else -> false
}

/** The habit's own buttons for this day, one rule per kind (U16: prominent only for what a positive goal asks). */
private fun dayActions(habit: Habit, ruled: Habit, day: Int, editable: Boolean, hasLogs: Boolean, store: HabitStore, nav: DayNav,
                       onAdded: ((String) -> Unit)? = null, close: () -> Unit = {}): List<DayAction> {
    if (!editable) return emptyList()
    val today = store.today()
    val skipped = store.isSkipped(habit, day)
    val src = EntrySource.DAY_SHEET
    val manual = { nav.addLog(habit, day) }
    // Paused: only Resume (Figma 13).
    if (store.isPaused(habit, day)) {
        return if (store.pause(habit, today)?.contains(today) == true) listOf(DayAction("Resume habit", true, tag = "day-resume") { resume(habit, store, nav, close) }) else emptyList()
    }
    // A day it isn't planned: the same buttons, none of them asking (Figma 3.3).
    val planned = store.rules.isDue(habit, day, countingSkips = false) || !ruled.frequency.isDayBased || ruled.frequency.isFlexible
    val ask = !ruled.atMost && planned
    return when (val k = ruled.kind) {
        HabitKind.Task -> {
            val done = store.rules.isDone(habit, day)
            listOf(DayAction(if (done) "Undo done" else "Mark done", !done, tag = "day-done") { store.toggleCheck(habit, day, src) })
        }
        // Once a week, month or year (Deep clean): Mark done, and Undo done takes that period's check back on any of its
        // days (Figma 913:27361, 913:28949); more than once, Add a check, as a week goal.
        HabitKind.Check -> if (!ruled.frequency.isDayBased && !ruled.frequency.isFlexible && store.rules.goal(ruled) <= 1) {
            val done = store.rules.isDone(habit, day)
            listOf(DayAction(if (done) "Undo done" else "Mark done", !done && ask, !skipped, tag = "day-done") {
                if (done) store.undoLast(habit, day) else store.addProgress(habit, 1.0, day, source = src)
            })
        } else if (store.rules.countsUp(habit, day)) {
            listOf(DayAction("Add a check", ask, !skipped, tag = "day-add-one") { store.addProgress(habit, 1.0, day, source = src) })
        } else {
            val done = store.rules.isDayMet(ruled, day)
            listOf(DayAction(if (done) "Undo done" else "Mark done", !done && ask, !skipped, tag = "day-done") { store.setDayDone(!done, habit, day) })
        }
        HabitKind.Checklist -> emptyList()
        is HabitKind.Amount -> {
            val step = ruled.quickIncrement
            // Figma's Day details sheet (669:234, Kind=Amount): "+1 | Log"; an amount typed each time has the one Log.
            if (step == null) listOf(DayAction("Log", ask, !skipped, tag = "day-add-entry", run = manual))
            else listOf(
                DayAction("+" + Format.amount(step), ask, !skipped, "Add " + HabitCopy.amount(step, k.unit), "day-add-step") {
                    // A past day's log says nothing: history added later isn't celebrated (Figma 930:43143).
                    store.increment(habit, day, src)
                },
                DayAction("Log", enabled = !skipped, tag = "day-add-entry", run = manual),
            )
        }
        HabitKind.Duration -> if (day != today) listOf(DayAction("Log time", ask, !skipped, tag = "day-add-entry", run = manual))
        else listOf(
            // Pause saves the time as one log, with its seconds (Figma 906:87291); Start timer opens the full-screen timer.
            if (store.timers.containsKey(habit.id)) DayAction("Pause", ask, !skipped, tag = "day-stop-timer") { store.stopTimer(habit, day) }
            else DayAction("Start timer", ask, !skipped, tag = "day-start-timer") { store.toggleTimer(habit); nav.timer(habit) },
            // Figma's Day details for a time habit: "Start timer | Log time" (Day details flows 13, 23).
            DayAction("Log time", enabled = !skipped, tag = "day-add-entry", run = manual),
        )
        HabitKind.Quit -> listOf(DayAction(if (hasLogs) "Log another slip" else "Log a slip", tag = "day-add-entry", run = manual))
    }
}

/** Another day… (a task): the Date picker (5.3.6), the days it can move to (Figma's Limit, Tomorrow and later). */
@Composable
private fun RescheduleDialog(habit: Habit, day: Int, store: HabitStore, onDismiss: () -> Unit, onMoved: () -> Unit) {
    val range = store.rescheduleRange(habit, day) ?: run { onDismiss(); return }
    // Android's own picker with nothing picked yet (Figma 928:40378: "Select date", "Select a day", Cancel | OK).
    AppDatePicker(null, { it in range }, onDismiss) { picked ->
        store.reschedule(habit, day, picked)
        onMoved()
    }
}
