package com.oftenenough.app.ui.newhabit

import com.oftenenough.app.ui.components.FormField
import com.oftenenough.app.ui.components.AppMenuItem
import androidx.compose.ui.unit.DpOffset
import com.oftenenough.app.ui.components.AppMenu
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.AppSwitch
import com.oftenenough.app.ui.components.AppTopBar
import com.oftenenough.app.ui.theme.AppType

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.ui.semantics.Role
import androidx.compose.material3.AlertDialog
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.IntrinsicSize
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
import androidx.compose.material3.Button
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Text
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
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.text.input.KeyboardCapitalization
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitCopy
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.TextLimit
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.AppFilledIconButton
import com.oftenenough.app.ui.components.Segment
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.onboarding.HabitIdea
import com.oftenenough.app.ui.record.DiscardDialog
import com.oftenenough.app.ui.record.GoalNumber
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.collectLatest
import java.time.Instant
import java.time.LocalDate
import java.time.ZoneId

/** Text being typed, read only by its own field, so typing redraws only the field (S11). */
class TypedText(initial: String) { var text by mutableStateOf(initial) }

private enum class Page { HOW_MUCH, UNIT, STEPS, OFTEN, TIME_OF_DAY, NEW_PART, GROUP, REMINDERS, ICON, TYPE, SIXTH, MAKE_ROOM }

/**
 * New: what do you want to do → (build: how to track it | quit: quit or cut down) → the form. From an idea it opens the
 * form straight away with everything the idea says filled in, so Add works at once (Onboarding 07.1, the user, 19 Oct
 * 2026).
 */
@Composable
fun NewHabitFlow(
    store: HabitStore, idea: HabitIdea?, onClose: () -> Unit, onSaved: (Habit) -> Unit, onPlus: () -> Unit, task: Boolean = false,
    /** Duplicate (Habits, Figma 2.2): the form filled in from this habit as "Name (copy)", its type already chosen. */
    copyOf: Habit? = null,
    /** The name typed in Habits' search (Figma 4.2: New habit "yoga"). */
    name: String? = null,
    /** At the free plan's five habits, Add a 6th habit comes first (Habits' + and Duplicate, Figma 1.9, 2.2.1). */
    roomFirst: Boolean = false,
) {
    val ideaType = idea?.let { when (it.type) { "amount" -> ItemType.AMOUNT; "time" -> ItemType.TIME; "quit" -> ItemType.QUIT; "cutDown" -> ItemType.CUT_DOWN; else -> ItemType.CHECK } }
    val copyType = copyOf?.let { ItemType.of(it) }
    // ≡ › Tasks' + opens the task form straight away.
    var step by rememberSaveable { mutableStateOf(if (task) "form:${ItemType.TASK.name}" else (copyType ?: ideaType)?.let { "form:${it.name}" } ?: "choose") }
    var room by rememberSaveable { mutableStateOf(if (roomFirst && !store.canAddHabit && copyType != ItemType.TASK) "sixth" else "") }
    if (room == "sixth") {
        SixthHabitPage(store, onClose, onMakeRoom = { room = "make" }, onPlus = onPlus, onBought = { room = "" })
        return
    }
    if (room == "make") {
        MakeRoomPage(store, { room = "sixth" }) { room = "" }
        return
    }
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
            // From an idea or a copy, back closes the flow; the step itself never goes blank, since this screen can be drawn
            // once more while it leaves (an empty step made `ItemType.valueOf("")` throw).
            val back = {
                if (idea != null || copyOf != null) onClose()
                else step = when { type == ItemType.TASK -> "choose"; type == ItemType.QUIT || type == ItemType.CUT_DOWN -> "quit"; else -> "build" }
            }
            HabitForm(type, null, store, idea.takeIf { ideaType == type }, back, onSaved, onPlus, template = copyOf, prefillName = name)
        }
    }
}

/** Edit habit: the same form on a saved habit, every row as it is now. [onStartedOver]: a new type started it over. */
@Composable
fun EditHabitScreen(habitId: String, store: HabitStore, onClose: () -> Unit, onStartedOver: () -> Unit = onClose) {
    val habit = store.habit(habitId) ?: run { LaunchedEffect(Unit) { onClose() }; return }
    HabitForm(ItemType.of(habit), habit, store, null, onClose, { onClose() }, {}, onStartedOver)
}

/** The New Habit (or Edit) form: the preview, the name, then the rows each type needs, each opening its own page. */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun HabitForm(
    type: ItemType, original: Habit?, store: HabitStore, idea: HabitIdea?, onClose: () -> Unit, onSaved: (Habit) -> Unit, onPlus: () -> Unit,
    onStartedOver: () -> Unit = {}, template: Habit? = null, prefillName: String? = null,
) {
    val form = remember {
        FormState(type, original, store, template).also { f ->
            idea?.let { f.applyIdea(it) }
            prefillName?.let { n -> f.name = TextLimit.clean(n, TextLimit.NAME); f.nameFilled = f.name.isNotBlank() }
            if (idea != null) f.markPristine()
        }
    }
    val typed = remember { TypedText(form.name) }
    val describing = remember { TypedText(form.description) }
    var pages by remember { mutableStateOf(listOf<Page>()) }
    val scroll = rememberScrollState()
    var discard by remember { mutableStateOf(false) }
    var startOver by remember { mutableStateOf(false) }
    val nameFocus = remember { FocusRequester() }
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
    /** Tell me at milestones: kept with the habit's settings, only for quit and cut down. */
    fun saveAlerts(habit: Habit) {
        val on = form.milestoneAlerts && (form.type == ItemType.QUIT || form.type == ItemType.CUT_DOWN)
        val key = com.oftenenough.app.app.reminders.MilestoneAlerts.key(habit.id)
        if (on != (store.setting(key) == "true")) store.saveAppSetting(key, if (on) "true" else null)
    }
    /** What's still needed before Add: its page opens (a name says so where it's typed). */
    fun missingPage(): Page? = when {
        form.hasAmount && form.amountValue == null -> Page.HOW_MUCH
        form.type == ItemType.CHECKLIST && form.filledItems.isEmpty() -> Page.STEPS
        !form.canAdd -> Page.OFTEN
        else -> null
    }
    fun add() {
        val habit = form.makeHabit(form.trimmedName)
        store.add(habit)
        store.setDescription(TextLimit.clean(describing.text, TextLimit.DESCRIPTION), habit.id)
        saveAlerts(habit)
        form.groupId?.let { g -> if (store.groups.any { it.id == g }) store.setGroup(g, habit.id) }
        onSaved(habit)
    }
    fun save() {
        form.name = typed.text
        form.description = describing.text
        if (!form.nameFilled) { runCatching { nameFocus.requestFocus() }; return } // nothing turns red (A65)
        missingPage()?.let { open(it); return }
        val o = form.original
        if (o != null) {
            if (form.typeChanged) { startOver = true; return }
            val habit = form.edited(form.trimmedName) ?: return
            store.update(habit)
            store.setDescription(TextLimit.clean(describing.text, TextLimit.DESCRIPTION), habit.id)
            saveAlerts(habit)
            if (form.groupId != form.originalGroupId) store.setGroup(form.groupId, habit.id)
            onSaved(habit)
            return
        }
        // The free plan's five habits at once (Figma 5): Plus, or make room.
        if (form.type.isHabit && !store.canAddHabit) { open(Page.SIXTH); return }
        add()
    }
    /** A new type, agreed (Figma 6.3.1): the old habit archived with all it had, a new one in its place from today. */
    fun startOverNow() {
        val o = form.original ?: return
        val fresh = form.makeHabit(form.trimmedName)
        store.startOver(o, fresh, form.type.title)
        store.setDescription(TextLimit.clean(describing.text, TextLimit.DESCRIPTION), fresh.id)
        saveAlerts(fresh)
        form.groupId?.let { g -> if (store.groups.any { it.id == g }) store.setGroup(g, fresh.id) }
        onStartedOver()
    }

    when (pages.lastOrNull()) {
        Page.HOW_MUCH -> if (form.timed) HowLongPage(form, ::back) else HowMuchPage(form, { open(Page.UNIT) }, ::back)
        Page.UNIT -> UnitPage(form, store, ::back)
        Page.STEPS -> StepsPage(form, ::back)
        Page.OFTEN -> HowOftenPage(form, ::back)
        Page.TIME_OF_DAY -> TimeOfDayPage(form, store, ::back) { open(Page.NEW_PART) }
        Page.NEW_PART -> com.oftenenough.app.ui.settings.SectionEditorScreen(store, null) { id -> back(); id?.let { form.choose(it) } }
        Page.GROUP -> GroupPage(form, store, ::back)
        Page.REMINDERS -> RemindersPage(form, store, ::back)
        Page.ICON -> IconPage(form, ::back)
        Page.TYPE -> TypePage(form, ::back)
        Page.SIXTH -> SixthHabitPage(store, ::back, onMakeRoom = { open(Page.MAKE_ROOM) }, onPlus = onPlus, onBought = { pages = emptyList(); add() })
        Page.MAKE_ROOM -> MakeRoomPage(store, ::back) { pages = emptyList(); add() }
        null -> FormBody(form, store, typed, describing, scroll, nameFocus, ::open, ::close, ::save)
    }
    if (discard) DiscardDialog(if (form.editing) "Discard your changes?" else if (form.type == ItemType.TASK) "Discard this task?" else "Discard this habit?",
        onKeep = { discard = false }, onDiscard = { discard = false; onClose() }, keepLabel = "Keep editing")
    if (startOver) {
        val o = form.original
        val name = o?.name ?: form.trimmedName
        val kind = form.type.title
        AlertDialog({ startOver = false }, title = { Text("Start $name over as $kind?") },
            text = {
                Text(if (o?.kind == HabitKind.Quit) "Changing $name to $kind starts it over from today. Your old $name, with its quit run and slips, is kept in Archived habits."
                    else "Changing $name to $kind starts it over from today. Your old $name and its history are kept in Archived habits.")
            },
            confirmButton = { AppButton("Start over", { startOver = false; startOverNow() }, Modifier.semantics { testTag = "start-over" }, style = ButtonStyle.Text) },
            dismissButton = { AppButton("Cancel", { startOver = false }, style = ButtonStyle.Text) })
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun FormBody(
    form: FormState, store: HabitStore, typed: TypedText, describing: TypedText, scroll: androidx.compose.foundation.ScrollState,
    nameFocus: FocusRequester, open: (Page) -> Unit, close: () -> Unit, save: () -> Unit,
) {
    val type = form.type
    var colours by remember { mutableStateOf(false) }
    BackHandler(onBack = close)
    Column(Modifier.fillMaxSize().background(appColors.screen).imePadding()) {
        AppTopBar(
            formTitle(form),
            navigationIcon = { IconButton(close, Modifier.semantics { testTag = "form-back" }) { Icon(Symbols.ArrowBack, "Back") } },
            actions = { AddButton(if (form.editing) "Save" else "Add", ready = form.canAdd, onClick = save) },
        )
        Column(Modifier.fillMaxWidth().verticalScroll(scroll).padding(horizontal = 16.dp).padding(top = 8.dp, bottom = 24.dp).navigationBarsPadding(),
            verticalArrangement = Arrangement.spacedBy(16.dp)) {
            if (type != ItemType.QUIT) Preview(form)
            NameGroup(form, typed, describing, nameFocus, onIcon = { open(Page.ICON) }, onColour = { colours = true })
            when (type) {
                ItemType.QUIT -> {
                    if (form.editing) SegmentedList { OpenRow("Type", type.title, null, 0, 1, "type-row") { open(Page.TYPE) } }
                    Column {
                        QuitStarted(form, store)
                        Note("The counter runs from here. It shows on Today under Quit or Cut Down, counting up.")
                    }
                    SegmentedList { OpenRow("Group", groupName(form, store), null, 0, 1, "group-row") { open(Page.GROUP) } }
                    MilestoneSwitch(form, store)
                }
                ItemType.TASK -> {
                    Column {
                        TaskRows(form, store)
                        Note(when {
                            form.taskRepeats -> "It comes back on the days you pick below."
                            form.taskHasNoDate -> "Saved without a date, it stays on the Tasks page, under No date. It won't show on Today until you give it a day."
                            else -> "If it isn't done, it moves forward to today until it is."
                        } + " Tasks don't have progress or stats.")
                    }
                    if (form.taskRepeats) SegmentedList {
                        OpenRow("How often", form.often.often(false).label(false, weekStart = form.weekStart), null, 0, 1, "how-often-row") { open(Page.OFTEN) }
                    }
                    PlaceRows(form, store, open, withTime = true)
                    if (form.taskRepeats) StartEndRows(form, store)
                }
                ItemType.CUT_DOWN -> {
                    Column { PlanRows(form, open); goalNote(form, store)?.let { Note(it) } }
                    Column {
                        PlaceRows(form, store, open, withTime = false)
                        Note("It shows on Today under Quit or Cut Down. Log it only when it happens.")
                    }
                    StartEndRows(form, store)
                    MilestoneSwitch(form, store)
                }
                else -> {
                    Column { PlanRows(form, open); goalNote(form, store)?.let { Note(it) } }
                    if (type == ItemType.AMOUNT) TapRows(form)
                    PlaceRows(form, store, open, withTime = true)
                    StartEndRows(form, store)
                }
            }
        }
    }
    if (colours) ColourSheet(form) { colours = false }
}

/**
 * Add (or Save) in the top bar (Figma 2.1, 2.1.10): ink once everything's there; before that it looks quiet (ink at 12 %,
 * its word at 38 %) but still answers, saying what's missing.
 */
@Composable
private fun AddButton(text: String, ready: Boolean, onClick: () -> Unit) {
    val c = appColors
    Box(Modifier.padding(end = 12.dp).height(40.dp).clip(RoundedCornerShape(20.dp)).background(if (ready) c.ink else c.ink.copy(alpha = 0.12f))
        .clickable(role = Role.Button, onClick = onClick).padding(horizontal = 16.dp).semantics { testTag = "form-add" }, contentAlignment = Alignment.Center) {
        Text(text, style = AppType.labelLarge, color = if (ready) c.onInk else c.ink.copy(alpha = 0.38f))
    }
}

/**
 * Tell me at milestones (Figma N.1–N.4): off until it's turned on. The first time, Android's own dialog asks for
 * notifications (as for reminders); allowed, it stays on and says when the next one is; not allowed, it goes back off,
 * with Open settings once Android won't ask again.
 */
@Composable
private fun MilestoneSwitch(form: FormState, store: HabitStore) {
    val context = androidx.compose.ui.platform.LocalContext.current
    var refused by remember { mutableStateOf(false) }
    val ask = androidx.activity.compose.rememberLauncherForActivityResult(
        androidx.activity.result.contract.ActivityResultContracts.RequestPermission()) { granted ->
        if (granted) form.milestoneAlerts = true else { form.milestoneAlerts = false; refused = true }
    }
    Column {
        SegmentedList {
            SwitchRow("Tell me at milestones", form.milestoneAlerts, 0, 1, "milestone-alerts") { on ->
                when {
                    !on -> form.milestoneAlerts = false
                    com.oftenenough.app.app.reminders.Reminders.canPost(context) -> { form.milestoneAlerts = true; refused = false }
                    android.os.Build.VERSION.SDK_INT >= 33 && !refused -> runCatching { ask.launch(android.Manifest.permission.POST_NOTIFICATIONS) }
                    else -> refused = true
                }
            }
        }
        if (refused && !form.milestoneAlerts) {
            Note("Notifications are off for the app, so milestone notifications can't come. To get them, allow notifications in Android's settings.")
            OpenSettingsButton(context)
        } else {
            val next = if (form.milestoneAlerts) form.original?.let { com.oftenenough.app.app.reminders.MilestoneAlerts.nextText(store, it) } else null
            Note("A notification when you reach 30 days, 180 days, a year and each year after. " +
                (next ?: if (form.milestoneAlerts) "" else "Off unless you turn it on."))
        }
    }
}

/** "⚙ Open settings": Android's notification settings for the app (Figma N.4, 2.1.6.4). */
@Composable
fun OpenSettingsButton(context: android.content.Context) {
    AppButton("Open settings", {
        runCatching {
            context.startActivity(android.content.Intent(android.provider.Settings.ACTION_APP_NOTIFICATION_SETTINGS)
                .putExtra(android.provider.Settings.EXTRA_APP_PACKAGE, context.packageName))
        }
    }, Modifier.padding(start = 16.dp, top = 4.dp), style = ButtonStyle.Tonal, icon = Symbols.Settings, tag = "open-settings")
}

/** A one-time task's day on the form (Figma 1.9, 6.2): "Today · Sat 18 Oct", "Tomorrow · Sun 19 Oct", "Thu 23 Oct", "No date". */
private fun taskDateWords(day: Int, today: Int): String = when (day) {
    com.oftenenough.app.data.NO_DATE_DAY -> "No date"
    today -> "Today · " + com.oftenenough.app.data.taskDay(day)
    today + 1 -> "Tomorrow · " + com.oftenenough.app.data.taskDay(day)
    else -> if (java.time.LocalDate.ofEpochDay(day.toLong()).year == java.time.LocalDate.ofEpochDay(today.toLong()).year) com.oftenenough.app.data.taskDay(day) else pillDate(day)
}

private fun formTitle(form: FormState): String = when {
    form.editing -> if (form.type == ItemType.TASK) "Edit task" else "Edit habit"
    form.type == ItemType.TASK -> "Task"
    form.type == ItemType.QUIT -> "Quit"
    form.type == ItemType.CUT_DOWN -> "Cut down"
    else -> "New Habit"
}

/**
 * A goal or How often changed in Edit (Figma 6.1): it applies from today, said under the rows; the days before keep their
 * goal (D6). No extra step.
 */
private fun goalNote(form: FormState, store: HabitStore): String? {
    val o = form.original ?: return null
    if (form.typeChanged) return null
    val e = form.edited(o.name) ?: return null
    if (e.goal == o.goal && e.frequency == o.frequency && e.kind == o.kind) return null
    return "The new goal starts today. Days before today keep ${HabitCopy.plan(o, store.weekStart)}."
}

// ------------------------------------------------------------------ Preview and name

/** Figma 2.1's "Preview": the habit as Today would show it; until it's named, a line saying so. */
@Composable
private fun Preview(form: FormState) {
    val habit = form.previewHabit()
    val named = form.trimmedName.isNotEmpty()
    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
        Text("Preview", Modifier.padding(start = 16.dp), style = AppType.labelLarge, color = appColors.secondary)
        Row(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(appColors.surface).height(72.dp).padding(start = 16.dp, end = 12.dp)
            .semantics(mergeDescendants = true) { contentDescription = "Preview on Today"; testTag = "today-preview" }, verticalAlignment = Alignment.CenterVertically) {
            HabitIcon(habit.symbol, habit.color, 40.dp)
            Spacer(Modifier.width(16.dp))
            Column(Modifier.weight(1f)) {
                Text(habit.name, style = AppType.titleMedium, color = appColors.ink, maxLines = 1)
                previewLine(form, habit)?.let { Text(it, style = AppType.bodyMedium, color = appColors.secondary, maxLines = 1) }
            }
            val (icon, text) = when {
                habit.kind == HabitKind.Duration -> Symbols.Filled.PlayArrow to null
                habit.kind is HabitKind.Amount -> Symbols.Check to ("+" + (habit.quickIncrement?.let { GoalNumber.text(it) } ?: ""))
                habit.kind == HabitKind.Checklist -> Symbols.ExpandMore to null
                else -> Symbols.Check to null
            }
            AppFilledIconButton(icon, "", {}, color = habit.color, text = text)
        }
        if (named && form.taskHasNoDate) Text("It shows on the Tasks page under No date, not on Today.",
            Modifier.padding(horizontal = 16.dp).semantics { testTag = "habit-sentence" }, style = AppType.bodySmall, color = appColors.secondary)
        if (!named) Text(if (form.type == ItemType.TASK) "Enter a task name to see the preview." else "Enter a habit name to see the preview.",
            Modifier.padding(horizontal = 16.dp).semantics { testTag = "habit-sentence" }, style = AppType.bodySmall, color = appColors.secondary)
    }
}

private fun previewLine(form: FormState, habit: Habit): String? = when {
    form.type == ItemType.TASK -> if (form.taskRepeats) HabitCopy.capitalized(HabitCopy.rhythm(habit.frequency, form.weekStart, short = true)) else "Task"
    form.type == ItemType.CHECKLIST -> "0/${maxOf(1, form.filledItems.size)} steps"
    form.hasAmount && form.amountValue == null -> null
    habit.kind is HabitKind.Amount -> null
    else -> HabitCopy.capitalized(HabitCopy.plan(habit, form.weekStart, short = true))
}

/** The name, the description, and Icon | Colour, as one group (Figma 2.1's "Card · Name"). */
@Composable
private fun NameGroup(form: FormState, typed: TypedText, describing: TypedText, focus: FocusRequester, onIcon: () -> Unit, onColour: () -> Unit) {
    val describes = form.type != ItemType.QUIT
    Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
        NameField(typed, form.type.namePlaceholder, focus, autoFocus = !form.editing && typed.text.isEmpty())
        if (describes) DescriptionField(describing)
        Row(horizontalArrangement = Arrangement.spacedBy(2.dp)) {
            HalfRow("Icon", "icon-row", RoundedCornerShape(4.dp, 4.dp, 4.dp, 24.dp), Modifier.weight(1f), onIcon) {
                HabitIcon(form.symbol, form.color, 32.dp)
            }
            HalfRow("Colour", "colour-row", RoundedCornerShape(4.dp, 4.dp, 24.dp, 4.dp), Modifier.weight(1f), onColour) {
                Box(Modifier.size(32.dp).clip(CircleShape).background(appColors.habit(form.color)))
            }
        }
    }
}

/**
 * The name field on its own, so typing redraws only it (S11): the Form field atom (3.1), first in its group. A name is
 * at most 24 letters, and shows only what's kept (U6). With nothing typed it looks as usual: Add only stays quiet (A65).
 */
@Composable
private fun NameField(typed: TypedText, placeholder: String, focus: FocusRequester, autoFocus: Boolean) {
    LaunchedEffect(Unit) { if (autoFocus) runCatching { focus.requestFocus() } }
    FormField(typed.text, { typed.text = it.replace("\n", "").take(TextLimit.NAME) }, placeholder, 0, 3,
        fieldModifier = Modifier.focusRequester(focus).semantics { testTag = "name-field"; contentDescription = "Name" },
        keyboardOptions = KeyboardOptions(capitalization = KeyboardCapitalization.Sentences))
    TextLimit.note(typed.text, TextLimit.NAME)?.let { Text(it, Modifier.padding(start = 16.dp, top = 4.dp), style = AppType.bodySmall, color = appColors.secondary) }
}

/** The description, second in the group (Form field, Middle), up to four lines. */
@Composable
private fun DescriptionField(describing: TypedText) =
    FormField(describing.text, { describing.text = it.take(TextLimit.DESCRIPTION) }, "Description (optional)", 1, 3,
        fieldModifier = Modifier.semantics { testTag = "description-field"; contentDescription = "Description" }, maxLines = 4,
        keyboardOptions = KeyboardOptions(capitalization = KeyboardCapitalization.Sentences))

@Composable
private fun HalfRow(title: String, tag: String, shape: RoundedCornerShape, modifier: Modifier, onClick: () -> Unit, lead: @Composable () -> Unit) {
    Row(modifier.clip(shape).background(appColors.surface).clickable(onClick = onClick).semantics { testTag = tag }.heightIn(min = 56.dp)
        .padding(start = 16.dp, end = 12.dp, top = 12.dp, bottom = 12.dp), verticalAlignment = Alignment.CenterVertically) {
        lead()
        Spacer(Modifier.width(12.dp))
        Text(title, Modifier.weight(1f), style = AppType.titleMedium, color = appColors.ink)
        Icon(Symbols.KeyboardArrowRight, null, tint = appColors.secondary)
    }
}

// ------------------------------------------------------------------ Rows by type

/** (Edit: Type,) How much / Limit / How long / Steps, then How often. */
@Composable
private fun PlanRows(form: FormState, open: (Page) -> Unit) {
    val type = form.type
    val plan = form.plan
    SegmentedList {
        val typed = if (form.editing) 1 else 0
        val count = typed + (if (type == ItemType.CHECK) 1 else 2)
        if (form.editing) OpenRow("Type", type.title, null, 0, count, "type-row") { open(Page.TYPE) }
        when (type) {
            ItemType.AMOUNT -> OpenRow("How much", if (form.amountValue == null) "Set" else plan.howMuchLabel, null, typed, count, "how-much-row") { open(Page.HOW_MUCH) }
            ItemType.CUT_DOWN -> OpenRow("Limit", if (form.amountValue == null) "Set" else plan.howMuchLabel, null, typed, count, "how-much-row") { open(Page.HOW_MUCH) }
            ItemType.TIME -> OpenRow("How long", if (form.amountValue == null) "Set" else plan.howMuchLabel, null, typed, count, "how-much-row") { open(Page.HOW_MUCH) }
            ItemType.CHECKLIST -> {
                val n = form.filledItems.size
                OpenRow("Steps", if (n == 0) "Add" else if (n == 1) "1 step" else "$n steps", null, typed, count, "steps-row") { open(Page.STEPS) }
            }
            else -> {}
        }
        OpenRow("How often", plan.often.label(plan.hasAmount || form.hasAmount, plan.checklist, form.weekStart), null, count - 1, count, "how-often-row") { open(Page.OFTEN) }
    }
}

/** What + does on Today, chosen: add a set step, or type the amount each time. */
@Composable
private fun TapRows(form: FormState) {
    val plan = form.plan
    Column {
        Text("When you tap +", Modifier.padding(start = 16.dp, bottom = 8.dp), style = AppType.labelLarge, color = appColors.secondary)
        SegmentedList {
            val count = if (form.asks) 2 else 3
            RadioRow("Add a set amount", !form.asks, 0, count, "tap-adds-step") { form.asks = false }
            if (!form.asks) Segment(1, count) {
                Text("Each tap adds", Modifier.weight(1f).padding(start = 40.dp), style = AppType.bodyLarge, color = appColors.ink)
                var text by remember { mutableStateOf(form.step?.let { GoalNumber.text(it) } ?: "") }
                BasicTextField(text, { t -> text = t.filter { it.isDigit() || it == '.' || it == ',' }.take(10); form.step = GoalNumber.parse(text)?.takeIf { it > 0 } },
                    Modifier.width(72.dp).clip(RoundedCornerShape(8.dp)).background(appColors.tonal).heightIn(min = 40.dp).padding(horizontal = 12.dp, vertical = 8.dp)
                        .semantics { testTag = "tap-step"; contentDescription = "Each tap adds" },
                    textStyle = AppType.bodyLarge.copy(color = appColors.ink, textAlign = TextAlign.End), singleLine = true,
                    keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Decimal), cursorBrush = SolidColor(appColors.ink),
                    decorationBox = { inner -> Box(contentAlignment = Alignment.CenterEnd) { if (text.isEmpty()) Text(HabitCopy.number(plan.stepValue), style = AppType.bodyLarge, color = appColors.ink); inner() } })
            }
            RadioRow("Type the amount each time", form.asks, count - 1, count, "tap-asks") { form.asks = true }
        }
        Note(if (form.asks) "Tap + to type how much you did." else "Each tap on + adds ${HabitCopy.amount(plan.stepValue, plan.unit)}.")
    }
}

/** Time of Day, Group and Reminders (a limit has no time of day: it shows under Quit or Cut Down). */
@Composable
private fun PlaceRows(form: FormState, store: HabitStore, open: (Page) -> Unit, withTime: Boolean) {
    SegmentedList {
        val count = if (withTime) 3 else 2
        var i = 0
        if (withTime) OpenRow("Time of Day", HabitCopy.join(form.timesOfDay.map { store.section(it).name }), null, i++, count, "time-of-day-row") { open(Page.TIME_OF_DAY) }
        OpenRow("Group", groupName(form, store), null, i++, count, "group-row") { open(Page.GROUP) }
        OpenRow("Reminders", form.remindersSummary(), null, i, count, "reminders-row") { open(Page.REMINDERS) }
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
    // A habit with logs can't start after its first one: no log is ever hidden (Habit details, Figma 1373:2, 5.1, 5.3).
    val firstLog = remember(form.original) { form.original?.let { h -> store.entries(h.id).minOfOrNull { it.day } } }
    var picking by remember { mutableStateOf<String?>(null) }
    var endsMenu by remember { mutableStateOf(false) }
    Column {
        SegmentedList {
            OpenRow(if (form.startDate < today) "Started" else "Starts", dayWords(form.startDate, today), null, 0, 2, "starts-row") { picking = "start" }
            Box {
                OpenRow("Ends", if (form.hasEnd) dayWords(form.endDate, today) else "Never", null, 1, 2, "ends-row") { endsMenu = true }
                AppMenu(endsMenu, { endsMenu = false }, Modifier.width(200.dp).semantics { testTag = "ends-menu" }, offset = DpOffset(130.dp, 0.dp)) {
                    AppMenuItem("Never", { form.hasEnd = false; endsMenu = false }, selected = !form.hasEnd)
                    AppMenuItem("On a date…", {
                        endsMenu = false
                        if (!form.hasEnd && form.endDate <= form.startDate) form.endDate = form.startDate + 30
                        picking = "end"
                    }, selected = form.hasEnd)
                }
            }
        }
        if (form.hasEnd) Note("After ${DayWords.dayMonth(form.endDate)}, it leaves Today. Its history stays.")
        else if (form.startDate < today) Note(
            if (form.original == null) "A start date in the past lets you tick the days since then."
            else "Days from ${DayWords.dayMonth(form.startDate)} can be logged now. A day with no log counts as not done." +
                (firstLog?.let { " Started can be any day up to ${DayWords.dayMonth(it)}, the first log." } ?: ""))
    }
    when (picking) {
        "start" -> DayDialog(form.startDate, { firstLog == null || it <= firstLog }, { picking = null }, title = if (form.startDate < today) "Started" else "Starts",
            note = firstLog?.let { "Up to ${DayWords.dayMonth(it)}, the first log, so no log is hidden." } ?: "A start date in the past lets you tick the days since then.") { form.startDate = it; if (form.hasEnd && form.endDate < it) form.endDate = it }
        "end" -> DayDialog(maxOf(form.endDate, form.startDate), { it >= form.startDate }, { picking = null }, title = "Ends",
            note = "After it, the habit leaves Today. Its history stays.") { form.endDate = it; form.hasEnd = true }
    }
}

/** Quit (Figma 3.1): Started (the date) | At (the time), never later than now; each opens Android's own picker. */
@Composable
private fun QuitStarted(form: FormState, store: HabitStore) {
    val zone = ZoneId.systemDefault()
    val at = Instant.ofEpochMilli(form.quitSince).atZone(zone)
    var picking by remember { mutableStateOf<String?>(null) }
    Row(Modifier.fillMaxWidth().height(IntrinsicSize.Min).semantics { testTag = "quit-started" }, horizontalArrangement = Arrangement.spacedBy(2.dp)) {
        HalfValue("Started", pillDate(at.toLocalDate().toEpochDay().toInt()), "quit-date", RoundedCornerShape(24.dp, 4.dp, 4.dp, 24.dp), Modifier.weight(1f)) { picking = "date" }
        HalfValue("At", DayWords.clock(form.quitSince), "quit-time", RoundedCornerShape(4.dp, 24.dp, 24.dp, 4.dp), Modifier) { picking = "time" }
    }
    val now = store.clock()
    val lastDay = Instant.ofEpochMilli(now).atZone(zone).toLocalDate().toEpochDay()
    when (picking) {
        "date" -> DayDialog(at.toLocalDate().toEpochDay().toInt(), { it <= lastDay }, { picking = null },
            title = "Started", note = "The counter runs from here.") { day ->
            form.quitSince = minOf(now, LocalDate.ofEpochDay(day.toLong()).atTime(at.toLocalTime()).atZone(zone).toInstant().toEpochMilli())
        }
        "time" -> MinuteDialog(at.hour * 60 + at.minute, { picking = null }) { m ->
            form.quitSince = minOf(now, at.toLocalDate().atTime(m / 60, m % 60).atZone(zone).toInstant().toEpochMilli())
        }
    }
}

/** One half of a pair of rows: its title over its value, then › (Figma 3.1's Started | At). */
@Composable
private fun HalfValue(title: String, value: String, tag: String, shape: RoundedCornerShape, modifier: Modifier, onClick: () -> Unit) {
    Row(modifier.fillMaxHeight().clip(shape).background(appColors.surface).clickable(onClick = onClick)
        .semantics(mergeDescendants = true) { testTag = tag; contentDescription = "$title, $value" }
        .heightIn(min = 72.dp).padding(start = 16.dp, end = 12.dp), verticalAlignment = Alignment.CenterVertically) {
        Column(Modifier.weight(1f, fill = false)) {
            Text(title, style = AppType.titleMedium, color = appColors.ink, maxLines = 1)
            Text(value, style = AppType.bodyMedium, color = appColors.secondary, maxLines = 1)
        }
        Spacer(Modifier.width(8.dp))
        Icon(Symbols.KeyboardArrowRight, null, tint = appColors.secondary)
    }
}

/** A task (Figma 4, 4.2): Repeat (Never | On a schedule), its Date when it's once, and Time; each opens Android's own picker. */
@Composable
private fun TaskRows(form: FormState, store: HabitStore) {
    var repeatMenu by remember { mutableStateOf(false) }
    var picking by remember { mutableStateOf<String?>(null) }
    var dateMenu by remember { mutableStateOf(false) }
    val today = store.today()
    val earliest = form.original?.dueDay?.takeIf { it != com.oftenenough.app.data.NO_DATE_DAY }?.let { minOf(today, it) } ?: today
    SegmentedList {
        val count = (if (form.taskHasNoDate) 1 else 2) + (if (!form.taskRepeats) 1 else 0)
        var i = 0
        Box {
            OpenRow("Repeat", if (form.taskRepeats) "On a schedule" else "Never", null, i++, count, "repeat-row") { repeatMenu = true }
            AppMenu(repeatMenu, { repeatMenu = false }, Modifier.width(200.dp), offset = DpOffset(130.dp, 0.dp)) {
                AppMenuItem("Never", { form.taskRepeats = false; repeatMenu = false }, selected = !form.taskRepeats)
                AppMenuItem("On a schedule", { form.taskRepeats = true; repeatMenu = false }, selected = form.taskRepeats)
            }
        }
        // Date (Tasks, Figma 1.9): Today, Tomorrow, Pick a date… or No date, from a menu under the row.
        if (!form.taskRepeats) Box {
            OpenRow("Date", taskDateWords(form.taskDate, today), null, i++, count, "task-date") { dateMenu = true }
            AppMenu(dateMenu, { dateMenu = false }, Modifier.width(240.dp).semantics { testTagsAsResourceId = true }, offset = DpOffset(88.dp, 0.dp)) {
                val item = @Composable { text: String, icon: androidx.compose.ui.graphics.vector.ImageVector, tag: String, pick: () -> Unit ->
                    AppMenuItem(text, { dateMenu = false; pick() }, icon = icon, tag = tag)
                }
                item("Today", Symbols.Today, "task-date-today") { form.taskDate = today }
                item("Tomorrow · " + com.oftenenough.app.data.taskDay(today + 1), Symbols.CalendarMonth, "task-date-tomorrow") { form.taskDate = today + 1 }
                item("Pick a date…", Symbols.EditCalendar, "task-date-pick") { picking = "date" }
                item("No date", Symbols.EventBusy, "task-date-none") { form.taskDate = com.oftenenough.app.data.NO_DATE_DAY }
            }
        }
        if (!form.taskHasNoDate) AppListItem("Time", i, count, onClick = { picking = "time" }, tag = "task-time",
            below = if (form.taskHasTime) ({ Text(DayWords.clockMinute(form.taskMinute), Modifier.semantics { testTag = "task-time-pill" }) }) else null,
            trailing = { AppSwitch(form.taskHasTime, onCheckedChange = { on -> if (on) picking = "time" else { form.taskHasTime = false; form.syncReminders() } }) })
    }
    when (picking) {
        "date" -> DayDialog(if (form.taskHasNoDate) today else form.taskDate, { it >= earliest }, { picking = null }) { form.taskDate = it }
        // Turning Time on waits for OK: Cancel leaves it off (Figma 4.4).
        "time" -> MinuteDialog(form.taskMinute, { picking = null }) { form.taskMinute = it; form.taskHasTime = true; form.syncReminders() }
    }
}
