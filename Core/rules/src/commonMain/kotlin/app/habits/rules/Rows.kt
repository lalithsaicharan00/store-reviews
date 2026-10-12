package app.habits.rules

import kotlin.io.encoding.Base64
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.booleanOrNull
import kotlinx.serialization.json.doubleOrNull
import kotlinx.serialization.json.intOrNull
import kotlinx.serialization.json.jsonArray
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive

/**
 * The saved rows the rules read, field for field as `Core`'s records (and the backup file) name them, and how they become
 * [HabitData] (spec/README.md "Reading saved data"). Settings are read exactly as the iPhone saves them: plain text for
 * skips, moved task days, archive days and timers; Swift's JSON for pauses, goal history, times of day and Today's order.
 */
object Rows {
    class HabitRow(
        val id: String, val kind: String, val unit: String?, val increment: Double, val part: String, val goal: Double,
        val frequency: String, val dueDay: String?, val atMost: Boolean, val quitSince: Long?, val position: Int,
        val createdAt: Long, val archivedAt: Long?, val startsOn: String?, val endsOn: String?, val deletedAt: Long? = null,
    )
    class StepRow(val id: String, val habitId: String, val position: Int, val deletedAt: Long? = null)
    class ReminderRow(val id: String, val habitId: String, val hour: Int, val minute: Int, val deletedAt: Long? = null)
    class EntryRow(
        val id: String, val habitId: String, val stepId: String?, val day: String, val value: Double, val createdAt: Long,
        val timeZone: String, val slot: String?, val deletedAt: Long? = null,
    )

    /** Seconds from 1970 to Swift's reference date (1 January 2001), for the moments in the iPhone's JSON. */
    private const val APPLE_EPOCH = 978_307_200.0

    /**
     * The rules' data from the saved rows, as the iPhone's `HabitStore.load` reads them. [defaultWeekStart] is the week
     * start when the person never chose one (the phone's region). [window]: the Apple Watch reads only its last days of
     * logs (spec/streaks.md ST-6); the caller passes the rows it read.
     */
    fun load(
        habits: List<HabitRow>, steps: List<StepRow>, reminders: List<ReminderRow>, entries: List<EntryRow>,
        settings: Map<String, String>, timeZone: String, defaultWeekStart: Int,
    ): Pair<HabitData, DaySettings> {
        val liveSteps = steps.filter { it.deletedAt == null }.sortedBy { it.position }.groupBy { it.habitId }
        val liveTimes = reminders.filter { it.deletedAt == null }.sortedWith(compareBy({ it.hour }, { it.minute })).groupBy { it.habitId }
        val list = habits.filter { it.deletedAt == null }.sortedWith(compareBy({ it.position }, { it.createdAt }))
            .mapNotNull { habit(it, liveSteps[it.id] ?: emptyList(), liveTimes[it.id] ?: emptyList()) }
        val ids = list.map { it.id }.toSet()
        val logs = entries.filter { it.deletedAt == null && it.habitId in ids }.sortedBy { it.createdAt }.mapNotNull { e ->
            val day = Day.parse(e.day) ?: return@mapNotNull null
            Entry(e.id, e.habitId, e.stepId, day, e.value, e.createdAt, e.timeZone, e.slot)
        }

        var dayEnd = 0
        var weekStart = defaultWeekStart
        val skips = HashMap<String, Set<Int>>()
        val moves = HashMap<String, Map<Int, Int>>()
        val pauses = HashMap<String, List<Pause>>()
        val rules = HashMap<String, List<PastRule>>()
        val archived = HashMap<String, Int>()
        val timers = HashMap<String, Long>()
        var sections = DaySection.defaults
        var cardOrder = emptyList<String>()
        for ((key, value) in settings) {
            when {
                key == "day_end_hour" -> dayEnd = (value.toIntOrNull() ?: 0).coerceIn(0, 12)
                key == "week_start" -> value.toIntOrNull()?.takeIf { it in 1..7 }?.let { weekStart = it }
                key == "day_sections" -> parseSections(value)?.takeIf { it.isNotEmpty() }?.let { sections = it }
                key == "today_order" -> cardOrder = json(value)?.let { (it as? JsonArray)?.mapNotNull { e -> (e as? JsonPrimitive)?.content } } ?: emptyList()
                key.startsWith("archived.") -> Day.parse(value)?.let { archived[key.removePrefix("archived.")] = it }
                key.startsWith("rules.") -> parseRules(value)?.let { rules[key.removePrefix("rules.")] = it.sortedBy { r -> r.until } }
                key.startsWith("pause.") -> parsePauses(value)?.takeIf { it.isNotEmpty() }?.let { pauses[key.removePrefix("pause.")] = it }
                key.startsWith("move.") -> {
                    val m = LinkedHashMap<Int, Int>()
                    for (pair in value.split(",")) {
                        val days = pair.split(">").mapNotNull { Day.parse(it) }
                        if (days.size == 2) m[days[0]] = days[1]
                    }
                    if (m.isNotEmpty()) moves[key.removePrefix("move.")] = m
                }
                key.startsWith("skip.") -> {
                    val days = value.split(",").mapNotNull { Day.parse(it) }.toSet()
                    if (days.isNotEmpty()) skips[key.removePrefix("skip.")] = days
                }
                key.startsWith("timer.") -> value.split("|").first().toLongOrNull()?.let { timers[key.removePrefix("timer.")] = it }
            }
        }
        val zone = Zone(timeZone)
        // Habits archived before archive days were kept: the day after their last log, or their first day.
        for (h in list) {
            if (!h.archived || archived.containsKey(h.id)) continue
            val last = logs.filter { it.habitId == h.id }.maxOfOrNull { it.day }
            archived[h.id] = last?.let { it + 1 } ?: (h.startsOn ?: zone.dayOf(h.createdAt))
        }
        val archivedOn = archived.filterKeys { id -> list.any { it.id == id && it.archived } }
        val data = HabitData(list, logs, skips, moves, pauses, rules, archivedOn, timers, sections, cardOrder)
        return data to DaySettings(dayEnd, weekStart.coerceIn(1, 7), timeZone)
    }

    /** One habit row, or null for one this version can't read (an unknown kind or schedule). */
    fun habit(r: HabitRow, steps: List<StepRow>, reminders: List<ReminderRow>): Habit? {
        val kind = Kind.parse(r.kind) ?: return null
        val frequency = frequency(r.frequency) ?: return null
        val unit = when (kind) {
            Kind.AMOUNT -> r.unit ?: ""
            Kind.CHECK -> r.unit?.takeIf { it.isNotEmpty() && it != "times" }
            else -> null
        }
        val parts = r.part.split(",").map { it.trim() }.filter { it.isNotEmpty() }.ifEmpty { listOf(DaySection.ANYTIME) }
        return Habit(
            id = r.id, judging = Judging(kind, r.goal, frequency, unit, if (kind == Kind.AMOUNT) r.increment else 1.0, steps.map { it.id }),
            atMost = r.atMost, parts = parts, times = reminders.map { it.hour * 60 + it.minute }, dueDay = Day.parse(r.dueDay),
            startsOn = Day.parse(r.startsOn), endsOn = Day.parse(r.endsOn), quitSince = r.quitSince, createdAt = r.createdAt,
            archived = r.archivedAt != null, position = r.position,
        )
    }

    /** The database's schedule (`daily`, `weekdays:2,4,6`, `every:3`, …, or `v2:` and base64 JSON). */
    fun frequency(key: String): Frequency? {
        if (key.startsWith("v2:")) {
            val text = try { Base64.decode(key.removePrefix("v2:")).decodeToString() } catch (_: Exception) { return null }
            return frequencyJson(json(text) ?: return null)
        }
        if (key.isEmpty()) return null
        val name = key.substringBefore(":")
        val value = key.substringAfter(":", "")
        fun numbers() = value.split(",").mapNotNull { it.toIntOrNull() }.toSet()
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

    /** Swift's synthesized JSON for an enum case with values: `{"flexible":{"_0":"week","_1":3}}`. */
    fun frequencyJson(e: JsonElement): Frequency? {
        val obj = e as? JsonObject ?: return null
        val (case, payload) = obj.entries.singleOrNull() ?: return null
        val p = payload as? JsonObject ?: return null
        fun int(k: String) = (p[k] as? JsonPrimitive)?.intOrNull
        fun ints(k: String) = (p[k] as? JsonArray)?.mapNotNull { (it as? JsonPrimitive)?.intOrNull }?.toSet()
        return when (case) {
            "daily" -> Frequency.Daily
            "weekdays" -> Frequency.Weekdays(ints("_0") ?: return null)
            "everyNDays" -> Frequency.EveryNDays(int("_0") ?: return null)
            "everyNWeeks" -> Frequency.EveryNWeeks(int("_0") ?: return null)
            "monthDates" -> Frequency.MonthDates(ints("_0") ?: return null)
            "perWeek" -> Frequency.PerWeek(int("_0") ?: return null)
            "perMonth" -> Frequency.PerMonth(int("_0") ?: return null)
            "perYear" -> Frequency.PerYear(int("_0") ?: return null)
            "flexible" -> Frequency.Flexible(Period.parse((p["_0"] as? JsonPrimitive)?.content ?: "") ?: return null, int("_1") ?: return null)
            "calendar" -> Frequency.Calendar(calendar(p["_0"] as? JsonObject ?: return null) ?: return null)
            "afterCompletion" -> Frequency.AfterCompletion(int("_0") ?: return null, Period.parse((p["_1"] as? JsonPrimitive)?.content ?: "") ?: return null)
            else -> null
        }
    }

    private fun calendar(o: JsonObject): CalendarSchedule? {
        fun int(k: String) = (o[k] as? JsonPrimitive)?.intOrNull
        fun ints(k: String) = (o[k] as? JsonArray)?.mapNotNull { (it as? JsonPrimitive)?.intOrNull }?.toSet()
        // Swift's decoder needs every field: a rule missing one isn't read at all.
        return CalendarSchedule(
            unit = Period.parse((o["unit"] as? JsonPrimitive)?.content ?: return null) ?: return null,
            interval = int("interval") ?: return null,
            weekdays = ints("weekdays") ?: return null,
            dates = ints("dates") ?: return null,
            pattern = (o["pattern"] as? JsonPrimitive)?.content?.takeIf { it in setOf("Dates", "Last day", "Weekday") } ?: return null,
            ordinal = int("ordinal") ?: return null,
            weekday = int("weekday") ?: return null,
            month = int("month") ?: return null,
            day = int("day") ?: return null,
            useLastDay = (o["useLastDay"] as? JsonPrimitive)?.booleanOrNull ?: return null,
            anchorWeekStart = int("anchorWeekStart") ?: return null,
        )
    }

    private fun localDay(e: JsonElement?): Int? {
        val o = e as? JsonObject ?: return null
        fun int(k: String) = (o[k] as? JsonPrimitive)?.intOrNull
        return Day.of(int("year") ?: return null, int("month") ?: return null, int("day") ?: return null)
    }

    private fun moment(e: JsonElement?): Long? =
        (e as? JsonPrimitive)?.doubleOrNull?.let { kotlin.math.round((it + APPLE_EPOCH) * 1000).toLong() }

    /** `[HabitPause]`: `{"from":{…},"through":{…},"pausedAt":812345678.9,"resumedAt":…}`. */
    fun parsePauses(text: String): List<Pause>? = (json(text) as? JsonArray)?.map { e ->
        val o = e.jsonObject
        Pause(localDay(o["from"]) ?: return null, localDay(o["through"]), moment(o["pausedAt"]) ?: return null, moment(o["resumedAt"]))
    }

    /** `[HabitRule]`: what judged the habit until a day. */
    fun parseRules(text: String): List<PastRule>? = (json(text) as? JsonArray)?.map { e ->
        val o = e.jsonObject
        val until = localDay(o["until"]) ?: return null
        val kindObj = o["kind"] as? JsonObject ?: return null
        val (kindName, payload) = kindObj.entries.singleOrNull() ?: return null
        val kind = Kind.parse(kindName) ?: return null
        val frequency = frequencyJson(o["frequency"] ?: return null) ?: return null
        val checkUnit = (o["checkUnit"] as? JsonPrimitive)?.content
        val unit = if (kind == Kind.AMOUNT) (payload.jsonObject["unit"] as? JsonPrimitive)?.content ?: "" else if (kind == Kind.CHECK) checkUnit else null
        val increment = if (kind == Kind.AMOUNT) (payload.jsonObject["increment"] as? JsonPrimitive)?.doubleOrNull ?: 1.0 else 1.0
        val steps = (o["steps"] as? JsonArray)?.mapNotNull { (it as? JsonObject)?.get("id")?.jsonPrimitive?.content } ?: return null
        val goal = (o["goal"] as? JsonPrimitive)?.doubleOrNull ?: return null
        PastRule(until, Judging(kind, goal, frequency, unit, increment, steps))
    }

    /** `[DaySection]`: `{"id":"morning","name":"Morning","start":360}`. */
    fun parseSections(text: String): List<DaySection>? = (json(text) as? JsonArray)?.map { e ->
        val o = e.jsonObject
        DaySection(o["id"]?.jsonPrimitive?.content ?: return null, o["name"]?.jsonPrimitive?.content ?: return null,
            (o["start"] as? JsonPrimitive)?.intOrNull, (o["end"] as? JsonPrimitive)?.intOrNull)
    }

    private fun json(text: String): JsonElement? = try { Json.parseToJsonElement(text) } catch (_: Exception) { null }

    @Suppress("unused")
    private fun JsonElement.arrayOrEmpty() = (this as? JsonArray) ?: JsonArray(emptyList())
}
