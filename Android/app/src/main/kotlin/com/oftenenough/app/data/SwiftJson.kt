package com.oftenenough.app.data

import java.time.LocalDate
import java.util.Base64
import kotlin.math.roundToLong
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonNull
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.booleanOrNull
import kotlinx.serialization.json.contentOrNull
import kotlinx.serialization.json.doubleOrNull
import kotlinx.serialization.json.intOrNull

/**
 * The settings and schedules exactly as the iPhone saves them (Swift's `JSONEncoder`), so a habit made on Android reads on
 * the iPhone and the other way round: an enum case with values is `{"flexible":{"_0":"week","_1":3}}`, a day is
 * `{"year":2026,"month":10,"day":12}`, a moment is seconds since 1 January 2001, and a missing value is left out.
 */
object SwiftJson {
    /** Seconds from 1970 to Swift's reference date (1 January 2001). */
    private const val APPLE_EPOCH = 978_307_200.0

    fun parse(text: String): JsonElement? = try { Json.parseToJsonElement(text) } catch (_: Exception) { null }

    // ------------------------------------------------------------------ Days and moments

    fun day(n: Int): JsonObject {
        val d = LocalDate.ofEpochDay(n.toLong())
        return obj("year" to num(d.year), "month" to num(d.monthValue), "day" to num(d.dayOfMonth))
    }

    fun day(e: JsonElement?): Int? {
        val o = e as? JsonObject ?: return null
        val y = o.int("year") ?: return null
        val m = o.int("month") ?: return null
        val d = o.int("day") ?: return null
        return try { LocalDate.of(y, m, d).toEpochDay().toInt() } catch (_: Exception) { null }
    }

    fun moment(ms: Long): JsonPrimitive = JsonPrimitive(ms / 1000.0 - APPLE_EPOCH)
    fun moment(e: JsonElement?): Long? = (e as? JsonPrimitive)?.doubleOrNull?.let { ((it + APPLE_EPOCH) * 1000).roundToLong() }

    // ------------------------------------------------------------------ Frequency

    /** The database form: `daily`, `weekdays:2,4,6`, `every:3`, `weeks:2`, `dates:1,15`, `week:3`, `month:4`, `year:6`,
     *  or `v2:` and base64 JSON for the newer kinds (the iPhone's `Frequency.storageKey`). */
    fun storageKey(f: Frequency): String = when (f) {
        is Frequency.Calendar, is Frequency.Flexible, is Frequency.AfterCompletion ->
            "v2:" + Base64.getEncoder().encodeToString(frequencyJson(f).toString().encodeToByteArray())
        Frequency.Daily -> "daily"
        is Frequency.Weekdays -> "weekdays:" + f.days.sorted().joinToString(",")
        is Frequency.EveryNDays -> "every:${f.n}"
        is Frequency.EveryNWeeks -> "weeks:${f.n}"
        is Frequency.MonthDates -> "dates:" + f.dates.sorted().joinToString(",")
        is Frequency.PerWeek -> "week:${f.n}"
        is Frequency.PerMonth -> "month:${f.n}"
        is Frequency.PerYear -> "year:${f.n}"
    }

    fun frequency(key: String): Frequency? {
        if (key.startsWith("v2:")) {
            val text = try { String(Base64.getDecoder().decode(key.removePrefix("v2:"))) } catch (_: Exception) { return null }
            return frequency(parse(text) ?: return null)
        }
        if (key.isEmpty()) return null
        val name = key.substringBefore(":")
        val value = key.substringAfter(":", "")
        fun numbers() = value.split(",").mapNotNull { it.trim().toIntOrNull() }.toSet()
        fun positive() = value.toIntOrNull()?.takeIf { it > 0 }
        return when (name) {
            "daily" -> Frequency.Daily
            "weekdays" -> Frequency.Weekdays(numbers())
            "every" -> Frequency.EveryNDays(positive() ?: return null)
            "weeks" -> Frequency.EveryNWeeks(positive() ?: return null)
            "dates" -> Frequency.MonthDates(numbers())
            "week" -> Frequency.PerWeek(positive() ?: return null)
            "month" -> Frequency.PerMonth(positive() ?: return null)
            "year" -> Frequency.PerYear(positive() ?: return null)
            else -> null
        }
    }

    fun frequencyJson(f: Frequency): JsonObject = when (f) {
        Frequency.Daily -> case("daily")
        is Frequency.Weekdays -> case("weekdays", ints(f.days))
        is Frequency.EveryNDays -> case("everyNDays", num(f.n))
        is Frequency.EveryNWeeks -> case("everyNWeeks", num(f.n))
        is Frequency.MonthDates -> case("monthDates", ints(f.dates))
        is Frequency.PerWeek -> case("perWeek", num(f.n))
        is Frequency.PerMonth -> case("perMonth", num(f.n))
        is Frequency.PerYear -> case("perYear", num(f.n))
        is Frequency.Flexible -> case("flexible", JsonPrimitive(f.period.key), num(f.n))
        is Frequency.Calendar -> case("calendar", calendarJson(f.rule))
        is Frequency.AfterCompletion -> case("afterCompletion", num(f.n), JsonPrimitive(f.unit.key))
    }

    fun frequency(e: JsonElement): Frequency? {
        val o = e as? JsonObject ?: return null
        val (name, payload) = o.entries.singleOrNull() ?: return null
        val p = payload as? JsonObject ?: return null
        fun int(k: String) = p.int(k)
        fun ints(k: String) = (p[k] as? JsonArray)?.mapNotNull { (it as? JsonPrimitive)?.intOrNull }?.toSet()
        return when (name) {
            "daily" -> Frequency.Daily
            "weekdays" -> Frequency.Weekdays(ints("_0") ?: return null)
            "everyNDays" -> Frequency.EveryNDays(int("_0") ?: return null)
            "everyNWeeks" -> Frequency.EveryNWeeks(int("_0") ?: return null)
            "monthDates" -> Frequency.MonthDates(ints("_0") ?: return null)
            "perWeek" -> Frequency.PerWeek(int("_0") ?: return null)
            "perMonth" -> Frequency.PerMonth(int("_0") ?: return null)
            "perYear" -> Frequency.PerYear(int("_0") ?: return null)
            "flexible" -> Frequency.Flexible(GoalPeriod.of(p.str("_0") ?: "") ?: return null, int("_1") ?: return null)
            "calendar" -> Frequency.Calendar(calendar(p["_0"] as? JsonObject ?: return null) ?: return null)
            "afterCompletion" -> Frequency.AfterCompletion(int("_0") ?: return null, GoalPeriod.of(p.str("_1") ?: "") ?: return null)
            else -> null
        }
    }

    private fun calendarJson(r: CalendarRule) = obj(
        "unit" to JsonPrimitive(r.unit.key), "interval" to num(r.interval), "weekdays" to ints(r.weekdays),
        "dates" to ints(r.dates), "pattern" to JsonPrimitive(r.pattern), "ordinal" to num(r.ordinal), "weekday" to num(r.weekday),
        "month" to num(r.month), "day" to num(r.day), "useLastDay" to JsonPrimitive(r.useLastDay),
        "anchorWeekStart" to num(r.anchorWeekStart),
    )

    private fun calendar(o: JsonObject): CalendarRule? {
        fun ints(k: String) = (o[k] as? JsonArray)?.mapNotNull { (it as? JsonPrimitive)?.intOrNull }?.toSet()
        // Swift's decoder needs every field: a rule missing one isn't read at all.
        return CalendarRule(
            unit = GoalPeriod.of(o.str("unit") ?: return null) ?: return null,
            interval = o.int("interval") ?: return null,
            weekdays = ints("weekdays") ?: return null,
            dates = ints("dates") ?: return null,
            pattern = o.str("pattern")?.takeIf { it in setOf("Dates", "Last day", "Weekday") } ?: return null,
            ordinal = o.int("ordinal") ?: return null,
            weekday = o.int("weekday") ?: return null,
            month = o.int("month") ?: return null,
            day = o.int("day") ?: return null,
            useLastDay = (o["useLastDay"] as? JsonPrimitive)?.booleanOrNull ?: return null,
            anchorWeekStart = o.int("anchorWeekStart") ?: return null,
        )
    }

    // ------------------------------------------------------------------ Goal history, pauses, times of day, groups

    fun kindJson(k: HabitKind): JsonObject = when (k) {
        is HabitKind.Amount -> obj(k.storageName to obj("unit" to JsonPrimitive(k.unit), "increment" to JsonPrimitive(k.increment)))
        else -> obj(k.storageName to JsonObject(emptyMap()))
    }

    fun kind(e: JsonElement?): HabitKind? {
        val o = e as? JsonObject ?: return null
        val (name, payload) = o.entries.singleOrNull() ?: return null
        return when (name) {
            "check" -> HabitKind.Check
            "amount" -> {
                val p = payload as? JsonObject ?: return null
                HabitKind.Amount(p.str("unit") ?: "", (p["increment"] as? JsonPrimitive)?.doubleOrNull ?: 1.0)
            }
            "duration" -> HabitKind.Duration
            "checklist" -> HabitKind.Checklist
            "quit" -> HabitKind.Quit
            "task" -> HabitKind.Task
            else -> null
        }
    }

    fun rules(list: List<HabitRule>): String = JsonArray(list.map { r ->
        val fields = linkedMapOf<String, JsonElement>(
            "until" to day(r.until), "goal" to JsonPrimitive(r.goal), "frequency" to frequencyJson(r.frequency),
            "kind" to kindJson(r.kind),
            "steps" to JsonArray(r.steps.map { obj("id" to JsonPrimitive(it.id), "name" to JsonPrimitive(it.name)) }),
        )
        r.checkUnit?.let { fields["checkUnit"] = JsonPrimitive(it) }
        JsonObject(fields)
    }).toString()

    fun rules(text: String): List<HabitRule>? = (parse(text) as? JsonArray)?.map { e ->
        val o = e as? JsonObject ?: return null
        HabitRule(
            until = day(o["until"]) ?: return null,
            goal = (o["goal"] as? JsonPrimitive)?.doubleOrNull ?: return null,
            frequency = frequency(o["frequency"] ?: return null) ?: return null,
            kind = kind(o["kind"]) ?: return null,
            checkUnit = o.str("checkUnit"),
            steps = (o["steps"] as? JsonArray)?.mapNotNull { s ->
                val so = s as? JsonObject ?: return@mapNotNull null
                Step(so.str("id") ?: return@mapNotNull null, so.str("name") ?: "")
            } ?: return null,
        )
    }

    fun pauses(list: List<HabitPause>): String = JsonArray(list.map { p ->
        val fields = linkedMapOf<String, JsonElement>("from" to day(p.from), "pausedAt" to moment(p.pausedAt))
        p.through?.let { fields["through"] = day(it) }
        p.resumedAt?.let { fields["resumedAt"] = moment(it) }
        JsonObject(fields)
    }).toString()

    fun pauses(text: String): List<HabitPause>? = (parse(text) as? JsonArray)?.map { e ->
        val o = e as? JsonObject ?: return null
        HabitPause(day(o["from"]) ?: return null, day(o["through"]), moment(o["pausedAt"]) ?: return null, moment(o["resumedAt"]))
    }

    fun sections(list: List<DaySection>): String = JsonArray(list.map { s ->
        val fields = linkedMapOf<String, JsonElement>("id" to JsonPrimitive(s.id), "name" to JsonPrimitive(s.name))
        s.start?.let { fields["start"] = num(it) }
        s.end?.let { fields["end"] = num(it) }
        JsonObject(fields)
    }).toString()

    fun sections(text: String): List<DaySection>? = (parse(text) as? JsonArray)?.map { e ->
        val o = e as? JsonObject ?: return null
        DaySection(o.str("id") ?: return null, o.str("name") ?: return null, o.int("start"), o.int("end"))
    }

    fun strings(list: List<String>): String = JsonArray(list.map { JsonPrimitive(it) }).toString()
    fun strings(text: String): List<String>? = (parse(text) as? JsonArray)?.mapNotNull { (it as? JsonPrimitive)?.contentOrNull }

    fun groups(list: List<HabitGroup>): String = JsonArray(list.map { g ->
        obj("id" to JsonPrimitive(g.id), "name" to JsonPrimitive(g.name), "color" to JsonPrimitive(g.color.key),
            "habits" to JsonArray(g.habits.map { JsonPrimitive(it) }))
    }).toString()

    fun groups(text: String): List<HabitGroup>? = (parse(text) as? JsonArray)?.map { e ->
        val o = e as? JsonObject ?: return null
        HabitGroup(o.str("id") ?: return null, o.str("name") ?: return null, HabitColor.of(o.str("color") ?: "") ?: HabitColor.BLUE,
            (o["habits"] as? JsonArray)?.mapNotNull { (it as? JsonPrimitive)?.contentOrNull } ?: emptyList())
    }

    fun cost(c: HabitCost): String = obj("amount" to JsonPrimitive(c.amount), "currency" to JsonPrimitive(c.currency)).toString()
    fun cost(text: String): HabitCost? {
        val o = parse(text) as? JsonObject ?: return null
        return HabitCost((o["amount"] as? JsonPrimitive)?.doubleOrNull ?: return null, o.str("currency") ?: return null)
    }

    // ------------------------------------------------------------------ Helpers

    private fun case(name: String, vararg values: JsonElement): JsonObject =
        obj(name to JsonObject(values.withIndex().associate { (i, v) -> "_$i" to v }))

    private fun obj(vararg pairs: Pair<String, JsonElement>) = JsonObject(linkedMapOf(*pairs))
    private fun num(n: Int) = JsonPrimitive(n)
    private fun ints(set: Set<Int>) = JsonArray(set.sorted().map { JsonPrimitive(it) })
    private fun JsonObject.int(k: String) = (this[k] as? JsonPrimitive)?.takeIf { it !is JsonNull }?.intOrNull
    private fun JsonObject.str(k: String) = (this[k] as? JsonPrimitive)?.takeIf { it !is JsonNull }?.contentOrNull
}
