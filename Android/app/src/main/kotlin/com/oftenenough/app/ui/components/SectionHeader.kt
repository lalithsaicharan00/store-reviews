package com.oftenenough.app.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ExperimentalLayoutApi
import androidx.compose.foundation.layout.FlowRow
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.ExperimentalMaterial3ExpressiveApi
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Shape
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.HabitIcons
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.theme.appColors

/** A habit in a folded section's row of discs: its name (for TalkBack), its filled icon and its Colour. */
data class SectionHabit(val name: String, val symbol: String, val color: HabitColor)

/**
 * Molecule 4.4, **Section header** (Figma 562:48; Components — Atoms Build Plan): the first piece of a time of day on
 * Today (Morning, Afternoon, Evening, Anytime, Quitting, Paused), by State (Open, Closed) and Text size (Default, 200%).
 * Tapping anywhere on it opens or folds the section ([onToggle]).
 *
 * Surface bright, the section's corners through [shape] (open, 24 over 4: the rows follow 2 below; closed, it's the
 * whole card, 24 all round). 64 tall: 16 at the start, 12 between its parts, 8 at the end (the chevron carries its own
 * box). In order:
 *
 * - The [name] in Title Medium, On surface, over the [time] ("Starts 6 AM", "Stop, or do less") in Body Small, On
 *   surface variant. They take the room that's left.
 * - Closed: the [habits] in it, 28 dp discs of each habit's Colour with its filled icon (16, On habit), ringed 2 dp in
 *   Surface bright and overlapping by 6; past three, a "+N" disc of Surface container highest in Label Medium.
 * - The [count] ("2 left", "Done", "3 planned"): a neutral pill, 24 tall, corners 12, 10 at the sides, Label Medium On
 *   surface on Surface container highest. Not Material's `Badge` (that's the red error dot).
 * - Open: Start ([onStart]), Material's extra-small button: 32 tall, round, Primary with On primary, the filled play
 *   arrow (20), 8, "Start" in Label Large.
 * - ⌃ / ⌄: Material's small standard icon button (40, a 24 glyph, On surface variant). Its 48 dp touch target reaches 4
 *   past the 40, so the room around it is 4 less and the glyph sits where Figma draws it.
 *
 * **Large text** (Figma's 200%; from Android's font scale 1.5): the name and ⌃ / ⌄ on the first line, the name wrapping
 * to two lines; under it, 8 down, the time, the discs, the count and Start, 12 apart, wrapping 8 apart.
 *
 * No milestone shows on a folded section (A43). Nothing here moves (Figma has no motion for it).
 */
@Composable
fun SectionHeader(
    name: String,
    time: String?,
    open: Boolean,
    shape: Shape,
    onToggle: () -> Unit,
    modifier: Modifier = Modifier,
    count: String? = null,
    habits: List<SectionHabit> = emptyList(),
    onStart: (() -> Unit)? = null,
    tag: String? = null,
) {
    val s = MaterialTheme.colorScheme
    val large = LocalDensity.current.fontScale >= 1.5f
    val action = if (open) "Fold $name" else "Open $name"
    val box = modifier.fillMaxWidth().clip(shape).background(s.surface).clickable(onClickLabel = action, onClick = onToggle)
        .semantics { if (tag != null) testTag = tag }
    val discs = !open && habits.isNotEmpty()
    val start = open && onStart != null
    val chevron = @Composable { StandardIconButton(if (open) Symbols.ExpandLess else Symbols.ExpandMore, action, onToggle) }
    if (!large) {
        Row(box.heightIn(min = 64.dp).padding(start = 16.dp, end = 4.dp, top = 8.dp, bottom = 8.dp), verticalAlignment = Alignment.CenterVertically) {
            Column(Modifier.weight(1f)) {
                Text(name, style = AppType.titleMedium, color = s.onSurface, maxLines = 1, overflow = TextOverflow.Ellipsis)
                if (time != null) Text(time, style = AppType.bodySmall, color = s.onSurfaceVariant, maxLines = 1, overflow = TextOverflow.Ellipsis)
            }
            if (discs) { Spacer(Modifier.width(12.dp)); SectionDiscs(habits) }
            if (count != null) { Spacer(Modifier.width(12.dp)); SectionCount(count) }
            if (start) { Spacer(Modifier.width(12.dp)); StartButton(name, onStart) }
            Spacer(Modifier.width(8.dp))
            chevron()
        }
    } else {
        Column(box.padding(start = 16.dp, end = 4.dp, top = 8.dp, bottom = 12.dp)) {
            Row(verticalAlignment = Alignment.CenterVertically) {
                Text(name, Modifier.weight(1f), style = AppType.titleMedium, color = s.onSurface, maxLines = 2, overflow = TextOverflow.Ellipsis)
                Spacer(Modifier.width(4.dp))
                chevron()
            }
            if (time != null || discs || count != null || start) {
                Spacer(Modifier.height(4.dp))
                SecondLine(Modifier.padding(end = 4.dp)) {
                    if (time != null) Text(time, Modifier.align(Alignment.CenterVertically), style = AppType.bodySmall, color = s.onSurfaceVariant)
                    if (discs) SectionDiscs(habits, Modifier.align(Alignment.CenterVertically))
                    if (count != null) SectionCount(count, Modifier.align(Alignment.CenterVertically))
                    if (start) StartButton(name, onStart, Modifier.align(Alignment.CenterVertically))
                }
            }
        }
    }
}

/** The large-text second line: its parts 12 apart, wrapping to further lines 8 apart. */
@OptIn(ExperimentalLayoutApi::class)
@Composable
private fun SecondLine(modifier: Modifier, content: @Composable androidx.compose.foundation.layout.FlowRowScope.() -> Unit) =
    FlowRow(modifier, horizontalArrangement = Arrangement.spacedBy(12.dp), verticalArrangement = Arrangement.spacedBy(8.dp), content = content)

/** The neutral count pill: "2 left", "Done", "3 planned". */
@Composable
private fun SectionCount(text: String, modifier: Modifier = Modifier) {
    val s = MaterialTheme.colorScheme
    Box(modifier.heightIn(min = 24.dp).clip(RoundedCornerShape(12.dp)).background(s.surfaceContainerHighest).padding(horizontal = 10.dp, vertical = 4.dp),
        contentAlignment = Alignment.Center) {
        Text(text, style = AppType.labelMedium, color = s.onSurface, maxLines = 1)
    }
}

/**
 * Start: Material's extra-small button (`ButtonDefaults.ExtraSmallContainerHeight`, its round shape that squares up
 * while pressed, its 20 dp icon). Its sides and icon gap are Material's tokens (ButtonXSmallTokens: 16 and 8), which
 * Figma draws; Compose 1.5 still gives 12 and 4 there, marked in its own code to be corrected to the tokens. The set
 * height keeps Material's 40 dp default minimum from applying (as Material's own extra-small samples do); its touch
 * target is still 48.
 */
@OptIn(ExperimentalMaterial3ExpressiveApi::class)
@Composable
private fun StartButton(name: String, onStart: () -> Unit, modifier: Modifier = Modifier) {
    val height = ButtonDefaults.ExtraSmallContainerHeight
    Button(
        onStart, ButtonDefaults.shapesFor(height),
        modifier.heightIn(min = height).semantics { contentDescription = "Start $name"; testTag = "start-$name" },
        contentPadding = PaddingValues(horizontal = 16.dp, vertical = 6.dp),
    ) {
        Icon(Symbols.Filled.PlayArrow, null, Modifier.size(ButtonDefaults.iconSizeFor(height)))
        Spacer(Modifier.width(8.dp))
        Text("Start", style = AppType.labelLarge, maxLines = 1)
    }
}

/**
 * A folded section's habits: three discs at most, then "+N". Each ring is Surface bright painted behind a 24 dp disc,
 * never a stroke over it (a stroke leaves a fringe of the colour). The "+N" grows into a pill with large text.
 */
@Composable
private fun SectionDiscs(habits: List<SectionHabit>, modifier: Modifier = Modifier) {
    val ring = MaterialTheme.colorScheme.surface
    val c = appColors
    val shown = habits.take(3)
    val more = habits.size - shown.size
    Row(
        modifier.semantics(mergeDescendants = true) { contentDescription = habits.joinToString(", ") { it.name } },
        horizontalArrangement = Arrangement.spacedBy((-6).dp), verticalAlignment = Alignment.CenterVertically,
    ) {
        shown.forEach { h ->
            Box(Modifier.size(28.dp).clip(CircleShape).background(ring).padding(2.dp).clip(CircleShape).background(c.habit(h.color)),
                contentAlignment = Alignment.Center) {
                Icon(HabitIcons.icon(h.symbol), null, Modifier.size(16.dp), tint = Color.White)
            }
        }
        if (more > 0) {
            Box(Modifier.heightIn(min = 28.dp).widthIn(min = 28.dp).clip(CircleShape).background(ring).padding(2.dp).clip(CircleShape)
                .background(MaterialTheme.colorScheme.surfaceContainerHighest).padding(horizontal = 4.dp),
                contentAlignment = Alignment.Center) {
                Text("+$more", style = AppType.labelMedium, color = MaterialTheme.colorScheme.onSurface, maxLines = 1, softWrap = false)
            }
        }
    }
}
