package com.oftenenough.app.ui.components

import android.provider.Settings
import androidx.compose.animation.core.CubicBezierEasing
import androidx.compose.animation.core.Easing
import androidx.compose.animation.core.LinearEasing
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.drawscope.DrawScope
import androidx.compose.ui.platform.LocalContext

/*
 * The design system's motion helpers, shared by every component and screen that plays Figma's keyframes (the
 * milestone bar, band, ribbon and pop-up; Day details' celebration). Figma's timings are kept exactly; the curves are
 * Figma's easings, named as Figma names them.
 */

/** One keyframe of a track: its time (0–1 of the timeline), its value, and the easing from it to the next. */
class Key(val at: Float, val value: Float, val ease: Easing = LinearEasing)

/** The value of a keyframe track at [t] (0–1). */
fun track(t: Float, vararg keys: Key): Float {
    if (t <= keys.first().at) return keys.first().value
    for (i in 0 until keys.size - 1) {
        val a = keys[i]
        val b = keys[i + 1]
        if (t <= b.at) {
            val f = ((t - a.at) / (b.at - a.at)).coerceIn(0f, 1f)
            return a.value + (b.value - a.value) * a.ease.transform(f)
        }
    }
    return keys.last().value
}

/** CSS's ease-out, as Figma's keyframes use it. */
val EaseOut = CubicBezierEasing(0f, 0f, 0.58f, 1f)
/** CSS's ease-in. */
val EaseIn = CubicBezierEasing(0.42f, 0f, 1f, 1f)
/** CSS's ease-in-out. */
val EaseInOut = CubicBezierEasing(0.42f, 0f, 0.58f, 1f)
/** Material's emphasized decelerate: things that arrive. */
val Arrive = CubicBezierEasing(0.05f, 0.7f, 0.1f, 1f)
/** A pop, with a little overshoot (badges, medals, sparkles). */
val Pop = CubicBezierEasing(0.45f, 1.45f, 0.8f, 1f)

/** Whether the phone plays animations (Remove animations, or Developer options at 0×, turns them off). */
@Composable
fun animationsOn(): Boolean {
    val context = LocalContext.current
    return remember { runCatching { Settings.Global.getFloat(context.contentResolver, Settings.Global.ANIMATOR_DURATION_SCALE, 1f) }.getOrDefault(1f) != 0f }
}

/** A four-pointed sparkle centred on [p], [size] across, as Figma's stars. */
fun DrawScope.sparkle(p: Offset, size: Float, color: Color) {
    val h = size / 2
    val star = Path().apply {
        moveTo(p.x, p.y - h); quadraticTo(p.x, p.y, p.x + h, p.y); quadraticTo(p.x, p.y, p.x, p.y + h)
        quadraticTo(p.x, p.y, p.x - h, p.y); quadraticTo(p.x, p.y, p.x, p.y - h); close()
    }
    drawPath(star, color)
}
