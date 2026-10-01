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
