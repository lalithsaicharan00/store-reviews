plugins {
    kotlin("multiplatform")
}

// The habit rules (Core/spec/): days, schedules, goals, streaks and progress, one copy for every platform. Pure: no
// database, no clock, no platform calls; the time zone and "now" are inputs. Proven against the iPhone's own answers by
// the golden cases (Core/fixtures/, GoldenTest).
kotlin {
    jvm()
    listOf(iosArm64(), iosSimulatorArm64(), watchosArm64(), watchosDeviceArm64(), watchosSimulatorArm64())

    sourceSets {
        commonMain.dependencies {
            api("org.jetbrains.kotlinx:kotlinx-datetime:0.7.1")
            implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:1.11.0")
        }
        commonTest.dependencies {
            implementation(kotlin("test"))
        }
    }
}

tasks.named<Test>("jvmTest") {
    maxHeapSize = "6g"
    systemProperty("fixtures", file("../fixtures").absolutePath)
    // The golden cases are the test's real inputs: without this, Gradle's build cache handed back an earlier run's
    // result after new answers were recorded (core-tests run 38216987015 took a minute and never read the extreme account).
    inputs.dir(file("../fixtures/expected")).withPropertyName("goldenAnswers").withPathSensitivity(PathSensitivity.RELATIVE)
    inputs.files(fileTree("../fixtures/inputs") { include("*.json") }).withPropertyName("goldenInputs").withPathSensitivity(PathSensitivity.RELATIVE)
    System.getProperty("golden.only")?.let { systemProperty("golden.only", it) }
    testLogging { showStandardStreams = true }
}
