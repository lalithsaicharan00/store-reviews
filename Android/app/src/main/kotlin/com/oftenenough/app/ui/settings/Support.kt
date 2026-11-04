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
    const val EMAIL = "lalithsaicharan00@gmail.com"
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

// Open source licences are Google's own screen (OssLicensesMenuActivity, Settings › Open-source licences): its list is
// made from the app's dependencies at build time, so no library is ever left out.
