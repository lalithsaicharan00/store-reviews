package com.oftenenough.app.ui.menu

import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.outlined.Feedback
import androidx.compose.material.icons.rounded.AddCircleOutline
import androidx.compose.material.icons.rounded.Checklist
import androidx.compose.material.icons.rounded.ContactSupport
import androidx.compose.material.icons.rounded.Settings
import androidx.compose.material.icons.rounded.WbSunny
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.ModalDrawerSheet
import androidx.compose.material3.NavigationDrawerItem
import androidx.compose.material3.NavigationDrawerItemDefaults
import androidx.compose.material3.PermanentDrawerSheet
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import com.oftenenough.app.R
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors

/**
 * Where each menu row goes (Figma `12:5259`, 22 October 2026). Six rows, no more: the long settings menu became one
 * **Settings** page, Habits and Tasks became one place, and Help & Feedback split into the two things people actually
 * come for. Progress, Times of Day, Day and Week, Reminders, Appearance, Backup & Sync, Privacy and About are all
 * inside Settings now.
 */
enum class MenuItem(val title: String, val icon: ImageVector) {
    TODAY("Today", Icons.Rounded.WbSunny),
    HABITS("Habits & Tasks", Icons.Rounded.Checklist),
    PLUS("Plus", Icons.Rounded.AddCircleOutline),
    SETTINGS("Settings", Icons.Rounded.Settings),
    CONTACT("Contact us", Icons.Rounded.ContactSupport),
    FEEDBACK("Send feedback", Icons.Outlined.Feedback),
}

/**
 * The ≡ menu: Material's own navigation drawer, 304 wide, its rows 56 high and fully rounded, the open one tonal
 * (Figma `12:5259`). The logo and the app's name sit above them; a divider separates where you are from what you do.
 */
@Composable
fun MenuDrawer(store: HabitStore, current: MenuItem, onPick: (MenuItem) -> Unit) {
    ModalDrawerSheet(drawerContainerColor = appColors.surface, modifier = Modifier.semantics { testTag = "menu-drawer" }) {
        MenuItems(store, current, onPick)
    }
}

/**
 * The same menu as a sidebar that stays, on tablets and unfolded foldables (A11 D9; the iPad's sidebar). The phone's
 * drawer and this are the same rows, in the same order.
 */
@Composable
fun MenuSidebar(store: HabitStore, current: MenuItem?, onPick: (MenuItem) -> Unit) {
    PermanentDrawerSheet(Modifier.width(300.dp).semantics { testTag = "menu-sidebar" }, drawerContainerColor = appColors.surface) {
        MenuItems(store, current, onPick)
    }
}

@Composable
private fun MenuItems(store: HabitStore, current: MenuItem?, onPick: (MenuItem) -> Unit) {
    val c = appColors
    // One count, for one row: every habit and task someone keeps, as the Habits & Tasks page lists them.
    val kept = store.habits.count { !it.archived }
    Column(Modifier.verticalScroll(rememberScrollState()).padding(horizontal = 12.dp)) {
        Row(
            Modifier.padding(start = 12.dp, end = 16.dp, top = 16.dp, bottom = 28.dp),
            verticalAlignment = Alignment.CenterVertically,
        ) {
            Image(painterResource(if (c.dark) R.drawable.mark_dark else R.drawable.mark_light), null, Modifier.size(36.dp))
            Spacer(Modifier.width(12.dp))
            Text("Often Enough", style = AppType.title20Emphasized, color = c.ink)
        }
        for (item in MenuItem.entries) {
            // The line between where you are and what you do (Figma: under Habits & Tasks).
            if (item == MenuItem.PLUS) {
                HorizontalDivider(Modifier.padding(horizontal = 16.dp, vertical = 8.dp), color = c.line.copy(alpha = 0.6f))
            }
            NavigationDrawerItem(
                label = { Text(item.title, style = AppType.labelLarge) },
                selected = item == current,
                onClick = { onPick(item) },
                icon = { Icon(item.icon, null) },
                badge = if (item == MenuItem.HABITS && kept > 0) ({ Text("$kept", style = AppType.labelLarge) }) else null,
                modifier = Modifier.padding(vertical = 2.dp).semantics { testTag = "menu-" + item.name.lowercase() },
                colors = NavigationDrawerItemDefaults.colors(
                    selectedContainerColor = c.behind, unselectedContainerColor = c.surface,
                    selectedTextColor = c.ink, unselectedTextColor = c.ink,
                    selectedIconColor = c.ink, unselectedIconColor = c.secondary,
                    selectedBadgeColor = c.secondary, unselectedBadgeColor = c.secondary,
                ),
            )
        }
        Spacer(Modifier.height(24.dp))
    }
}
