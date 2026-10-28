package com.oftenenough.app.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.selection.selectable
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.theme.Symbols

/**
 * Atom 3.2, **Colour swatch** (Figma 1074:161495; Components — Atoms Build Plan): one of the thirteen habit colours in
 * the Colour sheet. Material has no colour picker, so it's ours: a 40 dp circle of the habit's own [color] (Figma's
 * "Habit / <colour> / Colour"). Chosen (Selected=True), the colour shrinks to 30, inside a 2 dp On surface ring with 5
 * between, and a 20 dp ✓ in On habit (white) sits on it.
 *
 * TalkBack reads it as a radio button: [spoken] (the colour's name), then selected or not selected. Seven to a row
 * leave no room for Material's 48 dp touch area each, so the 40 is the target, with the row's 8 between, as the
 * Day toggle's (2.7).
 */
@Composable
fun ColourSwatch(color: Color, selected: Boolean, onClick: () -> Unit, spoken: String, modifier: Modifier = Modifier) {
    Box(
        modifier.size(40.dp).clip(CircleShape)
            .then(if (selected) Modifier.border(2.dp, MaterialTheme.colorScheme.onSurface, CircleShape) else Modifier)
            .selectable(selected, onClick = onClick, role = Role.RadioButton)
            .semantics { contentDescription = spoken },
        contentAlignment = Alignment.Center,
    ) {
        Box(Modifier.size(if (selected) 30.dp else 40.dp).clip(CircleShape).background(color), contentAlignment = Alignment.Center) {
            if (selected) Icon(Symbols.Check, null, Modifier.size(20.dp), tint = Color.White)
        }
    }
}
