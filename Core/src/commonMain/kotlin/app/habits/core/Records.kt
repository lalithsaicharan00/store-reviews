package app.habits.core

import androidx.room3.ColumnInfo
import androidx.room3.Entity
import androidx.room3.Index
import androidx.room3.PrimaryKey

// The tables. Every row has a permanent UUID made on the device, and rows are never hard-deleted:
// `deletedAt` marks a tombstone, so a later sync can never bring a deleted row back
// (Architecture 05 §3, §7). Times are epoch milliseconds; days are "YYYY-MM-DD" in the user's calendar.

@Entity(tableName = "habit")
data class HabitRecord(
    @PrimaryKey val id: String,
    val name: String,
    val symbol: String,
    val color: String,
    /** check, amount, duration, checklist, quit or task. */
    val kind: String,
    /** Amount habits: the unit ("glasses"). */
    val unit: String?,
    /** Amount habits: what one tap adds. */
    val increment: Double,
    /** The day section (`anytime`, `morning`, … or a UUID) for a habit with no times. Since schema 4, a habit's
     *  times decide where it shows; this is only used while it has none. (Schema 3 builds could store several, comma-separated.) */
    val part: String,
    val goal: Double,
    /** Unused since schema 2 (replaced by `frequency`); kept because columns are never dropped in the release that stops using them. */
    val period: String,
    /** Unused since schema 2 (replaced by `frequency`). */
    @ColumnInfo(name = "schedule_days") val scheduleDays: String?,
    /** How often (schema 2): `daily`, `weekdays:2,4,6` (1 = Sunday), `every:3` (days), `weeks:2`, `dates:1,15` (of the month), or `week:3`, `month:4`, `year:6` (times per period). A new value needs no schema change; readers skip values they do not know. */
    @ColumnInfo(defaultValue = "'daily'") val frequency: String,
    /** One-time tasks (schema 2): the day it is for, "YYYY-MM-DD". */
    @ColumnInfo(name = "due_day") val dueDay: String?,
    /** One-time tasks (schema 2): an optional time, as minutes after midnight. */
    @ColumnInfo(name = "due_minute") val dueMinute: Int?,
    @ColumnInfo(name = "at_most") val atMost: Boolean,
    @ColumnInfo(name = "quit_since") val quitSince: Long?,
    val position: Int,
    @ColumnInfo(name = "created_at") val createdAt: Long,
    @ColumnInfo(name = "updated_at") val updatedAt: Long,
    @ColumnInfo(name = "archived_at") val archivedAt: Long?,
    @ColumnInfo(name = "deleted_at") val deletedAt: Long?,
    /** Schema 4: "Remind Me". When false, the habit's times only place it on Today. */
    @ColumnInfo(defaultValue = "1") val remind: Boolean = true,
    /** Schema 4: `notification` or `alarm`. Readers treat values they don't know as `notification`. */
    @ColumnInfo(defaultValue = "'notification'") val alert: String = "notification",
    /** Schema 4: "Remind Again If Not Done", in minutes (15, 30 or 60); null when off. */
    @ColumnInfo(name = "follow_up_minutes") val followUpMinutes: Int? = null,
    /** Schema 5: the first day it counts ("YYYY-MM-DD"), past or future; null means the day it was made. */
    @ColumnInfo(name = "starts_on") val startsOn: String? = null,
    /** Schema 5: the last day it's due ("YYYY-MM-DD"); null means it never ends. */
    @ColumnInfo(name = "ends_on") val endsOn: String? = null,
    /** Schema 8: "Reminder says…", the person's own words for this habit's reminders (24 characters at most); null
     *  when none. Shown instead of the habit's name while names are hidden outside the app. */
    @ColumnInfo(name = "reminder_text") val reminderText: String? = null,
)

@Entity(tableName = "step", indices = [Index("habit_id")])
data class StepRecord(
    @PrimaryKey val id: String,
    @ColumnInfo(name = "habit_id") val habitId: String,
    val name: String,
    val position: Int,
    @ColumnInfo(name = "deleted_at") val deletedAt: Long?,
)

/** A habit's times. Since schema 4 they decide where it shows on Today; `habit.remind` decides whether they notify. */
@Entity(tableName = "reminder", indices = [Index("habit_id")])
data class ReminderRecord(
    @PrimaryKey val id: String,
    @ColumnInfo(name = "habit_id") val habitId: String,
    val hour: Int,
    val minute: Int,
    @ColumnInfo(name = "deleted_at") val deletedAt: Long?,
)

/** One thing the user logged. Its ID is made at the tap, so the same tap saved twice counts once. */
@Entity(tableName = "entry", indices = [Index("habit_id", "day")])
data class EntryRecord(
    @PrimaryKey val id: String,
    @ColumnInfo(name = "habit_id") val habitId: String,
    @ColumnInfo(name = "step_id") val stepId: String?,
    val day: String,
    val value: Double,
    @ColumnInfo(name = "created_at") val createdAt: Long,
    @ColumnInfo(name = "time_zone") val timeZone: String,
    @ColumnInfo(name = "deleted_at") val deletedAt: Long?,
    /** Schema 3: the day section a tick belongs to, for a habit done once in each of several sections. */
    val slot: String?,
    /** Unknown for logs saved before schema 6. */
    val source: String? = null,
)

@Entity(tableName = "setting")
data class SettingRecord(
    @PrimaryKey val key: String,
    val value: String,
)

/** Everything the app needs at launch, read in one transaction. */
data class Snapshot(
    val habits: List<HabitRecord>,
    val steps: List<StepRecord>,
    val reminders: List<ReminderRecord>,
    val entries: List<EntryRecord>,
    val settings: List<SettingRecord>,
)

// Sync (schema 6). Local bookkeeping only: none of these rows are synced themselves.

/**
 * A change that hasn't reached iCloud yet (Architecture 05 §5, 11 §7). Written in the same transaction as the change
 * itself and removed only when CloudKit confirms a saved record that contains it, so a crash, a full iCloud or a dead
 * network never loses one. `problem` is set when the change can never be accepted (a record too large, refused); it's
 * then kept aside instead of being retried forever, and the iCloud page says so.
 */
@Entity(tableName = "outbox", indices = [Index("op_id", unique = true), Index("table_name", "row_id")])
data class OutboxRecord(
    @PrimaryKey(autoGenerate = true) val seq: Long = 0,
    @ColumnInfo(name = "op_id") val opId: String,
    /** The op as JSON. */
    val op: String,
    val problem: String? = null,
    /** Schema 9: the row the op changes and its stamp, so a confirmed save removes exactly the ops it contained. */
    @ColumnInfo(name = "table_name") val tableName: String? = null,
    @ColumnInfo(name = "row_id") val rowId: String? = null,
    val hlc: String? = null,
    /** Schema 9: 0 when the op doesn't delete its row, 1 when it does (`deleted_at` set), 2 when it does as part of one
     *  explicit action the person confirmed (a restore that replaces). For the mass-change brake (11 §13.2). */
    @ColumnInfo(defaultValue = "0") val deletes: Int = 0,
)

/**
 * How sync sees one row: the stamp of the change that set each field, and any fields this app version doesn't know
 * (kept and passed on, 05 §12). Most rows have one stamp for every field, so only the exceptions are listed.
 */
@Entity(tableName = "sync_meta", primaryKeys = ["table_name", "row_id"])
data class SyncMetaRecord(
    @ColumnInfo(name = "table_name") val tableName: String,
    @ColumnInfo(name = "row_id") val rowId: String,
    /** The stamp most fields share. */
    val hlc: String,
    /** JSON `{field: stamp}` for fields whose stamp differs from `hlc`, or null. */
    val clocks: String?,
    /** JSON `{field: value}` for fields this version doesn't store in the row, or null. */
    val extra: String?,
    /** True when the row can't be built yet (a change arrived before the record was complete); all fields are in `extra`. */
    val pending: Boolean,
    /** Schema 9: the row's CloudKit record system fields (`encodeSystemFields`, base64), so a save isn't a conflict. */
    @ColumnInfo(name = "ck_system") val ckSystem: String? = null,
)

/** This device's sync state: its clock, its node ID, the account it syncs with, and iCloud's engine state (`cloud.*`). */
@Entity(tableName = "local_state")
data class LocalStateRecord(
    @PrimaryKey val key: String,
    val value: String,
)
