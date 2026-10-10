package app.habits.sync

import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonNull
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.intOrNull
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive

/**
 * One change to one record (Architecture 05 §5): the fields that changed, stamped with the HLC of the change.
 * `id` is made on the device and is the idempotency key: the same op applied twice changes nothing.
 * `schema` is the app schema that wrote it; fields a reader doesn't know are kept and passed on (05 §12).
 */
data class Op(
    val id: String,
    val table: String,
    val row: String,
    val fields: Map<String, JsonElement>,
    val hlc: String,
    val schema: Int,
)

/** A record as sync sees it: its fields, and for each field the stamp of the change that last set it. */
data class SyncRecord(val fields: Map<String, JsonElement>, val clocks: Map<String, String>) {
    val isDeleted: Boolean get() = fields[SyncRules.DELETED_AT].let { it != null && it !is JsonNull }
}

/**
 * The merge rules (Architecture 05 §6–7), the same on every device and on the server, so everyone converges on the
 * same record whatever order the ops arrive in, and however many times each one arrives:
 *
 * - **Field by field, the later stamp wins.** A name changed on the phone and a colour changed on the iPad both stay.
 * - **A delete always wins** (`deleted_at` set). Once deleted, a record stays deleted: an edit from an old device,
 *   even a later one, can't bring it back. The edit's other fields are still kept (for the 30-day undo).
 * - **Nothing is dropped:** fields this version doesn't know are merged and kept like any other.
 */
object SyncRules {
    const val DELETED_AT = "deleted_at"
    const val MAX_FIELDS = 64
    const val MAX_FIELDS_BYTES = 32 * 1024

    private val TABLE = Regex("[a-z][a-z0-9_]{0,31}")
    private val FIELD = Regex("[a-z][a-z0-9_]{0,63}")
    private val ID = Regex("[0-9A-Za-z_.:|-]{1,128}")

    /** Why an op can't be accepted, or null if it's well formed. */
    fun problem(op: Op): String? = when {
        !ID.matches(op.id) -> "invalid op id"
        !TABLE.matches(op.table) -> "invalid table"
        !ID.matches(op.row) -> "invalid row id"
        !Hlc.isValid(op.hlc) -> "invalid hlc"
        op.schema < 0 -> "invalid schema"
        op.fields.isEmpty() -> "no fields"
        op.fields.size > MAX_FIELDS -> "too many fields"
        op.fields.keys.any { !FIELD.matches(it) || it == "id" } -> "invalid field name"
        op.fields.values.any { it !is JsonPrimitive } -> "fields must be plain values"
        JsonObject(op.fields).toString().encodeToByteArray().size > MAX_FIELDS_BYTES -> "fields too large"
        else -> null
    }

    fun merge(current: SyncRecord?, op: Op): SyncRecord = mergeFields(current, op.fields, op.hlc)

    /**
     * Merges a whole record, each field with its own stamp, as CloudKit hands one back (Architecture 11 §5). Exactly the
     * same as applying one op per stamp, in any order: so it's order-free and idempotent, and a record merged twice, or
     * a record and the ops it was made from, end in the same place. A field with no stamp is ignored (never guessed).
     */
    fun mergeRecord(current: SyncRecord?, incoming: SyncRecord): SyncRecord {
        var merged = current
        val byClock = incoming.fields.keys.filter { incoming.clocks[it] != null }.groupBy { incoming.clocks.getValue(it) }
        for (hlc in byClock.keys.sorted()) {
            merged = mergeFields(merged, byClock.getValue(hlc).associateWith { incoming.fields.getValue(it) }, hlc)
        }
        return merged ?: SyncRecord(emptyMap(), emptyMap())
    }

    /** Why a whole record (from CloudKit) can't be merged, or null if it's well formed. Same limits as an op's. */
    fun recordProblem(table: String, row: String, record: SyncRecord): String? = when {
        !TABLE.matches(table) -> "invalid table"
        !ID.matches(row) -> "invalid row id"
        record.fields.isEmpty() -> "no fields"
        record.fields.size > MAX_FIELDS -> "too many fields"
        record.fields.keys.any { !FIELD.matches(it) || it == "id" } -> "invalid field name"
        record.fields.values.any { it !is JsonPrimitive } -> "fields must be plain values"
        record.fields.keys.any { record.clocks[it] == null } -> "a field has no stamp"
        record.clocks.values.any { !Hlc.isValid(it) } -> "invalid hlc"
        else -> null
    }

    private fun mergeFields(current: SyncRecord?, changed: Map<String, JsonElement>, hlc: String): SyncRecord {
        val fields = current?.fields?.toMutableMap() ?: mutableMapOf()
        val clocks = current?.clocks?.toMutableMap() ?: mutableMapOf()
        for ((name, value) in changed) {
            val clock = clocks[name]
            val later = clock == null || hlc > clock
            val wins = if (name == DELETED_AT) {
                val deleted = fields[name].let { it != null && it !is JsonNull }
                when {
                    value is JsonNull -> !deleted && later // "not deleted" never overrides a delete
                    !deleted -> true // a delete wins over any edit
                    else -> later // two deletes: the later stamp's time is kept
                }
            } else {
                later
            }
            if (wins) {
                fields[name] = value
                clocks[name] = hlc
            }
        }
        return SyncRecord(fields, clocks)
    }

    // JSON, for storage and the wire. Kept here so every platform reads and writes exactly the same shape.

    private val json = Json { encodeDefaults = true }

    fun encodeOp(op: Op): String = opObject(op).toString()

    fun opObject(op: Op): JsonObject = JsonObject(
        mapOf(
            "id" to JsonPrimitive(op.id),
            "table" to JsonPrimitive(op.table),
            "row" to JsonPrimitive(op.row),
            "fields" to JsonObject(op.fields),
            "hlc" to JsonPrimitive(op.hlc),
            "schema" to JsonPrimitive(op.schema),
        ),
    )

    /** Reads an op, or returns null if it isn't one (the caller then reports it as invalid). */
    fun decodeOp(text: String): Op? = runCatching { opFrom(json.parseToJsonElement(text).jsonObject) }.getOrNull()

    fun opFrom(o: JsonObject): Op? = runCatching {
        Op(
            id = o.getValue("id").jsonPrimitive.content,
            table = o.getValue("table").jsonPrimitive.content,
            row = o.getValue("row").jsonPrimitive.content,
            fields = o.getValue("fields").jsonObject,
            hlc = o.getValue("hlc").jsonPrimitive.content,
            schema = o["schema"]?.jsonPrimitive?.intOrNull ?: 0,
        )
    }.getOrNull()

    fun encodeRecord(record: SyncRecord): String =
        JsonObject(mapOf("fields" to JsonObject(record.fields), "clocks" to JsonObject(record.clocks.mapValues { JsonPrimitive(it.value) }))).toString()

    fun decodeRecord(text: String): SyncRecord {
        val o = json.parseToJsonElement(text).jsonObject
        return SyncRecord(
            fields = o.getValue("fields").jsonObject,
            clocks = o.getValue("clocks").jsonObject.mapValues { it.value.jsonPrimitive.content },
        )
    }
}
