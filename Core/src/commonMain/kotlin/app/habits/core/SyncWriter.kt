package app.habits.core

import app.habits.sync.Hlc
import app.habits.sync.HlcClock
import app.habits.sync.Op
import app.habits.sync.SyncRecord
import app.habits.sync.SyncRules
import kotlin.uuid.ExperimentalUuidApi
import kotlin.uuid.Uuid
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive

/**
 * Every change to synced data goes through here, inside the same transaction as the change (Architecture 05 §5).
 *
 * A change becomes an op holding only the fields that changed, stamped by this device's clock. The op is merged into
 * the row with the shared rules ([SyncRules], the same code the server runs), the row is rebuilt from the result,
 * and, once this device syncs with an account, the op goes to the outbox. Ops from other devices take the same
 * path without the outbox, so local and remote changes can never be applied differently.
 */
class SyncWriter internal constructor(private val dao: HabitDao, private val now: Long) {
    private lateinit var clock: HlcClock
    private var sending = false

    internal suspend fun begin() {
        val node = dao.state(NODE) ?: newNode().also { dao.setState(LocalStateRecord(NODE, it)) }
        clock = HlcClock(node, dao.state(CLOCK)?.let(Hlc::parse))
        sending = dao.state(ACCOUNT) != null
        if (dao.state(STAMPED) == null) stampExistingRows()
    }

    internal suspend fun end() {
        clock.last?.let { dao.setState(LocalStateRecord(CLOCK, it.encode())) }
    }

    // MARK: Local changes

    /** Records a change made on this device: only fields that differ from what's stored become an op. */
    suspend fun change(table: String, row: String, fields: Map<String, JsonElement>) {
        val current = current(table, row)
        val changed = if (current == null) fields else fields.filter { (name, value) -> current.fields[name] != value }
        if (changed.isEmpty()) return
        val op = Op(newOpId(), table, row, changed, clock.now(now).encode(), HabitRepository.SCHEMA_VERSION)
        apply(op)
        if (sending) dao.insertOutbox(OutboxRecord(opId = op.id, op = SyncRules.encodeOp(op)))
    }

    suspend fun exists(table: String, row: String): Boolean = dao.syncMeta(table, row) != null

    // MARK: Changes from other devices

    suspend fun receive(op: Op) {
        Hlc.parse(op.hlc)?.let { clock.observe(it, now) }
        apply(op)
    }

    // MARK: Accounts

    /**
     * Starts syncing with [accountId]. Signing in to the account this device synced with before resumes where it
     * stopped (its unsent changes are still in the outbox). A different account starts from scratch: everything
     * on this device is queued for upload, so nothing is lost or replaced by an empty account (05 §5, 01 §3.4).
     */
    suspend fun bind(accountId: String) {
        if (dao.state(ACCOUNT) == accountId) return
        dao.setState(LocalStateRecord(ACCOUNT, accountId))
        dao.setState(LocalStateRecord(CURSOR, "0"))
        dao.clearOutbox()
        sending = true
        for (meta in dao.allSyncMeta()) {
            val record = current(meta.tableName, meta.rowId) ?: continue
            // One op per stamp, so every field keeps the stamp it really has.
            for ((hlc, names) in record.clocks.entries.groupBy({ it.value }, { it.key })) {
                val op = Op(newOpId(), meta.tableName, meta.rowId, names.associateWith { record.fields.getValue(it) }, hlc, HabitRepository.SCHEMA_VERSION)
                dao.insertOutbox(OutboxRecord(opId = op.id, op = SyncRules.encodeOp(op)))
            }
        }
    }

    // MARK: Merging

    private suspend fun apply(op: Op) {
        if (op.table == SyncCodec.SETTING && SyncCodec.isLocalSetting(op.row)) return
        val current = current(op.table, op.row)
        val merged = SyncRules.merge(current, op)
        if (merged == current) return
        store(op.table, op.row, merged)
    }

    /** The row as sync sees it: its columns plus kept-aside fields, each with its stamp. Null if sync has never seen it. */
    internal suspend fun current(table: String, row: String): SyncRecord? {
        val meta = dao.syncMeta(table, row) ?: return null
        val extra = meta.extra?.let(::decodeObject) ?: emptyMap()
        val columns = if (meta.pending) emptyMap() else columns(table, row) ?: emptyMap()
        val fields = columns + extra
        val clocks = meta.clocks?.let(::decodeObject)?.mapValues { it.value.jsonPrimitive.content } ?: emptyMap()
        return SyncRecord(fields, fields.keys.associateWith { clocks[it] ?: meta.hlc })
    }

    private suspend fun columns(table: String, row: String): Map<String, JsonElement>? = when (table) {
        SyncCodec.HABIT -> dao.habitById(row)?.let(SyncCodec::habit)
        SyncCodec.STEP -> dao.stepById(row)?.let(SyncCodec::step)
        SyncCodec.REMINDER -> dao.reminderById(row)?.let(SyncCodec::reminder)
        SyncCodec.ENTRY -> dao.entryById(row)?.let(SyncCodec::entry)
        SyncCodec.SETTING -> dao.settingByKey(row)?.let(SyncCodec::setting)
        else -> null
    }

    /** Writes the merged record: into its table's row when it's complete, and its stamps and extra fields into sync_meta. */
    private suspend fun store(table: String, row: String, record: SyncRecord) {
        val known = SyncCodec.knownFields[table] ?: emptySet()
        val built: Boolean = when (table) {
            SyncCodec.HABIT -> SyncCodec.decodeHabit(row, record.fields)?.let { dao.upsertHabit(it) } != null
            SyncCodec.STEP -> SyncCodec.decodeStep(row, record.fields)?.let { dao.upsertSteps(listOf(it)) } != null
            SyncCodec.REMINDER -> SyncCodec.decodeReminder(row, record.fields)?.let { dao.upsertReminders(listOf(it)) } != null
            SyncCodec.ENTRY -> SyncCodec.decodeEntry(row, record.fields)?.let { dao.upsertEntry(it) } != null
            SyncCodec.SETTING -> {
                // A removed setting is `value: null`: the row goes, its stamps stay, so an older value can't return.
                val value = (record.fields["value"] as? JsonPrimitive)?.takeIf { it.isString }?.content
                if (value != null) dao.upsertSetting(SettingRecord(row, value)) else dao.deleteSetting(row)
                value != null
            }
            else -> false // a table this version doesn't have yet: kept whole in sync_meta
        }
        val inColumns = if (built) known else emptySet()
        val extra = record.fields.filterKeys { it !in inColumns }
        val base = record.clocks.values.groupingBy { it }.eachCount().maxByOrNull { it.value }?.key
            ?: clock.now(now).encode()
        val exceptions = record.clocks.filterValues { it != base }
        dao.upsertSyncMeta(
            SyncMetaRecord(
                tableName = table, rowId = row, hlc = base,
                clocks = exceptions.takeIf { it.isNotEmpty() }?.let { JsonObject(it.mapValues { e -> JsonPrimitive(e.value) }).toString() },
                extra = extra.takeIf { it.isNotEmpty() }?.let { JsonObject(it).toString() },
                pending = !built && table != SyncCodec.SETTING,
            ),
        )
    }

    /** Gives rows written before sync existed (schema 5 and earlier) their first stamp. Runs once. */
    private suspend fun stampExistingRows() {
        val stamp = clock.now(now).encode()
        suspend fun stampRow(table: String, row: String) = dao.upsertSyncMeta(SyncMetaRecord(table, row, stamp, null, null, false))
        dao.unstampedHabits().forEach { stampRow(SyncCodec.HABIT, it.id) }
        dao.unstampedSteps().forEach { stampRow(SyncCodec.STEP, it.id) }
        dao.unstampedReminders().forEach { stampRow(SyncCodec.REMINDER, it.id) }
        dao.unstampedEntries().forEach { stampRow(SyncCodec.ENTRY, it.id) }
        dao.unstampedSettings().filterNot { SyncCodec.isLocalSetting(it.key) }.forEach { stampRow(SyncCodec.SETTING, it.key) }
        dao.setState(LocalStateRecord(STAMPED, stamp))
    }

    internal companion object {
        const val NODE = "sync.node"
        const val CLOCK = "sync.clock"
        const val ACCOUNT = "sync.account"
        const val CURSOR = "sync.cursor"
        const val STAMPED = "sync.stamped"
        const val LAST_SYNCED = "sync.last_synced"

        private val json = Json

        fun decodeObject(text: String): Map<String, JsonElement> = json.parseToJsonElement(text).jsonObject

        @OptIn(ExperimentalUuidApi::class)
        fun newOpId(): String = Uuid.random().toString()

        @OptIn(ExperimentalUuidApi::class)
        fun newNode(): String = Uuid.random().toHexString().take(16)
    }
}
