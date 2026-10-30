@file:OptIn(androidx.compose.material3.ExperimentalMaterial3Api::class)

package com.oftenenough.app.ui.newhabit

import com.oftenenough.app.ui.components.AppDialog
import com.oftenenough.app.ui.components.AppMenuItem
import com.oftenenough.app.ui.components.AppMenu
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.StandardIconButton
import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors

// ------------------------------------------------------------------ 6.3 · Change the type

// ------------------------------------------------------------------ 5.1 · Make room

/**
 * Make room (Figma 5.1, the iPhone's `MakeRoomView`): archive or delete one of the five; once there's room, the habit
 * being added goes ahead. Delete asks first (5.1.1) and says archiving makes room just the same.
 */
@Composable
fun MakeRoomPage(store: HabitStore, onBack: () -> Unit, onRoom: () -> Unit) {
    val c = appColors
    var deleting by remember { mutableStateOf<Habit?>(null) }
    BackHandler(onBack = onBack)
    // An archive or a delete leaves room: the new habit goes ahead.
    LaunchedEffect(store.canAddHabit) { if (store.canAddHabit) onRoom() }
    val habits = store.habits.filter { !it.archived && it.kind != HabitKind.Task }
    FormPage("Make room", onBack = onBack) {
        Text("Archive or delete one of your ${habits.size} habits to add a new one.", Modifier.padding(start = 16.dp, end = 16.dp, top = 4.dp, bottom = 16.dp),
            style = AppType.bodyLarge, color = c.secondary)
        Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
            habits.forEachIndexed { i, h ->
                var menu by remember { mutableStateOf(false) }
                Row(Modifier.fillMaxWidth().clip(com.oftenenough.app.ui.components.segmentShape(i, habits.size)).background(c.surface).heightIn(min = 72.dp)
                    .padding(start = 16.dp, end = 4.dp).semantics { testTag = "room-${h.name}" }, verticalAlignment = Alignment.CenterVertically) {
                    HabitIcon(h.symbol, h.color, 40.dp)
                    Spacer(Modifier.width(16.dp))
                    Text(h.name, Modifier.weight(1f), style = AppType.titleMedium, color = c.ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
                    AppButton("Archive", { store.archive(listOf(h)) }, style = ButtonStyle.Outlined, tag = "room-archive-${h.name}")
                    Box {
                        StandardIconButton(Symbols.MoreVert, "More for ${h.name}", { menu = true }, Modifier.semantics { testTag = "room-more-${h.name}" })
                        AppMenu(menu, { menu = false }) {
                            AppMenuItem("Delete…", { menu = false; deleting = h }, icon = Symbols.Delete, destructive = true)
                        }
                    }
                }
            }
        }
        Note("Archived habits keep all their progress, and you can bring them back any time.")
    }
    deleting?.let { h ->
        AppDialog("Delete ${h.name}?", "Its history and notes are deleted too. Archiving keeps them and makes room just the same.",
            "Delete", { deleting = null; store.delete(listOf(h)) }, { deleting = null }, destructive = true, confirmTag = "room-delete")
    }
}

