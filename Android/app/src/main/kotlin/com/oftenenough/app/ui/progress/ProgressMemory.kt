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

    // Folded until someone opens it (Habits & Tasks, flow 5: "help · What the squares mean · expand_more"); once
    // opened or folded, that choice is kept.
    val isOpen: Boolean get() = shown ?: (store.setting(HEAT_KEY_FOLDED) == "false")

    fun toggle() {
        val open = !isOpen
        shown = open
        // One write when the choice changes, never per redraw (S15).
        val want = if (open) "false" else "true"
        if (store.setting(HEAT_KEY_FOLDED) != want) store.saveAppSetting(HEAT_KEY_FOLDED, want)
    }
}
