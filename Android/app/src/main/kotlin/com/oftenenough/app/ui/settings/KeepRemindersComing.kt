package com.oftenenough.app.ui.settings

import android.Manifest
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.stateDescription
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleEventObserver
import androidx.lifecycle.compose.LocalLifecycleOwner
import com.oftenenough.app.app.reminders.Reminders
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.components.ListAction
import com.oftenenough.app.ui.components.ListAvatar
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.newhabit.FormPage
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.Symbols

/**
 * One of this phone maker's own steps (A40): its icon, what to do, where it is, and the page that opens. [checked]: the
 * app can read it (battery set to Unrestricted); otherwise it's ticked once opened and come back from.
 */
internal class MakerStep(
    val key: String, val icon: ImageVector, val title: String, val path: String, val checked: ((Context) -> Boolean)? = null,
    val intent: (Context) -> Intent,
)

/** A phone maker's lead line and steps (A40; Figma's "Keep reminders coming on each phone"). */
internal class Maker(val lead: String, val steps: List<MakerStep>)

private fun appInfo(c: Context) = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, Uri.parse("package:" + c.packageName))
private fun component(pkg: String, cls: String) = Intent().setComponent(ComponentName(pkg, cls))
private val unrestricted: (Context) -> Boolean = { !Reminders.batteryRestricted(it) }

/**
 * The steps for this phone, by `Build.MANUFACTURER` (menu names change with versions: A40 asks for each to be checked
 * on a real phone before release). A page a phone doesn't have opens App info instead ([openSettingsPage], U40).
 */
internal fun maker(manufacturer: String): Maker = when (manufacturer.lowercase()) {
    "samsung" -> Maker("Samsung puts apps to sleep to save battery, which can stop reminders. Two steps keep Often Enough awake.", listOf(
        MakerStep("samsung-battery", Symbols.BatteryFull, "Set battery to Unrestricted", "App info › Battery", unrestricted, ::appInfo),
        MakerStep("samsung-sleeping", Symbols.Bedtime, "Keep it out of sleeping apps", "Battery › Background usage limits › Never auto sleeping apps") {
            component("com.samsung.android.lool", "com.samsung.android.sm.battery.ui.BatteryActivity")
        },
    ))
    "xiaomi", "redmi", "poco" -> Maker("Xiaomi stops apps in the background to save battery, which can stop reminders. Two steps keep Often Enough running.", listOf(
        MakerStep("xiaomi-autostart", Symbols.Autorenew, "Turn on Autostart", "App info › Autostart") {
            component("com.miui.securitycenter", "com.miui.permcenter.autostart.AutoStartManagementActivity")
        },
        MakerStep("xiaomi-battery-saver", Symbols.BatterySaver, "Set Battery saver to No restrictions", "App info › Battery saver") { c ->
            component("com.miui.powerkeeper", "com.miui.powerkeeper.ui.HiddenAppsConfigActivity")
                .putExtra("package_name", c.packageName).putExtra("package_label", "Often Enough")
        },
    ))
    "oneplus", "oppo", "realme" -> Maker("Your phone stops apps in the background to save battery, which can stop reminders. Two switches keep Often Enough running.", listOf(
        MakerStep("oppo-background", Symbols.Sync, "Allow background activity", "App info › Battery usage", intent = ::appInfo),
        MakerStep("oppo-auto-launch", Symbols.Autorenew, "Allow auto launch", "App info › Battery usage", intent = ::appInfo),
    ))
    "vivo", "iqoo" -> Maker("vivo stops apps in the background to save battery, which can stop reminders. Two steps keep Often Enough running.", listOf(
        MakerStep("vivo-background-power", Symbols.Bolt, "Allow high background power use", "Settings › Battery › Background power consumption management") {
            component("com.iqoo.powersaving", "com.iqoo.powersaving.PowerSavingManagerActivity")
        },
        MakerStep("vivo-autostart", Symbols.Autorenew, "Turn on Autostart", "App info › Autostart") {
            component("com.vivo.permissionmanager", "com.vivo.permissionmanager.activity.BgStartUpManagerActivity")
        },
    ))
    "honor", "huawei" -> Maker("Your phone closes apps to save battery, which can stop reminders. One step keeps Often Enough running.", listOf(
        MakerStep("huawei-app-launch", Symbols.RocketLaunch, "Manage App launch yourself, all three on", "Settings › Battery › App launch › Often Enough") {
            if (manufacturer.equals("honor", ignoreCase = true)) component("com.hihonor.systemmanager", "com.hihonor.systemmanager.startupmgr.ui.StartupNormalAppListActivity")
            else component("com.huawei.systemmanager", "com.huawei.systemmanager.startupmgr.ui.StartupNormalAppListActivity")
        },
    ))
    else -> Maker("Your phone can put apps to sleep to save battery, which can stop reminders. One step keeps Often Enough awake.", listOf(
        MakerStep("battery", Symbols.BatteryFull, "Set battery to Unrestricted", "App info › App battery usage", unrestricted, ::appInfo),
    ))
}

private const val PREFS = "keep_reminders"

/** A step is done when the app can read that it's so (battery Unrestricted), or once it has been opened (A40). */
private fun stepDone(context: Context, step: MakerStep): Boolean =
    step.checked?.invoke(context) ?: context.getSharedPreferences(PREFS, Context.MODE_PRIVATE).getBoolean(step.key, false)

/**
 * How many of this page's rows are still to do: notifications, alarms & reminders, and this phone maker's steps.
 * Settings' row counts with it ("1 thing to fix", or All set at 0; Figma 1173:547, A40, A70).
 */
fun remindersLeftToFix(context: Context): Int =
    (if (Reminders.canPost(context)) 0 else 1) + (if (Reminders.canBeExact(context)) 0 else 1) +
        maker(Build.MANUFACTURER ?: "").steps.count { !stepDone(context, it) }

/**
 * 5.8.1, **Keep reminders coming** (Figma 804:192; flows on the Today and Settings pages; A40, A66, A70; Components —
 * Atoms Build Plan). From a reminder notice's Show me how and from Settings › Keep reminders coming. On Surface
 * container: the Top app bar (← "Keep reminders coming"); 16 at the sides, 8 above, 40 under, 24 between: the lead in
 * Body Large On surface variant (this phone maker's, or "No habit has a reminder yet. …" while none has one);
 * **Permissions** (Label Large Primary) over one list on Surface bright: Allow notifications (App info › Notifications;
 * Allow) and Allow alarms & reminders (Special app access › Alarms & reminders; Open settings), then this phone's own
 * steps, each its own row with its own icon. A row still to do shows its button under its words (Tonal, Small); a row
 * that's done turns its icon into a check (A70). The footer, "These change only Often Enough. Other apps keep saving
 * battery." in Body Medium On surface variant. Everything is read again when the page comes back from Settings.
 */
@Composable
fun KeepRemindersComingPage(store: HabitStore, onBack: () -> Unit) {
    val context = LocalContext.current
    val s = MaterialTheme.colorScheme
    var refresh by remember { mutableIntStateOf(0) }
    val lifecycle = LocalLifecycleOwner.current.lifecycle
    DisposableEffect(lifecycle) {
        val observer = LifecycleEventObserver { _, e -> if (e == Lifecycle.Event.ON_RESUME) refresh++ }
        lifecycle.addObserver(observer)
        onDispose { lifecycle.removeObserver(observer) }
    }
    val askNotifications = rememberLauncherForActivityResult(ActivityResultContracts.RequestPermission()) { refresh++ }
    val prefs = remember { context.getSharedPreferences(PREFS, Context.MODE_PRIVATE) }
    val phone = remember { maker(Build.MANUFACTURER ?: "") }
    val notifications = remember(refresh) { Reminders.canPost(context) }
    val exact = remember(refresh) { Reminders.canBeExact(context) }
    val done = remember(refresh) { phone.steps.associate { st -> st.key to stepDone(context, st) } }
    val anyReminder = store.habits.any(::hasReminders)

    FormPage("Keep reminders coming", onBack = onBack) {
        Column(Modifier.padding(top = 8.dp, bottom = 16.dp), verticalArrangement = Arrangement.spacedBy(24.dp)) {
            Text(if (anyReminder) phone.lead else "No habit has a reminder yet. When one does, these steps make sure it comes on time. You can do them now or later.",
                Modifier.padding(horizontal = 16.dp).semantics { testTag = "keep-reminders-lead" }, style = AppType.bodyLarge, color = s.onSurfaceVariant)
            Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                Text("Permissions", Modifier.padding(horizontal = 16.dp).semantics { heading() }, style = AppType.labelLarge, color = s.primary)
                SegmentedList {
                    val count = 2 + phone.steps.size
                    PermissionRow(Symbols.Notifications, "Allow notifications", "App info › Notifications", notifications, "Allow", 0, count, "check-notifications") {
                        if (Build.VERSION.SDK_INT >= 33) askNotifications.launch(Manifest.permission.POST_NOTIFICATIONS)
                        else openSettingsPage(context, Intent(Settings.ACTION_APP_NOTIFICATION_SETTINGS).putExtra(Settings.EXTRA_APP_PACKAGE, context.packageName))
                    }
                    PermissionRow(Symbols.Alarm, "Allow alarms & reminders", "Special app access › Alarms & reminders", exact, "Open settings", 1, count, "check-exact") {
                        if (Build.VERSION.SDK_INT >= 31) openSettingsPage(context, Intent(Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM, Uri.parse("package:" + context.packageName)))
                    }
                    phone.steps.forEachIndexed { i, st ->
                        PermissionRow(st.icon, st.title, st.path, done[st.key] == true, "Open settings", 2 + i, count, "check-${st.key}") {
                            // A step the app can't read is ticked once it's been opened (A40).
                            if (st.checked == null) prefs.edit().putBoolean(st.key, true).apply()
                            openSettingsPage(context, st.intent(context))
                        }
                    }
                }
                Text("These change only Often Enough. Other apps keep saving battery.", Modifier.padding(horizontal = 16.dp),
                    style = AppType.bodyMedium, color = s.onSurfaceVariant)
            }
        }
    }
}

/** One permission or step (A70): its icon turns into the check once it's done; until then its button sits under the words. */
@Composable
private fun PermissionRow(icon: ImageVector, title: String, path: String, ok: Boolean, fix: String, index: Int, count: Int, tag: String, onFix: () -> Unit) =
    AppListItem(
        title, index, count, Modifier.semantics { if (ok) stateDescription = "Done" }, path, tag = tag,
        leading = { ListAvatar(if (ok) Symbols.Check else icon, done = ok) },
        below = if (ok) null else ({ ListAction(fix, onFix, "$tag-fix") }),
        containerColor = MaterialTheme.colorScheme.surfaceBright,
    )
