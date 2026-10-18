package com.oftenenough.app.ui.charts

import com.oftenenough.app.ui.theme.AppType

import androidx.compose.foundation.layout.defaultMinSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.Spacer
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.drawWithCache
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.PathEffect
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.text.TextLayoutResult
import androidx.compose.ui.text.drawText
import androidx.compose.ui.text.rememberTextMeasurer
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.oftenenough.app.data.Format
import com.oftenenough.app.ui.theme.appColors
import kotlin.math.ceil
import kotlin.math.floor
import kotlin.math.log10
import kotlin.math.max
import kotlin.math.min
import kotlin.math.pow

// Charts drawn in one pass (Rulebook S12; the iPhone's LightBarChart.swift): bars, a goal line, grid lines and axis labels
// in one drawing, with no layout of their own. Swift Charts' first layout of a scrolling page froze it for up to 2.7 s on
// the iPhone; the same picture drawn here is one node. Text is measured once per set of values (rememberTextMeasurer, in
// the drawing's cache), never per frame.

/**
 * A bar chart: a bar per value, scaled to a round top above the largest value (or the [goal], when higher); an optional
 * dashed [goal] line; three to five grid lines with their values on the right; and [labels] under the bars. With one
 * label per value, each sits under its own bar (an empty one is skipped: "1", "", …, "8"); otherwise the labels are
 * spread evenly across the chart. TalkBack reads [description]. Give it a height (it is at least 140 dp).
 */
@Composable
fun LightBarChart(
    values: List<Double>,
    color: Color,
    description: String,
    modifier: Modifier = Modifier,
    goal: Double? = null,
    labels: List<String> = emptyList(),
) {
    val c = appColors
    val measurer = rememberTextMeasurer()
    val labelStyle = AppType.labelSmall.copy(color = c.secondary)
    val gridColor = c.secondary.copy(alpha = 0.25f)
    val goalColor = c.secondary
    Spacer(
        modifier
            .fillMaxWidth()
            .defaultMinSize(minHeight = 140.dp)
            .semantics { contentDescription = description }
            .drawWithCache {
                val highest = max(values.filter { it.isFinite() }.maxOrNull() ?: 0.0, goal?.takeIf { it.isFinite() } ?: 0.0)
                val axis = ChartAxis.of(highest)
                val ticks = ArrayList<Double>()
                var t = 0.0
                while (t <= axis.top + axis.step / 2) { ticks.add(t); t += axis.step }
                val tickTexts: List<TextLayoutResult> = ticks.map { measurer.measure(Format.amount(it), labelStyle) }
                val gutter = (tickTexts.maxOfOrNull { it.size.width } ?: 0) + 8.dp.toPx()
                val xTexts: List<Pair<Float, TextLayoutResult>> = when {
                    labels.isEmpty() -> emptyList()
                    labels.size == values.size -> labels.mapIndexedNotNull { i, s ->
                        if (s.isEmpty()) null else ((i + 0.5f) / values.size) to measurer.measure(s, labelStyle)
                    }
                    else -> labels.mapIndexed { i, s -> ((i + 0.5f) / labels.size) to measurer.measure(s, labelStyle) }
                }
                val bottomRoom = if (xTexts.isEmpty()) 0f else (xTexts.maxOf { it.second.size.height } + 4.dp.toPx())
                val topRoom = (tickTexts.firstOrNull()?.size?.height ?: 0) / 2f + 2.dp.toPx()
                val plotLeft = 0f
                val plotRight = max(plotLeft + 1f, size.width - gutter)
                val plotTop = topRoom
                val plotBottom = max(plotTop + 1f, size.height - bottomRoom)
                val top = max(axis.top, Double.MIN_VALUE)
                fun y(v: Double): Float = plotBottom - (min(max(v, 0.0), top) / top).toFloat() * (plotBottom - plotTop)
                fun x(at: Float): Float = plotLeft + at * (plotRight - plotLeft)

                // Bars: one path, so a month of bars is one fill. Each fills four fifths of its slot.
                val bars = Path()
                val count = values.size
                for (i in 0 until count) {
                    val v = values[i]
                    if (!v.isFinite() || v <= 0) continue
                    val left = x(i.toFloat() / count)
                    val right = x((i + 1).toFloat() / count)
                    val gap = max(1f, (right - left) * 0.2f)
                    bars.addRect(androidx.compose.ui.geometry.Rect(left + gap / 2, y(v), max(left + gap / 2 + 1f, right - gap / 2), plotBottom))
                }
                val goalY = goal?.takeIf { it.isFinite() && it > 0 }?.let { y(it) }
                val dash = PathEffect.dashPathEffect(floatArrayOf(4.dp.toPx(), 3.dp.toPx()))
                val hairline = 0.5.dp.toPx()

                onDrawBehind {
                    for ((i, tick) in ticks.withIndex()) {
                        val ty = y(tick)
                        drawLine(gridColor, Offset(plotLeft, ty), Offset(plotRight, ty), strokeWidth = hairline)
                        val text = tickTexts[i]
                        drawText(text, topLeft = Offset(size.width - text.size.width, ty - text.size.height / 2f))
                    }
                    drawPath(bars, color)
                    if (goalY != null) {
                        val line = Path().apply { moveTo(plotLeft, goalY); lineTo(plotRight, goalY) }
                        drawPath(line, goalColor, style = Stroke(width = 1.dp.toPx(), pathEffect = dash))
                    }
                    for ((at, text) in xTexts) {
                        val left = (x(at) - text.size.width / 2f).coerceIn(0f, max(0f, size.width - text.size.width))
                        drawText(text, topLeft = Offset(left, plotBottom + 4.dp.toPx()))
                    }
                }
            },
    )
}

/** A round top and step, three to five grid lines: 0, 2, 4, 6, 8 for a goal of 8 (the iPhone's `ChartGrid.axis`). */
internal class ChartAxis(val top: Double, val step: Double) {
    companion object {
        fun of(highest: Double): ChartAxis {
            if (highest <= 0) return ChartAxis(1.0, 1.0)
            val rough = highest / 4
            val magnitude = 10.0.pow(floor(log10(rough)))
            val step = listOf(1.0, 2.0, 2.5, 5.0, 10.0).map { it * magnitude }.firstOrNull { it >= rough } ?: (10 * magnitude)
            return ChartAxis(ceil(highest / step) * step, step)
        }
    }
}
