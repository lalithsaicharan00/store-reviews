package app.habits.rules

/** What a habit measures (spec/goals.md G-1). */
enum class Kind { CHECK, AMOUNT, DURATION, CHECKLIST, QUIT, TASK;

    companion object {
        /** The database's `kind` column; null for a kind this version can't read (the habit is then left out). */
        fun parse(name: String): Kind? = when (name) {
            "check" -> CHECK
            "amount" -> AMOUNT
            "duration" -> DURATION
            "checklist" -> CHECKLIST
            "quit" -> QUIT
            "task" -> TASK
            else -> null
        }
    }
}

/** A goal's period (spec/goals.md). */
enum class Period { DAY, WEEK, MONTH, YEAR;

    val key: String get() = name.lowercase()

    companion object {
        fun parse(name: String): Period? = entries.firstOrNull { it.key == name }
    }
}

/** A calendar rule ("every other week on Saturday", "the second Tuesday of each month"): spec/schedules.md S-3. */
data class CalendarSchedule(
    val unit: Period = Period.DAY,
    val interval: Int = 2,
    val weekdays: Set<Int> = emptySet(),
    val dates: Set<Int> = emptySet(),
    /** "Dates", "Last day" or "Weekday". */
    val pattern: String = "Dates",
    /** 1…5, or -1 for the last. */
    val ordinal: Int = 1,
    val weekday: Int = 1,
    val month: Int = 1,
    val day: Int = 1,
    val useLastDay: Boolean = true,
    /** The week start when the rule was made: later changes to the week start never move its days. */
    val anchorWeekStart: Int = 2,
)

/** How often (spec/schedules.md S-2): exactly the iPhone's `Frequency`, case for case. */
sealed class Frequency {
    data object Daily : Frequency()
    data class Weekdays(val days: Set<Int>) : Frequency()
    data class EveryNDays(val n: Int) : Frequency()
    data class EveryNWeeks(val n: Int) : Frequency()
    data class MonthDates(val dates: Set<Int>) : Frequency()
    data class PerWeek(val n: Int) : Frequency()
    data class PerMonth(val n: Int) : Frequency()
    data class PerYear(val n: Int) : Frequency()
    data class Flexible(val period: Period, val n: Int) : Frequency()
    data class Calendar(val rule: CalendarSchedule) : Frequency()
    data class AfterCompletion(val n: Int, val unit: Period) : Frequency()

    /** Judged day by day (a week, month or year count or total isn't). */
    val isDayBased: Boolean get() = this !is PerWeek && this !is PerMonth && this !is PerYear
    val isFlexible: Boolean get() = this is Flexible
}

/** What judges a habit's days: the parts goal history keeps (spec/schedules.md S-6). */
data class Judging(
    val kind: Kind,
    val goal: Double,
    val frequency: Frequency,
    /** Amount habits: the unit; check habits: what one tick counts (null: "times"). */
    val unit: String?,
    val increment: Double,
    val steps: List<String>,
)

/** One habit, as the rules see it. [judging] is today's; [rules] are the earlier ones, oldest first. */
class Habit(
    val id: String,
    val judging: Judging,
    val atMost: Boolean,
    /** Day section IDs for a habit with no times ("anytime", "morning", … or the person's own). */
    val parts: List<String>,
    /** Its times, as minutes after midnight, in the database's order (hour, then minute). */
    val times: List<Int>,
    val dueDay: Int?,
    val startsOn: Int?,
    val endsOn: Int?,
    /** Quit habits: when the current run was said to start, epoch ms. */
    val quitSince: Long?,
    val createdAt: Long,
    val archived: Boolean,
    val position: Int = 0,
) {
    val kind get() = judging.kind
    val goal get() = judging.goal
    val frequency get() = judging.frequency
    val steps get() = judging.steps
    val isQuitOrLimit get() = kind == Kind.QUIT || (atMost && kind != Kind.TASK)

    /** Its part of the data the rules last found for it ([HabitData.facts]), and which data that was. */
    internal var facts: HabitFacts? = null
    internal var factsOf: HabitData? = null
    /** It judged by each of its earlier rules ([HabitRules.rule]), for the [HabitFacts] they were found in. */
    internal var judged: Array<Habit?>? = null
    internal var judgedOf: HabitFacts? = null

    /** This habit judged by [other] (an earlier rule): everything else stays, its part of the data too. */
    fun judgedBy(other: Judging): Habit {
        if (other == judging) return this
        val judged = Habit(id, other, atMost, parts, times, dueDay, startsOn, endsOn, quitSince, createdAt, archived, position)
        judged.facts = facts
        judged.factsOf = factsOf
        return judged
    }
}

/** An earlier rule: [judging] applied up to and including [until]. */
data class PastRule(val until: Int, val judging: Judging)

/** One log. [day] is the day it counts for, kept as saved (spec/day.md DAY-4). */
class Entry(
    val id: String,
    val habitId: String,
    val stepId: String?,
    val day: Int,
    val value: Double,
    val createdAt: Long,
    val timeZone: String,
    val slot: String?,
)

/** A stretch of paused days ([through] null: until turned back on). Moments are epoch ms. */
data class Pause(val from: Int, val through: Int?, val pausedAt: Long, val resumedAt: Long?) {
    operator fun contains(day: Int) = from <= day && (through == null || day <= through)
}

/** A time of day ([start] null only for Anytime); only the latest keeps its own [end]. Minutes after midnight. */
data class DaySection(val id: String, val name: String, val start: Int?, val end: Int?) {
    val isAnytime get() = start == null

    companion object {
        const val ANYTIME = "anytime"
        const val QUITTING = "quitting"
        val defaults = listOf(
            DaySection("anytime", "Anytime", null, null),
            DaySection("morning", "Morning", 6 * 60, null),
            DaySection("afternoon", "Afternoon", 12 * 60, null),
            DaySection("evening", "Evening", 18 * 60, 24 * 60),
        )
    }
}

/** How days and weeks are counted (spec/day.md): the hour a day starts (0…12), the week's first day and the time zone. */
data class DaySettings(val dayEndHour: Int = 0, val weekStart: Int = 1, val timeZone: String = "UTC")
