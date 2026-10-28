package com.oftenenough.app.ui.components

import androidx.compose.material3.MenuDefaults
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.ExposedDropdownMenu
import androidx.compose.material3.ExposedDropdownMenuAnchorType
import androidx.compose.material3.ExposedDropdownMenuBox
import androidx.compose.material3.ExposedDropdownMenuDefaults
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag

/**
 * Atom 1.10, **Dropdown field** (Figma 1075:1967; Components — Atoms Build Plan): Material's own outlined exposed
 * dropdown as it is, `ExposedDropdownMenuBox` around a read-only `OutlinedTextField`. 56 dp high, Material's 4 dp corners,
 * a 1 dp Outline border, the label (Body Small) in a gap in the border, the value Body Large On surface, ▾ On surface
 * variant; focused, the border and label are Primary. Every one of those is Material's default, so nothing is set here.
 *
 * Where it's used: How often › On a date (Repeat on; Which and Day; Month and Day) and How much / Limit (Unit).
 * The menu under it is the field's width and looks like every other menu (atom 2.5): Material's Expressive menu colour,
 * Surface container low, and its 16 dp corners, with [AppMenuItem]s that mark the chosen value.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun DropdownField(
    label: String,
    value: String,
    options: List<String>,
    onPick: (Int) -> Unit,
    modifier: Modifier = Modifier,
    tag: String? = null,
) {
    var open by remember { mutableStateOf(false) }
    ExposedDropdownMenuBox(open, { open = it }, modifier) {
        Field(label, value, open, Modifier.menuAnchor(ExposedDropdownMenuAnchorType.PrimaryNotEditable), tag)
        ExposedDropdownMenu(open, { open = false }, shape = MenuDefaults.standaloneGroupShape, containerColor = MenuDefaults.groupStandardContainerColor) {
            options.forEachIndexed { i, option ->
                AppMenuItem(option, { open = false; onPick(i) }, selected = option == value)
            }
        }
    }
}

/**
 * The same field when its choices are a page of their own (How much's **Unit**, with search and your own units): the
 * tap opens that page instead of a menu.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun DropdownField(label: String, value: String, onClick: () -> Unit, modifier: Modifier = Modifier, tag: String? = null) {
    ExposedDropdownMenuBox(false, { if (it) onClick() }, modifier) {
        Field(label, value, false, Modifier.menuAnchor(ExposedDropdownMenuAnchorType.PrimaryNotEditable), tag)
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun Field(label: String, value: String, open: Boolean, anchor: Modifier, tag: String?) {
    OutlinedTextField(
        value = value,
        onValueChange = {},
        modifier = anchor.fillMaxWidth().semantics { tag?.let { testTag = it } },
        readOnly = true,
        singleLine = true,
        label = { Text(label) },
        trailingIcon = { ExposedDropdownMenuDefaults.TrailingIcon(open) },
    )
}
