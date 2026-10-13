package com.oftenenough.app.ui.player

import androidx.activity.compose.BackHandler
import androidx.compose.animation.core.animate
import androidx.compose.foundation.background
import androidx.compose.foundation.gestures.Orientation
import androidx.compose.foundation.gestures.draggable
import androidx.compose.foundation.gestures.rememberDraggableState
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.rounded.KeyboardArrowDown
import androidx.compose.material.icons.rounded.Pause
import androidx.compose.material.icons.rounded.PlayArrow
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableFloatStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.platform.LocalView
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleEventObserver
import androidx.lifecycle.compose.LocalLifecycleOwner
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.PlayerAction
import com.oftenenough.app.data.PlayerWords
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch

/**
 * One habit's timer, full screen (the iPhone's `TimerScreen`, iOS/Habits/Today/TimerScreen.swift; the Android design
 * "Timer · running"): ⌄ at the top, the same hero card as the routine player (the clock counts up from the saved start,
 * the goal beside it, the wavy bar), and a button group: Log manually (tonal) and Pause (ink). Pause stops the timer and
 * saves the time, exactly as ⏸ on Today's row; Resume (or Start) runs it again.
 *
 * Never a trap: ⌄, back or a swipe down puts it away and the timer keeps running. Only the clock and the bar tick (S3).
 * [onLogManually] opens the habit's Add screen (the timer is paused first so no minute counts twice, and runs again on
 * return); without it there is no Log manually. [onOpenDay] makes the day chip open Day details.
 */
@Composable
fun TimerScreen(
    store: HabitStore, habitId: String, onClose: () -> Unit,
    onLogManually: (() -> Unit)? = null, onOpenDay: (() -> Unit)? = null,
) {
    val c = appColors
    val habit = store.habit(habitId)?.takeIf { !it.archived }
    val day = store.today()
    val running = store.timers.containsKey(habitId)
    // The part of the day the timer was started for, kept so Resume counts toward the same one.
    val slot by rememberSaveable { mutableStateOf(store.timerSlots[habitId]) }
    var resumeAfterLog by rememberSaveable { mutableStateOf(false) }
    val drag = remember { mutableFloatStateOf(0f) }
    val putAway = with(LocalDensity.current) { 120.dp.toPx() }
    val view = LocalView.current
    val scope = rememberCoroutineScope()
    val lifecycle = LocalLifecycleOwner.current.lifecycle

    BackHandler(onBack = onClose)
    DisposableEffect(view, running) {
        view.keepScreenOn = running
        onDispose { view.keepScreenOn = false }
    }
    // Back from Log manually (saved or not): a timer that was running runs again, unless the goal is now met.
    DisposableEffect(lifecycle, habitId) {
        val observer = LifecycleEventObserver { _, event ->
            if (event == Lifecycle.Event.ON_RESUME && resumeAfterLog) {
                resumeAfterLog = false
                val h = store.habit(habitId)
                if (h != null && !store.timers.containsKey(h.id) && (h.atMost || !store.rules.isComplete(h, store.today()))) store.toggleTimer(h, slot)
            }
        }
        lifecycle.addObserver(observer)
        onDispose { lifecycle.removeObserver(observer) }
    }

    fun logManually() {
        val h = habit ?: return
        val open = onLogManually ?: return
        resumeAfterLog = store.timers.containsKey(h.id)
        if (resumeAfterLog) store.toggleTimer(h)
        open()
    }

    // A swipe down anywhere puts the screen away; short of the distance it springs back.
    fun settle() {
        if (drag.floatValue > putAway) { onClose(); return }
        scope.launch { animate(drag.floatValue, 0f) { value, _ -> drag.floatValue = value } }
    }
    Box(
        Modifier.fillMaxSize().draggable(
            state = rememberDraggableState { delta -> drag.floatValue = maxOf(0f, drag.floatValue + delta) },
            orientation = Orientation.Vertical,
            onDragStopped = { _ -> settle() },
        ),
    ) {
        Column(
            Modifier.fillMaxSize().graphicsLayer { translationY = drag.floatValue }.background(c.screen)
                .statusBarsPadding().navigationBarsPadding().semantics { testTag = "timer-screen" },
        ) {
            Row(Modifier.fillMaxWidth().heightIn(min = 64.dp).padding(horizontal = 4.dp), verticalAlignment = Alignment.CenterVertically) {
                // Putting it away, not stopping: the name says so to TalkBack too.
                IconButton(onClose, Modifier.semantics { testTag = "timer-screen-close" }) {
                    Icon(Icons.Rounded.KeyboardArrowDown, PlayerWords.timerClose(running), tint = c.ink)
                }
            }
            if (habit == null) {
                Box(Modifier.weight(1f).fillMaxWidth().padding(horizontal = 16.dp)) { GoneCard() }
                Spacer(Modifier.height(112.dp))
            } else {
                val rev = store.revision(habit.id)
                val ruled = remember(habit, rev) { store.rule(habit, day) }
                Box(Modifier.weight(1f).fillMaxWidth().padding(horizontal = 16.dp)) {
                    HeroCard(
                        habit = habit, ruled = ruled, day = day, store = store, rev = rev, skipped = false,
                        onDay = onOpenDay,
                        // A tap on the clock types time, as on the iPhone.
                        onCountTap = if (onLogManually != null && ruled.kind == HabitKind.Duration) ({ logManually() }) else null,
                        onStep = null,
                    )
                }
                Spacer(Modifier.height(16.dp))
                // One main button, always in the same place: Pause while it runs, Resume (or Start) when it doesn't.
                val started = remember(habit, rev, running) { store.rules.progress(habit, day) > 0 }
                val action = PlayerWords.mainAction(ruled, store.rules.goal(ruled), done = false, skipped = false, isLast = false, running = running, started = started)
                Row(Modifier.fillMaxWidth().height(96.dp).padding(horizontal = 16.dp), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    if (onLogManually != null) {
                        TonalBigButton(null, "Log manually", "timer-screen-log", Modifier.weight(1f).fillMaxHeight()) { logManually() }
                    }
                    MainButton(
                        if (action.action == PlayerAction.PAUSE) Icons.Rounded.Pause else Icons.Rounded.PlayArrow,
                        action.label, action.spoken, "timer-screen-primary", Modifier.weight(if (onLogManually != null) 1.2f else 1f),
                    ) {
                        if (store.timers.containsKey(habit.id)) store.toggleTimer(habit) else store.toggleTimer(habit, slot)
                    }
                }
                Spacer(Modifier.height(16.dp))
            }
        }
    }
}
