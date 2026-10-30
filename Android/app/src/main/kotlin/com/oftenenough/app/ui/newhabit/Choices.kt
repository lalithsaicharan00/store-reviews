@file:OptIn(androidx.compose.material3.ExperimentalMaterial3Api::class)

package com.oftenenough.app.ui.newhabit

import com.oftenenough.app.ui.components.SegmentedListGap
import com.oftenenough.app.ui.components.ListExample
import com.oftenenough.app.ui.components.ListChevron
import com.oftenenough.app.ui.components.ListAvatar
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.theme.Symbols
import androidx.compose.foundation.layout.WindowInsets
import com.oftenenough.app.ui.components.NavigationIcon
import com.oftenenough.app.ui.components.AppTopBar
import androidx.compose.ui.semantics.heading
import androidx.compose.foundation.border
import com.oftenenough.app.ui.theme.AppType

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.components.segmentShape
import androidx.compose.material3.MaterialTheme

/** What the person wants to make (the iPhone's `ItemType`): the form each choice opens. */
enum class ItemType(val title: String, val summary: String, val example: String, val namePlaceholder: String) {
    CHECK("Check it off", "Done or not done.", "e.g. Make your bed", "Name, e.g. Make bed"),
    AMOUNT("Track an amount", "How many or how much.", "e.g. 8 glasses of water", "Name, e.g. Drink water"),
    TIME("Time it", "How long, with a timer.", "e.g. Meditate 10 min", "Name, e.g. Meditate"),
    CHECKLIST("Checklist", "A short list to tick off.", "e.g. Clean kitchen", "Name, e.g. Clean kitchen"),
    CUT_DOWN("Cut down", "Set a maximum and log how much.", "e.g. Coffee, 2 a day", "Name, e.g. Coffee"),
    QUIT("Quit", "Stop completely. Track the time since you stopped.", "e.g. Smoking", "e.g. Smoking"),
    TASK("Task", "Something to get done.", "e.g. Pay the rent", "e.g. Pay the rent");

    val isHabit: Boolean get() = this != TASK
    val isBuild: Boolean get() = this in setOf(CHECK, AMOUNT, TIME, CHECKLIST)

    companion object {
        fun of(habit: com.oftenenough.app.data.Habit): ItemType = when (habit.kind) {
            com.oftenenough.app.data.HabitKind.Check -> CHECK
            is com.oftenenough.app.data.HabitKind.Amount -> if (habit.atMost) CUT_DOWN else AMOUNT
            com.oftenenough.app.data.HabitKind.Duration -> if (habit.atMost) CUT_DOWN else TIME
            com.oftenenough.app.data.HabitKind.Checklist -> CHECKLIST
            com.oftenenough.app.data.HabitKind.Quit -> QUIT
            com.oftenenough.app.data.HabitKind.Task -> TASK
        }
    }
}

fun icon(type: ItemType): ImageVector = when (type) {
    ItemType.CHECK -> Symbols.CheckCircle
    ItemType.AMOUNT -> Symbols.Tag
    ItemType.TIME -> Symbols.Timer
    ItemType.CHECKLIST -> Symbols.Checklist
    ItemType.CUT_DOWN -> Symbols.Speed
    ItemType.QUIT -> Symbols.Block
    ItemType.TASK -> Symbols.EventAvailable
}

/**
 * A choice (Figma's Create new pages): a two-line List item on Surface bright, its icon in the avatar (Surface container
 * highest), the name in Title Medium, one line in Body Medium On surface variant, an example tag (Show example), ›.
 */
@Composable
fun ChoiceCard(icon: ImageVector, title: String, line: String, example: String?, index: Int, count: Int, tag: String, onClick: () -> Unit) =
    AppListItem(
        title, index, count, Modifier, line,
        leading = { ListAvatar(icon) }, trailing = { ListChevron() }, onClick = onClick, tag = tag,
        below = example?.let { { ListExample(it) } }, containerColor = MaterialTheme.colorScheme.surfaceBright,
    )

/**
 * A choice page (Figma's What do you want to do?): on Surface container, the Top app bar with ✕ or ← and no title; then
 * the content, 16 at the sides and 24 under, 24 apart: the question in Headline Small Emphasized On surface, its only
 * heading, over the choices, 2 apart.
 */
@Composable
fun ChoicePage(question: String, close: Boolean, onBack: () -> Unit, content: @Composable () -> Unit) {
    val s = MaterialTheme.colorScheme
    Column(Modifier.fillMaxSize().background(s.surfaceContainer).statusBarsPadding().navigationBarsPadding()) {
        AppTopBar(null, navigationIcon = {
            if (close) NavigationIcon(Symbols.Close, "Close", onBack, Modifier.semantics { testTag = "page-back" })
            else NavigationIcon(Symbols.ArrowBack, "Back", onBack, Modifier.semantics { testTag = "page-back" })
        }, windowInsets = WindowInsets(0))
        Column(Modifier.verticalScroll(rememberScrollState()).padding(start = 16.dp, end = 16.dp, bottom = 24.dp), verticalArrangement = Arrangement.spacedBy(24.dp)) {
            Text(question, Modifier.semantics { heading() }, style = AppType.headlineSmallEmphasized, color = s.onSurface)
            Column(verticalArrangement = Arrangement.spacedBy(SegmentedListGap)) { content() }
        }
    }
}

/**
 * 5.7.1, **What do you want to do?** (Figma 1061:2016; Components — Atoms Build Plan): New's first page, from every +.
 * The choice page with ✕: Build or maintain (trending_up, "A habit you want to start or keep doing."), Quit or cut down
 * (trending_down, "A habit you want to stop or do less.") and Add a task (event_available, "Something to get done, once
 * or on repeat."), each opening its next page.
 */
@Composable
fun NewChoices(onClose: () -> Unit, onBuild: () -> Unit, onQuit: () -> Unit, onTask: () -> Unit) {
    ChoicePage("What do you want to do?", close = true, onBack = onClose) {
        ChoiceCard(Symbols.TrendingUp, "Build or maintain", "A habit you want to start or keep doing.", null, 0, 3, "new-build", onClick = onBuild)
        ChoiceCard(Symbols.TrendingDown, "Quit or cut down", "A habit you want to stop or do less.", null, 1, 3, "new-quit", onClick = onQuit)
        ChoiceCard(icon(ItemType.TASK), "Add a task", "Something to get done, once or on repeat.", null, 2, 3, "new-task", onClick = onTask)
    }
}

/**
 * 5.7.14, **What kind of task?** (Figma 1109:2; Components — Atoms Build Plan), from Add a task and Tasks' +. The choice
 * page with ←: Once (event, "On one day, or with no date.", "e.g. Pick up parcel") and On repeat (event_repeat, "Comes
 * back on the days you pick, or a while after it’s done.", "e.g. Water plants, every 3 days"), each opening its task
 * form: Once with its Date, On repeat with How often, Starts and Ends. The form has no Repeat row.
 */
@Composable
fun TaskKinds(onBack: () -> Unit, onPick: (repeats: Boolean) -> Unit) {
    ChoicePage("What kind of task?", close = false, onBack = onBack) {
        ChoiceCard(Symbols.Event, "Once", "On one day, or with no date.", "e.g. Pick up parcel", 0, 2, "task-once") { onPick(false) }
        ChoiceCard(Symbols.EventRepeat, "On repeat", "Comes back on the days you pick, or a while after it’s done.", "e.g. Water plants, every 3 days", 1, 2, "task-repeat") { onPick(true) }
    }
}

@Composable
fun TypeChoices(question: String, types: List<ItemType>, onBack: () -> Unit, onPick: (ItemType) -> Unit) {
    ChoicePage(question, close = false, onBack = onBack) {
        types.forEachIndexed { i, t -> ChoiceCard(icon(t), t.title, t.summary, t.example, i, types.size, "type-${t.name.lowercase()}") { onPick(t) } }
    }
}
