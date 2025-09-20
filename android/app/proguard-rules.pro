#############################################
# Flutter & Dart
#############################################
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.embedding.engine.FlutterJNI { *; }
-keep class io.flutter.view.** { *; }
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**


# Keep native methods (Dart <-> JNI)
-keepclassmembers class * {
    native <methods>;
}

#############################################
# Kotlin & Coroutines
#############################################
-dontwarn kotlin.**
-keep class kotlin.** { *; }
-keepclassmembers class kotlin.** { *; }
-keepclassmembers class kotlinx.coroutines.** { *; }

#############################################
# Hive / Hydrated Bloc
#############################################
# Keep Hive model classes and generated adapters
-keep class com.vpx.quowally.** { *; }
-keep class * extends com.example.quowally.** { *; }
-keepclassmembers class ** extends TypeAdapter { *; }
-keepclassmembers class * {
    @HiveField <fields>;
}

#############################################
# WorkManager (background tasks)
#############################################
-dontwarn androidx.work.**
-keep class androidx.work.** { *; }
-keepclassmembers class * extends androidx.work.ListenableWorker { *; }

#############################################
# Wallpaper Plugin (local plugin)
#############################################
-keep class com.vpx.wallpaper_plugin.** { *; }

#############################################
# Common Plugins (url_launcher, share_plus, google_fonts, flutter_svg)
#############################################
-dontwarn io.flutter.plugins.**
-dontwarn androidx.annotation.**
-dontwarn org.jetbrains.annotations.**

#############################################
# Logging
#############################################
-dontwarn org.slf4j.**
-keep class org.slf4j.** { *; }
