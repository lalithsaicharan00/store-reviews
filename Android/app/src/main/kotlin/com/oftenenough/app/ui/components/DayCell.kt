package com.oftenenough.app.ui.components

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.layout.size
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.Immutable
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.CornerRadius
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Rect
import androidx.compose.ui.geometry.RoundRect
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Matrix
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.PathEffect
import androidx.compose.ui.graphics.drawscope.DrawScope
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.graphics.vector.VectorGroup
import androidx.compose.ui.graphics.vector.VectorPath
import androidx.compose.ui.graphics.vector.toPath
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HeatCell
import com.oftenenough.app.data.HeatOff
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.theme.appColors

/**
 * Atom 3.6, **Day cell** (Figma 977:635; Components — Atoms Build Plan): one day of a habit, the same square in Week,
 * Month, Year, History and the key; only its size changes. No date or number inside: the fill says how much, the sign
 * says what happened (Material Symbols Rounded, outlined, weight 400, as Figma's glyphs).
 *
 * - **Done** (goal met): the habit's Colour with a ✓ in On habit. **More than the goal**: the habit's Strong (the
 *   medal's deep end, [medalColors]) with the ✓. **Part**: the Colour at 50 %.
 * - **Not done**: Surface container high with a ✕ in Outline. **Skipped** (redo) and **Paused** (pause): the same grey
 *   with their sign; they were due, so they look like a planned day, never like a miss. **To come**: the grey alone.
 * - **No goal** (not its day): no fill, a dashed Outline variant line 1.5 dp inside the edge (3 on, 3 off).
 * - **Empty** (before the habit started): nothing.
 * - **Today**: a 2 dp On surface ring 1 dp outside the square, its corners 3 rounder ([DayCellSize.ring] keeps room).
 *
 * Sizes (Figma's Size): **Week** 36, corners 8, ✓ 22, ✕ 18, pause and redo 16; **Small** 28: 7, 17, 14, 12; **Year** 24:
 * 6, 16, 12, 12. A cell drawn at another size (a month with its Week column, the Progress page's grid) takes the
 * nearest of these, scaled. Light is Figma's; dark uses the same roles, the habit's dark colour, and a deep shade for
 * the ✓ on Done, where white wouldn't read.
 *
 * A year has hundreds of cells, so screens never draw them one by one: [DayCellDraw] batches every look into one path,
 * in one Canvas (Rulebook S12). [DayCell] is one cell on its own.
 */
object DayCellSize {
    val week: Dp = 36.dp
    val small: Dp = 28.dp
    val year: Dp = 24.dp
    /** Room around a cell for today's ring. */
    val ring: Dp = 3.dp
}

/** One cell on its own (a History row, the key): [size] plus [DayCellSize.ring] all round. */
@Composable
fun DayCell(cell: HeatCell, color: HabitColor, modifier: Modifier = Modifier, size: Dp = DayCellSize.week, isToday: Boolean = false) {
    val colors = dayCellColors(color)
    Canvas(modifier.size(size + DayCellSize.ring * 2)) {
        val pad = DayCellSize.ring.toPx()
        DayCellDraw(size.toPx(), 1.dp.toPx()).apply { add(cell, pad, pad, isToday) }.draw(this, colors)
    }
}

/** Every colour a habit's cells use, read once per drawing. */
@Immutable
class DayCellColors(
    val done: Color, val part: Color, val more: Color, val check: Color, val checkOnMore: Color,
    val grey: Color, val sign: Color, val dash: Color, val ring: Color,
)

@Composable
fun dayCellColors(habit: HabitColor): DayCellColors {
    val c = appColors
    val s = MaterialTheme.colorScheme
    val done = c.habit(habit)
    return DayCellColors(
        done = done, part = done.copy(alpha = 0.5f), more = medalColors(c, habit).bottom,
        check = if (c.dark) Color(darkChecks.getValue(habit)) else Color.White, checkOnMore = Color.White,
        grey = s.surfaceContainerHigh, sign = s.outline, dash = s.outlineVariant, ring = s.onSurface,
    )
}

/** Dark mode's ✓ on Done: a deep shade of each habit's dark colour (its colours are too light for white). */
private val darkChecks = mapOf(
    HabitColor.RED to 0xFF331511, HabitColor.ORANGE to 0xFF301903, HabitColor.YELLOW to 0xFF281E00, HabitColor.GREEN to 0xFF0C2611,
    HabitColor.MINT to 0xFF002523, HabitColor.TEAL to 0xFF00242B, HabitColor.CYAN to 0xFF002333, HabitColor.BLUE to 0xFF0F1F37,
    HabitColor.INDIGO to 0xFF1A1C36, HabitColor.PURPLE to 0xFF271830, HabitColor.PINK to 0xFF331416, HabitColor.BROWN to 0xFF2D1B01,
    HabitColor.GRAY to 0xFF131E37,
)

/** A glyph's outline in its 960 box (Symbols draws them a box higher). */
private fun glyph(icon: ImageVector): Path =
    ((icon.root[0] as VectorGroup)[0] as VectorPath).pathData.toPath().apply { translate(Offset(0f, 960f)) }

private val check by lazy { glyph(Symbols.Check) }
private val close by lazy { glyph(Symbols.Close) }
private val pause by lazy { glyph(Symbols.Pause) }
private val redo by lazy { glyph(Symbols.Redo) }

/**
 * Draws [DayCell]s into a Canvas: [add] each day, then [draw] once. [square] is the cell's side in pixels, [unit] one
 * dp in pixels.
 */
class DayCellDraw(private val square: Float, private val unit: Float) {
    /** Which of Figma's sizes this is, and how much bigger or smaller: corners, ✓, ✕, pause/redo at that size. */
    private val kind = when {
        square >= 32f * unit -> floatArrayOf(36f, 8f, 22f, 18f, 16f)
        square >= 26f * unit -> floatArrayOf(28f, 7f, 17f, 14f, 12f)
        else -> floatArrayOf(24f, 6f, 16f, 12f, 12f)
    }
    private val scale = square / (kind[0] * unit)
    /** The cell's corner radius in pixels. */
    val radius = kind[1] * unit * scale
    private val dashWidth = 1.5f * unit

    private val done = Path()
    private val part = Path()
    private val more = Path()
    private val grey = Path()
    private val dashes = Path()
    private val signs = Path()
    private val checks = Path()
    private val checksOnMore = Path()
    private val today = Path()

    fun add(cell: HeatCell, left: Float, top: Float, isToday: Boolean = false) {
        val rect = Rect(left, top, left + square, top + square)
        val shape = RoundRect(rect, CornerRadius(radius))
        when (cell) {
            HeatCell.Blank -> Unit
            HeatCell.Upcoming -> grey.addRoundRect(shape)
            is HeatCell.Level -> when (cell.n) {
                0 -> { grey.addRoundRect(shape); sign(signs, close, kind[3], rect) }
                in 1..3 -> part.addRoundRect(shape)
                4 -> { done.addRoundRect(shape); sign(checks, check, kind[2], rect) }
                else -> { more.addRoundRect(shape); sign(checksOnMore, check, kind[2], rect) }
            }
            is HeatCell.Off -> if (cell.why == HeatOff.NOT_SCHEDULED) {
                val inset = dashWidth / 2
                dashes.addRoundRect(RoundRect(rect.deflate(inset), CornerRadius(radius - inset)))
            } else {
                grey.addRoundRect(shape)
                sign(signs, if (cell.why == HeatOff.SKIPPED) redo else pause, kind[4], rect)
            }
        }
        if (isToday) {
            val grow = 2f * unit
            today.addRoundRect(RoundRect(rect.inflate(grow), CornerRadius(radius + grow)))
        }
    }

    fun draw(scope: DrawScope, colors: DayCellColors) = with(scope) {
        drawPath(grey, colors.grey)
        drawPath(part, colors.part)
        drawPath(done, colors.done)
        drawPath(more, colors.more)
        drawPath(dashes, colors.dash, style = Stroke(dashWidth, pathEffect = PathEffect.dashPathEffect(floatArrayOf(3f * unit, 3f * unit))))
        drawPath(signs, colors.sign)
        drawPath(checks, colors.check)
        drawPath(checksOnMore, colors.checkOnMore)
        drawPath(today, colors.ring, style = Stroke(2f * unit))
    }

    private val scaled = HashMap<Path, Path>(4)

    /** [glyph] at [side] dp (scaled with the cell), centred on [rect], into [into]. Each glyph is scaled once. */
    private fun sign(into: Path, glyph: Path, side: Float, rect: Rect) {
        val px = side * unit * scale
        val shape = scaled.getOrPut(glyph) { Path().apply { addPath(glyph); transform(Matrix().apply { scale(px / 960f, px / 960f) }) } }
        into.addPath(shape, Offset(rect.center.x - px / 2, rect.center.y - px / 2))
    }
}
