package com.oftenenough.app.data

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateMapOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import app.habits.core.HabitRepository
import app.habits.core.TimerStop
import java.time.Instant
import java.time.LocalDate
import java.time.ZoneId
import java.time.temporal.WeekFields
import java.util.Locale
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Job
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

/**
 * Holds habits and logs and applies every change: the iPhone's `HabitStore` (iOS/Habits/Model/HabitStore.swift), the same
 * behaviour on Android. Everything shown is worked out from these records through [rules] (the shared rules, reached only
 * through RulesGateway), never stored.
 *
 * Writes go to the database one at a time, in the order they were made. A tap that logs (✓, +1, a step, a timer) changes
 * memory and the screen at once and is written right after (Rulebook S7); a failed write reloads what's stored and says
 * so. Main thread only, like the screens that read it; the database itself works on its own dispatcher (S16).
 */
class HabitStore(
    private val repository: HabitRepository,
    private val scope: CoroutineScope,
    val clock: () -> Long = { System.currentTimeMillis() },
) {
    val rules = RulesGateway { clock() }

    // ------------------------------------------------------------------ What the screens read (Compose state)

    var habits by mutableStateOf<List<Habit>>(emptyList()); private set
    var isLoaded by mutableStateOf(false); private set
    /** Shown to the person when a write fails or the data can't be read. */
    var problem by mutableStateOf<String?>(null)
    var sections by mutableStateOf(DaySection.defaults); private set
    var cardOrder by mutableStateOf<List<String>>(emptyList()); private set
    var dayEndHour by mutableIntStateOf(0); private set
    /** 1 = Sunday … 7 = Saturday. Sunday when the person never chose (decided for Android: never "Automatic"). */
    var weekStart by mutableIntStateOf(1); private set
    /** Running timers: habit ID → start (epoch ms). */
    var timers by mutableStateOf<Map<String, Long>>(emptyMap()); private set
    var timerSlots by mutableStateOf<Map<String, String>>(emptyMap()); private set
    var skips by mutableStateOf<Map<String, Set<Int>>>(emptyMap()); private set
    var taskMoves by mutableStateOf<Map<String, Map<Int, Int>>>(emptyMap()); private set
    var pauses by mutableStateOf<Map<String, List<HabitPause>>>(emptyMap()); private set
    var goalRules by mutableStateOf<Map<String, List<HabitRule>>>(emptyMap()); private set
    var habitNotes by mutableStateOf<Map<String, Map<Int, String>>>(emptyMap()); private set
    var dayNotes by mutableStateOf<Map<Int, String>>(emptyMap()); private set
    var descriptions by mutableStateOf<Map<String, String>>(emptyMap()); private set
    var archivedOn by mutableStateOf<Map<String, Int>>(emptyMap()); private set
    var costs by mutableStateOf<Map<String, HabitCost>>(emptyMap()); private set
    var groups by mutableStateOf<List<HabitGroup>>(emptyList()); private set
    var groupsManual by mutableStateOf(false); private set
    /**
     * Undo · Note under the row of the last thing done from Today (a log, a step, a timer's time, a slip or a skip;
     * Figma 1.2). It stays until the next one (which takes it), another day or leaving Today, never forever.
     */
    var afterLog by mutableStateOf<AfterLog?>(null)
    /** Milestones reached by today's logs, and what each was shown as (Android/Docs/Milestones, decided 17 Oct 2026). */
    val milestones = MilestoneCenter(this)
    /** Bumped on every change: whole-history readers (the day bar, Progress) read it to redraw. */
    var dataVersion by mutableIntStateOf(0); private set

    /** One habit's mark: a row reads it, so it redraws for its own habit's logs, not for every tap on Today (S6). */
    private val revisions = mutableStateMapOf<String, Int>()
    fun revision(habitId: String): Int = revisions[habitId] ?: 0

    /** Called after every saved change (widgets, reminders and sync follow it, debounced by their owners: S16). */
    var onChange: (() -> Unit)? = null
    /** True while the change being reported is sync's own reload: sync mustn't send it straight back (no loop). */
    var changeIsFromSync = false; private set
    /** A person's own log: true when it makes the habit complete (the completion sound and vibration). */
    var onLog: ((Boolean) -> Unit)? = null

    // ------------------------------------------------------------------ Logs, indexed (S5)

    private val entries = ArrayList<Entry>()
    private val byHabit = HashMap<String, MutableList<Entry>>()
    private val byDay = HashMap<String, HashMap<Int, MutableList<Entry>>>()
    /** Every setting row as saved: the rules read their own keys from it (day start, skips, pauses, timers …). */
    private val settingRows = HashMap<String, String>()

    fun entries(habitId: String): List<Entry> = byHabit[habitId] ?: emptyList()
    fun entries(habitId: String, day: Int): List<Entry> = byDay[habitId]?.get(day) ?: emptyList()
    val entryCount: Int get() = entries.size
    /** One log by its ID (worked out on a tap, never while drawing a list). */
    fun entry(id: String): Entry? = entries.firstOrNull { it.id == id }

    private fun indexAdd(e: Entry) {
        byHabit.getOrPut(e.habitId) { ArrayList() }.add(e)
        byDay.getOrPut(e.habitId) { HashMap() }.getOrPut(e.day) { ArrayList() }.add(e)
    }

    private fun insertEntry(e: Entry) {
        entries.add(e)
        indexAdd(e)
        rules.addEntry(e)
        changed(e.habitId)
    }

    private fun removeEntry(id: String): Entry? {
        val i = entries.indexOfFirst { it.id == id }
        if (i < 0) return null
        val e = entries.removeAt(i)
        byHabit[e.habitId]?.removeAll { it.id == id }
        byDay[e.habitId]?.get(e.day)?.removeAll { it.id == id }
        rules.removeEntry(id, e.habitId)
        changed(e.habitId)
        return e
    }

    private fun replaceEntry(e: Entry) {
        val i = entries.indexOfFirst { it.id == e.id }
        if (i < 0) return
        entries[i] = e
        byHabit[e.habitId]?.let { list -> list.indexOfFirst { it.id == e.id }.takeIf { it >= 0 }?.let { list[it] = e } }
        byDay[e.habitId]?.get(e.day)?.let { list -> list.indexOfFirst { it.id == e.id }.takeIf { it >= 0 }?.let { list[it] = e } }
        rules.replaceEntry(e)
        changed(e.habitId)
    }

    private fun changed(habitId: String) {
        revisions[habitId] = revision(habitId) + 1
        forget(habitId)
        dataVersion++
    }

    // ------------------------------------------------------------------ Remembered numbers (S5)

    private val memo = HashMap<String, HashMap<String, Any?>>()
    private val summaries = HashMap<Int, DayScore>()

    private fun forget(habitId: String) {
        memo.remove(habitId)
        summaries.clear()
    }

    private fun forgetAll() {
        memo.clear()
        summaries.clear()
        for (id in habits.map { it.id }) revisions[id] = revision(id) + 1
        dataVersion++
    }

    @Suppress("UNCHECKED_CAST")
    private fun <T> remembered(habitId: String, key: String, work: () -> T): T {
        val map = memo.getOrPut(habitId) { HashMap() }
        if (map.containsKey(key)) return map[key] as T
        return work().also { map[key] = it }
    }

    /** The rules read habits and their settings again (rare: an edit, a setting, a load). */
    private fun rulesChanged() {
        val wanted = settingRows.filterKeys { k ->
            k == Keys.DAY_END || k == Keys.WEEK_START || k == Keys.SECTIONS || k == Keys.CARD_ORDER ||
                RULE_PREFIXES.any { k.startsWith(it) }
        }.toMutableMap()
        // Sunday when never chosen (Current Work 99: no "Automatic").
        rules.reload(habits, wanted, ZoneId.systemDefault().id, 1)
        forgetAll()
    }

    // ------------------------------------------------------------------ Days

    fun today(now: Long = clock()): Int = rules.today(now)
    fun habit(id: String): Habit? = habits.firstOrNull { it.id == id }

    /** The habit as it was judged on [day]: the goal, how often, unit and steps in force then (goal history). */
    fun rule(habit: Habit, day: Int): Habit {
        val list = goalRules[habit.id] ?: return habit
        val r = list.firstOrNull { day <= it.until } ?: return habit
        return r.applyTo(habit)
    }

    fun isTicked(habit: Habit, day: Int) = rules.isDone(habit, day)

    fun streak(habit: Habit, day: Int): Int =
        if (timers.containsKey(habit.id)) rules.streak(habit, day) else remembered(habit.id, "streak$day") { rules.streak(habit, day) }

    fun bestStreak(habit: Habit): Int = remembered(habit.id, "best") { rules.bestStreak(habit) }

    /** The day bar's "done of planned": every habit and task on Today (not archived). Past days are remembered. */
    fun daySummary(day: Int): DayScore {
        val past = day < today()
        if (past) summaries[day]?.let { return it }
        val score = rules.dayScore(day, habits.filter { !it.archived })
        if (past) summaries[day] = score
        return score
    }

    fun placements(habit: Habit): List<Placement> = remembered(habit.id, "placements") { rules.placements(habit) }

    /** Today's cards from top to bottom: time-of-day IDs and the Quit or cut down card. */
    fun todayCards(): List<String> = rules.todayCards()

    fun section(id: String): DaySection = sections.firstOrNull { it.id == id } ?: sections[0]

    /** Timed sections in order, each with the minute it ends. */
    fun timedSections(): List<Pair<DaySection, Int>> {
        val timed = sections.filter { !it.isAnytime }
        return timed.mapIndexed { i, s -> s to (if (i + 1 < timed.size) timed[i + 1].start!! else (s.end ?: (24 * 60 + dayEndHour * 60))) }
    }

    /** The time of day that is "now", if any. */
    fun nowSection(now: Long = clock()): DaySection? {
        val t = Instant.ofEpochMilli(now).atZone(ZoneId.systemDefault())
        val minute = rules.dayMinute(t.hour * 60 + t.minute)
        return timedSections().firstOrNull { (s, end) -> (s.start ?: 0) <= minute && minute < end }?.first
    }

    // ------------------------------------------------------------------ The free plan

    var isPlus by mutableStateOf(false)
    val activeHabitCount: Int get() = habits.count { !it.archived && it.kind != HabitKind.Task }
    val canAddHabit: Boolean get() = isPlus || activeHabitCount < FREE_HABIT_LIMIT

    fun suggestedColor(): HabitColor {
        val used = habits.filter { !it.archived }.map { it.color }.toSet()
        return HabitColor.entries.firstOrNull { it !in used && it != HabitColor.GRAY } ?: HabitColor.entries[habits.size % 12]
    }

    // ------------------------------------------------------------------ Loading

    /**
     * Reads everything from the database. Rows this version can't read are skipped, never deleted. Always on the store's
     * own dispatcher (the main thread), whoever calls it: a caller resumed on the database's thread once rebuilt the
     * logs while Today was reading them (run 38396646458).
     */
    suspend fun load() = withContext(scope.coroutineContext.minusKey(Job)) { loadHere() }

    private suspend fun loadHere() {
        try {
            val snapshot = repository.load()
            val steps = snapshot.steps.groupBy { it.habitId }
            val reminders = snapshot.reminders.groupBy { it.habitId }
            val loadedHabits = snapshot.habits.mapNotNull { habitOf(it, steps[it.id] ?: emptyList(), reminders[it.id] ?: emptyList()) }
            val live = loadedHabits.map { it.id }.toSet()
            entries.clear(); byHabit.clear(); byDay.clear()
            for (r in snapshot.entries) {
                val e = entryOf(r) ?: continue
                if (e.habitId !in live) continue
                entries.add(e); indexAdd(e)
            }
            settingRows.clear()
            for (s in snapshot.settings) settingRows[s.key] = s.value
            habits = loadedHabits
            readSettings()
            rules.setEntries(entries)
            rulesChanged()
            // A reload (a sync, a restore) keeps Undo · Note only while what it offers is still there.
            afterLog = afterLog?.takeIf { o ->
                when (o) {
                    is AfterLog.Log -> entries.any { it.id == o.entry.id }
                    is AfterLog.Skip -> skips[o.habitId]?.contains(o.day) == true
                }
            }
            isLoaded = true
            onChange?.invoke()
        } catch (e: Exception) {
            problem = "Your habits couldn't be read. Nothing has been changed; please restart the app."
        }
    }

    private fun readSettings() {
        var dayEnd = 0
        var week = 1
        var loadedSections = DaySection.defaults
        var cards = emptyList<String>()
        val running = HashMap<String, Long>()
        val runningSlots = HashMap<String, String>()
        val loadedSkips = HashMap<String, Set<Int>>()
        val loadedMoves = HashMap<String, Map<Int, Int>>()
        val loadedPauses = HashMap<String, List<HabitPause>>()
        val loadedRules = HashMap<String, List<HabitRule>>()
        val notes = HashMap<String, HashMap<Int, String>>()
        val dNotes = HashMap<Int, String>()
        val desc = HashMap<String, String>()
        val archived = HashMap<String, Int>()
        val loadedCosts = HashMap<String, HabitCost>()
        var loadedGroups = emptyList<HabitGroup>()
        var manual = false
        for ((key, value) in settingRows) {
            when {
                key == Keys.DAY_END -> dayEnd = (value.toIntOrNull() ?: 0).coerceIn(0, 12)
                key == Keys.WEEK_START -> value.toIntOrNull()?.takeIf { it in 1..7 }?.let { week = it }
                key == Keys.SECTIONS -> SwiftJson.sections(value)?.takeIf { it.isNotEmpty() }?.let { loadedSections = it }
                key == Keys.CARD_ORDER -> cards = SwiftJson.strings(value) ?: emptyList()
                key == Keys.GROUPS -> loadedGroups = SwiftJson.groups(value) ?: emptyList()
                key == Keys.GROUPS_ORDER -> manual = value == "manual"
                key.startsWith(Keys.NOTE) -> {
                    val parts = key.removePrefix(Keys.NOTE).split("|")
                    val day = parseDay(parts.getOrNull(1))
                    if (parts.size == 2 && day != null && value.isNotEmpty()) notes.getOrPut(parts[0]) { HashMap() }[day] = value
                }
                key.startsWith(Keys.DAY_NOTE) -> parseDay(key.removePrefix(Keys.DAY_NOTE))?.let { if (value.isNotEmpty()) dNotes[it] = value }
                key.startsWith(Keys.COST) -> SwiftJson.cost(value)?.let { loadedCosts[key.removePrefix(Keys.COST)] = it }
                key.startsWith(Keys.ARCHIVED) -> parseDay(value)?.let { archived[key.removePrefix(Keys.ARCHIVED)] = it }
                key.startsWith(Keys.DESCRIPTION) -> desc[key.removePrefix(Keys.DESCRIPTION)] = value
                key.startsWith(Keys.RULES) -> SwiftJson.rules(value)?.let { loadedRules[key.removePrefix(Keys.RULES)] = it.sortedBy { r -> r.until } }
                key.startsWith(Keys.PAUSE) -> SwiftJson.pauses(value)?.takeIf { it.isNotEmpty() }?.let { loadedPauses[key.removePrefix(Keys.PAUSE)] = it }
                key.startsWith(Keys.MOVE) -> {
                    val m = LinkedHashMap<Int, Int>()
                    for (pair in value.split(",")) {
                        val days = pair.split(">").mapNotNull { parseDay(it) }
                        if (days.size == 2) m[days[0]] = days[1]
                    }
                    if (m.isNotEmpty()) loadedMoves[key.removePrefix(Keys.MOVE)] = m
                }
                key.startsWith(Keys.SKIP) -> {
                    val days = value.split(",").mapNotNull { parseDay(it) }.toSet()
                    if (days.isNotEmpty()) loadedSkips[key.removePrefix(Keys.SKIP)] = days
                }
                key.startsWith(Keys.TIMER) -> {
                    val parts = value.split("|", limit = 2)
                    parts[0].toLongOrNull()?.let { running[key.removePrefix(Keys.TIMER)] = it }
                    if (parts.size > 1) runningSlots[key.removePrefix(Keys.TIMER)] = parts[1]
                }
            }
        }
        dayEndHour = dayEnd
        weekStart = week
        sections = loadedSections
        cardOrder = cards
        timers = running
        timerSlots = runningSlots
        skips = loadedSkips
        taskMoves = loadedMoves
        pauses = loadedPauses
        goalRules = loadedRules
        habitNotes = notes
        dayNotes = dNotes
        descriptions = desc
        costs = loadedCosts
        groupsManual = manual
        groups = if (manual) loadedGroups else loadedGroups.sortedBy { it.name.lowercase() }
        // Habits archived before archive days were kept: the day after their last log, or their first day.
        val archivedIds = habits.filter { it.archived }.map { it.id }.toSet()
        for (h in habits.filter { it.archived }) {
            if (archived.containsKey(h.id)) continue
            val last = entries(h.id).maxOfOrNull { it.day }
            archived[h.id] = last?.let { it + 1 } ?: (h.startsOn ?: rules.calendarDayOf(h.createdAt))
        }
        archivedOn = archived.filterKeys { it in archivedIds }
    }

    // ------------------------------------------------------------------ The write queue

    private val queue = Channel<Pair<Boolean, suspend () -> Unit>>(Channel.UNLIMITED)
    private var pendingWrites = 0
    private var reloadWhenWritten = false
    private var worker: Job? = null

    /** Runs database writes one at a time, in the order they were made. [tap]: a log from a tap (its own words if it fails). */
    fun perform(tap: Boolean = false, change: suspend () -> Unit) {
        if (!isLoaded) {
            problem = "Your habits haven't loaded, so that change wasn't saved. Please restart the app."
            return
        }
        pendingWrites++
        queue.trySend(tap to change)
        if (worker == null) worker = scope.launch {
            for ((isTap, job) in queue) {
                try {
                    job()
                    dataVersion++
                    onChange?.invoke()
                } catch (e: Exception) {
                    changeIsFromSync = false
                    // Figma 1.5: Today reloads and says so in a snackbar above the day bar (S7).
                    problem = if (isTap) "Couldn’t save that tap. It’s undone." else "That change couldn't be saved, so it was undone. Please try again."
                    reloadWhenWritten = true
                }
                changeIsFromSync = false
                pendingWrites--
                if (reloadWhenWritten && pendingWrites == 0) {
                    reloadWhenWritten = false
                    load()
                }
            }
        }
    }

    /** Waits for every pending change to reach the database. */
    suspend fun flush() {
        while (pendingWrites > 0) delay(10)
    }

    /** Re-reads everything after sync merged other devices' changes, behind local changes, so none is lost or shown twice. */
    fun reloadAfterSync() = perform {
        // Reported as sync's own until the queue has told everyone (perform's onChange right after this job).
        changeIsFromSync = true
        load()
        if (pendingWrites > 1) reloadWhenWritten = true
    }

    private suspend fun saveSetting(key: String, value: String) {
        repository.saveSetting(key, value)
        settingRows[key] = value
    }

    private suspend fun removeSetting(key: String) {
        repository.removeSetting(key)
        settingRows.remove(key)
    }

    private suspend fun saveHabitRecord(habit: Habit, position: Int, deleted: Boolean = false) {
        repository.saveHabit(habit.record(position, deleted = deleted), if (deleted) emptyList() else habit.stepRecords(),
            if (deleted) emptyList() else habit.reminderRecords(), clock())
    }

    // ------------------------------------------------------------------ Habits

    /** The habit just added and when: Today says where it went and lights it briefly (Figma 1.6). */
    var justAdded by mutableStateOf<Pair<String, Long>?>(null)

    fun add(habit: Habit) = perform {
        if (habits.any { it.id == habit.id }) return@perform
        saveHabitRecord(habit, habits.size)
        habits = habits + habit
        rulesChanged()
        justAdded = habit.id to clock()
    }

    /** Saves an edited habit. If what judges a day changed, the rule it had is kept for every day before today. */
    fun update(habit: Habit) = perform {
        val i = habits.indexOfFirst { it.id == habit.id }
        if (i < 0) return@perform
        val old = habits[i]
        val yesterday = today() - 1
        val list = (goalRules[habit.id] ?: emptyList()).toMutableList()
        if (HabitRule.of(old, yesterday).judgesDifferently(habit) && rules.startDay(old) <= yesterday &&
            (list.lastOrNull()?.let { it.until < yesterday } != false)
        ) list.add(HabitRule.of(old, yesterday))
        saveHabitRecord(habit, i)
        if (list != (goalRules[habit.id] ?: emptyList<HabitRule>())) {
            saveSetting(Keys.RULES + habit.id, SwiftJson.rules(list))
            goalRules = goalRules + (habit.id to list)
        }
        // By ID, never the index found before the write: the order can change while the write waits (a reorder in
        // between put another habit at [i], and it was overwritten; found 18 Oct 2026 moving a habit in Arrange Today).
        habits = habits.map { if (it.id == habit.id) habit else it }
        rulesChanged()
    }

    /** Stops habits for good but keeps all their history. A running timer is saved first. */
    fun archive(list: List<Habit>) {
        for (h in list) if (timers.containsKey(h.id)) stopTimer(h, today())
        perform {
            val day = today()
            for (h in list) {
                val i = habits.indexOfFirst { it.id == h.id }
                if (i < 0 || habits[i].archived) continue
                val archived = habits[i].copy(archived = true)
                saveSetting(Keys.ARCHIVED + archived.id, dayKey(day))
                saveHabitRecord(archived, i)
                archivedOn = archivedOn + (archived.id to day)
                habits = habits.map { if (it.id == archived.id) archived else it }
            }
            rulesChanged()
        }
    }

    /**
     * A habit whose type changed starts over (Figma 6.3.1, 6.4.2; the user, 18 Oct 2026; no screen does it since A68,
     * 23 Oct, but habits started over before then keep their two linked pages): the old one is archived with
     * everything it had, and [fresh] (a new ID, so sync never merges the two) takes its place on Today from today. Old
     * logs can't be converted (glasses aren't minutes), so nothing is rewritten (D6); Restore brings the old one back.
     */
    fun startOver(old: Habit, fresh: Habit, asWhat: String? = null) {
        if (timers.containsKey(old.id)) stopTimer(old, today())
        // Archived habits says why this one is there: "Started over as Time it" (Habits, Figma 6.7).
        asWhat?.let { saveAppSetting(Keys.STARTED_OVER + old.id, it) }
        perform {
            val i = habits.indexOfFirst { it.id == old.id }
            if (i < 0 || habits.any { it.id == fresh.id }) return@perform
            val day = today()
            val archived = habits[i].copy(archived = true)
            saveSetting(Keys.ARCHIVED + archived.id, dayKey(day))
            // The two pages link to each other (Habit details, Figma 6.3, 6.4).
            saveSetting(Keys.REPLACED_BY + archived.id, fresh.id)
            archivedOn = archivedOn + (archived.id to day)
            val list = habits.toMutableList()
            list[i] = fresh
            list.add(archived)
            for (k in i until list.size) saveHabitRecord(list[k], k)
            habits = list
            rulesChanged()
        }
    }

    /** Brings an archived habit back if there's a free slot (or Plus). The archived stretch becomes a pause. */
    fun restore(habit: Habit): Boolean {
        if (habit.kind != HabitKind.Task && !canAddHabit) return false
        perform {
            val i = habits.indexOfFirst { it.id == habit.id }
            if (i < 0) return@perform
            val h = habits[i].copy(archived = false)
            val now = clock()
            val yesterday = today(now) - 1
            val list = (pauses[h.id] ?: emptyList()).toMutableList()
            val from = archivedOn[h.id]
            if (from != null && from <= yesterday) {
                list.add(HabitPause(from, yesterday, rules.dayStart(from), now))
                list.sortBy { it.from }
                saveSetting(Keys.PAUSE + h.id, SwiftJson.pauses(list))
            }
            removeSetting(Keys.ARCHIVED + h.id)
            saveHabitRecord(h, i)
            archivedOn = archivedOn - h.id
            pauses = if (list.isEmpty()) pauses - h.id else pauses + (h.id to list)
            habits = habits.map { if (it.id == h.id) h else it }
            rulesChanged()
        }
        return true
    }

    /** Deletes habits and their history; the row is kept as a tombstone so a sync can't bring it back. */
    fun delete(list: List<Habit>) {
        for (h in list) if (timers.containsKey(h.id)) stopTimer(h, today())
        perform {
            for (h in list) {
                val i = habits.indexOfFirst { it.id == h.id }
                if (i < 0) continue
                saveHabitRecord(habits[i], i, deleted = true)
                habits = habits.filter { it.id != h.id }
                for (e in entries(h.id).toList()) removeEntry(e.id)
                habitNotes = habitNotes - h.id
                descriptions = descriptions - h.id
                goalRules = goalRules - h.id
                pauses = pauses - h.id
                skips = skips - h.id
                if (afterLog?.habitId == h.id) afterLog = null
            }
            rulesChanged()
        }
    }

    /** Moves habit [id] to just after [afterId] in the person's order: a duplicate sits right after its habit (Habits, Figma 2.2). */
    fun placeAfter(id: String, afterId: String) = perform {
        // Queued behind the add that made [id]: until that write runs, the habit isn't in the list yet.
        val ids = habits.map { it.id }.filter { it != id }.toMutableList()
        val at = ids.indexOf(afterId)
        if (at < 0 || habits.none { it.id == id }) return@perform
        ids.add(at + 1, id)
        reorder(ids)
    }

    /** The habit that took [habitId]'s place when its type changed (Figma 6.4: Open the new Water), if it's still here. */
    fun replacedBy(habitId: String): Habit? = setting(Keys.REPLACED_BY + habitId)?.let { id -> habits.firstOrNull { it.id == id } }

    /** The archived habit [habitId] replaced when the type changed (Figma 6.3: Open earlier Water). */
    fun earlierOf(habitId: String): Habit? = habits.firstOrNull { it.archived && setting(Keys.REPLACED_BY + it.id) == habitId }

    /** What an archived habit started over as, if a type change archived it ("Time it"). */
    fun startedOverAs(habitId: String): String? = setting(Keys.STARTED_OVER + habitId)

    /** Puts [ids] (one card on Today, or one group) in this order, keeping every other habit where it is. */
    fun reorder(ids: List<String>) {
        val wanted = ids.toSet()
        val slots = habits.indices.filter { habits[it].id in wanted }
        val next = habits.toMutableList()
        for ((slot, id) in slots.zip(ids)) habits.firstOrNull { it.id == id }?.let { next[slot] = it }
        val moved = next.indices.filter { next[it].id != habits[it].id }.map { next[it].id }.toSet()
        if (moved.isEmpty()) return
        habits = next
        rulesChanged()
        perform {
            for ((i, h) in habits.withIndex()) if (h.id in moved) saveHabitRecord(h, i)
        }
    }

    // ------------------------------------------------------------------ Logging (memory first, S7)

    /** A tap's log: shown now, written next in the queue. */
    private fun addLogged(entry: Entry) {
        val habit = habit(entry.habitId)
        val wasComplete = habit?.let { rules.isComplete(it, entry.day) } ?: false
        val before = habit?.let { milestones.before(it, entry.day) }
        val wasMet = before != null && entry.stepId != null && rules.isDayMet(habit!!, entry.day)
        insertEntry(entry)
        offerUndo(entry)
        if (habit != null) {
            // A step adds to a checklist's total only by finishing its day.
            val added = if (entry.stepId == null) entry.value else if (!wasMet && rules.isDayMet(habit, entry.day)) 1.0 else 0.0
            milestones.after(before, habit, entry.source ?: EntrySource.TODAY, added)
            logFeedback(habit, entry.day, wasComplete)
        }
        perform(tap = true) { repository.addEntry(entry.record) }
    }

    /** Undoing a tap: gone from the screen now, the removal written next in the queue. */
    private fun removeLogged(id: String) {
        removeEntry(id) ?: return
        if ((afterLog as? AfterLog.Log)?.entry?.id == id) afterLog = null
        val at = clock()
        perform(tap = true) { repository.removeEntry(id, at) }
    }

    /** A log from Today (a tap, Add log, the timer) takes Undo · Note; one made elsewhere by the person ends it. */
    private fun offerUndo(entry: Entry) {
        when (entry.source) {
            EntrySource.TODAY, EntrySource.MANUAL, EntrySource.TIMER -> afterLog = AfterLog.Log(entry)
            EntrySource.DAY_SHEET, EntrySource.ROUTINE -> afterLog = null
            else -> {}
        }
    }

    /** Takes back what Undo · Note offers: the log, or the skip. */
    fun undo(offer: AfterLog) {
        when (offer) {
            is AfterLog.Log -> undoEntry(offer.entry.id)
            is AfterLog.Skip -> habit(offer.habitId)?.let { setSkipped(it, offer.day, false) }
        }
        if (afterLog == offer) afterLog = null
    }

    private fun logFeedback(habit: Habit, day: Int, wasComplete: Boolean, celebrated: Boolean = false) {
        onLog?.invoke(!rule(habit, day).isQuitOrLimit && !wasComplete && !celebrated && rules.isComplete(habit, day))
    }

    private fun log(habit: Habit, value: Double, day: Int, time: Long? = null, source: EntrySource) =
        addLogged(Entry(habitId = habit.id, day = day, value = value, createdAt = stamp(time, day), source = source))

    /** ✓: a once-a-day tick toggles; a week, month or year count only ever adds one. */
    fun toggleCheck(habit: Habit, day: Int, source: EntrySource = EntrySource.TODAY) {
        if (habit.kind == HabitKind.Task) return toggleTask(habit, day, source)
        if (!rule(habit, day).frequency.isDayBased) return addProgress(habit, 1.0, day, source = source)
        if (isTicked(habit, day)) undoLast(habit, day) else log(habit, 1.0, day, source = source)
    }

    private fun toggleTask(habit: Habit, day: Int, source: EntrySource) {
        val last = entries(habit.id).lastOrNull { habit.dueDay != null || it.day == day }
        if (last != null) removeLogged(last.id) else log(habit, 1.0, day, source = source)
    }

    /** + : adds the saved step; never takes back (Undo does). */
    fun increment(habit: Habit, day: Int, source: EntrySource = EntrySource.TODAY) {
        val value = habit.quickIncrement ?: return
        addProgress(habit, value, day, source = source)
    }

    /** [time]: when it happened, for a log added by hand, kept inside [day] and never later than now. */
    fun addProgress(habit: Habit, value: Double, day: Int, time: Long? = null, source: EntrySource = EntrySource.TODAY) {
        if (!value.isFinite() || value <= 0 || value > GOAL_MAXIMUM || day > today()) return
        log(habit, value, day, time, source)
    }

    fun toggleSlot(habit: Habit, slot: String, day: Int, source: EntrySource = EntrySource.TODAY) {
        val last = entries(habit.id, day).lastOrNull { it.slot == slot }
        if (last != null) removeLogged(last.id) else addLogged(Entry(habitId = habit.id, day = day, value = 1.0, slot = slot, source = source))
    }

    fun toggleStep(step: Step, habit: Habit, day: Int, time: Long? = null, source: EntrySource = EntrySource.TODAY) {
        val last = entries(habit.id, day).lastOrNull { it.stepId == step.id }
        if (last != null) removeLogged(last.id)
        else addLogged(Entry(habitId = habit.id, stepId = step.id, day = day, value = 1.0, createdAt = stamp(time, day), source = source))
    }

    /**
     * LOCKED (widget taps, 8 Oct 2026; Android): saves one widget tap, idempotently, so a tap saved twice counts once
     * (W4). A ✓ is saved as the state it set ([kind] "check" or "uncheck"), never a flip; a + by the tap's own ID; ▶/⏸
     * as the state it set.
     */
    fun saveWidgetTap(habitId: String, day: Int, kind: String, id: String, at: Long) {
        val habit = habit(habitId)?.takeIf { !it.archived } ?: return
        if (day > today()) return
        val source = EntrySource.WIDGET
        when (kind) {
            "check" -> if (!isTicked(habit, day)) {
                if (habit.kind == HabitKind.Task || rule(habit, day).frequency.isDayBased)
                    addLogged(Entry(id = id, habitId = habit.id, day = day, value = 1.0, createdAt = stamp(at, day), source = source))
            }
            "uncheck" -> if (isTicked(habit, day)) {
                if (habit.kind == HabitKind.Task) toggleTask(habit, day, source) else undoLast(habit, day)
            }
            "add" -> if (entries(habit.id).none { it.id == id }) {
                val slots = rules.placements(habit).mapNotNull { it.slot }
                val open = slots.firstOrNull { !isSlotDone(habit, it, day) }
                val value = if (habit.kind == HabitKind.Check) 1.0 else habit.quickIncrement ?: return
                if (slots.isNotEmpty() && habit.kind == HabitKind.Check) {
                    if (open != null) addLogged(Entry(id = id, habitId = habit.id, day = day, value = 1.0, slot = open, createdAt = stamp(at, day), source = source))
                } else if (value.isFinite() && value > 0) {
                    addLogged(Entry(id = id, habitId = habit.id, day = day, value = value, createdAt = stamp(at, day), source = source))
                }
            }
            "start" -> if (!timers.containsKey(habit.id)) toggleTimer(habit)
            "stop" -> if (timers.containsKey(habit.id)) stopTimer(habit, today(), source = source)
        }
    }

    fun isStepDone(step: Step, habit: Habit, day: Int) = entries(habit.id, day).any { it.stepId == step.id }
    fun isSlotDone(habit: Habit, slot: String, day: Int) = entries(habit.id, day).any { it.slot == slot }

    /** Takes back exactly this log. */
    fun undoEntry(id: String) = removeLogged(id)

    /** Undo the latest log on this day; for week and month rules, the latest in the period. */
    fun undoLast(habit: Habit, day: Int) {
        val range = if (habit.frequency.isFlexible) day..day else (rules.periodRange(habit, day) ?: day..day)
        val last = entries(habit.id).lastOrNull { it.stepId == null && it.day in range } ?: return
        removeLogged(last.id)
    }

    /** Explicit done / not done for a day's checks. Never touches another day's logs. */
    fun setDayDone(done: Boolean, habit: Habit, day: Int, time: Long? = null, source: EntrySource = EntrySource.DAY_SHEET) {
        if (day > today()) return
        val r = rule(habit, day)
        if (!done) {
            val ids = if (r.kind == HabitKind.Task && r.dueDay != null) entries(habit.id).map { it.id } else entries(habit.id, day).map { it.id }
            ids.forEach(::undoEntry)
        } else if (r.kind == HabitKind.Check) {
            val missing = maxOf(0.0, rules.dayGoal(r) - rules.dayProgress(r, day))
            if (missing > 0) log(habit, missing, day, time, source)
        } else if (r.kind == HabitKind.Task && !rules.isDone(r, day)) {
            log(habit, 1.0, day, time, source)
        }
    }

    /** A slip, at the moment it happened. */
    fun slip(habit: Habit, day: Int, at: Long, source: EntrySource = EntrySource.TODAY): String? {
        if (habit.kind != HabitKind.Quit || day > today() || at !in rules.dayBounds(day) || at > clock() ||
            at < minOf(habit.quitSince ?: habit.createdAt, habit.createdAt)
        ) return null
        val entry = Entry(habitId = habit.id, day = day, value = 1.0, createdAt = at, source = source)
        addLogged(entry)
        return entry.id
    }

    /** Correct one log's value and time, within its own tracked day; never another day, never later than now. */
    fun editEntry(id: String, value: Double, at: Long? = null) {
        if (!value.isFinite() || value <= 0 || value > GOAL_MAXIMUM) return
        val entry = entries.firstOrNull { it.id == id } ?: return
        val habit = habit(entry.habitId) ?: return
        val kind = rule(habit, entry.day).kind
        if (entry.day > today() || entry.stepId != null || kind == HabitKind.Task) return
        if (kind == HabitKind.Check && Math.rint(value) != value) return
        val wasComplete = rules.isComplete(habit, entry.day)
        val before = milestones.before(habit, entry.day)
        var updated = entry.copy(value = value)
        if (at != null && at != entry.createdAt) {
            if (at !in rules.dayBounds(entry.day, entry.timeZone) || at > maxOf(clock(), entry.createdAt)) return
            if (kind == HabitKind.Quit && at < minOf(habit.quitSince ?: habit.createdAt, habit.createdAt)) return
            updated = updated.copy(createdAt = at)
        }
        replaceEntry(updated)
        milestones.after(before, habit, EntrySource.MANUAL, value - entry.value)
        logFeedback(habit, entry.day, wasComplete)
        perform { repository.editEntry(updated.id, updated.value, updated.createdAt) }
    }

    /** A day's logs (no checklist steps), newest first by their time. */
    fun dayLogs(habit: Habit, day: Int): List<Entry> {
        val list = entries(habit.id, day)
        return list.indices.filter { list[it].stepId == null }
            .sortedWith(compareByDescending<Int> { list[it].createdAt }.thenByDescending { it }).map { list[it] }
    }

    /** When a new log of [day] happened: the chosen time inside that day; with none, now for today, and the same clock
     *  time on an earlier day. */
    fun stamp(time: Long?, day: Int): Long {
        if (time != null) return logTime(time, day)
        return if (day == today()) clock() else sameClockTime(clock(), day)
    }

    /** [time] kept inside [day]'s bounds and never later than now; the day itself never changes (D7, U19). */
    fun logTime(time: Long, day: Int, zone: String? = null): Long {
        val bounds = rules.dayBounds(day, zone)
        val upper = maxOf(bounds.first, minOf(bounds.last, clock()))
        return minOf(maxOf(time, bounds.first), upper)
    }

    /** [time]'s clock time on [day], inside that day (the wall clock, never adding hours, D7). */
    fun sameClockTime(time: Long, day: Int): Long {
        val zone = ZoneId.systemDefault()
        val clockTime = Instant.ofEpochMilli(time).atZone(zone).toLocalTime()
        val date = LocalDate.ofEpochDay(day.toLong())
        var moment = date.atTime(clockTime).atZone(zone).toInstant().toEpochMilli()
        if (moment < rules.dayBounds(day).first) moment = date.plusDays(1).atTime(clockTime).atZone(zone).toInstant().toEpochMilli()
        return logTime(moment, day)
    }

    // ------------------------------------------------------------------ Timers

    /** Start the timer, or stop it and log the minutes. A running timer is saved, so it survives the app being closed. */
    fun toggleTimer(habit: Habit, slot: String? = null) {
        val now = clock()
        if (timers.containsKey(habit.id)) return stopTimer(habit, today(now), now)
        milestones.timerStarted(habit)
        timers = timers + (habit.id to now)
        // ▶ is the next thing done: the buttons under the last log go (a timer's own come when it stops, Figma 1.2).
        afterLog = null
        timerSlots = if (slot != null) timerSlots + (habit.id to slot) else timerSlots - habit.id
        settingRows[Keys.TIMER + habit.id] = now.toString() + (slot?.let { "|$it" } ?: "")
        rulesChanged()
        val value = now.toString() + (slot?.let { "|$it" } ?: "")
        perform { saveSetting(Keys.TIMER + habit.id, value) }
    }

    /** Stopping never loses time: the log's ID comes from the habit and the start, so a second stop is the same log. */
    fun stopTimer(habit: Habit, day: Int, end: Long = clock(), source: EntrySource = EntrySource.TIMER) {
        val start = timers[habit.id] ?: return
        val minutes = maxOf(0L, end - start) / 60_000.0
        val before = milestones.before(habit, day)
        val entry = if (minutes >= 1.0 / 60) Entry(
            id = TimerStop.entryId(habit.id, start), habitId = habit.id, day = day, value = minutes,
            slot = timerSlots[habit.id], source = source,
        ) else null
        timers = timers - habit.id
        timerSlots = timerSlots - habit.id
        settingRows.remove(Keys.TIMER + habit.id)
        rulesChanged()
        val wasComplete = rules.isComplete(habit, day)
        if (entry != null) { insertEntry(entry); offerUndo(entry) }
        milestones.after(before, habit, source, entry?.value ?: 0.0)
        milestones.timerStopped(habit.id)
        logFeedback(habit, day, wasComplete)
        val key = Keys.TIMER + habit.id
        perform { repository.finishTimer(entry?.record, key) }
    }

    // ------------------------------------------------------------------ Skips, moves and pauses

    fun isSkipped(habit: Habit, day: Int) = skips[habit.id]?.contains(day) == true
    fun isPaused(habit: Habit, day: Int) = pauses[habit.id]?.any { day in it } == true

    /** [offer]: skipped from Today (a swipe or the row's menu), so the row offers Undo · Note (Figma 7.10). */
    fun setSkipped(habit: Habit, day: Int, skipped: Boolean, offer: Boolean = false) {
        if (skipped && !rules.canSkip(rule(habit, day))) return
        val days = (skips[habit.id] ?: emptySet()).toMutableSet()
        if (skipped) days.add(day) else days.remove(day)
        // A running timer's day skipped: the timer is stopped and saved first (Current Work 94: "Stop and save" stayed on).
        if (skipped && timers.containsKey(habit.id) && day == today()) stopTimer(habit, day)
        skips = if (days.isEmpty()) skips - habit.id else skips + (habit.id to days)
        if (skipped && offer) afterLog = AfterLog.Skip(habit.id, day)
        else if (!skipped && (afterLog as? AfterLog.Skip)?.let { it.habitId == habit.id && it.day == day } == true) afterLog = null
        val value = days.map(::dayKey).sorted().joinToString(",")
        settingRows[Keys.SKIP + habit.id] = value
        rulesChanged()
        perform { saveSetting(Keys.SKIP + habit.id, value) }
    }

    /** The pause covering [day], or the next one still to come. */
    fun pause(habit: Habit, day: Int): HabitPause? {
        val list = pauses[habit.id] ?: emptyList()
        return list.firstOrNull { day in it } ?: list.filter { it.from > day }.minByOrNull { it.from }
    }

    /** Pauses from [from] through [through] (null: until turned back on). A quit habit pauses now. */
    fun pause(habit: Habit, from: Int, through: Int?, now: Long = clock()) {
        val today = today(now)
        val start = if (habit.kind == HabitKind.Quit) today else from
        val list = (pauses[habit.id] ?: emptyList()).filter { it.from <= today }.map { p ->
            if (p.through == null || p.through >= start) p.copy(through = start - 1) else p
        }.filterNot { p -> habit.kind != HabitKind.Quit && p.through != null && p.through < p.from }.toMutableList()
        list.add(HabitPause(start, through, now))
        if (timers.containsKey(habit.id) && start <= today) stopTimer(habit, today)
        savePauses(list, habit)
    }

    /** Turns the habit back on today. */
    fun resume(habit: Habit, now: Long = clock()) {
        val today = today(now)
        val list = (pauses[habit.id] ?: emptyList()).filter { it.from <= today }.map { p ->
            if (today in p) p.copy(through = today - 1, resumedAt = now) else p
        }.filterNot { p -> habit.kind != HabitKind.Quit && p.through != null && p.through < p.from }
        savePauses(list, habit)
    }

    /** Puts a habit's pauses back exactly as they were: the Undo of a pause or a resume (Habits, Figma 2.3.1, 2.4.1). */
    fun setPauses(habit: Habit, list: List<HabitPause>) = savePauses(list, habit)

    private fun savePauses(list: List<HabitPause>, habit: Habit) = perform {
        if (list.isEmpty()) removeSetting(Keys.PAUSE + habit.id) else saveSetting(Keys.PAUSE + habit.id, SwiftJson.pauses(list))
        pauses = if (list.isEmpty()) pauses - habit.id else pauses + (habit.id to list)
        rulesChanged()
    }

    /** The repeating task's next scheduled day after [day], by its own schedule. Called on a tap, never while drawing. */
    fun nextOccurrence(habit: Habit, after: Int): Int? {
        for (d in after + 1..after + 366) if (rules.isDue(habit, d, countingSkips = false, followingMoves = false)) return d
        return null
    }

    fun canReschedule(habit: Habit, shownOn: Int): Boolean {
        if (habit.kind != HabitKind.Task || habit.archived || rules.isDone(habit, shownOn)) return false
        if (habit.dueDay != null) return true
        val today = today()
        return shownOn == today && !rules.isDue(habit, today + 1, countingSkips = false, followingMoves = false)
    }

    fun rescheduleRange(habit: Habit, shownOn: Int): IntRange? {
        if (!canReschedule(habit, shownOn)) return null
        val today = today()
        if (habit.dueDay != null) return today..today + 3650
        val last = nextOccurrence(habit, today)?.let { it - 1 } ?: habit.endsOn ?: (today + 365)
        return if (today + 1 <= last) (today + 1)..last else null
    }

    /** Moves a one-time task to another day, or one occurrence of a repeating task. */
    fun reschedule(habit: Habit, shownOn: Int, target: Int) {
        val range = rescheduleRange(habit, shownOn) ?: return
        if (target !in range) return
        if (habit.dueDay != null) {
            update(habit.copy(dueDay = target))
            justMoved = Moved(habit.id, target, clock()) { update(habit) }
            return
        }
        val before = taskMoves[habit.id] ?: emptyMap()
        val moves = before.toMutableMap()
        val original = moves.entries.firstOrNull { it.value == shownOn }?.key ?: shownOn
        if (original == target) moves.remove(original) else moves[original] = target
        setMoves(habit.id, moves)
        justMoved = Moved(habit.id, target, clock()) { setMoves(habit.id, before) }
    }

    // ------------------------------------------------------------------ The Tasks page (Figma 2373:2)

    /** A one-time task to another day, or to No date ([day] null). The task keeps its ID and history; Undo is [update] with the old one. */
    fun moveTask(task: Habit, day: Int?) {
        if (!task.isOneTimeTask) return
        update(task.copy(dueDay = day ?: NO_DATE_DAY))
    }

    /** One occurrence of a repeating task, from [from] to [to] (before its next one); the schedule stays as it is. */
    fun moveOccurrence(task: Habit, from: Int, to: Int) {
        if (!task.isRepeatingTask) return
        val moves = (taskMoves[task.id] ?: emptyMap()).toMutableMap()
        val original = moves.entries.firstOrNull { it.value == from }?.key ?: from
        if (original == to) moves.remove(original) else moves[original] = to
        setMoves(task.id, moves)
    }

    /** Puts a repeating task's moved days back as they were (the Undo of [moveOccurrence]). */
    fun setTaskMoves(task: Habit, moves: Map<Int, Int>) = setMoves(task.id, moves)

    /** A log taken back on the Tasks page (Mark as not done) put back by its Undo, as a new log with the same day, time and value. */
    fun putBack(entry: Entry) = addLogged(entry.copy(id = newId(), source = EntrySource.DAY_SHEET))

    private fun setMoves(habitId: String, moves: Map<Int, Int>) {
        taskMoves = if (moves.isEmpty()) taskMoves - habitId else taskMoves + (habitId to moves)
        val value = moves.map { dayKey(it.key) + ">" + dayKey(it.value) }.sorted().joinToString(",")
        settingRows[Keys.MOVE + habitId] = value
        rulesChanged()
        perform { saveSetting(Keys.MOVE + habitId, value) }
    }

    /** A task just moved to another day from Day details: Today says where it went, with Undo (as Arrange's "moved to"). */
    class Moved(val habitId: String, val to: Int, val at: Long, val undo: () -> Unit)
    var justMoved by mutableStateOf<Moved?>(null)

    // ------------------------------------------------------------------ Notes

    fun note(habit: Habit, day: Int): String? = habitNotes[habit.id]?.get(day)
    fun hasNotes(habit: Habit) = habitNotes[habit.id]?.isNotEmpty() == true
    /** Every note on a habit, newest first. */
    fun notes(habit: Habit): List<Pair<Int, String>> = (habitNotes[habit.id] ?: emptyMap()).entries.sortedByDescending { it.key }.map { it.key to it.value }
    fun dayNote(day: Int): String? = dayNotes[day]

    /** Empty text removes the note (kept as an empty value, so an older backup can't bring it back). */
    fun setNote(text: String, habit: Habit, day: Int) {
        val clean = TextLimit.clean(text, TextLimit.NOTE)
        perform {
            saveSetting(Keys.NOTE + habit.id + "|" + dayKey(day), clean)
            val days = (habitNotes[habit.id] ?: emptyMap()).toMutableMap()
            if (clean.isEmpty()) days.remove(day) else days[day] = clean
            habitNotes = habitNotes + (habit.id to days)
            changed(habit.id)
        }
    }

    fun setDayNote(text: String, day: Int) {
        val clean = TextLimit.clean(text, TextLimit.NOTE)
        perform {
            saveSetting(Keys.DAY_NOTE + dayKey(day), clean)
            dayNotes = if (clean.isEmpty()) dayNotes - day else dayNotes + (day to clean)
        }
    }

    fun setDescription(text: String, habitId: String) {
        val clean = TextLimit.clean(text, TextLimit.DESCRIPTION)
        if (clean == (descriptions[habitId] ?: "")) return
        perform {
            saveSetting(Keys.DESCRIPTION + habitId, clean)
            descriptions = if (clean.isEmpty()) descriptions - habitId else descriptions + (habitId to clean)
        }
    }

    // ------------------------------------------------------------------ Day and week, times of day, Today's cards

    /** The hour a new day starts, 0 (12:00 AM) to 12. Logs already saved keep their day. */
    fun setDayEnd(hour: Int) {
        val h = hour.coerceIn(0, 12)
        if (h == dayEndHour) return
        dayEndHour = h
        if (h == 0) settingRows.remove(Keys.DAY_END) else settingRows[Keys.DAY_END] = h.toString()
        rulesChanged()
        perform { if (h == 0) removeSetting(Keys.DAY_END) else saveSetting(Keys.DAY_END, h.toString()) }
    }

    /** The first day of the week, 1 = Sunday … 7 = Saturday. */
    fun chooseWeekStart(day: Int) {
        val d = day.coerceIn(1, 7)
        if (d == weekStart && settingRows.containsKey(Keys.WEEK_START)) return
        weekStart = d
        settingRows[Keys.WEEK_START] = d.toString()
        rulesChanged()
        perform { saveSetting(Keys.WEEK_START, d.toString()) }
    }

    /** Saves the whole list; habits in a removed time of day move to Anytime. */
    fun saveSections(list: List<DaySection>) {
        val sorted = listOf(list.firstOrNull { it.isAnytime } ?: DaySection.defaults[0]) + list.filter { !it.isAnytime }.sortedBy { it.start }
        val cleaned = sorted.mapIndexed { i, s -> if (i < sorted.size - 1) s.copy(end = null) else s }.toMutableList()
        val last = cleaned.lastIndex
        if (!cleaned[last].isAnytime && cleaned[last].end == null) cleaned[last] = cleaned[last].copy(end = 24 * 60)
        val removed = sections.map { it.id }.toSet() - cleaned.map { it.id }.toSet()
        perform {
            saveSetting(Keys.SECTIONS, SwiftJson.sections(cleaned))
            val next = habits.toMutableList()
            for ((i, h) in next.withIndex()) {
                if (h.parts.none { it in removed }) continue
                val kept = h.parts.filter { it !in removed }
                next[i] = h.copy(parts = kept.ifEmpty { listOf(DaySection.ANYTIME) })
                saveHabitRecord(next[i], i)
            }
            habits = next
            sections = cleaned
            rulesChanged()
        }
    }

    /** What Undo puts back after a time of day is deleted: the list as it was, and each moved habit's places then and now. */
    class SectionUndo(val sections: List<DaySection>, val parts: Map<String, Pair<List<String>, List<String>>>)

    /** Deletes a time of day (its habits move to Anytime, [saveSections]) and returns what its Undo needs. */
    fun deleteSection(id: String): SectionUndo {
        val moved = habits.filter { id in it.parts }.associate { h -> h.id to (h.parts to h.parts.filter { it != id }.ifEmpty { listOf(DaySection.ANYTIME) }) }
        val undo = SectionUndo(sections, moved)
        saveSections(sections.filter { it.id != id })
        return undo
    }

    /**
     * Times of day's Undo (Figma: "Undo brings Morning back with its habits"): the times of day as they were, and each
     * habit the delete moved back where it was, found by ID when the write runs (S7). A habit changed in between keeps
     * what it has now.
     */
    fun undoSectionDelete(undo: SectionUndo) {
        saveSections(undo.sections)
        perform {
            val next = habits.toMutableList()
            for ((i, h) in next.withIndex()) {
                val (was, after) = undo.parts[h.id] ?: continue
                if (h.parts != after) continue
                next[i] = h.copy(parts = was)
                saveHabitRecord(next[i], i)
            }
            habits = next
            rulesChanged()
        }
    }

    enum class CardMove { UP, DOWN, TOP, BOTTOM }

    /** Moves Anytime or Quit or cut down among the cards; the times of day keep their time order around it. */
    fun moveCard(id: String, move: CardMove) {
        if (id != DaySection.ANYTIME && id != DaySection.QUITTING) return
        val cards = todayCards().toMutableList()
        val from = cards.indexOf(id)
        if (from < 0) return
        val to = when (move) { CardMove.UP -> maxOf(0, from - 1); CardMove.DOWN -> minOf(cards.size - 1, from + 1); CardMove.TOP -> 0; CardMove.BOTTOM -> cards.size - 1 }
        if (to == from) return
        cards.removeAt(from)
        cards.add(to, id)
        perform {
            saveSetting(Keys.CARD_ORDER, SwiftJson.strings(cards))
            cardOrder = cards
            rulesChanged()
        }
    }

    // ------------------------------------------------------------------ Groups

    fun saveGroup(group: HabitGroup) {
        val g = group.copy(name = TextLimit.clean(group.name, TextLimit.GROUP))
        if (g.name.isEmpty()) return
        perform {
            val members = g.habits.toSet()
            val list = groups.map { if (it.id != g.id) it.copy(habits = it.habits.filter { h -> h !in members }) else it }.toMutableList()
            val i = list.indexOfFirst { it.id == g.id }
            if (i >= 0) list[i] = g else list.add(g)
            storeGroups(list, groupsManual)
        }
    }

    fun deleteGroup(id: String) = perform { storeGroups(groups.filter { it.id != id }, groupsManual) }

    fun setGroup(groupId: String?, habitId: String) = perform {
        val list = groups.map { g ->
            val without = g.habits.filter { it != habitId }
            g.copy(habits = if (g.id == groupId) without + habitId else without)
        }
        storeGroups(list, groupsManual)
    }

    fun groupOf(habitId: String): HabitGroup? = groups.firstOrNull { habitId in it.habits }

    private suspend fun storeGroups(list: List<HabitGroup>, manual: Boolean) {
        val seen = HashSet<String>()
        val cleaned = list.map { g -> g.copy(habits = g.habits.filter { seen.add(it) }) }.let { if (manual) it else it.sortedBy { g -> g.name.lowercase() } }
        if (cleaned.isEmpty()) removeSetting(Keys.GROUPS) else saveSetting(Keys.GROUPS, SwiftJson.groups(cleaned))
        if (manual) saveSetting(Keys.GROUPS_ORDER, "manual") else removeSetting(Keys.GROUPS_ORDER)
        groups = cleaned
        groupsManual = manual
    }

    // ------------------------------------------------------------------ Settings the app keeps on the phone

    /** Any other saved setting (Appearance's choices and the like), as text. */
    fun setting(key: String): String? = settingRows[key]

    fun saveAppSetting(key: String, value: String?) {
        if (value == null) settingRows.remove(key) else settingRows[key] = value
        perform { if (value == null) removeSetting(key) else saveSetting(key, value) }
    }

    /** "Erase all my data": every row, deletion markers and sync state included. Not undoable. */
    suspend fun eraseEverything() {
        flush()
        repository.eraseAllData()
        load()
    }

    val repo: HabitRepository get() = repository

    object Keys {
        const val DAY_END = "day_end_hour"
        const val WEEK_START = "week_start"
        const val TIMER = "timer."
        const val SKIP = "skip."
        const val MOVE = "move."
        const val PAUSE = "pause."
        const val STARTED_OVER = "startedover."
        const val REPLACED_BY = "replacedby."
        const val RULES = "rules."
        const val NOTE = "note."
        const val DAY_NOTE = "daynote."
        const val DESCRIPTION = "desc."
        const val ARCHIVED = "archived."
        const val COST = "cost."
        const val GROUPS = "groups"
        const val GROUPS_ORDER = "groups_order"
        const val SECTIONS = "day_sections"
        const val CARD_ORDER = "today_order"
    }

    companion object {
        const val FREE_HABIT_LIMIT = 5
        private val RULE_PREFIXES = listOf(Keys.ARCHIVED, Keys.RULES, Keys.PAUSE, Keys.MOVE, Keys.SKIP, Keys.TIMER)

        /** The phone's own week start, used nowhere by default (Sunday is the default: Current Work 99). */
        fun regionWeekStart(): Int = WeekFields.of(Locale.getDefault()).firstDayOfWeek.value % 7 + 1
    }
}

/** What Undo · Note on Today offers (Figma 1.2, 7.10): the last log made from Today, or a skip. */
sealed class AfterLog {
    abstract val habitId: String
    abstract val day: Int

    data class Log(val entry: Entry) : AfterLog() {
        override val habitId: String get() = entry.habitId
        override val day: Int get() = entry.day
    }

    data class Skip(override val habitId: String, override val day: Int) : AfterLog()
}
