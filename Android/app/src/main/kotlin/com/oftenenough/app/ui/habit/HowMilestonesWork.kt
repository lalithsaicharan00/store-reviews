package com.oftenenough.app.ui.habit

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.components.AppTopBar
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.Symbols

/** One part of the page: its subheader and the card of what it says. */
private class HowPart(val title: String, val lines: List<String>)

/** What every habit with a goal to reach counts (Figma's Screen How milestones work). */
private val reachingParts = listOf(
    HowPart("In a row", listOf(
        "3, 7, 14, 30, 60, 90, 180 and 365 days in a row, then every year.",
        "A weekly goal counts weeks in a row (2, 4, 8, 13, 26, 52); a monthly one, months (2, 3, 6, 9, 12).",
    )),
    HowPart("In total", listOf(
        "10, 25, 50, 100, 250, 500, 1,000 times your goal, and on.",
        "They never fall on the same day as an in-a-row milestone.",
    )),
    HowPart("Anniversaries", listOf("Each year since your first log, if the goal was met in the 30 days before.")),
    HowPart("Which ones get a pop-up", listOf(
        "The big ones: 30, 180 and 365 days in a row (4, 26 and 52 weeks; 6 and 12 months), every anniversary, and your very first milestone.",
        "The rest show as a bar on Today, and as a ribbon in a routine. At most two pop-ups in a week.",
    )),
    HowPart("Quitting and cutting down", listOf("Quit: days clean. Cut down: days within the limit. Skipped and paused days never count against you.")),
)

/** What a quit habit and a limit count (Figma's Screen Quitting and cutting down). */
private val quittingParts = listOf(
    HowPart("Quitting: days clean in a row", listOf(
        "3, 7, 14, 30, 60, 90, 180 and 365 days clean in a row, then every year.",
        "A slip starts the count again. A number you already reached is never given twice.",
    )),
    HowPart("Quitting: clean days in total", listOf(
        "10, 25, 50, 100, 250, 500 and 1,000 clean days, however many slips came between.",
        "A slip never takes a clean day away.",
    )),
    HowPart("Cutting down: days within the limit", listOf(
        "3, 7, 14, 30, 60, 90, 180 and 365 days within the limit in a row; 10, 25, 50, 100 and on in total.",
        "A day counts once it has ended at or under the limit. A weekly limit counts weeks instead (2, 4, 8, 13, 26, 52).",
    )),
    HowPart("Never counted", listOf(
        "What you had is never a milestone: having more is not doing better.",
        "Skipped and paused days don’t break a run, and aren’t added to it.",
    )),
    HowPart("Anniversaries", listOf("Each year since you started, if the 30 days before were clean or within the limit.")),
    HowPart("Which ones get a pop-up", listOf(
        "30 and 180 days, each year, and every anniversary. The rest show as a bar on Today.",
        "Tell me at milestones, on the habit’s form, also sends a notification at 30 days, 180 days, a year and each year after.",
    )),
)

/**
 * 5.6.6, **How milestones work page** (Figma 1142:29063, Screen How milestones work · Quitting and cutting down;
 * Components — Atoms Build Plan), from All milestones' last row. On Surface container: the Top app bar (← "How
 * milestones work"), then the content (16 at the sides, 8 above, 40 under, 8 apart): per part a subheader in Label Large
 * Primary (16 in, 12 above, 4 below) over a card on Surface container lowest (corners 24, 16 inside, 12 between its
 * lines) of Body Medium On surface. A habit to reach shows In a row, In total, Anniversaries, Which ones get a pop-up and
 * Quitting and cutting down; a quit habit or a limit ([quitting]) shows its own.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
internal fun HowMilestonesWorkPage(quitting: Boolean, onBack: () -> Unit) {
    BackHandler(onBack = onBack)
    val s = MaterialTheme.colorScheme
    Column(Modifier.fillMaxSize().background(s.surfaceContainer).semantics { testTag = "how-milestones" }) {
        AppTopBar(
            "How milestones work",
            navigationIcon = { IconButton(onBack, Modifier.semantics { testTag = "how-milestones-back" }) { Icon(Symbols.ArrowBack, "Back") } },
        )
        Column(Modifier.fillMaxWidth().weight(1f).verticalScroll(rememberScrollState()).padding(start = 16.dp, end = 16.dp, top = 8.dp, bottom = 40.dp)
            .navigationBarsPadding(), verticalArrangement = Arrangement.spacedBy(8.dp)) {
            for (part in if (quitting) quittingParts else reachingParts) {
                Text(part.title, Modifier.padding(start = 16.dp, end = 16.dp, top = 12.dp, bottom = 4.dp).semantics { heading() },
                    style = AppType.labelLarge, color = s.primary)
                Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(s.surfaceContainerLowest).padding(16.dp),
                    verticalArrangement = Arrangement.spacedBy(12.dp)) {
                    for (line in part.lines) Text(line, style = AppType.bodyMedium, color = s.onSurface)
                }
            }
        }
    }
}
