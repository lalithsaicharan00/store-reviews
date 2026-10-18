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
    /** An amount with a saved step: adds the step ("Log 1 glass"). */
    LOG_STEP,
    /** An amount typed each time: opens Add log. */
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
    const val STEP_SAVED = "Step saved"
    const val STEP_UNCHECKED = "Step unchecked"
    const val UNDONE = "Undone"
    const val SKIPPED = "Skipped for today"
    const val TIME_SAVED = "Time saved"
    const val AMOUNT_SAVED = "Amount saved"

    const val QUEUE_FOOTER = "Jump to any habit, or change the order for this routine. Moving on never marks a habit done."
    const val NEW_DAY_TITLE = "A new day has started"
    const val NEW_DAY_TEXT = "Your routine's progress is saved to its original day. Return to Today to continue."

    /** "Habit 4 of 12" under the routine's name. */
    fun position(index: Int, count: Int): String = "Habit ${minOf(index + 1, count)} of $count"

    /** The end page's line under the routine's name: "12 of 12 covered". */
    fun covered(covered: Int, count: Int): String = "$covered of $count covered"

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
     * "of 3 steps", "of 1" (the iPhone's `progressTarget`, with its period).
     */
    fun target(habit: Habit, goal: Double): String {
        val text = when (val k = habit.kind) {
            HabitKind.Duration -> Format.minutes(goal)
            is HabitKind.Amount -> HabitCopy.amount(goal, k.unit)
            HabitKind.Check -> habit.checkUnit?.takeIf { it.isNotBlank() }?.let { HabitCopy.amount(goal, it) } ?: HabitCopy.number(goal)
            HabitKind.Checklist -> HabitCopy.number(goal) + if (habit.frequency.isDayBased) " steps" else " days"
            HabitKind.Quit, HabitKind.Task -> HabitCopy.number(goal)
        }
        return "of " + text + (if (habit.atMost) " max" else "") + period(habit.frequency)
    }

    /**
     * The one main action (the iPhone's `primary`): skipped or done moves on ("Next", or "Finish routine" on the last
     * habit); a limit logs what happened and is never "done"; otherwise ✓, one, a step, an amount or the timer.
     * [goal] is the habit's goal as judged ("Log one" for more than one).
     */
    fun mainAction(habit: Habit, goal: Double, done: Boolean, skipped: Boolean, isLast: Boolean, running: Boolean, started: Boolean): MainAction {
        val onward = if (isLast) MainAction(PlayerAction.FINISH, "Finish routine", "Finish routine")
            else MainAction(PlayerAction.NEXT, "Next", "Next habit")
        if (skipped) return onward
        val unit = habit.unit
        val step = habit.quickIncrement
        fun timer() = when {
            running -> MainAction(PlayerAction.PAUSE, "Pause", "Stop ${habit.name} timer")
            started -> MainAction(PlayerAction.RESUME, "Resume", "Start ${habit.name} timer")
            else -> MainAction(PlayerAction.START, "Start", "Start ${habit.name} timer")
        }
        fun amount() = if (step != null) MainAction(PlayerAction.LOG_STEP, "Log " + HabitCopy.amount(step, unit), "Add ${HabitCopy.amount(step, unit)} to ${habit.name}")
            else MainAction(PlayerAction.LOG_AMOUNT, "Log amount", "Log an amount for ${habit.name}")
        if (habit.atMost) {
            // Cut down: log what happened; it never becomes "done" (P23).
            return when (habit.kind) {
                HabitKind.Duration -> timer()
                is HabitKind.Amount -> amount()
                HabitKind.Check, HabitKind.Task -> MainAction(PlayerAction.LOG_ONE, "Log one", "Add 1 to ${habit.name}")
                HabitKind.Checklist, HabitKind.Quit -> MainAction(PlayerAction.NONE, "", "")
            }
        }
        if (done) return onward
        return when (habit.kind) {
            HabitKind.Check, HabitKind.Task ->
                if (habit.kind == HabitKind.Check && goal > 1) MainAction(PlayerAction.LOG_ONE, "Log one", "Mark ${habit.name} done")
                else MainAction(PlayerAction.MARK_DONE, "Mark done", "Mark ${habit.name} done")
            is HabitKind.Amount -> amount()
            HabitKind.Duration -> timer()
            HabitKind.Checklist, HabitKind.Quit -> MainAction(PlayerAction.NONE, "", "")
        }
    }

    /** A habit's line in Your routine. */
    fun queueStatus(atMost: Boolean, reviewed: Boolean, doneToday: Boolean, skipped: Boolean): String = when {
        atMost -> if (reviewed) "Checked in" else "Limit check-in"
        doneToday -> "Done"
        skipped -> "Skipped for today"
        else -> "Not finished"
    }

    /** The end page's title. */
    fun endTitle(remaining: Int): String = if (remaining == 0) "Routine finished" else "End of the routine"

    /** "2 left for later. Your progress is saved." */
    fun endText(remaining: Int, reviewed: Int): String {
        if (remaining == 0) return if (reviewed == 0) "All habits in this routine are done." else "Your routine is complete. Your progress is saved."
        return "$remaining left for later. Your progress is saved."
    }

    /** "1 skipped for today. Skipped days don't count against you." (never shame, U3), or null with none. */
    fun skippedLine(skipped: Int): String? =
        if (skipped > 0) "$skipped skipped for today. Skipped days don't count against you." else null

    /** "2 limit check-ins. Your limits keep tracking through the day.", or null with none. */
    fun limitsLine(reviewed: Int): String? =
        if (reviewed > 0) "$reviewed limit ${if (reviewed == 1) "check-in" else "check-ins"}. Your limits keep tracking through the day." else null

    /** The timer's ⌄: putting it away, not stopping, and TalkBack says so. */
    fun timerClose(running: Boolean): String = if (running) "Close, the timer keeps running" else "Close"
}
