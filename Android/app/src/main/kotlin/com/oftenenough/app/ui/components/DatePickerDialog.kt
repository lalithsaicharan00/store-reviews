package com.oftenenough.app.ui.components

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.DatePicker
import androidx.compose.material3.DatePickerDefaults
import androidx.compose.material3.BasicAlertDialog
import androidx.compose.material3.Surface
import androidx.compose.material3.DisplayMode
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.foundation.layout.heightIn
import com.oftenenough.app.ui.theme.Symbols
import androidx.compose.material3.LocalMinimumInteractiveComponentSize
import androidx.compose.foundation.layout.BoxWithConstraints
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.wrapContentHeight
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.ui.Alignment
import androidx.compose.ui.window.DialogProperties
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.SelectableDates
import androidx.compose.material3.Text
import androidx.compose.material3.rememberDatePickerState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.height
import androidx.compose.ui.ExperimentalComposeUiApi
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.theme.AppType
import java.time.Instant
import java.time.LocalDate
import java.time.ZoneOffset
import java.time.format.DateTimeFormatter

/** A day number's midnight in UTC, as Material's date picker counts days; and back. */
fun dayToUtcMs(day: Int): Long = LocalDate.ofEpochDay(day.toLong()).atStartOfDay(ZoneOffset.UTC).toInstant().toEpochMilli()
fun utcMsToDay(ms: Long): Int = Instant.ofEpochMilli(ms).atZone(ZoneOffset.UTC).toLocalDate().toEpochDay().toInt()

/**
 * 5.3.6, **Date picker** (Figma 705:1025; Components — Atoms Build Plan): Android's date picker in its calendar mode,
 * what a log's Date field opens.
 *
 * Material's own `DatePicker` in its dialog's parts, 16 in from the screen's sides up to Material's 360 (six week rows always, so the height never jumps; the ✏ to type a
 * date): corners 28, on Surface bright; the header 24 in, 16 above: [title] ("Select date") in Label Large On surface
 * variant, 16, the chosen day ("Wed, 21 Oct", the phone's language) in Headline Large On surface, and a [note] under it
 * when it says what the day does; a divider in Outline variant; the month ("October 2026" ▾) and ‹ › in On surface
 * variant; the weekdays and days in Body Large On surface, each day a 40 dp circle, the chosen one Primary with an On
 * primary label; days [allowed] says no to (Figma's Limit: Any day · Today and earlier · Tomorrow and later · Today and
 * later) sit in Outline and can't be tapped; Cancel and [confirm] ("OK"), Small Text buttons On surface variant.
 * [onPick] gets the chosen day. With [atOnce] there are no buttons: tapping a day goes there at once (nothing is saved,
 * so there's nothing to confirm), and tapping outside or Back closes it; the calendar keeps 20 under its weeks.
 *
 * With no [day] (null), nothing is chosen when it opens (Material's own empty state: today only ringed, the headline
 * "Selected date" in On surface variant) and [confirm] stays off until a day is picked, so nothing lands on a day by
 * default (History's Add, A81). [confirmFor] names the button after the day picked ("Open Tue 8 Sep").
 */
@OptIn(ExperimentalMaterial3Api::class, ExperimentalComposeUiApi::class)
@Composable
fun AppDatePicker(
    day: Int?,
    allowed: (Int) -> Boolean,
    onDismiss: () -> Unit,
    title: String = "Select date",
    confirm: String = "OK",
    confirmTag: String? = "picker-ok",
    note: String? = null,
    confirmFor: ((Int?) -> String)? = null,
    dismissTag: String? = null,
    /** Go to a day: one tap on a day picks it and closes, with no Cancel or [confirm] (Figma's Today, flow 32). */
    atOnce: Boolean = false,
    onPick: (Int) -> Unit,
) {
    val s = MaterialTheme.colorScheme
    val state = rememberDatePickerState(initialSelectedDateMillis = day?.let(::dayToUtcMs), selectableDates = object : SelectableDates {
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
    // Material's DatePickerDialog, put together from its own parts so it keeps 16 from each side of the screen, up to
    // Material's 360 (Figma 705:1025: 328 on a 360 dp phone). Material's own dialog always takes 360, which touches both
    // edges of such a phone. Its buttons as Material places them: 6 from the end, 8 from the bottom, 8 apart.
    BasicAlertDialog(onDismiss, Modifier.semantics { testTag = "date-picker"; testTagsAsResourceId = true },
        properties = DialogProperties(usePlatformDefaultWidth = false)) {
        Surface(Modifier.padding(horizontal = 16.dp).widthIn(max = 360.dp).fillMaxWidth().wrapContentHeight(), shape = RoundedCornerShape(28.dp), color = s.surfaceBright) {
            BoxWithConstraints { val room = maxWidth; Column {
                // Material's grid gives each day its 48 dp touch target and 12 at each side, which needs 360. Narrower
                // (a 360 dp phone, 16 in from each side), each day takes a seventh of the room instead, so the week fits
                // evenly as Figma draws it (40 dp days, 43 apart); from 360 up it's Material's own 48.
                val cell = ((room - 24.dp) / 7).coerceAtMost(48.dp)
                // The header as Figma draws it (16 above, 16 between, 12 below: 112 to the divider); Material's own is a
                // fixed 120. "Select date", the chosen day with ✏ to type one (📅 back to the calendar), then the divider.
                Column(Modifier.padding(start = 24.dp, end = 12.dp, top = 16.dp, bottom = 12.dp)) {
                    Text(title, style = AppType.labelLarge, color = s.onSurfaceVariant)
                    Row(Modifier.padding(top = 16.dp).heightIn(min = 48.dp), verticalAlignment = Alignment.CenterVertically) {
                        val picked = state.selectedDateMillis?.let(::utcMsToDay)
                        val locale = LocalConfiguration.current.locales[0]
                        if (picked != null) Text(LocalDate.ofEpochDay(picked.toLong()).format(DateTimeFormatter.ofPattern("EEE, d MMM", locale)),
                            Modifier.weight(1f), style = AppType.headlineLarge, color = s.onSurface, maxLines = 1)
                        else Text("Selected date", Modifier.weight(1f), style = AppType.headlineLarge, color = s.onSurfaceVariant, maxLines = 1)
                        val typing = state.displayMode == DisplayMode.Input
                        IconButton({ state.displayMode = if (typing) DisplayMode.Picker else DisplayMode.Input }) {
                            Icon(if (typing) Symbols.CalendarToday else Symbols.Edit, if (typing) "Switch to calendar input mode" else "Switch to text input mode",
                                tint = s.onSurfaceVariant)
                        }
                    }
                    // The note sits under the day (a DatePicker takes the dialog's height, so never below it).
                    if (note != null) Text(note, Modifier.padding(top = 4.dp), style = AppType.bodySmall, color = s.onSurfaceVariant)
                }
                HorizontalDivider(color = s.outlineVariant)
                CompositionLocalProvider(LocalMinimumInteractiveComponentSize provides cell) {
                    DatePicker(state, colors = colors, title = null, headline = null, showModeToggle = false)
                }
                if (atOnce) {
                    val picked = state.selectedDateMillis?.let(::utcMsToDay)
                    LaunchedEffect(picked) { if (picked != null && picked != day) { onPick(picked); onDismiss() } }
                    Spacer(Modifier.height(20.dp))
                } else Row(Modifier.align(Alignment.End).padding(bottom = 8.dp, end = 6.dp), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    AppButton("Cancel", onDismiss, style = ButtonStyle.Text, tag = dismissTag)
                    val picked = state.selectedDateMillis?.let(::utcMsToDay)
                    AppButton(confirmFor?.invoke(picked) ?: confirm, { picked?.let(onPick); onDismiss() }, style = ButtonStyle.Text,
                        enabled = picked != null, tag = confirmTag)
                }
            } }
        }
    }
}
