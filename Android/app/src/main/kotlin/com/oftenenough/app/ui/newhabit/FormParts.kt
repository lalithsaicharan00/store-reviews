package com.oftenenough.app.ui.newhabit

import com.oftenenough.app.ui.theme.AppType

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.imePadding
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.ArrowBack
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowRight
import androidx.compose.material.icons.outlined.Flag
import androidx.compose.material.icons.rounded.Add
import androidx.compose.material.icons.rounded.Check
import androidx.compose.material.icons.rounded.Close
import androidx.compose.material.icons.rounded.Remove
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Checkbox
import androidx.compose.material3.CheckboxDefaults
import androidx.compose.material3.DatePicker
import androidx.compose.material3.DatePickerDialog
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.RadioButton
import androidx.compose.material3.RadioButtonDefaults
import androidx.compose.material3.SegmentedButton
import androidx.compose.material3.SegmentedButtonDefaults
import androidx.compose.material3.SelectableDates
import androidx.compose.material3.SingleChoiceSegmentedButtonRow
import androidx.compose.material3.Surface
import androidx.compose.material3.Switch
import androidx.compose.material3.SwitchDefaults
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TimePicker
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.material3.rememberDatePickerState
import androidx.compose.material3.rememberTimePickerState
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.ui.components.Segment
import com.oftenenough.app.ui.record.dayToUtcMs
import com.oftenenough.app.ui.record.utcMsToDay
import com.oftenenough.app.ui.theme.appColors
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.Locale

/** "12 Oct 2026": the date on a pill. */
fun pillDate(day: Int): String = LocalDate.ofEpochDay(day.toLong()).format(DateTimeFormatter.ofPattern("d MMM yyyy", Locale.getDefault()))

/**
 * A page the form opens: ← and its title, the habit's sentence as a chip (the same one the form shows, so the result of
 * each choice is read here), then its content. Back returns to the form, keeping what was chosen.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun FormPage(
    title: String, chip: String?, onBack: () -> Unit, close: Boolean = false, actions: @Composable () -> Unit = {},
    scrolls: Boolean = true, content: @Composable ColumnScope.() -> Unit,
) {
    BackHandler(onBack = onBack)
    Column(Modifier.fillMaxSize().background(appColors.screen).imePadding()) {
        TopAppBar(
            title = { Text(title, style = AppType.titleLargeEmphasized, maxLines = 1, overflow = androidx.compose.ui.text.style.TextOverflow.Ellipsis) },
            navigationIcon = {
                IconButton(onBack, Modifier.semantics { testTag = "page-back" }) {
                    if (close) Icon(Icons.Rounded.Close, "Close") else Icon(Icons.AutoMirrored.Rounded.ArrowBack, "Back")
                }
            },
            actions = { actions() },
            colors = TopAppBarDefaults.topAppBarColors(containerColor = appColors.screen, titleContentColor = appColors.ink, navigationIconContentColor = appColors.ink),
        )
        val body = Modifier.fillMaxWidth().semantics { testTag = "page-body" }.let { if (scrolls) it.verticalScroll(rememberScrollState()) else it.weight(1f) }
        Column(body.padding(horizontal = 16.dp).navigationBarsPadding()) {
            if (chip != null) SentenceChip(chip)
            content()
            Spacer(Modifier.height(24.dp))
        }
    }
}

/** The habit's sentence, pinned at the top of a page ("⚑ Every Mon, Wed and Fri"). */
@Composable
fun SentenceChip(text: String) {
    Surface(Modifier.padding(top = 4.dp, bottom = 8.dp).semantics { testTag = "screen-sentence" }, shape = RoundedCornerShape(8.dp), color = appColors.tonal) {
        Row(Modifier.padding(horizontal = 12.dp, vertical = 8.dp), verticalAlignment = Alignment.CenterVertically) {
            Icon(Icons.Outlined.Flag, null, Modifier.size(18.dp), tint = appColors.ink)
            Spacer(Modifier.width(8.dp))
            Text(text, style = AppType.labelLarge, color = appColors.ink)
        }
    }
}

/** A grey heading over a group of rows ("In total", "Pick one or more"). */
@Composable
fun GroupTitle(text: String) =
    Text(text, Modifier.padding(start = 16.dp, top = 16.dp, bottom = 8.dp), style = AppType.labelLarge, color = appColors.secondary)

@Composable
fun Note(text: String) =
    Text(text, Modifier.padding(start = 16.dp, end = 16.dp, top = 8.dp, bottom = 8.dp), style = MaterialTheme.typography.bodyMedium, color = appColors.secondary)

/** One choice of several: a radio button, its words, and a line under them. */
@Composable
fun RadioRow(title: String, selected: Boolean, index: Int, count: Int, tag: String, detail: String? = null, onClick: () -> Unit) {
    Segment(index, count, Modifier.semantics { testTag = tag }, onClick = onClick) {
        RadioButton(selected, onClick = null, colors = RadioButtonDefaults.colors(selectedColor = appColors.ink, unselectedColor = appColors.secondary))
        Spacer(Modifier.width(16.dp))
        Column(Modifier.weight(1f)) {
            Text(title, style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
            if (detail != null) Text(detail, style = MaterialTheme.typography.bodyMedium, color = appColors.secondary)
        }
    }
}

/** One of any number: a checkbox, its words, and a line under them. */
@Composable
fun CheckRow(title: String, checked: Boolean, index: Int, count: Int, tag: String, detail: String? = null, onClick: () -> Unit) {
    Segment(index, count, Modifier.semantics { testTag = tag }, onClick = onClick) {
        Checkbox(checked, onCheckedChange = null, colors = CheckboxDefaults.colors(checkedColor = appColors.ink, checkmarkColor = appColors.onInk, uncheckedColor = appColors.secondary))
        Spacer(Modifier.width(16.dp))
        Column(Modifier.weight(1f)) {
            Text(title, style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
            if (detail != null) Text(detail, style = MaterialTheme.typography.bodyMedium, color = appColors.secondary)
        }
    }
}

/** "+ New group", "+ Add step". */
@Composable
fun AddRow(title: String, index: Int, count: Int, tag: String, onClick: () -> Unit) {
    Segment(index, count, Modifier.semantics { testTag = tag }, onClick = onClick) {
        Icon(Icons.Rounded.Add, null, tint = appColors.ink)
        Spacer(Modifier.width(24.dp))
        Text(title, style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
    }
}

/** A form row that opens a page: its icon, the setting, what's chosen under it, ›. */
@Composable
fun OpenRow(title: String, value: String, icon: ImageVector, index: Int, count: Int, tag: String, onClick: () -> Unit) {
    Segment(index, count, Modifier.semantics(mergeDescendants = true) { testTag = tag; contentDescription = "$title, $value" }, onClick = onClick) {
        Icon(icon, null, tint = appColors.secondary)
        Spacer(Modifier.width(24.dp))
        Column(Modifier.weight(1f).padding(vertical = 6.dp)) {
            Text(title, style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
            Text(value, style = MaterialTheme.typography.bodyMedium, color = appColors.secondary)
        }
        Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = appColors.secondary)
    }
}

/** A row with a switch at its end ("Time", "Remind me"). */
@Composable
fun SwitchRow(title: String, checked: Boolean, index: Int, count: Int, tag: String, icon: ImageVector? = null, onChange: (Boolean) -> Unit) {
    Segment(index, count, Modifier.semantics { testTag = tag }, onClick = { onChange(!checked) }) {
        if (icon != null) { Icon(icon, null, tint = appColors.secondary); Spacer(Modifier.width(24.dp)) }
        Text(title, Modifier.weight(1f), style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
        InkSwitch(checked)
    }
}

/** Material's switch in ink, with a ✓ in its thumb when on (the design's switches). */
@Composable
fun InkSwitch(checked: Boolean, onChange: ((Boolean) -> Unit)? = null) {
    val c = appColors
    Switch(checked, onCheckedChange = onChange,
        thumbContent = if (checked) { { Icon(Icons.Rounded.Check, null, Modifier.size(SwitchDefaults.IconSize), tint = c.ink) } } else null,
        colors = SwitchDefaults.colors(checkedTrackColor = c.ink, checkedThumbColor = c.onInk, checkedBorderColor = c.ink,
            uncheckedTrackColor = c.tonal, uncheckedThumbColor = c.secondary, uncheckedBorderColor = c.secondary))
}

/** − [number] +: small nudges, and the number itself can be typed ("100 times a year" isn't 97 taps). */
@Composable
fun NumberRow(title: String, value: Int, range: IntRange, index: Int, count: Int, tag: String, unit: (Int) -> String = { "" }, onChange: (Int) -> Unit) {
    Segment(index, count, Modifier.semantics { testTag = tag }) {
        Text(title, Modifier.weight(1f), style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
        StepButton(Icons.Rounded.Remove, "Fewer", value > range.first) { onChange(maxOf(range.first, value - 1)) }
        BasicTextField(
            value.toString(), { text -> text.filter { it.isDigit() }.take(5).toIntOrNull()?.let { onChange(it.coerceIn(range)) } },
            Modifier.widthIn(min = 40.dp, max = 64.dp).semantics { contentDescription = title },
            textStyle = AppType.titleMedium.copy(color = appColors.ink, textAlign = TextAlign.Center),
            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number), singleLine = true, cursorBrush = SolidColor(appColors.ink),
        )
        StepButton(Icons.Rounded.Add, "More", value < range.last) { onChange(minOf(range.last, value + 1)) }
        val words = unit(value)
        if (words.isNotEmpty()) Text(words, Modifier.padding(start = 4.dp), style = MaterialTheme.typography.bodyLarge, color = appColors.secondary)
    }
}

@Composable
fun StepButton(icon: ImageVector, label: String, enabled: Boolean, size: Int = 40, onClick: () -> Unit) {
    Box(Modifier.size(48.dp).clip(CircleShape).clickable(enabled = enabled, onClick = onClick).semantics { contentDescription = label }, contentAlignment = Alignment.Center) {
        Box(Modifier.size(size.dp).clip(CircleShape).background(appColors.tonal), contentAlignment = Alignment.Center) {
            Icon(icon, null, tint = if (enabled) appColors.ink else appColors.secondary.copy(alpha = 0.4f))
        }
    }
}

/** Week | Month | Year, and the like: one choice from a few, side by side. */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun <T> Segments(options: List<Pair<T, String>>, selected: T, tag: String, modifier: Modifier = Modifier, onPick: (T) -> Unit) {
    SingleChoiceSegmentedButtonRow(modifier.fillMaxWidth().semantics { testTag = tag }) {
        options.forEachIndexed { i, (value, label) ->
            SegmentedButton(
                selected = value == selected, onClick = { onPick(value) }, shape = SegmentedButtonDefaults.itemShape(i, options.size),
                colors = SegmentedButtonDefaults.colors(activeContainerColor = appColors.ink, activeContentColor = appColors.onInk,
                    inactiveContainerColor = appColors.surface, inactiveContentColor = appColors.ink),
            ) { Text(label, maxLines = 1) }
        }
    }
}

/** S M T W T F S, in the person's week order: tap to choose any number. */
@Composable
fun WeekdayCircles(selected: Set<Int>, weekStart: Int, tag: String, onChange: (Set<Int>) -> Unit) {
    val letters = listOf("S", "M", "T", "W", "T", "F", "S")
    Row(Modifier.fillMaxWidth().semantics { testTag = tag }, horizontalArrangement = Arrangement.SpaceBetween) {
        for (i in 0 until 7) {
            val day = (weekStart - 1 + i) % 7 + 1
            val on = day in selected
            Box(Modifier.size(40.dp).clip(CircleShape).background(if (on) appColors.ink else appColors.tonal)
                .clickable { onChange(if (on) selected - day else selected + day) }
                .semantics { contentDescription = com.oftenenough.app.data.HabitCopy.fullDays[day - 1] + if (on) ", chosen" else "" },
                contentAlignment = Alignment.Center) {
                Text(letters[day - 1], color = if (on) appColors.onInk else appColors.ink, style = MaterialTheme.typography.titleSmall)
            }
        }
    }
}

/** A pill-shaped choice ("Weekdays", "10 min"). */
@Composable
fun ChoicePill(text: String, selected: Boolean = false, tag: String? = null, onClick: () -> Unit) {
    val c = appColors
    Box(Modifier.clip(RoundedCornerShape(10.dp)).background(if (selected) c.ink else Color.Transparent)
        .border(1.dp, if (selected) c.ink else c.outline, RoundedCornerShape(10.dp)).clickable(onClick = onClick)
        .let { m -> tag?.let { t -> m.semantics { testTag = t } } ?: m }
        .heightIn(min = 40.dp).padding(horizontal = 16.dp, vertical = 8.dp), contentAlignment = Alignment.Center) {
        Text((if (selected) "✓  " else "") + text, style = AppType.labelLarge, color = if (selected) c.onInk else c.ink)
    }
}

/** Android's date picker in its dialog; [allowed] limits the days. */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun DayDialog(day: Int, allowed: (Int) -> Boolean, onDismiss: () -> Unit, onPick: (Int) -> Unit) {
    val state = rememberDatePickerState(initialSelectedDateMillis = dayToUtcMs(day), selectableDates = object : SelectableDates {
        override fun isSelectableDate(utcTimeMillis: Long) = allowed(utcMsToDay(utcTimeMillis))
    })
    DatePickerDialog(onDismiss, confirmButton = {
        TextButton({ state.selectedDateMillis?.let { onPick(utcMsToDay(it)) }; onDismiss() }, Modifier.semantics { testTag = "date-ok" }) { Text("OK", color = appColors.ink) }
    }, dismissButton = { TextButton(onDismiss) { Text("Cancel", color = appColors.ink) } }) { DatePicker(state) }
}

/** Android's time picker in a dialog: minutes of the day in and out. */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MinuteDialog(minute: Int, onDismiss: () -> Unit, onPick: (Int) -> Unit) {
    val state = rememberTimePickerState(minute / 60 % 24, minute % 60, DayWords.is24Hour)
    AlertDialog(onDismiss, confirmButton = {
        TextButton({ onPick(state.hour * 60 + state.minute); onDismiss() }, Modifier.semantics { testTag = "time-ok" }) { Text("OK", color = appColors.ink) }
    }, dismissButton = { TextButton(onDismiss) { Text("Cancel", color = appColors.ink) } },
        text = { Box(Modifier.fillMaxWidth(), contentAlignment = Alignment.Center) { TimePicker(state) } })
}
