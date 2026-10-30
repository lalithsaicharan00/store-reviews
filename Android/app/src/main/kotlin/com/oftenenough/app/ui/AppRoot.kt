package com.oftenenough.app.ui

import com.oftenenough.app.ui.components.AppSnackbarHost
import android.view.View
import kotlinx.coroutines.CoroutineScope
import androidx.compose.runtime.MutableState
import com.oftenenough.app.ui.newhabit.EditHabitScreen
import com.oftenenough.app.ui.menu.MenuDrawer
import com.oftenenough.app.ui.menu.MenuSidebar
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.widthIn
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.ui.backup.BackupScreen
import com.oftenenough.app.ui.settings.AboutPage
import com.oftenenough.app.ui.settings.AppearancePage
import com.oftenenough.app.ui.settings.HelpPage
import com.oftenenough.app.ui.settings.LicencesPage
import com.oftenenough.app.ui.settings.AppLockPage
import com.oftenenough.app.ui.settings.AppLockSetup
import com.oftenenough.app.ui.settings.PrivacyPage
import com.oftenenough.app.ui.settings.DayAndWeekPage
import com.oftenenough.app.ui.settings.SectionEditorScreen
import com.oftenenough.app.ui.settings.SettingsHome
import com.oftenenough.app.ui.settings.SettingsPage
import com.oftenenough.app.ui.settings.Support
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
import com.oftenenough.app.ui.habit.ArchivedNav
import com.oftenenough.app.ui.habit.ArchivedHabitsScreen
import com.oftenenough.app.ui.habit.HabitsNav
import com.oftenenough.app.ui.habit.HabitsPage
import com.oftenenough.app.ui.player.PlayerNav
import com.oftenenough.app.ui.player.RoutinePlayer
import com.oftenenough.app.ui.player.TimerScreen
import com.oftenenough.app.ui.progress.ProgressNav
import com.oftenenough.app.ui.progress.ProgressScreen

import android.view.HapticFeedbackConstants
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.SnackbarHostState
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
import androidx.compose.ui.Alignment
import androidx.compose.foundation.layout.navigationBarsPadding
import com.oftenenough.app.app.Prefs
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.onboarding.HabitIdea
import com.oftenenough.app.ui.onboarding.IdeasScreen
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
    // **No onboarding** (the new Figma file, 22 October 2026): Android's own splash, then Today. Someone new sees
    // Today's "No habits yet" (Figma `36:32`), which offers New habit and Restore from a backup, and that is the whole
    // of the first run. The welcome, its three pages, Your days and weeks, Your first habit and the "coming back"
    // flow are gone; nothing is asked before the app is usable.
    val handOverState = rememberSaveable { mutableStateOf<String?>(null) }
    AppMain(store, prefs, nav, snackbar, rootScope, view, handOverState)
}

/** Today and every page pushed over it, once the welcome is finished. */
@Composable
private fun AppMain(
    store: HabitStore, prefs: Prefs, nav: NavHostController, snackbar: SnackbarHostState, rootScope: CoroutineScope,
    view: View, handOverState: MutableState<String?>,
) {
    var handOver by handOverState
    // Today's folds and held order, kept while pages open over Today and come back.
    val todayLayout = remember { com.oftenenough.app.ui.today.TodayLayout(rootScope) }
    // Day details over Today: kept while a page it opened is on top, so going back returns to it.
    var dayTarget by rememberSaveable { mutableStateOf<String?>(null) }
    // Restore from Google Play found nothing: Plus shows "No Plus found" over itself (Figma 4.2).
    var noPlusFound by rememberSaveable { mutableStateOf(false) }
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
            // A timer started in a routine: its Live Update opens that routine at that habit (Figma 10.5).
            "player" -> {
                val parts = id.split("/")
                val part = android.net.Uri.decode(parts.getOrNull(0) ?: "")
                val at = parts.getOrNull(2)
                val on = parts.getOrNull(1)?.toIntOrNull() ?: store.today()
                val habits = routineHabits(store, part, on)
                if (at != null && store.habit(at) != null) {
                    if (habits.isNotEmpty() && at in habits) nav.navigate(Routes.routine(part, on, habits, at)) else nav.navigate(Routes.timer(at))
                }
            }
            "plus" -> nav.navigate(Routes.GET_PLUS)
            // The app icon's long-press shortcuts (A11 D8).
            "new" -> nav.navigate(Routes.NEW)
            "routine" -> nextRoutine(store)?.let { (part, habits) -> nav.navigate(Routes.routine(part, store.today(), habits)) }
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
    LaunchedEffect(route) { if (route != null && route != Routes.TODAY && route !in pagesOverToday) store.afterLog = null }
    // The sidebar marks the page open beside it (Today, or a menu page).
    val menuItem = when (route) {
        Routes.TODAY -> MenuItem.TODAY
        "page/{title}" -> entry?.arguments?.getString("title")?.let { t -> MenuItem.entries.firstOrNull { it.title == t } }
        else -> null
    }
    Box(Modifier.fillMaxSize().background(appColors.screen)) {
    val appContext = androidx.compose.ui.platform.LocalContext.current
    AdaptiveFrame(store, menuItem, onPick = { item -> openMenuItem(item, nav, appContext) }) {
    NavHost(nav, startDestination = Routes.TODAY, modifier = Modifier.fillMaxSize().background(appColors.screen)) {
        composable(Routes.TODAY) {
            val drawer = rememberDrawerState(DrawerValue.Closed)
            val scope = rememberCoroutineScope()
            // Back closes the open menu first; it used to leave the app.
            androidx.activity.compose.BackHandler(enabled = drawer.isOpen) { scope.launch { drawer.close() } }
            // With the sidebar (tablets, unfolded foldables) there's no drawer to open; the phone is untouched.
            if (LocalSidebar.current) {
                TodayScreen(store, prefs, todayNav(nav) {}, todayActions(nav, view) { h, d -> dayTarget = h.id + "|" + d }, snackbar, todayLayout)
            } else ModalNavigationDrawer(drawerContent = {
                MenuDrawer(store, MenuItem.TODAY) { item ->
                    scope.launch { drawer.close() }
                    openMenuItem(item, nav, appContext)
                }
            }, drawerState = drawer) {
                TodayScreen(store, prefs, todayNav(nav) { scope.launch { drawer.open() } }, todayActions(nav, view) { h, d -> dayTarget = h.id + "|" + d }, snackbar, todayLayout)
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
        composable(Routes.NEW + "?idea={idea}&name={name}&copy={copy}&from={from}") { entry ->
            val a = entry.arguments
            val idea = a?.getString("idea")?.let { name -> HabitIdea.all.firstOrNull { it.name == name } }
            val copyOf = a?.getString("copy")?.let { store.habit(it) }
            // From Habits & Tasks' + on Habits: back there once added, with the 6th-habit page first.
            // From its + on Tasks, or a task's Duplicate: back there once added.
            val fromTasks = a?.getString("from") == "tasks"
            val fromHabits = a?.getString("from") == "habits"
            // Search's Add “word” (A72): back to Habits & Tasks once it's made, with no Add a 6th habit first (it may be a task).
            val fromSearch = a?.getString("from") == "search"
            NewHabitFlow(store, idea, onClose = { nav.popBackStack() }, onSaved = { habit ->
                copyOf?.let { store.placeAfter(habit.id, it.id) }
                if (fromHabits || fromTasks || fromSearch) nav.popBackStack() else nav.popBackStack(Routes.TODAY, inclusive = false)
            }, onPlus = { nav.navigate(Routes.GET_PLUS) }, copyOf = copyOf, name = a?.getString("name"), roomFirst = fromHabits, task = fromTasks && copyOf == null)
        }
        composable(Routes.ARCHIVED) {
            ArchivedHabitsScreen(store, object : ArchivedNav {
                override fun open(habit: Habit) = nav.navigate(Routes.habit(habit.id))
                override fun restoreNoRoom(habit: Habit) = nav.navigate(Routes.restoreRoom(habit.id))
                override fun back() { nav.popBackStack() }
            })
        }
        composable(Routes.ARCHIVED_TASKS) {
            ArchivedHabitsScreen(store, object : ArchivedNav {
                override fun open(habit: Habit) = nav.navigate(Routes.habit(habit.id))
                override fun restoreNoRoom(habit: Habit) {}
                override fun back() { nav.popBackStack() }
            }, tasks = true)
        }
        composable(Routes.COMPLETED_TASKS) {
            com.oftenenough.app.ui.habit.CompletedTasksScreen(store, object : com.oftenenough.app.ui.habit.CompletedNav {
                override fun open(task: Habit) = nav.navigate(Routes.habit(task.id))
                override fun back() { nav.popBackStack() }
            })
        }
        composable("restoreroom/{id}") { e ->
            // Restore a 6th habit (Habits, Figma 6.4): Plus, or make room; then the habit comes back.
            val habit = store.habit(e.arguments!!.getString("id")!!)
            var making by rememberSaveable { mutableStateOf(false) }
            val done = { habit?.let { store.restore(it) }; nav.popBackStack(); Unit }
            if (habit == null) LaunchedEffect(Unit) { nav.popBackStack() }
            else if (making) com.oftenenough.app.ui.newhabit.MakeRoomPage(store, { making = false }, done)
            else com.oftenenough.app.ui.newhabit.SixthHabitPage(store, { nav.popBackStack() }, { making = true }, { nav.navigate(Routes.GET_PLUS) }, done,
                title = "Restore a 6th habit")
        }
        composable("edit/{id}") { e ->
            EditHabitScreen(e.arguments!!.getString("id")!!, store, { nav.navigate(Routes.GET_PLUS) }) { nav.popBackStack() }
        }
        composable("page/{title}") { entry ->
            when (val title = entry.arguments?.getString("title") ?: "") {
                SettingsPage.PROGRESS -> WithDay(store, nav) { openDay ->
                    ProgressScreen(store, prefs, object : ProgressNav {
                        override fun openHabit(habit: Habit) = nav.navigate(Routes.habit(habit.id))
                        override fun openDay(habit: Habit, day: Int) = openDay(habit, day)
                    }) { nav.popBackStack() }
                }
                MenuItem.HABITS.title -> WithMenu(store, MenuItem.HABITS, nav) { openMenu ->
                    WithDay(store, nav) { openDay ->
                        HabitsPage(store, object : HabitsNav {
                            override val openMenu = openMenu
                            override fun open(habit: Habit) = nav.navigate(Routes.habit(habit.id))
                            override fun openDay(habit: Habit, day: Int) = openDay(habit, day)
                            override fun edit(habit: Habit) = nav.navigate(Routes.edit(habit.id))
                            override fun newHabit(name: String?) = nav.navigate(Routes.NEW + "?from=habits" + (name?.let { "&name=" + android.net.Uri.encode(it) } ?: ""))
                            override fun archived() = nav.navigate(Routes.ARCHIVED)
                            override fun add(name: String) = nav.navigate(Routes.NEW + "?from=search&name=" + android.net.Uri.encode(name))
                            override val tasks = object : com.oftenenough.app.ui.habit.TasksNav {
                                override fun open(task: Habit) = nav.navigate(Routes.habit(task.id))
                                override fun edit(task: Habit) = nav.navigate(Routes.edit(task.id))
                                override fun duplicate(task: Habit) = nav.navigate(Routes.NEW + "?copy=${task.id}&from=tasks")
                                override fun newTask(name: String?) = nav.navigate(Routes.NEW + "?from=tasks" + (name?.let { "&name=" + android.net.Uri.encode(it) } ?: ""))
                                override fun completed() = nav.navigate(Routes.COMPLETED_TASKS)
                                override fun archived() = nav.navigate(Routes.ARCHIVED_TASKS)
                                override fun showToday() { nav.popBackStack(Routes.TODAY, inclusive = false) }
                            }
                        })
                    }
                }
                SettingsPage.REMINDERS -> com.oftenenough.app.ui.settings.KeepRemindersComingPage(store) { nav.popBackStack() }
                SettingsPage.PRIVACY -> PrivacyPage(prefs, AppGraph.lock, { nav.navigate(Routes.page("App lock")) }) { nav.popBackStack() }
                "App lock" -> AppLockPage(AppGraph.lock, { nav.navigate(Routes.LOCK_SETUP) }, { nav.navigate(Routes.LOCK_PASSCODE) }) { nav.popBackStack() }
                MenuItem.PLUS.title -> com.oftenenough.app.ui.plus.PlusPage(store, AppGraph.plus, AppGraph.backup,
                    snackbar, plusNav(nav), restoreFoundNothing = noPlusFound, onRestoreDialogSeen = { noPlusFound = false })
                MenuItem.SETTINGS.title -> SettingsHome({ page -> nav.navigate(Routes.page(page)) }) { nav.popBackStack() }
                "Arrange your day" -> {
                    // The habit Arrange… or Move asked for, lifted once (Figma 1.4, 1.6).
                    val lifted = remember { ArrangeLift.habit.also { ArrangeLift.habit = null } }
                    ArrangeDayScreen(store, { id -> nav.navigate("section/" + (id ?: "new")) }, lifted) { nav.popBackStack() }
                }
                SettingsPage.HELP -> HelpPage { nav.popBackStack() }
                SettingsPage.ABOUT -> AboutPage({ nav.navigate(Routes.page("Open source licences")) }) { nav.popBackStack() }
                "Open source licences" -> LicencesPage { nav.popBackStack() }
                SettingsPage.DAY_AND_WEEK -> DayAndWeekPage(store) { nav.popBackStack() }
                SettingsPage.APPEARANCE -> AppearancePage(prefs) { nav.popBackStack() }
                SettingsPage.BACKUP -> BackupScreen(AppGraph.backup, store, { nav.navigate(Routes.RESTORE) }, { nav.popBackStack() }, snackbar)
                "Start from an idea" -> IdeasScreen({ nav.popBackStack() }) { idea ->
                    nav.popBackStack(); nav.navigate(Routes.NEW + "?idea=" + android.net.Uri.encode(idea.name))
                }
                SettingsPage.TIMES_OF_DAY -> TimesOfDayPage(store, { id -> nav.navigate("section/" + (id ?: "new")) }) { nav.popBackStack() }
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
                    override fun openHabit(habit: Habit) = nav.navigate(Routes.habit(habit.id))
                    override fun duplicate(habit: Habit) = nav.navigate(Routes.NEW + "?copy=${habit.id}&from=tasks")
                    override fun deleted(habit: Habit) {
                        nav.popBackStack()
                        // Today has its own snackbar, not this one: from there it goes at once, as before.
                        if (nav.currentBackStackEntry?.destination?.route == Routes.TODAY) { store.delete(listOf(habit)); return }
                        com.oftenenough.app.ui.habit.PendingDelete.ids.add(habit.id)
                        rootScope.launch {
                            snackbar.currentSnackbarData?.dismiss()
                            var undone = false
                            try {
                                undone = snackbar.showSnackbar("${habit.name} deleted", "Undo", duration = androidx.compose.material3.SnackbarDuration.Short) ==
                                    androidx.compose.material3.SnackbarResult.ActionPerformed
                            } finally {
                                if (!undone) store.habit(habit.id)?.let { store.delete(listOf(it)) }
                                com.oftenenough.app.ui.habit.PendingDelete.ids.remove(habit.id)
                            }
                        }
                    }
                }) { nav.popBackStack() }
            }
        }
        composable("routine/{part}/{day}/{ids}?at={at}", arguments = listOf(androidx.navigation.navArgument("at") { nullable = true; defaultValue = null })) { e ->
            val a = e.arguments!!
            WithDay(store, nav) { openDay ->
                RoutinePlayer(store, a.getString("part")!!, a.getString("day")!!.toInt(), a.getString("ids")!!.split(",").filter { it.isNotEmpty() },
                    startAt = a.getString("at"), nav =
                    object : PlayerNav {
                        override fun openDay(habit: Habit, day: Int) = openDay(habit, day)
                        override fun addLog(habit: Habit, day: Int) = nav.navigate(Routes.add(habit.id, day))
                        override fun openTimer(habit: Habit) = nav.navigate(Routes.timer(habit.id))
                        // The snackbar's Add note opens Add note for that day, and Save comes back to the player (Figma 6.2).
                        override fun writeNote(habit: Habit, day: Int) = nav.navigate(Routes.note(habit.id, day))
                        override fun habitPage(habit: Habit, milestones: Boolean) {
                            if (milestones) com.oftenenough.app.ui.habit.HabitPageOpen.milestones = habit.id
                            nav.navigate(Routes.habit(habit.id))
                        }
                    }) { nav.popBackStack() }
            }
        }
        composable(Routes.RESTORE) {
            com.oftenenough.app.ui.restore.RestoreFlow(AppGraph.backup, store, AppGraph.plus, { AppGraph.hasPlus },
                onBack = { nav.popBackStack() }) { message ->
                nav.popBackStack(Routes.TODAY, inclusive = false)
                rootScope.launch { snackbar.showSnackbar(message, duration = androidx.compose.material3.SnackbarDuration.Long) }
            }
        }
        composable("pause/{ids}") { e -> PauseScreen(e.arguments!!.getString("ids")!!.split(","), store) { nav.popBackStack() } }
        composable(Routes.LOCK_SETUP) { AppLockSetup(AppGraph.lock, passcodeOnly = false) { nav.popBackStack() } }
        composable(Routes.LOCK_PASSCODE) { AppLockSetup(AppGraph.lock, passcodeOnly = true) { nav.popBackStack() } }
        composable(Routes.GROUPS) { GroupsScreen(store, { id -> nav.navigate(Routes.group(id)) }) { nav.popBackStack() } }
        composable("group/{id}") { e ->
            GroupFormScreen(store, e.arguments!!.getString("id")!!.takeIf { it != "new" }, { hs -> nav.navigate(Routes.pause(hs.map { it.id })) }) { nav.popBackStack() }
        }
        composable(Routes.NEW_TASK) {
            NewHabitFlow(store, null, onClose = { nav.popBackStack() }, onSaved = { nav.popBackStack() }, onPlus = { nav.navigate(Routes.GET_PLUS) }, task = true)
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
        // Plus's flows (Figma 1476:2): each finishes back on the Plus page.
        val flowNav = plusFlowNav(nav, rootScope, snackbar) { noPlusFound = true }
        composable(Routes.GET_PLUS) { com.oftenenough.app.ui.plus.GetPlusScreen(AppGraph.plus, flowNav) { nav.popBackStack() } }
        composable(Routes.RESTORE_PLUS) { com.oftenenough.app.ui.plus.RestoreFlow(AppGraph.plus, flowNav) }
    }
    }
    // Plus has no pinned button, so its messages sit 16 from the sides and the bottom (Figma 7.2.2: with the
    // snackbar's own 12 inside the host, 4 more); other pages keep room for their buttons.
    if (route != null && route != Routes.TODAY) AppSnackbarHost(snackbar, Modifier.align(Alignment.BottomCenter).navigationBarsPadding()
        .let { if (menuItem == MenuItem.PLUS) it.padding(start = 4.dp, end = 4.dp, bottom = 4.dp) else it.padding(bottom = 96.dp) })
    }
    LaunchedEffect(handOver) { handOver?.let { target -> handOver = null; nav.navigate(target) } }
}

/** The Tasks page, until Habits and Tasks become one screen (the user is designing it). */

/**
 * What a menu row does (Figma `12:5259`). Four open a page; **Contact us** and **Send feedback** open the person's own
 * email app, filled in with the app and the phone, never their habits. A choice replaces the page open now, so the
 * menu never piles pages up.
 */
private fun openMenuItem(item: MenuItem, nav: NavHostController, context: android.content.Context) {
    when (item) {
        MenuItem.CONTACT -> { runCatching { context.startActivity(Support.mail()) }; return }
        MenuItem.FEEDBACK -> { runCatching { context.startActivity(Support.feedback()) }; return }
        else -> Unit
    }
    nav.popBackStack(Routes.TODAY, inclusive = false)
    if (item != MenuItem.TODAY) nav.navigate(Routes.menu(item))
}

/** The Plus page's rows. */
private fun plusNav(nav: NavHostController) = object : com.oftenenough.app.ui.plus.PlusNav {
    override fun seePlus() = nav.navigate(Routes.GET_PLUS)
    override fun restore() = nav.navigate(Routes.RESTORE_PLUS)
    override fun backup() = nav.navigate(Routes.page(SettingsPage.BACKUP))
    override fun back() { nav.popBackStack() }
}

/** Where a Plus flow ends: back on the Plus page (opened if the flow began elsewhere, as the 6th-habit page). */
private fun plusFlowNav(nav: NavHostController, scope: CoroutineScope, snackbar: SnackbarHostState, onNoPlusFound: () -> Unit) =
    object : com.oftenenough.app.ui.plus.PlusFlowNav {
        override fun toPage(message: String?) {
            if (!nav.popBackStack(Routes.menu(MenuItem.PLUS), inclusive = false)) {
                nav.popBackStack(Routes.TODAY, inclusive = false)
                nav.navigate(Routes.menu(MenuItem.PLUS))
            }
            message?.let { scope.launch { snackbar.showSnackbar(it) } }
        }
        override fun toPageNoPlusFound() { onNoPlusFound(); toPage() }
        override fun getPlus() = nav.navigate(Routes.GET_PLUS)
        override fun restore() = nav.navigate(Routes.RESTORE_PLUS)
    }
/**
 * The routine "Start the next routine" opens: the time of day that is now if it has anything left, else the next card
 * down Today that does (then from the top). Null when everything planned today is done: Today opens and says so.
 */
/** A time of day's habits for the routine player, in the person's order: everything due that day but quit habits and limits. */
fun routineHabits(store: HabitStore, part: String, day: Int): List<String> =
    (store.rules.cardMembers()[part] ?: emptyList()).mapNotNull { store.habit(it) }.filter { h ->
        !h.archived && !h.isQuitOrLimit && store.rules.isDue(h, day) && !store.isPaused(h, day)
    }.map { it.id }

fun nextRoutine(store: HabitStore): Pair<String, List<String>>? {
    val today = store.today()
    val members = store.rules.cardMembers()
    val cards = store.todayCards().filter { it != com.oftenenough.app.data.DaySection.QUITTING }
    val start = store.nowSection()?.id?.let { cards.indexOf(it) }?.takeIf { it >= 0 } ?: 0
    for (i in cards.indices) {
        val card = cards[(start + i) % cards.size]
        val left = (members[card] ?: emptyList()).mapNotNull { store.habit(it) }.filter { h ->
            !h.archived && !h.isQuitOrLimit && store.rules.isDue(h, today) && !store.rules.isSatisfied(h, today) &&
                !store.isSkipped(h, today) && !store.isPaused(h, today)
        }
        if (left.isNotEmpty()) return card to left.map { it.id }
    }
    return null
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
    const val RESTORE = "restore"
    const val NEW_TASK = "newtask"
    const val GROUPS = "groups"
    const val ARCHIVED = "archived"
    const val ARCHIVED_TASKS = "archived/tasks"
    const val COMPLETED_TASKS = "tasks/completed"
    fun restoreRoom(id: String) = "restoreroom/$id"
    const val GET_PLUS = "plus/get"
    const val RESTORE_PLUS = "plus/restore"
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
    fun routine(part: String, day: Int, ids: List<String>, at: String? = null) =
        "routine/" + android.net.Uri.encode(part) + "/$day/" + ids.joinToString(",") + (at?.let { "?at=$it" } ?: "")
}

/**
 * A top-level page with its own ☰ (Habits, Figma 2106:2): Material's navigation drawer over it on a phone; with the
 * sidebar beside the page there's no drawer and no ☰ (null).
 */
@Composable
private fun WithMenu(store: HabitStore, current: MenuItem, nav: NavHostController, content: @Composable (openMenu: (() -> Unit)?) -> Unit) {
    if (LocalSidebar.current) { content(null); return }
    val drawer = rememberDrawerState(DrawerValue.Closed)
    val scope = rememberCoroutineScope()
    val pageContext = androidx.compose.ui.platform.LocalContext.current
    androidx.activity.compose.BackHandler(enabled = drawer.isOpen) { scope.launch { drawer.close() } }
    ModalNavigationDrawer(drawerContent = {
        MenuDrawer(store, current) { item ->
            scope.launch { drawer.close() }
            if (item != current) openMenuItem(item, nav, pageContext)
        }
    }, drawerState = drawer) { content { scope.launch { drawer.open() } } }
}

/** Day details' way out to the pages it opens; [close] closes the sheet first where a page replaces it. */
private fun dayNav(nav: NavHostController, close: () -> Unit) = object : DayNav {
    override fun habitPage(habit: Habit) { close(); nav.navigate(Routes.habit(habit.id)) }
    override fun allMilestones(habit: Habit) { com.oftenenough.app.ui.habit.HabitPageOpen.milestones = habit.id; habitPage(habit) }
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
    override fun restore() = nav.navigate(Routes.RESTORE)
    override fun help() = nav.navigate(Routes.page(SettingsPage.HELP))
    override fun arrange() = nav.navigate(Routes.page("Arrange your day"))
    override fun archivedHabits() = nav.navigate(Routes.ARCHIVED)
    override fun startRoutine(part: String, day: Int, habits: List<Habit>) = nav.navigate(Routes.routine(part, day, habits.map { it.id }))
    override fun backup() = nav.navigate(Routes.page(SettingsPage.BACKUP))
    override fun reminders() = nav.navigate(Routes.page(SettingsPage.REMINDERS))
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
    override fun arrange(habit: Habit?) { ArrangeLift.habit = habit?.id; nav.navigate(Routes.page("Arrange your day")) }
}

/** The habit Arrange Today opens with lifted (a row's Arrange…, the new habit's Move; Figma 1.4, 1.6). */
object ArrangeLift { var habit: String? = null }

/**
 * Today's pages: Undo · Note under the last log stay while one of these is open over Today (the note, Add log, the
 * timer, a log, Day details' pages) and go when the person leaves Today for anything else (Figma 1.2).
 */
private val pagesOverToday = setOf("note/{habit}/{day}", "add/{habit}/{day}", "timer/{id}", "log/{id}", "alllogs/{habit}/{day}")
