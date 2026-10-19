package com.oftenenough.app.ui.habit

import androidx.compose.ui.graphics.compositeOver
import com.oftenenough.app.ui.components.segmentShape
import androidx.compose.foundation.lazy.itemsIndexed
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
import com.oftenenough.app.data.quitRecord
import com.oftenenough.app.data.noteIndexes
import com.oftenenough.app.data.amountsUnder
import com.oftenenough.app.data.weekLabels
import androidx.compose.foundation.gestures.detectTapGestures
import androidx.compose.ui.input.pointer.pointerInput
import com.oftenenough.app.ui.charts.LightBarChart
import com.oftenenough.app.ui.components.CookieShape
import com.oftenenough.app.ui.components.TonalButton
import com.oftenenough.app.ui.theme.appColors
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.Locale
import kotlinx.coroutines.delay

// Habit details' Progress tab (Figma 1373:2, 3.1–3.9; the iPhone's HabitProgressTab.swift): one card each for the Overall
// record (See all streaks opens every run), Milestones, What the squares mean, Week, Month and Year in Pixels. Facts are recorded data and plain counts with their
// denominators (no scores or predictions). Every card works its numbers out when its period or the habit's data change
// (a `remember` keyed on the habit's revision), never while drawing (S5, S8); the only thing that ticks is a quit habit's
// live run, in its own small Text (S3).

private val selectedDayFormat = DateTimeFormatter.ofPattern("EEEE d MMMM", Locale.ENGLISH)

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
    if (shown.next.isNotEmpty()) item(key = "progress-milestones") { MilestonesCard(shown, habit.color, onSeeAll) }
    item(key = "progress-key") { HabitKeyCard(keyOpen, onToggleKey, habit.color, Modifier.pageItem()) }
    item(key = "progress-week") { PeriodCardView(habit, store, week = true, today = today, revision = revision, onOpenDay = onOpenDay) }
    item(key = "progress-month") { PeriodCardView(habit, store, week = false, today = today, revision = revision, onOpenDay = onOpenDay) }
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
private fun RecordCard(record: HabitOverall, color: HabitColor, showStreaks: Boolean, showPercentages: Boolean, archived: Boolean, onSeeAll: () -> Unit) {
    val c = appColors
    val oneColumn = LocalDensity.current.fontScale >= 1.5f
    PageCard("habit-progress-record") {
        Row(Modifier.fillMaxWidth().semantics(mergeDescendants = true) { heading() }, verticalAlignment = Alignment.CenterVertically) {
            Text("Overall record", Modifier.weight(1f), style = AppType.titleMedium, color = c.ink)
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
        if (boxes.isNotEmpty()) {
            Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                for (row in boxes.chunked(if (oneColumn) 1 else 2)) {
                    Row(Modifier.fillMaxWidth().height(IntrinsicSize.Min), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                        for (box in row) RecordBox(box, color, Modifier.weight(1f).fillMaxHeight())
                    }
                }
            }
        }
        if (showStreaks && current != null) SeeAllLink("See all streaks", "habit-see-all-streaks", onSeeAll)
    }
}

/** "See all streaks ›" at a card's end (Figma 3.1), the way Milestones' See all opens All milestones. */
@Composable
private fun ColumnScope.SeeAllLink(text: String, tag: String, onClick: () -> Unit) {
    Row(
        Modifier.align(Alignment.End).clip(RoundedCornerShape(20.dp)).clickable(onClick = onClick).heightIn(min = 48.dp).padding(horizontal = 8.dp)
            .semantics(mergeDescendants = true) { testTag = tag },
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Text(text, style = AppType.labelLarge, color = appColors.ink)
        Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, Modifier.size(20.dp), tint = appColors.ink)
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

/**
 * A quit habit's Overall record (Figma 3.9): the time without a slip, ticking in its own Text; the run now, the longest,
 * the slips and the days with none; See all runs; and the money saved when a cost is set.
 */
@Composable
private fun QuitRecordCard(habit: Habit, store: HabitStore, today: Int, revision: Int, onSeeAll: () -> Unit) {
    val c = appColors
    val record = remember(habit, revision, today) { store.quitRecord(habit, today) }
    val saved = remember(habit, revision, today) { store.moneySaved(habit) }
    PageCard("habit-progress-record") {
        Row(Modifier.fillMaxWidth().semantics(mergeDescendants = true) { heading() }, verticalAlignment = Alignment.CenterVertically) {
            Text("Overall record", Modifier.weight(1f), style = AppType.titleMedium, color = c.ink)
            Spacer(Modifier.width(8.dp))
            Text(record.since, style = MaterialTheme.typography.bodyMedium, color = c.secondary, maxLines = 1)
        }
        val start = record.runStart
        if (start != null) QuitClockText(start, store.clock)
        else Text("Paused", style = AppType.headlineSmall, color = c.ink)
        val oneColumn = LocalDensity.current.fontScale >= 1.5f
        val boxes = listOf(
            RecordBoxData("habit-streak-current", record.current, record.current.detail, record.current.spoken, true),
            RecordBoxData("habit-streak-best", record.longest, record.longest.detail, record.longest.spoken, false),
            RecordBoxData("habit-quit-slips", record.slips, record.slips.detail, record.slips.spoken, false),
            RecordBoxData("habit-quit-clean", record.clean, record.clean.detail, record.clean.spoken, false),
        )
        Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
            for (row in boxes.chunked(if (oneColumn) 1 else 2)) {
                Row(Modifier.fillMaxWidth().height(IntrinsicSize.Min), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    for (box in row) RecordBox(box, habit.color, Modifier.weight(1f).fillMaxHeight())
                }
            }
        }
        saved?.let { Text(it, Modifier.semantics { testTag = "quit-money-saved" }, style = MaterialTheme.typography.labelLarge, color = c.ink) }
        SeeAllLink("See all runs", "habit-see-all-runs", onSeeAll)
    }
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
    // "12 days 6 h slip-free" (Figma 3.9): the days large, the hours after them; it moves on by itself each minute.
    val seconds = (now - start) / 1000
    val days = seconds / 86400
    val hours = seconds % 86400 / 3600
    val text = buildAnnotatedString {
        withStyle(AppType.displayMedium.toSpanStyle().copy(color = appColors.ink)) { append(com.oftenenough.app.data.HabitCopy.number(days.toDouble())) }
        withStyle(AppType.bodyLarge.toSpanStyle().copy(color = appColors.secondary)) { append(" " + (if (days == 1L) "day" else "days") + " $hours h slip-free") }
    }
    Text(text, Modifier.semantics { contentDescription = "$days ${if (days == 1L) "day" else "days"} $hours hours without a slip"; testTag = "quit-clock" }, maxLines = 2)
}

// ------------------------------------------------------------------------------------------------ Milestones

/**
 * Milestones (Figma 1373:2, 2475:75): the latest on a tinted plate with its 72 dp medal, the earlier ones side by side,
 * and the next one of each track with a ring filling toward it. See all opens every milestone, track by track.
 */
@Composable
private fun MilestonesCard(milestones: HabitMilestones, color: HabitColor, onSeeAll: () -> Unit) {
    val c = appColors
    val reached = milestones.reached
    Column(
        Modifier.pageItem().fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.surface).padding(20.dp)
            .semantics { testTag = "habit-milestones" },
        verticalArrangement = Arrangement.spacedBy(12.dp),
    ) {
        Row(Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
            Text("Milestones", Modifier.weight(1f).semantics { heading() }, style = AppType.titleMedium, color = c.ink)
            if (reached.size >= 2) {
                Row(
                    Modifier.clip(RoundedCornerShape(20.dp)).clickable(onClick = onSeeAll).heightIn(min = 40.dp).padding(start = 12.dp, end = 4.dp)
                        .clearAndSetSemantics { contentDescription = "See all ${reached.size} milestones"; testTag = "habit-milestones-see-all" },
                    verticalAlignment = Alignment.CenterVertically,
                ) {
                    Text("See all ${reached.size}", style = AppType.labelLarge, color = c.ink)
                    Spacer(Modifier.width(2.dp))
                    Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, Modifier.size(20.dp), tint = c.ink)
                }
            } else if (reached.size == 1) {
                Text("1 reached", style = AppType.bodyMedium, color = c.secondary)
            }
        }
        reached.firstOrNull()?.let { latest ->
            Row(
                Modifier.fillMaxWidth().clip(RoundedCornerShape(20.dp)).background(plateColor(c, color)).padding(16.dp)
                    .clearAndSetSemantics {
                        contentDescription = (if (reached.size > 1) "Latest: " else "") + latest.spoken
                        testTag = "habit-milestone-latest"
                    },
                verticalAlignment = Alignment.CenterVertically,
            ) {
                MilestoneMedal(latest.number, 72.dp, color)
                Spacer(Modifier.width(16.dp))
                Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
                    if (reached.size > 1) Text("Latest", style = AppType.labelMedium, color = c.secondary)
                    Text(latest.title, style = AppType.titleMedium, color = c.ink)
                    Text(latest.reachedText, style = AppType.bodyMedium, color = c.secondary)
                }
            }
        }
        if (reached.size > 1) {
            Text("Earlier", style = AppType.labelMedium, color = c.secondary)
            val earlier = reached.drop(1)
            if (earlier.size <= 4) {
                // Side by side, each a share of the width (Figma: three, 4 apart).
                Row(Modifier.fillMaxWidth().semantics { testTag = "habit-milestone-shelf" }, horizontalArrangement = Arrangement.spacedBy(4.dp)) {
                    for (m in earlier) ShelfMedal(m, color, Modifier.weight(1f))
                    repeat(3 - earlier.size.coerceAtMost(3)) { Spacer(Modifier.weight(1f)) }
                }
            } else {
                Row(Modifier.fillMaxWidth().horizontalScroll(rememberScrollState()).semantics { testTag = "habit-milestone-shelf" },
                    horizontalArrangement = Arrangement.spacedBy(4.dp)) {
                    for (m in earlier) ShelfMedal(m, color, Modifier.width(88.dp))
                }
            }
        }
        if (milestones.next.isNotEmpty()) {
            Text("Next", style = AppType.labelMedium, color = c.secondary)
            for (next in milestones.next) MilestoneNextRow(next, color, onPage = false)
        }
    }
}

/** The plate behind the latest medal: the habit's colour at 14 % on the card (Figma), a little more on dark. */
private fun plateColor(c: com.oftenenough.app.ui.theme.AppColors, color: HabitColor): Color =
    c.habit(color).copy(alpha = if (c.dark) 0.2f else 0.14f).compositeOver(c.surface)

@Composable
private fun ShelfMedal(m: Milestone, color: HabitColor, modifier: Modifier) {
    val c = appColors
    Column(modifier.clearAndSetSemantics { contentDescription = m.spoken }, horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.spacedBy(4.dp)) {
        MilestoneMedal(m.number, 52.dp, color)
        Text(m.shelfTop, style = AppType.labelMedium, color = c.ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
        Text(m.shelfBottom, style = AppType.bodySmall, color = c.secondary, maxLines = 1, overflow = TextOverflow.Ellipsis)
    }
}

/** A ring filling clockwise from the top toward a track's next milestone (Figma: 52, a 3.9 band, the colour at 20 %). */
@Composable
private fun MilestoneRing(next: MilestoneNext, color: HabitColor) {
    val c = appColors
    val ring = c.habit(color)
    val track = ring.copy(alpha = if (c.dark) 0.28f else 0.2f)
    Box(Modifier.size(52.dp), contentAlignment = Alignment.Center) {
        Canvas(Modifier.size(52.dp)) {
            val w = 3.9.dp.toPx()
            val inset = w / 2
            val arc = Size(size.width - w, size.height - w)
            drawArc(track, 0f, 360f, false, Offset(inset, inset), arc, style = Stroke(w))
            if (next.fraction > 0) drawArc(ring, -90f, 360f * next.fraction.toFloat(), false, Offset(inset, inset), arc, style = Stroke(w, cap = StrokeCap.Round))
        }
        if (next.target == null) Icon(Icons.Rounded.Check, null, tint = c.ink)
        else Text(next.number, color = c.ink, style = if (next.number.length >= 3) AppType.labelLarge else AppType.titleMedium, maxLines = 1)
    }
}

/** A track's next milestone: its ring, what it is, and what's left ("7 to go · now 23"; on All milestones "Next · …"). */
@Composable
private fun MilestoneNextRow(next: MilestoneNext, color: HabitColor, onPage: Boolean, modifier: Modifier = Modifier) {
    val c = appColors
    Row(modifier.fillMaxWidth().clearAndSetSemantics { contentDescription = next.spoken; testTag = "habit-milestone-next-" + next.track.key },
        verticalAlignment = Alignment.CenterVertically) {
        MilestoneRing(next, color)
        Spacer(Modifier.width(16.dp))
        Column(Modifier.weight(1f)) {
            Text(next.title, style = AppType.titleMedium, color = c.ink)
            next.detail?.let { Text(if (onPage && next.target != null) "Next · $it" else it, style = AppType.bodyMedium, color = c.secondary) }
        }
    }
}

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
        TopAppBar(
            title = { Text("All milestones", style = AppType.titleLargeEmphasized, maxLines = 1) },
            navigationIcon = { IconButton(onBack, Modifier.semantics { testTag = "milestones-back" }) { Icon(Icons.AutoMirrored.Rounded.ArrowBack, "Back") } },
            colors = TopAppBarDefaults.topAppBarColors(containerColor = c.screen, titleContentColor = c.ink, navigationIconContentColor = c.ink),
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
                        MilestoneNextRow(next, color, onPage = true)
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
                        MilestoneMedal(m.number, 52.dp, color)
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
    val notes: Set<Int>, val below: List<String>?, val weekLabels: List<String>?,
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
        notes = store.noteIndexes(habit, span),
        below = if (week || quit) null else store.amountsUnder(habit, span, today),
        weekLabels = if (week || quit) null else store.weekLabels(habit, span, pageMonthLead(span.first, store.weekStart), today),
    )
}

/** The Week or Month card: its dates with ‹ ›, what was recorded on the goal's own clock, the squares, the amount
 *  recorded each day (Month), and the period against the one before. */
@Composable
private fun PeriodCardView(habit: Habit, store: HabitStore, week: Boolean, today: Int, revision: Int, onOpenDay: (Int) -> Unit) {
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
                        HeatStrip(cells, view.todayIndex, habit.color, HeatSize.week, Modifier.semantics { testTag = "week-strip" }.pointerInput(view.span) {
                            // A tap opens that day (Figma 4.1); a day to come does nothing.
                            detectTapGestures { at ->
                                val i = (at.x / (size.width.toFloat() / cells.size)).toInt()
                                val day = view.span.first + i
                                if (i in cells.indices && day <= today && cells[i] != HeatCell.Blank) onOpenDay(day)
                            }
                        })
                    }
                } else {
                    Column(verticalArrangement = Arrangement.spacedBy(6.dp)) {
                        DayNames(pageWeekdayLetters(store.weekStart) + listOfNotNull(view.weekLabels?.let { "Week" }), view.todayIndex?.let { (view.lead + it) % 7 })
                        HeatMonthGrid(view.lead, cells, view.todayIndex, habit.color, size = if (view.weekLabels != null) 32.dp else HeatSize.month,
                            notes = view.notes, below = view.below, weekLabels = view.weekLabels) { i -> onOpenDay(view.span.first + i) }
                    }
                }
            }
            val bars = view.bars
            if (bars != null) {
                Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                    Text("Recorded each day", style = AppType.labelLarge, color = c.ink)
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

/** The weekday names (or letters) over the squares; today's in Medium, in ink (Figma 1.5, 3.3). */
@Composable
private fun DayNames(names: List<String>, todayColumn: Int?) {
    Row(Modifier.fillMaxWidth().clearAndSetSemantics { }) {
        names.forEachIndexed { i, name ->
            val isToday = i == todayColumn
            Text(name, Modifier.weight(1f), style = MaterialTheme.typography.labelMedium.copy(
                fontWeight = if (isToday) FontWeight.Medium else FontWeight.Normal,
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
            Text(title, style = AppType.titleMedium, color = c.ink)
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
    val headline: String?, val detail: String?, val earliestYear: Int, val notes: Set<Int>,
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
    return YearView(span.first, cells, starts, lengths, if (today in span) today - span.first else null, card?.headline, card?.detail, pageYear(first),
        store.noteIndexes(habit, span))
}

private val monthNamesShort = (1..12).map { pageMonthShort(it) }

/** Year in Pixels: the whole year as twelve month columns; a tap on a square shows its day under the grid, with Open day. */
@Composable
private fun YearCard(habit: Habit, store: HabitStore, today: Int, revision: Int, onOpenDay: (Int) -> Unit) {
    val c = appColors
    val thisYear = pageYear(today)
    var year by rememberSaveable(habit.id) { mutableStateOf<Int?>(null) }
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
                year = if (shown + step == thisYear) null else shown + step
            }
        }
        view.headline?.let { headline ->
            Column(Modifier.padding(horizontal = 4.dp), verticalArrangement = Arrangement.spacedBy(4.dp)) {
                Text(headline, style = MaterialTheme.typography.titleLarge, color = c.ink)
                view.detail?.let { Text(it, style = MaterialTheme.typography.bodyMedium, color = c.secondary) }
            }
        }
        HeatYearPixels(view.cells, view.starts, view.lengths, monthNamesShort, view.todayIndex, null, habit.color, view.notes) { index ->
            // A tap opens that day (Figma 4.1); a day to come does nothing.
            val day = view.first + index
            if (day <= today && view.cells[index] != HeatCell.Blank) onOpenDay(day)
        }
    }
}
