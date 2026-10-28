package com.oftenenough.app.ui.settings

import androidx.compose.ui.semantics.stateDescription
import com.oftenenough.app.ui.components.ListChevron
import com.oftenenough.app.ui.components.ListAction
import com.oftenenough.app.ui.components.ListAvatar
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import android.Manifest
import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleEventObserver
import androidx.lifecycle.compose.LocalLifecycleOwner
import com.oftenenough.app.app.reminders.Reminders
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.components.CookieShape
import com.oftenenough.app.ui.newhabit.FormPage
import com.oftenenough.app.ui.newhabit.GroupTitle
import com.oftenenough.app.ui.newhabit.Note
import com.oftenenough.app.ui.theme.appColors

/** A habit's reminders in one line: "8:00 AM · 2:00 PM · Notification", "8:00 AM · Alarm · Again every 15 min". */
fun reminderLine(habit: Habit): String {
    val times = habit.reminders.sortedBy { it.minuteOfDay }.map { DayWords.clockMinute(it.minuteOfDay) }
    val how = if (habit.alert == "alarm") "Alarm" else "Notification"
    val again = habit.followUpMinutes?.takeIf { it > 0 }?.let { "Again every $it min" }
    return (times + how + listOfNotNull(again)).joinToString(" · ")
}

/** Whether a habit has reminders that can ring (on, with at least one time, still going). */
fun hasReminders(habit: Habit) = habit.remind && habit.reminders.isNotEmpty() && !habit.archived

/** Why a phone's reminder didn't arrive, by maker: Samsung's sleeping apps, Xiaomi's autostart, and every other phone. */
fun missedReason(maker: String): String = when {
    maker.equals("samsung", ignoreCase = true) ->
        "Samsung phones put apps to sleep to save battery, and that can stop reminders. Keeping Often Enough out of sleeping apps fixes it."
    maker.equals("xiaomi", ignoreCase = true) || maker.equals("redmi", ignoreCase = true) || maker.equals("poco", ignoreCase = true) ->
        "Xiaomi phones stop apps in the background to save battery, and that can stop reminders. Letting Often Enough run in the background fixes it."
    else -> "This phone stopped Often Enough in the background to save battery, and that can stop reminders. Letting it run in the background fixes it."
}

/**
 * ≡ › Reminders (design §15, A11 D1–D3): the reminder check (what this phone allows, so reminders arrive on time:
 * notifications, exact times, battery), a reminder that didn't arrive when there was one, then each habit with its
 * reminders and those without. A habit opens its form to change them.
 */
@Composable
fun RemindersSettingsPage(store: HabitStore, onEdit: (Habit) -> Unit, onBack: () -> Unit) {
    val context = LocalContext.current
    // Read again whenever the page comes back from the phone's settings.
    var refresh by remember { mutableIntStateOf(0) }
    val lifecycle = LocalLifecycleOwner.current.lifecycle
    DisposableEffect(lifecycle) {
        val observer = LifecycleEventObserver { _, e -> if (e == Lifecycle.Event.ON_RESUME) refresh++ }
        lifecycle.addObserver(observer)
        onDispose { lifecycle.removeObserver(observer) }
    }
    val askNotifications = rememberLauncherForActivityResult(ActivityResultContracts.RequestPermission()) { refresh++ }
    val notifications = remember(refresh) { Reminders.canPost(context) }
    val exact = remember(refresh) { Reminders.canBeExact(context) }
    val battery = remember(refresh) { !Reminders.batteryRestricted(context) }
    val missed = remember(refresh) { Reminders.missed(context, store.clock()) }
    val habits = store.habits.filter { !it.archived && it.kind != HabitKind.Quit }
    val withReminders = habits.filter(::hasReminders)
    val without = habits.filter { !hasReminders(it) }

    FormPage("Reminders", chip = null, onBack = onBack) {
        Spacer(Modifier.height(8.dp))
        if (missed != null) {
            val name = store.habit(missed.habitId)?.name
            Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(28.dp)).background(appColors.surface).padding(20.dp).semantics { testTag = "reminder-missed" }) {
                Row(verticalAlignment = Alignment.Top) {
                    Icon(Symbols.NotificationsOff, null, tint = appColors.ink)
                    Spacer(Modifier.width(16.dp))
                    Text((name?.let { "$it's " } ?: "A ") + DayWords.clockMinute(missed.minute) + " reminder didn't arrive",
                        style = MaterialTheme.typography.titleMedium.copy(fontWeight = FontWeight.Medium), color = appColors.ink)
                }
                Spacer(Modifier.height(8.dp))
                Text(missedReason(Build.MANUFACTURER), style = MaterialTheme.typography.bodyMedium, color = appColors.secondary)
                Spacer(Modifier.height(12.dp))
                Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.End, verticalAlignment = Alignment.CenterVertically) {
                    AppButton("Dismiss", { Reminders.dismissMissed(context); refresh++ }, Modifier.semantics { testTag = "reminder-missed-dismiss" }, style = ButtonStyle.Text)
                    Spacer(Modifier.width(8.dp))
                    AppButton("Show me how", { openBatterySettings(context) }, Modifier.semantics { testTag = "reminder-missed-fix" })
                }
            }
            Spacer(Modifier.height(16.dp))
        }
        SegmentedList {
            Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(28.dp, 28.dp, 4.dp, 4.dp)).background(appColors.surface).padding(20.dp)) {
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Icon(Symbols.FactCheck, null, tint = appColors.ink)
                    Spacer(Modifier.width(12.dp))
                    Text("Reminder check", style = MaterialTheme.typography.titleLarge.copy(fontWeight = FontWeight.Medium), color = appColors.ink)
                }
                Spacer(Modifier.height(4.dp))
                Text("What this phone allows, so your reminders arrive on time.", style = MaterialTheme.typography.bodyMedium, color = appColors.secondary)
            }
            CheckRow(Symbols.Notifications, "Notifications", if (notifications) "Allowed" else "Off: reminders can't show", notifications, "Allow", 1, 4, "check-notifications") {
                if (Build.VERSION.SDK_INT >= 33 && !notifications) askNotifications.launch(Manifest.permission.POST_NOTIFICATIONS)
                if (Build.VERSION.SDK_INT < 33 || notifications) openNotificationSettings(context)
            }
            CheckRow(Symbols.Alarm, "Exact times", if (exact) "Allowed" else "Off: reminders may come up to 10 minutes late", exact, "Allow", 2, 4, "check-exact") {
                if (Build.VERSION.SDK_INT >= 31) open(context, Intent(Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM, Uri.parse("package:" + context.packageName)))
            }
            CheckRow(Symbols.BatteryStd, "Battery", if (battery) "Not restricted" else "Often Enough can be stopped to save battery", battery, "Fix", 3, 4, "check-battery") {
                openBatterySettings(context)
            }
        }
        if (withReminders.isNotEmpty()) {
            GroupTitle("With reminders")
            SegmentedList { withReminders.forEachIndexed { i, h -> HabitReminderRow(h, reminderLine(h), i, withReminders.size) { onEdit(h) } } }
            Note("Only planned days are scheduled. Completing it stops that day's reminders; paused and archived items stay saved without alerting you.")
        }
        if (without.isNotEmpty()) {
            GroupTitle("Without reminders")
            SegmentedList { without.forEachIndexed { i, h -> HabitReminderRow(h, "Reminders off", i, without.size) { onEdit(h) } } }
        }
        if (habits.isEmpty()) Note("Habits you add show here, with their reminders.")
        Spacer(Modifier.height(24.dp))
    }
}

/** One permission (A70): its icon turns into the ✓ once it's allowed; until then its fix sits under the words. */
@Composable
private fun CheckRow(icon: ImageVector, title: String, state: String, ok: Boolean, fix: String, index: Int, count: Int, tag: String, onFix: () -> Unit) =
    AppListItem(
        title, index, count, Modifier.semantics { if (ok) stateDescription = "Allowed" }, state, tag = tag,
        leading = { ListAvatar(if (ok) Symbols.Check else icon, done = ok) },
        below = if (ok) null else ({ ListAction(fix, onFix, "$tag-fix") }),
    )

@Composable
private fun HabitReminderRow(habit: Habit, line: String, index: Int, count: Int, onClick: () -> Unit) =
    AppListItem(
        habit.name, index, count, supporting = line, headlineLines = 1, onClick = onClick, tag = "reminders-habit-" + habit.name,
        leading = { HabitIcon(habit.symbol, habit.color, 40.dp, CookieShape()) }, trailing = { ListChevron() },
    )

private fun open(context: Context, intent: Intent) {
    try { context.startActivity(intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)) }
    catch (e: ActivityNotFoundException) { openAppSettings(context) }
}

private fun openNotificationSettings(context: Context) =
    open(context, Intent(Settings.ACTION_APP_NOTIFICATION_SETTINGS).putExtra(Settings.EXTRA_APP_PACKAGE, context.packageName))

/** The phone's battery optimisation list (Samsung and Xiaomi keep their own pages; this one exists on every phone). */
private fun openBatterySettings(context: Context) = open(context, Intent(Settings.ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS))

private fun openAppSettings(context: Context) {
    try {
        context.startActivity(Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, Uri.parse("package:" + context.packageName)).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK))
    } catch (_: ActivityNotFoundException) {}
}
