package com.oftenenough.app.ui.today

import com.oftenenough.app.ui.components.HabitRowSwipe
import com.oftenenough.app.ui.components.SwipeAction
import com.oftenenough.app.ui.components.HabitRowLayout
import com.oftenenough.app.ui.components.HabitRowLine
import com.oftenenough.app.ui.components.HabitRowStreak
import com.oftenenough.app.ui.components.HabitRowAfterLogButton
import com.oftenenough.app.ui.components.StepRow
import com.oftenenough.app.ui.components.StepRowBlock
import androidx.compose.material3.MaterialTheme
import com.oftenenough.app.ui.components.AppMenuItem
import com.oftenenough.app.ui.components.AppMenu
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.theme.AppType

import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Icon
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
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Shape
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.AfterLog
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Format
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitCopy
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.QuitRun
import com.oftenenough.app.data.ReminderTime
import com.oftenenough.app.data.rowLine
import com.oftenenough.app.data.undoLabel
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.AppFilledIconButton
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
    /** Arrange Today, with [habit] lifted (a row's menu, Figma 1.4; the new habit's Move, 1.6). */
    fun arrange(habit: Habit?)
    /** A milestone's band tapped, or its See: that milestone's pop-up, asked for (Figma R.1, A.1). */
    fun seeMilestone(habit: Habit) {}
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
    val countsUp: Boolean, val skipped: Boolean,
)

private fun rowModel(store: HabitStore, habit: Habit, day: Int, slot: String?, time: ReminderTime?, now: Long, streaks: Boolean): RowModel {
    val rules = store.rules
    val today = store.today()
    val progress = rules.progress(habit, day, now)
    val goal = rules.goal(store.rule(habit, day))
    val done = slot?.let { store.isSlotDone(habit, it, day) } ?: (rules.isDone(habit, day) && !habit.atMost)
    val streak = if (habit.kind == HabitKind.Task) 0 else store.streak(habit, day)
    val running = store.timers.containsKey(habit.id) && day == today
    var line = store.rowLine(habit, day, slot, time, progress, goal, running)
    // A later day plans, so its line is the goal alone: "8 glasses", "20 min" (Figma 4.3).
    if (day > today) line = line.replace(Regex("^[0-9][0-9,.:]*/"), "")
    // A milestone keeps the row's own line; its band says it, below (Figma R.1, decided 17 Oct 2026).
    // A day with a note says so (Figma 7.18).
    if (day <= today && store.note(habit, day) != null) line += " · Note"
    val ticked = slot?.let { store.isSlotDone(habit, it, day) } ?: (if (habit.kind == HabitKind.Task) done else store.isTicked(habit, day))
    return RowModel(progress, goal, done, streak, line, ticked, rules.countsUp(habit, day), store.isSkipped(habit, day))
}

/** Whether Today shows streaks (Progress's view option, shared with Today; on unless set off). */
fun HabitStore.showsStreaks(): Boolean = setting("progress.showStreaks") != "false"

/**
 * One habit's row on Today (Figma 1350:2, 1.2–1.13): the icon, the name (two lines at most, the row grows) over one
 * line, the 🔥 streak 20 dp before the round button, the progress fill behind; Undo · Note under it right after it's
 * logged from Today. Tap the row for Day details, the button to act, touch and hold for the menu; swipe left to skip,
 * right for a note.
 */
@OptIn(ExperimentalFoundationApi::class)
@Composable
fun HabitRow(
    habit: Habit, day: Int, today: Int, slot: String?, time: ReminderTime?, shape: Shape, store: HabitStore,
    layout: TodayLayout, actions: TodayActions, stepsOpen: Boolean, onToggleSteps: () -> Unit, lit: Boolean = false,
    haptics: Boolean = true,
) {
    val c = appColors
    val rev = store.revision(habit.id)
    val isToday = day == today
    val future = day > today
    val running = isToday && store.timers.containsKey(habit.id)
    val tick = rememberTicker(running, store.clock)
    val streaks = store.showsStreaks()
    val note = store.note(habit, day) != null
    val model = remember(habit, day, today, rev, running, slot, note, streaks) { rowModel(store, habit, day, slot, time, store.clock(), streaks) }
    val offer = store.afterLog?.takeIf { it.habitId == habit.id && it.day == day && !running }
    var menu by remember { mutableStateOf(false) }
    val moment = rememberRowMilestone(habit, isToday, rev, store)

    val trailing = rowButton(habit, day, isToday, future, slot, model, running)
    // An amount typed each time has no step to add: its button is the word Log (Figma's Show log button).
    val typed = habit.kind is HabitKind.Amount && habit.quickIncrement == null

    HabitRowSwipe(left = skipAction(habit, day, today, model, running, store, layout), right = noteAction(habit, day, today, store, actions), shape = shape, haptics = haptics) {
        HabitRowLayout(
            habit.symbol, habit.color, habit.name, shape,
            onClick = { actions.openDay(habit, day) }, onLongClick = { menu = true },
            modifier = Modifier.semantics { testTag = "row-${habit.name}" },
            // A later day plans, and a limit never fills (A41). Only the draw reads the ticking clock (S3).
            progress = if (future || habit.atMost) null else { {
                val progress = if (running) store.rules.progress(habit, day, tick.value) else model.progress
                (progress / maxOf(model.goal, 1e-9)).toFloat()
            } },
            pressed = menu, lit = lit,
            line = {
                if (running) RunningLine(store, habit, day, slot, time, model.goal, tick)
                else HabitRowLine(model.line, Modifier.semantics { testTag = "line-${habit.name}" })
            },
            streak = if (streaks && model.streak > 0 && !future) { { HabitRowStreak(model.streak, store.rule(habit, day).frequency.streakUnit, roll = moment.rolling) } } else null,
            action = if (trailing && !typed) { {
                Box(if (moment.full) Modifier.milestoneBurst(moment.t, c.habit(habit.color)) else Modifier) {
                    RowButton(habit, day, isToday, slot, model, store, layout, actions, stepsOpen, onToggleSteps, running)
                }
            } } else null,
            trailing = when {
                trailing && typed -> { { AppButton("Log", { actions.addLog(habit, day) }, style = ButtonStyle.Tonal, tag = "log-${habit.name}") } }
                future && habit.kind == HabitKind.Task -> { { DoneTodayButton(habit, store, layout) } }
                else -> null
            },
            below = offer?.let { o -> { AfterLogButtons(o, habit, day, store, layout, actions, note) } },
            band = moment.band?.let { b -> { MilestoneBand(moment.text, habit.color, b.see, moment.t, early = !moment.full) { actions.seeMilestone(habit) } } },
            menu = { RowMenu(menu, { menu = false }, habit, day, store, actions, layout) },
        )
    }
}

/** Whether a row has its round button: never on a later day or a skipped day (Figma 4.3, 7.10). */
private fun rowButton(habit: Habit, day: Int, isToday: Boolean, future: Boolean, slot: String?, model: RowModel, running: Boolean): Boolean =
    !future && !model.skipped && habit.kind != HabitKind.Quit

/** Swipe left (Figma 7.1–7.16, 7.24): Skip on a day it can be skipped, Undo skip on a skipped day, nothing otherwise. */
private fun skipAction(habit: Habit, day: Int, today: Int, model: RowModel, running: Boolean, store: HabitStore, layout: TodayLayout): SwipeAction? {
    if (habit.kind == HabitKind.Task) return null
    // A skip holds Today still like any log (U4): the row stays where it is, with Undo · Note, until the pause.
    if (model.skipped) return SwipeAction("Undo", "Undo skip", Symbols.Undo, "row-swipe-undo-skip") { layout.hold(); store.setSkipped(habit, day, false) }
    // Nothing to skip: a week or month goal, a limit, a day already done or a timer running (Figma 7.14, 7.15).
    if (habit.atMost || running || model.done || !store.rules.canSkip(store.rule(habit, day)) || store.isPaused(habit, day)) return null
    val word = if (day == today) "Skip today" else "Skip this day"
    return SwipeAction("Skip", word, Symbols.Redo, "row-swipe-skip") { layout.hold(); store.setSkipped(habit, day, true, offer = true) }
}

/** Swipe right (Figma 7.17–7.24): Note, on every row; opens the note sheet, where nothing is saved until Save. */
private fun noteAction(habit: Habit, day: Int, today: Int, store: HabitStore, actions: TodayActions): SwipeAction {
    val has = store.note(habit, day) != null
    return SwipeAction("Note", if (has) "Edit note" else "Add note", if (has) Symbols.EditNote else Symbols.NoteAdd, "row-swipe-note") {
        actions.writeNote(habit, day)
    }
}

@Composable
private fun RunningLine(store: HabitStore, habit: Habit, day: Int, slot: String?, time: ReminderTime?, goal: Double, tick: State<Long>) {
    val progress = store.rules.progress(habit, day, tick.value)
    HabitRowLine(runningWords(store.rowLine(habit, day, slot, time, progress, goal, true)), numbers = true)
}

/** "2:42/10 min" → "2:42 of 10 min" (Figma 1.3.1). */
private fun runningWords(line: String): String = line.replaceFirst(Regex("^([0-9:]+)/"), "$1 of ")

@Composable
private fun RowButton(
    habit: Habit, day: Int, isToday: Boolean, slot: String?, model: RowModel, store: HabitStore, layout: TodayLayout,
    actions: TodayActions, stepsOpen: Boolean, onToggleSteps: () -> Unit, running: Boolean,
) {
    fun log(change: () -> Unit) { layout.hold(); change() }
    when (val k = habit.kind) {
        HabitKind.Checklist -> AppFilledIconButton(if (stepsOpen) Symbols.ExpandLess else Symbols.ExpandMore, if (stepsOpen) "Hide ${habit.name} steps" else "Show ${habit.name} steps", onToggleSteps, done = model.done, color = habit.color)
        HabitKind.Check -> if (slot == null && model.countsUp) {
            // Ticked several times a day, or N a week: still a ✓; each tap adds one and never takes one back (U14).
            AppFilledIconButton(Symbols.Check, "Add 1 to ${habit.name}", { log { store.addProgress(habit, 1.0, day) } }, done = model.done, color = habit.color)
        } else {
            AppFilledIconButton(Symbols.Check, if (model.ticked) "Undo ${habit.name}" else "Mark ${habit.name} done", { log { if (slot != null) store.toggleSlot(habit, slot, day) else store.toggleCheck(habit, day) } }, done = model.ticked, color = habit.color)
        }
        HabitKind.Task -> AppFilledIconButton(Symbols.Check, if (model.ticked) "Undo ${habit.name}" else "Mark ${habit.name} done", { log { store.toggleCheck(habit, day) } }, done = model.ticked, color = habit.color)
        is HabitKind.Amount -> {
            // A limit's + stays plain however much is logged (Figma 1.12: never filled as if done).
            val filled = model.done && !habit.atMost
            val step = habit.quickIncrement
            if (step != null) AppFilledIconButton(Symbols.Add, "Add ${HabitCopy.amount(step, k.unit)} to ${habit.name}", { log { store.increment(habit, day) } }, done = filled, color = habit.color)
            else AppFilledIconButton(Symbols.Add, "Add an amount to ${habit.name}", { actions.addLog(habit, day) }, done = filled, color = habit.color)
        }
        HabitKind.Duration -> {
            // Past the goal the button fills, running or not (Figma 1.3.2); a limit's never does.
            val filled = !habit.atMost && (model.done || (running && store.rules.isDone(habit, day)))
            AppFilledIconButton(if (running) Symbols.Filled.Pause else Symbols.Filled.PlayArrow, if (running) "Stop ${habit.name} timer" else "Start ${habit.name} timer", {
                    if (!running) { store.toggleTimer(habit, slot); actions.openTimer(habit) } else log { store.toggleTimer(habit, slot) }
                }, done = filled, color = habit.color, enabled = isToday)
        }
        HabitKind.Quit -> {}
    }
}

/** A task planned for a later day can still be done today (Figma 4.3): "Done today", a tonal Small button, as the row's Log. */
@Composable
private fun DoneTodayButton(habit: Habit, store: HabitStore, layout: TodayLayout) =
    AppButton("Done today", { layout.hold(); store.toggleCheck(habit, store.today()) }, style = ButtonStyle.Tonal, tag = "done-today-${habit.name}")

/**
 * Undo · Note (Figma 1.2): under the row of the last thing done from Today, 12 dp below its line and lined up with the
 * name (56 dp in, placed by [HabitRowLayout]). Undo takes back exactly that log (or the skip); Note opens the day's note for this habit, "Note"
 * with ✎ once there is one. They go with the next log, another day or leaving Today (HabitStore.afterLog).
 */
@Composable
private fun AfterLogButtons(offer: AfterLog, habit: Habit, day: Int, store: HabitStore, layout: TodayLayout, actions: TodayActions, hasNote: Boolean) {
    Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
        val undoSays = when (offer) {
            is AfterLog.Skip -> "Undo skip"
            is AfterLog.Log -> offer.entry.undoLabel(store.rule(habit, day))
        }
        HabitRowAfterLogButton("Undo", Symbols.Undo, { layout.hold(); store.undo(offer) },
            Modifier.semantics { contentDescription = undoSays; testTag = "undo-${habit.name}" })
        HabitRowAfterLogButton("Note", if (hasNote) Symbols.EditNote else Symbols.Add, { actions.writeNote(habit, day) },
            Modifier.semantics { contentDescription = if (hasNote) "Edit note" else "Add note"; testTag = "note-${habit.name}" })
    }
}

/**
 * Touch and hold (Figma 1.4, 1.4.1): Edit habit, Arrange…, Pause…, Add note, then Skip today (Log a slip on a quit row),
 * each with its icon, on the menu's own surface; the held row is shaded while it's open. No Delete: it lives in Day
 * details' ⋮ menu, asking first (U14).
 */
@Composable
private fun RowMenu(open: Boolean, onDismiss: () -> Unit, habit: Habit, day: Int, store: HabitStore, actions: TodayActions, layout: TodayLayout) {
    AppMenu(open, onDismiss, Modifier.semantics { testTag = "row-menu" }) {
        val today = store.today()
        @Composable fun item(text: String, icon: ImageVector, action: () -> Unit) = AppMenuItem(text, { onDismiss(); action() }, icon = icon)
        item(if (habit.kind == HabitKind.Task) "Edit task" else "Edit habit", Symbols.Edit) { actions.editHabit(habit) }
        item("Arrange…", Symbols.SwapVert) { actions.arrange(habit) }
        if (store.rules.canPause(habit)) {
            if (store.isPaused(habit, today)) item("Resume habit", Symbols.PlayCircle) { store.resume(habit) }
            else item("Pause…", Symbols.PauseCircle) { actions.pause(habit) }
        }
        item(if (store.note(habit, day) == null) "Add note" else "Edit note", Symbols.StickyNote2) { actions.writeNote(habit, day) }
        when {
            habit.kind == HabitKind.Quit -> if (!store.isPaused(habit, today)) item("Log a slip", Symbols.AddCircle) { actions.addLog(habit, today) }
            habit.kind == HabitKind.Task -> {}
            store.isSkipped(habit, day) -> item("Undo skip", Symbols.Undo) { layout.hold(); store.setSkipped(habit, day, false) }
            store.rules.canSkip(store.rule(habit, day)) && !store.isPaused(habit, day) && !store.rules.isDone(habit, day) && !habit.atMost ->
                item(if (day == today) "Skip today" else "Skip this day", Symbols.Redo) { layout.hold(); store.setSkipped(habit, day, true, offer = true) }
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

/**
 * A checklist's steps, open in their own block under its row (Figma's Steps open; molecule 4.3, [StepRowBlock] and
 * [StepRow]): ticked steps stay in place, greyed. When the last step is ticked the steps stay through the pause, then
 * fold (TodayLayout.foldAfterHold).
 */
@Composable
fun StepsBlock(habit: Habit, day: Int, shape: Shape, store: HabitStore, layout: TodayLayout) {
    val c = appColors
    val rev = store.revision(habit.id)
    val done = remember(rev, day) { habit.steps.associate { it.id to store.isStepDone(it, habit, day) } }
    val canTick = day <= store.today()
    StepRowBlock(shape, Modifier.semantics { testTag = "steps-${habit.name}" }) {
        for (step in habit.steps) StepRow(step.name, done[step.id] == true, c.habit(habit.color), enabled = canTick, tag = "step-${step.name}", onToggle = {
            layout.hold()
            store.toggleStep(step, habit, day)
            if (store.rules.isDone(habit, day)) layout.foldAfterHold("steps-${habit.id}")
        })
    }
}

/**
 * A quit habit (Figma 1.1, 7.12–7.13): its best run (or the slip just made, "Slip at 9:40 AM"), and the live count where
 * other rows have their button (S3: only the count ticks). Swipe left logs a slip (it opens Add slip), right a note.
 */
@OptIn(ExperimentalFoundationApi::class)
@Composable
fun QuitRow(habit: Habit, shape: Shape, store: HabitStore, layout: TodayLayout, actions: TodayActions, haptics: Boolean = true) {
    val c = appColors
    val rev = store.revision(habit.id)
    val today = store.today()
    val streaks = store.showsStreaks()
    val history = remember(habit, rev, store.pauses[habit.id]) { store.rules.quitHistory(habit, store.clock()) }
    val ongoing = history.lastOrNull()?.takeIf { it.ending == QuitRun.Ending.ONGOING }?.start
    val pastBest = history.dropLast(if (ongoing == null) 0 else 1).maxOfOrNull { it.seconds(store.clock()) } ?: 0.0
    val tick = rememberTicker(ongoing != null, store.clock)
    var menu by remember { mutableStateOf(false) }
    val paused = store.isPaused(habit, today)
    val offer = store.afterLog?.takeIf { it.habitId == habit.id && it.day == today }
    val lastSlip = remember(rev, today) { store.entries(habit.id, today).lastOrNull() }
    val note = store.note(habit, today) != null
    val slip = if (!paused) SwipeAction("Slip", "Log a slip", Symbols.AddCircle, "row-swipe-slip") { actions.addLog(habit, today) } else null
    // A run that passed a length yesterday: the band, once, when the row is first seen (Figma R.9, A.1).
    val moment = rememberRowMilestone(habit, true, rev, store)
    HabitRowSwipe(left = slip, right = noteAction(habit, today, today, store, actions), shape = shape, haptics = haptics) {
        // No fill: a quit row has no goal to fill toward (A41). Its live count is where other rows have their button.
        HabitRowLayout(
            habit.symbol, habit.color, habit.name, shape,
            onClick = { actions.openDay(habit, today) }, onLongClick = { menu = true },
            modifier = Modifier.semantics { testTag = "row-${habit.name}" },
            pressed = menu,
            line = {
                val current = ongoing?.let { maxOf(0L, tick.value - it) / 1000.0 } ?: 0.0
                val line = when {
                    paused -> "Paused"
                    lastSlip != null && offer != null -> "Slip at " + DayWords.clock(lastSlip.createdAt)
                    streaks -> "Best " + Format.days(maxOf(pastBest, current))
                    else -> ongoing?.let { "Since " + DayWords.short(store.rules.calendarDayOf(it)) } ?: "Paused"
                } + (if (note) " · Note" else "")
                HabitRowLine(line, Modifier.semantics { testTag = "line-${habit.name}" })
            },
            trailing = {
                Text(Format.elapsed(ongoing?.let { maxOf(0L, tick.value - it) / 1000.0 } ?: 0.0),
                    style = AppType.titleMedium.copy(fontFeatureSettings = "tnum"), color = MaterialTheme.colorScheme.onSurface, maxLines = 1)
            },
            below = offer?.let { o -> { AfterLogButtons(o, habit, today, store, layout, actions, note) } },
            band = moment.band?.let { b -> { MilestoneBand(moment.text, habit.color, b.see, moment.t, early = true) { actions.seeMilestone(habit) } } },
            menu = { RowMenu(menu, { menu = false }, habit, today, store, actions, layout) },
        )
    }
}

/**
 * The first piece of every card (Figma 1350:56): the name over "Starts 6 AM"; folded, the habits' icons overlapping;
 * the badge ("2 left", "✓ Done", "3 planned"); Start where the card is open (ink for the time of day it is now, tonal
 * otherwise); the ⌃/⌄ in a 40 dp button. Tapping anywhere on it folds or opens the card.
 */
@Composable
fun PartHeader(
    title: String, subtitle: String?, habits: List<Habit>, badge: String?, isNow: Boolean, isOpen: Boolean, shape: Shape,
    onStart: (() -> Unit)?,
    /** Habits with a milestone not yet seen: a small medal on their icon while the card is folded (Figma A.2). */
    marked: Set<String> = emptySet(),
    onToggle: () -> Unit,
) {
    val c = appColors
    Row(
        Modifier.fillMaxWidth().clip(shape).background(c.surface).clickable(onClickLabel = if (isOpen) "Fold $title" else "Open $title", onClick = onToggle)
            .semantics { testTag = "header-$title" }
            .heightIn(min = 64.dp).padding(start = 16.dp, end = 8.dp, top = 12.dp, bottom = 12.dp),
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.spacedBy(12.dp),
    ) {
        Column {
            Text(title, style = AppType.titleMedium, color = c.ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
            if (subtitle != null) Text(subtitle, style = AppType.bodySmall, color = c.secondary, maxLines = 1, overflow = TextOverflow.Ellipsis)
        }
        if (!isOpen && habits.isNotEmpty()) FoldedIcons(habits, marked, Modifier.weight(1f)) else Spacer(Modifier.weight(1f))
        if (badge != null) com.oftenenough.app.ui.components.Badge(badge)
        if (onStart != null && isOpen) StartButton(title, isNow, onStart)
        Box(Modifier.size(40.dp).clip(CircleShape).clickable(onClick = onToggle).semantics { contentDescription = if (isOpen) "Fold $title" else "Open $title" },
            contentAlignment = Alignment.Center) {
            Icon(if (isOpen) Symbols.ExpandLess else Symbols.ExpandMore, null, tint = c.secondary)
        }
    }
}

/** Start (Figma 1958:253): 32 dp, ▶ 18 dp, 4 dp, "Start"; ink for the time of day it is now, tonal for the others. */
@Composable
private fun StartButton(title: String, isNow: Boolean, onStart: () -> Unit) {
    val c = appColors
    Row(
        Modifier.height(32.dp).clip(RoundedCornerShape(16.dp)).background(if (isNow) c.ink else c.soft)
            .clickable(role = Role.Button, onClick = onStart).semantics { contentDescription = "Start $title"; testTag = "start-$title" }
            .padding(start = if (isNow) 14.dp else 12.dp, end = if (isNow) 18.dp else 16.dp),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Icon(Symbols.Filled.PlayArrow, null, Modifier.size(18.dp), tint = if (isNow) c.onInk else c.ink)
        Spacer(Modifier.width(4.dp))
        Text("Start", style = AppType.labelLarge, color = if (isNow) c.onInk else c.ink, maxLines = 1)
    }
}

/**
 * A folded card's habits (Figma 1350:60): 28 dp circles in each habit's colour with a 16 dp white glyph and a 2 dp ring
 * of the card's own white, each overlapping the one before by 6 dp; after three, a "+N" circle in the same shape.
 */
@Composable
private fun FoldedIcons(habits: List<Habit>, marked: Set<String>, modifier: Modifier = Modifier) {
    val c = appColors
    // A habit with a milestone not yet seen comes first among the icons, so its medal shows (Figma A.2).
    val shown = (habits.filter { it.id in marked } + habits.filter { it.id !in marked }).take(3)
    val more = habits.size - shown.size
    // The ring is the card's white behind a 24 dp disc, never a stroke over the disc: a stroke leaves a fringe of colour.
    fun Modifier.ringed(fill: Color) = size(28.dp).clip(CircleShape).background(c.surface).padding(2.dp).clip(CircleShape).background(fill)
    Row(modifier.semantics(mergeDescendants = true) { contentDescription = habits.joinToString(", ") { it.name + if (it.id in marked) ", a milestone" else "" } },
        horizontalArrangement = Arrangement.spacedBy((-6).dp), verticalAlignment = Alignment.CenterVertically) {
        shown.forEach { h ->
            Box {
                Box(Modifier.ringed(c.habit(h.color)), contentAlignment = Alignment.Center) {
                    Icon(com.oftenenough.app.ui.theme.HabitIcons.icon(h.symbol), null, Modifier.size(16.dp), tint = Color.White)
                }
                if (h.id in marked) MiniMedal(h.color, Modifier.align(Alignment.TopEnd).offset(x = 4.dp, y = (-3).dp))
            }
        }
        if (more > 0) {
            Box(Modifier.ringed(c.soft), contentAlignment = Alignment.Center) {
                Text("+$more", style = AppType.labelMedium, color = c.ink, maxLines = 1, softWrap = false)
            }
        }
    }
}

/** A paused habit, in the Paused card at the bottom (opened): its icon, "Paused · back 20 Oct", and Resume. */
@Composable
fun PausedRow(habit: Habit, shape: Shape, store: HabitStore, actions: TodayActions) {
    val c = appColors
    val p = store.pause(habit, store.today())
    Row(Modifier.fillMaxWidth().clip(shape).background(c.surface).heightIn(min = 72.dp)
        .clickable { actions.openDay(habit, store.today()) }.padding(start = 16.dp, end = 8.dp)
        .semantics { testTag = "paused-${habit.name}" },
        verticalAlignment = Alignment.CenterVertically) {
        HabitIcon(habit.symbol, habit.color)
        Spacer(Modifier.width(16.dp))
        Column(Modifier.weight(1f)) {
            Text(habit.name, style = AppType.titleMedium, color = c.ink, maxLines = 2, overflow = TextOverflow.Ellipsis)
            Text(p?.let(DayWords::paused) ?: "Paused", style = AppType.bodyMedium, color = c.secondary, maxLines = 1)
        }
        AppButton("Resume", { store.resume(habit) }, style = ButtonStyle.Text)
    }
}
