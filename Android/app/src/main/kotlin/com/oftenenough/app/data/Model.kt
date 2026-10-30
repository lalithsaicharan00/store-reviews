package com.oftenenough.app.data

import java.util.UUID

// The app's own model of a habit, the same as the iPhone's `Habit` (iOS/Habits/Model/Habit.swift), field for field, so
// a habit saved here reads the same on the iPhone and back. Days are day numbers (days since 1 January 1970, the same as
// `java.time.LocalDate.toEpochDay`); moments are epoch milliseconds. The rules that judge habits are reached only
// through RulesGateway.

/** A new permanent ID, as the iPhone makes them (`UUID().uuidString`: upper case). */
fun newId(): String = UUID.randomUUID().toString().uppercase()

/** What a habit measures. */
sealed class HabitKind {
    /** Done or not done, once or more a day. */
    data object Check : HabitKind()
    /** An amount with a unit, logged in steps of [increment] (0: + asks how much). */
    data class Amount(val unit: String, val increment: Double) : HabitKind()
    /** Minutes, logged with a timer. */
    data object Duration : HabitKind()
    /** A list of steps, all ticked to finish the day. */
    data object Checklist : HabitKind()
    /** Time since the last slip, counted up live. */
    data object Quit : HabitKind()
    /** Done once, on a day; or a repeating task. */
    data object Task : HabitKind()

    val storageName: String get() = when (this) {
        Check -> "check"; is Amount -> "amount"; Duration -> "duration"; Checklist -> "checklist"; Quit -> "quit"; Task -> "task"
    }
}

/** A goal's period: day, week, month, year (the iPhone's `GoalPeriod` and `ScheduleUnit` share these names). */
enum class GoalPeriod(val key: String) {
    DAY("day"), WEEK("week"), MONTH("month"), YEAR("year");

    val noun: String get() = key
    val plural: String get() = key + "s"

    companion object {
        fun of(key: String): GoalPeriod? = entries.firstOrNull { it.key == key }
    }
}

/** A calendar rule ("every other week on Saturday"); the iPhone's `CalendarSchedule`. */
data class CalendarRule(
    val unit: GoalPeriod = GoalPeriod.DAY,
    val interval: Int = 2,
    val weekdays: Set<Int> = emptySet(),
    val dates: Set<Int> = emptySet(),
    /** "Dates", "Last day" or "Weekday". */
    val pattern: String = "Dates",
    val ordinal: Int = 1,
    val weekday: Int = 1,
    val month: Int = 1,
    val day: Int = 1,
    val useLastDay: Boolean = true,
    val anchorWeekStart: Int = 2,
)

/** How often; the iPhone's `Frequency`, case for case. Weekdays are 1 = Sunday … 7 = Saturday. */
sealed class Frequency {
    data object Daily : Frequency()
    data class Weekdays(val days: Set<Int>) : Frequency()
    data class EveryNDays(val n: Int) : Frequency()
    data class EveryNWeeks(val n: Int) : Frequency()
    data class MonthDates(val dates: Set<Int>) : Frequency()
    data class PerWeek(val n: Int) : Frequency()
    data class PerMonth(val n: Int) : Frequency()
    data class PerYear(val n: Int) : Frequency()
    data class Flexible(val period: GoalPeriod, val n: Int) : Frequency()
    data class Calendar(val rule: CalendarRule) : Frequency()
    data class AfterCompletion(val n: Int, val unit: GoalPeriod) : Frequency()

    val isDayBased: Boolean get() = this !is PerWeek && this !is PerMonth && this !is PerYear
    val isFlexible: Boolean get() = this is Flexible

    /** "week", "month", "year" for a count over a period; "day" otherwise. */
    val periodNoun: String get() = when (this) {
        is PerWeek -> "week"; is PerMonth -> "month"; is PerYear -> "year"; is Flexible -> period.noun; else -> "day"
    }

    val streakUnit: StreakUnit get() = when (this) {
        Daily -> StreakUnit.DAYS
        is Weekdays -> if (days.size == 7) StreakUnit.DAYS else StreakUnit.TIMES
        is EveryNDays, is EveryNWeeks, is MonthDates, is Calendar, is AfterCompletion -> StreakUnit.TIMES
        is Flexible -> when (period) { GoalPeriod.WEEK -> StreakUnit.WEEKS; GoalPeriod.MONTH -> StreakUnit.MONTHS; GoalPeriod.YEAR -> StreakUnit.YEARS; GoalPeriod.DAY -> StreakUnit.DAYS }
        is PerWeek -> StreakUnit.WEEKS
        is PerMonth -> StreakUnit.MONTHS
        is PerYear -> StreakUnit.YEARS
    }
}

/** What a streak counts, so its number is never mistaken for days. */
enum class StreakUnit {
    DAYS, TIMES, WEEKS, MONTHS, YEARS;

    /** Beside the flame: "6", "6×", "3 wk", "2 mo", "1 yr". */
    fun short(n: Int): String = when (this) {
        DAYS -> "$n"; TIMES -> "$n×"; WEEKS -> "$n wk"; MONTHS -> "$n mo"; YEARS -> "$n yr"
    }

    /** The sentence read by TalkBack and shown when the streak is tapped. */
    fun explained(n: Int): String = when (this) {
        DAYS -> if (n == 1) "Done 1 day in a row" else "Done $n days in a row"
        TIMES -> if (n == 1) "Done the last time it came round" else "Done the last $n times in a row"
        WEEKS -> if (n == 1) "Goal met 1 week in a row" else "Goal met $n weeks in a row"
        MONTHS -> if (n == 1) "Goal met 1 month in a row" else "Goal met $n months in a row"
        YEARS -> if (n == 1) "Goal met 1 year in a row" else "Goal met $n years in a row"
    }

    /** "7 days in a row", "3 weeks in a row" (milestones). */
    fun inARow(n: Int): String = when (this) {
        DAYS -> "$n ${if (n == 1) "day" else "days"} in a row"
        TIMES -> "$n ${if (n == 1) "time" else "times"} in a row"
        WEEKS -> "$n ${if (n == 1) "week" else "weeks"} in a row"
        MONTHS -> "$n ${if (n == 1) "month" else "months"} in a row"
        YEARS -> "$n ${if (n == 1) "year" else "years"} in a row"
    }
}

/** One of a habit's times, in the phone's local clock. A time places the habit on Today; with Remind me on, it notifies. */
data class ReminderTime(val id: String = newId(), val hour: Int, val minute: Int) {
    val minuteOfDay: Int get() = hour * 60 + minute
}

data class Step(val id: String = newId(), val name: String)

/** The 13 habit colours, by the names saved in the database (the iPhone's `HabitColor`). */
enum class HabitColor(val key: String) {
    RED("red"), ORANGE("orange"), YELLOW("yellow"), GREEN("green"), MINT("mint"), TEAL("teal"), CYAN("cyan"),
    BLUE("blue"), INDIGO("indigo"), PURPLE("purple"), PINK("pink"), BROWN("brown"), GRAY("gray");

    companion object {
        fun of(key: String): HabitColor? = entries.firstOrNull { it.key == key }
    }
}

/** A time of day: Anytime, or a named part of the day with a start (minutes after midnight). */
data class DaySection(val id: String, val name: String, val start: Int?, val end: Int?) {
    val isAnytime: Boolean get() = start == null

    companion object {
        const val ANYTIME = "anytime"
        const val MORNING = "morning"
        const val AFTERNOON = "afternoon"
        const val EVENING = "evening"
        /** Today's "Quit or cut down" card (not a time of day): quit habits and limits. */
        const val QUITTING = "quitting"
        val defaults = listOf(
            DaySection(ANYTIME, "Anytime", null, null),
            DaySection(MORNING, "Morning", 6 * 60, null),
            DaySection(AFTERNOON, "Afternoon", 12 * 60, null),
            DaySection(EVENING, "Evening", 18 * 60, 24 * 60),
        )
    }
}

data class Habit(
    val id: String = newId(),
    val name: String,
    val symbol: String,
    val color: HabitColor,
    val kind: HabitKind,
    /** The time-of-day IDs for a habit with no times; ignored while it has times. */
    val parts: List<String> = listOf(DaySection.ANYTIME),
    val goal: Double = 1.0,
    val frequency: Frequency = Frequency.Daily,
    /** Check it off: what one tick counts ("glasses"); null means "times". Stored in the unit column. */
    val checkUnit: String? = null,
    /** The goal is a maximum ("no more than 2 coffees"). */
    val atMost: Boolean = false,
    val dueDay: Int? = null,
    val dueMinute: Int? = null,
    val steps: List<Step> = emptyList(),
    val reminders: List<ReminderTime> = emptyList(),
    val remind: Boolean = true,
    /** "notification" or "alarm". */
    val alert: String = "notification",
    val followUpMinutes: Int? = null,
    val startsOn: Int? = null,
    val endsOn: Int? = null,
    val reminderText: String? = null,
    val quitSince: Long? = null,
    val createdAt: Long = System.currentTimeMillis(),
    val archived: Boolean = false,
) {
    /** Quit habits and limits: logged only when they happen. They share Today's "Quit or cut down" card. */
    val isQuitOrLimit: Boolean get() = kind == HabitKind.Quit || (atMost && kind != HabitKind.Task)

    /** What + adds, or null when + asks how much (or the habit has no +). */
    val quickIncrement: Double? get() = (kind as? HabitKind.Amount)?.increment?.takeIf { it > 0 }

    /** The unit the habit is counted in, if any. */
    val unit: String get() = when (kind) {
        is HabitKind.Amount -> kind.unit
        HabitKind.Check -> checkUnit ?: ""
        else -> ""
    }
}

/** Where a log came from (the iPhone's `EntrySource`). */
enum class EntrySource(val key: String) {
    TODAY("today"), MANUAL("manual"), ROUTINE("routine"), REMINDER("reminder"), TIMER("timer"), DAY_SHEET("daySheet"),
    SHORTCUT("shortcut"), WIDGET("widget"), WATCH("watch");

    companion object {
        fun of(key: String?): EntrySource? = entries.firstOrNull { it.key == key }
    }
}

/** One thing logged. Its ID is made at the tap, so the same tap saved twice counts once. */
data class Entry(
    val id: String = newId(),
    val habitId: String,
    val stepId: String? = null,
    val day: Int,
    val value: Double,
    val createdAt: Long = System.currentTimeMillis(),
    val timeZone: String = java.util.TimeZone.getDefault().id,
    val slot: String? = null,
    val source: EntrySource? = null,
)

/** What a habit was judged by until a day (goal history). */
data class HabitRule(
    val until: Int,
    val goal: Double,
    val frequency: Frequency,
    val kind: HabitKind,
    val checkUnit: String?,
    val steps: List<Step>,
) {
    fun applyTo(habit: Habit): Habit = habit.copy(goal = goal, frequency = frequency, kind = kind, checkUnit = checkUnit, steps = steps)

    /** Whether [habit] would judge a day differently. Renaming a step or changing + doesn't. */
    fun judgesDifferently(habit: Habit): Boolean {
        var kindChanged = kind != habit.kind
        if (kind is HabitKind.Amount && habit.kind is HabitKind.Amount) kindChanged = kind.unit != habit.kind.unit
        return goal != habit.goal || frequency != habit.frequency || kindChanged || checkUnit != habit.checkUnit ||
            steps.map { it.id } != habit.steps.map { it.id }
    }

    companion object {
        fun of(habit: Habit, until: Int) = HabitRule(until, habit.goal, habit.frequency, habit.kind, habit.checkUnit, habit.steps)
    }
}

/** A stretch of paused days ([through] null: until turned back on). Kept after it ends. */
data class HabitPause(val from: Int, val through: Int?, val pausedAt: Long, val resumedAt: Long? = null) {
    operator fun contains(day: Int): Boolean = from <= day && (through == null || day <= through)
}

data class HabitCost(val amount: Double, val currency: String)

/** Text limits, the iPhone's `TextLimit` (U6). */
object TextLimit {
    const val NAME = 24
    const val CHECKLIST_PART = 24
    const val SECTION = 16
    const val UNIT = 12
    const val NOTE = 1000
    const val DESCRIPTION = 200
    const val REMINDER_TEXT = 24

    /** "3 characters left", only in the last 5. */
    fun note(text: String, limit: Int): String? {
        val left = limit - text.length
        if (left > 5) return null
        return if (left <= 0) "That's the most: $limit characters." else if (left == 1) "1 character left" else "$left characters left"
    }

    fun clean(text: String, limit: Int): String = text.trim().take(limit)
}

/** The largest number a goal or a log can be. */
const val GOAL_MAXIMUM = 9_000_000_000_000.0
