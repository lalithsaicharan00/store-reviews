package com.oftenenough.app.ui.habit

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
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
import androidx.compose.foundation.lazy.LazyListScope
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.outlined.CalendarToday
import androidx.compose.material.icons.outlined.Schedule
import androidx.compose.material.icons.outlined.Unarchive
import androidx.compose.material.icons.rounded.Add
import androidx.compose.material.icons.rounded.Check
import androidx.compose.material.icons.rounded.SkipNext
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
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
import com.oftenenough.app.ui.components.InkButton
import com.oftenenough.app.ui.components.segmentShape
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
                TaskEventRow(e, i, events.size, if (e.day != null && e.kind != TaskEvent.Kind.CREATED && !task.archived) ({ onOpenDay(e.day) }) else null)
            }
        }
        if (title == null && g < groups.size - 1) item(key = "task-history-gap-$g") { Spacer(Modifier.height(16.dp)) }
    }
}

@Composable
private fun TaskEventRow(e: TaskEvent, index: Int, count: Int, onClick: (() -> Unit)?) {
    val c = appColors
    val icon = when (e.kind) {
        TaskEvent.Kind.WAITING -> Icons.Outlined.Schedule
        TaskEvent.Kind.PLANNED -> if (e.line.startsWith("Not done")) Icons.Outlined.CalendarToday else Icons.Outlined.Schedule
        TaskEvent.Kind.DONE -> Icons.Rounded.Check
        TaskEvent.Kind.SKIPPED -> Icons.Rounded.SkipNext
        TaskEvent.Kind.CREATED -> Icons.Rounded.Add
    }
    Row(
        Modifier.padding(horizontal = 16.dp).padding(bottom = 2.dp).fillMaxWidth().clip(segmentShape(index, count)).background(c.surface)
            .let { if (onClick != null) it.clickable(onClick = onClick) else it }
            .semantics(mergeDescendants = true) { testTag = "task-event" }
            .heightIn(min = 72.dp).padding(horizontal = 16.dp, vertical = 8.dp),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Box(Modifier.size(40.dp).clip(CircleShape).background(c.tonal), contentAlignment = Alignment.Center) {
            Icon(icon, null, Modifier.size(20.dp), tint = c.ink)
        }
        Spacer(Modifier.width(16.dp))
        Column(Modifier.weight(1f)) {
            Text(e.title, style = AppType.bodyLarge, color = c.ink)
            Text(e.line, style = AppType.bodyMedium, color = c.secondary)
        }
    }
}

/** An archived task (Figma 9.4): when, that it's off Today and Tasks and keeps its history, and Restore. */
@Composable
private fun TaskArchivedCard(store: HabitStore, task: Habit) {
    val c = appColors
    Column(Modifier.padding(horizontal = 16.dp).padding(bottom = 16.dp).fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.surface)
        .padding(20.dp).semantics { testTag = "habit-archived" }) {
        Text(store.archivedLine(task) + ". It’s off Today and Tasks, and keeps its history.", style = AppType.bodyMedium, color = c.secondary)
        Spacer(Modifier.height(16.dp))
        InkButton("Restore", { store.restore(task) }, Modifier.semantics { testTag = "habit-restore" }, icon = Icons.Outlined.Unarchive,
            height = 40.dp, textStyle = AppType.labelLarge)
    }
}
