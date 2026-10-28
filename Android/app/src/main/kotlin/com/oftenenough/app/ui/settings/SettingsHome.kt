@file:OptIn(androidx.compose.material3.ExperimentalMaterial3Api::class)

package com.oftenenough.app.ui.settings

import com.oftenenough.app.ui.theme.Symbols
import androidx.compose.foundation.layout.WindowInsets
import com.oftenenough.app.ui.components.NavigationIcon
import com.oftenenough.app.ui.components.AppTopBar
import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
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
        AppTopBar("Settings", navigationIcon = {
            NavigationIcon(Symbols.ArrowBack, "Back", onBack, Modifier.semantics { testTag = "page-back" })
        }, windowInsets = WindowInsets(0))
        Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 16.dp).navigationBarsPadding()) {
            Group("Your day")
            SegmentedList {
                Row("Times of Day", "Morning, Afternoon, Evening and your own", Symbols.ViewWeek, 0, 2, SettingsPage.TIMES_OF_DAY, onOpen)
                Row("Day and Week", "When a new day starts, and which day a week starts on", Symbols.CalendarMonth, 1, 2, SettingsPage.DAY_AND_WEEK, onOpen)
            }
            Group("The app")
            SegmentedList {
                Row("Reminders", "Every habit that reminds you, and when", Symbols.Notifications, 0, 2, SettingsPage.REMINDERS, onOpen)
                Row("Appearance", "Theme, streaks and what a done habit does", Symbols.Contrast, 1, 2, SettingsPage.APPEARANCE, onOpen)
            }
            Group("Your habits")
            SegmentedList {
                Row("Backup & Sync", "Google Drive, backup files and restoring", Symbols.Cloud, 0, 2, SettingsPage.BACKUP, onOpen)
                Row("Privacy & Security", "App lock, and hiding names outside the app", Symbols.Shield, 1, 2, SettingsPage.PRIVACY, onOpen)
            }
            Group("About")
            SegmentedList {
                Row("Help", "Answers to the things people ask", Symbols.Help, 0, 2, SettingsPage.HELP, onOpen)
                Row("About", "Version, licences and what the app promises", Symbols.Info, 1, 2, SettingsPage.ABOUT, onOpen)
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
