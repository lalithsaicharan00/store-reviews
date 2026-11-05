package com.oftenenough.app

import com.oftenenough.app.data.IconNames
import com.oftenenough.app.ui.theme.HabitIcons
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Test

/** A habit keeps its icon when a backup file moves between Android and the iPhone (Android A111). */
class IconNamesTest {
    @Test fun anIconHasItsNamesOnBothPlatforms() {
        val names = IconNames.of("figure.run")
        assertEquals("figure.run", names.first())
        assertTrue("directions_run" in names)
        assertTrue("run" in names)
    }

    @Test fun everyIconThePickerOffersHasMoreThanOneName() {
        for (symbol in HabitIcons.groups.flatMap { it.symbols }) {
            assertTrue(symbol, IconNames.of(symbol).size > 1)
            assertEquals(symbol, symbol, IconNames.closest(symbol, IconNames.stored(symbol)))
        }
    }

    @Test fun storedNamesReadBackWhole() {
        for (symbol in HabitIcons.groups.flatMap { it.symbols }) {
            assertEquals(IconNames.of(symbol), IconNames.stored(symbol).split(","))
        }
    }

    @Test fun anIconOnlyTheIphoneHasBecomesTheClosestOneHere() {
        assertEquals("figure.run", IconNames.closest("figure.run.treadmill", "figure.run.treadmill,directions_run,treadmill"))
        assertEquals("figure.run", IconNames.closest("figure.run.treadmill", "figure.run.treadmill,treadmill,jog"))
    }

    @Test fun anEarlierNameWinsOverALaterOne() {
        assertEquals("book.fill", IconNames.closest("figure.run", "book.fill,figure.run"))
    }

    @Test fun aFileWithNoNamesStillFindsItsIcon() {
        assertEquals("drop.fill", IconNames.closest("drop.fill", null))
        assertEquals("heart.fill", IconNames.closest("heart", null))
    }

    @Test fun nothingKnownIsLeftAsItIs() {
        assertNull(IconNames.closest("figure.curling", "figure.curling,curling"))
        assertEquals("figure.curling,curling", IconNames.toSave("figure.curling", "figure.curling,curling"))
    }

    @Test fun theOtherPhonesNamesSurviveAnEditHere() {
        val fromIphone = "figure.run.treadmill,treadmill,jog"
        val shown = IconNames.closest("figure.run.treadmill", fromIphone)!!
        val saved = IconNames.toSave(shown, fromIphone)
        assertTrue(saved.startsWith(fromIphone))
        assertEquals(shown, IconNames.closest(shown, saved))
    }

    @Test fun choosingAnotherIconStartsItsNamesAgain() {
        assertEquals(IconNames.stored("book.fill"), IconNames.toSave("book.fill", IconNames.stored("figure.run")))
    }
}
