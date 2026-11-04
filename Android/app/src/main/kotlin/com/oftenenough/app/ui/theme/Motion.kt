package com.oftenenough.app.ui.theme

import androidx.compose.animation.AnimatedContent
import androidx.compose.animation.ContentTransform
import androidx.compose.animation.EnterExitState
import androidx.compose.animation.EnterTransition
import androidx.compose.animation.ExitTransition
import androidx.compose.animation.core.Animatable
import androidx.compose.animation.core.CubicBezierEasing
import androidx.compose.animation.core.Easing
import androidx.compose.animation.core.LinearEasing
import androidx.compose.animation.core.PathEasing
import androidx.compose.animation.core.Transition
import androidx.compose.animation.core.tween
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.animation.scaleIn
import androidx.compose.animation.scaleOut
import androidx.compose.animation.slideInHorizontally
import androidx.compose.animation.slideOutHorizontally
import androidx.compose.animation.togetherWith
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.derivedStateOf
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.composed
import androidx.compose.ui.draw.drawWithContent
import androidx.compose.ui.focus.onFocusChanged
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.layout.layout
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.platform.LocalFocusManager
import androidx.compose.ui.platform.LocalLayoutDirection
import androidx.compose.ui.unit.LayoutDirection
import androidx.compose.ui.unit.dp

/*
 * The app's one way of moving between screens (Android A112; Research/Research Reports/Motion and Transitions/). Every
 * number here was read from this phone's Android 15 system files or measured frame by frame in Google's own apps.
 *
 * - A page, and anything deeper or back up: Android's own page transition, the one Settings, Clock's settings, Files and
 *   Gmail's compose play, and the one the app's other activities get from the system.
 * - The menu's own places, one to another (Today, Habits & Tasks, Settings): fade through, as Gmail's folders and Drive's.
 * - Something new in the same place (a tab, another day): the new content arrives, nothing is drawn twice ([arrival]).
 *
 * Only offset, alpha and scale move: drawn on the GPU layer, nothing measured or laid out again during the motion.
 */

/** Android's emphasized curve (`fast_out_extra_slow_in` in framework-res): quick, then a long soft landing. */
val Emphasized: Easing = PathEasing(Path().apply {
    moveTo(0f, 0f)
    cubicTo(0.05f, 0f, 0.133333f, 0.06f, 0.166666f, 0.4f)
    cubicTo(0.208333f, 0.82f, 0.25f, 1f, 1f, 1f)
})

/** Material's emphasized decelerate: things that arrive. */
val EmphasizedDecelerate: Easing = CubicBezierEasing(0.05f, 0.7f, 0.1f, 1f)

/** Material's emphasized accelerate: things that leave. */
val EmphasizedAccelerate: Easing = CubicBezierEasing(0.3f, 0f, 0.8f, 0.15f)

/** The page transition's numbers, from `activity_open_enter`, `activity_open_exit` and their `close` pair on Android 15. */
const val PAGE_MS = 450
private const val PAGE_SLIDE_DP = 96
private const val PAGE_FADE_MS = 83
private const val PAGE_FADE_IN_AFTER_MS = 50
private const val PAGE_FADE_OUT_AFTER_MS = 35
private const val PAGE_GONE_NANOS = 120_000_000L

/** Material's fade through: the old place gone in 90 ms, the new one over the next 210 ms, growing from 92 %. */
private const val THROUGH_OUT_MS = 90
private const val THROUGH_IN_MS = 210
private const val THROUGH_SCALE = 0.92f

/** A back swipe's preview: the page shrinks to Material's 90 % as it follows the finger. */
private const val BACK_SWIPE_SCALE = 0.9f

/** What's new in the same place: 200 ms in, from this far along its way. */
private const val ARRIVAL_MS = 200
private const val ARRIVAL_SLIDE_DP = 24

/**
 * The app's transitions, made once for the phone's density and reading direction: a right-to-left phone mirrors them
 * ([slide] is signed). Built with [rememberPageMotion], used by the NavHost and by [PageSwitch].
 */
class PageMotion(private val slide: Int) {
    private fun <T> moving() = tween<T>(PAGE_MS, easing = Emphasized)

    /** A deeper page comes in from the side, showing within its first 133 ms over the page it leaves behind. */
    val enter: EnterTransition = slideInHorizontally(moving()) { slide } +
        fadeIn(tween(PAGE_FADE_MS, delayMillis = PAGE_FADE_IN_AFTER_MS, easing = LinearEasing))

    /** The page left behind moves the other way, and stays solid under the new one. */
    val exit: ExitTransition = slideOutHorizontally(moving()) { -slide }

    /** Back: the page underneath returns from where it went. */
    val popEnter: EnterTransition = slideInHorizontally(moving()) { -slide }

    /** Back: the page leaving goes back the way it came, gone within its first 118 ms. */
    val popExit: ExitTransition = slideOutHorizontally(moving()) { slide } +
        fadeOut(tween(PAGE_FADE_MS, delayMillis = PAGE_FADE_OUT_AFTER_MS, easing = LinearEasing))

    /** While a back swipe is held the page follows the finger, so nothing eases: the swipe is the curve. */
    private fun <T> followed() = tween<T>(PAGE_MS, easing = LinearEasing)

    /** A back swipe: the page underneath comes back at the same pace as the finger. */
    val swipeEnter: EnterTransition = slideInHorizontally(followed()) { -slide }

    /** A back swipe: the page leaving shrinks and moves away with the finger (the system's own preview between activities). */
    val swipeExit: ExitTransition = scaleOut(followed(), targetScale = BACK_SWIPE_SCALE) +
        slideOutHorizontally(followed()) { slide } +
        fadeOut(tween(PAGE_MS / 8, delayMillis = PAGE_MS * 7 / 8, easing = LinearEasing))

    /** Fade through, in: over the old place once it has gone. */
    val throughEnter: EnterTransition =
        fadeIn(tween(THROUGH_IN_MS, delayMillis = THROUGH_OUT_MS, easing = LinearEasing)) +
            scaleIn(tween(THROUGH_IN_MS, delayMillis = THROUGH_OUT_MS, easing = EmphasizedDecelerate), initialScale = THROUGH_SCALE)

    /** Fade through, out. */
    val throughExit: ExitTransition = fadeOut(tween(THROUGH_OUT_MS, easing = EmphasizedAccelerate))

    /** The page transition for a [PageSwitch], with the leaving page on top going back, as the NavHost does. */
    fun switch(forward: Boolean): ContentTransform = (if (forward) enter togetherWith exit else popEnter togetherWith popExit).apply {
        targetContentZIndex = if (forward) 1f else -1f
    }
}

/**
 * Whether the page leaving now is held by a back swipe. Only the NavHost's transitions know, and they say so as each one
 * starts: Compose keeps its own `Transition.isSeeking` to itself.
 */
object BackSwipe {
    var holding = false
    val leaving: () -> Boolean = { holding }
}

/** The app's [PageMotion] for this phone. */
@Composable
fun rememberPageMotion(): PageMotion {
    val px = with(LocalDensity.current) { PAGE_SLIDE_DP.dp.roundToPx() }
    val signed = if (LocalLayoutDirection.current == LayoutDirection.Rtl) -px else px
    return remember(signed) { PageMotion(signed) }
}

/**
 * Pages a screen opens over itself, in its own steps (the habit form's pages, the choices before it, All milestones,
 * Restore's steps), moving exactly as the app's own pages do. A target deeper than the last ([depth]) comes in from the
 * side; a shallower one returns. The page's state outlives the switch only if it's kept above this, as it always was.
 */
@Composable
fun <T> PageSwitch(target: T, depth: (T) -> Int, modifier: Modifier = Modifier, content: @Composable (T) -> Unit) {
    val motion = rememberPageMotion()
    AnimatedContent(target, modifier, transitionSpec = { motion.switch(depth(targetState) >= depth(initialState)) using null }, label = "page") {
        Box(Modifier.fillMaxSize().stepsAside(transition)) { content(it) }
    }
}

/**
 * A page on its way out, once it has faded (118 ms), is no longer placed: it would otherwise sit on top, invisible, and
 * take the touches meant for the page coming back for the rest of the 450 ms. Never while a back swipe holds it: that
 * page is still on show. Only placement changes, nothing is measured again. A field focused on it lets go as it starts
 * to leave, so the keyboard goes as the page does, not 450 ms later; a field on the page coming in may then take over.
 */
@Composable
fun Modifier.stepsAside(transition: Transition<EnterExitState>): Modifier {
    val swiped = BackSwipe.leaving
    val gone by remember(transition) {
        derivedStateOf { transition.targetState == EnterExitState.PostExit && !swiped() && transition.playTimeNanos > PAGE_GONE_NANOS }
    }
    val leaving = transition.targetState == EnterExitState.PostExit && !swiped()
    val focus = LocalFocusManager.current
    val focused = remember { booleanArrayOf(false) }
    LaunchedEffect(leaving) { if (leaving && focused[0]) focus.clearFocus(force = true) }
    return onFocusChanged { focused[0] = it.hasFocus }.layout { measurable, constraints ->
        val placeable = measurable.measure(constraints)
        layout(placeable.width, placeable.height) { if (!gone) placeable.place(0, 0) }
    }
}

/**
 * Something new in the same place, with no second copy drawn: the new content is simply there and arrives, fading in and
 * coming [direction] × 24 dp (−1 from the start's side, 1 from the end's, 0 straight in). For a tab, another day: Google's
 * own tabs are 50–100 ms, and a list drawn twice is what a phone feels (S6). Nothing plays for the first key, nor when
 * the phone's animations are off. Only the draw changes.
 */
fun Modifier.arrival(key: Any?, direction: Int = 0): Modifier = composed {
    val first = remember { key }
    val travel = with(LocalDensity.current) { ARRIVAL_SLIDE_DP.dp.toPx() }
    val rtl = LocalLayoutDirection.current == LayoutDirection.Rtl
    val t = remember(key) { Animatable(if (key == first) 1f else 0f) }
    LaunchedEffect(t) { if (t.value < 1f) t.animateTo(1f, tween(ARRIVAL_MS, easing = EmphasizedDecelerate)) }
    graphicsLayer {
        alpha = t.value
        translationX = (1f - t.value) * travel * direction * if (rtl) -1 else 1
    }
}

/**
 * [arrival] for a list whose top stays put (Habit details' header and tabs): everything below [top] (px from the list's
 * top) comes up out of the page's [color]. The list isn't touched, only drawn over for 200 ms.
 */
fun Modifier.arrivalBelow(key: Any?, color: Color, top: () -> Int): Modifier = composed {
    val first = remember { key }
    val t = remember(key) { Animatable(if (key == first) 1f else 0f) }
    LaunchedEffect(t) { if (t.value < 1f) t.animateTo(1f, tween(ARRIVAL_MS, easing = EmphasizedDecelerate)) }
    drawWithContent {
        drawContent()
        val cover = 1f - t.value
        if (cover > 0f) {
            val from = top().toFloat()
            drawRect(color, Offset(0f, from), Size(size.width, size.height - from), alpha = cover)
        }
    }
}
