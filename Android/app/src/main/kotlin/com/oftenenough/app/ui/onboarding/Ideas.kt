package com.oftenenough.app.ui.onboarding

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.height
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.components.ListRow
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.newhabit.FormPage
import com.oftenenough.app.ui.newhabit.Note
import com.oftenenough.app.ui.theme.HabitIcons

/** Start from an idea (an empty Today's second button): the welcome's ideas, each opening the form filled in. */
@Composable
fun IdeasScreen(onBack: () -> Unit, onPick: (HabitIdea) -> Unit) {
    FormPage("Start from an idea", chip = null, onBack = onBack) {
        Spacer(Modifier.height(8.dp))
        SegmentedList {
            HabitIdea.all.forEachIndexed { i, idea ->
                Box(Modifier.semantics { testTag = "idea-${idea.name}" }) {
                    ListRow(idea.name, i, HabitIdea.all.size, idea.line, HabitIcons.icon(idea.symbol), iconDisc = true, onClick = { onPick(idea) })
                }
            }
        }
        Note("An idea only fills in the form. Nothing is added until you tap Add.")
    }
}
