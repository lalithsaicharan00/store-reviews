package com.oftenenough.app.ui.settings

import com.oftenenough.app.ui.theme.AppType

import android.content.ActivityNotFoundException
import android.content.ClipData
import android.content.Intent
import android.net.Uri
import android.os.Build
import androidx.compose.animation.animateContentSize
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
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
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowRight
import androidx.compose.material.icons.outlined.Email
import androidx.compose.material.icons.rounded.Close
import androidx.compose.material.icons.rounded.ExpandLess
import androidx.compose.material.icons.rounded.ExpandMore
import androidx.compose.material.icons.rounded.Search
import androidx.compose.material.icons.rounded.WavingHand
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.platform.LocalClipboard
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.toClipEntry
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.stateDescription
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.oftenenough.app.BuildConfig
import com.oftenenough.app.R
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.components.ListRow
import com.oftenenough.app.ui.components.Segment
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.newhabit.FormPage
import com.oftenenough.app.ui.newhabit.GroupTitle
import com.oftenenough.app.ui.newhabit.Note
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch

// ------------------------------------------------------------------ Help & Feedback

/** Where people write to us, and what the email starts with: the app and Android versions, never their habits. */
object Support {
    const val EMAIL = "support@oftenenough.com"
    val appVersion: String get() = "${BuildConfig.VERSION_NAME} (${BuildConfig.VERSION_CODE})"

    fun mail(): Intent = Intent(Intent.ACTION_SENDTO, Uri.parse("mailto:")).apply {
        putExtra(Intent.EXTRA_EMAIL, arrayOf(EMAIL))
        putExtra(Intent.EXTRA_SUBJECT, "Often Enough $appVersion")
        putExtra(Intent.EXTRA_TEXT, "\n\n\n—\nOften Enough $appVersion · ${Build.MANUFACTURER} ${Build.MODEL} · Android ${Build.VERSION.RELEASE}")
    }
}

data class HelpTopic(val question: String, val answer: String)
data class HelpSection(val title: String, val topics: List<HelpTopic>)

/**
 * The answers, grouped as people look for them (the iPhone's `HelpTopics`, iOS/Habits/Help/HelpView.swift), each naming
 * the exact control on Android and saying "log" (Current Work 102). **When a way in changes, change its answer here too.**
 */
object HelpTopics {
    const val WIDGETS = "Widgets"

    val sections: List<HelpSection> = listOf(
        HelpSection("Logging", listOf(
            HelpTopic("Log a habit",
                "Tap ✓ or + on its row. For an amount or a time you type, tap the row to open Day details and choose Log manually. On a timed habit's row, ▶ starts a timer."),
            HelpTopic("Undo a wrong tap",
                "Right after you log, Undo shows under the habit's name: tap it. A ✓ can also be tapped again. For an amount or a time, tap the row to open Day details, where each log has its own Undo."),
            HelpTopic("Fill in a day I forgot",
                "Go back a day with ‹ in the bar at the bottom of Today, or tap the date there to choose a day. Then log as usual."),
            HelpTopic("Change or delete what I logged",
                "Tap the habit's row to open Day details. Tap a log under the day's logs to see it, then choose Edit or Delete."),
            HelpTopic("Log without opening the app",
                "A reminder's notification has Done, or +1 for amounts. On your home screen, a widget's ✓ and + log right there."),
        )),
        HelpSection("Habits", listOf(
            HelpTopic("Edit a habit",
                "Touch and hold it on Today and choose Edit habit. Changes apply from today; past days keep the goal they had."),
            HelpTopic("Skip a day",
                "Swipe the habit's row to show Skip, or tap the row and choose Skip today at the bottom of Day details. A skipped day isn't a missed day: it never breaks a streak."),
            HelpTopic("Pause a habit while I'm away or ill",
                "Touch and hold it and choose Pause… for a week, two weeks, until a date, or until you turn it back on. Paused habits wait in a Paused card at the bottom of Today, and their streak is kept. Skip is for one day; Pause is for a stretch of days."),
            HelpTopic("Archive or delete a habit",
                "Open its page (≡ › Habits, then the habit), and tap ⋮. Archive keeps its history and frees its place on the free plan. Delete removes the habit and its history for good."),
            HelpTopic("See a habit's history",
                "In ≡ › Habits, tap a habit for its page: History lists its days, Notes its notes, and Progress its streak, best and how it's gone over time."),
            HelpTopic("Morning, Afternoon and Evening",
                "Each time of day is a card on Today. Pick one or more in a habit's Time of day, or Anytime. Change them or add your own in ≡ › Times of Day."),
            HelpTopic("Run a routine",
                "Tap ▶ Start on a time of day. Its habits open one at a time: move with ‹ ›, and tap the day under a habit's name for Day details, to skip or log by hand."),
            HelpTopic("Groups",
                "Tap Filter at the top of Today and choose New group. Filter then shows just that group's habits, and Progress can show one group too."),
            HelpTopic("Add a note",
                "After you log, tap Add note under the habit. Or swipe the row to show Note, or touch and hold it. A note for the whole day is at the bottom of Today."),
            HelpTopic("Tasks",
                "Tap + on Today and choose Add a task: something to get done once, or on repeat. Tasks have no streaks or stats, and they're always free. See them all in ≡ › Tasks."),
        )),
        HelpSection("Quitting and cutting down", listOf(
            HelpTopic("Log a slip",
                "Touch and hold the quit habit and choose Record a slip…, or swipe its row to show Log slip. The clock starts again from then; your best run and your history are kept, and Undo is right there."),
            HelpTopic("When a daily limit counts",
                "A Cut down limit is judged when the day ends, so it never shows as met in the morning before you've had the chance to go over it."),
        )),
        HelpSection("How things count", listOf(
            HelpTopic("What the streak number means",
                "It counts your goal in a row. \"23\" is 23 days; \"4 wk\" is 4 weeks in a row at a weekly goal. Days that aren't the habit's days, and skipped or paused days, never break it."),
            HelpTopic("Why a weekly habit shows done today",
                "A habit like 3 times a week counts as done for the day once you've logged it that day, and its row shows how many so far this week."),
            HelpTopic("How Progress counts",
                "≡ › Progress shows each week, month or year. Each planned day counts once; skipped, paused and archived days never count against you. What the squares mean, on that page, explains every square."),
        )),
        HelpSection("Reminders", listOf(
            HelpTopic("Set a reminder",
                "Edit the habit, open Reminders and turn them on, then set the times. Choose a notification or an alarm, and Remind again if it isn't done yet."),
            HelpTopic("A reminder didn't come",
                "Open ≡ › Reminders. The Reminder check shows what this phone allows: notifications, exact times and battery use. Anything that can stop a reminder has a button to fix it."),
            HelpTopic("Notifications are off",
                "If you said no when the phone asked, ≡ › Reminders says so, with a button to open the phone's settings, where you can allow them."),
        )),
        HelpSection("Settings", listOf(
            HelpTopic("My day ends after midnight",
                "In ≡ › Day and Week, set New day starts at to a later hour, up to noon. What you log before then counts for the day before."),
            HelpTopic("Change the first day of the week",
                "In ≡ › Day and Week, choose Week starts on. Weekly goals and week streaks count in those weeks."),
            HelpTopic("Dark mode, sound and vibration",
                "In ≡ › Appearance: Theme, Vibration and Sound when done."),
        )),
        HelpSection(WIDGETS, listOf(
            HelpTopic("Which widgets are there?",
                "One habit (small), Today (medium and large: your habits for today, or one time of day), This week (one habit, medium) and Tasks (medium and large)."),
            HelpTopic("What the buttons on a widget do",
                "✓ and + log right on the widget, and ▶ and ⏸ start and stop a timer, without opening the app. An amount you type, a slip, or a checklist's steps open their own screen in the app. Lists keep your order; ‹ › show the rest."),
            HelpTopic("Add a widget",
                "Touch and hold an empty spot on your home screen and tap Widgets. Find Often Enough, then touch and hold the widget you want and drag it into place."),
            HelpTopic("Choose a habit for a widget",
                "Touch and hold the widget and tap the pencil (Reconfigure on some phones), then choose. Each widget keeps its own choice."),
            HelpTopic("A widget looks out of date",
                "Open the app: it updates every widget when it opens. The phone decides when widgets redraw, so a widget can take a moment to follow a change."),
        )),
        HelpSection("Privacy & Security", listOf(
            HelpTopic("Lock the app",
                "In ≡ › Privacy & Security, tap App lock and turn it on. Choose your phone's lock (fingerprint, face, PIN or pattern) or a six-digit app passcode. Lock again sets how long it stays open after you leave it; locking your phone always locks it."),
            HelpTopic("Use an app passcode instead of your phone's lock",
                "In ≡ › Privacy & Security › App lock, under Unlock with, choose An app passcode. Only your app passcode opens the app then, so people who know your phone's PIN can't get in."),
            HelpTopic("Forgot your app passcode",
                "On the lock screen, tap Forgot passcode?. If this phone has a screen lock, unlock with it and choose a new passcode straight away. Otherwise, start the 24-hour reset: after 24 hours you choose a new one. Entering your passcode before then cancels the reset. Your habits stay as they are."),
            HelpTopic("Hide names outside the app",
                "In ≡ › Privacy & Security, turn on Hide names outside the app. Widgets, reminders, alarms and the running timer then show icons and numbers without habit names, and ✓ and + still work. It's always on while App lock is on."),
            HelpTopic("App lock on a new phone",
                "App lock and your app passcode stay on the phone they were set on. After moving to a new phone or restoring a backup, App lock is off: turn it on again in ≡ › Privacy & Security › App lock."),
        )),
        HelpSection("Your data", listOf(
            HelpTopic("Where my habits are",
                "On this phone, and in your own Google Drive once you connect it: a backup goes there each day. Your Google Drive is yours: we never see your habits. ≡ › Google Drive & Backup says when the last backup was made. Nothing else is sent anywhere unless you share it."),
            HelpTopic("What free and Plus keep",
                "Free: a backup in your Google Drive each day, and Android's own backup of the app. Plus also keeps a tablet or a second phone the same as this one, through your Google Drive."),
            HelpTopic("A new phone",
                "Install Often Enough and choose I've used it before, then connect Google Drive: what's there comes back. Coming from an iPhone? Save a backup file there and choose Restore from a backup › A backup file here. On a phone that already has habits, you see what's coming before anything changes."),
            HelpTopic("Before deleting the app",
                "With Google Drive connected, your habits stay there: after reinstalling, choose I've used it before and they come back. Without it, save a backup file outside the app first (≡ › Google Drive & Backup › Save a backup file)."),
            HelpTopic("Restore from a backup",
                "In ≡ › Google Drive & Backup, choose Restore from a backup: from Google Drive or a backup file you saved. You see what's in it first. Restoring can be undone for 30 days with Undo last restore."),
            HelpTopic("Delete my data from Google Drive",
                "In ≡ › Google Drive & Backup, choose Delete my data from Google Drive…. Your backups leave Google Drive; this phone keeps everything unless you choose to erase it too."),
            HelpTopic("Open my history in a spreadsheet",
                "In ≡ › Google Drive & Backup, choose Export a spreadsheet (CSV), to open in Google Sheets or Excel. Each row is a day's log or note, with its date."),
            HelpTopic("What's free, and what Plus adds",
                "Free: up to ${HabitStore.FREE_HABIT_LIMIT} habits with everything else included, and unlimited tasks. Archiving a habit frees its place. Plus is one payment, not a subscription: unlimited habits, the Today and This week widgets, and more devices kept the same."),
        )),
    )

    /** Topics whose question or answer holds [query], ignoring case. */
    fun matching(query: String): List<HelpTopic> {
        val q = query.trim()
        if (q.isEmpty()) return emptyList()
        return sections.flatMap { it.topics }.filter { it.question.contains(q, ignoreCase = true) || it.answer.contains(q, ignoreCase = true) }
    }
}

/** ≡ › Help & Feedback: search at the top, Contact us and the welcome again, then every topic opened in place. */
@Composable
fun HelpPage(onWelcome: () -> Unit, onBack: () -> Unit) {
    val context = LocalContext.current
    var query by rememberSaveable { mutableStateOf("") }
    var open by rememberSaveable { mutableStateOf(emptySet<String>()) }
    var showAddress by remember { mutableStateOf(false) }
    val toggle: (String) -> Unit = { q -> open = if (q in open) open - q else open + q }
    FormPage("Help & Feedback", chip = null, onBack = onBack) {
        SearchField(query) { query = it }
        Spacer(Modifier.height(16.dp))
        if (query.isBlank()) {
            SegmentedList {
                Box(Modifier.semantics { testTag = "help-contact" }) {
                    ListRow("Contact us", 0, 2, Support.EMAIL, Icons.Outlined.Email, chevron = false, onClick = {
                        try { context.startActivity(Support.mail()) } catch (e: ActivityNotFoundException) { showAddress = true }
                    })
                }
                Box(Modifier.semantics { testTag = "help-welcome" }) {
                    ListRow("Show the welcome again", 1, 2, "What's free, and what Often Enough can do", Icons.Rounded.WavingHand, chevron = false, onClick = onWelcome)
                }
            }
            Note("We read every message. Tell us what happened and when; your habits are never sent with it.")
            for (section in HelpTopics.sections) {
                GroupTitle(section.title)
                SegmentedList { section.topics.forEachIndexed { i, t -> TopicRow(t, i, section.topics.size, t.question in open) { toggle(t.question) } } }
            }
        } else {
            val found = HelpTopics.matching(query)
            if (found.isEmpty()) {
                Text("No help for \"${query.trim()}\". Try another word, or write to us.", Modifier.padding(16.dp).semantics { testTag = "help-none" },
                    style = MaterialTheme.typography.bodyLarge, color = appColors.secondary)
            } else SegmentedList { found.forEachIndexed { i, t -> TopicRow(t, i, found.size, t.question in open) { toggle(t.question) } } }
        }
        Spacer(Modifier.height(24.dp))
    }
    if (showAddress) {
        val clipboard = LocalClipboard.current
        val scope = androidx.compose.runtime.rememberCoroutineScope()
        AlertDialog({ showAddress = false }, title = { Text("Write to us") },
            text = { Text("Email ${Support.EMAIL}. Say what happened and when, and which phone you use.") },
            confirmButton = { TextButton({ showAddress = false }) { Text("OK", color = appColors.ink) } },
            dismissButton = { TextButton({
                scope.launch { clipboard.setClipEntry(ClipData.newPlainText("Email", Support.EMAIL).toClipEntry()) }
                showAddress = false
            }) { Text("Copy address", color = appColors.ink) } })
    }
}

@Composable
private fun SearchField(query: String, onChange: (String) -> Unit) {
    val c = appColors
    Row(Modifier.fillMaxWidth().clip(RoundedCornerShape(28.dp)).background(c.tonal).heightIn(min = 56.dp).padding(start = 16.dp, end = 4.dp),
        verticalAlignment = Alignment.CenterVertically) {
        Icon(Icons.Rounded.Search, null, tint = c.ink)
        Spacer(Modifier.width(16.dp))
        BasicTextField(query, onChange, Modifier.weight(1f).semantics { testTag = "help-search"; contentDescription = "Search help" },
            singleLine = true, textStyle = MaterialTheme.typography.bodyLarge.copy(color = c.ink), cursorBrush = SolidColor(c.ink),
            decorationBox = { inner -> Box { if (query.isEmpty()) Text("Search help", style = MaterialTheme.typography.bodyLarge, color = c.secondary); inner() } })
        if (query.isNotEmpty()) IconButton({ onChange("") }) { Icon(Icons.Rounded.Close, "Clear search", tint = c.ink) }
        else Spacer(Modifier.width(12.dp))
    }
}

/** One question; tapping it opens the answer in place (▾). */
@Composable
private fun TopicRow(topic: HelpTopic, index: Int, count: Int, open: Boolean, onToggle: () -> Unit) {
    val c = appColors
    Segment(index, count, Modifier.animateContentSize().semantics(mergeDescendants = true) {
        testTag = "help-topic-" + topic.question
        stateDescription = if (open) "Expanded" else "Collapsed"
    }, onClick = onToggle) {
        Column(Modifier.weight(1f).padding(vertical = 4.dp)) {
            Text(topic.question, style = MaterialTheme.typography.bodyLarge.copy(fontWeight = if (open) FontWeight.Medium else FontWeight.Normal), color = c.ink)
            if (open) {
                Spacer(Modifier.height(8.dp))
                Text(topic.answer, style = AppType.bodyMedium, color = c.secondary)
            }
        }
        Spacer(Modifier.width(8.dp))
        Icon(if (open) Icons.Rounded.ExpandLess else Icons.Rounded.ExpandMore, null, tint = c.ink)
    }
}

// ------------------------------------------------------------------ About

/** The libraries inside the app, with their licences (the iPhone's AboutView, plus Android's own). */
private val libraries = listOf(
    "Kotlin standard library" to "Apache License 2.0 · JetBrains",
    "kotlinx.coroutines" to "Apache License 2.0 · JetBrains",
    "AndroidX Room" to "Apache License 2.0 · Google",
    "AndroidX SQLite" to "Apache License 2.0 · Google",
    "Jetpack Compose" to "Apache License 2.0 · Google",
    "SQLite" to "Public domain",
)

/** ≡ › About: the mark, name and version, the name in one line, privacy in plain words, and the acknowledgements. */
@Composable
fun AboutPage(onLicences: () -> Unit, onBack: () -> Unit) {
    val c = appColors
    FormPage("About", chip = null, onBack = onBack) {
        Spacer(Modifier.height(8.dp))
        Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(28.dp)).background(c.surface).padding(vertical = 32.dp),
            horizontalAlignment = Alignment.CenterHorizontally) {
            // The tonal mark straight on the card (Brand/Logo Guide.md: a simple matching surface, no tile).
            Image(painterResource(if (c.dark) R.drawable.mark_dark else R.drawable.mark_light), null, Modifier.size(96.dp))
            Spacer(Modifier.height(16.dp))
            Text("Often Enough", Modifier.semantics { heading() }, style = MaterialTheme.typography.headlineMedium, color = c.ink)
            Spacer(Modifier.height(8.dp))
            Text("Version ${Support.appVersion}", Modifier.semantics { testTag = "about-version" }, style = MaterialTheme.typography.bodyLarge, color = c.secondary)
        }
        GroupTitle("The name")
        TextCard("A habit doesn't need a perfect record. It needs to happen often enough.")
        GroupTitle("Privacy")
        TextCard("No ads and no tracking, and no account. Your habits stay on your devices and in your own Google Drive: we never see them.")
        GroupTitle("Acknowledgements")
        SegmentedList {
            val count = libraries.size + 1
            libraries.forEachIndexed { i, (name, licence) -> ListRow(name, i, count, licence) }
            Box(Modifier.semantics { testTag = "about-licences" }) { ListRow("Open source licences", libraries.size, count, onClick = onLicences) }
        }
        Note("Often Enough is built with these open-source libraries. Thank you to the people who make them.")
        Spacer(Modifier.height(24.dp))
    }
}

@Composable
private fun TextCard(text: String) {
    Text(text, Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(appColors.surface).padding(horizontal = 20.dp, vertical = 18.dp),
        style = MaterialTheme.typography.bodyLarge, color = appColors.ink)
}

/** Open source licences: each library's licence, in full words a person can read (Android's standard page). */
@Composable
fun LicencesPage(onBack: () -> Unit) {
    FormPage("Open source licences", chip = null, onBack = onBack) {
        Spacer(Modifier.height(8.dp))
        SegmentedList { libraries.forEachIndexed { i, (name, licence) -> ListRow(name, i, libraries.size, licence) } }
        Note("The Apache License 2.0 lets anyone use, change and share the software, keeping its copyright and licence notices. Its full text: apache.org/licenses/LICENSE-2.0. SQLite is in the public domain: anyone may use it for any purpose.")
        Spacer(Modifier.height(24.dp))
    }
}
