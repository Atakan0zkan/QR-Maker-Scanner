# Flutter ProGuard Rules for QR Scanner App

# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Firebase
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# Google Mobile Ads (AdMob)
-keep class com.google.android.gms.ads.** { *; }
-dontwarn com.google.android.gms.ads.**

# Hive Database
-keep class * extends hive.HiveObject
-keep class * implements hive.HiveObject
-keepclassmembers class * extends hive.HiveObject {
    <fields>;
}

# Mobile Scanner (QR Scanner)
-keep class com.google.mlkit.** { *; }
-dontwarn com.google.mlkit.**

# Gson (for JSON serialization)
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**
-keep class com.google.gson.** { *; }

# Your app models (Hive generated classes)
-keep class com.qrscanner.qr_scanner_app.models.** { *; }

# Kotlin
-keep class kotlin.** { *; }
-keep class kotlinx.** { *; }
-dontwarn kotlin.**
-dontwarn kotlinx.**

# Reflection
-keepattributes *Annotation*,InnerClasses
-keepattributes Signature,Exception
-keepattributes SourceFile,LineNumberTable

# For crash reporting
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception

# Play Core & Play Store (Fix R8 missing classes)
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.splitcompat.** { *; }
-keep class com.google.android.play.core.splitinstall.** { *; }

# Play Store deferred components
-dontwarn com.google.android.play.core.splitinstall.PlayStoreDeferredComponentManager
-dontwarn com.google.android.play.core.appupdate.**

# Remove logging (production)
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** v(...);
    public static *** i(...);
}
