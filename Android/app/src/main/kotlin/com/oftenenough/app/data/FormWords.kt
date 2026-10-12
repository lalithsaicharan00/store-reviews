package com.oftenenough.app.data

// MOVE TO CORE: the New Habit form's live sentences, ported from the iPhone's Outcome.swift. They say what will happen
// before Add, built from the draft habit with the same rules Today and the reminders use.

object Outcome {
    /** Most "remind again" follow-ups for one reminder (the iPhone's `ReminderScheduler.maxFollowUps`). */
    const val MAX_FOLLOW_UPS = 3

    /** Where it shows on Today, and for week, month and year rules, until when. */
    fun timeOfDay(habit: Habit, store: HabitStore): String {
        val f = habit.frequency
        if (f is Frequency.Flexible) {
            val what = HabitCopy.howMuch(habit)?.let { "Reach $it" } ?: "Tick it"
            return "$what on ${if (f.n == 1) "1 day" else "${f.n} different days"} each ${f.period.noun}. You can still log extra days after that."
        }
        val placements = store.rules.placements(habit)
        val names = placements.map { store.section(it.section).name }
        var sentence = if (placements.size >= 2) {
            "It shows in ${HabitCopy.join(names)}. It's one ${if (habit.kind == HabitKind.Task) "task" else "habit"}: do it in any of them."
        } else {
            val section = store.section(placements.firstOrNull()?.section ?: DaySection.ANYTIME)
            hours(section, store)?.let { "It shows in ${section.name} on Today ($it)." }
                ?: "It shows in Anytime on Today, so you can do it whenever suits you."
        }
        periodRule(habit)?.let { sentence += " It stays on Today every day until $it." }
        return sentence
    }

    /** What the phone will do, and when it stops. */
    fun reminders(habit: Habit, store: HabitStore, alarmsAvailable: Boolean): String {
        if (!habit.remind || habit.reminders.isEmpty()) return "No notifications. You'll see it on Today."
        val alarm = habit.alert == "alarm" && alarmsAvailable
        val word = if (alarm) "An alarm" else "A notification"
        val times = habit.reminders.sortedBy { store.rules.dayMinute(it.minuteOfDay) }
        val at = "at " + HabitCopy.join(times.map { DayWords.clockMinute(it.minuteOfDay) })
        val placements = store.rules.placements(habit)
        var sentence = when {
            habit.atMost -> "$word $at on each of its days."
            habit.kind == HabitKind.Task -> "$word $at on the day. None once it's done."
            else -> periodRule(habit, forReminders = true)?.let { "$word $at each day until $it." }
                ?: ("$word $at on its days. " + if (placements.any { it.slot != null }) "None for a part of the day you've already finished." else "None once it's done for the day.")
        }
        if (alarm) sentence += " It rings even on silent, until you stop it. Stopping it doesn't tick the habit; its Done button does."
        val every = habit.followUpMinutes
        if (every != null && !habit.atMost) {
            sentence += " If it isn't done, it reminds you again every ${if (every == 60) "hour" else "$every min"}, up to $MAX_FOLLOW_UPS times."
        }
        // A reminder in another part of the day is allowed, but said, so it isn't a surprise.
        val shown = placements.map { it.section }.toSet()
        if (!habit.isQuitOrLimit && DaySection.ANYTIME !in shown) {
            times.firstOrNull { store.rules.sectionForMinute(it.minuteOfDay) !in shown }?.let { first ->
                val part = store.section(store.rules.sectionForMinute(first.minuteOfDay)).name
                val order = store.sections.map { it.id }
                val names = shown.sortedBy { order.indexOf(it) }.map { store.section(it).name }
                sentence += " Note: ${DayWords.clockMinute(first.minuteOfDay)} is in the $part, but the habit shows in ${HabitCopy.join(names)}."
            }
        }
        return sentence
    }

    /** "6:00 AM – 12:00 PM" for a timed part of the day; null for Anytime. */
    fun hours(section: DaySection, store: HabitStore): String? {
        val start = section.start ?: return null
        val end = store.timedSections().firstOrNull { it.first.id == section.id }?.second ?: return null
        return "${DayWords.clockMinute(start)} – ${DayWords.clockMinute(end % (24 * 60))}"
    }

    private fun periodRule(habit: Habit, forReminders: Boolean = false): String? {
        val f = habit.frequency
        if (f is Frequency.Flexible) return "it's done on ${if (f.n == 1) "1 day" else "${f.n} different days"} this ${f.period.noun}"
        val (n, period) = when (f) {
            is Frequency.PerWeek -> f.n to "week"
            is Frequency.PerMonth -> f.n to "month"
            is Frequency.PerYear -> f.n to "year"
            else -> return null
        }
        if (habit.atMost) return null
        when (val k = habit.kind) {
            is HabitKind.Amount -> return "you reach ${HabitCopy.amount(habit.goal, k.unit)} this $period"
            HabitKind.Duration -> return "you reach ${HabitCopy.minutes(habit.goal)} this $period"
            else -> {}
        }
        if (forReminders) return if (n == 1) "it's done this $period" else "this $period's $n are done"
        return "you've done it ${HabitCopy.times(n)} this $period"
    }
}
