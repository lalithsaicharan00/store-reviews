package com.oftenenough.app.ui.today

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
import androidx.compose.foundation.shape.RoundedCornerShape
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
import androidx.compose.ui.graphics.graphicsLayer
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
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch
import kotlin.math.abs
import kotlin.math.roundToInt
import kotlin.math.sign

/**
 * What a swipe does (Figma 7): [short] while the swipe is short of halfway ("Skip", "Note"), [full] once it's past
 * ("Skip today", "Add note"), and [act] when it's let go there.
 */
class SwipeAction(val short: String, val full: String, val icon: ImageVector, val tag: String, val act: () -> Unit)

/** How far a row gives when its side has nothing ("the row gives a little and springs back", Figma 7.14). */
private val GiveDp = 24.dp

/**
 * A Today row that swipes (Figma 7.1–7.24; the user's design, 18 Oct 2026, which replaces the earlier "reveal buttons,
 * never act"): swipe left for [left] (Skip, Undo skip, a slip), right for [right] (Note). Short of halfway the grey
 * (#E2E2E7) shows the short word; past it the colour fills with ink, the full words show and the phone ticks once; let go
 * there and it acts, short of it the row springs back. Either way the row comes home: nothing is ever left open. A side
 * with nothing gives a little and springs back. While it moves the row lifts: corners 12 and a soft shadow. Both actions
 * are TalkBack actions on the row too.
 */
@Composable
fun SwipeRow(left: SwipeAction?, right: SwipeAction?, shape: Shape, haptics: Boolean = true, content: @Composable () -> Unit) {
    val c = appColors
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
            val background by animateColorAsState(if (past) c.ink else c.behind, tween(120), label = "swipe")
            val ink = if (past) c.onInk else c.ink
            Row(
                Modifier.matchParentSize().background(background).padding(horizontal = if (past) 24.dp else 16.dp)
                    .semantics { testTag = action.tag },
                horizontalArrangement = if (v < 0) Arrangement.End else Arrangement.Start,
                verticalAlignment = Alignment.CenterVertically,
            ) {
                Icon(action.icon, null, Modifier.size(24.dp), tint = ink)
                Spacer(Modifier.width(8.dp))
                Text(if (past) action.full else action.short, style = AppType.labelLarge, color = ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
            }
        }
        val lifted = abs(v) > 0.5f
        Box(
            Modifier.offset { IntOffset(v.roundToInt(), 0) }
                .graphicsLayer {
                    if (lifted) {
                        this.shape = RoundedCornerShape(12.dp)
                        clip = true
                        shadowElevation = with(density) { 3.dp.toPx() }
                    }
                }
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
