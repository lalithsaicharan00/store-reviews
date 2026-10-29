package com.oftenenough.app.data

// MOVE TO CORE: the form's words worked out from the rules (a time of day's hours).

object FormOutcome {
    /** "6:00 AM – 12:00 PM" for a timed part of the day; null for Anytime. */
    fun hours(section: DaySection, store: HabitStore): String? {
        val start = section.start ?: return null
        val end = store.timedSections().firstOrNull { it.first.id == section.id }?.second ?: return null
        return "${DayWords.clockMinute(start)} – ${DayWords.clockMinute(end % (24 * 60))}"
    }
}
