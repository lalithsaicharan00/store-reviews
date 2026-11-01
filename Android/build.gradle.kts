plugins {
    id("com.android.application") version "9.4.1" apply false
    id("com.android.test") version "9.4.1" apply false
    // AGP 9 compiles Kotlin itself; this pins the Kotlin version to the core's.
    id("org.jetbrains.kotlin.android") version "2.4.20" apply false
    id("org.jetbrains.kotlin.plugin.compose") version "2.4.20" apply false
    id("org.jetbrains.kotlin.plugin.serialization") version "2.4.20" apply false
    id("androidx.baselineprofile") version "1.5.0" apply false
    // Google's own Open source licenses screen, listing every library the app is built with (Settings flow 23).
    id("com.google.android.gms.oss-licenses-plugin") version "0.13.0" apply false
}
