package com.oftenenough.app.ui.plus

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.BoxWithConstraints
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import com.oftenenough.app.R
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.AppTopBar
import com.oftenenough.app.ui.components.ButtonSize
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.NavigationIcon
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.theme.appColors

/*
 * The pieces the Plus screen and the restore flows share. Text is only the shared styles (AppType); rows and buttons
 * have minimum heights, never fixed ones, so a larger font grows them.
 */

/**
 * The app icon on its tile (the light tile in light mode, as approved; Brand/Logo Guide.md). Lifted by a soft shadow
 * on a flow's hero and Get Plus (Figma 2, 2.2); [flat] in Plus & Account's white card, where it sits on white (Figma 1).
 */
@Composable
fun AppIconTile(size: Dp, flat: Boolean = false) {
    val c = appColors
    val shape = RoundedCornerShape(size * (if (flat) 0.27f else 0.3f))
    Box(Modifier.size(size).let { if (flat) it else it.shadow(size * 0.05f, shape) }.clip(shape).background(c.surface)) {
        Image(painterResource(if (c.dark) R.drawable.mark_dark else R.drawable.mark_light), null, Modifier.size(size))
    }
}

/** The app's mark alone, small (the Plus screen's example notifications). */
@Composable
fun MarkIcon(size: Dp = 24.dp) =
    Image(painterResource(if (appColors.dark) R.drawable.mark_dark else R.drawable.mark_light), null, Modifier.size(size))

/**
 * A step of a flow: an optional back arrow, the content (scrolls when the font is large), and its buttons pinned at the
 * bottom. The content sits in the middle of the space between the top and the buttons, as every flow frame draws it;
 * [top] keeps it under the bar instead (Figma 3.4, a list). Back (the system's too) does what the arrow does.
 */
@Composable
fun FlowScreen(
    onBack: (() -> Unit)?, tag: String, showBack: Boolean = true, top: Boolean = false,
    bottom: @Composable ColumnScope.() -> Unit = {}, content: @Composable ColumnScope.() -> Unit,
) {
    val c = appColors
    if (onBack != null) BackHandler(onBack = onBack)
    Column(Modifier.fillMaxSize().background(c.screen).statusBarsPadding().navigationBarsPadding().semantics { testTag = tag }) {
        if (onBack != null && showBack) AppTopBar(null, navigationIcon = {
            NavigationIcon(Symbols.ArrowBack, "Back", onBack, Modifier.semantics { testTag = "flow-back" })
        }, windowInsets = WindowInsets(0))
        BoxWithConstraints(Modifier.weight(1f).fillMaxWidth()) {
            val room = maxHeight
            Column(Modifier.fillMaxSize().verticalScroll(rememberScrollState()).padding(horizontal = 16.dp)) {
                Column(Modifier.fillMaxWidth().heightIn(min = room), horizontalAlignment = Alignment.CenterHorizontally,
                    verticalArrangement = if (top) Arrangement.Top else Arrangement.Center) {
                    // Figma's content starts right under the top bar; a centred message keeps 24 above it.
                    if (!top) Spacer(Modifier.height(24.dp))
                    content()
                    Spacer(Modifier.height(24.dp))
                }
            }
        }
        Column(Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 12.dp), verticalArrangement = Arrangement.spacedBy(8.dp),
            horizontalAlignment = Alignment.CenterHorizontally, content = bottom)
    }
}

/** A flow's main button: the Medium Filled button (2.1), full width. */
@Composable
fun MainButton(text: String, tag: String, icon: ImageVector? = null, enabled: Boolean = true, onClick: () -> Unit) =
    AppButton(text, onClick, Modifier.fillMaxWidth(), size = ButtonSize.Medium, icon = icon, enabled = enabled, tag = tag)

/**
 * A flow's quiet button ("Not now", "Cancel", "Close"): the Medium Text button (2.1), full width. "I already have Plus"
 * under Get Plus is the Small one (Figma 2: [height] under 56, or [small]).
 */
@Composable
fun QuietButton(text: String, tag: String, height: Dp = 56.dp, small: Boolean = false, onClick: () -> Unit) =
    AppButton(text, onClick, Modifier.fillMaxWidth(), style = ButtonStyle.Text,
        size = if (small || height < 56.dp) ButtonSize.Small else ButtonSize.Medium, tag = tag)
