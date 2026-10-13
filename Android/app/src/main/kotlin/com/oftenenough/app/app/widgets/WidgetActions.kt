package com.oftenenough.app.app.widgets

import android.content.Context
import android.content.Intent
import androidx.glance.GlanceId
import androidx.glance.action.ActionParameters
import androidx.glance.appwidget.action.ActionCallback
import androidx.glance.appwidget.state.updateAppWidgetState
import androidx.datastore.preferences.core.intPreferencesKey
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.newId
import kotlinx.coroutines.delay
import kotlinx.coroutines.sync.Mutex
import kotlinx.coroutines.sync.withLock
import kotlinx.coroutines.withContext
import kotlinx.coroutines.Dispatchers

/** What a widget's button sends to its tap (Glance action parameters). */
object TapKeys {
    val ITEM = ActionParameters.Key<String>("item")
    val TOKEN = ActionParameters.Key<String>("token")
    /** "check", "uncheck", "add", "start", "stop". */
    val KIND = ActionParameters.Key<String>("kind")
    val DAY = ActionParameters.Key<Int>("day")
    val ROUTE = ActionParameters.Key<String>("route")
    val DELTA = ActionParameters.Key<Int>("delta")
}

/** A Large widget's page, kept per placed widget. */
val PAGE_KEY = intPreferencesKey("page")

/**
 * LOCKED (widget taps, 8 Oct 2026; Android): a ✓, + or ▶/⏸ on a widget. On Android a widget's action runs in the app's
 * own process, so the iPhone's hand-over (W1) is one step here, in the same order:
 *  1. the tap is written to the durable queue before anything else (W5),
 *  2. the card becomes its "after", the app's own next state (W3), and every widget redraws from it at once,
 *  3. the store saves it, idempotently (a + by its own ID, a ✓ as the state it set, W4), in the order taps were made,
 *  4. only then is it removed from the queue; the widgets are republished from the store, holding the order (U4),
 *     and the save's change asks for a Drive round and reminders (D12, SyncSchedule) like any other.
 * A tap that arrives while a test launch owns the process is only queued (D8), and saved by the person's next launch.
 */
class WidgetTapAction : ActionCallback {
    override suspend fun onAction(context: Context, glanceId: GlanceId, parameters: ActionParameters) {
        val item = parameters[TapKeys.ITEM] ?: return
        val token = parameters[TapKeys.TOKEN] ?: return
        val kind = parameters[TapKeys.KIND] ?: return
        val day = parameters[TapKeys.DAY] ?: return
        val app = context.applicationContext
        val tap = WidgetTap(newId(), item, day, kind, System.currentTimeMillis())
        withContext(Dispatchers.IO) {
            WidgetDisk.appendTap(app, tap)
            if (kind == "check" || kind == "uncheck" || kind == "add") WidgetDisk.applyTap(app, item, token)
        }
        WidgetPublisher.updateAll(app)
        WidgetTapSaver.saveWaiting(app)
    }
}

/** ‹ › on a Large widget: another page of its list. */
class WidgetPageAction : ActionCallback {
    override suspend fun onAction(context: Context, glanceId: GlanceId, parameters: ActionParameters) {
        val delta = parameters[TapKeys.DELTA] ?: return
        updateAppWidgetState(context, glanceId) { it[PAGE_KEY] = maxOf(0, (it[PAGE_KEY] ?: 0) + delta) }
        WidgetPublisher.updateOne(context, glanceId)
    }
}

/**
 * Anything that needs a screen opens it directly, replacing whatever the app had open (W8, W9): a checklist's Day
 * details, a slip or a typed number's Add screen, the timer.
 */
class WidgetOpenAction : ActionCallback {
    override suspend fun onAction(context: Context, glanceId: GlanceId, parameters: ActionParameters) {
        val route = parameters[TapKeys.ROUTE] ?: "today"
        val day = parameters[TapKeys.DAY] ?: -1
        context.startActivity(Intent(context, MainActivity::class.java)
            .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP)
            .putExtra(MainActivity.WIDGET_ROUTE, route).putExtra(MainActivity.OPEN_DAY, day))
    }
}

/** LOCKED (widget taps): saves every waiting tap, oldest first, one run at a time; removes each only once saved (W5). */
object WidgetTapSaver {
    private val mutex = Mutex()

    suspend fun saveWaiting(context: Context) = mutex.withLock {
        val app = context.applicationContext
        val waiting = withContext(Dispatchers.IO) { WidgetDisk.taps(app) }
        if (waiting.isEmpty()) return@withLock
        // A test launch never saves or removes the person's taps (D8): they wait for the next ordinary launch.
        if (AppGraph.isOpen && AppGraph.isTest) return@withLock
        AppGraph.open(app)
        val store = AppGraph.store
        if (!waitLoaded(store)) return@withLock
        val saved = HashSet<String>()
        for (tap in waiting.sortedBy { it.at }) {
            store.saveWidgetTap(tap.habit, tap.day, tap.kind, tap.id, tap.at)
            saved += tap.id
        }
        store.flush()
        // A failed write reloads the store and says so; the taps then stay in the queue for the next try.
        if (store.problem != null) return@withLock
        withContext(Dispatchers.IO) { WidgetDisk.removeTaps(app, saved) }
        WidgetPublisher.publish(app, store, hold = true)
    }

    private suspend fun waitLoaded(store: HabitStore): Boolean {
        var waited = 0
        while (!store.isLoaded && waited < 8_000) { delay(20); waited += 20 }
        return store.isLoaded
    }
}
