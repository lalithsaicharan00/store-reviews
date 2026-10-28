package com.oftenenough.app.ui.components

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.Symbols

/**
 * Molecule 4.10, **Next milestone** (Figma 1007:16; Components — Atoms Build Plan): a track's next milestone, how far
 * along it is, what it is and how many to go. In the Milestones card (the habit page's Progress, All milestones) and
 * the milestone pop-up.
 *
 * A row, its items centred: the [AppCircularProgress] (1.21, 52) filled to [fraction] with the milestone's [number] in
 * it (✓ once every milestone on the track is reached: [number] null); 16; the [title] ("30 days in a row") in Title
 * Medium On surface over the [supporting] text ("7 to go · now 23") in Body Medium On surface variant, both wrapping.
 * The caller says it for TalkBack as one line (its own words), so the parts aren't read on their own.
 */
@Composable
fun NextMilestone(number: String?, title: String, supporting: String?, fraction: Float, color: HabitColor, modifier: Modifier = Modifier) {
    val s = MaterialTheme.colorScheme
    Row(modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(16.dp), verticalAlignment = Alignment.CenterVertically) {
        AppCircularProgress(fraction, color) {
            if (number == null) Icon(Symbols.Check, null, tint = s.onSurface) else CircularProgressLabel(number)
        }
        Column(Modifier.weight(1f)) {
            Text(title, style = AppType.titleMedium, color = s.onSurface)
            supporting?.let { Text(it, style = AppType.bodyMedium, color = s.onSurfaceVariant) }
        }
    }
}
