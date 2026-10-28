package com.oftenenough.app.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Shape
import androidx.compose.ui.unit.dp

/**
 * Atom 3.4, **Skeleton** (Figma 1030:2; Components — Atoms Build Plan): a grey stand-in, in Surface container high, for
 * something still being read: the shape of a line of text, a number, a tile or a medal. Material has none. The
 * [modifier] gives it the size of what it stands for, and [shape] its corners: 8 for a line or a number (the
 * default), 16 for a tile, round for a medal. It never shows a number, so nothing reads as a real 0. It stays still:
 * Figma draws no shimmer.
 */
@Composable
fun Skeleton(modifier: Modifier, shape: Shape = RoundedCornerShape(8.dp)) =
    Box(modifier.clip(shape).background(MaterialTheme.colorScheme.surfaceContainerHigh))
