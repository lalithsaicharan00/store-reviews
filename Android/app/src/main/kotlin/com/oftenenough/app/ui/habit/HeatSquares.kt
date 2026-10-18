package com.oftenenough.app.ui.habit

import com.oftenenough.app.ui.theme.AppType

import androidx.compose.animation.animateContentSize
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.gestures.detectTapGestures
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ExperimentalLayoutApi
import androidx.compose.foundation.layout.FlowRow
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.rounded.ExpandLess
import androidx.compose.material.icons.rounded.ExpandMore
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.geometry.CornerRadius
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Rect
import androidx.compose.ui.geometry.RoundRect
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.PathEffect
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.StrokeJoin
import androidx.compose.ui.graphics.drawscope.DrawScope
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.semantics.clearAndSetSemantics
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.stateDescription
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.drawText
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.rememberTextMeasurer
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HeatCell
import com.oftenenough.app.data.HeatOff
import com.oftenenough.app.ui.theme.appColors
import kotlin.math.floor

// The heat map's squares (the iPhone's HeatMap.swift): one square per day, the same in History, Week, Month and Year;
// only the size changes, never below 24 dp. No dates or numbers inside: the colour says how much, the sign says what
// happened. Every drawing batches each look into one fill or stroke (`HeatDraw`), in one Canvas (Rulebook S12).

/** Square sizes: never smaller than [SMALLEST], where the signs stop being easy to read. */
object HeatSize {
    val week: Dp = 40.dp
    val month: Dp = 36.dp
    val year: Dp = 24.dp
    val smallest: Dp = 24.dp
    /** Room a square's today outline needs around it. */
    val outline: Dp = 3.dp
}

/**
 * Grey, the five steps of every habit colour (light and dark), and the signs' colours: the iPhone's measured table
 * (report "Day Marks — Heat Map, Rule and Palette"), so a square reads the same on both phones.
 */
object HeatPalette {
    private fun hex(v: Int): Color = Color(0xFF000000.toInt() or v)

    fun color(level: Int, habit: HabitColor, dark: Boolean): Color {
        if (level <= 0) return grey(dark)
        val steps = table[habit] ?: table.getValue(HabitColor.GREEN)
        return hex((if (dark) steps.second else steps.first)[minOf(5, level) - 1])
    }

    fun grey(dark: Boolean): Color = if (dark) hex(0x2C2C2E) else hex(0xEBEBF0)
    /** ✕, ⏩, ⏸. */
    fun sign(dark: Boolean): Color = if (dark) hex(0x98989F) else hex(0x6C6C70)
    fun dash(dark: Boolean): Color = if (dark) hex(0x7C7C80) else hex(0x8E8E93)
    fun today(@Suppress("UNUSED_PARAMETER") dark: Boolean): Color = hex(0x8E8E93)
    /** The ✓, the same on the goal step and the "more" step: white in light mode, a deep shade of the habit's colour in dark. */
    fun check(habit: HabitColor, dark: Boolean): Color = if (!dark) Color.White else hex(darkChecks[habit] ?: 0x0C2611)

    private val darkChecks = mapOf(
        HabitColor.RED to 0x331511, HabitColor.ORANGE to 0x301903, HabitColor.YELLOW to 0x281E00, HabitColor.GREEN to 0x0C2611,
        HabitColor.MINT to 0x002523, HabitColor.TEAL to 0x00242B, HabitColor.CYAN to 0x002333, HabitColor.BLUE to 0x0F1F37,
        HabitColor.INDIGO to 0x1A1C36, HabitColor.PURPLE to 0x271830, HabitColor.PINK to 0x331416, HabitColor.BROWN to 0x2D1B01,
        HabitColor.GRAY to 0x131E37,
    )

    private val table: Map<HabitColor, Pair<IntArray, IntArray>> = mapOf(
        HabitColor.RED to (intArrayOf(0xFFBDB2, 0xFE9688, 0xFE6D5D, 0xFA352B, 0xC50A0B) to intArrayOf(0x83271F, 0xAB2A21, 0xD32C23, 0xFA352B, 0xFE8C7C)),
        HabitColor.ORANGE to (intArrayOf(0xF2C69F, 0xE6A971, 0xD98E44, 0xC97504, 0x975703) to intArrayOf(0x6A4116, 0x895111, 0xAA6204, 0xC97504, 0xE89F58)),
        HabitColor.YELLOW to (intArrayOf(0xDFCE9F, 0xCDB573, 0xBC9E45, 0xAA8808, 0x806501) to intArrayOf(0x5A4A17, 0x745E12, 0x8F7207, 0xAA8808, 0xCBAE5A)),
        HabitColor.GREEN to (intArrayOf(0xA6E1AD, 0x7ACE86, 0x4CBC62, 0x06A941, 0x057F2F) to intArrayOf(0x1B5A28, 0x15742F, 0x068E36, 0x06A941, 0x62CC74)),
        HabitColor.MINT to (intArrayOf(0xA7DBD7, 0x7BC8C2, 0x4DB5AE, 0x09A19A, 0x067974) to intArrayOf(0x1B5653, 0x166F6A, 0x088882, 0x09A19A, 0x62C4BD)),
        HabitColor.TEAL to (intArrayOf(0xA6DAE5, 0x7AC5D5, 0x4CB1C6, 0x079DB4, 0x057688) to intArrayOf(0x1A545F, 0x156C7B, 0x078498, 0x079DB4, 0x61C1D5)),
        HabitColor.CYAN to (intArrayOf(0xA5D7F5, 0x79C2EA, 0x4AADDF, 0x0598D0, 0x04729D) to intArrayOf(0x1A526D, 0x14688E, 0x0580B0, 0x0598D0, 0x60BDEE)),
        HabitColor.BLUE to (intArrayOf(0xB2D2FF, 0x8AB9FE, 0x61A2FE, 0x3289FF, 0x1465CA) to intArrayOf(0x224B84, 0x255FAE, 0x2973D8, 0x3289FF, 0x7EB3FF)),
        HabitColor.INDIGO to (intArrayOf(0xC4CBFE, 0xA7B0FF, 0x8D95FF, 0x7679FC, 0x5757C8) to intArrayOf(0x404383, 0x5154AC, 0x6366D5, 0x7679FC, 0xA0A8FE)),
        HabitColor.PURPLE to (intArrayOf(0xE6BDFF, 0xD89AFC, 0xC979F4, 0xB75AE7, 0x8D3BB6) to intArrayOf(0x613579, 0x7D409E, 0x9B4BC3, 0xB75AE7, 0xD68EFE)),
        HabitColor.PINK to (intArrayOf(0xFEBBBC, 0xFF9498, 0xFF6975, 0xFB2852, 0xC40138) to intArrayOf(0x842330, 0xAC233A, 0xD52144, 0xFB2852, 0xFF898F)),
        HabitColor.BROWN to (intArrayOf(0xDDCDB9, 0xC9B398, 0xB89C7B, 0xA48660, 0x7E6443) to intArrayOf(0x584936, 0x715D43, 0x8B7151, 0xA48660, 0xC7AC8B)),
        HabitColor.GRAY to (intArrayOf(0xC7D0E0, 0xACB8CF, 0x93A2BE, 0x7D8CAB, 0x5C6983) to intArrayOf(0x444C5B, 0x566175, 0x697690, 0x7D8CAB, 0xA3B2CD)),
    )
}

/**
 * Draws heat squares into a Canvas: every look batched into one path (one per step, one for the dashes, one per kind of
 * sign), never one call per day. [square] is the square in pixels; [unit] is one dp in pixels (signs are one size
 * everywhere: ✓ 12 dp, ✕ 9.5 dp, ⏩ and ⏸ 11 dp).
 */
class HeatDraw(private val square: Float, private val unit: Float) {
    private val fills = arrayOfNulls<Path>(6)
    private val dashes = Path()
    private val crosses = Path()
    private val signs = Path()
    private val checks = Path()
    private val today = Path()
    private val radius = square * 0.22f
    private val dashWidth = maxOf(1.2f * unit, square * 0.045f)

    private fun fill(n: Int): Path = fills[n] ?: Path().also { fills[n] = it }

    fun add(cell: HeatCell, left: Float, top: Float, isToday: Boolean = false) {
        val rect = Rect(left, top, left + square, top + square)
        when (cell) {
            HeatCell.Blank -> return
            HeatCell.Upcoming -> fill(0).addRoundRect(RoundRect(rect, CornerRadius(radius)))
            is HeatCell.Level -> {
                val step = cell.n.coerceIn(0, 5)
                fill(step).addRoundRect(RoundRect(rect, CornerRadius(radius)))
                if (step == 0) cross(rect)
                if (step >= 4) check(rect)
            }
            is HeatCell.Off -> if (cell.why == HeatOff.NOT_SCHEDULED) {
                val inset = dashWidth / 2
                dashes.addRoundRect(RoundRect(rect.deflate(inset), CornerRadius(radius - inset)))
            } else {
                // Skipped and paused days were due: grey, like not done, with their sign.
                fill(0).addRoundRect(RoundRect(rect, CornerRadius(radius)))
                if (cell.why == HeatOff.SKIPPED) skip(rect) else pause(rect)
            }
        }
        if (isToday) {
            val grow = 2.5f * unit
            today.addRoundRect(RoundRect(rect.inflate(grow), CornerRadius(radius + grow)))
        }
    }

    fun draw(scope: DrawScope, color: HabitColor, dark: Boolean) = with(scope) {
        for (n in 0..5) fills[n]?.let { drawPath(it, HeatPalette.color(n, color, dark)) }
        drawPath(dashes, HeatPalette.dash(dark), style = Stroke(dashWidth, pathEffect = PathEffect.dashPathEffect(floatArrayOf(square * 0.12f, square * 0.09f))))
        drawPath(crosses, HeatPalette.sign(dark), style = Stroke(2f * unit, cap = StrokeCap.Round, join = StrokeJoin.Round))
        drawPath(signs, HeatPalette.sign(dark))
        drawPath(checks, HeatPalette.check(color, dark), style = Stroke(2.4f * unit, cap = StrokeCap.Round, join = StrokeJoin.Round))
        drawPath(today, HeatPalette.today(dark), style = Stroke(1.5f * unit))
    }

    /** A point in a sign's box of [side] dp, centred on the square. */
    private fun point(rect: Rect, side: Float, x: Float, y: Float) =
        Offset(rect.center.x + (x - 0.5f) * side * unit, rect.center.y + (y - 0.5f) * side * unit)

    private fun check(rect: Rect) {
        val side = 12f
        point(rect, side, 0.04f, 0.54f).let { checks.moveTo(it.x, it.y) }
        point(rect, side, 0.37f, 0.86f).let { checks.lineTo(it.x, it.y) }
        point(rect, side, 0.96f, 0.16f).let { checks.lineTo(it.x, it.y) }
    }

    private fun cross(rect: Rect) {
        val side = 9.5f
        point(rect, side, 0f, 0f).let { crosses.moveTo(it.x, it.y) }
        point(rect, side, 1f, 1f).let { crosses.lineTo(it.x, it.y) }
        point(rect, side, 1f, 0f).let { crosses.moveTo(it.x, it.y) }
        point(rect, side, 0f, 1f).let { crosses.lineTo(it.x, it.y) }
    }

    private fun skip(rect: Rect) {
        val side = 11f
        for (x in floatArrayOf(0f, 0.5f)) {
            point(rect, side, x, 0.18f).let { signs.moveTo(it.x, it.y) }
            point(rect, side, x + 0.5f, 0.5f).let { signs.lineTo(it.x, it.y) }
            point(rect, side, x, 0.82f).let { signs.lineTo(it.x, it.y) }
            signs.close()
        }
    }

    private fun pause(rect: Rect) {
        val side = 11f
        for (x in floatArrayOf(0.16f, 0.6f)) {
            val origin = point(rect, side, x, 0.08f)
            val bar = Rect(origin.x, origin.y, origin.x + side * 0.24f * unit, origin.y + side * 0.84f * unit)
            signs.addRoundRect(RoundRect(bar, CornerRadius(0.8f * unit)))
        }
    }
}

/** One square on its own (a History row, the key). */
@Composable
fun HeatSquare(cell: HeatCell, color: HabitColor, size: Dp = HeatSize.smallest, isToday: Boolean = false, modifier: Modifier = Modifier) {
    val dark = appColors.dark
    Canvas(modifier.size(size + HeatSize.outline * 2)) {
        val pad = HeatSize.outline.toPx()
        val draw = HeatDraw(size.toPx(), 1.dp.toPx())
        draw.add(cell, pad, pad, isToday)
        draw.draw(this, color, dark)
    }
}

/** A row of squares, each centred in its column (the Week card's strip, the key's steps). One Canvas. */
@Composable
fun HeatStrip(cells: List<HeatCell>, todayIndex: Int?, color: HabitColor, size: Dp = HeatSize.week, modifier: Modifier = Modifier) {
    val dark = appColors.dark
    Canvas(modifier.fillMaxWidth().height(size + HeatSize.outline * 2)) {
        val pad = HeatSize.outline.toPx()
        val s = size.toPx()
        val column = this.size.width / maxOf(cells.size, 1)
        val draw = HeatDraw(s, 1.dp.toPx())
        cells.forEachIndexed { i, cell -> draw.add(cell, column * (i + 0.5f) - s / 2, pad, i == todayIndex) }
        draw.draw(this, color, dark)
    }
}

/** A month of squares in rows of seven, each centred in its weekday's column (the Month card). One Canvas. */
@Composable
fun HeatMonthGrid(lead: Int, cells: List<HeatCell>, todayIndex: Int?, color: HabitColor, size: Dp = HeatSize.month, rowGap: Dp = 8.dp) {
    val dark = appColors.dark
    val rows = (lead + cells.size + 6) / 7
    Canvas(Modifier.fillMaxWidth().height(size * rows + rowGap * maxOf(rows - 1, 0) + HeatSize.outline * 2)) {
        val pad = HeatSize.outline.toPx()
        val s = size.toPx()
        val gap = rowGap.toPx()
        val column = this.size.width / 7
        val draw = HeatDraw(s, 1.dp.toPx())
        cells.forEachIndexed { i, cell ->
            val place = lead + i
            draw.add(cell, column * (place % 7 + 0.5f) - s / 2, pad + (place / 7) * (s + gap), i == todayIndex)
        }
        draw.draw(this, color, dark)
    }
}

/**
 * Year in Pixels: twelve month columns by 31 day rows, the whole year at once. Squares are always 24 dp; only the gap
 * between columns adjusts so twelve fit. Days a month doesn't have stay empty. A tap selects a day; it never logs
 * anything. One Canvas, its labels measured once.
 */
@Composable
fun HeatYearPixels(
    cells: List<HeatCell>, monthStarts: List<Int>, monthLengths: List<Int>, monthNames: List<String>, todayIndex: Int?,
    selected: Int?, color: HabitColor, onSelect: (Int) -> Unit,
) {
    val dark = appColors.dark
    val label = appColors.secondary
    val ink = appColors.ink
    val measurer = rememberTextMeasurer()
    val monthStyle = AppType.labelSmall
    val dayStyle = AppType.labelSmall.copy(fontWeight = FontWeight.Normal)
    val monthLabels = remember(measurer, monthNames) { monthNames.map { measurer.measure(it, monthStyle) } }
    val dayLabels = remember(measurer) { (1..31).map { measurer.measure("$it", dayStyle) } }
    val gutter = 20.dp
    val header = 22.dp
    val rowGap = 3.dp
    val square = HeatSize.year
    val height = header + square * 31 + rowGap * 30 + HeatSize.outline
    Canvas(
        Modifier.fillMaxWidth().height(height)
            .pointerInput(monthStarts, monthLengths, cells.size) {
                detectTapGestures { at ->
                    val s = square.toPx()
                    val g = gutter.toPx()
                    val gap = ((size.width - g - 12 * s) / 11).coerceIn(1.dp.toPx(), 4.dp.toPx())
                    val rg = rowGap.toPx()
                    val column = floor((at.x - g + gap / 2) / (s + gap)).toInt()
                    val row = floor((at.y - header.toPx() + rg / 2) / (s + rg)).toInt()
                    if (column < 0 || column >= minOf(12, monthStarts.size) || row < 0 || row >= monthLengths[column]) return@detectTapGestures
                    val index = monthStarts[column] + row
                    if (index < cells.size) onSelect(index)
                }
            }
            .clearAndSetSemantics { testTag = "year-pixels" },
    ) {
        val s = square.toPx()
        val g = gutter.toPx()
        val h = header.toPx()
        val rg = rowGap.toPx()
        val gap = ((size.width - g - 12 * s) / 11).coerceIn(1.dp.toPx(), 4.dp.toPx())
        val pitchX = s + gap
        val pitchY = s + rg
        for (m in 0 until minOf(12, monthLabels.size)) {
            val t = monthLabels[m]
            drawText(t, color = label, topLeft = Offset(g + m * pitchX + s / 2 - t.size.width / 2f, h / 2 - t.size.height / 2f))
        }
        for (d in 0 until 31) {
            val t = dayLabels[d]
            drawText(t, color = label, topLeft = Offset(g - 4.dp.toPx() - t.size.width, h + d * pitchY + s / 2 - t.size.height / 2f))
        }
        val draw = HeatDraw(s, 1.dp.toPx())
        var picked: Rect? = null
        for (m in 0 until minOf(12, monthStarts.size)) {
            for (d in 0 until monthLengths[m]) {
                val i = monthStarts[m] + d
                if (i >= cells.size) continue
                val left = g + m * pitchX
                val top = h + d * pitchY
                draw.add(cells[i], left, top, i == todayIndex)
                if (i == selected) picked = Rect(left, top, left + s, top + s)
            }
        }
        draw.draw(this, color, dark)
        picked?.let { r ->
            val grow = 2.dp.toPx()
            val ring = Path().apply { addRoundRect(RoundRect(r.inflate(grow), CornerRadius(s * 0.22f + grow))) }
            drawPath(ring, ink, style = Stroke(2.dp.toPx()))
        }
    }
}

// ------------------------------------------------------------------------------------------------ What the squares mean

/** Saved once the person folds the key anywhere: from then on it starts folded everywhere (Current Work 57). */
const val HEAT_KEY_FOLDED = "heatKey.folded"

/**
 * "What the squares mean": a folding card, open until the person folds it once anywhere in the app. [open] and
 * [onToggle] belong to the page's visit, so History and Progress share it.
 */
@OptIn(ExperimentalLayoutApi::class)
@Composable
fun HeatKeyCard(open: Boolean, onToggle: () -> Unit, modifier: Modifier = Modifier) {
    val c = appColors
    Column(modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.surface).animateContentSize()) {
        Row(
            Modifier.fillMaxWidth().clickable(onClick = onToggle).heightIn(min = 56.dp).padding(horizontal = 16.dp, vertical = 12.dp)
                .semantics(mergeDescendants = true) {
                    stateDescription = if (open) "Shown" else "Hidden"
                    testTag = "heat-key-toggle"
                },
            verticalAlignment = Alignment.CenterVertically,
        ) {
            Text("What the squares mean", Modifier.weight(1f), style = MaterialTheme.typography.titleMedium, color = c.ink)
            Icon(if (open) Icons.Rounded.ExpandLess else Icons.Rounded.ExpandMore, null, tint = c.ink)
        }
        if (open) {
            Column(
                Modifier.fillMaxWidth().padding(start = 16.dp, end = 16.dp, bottom = 16.dp).clearAndSetSemantics {
                    // "%", not the word: the key names the steps; it isn't a progress percentage.
                    contentDescription = "Key. Progress, lighter to darker in the habit's colour: 1 to 33%, 34 to 66%, 67 to 99%, " +
                        "goal met with a check, more than the goal with a check. Planned that day, grey: not done with a cross, " +
                        "skipped, paused. Other days: plain grey still to come, dashed not scheduled, an outline for today."
                    testTag = "progress-key"
                },
                verticalArrangement = Arrangement.spacedBy(16.dp),
            ) {
                Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                    KeyHeading("Progress", "Shown in green; each habit uses its own colour")
                    HeatStrip(stepCells, null, HabitColor.GREEN, HeatSize.smallest)
                    Row(Modifier.fillMaxWidth()) {
                        for (step in stepNames) {
                            Text(step, Modifier.weight(1f), style = MaterialTheme.typography.labelSmall.copy(fontWeight = FontWeight.Normal),
                                color = c.secondary, textAlign = TextAlign.Center)
                        }
                    }
                }
                Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                    KeyHeading("Planned that day", null)
                    FlowRow(horizontalArrangement = Arrangement.spacedBy(16.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
                        KeyEntry(HeatCell.level(0), "Not done")
                        KeyEntry(HeatCell.skipped, "Skipped")
                        KeyEntry(HeatCell.paused, "Paused")
                    }
                }
                Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                    KeyHeading("Other days", null)
                    FlowRow(horizontalArrangement = Arrangement.spacedBy(16.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
                        KeyEntry(HeatCell.Upcoming, "Still to come")
                        KeyEntry(HeatCell.notScheduled, "Not scheduled")
                        KeyEntry(HeatCell.Upcoming, "Today", isToday = true)
                    }
                }
            }
        }
    }
}

private val stepCells: List<HeatCell> = (1..5).map { HeatCell.level(it) }
private val stepNames = listOf("1–33%", "34–66%", "67–99%", "Goal met\n100%", "More\nover 100%")

@Composable
private fun KeyHeading(title: String, note: String?) {
    Column {
        Text(title, style = MaterialTheme.typography.labelLarge, color = appColors.ink)
        if (note != null) Text(note, style = MaterialTheme.typography.labelSmall.copy(fontWeight = FontWeight.Normal), color = appColors.secondary)
    }
}

@Composable
private fun KeyEntry(cell: HeatCell, title: String, isToday: Boolean = false) {
    Row(verticalAlignment = Alignment.CenterVertically) {
        HeatSquare(cell, HabitColor.GREEN, HeatSize.smallest, isToday)
        Spacer(Modifier.width(6.dp))
        Text(title, style = MaterialTheme.typography.bodySmall, color = appColors.secondary, maxLines = 1)
    }
}
