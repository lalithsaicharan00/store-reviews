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
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.semantics.clearAndSetSemantics
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.stateDescription
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HeatCell
import com.oftenenough.app.ui.theme.appColors

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
