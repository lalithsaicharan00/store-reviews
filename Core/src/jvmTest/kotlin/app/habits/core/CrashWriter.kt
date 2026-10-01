package app.habits.core

import java.io.File
import kotlinx.coroutines.runBlocking

/**
 * A separate process for [DurabilityTest]: writes as fast as it can until it is killed.
 *
 * After each write returns, it appends a line to the acknowledgement file. The parent kills this process
 * with SIGKILL at a random moment, then checks that every acknowledged write is in the database.
 *
 * Each round, the habit `h1` is saved with a new name `vN` and N % 5 + 1 steps whose IDs start with `N-`,
 * so the parent can check that a habit and its steps are never seen half-saved.
 */
object CrashWriter {
    @JvmStatic
    fun main(args: Array<String>) = runBlocking {
        val repo = HabitRepository.open(args[0])
        val acks = File(args[1])
        var n = acks.takeIf { it.exists() }?.readLines()?.size ?: 0
        acks.appendText("") // the parent waits for this file before it starts the clock
        while (true) {
            n++
            repo.addEntry(EntryRecord("e$n", "h1", null, "2026-09-27", 1.0, n.toLong(), "Europe/London", null, null))
            val steps = (0..n % 5).map { StepRecord("$n-$it", "h1", "Step $it", it, null) }
            repo.saveHabit(DurabilityTest.habit(name = "v$n"), steps, emptyList(), n.toLong())
            acks.appendText("$n\n")
        }
    }
}
