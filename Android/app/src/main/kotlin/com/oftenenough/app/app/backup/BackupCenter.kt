package com.oftenenough.app.app.backup

import android.content.Context
import android.net.Uri
import android.os.Build
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
     * Signs in (Android's own account chooser and Google's permission screen); false when the person backs out. With
     * [account] (the email this phone just signed in to Plus with, D16: "signed in with Google, backed up to that same
     * account"), that account is asked for at once, with no chooser; the email stays on this phone.
     */
    suspend fun connect(context: Context, account: String? = null): Boolean
    suspend fun disconnect()
    /** Deletes everything the app keeps in the person's Drive (its hidden folder only). */
    suspend fun deleteAll()
}

/**
 * Everything that moves data off the phone or back (Rulebook D4, D5, D9, D10, D16): a checked backup file, the
 * spreadsheet, restore with its 30-day undo, erasing, and Google Drive sync through the core's [DriveSync]. Every
 * backup counts only once it is read back and its checksum matches; a restore keeps an undo file; nothing here ever
 * replaces the phone's data without the person choosing it.
 */
class BackupCenter(private val context: Context, private val store: HabitStore, val link: DriveLink, private val test: Boolean) {
    val info = BackupInfo(deviceName = Build.MODEL ?: "Android phone", platform = "android", appVersion = BuildConfig.VERSION_NAME)
    private val mutex = Mutex()
    private val undoFolder = File(context.noBackupFilesDir, if (test) "uitest-restore-undo" else "restore-undo")

    var status by mutableStateOf<DriveStatus?>(null); private set
    var working by mutableStateOf(false); private set
    /** The last restore's undo file, kept 30 days (D5). */
    var undoAvailable by mutableStateOf(latestUndo() != null); private set

    // ------------------------------------------------------------------ Files

    /** "Often Enough 2026-10-13 0914.zip", as the iPhone names its file. */
    fun fileName(): String = "Often Enough " + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HHmm")) + ".zip"
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
     * Coming back with Google Drive (Onboarding: coming back, 4.2): connects the chosen account and brings Drive's copy
     * down, sending nothing up (a fresh install's welcome isn't finished, D14). The habits found, or null when Drive
     * couldn't be reached. Start fresh erases what came down ([eraseThisPhone]); the copy in Drive stays.
     */
    suspend fun lookInDrive(): Pair<Int, Int>? {
        val key = link.accountKey ?: return null
        val s = sync() ?: return null
        mutex.withLock {
            working = true
            try {
                s.connect(key)
                val result = s.syncNow(allowUpload = false)
                status = result
                if (result.state == DriveState.OFFLINE || result.state == DriveState.NOT_CONNECTED || result.state == DriveState.PROBLEM || result.state == DriveState.BUSY) return null
                store.reloadAfterSync()
                store.flush()
            } finally {
                working = false
            }
        }
        return store.habits.count { !it.archived } to store.entryCount
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

    suspend fun connectDrive(): Boolean {
        if (!link.connect(context)) return false
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
