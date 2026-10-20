package com.oftenenough.app.ui.components

import com.oftenenough.app.ui.theme.AppType

import androidx.compose.animation.animateColorAsState
import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.animation.core.tween
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.PaddingValues
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
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowRight
import androidx.compose.material.icons.rounded.LocalFireDepartment
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.FilledTonalButton
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.drawBehind
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Shape
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.StreakUnit
import com.oftenenough.app.ui.theme.HabitIcons
import com.oftenenough.app.ui.theme.appColors

/** A habit's icon: a filled circle in its colour with a white glyph (in the app and on widgets). */
@Composable
fun HabitIcon(symbol: String, color: HabitColor, size: Dp = 40.dp, shape: Shape = CircleShape, modifier: Modifier = Modifier, glyph: Float = 0.55f) {
    Box(modifier.size(size).clip(shape).background(appColors.habit(color)), contentAlignment = Alignment.Center) {
        Icon(HabitIcons.icon(symbol), contentDescription = null, tint = Color.White, modifier = Modifier.size(size * glyph))
    }
}

/**
 * A row's round button (40 dp, a 48 dp target; Figma 1350:2): the soft grey (#ECECEF) with an ink glyph before the goal
 * is met, filled in the habit's colour with a white glyph once it is (U2, U14). [text] replaces the icon ("+250").
 */
@Composable
fun RoundActionButton(
    icon: ImageVector, done: Boolean, color: HabitColor, label: String, onClick: () -> Unit,
    text: String? = null, enabled: Boolean = true, size: Dp = 40.dp,
) {
    val c = appColors
    val background by animateColorAsState(if (done) c.habit(color) else c.soft, tween(220), label = "round")
    val content = if (done) Color.White else c.ink
    Box(
        Modifier.size(48.dp).clip(CircleShape)
            .clickable(enabled = enabled, role = Role.Button, onClickLabel = label, onClick = onClick)
            .semantics { contentDescription = label },
        contentAlignment = Alignment.Center,
    ) {
        Box(Modifier.size(size).clip(CircleShape).background(if (enabled) background else background.copy(alpha = 0.5f)), contentAlignment = Alignment.Center) {
            if (text != null) Text(text, color = content, style = if (text.length > 3) AppType.labelMedium else AppType.labelLarge, maxLines = 1)
            else Icon(icon, null, tint = if (enabled) content else content.copy(alpha = 0.5f), modifier = Modifier.size(if (size >= 40.dp) 24.dp else 20.dp))
        }
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

/**
 * "🔥 6", "🔥 4 wk": the emoji in an 18 dp place, 2 dp from the number in Label Large (Figma 1350:2; the iPhone's rule,
 * the user, 13 Oct 2026). TalkBack reads it in words.
 */
@Composable
fun StreakLabel(count: Int, unit: StreakUnit, roll: Float = 1f) {
    Row(verticalAlignment = Alignment.CenterVertically, modifier = Modifier.semantics(mergeDescendants = true) { contentDescription = unit.explained(count) }) {
        Box(Modifier.size(18.dp), contentAlignment = Alignment.Center) { Text("🔥", fontSize = 12.sp, lineHeight = 18.sp) }
        Spacer(Modifier.width(2.dp))
        if (roll >= 0.24f || count < 1) Text(unit.short(count), style = AppType.labelLarge, color = appColors.ink, maxLines = 1)
        else {
            // A milestone shown in the row alone rolls the count (Figma R.1: 59 slips up and out, 60 pops up in).
            val density = androidx.compose.ui.platform.LocalDensity.current.density
            val ease = androidx.compose.animation.core.CubicBezierEasing(0.3f, 0f, 0.8f, 0.15f)
            val pop = androidx.compose.animation.core.CubicBezierEasing(0.45f, 1.45f, 0.8f, 1f)
            val oldA = com.oftenenough.app.ui.day.track(roll, com.oftenenough.app.ui.day.Key(0f, 1f), com.oftenenough.app.ui.day.Key(0.131f, 1f, ease), com.oftenenough.app.ui.day.Key(0.169f, 0f))
            val oldY = com.oftenenough.app.ui.day.track(roll, com.oftenenough.app.ui.day.Key(0f, 0f), com.oftenenough.app.ui.day.Key(0.131f, 0f, ease), com.oftenenough.app.ui.day.Key(0.169f, -10f))
            val newA = com.oftenenough.app.ui.day.track(roll, com.oftenenough.app.ui.day.Key(0f, 0f), com.oftenenough.app.ui.day.Key(0.169f, 0f), com.oftenenough.app.ui.day.Key(0.208f, 1f))
            val newY = com.oftenenough.app.ui.day.track(roll, com.oftenenough.app.ui.day.Key(0f, 10f), com.oftenenough.app.ui.day.Key(0.169f, 10f, pop), com.oftenenough.app.ui.day.Key(0.231f, 0f))
            Box {
                Text(unit.short(count - 1), Modifier.graphicsLayer { alpha = oldA; translationY = oldY * density }, style = AppType.labelLarge, color = appColors.ink, maxLines = 1)
                Text(unit.short(count), Modifier.graphicsLayer { alpha = newA; translationY = newY * density }, style = AppType.labelLarge, color = appColors.ink, maxLines = 1)
            }
        }
    }
}

/**
 * Undo and Note under a row just logged (Figma 1.2, "After-log buttons (button group, XS)"): 36 dp, outlined (#C9C6CF)
 * on the card's own white, an 18 dp icon 6 dp from the label, 12 dp before and 16 dp after.
 */
@Composable
fun OutlinedPill(text: String, icon: ImageVector, onClick: () -> Unit, modifier: Modifier = Modifier) {
    val c = appColors
    Row(
        modifier.heightIn(min = 36.dp).clip(RoundedCornerShape(18.dp)).background(c.surface)
            .border(1.dp, c.line, RoundedCornerShape(18.dp)).clickable(role = Role.Button, onClick = onClick)
            .padding(start = 12.dp, end = 16.dp, top = 6.dp, bottom = 6.dp),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Icon(icon, null, Modifier.size(18.dp), tint = c.ink)
        Spacer(Modifier.width(6.dp))
        Text(text, style = AppType.labelLarge, color = c.ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
    }
}

/** A white card on the grey screen (corners 24–28). */
@Composable
fun Card(modifier: Modifier = Modifier, shape: Shape = RoundedCornerShape(24.dp), content: @Composable ColumnScope.() -> Unit) {
    Column(modifier.clip(shape).background(appColors.surface), content = content)
}

/** One piece of a segmented list: its own white piece, 2–4 dp from the next (Android 16's lists). */
@Composable
fun Segment(index: Int, count: Int, modifier: Modifier = Modifier, onClick: (() -> Unit)? = null, color: Color? = null, content: @Composable RowScope.() -> Unit) {
    Row(
        modifier.fillMaxWidth().clip(segmentShape(index, count)).background(color ?: appColors.surface)
            .let { if (onClick != null) it.clickable(onClick = onClick) else it }
            .heightIn(min = 56.dp).padding(horizontal = 16.dp, vertical = 12.dp),
        verticalAlignment = Alignment.CenterVertically, content = content,
    )
}

/** A segmented list: [count] pieces, 2 dp apart. */
@Composable
fun SegmentedList(modifier: Modifier = Modifier, content: @Composable ColumnScope.() -> Unit) {
    Column(modifier.fillMaxWidth(), verticalArrangement = Arrangement.spacedBy(2.dp), content = content)
}

/** A settings-style row: a leading icon in a tonal disc, a title, supporting text, and a trailing chevron or control. */
@Composable
fun ListRow(
    title: String, index: Int, count: Int, supporting: String? = null, icon: ImageVector? = null, iconDisc: Boolean = false,
    onClick: (() -> Unit)? = null, chevron: Boolean = onClick != null, titleColor: Color? = null, trailing: (@Composable () -> Unit)? = null,
    modifier: Modifier = Modifier, iconTint: Color? = null, strong: Boolean = false,
) {
    Segment(index, count, modifier, onClick = onClick) {
        if (icon != null) {
            if (iconDisc) Box(Modifier.size(40.dp).clip(CircleShape).background(appColors.tonal), contentAlignment = Alignment.Center) {
                Icon(icon, null, tint = iconTint ?: appColors.ink, modifier = Modifier.size(22.dp))
            } else Icon(icon, null, tint = iconTint ?: appColors.ink, modifier = Modifier.size(24.dp))
            Spacer(Modifier.width(16.dp))
        }
        Column(Modifier.weight(1f)) {
            // A name over supporting text is Title Medium; a name alone is Body Large (the type scale, Type.kt).
            Text(title, style = if (supporting != null || strong) AppType.titleMedium else AppType.bodyLarge, color = titleColor ?: appColors.ink)
            if (supporting != null) Text(supporting, style = MaterialTheme.typography.bodyMedium, color = appColors.secondary)
        }
        if (trailing != null) { Spacer(Modifier.width(8.dp)); trailing() }
        else if (chevron) Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = appColors.secondary)
    }
}

/** The filled ink main action (56 high, fully rounded). */
@Composable
fun InkButton(
    text: String, onClick: () -> Unit, modifier: Modifier = Modifier, enabled: Boolean = true, icon: ImageVector? = null, height: Dp = 56.dp,
    /** A screen moved to Figma's type (Google Sans Flex) passes its own; every other screen keeps the default. */
    textStyle: TextStyle? = null,
) {
    Button(onClick, modifier.heightIn(min = height), enabled = enabled,
        // Off, it stays solid (it floats over lists): tonal grey with quiet text, never see-through.
        colors = ButtonDefaults.buttonColors(containerColor = appColors.ink, contentColor = appColors.onInk,
            disabledContainerColor = appColors.tonal, disabledContentColor = appColors.secondary),
        contentPadding = PaddingValues(horizontal = 24.dp)) {
        if (icon != null) { Icon(icon, null, Modifier.size(20.dp)); Spacer(Modifier.width(8.dp)) }
        Text(text, style = textStyle ?: MaterialTheme.typography.titleMedium, maxLines = 1, overflow = TextOverflow.Ellipsis)
    }
}

/** The tonal grey second action (48 high). */
@Composable
fun TonalButton(text: String, onClick: () -> Unit, modifier: Modifier = Modifier, enabled: Boolean = true, icon: ImageVector? = null, height: Dp = 48.dp) {
    FilledTonalButton(onClick, modifier.heightIn(min = height), enabled = enabled,
        colors = ButtonDefaults.filledTonalButtonColors(containerColor = appColors.tonal, contentColor = appColors.ink),
        contentPadding = PaddingValues(horizontal = 20.dp)) {
        if (icon != null) { Icon(icon, null, Modifier.size(20.dp)); Spacer(Modifier.width(8.dp)) }
        Text(text, style = AppType.labelLarge, maxLines = 1, overflow = TextOverflow.Ellipsis)
    }
}

@Composable
fun PlainButton(
    text: String, onClick: () -> Unit, modifier: Modifier = Modifier, color: Color? = null, enabled: Boolean = true,
    /** A screen moved to Figma's type (Google Sans Flex) passes its own; every other screen keeps the default. */
    textStyle: TextStyle? = null,
) {
    TextButton(onClick, modifier, enabled = enabled) {
        Text(text, style = textStyle ?: AppType.labelLarge, color = color ?: appColors.ink)
    }
}

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
