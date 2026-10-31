package com.oftenenough.app.app.reminders

import android.app.KeyguardManager
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.view.WindowManager
import androidx.activity.ComponentActivity
import androidx.activity.compose.BackHandler
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitCopy
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.widgets.WidgetItems
import com.oftenenough.app.ui.components.AppButton
import com.oftenenough.app.ui.components.ButtonSize
import com.oftenenough.app.ui.components.ButtonStyle
import com.oftenenough.app.ui.components.CookieShape
import com.oftenenough.app.ui.components.HabitIcon
import com.oftenenough.app.ui.components.StepRow
import com.oftenenough.app.ui.components.StepRowPlace
import com.oftenenough.app.ui.components.HabitProgress
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.OftenEnoughTheme
import com.oftenenough.app.ui.theme.Symbols
import com.oftenenough.app.ui.theme.appColors
import java.time.LocalDate
import java.time.format.DateTimeFormatter

/**
 * 5.11.4, **Alarm screen** (Figma 1274:1061, Kind Check · Amount · Typed amount · Time · Checklist · Task; the flow "An
 * alarm: turn it on, then answer it"): a reminder set to ring as an alarm (Remind me with: Alarm), over the lock screen,
 * when the person has let Often Enough's alarms fill the screen (5.11.5). It rings until answered: the ring is the
 * notification's, so answering here stops it the way the notification's own buttons do (`Reminders.answer`).
 *
 * On the habit's Fill colour: the clock (Display Large, "7:00") and "Reminder · Tue, 27 Oct" (Body Large, On surface
 * variant), 24 above, 16 under; the hero card (Surface container lowest, 28 corners, 24 by 28 in, 20 between, centred):
 * the habit's cookie (112, its glyph 56), its name (Headline Medium Emphasized) and description (Body Large, On surface
 * variant), then "Not done yet" (Headline Small) or the count ("3", Display Medium, and "of 8 glasses", Body Large) and
 * the progress line (wavy while its timer runs, A90); a checklist's card is its cookie (56), name, progress with "0 of 5 steps" and its steps. Under it,
 * 16 in: the main button (Filled, Large, round, the width), exactly Today's round button: **Done**, **+1 glass**,
 * **Log**, **Start**, **Tick Warm-up**; then Text buttons: **Log time** (time), **Open** (a checklist) and **Not now**
 * (the ring stops; the reminder stays as an ordinary notification). Log, Log time and Open ask to unlock, then open Add
 * log or the day in the app. Back is Not now.
 */
class AlarmActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        // Over the lock screen, and the screen comes on (an alarm clock's own activity does the same).
        if (Build.VERSION.SDK_INT >= 27) { setShowWhenLocked(true); setTurnScreenOn(true) }
        else @Suppress("DEPRECATION") window.addFlags(WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED or WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON)
        AppGraph.open(applicationContext)
        val store = AppGraph.store
        setContent {
            OftenEnoughTheme(AppGraph.prefs.theme) {
                Box(Modifier.fillMaxSize().semantics { testTagsAsResourceId = true }) {
                    val habit = store.habit(intent.getStringExtra(Reminders.EXTRA_HABIT) ?: "")?.takeIf { !it.archived }
                    if (!store.isLoaded) Box(Modifier.fillMaxSize().background(appColors.screen))
                    else if (habit == null) LaunchedEffect(Unit) { finish() }
                    else AlarmScreen(store, habit, intent.getIntExtra(Reminders.EXTRA_DAY, store.today()), intent.getIntExtra(Reminders.EXTRA_MINUTE, -1))
                }
            }
        }
    }

    /** What a button does here: the notification's own action, then the screen goes. */
    private fun answer(store: HabitStore, action: String, step: String? = null) {
        Reminders.answer(applicationContext, store, intent, action, step)
        finish()
    }

    /** Not now (and Back): the ring stops; the reminder stays in the shade. */
    private fun notNow(store: HabitStore) {
        Reminders.quiet(applicationContext, store, intent)
        finish()
    }

    /** Log, Log time and Open: the ring stops, the phone asks to unlock, then the app opens at [route] ("log/…", "item/…"). */
    private fun openApp(store: HabitStore, route: String, day: Int) {
        Reminders.quiet(applicationContext, store, intent)
        val open = { startActivity(Intent(this, MainActivity::class.java).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            .putExtra(MainActivity.WIDGET_ROUTE, route).putExtra(MainActivity.OPEN_DAY, day)); finish() }
        val keyguard = getSystemService(KeyguardManager::class.java)
        if (keyguard?.isKeyguardLocked == true) keyguard.requestDismissKeyguard(this, object : KeyguardManager.KeyguardDismissCallback() {
            override fun onDismissSucceeded() = open()
        }) else open()
    }

    @Composable
    private fun AlarmScreen(store: HabitStore, habit: Habit, day: Int, minute: Int) {
        val c = appColors
        val rule = store.rule(habit, day)
        val item = WidgetItems.item(store, habit, day, store.clock(), isToday = day == store.today())
        BackHandler { notNow(store) }
        Column(Modifier.fillMaxSize().background(c.habitFill(habit.color)).statusBarsPadding().navigationBarsPadding().semantics { testTag = "alarm-screen" }) {
            // The clock: the reminder's own time, as the phone writes times.
            val clock = if (minute >= 0) java.time.LocalTime.of(minute / 60, minute % 60)
                .format(DateTimeFormatter.ofPattern(if (android.text.format.DateFormat.is24HourFormat(this@AlarmActivity)) "H:mm" else "h:mm"))
                else ""
            Column(Modifier.fillMaxWidth().padding(top = 24.dp, bottom = 16.dp), horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.spacedBy(4.dp)) {
                if (clock.isNotEmpty()) Text(clock, style = AppType.displayLarge, color = c.ink)
                Text("Reminder · " + LocalDate.ofEpochDay(day.toLong()).format(DateTimeFormatter.ofPattern("EEE, d MMM")),
                    style = AppType.bodyLarge, color = c.secondary)
            }
            Box(Modifier.weight(1f).fillMaxWidth().padding(horizontal = 16.dp)) {
                Card(store, habit, rule, day, item)
            }
            Column(Modifier.fillMaxWidth().padding(start = 16.dp, end = 16.dp, top = 16.dp, bottom = 8.dp), horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.spacedBy(8.dp)) {
                Main(store, habit, rule, day)
                Row(horizontalArrangement = Arrangement.spacedBy(8.dp, Alignment.CenterHorizontally), verticalAlignment = Alignment.CenterVertically) {
                    when (rule.kind) {
                        HabitKind.Duration -> AppButton("Log time", { openApp(store, "log/${habit.id}", day) }, style = ButtonStyle.Text,
                            size = ButtonSize.Medium, tag = "alarm-log-time")
                        HabitKind.Checklist -> AppButton("Open", { openApp(store, "item/${habit.id}", day) }, style = ButtonStyle.Text,
                            size = ButtonSize.Medium, tag = "alarm-open")
                        else -> {}
                    }
                    AppButton("Not now", { notNow(store) }, style = ButtonStyle.Text, size = ButtonSize.Medium, tag = "alarm-not-now")
                }
            }
        }
    }

    /** The main button: exactly what Today's round button does for this habit. */
    @Composable
    private fun Main(store: HabitStore, habit: Habit, rule: Habit, day: Int) {
        val modifier = Modifier.fillMaxWidth()
        @Composable
        fun big(label: String, icon: androidx.compose.ui.graphics.vector.ImageVector, onClick: () -> Unit) =
            AppButton(label, onClick, modifier, size = ButtonSize.Large, icon = icon, tag = "alarm-main")
        when (val k = rule.kind) {
            HabitKind.Check, HabitKind.Task -> big("Done", Symbols.Check) { answer(store, Reminders.ACTION_DONE) }
            is HabitKind.Amount -> habit.quickIncrement?.let { step -> big("+" + HabitCopy.amount(step, k.unit), Symbols.Add) { answer(store, Reminders.ACTION_ADD) } }
                ?: big("Log", Symbols.Edit) { openApp(store, "log/${habit.id}", day) }
            HabitKind.Duration -> big("Start", Symbols.PlayArrow) { answer(store, Reminders.ACTION_START) }
            HabitKind.Checklist -> habit.steps.firstOrNull { !store.isStepDone(it, habit, day) }?.let { next ->
                big("Tick ${next.name}", Symbols.Check) { answer(store, Reminders.ACTION_TICK, next.id) }
            }
            HabitKind.Quit -> {}
        }
    }

    /** The hero card, as the routine player shows the habit (Figma's Alarm screen draws its own sizes). */
    @Composable
    private fun Card(store: HabitStore, habit: Habit, rule: Habit, day: Int, item: com.oftenenough.app.data.widgets.WidgetItem) {
        val c = appColors
        val checklist = rule.kind == HabitKind.Checklist
        val description = if (rule.kind == HabitKind.Task) "Task · for today" else store.descriptions[habit.id]
        Column(
            Modifier.fillMaxSize().clip(RoundedCornerShape(28.dp)).background(c.surface).verticalScroll(rememberScrollState())
                .padding(horizontal = 24.dp, vertical = if (checklist) 20.dp else 28.dp),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = if (checklist) Arrangement.spacedBy(12.dp) else Arrangement.spacedBy(20.dp, Alignment.CenterVertically),
        ) {
            HabitIcon(habit.symbol, habit.color, size = if (checklist) 56.dp else 112.dp, shape = CookieShape(), glyph = 0.5f)
            Column(horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(4.dp)) {
                Text(habit.name, Modifier.semantics { heading() }, style = AppType.headlineMediumEmphasized, color = c.ink, textAlign = TextAlign.Center,
                    maxLines = 2, overflow = TextOverflow.Ellipsis)
                if (!checklist && !description.isNullOrBlank()) Text(description, style = AppType.bodyLarge, color = c.secondary, textAlign = TextAlign.Center,
                    maxLines = 2, overflow = TextOverflow.Ellipsis)
            }
            val fraction = ((item.cardFraction ?: item.fraction) ?: 0.0).toFloat()
            val bar: @Composable (Modifier) -> Unit = { m ->
                if (!rule.atMost) HabitProgress(fraction, store.timers.containsKey(habit.id), m, color = c.habit(habit.color), trackColor = c.habitFill(habit.color))
            }
            when {
                checklist -> {
                    val done = rule.steps.count { store.isStepDone(it, habit, day) }
                    Row(verticalAlignment = Alignment.CenterVertically) {
                        bar(Modifier.weight(1f))
                        Spacer(Modifier.width(12.dp))
                        Text("$done of ${rule.steps.size} steps", style = AppType.labelLarge, color = c.secondary, maxLines = 1)
                    }
                    Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(16.dp)).background(c.screen), verticalArrangement = Arrangement.spacedBy(2.dp)) {
                        rule.steps.forEach { step ->
                            StepRow(step.name, store.isStepDone(step, habit, day), c.habit(habit.color), onToggle = {
                                if (!store.isStepDone(step, habit, day)) answer(store, Reminders.ACTION_TICK, step.id)
                            }, place = StepRowPlace.Today)
                        }
                    }
                }
                rule.kind == HabitKind.Task -> {}
                rule.kind == HabitKind.Check && rule.frequency.isDayBased && !store.rules.countsUp(habit, day) ->
                    Text(if (store.isTicked(habit, day)) "Done" else "Not done yet", style = AppType.headlineSmall, color = c.ink)
                else -> {
                    Row(verticalAlignment = Alignment.Bottom) {
                        Text(item.big, style = AppType.displayMedium, color = c.ink, maxLines = 1)
                        Spacer(Modifier.width(8.dp))
                        Text(item.goal, Modifier.padding(bottom = 6.dp), style = AppType.bodyLarge, color = c.secondary, maxLines = 1)
                    }
                    bar(Modifier.fillMaxWidth())
                }
            }
        }
    }
}
