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
            if (currency != null) Text(currency, style = AppType.displayMedium, color = s.onSurfaceVariant)
            if (readOnly) Text(draft.amount, Modifier.semantics { testTag = "record-amount" }, style = AppType.displayMedium, color = s.onSurface)
            else {
                var field by remember { mutableStateOf(TextFieldValue(draft.amount, TextRange(draft.amount.length))) }
                if (field.text != draft.amount) field = TextFieldValue(draft.amount, TextRange(draft.amount.length))
                BasicTextField(field, { field = it.copy(text = it.text.take(16)); draft.amount = field.text },
                    textStyle = AppType.displayMedium.copy(color = s.onSurface, textAlign = TextAlign.Center),
                    keyboardOptions = KeyboardOptions(keyboardType = if (draft.kind == HabitKind.Check) KeyboardType.Number else KeyboardType.Decimal),
                    singleLine = true, cursorBrush = SolidColor(s.onSurface),
                    modifier = Modifier.widthIn(min = 32.dp).width(widthFor(draft.amount)).let { m -> focus?.let { m.focusRequester(it) } ?: m }
                        .semantics { testTag = "record-amount"; contentDescription = spoken },
                    decorationBox = { inner -> Box(contentAlignment = Alignment.Center) {
                        if (draft.amount.isEmpty()) Text("0", style = AppType.displayMedium.copy(color = s.outline), textAlign = TextAlign.Center)
                        inner()
                    } })
            }
        }
        if (currency == null && unit.isNotBlank()) {
            val one = draft.value == 1.0
            Text(if (one) HabitCopy.unitWord(1.0, unit) else unit, style = AppType.bodyLarge, color = s.onSurfaceVariant)
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
                        keyboardOptions = KeyboardOptions(keyboardType = if (label == "Seconds") KeyboardType.Decimal else KeyboardType.Number,
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
fun AddLogScreen(habitId: String, startDay: Int, store: HabitStore, source: EntrySource = EntrySource.MANUAL, onDone: () -> Unit) {
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

/** Exactly what will happen, then a paused or skipped day's note (the iPhone's footers). */
private fun footerText(kind: RecordKind, ruled: com.oftenenough.app.data.Habit, day: Int, today: Int, at: Long, store: HabitStore, slipOk: Boolean): String {
    var text = when (kind) {
        RecordKind.AMOUNT -> if (ruled.atMost) "Records what happened. Your limit stays the same." else "Adds a new log. Other logs stay as they are."
        RecordKind.TIME -> if (ruled.atMost) "Records what happened. Your limit stays the same." else "Adds one session. Other logs stay as they are."
        RecordKind.SLIP -> if (slipOk) "A slip is recorded with its time. You can change or remove it later." else "This day is before this run started."
    }
    if (store.isPaused(ruled, day)) text += " This day is paused. A log still goes into your history."
    else if (store.isSkipped(ruled, day)) text += " This day is skipped. Adding keeps the skip; undo it in the day's details."
    return text
}

/** "India Standard Time": a zone's own name, for a record made somewhere else (Figma 9.3.4). */
private fun zoneName(zone: String): String? = runCatching {
    val z = ZoneId.of(zone)
    if (z.normalized() == ZoneId.systemDefault().normalized()) null
    else java.util.TimeZone.getTimeZone(z).getDisplayName(false, java.util.TimeZone.LONG, java.util.Locale.ENGLISH)
}.getOrNull()

/**
 * One saved record (U19; Figma 1.8, 2.5, 9.3): the Log or Slip view (the habit, Date | Time, the amount or how long,
 * where it came from) with Delete | Edit at the bottom; Edit opens Edit log / Edit slip with the value focused and Save
 * always on. The day itself never changes; the time stays inside it.
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
    // A timer's log keeps its seconds (Figma 2.5); one typed by hand has whole minutes.
    val withSeconds = ruled.kind == HabitKind.Duration && Math.abs(entry.value - Math.rint(entry.value)) > 1e-6
    val zone = zoneName(entry.timeZone)
    fun leaveEdit() { if (draft.differs || time != entry.createdAt) discard = true else editing = false }
    BackHandler(editing) { leaveEdit() }
    LaunchedEffect(editing) { if (editing && !slip) runCatching { focus.requestFocus() } }

    Column(Modifier.fillMaxSize().background(c.screen).imePadding().navigationBarsPadding()) {
        RecordTopBar(if (editing) "Edit $noun" else noun.replaceFirstChar { it.uppercase() }, close = editing, onClose = { if (editing) leaveEdit() else onBack() })
        val scroll = rememberScrollState()
        val keyboard = WindowInsets.ime.getBottom(LocalDensity.current) > 0
        LaunchedEffect(keyboard, scroll.maxValue) { if (keyboard) scroll.scrollTo(scroll.maxValue) }
        Column(Modifier.weight(1f).verticalScroll(scroll).padding(horizontal = 16.dp),
            verticalArrangement = Arrangement.spacedBy(8.dp)) {
            Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
                HabitFact(habit, 0, 2)
                DateTimeRows(entry.day, today, entry.day..entry.day, time, if (ruled.kind == HabitKind.Duration) "Finished at" else "Time",
                    onDay = {}, onTime = { t -> time = store.logTime(t, entry.day, entry.timeZone) },
                    editableDay = false, editableTime = editing, last = zone == null,
                    timeText = if (editing) DayWords.clock(time) else clockText(entry).removeSuffix(" " + entry.timeZone))
                if (zone != null) Row(Modifier.fillMaxWidth().clip(segmentShape(1, 2)).background(c.surface).padding(horizontal = 16.dp, vertical = 12.dp)) {
                    Text("Recorded in $zone", style = AppType.bodyMedium, color = c.secondary)
                }
            }
            when (ruled.kind) {
                is HabitKind.Amount, HabitKind.Check -> { SectionTitle("Amount"); AmountCard(draft, ruled.unit.ifEmpty { if (ruled.kind == HabitKind.Check) "checks" else "" }, focus, readOnly = !editing) }
                HabitKind.Duration -> { SectionTitle("How long"); if (editing) DurationCard(draft, focus, withSeconds = withSeconds) else DurationValue(draft) }
                else -> {}
            }
            val problem = draft.check().second
            val footer = if (editing) (problem ?: if (slip) "Changing the time updates your quit run." else null) else entry.originLine(slip)
            footer?.let { Footer(it, problem = editing && problem != null) }
        }
        if (editing) {
            BottomAction("Save", true, tag = "record-save") {
                val v = if (slip) 1.0 else draft.value ?: return@BottomAction
                store.editEntry(entry.id, v, time)
                editing = false
            }
        } else DeleteEditBar(noun, "record-delete", "record-edit", { confirmDelete = true }, { editing = true })
    }
    if (confirmDelete) AppDialog("Delete this $noun?",
        if (slip) "The slip at ${clockText(entry)} is removed, and your quit run is worked out again."
            else "${entry.description(ruled)} at ${clockText(entry)} is removed from ${if (entry.day == today) "today" else DayWords.short(entry.day)}. Your other logs stay.",
        "Delete $noun", { confirmDelete = false; onBack(); store.undoEntry(entry.id) }, { confirmDelete = false },
        destructive = true, confirmTag = "confirm-delete")
    if (discard) DiscardDialog("Discard your changes to this $noun?", "The $noun stays as it was.", { discard = false }, { discard = false; editing = false })
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
    val logs = remember(rev, day) { store.dayLogs(habit, day) }
    val total = logs.sumOf { it.value }
    val all = when (val k = ruled.kind) {
        is HabitKind.Amount -> HabitCopy.amount(total, k.unit) + " in all. Tap a log to change or delete it."
        HabitKind.Duration -> Format.minutes(total) + " in all. Tap a log to change or delete it."
        HabitKind.Quit -> "Tap a slip to change or delete it."
        else -> "Undo takes one back."
    }
    Column(Modifier.fillMaxSize().background(c.screen).navigationBarsPadding()) {
        RecordTopBar(logsTitle(ruled, day, store.today()), close = false, onClose = onBack)
        Column(Modifier.verticalScroll(rememberScrollState()).padding(horizontal = 16.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
            Column(verticalArrangement = Arrangement.spacedBy(SegmentedListGap)) {
                logs.forEachIndexed { i, e ->
                    val opens = e.opensRecord(ruled)
                    AppListItem(e.description(ruled), i, logs.size, headlineLines = 1, tag = "all-log-$i", onClick = if (opens) ({ onLog(e) }) else null,
                        containerColor = MaterialTheme.colorScheme.surfaceContainerLowest,
                        trailing = { com.oftenenough.app.ui.day.LogTrailing(e, ruled, opens) { store.undoEntry(e.id) } })
                }
            }
            Footer(all)
        }
    }
}
