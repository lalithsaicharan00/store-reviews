package app.habits.core

import androidx.room3.Room
import androidx.room3.RoomDatabase
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.IO
import kotlin.coroutines.CoroutineContext
import platform.Foundation.NSDate
import platform.Foundation.timeIntervalSince1970

internal actual fun databaseBuilder(path: String): RoomDatabase.Builder<HabitDatabase> =
    Room.databaseBuilder<HabitDatabase>(name = path)

internal actual fun inMemoryDatabaseBuilder(): RoomDatabase.Builder<HabitDatabase> =
    Room.inMemoryDatabaseBuilder<HabitDatabase>()

internal actual val databaseDispatcher: CoroutineContext = Dispatchers.IO

internal actual fun currentTimeMillis(): Long = (NSDate().timeIntervalSince1970 * 1000).toLong()
