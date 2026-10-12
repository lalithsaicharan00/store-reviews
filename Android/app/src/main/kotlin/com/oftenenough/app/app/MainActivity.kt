package com.oftenenough.app.app

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.snapshotFlow
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import com.oftenenough.app.BuildConfig
import com.oftenenough.app.data.DemoData
import com.oftenenough.app.ui.AppRoot
import com.oftenenough.app.ui.theme.OftenEnoughTheme
import kotlinx.coroutines.flow.first

/**
 * The one activity. A test launch passes extras (`uitest`, `clockHour`, `demo`, `onboarding`) and gets its own in-memory
 * database and preferences (D8); an ordinary launch opens the person's own.
 */
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        val splash = installSplashScreen()
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        val test = intent.getBooleanExtra(TestLaunch.UITEST, false)
        if (test) {
            AppGraph.openForTest(this, intent.getIntExtra(TestLaunch.CLOCK_HOUR, -1).takeIf { it >= 0 })
            if (!intent.getBooleanExtra(TestLaunch.ONBOARDING, false)) AppGraph.prefs.onboarded = true
        } else AppGraph.open(this)
        val store = AppGraph.store
        splash.setKeepOnScreenCondition { !store.isLoaded && store.problem == null }
        val demo = intent.getStringExtra(TestLaunch.DEMO)
        setContent {
            if (demo != null && (test || BuildConfig.DEBUG)) LaunchedEffect(Unit) {
                snapshotFlow { store.isLoaded }.first { it }
                DemoData.seed(store, year = demo == "year", many = demo == "many")
            }
            OftenEnoughTheme(AppGraph.prefs.theme) { AppRoot(store, AppGraph.prefs) }
        }
    }
}

/** The extras a test launch passes (Rulebook D8, T8, T11). */
object TestLaunch {
    const val UITEST = "uitest"
    /** The store's clock runs from this hour, :30 (T11). */
    const val CLOCK_HOUR = "clockHour"
    /** "today" (the design's habits), "year" (a year of history), "many" (30 habits, two years). */
    const val DEMO = "demo"
    /** Show the welcome (test launches skip it otherwise). */
    const val ONBOARDING = "onboarding"
}
