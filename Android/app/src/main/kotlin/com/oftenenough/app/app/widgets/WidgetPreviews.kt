package com.oftenenough.app.app.widgets

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProviderInfo
import android.content.ComponentName
import android.content.Context
import android.os.Build

/**
 * The widget picker shows each widget's `previewImage`: the widget alone at its own size (156 × 176, 328 × 176 or
 * 328 × 368), light and dark, from the Figma section "Widget image exports" (each named for its file), at 3× into
 * res/drawable-xxhdpi and drawable-night-xxhdpi (A98). Export them again when a widget's look changes. Android 15's
 * previews drawn by the app are cleared once, for a phone that had them from an earlier build: a launcher gives a drawn
 * preview the widget's whole span in its own cells, a large empty box round the card, where an image is shown at its
 * own size.
 */
object WidgetPreviews {
    private val receivers = listOf(
        OneHabitWidgetReceiver::class.java, TodayWidgetReceiver::class.java, TodayLargeWidgetReceiver::class.java,
        WeekWidgetReceiver::class.java, TasksWidgetReceiver::class.java, TasksLargeWidgetReceiver::class.java,
    )

    fun clearDrawn(context: Context) {
        if (Build.VERSION.SDK_INT < 35) return
        val prefs = context.getSharedPreferences("widget-previews", Context.MODE_PRIVATE)
        if (prefs.getBoolean("cleared", false)) return
        val manager = AppWidgetManager.getInstance(context)
        for (receiver in receivers) runCatching {
            manager.removeWidgetPreview(ComponentName(context, receiver), AppWidgetProviderInfo.WIDGET_CATEGORY_HOME_SCREEN)
        }
        prefs.edit().putBoolean("cleared", true).apply()
    }
}
