@file:OptIn(ExperimentalJsExport::class)

package app.habits.sync

/**
 * The narrow JavaScript API the Cloudflare Worker uses (Shared Core Decision: "a narrow exported API for
 * JavaScript"). Strings in, strings out, so nothing Kotlin-specific crosses the boundary.
 */

/** Why the op (JSON) can't be accepted, or null if it's fine. */
@JsExport
fun syncProblem(opJson: String): String? {
    val op = SyncRules.decodeOp(opJson) ?: return "not an op"
    return SyncRules.problem(op)
}

/** Merges an op (JSON) into a stored record (JSON, or null for a new record) and returns the new record (JSON). */
@JsExport
fun syncMerge(currentJson: String?, opJson: String): String {
    val op = requireNotNull(SyncRules.decodeOp(opJson)) { "not an op" }
    val current = currentJson?.let(SyncRules::decodeRecord)
    return SyncRules.encodeRecord(SyncRules.merge(current, op))
}
