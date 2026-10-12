package com.oftenenough.app.ui.record

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.imePadding
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.rounded.CalendarToday
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
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
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardCapitalization
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.TextLimit
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.theme.appColors

/**
 * A note for one habit's day ([habitId]), or the day's own note (null): Add note when there's none, the Note view when
 * there is (Delete note | Edit), and Edit note (✕ only, never ‹ and ✕ together: Current Work 104). Save is off until
 * something is typed; closing with something typed asks first (D7).
 */
@Composable
fun NoteScreen(habitId: String?, day: Int, store: HabitStore, onDone: () -> Unit) {
    val c = appColors
    val habit = habitId?.let { store.habit(it) }
    val saved = if (habit != null) store.note(habit, day) else store.dayNote(day)
    var editing by rememberSaveable { mutableStateOf(saved == null) }
    var text by rememberSaveable(editing) { mutableStateOf(saved ?: "") }
    var discard by remember { mutableStateOf(false) }
    var confirmDelete by remember { mutableStateOf(false) }
    val focus = remember { FocusRequester() }
    val changed = text.trim() != (saved ?: "").trim()
    fun close() { if (editing && changed && text.isNotBlank()) discard = true else if (editing && saved != null) editing = false else onDone() }
    fun save(value: String) { if (habit != null) store.setNote(value, habit, day) else store.setDayNote(value, day) }
    BackHandler { close() }
    LaunchedEffect(editing) { if (editing) runCatching { focus.requestFocus() } }

    val title = when { !editing -> "Note"; saved == null -> "Add note"; else -> "Edit note" }
    Column(Modifier.fillMaxSize().background(c.screen).imePadding().navigationBarsPadding()) {
        RecordTopBar(title, close = editing, onClose = ::close)
        Row(Modifier.fillMaxWidth().padding(start = 32.dp, end = 32.dp, top = 8.dp, bottom = 12.dp), verticalAlignment = Alignment.CenterVertically) {
            if (habit != null) HabitIcon(habit.symbol, habit.color, size = 24.dp)
            else Icon(Icons.Rounded.CalendarToday, null, tint = c.secondary, modifier = Modifier.size(24.dp))
            Spacer(Modifier.width(8.dp))
            Text(habit?.name ?: "This day", Modifier.weight(1f), style = MaterialTheme.typography.titleMedium, color = c.ink, maxLines = 1)
            Text(DayWords.withDate(day, store.today()), style = MaterialTheme.typography.bodyMedium, color = c.secondary)
        }
        Box(Modifier.weight(1f).fillMaxWidth().padding(horizontal = 16.dp).clip(RoundedCornerShape(20.dp)).background(c.surface).padding(16.dp)) {
            if (editing) {
                BasicTextField(text, { text = it.take(TextLimit.NOTE) },
                    textStyle = MaterialTheme.typography.bodyLarge.copy(color = c.ink, lineHeight = 24.sp),
                    keyboardOptions = KeyboardOptions(capitalization = KeyboardCapitalization.Sentences),
                    cursorBrush = SolidColor(c.ink),
                    modifier = Modifier.fillMaxSize().focusRequester(focus).semantics { testTag = "note-field" },
                    decorationBox = { inner -> Box { if (text.isEmpty()) Text("Write a note", style = MaterialTheme.typography.bodyLarge, color = c.secondary); inner() } })
            } else Text(saved ?: "", Modifier.verticalScroll(rememberScrollState()), style = MaterialTheme.typography.bodyLarge.copy(lineHeight = 24.sp), color = c.ink)
        }
        TextLimit.note(text, TextLimit.NOTE)?.takeIf { editing }?.let { Footer(it) }
        if (editing) BottomAction("Save", text.isNotBlank() && changed, tag = "note-save") {
            save(text)
            if (saved == null) onDone() else editing = false
        } else Row(Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 12.dp), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
            Button({ confirmDelete = true }, Modifier.weight(1f).heightIn(min = 56.dp).semantics { testTag = "note-delete" },
                colors = ButtonDefaults.buttonColors(containerColor = c.tonal, contentColor = c.error)) { Text("Delete note", style = MaterialTheme.typography.titleMedium) }
            Button({ editing = true }, Modifier.weight(1f).heightIn(min = 56.dp).semantics { testTag = "note-edit" },
                colors = ButtonDefaults.buttonColors(containerColor = c.ink, contentColor = c.onInk)) { Text("Edit", style = MaterialTheme.typography.titleMedium) }
        }
    }
    if (discard) DiscardDialog(if (saved == null) "Discard this note?" else "Discard your changes to this note?", { discard = false }) {
        discard = false
        if (saved == null) onDone() else { editing = false }
    }
    if (confirmDelete) AlertDialog({ confirmDelete = false }, title = { Text("Delete this note?") },
        text = { Text("The note for ${DayWords.short(day)} is deleted. Nothing else changes.") },
        confirmButton = { TextButton({ confirmDelete = false; save(""); onDone() }) { Text("Delete note", color = c.error, fontWeight = FontWeight.Medium) } },
        dismissButton = { TextButton({ confirmDelete = false }) { Text("Cancel", color = c.ink) } })
}
