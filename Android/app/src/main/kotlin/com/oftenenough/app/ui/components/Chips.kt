package com.oftenenough.app.ui.components

import com.oftenenough.app.ui.theme.Symbols
import androidx.compose.foundation.layout.size
import androidx.compose.material3.AssistChip
import androidx.compose.material3.AssistChipDefaults
import androidx.compose.material3.FilterChip
import androidx.compose.material3.FilterChipDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag

/**
 * Atom 1.15, **Filter chip** (Figma 1040:678; Components — Atoms Build Plan): Material's own `FilterChip` with
 * Material's colours. 32 dp, 8 dp corners, Label Large. **Not selected: a 1 dp Outline variant border, the label On
 * surface variant. Selected: Secondary container, no border, a ✓ before the label, both On secondary container.**
 * The ✓ is Material's leading icon, shown only when selected.
 *
 * For choosing what's shown or picked: History's All · With notes, How long's quick picks, Weekdays · Weekends, the
 * groups. An action beside them (Go to date) is an assist chip (1.16).
 */
@Composable
fun AppFilterChip(label: String, selected: Boolean, onClick: () -> Unit, modifier: Modifier = Modifier, tag: String? = null) {
    FilterChip(
        selected = selected,
        onClick = onClick,
        label = { Text(label, maxLines = 1) },
        modifier = modifier.semantics { tag?.let { testTag = it } },
        leadingIcon = if (selected) { { Icon(Symbols.Check, null, Modifier.size(FilterChipDefaults.IconSize)) } } else null,
    )
}

/**
 * Atom 1.16, **Assist chip** (Figma 764:448): Material's own outlined `AssistChip` with Material's colours. 32 dp, 8 dp
 * corners, a 1 dp Outline variant border, no fill; the 18 dp [icon] Primary, the label Label Large On surface. For an
 * action beside content: History's Go to date, a note's date (opens the date picker), the routine player's day (opens
 * Day details). Defaults to the calendar icon, the only one the design uses.
 */
@Composable
fun AppAssistChip(
    label: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    icon: ImageVector? = Symbols.CalendarToday,
    enabled: Boolean = true,
    tag: String? = null,
) {
    AssistChip(
        onClick = onClick,
        label = { Text(label, maxLines = 1) },
        modifier = modifier.semantics { tag?.let { testTag = it } },
        enabled = enabled,
        leadingIcon = icon?.let { { Icon(it, null, Modifier.size(AssistChipDefaults.IconSize)) } },
    )
}
