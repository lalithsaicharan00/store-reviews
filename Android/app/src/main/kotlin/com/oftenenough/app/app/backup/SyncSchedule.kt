package com.oftenenough.app.app.backup

import android.content.Context
import androidx.work.BackoffPolicy
import androidx.work.Constraints
import androidx.work.CoroutineWorker
import androidx.work.ExistingPeriodicWorkPolicy
import androidx.work.ExistingWorkPolicy
import androidx.work.NetworkType
import androidx.work.OneTimeWorkRequestBuilder
import androidx.work.PeriodicWorkRequestBuilder
import androidx.work.WorkManager
import androidx.work.WorkerParameters
import com.oftenenough.app.app.AppGraph
import java.util.concurrent.TimeUnit
import kotlinx.coroutines.delay
import kotlinx.coroutines.withContext
import kotlinx.coroutines.Dispatchers

/**
 * When the phone talks to Google Drive (D4, D12, D16; Android/Docs A4–A7): on open, about once a minute while the app
 * is on screen (the app runs that loop), a few seconds after any change wherever it was made (a reminder's Done, a
 * widget, the app itself just before it leaves the screen), and in the background a few times a day. Each run is one
 * DriveSync round: download, merge, upload, never replace. Only with Drive connected, only after the welcome is finished
 * (D14: a fresh install sends nothing first), and never for a test launch (D8).
 */
object SyncSchedule {
    private const val SOON = "drive-sync-soon"
    private const val PERIODIC = "drive-sync-periodic"
    /** Changes are sent together once they stop for this long (S16). */
    private const val QUIET_SECONDS = 3L

    private val network = Constraints.Builder().setRequiredNetworkType(NetworkType.CONNECTED).build()

    /** The background rounds, a few times a day; kept if already planned. */
    fun start(context: Context) {
        if (AppGraph.isTest) return
        val request = PeriodicWorkRequestBuilder<SyncWorker>(6, TimeUnit.HOURS).setConstraints(network)
            .setBackoffCriteria(BackoffPolicy.EXPONENTIAL, 1, TimeUnit.MINUTES).build()
        WorkManager.getInstance(context).enqueueUniquePeriodicWork(PERIODIC, ExistingPeriodicWorkPolicy.KEEP, request)
    }

    /**
     * A change was saved: send it once changes stop. A later change replaces the waiting run, so a run of taps is one
     * round. It runs even if the app has left the screen (WorkManager keeps it), and waits for a network.
     */
    fun soon(context: Context) {
        if (AppGraph.isTest) return
        val request = OneTimeWorkRequestBuilder<SyncWorker>().setConstraints(network).setInitialDelay(QUIET_SECONDS, TimeUnit.SECONDS)
            .setBackoffCriteria(BackoffPolicy.EXPONENTIAL, 30, TimeUnit.SECONDS).build()
        WorkManager.getInstance(context).enqueueUniqueWork(SOON, ExistingWorkPolicy.REPLACE, request)
    }

    /** Whether a round may run now: Drive connected, the welcome finished. */
    fun mayRun(): Boolean = AppGraph.isOpen && !AppGraph.isTest && AppGraph.prefs.onboarded &&
        runCatching { AppGraph.backup.link.api() != null }.getOrDefault(false)
}

/** One round in the background. A failed round keeps everything on the phone and is tried again later. */
class SyncWorker(context: Context, params: WorkerParameters) : CoroutineWorker(context, params) {
    override suspend fun doWork(): Result = withContext(Dispatchers.Main.immediate) {
        AppGraph.open(applicationContext)
        var waited = 0
        while (!AppGraph.store.isLoaded && waited < 10_000) { delay(20); waited += 20 }
        if (!AppGraph.store.isLoaded) return@withContext Result.retry()
        if (!SyncSchedule.mayRun()) return@withContext Result.success()
        try {
            AppGraph.backup.syncNow()
            Result.success()
        } catch (e: Exception) {
            if (runAttemptCount < 5) Result.retry() else Result.failure()
        }
    }
}
