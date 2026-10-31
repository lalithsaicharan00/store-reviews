package com.oftenenough.app.ui.components

import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.ExperimentalComposeUiApi
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.DialogProperties

/**
 * 5.3.4, **Dialog** (Figma 702:618; Components — Atoms Build Plan): Material's alert dialog, one question, one line of
 * what follows, two text actions.
 *
 * Material's `AlertDialog` as it is, 312 wide on a 360 phone (the width less 24 each side, 280–560): corners 28, 24 in all round, 16 under the [title] (Headline Small, On surface),
 * 24 under the [text] (Body Medium, On surface variant), the actions at the end, 8 apart. On Surface bright, as Figma
 * fills it (Material's own is Surface container high, darker than our page). The actions are Small Text [AppButton]s:
 * [dismiss] (none for a dialog with one answer) then [confirm]; both On surface variant (Figma's Default: Keep editing
 * / Discard), or, [destructive], the confirm in Error (Figma's Destructive: Cancel / Delete; D9: Delete is red
 * everywhere). Two choices at most (D9). Its own window: tags work for UI Automator too.
 */
@OptIn(ExperimentalComposeUiApi::class)
@Composable
fun AppDialog(
    title: String,
    text: String?,
    confirm: String,
    onConfirm: () -> Unit,
    onDismiss: () -> Unit,
    modifier: Modifier = Modifier,
    dismiss: String? = "Cancel",
    destructive: Boolean = false,
    confirmTag: String? = null,
    dismissTag: String? = null,
    onDismissButton: () -> Unit = onDismiss,
) {
    val s = MaterialTheme.colorScheme
    AlertDialog(
        onDismissRequest = onDismiss,
        confirmButton = { AppButton(confirm, onConfirm, style = ButtonStyle.Text, destructive = destructive, tag = confirmTag) },
        // The screen's width less 24 each side (Figma's 312 on a 360 phone); Material keeps it within 280–560.
        modifier = modifier.padding(horizontal = 24.dp).fillMaxWidth().semantics { testTagsAsResourceId = true },
        dismissButton = dismiss?.let { { AppButton(it, onDismissButton, style = ButtonStyle.Text, tag = dismissTag) } },
        title = { Text(title) },
        text = text?.let { { Text(it) } },
        containerColor = s.surfaceBright,
        titleContentColor = s.onSurface,
        textContentColor = s.onSurfaceVariant,
        properties = DialogProperties(usePlatformDefaultWidth = false),
    )
}
