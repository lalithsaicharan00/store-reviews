package com.oftenenough.app.ui.components

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.widthIn
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.theme.AppType

/**
 * A screen's empty state, as Figma's **Today, no habits yet** draws it (5.1.2, Figma 547:2419; Components — Atoms Build
 * Plan): centred in what's left of the screen, 16 at the sides, 24 between the words and the [actions].
 *
 * The header, 16 apart: the [icon] (Material Symbols, 48) in a 112 dp cookie of Surface container highest, On surface;
 * the [title] in Headline Small Emphasized On surface over the [body] in Body Large On surface variant, 8 apart, both
 * centred and the full width (the body at most [bodyWidth] when a screen's design narrows it). The [actions] (Material's Small buttons, a Filled one first, then Tonal) sit centred
 * under it, 8 apart.
 */
@Composable
fun EmptyState(icon: ImageVector, title: String, body: String, modifier: Modifier = Modifier, bodyWidth: Dp = Dp.Unspecified, actions: @Composable ColumnScope.() -> Unit = {}) {
    val s = MaterialTheme.colorScheme
    Column(modifier.padding(horizontal = 16.dp), horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(24.dp)) {
        Column(Modifier.fillMaxWidth(), horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(16.dp)) {
            CookieIcon(icon, size = 112.dp, container = s.surfaceContainerHighest, tint = s.onSurface, glyph = 48f / 112f)
            Column(Modifier.fillMaxWidth(), horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(8.dp)) {
                Text(title, Modifier.fillMaxWidth(), style = AppType.headlineSmallEmphasized, color = s.onSurface, textAlign = TextAlign.Center)
                Text(body, Modifier.widthIn(max = bodyWidth).fillMaxWidth(), style = AppType.bodyLarge, color = s.onSurfaceVariant, textAlign = TextAlign.Center)
            }
        }
        Column(horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(8.dp), content = actions)
    }
}
