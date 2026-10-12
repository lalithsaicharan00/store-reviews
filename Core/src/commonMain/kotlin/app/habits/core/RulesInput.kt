package app.habits.core

import app.habits.rules.Day
import app.habits.rules.Entry
import app.habits.rules.Habit
import app.habits.rules.Rows

/**
 * The habit rules' data (Core/rules, Core/spec/) from the database's own records: what the apps hand the rules after a
 * load, a log or an edit (Current Work 92). Field for field; nothing is guessed.
 */
object RulesInput {
    fun habitRow(r: HabitRecord) = Rows.HabitRow(
        r.id, r.kind, r.unit, r.increment, r.part, r.goal, r.frequency, r.dueDay, r.atMost, r.quitSince, r.position,
        r.createdAt, r.archivedAt, r.startsOn, r.endsOn, r.deletedAt,
    )

    fun stepRow(r: StepRecord) = Rows.StepRow(r.id, r.habitId, r.position, r.deletedAt)
    fun reminderRow(r: ReminderRecord) = Rows.ReminderRow(r.id, r.habitId, r.hour, r.minute, r.deletedAt)
    fun entryRow(r: EntryRecord) = Rows.EntryRow(r.id, r.habitId, r.stepId, r.day, r.value, r.createdAt, r.timeZone, r.slot, r.deletedAt)

    /** One log, or null when its day isn't a real date (the iPhone skips such a row too). */
    fun entry(r: EntryRecord): Entry? = Day.parse(r.day)?.let { Entry(r.id, r.habitId, r.stepId, it, r.value, r.createdAt, r.timeZone, r.slot) }

    /** One habit (a saved one or a form's draft), or null for one this version can't read. */
    fun habit(r: HabitRecord, steps: List<StepRecord>, reminders: List<ReminderRecord>): Habit? =
        Rows.habit(habitRow(r), steps.filter { it.deletedAt == null }.sortedBy { it.position }.map(::stepRow),
            reminders.filter { it.deletedAt == null }.sortedWith(compareBy({ it.hour }, { it.minute })).map(::reminderRow))

    /** Everything a load read. [defaultWeekStart]: the phone's region's, when the person never chose one. */
    fun load(snapshot: Snapshot, timeZone: String, defaultWeekStart: Int): Rows.Loaded = Rows.load(
        snapshot.habits.map(::habitRow), snapshot.steps.map(::stepRow), snapshot.reminders.map(::reminderRow),
        snapshot.entries.map(::entryRow), snapshot.settings.associate { it.key to it.value }, timeZone, defaultWeekStart,
    )
}
