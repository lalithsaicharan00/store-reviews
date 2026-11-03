package com.oftenenough.app.ui.settings

import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
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
 * app can read it (battery Unrestricted); otherwise it never shows a check (A109).
 */
internal class MakerStep(
    val key: String, val icon: ImageVector, val title: String, val path: String, val checked: ((Context) -> Boolean)? = null,
    val intent: (Context) -> Intent,
)

/** A phone maker's lead line and steps (A40; Figma's "Keep reminders coming on each phone"). */
internal class Maker(val lead: String, val steps: List<MakerStep>)

private fun appInfo(c: Context) = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, Uri.parse("package:" + c.packageName))
private fun component(pkg: String, cls: String) = Intent().setComponent(ComponentName(pkg, cls))
private val unrestricted: (Context) -> Boolean = { !Reminders.notUnrestricted(it) }

/**
 * Android's own one-tap question, "Let Often Enough always run in the background? Allow / Deny", which sets battery to
 * Unrestricted (A109, the user's choice, 3 Nov 2026): no app can open the inner Allow background usage page, only App
 * battery usage above it, where people were lost. A phone without the question opens App info ([openSettingsPage], U40).
 */
internal fun unrestrictedQuestion(c: Context) = Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS, Uri.parse("package:" + c.packageName))

/** The step every phone has, and the one the app can read (A109). */
private val batteryStep = MakerStep("battery", Symbols.BatteryFull, "Set battery to Unrestricted", "Your phone asks: tap Allow", unrestricted, ::unrestrictedQuestion)

/**
 * The steps for this phone, by `Build.MANUFACTURER` (menu names change with versions: A40 asks for each to be checked
 * on a real phone before release). A page a phone doesn't have opens App info instead ([openSettingsPage], U40).
 */
internal fun maker(manufacturer: String): Maker = when (manufacturer.lowercase()) {
    "samsung" -> Maker("Samsung puts apps to sleep to save battery, which can stop reminders. Two steps keep Often Enough awake.", listOf(
        MakerStep("samsung-battery", Symbols.BatteryFull, "Set battery to Unrestricted", "Your phone asks: tap Allow", unrestricted, ::unrestrictedQuestion),
        MakerStep("samsung-sleeping", Symbols.Bedtime, "Keep it out of sleeping apps", "Battery › Background usage limits › Never auto sleeping apps") {
            component("com.samsung.android.lool", "com.samsung.android.sm.battery.ui.BatteryActivity")
        },
    ))
    "xiaomi", "redmi", "poco" -> Maker("Xiaomi stops apps in the background to save battery, which can stop reminders. Three steps keep Often Enough running.", listOf(
        batteryStep,
        MakerStep("xiaomi-autostart", Symbols.Autorenew, "Turn on Autostart", "App info › Autostart") {
            component("com.miui.securitycenter", "com.miui.permcenter.autostart.AutoStartManagementActivity")
        },
        MakerStep("xiaomi-battery-saver", Symbols.BatterySaver, "Set Battery saver to No restrictions", "App info › Battery saver") { c ->
            component("com.miui.powerkeeper", "com.miui.powerkeeper.ui.HiddenAppsConfigActivity")
                .putExtra("package_name", c.packageName).putExtra("package_label", "Often Enough")
        },
    ))
    "oneplus", "oppo", "realme" -> Maker("Your phone stops apps in the background to save battery, which can stop reminders. Three steps keep Often Enough running.", listOf(
        batteryStep,
        MakerStep("oppo-background", Symbols.Sync, "Allow background activity", "App info › Battery usage", intent = ::appInfo),
        MakerStep("oppo-auto-launch", Symbols.Autorenew, "Allow auto launch", "App info › Battery usage", intent = ::appInfo),
    ))
    "vivo", "iqoo" -> Maker("vivo stops apps in the background to save battery, which can stop reminders. Three steps keep Often Enough running.", listOf(
        batteryStep,
        MakerStep("vivo-background-power", Symbols.Bolt, "Allow high background power use", "Settings › Battery › Background power consumption management") {
            component("com.iqoo.powersaving", "com.iqoo.powersaving.PowerSavingManagerActivity")
        },
        MakerStep("vivo-autostart", Symbols.Autorenew, "Turn on Autostart", "App info › Autostart") {
            component("com.vivo.permissionmanager", "com.vivo.permissionmanager.activity.BgStartUpManagerActivity")
        },
    ))
    "honor", "huawei" -> Maker("Your phone closes apps to save battery, which can stop reminders. Two steps keep Often Enough running.", listOf(
        batteryStep,
        MakerStep("huawei-app-launch", Symbols.RocketLaunch, "Manage App launch yourself, all three on", "Settings › Battery › App launch › Often Enough") {
            if (manufacturer.equals("honor", ignoreCase = true)) component("com.hihonor.systemmanager", "com.hihonor.systemmanager.startupmgr.ui.StartupNormalAppListActivity")
            else component("com.huawei.systemmanager", "com.huawei.systemmanager.startupmgr.ui.StartupNormalAppListActivity")
        },
    ))
    else -> Maker("Your phone can put apps to sleep to save battery, which can stop reminders. One step keeps Often Enough awake.", listOf(
        batteryStep,
    ))
}

/**
 * A step is done only when the app can read that it is (battery Unrestricted); A109, the user, 3 Nov 2026: "the
 * permission should only showcase checkmark once it is actually done". A step no app can read (Samsung's sleeping apps,
 * Xiaomi's Autostart) never shows a check: its button stays.
 */
private fun stepDone(context: Context, step: MakerStep): Boolean = step.checked?.invoke(context) ?: false

/**
 * How many of this page's rows are still to do: notifications, alarms & reminders, and this phone maker's steps the app
 * can read (a step it can't read can never be shown done, so it never counts). Settings' row counts with it ("1 thing
 * to fix", or All set at 0; Figma 1173:547, A40, A70).
 */
fun remindersLeftToFix(context: Context): Int =
    (if (Reminders.canPost(context)) 0 else 1) + (if (Reminders.canBeExact(context)) 0 else 1) +
        maker(Build.MANUFACTURER ?: "").steps.count { it.checked != null && !stepDone(context, it) }

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
    val turnOn = rememberTurnOnNotifications { refresh++ }
    val phone = remember { maker(Build.MANUFACTURER ?: "") }
    val notifications = remember(refresh) { Reminders.canPost(context) }
    val exact = remember(refresh) { Reminders.canBeExact(context) }
    val done = remember(refresh) { phone.steps.associate { st -> st.key to stepDone(context, st) } }
    val anyReminder = store.habits.any(::hasReminders)

    FormPage("Keep reminders coming", onBack = onBack) {
        Column(Modifier.padding(top = 8.dp, bottom = 16.dp), verticalArrangement = Arrangement.spacedBy(24.dp)) {
            Text(if (anyReminder) keepLead(phone, notifications, exact, phone.steps.count { it.checked != null && done[it.key] != true }) else "No habit has a reminder yet. When one does, these steps make sure it comes on time. You can do them now or later.",
                Modifier.padding(horizontal = 16.dp).semantics { testTag = "keep-reminders-lead" }, style = AppType.bodyLarge, color = s.onSurfaceVariant)
            Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                Text("Permissions", Modifier.padding(horizontal = 16.dp).semantics { heading() }, style = AppType.labelLarge, color = s.primary)
                SegmentedList {
                    val count = 2 + phone.steps.size
                    PermissionRow(Symbols.Notifications, "Allow notifications", "App info › Notifications", notifications, "Allow", 0, count, "check-notifications", turnOn)
                    PermissionRow(Symbols.Alarm, "Allow alarms & reminders", "Special app access › Alarms & reminders", exact, "Open settings", 1, count, "check-exact") {
                        if (Build.VERSION.SDK_INT >= 31) openSettingsPage(context, Intent(Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM, Uri.parse("package:" + context.packageName)))
                    }
                    phone.steps.forEachIndexed { i, st ->
                        // Unrestricted is Android's own one-tap question, so Allow, as notifications' (A109).
                        PermissionRow(st.icon, st.title, st.path, done[st.key] == true, if (st.checked != null) "Allow" else "Open settings", 2 + i, count, "check-${st.key}") {
                            openSettingsPage(context, st.intent(context))
                        }
                    }
                }
            }
            // Its own group, 24 under the list (Figma's flows 18 and 19).
            Text("These change only Often Enough. Other apps keep saving battery.", Modifier.padding(horizontal = 16.dp),
                style = AppType.bodyMedium, color = s.onSurfaceVariant)
        }
    }
}

/**
 * The lead says what's left, as Figma's flows do (Today flows 38, 39): this phone's words while battery isn't
 * Unrestricted ([stepsLeft] counts only steps the app can read, A109), "All set." once everything is; with Alarms &
 * reminders off it leads with that, the one thing that makes reminders late. A phone with steps the app can't read
 * says so once the rest is done, since their buttons stay.
 */
internal fun keepLead(phone: Maker, notifications: Boolean, exact: Boolean, stepsLeft: Int): String = when {
    notifications && exact && stepsLeft == 0 && phone.steps.any { it.checked == null } ->
        "Battery is Unrestricted. Also do the step below, if you haven’t: your phone doesn’t let the app check it."
    notifications && exact && stepsLeft == 0 -> "All set. Reminders will come on time."
    !exact -> "Reminders may come late. Android sends them on time only when Alarms & reminders is allowed. It’s Android’s setting, not the app’s."
    stepsLeft > 0 -> phone.lead
    else -> "Reminders can’t come while notifications are off for Often Enough."
}

/** One permission or step (A70): its icon turns into the check once it's done; until then its button sits under the words. */
@Composable
private fun PermissionRow(icon: ImageVector, title: String, path: String, ok: Boolean, fix: String, index: Int, count: Int, tag: String, onFix: () -> Unit) =
    AppListItem(
        title, index, count, Modifier.semantics { if (ok) stateDescription = "Done" }, path, tag = tag,
        leading = { ListAvatar(if (ok) Symbols.Check else icon, done = ok) },
        below = if (ok) null else ({ ListAction(fix, onFix, "$tag-fix") }), topWithBelow = true, belowPadding = 12.dp,
        containerColor = MaterialTheme.colorScheme.surfaceBright,
    )
