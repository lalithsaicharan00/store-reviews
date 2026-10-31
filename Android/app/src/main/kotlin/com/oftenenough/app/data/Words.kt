package com.oftenenough.app.data

import java.text.DecimalFormat
import java.text.DecimalFormatSymbols
import java.time.Instant
import java.time.LocalDate
import java.time.LocalTime
import java.time.ZoneId
import java.time.format.DateTimeFormatter
import java.util.Locale
import kotlin.math.abs
import kotlin.math.floor

// MOVE TO CORE: the words the app shows (rows, Day details, logs), ported unchanged from the iPhone's HabitCopy.swift and
// Words.swift (Current Work 107). The iPhone's words stay Swift until they move into the shared core
// (Core/spec/README.md); until then this is the one Android copy, checked against the iPhone's own cases in WordsTest.

/** Numbers and times as the app writes them (the iPhone's `Format`). Formatters are made once (S8). */
object Format {
    private val trimmers = HashMap<Int, DecimalFormat>()
    private var trimmerLocale: Locale? = null

    private fun trimmed(v: Double, places: Int): String {
        val locale = Locale.getDefault()
        if (trimmerLocale != locale) { trimmers.clear(); trimmerLocale = locale }
        val f = trimmers.getOrPut(places) {
            DecimalFormat("0." + "#".repeat(places), DecimalFormatSymbols.getInstance(locale)).apply { isGroupingUsed = false }
        }
        return f.format(v)
    }

    /** Whole stays whole ("8"), decimals up to two places ("0.25"), and from 1,000 the k suffix ("1k", "5.2k"). */
    fun amount(v: Double): String {
        if (abs(v) >= 1000) {
            val k = Math.rint(v / 100) / 10
            return trimmed(k, 1) + "k"
        }
        return trimmed(v, 2)
    }

    /** "45 min", "1 h", "1 h 25 min". Never decimals or "k". */
    fun minutes(v: Double): String {
        val total = Math.rint(v).toInt()
        val h = total / 60
        val m = total % 60
        if (h == 0) return "$m min"
        return if (m == 0) "$h h" else "$h h $m min"
    }

    /** A running timer's clock: "0:07", "7:42", "1:07:42". Minutes in, whole seconds out. */
    fun clock(minutes: Double): String {
        val total = maxOf(0, floor(minutes * 60).toInt())
        val h = total / 3600
        val m = total / 60 % 60
        val s = total % 60
        return if (h > 0) "%d:%02d:%02d".format(h, m, s) else "%d:%02d".format(m, s)
    }

    /** "12d 11:23:07" */
    fun elapsed(seconds: Double): String {
        val s = seconds.toLong()
        return "%dd %d:%02d:%02d".format(s / 86400, s % 86400 / 3600, s % 3600 / 60, s % 60)
    }

    fun days(seconds: Double): String {
        val d = (seconds / 86400).toInt()
        return if (d == 1) "1 day" else "$d days"
    }

    /** A quit run's length: "15 d 22 h", "3 h 20 min". */
    fun run(seconds: Double): String {
        val minutes = maxOf(0, (seconds / 60).toInt())
        val d = minutes / 1440
        val h = minutes % 1440 / 60
        val m = minutes % 60
        return if (d > 0) "$d d $h h" else "$h h $m min"
    }
}

/** A habit in words, the way a person says it (the iPhone's `HabitCopy`). */
object HabitCopy {
    val fullDays = listOf("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
    val shortDays = listOf("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
    val monthNames = listOf("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")

    fun ordinal(n: Int): String {
        val suffix = if (n % 100 in 10..20) "th" else when (n % 10) { 1 -> "st"; 2 -> "nd"; 3 -> "rd"; else -> "th" }
        return "$n$suffix"
    }

    fun ordinalWord(n: Int): String = when (n) { 1 -> "first"; 2 -> "second"; 3 -> "third"; 4 -> "fourth"; 5 -> "fifth"; else -> "last" }

    /** "A", "A and B", "A, B and C". */
    fun join(items: List<String>): String = when (items.size) {
        0 -> ""
        1 -> items[0]
        2 -> "${items[0]} and ${items[1]}"
        else -> items.dropLast(1).joinToString(", ") + " and " + items.last()
    }

    fun times(n: Int): String = if (n == 1) "once" else if (n == 2) "twice" else "$n times"

    fun everyN(n: Int, unit: String): String = if (n <= 1) "every $unit" else if (n == 2) "every other $unit" else "every $n ${unit}s"

    fun capitalized(text: String): String = if (text.isEmpty()) text else text.substring(0, 1).uppercase() + text.substring(1)

    /** Chosen days, in the week's order, as unbroken runs; a run through the week's end into its start is one run. */
    fun dayRuns(days: Set<Int>, weekStart: Int): List<List<Int>> {
        val order = (0 until 7).map { (weekStart - 1 + it) % 7 + 1 }
        var runs = mutableListOf<List<Int>>()
        var current = mutableListOf<Int>()
        for (day in order) {
            if (day in days) current.add(day)
            else if (current.isNotEmpty()) { runs.add(current); current = mutableListOf() }
        }
        if (current.isNotEmpty()) runs.add(current)
        if (runs.size > 1 && order[0] in days && order[6] in days) {
            val wrapped = runs.last() + runs[0]
            runs = (listOf(wrapped) + runs.subList(1, runs.size - 1)).toMutableList()
        }
        return runs
    }

    /** "every day", "on weekdays", "on weekends", "every day except Sunday", "every Sunday to Thursday", "every Monday and Wednesday". */
    fun dayText(daysIn: Set<Int>, weekStart: Int, short: Boolean = false): String {
        val names = if (short) shortDays else fullDays
        fun name(d: Int) = names[(d - 1 + 7) % 7]
        val days = daysIn.filter { it in 1..7 }.toSet()
        val count = days.size
        if (count == 0) return "on no days yet"
        if (count == 7) return "every day"
        if (days == setOf(2, 3, 4, 5, 6)) return "on weekdays"
        if (days == setOf(1, 7)) return "on weekends"
        val missing = (1..7).filter { it !in days }.sortedBy { ((it - weekStart) % 7 + 7) % 7 }
        if (count == 6) return "every day except ${name(missing[0])}"
        val runs = dayRuns(days, weekStart)
        if (runs.size == 1 && runs[0].size >= 3) return "every ${name(runs[0].first())} to ${name(runs[0].last())}"
        if (count == 5) return "every day except " + join(missing.map(::name))
        return "every " + join(runs.flatten().map(::name))
    }

    fun weekText(every: Int, days: Set<Int>, weekStart: Int, short: Boolean = false): String {
        val lead = everyN(every, "week")
        val body = dayText(days, weekStart, short)
        if (body == "every day") return "every day, $lead"
        if (body.startsWith("on ")) return "$lead $body"
        if (body.startsWith("every day except")) return "$lead, $body"
        val rest = body.removePrefix("every ")
        return if (" to " in rest) "$lead, $rest" else "$lead on $rest"
    }

    private val oddDates = (1..31 step 2).toSet()
    private val evenDates = (2..30 step 2).toSet()
    private const val MANY_DATES = 6

    fun dateParts(dates: Set<Int>): Pair<List<String>, Boolean> {
        val runs = mutableListOf<List<Int>>()
        var current = mutableListOf<Int>()
        for (d in dates.sorted()) {
            if (current.isNotEmpty() && d == current.last() + 1) current.add(d)
            else { if (current.isNotEmpty()) runs.add(current); current = mutableListOf(d) }
        }
        if (current.isNotEmpty()) runs.add(current)
        val parts = mutableListOf<String>()
        var hasRange = false
        for (run in runs) {
            if (run.size >= 3) { parts.add("${ordinal(run.first())} to ${ordinal(run.last())}"); hasRange = true }
            else parts.addAll(run.map(::ordinal))
        }
        return parts to hasRange
    }

    fun monthTail(phrase: String, every: Int): String = if (every <= 1) "$phrase of every month" else "$phrase, ${everyN(every, "month")}"

    fun monthDates(datesIn: Set<Int>, useLastDay: Boolean = true, every: Int = 1): String {
        val dates = datesIn.filter { it in 1..31 }.toSet()
        val months = everyN(every, "month")
        if (dates.isEmpty()) return "on no dates yet"
        if (dates.size == 31) return if (every <= 1) "every day" else "every day, $months"
        if (dates == oddDates) return if (every <= 1) "on odd dates" else "on odd dates, $months"
        if (dates == evenDates) return if (every <= 1) "on even dates" else "on even dates, $months"
        if (dates == setOf(31) && useLastDay) return monthTail("on the last day", every)
        if (dates.size >= 28) {
            val missing = (1..31).filter { it !in dates }
            val text = "every day except the " + join(missing.map(::ordinal))
            return if (every <= 1) text else "$text, $months"
        }
        val (parts, hasRange) = dateParts(dates)
        if (parts.size > MANY_DATES) return if (every <= 1) "on ${dates.size} dates each month" else "on ${dates.size} dates, $months"
        val listed = if (hasRange) join(parts.map { "the $it" }) else "the " + join(parts)
        return monthTail("on $listed", every)
    }

    fun yearText(month: Int, day: Int, every: Int = 1) = "${everyN(every, "year")} on ${monthNames[(month - 1 + 12) % 12]} $day"

    fun calendarText(rule: CalendarRule, weekStart: Int, short: Boolean = false): String {
        val n = maxOf(1, rule.interval)
        return when (rule.unit) {
            GoalPeriod.DAY -> everyN(n, "day")
            GoalPeriod.WEEK -> if (n == 1) dayText(rule.weekdays, weekStart, short) else weekText(n, rule.weekdays, weekStart, short)
            GoalPeriod.MONTH -> when (rule.pattern) {
                "Last day" -> monthTail("on the last day", n)
                "Weekday" -> {
                    val names = if (short) shortDays else fullDays
                    monthTail("on the ${ordinalWord(rule.ordinal)} ${names[(rule.weekday - 1 + 7) % 7]}", n)
                }
                else -> monthDates(rule.dates, rule.useLastDay, n)
            }
            GoalPeriod.YEAR -> yearText(rule.month, rule.day, n)
        }
    }

    /** How often, alone, for rules that name days; empty for counts over a period. */
    fun rhythm(f: Frequency, weekStart: Int, short: Boolean = false): String = when (f) {
        Frequency.Daily -> "every day"
        is Frequency.Weekdays -> dayText(f.days, weekStart, short)
        is Frequency.EveryNDays -> everyN(f.n, "day")
        is Frequency.EveryNWeeks -> everyN(f.n, "week")
        is Frequency.MonthDates -> monthDates(f.dates)
        is Frequency.Calendar -> calendarText(f.rule, weekStart, short)
        is Frequency.AfterCompletion -> "${f.n} ${if (f.n == 1) f.unit.key else f.unit.plural} after it's done"
        is Frequency.PerWeek, is Frequency.PerMonth, is Frequency.PerYear, is Frequency.Flexible -> ""
    }

    val unchangingUnits = setOf("ml", "l", "oz", "km", "kg", "g", "mg", "kcal", "cal", "mi", "m", "cl", "$", "€", "£", "₹")
    val singularUnits = mapOf("glasses" to "glass", "lbs" to "lb", "push-ups" to "push-up", "pushups" to "pushup",
        "sit-ups" to "sit-up", "pull-ups" to "pull-up", "coffees" to "coffee", "series" to "series", "news" to "news")
    val currencies = setOf("$", "€", "£", "₹")

    /** "1 glass", never "1 glasses"; the unit as it is for any other number. */
    fun unitWord(value: Double, unit: String): String {
        if (value != 1.0 || unit.isEmpty()) return unit
        val low = unit.lowercase()
        if (low in unchangingUnits) return unit
        singularUnits[low]?.let { singular ->
            if (unit == low) return singular
            return if (unit.first().isUpperCase()) capitalized(singular) else unit
        }
        if (listOf("ches", "shes", "sses", "xes").any { low.endsWith(it) }) return unit.dropLast(2)
        if (low.endsWith("ies") && low.length > 4) return unit.dropLast(3) + "y"
        if (low.endsWith("s") && listOf("ss", "us", "is").none { low.endsWith(it) } && low.length > 2) return unit.dropLast(1)
        return unit
    }

    private var numberFormat: DecimalFormat? = null
    private var numberLocale: Locale? = null

    /** The whole number, grouped, as people read it: "10,000", "2.5", "0.25". */
    fun number(value: Double): String {
        val locale = Locale.getDefault()
        val f = numberFormat?.takeIf { numberLocale == locale } ?: DecimalFormat("#,##0.##", DecimalFormatSymbols.getInstance(locale)).also {
            numberFormat = it; numberLocale = locale
        }
        return f.format(value)
    }

    /** "8 glasses", "1 glass", "2,000 ml", "$100", "8" (no unit). */
    fun amount(value: Double, unitIn: String): String {
        val unit = unitIn.trim()
        if (unit in currencies) return unit + number(value)
        return if (unit.isEmpty()) number(value) else "${number(value)} ${unitWord(value, unit)}"
    }

    fun minutes(value: Double): String = Format.minutes(value)

    /** How much, or null for done-or-not: "8 glasses", "30 min". */
    fun howMuch(habit: Habit): String? = when (val k = habit.kind) {
        HabitKind.Duration -> minutes(habit.goal)
        is HabitKind.Amount -> amount(habit.goal, k.unit)
        HabitKind.Check -> habit.checkUnit?.takeIf { it.isNotEmpty() }?.let { amount(habit.goal, it) }
        else -> null
    }

    /** How much and how often, without the name: "2 chapters a week", "twice a day", "at most 3 coffees a day". */
    fun plan(habit: Habit, weekStart: Int, short: Boolean = false): String {
        val f = habit.frequency
        val much = howMuch(habit)
        if (habit.atMost) {
            val per = when (f) { is Frequency.PerWeek -> "a week"; is Frequency.PerMonth -> "a month"; is Frequency.PerYear -> "a year"; else -> "a day" }
            return "at most ${much ?: number(habit.goal)} $per"
        }
        when (f) {
            is Frequency.PerWeek, is Frequency.PerMonth, is Frequency.PerYear -> {
                val n = when (f) { is Frequency.PerWeek -> f.n; is Frequency.PerMonth -> f.n; is Frequency.PerYear -> f.n; else -> 0 }
                return if (much != null) "$much a ${f.periodNoun}" else "${times(n)} a ${f.periodNoun}"
            }
            is Frequency.Flexible -> {
                val per = f.period.noun
                if (f.n == 1) return much?.let { "$it, once a $per" } ?: "once a $per"
                val days = "${f.n} days a $per"
                return much?.let { "$it on $days" } ?: days
            }
            else -> {}
        }
        val base = rhythm(f, weekStart, short)
        if (much != null) return if (f == Frequency.Daily) "$much a day" else "$much $base"
        if (habit.kind == HabitKind.Check && habit.goal > 1) {
            val count = times(habit.goal.toInt())
            return if (f == Frequency.Daily) "$count a day" else "$count a day, $base"
        }
        return base
    }

    fun namesUnit(name: String, unit: String): Boolean {
        val n = name.trim().lowercase()
        return unit.isNotEmpty() && (n == unit.lowercase() || n == unitWord(1.0, unit).lowercase())
    }

    /** The habit said back as one sentence: "Read 2 chapters a week", "Coffee: at most 3 coffees a day". */
    fun sentence(habit: Habit, weekStart: Int): String {
        val text = plan(habit, weekStart)
        val name = habit.name.trim()
        if (name.isEmpty() || namesUnit(name, habit.unit)) return capitalized(text)
        if (habit.atMost) return "$name: $text"
        return "$name $text"
    }
}

/** "3/8 glasses", "12/20 min", "2/3 this week", "1/4 steps", "1/3 times", "0/2 cups max"; while a timer runs, "7:42/20 min". */
fun goalLine(habit: Habit, progress: Double, goal: Double, running: Boolean = false): String {
    val period = when (habit.frequency) { is Frequency.PerWeek -> " this week"; is Frequency.PerMonth -> " this month"; is Frequency.PerYear -> " this year"; else -> "" }
    val max = if (habit.atMost) " max" else ""
    return when (val k = habit.kind) {
        HabitKind.Duration -> {
            // Under an hour the minutes are a number before the goal: "4/10 min" (Figma 1350:2); "2:42/10 min" running.
            // Past an hour, "1 h 40" (Figma's Piano row, "1 h 40/3 h this week").
            val done = if (running) Format.clock(progress) else if (goal < 60 && progress < 60) Format.amount(floor(progress))
                else Format.minutes(floor(progress)).let { if (it.contains(" h ")) it.removeSuffix(" min") else it }
            "$done/${Format.minutes(goal)}$max$period"
        }
        // Money's sign goes before each number; a week's or month's total is its numbers only, as Day details' card
        // ("160/300 this week", "$250/$500": Figma's Push-ups and Savings rows, 915:107493).
        is HabitKind.Amount -> if (k.unit in HabitCopy.currencies) "${k.unit}${Format.amount(progress)}/${k.unit}${Format.amount(goal)}$max" + (if (period.isEmpty() || habit.atMost) period else "")
            else "${Format.amount(progress)}/${Format.amount(goal)}${if (k.unit.isEmpty() || (period.isNotEmpty() && !habit.atMost)) "" else " " + k.unit}$max$period"
        HabitKind.Checklist -> "${Format.amount(progress)}/${Format.amount(goal)} steps$period"
        HabitKind.Check -> if (habit.checkUnit != null) "${Format.amount(progress)}/${Format.amount(goal)} ${habit.checkUnit}$period"
            else "${Format.amount(progress)}/${Format.amount(goal)}${if (habit.frequency.isDayBased) " times" else ""}$max$period"
        HabitKind.Quit, HabitKind.Task -> "${Format.amount(progress)}/${Format.amount(goal)}$max$period"
    }
}

/** The words for days and clock times. */
object DayWords {
    private val shortDate = DateTimeFormatter.ofPattern("EEE, d MMM", Locale.ENGLISH)
    private val dayMonth = DateTimeFormatter.ofPattern("d MMM", Locale.ENGLISH)
    private val barDate = DateTimeFormatter.ofPattern("EEE d MMM", Locale.ENGLISH)
    private val longDate = DateTimeFormatter.ofPattern("d MMM yyyy", Locale.ENGLISH)
    private var clockFormat: DateTimeFormatter? = null
    var is24Hour: Boolean = false
        set(value) { field = value; clockFormat = null }

    fun date(day: Int): LocalDate = LocalDate.ofEpochDay(day.toLong())

    /** "Today", "Yesterday", or "Mon, 29 Sep". */
    fun day(day: Int, today: Int): String = relative(day, today) ?: short(day)

    fun relative(day: Int, today: Int): String? = when (day) { today -> "Today"; today - 1 -> "Yesterday"; else -> null }

    fun short(day: Int): String = date(day).format(shortDate)
    fun dayMonth(day: Int): String = date(day).format(dayMonth)
    /** The day bar's day, without the comma: "Tue 13 Oct" (Figma's Today, flow 32). */
    fun bar(day: Int): String = date(day).format(barDate)
    fun long(day: Int): String = date(day).format(longDate)

    /** "Paused until 13 Oct" (the day it's back, as the snackbar says it), or "Paused" until resumed: short for a row (the user, 31 Oct 2026). */
    fun paused(p: HabitPause): String = p.through?.let { "Paused until " + dayMonth(it + 1) } ?: "Paused"

    private fun clockFormatter(): DateTimeFormatter = clockFormat ?: (if (is24Hour) DateTimeFormatter.ofPattern("HH:mm")
        else DateTimeFormatter.ofPattern("h:mm a", Locale.ENGLISH)).also { clockFormat = it }

    /** "9:40 PM" (or "21:40" with the phone's 24-hour time), in [zone]. */
    fun clock(ms: Long, zone: ZoneId = ZoneId.systemDefault()): String = Instant.ofEpochMilli(ms).atZone(zone).toLocalTime().format(clockFormatter())

    /** A minute of the day: "7:00 AM". */
    fun clockMinute(minute: Int): String = LocalTime.of((minute / 60) % 24, minute % 60).format(clockFormatter())

    /** "6 AM", "12 PM", "6:30 PM": a time of day's start, short (or "06:00"). */
    fun hourShort(minute: Int): String {
        if (is24Hour) return clockMinute(minute)
        val h = (minute / 60) % 24
        val m = minute % 60
        val hour12 = if (h % 12 == 0) 12 else h % 12
        val suffix = if (h < 12) "AM" else "PM"
        return if (m == 0) "$hour12 $suffix" else "$hour12:%02d $suffix".format(m)
    }
}

/** A task's line always says it's a task, then its time, or where it came from if it moved forward. */
fun taskLine(habit: Habit, shownOn: Int, weekStart: Int = 1): String {
    val parts = mutableListOf("Task")
    habit.dueDay?.let { if (it < shownOn) parts.add("From " + DayWords.short(it)) }
    habit.dueMinute?.let { parts.add(DayWords.clockMinute(it)) }
    // Nothing else to say: how often it comes ("Task · Once", "Task · Every month"; Figma 1350:2, as the widgets say).
    if (parts.size == 1) parts.add(if (habit.dueDay != null) "Once" else HabitCopy.capitalized(HabitCopy.rhythm(habit.frequency, weekStart)))
    return parts.joinToString(" · ")
}
