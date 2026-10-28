package com.oftenenough.app.ui.components

import androidx.compose.animation.animateColorAsState
import androidx.compose.animation.core.tween
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.combinedClickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.drawBehind
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Shape
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.StreakUnit
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors

/**
 * Molecule 4.1, **Habit row** (Figma 571:277; Components — Atoms Build Plan): one habit on Today, every kind (a check,
 * an amount, a timer, a checklist, a task, a cut-down, a quit). What changes between them is the line under the name,
 * the action and the state; Today ([com.oftenenough.app.ui.today.HabitRow]) works those out and this draws them.
 *
 * Surface bright (the theme's Surface), square: the section it sits in gives it its corners through [shape] (24 on
 * the group's outside, 4 inside, 2 apart). The body is 16 before, 12 after and 14 above and below; in it, the habit's
 * 40 dp [HabitIcon], 16, the [name] in Title Medium (two lines at most, the row grows) over the [line], 16, then the
 * trailing group, 20 apart: the [streak] ([HabitRowStreak]) and one of:
 *
 * - **[action]**: the round button, a 40 dp [AppFilledIconButton] (✓ + ▶ ⏸ ⌄ ⌃), Neutral until the goal is met, Done
 *   after. Its 48 dp touch target reaches 4 past the circle, so the room around it is 4 less and the circle sits
 *   where Figma draws it.
 * - **[trailing]**: anything else at the end (Show log button: a tonal Small "Log" for an amount typed each time; Show
 *   run: a quit's live count in Title Medium; a later day's Done today).
 *
 * Under the body, 12 below, [below]: Undo · Note right after a log ([HabitRowAfterLogButton]s), lined up with the
 * name (56 in). Under everything, edge to edge, [band]: a milestone's band.
 *
 * Behind everything, the progress fill: [progress] (0–1, read only when drawn, so a running timer redraws the fill
 * and not the row, Rulebook S3) in the habit's Fill, so two habits at the same progress read equally far along; a
 * cut-down or quit row passes nothing (A41: a limit never fills). Over it, [pressed] lays Material's pressed state, On
 * surface at 10 %, for the moment the row is held for its menu; [lit] flashes the same, softer, for a row Today points
 * to. Tap for [onClick], touch and hold for [onLongClick]; [menu] is that menu, anchored under the body (above the band).
 */
@OptIn(ExperimentalFoundationApi::class)
@Composable
fun HabitRowLayout(
    symbol: String,
    color: HabitColor,
    name: String,
    shape: Shape,
    onClick: () -> Unit,
    onLongClick: () -> Unit,
    modifier: Modifier = Modifier,
    progress: (() -> Float)? = null,
    pressed: Boolean = false,
    lit: Boolean = false,
    line: @Composable () -> Unit,
    streak: (@Composable () -> Unit)? = null,
    action: (@Composable () -> Unit)? = null,
    trailing: (@Composable () -> Unit)? = null,
    below: (@Composable () -> Unit)? = null,
    band: (@Composable ColumnScope.() -> Unit)? = null,
    menu: (@Composable () -> Unit)? = null,
) {
    val c = appColors
    val s = MaterialTheme.colorScheme
    val fill = c.habitFill(color)
    val held by animateColorAsState(if (pressed) s.onSurface.copy(alpha = 0.10f) else Color.Transparent, tween(150), label = "held")
    val flash by animateColorAsState(if (lit) s.onSurface.copy(alpha = 0.08f) else Color.Transparent, tween(600), label = "lit")
    Column(
        modifier.fillMaxWidth().clip(shape).background(s.surface)
            .drawBehind {
                val p = progress?.invoke()?.coerceIn(0f, 1f) ?: 0f
                if (p > 0f) drawRect(fill, size = size.copy(width = size.width * p))
                if (flash.alpha > 0f) drawRect(flash)
                if (held.alpha > 0f) drawRect(held)
            }
            .combinedClickable(onClick = onClick, onLongClick = onLongClick),
    ) {
        Column(Modifier.padding(start = 16.dp, end = if (action != null) 8.dp else 12.dp, top = 14.dp, bottom = 14.dp)) {
            Row(Modifier.heightIn(min = 44.dp), verticalAlignment = Alignment.CenterVertically) {
                HabitIcon(symbol, color)
                Spacer(Modifier.width(16.dp))
                Column(Modifier.weight(1f)) {
                    Text(name, style = AppType.titleMedium, color = s.onSurface, maxLines = 2, overflow = TextOverflow.Ellipsis)
                    line()
                }
                val end = action ?: trailing
                if (streak != null) {
                    Spacer(Modifier.width(16.dp))
                    streak()
                    if (end != null) Spacer(Modifier.width(if (action != null) 16.dp else 20.dp))
                } else if (end != null) Spacer(Modifier.width(if (action != null) 12.dp else 16.dp))
                end?.invoke()
            }
            if (below != null) {
                Spacer(Modifier.height(12.dp))
                Box(Modifier.padding(start = 56.dp, end = 4.dp)) { below() }
            }
            menu?.invoke()
        }
        band?.invoke(this)
    }
}

/** The line under a row's name: Body Medium in On surface variant, one line ("4/10 min", "Every day · 8:00 AM"). */
@Composable
fun HabitRowLine(text: String, modifier: Modifier = Modifier, numbers: Boolean = false) =
    Text(text, modifier, style = if (numbers) AppType.bodyMedium.copy(fontFeatureSettings = "tnum") else AppType.bodyMedium,
        color = MaterialTheme.colorScheme.onSurfaceVariant, maxLines = 1, overflow = TextOverflow.Ellipsis)

/**
 * "🔥 58", "🔥 4 wk": the emoji in Body Small, 2 from the count in Label Large, both On surface (the iPhone's rule, the
 * user, 13 Oct 2026). TalkBack reads it in words. [roll] < 1 plays a milestone's roll: the old count slips up and out,
 * the new one pops in (Figma R.1).
 */
@Composable
fun HabitRowStreak(count: Int, unit: StreakUnit, roll: Float = 1f) {
    val ink = MaterialTheme.colorScheme.onSurface
    Row(verticalAlignment = Alignment.CenterVertically, modifier = Modifier.semantics(mergeDescendants = true) { contentDescription = unit.explained(count) }) {
        Text("🔥", style = AppType.bodySmall, color = ink)
        Spacer(Modifier.width(2.dp))
        if (roll >= 0.24f || count < 1) Text(unit.short(count), style = AppType.labelLarge, color = ink, maxLines = 1)
        else {
            val density = androidx.compose.ui.platform.LocalDensity.current.density
            val ease = androidx.compose.animation.core.CubicBezierEasing(0.3f, 0f, 0.8f, 0.15f)
            val pop = androidx.compose.animation.core.CubicBezierEasing(0.45f, 1.45f, 0.8f, 1f)
            val oldA = com.oftenenough.app.ui.day.track(roll, com.oftenenough.app.ui.day.Key(0f, 1f), com.oftenenough.app.ui.day.Key(0.131f, 1f, ease), com.oftenenough.app.ui.day.Key(0.169f, 0f))
            val oldY = com.oftenenough.app.ui.day.track(roll, com.oftenenough.app.ui.day.Key(0f, 0f), com.oftenenough.app.ui.day.Key(0.131f, 0f, ease), com.oftenenough.app.ui.day.Key(0.169f, -10f))
            val newA = com.oftenenough.app.ui.day.track(roll, com.oftenenough.app.ui.day.Key(0f, 0f), com.oftenenough.app.ui.day.Key(0.169f, 0f), com.oftenenough.app.ui.day.Key(0.208f, 1f))
            val newY = com.oftenenough.app.ui.day.track(roll, com.oftenenough.app.ui.day.Key(0f, 10f), com.oftenenough.app.ui.day.Key(0.169f, 10f, pop), com.oftenenough.app.ui.day.Key(0.231f, 0f))
            Box {
                Text(unit.short(count - 1), Modifier.graphicsLayer { alpha = oldA; translationY = oldY * density }, style = AppType.labelLarge, color = ink, maxLines = 1)
                Text(unit.short(count), Modifier.graphicsLayer { alpha = newA; translationY = newY * density }, style = AppType.labelLarge, color = ink, maxLines = 1)
            }
        }
    }
}

/**
 * Undo or Note under a row just logged (Figma's After-log buttons, 8 apart): 36 dp, corners 16, the row's Surface
 * with a 1 dp Outline variant edge, an 18 dp icon 6 from the label in Label Large, all On surface, 12 before and 16
 * after.
 */
@Composable
fun HabitRowAfterLogButton(text: String, icon: ImageVector, onClick: () -> Unit, modifier: Modifier = Modifier) {
    val s = MaterialTheme.colorScheme
    val shape = RoundedCornerShape(16.dp)
    Row(
        modifier.heightIn(min = 36.dp).clip(shape).background(s.surface)
            .border(1.dp, s.outlineVariant, shape).clickable(role = Role.Button, onClick = onClick)
            .padding(start = 12.dp, end = 16.dp, top = 6.dp, bottom = 6.dp),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Icon(icon, null, Modifier.size(18.dp), tint = s.onSurface)
        Spacer(Modifier.width(6.dp))
        Text(text, style = AppType.labelLarge, color = s.onSurface, maxLines = 1, overflow = TextOverflow.Ellipsis)
    }
}
