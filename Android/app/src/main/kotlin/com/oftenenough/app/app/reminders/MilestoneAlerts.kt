package com.oftenenough.app.app.reminders

import android.app.AlarmManager
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent

/**
 * The milestone notification is gone (the user, 1 Nov 2026, Android A93: "it feels unnecessary"): quit and cut-down
 * habits no longer have *Tell me at milestones*, and milestones show only in the app, as for every habit. What a phone
 * that had it on still holds is cleared at start: its alarm, its channels and its record of what was sent. Each habit's
 * old switch stays in its settings, unread, so nothing saved is lost.
 */
object MilestoneAlerts {
    private const val CHANNEL = "milestone-alerts"
    private const val OLD_CHANNEL = "milestones"
    private const val ACTION = "com.oftenenough.app.MILESTONE_ALERT"
    private const val PREFS = "milestone-alerts"

    fun retire(context: Context) {
        context.getSystemService(NotificationManager::class.java)?.let {
            it.deleteNotificationChannel(CHANNEL)
            it.deleteNotificationChannel(OLD_CHANNEL)
        }
        val alarm = PendingIntent.getBroadcast(context, 7, Intent(context, ReminderReceiver::class.java).setAction(ACTION),
            PendingIntent.FLAG_NO_CREATE or PendingIntent.FLAG_IMMUTABLE)
        if (alarm != null) {
            context.getSystemService(AlarmManager::class.java)?.cancel(alarm)
            alarm.cancel()
        }
        context.deleteSharedPreferences(PREFS)
    }
}
