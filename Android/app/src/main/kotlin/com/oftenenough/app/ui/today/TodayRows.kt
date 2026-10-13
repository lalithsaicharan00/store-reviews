package com.oftenenough.app.ui.today

import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.combinedClickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.Undo
import androidx.compose.material.icons.rounded.Add
import androidx.compose.material.icons.rounded.Check
import androidx.compose.material.icons.rounded.EditNote
import androidx.compose.material.icons.rounded.ExpandLess
import androidx.compose.material.icons.rounded.ExpandMore
import androidx.compose.material.icons.rounded.Pause
import androidx.compose.material.icons.rounded.PlayArrow
import androidx.compose.material.icons.rounded.Replay
import androidx.compose.material.icons.rounded.SkipNext
import androidx.compose.material3.AssistChip
import androidx.compose.material3.AssistChipDefaults
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.State
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableLongStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.drawBehind
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Shape
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Entry
import com.oftenenough.app.data.Format
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.QuitRun
import com.oftenenough.app.data.ReminderTime
import com.oftenenough.app.data.Step
import com.oftenenough.app.data.goalLine
import com.oftenenough.app.data.rowLine
import com.oftenenough.app.data.undoLabel
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.RoundActionButton
import com.oftenenough.app.ui.components.StreakLabel
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.delay

/** What Today asks of the screens it opens. */
interface TodayActions {
    fun openDay(habit: Habit, day: Int)
    fun addLog(habit: Habit, day: Int)
    fun writeNote(habit: Habit?, day: Int)
    fun openTimer(habit: Habit)
    fun editHabit(habit: Habit)
    fun openHabitPage(habit: Habit)
    fun pause(habit: Habit)
    fun feedback(done: Boolean)
}

/**
 * A clock that ticks once a second only while [running] (Rulebook S3): anchored on whole seconds, so every clock on screen
 * ticks together, and only the composable that reads it redraws.
 */
@Composable
fun rememberTicker(running: Boolean, clock: () -> Long): State<Long> {
    val now = remember { mutableLongStateOf(clock()) }
    LaunchedEffect(running) {
        if (!running) return@LaunchedEffect
        while (true) {
            val t = clock()
            now.longValue = t
            delay(1000 - t % 1000)
        }
    }
    return now
}

/** One row's numbers, worked out once per change of its habit's logs, the day or a timer (S5), never per frame. */
private class RowModel(
    val progress: Double, val goal: Double, val done: Boolean, val streak: Int, val line: String, val ticked: Boolean,
    val countsUp: Boolean,
)

private fun rowModel(store: HabitStore, habit: Habit, day: Int, slot: String?, time: ReminderTime?, now: Long): RowModel {
    val rules = store.rules
    val progress = rules.progress(habit, day, now)
    val goal = rules.goal(store.rule(habit, day))
    val done = slot?.let { store.isSlotDone(habit, it, day) } ?: (rules.isDone(habit, day) && !habit.atMost)
    val streak = store.streak(habit, day)
    val running = store.timers.containsKey(habit.id) && day == store.today()
    val line = store.rowLine(habit, day, slot, time, progress, goal, running)
    val ticked = slot?.let { store.isSlotDone(habit, it, day) } ?: (if (habit.kind == HabitKind.Task) done else store.isTicked(habit, day))
    return RowModel(progress, goal, done, streak, line, ticked, rules.countsUp(habit, day))
}

@OptIn(ExperimentalFoundationApi::class)
@Composable
fun HabitRow(
    habit: Habit, day: Int, today: Int, slot: String?, time: ReminderTime?, shape: Shape, store: HabitStore,
    layout: TodayLayout, actions: TodayActions, stepsOpen: Boolean, onToggleSteps: () -> Unit, showStreaks: Boolean = true,
) {
    val c = appColors
    val rev = store.revision(habit.id)
    val isToday = day == today
    val running = isToday && store.timers.containsKey(habit.id)
    val tick = rememberTicker(running, store.clock)
    val model = remember(habit, day, today, rev, running, slot) { rowModel(store, habit, day, slot, time, store.clock()) }
    val fillColor = c.fill(habit.color)
    var menu by remember { mutableStateOf(false) }
    val past = day <= today

    SwipeRow(start = if (past) undoActions(habit, day, store, layout) else emptyList(),
        end = if (past) dayActions(habit, day, today, store, actions) else emptyList(), shape = shape) {
    Column(
        Modifier.fillMaxWidth().clip(shape).background(c.surface)
            .drawBehind {
                // The fill: only the draw reads the ticking clock, so a running timer redraws its fill, not the row (S3).
                val progress = if (running) store.rules.progress(habit, day, tick.value) else model.progress
                val fraction = if (habit.atMost) 0.0 else progress / maxOf(model.goal, 1.0)
                val p = fraction.coerceIn(0.0, 1.0).toFloat()
                if (p > 0f) drawRect(fillColor, size = size.copy(width = size.width * p))
            }
            .combinedClickable(onClick = { actions.openDay(habit, day) }, onLongClick = { menu = true })
            .semantics { testTag = "row-${habit.name}" }
            .padding(start = 16.dp, end = 8.dp, top = 8.dp, bottom = 8.dp),
    ) {
        Row(Modifier.heightIn(min = 56.dp), verticalAlignment = Alignment.CenterVertically) {
            HabitIcon(habit.symbol, habit.color)
            Spacer(Modifier.width(16.dp))
            Column(Modifier.weight(1f)) {
                Text(habit.name, style = MaterialTheme.typography.bodyLarge, color = c.ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
                if (running) RunningLine(store, habit, day, slot, time, model.goal, tick)
                else Text(model.line, style = MaterialTheme.typography.bodyMedium, color = c.secondary, maxLines = 1, overflow = TextOverflow.Ellipsis,
                    modifier = Modifier.semantics { testTag = "line-${habit.name}" })
            }
            if (showStreaks && model.streak > 0) { Spacer(Modifier.width(8.dp)); StreakLabel(model.streak, store.rule(habit, day).frequency.streakUnit) }
            Spacer(Modifier.width(4.dp))
            RowButton(habit, day, isToday, slot, model, store, layout, actions, stepsOpen, onToggleSteps)
        }
        AfterLog(habit, day, store, layout, actions)
        RowMenu(menu, { menu = false }, habit, day, store, layout, actions)
    }
    }
}

/** Swipe right: Undo, naming what it takes back, when the day has a log (U14). */
private fun undoActions(habit: Habit, day: Int, store: HabitStore, layout: TodayLayout): List<SwipeAction> {
    val last = store.entries(habit.id, day).lastOrNull() ?: return emptyList()
    return listOf(SwipeAction(last.undoLabel(store.rule(habit, day)), Icons.AutoMirrored.Rounded.Undo, "row-swipe-undo") {
        layout.hold(); store.undoEntry(last.id)
    })
}

/** Swipe left: Skip (or Undo skip) at the edge, then Note (U14). */
private fun dayActions(habit: Habit, day: Int, today: Int, store: HabitStore, actions: TodayActions): List<SwipeAction> {
    val list = ArrayList<SwipeAction>(2)
    if (habit.kind != HabitKind.Task) {
        if (store.isSkipped(habit, day)) list += SwipeAction("Undo skip", Icons.AutoMirrored.Rounded.Undo, "row-swipe-skip") { store.setSkipped(habit, day, false) }
        else if (store.rules.canSkip(store.rule(habit, day)) && !store.isPaused(habit, day))
            list += SwipeAction(if (day == today) "Skip" else "Skip this day", Icons.Rounded.SkipNext, "row-swipe-skip") { store.setSkipped(habit, day, true) }
    }
    list += SwipeAction(if (store.note(habit, day) == null) "Note" else "Edit note", Icons.Rounded.EditNote, "row-swipe-note") { actions.writeNote(habit, day) }
    return list
}

@Composable
private fun RunningLine(store: HabitStore, habit: Habit, day: Int, slot: String?, time: ReminderTime?, goal: Double, tick: State<Long>) {
    val progress = store.rules.progress(habit, day, tick.value)
    Text(store.rowLine(habit, day, slot, time, progress, goal, true), style = MaterialTheme.typography.bodyMedium.copy(fontFeatureSettings = "tnum"),
        color = appColors.ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
}

@Composable
private fun RowButton(
    habit: Habit, day: Int, isToday: Boolean, slot: String?, model: RowModel, store: HabitStore, layout: TodayLayout,
    actions: TodayActions, stepsOpen: Boolean, onToggleSteps: () -> Unit,
) {
    val future = day > store.today()
    fun log(change: () -> Unit) { layout.hold(); change() }
    when (val k = habit.kind) {
        HabitKind.Checklist -> RoundActionButton(if (stepsOpen) Icons.Rounded.ExpandLess else Icons.Rounded.ExpandMore, model.done, habit.color,
            if (stepsOpen) "Hide ${habit.name} steps" else "Show ${habit.name} steps", onToggleSteps)
        HabitKind.Check -> if (slot == null && model.countsUp) {
            // Ticked several times a day, or N a week: still a ✓; each tap adds one and never takes one back (U14).
            RoundActionButton(Icons.Rounded.Check, model.done, habit.color, "Add 1 to ${habit.name}", enabled = !future,
                onClick = { log { store.addProgress(habit, 1.0, day) } })
        } else {
            RoundActionButton(Icons.Rounded.Check, model.ticked, habit.color, if (model.ticked) "Undo ${habit.name}" else "Mark ${habit.name} done",
                enabled = !future, onClick = { log { if (slot != null) store.toggleSlot(habit, slot, day) else store.toggleCheck(habit, day) } })
        }
        HabitKind.Task -> RoundActionButton(Icons.Rounded.Check, model.ticked, habit.color, if (model.ticked) "Undo ${habit.name}" else "Mark ${habit.name} done",
            enabled = !future, onClick = { log { store.toggleCheck(habit, day) } })
        is HabitKind.Amount -> {
            val step = habit.quickIncrement
            if (step != null) RoundActionButton(Icons.Rounded.Add, model.done, habit.color, "Add ${com.oftenenough.app.data.HabitCopy.amount(step, k.unit)} to ${habit.name}",
                text = "+" + Format.amount(step), enabled = !future, onClick = { log { store.increment(habit, day) } })
            else RoundActionButton(Icons.Rounded.Add, model.done, habit.color, "Add an amount to ${habit.name}", enabled = !future,
                onClick = { actions.addLog(habit, day) })
        }
        HabitKind.Duration -> {
            val running = store.timers.containsKey(habit.id)
            RoundActionButton(if (running) Icons.Rounded.Pause else Icons.Rounded.PlayArrow, model.done && !running, habit.color,
                if (running) "Stop ${habit.name} timer" else "Start ${habit.name} timer", enabled = isToday,
                onClick = {
                    if (!running) { store.toggleTimer(habit, slot); actions.openTimer(habit) } else log { store.toggleTimer(habit, slot) }
                })
        }
        HabitKind.Quit -> {}
    }
}

/** After a log: Undo (naming what it takes back) and Add note, under the row (U14). */
@Composable
private fun AfterLog(habit: Habit, day: Int, store: HabitStore, layout: TodayLayout, actions: TodayActions) {
    val offer: Entry = store.undoOffer?.takeIf { it.habitId == habit.id && it.day == day } ?: return
    val hasNote = store.note(habit, day) != null
    Row(Modifier.padding(start = 56.dp, bottom = 4.dp).fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
        AssistChip(onClick = { layout.hold(); store.undoEntry(offer.id) },
            label = { Text(offer.undoLabel(store.rule(habit, day)), maxLines = 1, overflow = TextOverflow.Ellipsis) },
            leadingIcon = { Icon(Icons.AutoMirrored.Rounded.Undo, null, Modifier.size(18.dp)) },
            colors = AssistChipDefaults.assistChipColors(containerColor = appColors.tonal, labelColor = appColors.ink, leadingIconContentColor = appColors.ink),
            border = null, modifier = Modifier.weight(1f, fill = false).semantics { testTag = "undo-${habit.name}" })
        AssistChip(onClick = { actions.writeNote(habit, day) }, label = { Text(if (hasNote) "Edit note" else "Add note", maxLines = 1) },
            leadingIcon = { Icon(Icons.Rounded.EditNote, null, Modifier.size(18.dp)) },
            colors = AssistChipDefaults.assistChipColors(containerColor = appColors.tonal, labelColor = appColors.ink, leadingIconContentColor = appColors.ink),
            border = null)
    }
}

/** Touch and hold: the same actions as Day details (U14). No Delete: it lives in Day details' ⋮ menu, asking first. */
@Composable
private fun RowMenu(open: Boolean, onDismiss: () -> Unit, habit: Habit, day: Int, store: HabitStore, layout: TodayLayout, actions: TodayActions) {
    DropdownMenu(open, onDismiss) {
        val today = store.today()
        @Composable fun item(text: String, action: () -> Unit) = DropdownMenuItem(text = { Text(text) }, onClick = { onDismiss(); action() })
        if (habit.kind != HabitKind.Task) item("Open habit page") { actions.openHabitPage(habit) }
        item(if (habit.kind == HabitKind.Task) "Edit task" else "Edit habit") { actions.editHabit(habit) }
        if (day <= today) {
            if (habit.kind == HabitKind.Quit) item("Record a slip…") { actions.addLog(habit, day) }
            else if (habit.kind != HabitKind.Task && habit.kind != HabitKind.Checklist) item(addTitle(habit, store, day) + "…") { actions.addLog(habit, day) }
            item(if (store.note(habit, day) == null) "Add note" else "Edit note") { actions.writeNote(habit, day) }
            if (habit.kind != HabitKind.Task && habit.kind != HabitKind.Quit) {
                if (store.isSkipped(habit, day)) item("Undo skip") { store.setSkipped(habit, day, false) }
                else if (store.rules.canSkip(store.rule(habit, day)) && !store.isPaused(habit, day)) item(if (day == today) "Skip today" else "Skip this day") { store.setSkipped(habit, day, true) }
            }
            if (store.rules.canPause(habit)) {
                if (store.isPaused(habit, today)) item("Resume habit") { store.resume(habit) } else item("Pause…") { actions.pause(habit) }
            }
            store.entries(habit.id, day).lastOrNull()?.let { last -> item(last.undoLabel(store.rule(habit, day))) { layout.hold(); store.undoEntry(last.id) } }
        }
    }
}

/** The Add screen's name for this habit (U21): "Add log", "Add a check", "Mark a day done", "Tick steps", "Add slip". */
fun addTitle(habit: Habit, store: HabitStore, day: Int): String {
    val r = store.rule(habit, day)
    return when (r.kind) {
        HabitKind.Check -> if (store.rules.countsUp(habit, day)) "Add a check" else "Mark a day done"
        HabitKind.Checklist -> "Tick steps"
        HabitKind.Quit -> "Add slip"
        HabitKind.Task -> "Mark a day done"
        else -> "Add log"
    }
}

/** One step of a checklist, under its row on Today. */
@Composable
fun StepRow(step: Step, habit: Habit, day: Int, shape: Shape, store: HabitStore, layout: TodayLayout) {
    val rev = store.revision(habit.id)
    val done = remember(rev, day) { store.isStepDone(step, habit, day) }
    Row(
        Modifier.fillMaxWidth().clip(shape).background(appColors.surface).heightIn(min = 52.dp).padding(start = 72.dp, end = 8.dp),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Text(step.name, Modifier.weight(1f), style = MaterialTheme.typography.bodyMedium, color = if (done) appColors.secondary else appColors.ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
        RoundActionButton(Icons.Rounded.Check, done, habit.color, if (done) "Undo ${step.name}" else "Mark ${step.name} done", size = 36.dp,
            enabled = day <= store.today(), onClick = { layout.hold(); store.toggleStep(step, habit, day) })
    }
}

/** A quit habit: its best run, and the live count where other rows have their button (S3: only the count ticks). */
@OptIn(ExperimentalFoundationApi::class)
@Composable
fun QuitRow(habit: Habit, shape: Shape, store: HabitStore, layout: TodayLayout, actions: TodayActions, showStreaks: Boolean = true) {
    val c = appColors
    val rev = store.revision(habit.id)
    val today = store.today()
    val history = remember(habit, rev, store.pauses[habit.id]) { store.rules.quitHistory(habit, store.clock()) }
    val ongoing = history.lastOrNull()?.takeIf { it.ending == QuitRun.Ending.ONGOING }?.start
    val pastBest = history.dropLast(if (ongoing == null) 0 else 1).maxOfOrNull { it.seconds(store.clock()) } ?: 0.0
    val tick = rememberTicker(ongoing != null, store.clock)
    var menu by remember { mutableStateOf(false) }
    val paused = store.isPaused(habit, today)
    SwipeRow(start = emptyList(), end = listOfNotNull(
        if (!paused) SwipeAction("Log slip", Icons.Rounded.Replay, "row-swipe-slip") { actions.addLog(habit, today) } else null,
        SwipeAction(if (store.note(habit, today) == null) "Note" else "Edit note", Icons.Rounded.EditNote, "row-swipe-note") { actions.writeNote(habit, today) },
    ), shape = shape) {
    Column(Modifier.fillMaxWidth().clip(shape).background(c.surface)
        .combinedClickable(onClick = { actions.openDay(habit, today) }, onLongClick = { menu = true })
        .semantics { testTag = "row-${habit.name}" }
        .padding(start = 16.dp, end = 16.dp, top = 8.dp, bottom = 8.dp)) {
        Row(Modifier.heightIn(min = 56.dp), verticalAlignment = Alignment.CenterVertically) {
            HabitIcon(habit.symbol, habit.color)
            Spacer(Modifier.width(16.dp))
            Column(Modifier.weight(1f)) {
                Text(habit.name, style = MaterialTheme.typography.bodyLarge, color = c.ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
                val current = ongoing?.let { maxOf(0L, tick.value - it) / 1000.0 } ?: 0.0
                Text(if (showStreaks) "Best " + Format.days(maxOf(pastBest, current)) else (ongoing?.let { "Since " + DayWords.short(store.rules.calendarDayOf(it)) } ?: "Paused"),
                    style = MaterialTheme.typography.bodyMedium, color = c.secondary, maxLines = 1)
            }
            Text(Format.elapsed(ongoing?.let { maxOf(0L, tick.value - it) / 1000.0 } ?: 0.0),
                style = MaterialTheme.typography.bodyLarge.copy(fontWeight = FontWeight.SemiBold, fontFeatureSettings = "tnum"), color = c.ink, maxLines = 1)
        }
        RowMenu(menu, { menu = false }, habit, today, store, layout, actions)
    }
    }
}

/** The first piece of every card: name and start, folded icons, "N left", Start and the fold chevron. */
@Composable
fun PartHeader(
    title: String, subtitle: String?, habits: List<Habit>, left: Int?, isNow: Boolean, isOpen: Boolean, shape: Shape,
    onStart: (() -> Unit)?, onToggle: () -> Unit,
) {
    val c = appColors
    Row(
        Modifier.fillMaxWidth().clip(shape).background(c.surface).combinedClickableSafe(onToggle)
            .semantics { testTag = "header-$title" }
            .heightIn(min = 64.dp).padding(start = 16.dp, end = 8.dp, top = 8.dp, bottom = 8.dp),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Column(Modifier.weight(1f, fill = isOpen)) {
            Text(title, style = MaterialTheme.typography.titleMedium, color = c.ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
            if (subtitle != null) Text(subtitle, style = MaterialTheme.typography.bodySmall.copy(fontSize = 12.sp), color = c.secondary, maxLines = 1)
        }
        if (!isOpen) {
            Spacer(Modifier.width(12.dp))
            FoldedIcons(habits, Modifier.weight(1f))
        }
        if (left != null) {
            Spacer(Modifier.width(8.dp))
            com.oftenenough.app.ui.components.Badge(if (left == 0) "All done" else "$left left")
        }
        if (onStart != null && (isOpen || isNow)) {
            Spacer(Modifier.width(8.dp))
            val colors = if (isNow) androidx.compose.material3.ButtonDefaults.buttonColors(containerColor = c.ink, contentColor = c.onInk)
                else androidx.compose.material3.ButtonDefaults.buttonColors(containerColor = c.tonal, contentColor = c.ink)
            androidx.compose.material3.Button(onStart, colors = colors, contentPadding = androidx.compose.foundation.layout.PaddingValues(start = 12.dp, end = 16.dp),
                modifier = Modifier.heightIn(min = 40.dp).semantics { contentDescription = "Start $title" }) {
                Icon(Icons.Rounded.PlayArrow, null, Modifier.size(20.dp))
                if (isOpen) { Spacer(Modifier.width(4.dp)); Text("Start", style = MaterialTheme.typography.labelLarge.copy(fontSize = 15.sp)) }
            }
        }
        IconButton(onToggle) {
            Icon(if (isOpen) Icons.Rounded.ExpandLess else Icons.Rounded.ExpandMore, if (isOpen) "Fold $title" else "Open $title", tint = c.ink)
        }
    }
}

private fun Modifier.combinedClickableSafe(onClick: () -> Unit): Modifier = this.clickable(onClick = onClick)

/** Folded: the habit icons as an overlapping stack (28, a white ring, 6 overlapping), ending in "+N". */
@Composable
private fun FoldedIcons(habits: List<Habit>, modifier: Modifier = Modifier) {
    val c = appColors
    val shown = habits.take(3)
    val more = habits.size - shown.size
    Row(modifier, verticalAlignment = Alignment.CenterVertically) {
        shown.forEachIndexed { i, h ->
            Box(Modifier.offset(x = (-6 * i).dp).size(32.dp).clip(CircleShape).background(c.surface), contentAlignment = Alignment.Center) {
                HabitIcon(h.symbol, h.color, size = 28.dp)
            }
        }
        if (more > 0) {
            Box(Modifier.offset(x = (-6 * shown.size).dp).size(32.dp).clip(CircleShape).background(c.surface), contentAlignment = Alignment.Center) {
                Box(Modifier.size(28.dp).clip(CircleShape).background(c.tonal), contentAlignment = Alignment.Center) {
                    Text("+$more", style = MaterialTheme.typography.labelMedium, color = c.ink)
                }
            }
        }
    }
}

/** A paused habit, in the folded Paused card at the bottom. */
@Composable
fun PausedRow(habit: Habit, shape: Shape, store: HabitStore, actions: TodayActions) {
    val c = appColors
    val p = store.pause(habit, store.today())
    Row(Modifier.fillMaxWidth().clip(shape).background(c.surface).heightIn(min = 72.dp)
        .combinedClickableSafe { actions.openDay(habit, store.today()) }.padding(horizontal = 16.dp),
        verticalAlignment = Alignment.CenterVertically) {
        HabitIcon(habit.symbol, habit.color)
        Spacer(Modifier.width(16.dp))
        Column(Modifier.weight(1f)) {
            Text(habit.name, style = MaterialTheme.typography.bodyLarge, color = c.secondary, maxLines = 1, overflow = TextOverflow.Ellipsis)
            Text(p?.let(DayWords::paused) ?: "Paused", style = MaterialTheme.typography.bodyMedium, color = c.secondary, maxLines = 1)
        }
        androidx.compose.material3.TextButton({ store.resume(habit) }) { Text("Resume", color = c.ink) }
    }
}

@Suppress("unused") private val unusedBorder = Modifier.border(0.dp, Color.Transparent, RoundedCornerShape(0.dp))
@Suppress("unused") private fun unusedGoal(h: Habit) = goalLine(h, 0.0, 0.0)
