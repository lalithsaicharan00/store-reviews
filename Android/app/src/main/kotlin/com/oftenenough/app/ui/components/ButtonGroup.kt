package com.oftenenough.app.ui.components

import com.oftenenough.app.ui.theme.Symbols
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.size
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.ButtonGroupDefaults
import androidx.compose.material3.ExperimentalMaterial3ExpressiveApi
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.ToggleButton
import androidx.compose.material3.ToggleButtonDefaults
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.role
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp

/**
 * Atom 1.3, **Connected button group** (Figma 967:611, 967:612; Components — Atoms Build Plan): Material 3 Expressive's
 * own connected `ToggleButton`s (Material 1.5, Android A76), one choice from a few, side by side and equal: Week · Month
 * · Year, One-time · Repeating, Days · Weeks · Months. 40 dp, Label Large, 2 dp apart, Material's connected shapes:
 * the outer ends round, the inner corners 8, **the chosen one fully round**, with Material's ✓ before its label.
 *
 * One setting of the design's: not chosen is **Secondary container** (Material's is Surface container, the page's own
 * colour, where the buttons would vanish); chosen is Material's Primary. With three or more, 12 at the sides instead
 * of Material's 16, so "✓ Weeks" fits a third of a 360 dp phone (Figma's 97 dp). A long label wraps to a second line
 * rather than being cut. TalkBack reads each as a radio button. [tag] names the group; each button is "[tag]-[index]".
 */
@OptIn(ExperimentalMaterial3ExpressiveApi::class)
@Composable
fun <T> AppConnectedButtons(options: List<Pair<T, String>>, selected: T, modifier: Modifier = Modifier, tag: String? = null, onPick: (T) -> Unit) {
    val s = MaterialTheme.colorScheme
    val colors = ToggleButtonDefaults.colors(containerColor = s.secondaryContainer, contentColor = s.onSecondaryContainer)
    Row(modifier.fillMaxWidth().semantics { tag?.let { testTag = it } }, horizontalArrangement = Arrangement.spacedBy(ButtonGroupDefaults.ConnectedSpaceBetween)) {
        options.forEachIndexed { i, (value, label) ->
            val on = value == selected
            ToggleButton(
                checked = on,
                onCheckedChange = { onPick(value) },
                modifier = Modifier.weight(1f).semantics { role = Role.RadioButton; tag?.let { testTag = "$it-$i" } },
                shapes = when (i) {
                    0 -> ButtonGroupDefaults.connectedLeadingButtonShapes()
                    options.lastIndex -> ButtonGroupDefaults.connectedTrailingButtonShapes()
                    else -> ButtonGroupDefaults.connectedMiddleButtonShapes()
                },
                colors = colors,
                contentPadding = if (options.size >= 3) PaddingValues(horizontal = 12.dp, vertical = 8.dp) else ButtonDefaults.ContentPadding,
            ) {
                if (on) { Icon(Symbols.Check, null, Modifier.size(ToggleButtonDefaults.IconSize)); Spacer(Modifier.size(ToggleButtonDefaults.IconSpacing)) }
                Text(label, maxLines = 2, textAlign = TextAlign.Center)
            }
        }
    }
}
