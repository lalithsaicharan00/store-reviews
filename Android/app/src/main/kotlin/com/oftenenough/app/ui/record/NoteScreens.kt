package com.oftenenough.app.ui.record

import com.oftenenough.app.ui.components.AppDialog
import com.oftenenough.app.ui.theme.AppType

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.imePadding
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
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
import com.oftenenough.app.ui.theme.appColors

/**
 * 5.3.8, **Note screen** (Figma 765:1087, Mode Entry · empty · Entry · typed · View; Components — Atoms Build Plan): a
 * note for one habit's day ([habitId]). Built like the Log screen: the Top app bar (✕ and "Add note" / "Edit note"; ←
 * and "Note"), the content 16 at the sides, nothing above, 8 apart, the bottom bar 12 / 16.
 *
 * Entry: the habit, 4 above and below, 8 apart (its icon in a 24 dp circle, the name in Title Medium On surface; no
 * date: a note belongs to the day it's written from, A78); the field (Surface container lowest, corners 24, 16 in, Body
 * Large, "Write a note" in On surface variant) filling the room; Save, Medium Filled, off until something is typed;
 * closing with something typed asks first. View: the habit and its date (Body Medium On surface variant), the note's
 * card, Delete note (Outlined, Error) | Edit (Filled). Edit note is Entry with ✕ only (never ‹ and ✕ together).
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun NoteScreen(habitId: String, startDay: Int, store: HabitStore, say: (String, (() -> Unit)?) -> Unit = { _, _ -> }, onDone: () -> Unit) {
    val c = appColors
    val s = MaterialTheme.colorScheme
    // A habit deleted while this was open: nothing to write on.
    val habit = store.habit(habitId) ?: run { LaunchedEffect(Unit) { onDone() }; return }
    // A note belongs to the day it's written from; its day never changes (A78).
    val day = startDay
    val opened = remember { store.note(habit, day) }
    val saved = store.note(habit, day)
    var editing by rememberSaveable { mutableStateOf(opened == null) }
    val adding = opened == null
    // Editing starts with the cursor after the note, to add to it (Figma 958:137302).
    var field by rememberSaveable(editing, stateSaver = androidx.compose.ui.text.input.TextFieldValue.Saver) {
        mutableStateOf(androidx.compose.ui.text.input.TextFieldValue(saved ?: "", androidx.compose.ui.text.TextRange((saved ?: "").length)))
    }
    val text = field.text
    var discard by remember { mutableStateOf(false) }
    var confirmDelete by remember { mutableStateOf(false) }
    // Saved and leaving: the screen keeps what it showed while it slides away.
    var leaving by remember { mutableStateOf(false) }
    val focus = remember { FocusRequester() }
    val changed = text.trim() != (saved ?: "").trim()
    fun close() { if (editing && changed && text.isNotBlank()) discard = true else if (editing && !adding) editing = false else onDone() }
    fun save(value: String) = store.setNote(value, habit, day)
    BackHandler { close() }
    LaunchedEffect(editing) { if (editing) runCatching { focus.requestFocus() } }

    val title = when { !editing -> "Note"; adding -> "Add note"; else -> "Edit note" }
    val date = DayWords.date(day).format(noteDate)
    Column(Modifier.fillMaxSize().background(c.screen).imePadding().navigationBarsPadding()) {
        RecordTopBar(title, close = editing, onClose = ::close)
        Column(Modifier.weight(1f).padding(horizontal = 16.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
            // The habit (Figma's Habit and day): its icon in a 24 circle and the name; the note's date only when reading it.
            Row(Modifier.fillMaxWidth().padding(vertical = 4.dp), verticalAlignment = Alignment.CenterVertically,
                horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                HabitIcon(habit.symbol, habit.color, size = 24.dp)
                Text(habit.name, Modifier.weight(1f), style = AppType.titleMedium, color = s.onSurface, maxLines = 1, overflow = TextOverflow.Ellipsis)
                if (!editing) Text(date, Modifier.semantics { testTag = "note-day" }, style = AppType.bodyMedium, color = s.onSurfaceVariant, maxLines = 1)
            }
            if (editing) {
                Box(Modifier.weight(1f).fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(s.surfaceContainerLowest).padding(16.dp)) {
                    BasicTextField(field, { field = it.copy(text = it.text.take(TextLimit.NOTE)) },
                        textStyle = AppType.bodyLarge.copy(color = s.onSurface),
                        keyboardOptions = KeyboardOptions(capitalization = KeyboardCapitalization.Sentences),
                        cursorBrush = SolidColor(s.onSurface),
                        modifier = Modifier.fillMaxSize().focusRequester(focus).semantics { testTag = "note-field" },
                        decorationBox = { inner -> Box { if (text.isEmpty()) Text("Write a note", style = AppType.bodyLarge, color = s.onSurfaceVariant); inner() } })
                }
            } else {
                Box(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(s.surfaceContainerLowest).padding(16.dp)) {
                    Text((if (leaving) opened else saved) ?: "", Modifier.verticalScroll(rememberScrollState()).semantics { testTag = "note-text" }, style = AppType.bodyLarge, color = s.onSurface)
                }
            }
            TextLimit.note(text, TextLimit.NOTE)?.takeIf { editing }?.let { Footer(it) }
        }
        if (editing) BottomAction("Save", leaving || (text.isNotBlank() && changed), tag = "note-save") {
            if (leaving) return@BottomAction
            // Saved, it goes back where it came from and says so (Figma's Today, flows 25 and 27).
            leaving = true
            save(text)
            onDone()
            say("Note saved", null)
        } else DeleteEditBar("note", "note-delete", "note-edit", { confirmDelete = true }, { editing = true })
    }
    if (discard) DiscardDialog(if (adding) "Discard this note?" else "Discard your changes?",
        if (adding) "What you typed won’t be saved." else "The note stays as it was.", { discard = false }, {
        discard = false
        if (adding) onDone() else editing = false
    })
    // Figma's Today, flow 28: Delete this note? · Cancel | Delete, then "Note deleted" with Undo.
    if (confirmDelete) AppDialog("Delete this note?", "Your logs for this day stay as they are.",
        "Delete", {
            confirmDelete = false
            val was = saved ?: ""
            leaving = true
            save("")
            onDone()
            say("Note deleted") { save(was) }
        }, { confirmDelete = false }, destructive = true, confirmTag = "note-delete-confirm")
}

/** A note's date, as Figma writes it: "21 Oct 2026". */
private val noteDate = java.time.format.DateTimeFormatter.ofPattern("d MMM yyyy", java.util.Locale.ENGLISH)
