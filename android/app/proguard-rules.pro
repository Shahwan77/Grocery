# Keep rules for Telr Payment Gateway
-keep class com.telr.** { *; }
-keepclassmembers class com.telr.** { *; }
-dontwarn com.telr.**

# Additional rules for other dependencies (if needed)
-keep class com.fasterxml.jackson.** { *; }
-keep class com.google.android.play.core.** { *; }
-dontwarn com.fasterxml.jackson.**
-dontwarn com.google.android.play.core.**