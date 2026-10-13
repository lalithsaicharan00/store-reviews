package com.oftenenough.app.app.widgets

import android.content.Context
import com.oftenenough.app.data.widgets.WidgetItem
import com.oftenenough.app.data.widgets.WidgetSnapshot
import java.io.File
import kotlinx.serialization.Serializable
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.json.Json

/** One tap on a widget, written before anything is drawn and removed only once the store has saved it (W4, W5). */
@Serializable
data class WidgetTap(
    val id: String,
    val habit: String,
    val day: Int,
    /** "check" or "uncheck" (the state a ✓ set, never a flip, W4), "add" (one saved step), "timer". */
    val kind: String,
    val at: Long,
)

/**
 * The widgets' files, in the app's own storage (widgets run in the app's process on Android): the snapshot the app
 * wrote, the taps waiting to be saved, and each placed widget's choice. A test launch has its own folder (D8).
 */
object WidgetDisk {
    private val json = Json { ignoreUnknownKeys = true; encodeDefaults = false }
    private val lock = Any()
    var testLaunch = false

    private fun folder(context: Context) = File(context.filesDir, if (testLaunch) "uitest-widgets" else "widgets").also { it.mkdirs() }
    private fun snapshotFile(context: Context) = File(folder(context), "snapshot.json")
    private fun tapsFile(context: Context) = File(folder(context), "taps.json")

    fun read(context: Context): WidgetSnapshot? = synchronized(lock) {
        val f = snapshotFile(context)
        if (!f.exists()) null else runCatching { json.decodeFromString(WidgetSnapshot.serializer(), f.readText()) }.getOrNull()
    }

    fun write(context: Context, snapshot: WidgetSnapshot) = synchronized(lock) {
        atomic(snapshotFile(context), json.encodeToString(WidgetSnapshot.serializer(), snapshot))
    }

    /** A tap's card becomes its "after" in the snapshot (the app's own next state, W3), so the widget redraws at once. */
    fun applyTap(context: Context, itemId: String, token: String): WidgetItem? = synchronized(lock) {
        val snapshot = read(context) ?: return null
        var applied: WidgetItem? = null
        val frames = snapshot.frames.mapIndexed { i, frame ->
            if (i != 0) frame else frame.copy(items = frame.items.map { item ->
                if (item.id == itemId && item.token == token) item.after?.firstOrNull()?.also { applied = it } ?: item else item
            })
        }
        if (applied != null) atomic(snapshotFile(context), json.encodeToString(WidgetSnapshot.serializer(), snapshot.copy(frames = frames)))
        applied
    }

    fun taps(context: Context): List<WidgetTap> = synchronized(lock) {
        val f = tapsFile(context)
        if (!f.exists()) emptyList() else runCatching { json.decodeFromString(ListSerializer(WidgetTap.serializer()), f.readText()) }.getOrDefault(emptyList())
    }

    fun appendTap(context: Context, tap: WidgetTap) = synchronized(lock) {
        atomic(tapsFile(context), json.encodeToString(ListSerializer(WidgetTap.serializer()), taps(context) + tap))
    }

    fun removeTaps(context: Context, ids: Set<String>) = synchronized(lock) {
        atomic(tapsFile(context), json.encodeToString(ListSerializer(WidgetTap.serializer()), taps(context).filter { it.id !in ids }))
    }

    /** Each placed widget's choice ("habit:<id>", "section:<id>", "all"), by its Android widget ID. */
    fun choice(context: Context, widgetId: Int): String? = prefs(context).getString("widget.$widgetId", null)
    fun setChoice(context: Context, widgetId: Int, choice: String) { prefs(context).edit().putString("widget.$widgetId", choice).apply() }
    fun forget(context: Context, widgetId: Int) { prefs(context).edit().remove("widget.$widgetId").apply() }
    private fun prefs(context: Context) = context.getSharedPreferences(if (testLaunch) "uitest-widgets" else "widgets", Context.MODE_PRIVATE)

    private fun atomic(file: File, text: String) {
        val tmp = File(file.parentFile, file.name + ".tmp")
        tmp.writeText(text)
        if (!tmp.renameTo(file)) { file.delete(); tmp.renameTo(file) }
    }
}
