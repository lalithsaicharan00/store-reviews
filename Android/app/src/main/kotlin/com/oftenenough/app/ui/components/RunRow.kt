package com.oftenenough.app.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors

/**
 * Molecule 4.5, **Run row** (Figma 1034:2; Components — Atoms Build Plan): one run of days in a row on the Streaks
 * page (a quit habit's runs too), longest first.
 *
 * The [length] ("23 days") in Title Medium, On surface, taking the room left, and the [dates] ("30 Sep – today · now")
 * in Body Medium, On surface variant, 12 apart on one baseline. 8 under them, the track: 8 tall, corners 4, Surface
 * container high. The bar is the run's share of the longest ([fraction]: the longest fills the track), in the habit's
 * **Colour** for the run going on now ([current]) and its **Pale** for an earlier one. A share too small to see keeps
 * 3 % of the track, so a run never shows as no bar at all.
 */
@Composable
fun RunRow(length: String, dates: String, fraction: Float, current: Boolean, color: HabitColor, modifier: Modifier = Modifier) {
    val s = MaterialTheme.colorScheme
    val c = appColors
    Column(modifier.fillMaxWidth(), verticalArrangement = Arrangement.spacedBy(8.dp)) {
        Row(horizontalArrangement = Arrangement.spacedBy(12.dp)) {
            Text(length, Modifier.weight(1f).alignByBaseline(), style = AppType.titleMedium, color = s.onSurface)
            Text(dates, Modifier.alignByBaseline(), style = AppType.bodyMedium, color = s.onSurfaceVariant, maxLines = 1)
        }
        val shape = RoundedCornerShape(4.dp)
        Box(Modifier.fillMaxWidth().height(8.dp).clip(shape).background(s.surfaceContainerHigh)) {
            Box(Modifier.fillMaxHeight().fillMaxWidth(fraction.coerceIn(0.03f, 1f)).clip(shape)
                .background(if (current) c.habit(color) else c.habitPale(color)))
        }
    }
}
