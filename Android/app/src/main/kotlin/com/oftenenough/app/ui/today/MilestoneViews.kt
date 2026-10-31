package com.oftenenough.app.ui.today

import kotlin.math.roundToInt
import androidx.compose.ui.layout.layout
import androidx.compose.ui.draw.clipToBounds
import com.oftenenough.app.ui.theme.Symbols
import androidx.compose.animation.core.Animatable
import androidx.compose.animation.core.LinearEasing
import androidx.compose.animation.core.tween
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.drawWithContent
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.compositeOver
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.graphics.drawscope.rotate
import androidx.compose.ui.graphics.drawscope.scale
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.ui.components.Arrive
import com.oftenenough.app.ui.components.EaseIn
import com.oftenenough.app.ui.components.EaseInOut
import com.oftenenough.app.ui.components.EaseOut
import com.oftenenough.app.ui.components.Key
import com.oftenenough.app.ui.components.Pop
import com.oftenenough.app.ui.components.animationsOn
import com.oftenenough.app.ui.components.sparkle
import com.oftenenough.app.ui.components.track
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlin.math.cos
import kotlin.math.sin

/** One timeline of [ms], played once per [key] while [play]; at rest (1) otherwise or with animations off. */
@Composable
fun rememberPlay(key: Any?, play: Boolean, ms: Int): Float {
    val on = animationsOn()
    val t = remember(key) { Animatable(if (play && on) 0f else 1f) }
    LaunchedEffect(key, play) { if (play && on && t.value < 1f) t.animateTo(1f, tween(ms, easing = LinearEasing)) }
    return t.value
}

/** The words' shade of a habit's colour on its own light tint (Figma: #982C22 on Meds' red). */
@Composable
fun bandInk(color: HabitColor): Color {
    val c = appColors
    val base = c.habit(color)
    return if (c.dark) Color.White.copy(alpha = 0.75f).compositeOver(base) else Color.Black.copy(alpha = 0.35f).compositeOver(base)
}

// ------------------------------------------------------------------ The row's band (Figma R.1, A.1: ML.B)

/**
 * A milestone in its row for the rest of the day (Figma R.1, "Milestone band"): the full width of the row's foot, 32 dp,
 * the habit's colour at 22 %, a 16 dp medal 72 dp in (under the name), and "60 days in a row" in the
 * colour's dark shade; See › at the end for a pop-up's band reached away (A.1). Tapping it opens the pop-up.
 *
 * [raw]: where R.1's 2.6 s timeline is (1 at rest): the band opens from 0.42 s, the medal spins in, the words slide in,
 * a sheen and two sparkles. [early]: played on its own (reached away, A.1), from the start.
 */
@Composable
fun MilestoneBand(text: String, color: HabitColor, see: Boolean, raw: Float, early: Boolean, onTap: () -> Unit) {
    val c = appColors
    val base = c.habit(color)
    val ink = bandInk(color)
    val density = LocalDensity.current
    // Played on its own, the band starts at once: R.1's band timings moved 0.46 s earlier.
    val t = if (early) (raw + 0.177f).coerceAtMost(1f) else raw
    // Figma's Row band (Milestone · Motion): the band opens from nothing to its height (0.42–0.80 s, emphasized
    // decelerate) and fades in (0.46–0.62 s), so the row grows instead of jumping.
    val open = track(t, Key(0f, 0f), Key(0.1615f, 0f, Arrive), Key(0.3077f, 1f))
    val a = track(t, Key(0f, 0f), Key(0.177f, 0f, EaseOut), Key(0.2385f, 1f))
    Row(
        Modifier.fillMaxWidth().clipToBounds()
            .layout { measurable, constraints ->
                val p = measurable.measure(constraints)
                layout(p.width, (p.height * open).roundToInt()) { p.place(0, 0) }
            }
            .heightIn(min = 32.dp)
            .graphicsLayer { alpha = a }
            .background(base.copy(alpha = if (c.dark) 0.30f else 0.22f))
            .drawWithContent {
                drawContent()
                // The sheen: once, left to right (0.88–1.48 s).
                val x = track(t, Key(0f, 0f), Key(0.338f, 0f, EaseInOut), Key(0.569f, 520f)) * density.density - 147.dp.toPx()
                if (t in 0.338f..0.57f) drawRect(Brush.horizontalGradient(listOf(Color.Transparent, Color.White.copy(alpha = 0.5f), Color.Transparent),
                    startX = x, endX = x + 48.dp.toPx()), topLeft = Offset(x, 0f), size = Size(48.dp.toPx(), size.height))
                // Two sparkles beside the words (0.82–1.40 s).
                listOf(0.315f to Offset(40.dp.toPx(), 8.dp.toPx()), 0.346f to Offset(size.width - 28.dp.toPx(), size.height - 9.dp.toPx())).forEach { (start, p) ->
                    val sa = track(t, Key(0f, 0f), Key(start, 0f, EaseOut), Key(start + 0.046f, 1f, EaseIn), Key(start + 0.192f, 0f))
                    val ss = track(t, Key(0f, 0.01f), Key(start, 0.01f, Pop), Key(start + 0.069f, 1.1f, EaseIn), Key(start + 0.192f, 0.5f))
                    val sr = track(t, Key(0f, 0f), Key(start, 0f, EaseOut), Key(start + 0.192f, 45f))
                    if (sa > 0f) rotate(sr, p) { scale(ss, ss, p) { sparkle(p, 8.dp.toPx(), base.copy(alpha = sa)) } }
                }
            }
            .clickable(role = Role.Button, onClickLabel = "See this milestone", onClick = onTap)
            .padding(start = 72.dp, end = 12.dp)
            .semantics(mergeDescendants = true) { contentDescription = text; testTag = "milestone-band" },
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.spacedBy(6.dp),
    ) {
        val rot = track(t, Key(0f, 35f), Key(0.223f, 35f, EaseOut), Key(0.346f, 0f))
        val sc = track(t, Key(0f, 0.01f), Key(0.223f, 0.01f, EaseOut), Key(0.292f, 1.3f, EaseInOut), Key(0.346f, 1f))
        com.oftenenough.app.ui.components.Medal(null, 16.dp, color, Modifier.graphicsLayer { rotationZ = rot; scaleX = sc; scaleY = sc })
        val tx = track(t, Key(0f, -8f), Key(0.246f, -8f, Arrive), Key(0.331f, 0f))
        val ta = track(t, Key(0f, 0f), Key(0.246f, 0f, Arrive), Key(0.331f, 1f))
        Text(text, Modifier.weight(1f).graphicsLayer { translationX = tx * density.density; alpha = ta },
            style = AppType.labelMedium, color = ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
        if (see) {
            Text("See", Modifier.graphicsLayer { alpha = ta }, style = AppType.labelMedium, color = ink)
            Icon(Symbols.KeyboardArrowRight, null, Modifier.size(16.dp).graphicsLayer { alpha = ta }, tint = ink)
        }
    }
}

// ------------------------------------------------------------------ The burst round the button (Figma R.1)

/**
 * The ring and eight dots that burst round the round button when its tap reaches a milestone shown in the row alone
 * (R.1: from 0.30 s, the ring growing 0.7 → 1.45 and fading; the dots flying out 14 dp, each a little later).
 */
fun Modifier.milestoneBurst(t: Float, color: Color): Modifier = drawWithContent {
    drawContent()
    if (t <= 0.115f || t >= 0.35f) return@drawWithContent
    val centre = Offset(size.width / 2, size.height / 2)
    val ra = track(t, Key(0f, 0f), Key(0.115f, 0f, EaseOut), Key(0.131f, 0.55f, EaseOut), Key(0.288f, 0f))
    val rs = track(t, Key(0f, 0.7f), Key(0.115f, 0.7f, EaseOut), Key(0.288f, 1.45f))
    if (ra > 0f) drawCircle(color.copy(alpha = ra), 20.dp.toPx() * rs, centre, style = Stroke(2.dp.toPx()))
    for (i in 0 until 8) {
        val start = 0.115f + 0.0046f * i
        val angle = Math.toRadians(22.5 + 45.0 * i - 180.0)
        val da = track(t, Key(0f, 0f), Key(start, 0f, EaseOut), Key(start + 0.031f, 1f, EaseIn), Key(start + 0.192f, 0f))
        val ds = track(t, Key(0f, 0.6f), Key(start, 0.6f, EaseOut), Key(start + 0.058f, 1f, EaseIn), Key(start + 0.192f, 0.3f))
        val r = track(t, Key(0f, 14f), Key(start, 14f, EaseOut), Key(start + 0.123f, 28f)) * density
        if (da > 0f) drawCircle(color.copy(alpha = da), 2.5f * density * ds,
            Offset(centre.x + (cos(angle) * r).toFloat(), centre.y + (sin(angle) * r).toFloat()))
    }
}

// ------------------------------------------------------------------ A row's milestone today

/**
 * A row's milestone today: its band while the milestone stands (an undo hides it) and no bar is showing it, and the row's
 * own moment, played once (R.1 for a tap shown in the row alone: the burst, the count rolling, the band; the band alone
 * for one reached away, A.1). [t] is the 2.6 s timeline (1 at rest).
 */
class RowMoment(val band: com.oftenenough.app.data.MilestoneShown?, val text: String, val t: Float, val full: Boolean, private val waiting: Boolean = false) {
    /** The count's roll: held at its start while the milestone waits to be shown (a frame or two after the tap). */
    val rolling: Float get() = if (waiting) 0f else if (full) t else 1f
}

@Composable
fun rememberRowMilestone(habit: com.oftenenough.app.data.Habit, isToday: Boolean, rev: Int, store: com.oftenenough.app.data.HabitStore): RowMoment {
    val center = store.milestones
    val shown = if (isToday) center.shown(habit.id) else null
    val visible = remember(rev, shown) { shown?.takeIf { center.stillReached(habit, it) } }
    val band = visible?.takeIf { center.barHabit != habit.id }
    val text = remember(band) { band?.let { center.words(it, habit).band } ?: "" }
    var playing by remember(habit.id) { androidx.compose.runtime.mutableStateOf<com.oftenenough.app.data.MilestoneShown?>(null) }
    val now = playing ?: band?.takeIf { !it.played }
    LaunchedEffect(band?.played, band?.value) {
        if (band != null && !band.played) { playing = band; center.markPlayed(habit.id) }
    }
    val t = rememberPlay(now?.let { "${habit.id}|${it.value}" }, now != null, 2600)
    val full = now != null && now.cause == com.oftenenough.app.data.MilestoneCause.TAP && t < 1f
    val waiting = isToday && shown == null && center.pending.any { it.habitId == habit.id }
    return RowMoment(band, text, if (band == null) 1f else t, full, waiting)
}
