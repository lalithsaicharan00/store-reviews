package com.oftenenough.app.ui.record

import com.oftenenough.app.ui.components.AppDatePicker
import com.oftenenough.app.ui.components.AppTimePicker
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
import androidx.compose.material3.MaterialTheme
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Text
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
import java.time.Instant
import java.time.LocalDate
import java.time.ZoneId
import java.time.format.DateTimeFormatter
import java.util.Locale

/** What one Add screen adds (the iPhone's `RecordKind`). */
enum class RecordKind(val addTitle: String, val addButton: String) {
    AMOUNT("Add log", "Add"), TIME("Add log", "Add"), SLIP("Add slip", "Add");

    companion object {
        /**
         * What Add records for this habit; null for a check, a task or a checklist, which Figma logs in place (Day
         * details' Mark done, Add a check and its steps; cleanup 6.6), so no Add screen opens for them.
         */
        fun of(habit: Habit, day: Int, store: HabitStore): RecordKind? = when (store.rule(habit, day).kind) {
            is HabitKind.Amount -> AMOUNT
            HabitKind.Duration -> TIME
            HabitKind.Quit -> SLIP
            HabitKind.Check, HabitKind.Task, HabitKind.Checklist -> null
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
            if (v <= 0) return null to "Enter more than zero."
            return if (v <= GOAL_MAXIMUM) v to null else null to "That's longer than a log can hold."
        }
        if (amount.isBlank()) return null to null
        val whole = kind == HabitKind.Check
        val v = GoalNumber.parse(amount, if (whole) 0 else 2) ?: return null to (if (whole) "Checks are a whole number." else "Use a number with up to 2 decimal places.")
        return if (v > 0) v to null else null to "Enter more than zero."
    }

    val value: Double? get() = check().first
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

/** "Today, 12 Oct 2026", "Sat, 10 Oct 2026": a record's date, with its year (Figma's Log screen, Entry and View alike). */
fun recordDate(day: Int, today: Int): String = DayWords.withDate(day, today) + " " + LocalDate.ofEpochDay(day.toLong()).format(yearFormat)

/**
 * Date | Time (Figma's Log screen, 687:829): one row of two List items (two lines: Title Medium On surface over Body
 * Medium On surface variant, 72 high, 8 above and below, 16 in at the start and 8 at the end, 8 before ›; Surface
 * container lowest), 2 apart, Date filling the room and Time as wide as its words; › when it opens its own picker
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
        DatePiece("Date", recordDate(day, today), editableDay,
            RoundedCornerShape(topStart = 4.dp, topEnd = 4.dp, bottomEnd = 4.dp, bottomStart = bottom), "record-date", Modifier.weight(1f), grow = true) { pickDay = true }
        DatePiece(timeTitle, timeText, editableTime,
            RoundedCornerShape(topStart = 4.dp, topEnd = 4.dp, bottomEnd = bottom, bottomStart = 4.dp), "record-time", Modifier) { pickTime = true }
    }
    if (pickDay) {
        AppDatePicker(day, { it in range }, { pickDay = false }, onPick = onDay)
    }
    if (pickTime) {
        val zone = ZoneId.systemDefault()
        val local = Instant.ofEpochMilli(time).atZone(zone)
        AppTimePicker(local.hour, local.minute, { pickTime = false }) { h, m ->
            onTime(local.withHour(h).withMinute(m).withSecond(0).toInstant().toEpochMilli())
        }
    }
}

@Composable
private fun DatePiece(title: String, value: String, opens: Boolean, shape: RoundedCornerShape, tag: String, modifier: Modifier, grow: Boolean = false, onClick: () -> Unit) {
    val s = MaterialTheme.colorScheme
    Row(modifier.fillMaxHeight().clip(shape).background(s.surfaceContainerLowest).let { if (opens) it.clickable(onClick = onClick) else it }
        .heightIn(min = 72.dp).padding(start = 16.dp, end = if (opens) 8.dp else 16.dp, top = 8.dp, bottom = 8.dp).semantics { testTag = tag },
        verticalAlignment = Alignment.CenterVertically) {
        // Only Date grows; Time is as wide as its words (Figma: Date fills, Time hugs).
        Column(if (grow) Modifier.weight(1f) else Modifier) {
            Text(title, style = AppType.titleMedium, color = s.onSurface, maxLines = 1)
            Text(value, style = AppType.bodyMedium, color = s.onSurfaceVariant, maxLines = 1)
        }
        if (opens) {
            Spacer(Modifier.width(8.dp))
            Icon(Symbols.ChevronRight, null, tint = s.onSurfaceVariant)
        }
    }
}

/**
 * A line under the fields (Figma's Footer: Body Small On surface variant, 16 in); what's wrong with what was typed
 * ("Enter more than zero.") is in Error, as Figma's Error variant draws it. The field itself never turns red (A65).
 */
@Composable
fun Footer(text: String, modifier: Modifier = Modifier, problem: Boolean = false) {
    val s = MaterialTheme.colorScheme
    Text(text, modifier.fillMaxWidth().padding(horizontal = 16.dp).semantics { testTag = "record-footer" }, style = AppType.bodySmall,
        color = if (problem) s.error else s.onSurfaceVariant)
}

/** The label above a card ("Amount", "How long": Figma's Label, Label Large On surface variant, 16 in, 8 above). */
@Composable
fun SectionTitle(text: String) =
    Text(text, Modifier.padding(start = 16.dp, top = 8.dp), style = AppType.labelLarge, color = MaterialTheme.colorScheme.onSurfaceVariant)

/**
 * The one main action (Figma's Bottom bar: 12 above and below, 16 at the sides): a Medium Filled [AppButton] (56) the
 * full width, riding above the keyboard (U18).
 */
@Composable
fun BottomAction(text: String, enabled: Boolean, tag: String = "record-add", onClick: () -> Unit) =
    AppButton(text, onClick, Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 12.dp), size = ButtonSize.Medium, enabled = enabled, tag = tag)

/**
 * A saved record's two actions (Figma's Bottom bar in View: 12 above and below, 16 at the sides, 8 apart): "Delete
 * [noun]", a Medium Outlined [AppButton] in Error (D9), and "Edit", Medium Filled; each half the width.
 */
@Composable
fun DeleteEditBar(noun: String, deleteTag: String, editTag: String, onDelete: () -> Unit, onEdit: () -> Unit) {
    Row(Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 12.dp), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
        AppButton("Delete $noun", onDelete, Modifier.weight(1f), style = ButtonStyle.Outlined, size = ButtonSize.Medium, destructive = true, tag = deleteTag)
        AppButton("Edit", onEdit, Modifier.weight(1f), size = ButtonSize.Medium, tag = editTag)
    }
}

private val Int.sp get() = androidx.compose.ui.unit.TextUnit(this.toFloat(), androidx.compose.ui.unit.TextUnitType.Sp)
