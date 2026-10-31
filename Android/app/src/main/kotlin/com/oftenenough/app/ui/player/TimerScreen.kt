package com.oftenenough.app.ui.player

import com.oftenenough.app.ui.theme.Symbols
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
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableFloatStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
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
import com.oftenenough.app.ui.components.AppLargeIconButton
import com.oftenenough.app.ui.components.AppTopBar
import com.oftenenough.app.ui.components.NavigationIcon
import androidx.compose.foundation.layout.WindowInsets
import com.oftenenough.app.ui.components.LargeIconWidth
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch

/**
 * 5.3.7, **Timer screen** (Figma 705:7745, State Running · Paused; Components — Atoms Build Plan): one habit's timer,
 * full screen, opened by Start timer on a Today row or in Day details. A scaffold: the Top app bar (64) with ⌄
 * (expand_more: it minimises, the timer keeps running) and "Timer"; the content 16 at the sides, the routine player's
 * hero card filling it (the clock counts up from the saved start in Display Large, "of 10 min" beside it, the bar,
 * wavy while it runs); the bottom bar, 12 above and below, 16 at the sides, 8 apart: Log time (Large square Tonal) and Pause, or
 * Resume (the Wide Large icon button, Filled). Pause stops the timer and saves the time, exactly as ⏸ on Today's row;
 * Resume (or Start) runs it again.
 *
 * Never a trap: ⌄, back or a swipe down puts it away and the timer keeps running. Only the clock and the bar tick (S3).
 * [onLogManually] (Log time) opens the habit's Add screen (the timer is paused first so no minute counts twice, and runs again on
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
            AppTopBar("Timer", navigationIcon = {
                // Putting it away, not stopping: the name says so to TalkBack too.
                NavigationIcon(Symbols.ExpandMore, PlayerWords.timerClose(running), onClose, Modifier.semantics { testTag = "timer-screen-close" })
            }, windowInsets = WindowInsets(0))
            if (habit == null) {
                Box(Modifier.weight(1f).fillMaxWidth().padding(horizontal = 16.dp)) { GoneCard() }
                Spacer(Modifier.height(120.dp))
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
                        identityGap = 28.dp, namingGap = 12.dp, filledDayChip = true,
                    )
                }
                // One main button, always in the same place: Pause while it runs, Resume (or Start) when it doesn't, the
                // Wide large icon button (128 dp, Figma's Timer screen); Log manually takes the rest of the row.
                val started = remember(habit, rev, running) { store.rules.progress(habit, day) > 0 }
                val action = PlayerWords.mainAction(ruled, store.rules.goal(ruled), done = false, skipped = false, isLast = false, running = running, started = started)
                Row(Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 12.dp).height(96.dp), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    if (onLogManually != null) {
                        TonalBigButton(null, "Log time", "timer-screen-log", Modifier.weight(1f).fillMaxHeight()) { logManually() }
                    }
                    AppLargeIconButton(
                        if (action.action == PlayerAction.PAUSE) Symbols.Filled.Pause else Symbols.Filled.PlayArrow, action.spoken,
                        { if (store.timers.containsKey(habit.id)) store.toggleTimer(habit) else store.toggleTimer(habit, slot) },
                        width = if (onLogManually != null) LargeIconWidth.Wide else LargeIconWidth.Fill,
                        modifier = if (onLogManually != null) Modifier else Modifier.weight(1f), tag = "timer-screen-primary",
                    )
                }
            }
        }
    }
}
