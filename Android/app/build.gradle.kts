plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.plugin.compose")
    id("org.jetbrains.kotlin.plugin.serialization")
}

android {
    namespace = "com.oftenenough.app"
    compileSdk = 37

    defaultConfig {
        applicationId = "com.oftenenough.app"
        // Android 8.0: adaptive icons and notification channels; about 98 % of active Android phones (Build Results).
        minSdk = 26
        targetSdk = 37
        versionCode = 4
        versionName = "1.0"
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        // Debug builds use the stand-in Plus store unless built with -PrealBilling (to test real purchases as a license tester).
        buildConfigField("boolean", "REAL_BILLING", (project.findProperty("realBilling") != null).toString())
        // `-PstandInDrive`: a debug build works against the stand-in Drive on the phone, for an emulator with no
        // Google Play. Every other build talks to the person's own Google Drive.
        buildConfigField("boolean", "STAND_IN_DRIVE", (project.findProperty("standInDrive") != null).toString())
    }

    // Debug builds on CI use a stable key kept only as GitHub secrets (D11), so the Google OAuth client can trust its
    // SHA-1; without the secrets (a local build) the SDK's own debug key is used. Release reads the upload key the same way.
    signingConfigs {
        val debugStore = System.getenv("ANDROID_DEBUG_KEYSTORE")
        if (debugStore != null && file(debugStore).exists()) {
            getByName("debug") {
                storeFile = file(debugStore)
                storePassword = System.getenv("ANDROID_DEBUG_KEYSTORE_PASSWORD")
                keyAlias = System.getenv("ANDROID_DEBUG_KEY_ALIAS") ?: "oftenenough-debug"
                keyPassword = System.getenv("ANDROID_DEBUG_KEYSTORE_PASSWORD")
            }
        }
        val uploadStore = System.getenv("ANDROID_UPLOAD_KEYSTORE")
        if (uploadStore != null && file(uploadStore).exists()) {
            create("upload") {
                storeFile = file(uploadStore)
                storePassword = System.getenv("ANDROID_UPLOAD_KEYSTORE_PASSWORD")
                keyAlias = System.getenv("ANDROID_UPLOAD_KEY_ALIAS") ?: "upload"
                keyPassword = System.getenv("ANDROID_UPLOAD_KEY_PASSWORD") ?: System.getenv("ANDROID_UPLOAD_KEYSTORE_PASSWORD")
            }
        }
    }

    // No server of ours (22 Oct 2026): Plus comes from Google Play and the habits from the person's own Google Drive.
    buildTypes {
        release {
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
            signingConfigs.findByName("upload")?.let { signingConfig = it }
        }
    }

    buildFeatures {
        compose = true
        buildConfig = true
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    testOptions {
        unitTests.isReturnDefaultValues = true
    }

    packaging {
        resources.excludes += setOf("/META-INF/{AL2.0,LGPL2.1}", "/META-INF/versions/9/previous-compilation-data.bin")
    }
}

dependencies {
    implementation("app.habits:core:local")

    val composeBom = platform("androidx.compose:compose-bom:2026.09.00")
    implementation(composeBom)
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.ui:ui-graphics")
    implementation("androidx.compose.ui:ui-tooling-preview")
    implementation("androidx.compose.foundation:foundation")
    // Material 3 Expressive (Android A76): 1.5 has its components, 1.4 has none. Back to the BOM's version once 1.5 is stable.
    implementation("androidx.compose.material3:material3:1.5.0-beta02")
    implementation("androidx.graphics:graphics-shapes:1.1.0")
    implementation("androidx.activity:activity-compose:1.13.0")
    implementation("androidx.navigation:navigation-compose:2.10.2")
    implementation("androidx.lifecycle:lifecycle-viewmodel-compose:2.11.0")
    implementation("androidx.lifecycle:lifecycle-runtime-compose:2.11.0")
    implementation("androidx.lifecycle:lifecycle-process:2.11.0")
    implementation("androidx.core:core-ktx:1.19.1")
    implementation("androidx.core:core-splashscreen:1.2.0")
    implementation("androidx.appcompat:appcompat:1.8.0")
    implementation("androidx.work:work-runtime-ktx:2.12.0")
    implementation("androidx.glance:glance-appwidget:1.2.0")
    implementation("androidx.glance:glance-material3:1.2.0")
    implementation("androidx.profileinstaller:profileinstaller:1.4.1")
    implementation("androidx.metrics:metrics-performance:1.0.0")
    implementation("com.android.billingclient:billing-ktx:9.1.0")
    // Google Drive's permission screen and its drive.appdata token (A4, A39). No sign-in and no client ID in the
    // app: Play Services matches the package name and signing certificate to our Android OAuth client.
    implementation("com.google.android.gms:play-services-auth:21.4.0")
    // Material 3 Expressive's loading indicator, drawn with the library Material's own uses (LoadingIndicator.kt).
    implementation("androidx.graphics:graphics-shapes:1.1.0")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.11.0")
    implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:1.11.0")
    debugImplementation("androidx.compose.ui:ui-tooling")
    debugImplementation("androidx.compose.ui:ui-test-manifest")

    testImplementation("junit:junit:4.13.2")
    // The real org.json for JVM tests (Android's own is a stub there): the account file is JSON.
    testImplementation("org.json:json:20240303")
    testImplementation("org.jetbrains.kotlinx:kotlinx-coroutines-test:1.11.0")

    androidTestImplementation(composeBom)
    androidTestImplementation("androidx.compose.ui:ui-test-junit4")
    androidTestImplementation("androidx.test.ext:junit:1.3.0")
    androidTestImplementation("androidx.test:runner:1.7.0")
    androidTestImplementation("androidx.test:rules:1.7.0")
    // Compose's test rule brings an older Espresso that calls InputManager.getInstance, gone in Android 16 (API 36):
    // every test failed before its first tap on a Pixel 10 emulator.
    androidTestImplementation("androidx.test.espresso:espresso-core:3.7.0")
    androidTestImplementation("androidx.test.uiautomator:uiautomator:2.4.0")
    androidTestImplementation("org.jetbrains.kotlinx:kotlinx-coroutines-test:1.11.0")
}
