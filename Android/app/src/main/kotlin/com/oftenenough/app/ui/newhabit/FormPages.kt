package com.oftenenough.app.ui.newhabit

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.gestures.detectVerticalDragGestures
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.GridItemSpan
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.foundation.text.KeyboardActions
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.outlined.Alarm
import androidx.compose.material.icons.rounded.Add
import androidx.compose.material.icons.rounded.ArrowDropDown
import androidx.compose.material.icons.rounded.Remove
import androidx.compose.material.icons.rounded.Close
import androidx.compose.material.icons.rounded.CreateNewFolder
import androidx.compose.material.icons.rounded.DragIndicator
import androidx.compose.material.icons.rounded.Search
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.ModalBottomSheet
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.OutlinedTextFieldDefaults
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
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
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
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
import com.oftenenough.app.ui.components.segmentShape
import com.oftenenough.app.ui.record.GoalNumber
import com.oftenenough.app.ui.theme.HabitIcons
import com.oftenenough.app.ui.theme.appColors
import java.util.Currency
import java.util.Locale

// ------------------------------------------------------------------ How much, Limit and How long

/** The big number between − and +, with the unit chip under it; tap the number to type it. */
@Composable
fun HowMuchPage(form: FormState, onUnit: () -> Unit, onBack: () -> Unit) {
    val limit = form.type == ItemType.CUT_DOWN
    FormPage(if (limit) "Limit" else "How much", chip = null, onBack = onBack) {
        val focus = remember { FocusRequester() }
        LaunchedEffect(Unit) { if (form.amountText.isEmpty()) runCatching { focus.requestFocus() } }
        Card(Modifier.fillMaxWidth().padding(top = 8.dp)) {
            Column(Modifier.fillMaxWidth().padding(vertical = 24.dp, horizontal = 16.dp), horizontalAlignment = Alignment.CenterHorizontally) {
                Text(oftenHeader(form), style = MaterialTheme.typography.titleSmall.copy(fontSize = 16.sp), color = appColors.secondary)
                Spacer(Modifier.height(20.dp))
                Row(verticalAlignment = Alignment.CenterVertically) {
                    val value = GoalNumber.parse(form.amountText)
                    StepButton(Icons.Rounded.Remove, "Less", (value ?: 0.0) > 1, size = 56) {
                        form.amountText = GoalNumber.text(maxOf(1.0, (value ?: 1.0) - 1))
                    }
                    Spacer(Modifier.width(12.dp))
                    BasicTextField(
                        form.amountText, { form.amountText = it.filter { c -> c.isDigit() || c == '.' || c == ',' }.take(12) },
                        Modifier.width(120.dp).clip(RoundedCornerShape(20.dp)).background(appColors.tonal).heightIn(min = 88.dp)
                            .focusRequester(focus).semantics { testTag = "much-number"; contentDescription = if (limit) "Limit" else "Amount" },
                        textStyle = TextStyle(fontSize = 57.sp, color = appColors.ink, textAlign = TextAlign.Center),
                        keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Decimal, imeAction = ImeAction.Done),
                        singleLine = true, cursorBrush = SolidColor(appColors.ink),
                        decorationBox = { inner ->
                            Box(Modifier.padding(vertical = 8.dp), contentAlignment = Alignment.Center) {
                                if (form.amountText.isEmpty()) Text(if (limit) "2" else "8", style = TextStyle(fontSize = 57.sp, color = appColors.secondary.copy(alpha = 0.45f)))
                                inner()
                            }
                        },
                    )
                    Spacer(Modifier.width(12.dp))
                    StepButton(Icons.Rounded.Add, "More", (value ?: 0.0) < 9_999_999, size = 56) {
                        form.amountText = GoalNumber.text(if (value == null) 1.0 else value + 1)
                    }
                }
                Spacer(Modifier.height(16.dp))
                Row(Modifier.clip(RoundedCornerShape(8.dp)).border(1.dp, appColors.outline, RoundedCornerShape(8.dp)).clickable(onClick = onUnit)
                    .semantics { testTag = "much-unit" }.heightIn(min = 40.dp).padding(start = 16.dp, end = 8.dp), verticalAlignment = Alignment.CenterVertically) {
                    Text(form.unit.ifEmpty { "No unit" }, style = MaterialTheme.typography.titleSmall.copy(fontSize = 16.sp), color = appColors.ink)
                    Icon(Icons.Rounded.ArrowDropDown, null, tint = appColors.ink)
                }
            }
        }
        val text = form.amountText.trim()
        val error = if (text.isNotEmpty() && (GoalNumber.parse(text)?.let { it > 0 } != true)) "Enter a number above 0, with up to 2 decimal places." else null
        Note(error ?: if (limit) "Log it only when it happens. Staying at or under the limit counts as a good day."
            else "Tap the number to type it, up to 2 decimal places. The unit is optional.")
    }
}

/** "Every day", "At most, every day", "A week": the rhythm the amount is for. */
private fun oftenHeader(form: FormState): String {
    val o = form.plan.often
    val phrase = o.phrase(true, false, form.weekStart)
    return if (form.type == ItemType.CUT_DOWN) "At most, $phrase" else HabitCopy.capitalized(phrase)
}

/** Hours : minutes, with quick picks. */
@Composable
fun HowLongPage(form: FormState, onBack: () -> Unit) {
    FormPage("How long", chip = null, onBack = onBack) {
        Card(Modifier.fillMaxWidth().padding(top = 8.dp)) {
            Column(Modifier.fillMaxWidth().padding(vertical = 24.dp, horizontal = 16.dp), horizontalAlignment = Alignment.CenterHorizontally) {
                Text(oftenHeader(form), style = MaterialTheme.typography.titleSmall.copy(fontSize = 16.sp), color = appColors.secondary)
                Spacer(Modifier.height(20.dp))
                Row(verticalAlignment = Alignment.CenterVertically) {
                    TimeBox(form.hours, "hours", "how-long-hours") { form.hours = it }
                    Text(":", Modifier.padding(horizontal = 12.dp).padding(bottom = 28.dp), style = TextStyle(fontSize = 45.sp, color = appColors.ink))
                    TimeBox(form.minutes, "minutes", "how-long-minutes") { form.minutes = it }
                }
                Spacer(Modifier.height(16.dp))
                val total = (form.hours.toIntOrNull() ?: 0) * 60 + (form.minutes.toIntOrNull() ?: 0)
                val picks = listOf(5, 10, 15, 20, 30, 45, 60)
                Column(horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(8.dp)) {
                    for (row in listOf(picks.take(3), picks.drop(3))) Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                        for (m in row) ChoicePill(if (m == 60) "1 h" else "$m min", selected = total == m, tag = "pick-$m") {
                            form.hours = (m / 60).toString(); form.minutes = (m % 60).toString()
                        }
                    }
                }
            }
        }
        val period = form.amountPeriod
        Note(if (form.minutes.toIntOrNull()?.let { it >= 60 } == true) "Minutes go up to 59; use hours for more."
            else if (period == GoalPeriod.DAY) "How long it takes on a day. The timer on Today counts up to it."
            else "How long in a ${period.noun}, in total. The timer on Today counts up to it.")
    }
}

@Composable
private fun TimeBox(value: String, label: String, tag: String, onChange: (String) -> Unit) {
    var focused by remember { mutableStateOf(false) }
    Column(horizontalAlignment = Alignment.CenterHorizontally) {
        BasicTextField(
            value, { onChange(it.filter { c -> c.isDigit() }.take(3)) },
            Modifier.width(120.dp).clip(RoundedCornerShape(20.dp)).background(appColors.tonal)
                .border(if (focused) 3.dp else 0.dp, if (focused) appColors.ink else Color.Transparent, RoundedCornerShape(20.dp))
                .heightIn(min = 88.dp).onFocusChanged { focused = it.isFocused }.semantics { testTag = tag; contentDescription = label },
            textStyle = TextStyle(fontSize = 57.sp, color = appColors.ink, textAlign = TextAlign.Center),
            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number), singleLine = true, cursorBrush = SolidColor(appColors.ink),
            decorationBox = { inner -> Box(Modifier.padding(vertical = 8.dp), contentAlignment = Alignment.Center) { inner() } },
        )
        Text(label, Modifier.padding(top = 6.dp), style = MaterialTheme.typography.bodyLarge, color = appColors.secondary)
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
                Segment(0, count) {
                    val focus = remember { FocusRequester() }
                    LaunchedEffect(Unit) { runCatching { focus.requestFocus() } }
                    BasicTextField(custom, { custom = it.take(TextLimit.UNIT) }, Modifier.weight(1f).focusRequester(focus).semantics { testTag = "custom-unit" },
                        textStyle = MaterialTheme.typography.bodyLarge.copy(color = appColors.ink), singleLine = true, cursorBrush = SolidColor(appColors.ink),
                        keyboardOptions = KeyboardOptions(imeAction = ImeAction.Done),
                        keyboardActions = KeyboardActions(onDone = { TextLimit.clean(custom, TextLimit.UNIT).takeIf { it.isNotEmpty() }?.let(::pick) }),
                        decorationBox = { inner -> Box { if (custom.isEmpty()) Text("e.g. prayers", style = MaterialTheme.typography.bodyLarge, color = appColors.secondary); inner() } })
                    TextButton({ TextLimit.clean(custom, TextLimit.UNIT).takeIf { it.isNotEmpty() }?.let(::pick) }, enabled = custom.isNotBlank()) { Text("Done", color = appColors.ink) }
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
    FormPage("Steps", chip = form.chipText(), onBack = onBack) {
        SegmentedList {
            val items = form.items
            val count = items.size + 1
            items.forEachIndexed { i, step ->
                key(step.id) {
                    val focus = remember { FocusRequester() }
                    LaunchedEffect(focusNew) { if (focusNew == step.id) { runCatching { focus.requestFocus() }; focusNew = null } }
                    val isDragged = dragging == step.id
                    Segment(i, count, Modifier.zIndex(if (isDragged) 1f else 0f).graphicsLayer { translationY = if (isDragged) offset else 0f }
                        .semantics {
                            customActions = listOfNotNull(
                                if (i > 0) CustomAccessibilityAction("Move up") { move(i, i - 1); true } else null,
                                if (i < items.size - 1) CustomAccessibilityAction("Move down") { move(i, i + 1); true } else null,
                            )
                        }) {
                        Icon(Icons.Rounded.DragIndicator, "Reorder", tint = appColors.secondary, modifier = Modifier.size(24.dp).pointerInput(step.id) {
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
                        })
                        Spacer(Modifier.width(16.dp))
                        BasicTextField(step.name, { text -> form.items = form.items.map { if (it.id == step.id) it.copy(name = text.take(TextLimit.CHECKLIST_PART)) else it } },
                            Modifier.weight(1f).focusRequester(focus).semantics { testTag = "step-field-$i" },
                            textStyle = MaterialTheme.typography.bodyLarge.copy(color = appColors.ink), singleLine = true, cursorBrush = SolidColor(appColors.ink),
                            decorationBox = { inner -> Box { if (step.name.isEmpty()) Text("Step ${i + 1}", style = MaterialTheme.typography.bodyLarge, color = appColors.secondary); inner() } })
                        IconButton({ form.items = form.items.filter { it.id != step.id } }) { Icon(Icons.Rounded.Close, "Remove ${step.name.ifEmpty { "step ${i + 1}" }}", tint = appColors.secondary) }
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
                Segments(listOf(GoalPeriod.WEEK to "Week", GoalPeriod.MONTH to "Month", GoalPeriod.YEAR to "Year"), d.countPeriod, "often-count-period") { p ->
                    val next = d.copy(countPeriod = p)
                    set(next.copy(count = minOf(next.count, next.countMaximum(days))))
                }
            }
        }
        NumberRow(if (days) "Days" else "Times", d.count, 1..d.countMaximum(days), index + 1, count, "often-count") { set(d.copy(count = it)) }
    }

    FormPage(if (task) "Repeat" else "How often", chip = if (task || form.trimmedName.isNotEmpty() || !hasAmount) form.chipText() else words(form.plan.often), onBack = onBack) {
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
                            ChoicePill("Weekdays", tag = "often-weekdays-quick") { set(d.copy(weekdays = setOf(2, 3, 4, 5, 6))) }
                            ChoicePill("Weekends", tag = "often-weekends-quick") { set(d.copy(weekdays = setOf(1, 7))) }
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
                            Segments(GoalPeriod.entries.map { it to HabitCopy.capitalized(it.noun) + "s" }, d.afterUnit, "often-after-unit") { set(d.copy(afterUnit = it)) }
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
    Segments(listOf(GoalPeriod.MONTH to "Month", GoalPeriod.YEAR to "Year"), rule.unit, "often-date-unit") { onChange(rule.copy(unit = it)) }
    if (rule.unit == GoalPeriod.MONTH) {
        Segments(listOf("Dates" to "Dates", "Last day" to "The last day", "Weekday" to "A weekday"), rule.pattern, "often-date-pattern") { onChange(rule.copy(pattern = it)) }
        when (rule.pattern) {
            "Dates" -> {
                // A plain grid sized up front, never a lazy one (S13).
                Column(verticalArrangement = Arrangement.spacedBy(6.dp), modifier = Modifier.semantics { testTag = "often-month-dates" }) {
                    for (week in (1..31).chunked(7)) Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(6.dp)) {
                        for (date in week) {
                            val on = date in rule.dates
                            Box(Modifier.weight(1f).aspectRatio(1f).clip(CircleShape).background(if (on) appColors.ink else appColors.tonal)
                                .clickable { onChange(rule.copy(dates = if (on) rule.dates - date else rule.dates + date)) }
                                .semantics { contentDescription = "Day $date" + if (on) ", chosen" else "" }, contentAlignment = Alignment.Center) {
                                Text("$date", color = if (on) appColors.onInk else appColors.ink, style = MaterialTheme.typography.labelLarge)
                            }
                        }
                        repeat(7 - week.size) { Spacer(Modifier.weight(1f)) }
                    }
                }
                if (rule.dates.any { it > 28 }) Segments(listOf(true to "Use the last day", false to "Skip that month"), rule.useLastDay, "often-short-months") { onChange(rule.copy(useLastDay = it)) }
            }
            "Weekday" -> Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                Text("The", style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
                MenuPill(HabitCopy.ordinalWord(rule.ordinal), listOf(1, 2, 3, 4, 5, -1).map { HabitCopy.ordinalWord(it) }, "often-weekday-ordinal") {
                    onChange(rule.copy(ordinal = listOf(1, 2, 3, 4, 5, -1)[it]))
                }
                MenuPill(HabitCopy.fullDays[(rule.weekday - 1 + 7) % 7], HabitCopy.fullDays, "often-weekday-day") { onChange(rule.copy(weekday = it + 1)) }
                Text("of the month", style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
            }
            else -> {}
        }
        NumberRow("Every", rule.interval, 1..12, 0, 1, "often-month-interval", { if (it == 1) "month" else "months" }) { onChange(rule.copy(interval = it)) }
    } else {
        Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(8.dp)) {
            MenuPill(HabitCopy.monthNames[rule.month - 1], HabitCopy.monthNames, "often-year-month") { m ->
                val month = m + 1
                onChange(rule.copy(month = month, day = minOf(rule.day, daysIn(month))))
            }
            MenuPill(HabitCopy.ordinal(rule.day), (1..daysIn(rule.month)).map { HabitCopy.ordinal(it) }, "often-year-day") { onChange(rule.copy(day = it + 1)) }
        }
        if (rule.month == 2 && rule.day == 29) Segments(listOf(true to "Use 28 February", false to "Skip that year"), rule.useLastDay, "often-leap") { onChange(rule.copy(useLastDay = it)) }
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
            Icon(Icons.Rounded.ArrowDropDown, null, tint = appColors.ink)
        }
        DropdownMenu(open, { open = false }, containerColor = appColors.surface) {
            options.forEachIndexed { i, o -> DropdownMenuItem({ Text(o) }, { onPick(i); open = false }) }
        }
    }
}

// ------------------------------------------------------------------ Time of Day

/** The parts of the day, any number of them; then "Or", Anytime; then a new time of day. */
@Composable
fun TimeOfDayPage(form: FormState, store: HabitStore, onBack: () -> Unit) {
    var adding by remember { mutableStateOf(false) }
    FormPage("Time of Day", chip = form.chipText(), onBack = onBack) {
        GroupTitle("Pick one or more")
        val timed = store.sections.filter { !it.isAnytime }
        SegmentedList {
            timed.forEachIndexed { i, s ->
                CheckRow(s.name, s.id in form.timesOfDay, i, timed.size, "part-${s.id}", detail = FormOutcome.hours(s, store)) { form.choose(s.id) }
            }
        }
        GroupTitle("Or")
        SegmentedList { RadioRow("Anytime", form.timesOfDay == listOf(DaySection.ANYTIME), 0, 1, "part-anytime", detail = "No set time") { form.choose(DaySection.ANYTIME) } }
        Spacer(Modifier.height(16.dp))
        SegmentedList { AddRow("New time of day", 0, 1, "new-time-of-day") { adding = true } }
        Note(FormOutcome.timeOfDay(form.previewHabit(), store))
    }
    if (adding) NewSectionDialog(store, { adding = false }) { id -> form.choose(id) }
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
            Button({
                val s = DaySection(newId(), clean, start, null)
                store.saveSections(store.sections + s)
                onAdded(s.id)
                onDismiss()
            }, enabled = clean.isNotEmpty() && !taken, colors = ButtonDefaults.buttonColors(containerColor = appColors.ink, contentColor = appColors.onInk),
                modifier = Modifier.semantics { testTag = "section-add" }) { Text("Add") }
        },
        dismissButton = { TextButton(onDismiss) { Text("Cancel", color = appColors.ink) } })
    if (picking) MinuteDialog(start, { picking = false }) { start = it }
}

// ------------------------------------------------------------------ Group

@Composable
fun GroupPage(form: FormState, store: HabitStore, onBack: () -> Unit) {
    var adding by remember { mutableStateOf(false) }
    FormPage("Group", chip = null, onBack = onBack) {
        val groups = store.groups
        SegmentedList {
            val count = groups.size + 1
            RadioRow("None", form.groupId == null, 0, count, "group-none") { form.groupId = null }
            groups.forEachIndexed { i, g -> RadioRow(g.name, form.groupId == g.id, i + 1, count, "group-${g.name}") { form.groupId = g.id } }
        }
        Note("A habit is in one group at a time. Filter Today and Progress by group.")
        Spacer(Modifier.height(8.dp))
        SegmentedList { AddRow("New group", 0, 1, "new-group") { adding = true } }
    }
    if (adding) NewGroupDialog(store, { adding = false }) { form.groupId = it }
}

/** "Get reminders on time" (design §15): why exact times matter, then Android's own Alarms & reminders page. */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ExactTimesSheet(onAllow: () -> Unit, onDismiss: () -> Unit) {
    val c = appColors
    ModalBottomSheet(onDismiss, containerColor = c.screen) {
        Column(Modifier.fillMaxWidth().padding(horizontal = 24.dp).padding(bottom = 24.dp).semantics { testTag = "exact-times-sheet" },
            horizontalAlignment = Alignment.CenterHorizontally) {
            Box(Modifier.size(64.dp).clip(CircleShape).background(c.tonal), contentAlignment = Alignment.Center) {
                Icon(Icons.Outlined.Alarm, null, tint = c.ink)
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
            com.oftenenough.app.ui.components.InkButton("Allow exact times", onAllow, Modifier.fillMaxWidth().semantics { testTag = "exact-times-allow" })
            Spacer(Modifier.height(8.dp))
            TextButton(onDismiss, Modifier.semantics { testTag = "exact-times-not-now" }) { Text("Not now", color = c.ink) }
        }
    }
}

/** "New group": put habits together, then filter Today and Progress by group. */
@Composable
fun NewGroupDialog(store: HabitStore, onDismiss: () -> Unit, onAdded: (String) -> Unit) {
    var name by remember { mutableStateOf("") }
    val clean = TextLimit.clean(name, TextLimit.GROUP)
    val exists = store.groups.any { it.name.equals(clean, ignoreCase = true) }
    AlertDialog(onDismiss, icon = { Icon(Icons.Rounded.CreateNewFolder, null) }, title = { Text("New group") },
        text = {
            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                Text("Put habits together, then filter Today and Progress by group.", textAlign = TextAlign.Center, color = appColors.secondary)
                Spacer(Modifier.height(16.dp))
                OutlinedTextField(name, { name = it.take(TextLimit.GROUP) }, label = { Text("Name") }, singleLine = true,
                    supportingText = { Text(if (exists) "There's a group with that name." else "${name.length}/${TextLimit.GROUP}", Modifier.fillMaxWidth(), textAlign = TextAlign.End) },
                    modifier = Modifier.fillMaxWidth().semantics { testTag = "group-name" },
                    colors = OutlinedTextFieldDefaults.colors(focusedBorderColor = appColors.ink, focusedLabelColor = appColors.ink, cursorColor = appColors.ink))
            }
        },
        confirmButton = {
            Button({
                val used = store.groups.map { it.color }.toSet()
                val g = HabitGroup(name = clean, color = HabitColor.entries.firstOrNull { it !in used } ?: HabitColor.BLUE)
                store.saveGroup(g)
                onAdded(g.id)
                onDismiss()
            }, enabled = clean.isNotEmpty() && !exists, colors = ButtonDefaults.buttonColors(containerColor = appColors.ink, contentColor = appColors.onInk),
                modifier = Modifier.semantics { testTag = "group-add" }) { Text("Add") }
        },
        dismissButton = { TextButton(onDismiss) { Text("Cancel", color = appColors.ink) } })
}

// ------------------------------------------------------------------ Reminders

/** Reminders: one per chosen time of day by default, any number more; then how, and the reminder's own words. */
@Composable
fun RemindersPage(form: FormState, store: HabitStore, onBack: () -> Unit) {
    var editing by remember { mutableStateOf<String?>(null) }
    val context = androidx.compose.ui.platform.LocalContext.current
    // Reminders turned on: Android's own question for notifications first, then exact times (A11 D1). Never in a test
    // launch: a system question stays over every later launch on that emulator (T18).
    var askExact by remember { mutableStateOf(false) }
    val askNotifications = androidx.activity.compose.rememberLauncherForActivityResult(
        androidx.activity.result.contract.ActivityResultContracts.RequestPermission()) {
        askExact = !com.oftenenough.app.app.reminders.Reminders.canBeExact(context)
    }
    val turnedOn: () -> Unit = {
        if (!com.oftenenough.app.app.AppGraph.isTest) {
            if (android.os.Build.VERSION.SDK_INT >= 33 && !com.oftenenough.app.app.reminders.Reminders.canPost(context))
                askNotifications.launch(android.Manifest.permission.POST_NOTIFICATIONS)
            else askExact = !com.oftenenough.app.app.reminders.Reminders.canBeExact(context)
        }
    }
    FormPage("Reminders", chip = if (form.type == ItemType.QUIT) null else form.chipText(), onBack = onBack) {
        SegmentedList {
            SwitchRow("Remind me", form.remindOn, 0, 1, "remind-me") { on ->
                form.remindOn = on
                if (on && (form.times.isEmpty() || !form.remindersEdited)) form.syncReminders(force = true)
                if (on) turnedOn()
            }
        }
        if (!form.remindOn) Note("No reminders. You'll see it on Today.")
        else {
            Spacer(Modifier.height(16.dp))
            SegmentedList {
                val count = form.times.size + 1
                form.times.forEachIndexed { i, t ->
                    Segment(i, count, Modifier.semantics { testTag = "reminder-$i" }) {
                        IconButton({ form.remindersEdited = true; form.times = form.times.filter { it.id != t.id } }) {
                            Icon(Icons.Rounded.Close, "Remove reminder", tint = appColors.secondary)
                        }
                        Text(t.part?.let { "${store.section(it).name} reminder" } ?: "Reminder", Modifier.weight(1f).padding(start = 8.dp), style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
                        com.oftenenough.app.ui.record.Pill(DayWords.clockMinute(t.minute), tag = "reminder-time-$i") { editing = t.id }
                    }
                }
                AddRow(if (form.times.isEmpty()) "Add reminder" else "Add another reminder", form.times.size, count, "add-reminder") { form.addReminder() }
            }
            if (form.times.isNotEmpty()) {
                Spacer(Modifier.height(16.dp))
                SegmentedList {
                    val rows = if (form.type != ItemType.CUT_DOWN) 2 else 1
                    // An alarm rings on Android's alarm sound until it's answered; never a full screen (A11 D3).
                    Segment(0, rows) {
                        Text("Remind me with", Modifier.weight(1f), style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
                        val styles = listOf("notification" to "A notification", "alarm" to "An alarm")
                        MenuPill(styles.first { it.first == form.alert }.second, styles.map { it.second }, "remind-with") { form.alert = styles[it].first }
                    }
                    if (form.type != ItemType.CUT_DOWN) Segment(1, rows) {
                        Text("If not done, remind again", Modifier.weight(1f), style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
                        val options = listOf(null, 15, 30, 60)
                        MenuPill(followWords(form.followUp), options.map { followWords(it) }, "follow-up") { form.followUp = options[it] }
                    }
                }
                Note(FormOutcome.reminders(form.previewHabit(), store, alarmsAvailable = true))
                Spacer(Modifier.height(8.dp))
                SegmentedList {
                    Segment(0, 1) {
                        Text("Reminder says", style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
                        Spacer(Modifier.width(16.dp))
                        BasicTextField(form.reminderWords, { form.reminderWords = it.take(TextLimit.REMINDER_TEXT) },
                            Modifier.weight(1f).semantics { testTag = "reminder-says"; contentDescription = "Reminder says" },
                            textStyle = MaterialTheme.typography.bodyLarge.copy(color = appColors.ink, textAlign = TextAlign.End), singleLine = true,
                            cursorBrush = SolidColor(appColors.ink),
                            decorationBox = { inner -> Box(contentAlignment = Alignment.CenterEnd) { if (form.reminderWords.isEmpty()) Text("Optional", style = MaterialTheme.typography.bodyLarge, color = appColors.secondary); inner() } })
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

/** Icons by group, with search; the chosen one filled in the habit's colour. Done keeps it, ✕ leaves it as it was. */
@Composable
fun IconPage(form: FormState, onBack: () -> Unit) {
    var chosen by remember { mutableStateOf(form.symbol) }
    var query by remember { mutableStateOf("") }
    FormPage("Icon", chip = null, onBack = onBack, close = true, scrolls = false, actions = {
        Button({ form.symbol = chosen; form.pickedSymbol = true; onBack() }, Modifier.padding(end = 8.dp).semantics { testTag = "icon-done" },
            colors = ButtonDefaults.buttonColors(containerColor = appColors.ink, contentColor = appColors.onInk)) { Text("Done") }
    }) {
        Row(Modifier.fillMaxWidth().padding(vertical = 8.dp).clip(RoundedCornerShape(28.dp)).background(appColors.tonal).heightIn(min = 56.dp).padding(horizontal = 16.dp),
            verticalAlignment = Alignment.CenterVertically) {
            Icon(Icons.Rounded.Search, null, tint = appColors.ink)
            Spacer(Modifier.width(16.dp))
            BasicTextField(query, { query = it.take(30) }, Modifier.weight(1f).semantics { testTag = "icon-search"; contentDescription = "Search icons" },
                textStyle = MaterialTheme.typography.bodyLarge.copy(color = appColors.ink), singleLine = true, cursorBrush = SolidColor(appColors.ink),
                decorationBox = { inner -> Box { if (query.isEmpty()) Text("Search icons", style = MaterialTheme.typography.bodyLarge, color = appColors.secondary); inner() } })
        }
        val q = query.trim().lowercase()
        val groups = HabitIcons.groups.mapNotNull { g ->
            val symbols = if (q.isEmpty()) g.symbols else g.symbols.filter { s ->
                g.name.lowercase().contains(q) || s.contains(q) || HabitIcons.keywords[s]?.any { it.contains(q) } == true
            }
            symbols.takeIf { it.isNotEmpty() }?.let { g.name to it }
        }
        if (groups.isEmpty()) Note("No icons match \"${query.trim()}\".")
        LazyVerticalGrid(GridCells.Fixed(6), Modifier.weight(1f), horizontalArrangement = Arrangement.spacedBy(8.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
            for ((name, symbols) in groups) {
                item(key = "h-$name", span = { GridItemSpan(maxLineSpan) }) { GroupTitle(name) }
                items(symbols, key = { "$name-$it" }) { s ->
                    val on = s == chosen
                    Box(Modifier.aspectRatio(1f).clip(if (on) CircleShape else RoundedCornerShape(16.dp)).background(if (on) appColors.habit(form.color) else appColors.surface)
                        .clickable { chosen = s }.semantics { contentDescription = HabitIcons.spokenName(s) + if (on) ", chosen" else ""; testTag = "icon-$s" },
                        contentAlignment = Alignment.Center) {
                        Icon(HabitIcons.icon(s), null, Modifier.size(28.dp), tint = if (on) Color.White else appColors.ink)
                    }
                }
            }
        }
    }
}

/** The thirteen habit colours, in a sheet. */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ColourSheet(form: FormState, onDismiss: () -> Unit) {
    ModalBottomSheet(onDismiss, containerColor = appColors.surface) {
        Column(Modifier.padding(horizontal = 24.dp).padding(bottom = 32.dp)) {
            Text("Colour", style = MaterialTheme.typography.headlineSmall, color = appColors.ink)
            Spacer(Modifier.height(20.dp))
            for (row in HabitColor.entries.chunked(7)) {
                Row(Modifier.fillMaxWidth().padding(bottom = 12.dp), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    for (c in row) {
                        val on = c == form.color
                        Box(Modifier.weight(1f).aspectRatio(1f).clip(CircleShape)
                            .border(if (on) 3.dp else 0.dp, if (on) appColors.ink else Color.Transparent, CircleShape)
                            .padding(if (on) 6.dp else 0.dp).clip(CircleShape).background(appColors.habit(c))
                            .clickable { form.color = c; onDismiss() }
                            .semantics { contentDescription = c.key.replaceFirstChar { it.uppercase() } + if (on) ", chosen" else ""; testTag = "colour-${c.key}" })
                    }
                    repeat(7 - row.size) { Spacer(Modifier.weight(1f)) }
                }
            }
        }
    }
}

@Suppress("unused") private val unusedShape = segmentShape(0, 1)
@Suppress("unused") private fun unusedWidth() = Modifier.widthIn(min = 0.dp)
