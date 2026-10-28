package com.oftenenough.app.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.semantics.clearAndSetSemantics
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HabitMilestones
import com.oftenenough.app.data.MilestoneNext
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors

/**
 * Molecule 4.13, **Milestones card** (Figma 1007:24; Components — Atoms Build Plan): Habit details › Progress. The
 * latest milestone, up to three earlier ones, then the next milestone of each track with its progress.
 *
 * A card (Surface container lowest, 24 corners, 20 in), its parts 12 apart: the header ("Milestones" in Title Medium
 * On surface, a heading; See all N, Material's Small Text button, from two reached; "1 reached" with one); **Latest**
 * on the habit's Fill (20 corners, 16 in): the Medium [Medal] (72), 16, "Latest" in Label Medium On surface variant
 * (from two reached), the milestone in Title Medium and its day in Body Medium On surface variant, 2 apart;
 * **Earlier** (Label Medium) over up to three [MilestoneBadge]s (4.11), each a third of the row, 4 apart, newest first
 * (the rest are in All milestones); **Next** (Label Medium) over each track's [NextMilestone] (4.10), 12 apart. A part
 * with nothing yet isn't shown, as Figma's Show earlier and Show next say.
 */
@Composable
fun MilestonesCard(milestones: HabitMilestones, color: HabitColor, onSeeAll: () -> Unit, modifier: Modifier = Modifier) {
    val s = MaterialTheme.colorScheme
    val c = appColors
    val reached = milestones.reached
    Column(
        modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(s.surfaceContainerLowest).padding(20.dp)
            .semantics { testTag = "habit-milestones" },
        verticalArrangement = Arrangement.spacedBy(12.dp),
    ) {
        Row(Modifier.fillMaxWidth().heightIn(min = 40.dp), horizontalArrangement = Arrangement.spacedBy(8.dp), verticalAlignment = Alignment.CenterVertically) {
            Text("Milestones", Modifier.weight(1f).semantics { heading() }, style = AppType.titleMedium, color = s.onSurface)
            if (reached.size >= 2) {
                AppButton("See all ${reached.size}", onSeeAll, Modifier.semantics { contentDescription = "See all ${reached.size} milestones" },
                    style = ButtonStyle.Text, size = ButtonSize.Small, tag = "habit-milestones-see-all")
            } else if (reached.size == 1) {
                Text("1 reached", style = AppType.bodyMedium, color = s.onSurfaceVariant)
            }
        }
        reached.firstOrNull()?.let { latest ->
            Row(
                Modifier.fillMaxWidth().clip(RoundedCornerShape(20.dp)).background(c.habitFill(color)).padding(16.dp)
                    .clearAndSetSemantics {
                        contentDescription = (if (reached.size > 1) "Latest: " else "") + latest.spoken
                        testTag = "habit-milestone-latest"
                    },
                horizontalArrangement = Arrangement.spacedBy(16.dp),
                verticalAlignment = Alignment.CenterVertically,
            ) {
                Medal(latest.number, 72.dp, color)
                Column(Modifier.weight(1f), verticalArrangement = Arrangement.spacedBy(2.dp)) {
                    if (reached.size > 1) Text("Latest", style = AppType.labelMedium, color = s.onSurfaceVariant)
                    Text(latest.title, style = AppType.titleMedium, color = s.onSurface)
                    Text(latest.reachedText, style = AppType.bodyMedium, color = s.onSurfaceVariant)
                }
            }
        }
        if (reached.size > 1) {
            Text("Earlier", style = AppType.labelMedium, color = s.onSurfaceVariant)
            Row(Modifier.fillMaxWidth().semantics { testTag = "habit-milestone-shelf" }, horizontalArrangement = Arrangement.spacedBy(4.dp)) {
                val earlier = reached.drop(1).take(3)
                for (m in earlier) MilestoneBadge(m.number, m.shelfTop, m.shelfBottom, color, m.spoken, Modifier.weight(1f))
                repeat(3 - earlier.size) { Spacer(Modifier.weight(1f)) }
            }
        }
        if (milestones.next.isNotEmpty()) {
            Text("Next", style = AppType.labelMedium, color = s.onSurfaceVariant)
            for (next in milestones.next) NextMilestone(next, color)
        }
    }
}

/**
 * A track's [NextMilestone] from the habit page's words: "7 to go · now 23", or on All milestones ([onPage])
 * "Next · 7 to go · now 23"; read by TalkBack as its one spoken line.
 */
@Composable
fun NextMilestone(next: MilestoneNext, color: HabitColor, onPage: Boolean = false, modifier: Modifier = Modifier) =
    NextMilestone(next.number.takeIf { next.target != null }, next.title,
        next.detail?.let { if (onPage && next.target != null) "Next · $it" else it }, next.fraction.toFloat(), color,
        modifier.clearAndSetSemantics { contentDescription = next.spoken; testTag = "habit-milestone-next-" + next.track.key })
