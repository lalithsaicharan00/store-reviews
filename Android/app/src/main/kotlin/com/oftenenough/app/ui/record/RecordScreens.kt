package com.oftenenough.app.ui.record

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.imePadding
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.ArrowBack
import androidx.compose.material.icons.rounded.Close
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Checkbox
import androidx.compose.material3.CheckboxDefaults
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Entry
import com.oftenenough.app.data.EntrySource
import com.oftenenough.app.data.HabitCopy
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.clockText
import com.oftenenough.app.data.description
import com.oftenenough.app.data.opensRecord
import com.oftenenough.app.data.originLine
import com.oftenenough.app.data.undoLabel
import com.oftenenough.app.ui.components.segmentShape
import com.oftenenough.app.ui.day.logCount
import com.oftenenough.app.ui.theme.appColors

/** ✕ (or ←) and a one-line title (U18). */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RecordTopBar(title: String, close: Boolean = true, onClose: () -> Unit, actions: @Composable () -> Unit = {}) {
    TopAppBar(
        title = { Text(title, maxLines = 1) },
        navigationIcon = {
            IconButton(onClose, Modifier.semantics { testTag = "record-close" }) {
                if (close) Icon(Icons.Rounded.Close, "Cancel") else Icon(Icons.AutoMirrored.Rounded.ArrowBack, "Back")
            }
        },
        actions = { actions() },
        colors = TopAppBarDefaults.topAppBarColors(containerColor = appColors.screen),
    )
}

/** Keep editing / Discard changes: asked before closing anything typed (D7: back never loses typing). */
@Composable
fun DiscardDialog(title: String, onKeep: () -> Unit, onDiscard: () -> Unit) {
    AlertDialog(onKeep, title = { Text(title) },
        confirmButton = { TextButton(onDiscard, Modifier.semantics { testTag = "discard" }) { Text("Discard changes", color = appColors.error) } },
        dismissButton = { TextButton(onKeep) { Text("Keep editing", color = appColors.ink) } })
}

/** The amount: one large typed number, the unit under it, the decimal pad up. */
@Composable
fun AmountCard(draft: ValueDraft, unit: String, focus: FocusRequester?, readOnly: Boolean = false) {
    val c = appColors
    val currency = unit.trim().takeIf { it in HabitCopy.currencies }
    Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(28.dp)).background(c.surface).padding(vertical = 24.dp), horizontalAlignment = Alignment.CenterHorizontally) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            if (currency != null) Text(currency, style = MaterialTheme.typography.displaySmall.copy(fontSize = 48.sp), color = c.secondary)
            BasicTextField(draft.amount, { draft.amount = it.take(16) }, readOnly = readOnly,
                textStyle = TextStyle(fontSize = 57.sp, fontWeight = FontWeight.Normal, color = c.ink, textAlign = TextAlign.Center),
                keyboardOptions = KeyboardOptions(keyboardType = if (draft.kind == HabitKind.Check) KeyboardType.Number else KeyboardType.Decimal),
                singleLine = true, cursorBrush = SolidColor(c.ink),
                modifier = Modifier.widthIn(min = 48.dp).width(IntrinsicWidthFor(draft.amount)).let { m -> focus?.let { m.focusRequester(it) } ?: m }
                    .semantics { testTag = "record-amount"; contentDescription = if (unit.isBlank() || currency != null) "Amount" else "Amount, in $unit" },
                decorationBox = { inner -> Box(contentAlignment = Alignment.Center) {
                    if (draft.amount.isEmpty()) Text("0", style = TextStyle(fontSize = 57.sp, color = c.tonal), textAlign = TextAlign.Center)
                    inner()
                } })
        }
        if (currency == null && unit.isNotBlank()) {
            val one = draft.value == 1.0
            Text(if (one) HabitCopy.unitWord(1.0, unit) else unit, style = MaterialTheme.typography.titleLarge, color = c.secondary)
        }
    }
}

/** Width that fits the typed number (a few characters at 57 sp), so the cursor sits beside it, centred. */
private fun IntrinsicWidthFor(text: String) = (maxOf(1, text.length) * 34 + 8).dp

/** How long: hours, minutes and seconds in three boxes. */
@Composable
fun DurationCard(draft: ValueDraft, focus: FocusRequester?, readOnly: Boolean = false) {
    val c = appColors
    Row(Modifier.fillMaxWidth().clip(RoundedCornerShape(28.dp)).background(c.surface).padding(16.dp), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
        listOf(Triple("h", draft.hours, { v: String -> draft.hours = v }), Triple("min", draft.minutes, { v: String -> draft.minutes = v }),
            Triple("sec", draft.seconds, { v: String -> draft.seconds = v })).forEachIndexed { i, (label, value, set) ->
            Column(Modifier.weight(1f).clip(RoundedCornerShape(16.dp)).background(c.tonal2).padding(vertical = 12.dp), horizontalAlignment = Alignment.CenterHorizontally) {
                BasicTextField(value, { set(it.take(5)) }, readOnly = readOnly,
                    textStyle = TextStyle(fontSize = 40.sp, color = c.ink, textAlign = TextAlign.Center),
                    keyboardOptions = KeyboardOptions(keyboardType = if (i == 2) KeyboardType.Decimal else KeyboardType.Number, imeAction = ImeAction.Next),
                    singleLine = true, cursorBrush = SolidColor(c.ink),
                    modifier = Modifier.fillMaxWidth().let { m -> if (i == 1 && focus != null) m.focusRequester(focus) else m }
                        .semantics { testTag = "record-$label"; contentDescription = when (i) { 0 -> "Hours"; 1 -> "Minutes"; else -> "Seconds" } },
                    decorationBox = { inner -> Box(contentAlignment = Alignment.Center) {
                        if (value.isEmpty()) Text("0", style = TextStyle(fontSize = 40.sp, color = c.secondary.copy(alpha = 0.4f)))
                        inner()
                    } })
                Text(label, style = MaterialTheme.typography.bodyMedium, color = c.secondary)
            }
        }
    }
}

/**
 * One Add screen for every kind (U22): Day details' Log manually, a Today row, History's Add, the timer and the player.
 * ✕ and a one-line title; Habit, Date and Time; the main thing for the kind; a footer that says exactly what will happen;
 * the filled button at the bottom.
 */
@Composable
fun AddLogScreen(habitId: String, startDay: Int, store: HabitStore, source: EntrySource = EntrySource.MANUAL, onDone: () -> Unit) {
    val habit = store.habit(habitId) ?: run { LaunchedEffect(Unit) { onDone() }; return }
    val c = appColors
    val today = store.today()
    var day by rememberSaveable { mutableStateOf(startDay) }
    var time by rememberSaveable { mutableStateOf(store.stamp(null, startDay)) }
    val kind = RecordKind.of(habit, day, store)
    val ruled = store.rule(habit, day)
    val draft = remember(kind) { ValueDraft(ruled.kind) }
    var ticked by remember(day) { mutableStateOf<Set<String>?>(null) }
    var discard by remember { mutableStateOf(false) }
    val focus = remember { FocusRequester() }
    val first = if (habit.kind == HabitKind.Quit) store.rules.quitStartDay(habit) else store.rules.startDay(habit)
    val range = minOf(first, today)..today
    val slipLower = maxOf(store.rules.dayBounds(day).first, minOf(habit.quitSince ?: habit.createdAt, habit.createdAt))
    val slipUpper = minOf(store.rules.dayBounds(day).last, store.clock())
    val doneSteps = ruled.steps.filter { store.isStepDone(it, ruled, day) }.map { it.id }.toSet()
    val changed = draft.differs || ticked != null
    fun close() { if (changed) discard = true else onDone() }
    BackHandler { close() }
    LaunchedEffect(kind) { if (kind == RecordKind.AMOUNT || kind == RecordKind.TIME) runCatching { focus.requestFocus() } }

    val (value, problem) = draft.check()
    val canAdd = day <= today && when (kind) {
        RecordKind.AMOUNT, RecordKind.TIME -> value != null
        RecordKind.CHECK -> true
        RecordKind.DAY_DONE -> !store.rules.isDayMet(ruled, day)
        RecordKind.STEPS -> ticked?.let { it != doneSteps } ?: false
        RecordKind.SLIP -> slipLower <= slipUpper
    }
    fun add() {
        if (!canAdd) return
        val at = store.logTime(time, day)
        when (kind) {
            RecordKind.AMOUNT, RecordKind.TIME -> store.addProgress(habit, value!!, day, at, source)
            RecordKind.CHECK -> store.addProgress(habit, 1.0, day, at, source)
            RecordKind.DAY_DONE -> store.setDayDone(true, habit, day, at, source)
            RecordKind.STEPS -> {
                val wanted = ticked ?: doneSteps
                for (s in ruled.steps) if ((s.id in wanted) != store.isStepDone(s, ruled, day)) store.toggleStep(s, ruled, day, at, source)
            }
            RecordKind.SLIP -> store.slip(habit, day, time.coerceIn(slipLower, maxOf(slipLower, slipUpper)), source)
        }
        onDone()
    }
    val footer = footerText(kind, ruled, day, today, store.logTime(time, day), store, slipLower <= slipUpper)
    Column(Modifier.fillMaxSize().background(c.screen).imePadding().navigationBarsPadding()) {
        RecordTopBar(kind.addTitle, onClose = ::close)
        Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 16.dp)) {
            Spacer(Modifier.height(8.dp))
            Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
                HabitFact(habit, 0, 3)
                DateTimeRows(day, today, range, time, if (kind == RecordKind.TIME) "Finished at" else "Time", 1, 3,
                    onDay = { d -> time = store.sameClockTime(time, d); day = d }, onTime = { t -> time = store.logTime(t, day) })
            }
            when (kind) {
                RecordKind.AMOUNT -> { SectionTitle("Amount"); AmountCard(draft, ruled.unit, focus); Footer(problem ?: footer) }
                RecordKind.TIME -> { SectionTitle("How long"); DurationCard(draft, focus); Footer(problem ?: footer) }
                RecordKind.STEPS -> {
                    SectionTitle("Steps")
                    val chosen = ticked ?: doneSteps
                    Column(Modifier.clip(RoundedCornerShape(28.dp)).background(c.surface).padding(vertical = 8.dp)) {
                        ruled.steps.forEachIndexed { i, s ->
                            val on = s.id in chosen
                            Row(Modifier.fillMaxWidth().clickable { ticked = if (on) chosen - s.id else chosen + s.id }.heightIn(min = 48.dp).padding(horizontal = 8.dp)
                                .semantics { testTag = "record-step-$i" }, verticalAlignment = Alignment.CenterVertically) {
                                Checkbox(on, { ticked = if (on) chosen - s.id else chosen + s.id },
                                    colors = CheckboxDefaults.colors(checkedColor = c.habit(habit.color), uncheckedColor = c.secondary))
                                Text(s.name, style = MaterialTheme.typography.bodyLarge, color = c.ink)
                            }
                        }
                    }
                    Footer(footer)
                }
                else -> Footer(footer)
            }
        }
        BottomAction(kind.addButton, canAdd, onClick = ::add)
    }
    if (discard) DiscardDialog("Discard this ${if (kind == RecordKind.SLIP) "slip" else "log"}?", { discard = false }, onDone)
}

/** Exactly what will happen, then a paused or skipped day's note (the iPhone's footers). */
private fun footerText(kind: RecordKind, ruled: com.oftenenough.app.data.Habit, day: Int, today: Int, at: Long, store: HabitStore, slipOk: Boolean): String {
    val date = DayWords.short(day).replace(",", "")
    val clock = DayWords.clock(at)
    var text = when (kind) {
        RecordKind.AMOUNT -> if (ruled.atMost) "Records what happened. Your limit stays the same." else "Adds a new log. Other logs stay as they are."
        RecordKind.TIME -> if (ruled.atMost) "Records what happened. Your limit stays the same." else "Adds one session. Other logs stay as they are."
        RecordKind.CHECK -> {
            var t = "Adds one check to $date at $clock. Checks already there stay."
            if (!ruled.frequency.isDayBased) {
                val thisPeriod = store.rules.periodRange(ruled, day)?.contains(today) ?: false
                val period = com.oftenenough.app.data.DayStatus.periodWord(ruled.frequency).trim()
                if (period.isNotEmpty()) t += " It counts toward ${if (thisPeriod) period else period.replace("this", "that")}."
            }
            t
        }
        RecordKind.DAY_DONE -> if (store.rules.isDayMet(ruled, day)) "$date is already done. To take it back, open that day's details."
            else "Marks $date as done at $clock." + (com.oftenenough.app.data.DayStatus.periodWord(ruled.frequency).replace(" this ", "")
                .takeIf { ruled.frequency.isFlexible && it.isNotEmpty() }?.let { " It counts toward that $it." } ?: "")
        RecordKind.STEPS -> "Saves these steps for $date at $clock."
        RecordKind.SLIP -> if (slipOk) "A slip is recorded with its time. You can change or remove it later." else "This day is before this run started."
    }
    if (store.isPaused(ruled, day)) text += " This day is paused. A log still goes into your history."
    else if (store.isSkipped(ruled, day)) text += " This day is skipped. Adding keeps the skip; undo it in the day's details."
    return text
}

/**
 * One saved record: view first (Log, Slip), with Delete | Edit at the bottom; Edit opens edit mode (Edit log, Edit slip)
 * with the value focused and Save always on (U19). The day itself never changes; the time stays inside it.
 */
@Composable
fun LogScreen(entryId: String, store: HabitStore, onBack: () -> Unit) {
    val c = appColors
    val rev = store.dataVersion
    val entry: Entry = remember(rev) { store.entry(entryId) } ?: run { LaunchedEffect(Unit) { onBack() }; return }
    val habit = store.habit(entry.habitId) ?: run { LaunchedEffect(Unit) { onBack() }; return }
    val ruled = store.rule(habit, entry.day)
    val slip = ruled.kind == HabitKind.Quit
    val noun = if (slip) "slip" else "log"
    var editing by rememberSaveable { mutableStateOf(false) }
    var confirmDelete by remember { mutableStateOf(false) }
    var discard by remember { mutableStateOf(false) }
    val draft = remember(editing) { ValueDraft(ruled.kind, entry.value) }
    var time by remember(editing) { mutableStateOf(entry.createdAt) }
    val focus = remember { FocusRequester() }
    val today = store.today()
    fun leaveEdit() { if (draft.differs || time != entry.createdAt) discard = true else editing = false }
    BackHandler(editing) { leaveEdit() }
    LaunchedEffect(editing) { if (editing && !slip) runCatching { focus.requestFocus() } }

    Column(Modifier.fillMaxSize().background(c.screen).imePadding().navigationBarsPadding()) {
        RecordTopBar(if (editing) "Edit $noun" else noun.replaceFirstChar { it.uppercase() }, close = editing, onClose = { if (editing) leaveEdit() else onBack() })
        Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 16.dp)) {
            Spacer(Modifier.height(8.dp))
            Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
                HabitFact(habit, 0, 3)
                if (editing) {
                    DateTimeRows(entry.day, today, entry.day..entry.day, time, if (ruled.kind == HabitKind.Duration) "Finished at" else "Time", 1, 3,
                        onDay = {}, onTime = { t -> time = store.logTime(t, entry.day, entry.timeZone) }, editableDay = false)
                } else {
                    FactRow("Date", 1, 3) { Text(DayWords.withDate(entry.day, today), style = MaterialTheme.typography.bodyLarge, color = c.secondary) }
                    FactRow("Time", 2, 3) { Text(clockText(entry), style = MaterialTheme.typography.bodyLarge, color = c.secondary) }
                }
            }
            when (ruled.kind) {
                is HabitKind.Amount, HabitKind.Check -> { SectionTitle("Amount"); AmountCard(draft, ruled.unit.ifEmpty { if (ruled.kind == HabitKind.Check) "checks" else "" }, focus, readOnly = !editing) }
                HabitKind.Duration -> { SectionTitle("How long"); DurationCard(draft, focus, readOnly = !editing) }
                else -> {}
            }
            val problem = draft.check().second
            Footer(if (editing) (problem ?: "Changes this $noun only. Its day stays ${DayWords.short(entry.day)}.") else (entry.originLine(slip) ?: ""))
        }
        if (editing) {
            BottomAction("Save", true, tag = "record-save") {
                val v = if (slip) 1.0 else draft.value ?: return@BottomAction
                store.editEntry(entry.id, v, time)
                editing = false
            }
        } else Row(Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 12.dp), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
            Button({ confirmDelete = true }, Modifier.weight(1f).heightIn(min = 56.dp).semantics { testTag = "record-delete" },
                colors = ButtonDefaults.buttonColors(containerColor = c.tonal, contentColor = c.error)) { Text("Delete $noun", style = MaterialTheme.typography.titleMedium) }
            Button({ editing = true }, Modifier.weight(1f).heightIn(min = 56.dp).semantics { testTag = "record-edit" },
                colors = ButtonDefaults.buttonColors(containerColor = c.ink, contentColor = c.onInk)) { Text("Edit", style = MaterialTheme.typography.titleMedium) }
        }
    }
    if (confirmDelete) AlertDialog({ confirmDelete = false }, title = { Text("Delete this $noun?") },
        text = { Text("${entry.description(ruled)} at ${clockText(entry)} on ${DayWords.short(entry.day)} is removed from your history.") },
        confirmButton = { TextButton({ confirmDelete = false; onBack(); store.undoEntry(entry.id) }, Modifier.semantics { testTag = "confirm-delete" }) { Text("Delete $noun", color = c.error) } },
        dismissButton = { TextButton({ confirmDelete = false }) { Text("Cancel", color = c.ink) } })
    if (discard) DiscardDialog("Discard your changes to this $noun?", { discard = false }, { discard = false; editing = false })
}


/** All of a day's logs, newest first (from "All N logs ›"). */
@Composable
fun AllLogsScreen(habitId: String, day: Int, store: HabitStore, onLog: (Entry) -> Unit, onBack: () -> Unit) {
    val habit = store.habit(habitId) ?: run { LaunchedEffect(Unit) { onBack() }; return }
    val c = appColors
    val rev = store.revision(habitId)
    val ruled = store.rule(habit, day)
    val logs = remember(rev, day) { store.dayLogs(habit, day) }
    Column(Modifier.fillMaxSize().background(c.screen).navigationBarsPadding()) {
        RecordTopBar("All logs", close = false, onClose = onBack)
        Text(logCount(logs.size, ruled) + " · " + DayWords.withDate(day, store.today()), Modifier.padding(start = 32.dp, bottom = 8.dp),
            style = MaterialTheme.typography.bodyMedium, color = c.secondary)
        Column(Modifier.verticalScroll(rememberScrollState()).padding(horizontal = 16.dp), verticalArrangement = Arrangement.spacedBy(2.dp)) {
            logs.forEachIndexed { i, e ->
                val opens = e.opensRecord(ruled)
                Row(Modifier.fillMaxWidth().clip(segmentShape(i, logs.size)).background(c.surface).let { if (opens) it.clickable { onLog(e) } else it }
                    .heightIn(min = 56.dp).padding(start = 16.dp, end = 8.dp), verticalAlignment = Alignment.CenterVertically) {
                    Text(e.description(ruled), Modifier.weight(1f), style = MaterialTheme.typography.bodyLarge, color = c.ink)
                    Text(clockText(e), style = MaterialTheme.typography.bodyLarge, color = c.secondary)
                    if (!opens) TextButton({ store.undoEntry(e.id) }, Modifier.semantics { contentDescription = e.undoLabel(ruled) }) { Text("Undo", color = c.ink) }
                    else Spacer(Modifier.width(12.dp))
                }
            }
        }
    }
}
