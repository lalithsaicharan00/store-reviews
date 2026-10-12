package com.oftenenough.app

import android.app.Application
import app.habits.core.AndroidCore

class OftenEnoughApp : Application() {
    override fun onCreate() {
        super.onCreate()
        AndroidCore.context = this
    }
}
