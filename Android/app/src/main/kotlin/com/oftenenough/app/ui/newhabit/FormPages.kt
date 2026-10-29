package com.oftenenough.app.ui.newhabit

import com.oftenenough.app.ui.components.ColourSwatch
import com.oftenenough.app.ui.components.FormFieldRemove
import com.oftenenough.app.ui.components.FormField
import com.oftenenough.app.ui.components.DayToggleSize
import com.oftenenough.app.ui.components.DayToggle
import androidx.compose.ui.graphics.vector.ImageVector
import com.oftenenough.app.ui.components.AppMenuItem
import androidx.compose.ui.unit.DpOffset
import com.oftenenough.app.ui.components.AppMenu
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.ButtonSize
import com.oftenenough.app.ui.components.rememberWholeSheetState
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.AppBottomSheet
import com.oftenenough.app.ui.components.AppFilterChip
import com.oftenenough.app.ui.components.AppFilledIconButton
import com.oftenenough.app.ui.components.AppConnectedButtons
import com.oftenenough.app.ui.components.IconButtonSize
import com.oftenenough.app.ui.components.DropdownField
import com.oftenenough.app.ui.components.SearchBarField
import com.oftenenough.app.ui.components.StandardIconButton
import com.oftenenough.app.ui.theme.AppType

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.verticalScroll
import androidx.compose.foundation.gestures.detectVerticalDragGestures
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.GridItemSpan
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.foundation.text.KeyboardActions
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.ui.semantics.heading
import androidx.compose.material3.ModalBottomSheet
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.OutlinedTextFieldDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.key
import androidx.compose.runtime.mutableFloatStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.focus.onFocusChanged
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.semantics.CustomAccessibilityAction
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.customActions
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.ExperimentalLayoutApi
import androidx.compose.foundation.layout.FlowRow
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.zIndex
import com.oftenenough.app.data.CalendarRule
import com.oftenenough.app.data.DaySection
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.GoalPeriod
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HabitCopy
import com.oftenenough.app.data.HabitGroup
import com.oftenenough.app.data.HabitPlan
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.HowOften
import com.oftenenough.app.data.OftenDraft
import com.oftenenough.app.data.OftenDraft.Choice
import com.oftenenough.app.data.FormOutcome
import com.oftenenough.app.data.Step
import com.oftenenough.app.data.TextLimit
import com.oftenenough.app.data.newId
import com.oftenenough.app.ui.components.Card
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.components.Segment
import com.oftenenough.app.ui.record.GoalNumber
import com.oftenenough.app.ui.theme.HabitIcons
import com.oftenenough.app.ui.theme.appColors
import java.util.Currency

// ------------------------------------------------------------------ How much, Limit and How long

/** Figma 2.2.1 / 3.2.1: one wide number field (the number keypad comes up), with the unit chip under it. */
@Composable
fun HowMuchPage(form: FormState, onUnit: () -> Unit, onBack: () -> Unit) {
    val limit = form.type == ItemType.CUT_DOWN
    FormPage(if (limit) "Limit" else "How much", chip = null, onBack = onBack) {
        val focus = remember { FocusRequester() }
        var focused by remember { mutableStateOf(false) }
        LaunchedEffect(Unit) { if (form.amountText.isEmpty()) runCatching { focus.requestFocus() } }
        GoalCard(oftenHeader(form)) {
            BasicTextField(
                form.amountText, { form.amountText = it.filter { c -> c.isDigit() || c == '.' || c == ',' }.take(12) },
                Modifier.fillMaxWidth().clip(RoundedCornerShape(16.dp)).background(appColors.tonal)
                    .border(if (focused) 2.dp else 0.dp, if (focused) appColors.ink else Color.Transparent, RoundedCornerShape(16.dp))
                    .heightIn(min = 80.dp).focusRequester(focus).onFocusChanged { focused = it.isFocused }
                    .semantics { testTag = "much-number"; contentDescription = if (limit) "Limit" else "Amount" },
                textStyle = AppType.displayMedium.copy(color = appColors.ink, textAlign = TextAlign.Center),
                keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Decimal, imeAction = ImeAction.Done),
                singleLine = true, cursorBrush = SolidColor(appColors.ink),
                decorationBox = { inner ->
                    Box(Modifier.padding(horizontal = 16.dp, vertical = 14.dp), contentAlignment = Alignment.Center) {
                        if (form.amountText.isEmpty() && !focused) Text(if (limit) "2" else "8", style = AppType.displayMedium.copy(color = appColors.secondary.copy(alpha = 0.45f)))
                        inner()
                    }
                },
            )
            DropdownField("Unit", form.unit.ifEmpty { "No unit" }, onUnit, Modifier.fillMaxWidth(), tag = "much-unit")
        }
        val text = form.amountText.trim()
        val error = if (text.isNotEmpty() && (GoalNumber.parse(text)?.let { it > 0 } != true)) "Enter a number above 0, with up to 2 decimal places." else null
        Note(error ?: if (limit) "Log it only when it happens. Staying at or under the limit counts as a good day."
            else "Tap the number to type it, up to 2 decimal places. The unit is optional.")
    }
}

/** The white goal card: the rhythm on top ("Every day"), then what's typed. */
@Composable
private fun GoalCard(header: String, content: @Composable ColumnScope.() -> Unit) {
    Card(Modifier.fillMaxWidth().padding(top = 8.dp)) {
        Column(Modifier.fillMaxWidth().padding(start = 16.dp, end = 16.dp, top = 20.dp, bottom = 16.dp),
            horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(16.dp)) {
            Text(header, style = AppType.labelLarge, color = appColors.secondary)
            content()
        }
    }
}

/** "Every day", "At most, every day", "A week": the rhythm the amount is for. */
private fun oftenHeader(form: FormState): String {
    val o = form.plan.often
    val phrase = o.phrase(true, false, form.weekStart)
    return if (form.type == ItemType.CUT_DOWN) "At most, $phrase" else HabitCopy.capitalized(phrase)
}

/** Figma 2.3.1: Material's time-input boxes (Hours : Minutes, the cursor in Minutes), then Quick picks as filter chips. */
@OptIn(ExperimentalLayoutApi::class)
@Composable
fun HowLongPage(form: FormState, onBack: () -> Unit) {
    FormPage("How long", chip = null, onBack = onBack) {
        val minutesFocus = remember { FocusRequester() }
        LaunchedEffect(Unit) { if (form.amountValue == null) runCatching { minutesFocus.requestFocus() } }
        GoalCard(oftenHeader(form)) {
            Row(horizontalArrangement = Arrangement.spacedBy(4.dp)) {
                TimeBox(form.hours, "Hours", "how-long-hours", Modifier) { form.hours = it }
                Box(Modifier.width(24.dp).height(72.dp), contentAlignment = Alignment.Center) {
                    Text(":", style = AppType.displayMedium.copy(color = appColors.ink))
                }
                TimeBox(form.minutes, "Minutes", "how-long-minutes", Modifier.focusRequester(minutesFocus)) { form.minutes = it }
            }
        }
        val total = form.amountValue?.toInt()
        Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
            Text("Quick picks", Modifier.padding(start = 16.dp), style = AppType.labelLarge, color = appColors.secondary)
            FlowRow(horizontalArrangement = Arrangement.spacedBy(8.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
                for (m in listOf(5, 10, 15, 20, 30, 45, 60)) AppFilterChip(if (m == 60) "1 h" else "$m min", total == m, tag = "pick-$m", onClick = {
                    form.hours = if (m >= 60) (m / 60).toString() else ""; form.minutes = (m % 60).toString().padStart(2, '0')
                })
            }
        }
        val period = form.amountPeriod
        Note(if (form.minutes.toIntOrNull()?.let { it >= 60 } == true) "Minutes go up to 59; use hours for more."
            else if (period == GoalPeriod.DAY) "How long it takes on a day. The timer on Today counts up to it."
            else "How long in a ${period.noun}, in total. The timer on Today counts up to it.")
    }
}

/** Material's filter chip, drawn as Figma has it: outlined, or tonal with a check when chosen. */
@Composable
private fun TimeBox(value: String, label: String, tag: String, modifier: Modifier, onChange: (String) -> Unit) {
    var focused by remember { mutableStateOf(false) }
    Column(horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(6.dp)) {
        BasicTextField(
            value, { onChange(it.filter { c -> c.isDigit() }.take(3)) },
            modifier.width(96.dp).clip(RoundedCornerShape(16.dp)).background(appColors.tonal)
                .border(if (focused) 2.dp else 0.dp, if (focused) appColors.ink else Color.Transparent, RoundedCornerShape(16.dp))
                .heightIn(min = 72.dp).onFocusChanged { focused = it.isFocused }.semantics { testTag = tag; contentDescription = label },
            textStyle = AppType.displayMedium.copy(color = appColors.ink, textAlign = TextAlign.Center),
            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number), singleLine = true, cursorBrush = SolidColor(appColors.ink),
            decorationBox = { inner ->
                Box(Modifier.padding(vertical = 10.dp), contentAlignment = Alignment.Center) {
                    if (value.isEmpty() && !focused) Text("00", style = AppType.displayMedium.copy(color = appColors.secondary.copy(alpha = 0.45f)))
                    inner()
                }
            },
        )
        Text(label, style = AppType.bodySmall, color = appColors.secondary)
    }
}

// ------------------------------------------------------------------ Unit

/** The units people count in, grouped; "Create your own unit" and "No unit" first. */
@Composable
fun UnitPage(form: FormState, store: HabitStore, onBack: () -> Unit) {
    val limit = form.type == ItemType.CUT_DOWN
    var creating by remember { mutableStateOf(false) }
    var custom by remember { mutableStateOf("") }
    // The phone's own locale, read so the list follows a change of language or region.
    val locale = androidx.compose.ui.platform.LocalConfiguration.current.locales[0]
    val metric = locale.country !in setOf("US", "LR", "MM")
    val own = runCatching { Currency.getInstance(locale).getSymbol(locale) }.getOrNull()?.takeIf { it.length <= 3 } ?: "$"
    val money = listOf(own) + listOf("$", "€", "£", "₹").filter { it != own }
    val volume = if (metric) listOf("ml", "litres", "oz") else listOf("oz", "ml", "litres")
    val distance = if (metric) listOf("km", "miles") else listOf("miles", "km")
    val groups = buildList {
        if (limit) add("Cutting down" to listOf("cigarettes", "drinks", "coffees", "snacks"))
        if (limit && form.original == null) add("Time" to listOf(HabitPlan.TIME_UNIT))
        add("Drinking" to listOf("glasses", "cups", "bottles") + volume)
        add("Walking and running" to listOf("steps") + distance)
        add("Reading and writing" to listOf("pages", "chapters", "books", "words"))
        add("Exercise" to listOf("reps", "sets", "push-ups", "workouts", "laps"))
        add("Everyday" to listOf("times", "meals", "servings", "sessions", "pills"))
        add("Money" to money)
    }
    val known = groups.flatMap { it.second }.toSet()
    val used = store.habits.map { it.unit }.filter { it.isNotEmpty() && it !in known && it != "minutes" && it != "hours" }.distinct()
    fun pick(value: String) { form.unit = value; onBack() }
    FormPage("Unit", chip = null, onBack = onBack) {
        GroupTitle("Your own")
        SegmentedList {
            val count = 2 + used.size
            if (creating) {
                val focus = remember { FocusRequester() }
                LaunchedEffect(Unit) { runCatching { focus.requestFocus() } }
                val done = { TextLimit.clean(custom, TextLimit.UNIT).takeIf { it.isNotEmpty() }?.let(::pick) }
                FormField(custom, { custom = it.take(TextLimit.UNIT) }, "e.g. prayers", 0, count,
                    fieldModifier = Modifier.focusRequester(focus).semantics { testTag = "custom-unit" },
                    keyboardOptions = KeyboardOptions(imeAction = ImeAction.Done), keyboardActions = KeyboardActions(onDone = { done() })) {
                    AppButton("Done", { done() }, Modifier.padding(end = 4.dp), enabled = custom.isNotBlank(), style = ButtonStyle.Text)
                }
            } else AddRow("Create your own unit", 0, count, "create-unit") { creating = true }
            RadioRow("No unit", form.unit.isBlank(), 1, count, "no-unit") { pick("") }
            used.forEachIndexed { i, u -> RadioRow(u, form.unit == u, 2 + i, count, "unit-$u") { pick(u) } }
        }
        Note(TextLimit.note(custom, TextLimit.UNIT) ?: "Anything you count, in a word or two: prayers, laps, sets.")
        for ((title, units) in groups) {
            GroupTitle(title)
            SegmentedList { units.forEachIndexed { i, u -> RadioRow(u, form.unit == u, i, units.size, "unit-$u") { pick(u) } } }
        }
    }
}

// ------------------------------------------------------------------ Steps

/** A checklist's steps: type each, drag the handle to reorder, ✕ to remove. */
@Composable
fun StepsPage(form: FormState, onBack: () -> Unit) {
    var dragging by remember { mutableStateOf<String?>(null) }
    var offset by remember { mutableFloatStateOf(0f) }
    var focusNew by remember { mutableStateOf<String?>(null) }
    val rowPx = with(LocalDensity.current) { 58.dp.toPx() }
    fun move(from: Int, to: Int) {
        val list = form.items.toMutableList()
        if (from !in list.indices || to !in list.indices) return
        list.add(to, list.removeAt(from))
        form.items = list
    }
    FormPage("Steps", chip = null, onBack = onBack) {
        SegmentedList {
            val items = form.items
            val count = items.size + 1
            items.forEachIndexed { i, step ->
                key(step.id) {
                    val focus = remember { FocusRequester() }
                    LaunchedEffect(focusNew) { if (focusNew == step.id) { runCatching { focus.requestFocus() }; focusNew = null } }
                    val isDragged = dragging == step.id
                    FormField(step.name, { text -> form.items = form.items.map { if (it.id == step.id) it.copy(name = text.take(TextLimit.CHECKLIST_PART)) else it } },
                        "Step ${i + 1}", i, count,
                        Modifier.zIndex(if (isDragged) 1f else 0f).graphicsLayer { translationY = if (isDragged) offset else 0f }
                            .semantics {
                                customActions = listOfNotNull(
                                    if (i > 0) CustomAccessibilityAction("Move up") { move(i, i - 1); true } else null,
                                    if (i < items.size - 1) CustomAccessibilityAction("Move down") { move(i, i + 1); true } else null,
                                )
                            },
                        Modifier.focusRequester(focus).semantics { testTag = "step-field-$i" },
                        handle = Modifier.pointerInput(step.id) {
                            detectVerticalDragGestures(
                                onDragStart = { dragging = step.id; offset = 0f },
                                onDragEnd = { dragging = null; offset = 0f },
                                onDragCancel = { dragging = null; offset = 0f },
                            ) { change, dy ->
                                change.consume()
                                offset += dy
                                val at = form.items.indexOfFirst { it.id == step.id }
                                if (offset > rowPx * 0.6f && at < form.items.size - 1) { move(at, at + 1); offset -= rowPx }
                                else if (offset < -rowPx * 0.6f && at > 0) { move(at, at - 1); offset += rowPx }
                            }
                        },
                    ) {
                        FormFieldRemove("Remove ${step.name.ifEmpty { "step ${i + 1}" }}") { form.items = form.items.filter { it.id != step.id } }
                    }
                }
            }
            AddRow("Add step", items.size, count, "add-step") {
                val s = Step(name = "")
                form.items = form.items + s
                focusNew = s.id
            }
        }
        Note("Up to ${TextLimit.CHECKLIST_PART} letters a step. Drag to reorder. Each step is ticked on its own.")
    }
}

// ------------------------------------------------------------------ How often

/**
 * How often: one list of sentence endings, each with the person's own amount in it ("2 chapters a week"), so what each
 * choice means is read, not looked up. A choice's own settings show under it only while it's chosen.
 */
@Composable
fun HowOftenPage(form: FormState, onBack: () -> Unit) {
    val limit = form.type == ItemType.CUT_DOWN
    val task = form.type == ItemType.TASK
    val checklist = form.type == ItemType.CHECKLIST
    val hasAmount = form.hasAmount
    val amountText = form.amountValue?.let { if (form.timed) HabitCopy.minutes(it) else HabitCopy.amount(it, TextLimit.clean(form.unit, TextLimit.UNIT)) }
    val ws = form.weekStart
    val d = form.often
    fun set(next: OftenDraft) { form.often = next }
    fun words(choice: HowOften): String {
        val phrase = choice.phrase(hasAmount, checklist, ws)
        if (amountText == null) return if (limit && choice != HowOften.EveryDay) "At most, $phrase" else HabitCopy.capitalized(phrase)
        if (limit) return "At most $amountText " + if (choice == HowOften.EveryDay) "a day" else phrase
        return when {
            choice == HowOften.EveryDay -> "$amountText a day"
            choice is HowOften.Days && choice.n == 1 -> "$amountText, $phrase"
            else -> "$amountText $phrase"
        }
    }
    val countChoice = if (hasAmount) HowOften.Days(d.countPeriod, d.count) else HowOften.Times(d.countPeriod, d.count)
    @Composable
    fun countControls(days: Boolean, index: Int, count: Int) {
        Segment(index, count) {
            Column(Modifier.weight(1f), verticalArrangement = Arrangement.spacedBy(8.dp)) {
                AppConnectedButtons(listOf(GoalPeriod.WEEK to "Week", GoalPeriod.MONTH to "Month", GoalPeriod.YEAR to "Year"), d.countPeriod, tag = "often-count-period") { p ->
                    val next = d.copy(countPeriod = p)
                    set(next.copy(count = minOf(next.count, next.countMaximum(days))))
                }
            }
        }
        NumberRow(if (days) "Days" else "Times", d.count, 1..d.countMaximum(days), index + 1, count, "often-count") { set(d.copy(count = it)) }
    }

    FormPage(if (task) "Repeat" else "How often", chip = null, onBack = onBack) {
        if (limit) {
            SegmentedList {
                RadioRow(words(HowOften.EveryDay), d.choice == Choice.EVERY_DAY, 0, 3, "often-every-day") { set(d.copy(choice = Choice.EVERY_DAY)) }
                RadioRow(words(HowOften.Total(GoalPeriod.WEEK)), d.choice == Choice.TOTAL && d.totalPeriod == GoalPeriod.WEEK, 1, 3, "often-total-week") { set(d.copy(choice = Choice.TOTAL, totalPeriod = GoalPeriod.WEEK)) }
                RadioRow(words(HowOften.Total(GoalPeriod.MONTH)), d.choice == Choice.TOTAL && d.totalPeriod == GoalPeriod.MONTH, 2, 3, "often-total-month") { set(d.copy(choice = Choice.TOTAL, totalPeriod = GoalPeriod.MONTH)) }
            }
        } else if (hasAmount) {
            GroupTitle("In total")
            SegmentedList {
                RadioRow(words(HowOften.EveryDay), d.choice == Choice.EVERY_DAY, 0, 4, "often-every-day") { set(d.copy(choice = Choice.EVERY_DAY)) }
                listOf(GoalPeriod.WEEK, GoalPeriod.MONTH, GoalPeriod.YEAR).forEachIndexed { i, p ->
                    RadioRow(words(HowOften.Total(p)), d.choice == Choice.TOTAL && d.totalPeriod == p, i + 1, 4, "often-total-${p.noun}") { set(d.copy(choice = Choice.TOTAL, totalPeriod = p)) }
                }
            }
            GroupTitle("A number of days")
            SegmentedList {
                val open = d.choice == Choice.TIMES
                val count = if (open) 3 else 1
                RadioRow(if (open) words(countChoice) else "Days a week, month or year", open, 0, count, "often-times") { set(d.copy(choice = Choice.TIMES)) }
                if (open) countControls(true, 1, count)
            }
        } else if (task) {
            GroupTitle("Daily")
            SegmentedList { RadioRow("Every day", d.choice == Choice.EVERY_DAY, 0, 1, "often-every-day") { set(d.copy(choice = Choice.EVERY_DAY)) } }
        } else {
            GroupTitle("Daily")
            SegmentedList {
                val open = d.choice == Choice.TIMES_A_DAY
                val count = if (open) 3 else 2
                RadioRow("Every day", d.choice == Choice.EVERY_DAY, 0, count, "often-every-day") { set(d.copy(choice = Choice.EVERY_DAY)) }
                RadioRow(if (open) words(HowOften.TimesADay(maxOf(2, d.perDay))) else "Several times a day", open, 1, count, "often-times-a-day") { set(d.copy(choice = Choice.TIMES_A_DAY)) }
                if (open) NumberRow("Times a day", d.perDay, 2..99, 2, count, "often-per-day") { set(d.copy(perDay = it)) }
            }
            GroupTitle("A number of times")
            SegmentedList {
                val open = d.choice == Choice.TIMES
                val count = if (open) 3 else 1
                RadioRow(if (open) words(countChoice) else "Times a week, month or year", open, 0, count, "often-times") { set(d.copy(choice = Choice.TIMES)) }
                if (open) countControls(false, 1, count)
            }
        }
        if (!limit) {
            GroupTitle("Days of the week")
            SegmentedList {
                val open = d.choice == Choice.WEEKDAYS
                RadioRow(if (open) HabitCopy.capitalized(words(HowOften.Weekdays(d.weekdays))) else "On certain days of the week", open, 0, if (open) 2 else 1, "often-weekdays") {
                    set(d.copy(choice = Choice.WEEKDAYS))
                }
                if (open) Segment(1, 2) {
                    Column(Modifier.weight(1f).padding(start = 40.dp), verticalArrangement = Arrangement.spacedBy(12.dp)) {
                        Row(horizontalArrangement = Arrangement.spacedBy(12.dp)) {
                            AppFilterChip("Weekdays", false, { set(d.copy(weekdays = setOf(2, 3, 4, 5, 6))) }, tag = "often-weekdays-quick")
                            AppFilterChip("Weekends", false, { set(d.copy(weekdays = setOf(1, 7))) }, tag = "often-weekends-quick")
                        }
                        WeekdayCircles(d.weekdays, ws, "often-weekday-picker") { days ->
                            set(if (days.size == 7) d.copy(choice = Choice.EVERY_DAY) else d.copy(weekdays = days))
                        }
                    }
                }
            }
            GroupTitle("Every few days, weeks or months")
            SegmentedList {
                val rows = mutableListOf<@Composable (Int, Int) -> Unit>()
                val days = d.choice == Choice.EVERY_DAYS
                rows += { i, n -> RadioRow(if (days) HabitCopy.capitalized(HabitCopy.everyN(d.daysInterval, "day")) else "Every few days", days, i, n, "often-every-days") { set(d.copy(choice = Choice.EVERY_DAYS)) } }
                if (days) rows += { i, n -> NumberRow("Every", d.daysInterval, 2..365, i, n, "often-every-count", { "days" }) { set(d.copy(daysInterval = it)) } }
                val weeks = d.choice == Choice.EVERY_WEEKS
                rows += { i, n -> RadioRow(if (weeks) HabitCopy.capitalized(words(d.often(hasAmount))) else "Every few weeks", weeks, i, n, "often-every-weeks") { set(d.copy(choice = Choice.EVERY_WEEKS)) } }
                if (weeks) {
                    rows += { i, n -> NumberRow("Every", d.weeksInterval, 1..52, i, n, "often-weeks-count", { if (it == 1) "week" else "weeks" }) { set(d.copy(weeksInterval = it)) } }
                    rows += { i, n ->
                        SwitchRow("On set days", d.weeksDays.isNotEmpty(), i, n, "often-weeks-days") { on ->
                            val start = java.time.LocalDate.ofEpochDay(form.startDate.toLong()).dayOfWeek.value % 7 + 1
                            set(d.copy(weeksDays = if (on) setOf(start) else emptySet()))
                        }
                    }
                    if (d.weeksDays.isNotEmpty()) rows += { i, n -> Segment(i, n) { Box(Modifier.weight(1f)) { WeekdayCircles(d.weeksDays, ws, "often-weeks-picker") { set(d.copy(weeksDays = it)) } } } }
                }
                val months = d.choice == Choice.EVERY_MONTHS
                rows += { i, n -> RadioRow(if (months) HabitCopy.capitalized(HabitCopy.everyN(d.monthsInterval, "month")) else "Every few months", months, i, n, "often-every-months") { set(d.copy(choice = Choice.EVERY_MONTHS)) } }
                if (months) rows += { i, n -> NumberRow("Every", d.monthsInterval, 1..24, i, n, "often-months-count", { if (it == 1) "month" else "months" }) { set(d.copy(monthsInterval = it)) } }
                rows.forEachIndexed { i, row -> row(i, rows.size) }
            }
            GroupTitle("On a date")
            SegmentedList {
                val open = d.choice == Choice.DATE
                RadioRow(if (open) HabitCopy.capitalized(words(HowOften.Calendar(d.dateRule))) else "On a date each month or year", open, 0, if (open) 2 else 1, "often-date") {
                    set(d.copy(choice = Choice.DATE))
                }
                if (open) Segment(1, 2) { Column(Modifier.weight(1f), verticalArrangement = Arrangement.spacedBy(12.dp)) { DateControls(d.dateRule) { set(d.copy(dateRule = it)) } } }
            }
            setDaysNote(d)?.let { Note(it) }
        }
        if (task) {
            GroupTitle("After it's done")
            SegmentedList {
                val open = d.choice == Choice.AFTER_DONE
                val count = if (open) 3 else 1
                RadioRow(if (open) HabitCopy.capitalized(words(d.often(false))) else "A while after it's done", open, 0, count, "often-after-done") { set(d.copy(choice = Choice.AFTER_DONE)) }
                if (open) {
                    Segment(1, count) {
                        Box(Modifier.weight(1f)) {
                            AppConnectedButtons(GoalPeriod.entries.map { it to HabitCopy.capitalized(it.noun) + "s" }, d.afterUnit, tag = "often-after-unit") { set(d.copy(afterUnit = it)) }
                        }
                    }
                    NumberRow("Again after", d.afterCount, 1..365, 2, count, "often-after-count", { if (it == 1) d.afterUnit.noun else d.afterUnit.noun + "s" }) { set(d.copy(afterCount = it)) }
                }
            }
            if (d.choice == Choice.AFTER_DONE) Note("Counted from the day you tick it.")
        }
    }
}

private fun setDaysNote(d: OftenDraft): String? {
    if (d.choice != Choice.DATE) return null
    val r = d.dateRule
    if (r.unit == GoalPeriod.MONTH && r.pattern == "Dates" && r.dates.any { it > 28 }) return if (r.useLastDay) "Months without that date use their last day." else "Months without that date are skipped."
    if (r.unit == GoalPeriod.MONTH && r.pattern == "Weekday" && r.ordinal == 5) return "Months without a fifth ${HabitCopy.fullDays[(r.weekday - 1 + 7) % 7]} are skipped."
    if (r.unit == GoalPeriod.YEAR && r.month == 2 && r.day == 29) return if (r.useLastDay) "Years without 29 February use 28 February." else "Years without 29 February are skipped."
    return null
}

/** Each month (on dates, the last day, or a weekday like the first Saturday) or each year (a month and a date). */
@Composable
private fun DateControls(rule: CalendarRule, onChange: (CalendarRule) -> Unit) {
    AppConnectedButtons(listOf(GoalPeriod.MONTH to "Month", GoalPeriod.YEAR to "Year"), rule.unit, tag = "often-date-unit") { onChange(rule.copy(unit = it)) }
    if (rule.unit == GoalPeriod.MONTH) {
        val patterns = listOf("Dates" to "Dates", "Last day" to "The last day", "Weekday" to "A weekday")
        DropdownField("Repeat on", patterns.first { it.first == rule.pattern }.second, patterns.map { it.second },
            { onChange(rule.copy(pattern = patterns[it].first)) }, tag = "often-date-pattern")
        when (rule.pattern) {
            "Dates" -> {
                // A plain grid sized up front, never a lazy one (S13): seven dates a row, spread across it, rows 8 apart (Figma).
                Column(verticalArrangement = Arrangement.spacedBy(8.dp), modifier = Modifier.semantics { testTag = "often-month-dates" }) {
                    for (week in (1..31).chunked(7)) Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
                        for (date in week) DayToggle("$date", date in rule.dates, { on -> onChange(rule.copy(dates = if (on) rule.dates + date else rule.dates - date)) },
                            "Day $date", size = DayToggleSize.Date)
                        repeat(7 - week.size) { Spacer(Modifier.size(DayToggleSize.Date.size)) }
                    }
                }
                if (rule.dates.any { it > 28 }) AppConnectedButtons(listOf(true to "Use the last day", false to "Skip that month"), rule.useLastDay, tag = "often-short-months") { onChange(rule.copy(useLastDay = it)) }
            }
            "Weekday" -> Row(horizontalArrangement = Arrangement.spacedBy(16.dp)) {
                val ordinals = listOf(1, 2, 3, 4, 5, -1)
                DropdownField("Which", HabitCopy.capitalized(HabitCopy.ordinalWord(rule.ordinal)), ordinals.map { HabitCopy.capitalized(HabitCopy.ordinalWord(it)) },
                    { onChange(rule.copy(ordinal = ordinals[it])) }, Modifier.weight(1f), tag = "often-weekday-ordinal")
                DropdownField("Day", HabitCopy.fullDays[(rule.weekday - 1 + 7) % 7], HabitCopy.fullDays,
                    { onChange(rule.copy(weekday = it + 1)) }, Modifier.weight(1f), tag = "often-weekday-day")
            }
            else -> {}
        }
        NumberRow("Every", rule.interval, 1..12, 0, 1, "often-month-interval", { if (it == 1) "month" else "months" }) { onChange(rule.copy(interval = it)) }
    } else {
        Row(horizontalArrangement = Arrangement.spacedBy(16.dp)) {
            DropdownField("Month", HabitCopy.monthNames[rule.month - 1], HabitCopy.monthNames, { m ->
                val month = m + 1
                onChange(rule.copy(month = month, day = minOf(rule.day, daysIn(month))))
            }, Modifier.weight(1f), tag = "often-year-month")
            DropdownField("Day", "${rule.day}", (1..daysIn(rule.month)).map { "$it" }, { onChange(rule.copy(day = it + 1)) },
                Modifier.weight(1f), tag = "often-year-day")
        }
        if (rule.month == 2 && rule.day == 29) AppConnectedButtons(listOf(true to "Use 28 February", false to "Skip that year"), rule.useLastDay, tag = "often-leap") { onChange(rule.copy(useLastDay = it)) }
    }
}

private fun daysIn(month: Int): Int = java.time.YearMonth.of(2024, month).lengthOfMonth()

/** A small menu button showing its choice ("first ▾"). */
@Composable
fun MenuPill(text: String, options: List<String>, tag: String, onPick: (Int) -> Unit) {
    var open by remember { mutableStateOf(false) }
    Box {
        Row(Modifier.clip(RoundedCornerShape(8.dp)).border(1.dp, appColors.outline, RoundedCornerShape(8.dp)).clickable { open = true }
            .semantics { testTag = tag }.heightIn(min = 40.dp).padding(start = 12.dp, end = 4.dp), verticalAlignment = Alignment.CenterVertically) {
            Text(text, style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
            Icon(Symbols.ArrowDropDown, null, tint = appColors.ink)
        }
        AppMenu(open, { open = false }) {
            options.forEachIndexed { i, o -> AppMenuItem(o, { onPick(i); open = false }, selected = o == text) }
        }
    }
}

// ------------------------------------------------------------------ Time of Day

/**
 * Time of Day (Figma 2.1.4): Anytime ("No set time") or At set times of day ("Pick one or more"); only under the second,
 * indented, the times of day as checkboxes and + New time of day, which opens the same page as Settings › Times of Day.
 */
@Composable
fun TimeOfDayPage(form: FormState, store: HabitStore, onBack: () -> Unit, onNew: () -> Unit) {
    val anytime = form.timesOfDay == listOf(DaySection.ANYTIME)
    // At set times of day, chosen before any time is ticked: the times show, waiting for one.
    var setTimes by remember { mutableStateOf(!anytime) }
    FormPage("Time of Day", chip = null, onBack = onBack) {
        val timed = store.sections.filter { !it.isAnytime }
        val showTimes = setTimes || !anytime
        SegmentedList {
            val count = 2 + if (showTimes) timed.size + 1 else 0
            RadioRow("Anytime", !showTimes, 0, count, "part-anytime", detail = "No set time") { setTimes = false; form.choose(DaySection.ANYTIME) }
            RadioRow("At set times of day", showTimes, 1, count, "part-set", detail = "Pick one or more") { setTimes = true }
            if (showTimes) {
                timed.forEachIndexed { i, s ->
                    CheckRow(s.name, s.id in form.timesOfDay, i + 2, count, "part-${s.id}", detail = FormOutcome.hours(s, store), indent = true) { form.choose(s.id) }
                }
                AddRow("New time of day", count - 1, count, "new-time-of-day", indent = true, onClick = onNew)
            }
        }
        Note(FormOutcome.timeOfDay(form.previewHabit(), store))
    }
}

/** A new time of day: its name and when it starts; it ends where the next one begins. */
@Composable
fun NewSectionDialog(store: HabitStore, onDismiss: () -> Unit, onAdded: (String) -> Unit) {
    var name by remember { mutableStateOf("") }
    var start by remember { mutableStateOf(21 * 60) }
    var picking by remember { mutableStateOf(false) }
    val taken = store.sections.any { it.start == start }
    val clean = TextLimit.clean(name, TextLimit.SECTION)
    AlertDialog(onDismiss, title = { Text("New time of day") },
        text = {
            Column(verticalArrangement = Arrangement.spacedBy(12.dp)) {
                OutlinedTextField(name, { name = it.take(TextLimit.SECTION) }, label = { Text("Name") }, singleLine = true,
                    supportingText = { Text("${name.length}/${TextLimit.SECTION}") }, modifier = Modifier.fillMaxWidth().semantics { testTag = "section-name" },
                    colors = OutlinedTextFieldDefaults.colors(focusedBorderColor = appColors.ink, focusedLabelColor = appColors.ink, cursorColor = appColors.ink))
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Text("Starts", Modifier.weight(1f), style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
                    com.oftenenough.app.ui.record.Pill(DayWords.clockMinute(start), tag = "section-start") { picking = true }
                }
                Text(if (taken) "Another time of day starts then." else "It ends when the next time of day begins.", style = MaterialTheme.typography.bodyMedium, color = appColors.secondary)
            }
        },
        confirmButton = {
            AppButton("Add", {
                val s = DaySection(newId(), clean, start, null)
                store.saveSections(store.sections + s)
                onAdded(s.id)
                onDismiss()
            }, enabled = clean.isNotEmpty() && !taken, tag = "section-add")
        },
        dismissButton = { AppButton("Cancel", onDismiss, style = ButtonStyle.Text) })
    if (picking) MinuteDialog(start, { picking = false }) { start = it }
}

/** "Get reminders on time" (design §15): why exact times matter, then Android's own Alarms & reminders page. */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ExactTimesSheet(onAllow: () -> Unit, onDismiss: () -> Unit) {
    val c = appColors
    // Opened whole, and scrolling: half-open, its buttons were under the gesture bar and below the screen (360 x 800 dp).
    ModalBottomSheet(onDismiss, sheetState = rememberWholeSheetState()) {
        Column(Modifier.fillMaxWidth().verticalScroll(androidx.compose.foundation.rememberScrollState()).padding(horizontal = 24.dp).padding(bottom = 24.dp)
            .semantics { testTag = "exact-times-sheet"; testTagsAsResourceId = true },
            horizontalAlignment = Alignment.CenterHorizontally) {
            Box(Modifier.size(64.dp).clip(CircleShape).background(c.tonal), contentAlignment = Alignment.Center) {
                Icon(Symbols.Alarm, null, tint = c.ink)
            }
            Spacer(Modifier.height(24.dp))
            Text("Get reminders on time", style = MaterialTheme.typography.headlineSmall, color = c.ink, textAlign = TextAlign.Center)
            Spacer(Modifier.height(16.dp))
            Text("Android holds reminders back unless an app may use exact times. Without it, a reminder can come up to 10 minutes late.",
                style = MaterialTheme.typography.bodyLarge, color = c.secondary, textAlign = TextAlign.Center)
            Spacer(Modifier.height(12.dp))
            Text("Next, Android opens Alarms & reminders: switch it on for Often Enough, then come back.",
                style = MaterialTheme.typography.bodyLarge, color = c.secondary, textAlign = TextAlign.Center)
            Spacer(Modifier.height(24.dp))
            AppButton("Allow exact times", onAllow, Modifier.fillMaxWidth().semantics { testTag = "exact-times-allow" }, size = ButtonSize.Medium)
            Spacer(Modifier.height(8.dp))
            AppButton("Not now", onDismiss, Modifier.semantics { testTag = "exact-times-not-now" }, style = ButtonStyle.Text)
        }
    }
}

// ------------------------------------------------------------------ Reminders

/**
 * Reminders (Figma 2.1.6–2.1.6.4): the habit in a sentence; Remind me, off as every habit starts. Turning it on asks
 * Android for notifications the first time (its own dialog); not allowed, it goes back off and says how to allow them.
 * On: Remind me at (each time, ✕ to remove; Add a time opens the time picker at now), How (with what, and again if not
 * done), what will happen, and what the reminder says.
 */
@Composable
fun RemindersPage(form: FormState, store: HabitStore, onBack: () -> Unit) {
    var editing by remember { mutableStateOf<String?>(null) }
    var adding by remember { mutableStateOf(false) }
    var refused by remember { mutableStateOf(false) }
    var canAskAgain by remember { mutableStateOf(false) }
    val context = androidx.compose.ui.platform.LocalContext.current
    // Reminders turned on: Android's own question for notifications first, then exact times (A11 D1). Never in a test
    // launch: a system question stays over every later launch on that emulator (T18).
    var askExact by remember { mutableStateOf(false) }
    val askNotifications = androidx.activity.compose.rememberLauncherForActivityResult(
        androidx.activity.result.contract.ActivityResultContracts.RequestPermission()) { granted ->
        if (!granted) {
            form.remindOn = false; refused = true
            // Android asks again after a first refusal; only once it won't (after two) is Settings the way (U37).
            canAskAgain = (context as? android.app.Activity)?.shouldShowRequestPermissionRationale(android.Manifest.permission.POST_NOTIFICATIONS) == true
        }
        else askExact = !com.oftenenough.app.app.reminders.Reminders.canBeExact(context)
    }
    val turnedOn: () -> Unit = {
        if (!com.oftenenough.app.app.AppGraph.isTest) {
            if (android.os.Build.VERSION.SDK_INT >= 33 && !com.oftenenough.app.app.reminders.Reminders.canPost(context))
                askNotifications.launch(android.Manifest.permission.POST_NOTIFICATIONS)
            else askExact = !com.oftenenough.app.app.reminders.Reminders.canBeExact(context)
        }
    }
    FormPage("Reminders", chip = null, onBack = onBack) {
        val habit = form.previewHabit()
        Row(Modifier.fillMaxWidth().padding(start = 16.dp, end = 16.dp, top = 4.dp, bottom = 16.dp), verticalAlignment = Alignment.CenterVertically) {
            com.oftenenough.app.ui.components.HabitIcon(habit.symbol, habit.color, 40.dp)
            Spacer(Modifier.width(12.dp))
            Text(if (form.trimmedName.isNotEmpty()) form.sentence() else form.chipText(), Modifier.semantics { testTag = "screen-sentence" },
                style = AppType.titleMedium, color = appColors.ink)
        }
        SegmentedList {
            SwitchRow("Remind me", form.remindOn, 0, 1, "remind-me") { on ->
                form.remindOn = on
                if (on) refused = false
                if (on && (form.times.isEmpty() || !form.remindersEdited)) form.syncReminders(force = true)
                if (on) turnedOn()
            }
        }
        if (!form.remindOn) {
            if (refused && canAskAgain) Note("Notifications are off for the app, so reminders can't come. Turn on Remind me to be asked again.")
            else if (refused) {
                Note("Notifications are off for the app, so reminders can't come. To get them, allow notifications in Settings.")
                OpenSettingsButton(context)
            } else Note("Reminders are off. Turn on Remind me to choose times; Android asks once if the app may send notifications.")
        } else {
            Text("Remind me at", Modifier.padding(start = 16.dp, top = 24.dp, bottom = 8.dp), style = AppType.labelLarge, color = appColors.secondary)
            SegmentedList {
                val count = form.times.size + 1
                form.times.forEachIndexed { i, t ->
                    AppListItem(DayWords.clockMinute(t.minute), i, count, leading = { Icon(Symbols.Schedule, null) }, onClick = { editing = t.id },
                        tag = "reminder-$i", trailing = {
                            StandardIconButton(Symbols.Close, "Remove the ${DayWords.clockMinute(t.minute)} reminder",
                                { form.remindersEdited = true; form.times = form.times.filter { it.id != t.id } })
                        })
                }
                AddRow("Add a time", form.times.size, count, "add-reminder") { adding = true }
            }
            if (form.times.isNotEmpty()) {
                Text("How", Modifier.padding(start = 16.dp, top = 24.dp, bottom = 8.dp), style = AppType.labelLarge, color = appColors.secondary)
                SegmentedList {
                    val rows = if (form.type != ItemType.CUT_DOWN) 2 else 1
                    // An alarm rings on Android's alarm sound until it's answered; never a full screen (A11 D3).
                    val styles = listOf("notification" to "A notification", "alarm" to "An alarm")
                    MenuRow("Remind me with", styles.first { it.first == form.alert }.second, styles.map { it.second }, 0, rows, "remind-with",
                        listOf(Symbols.Notifications, Symbols.Alarm)) { form.alert = styles[it].first }
                    if (form.type != ItemType.CUT_DOWN) {
                        val options = listOf(null, 15, 30, 60)
                        MenuRow("If not done, remind again", followWords(form.followUp), options.map { followWords(it) }, 1, rows, "follow-up") { form.followUp = options[it] }
                    }
                }
                Note(FormOutcome.reminders(form.previewHabit(), store, alarmsAvailable = true))
                Spacer(Modifier.height(16.dp))
                SegmentedList {
                    Segment(0, 1) {
                        Icon(Symbols.ChatBubble, null, tint = appColors.secondary)
                        Spacer(Modifier.width(16.dp))
                        BasicTextField(form.reminderWords, { form.reminderWords = it.take(TextLimit.REMINDER_TEXT) },
                            Modifier.weight(1f).semantics { testTag = "reminder-says"; contentDescription = "Reminder says" },
                            textStyle = AppType.bodyLarge.copy(color = appColors.ink), singleLine = true, cursorBrush = SolidColor(appColors.ink),
                            decorationBox = { inner -> Box { if (form.reminderWords.isEmpty()) Text("Reminder says (optional)", style = AppType.bodyLarge, color = appColors.secondary); inner() } })
                    }
                }
                Note(TextLimit.note(form.reminderWords, TextLimit.REMINDER_TEXT)
                    ?: "Shown in this habit's reminders. When names are hidden outside the app, it's shown instead of the name.")
            }
        }
    }
    if (askExact) ExactTimesSheet(onAllow = {
        askExact = false
        if (android.os.Build.VERSION.SDK_INT >= 31) runCatching {
            context.startActivity(android.content.Intent(android.provider.Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM,
                android.net.Uri.parse("package:" + context.packageName)).addFlags(android.content.Intent.FLAG_ACTIVITY_NEW_TASK))
        }
    }) { askExact = false }
    editing?.let { id ->
        val t = form.times.firstOrNull { it.id == id }
        if (t == null) editing = null
        else MinuteDialog(t.minute, { editing = null }) { picked ->
            form.remindersEdited = true
            val minute = t.part?.let { clampToPart(it, picked, store) } ?: picked
            form.times = form.times.map { if (it.id == id) it.copy(minute = minute) else it }
        }
    }
    // Add a time (Figma 2.1.6.2.1): Android's time picker, starting at now; OK adds it.
    if (adding) {
        val now = java.time.LocalTime.now()
        MinuteDialog(now.hour * 60 + now.minute, { adding = false }) { picked -> form.addReminderAt(picked) }
    }
}

/**
 * A row whose value opens a menu (Figma 2.1.6.2's "How"): its title over the value, then ▾ (List item, 2.4). The menu
 * marks the value chosen (Menu item, Selected), each choice with its [icons] if it has them (A notification, An alarm).
 */
@Composable
private fun MenuRow(title: String, value: String, options: List<String>, index: Int, count: Int, tag: String, icons: List<ImageVector>? = null, onPick: (Int) -> Unit) {
    var open by remember { mutableStateOf(false) }
    Box {
        AppListItem(title, index, count, Modifier.semantics(mergeDescendants = true) { contentDescription = "$title, $value" }, value,
            trailing = { Icon(Symbols.ArrowDropDown, null) }, onClick = { open = true }, tag = tag)
        AppMenu(open, { open = false }, offset = DpOffset(140.dp, 0.dp)) {
            options.forEachIndexed { i, o -> AppMenuItem(o, { onPick(i); open = false }, icon = icons?.get(i), selected = o == value) }
        }
    }
}

private fun followWords(m: Int?) = when (m) { null -> "Never"; 60 -> "Every hour"; else -> "Every $m min" }

/** A reminder stays inside its time of day: Morning's reminder can only be set in the morning. */
private fun clampToPart(part: String, minute: Int, store: HabitStore): Int {
    val timed = store.timedSections().firstOrNull { it.first.id == part } ?: return minute
    val start = timed.first.start ?: return minute
    val end = timed.second - 1
    val m = if (minute < start && minute + 24 * 60 <= end) minute + 24 * 60 else minute
    return (if (m < start) start else if (m > end) end else m) % (24 * 60)
}

// ------------------------------------------------------------------ Icon and Colour

/**
 * 5.7.4, **Icon picker** (Figma 1074:932; Components — Atoms Build Plan), from the form's Icon. The Top app bar (✕
 * "Icon", Done as a Filled Small button); the content 16 at the sides and above, 16 apart: the Search bar ("Search
 * icons"), then the icons by kind (Health, Fitness, Mind, Home …), each kind's label in Label Large On surface variant
 * (4 in), 12 over its rows of Medium icon buttons (56, five to a row, spread across), 24 between kinds. The current one
 * is filled in the habit's colour; the rest are neutral. Done keeps the one tapped, ✕ leaves it as it was.
 */
@Composable
fun IconPage(form: FormState, onBack: () -> Unit) {
    var chosen by remember { mutableStateOf(form.symbol) }
    var query by remember { mutableStateOf("") }
    FormPage("Icon", chip = null, onBack = onBack, close = true, scrolls = false, actions = {
        AppButton("Done", { form.symbol = chosen; form.pickedSymbol = true; onBack() }, Modifier.padding(end = 8.dp), tag = "icon-done")
    }) {
        SearchBarField(query, { query = it.take(30) }, "Search icons", Modifier.padding(top = 16.dp, bottom = 16.dp), fieldTag = "icon-search")
        val q = query.trim().lowercase()
        val groups = HabitIcons.groups.mapNotNull { g ->
            val symbols = if (q.isEmpty()) g.symbols else g.symbols.filter { s ->
                g.name.lowercase().contains(q) || s.contains(q) || HabitIcons.keywords[s]?.any { it.contains(q) } == true
            }
            symbols.takeIf { it.isNotEmpty() }?.let { g.name to it }
        }
        if (groups.isEmpty()) Note("No icons match \"${query.trim()}\".")
        LazyVerticalGrid(GridCells.FixedSize(56.dp), Modifier.weight(1f), horizontalArrangement = Arrangement.SpaceBetween, verticalArrangement = Arrangement.spacedBy(12.dp),
            contentPadding = PaddingValues(bottom = 24.dp)) {
            for ((n, pair) in groups.withIndex()) {
                val (name, symbols) = pair
                // 12 under each label; 24 between kinds (12 more over every label but the first).
                item(key = "h-$name", span = { GridItemSpan(maxLineSpan) }) {
                    Text(name, Modifier.padding(start = 4.dp, top = if (n == 0) 0.dp else 12.dp).semantics { heading() },
                        style = AppType.labelLarge, color = MaterialTheme.colorScheme.onSurfaceVariant)
                }
                items(symbols, key = { "$name-$it" }) { s ->
                    val on = s == chosen
                    AppFilledIconButton(HabitIcons.outlined(s), HabitIcons.spokenName(s) + if (on) ", chosen" else "", { chosen = s },
                        done = on, color = form.color, size = IconButtonSize.Medium, tag = "icon-$s")
                }
            }
        }
    }
}

/** The thirteen habit colours, in a sheet (Figma Colour, 1074:161496): Colour swatches (3.2), seven to a row. */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ColourSheet(form: FormState, onDismiss: () -> Unit) {
    AppBottomSheet(onDismiss, Modifier.semantics { testTagsAsResourceId = true }, title = "Colour") {
        // Figma's Swatches: 16 at the sides, 8 above, 24 under (the sheet adds its own 24), rows 12 apart, 8 between.
        Column(Modifier.padding(horizontal = 16.dp).padding(top = 8.dp, bottom = 24.dp), verticalArrangement = Arrangement.spacedBy(12.dp)) {
            for (row in HabitColor.entries.chunked(7)) {
                Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    for (c in row) ColourSwatch(appColors.habit(c), c == form.color, { form.color = c; onDismiss() },
                        if (c == HabitColor.GRAY) "Grey" else c.key.replaceFirstChar { it.uppercase() }, Modifier.semantics { testTag = "colour-${c.key}" })
                }
            }
        }
    }
}

