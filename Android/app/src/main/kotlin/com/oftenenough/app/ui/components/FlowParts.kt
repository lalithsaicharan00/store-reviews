package com.oftenenough.app.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.rounded.History
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors

// The parts every flow step is built from (restore, backup, Plus). They were in the move screens, which went with the
// server (22 Oct 2026); they belong with the other shared pieces.

/**
 * A flow step's heading: the question in Headline Medium Emphasized over a Body Large line, 8 apart (Figma `39:1590`:
 * 28/36 Medium over 16/24 secondary, 16 from the sides plus the 8 the flow already keeps).
 */
@Composable
fun StepHeading(title: String, lead: String?) {
    Column(Modifier.fillMaxWidth().padding(start = 8.dp, end = 8.dp, bottom = 24.dp)) {
        Text(title, Modifier.semantics { heading() }, style = AppType.headlineMediumEmphasized, color = appColors.ink)
        if (lead != null) {
            Spacer(Modifier.height(8.dp))
            Text(lead, style = AppType.bodyLarge, color = appColors.secondary)
        }
    }
}

/** A tonal 40 circle with an icon (the rows' and cards' leading icon). */
@Composable
fun Disc(icon: ImageVector, size: Dp = 40.dp) =
    Box(Modifier.size(size).clip(CircleShape).background(appColors.tonal), contentAlignment = Alignment.Center) {
        Icon(icon, null, Modifier.size(size * 0.55f), tint = appColors.ink)
    }

/** What a backup holds: "31 habits, 929 logs" and where and when it's from. */
@Composable
fun CountCard(habits: Int, logs: Int, line: String, icon: ImageVector = Icons.Rounded.History, tag: String = "count-card") {
    Row(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(appColors.surface).padding(horizontal = 16.dp, vertical = 20.dp)
        .semantics(mergeDescendants = true) { testTag = tag }, verticalAlignment = Alignment.CenterVertically) {
        Disc(icon)
        Spacer(Modifier.width(16.dp))
        Column {
            Text(countText(habits, logs), style = AppType.titleLarge, color = appColors.ink)
            Text(line, style = AppType.bodyMedium, color = appColors.secondary)
        }
    }
}

/** "From a Pixel 9 · today, 9:14 AM". */
fun fromLine(device: String, at: Long, store: HabitStore): String {
    val day = store.rules.calendarDayOf(at)
    val today = store.rules.calendarDayOf(System.currentTimeMillis())
    val whenWords = when (day) { today -> "today"; today - 1 -> "yesterday"; else -> DayWords.short(day) } + ", " + DayWords.clock(at)
    return "From a $device · $whenWords"
}

/** A fact said before a choice ("This replaces what's on this phone"): an icon, a title, the words. */
@Composable
fun FactRow(icon: ImageVector, title: String, text: String) {
    Row(Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 16.dp)) {
        Icon(icon, null, Modifier.size(24.dp), tint = appColors.ink)
        Spacer(Modifier.width(16.dp))
        Column {
            Text(title, style = AppType.labelLarge, color = appColors.ink)
            Spacer(Modifier.height(2.dp))
            Text(text, style = AppType.bodyMedium, color = appColors.secondary)
        }
    }
}

/** "31 habits, 929 logs" — one habit and one log stay singular. */
fun countText(habits: Int, logs: Int): String =
    (if (habits == 1) "1 habit" else "$habits habits") + ", " + (if (logs == 1) "1 log" else "$logs logs")
