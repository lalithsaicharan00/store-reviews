package app.habits.core

import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.intOrNull
import kotlinx.serialization.json.jsonArray
import kotlinx.serialization.json.longOrNull

/**
 * One saved version of one Google Drive sync file (a year of logs, or "base": habits, steps, times, settings and
 * notes). Made and checked like the backup file and the Watch's first fill ([BackupFile], [PeerFill]): a small zip of
 * `manifest.json` (what it is, which file, which version, how many records, their SHA-256) and `records.json`,
 * deflated, every record whole with every field's sync stamp, so merging it is exactly as if each change had arrived
 * on its own (SyncRules.mergeRecord).
 */
internal object DriveSnapshot {
    const val KIND = "often-enough-drive"
    /** The layout's version. A newer one is never read half-way, and never written over (DriveSync blocks the file). */
    const val FORMAT = 1
    const val MANIFEST = "manifest.json"
    const val RECORDS = "records.json"

    class Contents(val chain: String, val seq: Long, val rows: List<PeerFill.Row>)

    fun write(chain: String, seq: Long, rows: List<PeerFill.Row>, by: String, now: Long): ByteArray {
        val records = PeerFill.encodeRows(rows)
        val manifest = JsonObject(buildMap {
            put("kind", JsonPrimitive(KIND))
            put("format", JsonPrimitive(FORMAT))
            put("schema", JsonPrimitive(HabitRepository.SCHEMA_VERSION))
            put("chain", JsonPrimitive(chain))
            put("seq", JsonPrimitive(seq))
            put("by", JsonPrimitive(by))
            put("createdAt", JsonPrimitive(now))
            put("count", JsonPrimitive(rows.size))
            put("sha256", JsonPrimitive(Sha256.hex(records)))
            put("bytes", JsonPrimitive(records.size))
        }).toString().encodeToByteArray()
        return Zip.write(listOf(Zip.Entry(MANIFEST, manifest), Zip.Entry(RECORDS, records, deflate = true)), now)
    }

    /** Checks a file completely before anything is merged. Any mismatch is a [BackupProblem]; a newer layout is
     *  [BackupProblem.NEWER_VERSION]. */
    fun read(bytes: ByteArray): Contents {
        val files = try { Zip.read(bytes).files } catch (e: BackupProblem) { throw e } catch (_: Exception) { throw BackupProblem(BackupProblem.DAMAGED) }
        val manifest = files[MANIFEST]?.let { runCatching { Json.parseToJsonElement(it.decodeToString()) as? JsonObject }.getOrNull() }
            ?: throw BackupProblem(BackupProblem.DAMAGED)
        if ((manifest["kind"] as? JsonPrimitive)?.content != KIND) throw BackupProblem(BackupProblem.NOT_A_BACKUP)
        val format = (manifest["format"] as? JsonPrimitive)?.intOrNull ?: throw BackupProblem(BackupProblem.DAMAGED)
        if (format > FORMAT) throw BackupProblem(BackupProblem.NEWER_VERSION)
        val data = files[RECORDS] ?: throw BackupProblem(BackupProblem.DAMAGED)
        if ((manifest["sha256"] as? JsonPrimitive)?.content != Sha256.hex(data)) throw BackupProblem(BackupProblem.DAMAGED)
        val list = runCatching { Json.parseToJsonElement(data.decodeToString()).jsonArray }.getOrNull() ?: throw BackupProblem(BackupProblem.DAMAGED)
        if ((manifest["count"] as? JsonPrimitive)?.longOrNull != list.size.toLong()) throw BackupProblem(BackupProblem.DAMAGED)
        val chain = (manifest["chain"] as? JsonPrimitive)?.content ?: throw BackupProblem(BackupProblem.DAMAGED)
        val seq = (manifest["seq"] as? JsonPrimitive)?.longOrNull ?: throw BackupProblem(BackupProblem.DAMAGED)
        return Contents(chain, seq, PeerFill.decodeRows(list))
    }
}
