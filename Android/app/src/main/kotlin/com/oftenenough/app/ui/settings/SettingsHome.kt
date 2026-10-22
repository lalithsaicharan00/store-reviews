package com.oftenenough.app.ui.settings

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.ArrowBack
import androidx.compose.material.icons.automirrored.rounded.HelpOutline
import androidx.compose.material.icons.outlined.Cloud
import androidx.compose.material.icons.outlined.Info
import androidx.compose.material.icons.outlined.Notifications
import androidx.compose.material.icons.outlined.Shield
import androidx.compose.material.icons.rounded.CalendarMonth
import androidx.compose.material.icons.rounded.Contrast
import androidx.compose.material.icons.rounded.ViewWeek
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.components.ListRow
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors

/** Every page the app opens by its own name (the routes are `page/<title>`). */
object SettingsPage {
    /**
     * Progress has no way in since the menu became six rows (Figma `12:5259`): the route is still here and still
     * works, so nothing was deleted, but nothing opens it. Where it belongs is the user's call.
     */
    const val PROGRESS = "Progress"
    const val TIMES_OF_DAY = "Times of Day"
    const val DAY_AND_WEEK = "Day and Week"
    const val REMINDERS = "Reminders"
    const val APPEARANCE = "Appearance"
    const val BACKUP = "Backup & Sync"
    const val PRIVACY = "Privacy & Security"
    const val HELP = "Help"
    const val ABOUT = "About"
}

/**
 * **Settings** — one page for everything the menu used to list separately (Figma `12:5259`, 22 October 2026: the menu
 * is six rows now). Grouped the way people look for them: the shape of the day, what the app tells you, how it looks,
 * where the habits are kept, and what the app is.
 *
 * The user is designing this screen; until that arrives this is the plain Material list of the pages that already
 * exist, so nothing the shorter menu dropped became unreachable.
 */
@Composable
fun SettingsHome(onOpen: (String) -> Unit, onBack: () -> Unit) {
    val c = appColors
    BackHandler(onBack = onBack)
    Column(Modifier.fillMaxSize().background(c.screen).statusBarsPadding().semantics { testTag = "settings-page" }) {
        Row(Modifier.heightIn(min = 64.dp).padding(start = 4.dp), verticalAlignment = Alignment.CenterVertically) {
            IconButton(onBack, Modifier.semantics { testTag = "page-back" }) {
                Icon(Icons.AutoMirrored.Rounded.ArrowBack, "Back", tint = c.ink)
            }
            Text("Settings", style = AppType.titleLargeEmphasized, color = c.ink)
        }
        Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 16.dp).navigationBarsPadding()) {
            Group("Your day")
            SegmentedList {
                Row("Times of Day", "Morning, Afternoon, Evening and your own", Icons.Rounded.ViewWeek, 0, 2, SettingsPage.TIMES_OF_DAY, onOpen)
                Row("Day and Week", "When a new day starts, and which day a week starts on", Icons.Rounded.CalendarMonth, 1, 2, SettingsPage.DAY_AND_WEEK, onOpen)
            }
            Group("The app")
            SegmentedList {
                Row("Reminders", "Every habit that reminds you, and when", Icons.Outlined.Notifications, 0, 2, SettingsPage.REMINDERS, onOpen)
                Row("Appearance", "Theme, streaks and what a done habit does", Icons.Rounded.Contrast, 1, 2, SettingsPage.APPEARANCE, onOpen)
            }
            Group("Your habits")
            SegmentedList {
                Row("Backup & Sync", "Google Drive, backup files and restoring", Icons.Outlined.Cloud, 0, 2, SettingsPage.BACKUP, onOpen)
                Row("Privacy & Security", "App lock, and hiding names outside the app", Icons.Outlined.Shield, 1, 2, SettingsPage.PRIVACY, onOpen)
            }
            Group("About")
            SegmentedList {
                Row("Help", "Answers to the things people ask", Icons.AutoMirrored.Rounded.HelpOutline, 0, 2, SettingsPage.HELP, onOpen)
                Row("About", "Version, licences and what the app promises", Icons.Outlined.Info, 1, 2, SettingsPage.ABOUT, onOpen)
            }
            Spacer(Modifier.height(24.dp))
        }
    }
}

@Composable
private fun Group(title: String) =
    Text(title, Modifier.padding(start = 16.dp, top = 24.dp, bottom = 8.dp), style = AppType.labelLarge, color = appColors.secondary)

@Composable
private fun Row(
    title: String,
    line: String,
    icon: androidx.compose.ui.graphics.vector.ImageVector,
    index: Int,
    count: Int,
    page: String,
    onOpen: (String) -> Unit,
) = ListRow(
    title, index, count, line, icon, iconDisc = true, onClick = { onOpen(page) },
    modifier = Modifier.semantics { testTag = "settings-" + page.lowercase().replace(" ", "-").replace("&", "and") },
)
