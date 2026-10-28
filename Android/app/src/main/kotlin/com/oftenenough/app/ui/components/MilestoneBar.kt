package com.oftenenough.app.ui.components

import androidx.compose.animation.core.Animatable
import androidx.compose.animation.core.LinearEasing
import androidx.compose.animation.core.tween
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.gestures.Orientation
import androidx.compose.foundation.gestures.draggable
import androidx.compose.foundation.gestures.rememberDraggableState
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableFloatStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.drawWithContent
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.geometry.CornerRadius
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Matrix
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.asAndroidPath
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.graphics.drawscope.drawIntoCanvas
import androidx.compose.ui.graphics.drawscope.rotate
import androidx.compose.ui.graphics.drawscope.scale
import androidx.compose.ui.graphics.drawscope.withTransform
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.graphics.nativeCanvas
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.platform.LocalAccessibilityManager
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.semantics.LiveRegionMode
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.liveRegion
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

/** The bar's own timeline (Figma's "Milestone · Motion", from the moment the bar starts to rise). */
private const val TIMELINE_MS = 1150f
private fun at(ms: Int) = ms / TIMELINE_MS

/** When the bar's rise has ended and its own motion begins (Today's entrance takes the first 250 ms). */
private const val RISEN_MS = 250

/**
 * Molecule 4.8, **Milestone bar** (Figma 852:45599; Components — Atoms Build Plan): a milestone reached on Today,
 * over the day bar for 5 s. [onSee] opens its pop-up; it goes ([onGone]) when its time is up (longer when the phone
 * asks for more time to act), on a sideways swipe, or, as Today decides, on any other touch or the next milestone.
 *
 * 72 tall, corners 20, the habit's **Bar** gradient (Deep to Strong, left to right) with Material's Elevation Level 3
 * shadow. 12 at the sides; the white medal (40 in a 44 box: the star with a soft shadow, an inner line in the habit's
 * Pale, the number in Label Large in its Strong) and three white sparkles; 12; the milestone ([title]) in Title Medium
 * over the habit's [name] in Body Medium at 86 %, both On primary; 12; See, Material's Small filled button in white
 * with the label in Strong. Along its foot, 20 in and 3 up, the time left: 3 tall, white at 45 %, shrinking.
 *
 * **Inner motion** (the bar's own, from the moment it is up; Today plays its rise, 250 ms): the badge pops (0.6 → 1,
 * 300 ms, with an overshoot), the sparkles appear one after another (60 ms apart) and settle at 60 %, a sheen sweeps
 * once (600 ms), and the time-left line shrinks. With Remove animations the bar shows at rest and the line stays full.
 * The motion is read only where it's drawn, so a moving bar never recomposes (Rulebook S3, S6).
 */
@Composable
fun MilestoneBar(number: String, title: String, name: String, color: HabitColor, onSee: () -> Unit, onGone: () -> Unit, modifier: Modifier = Modifier) {
    val c = appColors
    val s = MaterialTheme.colorScheme
    val density = LocalDensity.current
    val strong = c.habitStrong(color)
    // Figma draws light only: On primary there; in dark the bar keeps its light look (On primary turns dark there).
    val ink = if (c.dark) Color.White else s.onPrimary
    val seeFill = if (c.dark) Color.White else s.surfaceContainerLowest
    val shape = RoundedCornerShape(20.dp)
    val on = animationsOn()
    val t = remember { Animatable(if (on) 0f else 1f) }
    val left = remember { Animatable(1f) }
    val a11y = LocalAccessibilityManager.current
    val stay = remember { a11y?.calculateRecommendedTimeoutMillis(5_000, containsIcons = true, containsText = true, containsControls = true) ?: 5_000 }
    LaunchedEffect(Unit) {
        if (on) launch { t.animateTo(1f, tween(TIMELINE_MS.toInt(), easing = LinearEasing)) }
        delay(RISEN_MS.toLong())
        if (on) left.animateTo(0f, tween(stay.toInt(), easing = LinearEasing)) else delay(stay)
        onGone()
    }
    var drag by remember { mutableFloatStateOf(0f) }
    Row(
        modifier.fillMaxWidth().heightIn(min = 72.dp)
            .graphicsLayer { translationX = drag }
            .draggable(rememberDraggableState { drag += it }, Orientation.Horizontal,
                onDragStopped = { if (kotlin.math.abs(drag) > 80 * density.density) onGone() else drag = 0f })
            .shadow(6.dp, shape)
            .clip(shape)
            .background(Brush.horizontalGradient(listOf(c.habitDeep(color), strong)))
            .drawWithContent {
                drawContent()
                val now = t.value
                // The sheen: 56 × 130, tilted 20°, white at 28 % in its middle, once from left to right.
                if (now > at(550) && now < at(1150)) {
                    val dx = track(now, Key(at(550), -240f, EaseInOut), Key(at(1150), 240f)).dp.toPx()
                    val w = 56.dp.toPx()
                    val h = 130.dp.toPx()
                    val centre = Offset(178.dp.toPx() + dx, size.height / 2)
                    rotate(20f, centre) {
                        drawRect(Brush.horizontalGradient(listOf(Color.Transparent, Color.White.copy(alpha = 0.28f), Color.Transparent),
                            startX = centre.x - w / 2, endX = centre.x + w / 2), topLeft = Offset(centre.x - w / 2, centre.y - h / 2), size = Size(w, h))
                    }
                }
                // The time left, 20 in and 3 up.
                val inset = 20.dp.toPx()
                val line = 3.dp.toPx()
                drawRoundRect(Color.White.copy(alpha = 0.45f), topLeft = Offset(inset, size.height - 3.dp.toPx() - line),
                    size = Size((size.width - 2 * inset) * left.value, line), cornerRadius = CornerRadius(line / 2))
            }
            .padding(12.dp)
            .semantics(mergeDescendants = true) { contentDescription = "$name: $title"; liveRegion = LiveRegionMode.Polite; testTag = "milestone-bar" },
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Box(Modifier.size(44.dp), contentAlignment = Alignment.Center) {
            BarMedal(number, color, Modifier.graphicsLayer {
                val k = track(t.value, Key(at(RISEN_MS), 0.6f, Pop), Key(at(550), 1f))
                scaleX = k; scaleY = k
            })
            Canvas(Modifier.size(44.dp)) {
                // Figma's three sparkles, each a little after the one before; at rest at 60 %.
                listOf(Triple(Offset(41f, 1f), 10f, 0.95f), Triple(Offset(-1.5f, 33.5f), 7f, 0.8f), Triple(Offset(43f, 35f), 6f, 0.7f))
                    .forEachIndexed { i, (p, d, alpha) ->
                        val o = 60 * i
                        val now = t.value
                        val a = track(now, Key(at(300 + o), 0f, EaseOut), Key(at(500 + o), 1f, EaseInOut), Key(at(800 + o), 0.6f))
                        val k = track(now, Key(at(300 + o), 0.01f, Pop), Key(at(550 + o), 1f))
                        if (a > 0f) {
                            val q = Offset(p.x.dp.toPx(), p.y.dp.toPx())
                            scale(k, k, q) { sparkle(q, d.dp.toPx(), Color.White.copy(alpha = alpha * a)) }
                        }
                    }
            }
        }
        Spacer(Modifier.width(12.dp))
        Column(Modifier.weight(1f)) {
            Text(title, style = AppType.titleMedium, color = ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
            Text(name, style = AppType.bodyMedium, color = ink.copy(alpha = 0.86f), maxLines = 1, overflow = TextOverflow.Ellipsis)
        }
        Spacer(Modifier.width(12.dp))
        val h = ButtonDefaults.MinHeight
        Button(onSee, ButtonDefaults.shapesFor(h), Modifier.heightIn(min = h).semantics { testTag = "milestone-bar-see" },
            colors = ButtonDefaults.buttonColors(containerColor = seeFill, contentColor = strong), contentPadding = ButtonDefaults.contentPaddingFor(h)) {
            Text("See", style = AppType.labelLarge, maxLines = 1)
        }
    }
}

/**
 * The bar's medal (Figma's Badge): the medal's star, 40, in white with a soft shadow (1 down, a 3.3 blur); the same
 * star at 82 % as a 0.8 line in the habit's Pale; the [number] in Label Large in the habit's Strong, so it reads on any
 * colour. Three digits and more go a step smaller (Label Medium) to stay inside the line.
 */
@Composable
private fun BarMedal(number: String, color: HabitColor, modifier: Modifier = Modifier) {
    val c = appColors
    val pale = c.habitPale(color)
    val strong = c.habitStrong(color)
    Box(modifier.size(40.dp), contentAlignment = Alignment.Center) {
        Canvas(Modifier.size(40.dp)) {
            val k = size.minDimension / 72f
            val shape = Path().apply { addPath(starPath); transform(Matrix().apply { scale(k, k) }) }
            drawIntoCanvas { canvas ->
                val paint = android.graphics.Paint(android.graphics.Paint.ANTI_ALIAS_FLAG).apply {
                    this.color = Color.White.toArgb()
                    setShadowLayer(3.33f.dp.toPx(), 0f, 1.11f.dp.toPx(), Color.Black.copy(alpha = 0.35f).toArgb())
                }
                canvas.nativeCanvas.drawPath(shape.asAndroidPath(), paint)
            }
            withTransform({ scale(0.825f, 0.825f, Offset(size.width / 2, size.height / 2)) }) {
                drawPath(shape, pale, style = Stroke(width = 0.83f.dp.toPx() / 0.825f))
            }
        }
        Text(number, style = if (number.length > 2) AppType.labelMedium else AppType.labelLarge, color = strong, maxLines = 1)
    }
}
