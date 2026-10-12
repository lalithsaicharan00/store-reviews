package com.oftenenough.app

import app.habits.rules.Day
import org.junit.Assert.assertEquals
import org.junit.Test

class SmokeTest {
    @Test fun coreRulesLoad() = assertEquals("2026-10-12", Day.key(Day.of(2026, 10, 12)))
}
