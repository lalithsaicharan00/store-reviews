package com.oftenenough.app.ui.components

import androidx.compose.foundation.layout.size
import androidx.compose.material3.ContainedLoadingIndicator
import androidx.compose.material3.ExperimentalMaterial3ExpressiveApi
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

/**
 * Material 3 Expressive's own `ContainedLoadingIndicator` (Material 1.5, Android A76; Figma Plus & Account 3.2, 4,
 * 2.1.1): its seven shapes morphing in a round container, its timing, and holding still with animations off. Set: the
 * design's colours ([container] Secondary container, [indicator] ink, where Material's are Primary container and
 * Primary) and the design's 64 dp size.
 */
@OptIn(ExperimentalMaterial3ExpressiveApi::class)
@Composable
fun ExpressiveLoadingIndicator(container: Color, indicator: Color, modifier: Modifier = Modifier, size: Dp = 64.dp) =
    ContainedLoadingIndicator(modifier = modifier.size(size), containerColor = container, indicatorColor = indicator)
