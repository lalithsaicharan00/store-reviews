package app.habits.core

import app.habits.sync.Hlc
import app.habits.sync.SyncRecord
import kotlin.io.encoding.Base64
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.intOrNull
import kotlinx.serialization.json.jsonArray
import kotlinx.serialization.json.jsonPrimitive
import kotlinx.serialization.json.longOrNull

/**
 * The Apple Watch's first fill from its iPhone (Architecture 12 §3.1 step 1), one checked part at a time.
 *
 * A part is a small zip, made and checked like the backup file ([BackupFile]): `manifest.json` (what it is, which part,
 * how many records, the SHA-256 of the records) and `records.json`, deflated. Unlike a backup file it carries every
 * field's sync stamp, so merging it is exactly as if every change had arrived one by one: a change made on either device
 * while the fill travels still wins. Restoring a backup file instead would stamp every row anew on the Watch, and the
 * copy would then overwrite edits made on the iPhone in the meantime (10 Oct 2026, why Architecture 12 changed).
 *
 * Parts are small (a few thousand records) so the Watch checks and merges each one in its own transaction, with little
 * memory, and a fill cut off half-way resumes from the last part that arrived ([PeerStatus.fillCursor]).
 */
object PeerFill {
    const val KIND = "often-enough-peer-fill"
    const val FORMAT = 1
    const val MANIFEST = "manifest.json"
    const val RECORDS = "records.json"
    /** Records per part: an extreme account's logs (25,000 a year) come in parts of about 1 MB deflated. */
    const val DEFAULT_PART = 5_000

    private val TABLE = Regex("[a-z][a-z0-9_]{0,31}")

    internal class Row(val table: String, val row: String, val record: SyncRecord)

    internal class Part(val cursor: String?, val next: String?, val rows: List<Row>)

    /** Where a part starts: the non-log records by (table, row), then logs newest first by (day, id). */
    internal data class Cursor(val phase: String, val a: String, val b: String) {
        fun encode(): String = JsonArray(listOf(JsonPrimitive(phase), JsonPrimitive(a), JsonPrimitive(b))).toString()

        companion object {
            const val META = "m"
            const val ENTRIES = "e"
            /** Sorts after every "YYYY-MM-DD", so the first page of logs starts at the newest. */
            val firstEntries = Cursor(ENTRIES, "~", "")

            fun decode(text: String?): Cursor {
                if (text.isNullOrEmpty()) return Cursor(META, "", "")
                val list = runCatching { Json.parseToJsonElement(text).jsonArray.map { it.jsonPrimitive.content } }.getOrNull()
                if (list == null || list.size != 3 || list[0] !in setOf(META, ENTRIES)) throw BackupProblem(BackupProblem.DAMAGED)
                return Cursor(list[0], list[1], list[2])
            }
        }
    }

    internal fun write(rows: List<Row>, cursor: String?, next: String?, now: Long): PeerFillPart {
        val records = JsonArray(rows.map { row ->
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
        val manifest = JsonObject(buildMap {
            put("kind", JsonPrimitive(KIND))
            put("format", JsonPrimitive(FORMAT))
            put("schema", JsonPrimitive(HabitRepository.SCHEMA_VERSION))
            put("createdAt", JsonPrimitive(now))
            put("cursor", JsonPrimitive(cursor ?: ""))
            next?.let { put("next", JsonPrimitive(it)) }
            put("count", JsonPrimitive(rows.size))
            put("sha256", JsonPrimitive(Sha256.hex(records)))
            put("bytes", JsonPrimitive(records.size))
        }).toString().encodeToByteArray()
        val bytes = Zip.write(listOf(Zip.Entry(MANIFEST, manifest), Zip.Entry(RECORDS, records, deflate = true)), now)
        return PeerFillPart(Base64.encode(bytes), Sha256.hex(bytes), bytes.size, rows.size, cursor, next)
    }

    /** Checks a part completely before anything is merged. Any mismatch is a [BackupProblem]. */
    internal fun read(base64: String): Part {
        val bytes = try { Base64.decode(base64) } catch (_: IllegalArgumentException) { throw BackupProblem(BackupProblem.NOT_A_BACKUP) }
        val files = Zip.read(bytes).files
        val manifest = files[MANIFEST]?.let { runCatching { Json.parseToJsonElement(it.decodeToString()) as? JsonObject }.getOrNull() }
            ?: throw BackupProblem(BackupProblem.NOT_A_BACKUP)
        if ((manifest["kind"] as? JsonPrimitive)?.content != KIND) throw BackupProblem(BackupProblem.NOT_A_BACKUP)
        val format = (manifest["format"] as? JsonPrimitive)?.intOrNull ?: throw BackupProblem(BackupProblem.NOT_A_BACKUP)
        if (format > FORMAT) throw BackupProblem(BackupProblem.NEWER_VERSION)
        val data = files[RECORDS] ?: throw BackupProblem(BackupProblem.DAMAGED)
        if ((manifest["sha256"] as? JsonPrimitive)?.content != Sha256.hex(data)) throw BackupProblem(BackupProblem.DAMAGED)
        val list = runCatching { Json.parseToJsonElement(data.decodeToString()).jsonArray }.getOrNull() ?: throw BackupProblem(BackupProblem.DAMAGED)
        if ((manifest["count"] as? JsonPrimitive)?.longOrNull != list.size.toLong()) throw BackupProblem(BackupProblem.DAMAGED)
        val rows = list.map { element ->
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
        val cursor = (manifest["cursor"] as? JsonPrimitive)?.content?.takeIf { it.isNotEmpty() }
        val next = (manifest["next"] as? JsonPrimitive)?.content?.takeIf { it.isNotEmpty() }
        return Part(cursor, next, rows)
    }
}

/** One part of the first fill, ready to send. [next] is null on the last part. */
data class PeerFillPart(
    val base64: String,
    val sha256: String,
    val size: Int,
    val records: Int,
    val cursor: String?,
    val next: String?,
)

/**
 * The ID of the log a timer's stop writes: made from the habit and the timer's start time, so the same timer stopped on
 * the iPhone and on the Watch (offline, or within a second) is one log, never its time counted twice
 * (Architecture 12 §4). Every platform makes the same ID from the same timer.
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
