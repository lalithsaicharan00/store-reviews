package com.oftenenough.app.ui.components

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.ScrollState
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.gestures.detectTapGestures
import androidx.compose.foundation.horizontalScroll
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.wrapContentWidth
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberUpdatedState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.drawWithCache
import androidx.compose.ui.geometry.CornerRadius
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.RoundRect
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.clearAndSetSemantics
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.drawText
import androidx.compose.ui.text.rememberTextMeasurer
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HeatCell
import com.oftenenough.app.data.YearLayout
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.theme.appColors
import kotlin.math.floor

/*
 * Molecule 4.15, **Habit history card** (Figma 978:1598; Components — Atoms Build Plan): a habit's history over a
 * Week, a Month or a Year. Two places use it: Habits & Tasks (the Progress page: the habit's header, its summary and
 * squares; tap the card for Habit details) and Habit details › Progress (the Week and Month cards: the period's header
 * with ‹ ›, the summary, the squares, then Recorded each day and the comparison).
 *
 * The card is [HabitHistoryCard]; its parts, in Figma's order and each optional as Figma's properties are:
 * [HistoryHabitHeader] (Habit header), [HistoryPeriodHeader] (Period header), [HistorySummary], one of [HistoryWeek],
 * [HistoryMonth] or [HistoryYear] (Period), and [HistorySection]s (Daily chart, Comparison). Every square is the Day
 * cell atom (3.6), all of a card's squares in one Canvas (Rulebook S12), never a lazy grid (S13). A tap on a square
 * names its day ([onTap] gets its index, or null between squares); the screen decides what opens. No dot for a note
 * on any square (A60).
 */

/** The squares' sizes: Week and Month 36, 6 apart; Year 24, 4 apart. */
private val YearGap = 4.dp
private val CellGap = 6.dp

/**
 * The card: Surface container lowest, corners 24, 16 at the top, 20 at the start and bottom, 12 at the end, its parts
 * 12 apart. [onClick] (Habits & Tasks: open Habit details) makes the whole card a button.
 */
@Composable
fun HabitHistoryCard(modifier: Modifier = Modifier, onClick: (() -> Unit)? = null, onClickLabel: String? = null, content: @Composable ColumnScope.() -> Unit) {
    Column(
        modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(MaterialTheme.colorScheme.surfaceContainerLowest)
            .let { if (onClick != null) it.clickable(onClickLabel = onClickLabel, role = Role.Button, onClick = onClick) else it }
            .padding(start = 20.dp, top = 16.dp, end = 12.dp, bottom = 20.dp),
        verticalArrangement = Arrangement.spacedBy(12.dp),
        content = content,
    )
}

/**
 * Habits & Tasks' header (Figma's List item, Single, two lines, 72 tall): the habit's 40 dp avatar in its colour with
 * its glyph, 16, the [name] in Title Medium On surface over the [goal] in Body Medium On surface variant, one line each;
 * [trailing] at the end (Figma's ⋮, 24).
 */
@Composable
fun HistoryHabitHeader(symbol: String, color: HabitColor, name: String, goal: String, trailing: @Composable () -> Unit = {}) {
    val s = MaterialTheme.colorScheme
    Row(Modifier.fillMaxWidth().heightIn(min = 72.dp), horizontalArrangement = Arrangement.spacedBy(16.dp), verticalAlignment = Alignment.CenterVertically) {
        HabitIcon(symbol, color, 40.dp, CircleShape)
        Column(Modifier.weight(1f)) {
            Text(name, style = AppType.titleMedium, color = s.onSurface, maxLines = 1, overflow = TextOverflow.Ellipsis)
            Text(goal, style = AppType.bodyMedium, color = s.onSurfaceVariant, maxLines = 1, overflow = TextOverflow.Ellipsis)
        }
        trailing()
    }
}

/**
 * Habit details' header: the [title] ("Week") in Title Medium On surface over the [period] ("18–24 Oct · This week")
 * in Body Medium On surface variant, a heading; then ‹ and › (Icon buttons, 48), › off on the latest period.
 */
@Composable
fun HistoryPeriodHeader(title: String, period: String, noun: String, canGoBack: Boolean, canGoForward: Boolean, move: (Int) -> Unit) {
    val s = MaterialTheme.colorScheme
    Row(Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
        Column(Modifier.weight(1f).semantics(mergeDescendants = true) { heading() }) {
            Text(title, style = AppType.titleMedium, color = s.onSurface)
            Text(period, style = AppType.bodyMedium, color = s.onSurfaceVariant)
        }
        StandardIconButton(Symbols.KeyboardArrowLeft, "Previous $noun", { move(-1) },
            Modifier.semantics { testTag = "previous-$noun" }, enabled = canGoBack)
        StandardIconButton(Symbols.KeyboardArrowRight, "Next $noun", { move(1) },
            Modifier.semantics { testTag = "next-$noun" }, enabled = canGoForward)
    }
}

/** The summary ("Reached on 5 of 5 days so far") in Title Large Emphasized On surface, and its [detail] under it. */
@Composable
fun HistorySummary(summary: String, detail: String?) = HistorySummary(detail) {
    Text(summary, style = AppType.titleLargeEmphasized, color = MaterialTheme.colorScheme.onSurface)
}

/** The summary drawn by the screen (a quit habit's ticking run), with its [detail] under it, 2 apart. */
@Composable
fun HistorySummary(detail: String?, summary: @Composable () -> Unit) {
    Column(Modifier.fillMaxWidth(), verticalArrangement = Arrangement.spacedBy(2.dp)) {
        summary()
        detail?.let { Text(it, style = AppType.bodyMedium.copy(fontFeatureSettings = "tnum"), color = MaterialTheme.colorScheme.onSurfaceVariant) }
    }
}

/**
 * Week: the weekday [names] ("Sun" … "Sat", in the person's order) in Body Small On surface variant, today's in Label
 * Medium On surface; 8; the week's seven squares, 36 and 6 apart.
 */
@Composable
fun HistoryWeek(names: List<String>, cells: List<HeatCell>, todayIndex: Int?, color: HabitColor, modifier: Modifier = Modifier, onTap: ((Int?) -> Unit)? = null) {
    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
        DayNames(names, todayIndex)
        Squares(0, cells, todayIndex, color, null, modifier, onTap)
    }
}

/**
 * Month: the weekday letters ("S M T W T F S"), today's as Week's; 6; the month in rows of seven, 36 and 6 apart, its
 * first row starting after [lead] empty places (Figma's Empty), five rows or six. A week goal adds a column of its own
 * ([weekLabels]: "Met", "1 of 3" for each row), the squares then 32.
 */
@Composable
fun HistoryMonth(
    letters: List<String>, lead: Int, cells: List<HeatCell>, todayIndex: Int?, color: HabitColor, modifier: Modifier = Modifier,
    weekLabels: List<String>? = null, onTap: ((Int?) -> Unit)? = null,
) {
    val size = if (weekLabels != null) 32.dp else DayCellSize.week
    Column(verticalArrangement = Arrangement.spacedBy(6.dp)) {
        DayNames(letters + listOfNotNull(weekLabels?.let { "Week" }), todayIndex?.let { (lead + it) % 7 }, size)
        Squares(lead, cells, todayIndex, color, weekLabels, modifier, onTap, size)
    }
}

/**
 * Year: the weekday letters down the side (12 wide, Body Small, under a 16 row), 6, then the weeks as columns of 24
 * squares, 4 apart, each month's short name (Body Small On surface variant) over its first whole week. It scrolls
 * sideways and opens on the latest week; the letters stay put. Days before the habit began are Empty.
 */
@Composable
fun HistoryYear(layout: YearLayout, cells: List<HeatCell>, color: HabitColor, onTap: ((Int?) -> Unit)? = null) {
    val s = MaterialTheme.colorScheme
    val colors = dayCellColors(color)
    val measurer = rememberTextMeasurer()
    val labelStyle = AppType.bodySmall.copy(color = s.onSurfaceVariant)
    val square = DayCellSize.year
    val pitch = square + YearGap
    val ring = DayCellSize.ring
    val labels = 16.dp + YearGap
    val columns = maxOf(layout.columns, 1)
    // Room after the last column for a month name that starts there.
    val width = ring * 2 + pitch * columns - YearGap + 24.dp
    val height = labels + ring * 2 + pitch * 7 - YearGap
    // Another year opens again on its latest weeks: the scroll starts past the end and is kept within its range.
    val scroll = remember(layout) { ScrollState(Int.MAX_VALUE) }
    val names = remember(layout, measurer, labelStyle) { layout.months.map { it.column to measurer.measure(it.name, labelStyle) } }
    val tap by rememberUpdatedState(onTap)
    Row(verticalAlignment = Alignment.Top, horizontalArrangement = Arrangement.spacedBy(6.dp)) {
        Column(Modifier.padding(top = labels + ring).width(12.dp), verticalArrangement = Arrangement.spacedBy(YearGap)) {
            for (row in 0 until 7) {
                val isToday = row == layout.todayRow
                Box(Modifier.size(12.dp, square), contentAlignment = Alignment.CenterStart) {
                    Text(layout.letters.getOrElse(row) { "" }, style = if (isToday) AppType.labelMedium else AppType.bodySmall,
                        color = if (isToday) s.onSurface else s.onSurfaceVariant, maxLines = 1, softWrap = false)
                }
            }
        }
        Box(Modifier.weight(1f).horizontalScroll(scroll)) {
            Canvas(
                Modifier.size(width, height)
                    .let { m ->
                        if (onTap == null) m else m.pointerInput(layout) {
                            detectTapGestures { at ->
                                val pad = ring.toPx()
                                val step = pitch.toPx()
                                val top = labels.toPx() + pad
                                val column = ((at.x - pad) / step).toInt()
                                val row = ((at.y - top) / step).toInt()
                                val index = column * 7 + row - layout.lead
                                tap?.invoke(if (at.x >= pad && at.y >= top && row in 0..6 && index in 0 until layout.shown) index else null)
                            }
                        }
                    },
            ) {
                val pad = ring.toPx()
                val sq = square.toPx()
                val step = pitch.toPx()
                val top = labels.toPx() + pad
                for ((column, name) in names) drawText(name, topLeft = Offset(pad + column * step, 0f))
                val draw = DayCellDraw(sq, 1.dp.toPx())
                val todayPlace = if (layout.todayRow == null) -1 else layout.lead + layout.shown - 1
                for (i in 0 until minOf(layout.shown, cells.size)) {
                    val place = layout.lead + i
                    draw.add(cells[i], pad + (place / 7) * step, top + (place % 7) * step, place == todayPlace)
                }
                draw.draw(this, colors)
            }
        }
    }
}

/**
 * A part under the squares (Figma's Daily chart, Comparison): a divider in Outline variant, then the [heading] in
 * Label Large On surface, then its content, 12 apart.
 */
@Composable
fun HistorySection(heading: String, modifier: Modifier = Modifier, content: @Composable ColumnScope.() -> Unit) {
    Column(modifier.fillMaxWidth(), verticalArrangement = Arrangement.spacedBy(12.dp)) {
        HorizontalDivider(color = MaterialTheme.colorScheme.outlineVariant)
        Text(heading, style = AppType.labelLarge, color = MaterialTheme.colorScheme.onSurface)
        content()
    }
}

/** The weekday names, each centred over its 36 dp column, 6 apart; today's in Label Medium On surface. */
@Composable
private fun DayNames(names: List<String>, todayColumn: Int?, column: Dp = DayCellSize.week) {
    val s = MaterialTheme.colorScheme
    Row(Modifier.padding(horizontal = DayCellSize.ring).clearAndSetSemantics { }, horizontalArrangement = Arrangement.spacedBy(CellGap)) {
        names.forEachIndexed { i, name ->
            val isToday = i == todayColumn
            Box(Modifier.width(if (i < 7) column else 40.dp), contentAlignment = Alignment.Center) {
                Text(name, Modifier.wrapContentWidth(unbounded = true), style = if (isToday) AppType.labelMedium else AppType.bodySmall,
                    color = if (isToday) s.onSurface else s.onSurfaceVariant, textAlign = TextAlign.Center, maxLines = 1, softWrap = false)
            }
        }
    }
}

/** Rows of seven squares ([size], 6 apart both ways) after [lead] empty places, and a week's column; one Canvas. */
@Composable
private fun Squares(
    lead: Int, cells: List<HeatCell>, todayIndex: Int?, color: HabitColor, weekLabels: List<String>?, modifier: Modifier,
    onTap: ((Int?) -> Unit)?, size: Dp = DayCellSize.week,
) {
    val s = MaterialTheme.colorScheme
    val colors = dayCellColors(color)
    val measurer = rememberTextMeasurer()
    val weekTexts = remember(measurer, weekLabels) { weekLabels?.map { measurer.measure(it, AppType.labelMedium) } }
    val rows = (lead + cells.size + 6) / 7
    val ring = DayCellSize.ring
    val pitch = size + CellGap
    val width = ring * 2 + pitch * 7 - CellGap + (if (weekLabels != null) CellGap + 40.dp else 0.dp)
    val height = ring * 2 + pitch * rows - CellGap
    val tap by rememberUpdatedState(onTap)
    val ink = s.onSurface
    Canvas(
        modifier.size(width, height)
            .let { m ->
                if (onTap == null) m else m.pointerInput(lead, cells.size, size) {
                    detectTapGestures { at ->
                        val step = pitch.toPx()
                        val column = floor((at.x - ring.toPx()) / step).toInt()
                        val row = floor((at.y - ring.toPx()) / step).toInt()
                        val i = row * 7 + column - lead
                        tap?.invoke(if (column in 0..6 && row >= 0 && i in cells.indices) i else null)
                    }
                }
            },
    ) {
        val pad = ring.toPx()
        val sq = size.toPx()
        val step = pitch.toPx()
        val draw = DayCellDraw(sq, 1.dp.toPx())
        cells.forEachIndexed { i, cell ->
            val place = lead + i
            draw.add(cell, pad + (place % 7) * step, pad + (place / 7) * step, i == todayIndex)
        }
        draw.draw(this, colors)
        weekTexts?.forEachIndexed { r, t ->
            val x = pad + 7 * step + 20.dp.toPx() - t.size.width / 2f
            drawText(t, color = ink, topLeft = Offset(x, pad + r * step + sq / 2 - t.size.height / 2f))
        }
    }
}

/**
 * Figma's Daily chart ("Recorded each day"), under its [HistorySection]: one bar a day in the habit's Colour, top
 * corners 2, two thirds of its slot, from the baseline; a bar's height is the day's value ÷ the [goal] × 96 (at most
 * 120). Lines in Outline variant at the goal, at half of it and at the baseline; the goal's and the half's amounts in
 * the habit's own words ([label]: "8 glasses", "5 min") in Label Small On surface variant at the end, 6 from the
 * bars; under them the 1st and today's day ([todayIndex]). With no daily goal the most in a day takes its place. One
 * Canvas, worked out when the values change (S12); TalkBack reads [description].
 */
@Composable
fun HistoryDailyChart(values: List<Double>, goal: Double?, todayIndex: Int?, color: HabitColor, label: (Double) -> String, description: String, modifier: Modifier = Modifier) {
    val s = MaterialTheme.colorScheme
    val c = appColors
    val bar = c.habit(color)
    val line = s.outlineVariant
    val measurer = rememberTextMeasurer()
    val style = AppType.labelSmall.copy(color = s.onSurfaceVariant)
    val reference = (goal?.takeIf { it > 0 } ?: values.maxOrNull() ?: 0.0).coerceAtLeast(1e-9)
    val texts = remember(measurer, style, reference, values.size, todayIndex) {
        Triple(measurer.measure(label(reference), style), measurer.measure(label(reference / 2), style),
            listOfNotNull(0 to measurer.measure("1", style), todayIndex?.takeIf { it > 0 }?.let { it to measurer.measure("${it + 1}", style) }))
    }
    Spacer(
        modifier.fillMaxWidth().height(136.dp)
            .semantics { contentDescription = description }
            .drawWithCache {
                val (top, half, days) = texts
                val plot = 120.dp.toPx()
                val gutter = maxOf(top.size.width, half.size.width) + 6.dp.toPx()
                val width = (size.width - gutter).coerceAtLeast(1f)
                val slot = width / maxOf(values.size, 1)
                val thick = slot * 2f / 3f
                val unit = 96.dp.toPx() / reference.toFloat()
                val radius = CornerRadius(2.dp.toPx())
                val bars = Path()
                values.forEachIndexed { i, v ->
                    if (v <= 0 || !v.isFinite()) return@forEachIndexed
                    val h = minOf(plot, v.toFloat() * unit)
                    val left = i * slot + (slot - thick) / 2
                    bars.addRoundRect(RoundRect(left, plot - h, left + thick, plot, radius, radius,
                        CornerRadius.Zero, CornerRadius.Zero))
                }
                val stroke = 1.dp.toPx()
                val goalY = plot - 96.dp.toPx()
                val halfY = plot - 48.dp.toPx()
                onDrawBehind {
                    for (y in listOf(goalY, halfY, plot)) drawRect(line, Offset(0f, y - stroke / 2), Size(width, stroke))
                    drawPath(bars, bar)
                    drawText(top, topLeft = Offset(width + 6.dp.toPx(), goalY - top.size.height / 2f))
                    drawText(half, topLeft = Offset(width + 6.dp.toPx(), halfY - half.size.height / 2f))
                    for ((i, t) in days) {
                        val x = if (i == 0) (slot - thick) / 2 else (i + 0.5f) * slot - t.size.width / 2f
                        drawText(t, topLeft = Offset(x, plot + 4.dp.toPx()))
                    }
                }
            },
    )
}
