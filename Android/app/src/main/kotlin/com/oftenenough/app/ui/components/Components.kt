package com.oftenenough.app.ui.components

import com.oftenenough.app.ui.theme.AppType

import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.animation.core.tween
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.RowScope
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Icon
import androidx.compose.material3.LocalContentColor
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.drawBehind
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Shape
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.ui.theme.HabitIcons
import com.oftenenough.app.ui.theme.appColors

/** A habit's icon: a filled circle in its colour with a white glyph (in the app and on widgets). */
@Composable
fun HabitIcon(symbol: String, color: HabitColor, size: Dp = 40.dp, shape: Shape = CircleShape, modifier: Modifier = Modifier, glyph: Float = 0.55f) {
    Box(modifier.size(size).clip(shape).background(appColors.habit(color)), contentAlignment = Alignment.Center) {
        Icon(HabitIcons.icon(symbol), contentDescription = null, tint = Color.White, modifier = Modifier.size(size * glyph))
    }
}

/** The progress fill behind a row: the share reached, in a light tint of the habit's colour. */
fun Modifier.progressFill(progress: Float, color: Color): Modifier = drawBehind {
    val p = progress.coerceIn(0f, 1f)
    if (p > 0f) drawRect(color, size = size.copy(width = size.width * p))
}

@Composable
fun animatedProgress(target: Float): Float {
    val v by animateFloatAsState(target.coerceIn(0f, 1f), tween(350), label = "fill")
    return v
}

/** A white card on the grey screen (corners 24–28). */
@Composable
fun Card(modifier: Modifier = Modifier, shape: Shape = RoundedCornerShape(24.dp), content: @Composable ColumnScope.() -> Unit) {
    Column(modifier.clip(shape).background(appColors.surface), content = content)
}

/**
 * One piece of a segmented list that isn't a row (a stepper, the weekday circles, a field): the List item atom's own
 * Surface and corners (2.4), so it sits in a group of [AppListItem]s as one of them. A row is an [AppListItem].
 */
@Composable
fun Segment(index: Int, count: Int, modifier: Modifier = Modifier, onClick: (() -> Unit)? = null, color: Color? = null, content: @Composable RowScope.() -> Unit) {
    Row(
        modifier.fillMaxWidth().clip(segmentShape(index, count)).background(color ?: MaterialTheme.colorScheme.surface)
            .let { if (onClick != null) it.clickable(onClick = onClick) else it }
            .heightIn(min = 56.dp).padding(horizontal = 16.dp, vertical = 12.dp),
        verticalAlignment = Alignment.CenterVertically, content = content,
    )
}

/** A segmented list: [count] pieces, 2 dp apart. */
@Composable
fun SegmentedList(modifier: Modifier = Modifier, content: @Composable ColumnScope.() -> Unit) {
    Column(modifier.fillMaxWidth(), verticalArrangement = Arrangement.spacedBy(SegmentedListGap), content = content)
}

/**
 * A settings-style row on the List item atom (2.4, [AppListItem]): an optional leading icon, bare or in its circle
 * ([iconDisc], [ListAvatar]), the title, supporting text, and a trailing control or, when it opens something, ›.
 */
@Composable
fun ListRow(
    title: String, index: Int, count: Int, supporting: String? = null, icon: ImageVector? = null, iconDisc: Boolean = false,
    onClick: (() -> Unit)? = null, chevron: Boolean = onClick != null, titleColor: Color? = null, trailing: (@Composable () -> Unit)? = null,
    modifier: Modifier = Modifier, iconTint: Color? = null,
) = AppListItem(
    title, index, count, modifier, supporting,
    leading = icon?.let { { if (iconDisc) ListAvatar(it, tint = iconTint) else Icon(it, null, tint = iconTint ?: LocalContentColor.current) } },
    trailing = trailing ?: if (chevron) ({ ListChevron() }) else null,
    onClick = onClick, headlineColor = titleColor ?: Color.Unspecified,
)

/** An icon in the Expressive cookie, tonal grey (illustrations on empty states and choices). */
@Composable
fun CookieIcon(icon: ImageVector, size: Dp = 56.dp, container: Color? = null, tint: Color? = null, glyph: Float = 0.45f) {
    Box(Modifier.size(size).clip(CookieShape()).background(container ?: appColors.tonal), contentAlignment = Alignment.Center) {
        Icon(icon, null, tint = tint ?: appColors.ink, modifier = Modifier.size(size * glyph))
    }
}

/** A grey badge: "2 left", "✓ Done", "3 planned" (Figma: 24 dp, 10 dp each side, Label Medium on #ECECEF). */
@Composable
fun Badge(text: String) {
    Box(Modifier.heightIn(min = 24.dp).clip(RoundedCornerShape(12.dp)).background(appColors.soft).padding(horizontal = 10.dp, vertical = 4.dp),
        contentAlignment = Alignment.Center) {
        Text(text, style = AppType.labelMedium, color = appColors.ink, maxLines = 1)
    }
}

/** A full-height vertical divider-free spacer that takes the rest of a row. */
@Composable
fun RowScope.Fill() = Spacer(Modifier.weight(1f).fillMaxHeight())
