package com.oftenenough.app.ui.habit

import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.AppBottomSheet
import com.oftenenough.app.ui.components.RadioListItem
import androidx.compose.runtime.getValue
import androidx.compose.runtime.setValue
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitCopy
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.newhabit.DayDialog
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors

/**
 * The Habits page's Pause… (Figma 2106:2, 2.3–2.3.3, 2.7, 3.4): a sheet over the list, from today, for 1 week, 2 weeks,
 * until a date (tomorrow and later) or until resumed. A quit habit's sheet says first that its current run ends and is
 * kept. [onPaused] gets the day each habit is back (null: until resumed) once Pause is tapped.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun PauseSheet(habits: List<Habit>, store: HabitStore, onDismiss: () -> Unit, onPaused: (back: Int?) -> Unit) {
    val c = appColors
    val today = store.today()
    var length by rememberSaveable { mutableStateOf(PauseLength.WEEK) }
    var chosen by rememberSaveable { mutableStateOf<Int?>(null) }
    var picking by rememberSaveable { mutableStateOf(false) }
    val one = habits.size == 1
    val name = if (one) habits[0].name else "${habits.size} habits"
    AppBottomSheet(
        onDismiss, Modifier.semantics { testTag = "pause-sheet"; testTagsAsResourceId = true }, title = "Pause $name",
        actions = {
            AppButton("Cancel", onDismiss, Modifier.semantics { testTag = "pause-cancel" }, style = ButtonStyle.Text)
            AppButton("Pause", {
                val back = when (length) {
                    PauseLength.WEEK -> today + 7
                    PauseLength.TWO_WEEKS -> today + 14
                    PauseLength.DATE -> chosen ?: (today + 7)
                    PauseLength.OPEN -> null
                }
                for (h in habits) store.pause(h, today, back?.let { it - 1 })
                onPaused(back)
            }, Modifier.semantics { testTag = "confirm-pause" })
        },
    ) {
        Text(pauseSheetWords(habits, store), Modifier.padding(horizontal = 16.dp).padding(bottom = 8.dp), style = AppType.bodyMedium, color = c.secondary)
        PauseOption("1 week", "Back on " + DayWords.short(today + 7), length == PauseLength.WEEK, "pause-week") { length = PauseLength.WEEK }
        PauseOption("2 weeks", "Back on " + DayWords.short(today + 14), length == PauseLength.TWO_WEEKS, "pause-two-weeks") { length = PauseLength.TWO_WEEKS }
        PauseOption("Until a date…", chosen?.let { "Back on " + DayWords.short(it) } ?: "Pick the day it comes back", length == PauseLength.DATE, "pause-date") {
            picking = true
        }
        PauseOption("Until I resume it", "It waits in Paused", length == PauseLength.OPEN, "pause-open") { length = PauseLength.OPEN }
    }
    if (picking) {
        DayDialog(chosen ?: (today + 7), { it > today }, { picking = false }) { day -> chosen = day; length = PauseLength.DATE }
    }
}

@Composable
private fun PauseOption(title: String, line: String, selected: Boolean, tag: String, onClick: () -> Unit) =
    RadioListItem(title, selected, onClick, supporting = line, tag = tag)

/** What pausing does, said before it's tapped (Figma 2.3, 2.7, 3.4). */
fun pauseSheetWords(habits: List<Habit>, store: HabitStore): String {
    if (habits.size == 1) {
        val h = habits[0]
        if (h.kind == HabitKind.Quit) {
            val days = (store.rules.quitRuns(h).first / 86_400).toInt()
            val run = if (days >= 1) "your current run of $days ${if (days == 1) "day" else "days"}" else "your current run"
            return "Pausing ends $run. It stays in your history, and a new run starts when you resume. While it's paused, ${h.name} is off Today."
        }
        return "While ${h.name} is paused, it's off Today and sends no reminders. Paused days never break a streak."
    }
    var text = "While they're paused, ${HabitCopy.join(habits.map { it.name })} are off Today and send no reminders. Paused days never break a streak."
    if (habits.any { it.kind == HabitKind.Quit }) text += " A quit habit's current run ends and is kept; a new one starts when it's resumed."
    return text
}
