package app.habits.core

import androidx.room3.RoomDatabase
import kotlin.coroutines.CoroutineContext

internal expect fun databaseBuilder(path: String): RoomDatabase.Builder<HabitDatabase>

internal expect fun inMemoryDatabaseBuilder(): RoomDatabase.Builder<HabitDatabase>

/** Database work runs off the main thread. */
internal expect val databaseDispatcher: CoroutineContext

/** Wall-clock time in epoch milliseconds (the sync clock's physical part). */
internal expect fun currentTimeMillis(): Long
