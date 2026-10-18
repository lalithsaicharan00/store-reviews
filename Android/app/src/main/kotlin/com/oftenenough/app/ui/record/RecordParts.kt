package com.oftenenough.app.ui.record

import com.oftenenough.app.ui.theme.AppType

import androidx.compose.foundation.background
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
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.DatePicker
import androidx.compose.material3.DatePickerDialog
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.SelectableDates
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
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
import com.oftenenough.app.ui.components.segmentShape
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
    Button(onClick, enabled = enabled, modifier = Modifier.heightIn(min = 40.dp).let { m -> tag?.let { m.semantics { testTag = it } } ?: m },
        colors = ButtonDefaults.buttonColors(containerColor = appColors.tonal, contentColor = appColors.ink)) {
        Text(text, style = MaterialTheme.typography.labelLarge)
    }
}

/** One segmented row: a label at the start and its value or control at the end. */
@Composable
fun FactRow(label: String, index: Int, count: Int, content: @Composable () -> Unit) {
    Row(Modifier.fillMaxWidth().clip(segmentShape(index, count)).background(appColors.surface).heightIn(min = 56.dp).padding(horizontal = 16.dp, vertical = 8.dp),
        verticalAlignment = Alignment.CenterVertically) {
        Text(label, Modifier.weight(1f), style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
        content()
    }
}

/** Habit · [icon] name. */
@Composable
fun HabitFact(habit: Habit, index: Int, count: Int) = FactRow("Habit", index, count) {
    HabitIcon(habit.symbol, habit.color, size = 24.dp)
    Spacer(Modifier.width(8.dp))
    Text(habit.name, style = MaterialTheme.typography.bodyLarge, color = appColors.secondary, maxLines = 1)
}

/**
 * Date ("Today" + a pill opening Android's date picker, any day in [range]) and Time (a pill opening the time picker,
 * kept inside the day by the caller). [onTime] gets the chosen clock time on [day].
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun DateTimeRows(
    day: Int, today: Int, range: IntRange, time: Long, timeTitle: String, startIndex: Int, count: Int,
    onDay: (Int) -> Unit, onTime: (Long) -> Unit, editableDay: Boolean = true,
) {
    var pickDay by remember { mutableStateOf(false) }
    var pickTime by remember { mutableStateOf(false) }
    FactRow("Date", startIndex, count) {
        DayWords.relative(day, today)?.let { Text(it, Modifier.padding(end = 12.dp), style = MaterialTheme.typography.bodyLarge, color = appColors.secondary) }
        if (editableDay) Pill(LocalDate.ofEpochDay(day.toLong()).format(dateFormat), tag = "record-date") { pickDay = true }
        else Text(DayWords.withDate(day, today), style = MaterialTheme.typography.bodyLarge, color = appColors.secondary)
    }
    FactRow(timeTitle, startIndex + 1, count) { Pill(DayWords.clock(time), tag = "record-time") { pickTime = true } }
    if (pickDay) {
        val state = rememberDatePickerState(initialSelectedDateMillis = dayToUtcMs(day), selectableDates = object : SelectableDates {
            override fun isSelectableDate(utcTimeMillis: Long) = utcMsToDay(utcTimeMillis) in range
        })
        DatePickerDialog({ pickDay = false }, confirmButton = {
            TextButton({ state.selectedDateMillis?.let { onDay(utcMsToDay(it)) }; pickDay = false }) { Text("OK", color = appColors.ink) }
        }, dismissButton = { TextButton({ pickDay = false }) { Text("Cancel", color = appColors.ink) } }) { DatePicker(state) }
    }
    if (pickTime) {
        val zone = ZoneId.systemDefault()
        val local = Instant.ofEpochMilli(time).atZone(zone)
        val state = rememberTimePickerState(local.hour, local.minute, DayWords.is24Hour)
        AlertDialog({ pickTime = false }, confirmButton = {
            TextButton({
                onTime(local.withHour(state.hour).withMinute(state.minute).withSecond(0).toInstant().toEpochMilli())
                pickTime = false
            }) { Text("OK", color = appColors.ink) }
        }, dismissButton = { TextButton({ pickTime = false }) { Text("Cancel", color = appColors.ink) } },
            text = { Box(Modifier.fillMaxWidth(), contentAlignment = Alignment.Center) { TimePicker(state) } })
    }
}

/** A footer line under a card. */
@Composable
fun Footer(text: String, modifier: Modifier = Modifier) =
    Text(text, modifier.padding(start = 16.dp, end = 16.dp, top = 8.dp), style = MaterialTheme.typography.bodyMedium, color = appColors.secondary)

/** The section heading above a card ("Amount", "How long"). */
@Composable
fun SectionTitle(text: String) =
    Text(text, Modifier.padding(start = 16.dp, top = 20.dp, bottom = 8.dp), style = AppType.labelLarge, color = appColors.secondary)

/** The one filled main action, full width at the bottom, riding above the keyboard (U18). */
@Composable
fun BottomAction(text: String, enabled: Boolean, tag: String = "record-add", onClick: () -> Unit) {
    Column(Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 12.dp), verticalArrangement = Arrangement.Bottom) {
        Button(onClick, Modifier.fillMaxWidth().heightIn(min = 56.dp).semantics { testTag = tag }, enabled = enabled,
            colors = ButtonDefaults.buttonColors(containerColor = appColors.ink, contentColor = appColors.onInk)) {
            Text(text, style = MaterialTheme.typography.titleMedium)
        }
    }
}

private val Int.sp get() = androidx.compose.ui.unit.TextUnit(this.toFloat(), androidx.compose.ui.unit.TextUnitType.Sp)
