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
 * The app's colours (Android/Docs/Designs/README.md, "The design language"): the chrome is monochrome and colour belongs
 * to the habits (U2); no wallpaper colours (A11 D5). Light is the designs' own; dark is Material 3's dark roles with the
 * same structure, its colours from the old dark design (the user, 13 Oct 2026).
 */
@Immutable
data class AppColors(
    val dark: Boolean,
    /** The screen behind the cards. */
    val screen: Color,
    /** Cards and segmented rows. */
    val surface: Color,
    /** Text and filled buttons (black in light, near-white in dark). */
    val ink: Color,
    /** Text on [ink]. */
    val onInk: Color,
    val secondary: Color,
    /** Tonal buttons and chips. */
    val tonal: Color,
    /** A lighter tonal, for fields and the selected menu row. */
    val tonal2: Color,
    val outline: Color,
    /** Only for destructive words, never progress or habits (U3). */
    val error: Color,
    val scrim: Color,
    /** The streak flame. */
    val flame: Color,
) {
    /** A habit's own colour, as the iPhone's system colours, light or dark. */
    fun habit(c: HabitColor): Color = if (dark) habitDark.getValue(c) else habitLight.getValue(c)

    /** The progress fill behind a row: a light tint of the habit's colour on the card. */
    fun fill(c: HabitColor): Color = habit(c).copy(alpha = if (dark) 0.34f else 0.18f).compositeOver(surface)

    companion object {
        val light = AppColors(
            dark = false, screen = Color(0xFFF0F0F3), surface = Color.White, ink = Color(0xFF1C1B1F), onInk = Color.White,
            secondary = Color(0xFF5E5E62), tonal = Color(0xFFE6E6EA), tonal2 = Color(0xFFECECEF), outline = Color(0xFF79747E),
            error = Color(0xFFB3261E), scrim = Color(0x52000000), flame = Color(0xFFF57C00),
        )
        val dark = AppColors(
            dark = true, screen = Color(0xFF0F0F10), surface = Color(0xFF1E1E20), ink = Color(0xFFF2F2F5), onInk = Color(0xFF1C1B1F),
            secondary = Color(0xFFA3A3A8), tonal = Color(0xFF303033), tonal2 = Color(0xFF29292C), outline = Color(0xFF938F99),
            error = Color(0xFFF2B8B5), scrim = Color(0x99000000), flame = Color(0xFFFF9F0A),
        )

        private val habitLight = mapOf(
            HabitColor.RED to Color(0xFFFF3B30), HabitColor.ORANGE to Color(0xFFFF9500), HabitColor.YELLOW to Color(0xFFFFCC00),
            HabitColor.GREEN to Color(0xFF34C759), HabitColor.MINT to Color(0xFF00C7BE), HabitColor.TEAL to Color(0xFF30B0C7),
            HabitColor.CYAN to Color(0xFF32ADE6), HabitColor.BLUE to Color(0xFF007AFF), HabitColor.INDIGO to Color(0xFF5856D6),
            HabitColor.PURPLE to Color(0xFFAF52DE), HabitColor.PINK to Color(0xFFFF2D55), HabitColor.BROWN to Color(0xFFA2845E),
            HabitColor.GRAY to Color(0xFF8E8E93),
        )
        private val habitDark = mapOf(
            HabitColor.RED to Color(0xFFFF453A), HabitColor.ORANGE to Color(0xFFFF9F0A), HabitColor.YELLOW to Color(0xFFFFD60A),
            HabitColor.GREEN to Color(0xFF30D158), HabitColor.MINT to Color(0xFF63E6E2), HabitColor.TEAL to Color(0xFF40C8E0),
            HabitColor.CYAN to Color(0xFF64D2FF), HabitColor.BLUE to Color(0xFF0A84FF), HabitColor.INDIGO to Color(0xFF5E5CE6),
            HabitColor.PURPLE to Color(0xFFBF5AF2), HabitColor.PINK to Color(0xFFFF375F), HabitColor.BROWN to Color(0xFFAC8E68),
            HabitColor.GRAY to Color(0xFF8E8E93),
        )
    }
}

val LocalAppColors = staticCompositionLocalOf { AppColors.light }

/** Shortcut for the app's colours in a composable. */
val appColors: AppColors @Composable get() = LocalAppColors.current

private fun scheme(c: AppColors): ColorScheme {
    val base = if (c.dark) darkColorScheme() else lightColorScheme()
    return base.copy(
        primary = c.ink, onPrimary = c.onInk, primaryContainer = c.tonal, onPrimaryContainer = c.ink,
        secondary = c.ink, onSecondary = c.onInk, secondaryContainer = c.tonal, onSecondaryContainer = c.ink,
        tertiary = c.ink, onTertiary = c.onInk, tertiaryContainer = c.tonal, onTertiaryContainer = c.ink,
        background = c.screen, onBackground = c.ink, surface = c.surface, onSurface = c.ink,
        surfaceVariant = c.tonal, onSurfaceVariant = c.secondary, surfaceTint = Color.Transparent,
        surfaceContainerLowest = c.surface, surfaceContainerLow = c.surface, surfaceContainer = c.surface,
        surfaceContainerHigh = c.surface, surfaceContainerHighest = c.tonal, surfaceBright = c.surface, surfaceDim = c.screen,
        inverseSurface = if (c.dark) Color(0xFFE6E1E5) else Color(0xFF313033), inverseOnSurface = if (c.dark) Color(0xFF313033) else Color(0xFFF4EFF4),
        inversePrimary = c.onInk, outline = c.outline, outlineVariant = c.tonal, error = c.error,
        onError = if (c.dark) Color(0xFF601410) else Color.White, scrim = Color.Black,
    )
}

/** Google Sans Flex in the Figma file's styles, everywhere (`Type.kt`; the user, 15 Oct 2026: no Roboto left). */
private val typography = AppType.material

/** "light", "dark" or "system" (Appearance → Theme). */
@Composable
fun OftenEnoughTheme(theme: String = "system", content: @Composable () -> Unit) {
    val dark = when (theme) { "light" -> false; "dark" -> true; else -> isSystemInDarkTheme() }
    val colors = if (dark) AppColors.dark else AppColors.light
    CompositionLocalProvider(LocalAppColors provides colors) {
        MaterialTheme(colorScheme = scheme(colors), typography = typography, content = content)
    }
}
