package com.oftenenough.app.app

import android.app.Application

class OftenEnoughApp : Application() {
    override fun onCreate() {
        super.onCreate()
        AppGraph.init(this)
        com.oftenenough.app.app.reminders.Reminders.channel(this)
        com.oftenenough.app.app.reminders.TimerNotice.channel(this)
    }
}
