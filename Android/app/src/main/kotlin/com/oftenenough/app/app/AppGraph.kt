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

    /** A milestone notification tapped: "habitId|length", read once by Today, which shows its pop-up (Figma N.6). */
    var milestoneToOpen by androidx.compose.runtime.mutableStateOf<String?>(null)

    /** A widget's link, read once by the app's navigation (W9: it replaces whatever was open). */
    var widgetRoute by androidx.compose.runtime.mutableStateOf<String?>(null)

    fun openTarget(intent: android.content.Intent?) {
        intent?.getStringExtra(MainActivity.WIDGET_ROUTE)?.let { route ->
            widgetRoute = route + "|" + intent.getIntExtra(MainActivity.OPEN_DAY, -1)
            intent.removeExtra(MainActivity.WIDGET_ROUTE)
        }
        intent?.getStringExtra(MainActivity.OPEN_MILESTONE)?.let { milestoneToOpen = it; intent.removeExtra(MainActivity.OPEN_MILESTONE) }
        val habit = intent?.getStringExtra(MainActivity.OPEN_HABIT) ?: return
        val day = intent.getIntExtra(MainActivity.OPEN_DAY, -1)
        if (day >= 0) dayToOpen = "$habit|$day"
        intent.removeExtra(MainActivity.OPEN_HABIT)
    }
    val prefs: Prefs get() = prefsInstance ?: error("AppGraph.open first")
    /** Sound when done's chime; made when the app's screen first shows, so it's loaded before the first goal is met. */
    val chime: Chime by lazy { Chime(AndroidCore.context) }
    /** Names are hidden outside the app when the person asked. */
    val hidesNames: Boolean get() = prefs.hideNames
    private var plusInstance: PlusStore? = null
    /** Where Plus comes from: the fake store in debug builds and tests until Play Billing is connected (build prompt §5). */
    val plus: PlusStore get() = plusInstance ?: error("AppGraph.open first")


    /**
     * **Plus comes from Google Play, and from nowhere else** (the user, 22 Oct 2026: "nothing unlocks a Plus on
     * device. A Plus should be always and only unlocked through Google Play Store"; Rulebook D16). Not a backup's
     * "made with Plus" flag, not a restored file, not a setting, not a code typed into the app, not an account on a
     * server of ours — there is no server. Someone whose Plus doesn't appear here is sent to the Play Store to sign
     * in with the Google account that bought it, or to us for a Play promo code (the restore flows, 3.7 and 5.6).
     */
    val hasPlus: Boolean get() = plus.owned != PlusOwned.NONE

    /** The store's free-plan limit follows Plus, from Google Play. */
    private fun followPlus(store: HabitStore) {
        store.isPlus = hasPlus
        scope.launch { androidx.compose.runtime.snapshotFlow { hasPlus }.collect { store.isPlus = it } }
    }

    /**
     * **There is no server** (the user, 22 Oct 2026: "we don't have any backend. Cloudflare has been deleted").
     * Nothing the app does reaches one: no Plus account, no family record, no move relay, no "where the habits live".
     * Plus comes from Google Play alone ([hasPlus]); the habits live on this phone and in the person's own Google
     * Drive (Rulebook D16). So there is nothing here to open.
     */

    val isOpen: Boolean get() = storeInstance != null

    /** Opens the person's own database (the app, widgets, notifications). */
    fun open(context: Context) {
        if (storeInstance != null) return
        init(context)
        val path = context.getDatabasePath("habits.db").also { it.parentFile?.mkdirs() }.path
        prefsInstance = Prefs.of(context)
        storeInstance = HabitStore(HabitRepository.open(path), scope).also { s ->
            s.milestones.memory = milestoneMemory()
            // Every saved change plans reminders again once the changes stop (S16).
            s.onChange = {
                com.oftenenough.app.app.reminders.Reminders.replanSoon(context.applicationContext, s)
                com.oftenenough.app.app.reminders.TimerNotice.sync(context.applicationContext, s)
                // LOCKED (widget taps): widgets publish 0.5 s after the last change (W11).
                com.oftenenough.app.app.widgets.WidgetPublisher.schedule(context.applicationContext, s)
                // Every change made here reaches Google Drive soon, the app open or not (D12); sync's own reload doesn't.
                if (!s.changeIsFromSync && com.oftenenough.app.app.backup.SyncSchedule.mayRun()) com.oftenenough.app.app.backup.SyncSchedule.soon(context.applicationContext)
            }
            scope.launch {
                s.load()
                com.oftenenough.app.app.reminders.Reminders.replan(context.applicationContext, s)
                com.oftenenough.app.app.backup.SyncSchedule.start(context.applicationContext)
                // Taps made on a widget while the app wasn't running are saved first (W5).
                com.oftenenough.app.app.widgets.WidgetTapSaver.saveWaiting(context.applicationContext)
            }
        }
        backupInstance = com.oftenenough.app.app.backup.BackupCenter(context, store, driveLink(context, "standin-drive", context.getSharedPreferences("drive", Context.MODE_PRIVATE)), test = false)
        // Google Play Billing in release builds (and debug builds made with -PrealBilling); the stand-in store otherwise.
        plusInstance = if (!BuildConfig.DEBUG || BuildConfig.REAL_BILLING) PlayPlusStore(context, scope, context.getSharedPreferences("plus-play", Context.MODE_PRIVATE))
            else FakePlusStore(context.getSharedPreferences("plus-fake", Context.MODE_PRIVATE)).also { it.latencyMs = 900 }
        followPlus(store)
    }

    /**
     * Google Drive: **the person's own, through Google's permission screen** (A4, A39). Debug builds can take the
     * stand-in Drive instead with `-PstandInDrive`, for working on an emulator with no Google Play; a test launch
     * always gets its own stand-in (D8). Without Google Play on the phone at all, Drive can't be connected and the
     * app says so rather than offering it.
     */
    private fun driveLink(context: Context, folder: String, prefs: android.content.SharedPreferences): com.oftenenough.app.app.backup.DriveLink =
        if (BuildConfig.DEBUG && BuildConfig.STAND_IN_DRIVE) com.oftenenough.app.app.backup.StandInLink(java.io.File(context.noBackupFilesDir, folder), prefs)
        else if (playServices(context)) com.oftenenough.app.app.backup.GoogleDriveLink(context, prefs)
        else com.oftenenough.app.app.backup.NoDriveLink

    /** Google Play services, which Google Drive's permission screen and its token come from. */
    private fun playServices(context: Context): Boolean =
        com.google.android.gms.common.GoogleApiAvailability.getInstance()
            .isGooglePlayServicesAvailable(context) == com.google.android.gms.common.ConnectionResult.SUCCESS

    /** A test launch: an in-memory database, its own preferences, and (optionally) a clock that starts at [clockHour]:30. */
    fun openForTest(context: Context, clockHour: Int?, plus: Boolean = false) {
        init(context)
        isTest = true
        val offset = clockHour?.let {
            val c = Calendar.getInstance().apply { set(Calendar.HOUR_OF_DAY, it); set(Calendar.MINUTE, 30); set(Calendar.SECOND, 0) }
            c.timeInMillis - System.currentTimeMillis()
        } ?: 0L
        // Every test launch starts from the defaults (T8): nothing a test changes reaches the next.
        context.getSharedPreferences("uitest", Context.MODE_PRIVATE).edit().clear().commit()
        context.getSharedPreferences("uitest-today-notices", Context.MODE_PRIVATE).edit().clear().commit()
        prefsInstance = Prefs.of(context, "uitest")
        storeInstance?.repo?.close()
        storeInstance = HabitStore(HabitRepository.openInMemory(), scope) { System.currentTimeMillis() + offset }.also { s ->
            s.milestones.memory = milestoneMemory()
            scope.launchLoad(s)
        }
        // Its own stand-in Drive, emptied each test launch (D8: never the person's).
        val driveFolder = java.io.File(context.noBackupFilesDir, "uitest-standin-drive").also { it.deleteRecursively() }
        val drivePrefs = context.getSharedPreferences("uitest-drive", Context.MODE_PRIVATE).also { it.edit().clear().commit() }
        backupInstance = com.oftenenough.app.app.backup.BackupCenter(context, store,
            com.oftenenough.app.app.backup.StandInLink(driveFolder, drivePrefs), test = true)
        // Its own purchases, none each launch unless the launch asks for Plus (TestLaunch.PLUS).
        plusInstance = FakePlusStore(context.getSharedPreferences("uitest-plus", Context.MODE_PRIVATE).also { it.edit().clear().commit() })
            .also { if (plus) it.ownForTest() }
        followPlus(store)
    }

    /** Today's shown milestones live in this launch's own preferences (the person's, or a test launch's, D8). */
    private fun milestoneMemory() = object : com.oftenenough.app.data.MilestoneCenter.Memory {
        override fun read(): String = prefs.milestones
        override fun write(text: String) { prefs.milestones = text }
    }

    private fun CoroutineScope.launchLoad(store: HabitStore) {
        launch { store.load() }
    }
}
