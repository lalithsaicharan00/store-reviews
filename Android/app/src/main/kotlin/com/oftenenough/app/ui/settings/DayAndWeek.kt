package com.oftenenough.app.ui.settings

import com.oftenenough.app.ui.components.AppMenuItem
import com.oftenenough.app.ui.components.AppMenu
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.theme.Symbols
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Icon
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.HabitCopy
import com.oftenenough.app.data.HabitStore

/**
 * "New day starts at" (12:00 AM … 12:00 PM, never "Midnight") and "Week starts on" (Sunday … Saturday, Sunday by
 * default, never "Automatic"), as dropdown rows (Current Work 99): onboarding's Your days and weeks and ≡ › Day and Week.
 */
@Composable
fun DayAndWeekRows(store: HabitStore) {
    Column {
        DropdownRow("New day starts at", DayWords.clockMinute(store.dayEndHour * 60), Symbols.WbTwilight,
            (0..12).map { DayWords.clockMinute(it * 60) }, store.dayEndHour, "day-start") { store.setDayEnd(it) }
        Spacer(Modifier.padding(4.dp))
        DropdownRow("Week starts on", HabitCopy.fullDays[store.weekStart - 1], Symbols.CalendarMonth,
            HabitCopy.fullDays, store.weekStart - 1, "week-start") { store.chooseWeekStart(it + 1) }
    }
}

/** Material's exposed dropdown as a row: icon, title, the value under it, ▾; a menu that marks the chosen value. */
@Composable
fun DropdownRow(title: String, value: String, icon: ImageVector, options: List<String>, selected: Int, tag: String, onPick: (Int) -> Unit) {
    var open by remember { mutableStateOf(false) }
    Box {
        AppListItem(title, 0, 1, supporting = value, leading = { Icon(icon, null) }, trailing = { Icon(Symbols.ArrowDropDown, null) },
            onClick = { open = true }, tag = tag)
        AppMenu(open, { open = false }, maxHeight = 480.dp) {
            options.forEachIndexed { i, option ->
                AppMenuItem(option, { open = false; onPick(i) }, selected = i == selected)
            }
        }
    }
}
