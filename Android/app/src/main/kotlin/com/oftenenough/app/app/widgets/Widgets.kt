package com.oftenenough.app.app.widgets

import android.content.Context
import android.content.Intent
import android.content.res.Configuration
import android.os.SystemClock
import android.util.TypedValue
import android.widget.RemoteViews
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.runtime.staticCompositionLocalOf
import androidx.compose.ui.unit.DpSize
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.compositeOver
import androidx.compose.ui.graphics.toArgb
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
import androidx.glance.action.actionParametersOf
import androidx.glance.action.clickable
import androidx.glance.appwidget.AndroidRemoteViews
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.GlanceAppWidgetManager
import androidx.glance.appwidget.GlanceAppWidgetReceiver
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
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.widgets.WidgetAction
import com.oftenenough.app.data.widgets.WidgetCell
import com.oftenenough.app.data.widgets.WidgetFrame
import com.oftenenough.app.data.widgets.WidgetItem
import com.oftenenough.app.data.widgets.WidgetSnapshot
import com.oftenenough.app.ui.components.DayCellColors
import com.oftenenough.app.ui.components.dayCellColors
import com.oftenenough.app.ui.theme.AppColors

// The widgets (designs §23–25): fixed sizes, 28 dp corners, 12 dp inside, 48 dp touch targets, filled-circle habit icons.
// Each draws only the app's snapshot (U26) and the widget's own choice; a tap goes through WidgetTapAction (LOCKED).

/** Bumped by the publisher, so a placed widget draws the snapshot again. */
val VERSION_KEY = longPreferencesKey("version")

/** Each widget's size in Figma ([design]): One habit 156 × 176, the 4×2s 328 × 176, the 4×4s 328 × 368. */
enum class WidgetKind(val plus: Boolean, val large: Boolean, val design: DpSize) {
    ONE_HABIT(false, false, DpSize(156.dp, 176.dp)), TODAY(true, false, DpSize(328.dp, 176.dp)), TODAY_LARGE(true, true, DpSize(328.dp, 368.dp)),
    WEEK(true, false, DpSize(328.dp, 176.dp)), TASKS(false, false, DpSize(328.dp, 176.dp)), TASKS_LARGE(false, true, DpSize(328.dp, 368.dp));
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
            // A page lasts the day: the next morning starts on the first, with what's still to do.
            val page = if (state[PAGE_DAY_KEY] == snapshot(context)?.frame(System.currentTimeMillis())?.day) state[PAGE_KEY] ?: 0 else 0
            CompositionLocalProvider(LocalNight provides widgetNight(context)) {
                WidgetBody(kind, snapshot(context), WidgetDisk.choice(context, widgetId), page, widgetId)
            }
        }
    }
}

private fun snapshot(context: Context) = WidgetDisk.read(context)

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

/**
 * The app's Theme decides the widgets too (A98): Light or Dark draws every colour in that mode whatever the phone's is;
 * System leaves each colour a light and dark pair, which the launcher picks between with the phone's mode. Everything a
 * widget draws is one of these, the week's cells too, so no part of it can follow a different mode from the rest (the
 * cells were a picture drawn in the app's mode, dark on a light widget).
 */
private val LocalNight = staticCompositionLocalOf<Boolean?> { null }

/** The Theme setting as the widgets read it: true dark, false light, null the phone's. */
internal fun widgetNight(context: Context): Boolean? =
    when (context.getSharedPreferences("prefs", Context.MODE_PRIVATE).getString("appearance.theme", "system")) {
        "light" -> false; "dark" -> true; else -> null
    }

/** One colour role, light and dark, as the widgets draw it ([LocalNight]). */
private class Tone(val day: Color, val night: Color)

@Composable
private fun pair(day: Color, night: Color): ColorProvider = when (LocalNight.current) {
    true -> ColorProvider(night); false -> ColorProvider(day); null -> ColorProvider(day = day, night = night)
}
@Composable private fun Tone.provider() = pair(day, night)

private val InkTone = Tone(L.ink, D.ink)
private val SecondaryTone = Tone(L.secondary, D.secondary)
private val Surface @Composable get() = pair(L.surface, D.surface)
private val Ink @Composable get() = InkTone.provider()
private val Secondary @Composable get() = SecondaryTone.provider()
private val Tonal @Composable get() = pair(L.tonal, D.tonal)
private val Tonal2 @Composable get() = pair(L.tonal2, D.tonal2)
/** Surface container: This week's two panels (Figma 1243:857). */
private val Screen @Composable get() = pair(L.screen, D.screen)
/** Surface container highest: a round button before the goal is met (Figma's Filled icon button, Neutral). */
private val Soft @Composable get() = pair(L.soft, D.soft)
private val White = ColorProvider(Color.White)
/** Primary and On primary: the Plus label (Figma 1208:1983). */
private val Primary @Composable get() = pair(AppColors.lightRoles.primary, AppColors.darkRoles.primary)
private val OnPrimary @Composable get() = pair(AppColors.lightRoles.onPrimary, AppColors.darkRoles.onPrimary)
@Composable private fun habit(key: String) = (HabitColor.of(key) ?: HabitColor.BLUE).let { pair(L.habit(it), D.habit(it)) }
@Composable private fun fill(key: String) = (HabitColor.of(key) ?: HabitColor.BLUE).let { pair(L.fill(it), D.fill(it)) }

@Composable
private fun style(size: TextUnit, color: ColorProvider = Ink, weight: FontWeight = FontWeight.Normal) = TextStyle(fontSize = size, color = color, fontWeight = weight)

// ------------------------------------------------------------------ The body: which state to draw

/** The card's own size ([cardSize]): what a row or the week reads instead of the cells the launcher gave. */
private val LocalCard = staticCompositionLocalOf { DpSize(328.dp, 176.dp) }

/**
 * The card inside the cells the launcher gives (A98): as wide as they are and Figma's height, never taller than the
 * cells; centred in them. Launchers' cells differ a lot (a 2×2 is 208 × 368 on a moto g54's 4 × 4 grid), and a card
 * stretched to fill them, or kept in Figma's proportions, pulled its parts apart (99 between a 2×2's button and its
 * name, where Figma has 40).
 */
internal fun cardSize(kind: WidgetKind, space: DpSize): DpSize {
    val design = kind.design
    return DpSize(space.width, minOf(design.height, space.height))
}

@Composable
private fun WidgetBody(kind: WidgetKind, snapshot: WidgetSnapshot?, choice: String?, page: Int, widgetId: Int) {
    val now = System.currentTimeMillis()
    val frame = snapshot?.frame(now)
    // One habit: 12 above, 16 at the sides and under (Figma 1235:46). The lists: 10 above and 12 round on a 4×2, 12 all
    // round on a 4×4 (Figma 1240:488). This week keeps 12 until its own component.
    val inside = when {
        kind == WidgetKind.ONE_HABIT -> GlanceModifier.padding(start = 16.dp, end = 16.dp, top = 12.dp, bottom = 16.dp)
        !kind.oneHabit && !kind.large -> GlanceModifier.padding(start = 12.dp, end = 12.dp, top = 10.dp, bottom = 12.dp)
        else -> GlanceModifier.padding(12.dp)
    }
    val card = cardSize(kind, LocalSize.current)
    Box(GlanceModifier.fillMaxSize(), contentAlignment = Alignment.Center) {
    CompositionLocalProvider(LocalCard provides card) {
    // As wide as the cells really are: a launcher can pad them (8 all round on a moto g54) and still report their whole
    // size, and a card given that width was cut off at both sides.
    Box(GlanceModifier.fillMaxWidth().height(card.height).cornerRadius(28.dp).background(Surface).then(inside)) {
        when {
            // Open to update: no snapshot yet, or one from another time zone or day (the app writes seven days ahead).
            snapshot == null || frame == null -> Message(kind, "Open to update", "Data unavailable", R.drawable.ic_w_refresh, open = "today",
                header = if (kind.oneHabit) null else if (kind.tasks) "Tasks" else "Today", note = "Open the app to refresh this widget.")
            kind.oneHabit -> OneHabit(kind, snapshot, frame, choice, widgetId)
            else -> ListWidget(kind, snapshot, frame, choice, page, widgetId)
        }
    }
    }
    }
}

/** The widget exactly as it draws, for Widget setup's preview (5.10.6): the first page, no widget of its own. */
@Composable
internal fun WidgetPreview(kind: WidgetKind, snapshot: WidgetSnapshot?, choice: String?, night: Boolean? = null) =
    CompositionLocalProvider(LocalNight provides night) {
        WidgetBody(kind, snapshot, choice, 0, android.appwidget.AppWidgetManager.INVALID_APPWIDGET_ID)
    }

/** A widget with nothing to list: a title, one line, a glyph, and where a tap goes. */
@Composable
private fun Message(
    kind: WidgetKind, title: String, line: String, glyph: Int?, open: String? = null, setup: Int? = null, header: String? = null,
    note: String = "", plus: Boolean = false,
) {
    val context = LocalContext.current
    val click = when {
        setup != null -> actionStartActivity(Intent(context, WidgetSetupActivity::class.java).putExtra(android.appwidget.AppWidgetManager.EXTRA_APPWIDGET_ID, setup)
            .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK))
        else -> actionRunCallback<WidgetOpenAction>(actionParametersOf(TapKeys.ROUTE to (open ?: "today")))
    }
    if (kind == WidgetKind.ONE_HABIT) return SmallMessage(title, line, glyph, click)
    if (kind == WidgetKind.WEEK) return WeekMessage(title, line, note, glyph ?: R.drawable.ic_w_list, click, plus)
    ListMessage(header, title, line, glyph, click)
}

/**
 * A list widget with no rows (Figma 1240:488, Size 4×2 · Message): the header (its title, and the 6 it keeps under it), then one message
 * in the middle of the rest, 16 in at the sides, 4 between: an optional glyph (24, On surface variant) or the Plus label,
 * the headline (Title Medium, 16 sp, On surface) and its line (Body Small, 12 sp, On surface variant). The whole widget
 * is the tap.
 */
@Composable
private fun ListMessage(header: String?, title: String, line: String, glyph: Int?, click: androidx.glance.action.Action, plus: Boolean = false) {
    Column(GlanceModifier.fillMaxSize().clickable(click).semantics { contentDescription = listOfNotNull(header, title, line).joinToString(", ") }) {
        if (header != null) Header(false, header, null, 0, 1)
        Column(GlanceModifier.fillMaxWidth().defaultWeight().padding(horizontal = 16.dp),
            horizontalAlignment = Alignment.CenterHorizontally, verticalAlignment = Alignment.CenterVertically) {
            if (plus) { PlusLabel(); Spacer(GlanceModifier.height(4.dp)) }
            if (glyph != null) { Image(ImageProvider(glyph), null, GlanceModifier.size(24.dp), colorFilter = ColorFilter.tint(Secondary)); Spacer(GlanceModifier.height(4.dp)) }
            Text(title, style = style(16.sp, weight = FontWeight.Medium).copy(textAlign = TextAlign.Center), maxLines = 2)
            Spacer(GlanceModifier.height(4.dp))
            Text(line, style = style(12.sp, Secondary).copy(textAlign = TextAlign.Center), maxLines = 2)
        }
    }
}

/** Plus label (Figma 1208:1983): a pill of Primary, the filled workspace_premium (16) and "Plus" (Label Medium), On primary. */
@Composable
private fun PlusLabel() {
    Row(GlanceModifier.cornerRadius(12.dp).background(Primary).padding(start = 8.dp, end = 10.dp, top = 4.dp, bottom = 4.dp),
        verticalAlignment = Alignment.CenterVertically) {
        Image(ImageProvider(R.drawable.ic_w_plus_label), null, GlanceModifier.size(16.dp), colorFilter = ColorFilter.tint(OnPrimary))
        Spacer(GlanceModifier.width(4.dp))
        Text("Plus", style = style(12.sp, OnPrimary, FontWeight.Medium))
    }
}

// ------------------------------------------------------------------ One habit (2×2) and This week (4×2)

@Composable
private fun OneHabit(kind: WidgetKind, snapshot: WidgetSnapshot, frame: WidgetFrame, choice: String?, widgetId: Int) {
    val id = choice?.removePrefix("habit:")
    val small = kind == WidgetKind.ONE_HABIT
    // No habit made yet (Figma's "no habits yet"): the app opens to start one.
    if (id == null && small && snapshot.choices.isEmpty()) return Message(kind, "No habits yet", "Start one in the app", R.drawable.ic_w_list, open = "today")
    val choose = "Tap to choose the habit this widget shows."
    if (id == null) return Message(kind, "Choose a habit", if (small) "Tap to choose" else "Not chosen yet", R.drawable.ic_w_list, setup = widgetId, note = choose)
    val item = frame.item(id) ?: return Message(kind, "Choose a habit", "Habit removed", R.drawable.ic_w_list, setup = widgetId, note = choose)
    // This week is Plus; without Plus it never blocks or goes blank: it says where the habit stands and opens it (A13).
    if (kind.plus && !snapshot.plus) return Message(kind, "This week", "${item.name}: ${item.line}" + (if (item.quitStart != null || item.line.contains(" this ") || item.line.contains("today", ignoreCase = true)) "" else " today"),
        R.drawable.ic_w_week, open = "item/$id", note = "See the whole week here with Plus. Tap to open the app.", plus = true)
    if (kind == WidgetKind.WEEK) WeekCard(item, frame, snapshot) else SmallCard(item, frame)
}

/**
 * 5.10.1, **Widget · One habit** (Figma 1235:46, Kind Habit; every state in "One habit (2×2) · every state"): 2×2,
 * Surface container lowest, 28 corners, 12 above, 16 at the sides and under. The top: the habit's icon (40, its colour)
 * and the round button (40 on a 48 touch target; Surface container highest with an On surface variant glyph, or the
 * habit's colour with white once its goal is met); then, at the foot, the name in Title Medium, its line in Body Medium
 * On surface variant ("3 of 8 glasses", a quit run's clock, a timer's), and 12 under it either today's progress (Linear
 * progress, Flat: 8 tall, the habit's colour on Secondary container) or the band (20 tall, 10 corners, Surface container
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
            item.quitStart != null -> QuitClock(item, 14.sp, SecondaryTone)
            // A running timer is its clock alone here ("18:24", Figma's Focus); the list rows add the goal.
            item.timerClock != null -> TimerClock(item, 14.sp, SecondaryTone, withGoal = false)
            else -> Text(item.value.ifEmpty { item.line }, style = style(14.sp, Secondary), maxLines = 1)
        }
        val caption = item.caption
        if (item.milestone != null) {
            Spacer(GlanceModifier.height(12.dp))
            MilestoneBand(item, item.milestone)
        } else if (caption != null) {
            Spacer(GlanceModifier.height(12.dp))
            Band(caption)
        } else if ((item.cardFraction ?: item.fraction) != null) {
            Spacer(GlanceModifier.height(12.dp))
            Bar(item, LocalCard.current.width - 32.dp)
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

/**
 * 5.10.5, **Widget · This week** (Figma 1243:857, Kind Habit; "This week · every state"): 4×2, Surface container
 * lowest, 28 corners, 12 all round, 12 between its two halves. On the left, on Surface container (96 wide, 16 corners, 8
 * at the sides, 6 between, centred): the habit's icon (44), its name (Label Large) and its streak (🔥 and the count in
 * Title Small) or its caption (Body Small, On surface variant: "Best 45 days", "Daily limit"). On the right: today's
 * number (Headline Medium, 28 sp) and its unit (Body Medium, On surface variant, 6 after it, on its baseline: "of 8
 * glasses", "since 26 Sep") with the round button (40); 8 under it today's progress (8 tall; none for a quit run); 8
 * under that the week, on Surface container (16 corners, 8 in at the sides, 10 above and under): seven square Day cells
 * ([DayBox], today ringed) 6 apart, as wide as the panel allows (A98), and 4 under them their letters (11 sp Medium,
 * today's On surface, the rest On surface variant). A tap opens the day; the button logs (LOCKED, widget taps).
 */
@Composable
private fun WeekCard(item: WidgetItem, frame: WidgetFrame, snapshot: WidgetSnapshot) {
    val dayClick = actionRunCallback<WidgetOpenAction>(actionParametersOf(TapKeys.ROUTE to item.routeOrDay, TapKeys.DAY to frame.day))
    // The week fills its panel (8 in at the sides): seven equal columns, each a square cell and the 6 between cells,
    // where today's ring (3 out) has room; never taller than the panel (its height after the 48 row, the bar and the
    // gaps; 10 above and under, 4 and a letter's line under the cells). The column is reckoned 16 narrower than the
    // launcher reports, as a launcher can pad the cells and still report their whole size (8 all round on a moto g54).
    val right = LocalCard.current.width - 24.dp - 96.dp - 12.dp
    val panel = LocalCard.current.height.value - 24f - 48f - (if (item.milestone != null) 24f else if (item.quitStart == null) 12f else 0f) - 8f
    val column = (right.value - 16f - 16f) / 7f
    val cell = minOf(column - WEEK_GAP, panel - 20f - 4f - 16f - WEEK_GAP).coerceAtLeast(8f)
    Row(GlanceModifier.fillMaxSize().clickable(dayClick).semantics { contentDescription = spoken(item) }) {
        Column(GlanceModifier.width(96.dp).fillMaxHeight().cornerRadius(16.dp).background(Screen).padding(horizontal = 8.dp),
            horizontalAlignment = Alignment.CenterHorizontally, verticalAlignment = Alignment.CenterVertically) {
            Icon(item, 44.dp)
            Spacer(GlanceModifier.height(6.dp))
            if (item.name.isNotEmpty()) Text(item.name, style = style(14.sp, weight = FontWeight.Medium).copy(textAlign = TextAlign.Center), maxLines = 1)
            Spacer(GlanceModifier.height(6.dp))
            // A quit run or a limit has its caption ("Best 45 days", "Daily limit"); any other habit its streak, if it has one.
            val caption = item.caption ?: item.quitBestText
            val streak = if (item.limit || item.quitStart != null) null else item.streak
            if (streak != null) Streak(streak, 14.sp, FontWeight.Medium)
            else caption?.let { Text(it, style = style(12.sp, Secondary).copy(textAlign = TextAlign.Center), maxLines = 1) }
        }
        Spacer(GlanceModifier.width(12.dp))
        Column(GlanceModifier.defaultWeight().fillMaxHeight()) {
            // The round button keeps its 48 touch target, so this row is 48 and the gap under it 4 (8 under the circle).
            Row(GlanceModifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
                Box(GlanceModifier.defaultWeight()) {
                    when {
                        item.quitStart != null -> Row(verticalAlignment = Alignment.Bottom) {
                            QuitClock(item, 28.sp, InkTone)
                            item.since?.let { Text("  $it", style = style(14.sp, Secondary), maxLines = 1) }
                        }
                        item.timerClock != null -> TimerClock(item, 28.sp, InkTone)
                        else -> Row(verticalAlignment = Alignment.Bottom) {
                            Text(item.big, style = style(28.sp), maxLines = 1)
                            Text("  " + item.goal, style = style(14.sp, Secondary), maxLines = 1)
                        }
                    }
                }
                RoundButton(item, frame)
            }
            if (item.milestone != null) { Spacer(GlanceModifier.height(4.dp)); MilestoneBand(item, item.milestone) }
            else if (item.quitStart == null) { Spacer(GlanceModifier.height(4.dp)); Bar(item, right) }
            Spacer(GlanceModifier.height(8.dp))
            Column(GlanceModifier.fillMaxWidth().defaultWeight().cornerRadius(16.dp).background(Screen),
                horizontalAlignment = Alignment.CenterHorizontally, verticalAlignment = Alignment.CenterVertically) {
                val habitColor = HabitColor.of(item.color) ?: HabitColor.BLUE
                val light = dayCellColors(habitColor, L, AppColors.lightRoles)
                val dark = dayCellColors(habitColor, D, AppColors.darkRoles)
                Row(GlanceModifier.fillMaxWidth().padding(horizontal = 8.dp)) {
                    for (i in 0 until 7) Box(GlanceModifier.defaultWeight(), contentAlignment = Alignment.Center) {
                        DayBox(item.week.getOrElse(i) { WidgetCell.BLANK }, i == item.weekToday, cell.dp, light, dark)
                    }
                }
                Spacer(GlanceModifier.height(4.dp))
                // Each letter in its cell's column.
                Row(GlanceModifier.fillMaxWidth().padding(horizontal = 8.dp)) {
                    for (i in 0 until 7) Box(GlanceModifier.defaultWeight(), contentAlignment = Alignment.Center) {
                        Text(snapshot.weekdays.getOrNull(i)?.take(1) ?: "", style = style(11.sp, if (i == item.weekToday) Ink else Secondary, FontWeight.Medium))
                    }
                }
            }
        }
    }
}

/**
 * This week with nothing to show (Figma 1243:857, Kind Message): its glyph (24, On surface variant) in the left half, on
 * Surface container; on the right the headline (Headline Small, 22 sp) over its line (Body Medium, On surface variant),
 * then, 8 under, the note on Surface container (16 corners, 16 in, centred): the Plus label on the free plan, and the
 * words (Body Small, On surface variant). The whole widget is the tap.
 */
@Composable
private fun WeekMessage(title: String, line: String, note: String, glyph: Int, click: androidx.glance.action.Action, plus: Boolean = false) {
    Row(GlanceModifier.fillMaxSize().clickable(click).semantics { contentDescription = "$title, $line, $note" }) {
        Box(GlanceModifier.width(96.dp).fillMaxHeight().cornerRadius(16.dp).background(Screen), contentAlignment = Alignment.Center) {
            Image(ImageProvider(glyph), null, GlanceModifier.size(24.dp), colorFilter = ColorFilter.tint(Secondary))
        }
        Spacer(GlanceModifier.width(12.dp))
        Column(GlanceModifier.defaultWeight().fillMaxHeight()) {
            Text(title, style = style(22.sp), maxLines = 1)
            Text(line, style = style(14.sp, Secondary), maxLines = 1)
            Spacer(GlanceModifier.height(8.dp))
            Column(GlanceModifier.fillMaxWidth().defaultWeight().cornerRadius(16.dp).background(Screen).padding(horizontal = 16.dp),
                horizontalAlignment = Alignment.CenterHorizontally, verticalAlignment = Alignment.CenterVertically) {
                if (plus) { PlusLabel(); Spacer(GlanceModifier.height(8.dp)) }
                Text(note, style = style(12.sp, Secondary).copy(textAlign = TextAlign.Center), maxLines = 3)
            }
        }
    }
}

/** Between This week's day cells: room for today's ring, which sits 3 outside its cell. */
private const val WEEK_GAP = 6f

/**
 * One of This week's days, as Progress draws it (DayCell.kt, Figma's Day cell): the square in the habit's colours with
 * its sign, the dashed edge of a day with no goal, today's ring. Drawn from the widget's own parts rather than a picture,
 * so each colour is a light and dark pair like the rest of the widget ([LocalNight]). [side] picks Figma's size
 * (Year, Small or Week) for the corners and signs, scaled.
 */
@Composable
private fun DayBox(cell: Int, today: Boolean, side: Dp, light: DayCellColors, dark: DayCellColors) {
    val kind = when {
        side.value >= 32f -> floatArrayOf(36f, 8f, 22f, 18f, 16f)
        side.value >= 26f -> floatArrayOf(28f, 7f, 17f, 14f, 12f)
        else -> floatArrayOf(24f, 6f, 16f, 12f, 12f)
    }
    val scale = side.value / kind[0]
    val corner = (kind[1] * scale).dp
    @Composable fun sign(glyph: Int, size: Float, day: Color, night: Color) =
        Image(ImageProvider(glyph), null, GlanceModifier.size((size * scale).dp), colorFilter = ColorFilter.tint(pair(day, night)))
    // The grey days sit on the week's panel (Surface container), where the app's grey (Surface container high) all but
    // disappears in light mode: Surface dim there, as Figma's This week (the user, 2 Nov 2026).
    val grey = AppColors.lightRoles.surfaceDim
    @Composable fun square(day: Color, night: Color, content: @Composable () -> Unit = {}) =
        Box(GlanceModifier.size(side).cornerRadius(corner).background(pair(day, night)), contentAlignment = Alignment.Center) { content() }
    Box(GlanceModifier.size(side + WEEK_GAP.dp), contentAlignment = Alignment.Center) {
        if (today) Image(ImageProvider(R.drawable.w_day_ring), null, GlanceModifier.size(side + WEEK_GAP.dp), colorFilter = ColorFilter.tint(pair(light.ring, dark.ring)))
        when (cell) {
            WidgetCell.BLANK -> {}
            WidgetCell.UPCOMING -> square(grey, dark.grey)
            WidgetCell.NOT_SCHEDULED -> Image(ImageProvider(R.drawable.w_day_dashed), null, GlanceModifier.size(side), colorFilter = ColorFilter.tint(pair(light.dash, dark.dash)))
            WidgetCell.SKIPPED -> square(grey, dark.grey) { sign(R.drawable.ic_w_redo, kind[4], light.sign, dark.sign) }
            WidgetCell.PAUSED -> square(grey, dark.grey) { sign(R.drawable.ic_w_pause, kind[4], light.sign, dark.sign) }
            0 -> square(grey, dark.grey) { sign(R.drawable.ic_w_close, kind[3], light.sign, dark.sign) }
            1, 2, 3 -> square(light.part, dark.part)
            4 -> square(light.done, dark.done) { sign(R.drawable.ic_w_check, kind[2], light.check, dark.check) }
            else -> square(light.more, dark.more) { sign(R.drawable.ic_w_check, kind[2], light.checkOnMore, dark.checkOnMore) }
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
        kind.plus && !snapshot.plus -> return ListMessage(title, "See your whole day here with Plus", "Tap to open the app", null,
            actionRunCallback<WidgetOpenAction>(actionParametersOf(TapKeys.ROUTE to "today")), plus = true)
        rows.isEmpty() && frame.items.none { !it.isTask == !kind.tasks } -> return Message(kind, if (kind.tasks) "No tasks today" else "No habits yet",
            if (kind.tasks) "Add one in the app" else "Start one in the app", null, header = title)
        rows.isEmpty() -> return Message(kind, if (section != null) "Nothing planned in $title" else if (kind.tasks) "No tasks today" else "Nothing planned for today",
            if (section != null) "Open $title" else "Open Today", null, header = title)
    }
    // Figma's two rows on a 4×2 and five on a 4×4; fewer where the launcher's cells are shorter than Figma's card.
    val card = LocalCard.current.height.value
    val perPage = if (kind.large) ((card - 80f + 2f) / 58f).toInt().coerceIn(1, 5) else ((card - 56f + 4f) / 60f).toInt().coerceIn(1, 2)
    val pages = (rows.size + perPage - 1) / perPage
    val shown = page.coerceIn(0, pages - 1)
    Column(GlanceModifier.fillMaxSize()) {
        Header(kind.large, title, doneText, shown, pages, frame.day)
        if (kind.large) Spacer(GlanceModifier.height(8.dp))
        // 4 between the rows on a 4×2, 2 on a 4×4 (Figma).
        // The rows in a column of their own: a Glance container holds at most 10 children (five rows and their gaps
        // beside the header and its gap were 11, and the fifth row was dropped).
        Column(GlanceModifier.fillMaxWidth()) {
            rows.drop(shown * perPage).take(perPage).forEachIndexed { i, item ->
                ListRow(item, frame, showPlace = section == null && !kind.tasks, top = if (i == 0) 0.dp else if (kind.large) 2.dp else 4.dp)
            }
        }
    }
}

/**
 * A list widget's header (Figma 1240:488), 8 in. On a 4×2, 28 tall: the title (the day, a time of day or Tasks; Title
 * Medium, 16 sp) and, at the end, its count chip ("2 of 5 done": Label Medium, On surface variant, on Surface container
 * high, 10 corners, 8 at the sides and 2 above and under). On a 4×4 ([large]), 48 tall: the title in Title Large (22 sp)
 * over the count, and, with more than one page, the pager: ‹ (48), "1/2" (Label Medium, On surface variant), ›. On a
 * 4×2 the pager follows the chip in the same row, its arrows 40 wide; they take the 6 under the row too, which a 4×2's
 * header and rows keep between them, for a larger touch.
 */
@Composable
private fun Header(large: Boolean, title: String, done: String?, page: Int, pages: Int, day: Int = 0) {
    if (large) {
        Row(GlanceModifier.fillMaxWidth().height(48.dp).padding(start = 8.dp), verticalAlignment = Alignment.CenterVertically) {
            Column(GlanceModifier.defaultWeight()) {
                Text(title, style = style(22.sp), maxLines = 1)
                done?.let { Text(it, style = style(12.sp, Secondary, FontWeight.Medium)) }
            }
            if (pages > 1) {
                PageArrow(R.drawable.ic_w_left, -1, page > 0, "Previous page", day)
                Text("${page + 1}/$pages", style = style(12.sp, Secondary, FontWeight.Medium))
                PageArrow(R.drawable.ic_w_right, 1, page < pages - 1, "Next page", day)
            }
        }
    } else {
        Row(GlanceModifier.fillMaxWidth().height(34.dp).padding(start = 8.dp)) {
            Row(GlanceModifier.defaultWeight().height(28.dp), verticalAlignment = Alignment.CenterVertically) {
                Text(title, GlanceModifier.defaultWeight(), style = style(16.sp, weight = FontWeight.Medium), maxLines = 1)
                done?.let { Text(it, GlanceModifier.cornerRadius(10.dp).background(Tonal2).padding(horizontal = 8.dp, vertical = 2.dp), style = style(12.sp, Secondary, FontWeight.Medium)) }
            }
            if (pages > 1) {
                PageArrow(R.drawable.ic_w_left, -1, page > 0, "Previous page", day, compact = true)
                Box(GlanceModifier.height(28.dp), contentAlignment = Alignment.Center) {
                    Text("${page + 1}/$pages", style = style(12.sp, Secondary, FontWeight.Medium))
                }
                PageArrow(R.drawable.ic_w_right, 1, page < pages - 1, "Next page", day, compact = true)
            }
        }
    }
}

/**
 * A pager arrow: Figma's Standard icon button (48, its chevron 24 in On surface variant); [compact], a 4×2's, 40 wide
 * and 34 tall with its chevron in the top 28. Figma draws both arrows alike on the first and last page; the one with
 * nowhere to go takes no tap (Decisions needed D-31).
 */
@Composable
private fun PageArrow(glyph: Int, delta: Int, enabled: Boolean, label: String, day: Int, compact: Boolean = false) {
    val size = if (compact) GlanceModifier.width(40.dp).height(34.dp).padding(bottom = 6.dp) else GlanceModifier.size(48.dp)
    Box(size.let { if (enabled) it.clickable(actionRunCallback<WidgetPageAction>(actionParametersOf(TapKeys.DELTA to delta, TapKeys.DAY to day))) else it }
        .semantics { contentDescription = label }, contentAlignment = Alignment.Center) {
        Image(ImageProvider(glyph), null, GlanceModifier.size(24.dp), colorFilter = ColorFilter.tint(Secondary))
    }
}

/**
 * 5.10.3, **Widget · List row** (Figma 1238:429): one habit or task in the Today and Tasks widgets, 56 tall with 12
 * corners and no background of its own, today's fill behind it ([RowFill]); 8 at the sides, 12 between: the habit's
 * icon (32), its name (Label Large, On surface) over its line (Body Small, On surface variant: "Anytime · 3 of 8
 * glasses", a quit run's or a timer's clock), the streak (the phone's 🔥 and the count, Label Medium; tasks have none)
 * and the round button (40, in a 48 touch target, so the row's end keeps 4). A tap on the row opens its day.
 */
@Composable
private fun ListRow(item: WidgetItem, frame: WidgetFrame, showPlace: Boolean, top: Dp = 0.dp) {
    val width = LocalCard.current.width - 24.dp
    val dayClick = actionRunCallback<WidgetOpenAction>(actionParametersOf(TapKeys.ROUTE to item.routeOrDay, TapKeys.DAY to frame.day))
    Box(GlanceModifier.fillMaxWidth().padding(top = top)) {
    Box(GlanceModifier.fillMaxWidth().height(56.dp).cornerRadius(12.dp)) {
        RowFill(item, width)
        Row(GlanceModifier.fillMaxSize().clickable(dayClick).padding(start = 8.dp, end = 4.dp).semantics { contentDescription = spoken(item) },
            verticalAlignment = Alignment.CenterVertically) {
            Icon(item, 32.dp)
            Spacer(GlanceModifier.width(12.dp))
            Column(GlanceModifier.defaultWeight()) {
                if (item.name.isNotEmpty()) Text(item.name, style = style(14.sp, weight = FontWeight.Medium), maxLines = 1)
                when {
                    // The milestone's words in the band's colour for the rest of the day (Figma WL.2).
                    item.milestone != null -> Text(item.milestone, style = style(12.sp, bandInk(item.color)), maxLines = 1)
                    item.quitStart != null -> Row { QuitClock(item, 12.sp, SecondaryTone); item.quitBestText?.let { Text(" · $it", style = style(12.sp, Secondary), maxLines = 1) } }
                    item.timerClock != null -> TimerClock(item, 12.sp, SecondaryTone)
                    else -> Text(if (showPlace) item.todayLine.ifEmpty { item.line } else item.line, style = style(12.sp, Secondary), maxLines = 1)
                }
            }
            // 12 to the streak, and 12 from it to the button's circle (8 here and the 4 inside its touch target).
            item.streak?.let { Spacer(GlanceModifier.width(12.dp)); Streak(it, 12.sp, FontWeight.Medium) }
            Spacer(GlanceModifier.width(8.dp))
            RoundButton(item, frame)
        }
    }
    }
}

// ------------------------------------------------------------------ Parts

/**
 * 5.10.2, **Widget row fill** (Figma 1238:428): how far a list row is toward today's goal, drawn behind the row from its
 * start in the habit's Fill colour, the row [width] wide when done. A cut-down row (a limit) and a quit row never fill
 * (A41: Figma's Coffee row is Value 0). Figma draws it in steps of 10, like Linear progress; the row keeps the exact share.
 */
@Composable
private fun RowFill(item: WidgetItem, width: Dp) {
    if (item.limitFill || item.quitStart != null) return
    val share = if (item.done) 1.0 else (item.fraction ?: return).coerceIn(0.0, 1.0)
    // Full is the whole row, whatever its width; a share is of the card's width as the launcher reports it.
    if (share >= 1) Box(GlanceModifier.fillMaxSize().background(fill(item.color))) {}
    else if (share > 0) Box(GlanceModifier.width(width * share.toFloat()).fillMaxHeight().background(fill(item.color))) {}
}

@Composable
private fun Icon(item: WidgetItem, size: Dp) {
    if (item.medal != null) return MedalIcon(item.color, item.medal, size)
    val context = LocalContext.current
    val px = (size.value * context.resources.displayMetrics.density).toInt()
    // The habit colours are the same in both modes (AppColors), so one picture serves both.
    Image(ImageProvider(HabitIconBitmaps.get(item.symbol, item.color, false, px)), null, GlanceModifier.size(size))
}

/**
 * A habit's medal in its icon's place (Figma's widgets · milestones): the app's medal as a picture ([MedalBitmaps]), in
 * the widget's mode, and its [number] in white over it (Title Medium at 40, smaller with three digits or more).
 */
@Composable
private fun MedalIcon(color: String, number: String?, size: Dp) {
    val context = LocalContext.current
    val px = (size.value * context.resources.displayMetrics.density).toInt()
    val dark = LocalNight.current ?: isPhoneDark()
    Box(GlanceModifier.size(size), contentAlignment = Alignment.Center) {
        Image(ImageProvider(MedalBitmaps.get(color, dark, px)), null, GlanceModifier.size(size))
        if (number != null) {
            val shrink = when { number.length >= 4 -> 0.62f; number.length == 3 -> 0.8f; else -> 1f }
            Text(number, style = TextStyle(fontSize = (size.value * 0.4f * shrink).sp, color = White, fontWeight = FontWeight.Medium), maxLines = 1)
        }
    }
}

/** The milestone band's words: the habit's colour, darker in light and lighter in dark (Today's band, bandInk). */
@Composable
private fun bandInk(key: String): ColorProvider {
    val c = HabitColor.of(key) ?: HabitColor.BLUE
    return pair(Color.Black.copy(alpha = 0.35f).compositeOver(L.habit(c)), Color.White.copy(alpha = 0.75f).compositeOver(D.habit(c)))
}

/**
 * Today's milestone in the bar's place (Figma's widgets · milestones: "30 days in a row", "30 days clean"): 20 tall, 10
 * corners, the habit's Band, a small medal and the words (Label Medium) in [bandInk].
 */
@Composable
private fun MilestoneBand(item: WidgetItem, words: String) {
    val c = HabitColor.of(item.color) ?: HabitColor.BLUE
    Row(GlanceModifier.fillMaxWidth().height(20.dp).cornerRadius(10.dp).background(pair(L.habitBand(c), D.habitBand(c))).padding(horizontal = 8.dp),
        horizontalAlignment = Alignment.CenterHorizontally, verticalAlignment = Alignment.CenterVertically) {
        MedalIcon(item.color, null, 12.dp)
        Spacer(GlanceModifier.width(4.dp))
        Text(words, style = style(12.sp, bandInk(item.color), FontWeight.Medium), maxLines = 1)
    }
}

/** A streak: the phone's own 🔥 (emoji are the phone's, as Figma draws them) and the count, 2 apart, in On surface. */
@Composable
private fun Streak(text: String, size: TextUnit = 15.sp, weight: FontWeight = FontWeight.Normal) {
    Row(verticalAlignment = Alignment.CenterVertically) {
        Text("🔥", style = style(12.sp, weight = FontWeight.Medium))
        Spacer(GlanceModifier.width(2.dp))
        Text(text, style = style(size, weight = weight))
    }
}

/**
 * Today's progress (Figma's Linear progress, Flat, 8 tall, A98): the habit's colour, 4 apart from the track (Secondary
 * container), both fully round, with no stop dot; neutral for a limit (U2, U25). Glance's own bar has no gap, so it's
 * drawn from boxes; [span] is the bar's width as the launcher reports the card's, and the track takes whatever is really
 * left.
 */
@Composable
private fun Bar(item: WidgetItem, span: Dp) {
    val share = ((item.cardFraction ?: item.fraction) ?: return).coerceIn(0.0, 1.0).toFloat()
    val color = if (item.limitFill) Secondary else habit(item.color)
    val h = 8.dp
    Row(GlanceModifier.fillMaxWidth().height(h), verticalAlignment = Alignment.CenterVertically) {
        if (share >= 1f) { Box(GlanceModifier.fillMaxWidth().fillMaxHeight().cornerRadius(h / 2).background(color)) {}; return@Row }
        if (share > 0f) {
            Box(GlanceModifier.width(((span.value - 4f) * share).coerceAtLeast(h.value).dp).fillMaxHeight().cornerRadius(h / 2).background(color)) {}
            Spacer(GlanceModifier.width(4.dp))
        }
        Box(GlanceModifier.defaultWeight().fillMaxHeight().cornerRadius(h / 2).background(Tonal)) {}
    }
}

/**
 * The card's one button (48 dp target, 40 dp circle): tonal grey before the goal is met, the habit's colour with white
 * once it is (U2, U14). LOCKED (widget taps): ✓ and + log on the widget; ▶/⏸ start and stop the timer there (W7);
 * anything needing a screen opens it (W8).
 */
@Composable
private fun RoundButton(item: WidgetItem, frame: WidgetFrame) {
    // Every kind fills once its goal is met, a running ⏸ too (Figma's widgets, A91); a limit never does.
    val filled = item.done && !item.limit
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
private fun QuitClock(item: WidgetItem, size: TextUnit, tone: Tone) {
    val color = tone.provider()
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
        Chronometer(SystemClock.elapsedRealtime() - inDay, size, tone)
    }
}

/** A running timer's clock and its goal, "6:24 of 10 min". */
@Composable
private fun TimerClock(item: WidgetItem, size: TextUnit, tone: Tone, withGoal: Boolean = true) {
    val color = tone.provider()
    val clock = item.timerClock ?: return
    Row(verticalAlignment = Alignment.CenterVertically) {
        Chronometer(SystemClock.elapsedRealtime() - (System.currentTimeMillis() - clock), size, tone)
        // The goal's words come whole from the app ("of 20 min").
        if (withGoal) item.timerGoal?.let { Text(" " + it.trim(), style = style(size, color), maxLines = 1) }
    }
}

@Composable
private fun Chronometer(base: Long, size: TextUnit, tone: Tone) {
    val context = LocalContext.current
    val night = LocalNight.current
    val views = RemoteViews(context.packageName, R.layout.widget_chronometer).apply {
        setChronometer(R.id.chronometer, base, null, true)
        setTextViewTextSize(R.id.chronometer, TypedValue.COMPLEX_UNIT_SP, size.value)
        // Its own view, outside Glance's colours: both modes on Android 12 and later, so it switches with the rest.
        if (night == null && android.os.Build.VERSION.SDK_INT >= 31) setColorInt(R.id.chronometer, "setTextColor", tone.day.toArgb(), tone.night.toArgb())
        else setTextColor(R.id.chronometer, (if (night ?: isPhoneDark()) tone.night else tone.day).toArgb())
    }
    AndroidRemoteViews(views)
}

/** The phone's own mode (not the app's: the app sets its own night mode to its Theme, A98). */
private fun isPhoneDark() =
    (android.content.res.Resources.getSystem().configuration.uiMode and Configuration.UI_MODE_NIGHT_MASK) == Configuration.UI_MODE_NIGHT_YES

/** What TalkBack says for a card: its name and line (W16). */
private fun spoken(item: WidgetItem): String = listOf(item.name, item.value.ifEmpty { item.line }).filter { it.isNotEmpty() }.joinToString(", ")

