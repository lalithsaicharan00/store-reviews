package com.oftenenough.app.ui.components

import com.oftenenough.app.ui.theme.Symbols
import androidx.compose.foundation.layout.size
import androidx.compose.material3.Icon
import androidx.compose.material3.Switch
import androidx.compose.material3.SwitchDefaults
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier

/**
 * Atom 1.14, **Switch** (Figma 1070:246400; Components — Atoms Build Plan): Material's own `Switch` with Material's
 * colours. 52 × 32, a full pill. **On: a Primary track and a 24 dp On primary handle with a ✓ in it** (Material's icon
 * slot, `thumbContent`, in its own On primary container colour). **Off: a Surface container highest track with a 2 dp
 * Outline border and a 16 dp Outline handle.** Disabled, Material's own.
 *
 * In a row that is itself the toggle, pass `onCheckedChange = null`.
 */
@Composable
fun AppSwitch(checked: Boolean, onCheckedChange: ((Boolean) -> Unit)? = null, modifier: Modifier = Modifier, enabled: Boolean = true) {
    Switch(
        checked, onCheckedChange, modifier,
        thumbContent = if (checked) { { Icon(Symbols.Check, null, Modifier.size(SwitchDefaults.IconSize)) } } else null,
        enabled = enabled,
    )
}
