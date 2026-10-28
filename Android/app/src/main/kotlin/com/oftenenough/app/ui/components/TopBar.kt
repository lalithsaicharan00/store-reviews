package com.oftenenough.app.ui.components

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.RowScope
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.material3.TopAppBarScrollBehavior
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.text.style.TextOverflow
import com.oftenenough.app.ui.theme.AppType

/**
 * Atom 1.6, **Top app bar** (Figma 495:70; Components — Atoms Build Plan): Material's own small `TopAppBar` as it is,
 * 64 dp high, its title 16 dp from the start (56 dp after a navigation icon), its actions 4 dp from the end. What the
 * design sets, and nothing more:
 *
 * - **The bar is Surface container**, the page's own colour, **and Surface container high once something scrolls under
 *   it** (Figma's Scrolled variants of Habits, Tasks and Habit details). Material does the change itself when it's given
 *   a [scrollBehavior]; a page that decides "scrolled" itself passes [containerColor].
 * - **The title is Title Large Emphasized, On surface**, one line; a **subtitle** under it is Label Medium, On surface
 *   variant. No title ([title] null) is Figma's Text = None: the actions still sit at the end.
 * - Icon colours are Material's: the navigation icon On surface, the actions On surface variant (1.1). Pass a plain
 *   [NavigationIcon] and plain `IconButton`s or [StandardIconButton]s, never a tint.
 *
 * A page whose column already pads the status bar passes `WindowInsets(0)` as [windowInsets].
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AppTopBar(
    title: String?,
    modifier: Modifier = Modifier,
    subtitle: String? = null,
    navigationIcon: @Composable () -> Unit = {},
    actions: @Composable RowScope.() -> Unit = {},
    scrollBehavior: TopAppBarScrollBehavior? = null,
    containerColor: Color = MaterialTheme.colorScheme.surfaceContainer,
    windowInsets: WindowInsets = TopAppBarDefaults.windowInsets,
) {
    TopAppBar(
        title = {
            if (title != null) Column {
                Text(title, style = AppType.titleLargeEmphasized, maxLines = 1, overflow = TextOverflow.Ellipsis)
                if (subtitle != null) Text(subtitle, style = AppType.labelMedium, color = MaterialTheme.colorScheme.onSurfaceVariant,
                    maxLines = 1, overflow = TextOverflow.Ellipsis)
            }
        },
        modifier = modifier,
        navigationIcon = navigationIcon,
        actions = actions,
        windowInsets = windowInsets,
        colors = TopAppBarDefaults.topAppBarColors(containerColor = containerColor, scrolledContainerColor = scrolledTopBarColor),
        scrollBehavior = scrollBehavior,
    )
}

/** The bar's colour once something scrolls under it: Surface container high. */
val scrolledTopBarColor: Color @Composable get() = MaterialTheme.colorScheme.surfaceContainerHigh

/** A top app bar's navigation icon (back, close, menu): Material's `IconButton`, coloured On surface by the bar. */
@Composable
fun NavigationIcon(icon: ImageVector, label: String, onClick: () -> Unit, modifier: Modifier = Modifier) {
    IconButton(onClick, modifier) { Icon(icon, label) }
}
