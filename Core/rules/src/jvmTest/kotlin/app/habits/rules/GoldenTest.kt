package app.habits.rules

import java.io.File
import java.security.MessageDigest
import java.util.zip.GZIPInputStream
import kotlin.math.abs
import kotlin.math.max
import kotlin.test.Test
import kotlin.test.fail
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonNull
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.booleanOrNull
import kotlinx.serialization.json.doubleOrNull
import kotlinx.serialization.json.intOrNull
import kotlinx.serialization.json.jsonArray
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive
import kotlinx.serialization.json.longOrNull

/**
 * The golden cases (Core/fixtures/README.md): for every case the iPhone answered, the shared rules must give exactly the
 * same answers. Inputs are in `Core/fixtures/inputs/` (`tools/generate.py` makes the large ones); the iPhone's answers
 * are in `Core/fixtures/expected/`, each file with the SHA-256 of the input it answered (`inputs.sha256`).
 *
 * A difference names the case, the habit, the day and the rule (column) that differ, so it can be looked up in spec/.
 */
class GoldenTest {
    private val root = File(System.getProperty("fixtures") ?: "../fixtures")

    @Test
    fun everyCaseMatchesTheIPhone() {
        val expectedDir = File(root, "expected")
        val files = expectedDir.listFiles { f -> f.name.endsWith(".json.gz") }?.sortedBy { it.name } ?: emptyList()
        if (files.isEmpty()) fail("No recorded answers in $expectedDir")
        val hashes = File(expectedDir, "inputs.sha256").takeIf { it.exists() }?.readLines()
            ?.mapNotNull { line -> line.split(" ").takeIf { it.size >= 3 }?.let { it[2] to it[0] } }?.toMap() ?: emptyMap()
        val only = System.getProperty("golden.only")?.takeIf { it.isNotEmpty() }
        val problems = ArrayList<String>()
        var cases = 0
        var compared = 0L
        for (file in files) {
            val name = file.name.removeSuffix(".gz")
            if (only != null && !name.contains(only)) continue
            val input = File(root, "inputs/$name")
            if (!input.exists()) { problems.add("$name: no input (run python3 Core/fixtures/tools/generate.py)"); continue }
            val bytes = input.readBytes()
            val want = hashes[name]
            if (want != null && sha256(bytes) != want) { problems.add("$name: the input isn't the one the iPhone answered"); continue }
            val inputs = Json.parseToJsonElement(bytes.decodeToString()).jsonObject["cases"]!!.jsonArray
            val answers = GZIPInputStream(file.inputStream()).use { Json.parseToJsonElement(it.readBytes().decodeToString()) }
                .jsonObject["cases"]!!.jsonArray
            if (inputs.size != answers.size) problems.add("$name: ${inputs.size} cases, ${answers.size} answers")
            val began = System.nanoTime()
            for ((i, case) in inputs.withIndex()) {
                val expected = answers.getOrNull(i)?.jsonObject ?: break
                val got = Recorder.record(case.jsonObject)
                val diffs = ArrayList<String>()
                compare(got, expected, "", diffs)
                compared += countLeaves(expected)
                cases++
                if (diffs.isNotEmpty()) problems.add("${expected["name"]?.jsonPrimitive?.content}: ${diffs.size} differences: " + diffs.take(12).joinToString("; "))
            }
            println("golden $name: ${inputs.size} cases in ${(System.nanoTime() - began) / 1_000_000} ms")
        }
        println("golden: $cases cases, $compared answers compared, ${problems.size} cases differ")
        File("build/golden-differences.txt").apply { parentFile.mkdirs() }.writeText(problems.joinToString("\n"))
        if (problems.isNotEmpty()) fail("${problems.size} cases differ from the iPhone:\n" + problems.take(40).joinToString("\n"))
    }

    private fun sha256(bytes: ByteArray) = MessageDigest.getInstance("SHA-256").digest(bytes).joinToString("") { "%02x".format(it) }

    private fun countLeaves(e: JsonElement): Long = when (e) {
        is JsonObject -> e.values.sumOf { countLeaves(it) }
        is JsonArray -> e.sumOf { countLeaves(it) }
        else -> 1
    }

    /** Compares what the rules answered with what the iPhone answered; only what the rules answer is compared
     *  (the iPhone's screens built on them, under "full", are checked through the iPhone itself in checkpoint 2). */
    private fun compare(got: JsonElement, want: JsonElement, path: String, diffs: MutableList<String>) {
        if (diffs.size > 50) return
        when {
            got is JsonObject && want is JsonObject -> for ((k, v) in got) {
                val w = want[k] ?: run { diffs.add("$path.$k missing from the iPhone's answers"); null } ?: continue
                compare(v, w, "$path.$k", diffs)
            }
            got is JsonArray && want is JsonArray -> {
                if (got.size != want.size) diffs.add("$path: ${got.size} items, iPhone ${want.size} (${short(got)} vs ${short(want)})")
                else {
                    // A habit's day row: its columns by name (Recorder.columnNames).
                    val row = got.size == Recorder.columnNames.size && (got[0] as? JsonPrimitive)?.isString == true
                    for (i in got.indices) {
                        val name = if (row) (if (i == 0) "" else Recorder.columnNames[i]) else itemLabel(got[i], i)
                        if (row && i == 0) continue
                        compare(got[i], want[i], if (row) "$path ${got[0].jsonPrimitive.content} $name" else "$path[$name]", diffs)
                    }
                }
            }
            got is JsonPrimitive && want is JsonPrimitive -> if (!same(got, want)) diffs.add("$path: ${got.content} vs iPhone ${want.content}")
            got is JsonNull && want is JsonNull -> {}
            else -> diffs.add("$path: ${short(got)} vs iPhone ${short(want)}")
        }
    }

    private fun itemLabel(item: JsonElement, i: Int): String {
        if (item is JsonObject) item["id"]?.jsonPrimitive?.content?.let { return it.take(8) }
        return i.toString()
    }

    private fun short(e: JsonElement) = e.toString().take(120)

    private fun same(a: JsonPrimitive, b: JsonPrimitive): Boolean {
        if (a.isString || b.isString) return a.content == b.content
        a.booleanOrNull?.let { x -> return x == b.booleanOrNull }
        val x = a.doubleOrNull ?: return a.content == b.content
        val y = b.doubleOrNull ?: return false
        return abs(x - y) <= 1e-6 * max(1.0, max(abs(x), abs(y)))
    }
}

/** Answers a golden case with the shared rules, in the same shape as the iPhone's recorder (`GoldenRecorder.swift`). */
object Recorder {
    /** The columns of a habit's day row, in order (Core/fixtures/README.md). */
    val columnNames = listOf("day", "due", "planned", "dayGoal", "dayProgress", "dayMet", "progress", "goal", "done",
        "flexible", "complete", "satisfied", "periodMet", "outcome", "share", "mark", "streak", "countsUp", "fraction",
        "periodRange", "skipped", "paused", "archived")

    fun load(case: JsonObject, windowDays: Int = 0): Triple<HabitRules, HabitData, Set<String>> {
        val s = case["snapshot"]!!.jsonObject
        fun list(k: String) = (s[k] as? JsonArray) ?: JsonArray(emptyList())
        fun JsonObject.str(k: String) = (this[k] as? JsonPrimitive)?.takeIf { it !is JsonNull }?.content
        fun JsonObject.long(k: String) = (this[k] as? JsonPrimitive)?.longOrNull
        fun JsonObject.dbl(k: String) = (this[k] as? JsonPrimitive)?.doubleOrNull
        fun JsonObject.bool(k: String) = (this[k] as? JsonPrimitive)?.booleanOrNull
        val habits = list("habits").mapIndexed { i, e ->
            val o = e.jsonObject
            Rows.HabitRow(o.str("id")!!, o.str("kind")!!, o.str("unit"), o.dbl("increment") ?: 1.0, o.str("part") ?: "anytime",
                o.dbl("goal") ?: 1.0, o.str("frequency") ?: "daily", o.str("dueDay"), o.bool("atMost") ?: false, o.long("quitSince"),
                o.long("position")?.toInt() ?: i, o.long("createdAt")!!, o.long("archivedAt"), o.str("startsOn"), o.str("endsOn"))
        }
        val steps = list("steps").map { val o = it.jsonObject; Rows.StepRow(o.str("id")!!, o.str("habitId")!!, o.long("position")!!.toInt()) }
        val reminders = list("reminders").map {
            val o = it.jsonObject
            Rows.ReminderRow(o.str("id")!!, o.str("habitId")!!, o.long("hour")!!.toInt(), o.long("minute")!!.toInt())
        }
        var entries = list("entries").map {
            val o = it.jsonObject
            Rows.EntryRow(o.str("id")!!, o.str("habitId")!!, o.str("stepId"), o.str("day")!!, o.dbl("value")!!, o.long("createdAt")!!,
                o.str("timeZone")!!, o.str("slot"))
        }
        val settings = list("settings").associate { val o = it.jsonObject; o.str("key")!! to o.str("value")!! }
        val tz = case["timeZone"]!!.jsonPrimitive.content
        val now = case["nowMs"]!!.jsonPrimitive.long
        var before = emptySet<String>()
        if (windowDays > 0) {
            // The Apple Watch's load (spec/streaks.md ST-6): its last days of logs, and every log of a quit habit or task.
            val (probe, probeSettings) = Rows.load(habits, steps, reminders, emptyList(), settings, tz, 1)
            val start = HabitRules(probe, probeSettings) { now }.today() - windowDays
            val whole = habits.filter { it.kind == "quit" || it.kind == "task" }.map { it.id }.toSet()
            val oldest = entries.groupBy { it.habitId }.mapValues { (_, l) -> l.minOf { it.day } }
            before = oldest.filter { (_, d) -> (Day.parse(d) ?: Int.MAX_VALUE) < start }.keys
            entries = entries.filter { (Day.parse(it.day) ?: Int.MIN_VALUE) >= start || it.habitId in whole }
        }
        val (data, daySettings) = Rows.load(habits, steps, reminders, entries, settings, tz, 1)
        return Triple(HabitRules(data, daySettings) { now }, data, before)
    }

    fun record(case: JsonObject): JsonObject {
        val (r, data, _) = load(case)
        val now = case["nowMs"]!!.jsonPrimitive.long
        val today = r.today()
        val window = case["window"]!!.jsonArray.map { Day.parse(it.jsonPrimitive.content)!! }
        val days = (window[0]..window[1]).toList()
        val out = LinkedHashMap<String, JsonElement>()
        out["name"] = JsonPrimitive(case["name"]!!.jsonPrimitive.content)
        out["today"] = JsonPrimitive(Day.key(today))
        out["probes"] = arr((case["probes"] as? JsonArray ?: JsonArray(emptyList())).map { p ->
            val ms = p.jsonPrimitive.long
            arr(listOf(JsonPrimitive(ms), JsonPrimitive(Day.key(r.today(ms)))))
        })
        out["bounds"] = arr(listOf(window[0], today, window[1]).map { d ->
            val b = r.dayBounds(d)
            arr(listOf(JsonPrimitive(Day.key(d)), JsonPrimitive(b[0]), JsonPrimitive(b[1])))
        })
        out["periods"] = arr(listOf(window[0], today, window[1]).map { d ->
            arr(listOf(JsonPrimitive(Day.key(d))) + listOf(Period.WEEK, Period.MONTH, Period.YEAR).map { k ->
                val p = r.period(k, d)
                arr(listOf(JsonPrimitive(Day.key(p.first)), JsonPrimitive(Day.key(p.last))))
            })
        })
        out["weekdays"] = arr(days.take(7).map { JsonPrimitive(Day.weekday(it)) })
        out["cards"] = arr(r.todayCards().map { JsonPrimitive(it) })
        out["members"] = JsonObject(r.cardMembers().mapValues { (_, l) -> arr(l.map { JsonPrimitive(it.id) }) })
        out["sections"] = arr(r.timedSections().map { (s, end) -> arr(listOf(JsonPrimitive(s.id), JsonPrimitive(s.start ?: -1), JsonPrimitive(end))) })
        out["habits"] = arr(data.habits.map { h ->
            val o = LinkedHashMap<String, JsonElement>()
            o["id"] = JsonPrimitive(h.id)
            o["start"] = JsonPrimitive(Day.key(r.startDay(h)))
            o["placements"] = arr(r.placements(h).map { p -> arr(listOf(JsonPrimitive(p.section), JsonPrimitive(p.slot), arr(p.times.map { JsonPrimitive(it) }))) })
            o["slots"] = arr(r.slots(h).map { JsonPrimitive(it) })
            o["periodKind"] = JsonPrimitive(r.periodKind(h).key)
            o["isTotal"] = JsonPrimitive(r.isTotal(h))
            o["canSkip"] = JsonPrimitive(r.canSkip(h))
            o["canPause"] = JsonPrimitive(r.canPause(h))
            o["runs"] = arr(r.runs(h).map { arr(listOf(JsonPrimitive(Day.key(it.start)), JsonPrimitive(Day.key(it.end)), JsonPrimitive(it.length), JsonPrimitive(it.isCurrent))) })
            o["best"] = JsonPrimitive(r.bestStreak(h))
            o["streakUnit"] = JsonPrimitive(StreakUnit.of(h.frequency).name.lowercase())
            if (h.kind == Kind.QUIT) {
                val runs = r.quitRuns(h, now)
                o["quit"] = JsonObject(mapOf(
                    "current" to JsonPrimitive(runs[0]), "best" to JsonPrimitive(runs[1]),
                    "slips" to arr(r.slips(h, now).map { JsonPrimitive(it) }),
                    "history" to arr(r.quitHistory(h, now).map { q -> arr(listOf(JsonPrimitive(q.start), JsonPrimitive(q.end), JsonPrimitive(q.ending.key))) }),
                    "startDay" to JsonPrimitive(Day.key(r.quitStartDay(h))),
                ))
            }
            o["days"] = arr(days.map { d -> dayRow(r, h, d, now) })
            JsonObject(o)
        })
        out["scores"] = arr(days.map { d ->
            val s = r.todayScore(d)
            arr(listOf(JsonPrimitive(Day.key(d)), JsonPrimitive(s.done), JsonPrimitive(s.part), JsonPrimitive(s.partCount), JsonPrimitive(s.planned),
                JsonPrimitive(s.done), JsonPrimitive(s.planned)))
        })
        if (out["name"]!!.jsonPrimitive.content.startsWith("ST-7")) {
            val ladders = LinkedHashMap<String, JsonElement>()
            for (unit in StreakUnit.entries) {
                ladders[unit.name.lowercase()] = JsonObject(mapOf(
                    "milestones" to arr(Milestones.upTo(unit, 3000).map { JsonPrimitive(it) }),
                    "next" to arr(listOf(0, 1, 2, 3, 29, 30, 104, 105, 365, 730, 731, 1094, 1095).map { JsonPrimitive(Milestones.next(unit, it)) }),
                ))
            }
            for (p in Period.entries) ladders["total." + p.key] = arr(Milestones.totalLadder(p).map { JsonPrimitive(it) })
            out["milestones"] = JsonObject(ladders)
        }
        if ((case["watch"] as? JsonPrimitive)?.booleanOrNull == true) {
            val (w, wd, before) = load(case, 400)
            val wToday = w.today()
            out["watch"] = arr(wd.habits.map { h ->
                arr(listOf(JsonPrimitive(h.id), JsonPrimitive(w.streak(h, wToday)), JsonPrimitive(w.bestStreak(h)), JsonPrimitive(h.id in before)))
            })
        }
        return JsonObject(out)
    }

    fun dayRow(r: HabitRules, h: Habit, d: Int, now: Long): JsonArray {
        val rule = r.rule(h, d)
        val range = r.periodRange(rule, d)
        val o = r.outcome(h, d)
        val outcome = when (o.kind) {
            Outcome.Kind.DONE -> "done"
            Outcome.Kind.PART -> "part"
            Outcome.Kind.NOT_DONE -> "notDone"
            Outcome.Kind.OPEN -> "open"
            Outcome.Kind.NEUTRAL -> "neutral"
        }
        val share: Double = when (o.kind) {
            Outcome.Kind.DONE -> 1.0
            Outcome.Kind.PART -> o.share
            else -> 0.0
        }
        return arr(listOf(
            JsonPrimitive(Day.key(d)),
            JsonPrimitive(r.isDue(h, d, now)),
            JsonPrimitive(r.isDue(h, d, now, countingSkips = false)),
            JsonPrimitive(r.dayGoal(rule)),
            JsonPrimitive(r.dayProgress(h, d, now)),
            JsonPrimitive(r.isDayMet(h, d)),
            JsonPrimitive(r.progress(h, d, now)),
            JsonPrimitive(r.goal(rule)),
            JsonPrimitive(r.isDone(h, d)),
            JsonPrimitive(r.flexibleProgress(h, d) ?: -1),
            JsonPrimitive(r.isComplete(h, d)),
            JsonPrimitive(r.isSatisfied(h, d)),
            JsonPrimitive(r.isPeriodMet(h, d)),
            JsonPrimitive(outcome), JsonPrimitive(share),
            JsonPrimitive(r.dayMark(h, d).key),
            JsonPrimitive(r.streak(h, d)),
            JsonPrimitive(r.countsUp(h, d)),
            JsonPrimitive(r.dayFraction(h, d)),
            range?.let { arr(listOf(JsonPrimitive(Day.key(it.first)), JsonPrimitive(Day.key(it.last)))) } ?: JsonNull,
            JsonPrimitive(r.isSkipped(h, d)),
            JsonPrimitive(r.isPaused(h, d)),
            JsonPrimitive(r.isArchived(h, d)),
        ))
    }

    private fun arr(items: List<JsonElement>) = JsonArray(items)
    private val JsonPrimitive.long get() = longOrNull ?: content.toDouble().toLong()
}
