package com.oftenenough.app.ui.habit

import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.AppTopBar
import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.semantics.clearAndSetSemantics
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.streakList
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.RunRow
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors

/**
 * Streaks (Figma 1373:2, 3.2), from the record's See all streaks; a quit habit's Runs, from See all runs (3.9): every run
 * of 3 days (or weeks …) or more, longest first, each with its dates and a bar beside the longest; the one going on now
 * says "now" and is drawn in the habit's full colour. Worked out once per data change (S5).
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
internal fun StreaksPage(habit: Habit, store: HabitStore, today: Int, revision: Int, onBack: () -> Unit) {
    BackHandler(onBack = onBack)
    val c = appColors
    val list = remember(habit, revision, today) { store.streakList(habit, today) }
    Column(Modifier.fillMaxSize().background(c.screen).semantics { testTag = "streaks-page" }) {
        AppTopBar(
            list.title,
            navigationIcon = { IconButton(onBack, Modifier.semantics { testTag = "page-back" }) { Icon(Symbols.ArrowBack, "Back") } },
        )
        LazyColumn(Modifier.fillMaxWidth().weight(1f)) {
            item(key = "who") {
                Row(Modifier.fillMaxWidth().padding(horizontal = 28.dp).padding(top = 4.dp, bottom = 16.dp), verticalAlignment = Alignment.CenterVertically) {
                    HabitIcon(habit.symbol, habit.color, 28.dp, CircleShape)
                    Spacer(Modifier.width(12.dp))
                    Text(habit.name, Modifier.weight(1f), style = AppType.titleMedium, color = c.ink)
                    Text(list.since, style = AppType.bodyMedium, color = c.secondary)
                }
            }
            item(key = "count") {
                Box(Modifier.padding(horizontal = 16.dp).fillMaxWidth().clip(RoundedCornerShape(24.dp, 24.dp, 0.dp, 0.dp)).background(c.surface)
                    .padding(start = 20.dp, end = 20.dp, top = 20.dp)) {
                    Text(if (list.rows.isEmpty()) "None yet" else list.count, style = AppType.titleMedium, color = c.ink)
                }
            }
            // Each run a Run row (molecule 4.5), 16 under the one before, on the card's white.
            itemsIndexed(list.rows, key = { i, _ -> "run-$i" }) { _, row ->
                Box(Modifier.padding(horizontal = 16.dp).fillMaxWidth().background(c.surface).padding(start = 20.dp, end = 20.dp, top = 16.dp)) {
                    RunRow(row.length, row.dates, row.fraction, row.isCurrent, habit.color,
                        Modifier.clearAndSetSemantics { contentDescription = row.spoken; testTag = if (row.isCurrent) "run-current" else "run" })
                }
            }
            item(key = "note") {
                Box(Modifier.padding(horizontal = 16.dp).fillMaxWidth().clip(RoundedCornerShape(0.dp, 0.dp, 24.dp, 24.dp)).background(c.surface)
                    .padding(start = 20.dp, end = 20.dp, top = 16.dp, bottom = 20.dp)) {
                    Text(list.note, style = AppType.bodySmall, color = c.secondary)
                }
            }
            item(key = "end") { Spacer(Modifier.navigationBarsPadding().height(16.dp)) }
        }
    }
}
