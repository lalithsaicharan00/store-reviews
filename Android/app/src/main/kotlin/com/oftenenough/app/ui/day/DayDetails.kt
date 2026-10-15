package com.oftenenough.app.ui.day

import com.oftenenough.app.ui.theme.AppType

import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
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
import androidx.compose.material.icons.automirrored.rounded.StickyNote2
import androidx.compose.material.icons.rounded.CalendarMonth
import androidx.compose.material.icons.rounded.Close
import androidx.compose.material.icons.rounded.MoreVert
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Checkbox
import androidx.compose.material3.CheckboxDefaults
import androidx.compose.material3.DatePicker
import androidx.compose.material3.DatePickerDialog
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.ModalBottomSheet
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.SelectableDates
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.rememberDatePickerState
import androidx.compose.material3.rememberModalBottomSheetState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.oftenenough.app.data.DayStatus
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Entry
import com.oftenenough.app.data.EntrySource
import com.oftenenough.app.data.Format
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitCopy
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.clockText
import com.oftenenough.app.data.description
import com.oftenenough.app.data.opensRecord
import com.oftenenough.app.data.undoLabel
import com.oftenenough.app.ui.components.CookieShape
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.WavyProgress
import com.oftenenough.app.ui.components.segmentShape
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
}

/** "8 glasses a day · Anytime", "Quitting since 19 Sep 2026", "Task · Planned for Sat, 4 Oct" (the iPhone's DayIdentityRow). */
fun planLine(habit: Habit, store: HabitStore): String = when (habit.kind) {
    HabitKind.Quit -> "Quitting since " + DayWords.long(store.rules.calendarDayOf(habit.quitSince ?: habit.createdAt))
    HabitKind.Task -> habit.dueDay?.let { "Task · Planned for " + DayWords.short(it) } ?: ("Task · " + HabitCopy.capitalized(HabitCopy.plan(habit, store.weekStart)))
    else -> HabitCopy.capitalized(HabitCopy.plan(habit, store.weekStart)) + " · " +
        (if (habit.parts == listOf("anytime")) "Anytime" else HabitCopy.capitalized(HabitCopy.join(habit.parts.map { store.section(it).name })))
}

/**
 * Day details: one habit (or task) on one day, a modal bottom sheet (✕ start, the day, ⋮ end). The habit card opens its
 * page; This day holds the status, the logging buttons and the note; the day's logs follow (at most three rows); Skip
 * last, outlined (U14–U17, the 12 Oct Expressive version).
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun DayDetailsSheet(habitId: String, day: Int, store: HabitStore, nav: DayNav, onDismiss: () -> Unit) {
    val habit = store.habit(habitId) ?: run { onDismiss(); return }
    val state = rememberModalBottomSheetState(skipPartiallyExpanded = true)
    ModalBottomSheet(onDismiss, sheetState = state, containerColor = appColors.screen, shape = RoundedCornerShape(topStart = 28.dp, topEnd = 28.dp)) {
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
    val editable = day <= today && day >= store.rules.startDay(habit)
    Column(Modifier.verticalScroll(rememberScrollState()).padding(horizontal = 16.dp).navigationBarsPadding().semantics { testTag = "day-details" }) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            IconButton(onDismiss, Modifier.semantics { testTag = "day-close" }) { Icon(Icons.Rounded.Close, "Close", tint = c.ink) }
            Text(DayWords.day(day, today), Modifier.weight(1f).padding(start = 8.dp), style = AppType.headlineSmall, color = c.ink)
            Box {
                IconButton({ menu = true }, Modifier.semantics { testTag = "day-more" }) { Icon(Icons.Rounded.MoreVert, if (isTask) "Task actions" else "Habit actions", tint = c.ink) }
                DropdownMenu(menu, { menu = false }) {
                    @Composable fun item(text: String, red: Boolean = false, action: () -> Unit) =
                        DropdownMenuItem(text = { Text(text, color = if (red) c.error else c.ink) }, onClick = { menu = false; action() })
                    if (!isTask) item("View habit") { nav.habitPage(habit) }
                    item(if (isTask) "Edit task" else "Edit habit") { nav.edit(habit) }
                    if (!isTask && store.rules.canPause(habit)) {
                        if (store.isPaused(habit, today)) item("Resume habit") { store.resume(habit) } else item("Pause…") { nav.pause(habit) }
                    }
                    HorizontalDivider()
                    if (habit.archived) item("Restore") { store.restore(habit) } else item("Archive") { store.archive(listOf(habit)); onDismiss() }
                    item(if (isTask) "Delete task…" else "Delete habit…", red = true) { confirmDelete = true }
                }
            }
        }
        Spacer(Modifier.height(16.dp))
        // The habit: icon in the cookie, name, plan; opens its page.
        Row(Modifier.fillMaxWidth().clip(RoundedCornerShape(28.dp)).background(c.surface)
            .let { if (!isTask) it.clickable { nav.habitPage(habit) } else it }.padding(16.dp).semantics { testTag = "day-identity" },
            verticalAlignment = Alignment.CenterVertically) {
            HabitIcon(habit.symbol, habit.color, size = 48.dp, shape = CookieShape())
            Spacer(Modifier.width(16.dp))
            Column(Modifier.weight(1f)) {
                Text(habit.name, style = AppType.titleMedium, color = c.ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
                Text(planLine(habit, store), style = MaterialTheme.typography.bodyMedium, color = c.secondary)
            }
            if (!isTask) Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = c.secondary)
        }
        Spacer(Modifier.height(12.dp))
        DayActivity(habit, day, editable, rev, store, nav)
        if (isTask && store.canReschedule(habit, day)) {
            Spacer(Modifier.height(12.dp))
            Text("Reschedule", Modifier.padding(start = 16.dp, bottom = 8.dp), style = MaterialTheme.typography.labelLarge, color = c.secondary)
            Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
                RowAction("Do tomorrow", Icons.AutoMirrored.Rounded.Redo, segmentShape(0, 2)) { store.reschedule(habit, day, today + 1); onDismiss() }
                RowAction("Another day…", Icons.Rounded.CalendarMonth, segmentShape(1, 2)) { reschedule = true }
            }
        } else if (!isTask && habit.kind != HabitKind.Quit && editable && !habit.atMost) {
            val skipped = store.isSkipped(habit, day)
            if (skipped || (store.rules.canSkip(store.rule(habit, day)) && !store.isPaused(habit, day))) {
                Spacer(Modifier.height(12.dp))
                OutlinedButton({ store.setSkipped(habit, day, !skipped) }, Modifier.fillMaxWidth().heightIn(min = 52.dp).semantics { testTag = "day-skip" },
                    border = BorderStroke(1.dp, c.outline.copy(alpha = 0.5f))) {
                    Text(if (skipped) "Undo skip" else if (day == today) "Skip today" else "Skip this day", style = MaterialTheme.typography.titleMedium, color = c.ink)
                }
            }
        }
        Spacer(Modifier.height(24.dp))
    }
    if (confirmDelete) AlertDialog(
        onDismissRequest = { confirmDelete = false },
        title = { Text("Delete ${habit.name}?") },
        text = { Text("Its history and notes are deleted too, and this can't be undone. Archiving stops it and keeps its history.") },
        confirmButton = { TextButton({ confirmDelete = false; onDismiss(); store.delete(listOf(habit)) }) { Text(if (isTask) "Delete task" else "Delete habit", color = c.error) } },
        dismissButton = {
            Row {
                if (!habit.archived) TextButton({ confirmDelete = false; store.archive(listOf(habit)); onDismiss() }) { Text("Archive instead", color = c.ink) }
                TextButton({ confirmDelete = false }) { Text("Cancel", color = c.ink) }
            }
        },
    )
    if (reschedule) {
        val range = store.rescheduleRange(habit, day)
        if (range == null) reschedule = false else {
            val toMs = { d: Int -> LocalDate.ofEpochDay(d.toLong()).atStartOfDay(ZoneOffset.UTC).toInstant().toEpochMilli() }
            val picker = rememberDatePickerState(initialSelectedDateMillis = toMs(range.first), selectableDates = object : SelectableDates {
                override fun isSelectableDate(utcTimeMillis: Long): Boolean =
                    Instant.ofEpochMilli(utcTimeMillis).atZone(ZoneOffset.UTC).toLocalDate().toEpochDay().toInt() in range
            })
            DatePickerDialog({ reschedule = false }, confirmButton = {
                TextButton({
                    picker.selectedDateMillis?.let { store.reschedule(habit, day, Instant.ofEpochMilli(it).atZone(ZoneOffset.UTC).toLocalDate().toEpochDay().toInt()) }
                    reschedule = false; onDismiss()
                }) { Text("Move", color = c.ink) }
            }, dismissButton = { TextButton({ reschedule = false }) { Text("Cancel", color = c.ink) } }) {
                DatePicker(picker, title = { Text("Another day", Modifier.padding(start = 24.dp, top = 16.dp)) })
            }
        }
    }
}

@Composable
private fun RowAction(text: String, icon: androidx.compose.ui.graphics.vector.ImageVector, shape: androidx.compose.ui.graphics.Shape, onClick: () -> Unit) {
    Row(Modifier.fillMaxWidth().clip(shape).background(appColors.surface).clickable(onClick = onClick).heightIn(min = 56.dp).padding(horizontal = 16.dp),
        verticalAlignment = Alignment.CenterVertically) {
        Icon(icon, null, tint = appColors.ink)
        Spacer(Modifier.width(16.dp))
        Text(text, style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
    }
}

private class DayAction(val title: String, val prominent: Boolean = false, val enabled: Boolean = true, val spoken: String? = null, val tag: String, val run: () -> Unit)

/** This day: the status ("4 of 8 glasses"), the wavy bar where there's progress toward a goal, the buttons, the note. */
@Composable
private fun DayActivity(habit: Habit, day: Int, editable: Boolean, rev: Int, store: HabitStore, nav: DayNav) {
    val c = appColors
    val today = store.today()
    val ruled = store.rule(habit, day)
    val running = day == today && store.timers.containsKey(habit.id)
    val tick = rememberTicker(running, store.clock)
    val status = remember(rev, day, store.timers, store.skips, store.pauses) { DayStatus.make(habit, day, store) }
    val logs = remember(rev, day) { if (showsLogs(ruled, habit, day, store)) store.dayLogs(habit, day) else emptyList() }
    val actions = dayActions(habit, ruled, day, editable, logs.isNotEmpty(), store, nav)
    val skipped = store.isSkipped(habit, day)
    val paused = store.isPaused(habit, day)
    val showsBar = !skipped && !paused && !ruled.atMost && ruled.kind != HabitKind.Quit && ruled.kind != HabitKind.Task &&
        !(ruled.kind == HabitKind.Check && !store.rules.countsUp(habit, day) && ruled.frequency.isDayBased) && day >= store.rules.startDay(habit)

    Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(28.dp)).background(c.surface).padding(horizontal = 20.dp, vertical = 18.dp)) {
        Text("This day", style = MaterialTheme.typography.bodySmall, color = c.secondary)
        StatusLine(status, running, tick.value)
        if (showsBar) {
            val goal = maxOf(store.rules.goal(ruled), 1.0)
            val progress = if (running) store.rules.progress(habit, day, tick.value) else store.rules.progress(habit, day)
            Spacer(Modifier.height(12.dp))
            WavyProgress((progress / goal).toFloat(), c.habit(habit.color), c.habit(habit.color).copy(alpha = 0.25f), Modifier.fillMaxWidth().height(14.dp))
        }
        if (actions.isNotEmpty()) {
            Spacer(Modifier.height(16.dp))
            Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                for (a in actions) {
                    val colors = if (a.prominent) ButtonDefaults.buttonColors(containerColor = c.ink, contentColor = c.onInk)
                        else ButtonDefaults.buttonColors(containerColor = c.tonal, contentColor = c.ink)
                    Button(a.run, Modifier.weight(1f).heightIn(min = 52.dp).semantics { testTag = a.tag; a.spoken?.let { contentDescription = it } },
                        enabled = a.enabled, colors = colors, contentPadding = PaddingValues(horizontal = 12.dp)) {
                        Text(a.title, style = MaterialTheme.typography.titleMedium, maxLines = 1, overflow = TextOverflow.Ellipsis)
                    }
                }
            }
        }
        // A checklist's steps: Material checkboxes in the habit's colour, the work and the correction at once.
        if (ruled.kind == HabitKind.Checklist && day >= store.rules.startDay(habit)) {
            val locked = !editable || skipped || paused
            Spacer(Modifier.height(8.dp))
            ruled.steps.forEachIndexed { i, step ->
                val done = remember(rev, day) { store.isStepDone(step, ruled, day) }
                Row(Modifier.fillMaxWidth().clip(RoundedCornerShape(12.dp)).clickable(enabled = !locked) { store.toggleStep(step, ruled, day, source = EntrySource.DAY_SHEET) }
                    .heightIn(min = 48.dp).semantics { testTag = "day-step-$i" }, verticalAlignment = Alignment.CenterVertically) {
                    Checkbox(done, { store.toggleStep(step, ruled, day, source = EntrySource.DAY_SHEET) }, enabled = !locked,
                        colors = CheckboxDefaults.colors(checkedColor = c.habit(habit.color), uncheckedColor = c.secondary))
                    Text(step.name, style = MaterialTheme.typography.bodyLarge, color = c.ink)
                }
            }
        }
        Spacer(Modifier.height(12.dp))
        HorizontalDivider(color = c.tonal)
        val note = store.note(habit, day)
        Row(Modifier.fillMaxWidth().clickable(enabled = editable || note != null) { nav.note(habit, day) }.padding(vertical = 14.dp)
            .semantics { testTag = if (note == null) "day-add-note" else "day-edit-note" }, verticalAlignment = Alignment.CenterVertically) {
            Icon(Icons.AutoMirrored.Rounded.StickyNote2, null, tint = c.secondary)
            Spacer(Modifier.width(16.dp))
            Column(Modifier.weight(1f)) {
                if (note != null) {
                    Text("Note", style = MaterialTheme.typography.bodySmall, color = c.secondary)
                    Text(note, style = MaterialTheme.typography.bodyLarge, color = c.ink, maxLines = 2, overflow = TextOverflow.Ellipsis)
                } else Text("Add a note…", style = MaterialTheme.typography.bodyLarge, color = c.secondary)
            }
            Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = c.secondary)
        }
    }
    if (logs.isNotEmpty()) {
        Spacer(Modifier.height(20.dp))
        Text(logsTitle(ruled, day, today), Modifier.padding(start = 16.dp, bottom = 8.dp), style = AppType.labelLarge, color = c.secondary)
        val shown = if (logs.size <= 3) logs else logs.take(2)
        val rows = shown.size + if (logs.size > 3) 1 else 0
        Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
            shown.forEachIndexed { i, e -> LogRow(e, ruled, segmentShape(i, rows), store, nav) }
            if (logs.size > 3) Row(Modifier.fillMaxWidth().clip(segmentShape(rows - 1, rows)).background(c.surface).clickable { nav.allLogs(habit, day) }
                .heightIn(min = 56.dp).padding(horizontal = 16.dp).semantics { testTag = "day-all-logs" }, verticalAlignment = Alignment.CenterVertically) {
                Text("All " + logCount(logs.size, ruled), Modifier.weight(1f), style = MaterialTheme.typography.bodyLarge, color = c.ink)
                Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = c.secondary)
            }
        }
    }
}

/** The count's number large, its words beside it on the same baseline ("4 of 8 glasses", "4 glasses to go"). */
@Composable
private fun StatusLine(status: DayStatus, running: Boolean, now: Long) {
    val c = appColors
    val title = status.title
    val match = Regex("^(\\d[\\d,.]*)\\s+(.*)$").find(title)
    val detail = if (running && status.running != null) "Timer running · " + Format.clock((now - status.running) / 60_000.0) else status.detail
    val short = detail != null && detail.length <= 22
    if (match != null) {
        Row(verticalAlignment = Alignment.Bottom) {
            Text(match.groupValues[1], style = AppType.displayMedium, color = c.ink,
                modifier = Modifier.alignByBaseline().semantics { testTag = "day-result" })
            Spacer(Modifier.width(8.dp))
            Text(match.groupValues[2], Modifier.alignByBaseline().weight(1f), style = MaterialTheme.typography.titleLarge, color = c.ink, maxLines = 2)
            if (short && detail != null) Text(detail, Modifier.alignByBaseline(), style = MaterialTheme.typography.bodyMedium, color = c.secondary)
        }
    } else {
        Text(title, style = MaterialTheme.typography.headlineMedium.copy(fontWeight = FontWeight.Medium), color = c.ink, modifier = Modifier.semantics { testTag = "day-result" })
    }
    if (detail != null && (match == null || !short)) Text(detail, Modifier.semantics { testTag = "day-detail" }, style = MaterialTheme.typography.bodyMedium, color = c.secondary)
}

@Composable
private fun LogRow(entry: Entry, habit: Habit, shape: androidx.compose.ui.graphics.Shape, store: HabitStore, nav: DayNav) {
    val c = appColors
    val opens = entry.opensRecord(habit)
    Row(Modifier.fillMaxWidth().clip(shape).background(c.surface).let { if (opens) it.clickable { nav.log(habit, entry) } else it }
        .heightIn(min = 56.dp).padding(start = 16.dp, end = 8.dp).semantics { testTag = "log-${entry.id}" }, verticalAlignment = Alignment.CenterVertically) {
        Text(entry.description(habit), Modifier.weight(1f), style = MaterialTheme.typography.bodyLarge, color = c.ink, maxLines = 1)
        Text(clockText(entry), style = MaterialTheme.typography.bodyLarge.copy(fontFeatureSettings = "tnum"), color = c.secondary)
        if (opens) Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = c.secondary, modifier = Modifier.padding(start = 8.dp))
        else TextButton({ store.undoEntry(entry.id) }, Modifier.semantics { contentDescription = entry.undoLabel(habit) + " at " + clockText(entry) }) {
            Text("Undo", color = c.ink, fontWeight = FontWeight.Medium)
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
    if (store.isPaused(habit, day)) {
        val list = mutableListOf<DayAction>()
        if (store.pause(habit, today)?.contains(today) == true) list.add(DayAction("Resume habit", true, tag = "day-resume") { store.resume(habit) })
        when (ruled.kind) {
            is HabitKind.Amount -> list.add(DayAction(if (list.isEmpty()) "Log amount" else "Log manually", tag = "day-add-entry", run = manual))
            HabitKind.Duration -> list.add(DayAction(if (list.isEmpty()) "Log time" else "Log manually", tag = "day-add-entry", run = manual))
            else -> {}
        }
        return list
    }
    return when (val k = ruled.kind) {
        HabitKind.Task -> {
            val done = store.rules.isDone(habit, day)
            listOf(DayAction(if (done) "Undo done" else "Mark done", !done, tag = "day-done") { store.toggleCheck(habit, day, src) })
        }
        HabitKind.Check -> if (store.rules.countsUp(habit, day)) {
            listOf(DayAction("Add a check", !ruled.atMost, !skipped, tag = "day-add-one") { store.addProgress(habit, 1.0, day, source = src) })
        } else {
            val done = store.rules.isDayMet(ruled, day)
            listOf(DayAction(if (done) "Undo done" else "Mark done", !done, !skipped, tag = "day-done") { store.setDayDone(!done, habit, day) })
        }
        HabitKind.Checklist -> emptyList()
        is HabitKind.Amount -> {
            val step = ruled.quickIncrement
            if (step == null) listOf(DayAction("Log amount", !ruled.atMost, !skipped, tag = "day-add-entry", run = manual))
            else listOf(
                DayAction("+" + Format.amount(step), !ruled.atMost, !skipped, "Add " + HabitCopy.amount(step, k.unit), "day-add-step") { store.increment(habit, day, src) },
                DayAction("Log manually", enabled = !skipped, tag = "day-add-entry", run = manual),
            )
        }
        HabitKind.Duration -> if (day != today) listOf(DayAction("Log time", !ruled.atMost, !skipped, tag = "day-add-entry", run = manual))
        else listOf(
            if (store.timers.containsKey(habit.id)) DayAction("Stop and save", !ruled.atMost, !skipped, tag = "day-stop-timer") { store.stopTimer(habit, day) }
            else DayAction("Start timer", !ruled.atMost, !skipped, tag = "day-start-timer") { store.toggleTimer(habit) },
            DayAction("Log manually", enabled = !skipped, tag = "day-add-entry", run = manual),
        )
        HabitKind.Quit -> listOf(DayAction(if (hasLogs) "Record another slip" else "Record a slip", tag = "day-add-entry", run = manual))
    }
}
