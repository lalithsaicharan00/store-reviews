package com.oftenenough.app.data.widgets

import kotlinx.serialization.Serializable

// The widgets' snapshot, ported from the iPhone's WidgetSnapshot.swift: everything a widget draws, worked out by the app
// with the store's own functions, so a widget never disagrees with Today or Progress (U26). The widget only draws it.

/** What a widget's one button does. */
@Serializable
enum class WidgetAction { CHECK, ADD, TIMER_START, TIMER_PAUSE, OPEN }

/** A day's square in This week: the Progress Week's language. 0: not done; 1–3 part; 4 met; 5 more than the goal. */
object WidgetCell {
    const val BLANK = -1
    const val UPCOMING = -2
    const val NOT_SCHEDULED = -3
    const val SKIPPED = -4
    const val PAUSED = -5
}

@Serializable
data class WidgetItem(
    val id: String,
    val name: String,
    val symbol: String,
    val color: String = "blue",
    /** check, amount, duration, checklist, quit, task. */
    val type: String,
    val isTask: Boolean = false,
    /** Cut down: the goal is a maximum, never celebrated (U3, U25). */
    val limit: Boolean = false,
    /** null, or "skipped", "paused", "notPlanned": neutral states with quick logging off. */
    val state: String? = null,
    /** The Today cards it's on this day, in Today's order; empty when it isn't on Today. */
    val cards: List<String> = emptyList(),
    /** A list row's line ("3 of 8 glasses", "Done"), and in the Today list with the section first. */
    val line: String = "",
    val todayLine: String = "",
    val place: String = "",
    /** The Small card's value line ("3 of 8 glasses", "1 of 2 cups max", "1h 12m of 3 h"). */
    val value: String = "",
    /** This week's big number and the goal after it ("3", "of 8 glasses"). */
    val big: String = "",
    val goal: String = "",
    /** The Small card's capsule ("Daily limit", "Best 45 days", "Skipped today"). */
    val caption: String? = null,
    /** How full a list row is toward Today's goal (a week or month goal: its period's, U25); the Small card's bar. */
    val fraction: Double? = null,
    val cardFraction: Double? = null,
    /** A limit's neutral fill, never the habit's colour (U2). */
    val limitFill: Boolean = false,
    /** Positive completion: the button turns the habit's colour with white content. */
    val done: Boolean = false,
    /** A + whose next tap meets the goal. */
    val completesNext: Boolean? = null,
    /** LOCKED (widget taps): the card as it will be after one tap, worked out by the app (W3); a + chain holds the next. */
    val after: List<WidgetItem>? = null,
    val todayAmount: Double? = null,
    val todayLevel: Int? = null,
    /** Counted in a list's "2 of 5 done", and done there (the day bar's own rule, U10). */
    val counts: Boolean = false,
    val countsDone: Boolean = false,
    /** Done for the day on Today (or skipped): sinks below the rest when done habits move to the bottom (U13). */
    val sinks: Boolean = false,
    val action: WidgetAction = WidgetAction.OPEN,
    /** What a + button says ("+1", "+500"). */
    val actionText: String? = null,
    /** Where an open button goes: "item/<id>" (Day details), "log/<id>", "slip/<id>", "timer/<id>". */
    val route: String? = null,
    /** The drawn rendition's ID; a tap's log gets its own new ID, so two quick taps are two logs. */
    val token: String,
    val streak: String? = null,
    /** Quit: when the current run began (epoch ms), and where its counter stops (a known pause or end). */
    val quitStart: Long? = null,
    val quitUntil: Long? = null,
    val quitBest: Double? = null,
    val quitBestText: String? = null,
    val since: String? = null,
    /** A running timer: when its clock read 0:00 (start minus what was already logged), and when it reaches the goal. */
    val timerClock: Long? = null,
    val timerGoalAt: Long? = null,
    val timerGoal: String? = null,
    /** The week's seven squares in the person's week order ([WidgetCell]), and which is this day (-1: none). */
    val week: List<Int> = emptyList(),
    val weekToday: Int = -1,
) {
    val routeOrDay: String get() = route ?: "item/$id"
}

/** A Today card a list can show (a time of day, Anytime, or Quit or Cut Down), by its stable ID (U13). */
@Serializable
data class WidgetSection(val id: String, val name: String)

/** A habit offered in a widget's setup, in the person's own order. */
@Serializable
data class WidgetChoice(val id: String, val name: String, val symbol: String? = null)

@Serializable
data class WidgetFrame(
    val day: Int,
    /** The tracked day's first moment and the next day's (epoch ms). */
    val start: Long,
    val end: Long,
    val items: List<WidgetItem>,
    /** Each list in Today's order: "habits", "habits:<section>", "tasks", "tasks:<section>". */
    val lists: Map<String, List<String>> = emptyMap(),
    /** The order shown until [settle]: nothing moves during a run of taps (U4); done rows sink after it (U13). */
    val held: Map<String, List<String>>? = null,
    val settle: Long? = null,
) {
    fun item(id: String?): WidgetItem? = id?.let { i -> items.firstOrNull { it.id == i } }

    fun list(key: String, at: Long): List<WidgetItem> {
        val holding = settle?.let { at < it } ?: false
        val ids = (if (holding) held?.get(key) else null) ?: lists[key] ?: emptyList()
        val byId = items.associateBy { it.id }
        return ids.mapNotNull { byId[it] }
    }
}

@Serializable
data class WidgetSnapshot(
    val version: Int = VERSION,
    val generated: Long,
    val timeZone: String,
    val plus: Boolean,
    /** Hide names outside the app: written without a habit name, task title or section name anywhere. */
    val discreet: Boolean = false,
    val sections: List<WidgetSection> = emptyList(),
    val taskSections: List<WidgetSection> = emptyList(),
    val choices: List<WidgetChoice> = emptyList(),
    /** "Sun" … "Sat" in the person's week order. */
    val weekdays: List<String> = emptyList(),
    val timerOpensScreen: Boolean = true,
    /** Seven tracked days from today, so the widgets move on at the day's start without the app. */
    val frames: List<WidgetFrame>,
) {
    fun frame(at: Long, zone: String = java.util.TimeZone.getDefault().id): WidgetFrame? {
        if (version != VERSION || timeZone != zone) return null
        return frames.firstOrNull { it.start <= at && at < it.end }
    }

    /** The same snapshot without a word the person wrote; every item, count and button stays (Current Work 58). */
    fun withoutNames(): WidgetSnapshot = copy(
        discreet = true,
        sections = sections.mapIndexed { i, s -> WidgetSection(s.id, "Section ${i + 1}") },
        taskSections = taskSections.mapIndexed { i, s -> WidgetSection(s.id, "Section ${i + 1}") },
        choices = choices.mapIndexed { i, c -> WidgetChoice(c.id, "Habit ${i + 1}", c.symbol) },
        frames = frames.map { f -> f.copy(items = f.items.map(::nameless)) },
    )

    companion object {
        const val VERSION = 1
        private fun nameless(item: WidgetItem): WidgetItem =
            item.copy(name = "", place = "", todayLine = item.line, after = item.after?.map(::nameless))
    }
}
