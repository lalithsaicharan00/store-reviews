package app.habits.core

import java.io.File
import kotlin.test.AfterTest
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertTrue
import kotlinx.coroutines.test.runTest

class HabitRepositoryTest {
    private val dir = File(System.getProperty("java.io.tmpdir"), "habits-test-${System.nanoTime()}").apply { mkdirs() }
    private val path = File(dir, "habits.db").path

    @AfterTest fun cleanUp() { dir.deleteRecursively() }

    private fun habit(id: String = "h1", name: String = "Water") = HabitRecord(
        id = id, name = name, symbol = "drop.fill", color = "blue", kind = "amount", unit = "glasses",
        increment = 1.0, part = "anytime", goal = 8.0, period = "day", scheduleDays = null, frequency = "daily",
        dueDay = null, dueMinute = null, atMost = false,
        quitSince = null, position = 0, createdAt = 1_000, updatedAt = 1_000, archivedAt = null, deletedAt = null,
    )

    private fun entry(id: String, habitId: String = "h1", day: String = "2026-09-27") =
        EntryRecord(id, habitId, null, day, 1.0, 2_000, "Europe/London", null, null)

    @Test fun savedDataSurvivesClosingAndReopening() = runTest {
        val repo = HabitRepository.open(path)
        repo.saveHabit(habit(), listOf(StepRecord("s1", "h1", "Cleanser", 0, null)), listOf(ReminderRecord("r1", "h1", 9, 0, null)), 1_000)
        repo.addEntry(entry("e1"))
        repo.saveSetting("day_end_hour", "3")
        repo.close()

        val reopened = HabitRepository.open(path)
        val snapshot = reopened.load()
        assertEquals(listOf(habit()), snapshot.habits)
        assertEquals(listOf("Cleanser"), snapshot.steps.map { it.name })
        assertEquals(listOf(9), snapshot.reminders.map { it.hour })
        assertEquals(listOf("e1"), snapshot.entries.map { it.id })
        assertEquals("3", snapshot.settings.single { it.key == "day_end_hour" }.value)
        reopened.close()
    }

    @Test fun theSameTapSavedTwiceCountsOnce() = runTest {
        val repo = HabitRepository.open(path)
        repo.saveHabit(habit(), emptyList(), emptyList(), 1_000)
        repo.addEntry(entry("e1"))
        repo.addEntry(entry("e1"))
        repo.addEntry(entry("e2"))
        assertEquals(listOf("e1", "e2"), repo.load().entries.map { it.id })
        repo.close()
    }

    @Test fun stoppingATimerCommitsTimeAndRemovesItsRunningMarker() = runTest {
        val repo = HabitRepository.open(path)
        repo.saveHabit(habit(), emptyList(), emptyList(), 1_000)
        repo.saveSetting("timer.h1", "1000")
        repo.finishTimer(entry("timer-entry"), "timer.h1")
        // Replaying the same completed transaction must not duplicate time.
        repo.finishTimer(entry("timer-entry"), "timer.h1")
        repo.close()
        val reopened = HabitRepository.open(path)
        assertEquals(listOf("timer-entry"), reopened.load().entries.map { it.id })
        assertTrue(reopened.load().settings.none { it.key == "timer.h1" })
        reopened.saveSetting("timer.h1", "2000")
        reopened.finishTimer(null, "timer.h1")
        assertEquals(1, reopened.load().entries.size)
        assertTrue(reopened.load().settings.none { it.key == "timer.h1" })
        reopened.close()
    }

    @Test fun undoKeepsATombstoneAndHidesTheEntry() = runTest {
        val repo = HabitRepository.open(path)
        repo.saveHabit(habit(), emptyList(), emptyList(), 1_000)
        repo.addEntry(entry("e1"))
        repo.removeEntry("e1", 3_000)
        assertTrue(repo.load().entries.isEmpty())
        // A retried write of the undone tap must not bring it back.
        repo.addEntry(entry("e1"))
        assertTrue(repo.load().entries.isEmpty())
        repo.close()
    }

    @Test fun editingAHabitTombstonesRemovedStepsAndReminders() = runTest {
        val repo = HabitRepository.open(path)
        val steps = listOf(StepRecord("s1", "h1", "A", 0, null), StepRecord("s2", "h1", "B", 1, null))
        repo.saveHabit(habit(), steps, listOf(ReminderRecord("r1", "h1", 9, 0, null)), 1_000)
        repo.saveHabit(habit(name = "Water!"), steps.take(1), emptyList(), 2_000)
        val snapshot = repo.load()
        assertEquals("Water!", snapshot.habits.single().name)
        assertEquals(listOf("s1"), snapshot.steps.map { it.id })
        assertTrue(snapshot.reminders.isEmpty())
        repo.close()
    }

    @Test fun durabilitySettingsAreOn() = runTest {
        val repo = HabitRepository.open(path)
        repo.load()
        assertEquals("wal", repo.pragma("journal_mode").lowercase())
        assertEquals("2", repo.pragma("synchronous")) // 2 = FULL
        repo.close()
    }

    @Test fun snapshotIsACompleteCopy() = runTest {
        val repo = HabitRepository.open(path)
        repo.saveHabit(habit(), emptyList(), emptyList(), 1_000)
        repo.addEntry(entry("e1"))
        val copy = File(dir, "copy.db").path
        repo.snapshot(copy)
        repo.close()

        val restored = HabitRepository.open(copy)
        assertEquals(listOf("e1"), restored.load().entries.map { it.id })
        restored.close()
    }

    @Test fun importKeepsExistingRows() = runTest {
        val repo = HabitRepository.open(path)
        repo.saveHabit(habit(), emptyList(), emptyList(), 1_000)
        repo.addEntry(entry("e1"))
        repo.importAll(Snapshot(listOf(habit(id = "h2", name = "Read")), emptyList(), emptyList(), listOf(entry("e1"), entry("e2", "h2")), emptyList()))
        val snapshot = repo.load()
        assertEquals(setOf("Water", "Read"), snapshot.habits.map { it.name }.toSet())
        assertEquals(listOf("e1", "e2"), snapshot.entries.map { it.id })
        repo.close()
    }
}
