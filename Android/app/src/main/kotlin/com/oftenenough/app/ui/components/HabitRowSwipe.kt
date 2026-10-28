package com.oftenenough.app.ui.components

import android.view.HapticFeedbackConstants
import androidx.compose.animation.animateColorAsState
import androidx.compose.animation.core.Animatable
import androidx.compose.animation.core.Spring
import androidx.compose.animation.core.spring
import androidx.compose.animation.core.tween
import androidx.compose.foundation.background
import androidx.compose.foundation.gestures.detectHorizontalDragGestures
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.rememberUpdatedState
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Shape
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.layout.onSizeChanged
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.platform.LocalView
import androidx.compose.ui.semantics.CustomAccessibilityAction
import androidx.compose.ui.semantics.customActions
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.IntOffset
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.theme.AppType
import androidx.compose.material3.MaterialTheme
import kotlinx.coroutines.launch
import kotlin.math.abs
import kotlin.math.roundToInt
import kotlin.math.sign

/**
 * What a swipe does (Figma 7): [short] while the swipe is short of halfway ("Skip", "Note"), [full] once it's past
 * ("Skip today", "Add note"), and [act] when it's let go there.
 */
class SwipeAction(val short: String, val full: String, val icon: ImageVector, val tag: String, val act: () -> Unit)

/** How far a row gives when its side has nothing ("the row gives a little and springs back", Figma 7.14, Nudge). */
private val GiveDp = 24.dp

/**
 * Molecule 4.2, **Habit row · Swipe** (Figma 763:273; Components — Atoms Build Plan): a Today row ([HabitRowLayout])
 * that swipes, acting when let go past halfway (Android A16): swipe left for [left] (Skip, Undo skip, Log a slip),
 * right for [right] (Note).
 *
 * Behind the row, its whole size, the action: a 24 dp icon, 8, its word in Label Large, 16 from the side it comes
 * from. Short of halfway (Reveal) it's Surface container highest with On surface and the short word ("Skip",
 * "Note"); past halfway it turns Inverse surface with Inverse on surface and the full words ("Skip today", "Add note"),
 * and the phone ticks once. Let go there and it acts; short of it the row springs back. Either way the row comes home:
 * nothing is ever left open. The row slides flat, inside its section's [shape]: no lift, no shadow. A side with nothing
 * (A35: a week or month goal, a cut-down, a task) gives 24 and springs back (Nudge). Both actions are TalkBack actions
 * on the row too.
 */
@Composable
fun HabitRowSwipe(left: SwipeAction?, right: SwipeAction?, shape: Shape, haptics: Boolean = true, content: @Composable () -> Unit) {
    val s = MaterialTheme.colorScheme
    val view = LocalView.current
    val density = LocalDensity.current
    val givePx = with(density) { GiveDp.toPx() }
    val offset = remember { Animatable(0f) }
    val scope = rememberCoroutineScope()
    var width by remember { mutableIntStateOf(0) }
    var past by remember { mutableStateOf(false) }
    val leftNow by rememberUpdatedState(left)
    val rightNow by rememberUpdatedState(right)
    val actions = listOfNotNull(left, right)
    Box(
        Modifier.fillMaxWidth().clip(shape).onSizeChanged { width = it.width }
            .semantics { customActions = actions.map { a -> CustomAccessibilityAction(a.full) { a.act(); true } } },
    ) {
        val v = offset.value
        val action = if (v < 0) left else if (v > 0) right else null
        if (action != null && abs(v) > 0.5f) {
            val background by animateColorAsState(if (past) s.inverseSurface else s.surfaceContainerHighest, tween(120), label = "swipe")
            val ink = if (past) s.inverseOnSurface else s.onSurface
            Row(
                Modifier.matchParentSize().background(background).padding(horizontal = 16.dp)
                    .semantics { testTag = action.tag },
                horizontalArrangement = if (v < 0) Arrangement.End else Arrangement.Start,
                verticalAlignment = Alignment.CenterVertically,
            ) {
                Icon(action.icon, null, Modifier.size(24.dp), tint = ink)
                Spacer(Modifier.width(8.dp))
                Text(if (past) action.full else action.short, style = AppType.labelLarge, color = ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
            }
        }
        Box(
            Modifier.offset { IntOffset(v.roundToInt(), 0) }
                .pointerInput(Unit) {
                    detectHorizontalDragGestures(
                        onDragStart = { past = false },
                        onDragEnd = {
                            val at = offset.value
                            val a = if (at < 0) leftNow else if (at > 0) rightNow else null
                            val acts = a != null && past
                            past = false
                            scope.launch {
                                offset.animateTo(0f, spring(dampingRatio = Spring.DampingRatioNoBouncy, stiffness = Spring.StiffnessMediumLow))
                            }
                            if (acts) a!!.act()
                        },
                        onDragCancel = { past = false; scope.launch { offset.animateTo(0f) } },
                    ) { change, dx ->
                        change.consume()
                        val raw = offset.value + dx
                        val a = if (raw < 0) leftNow else if (raw > 0) rightNow else null
                        // Nothing on this side: a little give, never more.
                        val next = if (a == null) sign(raw) * minOf(abs(raw), givePx) else raw.coerceIn(-width.toFloat(), width.toFloat())
                        val nowPast = a != null && width > 0 && abs(next) >= width / 2f
                        if (nowPast != past) {
                            past = nowPast
                            if (nowPast && haptics) view.performHapticFeedback(HapticFeedbackConstants.CLOCK_TICK)
                        }
                        scope.launch { offset.snapTo(next) }
                    }
                },
        ) { content() }
    }
}
