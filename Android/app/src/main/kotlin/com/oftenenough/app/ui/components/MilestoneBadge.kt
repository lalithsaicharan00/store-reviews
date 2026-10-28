package com.oftenenough.app.ui.components

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.clearAndSetSemantics
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.ui.theme.AppType

/** Figma's badge width: three share the Milestones card's row; past that the row scrolls, each this wide. */
val MilestoneBadgeWidth = 92.dp

/**
 * Molecule 4.11, **Milestone badge** (Figma 1007:9; Components — Atoms Build Plan): a milestone already reached, its
 * [Medal], what it was and the day. Three share a row under Earlier in the Milestones card (4.13).
 *
 * A column, centred, 4 apart: the [Medal] at 52 (its Small, scaled as Figma's instance is) with its [number]; the
 * [name] ("80 glasses") in Label Medium On surface; the [date] ("29 Sep") in Body Small On surface variant; both
 * centred and wrapping, as Figma's text grows in height. TalkBack reads it as one line, [spoken] ("80 glasses,
 * reached 29 September 2026").
 */
@Composable
fun MilestoneBadge(number: String, name: String, date: String, color: HabitColor, spoken: String, modifier: Modifier = Modifier) {
    val s = MaterialTheme.colorScheme
    Column(modifier.clearAndSetSemantics { contentDescription = spoken }, horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.spacedBy(4.dp)) {
        Medal(number, 52.dp, color)
        Text(name, style = AppType.labelMedium, color = s.onSurface, textAlign = TextAlign.Center)
        Text(date, style = AppType.bodySmall, color = s.onSurfaceVariant, textAlign = TextAlign.Center)
    }
}
