package com.oftenenough.app.app

import android.app.KeyguardManager
import android.content.Context
import android.content.SharedPreferences
import android.os.SystemClock
import android.provider.Settings
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import java.security.MessageDigest
import java.security.SecureRandom
import javax.crypto.SecretKeyFactory
import javax.crypto.spec.PBEKeySpec

/**
 * App lock (design §19; the iPhone's AppLock.swift): the app asks for the phone's own lock (fingerprint, face, PIN or
 * pattern, through Android's prompt) or a six-digit app passcode when it opens. Kept on this phone only: its file is
 * left out of Android's backup (res/xml), so after moving phones App lock is off and the habits are all there.
 *
 * Nothing here ever deletes a habit. Wrong codes wait (after 5 in a row: 1, 5 and 15 minutes, then an hour each);
 * a forgotten passcode is replaced through the phone's own lock, or after a 24-hour reset when the phone has none.
 * Only a salted PBKDF2 hash of the passcode is kept.
 */
class AppLock(private val sp: SharedPreferences, private val now: () -> Long = { System.currentTimeMillis() }) {
    enum class Method { PHONE, PASSCODE }

    /** How long the app stays open after leaving it. Locking the phone always locks it. */
    enum class Again(val seconds: Long, val words: String) {
        IMMEDIATELY(0, "Immediately"), ONE_MINUTE(60, "After 1 minute"), FIFTEEN_MINUTES(900, "After 15 minutes");
    }

    var isOn by mutableStateOf(sp.getBoolean(ON, false)); private set
    var method by mutableStateOf(runCatching { Method.valueOf(sp.getString(METHOD, "PHONE")!!) }.getOrDefault(Method.PHONE)); private set
    var again by mutableStateOf(runCatching { Again.valueOf(sp.getString(AGAIN, "IMMEDIATELY")!!) }.getOrDefault(Again.IMMEDIATELY)); private set
    /** Shown over the app until unlocked. */
    var isLocked by mutableStateOf(isOn); private set
    /** Bumped on a wrong code, so the dots shake. */
    var wrongCount by mutableIntStateOf(0); private set

    val hasPasscode: Boolean get() = sp.getString(HASH, null) != null

    // ------------------------------------------------------------------ Turning it on and off

    /** On with the phone's lock (after Android's prompt confirmed it works). */
    fun turnOnWithPhone() {
        sp.edit().putBoolean(ON, true).putString(METHOD, Method.PHONE.name).apply()
        isOn = true; method = Method.PHONE; isLocked = false
    }

    /** On with a new app passcode (typed twice). */
    fun turnOnWithPasscode(code: String) {
        setPasscode(code)
        sp.edit().putBoolean(ON, true).putString(METHOD, Method.PASSCODE.name).apply()
        isOn = true; method = Method.PASSCODE; isLocked = false
    }

    /** Off: every lock setting and the passcode go; the habits never do. */
    fun turnOff() {
        sp.edit().clear().apply()
        isOn = false; isLocked = false; method = Method.PHONE; again = Again.IMMEDIATELY
    }

    fun chooseAgain(value: Again) {
        sp.edit().putString(AGAIN, value.name).apply()
        again = value
    }

    // ------------------------------------------------------------------ Locking

    /** The app left the screen. */
    fun left() { if (isOn) sp.edit().putLong(LEFT_AT, SystemClock.elapsedRealtime()).apply() }

    /** The phone was locked: the app locks at once, whatever Lock again says. */
    fun phoneLocked() { if (isOn) isLocked = true }

    /** The app came back: locked again once Lock again's time is up. */
    fun returned() {
        if (!isOn || isLocked) return
        val leftAt = sp.getLong(LEFT_AT, -1L)
        val away = if (leftAt < 0) Long.MAX_VALUE else SystemClock.elapsedRealtime() - leftAt
        if (away < 0 || away >= again.seconds * 1000) isLocked = true
    }

    /** Unlocked by the phone's own lock, or a right code. Every wait is cleared. */
    fun opened() {
        sp.edit().remove(FAILURES).remove(WAIT_ENDS).remove(RESET_AT).remove(RESET_BOOT).remove(RESET_ELAPSED).apply()
        isLocked = false
    }

    // ------------------------------------------------------------------ The passcode

    fun setPasscode(code: String) {
        val salt = ByteArray(16).also { SecureRandom().nextBytes(it) }
        sp.edit().putString(SALT, salt.hex()).putString(HASH, hash(code, salt).hex()).apply()
    }

    fun isRight(code: String): Boolean {
        val salt = sp.getString(SALT, null)?.unhex() ?: return false
        val stored = sp.getString(HASH, null)?.unhex() ?: return false
        return MessageDigest.isEqual(stored, hash(code, salt))
    }

    /** Milliseconds left of a wait after wrong codes, or null. */
    fun waitLeft(): Long? = sp.getLong(WAIT_ENDS, 0L).let { ends -> (ends - now()).takeIf { it > 0 } }

    /** "Try again in 5 minutes." while a wait runs. */
    fun waitText(): String? = waitLeft()?.let { left ->
        val minutes = ((left + 59_999) / 60_000).toInt()
        when { minutes >= 60 -> "Try again in 1 hour."; minutes == 1 -> "Try again in 1 minute."; else -> "Try again in $minutes minutes." }
    }

    /**
     * A typed code. Right: the app opens (a waiting reset is cancelled). Wrong: "That's not your app passcode."; after 5
     * in a row, a wait. Returns the message to show, or null when it opened.
     */
    fun enter(code: String): String? {
        waitText()?.let { return it }
        if (isRight(code)) { opened(); return null }
        val failures = sp.getInt(FAILURES, 0) + 1
        val edit = sp.edit().putInt(FAILURES, failures)
        if (failures >= 5) edit.putLong(WAIT_ENDS, now() + WAITS[minOf(failures - 5, WAITS.size - 1)] * 1000)
        edit.apply()
        wrongCount++
        return waitText() ?: "That's not your app passcode."
    }

    // ------------------------------------------------------------------ Forgot the passcode: the 24-hour reset

    /** Starts the 24 hours. Counted on the phone's running clock, so changing its time can't shorten it. */
    fun startReset(context: Context) {
        sp.edit().putLong(RESET_AT, now()).putLong(RESET_ELAPSED, SystemClock.elapsedRealtime()).putInt(RESET_BOOT, bootCount(context)).apply()
    }

    fun resetStarted(): Boolean = sp.contains(RESET_AT)

    /** Milliseconds left of a started reset (0 when it's up), or null when none was started. */
    fun resetLeft(context: Context): Long? {
        if (!sp.contains(RESET_AT)) return null
        // The same run of the phone: its running clock. After a restart: the wall clock, and never less than a full day.
        val gone = if (sp.getInt(RESET_BOOT, -1) == bootCount(context)) SystemClock.elapsedRealtime() - sp.getLong(RESET_ELAPSED, 0L)
            else now() - sp.getLong(RESET_AT, 0L)
        return maxOf(0L, RESET_MS - gone)
    }

    fun cancelReset() { sp.edit().remove(RESET_AT).remove(RESET_BOOT).remove(RESET_ELAPSED).apply() }

    private fun bootCount(context: Context): Int = runCatching { Settings.Global.getInt(context.contentResolver, Settings.Global.BOOT_COUNT) }.getOrDefault(-1)

    companion object {
        const val FILE = "applock"
        private const val ON = "on"
        private const val METHOD = "method"
        private const val AGAIN = "again"
        private const val SALT = "salt"
        private const val HASH = "hash"
        private const val FAILURES = "failures"
        private const val WAIT_ENDS = "waitEnds"
        private const val LEFT_AT = "leftAt"
        private const val RESET_AT = "resetAt"
        private const val RESET_ELAPSED = "resetElapsed"
        private const val RESET_BOOT = "resetBoot"
        const val RESET_MS = 24 * 3_600_000L
        private val WAITS = longArrayOf(60, 300, 900, 3600)

        /** Whether the phone has a screen lock (a PIN, pattern or password) to fall back on. */
        fun phoneIsSecure(context: Context): Boolean = context.getSystemService(KeyguardManager::class.java)?.isDeviceSecure == true

        fun hash(code: String, salt: ByteArray): ByteArray =
            SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256").generateSecret(PBEKeySpec(code.toCharArray(), salt, 60_000, 256)).encoded

        private fun ByteArray.hex() = joinToString("") { "%02x".format(it) }
        private fun String.unhex() = chunked(2).map { it.toInt(16).toByte() }.toByteArray()
    }
}
