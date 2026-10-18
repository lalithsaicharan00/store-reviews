# Room 3 (the core's database) keeps its generated constructor by reflection-free code; keep the entities' names stable.
-keep class app.habits.core.** { *; }
-keep class app.habits.rules.** { *; }
-keep class app.habits.sync.** { *; }
-keepclassmembers class * { @kotlinx.serialization.Serializable *; }
