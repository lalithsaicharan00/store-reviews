package com.oftenenough.app.app

import com.oftenenough.app.BuildConfig

import android.content.Context
import androidx.compose.runtime.getValue
import androidx.compose.runtime.setValue
import android.text.format.DateFormat
import app.habits.core.AndroidCore
import app.habits.core.HabitRepository
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.HabitStore
import java.util.Calendar
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch

/**
 * The app's one store and its preferences. The person's database is opened once per process; a test launch
 * (`-uitest`, the [TestLaunch] extras) gets its own in-memory database and its own preferences, never the person's (D8).
 */
object AppGraph {
    val scope = CoroutineScope(SupervisorJob() + Dispatchers.Main.immediate)
    private var storeInstance: HabitStore? = null
    private var prefsInstance: Prefs? = null
    var isTest = false; private set

    fun init(context: Context) {
        AndroidCore.context = context.applicationContext
        DayWords.is24Hour = DateFormat.is24HourFormat(context)
    }

    private var backupInstance: com.oftenenough.app.app.backup.BackupCenter? = null
    val backup: com.oftenenough.app.app.backup.BackupCenter get() = backupInstance ?: error("AppGraph.open first")

    val store: HabitStore get() = storeInstance ?: error("AppGraph.open first")

    /** "habitId|day" a reminder asked to open (Day details), read once by Today. */
    var dayToOpen by androidx.compose.runtime.mutableStateOf<String?>(null)

    fun openTarget(intent: android.content.Intent?) {
        val habit = intent?.getStringExtra(MainActivity.OPEN_HABIT) ?: return
        val day = intent.getIntExtra(MainActivity.OPEN_DAY, -1)
        if (day >= 0) dayToOpen = "$habit|$day"
        intent.removeExtra(MainActivity.OPEN_HABIT)
    }
    val prefs: Prefs get() = prefsInstance ?: error("AppGraph.open first")
    private var lockInstance: AppLock? = null
    val lock: AppLock get() = lockInstance ?: error("AppGraph.open first")
    /** Names are hidden outside the app when the person asked, and always while App lock is on. */
    val hidesNames: Boolean get() = prefs.hideNames || lock.isOn
    private var screenOffWatched = false
    private var plusInstance: PlusStore? = null
    /** Where Plus comes from: the fake store in debug builds and tests until Play Billing is connected (build prompt §5). */
    val plus: PlusStore get() = plusInstance ?: error("AppGraph.open first")

    /** The store's free-plan limit follows what the account owns. */
    private fun followPlus(store: HabitStore, plus: PlusStore) {
        store.isPlus = plus.owned != PlusOwned.NONE
        scope.launch { androidx.compose.runtime.snapshotFlow { plus.owned }.collect { store.isPlus = it != PlusOwned.NONE } }
    }

    /** Locking the phone locks the app at once (whatever Lock again says). */
    private fun watchScreenOff(context: Context) {
        if (screenOffWatched) return
        screenOffWatched = true
        context.applicationContext.registerReceiver(object : android.content.BroadcastReceiver() {
            override fun onReceive(c: Context, i: android.content.Intent) { lockInstance?.phoneLocked() }
        }, android.content.IntentFilter(android.content.Intent.ACTION_SCREEN_OFF))
    }
    val isOpen: Boolean get() = storeInstance != null

    /** Opens the person's own database (the app, widgets, notifications). */
    fun open(context: Context) {
        if (storeInstance != null) return
        init(context)
        val path = context.getDatabasePath("habits.db").also { it.parentFile?.mkdirs() }.path
        prefsInstance = Prefs.of(context)
        lockInstance = AppLock(context.getSharedPreferences(AppLock.FILE, Context.MODE_PRIVATE))
        watchScreenOff(context)
        storeInstance = HabitStore(HabitRepository.open(path), scope).also { s ->
            // Every saved change plans reminders again once the changes stop (S16).
            s.onChange = {
                com.oftenenough.app.app.reminders.Reminders.replanSoon(context.applicationContext, s)
                com.oftenenough.app.app.reminders.TimerNotice.sync(context.applicationContext, s)
                // Every change made here reaches Google Drive soon, the app open or not (D12); sync's own reload doesn't.
                if (!s.changeIsFromSync && com.oftenenough.app.app.backup.SyncSchedule.mayRun()) com.oftenenough.app.app.backup.SyncSchedule.soon(context.applicationContext)
            }
            scope.launch {
                s.load()
                com.oftenenough.app.app.reminders.Reminders.replan(context.applicationContext, s)
                com.oftenenough.app.app.backup.SyncSchedule.start(context.applicationContext)
            }
        }
        backupInstance = com.oftenenough.app.app.backup.BackupCenter(context, store, driveLink(context, "standin-drive", context.getSharedPreferences("drive", Context.MODE_PRIVATE)), test = false)
        plusInstance = if (BuildConfig.DEBUG) FakePlusStore(context.getSharedPreferences("plus-fake", Context.MODE_PRIVATE)) else NoPlusStore
        followPlus(store, plus)
    }

    /** Google Drive: the stand-in on this phone in debug builds until the user's OAuth client exists (build prompt §5). */
    private fun driveLink(context: Context, folder: String, prefs: android.content.SharedPreferences): com.oftenenough.app.app.backup.DriveLink =
        if (BuildConfig.DEBUG) com.oftenenough.app.app.backup.StandInLink(java.io.File(context.noBackupFilesDir, folder), prefs)
        else com.oftenenough.app.app.backup.NoDriveLink

    /** A test launch: an in-memory database, its own preferences, and (optionally) a clock that starts at [clockHour]:30. */
    fun openForTest(context: Context, clockHour: Int?) {
        init(context)
        isTest = true
        val offset = clockHour?.let {
            val c = Calendar.getInstance().apply { set(Calendar.HOUR_OF_DAY, it); set(Calendar.MINUTE, 30); set(Calendar.SECOND, 0) }
            c.timeInMillis - System.currentTimeMillis()
        } ?: 0L
        // Every test launch starts from the defaults (T8): nothing a test changes reaches the next.
        context.getSharedPreferences("uitest", Context.MODE_PRIVATE).edit().clear().commit()
        prefsInstance = Prefs.of(context, "uitest")
        // Its own App lock, off each launch (D8, T8): a test never locks or unlocks the person's app.
        lockInstance = AppLock(context.getSharedPreferences("uitest-applock", Context.MODE_PRIVATE).also { it.edit().clear().commit() })
        watchScreenOff(context)
        storeInstance?.repo?.close()
        storeInstance = HabitStore(HabitRepository.openInMemory(), scope) { System.currentTimeMillis() + offset }.also { s -> scope.launchLoad(s) }
        // Its own stand-in Drive, emptied each test launch (D8: never the person's).
        val driveFolder = java.io.File(context.noBackupFilesDir, "uitest-standin-drive").also { it.deleteRecursively() }
        val drivePrefs = context.getSharedPreferences("uitest-drive", Context.MODE_PRIVATE).also { it.edit().clear().commit() }
        backupInstance = com.oftenenough.app.app.backup.BackupCenter(context, store,
            com.oftenenough.app.app.backup.StandInLink(driveFolder, drivePrefs), test = true)
        // Its own purchases, none each launch unless the launch asks for Plus (TestLaunch.PLUS).
        plusInstance = FakePlusStore(context.getSharedPreferences("uitest-plus", Context.MODE_PRIVATE).also { it.edit().clear().commit() })
        followPlus(store, plus)
    }

    private fun CoroutineScope.launchLoad(store: HabitStore) {
        launch { store.load() }
    }
}
