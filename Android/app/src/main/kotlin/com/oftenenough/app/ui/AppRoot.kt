package com.oftenenough.app.ui

import android.view.HapticFeedbackConstants
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.ArrowBack
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import com.oftenenough.app.data.Entry
import com.oftenenough.app.ui.day.DayDetailsSheet
import com.oftenenough.app.ui.day.DayNav
import com.oftenenough.app.ui.record.AddLogScreen
import com.oftenenough.app.ui.record.AllLogsScreen
import com.oftenenough.app.ui.record.LogScreen
import com.oftenenough.app.ui.record.NoteScreen
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalView
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.oftenenough.app.app.Prefs
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.onboarding.HabitIdea
import com.oftenenough.app.ui.onboarding.OnboardingFlow
import com.oftenenough.app.ui.onboarding.OnboardingNav
import com.oftenenough.app.ui.theme.appColors
import com.oftenenough.app.ui.today.TodayActions
import com.oftenenough.app.ui.today.TodayNav
import com.oftenenough.app.ui.today.TodayScreen

/** The app: the welcome until it's finished, then Today and every page pushed over it (back returns one step, D7). */
@Composable
fun AppRoot(store: HabitStore, prefs: Prefs) {
    val nav = rememberNavController()
    val snackbar = remember { SnackbarHostState() }
    val view = LocalView.current
    LaunchedEffect(store) {
        store.onLog = { done ->
            if (prefs.vibration) view.performHapticFeedback(if (done) HapticFeedbackConstants.CONFIRM else HapticFeedbackConstants.CLOCK_TICK)
        }
    }
    LaunchedEffect(store.problem) { store.problem?.let { snackbar.showSnackbar(it); store.problem = null } }
    if (!store.isLoaded) { Box(Modifier.fillMaxSize().background(appColors.screen)); return }
    if (!prefs.onboarded) {
        // Someone with habits already (Android's own Auto Backup brought them back) never sees the welcome.
        if (store.habits.isNotEmpty()) { prefs.onboarded = true; return }
        OnboardingFlow(store, object : OnboardingNav {
            override fun finished() { prefs.onboarded = true }
            override fun newHabit(idea: HabitIdea?) { prefs.onboarded = true; nav.navigate(Routes.NEW + (idea?.let { "?idea=${it.name}" } ?: "")) }
            override fun signIn() { prefs.onboarded = true; nav.navigate(Routes.page("Google Drive & Backup")) }
            override fun restore() { prefs.onboarded = true; nav.navigate(Routes.page("Restore from a backup")) }
            override fun privacy() { prefs.onboarded = true; nav.navigate(Routes.page("Privacy & Security")) }
        })
        return
    }
    // Day details over Today: kept while a page it opened is on top, so going back returns to it.
    var dayTarget by rememberSaveable { mutableStateOf<String?>(null) }
    val dayNav = object : DayNav {
        override fun habitPage(habit: Habit) { dayTarget = null; nav.navigate(Routes.page("Habit details")) }
        override fun addLog(habit: Habit, day: Int) = nav.navigate(Routes.add(habit.id, day))
        override fun note(habit: Habit, day: Int) = nav.navigate(Routes.note(habit.id, day))
        override fun log(habit: Habit, entry: Entry) = nav.navigate(Routes.log(entry.id))
        override fun allLogs(habit: Habit, day: Int) = nav.navigate(Routes.allLogs(habit.id, day))
        override fun edit(habit: Habit) = nav.navigate(Routes.page("Edit habit"))
        override fun pause(habit: Habit) = nav.navigate(Routes.page("Pause"))
    }
    NavHost(nav, startDestination = Routes.TODAY, modifier = Modifier.fillMaxSize().background(appColors.screen)) {
        composable(Routes.TODAY) {
            TodayScreen(store, prefs, todayNav(nav), todayActions(nav, view) { h, d -> dayTarget = h.id + "|" + d }, snackbar)
            dayTarget?.split("|")?.let { (id, d) ->
                DayDetailsSheet(id, d.toInt(), store, dayNav) { dayTarget = null }
            }
        }
        composable("add/{habit}/{day}") { e ->
            AddLogScreen(e.arguments!!.getString("habit")!!, e.arguments!!.getString("day")!!.toInt(), store) { nav.popBackStack() }
        }
        composable("log/{id}") { e -> LogScreen(e.arguments!!.getString("id")!!, store) { nav.popBackStack() } }
        composable("alllogs/{habit}/{day}") { e ->
            AllLogsScreen(e.arguments!!.getString("habit")!!, e.arguments!!.getString("day")!!.toInt(), store, { nav.navigate(Routes.log(it.id)) }) { nav.popBackStack() }
        }
        composable("note/{habit}/{day}") { e ->
            NoteScreen(e.arguments!!.getString("habit")!!.takeIf { it != "day" }, e.arguments!!.getString("day")!!.toInt(), store) { nav.popBackStack() }
        }
        composable(Routes.NEW + "?idea={idea}") { entry -> NextPage(nav, "New") }
        composable("page/{title}") { entry -> NextPage(nav, entry.arguments?.getString("title") ?: "") }
    }
}

object Routes {
    const val TODAY = "today"
    const val NEW = "new"
    fun page(title: String) = "page/" + android.net.Uri.encode(title)
    fun add(habit: String, day: Int) = "add/$habit/$day"
    fun log(id: String) = "log/$id"
    fun allLogs(habit: String, day: Int) = "alllogs/$habit/$day"
    fun note(habit: String?, day: Int) = "note/${habit ?: "day"}/$day"
}

private fun todayNav(nav: NavHostController) = object : TodayNav {
    override fun openMenu() = nav.navigate(Routes.page("Menu"))
    override fun newHabit() = nav.navigate(Routes.NEW)
    override fun ideas() = nav.navigate(Routes.page("Start from an idea"))
    override fun restore() = nav.navigate(Routes.page("Restore from a backup"))
    override fun help() = nav.navigate(Routes.page("Help & Feedback"))
    override fun arrange() = nav.navigate(Routes.page("Arrange your day"))
    override fun filter() = nav.navigate(Routes.page("Filter"))
    override fun startRoutine(part: String, day: Int, habits: List<Habit>) = nav.navigate(Routes.page("Routine"))
}

private fun todayActions(nav: NavHostController, view: android.view.View, openDay: (Habit, Int) -> Unit) = object : TodayActions {
    override fun openDay(habit: Habit, day: Int) = openDay(habit, day)
    override fun addLog(habit: Habit, day: Int) = nav.navigate(Routes.add(habit.id, day))
    override fun writeNote(habit: Habit?, day: Int) = nav.navigate(Routes.note(habit?.id, day))
    override fun openTimer(habit: Habit) {}
    override fun editHabit(habit: Habit) = nav.navigate(Routes.page("Edit habit"))
    override fun openHabitPage(habit: Habit) = nav.navigate(Routes.page("Habit details"))
    override fun pause(habit: Habit) = nav.navigate(Routes.page("Pause"))
    override fun feedback(done: Boolean) { view.performHapticFeedback(HapticFeedbackConstants.CONFIRM) }
}

/** A page built at the next checkpoint (Day details, the form, settings …): back returns to Today. */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun NextPage(nav: NavHostController, title: String) {
    Column(Modifier.fillMaxSize().background(appColors.screen)) {
        TopAppBar(title = { Text(title) }, navigationIcon = { IconButton({ nav.popBackStack() }) { Icon(Icons.AutoMirrored.Rounded.ArrowBack, "Back") } },
            colors = TopAppBarDefaults.topAppBarColors(containerColor = appColors.screen))
        Text("Coming in the next checkpoint.", Modifier.padding(24.dp), style = MaterialTheme.typography.bodyLarge, color = appColors.secondary)
    }
}
