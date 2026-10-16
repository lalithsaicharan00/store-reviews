plugins {
    kotlin("multiplatform")
}

// Android (Android/, Current Work 107): only when the Android app builds the core (`core.android`, set by
// Android/gradle.properties), so the iPhone's, the Watch's and the server's builds never need an Android SDK.
if ((providers.systemProperty("core.android").orNull ?: providers.gradleProperty("core.android").orNull) == "true") {
    apply(plugin = "com.android.kotlin.multiplatform.library")
    val targets = (kotlin as ExtensionAware).extensions
    (targets.findByName("android") ?: targets.getByName("androidLibrary")).withGroovyBuilder {
        "setNamespace"("app.habits.sync")
        "setCompileSdk"(37)
        "setMinSdk"(26)
    }
}

// The pure sync rules (clock, ops, merge), shared by the apps and the server (Architecture/Shared Core Decision.md).
// No database, no network: those stay with each platform's adapter.
kotlin {
    jvm()
    js {
        // An ES module for JavaScript (the retired server imported it; tag server-final-2026-10).
        nodejs()
        binaries.library()
        useEsModules()
        generateTypeScriptDefinitions()
    }
    listOf(iosArm64(), iosSimulatorArm64(), watchosArm64(), watchosDeviceArm64(), watchosSimulatorArm64())

    sourceSets {
        commonMain.dependencies {
            api("org.jetbrains.kotlinx:kotlinx-serialization-json:1.11.0")
        }
        commonTest.dependencies {
            implementation(kotlin("test"))
        }
    }
}
