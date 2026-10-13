package com.oftenenough.app.ui

import com.oftenenough.app.ui.newhabit.EditHabitScreen
import com.oftenenough.app.ui.menu.MenuDrawer
import com.oftenenough.app.ui.menu.MenuSidebar
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.widthIn
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.ui.backup.BackupScreen
import com.oftenenough.app.ui.backup.RestoreScreen
import com.oftenenough.app.ui.settings.AboutPage
import com.oftenenough.app.ui.settings.AppearancePage
import com.oftenenough.app.ui.settings.HelpPage
import com.oftenenough.app.ui.settings.LicencesPage
import com.oftenenough.app.ui.settings.AppLockPage
import com.oftenenough.app.ui.settings.AppLockSetup
import com.oftenenough.app.ui.settings.PrivacyPage
import com.oftenenough.app.ui.settings.PlusPage
import com.oftenenough.app.ui.settings.RemindersSettingsPage
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
import com.oftenenough.app.ui.habit.HabitDetailsNav
import com.oftenenough.app.ui.habit.HabitDetailsScreen
import com.oftenenough.app.ui.habit.PauseScreen
import com.oftenenough.app.ui.habit.AllHabitsNav
import com.oftenenough.app.ui.habit.AllHabitsScreen
import com.oftenenough.app.ui.player.PlayerNav
import com.oftenenough.app.ui.player.RoutinePlayer
import com.oftenenough.app.ui.player.TimerScreen
import com.oftenenough.app.ui.progress.ProgressNav
import com.oftenenough.app.ui.progress.ProgressScreen

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
import androidx.navigation.compose.currentBackStackEntryAsState
import androidx.compose.material3.SnackbarHost
import androidx.compose.ui.Alignment
import androidx.compose.foundation.layout.navigationBarsPadding
import com.oftenenough.app.app.Prefs
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.onboarding.HabitIdea
import com.oftenenough.app.ui.onboarding.IdeasScreen
import com.oftenenough.app.ui.onboarding.OnboardingFlow
import com.oftenenough.app.ui.onboarding.OnboardingNav
import com.oftenenough.app.ui.theme.appColors
import com.oftenenough.app.ui.today.TodayActions
import com.oftenenough.app.ui.today.TodayNav
import com.oftenenough.app.ui.today.TodayScreen
import com.oftenenough.app.ui.today.GroupFormScreen
import com.oftenenough.app.ui.today.GroupsScreen
import com.oftenenough.app.ui.today.ArrangeDayScreen

/** The app: the welcome until it's finished, then Today and every page pushed over it (back returns one step, D7). */
@Composable
fun AppRoot(store: HabitStore, prefs: Prefs) {
    val nav = rememberNavController()
    val snackbar = remember { SnackbarHostState() }
    val rootScope = rememberCoroutineScope()
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
    // A widget's link opens its screen directly, replacing whatever was open (W8, W9).
    LaunchedEffect(AppGraph.widgetRoute) {
        val (route, d) = AppGraph.widgetRoute?.split("|")?.let { it[0] to (it.getOrNull(1)?.toIntOrNull() ?: -1) } ?: return@LaunchedEffect
        AppGraph.widgetRoute = null
        nav.popBackStack(Routes.TODAY, inclusive = false)
        dayTarget = null
        val day = if (d >= 0) d else store.today()
        val id = route.substringAfter("/", "")
        when (route.substringBefore("/")) {
            "item" -> if (store.habit(id) != null) dayTarget = "$id|$day"
            "log", "slip" -> if (store.habit(id) != null) nav.navigate(Routes.add(id, day))
            "timer" -> if (store.habit(id) != null) nav.navigate(Routes.timer(id))
            "plus" -> nav.navigate(Routes.menu(MenuItem.PLUS))
        }
    }
    // A reminder's tap opens that habit's Day details over Today.
    LaunchedEffect(AppGraph.dayToOpen) {
        AppGraph.dayToOpen?.let { target -> AppGraph.dayToOpen = null; nav.popBackStack(Routes.TODAY, inclusive = false); dayTarget = target }
    }
    val dayNav = dayNav(nav) { dayTarget = null }
    // Today places its own messages above the day bar; every other page shows them here, at the bottom.
    val entry = nav.currentBackStackEntryAsState().value
    val route = entry?.destination?.route
    // The sidebar marks the page open beside it (Today, or a menu page).
    val menuItem = when (route) {
        Routes.TODAY -> MenuItem.TODAY
        "page/{title}" -> entry?.arguments?.getString("title")?.let { t -> MenuItem.entries.firstOrNull { it.title == t } }
        else -> null
    }
    Box(Modifier.fillMaxSize().background(appColors.screen)) {
    AdaptiveFrame(store, menuItem, onPick = { item ->
        // A sidebar choice replaces the page beside it; it never piles pages up.
        nav.popBackStack(Routes.TODAY, inclusive = false)
        if (item != MenuItem.TODAY) nav.navigate(Routes.menu(item))
    }) {
    NavHost(nav, startDestination = Routes.TODAY, modifier = Modifier.fillMaxSize().background(appColors.screen)) {
        composable(Routes.TODAY) {
            val drawer = rememberDrawerState(DrawerValue.Closed)
            val scope = rememberCoroutineScope()
            // Back closes the open menu first; it used to leave the app.
            androidx.activity.compose.BackHandler(enabled = drawer.isOpen) { scope.launch { drawer.close() } }
            // With the sidebar (tablets, unfolded foldables) there's no drawer to open; the phone is untouched.
            if (LocalSidebar.current) {
                TodayScreen(store, prefs, todayNav(nav) {}, todayActions(nav, view) { h, d -> dayTarget = h.id + "|" + d }, snackbar)
            } else ModalNavigationDrawer(drawerContent = {
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
                MenuItem.PROGRESS.title -> WithDay(store, nav) { openDay ->
                    ProgressScreen(store, prefs, object : ProgressNav {
                        override fun openHabit(habit: Habit) = nav.navigate(Routes.habit(habit.id))
                        override fun openDay(habit: Habit, day: Int) = openDay(habit, day)
                    }) { nav.popBackStack() }
                }
                MenuItem.HABITS.title, MenuItem.TASKS.title -> AllHabitsScreen(title == MenuItem.TASKS.title, store, object : AllHabitsNav {
                    override fun open(habit: Habit) = nav.navigate(Routes.habit(habit.id))
                    override fun pause(habits: List<Habit>) { if (habits.isNotEmpty()) nav.navigate(Routes.pause(habits.map { it.id })) }
                    override fun addTask() = nav.navigate(Routes.NEW_TASK)
                }) { nav.popBackStack() }
                MenuItem.REMINDERS.title -> RemindersSettingsPage(store, { h -> nav.navigate(Routes.edit(h.id)) }) { nav.popBackStack() }
                MenuItem.PRIVACY.title -> PrivacyPage(prefs, AppGraph.lock, { nav.navigate(Routes.page("App lock")) }) { nav.popBackStack() }
                "App lock" -> AppLockPage(AppGraph.lock, { nav.navigate(Routes.LOCK_SETUP) }, { nav.navigate(Routes.LOCK_PASSCODE) }) { nav.popBackStack() }
                MenuItem.PLUS.title -> PlusPage(store, AppGraph.plus, snackbar, { nav.navigate(Routes.menu(MenuItem.HELP)) }) { nav.popBackStack() }
                "Arrange your day" -> ArrangeDayScreen(store, { id -> nav.navigate("section/" + (id ?: "new")) }) { nav.popBackStack() }
                MenuItem.HELP.title -> HelpPage({ nav.navigate(Routes.WELCOME) }) { nav.popBackStack() }
                MenuItem.ABOUT.title -> AboutPage({ nav.navigate(Routes.page("Open source licences")) }) { nav.popBackStack() }
                "Open source licences" -> LicencesPage { nav.popBackStack() }
                MenuItem.DAY_AND_WEEK.title -> DayAndWeekPage(store) { nav.popBackStack() }
                MenuItem.APPEARANCE.title -> AppearancePage(prefs) { nav.popBackStack() }
                MenuItem.BACKUP.title -> BackupScreen(AppGraph.backup, store, { nav.navigate(Routes.page("Restore from a backup")) },
                    { nav.navigate(Routes.menu(MenuItem.PLUS)) }, { nav.popBackStack() }, snackbar)
                "Restore from a backup" -> RestoreScreen(AppGraph.backup, store, { nav.popBackStack() }) { message ->
                    nav.popBackStack()
                    rootScope.launch { snackbar.showSnackbar(message) }
                }
                "Start from an idea" -> IdeasScreen({ nav.popBackStack() }) { idea ->
                    nav.popBackStack(); nav.navigate(Routes.NEW + "?idea=" + android.net.Uri.encode(idea.name))
                }
                MenuItem.TIMES_OF_DAY.title -> TimesOfDayPage(store, { id -> nav.navigate("section/" + (id ?: "new")) }) { nav.popBackStack() }
                // A page that doesn't exist (an old link): straight back.
                else -> LaunchedEffect(title) { nav.popBackStack() }
            }
        }
        composable("habit/{id}") { e ->
            val id = e.arguments!!.getString("id")!!
            WithDay(store, nav) { openDay ->
                HabitDetailsScreen(id, store, object : HabitDetailsNav {
                    override fun openDay(habit: Habit, day: Int) = openDay(habit, day)
                    override fun addLog(habit: Habit, day: Int) = nav.navigate(Routes.add(habit.id, day))
                    override fun note(habit: Habit, day: Int) = nav.navigate(Routes.note(habit.id, day))
                    override fun edit(habit: Habit) = nav.navigate(Routes.edit(habit.id))
                    override fun pause(habit: Habit) = nav.navigate(Routes.pause(habit.id))
                }) { nav.popBackStack() }
            }
        }
        composable("routine/{part}/{day}/{ids}") { e ->
            val a = e.arguments!!
            WithDay(store, nav) { openDay ->
                RoutinePlayer(store, a.getString("part")!!, a.getString("day")!!.toInt(), a.getString("ids")!!.split(",").filter { it.isNotEmpty() },
                    object : PlayerNav {
                        override fun openDay(habit: Habit, day: Int) = openDay(habit, day)
                        override fun addLog(habit: Habit, day: Int) = nav.navigate(Routes.add(habit.id, day))
                        override fun openTimer(habit: Habit) = nav.navigate(Routes.timer(habit.id))
                    }) { nav.popBackStack() }
            }
        }
        composable(Routes.WELCOME) {
            OnboardingFlow(store, object : OnboardingNav {
                override fun finished() { nav.popBackStack() }
                override fun newHabit(idea: HabitIdea?) { nav.popBackStack(Routes.TODAY, inclusive = false); nav.navigate(Routes.NEW + (idea?.let { "?idea=" + android.net.Uri.encode(it.name) } ?: "")) }
                override fun signIn() { nav.popBackStack(); nav.navigate(Routes.menu(MenuItem.BACKUP)) }
                override fun restore() { nav.popBackStack(); nav.navigate(Routes.page("Restore from a backup")) }
                override fun privacy() { nav.popBackStack(); nav.navigate(Routes.menu(MenuItem.PRIVACY)) }
            }, replay = true)
        }
        composable("pause/{ids}") { e -> PauseScreen(e.arguments!!.getString("ids")!!.split(","), store) { nav.popBackStack() } }
        composable(Routes.LOCK_SETUP) { AppLockSetup(AppGraph.lock, passcodeOnly = false) { nav.popBackStack() } }
        composable(Routes.LOCK_PASSCODE) { AppLockSetup(AppGraph.lock, passcodeOnly = true) { nav.popBackStack() } }
        composable(Routes.GROUPS) { GroupsScreen(store, { id -> nav.navigate(Routes.group(id)) }) { nav.popBackStack() } }
        composable("group/{id}") { e ->
            GroupFormScreen(store, e.arguments!!.getString("id")!!.takeIf { it != "new" }, { hs -> nav.navigate(Routes.pause(hs.map { it.id })) }) { nav.popBackStack() }
        }
        composable(Routes.NEW_TASK) {
            NewHabitFlow(store, null, onClose = { nav.popBackStack() }, onSaved = { nav.popBackStack() }, onPlus = { nav.navigate(Routes.menu(MenuItem.PLUS)) }, task = true)
        }
        composable("timer/{id}") { e ->
            val id = e.arguments!!.getString("id")!!
            WithDay(store, nav) { openDay ->
                TimerScreen(store, id, { nav.popBackStack() },
                    onLogManually = { nav.navigate(Routes.add(id, store.today())) },
                    onOpenDay = { store.habit(id)?.let { openDay(it, store.today()) } })
            }
        }
        composable("section/{id}") { e ->
            SectionEditorScreen(store, e.arguments!!.getString("id")!!.takeIf { it != "new" }) { nav.popBackStack() }
        }
    }
    }
    if (route != null && route != Routes.TODAY) SnackbarHost(snackbar, Modifier.align(Alignment.BottomCenter).navigationBarsPadding().padding(bottom = 96.dp))
    }
    LaunchedEffect(handOver) { handOver?.let { target -> handOver = null; nav.navigate(target) } }
}

/** True where the menu is a sidebar beside the page (840 dp and wider), so pages don't show a menu button. */
val LocalSidebar = androidx.compose.runtime.staticCompositionLocalOf { false }

/** The window's width, in dp, as the app lays itself out by it. */
object WindowWidth {
    /** From here the menu is a sidebar and the page a centred column. */
    const val EXPANDED = 840
    /** At most this wide: the phone's own column, centred (the iPad's ~700 pt, I5). */
    const val COLUMN = 720
}

/**
 * Tablets and foldables (A11 D9; the iPad's decisions, U35): the same app in a wider frame, and **the phone never
 * changes for it**. Under 840 dp (phones, a folded foldable, a narrow window, a small tablet in portrait) this adds
 * nothing: it is the phone's app, exactly. From 840 dp the menu is a sidebar that stays, and the page beside it is one
 * centred column at most 720 dp wide: the phone's cards at their own size, never stretched.
 */
@Composable
private fun AdaptiveFrame(store: HabitStore, current: MenuItem?, onPick: (MenuItem) -> Unit, content: @Composable () -> Unit) {
    val width = androidx.compose.ui.platform.LocalConfiguration.current.screenWidthDp
    if (width < WindowWidth.EXPANDED) { content(); return }
    androidx.compose.runtime.CompositionLocalProvider(LocalSidebar provides true) {
        androidx.compose.foundation.layout.Row(Modifier.fillMaxSize()) {
            MenuSidebar(store, current, onPick)
            Box(Modifier.weight(1f).fillMaxHeight(), contentAlignment = Alignment.TopCenter) {
                Box(Modifier.widthIn(max = WindowWidth.COLUMN.dp).fillMaxHeight()) { content() }
            }
        }
    }
}

object Routes {
    const val TODAY = "today"
    const val NEW = "new"
    const val WELCOME = "welcome"
    const val NEW_TASK = "newtask"
    const val GROUPS = "groups"
    fun group(id: String?) = "group/" + (id ?: "new")
    const val LOCK_SETUP = "applock/setup"
    const val LOCK_PASSCODE = "applock/passcode"
    fun page(title: String) = "page/" + android.net.Uri.encode(title)
    fun add(habit: String, day: Int) = "add/$habit/$day"
    fun log(id: String) = "log/$id"
    fun edit(id: String) = "edit/$id"
    fun menu(item: MenuItem) = page(item.title)
    fun allLogs(habit: String, day: Int) = "alllogs/$habit/$day"
    fun note(habit: String?, day: Int) = "note/${habit ?: "day"}/$day"
    fun habit(id: String) = "habit/$id"
    fun timer(id: String) = "timer/$id"
    fun pause(id: String) = "pause/$id"
    fun pause(ids: List<String>) = "pause/" + ids.joinToString(",")
    fun routine(part: String, day: Int, ids: List<String>) = "routine/" + android.net.Uri.encode(part) + "/$day/" + ids.joinToString(",")
}

/** Day details' way out to the pages it opens; [close] closes the sheet first where a page replaces it. */
private fun dayNav(nav: NavHostController, close: () -> Unit) = object : DayNav {
    override fun habitPage(habit: Habit) { close(); nav.navigate(Routes.habit(habit.id)) }
    override fun addLog(habit: Habit, day: Int) = nav.navigate(Routes.add(habit.id, day))
    override fun note(habit: Habit, day: Int) = nav.navigate(Routes.note(habit.id, day))
    override fun log(habit: Habit, entry: Entry) = nav.navigate(Routes.log(entry.id))
    override fun allLogs(habit: Habit, day: Int) = nav.navigate(Routes.allLogs(habit.id, day))
    override fun edit(habit: Habit) = nav.navigate(Routes.edit(habit.id))
    override fun pause(habit: Habit) = nav.navigate(Routes.pause(habit.id))
}

/**
 * A page that opens Day details over itself (Habit details, Progress, the player, the timer). The sheet's target is kept
 * with the page, so going back from a page the sheet opened returns to the sheet, as on Today.
 */
@Composable
private fun WithDay(store: HabitStore, nav: NavHostController, content: @Composable (openDay: (Habit, Int) -> Unit) -> Unit) {
    var target by rememberSaveable { mutableStateOf<String?>(null) }
    content { h, d -> target = h.id + "|" + d }
    target?.split("|")?.let { (id, d) ->
        DayDetailsSheet(id, d.toInt(), store, dayNav(nav) { target = null }) { target = null }
    }
}

private fun todayNav(nav: NavHostController, openDrawer: () -> Unit) = object : TodayNav {
    override fun openMenu() = openDrawer()
    override fun newHabit() = nav.navigate(Routes.NEW)
    override fun ideas() = nav.navigate(Routes.page("Start from an idea"))
    override fun restore() = nav.navigate(Routes.page("Restore from a backup"))
    override fun help() = nav.navigate(Routes.page("Help & Feedback"))
    override fun arrange() = nav.navigate(Routes.page("Arrange your day"))
    override fun newGroup() = nav.navigate(Routes.group(null))
    override fun editGroups() = nav.navigate(Routes.GROUPS)
    override fun startRoutine(part: String, day: Int, habits: List<Habit>) = nav.navigate(Routes.routine(part, day, habits.map { it.id }))
}

private fun todayActions(nav: NavHostController, view: android.view.View, openDay: (Habit, Int) -> Unit) = object : TodayActions {
    override fun openDay(habit: Habit, day: Int) = openDay(habit, day)
    override fun addLog(habit: Habit, day: Int) = nav.navigate(Routes.add(habit.id, day))
    override fun writeNote(habit: Habit?, day: Int) = nav.navigate(Routes.note(habit?.id, day))
    override fun openTimer(habit: Habit) = nav.navigate(Routes.timer(habit.id))
    override fun editHabit(habit: Habit) = nav.navigate(Routes.edit(habit.id))
    override fun openHabitPage(habit: Habit) = nav.navigate(Routes.habit(habit.id))
    override fun pause(habit: Habit) = nav.navigate(Routes.pause(habit.id))
    override fun feedback(done: Boolean) { view.performHapticFeedback(HapticFeedbackConstants.CONFIRM) }
}
