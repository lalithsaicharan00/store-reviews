package com.oftenenough.app.app.backup

import android.content.Context
import android.net.Uri
import android.os.Build
import android.os.Handler
import android.os.Looper
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import app.habits.core.BackupCheck
import app.habits.core.BackupInfo
import app.habits.core.DriveApi
import app.habits.core.DriveState
import app.habits.core.DriveStatus
import app.habits.core.DriveSync
import app.habits.core.RestoreChanges
import app.habits.core.RestoreMode
import com.oftenenough.app.BuildConfig
import com.oftenenough.app.data.DataExport
import com.oftenenough.app.data.HabitStore
import java.io.File
import java.security.MessageDigest
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter
import java.util.Base64
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.sync.Mutex
import kotlinx.coroutines.sync.withLock
import kotlinx.coroutines.withContext

/** Where Google Drive is reached: the real one through the person's Google sign-in, or the stand-in on this phone. */
interface DriveLink {
    /** "Google Drive (sam@gmail.com)": who is connected, or null. */
    val accountName: String?
    /** "gdrive:<a hash of the account's ID>": the account sync binds to (DriveSync.ACCOUNT_PREFIX). */
    val accountKey: String?
    /** The Drive calls, while connected. */
    fun api(): DriveApi?
    /**
     * Can this phone reach Google Drive at all? False without Google Play services (a phone that never had them, or
     * a de-Googled one): then the app says so plainly and offers a backup file instead, rather than a dead button.
     */
    val available: Boolean get() = true

    /**
     * Asks Google for the app's own folder in the person's Drive: Android's account chooser and Google's permission
     * screen, shown only while the permission is missing. False when they back out, or when this phone can't reach
     * Drive ([available]). [account] is unused since there are no accounts (D16, 21 Oct 2026). [pick] always shows the
     * account chooser first (Try another Google account, Change account): without it Play Services hands back the
     * account it already knows, and the person never gets to choose another.
     */
    suspend fun connect(context: Context, account: String? = null, pick: Boolean = false): Boolean
    suspend fun disconnect()
    /** Deletes everything the app keeps in the person's Drive (its hidden folder only). */
    suspend fun deleteAll()
}

/** What looking for habits in a Google Drive ended as (the restore flows 2, 8 and 10). */
sealed class DriveLook {
    /**
     * Drive's copy is here now: this is what came down. [activeHabits] is what the free plan counts (not archived,
     * not a task), which is what a restore weighs against the free limit; [habits] is everything, for the words.
     */
    data class Found(val habits: Int, val logs: Int, val activeHabits: Int) : DriveLook()
    /** That Google account holds no Often Enough backup (10.7). Nothing changed. */
    object Nothing : DriveLook()
    /** No internet (8.4). Nothing changed. */
    object Offline : DriveLook()
    /** Signed out, or access removed. Nothing changed. */
    object NotConnected : DriveLook()
    /** Drive had trouble or is full. Nothing changed. */
    object Problem : DriveLook()
}

/**
 * Everything that moves data off the phone or back (Rulebook D4, D5, D9, D10, D16): a checked backup file, the
 * spreadsheet, restore with its 30-day undo, erasing, and Google Drive sync through the core's [DriveSync]. Every
 * backup counts only once it is read back and its checksum matches; a restore keeps an undo file; nothing here ever
 * replaces the phone's data without the person choosing it.
 */
class BackupCenter(private val context: Context, private val store: HabitStore, val link: DriveLink, private val test: Boolean) {
    /**
     * Who made a backup, written into every file it makes: this phone, "android", the app version and whether this
     * phone has Plus **now** (read each time, so a file made after buying says so). The flag is a fact, never a key:
     * it unlocks nothing here or anywhere (Rulebook D16; the user, 22 Oct 2026).
     */
    val info: BackupInfo
        get() = BackupInfo(deviceName = Build.MODEL ?: "Android phone", platform = "android", appVersion = BuildConfig.VERSION_NAME, plus = store.isPlus)
    private val mutex = Mutex()
    /** Carries a round's progress back to the main thread, where the card that shows it is drawn. */
    private val main = Handler(Looper.getMainLooper())
    private val undoFolder = File(context.noBackupFilesDir, if (test) "uitest-restore-undo" else "restore-undo")

    var status by mutableStateOf<DriveStatus?>(null); private set
    var working by mutableStateOf(false); private set
    /** The last restore's undo file, kept 30 days (D5). */
    var undoAvailable by mutableStateOf(latestUndo() != null); private set

    // ------------------------------------------------------------------ Files

    /** "Often Enough backup 2026-10-13 0914.zip": one name on every device, which every app opens (D5). */
    fun fileName(): String = "Often Enough backup " + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HHmm")) + ".zip"
    fun csvName(): String = "Often Enough Export " + java.time.LocalDate.ofEpochDay(store.today().toLong()) + ".csv"

    /** Writes a checked backup file to [uri] (the system's own file picker chose it), then reads it back and compares. */
    suspend fun saveFile(uri: Uri): Boolean = mutex.withLock {
        store.flush()
        val file = store.repo.backupFile(info)
        val bytes = Base64.getDecoder().decode(file.base64)
        withContext(Dispatchers.IO) {
            context.contentResolver.openOutputStream(uri, "wt")?.use { it.write(bytes) } ?: return@withContext false
            val back = context.contentResolver.openInputStream(uri)?.use { it.readBytes() } ?: return@withContext false
            sha256(back) == file.sha256
        }
    }

    /** The spreadsheet, for reading (never for restoring). */
    suspend fun exportCsv(uri: Uri): Boolean {
        store.flush()
        val text = DataExport.csv(DataExport.rows(store))
        return withContext(Dispatchers.IO) {
            context.contentResolver.openOutputStream(uri, "wt")?.use { it.write(text.toByteArray()) } != null
        }
    }

    /**
     * Restoring from Google Drive (the restore flows 2, 8, 10): connects the chosen account and brings Drive's copy
     * down, **sending nothing up** (a fresh install's welcome isn't finished, D14), so the copy in Drive is untouched
     * whatever happens here and [eraseThisPhone] can put this phone back exactly as it was.
     */
    suspend fun lookInDrive(): DriveLook {
        val key = link.accountKey ?: return DriveLook.NotConnected
        val s = sync() ?: return DriveLook.NotConnected
        val habitsBefore = store.habits.size
        val logsBefore = store.entryCount
        mutex.withLock {
            working = true
            try {
                s.connect(key)
                val result = s.syncNow(allowUpload = false)
                status = result
                when (result.state) {
                    DriveState.OFFLINE -> return DriveLook.Offline
                    DriveState.NOT_CONNECTED -> return DriveLook.NotConnected
                    DriveState.PROBLEM, DriveState.BUSY, DriveState.FULL -> return DriveLook.Problem
                    else -> Unit
                }
                store.reloadAfterSync()
                store.flush()
            } finally {
                working = false
            }
        }
        // Nothing new came down: that Google account has no Often Enough backup in it (10.7).
        if (store.habits.size == habitsBefore && store.entryCount == logsBefore) return DriveLook.Nothing
        return DriveLook.Found(store.habits.count { !it.archived }, store.entryCount, store.activeHabitCount)
    }

    // ------------------------------------------------------------------ Restore

    /** A file chosen to restore, checked: what it holds and what each way would change. Nothing changes yet. */
    class Pending(val base64: String, val check: BackupCheck)

    suspend fun check(uri: Uri): Pending? {
        val bytes = withContext(Dispatchers.IO) { context.contentResolver.openInputStream(uri)?.use { it.readBytes() } } ?: return null
        return check(bytes)
    }

    suspend fun check(bytes: ByteArray): Pending {
        val base64 = Base64.getEncoder().encodeToString(bytes)
        return Pending(base64, store.repo.checkBackup(base64))
    }

    /** Restores, keeping this phone as it was just before as the undo file (D5), then shows what came back. */
    suspend fun restore(pending: Pending, mode: RestoreMode): RestoreChanges = mutex.withLock {
        working = true
        try {
            store.flush()
            val result = store.repo.restore(pending.base64, mode, info)
            withContext(Dispatchers.IO) {
                undoFolder.mkdirs()
                File(undoFolder, "undo-${System.currentTimeMillis()}.zip").writeBytes(Base64.getDecoder().decode(result.undo.base64))
                pruneUndo()
            }
            undoAvailable = true
            store.reloadAfterSync()
            store.flush()
            result.changes
        } finally {
            working = false
        }
    }

    /** Puts the phone back exactly as it was before the last restore. */
    suspend fun undoRestore(): Boolean = mutex.withLock {
        val file = latestUndo() ?: return false
        store.flush()
        val base64 = withContext(Dispatchers.IO) { Base64.getEncoder().encodeToString(file.readBytes()) }
        store.repo.restore(base64, RestoreMode.REPLACE, info)
        withContext(Dispatchers.IO) { file.delete() }
        undoAvailable = latestUndo() != null
        store.reloadAfterSync()
        store.flush()
        true
    }

    private fun latestUndo(): File? = undoFolder.listFiles { f -> f.name.startsWith("undo-") }.orEmpty()
        .filter { System.currentTimeMillis() - it.lastModified() < UNDO_DAYS * 86_400_000L }.maxByOrNull { it.lastModified() }

    private fun pruneUndo() {
        undoFolder.listFiles().orEmpty().filter { System.currentTimeMillis() - it.lastModified() >= UNDO_DAYS * 86_400_000L }.forEach { it.delete() }
    }

    // ------------------------------------------------------------------ Erase

    /** Erase all my data: Drive sync goes off first, so the erased habits don't come straight back (D9). */
    suspend fun eraseThisPhone() = mutex.withLock {
        if (link.accountKey != null) link.disconnect()
        store.eraseEverything()
        status = null
    }

    // ------------------------------------------------------------------ Google Drive (D16)

    private fun sync(): DriveSync? = link.api()?.let { DriveSync(store.repo, it, info.deviceName, "android") }

    suspend fun connectDrive(pick: Boolean = false): Boolean {
        if (!link.connect(context, pick = pick)) return false
        val key = link.accountKey ?: return false
        sync()?.connect(key)
        syncNow()
        return true
    }

    /** One round: download, merge, upload (never replace). The phone's own data stays the truth (D1). */
    suspend fun syncNow(): DriveStatus? {
        return mutex.withLock {
            val s = sync() ?: return null
            working = true
            try {
                store.flush()
                val result = s.syncNow(allowUpload = true)
                status = result
                if (result.state != DriveState.OFF) store.reloadAfterSync()
                result
            } finally {
                working = false
            }
        }
    }

    /**
     * **Back up again** (A39): everything on this phone goes to Drive again, every file, after the Drive copy was
     * deleted. A backup saves only the files that changed, so carrying on quietly would leave the untouched years
     * missing. [progress] is told how many files of how many are saved, on the main thread, for the card the person
     * is watching. False when it didn't finish; nothing on this phone is touched either way.
     */
    suspend fun backUpEverythingAgain(progress: (Int, Int) -> Unit = { _, _ -> }): Boolean = mutex.withLock {
        val s = sync()
        if (s == null) return@withLock false
        working = true
        try {
            store.flush()
            val result = s.sendEverythingAgain { saved, of -> main.post { progress(saved, of) } }
            status = result
            if (result.state != DriveState.OFF) store.reloadAfterSync()
            result.state == DriveState.SYNCED
        } catch (_: Exception) {
            false
        } finally {
            working = false
        }
    }

    suspend fun refreshStatus() { status = sync()?.status() }

    /** Delete my data from Google Drive: only there, deliberately; this phone keeps everything (D9). */
    suspend fun deleteFromDrive() {
        mutex.withLock {
            link.deleteAll()
            link.disconnect()
            status = null
        }
    }

    suspend fun disconnectDrive() = mutex.withLock { link.disconnect(); status = null }

    companion object {
        const val UNDO_DAYS = 30
        fun sha256(bytes: ByteArray): String = MessageDigest.getInstance("SHA-256").digest(bytes).joinToString("") { "%02x".format(it) }
    }
}
