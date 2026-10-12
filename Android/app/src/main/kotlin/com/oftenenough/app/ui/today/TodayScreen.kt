package com.oftenenough.app.ui.today

import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
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
import androidx.compose.foundation.lazy.LazyListScope
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowLeft
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowRight
import androidx.compose.material.icons.automirrored.rounded.StickyNote2
import androidx.compose.material.icons.rounded.Add
import androidx.compose.material.icons.rounded.ArrowDropDown
import androidx.compose.material.icons.rounded.Checklist
import androidx.compose.material.icons.rounded.EditCalendar
import androidx.compose.material.icons.rounded.FilterList
import androidx.compose.material.icons.rounded.Lightbulb
import androidx.compose.material.icons.rounded.Menu
import androidx.compose.material.icons.outlined.Edit
import androidx.compose.material3.DatePicker
import androidx.compose.material3.DatePickerDialog
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.SnackbarHost
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.material3.rememberDatePickerState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import com.oftenenough.app.app.Prefs
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.DaySection
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.Placement
import com.oftenenough.app.ui.components.CookieIcon
import com.oftenenough.app.ui.components.InkButton
import com.oftenenough.app.ui.components.MiniRing
import com.oftenenough.app.ui.components.PlainButton
import com.oftenenough.app.ui.components.TonalButton
import com.oftenenough.app.ui.components.segmentShape
import com.oftenenough.app.ui.theme.appColors
import java.time.Instant
import java.time.LocalDate
import java.time.ZoneOffset
import kotlinx.coroutines.delay

/** What Today's top bar and empty states open. */
interface TodayNav {
    fun openMenu()
    fun newHabit()
    fun ideas()
    fun restore()
    fun help()
    fun arrange()
    fun filter()
    fun startRoutine(part: String, day: Int, habits: List<Habit>)
}

/** "Starts 6 AM". */
fun startsText(section: DaySection): String? = section.start?.let { "Starts " + DayWords.hourShort(it) }

/** Today's day: moves on at the day's start and once a minute (the Now section), never per second (S3). */
@Composable
private fun rememberNow(store: HabitStore): Long {
    var now by remember { mutableStateOf(store.clock()) }
    LaunchedEffect(Unit) {
        while (true) {
            val t = store.clock()
            now = t
            delay(60_000 - t % 60_000)
        }
    }
    return now
}

/** The home screen: one card per time of day, with Quit or cut down and Paused (iOS TodayView). */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun TodayScreen(store: HabitStore, prefs: Prefs, nav: TodayNav, actions: TodayActions, snackbar: SnackbarHostState) {
    val c = appColors
    val now = rememberNow(store)
    val today = store.today(now)
    var shownDay by rememberSaveable { mutableStateOf<Int?>(null) }
    val day = shownDay ?: today
    val isToday = day == today
    val scope = rememberCoroutineScope()
    val layout = remember { TodayLayout(scope) }
    var calendar by remember { mutableStateOf(false) }
    LaunchedEffect(day) { layout.reset(); store.undoOffer = null }

    val hasHabits = store.habits.isNotEmpty()
    Scaffold(
        containerColor = c.screen,
        snackbarHost = { SnackbarHost(snackbar) },
        topBar = {
            TopAppBar(
                title = {},
                navigationIcon = { IconButton(nav::openMenu, Modifier.semantics { testTag = "menu-button" }) { Icon(Icons.Rounded.Menu, "Menu") } },
                actions = {
                    if (hasHabits) {
                        IconButton(nav::arrange) { Icon(Icons.Outlined.Edit, "Arrange your day") }
                        IconButton(nav::filter) { Icon(Icons.Rounded.FilterList, if (prefs.hideDoneHabits || prefs.hideDoneTasks || prefs.todayGroup.isNotEmpty()) "Filter, on" else "Filter") }
                    }
                    IconButton(nav::newHabit, Modifier.semantics { testTag = "new-habit" }) { Icon(Icons.Rounded.Add, "New habit") }
                },
                colors = TopAppBarDefaults.topAppBarColors(containerColor = c.screen, scrolledContainerColor = c.screen),
            )
        },
    ) { padding ->
        Box(Modifier.fillMaxSize().padding(top = padding.calculateTopPadding())) {
            when {
                !store.isLoaded -> {}
                !hasHabits -> NoHabitsYet(nav)
                else -> {
                    val content = remember(store.dataVersion, day, today, now / 60_000, prefs.doneOrder, prefs.hideDoneHabits, prefs.hideDoneTasks, prefs.todayGroup, layout.holding) {
                        TodayContent.make(store, day, today, now, prefs)
                    }
                    if (content.isEmpty) NothingPlanned(nav, isToday)
                    else LazyColumn(
                        Modifier.fillMaxSize().semantics { testTag = "today-list" },
                        contentPadding = PaddingValues(start = 16.dp, end = 16.dp, top = 4.dp, bottom = 132.dp),
                    ) {
                        todayItems(content, store, layout, actions, nav, prefs)
                    }
                    Column(Modifier.align(Alignment.BottomCenter).navigationBarsPadding().padding(bottom = 16.dp), horizontalAlignment = Alignment.CenterHorizontally) {
                        if (!isToday) {
                            TonalButton("Back to today", { shownDay = null }, Modifier.padding(bottom = 8.dp))
                        }
                        DayBar(store, day, today, onPrevious = { shownDay = day - 1 }, onNext = { shownDay = day + 1 }, onPick = { calendar = true })
                    }
                }
            }
        }
    }
    if (calendar) {
        val state = rememberDatePickerState(initialSelectedDateMillis = LocalDate.ofEpochDay(day.toLong()).atStartOfDay(ZoneOffset.UTC).toInstant().toEpochMilli())
        DatePickerDialog(
            onDismissRequest = { calendar = false },
            confirmButton = {
                TextButton({
                    state.selectedDateMillis?.let { ms ->
                        val picked = Instant.ofEpochMilli(ms).atZone(ZoneOffset.UTC).toLocalDate().toEpochDay().toInt()
                        shownDay = if (picked == today) null else picked
                    }
                    calendar = false
                }) { Text("Go", color = c.ink) }
            },
            dismissButton = { TextButton({ calendar = false }) { Text("Cancel", color = c.ink) } },
        ) {
            DatePicker(state, title = { Text("Go to a day", Modifier.padding(start = 24.dp, top = 16.dp)) })
        }
    }
}

/** One row on Today: a habit in one time of day. */
class TodayItem(val habit: Habit, val placement: Placement)

/** Everything Today shows for a day, worked out once per change (S5, S8), never while drawing a row. */
class TodayContent(
    val cards: List<Pair<String, List<TodayItem>>>, val restraint: List<Habit>, val paused: List<Habit>,
    val nowPart: String?, val day: Int, val today: Int, val dayNote: String?, val done: Map<String, Boolean>,
) {
    val isEmpty: Boolean get() = cards.isEmpty() && restraint.isEmpty() && paused.isEmpty()

    companion object {
        fun make(store: HabitStore, day: Int, today: Int, now: Long, prefs: Prefs): TodayContent {
            val isToday = day == today
            val rules = store.rules
            val group = prefs.todayGroup.takeIf { it.isNotEmpty() }?.let { id -> store.groups.firstOrNull { it.id == id } }
            val active = store.habits.filter { !it.archived && rules.startDay(it) <= day && (group == null || it.id in group.habits) }
            val restraint = active.filter { h ->
                if (h.kind == HabitKind.Quit) isToday && !store.isPaused(h, today)
                else h.isQuitOrLimit && rules.isDue(h, day, now, countingSkips = false)
            }
            val paused = active.filter { store.isPaused(it, day) && (it.kind != HabitKind.Quit || isToday) }
            val tracked = active.filter { !it.isQuitOrLimit && rules.isDue(it, day, now, countingSkips = false) }
            val rows = LinkedHashMap<String, MutableList<TodayItem>>()
            for (h in tracked) for (p in store.placements(h)) rows.getOrPut(p.section) { ArrayList() }.add(TodayItem(h, p))
            val done = HashMap<String, Boolean>()
            for (h in tracked) done[h.id] = store.isSkipped(h, day) || rules.isSatisfied(h, day)
            val cards = store.todayCards().mapNotNull { card ->
                if (card == DaySection.QUITTING) card to emptyList<TodayItem>() else rows[card]?.takeIf { it.isNotEmpty() }?.let { card to it }
            }.filter { (card, items) -> card == DaySection.QUITTING && restraint.isNotEmpty() || items.isNotEmpty() }
            return TodayContent(cards, restraint, paused, if (isToday) store.nowSection(now)?.id else null, day, today,
                if (day <= today) store.dayNote(day) else null, done)
        }
    }
}

private fun LazyListScope.todayItems(content: TodayContent, store: HabitStore, layout: TodayLayout, actions: TodayActions, nav: TodayNav, prefs: Prefs) {
    val day = content.day
    val today = content.today
    content.dayNote?.let { note ->
        item(key = "day-note") {
            Row(Modifier.fillMaxWidth().padding(bottom = 16.dp).clip(RoundedCornerShape(24.dp)).background(appColors.surface)
                .clickable { actions.writeNote(null, day) }.padding(16.dp)) {
                Icon(Icons.AutoMirrored.Rounded.StickyNote2, null, tint = appColors.secondary)
                Spacer(Modifier.width(12.dp))
                Text(note, style = MaterialTheme.typography.bodyMedium, color = appColors.ink)
            }
        }
    }
    for ((card, items) in content.cards) {
        if (card == DaySection.QUITTING) quitting(content.restraint, store, layout, actions, day, today)
        else section(card, items, content, store, layout, actions, nav, prefs)
    }
    if (content.paused.isNotEmpty()) {
        val open = layout.choice("paused") ?: false
        item(key = "header-paused") {
            PartHeader("Paused", null, content.paused, null, false, open, if (open) segmentShape(0, 2) else RoundedCornerShape(24.dp), null) { layout.setOpen("paused", !open) }
        }
        if (open) content.paused.forEachIndexed { i, h ->
            item(key = "paused-${h.id}") { Spacer(Modifier.height(2.dp)); PausedRow(h, segmentShape(i + 1, content.paused.size + 1), store, actions) }
        }
        item(key = "gap-paused") { Spacer(Modifier.height(16.dp)) }
    }
    if (day <= today && content.dayNote == null) {
        item(key = "add-day-note") {
            Box(Modifier.fillMaxWidth(), contentAlignment = Alignment.Center) {
                PlainButton("Note for the day", { actions.writeNote(null, day) }, color = appColors.secondary)
            }
        }
    }
}

private fun LazyListScope.section(
    card: String, items: List<TodayItem>, content: TodayContent, store: HabitStore, layout: TodayLayout, actions: TodayActions,
    nav: TodayNav, prefs: Prefs,
) {
    val day = content.day
    val isToday = day == content.today
    val isNow = card == content.nowPart
    val left = items.count { content.done[it.habit.id] != true }
    val open = layout.isOpen(card, left > 0 && (isNow || card == DaySection.ANYTIME || !isToday))
    val hides = prefs.hideDoneHabits || prefs.hideDoneTasks
    val shown = if (!hides || layout.holding) items else items.filter { item ->
        content.done[item.habit.id] != true || !(if (item.habit.kind == HabitKind.Task) prefs.hideDoneTasks else prefs.hideDoneHabits)
    }
    val fresh = if (prefs.doneOrder != "inPlace") shown.filter { content.done[it.habit.id] != true } + shown.filter { content.done[it.habit.id] == true } else shown
    val ordered = layout.order(card, fresh) { it.habit.id }
    // Every row's piece, steps included, so the corners are right.
    val pieces = ArrayList<Pair<TodayItem, String?>>()
    for (item in ordered) {
        pieces.add(item to null)
        if (item.habit.kind == HabitKind.Checklist && layout.choice("steps-${item.habit.id}") == true) item.habit.steps.forEach { pieces.add(item to it.id) }
    }
    val count = if (open) pieces.size + 1 else 1
    val section = store.section(card)
    val start: (() -> Unit)? = if (isToday && left > 0) {
        { nav.startRoutine(card, day, items.filter { content.done[it.habit.id] != true }.map { it.habit }) }
    } else null
    item(key = "header-$card") {
        PartHeader(section.name, startsText(section), items.map { it.habit }, left, isNow, open,
            if (open) segmentShape(0, count) else RoundedCornerShape(24.dp),
            onStart = start,
            onToggle = { layout.setOpen(card, !open) })
    }
    if (open) pieces.forEachIndexed { i, (item, stepId) ->
        val habit = item.habit
        item(key = "row-$card-${habit.id}-${stepId ?: ""}") {
            Spacer(Modifier.height(2.dp))
            val shape = segmentShape(i + 1, count)
            if (stepId == null) {
                val stepsKey = "steps-${habit.id}"
                HabitRow(habit, day, content.today, item.placement.slot, item.placement.times.firstOrNull(), shape, store, layout, actions,
                    stepsOpen = layout.choice(stepsKey) == true, onToggleSteps = { layout.setOpen(stepsKey, layout.choice(stepsKey) != true) })
            } else {
                habit.steps.firstOrNull { it.id == stepId }?.let { StepRow(it, habit, day, shape, store, layout) }
            }
        }
    }
    item(key = "gap-$card") { Spacer(Modifier.height(16.dp)) }
}

private fun LazyListScope.quitting(habits: List<Habit>, store: HabitStore, layout: TodayLayout, actions: TodayActions, day: Int, today: Int) {
    val open = layout.choice(DaySection.QUITTING) ?: true
    val count = if (open) habits.size + 1 else 1
    item(key = "header-quitting") {
        PartHeader("Quit or cut down", null, habits, null, false, open, if (open) segmentShape(0, count) else RoundedCornerShape(24.dp), null) {
            layout.setOpen(DaySection.QUITTING, !open)
        }
    }
    if (open) habits.forEachIndexed { i, h ->
        item(key = "quit-${h.id}") {
            Spacer(Modifier.height(2.dp))
            val shape = segmentShape(i + 1, count)
            if (h.kind == HabitKind.Quit) QuitRow(h, shape, store, layout, actions)
            else HabitRow(h, day, today, null, null, shape, store, layout, actions, false, {})
        }
    }
    item(key = "gap-quitting") { Spacer(Modifier.height(16.dp)) }
}

/**
 * The day bar: Material's floating toolbar, fixed width (it never changes as the day changes), the ring, the day ▾ and
 * the count centred as one group; ‹ and › at its ends (the user, 12 Oct 2026).
 */
@Composable
fun DayBar(store: HabitStore, day: Int, today: Int, onPrevious: () -> Unit, onNext: () -> Unit, onPick: () -> Unit) {
    val c = appColors
    val score = remember(store.dataVersion, day, today) { store.daySummary(day) }
    val label = when (day) { today -> "Today"; today - 1 -> "Yesterday"; today + 1 -> "Tomorrow"; else -> DayWords.short(day) }
    Surface(
        modifier = Modifier.width(320.dp).height(64.dp).shadow(8.dp, RoundedCornerShape(32.dp)).semantics { testTag = "day-bar" },
        shape = RoundedCornerShape(32.dp), color = c.surface, border = BorderStroke(0.5.dp, c.tonal),
    ) {
        Row(Modifier.padding(horizontal = 8.dp), verticalAlignment = Alignment.CenterVertically) {
            IconButton(onPrevious, Modifier.size(48.dp)) { Icon(Icons.AutoMirrored.Rounded.KeyboardArrowLeft, "Previous day", tint = c.ink) }
            Row(Modifier.weight(1f).clip(RoundedCornerShape(24.dp)).clickable(onClick = onPick).padding(vertical = 8.dp)
                .semantics(mergeDescendants = true) { contentDescription = "$label, ${score.done} of ${score.planned} done. Go to a day" },
                horizontalArrangement = Arrangement.Center, verticalAlignment = Alignment.CenterVertically) {
                MiniRing(score.fraction.toFloat(), c.ink, c.tonal)
                Spacer(Modifier.width(8.dp))
                Text(label, style = MaterialTheme.typography.titleMedium.copy(fontWeight = FontWeight.Medium), color = c.ink, maxLines = 1)
                Icon(Icons.Rounded.ArrowDropDown, null, tint = c.ink)
                if (score.planned > 0) {
                    Spacer(Modifier.width(4.dp))
                    Text("${score.done}/${score.planned}", style = MaterialTheme.typography.bodyLarge.copy(fontFeatureSettings = "tnum"), color = c.secondary)
                }
            }
            IconButton(onNext, Modifier.size(48.dp)) { Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, "Next day", tint = c.ink) }
        }
    }
}

/** No habits yet: never a dead end (onboarding report §4). */
@Composable
private fun NoHabitsYet(nav: TodayNav) {
    Column(Modifier.fillMaxSize().padding(horizontal = 32.dp), horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.Center) {
        CookieIcon(Icons.Rounded.Checklist, size = 112.dp)
        Spacer(Modifier.height(24.dp))
        Text("No habits yet", style = MaterialTheme.typography.headlineMedium, color = appColors.ink)
        Spacer(Modifier.height(8.dp))
        Text("Add something you'd like to do often enough, or start from an idea.", style = MaterialTheme.typography.bodyLarge,
            color = appColors.secondary, textAlign = TextAlign.Center)
        Spacer(Modifier.height(24.dp))
        InkButton("New habit", nav::newHabit, icon = Icons.Rounded.Add, height = 48.dp)
        Spacer(Modifier.height(8.dp))
        TonalButton("Start from an idea", nav::ideas, icon = Icons.Rounded.Lightbulb)
        Spacer(Modifier.height(24.dp))
        PlainButton("Restore from a backup", nav::restore)
        PlainButton("How it works", nav::help)
    }
}

/** Habits exist, none on this day: neutral words, never "missed" or "no habits due" (U3, Current Work 106). */
@Composable
private fun NothingPlanned(nav: TodayNav, isToday: Boolean) {
    Column(Modifier.fillMaxSize().padding(horizontal = 32.dp).padding(bottom = 96.dp), horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.Center) {
        CookieIcon(Icons.Rounded.EditCalendar, size = 112.dp)
        Spacer(Modifier.height(24.dp))
        Text(if (isToday) "Nothing planned today" else "Nothing planned this day", style = MaterialTheme.typography.headlineMedium, color = appColors.ink, textAlign = TextAlign.Center)
        Spacer(Modifier.height(8.dp))
        Text("Your habits are planned for other days. Each one shows on its own days.", style = MaterialTheme.typography.bodyLarge,
            color = appColors.secondary, textAlign = TextAlign.Center)
        Spacer(Modifier.height(24.dp))
        TonalButton("New habit", nav::newHabit, icon = Icons.Rounded.Add)
    }
}
