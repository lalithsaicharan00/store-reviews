package com.oftenenough.app.ui.settings

import com.oftenenough.app.ui.components.AppDialog
import com.oftenenough.app.ui.components.ListChevron
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.ButtonSize
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.AppExtendedFab
import com.oftenenough.app.ui.components.AppSwitch
import com.oftenenough.app.ui.theme.AppType

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
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
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.input.KeyboardCapitalization
import androidx.compose.ui.unit.dp
import com.oftenenough.app.app.Prefs
import com.oftenenough.app.data.DaySection
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.HabitCopy
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.SectionPlan
import com.oftenenough.app.data.TextLimit
import com.oftenenough.app.data.newId
import com.oftenenough.app.data.FormOutcome
import com.oftenenough.app.ui.components.Segment
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.newhabit.FormPage
import com.oftenenough.app.ui.newhabit.GroupTitle
import com.oftenenough.app.ui.newhabit.MinuteDialog
import com.oftenenough.app.ui.newhabit.Note
import com.oftenenough.app.ui.theme.appColors

// ------------------------------------------------------------------ Day and Week

/** ≡ › Day and Week: when the day starts, when the week starts, and how the clock is read. */
@Composable
fun DayAndWeekPage(store: HabitStore, onBack: () -> Unit) {
    FormPage("Day and Week", onBack = onBack) {
        Spacer(Modifier.height(8.dp))
        DropdownRow("New day starts at", DayWords.clockMinute(store.dayEndHour * 60), Symbols.Update,
            (0..12).map { DayWords.clockMinute(it * 60) }, store.dayEndHour, "day-start") { store.setDayEnd(it) }
        Note("Your day starts at ${DayWords.clockMinute(store.dayEndHour * 60)}. For late nights or night shifts, pick a later time: what you log before it counts for the day before.")
        Spacer(Modifier.height(12.dp))
        DropdownRow("Week starts on", HabitCopy.fullDays[store.weekStart - 1], Symbols.CalendarMonth,
            HabitCopy.fullDays, store.weekStart - 1, "week-start") { store.chooseWeekStart(it + 1) }
        Note("Weekly goals, week streaks, the calendar and Progress count in these weeks, past weeks too.")
        GroupTitle("Clock")
        SegmentedList {
            InfoRow(Symbols.Schedule, "Times follow your phone's 24-hour time setting, in Settings › System › Date & time.", 0, 2)
            InfoRow(Symbols.Public, "Daylight saving and travel are handled for you: what you log keeps its day, and reminders keep their time.", 1, 2)
        }
    }
}

@Composable
private fun InfoRow(icon: ImageVector, text: String, index: Int, count: Int) {
    Segment(index, count) {
        Icon(icon, null, tint = appColors.secondary)
        Spacer(Modifier.width(24.dp))
        Text(text, Modifier.padding(vertical = 8.dp), style = MaterialTheme.typography.bodyLarge, color = appColors.secondary)
    }
}

// ------------------------------------------------------------------ Appearance

/** ≡ › Appearance: the theme, done habits on Today, what happens when you tick, and timers. */
@Composable
fun AppearancePage(prefs: Prefs, onBack: () -> Unit) {
    FormPage("Appearance", onBack = onBack) {
        GroupTitle("Theme")
        Row(horizontalArrangement = Arrangement.spacedBy(4.dp)) {
            listOf(Triple("light", "Light", Symbols.LightMode), Triple("dark", "Dark", Symbols.DarkMode), Triple("system", "System default", null))
                .forEachIndexed { i, (key, title, icon) ->
                    val on = prefs.theme == key
                    val shape = when (i) { 0 -> RoundedCornerShape(24.dp, 4.dp, 4.dp, 24.dp); 2 -> RoundedCornerShape(4.dp, 24.dp, 24.dp, 4.dp); else -> RoundedCornerShape(4.dp) }
                    Column(Modifier.weight(if (key == "system") 1.5f else 1f).clip(if (on) RoundedCornerShape(24.dp) else shape).background(if (on) appColors.ink else appColors.surface)
                        .clickable { prefs.theme = key }.heightIn(min = 76.dp).padding(vertical = 12.dp)
                        .semantics { testTag = "theme-$key"; contentDescription = title + if (on) ", chosen" else "" },
                        horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.Center) {
                        val shown = if (on) Symbols.Check else icon
                        if (shown != null) Icon(shown, null, tint = if (on) appColors.onInk else appColors.ink)
                        Spacer(Modifier.height(6.dp))
                        Text(title, style = AppType.titleMedium, color = if (on) appColors.onInk else appColors.ink, maxLines = 1)
                    }
                }
        }
        Note("System default follows your phone: light by day and dark at night if you've set it to.")
        GroupTitle("Today")
        DropdownRow("Done habits", if (prefs.doneOrder == "stay") "Stay in place" else "Move to bottom", Symbols.PlaylistAddCheck,
            listOf("Move to bottom", "Stay in place"), if (prefs.doneOrder == "stay") 1 else 0, "done-order") { prefs.doneOrder = if (it == 1) "stay" else "bottom" }
        Note(if (prefs.doneOrder == "stay") "Done habits stay where they are. Your order never changes by itself."
            else "Done habits go below the rest once you pause, never while you're still ticking.")
        GroupTitle("When you tick")
        SegmentedList {
            ToggleRow("Vibration", Symbols.Vibration, prefs.vibration, 0, 2, "vibration") { prefs.vibration = it }
            ToggleRow("Sound when done", Symbols.MusicNote, prefs.sound, 1, 2, "sound") { prefs.sound = it }
        }
        Note("A light buzz as you log, and a chime when a habit is done. The chime follows your phone's sound mode.")
        GroupTitle("Timers")
        SegmentedList {
            ToggleRow("Open timer full screen", Symbols.CropFree, prefs.timerScreen, 0, 2, "timer-screen") { prefs.timerScreen = it }
            ToggleRow("Show in notifications", Symbols.NotificationsActive, prefs.timerNotification, 1, 2, "timer-notification") { prefs.timerNotification = it }
        }
        Note("Starting a timer opens it full screen; swipe down to put it away while it keeps running. When you leave the app, a running timer stays in your notifications, on the lock screen and in the status bar, with Pause.")
    }
}

/** A setting that's on or off; the whole row is the toggle (List item, 2.4). */
@Composable
fun ToggleRow(title: String, icon: ImageVector?, checked: Boolean, index: Int, count: Int, tag: String, onChange: (Boolean) -> Unit) =
    AppListItem(title, index, count, leading = icon?.let { { Icon(it, null) } }, trailing = { AppSwitch(checked) },
        onClick = { onChange(!checked) }, tag = tag)

// ------------------------------------------------------------------ Times of Day

/** ≡ › Times of Day: Anytime, then each time of day with its hours; tap one to edit it, or add your own. */
@Composable
fun TimesOfDayPage(store: HabitStore, onEdit: (String?) -> Unit, onBack: () -> Unit) {
    Box(Modifier.fillMaxSize()) {
        FormPage("Times of Day", onBack = onBack) {
            Spacer(Modifier.height(8.dp))
            val timed = store.timedSections()
            SegmentedList {
                val count = timed.size + 1
                AppListItem("Anytime", 0, count, supporting = "No set time", tag = "section-anytime")
                timed.forEachIndexed { i, (s, _) ->
                    AppListItem(s.name, i + 1, count, supporting = FormOutcome.hours(s, store) ?: "", trailing = { ListChevron() },
                        onClick = { onEdit(s.id) }, tag = "section-${s.name}")
                }
            }
            Note("Morning, Evening, or your own, like Before work. Each one ends when the next one starts.")
            Spacer(Modifier.height(80.dp))
        }
        AppExtendedFab("Add time of day", Symbols.Add, { onEdit(null) },
            Modifier.align(Alignment.BottomEnd).navigationBarsPadding().padding(16.dp), tag = "add-section")
    }
}

/** New or Edit time of day: its name, when it starts and ends, and the whole day as it will be, before saving. */
@Composable
fun SectionEditorScreen(store: HabitStore, existingId: String?, onClose: (String?) -> Unit) {
    val existing = existingId?.let { id -> store.sections.firstOrNull { it.id == id } }
    var name by remember { mutableStateOf(existing?.name ?: "") }
    val newId = remember { newId() }
    val dayEnd = 24 * 60 + store.dayEndHour * 60
    var start by remember { mutableStateOf(existing?.start ?: SectionPlan.freeStart(store.sections, dayEnd)) }
    var picking by remember { mutableStateOf<String?>(null) }
    var confirmSplit by remember { mutableStateOf(false) }
    var confirmDelete by remember { mutableStateOf(false) }
    val trimmed = TextLimit.clean(name, TextLimit.SECTION)
    val subject = DaySection(existing?.id ?: newId, trimmed.ifEmpty { "New time of day" }, null, null)
    val plan = start?.let { SectionPlan.fromStart(store.sections, subject, it, dayEnd) }
    fun save() {
        if (plan == null || plan.problem != null || trimmed.isEmpty()) return
        store.saveSections(plan.sections)
        onClose(subject.id)
    }
    FormPage(if (existing == null) "New time of day" else "Edit time of day", onBack = { onClose(null) }, close = true, actions = {
        AppButton(if (existing == null) "Add" else "Save", { if (plan?.split.isNullOrEmpty()) save() else confirmSplit = true },
            Modifier.padding(end = 8.dp), enabled = trimmed.isNotEmpty() && plan != null && plan.problem == null, tag = "section-save")
    }) {
        val focus = remember { FocusRequester() }
        LaunchedEffect(Unit) { if (existing == null) runCatching { focus.requestFocus() } }
        Box(Modifier.fillMaxWidth().padding(top = 8.dp).clip(RoundedCornerShape(24.dp)).background(appColors.surface).heightIn(min = 68.dp).padding(16.dp),
            contentAlignment = Alignment.CenterStart) {
            BasicTextField(name, { name = it.replace("\n", "").take(TextLimit.SECTION) }, Modifier.fillMaxWidth().focusRequester(focus).semantics { testTag = "section-name-field"; contentDescription = "Name" },
                textStyle = AppType.headlineMedium.copy(color = appColors.ink), singleLine = true, cursorBrush = SolidColor(appColors.ink),
                keyboardOptions = KeyboardOptions(capitalization = KeyboardCapitalization.Sentences),
                decorationBox = { inner -> Box { if (name.isEmpty()) Text("e.g. Before work", style = AppType.headlineMedium.copy(color = appColors.secondary)); inner() } })
        }
        TextLimit.note(name, TextLimit.SECTION)?.let { Note(it) }
        Spacer(Modifier.height(16.dp))
        val mine = plan?.rows?.firstOrNull { it.isSubject }
        val endWords = mine?.let { row ->
            val next = plan.rows.firstOrNull { it.start == row.end && !it.isSubject }
            "Ends ${DayWords.clockMinute(row.end % (24 * 60))}, when ${next?.name ?: "your new day"} starts"
        }
        StartTile(start, endWords) { picking = "start" }
        Text(plan?.problem ?: "Habits can still be ticked at any time; the time of day only orders Today and marks what's Now.",
            Modifier.padding(16.dp, 8.dp).semantics { testTag = "section-problem" }, style = MaterialTheme.typography.bodyMedium,
            color = if (plan?.problem != null) appColors.error else appColors.secondary)
        if (plan != null) {
            GroupTitle("Your day")
            SegmentedList {
                plan.rows.forEachIndexed { i, row ->
                    Segment(i, plan.rows.size, Modifier.semantics(mergeDescendants = true) { testTag = "plan-row-${row.name}" }) {
                        Column(Modifier.weight(1f).padding(vertical = 4.dp)) {
                            Text(row.name, style = if (row.isSubject) AppType.titleMedium else AppType.bodyLarge, color = appColors.ink, maxLines = 1)
                            Text(row.range, style = MaterialTheme.typography.bodyMedium, color = if (row.isSubject || row.changed) appColors.ink else appColors.secondary)
                            if (!row.isSubject && row.changed) row.oldRange?.let { Text("Was $it", style = MaterialTheme.typography.bodySmall, color = appColors.secondary) }
                        }
                        if (row.isSubject) {
                            Row(Modifier.clip(RoundedCornerShape(16.dp)).background(appColors.tonal).padding(start = 8.dp, end = 12.dp, top = 6.dp, bottom = 6.dp),
                                verticalAlignment = Alignment.CenterVertically) {
                                Icon(if (existing == null) Symbols.Add else Symbols.Edit, null, Modifier.size(18.dp), tint = appColors.ink)
                                Spacer(Modifier.width(4.dp))
                                Text(if (existing == null) "New" else "Editing", style = MaterialTheme.typography.labelLarge, color = appColors.ink)
                            }
                        }
                    }
                }
            }
            Note(if (existing == null) "Each time of day ends when the next one starts. This is your day once you add this one."
                else "Each time of day ends when the next one starts. This is your day once you save.")
        }
        if (existing != null) {
            Spacer(Modifier.height(24.dp))
            AppButton("Delete time of day", { confirmDelete = true }, Modifier.fillMaxWidth(), style = ButtonStyle.Outlined,
                size = ButtonSize.Medium, destructive = true, tag = "section-delete")
        }
    }
    if (picking == "start") MinuteDialog(start ?: 6 * 60, { picking = null }) { start = it }
    if (confirmSplit && plan != null) AppDialog("Split ${HabitCopy.join(plan.split.map { it.name })}?",
        plan.rows.filter { it.isSubject || it.changed }.joinToString("\n") { "${it.name}: ${it.range}" },
        if (existing == null) "Split and add $trimmed" else "Split and save", { confirmSplit = false; save() }, { confirmSplit = false },
        confirmTag = "section-split-confirm")
    if (confirmDelete && existing != null) AppDialog("Delete ${existing.name}?", "Its habits move to Anytime. Nothing else changes.", "Delete time of day", {
        confirmDelete = false
        store.saveSections(store.sections.filter { it.id != existing.id })
        onClose(null)
    }, { confirmDelete = false }, destructive = true, confirmTag = "section-delete-confirm")
}

/** "🕒 Starts / 6:00 AM": a big clock time that opens Android's time picker. */
/** The one Starts tile (Current Work 108): the start large, an edit pencil, and the end worked out under it in grey. */
@Composable
private fun StartTile(minute: Int?, endWords: String?, onClick: () -> Unit) {
    val text = minute?.let { DayWords.clockMinute(it % (24 * 60)) }
    val (main, suffix) = text?.split(" ")?.let { if (it.size == 2) it[0] to it[1] else text to "" } ?: ("Choose" to "")
    Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(appColors.surface).clickable(onClick = onClick)
        .semantics(mergeDescendants = true) { testTag = "section-start"; contentDescription = "Starts, ${text ?: "not chosen"}" + (endWords?.let { ". $it" } ?: "") }
        .padding(16.dp)) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            Icon(Symbols.Schedule, null, Modifier.size(20.dp), tint = appColors.secondary)
            Spacer(Modifier.width(8.dp))
            Text("Starts", Modifier.weight(1f), style = AppType.titleMedium, color = appColors.secondary)
            Icon(Symbols.Edit, null, Modifier.size(20.dp), tint = appColors.ink)
        }
        Row(verticalAlignment = Alignment.Bottom) {
            Text(main, style = AppType.displayMedium.copy(color = appColors.ink))
            if (suffix.isNotEmpty()) Text(" $suffix", Modifier.padding(bottom = 8.dp), style = MaterialTheme.typography.titleMedium, color = appColors.ink)
        }
        endWords?.let { Text(it, style = MaterialTheme.typography.bodyMedium, color = appColors.secondary) }
    }
}

