package com.oftenenough.app.ui.habit

import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.components.DayCell
import com.oftenenough.app.ui.components.DayCellDraw
import com.oftenenough.app.ui.components.DayCellSize
import com.oftenenough.app.ui.components.dayCellColors

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
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.semantics.clearAndSetSemantics
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.stateDescription
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.drawText
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.rememberTextMeasurer
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HeatCell
import com.oftenenough.app.ui.theme.appColors
import kotlin.math.floor

// The day cells' layouts: a week's strip, a month, the year in pixels, and the key. Every cell is the Day cell atom
// (ui/components/DayCell.kt), drawn in batches by `DayCellDraw`, in one Canvas each (Rulebook S12).

/** A row of squares, each centred in its column (the Week card's strip, the key's steps). One Canvas. */
@Composable
fun HeatStrip(cells: List<HeatCell>, todayIndex: Int?, color: HabitColor, size: Dp = DayCellSize.week, modifier: Modifier = Modifier) {
    val colors = dayCellColors(color)
    Canvas(modifier.fillMaxWidth().height(size + DayCellSize.ring * 2)) {
        val pad = DayCellSize.ring.toPx()
        val s = size.toPx()
        val column = this.size.width / maxOf(cells.size, 1)
        val draw = DayCellDraw(s, 1.dp.toPx())
        cells.forEachIndexed { i, cell -> draw.add(cell, column * (i + 0.5f) - s / 2, pad, i == todayIndex) }
        draw.draw(this, colors)
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
    selected: Int?, color: HabitColor, notes: Set<Int> = emptySet(), onSelect: (Int) -> Unit,
) {
    val colors = dayCellColors(color)
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
    val square = DayCellSize.year
    val height = header + square * 31 + rowGap * 30 + DayCellSize.ring
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
        val draw = DayCellDraw(s, 1.dp.toPx())
        var picked: Rect? = null
        for (m in 0 until minOf(12, monthStarts.size)) {
            for (d in 0 until monthLengths[m]) {
                val i = monthStarts[m] + d
                if (i >= cells.size) continue
                val left = g + m * pitchX
                val top = h + d * pitchY
                draw.add(cells[i], left, top, i == todayIndex)
                if (i in notes) draw.note(cells[i], left, top, below = false)
                if (i == selected) picked = Rect(left, top, left + s, top + s)
            }
        }
        draw.draw(this, colors)
        picked?.let { r ->
            val grow = 2.dp.toPx()
            val ring = Path().apply { addRoundRect(RoundRect(r.inflate(grow), CornerRadius(draw.radius + grow))) }
            drawPath(ring, ink, style = Stroke(2.dp.toPx()))
        }
    }
}

// ------------------------------------------------------------------------------------------------ What the squares mean

/** Saved once the person folds the key anywhere: from then on it starts folded everywhere (Current Work 57). */
const val HEAT_KEY_FOLDED = "heatKey.folded"

/**
 * Habit details' "What the squares mean" (Figma 1373:2, 3.7): a folding card, open until the person folds it once anywhere in the app; every
 * state in the habit's [color], the note mark, and the days before the habit started. [open] and [onToggle] belong to the
 * page's visit.
 */
@Composable
fun HabitKeyCard(open: Boolean, onToggle: () -> Unit, color: HabitColor, modifier: Modifier = Modifier) {
    val c = appColors
    Column(modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.surface).animateContentSize()) {
        Row(
            Modifier.fillMaxWidth().clickable(onClick = onToggle).heightIn(min = 56.dp).padding(start = 20.dp, end = 16.dp, top = 12.dp, bottom = 12.dp)
                .semantics(mergeDescendants = true) {
                    stateDescription = if (open) "Shown" else "Hidden"
                    testTag = "heat-key-toggle"
                },
            verticalAlignment = Alignment.CenterVertically,
        ) {
            Text("What the squares mean", Modifier.weight(1f), style = AppType.titleMedium, color = c.ink)
            Icon(if (open) Symbols.ExpandLess else Symbols.ExpandMore, null, tint = c.ink)
        }
        if (open) {
            Column(
                Modifier.fillMaxWidth().padding(start = 16.dp, end = 16.dp, top = 16.dp, bottom = 20.dp).semantics { testTag = "progress-key" },
                verticalArrangement = Arrangement.spacedBy(12.dp),
            ) {
                for ((cell, title) in keyRows) KeyRow(cell, title, color)
                KeyRow(HeatCell.Upcoming, "Today", color, isToday = true)
                Text("Nothing here counts against you: skipped, paused and no-goal days are left out of every count.",
                    style = AppType.bodySmall, color = MaterialTheme.colorScheme.onSurfaceVariant)
            }
        }
    }
}

/** Figma's key, in its order and words (Habit details, Key open). */
private val keyRows: List<Pair<HeatCell, String>> = listOf(
    HeatCell.level(4) to "Done: the goal was reached",
    HeatCell.level(5) to "More than the goal",
    HeatCell.level(2) to "Part of the goal",
    HeatCell.level(0) to "Not done",
    HeatCell.notScheduled to "No goal that day",
    HeatCell.skipped to "Skipped",
    HeatCell.paused to "Paused",
    HeatCell.Blank to "Before the habit started",
    HeatCell.Upcoming to "Still to come",
)

/** A Week-size cell, then its words 16 after, in Body Medium; today's ring reaches past the 36 into the 12 between rows. */
@Composable
private fun KeyRow(cell: HeatCell, title: String, color: HabitColor, isToday: Boolean = false) {
    val colors = dayCellColors(color)
    Row(Modifier.fillMaxWidth().semantics(mergeDescendants = true) { }, verticalAlignment = Alignment.CenterVertically) {
        Canvas(Modifier.size(DayCellSize.week)) {
            DayCellDraw(size.width, 1.dp.toPx()).apply { add(cell, 0f, 0f, isToday) }.draw(this, colors)
        }
        Spacer(Modifier.width(16.dp))
        Text(title, style = AppType.bodyMedium, color = MaterialTheme.colorScheme.onSurface)
    }
}

/**
 * The Progress page's "What the squares mean" (every habit at once, so the steps of colour): a folding card, open until the person folds it once anywhere in the app. [open] and
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
            Icon(if (open) Symbols.ExpandLess else Symbols.ExpandMore, null, tint = c.ink)
        }
        if (open) {
            Column(
                Modifier.fillMaxWidth().padding(start = 16.dp, end = 16.dp, bottom = 16.dp).clearAndSetSemantics {
                    // "%", not the word: the key names the steps; it isn't a progress percentage.
                    contentDescription = "Key. In the habit's colour: part of the goal, lighter; done, with a check; more than the goal, deeper, " +
                        "with a check. Planned that day, grey: not done with a cross, skipped, paused. Other days: plain grey " +
                        "still to come, a dashed outline no goal that day, a ring for today."
                    testTag = "progress-key"
                },
                verticalArrangement = Arrangement.spacedBy(16.dp),
            ) {
                Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                    KeyHeading("Progress", "Shown in green; each habit uses its own colour")
                    HeatStrip(stepCells, null, HabitColor.GREEN, DayCellSize.year)
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
                        KeyEntry(HeatCell.notScheduled, "No goal that day")
                        KeyEntry(HeatCell.Upcoming, "Today", isToday = true)
                    }
                }
            }
        }
    }
}

private val stepCells: List<HeatCell> = listOf(HeatCell.level(2), HeatCell.level(4), HeatCell.level(5))
private val stepNames = listOf("Part of\nthe goal", "Done", "More than\nthe goal")

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
        DayCell(cell, HabitColor.GREEN, size = DayCellSize.year, isToday = isToday)
        Spacer(Modifier.width(6.dp))
        Text(title, style = MaterialTheme.typography.bodySmall, color = appColors.secondary, maxLines = 1)
    }
}
