package com.oftenenough.app.ui.onboarding

import com.oftenenough.app.ui.components.ListChevron
import com.oftenenough.app.ui.components.AppListItem
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.height
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.newhabit.FormPage
import com.oftenenough.app.ui.newhabit.Note

/**
 * One ready-made habit: [title] is the row ("Drink 8 glasses of water"), [name] the habit it makes ("Drink water"),
 * and the rest **fills in the whole form**, so Add works straight away and adds it as it is (the user, 19 Oct 2026:
 * "whatever the defaults values that has been set with those they should be able to continue forward and directly add
 * it"). Nothing is saved until Add. [minutes] for a time habit, [goal] and [unit] (with the + step [step]) for an
 * amount.
 *
 * These were the welcome's ideas until 22 October 2026, when the welcome went (there is no onboarding any more); they
 * live on behind the Habits page's **Start from an idea**.
 */
data class HabitIdea(
    val title: String, val name: String, val type: String, val symbol: String, val color: HabitColor,
    val goal: Double = 1.0, val unit: String = "", val step: Double = 1.0, val minutes: Int = 0, val line: String = "Every day",
) {
    companion object {
        val all = listOf(
            HabitIdea("Drink 8 glasses of water", "Drink water", "amount", "drop.fill", HabitColor.BLUE, goal = 8.0, unit = "glasses"),
            HabitIdea("Exercise for 30 minutes", "Exercise", "time", "dumbbell.fill", HabitColor.PINK, minutes = 30),
            HabitIdea("Read for 30 minutes", "Read", "time", "book.fill", HabitColor.ORANGE, minutes = 30),
            HabitIdea("Walk 10,000 steps", "Walk", "amount", "figure.walk", HabitColor.PURPLE, goal = 10_000.0, unit = "steps", step = 1_000.0),
            HabitIdea("Take vitamins", "Take vitamins", "check", "pills.fill", HabitColor.GREEN),
            HabitIdea("Floss", "Floss", "check", "mouth.fill", HabitColor.INDIGO),
            HabitIdea("Go to bed on time", "Go to bed on time", "check", "moon.fill", HabitColor.GRAY),
            HabitIdea("Meditate for 10 minutes", "Meditate", "time", "figure.mind.and.body", HabitColor.BROWN, minutes = 10),
        )
    }
}

/** One idea's row: its icon in its colour, what it is, and how often. */
@Composable
fun IdeaRow(idea: HabitIdea, index: Int, count: Int, onClick: () -> Unit) =
    AppListItem(idea.title, index, count, supporting = idea.line, onClick = onClick, tag = "idea-${idea.name}",
        leading = { HabitIcon(idea.symbol, idea.color) }, trailing = { ListChevron() })

/** Start from an idea (the Habits page): each row opens the habit form, filled in. */
@Composable
fun IdeasScreen(onBack: () -> Unit, onPick: (HabitIdea) -> Unit) {
    FormPage("Start from an idea", onBack = onBack) {
        Spacer(Modifier.height(8.dp))
        SegmentedList {
            HabitIdea.all.forEachIndexed { i, idea ->
                Box(Modifier.semantics { testTag = "idea-${idea.name}" }) {
                    IdeaRow(idea, i, HabitIdea.all.size) { onPick(idea) }
                }
            }
        }
        Note("An idea only fills in the form. Nothing is added until you tap Add.")
    }
}
