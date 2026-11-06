// Generates the app's Baseline Profile: the code people run most, compiled ahead of time when the app is installed
// (Android A114). Run on an emulator only, never the person's phone: the task uninstalls the app and its data.
//   ./gradlew :app:generateReleaseBaselineProfile
plugins {
    id("com.android.test")
    id("androidx.baselineprofile")
}

android {
    namespace = "com.oftenenough.baselineprofile"
    compileSdk = 37

    defaultConfig {
        minSdk = 28
        targetSdk = 37
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    targetProjectPath = ":app"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
}

baselineProfile {
    useConnectedDevices = true
}

dependencies {
    implementation("androidx.test.ext:junit:1.3.0")
    implementation("androidx.test:runner:1.7.0")
    implementation("androidx.test.uiautomator:uiautomator:2.4.0")
    implementation("androidx.benchmark:benchmark-macro-junit4:1.5.0")
}
