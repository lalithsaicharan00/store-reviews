package com.oftenenough.app.ui.settings

import android.Manifest
import android.app.Activity
import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.platform.LocalContext
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.compose.LifecycleEventEffect
import com.oftenenough.app.app.reminders.Reminders
import com.oftenenough.app.data.Habit

/** Whether a habit has reminders that can ring (on, with at least one time, still going). */
fun hasReminders(habit: Habit) = habit.remind && habit.reminders.isNotEmpty() && !habit.archived

/**
 * Opens [intent]'s settings page; a phone that has no such page opens the app's own App info instead, never nothing and
 * never Settings' home (U40).
 */
fun openSettingsPage(context: Context, intent: Intent) {
    try { context.startActivity(intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)) }
    catch (e: ActivityNotFoundException) { openAppSettings(context) }
    // A maker's page another app keeps closed to others.
    catch (e: SecurityException) { openAppSettings(context) }
}

private fun openAppSettings(context: Context) {
    try {
        context.startActivity(Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, Uri.parse("package:" + context.packageName)).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK))
    } catch (_: ActivityNotFoundException) {}
}

/**
 * Turns notifications on for the app (U37; Figma's Today, flows 41 and 42): Android's own question while Android will
 * still ask, and the app's notification settings once it won't (after two refusals). [onAnswer] gets whether they're
 * on: after the question, or on coming back from Settings. Today's notice and Keep reminders coming both ask this way.
 */
@Composable
fun rememberTurnOnNotifications(onAnswer: (Boolean) -> Unit): () -> Unit {
    val context = LocalContext.current
    val prefs = remember { context.getSharedPreferences(ASK_PREFS, Context.MODE_PRIVATE) }
    var inSettings by remember { mutableStateOf(false) }
    val ask = rememberLauncherForActivityResult(ActivityResultContracts.RequestPermission()) { granted -> onAnswer(granted) }
    LifecycleEventEffect(Lifecycle.Event.ON_RESUME) { if (inSettings) { inSettings = false; onAnswer(Reminders.canPost(context)) } }
    return {
        // Android asks a first time, and again after one refusal; after a second it won't, and Settings is the way.
        val willAsk = Build.VERSION.SDK_INT >= 33 && (!prefs.getBoolean(ASKED, false) ||
            (context as? Activity)?.shouldShowRequestPermissionRationale(Manifest.permission.POST_NOTIFICATIONS) == true)
        when {
            Reminders.canPost(context) -> onAnswer(true)
            willAsk -> { prefs.edit().putBoolean(ASKED, true).apply(); ask.launch(Manifest.permission.POST_NOTIFICATIONS) }
            else -> {
                inSettings = true
                openSettingsPage(context, Intent(Settings.ACTION_APP_NOTIFICATION_SETTINGS).putExtra(Settings.EXTRA_APP_PACKAGE, context.packageName))
            }
        }
    }
}

private const val ASK_PREFS = "notifications_ask"
private const val ASKED = "asked"
