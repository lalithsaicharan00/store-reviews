package com.oftenenough.app.app.widgets

import android.appwidget.AppWidgetManager
import android.content.Intent
import android.os.Bundle
import android.widget.FrameLayout
import android.widget.RemoteViews
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
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
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.requiredSize
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.RadioButton
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.input.pointer.PointerEventPass
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.unit.DpSize
import androidx.compose.ui.unit.dp
import androidx.compose.ui.viewinterop.AndroidView
import androidx.glance.appwidget.ExperimentalGlanceRemoteViewsApi
import androidx.glance.appwidget.GlanceRemoteViews
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.data.DaySection
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HabitCopy
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.pageSentence
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.components.ButtonSize
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.PlusLabel
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.newhabit.FormPage
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.OftenEnoughTheme
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch

/**
 * 5.10.6, **Widget setup** (Figma 1252:3618: One habit, One habit · change, Today, Tasks, This week, and Today and This
 * week on the free plan): Android's configuration activity, shown when a widget is added and again from Reconfigure.
 * On Surface container: the Top app bar (← and the widget's name; ← leaves without adding); then, scrolling, 8 above, 16
 * at the sides, 16 between: the preview (the real widget, drawn by Glance, on a gradient of the blue and orange Fills,
 * 28 corners, 24 above and under; a 4×2 at 90 %), "Show" (Label Large, On surface variant) and the choices, one List of
 * List items on Surface bright with a Radio button at the end: a habit for One habit and This week (its icon, its name,
 * its times of day and goal: "Anytime · 8 glasses a day"); for Today and Tasks the whole day or one time of day ("From 6
 * AM · 3 habits"). At the bottom, on Surface container, 16 all round: **Add widget** (Filled, Medium), or **Save** when
 * changing a widget already placed.
 *
 * Free plan (Today and This week are Plus, A73): the preview shows the widget as it looks with Plus, then the Plus card
 * (Surface container lowest, 24 corners, 20 in, 8 between: the Plus label and "Today’s list comes with Plus" in Title
 * Medium, then what Plus adds in Body Medium); the whole card opens the Plus screen. Add widget adds the free widget,
 * which opens the app (A13: it never blocks).
 */
class WidgetSetupActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        val widgetId = intent.getIntExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, AppWidgetManager.INVALID_APPWIDGET_ID)
        // Leaving without choosing keeps the widget as it was (it was optional to configure).
        setResult(RESULT_CANCELED, Intent().putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId))
        if (widgetId == AppWidgetManager.INVALID_APPWIDGET_ID) { finish(); return }
        AppGraph.open(applicationContext)
        val provider = AppWidgetManager.getInstance(this).getAppWidgetInfo(widgetId)?.provider?.className ?: ""
        val kind = when {
            provider.endsWith("OneHabitWidgetReceiver") -> WidgetKind.ONE_HABIT
            provider.endsWith("TodayLargeWidgetReceiver") -> WidgetKind.TODAY_LARGE
            provider.endsWith("TodayWidgetReceiver") -> WidgetKind.TODAY
            provider.endsWith("WeekWidgetReceiver") -> WidgetKind.WEEK
            provider.endsWith("TasksLargeWidgetReceiver") -> WidgetKind.TASKS_LARGE
            else -> WidgetKind.TASKS
        }
        setContent {
            OftenEnoughTheme(AppGraph.prefs.theme) {
                Box(Modifier.fillMaxSize().semantics { testTagsAsResourceId = true }) {
                    SetupScreen(kind, AppGraph.store, WidgetDisk.choice(this@WidgetSetupActivity, widgetId), onClose = ::finish) { choice ->
                        choice?.let { WidgetDisk.setChoice(this@WidgetSetupActivity, widgetId, it) }
                        setResult(RESULT_OK, Intent().putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId))
                        finish()
                    }
                }
            }
        }
    }

    @Composable
    private fun SetupScreen(kind: WidgetKind, store: HabitStore, current: String?, onClose: () -> Unit, onDone: (String?) -> Unit) {
        val c = appColors
        val scope = rememberCoroutineScope()
        val title = when (kind) { WidgetKind.ONE_HABIT -> "One habit"; WidgetKind.WEEK -> "This week"; WidgetKind.TASKS, WidgetKind.TASKS_LARGE -> "Tasks"; else -> "Today" }
        if (!store.isLoaded) { Box(Modifier.fillMaxSize().background(c.screen)); return }
        val habits = store.habits.filter { !it.archived && it.kind != HabitKind.Task }
        val free = kind.plus && !store.isPlus
        var chosen by rememberSaveable { mutableStateOf(current ?: if (kind.oneHabit) null else "all") }
        // On the free plan This week shows no choices: the free widget says where one habit stands, so it takes the
        // first in the person's order (or the one it had).
        val choice = chosen ?: if (free) habits.firstOrNull()?.let { "habit:${it.id}" } else null
        val save: () -> Unit = {
            onDone(choice)
            scope.launch { WidgetPublisher.publish(applicationContext, store) }
        }
        Column(Modifier.fillMaxSize().background(c.screen)) {
            Box(Modifier.weight(1f)) {
                FormPage(title, onBack = onClose) {
                    Spacer(Modifier.height(8.dp))
                    Preview(kind, choice, withPlus = free)
                    Spacer(Modifier.height(16.dp))
                    if (free) PlusCard(kind) else {
                        Text("Show", style = AppType.labelLarge, color = c.secondary)
                        Spacer(Modifier.height(16.dp))
                        if (kind.oneHabit) {
                            if (habits.isEmpty()) Text("No habits yet. Add one in the app, then choose it here.", Modifier.padding(horizontal = 16.dp),
                                style = AppType.bodyLarge, color = c.secondary)
                            SegmentedList {
                                habits.forEachIndexed { i, h ->
                                    Choice(h.name, habitLine(store, h), "habit:${h.id}" == chosen, i, habits.size, "setup-habit-${h.name}",
                                        icon = { HabitIcon(h.symbol, h.color, 40.dp, glyph = 0.6f) }) { chosen = "habit:${h.id}" }
                                }
                            }
                        } else {
                            val members = store.rules.cardMembers()
                            val cards = store.todayCards().filter { !kind.tasks || it != DaySection.QUITTING }
                            SegmentedList {
                                val n = cards.size + 1
                                Choice(if (kind.tasks) "All of today’s tasks" else "All of today", if (kind.tasks) "Every task for today" else "Every habit planned for today",
                                    chosen == "all", 0, n, "setup-all") { chosen = "all" }
                                cards.forEachIndexed { i, card ->
                                    val name = if (card == DaySection.QUITTING) "Quit or cut down" else store.section(card).name
                                    val count = (members[card] ?: emptyList()).mapNotNull { store.habit(it) }.count { (it.kind == HabitKind.Task) == kind.tasks && !it.archived }
                                    val starts = store.section(card).start?.takeIf { card != DaySection.QUITTING }?.let { "From " + DayWords.hourShort(it) + " · " } ?: ""
                                    val noun = if (kind.tasks) (if (count == 1) "task" else "tasks") else (if (count == 1) "habit" else "habits")
                                    Choice(name, "$starts$count $noun", chosen == "section:$card", i + 1, n, "setup-section-$name") { chosen = "section:$card" }
                                }
                            }
                        }
                    }
                }
            }
            Box(Modifier.fillMaxWidth().background(c.screen).navigationBarsPadding().padding(16.dp)) {
                AppButton(if (current != null) "Save" else "Add widget", save, Modifier.fillMaxWidth(), size = ButtonSize.Medium,
                    enabled = free || chosen != null, tag = "setup-add")
            }
        }
    }

    /** A habit's times of day and goal, as Figma's choices say it: "Anytime · 8 glasses a day", "Morning · every day". */
    private fun habitLine(store: HabitStore, h: Habit): String =
        if (h.kind == HabitKind.Quit) store.pageSentence(h)
        else h.parts.joinToString(", ") { store.section(it).name } + " · " + HabitCopy.plan(h, store.weekStart)

    /**
     * The widget as it will look, drawn by Glance itself ([GlanceRemoteViews]) from the app's own snapshot and the choice
     * being made, so it changes as the person chooses. On the free plan it's the widget as Plus shows it. A preview, not
     * a widget: it takes no touch (its buttons would log), and TalkBack reads it as one picture.
     */
    @OptIn(ExperimentalGlanceRemoteViewsApi::class)
    @Composable
    private fun Preview(kind: WidgetKind, choice: String?, withPlus: Boolean) {
        val context = LocalContext.current
        val c = appColors
        val size = when {
            kind == WidgetKind.ONE_HABIT -> DpSize(156.dp, 176.dp)
            kind.large -> DpSize(328.dp, 368.dp)
            else -> DpSize(328.dp, 176.dp)
        }
        // A 2×2 shows at its size; a 4×2 or 4×4 at 90 %, as Figma's 296 × 159.
        val scale = if (kind == WidgetKind.ONE_HABIT) 1f else 296f / 328f
        val glance = remember { GlanceRemoteViews() }
        var views by remember { mutableStateOf<RemoteViews?>(null) }
        LaunchedEffect(kind, choice, withPlus, AppGraph.store.habits) {
            val snapshot = WidgetDisk.read(context)?.let { if (withPlus) it.copy(plus = true) else it }
            views = runCatching { glance.compose(context, size) { WidgetPreview(kind, snapshot, choice) }.remoteViews }.getOrNull()
        }
        Box(
            Modifier.fillMaxWidth().clip(RoundedCornerShape(28.dp))
                .background(Brush.verticalGradient(listOf(c.fill(HabitColor.BLUE), c.fill(HabitColor.ORANGE)))).padding(vertical = 24.dp),
            contentAlignment = Alignment.Center,
        ) {
            Box(Modifier.size(size.width * scale, size.height * scale), contentAlignment = Alignment.Center) {
                views?.let { rv ->
                    AndroidView(
                        factory = { FrameLayout(it) },
                        update = { frame -> frame.removeAllViews(); runCatching { frame.addView(rv.apply(frame.context, frame)) } },
                        modifier = Modifier.requiredSize(size).graphicsLayer { scaleX = scale; scaleY = scale },
                    )
                }
                Box(Modifier.matchParentSize().semantics { contentDescription = "Preview of the widget" }.pointerInput(Unit) {
                    awaitPointerEventScope { while (true) awaitPointerEvent(PointerEventPass.Initial).changes.forEach { it.consume() } }
                })
            }
        }
    }

    /** The free plan's card: the Plus label and what the widget does with Plus; the whole card opens the Plus screen. */
    @Composable
    private fun PlusCard(kind: WidgetKind) {
        val c = appColors
        val week = kind == WidgetKind.WEEK
        Column(
            Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.surface)
                .clickable(role = Role.Button) {
                    startActivity(Intent(this, MainActivity::class.java).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK).putExtra(MainActivity.WIDGET_ROUTE, "plus"))
                }
                .semantics { testTag = "setup-plus-card" }.padding(20.dp),
            verticalArrangement = Arrangement.spacedBy(8.dp),
        ) {
            Row(horizontalArrangement = Arrangement.spacedBy(8.dp), verticalAlignment = Alignment.CenterVertically) {
                PlusLabel()
                Text(if (week) "This week comes with Plus" else "Today’s list comes with Plus", Modifier.weight(1f, fill = false),
                    style = AppType.titleMedium, color = c.ink)
            }
            Text(if (week) "With Plus, this widget shows one habit’s day and its week so far. Without Plus, it opens the app."
                else "With Plus, this widget shows your whole day or one part of it, and you tick habits off right from it. Without Plus, it opens Today.",
                style = AppType.bodyMedium, color = c.secondary)
        }
    }

    @Composable
    private fun Choice(title: String, line: String, selected: Boolean, index: Int, count: Int, tag: String, icon: (@Composable () -> Unit)? = null, onClick: () -> Unit) =
        AppListItem(title, index, count, supporting = line, headlineLines = 1, leading = icon, onClick = onClick, tag = tag,
            trailing = { RadioButton(selected, null) }, containerColor = MaterialTheme.colorScheme.surfaceBright)
}
