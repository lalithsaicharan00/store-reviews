package com.oftenenough.app.ui.settings

import android.content.Intent
import android.net.Uri
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.role
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.semantics.toggleableState
import androidx.compose.ui.state.ToggleableState
import androidx.compose.ui.unit.dp
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleEventObserver
import androidx.lifecycle.compose.LocalLifecycleOwner
import com.oftenenough.app.app.Prefs
import com.oftenenough.app.app.backup.BackupCenter
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.HabitCopy
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.backup.backupSummary
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.components.AppSwitch
import com.oftenenough.app.ui.components.AppTopBar
import com.oftenenough.app.ui.components.ListAvatar
import com.oftenenough.app.ui.components.ListChevron
import com.oftenenough.app.ui.components.NavigationIcon
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.Symbols

/** Every page the app opens by its own name (the routes are `page/<title>`). */
object SettingsPage {
    /** The old Progress page: nothing opens it since the Habits tab became that page (A54); it goes with cleanup 6.2. */
    const val PROGRESS = "Progress"
    const val TIMES_OF_DAY = "Times of Day"
    const val DAY_AND_WEEK = "Day and Week"
    const val NEW_DAY = "New day starts at"
    const val REMINDERS = "Reminders"
    const val APPEARANCE = "Appearance"
    const val BACKUP = "Backup & Sync"
    /** App Lock's page: no row opens it (A27); it goes with cleanup 6.5. */
    const val PRIVACY = "Privacy & Security"
    const val LICENCES = "Open source licences"
}

/** The privacy policy on the website, always the current one (Figma's flow "Privacy policy"). */
private const val PRIVACY_POLICY = "https://oftenenough.com/privacy"

/**
 * 5.8.3, **Settings** (Figma 1173:547, Screen Default · End of the list · Nothing set up; the flows on the settings page;
 * A28: one of the menu's five places). On Surface container: the Top app bar (≡ "Settings", Title Large Emphasized);
 * then, scrolling, 8 above, 16 at the sides, 40 under, 24 between: five sections, each a Label Large Primary heading 16
 * in and, 8 under it, one List of List items (Two lines, Surface bright, the icon in its circle):
 *
 * - **Backup:** Backup & Sync, saying what the page's card says ("Backed up · Today, 9:14 AM", or Not backed up yet).
 * - **Your day:** Times of day (their names), New day starts at (12:00 AM), Week starts on (Sunday).
 * - **Reminders:** Keep reminders coming: No reminders yet while no habit reminds; then what's left to do, "3 things to
 *   fix" … "1 thing to fix" (notification_important), and All set (notifications_active) (A40, A70).
 * - **General:** Theme (System default), Vibration ("A light buzz as you log", on by default) and Sound when done ("Plays
 *   when a goal is met", off): the whole row toggles, not just the switch.
 * - **About:** Privacy policy ("Opens in your browser", ↗), Open-source licences ("The libraries we use", ›), Version
 *   ("1.0 (1)", not tappable).
 *
 * Every row that opens something to change has › and its current value under its name. [openMenu] is null where the
 * menu is a sidebar beside the page.
 */
@Composable
fun SettingsHome(store: HabitStore, prefs: Prefs, backup: BackupCenter, openMenu: (() -> Unit)?, onOpen: (String) -> Unit) {
    val context = LocalContext.current
    val s = MaterialTheme.colorScheme
    // What Keep reminders coming counts is read again when the person comes back from Android's settings (U40).
    var refresh by remember { mutableIntStateOf(0) }
    val lifecycle = LocalLifecycleOwner.current.lifecycle
    DisposableEffect(lifecycle) {
        val observer = LifecycleEventObserver { _, e -> if (e == Lifecycle.Event.ON_RESUME) refresh++ }
        lifecycle.addObserver(observer)
        onDispose { lifecycle.removeObserver(observer) }
    }
    LaunchedEffect(backup) { backup.refreshStatus() }
    val anyReminder = store.habits.any(::hasReminders)
    val toFix = remember(refresh, anyReminder) { if (anyReminder) remindersLeftToFix(context) else 0 }

    Column(Modifier.fillMaxSize().background(s.surfaceContainer).semantics { testTag = "settings-page" }) {
        AppTopBar("Settings", navigationIcon = {
            openMenu?.let { NavigationIcon(Symbols.Menu, "Menu", it, Modifier.semantics { testTag = "settings-menu" }) }
        })
        Column(
            Modifier.weight(1f).verticalScroll(rememberScrollState()).semantics { testTag = "settings-list" }
                .navigationBarsPadding().padding(start = 16.dp, end = 16.dp, top = 8.dp, bottom = 40.dp),
            verticalArrangement = Arrangement.spacedBy(24.dp),
        ) {
            Section("Backup") {
                val (icon, line) = backupSummary(backup, store)
                Row("Backup & Sync", line, icon, 0, 1, "settings-backup-and-sync") { onOpen(SettingsPage.BACKUP) }
            }
            Section("Your day") {
                Row("Times of day", store.timedSections().joinToString(", ") { it.first.name }.ifEmpty { "Anytime" }, Symbols.Schedule, 0, 3,
                    "settings-times-of-day") { onOpen(SettingsPage.TIMES_OF_DAY) }
                Row("New day starts at", DayWords.clockMinute(store.dayEndHour * 60), Symbols.Bedtime, 1, 3, "settings-new-day") {
                    onOpen(SettingsPage.NEW_DAY)
                }
                Row("Week starts on", HabitCopy.fullDays[store.weekStart - 1], Symbols.DateRange, 2, 3, "settings-week-start") {
                    onOpen(SettingsPage.DAY_AND_WEEK)
                }
            }
            Section("Reminders") {
                val (icon, line) = when {
                    !anyReminder -> Symbols.Notifications to "No reminders yet"
                    toFix == 0 -> Symbols.NotificationsActive to "All set"
                    else -> Symbols.NotificationImportant to "$toFix ${if (toFix == 1) "thing" else "things"} to fix"
                }
                Row("Keep reminders coming", line, icon, 0, 1, "settings-reminders") { onOpen(SettingsPage.REMINDERS) }
            }
            Section("General") {
                Row("Theme", themeName(prefs.theme), Symbols.Contrast, 0, 3, "settings-theme") { onOpen(SettingsPage.APPEARANCE) }
                Toggle("Vibration", "A light buzz as you log", Symbols.Vibration, prefs.vibration, 1, 3, "settings-vibration") { prefs.vibration = it }
                Toggle("Sound when done", "Plays when a goal is met", Symbols.VolumeUp, prefs.sound, 2, 3, "settings-sound") { prefs.sound = it }
            }
            Section("About") {
                Row("Privacy policy", "Opens in your browser", Symbols.Policy, 0, 3, "settings-privacy-policy", trailing = { Icon(Symbols.OpenInNew, null) }) {
                    runCatching { context.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(PRIVACY_POLICY))) }
                }
                Row("Open-source licences", "The libraries we use", Symbols.Code, 1, 3, "settings-licences") { onOpen(SettingsPage.LICENCES) }
                Row("Version", Support.appVersion, Symbols.Info, 2, 3, "settings-version", trailing = null, onClick = null)
            }
        }
    }
}

/** Theme's value as Android names it. */
fun themeName(theme: String): String = when (theme) { "light" -> "Light"; "dark" -> "Dark"; else -> "System default" }

/** A section: its heading (Label Large, Primary, 16 in), 8 above its one list. */
@Composable
private fun Section(title: String, rows: @Composable ColumnScope.() -> Unit) =
    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
        Text(title, Modifier.padding(horizontal = 16.dp).semantics { heading() }, style = AppType.labelLarge, color = MaterialTheme.colorScheme.primary)
        SegmentedList(content = rows)
    }

/** A row (List item, Two lines, on Surface bright): its icon in its circle, the name, the value under it, and ›. */
@Composable
private fun Row(
    title: String, line: String, icon: ImageVector, index: Int, count: Int, tag: String,
    modifier: Modifier = Modifier,
    trailing: (@Composable () -> Unit)? = { ListChevron() },
    onClick: (() -> Unit)?,
) = AppListItem(
    title, index, count, modifier, supporting = line, leading = { ListAvatar(icon) }, trailing = trailing, onClick = onClick, tag = tag,
    containerColor = MaterialTheme.colorScheme.surfaceBright,
)

/** A row that's on or off: the whole row toggles, and TalkBack reads it as the switch it is. */
@Composable
private fun Toggle(title: String, line: String, icon: ImageVector, checked: Boolean, index: Int, count: Int, tag: String, onChange: (Boolean) -> Unit) =
    Row(title, line, icon, index, count, tag, Modifier.semantics { role = Role.Switch; toggleableState = ToggleableState(checked) },
        trailing = { AppSwitch(checked) }) { onChange(!checked) }
