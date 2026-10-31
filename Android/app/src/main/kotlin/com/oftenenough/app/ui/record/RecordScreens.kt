@file:OptIn(androidx.compose.material3.ExperimentalMaterial3Api::class)

package com.oftenenough.app.ui.record

import com.oftenenough.app.ui.components.AppDialog
import com.oftenenough.app.ui.components.SegmentedListGap
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.NavigationIcon
import com.oftenenough.app.ui.components.AppTopBar
import com.oftenenough.app.ui.theme.AppType

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.imePadding
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.foundation.layout.ime
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
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
import androidx.compose.ui.focus.onFocusChanged
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.TextRange
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Entry
import com.oftenenough.app.data.EntrySource
import com.oftenenough.app.data.Format
import com.oftenenough.app.data.HabitCopy
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.clockText
import com.oftenenough.app.data.description
import com.oftenenough.app.data.opensRecord
import com.oftenenough.app.data.originLine
import com.oftenenough.app.ui.components.segmentShape
import com.oftenenough.app.ui.day.logsTitle
import com.oftenenough.app.ui.theme.appColors
import java.time.ZoneId

/** ✕ (or ←) and a one-line title (U18; Figma: 64 high, Title Large Emphasized). */
@Composable
fun RecordTopBar(title: String, close: Boolean = true, onClose: () -> Unit, actions: @Composable () -> Unit = {}) {
    AppTopBar(title, navigationIcon = {
        if (close) NavigationIcon(Symbols.Close, "Cancel", onClose, Modifier.semantics { testTag = "record-close" })
        else NavigationIcon(Symbols.ArrowBack, "Back", onClose, Modifier.semantics { testTag = "record-close" })
    }, actions = { actions() })
}

/**
 * Asked before closing anything typed (back never loses typing): the Dialog's Default kind (5.3.4, Figma 702:618), the
 * question ("Discard this log?"), what goes ([text]: "The 2 glasses you typed won’t be added."), Keep editing (or
 * [keepLabel]) and Discard, neither in red: nothing saved is lost.
 */
@Composable
fun DiscardDialog(title: String, text: String, onKeep: () -> Unit, onDiscard: () -> Unit, keepLabel: String = "Keep editing") =
    AppDialog(title, text, "Discard", onDiscard, onKeep, dismiss = keepLabel, confirmTag = "discard", dismissTag = "keep-editing")

/**
 * The value's card (Figma's Value, Log screen 687:829): Surface container lowest, corners 24, 16 above and below, its
 * [content] centred.
 */
@Composable
private fun ValueCard(content: @Composable () -> Unit) =
    Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(MaterialTheme.colorScheme.surfaceContainerLowest).padding(vertical = 16.dp),
        horizontalAlignment = Alignment.CenterHorizontally) { content() }

/**
 * Amount (Figma's Value card): the number in Display Medium On surface, typed with the decimal pad up (a whole number
 * for checks); "0" in Outline until something is typed; the unit under it in Body Large On surface variant (a currency
 * sign goes before the number instead). [readOnly]: the View, the number as plain text.
 */
@Composable
fun AmountCard(draft: ValueDraft, unit: String, focus: FocusRequester?, readOnly: Boolean = false) {
    val s = MaterialTheme.colorScheme
    val currency = unit.trim().takeIf { it in HabitCopy.currencies }
    val spoken = if (unit.isBlank() || currency != null) "Amount" else "Amount, in $unit"
    ValueCard {
        Row(verticalAlignment = Alignment.CenterVertically) {
            // The sign is part of the number: the same colour, right against it (Figma 917:30448: "$50").
            if (currency != null) Text(currency, style = AppType.displayMedium, color = if (readOnly || draft.amount.isNotEmpty()) s.onSurface else s.outline)
            if (readOnly) Text(draft.amount, Modifier.semantics { testTag = "record-amount" }, style = AppType.displayMedium, color = s.onSurface)
            else {
                var field by remember { mutableStateOf(TextFieldValue(draft.amount, TextRange(draft.amount.length))) }
                if (field.text != draft.amount) field = TextFieldValue(draft.amount, TextRange(draft.amount.length))
                BasicTextField(field, { field = it.copy(text = it.text.take(16)); draft.amount = field.text },
                    textStyle = AppType.displayMedium.copy(color = s.onSurface, textAlign = if (currency != null) TextAlign.Start else TextAlign.Center),
                    keyboardOptions = KeyboardOptions(keyboardType = if (draft.kind == HabitKind.Check) KeyboardType.Number else KeyboardType.Decimal),
                    singleLine = true, cursorBrush = SolidColor(s.onSurface),
                    modifier = Modifier.widthIn(min = 32.dp).width(widthFor(draft.amount)).let { m -> focus?.let { m.focusRequester(it) } ?: m }
                        .semantics { testTag = "record-amount"; contentDescription = spoken },
                    // Empty, the grey "0" comes first and the caret just after it (Figma 893:6757), never through it.
                    decorationBox = { inner ->
                        if (draft.amount.isEmpty()) Row(verticalAlignment = Alignment.CenterVertically) {
                            Text("0", style = AppType.displayMedium.copy(color = s.outline))
                            Box(Modifier.weight(1f)) { inner() }
                        } else Box(contentAlignment = Alignment.Center) { inner() }
                    })
            }
        }
        if (currency == null && unit.isNotBlank()) {
            val one = draft.value == 1.0
            Text(if (one) HabitCopy.unitWord(1.0, unit) else unit, style = AppType.bodyLarge, color = s.onSurfaceVariant)
        } else if (currency != null) {
            // The currency by name under the number, as any unit (Figma 917:30448: "$50", "dollars").
            val name = when (currency) { "$" -> "dollar"; "€" -> "euro"; "£" -> "pound"; else -> "rupee" }
            Text(if (draft.value == 1.0) name else name + "s", style = AppType.bodyLarge, color = s.onSurfaceVariant)
        }
    }
}

/** How long, read (Figma's Duration View): "2 min 42 s" in Display Medium On surface, in the Value card. */
@Composable
fun DurationValue(draft: ValueDraft) {
    val parts = listOf(draft.hours to "h", draft.minutes to "min", draft.seconds to "s")
        .filter { (v, _) -> v.isNotBlank() && (GoalNumber.parse(v) ?: 0.0) > 0 }.joinToString(" ") { (v, u) -> "$v $u" }
    ValueCard {
        Text(parts.ifEmpty { "0 min" }, Modifier.semantics { testTag = "record-duration" }, style = AppType.displayMedium,
            color = MaterialTheme.colorScheme.onSurface, textAlign = TextAlign.Center)
    }
}

/** Width that fits the typed number (about 26 dp a character at 45 sp), so the cursor sits beside it, centred. */
private fun widthFor(text: String) = (maxOf(1, text.length) * 27 + 6).dp

/**
 * How long (Figma's How long card, Log screen 687:829): Surface container lowest, corners 24, 20 by 16 in, 12 apart:
 * Hours and Minutes in boxes 80 high (corners 12), each its label under it, 8 apart, in Body Medium On surface variant;
 * a timer's log keeps its Seconds too (Figma's Show seconds). Minutes is focused first. The focused box is Surface
 * container high, its number in Display Medium Emphasized On surface ("0" in Outline until typed); the others are
 * Surface container, their numbers On surface variant. No outline.
 */
@Composable
fun DurationCard(draft: ValueDraft, focus: FocusRequester?, withSeconds: Boolean = false) {
    val s = MaterialTheme.colorScheme
    val fields = listOfNotNull(
        Triple("Hours", draft.hours, { v: String -> draft.hours = v }),
        Triple("Minutes", draft.minutes, { v: String -> draft.minutes = v }),
        if (withSeconds) Triple("Seconds", draft.seconds, { v: String -> draft.seconds = v }) else null,
    )
    Row(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(s.surfaceContainerLowest).padding(horizontal = 16.dp, vertical = 20.dp),
        horizontalArrangement = Arrangement.spacedBy(12.dp)) {
        fields.forEachIndexed { i, (label, value, set) ->
            var focused by remember { mutableStateOf(false) }
            Column(Modifier.weight(1f), horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(8.dp)) {
                Box(Modifier.fillMaxWidth().height(80.dp).clip(RoundedCornerShape(12.dp)).background(if (focused) s.surfaceContainerHigh else s.surfaceContainer),
                    contentAlignment = Alignment.Center) {
                    var field by remember { mutableStateOf(TextFieldValue(value, TextRange(value.length))) }
                    if (field.text != value) field = TextFieldValue(value, TextRange(value.length))
                    BasicTextField(field, { v ->
                        val clean = v.text.filter { ch -> ch.isDigit() || ch == '.' || ch == ',' }.take(5)
                        field = v.copy(text = clean, selection = TextRange(minOf(v.selection.end, clean.length))); set(clean)
                    },
                        textStyle = AppType.displayMediumEmphasized.copy(color = if (focused) s.onSurface else s.onSurfaceVariant, textAlign = TextAlign.Center),
                        keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number,
                            imeAction = if (i < fields.lastIndex) ImeAction.Next else ImeAction.Done),
                        singleLine = true, cursorBrush = SolidColor(s.onSurface),
                        modifier = Modifier.fillMaxWidth().onFocusChanged { focused = it.isFocused }
                            .let { m -> if (i == 1 && focus != null) m.focusRequester(focus) else m }
                            .semantics { testTag = "record-${label.lowercase()}"; contentDescription = label },
                        decorationBox = { inner -> Box(contentAlignment = Alignment.Center) {
                            if (value.isEmpty()) Text("0", style = AppType.displayMediumEmphasized.copy(color = if (focused) s.outline else s.onSurfaceVariant, textAlign = TextAlign.Center))
                            inner()
                        } })
                }
                Text(label, style = AppType.bodyMedium, color = s.onSurfaceVariant)
            }
        }
    }
}

/**
 * One Add screen for every kind (U22): Day details' Log manually, a Today row, History's Add, the timer and the player.
 * ✕ and a one-line title; the habit, then Date | Time; the main thing for the kind; a footer that says exactly what will
 * happen; the filled button at the bottom. Add stays on: with nothing (or 0) typed, the footer says what's wrong
 * (Figma 1.6.4); a time later than now stays at now, and says so (1.6.5).
 */
@Composable
fun AddLogScreen(habitId: String, startDay: Int, store: HabitStore, source: EntrySource = EntrySource.MANUAL, say: (String) -> Unit = {}, onDone: () -> Unit) {
    val habit = store.habit(habitId) ?: run { LaunchedEffect(Unit) { onDone() }; return }
    val c = appColors
    val today = store.today()
    var day by rememberSaveable { mutableStateOf(startDay) }
    var time by rememberSaveable { mutableStateOf(store.stamp(null, startDay)) }
    var later by rememberSaveable { mutableStateOf(false) }
    var tried by rememberSaveable { mutableStateOf(false) }
    // A check, a task or a checklist is logged in place, never here (an old link closes).
    val kind = RecordKind.of(habit, day, store) ?: run { LaunchedEffect(Unit) { onDone() }; return }
    val ruled = store.rule(habit, day)
    val draft = remember(kind) { ValueDraft(ruled.kind) }
    var discard by remember { mutableStateOf(false) }
    val focus = remember { FocusRequester() }
    val first = if (habit.kind == HabitKind.Quit) store.rules.quitStartDay(habit) else store.rules.startDay(habit)
    val range = minOf(first, today)..today
    val slipLower = maxOf(store.rules.dayBounds(day).first, minOf(habit.quitSince ?: habit.createdAt, habit.createdAt))
    val slipUpper = minOf(store.rules.dayBounds(day).last, store.clock())
    val changed = draft.differs
    fun close() { if (changed) discard = true else onDone() }
    BackHandler { close() }
    LaunchedEffect(kind) { if (kind == RecordKind.AMOUNT || kind == RecordKind.TIME) runCatching { focus.requestFocus() } }

    val (value, problem) = draft.check()
    val typed = kind == RecordKind.AMOUNT || kind == RecordKind.TIME
    val canAdd = day <= today && when (kind) {
        RecordKind.AMOUNT, RecordKind.TIME -> true
        RecordKind.SLIP -> slipLower <= slipUpper
    }
    fun add() {
        if (!canAdd) return
        if (typed && value == null) { tried = true; return }
        val at = store.logTime(time, day)
        when (kind) {
            RecordKind.AMOUNT, RecordKind.TIME -> store.addProgress(habit, value!!, day, at, source)
            RecordKind.SLIP -> store.slip(habit, day, time.coerceIn(slipLower, maxOf(slipLower, slipUpper)), source)
        }
        // Gone to a day other than the one it came from, it says where (Figma 891:93890: "2 glasses added to yesterday").
        if (day != startDay && kind != RecordKind.SLIP) {
            val what = if (kind == RecordKind.TIME) Format.minutes(value!!) else HabitCopy.amount(value!!, ruled.unit)
            val where = when (day) { today -> "today"; today - 1 -> "yesterday"; else -> recordDate(day) }
            say("$what added to $where")
        }
        onDone()
    }
    // What the footer says: a problem (red) once Add was tried, a time kept at now, or what will happen.
    val shownProblem = problem ?: if (tried && typed && value == null) "Enter more than zero." else null
    val footer = when {
        shownProblem != null -> shownProblem
        later -> "That’s later than now, so the time stays ${DayWords.clock(store.logTime(time, day))}."
        else -> footerText(kind, ruled, day, today, store.logTime(time, day), store, slipLower <= slipUpper)
    }
    val scroll = rememberScrollState()
    // What's wrong comes into view: with the keyboard up the footer can sit under the button (Figma 1.6.4).
    LaunchedEffect(shownProblem, later) { if (shownProblem != null || later) scroll.animateScrollTo(scroll.maxValue) }
    // The keyboard coming up keeps the footer whole above the button, never cut in half under it.
    val keyboard = WindowInsets.ime.getBottom(LocalDensity.current) > 0
    LaunchedEffect(keyboard, scroll.maxValue) { if (keyboard) scroll.scrollTo(scroll.maxValue) }
    Column(Modifier.fillMaxSize().background(c.screen).imePadding().navigationBarsPadding()) {
        RecordTopBar(kind.addTitle, onClose = ::close)
        Column(Modifier.weight(1f).verticalScroll(scroll).padding(horizontal = 16.dp),
            verticalArrangement = Arrangement.spacedBy(8.dp)) {
            Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
                HabitFact(habit, 0, 2)
                DateTimeRows(day, today, range, store.logTime(time, day), if (kind == RecordKind.TIME) "Finished at" else "Time",
                    onDay = { d -> time = store.sameClockTime(time, d); day = d; later = false },
                    onTime = { t -> later = t > store.clock() && day == today; time = store.logTime(t, day) })
            }
            when (kind) {
                RecordKind.AMOUNT -> { SectionTitle("Amount"); AmountCard(draft, ruled.unit, focus) }
                RecordKind.TIME -> { SectionTitle("How long"); DurationCard(draft, focus) }
                RecordKind.SLIP -> {}
            }
            Footer(footer, problem = shownProblem != null)
        }
        BottomAction(kind.addButton, canAdd, onClick = ::add)
    }
    if (discard) DiscardDialog("Discard this ${if (kind == RecordKind.SLIP) "slip" else "log"}?", when {
        kind == RecordKind.AMOUNT && value != null -> "The ${HabitCopy.amount(value, ruled.unit)} you typed won’t be added."
        kind == RecordKind.TIME && value != null -> "The ${Format.minutes(value)} you typed won’t be added."
        else -> "What you typed won’t be added."
    }, { discard = false }, onDone)
}

/** Under All logs, the day's total and what a tap does (Figma 905:16051): "7 glasses in all. Tap a log to change or delete it." */
private fun allLogsFooter(ruled: com.oftenenough.app.data.Habit, logs: List<Entry>): String {
    val total = logs.sumOf { it.value }
    return when (val k = ruled.kind) {
        is HabitKind.Amount -> "${HabitCopy.amount(total, k.unit)} in all. Tap a log to change or delete it."
        HabitKind.Duration -> "${Format.minutes(total)} in all. Tap a log to change or delete it."
        HabitKind.Quit -> "${logs.size} ${if (logs.size == 1) "slip" else "slips"} in all. Tap a slip to change or delete it."
        else -> "${HabitCopy.amount(total, ruled.checkUnit ?: "checks")} in all. Tap a check to change or delete it."
    }
}

/** What deleting a slip does to the run, in plain numbers (Figma 921:117121): " Your run goes back to 19 days." */
private fun slipRunAfterDelete(store: HabitStore, habit: com.oftenenough.app.data.Habit, slip: Entry): String {
    val slips = store.entries(habit.id).filter { it.stepId == null }
    if (slips.any { it.id != slip.id && it.createdAt > slip.createdAt }) return " Your run now stays as it is."
    val from = slips.filter { it.id != slip.id }.maxOfOrNull { it.createdAt } ?: (habit.quitSince ?: habit.createdAt)
    val days = ((store.clock() - from) / 86_400_000L).toInt()
    return " Your run goes back to $days ${if (days == 1) "day" else "days"}."
}

/** A day as the footers and messages name it: today, yesterday, or its date alone ("28 Oct 2026"). */
private fun dayName(day: Int, today: Int) = when (day) { today -> "today"; today - 1 -> "yesterday"; else -> recordDate(day) }

/** "Moves this log to yesterday. Today goes down by 2 glasses." A slip moves its quit run with it. */
private fun moveText(slip: Boolean, entry: Entry, ruled: com.oftenenough.app.data.Habit, day: Int, today: Int): String {
    if (slip) return "Moves this slip to ${dayName(day, today)}. Your quit run is worked out again."
    val from = dayName(entry.day, today).replaceFirstChar { it.uppercase() }
    return "Moves this log to ${dayName(day, today)}. $from goes down by ${entry.description(ruled)}."
}

/** Exactly what will happen, then a paused or skipped day's note (the iPhone's footers). */
private fun footerText(kind: RecordKind, ruled: com.oftenenough.app.data.Habit, day: Int, today: Int, at: Long, store: HabitStore, slipOk: Boolean): String {
    // Another day says where it goes (Figma: "Adds a new log to yesterday. Today's logs stay as they are."); an older
    // day by its date alone, as the Date row writes it.
    val where = when (day) { today -> null; today - 1 -> "yesterday"; else -> recordDate(day) }
    fun adds(what: String) = if (where == null) "$what. Other logs stay as they are." else "$what to $where. Today’s logs stay as they are."
    var text = when (kind) {
        RecordKind.AMOUNT -> if (ruled.atMost) "Records what happened. Your limit stays the same." else adds("Adds a new log")
        RecordKind.TIME -> if (ruled.atMost) "Records what happened. Your limit stays the same." else adds("Adds one session")
        RecordKind.SLIP -> if (slipOk) "A slip is recorded with its time. You can change or remove it later." else "This day is before this run started."
    }
    if (store.isPaused(ruled, day)) text += " This day is paused. A log still goes into your history."
    else if (store.isSkipped(ruled, day)) text += " This day is skipped. Adding keeps the skip; undo it in the day's details."
    return text
}

/**
 * A record made somewhere else says so in its footer (Figma 921:118020): "Logged at 2:40 PM London time (9:40 AM here).
 * It counts on the day it was logged." The zone by its city ("Europe/London": London), else its own name. Null here.
 */
private fun awayLine(entry: Entry): String? = runCatching {
    val z = ZoneId.of(entry.timeZone)
    if (z.normalized() == ZoneId.systemDefault().normalized()) return@runCatching null
    val city = z.id.substringAfterLast('/', "").replace('_', ' ').takeIf { z.id.contains('/') && it.isNotBlank() }
    val place = city ?: java.util.TimeZone.getTimeZone(z).getDisplayName(false, java.util.TimeZone.LONG, java.util.Locale.ENGLISH)
    "Logged at ${DayWords.clock(entry.createdAt, z)} $place time (${DayWords.clock(entry.createdAt)} here). It counts on the day it was logged."
}.getOrNull()

/**
 * One saved record (U19; Figma 1.8, 2.5, 9.3): the Log or Slip view (the habit, Date | Time, the amount or how long,
 * where it came from) with Delete | Edit at the bottom; Edit opens Edit log / Edit slip with the value focused and Save
 * always on. The time stays inside its day; the Date row moves it to another day, today or earlier (Figma 184:2, U19).
 */
@Composable
fun LogScreen(entryId: String, store: HabitStore, say: (String) -> Unit = {}, sayUndo: (String, () -> Unit) -> Unit = { _, _ -> }, onBack: () -> Unit) {
    val c = appColors
    val rev = store.dataVersion
    // Deleted from here, the page leaves first (U27) and keeps showing the log while it slides away.
    var shown by remember { mutableStateOf<Entry?>(null) }
    remember(rev) { store.entry(entryId) }?.let { shown = it } ?: run { if (shown == null) { LaunchedEffect(Unit) { onBack() }; return } }
    val entry: Entry = shown!!
    val habit = store.habit(entry.habitId) ?: run { LaunchedEffect(Unit) { onBack() }; return }
    val ruled = store.rule(habit, entry.day)
    val slip = ruled.kind == HabitKind.Quit
    val oneCheck = ruled.kind == HabitKind.Check && entry.value == 1.0
    val noun = if (slip) "slip" else "log"
    var editing by rememberSaveable { mutableStateOf(false) }
    var confirmDelete by remember { mutableStateOf(false) }
    var discard by remember { mutableStateOf(false) }
    val draft = remember(editing) { ValueDraft(ruled.kind, entry.value) }
    var time by remember(editing) { mutableStateOf(entry.createdAt) }
    var day by remember(editing) { mutableStateOf(entry.day) }
    val focus = remember { FocusRequester() }
    val today = store.today()
    // A timer's log keeps its seconds (Figma 2.5); one typed by hand has whole minutes.
    val withSeconds = ruled.kind == HabitKind.Duration && kotlin.math.floor(entry.value * 60 + 1e-6).toLong() % 60 != 0L
    val away = awayLine(entry)
    val first = if (slip) store.rules.quitStartDay(habit) else store.rules.startDay(habit)
    val range = minOf(first, entry.day, today)..today
    // Moved, it takes the chosen day's clock and zone; kept, its own (a log made on a trip stays in that zone's day).
    val zoneOf = { d: Int -> if (d == entry.day) entry.timeZone else null }
    fun leaveEdit() { if (draft.differs || time != entry.createdAt || day != entry.day) discard = true else editing = false }
    BackHandler(editing) { leaveEdit() }
    LaunchedEffect(editing) { if (editing && !slip && !oneCheck) runCatching { focus.requestFocus() } }

    Column(Modifier.fillMaxSize().background(c.screen).imePadding().navigationBarsPadding()) {
        RecordTopBar(if (editing) "Edit $noun" else noun.replaceFirstChar { it.uppercase() }, close = editing, onClose = { if (editing) leaveEdit() else onBack() })
        val scroll = rememberScrollState()
        val keyboard = WindowInsets.ime.getBottom(LocalDensity.current) > 0
        LaunchedEffect(keyboard, scroll.maxValue) { if (keyboard) scroll.scrollTo(scroll.maxValue) }
        Column(Modifier.weight(1f).verticalScroll(scroll).padding(horizontal = 16.dp),
            verticalArrangement = Arrangement.spacedBy(8.dp)) {
            Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
                HabitFact(habit, 0, 2)
                DateTimeRows(if (editing) day else entry.day, today, range, time, if (ruled.kind == HabitKind.Duration) "Finished at" else "Time",
                    onDay = { d -> time = store.logTime(store.sameClockTime(time, d), d, zoneOf(d)); day = d },
                    onTime = { t -> time = store.logTime(t, day, zoneOf(day)) },
                    editableDay = editing, editableTime = editing, last = true,
                    timeText = DayWords.clock(if (editing) time else entry.createdAt))  // the time here; another zone's in the footer
            }
            when (ruled.kind) {
                // A single check has no amount to show: the habit, its date and its time (Figma 910:25226).
                HabitKind.Check -> if (!oneCheck) { SectionTitle("Amount"); AmountCard(draft, ruled.unit.ifEmpty { "checks" }, focus, readOnly = !editing) }
                is HabitKind.Amount -> { SectionTitle("Amount"); AmountCard(draft, ruled.unit.ifEmpty { if (ruled.kind == HabitKind.Check) "checks" else "" }, focus, readOnly = !editing) }
                HabitKind.Duration -> { SectionTitle("How long"); if (editing) DurationCard(draft, focus, withSeconds = withSeconds) else DurationValue(draft) }
                else -> {}
            }
            val problem = draft.check().second
            // Editing says what Save will do (Figma 896:96313): this record only.
            // Moved, it says where to and what the day it leaves loses (Figma 901:13683: "Moves this log to yesterday.
            // Today goes down by 2 glasses.").
            val footer = if (editing) (problem ?: when {
                day != entry.day -> moveText(slip, entry, ruled, day, today)
                slip -> "Changes this slip only. Your run counts from the new time."
                else -> "Changes this log only. Other logs stay as they are."
            })
                else away ?: entry.originLine(ruled)
            footer?.let { Footer(it, problem = editing && problem != null) }
        }
        if (editing) {
            BottomAction("Save", true, tag = "record-save") {
                val v = if (slip || oneCheck) entry.value else if (!draft.differs) entry.value else draft.value ?: return@BottomAction
                val moved = day != entry.day
                store.editEntry(entry.id, v, time, day)
                editing = false
                // A slip's new time moves the run, so it can be taken back (Figma 921:116994: "Slip changed · Undo").
                if (slip && !moved) sayUndo("Slip changed") { store.editEntry(entry.id, entry.value, entry.createdAt) }
                else say(if (moved) "Moved to ${dayName(day, today)}" else if (slip) "Slip changed" else "Log changed")
            }
        } else DeleteEditBar(noun, "record-delete", "record-edit", { confirmDelete = true }, { editing = true })
    }
    if (confirmDelete) AppDialog(if (oneCheck) "Delete this check?" else "Delete this $noun?",
        if (slip) "The ${clockText(entry)} slip will be removed." + slipRunAfterDelete(store, habit, entry)
            else if (oneCheck) "The ${clockText(entry)} check will be removed from ${if (entry.day == today) "today" else DayWords.short(entry.day)}. Your other checks stay."
            else "${entry.description(ruled)} at ${clockText(entry)} will be removed from ${if (entry.day == today) "today" else DayWords.short(entry.day)}. Your other logs stay.",
        "Delete", {
            confirmDelete = false; onBack(); store.undoEntry(entry.id)
            // Undo puts the same log back, with its time (Figma 902:15462, 902:15770).
            sayUndo(if (slip) "Slip deleted" else if (oneCheck) "Check deleted" else "Log deleted") { store.restoreLog(entry) }
        }, { confirmDelete = false },
        destructive = true, confirmTag = "confirm-delete")
    // Says exactly what stays (Figma 897:11891): "This log stays 2 glasses at 1:10 PM."
    if (discard) DiscardDialog("Discard your changes?",
        if (slip) "This slip stays at ${clockText(entry)}." else "This log stays ${entry.description(ruled)} at ${clockText(entry)}.",
        { discard = false }, { discard = false; editing = false })
}

/**
 * All logs (Figma's All logs screen, 694:607): every record of one habit on one day, newest first, opened from Day
 * details' "All N logs ›". The Top app bar with ← and the title Day details gives the list ("Today’s logs", "Slips on
 * Wed 21 Oct"); the content 16 at the sides, 8 apart, nothing above: the rows, one-line List items 2 apart on Surface
 * container lowest (the value in Title Medium; the clock in Body Medium On surface variant, 16, ›), then the footer
 * ("7 glasses in all. Tap a log to change or delete it."). A row opens the Log screen's View; a check, which has
 * nothing to view, keeps its named Undo in place of ›.
 */
@Composable
fun AllLogsScreen(habitId: String, day: Int, store: HabitStore, onLog: (Entry) -> Unit, onBack: () -> Unit) {
    val habit = store.habit(habitId) ?: run { LaunchedEffect(Unit) { onBack() }; return }
    val c = appColors
    val rev = store.revision(habitId)
    val ruled = store.rule(habit, day)
    val period = remember(rev, day) { com.oftenenough.app.ui.day.logPeriod(ruled, day, store) }
    val logs = remember(rev, day) { if (period != null) store.periodLogs(habit, period) else store.dayLogs(habit, day) }
    Column(Modifier.fillMaxSize().background(c.screen).navigationBarsPadding()) {
        RecordTopBar(logsTitle(ruled, day, store.today(), period), close = false, onClose = onBack)
        Column(Modifier.verticalScroll(rememberScrollState()).padding(horizontal = 16.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
            Column(verticalArrangement = Arrangement.spacedBy(SegmentedListGap)) {
                logs.forEachIndexed { i, e ->
                    val opens = e.opensRecord(ruled)
                    com.oftenenough.app.ui.day.LogListItem(e, ruled, i, logs.size, opens, if (period != null) store.today() else null,
                        if (opens) ({ onLog(e) }) else null) { store.undoEntry(e.id) }
                }
            }
            if (logs.isNotEmpty()) Footer(allLogsFooter(ruled, logs))
        }
    }
}
