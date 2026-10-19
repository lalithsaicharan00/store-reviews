package com.oftenenough.app.data

// MOVE TO CORE: adding or editing a time of day, ported from the iPhone's SectionPlan.swift. Each time of day ends where
// the next begins; new times split the ones they overlap, and the person sees every change before saving.

class SectionPlan(val rows: List<Row>, val problem: String?, val sections: List<DaySection>) {
    /** One timed section as it will be, with how it was (null for the new one). */
    data class Row(val id: String, val name: String, val start: Int, val end: Int, val oldStart: Int?, val oldEnd: Int?, val isSubject: Boolean) {
        val changed: Boolean get() = oldStart != start || oldEnd != end
        val range: String get() = "${DayWords.clockMinute(start % (24 * 60))} – ${DayWords.clockMinute(end % (24 * 60))}"
        val oldRange: String? get() = if (oldStart != null && oldEnd != null) "${DayWords.clockMinute(oldStart % (24 * 60))} – ${DayWords.clockMinute(oldEnd % (24 * 60))}" else null
    }

    /** The other sections whose times change: these are split, and the person is asked first. */
    val split: List<Row> get() = rows.filter { !it.isSubject && it.changed }

    private class Range(val section: DaySection, val start: Int, var end: Int)

    companion object {
        /**
         * [subject] is the section being added (a new ID) or edited (its ID), with its new name; [start] and [end] are clock
         * minutes (an end at or before the start is after midnight); [defaultEnd] is where the latest ends without its own.
         */
        fun make(sections: List<DaySection>, subject: DaySection, start: Int, end: Int, defaultEnd: Int = 24 * 60): SectionPlan {
            val timed = sections.filter { !it.isAnytime }.sortedBy { it.start }
            val before = ranges(timed, defaultEnd)
            val was = before.associate { it.section.id to (it.start to it.end) }

            // Take the subject out. Its old times go to the section before it; if it was the latest, the one before keeps the day's end.
            val rest = timed.filter { it.id != subject.id }.toMutableList()
            val old = before.firstOrNull { it.section.id == subject.id }
            if (old != null && old.section.id == timed.lastOrNull()?.id && rest.isNotEmpty()) rest[rest.lastIndex] = rest.last().copy(end = old.end)

            val s = start
            val e = if (end > start) end else end + 24 * 60
            val placed = mutableListOf<Range>()
            val covered = mutableListOf<String>()
            for (r in ranges(rest, defaultEnd)) {
                when {
                    r.start < s -> placed += Range(r.section, r.start, minOf(r.end, s))
                    r.start < e -> if (r.end <= e) covered += r.section.name else placed += Range(r.section, e, r.end)
                    else -> placed += r
                }
            }
            val next = placed.filter { it.start >= e }.minByOrNull { it.start }
            val subjectEnd = next?.start ?: e
            placed.filter { it.start < s }.maxByOrNull { it.start }?.end = s
            placed += Range(subject, s, subjectEnd)
            placed.sortBy { it.start }

            val rows = placed.map { item ->
                val w = was[item.section.id]
                Row(item.section.id, if (item.section.id == subject.id) subject.name else item.section.name, item.start, item.end,
                    w?.first, w?.second, item.section.id == subject.id)
            }
            val problem = when {
                covered.isNotEmpty() -> "That covers all of ${HabitCopy.join(covered)}. Choose shorter times, or delete ${if (covered.size == 1) "it" else "them"} first."
                e - s < 15 -> "Give it at least 15 minutes."
                e - s > 24 * 60 -> "It can't be longer than a day."
                else -> null
            }
            val list = mutableListOf(sections.firstOrNull { it.isAnytime } ?: DaySection.defaults[0])
            placed.forEachIndexed { i, item ->
                val name = if (item.section.id == subject.id) subject.name else item.section.name
                list += item.section.copy(name = name, start = item.start % (24 * 60), end = if (i == placed.size - 1) item.end else null)
            }
            return SectionPlan(rows, problem, list)
        }

        /**
         * A time of day set by its start alone (Current Work 108): it runs until the next one starts, or until the day ends
         * (where the latest one ends now). [dayEnd] is the day's end in minutes from the day's midnight (24 * 60 + New day
         * starts at). A start before the day starts belongs to the end of the day.
         */
        fun fromStart(sections: List<DaySection>, subject: DaySection, start: Int, dayEnd: Int = 24 * 60): SectionPlan {
            val timed = sections.filter { !it.isAnytime }.sortedBy { it.start }
            val s = if (start < dayEnd - 24 * 60) start + 24 * 60 else start
            val lastEnd = ranges(timed, dayEnd).lastOrNull()?.end ?: dayEnd
            val rest = timed.filter { it.id != subject.id }
            val end = rest.mapNotNull { it.start }.filter { it > s }.minOrNull() ?: if (s >= lastEnd) dayEnd else lastEnd
            val plan = make(sections, subject, s, end, dayEnd)
            val clash = rest.any { it.start == s % (24 * 60) }
            return SectionPlan(plan.rows, if (clash) "Another time of day starts then." else null, plan.sections)
        }

        /**
         * Where a new time of day opens (Current Work 98): in time no other one covers, so nothing is split. The two hours
         * before the first one when they're free (4:00 AM with the standard set), else the start of the free time before it,
         * else null: the whole day is covered, and the person picks a start.
         */
        fun freeStart(sections: List<DaySection>, dayEnd: Int = 24 * 60): Int? {
            val timed = sections.filter { !it.isAnytime }.sortedBy { it.start }
            if (timed.isEmpty()) return 6 * 60
            val first = timed.first().start!!
            val lastEnd = ranges(timed, dayEnd).last().end - 24 * 60
            val gap = first - lastEnd
            return when {
                gap >= 120 -> first - 120
                gap > 0 -> lastEnd.mod(24 * 60)
                else -> null
            }
        }

        private fun ranges(timed: List<DaySection>, defaultEnd: Int): List<Range> = timed.mapIndexed { i, s ->
            Range(s, s.start!!, if (i + 1 < timed.size) timed[i + 1].start!! else (s.end ?: defaultEnd))
        }
    }
}
