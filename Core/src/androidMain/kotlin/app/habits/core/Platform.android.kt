package app.habits.core

import android.content.Context
import androidx.room3.Room
import androidx.room3.RoomDatabase
import kotlinx.coroutines.Dispatchers
import kotlin.coroutines.CoroutineContext

/** The Android app hands the core its application context before opening the database (Room needs it on Android). */
object AndroidCore {
    @Volatile lateinit var context: Context
}

internal actual fun databaseBuilder(path: String): RoomDatabase.Builder<HabitDatabase> =
    Room.databaseBuilder<HabitDatabase>(context = AndroidCore.context, name = path)

internal actual fun inMemoryDatabaseBuilder(): RoomDatabase.Builder<HabitDatabase> =
    Room.inMemoryDatabaseBuilder<HabitDatabase>(context = AndroidCore.context)

internal actual val databaseDispatcher: CoroutineContext = Dispatchers.IO

internal actual fun currentTimeMillis(): Long = System.currentTimeMillis()
