package com.oftenenough.app.ui.components

import androidx.compose.material3.ExperimentalMaterial3ExpressiveApi
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.FloatingActionButtonDefaults
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.padding
import androidx.compose.ui.Alignment
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.width
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.theme.AppType
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag

/**
 * Atom 1.4, **Extended FAB** (Figma 1043:72991; Components — Atoms Build Plan): Material 3 Expressive's own small
 * extended FAB (Material 1.5, Android A76): 56 dp, 16 dp corners, a 24 dp icon, Title Medium and Level 3 shadow. The
 * design's settings: **Primary with On primary**, like the Filled button (Material's is Primary container, our light
 * grey), and **16 before the icon, 12 between, 20 after the words** (Material's small one is 16, 8, 16; QA, 1 Nov
 * 2026: Add time of day was 9 narrower than Figma's). It floats 16 from the right and 16 above the gesture bar; the
 * caller places it ([modifier]) and leaves room under the list's last row. History's Add, Times of day's Add time of day.
 */
@OptIn(ExperimentalMaterial3ExpressiveApi::class)
@Composable
fun AppExtendedFab(text: String, icon: ImageVector, onClick: () -> Unit, modifier: Modifier = Modifier, tag: String? = null) =
    // Material's FAB surface (its colours, shadow and 56 dp) with the design's own row: Material's extended FAB pads
    // its content 20 at both sides, which put the icon 4 late.
    FloatingActionButton(
        onClick = onClick,
        modifier = modifier.semantics { tag?.let { testTag = it } },
        shape = FloatingActionButtonDefaults.extendedFabShape,
        containerColor = MaterialTheme.colorScheme.primary,
    ) {
        Row(Modifier.padding(start = 16.dp, end = 20.dp), verticalAlignment = Alignment.CenterVertically) {
            Icon(icon, null)
            Spacer(Modifier.width(12.dp))
            Text(text, style = AppType.titleMedium, maxLines = 1)
        }
    }
