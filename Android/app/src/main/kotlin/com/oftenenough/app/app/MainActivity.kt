package com.oftenenough.app.app

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.semantics
import android.os.Build
import androidx.compose.ui.semantics.testTagsAsResourceId
import androidx.compose.runtime.getValue
import androidx.compose.runtime.snapshotFlow
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import com.oftenenough.app.BuildConfig
import com.oftenenough.app.data.DemoData
import com.oftenenough.app.ui.AppRoot
import com.oftenenough.app.ui.theme.OftenEnoughTheme
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.lifecycleScope
import androidx.lifecycle.repeatOnLifecycle
import com.oftenenough.app.app.backup.SyncSchedule
import com.oftenenough.app.app.widgets.WidgetPublisher
import com.oftenenough.app.app.widgets.WidgetTapSaver

/**
 * The one activity. A test launch passes extras (`uitest`, `clockHour`, `demo`, `onboarding`) and gets its own in-memory
 * database and preferences (D8); an ordinary launch opens the person's own.
 */
class MainActivity : ComponentActivity() {
    /** The account chosen in Android's account chooser, while it is open. */
    private var picking: kotlinx.coroutines.CompletableDeferred<String?>? = null
    private val accountChooser = registerForActivityResult(androidx.activity.result.contract.ActivityResultContracts.StartActivityForResult()) { result ->
        picking?.complete(result.data?.getStringExtra(android.accounts.AccountManager.KEY_ACCOUNT_NAME).takeIf { result.resultCode == RESULT_OK })
        picking = null
    }

    /** The answer to Google's Drive permission screen, while it is open. */
    private var consenting: kotlinx.coroutines.CompletableDeferred<Boolean>? = null
    private val consentScreen = registerForActivityResult(androidx.activity.result.contract.ActivityResultContracts.StartIntentSenderForResult()) { result ->
        consenting?.complete(result.resultCode == RESULT_OK)
        consenting = null
    }

    /**
     * How Google Drive asks for permission (A4): its own screen, over this Activity, answered when it closes. The
     * link asks for it only when the grant is missing; after that a token comes back with no screen at all.
     */
    private fun driveConsent() {
        com.oftenenough.app.app.backup.DriveConsent.ask = { pending ->
            val answer = kotlinx.coroutines.CompletableDeferred<Boolean>()
            consenting = answer
            runCatching {
                consentScreen.launch(androidx.activity.result.IntentSenderRequest.Builder(pending).build())
            }.getOrElse { consenting = null; answer.complete(false) }
            answer.await()
        }
        com.oftenenough.app.app.backup.DriveConsent.pickAccount = {
            val answer = kotlinx.coroutines.CompletableDeferred<String?>()
            picking = answer
            runCatching {
                accountChooser.launch(android.accounts.AccountManager.newChooseAccountIntent(null, null, arrayOf("com.google"), null, null, null, null))
            }.getOrElse { picking = null; answer.complete(null) }
            answer.await()
        }
    }

    companion object {
        /** A reminder's tap: open this habit's Day details for this day. */
        const val OPEN_HABIT = "openHabit"
        /** A milestone notification's tap: "habitId|length", its pop-up on Today (Figma N.6). */
        const val OPEN_MILESTONE = "openMilestone"
        const val OPEN_DAY = "openDay"
        /** A widget's link: "item/<id>" (Day details), "log/<id>", "slip/<id>", "timer/<id>", "plus", "today". */
        const val WIDGET_ROUTE = "widgetRoute"
    }

    override fun onStart() {
        super.onStart()
        if (AppGraph.isOpen) {
            // LOCKED (widget taps): waiting taps are saved on every return (W5).
            if (AppGraph.store.isLoaded) lifecycleScope.launch { WidgetTapSaver.saveWaiting(applicationContext) }
            // Plus is asked of Google Play on every return (a pending payment finished, a refund). Play is the only
            // place it ever comes from (D16), so this is the whole of keeping it up to date.
            (AppGraph.plus as? PlayPlusStore)?.let { play -> lifecycleScope.launch { play.refresh() } }
        }
    }

    override fun onStop() {
        super.onStop()
        if (AppGraph.isOpen) {
            // LOCKED (widget taps): leaving the screen publishes at once, so the Home Screen shows what was just logged (W11).
            if (AppGraph.store.isLoaded) AppGraph.scope.launch { WidgetPublisher.publish(applicationContext, AppGraph.store) }
        }
    }

    /** Debug builds only: ask the launcher to add a widget (its own "Add to home screen" sheet), for checking widgets. */
    private fun pinWidget(intent: android.content.Intent) {
        if (!BuildConfig.DEBUG) return
        val name = intent.getStringExtra(TestLaunch.PIN_WIDGET) ?: return
        intent.removeExtra(TestLaunch.PIN_WIDGET)
        val receiver = android.content.ComponentName(this, "com.oftenenough.app.app.widgets.${name}WidgetReceiver")
        android.appwidget.AppWidgetManager.getInstance(this).requestPinAppWidget(receiver, null, null)
    }

    /** On screen: a Drive round on open and about once a minute after (D16, A7). Stops when the app leaves the screen. */
    private fun syncWhileOnScreen() {
        lifecycleScope.launch {
            repeatOnLifecycle(Lifecycle.State.STARTED) {
                while (true) {
                    if (AppGraph.isOpen && AppGraph.store.isLoaded && SyncSchedule.mayRun()) runCatching { AppGraph.backup.syncNow() }
                    delay(60_000)
                }
            }
        }
    }

    override fun onNewIntent(intent: android.content.Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        AppGraph.openTarget(intent)
        pinWidget(intent)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        val splash = installSplashScreen()
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        // The navigation bar takes the screen's own colour (the user, 13 Oct 2026). With three-button navigation Android
        // otherwise lays a white scrim behind the buttons, a white strip under the grey screens (seen on a moto g54).
        // Screens keep their content clear of it with navigationBarsPadding; gesture navigation is unchanged.
        // Android 8–9 keep the library's scrim: they can't always draw dark buttons on a light bar.
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.Q) window.isNavigationBarContrastEnforced = false
        driveConsent()
        val test = intent.getBooleanExtra(TestLaunch.UITEST, false)
        if (test) {
            AppGraph.openForTest(this, intent.getIntExtra(TestLaunch.CLOCK_HOUR, -1).takeIf { it >= 0 },
                plus = intent.getBooleanExtra(TestLaunch.PLUS, false))
        } else AppGraph.open(this)
        val store = AppGraph.store
        if (test) store.failNextTap = intent.getBooleanExtra(TestLaunch.FAIL_TAP, false)
        AppGraph.openTarget(intent)
        splash.setKeepOnScreenCondition { !store.isLoaded && store.problem == null }
        pinWidget(intent)
        val demo = intent.getStringExtra(TestLaunch.DEMO)
        if (test || BuildConfig.DEBUG) com.oftenenough.app.ui.today.TodayNotices.forced = intent.getStringExtra(TestLaunch.NOTICE)
        syncWhileOnScreen()
        setContent {
            if (demo != null && (test || BuildConfig.DEBUG)) LaunchedEffect(Unit) {
                snapshotFlow { store.isLoaded }.first { it }
                fun named(key: String) = intent.getStringExtra(key).orEmpty().split(",").mapNotNull { pair ->
                    pair.split("=").takeIf { it.size == 2 }?.let { (name, n) -> n.trim().toIntOrNull()?.let { name.trim() to it } }
                }.toMap()
                DemoData.seed(store, year = demo == "year", many = demo == "many", design = demo == "design", days = demo == "days", habitsPage = demo == "habits",
                    tasks = demo == "tasks", streaks = named(TestLaunch.STREAK), todays = named(TestLaunch.TODAY), runsBefore = named(TestLaunch.EARLIER))
                when (intent.getStringExtra(TestLaunch.MOMENTS)) {
                    "used" -> store.milestones.useUpToday()
                    "week" -> store.milestones.popupsThisWeek()
                }
                // A widget's tap, saved through the widget's own path (Figma 112:2: reached away), after the demo is in.
                intent.getStringExtra(TestLaunch.AWAY)?.let { name ->
                    store.habits.firstOrNull { it.name == name }?.let { h ->
                        val kind = if (h.kind == com.oftenenough.app.data.HabitKind.Check) "check" else "add"
                        store.saveWidgetTap(h.id, store.today(), kind, java.util.UUID.randomUUID().toString(), store.clock())
                    }
                }
                // The milestone notification its alarm would post (Figma 112:757), for the test to tap.
                intent.getStringExtra(TestLaunch.ALERT)?.let { name ->
                    store.habits.firstOrNull { it.name == name }?.let { com.oftenenough.app.app.reminders.MilestoneAlerts.showForTest(this@MainActivity, store, it) }
                }
            }
            // Test tags as resource IDs, so UI Automator (Macrobenchmark, the widget tests) finds what Compose tests find.
            OftenEnoughTheme(AppGraph.prefs.theme) {
                Box(Modifier.fillMaxSize().semantics { testTagsAsResourceId = true }) { AppRoot(store, AppGraph.prefs) }
            }
        }
    }
}

/** The extras a test launch passes (Rulebook D8, T8, T11). */
object TestLaunch {
    const val UITEST = "uitest"
    /** Debug builds: "OneHabit", "Today", "TodayLarge", "Week", "Tasks", "TasksLarge" asks the launcher to add that widget. */
    const val PIN_WIDGET = "pinWidget"
    /** The store's clock runs from this hour, :30 (T11). */
    const val CLOCK_HOUR = "clockHour"
    /** "today" (the design's habits), "design" (Today exactly as Figma 1958:2), "year" (a year of history), "many" (30 habits, two years). */
    const val DEMO = "demo"
    /** A Today notice to show whatever the phone's state ("full", "off", "removed", "missed", "late", "notifications", "pending"). */
    const val NOTICE = "notice"
    /** Plus owned from the start (the stand-in store, as if bought). */
    const val PLUS = "plus"
    /** The first tap's save fails, to see Couldn't save (Today flow 47). */
    const val FAIL_TAP = "failTap"
    /** The design demo's days in a row before today, by habit name: "Meds=29,Water=29" (the milestone flows). */
    const val STREAK = "streak"
    /** The design demo's amount logged today, by habit name: "Water=7". */
    const val TODAY = "today"
    /** The design demo's earlier run before a one-day break, by habit name: "Meds=7" (a number reached again). */
    const val EARLIER = "earlier"
    /** "used": today's milestone pop-up and bars are used up, so a milestone gets just the row (Figma 107:2); "week": the
     *  last two days each had a pop-up, the most in 7 days, so today's goes down to a bar (Figma 114:1551). */
    const val MOMENTS = "moments"
    /** A habit's name: one widget tap for it (✓ or +), saved as a widget saves it, as if made away from the app. */
    const val AWAY = "away"
    /** A quit or cut-down habit's name: its milestone notification, posted now (Figma 112:757). */
    const val ALERT = "alert"
}
