package com.oftenenough.app.ui.theme

import androidx.compose.animation.AnimatedContentTransitionScope
import androidx.compose.animation.ContentTransform
import androidx.compose.animation.core.FastOutLinearInEasing
import androidx.compose.animation.core.FastOutSlowInEasing
import androidx.compose.animation.core.LinearOutSlowInEasing
import androidx.compose.animation.core.tween
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.animation.slideInHorizontally
import androidx.compose.animation.slideOutHorizontally
import androidx.compose.animation.togetherWith
import androidx.compose.runtime.Composable
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.unit.dp

/**
 * Material's **shared axis X**, the motion for moving through the steps of one flow (onboarding, a setup): the new
 * screen slides in 30 dp from the side it comes from while fading in, the old one slides 30 dp the other way while
 * fading out; going back runs it in reverse. 300 ms in all, so the app keeps its snappy feel.
 *
 * The user, 13 Oct 2026: tapping an onboarding choice jumped to the next screen with no motion, "snappy … but very
 * boring"; they asked for Android's own kind of slide, "very performance efficient". So:
 * - **Only offset and alpha move.** Both are drawn on the GPU layer; nothing is measured or laid out again during the
 *   motion, and the two screens exist side by side only for those 300 ms.
 * - **Never a longer or bouncier motion here** without the user's say-so: they liked the speed and want it kept.
 * - The timings are Material's shared axis: the old screen fades out in the first 90 ms, the new one fades in over the
 *   remaining 210 ms, and both slide for the whole 300 ms with the standard easing.
 */
fun <S> AnimatedContentTransitionScope<S>.sharedAxisX(forward: Boolean, slidePx: Int): ContentTransform {
    val slide = tween<androidx.compose.ui.unit.IntOffset>(SHARED_AXIS_MS, easing = FastOutSlowInEasing)
    val enter = slideInHorizontally(slide) { if (forward) slidePx else -slidePx } +
        fadeIn(tween(SHARED_AXIS_MS - FADE_OUT_MS, delayMillis = FADE_OUT_MS, easing = LinearOutSlowInEasing))
    val exit = slideOutHorizontally(slide) { if (forward) -slidePx else slidePx } +
        fadeOut(tween(FADE_OUT_MS, easing = FastOutLinearInEasing))
    return enter togetherWith exit
}

/** The 30 dp the shared axis slides, in pixels for this screen. */
@Composable
fun sharedAxisSlidePx(): Int = with(LocalDensity.current) { 30.dp.roundToPx() }

private const val SHARED_AXIS_MS = 300
private const val FADE_OUT_MS = 90
