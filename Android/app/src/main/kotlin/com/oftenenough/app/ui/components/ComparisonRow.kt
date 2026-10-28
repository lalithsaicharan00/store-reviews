package com.oftenenough.app.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors

/**
 * Molecule 4.6, **Comparison row** (Figma 1009:2; Components — Atoms Build Plan): one bar of a comparison on Habit
 * details (this week against the same days last week, this month against the month before).
 *
 * The [label] ("This week") in Body Medium, On surface variant, taking the room left, and the [value] ("44 glasses")
 * in Label Large, On surface, 12 apart on one baseline. 6 under them, the bar: 8 tall, corners 4, in the habit's
 * Colour for both periods, on no track. The larger value fills the width; the other is its share of it ([fraction]),
 * so the two stay in proportion. A share too small to see keeps 2 % of the width.
 */
@Composable
fun ComparisonRow(label: String, value: String, fraction: Float, color: HabitColor, modifier: Modifier = Modifier) {
    val s = MaterialTheme.colorScheme
    Column(modifier.fillMaxWidth()) {
        Row(horizontalArrangement = Arrangement.spacedBy(12.dp)) {
            Text(label, Modifier.weight(1f).alignByBaseline(), style = AppType.bodyMedium, color = s.onSurfaceVariant,
                maxLines = 1, overflow = TextOverflow.Ellipsis)
            Text(value, Modifier.alignByBaseline(), style = AppType.labelLarge, color = s.onSurface, maxLines = 1)
        }
        Spacer(Modifier.height(6.dp))
        Spacer(Modifier.fillMaxWidth(fraction.coerceIn(0.02f, 1f)).height(8.dp).clip(RoundedCornerShape(4.dp)).background(appColors.habit(color)))
    }
}
