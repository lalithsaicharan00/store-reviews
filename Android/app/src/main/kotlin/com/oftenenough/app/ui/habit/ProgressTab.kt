package com.oftenenough.app.ui.habit

import com.oftenenough.app.ui.components.Medal
import com.oftenenough.app.ui.components.EmptyState
import com.oftenenough.app.ui.components.MilestonesCard
import com.oftenenough.app.ui.components.StatTile
import com.oftenenough.app.ui.components.YearInPixelsCard
import com.oftenenough.app.ui.components.OverallRecordCard
import com.oftenenough.app.ui.components.OverallRecordTotal
import com.oftenenough.app.ui.components.HabitHistoryCard
import com.oftenenough.app.ui.components.HistoryDailyChart
import com.oftenenough.app.ui.components.HistoryMonth
import com.oftenenough.app.ui.components.HistoryPeriodHeader
import com.oftenenough.app.ui.components.HistorySection
import com.oftenenough.app.ui.components.HistorySummary
import com.oftenenough.app.ui.components.HistoryWeek
import com.oftenenough.app.ui.components.NextMilestone
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.AppTopBar
import com.oftenenough.app.ui.components.ComparisonRow
import com.oftenenough.app.ui.components.segmentShape
import androidx.compose.foundation.lazy.itemsIndexed
import com.oftenenough.app.ui.theme.AppType

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyListScope
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
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
import androidx.compose.ui.semantics.clearAndSetSemantics
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.buildAnnotatedString
import androidx.compose.ui.text.withStyle
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitMilestones
import com.oftenenough.app.data.HabitOverall
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.HeatCell
import com.oftenenough.app.data.Milestone
import com.oftenenough.app.data.PeriodCard
import com.oftenenough.app.data.PeriodComparison
import com.oftenenough.app.data.PeriodKind
import com.oftenenough.app.data.ProgressRange
import com.oftenenough.app.data.RecordFact
import com.oftenenough.app.data.moneySaved
import com.oftenenough.app.data.pageDay
import com.oftenenough.app.data.pageMonthCaption
import com.oftenenough.app.data.pageMonthLead
import com.oftenenough.app.data.pageMonthLength
import com.oftenenough.app.data.pageMonthTitle
import com.oftenenough.app.data.pageWeekCaption
import com.oftenenough.app.data.pageWeekTitle
import com.oftenenough.app.data.pageWeekdayLetters
import com.oftenenough.app.data.pageWeekdayNames
import com.oftenenough.app.data.pageYear
import com.oftenenough.app.data.periodCard
import com.oftenenough.app.data.periodComparison
import com.oftenenough.app.data.quitPeriodCard
import com.oftenenough.app.data.recordedEachDay
import com.oftenenough.app.data.quitRecord
import com.oftenenough.app.data.progressValue
import com.oftenenough.app.data.weekLabels
import com.oftenenough.app.ui.theme.appColors
import java.time.format.DateTimeFormatter
import java.util.Locale
import kotlinx.coroutines.delay

// Habit details' Progress tab (Figma 1373:2, 3.1–3.9; the iPhone's HabitProgressTab.swift): one card each for the Overall
// record (See all streaks opens every run), Milestones, What the squares mean, Week, Month and Year in Pixels. Facts are recorded data and plain counts with their
// denominators (no scores or predictions). Every card works its numbers out when its period or the habit's data change
// (a `remember` keyed on the habit's revision), never while drawing (S5, S8); the only thing that ticks is a quit habit's
// live run, in its own small Text (S3).

private val startDay = DateTimeFormatter.ofPattern("EEE d MMM", Locale.ENGLISH)

/** The Progress tab's items. [record] and [milestones] come from the page's model (null for a quit habit's record). */
internal fun LazyListScope.progressItems(
    habit: Habit, store: HabitStore, today: Int, revision: Int, record: HabitOverall?, milestones: HabitMilestones,
    showStreaks: Boolean, showPercentages: Boolean, keyOpen: Boolean, onToggleKey: () -> Unit, onSeeAll: () -> Unit,
    onSeeAllStreaks: () -> Unit, onOpenDay: (Int) -> Unit, @Suppress("UNUSED_PARAMETER") onAddSlip: () -> Unit,
) {
    if (habit.kind == HabitKind.Quit) {
        item(key = "progress-quit-record") { QuitRecordCard(habit, store, today, revision, onSeeAllStreaks) }
    } else if (record != null) {
        item(key = "progress-record") { RecordCard(record, habit.color, showStreaks, showPercentages, habit.archived, onSeeAllStreaks) }
    }
    val shown = milestones.shown(showStreaks)
    if (shown.next.isNotEmpty()) item(key = "progress-milestones") { MilestonesCard(shown, habit.color, onSeeAll, Modifier.pageItem()) }
    item(key = "progress-key") { HabitKeyCard(keyOpen, onToggleKey, habit.color, Modifier.pageItem()) }
    item(key = "progress-week") { PeriodCardView(habit, store, week = true, today = today, revision = revision, onOpenDay = onOpenDay) }
    item(key = "progress-month") { PeriodCardView(habit, store, week = false, today = today, revision = revision, onOpenDay = onOpenDay) }
    item(key = "progress-year") { YearCard(habit, store, today, revision, onOpenDay) }
}

/**
 * Progress for a habit with nothing logged yet (Figma's New habit): no record, milestones or charts to show, so the
 * Empty state (insights in its cookie, "No progress yet", what will build up here), 40 under the tabs; 24 under it, the
 * first Week ("Your first week", when it started); then What the squares mean, folded. Nothing is padded or guessed.
 */
internal fun LazyListScope.freshItems(habit: Habit, store: HabitStore, today: Int, revision: Int, keyOpen: Boolean, onToggleKey: () -> Unit, onOpenDay: (Int) -> Unit) {
    item(key = "progress-fresh") {
        EmptyState(Symbols.Insights, "No progress yet", "Log ${habit.name} on Today. Your record, streaks and milestones build up here.",
            Modifier.padding(top = 24.dp, bottom = 40.dp).semantics { testTag = "habit-no-progress" })
    }
    item(key = "progress-week") { PeriodCardView(habit, store, week = true, today = today, revision = revision, onOpenDay = onOpenDay, firstWeek = true) }
    item(key = "progress-key") { HabitKeyCard(keyOpen, onToggleKey, habit.color, Modifier.pageItem()) }
}

// ------------------------------------------------------------------------------------------------ Overall record

@Composable
private fun RecordCard(record: HabitOverall, color: HabitColor, showStreaks: Boolean, showPercentages: Boolean, archived: Boolean, onSeeAll: () -> Unit) {
    val boxes = ArrayList<RecordBoxData>()
    val current = record.current
    val best = record.best
    if (showStreaks && current != null && best != null) {
        // An archived habit's run stopped with it (Figma 6.2).
        val now = if (archived) current.copy(title = "Streak when archived", spoken = current.spoken.replace("Current streak", "Streak when archived")) else current
        boxes.add(RecordBoxData("habit-streak-current", now, now.detail, now.spoken, true))
        boxes.add(RecordBoxData("habit-streak-best", best, best.detail, best.spoken, false))
    }
    record.goalMet?.let { goal ->
        // The percentage follows Progress's "Show percentages".
        val percent = if (showPercentages && record.eligible > 0) Math.round(record.met.toDouble() / record.eligible * 100).toInt() else null
        boxes.add(RecordBoxData("habit-record-goal-met", goal, percent?.let { "$it% ${record.percentNoun}" },
            goal.spoken + (percent?.let { ", $it percent ${record.percentNoun}" } ?: ""), false))
    }
    record.bestPeriod?.let { boxes.add(RecordBoxData("habit-record-best-period", it, it.detail, it.spoken, false)) }
    OverallRecordCard(
        record.since, if (showStreaks && current != null) "See all streaks" else null, onSeeAll,
        Modifier.pageItem().semantics { testTag = "habit-progress-record" }, seeAllTag = "habit-see-all-streaks",
        total = { OverallRecordTotal(record.lead, record.value, record.trail, record.headline, Modifier.semantics { testTag = "habit-record-headline" }) },
        tiles = boxes.map { box -> { m: Modifier -> RecordBox(box, color, m) } },
    )
}

private class RecordBoxData(val tag: String, val fact: RecordFact, val detail: String?, val spoken: String, val tinted: Boolean)

/** One box: the Stat tile (4.14); the current streak on the habit's Fill with the phone's 🔥. */
@Composable
private fun RecordBox(box: RecordBoxData, color: HabitColor, modifier: Modifier) =
    StatTile(box.fact.title, box.fact.number, box.fact.unit, box.detail, box.spoken, modifier,
        emoji = if (box.tinted) "🔥" else null, fill = if (box.tinted) color else null, tag = box.tag)

/**
 * A quit habit's Overall record (Figma 3.9): the time without a slip, ticking in its own Text; the run now, the longest,
 * the slips and the days with none; See all runs; and the money saved when a cost is set.
 */
@Composable
private fun QuitRecordCard(habit: Habit, store: HabitStore, today: Int, revision: Int, onSeeAll: () -> Unit) {
    val record = remember(habit, revision, today) { store.quitRecord(habit, today) }
    val saved = remember(habit, revision, today) { store.moneySaved(habit) }
    val boxes = listOf(
        RecordBoxData("habit-streak-current", record.current, record.current.detail, record.current.spoken, true),
        RecordBoxData("habit-streak-best", record.longest, record.longest.detail, record.longest.spoken, false),
        RecordBoxData("habit-quit-slips", record.slips, record.slips.detail, record.slips.spoken, false),
        RecordBoxData("habit-quit-clean", record.clean, record.clean.detail, record.clean.spoken, false),
    )
    OverallRecordCard(
        record.since, "See all runs", onSeeAll, Modifier.pageItem().semantics { testTag = "habit-progress-record" }, seeAllTag = "habit-see-all-runs",
        total = {
            val start = record.runStart
            if (start != null) QuitClockText(start, store.clock)
            else Text("Paused", style = AppType.headlineLargeEmphasized, color = MaterialTheme.colorScheme.onSurface)
        },
        tiles = boxes.map { box -> { m: Modifier -> RecordBox(box, habit.color, m) } },
        more = { saved?.let { Text(it, Modifier.semantics { testTag = "quit-money-saved" }, style = AppType.labelLarge, color = MaterialTheme.colorScheme.onSurface) } },
    )
}

/** The live run, ticking each second in this Text only, from the run's start (Rulebook S3, S4). */
@Composable
private fun QuitClockText(start: Long, clock: () -> Long) {
    var now by remember { mutableLongStateOf(clock()) }
    LaunchedEffect(start) {
        while (true) {
            now = clock()
            delay((60_000 - (now - start) % 60_000).coerceIn(50, 60_000))
        }
    }
    // "12 days 6 h clean" (Figma 3.9, "smoke-free": one word for every quit habit, the user, 19 Oct 2026): the days large, the hours after them; it moves on by itself each minute.
    val seconds = (now - start) / 1000
    val days = seconds / 86400
    val hours = seconds % 86400 / 3600
    val text = buildAnnotatedString {
        withStyle(AppType.headlineLargeEmphasized.toSpanStyle().copy(color = MaterialTheme.colorScheme.onSurface)) { append(com.oftenenough.app.data.HabitCopy.number(days.toDouble())) }
        withStyle(AppType.bodyLarge.toSpanStyle().copy(color = MaterialTheme.colorScheme.onSurfaceVariant)) { append(" " + (if (days == 1L) "day" else "days") + " $hours h clean") }
    }
    Text(text, Modifier.semantics { contentDescription = "$days ${if (days == 1L) "day" else "days"} $hours hours without a slip"; testTag = "quit-clock" }, maxLines = 2)
}

// ------------------------------------------------------------------------------------------------ Milestones

/**
 * All milestones (Figma 1735:4), from "See all N ›": the habit and how many it reached, then each track (In a row, the
 * total in the habit's own unit, Anniversaries; a quit habit's Since a slip) as one list: its next milestone first, then
 * every one reached, newest first; a note on how the tracks count at the end.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
internal fun AllMilestonesPage(habitName: String, milestones: HabitMilestones, color: HabitColor, onBack: () -> Unit) {
    BackHandler(onBack = onBack)
    val c = appColors
    val tracks = remember(milestones) {
        (milestones.next.map { it.track } + milestones.reached.map { it.track }).distinct()
            .sortedBy { listOf(Milestone.Track.IN_A_ROW, Milestone.Track.SINCE_SLIP, Milestone.Track.IN_TOTAL, Milestone.Track.ANNIVERSARY).indexOf(it) }
    }
    Column(Modifier.fillMaxSize().background(c.screen).semantics { testTag = "all-milestones" }) {
        AppTopBar(
            "All milestones",
            navigationIcon = { IconButton(onBack, Modifier.semantics { testTag = "milestones-back" }) { Icon(Symbols.ArrowBack, "Back") } },
        )
        LazyColumn(Modifier.fillMaxWidth().weight(1f).padding(horizontal = 16.dp)) {
            item(key = "summary") {
                Text("$habitName · ${milestones.reached.size} reached", Modifier.padding(start = 16.dp, top = 8.dp, bottom = 24.dp),
                    style = AppType.bodyMedium, color = c.secondary)
            }
            for (track in tracks) {
                val next = milestones.next.firstOrNull { it.track == track }
                val reached = milestones.reached.filter { it.track == track }
                val count = reached.size + (if (next != null) 1 else 0)
                item(key = "track-" + track.key) {
                    Text(trackTitle(track, milestones.totalLabel), Modifier.padding(start = 16.dp, bottom = 8.dp).semantics { heading() },
                        style = AppType.labelLarge, color = c.secondary)
                }
                if (next != null) item(key = "next-" + track.key) {
                    Box(Modifier.fillMaxWidth().padding(bottom = if (count == 1) 0.dp else 2.dp).clip(segmentShape(0, count)).background(c.surface)
                        .heightIn(min = 76.dp).padding(horizontal = 16.dp), contentAlignment = Alignment.CenterStart) {
                        NextMilestone(next, color, onPage = true)
                    }
                }
                itemsIndexed(reached, key = { _, m -> m.id }) { i, m ->
                    val index = i + (if (next != null) 1 else 0)
                    Row(
                        Modifier.fillMaxWidth().padding(bottom = if (index == count - 1) 0.dp else 2.dp).clip(segmentShape(index, count))
                            .background(c.surface).heightIn(min = 76.dp).padding(horizontal = 16.dp)
                            .clearAndSetSemantics { contentDescription = m.spoken; testTag = "milestone-reached" },
                        verticalAlignment = Alignment.CenterVertically,
                    ) {
                        Medal(m.number, 52.dp, color)
                        Spacer(Modifier.width(16.dp))
                        Column {
                            Text(m.title, style = AppType.titleMedium, color = c.ink)
                            Text(m.reachedText, style = AppType.bodyMedium, color = c.secondary)
                        }
                    }
                }
                item(key = "gap-" + track.key) { Spacer(Modifier.height(24.dp)) }
            }
            item(key = "all-milestones-note") {
                Text(
                    if (tracks.contains(Milestone.Track.SINCE_SLIP)) "Each track shows its next milestone. Reached ones stay, even after a slip."
                    else "Each track shows its next milestone. Reached ones stay, even if a streak ends. Anniversaries count each year " +
                        "from the first log, when the goal was met in the 30 days before.",
                    Modifier.padding(horizontal = 16.dp).padding(bottom = 32.dp).navigationBarsPadding(),
                    style = AppType.bodySmall, color = c.secondary)
            }
        }
    }
}

private fun trackTitle(track: Milestone.Track, totalLabel: String): String = when (track) {
    Milestone.Track.IN_A_ROW -> "In a row"
    Milestone.Track.IN_TOTAL -> totalLabel
    Milestone.Track.ANNIVERSARY -> "Anniversaries"
    Milestone.Track.SINCE_SLIP -> "Since a slip"
}

// ------------------------------------------------------------------------------------------------ Week and Month

/** A Week or Month card's numbers, worked out when its period or the data change. */
private class PeriodView(
    val span: IntRange, val subtitle: String, val card: PeriodCard?, val comparison: PeriodComparison?, val lead: Int,
    val bars: Pair<List<Double>, Double?>?, val canGoBack: Boolean, val canGoForward: Boolean, val todayIndex: Int?,
    val weekLabels: List<String>?,
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
        weekLabels = if (week || quit) null else store.weekLabels(habit, span, pageMonthLead(span.first, store.weekStart), today),
    )
}

/** The Week or Month card (the Habit history card, 4.15): its dates with ‹ ›, what was recorded on the goal's own
 *  clock, the squares, the amount recorded each day (Month), and the period against the one before. */
@Composable
private fun PeriodCardView(habit: Habit, store: HabitStore, week: Boolean, today: Int, revision: Int, onOpenDay: (Int) -> Unit, firstWeek: Boolean = false) {
    val c = appColors
    var anchor by rememberSaveable(habit.id, week) { mutableStateOf<Int?>(null) }
    val view = remember(habit, revision, today, anchor, store.weekStart) { periodView(store, habit, week, anchor, today) }
    val noun = if (week) "week" else "month"
    HabitHistoryCard(Modifier.pageItem().semantics { testTag = if (week) "habit-progress-week" else "habit-progress-month" }) {
        HistoryPeriodHeader(if (week) "Week" else "Month", view.subtitle, noun, view.canGoBack, view.canGoForward) { step ->
            val next = if (step < 0) view.span.first - 1 else view.span.last + 1
            anchor = if (next >= today || store.rules.period(if (week) PeriodKind.WEEK else PeriodKind.MONTH, next).contains(today)) null else next
        }
        val card = view.card
        val start = if (habit.kind == HabitKind.Quit) store.rules.quitStartDay(habit) else store.rules.startDay(habit)
        if (card != null) {
            // A habit's first week, nothing logged yet (Figma's New habit): "Your first week", "Started today, Fri 23 Oct".
            if (firstWeek && start in view.span) HistorySummary("Your first week", "Started " + (if (start == today) "today, " else "") + startDay.format(java.time.LocalDate.ofEpochDay(start.toLong())))
            else HistorySummary(card.headline, card.detail)
            if (card.days.size == view.span.last - view.span.first + 1) {
                val cells = remember(card) { card.days.map { it.heat } }
                // A tap opens that day (Figma 4.1); a day to come does nothing.
                val open: (Int?) -> Unit = { i ->
                    if (i != null && view.span.first + i <= today && cells[i] != HeatCell.Blank && cells[i] != HeatCell.Upcoming) onOpenDay(view.span.first + i)
                }
                if (week) HistoryWeek(pageWeekdayNames(store.weekStart), cells, view.todayIndex, habit.color, Modifier.semantics { testTag = "week-strip" }, open)
                else HistoryMonth(pageWeekdayLetters(store.weekStart), view.lead, cells, view.todayIndex, habit.color,
                    Modifier.semantics { testTag = "month-grid" }, view.weekLabels, open)
            }
            val bars = view.bars
            if (bars != null) {
                HistorySection("Recorded each day") {
                    val ruled = remember(habit, revision, view.span) { store.rule(habit, minOf(view.span.last, today)) }
                    HistoryDailyChart(bars.first, bars.second, view.todayIndex, habit.color, { progressValue(it, ruled) },
                        "Recorded each day in " + pageMonthTitle(view.span.first, today) + (card.detail?.let { ": $it" } ?: ""),
                        Modifier.semantics { testTag = "habit-month-chart" })
                }
            }
        } else {
            Text(if (habit.kind == HabitKind.Quit) "Nothing recorded this $noun." else "Not started yet this $noun.",
                style = AppType.bodyMedium, color = MaterialTheme.colorScheme.onSurfaceVariant)
        }
        view.comparison?.let { ComparisonView(it, habit.color) }
    }
}

/** This period and the one before (Figma's Comparison: "Same days last week"), as two Comparison rows (molecule 4.6)
 *  with exact values, both in the habit's colour; no arrows, no better or worse. */
@Composable
private fun ComparisonView(comparison: PeriodComparison, color: HabitColor) {
    HistorySection(comparison.title, Modifier.semantics(mergeDescendants = true) { testTag = "habit-comparison" }) {
        val note = comparison.note
        if (note != null) {
            Text(note, style = AppType.bodyMedium, color = MaterialTheme.colorScheme.onSurfaceVariant)
        } else {
            val top = maxOf(comparison.thisValue ?: 0.0, comparison.previousValue ?: 0.0, 0.0001)
            ComparisonRow(comparison.thisLabel, comparison.thisText, ((comparison.thisValue ?: 0.0) / top).toFloat(), color, Modifier.padding(end = 8.dp))
            ComparisonRow(comparison.previousLabel, comparison.previousText, ((comparison.previousValue ?: 0.0) / top).toFloat(), color, Modifier.padding(end = 8.dp))
        }
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

/** Year in pixels (molecule 4.17): the whole year as twelve month columns; a tap on a square opens its day. */
@Composable
private fun YearCard(habit: Habit, store: HabitStore, today: Int, revision: Int, onOpenDay: (Int) -> Unit) {
    val thisYear = pageYear(today)
    var year by rememberSaveable(habit.id) { mutableStateOf<Int?>(null) }
    val shown = year ?: thisYear
    val view = remember(habit, revision, today, shown) { yearView(store, habit, shown, today) }
    YearInPixelsCard(
        if (shown == thisYear) "$shown · This year" else "$shown", shown > view.earliestYear, shown < thisYear,
        { step -> year = if (shown + step == thisYear) null else shown + step },
        view.headline, view.detail, view.cells, view.starts, view.lengths, view.todayIndex, habit.color,
        onTap = { index ->
            // A tap opens that day (Figma 4.1); a day to come does nothing.
            val day = view.first + index
            if (day <= today && view.cells[index] != HeatCell.Blank) onOpenDay(day)
        },
        modifier = Modifier.pageItem().semantics { testTag = "habit-year-grid" },
    )
}
