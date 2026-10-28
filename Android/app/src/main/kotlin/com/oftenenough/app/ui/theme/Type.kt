package com.oftenenough.app.ui.theme

import androidx.compose.material3.Typography
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.LineHeightStyle
import androidx.compose.ui.unit.sp

/**
 * The app's text styles: one list, the Figma file's **Android / …** styles, which are **Material 3's own type scale
 * (names, sizes, line heights, weights) in Google Sans Flex** (Android A74, 28 Oct 2026; never rename, add or change one
 * without the user). Every screen refers to these and never makes a size of its own (the user, 15 Oct 2026:
 * "create the shared text styles … so that nothing stays inconsistent"). Written down in Android/README.md, "Text".
 *
 * - **Google Sans Flex, Regular and Medium only** (`Fonts.kt`); "Emphasized" is Medium, as in Material 3 Expressive.
 * - **Sizes and line heights are Material 3's** (57, 45, 36, 32, 28, 24, 22, 16, 14, 12, 11), with no size of our own
 *   (the 20 went on 28 Oct 2026, A74). Material's Bold Emphasized styles (Title Medium and Small, the labels) aren't used.
 *   Within one screen, neighbouring levels differ by at least 1.25×: skip steps rather than use neighbours together.
 * - **Everything is in sp, never dp or px**, so the phone's font size and display size change all text (Android 14+
 *   scales large text less than small, by itself, from sp). Never a fixed height around text: give rows and buttons a
 *   minimum height (`heightIn(min = …)`) so a larger font grows them instead of clipping.
 * - Letter spacing 0, and the text centred in each line as Figma draws it (nothing trimmed).
 *
 * Adding a size? Don't: pick the style for the job (the list under each name). If a design truly needs a new one, it's
 * added in Figma first, then here, with its job.
 */
object AppType {
    private val lines = LineHeightStyle(LineHeightStyle.Alignment.Center, LineHeightStyle.Trim.None)

    private fun style(size: Int, lineHeight: Int, medium: Boolean) = TextStyle(
        fontFamily = googleSansFlex(size), fontWeight = if (medium) FontWeight.Medium else FontWeight.Normal,
        fontSize = size.sp, lineHeight = lineHeight.sp, letterSpacing = 0.sp, lineHeightStyle = lines,
    )

    /** Clocks, the player's count. */
    val displayLarge = style(57, 64, false)
    val displayLargeEmphasized = style(57, 64, true)
    /** The one big figure on a screen (Progress's record); Emphasized for an amount being typed. */
    val displayMedium = style(45, 52, false)
    val displayMediumEmphasized = style(45, 52, true)
    val displaySmall = style(36, 44, false)
    val displaySmallEmphasized = style(36, 44, true)
    /** The routine player's habit name (Emphasized). */
    val headlineLarge = style(32, 40, false)
    val headlineLargeEmphasized = style(32, 40, true)
    /** A habit's large title, a screen's question or status, a hero's heading (Emphasized). */
    val headlineMedium = style(28, 36, false)
    val headlineMediumEmphasized = style(28, 36, true)
    /** Dialog and sheet headlines; tile figures (Emphasized); an empty state's title (Emphasized). */
    val headlineSmall = style(24, 32, false)
    val headlineSmallEmphasized = style(24, 32, true)
    /** Top app bar and sheet titles (Emphasized). */
    val titleLarge = style(22, 28, false)
    val titleLargeEmphasized = style(22, 28, true)
    /** List item and card names; a name over supporting text. */
    val titleMedium = style(16, 24, true)
    /** A small heading inside a dense card or sheet (same size and weight as Label Large, which is for actions). */
    val titleSmall = style(14, 20, true)
    /** Body text; a unit beside a figure. */
    val bodyLarge = style(16, 24, false)
    /** One line picked out of Body Large. */
    val bodyLargeEmphasized = style(16, 24, true)
    /** Supporting text under a name. */
    val bodyMedium = style(14, 20, false)
    val bodyMediumEmphasized = style(14, 20, true)
    /** Footers and notes under a group. */
    val bodySmall = style(12, 16, false)
    val bodySmallEmphasized = style(12, 16, true)
    /** Buttons, tabs, chips, section labels, menu items. */
    val labelLarge = style(14, 20, true)
    /** Badges. */
    val labelMedium = style(12, 16, true)
    /** Weekday letters, chart axes. */
    val labelSmall = style(11, 16, true)

    /** Material's own slots, so its components (buttons, dialogs, menus, snackbars, pickers) use the same styles. */
    val material = Typography(
        displayLarge = displayLarge, displayMedium = displayMedium, displaySmall = displaySmall,
        headlineLarge = headlineLarge, headlineMedium = headlineMedium, headlineSmall = headlineSmall,
        titleLarge = titleLarge, titleMedium = titleMedium, titleSmall = titleSmall,
        bodyLarge = bodyLarge, bodyMedium = bodyMedium, bodySmall = bodySmall,
        labelLarge = labelLarge, labelMedium = labelMedium, labelSmall = labelSmall,
    )
}
