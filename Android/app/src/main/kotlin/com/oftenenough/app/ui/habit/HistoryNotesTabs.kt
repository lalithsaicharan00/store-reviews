package com.oftenenough.app.ui.habit

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyListScope
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowRight
import androidx.compose.material.icons.automirrored.rounded.StickyNote2
import androidx.compose.material.icons.outlined.CalendarMonth
import androidx.compose.material.icons.rounded.Add
import androidx.compose.material.icons.rounded.Close
import androidx.compose.material.icons.rounded.ExpandLess
import androidx.compose.material.icons.rounded.ExpandMore
import androidx.compose.material.icons.rounded.Search
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.stateDescription
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HistoryDay
import com.oftenenough.app.data.HistoryMonth
import com.oftenenough.app.data.NoteItem
import com.oftenenough.app.data.NoteMonth
import com.oftenenough.app.data.dayKey
import com.oftenenough.app.ui.components.TonalButton
import com.oftenenough.app.ui.components.segmentShape
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.delay

// Habit details' History and Notes tabs (the iPhone's HabitPageParts.swift and HabitNotesTab.swift): actions first, then
// one card per month, newest first, each folding from its header (the newest two start open). Each month's rows are
// worked out once per data change by the screen (`HabitPageModel`), never while drawing (Rulebook S5, S8); every row is
// its own lazy item with a stable key.

/** A segmented piece in the page's list: the side margins, 2 dp from the piece above, 16 dp under a group's last. */
internal fun Modifier.pagePiece(index: Int, count: Int): Modifier =
    padding(horizontal = 16.dp).padding(top = if (index == 0) 0.dp else 2.dp, bottom = if (index == count - 1) 16.dp else 0.dp)

/** One item of the page's list: the side margins and the gap under it. */
internal fun Modifier.pageItem(): Modifier = padding(horizontal = 16.dp).padding(bottom = 16.dp)

/** A month's header: its name and how it went (or how many notes), folding the month (an accordion's chevron). */
@Composable
internal fun FoldHeader(title: String, summary: String, open: Boolean, count: Int, tag: String, onToggle: () -> Unit) {
    val c = appColors
    Row(
        Modifier.pagePiece(0, count).fillMaxWidth().clip(segmentShape(0, count)).background(c.surface)
            .clickable(onClickLabel = if (open) "Fold the month" else "Show the month", onClick = onToggle)
            .padding(16.dp)
            .semantics(mergeDescendants = true) {
                stateDescription = if (open) "Open" else "Folded"
                testTag = tag
            },
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Column(Modifier.weight(1f)) {
            Text(title, style = MaterialTheme.typography.titleLarge, color = c.ink)
            if (summary.isNotEmpty()) Text(summary, style = MaterialTheme.typography.bodyMedium, color = c.secondary)
        }
        Icon(if (open) Icons.Rounded.ExpandLess else Icons.Rounded.ExpandMore, null, tint = c.ink)
    }
}

/** A plain card with one line of text (an empty tab). */
@Composable
internal fun MessageCard(title: String?, text: String, tag: String) {
    val c = appColors
    Column(
        Modifier.pageItem().fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.surface).padding(16.dp)
            .semantics(mergeDescendants = true) { testTag = tag },
        verticalArrangement = Arrangement.spacedBy(4.dp),
    ) {
        if (title != null) Text(title, style = MaterialTheme.typography.titleMedium, color = c.ink)
        Text(text, style = MaterialTheme.typography.bodyMedium, color = c.secondary)
    }
}

// ------------------------------------------------------------------------------------------------------------ History

/** History: Add (named per kind, U21) and Go to date, the key, then a card per month with a row per day. */
internal fun LazyListScope.historyItems(
    color: HabitColor, months: List<HistoryMonth>, addLabel: String, toggled: Set<Int>, keyOpen: Boolean,
    onToggleKey: () -> Unit, onToggleMonth: (Int) -> Unit, onAdd: () -> Unit, onGoToDate: () -> Unit, onOpenDay: (Int) -> Unit,
) {
    item(key = "history-actions") {
        Row(Modifier.pageItem(), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
            // An archived habit has nothing to log (Habits, Figma 6.6): no Add.
            if (addLabel.isNotEmpty()) TonalButton(addLabel, onAdd, Modifier.semantics { testTag = "history-add-log" }, icon = Icons.Rounded.Add)
            TonalButton("Go to date", onGoToDate, Modifier.semantics { testTag = "history-go-to-date" }, icon = Icons.Outlined.CalendarMonth)
        }
    }
    item(key = "history-key") { HeatKeyCard(keyOpen, onToggleKey, Modifier.pageItem()) }
    if (months.isEmpty()) {
        item(key = "history-empty") { MessageCard(null, "Nothing recorded yet. Days appear here once they're planned or logged.", "history-empty") }
    }
    months.forEachIndexed { index, month ->
        val open = (index < 2) != (month.first in toggled)
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

/** One day: its square, the date (with Today or Yesterday), what was recorded, a note mark, and a chevron. */
@Composable
private fun HistoryDayRow(day: HistoryDay, color: HabitColor, index: Int, count: Int, onOpen: () -> Unit) {
    val c = appColors
    Row(
        Modifier.pagePiece(index, count).fillMaxWidth().clip(segmentShape(index, count)).background(c.surface)
            .clickable(onClickLabel = "Open the day", onClick = onOpen)
            .heightIn(min = 56.dp).padding(horizontal = 16.dp, vertical = 12.dp)
            .semantics(mergeDescendants = true) { testTag = "habit-day-" + dayKey(day.day) },
        verticalAlignment = Alignment.CenterVertically,
    ) {
        HeatSquare(day.heat, color, HeatSize.smallest, isToday = day.relative == "Today")
        Spacer(Modifier.width(16.dp))
        Column(Modifier.weight(1f)) {
            Row(verticalAlignment = Alignment.CenterVertically) {
                Text(day.title, style = MaterialTheme.typography.bodyLarge, color = c.ink)
                if (day.relative != null) {
                    Spacer(Modifier.width(6.dp))
                    Text(day.relative, style = MaterialTheme.typography.bodyMedium, color = c.secondary)
                }
            }
            Text(day.detail, style = MaterialTheme.typography.bodyMedium, color = c.secondary, maxLines = 2, overflow = TextOverflow.Ellipsis)
        }
        if (day.hasNote) {
            Icon(Icons.AutoMirrored.Rounded.StickyNote2, "Has a note", Modifier.size(20.dp), tint = c.secondary)
            Spacer(Modifier.width(8.dp))
        }
        Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = c.secondary)
    }
}

// ------------------------------------------------------------------------------------------------------------ Notes

/** Notes: search across the full width (only while there's something to search), Add note, then a card per month. */
internal fun LazyListScope.notesItems(
    months: List<NoteMonth>, shown: List<NoteMonth>, query: String, toggled: Set<Int>,
    onQuery: (String) -> Unit, onToggleMonth: (Int) -> Unit, onAdd: () -> Unit, onOpen: (Int) -> Unit,
) {
    item(key = "notes-actions") {
        Column(Modifier.pageItem(), verticalArrangement = Arrangement.spacedBy(16.dp)) {
            if (months.isNotEmpty()) NoteSearchField(onQuery)
            TonalButton("Add note", onAdd, Modifier.semantics { testTag = "notes-add" }, icon = Icons.Rounded.Add)
        }
    }
    if (months.isEmpty()) {
        item(key = "notes-empty") {
            MessageCard("No notes yet", "Add context to any day of this habit: what helped, what got in the way. Notes never change your progress.", "notes-empty")
        }
    } else if (shown.isEmpty()) {
        item(key = "notes-none") { MessageCard(null, "No notes match “${query.trim()}”.", "notes-no-match") }
    }
    val searching = query.isNotBlank()
    shown.forEachIndexed { index, month ->
        val open = searching || ((index < 2) != (month.first in toggled))
        val count = if (open) month.notes.size + 1 else 1
        item(key = month.key) {
            FoldHeader(month.title, month.summary, open, count, "notes-month-" + dayKey(month.first)) { onToggleMonth(month.first) }
        }
        if (open) {
            itemsIndexed(month.notes, key = { _, n -> month.key + "-" + n.day }) { i, n -> NoteRow(n, i + 1, count) { onOpen(n.day) } }
        }
    }
}

/** A day's note: its date as History writes it, then the note's first lines, opening the note to read in full. */
@Composable
private fun NoteRow(note: NoteItem, index: Int, count: Int, onOpen: () -> Unit) {
    val c = appColors
    Row(
        Modifier.pagePiece(index, count).fillMaxWidth().clip(segmentShape(index, count)).background(c.surface)
            .clickable(onClickLabel = "Open the note", onClick = onOpen)
            .heightIn(min = 56.dp).padding(horizontal = 16.dp, vertical = 12.dp)
            .semantics(mergeDescendants = true) { testTag = "note-" + dayKey(note.day) },
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Column(Modifier.weight(1f)) {
            Row(verticalAlignment = Alignment.CenterVertically) {
                Text(note.title, style = MaterialTheme.typography.bodyLarge, color = c.ink)
                if (note.relative != null) {
                    Spacer(Modifier.width(6.dp))
                    Text(note.relative, style = MaterialTheme.typography.bodyMedium, color = c.secondary)
                }
            }
            Text(note.text, style = MaterialTheme.typography.bodyMedium, color = c.secondary, maxLines = 2, overflow = TextOverflow.Ellipsis)
        }
        Spacer(Modifier.width(8.dp))
        Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = c.secondary)
    }
}

/** A search field for one habit's notes. Its text lives here; the list hears it once typing pauses, 0.3 s (S11). */
@Composable
private fun NoteSearchField(onChange: (String) -> Unit) {
    val c = appColors
    var text by rememberSaveable { mutableStateOf("") }
    LaunchedEffect(text) {
        delay(300)
        onChange(text)
    }
    Row(
        Modifier.fillMaxWidth().heightIn(min = 56.dp).clip(RoundedCornerShape(28.dp)).background(c.tonal).padding(start = 20.dp, end = 8.dp),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Icon(Icons.Rounded.Search, null, tint = c.ink)
        Spacer(Modifier.width(16.dp))
        Box(Modifier.weight(1f), contentAlignment = Alignment.CenterStart) {
            if (text.isEmpty()) Text("Search notes", style = MaterialTheme.typography.bodyLarge, color = c.secondary)
            BasicTextField(
                value = text,
                onValueChange = { text = it },
                modifier = Modifier.fillMaxWidth().semantics { testTag = "notes-search" },
                singleLine = true,
                textStyle = MaterialTheme.typography.bodyLarge.copy(color = c.ink),
                cursorBrush = SolidColor(c.ink),
                keyboardOptions = KeyboardOptions(imeAction = ImeAction.Search),
            )
        }
        if (text.isNotEmpty()) {
            IconButton({ text = "" }) { Icon(Icons.Rounded.Close, "Clear search", tint = c.secondary) }
        } else Spacer(Modifier.width(12.dp))
    }
}
