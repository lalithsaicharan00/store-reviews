package com.oftenenough.app.ui.theme

import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.ColorScheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.runtime.Immutable
import androidx.compose.runtime.staticCompositionLocalOf
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.compositeOver
import com.oftenenough.app.data.HabitColor

/**
 * The app's colours. **The source is Material's colour scheme, [lightScheme] and [darkScheme]: Android's own colour
 * roles with our own values** (Android A75, 28 Oct 2026; the Figma file's "Android / Light / System / …" styles, one to
 * one). The chrome is monochrome and colour belongs to the habits (U2); no wallpaper colours (A11 D5). Dark has no Figma
 * design yet: it keeps the old dark design's colours (the user, 13 Oct 2026) under the same roles.
 *
 * The names below (`ink`, `tonal`, …) are older shortcuts that screens still read; each now points at one role. New code
 * reads `MaterialTheme.colorScheme` instead, and the shortcuts go as the screens move onto the components
 * (Android/Docs/Components — Atoms Build Plan.md).
 */
@Immutable
data class AppColors(
    val dark: Boolean,
    /** The page behind the cards: Surface container. */
    val screen: Color,
    /** Cards and segmented rows: Surface container lowest. */
    val surface: Color,
    /** Text: On surface. (A filled button is Primary, `MaterialTheme.colorScheme.primary`.) */
    val ink: Color,
    /** On primary. */
    val onInk: Color,
    /** Secondary text and icons: On surface variant. */
    val secondary: Color,
    /** Tonal buttons: Secondary container. */
    val tonal: Color,
    /** A text field, a pressed row: Surface container high. */
    val tonal2: Color,
    val outline: Color,
    /** Only for destructive words, never progress or habits (U3). */
    val error: Color,
    val scrim: Color,
    /** Badges, chips, a row's round button: Surface container highest. */
    val soft: Color,
    /** What a swipe uncovers, a notice's icon disc: Surface container highest. */
    val behind: Color,
    /** Hairlines and the outline of Undo · Note: Outline variant. */
    val line: Color,
    /** A menu's surface: Surface container low. */
    val menu: Color,
) {
    /** A habit's own colour, as the iPhone's system colours, light or dark. */
    fun habit(c: HabitColor): Color = if (dark) habitDark.getValue(c) else habitLight.getValue(c)

    /**
     * A habit's Fill (Figma's "Habit / <colour> / Fill"): the pale tone of its colour, for a wavy bar's track (1.20).
     * Figma draws light only; in dark it's the colour at 24 % on the card.
     */
    fun habitFill(c: HabitColor): Color = if (dark) habit(c).copy(alpha = 0.24f).compositeOver(surface) else habitFillLight.getValue(c)

    /**
     * A habit's Band (Figma's "Habit / <colour> / Band"): the track of its milestone ring (1.21). Light only in Figma; in
     * dark it's the colour at 28 % on the card.
     */
    fun habitBand(c: HabitColor): Color = if (dark) habit(c).copy(alpha = 0.28f).compositeOver(surface) else habitBandLight.getValue(c)

    /**
     * A habit's Pale (Figma's "Habit / <colour> / Pale", tone 75): the light end of its medal's gradient, and an earlier
     * run's bar on the Streaks page (4.5). Light only in Figma; in dark it's the colour at 60 % on the card.
     */
    fun habitPale(c: HabitColor): Color = if (dark) habit(c).copy(alpha = 0.6f).compositeOver(surface) else habitPaleLight.getValue(c)

    /**
     * A habit's Strong (Figma's "Habit / <colour> / Strong", tone 48): the deep end of its medal's gradient, and the
     * surface that carries white content (the milestone bar's end, its See label). The same in dark: Figma draws light
     * only, and the habit colours are the same in both modes.
     */
    fun habitStrong(c: HabitColor): Color = habitStrongLight.getValue(c)

    /**
     * A habit's Deep (tone 30): the start of Figma's "Habit / <colour> / Bar", the milestone bar's gradient from Deep to
     * Strong. The same in dark, as Strong.
     */
    fun habitDeep(c: HabitColor): Color = habitDeepLight.getValue(c)

    /** The progress fill behind a row: a light tint of the habit's colour on the card (Figma: 16 %, 18 % once full). */
    fun fill(c: HabitColor, full: Boolean = true): Color =
        habit(c).copy(alpha = if (dark) (if (full) 0.28f else 0.24f) else (if (full) 0.18f else 0.16f)).compositeOver(surface)


    companion object {
        /** Each shortcut is one role of [lightScheme] / [darkScheme] (A75); the comment names it. */
        private fun from(s: ColorScheme, dark: Boolean) = AppColors(
            dark = dark,
            screen = s.surfaceContainer, // the page behind the cards
            surface = s.surfaceContainerLowest, // cards and list items on the page
            ink = s.onSurface,
            onInk = s.onPrimary,
            secondary = s.onSurfaceVariant,
            tonal = s.secondaryContainer,
            tonal2 = s.surfaceContainerHigh, // a text field, a pressed row
            outline = s.outline,
            error = s.error,
            scrim = s.scrim.copy(alpha = 0.32f),
            soft = s.surfaceContainerHighest, // badges, chips, a row's round button
            behind = s.surfaceContainerHighest,
            line = s.outlineVariant,
            menu = s.surfaceContainerLow,
        )
        val light = from(lightScheme, dark = false)
        val dark = from(darkScheme, dark = true)
        /** Every role, light and dark, for what can't read `MaterialTheme` (the home-screen widgets). */
        val lightRoles: ColorScheme get() = lightScheme
        val darkRoles: ColorScheme get() = darkScheme

        /**
         * The 13 habit colours as Figma's colour sheet draws them (2.1.2, Google's palette; the user, 18 Oct 2026: match
         * the designs closely). Dark keeps the same colours: they're mid tones that carry a white glyph on either
         * background; only the row fills grow stronger (see [fill]).
         */
        private val habitLight = mapOf(
            HabitColor.RED to Color(0xFFEA4335), HabitColor.ORANGE to Color(0xFFFA7B17), HabitColor.YELLOW to Color(0xFFF9AB00),
            HabitColor.GREEN to Color(0xFF34A853), HabitColor.MINT to Color(0xFF00A39A), HabitColor.TEAL to Color(0xFF12B5CB),
            HabitColor.CYAN to Color(0xFF24C1E0), HabitColor.BLUE to Color(0xFF4285F4), HabitColor.INDIGO to Color(0xFF5C6BC0),
            HabitColor.PURPLE to Color(0xFFA142F4), HabitColor.PINK to Color(0xFFE52592), HabitColor.BROWN to Color(0xFFA1887F),
            HabitColor.GRAY to Color(0xFF80868B),
        )
        private val habitDark = habitLight
        private val habitBandLight = mapOf(
            HabitColor.RED to Color(0xFFF6CAC4), HabitColor.ORANGE to Color(0xFFF4CCB7), HabitColor.YELLOW to Color(0xFFEBD0AE),
            HabitColor.GREEN to Color(0xFFC6DAC3), HabitColor.MINT to Color(0xFFBEDAD6), HabitColor.TEAL to Color(0xFFBFD9DF),
            HabitColor.CYAN to Color(0xFFC0D9E0), HabitColor.BLUE to Color(0xFFCDD4EA), HabitColor.INDIGO to Color(0xFFD1D3EB),
            HabitColor.PURPLE to Color(0xFFDFCFE8), HabitColor.PINK to Color(0xFFF0CBD7), HabitColor.BROWN to Color(0xFFEBCEC4),
            HabitColor.GRAY to Color(0xFFCFD5DA),
        )
        private val habitPaleLight = mapOf(
            HabitColor.RED to Color(0xFFFF9F92), HabitColor.ORANGE to Color(0xFFFFA269), HabitColor.YELLOW to Color(0xFFF7A900),
            HabitColor.GREEN to Color(0xFF5ECF75), HabitColor.MINT to Color(0xFF4DCBC1), HabitColor.TEAL to Color(0xFF3CC9E0),
            HabitColor.CYAN to Color(0xFF34C9E8), HabitColor.BLUE to Color(0xFF97B8FF), HabitColor.INDIGO to Color(0xFFA8B4FF),
            HabitColor.PURPLE to Color(0xFFD5A5FF), HabitColor.PINK to Color(0xFFFF9AC4), HabitColor.BROWN to Color(0xFFCFB3A9),
            HabitColor.GRAY to Color(0xFFB4B9BF),
        )
        private val habitStrongLight = mapOf(
            HabitColor.RED to Color(0xFFD53428), HabitColor.ORANGE to Color(0xFFB85600), HabitColor.YELLOW to Color(0xFF9A6800),
            HabitColor.GREEN to Color(0xFF008437), HabitColor.MINT to Color(0xFF008079), HabitColor.TEAL to Color(0xFF007E8E),
            HabitColor.CYAN to Color(0xFF007D93), HabitColor.BLUE to Color(0xFF226FDC), HabitColor.INDIGO to Color(0xFF5D6CC1),
            HabitColor.PURPLE to Color(0xFF9D3DF0), HabitColor.PINK to Color(0xFFD81488), HabitColor.BROWN to Color(0xFF846D65),
            HabitColor.GRAY to Color(0xFF6D7378),
        )
        private val habitDeepLight = mapOf(
            HabitColor.RED to Color(0xFF930004), HabitColor.ORANGE to Color(0xFF753400), HabitColor.YELLOW to Color(0xFF614000),
            HabitColor.GREEN to Color(0xFF005320), HabitColor.MINT to Color(0xFF00504B), HabitColor.TEAL to Color(0xFF004E59),
            HabitColor.CYAN to Color(0xFF004E5C), HabitColor.BLUE to Color(0xFF004494), HabitColor.INDIGO to Color(0xFF2F3F92),
            HabitColor.PURPLE to Color(0xFF6A00B2), HabitColor.PINK to Color(0xFF8C0056), HabitColor.BROWN to Color(0xFF56423B),
            HabitColor.GRAY to Color(0xFF41484C),
        )
        private val habitFillLight = mapOf(
            HabitColor.RED to Color(0xFFFBE3DF), HabitColor.ORANGE to Color(0xFFF9E4D9), HabitColor.YELLOW to Color(0xFFFFEFDA),
            HabitColor.GREEN to Color(0xFFDDEEDF), HabitColor.MINT to Color(0xFFD6EFEC), HabitColor.TEAL to Color(0xFFD5EEF3),
            HabitColor.CYAN to Color(0xFFD6EEF4), HabitColor.BLUE to Color(0xFFDFEAFB), HabitColor.INDIGO to Color(0xFFE3E8FC),
            HabitColor.PURPLE to Color(0xFFECE5F8), HabitColor.PINK to Color(0xFFF8E2EA), HabitColor.BROWN to Color(0xFFDAD0CD),
            HabitColor.GRAY to Color(0xFFCCCED1),
        )
    }
}

val LocalAppColors = staticCompositionLocalOf { AppColors.light }

/** Shortcut for the app's colours in a composable. */
val appColors: AppColors @Composable get() = LocalAppColors.current

/**
 * Light: the Figma file's 32 "Android / Light / System / …" colour styles (A75), value for value. Tertiary equals Primary
 * (no third accent); Background, On background and Surface variant (older roles Material replaced with the surface roles)
 * follow the page, its ink and Surface container highest; no tonal tint; the Fixed roles are neutral greys, unused.
 */
private val lightScheme = lightColorScheme(
    primary = Color(0xFF303030), onPrimary = Color(0xFFF9F9F9),
    primaryContainer = Color(0xFFE2E2E2), onPrimaryContainer = Color(0xFF1B1B1B), inversePrimary = Color(0xFFC6C6C6),
    secondary = Color(0xFF5E5E5E), onSecondary = Color(0xFFF9F9F9),
    secondaryContainer = Color(0xFFE2E2E2), onSecondaryContainer = Color(0xFF1B1B1B),
    tertiary = Color(0xFF303030), onTertiary = Color(0xFFF9F9F9),
    tertiaryContainer = Color(0xFFE2E2E2), onTertiaryContainer = Color(0xFF1B1B1B),
    error = Color(0xFFB3261E), onError = Color(0xFFFFFBF9),
    errorContainer = Color(0xFFF9DEDC), onErrorContainer = Color(0xFF410E0B),
    surface = Color(0xFFF9F9F9), onSurface = Color(0xFF1B1B1B), onSurfaceVariant = Color(0xFF474747),
    surfaceDim = Color(0xFFDADADA), surfaceBright = Color(0xFFF9F9F9),
    surfaceContainerLowest = Color(0xFFFFFFFF), surfaceContainerLow = Color(0xFFF3F3F3),
    surfaceContainer = Color(0xFFEEEEEE), surfaceContainerHigh = Color(0xFFE8E8E8),
    surfaceContainerHighest = Color(0xFFE2E2E2),
    inverseSurface = Color(0xFF303030), inverseOnSurface = Color(0xFFF1F1F1),
    outline = Color(0xFF777777), outlineVariant = Color(0xFFC6C6C6), scrim = Color.Black,
    background = Color(0xFFEEEEEE), onBackground = Color(0xFF1B1B1B), surfaceVariant = Color(0xFFE2E2E2),
    surfaceTint = Color.Transparent,
).copy(
    primaryFixed = Color(0xFFE2E2E2), primaryFixedDim = Color(0xFFC6C6C6),
    onPrimaryFixed = Color(0xFF1B1B1B), onPrimaryFixedVariant = Color(0xFF474747),
    secondaryFixed = Color(0xFFE2E2E2), secondaryFixedDim = Color(0xFFC6C6C6),
    onSecondaryFixed = Color(0xFF1B1B1B), onSecondaryFixedVariant = Color(0xFF474747),
    tertiaryFixed = Color(0xFFE2E2E2), tertiaryFixedDim = Color(0xFFC6C6C6),
    onTertiaryFixed = Color(0xFF1B1B1B), onTertiaryFixedVariant = Color(0xFF474747),
)

/**
 * Dark: no Figma design yet, so the old dark design's colours (13 Oct 2026) under the same roles. Cards stay lighter
 * than the page, as in light, so Surface container lowest is the card here too.
 */
private val darkScheme = darkColorScheme(
    primary = Color(0xFFF2F2F5), onPrimary = Color(0xFF1C1B1F),
    primaryContainer = Color(0xFF303033), onPrimaryContainer = Color(0xFFF2F2F5), inversePrimary = Color(0xFF474747),
    secondary = Color(0xFFC6C6C6), onSecondary = Color(0xFF303030),
    secondaryContainer = Color(0xFF303033), onSecondaryContainer = Color(0xFFF2F2F5),
    tertiary = Color(0xFFF2F2F5), onTertiary = Color(0xFF1C1B1F),
    tertiaryContainer = Color(0xFF303033), onTertiaryContainer = Color(0xFFF2F2F5),
    error = Color(0xFFF2B8B5), onError = Color(0xFF601410),
    errorContainer = Color(0xFF8C1D18), onErrorContainer = Color(0xFFF9DEDC),
    surface = Color(0xFF1E1E20), onSurface = Color(0xFFF2F2F5), onSurfaceVariant = Color(0xFFA3A3A8),
    surfaceDim = Color(0xFF0F0F10), surfaceBright = Color(0xFF2A2A2D),
    surfaceContainerLowest = Color(0xFF1E1E20), surfaceContainerLow = Color(0xFF2A2A2D),
    surfaceContainer = Color(0xFF0F0F10), surfaceContainerHigh = Color(0xFF29292C),
    surfaceContainerHighest = Color(0xFF303033),
    inverseSurface = Color(0xFFE6E1E5), inverseOnSurface = Color(0xFF313033),
    outline = Color(0xFF938F99), outlineVariant = Color(0xFF4A484E), scrim = Color.Black,
    background = Color(0xFF0F0F10), onBackground = Color(0xFFF2F2F5), surfaceVariant = Color(0xFF303033),
    surfaceTint = Color.Transparent,
).copy(
    primaryFixed = Color(0xFF303033), primaryFixedDim = Color(0xFF474747),
    onPrimaryFixed = Color(0xFFF2F2F5), onPrimaryFixedVariant = Color(0xFFA3A3A8),
    secondaryFixed = Color(0xFF303033), secondaryFixedDim = Color(0xFF474747),
    onSecondaryFixed = Color(0xFFF2F2F5), onSecondaryFixedVariant = Color(0xFFA3A3A8),
    tertiaryFixed = Color(0xFF303033), tertiaryFixedDim = Color(0xFF474747),
    onTertiaryFixed = Color(0xFFF2F2F5), onTertiaryFixedVariant = Color(0xFFA3A3A8),
)

/** Google Sans Flex in the Figma file's styles, everywhere (`Type.kt`; the user, 15 Oct 2026: no Roboto left). */
private val typography = AppType.material

/** "light", "dark" or "system" (Appearance → Theme). */
@Composable
fun OftenEnoughTheme(theme: String = "system", content: @Composable () -> Unit) {
    val dark = when (theme) { "light" -> false; "dark" -> true; else -> isSystemInDarkTheme() }
    val colors = if (dark) AppColors.dark else AppColors.light
    CompositionLocalProvider(LocalAppColors provides colors) {
        MaterialTheme(colorScheme = if (dark) darkScheme else lightScheme, typography = typography, content = content)
    }
}
