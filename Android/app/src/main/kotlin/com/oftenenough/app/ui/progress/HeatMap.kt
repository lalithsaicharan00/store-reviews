package com.oftenenough.app.ui.progress

import com.oftenenough.app.ui.theme.AppType

import androidx.compose.foundation.ScrollState
import androidx.compose.foundation.gestures.detectTapGestures
import androidx.compose.foundation.horizontalScroll
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberUpdatedState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.drawWithCache
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.layout.layout
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.text.drawText
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.rememberTextMeasurer
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextDecoration
import androidx.compose.ui.unit.Constraints
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HeatCell
import com.oftenenough.app.data.WeekColumn
import com.oftenenough.app.data.YearLayout
import com.oftenenough.app.ui.components.DayCellDraw
import com.oftenenough.app.ui.components.dayCellColors
import com.oftenenough.app.ui.components.DayCellSize
import com.oftenenough.app.ui.theme.appColors
import kotlin.math.max
import kotlin.math.min
import kotlin.math.roundToInt

// Progress's squares (the iPhone's HeatMap.swift: HeatRow, HeatMonth, HeatYear): Week's row, Month's rows of seven and
// Year's GitHub grid. Every square is drawn by the Day cell atom's `DayCellDraw` (ui/components/DayCell.kt), so a square looks
// the same everywhere; each card's squares are one drawing, cached until its cells change (Rulebook S8, S12), never a
// lazy grid (S13). A tap on a square names its day; the card decides what opens.

/** Square sizes on Progress: Week's and Month's fill a seventh of the card up to [WEEK]; Year's stay readable and it scrolls. */
internal object ProgressHeatSize {
    val WEEK = DayCellSize.week
    /** The least space between two squares in Week and Month. */
    val GAP = 6.dp
    val YEAR = 24.dp
    val YEAR_GAP = 4.dp
    /** Room around a square for today's outline. */
    val OUTLINE = 3.dp
    /** Room for the month names over the year. */
    val YEAR_LABELS = 18.dp
}

/** A square's size for seven columns [width] wide (px): a seventh less a gap, never above [cap]. */
private fun sevenths(width: Float, cap: Float, gap: Float): Float = max(1f, min(cap, width / 7f - gap))

/**
 * Seven columns of squares in rows (Week: one row; Month: [lead] empty places, then the month), each centred in its
 * weekday's column. One drawing; a tap gives the cell's index (from the period's first day) to [onCell], or null
 * outside every square.
 */
@Composable
internal fun HeatGrid(cells: List<HeatCell>, lead: Int, todayIndex: Int?, color: HabitColor, onCell: (Int?) -> Unit, modifier: Modifier = Modifier) {
    val density = LocalDensity.current
    val unit = density.density
    val colors = dayCellColors(color)
    val cap = with(density) { ProgressHeatSize.WEEK.toPx() }
    val gap = with(density) { ProgressHeatSize.GAP.toPx() }
    val pad = with(density) { ProgressHeatSize.OUTLINE.toPx() }
    val rows = (lead + cells.size + 6) / 7
    val tap by rememberUpdatedState(onCell)
    Spacer(
        modifier
            .fillMaxWidth()
            .layout { measurable, constraints ->
                val w = constraints.maxWidth
                val sq = sevenths(w.toFloat(), cap, gap)
                val h = (rows * sq + max(rows - 1, 0) * gap + 2 * pad).roundToInt()
                val placeable = measurable.measure(Constraints.fixed(w, h))
                layout(w, h) { placeable.place(0, 0) }
            }
            .drawWithCache {
                val sq = sevenths(size.width, cap, gap)
                val column = size.width / 7f
                val heat = DayCellDraw(sq, unit)
                cells.forEachIndexed { i, cell ->
                    val place = lead + i
                    heat.add(cell, column * (place % 7 + 0.5f) - sq / 2, pad + (place / 7) * (sq + gap), i == todayIndex)
                }
                onDrawBehind { heat.draw(this, colors) }
            }
            .pointerInput(lead, cells.size) {
                detectTapGestures { at: Offset ->
                    val width = size.width.toFloat()
                    val sq = sevenths(width, cap, gap)
                    val col = (at.x / (width / 7f)).toInt().coerceIn(0, 6)
                    val row = ((at.y - pad) / (sq + gap)).toInt()
                    val index = row * 7 + col - lead
                    tap(if (at.y >= 0f && row >= 0 && index in cells.indices) index else null)
                }
            },
    )
}

/** Week: the weekday names (today's underlined), then the week's squares. */
@Composable
internal fun HeatWeek(columns: List<WeekColumn>, cells: List<HeatCell>, color: HabitColor, onCell: (Int?) -> Unit) {
    val todayIndex = columns.indexOfFirst { it.isToday }.takeIf { it >= 0 }
    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
        Row(Modifier.fillMaxWidth()) {
            for (column in columns) WeekdayLabel(column.short, column.isToday, Modifier.weight(1f))
        }
        HeatGrid(cells, 0, todayIndex, color, onCell)
    }
}

/** Month: the weekday letters in the person's order (today's underlined), then the month in rows of seven. */
@Composable
internal fun HeatMonth(lead: Int, letters: List<String>, todayIndex: Int?, cells: List<HeatCell>, color: HabitColor, onCell: (Int?) -> Unit) {
    val todayColumn = todayIndex?.let { (lead + it) % 7 }
    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
        Row(Modifier.fillMaxWidth()) {
            for (i in 0 until 7) WeekdayLabel(letters.getOrElse(i) { "" }, i == todayColumn, Modifier.weight(1f))
        }
        HeatGrid(cells, lead, todayIndex, color, onCell)
    }
}

@Composable
private fun WeekdayLabel(text: String, isToday: Boolean, modifier: Modifier) {
    val c = appColors
    Text(
        text, modifier, maxLines = 1, textAlign = TextAlign.Center,
        style = MaterialTheme.typography.bodyMedium.copy(
            fontWeight = if (isToday) FontWeight.Medium else FontWeight.Normal,
            textDecoration = if (isToday) TextDecoration.Underline else TextDecoration.None,
        ),
        color = if (isToday) c.ink else c.secondary,
    )
}

/**
 * A habit's year as GitHub's grid: weeks left to right, weekdays top to bottom, months on top. Squares stay readable;
 * the year scrolls sideways instead of shrinking, opening on its latest weeks. The weekday letters stay put.
 */
@Composable
internal fun HeatYear(layout: YearLayout, cells: List<HeatCell>, color: HabitColor, onCell: (Int?) -> Unit) {
    val c = appColors
    val colors = dayCellColors(color)
    val unit = LocalDensity.current.density
    val measurer = rememberTextMeasurer()
    val labelStyle = MaterialTheme.typography.labelMedium.copy(color = c.secondary)
    val square = ProgressHeatSize.YEAR
    val pitch = ProgressHeatSize.YEAR + ProgressHeatSize.YEAR_GAP
    val outline = ProgressHeatSize.OUTLINE
    val labels = ProgressHeatSize.YEAR_LABELS
    val columns = max(layout.columns, 1)
    // Room after the last column for a month name that starts there.
    val width = outline * 2 + pitch * columns - ProgressHeatSize.YEAR_GAP + 24.dp
    val height = labels + outline * 2 + pitch * 7 - ProgressHeatSize.YEAR_GAP
    // Another year opens again on its latest weeks: the scroll starts past the end and is kept within its range.
    val scroll = remember(layout) { ScrollState(Int.MAX_VALUE) }
    val tap by rememberUpdatedState(onCell)
    Row(verticalAlignment = Alignment.Top) {
        Column(Modifier.padding(top = labels + outline).width(16.dp), verticalArrangement = Arrangement.spacedBy(ProgressHeatSize.YEAR_GAP)) {
            for (row in 0 until 7) {
                val isToday = row == layout.todayRow
                Box(Modifier.size(16.dp, square), contentAlignment = Alignment.CenterStart) {
                    Text(layout.letters.getOrElse(row) { "" }, maxLines = 1,
                        style = if (isToday) AppType.labelMedium else AppType.labelMedium.copy(fontWeight = FontWeight.Normal),
                        color = if (isToday) c.ink else c.secondary)
                }
            }
        }
        Spacer(Modifier.width(4.dp))
        Box(Modifier.weight(1f).horizontalScroll(scroll)) {
            Spacer(
                Modifier.size(width, height)
                    .drawWithCache {
                        val pad = outline.toPx()
                        val sq = square.toPx()
                        val step = pitch.toPx()
                        val top = labels.toPx() + pad
                        val names = layout.months.map { it to measurer.measure(it.name, labelStyle) }
                        val heat = DayCellDraw(sq, unit)
                        val todayPlace = if (layout.todayRow == null) -1 else layout.lead + layout.shown - 1
                        for (i in 0 until min(layout.shown, cells.size)) {
                            val place = layout.lead + i
                            heat.add(cells[i], pad + (place / 7) * step, top + (place % 7) * step, place == todayPlace)
                        }
                        onDrawBehind {
                            for ((month, text) in names) drawText(text, topLeft = Offset(pad + month.column * step, 0f))
                            heat.draw(this, colors)
                        }
                    }
                    .pointerInput(layout) {
                        detectTapGestures { at: Offset ->
                            val pad = outline.toPx()
                            val step = pitch.toPx()
                            val top = labels.toPx() + pad
                            val inside = at.x >= pad && at.y >= top
                            val column = ((at.x - pad) / step).toInt()
                            val row = ((at.y - top) / step).toInt()
                            val index = column * 7 + row - layout.lead
                            tap(if (inside && row in 0..6 && index in 0 until layout.shown) index else null)
                        }
                    },
            )
        }
    }
}
