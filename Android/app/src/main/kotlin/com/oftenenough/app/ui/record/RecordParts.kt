package com.oftenenough.app.ui.record

import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.ButtonSize
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.theme.AppType

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.IntrinsicSize
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.height
import androidx.compose.material3.Icon
import androidx.compose.ui.semantics.Role
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Button
import androidx.compose.material3.DatePicker
import androidx.compose.material3.DatePickerDialog
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.SelectableDates
import androidx.compose.material3.Text
import androidx.compose.material3.TimePicker
import androidx.compose.material3.rememberDatePickerState
import androidx.compose.material3.rememberTimePickerState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.GOAL_MAXIMUM
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.theme.appColors
import java.time.Instant
import java.time.LocalDate
import java.time.ZoneId
import java.time.ZoneOffset
import java.time.format.DateTimeFormatter
import java.util.Locale

/** What one Add screen adds (the iPhone's `RecordKind`). */
enum class RecordKind(val addTitle: String, val addButton: String) {
    AMOUNT("Add log", "Add"), TIME("Add log", "Add"), CHECK("Add a check", "Add"), DAY_DONE("Mark a day done", "Mark done"),
    STEPS("Tick steps", "Save"), SLIP("Add slip", "Add");

    companion object {
        fun of(habit: Habit, day: Int, store: HabitStore): RecordKind = when (store.rule(habit, day).kind) {
            is HabitKind.Amount -> AMOUNT
            HabitKind.Duration -> TIME
            HabitKind.Check -> if (store.rules.countsUp(habit, day)) CHECK else DAY_DONE
            HabitKind.Task -> DAY_DONE
            HabitKind.Checklist -> STEPS
            HabitKind.Quit -> SLIP
        }
    }
}

/** Typed numbers, read exactly (never silently clamped or rounded): the iPhone's `GoalNumber.parse`. */
object GoalNumber {
    fun parse(text: String, decimals: Int = 2): Double? {
        val t = text.trim().replace(',', '.')
        if (t.isEmpty() || t.count { it == '.' } > 1 || t.any { !it.isDigit() && it != '.' }) return null
        val places = t.substringAfter('.', "").length
        if (places > decimals) return null
        val v = t.toDoubleOrNull() ?: return null
        return v.takeIf { it.isFinite() && it <= GOAL_MAXIMUM }
    }

    /** "8", "2.5": a value as the field shows it. */
    fun text(v: Double): String = if (v == Math.rint(v)) v.toLong().toString() else "%.2f".format(Locale.US, v).trimEnd('0').trimEnd('.')
}

/** A typed amount or session: its value, or why it can't be saved (said near the field). */
class ValueDraft(val kind: HabitKind, initial: Double? = null) {
    var amount by mutableStateOf(initial?.let(GoalNumber::text) ?: "")
    var hours by mutableStateOf("")
    var minutes by mutableStateOf("")
    var seconds by mutableStateOf("")
    private val opened: List<String>

    init {
        if (kind == HabitKind.Duration && initial != null) {
            val totalSeconds = Math.rint(initial * 6000) / 100
            val whole = (totalSeconds / 60).toInt()
            hours = (whole / 60).toString(); minutes = (whole % 60).toString(); seconds = GoalNumber.text(totalSeconds - whole * 60)
        }
        opened = listOf(amount, hours, minutes, seconds)
    }

    val differs: Boolean get() = listOf(amount, hours, minutes, seconds) != opened

    /** The value, or the problem (null value and null problem: simply empty). */
    fun check(): Pair<Double?, String?> {
        if (kind == HabitKind.Quit) return 1.0 to null
        if (kind == HabitKind.Duration) {
            if (listOf(hours, minutes, seconds).all { it.isBlank() }) return null to null
            fun part(t: String) = if (t.isBlank()) "0" else t
            val h = GoalNumber.parse(part(hours), 0) ?: return null to "Hours are a whole number."
            val m = GoalNumber.parse(part(minutes), 0) ?: return null to "Minutes are a whole number."
            if (m >= 60) return null to "Minutes go up to 59."
            val s = GoalNumber.parse(part(seconds)) ?: return null to "Seconds take up to 2 decimal places."
            if (s >= 60) return null to "Seconds go up to 59.99."
            val v = h * 60 + m + s / 60
            if (v <= 0) return null to "A session is longer than zero."
            return if (v <= GOAL_MAXIMUM) v to null else null to "That's longer than a log can hold."
        }
        if (amount.isBlank()) return null to null
        val whole = kind == HabitKind.Check
        val v = GoalNumber.parse(amount, if (whole) 0 else 2) ?: return null to (if (whole) "Checks are a whole number." else "Use a number with up to 2 decimal places.")
        return if (v > 0) v to null else null to "Enter more than zero."
    }

    val value: Double? get() = check().first
}

private val dateFormat = DateTimeFormatter.ofPattern("d MMM yyyy", Locale.ENGLISH)
fun dayToUtcMs(day: Int): Long = LocalDate.ofEpochDay(day.toLong()).atStartOfDay(ZoneOffset.UTC).toInstant().toEpochMilli()
fun utcMsToDay(ms: Long): Int = Instant.ofEpochMilli(ms).atZone(ZoneOffset.UTC).toLocalDate().toEpochDay().toInt()

/** A tonal pill button that opens a picker ("7 Oct 2026", "2:15 PM"). */
@Composable
fun Pill(text: String, enabled: Boolean = true, tag: String? = null, onClick: () -> Unit) {
    AppButton(text, onClick, style = ButtonStyle.Tonal, enabled = enabled, tag = tag)
}

/** One segmented row: a label at the start and its value or control at the end (List item, 2.4). */
@Composable
fun FactRow(label: String, index: Int, count: Int, content: @Composable () -> Unit) =
    AppListItem(label, index, count, trailing = content)

/** The habit a record belongs to (Figma 1.6: its icon in a 40 circle, the name; List item, 2.4). The first piece of the fields. */
@Composable
fun HabitFact(habit: Habit, index: Int, count: Int) =
    AppListItem(habit.name, index, count, headlineLines = 2, leading = { HabitIcon(habit.symbol, habit.color) }, tag = "record-habit")

private val yearFormat = DateTimeFormatter.ofPattern("yyyy", Locale.ENGLISH)

/** "Today, 12 Oct 2026", "Sat, 10 Oct 2026" (a form's date, with its year); "Today, 12 Oct" in a view. */
fun recordDate(day: Int, today: Int, year: Boolean): String =
    DayWords.withDate(day, today) + if (year) " " + LocalDate.ofEpochDay(day.toLong()).format(yearFormat) else ""

/**
 * Date | Time (Figma 1.6): one row of two pieces, each its title over its value, › when it opens its own picker
 * (Android's date picker for any day in [range], the time picker inside the day). [last]: this row ends the fields.
 * [onTime] gets the chosen clock time on [day].
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun DateTimeRows(
    day: Int, today: Int, range: IntRange, time: Long, timeTitle: String,
    onDay: (Int) -> Unit, onTime: (Long) -> Unit, editableDay: Boolean = true, editableTime: Boolean = true, last: Boolean = true,
    timeText: String = DayWords.clock(time),
) {
    var pickDay by remember { mutableStateOf(false) }
    var pickTime by remember { mutableStateOf(false) }
    val bottom = if (last) 24.dp else 4.dp
    Row(Modifier.fillMaxWidth().height(IntrinsicSize.Min), horizontalArrangement = Arrangement.spacedBy(2.dp)) {
        DatePiece("Date", recordDate(day, today, year = editableDay), editableDay,
            RoundedCornerShape(topStart = 4.dp, topEnd = 4.dp, bottomEnd = 4.dp, bottomStart = bottom), "record-date", Modifier.weight(1f), grow = true) { pickDay = true }
        DatePiece(timeTitle, timeText, editableTime,
            RoundedCornerShape(topStart = 4.dp, topEnd = 4.dp, bottomEnd = bottom, bottomStart = 4.dp), "record-time", Modifier) { pickTime = true }
    }
    if (pickDay) {
        val state = rememberDatePickerState(initialSelectedDateMillis = dayToUtcMs(day), selectableDates = object : SelectableDates {
            override fun isSelectableDate(utcTimeMillis: Long) = utcMsToDay(utcTimeMillis) in range
        })
        DatePickerDialog({ pickDay = false }, confirmButton = {
            AppButton("OK", { state.selectedDateMillis?.let { onDay(utcMsToDay(it)) }; pickDay = false }, Modifier.semantics { testTag = "picker-ok" }, style = ButtonStyle.Text)
        }, dismissButton = { AppButton("Cancel", { pickDay = false }, style = ButtonStyle.Text) }) { DatePicker(state) }
    }
    if (pickTime) {
        val zone = ZoneId.systemDefault()
        val local = Instant.ofEpochMilli(time).atZone(zone)
        val state = rememberTimePickerState(local.hour, local.minute, DayWords.is24Hour)
        AlertDialog({ pickTime = false }, confirmButton = {
            AppButton("OK", {
                onTime(local.withHour(state.hour).withMinute(state.minute).withSecond(0).toInstant().toEpochMilli())
                pickTime = false
            }, Modifier.semantics { testTag = "picker-ok" }, style = ButtonStyle.Text)
        }, dismissButton = { AppButton("Cancel", { pickTime = false }, style = ButtonStyle.Text) },
            title = { Text("Select time", style = AppType.labelLarge, color = appColors.secondary) },
            text = { Box(Modifier.fillMaxWidth(), contentAlignment = Alignment.Center) { TimePicker(state) } })
    }
}

@Composable
private fun DatePiece(title: String, value: String, opens: Boolean, shape: RoundedCornerShape, tag: String, modifier: Modifier, grow: Boolean = false, onClick: () -> Unit) {
    val c = appColors
    Row(modifier.fillMaxHeight().clip(shape).background(c.surface).let { if (opens) it.clickable(onClick = onClick) else it }
        .heightIn(min = 72.dp).padding(start = 16.dp, end = if (opens) 8.dp else 16.dp, top = 14.dp, bottom = 14.dp).semantics { testTag = tag },
        verticalAlignment = Alignment.CenterVertically) {
        // Only Date grows; Time is as wide as its words (Figma: Date fills, Time hugs).
        Column(if (grow) Modifier.weight(1f) else Modifier) {
            Text(title, style = AppType.titleMedium, color = c.ink, maxLines = 1)
            Text(value, style = AppType.bodyMedium, color = c.secondary, maxLines = 1)
        }
        if (opens) {
            Spacer(Modifier.width(8.dp))
            Icon(Symbols.KeyboardArrowRight, null, tint = c.secondary)
        }
    }
}

/** A line under the fields (Figma: Body Small, grey, 16 in); a problem with what was typed is red. */
@Composable
fun Footer(text: String, modifier: Modifier = Modifier, problem: Boolean = false) =
    Text(text, modifier.fillMaxWidth().padding(horizontal = 16.dp).semantics { testTag = "record-footer" }, style = AppType.bodySmall,
        color = if (problem) appColors.error else appColors.secondary)

/** The label above a card ("Amount", "How long": Label Large, grey, 16 in, 8 above). */
@Composable
fun SectionTitle(text: String) =
    Text(text, Modifier.padding(start = 16.dp, top = 8.dp), style = AppType.labelLarge, color = appColors.secondary)

/** The one filled main action, full width at the bottom (48 high), 12 above the keyboard (U18; Figma 1.6). */
@Composable
fun BottomAction(text: String, enabled: Boolean, tag: String = "record-add", onClick: () -> Unit) {
    val c = appColors
    Box(Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 12.dp)) {
        Box(Modifier.fillMaxWidth().height(48.dp).clip(RoundedCornerShape(24.dp)).background(if (enabled) c.ink else c.ink.copy(alpha = 0.12f))
            .clickable(enabled = enabled, role = Role.Button, onClick = onClick).semantics { testTag = tag }, contentAlignment = Alignment.Center) {
            Text(text, style = AppType.titleMedium, color = if (enabled) c.onInk else c.ink.copy(alpha = 0.38f))
        }
    }
}

/** A saved record's two actions (Figma's Log and Note screens): Delete, Outlined in red (D9), and Edit, Filled; both Medium. */
@Composable
fun DeleteEditBar(noun: String, deleteTag: String, editTag: String, onDelete: () -> Unit, onEdit: () -> Unit) {
    Row(Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 12.dp), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
        AppButton("Delete $noun", onDelete, Modifier.weight(1f), style = ButtonStyle.Outlined, size = ButtonSize.Medium, destructive = true,
            compact = true, tag = deleteTag)
        AppButton("Edit", onEdit, Modifier.weight(1f), size = ButtonSize.Medium, compact = true, tag = editTag)
    }
}

private val Int.sp get() = androidx.compose.ui.unit.TextUnit(this.toFloat(), androidx.compose.ui.unit.TextUnitType.Sp)
