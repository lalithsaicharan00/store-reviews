package com.oftenenough.app.ui

import com.oftenenough.app.ui.newhabit.EditHabitScreen
import com.oftenenough.app.ui.menu.MenuDrawer
import com.oftenenough.app.ui.settings.AppearancePage
import com.oftenenough.app.ui.settings.DayAndWeekPage
import com.oftenenough.app.ui.settings.SectionEditorScreen
import com.oftenenough.app.ui.settings.TimesOfDayPage
import com.oftenenough.app.ui.menu.MenuItem
import androidx.compose.material3.DrawerValue
import androidx.compose.material3.ModalNavigationDrawer
import androidx.compose.material3.rememberDrawerState
import androidx.compose.runtime.rememberCoroutineScope
import kotlinx.coroutines.launch
import com.oftenenough.app.ui.newhabit.NewHabitFlow

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
    // A page the welcome hands over to opens once Today's navigation exists (navigating before it is set up throws).
    var handOver by rememberSaveable { mutableStateOf<String?>(null) }
    if (!prefs.onboarded) {
        // Someone with habits already (Android's own Auto Backup brought them back) never sees the welcome.
        if (store.habits.isNotEmpty()) { prefs.onboarded = true; return }
        OnboardingFlow(store, object : OnboardingNav {
            override fun finished() { prefs.onboarded = true }
            override fun newHabit(idea: HabitIdea?) { handOver = Routes.NEW + (idea?.let { "?idea=" + android.net.Uri.encode(it.name) } ?: ""); prefs.onboarded = true }
            override fun signIn() { handOver = Routes.page("Google Drive & Backup"); prefs.onboarded = true }
            override fun restore() { handOver = Routes.page("Restore from a backup"); prefs.onboarded = true }
            override fun privacy() { handOver = Routes.page("Privacy & Security"); prefs.onboarded = true }
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
        override fun edit(habit: Habit) = nav.navigate(Routes.edit(habit.id))
        override fun pause(habit: Habit) = nav.navigate(Routes.page("Pause"))
    }
    NavHost(nav, startDestination = Routes.TODAY, modifier = Modifier.fillMaxSize().background(appColors.screen)) {
        composable(Routes.TODAY) {
            val drawer = rememberDrawerState(DrawerValue.Closed)
            val scope = rememberCoroutineScope()
            ModalNavigationDrawer(drawerContent = {
                MenuDrawer(store, MenuItem.TODAY) { item ->
                    scope.launch { drawer.close() }
                    if (item != MenuItem.TODAY) nav.navigate(Routes.menu(item))
                }
            }, drawerState = drawer) {
                TodayScreen(store, prefs, todayNav(nav) { scope.launch { drawer.open() } }, todayActions(nav, view) { h, d -> dayTarget = h.id + "|" + d }, snackbar)
            }
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
        composable(Routes.NEW + "?idea={idea}") { entry ->
            val idea = entry.arguments?.getString("idea")?.let { name -> HabitIdea.all.firstOrNull { it.name == name } }
            NewHabitFlow(store, idea, onClose = { nav.popBackStack() }, onSaved = { nav.popBackStack(Routes.TODAY, inclusive = false) },
                onPlus = { nav.navigate(Routes.page("Plus")) })
        }
        composable("edit/{id}") { e -> EditHabitScreen(e.arguments!!.getString("id")!!, store) { nav.popBackStack() } }
        composable("page/{title}") { entry ->
            when (val title = entry.arguments?.getString("title") ?: "") {
                MenuItem.DAY_AND_WEEK.title -> DayAndWeekPage(store) { nav.popBackStack() }
                MenuItem.APPEARANCE.title -> AppearancePage(prefs) { nav.popBackStack() }
                MenuItem.TIMES_OF_DAY.title -> TimesOfDayPage(store, { id -> nav.navigate("section/" + (id ?: "new")) }) { nav.popBackStack() }
                else -> NextPage(nav, title)
            }
        }
        composable("section/{id}") { e ->
            SectionEditorScreen(store, e.arguments!!.getString("id")!!.takeIf { it != "new" }) { nav.popBackStack() }
        }
    }
    LaunchedEffect(handOver) { handOver?.let { route -> handOver = null; nav.navigate(route) } }
}

object Routes {
    const val TODAY = "today"
    const val NEW = "new"
    fun page(title: String) = "page/" + android.net.Uri.encode(title)
    fun add(habit: String, day: Int) = "add/$habit/$day"
    fun log(id: String) = "log/$id"
    fun edit(id: String) = "edit/$id"
    fun menu(item: MenuItem) = page(item.title)
    fun allLogs(habit: String, day: Int) = "alllogs/$habit/$day"
    fun note(habit: String?, day: Int) = "note/${habit ?: "day"}/$day"
}

private fun todayNav(nav: NavHostController, openDrawer: () -> Unit) = object : TodayNav {
    override fun openMenu() = openDrawer()
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
    override fun editHabit(habit: Habit) = nav.navigate(Routes.edit(habit.id))
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
