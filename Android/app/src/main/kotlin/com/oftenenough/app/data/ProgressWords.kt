package com.oftenenough.app.data

import java.util.Locale

// MOVE TO CORE: Progress's own words and numbers for Week, Month and Year, ported unchanged from the iPhone's
// iOS/Habits/Model/HabitStore+WeekCards.swift (weekColumns, yearLayout, yearCaption, weekGoalText, quitGoalText,
// weekValue, compactNumber, compactMinutes, weekSpoken) and HabitStore+Progress.swift (progressSnapshot's Week, Month
// and Year cards, earliestProgressDay, DayMark.words). Each card's headline, detail and squares come from the same
// engine as the habit page's cards (`periodCard` and `quitPeriodCard` in HabitPageWords.kt), as on the iPhone, where
// both read `weekCard`. Checked in ProgressWordsTest.
//
// Everything here is worked out once per period and data version and kept (ProgressSnapshot), never while drawing
// (Rulebook S5, S8). Rules are reached only through RulesGateway.

/** "Week", "Month", "Year". */
val ProgressRange.title: String get() = noun.replaceFirstChar { it.uppercaseChar() }

/** One column of the week: the day and its names, made once per snapshot (not per card or per cell). */
data class WeekColumn(val day: Int, val short: String, val letter: String, val spoken: String, val isToday: Boolean)

/** "Jan" over the first column that is wholly in January. */
data class YearMonthLabel(val column: Int, val name: String)

/** How a year sits in its heat map: weeks left to right in columns, weekdays top to bottom in the person's order. */
data class YearLayout(
    /** Empty places before the first day, in the first column. */
    val lead: Int,
    /** The weekday letters down the side, in the person's order: "S M T W T F S". */
    val letters: List<String>,
    /** Days drawn, from the first: through today in the current year, every day in a past one. */
    val shown: Int,
    /** Today's row, for its weekday letter; null in another year. */
    val todayRow: Int?,
    val months: List<YearMonthLabel>,
) {
    val columns: Int get() = (lead + shown + 6) / 7
}

/** One habit's card on Progress. */
data class ProgressWeekCard(
    val habit: Habit,
    /** The goal in words, under the name: "8 glasses a day", "3 times a week", "Quit · since Wed, 2 Sep". */
    val goal: String,
    /** The period on the goal's own clock: "Reached on 4 of 5 days so far", "1 of 3 this week". */
    val headline: String,
    /** One different fact, or null when it would only repeat the headline or the squares. */
    val detail: String?,
    val days: List<WeekCardDay>,
    /** TalkBack: the whole card is one element. */
    val accessibility: String,
    /** Quit: the run going on now (epoch ms), shown live in place of the headline; null while paused or in a past period. */
    val runStart: Long? = null,
    val isQuit: Boolean = false,
) {
    /** The squares, made once with the card (never while drawing). */
    val heat: List<HeatCell> = days.map { it.heat }
}

/** Everything Progress shows for one range and period, worked out once per change. */
class ProgressSnapshot(
    val range: ProgressRange,
    val first: Int,
    val last: Int,
    val today: Int,
    /** "11–17 Oct", "October", "2026". */
    val title: String,
    /** "This week", "Last month"; null for older periods (the dates say it). */
    val caption: String?,
    val cards: List<ProgressWeekCard>,
    val archivedCards: List<ProgressWeekCard>,
    /** Week and Month: the period's columns. */
    val columns: List<WeekColumn>,
    /** Month: the empty places before the 1st. */
    val monthLead: Int,
    /** The weekday letters in the person's week order. */
    val letters: List<String>,
    /** Year: the heat map's layout, shared by every card. */
    val year: YearLayout?,
    val canGoBack: Boolean,
    val canGoForward: Boolean,
    /** Any habit Progress can show (tasks never are). */
    val hasHabits: Boolean,
    /** The group chosen; null is All (a deleted group is All). */
    val group: HabitGroup?,
) {
    val isRunning: Boolean get() = today in first..last
}

/** Progress's words and day arithmetic that need no store (the iPhone's, unchanged). */
object ProgressWords {
    /** "This year", "Last year", or null for older years. */
    fun yearCaption(first: Int, last: Int, today: Int): String? = when {
        today in first..last -> "This year"
        pageYear(first) == pageYear(today) - 1 -> "Last year"
        else -> null
    }

    /** The period's columns, in order: "Sun", "S", "Sunday 11 October". */
    fun weekColumns(first: Int, last: Int, today: Int): List<WeekColumn> = (first..last).map { day ->
        val w = pageWeekday(day) - 1
        val spoken = "${HabitCopy.fullDays[w]} ${pageDayOfMonth(day)} ${HabitCopy.monthNames[pageMonth(day) - 1]}"
        WeekColumn(day, HabitCopy.shortDays[w], HabitCopy.shortDays[w].substring(0, 1), spoken, day == today)
    }

    /** The year's heat map layout, worked out once per snapshot from day numbers only. */
    fun yearLayout(first: Int, last: Int, today: Int, weekStart: Int): YearLayout {
        val lead = pageMonthLead(first, weekStart)
        val running = today in first..last
        val shown = if (running) today - first + 1 else if (today < first) 0 else last - first + 1
        val columns = (lead + shown + 6) / 7
        val year = pageYear(first)
        val months = ArrayList<YearMonthLabel>()
        for (month in 1..12) {
            val index = pageDay(year, month, 1) - first
            if (index < 0 || index >= shown) continue
            val place = lead + index
            // As GitHub: over the first week wholly in the month; the month just begun, over the week that holds its 1st.
            var column = if (place % 7 == 0) place / 7 else place / 7 + 1
            if (column >= columns) column = place / 7
            val previous = months.lastOrNull()
            if (previous != null && column - previous.column < 2) continue
            months.add(YearMonthLabel(column, pageMonthShort(month)))
        }
        return YearLayout(lead, pageWeekdayLetters(weekStart), shown, if (running) (lead + shown - 1) % 7 else null, months)
    }

    /** "8", "2.5", "9.1k", "10k", "123k", "1.2M": short enough for a seventh of the card. */
    fun compactNumber(value: Double): String {
        fun trimmed(v: Double): String {
            val r = Math.round(v * 10) / 10.0
            return if (r == Math.rint(r)) r.toLong().toString() else String.format(Locale.US, "%.1f", r)
        }
        return when {
            value < 1000 -> trimmed(value)
            value < 100_000 -> trimmed(value / 1000) + "k"
            value < 1_000_000 -> Math.round(value / 1000).toString() + "k"
            else -> trimmed(value / 1_000_000) + "M"
        }
    }

    /** "25m", "2h", "1h30". */
    fun compactMinutes(value: Double): String {
        val total = Math.round(value).toInt()
        if (total < 60) return "${total}m"
        val h = total / 60
        val m = total % 60
        return if (m == 0) "${h}h" else "${h}h${if (m < 10) "0" else ""}$m"
    }

    /** The mark's name, as TalkBack says it; a limit's marks say what they mean for a limit. */
    fun markWords(mark: DayMark, atMost: Boolean = false): String = when (mark) {
        DayMark.DONE -> if (atMost) "Within the limit" else "Done"
        DayMark.SOME -> if (atMost) "Logged" else "Partial"
        DayMark.MISSED -> if (atMost) "Over the limit" else "Not done"
        DayMark.OPEN -> "Today, still open"
        DayMark.SKIPPED -> "Skipped"
        DayMark.PAUSED -> "Paused"
        DayMark.NOT_ITS_DAY -> "Not scheduled"
        DayMark.UPCOMING -> "Coming up"
        DayMark.BEFORE -> "Before it started"
    }

    /**
     * A card read as one element: "Read. Reached on 1 of 1 day so far. 32 min this week. Sunday done, 32m, …". Week cards
     * name each day ([values]: the day's own number, the same length as [days], or empty); Month and Year cards say their
     * numbers only, since thirty-one days read aloud is noise (pass no days).
     */
    fun spoken(name: String, headline: String, detail: String?, days: List<WeekCardDay>, values: List<String>, atMost: Boolean): String {
        var text = "$name. $headline."
        if (detail != null) text += " $detail."
        val parts = ArrayList<String>()
        days.forEachIndexed { i, d ->
            if (d.mark == DayMark.BEFORE) return@forEachIndexed
            var words = HabitCopy.fullDays[pageWeekday(d.day) - 1] + " " + (if (d.extra) "extra, " else "") +
                (if (d.slip) "slip" else markWords(d.mark, atMost).lowercase(Locale.US))
            val value = values.getOrElse(i) { "" }
            if (value.isNotEmpty()) words += ", $value"
            parts.add(words)
        }
        return if (parts.isEmpty()) text else text + " " + parts.joinToString(", ") + "."
    }

    /** The number for a day: counted habits only, and only when something was logged. */
    fun weekValue(amount: Double, rule: Habit, dayGoal: Double, mark: DayMark): String {
        if (amount <= 0) return ""
        return when (rule.kind) {
            HabitKind.Duration -> compactMinutes(amount)
            HabitKind.Checklist -> if (mark == DayMark.SOME) "${amount.toInt()}/${dayGoal.toInt()}" else ""
            // A plain tick says nothing a mark doesn't; several in a day say how many.
            HabitKind.Check -> if (dayGoal > 1 || amount > 1) compactNumber(amount) else ""
            else -> compactNumber(amount)
        }
    }
}

// ---------------------------------------------------------------------- The store's part

/** The first day any habit Progress shows counts from: ‹ stops at the period holding it. */
fun HabitStore.earliestProgressDay(): Int? = habits.filter { it.kind != HabitKind.Task }.minOfOrNull { rules.startDay(it) }

/** The goal in words under a card's name: "8,000 steps a day", "3 times a week", "4 steps a day". */
fun HabitStore.weekGoalText(habit: Habit): String {
    if (habit.kind == HabitKind.Checklist) {
        val n = habit.steps.size
        val steps = if (n == 1) "1 step" else "$n steps"
        if (habit.frequency == Frequency.Daily) return "$steps a day"
        val rhythm = HabitCopy.rhythm(habit.frequency, weekStart, short = true)
        return if (rhythm.isEmpty()) steps else "$steps, $rhythm"
    }
    return HabitCopy.capitalized(HabitCopy.plan(habit, weekStart, short = true))
}

/**
 * Everything Progress shows for [range] around [anchor]: a card per habit in the person's order, then quit habits, and
 * archived habits apart; tasks never. [groupId] chooses one group's habits ("" or an unknown group is All). Reads only.
 */
fun HabitStore.progressSnapshot(range: ProgressRange, anchor: Int, today: Int, groupId: String?): ProgressSnapshot {
    val span = rules.period(range.kind, anchor)
    val first = span.first
    val last = span.last
    val group = groupId?.takeIf { it.isNotEmpty() }?.let { id -> groups.firstOrNull { it.id == id } }
    fun inGroup(h: Habit) = group == null || h.id in group.habits
    val cards = ArrayList<ProgressWeekCard>()
    val archived = ArrayList<ProgressWeekCard>()
    for (habit in habits) {
        if (habit.kind == HabitKind.Task || habit.kind == HabitKind.Quit || !inGroup(habit)) continue
        val card = progressCard(habit, span, range, today) ?: continue
        if (habit.archived) archived.add(card) else cards.add(card)
    }
    val now = clock()
    for (habit in habits) {
        if (habit.kind != HabitKind.Quit || habit.archived || !inGroup(habit)) continue
        if (rules.quitStartDay(habit) > minOf(last, today)) continue
        cards.add(progressQuitCard(habit, span, range, today, now))
    }
    val earliest = earliestProgressDay()
    return ProgressSnapshot(
        range = range, first = first, last = last, today = today,
        title = when (range) {
            ProgressRange.WEEK -> pageWeekTitle(first, last, today)
            ProgressRange.MONTH -> pageMonthTitle(first, today)
            ProgressRange.YEAR -> pageYear(first).toString()
        },
        caption = when (range) {
            ProgressRange.WEEK -> pageWeekCaption(span, today)
            ProgressRange.MONTH -> pageMonthCaption(span, today)
            ProgressRange.YEAR -> ProgressWords.yearCaption(first, last, today)
        },
        cards = cards, archivedCards = archived,
        // The year draws from day numbers; 365 named columns would be made for nothing.
        columns = if (range == ProgressRange.YEAR) emptyList() else ProgressWords.weekColumns(first, last, today),
        monthLead = if (range == ProgressRange.MONTH) pageMonthLead(first, weekStart) else 0,
        letters = pageWeekdayLetters(weekStart),
        year = if (range == ProgressRange.YEAR) ProgressWords.yearLayout(first, last, today, weekStart) else null,
        canGoBack = earliest != null && earliest < first,
        canGoForward = last < today,
        hasHabits = habits.any { it.kind != HabitKind.Task },
        group = group,
    )
}

/** One habit's card, or null when the period has nothing to say about it (the habit page's `periodCard`). */
private fun HabitStore.progressCard(habit: Habit, span: IntRange, range: ProgressRange, today: Int): ProgressWeekCard? {
    val card = periodCard(habit, span, range, today) ?: return null
    val start = rules.startDay(habit)
    // Not begun yet: its own goal and "Starts Mon, 19 Oct".
    if (start > today) {
        return ProgressWeekCard(habit, weekGoalText(habit), card.headline, card.detail, card.days, habit.name + ". " + card.headline + ".")
    }
    val rule = rule(habit, maxOf(minOf(span.last, today), start))
    val week = range == ProgressRange.WEEK
    val values = if (!week) emptyList() else card.days.map { d ->
        if (d.day < start || d.day > today) "" else {
            val dayRule = rule(habit, d.day)
            ProgressWords.weekValue(rules.dayProgress(habit, d.day), dayRule, pageDayGoal(dayRule), d.mark)
        }
    }
    val spoken = ProgressWords.spoken(habit.name, card.headline, card.detail, if (week) card.days else emptyList(), values, rule.atMost)
    return ProgressWeekCard(habit, weekGoalText(rule), card.headline, card.detail, card.days, spoken)
}

/** A quit habit's card: the run going on now, and the period's slips (the habit page's `quitPeriodCard`). */
private fun HabitStore.progressQuitCard(habit: Habit, span: IntRange, range: ProgressRange, today: Int, now: Long): ProgressWeekCard {
    val card = quitPeriodCard(habit, span, range, today, now)
    val running = today in span
    val runStart = if (running && !isPaused(habit, today)) {
        rules.quitHistory(habit, now).lastOrNull()?.takeIf { it.ending == QuitRun.Ending.ONGOING }?.start
    } else null
    val week = range == ProgressRange.WEEK
    val values = if (!week) emptyList() else {
        val perDay = HashMap<Int, Int>()
        for (slip in rules.slips(habit, now)) {
            val day = rules.today(slip)
            if (day in span) perDay[day] = (perDay[day] ?: 0) + 1
        }
        card.days.map { d -> (perDay[d.day] ?: 0).let { n -> if (n > 1) "$n×" else "" } }
    }
    val goal = "Quit · since " + DayWords.short(rules.quitStartDay(habit))
    val spoken = ProgressWords.spoken(habit.name, card.headline, card.detail, if (week) card.days else emptyList(), values, false)
    return ProgressWeekCard(habit, goal, card.headline, card.detail, card.days, spoken, runStart = runStart, isQuit = true)
}
