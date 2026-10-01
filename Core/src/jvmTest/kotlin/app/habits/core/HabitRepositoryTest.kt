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
        assertTrue(repo.hasEntry("e1"))
        assertTrue(!repo.hasEntry("unknown"))
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

    @Test fun backupRestorePreservesEditsDeletesAndRemovedChildren() = runTest {
        val repo = HabitRepository.open(path)
        repo.saveHabit(habit(name = "Edited"), emptyList(), emptyList(), 3_000)
        repo.addEntry(entry("removed"))
        repo.removeEntry("removed", 4_000)
        repo.saveHabit(habit(id = "deleted").copy(deletedAt = 4_000), emptyList(), emptyList(), 4_000)
        repo.saveSetting("note.h1|2026-09-27", "")
        repo.saveSetting("week_start", "2")
        val old = Snapshot(
            listOf(habit(), habit(id = "deleted"), habit(id = "h2", name = "New")),
            listOf(StepRecord("old-step", "h1", "Removed", 0, null), StepRecord("new-step", "h2", "Keep", 0, null)),
            listOf(ReminderRecord("old-reminder", "h1", 9, 0, null), ReminderRecord("new-reminder", "h2", 8, 0, null)),
            listOf(entry("removed"), entry("missing"), entry("orphan", "deleted"), entry("new", "h2")),
            listOf(SettingRecord("note.h1|2026-09-27", "Removed note"), SettingRecord("week_start", "1"),
                   SettingRecord("timer.h2", "1000"), SettingRecord("rules.h1", "old"), SettingRecord("rules.h2", "new"))
        )
        repo.mergeAll(old)
        val first = repo.load()
        assertEquals(setOf("Edited", "New"), first.habits.map { it.name }.toSet())
        assertEquals(listOf("new-step"), first.steps.map { it.id })
        assertEquals(listOf("new-reminder"), first.reminders.map { it.id })
        assertEquals(setOf("missing", "new"), first.entries.map { it.id }.toSet())
        assertEquals("", first.settings.single { it.key == "note.h1|2026-09-27" }.value)
        assertEquals("2", first.settings.single { it.key == "week_start" }.value)
        assertTrue(first.settings.none { it.key.startsWith("timer.") || it.key == "rules.h1" })
        assertEquals("new", first.settings.single { it.key == "rules.h2" }.value)
        repo.mergeAll(old)
        assertEquals(first, repo.load())
        repo.close()
        val reopened = HabitRepository.open(path)
        assertEquals(first, reopened.load())
        reopened.close()
    }

    @Test fun emptyBackupAndUnknownSettingsAreHarmless() = runTest {
        val repo = HabitRepository.open(path)
        repo.saveHabit(habit(), emptyList(), emptyList(), 1_000)
        val before = repo.load()
        repo.mergeAll(Snapshot(emptyList(), emptyList(), emptyList(), emptyList(),
                              listOf(SettingRecord("app_lock", "1"), SettingRecord("timer.h1", "1000"))))
        assertEquals(before, repo.load())
        repo.close()
    }

    @Test fun freshRestoreCarriesTombstonesIntoSubsequentRestores() = runTest {
        val source = HabitRepository.open(path)
        source.saveHabit(habit(), emptyList(), emptyList(), 1_000)
        source.saveHabit(habit(id = "deleted").copy(deletedAt = 3_000), emptyList(), emptyList(), 3_000)
        source.addEntry(entry("undone"))
        source.removeEntry("undone", 3_000)
        val target = HabitRepository.open(File(dir, "target.db").path)
        target.mergeAll(source.loadForRestore())
        target.mergeAll(Snapshot(listOf(habit(), habit(id = "deleted")), emptyList(), emptyList(),
                                 listOf(entry("undone")), emptyList()))
        assertEquals(listOf("h1"), target.load().habits.map { it.id })
        assertTrue(target.load().entries.isEmpty())
        source.close()
        target.close()
    }
    @Test fun restoreDoesNotReplaceUnsavedDefaultPreferencesOnExistingData() = runTest {
        val repo = HabitRepository.open(path)
        repo.saveHabit(habit(), emptyList(), emptyList(), 1_000)
        repo.mergeAll(Snapshot(emptyList(), emptyList(), emptyList(), emptyList(),
                              listOf(SettingRecord("day_end_hour", "4"), SettingRecord("week_start", "1"))))
        assertTrue(repo.load().settings.isEmpty())
        repo.close()
    }

    @Test fun editingOneEntryPreservesItsIdentityAndSourceAndNeverRevivesADeletion() = runTest {
        var repo = HabitRepository.open(path)
        repo.saveHabit(habit(), emptyList(), emptyList(), 1_000)
        val first = entry("e1").copy(source = "routine", slot = "morning")
        repo.addEntry(first)
        repo.addEntry(entry("e2"))
        repo.editEntry("e1", 3.5, first.createdAt)
        repo.close()
        repo = HabitRepository.open(path)
        assertEquals(first.copy(value = 3.5), repo.load().entries.first { it.id == "e1" })
        assertEquals(1.0, repo.load().entries.first { it.id == "e2" }.value)
        repo.removeEntry("e1", 4_000)
        repo.editEntry("e1", 9.0, 5_000)
        assertEquals(listOf("e2"), repo.load().entries.map { it.id })
        repo.close()
    }

}
