package com.oftenenough.app.ui.components

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.gestures.detectTapGestures
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberUpdatedState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.blur
import androidx.compose.ui.draw.clip
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.layout.layout
import androidx.compose.ui.unit.Constraints
import androidx.compose.ui.semantics.clearAndSetSemantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.drawText
import androidx.compose.ui.text.rememberTextMeasurer
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HeatCell
import com.oftenenough.app.ui.theme.AppType
import kotlin.math.floor
import kotlin.math.roundToInt

/** The grid's measures: the day numbers' column, the gap between squares both ways, and the room kept at its end. */
private val DayColumn = 18.dp
private val Gap = 3.dp
private val EndRoom = 8.dp

/**
 * Molecule 4.17, **Year in pixels card** (Figma 1226:2470; Components — Atoms Build Plan): Habit details › Progress,
 * the whole year, a column per month and a row per day.
 *
 * The Habit history card's frame and header (4.15: "Year in pixels", [period], ‹ ›), the [summary] and its [detail],
 * then the grid, then "Tap a square to see its day." in Body Small On surface variant. The grid fills the card's width
 * and never scrolls sideways: a square is (the width − 8 at the end − the 18 dp day column − 12 gaps of 3) ÷ 12, 19.5
 * on a 360 dp phone, about 23.8 on a 412 dp one; rows 3 apart. Over each month its letter, centred; down the side the
 * 1st, 6th, 11th … 31st; all Body Small On surface variant. Each square is the Day cell (3.6, Size Year, scaled);
 * days before the habit started and dates that don't exist are left empty, and no square has a note's dot (A60). One
 * Canvas (S12). A tap on a square gives [onTap] its index in the year.
 *
 * **Plan Free** ([locked], A73: Year in Pixels is Plus): the same height, so the page doesn't jump; under the header
 * the summary, grid and footnote are blurred (10) under the Scrim at 16 %, the arrows hidden in place; a prompt
 * (Surface container lowest, 24 corners, 20 by 24 in, 12 apart: the [PlusLabel] and "Your whole year, a square a day"
 * in Title Medium) sits 16 under the header, centred. The whole card is one tap target: [onUnlock] opens Plus.
 */
@Composable
fun YearInPixelsCard(
    period: String, canGoBack: Boolean, canGoForward: Boolean, move: (Int) -> Unit, summary: String?, detail: String?,
    cells: List<HeatCell>, monthStarts: List<Int>, monthLengths: List<Int>, todayIndex: Int?, color: HabitColor,
    onTap: (Int) -> Unit, modifier: Modifier = Modifier, locked: Boolean = false, onUnlock: () -> Unit = {},
) {
    val s = MaterialTheme.colorScheme
    Box(modifier.fillMaxWidth()) {
        HabitHistoryCard(onClick = if (locked) onUnlock else null, onClickLabel = if (locked) "Get Plus" else null) {
            HistoryPeriodHeader("Year in pixels", period, "year", canGoBack && !locked, canGoForward && !locked, arrows = !locked, move = move)
            Column(Modifier.let { if (locked) it.blur(10.dp) else it }, verticalArrangement = Arrangement.spacedBy(12.dp)) {
                summary?.let { HistorySummary(it, detail) }
                YearGrid(cells, monthStarts, monthLengths, todayIndex, color, if (locked) null else onTap)
                Text("Tap a square to see its day.", style = AppType.bodySmall, color = s.onSurfaceVariant)
            }
        }
        if (locked) {
            // The Scrim over everything under the header (16 + 48 + 8 down), and the prompt 16 under it.
            Box(Modifier.matchParentSize().padding(top = 72.dp).clip(RoundedCornerShape(bottomStart = 24.dp, bottomEnd = 24.dp))
                .background(s.scrim.copy(alpha = 0.16f)))
            Column(
                Modifier.align(Alignment.TopCenter).padding(top = 88.dp, start = 22.dp, end = 22.dp).widthIn(max = 285.dp)
                    .clip(RoundedCornerShape(24.dp)).background(s.surfaceContainerLowest).padding(horizontal = 24.dp, vertical = 20.dp),
                verticalArrangement = Arrangement.spacedBy(12.dp), horizontalAlignment = Alignment.CenterHorizontally,
            ) {
                PlusLabel()
                Text("Your whole year, a square a day", style = AppType.titleMedium, color = s.onSurface, textAlign = TextAlign.Center)
            }
        }
    }
}

/** Twelve month columns by 31 day rows, the squares filling the width, in one Canvas; labels measured once. */
@Composable
private fun YearGrid(cells: List<HeatCell>, monthStarts: List<Int>, monthLengths: List<Int>, todayIndex: Int?, color: HabitColor, onTap: ((Int) -> Unit)?) {
    val s = MaterialTheme.colorScheme
    val colors = dayCellColors(color)
    val measurer = rememberTextMeasurer()
    val style = AppType.bodySmall
    val months = remember(measurer, style) { "JFMAMJJASOND".map { measurer.measure(it.toString(), style) } }
    val days = remember(measurer, style) { (1..31 step 5).map { it to measurer.measure("$it", style) } }
    val label = s.onSurfaceVariant
    val tap by rememberUpdatedState(onTap)
    Canvas(
        // Its height follows its width: the letters' row, then 31 rows of squares 3 apart, and room for today's ring.
        Modifier.fillMaxWidth().layout { measurable, constraints ->
            val w = constraints.maxWidth
            val g = YearGeometry(w.toFloat(), density)
            val h = (g.top + 31 * g.pitch - g.gap + DayCellSize.ring.toPx()).roundToInt()
            val placeable = measurable.measure(Constraints.fixed(w, h))
            layout(w, h) { placeable.place(0, 0) }
        }
            .let { m ->
                if (onTap == null) m else m.pointerInput(monthStarts, monthLengths, cells.size) {
                    detectTapGestures { at ->
                        val g = YearGeometry(size.width.toFloat(), density)
                        val column = floor((at.x - g.left + g.gap / 2) / g.pitch).toInt()
                        val row = floor((at.y - g.top + g.gap / 2) / g.pitch).toInt()
                        if (column !in 0 until minOf(12, monthStarts.size) || row < 0 || row >= monthLengths[column]) return@detectTapGestures
                        val index = monthStarts[column] + row
                        if (index < cells.size) tap?.invoke(index)
                    }
                }
            }
            .clearAndSetSemantics { testTag = "year-pixels" },
    ) {
        val g = YearGeometry(size.width, density)
        for (m in 0 until 12) {
            val t = months[m]
            drawText(t, color = label, topLeft = Offset(g.left + m * g.pitch + g.square / 2 - t.size.width / 2f, 0f))
        }
        for ((day, t) in days) drawText(t, color = label, topLeft = Offset(0f, g.top + (day - 1) * g.pitch + g.square / 2 - t.size.height / 2f))
        val draw = DayCellDraw(g.square, 1.dp.toPx())
        for (m in 0 until minOf(12, monthStarts.size)) {
            for (d in 0 until monthLengths[m]) {
                val i = monthStarts[m] + d
                if (i < cells.size) draw.add(cells[i], g.left + m * g.pitch, g.top + d * g.pitch, i == todayIndex)
            }
        }
        draw.draw(this, colors)
    }
}

/** Where the grid's squares go for a [width] (px): Figma's square = (width − 8 − 18 − 12 × 3) ÷ 12. */
private class YearGeometry(width: Float, density: Float) {
    val gap = Gap.value * density
    val left = (DayColumn.value + Gap.value) * density
    val square = (width - (EndRoom.value + DayColumn.value + 12 * Gap.value) * density) / 12f
    val pitch = square + gap
    /** The month letters' 16 dp row and a gap. */
    val top = (16 + Gap.value) * density
}
