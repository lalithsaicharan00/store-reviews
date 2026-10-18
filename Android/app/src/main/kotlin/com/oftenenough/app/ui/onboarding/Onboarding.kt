package com.oftenenough.app.ui.onboarding

import com.oftenenough.app.ui.theme.AppType

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.Image
import androidx.compose.ui.unit.Constraints
import androidx.compose.ui.text.rememberTextMeasurer
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.runtime.remember
import androidx.compose.animation.core.animateDpAsState
import androidx.compose.animation.animateColorAsState
import androidx.compose.animation.fadeOut
import androidx.compose.animation.fadeIn
import androidx.compose.animation.AnimatedVisibility
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.foundation.layout.defaultMinSize
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.text.style.LineBreak
import com.oftenenough.app.ui.theme.sharedAxisX
import com.oftenenough.app.ui.theme.sharedAxisSlidePx
import androidx.compose.animation.AnimatedContent
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
    // Each step slides in with Material's shared axis (Motion.kt; the user, 13 Oct 2026: the steps jumped with no
    // motion). Forward when the next step is further along, back when it's earlier: the way back is a side step of
    // the welcome, so it counts as one step forward from it.
    val slide = sharedAxisSlidePx()
    fun step(p: String) = if (p == "back") 1 else pages.indexOf(p)
    Box(Modifier.fillMaxSize().background(appColors.screen).statusBarsPadding().navigationBarsPadding()) {
    AnimatedContent(page, Modifier.fillMaxSize(),
        transitionSpec = { sharedAxisX(forward = step(targetState) > step(initialState), slidePx = slide) }, label = "onboarding") { shown ->
        when (shown) {
            "welcome" -> Welcome(onNew = { page = "habit" }, onBack = { page = "back" })
            "back" -> WelcomeBack(::back, nav)
            "habit", "quit", "tasks" -> IntroPage(shown, ::back, onSkip = nav::finished, onContinue = { page = pages[pages.indexOf(shown) + 1] })
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
    // The intro pages' dots (rule 4 above `IntroPage`): drawn once, over the pages, so they stay put while a page
    // slides and the current dot grows into the pill; they fade in and out with the three intro pages.
    val introIndex = introPages.indexOf(page)
    AnimatedVisibility(introIndex >= 0, Modifier.align(Alignment.BottomCenter).padding(bottom = IntroDotsAboveBottom), enter = fadeIn(), exit = fadeOut()) {
        PageDots(introIndex.coerceAtLeast(0), introPages.size)
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
 * Welcome's type: the shared styles (`AppType`, the Figma file's Android / … styles), named for their jobs here.
 */
private object WelcomeType {
    val name = AppType.headlineLargeEmphasized
    val tagline = AppType.bodyLarge
    val question = AppType.titleMedium
    val choice = AppType.titleMedium
    val choiceSupporting = AppType.bodyMedium

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
        Text(title, style = AppType.displaySmall, color = appColors.ink)
        if (subtitle != null) {
            Spacer(Modifier.height(12.dp))
            Text(subtitle, style = AppType.bodyLarge, color = appColors.secondary)
        }
    }
}

/** A page with ← and Skip setup at the top, a heading, its content and the main button at the bottom. */
@Composable
private fun Page(
    title: String, subtitle: String?, onBack: () -> Unit, onSkip: () -> Unit, button: String, onButton: () -> Unit,
    content: @Composable ColumnScope.() -> Unit,
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
        InkButton(button, onButton, Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 8.dp).semantics { testTag = "onboarding-continue" })
    }
}

/*
 * The three intro pages: "03 · Intro 1 of 3 · Your habit. Your goal." (Figma 1548:46), "04 · … Quit or cut down."
 * (1548:177) and "05 · … Tasks, once or on repeat." (1548:296), in the section "Onboarding: new to the app". Rebuilt
 * 13 Oct 2026 to match Figma exactly, with the same rules as Welcome (its header above, rules 1, 2 and 7):
 *
 * 1. **Figma's numbers, Google Sans Flex, Regular and Medium only.** The heading 28/36 Medium (−0.25); the line under
 *    it 16/24 Regular, grey; the section title 16/24 Medium over 12/16 Regular; each habit's name 16/24 Medium over
 *    its detail 14/20 Regular, grey. The names are Medium so a row reads name first, detail second.
 * 2. **The line under the heading has a measure** (`IntroPageSpec.measure`, measured in Figma): "…follow steps. /
 *    You choose the goal." (296), "Quit completely, or set a limit / on how much or how long." (228), "…repeating
 *    tasks. / Keep them alongside your habits." (296). The heading itself breaks balanced (`LineBreak.Heading`):
 *    "Tasks, once or on repeat." is one line where it fits and "Tasks, once or / on repeat." on a 360 dp phone,
 *    never a lone "repeat.".
 * 3. **The card starts at the same place on all three pages** (the user, 13 Oct 2026): the heading and its line get
 *    the same space on each, the tallest of the three at this width and font size (`introHeadingHeight`, measured),
 *    then 24 dp, then the card. Any space left is below the card ("let's have that empty space, let it be"); never
 *    centre the card, or it jumps between pages. With very large text the page scrolls.
 * 4. **The page dots stay** (the user, 13 Oct 2026, after trying the pages without them): 20 dp above Continue, the
 *    current page a 24 dp pill. They're drawn once by the flow (`PageDots`), so they stay still while the pages slide
 *    and only the pill moves, with Compose's default spring.
 * 5. **Streaks are 🔥 with the number** (the iPhone's rule; the user, 13 Oct 2026), 20 dp from the row's round button
 *    (it was 12, "very close"). These pages draw their own (`IntroStreak`): Today's `StreakLabel` keeps its icon
 *    until Today is redesigned, and these pages must not change Today.
 * 6. **Habit icons are circles**, as everywhere on these pages; the tasks have their own colours (brown, indigo,
 *    green), not one orange for all.
 * 7. **No "Unlimited tasks · Included in the free plan"** on the tasks page (the user, 13 Oct 2026).
 *
 * The cards are samples: not saved, not tappable. They are drawn here, not from Today's rows, so Today can change
 * on its own schedule; when Today moves to Google Sans Flex, keep the two looking alike.
 */
@Composable
private fun IntroPage(page: String, onBack: () -> Unit, onSkip: () -> Unit, onContinue: () -> Unit) {
    val spec = introSpec(page)
    Column(Modifier.fillMaxSize()) {
        // Figma's top app bar: 64 dp, ← at 4 dp from the edge, Skip setup 12 dp from the other.
        Row(Modifier.fillMaxWidth().height(64.dp).padding(start = 4.dp, end = 12.dp), verticalAlignment = Alignment.CenterVertically) {
            IconButton(onBack) { Icon(Icons.AutoMirrored.Rounded.ArrowBack, "Back", tint = appColors.ink) }
            Spacer(Modifier.weight(1f))
            PlainButton("Skip setup", onSkip, Modifier.semantics { testTag = "skip-setup" }, textStyle = IntroType.button)
        }
        // fillMaxSize before verticalScroll keeps the space's height as the minimum, so the two weighted gaps centre
        // the card; with very large text they shrink to 24 dp and the page scrolls.
        Column(Modifier.weight(1f).fillMaxWidth().verticalScroll(rememberScrollState()).padding(start = 16.dp, end = 16.dp, top = 8.dp)) {
            Column(Modifier.padding(horizontal = 8.dp).heightIn(min = introHeadingHeight()), verticalArrangement = Arrangement.spacedBy(8.dp)) {
                Text(spec.title, style = IntroType.heading, color = appColors.ink)
                Text(spec.line, Modifier.widthIn(max = spec.measure), style = IntroType.line, color = appColors.secondary)
            }
            Spacer(Modifier.height(24.dp))
            SampleCard(spec.section)
            Spacer(Modifier.height(24.dp))
        }
        // Figma's bottom bar: 12 dp, the dots (8), 20 dp, the 56 dp button, 12 dp. The dots are drawn by the flow
        // (`PageDots`), so here there's only their room.
        Spacer(Modifier.height(IntroDotsRoom))
        InkButton("Continue", onContinue, Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 12.dp).semantics { testTag = "onboarding-continue" },
            textStyle = IntroType.continueLabel)
    }
}

/** The three intro pages in order: the dots and the shared heading space use all three. */
private val introPages = listOf("habit", "quit", "tasks")

private fun introSpec(page: String): IntroPageSpec = when (page) {
    "habit" -> IntroPageSpec("Your habit. Your goal.", "Count, check off, time or follow steps. You choose the goal.", 296.dp,
        SampleSection("Morning", "Starts 6 AM", listOf(
            Sample("Water", "3/8 glasses", "drop.fill", HabitColor.BLUE, 3f / 8, 3, "+"),
            Sample("Take vitamins", "Every day", "pills.fill", HabitColor.GREEN, 0f, 2, "✓"),
            Sample("Read", "6/10 min", "book.fill", HabitColor.ORANGE, 0.6f, 4, "▶"),
            Sample("Tidy desk", "0/3 steps", "checklist", HabitColor.PURPLE, 0f, 2, "⌄"),
        )))
    "quit" -> IntroPageSpec("Quit or cut down.", "Quit completely, or set a limit on how much or how long.", 228.dp,
        SampleSection("Quit or cut down", "Stop, or do less", listOf(
            Sample("Smoking", "Best 45 days", "smoke.fill", HabitColor.GRAY, 0f, 0, "19d 12:32:45"),
            Sample("Coffee", "0/2 cups max", "cup.and.saucer.fill", HabitColor.BROWN, 0f, 0, "+"),
            Sample("Social media", "0/30 min max", "iphone.slash", HabitColor.PINK, 0f, 7, "▶"),
        )))
    else -> IntroPageSpec("Tasks, once or on repeat.", "Plan one-off jobs and repeating tasks. Keep them alongside your habits.", 296.dp,
        SampleSection("Anytime", "Once or on repeat", listOf(
            Sample("Pick up parcel", "Task · Once", "shippingbox.fill", HabitColor.BROWN, 0f, 0, "✓"),
            Sample("Pay rent", "Task · Every month", "banknote.fill", HabitColor.INDIGO, 0f, 0, "✓"),
            Sample("Water plants", "Task · 7 days after done", "leaf.fill", HabitColor.GREEN, 0f, 0, "✓"),
        )))
}

/**
 * Rule 3: the space the heading and its line take on every intro page, so each card starts at the same place (the
 * user, 13 Oct 2026: "the card should be starting at the same space in every page"). It's the tallest of the three at
 * this screen's width and font size, measured, never a guess: "Tasks, once or / on repeat." takes two lines on a
 * 360 dp phone and one on a wider one.
 */
@Composable
private fun introHeadingHeight(): Dp {
    val measurer = rememberTextMeasurer()
    val density = LocalDensity.current
    // The heading column's width: the screen less 16 dp and 8 dp on each side.
    val width = with(density) { (LocalConfiguration.current.screenWidthDp.dp - 48.dp).roundToPx() }
    return remember(width, density.fontScale) {
        introPages.maxOf { p ->
            val s = introSpec(p)
            val head = measurer.measure(s.title, IntroType.heading, constraints = Constraints(maxWidth = width)).size.height
            val line = measurer.measure(s.line, IntroType.line, constraints = Constraints(maxWidth = minOf(width, with(density) { s.measure.roundToPx() }))).size.height
            with(density) { (head + line).toDp() + 8.dp }
        }
    }
}

/** Figma: 12 dp below the cards' space, the 8 dp dots, 20 dp, then the button (whose own 12 dp top is in `InkButton`'s padding). */
private val IntroDotsRoom = 28.dp
/** Where the dots sit: 12 + 56 + 20 dp above the bottom of the flow (the button's 12 dp bottom, the button, the gap). */
private val IntroDotsAboveBottom = 88.dp

/**
 * The page dots: the current page a 24 × 8 dp pill in ink, the others 8 × 8 dp in ink at 30 % (≈ #B0B0B3 on the
 * light screen, about 2 : 1), 8 dp apart (Figma). The user, 13 Oct 2026, tried both neighbours: the tonal grey
 * (#E6E6EA) couldn't be seen on the #F0F0F3 screen, and the outline grey (#79747E) was "too dark … competing with
 * the active state". Ink at 30 % follows light and dark by itself.
 * A change of page grows the new pill and shrinks the old one with Compose's default spring, Android's own short,
 * settle-in motion; nothing else moves. TalkBack reads "Page 2 of 3".
 */
@Composable
private fun PageDots(current: Int, count: Int) {
    Row(Modifier.semantics { contentDescription = "Page ${current + 1} of $count" }, horizontalArrangement = Arrangement.spacedBy(8.dp)) {
        repeat(count) { i ->
            val width by animateDpAsState(if (i == current) 24.dp else 8.dp, label = "dot width")
            val colour by animateColorAsState(if (i == current) appColors.ink else appColors.ink.copy(alpha = 0.3f), label = "dot colour")
            Box(Modifier.height(8.dp).width(width).clip(CircleShape).background(colour))
        }
    }
}

private class IntroPageSpec(val title: String, val line: String, val measure: Dp, val section: SampleSection)
private class SampleSection(val title: String, val subtitle: String, val rows: List<Sample>)
private data class Sample(val name: String, val line: String, val symbol: String, val color: HabitColor, val fill: Float, val streak: Int, val button: String)

/** A section of Today as Figma draws it on the intro pages (rule 1): its header, then each row as its own piece. */
@Composable
private fun SampleCard(section: SampleSection) {
    val c = appColors
    val count = section.rows.size + 1
    Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
        // Header: 12 dp above and below, 16 dp at the start, 8 dp at the end, the ⌃ in a 40 dp button.
        Row(Modifier.fillMaxWidth().clip(segmentShape(0, count)).background(c.surface).padding(start = 16.dp, top = 12.dp, bottom = 12.dp, end = 8.dp),
            verticalAlignment = Alignment.CenterVertically) {
            Column(Modifier.weight(1f)) {
                Text(section.title, style = IntroType.sectionTitle, color = c.ink)
                Text(section.subtitle, style = IntroType.sectionLine, color = c.secondary)
            }
            Box(Modifier.size(40.dp), contentAlignment = Alignment.Center) { Icon(Icons.Rounded.ExpandLess, null, tint = c.ink, modifier = Modifier.size(24.dp)) }
        }
        section.rows.forEachIndexed { i, s ->
            // A row: 72 dp, 16 dp at the start, 12 at the end; icon · 16 · name and detail · streak · 20 · button.
            Row(Modifier.fillMaxWidth().clip(segmentShape(i + 1, count)).background(c.surface).progressFill(s.fill, c.fill(s.color))
                .heightIn(min = 72.dp).padding(start = 16.dp, end = 12.dp), verticalAlignment = Alignment.CenterVertically) {
                HabitIcon(s.symbol, s.color)
                Spacer(Modifier.width(16.dp))
                Column(Modifier.weight(1f)) {
                    Text(s.name, style = IntroType.rowName, color = c.ink, maxLines = 1)
                    Text(s.line, style = IntroType.rowLine, color = c.secondary, maxLines = 1)
                }
                if (s.streak > 0) { IntroStreak(s.streak); Spacer(Modifier.width(20.dp)) }
                if (s.button.length > 2) Text(s.button, style = IntroType.clock, color = c.ink, maxLines = 1)
                else Box(Modifier.size(40.dp).clip(CircleShape).background(c.tonal), contentAlignment = Alignment.Center) {
                    Icon(sampleIcon(s.button), null, tint = c.ink, modifier = Modifier.size(24.dp))
                }
            }
        }
    }
}

/** "🔥 3": the emoji in an 18 dp place, 2 dp from the number (rule 5). TalkBack reads it in words, as Today's does. */
@Composable
private fun IntroStreak(count: Int) {
    Row(Modifier.semantics(mergeDescendants = true) { contentDescription = StreakUnit.DAYS.explained(count) }, verticalAlignment = Alignment.CenterVertically) {
        Box(Modifier.defaultMinSize(18.dp, 18.dp), contentAlignment = Alignment.Center) { Text("🔥", fontSize = 12.sp) }
        Spacer(Modifier.width(2.dp))
        Text(StreakUnit.DAYS.short(count), style = IntroType.streak, color = appColors.ink, maxLines = 1)
    }
}

private fun sampleIcon(b: String): ImageVector = when (b) {
    "+" -> Icons.Rounded.Add
    "✓" -> Icons.Rounded.Check
    "▶" -> Icons.Rounded.PlayArrow
    else -> Icons.Rounded.ExpandMore
}

/** The intro pages' type: the shared styles (`AppType`), named for their jobs here. */
private object IntroType {
    val heading = AppType.headlineMediumEmphasized.copy(lineBreak = LineBreak.Heading)
    val line = AppType.bodyLarge
    val sectionTitle = AppType.titleMedium
    val sectionLine = AppType.bodySmall
    val rowName = AppType.titleMedium
    val rowLine = AppType.bodyMedium
    val streak = AppType.labelLarge
    val clock = AppType.titleMedium
    val button = AppType.labelLarge
    val continueLabel = AppType.titleMedium
}

@Suppress("unused") private val unusedIcons = listOf(Icons.Rounded.WbTwilight, Icons.Rounded.CalendarMonth, Icons.Rounded.FolderOpen, Icons.Rounded.AddToDrive)
