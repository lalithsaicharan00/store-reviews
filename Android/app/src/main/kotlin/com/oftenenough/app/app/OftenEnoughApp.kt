package com.oftenenough.app.app

import android.app.Application

class OftenEnoughApp : Application() {
    override fun onCreate() {
        super.onCreate()
        AppGraph.init(this)
    }
}
