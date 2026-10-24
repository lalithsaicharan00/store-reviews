package com.oftenenough.app.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.selection.selectable
import androidx.compose.foundation.selection.selectableGroup
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.rounded.Check
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors

/**
 * Material 3 Expressive's **connected button group**: two or more buttons that share a bar, the chosen one filled ink
 * with a ✓ before its word, the others tonal. The chosen one's corners go round and its neighbours' corners stay
 * squarer, so the group reads as one control. Week · Month · Year on the Habits tab and One-time · Repeating on the
 * Tasks tab are both this (Habits & Tasks, `369:28`), and both scroll away with the list.
 *
 * [tagPrefix] + each option's lowercase word is a button's test tag.
 */
@Composable
fun ConnectedButtons(
    options: List<String>,
    selected: Int,
    tagPrefix: String,
    modifier: Modifier = Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 8.dp),
    onPick: (Int) -> Unit,
) {
    val c = appColors
    Row(modifier.selectableGroup().semantics { testTag = tagPrefix.trimEnd('-') },
        horizontalArrangement = Arrangement.spacedBy(2.dp)) {
        options.forEachIndexed { i, word ->
            val on = i == selected
            val shape = when {
                on -> RoundedCornerShape(50)
                i == 0 -> RoundedCornerShape(topStart = 20.dp, bottomStart = 20.dp, topEnd = 8.dp, bottomEnd = 8.dp)
                i == options.lastIndex -> RoundedCornerShape(topStart = 8.dp, bottomStart = 8.dp, topEnd = 20.dp, bottomEnd = 20.dp)
                else -> RoundedCornerShape(8.dp)
            }
            Row(
                Modifier.weight(1f).heightIn(min = 40.dp).clip(shape).background(if (on) c.ink else c.tonal)
                    .selectable(selected = on, role = Role.RadioButton, onClick = { onPick(i) })
                    .padding(horizontal = 8.dp, vertical = 10.dp)
                    .semantics { testTag = tagPrefix + word.lowercase() },
                horizontalArrangement = Arrangement.Center,
                verticalAlignment = Alignment.CenterVertically,
            ) {
                if (on) {
                    Icon(Icons.Rounded.Check, null, Modifier.size(18.dp), tint = c.onInk)
                    Spacer(Modifier.width(8.dp))
                }
                Text(word, style = AppType.labelLarge, color = if (on) c.onInk else c.ink, maxLines = 1)
            }
        }
    }
}
