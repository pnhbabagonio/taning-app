# Flutter specific
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Firebase
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Keep our models
-keep class com.taning.app.** { *; }
-keepclassmembers class com.taning.app.** { *; }

# Drift
-keep class * extends androidx.room.** { *; }
-keep class * extends io.flutter.plugin.common.** { *; }