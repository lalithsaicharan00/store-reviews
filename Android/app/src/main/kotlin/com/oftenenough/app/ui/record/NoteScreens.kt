package com.oftenenough.app.ui.record

import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.AppAssistChip
import com.oftenenough.app.ui.theme.AppType

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.imePadding
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.AlertDialog
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
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.input.KeyboardCapitalization
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.TextLimit
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.data.noteDayLine
import com.oftenenough.app.ui.theme.appColors

/**
 * A note for one habit's day ([habitId]), or the day's own note (null) (Figma 15–15.4.3): Add note when there's none,
 * the Note view when there is (Delete note | Edit), and Edit note (✕ only, never ‹ and ✕ together: Current Work 104).
 * A new note's date is an assist chip that opens the date picker (today and earlier); a day that already has a note says
 * so and opens it for changing. Save is off until something is typed; closing with something typed asks first (D7).
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun NoteScreen(habitId: String?, startDay: Int, store: HabitStore, onDone: () -> Unit) {
    val c = appColors
    val habit = habitId?.let { store.habit(it) }
    val today = store.today()
    var day by rememberSaveable { mutableStateOf(startDay) }
    fun noteOf(d: Int) = if (habit != null) store.note(habit, d) else store.dayNote(d)
    val opened = remember { noteOf(startDay) }
    val saved = noteOf(day)
    var editing by rememberSaveable { mutableStateOf(opened == null) }
    // A new note whose day already has one (chosen with the chip): that note is changed (Figma 15.3).
    val adding = opened == null
    var text by rememberSaveable(editing) { mutableStateOf(saved ?: "") }
    // Another day chosen: its note, if it has one, is the one being written (Figma 15.3); otherwise the typing stays.
    var shownDay by rememberSaveable { mutableStateOf(startDay) }
    if (shownDay != day) { shownDay = day; noteOf(day)?.let { text = it } }
    var discard by remember { mutableStateOf(false) }
    var confirmDelete by remember { mutableStateOf(false) }
    var pickDay by remember { mutableStateOf(false) }
    // Saved and leaving: the screen keeps what it showed while it slides away.
    var leaving by remember { mutableStateOf(false) }
    val focus = remember { FocusRequester() }
    val changed = text.trim() != (saved ?: "").trim()
    fun close() { if (editing && changed && text.isNotBlank()) discard = true else if (editing && !adding) editing = false else onDone() }
    fun save(value: String) { if (habit != null) store.setNote(value, habit, day) else store.setDayNote(value, day) }
    BackHandler { close() }
    LaunchedEffect(editing, day) { if (editing) runCatching { focus.requestFocus() } }

    val title = when { !editing -> "Note"; adding -> "Add note"; else -> "Edit note" }
    val shortDay = DayWords.short(day).replace(",", "")
    Column(Modifier.fillMaxSize().background(c.screen).imePadding().navigationBarsPadding()) {
        RecordTopBar(title, close = editing, onClose = ::close)
        Column(Modifier.weight(1f).padding(start = 16.dp, end = 16.dp, top = 8.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
            // A habit's note, read (Habit details, Figma 1373:2, 2.9): the day as its title, then the habit and how the day went.
            if (!editing && habit != null) {
                Column(Modifier.padding(horizontal = 4.dp).padding(bottom = 8.dp)) {
                    Text(DayWords.date(day).format(java.time.format.DateTimeFormatter.ofPattern("EEEE, d MMMM", java.util.Locale.ENGLISH)),
                        Modifier.semantics { testTag = "note-day" }, style = AppType.headlineSmall, color = c.ink)
                    Spacer(Modifier.height(8.dp))
                    Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                        HabitIcon(habit.symbol, habit.color, size = 20.dp)
                        Text(habit.name + " · " + store.noteDayLine(habit, day), style = AppType.bodyMedium, color = c.secondary)
                    }
                }
            } else {
                // The habit and the day (Figma: 40 high, 16 in): its icon in a 24 circle, the name, then the date.
                Row(Modifier.fillMaxWidth().heightIn(min = 40.dp).padding(horizontal = 16.dp), verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    if (habit != null) HabitIcon(habit.symbol, habit.color, size = 24.dp)
                    else Icon(Symbols.CalendarToday, null, tint = c.secondary, modifier = Modifier.size(24.dp))
                    Text(habit?.name ?: "This day", Modifier.weight(1f), style = AppType.titleMedium, color = c.ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
                    if (editing && adding) {
                        AppAssistChip(DayWords.withDate(day, today), { pickDay = true }, tag = "note-date")
                    } else Text(DayWords.withDate(day, today), style = AppType.bodyMedium, color = c.secondary, maxLines = 1)
                }
            }
            if (editing && adding && saved != null && !leaving) {
                Text("$shortDay already has a note; you're changing it.", Modifier.padding(horizontal = 16.dp), style = AppType.bodySmall, color = c.secondary)
            }
            if (editing) {
                Box(Modifier.weight(1f).fillMaxWidth().clip(RoundedCornerShape(20.dp)).background(c.surface).padding(16.dp)) {
                    BasicTextField(text, { text = it.take(TextLimit.NOTE) },
                        textStyle = AppType.bodyLarge.copy(color = c.ink),
                        keyboardOptions = KeyboardOptions(capitalization = KeyboardCapitalization.Sentences),
                        cursorBrush = SolidColor(c.ink),
                        modifier = Modifier.fillMaxSize().focusRequester(focus).semantics { testTag = "note-field" },
                        decorationBox = { inner -> Box { if (text.isEmpty()) Text("Write a note", style = AppType.bodyLarge, color = c.secondary); inner() } })
                }
            } else {
                Box(Modifier.fillMaxWidth().clip(RoundedCornerShape(20.dp)).background(c.surface).padding(16.dp)) {
                    Text(saved ?: "", Modifier.verticalScroll(rememberScrollState()).semantics { testTag = "note-text" }, style = AppType.bodyLarge, color = c.ink)
                }
            }
            TextLimit.note(text, TextLimit.NOTE)?.takeIf { editing }?.let { Footer(it) }
        }
        if (editing) BottomAction("Save", leaving || (text.isNotBlank() && changed), tag = "note-save") {
            if (leaving) return@BottomAction
            if (adding) leaving = true
            save(text)
            if (adding) onDone() else editing = false
        } else DeleteEditBar("note", "note-delete", "note-edit", { confirmDelete = true }, { editing = true })
    }
    if (discard) DiscardDialog(if (adding) "Discard this note?" else "Discard your changes to this note?", { discard = false }, {
        discard = false
        if (adding) onDone() else editing = false
    }, keepLabel = if (adding) "Keep writing" else "Keep editing")
    if (confirmDelete) AlertDialog({ confirmDelete = false }, title = { Text("Delete this note?") },
        text = { Text("Only the note for $shortDay is removed. That day's progress stays.") },
        confirmButton = { AppButton("Delete note", { confirmDelete = false; save(""); onDone() }, Modifier.semantics { testTag = "note-delete-confirm" }, style = ButtonStyle.Text, destructive = true) },
        dismissButton = { AppButton("Cancel", { confirmDelete = false }, style = ButtonStyle.Text) })
    if (pickDay) {
        val first = habit?.let { store.rules.startDay(it) } ?: Int.MIN_VALUE
        val state = rememberDatePickerState(initialSelectedDateMillis = dayToUtcMs(day), selectableDates = object : SelectableDates {
            override fun isSelectableDate(utcTimeMillis: Long) = utcMsToDay(utcTimeMillis).let { it <= today && it >= first }
        })
        DatePickerDialog({ pickDay = false }, confirmButton = {
            AppButton("OK", { state.selectedDateMillis?.let { day = utcMsToDay(it) }; pickDay = false }, Modifier.semantics { testTag = "picker-ok" }, style = ButtonStyle.Text)
        }, dismissButton = { AppButton("Cancel", { pickDay = false }, style = ButtonStyle.Text) }) { DatePicker(state) }
    }
}
