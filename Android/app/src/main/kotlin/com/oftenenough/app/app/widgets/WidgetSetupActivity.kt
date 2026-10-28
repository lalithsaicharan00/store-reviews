package com.oftenenough.app.app.widgets

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import com.oftenenough.app.ui.components.PlusLabel
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.components.ButtonSize
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import android.appwidget.AppWidgetManager
import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.unit.dp
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.data.DaySection
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.pageSentence
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.newhabit.FormPage
import com.oftenenough.app.ui.newhabit.GroupTitle
import com.oftenenough.app.ui.theme.OftenEnoughTheme
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch

/**
 * Our setup screen (design §24), shown when a widget is added and from Android's Reconfigure: One habit and This week
 * choose a habit; Today and Tasks the whole day or one time of day. Text only, in the person's order. A Plus widget
 * without Plus says what it does without Plus and can be added either way (A13: it never blocks).
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
                        WidgetDisk.setChoice(this@WidgetSetupActivity, widgetId, choice)
                        setResult(RESULT_OK, Intent().putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId))
                        finish()
                    }
                }
            }
        }
    }

    @Composable
    private fun SetupScreen(kind: WidgetKind, store: HabitStore, current: String?, onClose: () -> Unit, onDone: (String) -> Unit) {
        val c = appColors
        val scope = rememberCoroutineScope()
        val title = when (kind) { WidgetKind.ONE_HABIT -> "One habit"; WidgetKind.WEEK -> "This week"; WidgetKind.TASKS, WidgetKind.TASKS_LARGE -> "Tasks"; else -> "Today" }
        var withoutPlus by rememberSaveable { mutableStateOf(false) }
        var chosen by rememberSaveable { mutableStateOf(current ?: if (kind.oneHabit) null else "all") }
        val save: (String) -> Unit = { choice ->
            onDone(choice)
            scope.launch { WidgetPublisher.publish(applicationContext, store) }
        }
        if (!store.isLoaded) { Box(Modifier.fillMaxSize().background(c.screen)); return }
        if (kind.plus && !store.isPlus && !withoutPlus) {
            Box(Modifier.fillMaxSize().background(c.screen)) {
                FormPage(title, chip = null, onBack = onClose, close = true) {
                    Spacer(Modifier.height(8.dp))
                    Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(28.dp)).background(c.surface).padding(24.dp)) {
                        // Figma's Plus card heading: the Plus label (3.3), 8 before the title.
                        Row(horizontalArrangement = Arrangement.spacedBy(8.dp), verticalAlignment = Alignment.CenterVertically) {
                            PlusLabel()
                            Text("$title is a Plus widget", Modifier.weight(1f, fill = false), style = MaterialTheme.typography.titleLarge, color = c.ink)
                        }
                        Spacer(Modifier.height(12.dp))
                        Text(if (kind == WidgetKind.WEEK) "With Plus, you see one habit's whole week and log it right from the widget."
                            else "With Plus, you tick habits off right from the widget, and see the whole day or one part of it.",
                            style = MaterialTheme.typography.bodyLarge, color = c.secondary)
                        Spacer(Modifier.height(12.dp))
                        Text(if (kind == WidgetKind.WEEK) "Without it, the widget opens the habit in the app. You can add it either way."
                            else "Without it, the widget shows how many are done and opens Today. You can add it either way.",
                            style = MaterialTheme.typography.bodyLarge, color = c.secondary)
                    }
                }
                Column(Modifier.align(Alignment.BottomCenter).fillMaxWidth().navigationBarsPadding().padding(16.dp)) {
                    AppButton("Get Plus" + (AppGraph.plus.price(com.oftenenough.app.app.PlusProduct.PLUS)?.let { " · $it" } ?: ""), {
                        startActivity(Intent(this@WidgetSetupActivity, MainActivity::class.java).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                            .putExtra(MainActivity.WIDGET_ROUTE, "plus"))
                    }, Modifier.fillMaxWidth().semantics { testTag = "setup-get-plus" }, size = ButtonSize.Medium)
                    Spacer(Modifier.height(8.dp))
                    AppButton("Add without Plus", { withoutPlus = true }, Modifier.fillMaxWidth().semantics { testTag = "setup-without-plus" }, style = ButtonStyle.Tonal, size = ButtonSize.Medium)
                }
            }
            return
        }
        Box(Modifier.fillMaxSize().background(c.screen)) {
            FormPage(title, chip = null, onBack = onClose, close = true) {
                GroupTitle("Show")
                if (kind.oneHabit) {
                    val habits = store.habits.filter { !it.archived && it.kind != HabitKind.Task }
                    if (habits.isEmpty()) Text("No habits yet. Add one in the app, then choose it here.", Modifier.padding(16.dp),
                        style = MaterialTheme.typography.bodyLarge, color = c.secondary)
                    SegmentedList {
                        habits.forEachIndexed { i, h ->
                            Choice(h.name, store.pageSentence(h), "habit:${h.id}" == chosen, i, habits.size, "setup-habit-${h.name}",
                                icon = { HabitIcon(h.symbol, h.color) }) { chosen = "habit:${h.id}" }
                        }
                    }
                } else {
                    val members = store.rules.cardMembers()
                    val cards = store.todayCards().filter { !kind.tasks || it != DaySection.QUITTING }
                    SegmentedList {
                        val n = cards.size + 1
                        Choice(if (kind.tasks) "All of today" else "All of today", if (kind.tasks) "Every task for today" else "Every habit planned for today",
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
                Spacer(Modifier.height(96.dp))
            }
            AppButton("Add widget", { chosen?.let(save) }, Modifier.align(Alignment.BottomCenter).fillMaxWidth().navigationBarsPadding().padding(16.dp)
                .semantics { testTag = "setup-add" }, size = ButtonSize.Medium, enabled = chosen != null)
        }
    }

    @Composable
    private fun Choice(title: String, line: String, selected: Boolean, index: Int, count: Int, tag: String, icon: (@Composable () -> Unit)? = null, onClick: () -> Unit) =
        AppListItem(title, index, count, supporting = line, headlineLines = 1, leading = icon, onClick = onClick, tag = tag,
            trailing = { androidx.compose.material3.RadioButton(selected, null) })
}
