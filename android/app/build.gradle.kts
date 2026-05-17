plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    // Google Services plugin for Firebase
    id("com.google.gms.google-services")
}

android {
    namespace = "com.aozka.qrscannerapp"
    compileSdk = 36
    ndkVersion = "28.2.13676358"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.aozka.qrscannerapp"
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = 1
        versionName = "1.0"
    }

    // 👇 YENİ EKLENEN KISIM: İmzalama Ayarları
    signingConfigs {
        create("release") {
            // Codemagic environment değişkenlerini okur
            val keystorePath = System.getenv("CM_KEYSTORE_PATH")
            // Eğer Codemagic bu yolu verdiyse şifreleri de oradan al
            if (keystorePath != null) {
                storeFile = file(keystorePath)
                storePassword = System.getenv("CM_KEYSTORE_PASSWORD")
                keyAlias = System.getenv("CM_KEY_ALIAS")
                keyPassword = System.getenv("CM_KEY_PASSWORD")
            }
        }
    }

    buildTypes {
        release {
            // Enable code shrinking, obfuscation, and optimization
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            
            // 👇 GÜNCELLENEN KISIM: Doğru İmzayı Seçme Mantığı
            // Eğer Codemagic üzerindeysek (yani keystore yolu varsa) release imzasını kullan.
            // Yoksa (bilgisayarında test ediyorsan) debug imzasını kullan.
            if (System.getenv("CM_KEYSTORE_PATH") != null) {
                signingConfig = signingConfigs.getByName("release")
            } else {
                signingConfig = signingConfigs.getByName("debug")
            }
        }
    }
}

flutter {
    source = "../.."
}