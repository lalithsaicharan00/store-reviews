package com.oftenenough.app.ui.today

import androidx.compose.animation.core.Animatable
import androidx.compose.animation.core.tween
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.gestures.detectHorizontalDragGestures
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Shape
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.semantics.CustomAccessibilityAction
import androidx.compose.ui.semantics.customActions
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.IntOffset
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch
import kotlin.math.abs
import kotlin.math.roundToInt

/** A button a swipe reveals: always labelled, acting only when tapped (U14). */
class SwipeAction(val label: String, val icon: ImageVector, val tag: String, val onClick: () -> Unit)

private val ActionWidth = 88.dp

/**
 * A row whose swipes *reveal* labelled buttons and never act by themselves, however far they go (U14): swipe right
 * for [start] (a named Undo), swipe left for [end] (Skip or Log slip at the edge, then Note); two at most a side.
 * Each action is also a TalkBack action on the row. A tap on the row while it's open closes it.
 */
@Composable
fun SwipeRow(start: List<SwipeAction>, end: List<SwipeAction>, shape: Shape, content: @Composable () -> Unit) {
    val density = LocalDensity.current
    val actionPx = with(density) { ActionWidth.toPx() }
    val startWidth = actionPx * start.size
    val endWidth = actionPx * end.size
    val offset = remember { Animatable(0f) }
    val scope = rememberCoroutineScope()
    fun settle(to: Float) { scope.launch { offset.animateTo(to, tween(180)) } }
    fun act(a: SwipeAction) { settle(0f); a.onClick() }
    Box(Modifier.fillMaxWidth().clip(shape)
        .semantics { customActions = (start + end).map { a -> CustomAccessibilityAction(a.label) { a.onClick(); true } } }) {
        // The buttons behind the row, on the side the swipe uncovers.
        if (start.isNotEmpty() || end.isNotEmpty()) Row(Modifier.matchParentSize()) {
            Row(Modifier.fillMaxHeight()) { start.forEach { ActionButton(it) { act(it) } } }
            Box(Modifier.weight(1f))
            Row(Modifier.fillMaxHeight()) { end.asReversed().forEach { ActionButton(it) { act(it) } } }
        }
        Box(Modifier.offset { IntOffset(offset.value.roundToInt(), 0) }
            .pointerInput(startWidth, endWidth) {
                detectHorizontalDragGestures(
                    onDragEnd = {
                        val v = offset.value
                        settle(when {
                            v > 0 && v > startWidth / 2 -> startWidth
                            v < 0 && -v > endWidth / 2 -> -endWidth
                            else -> 0f
                        })
                    },
                    onDragCancel = { settle(0f) },
                ) { change, dx ->
                    change.consume()
                    scope.launch { offset.snapTo((offset.value + dx).coerceIn(-endWidth, startWidth)) }
                }
            }
            .let { m -> if (abs(offset.value) > 1f) m.clickable { settle(0f) } else m }) {
            content()
        }
    }
}

@Composable
private fun ActionButton(a: SwipeAction, onClick: () -> Unit) {
    Column(Modifier.width(ActionWidth).fillMaxHeight().background(appColors.tonal).clickable(onClick = onClick)
        .semantics { testTag = a.tag }.padding(horizontal = 6.dp, vertical = 8.dp),
        horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = androidx.compose.foundation.layout.Arrangement.Center) {
        Icon(a.icon, null, Modifier.size(22.dp), tint = appColors.ink)
        Text(a.label, style = MaterialTheme.typography.labelMedium, color = appColors.ink, maxLines = 2, textAlign = TextAlign.Center,
            overflow = TextOverflow.Ellipsis)
    }
}
