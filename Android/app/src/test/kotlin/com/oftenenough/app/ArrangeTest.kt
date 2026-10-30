package com.oftenenough.app

import com.oftenenough.app.ui.today.moved
import org.junit.Assert.assertEquals
import org.junit.Test

/** Arrange your day's order: a drag moves one habit (U13). */
class ArrangeTest {
    @Test fun aDragMovesOneAndKeepsTheRest() {
        assertEquals(listOf("b", "c", "a", "d"), listOf("a", "b", "c", "d").moved(0, 2))
        assertEquals(listOf("a", "d", "b", "c"), listOf("a", "b", "c", "d").moved(3, 1))
        assertEquals(listOf("a", "b"), listOf("a", "b").moved(0, 5))
    }
}
