package com.oftenenough.app.ui.components

import androidx.compose.foundation.layout.size
import androidx.compose.material3.FilledIconToggleButton
import androidx.compose.material3.IconButtonDefaults
import androidx.compose.material3.LocalMinimumInteractiveComponentSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.theme.AppType

/** Which Day toggle (Figma Day toggle, Size). */
enum class DayToggleSize(val size: Dp) {
    /** A day of the week, S M T W T F S: 34 dp on Surface container highest, Label Large. */
    Week(34.dp),
    /** A date of the month, 1 to 31: 40 dp, nothing behind it until it's chosen, Body Large. */
    Date(40.dp);

    val label: TextStyle @Composable get() = if (this == Week) AppType.labelLarge else AppType.bodyLarge
}

/**
 * Atom 2.7, **Day toggle** (Figma 1075:1966; Components — Atoms Build Plan): Material's own round `FilledIconToggleButton`,
 * a letter or a date in place of its icon. Material's: the round shape, Primary with On primary once chosen, the
 * switched-off colours, read as a checkbox. The design's small settings:
 *
 * - **Size** ([DayToggleSize]): 34 for the week's seven, so they fit 328 dp with room between them, and 40 for the
 *   month's dates (Material's is 40). Seven in a row leave no room for Material's 48 dp touch area each, so a row
 *   of them has none: the 34 or 40 is the target, with the row's space between.
 * - **Not chosen:** On surface on Surface container highest for a weekday, on nothing for a date (Material's is On
 *   surface variant on Surface container).
 *
 * [spoken] is what TalkBack reads (the day's full name, "Day 12").
 */
@Composable
fun DayToggle(
    label: String,
    checked: Boolean,
    onCheckedChange: (Boolean) -> Unit,
    spoken: String,
    modifier: Modifier = Modifier,
    size: DayToggleSize = DayToggleSize.Week,
    enabled: Boolean = true,
) {
    val s = MaterialTheme.colorScheme
    val colors = IconButtonDefaults.filledIconToggleButtonColors(
        containerColor = if (size == DayToggleSize.Week) s.surfaceContainerHighest else Color.Transparent,
        contentColor = s.onSurface,
    )
    CompositionLocalProvider(LocalMinimumInteractiveComponentSize provides Dp.Unspecified) {
        FilledIconToggleButton(checked, onCheckedChange, modifier.size(size.size).semantics { contentDescription = spoken },
            enabled, colors = colors) {
            Text(label, style = size.label)
        }
    }
}
