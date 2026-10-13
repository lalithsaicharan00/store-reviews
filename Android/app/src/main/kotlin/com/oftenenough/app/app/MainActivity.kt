package com.oftenenough.app.app

import android.os.Bundle
import androidx.fragment.app.FragmentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.clearAndSetSemantics
import androidx.compose.ui.semantics.semantics
import android.os.Build
import com.oftenenough.app.ui.settings.LockScreen
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
class MainActivity : FragmentActivity() {
    companion object {
        /** A reminder's tap: open this habit's Day details for this day. */
        const val OPEN_HABIT = "openHabit"
        const val OPEN_DAY = "openDay"
        /** A widget's link: "item/<id>" (Day details), "log/<id>", "slip/<id>", "timer/<id>", "plus", "today". */
        const val WIDGET_ROUTE = "widgetRoute"
    }

    override fun onStart() {
        super.onStart()
        if (AppGraph.isOpen) {
            AppGraph.lock.returned()
            // LOCKED (widget taps): waiting taps are saved on every return (W5).
            if (AppGraph.store.isLoaded) lifecycleScope.launch { WidgetTapSaver.saveWaiting(applicationContext) }
        }
    }

    override fun onStop() {
        super.onStop()
        if (AppGraph.isOpen) {
            AppGraph.lock.left()
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
        val test = intent.getBooleanExtra(TestLaunch.UITEST, false)
        if (test) {
            AppGraph.openForTest(this, intent.getIntExtra(TestLaunch.CLOCK_HOUR, -1).takeIf { it >= 0 })
            if (!intent.getBooleanExtra(TestLaunch.ONBOARDING, false)) AppGraph.prefs.onboarded = true
        } else AppGraph.open(this)
        val store = AppGraph.store
        AppGraph.openTarget(intent)
        splash.setKeepOnScreenCondition { !store.isLoaded && store.problem == null }
        pinWidget(intent)
        val demo = intent.getStringExtra(TestLaunch.DEMO)
        syncWhileOnScreen()
        setContent {
            if (demo != null && (test || BuildConfig.DEBUG)) LaunchedEffect(Unit) {
                snapshotFlow { store.isLoaded }.first { it }
                DemoData.seed(store, year = demo == "year", many = demo == "many")
            }
            // Test tags as resource IDs, so UI Automator (Macrobenchmark, the widget tests) finds what Compose tests find.
            OftenEnoughTheme(AppGraph.prefs.theme) {
                val lock = AppGraph.lock
                Box(Modifier.fillMaxSize().semantics { testTagsAsResourceId = true }) {
                    // While locked, the app stays as it was underneath, hidden from the screen and from TalkBack.
                    Box(Modifier.fillMaxSize().then(if (lock.isLocked) Modifier.clearAndSetSemantics {} else Modifier)) { AppRoot(store, AppGraph.prefs) }
                    if (lock.isLocked) LockScreen(lock)
                }
                // The recents screenshot shows nothing while App lock is on.
                LaunchedEffect(lock.isOn) { if (Build.VERSION.SDK_INT >= 33) setRecentsScreenshotEnabled(!lock.isOn) }
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
    /** "today" (the design's habits), "year" (a year of history), "many" (30 habits, two years). */
    const val DEMO = "demo"
    /** Show the welcome (test launches skip it otherwise). */
    const val ONBOARDING = "onboarding"
}
