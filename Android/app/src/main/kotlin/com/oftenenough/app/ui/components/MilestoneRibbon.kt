package com.oftenenough.app.ui.components

import androidx.compose.animation.core.Animatable
import androidx.compose.animation.core.LinearEasing
import androidx.compose.animation.core.tween
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.ExperimentalMaterial3ExpressiveApi
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
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
import androidx.compose.ui.graphics.drawscope.rotate
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch

/** The ribbon's own timeline, from the moment its entrance starts (Figma's 2 s player frame, from 460 ms). */
private const val RIBBON_MS = 1020f
private fun at(ms: Int) = ms / RIBBON_MS

/**
 * Molecule 4.9, **Milestone ribbon** (Figma 902:16439; Components — Atoms Build Plan): a milestone in the routine
 * player, across the top of the habit's card, the same job as a row's band and the bar on Today (A53).
 *
 * 40 tall, the full width, the habit's **Band**; centred in it, 16 at the sides, a 16 dp [Medal], 8, the milestone's
 * [text] in Label Large in the habit's **Deep** (one line, A42: the milestone only).
 *
 * **Inner motion** ([play]: the moment it's reached; at rest otherwise, and with Remove animations): the medal spins in
 * from 35° and pops (0.01 → 1.3 → 1), the words slide in 8 dp and fade up, then a sheen (48 × 80, tilted 20°, white at
 * 50 % in its middle) passes once. Read only where it's drawn, so a moving ribbon never recomposes (S3, S6). Its
 * entrance (10 dp up and fading in) is the screen's.
 */
@Composable
fun MilestoneRibbon(text: String, color: HabitColor, play: Boolean, modifier: Modifier = Modifier, tag: String = "day-ribbon") {
    val c = appColors
    // Figma draws light only: Deep on the Band. In dark the Band is the colour at 28 % on the card, where Deep doesn't
    // read, so the words take the colour's light shade there.
    val ink = if (c.dark) Color.White.copy(alpha = 0.72f).compositeOver(c.habit(color)) else c.habitDeep(color)
    val on = animationsOn()
    val t = remember { Animatable(if (play && on) 0f else 1f) }
    // Plays once, when [play] turns on (Day details claims the milestone a moment after it shows).
    var played by remember { mutableStateOf(false) }
    LaunchedEffect(play) {
        if (!play || !on || played) return@LaunchedEffect
        played = true
        t.snapTo(0f)
        t.animateTo(1f, tween(RIBBON_MS.toInt(), easing = LinearEasing))
    }
    Row(
        modifier.fillMaxWidth().heightIn(min = 40.dp).background(c.habitBand(color))
            .drawWithContent {
                drawContent()
                val now = t.value
                if (now > at(420) && now < at(1020)) {
                    val dx = track(now, Key(at(420), 0f, EaseInOut), Key(at(1020), 520f)).dp.toPx()
                    val w = 48.dp.toPx()
                    val h = 80.dp.toPx()
                    val centre = Offset(-96.dp.toPx() + dx, size.height / 2)
                    rotate(20f, centre) {
                        drawRect(Brush.horizontalGradient(listOf(Color.Transparent, Color.White.copy(alpha = 0.5f), Color.Transparent),
                            startX = centre.x - w / 2, endX = centre.x + w / 2), topLeft = Offset(centre.x - w / 2, centre.y - h / 2), size = Size(w, h))
                    }
                }
            }
            .padding(horizontal = 16.dp)
            .semantics(mergeDescendants = true) { testTag = tag },
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.spacedBy(8.dp, Alignment.CenterHorizontally),
    ) {
        Medal(null, 16.dp, color, Modifier.graphicsLayer {
            val now = t.value
            rotationZ = track(now, Key(at(120), 35f, EaseOut), Key(at(440), 0f))
            val k = track(now, Key(at(120), 0.01f, EaseOut), Key(at(300), 1.3f, EaseInOut), Key(at(440), 1f))
            scaleX = k; scaleY = k
        })
        Text(text, Modifier.graphicsLayer {
            val now = t.value
            translationX = track(now, Key(at(180), -8f, Arrive), Key(at(400), 0f)) * density
            alpha = track(now, Key(at(180), 0f, Arrive), Key(at(400), 1f))
        }, style = AppType.labelLarge, color = ink, maxLines = 1, overflow = TextOverflow.Ellipsis)
    }
}

/**
 * The ribbon's entrance, for the screens that show it (Figma's player frame: 10 dp up and fading in as it's reached):
 * Material's fast spatial and effects springs, once, when [play] turns on; at rest otherwise and with Remove animations.
 * It's the screen's motion, kept in one place because the routine player and Day details play it alike.
 */
@OptIn(ExperimentalMaterial3ExpressiveApi::class)
@Composable
fun MilestoneRibbonArrival(play: Boolean, content: @Composable () -> Unit) {
    val on = animationsOn()
    val motion = MaterialTheme.motionScheme
    val rise = remember { Animatable(if (play && on) 1f else 0f) }
    val fade = remember { Animatable(if (play && on) 0f else 1f) }
    var played by remember { mutableStateOf(false) }
    LaunchedEffect(play) {
        if (!play || !on || played) return@LaunchedEffect
        played = true
        rise.snapTo(1f)
        fade.snapTo(0f)
        launch { fade.animateTo(1f, motion.fastEffectsSpec()) }
        rise.animateTo(0f, motion.fastSpatialSpec())
    }
    Box(Modifier.graphicsLayer { translationY = rise.value * 10.dp.toPx(); alpha = fade.value }) { content() }
}
