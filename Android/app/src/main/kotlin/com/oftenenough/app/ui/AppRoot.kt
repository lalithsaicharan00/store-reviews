package com.oftenenough.app.ui

import com.oftenenough.app.ui.components.AppSnackbarHost
import android.view.View
import kotlinx.coroutines.CoroutineScope
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.MutableState
import com.oftenenough.app.ui.newhabit.EditHabitScreen
import com.oftenenough.app.ui.menu.MenuDrawer
import com.oftenenough.app.ui.menu.MenuSidebar
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.widthIn
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.ui.backup.BackupScreen
import com.oftenenough.app.ui.settings.ThemePage
import com.oftenenough.app.ui.settings.LicencesPage
import com.oftenenough.app.ui.settings.SectionEditorScreen
import com.oftenenough.app.ui.plus.PlusReason
import com.oftenenough.app.ui.plus.PlusScreen
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
import com.oftenenough.app.ui.habit.PauseSheet
import com.oftenenough.app.ui.habit.pausedWords
import com.oftenenough.app.ui.habit.ArchivedNav
import com.oftenenough.app.ui.habit.ArchivedHabitsScreen
import com.oftenenough.app.ui.habit.HabitsNav
import com.oftenenough.app.ui.habit.HabitsPage
import com.oftenenough.app.ui.player.PlayerNav
import com.oftenenough.app.ui.player.RoutinePlayer
import com.oftenenough.app.ui.player.TimerScreen

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
import com.oftenenough.app.ui.theme.appColors
import com.oftenenough.app.ui.today.TodayActions
import com.oftenenough.app.ui.today.TodayNav
import com.oftenenough.app.ui.today.TodayScreen
import com.oftenenough.app.ui.today.ArrangeDayScreen

/** The app: the welcome until it's finished, then Today and every page pushed over it (back returns one step, D7). */
@Composable
fun AppRoot(store: HabitStore, prefs: Prefs) {
    val nav = rememberNavController()
    val snackbar = remember { SnackbarHostState() }
    val rootScope = rememberCoroutineScope()
    val view = LocalView.current
    val chime = remember { AppGraph.chime }
    LaunchedEffect(store) {
        store.onLog = { done ->
            if (prefs.vibration) view.performHapticFeedback(if (done) HapticFeedbackConstants.CONFIRM else HapticFeedbackConstants.CLOCK_TICK)
            if (done && prefs.sound) chime.play()
        }
    }
    LaunchedEffect(store.problem) { store.problem?.let { snackbar.showSnackbar(it); store.problem = null } }
    // A tap that couldn't be saved: Today is as it was, and Try again taps it again (Figma's Today, flow 47).
    LaunchedEffect(store.failedTap) {
        val tap = store.failedTap ?: return@LaunchedEffect
        val said = "Couldn't save ${tap.name ?: "that"}. Nothing changed."
        val again = snackbar.showSnackbar(said, "Try again", duration = androidx.compose.material3.SnackbarDuration.Short) ==
            androidx.compose.material3.SnackbarResult.ActionPerformed
        // Cleared once shown: clearing it first would restart this effect and take the snackbar away.
        if (store.failedTap === tap) store.failedTap = null
        if (again) tap.retry()
    }
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
    // Pause's one sheet, over whichever page asked (Today's menu, Day details, a habit's page): Figma's Pause sheet.
    var pausing by rememberSaveable { mutableStateOf<List<String>>(emptyList()) }
    val askPause: (Habit) -> Unit = { pausing = listOf(it.id) }
    // A message with Undo on whichever page is showing (Today places its own above the day bar).
    val sayUndo: (String, () -> Unit) -> Unit = { text, undo ->
        rootScope.launch {
            snackbar.currentSnackbarData?.dismiss()
            if (snackbar.showSnackbar(text, "Undo", duration = androidx.compose.material3.SnackbarDuration.Short) ==
                androidx.compose.material3.SnackbarResult.ActionPerformed) undo()
        }
    }
    // Plus turned on from a Plus screen (Figma's flows: "the snackbar says Plus is on").
    val plusOn: () -> Unit = { rootScope.launch { snackbar.currentSnackbarData?.dismiss(); snackbar.showSnackbar("Plus is on") } }
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
            "plus" -> nav.navigate(Routes.plus(PlusReason.MENU))
            // The app icon's long-press shortcuts (A11 D8).
            "new" -> nav.navigate(Routes.NEW)
            "routine" -> nextRoutine(store)?.let { (part, habits) -> nav.navigate(Routes.routine(part, store.today(), habits)) }
        }
    }
    // A reminder's tap opens that habit's Day details over Today.
    LaunchedEffect(AppGraph.dayToOpen) {
        AppGraph.dayToOpen?.let { target -> AppGraph.dayToOpen = null; nav.popBackStack(Routes.TODAY, inclusive = false); dayTarget = target }
    }
    val dayNav = dayNav(nav, askPause, sayUndo) { dayTarget = null }
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
    androidx.compose.runtime.CompositionLocalProvider(LocalPause provides askPause, LocalSayUndo provides sayUndo, com.oftenenough.app.ui.components.LocalAppSnackbar provides snackbar) {
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
                TodayScreen(store, prefs, todayNav(nav) {}, todayActions(nav, view, askPause) { h, d -> dayTarget = h.id + "|" + d }, snackbar, todayLayout)
            } else ModalNavigationDrawer(drawerContent = {
                MenuDrawer(store, MenuItem.TODAY) { item ->
                    scope.launch { drawer.close() }
                    openMenuItem(item, nav, appContext)
                }
            }, drawerState = drawer) {
                TodayScreen(store, prefs, todayNav(nav) { scope.launch { drawer.open() } }, todayActions(nav, view, askPause) { h, d -> dayTarget = h.id + "|" + d }, snackbar, todayLayout)
            }
            dayTarget?.split("|")?.let { (id, d) ->
                DayDetailsSheet(id, d.toInt(), store, dayNav) { dayTarget = null }
            }
        }
        composable("add/{habit}/{day}") { e ->
            AddLogScreen(e.arguments!!.getString("habit")!!, e.arguments!!.getString("day")!!.toInt(), store,
                say = { text -> rootScope.launch { snackbar.currentSnackbarData?.dismiss(); snackbar.showSnackbar(text) } }) { nav.popBackStack() }
        }
        composable("log/{id}") { e -> LogScreen(e.arguments!!.getString("id")!!, store) { nav.popBackStack() } }
        composable("alllogs/{habit}/{day}") { e ->
            AllLogsScreen(e.arguments!!.getString("habit")!!, e.arguments!!.getString("day")!!.toInt(), store, { nav.navigate(Routes.log(it.id)) }) { nav.popBackStack() }
        }
        composable("note/{habit}/{day}") { e ->
            NoteScreen(e.arguments!!.getString("habit")!!, e.arguments!!.getString("day")!!.toInt(), store, say = { text, undo ->
                if (undo != null) sayUndo(text, undo) else rootScope.launch { snackbar.currentSnackbarData?.dismiss(); snackbar.showSnackbar(text) }
            }) { nav.popBackStack() }
        }
        composable(Routes.NEW + "?name={name}&copy={copy}&from={from}") { entry ->
            val a = entry.arguments
            val copyOf = a?.getString("copy")?.let { store.habit(it) }
            // From Habits & Tasks' + on Habits: back there once added, with the 6th-habit page first.
            // From its + on Tasks, or a task's Duplicate: back there once added.
            val fromTasks = a?.getString("from") == "tasks"
            val fromHabits = a?.getString("from") == "habits"
            // Search's Add “word” (A72): back to Habits & Tasks once it's made, with no Add a 6th habit first (it may be a task).
            val fromSearch = a?.getString("from") == "search"
            NewHabitFlow(store, onClose = { nav.popBackStack() }, onSaved = { habit ->
                copyOf?.let { store.placeAfter(habit.id, it.id) }
                if (fromHabits || fromTasks || fromSearch) nav.popBackStack() else nav.popBackStack(Routes.TODAY, inclusive = false)
            }, onPlus = { reason -> nav.navigate(Routes.plus(reason)) }, copyOf = copyOf, name = a?.getString("name"), roomFirst = fromHabits,
                task = fromTasks && copyOf == null, onPlusOn = plusOn)
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
            // Restore a 6th habit (Habits, Figma 6.4): Plus (Reason=6th habit), whose ← opens Make room; then the habit comes back.
            val habit = store.habit(e.arguments!!.getString("id")!!)
            var making by rememberSaveable { mutableStateOf(false) }
            val done = { habit?.let { store.restore(it) }; nav.popBackStack(); Unit }
            if (habit == null) LaunchedEffect(Unit) { nav.popBackStack() }
            else if (making) com.oftenenough.app.ui.newhabit.MakeRoomPage(store, { nav.popBackStack() }, done)
            else PlusScreen(PlusReason.SIXTH, store, AppGraph.plus, onBack = { making = true }, onBought = { plusOn(); done() },
                title = "Restore a 6th habit")
        }
        composable("edit/{id}") { e ->
            EditHabitScreen(e.arguments!!.getString("id")!!, store, { reason -> nav.navigate(Routes.plus(reason)) }) { nav.popBackStack() }
        }
        composable("page/{title}") { entry ->
            when (val title = entry.arguments?.getString("title") ?: "") {
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
                // The menu's Plus (Reason=Menu): bought here, it stays, saying Plus is yours.
                MenuItem.PLUS.title -> PlusScreen(PlusReason.MENU, store, AppGraph.plus, { nav.popBackStack() }, plusOn)
                MenuItem.SETTINGS.title -> WithMenu(store, MenuItem.SETTINGS, nav) { openMenu ->
                    SettingsHome(store, prefs, AppGraph.backup, openMenu) { page -> nav.navigate(Routes.page(page)) }
                }
                "Arrange your day" -> {
                    // After a time of day is deleted: Anytime, where its habits went (Figma 842:65986).
                    val reveal by entry.savedStateHandle.getStateFlow<String?>("reveal", null).collectAsState()
                    ArrangeDayScreen(store, { id -> nav.navigate("section/" + (id ?: "new")) }, reveal = reveal,
                        onRevealed = { entry.savedStateHandle["reveal"] = null }) { nav.popBackStack() }
                }
                SettingsPage.LICENCES -> LicencesPage { nav.popBackStack() }
                SettingsPage.NEW_DAY -> com.oftenenough.app.ui.settings.NewDayStartsAtPage(store) { nav.popBackStack() }
                SettingsPage.WEEK_START -> com.oftenenough.app.ui.settings.WeekStartsOnPage(store) { nav.popBackStack() }
                SettingsPage.THEME -> ThemePage(prefs) { nav.popBackStack() }
                // After Erase all my data the app starts again on Today, as a fresh install (Figma's Erase flow).
                SettingsPage.BACKUP -> BackupScreen(AppGraph.backup, store, { nav.navigate(Routes.RESTORE_FROM_SETTINGS) }, { nav.popBackStack(Routes.TODAY, inclusive = false) },
                    { nav.popBackStack() }, snackbar)
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
                    override fun pause(habit: Habit) = askPause(habit)
                    override fun openHabit(habit: Habit) = nav.navigate(Routes.habit(habit.id))
                    override fun duplicate(habit: Habit) = nav.navigate(Routes.NEW + "?copy=${habit.id}&from=tasks")
                    override fun plus() = nav.navigate(Routes.plus(PlusReason.YEAR))
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
        composable(Routes.RESTORE + "?from={from}", arguments = listOf(androidx.navigation.navArgument("from") { nullable = true; defaultValue = null })) { e ->
            // From the empty Today the restore ends on Today and nothing more (Figma's onboarding, 2.7 and every flow's
            // last screen); from Settings it says what came back (Settings' Restore flows end "Today, habits restored").
            val fromSettings = e.arguments?.getString("from") == "settings"
            com.oftenenough.app.ui.restore.RestoreFlow(AppGraph.backup, store, AppGraph.plus, { AppGraph.hasPlus },
                onBack = { nav.popBackStack() }) { message, done ->
                nav.popBackStack(Routes.TODAY, inclusive = false)
                if (fromSettings || !done) rootScope.launch { snackbar.showSnackbar(message, duration = androidx.compose.material3.SnackbarDuration.Long) }
            }
        }
        composable(Routes.NEW_TASK) {
            NewHabitFlow(store, onClose = { nav.popBackStack() }, onSaved = { nav.popBackStack() }, onPlus = { reason -> nav.navigate(Routes.plus(reason)) },
                task = true, onPlusOn = plusOn)
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
            val existing = e.arguments!!.getString("id")!!.takeIf { it != "new" }
            // Back on Times of day (5.8.4, Figma's flows): "Changes saved" after an edit (a new one just appears in its
            // place, in time order); "Morning deleted" with Undo, which brings it back with its habits.
            SectionEditorScreen(store, existing, onDeleted = { name, undo ->
                nav.previousBackStackEntry?.savedStateHandle?.set("reveal", com.oftenenough.app.data.DaySection.ANYTIME)
                nav.popBackStack()
                rootScope.launch {
                    snackbar.currentSnackbarData?.dismiss()
                    if (snackbar.showSnackbar("$name deleted", "Undo", duration = androidx.compose.material3.SnackbarDuration.Short) ==
                        androidx.compose.material3.SnackbarResult.ActionPerformed) store.undoSectionDelete(undo)
                }
            }) { saved ->
                nav.popBackStack()
                if (saved != null && existing != null) rootScope.launch { snackbar.currentSnackbarData?.dismiss(); snackbar.showSnackbar("Changes saved") }
            }
        }
        // Plus (5.9.1), for a reason: once it's on, back where the person was, which goes on as Figma's flows say (the
        // checklist form opens; Reminders loses its badge; Year in pixels unlocks), and "Plus is on".
        composable(Routes.PLUS) { e ->
            PlusScreen(PlusReason.of(e.arguments?.getString("reason")), store, AppGraph.plus, { nav.popBackStack() },
                onBought = { nav.popBackStack(); plusOn() })
        }
    }
    }
    // Plus has no pinned button, so its messages sit 16 from the sides and the bottom (Figma 7.2.2: with the
    // snackbar's own 12 inside the host, 4 more); other pages keep room for their buttons.
    if (route != null && route != Routes.TODAY) AppSnackbarHost(snackbar, Modifier.align(Alignment.BottomCenter).navigationBarsPadding()
        .let { if (menuItem == MenuItem.PLUS) it.padding(start = 4.dp, end = 4.dp, bottom = 4.dp) else it.padding(bottom = 96.dp) })
    }
    }
    val toPause = pausing.mapNotNull { store.habit(it) }.filter { store.rules.canPause(it) }
    if (toPause.isNotEmpty()) {
        val before = toPause.associate { it.id to (store.pauses[it.id] ?: emptyList()) }
        PauseSheet(toPause, store, { pausing = emptyList() }) { back ->
            pausing = emptyList()
            sayUndo(pausedWords(toPause, back)) { toPause.forEach { store.setPauses(it, before[it.id] ?: emptyList()) } }
        }
    } else if (pausing.isNotEmpty()) pausing = emptyList()
    LaunchedEffect(handOver) { handOver?.let { target -> handOver = null; nav.navigate(target) } }
}

/** Asks for Pause's sheet for a habit, from any page under [AppMain]. */
private val LocalPause = androidx.compose.runtime.staticCompositionLocalOf<(Habit) -> Unit> { {} }

/** Says something with Undo on the page showing, from any page under [AppMain]. */
private val LocalSayUndo = androidx.compose.runtime.staticCompositionLocalOf<(String, () -> Unit) -> Unit> { { _, _ -> } }

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

/** A time of day's habits for the routine player, in the person's order: everything due that day but quit habits and limits. */
fun routineHabits(store: HabitStore, part: String, day: Int): List<String> =
    (store.rules.cardMembers()[part] ?: emptyList()).mapNotNull { store.habit(it) }.filter { h ->
        !h.archived && !h.isQuitOrLimit && store.rules.isDue(h, day) && !store.isPaused(h, day)
    }.map { it.id }

/**
 * The routine "Start the next routine" opens: the time of day that is now if it has anything left, else the next card
 * down Today that does (then from the top). Null when everything planned today is done: Today opens and says so.
 */
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
    const val RESTORE_FROM_SETTINGS = "restore?from=settings"
    const val NEW_TASK = "newtask"
    const val ARCHIVED = "archived"
    const val ARCHIVED_TASKS = "archived/tasks"
    const val COMPLETED_TASKS = "tasks/completed"
    fun restoreRoom(id: String) = "restoreroom/$id"
    const val PLUS = "plus/{reason}"
    fun plus(reason: PlusReason) = "plus/" + reason.key
    fun page(title: String) = "page/" + android.net.Uri.encode(title)
    fun add(habit: String, day: Int) = "add/$habit/$day"
    fun log(id: String) = "log/$id"
    fun edit(id: String) = "edit/$id"
    fun menu(item: MenuItem) = page(item.title)
    fun allLogs(habit: String, day: Int) = "alllogs/$habit/$day"
    fun note(habit: String, day: Int) = "note/$habit/$day"
    fun habit(id: String) = "habit/$id"
    fun timer(id: String) = "timer/$id"
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
private fun dayNav(nav: NavHostController, pause: (Habit) -> Unit, say: (String, () -> Unit) -> Unit, close: () -> Unit) = object : DayNav {
    override fun habitPage(habit: Habit) { close(); nav.navigate(Routes.habit(habit.id)) }
    override fun allMilestones(habit: Habit) { com.oftenenough.app.ui.habit.HabitPageOpen.milestones = habit.id; habitPage(habit) }
    override fun addLog(habit: Habit, day: Int) = nav.navigate(Routes.add(habit.id, day))
    override fun note(habit: Habit, day: Int) = nav.navigate(Routes.note(habit.id, day))
    override fun log(habit: Habit, entry: Entry) = nav.navigate(Routes.log(entry.id))
    override fun allLogs(habit: Habit, day: Int) = nav.navigate(Routes.allLogs(habit.id, day))
    override fun edit(habit: Habit) = nav.navigate(Routes.edit(habit.id))
    override fun pause(habit: Habit) = pause(habit)
    override fun resumed(habit: Habit, undo: () -> Unit) = say("${habit.name} resumed", undo)
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
        DayDetailsSheet(id, d.toInt(), store, dayNav(nav, LocalPause.current, LocalSayUndo.current) { target = null }) { target = null }
    }
}

private fun todayNav(nav: NavHostController, openDrawer: () -> Unit) = object : TodayNav {
    override fun openMenu() = openDrawer()
    override fun newHabit() = nav.navigate(Routes.NEW)
    override fun restore() = nav.navigate(Routes.RESTORE)
    override fun arrange() = nav.navigate(Routes.page("Arrange your day"))
    override fun archivedHabits() = nav.navigate(Routes.ARCHIVED)
    override fun startRoutine(part: String, day: Int, habits: List<Habit>) = nav.navigate(Routes.routine(part, day, habits.map { it.id }))
    override fun backup() = nav.navigate(Routes.page(SettingsPage.BACKUP))
    override fun reminders() = nav.navigate(Routes.page(SettingsPage.REMINDERS))
}

private fun todayActions(nav: NavHostController, view: android.view.View, pause: (Habit) -> Unit, openDay: (Habit, Int) -> Unit) = object : TodayActions {
    override fun openDay(habit: Habit, day: Int) = openDay(habit, day)
    override fun addLog(habit: Habit, day: Int) = nav.navigate(Routes.add(habit.id, day))
    override fun writeNote(habit: Habit, day: Int) = nav.navigate(Routes.note(habit.id, day))
    override fun openTimer(habit: Habit) = nav.navigate(Routes.timer(habit.id))
    override fun editHabit(habit: Habit) = nav.navigate(Routes.edit(habit.id))
    override fun openHabitPage(habit: Habit) = nav.navigate(Routes.habit(habit.id))
    override fun pause(habit: Habit) = pause(habit)
    override fun feedback(done: Boolean) { view.performHapticFeedback(HapticFeedbackConstants.CONFIRM) }
}

/**
 * Today's pages: Undo · Note under the last log stay while one of these is open over Today (the note, Add log, the
 * timer, a log, Day details' pages) and go when the person leaves Today for anything else (Figma 1.2).
 */
private val pagesOverToday = setOf("note/{habit}/{day}", "add/{habit}/{day}", "timer/{id}", "log/{id}", "alllogs/{habit}/{day}")
