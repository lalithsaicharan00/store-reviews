package app.habits.core

import kotlin.io.encoding.Base64
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonNull
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.intOrNull
import kotlinx.serialization.json.jsonArray
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive
import kotlinx.serialization.json.longOrNull

/**
 * The checked backup file (Architecture 03 §3.2; format in `Core/Backup File Format.md`): one file that every app
 * version can read, made the same way on every platform, for every place a backup goes (the user's iCloud or Google
 * Drive, our server, "Move to another device", Export).
 *
 * A zip (stored, not compressed, so any unzip tool and any app version can open it) holding:
 * - `manifest.json`: format version, who made it and when, record counts, and the SHA-256 of `data.json`;
 * - `data.json`: every row of every table, deleted ones included (so a deleted habit stays deleted after a restore),
 *   as the same fields sync uses;
 * - `csv/`: one readable CSV per table, for Excel or Numbers. Only in a file made for a person (Save a Backup File,
 *   Move to Another Device, a restore's undo): the automatic backups (iCloud, the account) leave it out, since it repeats
 *   `data.json` and no reader uses it. Same format either way, so every app version imports both (Current Work 75,
 *   Free Plan Backups §7 step 2; Rulebook D5).
 *
 * Reading checks everything before anything is changed: the zip's own checksums, the data's SHA-256, the counts, and
 * that every row can be built. Any mismatch is a [BackupProblem] and nothing is restored (03 §3.6 step 5).
 */
object BackupFile {
    /** Bump only with a new layout; every app version keeps reading every older one (tests keep a sample of each). */
    const val FORMAT = 1
    /**
     * Format 2 (10 Oct 2026, Current Work 75): the automatic backups (iCloud, the account), with `data.json` deflated and
     * no CSV copies, about a tenth of the size (Free Plan Backups §7 step 2). Files made for a person (Save a Backup File,
     * Move to Another Device, a restore's undo) stay format 1, which every app version and any unzip tool opens.
     */
    const val FORMAT_COMPACT = 2
    /** The newest format this version reads. */
    const val NEWEST_FORMAT = FORMAT_COMPACT
    const val MANIFEST = "manifest.json"
    const val DATA = "data.json"

    private val json = Json

    /**
     * Makes the file from every row of [data]. Settings that only make sense on this device are left out. [readable]
     * false makes the compact automatic backup ([FORMAT_COMPACT]): `data.json` deflated, no CSV copies.
     */
    internal fun write(data: Snapshot, info: BackupInfo, now: Long, readable: Boolean = true): BackupFileData {
        val settings = data.settings.filterNot { SyncCodec.isLocalSetting(it.key) }
        val rows: Map<String, List<Pair<String, Map<String, JsonElement>>>> = mapOf(
            SyncCodec.HABIT to data.habits.map { it.id to SyncCodec.habit(it) },
            SyncCodec.STEP to data.steps.map { it.id to SyncCodec.step(it) },
            SyncCodec.REMINDER to data.reminders.map { it.id to SyncCodec.reminder(it) },
            SyncCodec.ENTRY to data.entries.map { it.id to SyncCodec.entry(it) },
            SyncCodec.SETTING to settings.map { it.key to SyncCodec.setting(it) },
        )
        val dataJson = JsonObject(
            rows.mapValues { (_, list) -> JsonArray(list.map { (id, fields) -> JsonObject(mapOf("id" to JsonPrimitive(id)) + fields) }) },
        ).toString().encodeToByteArray()
        val liveHabits = data.habits.count { it.deletedAt == null }
        val liveEntries = data.entries.count { it.deletedAt == null }
        val records = rows.values.sumOf { it.size }
        val manifest = JsonObject(
            mapOf(
                "format" to JsonPrimitive(if (readable) FORMAT else FORMAT_COMPACT),
                "app" to JsonPrimitive("Often Enough"),
                "appVersion" to JsonPrimitive(info.appVersion),
                "platform" to JsonPrimitive(info.platform),
                "deviceName" to JsonPrimitive(info.deviceName),
                "createdAt" to JsonPrimitive(now),
                "schema" to JsonPrimitive(HabitRepository.SCHEMA_VERSION),
                "data" to JsonObject(mapOf("file" to JsonPrimitive(DATA), "sha256" to JsonPrimitive(Sha256.hex(dataJson)), "bytes" to JsonPrimitive(dataJson.size))),
                "counts" to JsonObject(rows.mapValues { JsonPrimitive(it.value.size) }),
                "live" to JsonObject(mapOf("habits" to JsonPrimitive(liveHabits), "entries" to JsonPrimitive(liveEntries))),
            ),
        ).toString().encodeToByteArray()

        val habitNames = data.habits.associate { it.id to it.name }
        val csv = if (!readable) emptyList() else rows.map { (table, list) ->
            val extra = if (table == SyncCodec.ENTRY) listOf("habit") else emptyList()
            val fieldNames = list.firstOrNull()?.second?.keys?.toList() ?: SyncCodec.knownFields.getValue(table).toList()
            val header = listOf("id") + extra + fieldNames
            val lines = list.map { (id, fields) ->
                val habit = if (table == SyncCodec.ENTRY) listOf(safeText(habitNames[(fields["habit_id"] as? JsonPrimitive)?.content] ?: "")) else emptyList()
                (listOf(id) + habit + fieldNames.map { name -> cell(fields[name]) }).joinToString(",", transform = ::csvField)
            }
            Zip.Entry("csv/${csvName(table)}.csv", (listOf(header.joinToString(",")) + lines).joinToString("\r\n", postfix = "\r\n").encodeToByteArray())
        }
        val bytes = Zip.write(listOf(Zip.Entry(MANIFEST, manifest), Zip.Entry(DATA, dataJson, deflate = !readable)) + csv, now)
        return BackupFileData(
            base64 = Base64.encode(bytes), sha256 = Sha256.hex(bytes), size = bytes.size, createdAt = now,
            habits = liveHabits, entries = liveEntries, records = records, format = if (readable) FORMAT else FORMAT_COMPACT,
        )
    }

    /** Reads and checks a backup file. Throws [BackupProblem] if it isn't one, or isn't whole. */
    internal fun read(base64: String): BackupContents {
        val bytes = try {
            Base64.decode(base64)
        } catch (_: IllegalArgumentException) {
            throw BackupProblem(BackupProblem.NOT_A_BACKUP)
        }
        return read(bytes)
    }

    internal fun read(bytes: ByteArray): BackupContents {
        val zip = Zip.read(bytes)
        val files = zip.files
        val manifest = files[MANIFEST]?.let { parseObject(it) } ?: throw BackupProblem(BackupProblem.NOT_A_BACKUP)
        val format = (manifest["format"] as? JsonPrimitive)?.intOrNull ?: throw BackupProblem(BackupProblem.NOT_A_BACKUP)
        if (format > NEWEST_FORMAT) throw BackupProblem(BackupProblem.NEWER_VERSION)
        if (format < 1) throw BackupProblem(BackupProblem.NOT_A_BACKUP)
        // Format 1 is stored only: a deflated entry means another app zipped it again (use the original file). Format 2
        // deflates `data.json`, and only that.
        if (zip.deflated.any { format < FORMAT_COMPACT || it != DATA }) throw BackupProblem(BackupProblem.REPACKED)

        val data = files[DATA] ?: throw BackupProblem(BackupProblem.DAMAGED)
        val expected = (manifest["data"] as? JsonObject)?.get("sha256")?.let { (it as? JsonPrimitive)?.content }
        if (expected == null || expected.lowercase() != Sha256.hex(data)) throw BackupProblem(BackupProblem.DAMAGED)
        val tablesJson = parseObject(data) ?: throw BackupProblem(BackupProblem.DAMAGED)
        val counts = manifest["counts"] as? JsonObject ?: throw BackupProblem(BackupProblem.DAMAGED)

        fun rows(table: String): List<Pair<String, Map<String, JsonElement>>> {
            val list = (tablesJson[table] ?: JsonArray(emptyList())) as? JsonArray ?: throw BackupProblem(BackupProblem.DAMAGED)
            val count = (counts[table] as? JsonPrimitive)?.intOrNull ?: 0
            if (list.size != count) throw BackupProblem(BackupProblem.DAMAGED)
            return list.map { row ->
                val o = row as? JsonObject ?: throw BackupProblem(BackupProblem.DAMAGED)
                val id = (o["id"] as? JsonPrimitive)?.takeIf { it.isString }?.content
                if (id.isNullOrEmpty() || id.length > 128) throw BackupProblem(BackupProblem.DAMAGED)
                id to (o - "id")
            }
        }
        fun <T> decode(table: String, build: (String, Map<String, JsonElement>) -> T?): List<T> =
            rows(table).map { (id, fields) -> build(id, fields) ?: throw BackupProblem(BackupProblem.DAMAGED) }

        val habits = decode(SyncCodec.HABIT, SyncCodec::decodeHabit)
        val steps = decode(SyncCodec.STEP, SyncCodec::decodeStep)
        val reminders = decode(SyncCodec.REMINDER, SyncCodec::decodeReminder)
        val entries = decode(SyncCodec.ENTRY, SyncCodec::decodeEntry)
        val settings = decode(SyncCodec.SETTING) { key, fields ->
            (fields["value"] as? JsonPrimitive)?.takeIf { it.isString }?.let { SettingRecord(key, it.content) }
        }.filterNot { SyncCodec.isLocalSetting(it.key) }

        // Every step, time and log belongs to a habit in the file.
        val habitIds = habits.map { it.id }.toSet()
        val orphan = steps.any { it.habitId !in habitIds } || reminders.any { it.habitId !in habitIds } || entries.any { it.habitId !in habitIds }
        val duplicate = habitIds.size != habits.size || steps.distinctBy { it.id }.size != steps.size ||
            reminders.distinctBy { it.id }.size != reminders.size || entries.distinctBy { it.id }.size != entries.size ||
            settings.distinctBy { it.key }.size != settings.size
        if (orphan || duplicate) throw BackupProblem(BackupProblem.DAMAGED)

        fun text(key: String) = (manifest[key] as? JsonPrimitive)?.takeIf { it.isString }?.content ?: ""
        return BackupContents(
            snapshot = Snapshot(habits, steps, reminders, entries, settings),
            format = format,
            createdAt = (manifest["createdAt"] as? JsonPrimitive)?.longOrNull ?: 0,
            deviceName = text("deviceName"),
            platform = text("platform"),
            appVersion = text("appVersion"),
        )
    }

    private fun parseObject(bytes: ByteArray): JsonObject? =
        runCatching { json.parseToJsonElement(bytes.decodeToString(throwOnInvalidSequence = true)).jsonObject }.getOrNull()

    private fun csvName(table: String) = when (table) {
        SyncCodec.HABIT -> "habits"
        SyncCodec.STEP -> "steps"
        SyncCodec.REMINDER -> "times"
        SyncCodec.ENTRY -> "logs"
        else -> "settings"
    }

    private fun cell(value: JsonElement?): String = when (value) {
        null, JsonNull -> ""
        is JsonPrimitive -> if (value.isString) safeText(value.content) else value.content
        else -> value.toString()
    }

    /** A text that a spreadsheet would run as a formula (`=`, `+`, `-`, `@`) is shown as text instead. */
    private fun safeText(text: String) = if (text.isNotEmpty() && text[0] in "=+-@") "'$text" else text

    private fun csvField(text: String): String =
        if (text.any { it == ',' || it == '"' || it == '\n' || it == '\r' }) "\"" + text.replace("\"", "\"\"") + "\"" else text
}

/** Who is making a backup: shown when it's restored ("from 'Lalith's iPhone', 30 Sep"). */
data class BackupInfo(val deviceName: String, val platform: String, val appVersion: String)

/**
 * A finished backup file. `base64` crosses to Swift and Kotlin/JS cheaply as one string; `sha256` (of the whole file)
 * is what the copy must still match after it's written and read back, here or on the server, before it counts.
 */
data class BackupFileData(
    val base64: String,
    val sha256: String,
    val size: Int,
    val createdAt: Long,
    /** Live habits and logs, for "5 habits, 412 check-ins". */
    val habits: Int,
    val entries: Int,
    /** Every row in the file, deleted ones included: what the server's shrink guard compares. */
    val records: Int,
    val format: Int,
)

/** A checked backup file's contents. */
data class BackupContents(
    val snapshot: Snapshot,
    val format: Int,
    val createdAt: Long,
    val deviceName: String,
    val platform: String,
    val appVersion: String,
)

/** Why a file can't be restored. The app turns [reason] into plain words; nothing was changed. */
class BackupProblem(val reason: String) : Exception("Backup problem: $reason") {
    companion object {
        /** Not one of our backup files (another app's, a photo, a half-downloaded file). */
        const val NOT_A_BACKUP = "not_a_backup"
        /** Our file, unzipped and zipped again by another app: use the original file. */
        const val REPACKED = "repacked"
        /** Our file, but something in it doesn't match its checksums or counts. */
        const val DAMAGED = "damaged"
        /** Made by a newer version of the app: update the app first. */
        const val NEWER_VERSION = "newer_version"
    }
}

/** A minimal zip: stored entries, and deflated ones for the compact automatic backup (format 2). */
internal object Zip {
    class Entry(val name: String, val data: ByteArray, val deflate: Boolean = false)

    /** Every entry by name (inflated), and the names of those that were deflated. */
    class Contents(val files: Map<String, ByteArray>, val deflated: Set<String>)

    fun write(entries: List<Entry>, modifiedAt: Long): ByteArray {
        val out = Bytes()
        val central = Bytes()
        val (time, date) = dosTime(modifiedAt)
        for (entry in entries) {
            val name = entry.name.encodeToByteArray()
            val crc = Crc32.of(entry.data)
            val offset = out.size
            val stored = if (entry.deflate) Deflate.compress(entry.data) else entry.data
            val method = if (entry.deflate) 8 else 0
            out.u32(0x04034b50); out.u16(20); out.u16(0x0800); out.u16(method); out.u16(time); out.u16(date)
            out.u32(crc); out.u32(stored.size); out.u32(entry.data.size); out.u16(name.size); out.u16(0)
            out.bytes(name); out.bytes(stored)
            central.u32(0x02014b50); central.u16(20); central.u16(20); central.u16(0x0800); central.u16(method)
            central.u16(time); central.u16(date); central.u32(crc); central.u32(stored.size); central.u32(entry.data.size)
            central.u16(name.size); central.u16(0); central.u16(0); central.u16(0); central.u16(0); central.u32(0); central.u32(offset)
            central.bytes(name)
        }
        val centralOffset = out.size
        val centralBytes = central.toByteArray()
        out.bytes(centralBytes)
        out.u32(0x06054b50); out.u16(0); out.u16(0); out.u16(entries.size); out.u16(entries.size)
        out.u32(centralBytes.size); out.u32(centralOffset); out.u16(0)
        return out.toByteArray()
    }

    /** Every entry by name. Bounds, signatures and CRCs are all checked. */
    fun read(bytes: ByteArray): Contents {
        fun u16(at: Int): Int {
            if (at < 0 || at + 2 > bytes.size) throw BackupProblem(BackupProblem.NOT_A_BACKUP)
            return (bytes[at].toInt() and 0xff) or ((bytes[at + 1].toInt() and 0xff) shl 8)
        }
        fun u32(at: Int): Long = u16(at).toLong() or (u16(at + 2).toLong() shl 16)

        // The end-of-central-directory record: 22 bytes plus a comment of up to 65,535.
        var end = -1
        var at = bytes.size - 22
        while (at >= 0 && at >= bytes.size - 22 - 65_535) {
            if (u32(at) == 0x06054b50L) { end = at; break }
            at--
        }
        if (end < 0) throw BackupProblem(BackupProblem.NOT_A_BACKUP)
        val count = u16(end + 10)
        var entry = u32(end + 16).toInt()
        if (entry < 0 || entry > bytes.size) throw BackupProblem(BackupProblem.NOT_A_BACKUP)
        val files = mutableMapOf<String, ByteArray>()
        val deflated = mutableSetOf<String>()
        repeat(count) {
            if (u32(entry) != 0x02014b50L) throw BackupProblem(BackupProblem.NOT_A_BACKUP)
            val flags = u16(entry + 8)
            val method = u16(entry + 10)
            val crc = u32(entry + 16)
            val compressed = u32(entry + 20)
            val size = u32(entry + 24)
            val nameLength = u16(entry + 28)
            val extraLength = u16(entry + 30)
            val commentLength = u16(entry + 32)
            val local = u32(entry + 42).toInt()
            if (entry + 46 + nameLength > bytes.size) throw BackupProblem(BackupProblem.NOT_A_BACKUP)
            val name = bytes.decodeToString(entry + 46, entry + 46 + nameLength)
            entry += 46 + nameLength + extraLength + commentLength
            if (flags and 1 != 0) throw BackupProblem(BackupProblem.NOT_A_BACKUP) // encrypted
            if (method != 0 && method != 8) throw BackupProblem(BackupProblem.REPACKED)
            if ((method == 0 && compressed != size) || size > MAX_ENTRY || compressed > Int.MAX_VALUE) throw BackupProblem(BackupProblem.DAMAGED)
            if (u32(local) != 0x04034b50L) throw BackupProblem(BackupProblem.DAMAGED)
            val start = local + 30 + u16(local + 26) + u16(local + 28)
            val stop = start.toLong() + compressed
            if (start < 0 || stop > bytes.size) throw BackupProblem(BackupProblem.DAMAGED)
            val raw = bytes.copyOfRange(start, stop.toInt())
            val data = if (method == 8) Deflate.decompress(raw, size.toInt()).also { deflated += name } else raw
            if (Crc32.of(data).toLong() and 0xffffffffL != crc) throw BackupProblem(BackupProblem.DAMAGED)
            files[name] = data
        }
        return Contents(files, deflated)
    }

    /** No entry inflates past this: a file that claims more is damaged, never a reason to run out of memory. */
    private const val MAX_ENTRY = 256L * 1024 * 1024

    /** MS-DOS time and date (UTC), as zip stores them. */
    private fun dosTime(epochMillis: Long): Pair<Int, Int> {
        val days = epochMillis.floorDiv(86_400_000L)
        val seconds = (epochMillis.mod(86_400_000L) / 1000).toInt()
        // Civil date from days since 1970 (Howard Hinnant's algorithm).
        val z = days + 719_468
        val era = z.floorDiv(146_097L)
        val doe = z - era * 146_097
        val yoe = (doe - doe / 1460 + doe / 36_524 - doe / 146_096) / 365
        val doy = doe - (365 * yoe + yoe / 4 - yoe / 100)
        val mp = (5 * doy + 2) / 153
        val day = (doy - (153 * mp + 2) / 5 + 1).toInt()
        val month = (if (mp < 10) mp + 3 else mp - 9).toInt()
        val year = (yoe + era * 400 + if (month <= 2) 1 else 0).toInt()
        if (year < 1980) return 0 to ((1 shl 5) or 1)
        val time = ((seconds / 3600) shl 11) or (((seconds / 60) % 60) shl 5) or ((seconds % 60) / 2)
        val date = ((year - 1980) shl 9) or (month shl 5) or day
        return time to date
    }

    private class Bytes {
        private var buffer = ByteArray(64 * 1024)
        var size = 0
            private set

        private fun room(n: Int) {
            if (size + n <= buffer.size) return
            var capacity = buffer.size
            while (capacity < size + n) capacity *= 2
            buffer = buffer.copyOf(capacity)
        }

        fun u16(v: Int) { room(2); buffer[size++] = v.toByte(); buffer[size++] = (v ushr 8).toByte() }
        fun u32(v: Int) { u16(v and 0xffff); u16(v ushr 16) }
        fun bytes(b: ByteArray) { room(b.size); b.copyInto(buffer, size); size += b.size }
        fun toByteArray() = buffer.copyOf(size)
    }
}

internal object Crc32 {
    private val table = IntArray(256) { n ->
        var c = n
        repeat(8) { c = if (c and 1 != 0) (0xEDB88320L.toInt() xor (c ushr 1)) else c ushr 1 }
        c
    }

    fun of(data: ByteArray): Int {
        var c = -1
        for (b in data) c = table[(c xor b.toInt()) and 0xff] xor (c ushr 8)
        return c.inv()
    }
}

/** SHA-256 (FIPS 180-4). Common Kotlin has none built in; checked against the JVM's in the tests. */
internal object Sha256 {
    private val K = longArrayOf(
        0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
        0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
        0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
        0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
        0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
        0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
        0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
        0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
    ).map { it.toInt() }.toIntArray()

    fun digest(data: ByteArray): ByteArray {
        val h = longArrayOf(0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19)
            .map { it.toInt() }.toIntArray()
        val padded = ByteArray(((data.size + 9 + 63) / 64) * 64)
        data.copyInto(padded)
        padded[data.size] = 0x80.toByte()
        val bits = data.size.toLong() * 8
        for (i in 0 until 8) padded[padded.size - 1 - i] = (bits ushr (8 * i)).toByte()
        val w = IntArray(64)
        for (chunk in padded.indices step 64) {
            for (t in 0 until 16) {
                val i = chunk + 4 * t
                w[t] = ((padded[i].toInt() and 0xff) shl 24) or ((padded[i + 1].toInt() and 0xff) shl 16) or
                    ((padded[i + 2].toInt() and 0xff) shl 8) or (padded[i + 3].toInt() and 0xff)
            }
            for (t in 16 until 64) {
                val s0 = w[t - 15].rotateRight(7) xor w[t - 15].rotateRight(18) xor (w[t - 15] ushr 3)
                val s1 = w[t - 2].rotateRight(17) xor w[t - 2].rotateRight(19) xor (w[t - 2] ushr 10)
                w[t] = w[t - 16] + s0 + w[t - 7] + s1
            }
            var a = h[0]; var b = h[1]; var c = h[2]; var d = h[3]
            var e = h[4]; var f = h[5]; var g = h[6]; var hh = h[7]
            for (t in 0 until 64) {
                val t1 = hh + (e.rotateRight(6) xor e.rotateRight(11) xor e.rotateRight(25)) + ((e and f) xor (e.inv() and g)) + K[t] + w[t]
                val t2 = (a.rotateRight(2) xor a.rotateRight(13) xor a.rotateRight(22)) + ((a and b) xor (a and c) xor (b and c))
                hh = g; g = f; f = e; e = d + t1; d = c; c = b; b = a; a = t1 + t2
            }
            h[0] += a; h[1] += b; h[2] += c; h[3] += d; h[4] += e; h[5] += f; h[6] += g; h[7] += hh
        }
        val out = ByteArray(32)
        for (i in 0 until 8) for (j in 0 until 4) out[4 * i + j] = (h[i] ushr (24 - 8 * j)).toByte()
        return out
    }

    fun hex(data: ByteArray): String = digest(data).joinToString("") { (it.toInt() and 0xff).toString(16).padStart(2, '0') }
}
