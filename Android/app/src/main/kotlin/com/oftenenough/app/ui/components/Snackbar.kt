package com.oftenenough.app.ui.components

import androidx.compose.foundation.layout.Row
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Snackbar
import androidx.compose.material3.SnackbarData
import androidx.compose.material3.SnackbarHost
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextOverflow

/**
 * The app's one message line (AppMain's), for a sheet to show it over itself: a message said on the page under Day
 * details ("Note saved", "Note deleted · Undo") shows on the sheet, where the person is looking.
 */
val LocalAppSnackbar = androidx.compose.runtime.staticCompositionLocalOf<SnackbarHostState?> { null }

/**
 * Atom 2.6, **Snackbar** (Figma 778:444; Components — Atoms Build Plan): Material's own `Snackbar` as it is: Inverse
 * surface, 4 dp corners, Elevation Level 3, 48 dp for one line and 68 for two, the text Body Medium in Inverse on
 * surface, the action a text button in Label Large, the close Material's own, 12 dp from the edges of where it sits.
 * The design's small settings, nothing else:
 *
 * - **Action colour:** Inverse on surface, the text's own colour (Material's is Inverse primary; the app's chrome is
 *   monochrome and Figma draws it so).
 * - **A second action** ([AppSnackbar] with two [SnackbarAction]s): only where an approved flow has two, the routine
 *   player's Saved · Undo · Add note. Material's snackbar takes one action, so both sit in its action slot, side by
 *   side, as Material's text buttons.
 *
 * Messages a screen shows through a [SnackbarHostState] use [AppSnackbarHost].
 */
@Composable
fun AppSnackbarHost(state: SnackbarHostState, modifier: Modifier = Modifier) =
    SnackbarHost(state, modifier) { AppSnackbar(it) }

/** One message from a [SnackbarHostState]: its words, its one action and its close, if it has them. */
@Composable
fun AppSnackbar(data: SnackbarData, modifier: Modifier = Modifier) {
    val label = MaterialTheme.colorScheme.inverseOnSurface
    Snackbar(data, modifier, actionColor = label, actionContentColor = label)
}

/** One of the actions of a snackbar a screen shows itself. */
class SnackbarAction(val label: String, val tag: String? = null, val onClick: () -> Unit)

/**
 * A snackbar a screen shows itself, from its own state (the routine player's, after a log): [message], then up to two
 * [actions], in the order given (Figma: Undo, then Add note). Like Material's own, it has no room around it: the
 * screen places it.
 */
@Composable
fun AppSnackbar(message: String, actions: List<SnackbarAction>, modifier: Modifier = Modifier) {
    val label = MaterialTheme.colorScheme.inverseOnSurface
    Snackbar(
        modifier,
        action = if (actions.isEmpty()) null else { {
            Row {
                actions.forEach { a ->
                    TextButton(a.onClick, Modifier.semantics { a.tag?.let { testTag = it } },
                        colors = ButtonDefaults.textButtonColors(contentColor = label)) { Text(a.label) }
                }
            }
        } },
        actionContentColor = label,
    ) {
        Text(message, maxLines = 2, overflow = TextOverflow.Ellipsis)
    }
}
