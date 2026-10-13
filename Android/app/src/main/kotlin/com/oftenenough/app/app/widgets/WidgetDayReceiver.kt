package com.oftenenough.app.app.widgets

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.data.HabitStore
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

/**
 * The widgets move on at the day's start without the app: the snapshot holds seven days, and an inexact alarm at the
 * next day's start redraws them (and republishes when the app's process is there). Android has no widget timeline, so
 * this one alarm is the whole of it (W10's "only what's needed").
 */
class WidgetDayReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val result = goAsync()
        CoroutineScope(Dispatchers.Main.immediate).launch {
            try {
                if (AppGraph.isOpen && AppGraph.store.isLoaded && !AppGraph.isTest) WidgetPublisher.publish(context.applicationContext, AppGraph.store)
                else WidgetPublisher.updateAll(context.applicationContext)
            } finally { result.finish() }
        }
    }

    companion object {
        /** Sets the one alarm for the next day's start (from the store, or the snapshot's next frame). */
        fun plan(context: Context, store: HabitStore?) {
            val next = store?.takeIf { it.isLoaded }?.let { it.rules.dayBounds(it.today()).last + 1 }
                ?: WidgetDisk.read(context)?.frames?.firstOrNull { it.end > System.currentTimeMillis() }?.end ?: return
            val alarms = context.getSystemService(AlarmManager::class.java) ?: return
            val pending = PendingIntent.getBroadcast(context, 7, Intent(context, WidgetDayReceiver::class.java),
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
            alarms.set(AlarmManager.RTC, next + 1_000, pending)
        }
    }
}
