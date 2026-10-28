package com.oftenenough.app.ui.components

import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Outline
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.Shape
import androidx.compose.ui.unit.Density
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.LayoutDirection
import androidx.compose.ui.unit.dp
import kotlin.math.PI
import kotlin.math.cos
import kotlin.math.sin

/** Material 3 Expressive's "cookie": a 9-sided scallop, for illustrative icon containers (the designs). */
class CookieShape(private val scallops: Int = 9, private val depth: Float = 0.085f) : Shape {
    override fun createOutline(size: Size, layoutDirection: LayoutDirection, density: Density): Outline {
        val path = Path()
        val cx = size.width / 2
        val cy = size.height / 2
        val r = minOf(cx, cy) / (1 + depth)
        val steps = 180
        for (i in 0..steps) {
            val t = 2 * PI * i / steps - PI / 2
            val radius = r * (1 + depth * cos(scallops * (t + PI / 2)))
            val x = cx + (radius * cos(t)).toFloat()
            val y = cy + (radius * sin(t)).toFloat()
            if (i == 0) path.moveTo(x, y) else path.lineTo(x, y)
        }
        path.close()
        return Outline.Generic(path)
    }
}

/** A segmented list's piece: outer corners [outer] on the first and last, [inner] between (Android 16's lists). */
fun segmentShape(index: Int, count: Int, outer: Dp = 24.dp, inner: Dp = 4.dp): RoundedCornerShape {
    val top = if (index == 0) outer else inner
    val bottom = if (index == count - 1) outer else inner
    return RoundedCornerShape(topStart = top, topEnd = top, bottomStart = bottom, bottomEnd = bottom)
}

