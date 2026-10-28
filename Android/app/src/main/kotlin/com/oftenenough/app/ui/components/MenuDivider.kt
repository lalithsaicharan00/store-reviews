package com.oftenenough.app.ui.components

import androidx.compose.foundation.layout.padding
import androidx.compose.material3.HorizontalDivider
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

/**
 * Atom 1.19, **Menu divider** (Figma 734:74; Components — Atoms Build Plan): Material's own `HorizontalDivider` with
 * Material's colour (1 dp, Outline variant), 12 dp in from the menu's sides and 2 above and below (Material's menu
 * divider padding, `MenuDefaults.HorizontalDividerPadding` from Material 1.5). Between a menu's groups: what you do
 * to an item, then Archive, Restore or Delete.
 */
@Composable
fun MenuDivider() = HorizontalDivider(Modifier.padding(horizontal = 12.dp, vertical = 2.dp))
