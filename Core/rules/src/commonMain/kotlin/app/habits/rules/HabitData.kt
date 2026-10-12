package app.habits.rules

/**
 * Everything the rules read: the habits, their logs (by habit and by day), skips, moved task days, pauses, goal history,
 * archive days, running timers, the times of day and Today's card order. Built once from the saved rows ([Rows]); a
 * caller that keeps it changes logs with [addEntry] / [removeEntry], so nothing walks every log after a tap (Rulebook S5).
 */
class HabitData(
    habits: List<Habit>,
    entries: List<Entry>,
    val skips: Map<String, Set<Int>> = emptyMap(),
    val moves: Map<String, Map<Int, Int>> = emptyMap(),
    val pauses: Map<String, List<Pause>> = emptyMap(),
    val rules: Map<String, List<PastRule>> = emptyMap(),
    val archivedOn: Map<String, Int> = emptyMap(),
    val timers: Map<String, Long> = emptyMap(),
    val sections: List<DaySection> = DaySection.defaults,
    val cardOrder: List<String> = emptyList(),
) {
    val habits: List<Habit> = habits
    val habitById: Map<String, Habit> = habits.associateBy { it.id }
    private val byHabit = HashMap<String, MutableList<Entry>>()
    private val byDay = HashMap<String, HashMap<Int, MutableList<Entry>>>()

    init {
        for (e in entries) index(e)
    }

    private fun index(e: Entry) {
        byHabit.getOrPut(e.habitId) { ArrayList() }.add(e)
        byDay.getOrPut(e.habitId) { HashMap() }.getOrPut(e.day) { ArrayList() }.add(e)
    }

    /** One habit's logs, in the order they were made. */
    fun entries(habit: String): List<Entry> = byHabit[habit] ?: emptyList()

    /** One habit's logs on one day, in the order they were made. */
    fun entries(habit: String, day: Int): List<Entry> = byDay[habit]?.get(day) ?: emptyList()

    fun addEntry(e: Entry) = index(e)

    fun removeEntry(id: String, habit: String) {
        val e = byHabit[habit]?.firstOrNull { it.id == id } ?: return
        byHabit[habit]?.remove(e)
        byDay[habit]?.get(e.day)?.remove(e)
    }
}
