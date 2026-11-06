package com.oftenenough.app.ui.components

import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.navigationBars
import androidx.compose.foundation.layout.tappableElement
import androidx.compose.foundation.layout.windowInsetsBottomHeight
import androidx.compose.material3.DrawerState
import androidx.compose.material3.DrawerValue
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.snapshotFlow
import androidx.compose.runtime.staticCompositionLocalOf
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.platform.LocalDensity
import com.oftenenough.app.ui.theme.appColors

/**
 * How much of the page's colour lies over the pages under Android's three buttons: 90 %, the step Figma's Bottom fade
 * reaches before its end, and Android's own light scrim.
 */
const val NavBarScrimAlpha = 0.9f

/** True when Android shows its three buttons at the bottom (gesture navigation has nothing to tap there). */
@Composable
fun threeButtonNavigation(): Boolean = WindowInsets.tappableElement.getBottom(LocalDensity.current) > 0

/**
 * True when Android shows buttons on any side (a phone on its side keeps them at its end), so Back is a press. With
 * buttons there is no edge swipe, and with gestures no arrow: this is what tells a press from a swipe on Android 15,
 * which reports both alike (Android A115).
 */
@Composable
fun backIsAButton(): Boolean {
    val density = LocalDensity.current
    val direction = androidx.compose.ui.platform.LocalLayoutDirection.current
    val bar = WindowInsets.tappableElement
    return bar.getBottom(density) > 0 || bar.getLeft(density, direction) > 0 || bar.getRight(density, direction) > 0
}

/** Whether a menu drawer is open, told by the page that holds it ([ReportMenu]); the bar's tint steps aside then. */
val LocalMenuOpen = staticCompositionLocalOf<MutableState<Boolean>?> { null }

/** Tells [NavBarScrim] while [drawer] is open or opening, and that it's closed once the page goes. */
@Composable
fun ReportMenu(drawer: DrawerState) {
    val open = LocalMenuOpen.current ?: return
    LaunchedEffect(drawer) {
        snapshotFlow { drawer.currentValue == DrawerValue.Open || drawer.targetValue == DrawerValue.Open }.collect { open.value = it }
    }
    DisposableEffect(drawer) { onDispose { open.value = false } }
}

/**
 * The tint under Android's three buttons (the user, 1 Nov 2026: "some color, but with some opacity … like how YouTube
 * does it … matching with the overall app"): the page's colour at [NavBarScrimAlpha] over whatever scrolls behind,
 * neither clear nor solid. Gesture navigation keeps the page as it is, with nothing drawn. While the menu is open the
 * tint fades away, so the drawer and its dim reach the bottom of the screen; sheets and dialogs are windows of their
 * own and dim everything themselves.
 */
@Composable
fun NavBarScrim(modifier: Modifier = Modifier) {
    if (!threeButtonNavigation()) return
    val menuOpen = LocalMenuOpen.current?.value == true
    val shown by animateFloatAsState(if (menuOpen) 0f else 1f, label = "bar tint")
    Box(modifier.fillMaxWidth().windowInsetsBottomHeight(WindowInsets.navigationBars).graphicsLayer { alpha = shown }
        .background(appColors.screen.copy(alpha = NavBarScrimAlpha)))
}
