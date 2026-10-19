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
    /**
     * Where Move to a new phone's relay is (account-server/src/move.ts): the account Worker's dev in debug builds, its
     * production in release ones. A debug or test launch may point it elsewhere ([TestLaunch.MOVE_SERVER]: the relay
     * under `wrangler dev`, reached from the emulator at http://10.0.2.2:8787).
     */
    var moveServer: String = if (com.oftenenough.app.BuildConfig.DEBUG) app.habits.account.HttpAccountServer.DEV else app.habits.account.HttpAccountServer.PRODUCTION
    val moveHttp by lazy { com.oftenenough.app.data.move.moveHttp() }

    /** "habitId|day" a reminder asked to open (Day details), read once by Today. */
    var dayToOpen by androidx.compose.runtime.mutableStateOf<String?>(null)

    /** A milestone notification tapped: "habitId|length", read once by Today, which shows its pop-up (Figma N.6). */
    var milestoneToOpen by androidx.compose.runtime.mutableStateOf<String?>(null)

    /** A widget's link, read once by the app's navigation (W9: it replaces whatever was open). */
    var widgetRoute by androidx.compose.runtime.mutableStateOf<String?>(null)

    fun openTarget(intent: android.content.Intent?) {
        app.habits.account.InviteLink.token(intent?.dataString)?.let { inviteToOpen = it; intent?.data = null }
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
    private var lockInstance: AppLock? = null
    val lock: AppLock get() = lockInstance ?: error("AppGraph.open first")
    /** Names are hidden outside the app when the person asked, and always while App lock is on. */
    val hidesNames: Boolean get() = prefs.hideNames || lock.isOn
    private var screenOffWatched = false
    private var plusInstance: PlusStore? = null
    /** Where Plus comes from: the fake store in debug builds and tests until Play Billing is connected (build prompt §5). */
    val plus: PlusStore get() = plusInstance ?: error("AppGraph.open first")

    private var accountsInstance: app.habits.account.AccountCenter? = null
    /** The Plus account (Plus & Account): optional, holds only the purchase and the family (D16). */
    val accounts: app.habits.account.AccountCenter get() = accountsInstance ?: error("AppGraph.open first")
    private var signInInstance: com.oftenenough.app.app.account.SignInProvider? = null
    val signIn: com.oftenenough.app.app.account.SignInProvider get() = signInInstance ?: error("AppGraph.open first")

    private var codesInstance: PlusCodes? = null
    /** Plus from a code (reviewers, testing): Plus & Account › Redeem a code. */
    val plusCodes: PlusCodes get() = codesInstance ?: error("AppGraph.open first")

    /** Plus from any place: bought through Google Play on this account, held by the Plus account (an iPhone purchase, a
     *  family), or unlocked with a code. */
    val hasPlus: Boolean get() = plus.owned != PlusOwned.NONE || accounts.account?.givesPlus == true || plusCodes.redeemed

    /** The store's free-plan limit follows Plus, from Play or the account. */
    private fun followPlus(store: HabitStore) {
        store.isPlus = hasPlus
        scope.launch { androidx.compose.runtime.snapshotFlow { hasPlus }.collect { store.isPlus = it } }
    }

    /**
     * The account's server and sign-in (BuildConfig.ACCOUNT_SERVER, app/build.gradle.kts): the Worker's dev or production
     * ([app.habits.account.HttpAccountServer]), or the on-phone stand-in with the same rules. A test launch
     * uses the stand-in unless it asks for dev ([TestLaunch.ACCOUNT_SERVER], the end-to-end tests).
     */
    private fun openAccounts(context: Context, file: String, test: Boolean, testServer: String? = null) {
        val prefs = context.getSharedPreferences(file, Context.MODE_PRIVATE)
        val standInPrefs = context.getSharedPreferences("$file-standin", Context.MODE_PRIVATE)
        if (test) { prefs.edit().clear().commit(); standInPrefs.edit().clear().commit() }
        val today = { java.time.LocalDate.now().toEpochDay() }
        val standIn = { com.oftenenough.app.app.account.androidStandInServer(standInPrefs, today).also { if (!test) it.latencyMs = 900 } }
        val server = when {
            test && testServer == "dev" -> com.oftenenough.app.app.account.androidAccountServer(app.habits.account.HttpAccountServer.DEV)
            test -> standIn()
            BuildConfig.ACCOUNT_SERVER == "dev" -> com.oftenenough.app.app.account.androidAccountServer(app.habits.account.HttpAccountServer.DEV)
            BuildConfig.ACCOUNT_SERVER == "production" -> com.oftenenough.app.app.account.androidAccountServer(app.habits.account.HttpAccountServer.PRODUCTION)
            BuildConfig.ACCOUNT_SERVER == "standin" -> standIn()
            else -> app.habits.account.NoAccountServer
        }
        accountsInstance = com.oftenenough.app.app.account.androidAccountCenter(prefs, server, kotlinx.coroutines.Dispatchers.Main.immediate)
        signInInstance = when {
            test -> com.oftenenough.app.app.account.StandInSignIn()
            BuildConfig.GOOGLE_WEB_CLIENT_ID.isNotEmpty() -> com.oftenenough.app.app.account.GoogleSignInProvider(BuildConfig.GOOGLE_WEB_CLIENT_ID)
            BuildConfig.DEBUG -> com.oftenenough.app.app.account.StandInSignIn()
            else -> com.oftenenough.app.app.account.NoSignIn
        }
    }

    /** An invite link opened from outside the app (Figma 5): read once by the app's navigation. */
    var inviteToOpen by androidx.compose.runtime.mutableStateOf<String?>(null)

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
        openAccounts(context, app.habits.account.AccountCenter.FILE, test = false)
        tellAccountWhereTheHabitsAre()
        codesInstance = PlusCodes(context.getSharedPreferences("plus-codes", Context.MODE_PRIVATE))
        followPlus(store)
        // The account is asked again on each launch (a family change, a refund); kept as it was when offline.
        scope.launch { accounts.refresh(); accounts.syncPurchases(plus.purchases()) }
    }

    /**
     * A Plus account remembers where the habits live (D16, Current Work 138): each Google Drive round that synced tells
     * it (only when the place changed, or once a day), and deleting the Drive copy makes it forget. No account, nothing.
     */
    private fun tellAccountWhereTheHabitsAre() {
        backup.onCloud = { key ->
            accounts.noteCloud(key?.let { app.habits.account.CloudPlace(app.habits.account.CloudKind.GOOGLE_DRIVE, it, app.habits.account.CloudDevice.ANDROID) }, System.currentTimeMillis())
        }
    }

    /** Google Drive: the stand-in on this phone in debug builds until the user's OAuth client exists (build prompt §5). */
    private fun driveLink(context: Context, folder: String, prefs: android.content.SharedPreferences): com.oftenenough.app.app.backup.DriveLink =
        if (BuildConfig.DEBUG) com.oftenenough.app.app.backup.StandInLink(java.io.File(context.noBackupFilesDir, folder), prefs)
        else com.oftenenough.app.app.backup.NoDriveLink

    /** A test launch: an in-memory database, its own preferences, and (optionally) a clock that starts at [clockHour]:30. */
    fun openForTest(context: Context, clockHour: Int?, accountServer: String? = null, plus: Boolean = false) {
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
        // Its own App lock, off each launch (D8, T8): a test never locks or unlocks the person's app.
        lockInstance = AppLock(context.getSharedPreferences("uitest-applock", Context.MODE_PRIVATE).also { it.edit().clear().commit() })
        watchScreenOff(context)
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
        // Its own account and stand-in server, emptied each launch (D8).
        openAccounts(context, "uitest-account", test = true, testServer = accountServer)
        tellAccountWhereTheHabitsAre()
        codesInstance = PlusCodes(context.getSharedPreferences("uitest-plus-codes", Context.MODE_PRIVATE).also { it.edit().clear().commit() })
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
