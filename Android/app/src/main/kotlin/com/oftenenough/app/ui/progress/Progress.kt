package com.oftenenough.app.ui.progress

import com.oftenenough.app.ui.theme.AppType

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.horizontalScroll
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.selection.selectable
import androidx.compose.foundation.selection.selectableGroup
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.ArrowBack
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowLeft
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowRight
import androidx.compose.material.icons.rounded.BarChart
import androidx.compose.material.icons.rounded.Check
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.IconButtonDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.derivedStateOf
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableLongStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.withFrameNanos
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.clearAndSetSemantics
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.SpanStyle
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.buildAnnotatedString
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.text.withStyle
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.oftenenough.app.app.Prefs
import com.oftenenough.app.data.Format
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitGroup
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.HeatCell
import com.oftenenough.app.data.ProgressRange
import com.oftenenough.app.data.ProgressSnapshot
import com.oftenenough.app.data.ProgressWeekCard
import com.oftenenough.app.data.progressBuilder
import com.oftenenough.app.data.title
import com.oftenenough.app.ui.components.Card
import com.oftenenough.app.ui.components.CookieIcon
import com.oftenenough.app.ui.components.CookieShape
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.habit.HeatKeyCard
import com.oftenenough.app.ui.newhabit.ChoicePill
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.delay

/** Where Progress goes: a habit's own page (tapping its card), or Day details for one of its days (tapping a square). */
interface ProgressNav {
    fun openHabit(habit: Habit)
    fun openDay(habit: Habit, day: Int)
}

/**
 * Progress, opened from the ≡ menu (the iPhone's ProgressScreen.swift; designs §12). Week, Month and Year: the dates of
 * the period with ‹ ›, "What the squares mean", then a card per habit, each on its own goal's clock, with the period's
 * squares; no overview, no day rings, no group numbers (the iPhone, 2 Oct 2026). It only reads: nothing here logs.
 * Follows the group chosen for Progress (`prefs.progressGroup`), apart from Today's.
 *
 * Speed (S5, S8): every number comes from one `ProgressSnapshot`, worked out when the data, the period, the group or the
 * day changes, and kept for the app's life so going back to a period is instant; drawing reads it only. Each card's
 * squares are one drawing (S12); cards are a lazy list with stable keys, never a lazy grid (S13).
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ProgressScreen(store: HabitStore, prefs: Prefs, nav: ProgressNav, onBack: () -> Unit) {
    val c = appColors
    val visit = remember(store) { HeatKeyVisit(store) }
    val range = ProgressRangeMemory.range
    /** A day in the period on screen; null means the current one, so the page always opens on it. */
    var anchor by rememberSaveable { mutableStateOf<Int?>(null) }
    // A new day makes new numbers ("This week" kept from before the day's start would be last week). Wakes once a day,
    // at its start, never on a ticker (S3).
    var today by remember { mutableIntStateOf(store.today()) }
    LaunchedEffect(store) {
        while (true) {
            val t = store.today()
            today = t
            delay(maxOf(1_000L, store.rules.dayStart(t + 1) - store.clock()))
        }
    }
    val groupId = prefs.progressGroup
    val key = SnapshotKey(range, anchor, store.dataVersion, groupId, today, store.weekStart, System.identityHashCode(store))
    // The page's numbers: kept ones at once; otherwise the period and its first cards now (one frame's worth) and the
    // rest a few per frame, so even a year of many habits never holds a frame (S5, S16).
    val builder = remember(key) { if (ProgressCache.peek(key) != null) null else store.progressBuilder(range, anchor ?: today, today, groupId) }
    var snap by remember(key) { mutableStateOf(ProgressCache.peek(key) ?: builder!!.also { it.step(FIRST_BUDGET) }.snapshot()) }
    LaunchedEffect(key) {
        val b = builder ?: return@LaunchedEffect
        while (!b.isDone) {
            withFrameNanos { }
            b.step(FRAME_BUDGET)
            snap = b.snapshot()
        }
        ProgressCache.put(key, snap)
    }
    val move: (Int) -> Unit = { step ->
        val day = if (step < 0) snap.first - 1 else snap.last + 1
        anchor = if (today in store.rules.period(range.kind, day)) null else day
    }

    Column(Modifier.fillMaxSize().background(c.screen).semantics { testTag = "progress-screen" }) {
        TopAppBar(
            title = { Text("Progress", maxLines = 1) },
            navigationIcon = {
                IconButton(onBack, Modifier.semantics { testTag = "progress-back" }) { Icon(Icons.AutoMirrored.Rounded.ArrowBack, "Back") }
            },
            colors = TopAppBarDefaults.topAppBarColors(containerColor = c.screen, scrolledContainerColor = c.screen,
                titleContentColor = c.ink, navigationIconContentColor = c.ink),
        )
        if (!snap.hasHabits) {
            NoProgressYet()
        } else {
            val list = rememberLazyListState()
            // The dates stay at the top while the cards scroll (Week | Month | Year and the key scroll away), so it's always
            // clear which period the cards show and ‹ › are one tap away. Read through derivedStateOf: the screen redraws
            // only when the bar comes or goes, never per scrolled pixel (S6).
            val pinned by remember(list) {
                derivedStateOf { list.firstVisibleItemIndex > 1 || (list.firstVisibleItemIndex == 1 && list.firstVisibleItemScrollOffset > 0) }
            }
            Box(Modifier.weight(1f).fillMaxWidth()) {
                LazyColumn(
                    Modifier.fillMaxSize().semantics { testTag = "progress-list" },
                    state = list,
                    contentPadding = PaddingValues(bottom = 24.dp),
                ) {
                    item(key = "range", contentType = "range") { RangePicker(range) { ProgressRangeMemory.range = it } }
                    item(key = "period", contentType = "period") { PeriodBar(snap, move) }
                    if (store.groups.isNotEmpty()) {
                        item(key = "groups", contentType = "groups") {
                            GroupChips(store.groups, snap.group?.id) { prefs.progressGroup = it }
                        }
                    }
                    item(key = "key", contentType = "key") {
                        HeatKeyCard(visit.isOpen, { visit.toggle() }, Modifier.padding(start = 16.dp, end = 16.dp, top = 8.dp, bottom = 16.dp))
                    }
                    if (snap.complete && snap.group != null && snap.cards.isEmpty() && snap.archivedCards.isEmpty()) {
                        item(key = "group-empty", contentType = "note") {
                            Text("No habits in this group yet. Add them in Filter on Today, or in a habit's Group.",
                                Modifier.fillMaxWidth().padding(horizontal = 32.dp, vertical = 8.dp).semantics { testTag = "progress-group-empty" },
                                style = MaterialTheme.typography.bodyMedium, color = c.secondary, textAlign = TextAlign.Center)
                        }
                    }
                    items(snap.cards, key = { "card-" + it.habit.id }, contentType = { "card" }) { card ->
                        HabitCard(card, snap, store, nav, Modifier.padding(horizontal = 16.dp, vertical = 8.dp))
                    }
                    if (snap.archivedCards.isNotEmpty()) {
                        item(key = "archived-title", contentType = "note") {
                            Text("Archived", Modifier.padding(start = 32.dp, end = 32.dp, top = 16.dp, bottom = 4.dp).semantics { heading() },
                                style = AppType.labelLarge, color = c.secondary)
                        }
                        items(snap.archivedCards, key = { "archived-" + it.habit.id }, contentType = { "card" }) { card ->
                            HabitCard(card, snap, store, nav, Modifier.padding(horizontal = 16.dp, vertical = 8.dp))
                        }
                        item(key = "archived-note", contentType = "note") {
                            Text("Archived habits count for the days before they were archived.", Modifier.padding(horizontal = 32.dp, vertical = 4.dp),
                                style = MaterialTheme.typography.bodySmall, color = c.secondary)
                        }
                    }
                    item(key = "end", contentType = "end") { Spacer(Modifier.navigationBarsPadding()) }
                }
                if (pinned) PeriodBar(snap, move)
            }
        }
    }
}

/** The first frame's share of the cards' work, and each later frame's (a Year card is ~23 ms: one a frame). */
private const val FIRST_BUDGET = 20_000_000L
private const val FRAME_BUDGET = 6_000_000L

/** One snapshot per range, period, data version, group, day and week start (and store, for a test's own). */
private data class SnapshotKey(
    val range: ProgressRange, val anchor: Int?, val version: Int, val group: String, val today: Int, val weekStart: Int, val store: Int,
)

/**
 * Progress's numbers, kept between openings (one for the app): reopening Progress, or going back to a period, with
 * nothing changed shows the numbers already worked out (the iPhone's `ProgressModel`).
 */
private object ProgressCache {
    private val made = HashMap<SnapshotKey, ProgressSnapshot>()

    fun peek(key: SnapshotKey): ProgressSnapshot? = made[key]

    fun put(key: SnapshotKey, snapshot: ProgressSnapshot) {
        made.keys.removeAll { it.version != key.version || it.store != key.store || it.today != key.today }
        if (made.size > 80) made.clear()
        made[key] = snapshot
    }

    fun get(key: SnapshotKey, work: () -> ProgressSnapshot): ProgressSnapshot {
        made[key]?.let { return it }
        // Numbers from before a change are never shown again.
        made.keys.removeAll { it.version != key.version || it.store != key.store || it.today != key.today }
        // Ranges × periods × groups: room for every group's week, month and year and the ones before them.
        if (made.size > 80) made.clear()
        return work().also { made[key] = it }
    }
}

/** Week | Month | Year: Material 3 Expressive's connected buttons; the chosen one is ink with a ✓. */
@Composable
private fun RangePicker(selected: ProgressRange, onPick: (ProgressRange) -> Unit) {
    val c = appColors
    val all = ProgressRange.entries
    Row(
        Modifier.fillMaxWidth().padding(start = 16.dp, end = 16.dp, top = 8.dp, bottom = 8.dp).selectableGroup()
            .semantics { testTag = "progress-range" },
        horizontalArrangement = Arrangement.spacedBy(4.dp),
    ) {
        all.forEachIndexed { i, r ->
            val on = r == selected
            val shape = when {
                on -> RoundedCornerShape(50)
                i == 0 -> RoundedCornerShape(topStart = 24.dp, bottomStart = 24.dp, topEnd = 8.dp, bottomEnd = 8.dp)
                i == all.lastIndex -> RoundedCornerShape(topStart = 8.dp, bottomStart = 8.dp, topEnd = 24.dp, bottomEnd = 24.dp)
                else -> RoundedCornerShape(8.dp)
            }
            Row(
                Modifier.weight(1f).height(48.dp).clip(shape).background(if (on) c.ink else c.tonal)
                    .selectable(selected = on, role = Role.Tab, onClick = { onPick(r) })
                    .semantics { testTag = "progress-range-" + r.noun },
                horizontalArrangement = Arrangement.Center,
                verticalAlignment = Alignment.CenterVertically,
            ) {
                if (on) {
                    Icon(Icons.Rounded.Check, null, Modifier.size(18.dp), tint = c.onInk)
                    Spacer(Modifier.width(8.dp))
                }
                Text(r.title, style = AppType.labelLarge, color = if (on) c.onInk else c.ink, maxLines = 1)
            }
        }
    }
}

/** The period's dates with ‹ and ›, and "This week" under them. Opaque, the page's own colour: cards slide under it. */
@Composable
private fun PeriodBar(snap: ProgressSnapshot, move: (Int) -> Unit) {
    val c = appColors
    val noun = snap.range.noun
    val colors = IconButtonDefaults.iconButtonColors(contentColor = c.ink, disabledContentColor = c.secondary.copy(alpha = 0.45f))
    Row(Modifier.fillMaxWidth().background(c.screen).padding(horizontal = 8.dp, vertical = 4.dp), verticalAlignment = Alignment.CenterVertically) {
        IconButton({ move(-1) }, Modifier.semantics { testTag = "progress-previous" }, enabled = snap.canGoBack, colors = colors) {
            Icon(Icons.AutoMirrored.Rounded.KeyboardArrowLeft, "Previous $noun")
        }
        Column(Modifier.weight(1f), horizontalAlignment = Alignment.CenterHorizontally) {
            Text(snap.title, Modifier.semantics { testTag = "progress-period" }, maxLines = 1,
                style = MaterialTheme.typography.titleLarge.copy(fontFeatureSettings = "tnum"), color = c.ink)
            snap.caption?.let {
                Text(it, Modifier.semantics { testTag = "progress-period-caption" }, maxLines = 1,
                    style = MaterialTheme.typography.bodyMedium, color = c.secondary)
            }
        }
        IconButton({ move(1) }, Modifier.semantics { testTag = "progress-next" }, enabled = snap.canGoForward, colors = colors) {
            Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, "Next $noun")
        }
    }
}

/** The groups as choices ("All" first): they choose which habits' cards show. Nothing shows until a group exists. */
@Composable
private fun GroupChips(groups: List<HabitGroup>, selected: String?, onPick: (String) -> Unit) {
    Row(
        Modifier.fillMaxWidth().horizontalScroll(rememberScrollState()).padding(horizontal = 16.dp, vertical = 4.dp)
            .semantics { testTag = "progress-groups" },
        horizontalArrangement = Arrangement.spacedBy(8.dp),
    ) {
        ChoicePill("All", selected == null, "progress-group-all") { onPick("") }
        for (g in groups) ChoicePill(g.name, selected == g.id, "progress-group-" + tagName(g.name)) { onPick(g.id) }
    }
}

private fun tagName(name: String): String = name.trim().lowercase().replace(Regex("\\s+"), "-")

private val headlineStyle = AppType.title20Emphasized

/**
 * One habit's card: icon, name on one line, the goal; the headline and at most one more fact; the period's squares.
 * The card opens the habit; a square of a day up to today opens that day's details.
 */
@Composable
private fun HabitCard(card: ProgressWeekCard, snap: ProgressSnapshot, store: HabitStore, nav: ProgressNav, modifier: Modifier) {
    val c = appColors
    val habit = card.habit
    // From the largest text sizes, the squares give way to the words, which carry the meaning.
    val big = LocalDensity.current.fontScale >= 1.8f
    val onCell: (Int?) -> Unit = { i ->
        val d = i?.let { card.days.getOrNull(it) }
        if (d != null && d.heat != HeatCell.Blank && d.day <= snap.today) nav.openDay(habit, d.day) else nav.openHabit(habit)
    }
    val tag = (if (card.isQuit) "progress-quit-" else "progress-row-") + tagName(habit.name)
    Card(modifier.fillMaxWidth()) {
        Column(
            Modifier.fillMaxWidth()
                .clickable(onClickLabel = "Opens the habit", role = Role.Button) { nav.openHabit(habit) }
                // TalkBack: the whole card is one element that says everything (the squares are in its words).
                .clearAndSetSemantics { contentDescription = card.accessibility; testTag = tag }
                .padding(20.dp),
        ) {
            Row(verticalAlignment = Alignment.CenterVertically) {
                HabitIcon(habit.symbol, habit.color, 44.dp, CookieShape())
                Spacer(Modifier.width(16.dp))
                Column(Modifier.weight(1f)) {
                    // One line: a long name ends in "…".
                    Text(habit.name, maxLines = 1, overflow = TextOverflow.Ellipsis, color = c.ink,
                        style = AppType.bodyLarge)
                    Text(card.goal, maxLines = 1, overflow = TextOverflow.Ellipsis, color = c.secondary, style = MaterialTheme.typography.bodyMedium)
                }
                Spacer(Modifier.width(8.dp))
                Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = c.secondary)
            }
            Spacer(Modifier.height(16.dp))
            val start = card.runStart
            if (start != null) QuitRunClock(start, store.clock) else Text(card.headline, style = headlineStyle, color = c.ink)
            card.detail?.let {
                Spacer(Modifier.height(4.dp))
                Text(it, style = MaterialTheme.typography.bodyMedium.copy(fontFeatureSettings = "tnum"), color = c.secondary)
            }
            if (!big) {
                when (snap.range) {
                    ProgressRange.WEEK -> if (snap.columns.size == card.heat.size) {
                        Spacer(Modifier.height(16.dp))
                        HeatWeek(snap.columns, card.heat, habit.color, onCell)
                    }
                    ProgressRange.MONTH -> if (snap.columns.size == card.heat.size) {
                        Spacer(Modifier.height(16.dp))
                        HeatMonth(snap.monthLead, snap.letters, snap.columns.indexOfFirst { it.isToday }.takeIf { it >= 0 }, card.heat, habit.color, onCell)
                    }
                    ProgressRange.YEAR -> snap.year?.let { year ->
                        if (card.heat.size >= year.shown) {
                            Spacer(Modifier.height(16.dp))
                            HeatYear(year, card.heat, habit.color, onCell)
                        }
                    }
                }
            }
        }
    }
}

/**
 * A quit card's headline: the run going on now, "12 d 11 h current run". Only this text ticks, once a minute, on the
 * run's own minutes (S3, S4).
 */
@Composable
private fun QuitRunClock(start: Long, clock: () -> Long) {
    val c = appColors
    var now by remember(start) { mutableLongStateOf(clock()) }
    LaunchedEffect(start) {
        while (true) {
            val t = clock()
            now = t
            delay(60_000L - Math.floorMod(t - start, 60_000L))
        }
    }
    Text(
        buildAnnotatedString {
            withStyle(AppType.title20Emphasized.toSpanStyle().copy(color = c.ink)) { append(Format.run((now - start) / 1000.0)) }
            withStyle(AppType.bodyMedium.toSpanStyle().copy(color = c.secondary)) { append(" current run") }
        },
        style = headlineStyle.copy(fontFeatureSettings = "tnum"),
    )
}

/** No habit Progress can show yet (tasks never are): never a dead end. */
@Composable
private fun NoProgressYet() {
    Column(
        Modifier.fillMaxSize().padding(horizontal = 32.dp).padding(bottom = 96.dp).semantics { testTag = "progress-empty" },
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center,
    ) {
        CookieIcon(Icons.Rounded.BarChart, size = 112.dp)
        Spacer(Modifier.height(24.dp))
        Text("No progress yet", style = MaterialTheme.typography.headlineMedium, color = appColors.ink, textAlign = TextAlign.Center)
        Spacer(Modifier.height(8.dp))
        Text("Add a habit on Today and its progress shows here.", style = MaterialTheme.typography.bodyLarge,
            color = appColors.secondary, textAlign = TextAlign.Center)
    }
}
