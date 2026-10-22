plugins {
    kotlin("multiplatform") version "2.4.20"
    id("com.google.devtools.ksp") version "2.3.12"
    id("androidx.room3") version "3.0.3"
    id("com.android.kotlin.multiplatform.library") version "9.4.1" apply false
}

// Android (Android/, Current Work 107): only when the Android app builds the core (`core.android`, set by
// Android/gradle.properties), so the iPhone's and the server's builds never need an Android SDK.
val withAndroid = (providers.systemProperty("core.android").orNull ?: providers.gradleProperty("core.android").orNull) == "true"
if (withAndroid) {
    apply(plugin = "com.android.kotlin.multiplatform.library")
    val targets = (kotlin as ExtensionAware).extensions
    (targets.findByName("android") ?: targets.getByName("androidLibrary")).withGroovyBuilder {
        "setNamespace"("app.habits.core")
        "setCompileSdk"(37)
        "setMinSdk"(26)
    }
}

kotlin {
    compilerOptions { freeCompilerArgs.add("-Xexpect-actual-classes") }

    // Desktop JVM: runs the storage tests on the Mac, and later the Windows/Mac desktop builds.
    jvm()
    // The iPhone and its simulator (the app is iPhone-only: the Apple Watch app was removed 21 Oct 2026).
    listOf(iosArm64(), iosSimulatorArm64()).forEach { target ->
        target.binaries.framework {
            baseName = "Core"
            isStatic = true
            export(project(":sync"))
            export(project(":rules"))
        }
    }

    sourceSets {
        commonMain.dependencies {
            api(project(":sync"))
            api(project(":rules"))
            implementation("androidx.room3:room3-runtime:3.0.3")
            implementation("androidx.sqlite:sqlite-bundled:2.7.1")
            implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.11.0")
        }
        commonTest.dependencies {
            implementation(kotlin("test"))
            implementation("org.jetbrains.kotlinx:kotlinx-coroutines-test:1.11.0")
        }
    }
}

room3 {
    // The schema of every shipped version is kept, so migrations can be tested against it.
    schemaDirectory("$projectDir/schemas")
}

dependencies {
    listOf("kspJvm", "kspIosArm64", "kspIosSimulatorArm64").forEach {
        add(it, "androidx.room3:room3-compiler:3.0.3")
    }
    if (withAndroid) add("kspAndroid", "androidx.room3:room3-compiler:3.0.3")
}

// The real-Google-Drive checks (.github/workflows/drive-real.yml) run test code as plain JVM processes, several at once
// (two "devices" are two processes): this writes the classpath they need.
tasks.register("writeJvmTestClasspath") {
    dependsOn("jvmTestClasses")
    val compilation = kotlin.jvm().compilations.getByName("test")
    val files = compilation.output.allOutputs + compilation.runtimeDependencyFiles!!
    val out = layout.buildDirectory.file("jvmTestClasspath.txt")
    inputs.files(files)
    outputs.file(out)
    doLast { out.get().asFile.writeText(files.joinToString(File.pathSeparator) { it.path }) }
}
