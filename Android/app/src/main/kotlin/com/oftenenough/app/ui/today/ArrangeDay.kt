package com.oftenenough.app.ui.today

import androidx.compose.ui.draw.drawBehind
import androidx.compose.ui.semantics.clearAndSetSemantics
import androidx.compose.ui.unit.IntOffset
import androidx.compose.ui.graphics.drawOutline
import androidx.compose.ui.graphics.drawscope.translate
import com.oftenenough.app.ui.components.StandardIconButton
import com.oftenenough.app.ui.components.ListAvatar
import androidx.compose.material3.MaterialTheme
import com.oftenenough.app.ui.components.AppSnackbarHost
import com.oftenenough.app.ui.components.AppMenuItem
import androidx.compose.ui.unit.DpOffset
import com.oftenenough.app.ui.components.AppMenu
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.NavigationIcon
import com.oftenenough.app.ui.components.AppTopBar
import androidx.compose.foundation.background
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.gestures.scrollBy
import androidx.compose.foundation.clickable
import androidx.compose.foundation.gestures.detectDragGesturesAfterLongPress
import androidx.compose.foundation.gestures.detectVerticalDragGestures
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.RadioButton
import androidx.compose.material3.Scaffold
import androidx.compose.material3.SnackbarDuration
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.SnackbarResult
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.key
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateMapOf
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.withFrameNanos
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.layout.onGloballyPositioned
import androidx.compose.ui.layout.onSizeChanged
import androidx.compose.ui.layout.positionInParent
import androidx.compose.ui.semantics.contentDescription
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.HabitIcons
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import androidx.compose.foundation.gestures.detectDragGestures
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableFloatStateOf
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.semantics.CustomAccessibilityAction
import androidx.compose.ui.semantics.customActions
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.zIndex
import com.oftenenough.app.data.DaySection
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.components.segmentShape
import com.oftenenough.app.ui.theme.appColors
import kotlin.math.roundToInt

/** [list] with the item at [from] moved to [to]. */
fun <T> List<T>.moved(from: Int, to: Int): List<T> {
    if (from !in indices || to !in indices || from == to) return this
    return toMutableList().also { it.add(to, it.removeAt(from)) }
}

/**
 * Edit Today (5.2.3, Figma 827:39487; from ✏ on Today, Arrange… in a row's menu, or a new habit's Move). Every habit in
 * each time of day, not only today's, in the person's order (U13). Drag ≡ (or hold a row) to change the order, or into
 * another time of day: the row follows the finger and the others make room; it's saved when the finger lifts (S7), and
 * a move to another time of day says where it went, with Undo. Tap a habit for Move up, Move down and Move to…. A timed
 * time of day's ✏ edits it; Anytime and Quitting move as a whole by their handle. Paused habits are last in their time
 * of day and don't move. Add time of day follows the timed ones. Moving a habit to another time of day changes only
 * where Today shows it: its reminders don't change. Nothing here logs.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ArrangeDayScreen(store: HabitStore, onEditSection: (String?) -> Unit, onBack: () -> Unit) {
    val c = appColors
    val outline = MaterialTheme.colorScheme.outline
    val today = store.today()
    val cards = store.todayCards()
    // A paused habit is a row like any other, "Paused" under its name, and moves like the rest (Figma's Edit Today:
    // Meditate in Morning, with its handle).
    val members = remember(store.dataVersion, store.habits, store.sections, store.cardOrder) {
        store.rules.cardMembers().mapValues { (_, ids) -> ids.mapNotNull { store.habit(it) } }
    }
    val lastTimed = cards.lastOrNull { it != DaySection.QUITTING && !store.section(it).isAnytime }
    val snackbar = remember { SnackbarHostState() }
    val scope = rememberCoroutineScope()
    val scroll = rememberScrollState()
    val density = LocalDensity.current

    // The list as drawn: each card's header, then its rows. While a row is dragged this local copy changes, so the rows
    // make room as it passes; the store changes only when it's dropped.
    val entries = remember { mutableStateListOf<ArrangeEntry>() }
    var drag by remember { mutableStateOf<ArrangeEntry.Row?>(null) }
    var dragFrom by remember { mutableStateOf<String?>(null) }
    fun rebuild() {
        entries.clear()
        for (card in cards) {
            val list = members[card] ?: emptyList()
            if (card == DaySection.QUITTING && list.isEmpty()) continue
            entries.add(ArrangeEntry.Header(card))
            list.forEach { entries.add(ArrangeEntry.Row(it.id, card)) }
        }
    }
    // Anytime or Quitting carried by its handle: the whole card (heading and rows) lifts and follows the finger.
    var held by remember { mutableStateOf<String?>(null) }
    LaunchedEffect(members, cards) { if (drag == null && held == null) rebuild() }
    if (entries.isEmpty() && members.isNotEmpty()) rebuild()

    /** The card the item at [index] is in: the header above it. */
    fun cardAt(index: Int): String? = (index downTo 0).firstNotNullOfOrNull { (entries.getOrNull(it) as? ArrangeEntry.Header)?.card }
    /** A card's rows, in the list's order. */
    fun rowsOf(card: String): List<ArrangeEntry.Row> {
        val from = entries.indexOfFirst { it is ArrangeEntry.Header && it.card == card }
        if (from < 0) return emptyList()
        return entries.drop(from + 1).takeWhile { it is ArrangeEntry.Row }.map { it as ArrangeEntry.Row }
    }
    val tops = remember { mutableStateMapOf<String, Float>() }
    val heights = remember { mutableStateMapOf<String, Float>() }
    var dragTop by remember { mutableFloatStateOf(0f) }
    var viewport by remember { mutableIntStateOf(0) }
    var menuFor by remember { mutableStateOf<String?>(null) }
    var moving by remember { mutableStateOf<Habit?>(null) }

    // Where a habit may go: a quit habit or a limit stays in Quitting, every other one stays out of it.
    fun accepts(card: String, habitId: String): Boolean {
        val h = store.habit(habitId) ?: return false
        return (card == DaySection.QUITTING) == h.isQuitOrLimit
    }

    /** Moves the dragged row past its neighbour once its middle crosses the neighbour's middle; into the next card too. */
    fun follow() {
        val d = drag ?: return
        while (true) {
            val i = entries.indexOf(d).takeIf { it >= 0 } ?: return
            val h = heights[d.key] ?: return
            val mid = dragTop + h / 2
            val next = entries.getOrNull(i + 1)
            val prev = entries.getOrNull(i - 1)
            fun crossed(e: ArrangeEntry, down: Boolean): Boolean {
                val t = tops[e.key] ?: return false
                val m = t + (heights[e.key] ?: 0f) / 2
                return if (down) mid > m else mid < m
            }
            fun taken(card: String) = rowsOf(card).any { it != d && it.habitId == d.habitId }
            if (next != null && crossed(next, down = true)) {
                if (next is ArrangeEntry.Header && (!accepts(next.card, d.habitId) || taken(next.card))) return
                // Past a row: swap. Past the next card's header: first in that card.
                entries.removeAt(i); entries.add(i + 1, d); continue
            }
            if (prev != null && crossed(prev, down = false)) {
                if (prev is ArrangeEntry.Header) {
                    // Into the end of the card above, when there is one that takes it.
                    val above = cardAt(i - 2) ?: return
                    if (!accepts(above, d.habitId) || taken(above)) return
                }
                entries.removeAt(i); entries.add(i - 1, d); continue
            }
            return
        }
    }

    // A carried card: where its top is now, its height, and where it was among the cards when lifted.
    var heldTop by remember { mutableFloatStateOf(0f) }
    var heldHeight by remember { mutableFloatStateOf(0f) }
    /** Where a card's heading starts and its last row ends, in the list. */
    fun span(card: String): Pair<Float, Float>? {
        val top = tops["h-$card"] ?: return null
        val last = rowsOf(card).lastOrNull()?.key ?: "h-$card"
        return top to (tops[last] ?: return null) + (heights[last] ?: 0f)
    }
    /** Moves a card's heading and rows together in the list. */
    fun moveBlock(card: String, before: String?) {
        val from = entries.indexOfFirst { it is ArrangeEntry.Header && it.card == card }
        val block = listOf(entries[from]) + rowsOf(card)
        entries.removeAll(block)
        val at = before?.let { b -> entries.indexOfFirst { it is ArrangeEntry.Header && it.card == b } } ?: entries.size
        entries.addAll(at, block)
    }
    // After a card moves, the list's positions are old until it's laid out again: wait for that before the next move.
    val laidOut = remember { booleanArrayOf(true) }
    /**
     * Moves the carried card past the card next to it once its leading edge crosses that card's middle (its top going
     * up, its bottom going down): cards are tall, and a middle-to-middle rule couldn't pass a card already at the top.
     */
    fun followCard() {
        val card = held ?: return
        if (!laidOut[0]) return
        val order = entries.filterIsInstance<ArrangeEntry.Header>().map { it.card }
        val i = order.indexOf(card)
        fun middle(other: String) = span(other)?.let { (a, b) -> (a + b) / 2 }
        val next = order.getOrNull(i + 1)
        val prev = order.getOrNull(i - 1)
        if (next != null && middle(next)?.let { heldTop + heldHeight > it } == true) { laidOut[0] = false; moveBlock(card, order.getOrNull(i + 2)) }
        else if (prev != null && middle(prev)?.let { heldTop < it } == true) { laidOut[0] = false; moveBlock(card, prev) }
    }
    /** Saves where a carried card was dropped, and says so with Undo ("Anytime moved to the top", Figma 62:2). */
    fun dropCard(card: String) {
        val order = entries.filterIsInstance<ArrangeEntry.Header>().map { it.card }
        val at = order.indexOf(card)
        val was = store.todayCards().indexOf(card)
        val others = store.todayCards().filter { it != card }
        val to = order.getOrNull(at + 1)?.let { others.indexOf(it) } ?: others.size
        if (to == was) return
        store.placeCard(card, to)
        fun name(id: String) = if (id == DaySection.QUITTING) "Quitting" else store.section(id).name
        val where = when (at) { 0 -> "to the top"; order.size - 1 -> "to the bottom"; else -> "after ${name(order[at - 1])}" }
        scope.launch {
            val r = snackbar.showSnackbar("${name(card)} moved $where", actionLabel = "Undo", duration = SnackbarDuration.Short)
            if (r == SnackbarResult.ActionPerformed) store.placeCard(card, was)
        }
    }

    /** Saves what the list shows: each card's order, and the dragged habit's new time of day (its reminders stay). */
    fun commit(row: ArrangeEntry.Row, fromCard: String) {
        val before = store.habits.map { it.id }
        val old = store.habit(row.habitId) ?: return
        val toCard = cardAt(entries.indexOf(row)) ?: return
        if (fromCard != toCard) {
            val parts = (old.parts.filter { it != fromCard } + toCard).distinct()
            store.update(old.copy(parts = parts))
        }
        store.reorder(rowsOf(toCard).map { it.habitId })
        if (fromCard != toCard) {
            val where = if (toCard == DaySection.QUITTING) "Quitting" else store.section(toCard).name
            scope.launch {
                val r = snackbar.showSnackbar("${old.name} moved to $where", actionLabel = "Undo", duration = SnackbarDuration.Short)
                if (r == SnackbarResult.ActionPerformed) { store.update(old); store.reorder(before) }
            }
        }
    }

    // Near the top or bottom of the screen a dragged row, or a carried card, scrolls the page.
    LaunchedEffect(drag != null || held != null) {
        while (drag != null || held != null) {
            val card = held != null
            val top = if (card) heldTop else dragTop
            val tall = if (card) heldHeight else drag?.let { heights[it.key] } ?: 0f
            val finger = top - scroll.value
            val edge = with(density) { 72.dp.toPx() }
            val speed = when {
                finger < edge -> -((edge - finger) / edge * 24f)
                finger + tall > viewport - edge -> ((finger + tall - viewport + edge) / edge * 24f)
                else -> 0f
            }
            if (speed != 0f) {
                val used = scroll.scrollBy(speed)
                if (card) { heldTop += used; followCard() } else { dragTop += used; follow() }
            }
            withFrameNanos { }
        }
    }

    Scaffold(
        containerColor = c.screen,
        topBar = {
            AppTopBar("Edit Today", Modifier.semantics { heading() }, navigationIcon = {
                NavigationIcon(Symbols.ArrowBack, "Back", onBack, Modifier.semantics { testTag = "arrange-back" })
            })
        },
        snackbarHost = { AppSnackbarHost(snackbar) },
    ) { padding ->
        Box(Modifier.fillMaxSize().padding(padding)) {
        Column(
            Modifier.fillMaxSize().onSizeChanged { viewport = it.height }.verticalScroll(scroll, enabled = drag == null && held == null)
                .padding(start = 16.dp, end = 16.dp, bottom = 40.dp),
        ) {
            entries.forEachIndexed { i, e ->
                // A carried card keeps its place here, unseen (its handle's gesture lives here), and moves as it passes others.
                val unseen = held != null && cardAt(i) == held
                // Keyed: as a dragged row moves, its composition (and its gesture) moves with it.
                key(e.key) { when (e) {
                    is ArrangeEntry.Header -> {
                        if (i > 0) Spacer(Modifier.height(16.dp))
                        ArrangeHeader(e, cards, store, Modifier.measured(e.key, tops, heights).graphicsLayer { if (unseen) alpha = 0f }
                            .onGloballyPositioned { if (unseen) laidOut[0] = true },
                            onEdit = onEditSection,
                            onLift = { held = e.card; menuFor = null; laidOut[0] = true; heldTop = tops[e.key] ?: 0f; heldHeight = span(e.card)?.let { (a, b) -> b - a } ?: 0f },
                            onCarry = { dy -> heldTop += dy; followCard() },
                            onDrop = { val card = held; held = null; if (card != null) dropCard(card) })
                        Spacer(Modifier.height(8.dp))
                    }
                    is ArrangeEntry.Row -> {
                        val cardRows = cardAt(i)?.let { rowsOf(it) } ?: listOf(e)
                        val at = cardRows.indexOf(e)
                        val dragged = drag?.key == e.key
                        val h = store.habit(e.habitId) ?: return@forEachIndexed
                        if (at > 0) Spacer(Modifier.height(2.dp))
                        val all = cardRows.size
                        ArrangeRow(
                            habit = h, shape = segmentShape(at, all), subtitle = if (store.isPaused(h, today)) "Paused" else arrangeSubtitle(h, store),
                            lifted = dragged,
                            modifier = Modifier.measured(e.key, tops, heights).zIndex(if (dragged) 1f else 0f).graphicsLayer { if (unseen) alpha = 0f }
                                // Where it will land while it's carried: a dashed outline in the row's place (Figma's Edit
                                // Today, "Drop here": Outline, 1 dp, 6 on 4 off), drawn before the layer that moves the row.
                                .then(if (dragged) Modifier.dropSlot(segmentShape(at, all), outline) else Modifier)
                                .graphicsLayer { if (dragged) translationY = dragTop - (tops[e.key] ?: dragTop) },
                            onDragStart = { drag = e; dragFrom = cardAt(entries.indexOf(e)); dragTop = tops[e.key] ?: 0f; menuFor = null },
                            onDrag = { dy -> dragTop += dy; follow() },
                            onDragEnd = { val d = drag; val from = dragFrom; drag = null; dragFrom = null; if (d != null && from != null) commit(d, from) },
                            onTap = { menuFor = e.key },
                            menuOpen = menuFor == e.key, onMenuDismiss = { menuFor = null },
                            canUp = at > 0, canDown = at < cardRows.size - 1,
                            onUp = { menuFor = null; store.reorder(cardRows.map { it.habitId }.moved(at, at - 1)) },
                            onDown = { menuFor = null; store.reorder(cardRows.map { it.habitId }.moved(at, at + 1)) },
                            onMoveTo = if (h.isQuitOrLimit) null else ({ menuFor = null; moving = h }),
                        )
                    }
                } }
                // An empty time of day: "Drag a habit here" in a dashed box (Figma's Edit Today, a new Night); after the last
                // timed one, Add time of day.
                if (entries.getOrNull(i + 1) !is ArrangeEntry.Row) {
                    val card = cardAt(i)
                    if (e is ArrangeEntry.Header) EmptyCard(Modifier.graphicsLayer { if (unseen) alpha = 0f }.semantics { testTag = "arrange-empty-${e.card}" })
                    if (card == lastTimed) {
                        Spacer(Modifier.height(16.dp))
                        AppButton("Add time of day", { onEditSection(null) }, style = ButtonStyle.Tonal, icon = Symbols.Add, tag = "arrange-add-time")
                    }
                }
            }
        }
        // The carried card over the list, where the finger has it (Figma 62:2, "Anytime · held"): its heading and rows on
        // the page's colour, corners 24, Elevation Level 3; under it, a dashed outline where it will land.
        held?.let { card ->
            val slot = span(card)
            val shape = RoundedCornerShape(24.dp)
            if (slot != null) Box(Modifier.padding(horizontal = 16.dp).offset { IntOffset(0, (slot.first - scroll.value).roundToInt()) }.fillMaxWidth()
                .height(with(density) { (slot.second - slot.first).toDp() }).dropSlot(shape, outline))
            Column(Modifier.padding(horizontal = 16.dp).offset { IntOffset(0, (heldTop - scroll.value).roundToInt()) }.fillMaxWidth()
                .shadow(6.dp, shape).background(c.screen, shape).clearAndSetSemantics { }) {
                ArrangeHeader(ArrangeEntry.Header(card), cards, store, Modifier, onEdit = {}, onLift = {}, onCarry = {}, onDrop = {})
                Spacer(Modifier.height(8.dp))
                val rows = rowsOf(card)
                rows.forEachIndexed { at, r ->
                    val h = store.habit(r.habitId) ?: return@forEachIndexed
                    if (at > 0) Spacer(Modifier.height(2.dp))
                    ArrangeRow(h, segmentShape(at, rows.size), if (store.isPaused(h, today)) "Paused" else arrangeSubtitle(h, store), lifted = false,
                        modifier = Modifier, onDragStart = {}, onDrag = {}, onDragEnd = {}, onTap = null, menuOpen = false, onMenuDismiss = {},
                        canUp = false, canDown = false, onUp = {}, onDown = {}, onMoveTo = null)
                }
                if (rows.isEmpty()) EmptyCard(Modifier)
            }
        }
        }
    }
    moving?.let { h -> MoveToDialog(h, cards.filter { it != DaySection.QUITTING }, store, onDismiss = { moving = null }) { to ->
        moving = null
        val from = store.placements(h).firstOrNull()?.section ?: DaySection.ANYTIME
        if (to == from) return@MoveToDialog
        val before = store.habits.map { it.id }
        store.update(h.copy(parts = (h.parts.filter { it != from } + to).distinct()))
        // It goes to the end of that time of day (Figma 2.3).
        store.reorder((members[to] ?: emptyList()).map { it.id } + h.id)
        val where = store.section(to).name
        scope.launch {
            val r = snackbar.showSnackbar("${h.name} moved to $where", actionLabel = "Undo", duration = SnackbarDuration.Short)
            if (r == SnackbarResult.ActionPerformed) { store.update(h); store.reorder(before) }
        }
    } }
}

/** One item of Arrange Today's list: a card's header, or a habit in a card. */
sealed class ArrangeEntry {
    abstract val key: String
    data class Header(val card: String) : ArrangeEntry() { override val key get() = "h-$card" }
    /** [home]: the card it was in when the list was built (part of its key, so a habit in two cards has two keys). */
    data class Row(val habitId: String, val home: String) : ArrangeEntry() { override val key get() = "r-$habitId-$home" }
}

/** An empty time of day: "Drag a habit here" in a dashed box (Figma's Edit Today, a new Night). */
@Composable
private fun EmptyCard(modifier: Modifier) {
    Box(modifier.fillMaxWidth().heightIn(min = 56.dp).dropSlot(RoundedCornerShape(24.dp), MaterialTheme.colorScheme.outline),
        contentAlignment = Alignment.Center) {
        Text("Drag a habit here", Modifier.padding(horizontal = 16.dp, vertical = 8.dp), style = AppType.bodyMedium,
            color = MaterialTheme.colorScheme.onSurfaceVariant, textAlign = androidx.compose.ui.text.style.TextAlign.Center)
    }
}

/** Remembers where an item sits in the list (its layout, before any drag offset). */
private fun Modifier.measured(key: String, tops: MutableMap<String, Float>, heights: MutableMap<String, Float>): Modifier =
    onGloballyPositioned { tops[key] = it.positionInParent().y; heights[key] = it.size.height.toFloat() }

/** "Mon, Wed, Fri": how often, under the name, only when it isn't every day (Figma 2). */
/** A dashed outline of [shape] where a carried row will land. */
private fun Modifier.dropSlot(shape: androidx.compose.ui.graphics.Shape, color: androidx.compose.ui.graphics.Color) = drawBehind {
    val w = 1.dp.toPx()
    val outline = shape.createOutline(size.copy(width = size.width - w, height = size.height - w), layoutDirection, this)
    translate(w / 2, w / 2) {
        drawOutline(outline, color, style = androidx.compose.ui.graphics.drawscope.Stroke(w,
            pathEffect = androidx.compose.ui.graphics.PathEffect.dashPathEffect(floatArrayOf(6.dp.toPx(), 4.dp.toPx()))))
    }
}

private fun arrangeSubtitle(h: Habit, store: HabitStore): String? {
    if (h.kind == com.oftenenough.app.data.HabitKind.Task || h.frequency == com.oftenenough.app.data.Frequency.Daily) return null
    // "Mon, Wed, Fri"; a count for its period by its plan, "3 times a week" (Figma's Edit Today).
    val words = com.oftenenough.app.data.HabitCopy.rhythm(h.frequency, store.weekStart, short = true)
        .ifEmpty { com.oftenenough.app.data.HabitCopy.plan(h, store.weekStart) }
    return words.takeIf { it.isNotEmpty() }?.let(com.oftenenough.app.data.HabitCopy::capitalized)
}

/**
 * A time of day's heading (Figma's Edit Today: 48 tall, 16 in): "Morning · 6 AM – 12 PM" in Label Large, Primary, a
 * heading; a timed one ends in ✏ (an Icon button: Edit time of day); Anytime and Quitting end in their drag handle and
 * move as a whole, a row's height a place (TalkBack: Move up, Move down).
 */
@Composable
private fun ArrangeHeader(
    e: ArrangeEntry.Header, cards: List<String>, store: HabitStore, modifier: Modifier, onEdit: (String?) -> Unit,
    onLift: () -> Unit, onCarry: (Float) -> Unit, onDrop: () -> Unit,
) {
    val s = MaterialTheme.colorScheme
    val card = e.card
    val section = if (card == DaySection.QUITTING) null else store.section(card)
    val title = when {
        card == DaySection.QUITTING -> "Quitting"
        section == null || section.isAnytime -> section?.name ?: "Anytime"
        else -> {
            val end = store.timedSections().firstOrNull { it.first.id == card }?.second
            section.name + " · " + DayWords.hourShort(section.start ?: 0) + (end?.let { " – " + DayWords.hourShort(it % (24 * 60)) } ?: "")
        }
    }
    val movable = card == DaySection.ANYTIME || card == DaySection.QUITTING
    Row(modifier.fillMaxWidth().heightIn(min = 48.dp).padding(start = 16.dp).semantics { testTag = "arrange-card-$title" },
        verticalAlignment = Alignment.CenterVertically) {
        Text(title, Modifier.weight(1f).semantics { heading() }, style = AppType.labelLarge, color = s.primary, maxLines = 1, overflow = TextOverflow.Ellipsis)
        if (section != null && !section.isAnytime) {
            StandardIconButton(Symbols.Edit, "Edit $title", { onEdit(section.id) }, Modifier.semantics { testTag = "arrange-edit-$title" })
        }
        if (movable) {
            // The handle carries the whole time of day: it lifts and follows the finger, and is saved where it's let go.
            val i = cards.indexOf(card)
            Box(Modifier.size(48.dp).pointerInput(card) {
                detectVerticalDragGestures(onDragStart = { onLift() }, onDragEnd = onDrop, onDragCancel = onDrop) { change, amount ->
                    change.consume(); onCarry(amount)
                }
            }.semantics {
                testTag = "arrange-card-handle-$title"; contentDescription = "Move $title"
                customActions = listOfNotNull(
                    if (i > 0) CustomAccessibilityAction("Move up") { store.moveCard(card, HabitStore.CardMove.UP); true } else null,
                    if (i < cards.size - 1) CustomAccessibilityAction("Move down") { store.moveCard(card, HabitStore.CardMove.DOWN); true } else null,
                )
            }, contentAlignment = Alignment.Center) {
                Icon(Symbols.DragHandle, null, tint = s.onSurfaceVariant)
            }
        }
    }
}

/**
 * A habit in Edit Today (Figma's List item, one or two lines, trailing drag_handle as Android's own Languages page): its
 * icon in a 40 dp Surface container highest avatar, 16, the name in Title Medium On surface over how often (or Paused)
 * in Body Medium On surface variant, ≡ at the end; Surface bright. Drag ≡ or hold the row to move it; tap it for Move
 * up, Move down and Move to…. Lifted: a shadow.
 */
@OptIn(ExperimentalFoundationApi::class)
@Composable
private fun ArrangeRow(
    habit: Habit, shape: androidx.compose.ui.graphics.Shape, subtitle: String?, lifted: Boolean, modifier: Modifier,
    onDragStart: (() -> Unit)?, onDrag: (Float) -> Unit, onDragEnd: () -> Unit, onTap: (() -> Unit)?,
    menuOpen: Boolean, onMenuDismiss: () -> Unit, canUp: Boolean, canDown: Boolean, onUp: () -> Unit, onDown: () -> Unit,
    onMoveTo: (() -> Unit)?,
) {
    val c = appColors
    val drag = Modifier.pointerInput(habit.id, onDragStart != null) {
        if (onDragStart == null) return@pointerInput
        detectDragGestures(onDragStart = { onDragStart() }, onDragEnd = onDragEnd, onDragCancel = onDragEnd) { change, amount -> change.consume(); onDrag(amount.y) }
    }
    val hold = Modifier.pointerInput(habit.id, onDragStart != null) {
        if (onDragStart == null) return@pointerInput
        detectDragGesturesAfterLongPress(onDragStart = { onDragStart() }, onDragEnd = onDragEnd, onDragCancel = onDragEnd) { change, amount -> change.consume(); onDrag(amount.y) }
    }
    Box(modifier) {
        Row(
            Modifier.fillMaxWidth().let { if (lifted) it.shadow(8.dp, RoundedCornerShape(24.dp)) else it }
                .clip(if (lifted) RoundedCornerShape(24.dp) else shape).background(if (menuOpen) c.behind else MaterialTheme.colorScheme.surfaceBright)
                .then(hold).let { if (onTap != null) it.clickable(onClick = onTap) else it }
                // Figma's List item: 56 for one line, 72 for two. The handle keeps its 48 dp touch target, 4 past the
                // 40 avatar above and below, so the row's padding is 4 less there and its height lands where Figma's does.
                .heightIn(min = if (subtitle != null) 72.dp else 56.dp)
                .padding(start = 16.dp, end = if (onDragStart != null) 4.dp else 16.dp, top = if (onDragStart != null) 4.dp else 8.dp, bottom = if (onDragStart != null) 4.dp else 8.dp)
                .semantics(mergeDescendants = true) {
                    testTag = "arrange-row-${habit.name}"
                    customActions = listOfNotNull(
                        if (canUp) CustomAccessibilityAction("Move up") { onUp(); true } else null,
                        if (canDown) CustomAccessibilityAction("Move down") { onDown(); true } else null,
                        onMoveTo?.let { CustomAccessibilityAction("Move to…") { it(); true } },
                    )
                },
            verticalAlignment = Alignment.CenterVertically,
        ) {
            // The list's avatar: the habit's icon outlined (Figma's List item, Material Symbols fill 0), as the icon picker draws it.
            ListAvatar(HabitIcons.outlined(habit.symbol))
            Spacer(Modifier.width(16.dp))
            Column(Modifier.weight(1f)) {
                Text(habit.name, style = AppType.titleMedium, color = MaterialTheme.colorScheme.onSurface, maxLines = 2, overflow = TextOverflow.Ellipsis)
                if (subtitle != null) Text(subtitle, style = AppType.bodyMedium, color = MaterialTheme.colorScheme.onSurfaceVariant, maxLines = 1)
            }
            if (onDragStart != null) Box(Modifier.size(48.dp).then(drag).semantics { testTag = "arrange-handle-${habit.name}"; contentDescription = "Drag to move" },
                contentAlignment = Alignment.Center) {
                Icon(Symbols.DragHandle, null, tint = if (lifted) MaterialTheme.colorScheme.onSurface else MaterialTheme.colorScheme.onSurfaceVariant)
            }
        }
        AppMenu(menuOpen, onMenuDismiss, offset = DpOffset(120.dp, 0.dp)) {
            @Composable fun item(text: String, icon: androidx.compose.ui.graphics.vector.ImageVector, tag: String, enabled: Boolean = true, action: () -> Unit) =
                AppMenuItem(text, action, icon = icon, enabled = enabled, tag = tag)
            item("Move up", Symbols.ArrowUpward, "arrange-move-up", canUp, onUp)
            item("Move down", Symbols.ArrowDownward, "arrange-move-down", canDown, onDown)
            if (onMoveTo != null) item("Move to…", Symbols.Schedule, "arrange-move-to") { onMoveTo() }
        }
    }
}

/** Move to… (Figma 2.3): the times of day as radio rows, the one it's in now said so; Move puts it at that one's end. */
@Composable
private fun MoveToDialog(habit: Habit, cards: List<String>, store: HabitStore, onDismiss: () -> Unit, onMove: (String) -> Unit) {
    val c = appColors
    val now = store.placements(habit).firstOrNull()?.section ?: DaySection.ANYTIME
    var chosen by remember { mutableStateOf(now) }
    AlertDialog(
        onDismissRequest = onDismiss,
        title = {
            Column(Modifier.fillMaxWidth()) {
                Icon(Symbols.Schedule, null, tint = c.ink)
                Spacer(Modifier.height(16.dp))
                Text("Move ${habit.name} to", style = AppType.headlineSmall, color = c.ink)
            }
        },
        text = {
            Column {
                for (card in cards) {
                    val name = store.section(card).name
                    Row(Modifier.fillMaxWidth().heightIn(min = 48.dp).clip(RoundedCornerShape(8.dp)).clickable { chosen = card }
                        .semantics(mergeDescendants = true) { testTag = "move-to-$name" }, verticalAlignment = Alignment.CenterVertically) {
                        RadioButton(chosen == card, { chosen = card })
                        Spacer(Modifier.width(8.dp))
                        Text(if (card == now) "$name (where it is now)" else name, style = AppType.bodyLarge, color = c.ink)
                    }
                }
            }
        },
        confirmButton = { AppButton("Move", { onMove(chosen) }, Modifier.semantics { testTag = "move-to-confirm" }, style = ButtonStyle.Text) },
        dismissButton = { AppButton("Cancel", onDismiss, style = ButtonStyle.Text) },
        containerColor = c.menu,
    )
}
