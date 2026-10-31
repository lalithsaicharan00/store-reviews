package com.oftenenough.app.data

// MOVE TO CORE: the routine player's and the timer's words and its one-main-action rule, ported from the iPhone's
// iOS/Habits/Today/RoutinePlayer.swift (`primary`, `progressTarget`, `FocusProgressValue.period`, `summary`, `queue`,
// the save messages) and TimerScreen.swift (the close button's name). Checked case for case in PlayerWordsTest. Until
// the words move into the shared core (Core/spec/README.md), this is the one Android copy.

/** What the player's main button does for the habit on screen (the iPhone's `RoutinePlayer.primary`, one per kind). */
enum class PlayerAction {
    /** Done or skipped: on to the next habit. */
    NEXT,
    /** Done or skipped, and the last habit: on to the end page. */
    FINISH,
    /** A once-a-day check or a task: ✓. */
    MARK_DONE,
    /** A check counted several times (a day, or N a week): adds one, never takes one back (U14). */
    LOG_ONE,
    /** An amount with a saved step: adds the step ("+1", "+2.5": + and the step, never the unit, U16). */
    LOG_STEP,
    /** An amount typed each time ("Log", the word alone), or time on another day: opens Add log. */
    LOG_AMOUNT,
    START,
    RESUME,
    PAUSE,
    /** A checklist (its steps are the action) or a quit habit. */
    NONE,
}

/** The main button: what it does, its label (one line, ending in … when long) and what TalkBack reads. */
data class MainAction(val action: PlayerAction, val label: String, val spoken: String)

object PlayerWords {
    // The save messages ("Saved · Undo · Add note"), as the iPhone's banner says them.
    const val SAVED = "Saved"
    const val LOGGED = "Logged"
    const val UNDONE = "Undone"
    const val SKIPPED = "Skipped for today"
    const val STREAK_SAFE = "Your streak stays safe."

    const val QUEUE_FOOTER = "Tap a habit to go to it. Moving never marks anything done."
    /** Your routine · Edit (Figma 7.2). */
    const val QUEUE_FOOTER_EDIT = "Drag to change the order for this run. Today's order stays as it is."

    // The status line under the count (Figma 2.4, 4.2–4.5, 6.1, 9.1, 9.2): neutral words, never red (U3).
    const val DONE_FOR_TODAY = "Done for today"
    const val PAUSED = "Paused"
    const val GOAL_MET = "Goal met"
    const val OVER_LIMIT = "Over the limit"
    /** A single check or a task, in place of "0 of 1" (Figma's Routine player, Value). */
    const val NOT_DONE = "Not done"
    const val DONE = "Done"
    const val NEW_DAY_TITLE = "A new day has started"
    const val NEW_DAY_TEXT = "Your routine's progress is saved to its original day. Return to Today to continue."

    /** "4 of 12" at the end of the routine's progress bar (Figma 1328:2, under the title since 14 Oct). */
    fun position(index: Int, count: Int): String = "${minOf(index + 1, count)} of $count"

    /** Opening a routine that's partly done (Figma 1.2): "3 done earlier today. Starting at Water."; another day, "3 already done". */
    fun startingAt(doneBefore: Int, name: String, today: Boolean = true): String =
        "$doneBefore " + (if (today) "done earlier today" else "already done") + ". Starting at $name."

    /** TalkBack's name for the title: "Morning routine, habit 2 of 10", or "…, summary" on the end page. */
    fun routineSpoken(name: String, index: Int, count: Int): String =
        "$name routine, " + if (index < count) "habit ${index + 1} of $count" else "summary"

    /** TalkBack's reading of the segments: "3 of 12 habits covered". */
    fun segmentsSpoken(covered: Int, count: Int): String = "$covered of $count habits covered"

    /** "This week" words after the goal, for a total over a period (the iPhone's `FocusProgressValue.period`). */
    fun period(f: Frequency): String = when (f) {
        is Frequency.PerWeek -> " this week"
        is Frequency.PerMonth -> " this month"
        is Frequency.PerYear -> " this year"
        else -> ""
    }

    /** The large number: "2", "2.5", "£0" (a currency before it, as `HabitCopy.amount`); a time habit's clock "5:24". */
    fun value(habit: Habit, progress: Double): String {
        if (habit.kind == HabitKind.Duration) return Format.clock(progress)
        val unit = habit.unit.trim()
        return if (habit.kind is HabitKind.Amount && unit in HabitCopy.currencies) unit + HabitCopy.number(progress) else HabitCopy.number(progress)
    }

    /**
     * Beside the number: "of 8 glasses", "of 20 min", "of 2 cups max", "of 15 kilometres this week", "of £200 this month",
     * "of 3 steps", "of 1" (the iPhone's `progressTarget`, with its period; an amount's period is [periodLine]).
     */
    fun target(habit: Habit, goal: Double): String {
        val text = when (val k = habit.kind) {
            HabitKind.Duration -> Format.minutes(goal)
            is HabitKind.Amount -> HabitCopy.amount(goal, k.unit)
            // A day's checks say "times" ("of 3 times", Figma 253:2); a week's or month's are counted by the period ("of 3 this week").
            HabitKind.Check -> habit.checkUnit?.takeIf { it.isNotBlank() }?.let { HabitCopy.amount(goal, it) }
                ?: (HabitCopy.number(goal) + if (habit.frequency.isDayBased && goal > 1) " times" else "")
            HabitKind.Checklist -> HabitCopy.number(goal) + if (habit.frequency.isDayBased) " steps" else " days"
            HabitKind.Quit, HabitKind.Task -> HabitCopy.number(goal)
        }
        // An amount's period goes on the line under it ("$250 of $500", then "This month": Figma 252:2), where it has room.
        return "of " + text + (if (habit.atMost) " max" else "") + if (habit.kind is HabitKind.Amount) "" else period(habit.frequency)
    }

    /** The line under an amount kept by the period: "This week", "This month" (Figma 252:2); nothing for a day's goal. */
    fun periodLine(f: Frequency): String? = period(f).trim().takeIf { it.isNotEmpty() }?.replaceFirstChar { it.uppercase() }

    /**
     * The one main action (the iPhone's `primary`): skipped or done moves on ("Next", or "Finish routine" on the last
     * habit); a limit logs what happened and is never "done"; otherwise ✓, one, a step, an amount or the timer.
     * [goal] is the habit's goal as judged ("Add a check" for more than one).
     */
    fun mainAction(habit: Habit, goal: Double, done: Boolean, skipped: Boolean, isLast: Boolean, running: Boolean, started: Boolean,
                   today: Boolean = true): MainAction {
        val onward = if (isLast) MainAction(PlayerAction.FINISH, "Finish", "Finish routine")  // Figma: "Finish"
            else MainAction(PlayerAction.NEXT, "Next", "Next habit")
        if (skipped) return onward
        val unit = habit.unit
        val step = habit.quickIncrement
        fun timer() = when {
            // Another day has no clock to run: its time is typed (Figma 1.4, "logs go to it").
            !today -> MainAction(PlayerAction.LOG_AMOUNT, "Log", "Log time for ${habit.name}")
            running -> MainAction(PlayerAction.PAUSE, "Pause", "Stop ${habit.name} timer")
            started -> MainAction(PlayerAction.RESUME, "Resume", "Start ${habit.name} timer")
            else -> MainAction(PlayerAction.START, "Start", "Start ${habit.name} timer")
        }
        fun amount() = if (step != null) MainAction(PlayerAction.LOG_STEP, "+" + HabitCopy.number(step), "Add ${HabitCopy.amount(step, unit)} to ${habit.name}")
            else MainAction(PlayerAction.LOG_AMOUNT, "Log", "Log an amount for ${habit.name}")
        if (habit.atMost) {
            // Cut down: log what happened; it never becomes "done" (P23).
            return when (habit.kind) {
                HabitKind.Duration -> timer()
                is HabitKind.Amount -> amount()
                HabitKind.Check, HabitKind.Task -> MainAction(PlayerAction.LOG_ONE, "Add a check", "Add a check to ${habit.name}")
                HabitKind.Checklist, HabitKind.Quit -> MainAction(PlayerAction.NONE, "", "")
            }
        }
        // At the goal the clock keeps counting and Pause stays; Next comes once it's paused (Figma 4.3).
        if (habit.kind == HabitKind.Duration && running && today) return timer()
        if (done) return onward
        return when (habit.kind) {
            HabitKind.Check, HabitKind.Task ->
                // Several a day or a week: "Add a check", as Day details (Figma 253:2, 253:397).
                if (habit.kind == HabitKind.Check && goal > 1) MainAction(PlayerAction.LOG_ONE, "Add a check", "Add a check to ${habit.name}")
                else MainAction(PlayerAction.MARK_DONE, "Mark done", "Mark ${habit.name} done")
            is HabitKind.Amount -> amount()
            HabitKind.Duration -> timer()
            HabitKind.Checklist, HabitKind.Quit -> MainAction(PlayerAction.NONE, "", "")
        }
    }

    /** A habit's line in Your routine (Figma 907:29174): "Here now", "Done" or "Not done", nothing else (cleanup 6.8). */
    fun queueStatus(doneToday: Boolean, here: Boolean = false): String = when {
        here -> "Here now"
        doneToday -> "Done"
        else -> "Not done"
    }

    /** The end page's title: "Anytime is done" (Figma 1.3, 8.2), or "End of the routine" with some left (8.1, 8.3). */
    fun endTitle(remaining: Int, count: Int, name: String): String = if (remaining == 0) "$name is done" else "${count - remaining} of $count done"

    /** "All 3 done today." or, by name, what waits: "Stretch and Skincare wait on Today. Pick them up any time." (Figma 929:126945). */
    fun endText(left: List<String>, count: Int): String = when (left.size) {
        0 -> "All $count done today."
        1 -> "${left[0]} waits on Today. Pick it up any time."
        else -> "${HabitCopy.join(left)} wait on Today. Pick them up any time."
    }


    /** The timer's ⌄: putting it away, not stopping, and TalkBack says so. */
    fun timerClose(running: Boolean): String = if (running) "Close, the timer keeps running" else "Close"
}
