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
import androidx.compose.material3.MaterialTheme
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

/**
 * 5.6.2, **Streaks page** (Figma 1034:74; Components — Atoms Build Plan), from the record's See all streaks; a quit
 * habit's Runs, from See all runs: on Surface container, the Top app bar (← and "Streaks" or "Runs"); the content 16 at
 * the sides, 8 above, 40 under, 16 between its parts. The habit (its icon 28 in its colour, 12, its name in Title Medium,
 * "Since 2 Sep 2026" in Body Medium On surface variant at the end), 4 in from the content's sides; then one card
 * (Surface container lowest, corners 24, 20 inside, 16 between): "3 runs" in Title Medium, then each run of 3 days (or
 * weeks …) or more, longest first, as the Run row (4.5: its length, its dates, a bar beside the longest; the one going
 * on now says "now" in the habit's full colour). Under the card, the footnote in Body Small On surface variant. Worked
 * out once per data change (S5).
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
internal fun StreaksPage(habit: Habit, store: HabitStore, today: Int, revision: Int, onBack: () -> Unit) {
    BackHandler(onBack = onBack)
    val s = MaterialTheme.colorScheme
    val list = remember(habit, revision, today) { store.streakList(habit, today) }
    // One card over several lazy items: the heading carries its top corners, a closing piece its bottom ones.
    val card = Modifier.padding(horizontal = 16.dp).fillMaxWidth()
    Column(Modifier.fillMaxSize().background(s.surfaceContainer).semantics { testTag = "streaks-page" }) {
        AppTopBar(
            list.title,
            navigationIcon = { IconButton(onBack, Modifier.semantics { testTag = "page-back" }) { Icon(Symbols.ArrowBack, "Back") } },
        )
        LazyColumn(Modifier.fillMaxWidth().weight(1f)) {
            item(key = "who") {
                Row(Modifier.fillMaxWidth().padding(horizontal = 20.dp).padding(top = 8.dp, bottom = 16.dp), verticalAlignment = Alignment.CenterVertically) {
                    HabitIcon(habit.symbol, habit.color, 28.dp, CircleShape, glyph = 16f / 28f)
                    Spacer(Modifier.width(12.dp))
                    Text(habit.name, Modifier.weight(1f), style = AppType.titleMedium, color = s.onSurface)
                    Text(list.since, style = AppType.bodyMedium, color = s.onSurfaceVariant)
                }
            }
            item(key = "count") {
                Box(card.clip(RoundedCornerShape(24.dp, 24.dp, 0.dp, 0.dp)).background(s.surfaceContainerLowest).padding(start = 20.dp, end = 20.dp, top = 20.dp)) {
                    Text(if (list.rows.isEmpty()) "None yet" else list.count, style = AppType.titleMedium, color = s.onSurface)
                }
            }
            // Each run a Run row (molecule 4.5), 16 under the one before, on the card.
            itemsIndexed(list.rows, key = { i, _ -> "run-$i" }) { _, row ->
                Box(card.background(s.surfaceContainerLowest).padding(start = 20.dp, end = 20.dp, top = 16.dp)) {
                    RunRow(row.length, row.dates, row.fraction, row.isCurrent, habit.color,
                        Modifier.clearAndSetSemantics { contentDescription = row.spoken; testTag = if (row.isCurrent) "run-current" else "run" })
                }
            }
            item(key = "card-end") {
                Spacer(card.height(20.dp).clip(RoundedCornerShape(0.dp, 0.dp, 24.dp, 24.dp)).background(s.surfaceContainerLowest))
            }
            item(key = "note") {
                Text(list.note, card.padding(top = 16.dp), style = AppType.bodySmall, color = s.onSurfaceVariant)
            }
            item(key = "end") { Spacer(Modifier.navigationBarsPadding().height(40.dp)) }
        }
    }
}
