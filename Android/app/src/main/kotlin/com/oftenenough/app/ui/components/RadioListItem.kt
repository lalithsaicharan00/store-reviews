package com.oftenenough.app.ui.components

import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.selection.selectable
import androidx.compose.ui.unit.dp
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
    // The words keep the room they have on one line however long they get, as [AppListItem]'s do: Material's 8 is the
    // radio's, the rest of its 56 (or 72 with a line under) is theirs.
    val words = if (supporting != null) 6.dp else 8.dp
    ListItem(
        modifier = modifier.selectable(selected, onClick = onClick, role = Role.RadioButton).semantics { tag?.let { testTag = it } },
        supportingContent = supporting?.let { { Text(it, Modifier.padding(bottom = words)) } },
        leadingContent = { RadioButton(selected, null) },
        colors = ListItemDefaults.colors(containerColor = Color.Transparent),
    ) { Text(label, Modifier.padding(top = words, bottom = if (supporting != null) 0.dp else words)) }
}
