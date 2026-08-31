# Flutter specific
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Keep Google Play Core classes (fixes the missing class errors)
-keep class com.google.android.play.core.** { *; }
-keep class com.google.android.play.core.splitcompat.** { *; }
-keep class com.google.android.play.core.splitinstall.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }

# Keep all classes that might be used by deferred components
-keep class * extends io.flutter.embedding.android.FlutterActivity { *; }
-keep class * extends io.flutter.embedding.android.FlutterFragmentActivity { *; }

# Keep native method names
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep your app models
-keep class com.taning.taning.** { *; }
-keepclassmembers class com.taning.taning.** { *; }

# Keep enum values
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Keep JSON serializable classes
-keep class * extends com.fasterxml.jackson.databind.** { *; }
-keep class * extends com.google.gson.** { *; }

# AndroidX / Material
-keep class androidx.** { *; }
-keep class com.google.android.material.** { *; }