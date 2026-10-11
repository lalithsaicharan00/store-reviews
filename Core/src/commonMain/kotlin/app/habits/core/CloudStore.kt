package app.habits.core

import app.habits.sync.SyncRecord
import app.habits.sync.SyncRules
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
import kotlinx.coroutines.withContext

/**
 * The database's side of iCloud sync (Architecture 11 §6–9). CloudKit itself is driven by the app (`CloudSync` on
 * iPhone); this is what it asks of the database, each call one transaction:
 *
 * - **What to send:** the rows with changes waiting ([waitingRows]), and each as one CloudKit `Row` record built from
 *   the row's current merged state ([batch]).
 * - **Confirmed saves** ([saved]): only then do the ops a saved record contained leave the outbox, exactly those queued
 *   before it was built, so a change made while the batch was in flight stays queued (§7).
 * - **What was fetched** ([fetched]): merged with the shared rules, field by field, in one transaction before the
 *   engine moves on (§8). A record this version can't read is kept aside, never applied half-way and never dropped.
 *   Nothing here ever deletes a row: a delete is the `deleted_at` field, which merges like any other.
 * - **The brake** (§13.2): fetched changes that would delete too much at once are held, whole, until the person says.
 */
class CloudStore internal constructor(private val dao: HabitDao, private val clock: () -> Long) {

    /**
     * Swift calls these on the main thread, and Kotlin runs a suspend function on the thread that called it until it
     * suspends: merging a page of fetched records or building a batch there froze Today during a big fetch (the speed
     * run, 10 Oct 2026). Every call runs on the database's background dispatcher, as `HabitRepository`'s do.
     */
    private suspend fun <T> offMain(work: suspend () -> T): T = withContext(databaseDispatcher) { work() }

    /** One transaction, off the main thread. */
    private suspend fun <T> synced(block: suspend (SyncWriter) -> T): T = offMain { dao.synced(clock(), block) }

    // MARK: The account

    /** The account this device's outbox is kept for ("icloud:<hash>"), or null if it has never synced. */
    @Throws(Exception::class)
    suspend fun account(): String? = offMain { dao.state(SyncWriter.ACCOUNT) }

    /**
     * Starts keeping every change for [account]. The first time, or for a different account (after the person chose
     * "Add to This Account's iCloud"), every row on this device is queued, so the account gets everything here and
     * nothing is replaced by what's (or isn't) there: both merge by ID. The same account resumes where it stopped.
     */
    @Throws(Exception::class)
    suspend fun bind(account: String) = synced { it.bind(account) }

    /** Everything on this device goes up again as new records (the person deleted the app's iCloud data and chose Back
     *  Up Again, or the zone had to be made again). Nothing local changes. */
    @Throws(Exception::class)
    suspend fun uploadEverythingAgain() = synced { sync ->
        val account = dao.state(SyncWriter.ACCOUNT) ?: return@synced
        sync.bind(account, force = true)
    }

    // MARK: Sending (§7)

    /** Record names (`<table>:<row>`) of rows with changes waiting, oldest change first, each once. */
    @Throws(Exception::class)
    suspend fun waitingRows(limit: Int): List<String> = offMain { dao.oldestWaiting(limit * 4).distinct().take(limit) }

    /**
     * The records for [names], each from its row's current merged state, with the system fields kept from its last
     * save. A record over [MAX_RECORD_BYTES] is refused here (it could never fail at CloudKit's 1 MB): its changes are
     * kept aside with a problem the iCloud page shows, never retried forever and never dropped.
     */
    @Throws(Exception::class)
    suspend fun batch(names: List<String>): CloudBatch = synced { sync ->
        val rows = mutableListOf<CloudRow>()
        val refused = mutableListOf<String>()
        val missing = mutableListOf<String>()
        var deletes = 0
        // Every op queued so far has already been merged into its row, so a record built now contains them all.
        val upTo = dao.lastOutboxSeq()
        for (name in names) {
            val key = split(name)
            if (key == null) {
                missing += name
                continue
            }
            val (table, row) = key
            if (!isRecordName(name)) {
                dao.markRowProblem(table, row, "name")
                refused += name
                continue
            }
            val meta = dao.syncMeta(table, row)
            val record = sync.current(table, row)
            if (meta == null || record == null || record.fields.isEmpty()) {
                missing += name
                continue
            }
            val fields = JsonObject(record.fields).toString()
            val clocks = JsonObject(record.clocks.mapValues { JsonPrimitive(it.value) }).toString()
            if (fields.encodeToByteArray().size + clocks.encodeToByteArray().size > MAX_RECORD_BYTES) {
                dao.markRowProblem(table, row, "too_large")
                refused += name
                continue
            }
            if (dao.hasWaitingDelete(table, row)) deletes++
            rows += CloudRow(name, table, row, fields, clocks, HabitRepository.SCHEMA_VERSION, meta.ckSystem, upTo)
        }
        CloudBatch(rows, refused, missing, deletes)
    }

    /**
     * CloudKit confirmed these saves: each row keeps the saved record's system fields, and the ops that record contained
     * leave the outbox. Returns how many changes are still waiting (ops, not rows: cheap to count).
     */
    @Throws(Exception::class)
    suspend fun saved(results: List<CloudSaved>): Int = synced {
        for (result in results) {
            val (table, row) = split(result.name) ?: continue
            if (result.system != null) dao.setCloudSystem(table, row, result.system)
            dao.deleteConfirmed(table, row, result.upTo)
        }
        dao.setState(LocalStateRecord(LAST_SENT, clock().toString()))
        dao.outboxCount()
    }

    /** The changes to these rows can never be accepted (`invalidArguments`): kept aside, with why. */
    @Throws(Exception::class)
    suspend fun keepAside(name: String, problem: String) = synced {
        val (table, row) = split(name) ?: return@synced
        dao.markRowProblem(table, row, problem)
    }

    /** The saved records' system fields no longer match CloudKit's (`unknownItem`): the next save makes them anew. */
    @Throws(Exception::class)
    suspend fun forgetSystemFields(names: List<String>) = synced {
        for (name in names) {
            val (table, row) = split(name) ?: continue
            dao.setCloudSystem(table, row, null)
        }
    }

    /** Every row's system fields go (the zone is new): the next saves make every record anew. */
    @Throws(Exception::class)
    suspend fun forgetAllSystemFields() = synced { dao.clearCloudSystem() }

    // MARK: Fetching (§8)

    /**
     * Merges fetched records, in one transaction, before the engine saves its new position. Returns what changed.
     *
     * The brake (§13.2): if merging would delete more than [deleteAllowance] rows that are live here, nothing is merged
     * and the whole page is held (kept in this database) until the person chooses ([applyHeld]); with [holdAll], every
     * page is held, so nothing jumps the queue while one waits. Records this version can't read are kept aside.
     */
    @Throws(Exception::class)
    suspend fun fetched(records: List<CloudIncoming>, deleteAllowance: Int, holdAll: Boolean): CloudApplied = synced { sync ->
        val readable = mutableListOf<Pair<CloudIncoming, Pair<Pair<String, String>, SyncRecord>>>()
        var quarantined = 0
        for (incoming in records) {
            val parsed = parse(incoming)
            if (parsed == null) {
                dao.setState(LocalStateRecord(QUARANTINE + incoming.name, encode(incoming)))
                quarantined++
            } else {
                readable += incoming to parsed
            }
        }
        var deletes = 0
        for ((_, parsed) in readable) {
            val (key, record) = parsed
            if (sync.wouldDelete(key.first, key.second, record)) deletes++
        }
        if (readable.isNotEmpty() && (holdAll || deletes > deleteAllowance)) {
            val next = (dao.statesWithPrefix(HELD).mapNotNull { it.key.removePrefix(HELD).toIntOrNull() }.maxOrNull() ?: 0) + 1
            dao.setState(LocalStateRecord(HELD + next.toString().padStart(8, '0'), JsonArray(readable.map { Json.parseToJsonElement(encode(it.first)) }).toString()))
            val held = dao.state(HELD_DELETES)?.toIntOrNull() ?: 0
            dao.setState(LocalStateRecord(HELD_DELETES, (held + deletes).toString()))
            return@synced CloudApplied(changed = 0, deleted = deletes, quarantined = quarantined, held = true)
        }
        var changed = 0
        for ((incoming, parsed) in readable) {
            val (key, record) = parsed
            if (sync.receiveRecord(key.first, key.second, record, incoming.system)) changed++
        }
        dao.setState(LocalStateRecord(LAST_FETCHED, clock().toString()))
        CloudApplied(changed = changed, deleted = deletes, quarantined = quarantined, held = false)
    }

    /** The person chose to apply what the brake held: every held page, in order, in one transaction. */
    @Throws(Exception::class)
    suspend fun applyHeld(): CloudApplied = synced { sync ->
        var changed = 0
        var deleted = 0
        for (page in dao.statesWithPrefix(HELD)) {
            for (element in Json.parseToJsonElement(page.value).jsonArray) {
                val incoming = decode(element.jsonObject) ?: continue
                val (key, record) = parse(incoming) ?: continue
                if (sync.wouldDelete(key.first, key.second, record)) deleted++
                if (sync.receiveRecord(key.first, key.second, record, incoming.system)) changed++
            }
        }
        dao.removeStatesWithPrefix(HELD)
        dao.removeState(HELD_DELETES)
        CloudApplied(changed = changed, deleted = deleted, quarantined = 0, held = false)
    }

    /** Records kept aside because an older version couldn't read them: merged now if this version can. */
    @Throws(Exception::class)
    suspend fun retryKeptAside(): Int = synced { sync ->
        var applied = 0
        for (kept in dao.statesWithPrefix(QUARANTINE)) {
            val incoming = runCatching { decode(Json.parseToJsonElement(kept.value).jsonObject) }.getOrNull() ?: continue
            val (key, record) = parse(incoming) ?: continue
            sync.receiveRecord(key.first, key.second, record, incoming.system)
            dao.removeState(kept.key)
            applied++
        }
        applied
    }

    // MARK: Where things stand

    @Throws(Exception::class)
    suspend fun counts(): CloudCounts = offMain {
        CloudCounts(
            waitingOps = dao.outboxCount(),
            waitingRows = dao.waitingRowCount(),
            keptAside = dao.outboxProblemCount(),
            waitingDeletes = dao.waitingDeleteCount(1),
            confirmedDeletes = dao.waitingDeleteCount(2),
            liveRecords = dao.liveRecordCount(),
            liveHabits = dao.liveHabitCount(),
            heldPages = dao.statesWithPrefix(HELD).size,
            heldDeletes = dao.state(HELD_DELETES)?.toIntOrNull() ?: 0,
            unreadable = dao.statesWithPrefix(QUARANTINE).size,
            lastSent = dao.state(LAST_SENT)?.toLongOrNull(),
            lastFetched = dao.state(LAST_FETCHED)?.toLongOrNull(),
        )
    }

    /** Device state kept in this database, beside the data it describes (the engine's state, the account's hash, …). */
    @Throws(Exception::class)
    suspend fun state(key: String): String? = offMain { dao.state(CLOUD + key) }

    @Throws(Exception::class)
    suspend fun setState(key: String, value: String?) {
        offMain { if (value == null) dao.removeState(CLOUD + key) else dao.setState(LocalStateRecord(CLOUD + key, value)) }
    }

    /** This device's clock node. */
    @Throws(Exception::class)
    suspend fun node(): String? = offMain { dao.state(SyncWriter.NODE) }

    /** A new node, for a device restored from another's backup (§13.4), so two devices never share stamps. */
    @Throws(Exception::class)
    suspend fun renewNode() = synced { it.renewNode() }

    companion object {
        /** A record bigger than this is refused before sending (§6): CloudKit's limit is 1 MB. */
        const val MAX_RECORD_BYTES = 256 * 1024
        /** The record layout's version (§6, the `format` field). A newer one is kept aside, not read. */
        const val FORMAT = 1

        /**
         * The mass-change brake for sending (§13.2, the user's 20% / 50 rows, 10 Oct 2026): pause and ask when the
         * deletes waiting to go, other than one explicit action the person confirmed, are more than 50 rows, or more
         * than 20% of the habits and records once there are at least [BRAKE_FLOOR] of them.
         */
        fun outgoingBrake(deletes: Int, live: Int): Boolean =
            deletes > 50 || (deletes >= BRAKE_FLOOR && deletes * 5 > live + deletes)

        /** How many more rows fetched changes may delete in this run before they're held (§13.2): up to 20% of the
         *  habits and records there were when the run began, and never fewer than [BRAKE_FLOOR] - 1. */
        fun incomingAllowance(liveAtStart: Int, deletedSoFar: Int): Int =
            maxOf(BRAKE_FLOOR - 1, liveAtStart / 5) - deletedSoFar

        /** Fewer than this many deletes never trip the brake: with a handful of rows, 20% is one or two taps. */
        const val BRAKE_FLOOR = 10

        fun recordName(table: String, row: String) = "$table:$row"

        /** CloudKit record names: ASCII, at most 255 characters, not starting with "_". */
        fun isRecordName(name: String) = name.length in 1..255 && !name.startsWith("_") && name.all { it.code in 33..126 }

        internal const val CLOUD = "cloud."
        internal const val HELD = "cloud.held."
        internal const val HELD_DELETES = "cloud.heldDeletes"
        internal const val QUARANTINE = "cloud.unreadable."
        internal const val LAST_SENT = "cloud.lastSent"
        internal const val LAST_FETCHED = "cloud.lastFetched"

        private fun split(name: String): Pair<String, String>? {
            val at = name.indexOf(':')
            if (at <= 0 || at == name.length - 1) return null
            return name.substring(0, at) to name.substring(at + 1)
        }

        private fun parse(incoming: CloudIncoming): Pair<Pair<String, String>, SyncRecord>? = runCatching {
            if (incoming.format > FORMAT) return null
            val key = split(incoming.name) ?: return null
            val fields = Json.parseToJsonElement(incoming.fields).jsonObject
            val clocks = Json.parseToJsonElement(incoming.clocks).jsonObject.mapValues { it.value.jsonPrimitive.content }
            val record = SyncRecord(fields, clocks)
            if (SyncRules.recordProblem(key.first, key.second, record) != null) return null
            key to record
        }.getOrNull()

        private fun encode(incoming: CloudIncoming): String = JsonObject(
            mapOf(
                "name" to JsonPrimitive(incoming.name), "fields" to JsonPrimitive(incoming.fields),
                "clocks" to JsonPrimitive(incoming.clocks), "format" to JsonPrimitive(incoming.format),
                "system" to (incoming.system?.let(::JsonPrimitive) ?: JsonNull),
            ),
        ).toString()

        private fun decode(o: JsonObject): CloudIncoming? = runCatching {
            CloudIncoming(
                name = o.getValue("name").jsonPrimitive.content,
                fields = o.getValue("fields").jsonPrimitive.content,
                clocks = o.getValue("clocks").jsonPrimitive.content,
                format = o["format"]?.jsonPrimitive?.intOrNull ?: FORMAT,
                system = (o["system"] as? JsonPrimitive)?.takeIf { it.isString }?.content,
            )
        }.getOrNull()
    }
}

/**
 * One `Row` record to send: its name, table, row, fields and stamps (JSON), the schema, its system fields, and `upTo`:
 * the outbox position it was built at. Every op queued by then is in it (merged, even an op whose fields all lost the
 * merge), so a confirmed save removes the row's ops up to there, and a change made after stays queued (§7).
 */
data class CloudRow(
    val name: String, val table: String, val row: String, val fields: String, val clocks: String, val schema: Int,
    val system: String?, val upTo: Long,
)

/** A batch to send; records refused (kept aside) or with nothing to send; and how many rows in it carry a delete that
 *  isn't part of one confirmed action (the brake checks before sending those, §13.2). */
data class CloudBatch(val rows: List<CloudRow>, val refused: List<String>, val missing: List<String>, val deletes: Int)

/** A confirmed save: the record's name, its new system fields, and the outbox position it was built at. */
data class CloudSaved(val name: String, val system: String?, val upTo: Long)

/** A fetched `Row` record, as CloudKit returned it. */
data class CloudIncoming(val name: String, val fields: String, val clocks: String, val format: Int, val system: String?)

data class CloudApplied(val changed: Int, val deleted: Int, val quarantined: Int, val held: Boolean)

data class CloudCounts(
    /** Changes not yet confirmed by CloudKit, and the rows they're on. */
    val waitingOps: Int, val waitingRows: Int,
    /** Changes that can never be accepted, kept aside. */
    val keptAside: Int,
    /** Rows waiting to be deleted in iCloud: not part of one confirmed action, and part of one. */
    val waitingDeletes: Int, val confirmedDeletes: Int,
    /** Live habits and records (habits, steps, times, logs), and live habits alone. */
    val liveRecords: Int, val liveHabits: Int,
    /** Fetched pages the brake is holding, and how many rows they'd delete. */
    val heldPages: Int, val heldDeletes: Int,
    /** Fetched records this version couldn't read, kept aside. */
    val unreadable: Int,
    /** When CloudKit last confirmed a save, and when fetched changes were last applied (epoch ms). */
    val lastSent: Long?, val lastFetched: Long?,
)
