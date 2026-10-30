package com.oftenenough.app.ui.newhabit

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.SnackbarDuration
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.SnackbarResult
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitCopy
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.AppDialog
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.components.AppMenu
import com.oftenenough.app.ui.components.AppMenuItem
import com.oftenenough.app.ui.components.AppSnackbarHost
import com.oftenenough.app.ui.components.ButtonSize
import com.oftenenough.app.ui.components.ListAvatar
import com.oftenenough.app.ui.components.StandardIconButton
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.HabitIcons
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch

/**
 * 5.9.2, **Make room** (Figma 1167:351072 and 1167:351230, the flow "A sixth habit on the free plan": "Back (←), then
 * archive one"). From Plus for a sixth habit, by its ←. On Surface container: the Top app bar (← "Make room"); 8 above,
 * 16 at the sides, 24 between: "Archive or delete one of your habits to add a new one." in Body Large On surface
 * variant, 16 in; one List of the habits on Surface bright, each a List item (Two lines): its own icon in its colour in
 * the grey circle, its name, its goal ("8 glasses a day", "Every day"), and ⋮ with **Archive** and **Delete** (Error,
 * asked first, D9); then "Archived habits keep all their progress; you can bring them back any time." in Body Medium.
 *
 * Archived, the row goes and the snackbar says "Read archived" with Undo; once there's room, **Continue** (Filled,
 * Medium, round, the width, 12 above and under) is held at the bottom and goes on with the habit ([onRoom]). ← leaves
 * ([onBack]); it never goes back to Plus, so the two never send each other round.
 */
@Composable
fun MakeRoomPage(store: HabitStore, onBack: () -> Unit, onRoom: () -> Unit) {
    val s = MaterialTheme.colorScheme
    val scope = rememberCoroutineScope()
    val snack = remember { SnackbarHostState() }
    var deleting by remember { mutableStateOf<Habit?>(null) }
    val habits = store.habits.filter { !it.archived && it.kind != HabitKind.Task }
    val archive: (Habit) -> Unit = { h ->
        store.archive(listOf(h))
        scope.launch {
            snack.currentSnackbarData?.dismiss()
            if (snack.showSnackbar("${h.name} archived", "Undo", duration = SnackbarDuration.Short) == SnackbarResult.ActionPerformed)
                store.habit(h.id)?.let { store.restore(it) }
        }
    }
    Box(Modifier.fillMaxSize()) {
        Column(Modifier.fillMaxSize()) {
            Box(Modifier.weight(1f)) {
                FormPage("Make room", onBack = onBack) {
                    Column(Modifier.padding(top = 8.dp), verticalArrangement = Arrangement.spacedBy(24.dp)) {
                        Text("Archive or delete one of your habits to add a new one.", Modifier.padding(horizontal = 16.dp),
                            style = AppType.bodyLarge, color = s.onSurfaceVariant)
                        com.oftenenough.app.ui.components.SegmentedList {
                            habits.forEachIndexed { i, h -> RoomRow(h, store, i, habits.size, onArchive = { archive(h) }, onDelete = { deleting = h }) }
                        }
                        Text("Archived habits keep all their progress; you can bring them back any time.", Modifier.padding(horizontal = 16.dp),
                            style = AppType.bodyMedium, color = s.onSurfaceVariant)
                    }
                }
            }
            // Room made: Continue goes on with the habit (Figma 4).
            if (store.canAddHabit) Box(Modifier.fillMaxWidth().background(s.surfaceContainer).navigationBarsPadding().padding(horizontal = 16.dp, vertical = 12.dp)) {
                AppButton("Continue", onRoom, Modifier.fillMaxWidth(), size = ButtonSize.Medium, tag = "room-continue")
            }
        }
        AppSnackbarHost(snack, Modifier.align(Alignment.BottomCenter).navigationBarsPadding().padding(bottom = if (store.canAddHabit) 80.dp else 0.dp))
    }
    deleting?.let { h ->
        AppDialog("Delete ${h.name}?", "Its history and notes are deleted too. Archiving keeps them and makes room just the same.",
            "Delete", { deleting = null; store.delete(listOf(h)) }, { deleting = null }, destructive = true, confirmTag = "room-delete")
    }
}

/** One habit: its icon in its colour in the grey circle, its name and goal, and ⋮ with Archive and Delete. */
@Composable
private fun RoomRow(h: Habit, store: HabitStore, index: Int, count: Int, onArchive: () -> Unit, onDelete: () -> Unit) {
    var menu by remember { mutableStateOf(false) }
    AppListItem(
        h.name, index, count, supporting = if (h.kind == HabitKind.Quit) "Quit" else HabitCopy.capitalized(HabitCopy.plan(h, store.weekStart)),
        headlineLines = 1,
        leading = { ListAvatar(HabitIcons.icon(h.symbol), tint = appColors.habit(h.color)) },
        trailing = {
            Box {
                StandardIconButton(Symbols.MoreVert, "More for ${h.name}", { menu = true }, Modifier.semantics { testTag = "room-more-${h.name}" })
                AppMenu(menu, { menu = false }) {
                    AppMenuItem("Archive", { menu = false; onArchive() }, icon = Symbols.Archive, tag = "room-archive-${h.name}")
                    AppMenuItem("Delete", { menu = false; onDelete() }, icon = Symbols.Delete, destructive = true, tag = "room-delete-${h.name}")
                }
            }
        },
        containerColor = MaterialTheme.colorScheme.surfaceBright, tag = "room-${h.name}",
    )
}
