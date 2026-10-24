package com.oftenenough.app.app

import android.content.ComponentName
import android.content.Context
import android.content.pm.PackageManager

/**
 * The launcher icon follows the app's own theme (the user, 24 Oct 2026): the light artwork while the app is light,
 * the dark artwork while it is dark. With Appearance on Follow system, that is the phone's theme; set to Light or
 * Dark, the icon follows the person's choice, not the phone's.
 *
 * Why it isn't a `-night` mipmap: a launcher reads an app's icon when the package changes and then caches it. It
 * does not read it again when the system's theme changes, so the `-night` artwork was only ever shown if the phone
 * happened to be dark at the moment the app was installed (measured on a moto g54, 24 Oct 2026: the icon stayed
 * light through a theme change, and only became dark on reinstall). So the two sets of artwork are two launcher
 * entries, `LightIcon` and `DarkIcon`, and exactly one is enabled; enabling the other is itself the package change
 * that makes the launcher read the icon again.
 *
 * [follow] does nothing unless the icon is actually wrong, so an ordinary launch never disturbs the launcher.
 */
object AppIcon {
    private const val LIGHT = "com.oftenenough.app.app.LightIcon"
    private const val DARK = "com.oftenenough.app.app.DarkIcon"

    /** Shows the artwork for [dark]. Call it whenever the app's theme settles; it is cheap when nothing changed. */
    fun follow(context: Context, dark: Boolean) {
        val pm = context.packageManager
        val pkg = context.packageName
        val wanted = ComponentName(pkg, if (dark) DARK else LIGHT)
        val other = ComponentName(pkg, if (dark) LIGHT else DARK)
        // The manifest enables LightIcon and disables DarkIcon, so an untouched component reads as DEFAULT.
        if (isOn(pm, wanted, defaultOn = !dark)) return
        // The wanted one goes on first: the app always has a launcher entry, never none for an instant.
        pm.setComponentEnabledSetting(wanted, PackageManager.COMPONENT_ENABLED_STATE_ENABLED, PackageManager.DONT_KILL_APP)
        pm.setComponentEnabledSetting(other, PackageManager.COMPONENT_ENABLED_STATE_DISABLED, PackageManager.DONT_KILL_APP)
    }

    private fun isOn(pm: PackageManager, component: ComponentName, defaultOn: Boolean): Boolean =
        when (pm.getComponentEnabledSetting(component)) {
            PackageManager.COMPONENT_ENABLED_STATE_ENABLED -> true
            PackageManager.COMPONENT_ENABLED_STATE_DISABLED -> false
            else -> defaultOn
        }
}
