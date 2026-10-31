package com.oftenenough.app.ui.components

import androidx.compose.animation.animateColorAsState
import androidx.compose.animation.core.tween
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.size
import androidx.compose.material3.ExperimentalMaterial3ExpressiveApi
import androidx.compose.material3.FilledIconButton
import androidx.compose.material3.FilledTonalIconButton
import androidx.compose.material3.IconButtonShapes
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButtonDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors

/** Figma Filled icon button, Size: Small for a row's or a stepper's button, Medium for the icon picker's cells. */
enum class IconButtonSize(val container: Dp) { Small(40.dp), Medium(56.dp) }

/**
 * Atom 2.2, **Filled icon button** (Figma 559:24; Components — Atoms Build Plan): Material's own `FilledIconButton`,
 * full round, a 24 dp glyph, a 48 dp target, Material's ripple. Two states, the design's colours:
 *
 * - **Neutral:** Surface container highest with an On surface variant glyph: Today's ✓ + ▶ ⌄ before the goal is met,
 *   the − and + of a number, an icon not chosen.
 * - **Done:** the habit's colour with a white glyph (On habit), and only once the goal is met (U2, U14), or the chosen
 *   icon. The change between them fades (220 ms).
 *
 * Switched off (a skipped day's ✓, a later day): Material's disabled state in our colours, as every switched-off button
 * ([AppButton]): Surface container low, the glyph On surface at 38 %, no habit colour. Material's On surface at 10 %
 * would be our Surface container highest, the enabled neutral button's own colour. **Done wins over switched off**
 * (the user, 31 Oct 2026): a goal met stays the habit's colour with white, even where the button can't act (an earlier
 * day's ▶, which starts no timer), as Figma's every Done row draws it. A limit is never Done (its caller passes false). [text] replaces the glyph where a number says more ("+250", the habit form's preview).
 */
@Composable
fun AppFilledIconButton(
    icon: ImageVector,
    label: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    done: Boolean = false,
    color: HabitColor = HabitColor.GRAY,
    size: IconButtonSize = IconButtonSize.Small,
    enabled: Boolean = true,
    text: String? = null,
    tag: String? = null,
) {
    val s = MaterialTheme.colorScheme
    val container by animateColorAsState(if (done) appColors.habit(color) else s.surfaceContainerHighest, tween(220), label = "filled-icon")
    val content = if (done) Color.White else s.onSurfaceVariant
    FilledIconButton(
        onClick,
        // Material's button is 40 dp on its own (in a 48 dp target); only the larger size is set.
        (if (size == IconButtonSize.Small) modifier else modifier.size(size.container)).semantics { contentDescription = label; tag?.let { testTag = it } },
        enabled,
        colors = IconButtonDefaults.filledIconButtonColors(
            containerColor = container, contentColor = content,
            disabledContainerColor = if (done) container else s.surfaceContainerLow,
            disabledContentColor = if (done) content else s.onSurface.copy(alpha = 0.38f),
        ),
    ) {
        if (text != null) Text(text, style = if (text.length > 3) AppType.labelMedium else AppType.labelLarge, maxLines = 1)
        else Icon(icon, null, Modifier.size(24.dp))
    }
}

/** Figma Large icon button, Width: Narrow 64, Uniform 96, Wide 128 (Material's widths); Fill takes the room it's given. */
enum class LargeIconWidth { Narrow, Uniform, Wide, Fill }

/**
 * Atom 1.2, **Large icon button** (Figma 718:8242; Components — Atoms Build Plan): Material 3 Expressive's own large
 * icon button as it is (Material 1.5, Android A76): 96 dp high, Material's square shape (28) that squares up further
 * while pressed, a 32 dp filled glyph. **Filled** (Primary, On primary: the timer's Pause and Resume) or **Tonal**
 * (Secondary container: the routine player's ‹ ›). Switched off, Material's disabled colours. [label] is what TalkBack
 * reads; the button has no words of its own.
 */
@OptIn(ExperimentalMaterial3ExpressiveApi::class)
@Composable
fun AppLargeIconButton(
    icon: ImageVector,
    label: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    tonal: Boolean = false,
    width: LargeIconWidth = LargeIconWidth.Uniform,
    enabled: Boolean = true,
    tag: String? = null,
) {
    val sized = when (width) {
        LargeIconWidth.Fill -> modifier.height(IconButtonDefaults.largeContainerSize().height)
        LargeIconWidth.Narrow -> modifier.size(IconButtonDefaults.largeContainerSize(IconButtonDefaults.IconButtonWidthOption.Narrow))
        LargeIconWidth.Uniform -> modifier.size(IconButtonDefaults.largeContainerSize(IconButtonDefaults.IconButtonWidthOption.Uniform))
        LargeIconWidth.Wide -> modifier.size(IconButtonDefaults.largeContainerSize(IconButtonDefaults.IconButtonWidthOption.Wide))
    }.semantics { contentDescription = label; tag?.let { testTag = it } }
    val shapes = IconButtonShapes(IconButtonDefaults.largeSquareShape, IconButtonDefaults.largePressedShape)
    val glyph: @Composable () -> Unit = { Icon(icon, null, Modifier.size(IconButtonDefaults.largeIconSize)) }
    if (tonal) FilledTonalIconButton(onClick, shapes, sized, enabled, content = glyph)
    else FilledIconButton(onClick, shapes, sized, enabled, content = glyph)
}
