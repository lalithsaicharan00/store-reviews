package app.habits.rules

import java.io.File
import kotlin.test.Test
import kotlin.test.fail
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.jsonArray
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive
import kotlinx.serialization.json.long

/**
 * [HabitRules.row] (a Today row's numbers) and [HabitRules.strip] work each day's facts out once and reads the mark from them; it must answer exactly as the rules
 * asked one by one ([HabitRules.dayMark], [HabitRules.dayProgress], [HabitRules.isDayMet], [HabitRules.dayGoal],
 * [HabitRules.isDue], [HabitRules.periodKind]) for every habit, every day of every golden case's window.
 */
class StripTest {
    private val root = File(System.getProperty("fixtures") ?: "../fixtures")

    @Test
    fun stripAnswersAsTheRulesOneByOne() {
        val files = File(root, "inputs").listFiles { f -> f.name.endsWith(".json") && f.name != "zz-extreme.json" }?.sortedBy { it.name }
            ?: emptyList()
        if (files.isEmpty()) fail("No golden inputs in $root/inputs (run python3 Core/fixtures/tools/generate.py)")
        val problems = ArrayList<String>()
        var days = 0L
        for (file in files) {
            val cases = Json.parseToJsonElement(file.readText()).jsonObject["cases"]!!.jsonArray
            for (case in cases) {
                val c = case.jsonObject
                val (r, data, _) = Recorder.load(c)
                val now = c["nowMs"]!!.jsonPrimitive.long
                val reference = r.today()
                val window = c["window"]!!.jsonArray.map { Day.parse(it.jsonPrimitive.content)!! }
                for (h in data.habits) {
                    val strip = r.strip(h, window[0], window[1], reference, now)
                    for (d in window[0]..window[1]) {
                        // A Today row's numbers in one call (`row`), against each rule asked on its own.
                        val row = r.row(h, d, now)
                        val rowJudged = r.rule(h, d)
                        val rowWant = doubleArrayOf(
                            r.dayProgress(rowJudged, d, now), r.dayGoal(rowJudged),
                            if (r.isDue(h, d, now, countingSkips = false)) 1.0 else 0.0, if (r.isSatisfied(h, d)) 1.0 else 0.0,
                            if (r.countsUp(h, d)) 1.0 else 0.0, r.progress(h, d, now), r.goal(h), r.startDay(h).toDouble(),
                            if (r.isDone(h, d)) 1.0 else 0.0, (r.flexibleProgress(h, d) ?: -1).toDouble(),
                        )
                        for (f in 0 until ROW_FIELDS) if (row[f] != rowWant[f]) {
                            problems.add("row: ${c["name"]!!.jsonPrimitive.content} ${h.id} ${Day.key(d)} field $f: ${row[f]} vs ${rowWant[f]}")
                        }
                        val at = (d - window[0]) * STRIP_FIELDS
                        val judged = r.rule(h, d)
                        val want = doubleArrayOf(
                            r.dayMark(h, d, reference).ordinal.toDouble(), r.dayProgress(judged, d, now),
                            if (r.isDayMet(judged, d)) 1.0 else 0.0, r.dayGoal(judged), if (r.isDue(h, d, now)) 1.0 else 0.0,
                            r.periodKind(judged).ordinal.toDouble(),
                        )
                        for (f in 0 until STRIP_FIELDS) if (strip[at + f] != want[f]) {
                            problems.add("${c["name"]!!.jsonPrimitive.content} ${h.id} ${Day.key(d)} field $f: ${strip[at + f]} vs ${want[f]}")
                        }
                        days++
                    }
                }
            }
        }
        println("strip and row: $days habit-days compared, ${problems.size} differ")
        if (problems.isNotEmpty()) fail("${problems.size} differ:\n" + problems.take(30).joinToString("\n"))
    }
}
