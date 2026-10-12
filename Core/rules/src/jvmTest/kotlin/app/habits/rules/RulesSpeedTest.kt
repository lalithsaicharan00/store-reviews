package app.habits.rules

import java.io.File
import kotlin.test.Test
import kotlin.test.assertTrue
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.jsonArray
import kotlinx.serialization.json.jsonObject

/**
 * How long the rules take on the JVM (Current Work 92): a year of history and the extreme account (15 years, 375,090
 * logs). Each figure is what a caller pays once per change before it keeps the answer (Rulebook S5): reading the rows,
 * then every habit's streak, best streak and today's progress, then a Progress month (30 days × every habit's outcome).
 */
class RulesSpeedTest {
    private val root = File(System.getProperty("fixtures") ?: "../fixtures")

    @Test
    fun aYearAndTheExtremeAccount() {
        for (name in listOf("year.json", "zz-extreme.json")) {
            val file = File(root, "inputs/$name")
            if (!file.exists()) { println("speed $name: no input (run python3 Core/fixtures/tools/generate.py)"); continue }
            val case = Json.parseToJsonElement(file.readText()).jsonObject["cases"]!!.jsonArray[0].jsonObject
            repeat(3) { round ->
                val t0 = System.nanoTime()
                val (r, data, _) = Recorder.load(case)
                val t1 = System.nanoTime()
                val today = r.today()
                var sum = 0
                for (h in data.habits) {
                    sum += r.streak(h, today) + r.bestStreak(h)
                    r.progress(h, today)
                }
                val t2 = System.nanoTime()
                val month = r.period(Period.MONTH, today)
                for (d in month.first..month.last) sum += r.todayScore(d).planned
                val t3 = System.nanoTime()
                println("speed $name round ${round + 1}: read ${(t1 - t0) / 1_000_000} ms, streaks and best of ${data.habits.size} habits " +
                    "${(t2 - t1) / 1_000_000} ms, a month's scores ${(t3 - t2) / 1_000_000} ms")
                assertTrue(sum >= 0)
            }
        }
    }
}
