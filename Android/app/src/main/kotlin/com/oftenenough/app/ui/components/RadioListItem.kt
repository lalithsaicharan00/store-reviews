package com.oftenenough.app.ui.components

import androidx.compose.foundation.selection.selectable
import androidx.compose.material3.ListItem
import androidx.compose.material3.ListItemDefaults
import androidx.compose.material3.RadioButton
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag

/**
 * Atom 1.13, **Radio list item** (Figma 737:183; Components — Atoms Build Plan): Material's own `ListItem` with a
 * leading `RadioButton` (1.12), as it is. 56 dp with one line, 72 with [supporting] text; the label Body Large On
 * surface, the supporting text Body Medium On surface variant; the whole row is the tap target (`selectable`, a radio
 * button to TalkBack). The one thing set: **no colour of its own**, so it sits on its sheet (Material's item is
 * Surface). It runs edge to edge: put it outside a sheet's side padding.
 *
 * Where it's used: the Pause sheet's lengths (1 week, 2 weeks, Until a date…, Until I resume it).
 */
@Composable
fun RadioListItem(
    label: String,
    selected: Boolean,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    supporting: String? = null,
    tag: String? = null,
) {
    ListItem(
        modifier = modifier.selectable(selected, onClick = onClick, role = Role.RadioButton).semantics { tag?.let { testTag = it } },
        supportingContent = supporting?.let { { Text(it) } },
        leadingContent = { RadioButton(selected, null) },
        colors = ListItemDefaults.colors(containerColor = Color.Transparent),
    ) { Text(label) }
}
