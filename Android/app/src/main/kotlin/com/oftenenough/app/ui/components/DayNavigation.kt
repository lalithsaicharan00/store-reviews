package com.oftenenough.app.ui.components

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.ExperimentalMaterial3ExpressiveApi
import androidx.compose.material3.FloatingToolbarDefaults
import androidx.compose.material3.HorizontalFloatingToolbar
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.Symbols

/**
 * Molecule 4.18, **Day navigation** in the **Floating toolbar** (Figma 581:145; Components — Atoms Build Plan): the
 * day bar that floats over Today.
 *
 * The Floating toolbar atom (1.5): Material 1.5's `HorizontalFloatingToolbar` as it is (64 tall, corners full, 8 at its
 * ends and 4 between, 16 from each screen edge, its elevation and no outline, A76), on Surface bright rather than
 * Material's Surface container, which is our page colour. It never changes width as the day changes (the user, 12 Oct
 * 2026). In it: ‹ (an Icon button, 48, "Previous day"); the day, a button that opens Go to a day, centred,
 * 4 in at its sides, 8 apart: the [DayRing] ([fraction] of the day's habits done), the [label] ("Today", "Yesterday",
 * "Wed 21 Oct") in Title Medium with ▾ 2 after it, both On surface, and the [count] ("4/13") in Label Large On surface
 * variant when there is one; › ("Next day"). TalkBack reads the day as one button ([spoken]).
 */
@OptIn(ExperimentalMaterial3ExpressiveApi::class)
@Composable
fun DayNavigation(
    label: String, count: String?, fraction: Float, spoken: String, onPrevious: () -> Unit, onNext: () -> Unit, onPick: () -> Unit,
    modifier: Modifier = Modifier,
) {
    val s = MaterialTheme.colorScheme
    HorizontalFloatingToolbar(
        expanded = true,
        modifier = modifier.padding(horizontal = 16.dp).fillMaxWidth().semantics { testTag = "day-bar" },
        colors = FloatingToolbarDefaults.standardFloatingToolbarColors(toolbarContainerColor = s.surfaceBright),
    ) {
        IconButton(onPrevious, Modifier.semantics { testTag = "day-previous" }) { Icon(Symbols.KeyboardArrowLeft, "Previous day") }
        Row(Modifier.weight(1f).clip(RoundedCornerShape(24.dp)).clickable(onClick = onPick).padding(horizontal = 4.dp, vertical = 12.dp)
            .semantics(mergeDescendants = true) { contentDescription = spoken },
            horizontalArrangement = Arrangement.spacedBy(8.dp, Alignment.CenterHorizontally), verticalAlignment = Alignment.CenterVertically) {
            DayRing(fraction, s.onSurface, s.outlineVariant)
            Row(horizontalArrangement = Arrangement.spacedBy(2.dp), verticalAlignment = Alignment.CenterVertically, modifier = Modifier.weight(1f, fill = false)) {
                Text(label, Modifier.weight(1f, fill = false), style = AppType.titleMedium, color = s.onSurface, maxLines = 1, overflow = TextOverflow.Ellipsis)
                Icon(Symbols.ArrowDropDown, null, Modifier.size(20.dp), tint = s.onSurface)
            }
            if (count != null) Text(count, style = AppType.labelLarge.copy(fontFeatureSettings = "tnum"), color = s.onSurfaceVariant, maxLines = 1)
        }
        IconButton(onNext, Modifier.semantics { testTag = "day-next" }) { Icon(Symbols.KeyboardArrowRight, "Next day") }
    }
}

/**
 * The day's ring (Figma's Day ring): [progress] of the day's habits, 20 dp, a full track in [track] and an arc in
 * [color] from twelve o'clock, inner radius 0.72 (a 2.8 dp band), square ends.
 */
@Composable
fun DayRing(progress: Float, color: Color, track: Color, modifier: Modifier = Modifier) {
    val p = progress.coerceIn(0f, 1f)
    Canvas(modifier.size(20.dp)) {
        val w = size.minDimension / 2 * 0.28f
        val inset = w / 2
        val arcSize = Size(size.width - w, size.height - w)
        drawArc(track, 0f, 360f, false, Offset(inset, inset), arcSize, style = Stroke(w))
        if (p > 0f) drawArc(color, -90f, 360f * p, false, Offset(inset, inset), arcSize, style = Stroke(w))
    }
}
