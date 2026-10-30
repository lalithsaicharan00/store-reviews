package com.oftenenough.app.ui.settings

import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.provider.Settings
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
