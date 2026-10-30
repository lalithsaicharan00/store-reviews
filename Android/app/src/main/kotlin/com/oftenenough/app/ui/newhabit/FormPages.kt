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
import com.oftenenough.app.ui.components.AppSwitch
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
import androidx.compose.material3.RadioButton
import androidx.compose.ui.semantics.Role
import androidx.compose.foundation.selection.toggleable
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

/**
 * 5.7.9, **How much page** (Figma 1102:2782, State Typing · Keyboard down; Components — Atoms Build Plan), from the
 * form's How much (and, until 5.7.13, Limit). On Surface container: the Top app bar (← "How much"); 16 at the sides and
 * above, 40 under, 24 between: the amount's card (Surface bright, corners 24, 24 above and under, 20 at the sides, 16
 * apart): the number field (80, Surface container highest, corners 16, Display Medium, the number pad up while it's
 * empty) over the Unit dropdown; its footer, "Up to 2 decimal places. The unit is optional."; then **When you log it**
 * (Label Large Primary): One tap adds a set amount, with Each tap adds and its step, or Type the amount each time. That
 * choice holds everywhere logging happens. Nothing above the number repeats How often (A64).
 */
@Composable
fun HowMuchPage(form: FormState, onUnit: () -> Unit, onBack: () -> Unit) {
    val limit = form.type == ItemType.CUT_DOWN
    val s = MaterialTheme.colorScheme
    FormPage(if (limit) "Limit" else "How much", onBack = onBack) {
        val focus = remember { FocusRequester() }
        var focused by remember { mutableStateOf(false) }
        LaunchedEffect(Unit) { if (form.amountText.isEmpty()) runCatching { focus.requestFocus() } }
        val number = @Composable {
            BasicTextField(
                form.amountText, { form.amountText = it.filter { c -> c.isDigit() || c == '.' || c == ',' }.take(12) },
                Modifier.fillMaxWidth().clip(RoundedCornerShape(16.dp)).background(s.surfaceContainerHighest)
                    .border(if (focused) 2.dp else 0.dp, if (focused) s.primary else Color.Transparent, RoundedCornerShape(16.dp))
                    .heightIn(min = 80.dp).focusRequester(focus).onFocusChanged { focused = it.isFocused }
                    .semantics { testTag = "much-number"; contentDescription = if (limit) "Limit" else "Amount" },
                textStyle = AppType.displayMedium.copy(color = s.onSurface, textAlign = TextAlign.Center),
                keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Decimal, imeAction = ImeAction.Done),
                singleLine = true, cursorBrush = SolidColor(s.primary),
                decorationBox = { inner ->
                    Box(Modifier.padding(horizontal = 16.dp, vertical = 14.dp), contentAlignment = Alignment.Center) {
                        if (form.amountText.isEmpty() && !focused) Text(if (limit) "2" else "8", style = AppType.displayMedium.copy(color = s.onSurfaceVariant.copy(alpha = 0.45f)))
                        inner()
                    }
                },
            )
            DropdownField("Unit", form.unit.ifEmpty { "No unit" }, onUnit, Modifier.fillMaxWidth(), tag = "much-unit")
        }
        val text = form.amountText.trim()
        val error = if (text.isNotEmpty() && (GoalNumber.parse(text)?.let { it > 0 } != true)) "Enter a number above 0, with up to 2 decimal places." else null
        if (limit) {
            // The limit's own page is 5.7.13; until then it keeps its card.
            GoalCard(oftenHeader(form)) { number() }
            Note(error ?: "Log it only when it happens. Staying at or under the limit counts as a good day.")
            return@FormPage
        }
        Column(Modifier.padding(top = 16.dp, bottom = 16.dp), verticalArrangement = Arrangement.spacedBy(24.dp)) {
            Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(s.surfaceBright).padding(horizontal = 20.dp, vertical = 24.dp),
                    horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(16.dp)) { number() }
                Text(error ?: "Up to 2 decimal places. The unit is optional.", Modifier.padding(horizontal = 16.dp),
                    style = AppType.bodySmall, color = s.onSurfaceVariant)
            }
            if (form.type == ItemType.AMOUNT) WhenYouLogIt(form)
        }
    }
}

/**
 * When you log it (Figma's How much): One tap adds a set amount (chosen, Each tap adds and its step: 72 wide, Surface
 * container highest, corners 8, the number at its end) or Type the amount each time.
 */
@Composable
private fun WhenYouLogIt(form: FormState) {
    val s = MaterialTheme.colorScheme
    val plan = form.plan
    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
        Text("When you log it", Modifier.padding(horizontal = 16.dp).semantics { heading() }, style = AppType.labelLarge, color = s.primary)
        SegmentedList {
            if (!form.asks) OpenOption("One tap adds a set amount", 0, 2, "tap-adds-step") {
                Row(Modifier.fillMaxWidth().padding(horizontal = 16.dp), horizontalArrangement = Arrangement.spacedBy(16.dp), verticalAlignment = Alignment.CenterVertically) {
                    Text("Each tap adds", Modifier.weight(1f), style = AppType.bodyLarge, color = s.onSurface)
                    var text by remember { mutableStateOf(form.step?.let { GoalNumber.text(it) } ?: "") }
                    BasicTextField(text, { t -> text = t.filter { it.isDigit() || it == '.' || it == ',' }.take(10); form.step = GoalNumber.parse(text)?.takeIf { it > 0 } },
                        Modifier.width(72.dp).clip(RoundedCornerShape(8.dp)).background(s.surfaceContainerHighest).heightIn(min = 40.dp).padding(end = 12.dp, start = 12.dp)
                            .semantics { testTag = "tap-step"; contentDescription = "Each tap adds" },
                        textStyle = AppType.bodyLarge.copy(color = s.onSurface, textAlign = TextAlign.End), singleLine = true,
                        keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Decimal), cursorBrush = SolidColor(s.primary),
                        decorationBox = { inner -> Box(Modifier.heightIn(min = 40.dp), contentAlignment = Alignment.CenterEnd) { if (text.isEmpty()) Text(HabitCopy.number(plan.stepValue), style = AppType.bodyLarge, color = s.onSurface); inner() } })
                }
            } else RadioRow("One tap adds a set amount", false, 0, 2, "tap-adds-step", option = true) { form.asks = false }
            RadioRow("Type the amount each time", form.asks, 1, 2, "tap-asks", option = true) { form.asks = true }
        }
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

/**
 * 5.7.11, **How long page** (Figma 1103:3208, State Typing · Quick pick; Components — Atoms Build Plan), from Time it's
 * How long (Material's time input, A-decision of 18 Oct). On Surface container: the Top app bar (← "How long"); 16 at the
 * sides and above, 40 under, 24 between: the card (Surface bright, corners 24, 24 above and under, 20 at the sides) with
 * Hours and Minutes side by side, 12 apart: each box 80 tall on Surface container highest, corners 16, the number in
 * Display Medium Emphasized (Primary's 2 dp ring while typing; the cursor starts in Minutes), its label under it in Body
 * Medium On surface variant; then **Quick picks** (Label Large Primary) as filter chips, 8 apart, and the footer "The
 * timer on Today counts up to it." Nothing above the boxes repeats How often (A64).
 */
@OptIn(ExperimentalLayoutApi::class)
@Composable
fun HowLongPage(form: FormState, onBack: () -> Unit) {
    val s = MaterialTheme.colorScheme
    FormPage("How long", onBack = onBack) {
        val minutesFocus = remember { FocusRequester() }
        LaunchedEffect(Unit) { if (form.amountValue == null) runCatching { minutesFocus.requestFocus() } }
        Column(Modifier.padding(top = 16.dp, bottom = 16.dp), verticalArrangement = Arrangement.spacedBy(24.dp)) {
            Row(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(s.surfaceBright).padding(horizontal = 20.dp, vertical = 24.dp),
                horizontalArrangement = Arrangement.spacedBy(12.dp)) {
                TimeBox(form.hours, "Hours", "how-long-hours", Modifier.weight(1f), Modifier) { form.hours = it }
                TimeBox(form.minutes, "Minutes", "how-long-minutes", Modifier.weight(1f), Modifier.focusRequester(minutesFocus)) { form.minutes = it }
            }
            val total = form.amountValue?.toInt()
            Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                Text("Quick picks", Modifier.padding(horizontal = 16.dp).semantics { heading() }, style = AppType.labelLarge, color = s.primary)
                FlowRow(horizontalArrangement = Arrangement.spacedBy(8.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
                    for (m in listOf(5, 10, 15, 20, 30, 45, 60)) AppFilterChip(if (m == 60) "1 h" else "$m min", total == m, tag = "pick-$m", onClick = {
                        form.hours = if (m >= 60) (m / 60).toString() else ""; form.minutes = (m % 60).toString().padStart(2, '0')
                    })
                }
                val period = form.amountPeriod
                Text(if (form.minutes.toIntOrNull()?.let { it >= 60 } == true) "Minutes go up to 59; use hours for more."
                    else if (period == GoalPeriod.DAY) "The timer on Today counts up to it."
                    else "How long in a ${period.noun}, in total. The timer on Today counts up to it.",
                    Modifier.padding(horizontal = 16.dp), style = AppType.bodySmall, color = s.onSurfaceVariant)
            }
        }
    }
}

/** One of How long's boxes (Figma's Field): the number over its label, 8 apart; "0" until something is typed. */
@Composable
private fun TimeBox(value: String, label: String, tag: String, modifier: Modifier, fieldModifier: Modifier, onChange: (String) -> Unit) {
    val s = MaterialTheme.colorScheme
    var focused by remember { mutableStateOf(false) }
    Column(modifier, horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(8.dp)) {
        BasicTextField(
            value, { onChange(it.filter { c -> c.isDigit() }.take(3)) },
            fieldModifier.fillMaxWidth().clip(RoundedCornerShape(16.dp)).background(s.surfaceContainerHighest)
                .border(if (focused) 2.dp else 0.dp, if (focused) s.primary else Color.Transparent, RoundedCornerShape(16.dp))
                .heightIn(min = 80.dp).onFocusChanged { focused = it.isFocused }.semantics { testTag = tag; contentDescription = label },
            textStyle = AppType.displayMediumEmphasized.copy(color = s.onSurface, textAlign = TextAlign.Center),
            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number), singleLine = true, cursorBrush = SolidColor(s.primary),
            decorationBox = { inner ->
                Box(Modifier.heightIn(min = 80.dp), contentAlignment = Alignment.Center) {
                    if (value.isEmpty() && !focused) Text("0", style = AppType.displayMediumEmphasized.copy(color = s.onSurfaceVariant))
                    inner()
                }
            },
        )
        Text(label, style = AppType.bodyMedium, color = s.onSurfaceVariant)
    }
}

// ------------------------------------------------------------------ Unit

/**
 * 5.7.10, **Unit page** (Figma 1102:3316, State No unit · Creating your own · Searching · Own unit added; Components —
 * Atoms Build Plan), from How much's Unit. On Surface container: the Top app bar (← "Unit"); 16 at the sides and above,
 * 40 under, 24 between: the Search bar ("Search units"); **Your own** (No unit, the units of your own, + Create your
 * own unit, which opens its field with Done, off until something is typed; "Anything you count, in a word or two:
 * prayers, laps, sets."); then the common units by what they count (Drinking, Walking and running, Reading and
 * writing, Exercise, Everyday, Money), each a subheader in Label Large Primary over radio Options in Body Large.
 * Searching shows only the matching units, in their groups. A tap chooses and goes back.
 */
@Composable
fun UnitPage(form: FormState, store: HabitStore, onBack: () -> Unit) {
    val limit = form.type == ItemType.CUT_DOWN
    val s = MaterialTheme.colorScheme
    var creating by remember { mutableStateOf(false) }
    var custom by remember { mutableStateOf("") }
    var query by remember { mutableStateOf("") }
    // The phone's own locale, read so the list follows a change of language or region.
    val locale = androidx.compose.ui.platform.LocalConfiguration.current.locales[0]
    val metric = locale.country !in setOf("US", "LR", "MM")
    val own = runCatching { Currency.getInstance(locale).getSymbol(locale) }.getOrNull()?.takeIf { it.length <= 3 } ?: "$"
    val money = listOf(own) + listOf("$", "€", "£", "₹").filter { it != own }
    val volume = if (metric) listOf("ml", "litres", "oz") else listOf("oz", "ml", "litres")
    val distance = if (metric) listOf("km", "miles") else listOf("miles", "km")
    val groups = buildList {
        // A time limit is chosen here until Limit's own Amount · Time (5.7.13, A67).
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
    // The form's own unit, made here and in no other habit yet: it shows with ✕, which takes it off.
    val mine = form.unit.takeIf { it.isNotBlank() && it !in known && it !in used }
    val yours = used + listOfNotNull(mine)
    fun pick(value: String) { form.unit = value; onBack() }
    @Composable fun Subheader(text: String) = Text(text, Modifier.padding(horizontal = 16.dp).semantics { heading() }, style = AppType.labelLarge, color = s.primary)
    FormPage("Unit", onBack = onBack) {
        Column(Modifier.padding(top = 16.dp, bottom = 16.dp), verticalArrangement = Arrangement.spacedBy(24.dp)) {
            SearchBarField(query, { query = it.take(30) }, "Search units", fieldTag = "unit-search")
            val q = query.trim().lowercase()
            if (q.isEmpty()) Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                Subheader("Your own")
                SegmentedList {
                    val count = 2 + yours.size + (if (creating) 1 else 0)
                    RadioRow("No unit", form.unit.isBlank(), 0, count, "no-unit", option = true) { pick("") }
                    yours.forEachIndexed { i, u ->
                        AppListItem(u, 1 + i, count, leading = { RadioButton(form.unit == u, onClick = null) }, onClick = { pick(u) },
                            trailing = if (u == mine) ({ StandardIconButton(Symbols.Close, "Remove $u", { form.unit = "" }) }) else null,
                            containerColor = s.surfaceBright, headlineStyle = AppType.bodyLarge, tag = "unit-$u")
                    }
                    if (creating) {
                        val focus = remember { FocusRequester() }
                        LaunchedEffect(Unit) { runCatching { focus.requestFocus() } }
                        val done = { TextLimit.clean(custom, TextLimit.UNIT).takeIf { it.isNotEmpty() }?.let(::pick) }
                        FormField(custom, { custom = it.take(TextLimit.UNIT) }, "e.g. prayers", 1 + yours.size, count,
                            fieldModifier = Modifier.focusRequester(focus).semantics { testTag = "custom-unit" },
                            keyboardOptions = KeyboardOptions(imeAction = ImeAction.Done), keyboardActions = KeyboardActions(onDone = { done() }),
                            containerColor = s.surfaceBright) {
                            AppButton("Done", { done() }, Modifier.padding(end = 4.dp), enabled = custom.isNotBlank(), style = ButtonStyle.Text, tag = "custom-unit-done")
                        }
                    }
                    AppListItem("Create your own unit", count - 1, count, leading = { Box(Modifier.size(40.dp), contentAlignment = Alignment.Center) { Icon(Symbols.Add, null) } },
                        onClick = { creating = true }, containerColor = s.surfaceBright, headlineStyle = AppType.bodyLarge, tag = "create-unit")
                }
                Text(TextLimit.note(custom, TextLimit.UNIT) ?: "Anything you count, in a word or two: prayers, laps, sets.",
                    Modifier.padding(horizontal = 16.dp), style = AppType.bodySmall, color = s.onSurfaceVariant)
            }
            for ((title, units) in groups) {
                val shown = if (q.isEmpty()) units else units.filter { it.lowercase().contains(q) }
                if (shown.isEmpty()) continue
                Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                    Subheader(title)
                    SegmentedList { shown.forEachIndexed { i, u -> RadioRow(u, form.unit == u, i, shown.size, "unit-$u", option = true) { pick(u) } } }
                }
            }
        }
    }
}

// ------------------------------------------------------------------ Steps

/**
 * 5.7.12, **Steps page** (Figma 1104:163327, State Typing a step; Components — Atoms Build Plan), from a checklist's
 * Steps. On Surface container: the Top app bar (← "Steps"); 16 at the sides and above, 40 under: one list, 2 apart, on
 * Surface bright: each step a Form field with its handle (drag to reorder; TalkBack's Move up and Move down) and ✕
 * ("Step 4" until typed, the new one focused), then + Add step (Body Large); 8 under it, "Up to 24 letters a step. Each
 * step is ticked on its own."
 */
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
    val s = MaterialTheme.colorScheme
    FormPage("Steps", onBack = onBack) {
        SegmentedList(Modifier.padding(top = 16.dp, bottom = 8.dp)) {
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
                        Modifier.focusRequester(focus).semantics { testTag = "step-field-$i" }, containerColor = s.surfaceBright,
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
            AppListItem("Add step", items.size, count, leading = { Box(Modifier.size(40.dp), contentAlignment = Alignment.Center) { Icon(Symbols.Add, null) } },
                onClick = {
                    val step = Step(name = "")
                    form.items = form.items + step
                    focusNew = step.id
                }, containerColor = s.surfaceBright, headlineStyle = AppType.bodyLarge, tag = "add-step")
        }
        Text("Up to ${TextLimit.CHECKLIST_PART} letters a step. Each step is ticked on its own.", Modifier.padding(horizontal = 16.dp).padding(bottom = 16.dp),
            style = AppType.bodySmall, color = s.onSurfaceVariant)
    }
}

// ------------------------------------------------------------------ How often

/**
 * 5.7.6, **How often page** (Figma 1075:161386, Option Every day · Several times a day · Times a week, month or year ·
 * On certain days of the week · Every few days · Every few weeks (and on set days) · Every few months · On a date
 * (dates, a weekday, a year) · Cut down · Task (every day, a while after it’s done) · Every day at 200%; Components —
 * Atoms Build Plan). From the form's How often. On Surface container: the Top app bar (← "How often"); one list of
 * options, 16 at the sides and above, 40 under, 16 between groups and 2 within, no group titles (A64): each a radio
 * Option on Surface bright, its words in Body Large. The chosen one says what it means as it's set ("Twice a day", "3
 * times a week", "Every Monday, Wednesday and Friday", "Every other week on Friday", "On the 23rd of every month",
 * "Every year on October 23", "2 weeks after it’s done") and opens its own settings in the same piece: a Stepper, Week ·
 * Month · Year (or Month · Year, Days · Weeks · Months), Weekdays · Weekends with the seven days, On set days, Repeat on
 * with the dates or Which and Day, Month and Day. A limit chooses at most a day, a week or a month; a task has no
 * several times a day or number of times, and has "A while after it’s done".
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
    // Week · Month · Year over the count (Figma's Period: 4 above, 8 under, 16 at the sides).
    @Composable
    fun countControls(days: Boolean) {
        Box(Modifier.padding(start = 16.dp, end = 16.dp, top = 4.dp)) {
            AppConnectedButtons(listOf(GoalPeriod.WEEK to "Week", GoalPeriod.MONTH to "Month", GoalPeriod.YEAR to "Year"), d.countPeriod, tag = "often-count-period") { p ->
                val next = d.copy(countPeriod = p)
                set(next.copy(count = minOf(next.count, next.countMaximum(days))))
            }
        }
        Stepper(if (days) "Days" else "Times", d.count, 1..d.countMaximum(days), "often-count") { set(d.copy(count = it)) }
    }
    /** A group of options: [rows] (title, chosen, tag, pick, its settings or none), 2 apart. */
    @Composable
    fun Options(vararg rows: Option) {
        SegmentedList {
            rows.forEachIndexed { i, o ->
                if (o.chosen && o.settings != null) OpenOption(o.title, i, rows.size, o.tag, o.bottom, content = o.settings)
                else RadioRow(o.title, o.chosen, i, rows.size, o.tag, option = true, onClick = o.pick)
            }
        }
    }

    FormPage("How often", onBack = onBack) {
        Column(Modifier.padding(top = 16.dp, bottom = 16.dp), verticalArrangement = Arrangement.spacedBy(16.dp)) {
            if (limit) {
                Options(
                    Option(words(HowOften.EveryDay), d.choice == Choice.EVERY_DAY, "often-every-day") { set(d.copy(choice = Choice.EVERY_DAY)) },
                    Option(words(HowOften.Total(GoalPeriod.WEEK)), d.choice == Choice.TOTAL && d.totalPeriod == GoalPeriod.WEEK, "often-total-week") { set(d.copy(choice = Choice.TOTAL, totalPeriod = GoalPeriod.WEEK)) },
                    Option(words(HowOften.Total(GoalPeriod.MONTH)), d.choice == Choice.TOTAL && d.totalPeriod == GoalPeriod.MONTH, "often-total-month") { set(d.copy(choice = Choice.TOTAL, totalPeriod = GoalPeriod.MONTH)) },
                )
                return@Column
            }
            if (hasAmount) {
                Options(
                    Option(words(HowOften.EveryDay), d.choice == Choice.EVERY_DAY, "often-every-day") { set(d.copy(choice = Choice.EVERY_DAY)) },
                    *listOf(GoalPeriod.WEEK, GoalPeriod.MONTH, GoalPeriod.YEAR).map { p ->
                        Option(words(HowOften.Total(p)), d.choice == Choice.TOTAL && d.totalPeriod == p, "often-total-${p.noun}") { set(d.copy(choice = Choice.TOTAL, totalPeriod = p)) }
                    }.toTypedArray(),
                )
                val open = d.choice == Choice.TIMES
                Options(Option(if (open) words(countChoice) else "Days a week, month or year", open, "often-times", settings = { countControls(true) }) { set(d.copy(choice = Choice.TIMES)) })
            } else if (task) {
                Options(Option("Every day", d.choice == Choice.EVERY_DAY, "often-every-day") { set(d.copy(choice = Choice.EVERY_DAY)) })
            } else {
                val several = d.choice == Choice.TIMES_A_DAY
                Options(
                    Option("Every day", d.choice == Choice.EVERY_DAY, "often-every-day") { set(d.copy(choice = Choice.EVERY_DAY)) },
                    Option(if (several) words(HowOften.TimesADay(maxOf(2, d.perDay))) else "Several times a day", several, "often-times-a-day",
                        settings = { Stepper("Times a day", d.perDay, 2..99, "often-per-day") { set(d.copy(perDay = it)) } }) { set(d.copy(choice = Choice.TIMES_A_DAY)) },
                )
                val open = d.choice == Choice.TIMES
                Options(Option(if (open) words(countChoice) else "Times a week, month or year", open, "often-times", settings = { countControls(false) }) { set(d.copy(choice = Choice.TIMES)) })
            }
            // On certain days of the week: Weekdays · Weekends (4 above, 16 under), then the seven days, 24 under.
            val weekdays = d.choice == Choice.WEEKDAYS
            Options(Option(if (weekdays) HabitCopy.capitalized(words(HowOften.Weekdays(d.weekdays))) else "On certain days of the week", weekdays, "often-weekdays", bottom = 24.dp,
                settings = {
                    Row(Modifier.padding(start = 16.dp, end = 16.dp, top = 4.dp, bottom = 8.dp), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                        AppFilterChip("Weekdays", false, { set(d.copy(weekdays = setOf(2, 3, 4, 5, 6))) }, tag = "often-weekdays-quick")
                        AppFilterChip("Weekends", false, { set(d.copy(weekdays = setOf(1, 7))) }, tag = "often-weekends-quick")
                    }
                    Box(Modifier.padding(horizontal = 16.dp)) {
                        WeekdayCircles(d.weekdays, ws, "often-weekday-picker") { days -> set(if (days.size == 7) d.copy(choice = Choice.EVERY_DAY) else d.copy(weekdays = days)) }
                    }
                }) { set(d.copy(choice = Choice.WEEKDAYS)) })
            // Every few days, weeks or months.
            val days = d.choice == Choice.EVERY_DAYS
            val weeks = d.choice == Choice.EVERY_WEEKS
            val months = d.choice == Choice.EVERY_MONTHS
            Options(
                Option(if (days) HabitCopy.capitalized(HabitCopy.everyN(d.daysInterval, "day")) else "Every few days", days, "often-every-days",
                    settings = { Stepper("Every", d.daysInterval, 2..365, "often-every-count", { "days" }) { set(d.copy(daysInterval = it)) } }) { set(d.copy(choice = Choice.EVERY_DAYS)) },
                Option(if (weeks) HabitCopy.capitalized(words(d.often(hasAmount))) else "Every few weeks", weeks, "often-every-weeks",
                    bottom = if (d.weeksDays.isNotEmpty()) 24.dp else 12.dp,
                    settings = {
                        Stepper("Every", d.weeksInterval, 1..52, "often-weeks-count", { if (it == 1) "week" else "weeks" }) { set(d.copy(weeksInterval = it)) }
                        val on = d.weeksDays.isNotEmpty()
                        Row(Modifier.fillMaxWidth().toggleable(on, role = Role.Switch) { now ->
                                val start = java.time.LocalDate.ofEpochDay(form.startDate.toLong()).dayOfWeek.value % 7 + 1
                                set(d.copy(weeksDays = if (now) setOf(start) else emptySet()))
                            }.semantics { testTag = "often-weeks-days" }.padding(start = 16.dp, end = 16.dp, top = 12.dp, bottom = if (on) 16.dp else 12.dp),
                            horizontalArrangement = Arrangement.spacedBy(16.dp), verticalAlignment = Alignment.CenterVertically) {
                            Text("On set days", Modifier.weight(1f), style = AppType.bodyLarge, color = MaterialTheme.colorScheme.onSurface)
                            AppSwitch(on)
                        }
                        if (on) Box(Modifier.padding(horizontal = 16.dp)) { WeekdayCircles(d.weeksDays, ws, "often-weeks-picker") { set(d.copy(weeksDays = it)) } }
                    }) { set(d.copy(choice = Choice.EVERY_WEEKS)) },
                Option(if (months) HabitCopy.capitalized(words(d.often(hasAmount))) else "Every few months", months, "often-every-months",
                    settings = { Stepper("Every", d.monthsInterval, 1..24, "often-months-count", { if (it == 1) "month" else "months" }) { set(d.copy(monthsInterval = it)) } }) { set(d.copy(choice = Choice.EVERY_MONTHS)) },
            )
            // On a date each month or year.
            val date = d.choice == Choice.DATE
            Options(Option(if (date) HabitCopy.capitalized(words(HowOften.Calendar(d.dateRule))) else "On a date each month or year", date, "often-date", bottom = 24.dp,
                settings = { DateControls(d.dateRule) { set(d.copy(dateRule = it)) } }) { set(d.copy(choice = Choice.DATE)) })
            setDaysNote(d)?.let { Note(it) }
            if (task) {
                val after = d.choice == Choice.AFTER_DONE
                Options(Option(if (after) HabitCopy.capitalized(words(d.often(false))) else "A while after it’s done", after, "often-after-done",
                    settings = {
                        Box(Modifier.padding(start = 16.dp, end = 16.dp, top = 4.dp)) {
                            AppConnectedButtons(listOf(GoalPeriod.DAY, GoalPeriod.WEEK, GoalPeriod.MONTH).map { it to HabitCopy.capitalized(it.noun) + "s" }, d.afterUnit, tag = "often-after-unit") { set(d.copy(afterUnit = it)) }
                        }
                        Stepper("Again after", d.afterCount, 1..365, "often-after-count") { set(d.copy(afterCount = it)) }
                    }) { set(d.copy(choice = Choice.AFTER_DONE)) })
            }
        }
    }
}

/** One option of How often: its words, whether it's chosen, its tag, its settings while chosen and the room under them. */
class Option(
    val title: String, val chosen: Boolean, val tag: String, val bottom: androidx.compose.ui.unit.Dp = 16.dp,
    val settings: (@Composable ColumnScope.() -> Unit)? = null, val pick: () -> Unit,
)

private fun setDaysNote(d: OftenDraft): String? {
    if (d.choice != Choice.DATE) return null
    val r = d.dateRule
    if (r.unit == GoalPeriod.MONTH && r.pattern == "Dates" && r.dates.any { it > 28 }) return if (r.useLastDay) "Months without that date use their last day." else "Months without that date are skipped."
    if (r.unit == GoalPeriod.MONTH && r.pattern == "Weekday" && r.ordinal == 5) return "Months without a fifth ${HabitCopy.fullDays[(r.weekday - 1 + 7) % 7]} are skipped."
    if (r.unit == GoalPeriod.YEAR && r.month == 2 && r.day == 29) return if (r.useLastDay) "Years without 29 February use 28 February." else "Years without 29 February are skipped."
    return null
}

/**
 * On a date (Figma): Month · Year (4 above, 16 under); a month's Repeat on (Dates, The last day, A weekday; 8 above, 16
 * under) over the 31 dates (seven to a row, 8 apart, 8 in) or Which and Day; a year's Month and Day. All 16 at the sides.
 */
@Composable
private fun ColumnScope.DateControls(rule: CalendarRule, onChange: (CalendarRule) -> Unit) {
    Box(Modifier.padding(start = 16.dp, end = 16.dp, top = 4.dp, bottom = 8.dp)) {
        AppConnectedButtons(listOf(GoalPeriod.MONTH to "Month", GoalPeriod.YEAR to "Year"), rule.unit, tag = "often-date-unit") { onChange(rule.copy(unit = it)) }
    }
    if (rule.unit == GoalPeriod.MONTH) {
        val patterns = listOf("Dates" to "Dates", "Last day" to "The last day", "Weekday" to "A weekday")
        DropdownField("Repeat on", patterns.first { it.first == rule.pattern }.second, patterns.map { it.second },
            { onChange(rule.copy(pattern = patterns[it].first)) }, Modifier.padding(start = 16.dp, end = 16.dp, bottom = 8.dp), tag = "often-date-pattern")
        when (rule.pattern) {
            "Dates" -> {
                // A plain grid sized up front, never a lazy one (S13): seven dates a row, spread across it, rows 8 apart (Figma).
                Column(Modifier.padding(horizontal = 8.dp).semantics { testTag = "often-month-dates" }, verticalArrangement = Arrangement.spacedBy(8.dp)) {
                    for (week in (1..31).chunked(7)) Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
                        for (date in week) DayToggle("$date", date in rule.dates, { on -> onChange(rule.copy(dates = if (on) rule.dates + date else rule.dates - date)) },
                            "Day $date", size = DayToggleSize.Date)
                        repeat(7 - week.size) { Spacer(Modifier.size(DayToggleSize.Date.size)) }
                    }
                }
                if (rule.dates.any { it > 28 }) Box(Modifier.padding(horizontal = 16.dp)) {
                    AppConnectedButtons(listOf(true to "Use the last day", false to "Skip that month"), rule.useLastDay, tag = "often-short-months") { onChange(rule.copy(useLastDay = it)) }
                }
            }
            "Weekday" -> Row(Modifier.padding(horizontal = 16.dp), horizontalArrangement = Arrangement.spacedBy(16.dp)) {
                val ordinals = listOf(1, 2, 3, 4, 5, -1)
                DropdownField("Which", HabitCopy.capitalized(HabitCopy.ordinalWord(rule.ordinal)), ordinals.map { HabitCopy.capitalized(HabitCopy.ordinalWord(it)) },
                    { onChange(rule.copy(ordinal = ordinals[it])) }, Modifier.weight(1f), tag = "often-weekday-ordinal")
                DropdownField("Day", HabitCopy.fullDays[(rule.weekday - 1 + 7) % 7], HabitCopy.fullDays,
                    { onChange(rule.copy(weekday = it + 1)) }, Modifier.weight(1f), tag = "often-weekday-day")
            }
            else -> {}
        }
    } else {
        Row(Modifier.padding(horizontal = 16.dp), horizontalArrangement = Arrangement.spacedBy(16.dp)) {
            DropdownField("Month", HabitCopy.monthNames[rule.month - 1], HabitCopy.monthNames, { m ->
                val month = m + 1
                onChange(rule.copy(month = month, day = minOf(rule.day, daysIn(month))))
            }, Modifier.weight(1f), tag = "often-year-month")
            DropdownField("Day", "${rule.day}", (1..daysIn(rule.month)).map { "$it" }, { onChange(rule.copy(day = it + 1)) },
                Modifier.weight(1f), tag = "often-year-day")
        }
        if (rule.month == 2 && rule.day == 29) Box(Modifier.padding(horizontal = 16.dp)) {
            AppConnectedButtons(listOf(true to "Use 28 February", false to "Skip that year"), rule.useLastDay, tag = "often-leap") { onChange(rule.copy(useLastDay = it)) }
        }
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
 * 5.7.7, **Time of day page** (Figma 1098:2480, Option At set times of day · Anytime; Components — Atoms Build Plan),
 * from the form's Time of day. On Surface container: the Top app bar (← "Time of day"); one group of two Options 16 in
 * and 16 down, on Surface bright: Anytime ("No set time") and At set times of day ("Pick one or more"). Chosen, the
 * second opens in the same piece: the times of day as checkboxes, 40 further in, each with its hours ("6:00 AM – 12:00
 * PM"), and + New time of day, which opens the same page as Settings › Times of day; 8 under. No line under it repeating
 * the choice (A64).
 */
@Composable
fun TimeOfDayPage(form: FormState, store: HabitStore, onBack: () -> Unit, onNew: () -> Unit) {
    val anytime = form.timesOfDay == listOf(DaySection.ANYTIME)
    // At set times of day, chosen before any time is ticked: the times show, waiting for one.
    var setTimes by remember { mutableStateOf(!anytime) }
    FormPage("Time of day", onBack = onBack) {
        val timed = store.sections.filter { !it.isAnytime }
        val showTimes = setTimes || !anytime
        SegmentedList(Modifier.padding(top = 16.dp, bottom = 16.dp)) {
            RadioRow("Anytime", !showTimes, 0, 2, "part-anytime", detail = "No set time", option = true) { setTimes = false; form.choose(DaySection.ANYTIME) }
            if (!showTimes) RadioRow("At set times of day", false, 1, 2, "part-set", detail = "Pick one or more", option = true) { setTimes = true }
            else OpenOption("At set times of day", 1, 2, "part-set", bottom = 8.dp, detail = "Pick one or more", gap = 0.dp) {
                timed.forEach { s ->
                    CheckRow(s.name, s.id in form.timesOfDay, 0, 1, "part-${s.id}", detail = FormOutcome.hours(s, store), indent = true, option = true) { form.choose(s.id) }
                }
                AddRow("New time of day", 0, 1, "new-time-of-day", indent = true, option = true, onClick = onNew)
            }
        }
    }
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
 * 5.7.8, **Reminders page** (Figma 1100:2996, Reminders Off · On · On, menu open · On, free plan; flows "Reminders:
 * turned on", "notifications not allowed", "on time, on some phones"; Components — Atoms Build Plan). From the form's
 * Reminders. On Surface container: the Top app bar (← "Reminders"); groups 24 apart, 16 at the sides and above, 40
 * under, each with its footer 8 under in Body Small On surface variant:
 *
 * - **Remind me**, off as every habit starts ("Reminders are off. Turning on Remind me asks Android once if Often
 *   Enough may send notifications."). Turning it on asks Android for notifications the first time (its own dialog);
 *   not allowed, it goes back off and says so ("… Turning Remind me on asks again."), and once Android won't ask
 *   again, Open settings (U37, U40).
 * - **Remind me at** (Label Large Primary): each time (schedule, the time in Body Large, ✕), and + Add a time
 *   (Android's time picker at now).
 * - **How**: Remind me with (A notification, "In your notifications" · An alarm, "Rings until you stop it") and If not
 *   done, remind again (Never, every 15 or 30 min or every hour; Plus, A73: on the free plan it carries the Plus label
 *   and opens Plus); "Not sent on a day it’s already done."
 * - **Reminder says (optional)** (chat_bubble): "Shown instead of the name when names are hidden outside the app."
 */
@Composable
fun RemindersPage(form: FormState, store: HabitStore, onBack: () -> Unit, onPlus: () -> Unit) {
    var editing by remember { mutableStateOf<String?>(null) }
    var adding by remember { mutableStateOf(false) }
    var refused by remember { mutableStateOf(false) }
    var canAskAgain by remember { mutableStateOf(false) }
    val context = androidx.compose.ui.platform.LocalContext.current
    val s = MaterialTheme.colorScheme
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
    @Composable fun Footer(text: String) = Text(text, Modifier.padding(horizontal = 16.dp).semantics { testTag = "reminders-footer" },
        style = AppType.bodySmall, color = s.onSurfaceVariant)
    @Composable fun Subheader(text: String) = Text(text, Modifier.padding(horizontal = 16.dp).semantics { heading() },
        style = AppType.labelLarge, color = s.primary)
    val bright = s.surfaceBright
    FormPage("Reminders", onBack = onBack) {
        Column(Modifier.padding(top = 16.dp, bottom = 16.dp), verticalArrangement = Arrangement.spacedBy(24.dp)) {
            Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                AppListItem("Remind me", 0, 1, trailing = { AppSwitch(form.remindOn) }, containerColor = bright, tag = "remind-me", onClick = {
                    val on = !form.remindOn
                    form.remindOn = on
                    if (on) refused = false
                    if (on && (form.times.isEmpty() || !form.remindersEdited)) form.syncReminders(force = true)
                    if (on) turnedOn()
                })
                if (!form.remindOn) {
                    if (refused && canAskAgain) Footer("Notifications are off for Often Enough, so reminders can’t come. Turning Remind me on asks again.")
                    else if (refused) {
                        Footer("Android won’t ask again. To get reminders, allow notifications for Often Enough in Settings.")
                        OpenSettingsButton(context)
                    } else Footer("Reminders are off. Turning on Remind me asks Android once if Often Enough may send notifications.")
                }
            }
            if (form.remindOn) {
                Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                    Subheader("Remind me at")
                    SegmentedList {
                        val count = form.times.size + 1
                        form.times.forEachIndexed { i, t ->
                            AppListItem(DayWords.clockMinute(t.minute), i, count, leading = { Icon(Symbols.Schedule, null) }, onClick = { editing = t.id },
                                containerColor = bright, headlineStyle = AppType.bodyLarge, tag = "reminder-$i", trailing = {
                                    StandardIconButton(Symbols.Close, "Remove the ${DayWords.clockMinute(t.minute)} reminder",
                                        { form.remindersEdited = true; form.times = form.times.filter { it.id != t.id } })
                                })
                        }
                        AppListItem("Add a time", form.times.size, count, leading = { Icon(Symbols.Add, null) }, onClick = { adding = true },
                            containerColor = bright, headlineStyle = AppType.bodyLarge, tag = "add-reminder")
                    }
                }
                if (form.times.isNotEmpty()) {
                    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                        Subheader("How")
                        SegmentedList {
                            val rows = if (form.type != ItemType.CUT_DOWN) 2 else 1
                            // An alarm rings on Android's alarm sound until it's answered; never a full screen (A11 D3).
                            val styles = listOf("notification" to "A notification", "alarm" to "An alarm")
                            MenuRow("Remind me with", styles.first { it.first == form.alert }.second, styles.map { it.second }, 0, rows, "remind-with",
                                listOf(Symbols.Notifications, Symbols.Alarm), listOf("In your notifications", "Rings until you stop it")) { form.alert = styles[it].first }
                            if (form.type != ItemType.CUT_DOWN) {
                                val options = listOf(null, 15, 30, 60)
                                // Remind again is Plus (A73): on the free plan the row opens Plus; one already set keeps working.
                                MenuRow("If not done, remind again", followWords(form.followUp), options.map { followWords(it) }, 1, rows, "follow-up",
                                    plus = !store.isPlus, onPlus = onPlus) { form.followUp = options[it] }
                            }
                        }
                        Footer("Not sent on a day it’s already done.")
                    }
                    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                        SegmentedList {
                            Segment(0, 1, color = bright) {
                                Icon(Symbols.ChatBubble, null, tint = s.onSurfaceVariant)
                                Spacer(Modifier.width(16.dp))
                                BasicTextField(form.reminderWords, { form.reminderWords = it.take(TextLimit.REMINDER_TEXT) },
                                    Modifier.weight(1f).semantics { testTag = "reminder-says"; contentDescription = "Reminder says" },
                                    textStyle = AppType.bodyLarge.copy(color = s.onSurface), singleLine = true, cursorBrush = SolidColor(s.primary),
                                    decorationBox = { inner -> Box { if (form.reminderWords.isEmpty()) Text("Reminder says (optional)", style = AppType.bodyLarge, color = s.onSurfaceVariant); inner() } })
                            }
                        }
                        Footer(TextLimit.note(form.reminderWords, TextLimit.REMINDER_TEXT) ?: "Shown instead of the name when names are hidden outside the app.")
                    }
                }
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
    // Add a time: Android's time picker, starting at now; OK adds it.
    if (adding) {
        val now = java.time.LocalTime.now()
        MinuteDialog(now.hour * 60 + now.minute, { adding = false }) { picked -> form.addReminderAt(picked) }
    }
}

/**
 * A row whose value opens a menu (Figma's Menu row): its title over the value, then ▾ (List item, 2.4), on Surface
 * bright. The menu marks the value chosen (Menu item, Selected), each choice with its [icons] and [lines] if it has them.
 * [plus]: a Plus feature on the free plan, the Plus label under the value, and a tap opens Plus instead (A73).
 */
@Composable
private fun MenuRow(
    title: String, value: String, options: List<String>, index: Int, count: Int, tag: String, icons: List<ImageVector>? = null,
    lines: List<String>? = null, plus: Boolean = false, onPlus: () -> Unit = {}, onPick: (Int) -> Unit,
) {
    var open by remember { mutableStateOf(false) }
    Box {
        AppListItem(title, index, count, Modifier.semantics(mergeDescendants = true) { contentDescription = "$title, $value" + if (plus) ", Plus" else "" }, value,
            trailing = { Icon(Symbols.ArrowDropDown, null) }, onClick = { if (plus) onPlus() else open = true },
            containerColor = MaterialTheme.colorScheme.surfaceBright, below = if (plus) ({ com.oftenenough.app.ui.components.PlusLabel(Modifier.padding(top = 4.dp)) }) else null, tag = tag)
        AppMenu(open, { open = false }, offset = DpOffset(96.dp, 0.dp)) {
            options.forEachIndexed { i, o -> AppMenuItem(o, { onPick(i); open = false }, icon = icons?.get(i), selected = o == value, supporting = lines?.get(i)) }
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
    FormPage("Icon", onBack = onBack, close = true, scrolls = false, actions = {
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

