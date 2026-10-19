package com.oftenenough.app.ui.habit

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.size
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.Immutable
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Matrix
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.asAndroidPath
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.graphics.drawscope.drawIntoCanvas
import androidx.compose.ui.graphics.drawscope.withTransform
import androidx.compose.ui.graphics.lerp
import androidx.compose.ui.graphics.luminance
import androidx.compose.ui.graphics.nativeCanvas
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.graphics.vector.PathParser
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.ui.theme.AppColors
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors

// The milestone medal (Habit details, Figma 1373:2, 2475:82; All milestones 1735:4): a soft nine-point star, its colour
// running from a lighter step at the top to a deeper one at the bottom, the same star again inside as a fine white line,
// a soft shadow under it in a dark shade of the colour, and the number in white. Figma draws Water's blue (#4285F4 →
// #77A7F7 top, #3A75D7 bottom, shadow #244986 at 35 %); every habit colour gets the same steps from its own colour, in
// light and dark, darkened only as far as the white number needs to stay readable (3:1, large text).

/** Figma's star, in a 72 × 72 box (its path, moved into the medal's own space). Parsed once. */
private val starPath: Path by lazy {
    PathParser().parsePathString(
        "M32.063 2.563C34.454 1.004 37.54 1.004 39.931 2.563L45.181 5.988C46.105 6.591 47.156 6.973 48.252 7.105L54.475 7.857" +
            "C57.308 8.199 59.672 10.183 60.502 12.914L62.322 18.912C62.642 19.968 63.202 20.936 63.956 21.742L68.24 26.318" +
            "C70.191 28.401 70.727 31.44 69.606 34.065L67.145 39.83C66.712 40.846 66.518 41.947 66.578 43.049L66.919 49.308" +
            "C67.074 52.158 65.531 54.83 62.985 56.121L57.394 58.955C56.41 59.454 55.553 60.173 54.891 61.056L51.129 66.07" +
            "C49.415 68.353 46.516 69.408 43.736 68.76L37.631 67.338C36.556 67.088 35.438 67.088 34.363 67.338L28.258 68.76" +
            "C25.479 69.408 22.579 68.353 20.866 66.07L17.103 61.056C16.441 60.173 15.584 59.454 14.6 58.955L9.009 56.121" +
            "C6.463 54.83 4.92 52.158 5.075 49.308L5.416 43.049C5.476 41.947 5.282 40.846 4.849 39.83L2.388 34.065" +
            "C1.267 31.44 1.803 28.401 3.754 26.318L8.038 21.742C8.793 20.936 9.352 19.968 9.672 18.912L11.493 12.914" +
            "C12.322 10.183 14.686 8.199 17.519 7.857L23.743 7.105C24.838 6.973 25.889 6.591 26.813 5.988L32.063 2.563Z",
    ).toPath()
}

/** One habit colour's medal: the gradient's two ends and the shadow. */
@Immutable
data class MedalColors(val top: Color, val bottom: Color, val shadow: Color)

/**
 * The medal's colours for [habit] in [c]'s mode. The steps are Figma's own (blue): top 28 % of the way to white, bottom
 * 88 % of the colour, shadow 55 % of it at 35 % (on dark, a plain dark shadow: a coloured one turns muddy). A light colour
 * (yellow, mint, the dark mode's brighter shades) is deepened first, step by step, until the white number is readable on
 * the middle of the gradient, so every medal looks like a medal and none washes out.
 */
fun medalColors(c: AppColors, habit: HabitColor): MedalColors {
    var base = c.habit(habit)
    fun mid(b: Color) = lerp(lerp(b, Color.White, if (c.dark) 0.18f else 0.28f), scale(b, 0.88f), 0.5f)
    var guard = 0
    while (contrastWithWhite(mid(base)) < 3.0 && guard++ < 20) base = scale(base, 0.93f)
    val top = lerp(base, Color.White, if (c.dark) 0.18f else 0.28f)
    val bottom = scale(base, 0.88f)
    val shadow = if (c.dark) Color.Black.copy(alpha = 0.55f) else scale(base, 0.55f).copy(alpha = 0.35f)
    return MedalColors(top, bottom, shadow)
}

private fun scale(color: Color, f: Float) = Color(color.red * f, color.green * f, color.blue * f, color.alpha)
private fun contrastWithWhite(color: Color): Double = 1.05 / (color.luminance() + 0.05)

/** The star as a shape, for whatever is drawn in it (the bar's white medal, a folded section's small one). */
object MedalShape : androidx.compose.ui.graphics.Shape {
    override fun createOutline(size: androidx.compose.ui.geometry.Size, layoutDirection: androidx.compose.ui.unit.LayoutDirection,
                               density: androidx.compose.ui.unit.Density): androidx.compose.ui.graphics.Outline {
        val k = size.minDimension / 72f
        return androidx.compose.ui.graphics.Outline.Generic(Path().apply { addPath(starPath); transform(Matrix().apply { scale(k, k) }) })
    }
}

/**
 * A reached milestone, the same everywhere it's shown (the habit page, All milestones, the pop-up, the row's band, the
 * routine): the star at [size], its number in white ([number] null: the medal alone, as in a band). The shadow reaches a
 * little past the box, as Figma's does; nothing clips it.
 */
@Composable
fun MilestoneMedal(number: String?, size: Dp, color: HabitColor, modifier: Modifier = Modifier) {
    val c = appColors
    val colors = remember(c, color) { medalColors(c, color) }
    // Figma: 24 at 72, 34.7 at 104, 16 at 52; longer numbers a step smaller so they stay inside the inner line.
    val base = if (size in 48.dp..60.dp) 16f / 52f else 24f / 72f
    val share = when { (number?.length ?: 0) >= 4 -> base * 0.62f; number?.length == 3 -> base * 0.8f; else -> base }
    val fontSize = with(LocalDensity.current) { (size * share).toSp() }
    Box(modifier.size(size), contentAlignment = Alignment.Center) {
        Canvas(Modifier.size(size)) {
            val k = this.size.minDimension / 72f
            val shape = Path().apply { addPath(starPath); transform(Matrix().apply { scale(k, k) }) }
            // The shadow: 2 down, a 6 blur (Figma's dy 2, σ 3), drawn by the platform under the star.
            drawIntoCanvas { canvas ->
                val paint = android.graphics.Paint(android.graphics.Paint.ANTI_ALIAS_FLAG).apply {
                    this.color = android.graphics.Color.TRANSPARENT
                    setShadowLayer(6f * k, 0f, 2f * k, colors.shadow.toArgb())
                }
                paint.color = colors.bottom.toArgb()
                canvas.nativeCanvas.drawPath(shape.asAndroidPath(), paint)
            }
            drawPath(shape, Brush.verticalGradient(listOf(colors.top, colors.bottom), startY = 0f, endY = this.size.height))
            // The inner line: the same star at 82 %, about the centre (Figma 59.04 of 72), white at 55 %.
            withTransform({ scale(0.82f, 0.82f, Offset(this.size.width / 2, this.size.height / 2)) }) {
                drawPath(shape, Color.White.copy(alpha = 0.55f), style = Stroke(width = (1.5f * k / 0.82f).coerceAtLeast(1.dp.toPx() / 0.82f), cap = StrokeCap.Round))
            }
        }
        if (number != null) Text(number, color = Color.White, fontSize = fontSize, fontWeight = FontWeight.Medium, fontFamily = AppType.labelLarge.fontFamily, maxLines = 1)
    }
}

/**
 * The milestone bar's medal (Figma 2160:2, item 2): the star in white with the number in the habit's colour, so it reads
 * on any colour (a light colour deepened, as the medal's own); the inner line in the colour, lighter.
 */
@Composable
fun WhiteMedal(number: String, size: Dp, color: HabitColor, modifier: Modifier = Modifier) {
    // The number in the medal's own deepened colour, so a light one (yellow) still reads on white (Figma 2160:2).
    val c = appColors
    val ink = remember(c, color) { medalColors(c, color).bottom }
    val fontSize = with(LocalDensity.current) { (size * (if (number.length > 2) 0.28f else 0.36f)).toSp() }
    Box(modifier.size(size), contentAlignment = Alignment.Center) {
        Canvas(Modifier.size(size)) {
            val k = this.size.minDimension / 72f
            val shape = Path().apply { addPath(starPath); transform(Matrix().apply { scale(k, k) }) }
            drawPath(shape, Color.White)
            withTransform({ scale(0.82f, 0.82f, Offset(this.size.width / 2, this.size.height / 2)) }) {
                drawPath(shape, ink.copy(alpha = 0.35f), style = Stroke(width = (1.5f * k / 0.82f).coerceAtLeast(1.dp.toPx() / 0.82f)))
            }
        }
        Text(number, color = ink, fontSize = fontSize, fontWeight = FontWeight.Medium, fontFamily = AppType.labelLarge.fontFamily, maxLines = 1)
    }
}
