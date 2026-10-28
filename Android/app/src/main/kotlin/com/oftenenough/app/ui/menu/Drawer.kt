package com.oftenenough.app.ui.menu

import com.oftenenough.app.ui.theme.Symbols
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
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.ModalDrawerSheet
import androidx.compose.material3.MaterialTheme
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
/** [selectedIcon]: the open row's glyph is filled, as Material's drawer and Figma draw it (Drawer item, State=Selected). */
enum class MenuItem(val title: String, val icon: ImageVector, val selectedIcon: ImageVector) {
    TODAY("Today", Symbols.WbSunny, Symbols.Filled.WbSunny),
    HABITS("Habits & Tasks", Symbols.Checklist, Symbols.Filled.Checklist),
    PLUS("Plus", Symbols.AddCircle, Symbols.Filled.AddCircle),
    SETTINGS("Settings", Symbols.Settings, Symbols.Filled.Settings),
    CONTACT("Contact us", Symbols.ContactSupport, Symbols.Filled.ContactSupport),
    FEEDBACK("Send feedback", Symbols.Feedback, Symbols.Filled.Feedback),
}

/**
 * The ≡ menu (5.2.1, Figma Navigation drawer 626:76): Material's own modal navigation drawer on Surface container low,
 * its end corners 16; the header (the mark, 36, and "Often Enough" in Title Large Emphasized, 12 apart, 28 from the
 * edges and 16 above and below); then the Drawer items (1.8), 56 tall, 12 in, one under another; a divider in Outline
 * variant, 16 + 12 in, separates where you are from what you do.
 */
@Composable
fun MenuDrawer(store: HabitStore, current: MenuItem, onPick: (MenuItem) -> Unit) {
    ModalDrawerSheet(drawerContainerColor = MaterialTheme.colorScheme.surfaceContainerLow, modifier = Modifier.semantics { testTag = "menu-drawer" }) {
        MenuItems(store, current, onPick)
    }
}

/**
 * The same menu as a sidebar that stays, on tablets and unfolded foldables (A11 D9; the iPad's sidebar). The phone's
 * drawer and this are the same rows, in the same order.
 */
@Composable
fun MenuSidebar(store: HabitStore, current: MenuItem?, onPick: (MenuItem) -> Unit) {
    PermanentDrawerSheet(Modifier.width(300.dp).semantics { testTag = "menu-sidebar" }, drawerContainerColor = MaterialTheme.colorScheme.surfaceContainerLow) {
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
            // 28 from the sheet's edges (12 + 16), so the mark lines up with the rows' icons; 16 above and below.
            Modifier.padding(horizontal = 16.dp, vertical = 16.dp),
            verticalAlignment = Alignment.CenterVertically,
        ) {
            Image(painterResource(if (c.dark) R.drawable.mark_dark else R.drawable.mark_light), null, Modifier.size(36.dp))
            Spacer(Modifier.width(12.dp))
            Text("Often Enough", style = AppType.titleLargeEmphasized, color = MaterialTheme.colorScheme.onSurface)
        }
        for (item in MenuItem.entries) {
            // The line between where you are and what you do (Figma: under Habits & Tasks).
            if (item == MenuItem.PLUS) {
                HorizontalDivider(Modifier.padding(horizontal = 16.dp, vertical = 8.dp), color = MaterialTheme.colorScheme.outlineVariant)
            }
            NavigationDrawerItem(
                label = { Text(item.title, style = AppType.labelLarge) },
                selected = item == current,
                onClick = { onPick(item) },
                icon = { Icon(if (item == current) item.selectedIcon else item.icon, null) },
                badge = if (item == MenuItem.HABITS && kept > 0) ({ Text("$kept", style = AppType.labelLarge) }) else null,
                modifier = Modifier.semantics { testTag = "menu-" + item.name.lowercase() },
                // Atom 1.8 (Figma Drawer item 625:46): Material's own colours (selected Secondary container with On
                // secondary container, unselected transparent with On surface variant); only the count stays On surface
                // variant on the selected row too, as the design draws it.
                colors = NavigationDrawerItemDefaults.colors(selectedBadgeColor = MaterialTheme.colorScheme.onSurfaceVariant),
            )
        }
        Spacer(Modifier.height(16.dp))
    }
}
