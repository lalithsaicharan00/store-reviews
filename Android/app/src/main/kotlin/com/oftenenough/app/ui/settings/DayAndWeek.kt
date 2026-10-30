package com.oftenenough.app.ui.settings

import com.oftenenough.app.ui.components.AppMenuItem
import com.oftenenough.app.ui.components.AppMenu
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.theme.Symbols
import androidx.compose.foundation.layout.Box
import androidx.compose.material3.Icon
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.unit.dp

/** Material's exposed dropdown as a row: icon, title, the value under it, ▾; a menu that marks the chosen value. */
@Composable
fun DropdownRow(title: String, value: String, icon: ImageVector, options: List<String>, selected: Int, tag: String, onPick: (Int) -> Unit) {
    var open by remember { mutableStateOf(false) }
    Box {
        AppListItem(title, 0, 1, supporting = value, leading = { Icon(icon, null) }, trailing = { Icon(Symbols.ArrowDropDown, null) },
            onClick = { open = true }, tag = tag)
        AppMenu(open, { open = false }, maxHeight = 480.dp) {
            options.forEachIndexed { i, option ->
                AppMenuItem(option, { open = false; onPick(i) }, selected = i == selected)
            }
        }
    }
}
