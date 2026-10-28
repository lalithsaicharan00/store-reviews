package com.oftenenough.app.ui.habit

import androidx.compose.ui.text.AnnotatedString
import com.oftenenough.app.ui.components.ListNote
import com.oftenenough.app.ui.components.ListAvatar
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.AppButton
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyListScope
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.TaskEvent
import com.oftenenough.app.data.archivedLine
import com.oftenenough.app.data.taskHistory
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors

/**
 * A task's History (Tasks, Figma 7.3, 8.6, 9.4, 10): what happened, newest first, in groups (Waiting, Done) and when it
 * was made. A task has no squares and no stats; a row with a day opens that day's Day details.
 */
fun LazyListScope.taskHistoryItems(store: HabitStore, task: Habit, today: Int, onOpenDay: (Int) -> Unit) {
    val groups = store.taskHistory(task, today)
    if (task.archived) item(key = "task-archived") { TaskArchivedCard(store, task) }
    for ((g, pair) in groups.withIndex()) {
        val (title, events) = pair
        if (title != null) item(key = "task-history-title-$g") {
            Text(title, Modifier.padding(start = 32.dp, top = if (g == 0) 0.dp else 16.dp, bottom = 8.dp), style = AppType.bodyMedium, color = appColors.secondary)
        }
        events.forEachIndexed { i, e ->
            item(key = "task-history-$g-$i") {
                // Each time with its note (Habit details, Figma 1373:2, 6.5).
                val note = if (e.kind != TaskEvent.Kind.CREATED) e.day?.let { store.note(task, it) }?.takeIf { it.isNotBlank() } else null
                TaskEventRow(e, i, events.size, note, if (e.day != null && e.kind != TaskEvent.Kind.CREATED && !task.archived) ({ onOpenDay(e.day) }) else null)
            }
        }
        if (title == null && g < groups.size - 1) item(key = "task-history-gap-$g") { Spacer(Modifier.height(16.dp)) }
    }
}

@Composable
private fun TaskEventRow(e: TaskEvent, index: Int, count: Int, note: String?, onClick: (() -> Unit)?) {
    val c = appColors
    val icon = when (e.kind) {
        TaskEvent.Kind.WAITING -> Symbols.Schedule
        TaskEvent.Kind.PLANNED -> if (e.line.startsWith("Not done")) Symbols.CalendarToday else Symbols.Schedule
        TaskEvent.Kind.DONE -> Symbols.Check
        TaskEvent.Kind.SKIPPED -> Symbols.SkipNext
        TaskEvent.Kind.CREATED -> Symbols.Add
    }
    AppListItem(
        e.title, index, count, Modifier.padding(horizontal = 16.dp).padding(bottom = 2.dp).semantics(mergeDescendants = true) {}, e.line,
        leading = { ListAvatar(icon) }, below = note?.let { { ListNote(AnnotatedString(it)) } }, onClick = onClick, tag = "task-event",
    )
}

/** An archived task (Figma 9.4): when, that it's off Today and Tasks and keeps its history, and Restore. */
@Composable
private fun TaskArchivedCard(store: HabitStore, task: Habit) {
    val c = appColors
    Column(Modifier.padding(horizontal = 16.dp).padding(bottom = 16.dp).fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.surface)
        .padding(20.dp).semantics { testTag = "habit-archived" }) {
        Text(store.archivedLine(task) + ". It’s off Today and Tasks, and keeps its history.", style = AppType.bodyMedium, color = c.secondary)
        Spacer(Modifier.height(16.dp))
        AppButton("Restore", { store.restore(task) }, Modifier.semantics { testTag = "habit-restore" }, icon = Symbols.Unarchive)
    }
}
