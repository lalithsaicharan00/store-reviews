package com.oftenenough.app.app

import android.app.Application

class OftenEnoughApp : Application() {
    override fun onCreate() {
        super.onCreate()
        AppGraph.init(this)
        com.oftenenough.app.app.reminders.Reminders.channel(this)
        com.oftenenough.app.app.reminders.MilestoneAlerts.retire(this)
        com.oftenenough.app.app.reminders.TimerNotice.channel(this)
        // The widget picker shows our preview images, not previews an earlier build drew (A98).
        com.oftenenough.app.app.widgets.WidgetPreviews.clearDrawn(this)
        night = resources.configuration.uiMode and android.content.res.Configuration.UI_MODE_NIGHT_MASK
    }

    private var night = 0

    /** The phone's mode changed (the app follows it on System): the widgets draw their pictures again in it. */
    override fun onConfigurationChanged(newConfig: android.content.res.Configuration) {
        super.onConfigurationChanged(newConfig)
        val now = newConfig.uiMode and android.content.res.Configuration.UI_MODE_NIGHT_MASK
        if (now != night) { night = now; com.oftenenough.app.app.widgets.WidgetPublisher.phoneModeChanged(this) }
    }
}
