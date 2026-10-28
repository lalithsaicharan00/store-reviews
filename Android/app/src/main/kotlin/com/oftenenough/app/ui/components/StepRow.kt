package com.oftenenough.app.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.selection.toggleable
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.RectangleShape
import androidx.compose.ui.graphics.Shape
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.stateDescription
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.theme.AppType

/**
 * Where a [StepRow] sits. Figma uses the one Step row in three places, each with its own room around it:
 *
 * - **[Today]**: under its checklist's row, 48 tall, 56 in so the box lines up under the habit's name, 12 at the end,
 *   Surface bright. The rows stack with no gap in a [StepRowBlock].
 * - **[Card]**: Day details' This day card, 48 tall, nothing at the start (the card's own 16 is the indent), 12 at the
 *   end, Surface bright (Figma keeps the row's own fill on the white card).
 * - **[Player]**: the routine player, where the steps are the work: each a segment of its own, 56 tall, 8 in, 16 at the
 *   end, Surface container lowest, 2 apart with the group's corners (24 outside, 4 between).
 */
enum class StepRowPlace(internal val start: Dp, internal val end: Dp, internal val height: Dp) {
    Today(56.dp, 12.dp, 48.dp),
    Card(0.dp, 12.dp, 48.dp),
    Player(8.dp, 16.dp, 56.dp),
}

/**
 * Molecule 4.3, **Step row** (Figma 575:136; Components — Atoms Build Plan): one step of a checklist habit, by State
 * (To do, Done). The step's own piece, never part of the habit's row: the only colour in it is the ticked box.
 *
 * Material's [AppCheckbox] in a 40 dp frame (an 18 dp box with 2 corners; not ticked, a 2 dp On surface variant
 * outline; ticked, the habit's Colour with a white check), 8, then the [name] in Body Large: On surface while it's to
 * do, **On surface variant once ticked, never crossed out**. The whole row is the toggle (a checkbox to TalkBack, read
 * "Done" or "Not done"), so it's the touch target, not just the box. Switched off ([enabled] false: a later day, a
 * paused or skipped one), the box and the words take Material's disabled colour, On surface at 38 %.
 *
 * [place] sets the room around it ([StepRowPlace]); [shape] is the segment's shape in the player.
 */
@Composable
fun StepRow(
    name: String,
    done: Boolean,
    habitColor: Color,
    onToggle: () -> Unit,
    modifier: Modifier = Modifier,
    place: StepRowPlace = StepRowPlace.Today,
    enabled: Boolean = true,
    shape: Shape = RectangleShape,
    tag: String? = null,
) {
    val s = MaterialTheme.colorScheme
    val fill = if (place == StepRowPlace.Player) s.surfaceContainerLowest else s.surface
    val words = when {
        !enabled -> s.onSurface.copy(alpha = 0.38f)
        done -> s.onSurfaceVariant
        else -> s.onSurface
    }
    Row(
        modifier.fillMaxWidth().heightIn(min = place.height).clip(shape).background(fill)
            .toggleable(value = done, enabled = enabled, role = Role.Checkbox, onValueChange = { onToggle() })
            .semantics {
                stateDescription = if (done) "Done" else "Not done"
                if (tag != null) testTag = tag
            }
            .padding(start = place.start, end = place.end),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Box(Modifier.size(40.dp), contentAlignment = Alignment.Center) {
            AppCheckbox(done, onCheckedChange = null, enabled = enabled, habitColor = habitColor)
        }
        Spacer(Modifier.width(8.dp))
        Text(name, Modifier.weight(1f), style = AppType.bodyLarge, color = words, maxLines = 2, overflow = TextOverflow.Ellipsis)
    }
}

/**
 * Today's block of a checklist's steps, open under its row: Surface bright, the section's corners through [shape] (4
 * under the row above, 24 when it ends the section), 8 above and below, its [StepRow]s stacked with no gap.
 */
@Composable
fun StepRowBlock(shape: Shape, modifier: Modifier = Modifier, content: @Composable ColumnScope.() -> Unit) {
    Column(modifier.fillMaxWidth().clip(shape).background(MaterialTheme.colorScheme.surface).padding(vertical = 8.dp), content = content)
}
