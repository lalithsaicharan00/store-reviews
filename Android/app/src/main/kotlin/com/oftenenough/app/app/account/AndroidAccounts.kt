// TO BE DELETED (the user, 21 Oct 2026): no accounts; Plus moves between iPhone and Android by hand. The server side was deleted the same day (account-server/README.md, "The accounts, deleted 21 Oct 2026").
package com.oftenenough.app.app.account

import android.content.SharedPreferences
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import app.habits.account.Account
import app.habits.account.AccountCenter
import app.habits.account.AccountHolder
import app.habits.account.AccountHttp
import app.habits.account.AccountRequest
import app.habits.account.AccountResponse
import app.habits.account.AccountServer
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.io.IOException
import java.net.HttpURLConnection
import java.net.URL
import kotlin.coroutines.CoroutineContext
import kotlin.coroutines.EmptyCoroutineContext

/*
 * Android's side of the shared Plus account (Core `app.habits.account`, moved there on 16 Oct 2026 so the iPhone runs
 * the same code): where the account is saved, how Compose redraws when it changes, and sending one HTTP request. The
 * account, the family, the Worker's protocol and the stand-in's rules all live in the core.
 */

/** One text in SharedPreferences, written at once (`commit`): an account that signed in must survive the process stopping. */
class PrefsStorage(private val sp: SharedPreferences, private val key: String) : app.habits.account.AccountStorage {
    override fun read(): String? = sp.getString(key, null)
    override fun write(text: String?) {
        if (text == null) sp.edit().remove(key).commit() else sp.edit().putString(key, text).commit()
    }
}

/** The account as Compose state, so every screen that reads it redraws when it changes. */
class ComposeAccountHolder : AccountHolder {
    override var value: Account? by mutableStateOf(null)
}

/** The account on this phone: kept in [sp] under [AccountCenter.FILE], read by Compose, answered on [ui]. */
fun androidAccountCenter(sp: SharedPreferences, server: AccountServer, ui: CoroutineContext = EmptyCoroutineContext) =
    AccountCenter(PrefsStorage(sp, AccountCenter.FILE), server, ComposeAccountHolder(), ui)

/** The Worker's stand-in on this phone, its state in [sp] (debug builds and tests only; D8). */
fun androidStandInServer(sp: SharedPreferences, today: () -> Long) =
    app.habits.account.StandInAccountServer(PrefsStorage(sp, "state"), today, nowMs = System::currentTimeMillis)

/** The real Worker at [base] (`HttpAccountServer.DEV` or `.PRODUCTION`), reached with [AndroidAccountHttp]. */
fun androidAccountServer(base: String, timeoutMs: Int = 15_000) = app.habits.account.HttpAccountServer(base, AndroidAccountHttp(timeoutMs))

/**
 * One HTTPS request for the core's [app.habits.account.HttpAccountServer]: null when no answer came (offline, timed out,
 * cut off). Never logs a body, a session or an invite token (D11); debug builds log which call answered what.
 */
class AndroidAccountHttp(private val timeoutMs: Int = 15_000) : AccountHttp {
    override suspend fun send(request: AccountRequest): AccountResponse? = withContext(Dispatchers.IO) {
        val reply = try {
            val connection = (URL(request.url).openConnection() as HttpURLConnection).apply {
                requestMethod = request.method
                connectTimeout = timeoutMs
                readTimeout = timeoutMs
                useCaches = false
                setRequestProperty("accept", "application/json")
                request.session?.let { setRequestProperty("authorization", "Bearer $it") }
                if (request.body != null) {
                    doOutput = true
                    setRequestProperty("content-type", "application/json")
                }
            }
            try {
                request.body?.let { body -> connection.outputStream.use { it.write(body.toByteArray(Charsets.UTF_8)) } }
                val status = connection.responseCode
                val stream = if (status in 200..299) connection.inputStream else connection.errorStream
                AccountResponse(status, stream?.use { it.readBytes().toString(Charsets.UTF_8) }.orEmpty())
            } finally {
                connection.disconnect()
            }
        } catch (e: IOException) {
            // HttpURLConnection throws this on a 401 that has no WWW-Authenticate header (the Worker sends one).
            if (e.message?.contains("authentication challenge", ignoreCase = true) == true) AccountResponse(401, "") else null
        }
        if (com.oftenenough.app.BuildConfig.DEBUG) {
            val path = request.url.substringAfter("://").substringAfter('/', "").replace(Regex("invites/[^/]+"), "invites/…")
            android.util.Log.d("AccountServer", "${request.method} /$path → ${reply?.status ?: "no answer"}")
        }
        reply
    }
}
