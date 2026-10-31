package com.oftenenough.app.data

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateMapOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import kotlin.math.max

/** In a row, in total, or an anniversary (Figma *Milestones: one simple rule*, `2266:2`). */
enum class MilestoneTrack { IN_A_ROW, IN_TOTAL, ANNIVERSARY }

/** What a milestone gets, biggest first: a pop-up, the bar, or just the row (card 4). */
enum class MilestoneTier { POPUP, BAR, ROW }

/** How it came: logged in the app; logged away (a widget, a reminder, a shortcut); or judged at a day's end (quit, cut down). */
enum class MilestoneCause { TAP, AWAY, YESTERDAY }

/** Which screen is in front and takes the milestones logged there (Today, a habit's Day details, the routine player). */
sealed class MilestoneFront {
    data object Today : MilestoneFront()
    data class Sheet(val habitId: String) : MilestoneFront()
    data class Player(val habitIds: Set<String>) : MilestoneFront()
}

/** A milestone just reached by a log made in the app, waiting for the screen in front to show it. */
data class MilestoneHit(
    val habitId: String, val day: Int, val track: MilestoneTrack, val value: Double,
    val wanted: MilestoneTier, val again: Boolean, val couldBeFirst: Boolean, val cause: MilestoneCause,
)

/**
 * Today's milestone of one habit, as shown (presentation only, kept on this phone for the day, never habit data): one a
 * habit a day, so one undone and done again never shows twice. [see]: a band that offers See (a pop-up's, reached away).
 * [played]: its row has played it once.
 */
data class MilestoneShown(
    val habitId: String, val day: Int, val track: MilestoneTrack, val value: Double, val tier: MilestoneTier,
    val again: Boolean, val first: Boolean, val cause: MilestoneCause, val see: Boolean, val played: Boolean,
) {
    fun encode() = listOf(habitId, day, track.name, value, tier.name, again, first, cause.name, see, played).joinToString("|")

    companion object {
        fun decode(line: String): MilestoneShown? = runCatching {
            val p = line.split("|")
            MilestoneShown(p[0], p[1].toInt(), MilestoneTrack.valueOf(p[2]), p[3].toDouble(), MilestoneTier.valueOf(p[4]),
                p[5].toBoolean(), p[6].toBoolean(), MilestoneCause.valueOf(p[7]), p[8].toBoolean(), p[9].toBoolean())
        }.getOrNull()
    }
}

/** A milestone in words: the medal's number, the title, the row's band, and the pop-up's lines. */
class MilestoneWords(
    val number: String, val title: String, val band: String, val popupTitle: String, val popupSubtitle: String,
    /** The next milestone of the same track: its number, its title, "Next · 30 to go · now 30", and how far (0–1). */
    val next: MilestoneAhead?, val spoken: String, val second: String,
)

class MilestoneAhead(val number: String, val title: String, val detail: String, val fraction: Float)

/**
 * The milestones (Rulebook D6: worked out from the records, never stored; Android/Docs/Milestones, decided 17 Oct 2026).
 *
 * - **Found at the log that reaches one** ([before] … [after]): in a row (the streak rising onto a length on its bucket's
 *   list, or back to a best of 14 or more), in total (the goal for one period × the list's multiple), an anniversary.
 *   One per habit per day: the biggest, in a row first. History added later, an import or a restore never gets one: only
 *   a log made today does.
 * - **Shown at once, first come first served** ([claim]): a pop-up for a landmark, a bar for any other first, the row for
 *   a number reached before; then the day's limits, every time: 1 pop-up a day (2 in any 7 days), 2 bars, 2 big moments
 *   in all. The rest is just the row. Day details and the routine player have no bar: their own ribbon.
 * - **Away** (a widget, a reminder, a shortcut) and **the day's end** (quit, cut down): just the row's band, played once
 *   when the row is first seen; a pop-up's has See.
 */
class MilestoneCenter(private val store: HabitStore) {
    /** Where today's records are kept: this phone's own settings (a test launch's are its own, D8). */
    interface Memory { fun read(): String; fun write(text: String) }
    var memory: Memory? = null

    var front by mutableStateOf<MilestoneFront>(MilestoneFront.Today)
    /** The habit whose bar is up on Today: its row keeps its own line until the bar goes, then shows the band (V3.4). */
    var barHabit by mutableStateOf<String?>(null)
    /** Milestones logged in the app, waiting for the screen in front. */
    val pending = mutableStateListOf<MilestoneHit>()
    private val shown = mutableStateMapOf<String, MilestoneShown>()
    private var loadedFor = Int.MIN_VALUE
    private var popupDays = listOf<Int>()
    private var againDays = mapOf<String, Int>()
    private var firstDone = false
    /** Milestones opened from their notification ("habitId:length"): the day's end doesn't show them again. */
    private var notified = mapOf<String, Int>()
    /** The state just before a running timer started: the clock crossing the goal is its milestone (Figma R.6). */
    private val timerBefore = HashMap<String, Before>()

    // ------------------------------------------------------------------ What's kept

    private fun ensureDay() {
        val today = store.today()
        if (loadedFor == today) return
        loadedFor = today
        shown.clear()
        pending.removeAll { it.day != today }
        val lines = memory?.read().orEmpty().lines()
        val head = lines.firstOrNull().orEmpty().split("|")
        firstDone = head.getOrNull(0) == "1"
        popupDays = head.getOrNull(1).orEmpty().split(",").mapNotNull { it.toIntOrNull() }.filter { it > today - 7 }
        againDays = head.getOrNull(2).orEmpty().split(",").mapNotNull { pair ->
            pair.split(":").takeIf { it.size == 2 }?.let { (id, d) -> d.toIntOrNull()?.let { id to it } }
        }.filter { it.second > today - 30 }.toMap()
        notified = head.getOrNull(3).orEmpty().split(",").mapNotNull { pair ->
            pair.split("@").takeIf { it.size == 2 }?.let { (k, d) -> d.toIntOrNull()?.let { k to it } }
        }.filter { it.second > today - 3 }.toMap()
        for (line in lines.drop(1)) MilestoneShown.decode(line)?.takeIf { it.day == today }?.let { shown[it.habitId] = it }
    }

    private fun save() {
        val head = listOf(if (firstDone) "1" else "0", popupDays.joinToString(","), againDays.entries.joinToString(",") { "${it.key}:${it.value}" },
            notified.entries.joinToString(",") { "${it.key}@${it.value}" })
        memory?.write((listOf(head.joinToString("|")) + shown.values.map { it.encode() }).joinToString("\n"))
    }

    /** The habit's milestone today, as shown, even if an undo has taken it back for now. */
    fun shown(habitId: String): MilestoneShown? { ensureDay(); return shown[habitId] }

    /** The habit's milestone today while it still stands (an undo hides it; done again, it's back, quietly). */
    fun visible(habit: Habit): MilestoneShown? = shown(habit.id)?.takeIf { stillReached(habit, it) }

    fun markPlayed(habitId: String) {
        ensureDay()
        val s = shown[habitId] ?: return
        if (s.played) return
        shown[habitId] = s.copy(played = true)
        save()
    }

    private fun record(s: MilestoneShown) {
        shown[s.habitId] = s
        if (s.tier == MilestoneTier.POPUP && s.day !in popupDays) popupDays = popupDays + s.day
        if (s.again) againDays = againDays + (s.habitId to s.day)
        save()
    }

    /**
     * A test launch's `moments=used` (D8; Figma's "after today's pop-up and bar are used up"): today's pop-up and two bars
     * count as shown, under IDs no habit has, so the next milestone today gets just the row.
     */
    fun useUpToday() {
        ensureDay()
        val today = store.today()
        for ((id, tier) in listOf("test-popup" to MilestoneTier.POPUP, "test-bar" to MilestoneTier.BAR))
            record(MilestoneShown(id, today, MilestoneTrack.IN_A_ROW, 7.0, tier, false, false, MilestoneCause.TAP, false, true))
    }

    /** A habit's records go with it (deleted, or every habit erased). */
    fun forget(habitId: String) {
        ensureDay()
        if (shown.remove(habitId) != null) save()
        pending.removeAll { it.habitId == habitId }
    }

    // ------------------------------------------------------------------ Found at a log

    class Before(val habitId: String, val day: Int, val streak: Int)

    private fun eligible(habit: Habit, day: Int): Boolean {
        if (day != store.today() || habit.archived) return false
        val r = store.rule(habit, day)
        return r.kind != HabitKind.Task && r.kind != HabitKind.Quit && !r.atMost && !store.isPaused(habit, day)
    }

    /** Just before a log of [habit] on [day]: where its streak stands. Null when no milestone can come of it. */
    fun before(habit: Habit, day: Int): Before? {
        if (!eligible(habit, day)) return null
        timerBefore[habit.id]?.let { if (it.day == day) return it }
        return Before(habit.id, day, store.streak(habit, day))
    }

    fun timerStarted(habit: Habit) {
        val day = store.today()
        if (eligible(habit, day)) timerBefore[habit.id] = Before(habit.id, day, store.streak(habit, day))
    }

    fun timerStopped(habitId: String) { timerBefore.remove(habitId) }

    /** Just after the log: a milestone it reached waits for the screen in front ([claim]); one made away is the row's. */
    fun after(before: Before?, habit: Habit, source: EntrySource, added: Double) {
        before ?: return
        ensureDay()
        val day = before.day
        if (day != store.today() || shown.containsKey(habit.id) || pending.any { it.habitId == habit.id }) return
        val ruled = store.rule(habit, day)
        val bucket = store.rules.milestoneBucket(ruled)
        val cause = when (source) {
            EntrySource.WIDGET, EntrySource.REMINDER, EntrySource.SHORTCUT, EntrySource.WATCH -> MilestoneCause.AWAY
            else -> MilestoneCause.TAP
        }
        val hits = ArrayList<MilestoneHit>()
        val streak = store.streak(habit, day)
        var previousBest = -1
        fun best(): Int {
            if (previousBest < 0) previousBest = store.rules.runs(habit, day).filter { !it.isCurrent }.maxOfOrNull { it.length } ?: 0
            return previousBest
        }
        if (streak > before.streak && store.setting("progress.showStreaks") != "false") {
            val listed = bucket.isRowMilestone(streak)
            if (listed || streak >= 14) {
                val first = streak > best()
                val again = !first && streak == best() && best() >= 14 && againAllowed(habit.id, day)
                val wanted = when {
                    listed && first -> if (bucket.isLandmark(streak)) MilestoneTier.POPUP else MilestoneTier.BAR
                    again -> MilestoneTier.BAR
                    listed -> MilestoneTier.ROW
                    else -> null
                }
                if (wanted != null) hits += MilestoneHit(habit.id, day, MilestoneTrack.IN_A_ROW, streak.toDouble(), wanted, again, best() < 3, cause)
            }
        }
        if (added > 0) {
            val total = lifetimeTotal(habit, ruled, day)
            bucket.totalCrossed(periodGoal(ruled), total - added, total)?.let {
                hits += MilestoneHit(habit.id, day, MilestoneTrack.IN_TOTAL, it, MilestoneTier.BAR, false, best() < 3, cause)
            }
        }
        anniversary(habit, day)?.let { years ->
            // On the day a run reaches a year, only the run's is shown.
            if (hits.none { it.track == MilestoneTrack.IN_A_ROW && it.wanted == MilestoneTier.POPUP })
                hits += MilestoneHit(habit.id, day, MilestoneTrack.ANNIVERSARY, years.toDouble(), MilestoneTier.POPUP, false, false, cause)
        }
        val lead = hits.minWithOrNull(compareBy<MilestoneHit>({ it.wanted.ordinal }, { it.track.ordinal })) ?: return
        if (cause == MilestoneCause.AWAY) recordAway(lead) else pending += lead
    }

    private fun againAllowed(habitId: String, day: Int) = againDays[habitId]?.let { day - it >= 30 } ?: true

    /** Everything logged since the start (a checklist: the days all its steps were done), in the habit's own unit. */
    private fun lifetimeTotal(habit: Habit, ruled: Habit, day: Int): Double {
        val all = store.entries(habit.id)
        if (ruled.kind == HabitKind.Checklist) return all.map { it.day }.filter { it <= day }.distinct().count { store.rules.isDayMet(habit, it) }.toDouble()
        return all.filter { it.stepId == null && it.day <= day }.sumOf { it.value }
    }

    /** The goal for one period: a day's for set days, a week's or month's for a goal over one (ST-8). */
    private fun periodGoal(ruled: Habit): Double = store.milestonePeriodGoal(ruled)

    /** Whole years since the first log, today being that date, when the goal was met in the last 30 days. */
    private fun anniversary(habit: Habit, day: Int): Int? {
        val first = store.entries(habit.id).minOfOrNull { it.day } ?: return null
        val years = milestoneAnniversary(first, day) ?: return null
        return years.takeIf { (day - 29..day).any { store.rules.isComplete(habit, it) } }
    }

    private fun recordAway(hit: MilestoneHit) {
        val see = hit.wanted == MilestoneTier.POPUP || hit.again
        record(MilestoneShown(hit.habitId, hit.day, hit.track, hit.value, MilestoneTier.ROW, hit.again, false, hit.cause, see, played = false))
    }

    // ------------------------------------------------------------------ Judged at the day's end: quit and cut down

    /**
     * Once a day, when Today opens: a quit run that passed a length yesterday, a cut-down habit whose day (or week, or
     * month) closed within its limit. Shown today, once, in the row (Figma R.9, R.10); never at a log or a slip.
     */
    fun dayCheck() {
        ensureDay()
        val today = store.today()
        var changed = false
        for (habit in store.habits) {
            if (habit.archived || shown.containsKey(habit.id) || store.isPaused(habit, today)) continue
            val ruled = store.rule(habit, today)
            val hit = when {
                ruled.kind == HabitKind.Quit -> quitHit(habit, today)
                ruled.atMost && ruled.kind != HabitKind.Task -> limitHit(habit, ruled, today)
                else -> null
            } ?: continue
            if ("${habit.id}:${hit.value.toInt()}" in notified) continue
            val see = hit.wanted == MilestoneTier.POPUP || hit.again
            shown[habit.id] = MilestoneShown(habit.id, today, hit.track, hit.value, MilestoneTier.ROW, hit.again, false, MilestoneCause.YESTERDAY, see, played = false)
            if (hit.again) againDays = againDays + (habit.id to today)
            changed = true
        }
        if (changed) save()
    }

    private fun quitDays(start: Long, at: Long): Int = if (at <= start) 0 else ((at - start) / DAY_MS).toInt()

    private fun quitHit(habit: Habit, today: Int): MilestoneHit? {
        val history = store.rules.quitHistory(habit, store.clock())
        val run = history.lastOrNull()?.takeIf { it.ending == QuitRun.Ending.ONGOING } ?: return null
        val from = store.rules.dayStartMoment(today - 1)
        val to = store.rules.dayStartMoment(today)
        val now = quitDays(run.start, to)
        val then = quitDays(run.start, from)
        if (now > then) {
            val best = history.dropLast(1).maxOfOrNull { ((it.end ?: to) - it.start) / DAY_MS }?.toInt() ?: 0
            val bucket = MilestoneBucket.DAYS
            val listed = (then + 1..now).lastOrNull { bucket.isRowMilestone(it) }
            if (listed != null) {
                val first = listed > best
                val wanted = if (!first) MilestoneTier.ROW else if (bucket.isLandmark(listed)) MilestoneTier.POPUP else MilestoneTier.BAR
                return MilestoneHit(habit.id, today, MilestoneTrack.IN_A_ROW, listed.toDouble(), wanted, false, false, MilestoneCause.YESTERDAY)
            }
            if (best >= 14 && best in then + 1..now && againAllowed(habit.id, today))
                return MilestoneHit(habit.id, today, MilestoneTrack.IN_A_ROW, best.toDouble(), MilestoneTier.BAR, true, false, MilestoneCause.YESTERDAY)
        }
        // Clean days in total: yesterday was one more.
        val start = store.rules.quitStartDay(habit)
        if (today - 1 >= start) {
            val clean = store.quitStats(habit, start..today - 1).cleanDays.toDouble()
            val yesterday = store.quitStats(habit, today - 1..today - 1).cleanDays.toDouble()
            MilestoneBucket.DAYS.totalCrossed(1.0, clean - yesterday, clean)?.let {
                return MilestoneHit(habit.id, today, MilestoneTrack.IN_TOTAL, it, MilestoneTier.BAR, false, false, MilestoneCause.YESTERDAY)
            }
        }
        return null
    }

    private fun limitHit(habit: Habit, ruled: Habit, today: Int): MilestoneHit? {
        // Judged when its day, week or month has just closed: on the first day of the next one.
        val closed = store.rules.periodRange(ruled, today - 1) ?: (today - 1..today - 1)
        if (closed.last != today - 1) return null
        val now = store.streak(habit, today)
        val before = store.streak(habit, closed.first - 1)
        if (now <= before) return null
        val bucket = store.rules.milestoneBucket(ruled)
        val runs = store.rules.runs(habit, today)
        val current = runs.lastOrNull()?.takeIf { it.end >= closed.first }
        val best = runs.filter { it !== current }.maxOfOrNull { it.length } ?: 0
        if (bucket.isRowMilestone(now)) {
            val wanted = if (now <= best) MilestoneTier.ROW else if (bucket.isLandmark(now)) MilestoneTier.POPUP else MilestoneTier.BAR
            return MilestoneHit(habit.id, today, MilestoneTrack.IN_A_ROW, now.toDouble(), wanted, false, false, MilestoneCause.YESTERDAY)
        }
        val within = runs.sumOf { it.length }.toDouble()
        bucket.totalCrossed(1.0, within - 1, within)?.let {
            return MilestoneHit(habit.id, today, MilestoneTrack.IN_TOTAL, it, MilestoneTier.BAR, false, false, MilestoneCause.YESTERDAY)
        }
        return null
    }

    /**
     * A milestone notification tapped (Figma N.6): its pop-up on Today, counted as the day's pop-up. Null when the
     * habit's gone.
     */
    fun opened(habitId: String, value: Int): MilestoneShown? {
        ensureDay()
        val habit = store.habit(habitId) ?: return null
        val today = store.today()
        notified = notified + ("$habitId:$value" to today)
        val s = shown[habitId] ?: MilestoneShown(habitId, today, MilestoneTrack.IN_A_ROW, value.toDouble(), MilestoneTier.POPUP,
            false, false, if (store.rule(habit, today).kind == HabitKind.Quit) MilestoneCause.TAP else MilestoneCause.YESTERDAY, false, true)
        record(s)
        return s
    }

    // ------------------------------------------------------------------ Shown: the screen in front takes it

    enum class Surface { TODAY, SHEET, PLAYER }

    /** The next milestone waiting for this screen, or null. */
    fun next(surface: Surface): MilestoneHit? {
        ensureDay()
        val f = front
        return pending.firstOrNull { hit ->
            when (surface) {
                Surface.TODAY -> f == MilestoneFront.Today
                Surface.SHEET -> f is MilestoneFront.Sheet && f.habitId == hit.habitId
                Surface.PLAYER -> f is MilestoneFront.Player && hit.habitId in f.habitIds
            }
        }
    }

    /**
     * Takes [hit] for [surface] and decides what it gets, first come first served (card 4 B): the day's first pop-up
     * (at most 2 in any 7 days), at most 2 bars, 2 big moments in all; a refused one goes down a level. Null when an
     * undo has taken it back meanwhile.
     */
    fun claim(hit: MilestoneHit, surface: Surface): MilestoneShown? {
        ensureDay()
        pending.remove(hit)
        val habit = store.habit(hit.habitId) ?: return null
        if (shown.containsKey(habit.id)) return null
        val probe = MilestoneShown(hit.habitId, hit.day, hit.track, hit.value, MilestoneTier.ROW, hit.again, false, hit.cause, false, true)
        if (!stillReached(habit, probe)) return null
        val first = !firstDone && hit.couldBeFirst && store.habits.none { it.id != habit.id && store.bestStreak(it) >= 3 }
        firstDone = true
        val today = shown.values
        val popups = today.count { it.tier == MilestoneTier.POPUP }
        val bars = today.count { it.tier == MilestoneTier.BAR }
        val big = popups + bars
        var tier = if (first) MilestoneTier.POPUP else hit.wanted
        if (tier == MilestoneTier.POPUP && (popups >= 1 || popupDays.count { it > hit.day - 7 } >= 2 || big >= 2)) tier = MilestoneTier.BAR
        // Today and Day details show the bar (Figma's "Milestones from Day details: the bar"); the player its ribbon.
        if (tier == MilestoneTier.BAR && surface == Surface.PLAYER) tier = MilestoneTier.ROW
        if (tier == MilestoneTier.BAR && (bars >= 2 || big >= 2)) tier = MilestoneTier.ROW
        val s = probe.copy(tier = tier, first = first && tier == MilestoneTier.POPUP, played = tier != MilestoneTier.ROW || surface != Surface.TODAY)
        record(s)
        return s
    }

    /** Whether the milestone still stands: an undo takes a streak or a total back below it. */
    fun stillReached(habit: Habit, s: MilestoneShown): Boolean {
        if (s.cause == MilestoneCause.YESTERDAY || s.track == MilestoneTrack.ANNIVERSARY) return true
        val ruled = store.rule(habit, s.day)
        return when (s.track) {
            MilestoneTrack.IN_A_ROW -> store.streak(habit, s.day) >= s.value.toInt()
            MilestoneTrack.IN_TOTAL -> lifetimeTotal(habit, ruled, s.day) + 1e-9 >= s.value
            MilestoneTrack.ANNIVERSARY -> true
        }
    }

    // ------------------------------------------------------------------ Words

    fun words(s: MilestoneShown, habit: Habit): MilestoneWords {
        val ruled = store.rule(habit, s.day)
        val n = s.value
        val quit = ruled.kind == HabitKind.Quit
        val limit = ruled.atMost && !quit
        val unit = ruled.frequency.streakUnit
        val bucket = if (quit) MilestoneBucket.DAYS else store.rules.milestoneBucket(ruled)
        fun rowTitle(k: Int) = when {
            quit -> "$k ${if (k == 1) "day" else "days"} clean"
            limit -> "$k ${unit.word(k)} within the limit"
            else -> milestoneRowTitle(k, unit)
        }
        // A week's or month's goal met N times in a row: "26 weeks of goals met" (Figma 876:73789, 877:74702); days stay
        // "in a row", and the next one's card keeps "52 weeks in a row".
        fun runTitle(k: Int) = if (!quit && !limit && (unit == StreakUnit.WEEKS || unit == StreakUnit.MONTHS)) "$k ${unit.word(k)} of goals met" else rowTitle(k)
        fun totalTitle(v: Double): String = when {
            quit -> "${Format.amount(v)} clean days in total"
            limit -> "${Format.amount(v)} ${if (v == 1.0) "day" else "days"} within the limit in total"
            else -> milestoneTotalWords(ruled, v)
        }
        val number: String
        val title: String
        var next: MilestoneAhead? = null
        when (s.track) {
            MilestoneTrack.IN_A_ROW -> {
                number = Format.amount(n)
                title = runTitle(n.toInt()) + if (s.again || reachedBefore(s, habit, quit)) " again" else ""
                bucket.nextRow(n.toInt())?.let { k ->
                    next = MilestoneAhead("$k", rowTitle(k), "Next · ${k - n.toInt()} to go · now ${n.toInt()}", (n / k).toFloat())
                }
                // Back at an earlier length: the next is the best run, when it's still ahead ("Next · your best is 45",
                // Figma 886:81868).
                if (reachedBefore(s, habit, quit)) earlierBest(habit, s.day, quit).takeIf { it > n.toInt() }?.let { best ->
                    next = MilestoneAhead("$best", rowTitle(best), "Next · your best is $best", (n / best).toFloat())
                }
            }
            MilestoneTrack.IN_TOTAL -> {
                number = Format.amount(n)
                title = totalTitle(n)
                val goal = if (quit || limit) 1.0 else periodGoal(ruled)
                bucket.nextTotal(goal, n)?.let { v ->
                    // A total counts up: "25 so far" (Figma 884:80684); a run is "now 30".
                    next = MilestoneAhead(Format.amount(v), totalTitle(v), "Next · ${Format.amount(v - n)} to go · ${Format.amount(n)} so far", (n / v).toFloat())
                }
            }
            MilestoneTrack.ANNIVERSARY -> {
                number = Format.amount(n)
                val years = n.toInt()
                title = if (years == 1) "One year of ${habit.name}" else "$years years of ${habit.name}"
                val first = store.entries(habit.id).minOfOrNull { it.day } ?: s.day
                val nextDay = java.time.LocalDate.ofEpochDay(first.toLong()).plusYears((years + 1).toLong()).toEpochDay().toInt()
                next = MilestoneAhead("${years + 1}", "${years + 1} years of ${habit.name}", fullDate(nextDay), 0f)
            }
        }
        val whenWords = if (s.cause == MilestoneCause.YESTERDAY) "yesterday" else "reached today"
        // The band and the player's ribbon name the milestone only, in the pop-up's words (Figma 156:47): "30 days in a row".
        val band = title
        val popupTitle = when {
            s.first -> "Your first milestone"
            s.again || reachedBefore(s, habit, quit) -> runTitle(n.toInt()) + ", again"
            else -> title
        }
        val subtitle = when {
            s.first -> "$title · ${habit.name}"
            s.again -> "${habit.name} · back to your best run"
            reachedBefore(s, habit, quit) -> "${habit.name} · back to your earlier run"
            s.track == MilestoneTrack.ANNIVERSARY -> {
                val first = store.entries(habit.id).minOfOrNull { it.day } ?: s.day
                val met = store.rules.runs(habit, s.day).sumOf { it.length }
                "Since ${fullDate(first)} · goal met $met ${if (met == 1) "time" else "times"}"
            }
            // A limit's run is judged when its day closes: "Coffee · yesterday, no more than 2 cups" (Figma 882:77784).
            limit && s.track == MilestoneTrack.IN_A_ROW && s.cause == MilestoneCause.YESTERDAY ->
                "${habit.name} · ${when (unit) { StreakUnit.WEEKS -> "last week"; StreakUnit.MONTHS -> "last month"; else -> "yesterday" }}, no more than ${limitAmount(ruled)}"
            else -> "${habit.name} · " + (landmarkWords(s, habit, bucket, quit || limit)
                ?: if (s.cause == MilestoneCause.YESTERDAY) "reached yesterday" else "reached today")
        }
        val second = if (s.track == MilestoneTrack.ANNIVERSARY) "See the year" else "All milestones"
        return MilestoneWords(number, title, band, popupTitle, subtitle, next, "${habit.name}: $title, $whenWords", second)
    }

    /**
     * What a pop-up's length means, under its title (Figma's pop-ups): a year of days "every day for a year", half a year
     * "every day for half a year"; weeks "half a year, week after week", "a year, week after week"; months "every month
     * since April". Null for the rest (a month of days: "reached today").
     */
    private fun landmarkWords(s: MilestoneShown, habit: Habit, bucket: MilestoneBucket, quitOrLimit: Boolean): String? {
        if (s.track != MilestoneTrack.IN_A_ROW || quitOrLimit || !bucket.isLandmark(s.value.toInt())) return null
        val n = s.value.toInt()
        fun years(y: Int) = if (y == 1) "a year" else "$y years"
        return when (bucket) {
            MilestoneBucket.DAYS -> when { n == 180 -> "every day for half a year"; n % 365 == 0 -> "every day for ${years(n / 365)}"; else -> null }
            MilestoneBucket.WEEKS -> when { n == 26 -> "half a year, week after week"; n % 52 == 0 -> "${years(n / 52)}, week after week"; else -> null }
            MilestoneBucket.MONTHS -> {
                val start = store.rules.runs(habit, s.day).lastOrNull { it.isCurrent }?.start ?: return null
                val from = java.time.LocalDate.ofEpochDay(start.toLong())
                val today = java.time.LocalDate.ofEpochDay(s.day.toLong())
                val month = from.month.getDisplayName(java.time.format.TextStyle.FULL, java.util.Locale.ENGLISH)
                "every month since " + if (from.year == today.year) month else "$month ${from.year}"
            }
            MilestoneBucket.YEARS -> null
        }
    }

    /**
     * A length in a row reached before a break, shown as just the row: "7 days in a row again", "30 days clean again"
     * (Figma 108:1308). A first-time milestone that only got the row because the day's bars were used up stays plain.
     */
    private fun reachedBefore(s: MilestoneShown, habit: Habit, quit: Boolean): Boolean {
        if (s.track != MilestoneTrack.IN_A_ROW || s.again || s.tier != MilestoneTier.ROW) return false
        return earlierBest(habit, s.day, quit) >= s.value.toInt()
    }

    /** The longest run before this one (a quit habit's in whole days clean), 0 when there's none. */
    private fun earlierBest(habit: Habit, day: Int, quit: Boolean): Int {
        if (quit) return store.rules.quitHistory(habit, store.clock()).filter { it.ending != QuitRun.Ending.ONGOING }
            .maxOfOrNull { quitDays(it.start, it.end ?: it.start) } ?: 0
        return store.rules.runs(habit, day).filter { !it.isCurrent }.maxOfOrNull { it.length } ?: 0
    }

    companion object {
        private const val DAY_MS = 86_400_000L

        /** A limit's amount: "2 cups", "30 min" (the pop-up's line and the milestone notification). */
        fun limitAmount(ruled: Habit): String = when (val k = ruled.kind) {
            is HabitKind.Amount -> HabitCopy.amount(ruled.goal, k.unit)
            HabitKind.Duration -> Format.minutes(ruled.goal)
            else -> Format.amount(ruled.goal)
        }
        private val FULL_DATE = java.time.format.DateTimeFormatter.ofPattern("d MMMM yyyy", java.util.Locale.ENGLISH)
        /** "17 October 2025" (Figma P.10). */
        fun fullDate(day: Int): String = java.time.LocalDate.ofEpochDay(day.toLong()).format(FULL_DATE)
    }
}
