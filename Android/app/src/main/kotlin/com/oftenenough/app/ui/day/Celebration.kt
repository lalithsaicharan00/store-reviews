package com.oftenenough.app.ui.day

import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.ButtonSize
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.CircularProgressLabel
import com.oftenenough.app.ui.components.AppCircularProgress
import android.provider.Settings
import androidx.compose.animation.core.Animatable
import androidx.compose.animation.core.LinearEasing
import androidx.compose.animation.core.tween
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
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
import com.oftenenough.app.ui.components.rememberWholeSheetState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Path
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
import com.oftenenough.app.ui.components.Arrive
import com.oftenenough.app.ui.components.EaseIn
import com.oftenenough.app.ui.components.EaseInOut
import com.oftenenough.app.ui.components.EaseOut
import com.oftenenough.app.ui.components.Key
import com.oftenenough.app.ui.components.Pop
import com.oftenenough.app.ui.components.track
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlin.math.cos
import kotlin.math.sin

// ------------------------------------------------------------------ Figma's timings, exactly (Figma 14, 14.1)

// Key, track and Figma's easings (EaseOut, EaseIn, EaseInOut, Arrive, Pop) are the design system's (ui/components/Motion.kt).

/**
 * The 2 s timeline, played once when [key] first shows (the design loops it only as a preview). With animations off on
 * the phone (Developer options, or Remove animations), everything is at its resting place at once.
 */
@Composable
private fun rememberTimeline(key: Any, play: Boolean = true): Animatable<Float, *> {
    val context = LocalContext.current
    val t = remember(key) { Animatable(if (play) 0f else 1f) }
    LaunchedEffect(key, play) {
        if (!play || t.value >= 1f) return@LaunchedEffect
        val scale = runCatching { Settings.Global.getFloat(context.contentResolver, Settings.Global.ANIMATOR_DURATION_SCALE, 1f) }.getOrDefault(1f)
        if (scale == 0f) t.snapTo(1f) else t.animateTo(1f, tween(2000, easing = LinearEasing))
    }
    return t
}

// ------------------------------------------------------------------ The medal

/** A milestone's medal: the one medal the whole app draws (`Medal`, 3.5: Figma's star, gradient, inner line, shadow). */
@Composable
fun CelebrationMedal(number: String?, size: Dp, color: HabitColor, modifier: Modifier = Modifier) =
    com.oftenenough.app.ui.components.Medal(number, size, color, modifier)

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
    next: com.oftenenough.app.data.MilestoneAhead?, onClose: () -> Unit, onAll: () -> Unit,
    /** "All milestones", or "See the year" for an anniversary (Figma P.10). */
    second: String = "All milestones",
    /** "and 1 more in this routine" (Figma RP.3): a chip under the words. */
    more: String? = null,
) {
    val c = appColors
    val state = rememberWholeSheetState()
    ModalBottomSheet(onClose, sheetState = state) {
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
            if (more != null) {
                Spacer(Modifier.height(12.dp))
                Row(Modifier.arrive(0.40f, 8f).clip(RoundedCornerShape(16.dp)).background(c.surface).clickable(onClick = onClose)
                    .padding(start = 14.dp, end = 8.dp, top = 6.dp, bottom = 6.dp).semantics { testTag = "landmark-more" },
                    verticalAlignment = Alignment.CenterVertically) {
                    Text(more, style = AppType.labelLarge, color = c.ink)
                    androidx.compose.material3.Icon(Symbols.KeyboardArrowRight, null, Modifier.size(18.dp), tint = c.ink)
                }
            }
            if (next != null) {
                Spacer(Modifier.height(20.dp))
                val target = next.number
                val fraction = next.fraction
                Row(Modifier.fillMaxWidth().arrive(0.45f, 12f).clip(RoundedCornerShape(20.dp)).background(c.surface).padding(horizontal = 18.dp, vertical = 14.dp)
                    .heightIn(min = 76.dp).padding(horizontal = 16.dp), verticalAlignment = Alignment.CenterVertically) {
                    AppCircularProgress(fraction.toFloat(), color) { CircularProgressLabel(target) }
                    Spacer(Modifier.width(16.dp))
                    Column {
                        Text(next.title, style = AppType.titleMedium, color = c.ink)
                        Text(next.detail, style = AppType.bodyMedium, color = c.secondary)
                    }
                }
            }
            Spacer(Modifier.height(20.dp))
            Row(Modifier.fillMaxWidth().arrive(0.50f, 8f), horizontalArrangement = Arrangement.spacedBy(10.dp)) {
                AppButton("Close", onClose, Modifier.weight(1f), style = ButtonStyle.Outlined, size = ButtonSize.Medium, compact = true, tag = "landmark-close")
                AppButton(second, onAll, Modifier.weight(1f), size = ButtonSize.Medium, compact = true, tag = "landmark-all")
            }
        }
    }
}
