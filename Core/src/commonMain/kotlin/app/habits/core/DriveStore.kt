package app.habits.core

import app.habits.sync.SyncRecord
import app.habits.sync.SyncRules
import kotlinx.coroutines.withContext
import kotlinx.serialization.json.JsonPrimitive

/**
 * The database's side of Google Drive sync ([DriveSync]): the same outbox, merge rules and brake as iCloud
 * ([CloudStore]); only what's carried differs. Each call is one transaction, off the main thread.
 *
 * Drive holds one file per year of logs and one "base" file for everything else ([chainOf]); each is a version chain
 * (DriveSync). Here: what a file of this device's data holds ([build]), merging a downloaded one ([merge]), and
 * confirming a save ([confirm]): only then do the changes the saved file contained leave the outbox, exactly those
 * queued before it was built (by outbox position, as D12 learned for iCloud).
 */
class DriveStore internal constructor(private val dao: HabitDao, private val clock: () -> Long) {

    private suspend fun <T> offMain(work: suspend () -> T): T = withContext(databaseDispatcher) { work() }

    private suspend fun <T> synced(block: suspend (SyncWriter) -> T): T = offMain { dao.synced(clock(), block) }

    /** The files this device has changes waiting for (years, and [BASE]). */
    internal suspend fun waitingChains(): Set<String> = offMain { dao.waitingDriveChains().map { it.ifEmpty { BASE } }.toSet() }

    /** Everything in one file, as this device has it now, and the outbox position it was read at (one transaction). */
    internal suspend fun build(chain: String): Built = synced { sync ->
        val upTo = dao.lastOutboxSeq()
        val rows = records(sync, chain).map { (key, record) -> SyncRows.Row(key.first, key.second, record) }
            .sortedWith(compareBy({ it.table }, { it.row }))
        var live = 0
        var habits = 0
        for (row in rows) {
            if (row.table !in SyncCodec.deletable || row.record.isDeleted) continue
            live++
            if (row.table == SyncCodec.HABIT && (row.record.fields["kind"] as? JsonPrimitive)?.content != "task") habits++
        }
        Built(rows, upTo, live, habits)
    }

    /**
     * Merges one downloaded file, field by field, in one transaction ([SyncRules.mergeRecord], exactly as iCloud's
     * fetched records). Records already here unchanged are skipped without touching the database.
     *
     * The brake (Architecture 11 §13.2): if merging would delete more than [deleteAllowance] rows that are live here,
     * nothing is merged ([Merged.held]). A record this version can't accept is counted, never applied half-way: the file
     * is then blocked from being written by this version (DriveSync), so a newer app's data is never dropped.
     */
    internal suspend fun merge(chain: String, rows: List<SyncRows.Row>, deleteAllowance: Int): Merged = synced { sync ->
        val here = records(sync, chain)
        val incoming = rows.filter { here[it.table to it.row] != it.record }
        val readable = incoming.filter { SyncRules.recordProblem(it.table, it.row, it.record) == null }
        val unreadable = incoming.size - readable.size
        var deletes = 0
        for (row in readable) if (sync.wouldDelete(row.table, row.row, row.record)) deletes++
        if (deletes > deleteAllowance) return@synced Merged(0, deletes, unreadable, held = true, moved = 0, dirty = emptySet())
        var changed = 0
        for (row in readable) if (sync.receiveRecord(row.table, row.row, row.record, null)) changed++
        // A record this device files elsewhere (a log it can build that another device couldn't yet): the file this
        // device would save it in must carry it, so it's marked to be saved, and this file may then hold one row fewer.
        var moved = 0
        val dirty = mutableSetOf<String>()
        for (row in rows) {
            val stated = if (row.table == SyncCodec.ENTRY) yearOf((row.record.fields["day"] as? JsonPrimitive)?.takeIf { it.isString }?.content) else null
            val buildable = row.table != SyncCodec.ENTRY || SyncCodec.decodeEntry(row.row, row.record.fields) != null
            if (stated == chain && buildable) continue
            if (row.table != SyncCodec.ENTRY && chain == BASE) continue
            val actual = if (row.table == SyncCodec.ENTRY) yearOf(dao.entryById(row.row)?.day) ?: BASE else BASE
            if (actual != chain) {
                moved++
                dirty += actual
            }
        }
        Merged(changed, deletes, unreadable, held = false, moved = moved, dirty = dirty)
    }

    /** A saved file was confirmed: the changes it contained leave the outbox. Returns how many changes still wait. */
    internal suspend fun confirm(chain: String, upTo: Long): Int = synced {
        if (chain == BASE) dao.confirmDriveBase(upTo) else dao.confirmDriveYear(upTo, chain, nextYear(chain))
        dao.outboxCount()
    }

    private suspend fun records(sync: SyncWriter, chain: String): Map<Pair<String, String>, SyncRecord> {
        if (chain == BASE) {
            return dao.driveBaseMeta().mapNotNull { meta -> sync.current(meta.tableName, meta.rowId)?.let { (meta.tableName to meta.rowId) to it } }.toMap()
        }
        return dao.driveYear(chain, nextYear(chain)).associate { e ->
            val meta = SyncMetaRecord(SyncCodec.ENTRY, e.entry.id, e.hlc, e.clocks, e.extra, e.pending)
            (SyncCodec.ENTRY to e.entry.id) to SyncWriter.record(meta, if (e.pending) null else SyncCodec.entry(e.entry))
        }
    }

    // MARK: Device state kept beside the data (`drive.*`): what each file's newest versions were when last merged, IDs
    // reserved for saves, this device's Drive file, and the last state for the app to show.

    internal suspend fun state(key: String): String? = offMain { dao.state(PREFIX + key) }

    internal suspend fun setState(key: String, value: String?) = offMain {
        if (value == null) dao.removeState(PREFIX + key) else dao.setState(LocalStateRecord(PREFIX + key, value))
    }

    internal suspend fun states(prefix: String): Map<String, String> = offMain {
        dao.statesWithPrefix(PREFIX + prefix).associate { it.key.removePrefix(PREFIX + prefix) to it.value }
    }

    /** Forgets everything about Drive on this device (another Google account): its data stays. */
    internal suspend fun forget() = offMain { dao.removeStatesWithPrefix(PREFIX) }

    // MARK: For tests

    /** Every record as sync sees it, by `table:row`. */
    internal suspend fun allRecords(): Map<String, SyncRecord> = synced { sync ->
        dao.allSyncMeta().mapNotNull { m -> sync.current(m.tableName, m.rowId)?.let { "${m.tableName}:${m.rowId}" to it } }.toMap()
    }

    /** The ops queued after outbox position [seq]: every change this device made, as it was made. */
    internal suspend fun opsAfter(seq: Long): List<OutboxRecord> = offMain { dao.outboxAfter(seq) }

    /** Breaks the database on purpose (a test of the never-shrink guard): a row disappears with its stamps. */
    internal suspend fun loseRowForTest(table: String, row: String) = offMain {
        dao.eraseSyncMetaRow(table, row)
    }

    internal class Built(val rows: List<SyncRows.Row>, val upTo: Long, val live: Int, val habits: Int)

    internal class Merged(val changed: Int, val deleted: Int, val unreadable: Int, val held: Boolean, val moved: Int, val dirty: Set<String>)

    companion object {
        /** The file for everything that isn't a log of some year. */
        const val BASE = "base"
        internal const val PREFIX = "drive."
        private val DAY = Regex("[0-9]{4}-.*")

        /** The year file a log of [day] belongs to, or null if [day] isn't a date (the log then goes to [BASE]). */
        fun yearOf(day: String?): String? = if (day != null && DAY.matches(day)) day.take(4) else null

        fun isChain(name: String) = name == BASE || Regex("[0-9]{4}").matches(name)

        private fun nextYear(year: String) = (year.toInt() + 1).toString().padStart(4, '0')
    }
}
