package com.oftenenough.app.ui.menu

import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.HelpOutline
import androidx.compose.material.icons.automirrored.rounded.List
import androidx.compose.material.icons.outlined.Cloud
import androidx.compose.material.icons.outlined.Info
import androidx.compose.material.icons.outlined.Notifications
import androidx.compose.material.icons.outlined.Shield
import androidx.compose.material.icons.rounded.AddCircleOutline
import androidx.compose.material.icons.rounded.BarChart
import androidx.compose.material.icons.rounded.CalendarMonth
import androidx.compose.material.icons.rounded.Contrast
import androidx.compose.material.icons.rounded.Checklist
import androidx.compose.material.icons.rounded.ViewWeek
import androidx.compose.material.icons.rounded.WbSunny
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.ModalDrawerSheet
import androidx.compose.material3.NavigationDrawerItem
import androidx.compose.material3.NavigationDrawerItemDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.theme.appColors

/** Where each menu item goes. */
enum class MenuItem(val title: String, val icon: ImageVector) {
    TODAY("Today", Icons.Rounded.WbSunny),
    PROGRESS("Progress", Icons.Rounded.BarChart),
    HABITS("Habits", Icons.Rounded.Checklist),
    TASKS("Tasks", Icons.AutoMirrored.Rounded.List),
    TIMES_OF_DAY("Times of Day", Icons.Rounded.ViewWeek),
    DAY_AND_WEEK("Day and Week", Icons.Rounded.CalendarMonth),
    REMINDERS("Reminders", Icons.Outlined.Notifications),
    APPEARANCE("Appearance", Icons.Rounded.Contrast),
    BACKUP("Google Drive & Backup", Icons.Outlined.Cloud),
    PRIVACY("Privacy & Security", Icons.Outlined.Shield),
    PLUS("Plus", Icons.Rounded.AddCircleOutline),
    HELP("Help & Feedback", Icons.AutoMirrored.Rounded.HelpOutline),
    ABOUT("About", Icons.Outlined.Info),
}

/**
 * The ≡ menu: Material's navigation drawer. The app's name, then where you are (Today, Progress, Habits, Tasks with their
 * counts), the day's settings, your data, Plus, and help (the iPhone's side menu, in Android's own drawer).
 */
@Composable
fun MenuDrawer(store: HabitStore, current: MenuItem, onPick: (MenuItem) -> Unit) {
    val habits = store.habits.count { !it.archived && it.kind != HabitKind.Task }
    val tasks = store.habits.count { !it.archived && it.kind == HabitKind.Task }
    ModalDrawerSheet(drawerContainerColor = appColors.surface, modifier = Modifier.semantics { testTag = "menu-drawer" }) {
        androidx.compose.foundation.layout.Column(Modifier.verticalScroll(rememberScrollState()).padding(horizontal = 12.dp)) {
            Text("Often Enough", Modifier.padding(start = 16.dp, top = 24.dp, bottom = 16.dp), style = MaterialTheme.typography.titleSmall, color = appColors.secondary)
            val groups = listOf(
                listOf(MenuItem.TODAY, MenuItem.PROGRESS, MenuItem.HABITS, MenuItem.TASKS),
                listOf(MenuItem.TIMES_OF_DAY, MenuItem.DAY_AND_WEEK, MenuItem.REMINDERS, MenuItem.APPEARANCE),
                listOf(MenuItem.BACKUP, MenuItem.PRIVACY),
                listOf(MenuItem.PLUS),
                listOf(MenuItem.HELP, MenuItem.ABOUT),
            )
            groups.forEachIndexed { g, items ->
                if (g > 0) HorizontalDivider(Modifier.padding(horizontal = 16.dp, vertical = 8.dp), color = appColors.outline.copy(alpha = 0.4f))
                for (item in items) {
                    val badge = when (item) { MenuItem.HABITS -> habits.toString(); MenuItem.TASKS -> tasks.toString(); else -> null }
                    NavigationDrawerItem(
                        label = { Text(item.title, style = MaterialTheme.typography.titleMedium.copy(fontWeight = androidx.compose.ui.text.font.FontWeight.Normal)) },
                        selected = item == current, onClick = { onPick(item) },
                        icon = { Icon(item.icon, null) },
                        badge = badge?.let { { Text(it, style = MaterialTheme.typography.titleMedium.copy(fontWeight = androidx.compose.ui.text.font.FontWeight.Normal)) } },
                        modifier = Modifier.padding(vertical = 2.dp).semantics { testTag = "menu-" + item.name.lowercase() },
                        colors = NavigationDrawerItemDefaults.colors(
                            selectedContainerColor = appColors.tonal, unselectedContainerColor = appColors.surface,
                            selectedTextColor = appColors.ink, unselectedTextColor = appColors.ink,
                            selectedIconColor = appColors.ink, unselectedIconColor = appColors.secondary,
                            selectedBadgeColor = appColors.secondary, unselectedBadgeColor = appColors.secondary,
                        ),
                    )
                }
            }
            Spacer(Modifier.height(24.dp))
        }
    }
}
