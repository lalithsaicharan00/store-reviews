package com.oftenenough.app.ui.day

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
import com.oftenenough.app.ui.components.MenuDivider
import com.oftenenough.app.ui.components.MilestoneRibbon
import com.oftenenough.app.ui.components.MilestoneRibbonArrival
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

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.BoxWithConstraints
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.DatePicker
import androidx.compose.material3.DatePickerDialog
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.ModalBottomSheet
import androidx.compose.material3.SelectableDates
import androidx.compose.material3.Text
import androidx.compose.material3.rememberDatePickerState
import com.oftenenough.app.ui.components.rememberWholeSheetState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.key
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
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.DayStatus
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Entry
import com.oftenenough.app.data.EntrySource
import com.oftenenough.app.data.Format
import com.oftenenough.app.data.Frequency
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
import com.oftenenough.app.ui.components.WavyProgress
import com.oftenenough.app.ui.theme.appColors
import com.oftenenough.app.ui.today.rememberTicker
import java.time.Instant
import java.time.LocalDate
import java.time.ZoneOffset

/** Where Day details hands over: the screens it opens. */
interface DayNav {
    fun habitPage(habit: Habit)
    fun addLog(habit: Habit, day: Int)
    fun note(habit: Habit, day: Int)
    fun log(habit: Habit, entry: Entry)
    fun allLogs(habit: Habit, day: Int)
    fun edit(habit: Habit)
    fun pause(habit: Habit)
    /** The habit's page, open at All milestones (the landmark pop-up's button, Figma 14.1). */
    fun allMilestones(habit: Habit) = habitPage(habit)
}

/** "8 glasses a day · Anytime", "Quitting since 19 Sep 2026", "Task · Planned for Sat, 4 Oct" (the iPhone's DayIdentityRow). */
fun planLine(habit: Habit, store: HabitStore): String = when (habit.kind) {
    HabitKind.Quit -> "Quitting since " + DayWords.long(store.rules.calendarDayOf(habit.quitSince ?: habit.createdAt))
    HabitKind.Task -> habit.dueDay?.let { if (it == com.oftenenough.app.data.NO_DATE_DAY) "Task · No date" else "Task · Planned for " + DayWords.short(it) } ?: ("Task · " + HabitCopy.capitalized(HabitCopy.plan(habit, store.weekStart)))
    else -> shortDays(habit, store.weekStart).ifEmpty { HabitCopy.capitalized(HabitCopy.plan(habit, store.weekStart)) } + " · " +
        (if (habit.parts == listOf("anytime")) "Anytime" else HabitCopy.capitalized(HabitCopy.join(habit.parts.map { store.section(it).name })))
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
    ModalBottomSheet(onDismiss, sheetState = state) {
        // A sheet is its own window: its tags reach UI Automator only if it says so too.
        val snackbar = remember { SnackbarHostState() }
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
        // The top bar: ✕, the day, ⋮ (56 high).
        Row(Modifier.fillMaxWidth().height(56.dp).padding(horizontal = 4.dp), verticalAlignment = Alignment.CenterVertically) {
            IconButton(onDismiss, Modifier.semantics { testTag = "day-close" }) { Icon(Symbols.Close, "Close", tint = c.ink) }
            Spacer(Modifier.width(4.dp))
            Text(if (day == today + 1) "Tomorrow" else DayWords.day(day, today), Modifier.weight(1f), style = AppType.titleLargeEmphasized, color = c.ink, maxLines = 1)
            Box {
                StandardIconButton(Symbols.MoreVert, if (isTask) "Task actions" else "Habit actions", { menu = true }, Modifier.semantics { testTag = "day-more" })
                DayMenu(menu, { menu = false }, habit, store, today, nav, onDismiss) { confirmDelete = true }
            }
        }
        Column(Modifier.padding(start = 16.dp, end = 16.dp, top = 8.dp), verticalArrangement = Arrangement.spacedBy(12.dp)) {
            IdentityCard(habit, store, nav)
            DayActivity(habit, day, editable, started, rev, store, nav, onAdded)
            if (isTask && store.canReschedule(habit, day)) {
                SectionList("Reschedule") {
                    RowAction("Do tomorrow", Symbols.Redo, 0, 2, "day-do-tomorrow") { store.reschedule(habit, day, today + 1); onDismiss() }
                    RowAction("Another day…", Symbols.CalendarMonth, 1, 2, "day-another-day") { reschedule = true }
                }
            } else if (!isTask && habit.kind != HabitKind.Quit && started && !habit.atMost && !store.isPaused(habit, day)) {
                val skipped = store.isSkipped(habit, day)
                val planned = store.rules.isDue(habit, day, countingSkips = false) || !store.rule(habit, day).frequency.isDayBased || store.rule(habit, day).frequency.isFlexible
                if (skipped || (planned && store.rules.canSkip(store.rule(habit, day)))) {
                    SkipButton(if (skipped) "Undo skip" else if (day == today) "Skip today" else "Skip this day") { store.setSkipped(habit, day, !skipped) }
                }
            }
        }
        Spacer(Modifier.height(24.dp))
    }
    if (confirmDelete) AlertDialog(
        onDismissRequest = { confirmDelete = false },
        title = { Text("Delete ${habit.name}?") },
        text = { Text("Its history and notes are deleted too, and this can't be undone. Archiving stops it and keeps its history.") },
        confirmButton = { AppButton(if (isTask) "Delete task" else "Delete habit", { confirmDelete = false; onDismiss(); store.delete(listOf(habit)) }, Modifier.semantics { testTag = "day-delete-confirm" }, style = ButtonStyle.Text, destructive = true) },
        dismissButton = {
            Row {
                if (!habit.archived) AppButton("Archive instead", { confirmDelete = false; store.archive(listOf(habit)); onDismiss() }, style = ButtonStyle.Text)
                AppButton("Cancel", { confirmDelete = false }, style = ButtonStyle.Text)
            }
        },
    )
    if (reschedule) RescheduleDialog(habit, day, store, { reschedule = false }) { reschedule = false; onDismiss() }
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
            if (store.isPaused(habit, today)) item("Resume habit", Symbols.PlayCircle, tag = "day-menu-resume") { store.resume(habit) }
            else item("Pause…", Symbols.PauseCircle, tag = "day-menu-pause") { nav.pause(habit) }
        }
        MenuDivider()
        if (habit.archived) item("Restore", Symbols.Unarchive, tag = "day-menu-restore") { store.restore(habit) }
        else item("Archive", Symbols.Archive, tag = "day-menu-archive") { store.archive(listOf(habit)); onClose() }
        item(if (isTask) "Delete task…" else "Delete habit…", Symbols.Delete, red = true, tag = "day-menu-delete") { onDelete() }
    }
}

/** The habit (Figma: 72 high, corners 24): its icon in a 48 circle, the name over the plan, ›; opens its page. */
@Composable
private fun IdentityCard(habit: Habit, store: HabitStore, nav: DayNav) {
    val c = appColors
    val isTask = habit.kind == HabitKind.Task
    Row(Modifier.fillMaxWidth().heightIn(min = 72.dp).clip(RoundedCornerShape(24.dp)).background(c.surface)
        .let { if (!isTask) it.clickable { nav.habitPage(habit) } else it }.padding(start = 16.dp, end = 12.dp, top = 8.dp, bottom = 8.dp)
        .semantics { testTag = "day-identity" }, verticalAlignment = Alignment.CenterVertically) {
        HabitIcon(habit.symbol, habit.color, size = 48.dp)
        Spacer(Modifier.width(16.dp))
        Column(Modifier.weight(1f)) {
            Text(habit.name, style = AppType.titleMedium, color = c.ink, maxLines = 2, overflow = TextOverflow.Ellipsis)
            Text(planLine(habit, store), style = AppType.bodyMedium, color = c.secondary, maxLines = 1, overflow = TextOverflow.Ellipsis)
        }
        if (!isTask) Icon(Symbols.KeyboardArrowRight, null, tint = c.secondary)
    }
}

/** A section under This day: its title (Label Large, grey), 6 dp, then its segmented rows. */
@Composable
private fun SectionList(title: String, rows: @Composable () -> Unit) {
    Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
        Text(title, Modifier.padding(bottom = 6.dp), style = AppType.labelLarge, color = appColors.secondary)
        rows()
    }
}

@Composable
private fun RowAction(text: String, icon: ImageVector, index: Int, count: Int, tag: String, onClick: () -> Unit) =
    AppListItem(text, index, count, leading = { Icon(icon, null) }, onClick = onClick, tag = tag)

/** Skip today, last and plain (Figma: the Medium Outlined button): skipping isn't an action to invite (U17). */
@Composable
private fun SkipButton(text: String, onClick: () -> Unit) =
    AppButton(text, onClick, Modifier.fillMaxWidth(), style = ButtonStyle.Outlined, size = ButtonSize.Medium, tag = "day-skip")

private class DayAction(val title: String, val prominent: Boolean = false, val enabled: Boolean = true, val spoken: String? = null, val tag: String, val run: () -> Unit)

/**
 * This day (Figma: white, corners 28): the ribbon on a milestone day; "This day"; the count (Display Medium) with its
 * words, or the state (28 Medium); the wavy bar toward the goal; the logging buttons (52 high) or a checklist's steps;
 * the note behind a divider. The day's logs follow below the card.
 */
@Composable
private fun DayActivity(habit: Habit, day: Int, editable: Boolean, started: Boolean, rev: Int, store: HabitStore, nav: DayNav, onAdded: ((String) -> Unit)? = null) {
    val c = appColors
    val today = store.today()
    val ruled = store.rule(habit, day)
    val running = day == today && store.timers.containsKey(habit.id)
    val tick = rememberTicker(running, store.clock)
    val status = remember(rev, day, store.timers, store.skips, store.pauses) { DayStatus.make(habit, day, store) }
    val logs = remember(rev, day) { if (showsLogs(ruled, habit, day, store)) store.dayLogs(habit, day) else emptyList() }
    val actions = dayActions(habit, ruled, day, editable, logs.isNotEmpty(), store, nav, onAdded)
    val skipped = store.isSkipped(habit, day)
    val paused = store.isPaused(habit, day)
    val future = day > today
    val planned = store.rules.isDue(habit, day, countingSkips = false) || !ruled.frequency.isDayBased || ruled.frequency.isFlexible
    val showsBar = started && !skipped && !paused && planned && !ruled.atMost && ruled.kind != HabitKind.Quit && ruled.kind != HabitKind.Task &&
        !(ruled.kind == HabitKind.Check && !store.rules.countsUp(habit, day) && ruled.frequency.isDayBased) &&
        !(ruled.kind == HabitKind.Check && ruled.frequency.isFlexible)
    // A milestone reached here is this sheet's (Android/Docs/Milestones): its pop-up at once when it's a landmark and the
    // day still has room (Figma 14.1), else the ribbon (14); it stays for the rest of the day.
    val center = store.milestones
    val milestone = remember(rev, day, center.shown(habit.id)) { if (day == today) center.visible(habit) else null }
    var popup by remember { mutableStateOf<MilestoneShown?>(null) }
    var playRibbon by remember { mutableStateOf(false) }
    val waiting = center.next(MilestoneCenter.Surface.SHEET)
    LaunchedEffect(waiting) {
        val hit = waiting?.takeIf { it.habitId == habit.id } ?: return@LaunchedEffect
        val s = center.claim(hit, MilestoneCenter.Surface.SHEET) ?: return@LaunchedEffect
        if (s.tier == MilestoneTier.POPUP) popup = s else playRibbon = true
    }

    Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(28.dp)).background(c.surface).padding(start = 20.dp, end = 20.dp, top = 18.dp, bottom = 4.dp)) {
        if (milestone != null) {
            // Not in Figma's Day details (a milestone reached here shows the bar over it); kept for the Day details sheet.
            key("${habit.id}|${milestone.value}") {
                MilestoneRibbonArrival(playRibbon) {
                    MilestoneRibbon(remember(milestone) { center.words(milestone, habit).band }, habit.color, play = playRibbon,
                        modifier = Modifier.clip(RoundedCornerShape(12.dp)))
                }
            }
            Spacer(Modifier.height(12.dp))
        }
        Text("This day", style = AppType.labelMedium, color = c.secondary)
        val detail = if (running && status.running != null) {
            "Timer running · " + Format.clock((tick.value - status.running) / 60_000.0) + (if (ruled.atMost) " · Limit " + Format.minutes(store.rules.dayGoal(ruled)) else "")
        } else status.detail
        StatusLine(status.title, detail)
        if (showsBar) {
            val goal = maxOf(store.rules.goal(ruled), 1e-9)
            val progress = if (future) 0.0 else if (running) store.rules.progress(habit, day, tick.value) else store.rules.progress(habit, day)
            Spacer(Modifier.height(8.dp))
            WavyProgress((progress / goal).toFloat(), color = c.habit(habit.color), trackColor = c.habitFill(habit.color))
        }
        if (future && !skipped) {
            Spacer(Modifier.height(12.dp))
            Text("You can log this on the day.", style = AppType.bodyMedium, color = c.secondary)
        }
        if (actions.isNotEmpty()) {
            Spacer(Modifier.height(12.dp))
            Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                for (a in actions) DayButton(a, Modifier.weight(1f))
            }
        }
        // A checklist's steps: Step rows in the card (molecule 4.3), the ticked box in the habit's colour.
        if (ruled.kind == HabitKind.Checklist && started) {
            val locked = !editable || skipped || paused
            Spacer(Modifier.height(4.dp))
            ruled.steps.forEachIndexed { i, step ->
                val done = remember(rev, day) { store.isStepDone(step, ruled, day) }
                StepRow(step.name, done, c.habit(habit.color), place = StepRowPlace.Card, enabled = !locked, tag = "day-step-$i",
                    onToggle = { store.toggleStep(step, ruled, day, source = EntrySource.DAY_SHEET) })
            }
        }
        Spacer(Modifier.height(16.dp))
        HorizontalDivider()
        val note = store.note(habit, day)
        Row(Modifier.fillMaxWidth().clickable(enabled = editable || note != null || future) { nav.note(habit, day) }
            .padding(vertical = if (note == null) 14.dp else 12.dp)
            .semantics { testTag = if (note == null) "day-add-note" else "day-edit-note" }, verticalAlignment = Alignment.CenterVertically) {
            Icon(Symbols.StickyNote2, null, tint = c.secondary)
            Spacer(Modifier.width(16.dp))
            Column(Modifier.weight(1f), verticalArrangement = Arrangement.spacedBy(2.dp)) {
                if (note != null) {
                    Text("Note", style = AppType.labelMedium, color = c.secondary)
                    Text(note, style = AppType.bodyMedium, color = c.ink, maxLines = 2, overflow = TextOverflow.Ellipsis)
                } else Text("Add a note…", style = AppType.bodyMedium, color = c.secondary)
            }
            Spacer(Modifier.width(16.dp))
            Icon(Symbols.KeyboardArrowRight, null, tint = c.secondary)
        }
    }
    if (logs.isNotEmpty()) {
        val shown = if (logs.size <= 3) logs else logs.take(2)
        val rows = shown.size + if (logs.size > 3) 1 else 0
        SectionList(logsTitle(ruled, day, today)) {
            shown.forEachIndexed { i, e -> LogRow(e, ruled, i, rows, store, nav) }
            if (logs.size > 3) AppListItem("All " + logCount(logs.size, ruled), rows - 1, rows, trailing = { ListChevron() },
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
private fun StatusLine(title: String, detail: String?) {
    val c = appColors
    val match = Regex("^([$€£₹]?\\d[\\d,.]*)\\s*(.*)$").find(title)
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
private fun LogRow(entry: Entry, habit: Habit, index: Int, count: Int, store: HabitStore, nav: DayNav) {
    val opens = entry.opensRecord(habit)
    AppListItem(entry.description(habit), index, count, headlineLines = 1, tag = "log-${entry.id}",
        onClick = if (opens) ({ nav.log(habit, entry) }) else null,
        trailing = { LogTrailing(entry, habit, opens) { store.undoEntry(entry.id) } })
}

/** A log row's end: its time (tabular figures), then › when it opens, or a check's named Undo. */
@Composable
internal fun LogTrailing(entry: Entry, habit: Habit, opens: Boolean, onUndo: () -> Unit) =
    Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(8.dp)) {
        Text(clockText(entry), style = AppType.bodyMedium.copy(fontFeatureSettings = "tnum"))
        if (opens) ListChevron()
        else AppButton("Undo", onUndo, Modifier.semantics { contentDescription = entry.undoLabel(habit) + " at " + clockText(entry) }, style = ButtonStyle.Text)
    }

fun logsTitle(habit: Habit, day: Int, today: Int): String {
    val short = DayWords.short(day).replace(",", "")
    return when (habit.kind) {
        HabitKind.Quit -> if (day == today) "Slips today" else "Slips on $short"
        HabitKind.Check -> if (day == today) "Checks today" else "Checks on $short"
        else -> if (day == today) "Today's logs" else "Logs for $short"
    }
}

fun logCount(n: Int, habit: Habit): String = "$n " + when (habit.kind) {
    HabitKind.Quit -> if (n == 1) "slip" else "slips"
    HabitKind.Check -> if (n == 1) "check" else "checks"
    else -> if (n == 1) "log" else "logs"
}

private fun showsLogs(ruled: Habit, habit: Habit, day: Int, store: HabitStore): Boolean = when (ruled.kind) {
    is HabitKind.Amount, HabitKind.Duration, HabitKind.Quit -> true
    HabitKind.Check -> store.rules.countsUp(habit, day)
    else -> false
}

/** The habit's own buttons for this day, one rule per kind (U16: prominent only for what a positive goal asks). */
private fun dayActions(habit: Habit, ruled: Habit, day: Int, editable: Boolean, hasLogs: Boolean, store: HabitStore, nav: DayNav,
                       onAdded: ((String) -> Unit)? = null): List<DayAction> {
    if (!editable) return emptyList()
    val today = store.today()
    // On a past day, a quick add says so: "Added 1 glass to Sat 19 Sep" (Figma 4.3); today's shows on the screen itself.
    val said = { what: String -> if (day != today) onAdded?.invoke("Added $what to " + com.oftenenough.app.data.pageDayDate(day)) }
    val skipped = store.isSkipped(habit, day)
    val src = EntrySource.DAY_SHEET
    val manual = { nav.addLog(habit, day) }
    // Paused: only Resume (Figma 13).
    if (store.isPaused(habit, day)) {
        return if (store.pause(habit, today)?.contains(today) == true) listOf(DayAction("Resume habit", true, tag = "day-resume") { store.resume(habit) }) else emptyList()
    }
    // A day it isn't planned: the same buttons, none of them asking (Figma 3.3).
    val planned = store.rules.isDue(habit, day, countingSkips = false) || !ruled.frequency.isDayBased || ruled.frequency.isFlexible
    val ask = !ruled.atMost && planned
    return when (val k = ruled.kind) {
        HabitKind.Task -> {
            val done = store.rules.isDone(habit, day)
            listOf(DayAction(if (done) "Undo done" else "Mark done", !done, tag = "day-done") { store.toggleCheck(habit, day, src) })
        }
        HabitKind.Check -> if (store.rules.countsUp(habit, day)) {
            listOf(DayAction("Add a check", ask, !skipped, tag = "day-add-one") { store.addProgress(habit, 1.0, day, source = src); said("a check") })
        } else {
            val done = store.rules.isDayMet(ruled, day)
            listOf(DayAction(if (done) "Undo done" else "Mark done", !done && ask, !skipped, tag = "day-done") { store.setDayDone(!done, habit, day) })
        }
        HabitKind.Checklist -> emptyList()
        is HabitKind.Amount -> {
            val step = ruled.quickIncrement
            if (step == null) listOf(DayAction("Log amount", ask, !skipped, tag = "day-add-entry", run = manual))
            else listOf(
                DayAction("+" + Format.amount(step), ask, !skipped, "Add " + HabitCopy.amount(step, k.unit), "day-add-step") {
                    store.increment(habit, day, src)
                    said(HabitCopy.amount(step, k.unit))
                },
                DayAction("Log manually", enabled = !skipped, tag = "day-add-entry", run = manual),
            )
        }
        HabitKind.Duration -> if (day != today) listOf(DayAction("Log time", ask, !skipped, tag = "day-add-entry", run = manual))
        else listOf(
            if (store.timers.containsKey(habit.id)) DayAction("Stop and save", ask, !skipped, tag = "day-stop-timer") { store.stopTimer(habit, day) }
            else DayAction("Start timer", ask, !skipped, tag = "day-start-timer") { store.toggleTimer(habit) },
            DayAction("Log manually", enabled = !skipped, tag = "day-add-entry", run = manual),
        )
        HabitKind.Quit -> listOf(DayAction(if (hasLogs) "Record another slip" else "Record a slip", tag = "day-add-entry", run = manual))
    }
}

/** Another day… (a task): Android's date picker, the days it can move to. */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun RescheduleDialog(habit: Habit, day: Int, store: HabitStore, onDismiss: () -> Unit, onMoved: () -> Unit) {
    val c = appColors
    val range = store.rescheduleRange(habit, day) ?: run { onDismiss(); return }
    val toMs = { d: Int -> LocalDate.ofEpochDay(d.toLong()).atStartOfDay(ZoneOffset.UTC).toInstant().toEpochMilli() }
    val picker = rememberDatePickerState(initialSelectedDateMillis = toMs(range.first), selectableDates = object : SelectableDates {
        override fun isSelectableDate(utcTimeMillis: Long): Boolean =
            Instant.ofEpochMilli(utcTimeMillis).atZone(ZoneOffset.UTC).toLocalDate().toEpochDay().toInt() in range
    })
    DatePickerDialog(onDismiss, confirmButton = {
        AppButton("Move", {
            picker.selectedDateMillis?.let { store.reschedule(habit, day, Instant.ofEpochMilli(it).atZone(ZoneOffset.UTC).toLocalDate().toEpochDay().toInt()) }
            onMoved()
        }, style = ButtonStyle.Text)
    }, dismissButton = { AppButton("Cancel", onDismiss, style = ButtonStyle.Text) }) {
        DatePicker(picker, title = { Text("Another day", Modifier.padding(start = 24.dp, top = 16.dp)) })
    }
}
