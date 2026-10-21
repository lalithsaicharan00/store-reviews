package com.oftenenough.app.ui.plus

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import com.oftenenough.app.app.PlusOwned
import com.oftenenough.app.app.PlusStore
import com.oftenenough.app.app.backup.BackupCenter
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.newhabit.FormPage
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch

/** Where the Plus page's rows go. */
interface PlusNav {
    fun seePlus()
    fun restore()
    fun backup()
    fun back()
}

/**
 * ≡ › Plus (W6: what people want to see here is what they have, then what they can do). The state card first (Free, or
 * Plus is yours), then Backup, then the ways back to a Plus bought before. There are no accounts (D16, 21 Oct 2026):
 * Plus stays with the Google Play account that bought it, and support moves it by hand to an iPhone. [restoreFoundNothing]
 * is set by Restore from Google Play when Play found nothing (Figma 4.2, shown over this page).
 */
@Composable
fun PlusPage(
    store: HabitStore, plus: PlusStore, backup: BackupCenter, snackbar: SnackbarHostState, nav: PlusNav,
    restoreFoundNothing: Boolean = false, onRestoreDialogSeen: () -> Unit = {}, codes: com.oftenenough.app.app.PlusCodes? = null,
) {
    val scope = rememberCoroutineScope()
    val hasPlus = plus.owned != PlusOwned.NONE || codes?.redeemed == true
    var dialog by rememberSaveable { mutableStateOf<String?>(null) }
    val say: (String) -> Unit = { m -> scope.launch { snackbar.showSnackbar(m) } }
    LaunchedEffect(restoreFoundNothing) { if (restoreFoundNothing) { dialog = "no-plus"; onRestoreDialogSeen() } }

    FormPage("Plus", chip = null, onBack = nav::back) {
        Spacer(Modifier.height(8.dp))
        StateCard(hasPlus, fromCode = plus.owned == PlusOwned.NONE, store, onSeePlus = nav::seePlus)
        Spacer(Modifier.height(24.dp))
        Section("Backup", footer = "We never see your habits.") { BackupRow(backup, nav::backup) }
        if (!hasPlus) {
            Spacer(Modifier.height(24.dp))
            Section("Already have Plus?", footer = "Plus bought on this Google account also comes back by itself when you open the app.") {
                SegmentedList {
                    PlusRow("Restore from Google Play", 0, 2, "From this Google account", Symbols.Shop,
                        onClick = nav::restore, modifier = Modifier.semantics { testTag = "plus-restore" })
                    PlusRow("Redeem a code", 1, 2, "If you were given one", Symbols.Redeem,
                        onClick = { dialog = "code" }, modifier = Modifier.semantics { testTag = "plus-redeem" })
                }
            }
        }
        Spacer(Modifier.height(8.dp))
    }

    when (dialog) {
        "code" -> RedeemCodeDialog({ code -> codes?.redeem(code) == true }, onDone = { dialog = null; say("Plus is on. Thank you.") }) { dialog = null }
        "no-plus" -> PlusDialog(Symbols.SearchOff, "No Plus found", "Nothing was bought with this Google account. Bought Plus on an iPhone? Write to us at ${com.oftenenough.app.ui.settings.Support.EMAIL} and we’ll move it across.",
            "OK", { dialog = null }, { dialog = null }, dismiss = "", tag = "dialog-no-plus")
    }
}

/** The state card: what you have, and the one thing to do next. */
@Composable
private fun StateCard(hasPlus: Boolean, fromCode: Boolean, store: HabitStore, onSeePlus: () -> Unit) {
    val c = appColors
    WhiteCard(Modifier.semantics { testTag = if (hasPlus) "plus-state-plus" else "plus-state-free" }) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            AppIconTile(56.dp, flat = true)
            Spacer(Modifier.width(16.dp))
            Column(Modifier.weight(1f).semantics(mergeDescendants = true) { heading() }, verticalArrangement = Arrangement.spacedBy(2.dp)) {
                Text(if (hasPlus) "Plus is yours" else "Free", style = AppType.title20Emphasized, color = c.ink)
                Text(when {
                    !hasPlus -> "No sign-in needed"
                    fromCode -> "From a code"
                    else -> "Bought with this Google account"
                }, style = AppType.bodyMedium, color = c.secondary)
            }
        }
        if (hasPlus) Text("Plus stays with the Google account that bought it and comes back on any Android phone signed in to it. Moving to an iPhone? Write to us and we’ll move it across.",
            style = AppType.bodyMedium, color = c.secondary)
        else FreeBox(store, onSeePlus)
    }
}

/** Free: how many of the free habits are used, what Plus adds, and the way to it. */
@Composable
private fun FreeBox(store: HabitStore, onSeePlus: () -> Unit) {
    val c = appColors
    val used = store.activeHabitCount
    val limit = HabitStore.FREE_HABIT_LIMIT
    Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(20.dp)).background(c.screen).padding(16.dp), verticalArrangement = Arrangement.spacedBy(12.dp)) {
        Column(Modifier.semantics(mergeDescendants = true) { testTag = "plus-used" }, verticalArrangement = Arrangement.spacedBy(10.dp)) {
            Row {
                Text("$used of $limit free habits used", Modifier.weight(1f), style = AppType.labelLarge, color = c.ink)
                Text(maxOf(0, limit - used).let { if (it == 0) "None left" else "$it left" }, style = AppType.bodyMedium, color = c.secondary)
            }
            LinearProgressIndicator({ minOf(1f, used / limit.toFloat()) }, Modifier.fillMaxWidth().height(6.dp),
                color = c.ink, trackColor = c.tonal.let { if (c.dark) it else androidx.compose.ui.graphics.Color(0xFFD9D9DE) },
                strokeCap = StrokeCap.Round, gapSize = 0.dp, drawStopIndicator = {})
        }
        Text("Plus gives you unlimited habits, sync across all your devices and more widgets. One payment, yours forever.", style = AppType.bodyMedium, color = c.secondary)
        Button(onSeePlus, Modifier.heightIn(min = 40.dp).semantics { testTag = "plus-see" },
            colors = ButtonDefaults.buttonColors(containerColor = c.ink, contentColor = c.onInk),
            contentPadding = androidx.compose.foundation.layout.PaddingValues(start = 24.dp, end = 16.dp, top = 10.dp, bottom = 10.dp)) {
            Text("See what’s in Plus", style = AppType.labelLarge)
            Spacer(Modifier.width(8.dp))
            Icon(Symbols.ArrowForward, null, Modifier.size(18.dp))
        }
    }
}

/**
 * The Backup row: where the habits are kept, or that they aren't yet (Figma 1.1: the button, under the words, opens
 * Backup & Sync's own flow).
 */
@Composable
private fun BackupRow(backup: BackupCenter, onOpen: () -> Unit) {
    val c = appColors
    val email = backup.link.accountName?.let { n -> Regex("\\((.+)\\)").find(n)?.groupValues?.get(1) ?: n }
    if (email != null) SegmentedList {
        PlusRow("Backed up to Google Drive", 0, 1, email, Symbols.AddToDrive, onClick = onOpen,
            modifier = Modifier.semantics { testTag = "plus-backup" })
    } else Row(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.surface).heightIn(min = 72.dp).padding(16.dp)
        .semantics { testTag = "plus-not-backed-up" }, verticalAlignment = Alignment.Top, horizontalArrangement = Arrangement.spacedBy(16.dp)) {
        IconDisc(Symbols.CloudOff)
        Column(Modifier.weight(1f), verticalArrangement = Arrangement.spacedBy(2.dp)) {
            Text("Not backed up", style = AppType.titleMedium, color = c.ink)
            Text("Only on this phone for now", style = AppType.bodyMedium, color = c.secondary)
            Box(Modifier.padding(top = 12.dp)) { PlusTonalButton("Back up to Google Drive", Symbols.AddToDrive, "plus-back-up", onOpen) }
        }
    }
}

/** A labelled group: "Backup", "Already have Plus?"; an optional footer under it. */
@Composable
private fun Section(label: String, footer: String? = null, content: @Composable () -> Unit) {
    val c = appColors
    Column(Modifier.fillMaxWidth(), verticalArrangement = Arrangement.spacedBy(8.dp)) {
        Text(label, Modifier.padding(start = 16.dp).semantics { heading() }, style = AppType.labelLarge, color = c.secondary)
        content()
        if (footer != null) Text(footer, Modifier.padding(horizontal = 16.dp), style = AppType.bodySmall, color = c.secondary)
    }
}

/** Redeem a code: type it, and Plus turns on when it's one of ours; a wrong code says so and keeps what was typed. */
@Composable
private fun RedeemCodeDialog(redeem: (String) -> Boolean, onDone: () -> Unit, onDismiss: () -> Unit) {
    val c = appColors
    var code by rememberSaveable { mutableStateOf("") }
    var wrong by rememberSaveable { mutableStateOf(false) }
    val submit = { if (redeem(code)) onDone() else wrong = true }
    // Not in Figma 1476:2 (added for Play's reviewers, 15 Oct 2026): drawn as its dialogs are (7.x).
    PlusDialogFrame(Symbols.Redeem, "Redeem a code", "dialog-code", onDismiss, actions = {
        DialogButton("Cancel", "dialog-code-dismiss", onClick = onDismiss)
        DialogButton("Redeem", "dialog-code-confirm", enabled = code.isNotBlank(), onClick = submit)
    }) {
        Text("A code turns on Plus on this phone.", style = AppType.bodyMedium, color = c.secondary)
        androidx.compose.material3.OutlinedTextField(code, { code = it.take(40); wrong = false }, Modifier.fillMaxWidth().semantics { testTag = "code-field" },
            textStyle = AppType.bodyLarge, singleLine = true, label = { Text("Code", style = AppType.bodySmall) },
            isError = wrong, supportingText = if (wrong) ({ Text("That code doesn’t work. Check it and try again.", style = AppType.bodySmall) }) else null,
            keyboardOptions = androidx.compose.foundation.text.KeyboardOptions(capitalization = androidx.compose.ui.text.input.KeyboardCapitalization.Characters,
                autoCorrectEnabled = false, imeAction = androidx.compose.ui.text.input.ImeAction.Done),
            keyboardActions = androidx.compose.foundation.text.KeyboardActions(onDone = { if (code.isNotBlank()) submit() }))
    }
}
