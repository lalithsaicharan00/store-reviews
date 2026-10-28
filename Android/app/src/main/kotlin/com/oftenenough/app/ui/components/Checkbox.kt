package com.oftenenough.app.ui.components

import androidx.compose.material3.Checkbox
import androidx.compose.material3.CheckboxDefaults
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color

/**
 * Atom 1.11, **Checkbox** (Figma 1096:1974; Components — Atoms Build Plan): Material's own `Checkbox` as it is, an 18 dp
 * box with 2 dp corners in a 40 dp state layer. **Ticked, the box is Primary with an On primary tick; not ticked, a 2 dp
 * On surface variant outline**; disabled, Material's 38 % On surface. All of that is Material's default.
 *
 * **One setting, on a habit's own rows** (a checklist's steps: Figma's Step row 575:136): the ticked box is the habit's
 * colour ([habitColor]) with a white tick. Nowhere else does a checkbox take a colour.
 *
 * In a row that is itself the toggle (`toggleable` with `Role.Checkbox`), pass `onCheckedChange = null`.
 */
@Composable
fun AppCheckbox(
    checked: Boolean,
    onCheckedChange: ((Boolean) -> Unit)?,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
    habitColor: Color? = null,
) {
    Checkbox(
        checked, onCheckedChange, modifier, enabled,
        colors = if (habitColor == null) CheckboxDefaults.colors() else CheckboxDefaults.colors(checkedColor = habitColor, checkmarkColor = Color.White),
    )
}
