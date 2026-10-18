package com.oftenenough.app.ui.components

import android.graphics.Matrix
import androidx.compose.animation.core.CubicBezierEasing
import androidx.compose.animation.core.LinearEasing
import androidx.compose.animation.core.RepeatMode
import androidx.compose.animation.core.animateFloat
import androidx.compose.animation.core.infiniteRepeatable
import androidx.compose.animation.core.rememberInfiniteTransition
import androidx.compose.animation.core.tween
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.asComposePath
import androidx.compose.ui.graphics.drawscope.rotate
import androidx.compose.ui.semantics.ProgressBarRangeInfo
import androidx.compose.ui.semantics.progressBarRangeInfo
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.graphics.shapes.CornerRounding
import androidx.graphics.shapes.Morph
import androidx.graphics.shapes.RoundedPolygon
import androidx.graphics.shapes.circle
import androidx.graphics.shapes.rectangle
import androidx.graphics.shapes.star
import androidx.graphics.shapes.toPath
import androidx.graphics.shapes.transformed

/**
 * Material 3 Expressive's contained loading indicator, as the Figma file animates it (Plus & Account 3.2, 4, 2.1.1):
 * seven shapes (soft burst, 9-sided cookie, pentagon, pill, sunny, 4-sided cookie, oval) morph into one another every
 * 650 ms while the whole turns twice in 4.55 s, in a tonal circle. Material's own `ContainedLoadingIndicator` isn't
 * public in the stable Material 3 this app uses (1.4.0), so it's drawn here with the same shape-morphing library
 * (`androidx.graphics:graphics-shapes`). Replace it with Material's once that is stable.
 *
 * Speed (S3, S6): only this Canvas redraws each frame; the time is read in the draw phase, so nothing recomposes, and
 * the shapes and morphs are made once. With animations turned off it holds still.
 */
@Composable
fun ExpressiveLoadingIndicator(container: Color, indicator: Color, modifier: Modifier = Modifier, size: Dp = 64.dp) {
    val morphs = remember { loadingMorphs() }
    val transition = rememberInfiniteTransition(label = "loading")
    val loop = transition.animateFloat(0f, CYCLE_MS.toFloat(), infiniteRepeatable(tween(CYCLE_MS, easing = LinearEasing), RepeatMode.Restart), label = "loop")
    val path = remember { android.graphics.Path() }
    val matrix = remember { Matrix() }
    Box(modifier.size(size).clip(CircleShape).background(container).semantics { progressBarRangeInfo = ProgressBarRangeInfo.Indeterminate },
        contentAlignment = Alignment.Center) {
        Canvas(Modifier.size(size * (38f / 64f))) {
            val t = loop.value
            val index = (t / STEP_MS).toInt().coerceIn(0, morphs.size - 1)
            val local = MORPH_EASING.transform(((t - index * STEP_MS) / STEP_MS).coerceIn(0f, 1f))
            path.rewind()
            morphs[index].toPath(local, path)
            matrix.reset(); matrix.setScale(this.size.width, this.size.height)
            path.transform(matrix)
            rotate(t / CYCLE_MS * 720f) { drawPath(path.asComposePath(), indicator) }
        }
    }
}

private const val STEP_MS = 650
private const val CYCLE_MS = STEP_MS * 7

/** Material's morph: quick, with a little overshoot, settling well before the next shape starts. */
private val MORPH_EASING = CubicBezierEasing(0.42f, 1.67f, 0.21f, 0.9f)

/** The seven shapes in Figma's order, each fitted to a unit square, and the morph from each to the next (looping). */
private fun loadingMorphs(): List<Morph> {
    fun RoundedPolygon.fit(): RoundedPolygon = normalized()
    fun RoundedPolygon.turn(degrees: Float, sx: Float = 1f, sy: Float = 1f): RoundedPolygon =
        transformed(Matrix().apply { setRotate(degrees); postScale(sx, sy) })
    val shapes = listOf(
        RoundedPolygon.star(10, radius = 1f, innerRadius = 0.892f, rounding = CornerRounding(0.085f)).fit(),
        RoundedPolygon.star(9, radius = 1f, innerRadius = 0.8f, rounding = CornerRounding(0.5f)).fit(),
        RoundedPolygon(5, rounding = CornerRounding(0.172f)).turn(-90f).fit(),
        RoundedPolygon.rectangle(width = 2f, height = 1.1f, rounding = CornerRounding(0.55f)).turn(-45f).fit(),
        RoundedPolygon.star(8, radius = 1f, innerRadius = 0.8f, rounding = CornerRounding(0.15f)).fit(),
        RoundedPolygon.star(4, radius = 1f, innerRadius = 0.6f, rounding = CornerRounding(0.4f)).turn(45f).fit(),
        RoundedPolygon.circle(8).turn(0f, 1f, 0.79f).fit(),
    )
    return shapes.indices.map { i -> Morph(shapes[i], shapes[(i + 1) % shapes.size]) }
}
