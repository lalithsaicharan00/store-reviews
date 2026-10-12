package com.oftenenough.app.data

import app.habits.core.EntryRecord
import app.habits.core.HabitRecord
import app.habits.core.ReminderRecord
import app.habits.core.StepRecord
import java.time.LocalDate

// Between the app's model and the database's rows (the iPhone's RecordMapping.swift): field for field, nothing guessed.

/** "2026-10-12" for a day number, as the database keeps days. */
fun dayKey(day: Int): String = LocalDate.ofEpochDay(day.toLong()).toString()

/** A day key, or null when it isn't a real date (the iPhone's `LocalDay(key:)`). */
fun parseDay(key: String?): Int? {
    if (key == null) return null
    val parts = key.split("-")
    if (parts.size != 3 || parts.any { p -> p.isEmpty() || p.any { it !in '0'..'9' } }) return null
    val y = parts[0].toIntOrNull() ?: return null
    val m = parts[1].toIntOrNull() ?: return null
    val d = parts[2].toIntOrNull() ?: return null
    if (y !in 1..9999 || m !in 1..12) return null
    return try { LocalDate.of(y, m, d).toEpochDay().toInt() } catch (_: Exception) { null }
}

fun Habit.record(position: Int, now: Long = System.currentTimeMillis(), deleted: Boolean = false): HabitRecord {
    var unit: String? = null
    var increment = 1.0
    when (kind) {
        HabitKind.Check -> unit = checkUnit
        is HabitKind.Amount -> { unit = kind.unit; increment = kind.increment }
        else -> {}
    }
    return HabitRecord(
        id = id, name = name, symbol = symbol, color = color.key, kind = kind.storageName, unit = unit, increment = increment,
        part = parts.joinToString(","), goal = goal, period = "day", scheduleDays = null,
        frequency = SwiftJson.storageKey(frequency), dueDay = dueDay?.let(::dayKey), dueMinute = dueMinute, atMost = atMost,
        quitSince = quitSince, position = position, createdAt = createdAt, updatedAt = now,
        archivedAt = if (archived) now else null, deletedAt = if (deleted) now else null,
        remind = remind, alert = alert, followUpMinutes = followUpMinutes, startsOn = startsOn?.let(::dayKey),
        endsOn = endsOn?.let(::dayKey), reminderText = reminderText,
    )
}

fun Habit.stepRecords(): List<StepRecord> = steps.mapIndexed { i, s -> StepRecord(s.id, id, s.name, i, null) }

fun Habit.reminderRecords(): List<ReminderRecord> = reminders.map { ReminderRecord(it.id, id, it.hour, it.minute, null) }

/** Null for a row this version can't read, so it is skipped rather than guessed at. */
fun habitOf(r: HabitRecord, steps: List<StepRecord>, reminders: List<ReminderRecord>): Habit? {
    val color = HabitColor.of(r.color) ?: return null
    val frequency = SwiftJson.frequency(r.frequency) ?: return null
    val kind = when (r.kind) {
        "check" -> HabitKind.Check
        "amount" -> HabitKind.Amount(r.unit ?: "", r.increment)
        "duration" -> HabitKind.Duration
        "checklist" -> HabitKind.Checklist
        "quit" -> HabitKind.Quit
        "task" -> HabitKind.Task
        else -> return null
    }
    return Habit(
        id = r.id, name = r.name, symbol = r.symbol, color = color, kind = kind,
        parts = r.part.split(",").map { it.trim() }.filter { it.isNotEmpty() }.ifEmpty { listOf(DaySection.ANYTIME) },
        goal = r.goal, frequency = frequency,
        checkUnit = if (kind == HabitKind.Check) r.unit?.takeIf { it.isNotEmpty() && it != "times" } else null,
        atMost = r.atMost, dueDay = parseDay(r.dueDay), dueMinute = r.dueMinute,
        steps = steps.filter { it.habitId == r.id && it.deletedAt == null }.sortedBy { it.position }.map { Step(it.id, it.name) },
        reminders = reminders.filter { it.habitId == r.id && it.deletedAt == null }.map { ReminderTime(it.id, it.hour, it.minute) },
        remind = r.remind, alert = if (r.alert == "alarm") "alarm" else "notification", followUpMinutes = r.followUpMinutes,
        startsOn = parseDay(r.startsOn), endsOn = parseDay(r.endsOn), reminderText = r.reminderText?.takeIf { it.isNotEmpty() },
        quitSince = r.quitSince, createdAt = r.createdAt, archived = r.archivedAt != null,
    )
}

val Entry.record: EntryRecord
    get() = EntryRecord(id, habitId, stepId, dayKey(day), value, createdAt, timeZone, null, slot, source?.key)

fun entryOf(r: EntryRecord): Entry? {
    val day = parseDay(r.day) ?: return null
    return Entry(r.id, r.habitId, r.stepId, day, r.value, r.createdAt, r.timeZone, r.slot, EntrySource.of(r.source))
}
