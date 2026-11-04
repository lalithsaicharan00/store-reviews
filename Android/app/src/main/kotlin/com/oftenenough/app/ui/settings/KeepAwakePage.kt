package com.oftenenough.app.ui.settings

import android.os.Build
import androidx.annotation.DrawableRes
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleEventObserver
import androidx.lifecycle.compose.LocalLifecycleOwner
import com.oftenenough.app.R
import com.oftenenough.app.app.reminders.Reminders
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.ButtonSize
import com.oftenenough.app.ui.newhabit.FormPage
import com.oftenenough.app.ui.theme.AppType

/**
 * **Keep Often Enough awake** (A109, the user, 3 Nov 2026): in one short paragraph, why battery needs to be
 * Unrestricted and what stops working without it; then how to set it, step by step, each step a drawing of the phone's own screen with what to tap marked
 * (real screenshots of the phone's settings, the user's call over D11, 3 Nov 2026). Stock Android first (Pixel, Motorola):
 * Android 14+ puts Unrestricted under Allow background usage, so four steps; before that it's on the first page. The
 * main action, Open settings, opens Often Enough's App battery usage page, the deepest page an app can open (no app can
 * open the one under it, and Android's one-tap question isn't for a habit app on Google Play). Opened from Today's
 * card, Keep reminders coming, the first widget, and the notification when battery stops being Unrestricted. It reads
 * battery again on each return, and once it's Unrestricted, [onDone].
 */
@Composable
fun KeepAwakePage(onBack: () -> Unit, onDone: () -> Unit) {
    val context = LocalContext.current
    val s = MaterialTheme.colorScheme
    var refresh by remember { mutableIntStateOf(0) }
    val lifecycle = LocalLifecycleOwner.current.lifecycle
    DisposableEffect(lifecycle) {
        val observer = LifecycleEventObserver { _, e -> if (e == Lifecycle.Event.ON_RESUME) refresh++ }
        lifecycle.addObserver(observer)
        onDispose { lifecycle.removeObserver(observer) }
    }
    val needed = remember(refresh) { Reminders.notUnrestricted(context) }
    // Set while this page was open (come back from Settings): done, back where it came from.
    val neededAtFirst = remember { Reminders.notUnrestricted(context) }
    LaunchedEffect(needed) { if (neededAtFirst && !needed) onDone() }

    FormPage("Keep Often Enough awake", onBack = onBack, ownBack = false, scrolls = false) {
        Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(top = 8.dp, bottom = 16.dp),
            verticalArrangement = Arrangement.spacedBy(24.dp)) {
            // One short paragraph, so How to set it is in view (the user, 3 Nov 2026: "it is occupying too much space").
            Text(
                if (needed) "Your phone can put Often Enough to sleep to save battery. Then reminders come late and widgets stop " +
                    "updating. Set battery to Unrestricted to keep it awake. It uses very little battery."
                else "Battery is Unrestricted, so Often Enough stays awake for your reminders and widgets.",
                Modifier.padding(horizontal = 16.dp).semantics { testTag = "keep-awake-lead" }, style = AppType.bodyLarge, color = s.onSurfaceVariant,
            )
            if (needed) {
                Column(verticalArrangement = Arrangement.spacedBy(20.dp)) {
                    Text("How to set it", Modifier.padding(horizontal = 16.dp).semantics { heading() }, style = AppType.labelLarge, color = s.primary)
                    Step(1, "Tap Open settings at the bottom of this page.")
                    if (Build.VERSION.SDK_INT >= 34 && Build.MANUFACTURER.equals("samsung", ignoreCase = true)) {
                        // One UI: the row's words open the three choices at once, with no switch between (Galaxy A57, One UI 8, 3 Nov 2026).
                        Step(2, "On Battery, tap the Allow background usage row: its words, not its switch.", R.drawable.keep_awake_samsung_step2)
                        Step(3, "Choose Unrestricted, then come back here.", R.drawable.keep_awake_samsung_step3)
                    } else if (Build.VERSION.SDK_INT >= 34) {
                        Step(2, "On App battery usage, tap the Allow background usage row: its words, not its switch.", R.drawable.keep_awake_step2)
                        Step(3, "Turn on Allow background usage.", R.drawable.keep_awake_step3)
                        Step(4, "Choose Unrestricted, then come back here.", R.drawable.keep_awake_step4)
                    } else {
                        Step(2, "On App battery usage, choose Unrestricted, then come back here.")
                    }
                    Text("These change only Often Enough. Other apps keep saving battery.", Modifier.padding(horizontal = 16.dp),
                        style = AppType.bodyMedium, color = s.onSurfaceVariant)
                }
            }
        }
        // The main action, at the bottom, always in reach.
        if (needed) AppButton("Open settings", { openSettingsPage(context, appBatteryPage(context)) }, Modifier.fillMaxWidth().padding(vertical = 12.dp),
            size = ButtonSize.Medium, tag = "keep-awake-open")
        else AppButton("Done", onBack, Modifier.fillMaxWidth().padding(vertical = 12.dp), size = ButtonSize.Medium, tag = "keep-awake-done")
    }
}

/**
 * A numbered step: its words, then, where the step has one, the phone's own screen with what to tap boxed in red and the
 * rest dimmed (the user, 3 Nov 2026: "use the real screenshots … red rectangles … remaining … less visible"; taken on a
 * Pixel, Android 16, the same pages on a Motorola; Samsung's own, on a Galaxy A57; a phone whose pages differ gets its own).
 */
@Composable
private fun Step(number: Int, words: String, @DrawableRes shot: Int? = null) {
    val s = MaterialTheme.colorScheme
    Column(Modifier.fillMaxWidth().semantics { testTag = "keep-awake-step-$number" }, verticalArrangement = Arrangement.spacedBy(12.dp)) {
        Row(Modifier.padding(horizontal = 16.dp), horizontalArrangement = Arrangement.spacedBy(12.dp)) {
            Box(Modifier.size(28.dp).clip(CircleShape).background(s.inverseSurface), contentAlignment = Alignment.Center) {
                Text("$number", style = AppType.labelLarge, color = s.inverseOnSurface)
            }
            Text(words, Modifier.weight(1f), style = AppType.bodyLarge, color = s.onSurface)
        }
        if (shot != null) Image(painterResource(shot), "The phone's settings for step $number, what to tap boxed in red",
            Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).border(1.dp, s.outlineVariant, RoundedCornerShape(24.dp)),
            contentScale = ContentScale.FillWidth)
    }
}
