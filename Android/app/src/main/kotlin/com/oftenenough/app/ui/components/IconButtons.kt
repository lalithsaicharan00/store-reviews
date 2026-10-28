package com.oftenenough.app.ui.components

import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.IconButtonDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector

/**
 * Atom 1.1, **Icon button** (Figma 495:4; Components — Atoms Build Plan): Material's own `IconButton` as it is, a 48 dp
 * target with a 24 dp glyph and Material's round pressed state. **The glyph is On surface variant**, Material's standard
 * icon button colour, and Material dims it to 38 % when disabled: search, add and ⋮ in a top app bar, a row's or card's
 * ⋮, a card's ‹ ›, a search header's back and clear, a sheet's ⋮, the routine player's ✕ and ⋮.
 *
 * **One exception, also Material's:** a header's navigation icon at its start (back, close) is On surface. Inside a
 * `TopAppBar` that's the bar's own default, so its `navigationIcon` is a plain `IconButton` with no tint; a top app bar
 * never sets `navigationIconContentColor` or `actionIconContentColor` of its own.
 */
@Composable
fun StandardIconButton(icon: ImageVector, label: String, onClick: () -> Unit, modifier: Modifier = Modifier, enabled: Boolean = true) {
    IconButton(onClick, modifier, enabled, colors = IconButtonDefaults.iconButtonColors(contentColor = MaterialTheme.colorScheme.onSurfaceVariant)) {
        Icon(icon, label)
    }
}
