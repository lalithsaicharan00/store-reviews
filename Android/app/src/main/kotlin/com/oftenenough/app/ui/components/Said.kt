package com.oftenenough.app.ui.components

import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Snackbar
import androidx.compose.material3.SnackbarDuration
import androidx.compose.material3.SnackbarHost
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.SnackbarResult
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.snapshotFlow
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.theme.appColors

/**
 * Says what happened after an action that left the screen it was done on: a deleted log says so on
 * whatever is behind it, with Undo (Day details flows 11 and 12). The screen that is on top drains it,
 * so the message is never shown twice and never lost between screens.
 */
@Composable
fun SaidHere(store: HabitStore, snackbar: SnackbarHostState, behind: Boolean = false) {
    LaunchedEffect(snackbar, behind) {
        snapshotFlow { store.said }.collect { said ->
            if (said == null || said.behind != behind) return@collect
            store.said = null
            snackbar.currentSnackbarData?.dismiss()
            var undone = false
            try {
                undone = snackbar.showSnackbar(said.text,
                    actionLabel = if (said.undo != null) "Undo" else null, duration = SnackbarDuration.Short) == SnackbarResult.ActionPerformed
            } finally {
                if (undone) said.undo?.invoke() else said.then?.invoke()
            }
        }
    }
}

/** The one snackbar look: ink, with its action in the same colour as its words. */
@Composable
fun SaidHost(snackbar: SnackbarHostState, modifier: Modifier = Modifier, bottom: Int = 16) {
    SnackbarHost(snackbar, modifier.navigationBarsPadding().padding(start = 16.dp, end = 16.dp, bottom = bottom.dp)) { data ->
        Snackbar(data, containerColor = appColors.ink, contentColor = appColors.onInk, actionColor = appColors.onInk)
    }
}
