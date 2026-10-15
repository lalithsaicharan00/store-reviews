package com.oftenenough.app.ui.settings

import com.oftenenough.app.ui.theme.AppType

import androidx.activity.compose.BackHandler
import androidx.biometric.BiometricManager.Authenticators.BIOMETRIC_WEAK
import androidx.biometric.BiometricManager.Authenticators.DEVICE_CREDENTIAL
import androidx.biometric.BiometricPrompt
import androidx.compose.animation.core.Animatable
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.outlined.Backspace
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowRight
import androidx.compose.material.icons.outlined.BugReport
import androidx.compose.material.icons.outlined.Lock
import androidx.compose.material.icons.outlined.QueryStats
import androidx.compose.material.icons.outlined.Timer
import androidx.compose.material.icons.outlined.VisibilityOff
import androidx.compose.material.icons.rounded.Lock
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.clip
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.content.ContextCompat
import androidx.fragment.app.FragmentActivity
import com.oftenenough.app.app.AppLock
import com.oftenenough.app.app.Prefs
import com.oftenenough.app.ui.components.CookieShape
import com.oftenenough.app.ui.components.InkButton
import com.oftenenough.app.ui.components.PlainButton
import com.oftenenough.app.ui.components.Segment
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.newhabit.FormPage
import com.oftenenough.app.ui.newhabit.GroupTitle
import com.oftenenough.app.ui.newhabit.InkSwitch
import com.oftenenough.app.ui.newhabit.MenuPill
import com.oftenenough.app.ui.newhabit.Note
import com.oftenenough.app.ui.newhabit.RadioRow
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

// ------------------------------------------------------------------ Android's own prompt (BiometricPrompt)

/**
 * Asks for the phone's own lock: fingerprint, face, PIN, pattern or password, whichever Android chooses to show. [onDone]
 * gets true once it's confirmed. The app's activity is a FragmentActivity for this.
 */
fun askPhoneLock(activity: FragmentActivity, title: String, subtitle: String, onDone: (Boolean) -> Unit) {
    val prompt = BiometricPrompt(activity, ContextCompat.getMainExecutor(activity), object : BiometricPrompt.AuthenticationCallback() {
        override fun onAuthenticationSucceeded(result: BiometricPrompt.AuthenticationResult) = onDone(true)
        override fun onAuthenticationError(errorCode: Int, errString: CharSequence) = onDone(false)
    })
    val info = BiometricPrompt.PromptInfo.Builder().setTitle(title).setSubtitle(subtitle)
        // Fingerprint or face, or the screen lock (Android offers "Use screen lock"); no app Cancel is allowed with it.
        .setAllowedAuthenticators(BIOMETRIC_WEAK or DEVICE_CREDENTIAL)
        .build()
    try { prompt.authenticate(info) } catch (e: Exception) { onDone(false) }
}

// ------------------------------------------------------------------ ≡ › Privacy & Security

/** ≡ › Privacy & Security (design §19): App lock, Hide names outside the app, and what is (and isn't) sent. */
@Composable
fun PrivacyPage(prefs: Prefs, lock: AppLock, onAppLock: () -> Unit, onBack: () -> Unit) {
    val c = appColors
    FormPage("Privacy & Security", chip = null, onBack = onBack) {
        Spacer(Modifier.height(8.dp))
        SegmentedList {
            Segment(0, 1, Modifier.semantics { testTag = "privacy-app-lock" }, onClick = onAppLock) {
                Icon(Icons.Outlined.Lock, null, tint = c.ink)
                Spacer(Modifier.width(24.dp))
                Column(Modifier.weight(1f).padding(vertical = 4.dp)) {
                    Text("App lock", style = MaterialTheme.typography.bodyLarge, color = c.ink)
                    Text("Lock the app with your fingerprint, face or a passcode", style = MaterialTheme.typography.bodyMedium, color = c.secondary)
                }
                Spacer(Modifier.width(8.dp))
                Text(if (lock.isOn) "On" else "Off", style = MaterialTheme.typography.bodyLarge, color = c.secondary)
                Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = c.secondary)
            }
        }
        GroupTitle("Outside the app")
        SegmentedList {
            // Always on while App lock is on: what's locked inside isn't shown outside.
            val on = prefs.hideNames || lock.isOn
            Segment(0, 1, Modifier.semantics { testTag = "privacy-hide-names" }, onClick = if (lock.isOn) null else ({ prefs.hideNames = !prefs.hideNames })) {
                Icon(Icons.Outlined.VisibilityOff, null, tint = c.ink)
                Spacer(Modifier.width(24.dp))
                Text("Hide names outside the app", Modifier.weight(1f), style = MaterialTheme.typography.bodyLarge, color = c.ink)
                Box(Modifier.alpha(if (lock.isOn) 0.5f else 1f)) { InkSwitch(on) }
            }
        }
        Note("Widgets, reminders, alarms and the running timer show icons and numbers instead of habit names." +
            if (lock.isOn) " It's always on while App lock is on." else "")
        GroupTitle("Help improve the app")
        SegmentedList {
            Unavailable(Icons.Outlined.QueryStats, "Share usage", 0, 2)
            Unavailable(Icons.Outlined.BugReport, "Share crash diagnostics", 1, 2)
        }
        Note("Nothing about how you use the app is sent: there's nothing to share yet. If sharing comes, it will be off until you turn it on, and habit and task names, notes, goals and logged values will never be sent.")
        Note("No ads. No account. Your habits stay on your phone and in your own Google Drive; we never see them.")
        Spacer(Modifier.height(24.dp))
    }
}

@Composable
private fun Unavailable(icon: androidx.compose.ui.graphics.vector.ImageVector, title: String, index: Int, count: Int) {
    Segment(index, count, Modifier.alpha(0.5f)) {
        Icon(icon, null, tint = appColors.ink)
        Spacer(Modifier.width(24.dp))
        Column(Modifier.weight(1f).padding(vertical = 4.dp)) {
            Text(title, style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
            Text("Not available yet", style = MaterialTheme.typography.bodyMedium, color = appColors.secondary)
        }
        InkSwitch(false)
    }
}

// ------------------------------------------------------------------ App lock

/** App lock: off (the switch and what it does), or on (Unlock with, Lock again). */
@Composable
fun AppLockPage(lock: AppLock, onSetUp: () -> Unit, onNewPasscode: () -> Unit, onBack: () -> Unit) {
    val c = appColors
    val context = LocalContext.current
    val activity = androidx.activity.compose.LocalActivity.current as? FragmentActivity
    var confirmOff by remember { mutableStateOf(false) }
    var problem by remember { mutableStateOf<String?>(null) }
    FormPage("App lock", chip = null, onBack = onBack) {
        Spacer(Modifier.height(8.dp))
        SegmentedList {
            Segment(0, 1, Modifier.semantics { testTag = "app-lock-switch" }, onClick = { if (lock.isOn) confirmOff = true else onSetUp() }) {
                Icon(Icons.Outlined.Lock, null, tint = c.ink)
                Spacer(Modifier.width(24.dp))
                Text("App lock", Modifier.weight(1f), style = MaterialTheme.typography.bodyLarge, color = c.ink)
                InkSwitch(lock.isOn)
            }
        }
        if (!lock.isOn) {
            Note("Ask for your fingerprint, face, screen lock or an app passcode each time you open the app. Widgets and reminders keep working, without habit names.")
        } else {
            Note("Widgets and reminders keep working, without habit names.")
            GroupTitle("Unlock with")
            val secure = AppLock.phoneIsSecure(context)
            SegmentedList {
                RadioRow("Your phone's lock", lock.method == AppLock.Method.PHONE, 0, 2, "unlock-phone",
                    if (secure) "Fingerprint, face, PIN or pattern" else "This phone has no screen lock") {
                    if (lock.method == AppLock.Method.PHONE) return@RadioRow
                    if (!secure || activity == null) { problem = "Set a screen lock in the phone's Settings first."; return@RadioRow }
                    askPhoneLock(activity, "Use your phone's lock", "Unlock Often Enough the way you unlock this phone") { ok -> if (ok) lock.turnOnWithPhone() }
                }
                RadioRow("An app passcode", lock.method == AppLock.Method.PASSCODE, 1, 2, "unlock-passcode", "Six digits") {
                    if (lock.method != AppLock.Method.PASSCODE) onNewPasscode()
                }
            }
            if (lock.method == AppLock.Method.PASSCODE) {
                Spacer(Modifier.height(8.dp))
                SegmentedList {
                    Segment(0, 1, Modifier.semantics { testTag = "change-passcode" }, onClick = onNewPasscode) {
                        Text("Change app passcode", Modifier.weight(1f), style = MaterialTheme.typography.bodyLarge, color = c.ink)
                        Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = c.secondary)
                    }
                }
            }
            Spacer(Modifier.height(16.dp))
            SegmentedList {
                Segment(0, 1) {
                    Icon(Icons.Outlined.Timer, null, tint = c.ink)
                    Spacer(Modifier.width(24.dp))
                    Column(Modifier.weight(1f).padding(vertical = 4.dp)) {
                        Text("Lock again", style = MaterialTheme.typography.bodyLarge, color = c.ink)
                    }
                    val options = AppLock.Again.entries
                    MenuPill(lock.again.words, options.map { it.words }, "lock-again") { lock.chooseAgain(options[it]) }
                }
            }
            Note("Locking your phone always locks the app at once.")
        }
    }
    if (confirmOff) {
        AlertDialog({ confirmOff = false }, title = { Text("Turn off App lock?") },
            text = { Text("The app opens without asking. Your habits stay as they are.") },
            confirmButton = { TextButton({
                confirmOff = false
                // Only the person who can unlock may turn it off.
                if (lock.method == AppLock.Method.PHONE && activity != null) askPhoneLock(activity, "Turn off App lock", "Confirm it's you") { ok -> if (ok) lock.turnOff() }
                else lock.turnOff()
            }, Modifier.semantics { testTag = "app-lock-off-confirm" }) { Text("Turn off", color = c.ink) } },
            dismissButton = { TextButton({ confirmOff = false }) { Text("Cancel", color = c.ink) } })
    }
    problem?.let { p ->
        AlertDialog({ problem = null }, title = { Text("No screen lock") }, text = { Text(p) },
            confirmButton = { TextButton({ problem = null }) { Text("OK", color = c.ink) } })
    }
}

/**
 * Set up app lock: "How do you want to unlock Often Enough?" → the phone's lock (Android's prompt confirms it works) or
 * an app passcode (create, then confirm). [passcodeOnly] skips the question (Change app passcode, Forgot passcode).
 */
@Composable
fun AppLockSetup(lock: AppLock, passcodeOnly: Boolean, onDone: () -> Unit) {
    val context = LocalContext.current
    val activity = androidx.activity.compose.LocalActivity.current as? FragmentActivity
    val secure = AppLock.phoneIsSecure(context)
    var step by rememberSaveable { mutableStateOf(if (passcodeOnly) "create" else "choose") }
    var choice by rememberSaveable { mutableStateOf(if (secure) "phone" else "passcode") }
    var first by rememberSaveable { mutableStateOf("") }
    var message by remember { mutableStateOf<String?>(null) }
    val back: () -> Unit = {
        when (step) {
            "confirm" -> { step = "create"; first = ""; message = null }
            "create" -> if (passcodeOnly) onDone() else step = "choose"
            else -> onDone()
        }
    }
    when (step) {
        "choose" -> Box(Modifier.fillMaxSize().background(appColors.screen)) {
            FormPage("Set up app lock", chip = null, onBack = onDone, close = true) {
                Text("How do you want to unlock Often Enough?", Modifier.padding(start = 16.dp, end = 16.dp, top = 8.dp, bottom = 24.dp),
                    style = AppType.headlineMedium, color = appColors.ink)
                SegmentedList {
                    RadioRow("Your phone's lock", choice == "phone", 0, 2, "setup-phone",
                        if (secure) "Fingerprint, face, PIN or pattern: whatever unlocks this phone. Android chooses which to show."
                        else "This phone has no screen lock. Set one in the phone's Settings to use it here.") { if (secure) choice = "phone" }
                    RadioRow("An app passcode", choice == "passcode", 1, 2, "setup-passcode",
                        "Six digits, just for this app. Good if people around you know your phone's PIN.") { choice = "passcode" }
                }
                Note("You can change this later in App lock. Your habits are never deleted, whatever happens.")
                Spacer(Modifier.height(96.dp))
            }
            InkButton("Continue", {
                if (choice == "passcode") step = "create"
                else if (activity != null) askPhoneLock(activity, "Unlock Often Enough", "Use your fingerprint or screen lock") { ok ->
                    if (ok) { lock.turnOnWithPhone(); onDone() }
                }
            }, Modifier.align(Alignment.BottomCenter).fillMaxWidth().navigationBarsPadding().padding(16.dp).semantics { testTag = "setup-continue" })
        }
        "create" -> PasscodePage("Set up app lock", "Create an app passcode", "Six digits. You'll use it to open the app.", message, 0, back) { code ->
            first = code; message = null; step = "confirm"
        }
        else -> PasscodePage("Set up app lock", "Confirm the app passcode", "Type it once more.", message, if (message != null) 1 else 0, back) { code ->
            if (code == first) {
                lock.turnOnWithPasscode(code)
                onDone()
            } else { first = ""; step = "create"; message = "Those didn't match. Create it again." }
        }
    }
}

/** A page with the six dots and the keypad (create and confirm). */
@Composable
private fun PasscodePage(title: String, heading: String, line: String, message: String?, shake: Int, onBack: () -> Unit, onCode: (String) -> Unit) {
    BackHandler(onBack = onBack)
    FormPage(title, chip = null, onBack = onBack, scrolls = false) {
        Keypad(heading, message ?: line, message != null, shake, onCode = onCode)
    }
}

/** Six dots, the digits 0–9 and delete; a sixth digit hands over the code. */
@Composable
fun Keypad(heading: String, line: String?, lineIsProblem: Boolean, shake: Int, enabled: Boolean = true, footer: (@Composable () -> Unit)? = null, onCode: (String) -> Unit) {
    val c = appColors
    var code by remember { mutableStateOf("") }
    val offset = remember { Animatable(0f) }
    LaunchedEffect(shake) {
        if (shake > 0) { code = ""; for (x in listOf(12f, -12f, 8f, -8f, 0f)) offset.animateTo(x) }
    }
    Column(Modifier.fillMaxWidth().verticalScroll(rememberScrollState()).padding(vertical = 24.dp), horizontalAlignment = Alignment.CenterHorizontally) {
        Box(Modifier.size(72.dp).clip(CookieShape()).background(c.ink), contentAlignment = Alignment.Center) {
            Icon(Icons.Rounded.Lock, null, tint = c.onInk, modifier = Modifier.size(32.dp))
        }
        Spacer(Modifier.height(24.dp))
        Text(heading, style = AppType.headlineSmall, color = c.ink, textAlign = TextAlign.Center)
        if (line != null) {
            Spacer(Modifier.height(12.dp))
            Text(line, Modifier.padding(horizontal = 24.dp).semantics { testTag = "keypad-line" }, style = MaterialTheme.typography.bodyMedium,
                color = if (lineIsProblem) c.ink else c.secondary, textAlign = TextAlign.Center)
        }
        Spacer(Modifier.height(24.dp))
        Row(Modifier.offset(x = offset.value.dp).semantics { contentDescription = "${code.length} of 6 digits" }, horizontalArrangement = Arrangement.spacedBy(16.dp)) {
            repeat(6) { i ->
                Box(Modifier.size(16.dp).clip(CircleShape).let { m -> if (i < code.length) m.background(c.ink) else m.border(2.dp, c.secondary, CircleShape) })
            }
        }
        Spacer(Modifier.height(32.dp))
        val keys = listOf("1", "2", "3", "4", "5", "6", "7", "8", "9", "", "0", "⌫")
        for (row in keys.chunked(3)) {
            Row(horizontalArrangement = Arrangement.spacedBy(24.dp)) {
                for (k in row) {
                    Box(Modifier.size(72.dp).clip(CircleShape).let { m ->
                        when {
                            k.isEmpty() -> m
                            k == "⌫" -> m.clickable(enabled = enabled && code.isNotEmpty()) { code = code.dropLast(1) }.semantics { contentDescription = "Delete" }
                            else -> m.background(c.tonal).clickable(enabled = enabled) {
                                if (code.length < 6) code += k
                                if (code.length == 6) { val done = code; code = ""; onCode(done) }
                            }.semantics { testTag = "key-$k" }
                        }
                    }, contentAlignment = Alignment.Center) {
                        if (k == "⌫") Icon(Icons.AutoMirrored.Outlined.Backspace, null, tint = c.ink)
                        else if (k.isNotEmpty()) Text(k, style = MaterialTheme.typography.headlineMedium, color = c.ink)
                    }
                }
            }
            Spacer(Modifier.height(16.dp))
        }
        footer?.invoke()
    }
}

// ------------------------------------------------------------------ The lock over the app

/**
 * Shown over everything while the app is locked: the phone's lock asks at once (Android's prompt over "Often Enough is
 * locked"), or the app passcode's keypad with Forgot app passcode?.
 */
@Composable
fun LockScreen(lock: AppLock) {
    val c = appColors
    val context = LocalContext.current
    val activity = androidx.activity.compose.LocalActivity.current as? FragmentActivity
    val scope = rememberCoroutineScope()
    var message by remember { mutableStateOf<String?>(null) }
    var forgot by remember { mutableStateOf(false) }
    var newCode by rememberSaveable { mutableStateOf(false) }
    var checking by remember { mutableStateOf(false) }
    BackHandler { activity?.moveTaskToBack(true) }
    if (newCode) {
        // The phone's own lock (or the 24-hour reset) confirmed it: choose a new passcode, then the app opens.
        AppLockSetup(lock, passcodeOnly = true) { newCode = false; if (lock.hasPasscode) lock.opened() }
        return
    }
    Box(Modifier.fillMaxSize().background(c.screen).statusBarsPadding().navigationBarsPadding().semantics { testTag = "lock-screen" }) {
        if (lock.method == AppLock.Method.PHONE) {
            val ask = { if (activity != null) askPhoneLock(activity, "Unlock Often Enough", "Use your fingerprint or screen lock") { ok -> if (ok) lock.opened() } }
            LaunchedEffect(Unit) { ask() }
            Column(Modifier.align(Alignment.Center).padding(24.dp), horizontalAlignment = Alignment.CenterHorizontally) {
                Box(Modifier.size(96.dp).clip(CookieShape()).background(c.ink), contentAlignment = Alignment.Center) {
                    Icon(Icons.Rounded.Lock, null, tint = c.onInk, modifier = Modifier.size(40.dp))
                }
                Spacer(Modifier.height(32.dp))
                Text("Often Enough is locked", style = MaterialTheme.typography.headlineMedium, color = c.ink, textAlign = TextAlign.Center)
                Spacer(Modifier.height(24.dp))
                InkButton("Unlock", ask, Modifier.semantics { testTag = "lock-unlock" })
            }
        } else {
            val reset = lock.resetLeft(context)
            Keypad("Enter app passcode", lock.waitText() ?: message ?: reset?.let { resetWords(it) }, message != null, lock.wrongCount, enabled = !checking,
                footer = { PlainButton("Forgot app passcode?", { forgot = true }, Modifier.semantics { testTag = "lock-forgot" }) }) { code ->
                checking = true
                scope.launch {
                    // PBKDF2 off the main thread (S16).
                    message = withContext(Dispatchers.Default) { lock.enter(code) }
                    checking = false
                }
            }
        }
    }
    if (forgot) {
        val secure = AppLock.phoneIsSecure(context)
        val left = lock.resetLeft(context)
        AlertDialog({ forgot = false }, title = { Text("Forgot app passcode?") },
            text = {
                Text(when {
                    left == 0L -> "The 24 hours are up: choose a new app passcode."
                    secure -> "Unlock with this phone's screen lock, then choose a new app passcode. Your habits stay as they are."
                    left != null -> resetWords(left) + " Entering your app passcode before then cancels it."
                    else -> "This phone has no screen lock, so a new passcode can be chosen after 24 hours. Entering your app passcode before then cancels the reset. Your habits stay as they are."
                })
            },
            confirmButton = {
                TextButton({
                    forgot = false
                    when {
                        left == 0L -> newCode = true
                        secure && activity != null -> askPhoneLock(activity, "Choose a new app passcode", "Use your fingerprint or screen lock") { ok -> if (ok) newCode = true }
                        left == null -> lock.startReset(context)
                    }
                }, Modifier.semantics { testTag = "lock-forgot-go" }) {
                    Text(when { left == 0L -> "Choose a new passcode"; secure -> "Use screen lock"; left == null -> "Start 24-hour reset"; else -> "OK" }, color = c.ink)
                }
            },
            dismissButton = { if (left != 0L) TextButton({ forgot = false }) { Text("Cancel", color = c.ink) } })
    }
}

/** "A new passcode can be chosen in 23 hours." */
fun resetWords(left: Long): String {
    if (left <= 0) return "The 24 hours are up: tap Forgot app passcode? to choose a new one."
    val hours = ((left + 3_599_999) / 3_600_000).toInt()
    return if (hours <= 1) "A new passcode can be chosen within the hour." else "A new passcode can be chosen in $hours hours."
}
