package com.oftenenough.app.ui.habit

import com.oftenenough.app.ui.components.DayCell
import com.oftenenough.app.ui.components.DayCellSize
import com.oftenenough.app.ui.components.ListNote
import com.oftenenough.app.ui.components.ListChevron
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.AppAssistChip
import com.oftenenough.app.ui.components.AppFilterChip
import com.oftenenough.app.ui.components.SearchBarButton
import com.oftenenough.app.ui.components.SearchHeader
import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ExperimentalLayoutApi
import androidx.compose.foundation.layout.FlowRow
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.imePadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyListScope
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.DatePicker
import androidx.compose.material3.DatePickerDialog
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.SelectableDates
import androidx.compose.material3.Text
import androidx.compose.material3.rememberDatePickerState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.stateDescription
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.AnnotatedString
import androidx.compose.ui.text.SpanStyle
import androidx.compose.ui.text.buildAnnotatedString
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.withStyle
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HistoryDay
import com.oftenenough.app.data.HistoryMonth
import com.oftenenough.app.data.dayKey
import com.oftenenough.app.data.pageDayDate
import com.oftenenough.app.ui.components.CookieShape
import com.oftenenough.app.ui.components.segmentShape
import com.oftenenough.app.ui.record.dayToUtcMs
import com.oftenenough.app.ui.record.utcMsToDay
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.delay

// Habit details' History (Figma 1373:2, 2.1–2.17; the iPhone's HabitPageParts.swift): every day from the start, newest
// first, each with what was logged and its note under it (Notes folds into History, 19 Oct 2026). Search notes, All or
// With notes, and Go to date come first; one card per month, folding from its header (the newest two start open). Each
// month's rows are worked out once per data change by the screen (`HabitPageModel`), never while drawing (Rulebook S5,
// S8); every row is its own lazy item with a stable key.

/** A segmented piece in the page's list: the side margins, 2 dp from the piece above, 16 dp under a group's last. */
internal fun Modifier.pagePiece(index: Int, count: Int): Modifier =
    padding(horizontal = 16.dp).padding(top = if (index == 0) 0.dp else 2.dp, bottom = if (index == count - 1) 16.dp else 0.dp)

/** One item of the page's list: the side margins and the gap under it. */
internal fun Modifier.pageItem(): Modifier = padding(horizontal = 16.dp).padding(bottom = 16.dp)

/** What History lists: every day, or only the days with a note (Figma 2.4). */
enum class HistoryFilter { ALL, NOTES }

/** The months History shows under [filter]: With notes keeps the days that have one, each month counting its notes. */
fun historyShown(months: List<HistoryMonth>, filter: HistoryFilter): List<HistoryMonth> =
    if (filter == HistoryFilter.ALL) months
    else months.mapNotNull { m ->
        val days = m.days.filter { it.hasNote }
        if (days.isEmpty()) null else m.copy(summary = if (days.size == 1) "1 note" else "${days.size} notes", days = days)
    }

/** Whether month [index] of the list is open: the newest two start open; a tap on the header turns that around. */
fun historyMonthOpen(index: Int, month: HistoryMonth, toggled: Set<Int>): Boolean = (index < 2) != (month.first in toggled)

/**
 * Where [day]'s row is among History's items (counted from History's first item, the search field), or the nearest
 * older row of its month, or the month's header: Go to date scrolls there (Figma 2.7). [toggled] must already open it.
 */
fun historyIndexOf(day: Int, shown: List<HistoryMonth>, toggled: Set<Int>): Int? {
    var index = 2 // the search field and the chips
    shown.forEachIndexed { i, m ->
        val open = historyMonthOpen(i, m, toggled)
        if (day >= m.first && (i == 0 || day < shown[i - 1].first)) {
            if (!open) return index
            val row = m.days.indexOfFirst { it.day <= day }
            return index + 1 + (if (row < 0) maxOf(m.days.size - 1, 0) else row)
        }
        index += 1 + (if (open) m.days.size else 0)
    }
    return null
}

/** A month's header: its name and how it went (or how many notes), folding the month (an accordion's chevron). */
@Composable
internal fun FoldHeader(title: String, summary: String, open: Boolean, count: Int, tag: String, onToggle: () -> Unit) {
    val c = appColors
    Row(
        Modifier.pagePiece(0, count).fillMaxWidth().clip(segmentShape(0, count)).background(c.surface)
            .clickable(onClickLabel = if (open) "Fold the month" else "Show the month", onClick = onToggle)
            .padding(start = 20.dp, end = 16.dp, top = 16.dp, bottom = 16.dp)
            .semantics(mergeDescendants = true) {
                stateDescription = if (open) "Open" else "Folded"
                testTag = tag
            },
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Column(Modifier.weight(1f)) {
            Text(title, style = AppType.titleMedium, color = c.ink)
            if (summary.isNotEmpty()) Text(summary, style = AppType.bodyMedium, color = c.secondary)
        }
        Icon(if (open) Symbols.ExpandLess else Symbols.ExpandMore, null, tint = c.ink)
    }
}

/** A plain card with a line of text. */
@Composable
internal fun MessageCard(title: String?, text: String, tag: String) {
    val c = appColors
    Column(
        Modifier.pageItem().fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.surface).padding(16.dp)
            .semantics(mergeDescendants = true) { testTag = tag },
        verticalArrangement = Arrangement.spacedBy(4.dp),
    ) {
        if (title != null) Text(title, style = AppType.titleMedium, color = c.ink)
        Text(text, style = AppType.bodyMedium, color = c.secondary)
    }
}

/**
 * History's items: Search notes, the chips (All, With notes, Go to date), then a card per month with a row per day; or
 * Nothing here yet (Figma 2.8) when no day has anything yet.
 */
internal fun LazyListScope.historyItems(
    color: HabitColor, months: List<HistoryMonth>, filter: HistoryFilter, toggled: Set<Int>,
    onSearch: () -> Unit, onFilter: (HistoryFilter) -> Unit, onGoToDate: () -> Unit, onToggleMonth: (Int) -> Unit, onOpenDay: (Int) -> Unit,
) {
    if (months.isEmpty()) {
        item(key = "history-empty") { NothingYet() }
        return
    }
    item(key = "history-search") { SearchBarButton("Search notes", onSearch, Modifier.pageItem().semantics { testTag = "history-search" }) }
    item(key = "history-chips") { HistoryChips(filter, onFilter, onGoToDate) }
    val shown = historyShown(months, filter)
    if (shown.isEmpty()) {
        item(key = "history-no-notes") { MessageCard("No notes yet", "A note can go on any day: Add, then the day.", "history-no-notes") }
    }
    shown.forEachIndexed { index, month ->
        val open = historyMonthOpen(index, month, toggled)
        val count = if (open) month.days.size + 1 else 1
        item(key = month.key) {
            FoldHeader(month.title, month.summary, open, count, "history-month-" + dayKey(month.first)) { onToggleMonth(month.first) }
        }
        if (open) {
            itemsIndexed(month.days, key = { _, d -> month.key + "-" + d.day }) { i, d ->
                HistoryDayRow(d, color, i + 1, count) { onOpenDay(d.day) }
            }
        }
    }
}

/** All · With notes · Go to date (Figma 2.1, 2.4): the first two choose what's listed, the last scrolls to a day. */
@OptIn(ExperimentalLayoutApi::class)
@Composable
private fun HistoryChips(filter: HistoryFilter, onFilter: (HistoryFilter) -> Unit, onGoToDate: () -> Unit) {
    FlowRow(Modifier.pageItem().fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(8.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
        AppFilterChip("All", filter == HistoryFilter.ALL, { onFilter(HistoryFilter.ALL) }, tag = "history-all")
        AppFilterChip("With notes", filter == HistoryFilter.NOTES, { onFilter(HistoryFilter.NOTES) }, tag = "history-with-notes")
        AppAssistChip("Go to date", onGoToDate, tag = "history-go-to-date")
    }
}

/** One day (List item, 2.4, Show note): its square, the date (with Today or Yesterday), what was recorded, its note, ›. */
@Composable
private fun HistoryDayRow(day: HistoryDay, color: HabitColor, index: Int, count: Int, title: String = day.title, query: String? = null, onOpen: () -> Unit) =
    AppListItem(
        title, index, count, Modifier.pagePiece(index, count).semantics(mergeDescendants = true) {}, day.detail,
        leading = { DayCell(day.heat, color, size = DayCellSize.year, isToday = day.relative == "Today") },
        beside = day.relative?.let { { Text(it, style = AppType.bodyMedium, color = appColors.secondary) } },
        below = day.note?.let { { ListNote(if (query != null) highlighted(it, query) else AnnotatedString(it)) } },
        trailing = { ListChevron() }, onClick = onOpen, tag = "habit-day-" + dayKey(day.day),
    )

/** [text] with every match of [query] in Medium (Figma 2.5: "glasses", "glass"). */
private fun highlighted(text: String, query: String): AnnotatedString = buildAnnotatedString {
    val q = query.trim()
    if (q.isEmpty()) { append(text); return@buildAnnotatedString }
    var at = 0
    while (true) {
        val found = text.indexOf(q, at, ignoreCase = true)
        if (found < 0) { append(text.substring(at)); break }
        append(text.substring(at, found))
        withStyle(SpanStyle(fontWeight = FontWeight.Bold)) { append(text.substring(found, found + q.length)) }
        at = found + q.length
    }
}

/** Nothing here yet (Figma 2.8): a habit with no logs and no notes. */
@Composable
private fun NothingYet() {
    val c = appColors
    Column(
        Modifier.fillMaxWidth().padding(horizontal = 32.dp, vertical = 16.dp).semantics(mergeDescendants = true) { testTag = "history-empty" },
        horizontalAlignment = Alignment.CenterHorizontally,
    ) {
        Box(Modifier.size(112.dp).clip(CookieShape()).background(c.tonal), contentAlignment = Alignment.Center) {
            Icon(Symbols.History, null, Modifier.size(40.dp), tint = c.ink)
        }
        Spacer(Modifier.height(24.dp))
        Text("Nothing here yet", Modifier.semantics { heading() }, style = AppType.headlineSmall, color = c.ink, textAlign = TextAlign.Center)
        Spacer(Modifier.height(8.dp))
        Text("Each day you log or write a note shows here, newest first. Add opens any day.",
            style = AppType.bodyMedium, color = c.secondary, textAlign = TextAlign.Center)
    }
}

// ------------------------------------------------------------------------------------------------------------ Search

/**
 * Search notes (Figma 2.5, 2.6): the search bar takes the page; the days whose note has the words, newest first, with
 * the words in bold; a row opens its day. Back closes it. The field's text lives here; the list follows once typing
 * pauses, 0.3 s (S11).
 */
@Composable
internal fun HistorySearchPage(months: List<HistoryMonth>, color: HabitColor, today: Int, onBack: () -> Unit, onOpenDay: (Int) -> Unit) {
    BackHandler(onBack = onBack)
    val c = appColors
    var text by rememberSaveable { mutableStateOf("") }
    var query by remember { mutableStateOf("") }
    LaunchedEffect(text) {
        delay(300)
        query = text
    }
    val found = remember(months, query) {
        val q = query.trim()
        if (q.isEmpty()) emptyList() else months.flatMap { m -> m.days.filter { it.note?.contains(q, ignoreCase = true) == true } }
    }
    Column(Modifier.fillMaxSize().background(c.screen).semantics { testTag = "history-search-page" }) {
        SearchHeader(text, { text = it; if (it.isEmpty()) query = "" }, onBack, "Search notes",
            fieldTag = "notes-search", backTag = "search-back", clearTag = "search-clear", clearLabel = "Clear search")
        val q = query.trim()
        when {
            q.isEmpty() -> {}
            found.isEmpty() -> Column(
                Modifier.fillMaxWidth().padding(horizontal = 32.dp, vertical = 64.dp).semantics(mergeDescendants = true) { testTag = "search-nothing" },
                horizontalAlignment = Alignment.CenterHorizontally,
            ) {
                Text("No notes with “$q”", style = AppType.titleMedium, color = c.ink, textAlign = TextAlign.Center)
                Spacer(Modifier.height(8.dp))
                Text("Search looks through this habit's notes.", style = AppType.bodyMedium, color = c.secondary, textAlign = TextAlign.Center)
            }
            else -> LazyColumn(Modifier.fillMaxWidth().weight(1f).imePadding().semantics { testTag = "search-results" }) {
                item(key = "count") {
                    Text(if (found.size == 1) "1 note" else "${found.size} notes", Modifier.padding(start = 32.dp, top = 16.dp, bottom = 12.dp),
                        style = AppType.bodyMedium, color = c.secondary)
                }
                itemsIndexed(found, key = { _, d -> "found-" + d.day }) { i, d ->
                    HistoryDayRow(d, color, i, found.size, title = pageDayDate(d.day), query = q) { onOpenDay(d.day) }
                }
            }
        }
    }
}

// ------------------------------------------------------------------------------------------------------------ Add

/**
 * Add, step by step (Figma 2.11–2.17): "Add to which day?", any day from the start to today; Open shows that day's
 * details, where +1, Log manually and Add a note… are. Nothing is added here: Cancel goes back with nothing changed.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
internal fun AddToWhichDay(name: String, first: Int, today: Int, onDismiss: () -> Unit, onOpen: (Int) -> Unit) {
    val c = appColors
    val state = rememberDatePickerState(initialSelectedDateMillis = dayToUtcMs(today), selectableDates = object : SelectableDates {
        override fun isSelectableDate(utcTimeMillis: Long) = utcMsToDay(utcTimeMillis) in first..today
    })
    val picked = state.selectedDateMillis?.let(::utcMsToDay)
    DatePickerDialog(onDismiss, confirmButton = {
        AppButton(picked?.let { "Open " + pageDayDate(it) } ?: "Open", { picked?.let(onOpen); onDismiss() }, Modifier.semantics { testTag = "add-day-open" }, enabled = picked != null, style = ButtonStyle.Text)
    }, dismissButton = { AppButton("Cancel", onDismiss, Modifier.semantics { testTag = "add-day-cancel" }, style = ButtonStyle.Text) }) {
        DatePicker(state, showModeToggle = false,
            title = {
                Column(Modifier.padding(start = 24.dp, end = 24.dp, top = 24.dp, bottom = 8.dp).semantics(mergeDescendants = true) { testTag = "add-day" }) {
                    Text("Add to which day?", Modifier.semantics { heading() }, style = AppType.headlineSmall, color = c.ink)
                    Spacer(Modifier.height(8.dp))
                    Text("Choose a day to log $name or add a note.", style = AppType.bodyMedium, color = c.secondary)
                }
            },
            headline = null)
    }
}
