package com.oftenenough.app.ui.components

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.RowScope
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.ModalBottomSheet
import androidx.compose.material3.SheetState
import androidx.compose.material3.SheetValue
import androidx.compose.material3.rememberBottomSheetState
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp

/**
 * Atom 1.18, **Bottom sheet** (Figma 737:184; Components — Atoms Build Plan): Material's own `ModalBottomSheet` as it
 * is: Surface container low, 28 dp top corners, Material's drag handle (1.17), its scrim, up to 640 dp wide. Opened
 * whole ([sheetState] skips the half-open stop) and scrolling, so its buttons are never under the gesture bar. What the
 * design adds, all optional:
 *
 * - a **header**: [title] in a Top app bar (1.6) on the sheet's colour, Title Large Emphasized, 16 dp in;
 * - the **content**: anything; it brings its own side padding (16 for text and cards; list items run edge to edge);
 * - **actions**: Text and Filled buttons, right-aligned, 16 dp in, 8 apart, 16 under the content;
 * - 24 dp under everything.
 *
 * Day details and the milestone pop-up are sheets of their own built on `ModalBottomSheet` with these same defaults.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AppBottomSheet(
    onDismiss: () -> Unit,
    modifier: Modifier = Modifier,
    title: String? = null,
    sheetState: SheetState = rememberWholeSheetState(),
    actions: (@Composable RowScope.() -> Unit)? = null,
    content: @Composable ColumnScope.() -> Unit,
) {
    ModalBottomSheet(onDismiss, sheetState = sheetState) {
        Column(modifier.fillMaxWidth().verticalScroll(rememberScrollState())) {
            if (title != null) AppTopBar(title, containerColor = Color.Transparent, windowInsets = WindowInsets(0))
            content()
            if (actions != null) Row(
                Modifier.fillMaxWidth().padding(top = 16.dp).padding(horizontal = 16.dp),
                horizontalArrangement = Arrangement.spacedBy(8.dp, Alignment.End),
                verticalAlignment = Alignment.CenterVertically,
                content = actions,
            )
            Spacer(Modifier.height(24.dp))
        }
    }
}

/**
 * A modal sheet's state, opened whole: it skips Material's half-open stop, so a sheet's buttons are never below the
 * screen (T22). Material 1.5's way of saying it: a sheet that starts hidden and only ever rests hidden or expanded.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun rememberWholeSheetState(): SheetState = rememberBottomSheetState(SheetValue.Hidden, setOf(SheetValue.Hidden, SheetValue.Expanded))
