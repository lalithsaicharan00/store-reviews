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
        // Sign in with Google (Plus & Account): the Web OAuth client ID the Worker checks ID tokens against. Public, not
        // a secret (Google puts it in every copy of the app), but kept out of the repository: on a PC it's
        // `googleWebClientId` in ~/.gradle/gradle.properties, on CI the repository variable GOOGLE_WEB_CLIENT_ID.
        // Empty, debug builds use the stand-in sign-in and a release build offers none.
        val webClientId = (project.findProperty("googleWebClientId") as String?) ?: System.getenv("GOOGLE_WEB_CLIENT_ID") ?: ""
        buildConfigField("String", "GOOGLE_WEB_CLIENT_ID", "\"" + webClientId + "\"")
        // Debug builds use the stand-in Plus store unless built with -PrealBilling (to test real purchases as a license tester).
        buildConfigField("boolean", "REAL_BILLING", (project.findProperty("realBilling") != null).toString())
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
    implementation("androidx.compose.material3:material3")
    implementation("androidx.compose.material:material-icons-extended")
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
    implementation("androidx.biometric:biometric:1.1.0")
    implementation("androidx.glance:glance-appwidget:1.2.0")
    implementation("androidx.glance:glance-material3:1.2.0")
    implementation("androidx.profileinstaller:profileinstaller:1.4.1")
    implementation("androidx.metrics:metrics-performance:1.0.0")
    implementation("com.android.billingclient:billing-ktx:9.1.0")
    // Plus & Account: Sign in with Google through Android's Credential Manager (Google's own account sheet), the family
    // invite's QR code (drawn on the phone, ZXing's encoder only) and Google's code scanner (no camera permission).
    implementation("androidx.credentials:credentials:1.5.0")
    implementation("androidx.credentials:credentials-play-services-auth:1.5.0")
    implementation("com.google.android.libraries.identity.googleid:googleid:1.1.1")
    implementation("com.google.zxing:core:3.5.3")
    // Material 3 Expressive's loading indicator, drawn with the library Material's own uses (LoadingIndicator.kt).
    implementation("androidx.graphics:graphics-shapes:1.1.0")
    implementation("com.google.android.gms:play-services-code-scanner:16.1.0")
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
