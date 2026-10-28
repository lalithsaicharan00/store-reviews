package com.oftenenough.app.ui.components

import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.PrimaryTabRow
import androidx.compose.material3.Tab
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import com.oftenenough.app.ui.theme.AppType

/**
 * Atom 1.7, **Primary tabs** (Figma 964:219674 and its Primary tab 964:219669; Components — Atoms Build Plan): Material's
 * own `PrimaryTabRow` and `Tab` as they are. 48 dp tabs, Label Large, Material's indicator (3 dp, rounded top, as wide as
 * the label) and its 1 dp Outline variant divider. **The active tab and its indicator are Primary, the others On surface
 * variant**: the one thing set here, because Compose's `Tab` gives inactive tabs the active colour unless told.
 *
 * The row has no colour of its own in the design: it sits on whatever is behind it, so a page passes [containerColor]
 * (the page, or the top app bar's scrolled colour when the row is pinned under it).
 */
@Composable
fun PrimaryTabs(
    selected: Int,
    labels: List<String>,
    onSelect: (Int) -> Unit,
    modifier: Modifier = Modifier,
    containerColor: Color = MaterialTheme.colorScheme.surfaceContainer,
    tag: (Int) -> String? = { null },
) {
    PrimaryTabRow(selected, modifier, containerColor = containerColor, contentColor = MaterialTheme.colorScheme.primary) {
        labels.forEachIndexed { i, label ->
            Tab(
                selected = i == selected,
                onClick = { onSelect(i) },
                modifier = tag(i)?.let { t -> Modifier.semantics { testTag = t } } ?: Modifier,
                text = { Text(label, style = AppType.labelLarge, maxLines = 1) },
                selectedContentColor = MaterialTheme.colorScheme.primary,
                unselectedContentColor = MaterialTheme.colorScheme.onSurfaceVariant,
            )
        }
    }
}
