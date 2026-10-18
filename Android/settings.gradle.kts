pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

dependencyResolutionManagement {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.name = "OftenEnough"
include(":app")

// The shared Kotlin core (../Core: storage, sync, backup files and the habit rules), built from source with its Android
// target (gradle.properties sets `core.android`). The app reaches the rules only through data/RulesGateway.kt.
includeBuild("../Core") {
    dependencySubstitution {
        substitute(module("app.habits:core")).using(project(":"))
    }
}
