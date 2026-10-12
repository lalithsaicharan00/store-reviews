package com.oftenenough.app.ui.settings

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.rounded.ArrowDropDown
import androidx.compose.material.icons.rounded.Check
import androidx.compose.material.icons.rounded.CalendarMonth
import androidx.compose.material.icons.rounded.WbTwilight
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.HabitCopy
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.theme.appColors

/**
 * "New day starts at" (12:00 AM … 12:00 PM, never "Midnight") and "Week starts on" (Sunday … Saturday, Sunday by
 * default, never "Automatic"), as dropdown rows (Current Work 99): onboarding's Your days and weeks and ≡ › Day and Week.
 */
@Composable
fun DayAndWeekRows(store: HabitStore) {
    Column {
        DropdownRow("New day starts at", DayWords.clockMinute(store.dayEndHour * 60), Icons.Rounded.WbTwilight,
            (0..12).map { DayWords.clockMinute(it * 60) }, store.dayEndHour, "day-start") { store.setDayEnd(it) }
        Spacer(Modifier.padding(4.dp))
        DropdownRow("Week starts on", HabitCopy.fullDays[store.weekStart - 1], Icons.Rounded.CalendarMonth,
            HabitCopy.fullDays, store.weekStart - 1, "week-start") { store.chooseWeekStart(it + 1) }
    }
}

/** Material's exposed dropdown as a row: icon, title, the value under it, ▾; a menu with ✓ on the chosen value. */
@Composable
fun DropdownRow(title: String, value: String, icon: ImageVector, options: List<String>, selected: Int, tag: String, onPick: (Int) -> Unit) {
    var open by remember { mutableStateOf(false) }
    Box {
        Row(Modifier.fillMaxWidth().clip(RoundedCornerShape(28.dp)).background(appColors.surface).clickable { open = true }
            .semantics { testTag = tag }.heightIn(min = 72.dp).padding(horizontal = 16.dp), verticalAlignment = Alignment.CenterVertically) {
            Icon(icon, null, tint = appColors.ink)
            Spacer(Modifier.width(16.dp))
            Column(Modifier.weight(1f)) {
                Text(title, style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
                Text(value, style = MaterialTheme.typography.bodyMedium, color = appColors.secondary)
            }
            Icon(Icons.Rounded.ArrowDropDown, null, tint = appColors.secondary)
        }
        DropdownMenu(open, { open = false }, Modifier.heightIn(max = 480.dp)) {
            options.forEachIndexed { i, option ->
                DropdownMenuItem(
                    text = { Text(option) },
                    leadingIcon = { if (i == selected) Icon(Icons.Rounded.Check, null) else Spacer(Modifier.size(24.dp)) },
                    onClick = { open = false; onPick(i) },
                )
            }
        }
    }
}
