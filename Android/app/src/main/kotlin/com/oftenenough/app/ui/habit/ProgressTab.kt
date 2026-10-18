package com.oftenenough.app.ui.habit

import com.oftenenough.app.ui.theme.AppType

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.horizontalScroll
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.IntrinsicSize
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyListScope
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.ArrowBack
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowLeft
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowRight
import androidx.compose.material.icons.rounded.Add
import androidx.compose.material.icons.rounded.Check
import androidx.compose.material.icons.rounded.LocalFireDepartment
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.IconButtonDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableLongStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.semantics.clearAndSetSemantics
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.SpanStyle
import androidx.compose.ui.text.buildAnnotatedString
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextDecoration
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.text.withStyle
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Format
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitMilestones
import com.oftenenough.app.data.HabitOverall
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.HeatCell
import com.oftenenough.app.data.Milestone
import com.oftenenough.app.data.MilestoneNext
import com.oftenenough.app.data.PeriodCard
import com.oftenenough.app.data.PeriodComparison
import com.oftenenough.app.data.PeriodKind
import com.oftenenough.app.data.ProgressRange
import com.oftenenough.app.data.QuitRun
import com.oftenenough.app.data.RecordFact
import com.oftenenough.app.data.dayResult
import com.oftenenough.app.data.moneySaved
import com.oftenenough.app.data.pageDay
import com.oftenenough.app.data.pageMonthCaption
import com.oftenenough.app.data.pageMonthLead
import com.oftenenough.app.data.pageMonthLength
import com.oftenenough.app.data.pageMonthShort
import com.oftenenough.app.data.pageMonthTitle
import com.oftenenough.app.data.pageWeekCaption
import com.oftenenough.app.data.pageWeekTitle
import com.oftenenough.app.data.pageWeekdayLetters
import com.oftenenough.app.data.pageWeekdayNames
import com.oftenenough.app.data.pageYear
import com.oftenenough.app.data.periodCard
import com.oftenenough.app.data.periodComparison
import com.oftenenough.app.data.quitClock
import com.oftenenough.app.data.quitPeriodCard
import com.oftenenough.app.data.quitTotalLine
import com.oftenenough.app.data.recordedEachDay
import com.oftenenough.app.ui.charts.LightBarChart
import com.oftenenough.app.ui.components.CookieShape
import com.oftenenough.app.ui.components.TonalButton
import com.oftenenough.app.ui.theme.appColors
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.Locale
import kotlinx.coroutines.delay

// Habit details' Progress tab (the iPhone's HabitProgressTab.swift, HabitPagePhase2.swift): the key, then one card each
// for the Overall record, Milestones, Week, Month and Year in Pixels. Facts are recorded data and plain counts with their
// denominators (no scores or predictions). Every card works its numbers out when its period or the habit's data change
// (a `remember` keyed on the habit's revision), never while drawing (S5, S8); the only thing that ticks is a quit habit's
// live run, in its own small Text (S3).

private val selectedDayFormat = DateTimeFormatter.ofPattern("EEEE d MMMM", Locale.ENGLISH)

/** The Progress tab's items. [record] and [milestones] come from the page's model (null for a quit habit's record). */
internal fun LazyListScope.progressItems(
    habit: Habit, store: HabitStore, today: Int, revision: Int, record: HabitOverall?, milestones: HabitMilestones,
    showStreaks: Boolean, showPercentages: Boolean, keyOpen: Boolean, onToggleKey: () -> Unit, onSeeAll: () -> Unit,
    onOpenDay: (Int) -> Unit, onAddSlip: () -> Unit,
) {
    item(key = "progress-key") { HeatKeyCard(keyOpen, onToggleKey, Modifier.pageItem()) }
    if (habit.kind == HabitKind.Quit) {
        item(key = "progress-quit-record") { QuitRecordCard(habit, store, revision, onAddSlip) }
    } else if (record != null) {
        item(key = "progress-record") { RecordCard(record, habit.color, showStreaks, showPercentages) }
    }
    val shown = milestones.shown(showStreaks)
    if (shown.next.isNotEmpty()) item(key = "progress-milestones") { MilestonesCard(shown, habit.color, onSeeAll) }
    item(key = "progress-week") { PeriodCardView(habit, store, week = true, today = today, revision = revision) }
    item(key = "progress-month") { PeriodCardView(habit, store, week = false, today = today, revision = revision) }
    item(key = "progress-year") { YearCard(habit, store, today, revision, onOpenDay) }
}

/** A white card on the page (corners 24, 16 dp inside). */
@Composable
private fun PageCard(tag: String, content: @Composable ColumnScope.() -> Unit) {
    Column(
        Modifier.pageItem().fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(appColors.surface).padding(16.dp)
            .semantics { testTag = tag },
        verticalArrangement = Arrangement.spacedBy(16.dp),
        content = content,
    )
}

// ------------------------------------------------------------------------------------------------ Overall record

@Composable
private fun RecordCard(record: HabitOverall, color: HabitColor, showStreaks: Boolean, showPercentages: Boolean) {
    val c = appColors
    val oneColumn = LocalDensity.current.fontScale >= 1.5f
    PageCard("habit-progress-record") {
        Row(Modifier.fillMaxWidth().semantics(mergeDescendants = true) { heading() }, verticalAlignment = Alignment.CenterVertically) {
            Text("Overall record", Modifier.weight(1f), style = MaterialTheme.typography.titleLarge, color = c.ink)
            Spacer(Modifier.width(8.dp))
            Text(record.since, style = MaterialTheme.typography.bodyMedium, color = c.secondary, maxLines = 1)
        }
        val headline = remember(record, c) {
            buildAnnotatedString {
                if (record.lead.isNotEmpty()) { withStyle(AppType.bodyLarge.toSpanStyle().copy(color = c.secondary)) { append(record.lead + " ") } }
                withStyle(AppType.displayMedium.toSpanStyle().copy(color = c.ink)) { append(record.value) }
                if (record.trail.isNotEmpty()) { withStyle(AppType.bodyLarge.toSpanStyle().copy(color = c.secondary)) { append(" " + record.trail) } }
            }
        }
        Text(headline, Modifier.clearAndSetSemantics { contentDescription = record.headline; testTag = "habit-record-headline" })
        val boxes = ArrayList<RecordBoxData>()
        val current = record.current
        val best = record.best
        if (showStreaks && current != null && best != null) {
            boxes.add(RecordBoxData("habit-streak-current", current, current.detail, current.spoken, true))
            boxes.add(RecordBoxData("habit-streak-best", best, best.detail, best.spoken, false))
        }
        record.goalMet?.let { goal ->
            // The percentage follows Progress's "Show percentages".
            val percent = if (showPercentages && record.eligible > 0) Math.round(record.met.toDouble() / record.eligible * 100).toInt() else null
            boxes.add(RecordBoxData("habit-record-goal-met", goal, percent?.let { "$it% ${record.percentNoun}" },
                goal.spoken + (percent?.let { ", $it percent ${record.percentNoun}" } ?: ""), false))
        }
        record.bestPeriod?.let { boxes.add(RecordBoxData("habit-record-best-period", it, it.detail, it.spoken, false)) }
        if (boxes.isNotEmpty()) {
            Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                for (row in boxes.chunked(if (oneColumn) 1 else 2)) {
                    Row(Modifier.fillMaxWidth().height(IntrinsicSize.Min), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                        for (box in row) RecordBox(box, color, Modifier.weight(1f).fillMaxHeight())
                    }
                }
            }
        }
    }
}

private class RecordBoxData(val tag: String, val fact: RecordFact, val detail: String?, val spoken: String, val tinted: Boolean)

/** One box: its label, the number with its unit, and a line under it. Current streak is tinted with the habit's colour
 *  and has Today's flame. */
@Composable
private fun RecordBox(box: RecordBoxData, color: HabitColor, modifier: Modifier) {
    val c = appColors
    Column(
        modifier.clip(RoundedCornerShape(20.dp)).background(if (box.tinted) c.fill(color) else c.tonal2).padding(16.dp)
            .clearAndSetSemantics { contentDescription = box.spoken; testTag = box.tag },
        verticalArrangement = Arrangement.spacedBy(4.dp),
    ) {
        Text(box.fact.title, style = MaterialTheme.typography.bodyMedium, color = c.secondary)
        Row(verticalAlignment = Alignment.CenterVertically) {
            if (box.tinted) {
                Icon(Icons.Rounded.LocalFireDepartment, null, Modifier.size(24.dp), tint = c.flame)
                Spacer(Modifier.width(6.dp))
            }
            Text(
                buildAnnotatedString {
                    withStyle(AppType.headlineSmallEmphasized.toSpanStyle().copy(color = c.ink)) { append(box.fact.number) }
                    if (box.fact.unit.isNotEmpty()) withStyle(AppType.bodyLarge.toSpanStyle().copy(color = c.ink)) { append(" " + box.fact.unit) }
                },
            )
        }
        if (box.detail != null) Text(box.detail, style = MaterialTheme.typography.bodySmall, color = c.secondary)
    }
}

/** A quit habit's Overall record: the run going on now (ticking in its own Text), the best run, a total a slip can't take
 *  away, Add slip, and the money saved when a cost is set. */
@Composable
private fun QuitRecordCard(habit: Habit, store: HabitStore, revision: Int, onAddSlip: () -> Unit) {
    val c = appColors
    val numbers = remember(habit, revision) {
        val now = store.clock()
        val history = store.rules.quitHistory(habit, now)
        val current = history.lastOrNull()?.takeIf { it.ending == QuitRun.Ending.ONGOING }
        val best = history.maxOfOrNull { it.seconds(now) } ?: 0.0
        QuitNumbers(current?.start, best, store.quitTotalLine(habit, now), store.moneySaved(habit, now),
            "Tracking since " + DayWords.long(store.rules.quitStartDay(habit)))
    }
    PageCard("habit-progress-record") {
        Column(Modifier.semantics(mergeDescendants = true) { heading() }) {
            Text("Overall record", style = MaterialTheme.typography.titleLarge, color = c.ink)
            Text(numbers.since, style = MaterialTheme.typography.bodyMedium, color = c.secondary)
        }
        Column(verticalArrangement = Arrangement.spacedBy(4.dp)) {
            val start = numbers.runStart
            if (start != null) QuitClockText(start, store.clock)
            else Text("Paused", style = MaterialTheme.typography.headlineSmall, color = c.ink)
            Text((if (start == null) "" else "This run · ") + "best " + Format.days(numbers.best),
                style = MaterialTheme.typography.bodyMedium, color = c.secondary)
            Text(numbers.total, Modifier.semantics { testTag = "quit-total-line" }, style = MaterialTheme.typography.bodyMedium, color = c.secondary)
        }
        TonalButton("Add slip", onAddSlip, Modifier.semantics { testTag = "habit-log-slip" }, icon = Icons.Rounded.Add)
        numbers.saved?.let { Text(it, Modifier.semantics { testTag = "quit-money-saved" }, style = MaterialTheme.typography.labelLarge, color = c.ink) }
    }
}

private class QuitNumbers(val runStart: Long?, val best: Double, val total: String, val saved: String?, val since: String)

/** The live run, ticking each second in this Text only, from the run's start (Rulebook S3, S4). */
@Composable
private fun QuitClockText(start: Long, clock: () -> Long) {
    var now by remember { mutableLongStateOf(clock()) }
    LaunchedEffect(start) {
        while (true) {
            now = clock()
            delay((1000 - (now - start) % 1000).coerceIn(50, 1000))
        }
    }
    Text(quitClock((now - start) / 1000.0), Modifier.semantics { contentDescription = "This run, " + quitClock((now - start) / 1000.0) },
        style = MaterialTheme.typography.headlineSmall, color = appColors.ink, maxLines = 1)
}

// ------------------------------------------------------------------------------------------------ Milestones

/** Milestones as awards: the newest on a plate, the rest on a shelf, and the one thing to aim for next on each track. */
@Composable
private fun MilestonesCard(milestones: HabitMilestones, color: HabitColor, onSeeAll: () -> Unit) {
    val c = appColors
    val reached = milestones.reached
    PageCard("habit-milestones") {
        Row(Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
            Text("Milestones", Modifier.weight(1f).semantics { heading() }, style = MaterialTheme.typography.titleLarge, color = c.ink)
            if (reached.size >= 2) {
                Row(
                    Modifier.clip(RoundedCornerShape(20.dp)).clickable(onClick = onSeeAll).heightIn(min = 48.dp).padding(horizontal = 8.dp)
                        .clearAndSetSemantics { contentDescription = "See all ${reached.size} milestones"; testTag = "habit-milestones-see-all" },
                    verticalAlignment = Alignment.CenterVertically,
                ) {
                    Text("See all ${reached.size}", style = MaterialTheme.typography.labelLarge, color = c.ink)
                    Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = c.ink)
                }
            } else if (reached.size == 1) {
                Text("1 reached", style = MaterialTheme.typography.bodyMedium, color = c.secondary)
            }
        }
        reached.firstOrNull()?.let { latest ->
            Row(
                Modifier.fillMaxWidth().clip(RoundedCornerShape(20.dp)).background(c.fill(color)).padding(16.dp)
                    .clearAndSetSemantics {
                        contentDescription = (if (reached.size > 1) "Latest: " else "") + latest.spoken
                        testTag = "habit-milestone-latest"
                    },
                verticalAlignment = Alignment.CenterVertically,
            ) {
                MilestoneMedal(latest.number, 64.dp, color)
                Spacer(Modifier.width(16.dp))
                Column {
                    if (reached.size > 1) Text("Latest", style = MaterialTheme.typography.labelMedium, color = c.secondary)
                    Text(latest.title, style = MaterialTheme.typography.titleMedium, color = c.ink)
                    Text(latest.reachedText, style = MaterialTheme.typography.bodyMedium, color = c.secondary)
                }
            }
        }
        if (reached.size > 1) {
            Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                Text("Earlier", style = MaterialTheme.typography.labelMedium, color = c.secondary)
                Row(Modifier.fillMaxWidth().horizontalScroll(rememberScrollState()).semantics { testTag = "habit-milestone-shelf" },
                    horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    for (m in reached.drop(1)) ShelfMedal(m, color)
                }
            }
        }
        Column(verticalArrangement = Arrangement.spacedBy(12.dp)) {
            Text("Next", style = MaterialTheme.typography.labelMedium, color = c.secondary)
            for (next in milestones.next) MilestoneNextRow(next, color, onPage = false)
        }
    }
}

@Composable
private fun ShelfMedal(m: Milestone, color: HabitColor) {
    val c = appColors
    Column(Modifier.width(72.dp).clearAndSetSemantics { contentDescription = m.spoken }, horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.spacedBy(6.dp)) {
        MilestoneMedal(m.number, 44.dp, color)
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            Text(m.shelfTop, style = MaterialTheme.typography.labelSmall, color = c.ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
            Text(m.shelfBottom, style = MaterialTheme.typography.labelSmall.copy(fontWeight = FontWeight.Normal), color = c.secondary,
                maxLines = 1, overflow = TextOverflow.Ellipsis)
        }
    }
}

/** A milestone reached: the habit's colour in the Expressive cookie, the number in white. Nothing else looks like one. */
@Composable
private fun MilestoneMedal(number: String, size: Dp, color: HabitColor) {
    val share = if (number.length >= 4) 0.26f else if (number.length == 3) 0.32f else 0.4f
    val fontSize = with(LocalDensity.current) { (size * share).toSp() }
    Box(Modifier.size(size).clip(CookieShape()).background(appColors.habit(color)), contentAlignment = Alignment.Center) {
        Text(number, color = Color.White, fontSize = fontSize, fontWeight = FontWeight.Medium, fontFamily = AppType.labelLarge.fontFamily, maxLines = 1)
    }
}

/** A track's next milestone: a ring filling clockwise from the top (current ÷ target), the target inside, and what's left. */
@Composable
private fun MilestoneNextRow(next: MilestoneNext, color: HabitColor, onPage: Boolean) {
    val c = appColors
    val ring = c.habit(color)
    val track = c.tonal
    Row(Modifier.fillMaxWidth().clearAndSetSemantics { contentDescription = next.spoken; testTag = "habit-milestone-next-" + next.track.key },
        verticalAlignment = Alignment.CenterVertically) {
        Box(Modifier.size(48.dp), contentAlignment = Alignment.Center) {
            Canvas(Modifier.size(48.dp)) {
                val w = 5.dp.toPx()
                val inset = w / 2
                val arc = Size(size.width - w, size.height - w)
                drawArc(track, 0f, 360f, false, Offset(inset, inset), arc, style = Stroke(w))
                if (next.fraction > 0) drawArc(ring, -90f, 360f * next.fraction.toFloat(), false, Offset(inset, inset), arc, style = Stroke(w, cap = StrokeCap.Round))
            }
            if (next.target == null) Icon(Icons.Rounded.Check, null, tint = c.ink)
            else Text(next.number, color = c.ink, style = if (next.number.length >= 3) AppType.labelMedium else AppType.titleMedium, maxLines = 1)
        }
        Spacer(Modifier.width(16.dp))
        Column(Modifier.weight(1f)) {
            Text(if (onPage) next.pageTitle else next.title, style = MaterialTheme.typography.bodyLarge, color = c.ink)
            next.detail?.let { Text(it, style = MaterialTheme.typography.bodyMedium, color = c.secondary) }
        }
    }
}

/** All milestones, from "See all N ›": one card per track with its Next row and every medal reached, newest first. */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
internal fun AllMilestonesPage(milestones: HabitMilestones, color: HabitColor, onBack: () -> Unit) {
    BackHandler(onBack = onBack)
    val c = appColors
    val columns = if (LocalDensity.current.fontScale >= 1.5f) 2 else 3
    Column(Modifier.fillMaxSize().background(c.screen).semantics { testTag = "all-milestones" }) {
        TopAppBar(
            title = { Text("Milestones", maxLines = 1) },
            navigationIcon = { IconButton(onBack, Modifier.semantics { testTag = "milestones-back" }) { Icon(Icons.AutoMirrored.Rounded.ArrowBack, "Back") } },
            colors = TopAppBarDefaults.topAppBarColors(containerColor = c.screen, titleContentColor = c.ink, navigationIconContentColor = c.ink),
        )
        LazyColumn(Modifier.fillMaxWidth().weight(1f)) {
            items(milestones.next, key = { it.track.key }) { next ->
                val reached = milestones.reached.filter { it.track == next.track }
                PageCard("all-milestones-" + next.track.key) {
                    Row(Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
                        Text(trackTitle(next.track), Modifier.weight(1f).semantics { heading() }, style = MaterialTheme.typography.titleLarge, color = c.ink)
                        Text("${reached.size} reached", style = MaterialTheme.typography.bodyMedium, color = c.secondary)
                    }
                    MilestoneNextRow(next, color, onPage = true)
                    if (reached.isNotEmpty()) {
                        HorizontalDivider(color = c.tonal)
                        for (row in reached.chunked(columns)) {
                            Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                                for (m in row) {
                                    Column(Modifier.weight(1f).clearAndSetSemantics { contentDescription = m.spoken },
                                        horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(6.dp)) {
                                        MilestoneMedal(m.number, 56.dp, color)
                                        Text(m.pageCaption, style = MaterialTheme.typography.labelLarge, color = c.ink, textAlign = TextAlign.Center)
                                        Text(m.pageDate, style = MaterialTheme.typography.bodySmall, color = c.secondary, textAlign = TextAlign.Center)
                                    }
                                }
                                repeat(columns - row.size) { Spacer(Modifier.weight(1f)) }
                            }
                        }
                    }
                }
            }
            item(key = "all-milestones-note") {
                Text("Milestones you reach stay here, even when a run starts again.",
                    Modifier.padding(horizontal = 32.dp).padding(bottom = 24.dp).navigationBarsPadding(),
                    style = MaterialTheme.typography.bodySmall, color = c.secondary)
            }
        }
    }
}

private fun trackTitle(track: Milestone.Track): String = when (track) {
    Milestone.Track.IN_A_ROW -> "In a row"
    Milestone.Track.IN_TOTAL -> "In total"
    Milestone.Track.SINCE_SLIP -> "Since a slip"
}

// ------------------------------------------------------------------------------------------------ Week and Month

/** A Week or Month card's numbers, worked out when its period or the data change. */
private class PeriodView(
    val span: IntRange, val subtitle: String, val card: PeriodCard?, val comparison: PeriodComparison?, val lead: Int,
    val bars: Pair<List<Double>, Double?>?, val canGoBack: Boolean, val canGoForward: Boolean, val todayIndex: Int?,
)

private fun periodView(store: HabitStore, habit: Habit, week: Boolean, anchor: Int?, today: Int): PeriodView {
    val day = minOf(anchor ?: today, today)
    val span = store.rules.period(if (week) PeriodKind.WEEK else PeriodKind.MONTH, day)
    val range = if (week) ProgressRange.WEEK else ProgressRange.MONTH
    val quit = habit.kind == HabitKind.Quit
    val card = if (quit) store.quitPeriodCard(habit, span, range, today) else store.periodCard(habit, span, range, today)
    val title = if (week) pageWeekTitle(span.first, span.last, today) else pageMonthTitle(span.first, today)
    val caption = if (week) pageWeekCaption(span, today) else pageMonthCaption(span, today)
    val first = if (quit) store.rules.quitStartDay(habit) else store.rules.startDay(habit)
    return PeriodView(
        span = span,
        subtitle = title + (caption?.let { " · $it" } ?: ""),
        card = card,
        comparison = store.periodComparison(habit, span, week, today),
        lead = pageMonthLead(span.first, store.weekStart),
        bars = if (week) null else store.recordedEachDay(habit, span, today),
        canGoBack = span.first > first,
        canGoForward = span.last < today,
        todayIndex = if (today in span) today - span.first else null,
    )
}

/** The Week or Month card: its dates with ‹ ›, what was recorded on the goal's own clock, the squares, the amount
 *  recorded each day (Month), and the period against the one before. */
@Composable
private fun PeriodCardView(habit: Habit, store: HabitStore, week: Boolean, today: Int, revision: Int) {
    val c = appColors
    var anchor by rememberSaveable(habit.id, week) { mutableStateOf<Int?>(null) }
    val view = remember(habit, revision, today, anchor, store.weekStart) { periodView(store, habit, week, anchor, today) }
    val noun = if (week) "week" else "month"
    PageCard(if (week) "habit-progress-week" else "habit-progress-month") {
        PeriodHeader(if (week) "Week" else "Month", view.subtitle, noun, view.canGoBack, view.canGoForward) { step ->
            val next = if (step < 0) view.span.first - 1 else view.span.last + 1
            anchor = if (next >= today || store.rules.period(if (week) PeriodKind.WEEK else PeriodKind.MONTH, next).contains(today)) null else next
        }
        val card = view.card
        if (card != null) {
            Column(verticalArrangement = Arrangement.spacedBy(4.dp)) {
                Text(card.headline, style = MaterialTheme.typography.titleLarge, color = c.ink)
                card.detail?.let { Text(it, style = MaterialTheme.typography.bodyMedium, color = c.secondary) }
            }
            if (card.days.size == view.span.last - view.span.first + 1) {
                val cells = remember(card) { card.days.map { it.heat } }
                if (week) {
                    Column(verticalArrangement = Arrangement.spacedBy(6.dp)) {
                        DayNames(pageWeekdayNames(store.weekStart), view.todayIndex)
                        HeatStrip(cells, view.todayIndex, habit.color, HeatSize.week)
                    }
                } else {
                    Column(verticalArrangement = Arrangement.spacedBy(6.dp)) {
                        DayNames(pageWeekdayLetters(store.weekStart), view.todayIndex?.let { (view.lead + it) % 7 })
                        HeatMonthGrid(view.lead, cells, view.todayIndex, habit.color)
                    }
                }
            }
            val bars = view.bars
            if (bars != null) {
                Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                    Text("Recorded each day", style = MaterialTheme.typography.titleSmall, color = c.ink)
                    val labels = remember(bars) { bars.first.indices.map { i -> if (i % 7 == 0) "${i + 1}" else "" } }
                    LightBarChart(
                        values = bars.first,
                        color = c.habit(habit.color),
                        description = "Recorded each day in " + pageMonthTitle(view.span.first, today) + (card.detail?.let { ": $it" } ?: ""),
                        modifier = Modifier.fillMaxWidth().height(140.dp).semantics { testTag = "habit-month-chart" },
                        goal = bars.second,
                        labels = labels,
                    )
                }
            }
        } else {
            Text(if (habit.kind == HabitKind.Quit) "Nothing recorded this $noun." else "Not started yet this $noun.",
                style = MaterialTheme.typography.bodyMedium, color = c.secondary)
        }
        view.comparison?.let { comparison ->
            HorizontalDivider(color = c.tonal)
            ComparisonView(comparison, habit.color)
        }
    }
}

/** The weekday names (or letters) over the squares; today's is bold and underlined. */
@Composable
private fun DayNames(names: List<String>, todayColumn: Int?) {
    Row(Modifier.fillMaxWidth().clearAndSetSemantics { }) {
        names.forEachIndexed { i, name ->
            val isToday = i == todayColumn
            Text(name, Modifier.weight(1f), style = MaterialTheme.typography.labelMedium.copy(
                fontWeight = if (isToday) FontWeight.Medium else FontWeight.Normal,
                textDecoration = if (isToday) TextDecoration.Underline else null,
            ), color = if (isToday) appColors.ink else appColors.secondary, textAlign = TextAlign.Center, maxLines = 1)
        }
    }
}

/** A card's title and scope, with ‹ › for the period before and after. */
@Composable
private fun PeriodHeader(title: String, subtitle: String, noun: String, canGoBack: Boolean, canGoForward: Boolean, move: (Int) -> Unit) {
    val c = appColors
    val colors = IconButtonDefaults.iconButtonColors(contentColor = c.ink, disabledContentColor = c.secondary.copy(alpha = 0.4f))
    Row(Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
        Column(Modifier.weight(1f).semantics(mergeDescendants = true) { heading() }) {
            Text(title, style = MaterialTheme.typography.titleLarge, color = c.ink)
            Text(subtitle, style = MaterialTheme.typography.bodyMedium, color = c.secondary)
        }
        IconButton({ move(-1) }, Modifier.semantics { testTag = "previous-$noun" }, enabled = canGoBack, colors = colors) {
            Icon(Icons.AutoMirrored.Rounded.KeyboardArrowLeft, "Previous $noun")
        }
        IconButton({ move(1) }, Modifier.semantics { testTag = "next-$noun" }, enabled = canGoForward, colors = colors) {
            Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, "Next $noun")
        }
    }
}

/** This period and the one before, as two labelled bars with exact values: the habit's colour for this period, a lighter
 *  step for the one before; no arrows, no better or worse. */
@Composable
private fun ComparisonView(comparison: PeriodComparison, color: HabitColor) {
    val c = appColors
    Column(Modifier.semantics(mergeDescendants = true) { testTag = "habit-comparison" }, verticalArrangement = Arrangement.spacedBy(8.dp)) {
        Text(comparison.title, style = MaterialTheme.typography.titleSmall, color = c.ink)
        val note = comparison.note
        if (note != null) {
            Text(note, style = MaterialTheme.typography.bodyMedium, color = c.secondary)
        } else {
            val top = maxOf(comparison.thisValue ?: 0.0, comparison.previousValue ?: 0.0, 0.0001)
            ComparisonRow(comparison.thisLabel, comparison.thisText, (comparison.thisValue ?: 0.0) / top, c.habit(color))
            ComparisonRow(comparison.previousLabel, comparison.previousText, (comparison.previousValue ?: 0.0) / top, HeatPalette.color(2, color, c.dark))
        }
    }
}

@Composable
private fun ComparisonRow(label: String, text: String, fraction: Double, fill: Color) {
    val c = appColors
    Row(Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(8.dp)) {
        Text(label, Modifier.width(92.dp), style = MaterialTheme.typography.bodyMedium, color = c.secondary, maxLines = 1, overflow = TextOverflow.Ellipsis)
        Box(Modifier.weight(1f).height(10.dp).clip(CircleShape).background(c.tonal)) {
            Box(Modifier.fillMaxHeight().fillMaxWidth(fraction.toFloat().coerceIn(0.02f, 1f)).clip(CircleShape).background(fill))
        }
        Text(text, Modifier.widthIn(min = 64.dp), style = MaterialTheme.typography.labelLarge, color = c.ink, textAlign = TextAlign.End, maxLines = 1)
    }
}

// ------------------------------------------------------------------------------------------------ Year in Pixels

private class YearView(
    val first: Int, val cells: List<HeatCell>, val starts: List<Int>, val lengths: List<Int>, val todayIndex: Int?,
    val headline: String?, val detail: String?, val earliestYear: Int,
)

private fun yearView(store: HabitStore, habit: Habit, year: Int, today: Int): YearView {
    val span = store.rules.period(PeriodKind.YEAR, pageDay(year, 6, 1))
    val quit = habit.kind == HabitKind.Quit
    val card = if (quit) store.quitPeriodCard(habit, span, ProgressRange.YEAR, today) else store.periodCard(habit, span, ProgressRange.YEAR, today)
    val count = span.last - span.first + 1
    val cells = card?.days?.takeIf { it.size == count }?.map { it.heat } ?: List(count) { HeatCell.Blank }
    val starts = (1..12).map { pageDay(year, it, 1) - span.first }
    val lengths = (1..12).map { pageMonthLength(pageDay(year, it, 1)) }
    val first = if (quit) store.rules.quitStartDay(habit) else store.rules.startDay(habit)
    return YearView(span.first, cells, starts, lengths, if (today in span) today - span.first else null, card?.headline, card?.detail, pageYear(first))
}

private val monthNamesShort = (1..12).map { pageMonthShort(it) }

/** Year in Pixels: the whole year as twelve month columns; a tap on a square shows its day under the grid, with Open day. */
@Composable
private fun YearCard(habit: Habit, store: HabitStore, today: Int, revision: Int, onOpenDay: (Int) -> Unit) {
    val c = appColors
    val thisYear = pageYear(today)
    var year by rememberSaveable(habit.id) { mutableStateOf<Int?>(null) }
    var selected by remember(habit.id) { mutableStateOf<Int?>(null) }
    val shown = year ?: thisYear
    val view = remember(habit, revision, today, shown) { yearView(store, habit, shown, today) }
    Column(
        Modifier.pageItem().fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.surface)
            .padding(horizontal = 12.dp, vertical = 16.dp).semantics { testTag = "habit-year-grid" },
        verticalArrangement = Arrangement.spacedBy(16.dp),
    ) {
        Box(Modifier.padding(start = 4.dp)) {
            PeriodHeader("Year in Pixels", if (shown == thisYear) "$shown · This year" else "$shown", "year",
                shown > view.earliestYear, shown < thisYear) { step ->
                selected = null
                year = if (shown + step == thisYear) null else shown + step
            }
        }
        view.headline?.let { headline ->
            Column(Modifier.padding(horizontal = 4.dp), verticalArrangement = Arrangement.spacedBy(4.dp)) {
                Text(headline, style = MaterialTheme.typography.titleLarge, color = c.ink)
                view.detail?.let { Text(it, style = MaterialTheme.typography.bodyMedium, color = c.secondary) }
            }
        }
        HeatYearPixels(view.cells, view.starts, view.lengths, monthNamesShort, view.todayIndex, selected, habit.color) { index ->
            val day = view.first + index
            if (day <= today) selected = if (selected == index) null else index
        }
        val pick = selected
        if (pick != null) {
            val day = view.first + pick
            Row(
                Modifier.fillMaxWidth().clip(RoundedCornerShape(16.dp)).background(c.tonal2).padding(12.dp),
                verticalAlignment = Alignment.CenterVertically,
            ) {
                Column(Modifier.weight(1f).semantics(mergeDescendants = true) { }) {
                    Text(LocalDate.ofEpochDay(day.toLong()).format(selectedDayFormat), style = MaterialTheme.typography.titleSmall, color = c.ink)
                    Text(store.dayResult(habit, day), style = MaterialTheme.typography.bodyMedium, color = c.secondary)
                }
                Spacer(Modifier.width(8.dp))
                TonalButton("Open day", { onOpenDay(day) }, Modifier.semantics { testTag = "year-open-day" })
            }
        } else {
            Text("Tap a square to see its day.", Modifier.padding(horizontal = 4.dp), style = MaterialTheme.typography.bodySmall, color = c.secondary)
        }
    }
}
