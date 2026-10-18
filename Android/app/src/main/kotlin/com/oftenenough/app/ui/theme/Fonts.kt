package com.oftenenough.app.ui.theme

import androidx.compose.ui.text.ExperimentalTextApi
import androidx.compose.ui.text.font.Font
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontVariation
import androidx.compose.ui.text.font.FontWeight
import com.oftenenough.app.R

/**
 * Google Sans Flex, the app's font (the user, 13 Oct 2026, chosen over Roboto side by side on the Welcome screen).
 *
 * - **Bundled, never downloaded:** Android's own font is Roboto, and Downloadable Fonts would show Roboto on the very
 *   first launch (the Welcome screen) until Play services fetched it. `res/font/google_sans_flex.ttf` is the variable
 *   font from Google Fonts (`ofl/googlesansflex`, SIL Open Font License, `assets/licenses/`), cut from 3.9 MB to 527 KB
 *   by pinning the axes we never change (width 100, roundness 0, slant 0) and keeping weight 300–700 and optical size
 *   8–144. All 541 characters are kept; anything else falls back to the system font as before.
 * - **Regular (400) and Medium (500) only.** The user: "don't use semi-bold unless I say." Hierarchy comes from size
 *   and these two weights, never from SemiBold or Bold.
 * - **Optical size follows the text size**, as Figma draws it ("Optical size: Auto"): a family per size, so 32 sp text
 *   uses opsz 32 and 14 sp text opsz 14. Pass the style's own font size.
 */
@OptIn(ExperimentalTextApi::class)
fun googleSansFlex(size: Int): FontFamily = families.getOrPut(size) {
    fun font(weight: FontWeight) = Font(
        R.font.google_sans_flex, weight,
        variationSettings = FontVariation.Settings(FontVariation.weight(weight.weight), FontVariation.Setting("opsz", size.toFloat())),
    )
    FontFamily(font(FontWeight.Normal), font(FontWeight.Medium))
}

private val families = HashMap<Int, FontFamily>()
