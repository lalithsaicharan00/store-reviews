package com.oftenenough.app.ui.backup

import com.oftenenough.app.ui.theme.Symbols
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
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.material3.MaterialTheme
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.backup.countText
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors

// Pieces shared by Backup & Sync's restore flows and coming back (Welcome back). They lived with Move to a new phone
// until it was removed (21 Oct 2026: the first release is kept simple).

/**
 * A flow step's heading (Figma's Heading on every onboarding, restore and Plus screen, 5.1.3): the title in Headline
 * Small Emphasized On surface, a heading, over its lead in Body Large On surface variant, 8 apart, the full width; 24
 * under it.
 */
@Composable
fun StepHeading(title: String, lead: String?) {
    val s = MaterialTheme.colorScheme
    Column(Modifier.fillMaxWidth().padding(bottom = 24.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
        Text(title, Modifier.semantics { heading() }, style = AppType.headlineSmallEmphasized, color = s.onSurface)
        if (lead != null) Text(lead, style = AppType.bodyLarge, color = s.onSurfaceVariant)
    }
}

/** A tonal 40 circle with an icon (the rows' and cards' leading icon). */
@Composable
fun Disc(icon: ImageVector, size: androidx.compose.ui.unit.Dp = 40.dp) =
    Box(Modifier.size(size).clip(CircleShape).background(appColors.tonal), contentAlignment = Alignment.Center) {
        Icon(icon, null, Modifier.size(size * 0.55f), tint = appColors.ink)
    }

/** What a backup or a move holds: "31 habits, 929 logs" and where and when it's from (Figma 2.2, 4.3, 5.4, 6.1). */
@Composable
fun CountCard(habits: Int, logs: Int, line: String, icon: ImageVector = Symbols.History, tag: String = "count-card") {
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

/** A fact said before a choice ("This replaces what's on this phone", Figma 4.1.1, 4.3.2): an icon, a title, the words. */
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
