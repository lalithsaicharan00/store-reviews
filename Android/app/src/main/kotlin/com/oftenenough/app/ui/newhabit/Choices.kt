package com.oftenenough.app.ui.newhabit

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.size
import androidx.compose.material.icons.automirrored.outlined.TrendingDown
import androidx.compose.material.icons.automirrored.outlined.TrendingUp
import androidx.compose.material.icons.outlined.EventAvailable
import androidx.compose.material.icons.outlined.Block
import androidx.compose.material.icons.outlined.Speed
import androidx.compose.material.icons.outlined.Checklist
import androidx.compose.material.icons.outlined.Timer
import androidx.compose.material.icons.outlined.Tag
import androidx.compose.material.icons.outlined.CheckCircle
import androidx.compose.ui.semantics.heading
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.border
import com.oftenenough.app.ui.theme.AppType

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.ArrowBack
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowRight
import androidx.compose.material.icons.automirrored.rounded.TrendingDown
import androidx.compose.material.icons.automirrored.rounded.TrendingUp
import androidx.compose.material.icons.rounded.Block
import androidx.compose.material.icons.rounded.CheckCircle
import androidx.compose.material.icons.rounded.Checklist
import androidx.compose.material.icons.rounded.Close
import androidx.compose.material.icons.rounded.EventAvailable
import androidx.compose.material.icons.rounded.Speed
import androidx.compose.material.icons.rounded.Tag
import androidx.compose.material.icons.rounded.Timer
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.components.CookieIcon
import com.oftenenough.app.ui.components.segmentShape
import com.oftenenough.app.ui.theme.appColors

/** What the person wants to make (the iPhone's `ItemType`): the form each choice opens. */
enum class ItemType(val title: String, val summary: String, val example: String, val namePlaceholder: String) {
    CHECK("Check it off", "Done or not done.", "e.g. Make your bed", "Name, e.g. Make bed"),
    AMOUNT("Track an amount", "How many or how much.", "e.g. 8 glasses of water", "Name, e.g. Drink water"),
    TIME("Time it", "How long, with a timer.", "e.g. Meditate 10 min", "Name, e.g. Meditate"),
    CHECKLIST("Checklist", "A short list to tick off.", "e.g. Clean kitchen", "Name, e.g. Clean kitchen"),
    CUT_DOWN("Cut down", "Set a maximum and log how much.", "e.g. Coffee, 2 a day", "Name, e.g. Coffee"),
    QUIT("Quit", "Stop completely. Track time since you stopped.", "e.g. Smoking", "e.g. Smoking"),
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
    ItemType.CHECK -> Icons.Outlined.CheckCircle
    ItemType.AMOUNT -> Icons.Outlined.Tag
    ItemType.TIME -> Icons.Outlined.Timer
    ItemType.CHECKLIST -> Icons.Outlined.Checklist
    ItemType.CUT_DOWN -> Icons.Outlined.Speed
    ItemType.QUIT -> Icons.Outlined.Block
    ItemType.TASK -> Icons.Outlined.EventAvailable
}

/**
 * A choice card (Figma 1–3, 6.3): the icon outlined in a 40 dp rounded tile, the name (Title Medium), one line, an
 * example chip, ›. [outlined]: the one chosen now (Edit's "Current type").
 */
@Composable
fun ChoiceCard(icon: ImageVector, title: String, line: String, example: String?, index: Int, count: Int, tag: String, outlined: Boolean = false, onClick: () -> Unit) {
    val c = appColors
    val shape = segmentShape(index, count)
    Row(Modifier.fillMaxWidth().clip(shape).background(c.surface).then(if (outlined) Modifier.border(2.dp, c.ink, shape) else Modifier)
        .clickable(onClick = onClick).semantics { testTag = tag }.padding(start = 16.dp, end = 12.dp, top = 16.dp, bottom = 16.dp),
        verticalAlignment = Alignment.CenterVertically) {
        Box(Modifier.size(40.dp).clip(RoundedCornerShape(12.dp)).background(c.behind), contentAlignment = Alignment.Center) {
            Icon(icon, null, Modifier.size(24.dp), tint = c.ink)
        }
        Spacer(Modifier.width(16.dp))
        Column(Modifier.weight(1f), verticalArrangement = Arrangement.spacedBy(2.dp)) {
            Text(title, style = AppType.titleMedium, color = c.ink)
            Text(line, style = AppType.bodyMedium, color = c.secondary)
            if (example != null) {
                Spacer(Modifier.height(4.dp))
                Box(Modifier.clip(RoundedCornerShape(8.dp)).background(c.behind).padding(horizontal = 8.dp, vertical = 3.dp)) {
                    Text(example, style = AppType.labelMedium, color = c.secondary)
                }
            }
        }
        Spacer(Modifier.width(16.dp))
        Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = c.secondary)
    }
}

/** A choice page (Figma 1, 2, 3): ✕ or ← and no title; the question (Headline Medium Emphasized) is its only heading. */
@Composable
fun ChoicePage(question: String, close: Boolean, onBack: () -> Unit, content: @Composable () -> Unit) {
    Column(Modifier.fillMaxSize().background(appColors.screen).statusBarsPadding().navigationBarsPadding()) {
        Box(Modifier.height(64.dp).padding(start = 4.dp), contentAlignment = Alignment.CenterStart) {
            IconButton(onBack, Modifier.semantics { testTag = "page-back" }) {
                if (close) Icon(Icons.Rounded.Close, "Close", tint = appColors.ink) else Icon(Icons.AutoMirrored.Rounded.ArrowBack, "Back", tint = appColors.ink)
            }
        }
        Column(Modifier.verticalScroll(rememberScrollState()).padding(start = 16.dp, end = 16.dp, top = 8.dp, bottom = 24.dp), verticalArrangement = Arrangement.spacedBy(24.dp)) {
            Text(question, Modifier.padding(horizontal = 8.dp).widthIn(max = 236.dp).semantics { heading() }, style = AppType.headlineMediumEmphasized, color = appColors.ink)
            Column(verticalArrangement = Arrangement.spacedBy(2.dp)) { content() }
        }
    }
}

/** New (Figma 1): What do you want to do? */
@Composable
fun NewChoices(store: HabitStore, onClose: () -> Unit, onBuild: () -> Unit, onQuit: () -> Unit, onTask: () -> Unit) {
    @Suppress("UNUSED_VARIABLE") val unused = store
    ChoicePage("What do you want to do?", close = true, onBack = onClose) {
        ChoiceCard(Icons.AutoMirrored.Outlined.TrendingUp, "Build or maintain", "A habit you want to start or keep doing.", null, 0, 3, "new-build", onClick = onBuild)
        ChoiceCard(Icons.AutoMirrored.Outlined.TrendingDown, "Quit or cut down", "A habit you want to stop or do less.", null, 1, 3, "new-quit", onClick = onQuit)
        ChoiceCard(icon(ItemType.TASK), "Add a task", "Something to get done, once or on repeat.", null, 2, 3, "new-task", onClick = onTask)
    }
}

@Composable
fun TypeChoices(question: String, types: List<ItemType>, onBack: () -> Unit, onPick: (ItemType) -> Unit) {
    ChoicePage(question, close = false, onBack = onBack) {
        types.forEachIndexed { i, t -> ChoiceCard(icon(t), t.title, t.summary, t.example, i, types.size, "type-${t.name.lowercase()}") { onPick(t) } }
    }
}
