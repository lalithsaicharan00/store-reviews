package com.oftenenough.app.ui.progress

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.ProgressRange
import com.oftenenough.app.ui.habit.HEAT_KEY_FOLDED

/**
 * Week, Month or Year: the last one chosen, kept for the app's life (the iPhone keeps it per phone in
 * `ProgressOptions.range`; to move into `Prefs` as `progressRange` when that file is next changed).
 */
internal object ProgressRangeMemory {
    var range by mutableStateOf(ProgressRange.WEEK)
}

/**
 * One visit's "What the squares mean" (the iPhone's `HeatKeyVisit`): the app-wide default until the person taps it here,
 * then what they chose, while the page is open. Folding it anywhere folds it everywhere from then on (the user, 6 Oct
 * 2026); the fold is the same saved setting the habit page reads (`HEAT_KEY_FOLDED`), so a test launch keeps its own.
 */
internal class HeatKeyVisit(private val store: HabitStore) {
    private var shown by mutableStateOf<Boolean?>(null)

    val isOpen: Boolean get() = shown ?: (store.setting(HEAT_KEY_FOLDED) != "true")

    fun toggle() {
        val open = !isOpen
        shown = open
        // Written once, the first time (S15).
        if (!open && store.setting(HEAT_KEY_FOLDED) != "true") store.saveAppSetting(HEAT_KEY_FOLDED, "true")
    }
}
