plugins {
    kotlin("multiplatform") version "2.4.20"
    id("com.google.devtools.ksp") version "2.3.12"
    id("androidx.room3") version "3.0.3"
}

kotlin {
    compilerOptions { freeCompilerArgs.add("-Xexpect-actual-classes") }

    // Desktop JVM: runs the storage tests on the Mac, and later the Windows/Mac desktop builds.
    jvm()
    listOf(iosArm64(), iosSimulatorArm64()).forEach { target ->
        target.binaries.framework {
            baseName = "Core"
            isStatic = true
            export(project(":sync"))
        }
    }

    sourceSets {
        commonMain.dependencies {
            api(project(":sync"))
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
}
