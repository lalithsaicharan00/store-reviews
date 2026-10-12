package app.habits.rules

/**
 * Every log, by habit and by day. Kept by the caller for as long as the data lives: a tap adds or removes one log
 * ([add], [remove]), so nothing walks every log after a tap (Rulebook S5). Habits and settings change rarely and are
 * replaced whole ([HabitData]); the logs stay here.
 */
class EntryIndex(entries: List<Entry> = emptyList()) {
    private val byHabit = HashMap<String, MutableList<Entry>>()
    private val byDay = HashMap<String, DayBuckets>()

    init {
        for (e in entries) add(e)
    }

    /** One habit's logs, in the order they were made. */
    fun of(habit: String): List<Entry> = byHabit[habit] ?: emptyList()

    /** One habit's logs on one day, in the order they were made. */
    fun of(habit: String, day: Int): List<Entry> = byDay[habit]?.get(day) ?: emptyList()

    fun add(e: Entry) {
        byHabit.getOrPut(e.habitId) { ArrayList() }.add(e)
        byDay.getOrPut(e.habitId) { DayBuckets() }.getOrPut(e.day).add(e)
    }

    /** Puts a log at [position] among its habit's logs (an undone delete goes back where it was). */
    fun insert(e: Entry, position: Int) {
        val list = byHabit.getOrPut(e.habitId) { ArrayList() }
        list.add(position.coerceIn(0, list.size), e)
        val day = byDay.getOrPut(e.habitId) { DayBuckets() }.getOrPut(e.day)
        // The day's logs keep the habit's order.
        val before = list.indexOf(e)
        val at = day.indexOfFirst { list.indexOf(it) > before }.let { if (it < 0) day.size else it }
        day.add(at, e)
    }

    fun remove(id: String, habit: String): Entry? {
        val list = byHabit[habit] ?: return null
        val i = list.indexOfFirst { it.id == id }
        if (i < 0) return null
        val e = list.removeAt(i)
        byDay[habit]?.get(e.day)?.let { day -> day.indexOfFirst { it.id == id }.takeIf { it >= 0 }?.let { day.removeAt(it) } }
        return e
    }

    /** An edit: the same place, the new value (its day may change). */
    fun replace(e: Entry) {
        val list = byHabit[e.habitId] ?: return add(e)
        val i = list.indexOfFirst { it.id == e.id }
        if (i < 0) return add(e)
        val old = list[i]
        list[i] = e
        val days = byDay.getOrPut(e.habitId) { DayBuckets() }
        if (old.day == e.day) {
            days[e.day]?.let { day -> day.indexOfFirst { it.id == e.id }.takeIf { it >= 0 }?.let { day[it] = e } }
        } else {
            days[old.day]?.removeAll { it.id == e.id }
            val day = days.getOrPut(e.day)
            val at = day.indexOfFirst { list.indexOf(it) > i }.let { if (it < 0) day.size else it }
            day.add(at, e)
        }
    }

    fun clear() {
        byHabit.clear()
        byDay.clear()
    }
}

/**
 * One habit's logs by day, in a list indexed by the day number: reading a day neither hashes nor boxes it, and the
 * rules read a habit's days one at a time across weeks and years (Current Work 92, checkpoint 2: on the iPhone and the
 * Watch each boxed day was an allocation). The list covers the days logged so far and grows to take a new one; a day
 * that would stretch it past [MAX_SPAN] days (a log dated centuries away) is kept in a map beside it.
 */
internal class DayBuckets {
    private var first = 0
    private var slots: Array<MutableList<Entry>?> = arrayOfNulls(0)
    private var far: HashMap<Int, MutableList<Entry>>? = null

    operator fun get(day: Int): MutableList<Entry>? {
        val i = day - first
        return if (i >= 0 && i < slots.size) slots[i] else far?.get(day)
    }

    fun getOrPut(day: Int): MutableList<Entry> {
        get(day)?.let { return it }
        if (!cover(day)) return far().getOrPut(day) { ArrayList() }
        val made = ArrayList<Entry>()
        slots[day - first] = made
        return made
    }

    private fun far(): HashMap<Int, MutableList<Entry>> = far ?: HashMap<Int, MutableList<Entry>>().also { far = it }

    /** Grows the list to include [day] (with room to spare either side); false when that would be too long. */
    private fun cover(day: Int): Boolean {
        if (slots.isEmpty()) {
            first = day - SPARE
            slots = arrayOfNulls(2 * SPARE + 1)
            return true
        }
        val last = first + slots.size - 1
        if (day in first..last) return true
        val newFirst = if (day < first) day - maxOf(SPARE, slots.size / 2) else first
        val newLast = if (day > last) day + maxOf(SPARE, slots.size / 2) else last
        if (newLast - newFirst + 1 > MAX_SPAN) return false
        val grown = arrayOfNulls<MutableList<Entry>>(newLast - newFirst + 1)
        slots.copyInto(grown, destinationOffset = first - newFirst)
        first = newFirst
        slots = grown
        return true
    }

    private companion object {
        const val SPARE = 32
        /** About 120 years of days. */
        const val MAX_SPAN = 44_000
    }
}

/**
 * Everything the rules read: the habits, their logs ([logs]), skips, moved task days, pauses, goal history, archive
 * days, running timers, the times of day and Today's card order. Built from the saved rows ([Rows.load]).
 */
class HabitData(
    val habits: List<Habit>,
    val logs: EntryIndex,
    val skips: Map<String, Set<Int>> = emptyMap(),
    val moves: Map<String, Map<Int, Int>> = emptyMap(),
    val pauses: Map<String, List<Pause>> = emptyMap(),
    val rules: Map<String, List<PastRule>> = emptyMap(),
    val archivedOn: Map<String, Int> = emptyMap(),
    val timers: Map<String, Long> = emptyMap(),
    val sections: List<DaySection> = DaySection.defaults,
    val cardOrder: List<String> = emptyList(),
) {
    constructor(
        habits: List<Habit>, entries: List<Entry>, skips: Map<String, Set<Int>> = emptyMap(),
        moves: Map<String, Map<Int, Int>> = emptyMap(), pauses: Map<String, List<Pause>> = emptyMap(),
        rules: Map<String, List<PastRule>> = emptyMap(), archivedOn: Map<String, Int> = emptyMap(),
        timers: Map<String, Long> = emptyMap(), sections: List<DaySection> = DaySection.defaults,
        cardOrder: List<String> = emptyList(),
    ) : this(habits, EntryIndex(entries), skips, moves, pauses, rules, archivedOn, timers, sections, cardOrder)

    val habitById: Map<String, Habit> = habits.associateBy { it.id }

    /** One habit's logs, in the order they were made. */
    fun entries(habit: String): List<Entry> = logs.of(habit)

    /** One habit's logs on one day, in the order they were made. */
    fun entries(habit: String, day: Int): List<Entry> = logs.of(habit, day)
}
