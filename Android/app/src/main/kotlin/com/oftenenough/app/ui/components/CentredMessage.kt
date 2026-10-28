package com.oftenenough.app.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors

/**
 * A whole-screen message with no top bar, as Figma's **No internet** (5.1.6, Figma 582:8426) and **Restoring** (5.1.4,
 * 582:7893) draw it: centred in the space over its buttons, 24 at the sides, its [mark] (64), 24, the [title] in
 * Headline Small Emphasized On surface over the [line] in Body Medium On surface variant, 8 apart, centred, the full
 * width; the [bottom] buttons in a bar, 12 above and below, 16 at the sides, 8 apart (a Medium Filled one, then
 * Medium Text). On the page colour.
 */
@Composable
fun CentredMessage(title: String, line: String, tag: String, mark: @Composable () -> Unit, bottom: @Composable ColumnScope.() -> Unit = {}) {
    val s = MaterialTheme.colorScheme
    Column(Modifier.fillMaxSize().background(appColors.screen).statusBarsPadding().navigationBarsPadding().semantics { testTag = tag }) {
        Column(Modifier.weight(1f).fillMaxWidth().padding(horizontal = 24.dp),
            horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.Center) {
            mark()
            Spacer(Modifier.height(24.dp))
            Text(title, Modifier.fillMaxWidth(), style = AppType.headlineSmallEmphasized, color = s.onSurface, textAlign = TextAlign.Center)
            Spacer(Modifier.height(8.dp))
            Text(line, Modifier.fillMaxWidth(), style = AppType.bodyMedium, color = s.onSurfaceVariant, textAlign = TextAlign.Center)
        }
        Column(Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 12.dp), verticalArrangement = Arrangement.spacedBy(8.dp),
            horizontalAlignment = Alignment.CenterHorizontally, content = bottom)
    }
}

/** The message's icon: [icon] (28, On surface) in a 64 dp circle of Surface container highest (Figma's Icon). */
@Composable
fun MessageIcon(icon: ImageVector) {
    val s = MaterialTheme.colorScheme
    Box(Modifier.size(64.dp).clip(CircleShape).background(s.surfaceContainerHighest), contentAlignment = Alignment.Center) {
        Icon(icon, null, Modifier.size(28.dp), tint = s.onSurface)
    }
}
