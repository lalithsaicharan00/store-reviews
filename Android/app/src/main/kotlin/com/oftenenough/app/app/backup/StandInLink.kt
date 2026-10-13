package com.oftenenough.app.app.backup

import android.content.Context
import android.content.SharedPreferences
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import app.habits.core.DriveApi
import java.io.File

/**
 * Google Drive while the Android OAuth client doesn't exist yet (build prompt §5): the stand-in Drive on this phone,
 * "connected" as a stand-in account. Debug builds and test launches only; a release build has no stand-in.
 */
class StandInLink(private val folder: File, private val prefs: SharedPreferences) : DriveLink {
    private var connected by mutableStateOf(prefs.getBoolean(KEY, false))
    private val drive by lazy { LocalDrive(folder) }

    override val accountName: String? get() = if (connected) "stand-in Drive on this phone" else null
    override val accountKey: String? get() = if (connected) "gdrive:standin" else null
    override fun api(): DriveApi? = if (connected) drive else null

    override suspend fun connect(context: Context): Boolean {
        connected = true
        prefs.edit().putBoolean(KEY, true).apply()
        return true
    }

    override suspend fun disconnect() {
        connected = false
        prefs.edit().putBoolean(KEY, false).apply()
    }

    override suspend fun deleteAll() { drive.clear() }

    private companion object { const val KEY = "drive.standin.connected" }
}

/** A release build before the OAuth client exists: Google Drive can't be connected yet; files still work. */
object NoDriveLink : DriveLink {
    override val accountName: String? get() = null
    override val accountKey: String? get() = null
    override fun api(): DriveApi? = null
    override suspend fun connect(context: Context): Boolean = false
    override suspend fun disconnect() {}
    override suspend fun deleteAll() {}
}
