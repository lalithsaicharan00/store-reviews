package com.oftenenough.app.ui.settings

import android.content.Intent
import android.net.Uri
import android.os.Build
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.height
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.oftenenough.app.BuildConfig
import com.oftenenough.app.ui.components.ListRow
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.newhabit.FormPage
import com.oftenenough.app.ui.newhabit.Note

/** Where people write to us, and what the email starts with: the app and Android versions, never their habits. */
object Support {
    const val EMAIL = "support@oftenenough.com"
    val appVersion: String get() = "${BuildConfig.VERSION_NAME} (${BuildConfig.VERSION_CODE})"

    /** Contact us (the menu): help. A29's subject, so the two are told apart at a glance. */
    fun mail(): Intent = letter("Often Enough: I need help")

    /** Send feedback (the menu): feedback, not help (A29). */
    fun feedback(): Intent = letter("Often Enough feedback")

    private fun letter(subject: String): Intent = Intent(Intent.ACTION_SENDTO, Uri.parse("mailto:")).apply {
        putExtra(Intent.EXTRA_EMAIL, arrayOf(EMAIL))
        putExtra(Intent.EXTRA_SUBJECT, subject)
        putExtra(Intent.EXTRA_TEXT, "\n\n\n—\nOften Enough $appVersion · ${Build.MANUFACTURER} ${Build.MODEL} · Android ${Build.VERSION.RELEASE}")
    }
}

/** The libraries inside the app, with their licences (the iPhone's AboutView, plus Android's own). */
private val libraries = listOf(
    "Kotlin standard library" to "Apache License 2.0 · JetBrains",
    "kotlinx.coroutines" to "Apache License 2.0 · JetBrains",
    "AndroidX Room" to "Apache License 2.0 · Google",
    "AndroidX SQLite" to "Apache License 2.0 · Google",
    "Jetpack Compose" to "Apache License 2.0 · Google",
    "SQLite" to "Public domain",
)

/** Open source licences: each library's licence, in full words a person can read (Android's standard page). */
@Composable
fun LicencesPage(onBack: () -> Unit) {
    FormPage("Open source licences", onBack = onBack) {
        Spacer(Modifier.height(8.dp))
        SegmentedList { libraries.forEachIndexed { i, (name, licence) -> ListRow(name, i, libraries.size, licence) } }
        Note("The Apache License 2.0 lets anyone use, change and share the software, keeping its copyright and licence notices. Its full text: apache.org/licenses/LICENSE-2.0. SQLite is in the public domain: anyone may use it for any purpose.")
        Spacer(Modifier.height(24.dp))
    }
}
