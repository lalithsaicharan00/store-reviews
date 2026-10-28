package com.oftenenough.app.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.FlowRow
import androidx.compose.foundation.layout.ExperimentalLayoutApi
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.semantics.clearAndSetSemantics
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors

/**
 * Molecule 4.14, **Stat tile** (Figma 1005:2; Components — Atoms Build Plan): one fact in the Overall record (4.16):
 * a label, the number with its unit, and a caption.
 *
 * Surface container low (neutral), or the habit's Fill for the current streak ([fill]); corners 16, 14 in, 4 apart:
 * the [label] in Body Small On surface variant; the value, on one baseline 4 apart: the phone's own [emoji] (Body
 * Large; the current streak's 🔥), the [number] in Headline Small Emphasized and the [unit] in Body Medium, both On
 * surface (they wrap to a second line before they're cut); the [caption] in Body Small On surface variant. TalkBack
 * reads [spoken] as one line.
 */
@OptIn(ExperimentalLayoutApi::class)
@Composable
fun StatTile(
    label: String, number: String, unit: String, caption: String?, spoken: String, modifier: Modifier = Modifier,
    emoji: String? = null, fill: HabitColor? = null, tag: String? = null,
) {
    val s = MaterialTheme.colorScheme
    val c = appColors
    Column(
        modifier.clip(RoundedCornerShape(16.dp)).background(fill?.let { c.habitFill(it) } ?: s.surfaceContainerLow).padding(14.dp)
            .clearAndSetSemantics { contentDescription = spoken; tag?.let { testTag = it } },
        verticalArrangement = Arrangement.spacedBy(4.dp),
    ) {
        Text(label, style = AppType.bodySmall, color = s.onSurfaceVariant)
        FlowRow(horizontalArrangement = Arrangement.spacedBy(4.dp)) {
            if (emoji != null) Text(emoji, Modifier.alignByBaseline(), style = AppType.bodyLarge)
            Text(number, Modifier.alignByBaseline(), style = AppType.headlineSmallEmphasized, color = s.onSurface)
            if (unit.isNotEmpty()) Text(unit, Modifier.alignByBaseline(), style = AppType.bodyMedium, color = s.onSurface)
        }
        if (caption != null) Text(caption, style = AppType.bodySmall, color = s.onSurfaceVariant)
    }
}
