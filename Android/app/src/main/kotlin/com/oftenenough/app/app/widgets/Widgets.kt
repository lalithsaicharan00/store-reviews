package com.oftenenough.app.app.widgets

import android.content.Context
import android.content.Intent
import android.content.res.Configuration
import android.os.SystemClock
import android.util.TypedValue
import android.widget.RemoteViews
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.TextUnit
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.longPreferencesKey
import androidx.glance.ColorFilter
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.Image
import androidx.glance.ImageProvider
import androidx.glance.LocalContext
import androidx.glance.LocalSize
import androidx.glance.action.ActionParameters
import androidx.glance.action.actionParametersOf
import androidx.glance.action.clickable
import androidx.glance.appwidget.AndroidRemoteViews
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.GlanceAppWidgetManager
import androidx.glance.appwidget.GlanceAppWidgetReceiver
import androidx.glance.appwidget.LinearProgressIndicator
import androidx.glance.appwidget.SizeMode
import androidx.glance.appwidget.action.actionRunCallback
import androidx.glance.appwidget.action.actionStartActivity
import androidx.glance.appwidget.cornerRadius
import androidx.glance.appwidget.provideContent
import androidx.glance.background
import androidx.glance.color.ColorProvider
import androidx.glance.unit.ColorProvider
import androidx.glance.currentState
import androidx.glance.layout.Alignment
import androidx.glance.layout.Box
import androidx.glance.layout.Column
import androidx.glance.layout.Row
import androidx.glance.layout.Spacer
import androidx.glance.layout.fillMaxHeight
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.fillMaxWidth
import androidx.glance.layout.height
import androidx.glance.layout.padding
import androidx.glance.layout.size
import androidx.glance.layout.width
import androidx.glance.semantics.contentDescription
import androidx.glance.semantics.semantics
import androidx.glance.state.PreferencesGlanceStateDefinition
import androidx.glance.text.FontWeight
import androidx.glance.text.Text
import androidx.glance.text.TextAlign
import androidx.glance.text.TextStyle
import com.oftenenough.app.R
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.widgets.WidgetAction
import com.oftenenough.app.data.widgets.WidgetCell
import com.oftenenough.app.data.widgets.WidgetFrame
import com.oftenenough.app.data.widgets.WidgetItem
import com.oftenenough.app.data.widgets.WidgetSnapshot
import com.oftenenough.app.ui.theme.AppColors

// The widgets (designs §23–25): fixed sizes, 28 dp corners, 12 dp inside, 48 dp touch targets, filled-circle habit icons.
// Each draws only the app's snapshot (U26) and the widget's own choice; a tap goes through WidgetTapAction (LOCKED).

/** Bumped by the publisher, so a placed widget draws the snapshot again. */
val VERSION_KEY = longPreferencesKey("version")

enum class WidgetKind(val plus: Boolean, val large: Boolean) {
    ONE_HABIT(false, false), TODAY(true, false), TODAY_LARGE(true, true), WEEK(true, false), TASKS(false, false), TASKS_LARGE(false, true);
    val isList: Boolean get() = this == TODAY || this == TODAY_LARGE || this == TASKS || this == TASKS_LARGE
    val tasks: Boolean get() = this == TASKS || this == TASKS_LARGE
    val oneHabit: Boolean get() = this == ONE_HABIT || this == WEEK
}

abstract class OftenEnoughWidget(private val kind: WidgetKind) : GlanceAppWidget() {
    override val sizeMode: SizeMode = SizeMode.Exact
    override val stateDefinition = PreferencesGlanceStateDefinition

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        val widgetId = GlanceAppWidgetManager(context).getAppWidgetId(id)
        provideContent {
            val state = currentState<Preferences>()
            state[VERSION_KEY] // read, so a publish redraws
            val page = state[PAGE_KEY] ?: 0
            val snapshot = WidgetDisk.read(context)
            WidgetBody(kind, snapshot, WidgetDisk.choice(context, widgetId), page, widgetId)
        }
    }
}

class OneHabitWidget : OftenEnoughWidget(WidgetKind.ONE_HABIT)
class TodayWidget : OftenEnoughWidget(WidgetKind.TODAY)
class TodayLargeWidget : OftenEnoughWidget(WidgetKind.TODAY_LARGE)
class WeekWidget : OftenEnoughWidget(WidgetKind.WEEK)
class TasksWidget : OftenEnoughWidget(WidgetKind.TASKS)
class TasksLargeWidget : OftenEnoughWidget(WidgetKind.TASKS_LARGE)

abstract class OftenEnoughReceiver : GlanceAppWidgetReceiver() {
    override fun onDeleted(context: Context, appWidgetIds: IntArray) {
        super.onDeleted(context, appWidgetIds)
        for (id in appWidgetIds) WidgetDisk.forget(context, id)
    }
}
class OneHabitWidgetReceiver : OftenEnoughReceiver() { override val glanceAppWidget: GlanceAppWidget = OneHabitWidget() }
class TodayWidgetReceiver : OftenEnoughReceiver() { override val glanceAppWidget: GlanceAppWidget = TodayWidget() }
class TodayLargeWidgetReceiver : OftenEnoughReceiver() { override val glanceAppWidget: GlanceAppWidget = TodayLargeWidget() }
class WeekWidgetReceiver : OftenEnoughReceiver() { override val glanceAppWidget: GlanceAppWidget = WeekWidget() }
class TasksWidgetReceiver : OftenEnoughReceiver() { override val glanceAppWidget: GlanceAppWidget = TasksWidget() }
class TasksLargeWidgetReceiver : OftenEnoughReceiver() { override val glanceAppWidget: GlanceAppWidget = TasksLargeWidget() }

// ------------------------------------------------------------------ Colours (the app's own, light and dark)

private val L = AppColors.light
private val D = AppColors.dark
private fun pair(day: Color, night: Color) = ColorProvider(day = day, night = night)
private val Surface = pair(L.surface, D.surface)
private val Ink = pair(L.ink, D.ink)
private val Secondary = pair(L.secondary, D.secondary)
private val Tonal = pair(L.tonal, D.tonal)
private val Tonal2 = pair(L.tonal2, D.tonal2)
/** Surface container highest: a round button before the goal is met (Figma's Filled icon button, Neutral). */
private val Soft = pair(L.soft, D.soft)
private val Flame = pair(L.flame, D.flame)
private val White = pair(Color.White, Color.White)
private fun habit(key: String) = (HabitColor.of(key) ?: HabitColor.BLUE).let { pair(L.habit(it), D.habit(it)) }
private fun fill(key: String) = (HabitColor.of(key) ?: HabitColor.BLUE).let { pair(L.fill(it), D.fill(it)) }
private fun isDark(context: Context) = (context.resources.configuration.uiMode and Configuration.UI_MODE_NIGHT_MASK) == Configuration.UI_MODE_NIGHT_YES

private fun style(size: TextUnit, color: ColorProvider = Ink, weight: FontWeight = FontWeight.Normal) = TextStyle(fontSize = size, color = color, fontWeight = weight)

// ------------------------------------------------------------------ The body: which state to draw

@Composable
private fun WidgetBody(kind: WidgetKind, snapshot: WidgetSnapshot?, choice: String?, page: Int, widgetId: Int) {
    val now = System.currentTimeMillis()
    val frame = snapshot?.frame(now)
    // One habit: 12 above, 16 at the sides and under (Figma 1235:46); the others keep 12 until their own components.
    val inside = if (kind == WidgetKind.ONE_HABIT) GlanceModifier.padding(start = 16.dp, end = 16.dp, top = 12.dp, bottom = 16.dp) else GlanceModifier.padding(12.dp)
    Box(GlanceModifier.fillMaxSize().cornerRadius(28.dp).background(Surface).then(inside)) {
        when {
            // Open to update: no snapshot yet, or one from another time zone or day (the app writes seven days ahead).
            snapshot == null || frame == null -> Message(kind, "Open to update", "Data unavailable", R.drawable.ic_w_refresh, open = "today")
            kind.oneHabit -> OneHabit(kind, snapshot, frame, choice, widgetId)
            else -> ListWidget(kind, snapshot, frame, choice, page, widgetId)
        }
    }
}

/** A widget with nothing to list: a title, one line, a glyph, and where a tap goes. */
@Composable
private fun Message(kind: WidgetKind, title: String, line: String, glyph: Int?, open: String? = null, setup: Int? = null, header: String? = null) {
    val context = LocalContext.current
    val click = when {
        setup != null -> actionStartActivity(Intent(context, WidgetSetupActivity::class.java).putExtra(android.appwidget.AppWidgetManager.EXTRA_APPWIDGET_ID, setup)
            .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK))
        else -> actionRunCallback<WidgetOpenAction>(actionParametersOf(TapKeys.ROUTE to (open ?: "today")))
    }
    if (kind == WidgetKind.ONE_HABIT) return SmallMessage(title, line, glyph, click)
    Column(GlanceModifier.fillMaxSize().clickable(click), horizontalAlignment = Alignment.CenterHorizontally) {
        if (header != null) Text(header, GlanceModifier.fillMaxWidth().padding(start = 4.dp), style = style(17.sp, weight = FontWeight.Medium), maxLines = 1)
        Spacer(GlanceModifier.defaultWeight())
        if (glyph != null) Image(ImageProvider(glyph), null, GlanceModifier.size(24.dp), colorFilter = ColorFilter.tint(Ink))
        Spacer(GlanceModifier.height(6.dp))
        Text(title, style = style(if (kind == WidgetKind.ONE_HABIT) 16.sp else 17.sp, weight = FontWeight.Medium).copy(textAlign = TextAlign.Center), maxLines = 2)
        Text(line, style = style(12.sp, Secondary, FontWeight.Medium).copy(textAlign = TextAlign.Center), maxLines = 2)
        Spacer(GlanceModifier.defaultWeight())
    }
}

// ------------------------------------------------------------------ One habit (2×2) and This week (4×2)

@Composable
private fun OneHabit(kind: WidgetKind, snapshot: WidgetSnapshot, frame: WidgetFrame, choice: String?, widgetId: Int) {
    val id = choice?.removePrefix("habit:")
    val small = kind == WidgetKind.ONE_HABIT
    // No habit made yet (Figma's "no habits yet"): the app opens to start one.
    if (id == null && small && snapshot.choices.isEmpty()) return Message(kind, "No habits yet", "Start one in the app", R.drawable.ic_w_list, open = "today")
    if (id == null) return Message(kind, "Choose a habit", if (small) "Tap to choose" else "Tap to choose the habit this widget shows.", R.drawable.ic_w_list, setup = widgetId)
    val item = frame.item(id) ?: return if (small) Message(kind, "Choose a habit", "Habit removed", R.drawable.ic_w_list, setup = widgetId)
        else Message(kind, "Habit removed", "Tap to choose another", R.drawable.ic_w_list, setup = widgetId)
    // This week is Plus; without Plus it never blocks or goes blank: it says what's there and opens the app (A13).
    if (kind.plus && !snapshot.plus) return Message(kind, "This week", "See the whole week here with Plus. Tap to open the app.", null, open = "item/$id")
    if (kind == WidgetKind.WEEK) WeekCard(item, frame, snapshot) else SmallCard(item, frame)
}

/**
 * 5.10.1, **Widget · One habit** (Figma 1235:46, Kind Habit; every state in "One habit (2×2) · every state"): 2×2,
 * Surface container lowest, 28 corners, 12 above, 16 at the sides and under. The top: the habit's icon (40, its colour)
 * and the round button (40 on a 48 touch target; Surface container highest with an On surface variant glyph, or the
 * habit's colour with white once its goal is met); then, at the foot, the name in Title Medium, its line in Body Medium
 * On surface variant ("3 of 8 glasses", a quit run's clock, a timer's), and 12 under it either today's progress (Linear
 * progress, Flat: 4 tall, the habit's colour on Secondary container) or the band (20 tall, 10 corners, Surface container
 * high, Label Medium On surface variant: "Best 45 days", "Daily limit", "Skipped today", "Back on Mon 19 Oct"). A tap on
 * the card opens the day; the button logs (LOCKED, widget taps).
 */
@Composable
private fun SmallCard(item: WidgetItem, frame: WidgetFrame) {
    val dayClick = actionRunCallback<WidgetOpenAction>(actionParametersOf(TapKeys.ROUTE to item.routeOrDay, TapKeys.DAY to frame.day))
    Column(GlanceModifier.fillMaxSize().clickable(dayClick).semantics { contentDescription = spoken(item) }) {
        Row(GlanceModifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
            Icon(item, 40.dp)
            Spacer(GlanceModifier.defaultWeight())
            RoundButton(item, frame)
        }
        Spacer(GlanceModifier.defaultWeight())
        if (item.name.isNotEmpty()) Text(item.name, style = style(16.sp, weight = FontWeight.Medium), maxLines = 1)
        when {
            item.quitStart != null -> QuitClock(item, 14.sp, Secondary)
            item.timerClock != null -> TimerClock(item, 14.sp, Secondary)
            else -> Text(item.value.ifEmpty { item.line }, style = style(14.sp, Secondary), maxLines = 1)
        }
        val caption = item.caption
        if (caption != null) {
            Spacer(GlanceModifier.height(12.dp))
            Band(caption)
        } else if ((item.cardFraction ?: item.fraction) != null) {
            Spacer(GlanceModifier.height(12.dp))
            Bar(item, 4.dp)
        }
    }
}

/** The One habit card's band (Figma's Band): a state in words, in place of the progress bar. */
@Composable
private fun Band(words: String) {
    Box(GlanceModifier.fillMaxWidth().height(20.dp).cornerRadius(10.dp).background(Tonal2).padding(horizontal = 8.dp), contentAlignment = Alignment.Center) {
        Text(words, style = style(12.sp, Secondary, FontWeight.Medium), maxLines = 1)
    }
}

/**
 * The One habit widget with nothing to show (Figma 1235:46, Kind Message): its icon (24, On surface variant) and the
 * open button at the top, the words at the foot, Title Medium over Body Medium. The whole card is the tap.
 */
@Composable
private fun SmallMessage(title: String, line: String, glyph: Int?, click: androidx.glance.action.Action) {
    Column(GlanceModifier.fillMaxSize().clickable(click).semantics { contentDescription = "$title, $line" }) {
        Row(GlanceModifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
            if (glyph != null) Image(ImageProvider(glyph), null, GlanceModifier.size(24.dp), colorFilter = ColorFilter.tint(Secondary))
            Spacer(GlanceModifier.defaultWeight())
            Box(GlanceModifier.size(48.dp), contentAlignment = Alignment.Center) {
                Box(GlanceModifier.size(40.dp).cornerRadius(20.dp).background(Soft), contentAlignment = Alignment.Center) {
                    Image(ImageProvider(R.drawable.ic_w_open), null, GlanceModifier.size(24.dp), colorFilter = ColorFilter.tint(Secondary))
                }
            }
        }
        Spacer(GlanceModifier.defaultWeight())
        Text(title, style = style(16.sp, weight = FontWeight.Medium), maxLines = 1)
        Text(line, style = style(14.sp, Secondary), maxLines = 1)
    }
}

@Composable
private fun WeekCard(item: WidgetItem, frame: WidgetFrame, snapshot: WidgetSnapshot) {
    val dayClick = actionRunCallback<WidgetOpenAction>(actionParametersOf(TapKeys.ROUTE to item.routeOrDay, TapKeys.DAY to frame.day))
    Row(GlanceModifier.fillMaxSize().clickable(dayClick).semantics { contentDescription = spoken(item) }) {
        Column(GlanceModifier.width(96.dp).fillMaxHeight().cornerRadius(20.dp).background(Tonal2).padding(8.dp),
            horizontalAlignment = Alignment.CenterHorizontally, verticalAlignment = Alignment.CenterVertically) {
            Icon(item, 48.dp)
            Spacer(GlanceModifier.height(8.dp))
            if (item.name.isNotEmpty()) Text(item.name, style = style(15.sp, weight = FontWeight.Medium), maxLines = 1)
            item.streak?.let { Streak(it) } ?: item.quitBestText?.let { Text(it, style = style(13.sp, Secondary), maxLines = 1) }
        }
        Spacer(GlanceModifier.width(12.dp))
        Column(GlanceModifier.defaultWeight().fillMaxHeight()) {
            Row(GlanceModifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
                Column(GlanceModifier.defaultWeight()) {
                    when {
                        item.quitStart != null -> { QuitClock(item, 24.sp, Ink); item.since?.let { Text(it, style = style(14.sp, Secondary), maxLines = 1) } }
                        item.timerClock != null -> TimerClock(item, 24.sp, Ink)
                        else -> Row(verticalAlignment = Alignment.Bottom) {
                            Text(item.big, style = style(30.sp))
                            Text("  " + item.goal, style = style(14.sp, Secondary), maxLines = 1)
                        }
                    }
                }
                RoundButton(item, frame)
            }
            Spacer(GlanceModifier.height(8.dp))
            Bar(item)
            Spacer(GlanceModifier.height(8.dp))
            Row(GlanceModifier.fillMaxWidth().defaultWeight().cornerRadius(16.dp).background(Tonal2).padding(horizontal = 6.dp, vertical = 6.dp),
                verticalAlignment = Alignment.CenterVertically) {
                item.week.forEachIndexed { i, cell ->
                    Column(GlanceModifier.defaultWeight(), horizontalAlignment = Alignment.CenterHorizontally) {
                        Square(cell, item.color, i == item.weekToday)
                        Text(snapshot.weekdays.getOrNull(i)?.take(1) ?: "", style = style(11.sp, if (i == item.weekToday) Ink else Secondary,
                            if (i == item.weekToday) FontWeight.Bold else FontWeight.Normal))
                    }
                }
            }
        }
    }
}

/** One day's square, in Progress Week's language (never a harsh mark, U3). */
@Composable
private fun Square(cell: Int, color: String, today: Boolean) {
    val level = cell.coerceAtLeast(-5)
    val back = when {
        level >= 4 -> habit(color)
        level in 1..3 -> fill(color)
        else -> Tonal
    }
    // Today's square has an outline (Glance has no border: a slightly larger square behind it).
    Box(GlanceModifier.size(24.dp).cornerRadius(6.dp).background(if (today) Secondary else back), contentAlignment = Alignment.Center) {
        Box(GlanceModifier.size(if (today) 20.dp else 24.dp).cornerRadius(if (today) 4.dp else 6.dp).background(back), contentAlignment = Alignment.Center) {
            if (level >= 4) Image(ImageProvider(R.drawable.ic_w_check), null, GlanceModifier.size(14.dp), colorFilter = ColorFilter.tint(White))
            else if (cell == WidgetCell.SKIPPED || cell == WidgetCell.PAUSED) Text(if (cell == WidgetCell.SKIPPED) "»" else "‖", style = style(11.sp, Secondary))
        }
    }
}

// ------------------------------------------------------------------ Lists: Today and Tasks (4×2, 4×4)

@Composable
private fun ListWidget(kind: WidgetKind, snapshot: WidgetSnapshot, frame: WidgetFrame, choice: String?, page: Int, widgetId: Int) {
    val section = choice?.removePrefix("section:")?.takeIf { choice.startsWith("section:") }
    val sections = if (kind.tasks) snapshot.taskSections else snapshot.sections
    val sectionName = section?.let { id -> sections.firstOrNull { it.id == id }?.name }
    if (section != null && sectionName == null) return Message(kind, "Section unavailable", "Tap to choose another", null, setup = widgetId, header = if (kind.tasks) "Tasks" else "Today")
    val title = sectionName ?: if (kind.tasks) "Tasks" else "Today"
    val key = (if (kind.tasks) "tasks" else "habits") + (section?.let { ":$it" } ?: "")
    val rows = frame.list(key, System.currentTimeMillis())
    val counted = rows.filter { it.counts }
    val doneText = if (counted.isEmpty()) null else "${counted.count { it.countsDone }} of ${counted.size} done"
    when {
        kind.plus && !snapshot.plus -> return PlusMessage(title, doneText)
        rows.isEmpty() && frame.items.none { !it.isTask == !kind.tasks } -> return Message(kind, if (kind.tasks) "No tasks today" else "No habits yet",
            if (kind.tasks) "Add one in the app" else "Start one in the app", null, header = title)
        rows.isEmpty() -> return Message(kind, if (section != null) "Nothing planned in $title" else if (kind.tasks) "No tasks today" else "Nothing planned for today",
            if (section != null) "Open $title" else "Open Today", null, header = title)
    }
    val perPage = if (kind.large) 5 else 2
    val pages = (rows.size + perPage - 1) / perPage
    val shown = page.coerceIn(0, pages - 1)
    Column(GlanceModifier.fillMaxSize()) {
        Header(kind, title, doneText, shown, pages)
        Spacer(GlanceModifier.height(if (kind.large) 8.dp else 6.dp))
        // The rows in a column of their own: a Glance container holds at most 10 children (five rows and their gaps
        // beside the header and its gap were 11, and the fifth row was dropped).
        Column(GlanceModifier.fillMaxWidth()) {
            rows.drop(shown * perPage).take(perPage).forEachIndexed { i, item ->
                ListRow(item, frame, showPlace = section == null && !kind.tasks, top = if (i > 0) 4.dp else 0.dp)
            }
        }
    }
}

@Composable
private fun Header(kind: WidgetKind, title: String, done: String?, page: Int, pages: Int) {
    if (kind.large) {
        Row(GlanceModifier.fillMaxWidth().padding(start = 4.dp), verticalAlignment = Alignment.CenterVertically) {
            Column(GlanceModifier.defaultWeight()) {
                Text(title, style = style(22.sp), maxLines = 1)
                done?.let { Text(it, style = style(12.sp, Secondary, FontWeight.Medium)) }
            }
            if (pages > 1) {
                PageArrow(R.drawable.ic_w_left, -1, page > 0, "Previous page")
                Text("${page + 1}/$pages", style = style(14.sp, Ink, FontWeight.Medium))
                PageArrow(R.drawable.ic_w_right, 1, page < pages - 1, "Next page")
            }
        }
    } else {
        Row(GlanceModifier.fillMaxWidth().padding(start = 4.dp), verticalAlignment = Alignment.CenterVertically) {
            Text(title, GlanceModifier.defaultWeight(), style = style(17.sp, weight = FontWeight.Medium), maxLines = 1)
            done?.let { Text(it, GlanceModifier.cornerRadius(12.dp).background(Tonal).padding(horizontal = 10.dp, vertical = 3.dp), style = style(12.sp, Ink, FontWeight.Medium)) }
        }
    }
}

@Composable
private fun PageArrow(glyph: Int, delta: Int, enabled: Boolean, label: String) {
    Box(GlanceModifier.size(40.dp).let { if (enabled) it.clickable(actionRunCallback<WidgetPageAction>(actionParametersOf(TapKeys.DELTA to delta))) else it }
        .semantics { contentDescription = label }, contentAlignment = Alignment.Center) {
        Image(ImageProvider(glyph), null, GlanceModifier.size(20.dp), colorFilter = ColorFilter.tint(if (enabled) Ink else Tonal))
    }
}

/** Without Plus, a Plus widget never blocks and never shows blank: it says what's there and opens Today (A13). */
@Composable
private fun PlusMessage(title: String, done: String?) {
    Column(GlanceModifier.fillMaxSize().clickable(actionRunCallback<WidgetOpenAction>(actionParametersOf(TapKeys.ROUTE to "today"))),
        horizontalAlignment = Alignment.CenterHorizontally) {
        Row(GlanceModifier.fillMaxWidth().padding(start = 4.dp), verticalAlignment = Alignment.CenterVertically) {
            Text(title, GlanceModifier.defaultWeight(), style = style(17.sp, weight = FontWeight.Medium), maxLines = 1)
            done?.let { Text(it, GlanceModifier.cornerRadius(12.dp).background(Tonal).padding(horizontal = 10.dp, vertical = 3.dp), style = style(12.sp, Ink, FontWeight.Medium)) }
        }
        Spacer(GlanceModifier.defaultWeight())
        Text("Tick habits off here with Plus", style = style(16.sp, weight = FontWeight.Medium))
        Text("Your habits are in the app", style = style(12.sp, Secondary, FontWeight.Medium))
        Spacer(GlanceModifier.height(8.dp))
        Text("Open Today", GlanceModifier.cornerRadius(20.dp).background(Tonal).padding(horizontal = 16.dp, vertical = 8.dp), style = style(14.sp, Ink, FontWeight.Medium))
        Spacer(GlanceModifier.defaultWeight())
    }
}

/** One row: the fill toward its goal behind it, the icon, name and line, the streak, and its button. */
@Composable
private fun ListRow(item: WidgetItem, frame: WidgetFrame, showPlace: Boolean, top: Dp = 0.dp) {
    val width = LocalSize.current.width - 24.dp
    val share = (item.fraction ?: 0.0).coerceIn(0.0, 1.0)
    val dayClick = actionRunCallback<WidgetOpenAction>(actionParametersOf(TapKeys.ROUTE to item.routeOrDay, TapKeys.DAY to frame.day))
    Box(GlanceModifier.fillMaxWidth().padding(top = top)) {
    Box(GlanceModifier.fillMaxWidth().height(64.dp).cornerRadius(16.dp).background(Surface)) {
        // The fill: the share reached, in a light tint of the habit's colour (a limit's stays neutral, U2).
        if (share > 0) Box(GlanceModifier.width(width * share.toFloat()).fillMaxHeight().background(if (item.limitFill) Tonal2 else fill(item.color))) {}
        Row(GlanceModifier.fillMaxSize().clickable(dayClick).padding(start = 8.dp, end = 4.dp).semantics { contentDescription = spoken(item) },
            verticalAlignment = Alignment.CenterVertically) {
            Icon(item, 36.dp)
            Spacer(GlanceModifier.width(12.dp))
            Column(GlanceModifier.defaultWeight()) {
                if (item.name.isNotEmpty()) Text(item.name, style = style(15.sp, weight = FontWeight.Medium), maxLines = 1)
                when {
                    item.quitStart != null -> Row { QuitClock(item, 13.sp, Secondary); item.quitBestText?.let { Text(" · $it", style = style(13.sp, Secondary), maxLines = 1) } }
                    item.timerClock != null -> TimerClock(item, 13.sp, Secondary)
                    else -> Text(if (showPlace) item.todayLine.ifEmpty { item.line } else item.line, style = style(13.sp, Secondary), maxLines = 1)
                }
            }
            item.streak?.let { Streak(it); Spacer(GlanceModifier.width(8.dp)) }
            RoundButton(item, frame)
        }
    }
    }
}

// ------------------------------------------------------------------ Parts

@Composable
private fun Icon(item: WidgetItem, size: Dp) {
    val context = LocalContext.current
    val px = (size.value * context.resources.displayMetrics.density).toInt()
    Image(ImageProvider(HabitIconBitmaps.get(item.symbol, item.color, isDark(context), px)), null, GlanceModifier.size(size))
}

@Composable
private fun Streak(text: String) {
    Row(verticalAlignment = Alignment.CenterVertically) {
        Image(ImageProvider(R.drawable.ic_w_flame), null, GlanceModifier.size(16.dp), colorFilter = ColorFilter.tint(Flame))
        Spacer(GlanceModifier.width(2.dp))
        Text(text, style = style(15.sp))
    }
}

/**
 * Today's progress (Figma's Linear progress, Flat): the habit's colour on Secondary container, or neutral for a limit
 * (U2, U25). [height]: 4 on One habit; This week keeps its 8 until its own component.
 */
@Composable
private fun Bar(item: WidgetItem, height: Dp = 8.dp) {
    val share = (item.cardFraction ?: item.fraction) ?: return
    LinearProgressIndicator(share.toFloat().coerceIn(0f, 1f), GlanceModifier.fillMaxWidth().height(height).cornerRadius(height / 2),
        color = if (item.limitFill) Secondary else habit(item.color), backgroundColor = Tonal)
}

/**
 * The card's one button (48 dp target, 40 dp circle): tonal grey before the goal is met, the habit's colour with white
 * once it is (U2, U14). LOCKED (widget taps): ✓ and + log on the widget; ▶/⏸ start and stop the timer there (W7);
 * anything needing a screen opens it (W8).
 */
@Composable
private fun RoundButton(item: WidgetItem, frame: WidgetFrame) {
    val filled = item.done && item.action != WidgetAction.TIMER_PAUSE && !item.limit
    val back = if (filled) habit(item.color) else Soft
    val tint = if (filled) White else Secondary
    val idle = item.state != null
    val (click, label) = when (item.action) {
        WidgetAction.CHECK -> tap(item, frame, if (item.done) "uncheck" else "check") to (if (item.done) "Undo ${item.name}" else "Mark ${item.name} done")
        WidgetAction.ADD -> tap(item, frame, "add") to (if (item.type == "check") "Add a check to ${item.name}" else "Add ${item.actionText ?: ""} to ${item.name}")
        WidgetAction.TIMER_START -> tap(item, frame, "start") to "Start ${item.name} timer"
        WidgetAction.TIMER_PAUSE -> tap(item, frame, "stop") to "Stop ${item.name} timer"
        WidgetAction.OPEN -> actionRunCallback<WidgetOpenAction>(actionParametersOf(TapKeys.ROUTE to item.routeOrDay, TapKeys.DAY to frame.day)) to "Open ${item.name}"
    }
    Box(GlanceModifier.size(48.dp).let { if (idle) it else it.clickable(click) }.semantics { contentDescription = label.replace("  ", " ") },
        contentAlignment = Alignment.Center) {
        Box(GlanceModifier.size(40.dp).cornerRadius(20.dp).background(back), contentAlignment = Alignment.Center) {
            val glyph = when (item.action) {
                WidgetAction.CHECK -> R.drawable.ic_w_check
                // A check counted toward a week or month keeps its ✓ (W15); an amount says its step.
                WidgetAction.ADD -> if (item.type == "check") R.drawable.ic_w_check else null
                WidgetAction.TIMER_START -> R.drawable.ic_w_play
                WidgetAction.TIMER_PAUSE -> R.drawable.ic_w_pause
                // A number to type opens its Add screen with a plain + (W8); steps and slips open with ↗.
                WidgetAction.OPEN -> if (item.route?.startsWith("log/") == true) R.drawable.ic_w_plus else R.drawable.ic_w_open
            }
            if (glyph != null) Image(ImageProvider(glyph), null, GlanceModifier.size(24.dp), colorFilter = ColorFilter.tint(tint))
            else Text(item.actionText ?: "+1", style = style(14.sp, tint, FontWeight.Medium))
        }
    }
}

private fun tap(item: WidgetItem, frame: WidgetFrame, kind: String) = actionRunCallback<WidgetTapAction>(actionParametersOf(
    TapKeys.ITEM to item.id, TapKeys.TOKEN to item.token, TapKeys.KIND to kind, TapKeys.DAY to frame.day))

/** A quit run's live count, "12d 11:23:16": the days drawn, the clock ticking on its own (only it ticks, S3). */
@Composable
private fun QuitClock(item: WidgetItem, size: TextUnit, color: ColorProvider) {
    val start = item.quitStart ?: return
    val now = System.currentTimeMillis()
    val until = item.quitUntil
    if (until != null && until <= now) return Text(item.value, style = style(size, color), maxLines = 1)
    val elapsed = now - start
    val days = elapsed / 86_400_000L
    val inDay = elapsed - days * 86_400_000L
    // Android's chronometer leaves out the hour under an hour ("01:22"): the "0:" is drawn until then, and the widget is
    // redrawn an hour in and at each new day of the run (WidgetDayReceiver), so it always reads "12d 0:01:22".
    Row(verticalAlignment = Alignment.CenterVertically) {
        Text((if (days > 0) "${days}d " else "") + (if (inDay < 3_600_000L) "0:" else ""), style = style(size, color))
        Chronometer(SystemClock.elapsedRealtime() - inDay, size, color)
    }
}

/** A running timer's clock and its goal, "6:24 of 10 min". */
@Composable
private fun TimerClock(item: WidgetItem, size: TextUnit, color: ColorProvider) {
    val clock = item.timerClock ?: return
    Row(verticalAlignment = Alignment.CenterVertically) {
        Chronometer(SystemClock.elapsedRealtime() - (System.currentTimeMillis() - clock), size, color)
        // The goal's words come whole from the app ("of 20 min").
        item.timerGoal?.let { Text(" " + it.trim(), style = style(size, color), maxLines = 1) }
    }
}

@Composable
private fun Chronometer(base: Long, size: TextUnit, color: ColorProvider) {
    val context = LocalContext.current
    val views = RemoteViews(context.packageName, R.layout.widget_chronometer).apply {
        setChronometer(R.id.chronometer, base, null, true)
        setTextViewTextSize(R.id.chronometer, TypedValue.COMPLEX_UNIT_SP, size.value)
        val c = color.getColor(context)
        setTextColor(R.id.chronometer, android.graphics.Color.argb((c.alpha * 255).toInt(), (c.red * 255).toInt(), (c.green * 255).toInt(), (c.blue * 255).toInt()))
    }
    AndroidRemoteViews(views)
}

/** What TalkBack says for a card: its name and line (W16). */
private fun spoken(item: WidgetItem): String = listOf(item.name, item.value.ifEmpty { item.line }).filter { it.isNotEmpty() }.joinToString(", ")

