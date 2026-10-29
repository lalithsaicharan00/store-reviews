package com.oftenenough.app.ui.components

import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.TimeInput
import androidx.compose.material3.TimeInputDefaults
import androidx.compose.material3.TimePicker
import androidx.compose.material3.TimePickerDefaults
import androidx.compose.material3.TimePickerDialog
import androidx.compose.material3.TimePickerDialogDefaults
import androidx.compose.material3.TimePickerDisplayMode
import androidx.compose.material3.rememberTimePickerState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.ExperimentalComposeUiApi
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.semantics.testTagsAsResourceId
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.ui.theme.AppType

/**
 * 5.3.5, **Time picker** (Figma 703:602; Components — Atoms Build Plan): Android's time picker in its typed mode, the
 * one a log's Time field opens.
 *
 * Material's own `TimePickerDialog` and `TimeInput` (the dial, `TimePicker`, a tap away on the clock icon): corners
 * 28, 24 in all round; "Enter time" ("Select time" on the dial) in Label Medium On surface variant, 16; the hours and
 * minutes fields (96 × 72, corners 8) on Surface container highest in Display Medium On surface, the focused one with
 * Material's 2 dp Primary outline; AM / PM (52 × 72, corners 8, 1 dp Outline), the chosen half Primary with an On
 * primary label, the other On surface variant (Material's Tertiary container has no hue in our scheme, so it takes
 * the date picker's Primary, as Figma says); 24; the clock icon, then Cancel and OK, Small Text buttons On surface
 * variant. On Surface bright, as Figma fills it and as the Dialog (5.3.4). The phone's own 12 or 24 hours. The dial
 * isn't drawn in Figma: Material's colours there, but the same container and AM / PM.
 * [onPick] gets the hour (0–23) and minute; [okTag] names OK for the tests.
 */
@OptIn(ExperimentalMaterial3Api::class, ExperimentalComposeUiApi::class)
@Composable
fun AppTimePicker(hour: Int, minute: Int, onDismiss: () -> Unit, okTag: String = "picker-ok", onPick: (hour: Int, minute: Int) -> Unit) {
    val s = MaterialTheme.colorScheme
    val state = rememberTimePickerState(hour, minute, DayWords.is24Hour)
    var typed by rememberSaveable { mutableStateOf(true) }
    val mode = if (typed) TimePickerDisplayMode.Input else TimePickerDisplayMode.Picker
    // The dial isn't drawn in Figma: Material's own colours, with the dialog's container and Figma's AM / PM.
    val colors = TimePickerDefaults.colors(
        containerColor = s.surfaceBright,
        periodSelectorBorderColor = s.outline,
        periodSelectorSelectedContainerColor = s.primary,
        periodSelectorContainerColor = Color.Transparent,
        periodSelectorSelectedContentColor = s.onPrimary,
        periodSelectorContentColor = s.onSurfaceVariant,
    )
    // The typed fields are Material's text fields (1.5): Surface container highest whether focused or not, On surface.
    val fields = TimeInputDefaults.colors().timeTextFieldColors.copy(
        focusedContainerColor = s.surfaceContainerHighest, unfocusedContainerColor = s.surfaceContainerHighest,
        focusedTextColor = s.onSurface, unfocusedTextColor = s.onSurface,
    )
    val inputColors = TimeInputDefaults.colors(
        containerColor = s.surfaceBright,
        periodSelectorBorderColor = s.outline,
        periodSelectorSelectedContainerColor = s.primary,
        periodSelectorContainerColor = Color.Transparent,
        periodSelectorSelectedContentColor = s.onPrimary,
        periodSelectorContentColor = s.onSurfaceVariant,
        timeTextFieldColors = fields,
    )
    TimePickerDialog(
        onDismissRequest = onDismiss,
        confirmButton = { AppButton("OK", { onPick(state.hour, state.minute); onDismiss() }, style = ButtonStyle.Text, tag = okTag) },
        title = {
            Text(if (typed) "Enter time" else "Select time", style = AppType.labelMedium, color = s.onSurfaceVariant)
        },
        modifier = Modifier.semantics { testTag = "time-picker"; testTagsAsResourceId = true },
        modeToggleButton = {
            TimePickerDialogDefaults.DisplayModeToggle({ typed = !typed }, mode)
        },
        dismissButton = { AppButton("Cancel", onDismiss, style = ButtonStyle.Text) },
        containerColor = s.surfaceBright,
    ) {
        if (typed) TimeInput(state, colors = inputColors) else TimePicker(state, colors = colors)
    }
}
