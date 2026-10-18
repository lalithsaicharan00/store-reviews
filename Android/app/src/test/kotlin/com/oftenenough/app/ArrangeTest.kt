package com.oftenenough.app

import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.ui.today.moved
import com.oftenenough.app.ui.today.sortedByName
import org.junit.Assert.assertEquals
import org.junit.Test

/** Arrange your day's order: a drag moves one habit; sorting is a one-off action (U13). */
class ArrangeTest {
    private fun h(name: String) = Habit(name = name, symbol = "star", color = HabitColor.BLUE, kind = HabitKind.Check)

    @Test fun aDragMovesOneAndKeepsTheRest() {
        assertEquals(listOf("b", "c", "a", "d"), listOf("a", "b", "c", "d").moved(0, 2))
        assertEquals(listOf("a", "d", "b", "c"), listOf("a", "b", "c", "d").moved(3, 1))
        assertEquals(listOf("a", "b"), listOf("a", "b").moved(0, 5))
    }

    @Test fun aToZIgnoresCase() {
        assertEquals(listOf("apple", "Banana", "cherry"), sortedByName(listOf(h("cherry"), h("Banana"), h("apple"))).map { it.name })
    }
}
