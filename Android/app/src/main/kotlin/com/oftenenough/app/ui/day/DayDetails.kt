package com.oftenenough.app.ui.day

import com.oftenenough.app.ui.theme.AppType

import android.content.Context
import androidx.compose.foundation.background
import androidx.compose.foundation.border
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
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowRight
import androidx.compose.material.icons.automirrored.rounded.Redo
import androidx.compose.material.icons.automirrored.outlined.StickyNote2
import androidx.compose.material.icons.outlined.Archive
import androidx.compose.material.icons.outlined.Delete
import androidx.compose.material.icons.outlined.Edit
import androidx.compose.material.icons.outlined.Insights
import androidx.compose.material.icons.outlined.PauseCircle
import androidx.compose.material.icons.outlined.PlayCircle
import androidx.compose.material.icons.outlined.Unarchive
import androidx.compose.material.icons.rounded.CalendarMonth
import androidx.compose.material.icons.rounded.Check
import androidx.compose.material.icons.rounded.Close
import androidx.compose.material.icons.rounded.MoreVert
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.DatePicker
import androidx.compose.material3.DatePickerDialog
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.ModalBottomSheet
import androidx.compose.material3.SelectableDates
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.rememberDatePickerState
import androidx.compose.material3.rememberModalBottomSheetState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Shape
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.stateDescription
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.text.rememberTextMeasurer
import androidx.compose.ui.text.style.TextDecoration
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.oftenenough.app.app.AppGraph
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
import com.oftenenough.app.data.StreakUnit
import com.oftenenough.app.data.clockText
import com.oftenenough.app.data.description
import com.oftenenough.app.data.milestoneRowTitle
import com.oftenenough.app.data.milestonesUpTo
import com.oftenenough.app.data.opensRecord
import com.oftenenough.app.data.undoLabel
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.WavyProgress
import com.oftenenough.app.ui.components.segmentShape
import com.oftenenough.app.ui.theme.appColors
import com.oftenenough.app.ui.today.rememberTicker
import com.oftenenough.app.ui.today.showsStreaks
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
    HabitKind.Task -> habit.dueDay?.let { "Task · Planned for " + DayWords.short(it) } ?: ("Task · " + HabitCopy.capitalized(HabitCopy.plan(habit, store.weekStart)))
    else -> shortDays(habit, store.weekStart).ifEmpty { HabitCopy.capitalized(HabitCopy.plan(habit, store.weekStart)) } + " · " +
        (if (habit.parts == listOf("anytime")) "Anytime" else HabitCopy.capitalized(HabitCopy.join(habit.parts.map { store.section(it).name })))
}

/** A check on set days names them short, in week order (Figma 3.3: "Mon, Wed, Fri · Morning"); otherwise empty. */
private fun shortDays(habit: Habit, weekStart: Int): String {
    val f = habit.frequency as? Frequency.Weekdays ?: return ""
    if (habit.kind != HabitKind.Check || f.days.size !in 1..6 || f.days == setOf(2, 3, 4, 5, 6) || f.days == setOf(1, 7)) return ""
    return f.days.sortedBy { ((it - weekStart) % 7 + 7) % 7 }.joinToString(", ") { HabitCopy.shortDays[(it - 1 + 7) % 7] }
}

/** The divider in This day, and the outline of Skip (Figma #E2E2E6, #C7C7CC). */
private val DividerLight = Color(0xFFE2E2E6)
private val SkipLineLight = Color(0xFFC7C7CC)

/**
 * Day details (Figma `2308:2`): one habit (or task) on one day, a modal bottom sheet. Its top bar is ✕, the day and ⋮; the
 * habit opens its page; This day holds the status, the logging buttons and the note; the day's logs follow (at most
 * three rows); Skip last, outlined (U14–U17).
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun DayDetailsSheet(habitId: String, day: Int, store: HabitStore, nav: DayNav, onDismiss: () -> Unit) {
    val habit = store.habit(habitId) ?: run { onDismiss(); return }
    val c = appColors
    val state = rememberModalBottomSheetState(skipPartiallyExpanded = true)
    ModalBottomSheet(onDismiss, sheetState = state, containerColor = c.screen, shape = RoundedCornerShape(topStart = 28.dp, topEnd = 28.dp),
        dragHandle = {
            Box(Modifier.padding(top = 16.dp, bottom = 4.dp).size(32.dp, 4.dp).clip(RoundedCornerShape(2.dp)).background(Color(0x8079797E)))
        }) {
        // A sheet is its own window: its tags reach UI Automator only if it says so too.
        Box(Modifier.semantics { testTagsAsResourceId = true }) { DayDetailsContent(habit, day, store, nav, onDismiss) }
    }
}

@Composable
fun DayDetailsContent(habit: Habit, day: Int, store: HabitStore, nav: DayNav, onDismiss: () -> Unit) {
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
            IconButton(onDismiss, Modifier.semantics { testTag = "day-close" }) { Icon(Icons.Rounded.Close, "Close", tint = c.ink) }
            Spacer(Modifier.width(4.dp))
            Text(if (day == today + 1) "Tomorrow" else DayWords.day(day, today), Modifier.weight(1f), style = AppType.titleLargeEmphasized, color = c.ink, maxLines = 1)
            Box {
                IconButton({ menu = true }, Modifier.semantics { testTag = "day-more" }) { Icon(Icons.Rounded.MoreVert, if (isTask) "Task actions" else "Habit actions", tint = c.ink) }
                DayMenu(menu, { menu = false }, habit, store, today, nav, onDismiss) { confirmDelete = true }
            }
        }
        Column(Modifier.padding(start = 16.dp, end = 16.dp, top = 8.dp), verticalArrangement = Arrangement.spacedBy(12.dp)) {
            IdentityCard(habit, store, nav)
            DayActivity(habit, day, editable, started, rev, store, nav)
            if (isTask && store.canReschedule(habit, day)) {
                SectionList("Reschedule") {
                    RowAction("Do tomorrow", Icons.AutoMirrored.Rounded.Redo, segmentShape(0, 2), "day-do-tomorrow") { store.reschedule(habit, day, today + 1); onDismiss() }
                    RowAction("Another day…", Icons.Rounded.CalendarMonth, segmentShape(1, 2), "day-another-day") { reschedule = true }
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
        confirmButton = { TextButton({ confirmDelete = false; onDismiss(); store.delete(listOf(habit)) }, Modifier.semantics { testTag = "day-delete-confirm" }) { Text(if (isTask) "Delete task" else "Delete habit", color = c.error) } },
        dismissButton = {
            Row {
                if (!habit.archived) TextButton({ confirmDelete = false; store.archive(listOf(habit)); onDismiss() }) { Text("Archive instead", color = c.ink) }
                TextButton({ confirmDelete = false }) { Text("Cancel", color = c.ink) }
            }
        },
    )
    if (reschedule) RescheduleDialog(habit, day, store, { reschedule = false }) { reschedule = false; onDismiss() }
}

/** ⋮ (Figma 1.5): View habit, Edit habit, Pause…, then Archive and Delete habit…, each with its icon; only Delete red. */
@Composable
private fun DayMenu(open: Boolean, onDismiss: () -> Unit, habit: Habit, store: HabitStore, today: Int, nav: DayNav, onClose: () -> Unit, onDelete: () -> Unit) {
    val c = appColors
    val isTask = habit.kind == HabitKind.Task
    DropdownMenu(open, onDismiss, shape = RoundedCornerShape(16.dp), containerColor = c.menu, shadowElevation = 6.dp) {
        @Composable fun item(text: String, icon: ImageVector, red: Boolean = false, tag: String, action: () -> Unit) = DropdownMenuItem(
            text = { Text(text, style = AppType.bodyLarge, color = if (red) c.error else c.ink) },
            leadingIcon = { Icon(icon, null, tint = if (red) c.error else c.secondary) },
            onClick = { onDismiss(); action() }, modifier = Modifier.semantics { testTag = tag })
        if (!isTask) item("View habit", Icons.Outlined.Insights, tag = "day-menu-view") { nav.habitPage(habit) }
        item(if (isTask) "Edit task" else "Edit habit", Icons.Outlined.Edit, tag = "day-menu-edit") { nav.edit(habit) }
        if (!isTask && store.rules.canPause(habit)) {
            if (store.isPaused(habit, today)) item("Resume habit", Icons.Outlined.PlayCircle, tag = "day-menu-resume") { store.resume(habit) }
            else item("Pause…", Icons.Outlined.PauseCircle, tag = "day-menu-pause") { nav.pause(habit) }
        }
        HorizontalDivider(color = c.tonal)
        if (habit.archived) item("Restore", Icons.Outlined.Unarchive, tag = "day-menu-restore") { store.restore(habit) }
        else item("Archive", Icons.Outlined.Archive, tag = "day-menu-archive") { store.archive(listOf(habit)); onClose() }
        item(if (isTask) "Delete task…" else "Delete habit…", Icons.Outlined.Delete, red = true, tag = "day-menu-delete") { onDelete() }
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
        if (!isTask) Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = c.secondary)
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
private fun RowAction(text: String, icon: ImageVector, shape: Shape, tag: String, onClick: () -> Unit) {
    Row(Modifier.fillMaxWidth().clip(shape).background(appColors.surface).clickable(onClick = onClick).heightIn(min = 56.dp)
        .padding(start = 16.dp, end = 12.dp).semantics { testTag = tag }, verticalAlignment = Alignment.CenterVertically) {
        Icon(icon, null, tint = appColors.ink)
        Spacer(Modifier.width(16.dp))
        Text(text, style = AppType.bodyLarge, color = appColors.ink)
    }
}

/** Skip today, last and plain (Figma: outlined, 48 high, corners 24): skipping isn't an action to invite (U17). */
@Composable
private fun SkipButton(text: String, onClick: () -> Unit) {
    val c = appColors
    Box(Modifier.fillMaxWidth().height(48.dp).clip(RoundedCornerShape(24.dp))
        .border(1.dp, if (c.dark) c.line else SkipLineLight, RoundedCornerShape(24.dp)).clickable(role = Role.Button, onClick = onClick)
        .semantics { testTag = "day-skip" }, contentAlignment = Alignment.Center) {
        Text(text, style = AppType.titleMedium, color = c.ink)
    }
}

private class DayAction(val title: String, val prominent: Boolean = false, val enabled: Boolean = true, val spoken: String? = null, val tag: String, val run: () -> Unit)

/** A milestone this habit reached today, and whether it's a landmark (its pop-up), else the ribbon (Figma 14, 14.1). */
private class Reached(val value: Int, val unit: StreakUnit, val landmark: Boolean, val next: Int?)

private fun reachedToday(habit: Habit, day: Int, store: HabitStore): Reached? {
    if (day != store.today() || habit.kind == HabitKind.Task || habit.kind == HabitKind.Quit || !store.showsStreaks()) return null
    val ruled = store.rule(habit, day)
    if (!store.rules.isDone(habit, day) || ruled.atMost) return null
    val streak = store.streak(habit, day)
    val unit = ruled.frequency.streakUnit
    val ladder = store.rules.milestonesUpTo(unit, streak * 4 + 400)
    if (streak < 3 || streak !in ladder) return null
    // A landmark: a month of days or more in a row (Figma 14.1, "the first 30 days in a row"); smaller ones are the ribbon.
    val landmark = (unit == StreakUnit.DAYS || unit == StreakUnit.TIMES) && streak >= 30
    return Reached(streak, unit, landmark, ladder.firstOrNull { it > streak })
}

/** Each landmark's pop-up shows once (per habit, value and day), kept on this phone. */
private fun landmarkSeen(context: Context, key: String, mark: Boolean = false): Boolean {
    val prefs = context.getSharedPreferences(if (AppGraph.isOpen && AppGraph.isTest) "uitest-landmarks" else "landmarks", Context.MODE_PRIVATE)
    if (mark) prefs.edit().putBoolean(key, true).apply()
    return prefs.getBoolean(key, false)
}

/**
 * This day (Figma: white, corners 28): the ribbon on a milestone day; "This day"; the count (Display Medium) with its
 * words, or the state (28 Medium); the wavy bar toward the goal; the logging buttons (52 high) or a checklist's steps;
 * the note behind a divider. The day's logs follow below the card.
 */
@Composable
private fun DayActivity(habit: Habit, day: Int, editable: Boolean, started: Boolean, rev: Int, store: HabitStore, nav: DayNav) {
    val c = appColors
    val context = LocalContext.current
    val today = store.today()
    val ruled = store.rule(habit, day)
    val running = day == today && store.timers.containsKey(habit.id)
    val tick = rememberTicker(running, store.clock)
    val status = remember(rev, day, store.timers, store.skips, store.pauses) { DayStatus.make(habit, day, store) }
    val logs = remember(rev, day) { if (showsLogs(ruled, habit, day, store)) store.dayLogs(habit, day) else emptyList() }
    val actions = dayActions(habit, ruled, day, editable, logs.isNotEmpty(), store, nav)
    val skipped = store.isSkipped(habit, day)
    val paused = store.isPaused(habit, day)
    val future = day > today
    val planned = store.rules.isDue(habit, day, countingSkips = false) || !ruled.frequency.isDayBased || ruled.frequency.isFlexible
    val showsBar = started && !skipped && !paused && planned && !ruled.atMost && ruled.kind != HabitKind.Quit && ruled.kind != HabitKind.Task &&
        !(ruled.kind == HabitKind.Check && !store.rules.countsUp(habit, day) && ruled.frequency.isDayBased) &&
        !(ruled.kind == HabitKind.Check && ruled.frequency.isFlexible)
    val reached = remember(rev, day) { reachedToday(habit, day, store) }
    var popup by remember { mutableStateOf<Reached?>(null) }
    // A landmark reached here: its pop-up rises at once, once (Figma 14.1).
    LaunchedEffect(reached?.value) {
        val r = reached ?: return@LaunchedEffect
        val key = "${habit.id}|${r.value}|$day"
        if (r.landmark && !landmarkSeen(context, key)) { landmarkSeen(context, key, mark = true); popup = r }
    }

    Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(28.dp)).background(c.surface).padding(start = 20.dp, end = 20.dp, top = 18.dp, bottom = 4.dp)) {
        if (reached != null) {
            MilestoneRibbon(milestoneRowTitle(reached.value, reached.unit) + " · reached today", habit.color, "${habit.id}|${reached.value}")
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
            WavyProgress((progress / goal).toFloat(), c.habit(habit.color), c.habit(habit.color).copy(alpha = 0.22f), Modifier.fillMaxWidth().height(10.dp))
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
        // A checklist's steps: checkboxes in the habit's colour; a ticked step crossed out (Figma 8–8.2).
        if (ruled.kind == HabitKind.Checklist && started) {
            val locked = !editable || skipped || paused
            Spacer(Modifier.height(4.dp))
            ruled.steps.forEachIndexed { i, step ->
                val done = remember(rev, day) { store.isStepDone(step, ruled, day) }
                StepCheck(step.name, done, habit, !locked, "day-step-$i") { store.toggleStep(step, ruled, day, source = EntrySource.DAY_SHEET) }
            }
        }
        Spacer(Modifier.height(16.dp))
        HorizontalDivider(color = if (c.dark) c.tonal else DividerLight)
        val note = store.note(habit, day)
        Row(Modifier.fillMaxWidth().clickable(enabled = editable || note != null || future) { nav.note(habit, day) }
            .padding(vertical = if (note == null) 14.dp else 12.dp)
            .semantics { testTag = if (note == null) "day-add-note" else "day-edit-note" }, verticalAlignment = Alignment.CenterVertically) {
            Icon(Icons.AutoMirrored.Outlined.StickyNote2, null, tint = c.secondary)
            Spacer(Modifier.width(16.dp))
            Column(Modifier.weight(1f), verticalArrangement = Arrangement.spacedBy(2.dp)) {
                if (note != null) {
                    Text("Note", style = AppType.labelMedium, color = c.secondary)
                    Text(note, style = AppType.bodyMedium, color = c.ink, maxLines = 2, overflow = TextOverflow.Ellipsis)
                } else Text("Add a note…", style = AppType.bodyMedium, color = c.secondary)
            }
            Spacer(Modifier.width(16.dp))
            Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = c.secondary)
        }
    }
    if (logs.isNotEmpty()) {
        val shown = if (logs.size <= 3) logs else logs.take(2)
        val rows = shown.size + if (logs.size > 3) 1 else 0
        SectionList(logsTitle(ruled, day, today)) {
            shown.forEachIndexed { i, e -> LogRow(e, ruled, segmentShape(i, rows), store, nav) }
            if (logs.size > 3) Row(Modifier.fillMaxWidth().clip(segmentShape(rows - 1, rows)).background(c.surface).clickable { nav.allLogs(habit, day) }
                .heightIn(min = 56.dp).padding(start = 16.dp, end = 12.dp).semantics { testTag = "day-all-logs" }, verticalAlignment = Alignment.CenterVertically) {
                Text("All " + logCount(logs.size, ruled), Modifier.weight(1f), style = AppType.bodyLarge, color = c.ink)
                Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = c.secondary)
            }
        }
    }
    popup?.let { r ->
        val next = r.next?.let { n -> Triple("$n", "Next · ${n - r.value} to go · now ${r.value}", r.value.toFloat() / n) }
        LandmarkPopup("${r.value}", milestoneRowTitle(r.value, r.unit), "${habit.name} · reached today", habit.color, next,
            onClose = { popup = null }, onAll = { popup = null; nav.allMilestones(habit) })
    }
}

/** A logging button (Figma: 52 high, corners 26, Title Medium): ink when it's what the goal asks, else the soft grey. */
@Composable
private fun DayButton(a: DayAction, modifier: Modifier) {
    val c = appColors
    val bg = when { !a.enabled -> c.ink.copy(alpha = 0.12f); a.prominent -> c.ink; else -> c.soft }
    val fg = when { !a.enabled -> c.ink.copy(alpha = 0.38f); a.prominent -> c.onInk; else -> c.ink }
    Box(modifier.height(52.dp).clip(RoundedCornerShape(26.dp)).background(bg)
        .clickable(enabled = a.enabled, role = Role.Button, onClick = a.run)
        .semantics { testTag = a.tag; a.spoken?.let { contentDescription = it } }.padding(horizontal = 12.dp),
        contentAlignment = Alignment.Center) {
        Text(a.title, style = AppType.titleMedium, color = fg, maxLines = 1, overflow = TextOverflow.Ellipsis)
    }
}

/** One step: a square checkbox in the habit's colour, the name crossed out once ticked (Figma 8). 48 to tap. */
@Composable
fun StepCheck(name: String, done: Boolean, habit: Habit, enabled: Boolean, tag: String, strike: Boolean = true, onToggle: () -> Unit) {
    val c = appColors
    Row(Modifier.fillMaxWidth().heightIn(min = 48.dp).clip(RoundedCornerShape(8.dp)).clickable(enabled = enabled, role = Role.Checkbox, onClick = onToggle)
        .semantics { stateDescription = if (done) "Done" else "Not done"; testTag = tag }, verticalAlignment = Alignment.CenterVertically) {
        Box(Modifier.size(24.dp), contentAlignment = Alignment.Center) {
            Box(Modifier.size(18.dp).clip(RoundedCornerShape(2.dp)).background(if (done) c.habit(habit.color) else Color.Transparent)
                .let { if (done) it else it.border(2.dp, c.secondary, RoundedCornerShape(2.dp)) }, contentAlignment = Alignment.Center) {
                if (done) Icon(Icons.Rounded.Check, null, Modifier.size(16.dp), tint = Color.White)
            }
        }
        Spacer(Modifier.width(16.dp))
        Text(name, style = AppType.bodyLarge.copy(textDecoration = if (done && strike) TextDecoration.LineThrough else null),
            color = if (done && strike) c.secondary else if (enabled) c.ink else c.secondary, maxLines = 2, overflow = TextOverflow.Ellipsis)
    }
}

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

/** One log (Figma: 56 high): what it is, its time, ›; a check has its own Undo instead (U19: checks correct here). */
@Composable
private fun LogRow(entry: Entry, habit: Habit, shape: Shape, store: HabitStore, nav: DayNav) {
    val c = appColors
    val opens = entry.opensRecord(habit)
    Row(Modifier.fillMaxWidth().clip(shape).background(c.surface).let { if (opens) it.clickable { nav.log(habit, entry) } else it }
        .heightIn(min = 56.dp).padding(start = 16.dp, end = if (opens) 12.dp else 4.dp).semantics { testTag = "log-${entry.id}" },
        verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(8.dp)) {
        Text(entry.description(habit), Modifier.weight(1f), style = AppType.bodyLarge, color = c.ink, maxLines = 1)
        Text(clockText(entry), style = AppType.bodyMedium.copy(fontFeatureSettings = "tnum"), color = c.secondary)
        if (opens) Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = c.secondary)
        else TextButton({ store.undoEntry(entry.id) }, Modifier.semantics { contentDescription = entry.undoLabel(habit) + " at " + clockText(entry) }) {
            Text("Undo", style = AppType.labelLarge, color = c.ink)
        }
    }
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
private fun dayActions(habit: Habit, ruled: Habit, day: Int, editable: Boolean, hasLogs: Boolean, store: HabitStore, nav: DayNav): List<DayAction> {
    if (!editable) return emptyList()
    val today = store.today()
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
            listOf(DayAction("Add a check", ask, !skipped, tag = "day-add-one") { store.addProgress(habit, 1.0, day, source = src) })
        } else {
            val done = store.rules.isDayMet(ruled, day)
            listOf(DayAction(if (done) "Undo done" else "Mark done", !done && ask, !skipped, tag = "day-done") { store.setDayDone(!done, habit, day) })
        }
        HabitKind.Checklist -> emptyList()
        is HabitKind.Amount -> {
            val step = ruled.quickIncrement
            if (step == null) listOf(DayAction("Log amount", ask, !skipped, tag = "day-add-entry", run = manual))
            else listOf(
                DayAction("+" + Format.amount(step), ask, !skipped, "Add " + HabitCopy.amount(step, k.unit), "day-add-step") { store.increment(habit, day, src) },
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
        TextButton({
            picker.selectedDateMillis?.let { store.reschedule(habit, day, Instant.ofEpochMilli(it).atZone(ZoneOffset.UTC).toLocalDate().toEpochDay().toInt()) }
            onMoved()
        }) { Text("Move", color = c.ink) }
    }, dismissButton = { TextButton(onDismiss) { Text("Cancel", color = c.ink) } }) {
        DatePicker(picker, title = { Text("Another day", Modifier.padding(start = 24.dp, top = 16.dp)) })
    }
}
