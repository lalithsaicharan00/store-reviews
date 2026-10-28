package com.oftenenough.app.ui.components

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
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Alignment
import androidx.compose.ui.ExperimentalComposeUiApi
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.graphics.drawscope.rotate
import androidx.compose.ui.graphics.drawscope.scale
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.MilestoneAhead
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch
import kotlin.math.cos
import kotlin.math.sin

/** The pop-up's own timeline (Figma's "Milestone · Motion", Pop-up: everything has arrived by 1.3 s of its 2.4 s). */
private const val POPUP_MS = 1300f
private fun at(ms: Int) = ms / POPUP_MS

/**
 * Molecule 4.12, **Milestone pop-up** (Figma 853:45861; Components — Atoms Build Plan): a landmark milestone, in a
 * modal bottom sheet of its own over Today, Day details, the routine player or the habit page.
 *
 * The [AppBottomSheet] (1.18: Surface container low, 28 top corners, Material's drag handle, scrim, Level 1). In it,
 * 24 at the sides, 24 apart: the **hero** (the medal's stage, 176 tall: a glow, the Large [Medal] with its [number],
 * a burst ring, twelve dots and four sparkles; 4; the [title] in Headline Small Emphasized On surface; 4; the
 * [supporting] text in Body Medium On surface variant, both centred); the [next] milestone (4.10) on a Surface
 * container lowest card, 24 corners, 20 in; **Close** (Outlined) and [second] ("All milestones", or "See the year" for
 * an anniversary; Filled), Medium, side by side, 8 apart. [more] ("and 1 more in this routine", the routine player's)
 * is a chip under the words that closes it too.
 *
 * **Inner motion**, once as it opens (Figma's keyframes, to the millisecond): the glow fades and grows in (200 ms on);
 * the medal spins in from 25° and pops (0.3 → 1.12 → 1, 250–820 ms); the ring bursts (0.8 → 1.3) and twelve dots fly
 * out in turn, 10 ms apart (450 ms on); the sparkles pop one after another, 100 ms apart, and settle at half (800 ms
 * on); then the title, the supporting text, the card and the buttons rise in turn (550, 630, 850, 950 ms). Read only
 * where it's drawn (S3, S6); at rest with Remove animations. Its entrance (the scrim and the sheet sliding up) and
 * leaving, predictive back included, are Material's sheet's own. Close and [second] slide it away before [onClose] and
 * [onAll] run.
 */
@OptIn(ExperimentalMaterial3Api::class, ExperimentalComposeUiApi::class)
@Composable
fun MilestonePopup(
    number: String, title: String, supporting: String, color: HabitColor, next: MilestoneAhead?,
    onClose: () -> Unit, onAll: () -> Unit, second: String = "All milestones", more: String? = null,
) {
    val c = appColors
    val s = MaterialTheme.colorScheme
    val state = rememberWholeSheetState()
    val scope = rememberCoroutineScope()
    fun leave(then: () -> Unit) { scope.launch { state.hide() }.invokeOnCompletion { then() } }
    val on = animationsOn()
    val t = remember(number) { Animatable(if (on) 0f else 1f) }
    LaunchedEffect(number) { if (on) t.animateTo(1f, tween(POPUP_MS.toInt(), easing = LinearEasing)) }
    fun Modifier.arrive(ms: Int, dy: Float) = graphicsLayer {
        val now = t.value
        alpha = track(now, Key(at(ms), 0f, EaseOut), Key(at(ms + 250), 1f))
        translationY = track(now, Key(at(ms), dy, Arrive), Key(at(ms + 300), 0f)) * density
    }
    AppBottomSheet(onClose, sheetState = state) {
        Column(Modifier.fillMaxWidth().padding(horizontal = 24.dp).semantics { testTagsAsResourceId = true; testTag = "landmark-popup" },
            verticalArrangement = Arrangement.spacedBy(24.dp), horizontalAlignment = Alignment.CenterHorizontally) {
            Column(Modifier.fillMaxWidth(), verticalArrangement = Arrangement.spacedBy(4.dp), horizontalAlignment = Alignment.CenterHorizontally) {
                MedalStage(number, title, color) { t.value }
                Text(title, Modifier.fillMaxWidth().arrive(550, 12f), style = AppType.headlineSmallEmphasized, color = s.onSurface, textAlign = TextAlign.Center)
                Text(supporting, Modifier.fillMaxWidth().arrive(630, 12f), style = AppType.bodyMedium, color = s.onSurfaceVariant, textAlign = TextAlign.Center)
                if (more != null) {
                    Row(Modifier.padding(top = 8.dp).arrive(800, 8f).clip(RoundedCornerShape(16.dp)).background(c.surface).clickable { leave(onClose) }
                        .padding(start = 14.dp, end = 8.dp, top = 6.dp, bottom = 6.dp).semantics { testTag = "landmark-more" },
                        verticalAlignment = Alignment.CenterVertically) {
                        Text(more, style = AppType.labelLarge, color = s.onSurface)
                        Icon(Symbols.KeyboardArrowRight, null, Modifier.size(18.dp), tint = s.onSurface)
                    }
                }
            }
            if (next != null) {
                Box(Modifier.fillMaxWidth().arrive(850, 12f).clip(RoundedCornerShape(24.dp)).background(s.surfaceContainerLowest).padding(20.dp)) {
                    NextMilestone(next.number, next.title, next.detail, next.fraction, color)
                }
            }
            Row(Modifier.fillMaxWidth().arrive(950, 8f), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                AppButton("Close", { leave(onClose) }, Modifier.weight(1f), style = ButtonStyle.Outlined, size = ButtonSize.Medium, tag = "landmark-close")
                AppButton(second, { leave(onAll) }, Modifier.weight(1f), size = ButtonSize.Medium, tag = "landmark-all")
            }
        }
    }
}

/**
 * The medal's stage, 176 tall; everything placed from its centre (156, 92 in Figma's 312-wide stage): a glow (the
 * habit's Band, 150 across, blurred 24), the Large medal (104) 40 down, a burst ring (116, a 2.5 line in the habit's
 * Colour), twelve dots (7 and 5 across in turn, the habit's Pale, every 30° from 15°, 64 out) and four sparkles in its
 * Colour. [t] is read only while drawing.
 */
@Composable
private fun MedalStage(number: String, title: String, color: HabitColor, t: () -> Float) {
    val c = appColors
    val base = c.habit(color)
    val band = c.habitBand(color)
    val pale = c.habitPale(color)
    Box(Modifier.fillMaxWidth().height(176.dp).semantics { contentDescription = "$title, reached today" }) {
        Canvas(Modifier.matchParentSize()) {
            val now = t()
            val centre = Offset(size.width / 2, 92.dp.toPx())
            // The glow: Figma's 150 dp disc blurred 24 dp, drawn as its soft edge (solid to 51, nothing by 99).
            val ga = track(now, Key(at(200), 0f, EaseOut), Key(at(600), 1f))
            val gs = track(now, Key(at(200), 0.6f, EaseOut), Key(at(750), 1f))
            if (ga > 0f) {
                val r = 99.dp.toPx() * gs
                drawCircle(Brush.radialGradient(0f to band, 0.52f to band, 1f to band.copy(alpha = 0f), center = centre, radius = r), r, centre, alpha = ga)
            }
            // The burst ring.
            val ra = track(now, Key(at(450), 0f, EaseOut), Key(at(500), 0.6f, EaseOut), Key(at(1000), 0f))
            val rs = track(now, Key(at(450), 0.8f, EaseOut), Key(at(1000), 1.3f))
            if (ra > 0f) drawCircle(base.copy(alpha = ra), 58.dp.toPx() * rs, centre, style = Stroke(2.5f.dp.toPx()))
            // Twelve dots, each 10 ms after the one before, flying 20 dp out to 64.
            for (i in 0 until 12) {
                val start = 450 + 10 * i
                val da = track(now, Key(at(start), 0f, EaseOut), Key(at(start + 80), 1f, EaseIn), Key(at(start + 600), 0f))
                if (da <= 0f) continue
                val ds = track(now, Key(at(start), 0.6f, EaseOut), Key(at(start + 150), 1f, EaseIn), Key(at(start + 600), 0.3f))
                val out = track(now, Key(at(start), 44f, EaseOut), Key(at(start + 380), 64f)).dp.toPx()
                val a = Math.toRadians(15.0 + 30.0 * i)
                val p = Offset(centre.x + (cos(a) * out).toFloat(), centre.y + (sin(a) * out).toFloat())
                drawCircle(pale.copy(alpha = da), (if (i % 2 == 0) 3.5f else 2.5f).dp.toPx() * ds, p)
            }
            // Four sparkles, 100 ms apart: Figma's centres and sizes.
            listOf(Triple(212f, 42f, 12f), Triple(92f, 64f, 9f), Triple(220f, 120f, 8f), Triple(108f, 140f, 10f)).forEachIndexed { i, (x, y, d) ->
                val start = 800 + 100 * i
                val sa = track(now, Key(at(start), 0f, EaseOut), Key(at(start + 150), 1f, EaseInOut), Key(at(start + 500), 0.5f))
                if (sa <= 0f) return@forEachIndexed
                val sr = track(now, Key(at(start), 0f, EaseOut), Key(at(start + 500), 45f))
                val ss = track(now, Key(at(start), 0.01f, Pop), Key(at(start + 200), 1.15f, EaseInOut), Key(at(start + 500), 0.85f))
                val p = Offset(centre.x + (x - 156f).dp.toPx(), centre.y + (y - 92f).dp.toPx())
                rotate(sr, p) { scale(ss, ss, p) { sparkle(p, d.dp.toPx(), base.copy(alpha = sa)) } }
            }
        }
        // The medal: spins in from 25°, overshoots, settles.
        Medal(number, 104.dp, color, Modifier.align(Alignment.TopCenter).offset(y = 40.dp).graphicsLayer {
            val now = t()
            rotationZ = track(now, Key(at(250), 25f, EaseOut), Key(at(820), 0f))
            val k = track(now, Key(at(250), 0.3f, EaseOut), Key(at(620), 1.12f, EaseInOut), Key(at(820), 1f))
            scaleX = k; scaleY = k
        })
    }
}
