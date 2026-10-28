package com.oftenenough.app.ui.components

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.BoxScope
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.size
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.ExperimentalMaterial3ExpressiveApi
import androidx.compose.material3.LinearWavyProgressIndicator
import androidx.compose.material3.Text
import androidx.compose.ui.Alignment
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp

/**
 * Atom 1.20, **Linear progress, wavy** (Figma 902:14527, Style=Wavy; Components — Atoms Build Plan): Material 3
 * Expressive's own `LinearWavyProgressIndicator` as it is (Material 1.5, Android A76): its 10 dp height, 4 dp wave,
 * gap, track and stop dot, and its own way of flattening the wave near 0 and 100. Material's colours by default
 * (Primary on Secondary container, as in the notice card); a habit's own progress passes its colour and Fill
 * (`c.habit`, `c.habitFill`).
 *
 * The flat style (Style=Flat: where a routine is, a count) is Material's own `LinearProgressIndicator` as it is,
 * with no wrapper: 4 dp, Primary on Secondary container, the same 4 dp gap and stop dot.
 */
@OptIn(ExperimentalMaterial3ExpressiveApi::class)
@Composable
fun WavyProgress(
    progress: Float,
    modifier: Modifier = Modifier,
    color: Color = MaterialTheme.colorScheme.primary,
    trackColor: Color = MaterialTheme.colorScheme.secondaryContainer,
) = LinearWavyProgressIndicator(progress = { progress.coerceIn(0f, 1f) }, modifier = modifier.fillMaxWidth(), color = color, trackColor = trackColor)

/**
 * Atom 1.21, **Circular progress** (Figma 1007:5): Material's own determinate `CircularProgressIndicator` with its own
 * band (4 dp), round ends and 4 dp gap, 52 dp across, filling clockwise from the top. The one thing set is its colours:
 * the [habit]'s Colour on its Band (`c.habit`, `c.habitBand`). [content] sits in the middle: a [CircularProgressLabel]
 * or an icon. For a track's next milestone: the habit page's Progress, All milestones and the milestone pop-up.
 */
@Composable
fun AppCircularProgress(progress: Float, habit: HabitColor, modifier: Modifier = Modifier, content: @Composable BoxScope.() -> Unit = {}) {
    val c = appColors
    Box(modifier.size(52.dp), contentAlignment = Alignment.Center) {
        CircularProgressIndicator({ progress.coerceIn(0f, 1f) }, Modifier.fillMaxSize(), color = c.habit(habit), trackColor = c.habitBand(habit))
        content()
    }
}

/** The number in a [AppCircularProgress]: Title Medium On surface; three digits or more, Label Large (Figma 1007:5). */
@Composable
fun CircularProgressLabel(text: String) =
    Text(text, style = if (text.length >= 3) AppType.labelLarge else AppType.titleMedium, color = appColors.ink, maxLines = 1)
