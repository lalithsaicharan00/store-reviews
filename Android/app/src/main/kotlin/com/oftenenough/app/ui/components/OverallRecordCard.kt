package com.oftenenough.app.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.ExperimentalLayoutApi
import androidx.compose.foundation.layout.FlowRow
import androidx.compose.foundation.layout.IntrinsicSize
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.semantics.clearAndSetSemantics
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.theme.AppType

/**
 * Molecule 4.16, **Overall record card** (Figma 1158:119643; Components — Atoms Build Plan): Habit details ›
 * Progress, the first card. Everything ever recorded, then the Stat tiles (4.14), then See all streaks.
 *
 * Surface container lowest, corners 24, 20 in, 12 apart: the header ("Overall record" in Title Medium On surface, a
 * heading, and [since] in Body Medium On surface variant, 8 apart; one over the other, 4 apart, from 150 % text, as
 * Figma's 200 %); the [total] ([OverallRecordTotal]); the [tiles], two a row, 8 apart and each as tall as its
 * neighbour (one a row from 150 % text); anything [more] (a quit habit's money saved); [seeAll] ("See all streaks",
 * Material's Small Text button) at the end.
 */
@Composable
fun OverallRecordCard(
    since: String, seeAll: String?, onSeeAll: () -> Unit, modifier: Modifier = Modifier, seeAllTag: String? = null,
    total: @Composable () -> Unit, tiles: List<@Composable (Modifier) -> Unit>, more: @Composable ColumnScope.() -> Unit = {},
) {
    val s = MaterialTheme.colorScheme
    val large = LocalDensity.current.fontScale >= 1.5f
    Column(
        modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(s.surfaceContainerLowest).padding(20.dp),
        verticalArrangement = Arrangement.spacedBy(12.dp),
    ) {
        if (large) {
            Column(Modifier.fillMaxWidth().semantics(mergeDescendants = true) { heading() }, verticalArrangement = Arrangement.spacedBy(4.dp)) {
                Text("Overall record", style = AppType.titleMedium, color = s.onSurface)
                Text(since, style = AppType.bodyMedium, color = s.onSurfaceVariant)
            }
        } else {
            Row(Modifier.fillMaxWidth().semantics(mergeDescendants = true) { heading() }, horizontalArrangement = Arrangement.spacedBy(8.dp),
                verticalAlignment = Alignment.CenterVertically) {
                Text("Overall record", Modifier.weight(1f), style = AppType.titleMedium, color = s.onSurface)
                Text(since, style = AppType.bodyMedium, color = s.onSurfaceVariant, maxLines = 1)
            }
        }
        total()
        if (tiles.isNotEmpty()) {
            Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                for (row in tiles.chunked(if (large) 1 else 2)) {
                    Row(Modifier.fillMaxWidth().height(IntrinsicSize.Min), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                        for (tile in row) tile(Modifier.weight(1f).fillMaxHeight())
                        if (!large && row.size == 1) Spacer(Modifier.weight(1f))
                    }
                }
            }
        }
        more()
        if (seeAll != null) Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.End) {
            AppButton(seeAll, onSeeAll, style = ButtonStyle.Text, size = ButtonSize.Small, tag = seeAllTag)
        }
    }
}

/**
 * The card's total: the [number] ("392") in Headline Large Emphasized On surface and the [unit] ("glasses recorded")
 * in Body Large On surface variant, 8 apart on one baseline, wrapping; a [lead] ("Done on") before the number in the
 * unit's style. TalkBack reads [spoken].
 */
@OptIn(ExperimentalLayoutApi::class)
@Composable
fun OverallRecordTotal(lead: String, number: String, unit: String, spoken: String, modifier: Modifier = Modifier) {
    val s = MaterialTheme.colorScheme
    FlowRow(modifier.clearAndSetSemantics { contentDescription = spoken }, horizontalArrangement = Arrangement.spacedBy(8.dp)) {
        if (lead.isNotEmpty()) Text(lead, Modifier.alignByBaseline(), style = AppType.bodyLarge, color = s.onSurfaceVariant)
        Text(number, Modifier.alignByBaseline(), style = AppType.headlineLargeEmphasized, color = s.onSurface)
        if (unit.isNotEmpty()) Text(unit, Modifier.alignByBaseline(), style = AppType.bodyLarge, color = s.onSurfaceVariant)
    }
}
