package com.oftenenough.app.app.backup

import android.accounts.Account
import android.app.PendingIntent
import android.content.Context
import android.content.SharedPreferences
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import app.habits.core.DriveApi
import app.habits.core.DriveRequest
import app.habits.core.DriveError
import app.habits.core.DriveSync
import app.habits.core.DriveTokens
import app.habits.core.GoogleDrive
import com.google.android.gms.auth.api.identity.AuthorizationRequest
import com.google.android.gms.auth.api.identity.AuthorizationResult
import com.google.android.gms.auth.api.identity.Identity
import com.google.android.gms.common.api.Scope
import java.security.MessageDigest
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlinx.coroutines.withContext
import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException

/**
 * **The person's own Google Drive, for real** (A4, A39; Rulebook D16).
 *
 * Everything about *what* goes to Drive is the shared core's ([DriveSync], [GoogleDrive]): the app's hidden folder,
 * one *base* file and one file per year of logs, each a version chain, merged by record ID, download → merge → upload,
 * never replace. This class is only the handshake Android needs to get at it: Google's own account chooser and
 * permission screen, and an access token for `drive.appdata`.
 *
 * **Why `AuthorizationClient` and not a sign-in.** We want a scope, not an identity: there are no accounts and nobody
 * signs in to anything of ours (D16). Play Services recognises the app by its package name and signing certificate
 * matched against an **Android OAuth client** in our Google Cloud project — nothing is passed from here, and there is
 * no client ID in the code. Every app that is to reach the same hidden folder (a later desktop or web app) must have
 * its client in **that same project**: Google ties the folder to the project, not to the app (A39).
 */
class GoogleDriveLink(context: Context, private val prefs: SharedPreferences) : DriveLink {
    private val appContext = context.applicationContext
    private val client = Identity.getAuthorizationClient(appContext)

    /** The Google account's own address, for the words only ("Google Drive (sam@gmail.com)"). Never sent anywhere. */
    override var email by mutableStateOf(prefs.getString(EMAIL, null)); private set

    /** The last token Play Services gave, kept only in memory. */
    @Volatile private var token: String? = null

    /**
     * What sync binds to: `gdrive:` and a SHA-256 of the account's address. It never leaves the phone; it is here so
     * that connecting a *different* Google account is noticed and everything is queued for the new Drive, rather than
     * carrying on against another account's version chain.
     */
    override val accountKey: String? get() = email?.let { DriveSync.ACCOUNT_PREFIX + sha256(it) }

    override fun api(): DriveApi? = if (email == null) null else GoogleDrive(HttpDrive(), tokens)

    private val tokens = object : DriveTokens {
        override suspend fun accessToken(refresh: Boolean): String {
            if (!refresh) token?.let { return it }
            // Play Services keeps and refreshes the grant; asking again after a refusal gets a fresh token. It only
            // needs the person when the grant itself is gone, and then there is nothing to hand out.
            val result = authorize() ?: throw DriveError.NotConnected("no grant")
            if (result.hasResolution()) throw DriveError.NotConnected("consent needed")
            val fresh = result.accessToken ?: throw DriveError.NotConnected("no token")
            token = fresh
            return fresh
        }
    }

    /**
     * Connects a Google account: Android's own chooser and Google's permission screen, shown only when this phone
     * hasn't granted `drive.appdata` yet. False when the person backs out — nothing is kept, and nothing is sent.
     *
     * [account] is ignored: there are no accounts to take a hint from any more (D16, 21 Oct 2026).
     */
    override suspend fun connect(context: Context, account: String?, pick: Boolean): Boolean {
        // Figma's Try another Google account and Change account open the chooser every time (onboarding 10.8).
        val chosen = if (pick) DriveConsent.pickAccount?.invoke() ?: return false else null
        val result = authorize(chosen) ?: return false
        val granted = if (result.hasResolution()) {
            val pending = result.pendingIntent ?: return false
            if (!(DriveConsent.ask?.invoke(pending) ?: false)) return false
            // After the person allows it, ask again: this time it answers with the token and no resolution.
            authorize(chosen)?.takeIf { !it.hasResolution() } ?: return false
        } else {
            result
        }
        val who = who(granted) ?: return false
        token = granted.accessToken
        email = who
        prefs.edit().putString(EMAIL, who).apply()
        return true
    }

    override suspend fun disconnect() {
        token = null
        email = null
        prefs.edit().remove(EMAIL).apply()
        // The grant itself stays with Google (the person takes it back in their Google Account, which the
        // permission screen says). This phone forgets the account, so nothing here can reach that Drive again.
    }

    /** Deletes everything the app keeps in the person's Drive (its hidden folder only, never anything else). */
    override suspend fun deleteAll() {
        val drive = api() ?: return
        for (file in drive.list()) runCatching { drive.delete(file.id) }
    }

    // ---------------------------------------------------------------- Google

    private suspend fun authorize(account: String? = null): AuthorizationResult? = withContext(Dispatchers.IO) {
        val request = AuthorizationRequest.Builder().setRequestedScopes(listOf(Scope(APPDATA)))
            .apply { if (account != null) setAccount(Account(account, "com.google")) }.build()
        runCatching { await(request) }.getOrNull()
    }

    private suspend fun await(request: AuthorizationRequest): AuthorizationResult =
        suspendCancellableCoroutine { go ->
            client.authorize(request)
                .addOnSuccessListener { if (go.isActive) go.resume(it) }
                .addOnFailureListener { if (go.isActive) go.resumeWithException(it) }
                .addOnCanceledListener { if (go.isActive) go.resumeWithException(CancellationException("cancelled")) }
        }

    /**
     * Which Google account this is. Play Services answers with it after an interactive grant; when it doesn't, Drive
     * is asked itself (`about`, the one call the appdata scope allows about the person). Null means we can't tell,
     * and then nothing is connected: a key we can't trust would let two accounts share one version chain.
     */
    private suspend fun who(result: AuthorizationResult): String? {
        result.toGoogleSignInAccount()?.email?.takeIf { it.isNotBlank() }?.let { return it }
        val reply = runCatching {
            HttpDrive().send(
                DriveRequest(
                    "GET", "https://www.googleapis.com/drive/v3/about?fields=user(emailAddress)",
                    mapOf("Authorization" to "Bearer " + (result.accessToken ?: return null)), null,
                ),
            )
        }.getOrNull() ?: return null
        if (reply.status != 200) return null
        return Regex("\"emailAddress\"\\s*:\\s*\"([^\"]+)\"").find(reply.body.decodeToString())?.groupValues?.get(1)
    }

    private fun sha256(text: String): String =
        MessageDigest.getInstance("SHA-256").digest(text.lowercase().trim().toByteArray()).joinToString("") { "%02x".format(it) }

    companion object {
        /** The app's own hidden folder in the person's Drive, and nothing else of theirs. */
        const val APPDATA = "https://www.googleapis.com/auth/drive.appdata"
        private const val EMAIL = "drive.account"
    }
}

/**
 * Google's permission screen needs an Activity to show itself in. The one Activity registers how to show it here, and
 * [GoogleDriveLink] asks for it only when the grant is missing.
 */
object DriveConsent {
    /** Shows Google's permission screen and answers true when the person allowed it. */
    @Volatile var ask: (suspend (PendingIntent) -> Boolean)? = null
    /** Shows Android's own account chooser for Google accounts; the chosen address, or null when they back out. */
    @Volatile var pickAccount: (suspend () -> String?)? = null
}
