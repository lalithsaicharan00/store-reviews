package app.habits.core

import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonNull
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.booleanOrNull
import kotlinx.serialization.json.doubleOrNull
import kotlinx.serialization.json.longOrNull

/**
 * Rows as sync fields (column name → value), and back. Every synced table goes through here, so the apps and the
 * server see the same field names as the database's columns. A record that's missing a required field can't be
 * built yet (`decode` returns null); sync then keeps its fields aside until the rest arrives.
 */
internal object SyncCodec {
    const val HABIT = "habit"
    const val STEP = "step"
    const val REMINDER = "reminder"
    const val ENTRY = "entry"
    const val SETTING = "setting"

    /** Settings that only make sense on this device (one-off local repairs); they never sync. */
    fun isLocalSetting(key: String): Boolean = key == "placement_v1" || key == "placement_v2"

    private fun s(v: String?): JsonElement = v?.let(::JsonPrimitive) ?: JsonNull
    private fun n(v: Number?): JsonElement = v?.let(::JsonPrimitive) ?: JsonNull
    private fun b(v: Boolean): JsonElement = JsonPrimitive(v)

    fun habit(h: HabitRecord): Map<String, JsonElement> = mapOf(
        "name" to s(h.name), "symbol" to s(h.symbol), "color" to s(h.color), "kind" to s(h.kind), "unit" to s(h.unit),
        "increment" to n(h.increment), "part" to s(h.part), "goal" to n(h.goal), "period" to s(h.period),
        "schedule_days" to s(h.scheduleDays), "frequency" to s(h.frequency), "due_day" to s(h.dueDay),
        "due_minute" to n(h.dueMinute), "at_most" to b(h.atMost), "quit_since" to n(h.quitSince), "position" to n(h.position),
        "created_at" to n(h.createdAt), "updated_at" to n(h.updatedAt), "archived_at" to n(h.archivedAt),
        "deleted_at" to n(h.deletedAt), "remind" to b(h.remind), "alert" to s(h.alert),
        "follow_up_minutes" to n(h.followUpMinutes), "starts_on" to s(h.startsOn), "ends_on" to s(h.endsOn),
    )

    fun step(x: StepRecord): Map<String, JsonElement> = mapOf(
        "habit_id" to s(x.habitId), "name" to s(x.name), "position" to n(x.position), "deleted_at" to n(x.deletedAt),
    )

    fun reminder(x: ReminderRecord): Map<String, JsonElement> = mapOf(
        "habit_id" to s(x.habitId), "hour" to n(x.hour), "minute" to n(x.minute), "deleted_at" to n(x.deletedAt),
    )

    fun entry(x: EntryRecord): Map<String, JsonElement> = mapOf(
        "habit_id" to s(x.habitId), "step_id" to s(x.stepId), "day" to s(x.day), "value" to n(x.value),
        "created_at" to n(x.createdAt), "time_zone" to s(x.timeZone), "deleted_at" to n(x.deletedAt), "slot" to s(x.slot),
        "source" to s(x.source),
    )

    fun setting(x: SettingRecord): Map<String, JsonElement> = mapOf("value" to s(x.value))

    /** The fields each table stores in its own columns; anything else is kept in `sync_meta.extra`. */
    val knownFields: Map<String, Set<String>> = mapOf(
        HABIT to habit(HabitRecord("", "", "", "", "", null, 0.0, "", 0.0, "", null, "", null, null, false, null, 0, 0, 0, null, null)).keys,
        STEP to step(StepRecord("", "", "", 0, null)).keys,
        REMINDER to reminder(ReminderRecord("", "", 0, 0, null)).keys,
        ENTRY to entry(EntryRecord("", "", null, "", 0.0, 0, "", null, null)).keys,
        SETTING to setOf("value"),
    )

    // Decoding. `req*` returns null when a required field is missing or the wrong type; `opt*` allows null.

    private class Missing : Exception()

    private fun Map<String, JsonElement>.str(k: String): String = (this[k] as? JsonPrimitive)?.takeIf { it.isString }?.content ?: throw Missing()
    private fun Map<String, JsonElement>.optStr(k: String): String? = (this[k] as? JsonPrimitive)?.takeIf { it.isString }?.content
    private fun Map<String, JsonElement>.dbl(k: String): Double = (this[k] as? JsonPrimitive)?.takeIf { !it.isString }?.doubleOrNull ?: throw Missing()
    private fun Map<String, JsonElement>.lng(k: String): Long = (this[k] as? JsonPrimitive)?.takeIf { !it.isString }?.let { it.longOrNull ?: it.doubleOrNull?.toLong() } ?: throw Missing()
    private fun Map<String, JsonElement>.optLng(k: String): Long? = (this[k] as? JsonPrimitive)?.takeIf { !it.isString }?.let { it.longOrNull ?: it.doubleOrNull?.toLong() }
    private fun Map<String, JsonElement>.bool(k: String, default: Boolean? = null): Boolean =
        (this[k] as? JsonPrimitive)?.takeIf { !it.isString }?.booleanOrNull ?: default ?: throw Missing()

    private inline fun <T> orNull(build: () -> T): T? = try { build() } catch (_: Missing) { null }

    fun decodeHabit(id: String, f: Map<String, JsonElement>): HabitRecord? = orNull {
        HabitRecord(
            id = id, name = f.str("name"), symbol = f.str("symbol"), color = f.str("color"), kind = f.str("kind"),
            unit = f.optStr("unit"), increment = f.dbl("increment"), part = f.str("part"), goal = f.dbl("goal"),
            period = f.optStr("period") ?: "day", scheduleDays = f.optStr("schedule_days"),
            frequency = f.optStr("frequency") ?: "daily", dueDay = f.optStr("due_day"), dueMinute = f.optLng("due_minute")?.toInt(),
            atMost = f.bool("at_most", default = false), quitSince = f.optLng("quit_since"), position = f.lng("position").toInt(),
            createdAt = f.lng("created_at"), updatedAt = f.optLng("updated_at") ?: f.lng("created_at"),
            archivedAt = f.optLng("archived_at"), deletedAt = f.optLng("deleted_at"),
            remind = f.bool("remind", default = true), alert = f.optStr("alert") ?: "notification",
            followUpMinutes = f.optLng("follow_up_minutes")?.toInt(), startsOn = f.optStr("starts_on"), endsOn = f.optStr("ends_on"),
        )
    }

    fun decodeStep(id: String, f: Map<String, JsonElement>): StepRecord? = orNull {
        StepRecord(id, f.str("habit_id"), f.str("name"), f.lng("position").toInt(), f.optLng("deleted_at"))
    }

    fun decodeReminder(id: String, f: Map<String, JsonElement>): ReminderRecord? = orNull {
        ReminderRecord(id, f.str("habit_id"), f.lng("hour").toInt(), f.lng("minute").toInt(), f.optLng("deleted_at"))
    }

    fun decodeEntry(id: String, f: Map<String, JsonElement>): EntryRecord? = orNull {
        EntryRecord(
            id = id, habitId = f.str("habit_id"), stepId = f.optStr("step_id"), day = f.str("day"), value = f.dbl("value"),
            createdAt = f.lng("created_at"), timeZone = f.str("time_zone"), deletedAt = f.optLng("deleted_at"), slot = f.optStr("slot"),
            source = f.optStr("source"),
        )
    }
}
