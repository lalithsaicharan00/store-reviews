package com.oftenenough.app.ui.newhabit

import androidx.activity.compose.BackHandler
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
import androidx.compose.foundation.layout.imePadding
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.ArrowBack
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowRight
import androidx.compose.material.icons.automirrored.rounded.Notes
import androidx.compose.material.icons.outlined.Folder
import androidx.compose.material.icons.outlined.Notifications
import androidx.compose.material.icons.outlined.Schedule
import androidx.compose.material.icons.outlined.WbSunny
import androidx.compose.material.icons.rounded.Check
import androidx.compose.material.icons.rounded.Checklist
import androidx.compose.material.icons.rounded.EditCalendar
import androidx.compose.material.icons.rounded.Event
import androidx.compose.material.icons.rounded.EventBusy
import androidx.compose.material.icons.rounded.History
import androidx.compose.material.icons.rounded.PlayArrow
import androidx.compose.material.icons.rounded.Repeat
import androidx.compose.material.icons.rounded.Speed
import androidx.compose.material.icons.rounded.Tag
import androidx.compose.material.icons.rounded.Timer
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.ModalBottomSheet
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.runtime.snapshotFlow
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
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardCapitalization
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Frequency
import com.oftenenough.app.data.GoalPeriod
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitCopy
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.TextLimit
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.RoundActionButton
import com.oftenenough.app.ui.components.Segment
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.onboarding.HabitIdea
import com.oftenenough.app.ui.record.DiscardDialog
import com.oftenenough.app.ui.record.GoalNumber
import com.oftenenough.app.ui.record.Pill
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.collectLatest
import java.time.Instant
import java.time.LocalDate
import java.time.ZoneId

/** Text being typed, read only by its own field, so typing redraws only the field (S11). */
class TypedText(initial: String) { var text by mutableStateOf(initial) }

private enum class Page { HOW_MUCH, UNIT, STEPS, OFTEN, TIME_OF_DAY, GROUP, REMINDERS, ICON }

/**
 * New: what do you want to do → (build: how to track it | quit: quit or cut down) → the form. From an idea it opens the
 * form straight away with the idea's name and how often (nothing else is filled in: the amount depends on the person).
 */
@Composable
fun NewHabitFlow(store: HabitStore, idea: HabitIdea?, onClose: () -> Unit, onSaved: (Habit) -> Unit, onPlus: () -> Unit) {
    val ideaType = idea?.let { when (it.type) { "amount" -> ItemType.AMOUNT; "time" -> ItemType.TIME; "quit" -> ItemType.QUIT; "cutDown" -> ItemType.CUT_DOWN; else -> ItemType.CHECK } }
    var step by rememberSaveable { mutableStateOf(ideaType?.let { "form:${it.name}" } ?: "choose") }
    when {
        step == "choose" -> {
            BackHandler(onBack = onClose)
            NewChoices(store, onClose, onBuild = { step = "build" }, onQuit = { step = "quit" }, onTask = { step = "form:${ItemType.TASK.name}" })
        }
        step == "build" -> {
            BackHandler { step = "choose" }
            TypeChoices("How do you want to track it?", listOf(ItemType.CHECK, ItemType.AMOUNT, ItemType.TIME, ItemType.CHECKLIST), { step = "choose" }) { step = "form:${it.name}" }
        }
        step == "quit" -> {
            BackHandler { step = "choose" }
            TypeChoices("What do you want to do?", listOf(ItemType.QUIT, ItemType.CUT_DOWN), { step = "choose" }) { step = "form:${it.name}" }
        }
        else -> {
            val type = ItemType.valueOf(step.removePrefix("form:"))
            val back = {
                step = when { idea != null -> ""; type == ItemType.TASK -> "choose"; type == ItemType.QUIT || type == ItemType.CUT_DOWN -> "quit"; else -> "build" }
                if (step.isEmpty()) onClose()
            }
            HabitForm(type, null, store, idea.takeIf { ideaType == type }, back, onSaved, onPlus)
        }
    }
}

/** Edit habit: the same form on a saved habit, every row as it is now. */
@Composable
fun EditHabitScreen(habitId: String, store: HabitStore, onClose: () -> Unit) {
    val habit = store.habit(habitId) ?: run { LaunchedEffect(Unit) { onClose() }; return }
    HabitForm(ItemType.of(habit), habit, store, null, onClose, { onClose() }, {})
}

/** The New Habit (or Edit) form: the preview, the name, then the rows each type needs, each opening its own page. */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun HabitForm(type: ItemType, original: Habit?, store: HabitStore, idea: HabitIdea?, onClose: () -> Unit, onSaved: (Habit) -> Unit, onPlus: () -> Unit) {
    val form = remember { FormState(type, original, store).also { f -> idea?.let { f.applyIdea(it) } } }
    val typed = remember { TypedText(form.name) }
    val describing = remember { TypedText(form.description) }
    var pages by remember { mutableStateOf(listOf<Page>()) }
    val scroll = rememberScrollState()
    var discard by remember { mutableStateOf(false) }
    var sixth by remember { mutableStateOf(false) }
    // The previews catch up when typing pauses (0.3 s); Add follows at once (S11).
    LaunchedEffect(typed) {
        snapshotFlow { typed.text }.collectLatest { text ->
            form.nameFilled = text.isNotBlank()
            delay(300)
            form.name = text
            form.suggestIcon()
        }
    }
    fun open(p: Page) { form.name = typed.text; pages = pages + p }
    fun back() { pages = pages.dropLast(1) }
    fun close() {
        form.name = typed.text
        form.description = describing.text
        if (form.hasChanges) discard = true else onClose()
    }
    fun save() {
        form.name = typed.text
        form.description = describing.text
        if (!form.canAdd) return
        val description = TextLimit.clean(describing.text, TextLimit.DESCRIPTION)
        val o = form.original
        if (o != null) {
            val habit = form.edited(form.trimmedName) ?: return
            store.update(habit)
            store.setDescription(description, habit.id)
            if (form.groupId != form.originalGroupId) store.setGroup(form.groupId, habit.id)
            onSaved(habit)
            return
        }
        if (type.isHabit && !store.canAddHabit) { sixth = true; return }
        val habit = form.makeHabit(form.trimmedName)
        store.add(habit)
        store.setDescription(description, habit.id)
        form.groupId?.let { g -> if (store.groups.any { it.id == g }) store.setGroup(g, habit.id) }
        onSaved(habit)
    }

    when (pages.lastOrNull()) {
        Page.HOW_MUCH -> if (form.timed) HowLongPage(form, ::back) else HowMuchPage(form, { open(Page.UNIT) }, ::back)
        Page.UNIT -> UnitPage(form, store, ::back)
        Page.STEPS -> StepsPage(form, ::back)
        Page.OFTEN -> HowOftenPage(form, ::back)
        Page.TIME_OF_DAY -> TimeOfDayPage(form, store, ::back)
        Page.GROUP -> GroupPage(form, store, ::back)
        Page.REMINDERS -> RemindersPage(form, store, ::back)
        Page.ICON -> IconPage(form, ::back)
        null -> FormBody(form, store, typed, describing, scroll, ::open, ::close, ::save)
    }
    if (discard) DiscardDialog(if (form.editing) "Discard your changes?" else if (type == ItemType.TASK) "Discard this task?" else "Discard this habit?",
        onKeep = { discard = false }, onDiscard = { discard = false; onClose() })
    if (sixth) SixthHabitSheet(store, form.trimmedName, { sixth = false }, onPlus)
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun FormBody(
    form: FormState, store: HabitStore, typed: TypedText, describing: TypedText, scroll: androidx.compose.foundation.ScrollState,
    open: (Page) -> Unit, close: () -> Unit, save: () -> Unit,
) {
    val type = form.type
    var colours by remember { mutableStateOf(false) }
    BackHandler(onBack = close)
    Column(Modifier.fillMaxSize().background(appColors.screen).imePadding()) {
        TopAppBar(
            title = { Text(formTitle(form), maxLines = 1) },
            navigationIcon = { IconButton(close, Modifier.semantics { testTag = "form-back" }) { Icon(Icons.AutoMirrored.Rounded.ArrowBack, "Back") } },
            actions = {
                Button(save, Modifier.padding(end = 8.dp).semantics { testTag = "form-add" }, enabled = form.canAdd,
                    colors = ButtonDefaults.buttonColors(containerColor = appColors.ink, contentColor = appColors.onInk,
                        disabledContainerColor = appColors.tonal, disabledContentColor = appColors.secondary)) {
                    Text(if (form.editing) "Save" else "Add", style = MaterialTheme.typography.titleSmall.copy(fontSize = 16.sp))
                }
            },
            colors = TopAppBarDefaults.topAppBarColors(containerColor = appColors.screen, titleContentColor = appColors.ink, navigationIconContentColor = appColors.ink),
        )
        Column(Modifier.fillMaxWidth().verticalScroll(scroll).padding(horizontal = 16.dp).navigationBarsPadding()) {
            if (type != ItemType.QUIT) Preview(form, store)
            NameGroup(form, typed, describing, onIcon = { open(Page.ICON) }, onColour = { colours = true })
            Spacer(Modifier.height(24.dp))
            when (type) {
                ItemType.QUIT -> {
                    QuitStarted(form, store)
                    Note("The counter runs from here. It shows on Today under Quit or Cut Down, counting up.")
                    Spacer(Modifier.height(16.dp))
                    SegmentedList { OpenRow("Group", groupName(form, store), Icons.Outlined.Folder, 0, 1, "group-row") { open(Page.GROUP) } }
                }
                ItemType.TASK -> {
                    TaskRows(form, store)
                    Note((if (form.taskRepeats) "It comes back on the days you pick below." else "If it isn't done, it moves forward to today until it is.") +
                        " Tasks don't have progress or stats.")
                    Spacer(Modifier.height(16.dp))
                    if (form.taskRepeats) {
                        SegmentedList { OpenRow("How often", form.often.often(false).label(false, weekStart = form.weekStart), Icons.Rounded.EditCalendar, 0, 1, "how-often-row") { open(Page.OFTEN) } }
                        Spacer(Modifier.height(16.dp))
                    }
                    PlaceRows(form, store, open, withTime = true)
                    if (form.taskRepeats) { Spacer(Modifier.height(24.dp)); StartEndRows(form, store) }
                }
                else -> {
                    PlanRows(form, open)
                    if (type == ItemType.AMOUNT) TapRows(form)
                    Spacer(Modifier.height(24.dp))
                    if (type == ItemType.CUT_DOWN) {
                        PlaceRows(form, store, open, withTime = false)
                        Note("It shows on Today under Quit or Cut Down. Log it only when it happens.")
                    } else PlaceRows(form, store, open, withTime = true)
                    Spacer(Modifier.height(24.dp))
                    StartEndRows(form, store)
                }
            }
            editOutcome(form, store)?.let { Note(it) }
            Spacer(Modifier.height(32.dp))
        }
    }
    if (colours) ColourSheet(form) { colours = false }
}

private fun formTitle(form: FormState): String = when {
    form.editing -> if (form.type == ItemType.TASK) "Edit task" else "Edit habit"
    form.isHabit && form.type != ItemType.CUT_DOWN -> "New Habit"
    else -> form.type.title.let { if (it == "Quit") "Quit" else it }
}

/** What saving an edit does, in one line, before Save. */
private fun editOutcome(form: FormState, store: HabitStore): String? {
    val o = form.original ?: return null
    if (form.type == ItemType.QUIT) return null
    if (form.type == ItemType.TASK) return "Changes apply from today."
    val edited = form.edited(o.name) ?: return null
    return if (periodOf(o) != periodOf(edited) && store.streak(o, store.today()) > 0) "Your streak restarts. Your history stays."
    else "Changes apply from today. Your history stays as it was."
}

/** The kind of period a habit is judged in: each day, or a week, month or year. */
private fun periodOf(h: Habit): GoalPeriod = when (val f = h.frequency) {
    is Frequency.PerWeek -> GoalPeriod.WEEK
    is Frequency.PerMonth -> GoalPeriod.MONTH
    is Frequency.PerYear -> GoalPeriod.YEAR
    is Frequency.Flexible -> f.period
    else -> GoalPeriod.DAY
}

// ------------------------------------------------------------------ Preview and name

/** The habit as Today would show it: its icon, name, a line, and its round button; then the whole habit in a sentence. */
@Composable
private fun Preview(form: FormState, store: HabitStore) {
    val habit = form.previewHabit()
    val named = form.trimmedName.isNotEmpty()
    GroupTitle("Preview")
    Row(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(appColors.surface).heightIn(min = 72.dp).padding(horizontal = 16.dp, vertical = 12.dp)
        .semantics(mergeDescendants = true) { contentDescription = "Preview on Today"; testTag = "today-preview" }, verticalAlignment = Alignment.CenterVertically) {
        HabitIcon(habit.symbol, habit.color, 40.dp)
        Spacer(Modifier.width(16.dp))
        Column(Modifier.weight(1f)) {
            Text(habit.name, style = MaterialTheme.typography.bodyLarge, color = appColors.ink, maxLines = 1)
            previewLine(form, habit)?.let { Text(it, style = MaterialTheme.typography.bodyMedium, color = appColors.secondary, maxLines = 1) }
        }
        val (icon, text) = when {
            habit.kind == HabitKind.Duration -> Icons.Rounded.PlayArrow to null
            habit.kind is HabitKind.Amount -> Icons.Rounded.Check to ("+" + (habit.quickIncrement?.let { GoalNumber.text(it) } ?: ""))
            else -> Icons.Rounded.Check to null
        }
        RoundActionButton(icon, done = false, color = habit.color, label = "", onClick = {}, text = text, enabled = true)
    }
    Text(if (named) form.sentence() else if (form.type == ItemType.TASK) "Enter a task name to see the preview." else "Enter a habit name to see the preview.",
        Modifier.padding(start = 16.dp, end = 16.dp, top = 8.dp, bottom = 16.dp).semantics { testTag = "habit-sentence" },
        style = if (named) MaterialTheme.typography.titleMedium.copy(fontWeight = FontWeight.SemiBold) else MaterialTheme.typography.bodyMedium,
        color = if (named) appColors.ink else appColors.secondary)
    @Suppress("UNUSED_VARIABLE") val unused = store
}

private fun previewLine(form: FormState, habit: Habit): String? = when {
    form.type == ItemType.TASK -> if (form.taskRepeats) HabitCopy.capitalized(HabitCopy.rhythm(habit.frequency, form.weekStart, short = true)) else "Task"
    form.hasAmount && form.amountValue == null -> null
    else -> HabitCopy.capitalized(HabitCopy.plan(habit, form.weekStart, short = true))
}

/** The name (big), the description, and Icon | Colour, as one group. */
@Composable
private fun NameGroup(form: FormState, typed: TypedText, describing: TypedText, onIcon: () -> Unit, onColour: () -> Unit) {
    val describes = form.type != ItemType.QUIT
    Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
        NameField(typed, form.type.namePlaceholder, autoFocus = !form.editing && typed.text.isEmpty())
        if (describes) DescriptionField(describing)
        Row(horizontalArrangement = Arrangement.spacedBy(2.dp)) {
            HalfRow("Icon", "icon-row", RoundedCornerShape(4.dp, 4.dp, 4.dp, 24.dp), Modifier.weight(1f), onIcon) {
                HabitIcon(form.symbol, form.color, 28.dp)
            }
            HalfRow("Colour", "colour-row", RoundedCornerShape(4.dp, 4.dp, 24.dp, 4.dp), Modifier.weight(1f), onColour) {
                Box(Modifier.size(28.dp).clip(CircleShape).background(appColors.habit(form.color)))
            }
        }
    }
}

/** The name field on its own, so typing redraws only it (S11). A name is at most 24 letters, and shows only what's kept (U6). */
@Composable
private fun NameField(typed: TypedText, placeholder: String, autoFocus: Boolean) {
    val focus = remember { FocusRequester() }
    LaunchedEffect(Unit) { if (autoFocus) runCatching { focus.requestFocus() } }
    Box(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp, 24.dp, 4.dp, 4.dp)).background(appColors.surface).heightIn(min = 68.dp)
        .padding(horizontal = 16.dp, vertical = 14.dp), contentAlignment = Alignment.CenterStart) {
        BasicTextField(typed.text, { typed.text = it.replace("\n", "").take(TextLimit.NAME) },
            Modifier.fillMaxWidth().focusRequester(focus).semantics { testTag = "name-field"; contentDescription = "Name" },
            textStyle = TextStyle(fontSize = 28.sp, color = appColors.ink), singleLine = true, cursorBrush = SolidColor(appColors.ink),
            keyboardOptions = KeyboardOptions(capitalization = KeyboardCapitalization.Sentences),
            decorationBox = { inner -> Box { if (typed.text.isEmpty()) Text(placeholder, style = TextStyle(fontSize = 28.sp, color = appColors.secondary)); inner() } })
    }
    TextLimit.note(typed.text, TextLimit.NAME)?.let { Text(it, Modifier.padding(start = 16.dp, top = 4.dp), style = MaterialTheme.typography.bodySmall, color = appColors.secondary) }
}

@Composable
private fun DescriptionField(describing: TypedText) {
    Row(Modifier.fillMaxWidth().clip(RoundedCornerShape(4.dp)).background(appColors.surface).heightIn(min = 56.dp).padding(horizontal = 16.dp, vertical = 12.dp),
        verticalAlignment = Alignment.CenterVertically) {
        Icon(Icons.AutoMirrored.Rounded.Notes, null, tint = appColors.secondary)
        Spacer(Modifier.width(24.dp))
        BasicTextField(describing.text, { describing.text = it.take(TextLimit.DESCRIPTION) },
            Modifier.weight(1f).semantics { testTag = "description-field"; contentDescription = "Description" },
            textStyle = MaterialTheme.typography.bodyLarge.copy(color = appColors.ink), maxLines = 4, cursorBrush = SolidColor(appColors.ink),
            keyboardOptions = KeyboardOptions(capitalization = KeyboardCapitalization.Sentences),
            decorationBox = { inner -> Box { if (describing.text.isEmpty()) Text("Description (optional)", style = MaterialTheme.typography.bodyLarge, color = appColors.secondary); inner() } })
    }
}

@Composable
private fun HalfRow(title: String, tag: String, shape: RoundedCornerShape, modifier: Modifier, onClick: () -> Unit, lead: @Composable () -> Unit) {
    Row(modifier.clip(shape).background(appColors.surface).clickable(onClick = onClick).semantics { testTag = tag }.heightIn(min = 56.dp).padding(horizontal = 16.dp),
        verticalAlignment = Alignment.CenterVertically) {
        lead()
        Spacer(Modifier.width(12.dp))
        Text(title, Modifier.weight(1f), style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
        Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = appColors.secondary)
    }
}

// ------------------------------------------------------------------ Rows by type

/** How much / Limit / How long / Steps, then How often. */
@Composable
private fun PlanRows(form: FormState, open: (Page) -> Unit) {
    val type = form.type
    val plan = form.plan
    SegmentedList {
        val count = if (type == ItemType.CHECK) 1 else 2
        when (type) {
            ItemType.AMOUNT -> OpenRow("How much", if (form.amountValue == null) "Set" else plan.howMuchLabel, Icons.Rounded.Tag, 0, 2, "how-much-row") { open(Page.HOW_MUCH) }
            ItemType.CUT_DOWN -> OpenRow("Limit", if (form.amountValue == null) "Set" else plan.howMuchLabel, Icons.Rounded.Speed, 0, 2, "how-much-row") { open(Page.HOW_MUCH) }
            ItemType.TIME -> OpenRow("How long", if (form.amountValue == null) "Set" else plan.howMuchLabel, Icons.Rounded.Timer, 0, 2, "how-much-row") { open(Page.HOW_MUCH) }
            ItemType.CHECKLIST -> {
                val n = form.filledItems.size
                OpenRow("Steps", if (n == 0) "Add" else if (n == 1) "1 step" else "$n steps", Icons.Rounded.Checklist, 0, 2, "steps-row") { open(Page.STEPS) }
            }
            else -> {}
        }
        OpenRow("How often", plan.often.label(plan.hasAmount || form.hasAmount, plan.checklist, form.weekStart), Icons.Rounded.EditCalendar, count - 1, count, "how-often-row") { open(Page.OFTEN) }
    }
}

/** What + does on Today, chosen: add a set step, or type the amount each time. */
@Composable
private fun TapRows(form: FormState) {
    val plan = form.plan
    GroupTitle("When you tap +")
    SegmentedList {
        val count = if (form.asks) 2 else 3
        RadioRow("Add a set amount", !form.asks, 0, count, "tap-adds-step") { form.asks = false }
        if (!form.asks) Segment(1, count) {
            Text("Each tap adds", Modifier.weight(1f).padding(start = 40.dp), style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
            var text by remember { mutableStateOf(form.step?.let { GoalNumber.text(it) } ?: "") }
            BasicTextField(text, { t -> text = t.filter { it.isDigit() || it == '.' || it == ',' }.take(10); form.step = GoalNumber.parse(text)?.takeIf { it > 0 } },
                Modifier.width(108.dp).clip(RoundedCornerShape(8.dp)).background(appColors.tonal).heightIn(min = 48.dp).padding(horizontal = 16.dp, vertical = 12.dp)
                    .semantics { testTag = "tap-step"; contentDescription = "Each tap adds" },
                textStyle = MaterialTheme.typography.bodyLarge.copy(color = appColors.ink, textAlign = TextAlign.End), singleLine = true,
                keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Decimal), cursorBrush = SolidColor(appColors.ink),
                decorationBox = { inner -> Box(contentAlignment = Alignment.CenterEnd) { if (text.isEmpty()) Text(HabitCopy.number(plan.stepValue), style = MaterialTheme.typography.bodyLarge, color = appColors.ink); inner() } })
        }
        RadioRow("Type the amount each time", form.asks, count - 1, count, "tap-asks") { form.asks = true }
    }
    Note(if (form.asks) "Tap + to type how much you did." else "Each tap on + adds ${HabitCopy.amount(plan.stepValue, plan.unit)}.")
}

/** Time of Day, Group and Reminders (a limit has no time of day: it shows under Quit or Cut Down). */
@Composable
private fun PlaceRows(form: FormState, store: HabitStore, open: (Page) -> Unit, withTime: Boolean) {
    SegmentedList {
        val count = if (withTime) 3 else 2
        var i = 0
        if (withTime) OpenRow("Time of Day", HabitCopy.join(form.timesOfDay.map { store.section(it).name }),
            if (form.type == ItemType.TASK) Icons.Outlined.WbSunny else Icons.Outlined.Schedule, i++, count, "time-of-day-row") { open(Page.TIME_OF_DAY) }
        OpenRow("Group", groupName(form, store), Icons.Outlined.Folder, i++, count, "group-row") { open(Page.GROUP) }
        OpenRow("Reminders", form.remindersSummary(), Icons.Outlined.Notifications, i, count, "reminders-row") { open(Page.REMINDERS) }
    }
}

private fun groupName(form: FormState, store: HabitStore) = form.groupId?.let { id -> store.groups.firstOrNull { it.id == id }?.name } ?: "None"

/** "Today", "Tomorrow", "Yesterday", or "Wed 1 Oct": a start as a person says it, counted from the app's today (D7). */
private fun dayWords(day: Int, today: Int): String = when (day) {
    today -> "Today"; today + 1 -> "Tomorrow"; today - 1 -> "Yesterday"; else -> DayWords.short(day)
}

/** Starts (or Started, in the past) and Ends: Never, or on a date. */
@Composable
private fun StartEndRows(form: FormState, store: HabitStore) {
    val today = store.today()
    var picking by remember { mutableStateOf<String?>(null) }
    var endsMenu by remember { mutableStateOf(false) }
    SegmentedList {
        OpenRow(if (form.startDate < today) "Started" else "Starts", dayWords(form.startDate, today), Icons.Rounded.Event, 0, 2, "starts-row") { picking = "start" }
        Box {
            OpenRow("Ends", if (form.hasEnd) dayWords(form.endDate, today) else "Never", Icons.Rounded.EventBusy, 1, 2, "ends-row") { endsMenu = true }
            DropdownMenu(endsMenu, { endsMenu = false }, Modifier.semantics { testTag = "ends-menu" }, containerColor = appColors.surface) {
                DropdownMenuItem({ Text("Never") }, { form.hasEnd = false; endsMenu = false },
                    leadingIcon = { if (!form.hasEnd) Icon(Icons.Rounded.Check, null) })
                DropdownMenuItem({ Text("On a date…") }, {
                    endsMenu = false
                    if (!form.hasEnd && form.endDate <= form.startDate) form.endDate = form.startDate + 30
                    picking = "end"
                }, leadingIcon = { if (form.hasEnd) Icon(Icons.Rounded.Check, null) })
            }
        }
    }
    if (form.hasEnd) Note("After ${DayWords.dayMonth(form.endDate)}, it leaves Today. Its history stays.")
    else if (form.startDate < today) Note("A start date in the past lets you tick the days since then.")
    when (picking) {
        "start" -> DayDialog(form.startDate, { true }, { picking = null }) { form.startDate = it; if (form.hasEnd && form.endDate < it) form.endDate = it }
        "end" -> DayDialog(maxOf(form.endDate, form.startDate), { it >= form.startDate }, { picking = null }) { form.endDate = it; form.hasEnd = true }
    }
}

/** Quit: when it started, as a date and a time, never later than now. */
@Composable
private fun QuitStarted(form: FormState, store: HabitStore) {
    val zone = ZoneId.systemDefault()
    val at = Instant.ofEpochMilli(form.quitSince).atZone(zone)
    var picking by remember { mutableStateOf<String?>(null) }
    SegmentedList {
        Segment(0, 1, Modifier.semantics { testTag = "quit-started" }) {
            Icon(Icons.Rounded.History, null, tint = appColors.secondary)
            Spacer(Modifier.width(16.dp))
            Text("Started", Modifier.weight(1f), style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
            Pill(pillDate(at.toLocalDate().toEpochDay().toInt()), tag = "quit-date") { picking = "date" }
            Spacer(Modifier.width(8.dp))
            Pill(DayWords.clock(form.quitSince), tag = "quit-time") { picking = "time" }
        }
    }
    val now = store.clock()
    when (picking) {
        "date" -> DayDialog(at.toLocalDate().toEpochDay().toInt(), { it <= LocalDate.now(zone).toEpochDay() }, { picking = null }) { day ->
            form.quitSince = minOf(now, LocalDate.ofEpochDay(day.toLong()).atTime(at.toLocalTime()).atZone(zone).toInstant().toEpochMilli())
        }
        "time" -> MinuteDialog(at.hour * 60 + at.minute, { picking = null }) { m ->
            form.quitSince = minOf(now, at.toLocalDate().atTime(m / 60, m % 60).atZone(zone).toInstant().toEpochMilli())
        }
    }
}

/** A task: once on a date (with an optional time), or on repeat. */
@Composable
private fun TaskRows(form: FormState, store: HabitStore) {
    var repeatMenu by remember { mutableStateOf(false) }
    var picking by remember { mutableStateOf<String?>(null) }
    val today = store.today()
    val earliest = form.original?.dueDay?.let { minOf(today, it) } ?: today
    SegmentedList {
        val count = 1 + (if (!form.taskRepeats) 1 else 0) + 1 + (if (form.taskHasTime) 1 else 0)
        var i = 0
        Box {
            OpenRow("Repeat", if (form.taskRepeats) "On a schedule" else "Never", Icons.Rounded.Repeat, i++, count, "repeat-row") { repeatMenu = true }
            DropdownMenu(repeatMenu, { repeatMenu = false }, containerColor = appColors.surface) {
                DropdownMenuItem({ Text("Never") }, { form.taskRepeats = false; repeatMenu = false }, leadingIcon = { if (!form.taskRepeats) Icon(Icons.Rounded.Check, null) })
                DropdownMenuItem({ Text("On a schedule") }, { form.taskRepeats = true; repeatMenu = false }, leadingIcon = { if (form.taskRepeats) Icon(Icons.Rounded.Check, null) })
            }
        }
        if (!form.taskRepeats) Segment(i++, count, Modifier.semantics { testTag = "task-date" }) {
            Icon(Icons.Rounded.Event, null, tint = appColors.secondary)
            Spacer(Modifier.width(24.dp))
            Text("Date", Modifier.weight(1f), style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
            Pill(pillDate(form.taskDate), tag = "task-date-pill") { picking = "date" }
        }
        SwitchRow("Time", form.taskHasTime, i++, count, "task-time", Icons.Outlined.Schedule) { form.taskHasTime = it; form.syncReminders() }
        if (form.taskHasTime) Segment(i, count) {
            Text("At", Modifier.weight(1f).padding(start = 48.dp), style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
            Pill(DayWords.clockMinute(form.taskMinute), tag = "task-time-pill") { picking = "time" }
        }
    }
    when (picking) {
        "date" -> DayDialog(form.taskDate, { it >= earliest }, { picking = null }) { form.taskDate = it }
        "time" -> MinuteDialog(form.taskMinute, { picking = null }) { form.taskMinute = it; form.syncReminders() }
    }
}

// ------------------------------------------------------------------ A sixth habit on the free plan

/** The free plan keeps five habits at once: Plus has no limit, or make room by archiving one. Tasks are always free. */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun SixthHabitSheet(store: HabitStore, name: String, onDismiss: () -> Unit, onPlus: () -> Unit) {
    ModalBottomSheet(onDismiss, containerColor = appColors.surface) {
        Column(Modifier.padding(horizontal = 24.dp).padding(bottom = 32.dp).semantics { testTag = "sixth-habit" }) {
            Text("Add a 6th habit", style = MaterialTheme.typography.headlineSmall, color = appColors.ink)
            Spacer(Modifier.height(12.dp))
            Text("The free plan keeps ${HabitStore.FREE_HABIT_LIMIT} habits at once. Plus has no limit, so ${name.ifEmpty { "this habit" }} can join them. Tasks are always free.",
                style = MaterialTheme.typography.bodyLarge, color = appColors.secondary)
            Spacer(Modifier.height(16.dp))
            store.habits.filter { !it.archived && it.kind != HabitKind.Task }.forEach { h ->
                Row(Modifier.padding(vertical = 6.dp), verticalAlignment = Alignment.CenterVertically) {
                    HabitIcon(h.symbol, h.color, 32.dp)
                    Spacer(Modifier.width(12.dp))
                    Text(h.name, style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
                }
            }
            Spacer(Modifier.height(20.dp))
            Button({ onDismiss(); onPlus() }, Modifier.fillMaxWidth().heightIn(min = 56.dp).semantics { testTag = "sixth-plus" },
                colors = ButtonDefaults.buttonColors(containerColor = appColors.ink, contentColor = appColors.onInk)) { Text("See Plus") }
            Spacer(Modifier.height(8.dp))
            androidx.compose.material3.TextButton(onDismiss, Modifier.fillMaxWidth()) {
                Text("Make room instead: archive a habit", color = appColors.ink)
            }
        }
    }
}

@Suppress("unused") private fun unusedIcon(): ImageVector = Icons.Rounded.Tag
