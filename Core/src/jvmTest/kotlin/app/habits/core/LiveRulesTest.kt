package app.habits.core

import app.habits.rules.Day
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertFalse
import kotlin.test.assertTrue

/**
 * The apps' live copy of the rules (`LiveRules`, Current Work 92): a habit's part of the data is found once and kept on
 * the habit (`HabitFacts`), so every log added, inserted, edited, moved or removed after that must still be seen, and
 * new habits and settings must replace it.
 */
class LiveRulesTest {
    private val now = 1_791_630_000_000L // 10 Oct 2026, 12:00 in London
    private fun day(key: String) = Day.parse(key)!!

    private fun habit(id: String = "w") = HabitRecord(
        id = id, name = "Water", symbol = "drop.fill", color = "blue", kind = "amount", unit = "glasses", increment = 1.0,
        part = "anytime", goal = 8.0, period = "day", scheduleDays = null, frequency = "daily", dueDay = null, dueMinute = null,
        atMost = false, quitSince = null, position = 0, createdAt = 1_790_000_000_000L, updatedAt = 1_000, archivedAt = null,
        deletedAt = null,
    )

    private fun entry(id: String, value: Double, day: String, habitId: String = "w") =
        EntryRecord(id, habitId, null, day, value, now - 1_000, "Europe/London", null, null, "today")

    private val settings = mapOf("day_end_hour" to "0", "week_start" to "2")

    @Test
    fun logsChangedAfterTheFirstQuestionAreSeen() {
        val rules = LiveRules(Snapshot(listOf(habit()), emptyList(), emptyList(), emptyList(), emptyList()), settings, "Europe/London") { now }
        val h = rules.habit("w")!!
        // Asked first with no logs at all: the habit's (empty) logs are kept from here on.
        assertEquals(0.0, rules.dayProgress(h, day("2026-10-10"), now))

        rules.addEntry(entry("a", 3.0, "2026-10-10"))
        assertEquals(3.0, rules.dayProgress(h, day("2026-10-10"), now))
        rules.insertEntry(entry("b", 2.0, "2026-10-10"), 0)
        assertEquals(5.0, rules.dayProgress(h, day("2026-10-10"), now))
        rules.replaceEntry(entry("a", 4.0, "2026-10-10"))
        assertEquals(6.0, rules.dayProgress(h, day("2026-10-10"), now))
        // Moved to the day before.
        rules.replaceEntry(entry("a", 4.0, "2026-10-09"))
        assertEquals(2.0, rules.dayProgress(h, day("2026-10-10"), now))
        assertEquals(4.0, rules.dayProgress(h, day("2026-10-09"), now))
        rules.removeEntry("b", "w")
        assertEquals(0.0, rules.dayProgress(h, day("2026-10-10"), now))
        assertEquals(4.0, rules.loggedTotal(h, day("2026-10-05"), day("2026-10-11")))

        // A form's draft of the same habit reads the same logs.
        val draft = rules.draft(habit(), emptyList(), emptyList())!!
        assertEquals(4.0, rules.dayProgress(draft, day("2026-10-09"), now))

        // A day far from the rest is kept too.
        rules.addEntry(entry("far", 1.0, "1901-01-01"))
        assertEquals(1.0, rules.dayProgress(h, day("1901-01-01"), now))
        assertEquals(4.0, rules.dayProgress(h, day("2026-10-09"), now))
    }

    @Test
    fun newHabitsAndSettingsReplaceWhatWasKept() {
        val rules = LiveRules(Snapshot(listOf(habit()), emptyList(), emptyList(), listOf(entry("a", 8.0, "2026-10-08")), emptyList()),
            settings, "Europe/London") { now }
        val before = rules.habit("w")!!
        assertFalse(rules.isSkipped(before, day("2026-10-09")))
        assertTrue(rules.isDayMet(before, day("2026-10-08")))

        rules.update(listOf(habit()), emptyList(), emptyList(), settings + ("skip.w" to "2026-10-09,2026-10-07"), "Europe/London")
        val after = rules.habit("w")!!
        assertTrue(rules.isSkipped(after, day("2026-10-09")))
        assertTrue(rules.isSkipped(after, day("2026-10-07")))
        assertFalse(rules.isSkipped(after, day("2026-10-08")))
        // The logs stay with the live copy through an update.
        assertTrue(rules.isDayMet(after, day("2026-10-08")))
        // A handle from before the update reads the new data.
        assertTrue(rules.isSkipped(before, day("2026-10-09")))

        // The strip of days in one call answers as the questions asked one by one.
        val first = day("2026-10-06")
        val last = day("2026-10-10")
        val strip = rules.days(after, first, last, last, now)
        for (d in first..last) {
            val at = (d - first) * LiveRules.DAY_FIELDS
            assertEquals(rules.dayMark(after, d, last).toDouble(), strip[at], "mark $d")
            assertEquals(rules.dayProgress(after, d, now), strip[at + 1], "logged $d")
            assertEquals(if (rules.isDayMet(after, d)) 1.0 else 0.0, strip[at + 2], "met $d")
            assertEquals(rules.dayGoal(after), strip[at + 3], "goal $d")
            assertEquals(if (rules.isDue(after, d, now, true, true)) 1.0 else 0.0, strip[at + 4], "due $d")
            assertEquals(rules.periodKind(after).toDouble(), strip[at + 5], "period $d")
        }
    }
}
