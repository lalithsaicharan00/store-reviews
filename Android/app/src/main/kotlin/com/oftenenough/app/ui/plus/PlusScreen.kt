package com.oftenenough.app.ui.plus

import androidx.activity.compose.BackHandler
import androidx.activity.compose.LocalActivity
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.drawBehind
import androidx.compose.ui.graphics.PathEffect
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.input.pointer.PointerEventPass
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.semantics.clearAndSetSemantics
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import com.oftenenough.app.app.BuyResult
import com.oftenenough.app.app.PlusOwned
import com.oftenenough.app.app.PlusProduct
import com.oftenenough.app.app.PlusStore
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.HeatCell
import com.oftenenough.app.data.StreakUnit
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.AppDialog
import com.oftenenough.app.ui.components.AppFilledIconButton
import com.oftenenough.app.ui.components.AppListItem
import com.oftenenough.app.ui.components.AppSnackbarHost
import com.oftenenough.app.ui.components.AppTopBar
import com.oftenenough.app.ui.components.ButtonSize
import com.oftenenough.app.ui.components.DayCellDraw
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.HabitRowLayout
import com.oftenenough.app.ui.components.HabitRowLine
import com.oftenenough.app.ui.components.HabitRowStreak
import com.oftenenough.app.ui.components.ListAvatar
import com.oftenenough.app.ui.components.NavigationIcon
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.components.StepRow
import com.oftenenough.app.ui.components.StepRowBlock
import com.oftenenough.app.ui.components.dayCellColors
import com.oftenenough.app.ui.components.segmentShape
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch
import java.time.LocalDate
import java.time.Month
import java.time.format.TextStyle

/**
 * Why the Plus screen opened (Figma's Plus, Reason): the thing the person reached for leads the screen, and its feature
 * comes first in the list. [key] is its route's word (`plus/<key>`).
 */
enum class PlusReason(val key: String) {
    /** Adding a habit past the free five (A30). */
    SIXTH("sixth"),
    /** Checklist on How do you want to track it? on the free plan (A73). */
    CHECKLIST("checklist"),
    /** "If not done, remind again" on Reminders on the free plan (A73). */
    REMIND("remind"),
    /** The locked Year in pixels card on Habit details on the free plan (A73). */
    YEAR("year"),
    /** Plus in the side menu (A28), and a widget's Plus card. */
    MENU("menu");

    companion object { fun of(key: String?) = entries.firstOrNull { it.key == key } ?: MENU }
}

/** One thing Plus gives: its row on the list (Figma's "What you get with Plus"). */
private class Feature(val icon: ImageVector, val title: String, val line: String)

private val unlimited = Feature(Symbols.AllInclusive, "Unlimited habits", "Free has ${HabitStore.FREE_HABIT_LIMIT}. Add as many as you like.")
private val widgets = Feature(Symbols.Widgets, "Today’s list and This week widgets", "Your whole day on your home screen.")
private val year = Feature(Symbols.CalendarMonth, "Your year at a glance", "Every habit by month and year, and each habit’s Year in Pixels.")
private val checklist = Feature(Symbols.Checklist, "Checklist habits", "One habit, several steps. Tick each one off.")
private val remind = Feature(Symbols.NotificationsActive, "Remind me again", "If a habit isn’t done, get another nudge later.")
private val support = Feature(Symbols.Favorite, "Support me as a developer", "Help keep Often Enough going.")

/** The six by importance, the reason's own first (Figma's description). */
private fun features(reason: PlusReason): List<Feature> {
    val all = listOf(unlimited, widgets, year, checklist, remind, support)
    val first = when (reason) {
        PlusReason.CHECKLIST -> checklist
        PlusReason.REMIND -> remind
        PlusReason.YEAR -> year
        PlusReason.SIXTH, PlusReason.MENU -> unlimited
    }
    return listOf(first) + (all - first)
}

/**
 * 5.9.1, **Plus** (Figma 1204:175, Reason 6th habit · Checklist · Remind me again · Year in Pixels · Menu, Screen Default ·
 * End of the list; the flows "A sixth habit on the free plan", "A checklist on the free plan", "Remind again on the free
 * plan"). On Surface container: the Top app bar (← only); scrolling, 16 at the sides, 24 under, 24 between:
 *
 * - **The heading** about that one thing: its title in Headline Small Emphasized over its lead in Body Large On surface
 *   variant, 8 apart (Menu: the app icon, 56 on its 16-cornered tile, 16 before "Plus" and "Pay once, keep forever. No
 *   subscription, no account.", 2 apart).
 * - **Its picture**, the only colour on the screen: the five habits and an empty dashed sixth spot, "5 of 5 free habits"
 *   (6th habit); a Workout as it looks on Today, its steps open (Checklist); a Walk reminder at 9:00 AM and, not done
 *   yet, another an hour later on the habit's Fill (Remind me again); a year of Water, a square a day (Year in Pixels).
 *   An example, not the person's data (but the six habit's own icons); it takes no touch, and TalkBack reads it as one.
 * - **What you get with Plus** (Label Large Primary, 16 in): the six as List items on Surface bright, their grey icons in
 *   their circles, the reason's own first, then by importance.
 * - **Always free**: "Backup to Google Drive, export, dark mode, reminders, tasks, and every habit you’ve made."
 * - The price, said once: "One payment of $29.99, no subscription. Plus stays with your Google Play account."
 *
 * Under it, held at the bottom, the one button, **Get Plus · $29.99** (Filled, Medium, round, the screen's width, 12
 * above and under, 16 at the sides); no second button: ← goes back. Google Play's own sheet takes the payment; once Plus
 * is on, [onBought] (the caller goes on where the person was, and says "Plus is on"). Not drawn, so the app's own: a
 * payment Play is still waiting for says so here (Today's notice says it too); "Payment not completed" asks to try again;
 * with Plus already on (the menu), the screen says so and has no button (Decisions needed D-28).
 */
@Composable
fun PlusScreen(
    reason: PlusReason, store: HabitStore, plus: PlusStore, onBack: () -> Unit, onBought: () -> Unit,
    /** Restoring a habit past the free five says "Restore a 6th habit" (the same screen, Archived habits' Restore). */
    title: String? = null,
) {
    val s = MaterialTheme.colorScheme
    val activity = LocalActivity.current
    val scope = rememberCoroutineScope()
    val snack = remember { SnackbarHostState() }
    var buying by remember { mutableStateOf(false) }
    var notCompleted by remember { mutableStateOf(false) }
    val product = PlusProduct.PLUS
    val price = plus.price(product)
    val owned = plus.owned != PlusOwned.NONE
    // Opened on the free plan: once Play turns Plus on (bought here, or a waiting payment confirmed), the caller goes on.
    val startedFree = remember { !owned }
    LaunchedEffect(owned) { if (startedFree && owned) onBought() }
    BackHandler(onBack = onBack)

    fun buy() {
        val a = activity ?: return
        if (buying) return
        scope.launch {
            buying = true
            val result = plus.buy(a, product)
            buying = false
            when (result) {
                BuyResult.BOUGHT, BuyResult.CANCELLED -> {}
                BuyResult.PENDING -> snack.showSnackbar("Waiting for your payment. Plus turns on as soon as Google Play confirms it.")
                BuyResult.NOT_COMPLETED -> notCompleted = true
                BuyResult.UNAVAILABLE -> snack.showSnackbar("Buying isn’t available on this version yet. Everything you have stays yours.")
            }
        }
    }

    Box(Modifier.fillMaxSize().background(s.surfaceContainer).semantics { testTag = "plus-screen" }) {
        Column(Modifier.fillMaxSize()) {
            AppTopBar(null, navigationIcon = { NavigationIcon(Symbols.ArrowBack, "Back", onBack, Modifier.semantics { testTag = "plus-back" }) })
            Column(
                Modifier.weight(1f).verticalScroll(rememberScrollState()).semantics { testTag = "plus-list" }
                    .padding(start = 16.dp, end = 16.dp, bottom = 24.dp),
                verticalArrangement = Arrangement.spacedBy(24.dp),
            ) {
                Heading(reason, title, owned)
                when (reason) {
                    PlusReason.SIXTH -> SixthPicture(store)
                    PlusReason.CHECKLIST -> WorkoutPicture()
                    PlusReason.REMIND -> WalkPicture()
                    PlusReason.YEAR -> YearPicture(store)
                    PlusReason.MENU -> {}
                }
                Section("What you get with Plus") {
                    val list = features(reason)
                    list.forEachIndexed { i, f ->
                        AppListItem(f.title, i, list.size, supporting = f.line, leading = { ListAvatar(f.icon) },
                            containerColor = s.surfaceBright, tag = "plus-feature-$i")
                    }
                }
                Section("Always free") {
                    Text("Backup to Google Drive, export, dark mode, reminders, tasks, and every habit you’ve made.",
                        Modifier.padding(horizontal = 16.dp), style = AppType.bodyMedium, color = s.onSurfaceVariant)
                }
                Text(
                    if (owned) "Plus stays with your Google Play account."
                    else "One payment" + (price?.let { " of $it" } ?: "") + ", no subscription. Plus stays with your Google Play account.",
                    Modifier.padding(horizontal = 16.dp).semantics { testTag = "plus-price" }, style = AppType.bodyMedium, color = s.onSurfaceVariant,
                )
            }
            if (!owned) Box(Modifier.fillMaxWidth().navigationBarsPadding().padding(horizontal = 16.dp, vertical = 12.dp)) {
                AppButton("Get Plus" + (price?.let { " · $it" } ?: ""), ::buy, Modifier.fillMaxWidth(), size = ButtonSize.Medium,
                    enabled = plus.canBuy && !buying, tag = "plus-buy")
            }
        }
        AppSnackbarHost(snack, Modifier.align(Alignment.BottomCenter).navigationBarsPadding().padding(bottom = if (owned) 0.dp else 80.dp))
    }
    if (notCompleted) AppDialog("Payment not completed", "Nothing was charged. Check your payment method in Google Play, then try again.",
        "Try again", { notCompleted = false; buy() }, { notCompleted = false }, confirmTag = "plus-try-again")
}

/** The heading: the reason's title over its lead; the menu's leads with the app icon. */
@Composable
private fun Heading(reason: PlusReason, title: String?, owned: Boolean) {
    val s = MaterialTheme.colorScheme
    val (head, lead) = when (reason) {
        PlusReason.SIXTH -> (title ?: "Add a 6th habit") to
            "You’re using all ${HabitStore.FREE_HABIT_LIMIT} free habits. Plus lets you add as many as you like."
        PlusReason.CHECKLIST -> "Checklists come with Plus" to "One habit, several steps. Tick each one off, and it’s done when they all are."
        PlusReason.REMIND -> "Remind me again with Plus" to "If a habit isn’t done, you get another nudge later. None comes once it’s done."
        PlusReason.YEAR -> "Year in Pixels with Plus" to "Every day of your year as one square, coloured by how it went. See your good months at a glance."
        PlusReason.MENU -> "Plus" to if (owned) "Plus is yours. Thank you for supporting Often Enough." else "Pay once, keep forever.\nNo subscription, no account."
    }
    val words = @Composable { gap: androidx.compose.ui.unit.Dp, modifier: Modifier ->
        Column(modifier.semantics(mergeDescendants = true) { heading() }, verticalArrangement = Arrangement.spacedBy(gap)) {
            Text(head, style = AppType.headlineSmallEmphasized, color = s.onSurface)
            Text(lead, style = AppType.bodyLarge, color = s.onSurfaceVariant)
        }
    }
    if (reason == PlusReason.MENU) Row(horizontalArrangement = Arrangement.spacedBy(16.dp)) {
        AppIconTile(56.dp, flat = true)
        words(2.dp, Modifier.weight(1f))
    } else words(8.dp, Modifier)
}

/** A titled group: its heading in Label Large Primary, 16 in, and 8 under it its list or words. */
@Composable
private fun Section(title: String, content: @Composable ColumnScope.() -> Unit) =
    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
        Text(title, Modifier.padding(horizontal = 16.dp).semantics { heading() }, style = AppType.labelLarge, color = MaterialTheme.colorScheme.primary)
        SegmentedList(content = content)
    }

/** An example picture: drawn, never touched, read by TalkBack as one sentence. */
private fun Modifier.example(description: String) = this
    .clearAndSetSemantics { contentDescription = description }
    .pointerInput(Unit) { awaitPointerEventScope { while (true) awaitPointerEvent(PointerEventPass.Initial).changes.forEach { it.consume() } } }

/** 6th habit: the person's five habits and an empty dashed sixth spot; "5 of 5 free habits". */
@Composable
private fun SixthPicture(store: HabitStore) {
    val s = MaterialTheme.colorScheme
    val habits = store.habits.filter { !it.archived && it.kind != HabitKind.Task }
    val used = "${habits.size} of ${HabitStore.FREE_HABIT_LIMIT} free habits"
    Column(
        Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(s.surfaceBright).padding(start = 16.dp, end = 16.dp, top = 24.dp, bottom = 20.dp)
            .semantics(mergeDescendants = true) { contentDescription = used; testTag = "plus-sixth" },
        verticalArrangement = Arrangement.spacedBy(16.dp),
    ) {
        Row(horizontalArrangement = Arrangement.spacedBy(10.dp)) {
            habits.take(HabitStore.FREE_HABIT_LIMIT).forEach { HabitIcon(it.symbol, it.color, 40.dp, glyph = 22f / 40f) }
            // The sixth spot, empty: a dashed Primary ring with + in it.
            Box(Modifier.size(40.dp).drawBehind {
                val w = 1.5.dp.toPx()
                drawCircle(s.primary, radius = (size.minDimension - w) / 2, style = Stroke(w, pathEffect = PathEffect.dashPathEffect(floatArrayOf(4.dp.toPx(), 3.dp.toPx()))))
            }, contentAlignment = Alignment.Center) { Icon(Symbols.Add, null, Modifier.size(22.dp), tint = s.primary) }
        }
        Text(used, style = AppType.bodyMedium, color = s.onSurfaceVariant)
    }
}

/** Checklist: a Workout as it looks on Today, one of its three steps ticked and the steps open. */
@Composable
private fun WorkoutPicture() {
    val orange = appColors.habit(HabitColor.ORANGE)
    Column(Modifier.fillMaxWidth().example("An example: Workout, 1 of 3 steps done. Push-ups done; Squats and Plank to do."),
        verticalArrangement = Arrangement.spacedBy(2.dp)) {
        // An example: touches never reach it (example()), so its row and steps do nothing.
        HabitRowLayout("dumbbell.fill", HabitColor.ORANGE, "Workout", segmentShape(0, 2), onClick = {}, onLongClick = {},
            progress = { 1f / 3f }, line = { HabitRowLine("1/3 steps") }, streak = { HabitRowStreak(9, StreakUnit.DAYS) },
            action = { AppFilledIconButton(Symbols.ExpandLess, "Hide steps", {}) })
        StepRowBlock(segmentShape(1, 2)) {
            StepRow("Push-ups", true, orange, {})
            StepRow("Squats", false, orange, {})
            StepRow("Plank", false, orange, {})
        }
    }
}

/** Remind me again: a Walk reminder at 9:00 AM and, not done yet, another an hour later, on the habit's Fill. */
@Composable
private fun WalkPicture() {
    val c = appColors
    val nine = DayWords.clockMinute(9 * 60)
    val ten = DayWords.clockMinute(10 * 60)
    Column(
        Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.habitFill(HabitColor.GREEN)).padding(horizontal = 12.dp, vertical = 16.dp)
            .example("An example: a Walk reminder at $nine, and, not done yet, another at $ten: Still to do today."),
        verticalArrangement = Arrangement.spacedBy(12.dp),
    ) {
        Reminder("Often Enough · $nine", "Walk", "30 minutes")
        Row(Modifier.padding(start = 4.dp), horizontalArrangement = Arrangement.spacedBy(8.dp), verticalAlignment = Alignment.CenterVertically) {
            Icon(Symbols.NotificationsActive, null, Modifier.size(20.dp), tint = c.habitDeep(HabitColor.GREEN))
            Text("Not done yet · an hour later", style = AppType.labelLarge, color = c.habitDeep(HabitColor.GREEN))
        }
        Reminder("Often Enough · $ten", "Walk", "Still to do today.")
    }
}

/** A notification as Android shows it (Figma's Notification (native)): the app and time, the title, the line. */
@Composable
private fun Reminder(appAndTime: String, title: String, line: String) {
    val s = MaterialTheme.colorScheme
    Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(s.surfaceContainerLowest)
        .padding(start = 16.dp, end = 16.dp, top = 14.dp, bottom = 16.dp), verticalArrangement = Arrangement.spacedBy(4.dp)) {
        Row(horizontalArrangement = Arrangement.spacedBy(6.dp), verticalAlignment = Alignment.CenterVertically) {
            MarkIcon(16.dp)
            Text(appAndTime, style = AppType.bodySmall, color = s.onSurfaceVariant)
        }
        Text(title, style = AppType.titleMedium, color = s.onSurface)
        Text(line, style = AppType.bodyMedium, color = s.onSurfaceVariant)
    }
}

/** Figma's year of Water, by row (a day) and column (a month): D done, P part done, N not done, T to come. */
private val waterYear = listOf(
    "DDPDDDNDDPTT", "DDDDPDDNDDTT", "DDPDDDDDNDTT", "PDDDDDDPDDTT", "DDNDDDPDDDTT", "DDDDPDDNDDTT", "DDDPDDDDDPTT",
)

/** Year in Pixels: a year of Water, a square a day under the months' letters (Day cell, Size Year at 20, 4 apart). */
@Composable
private fun YearPicture(store: HabitStore) {
    val s = MaterialTheme.colorScheme
    val colors = dayCellColors(HabitColor.TEAL)
    val year = LocalDate.ofEpochDay(store.today().toLong()).year
    Column(
        Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(s.surfaceBright).padding(horizontal = 16.dp, vertical = 20.dp)
            .example("An example: a year of Water, a square a day, coloured by how each day went."),
        verticalArrangement = Arrangement.spacedBy(4.dp),
    ) {
        // The phone's language, read so a change redraws the letters.
        val locale = LocalConfiguration.current.locales[0]
        Row(horizontalArrangement = Arrangement.spacedBy(4.dp)) {
            for (m in 1..12) Text(Month.of(m).getDisplayName(TextStyle.NARROW, locale), Modifier.width(20.dp),
                style = AppType.labelSmall, color = s.onSurfaceVariant, textAlign = TextAlign.Center)
        }
        // Drawn in one pass (Rulebook S12).
        Canvas(Modifier.width(284.dp).height(164.dp)) {
            val cell = 20.dp.toPx()
            val step = 24.dp.toPx()
            val draw = DayCellDraw(cell, 1.dp.toPx())
            waterYear.forEachIndexed { row, days ->
                days.forEachIndexed { month, d ->
                    val state = when (d) { 'D' -> HeatCell.level(4); 'P' -> HeatCell.level(2); 'N' -> HeatCell.level(0); else -> HeatCell.Upcoming }
                    draw.add(state, month * step, row * step)
                }
            }
            draw.draw(this, colors)
        }
        Text("Water · $year", style = AppType.bodyMedium, color = s.onSurfaceVariant)
    }
}
