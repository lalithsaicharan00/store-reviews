package com.oftenenough.app.ui.settings

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
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.outlined.Alarm
import androidx.compose.material.icons.outlined.BatteryAlert
import androidx.compose.material.icons.outlined.BatteryFull
import androidx.compose.material.icons.outlined.Notifications
import androidx.compose.material.icons.outlined.OpenInNew
import androidx.compose.material.icons.rounded.CheckCircle
import androidx.compose.material.icons.rounded.Error
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleEventObserver
import androidx.lifecycle.compose.LocalLifecycleOwner
import com.oftenenough.app.app.Prefs
import com.oftenenough.app.app.reminders.Reminders
import com.oftenenough.app.ui.components.InkButton
import com.oftenenough.app.ui.components.Segment
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.newhabit.FormPage
import com.oftenenough.app.ui.newhabit.GroupTitle
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors

/**
 * One step this phone's maker asks for, in the maker's own words (A40): what to do, where it is, and the page Open
 * goes to. The app can't read a maker's own list, so a step is ticked once it has been opened and come back from.
 */
class MakerStep(val title: String, val where: String, val open: (Context) -> Unit)

/**
 * What this phone's maker does to background apps, and the steps that stop it (A40, 22 Oct 2026; sources:
 * dontkillmyapp.com and the makers' own guides, which are third-party and version-scoped, W2). **Menu names change
 * with each version: check every one on a real phone before release.**
 */
object PhoneMaker {
    /** The maker as the person would name it, from the phone itself. */
    fun name(maker: String = Build.MANUFACTURER): String = when (lower(maker)) {
        "samsung" -> "Samsung"
        "xiaomi", "redmi", "poco" -> "Xiaomi"
        "oneplus" -> "OnePlus"
        "oppo" -> "OPPO"
        "realme" -> "realme"
        "vivo", "iqoo" -> "vivo"
        "honor" -> "Honor"
        "huawei" -> "Huawei"
        "google" -> "Google"
        else -> maker.replaceFirstChar { it.uppercase() }
    }

    private fun lower(maker: String) = maker.trim().lowercase()

    /** The notice's words on Today: why this phone can stop a reminder (A40, Today flows 38 and 40). */
    fun whyMissed(maker: String = Build.MANUFACTURER): String = when (lower(maker)) {
        "samsung" -> "Samsung phones put apps to sleep to save battery, and that can stop reminders."
        "xiaomi", "redmi", "poco" -> "Xiaomi phones stop apps in the background to save battery, and that can stop reminders."
        "oneplus", "oppo", "realme", "vivo", "iqoo" ->
            "${name(maker)} phones stop apps in the background to save battery, and that can stop reminders."
        "honor", "huawei" -> "${name(maker)} phones close apps to save battery, and that can stop reminders."
        else -> "Your phone can put apps to sleep to save battery, and that can stop reminders."
    }

    /** The page's lead line while there is something to do. */
    fun lead(maker: String = Build.MANUFACTURER): String = when (lower(maker)) {
        "samsung" -> "Samsung puts apps to sleep to save battery, which can stop reminders. Two steps keep Often Enough awake."
        "xiaomi", "redmi", "poco" -> "Xiaomi stops apps in the background to save battery, which can stop reminders. Two steps keep Often Enough running."
        "oneplus", "oppo", "realme" -> "Your phone stops apps in the background to save battery, which can stop reminders. Two switches keep Often Enough running."
        "vivo", "iqoo" -> "vivo stops apps in the background to save battery, which can stop reminders. Two steps keep Often Enough running."
        "honor", "huawei" -> "Your phone closes apps to save battery, which can stop reminders. One step keeps Often Enough running."
        else -> "Your phone can put apps to sleep to save battery, which can stop reminders. One step keeps Often Enough awake."
    }

    /** How the battery row reads while the phone may still stop the app. */
    fun batteryRisk(maker: String = Build.MANUFACTURER): String =
        if (lower(maker) == "samsung") "Can be put to sleep" else "Can be stopped in the background"

    fun steps(maker: String = Build.MANUFACTURER): List<MakerStep> = when (lower(maker)) {
        "samsung" -> listOf(
            MakerStep("Set battery to Unrestricted", "App info › Battery", ::openAppInfo),
            MakerStep("Keep it out of sleeping apps", "Battery › Background usage limits › Never auto sleeping apps", ::openBattery),
        )
        "xiaomi", "redmi", "poco" -> listOf(
            MakerStep("Turn on Autostart", "App info › Autostart", ::openAppInfo),
            MakerStep("Set Battery saver to No restrictions", "App info › Battery saver", ::openAppInfo),
        )
        "oneplus", "oppo", "realme" -> listOf(
            MakerStep("Allow background activity", "App info › Battery usage", ::openAppInfo),
            MakerStep("Allow auto launch", "App info › Battery usage", ::openAppInfo),
        )
        "vivo", "iqoo" -> listOf(
            MakerStep("Allow high background power use", "Settings › Battery › Background power consumption management", ::openBattery),
            MakerStep("Turn on Autostart", "App info › Autostart", ::openAppInfo),
        )
        "honor", "huawei" -> listOf(
            MakerStep("Manage App launch yourself, all three on", "Settings › Battery › App launch › Often Enough", ::openBattery),
        )
        else -> listOf(
            MakerStep("Set battery to Unrestricted", "App info › App battery usage", ::openAppInfo),
        )
    }

    private fun open(context: Context, intent: Intent) {
        try { context.startActivity(intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)) }
        catch (_: ActivityNotFoundException) { openAppInfo(context) }
    }

    /** Often Enough's own App info page, where every maker keeps its per-app battery switches. */
    fun openAppInfo(context: Context) {
        try {
            context.startActivity(Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, Uri.parse("package:" + context.packageName))
                .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK))
        } catch (_: ActivityNotFoundException) {}
    }

    /** The phone's battery settings; falls back to App info where a maker has no such page. */
    fun openBattery(context: Context) = open(context, Intent(Settings.ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS))

    fun openNotifications(context: Context) =
        open(context, Intent(Settings.ACTION_APP_NOTIFICATION_SETTINGS).putExtra(Settings.EXTRA_APP_PACKAGE, context.packageName))

    fun openExactAlarms(context: Context) {
        if (Build.VERSION.SDK_INT >= 31) open(context, Intent(Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM, Uri.parse("package:" + context.packageName)))
        else openAppInfo(context)
    }
}

/**
 * **Keep reminders coming** (A40, 22 Oct 2026; Today flows 38–40). One page, opened straight from Today's notice —
 * no trip through Settings — and from Settings › Reminders. A plain lead line; **What this phone allows**
 * (Notifications, Alarms & reminders, Battery: each ticked when the app can check it, or with its fix button); then
 * **this phone maker's steps** in the maker's own words, each with **Open** to that exact settings page and ticked
 * once it has been opened and come back from; then **Good to know**.
 */
@Composable
fun KeepRemindersPage(prefs: Prefs, onBack: () -> Unit) {
    val context = LocalContext.current
    var refresh by remember { mutableIntStateOf(0) }
    val lifecycle = LocalLifecycleOwner.current.lifecycle
    // Opened a maker's page and came back: that step counts as done, and the phone's own switches are read again.
    var opened by remember { mutableStateOf<Int?>(null) }
    DisposableEffect(lifecycle) {
        val observer = LifecycleEventObserver { _, e ->
            if (e == Lifecycle.Event.ON_RESUME) {
                opened?.let { prefs.reminderStepsDone = (stepsDone(prefs) + it).sorted().joinToString(",") }
                opened = null
                refresh++
            }
        }
        lifecycle.addObserver(observer)
        onDispose { lifecycle.removeObserver(observer) }
    }
    val askNotifications = rememberLauncherForActivityResult(ActivityResultContracts.RequestPermission()) { refresh++ }
    val notifications = remember(refresh) { Reminders.canPost(context) }
    val exact = remember(refresh) { Reminders.canBeExact(context) }
    val battery = remember(refresh) { !Reminders.batteryRestricted(context) }
    val steps = remember { PhoneMaker.steps() }
    val done = remember(refresh) { stepsDone(prefs) }
    val left = steps.indices.count { it !in done }
    val allSet = notifications && exact && left == 0

    val lead = when {
        allSet -> "All set. Reminders will come on time."
        !exact -> "Reminders may come late. Android sends them on time only when Alarms & reminders is allowed. It’s Android’s setting, not the app’s."
        left == 0 -> "All set. Reminders will come on time."
        // Part way: the same first sentence, then what is left ("…which can stop reminders. One step left.").
        left < steps.size -> PhoneMaker.lead().substringBefore(". ") + ". One step left."
        else -> PhoneMaker.lead()
    }

    FormPage("Keep reminders coming", chip = null, onBack = onBack) {
        Spacer(Modifier.height(8.dp))
        Text(lead, Modifier.padding(horizontal = 4.dp).semantics { testTag = "keep-reminders-lead" },
            style = AppType.bodyMedium, color = appColors.secondary)
        Spacer(Modifier.height(16.dp))
        GroupTitle("What this phone allows")
        SegmentedList {
            AllowRow(
                if (notifications) Icons.Outlined.Notifications else Icons.Outlined.Notifications,
                "Notifications", if (notifications) "Allowed" else "Off · reminders can’t show", notifications,
                "Turn on", 0, 3, "allow-notifications",
            ) {
                if (Build.VERSION.SDK_INT >= 33) askNotifications.launch(Manifest.permission.POST_NOTIFICATIONS)
                else PhoneMaker.openNotifications(context)
            }
            AllowRow(
                if (exact) Icons.Outlined.Alarm else Icons.Outlined.Alarm,
                "Alarms & reminders", if (exact) "Allowed" else "Off · reminders can come up to an hour late", exact,
                "Allow", 1, 3, "allow-exact",
            ) { PhoneMaker.openExactAlarms(context) }
            AllowRow(
                if (battery) Icons.Outlined.BatteryFull else Icons.Outlined.BatteryAlert,
                "Battery", if (battery) "Not restricted" else PhoneMaker.batteryRisk(), battery,
                null, 2, 3, "allow-battery",
            ) {}
        }
        if (steps.isNotEmpty() && !battery) {
            GroupTitle("On this ${PhoneMaker.name()} phone".replace("On this Google phone", "On this phone"))
            SegmentedList {
                steps.forEachIndexed { i, step ->
                    StepRow(step, i, steps.size, i in done) { opened = i; step.open(context) }
                }
            }
        }
        GroupTitle("Good to know")
        SegmentedList {
            GoodToKnow(Icons.Outlined.BatteryFull, "Only for Often Enough", "Other apps keep saving battery.", 0, 2)
            GoodToKnow(Icons.Outlined.OpenInNew, "Open takes you there", "Then come back here with Back.", 1, 2)
        }
        Spacer(Modifier.height(24.dp))
    }
}

private fun stepsDone(prefs: Prefs): Set<Int> =
    prefs.reminderStepsDone.split(",").mapNotNull { it.trim().toIntOrNull() }.toSet()

@Composable
private fun AllowRow(icon: ImageVector, title: String, state: String, ok: Boolean, fix: String?, index: Int, count: Int, tag: String, onFix: () -> Unit) {
    Segment(index, count, Modifier.semantics { testTag = tag }) {
        Box(Modifier.size(40.dp).clip(CircleShape).background(appColors.tonal), contentAlignment = Alignment.Center) {
            Icon(icon, null, tint = appColors.ink, modifier = Modifier.size(22.dp))
        }
        Spacer(Modifier.width(16.dp))
        Column(Modifier.weight(1f).padding(vertical = 4.dp)) {
            Text(title, style = AppType.bodyLarge, color = appColors.ink)
            Text(state, style = AppType.bodyMedium, color = appColors.secondary)
        }
        Spacer(Modifier.width(8.dp))
        when {
            ok -> Icon(Icons.Rounded.CheckCircle, "Allowed", tint = appColors.ink)
            fix != null -> InkButton(fix, onFix, Modifier.semantics { testTag = "$tag-fix" }, height = 40.dp)
            // The maker's own steps below do the fixing: nothing here to press.
            else -> Icon(Icons.Rounded.Error, "Needs a step below", tint = appColors.secondary)
        }
    }
}

@Composable
private fun StepRow(step: MakerStep, index: Int, count: Int, done: Boolean, onOpen: () -> Unit) {
    Segment(index, count, Modifier.semantics { testTag = "maker-step-$index" }) {
        Box(Modifier.size(28.dp).clip(CircleShape).background(appColors.tonal), contentAlignment = Alignment.Center) {
            Text("${index + 1}", style = AppType.labelLarge, color = appColors.ink)
        }
        Spacer(Modifier.width(16.dp))
        Column(Modifier.weight(1f).padding(vertical = 4.dp)) {
            Text(step.title, style = AppType.bodyLarge, color = appColors.ink)
            Text(step.where, style = AppType.bodyMedium, color = appColors.secondary)
        }
        Spacer(Modifier.width(8.dp))
        if (done) Text("Done", style = AppType.labelLarge, color = appColors.secondary, modifier = Modifier.padding(end = 8.dp))
        else InkButton("Open", onOpen, Modifier.semantics { testTag = "maker-step-$index-open" }, height = 40.dp)
    }
}

@Composable
private fun GoodToKnow(icon: ImageVector, title: String, body: String, index: Int, count: Int) {
    Segment(index, count) {
        Box(Modifier.size(40.dp).clip(CircleShape).background(appColors.tonal), contentAlignment = Alignment.Center) {
            Icon(icon, null, tint = appColors.ink, modifier = Modifier.size(22.dp))
        }
        Spacer(Modifier.width(16.dp))
        Column(Modifier.weight(1f).padding(vertical = 4.dp)) {
            Text(title, style = AppType.bodyLarge, color = appColors.ink)
            Text(body, style = AppType.bodyMedium, color = appColors.secondary)
        }
    }
}
