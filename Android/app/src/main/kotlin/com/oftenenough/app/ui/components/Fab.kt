package com.oftenenough.app.ui.components

import androidx.compose.material3.ExperimentalMaterial3ExpressiveApi
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.SmallExtendedFloatingActionButton
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag

/**
 * Atom 1.4, **Extended FAB** (Figma 1043:72991; Components — Atoms Build Plan): Material 3 Expressive's own small
 * extended FAB as it is (Material 1.5, Android A76): 56 dp, 16 dp corners, a 24 dp icon, Title Medium, Material's
 * padding and Level 3 shadow. One setting of the design's: **Primary with On primary**, like the Filled button
 * (Material's is Primary container, our light grey). It floats 16 from the right and 16 above the gesture bar; the
 * caller places it ([modifier]) and leaves room under the list's last row. History's Add, Times of day's Add time of day.
 */
@OptIn(ExperimentalMaterial3ExpressiveApi::class)
@Composable
fun AppExtendedFab(text: String, icon: ImageVector, onClick: () -> Unit, modifier: Modifier = Modifier, tag: String? = null) =
    SmallExtendedFloatingActionButton(
        text = { Text(text) },
        icon = { Icon(icon, null) },
        onClick = onClick,
        modifier = modifier.semantics { tag?.let { testTag = it } },
        containerColor = MaterialTheme.colorScheme.primary,
    )
