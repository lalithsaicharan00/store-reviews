package app.habits.core

import app.habits.sync.SyncRules
import kotlin.uuid.ExperimentalUuidApi
import kotlin.uuid.Uuid
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonNull
import kotlinx.serialization.json.JsonPrimitive

/**
 * Restoring a backup file (Architecture 03 §3.6): what it would change (the preview), and the change itself, worked
 * out by one planner so the preview always tells the truth.
 *
 * - **Replace:** this device becomes exactly the backup. Things added since are removed (as tombstones, so the removal
 *   syncs); things removed since come back. A sync delete is final (05 §7), so a row that was deleted here comes back
 *   under a new ID, with everything that points at it (steps, times, logs, settings keyed by it).
 * - **Merge:** combine by ID; nothing is ever removed. What's missing here is added; a habit edited more recently in
 *   the backup takes the backup's version; anything deleted here stays deleted.
 *
 * Every change goes through [SyncWriter] like any edit, so on a synced device it reaches the other devices, and only
 * because the person chose it (03 §3.6 step 6).
 */
enum class RestoreMode { REPLACE, MERGE }

/** What a restore would do, for the screen that asks "Replace or Merge?". */
data class RestorePreview(
    val createdAt: Long,
    val deviceName: String,
    val platform: String,
    val appVersion: String,
    /** Live habits and logs in the file, and on this device now. */
    val fileHabits: Int,
    val fileEntries: Int,
    val phoneHabits: Int,
    val phoneEntries: Int,
    val replace: RestoreChanges,
    val merge: RestoreChanges,
)

/** Counts of what a restore changes. All zero means it would change nothing ("Everything in it is already here"). */
data class RestoreChanges(
    val habitsAdded: Int,
    val habitsRemoved: Int,
    val habitsUpdated: Int,
    val entriesAdded: Int,
    val entriesRemoved: Int,
    val settingsChanged: Int,
) {
    val changesNothing: Boolean
        get() = habitsAdded == 0 && habitsRemoved == 0 && habitsUpdated == 0 && entriesAdded == 0 && entriesRemoved == 0 && settingsChanged == 0
}

/** A finished restore: what changed, and the file that undoes it (this device as it was just before). */
data class RestoreResult(val changes: RestoreChanges, val undo: BackupFileData)

/** The answer to "can this file be restored?", without throwing (friendlier from Swift). */
data class BackupCheck(
    /** One of [BackupProblem]'s reasons, or null when the file is fine. */
    val problem: String?,
    val preview: RestorePreview?,
)

internal object RestorePlanner {
    class Change(val table: String, val row: String, val fields: Map<String, JsonElement>)
    class Plan(val changes: List<Change>, val counts: RestoreChanges)

    /**
     * [phone] holds every row here, deleted ones included; [knownSettings] every setting key sync has seen here
     * (removed ones too, so Merge doesn't bring back a setting the person removed).
     */
    fun plan(phone: Snapshot, knownSettings: Set<String>, file: Snapshot, mode: RestoreMode, now: Long): Plan =
        when (mode) {
            RestoreMode.REPLACE -> replace(phone, file, now)
            RestoreMode.MERGE -> merge(phone, knownSettings, file)
        }

    private fun replace(phone: Snapshot, file: Snapshot, now: Long): Plan {
        val habits = phone.habits.associateBy { it.id }
        val steps = phone.steps.associateBy { it.id }
        val reminders = phone.reminders.associateBy { it.id }
        val entries = phone.entries.associateBy { it.id }

        // Rows the backup has but that were deleted here can only come back under new IDs. The new ID is derived from
        // the old one (and again, if that one was deleted too), so restoring the same file twice changes nothing.
        val ids = mutableMapOf<String, String>()
        fun rekey(id: String, deletedInFile: Long?, deletedHere: (String) -> Long?) {
            if (deletedInFile != null || deletedHere(id) == null) return
            var candidate = restoredId(id)
            while (deletedHere(candidate) != null) candidate = restoredId(candidate)
            ids[id] = candidate
        }
        file.habits.forEach { rekey(it.id, it.deletedAt) { id -> habits[id]?.deletedAt } }
        file.steps.forEach { rekey(it.id, it.deletedAt) { id -> steps[id]?.deletedAt } }
        file.reminders.forEach { rekey(it.id, it.deletedAt) { id -> reminders[id]?.deletedAt } }
        file.entries.forEach { rekey(it.id, it.deletedAt) { id -> entries[id]?.deletedAt } }
        fun id(old: String) = ids[old] ?: old
        fun text(old: String) = if (ids.isEmpty()) old else ids.entries.fold(old) { s, (from, to) -> if (from in s) s.replace(from, to) else s }

        val fileHabits = file.habits.map { it.copy(id = id(it.id)) }
        val fileSteps = file.steps.map { it.copy(id = id(it.id), habitId = id(it.habitId)) }
        val fileReminders = file.reminders.map { it.copy(id = id(it.id), habitId = id(it.habitId)) }
        val fileEntries = file.entries.map { it.copy(id = id(it.id), habitId = id(it.habitId), stepId = it.stepId?.let(::id)) }
        val fileSettings = file.settings.associate { text(it.key) to text(it.value) }

        val changes = mutableListOf<Change>()
        var habitsAdded = 0; var habitsRemoved = 0; var habitsUpdated = 0
        var entriesAdded = 0; var entriesRemoved = 0; var settingsChanged = 0
        val tombstone = mapOf<String, JsonElement>(SyncRules.DELETED_AT to JsonPrimitive(now))

        fun <T> table(
            name: String, here: Map<String, T>, there: List<T>, rowId: (T) -> String, deleted: (T) -> Long?, fields: (T) -> Map<String, JsonElement>,
            added: () -> Unit = {}, removed: () -> Unit = {}, updated: () -> Unit = {},
        ) {
            val liveThere = there.filter { deleted(it) == null }.map(rowId).toSet()
            for (row in here.values) if (deleted(row) == null && rowId(row) !in liveThere) { changes += Change(name, rowId(row), tombstone); removed() }
            for (row in there) {
                if (deleted(row) != null) continue // deleted in the backup: covered above if it's live here
                val current = here[rowId(row)]
                val wanted = fields(row)
                when {
                    current == null -> { changes += Change(name, rowId(row), wanted); added() }
                    fields(current) != wanted -> { changes += Change(name, rowId(row), wanted); updated() }
                }
            }
        }
        table(SyncCodec.HABIT, habits, fileHabits, { it.id }, { it.deletedAt }, SyncCodec::habit, { habitsAdded++ }, { habitsRemoved++ }, { habitsUpdated++ })
        table(SyncCodec.STEP, steps, fileSteps, { it.id }, { it.deletedAt }, SyncCodec::step)
        table(SyncCodec.REMINDER, reminders, fileReminders, { it.id }, { it.deletedAt }, SyncCodec::reminder)
        table(SyncCodec.ENTRY, entries, fileEntries, { it.id }, { it.deletedAt }, SyncCodec::entry, { entriesAdded++ }, { entriesRemoved++ })

        val settings = phone.settings.filterNot { SyncCodec.isLocalSetting(it.key) }.associate { it.key to it.value }
        for (key in settings.keys - fileSettings.keys) { changes += Change(SyncCodec.SETTING, key, mapOf("value" to JsonNull)); settingsChanged++ }
        for ((key, value) in fileSettings) if (settings[key] != value) { changes += Change(SyncCodec.SETTING, key, mapOf("value" to JsonPrimitive(value))); settingsChanged++ }

        return Plan(changes, RestoreChanges(habitsAdded, habitsRemoved, habitsUpdated, entriesAdded, entriesRemoved, settingsChanged))
    }

    private fun merge(phone: Snapshot, knownSettings: Set<String>, file: Snapshot): Plan {
        val habits = phone.habits.associateBy { it.id }
        val known = mapOf(
            SyncCodec.STEP to phone.steps.map { it.id }.toSet(),
            SyncCodec.REMINDER to phone.reminders.map { it.id }.toSet(),
            SyncCodec.ENTRY to phone.entries.map { it.id }.toSet(),
        )
        val changes = mutableListOf<Change>()
        var habitsAdded = 0; var habitsUpdated = 0; var entriesAdded = 0; var settingsChanged = 0
        val liveAfter = phone.habits.filter { it.deletedAt == null }.map { it.id }.toMutableSet()

        for (habit in file.habits) {
            val here = habits[habit.id]
            when {
                here == null -> {
                    changes += Change(SyncCodec.HABIT, habit.id, SyncCodec.habit(habit))
                    if (habit.deletedAt == null) { habitsAdded++; liveAfter += habit.id }
                }
                // Edited more recently in the backup, and live on both sides: the backup's version wins.
                here.deletedAt == null && habit.deletedAt == null && habit.updatedAt > here.updatedAt && SyncCodec.habit(habit) != SyncCodec.habit(here) -> {
                    changes += Change(SyncCodec.HABIT, habit.id, SyncCodec.habit(habit))
                    habitsUpdated++
                }
            }
        }
        for (step in file.steps) if (step.id !in known.getValue(SyncCodec.STEP)) changes += Change(SyncCodec.STEP, step.id, SyncCodec.step(step))
        for (time in file.reminders) if (time.id !in known.getValue(SyncCodec.REMINDER)) changes += Change(SyncCodec.REMINDER, time.id, SyncCodec.reminder(time))
        for (entry in file.entries) {
            if (entry.id in known.getValue(SyncCodec.ENTRY)) continue
            changes += Change(SyncCodec.ENTRY, entry.id, SyncCodec.entry(entry))
            if (entry.deletedAt == null && entry.habitId in liveAfter) entriesAdded++
        }
        val settingsHere = knownSettings + phone.settings.map { it.key }
        for (setting in file.settings) {
            if (SyncCodec.isLocalSetting(setting.key) || setting.key in settingsHere) continue
            changes += Change(SyncCodec.SETTING, setting.key, SyncCodec.setting(setting))
            settingsChanged++
        }
        return Plan(changes, RestoreChanges(habitsAdded, 0, habitsUpdated, entriesAdded, 0, settingsChanged))
    }

    /** A UUID made from [id]: the same every time, so every device and every retry agrees on it. */
    @OptIn(ExperimentalUuidApi::class)
    fun restoredId(id: String): String {
        val bytes = Sha256.digest("restored:$id".encodeToByteArray()).copyOf(16)
        bytes[6] = ((bytes[6].toInt() and 0x0f) or 0x80).toByte() // version 8: custom
        bytes[8] = ((bytes[8].toInt() and 0x3f) or 0x80).toByte() // RFC 4122 variant
        return Uuid.fromByteArray(bytes).toString()
    }
}
