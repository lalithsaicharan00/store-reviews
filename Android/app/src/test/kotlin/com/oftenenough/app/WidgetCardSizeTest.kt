package com.oftenenough.app

import androidx.compose.ui.unit.DpSize
import androidx.compose.ui.unit.dp
import com.oftenenough.app.app.widgets.WidgetKind
import com.oftenenough.app.app.widgets.cardSize
import org.junit.Assert.assertEquals
import org.junit.Test

class WidgetCardSizeTest {
    @Test fun cardKeepsToWhatTheLauncherShows() {
        // A moto g54's tall 2×2 cells: Figma's height, never stretched.
        assertEquals(DpSize(208.dp, 176.dp), cardSize(WidgetKind.ONE_HABIT, DpSize(208.dp, 368.dp), "motorola"))
        // ColorOS says 152 × 176 but shows only 150 × 146 of a 2×2 (OPPO CPH2557, 3 Nov 2026).
        assertEquals(DpSize(152.dp, 144.dp), cardSize(WidgetKind.ONE_HABIT, DpSize(152.dp, 176.dp), "OPPO"))
        assertEquals(DpSize(152.dp, 144.dp), cardSize(WidgetKind.ONE_HABIT, DpSize(152.dp, 176.dp), "OnePlus"))
        // Its 4×2 shows whole.
        assertEquals(DpSize(320.dp, 176.dp), cardSize(WidgetKind.TODAY, DpSize(320.dp, 176.dp), "OPPO"))
    }
}
