package com.oftenenough.app.app.backup

import android.content.Context
import android.content.SharedPreferences
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import app.habits.account.StandInAccountServer
import app.habits.core.DriveApi
import java.io.File

/**
 * Google Drive while the Android OAuth client doesn't exist yet (build prompt §5): the stand-in Drive on this phone,
 * "connected" as the Google account Google's chooser would have given ([nextAccount], which a test sets). Every account
 * shares the one folder; what differs is the account's key, as the real Drive's would ([StandInAccountServer.driveKey]),
 * so coming back can be tested with a different Google account. Debug builds and test launches only.
 */
class StandInLink(private val folder: File, private val prefs: SharedPreferences) : DriveLink {
    /** The account the next "chooser" gives (StandInSignIn's default person). */
    var nextAccount = "sam@gmail.com"
    // Connected before the stand-in had accounts: its default person.
    private var account by mutableStateOf(if (prefs.getBoolean(KEY, false)) prefs.getString(ACCOUNT, null) ?: nextAccount else null)
    private val drive by lazy { LocalDrive(folder) }

    override val accountName: String? get() = account?.let { "Google Drive ($it)" }
    override val accountKey: String? get() = account?.let(StandInAccountServer::driveKey)
    override fun api(): DriveApi? = if (account != null) drive else null

    override suspend fun connect(context: Context, account: String?): Boolean {
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
    }
}

/** A release build before the OAuth client exists: Google Drive can't be connected yet; files still work. */
object NoDriveLink : DriveLink {
    override val accountName: String? get() = null
    override val accountKey: String? get() = null
    override fun api(): DriveApi? = null
    override suspend fun connect(context: Context, account: String?): Boolean = false
    override suspend fun disconnect() {}
    override suspend fun deleteAll() {}
}
