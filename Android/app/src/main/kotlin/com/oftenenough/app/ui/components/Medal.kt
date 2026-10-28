package com.oftenenough.app.ui.components

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

// Atom 3.5, **Medal** (Figma 913:29957; Components — Atoms Build Plan): a reached milestone. A soft nine-point star
// (inner radius 86 %, corners 10 % of its size) in the habit's Medal gradient, the same star again at 82 % as a white
// line, a soft shadow under it, and the number reached in white. Large 104 (the milestone pop-up), Medium 72 (Habit
// details), Small 40 (a list row's leading slot); between them it scales, as Figma's instances do.

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

/** Figma's "Habit / <colour> / Medal": Pale (tone 75) at the top to Strong (tone 48) at the bottom, light mode. */
private val medalLight = mapOf(
    HabitColor.RED to (0xFFFF9F92 to 0xFFD53428), HabitColor.ORANGE to (0xFFFFA269 to 0xFFB85600),
    HabitColor.YELLOW to (0xFFF7A900 to 0xFF9A6800), HabitColor.GREEN to (0xFF5ECF75 to 0xFF008437),
    HabitColor.MINT to (0xFF4DCBC1 to 0xFF008079), HabitColor.TEAL to (0xFF3CC9E0 to 0xFF007E8E),
    HabitColor.CYAN to (0xFF34C9E8 to 0xFF007D93), HabitColor.BLUE to (0xFF97B8FF to 0xFF226FDC),
    HabitColor.INDIGO to (0xFFA8B4FF to 0xFF5D6CC1), HabitColor.PURPLE to (0xFFD5A5FF to 0xFF9D3DF0),
    HabitColor.PINK to (0xFFFF9AC4 to 0xFFD81488), HabitColor.BROWN to (0xFFCFB3A9 to 0xFF846D65),
    HabitColor.GRAY to (0xFFB4B9BF to 0xFF6D7378),
)

/**
 * The medal's colours for [habit] in [c]'s mode. Light: Figma's Medal gradient, and its shadow, black at 20 %. Figma
 * draws light only, so dark works its steps out from the habit's dark colour: top 18 % of the way to white, bottom 88 %
 * of the colour, deepened first until the white number reads on the middle (3:1, large text), with a plain dark shadow
 * (a coloured one turns muddy).
 */
fun medalColors(c: AppColors, habit: HabitColor): MedalColors {
    if (!c.dark) {
        val (pale, strong) = medalLight.getValue(habit)
        return MedalColors(Color(pale), Color(strong), Color.Black.copy(alpha = 0.2f))
    }
    var base = c.habit(habit)
    fun mid(b: Color) = lerp(lerp(b, Color.White, 0.18f), scale(b, 0.88f), 0.5f)
    var guard = 0
    while (contrastWithWhite(mid(base)) < 3.0 && guard++ < 20) base = scale(base, 0.93f)
    return MedalColors(lerp(base, Color.White, 0.18f), scale(base, 0.88f), Color.Black.copy(alpha = 0.55f))
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
 * routine): the star at [size], its [number] in white (null: the medal alone, as in a band's sparkles). The number is
 * Figma's style for the size: Headline Large Emphasized on the Large (88 and up), Headline Small Emphasized on the
 * Medium (56 and up), Title Medium below; three digits a step smaller, four or more two, so they stay inside the line.
 * The shadow (2 down, a 6 blur at 72) reaches a little past the box, as Figma's does; nothing clips it.
 */
@Composable
fun Medal(number: String?, size: Dp, color: HabitColor, modifier: Modifier = Modifier) {
    val c = appColors
    val colors = remember(c, color) { medalColors(c, color) }
    // Figma's three sizes, each with its own number style and ring (2.2 on the Large, 1.8 on the Medium, 1.2 on the Small).
    val (style, ref, ring) = when {
        size >= 88.dp -> Triple(AppType.headlineLargeEmphasized, 104f, 2.2f)
        size >= 56.dp -> Triple(AppType.headlineSmallEmphasized, 72f, 1.8f)
        else -> Triple(AppType.titleMedium, 40f, 1.2f)
    }
    val shrink = when { (number?.length ?: 0) >= 4 -> 0.62f; number?.length == 3 -> 0.8f; else -> 1f }
    Box(modifier.size(size), contentAlignment = Alignment.Center) {
        Canvas(Modifier.size(size)) {
            val k = this.size.minDimension / 72f
            val shape = Path().apply { addPath(starPath); transform(Matrix().apply { scale(k, k) }) }
            drawIntoCanvas { canvas ->
                val paint = android.graphics.Paint(android.graphics.Paint.ANTI_ALIAS_FLAG).apply {
                    this.color = colors.bottom.toArgb()
                    setShadowLayer(6f * k, 0f, 2f * k, colors.shadow.toArgb())
                }
                canvas.nativeCanvas.drawPath(shape.asAndroidPath(), paint)
            }
            drawPath(shape, Brush.verticalGradient(listOf(colors.top, colors.bottom), startY = 0f, endY = this.size.height))
            // The inner ring: the same star at 82 % about the centre (Figma 59 of 72), a line of white at 60 %.
            val line = ring.dp.toPx() * (size.value / ref)
            withTransform({ scale(0.82f, 0.82f, Offset(this.size.width / 2, this.size.height / 2)) }) {
                drawPath(shape, Color.White.copy(alpha = 0.6f), style = Stroke(width = line / 0.82f, cap = StrokeCap.Round))
            }
        }
        if (number != null) Text(number, color = Color.White, maxLines = 1,
            style = if (shrink == 1f) style else style.copy(fontSize = style.fontSize * shrink, lineHeight = style.lineHeight * shrink))
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
