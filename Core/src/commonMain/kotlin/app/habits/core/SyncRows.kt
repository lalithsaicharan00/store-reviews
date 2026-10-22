package app.habits.core

import app.habits.sync.Hlc
import app.habits.sync.SyncRecord
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive

/**
 * Whole records with every field's sync stamp, as JSON: how Google Drive's year files carry their records
 * ([DriveSnapshot]). Merging them is exactly as if every change had arrived one by one, so a change made since on any
 * device still wins over the copy.
 */
object SyncRows {
    private val TABLE = Regex("[a-z][a-z0-9_]{0,31}")

    internal class Row(val table: String, val row: String, val record: SyncRecord)

    /** Whole records with every field's stamp, as JSON: the stamp most fields share, and the exceptions. Google Drive's
     *  year files carry their records the same way (DriveSnapshot). */
    internal fun encodeRows(rows: List<Row>): ByteArray = JsonArray(rows.map { row ->
        val base = row.record.clocks.values.groupingBy { it }.eachCount().maxByOrNull { it.value }?.key ?: ""
        val exceptions = row.record.clocks.filterValues { it != base }
        JsonObject(buildMap {
            put("t", JsonPrimitive(row.table))
            put("r", JsonPrimitive(row.row))
            put("h", JsonPrimitive(base))
            if (exceptions.isNotEmpty()) put("x", JsonObject(exceptions.mapValues { JsonPrimitive(it.value) }))
            put("f", JsonObject(row.record.fields))
        })
    }).toString().encodeToByteArray()

    /** [encodeRows]' records back. Any mismatch is a [BackupProblem]. */
    internal fun decodeRows(list: JsonArray): List<Row> = list.map { element ->
        val o = element as? JsonObject ?: throw BackupProblem(BackupProblem.DAMAGED)
        val table = (o["t"] as? JsonPrimitive)?.content ?: throw BackupProblem(BackupProblem.DAMAGED)
        val row = (o["r"] as? JsonPrimitive)?.content ?: throw BackupProblem(BackupProblem.DAMAGED)
        val base = (o["h"] as? JsonPrimitive)?.content ?: throw BackupProblem(BackupProblem.DAMAGED)
        val exceptions = (o["x"] as? JsonObject)?.mapValues { (it.value as? JsonPrimitive)?.content ?: throw BackupProblem(BackupProblem.DAMAGED) } ?: emptyMap()
        val fields = o["f"] as? JsonObject ?: throw BackupProblem(BackupProblem.DAMAGED)
        if (!TABLE.matches(table) || row.isEmpty() || row.length > 128) throw BackupProblem(BackupProblem.DAMAGED)
        val clocks = fields.keys.associateWith { exceptions[it] ?: base }
        if (clocks.values.any { !Hlc.isValid(it) } || fields.values.any { it !is JsonPrimitive }) throw BackupProblem(BackupProblem.DAMAGED)
        Row(table, row, SyncRecord(fields, clocks))
    }
}

/**
 * The ID of the log a timer's stop writes: made from the habit and the timer's start time, so the same timer stopped on
 * two devices (offline, or within a second) is one log, never its time counted twice. Every platform makes the same ID
 * from the same timer.
 */
object TimerStop {
    fun entryId(habitId: String, startMillis: Long): String {
        val hash = Sha256.digest("often-enough.timer-stop|${habitId.lowercase()}|$startMillis".encodeToByteArray()).copyOf(16)
        hash[6] = ((hash[6].toInt() and 0x0f) or 0x50).toByte() // version 5 (name-based)
        hash[8] = ((hash[8].toInt() and 0x3f) or 0x80).toByte() // RFC 4122 variant
        val hex = hash.joinToString("") { (it.toInt() and 0xff).toString(16).padStart(2, '0') }
        return "${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20, 32)}".uppercase()
    }
}
