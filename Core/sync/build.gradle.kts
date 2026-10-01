plugins {
    kotlin("multiplatform")
}

// The pure sync rules (clock, ops, merge), shared by the apps and the server (Architecture/Shared Core Decision.md).
// No database, no network: those stay with each platform's adapter.
kotlin {
    jvm()
    js {
        // The Cloudflare Worker imports this as an ES module (server/core/).
        nodejs()
        binaries.library()
        useEsModules()
        generateTypeScriptDefinitions()
    }
    listOf(iosArm64(), iosSimulatorArm64())

    sourceSets {
        commonMain.dependencies {
            api("org.jetbrains.kotlinx:kotlinx-serialization-json:1.11.0")
        }
        commonTest.dependencies {
            implementation(kotlin("test"))
        }
    }
}
