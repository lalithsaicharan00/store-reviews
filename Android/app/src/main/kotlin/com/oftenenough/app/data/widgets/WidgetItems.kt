package com.oftenenough.app.data.widgets

import com.oftenenough.app.data.DayMark
import com.oftenenough.app.data.DaySection
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Format
import com.oftenenough.app.data.GoalPeriod
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitCopy
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.Outcome
import com.oftenenough.app.data.PeriodKind
import com.oftenenough.app.data.QuitRun
import com.oftenenough.app.data.newId
import kotlin.math.floor

// MOVE TO CORE: the widgets' cards, ported from the iPhone's HabitStore+Widgets.swift. Every number, word and order comes
// from the store's own functions, the ones Today and Progress use (U26). LOCKED (widget taps): the "after" cards, a ✓
// flipped and a + five taps ahead (W3): the widget draws the app's own next state, never its own.

object WidgetItems {
    /** How many quick + taps in a row a widget shows at once before it redraws with the saved numbers (W3). */
    const val TAPS_AHEAD = 5
    const val QUITTING = DaySection.QUITTING

    /** One tap's effect, for the card as it will be after it: a + adds [add]; a ✓ flips the day's tick. */
    data class Adjust(val add: Double, val flip: Boolean)

    fun cardName(store: HabitStore, card: String) = if (card == QUITTING) "Quit or Cut Down" else store.section(card).name

    /**
     * The whole snapshot: seven tracked days from today. With [hold], today's lists keep [previous]'s order until then
     * (a run of widget taps moves nothing, U4); afterwards done rows sink (U13).
     */
    fun snapshot(store: HabitStore, now: Long, sinkDone: Boolean, timerOpensScreen: Boolean, previous: WidgetSnapshot? = null, hold: Long? = null): WidgetSnapshot {
        val rules = store.rules
        val first = rules.today(now)
        val active = store.habits.filter { !it.archived }
        val perHabit = active.associate { it.id to items(store, it, first, now) }
        val cards = store.todayCards()
        val frames = (0 until 7).map { offset ->
            val day = first + offset
            val bounds = rules.dayBounds(day)
            val items = active.mapNotNull { perHabit[it.id]?.get(offset) }
            WidgetFrame(day, bounds.first, bounds.last + 1, items, lists(items, cards, sinkDone))
        }.toMutableList()
        if (hold != null && hold > now && previous != null) {
            previous.frames.firstOrNull { it.day == frames[0].day }?.let { shown ->
                val stillHolding = shown.settle?.let { now < it } ?: false
                val onScreen = (if (stillHolding) shown.held else null) ?: shown.lists
                val held = frames[0].lists.mapValues { (key, settled) ->
                    val members = settled.toSet()
                    val kept = (onScreen[key] ?: emptyList()).filter { it in members }
                    val keptSet = kept.toSet()
                    kept + settled.filter { it !in keptSet }
                }
                frames[0] = frames[0].copy(held = held, settle = hold)
            }
        }
        val weekSpan = rules.period(PeriodKind.WEEK, first)
        val weekdays = weekSpan.map { HabitCopy.shortDays[java.time.LocalDate.ofEpochDay(it.toLong()).dayOfWeek.value % 7] }
        return WidgetSnapshot(
            generated = now, timeZone = java.util.TimeZone.getDefault().id, plus = store.isPlus,
            sections = cards.map { WidgetSection(it, cardName(store, it)) },
            taskSections = cards.filter { it != QUITTING }.map { WidgetSection(it, cardName(store, it)) },
            choices = active.filter { it.kind != HabitKind.Task }.map { WidgetChoice(it.id, it.name, it.symbol) },
            weekdays = weekdays, timerOpensScreen = timerOpensScreen, frames = frames,
        )
    }

    /** Each list in Today's order: the cards as arranged, and in each card the person's order, done ones last when they sink. */
    fun lists(items: List<WidgetItem>, cards: List<String>, sinkDone: Boolean): Map<String, List<String>> {
        val lists = LinkedHashMap<String, List<String>>()
        val habitsToday = ArrayList<String>(); val tasksToday = ArrayList<String>()
        val seenHabits = HashSet<String>(); val seenTasks = HashSet<String>()
        for (card in cards) {
            val members = items.filter { card in it.cards }
            val ordered = if (sinkDone) members.filter { !it.sinks } + members.filter { it.sinks } else members
            val habits = ordered.filter { !it.isTask }.map { it.id }
            val tasks = ordered.filter { it.isTask }.map { it.id }
            lists["habits:$card"] = habits
            if (card != QUITTING) lists["tasks:$card"] = tasks
            for (id in habits) if (seenHabits.add(id)) habitsToday += id
            for (id in tasks) if (seenTasks.add(id)) tasksToday += id
        }
        lists["habits"] = habitsToday
        lists["tasks"] = tasksToday
        return lists
    }

    /** One habit's seven days, today's ✓ or + with its "after" cards. */
    fun items(store: HabitStore, habit: Habit, first: Int, now: Long): List<WidgetItem> = (0 until 7).map { offset ->
        val day = first + offset
        val moment = maxOf(now, store.rules.dayBounds(day).first)
        val card = item(store, habit, day, moment, offset == 0)
        if (offset == 0 && card.state == null && (card.action == WidgetAction.CHECK || card.action == WidgetAction.ADD)) {
            if (card.action == WidgetAction.CHECK) {
                card.copy(after = listOf(item(store, habit, day, moment, true, Adjust(0.0, true), card.week).copy(token = card.token)))
            } else {
                val step = if (card.type == "amount") (habit.quickIncrement ?: 0.0) else 1.0
                var next: WidgetItem? = null
                for (taps in TAPS_AHEAD downTo 1) {
                    next = item(store, habit, day, moment, true, Adjust(step * taps, false), card.week)
                        .copy(token = card.token, after = next?.let { listOf(it) })
                }
                card.copy(after = next?.let { listOf(it) })
            }
        } else card
    }

    private fun slots(store: HabitStore, habit: Habit) = store.rules.placements(habit).mapNotNull { it.slot }

    /** Today's "done" for one row: skipped, or done for the day (all its parts, for a habit ticked per part). */
    fun rowDone(store: HabitStore, habit: Habit, day: Int): Boolean {
        if (store.isSkipped(habit, day)) return true
        val slots = slots(store, habit)
        if (slots.isNotEmpty()) return slots.all { store.isSlotDone(habit, it, day) }
        return store.rules.isSatisfied(habit, day)
    }

    /** One habit or task on one day, as every widget shows it. */
    fun item(store: HabitStore, habit: Habit, day: Int, now: Long, isToday: Boolean, adjust: Adjust? = null, week: List<Int>? = null): WidgetItem {
        val rules = store.rules
        val rule = store.rule(habit, day)
        val paused = store.isPaused(habit, day)
        val skipped = store.isSkipped(habit, day)
        val started = rules.startDay(habit) <= day
        val ended = habit.endsOn?.let { day > it } ?: false
        val quit = habit.kind == HabitKind.Quit
        val due = if (quit) started && !paused && !ended else rules.isDue(habit, day, now, countingSkips = false)
        val w = Builder(habit.id, habit.name, habit.symbol, habit.color.key, type(rule), habit.kind == HabitKind.Task, rule.atMost && habit.kind != HabitKind.Task)
        if (due && !paused) {
            w.cards = if (habit.isQuitOrLimit) listOf(QUITTING) else rules.placements(habit).map { it.section }.distinct()
        }
        when {
            paused -> {
                w.state = "paused"
                val through = store.pause(habit, day)?.through
                w.value = "Paused"; w.line = "Paused"; w.big = "Paused"
                w.caption = through?.let { "Back on " + DayWords.short(it + 1) } ?: "Paused"
            }
            skipped && !quit -> {
                w.state = "skipped"
                w.value = if (isToday) "Skipped today" else "Skipped"; w.line = w.value; w.big = "Skipped"; w.caption = w.value
                w.sinks = true
            }
            !due -> {
                w.state = "notPlanned"
                val dueDay = habit.dueDay
                w.value = if (habit.kind == HabitKind.Task && dueDay != null && dueDay > day) "Planned for " + DayWords.short(dueDay) else "Not planned today"
                w.line = w.value; w.big = "Not planned"
                // A set schedule says its days ("Mon, Wed and Fri") so a habit missing today isn't a surprise.
                w.caption = if (habit.kind != HabitKind.Task) HabitCopy.capitalized(HabitCopy.rhythm(habit.frequency, store.weekStart, short = true)) else "Not planned"
            }
        }
        when {
            quit -> fillQuit(store, w, habit, day, now, due && !paused)
            habit.kind == HabitKind.Task -> fillTask(store, w, habit, day, adjust)
            else -> fillHabit(store, w, habit, rule, day, now, due && !paused && !skipped, adjust)
        }
        if (w.state != null) {
            w.action = WidgetAction.OPEN; w.route = "item/${habit.id}"; w.actionText = null; w.done = false
        }
        if (w.cards.isNotEmpty() && !skipped) {
            when (rules.outcome(habit, day, day).kind) {
                Outcome.Kind.DONE -> { w.counts = true; w.countsDone = true }
                Outcome.Kind.PART, Outcome.Kind.NOT_DONE, Outcome.Kind.OPEN -> w.counts = true
                Outcome.Kind.NEUTRAL -> {}
            }
            if (adjust != null && w.counts) {
                w.countsDone = w.done || (!rule.frequency.isDayBased && !rule.atMost && (w.todayAmount ?: 0.0) > 0)
            }
        }
        if (w.cards.isNotEmpty()) {
            val carried = habit.kind == HabitKind.Task && habit.dueDay?.let { it < day } == true
            w.place = if (w.cards[0] == QUITTING || carried) "" else cardName(store, w.cards[0])
            w.todayLine = listOf(w.place, w.line).filter { it.isNotEmpty() }.joinToString(" · ")
        }
        val span = rules.period(PeriodKind.WEEK, day)
        if (week != null && adjust != null) {
            val index = day - span.first
            w.weekToday = index
            w.week = week.toMutableList().also { list -> w.todayLevel?.let { if (index in list.indices) list[index] = it } }
        } else if (habit.kind != HabitKind.Task) {
            w.week = span.map { cell(store, habit, it, day) }
            w.weekToday = day - span.first
        }
        return w.build()
    }

    /** A day's square, as Progress's Week shows it. */
    fun cell(store: HabitStore, habit: Habit, d: Int, today: Int): Int {
        val rules = store.rules
        return when (rules.dayMark(habit, d, today)) {
            DayMark.BEFORE -> WidgetCell.BLANK
            DayMark.UPCOMING -> WidgetCell.UPCOMING
            DayMark.NOT_ITS_DAY -> WidgetCell.NOT_SCHEDULED
            DayMark.SKIPPED -> WidgetCell.SKIPPED
            DayMark.PAUSED -> WidgetCell.PAUSED
            DayMark.MISSED -> 0
            DayMark.DONE, DayMark.SOME, DayMark.OPEN -> level(store, habit, d)
        }
    }

    private fun level(store: HabitStore, habit: Habit, d: Int): Int {
        val rules = store.rules
        val rule = store.rule(habit, d)
        if (rule.atMost) return if (rules.dayProgress(habit, d) > 0) 4 else 0
        val amount = rules.dayProgress(habit, d)
        val dayGoal = rules.dayGoal(rule)
        val complete = rules.isComplete(habit, d)
        return if (complete) (if (amount > dayGoal && dayGoal > 0 && rule.frequency.isDayBased) 5 else 4)
        else if (amount <= 0) 0
        else if (dayGoal > 0 && rule.frequency.isDayBased) (if (amount / dayGoal <= 1.0 / 3) 1 else if (amount / dayGoal <= 2.0 / 3) 2 else 3)
        else 4
    }

    fun type(rule: Habit) = when (rule.kind) {
        HabitKind.Check -> "check"; is HabitKind.Amount -> "amount"; HabitKind.Duration -> "duration"
        HabitKind.Checklist -> "checklist"; HabitKind.Quit -> "quit"; HabitKind.Task -> "task"
    }

    // ------------------------------------------------------------------ Words and numbers

    private fun fillTask(store: HabitStore, w: Builder, habit: Habit, day: Int, adjust: Adjust?) {
        val doneNow = store.rules.isDone(habit, day)
        val done = if (adjust?.flip == true) !doneNow else doneNow
        if (w.state != null) return
        val parts = ArrayList<String>()
        habit.dueDay?.let { if (it < day) parts += "From " + DayWords.short(it) }
        habit.dueMinute?.let { parts += DayWords.clockMinute(it) }
        w.line = parts.joinToString(" · ")
        w.value = if (done) "Done" else "For today"
        w.big = if (done) "Done" else "Not yet"
        w.action = WidgetAction.CHECK
        w.done = done; w.sinks = done
        w.fraction = if (done) 1.0 else null
        w.cardFraction = if (done) 1.0 else 0.0
    }

    private fun fillQuit(store: HabitStore, w: Builder, habit: Habit, day: Int, now: Long, planned: Boolean) {
        val rules = store.rules
        val history = rules.quitHistory(habit, now)
        val current = if (planned) history.lastOrNull()?.takeIf { it.ending == QuitRun.Ending.ONGOING }?.start else null
        val earlier = history.filter { it.ending != QuitRun.Ending.ONGOING }.maxOfOrNull { it.seconds(now) }
        w.quitStart = current
        // The best run counts the one going on, as Today's row does (U26: a widget never disagrees with Today).
        val ongoing = history.lastOrNull()?.takeIf { it.ending == QuitRun.Ending.ONGOING }?.seconds(now)
        w.quitBest = listOfNotNull(earlier, ongoing).maxOrNull()?.takeIf { it > 0 }
        w.quitBestText = w.quitBest?.let { "Best " + runText(it) }
        if (current != null) {
            val sameDay = rules.today(current) == rules.today(now)
            w.since = "Since " + if (sameDay) DayWords.clock(current) else DayWords.dayMonth(rules.calendarDayOf(current))
            val nextPause = (store.pauses[habit.id] ?: emptyList()).filter { it.from > day }.minOfOrNull { rules.dayBounds(it.from).first }
            val ending = habit.endsOn?.let { rules.dayBounds(it).last + 1 }
            w.quitUntil = listOfNotNull(nextPause, ending).minOrNull()
        }
        if (w.state == null) {
            w.line = w.since ?: ""; w.value = w.since ?: ""; w.caption = w.quitBestText ?: w.since
        }
        // Record a slip opens straight on its screen; a slip is never logged from a widget tap.
        w.action = WidgetAction.OPEN
        w.route = "slip/${habit.id}"
    }

    private fun fillHabit(store: HabitStore, w: Builder, habit: Habit, rule: Habit, day: Int, now: Long, planned: Boolean, adjust: Adjust?) {
        val rules = store.rules
        var progress = rules.progress(habit, day, now)
        val goal = rules.goal(rule)
        val period = if (!rule.frequency.isDayBased) rules.periodKind(rule) else GoalPeriod.DAY
        val running = store.timers.containsKey(habit.id) && day == rules.today(now)
        val dayGoal = rules.dayGoal(rule)
        var todayAmount = rules.dayProgress(habit, day, now)
        var complete = rules.isComplete(habit, day)
        var tickedOverride: Boolean? = null
        if (adjust != null) {
            if (adjust.flip) {
                val ticked = !store.isTicked(habit, day)
                tickedOverride = ticked
                val delta = if (ticked) 1.0 else -minOf(1.0, todayAmount)
                progress += delta; todayAmount += delta
                complete = ticked
            } else {
                progress += adjust.add; todayAmount += adjust.add
                complete = !rule.atMost && progress >= goal
            }
        }
        w.todayAmount = todayAmount
        if (!rule.atMost) {
            w.todayLevel = if (complete) (if (todayAmount > dayGoal && dayGoal > 0 && rule.frequency.isDayBased) 5 else 4)
            else if (todayAmount <= 0) 0
            else if (dayGoal > 0 && rule.frequency.isDayBased) (if (todayAmount / dayGoal <= 1.0 / 3) 1 else if (todayAmount / dayGoal <= 2.0 / 3) 2 else 3)
            else 4
        }
        val slotted = slots(store, habit).isNotEmpty()
        val n = store.streak(habit, day)
        w.streak = if (n > 0) rule.frequency.streakUnit.short(n) else null
        val periodFraction = if (goal > 0) maxOf(0.0, progress / goal) else 0.0
        w.cardFraction = periodFraction
        w.fraction = when {
            rule.atMost -> { w.limitFill = true; periodFraction }
            period == GoalPeriod.DAY -> if (dayGoal > 0) maxOf(0.0, todayAmount / dayGoal) else 0.0
            else -> periodFraction // A week or month goal fills toward its period, as Today's row does (U25).
        }
        w.done = !rule.atMost && complete
        w.sinks = if (adjust != null) w.done else !rule.atMost && rowDone(store, habit, day)
        if (w.state != null) { w.fraction = null; w.cardFraction = null; return }

        val periodWord = when (period) { GoalPeriod.WEEK -> "a week"; GoalPeriod.MONTH -> "a month"; GoalPeriod.YEAR -> "a year"; else -> "" }
        val thisPeriod = when (period) { GoalPeriod.WEEK -> " this week"; GoalPeriod.MONTH -> " this month"; GoalPeriod.YEAR -> " this year"; else -> "" }
        when (val k = rule.kind) {
            HabitKind.Check -> {
                val unit = rule.checkUnit ?: "times"
                if (!slotted && !rules.countsUp(habit, day)) {
                    val ticked = tickedOverride ?: store.isTicked(habit, day)
                    w.line = if (ticked) "Done" else "Not yet"
                    w.value = if (ticked) "Done" else "Not done yet"
                    w.big = w.value
                } else if (period != GoalPeriod.DAY) {
                    w.value = "${Format.amount(progress)} of ${Format.amount(goal)} $unit"
                    // The Android widget design: the period's count, as Today's row says it ("1 of 3 this week").
                    w.line = "${Format.amount(progress)} of ${Format.amount(goal)}$thisPeriod"
                    w.big = Format.amount(progress); w.goal = "of ${Format.amount(goal)}$thisPeriod"
                } else {
                    w.value = "${Format.amount(progress)} of ${Format.amount(goal)} ${if (unit == "times") "checks" else unit}"
                    w.line = w.value
                    w.big = Format.amount(progress); w.goal = "of ${Format.amount(goal)} $unit"
                }
            }
            is HabitKind.Amount -> {
                val named = if (k.unit.isEmpty()) "" else " " + k.unit
                val maxWord = if (rule.atMost) " max" else ""
                w.value = "${Format.amount(progress)} of ${Format.amount(goal)}$named$maxWord"
                w.big = Format.amount(progress); w.goal = "of ${Format.amount(goal)}$named$thisPeriod"
                w.line = if (period != GoalPeriod.DAY && !rule.atMost) "${Format.amount(progress)} of ${Format.amount(goal)}$named$thisPeriod"
                    else "${Format.amount(progress)} of ${Format.amount(goal)}$named"
            }
            HabitKind.Duration -> {
                val maxWord = if (rule.atMost) " max" else ""
                val (doneText, of) = minutes(progress, goal)
                w.value = "$doneText of $of$maxWord"
                w.big = doneText; w.goal = "of $of" + when (period) { GoalPeriod.WEEK -> " a week"; GoalPeriod.MONTH -> " a month"; else -> "" }
                w.line = if (period != GoalPeriod.DAY && !rule.atMost) "$doneText of $of$thisPeriod" else "$doneText of $of"
                if (running) {
                    val clock = now - (progress * 60_000).toLong()
                    w.timerClock = clock
                    w.timerGoalAt = clock + (goal * 60_000).toLong()
                    w.timerGoal = if (rule.atMost) " of ${Format.amount(goal)} max" else " of $of"
                }
            }
            HabitKind.Checklist -> {
                w.value = "${Format.amount(progress)} of ${Format.amount(goal)} steps"
                w.line = w.value; w.big = Format.amount(progress); w.goal = "of ${Format.amount(goal)} steps"
            }
            HabitKind.Quit, HabitKind.Task -> {}
        }
        if (rule.atMost) {
            // The state in words, never red and never shame (U3).
            val state = if (progress > goal) "Over the limit" else if (progress == goal) "Limit reached"
                else when (period) { GoalPeriod.WEEK -> "Weekly limit"; GoalPeriod.MONTH -> "Monthly limit"; else -> "Daily limit" }
            w.caption = state
            w.line = w.line + " · " + state
        }
        if (!planned) return
        // The one button (U14): ✓ toggles today, + adds one saved step, ▶/⏸ the timer; anything needing a screen opens it.
        val meetsWith = { step: Double -> !rule.atMost && !complete && progress + step >= goal }
        when (rule.kind) {
            HabitKind.Check -> when {
                slotted -> {
                    val open = slots(store, habit).filter { !store.isSlotDone(habit, it, day) }
                    if (open.isEmpty()) { w.action = WidgetAction.OPEN; w.route = "item/${habit.id}" }
                    else { w.action = WidgetAction.ADD; w.completesNext = open.size == 1 }
                }
                // A check habit always shows ✓, even counted: each ✓ adds one check (U14), so no "+1" text.
                rules.countsUp(habit, day) -> { w.action = WidgetAction.ADD; w.completesNext = meetsWith(1.0) }
                else -> w.action = WidgetAction.CHECK
            }
            is HabitKind.Amount -> {
                val step = habit.quickIncrement
                if (step != null && step.isFinite() && step > 0) { w.action = WidgetAction.ADD; w.actionText = "+" + Format.amount(step); w.completesNext = meetsWith(step) }
                else { w.action = WidgetAction.OPEN; w.route = "log/${habit.id}" }
            }
            HabitKind.Duration -> w.action = if (running) WidgetAction.TIMER_PAUSE else WidgetAction.TIMER_START
            HabitKind.Checklist -> { w.action = WidgetAction.OPEN; w.route = "item/${habit.id}" }
            HabitKind.Quit, HabitKind.Task -> {}
        }
    }

    /** "12" and "20 min", "1h 12m" and "3 h": short enough for a small card. */
    fun minutes(progress: Double, goal: Double): Pair<String, String> {
        fun short(v: Double): String {
            val total = floor(v).toInt(); val h = total / 60; val m = total % 60
            return if (h == 0) "${m}m" else if (m == 0) "${h}h" else "${h}h ${m}m"
        }
        val goalText = Format.minutes(goal)
        if (goal < 60 && progress < 60) return floor(progress).toInt().toString() to goalText
        return (if (progress < 1) "0" else short(progress)) to goalText
    }

    /** A quit run: "45 days", "1 day", "14 hours". */
    fun runText(seconds: Double): String {
        val days = (seconds / 86_400).toInt(); val hours = (seconds / 3600).toInt()
        if (days >= 1) return if (days == 1) "1 day" else "$days days"
        return if (hours == 1) "1 hour" else "$hours hours"
    }

    /** Mutable while one card is worked out; a [WidgetItem] once built. */
    private class Builder(val id: String, val name: String, val symbol: String, val color: String, val type: String, val isTask: Boolean, val limit: Boolean) {
        var state: String? = null; var cards: List<String> = emptyList(); var line = ""; var todayLine = ""; var place = ""
        var value = ""; var big = ""; var goal = ""; var caption: String? = null; var fraction: Double? = null; var cardFraction: Double? = null
        var limitFill = false; var done = false; var completesNext: Boolean? = null; var todayAmount: Double? = null; var todayLevel: Int? = null
        var counts = false; var countsDone = false; var sinks = false; var action = WidgetAction.OPEN; var actionText: String? = null
        var route: String? = null; var streak: String? = null; var quitStart: Long? = null; var quitUntil: Long? = null
        var quitBest: Double? = null; var quitBestText: String? = null; var since: String? = null; var timerClock: Long? = null
        var timerGoalAt: Long? = null; var timerGoal: String? = null; var week: List<Int> = emptyList(); var weekToday = -1
        fun build() = WidgetItem(id, name, symbol, color, type, isTask, limit, state, cards, line, todayLine, place, value, big, goal,
            caption, fraction, cardFraction, limitFill, done, completesNext, null, todayAmount, todayLevel, counts, countsDone, sinks,
            action, actionText, route, newId(), streak, quitStart, quitUntil, quitBest, quitBestText, since, timerClock, timerGoalAt,
            timerGoal, week, weekToday)
    }
}
