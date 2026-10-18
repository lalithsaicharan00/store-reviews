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
        /**
         * Sets the one alarm: the next day's start (from the store, or the snapshot's next frame), or sooner when a quit
         * run's clock passes an hour or a whole day (Android's chronometer can't show either change on its own).
         */
        fun plan(context: Context, store: HabitStore?) {
            val now = System.currentTimeMillis()
            val snapshot = WidgetDisk.read(context)
            val dayStart = store?.takeIf { it.isLoaded }?.let { it.rules.dayBounds(it.today()).last + 1 }
                ?: snapshot?.frames?.firstOrNull { it.end > now }?.end
            val quitTurn = snapshot?.frame(now)?.items?.mapNotNull { it.quitStart?.takeIf { s -> s <= now } }?.minOfOrNull { start ->
                val inDay = (now - start) % 86_400_000L
                now + if (inDay < 3_600_000L) 3_600_000L - inDay else 86_400_000L - inDay
            }
            val next = listOfNotNull(dayStart, quitTurn).minOrNull() ?: return
            val alarms = context.getSystemService(AlarmManager::class.java) ?: return
            val pending = PendingIntent.getBroadcast(context, 7, Intent(context, WidgetDayReceiver::class.java),
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
            alarms.set(AlarmManager.RTC, next + 1_000, pending)
        }
    }
}
