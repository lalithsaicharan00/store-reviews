package com.oftenenough.app.ui.onboarding

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.Image
import com.oftenenough.app.ui.theme.googleSansFlex
import androidx.compose.ui.text.style.LineHeightStyle
import androidx.compose.ui.text.TextStyle
import androidx.compose.material.icons.automirrored.rounded.KeyboardArrowRight
import androidx.compose.foundation.clickable
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
import androidx.compose.foundation.layout.widthIn
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
}

/**
 * The first launch (Android/Docs/Designs, sections 01–02): "Have you used Often Enough before?", then the new person's
 * three pages, Your days and weeks and Your first habit; or every way back. Nothing here asks for a permission or a
 * purchase, and there's no account to make.
 */
@Composable
fun OnboardingFlow(store: HabitStore, nav: OnboardingNav, replay: Boolean = false) {
    // Help's Show the welcome again starts at what the app can do; going back from there closes it.
    var page by rememberSaveable { mutableStateOf(if (replay) "habit" else "welcome") }
    val pages = listOf("welcome", "habit", "quit", "tasks", "days", "first")
    fun back() {
        if (replay && page == "habit") return nav.finished()
        page = if (page == "back") "welcome" else pages.getOrElse(pages.indexOf(page) - 1) { "welcome" }
    }
    BackHandler(page != "welcome") { back() }
    Box(Modifier.fillMaxSize().background(appColors.screen).statusBarsPadding().navigationBarsPadding()) {
        when (page) {
            "welcome" -> Welcome(onNew = { page = "habit" }, onBack = { page = "back" })
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

/*
 * The Welcome screen: the first screen after downloading (Figma "02 · Welcome", node 1548:3, Android Designs, section
 * "Onboarding: new to the app"). Rebuilt 13 Oct 2026 to match Figma exactly, at the user's request ("whatever exactly
 * we have in the Figma, the same way it should look in the developed version"). Rules for anyone changing it:
 *
 * 1. **Figma's numbers, as drawn.** Every size, gap and padding below is the Figma frame's; never round, "improve" or
 *    reuse a nearby shared style that is a little different (the old screen used 34/17/15 sp and letter spacing the
 *    design never had, and looked heavier and more crowded than the design).
 * 2. **Google Sans Flex, Regular and Medium only** (`googleSansFlex`); never SemiBold or Bold unless the user asks.
 *    Letter spacing 0, except the app name's −0.5. Hierarchy: the name 32 Medium › the question 16 Medium › each
 *    choice's name 16 Medium › its description 14 Regular, grey.
 * 3. **The logo, the name and the line under it are centred in the space above the question**, on every screen
 *    height: two equal flexible gaps, never a fixed top gap (the old 96 dp stuck them to the top on tall phones and
 *    left a hole below). The question and the choices sit at the bottom, 24 dp above the gesture bar.
 *    Inside the group: 24 dp from the logo to the name, 8 dp from the name to the line under it (3 : 1, the user,
 *    13 Oct 2026, after trying 16 : 8): the name belongs with its line, not with the logo, so it sits nearer the line.
 * 4. **The choices breathe** (the user: "they have good amount of spacing"): 16 dp above and below the text, 2 dp
 *    between a choice's name and its description, 16 dp between the text and the chevron, 12 dp after the chevron.
 *    The text wraps to two lines before it ever reaches the chevron; don't use the shared `ListRow` here (its 12 dp
 *    padding and missing chevron gap squeezed "Build habits and keep track of your tasks." onto one line).
 * 5. **The logo fills its tile, and it's a vector:** `mark_light`/`mark_dark` (res/drawable: Figma's SVG export,
 *    converted with Android Studio's SVG converter) are the whole 1024 logo canvas, padding included, so they're drawn at the tile's full
 *    96 dp (Brand/Logo Guide.md, the 52:60 inset), never smaller. Never a PNG: the 288 px one looked soft on large
 *    screens (the user, 13 Oct 2026, "use SVG ... whichever is better in the long term").
 * 6. **One question, two answers, nothing else.** Privacy & optional usage sharing was removed on 13 Oct 2026 (the
 *    user: "yes remove it from the welcome screen"); Privacy is in ≡ › Privacy & Security (Design Rules, Onboarding).
 * 7. **Text has a measure, not hand-made breaks** (`WelcomeType.taglineMeasure`, `choiceMeasure`): it fills a narrow
 *    screen and stops at that width on a wide one, so the line under the name and each choice's description break
 *    at a natural pause on every phone.
 */
@Composable
private fun Welcome(onNew: () -> Unit, onBack: () -> Unit) {
    // fillMaxSize before verticalScroll keeps the screen's height as the column's minimum, so the two weighted gaps
    // share the spare height; with very large text the gaps shrink to 24 dp and the page scrolls instead.
    Column(Modifier.fillMaxSize().verticalScroll(rememberScrollState()).padding(horizontal = 16.dp), horizontalAlignment = Alignment.CenterHorizontally) {
        Spacer(Modifier.weight(1f).heightIn(min = 24.dp))
        // The tonal mark on its own background: the light set on white, the dark set on dark (Brand/Logo Guide.md, U29).
        Box(Modifier.size(96.dp).clip(RoundedCornerShape(25.85.dp)).background(appColors.surface), contentAlignment = Alignment.Center) {
            Image(painterResource(if (appColors.dark) R.drawable.mark_dark else R.drawable.mark_light), "Often Enough", Modifier.size(96.dp))
        }
        Spacer(Modifier.height(24.dp))
        Text("Often Enough", style = WelcomeType.name, color = appColors.ink)
        Spacer(Modifier.height(8.dp))
        Text("Habits grow through repetition. You choose how often is enough.", Modifier.widthIn(max = WelcomeType.taglineMeasure),
            style = WelcomeType.tagline, color = appColors.secondary, textAlign = TextAlign.Center)
        Spacer(Modifier.weight(1f).heightIn(min = 24.dp))
        Text("Have you used Often Enough before?", style = WelcomeType.question, color = appColors.ink, textAlign = TextAlign.Center)
        Spacer(Modifier.height(12.dp))
        SegmentedList {
            WelcomeChoice("I’m new here", "Build habits and keep track of your tasks.", Icons.Rounded.AutoAwesome, 0, "onboarding-new", onNew)
            WelcomeChoice("I’ve used it before", "Get your habits back from Google Drive or a backup file.", Icons.Rounded.History, 1, "onboarding-returning", onBack)
        }
        Spacer(Modifier.height(24.dp))
    }
}

/** One answer on Welcome, drawn to Figma's "Choice" rows (rule 4 above): 16 · disc 40 · 16 · text · 16 · › 24 · 12. */
@Composable
private fun WelcomeChoice(title: String, supporting: String, icon: ImageVector, index: Int, tag: String, onClick: () -> Unit) {
    Row(
        Modifier.fillMaxWidth().clip(segmentShape(index, 2)).background(appColors.surface)
            .clickable(onClick = onClick).semantics { testTag = tag }
            .padding(start = 16.dp, top = 16.dp, bottom = 16.dp, end = 12.dp),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Box(Modifier.size(40.dp).clip(CircleShape).background(appColors.tonal), contentAlignment = Alignment.Center) {
            Icon(icon, null, tint = appColors.ink, modifier = Modifier.size(24.dp))
        }
        Spacer(Modifier.width(16.dp))
        Column(Modifier.weight(1f), verticalArrangement = Arrangement.spacedBy(2.dp)) {
            Text(title, style = WelcomeType.choice, color = appColors.ink)
            Text(supporting, Modifier.widthIn(max = WelcomeType.choiceMeasure), style = WelcomeType.choiceSupporting, color = appColors.secondary)
        }
        Spacer(Modifier.width(16.dp))
        Icon(Icons.AutoMirrored.Rounded.KeyboardArrowRight, null, tint = appColors.secondary, modifier = Modifier.size(24.dp))
    }
}

/**
 * Welcome's type, exactly as Figma (rule 2). Line heights are Figma's, with the text centred in each line as Figma
 * draws it (`LineHeightStyle` Center, nothing trimmed). Kept here until the other screens move to Google Sans Flex;
 * then these become the app's shared `Typography`, set once, and screens only refer to it.
 */
private object WelcomeType {
    private val lines = LineHeightStyle(LineHeightStyle.Alignment.Center, LineHeightStyle.Trim.None)
    private fun style(size: Int, lineHeight: Int, weight: FontWeight, letterSpacing: Float = 0f) = TextStyle(
        fontFamily = googleSansFlex(size), fontWeight = weight, fontSize = size.sp, lineHeight = lineHeight.sp,
        letterSpacing = letterSpacing.sp, lineHeightStyle = lines,
    )
    val name = style(32, 40, FontWeight.Medium, letterSpacing = -0.5f)
    val tagline = style(16, 24, FontWeight.Normal)
    val question = style(16, 24, FontWeight.Medium)
    val choice = style(16, 24, FontWeight.Medium)
    val choiceSupporting = style(14, 20, FontWeight.Normal)

    /*
     * Rule 7, the measure: how long a line may get. Never a hand-typed line break, and never a line that runs across
     * a wide screen: on a narrow screen the text fills the space it has; on a wide one it stops at this width, so it
     * breaks where a reader pauses (the user, 13 Oct 2026: "if the space is smaller it should try to fill the space,
     * but if the space is large then it should split"). Measured in Figma in Google Sans Flex, with the window each
     * break needs, and set mid-window so small rendering differences can't move a word:
     *  - taglineMeasure 254: "Habits grow through repetition. / You choose how often is enough." (244–263 work).
     *  - choiceMeasure 212: "Build habits and keep track of / your tasks." and "Get your habits back from / Google
     *    Drive or a backup file." (197–226 work). Figma's 360-wide frame gives these descriptions 204, the same breaks.
     * Changing the words? Measure again and keep the value inside the new window.
     */
    val taglineMeasure = 254.dp
    val choiceMeasure = 212.dp
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
