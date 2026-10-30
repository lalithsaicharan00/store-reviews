package com.oftenenough.app.ui.newhabit

import com.oftenenough.app.ui.components.AppDialog
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
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.ui.plus.PlusReason
import com.oftenenough.app.ui.plus.PlusScreen
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
import androidx.compose.material3.MaterialTheme
import androidx.compose.ui.graphics.Color
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.collectLatest
import java.time.Instant
import java.time.LocalDate
import java.time.ZoneId

/** Text being typed, read only by its own field, so typing redraws only the field (S11). */
class TypedText(initial: String) { var text by mutableStateOf(initial) }

private enum class Page { HOW_MUCH, UNIT, STEPS, OFTEN, TIME_OF_DAY, NEW_PART, REMINDERS, ICON, SIXTH, MAKE_ROOM }

/**
 * New: what do you want to do → (build: how to track it | quit: quit or cut down) → the form. From an idea it opens the
 * form straight away with everything the idea says filled in, so Add works at once (Onboarding 07.1, the user, 19 Oct
 * 2026).
 */
@Composable
fun NewHabitFlow(
    store: HabitStore, idea: HabitIdea?, onClose: () -> Unit, onSaved: (Habit) -> Unit, onPlus: (PlusReason) -> Unit, task: Boolean = false,
    /** Duplicate (Habits, Figma 2.2): the form filled in from this habit as "Name (copy)", its type already chosen. */
    copyOf: Habit? = null,
    /** The name typed in Habits' search (Figma 4.2: New habit "yoga"). */
    name: String? = null,
    /** At the free plan's five habits, Add a 6th habit comes first (Habits' + and Duplicate, Figma 1.9, 2.2.1). */
    roomFirst: Boolean = false,
    /** Plus turned on from a Plus screen shown inside the flow: the caller says "Plus is on". */
    onPlusOn: () -> Unit = {},
) {
    val ideaType = idea?.let { when (it.type) { "amount" -> ItemType.AMOUNT; "time" -> ItemType.TIME; "quit" -> ItemType.QUIT; "cutDown" -> ItemType.CUT_DOWN; else -> ItemType.CHECK } }
    val copyType = copyOf?.let { ItemType.of(it) }
    // Tasks' + starts at What kind of task?; a copy or an idea opens its form straight away.
    var step by rememberSaveable { mutableStateOf((copyType ?: ideaType)?.let { "form:${it.name}" } ?: if (task) "task" else "choose") }
    var repeats by rememberSaveable { mutableStateOf(false) }
    var room by rememberSaveable { mutableStateOf(if (roomFirst && !store.canAddHabit && copyType != ItemType.TASK) "sixth" else "") }
    // The free plan's five habits (Figma's "A sixth habit on the free plan"): Plus first; its ← opens Make room ("Back (←),
    // then archive one"), and Make room's ← leaves, so the two never send each other back and forth.
    if (room == "sixth") {
        PlusScreen(PlusReason.SIXTH, store, AppGraph.plus, onBack = { room = "make" }, onBought = { room = ""; onPlusOn() })
        return
    }
    if (room == "make") {
        MakeRoomPage(store, onClose) { room = "" }
        return
    }
    // Checklist on the free plan opened Plus (A73): once it's bought, the checklist form opens straight away (Figma's
    // "A checklist on the free plan", 4).
    var wantsChecklist by rememberSaveable { mutableStateOf(false) }
    LaunchedEffect(store.isPlus, step) {
        if (step != "build") wantsChecklist = false
        else if (wantsChecklist && store.isPlus) { wantsChecklist = false; step = "form:${ItemType.CHECKLIST.name}" }
    }
    when {
        step == "choose" -> {
            BackHandler(onBack = onClose)
            NewChoices(onClose, onBuild = { step = "build" }, onQuit = { step = "quit" }, onTask = { step = "task" })
        }
        step == "task" -> {
            // From Tasks' +, back closes; from What do you want to do?, it goes back there.
            val back = { if (task) onClose() else step = "choose" }
            BackHandler(onBack = back)
            TaskKinds(back) { r -> repeats = r; step = "form:${ItemType.TASK.name}" }
        }
        step == "build" -> {
            BackHandler { step = "choose" }
            TypeChoices("How do you want to track it?", listOf(ItemType.CHECK, ItemType.AMOUNT, ItemType.TIME, ItemType.CHECKLIST), { step = "choose" },
                plus = store.isPlus, onPlus = { wantsChecklist = true; onPlus(PlusReason.CHECKLIST) }) { step = "form:${it.name}" }
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
                else step = when { type == ItemType.TASK -> "task"; type == ItemType.QUIT || type == ItemType.CUT_DOWN -> "quit"; else -> "build" }
            }
            HabitForm(type, null, store, idea.takeIf { ideaType == type }, back, onSaved, onPlus, template = copyOf, prefillName = name,
                repeats = repeats.takeIf { type == ItemType.TASK && copyOf == null }, onPlusOn = onPlusOn)
        }
    }
}

/** Edit habit: the same form on a saved habit, every row as it is now; its type stays (A68). */
@Composable
fun EditHabitScreen(habitId: String, store: HabitStore, onPlus: (PlusReason) -> Unit, onClose: () -> Unit) {
    val habit = store.habit(habitId) ?: run { LaunchedEffect(Unit) { onClose() }; return }
    HabitForm(ItemType.of(habit), habit, store, null, onClose, { onClose() }, onPlus)
}

/**
 * 5.7.3, **Create new form** (Figma 1065:2597; Components — Atoms Build Plan): New habit, New task, Edit habit and Edit
 * task, the type already chosen. On Surface container: the Top app bar (←, the title, Add or Save, a Filled Small
 * button, quiet until there's a name); then one list of rows, 16 at the sides and above, 40 under, 16 between groups,
 * 2 within them, on Surface bright: the name (focused, the keyboard up) and the description, then Icon | Colour; the
 * type's own rows (How much, How long, Steps or Limit, then How often; a quit habit's Started | At; a task's Date and
 * Time, or How often and Time); Time of day and Reminders; Starts and Ends. Each row says what's chosen and opens its
 * page. No preview, no groups, and no Type row: a habit keeps the type it was made with (A68).
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun HabitForm(
    type: ItemType, original: Habit?, store: HabitStore, idea: HabitIdea?, onClose: () -> Unit, onSaved: (Habit) -> Unit, onPlus: (PlusReason) -> Unit,
    template: Habit? = null, prefillName: String? = null,
    /** A new task's kind, chosen on What kind of task? (5.7.14). */
    repeats: Boolean? = null,
    onPlusOn: () -> Unit = {},
) {
    val form = remember {
        FormState(type, original, store, template).also { f ->
            repeats?.let { f.taskRepeats = it }
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
    val nameFocus = remember { FocusRequester() }
    // The pages' words catch up when typing pauses (0.3 s); Add follows at once (S11).
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
    /** What's still needed before Add: its page opens. */
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
        onSaved(habit)
    }
    fun save() {
        form.name = typed.text
        form.description = describing.text
        if (!form.nameFilled) { runCatching { nameFocus.requestFocus() }; return } // nothing turns red (A65)
        missingPage()?.let { open(it); return }
        if (form.original != null) {
            val habit = form.edited(form.trimmedName) ?: return
            store.update(habit)
            store.setDescription(TextLimit.clean(describing.text, TextLimit.DESCRIPTION), habit.id)
            saveAlerts(habit)
            onSaved(habit)
            return
        }
        // The free plan's five habits at once (Figma 5): Plus, or make room.
        if (form.type.isHabit && !store.canAddHabit) { open(Page.SIXTH); return }
        add()
    }

    when (pages.lastOrNull()) {
        Page.HOW_MUCH -> when {
            form.timed -> HowLongPage(form, ::back)
            form.type == ItemType.CUT_DOWN -> LimitPage(form, { open(Page.UNIT) }, ::back)
            else -> HowMuchPage(form, { open(Page.UNIT) }, ::back)
        }
        Page.UNIT -> UnitPage(form, store, ::back)
        Page.STEPS -> StepsPage(form, ::back)
        Page.OFTEN -> HowOftenPage(form, ::back)
        Page.TIME_OF_DAY -> TimeOfDayPage(form, store, ::back) { open(Page.NEW_PART) }
        Page.NEW_PART -> com.oftenenough.app.ui.settings.SectionEditorScreen(store, null) { id -> back(); id?.let { form.choose(it) } }
        Page.REMINDERS -> RemindersPage(form, store, ::back) { onPlus(PlusReason.REMIND) }
        Page.ICON -> IconPage(form, ::back)
        // ← on Plus opens Make room in its place; Make room's ← is back on the form.
        Page.SIXTH -> PlusScreen(PlusReason.SIXTH, store, AppGraph.plus, onBack = { pages = pages.dropLast(1) + Page.MAKE_ROOM },
            onBought = { pages = emptyList(); onPlusOn(); add() })
        Page.MAKE_ROOM -> MakeRoomPage(store, ::back) { pages = emptyList(); add() }
        null -> FormBody(form, store, typed, describing, scroll, nameFocus, ::open, ::close, ::save)
    }
    if (discard) DiscardDialog(if (form.editing) "Discard your changes?" else if (form.type == ItemType.TASK) "Discard this task?" else "Discard this habit?",
        if (form.editing) "${form.original?.name ?: "It"} stays as it was." else if (form.type == ItemType.TASK) "This task won’t be added." else "This habit won’t be added.",
        onKeep = { discard = false }, onDiscard = { discard = false; onClose() }, keepLabel = "Keep editing")
}

/** The form's rows sit on Surface bright (Figma). */
private val rowColor: Color @Composable get() = MaterialTheme.colorScheme.surfaceBright

@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun FormBody(
    form: FormState, store: HabitStore, typed: TypedText, describing: TypedText, scroll: androidx.compose.foundation.ScrollState,
    nameFocus: FocusRequester, open: (Page) -> Unit, close: () -> Unit, save: () -> Unit,
) {
    val type = form.type
    var colours by remember { mutableStateOf(false) }
    BackHandler(onBack = close)
    Column(Modifier.fillMaxSize().background(MaterialTheme.colorScheme.surfaceContainer).imePadding()) {
        AppTopBar(
            formTitle(form),
            navigationIcon = { IconButton(close, Modifier.semantics { testTag = "form-back" }) { Icon(Symbols.ArrowBack, "Back") } },
            // Quiet until there's a name (A65); with one, a tap still opens whatever else is missing.
            actions = { AppButton(if (form.editing) "Save" else "Add", save, Modifier.padding(end = 12.dp), enabled = form.nameFilled, tag = "form-add") },
        )
        Column(Modifier.fillMaxWidth().verticalScroll(scroll).padding(start = 16.dp, end = 16.dp, top = 16.dp, bottom = 40.dp).navigationBarsPadding(),
            verticalArrangement = Arrangement.spacedBy(16.dp)) {
            NameGroup(form, typed, describing, nameFocus, onIcon = { open(Page.ICON) }, onColour = { colours = true })
            when (type) {
                ItemType.QUIT -> {
                    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                        QuitStarted(form, store)
                        Footer("The run counts up from here. A slip starts it again.")
                    }
                    MilestoneSwitch(form, store)
                }
                ItemType.TASK -> {
                    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                        TaskRows(form, store, open)
                        Footer(when {
                            form.taskRepeats -> "It comes back on the days you pick."
                            form.taskHasNoDate -> "Saved without a date, it stays on the Tasks page, under No date. It won’t show on Today until you give it a day."
                            else -> "If it isn’t done, it moves to today until it is."
                        })
                    }
                    PlaceRows(form, store, open, withTime = true)
                    if (form.taskRepeats) StartEndRows(form, store)
                }
                else -> {
                    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                        PlanRows(form, open)
                        goalNote(form, store)?.let { Text(it, Modifier.padding(horizontal = 16.dp), style = AppType.bodyMedium, color = MaterialTheme.colorScheme.onSurfaceVariant) }
                    }
                    PlaceRows(form, store, open, withTime = type != ItemType.CUT_DOWN)
                    StartEndRows(form, store)
                    if (type == ItemType.CUT_DOWN) MilestoneSwitch(form, store)
                }
            }
        }
    }
    if (colours) ColourSheet(form) { colours = false }
}

/** A group's footer (Figma's Footer): Body Small On surface variant, 16 in, 8 under its rows. */
@Composable
private fun Footer(text: String) =
    Text(text, Modifier.padding(horizontal = 16.dp).semantics { testTag = "form-footer" }, style = AppType.bodySmall, color = MaterialTheme.colorScheme.onSurfaceVariant)

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

/** A one-time task's day on the form (Figma): "Today · Fri, 23 Oct", "Tomorrow · Sat, 24 Oct", "Thu, 29 Oct", "No date". */
private fun taskDateWords(day: Int, today: Int): String = when (day) {
    com.oftenenough.app.data.NO_DATE_DAY -> "No date"
    today -> "Today · " + formDay(day, today)
    today + 1 -> "Tomorrow · " + formDay(day, today)
    else -> formDay(day, today)
}

/** "Wed, 2 Sep", with its year in another year ("Wed, 2 Sep 2027"). */
private fun formDay(day: Int, today: Int): String =
    DayWords.short(day) + if (LocalDate.ofEpochDay(day.toLong()).year != LocalDate.ofEpochDay(today.toLong()).year) " " + LocalDate.ofEpochDay(day.toLong()).year else ""

private fun formTitle(form: FormState): String = when {
    form.editing -> if (form.type == ItemType.TASK) "Edit task" else "Edit habit"
    form.type == ItemType.TASK -> "New task"
    else -> "New habit"
}

/**
 * A goal or How often changed in Edit (Figma's Edit habit, 4): it starts today, said under the rows; the days before keep
 * their goal (D6). No extra step.
 */
private fun goalNote(form: FormState, store: HabitStore): String? {
    val o = form.original ?: return null
    val e = form.edited(o.name) ?: return null
    if (e.goal == o.goal && e.frequency == o.frequency && e.kind == o.kind) return null
    return "The new goal starts today. Days before keep ${HabitCopy.plan(o, store.weekStart)}."
}

// ------------------------------------------------------------------ Name, icon and colour

/** The name, the description, and Icon | Colour, as one group (Figma's About). */
@Composable
private fun NameGroup(form: FormState, typed: TypedText, describing: TypedText, focus: FocusRequester, onIcon: () -> Unit, onColour: () -> Unit) {
    Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
        NameField(typed, form.type.namePlaceholder, focus, autoFocus = !form.editing && typed.text.isEmpty())
        DescriptionField(describing)
        Row(Modifier.height(IntrinsicSize.Min), horizontalArrangement = Arrangement.spacedBy(2.dp)) {
            HalfRow("Icon", "icon-row", RoundedCornerShape(4.dp, 4.dp, 4.dp, 24.dp), Modifier.weight(1f), onIcon) {
                HabitIcon(form.symbol, form.color, 40.dp)
            }
            HalfRow("Colour", "colour-row", RoundedCornerShape(4.dp, 4.dp, 24.dp, 4.dp), Modifier.weight(1f), onColour) {
                Box(Modifier.size(40.dp).clip(CircleShape).background(appColors.habit(form.color)))
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
        keyboardOptions = KeyboardOptions(capitalization = KeyboardCapitalization.Sentences), containerColor = rowColor)
    TextLimit.note(typed.text, TextLimit.NAME)?.let { Text(it, Modifier.padding(start = 16.dp, top = 4.dp), style = AppType.bodySmall, color = MaterialTheme.colorScheme.onSurfaceVariant) }
}

/** The description, second in the group (Form field, Middle), up to four lines. */
@Composable
private fun DescriptionField(describing: TypedText) =
    FormField(describing.text, { describing.text = it.take(TextLimit.DESCRIPTION) }, "Description (optional)", 1, 3,
        fieldModifier = Modifier.semantics { testTag = "description-field"; contentDescription = "Description" }, maxLines = 4,
        keyboardOptions = KeyboardOptions(capitalization = KeyboardCapitalization.Sentences), containerColor = rowColor)

/** Icon or Colour: a one-line List item, half the width: its 40 lead, 8, the word in Title Medium, › (Figma). */
@Composable
private fun HalfRow(title: String, tag: String, shape: RoundedCornerShape, modifier: Modifier, onClick: () -> Unit, lead: @Composable () -> Unit) {
    val s = MaterialTheme.colorScheme
    Row(modifier.fillMaxHeight().clip(shape).background(rowColor).clickable(role = Role.Button, onClick = onClick).semantics { testTag = tag }.heightIn(min = 56.dp)
        .padding(start = 16.dp, end = 12.dp, top = 8.dp, bottom = 8.dp), verticalAlignment = Alignment.CenterVertically) {
        lead()
        Spacer(Modifier.width(8.dp))
        Text(title, Modifier.weight(1f), style = AppType.titleMedium, color = s.onSurface)
        Icon(Symbols.ChevronRight, null, tint = s.onSurfaceVariant)
    }
}

// ------------------------------------------------------------------ Rows by type

/** How much / Limit / How long / Steps, then How often (a check: How often alone). */
@Composable
private fun PlanRows(form: FormState, open: (Page) -> Unit) {
    val type = form.type
    val plan = form.plan
    SegmentedList {
        val count = if (type == ItemType.CHECK) 1 else 2
        val notSet = "Not set yet"
        when (type) {
            // "8 glasses · each tap adds 1" (Figma's Edit habit): the amount, and what one tap adds.
            ItemType.AMOUNT -> OpenRow("How much", if (form.amountValue == null) notSet
                else plan.howMuchLabel + if (form.asks) " · typed each time" else " · each tap adds " + HabitCopy.number(plan.stepValue),
                null, 0, count, "how-much-row", rowColor) { open(Page.HOW_MUCH) }
            ItemType.CUT_DOWN -> OpenRow("Limit", if (form.amountValue == null) notSet else plan.howMuchLabel, null, 0, count, "how-much-row", rowColor) { open(Page.HOW_MUCH) }
            ItemType.TIME -> OpenRow("How long", if (form.amountValue == null) notSet else plan.howMuchLabel, null, 0, count, "how-much-row", rowColor) { open(Page.HOW_MUCH) }
            ItemType.CHECKLIST -> {
                val n = form.filledItems.size
                OpenRow("Steps", if (n == 0) "None yet" else if (n == 1) "1 step" else "$n steps", null, 0, count, "steps-row", rowColor) { open(Page.STEPS) }
            }
            else -> {}
        }
        OpenRow("How often", plan.often.label(plan.hasAmount || form.hasAmount, plan.checklist, form.weekStart), null, count - 1, count, "how-often-row", rowColor) { open(Page.OFTEN) }
    }
}

/** Time of day and Reminders (a limit has no time of day: it shows under Quitting). */
@Composable
private fun PlaceRows(form: FormState, store: HabitStore, open: (Page) -> Unit, withTime: Boolean) {
    SegmentedList {
        val count = if (withTime) 2 else 1
        if (withTime) OpenRow("Time of day", HabitCopy.join(form.timesOfDay.map { store.section(it).name }), null, 0, count, "time-of-day-row", rowColor) { open(Page.TIME_OF_DAY) }
        OpenRow("Reminders", form.remindersSummary(), null, count - 1, count, "reminders-row", rowColor) { open(Page.REMINDERS) }
    }
}

/** "Today", "Tomorrow", "Yesterday", or "Wed, 2 Sep": a day as a person says it, counted from the app's today (D7). */
private fun dayWords(day: Int, today: Int): String = when (day) {
    today -> "Today"; today + 1 -> "Tomorrow"; today - 1 -> "Yesterday"; else -> formDay(day, today)
}

/** Starts (or Started, in the past) and Ends: a menu, Never or On a date… (Figma's Starts and Ends). */
@Composable
private fun StartEndRows(form: FormState, store: HabitStore) {
    val today = store.today()
    // A habit with logs can't start after its first one: no log is ever hidden (Habit details, Figma 1373:2, 5.1, 5.3).
    val firstLog = remember(form.original) { form.original?.let { h -> store.entries(h.id).minOfOrNull { it.day } } }
    var picking by remember { mutableStateOf<String?>(null) }
    var endsMenu by remember { mutableStateOf(false) }
    SegmentedList {
        OpenRow(if (form.startDate < today) "Started" else "Starts", dayWords(form.startDate, today), null, 0, 2, "starts-row", rowColor) { picking = "start" }
        Box {
            val ends = if (form.hasEnd) dayWords(form.endDate, today) else "Never"
            AppListItem("Ends", 1, 2, Modifier.semantics(mergeDescendants = true) { contentDescription = "Ends, $ends" }, ends,
                trailing = { Icon(Symbols.ArrowDropDown, null) }, onClick = { endsMenu = true }, containerColor = rowColor, tag = "ends-row")
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
    when (picking) {
        "start" -> DayDialog(form.startDate, { firstLog == null || it <= firstLog }, { picking = null }, title = if (form.startDate < today) "Started" else "Starts",
            note = firstLog?.let { "Up to ${DayWords.dayMonth(it)}, the first log, so no log is hidden." } ?: "A start date in the past lets you tick the days since then.") { form.startDate = it; if (form.hasEnd && form.endDate < it) form.endDate = it }
        "end" -> DayDialog(maxOf(form.endDate, form.startDate), { it >= form.startDate }, { picking = null }, title = "Ends",
            note = "After it, the habit leaves Today. Its history stays.") { form.endDate = it; form.hasEnd = true }
    }
}

/** Quit (Figma): Started (the day) | At (the time), never later than now; each opens Android's own picker. */
@Composable
private fun QuitStarted(form: FormState, store: HabitStore) {
    val zone = ZoneId.systemDefault()
    val at = Instant.ofEpochMilli(form.quitSince).atZone(zone)
    var picking by remember { mutableStateOf<String?>(null) }
    val today = store.today()
    Row(Modifier.fillMaxWidth().height(IntrinsicSize.Min).semantics { testTag = "quit-started" }, horizontalArrangement = Arrangement.spacedBy(2.dp)) {
        HalfValue("Started", dayWords(at.toLocalDate().toEpochDay().toInt(), today), "quit-date", RoundedCornerShape(24.dp, 4.dp, 4.dp, 24.dp), Modifier.weight(1f)) { picking = "date" }
        HalfValue("At", DayWords.clock(form.quitSince), "quit-time", RoundedCornerShape(4.dp, 24.dp, 24.dp, 4.dp), Modifier.weight(1f)) { picking = "time" }
    }
    val now = store.clock()
    val lastDay = Instant.ofEpochMilli(now).atZone(zone).toLocalDate().toEpochDay()
    when (picking) {
        "date" -> DayDialog(at.toLocalDate().toEpochDay().toInt(), { it <= lastDay }, { picking = null },
            title = "Started", note = "The run counts up from here.") { day ->
            form.quitSince = minOf(now, LocalDate.ofEpochDay(day.toLong()).atTime(at.toLocalTime()).atZone(zone).toInstant().toEpochMilli())
        }
        "time" -> MinuteDialog(at.hour * 60 + at.minute, { picking = null }) { m ->
            form.quitSince = minOf(now, at.toLocalDate().atTime(m / 60, m % 60).atZone(zone).toInstant().toEpochMilli())
        }
    }
}

/** One half of a pair of rows: its title over its value, then › (Figma's Started | At). */
@Composable
private fun HalfValue(title: String, value: String, tag: String, shape: RoundedCornerShape, modifier: Modifier, onClick: () -> Unit) {
    val s = MaterialTheme.colorScheme
    Row(modifier.fillMaxHeight().clip(shape).background(rowColor).clickable(onClick = onClick)
        .semantics(mergeDescendants = true) { testTag = tag; contentDescription = "$title, $value" }
        .heightIn(min = 72.dp).padding(start = 16.dp, end = 12.dp), verticalAlignment = Alignment.CenterVertically) {
        Column(Modifier.weight(1f)) {
            Text(title, style = AppType.titleMedium, color = s.onSurface, maxLines = 1)
            Text(value, style = AppType.bodyMedium, color = s.onSurfaceVariant)
        }
        Spacer(Modifier.width(8.dp))
        Icon(Symbols.ChevronRight, null, tint = s.onSurfaceVariant)
    }
}

/**
 * A task (Figma's Task once · Task on repeat), its kind chosen before the form: its Date (a menu: Today, Tomorrow, Pick
 * a date…, No date) or How often, then Time (a switch; turning it on waits for the picker's OK).
 */
@Composable
private fun TaskRows(form: FormState, store: HabitStore, open: (Page) -> Unit) {
    var picking by remember { mutableStateOf<String?>(null) }
    var dateMenu by remember { mutableStateOf(false) }
    val today = store.today()
    val earliest = form.original?.dueDay?.takeIf { it != com.oftenenough.app.data.NO_DATE_DAY }?.let { minOf(today, it) } ?: today
    SegmentedList {
        val count = 1 + (if (form.taskHasNoDate) 0 else 1)
        var i = 0
        if (form.taskRepeats) OpenRow("How often", form.often.often(false).label(false, weekStart = form.weekStart), null, i++, count, "how-often-row", rowColor) { open(Page.OFTEN) }
        else Box {
            OpenRow("Date", taskDateWords(form.taskDate, today), null, i++, count, "task-date", rowColor) { dateMenu = true }
            AppMenu(dateMenu, { dateMenu = false }, Modifier.width(240.dp).semantics { testTagsAsResourceId = true }, offset = DpOffset(88.dp, 0.dp)) {
                val item = @Composable { text: String, icon: ImageVector, tag: String, pick: () -> Unit ->
                    AppMenuItem(text, { dateMenu = false; pick() }, icon = icon, tag = tag)
                }
                item("Today", Symbols.Today, "task-date-today") { form.taskDate = today }
                item("Tomorrow · " + formDay(today + 1, today), Symbols.CalendarMonth, "task-date-tomorrow") { form.taskDate = today + 1 }
                item("Pick a date…", Symbols.EditCalendar, "task-date-pick") { picking = "date" }
                item("No date", Symbols.EventBusy, "task-date-none") { form.taskDate = com.oftenenough.app.data.NO_DATE_DAY }
            }
        }
        if (!form.taskHasNoDate) AppListItem("Time", i, count, onClick = { picking = "time" }, tag = "task-time", containerColor = rowColor,
            below = if (form.taskHasTime) ({ Text(DayWords.clockMinute(form.taskMinute), Modifier.semantics { testTag = "task-time-pill" }) }) else null,
            trailing = { AppSwitch(form.taskHasTime, onCheckedChange = { on -> if (on) picking = "time" else { form.taskHasTime = false; form.syncReminders() } }) })
    }
    when (picking) {
        "date" -> DayDialog(if (form.taskHasNoDate) today else form.taskDate, { it >= earliest }, { picking = null }) { form.taskDate = it }
        // Turning Time on waits for OK: Cancel leaves it off.
        "time" -> MinuteDialog(form.taskMinute, { picking = null }) { form.taskMinute = it; form.taskHasTime = true; form.syncReminders() }
    }
}
