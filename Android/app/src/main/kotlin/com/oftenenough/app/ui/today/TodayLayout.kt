package com.oftenenough.app.ui.today

import androidx.compose.runtime.Stable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateMapOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Job
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

/**
 * Nothing on Today moves during a run of taps (Rulebook U4): a log holds every section's order and fold, and Today tidies
 * (done rows sink, finished sections fold) [pauseMillis] after the last one. The iPhone's `TodayLayout`.
 */
@Stable
class TodayLayout(private val scope: CoroutineScope) {
    var holding by mutableStateOf(false); private set
    /** The person's own fold choices: section (or "steps-<habit>") → open. */
    private val opened = mutableStateMapOf<String, Boolean>()
    private val shownOrder = HashMap<String, List<String>>()
    private val shownOpen = HashMap<String, Boolean>()
    private var release: Job? = null

    /** Folds waiting for the pause: a checklist whose last step was just ticked (Figma 1.7.2: "then fold"). */
    private val foldLater = HashSet<String>()

    fun hold() {
        holding = true
        release?.cancel()
        release = scope.launch {
            delay(pauseMillis)
            holding = false
            for (key in foldLater) opened[key] = false
            foldLater.clear()
        }
    }

    /** Folds [key] once Today settles; a tap that opens it again in the meantime keeps it open. */
    fun foldAfterHold(key: String) { foldLater.add(key); hold() }

    /** Another day: every section follows the rule again, and nothing is held. */
    fun reset() {
        release?.cancel()
        holding = false
        opened.keys.filter { !it.startsWith("steps-") }.forEach { opened.remove(it) }
    }

    fun setOpen(key: String, open: Boolean) { opened[key] = open; foldLater.remove(key) }
    fun choice(key: String): Boolean? = opened[key]

    /** Whether a section is open: the person's choice, else the rule; while holding, the fold it was shown with. */
    fun isOpen(part: String, rule: Boolean): Boolean {
        opened[part]?.let { return it }
        if (holding) shownOpen[part]?.let { return it }
        shownOpen[part] = rule
        return rule
    }

    /** The rows to show: the fresh order, or while holding, the order last shown (new rows at the end). */
    fun <T> order(part: String, fresh: List<T>, id: (T) -> String): List<T> {
        val shown = shownOrder[part]
        if (!holding || shown == null) {
            shownOrder[part] = fresh.map(id)
            return fresh
        }
        val byId = LinkedHashMap<String, T>()
        for (item in fresh) byId.putIfAbsent(id(item), item)
        val kept = shown.mapNotNull { byId.remove(it) }
        return kept + fresh.filter { byId.containsKey(id(it)) }
    }

    companion object {
        /** Long enough for the next tick in a run, short enough to settle while the person is still looking. */
        var pauseMillis = 1500L
    }
}
