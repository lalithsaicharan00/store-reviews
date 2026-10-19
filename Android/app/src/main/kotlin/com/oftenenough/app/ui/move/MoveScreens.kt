package com.oftenenough.app.ui.move

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.ArrowBack
import androidx.compose.material.icons.outlined.Description
import androidx.compose.material.icons.outlined.Info
import androidx.compose.material.icons.outlined.SwapVert
import androidx.compose.material.icons.outlined.SyncProblem
import androidx.compose.material.icons.outlined.WifiOff
import androidx.compose.material.icons.rounded.History
import androidx.compose.material.icons.rounded.QrCodeScanner
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalView
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.backup.BackupCenter
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.move.MoveProtocol
import com.oftenenough.app.data.move.MoveReceiver
import com.oftenenough.app.data.move.MoveSender
import com.oftenenough.app.data.move.ReceiveState
import com.oftenenough.app.data.move.SendState
import com.oftenenough.app.ui.backup.countText
import com.oftenenough.app.ui.plus.CenterScreen
import com.oftenenough.app.ui.plus.FlowScreen
import com.oftenenough.app.ui.plus.InviteQr
import com.oftenenough.app.ui.plus.MainButton
import com.oftenenough.app.ui.plus.QuietButton
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors

// ==================================================================== Shared by the move, restore and coming back

/** A flow step's heading (coming back, Backup & Sync): Headline Medium Emphasized over a Body Large line, 8 apart. */
@Composable
fun StepHeading(title: String, lead: String?) {
    Column(Modifier.fillMaxWidth().padding(start = 8.dp, end = 8.dp, bottom = 24.dp)) {
        Text(title, Modifier.semantics { heading() }, style = AppType.headlineMediumEmphasized, color = appColors.ink)
        if (lead != null) {
            Spacer(Modifier.height(8.dp))
            Text(lead, style = AppType.bodyLarge, color = appColors.secondary)
        }
    }
}

/** A tonal 40 circle with an icon (the rows' and cards' leading icon). */
@Composable
fun Disc(icon: ImageVector, size: androidx.compose.ui.unit.Dp = 40.dp) =
    Box(Modifier.size(size).clip(CircleShape).background(appColors.tonal), contentAlignment = Alignment.Center) {
        Icon(icon, null, Modifier.size(size * 0.55f), tint = appColors.ink)
    }

/** What a backup or a move holds: "31 habits, 929 logs" and where and when it's from (Figma 2.2, 4.3, 5.4, 6.1). */
@Composable
fun CountCard(habits: Int, logs: Int, line: String, icon: ImageVector = Icons.Rounded.History, tag: String = "count-card") {
    Row(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(appColors.surface).padding(horizontal = 16.dp, vertical = 20.dp)
        .semantics(mergeDescendants = true) { testTag = tag }, verticalAlignment = Alignment.CenterVertically) {
        Disc(icon)
        Spacer(Modifier.width(16.dp))
        Column {
            Text(countText(habits, logs), style = AppType.titleLarge, color = appColors.ink)
            Text(line, style = AppType.bodyMedium, color = appColors.secondary)
        }
    }
}

/** "From a Pixel 9 · today, 9:14 AM". */
fun fromLine(device: String, at: Long, store: HabitStore): String {
    val day = store.rules.calendarDayOf(at)
    val today = store.rules.calendarDayOf(System.currentTimeMillis())
    val whenWords = when (day) { today -> "today"; today - 1 -> "yesterday"; else -> DayWords.short(day) } + ", " + DayWords.clock(at)
    return "From a $device · $whenWords"
}

/** Numbered steps in one card (Figma 3, 5, 3.3): "1 Open Move to a new phone · On your old phone". */
@Composable
fun StepsCard(steps: List<Pair<String, String>>) {
    Column(Modifier.fillMaxWidth(), verticalArrangement = Arrangement.spacedBy(2.dp)) {
        steps.forEachIndexed { i, (title, line) ->
            Row(Modifier.fillMaxWidth().clip(com.oftenenough.app.ui.components.segmentShape(i, steps.size)).background(appColors.surface)
                .heightIn(min = 72.dp).padding(horizontal = 16.dp, vertical = 12.dp), verticalAlignment = Alignment.CenterVertically) {
                Box(Modifier.size(40.dp).clip(CircleShape).background(appColors.tonal), contentAlignment = Alignment.Center) {
                    Text("${i + 1}", style = AppType.titleMedium, color = appColors.ink)
                }
                Spacer(Modifier.width(16.dp))
                Column {
                    Text(title, style = AppType.titleMedium, color = appColors.ink)
                    Text(line, style = AppType.bodyMedium, color = appColors.secondary)
                }
            }
        }
    }
}

/** A fact said before a choice ("This replaces what's on this phone", Figma 4.1.1, 4.3.2): an icon, a title, the words. */
@Composable
fun FactRow(icon: ImageVector, title: String, text: String) {
    Row(Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 16.dp)) {
        Icon(icon, null, Modifier.size(24.dp), tint = appColors.ink)
        Spacer(Modifier.width(16.dp))
        Column {
            Text(title, style = AppType.labelLarge, color = appColors.ink)
            Spacer(Modifier.height(2.dp))
            Text(text, style = AppType.bodyMedium, color = appColors.secondary)
        }
    }
}

// ==================================================================== The old phone: Move to a new phone (Figma 3–3.3)

/**
 * Backup & Sync › Move to a new phone (Figma `1461:2`, 3): a QR code and its 6 digits for the new phone, a new one by
 * itself after a wrong try (3.3) or 10 minutes; then Sending your habits (3.1) and Your habits are on your new phone
 * (3.2). This phone keeps everything. The screen stays on while a code shows.
 */
@Composable
fun MoveToNewPhoneScreen(center: BackupCenter, onBack: () -> Unit) {
    val sender = remember { MoveSender(AppGraph.moveServer, AppGraph.moveHttp, { center.moveFile() }, AppGraph.scope) }
    val state by sender.state.collectAsState()
    var attempt by remember { mutableStateOf(0) }
    LaunchedEffect(attempt) { sender.start() }
    DisposableEffect(Unit) { onDispose { sender.cancel() } }
    val view = LocalView.current
    DisposableEffect(state is SendState.Showing) {
        view.keepScreenOn = state is SendState.Showing || state is SendState.Sending
        onDispose { view.keepScreenOn = false }
    }
    when (val s = state) {
        SendState.Sending -> CenterScreen("Sending your habits", "Keep both phones open", "Cancel", "move-sending", onQuiet = { sender.cancel(); onBack() })
        is SendState.Sent -> FlowScreen(onBack = onBack, tag = "move-sent", top = true, bottom = { MainButton("Done", "move-done", onClick = onBack) }) {
            StepHeading("Your habits are on your new phone.", "This phone keeps its own copy.")
            CountCard(s.habits, s.entries, "Sent just now")
        }
        is SendState.Failed -> if (s.stoppedHalfway) CenterScreen("The move stopped", "Nothing changed on either phone. Keep the app open on both, then try again.",
            "Cancel", "move-stopped", onBack, icon = Icons.Outlined.SyncProblem, main = "Try again", onMain = { attempt++ })
        else CenterScreen("Couldn’t connect", if (s.busy) "Too many phones are moving right now. Try again in a minute." else "Check your internet connection, then try again.",
            "Cancel", "move-offline", onBack, icon = Icons.Outlined.WifiOff, main = "Try again", onMain = { attempt++ })
        else -> MovePage(s as? SendState.Showing, onBack)
    }
}

@Composable
private fun MovePage(showing: SendState.Showing?, onBack: () -> Unit) {
    val c = appColors
    BackHandler(onBack = onBack)
    Column(Modifier.fillMaxSize().background(c.screen).statusBarsPadding().navigationBarsPadding().semantics { testTag = "move-page" }) {
        Row(Modifier.heightIn(min = 64.dp).padding(start = 4.dp), verticalAlignment = Alignment.CenterVertically) {
            IconButton(onBack, Modifier.semantics { testTag = "page-back" }) { Icon(Icons.AutoMirrored.Rounded.ArrowBack, "Back", tint = c.ink) }
            Text("Move to a new phone", style = AppType.titleLargeEmphasized, color = c.ink)
        }
        Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 16.dp)) {
            Spacer(Modifier.height(8.dp))
            Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(28.dp)).background(c.surface).padding(horizontal = 20.dp, vertical = 24.dp),
                horizontalAlignment = Alignment.CenterHorizontally) {
                Text("Scan this on your new phone", style = AppType.titleMedium, color = c.ink)
                Spacer(Modifier.height(16.dp))
                Box(Modifier.size(180.dp).semantics { testTag = "move-qr" }, contentAlignment = Alignment.Center) {
                    if (showing != null) InviteQr(MoveProtocol.qr(showing.code), 180.dp)
                    else CircularProgressIndicator(Modifier.size(32.dp), color = c.ink, strokeWidth = 3.dp)
                }
                Spacer(Modifier.height(16.dp))
                Text("Or type these 6 digits", style = AppType.bodyMedium, color = c.secondary)
                val digits = showing?.code?.let { it.take(3) + " " + it.drop(3) } ?: "––– –––"
                Text(digits, Modifier.semantics { testTag = "move-code"; contentDescription = showing?.code?.toList()?.joinToString(" ") ?: "Making a code" },
                    style = AppType.displaySmall, color = c.ink)
                Spacer(Modifier.height(12.dp))
                if (showing?.afterWrongTry == true) Text("Someone typed a wrong code. Here’s a new one.", Modifier.semantics { testTag = "move-new-code" },
                    style = AppType.bodyMedium, color = c.secondary, textAlign = TextAlign.Center)
                else Row(verticalAlignment = Alignment.CenterVertically) {
                    CircularProgressIndicator(Modifier.size(16.dp), color = c.secondary, strokeWidth = 2.dp)
                    Spacer(Modifier.width(8.dp))
                    Text("Waiting for your new phone", style = AppType.bodyMedium, color = c.secondary)
                }
            }
            Spacer(Modifier.height(24.dp))
            Text("On your new phone", Modifier.padding(start = 16.dp, bottom = 8.dp), style = AppType.labelLarge, color = c.secondary)
            StepsCard(listOf("Open Often Enough" to "Choose I’ve used it before", "Choose Your old phone" to "Then scan this code or type it"))
            Text("Keep this open until your new phone has everything. The code changes by itself after a wrong try, or after 10 minutes.",
                Modifier.padding(start = 16.dp, end = 16.dp, top = 8.dp, bottom = 24.dp), style = AppType.bodySmall, color = c.secondary)
        }
    }
}

// ==================================================================== The new phone: from your old phone

/** Where the new phone's move was started: coming back (5–5.4) or Backup & Sync › Restore (4.3–4.3.2). */
enum class MoveEntry { WELCOME, RESTORE }

/**
 * The new phone (Figma coming back 5–5.4; Backup & Sync 4.3–4.3.2): how it works, then Google's code scanner or the six
 * boxes, Getting your habits, and what came. [onReceived] gets the checked file; nothing on this phone changes here.
 */
@Composable
fun FromOldPhoneFlow(center: BackupCenter, entry: MoveEntry, onBack: () -> Unit, onReceived: (BackupCenter.Pending) -> Unit) {
    val context = LocalContext.current
    var step by rememberSaveable { mutableStateOf("intro") }
    var wrong by rememberSaveable { mutableStateOf(false) }
    val receiver = remember { MoveReceiver(AppGraph.moveServer, AppGraph.moveHttp, AppGraph.scope) }
    val state by receiver.state.collectAsState()
    DisposableEffect(Unit) { onDispose { receiver.cancel() } }
    fun go(code: String) { wrong = false; step = "getting"; receiver.start(code) }
    LaunchedEffect(state, step) {
        if (step != "getting") return@LaunchedEffect
        when (val s = state) {
            ReceiveState.WrongCode -> { wrong = true; step = "type" }
            ReceiveState.Stopped -> step = "stopped"
            is ReceiveState.Received -> {
                val pending = center.check(s.bytes)
                if (pending.check.problem == null) onReceived(pending) else step = "stopped"
            }
            else -> {}
        }
    }
    when (step) {
        "type" -> CodeScreen(wrong, onBack = { step = "intro"; wrong = false }, onCode = ::go)
        "getting" -> CenterScreen("Getting your habits", "Keep both phones open", "Cancel", "move-getting", onQuiet = { receiver.cancel(); step = "intro" })
        "stopped" -> CenterScreen("The move stopped", "Nothing changed on either phone. Keep the app open on both, then try again.", "Cancel", "move-stopped",
            onQuiet = onBack, icon = Icons.Outlined.SyncProblem, main = "Try again", onMain = { step = "intro" })
        else -> FlowScreen(onBack = onBack, tag = "move-from-old", top = true, bottom = {
            MainButton("Scan QR code", "move-scan", Icons.Rounded.QrCodeScanner, iconSize = 20.dp) {
                // Google's code scanner: its own camera screen, no camera permission for the app (D15).
                com.google.mlkit.vision.codescanner.GmsBarcodeScanning.getClient(context,
                    com.google.mlkit.vision.codescanner.GmsBarcodeScannerOptions.Builder()
                        .setBarcodeFormats(com.google.mlkit.vision.barcode.common.Barcode.FORMAT_QR_CODE).build())
                    .startScan()
                    .addOnSuccessListener { code -> MoveProtocol.fromQr(code.rawValue ?: "")?.let(::go) ?: run { wrong = true; step = "type" } }
            }
            QuietButton("Type instead", "move-type") { step = "type" }
        }) {
            StepHeading("From your old phone.", "Keep the app open on both phones.")
            StepsCard(listOf(
                "Open Move to a new phone" to if (entry == MoveEntry.RESTORE) "In Backup & Sync on your old phone" else "On your old phone",
                "Scan the QR code it shows" to "Or type its 6 digits",
            ))
        }
    }
}

/**
 * 5.2 · Type the code: six boxes on the number keypad; it checks itself on the sixth digit, so there's no button. 5.2.1:
 * the boxes empty again with "That code didn't work. Your old phone now shows a new one." (one guess per code, D15).
 */
@Composable
private fun CodeScreen(wrong: Boolean, onBack: () -> Unit, onCode: (String) -> Unit) {
    val c = appColors
    var digits by rememberSaveable(wrong) { mutableStateOf("") }
    val focus = remember { FocusRequester() }
    LaunchedEffect(Unit) { runCatching { focus.requestFocus() } }
    FlowScreen(onBack = onBack, tag = "move-type-code", top = true) {
        StepHeading("Type the code.", "The 6 digits on your old phone.")
        BasicTextField(digits, { typed ->
            val clean = typed.filter(Char::isDigit).take(MoveProtocol.CODE_LENGTH)
            digits = clean
            if (clean.length == MoveProtocol.CODE_LENGTH) onCode(clean)
        }, Modifier.fillMaxWidth().focusRequester(focus).semantics { testTag = "move-code-field"; contentDescription = "Code, 6 digits" },
            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number),
            decorationBox = { _ ->
                Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    for (i in 0 until MoveProtocol.CODE_LENGTH) {
                        val focused = i == digits.length.coerceAtMost(MoveProtocol.CODE_LENGTH - 1)
                        Box(Modifier.weight(1f).height(56.dp).clip(RoundedCornerShape(12.dp)).background(c.surface)
                            .border(if (focused) 2.dp else 1.dp, if (focused) c.ink else c.outline, RoundedCornerShape(12.dp)),
                            contentAlignment = Alignment.Center) {
                            Text(digits.getOrNull(i)?.toString() ?: "", style = AppType.headlineSmall, color = c.ink)
                        }
                    }
                }
            })
        Spacer(Modifier.height(12.dp))
        if (wrong) Row(Modifier.fillMaxWidth().padding(horizontal = 8.dp).semantics(mergeDescendants = true) { testTag = "move-wrong" }) {
            Icon(Icons.Outlined.Info, null, Modifier.size(16.dp).padding(top = 1.dp), tint = c.ink)
            Spacer(Modifier.width(6.dp))
            Text("That code didn’t work. Your old phone now shows a new one.", style = AppType.bodySmall, color = c.ink)
        } else Text("It checks itself when all 6 are in.", Modifier.padding(horizontal = 8.dp), style = AppType.bodySmall, color = c.secondary)
    }
}

/** 4.3.2 · Restore what it sent? (Backup & Sync): what came, and that it replaces this phone's habits, with Undo for 30 days. */
@Composable
fun RestoreWhatItSent(pending: BackupCenter.Pending, store: HabitStore, onRestore: () -> Unit, onCancel: () -> Unit) {
    val p = pending.check.preview ?: return
    FlowScreen(onBack = onCancel, tag = "move-restore-sent", top = true, bottom = {
        MainButton("Restore", "restore-confirm", onClick = onRestore)
        QuietButton("Cancel", "restore-cancel", onClick = onCancel)
    }) {
        StepHeading("Restore what it sent?", "From your old phone.")
        CountCard(p.fileHabits, p.fileEntries, fromLine(p.deviceName, p.createdAt, store), Icons.Outlined.Description)
        FactRow(Icons.Outlined.SwapVert, "This replaces what’s on this phone",
            "The ${countText(p.phoneHabits, p.phoneEntries)} on this phone now are replaced with what your old phone sent. You can undo it for 30 days.")
    }
}
