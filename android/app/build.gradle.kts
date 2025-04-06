plugins {
    id("com.android.application")
    id("kotlin-android")
    // Flutter plugin must come after Android and Kotlin
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.my_app"
    compileSdk = 35 // ✅ Update to match plugin requirements

    ndkVersion = "27.0.12077973" // ✅ Explicitly defined

    defaultConfig {
        applicationId = "com.example.my_app"
        minSdk = 21
        targetSdk = 35 // ✅ Matching compileSdk version
        versionCode = 1
        versionName = "1.0"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            isShrinkResources = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}
