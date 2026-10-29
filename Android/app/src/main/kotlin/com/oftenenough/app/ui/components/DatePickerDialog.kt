package com.oftenenough.app.ui.components

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.DatePicker
import androidx.compose.material3.DatePickerDefaults
import androidx.compose.material3.DatePickerDialog
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.SelectableDates
import androidx.compose.material3.Text
import androidx.compose.material3.rememberDatePickerState
import androidx.compose.runtime.Composable
import androidx.compose.ui.ExperimentalComposeUiApi
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.theme.AppType
import java.time.Instant
import java.time.LocalDate
import java.time.ZoneOffset
import java.time.format.DateTimeFormatter
import java.util.Locale

/** A day number's midnight in UTC, as Material's date picker counts days; and back. */
fun dayToUtcMs(day: Int): Long = LocalDate.ofEpochDay(day.toLong()).atStartOfDay(ZoneOffset.UTC).toInstant().toEpochMilli()
fun utcMsToDay(ms: Long): Int = Instant.ofEpochMilli(ms).atZone(ZoneOffset.UTC).toLocalDate().toEpochDay().toInt()

/**
 * 5.3.6, **Date picker** (Figma 705:1025; Components — Atoms Build Plan): Android's date picker in its calendar mode,
 * what a log's Date field opens.
 *
 * Material's own `DatePickerDialog` and `DatePicker` (six week rows always, so the height never jumps; the ✏ to type a
 * date): corners 28, on Surface bright; the header 24 in, 16 above: [title] ("Select date") in Label Large On surface
 * variant, 16, the chosen day ("Wed, 21 Oct", the phone's language) in Headline Large On surface, and a [note] under it
 * when it says what the day does; a divider in Outline variant; the month ("October 2026" ▾) and ‹ › in On surface
 * variant; the weekdays and days in Body Large On surface, each day a 40 dp circle, the chosen one Primary with an On
 * primary label; days [allowed] says no to (Figma's Limit: Any day · Today and earlier · Tomorrow and later · Today and
 * later) sit in Outline and can't be tapped; Cancel and [confirm] ("OK"), Small Text buttons On surface variant.
 * [onPick] gets the chosen day.
 */
@OptIn(ExperimentalMaterial3Api::class, ExperimentalComposeUiApi::class)
@Composable
fun AppDatePicker(
    day: Int,
    allowed: (Int) -> Boolean,
    onDismiss: () -> Unit,
    title: String = "Select date",
    confirm: String = "OK",
    confirmTag: String? = "picker-ok",
    note: String? = null,
    onPick: (Int) -> Unit,
) {
    val s = MaterialTheme.colorScheme
    val state = rememberDatePickerState(initialSelectedDateMillis = dayToUtcMs(day), selectableDates = object : SelectableDates {
        override fun isSelectableDate(utcTimeMillis: Long) = allowed(utcMsToDay(utcTimeMillis))
    })
    val colors = DatePickerDefaults.colors(
        containerColor = s.surfaceBright,
        titleContentColor = s.onSurfaceVariant,
        headlineContentColor = s.onSurface,
        weekdayContentColor = s.onSurface,
        subheadContentColor = s.onSurfaceVariant,
        navigationContentColor = s.onSurfaceVariant,
        dayContentColor = s.onSurface,
        disabledDayContentColor = s.outline,
        selectedDayContainerColor = s.primary,
        selectedDayContentColor = s.onPrimary,
        dividerColor = s.outlineVariant,
    )
    DatePickerDialog(
        onDismissRequest = onDismiss,
        confirmButton = { AppButton(confirm, { state.selectedDateMillis?.let { onPick(utcMsToDay(it)) }; onDismiss() }, style = ButtonStyle.Text, tag = confirmTag) },
        modifier = Modifier.semantics { testTag = "date-picker"; testTagsAsResourceId = true },
        dismissButton = { AppButton("Cancel", onDismiss, style = ButtonStyle.Text) },
        colors = colors,
    ) {
        DatePicker(state, colors = colors,
            title = { Text(title, Modifier.padding(start = 24.dp, end = 12.dp, top = 16.dp), style = AppType.labelLarge) },
            headline = {
                val picked = state.selectedDateMillis?.let(::utcMsToDay)
                Column(Modifier.padding(start = 24.dp, end = 12.dp, bottom = 12.dp)) {
                    Text(picked?.let { LocalDate.ofEpochDay(it.toLong()).format(DateTimeFormatter.ofPattern("EEE, d MMM", Locale.getDefault())) } ?: "",
                        style = AppType.headlineLarge, maxLines = 1)
                    // The note sits under the day: below the picker it was drawn over the title (a DatePicker takes the dialog's height).
                    if (note != null) Text(note, Modifier.padding(top = 4.dp), style = AppType.bodySmall, color = s.onSurfaceVariant)
                }
            })
    }
}
