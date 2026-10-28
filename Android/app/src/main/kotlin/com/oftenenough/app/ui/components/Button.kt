package com.oftenenough.app.ui.components

import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.RowScope
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.calculateEndPadding
import androidx.compose.foundation.layout.calculateStartPadding
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonColors
import androidx.compose.material3.ButtonShapes
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.FilledTonalButton
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.compositeOver
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.LocalLayoutDirection
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.theme.AppType

/** How loud a button is (Figma Button 500:26, Style). */
enum class ButtonStyle {
    /** The one main action on a screen: Primary, On primary (Material's `Button`). */
    Filled,
    /** A second action beside it: Secondary container, On secondary container (`FilledTonalButton`). */
    Tonal,
    /** A quiet action, usually Cancel: no container, On surface variant (`TextButton`). */
    Text,
    /** A quiet action that needs an edge (Skip today, Delete log, Close): a 1 dp Outline variant border (`OutlinedButton`). */
    Outlined,
}

/**
 * Which of Material 3 Expressive's sizes (Figma Button, Size; Material 1.5, Android A76). Heights, padding, icon sizes
 * and the gap after an icon are Material's own (`ButtonDefaults`); the labels follow the design: Label Large, Title
 * Medium, Title Large (Material's Large label is Headline Small).
 */
enum class ButtonSize(val height: Dp) {
    /** 40 dp: inline actions, dialogs, empty states. */
    Small(ButtonDefaults.MinHeight),
    /** 56 dp: the full-width action at the bottom of a screen. */
    Medium(ButtonDefaults.MediumContainerHeight),
    /**
     * 96 dp: the routine player's, the timer's and the alarm's one big action. Every one fills a set width (a slot of
     * the player's bar, the screen), so its content is centred and 16 at the sides is only the least room: Material's
     * 48 cut "Mark done" to "Ma…" in the player's 184 dp slot, where Figma's own drawing runs past its 48.
     */
    Large(ButtonDefaults.LargeContainerHeight);

    val label: TextStyle @Composable get() = when (this) { Small -> AppType.labelLarge; Medium -> AppType.titleMedium; Large -> AppType.titleLarge }

    /** Round: Material's own pair for this size, which squares up a little while pressed (Expressive's shape morph). */
    @Composable fun roundShapes(): ButtonShapes = ButtonDefaults.shapesFor(height)

    /** Square: 12, 16 or 28 (Material's Medium, Large and Extra large corners), with the same pressed shape. */
    @Composable fun squareShapes(): ButtonShapes {
        val m = MaterialTheme.shapes
        return when (this) {
            Small -> ButtonShapes(m.medium, ButtonDefaults.pressedShape)
            Medium -> ButtonShapes(m.large, ButtonDefaults.mediumPressedShape)
            Large -> ButtonShapes(m.extraLarge, ButtonDefaults.largePressedShape)
        }
    }
}

/**
 * Atom 2.1, **Button** (Figma 500:26; Components — Atoms Build Plan): Material's own four buttons, with the design's
 * small settings and nothing else.
 *
 * - **Colours:** Filled and Tonal are Material's. Text and Outlined labels are On surface variant (Material's are
 *   Primary), and Outlined's border is Outline variant (Material's is Outline), 2 dp on the Large size. [destructive]
 *   turns a Text or Outlined label Error: Delete, Remove, Erase (D9). A switched-off Filled or Tonal button keeps
 *   Material's disabled colours, made solid on the surface, because it can float over a list.
 * - **Sizes:** [size], see [ButtonSize]; the label is one line, cut with … if it can't fit.
 * - **Shape:** Material's full round by default; [square] gives Expressive's square corners (12, 16, 28: the routine
 *   player's big actions). Both morph a little while pressed, as Material 3 Expressive's buttons do.
 * - **[compact]:** for a button that fills a share of a row (Day details' two logging buttons, Delete | Edit): 12 at
 *   the sides instead of 24. Its label is centred, so it looks the same, but "Log manually" isn't cut in a 144 dp half.
 */
@Composable
fun AppButton(
    text: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    style: ButtonStyle = ButtonStyle.Filled,
    size: ButtonSize = ButtonSize.Small,
    icon: ImageVector? = null,
    enabled: Boolean = true,
    square: Boolean = false,
    destructive: Boolean = false,
    compact: Boolean = false,
    tag: String? = null,
) {
    val s = MaterialTheme.colorScheme
    val shapes = if (square) size.squareShapes() else size.roundShapes()
    val padding = padding(size, icon != null, compact)
    val m = modifier.heightIn(min = size.height).semantics { tag?.let { testTag = it } }
    val solidOff = s.onSurface.copy(alpha = 0.12f).compositeOver(s.surface)
    val quiet = if (destructive) s.error else s.onSurfaceVariant
    val content: @Composable RowScope.() -> Unit = {
        if (icon != null) { Icon(icon, null, Modifier.size(ButtonDefaults.iconSizeFor(size.height))); Spacer(Modifier.width(ButtonDefaults.iconSpacingFor(size.height))) }
        Text(text, style = size.label, maxLines = 1, overflow = TextOverflow.Ellipsis)
    }
    when (style) {
        ButtonStyle.Filled -> Button(onClick, shapes, m, enabled,
            ButtonDefaults.buttonColors(disabledContainerColor = solidOff), contentPadding = padding, content = content)
        ButtonStyle.Tonal -> FilledTonalButton(onClick, shapes, m, enabled,
            ButtonDefaults.filledTonalButtonColors(disabledContainerColor = solidOff), contentPadding = padding, content = content)
        ButtonStyle.Text -> TextButton(onClick, shapes, m, enabled, quietColors(quiet), contentPadding = padding, content = content)
        ButtonStyle.Outlined -> OutlinedButton(onClick, shapes, m, enabled, quietColors(quiet),
            border = BorderStroke(if (size == ButtonSize.Large) 2.dp else 1.dp, if (enabled) s.outlineVariant else s.onSurface.copy(alpha = 0.12f)),
            contentPadding = padding, content = content)
    }
}

/**
 * Material's padding for the size (more at the start before an icon's gap is counted), with two settings of ours:
 * Large keeps 16 at the sides (see [ButtonSize.Large]), and [compact] keeps 12 at the sides for a button sharing a row.
 */
@Composable
private fun padding(size: ButtonSize, hasIcon: Boolean, compact: Boolean): PaddingValues {
    val material = ButtonDefaults.contentPaddingFor(size.height, hasIcon, false)
    val most = when { compact -> 12.dp; size == ButtonSize.Large -> 16.dp; else -> return material }
    val direction = LocalLayoutDirection.current
    return PaddingValues(
        start = minOf(material.calculateStartPadding(direction), most), end = minOf(material.calculateEndPadding(direction), most),
        top = material.calculateTopPadding(), bottom = material.calculateBottomPadding(),
    )
}

@Composable
private fun quietColors(label: androidx.compose.ui.graphics.Color): ButtonColors = ButtonDefaults.textButtonColors(contentColor = label)
