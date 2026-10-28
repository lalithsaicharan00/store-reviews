package com.oftenenough.app.ui.habit

import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.components.ButtonSize
import com.oftenenough.app.ui.components.AppButton
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.components.ListRow
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.newhabit.DayDialog
import com.oftenenough.app.ui.newhabit.FormPage
import com.oftenenough.app.ui.newhabit.GroupTitle
import com.oftenenough.app.ui.newhabit.Note
import com.oftenenough.app.ui.newhabit.RadioRow
import com.oftenenough.app.ui.theme.appColors

/** How long a pause lasts. */
enum class PauseLength { WEEK, TWO_WEEKS, DATE, OPEN }

/**
 * What Pause will do, said before it's tapped (the iPhone's PauseSheet.summary). [back] is the day it comes back, null
 * when it waits to be turned back on. // MOVE TO CORE (words)
 */
fun pauseSummary(habits: List<Habit>, from: Int, back: Int?, today: Int): String {
    val one = habits.size == 1
    val name = if (one) habits[0].name else "${habits.size} habits"
    if (!one) {
        val until = back?.let { "until ${DayWords.short(it)}" } ?: "until you turn them back on"
        var text = "$name leave Today $until. Streaks stay, and reminders stop."
        if (habits.any { it.kind == HabitKind.Quit }) text += " A quit habit's current run ends now and is kept; a new run starts when it's back."
        return text
    }
    if (habits[0].kind == HabitKind.Quit) {
        val comes = back?.let { "when it comes back on ${DayWords.short(it)}" } ?: "when you turn it back on"
        return "$name's current run ends now and is kept as a run, not a slip. A new run starts $comes."
    }
    val until = back?.let { "until ${DayWords.short(it)}" } ?: "until you turn it back on"
    val starts = if (from > today) "From ${DayWords.short(from)}, " else ""
    var text = "$starts$name leaves Today $until. Your streak stays, and reminders stop."
    if (from < today) text += " Days from ${DayWords.short(from)} count as paused."
    return text
}

/** The day a pause of [length] from [from] comes back on ([chosen] for a date the person picked). */
fun pauseBack(length: PauseLength, from: Int, chosen: Int): Int? = when (length) {
    PauseLength.WEEK -> from + 7
    PauseLength.TWO_WEEKS -> from + 14
    PauseLength.DATE -> maxOf(chosen, from + 1)
    PauseLength.OPEN -> null
}

/**
 * Pause a habit for a stretch of days (the iPhone's PauseSheet; report "Pausing a Habit — What People Need"): until a
 * date, which brings it back on its own, or until it's turned back on. Any length, and the streak is kept. A quit habit
 * pauses now: its current run ends and is kept as a run, not a slip. Earlier start days are allowed (someone who was ill
 * can pause after the fact).
 */
@Composable
fun PauseScreen(habitIds: List<String>, store: HabitStore, onClose: () -> Unit) {
    val habits = habitIds.mapNotNull { store.habit(it) }.filter { store.rules.canPause(it) }
    if (habits.isEmpty()) { onClose(); return }
    val habit = habits[0]
    val today = store.today()
    // Only quit habits: they pause now, so there's no start day to choose.
    val isQuit = habits.all { it.kind == HabitKind.Quit }
    var length by rememberSaveable { mutableStateOf(PauseLength.WEEK) }
    var start by rememberSaveable { mutableStateOf(today) }
    val from = if (isQuit) today else start
    var chosen by rememberSaveable { mutableStateOf(today + 7) }
    var picking by rememberSaveable { mutableStateOf<String?>(null) }
    val back = pauseBack(length, from, chosen)
    Box(Modifier.fillMaxSize().background(appColors.screen)) {
        FormPage(if (habits.size == 1) "Pause ${habit.name}" else "Pause ${habits.size} habits", chip = null, onBack = onClose, close = true) {
            GroupTitle("Pause until")
            SegmentedList {
                RadioRow("1 week", length == PauseLength.WEEK, 0, 4, "pause-week", "Back ${DayWords.short(from + 7)}") { length = PauseLength.WEEK }
                RadioRow("2 weeks", length == PauseLength.TWO_WEEKS, 1, 4, "pause-two-weeks", "Back ${DayWords.short(from + 14)}") { length = PauseLength.TWO_WEEKS }
                RadioRow("Choose a date", length == PauseLength.DATE, 2, 4, "pause-date",
                    if (length == PauseLength.DATE) "Back ${DayWords.short(maxOf(chosen, from + 1))}" else null) { length = PauseLength.DATE; picking = "back" }
                RadioRow("Until I turn it back on", length == PauseLength.OPEN, 3, 4, "pause-open") { length = PauseLength.OPEN }
            }
            if (!isQuit) {
                Spacer(Modifier.height(16.dp))
                SegmentedList {
                    Box(Modifier.semantics { testTag = "pause-start" }) {
                        ListRow("Starts", 0, 1, if (start == today) "Today" else DayWords.short(start), Symbols.Event, onClick = { picking = "start" })
                    }
                }
            }
            Note(pauseSummary(habits, from, back, today))
            Spacer(Modifier.height(96.dp))
        }
        AppButton("Pause", {
            for (h in habits) store.pause(h, from, back?.let { it - 1 })
            onClose()
        }, Modifier.align(Alignment.BottomCenter).fillMaxWidth().navigationBarsPadding().padding(16.dp).semantics { testTag = "confirm-pause" }, size = ButtonSize.Medium)
    }
    when (picking) {
        "back" -> DayDialog(maxOf(chosen, from + 1), { it > from }, { picking = null }) { chosen = it }
        // Any day from the habit's start, up to a year ahead.
        "start" -> DayDialog(start, { d -> d >= habits.minOf { store.rules.startDay(it) } && d <= today + 365 }, { picking = null }) { start = it; if (chosen <= it) chosen = it + 7 }
    }
}
