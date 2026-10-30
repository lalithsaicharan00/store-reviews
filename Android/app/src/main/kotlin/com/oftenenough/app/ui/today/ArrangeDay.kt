package com.oftenenough.app.ui.today

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
fun ArrangeDayScreen(store: HabitStore, onEditSection: (String?) -> Unit, lifted: String? = null, onBack: () -> Unit) {
    val c = appColors
    val today = store.today()
    val cards = store.todayCards()
    val members = remember(store.dataVersion, store.habits, store.sections, store.cardOrder) {
        store.rules.cardMembers().mapValues { (_, ids) -> ids.mapNotNull { store.habit(it) }.filter { !store.isPaused(it, today) } }
    }
    // Paused habits sit last in their own time of day, said so, and don't move (Figma's Edit Today: "Paused").
    val paused = remember(store.dataVersion, store.habits, store.sections, store.cardOrder) {
        store.rules.cardMembers().mapValues { (_, ids) -> ids.mapNotNull { store.habit(it) }.filter { store.isPaused(it, today) } }
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
    LaunchedEffect(members, cards) { if (drag == null) rebuild() }
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
    var liftedNow by remember { mutableStateOf(lifted) }

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

    // Near the top or bottom of the screen a dragged row scrolls the page.
    LaunchedEffect(drag != null) {
        while (drag != null) {
            val finger = dragTop - scroll.value
            val edge = with(density) { 72.dp.toPx() }
            val speed = when {
                finger < edge -> -((edge - finger) / edge * 24f)
                finger + (heights[drag!!.key] ?: 0f) > viewport - edge -> ((finger + (heights[drag!!.key] ?: 0f) - viewport + edge) / edge * 24f)
                else -> 0f
            }
            if (speed != 0f) { val used = scroll.scrollBy(speed); dragTop += used; follow() }
            withFrameNanos { }
        }
    }
    // Arrange… on a row: that habit is brought into view, lifted.
    LaunchedEffect(lifted, tops.size) {
        val id = lifted ?: return@LaunchedEffect
        val key = entries.firstOrNull { it is ArrangeEntry.Row && it.habitId == id }?.key ?: return@LaunchedEffect
        val top = tops[key] ?: return@LaunchedEffect
        scroll.animateScrollTo(maxOf(0, (top - viewport / 3).roundToInt()))
        delay(1500); liftedNow = null
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
        Column(
            Modifier.fillMaxSize().padding(padding).onSizeChanged { viewport = it.height }.verticalScroll(scroll, enabled = drag == null)
                .padding(start = 16.dp, end = 16.dp, bottom = 40.dp),
        ) {
            entries.forEachIndexed { i, e ->
                // Keyed: as a dragged row moves, its composition (and its gesture) moves with it.
                key(e.key) { when (e) {
                    is ArrangeEntry.Header -> {
                        if (i > 0) Spacer(Modifier.height(16.dp))
                        ArrangeHeader(e, cards, store, Modifier.measured(e.key, tops, heights), onEdit = onEditSection)
                        Spacer(Modifier.height(8.dp))
                    }
                    is ArrangeEntry.Row -> {
                        val cardRows = cardAt(i)?.let { rowsOf(it) } ?: listOf(e)
                        val at = cardRows.indexOf(e)
                        val dragged = drag?.key == e.key
                        val h = store.habit(e.habitId) ?: return@forEachIndexed
                        if (at > 0) Spacer(Modifier.height(2.dp))
                        val all = cardRows.size + (paused[cardAt(i)] ?: emptyList()).size
                        ArrangeRow(
                            habit = h, shape = segmentShape(at, all), subtitle = arrangeSubtitle(h, store),
                            lifted = dragged || liftedNow == h.id,
                            modifier = Modifier.measured(e.key, tops, heights).zIndex(if (dragged) 1f else 0f)
                                .graphicsLayer { if (dragged) translationY = dragTop - (tops[e.key] ?: dragTop) },
                            onDragStart = { drag = e; dragFrom = cardAt(entries.indexOf(e)); dragTop = tops[e.key] ?: 0f; liftedNow = null; menuFor = null },
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
                // The end of a time of day: its paused habits, last; after the last timed one, Add time of day.
                if (entries.getOrNull(i + 1) !is ArrangeEntry.Row) {
                    val card = cardAt(i)
                    val held = paused[card] ?: emptyList()
                    val moving = rowsOf(card ?: "").size
                    held.forEachIndexed { j, h ->
                        Spacer(Modifier.height(2.dp))
                        ArrangeRow(h, segmentShape(moving + j, moving + held.size), "Paused", lifted = false, modifier = Modifier,
                            onDragStart = null, onDrag = {}, onDragEnd = {}, onTap = null, menuOpen = false, onMenuDismiss = {},
                            canUp = false, canDown = false, onUp = {}, onDown = {}, onMoveTo = null)
                    }
                    if (card == lastTimed) {
                        Spacer(Modifier.height(16.dp))
                        AppButton("Add time of day", { onEditSection(null) }, style = ButtonStyle.Tonal, icon = Symbols.Add, tag = "arrange-add-time")
                    }
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

/** Remembers where an item sits in the list (its layout, before any drag offset). */
private fun Modifier.measured(key: String, tops: MutableMap<String, Float>, heights: MutableMap<String, Float>): Modifier =
    onGloballyPositioned { tops[key] = it.positionInParent().y; heights[key] = it.size.height.toFloat() }

/** "Mon, Wed, Fri": how often, under the name, only when it isn't every day (Figma 2). */
private fun arrangeSubtitle(h: Habit, store: HabitStore): String? =
    if (h.kind == com.oftenenough.app.data.HabitKind.Task || h.frequency == com.oftenenough.app.data.Frequency.Daily) null
    else com.oftenenough.app.data.HabitCopy.capitalized(com.oftenenough.app.data.HabitCopy.rhythm(h.frequency, store.weekStart, short = true))

/**
 * A time of day's heading (Figma's Edit Today: 48 tall, 16 in): "Morning · 6 AM – 12 PM" in Label Large, Primary, a
 * heading; a timed one ends in ✏ (an Icon button: Edit time of day); Anytime and Quitting end in their drag handle and
 * move as a whole, a row's height a place (TalkBack: Move up, Move down).
 */
@Composable
private fun ArrangeHeader(e: ArrangeEntry.Header, cards: List<String>, store: HabitStore, modifier: Modifier, onEdit: (String?) -> Unit) {
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
            // The handle moves the whole time of day: one place up or down per row's height dragged.
            var dy by remember { mutableFloatStateOf(0f) }
            val step = with(LocalDensity.current) { 64.dp.toPx() }
            val i = cards.indexOf(card)
            Box(Modifier.size(48.dp).pointerInput(card) {
                detectVerticalDragGestures(onDragEnd = { dy = 0f }, onDragCancel = { dy = 0f }) { change, amount ->
                    change.consume(); dy += amount
                    if (dy <= -step) { store.moveCard(card, HabitStore.CardMove.UP); dy = 0f }
                    if (dy >= step) { store.moveCard(card, HabitStore.CardMove.DOWN); dy = 0f }
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
                .heightIn(min = 56.dp).padding(start = 16.dp, end = if (onDragStart != null) 4.dp else 16.dp, top = 8.dp, bottom = 8.dp)
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
            ListAvatar(HabitIcons.icon(habit.symbol))
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
