package com.oftenenough.app.app.backup

import android.content.Context
import android.content.SharedPreferences
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import app.habits.core.DriveApi
import java.io.File

/**
 * **A Google Drive on this phone, for tests and for working without Google Play.** Every test launch gets one of its
 * own, emptied each launch (D8: a test never touches the person's Drive), and a debug build made with
 * `-PstandInDrive` uses one too, for an emulator with no Google Play services. It is "connected" as the Google
 * account Google's chooser would have given ([nextAccount], which a test sets); every account shares the one folder,
 * and what differs is the account's key, as the real Drive's does ([driveKey]), so coming back with a different
 * Google account can be tested. The person's own Drive is [GoogleDriveLink].
 */
class StandInLink(private val folder: File, private val prefs: SharedPreferences) : DriveLink {
    /** The account the next "chooser" gives (StandInSignIn's default person). */
    var nextAccount = "sam@gmail.com"
    // Connected before the stand-in had accounts: its default person.
    private var account by mutableStateOf(if (prefs.getBoolean(KEY, false)) prefs.getString(ACCOUNT, null) ?: nextAccount else null)
    private val drive by lazy { LocalDrive(folder) }

    override val email: String? get() = account
    override val accountKey: String? get() = account?.let(::driveKey)
    override fun api(): DriveApi? = if (account != null) drive else null

    override suspend fun connect(context: Context, account: String?, pick: Boolean): Boolean {
        val chosen = account ?: nextAccount
        this.account = chosen
        prefs.edit().putBoolean(KEY, true).putString(ACCOUNT, chosen).apply()
        return true
    }

    override suspend fun disconnect() {
        account = null
        prefs.edit().putBoolean(KEY, false).apply()
    }

    override suspend fun deleteAll() { drive.clear() }

    private companion object {
        const val KEY = "drive.standin.connected"
        const val ACCOUNT = "drive.standin.account"

        /** The key DriveSync binds to: "gdrive:" and a SHA-256 of Google's fixed ID (here the stand-in's email). */
        fun driveKey(email: String): String = "gdrive:" + java.security.MessageDigest.getInstance("SHA-256")
            .digest("google:stand-in:${email.lowercase()}".toByteArray()).joinToString("") { "%02x".format(it) }
    }
}

/** A phone with no Google Play services: Google Drive can't be reached at all. Backup files still work. */
object NoDriveLink : DriveLink {
    override val available: Boolean get() = false
    override val email: String? get() = null
    override val accountKey: String? get() = null
    override fun api(): DriveApi? = null
    override suspend fun connect(context: Context, account: String?, pick: Boolean): Boolean = false
    override suspend fun disconnect() {}
    override suspend fun deleteAll() {}
}
