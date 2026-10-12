package com.oftenenough.app.ui.onboarding

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
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
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.ArrowBack
import androidx.compose.material.icons.rounded.Add
import androidx.compose.material.icons.rounded.AllInclusive
import androidx.compose.material.icons.rounded.AutoAwesome
import androidx.compose.material.icons.rounded.CalendarMonth
import androidx.compose.material.icons.rounded.Check
import androidx.compose.material.icons.rounded.ExpandLess
import androidx.compose.material.icons.rounded.ExpandMore
import androidx.compose.material.icons.rounded.FolderOpen
import androidx.compose.material.icons.rounded.History
import androidx.compose.material.icons.rounded.PlayArrow
import androidx.compose.material.icons.rounded.AccountCircle
import androidx.compose.material.icons.rounded.AddToDrive
import androidx.compose.material.icons.rounded.WbTwilight
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.oftenenough.app.R
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.StreakUnit
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.InkButton
import com.oftenenough.app.ui.components.ListRow
import com.oftenenough.app.ui.components.PlainButton
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.components.StreakLabel
import com.oftenenough.app.ui.components.progressFill
import com.oftenenough.app.ui.components.segmentShape
import com.oftenenough.app.ui.settings.DayAndWeekRows
import com.oftenenough.app.ui.theme.appColors

/** One idea on "Your first habit": it only fills in the New Habit form; nothing is saved until Add (the iPhone's `HabitIdea`). */
data class HabitIdea(val name: String, val type: String, val line: String, val symbol: String) {
    companion object {
        val all = listOf(
            HabitIdea("Drink water", "amount", "Track an amount · every day", "drop.fill"),
            HabitIdea("Exercise", "check", "Check it off · 3 times a week", "figure.run"),
            HabitIdea("Read", "time", "Time it · every day", "book.fill"),
            HabitIdea("Meditate", "time", "Time it · every day", "figure.mind.and.body"),
            HabitIdea("Walk", "amount", "Track an amount · every day", "figure.walk"),
            HabitIdea("Go to bed on time", "check", "Check it off · every day", "moon.stars.fill"),
            HabitIdea("Stop smoking", "quit", "Quit · time since you stopped", "nosign"),
            HabitIdea("Less coffee", "cutDown", "Cut down · a daily limit", "cup.and.saucer.fill"),
        )
    }
}

/** Where the welcome hands over: Today, the New Habit form (from an idea or empty), or a way back (sign in, restore). */
interface OnboardingNav {
    fun finished()
    fun newHabit(idea: HabitIdea?)
    fun signIn()
    fun restore()
    fun privacy()
}

/**
 * The first launch (Android/Docs/Designs, sections 01–02): "Have you used Often Enough before?", then the new person's
 * three pages, Your days and weeks and Your first habit; or every way back. Nothing here asks for a permission or a
 * purchase, and there's no account to make.
 */
@Composable
fun OnboardingFlow(store: HabitStore, nav: OnboardingNav) {
    var page by rememberSaveable { mutableStateOf("welcome") }
    val pages = listOf("welcome", "habit", "quit", "tasks", "days", "first")
    fun back() { page = if (page == "back") "welcome" else pages.getOrElse(pages.indexOf(page) - 1) { "welcome" } }
    BackHandler(page != "welcome") { back() }
    Box(Modifier.fillMaxSize().background(appColors.screen).statusBarsPadding().navigationBarsPadding()) {
        when (page) {
            "welcome" -> Welcome(onNew = { page = "habit" }, onBack = { page = "back" }, onPrivacy = nav::privacy)
            "back" -> WelcomeBack(::back, nav)
            "habit", "quit", "tasks" -> IntroPage(page, ::back, onSkip = nav::finished, onContinue = { page = pages[pages.indexOf(page) + 1] })
            "days" -> Page("Your days and weeks.", null, ::back, nav::finished, "Continue", { page = "first" }) {
                DayAndWeekRows(store)
                Text("You can change these later in ≡ › Day and Week.", Modifier.padding(horizontal = 16.dp, vertical = 12.dp),
                    style = MaterialTheme.typography.bodyMedium, color = appColors.secondary)
            }
            "first" -> Page("Your first habit.", "Choose an idea to get started. You can edit it before adding it.", ::back, nav::finished,
                "Create my own habit", { nav.newHabit(null) }) {
                SegmentedList {
                    HabitIdea.all.forEachIndexed { i, idea ->
                        Box(Modifier.semantics { testTag = "idea-${idea.name}" }) {
                            ListRow(idea.name, i, HabitIdea.all.size, idea.line, com.oftenenough.app.ui.theme.HabitIcons.icon(idea.symbol), iconDisc = true,
                                onClick = { nav.newHabit(idea) })
                        }
                    }
                }
                Text("An idea only fills in the form. Nothing is added until you tap Add.", Modifier.padding(16.dp),
                    style = MaterialTheme.typography.bodyMedium, color = appColors.secondary)
            }
        }
    }
}

@Composable
private fun Welcome(onNew: () -> Unit, onBack: () -> Unit, onPrivacy: () -> Unit) {
    Column(Modifier.fillMaxSize().verticalScroll(rememberScrollState()).padding(horizontal = 16.dp), horizontalAlignment = Alignment.CenterHorizontally) {
        Spacer(Modifier.height(96.dp))
        Box(Modifier.size(96.dp).clip(RoundedCornerShape(24.dp)).background(Color.White), contentAlignment = Alignment.Center) {
            Image(painterResource(R.drawable.mark_light), "Often Enough", Modifier.size(72.dp))
        }
        Spacer(Modifier.height(24.dp))
        Text("Often Enough", style = MaterialTheme.typography.displaySmall.copy(fontSize = 34.sp), color = appColors.ink)
        Spacer(Modifier.height(12.dp))
        Text("Habits grow through repetition. You choose how often is enough.", Modifier.padding(horizontal = 24.dp),
            style = MaterialTheme.typography.bodyLarge.copy(fontSize = 17.sp), color = appColors.secondary, textAlign = TextAlign.Center)
        Spacer(Modifier.weight(1f).heightIn(min = 48.dp))
        Text("Have you used Often Enough before?", style = MaterialTheme.typography.titleMedium.copy(fontSize = 17.sp), color = appColors.ink)
        Spacer(Modifier.height(16.dp))
        SegmentedList {
            Box(Modifier.semantics { testTag = "onboarding-new" }) {
                ListRow("I'm new here", 0, 2, "Build habits and keep track of your tasks.", Icons.Rounded.AutoAwesome, iconDisc = true, onClick = onNew)
            }
            Box(Modifier.semantics { testTag = "onboarding-returning" }) {
                ListRow("I've used it before", 1, 2, "Get your habits back from Google Drive or a backup file.", Icons.Rounded.History, iconDisc = true, onClick = onBack)
            }
        }
        Spacer(Modifier.height(16.dp))
        PlainButton("Privacy & optional usage sharing", onPrivacy, color = appColors.secondary)
        Spacer(Modifier.height(8.dp))
    }
}

@Composable
private fun WelcomeBack(onBack: () -> Unit, nav: OnboardingNav) {
    Column(Modifier.fillMaxSize().padding(horizontal = 16.dp)) {
        IconButton(onBack, Modifier.padding(top = 8.dp)) { Icon(Icons.AutoMirrored.Rounded.ArrowBack, "Back", tint = appColors.ink) }
        Heading("Welcome back.", "Get your habits, tasks and history back.")
        SegmentedList {
            ListRow("Sign in with Google", 0, 2, "Your habits come back from Google Drive.", Icons.Rounded.AccountCircle, iconDisc = true, onClick = nav::signIn)
            ListRow("Restore a backup", 1, 2, "A day's copy from Google Drive, or a backup file.", Icons.Rounded.History, iconDisc = true, onClick = nav::restore)
        }
        Spacer(Modifier.height(24.dp))
        Box(Modifier.fillMaxWidth(), contentAlignment = Alignment.Center) {
            PlainButton("Start without restoring", nav::finished, Modifier.semantics { testTag = "start-without-restoring" })
        }
    }
}

@Composable
private fun Heading(title: String, subtitle: String?) {
    Column(Modifier.padding(start = 16.dp, end = 16.dp, top = 24.dp, bottom = 24.dp)) {
        Text(title, style = MaterialTheme.typography.displaySmall.copy(fontSize = 36.sp), color = appColors.ink)
        if (subtitle != null) {
            Spacer(Modifier.height(12.dp))
            Text(subtitle, style = MaterialTheme.typography.bodyLarge.copy(fontSize = 17.sp, lineHeight = 24.sp), color = appColors.secondary)
        }
    }
}

/** A page with ← and Skip setup at the top, a heading, its content, the page dots and the main button at the bottom. */
@Composable
private fun Page(
    title: String, subtitle: String?, onBack: () -> Unit, onSkip: () -> Unit, button: String, onButton: () -> Unit,
    dots: Int? = null, content: @Composable ColumnScope.() -> Unit,
) {
    Column(Modifier.fillMaxSize()) {
        Row(Modifier.fillMaxWidth().padding(start = 8.dp, end = 8.dp, top = 8.dp), verticalAlignment = Alignment.CenterVertically) {
            IconButton(onBack) { Icon(Icons.AutoMirrored.Rounded.ArrowBack, "Back", tint = appColors.ink) }
            Spacer(Modifier.weight(1f))
            PlainButton("Skip setup", onSkip, Modifier.semantics { testTag = "skip-setup" })
        }
        Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 16.dp)) {
            Heading(title, subtitle)
            content()
        }
        if (dots != null) Row(Modifier.fillMaxWidth().padding(vertical = 16.dp), horizontalArrangement = Arrangement.Center) {
            repeat(3) { i ->
                Box(Modifier.padding(horizontal = 4.dp).height(8.dp).width(if (i == dots) 24.dp else 8.dp).clip(CircleShape)
                    .background(if (i == dots) appColors.ink else appColors.tonal))
            }
        }
        InkButton(button, onButton, Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 8.dp).semantics { testTag = "onboarding-continue" })
    }
}

/** The three pages, each showing Today's real rows. */
@Composable
private fun IntroPage(page: String, onBack: () -> Unit, onSkip: () -> Unit, onContinue: () -> Unit) {
    when (page) {
        "habit" -> Page("Your habit. Your goal.", "Count, check off, time or follow steps. You choose the goal.", onBack, onSkip, "Continue", onContinue, 0) {
            SampleCard("Morning", "Starts 6 AM", listOf(
                Sample("Water", "3/8 glasses", "drop.fill", HabitColor.BLUE, 3f / 8, 3, "+"),
                Sample("Take vitamins", "Every day", "pills.fill", HabitColor.GREEN, 0f, 2, "✓"),
                Sample("Read", "6/10 min", "book.fill", HabitColor.ORANGE, 0.6f, 4, "▶"),
                Sample("Tidy desk", "0/3 steps", "checklist", HabitColor.PURPLE, 0f, 2, "⌄"),
            ))
        }
        "quit" -> Page("Quit or cut down.", "Quit completely, or set a limit on how much or how long.", onBack, onSkip, "Continue", onContinue, 1) {
            SampleCard("Quit or cut down", "Stop, or do less", listOf(
                Sample("Smoking", "Best 45 days", "smoke.fill", HabitColor.GRAY, 0f, 0, "19d 12:32:45"),
                Sample("Coffee", "0/2 cups max", "cup.and.saucer.fill", HabitColor.BROWN, 0f, 0, "+"),
                Sample("Social media", "0/30 min max", "iphone.slash", HabitColor.PINK, 0f, 7, "▶"),
            ))
        }
        else -> Page("Tasks, once or on repeat.", "Plan one-off jobs and repeating tasks. Keep them alongside your habits.", onBack, onSkip, "Continue", onContinue, 2) {
            SampleCard("Anytime", "Once or on repeat", listOf(
                Sample("Pick up parcel", "Task · Once", "shippingbox.fill", HabitColor.ORANGE, 0f, 0, "✓"),
                Sample("Pay rent", "Task · Every month", "banknote.fill", HabitColor.ORANGE, 0f, 0, "✓"),
                Sample("Water plants", "Task · 7 days after done", "leaf.fill", HabitColor.ORANGE, 0f, 0, "✓"),
            ))
            Spacer(Modifier.height(24.dp))
            SegmentedList { ListRow("Unlimited tasks", 0, 1, "Included in the free plan", Icons.Rounded.AllInclusive, iconDisc = true) }
        }
    }
}

private data class Sample(val name: String, val line: String, val symbol: String, val color: HabitColor, val fill: Float, val streak: Int, val button: String)

/** Today's real rows, drawn for the welcome (not saved, not tappable). */
@Composable
private fun SampleCard(title: String, subtitle: String, rows: List<Sample>) {
    val c = appColors
    val count = rows.size + 1
    Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
        Row(Modifier.fillMaxWidth().clip(segmentShape(0, count)).background(c.surface).padding(16.dp), verticalAlignment = Alignment.CenterVertically) {
            Column(Modifier.weight(1f)) {
                Text(title, style = MaterialTheme.typography.titleMedium, color = c.ink)
                Text(subtitle, style = MaterialTheme.typography.bodySmall, color = c.secondary)
            }
            Icon(Icons.Rounded.ExpandLess, null, tint = c.ink)
        }
        rows.forEachIndexed { i, s ->
            Row(Modifier.fillMaxWidth().clip(segmentShape(i + 1, count)).background(c.surface).progressFill(s.fill, c.fill(s.color))
                .heightIn(min = 72.dp).padding(start = 16.dp, end = 8.dp), verticalAlignment = Alignment.CenterVertically) {
                HabitIcon(s.symbol, s.color)
                Spacer(Modifier.width(16.dp))
                Column(Modifier.weight(1f)) {
                    Text(s.name, style = MaterialTheme.typography.bodyLarge, color = c.ink, maxLines = 1)
                    Text(s.line, style = MaterialTheme.typography.bodyMedium, color = c.secondary, maxLines = 1)
                }
                if (s.streak > 0) StreakLabel(s.streak, StreakUnit.DAYS)
                Spacer(Modifier.width(4.dp))
                if (s.button.length > 2) Text(s.button, Modifier.padding(end = 8.dp), style = MaterialTheme.typography.titleMedium.copy(fontWeight = FontWeight.SemiBold), color = c.ink)
                else Box(Modifier.padding(4.dp).size(40.dp).clip(CircleShape).background(c.tonal), contentAlignment = Alignment.Center) {
                    Icon(sampleIcon(s.button), null, tint = c.ink, modifier = Modifier.size(22.dp))
                }
            }
        }
    }
}

private fun sampleIcon(b: String): ImageVector = when (b) {
    "+" -> Icons.Rounded.Add
    "✓" -> Icons.Rounded.Check
    "▶" -> Icons.Rounded.PlayArrow
    else -> Icons.Rounded.ExpandMore
}

@Suppress("unused") private val unusedIcons = listOf(Icons.Rounded.WbTwilight, Icons.Rounded.CalendarMonth, Icons.Rounded.FolderOpen, Icons.Rounded.AddToDrive)
