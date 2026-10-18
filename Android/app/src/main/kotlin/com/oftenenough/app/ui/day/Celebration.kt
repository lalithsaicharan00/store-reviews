package com.oftenenough.app.ui.day

import android.provider.Settings
import androidx.compose.animation.core.Animatable
import androidx.compose.animation.core.CubicBezierEasing
import androidx.compose.animation.core.Easing
import androidx.compose.animation.core.LinearEasing
import androidx.compose.animation.core.tween
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.ModalBottomSheet
import androidx.compose.material3.Text
import androidx.compose.material3.rememberModalBottomSheetState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.drawWithContent
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.compositeOver
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.graphics.drawscope.rotate
import androidx.compose.ui.graphics.drawscope.scale
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.ui.components.CookieShape
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlin.math.cos
import kotlin.math.sin

// ------------------------------------------------------------------ Figma's timings, exactly (Figma 14, 14.1)

/** One keyframe of a track: its time (0–1 of the 2 s timeline), its value, and the easing from it to the next. */
class Key(val at: Float, val value: Float, val ease: Easing = LinearEasing)

/** The value of a keyframe track at [t] (0–1). */
fun track(t: Float, vararg keys: Key): Float {
    if (t <= keys.first().at) return keys.first().value
    for (i in 0 until keys.size - 1) {
        val a = keys[i]
        val b = keys[i + 1]
        if (t <= b.at) {
            val f = ((t - a.at) / (b.at - a.at)).coerceIn(0f, 1f)
            return a.value + (b.value - a.value) * a.ease.transform(f)
        }
    }
    return keys.last().value
}

private val EaseOut = CubicBezierEasing(0f, 0f, 0.58f, 1f)
private val EaseIn = CubicBezierEasing(0.42f, 0f, 1f, 1f)
private val EaseInOut = CubicBezierEasing(0.42f, 0f, 0.58f, 1f)
/** Material's emphasized decelerate: things that arrive. */
private val Arrive = CubicBezierEasing(0.05f, 0.7f, 0.1f, 1f)
/** The sparkles' pop, with a little overshoot. */
private val Pop = CubicBezierEasing(0.45f, 1.45f, 0.8f, 1f)

/**
 * The 2 s timeline, played once when [key] first shows (the design loops it only as a preview). With animations off on
 * the phone (Developer options, or Remove animations), everything is at its resting place at once.
 */
@Composable
private fun rememberTimeline(key: Any): Animatable<Float, *> {
    val context = LocalContext.current
    val t = remember(key) { Animatable(0f) }
    LaunchedEffect(key) {
        val scale = runCatching { Settings.Global.getFloat(context.contentResolver, Settings.Global.ANIMATOR_DURATION_SCALE, 1f) }.getOrDefault(1f)
        if (scale == 0f) t.snapTo(1f) else t.animateTo(1f, tween(2000, easing = LinearEasing))
    }
    return t
}

// ------------------------------------------------------------------ The medal

/** A milestone's medal (the habit page's, made special): the cookie in a gradient of the habit's colour, a white inner ring. */
@Composable
fun CelebrationMedal(number: String?, size: Dp, color: HabitColor, modifier: Modifier = Modifier) {
    val c = appColors
    val base = c.habit(color)
    val light = Color.White.copy(alpha = 0.28f).compositeOver(base)
    val dark = Color.Black.copy(alpha = 0.12f).compositeOver(base)
    Box(modifier.size(size), contentAlignment = Alignment.Center) {
        Box(Modifier.size(size).clip(CookieShape()).background(Brush.verticalGradient(listOf(light, dark))))
        Box(Modifier.size(size * 0.82f).border(maxOf(0.5.dp, size * 0.0036f * 4), Color.White.copy(alpha = 0.55f), CookieShape()))
        if (number != null) {
            val share = if (number.length >= 4) 0.24f else if (number.length == 3) 0.28f else 0.333f
            val sp = with(LocalDensity.current) { (size * share).toSp() }
            Text(number, color = Color.White, fontSize = sp, style = AppType.titleMedium.copy(fontSize = sp, lineHeight = sp), maxLines = 1)
        }
    }
}

// ------------------------------------------------------------------ The ribbon (Figma 14)

/**
 * A milestone reached today, at the top of This day (Figma 14, as in the routine player): the habit's colour at 24 %, a
 * small medal and "14 days in a row · reached today" in a dark shade of the colour. It drops in once, the medal spins in
 * and a sheen passes over it once; it stays for the rest of the day.
 */
@Composable
fun MilestoneRibbon(text: String, color: HabitColor, key: Any) {
    val c = appColors
    val base = c.habit(color)
    val ink = if (c.dark) Color.White.copy(alpha = 0.72f).compositeOver(base) else Color.Black.copy(alpha = 0.5f).compositeOver(base)
    val tl = rememberTimeline(key)
    val t = tl.value
    val density = LocalDensity.current
    val dropY = track(t, Key(0f, -20f), Key(0.25f, -20f, Arrive), Key(0.40f, 0f))
    val alpha = track(t, Key(0f, 0f), Key(0.25f, 0f, EaseOut), Key(0.33f, 1f))
    Row(
        Modifier.fillMaxWidth().height(40.dp)
            .graphicsLayer { translationY = dropY * density.density; this.alpha = alpha }
            .clip(RoundedCornerShape(12.dp)).background(base.copy(alpha = 0.24f).compositeOver(c.surface))
            .drawWithContent {
                drawContent()
                // The sheen: once, left to right.
                val x = track(t, Key(0f, 0f), Key(0.46f, 0f, EaseInOut), Key(0.76f, 520f)) * density.density - 48.dp.toPx()
                if (t in 0.46f..0.78f) drawRect(Brush.horizontalGradient(listOf(Color.Transparent, Color.White.copy(alpha = 0.45f), Color.Transparent),
                    startX = x, endX = x + 48.dp.toPx()), topLeft = Offset(x, 0f), size = Size(48.dp.toPx(), size.height))
            }
            .padding(horizontal = 12.dp).semantics(mergeDescendants = true) { testTag = "day-ribbon" },
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.spacedBy(8.dp),
    ) {
        val rot = track(t, Key(0f, 35f), Key(0.31f, 35f, EaseOut), Key(0.47f, 0f))
        val sc = track(t, Key(0f, 0.01f), Key(0.31f, 0.01f, EaseOut), Key(0.40f, 1.3f, EaseInOut), Key(0.47f, 1f))
        CelebrationMedal(null, 18.dp, color, Modifier.graphicsLayer { rotationZ = rot; scaleX = sc; scaleY = sc })
        val tx = track(t, Key(0f, -8f), Key(0.33f, -8f, Arrive), Key(0.44f, 0f))
        val ta = track(t, Key(0f, 0f), Key(0.33f, 0f, Arrive), Key(0.44f, 1f))
        Text(text, Modifier.graphicsLayer { translationX = tx * density.density; this.alpha = ta }, style = AppType.labelLarge, color = ink, maxLines = 1)
    }
}

// ------------------------------------------------------------------ The pop-up (Figma 14.1)

/**
 * A landmark reached (Figma 14.1): its own sheet rises over Day details at once. The medal spins in over a glow, a ring
 * and twelve dots burst from it, four sparkles pop; then the words, the next milestone and the buttons arrive in turn.
 * Close returns to Day details; All milestones opens the habit's page there.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun LandmarkPopup(
    number: String, title: String, subtitle: String, color: HabitColor,
    next: Triple<String, String, Float>?, onClose: () -> Unit, onAll: () -> Unit,
) {
    val c = appColors
    val state = rememberModalBottomSheetState(skipPartiallyExpanded = true)
    ModalBottomSheet(onClose, sheetState = state, containerColor = c.menu, shape = RoundedCornerShape(topStart = 28.dp, topEnd = 28.dp),
        dragHandle = { Box(Modifier.padding(top = 12.dp).size(32.dp, 4.dp).clip(RoundedCornerShape(2.dp)).background(c.outline.copy(alpha = 0.4f))) }) {
        val tl = rememberTimeline(number)
        val t = tl.value
        val density = LocalDensity.current
        val base = c.habit(color)
        Column(Modifier.fillMaxWidth().navigationBarsPadding().padding(start = 24.dp, end = 24.dp, bottom = 32.dp)
            .semantics { testTagsAsResourceId = true; testTag = "landmark-popup" },
            horizontalAlignment = Alignment.CenterHorizontally) {
            Spacer(Modifier.height(8.dp))
            // The medal's stage: 176 high; everything is placed from its centre (156, 92 in Figma's 312-wide stage).
            Box(Modifier.fillMaxWidth().height(176.dp).semantics { contentDescription = "$title, reached today" }) {
                Canvas(Modifier.matchParentSize()) {
                    val centre = Offset(size.width / 2, 92.dp.toPx())
                    // The glow.
                    val ga = track(t, Key(0f, 0f), Key(0.10f, 0f, EaseOut), Key(0.30f, 1f))
                    val gs = track(t, Key(0f, 0.6f), Key(0.10f, 0.6f, EaseOut), Key(0.375f, 1f))
                    val gr = 75.dp.toPx() * 1.32f * gs
                    drawCircle(Brush.radialGradient(listOf(base.copy(alpha = 0.42f * ga), base.copy(alpha = 0f)), centre, gr), gr, centre)
                    // The burst ring.
                    val ra = track(t, Key(0f, 0f), Key(0.225f, 0f, EaseOut), Key(0.25f, 0.6f, EaseOut), Key(0.50f, 0f))
                    val rs = track(t, Key(0f, 0.8f), Key(0.225f, 0.8f, EaseOut), Key(0.50f, 1.3f))
                    if (ra > 0f) drawCircle(base.copy(alpha = ra), 58.dp.toPx() * rs, centre, style = Stroke(2.dp.toPx()))
                    // Twelve dots, every 30° from 15°, each a little later than the one before.
                    for (i in 0 until 12) {
                        val start = 0.225f + 0.005f * i
                        val a = Math.toRadians(15.0 + 30.0 * i)
                        val da = track(t, Key(0f, 0f), Key(start, 0f, EaseOut), Key(start + 0.04f, 1f, EaseIn), Key(start + 0.30f, 0f))
                        val ds = track(t, Key(0f, 0.6f), Key(start, 0.6f, EaseOut), Key(start + 0.075f, 1f, EaseIn), Key(start + 0.30f, 0.3f))
                        val travel = track(t, Key(0f, -20f), Key(start, -20f, EaseOut), Key(start + 0.19f, 0f))
                        val r = (64f + travel) * density.density
                        val p = Offset(centre.x + (cos(a) * r).toFloat(), centre.y + (sin(a) * r).toFloat())
                        val radius = (if (i % 2 == 0) 3.5f else 2.5f) * density.density * ds
                        if (da > 0f) drawCircle(base.copy(alpha = da), radius, p)
                    }
                    // Four sparkles, popping in turn.
                    listOf(Triple(206f + 6f, 36f + 6f, 12f), Triple(87.5f + 4.5f, 59.5f + 4.5f, 9f), Triple(216f + 4f, 116f + 4f, 8f), Triple(103f + 5f, 135f + 5f, 10f))
                        .forEachIndexed { i, (x, y, s) ->
                            val start = 0.40f + 0.05f * i
                            val sa = track(t, Key(0f, 0f), Key(start, 0f, EaseOut), Key(start + 0.075f, 1f, EaseInOut), Key(start + 0.25f, 0.5f))
                            val sr = track(t, Key(0f, 0f), Key(start, 0f, EaseOut), Key(start + 0.25f, 45f))
                            val ss = track(t, Key(0f, 0.01f), Key(start, 0.01f, Pop), Key(start + 0.10f, 1.15f, EaseInOut), Key(start + 0.25f, 0.85f))
                            if (sa <= 0f) return@forEachIndexed
                            val p = Offset(centre.x + (x - 156f) * density.density, centre.y + (y - 92f) * density.density)
                            val half = s / 2 * density.density
                            rotate(sr, p) {
                                scale(ss, ss, p) {
                                    val star = Path().apply {
                                        moveTo(p.x, p.y - half); quadraticTo(p.x, p.y, p.x + half, p.y); quadraticTo(p.x, p.y, p.x, p.y + half)
                                        quadraticTo(p.x, p.y, p.x - half, p.y); quadraticTo(p.x, p.y, p.x, p.y - half); close()
                                    }
                                    drawPath(star, base.copy(alpha = sa))
                                }
                            }
                        }
                }
                // The medal: spins in from 25°, overshoots, settles.
                val mr = track(t, Key(0f, 25f), Key(0.125f, 25f, EaseOut), Key(0.41f, 0f))
                val ms = track(t, Key(0f, 0.3f), Key(0.125f, 0.3f, EaseOut), Key(0.31f, 1.12f, EaseInOut), Key(0.41f, 1f))
                val ma = track(t, Key(0f, 0f), Key(0.125f, 0f), Key(0.14f, 1f))
                CelebrationMedal(number, 104.dp, color, Modifier.align(Alignment.TopCenter).offset(y = 40.dp)
                    .graphicsLayer { rotationZ = mr; scaleX = ms; scaleY = ms; alpha = ma })
            }
            Spacer(Modifier.height(4.dp))
            fun Modifier.arrive(start: Float, dy: Float) = graphicsLayer {
                alpha = track(t, Key(0f, 0f), Key(start, 0f, EaseOut), Key(start + 0.125f, 1f))
                translationY = track(t, Key(0f, dy), Key(start, dy, Arrive), Key(start + 0.15f, 0f)) * density.density
            }
            Text(title, Modifier.fillMaxWidth().arrive(0.275f, 12f), style = AppType.headlineSmallEmphasized, color = c.ink, textAlign = TextAlign.Center)
            Spacer(Modifier.height(6.dp))
            Text(subtitle, Modifier.fillMaxWidth().arrive(0.315f, 12f), style = AppType.bodyMedium, color = c.secondary, textAlign = TextAlign.Center)
            if (next != null) {
                Spacer(Modifier.height(20.dp))
                val (target, detail, fraction) = next
                Row(Modifier.fillMaxWidth().arrive(0.45f, 12f).clip(RoundedCornerShape(20.dp)).background(c.surface).padding(horizontal = 18.dp, vertical = 14.dp)
                    .heightIn(min = 76.dp).padding(horizontal = 16.dp), verticalAlignment = Alignment.CenterVertically) {
                    Box(Modifier.size(52.dp), contentAlignment = Alignment.Center) {
                        Canvas(Modifier.size(52.dp)) {
                            val w = 4.dp.toPx()
                            val arc = Size(size.width - w, size.height - w)
                            drawArc(base.copy(alpha = 0.18f), 0f, 360f, false, Offset(w / 2, w / 2), arc, style = Stroke(w))
                            drawArc(base, -90f, 360f * fraction, false, Offset(w / 2, w / 2), arc, style = Stroke(w, cap = StrokeCap.Round))
                        }
                        Text(target, style = AppType.titleMedium, color = c.ink, maxLines = 1)
                    }
                    Spacer(Modifier.width(16.dp))
                    Column {
                        Text("$target ${title.substringAfter(' ')}", style = AppType.titleMedium, color = c.ink)
                        Text(detail, style = AppType.bodyMedium, color = c.secondary)
                    }
                }
            }
            Spacer(Modifier.height(20.dp))
            Row(Modifier.fillMaxWidth().arrive(0.50f, 8f), horizontalArrangement = Arrangement.spacedBy(10.dp)) {
                Box(Modifier.weight(1f).height(48.dp).clip(RoundedCornerShape(24.dp)).border(1.dp, c.outline, RoundedCornerShape(24.dp))
                    .clickable(onClick = onClose).semantics { testTag = "landmark-close" }, contentAlignment = Alignment.Center) {
                    Text("Close", style = AppType.labelLarge, color = c.ink)
                }
                Box(Modifier.weight(1f).height(48.dp).clip(RoundedCornerShape(24.dp)).background(c.ink)
                    .clickable(onClick = onAll).semantics { testTag = "landmark-all" }, contentAlignment = Alignment.Center) {
                    Text("All milestones", style = AppType.labelLarge, color = c.onInk)
                }
            }
        }
    }
}
