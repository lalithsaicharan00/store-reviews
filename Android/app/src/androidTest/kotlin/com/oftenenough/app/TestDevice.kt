package com.oftenenough.app

import androidx.test.platform.app.InstrumentationRegistry
import androidx.test.uiautomator.By
import androidx.test.uiautomator.UiDevice

/**
 * The emulator itself, for the tests that need the app's window to be the one in front: the back key and everything
 * UI Automator does go to the focused window. On GitHub's emulator something of the system's can be on top (run
 * 38390489090: the app's window had no focus from one test on, and six tests failed with nothing to go on), so each
 * of those tests clears system dialogs first, and a failure names the window that had the focus (T14).
 */
object TestDevice {
    val device: UiDevice get() = UiDevice.getInstance(InstrumentationRegistry.getInstrumentation())

    private fun shell(command: String): String = runCatching { device.executeShellCommand(command) }.getOrDefault("")

    /** The window that has the focus, on one line: "mCurrentFocus=Window{… com.oftenenough.app/….MainActivity}". */
    fun focus(): String = shell("dumpsys window displays").lineSequence().map { it.trim() }
        .filter { it.startsWith("mCurrentFocus") || it.startsWith("mFocusedApp") }.distinct().joinToString(" ").take(400)
        .ifBlank { "(no focused window reported)" }

    /** Every text on screen, whichever app or system window it belongs to, on one line. */
    fun everything(): String = runCatching {
        device.findObjects(By.enabled(true)).mapNotNull { o -> runCatching { o.text ?: o.contentDescription }.getOrNull() }
            .filter { it.isNotBlank() }.distinct().joinToString(" | ").take(1200)
    }.getOrDefault("(couldn't read the screen)")

    /** For a failure message: what had the focus and what was showing. */
    fun state(): String = "focus: ${focus()}; showing: ${everything()}"

    /** Closes whatever of the system's is over the app: a shade or dialog, and an "isn't responding" question (Wait). */
    fun clear() {
        if (focus().contains("com.oftenenough.app")) return
        shell("am broadcast -a android.intent.action.CLOSE_SYSTEM_DIALOGS")
        runCatching { device.findObject(By.res("android:id/aerr_wait"))?.click() }
        device.waitForIdle(1_000)
    }
}
