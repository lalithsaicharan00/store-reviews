package com.oftenenough.app.ui.newhabit

import com.oftenenough.app.ui.components.AppDatePicker
import com.oftenenough.app.ui.components.AppTimePicker
import com.oftenenough.app.ui.components.DayToggle
import com.oftenenough.app.ui.components.ListChevron
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.AppSwitch
import com.oftenenough.app.ui.components.AppFilledIconButton
import com.oftenenough.app.ui.components.AppCheckbox
import com.oftenenough.app.ui.components.AppTopBar
import com.oftenenough.app.ui.theme.AppType

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.imePadding
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.RadioButton
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
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
        AppTopBar(
            title,
            navigationIcon = {
                IconButton(onBack, Modifier.semantics { testTag = "page-back" }) {
                    if (close) Icon(Symbols.Close, "Close") else Icon(Symbols.ArrowBack, "Back")
                }
            },
            actions = { actions() },
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
            Icon(Symbols.Flag, null, Modifier.size(18.dp), tint = appColors.ink)
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
    Text(text, Modifier.padding(start = 16.dp, end = 16.dp, top = 8.dp, bottom = 8.dp), style = AppType.bodySmall, color = appColors.secondary)

/** One choice of several: a radio button, its words, and a line under them (List item, 2.4). */
@Composable
fun RadioRow(title: String, selected: Boolean, index: Int, count: Int, tag: String, detail: String? = null, onClick: () -> Unit) =
    AppListItem(title, index, count, supporting = detail, leading = { RadioButton(selected, onClick = null) }, onClick = onClick, tag = tag)

/** One of any number: a checkbox, its words, and a line under them (List item, 2.4). */
@Composable
fun CheckRow(title: String, checked: Boolean, index: Int, count: Int, tag: String, detail: String? = null, indent: Boolean = false, onClick: () -> Unit) =
    AppListItem(title, index, count, supporting = detail, onClick = onClick, tag = tag, leading = {
        Row(verticalAlignment = Alignment.CenterVertically) { if (indent) Spacer(Modifier.width(36.dp)); AppCheckbox(checked, onCheckedChange = null) }
    })

/** "+ New group", "+ Add step" (List item, 2.4). */
@Composable
fun AddRow(title: String, index: Int, count: Int, tag: String, indent: Boolean = false, onClick: () -> Unit) =
    AppListItem(title, index, count, onClick = onClick, tag = tag, leading = {
        Row(verticalAlignment = Alignment.CenterVertically) { if (indent) Spacer(Modifier.width(36.dp)); Icon(Symbols.Add, null) }
    })

/**
 * A row that opens a page: the setting, what's chosen under it, › (List item, 2.4; Figma 2.1: Title Medium over Body
 * Medium). The habit form's rows have no icon; a settings row keeps its icon.
 */
@Composable
fun OpenRow(
    title: String, value: String, icon: ImageVector?, index: Int, count: Int, tag: String,
    containerColor: androidx.compose.ui.graphics.Color = androidx.compose.ui.graphics.Color.Unspecified, onClick: () -> Unit,
) = AppListItem(
        title, index, count, Modifier.semantics(mergeDescendants = true) { contentDescription = "$title, $value" }, value,
        leading = icon?.let { { Icon(it, null) } }, trailing = { ListChevron() }, onClick = onClick, containerColor = containerColor, tag = tag,
    )

/** A row with a switch at its end ("Time", "Remind me"); the whole row is the toggle (List item, 2.4). */
@Composable
fun SwitchRow(title: String, checked: Boolean, index: Int, count: Int, tag: String, icon: ImageVector? = null, onChange: (Boolean) -> Unit) =
    AppListItem(title, index, count, leading = icon?.let { { Icon(it, null) } }, trailing = { AppSwitch(checked) },
        onClick = { onChange(!checked) }, tag = tag)

/** − [number] +: small nudges, and the number itself can be typed ("100 times a year" isn't 97 taps). */
@Composable
fun NumberRow(title: String, value: Int, range: IntRange, index: Int, count: Int, tag: String, unit: (Int) -> String = { "" }, onChange: (Int) -> Unit) =
    AppListItem(title, index, count, tag = tag, trailing = {
        Row(verticalAlignment = Alignment.CenterVertically) {
            StepButton(Symbols.Remove, "Fewer", value > range.first) { onChange(maxOf(range.first, value - 1)) }
            BasicTextField(
                value.toString(), { text -> text.filter { it.isDigit() }.take(5).toIntOrNull()?.let { onChange(it.coerceIn(range)) } },
                Modifier.widthIn(min = 40.dp, max = 64.dp).semantics { contentDescription = title },
                textStyle = AppType.titleMedium.copy(color = appColors.ink, textAlign = TextAlign.Center),
                keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number), singleLine = true, cursorBrush = SolidColor(appColors.ink),
            )
            StepButton(Symbols.Add, "More", value < range.last) { onChange(minOf(range.last, value + 1)) }
            val words = unit(value)
            if (words.isNotEmpty()) Text(words, Modifier.padding(start = 4.dp), style = AppType.bodyLarge, color = appColors.secondary)
        }
    })

/** A number's − or +: the neutral filled icon button (2.2), switched off at the end of its range. */
@Composable
fun StepButton(icon: ImageVector, label: String, enabled: Boolean, onClick: () -> Unit) = AppFilledIconButton(icon, label, onClick, enabled = enabled)

/** S M T W T F S, in the person's week order, spread across the row: tap to choose any number (Day toggle, 2.7). */
@Composable
fun WeekdayCircles(selected: Set<Int>, weekStart: Int, tag: String, onChange: (Set<Int>) -> Unit) {
    val letters = listOf("S", "M", "T", "W", "T", "F", "S")
    Row(Modifier.fillMaxWidth().semantics { testTag = tag }, horizontalArrangement = Arrangement.SpaceBetween) {
        for (i in 0 until 7) {
            val day = (weekStart - 1 + i) % 7 + 1
            DayToggle(letters[day - 1], day in selected, { on -> onChange(if (on) selected + day else selected - day) },
                com.oftenenough.app.data.HabitCopy.fullDays[day - 1])
        }
    }
}

/**
 * The Date picker (5.3.6, [AppDatePicker]); [allowed] limits the days. Figma 2.1.7, 3.1.1, 4.3: its title says what's
 * being chosen ("Starts", "Started", "Select date"), and a [note] under the day says what it does.
 */
@Composable
fun DayDialog(day: Int, allowed: (Int) -> Boolean, onDismiss: () -> Unit, title: String = "Select date", note: String? = null, onPick: (Int) -> Unit) =
    AppDatePicker(day, allowed, onDismiss, title, confirmTag = "date-ok", note = note, onPick = onPick)

/** The Time picker (5.3.5, [AppTimePicker]) with minutes of the day in and out. */
@Composable
fun MinuteDialog(minute: Int, onDismiss: () -> Unit, onPick: (Int) -> Unit) =
    AppTimePicker(minute / 60 % 24, minute % 60, onDismiss, okTag = "time-ok") { h, m -> onPick(h * 60 + m) }
