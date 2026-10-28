package com.oftenenough.app.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.Symbols

/**
 * Atom 3.3, **Plus label** (Figma 1208:1983; Components — Atoms Build Plan): marks the one thing on a screen that needs
 * Plus. A pill of Primary: the filled workspace_premium medal, 16 dp, then "Plus" in Label Medium, both On primary, 4
 * between, 4 above and below, 8 before and 10 after (24 dp tall). It only marks: the row or card it sits in is what
 * opens the Plus screen. Once per screen.
 *
 * In a list item it goes beside the name ([AppListItem]'s `beside`, 8 apart) when the name is short, or on its own
 * line under the supporting text (`below`) when they don't fit beside a trailing icon; never remove the trailing icon
 * to make room. On a card, it leads the heading, 8 before the title.
 */
@Composable
fun PlusLabel(modifier: Modifier = Modifier) {
    val s = MaterialTheme.colorScheme
    Row(
        modifier.clip(CircleShape).background(s.primary).padding(start = 8.dp, end = 10.dp, top = 4.dp, bottom = 4.dp),
        horizontalArrangement = Arrangement.spacedBy(4.dp), verticalAlignment = Alignment.CenterVertically,
    ) {
        Icon(Symbols.Filled.WorkspacePremium, null, Modifier.size(16.dp), tint = s.onPrimary)
        Text("Plus", style = AppType.labelMedium, color = s.onPrimary)
    }
}
