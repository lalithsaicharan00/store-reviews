package com.oftenenough.app.ui.components

import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.DropdownMenuGroup
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.DropdownMenuPopup
import androidx.compose.material3.ExperimentalMaterial3ExpressiveApi
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.MenuAnchorPosition
import androidx.compose.material3.MenuDefaults
import androidx.compose.material3.SelectableDropdownMenuItem
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.foundation.layout.padding
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.DpOffset
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.theme.AppType

/**
 * Atom 2.5, **Menu** (Figma 734:76; Components — Atoms Build Plan): Material 1.5's own Expressive menu,
 * `DropdownMenuPopup` holding a `DropdownMenuGroup`, as it is: Surface container low, Elevation Level 2, 16 dp corners,
 * Material's 2 above and below the items and 4 either side of them, 112 to 280 wide, its opening and closing motion.
 * Put [AppMenuItem]s in it, and a [MenuDivider] between groups of them.
 *
 * Opens below the thing it's placed beside, as Material's does; [offset] moves it. [maxHeight] makes a long list
 * scroll (Day & week's hours).
 */
@Composable
fun AppMenu(
    expanded: Boolean,
    onDismiss: () -> Unit,
    modifier: Modifier = Modifier,
    offset: DpOffset = DpOffset.Zero,
    maxHeight: Dp = Dp.Unspecified,
    content: @Composable ColumnScope.() -> Unit,
) = AppGroupedMenu(expanded, onDismiss, listOf(content), modifier, offset, maxHeight)

/**
 * A menu with gaps (Figma Menu, stacked 2 apart: the routine player's ⋮): each group its own `DropdownMenuGroup`,
 * Material's `GroupSpacing` apart, with Material's corners by place (`MenuDefaults.groupShape`): 16 at the menu's
 * top and bottom, 8 where two groups meet.
 */
@OptIn(ExperimentalMaterial3ExpressiveApi::class)
@Composable
fun AppGroupedMenu(
    expanded: Boolean,
    onDismiss: () -> Unit,
    groups: List<@Composable ColumnScope.() -> Unit>,
    modifier: Modifier = Modifier,
    offset: DpOffset = DpOffset.Zero,
    maxHeight: Dp = Dp.Unspecified,
) {
    DropdownMenuPopup(expanded, onDismiss, modifier,
        MenuDefaults.rememberDropdownMenuPopupPositionProvider(MenuAnchorPosition.Below, offset)) {
        groups.forEachIndexed { i, group ->
            if (i > 0) Spacer(Modifier.height(MenuDefaults.GroupSpacing))
            DropdownMenuGroup(MenuDefaults.groupShape(i, groups.size),
                if (maxHeight == Dp.Unspecified) Modifier else Modifier.heightIn(max = maxHeight).verticalScroll(rememberScrollState()),
                content = group)
        }
    }
}

/**
 * Atom 2.5, **Menu item** (Figma 734:73): Material 1.5's own Expressive `DropdownMenuItem`: 44 dp at least, Material's
 * padding and gap, its 4 dp shape, the label On surface and the 20 dp [icon] On surface variant, 38 % when switched off
 * ([enabled]). The design's small settings, nothing else:
 *
 * - **Label:** Body Large, Material's own label size (`SegmentedMenuTokens.ItemLabelTextFont`); Compose 1.5 still
 *   sets Label Large there, marked as a to-do.
 * - **[destructive]:** the label and icon Error: Delete, Remove, Erase (D9).
 * - **[selected]:** for a menu of choices (Sort by, A notification or an alarm, Ends): Material's selectable item,
 *   the chosen one on Tertiary container (our Secondary container's grey) with 12 dp corners, read as a radio button.
 *   Null for an action.
 * - **[supporting]:** a line under the label in Body Medium On surface variant ("In your notifications").
 *
 * Material leaves closing the menu to the caller, so [onClick] closes it as well as acting.
 */
@OptIn(ExperimentalMaterial3ExpressiveApi::class)
@Composable
fun AppMenuItem(
    text: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    icon: ImageVector? = null,
    enabled: Boolean = true,
    destructive: Boolean = false,
    selected: Boolean? = null,
    supporting: String? = null,
    tag: String? = null,
) {
    val label: @Composable () -> Unit = {
        // One line keeps the 12 it has in the 48 when it wraps (8 of the item's, 4 of its own).
        if (supporting == null) Text(text, Modifier.padding(vertical = 4.dp), style = AppType.bodyLarge)
        else androidx.compose.foundation.layout.Column {
            Text(text, style = AppType.bodyLarge)
            Text(supporting, style = AppType.bodyMedium, color = MaterialTheme.colorScheme.onSurfaceVariant)
        }
    }
    val leading: (@Composable () -> Unit)? = icon?.let { { Icon(it, null, Modifier.size(MenuDefaults.LeadingIconSize)) } }
    val m = modifier.semantics { tag?.let { testTag = it } }
    val red = if (destructive) MaterialTheme.colorScheme.error else Color.Unspecified
    // Figma's Menu item: 16 at the sides, 8 above and below. Its 44 high stays Material's 48 (Compose 1.5's
    // MenuListItemContainerHeight, the touch target).
    val padding = PaddingValues(horizontal = 16.dp, vertical = 8.dp)
    if (selected == null) DropdownMenuItem(onClick, label, MenuDefaults.middleItemShape, m, leading, enabled = enabled,
        colors = MenuDefaults.itemColors(textColor = red, leadingIconColor = red), contentPadding = padding)
    else SelectableDropdownMenuItem(selected, onClick, label, MenuDefaults.itemShapes(), m, leading, enabled = enabled,
        colors = MenuDefaults.selectableItemColors(textColor = red, leadingIconColor = red), contentPadding = padding)
}

