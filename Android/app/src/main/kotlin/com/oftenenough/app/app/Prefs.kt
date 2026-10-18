package com.oftenenough.app.app

import android.content.Context
import android.content.SharedPreferences
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue

/**
 * This phone's own choices (the iPhone's `Preferences`, per device): Appearance, Today's filter, onboarding. Each is Compose
 * state, and written only when it changes (S15).
 */
class Prefs(private val sp: SharedPreferences) {
    private fun bool(key: String, default: Boolean) = BoolPref(sp, key, default)
    private fun str(key: String, default: String) = StringPref(sp, key, default)

    /** "system", "light" or "dark" (Appearance → Theme; Android says System default). */
    var theme by str("appearance.theme", "system")
    var vibration by bool("feedback.haptics", true)
    var sound by bool("feedback.sound", false)
    /** "bottom" (done habits move to the bottom, after the pause) or "inPlace". */
    var doneOrder by str("today.doneOrder", "bottom")
    var hideDoneHabits by bool("today.hideDoneHabits", false)
    var hideDoneTasks by bool("today.hideDoneTasks", false)
    /** The group Today shows ("" is all). */
    var todayGroup by str("today.group", "")
    var progressGroup by str("progress.group", "")
    var timerScreen by bool("timers.openScreen", true)
    var timerNotification by bool("timers.liveUpdate", true)
    /** The welcome is finished (new, or back from a backup). Nothing goes to Google Drive before it (D4, D14). */
    var onboarded by bool("onboarding.done", false)
    var hideNames by bool("privacy.hideNames", false)
    /** The days Today was opened on, the first three (the ✏ tip waits for three, Figma 2.0): "20350,20351". */
    var todayDaysSeen by str("today.daysSeen", "")
    /** The ✏ tip was shown and ended (Got it, or ✏ itself). */
    var arrangeTipDone by bool("today.arrangeTipDone", false)

    class BoolPref(private val sp: SharedPreferences, private val key: String, default: Boolean) {
        private val state = mutableStateOf(sp.getBoolean(key, default))
        operator fun getValue(owner: Any?, p: Any?): Boolean = state.value
        operator fun setValue(owner: Any?, p: Any?, value: Boolean) {
            if (state.value == value) return
            state.value = value
            sp.edit().putBoolean(key, value).apply()
        }
    }

    class StringPref(private val sp: SharedPreferences, private val key: String, default: String) {
        private val state = mutableStateOf(sp.getString(key, default) ?: default)
        operator fun getValue(owner: Any?, p: Any?): String = state.value
        operator fun setValue(owner: Any?, p: Any?, value: String) {
            if (state.value == value) return
            state.value = value
            sp.edit().putString(key, value).apply()
        }
    }

    companion object {
        fun of(context: Context, name: String = "prefs") = Prefs(context.getSharedPreferences(name, Context.MODE_PRIVATE))
    }
}
