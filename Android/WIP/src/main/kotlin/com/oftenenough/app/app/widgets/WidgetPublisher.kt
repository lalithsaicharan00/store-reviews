package com.oftenenough.app.app.widgets

import android.content.Context
import android.graphics.Bitmap
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Canvas
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.ImageBitmap
import androidx.compose.ui.graphics.Paint
import androidx.compose.ui.graphics.PathFillType
import androidx.compose.ui.graphics.asAndroidBitmap
import androidx.compose.ui.graphics.vector.PathParser
import androidx.compose.ui.graphics.vector.VectorGroup
import androidx.compose.ui.graphics.vector.VectorNode
import androidx.compose.ui.graphics.vector.VectorPath
import androidx.glance.appwidget.updateAll
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.widgets.WidgetItems
import com.oftenenough.app.ui.theme.AppColors
import com.oftenenough.app.ui.theme.HabitIcons
import com.oftenenough.app.data.HabitColor
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

/**
 * LOCKED (widget taps): the widgets are published 0.5 s after the last change, and at once when the app leaves the
 * screen or a widget is tapped (W11). The snapshot is worked out by the app's own functions (U26), written to the
 * widgets' file, then every placed widget redraws from it.
 */
object WidgetPublisher {
    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.Main.immediate)
    private var pending: Job? = null

    fun schedule(context: Context, store: HabitStore) {
        pending?.cancel()
        pending = scope.launch {
            delay(500)
            publish(context.applicationContext, store)
        }
    }

    /** Publishes now. [hold]: a widget tap; today's lists keep their order for 1.5 s (U4), then done rows sink (U13). */
    suspend fun publish(context: Context, store: HabitStore, hold: Boolean = false) {
        pending?.cancel()
        store.flush()
        if (!store.isLoaded || store.problem != null) return
        val prefs = AppGraph.prefs
        val now = store.clock()
        val previous = if (hold) withContext(Dispatchers.IO) { WidgetDisk.read(context) } else null
        var snapshot = WidgetItems.snapshot(store, now, sinkDone = prefs.doneOrder != "stay", timerOpensScreen = prefs.timerScreen,
            previous = previous, hold = if (hold) now + 1_500 else null)
        if (prefs.hideNames) snapshot = snapshot.withoutNames()
        withContext(Dispatchers.IO) { WidgetDisk.write(context, snapshot) }
        updateAll(context)
        if (hold) scope.launch { delay(1_600); publish(context, store) }
    }

    /** Every placed widget redraws from the snapshot. */
    suspend fun updateAll(context: Context) {
        runCatching {
            OneHabitWidget().updateAll(context)
            TodayWidget().updateAll(context)
            TodayLargeWidget().updateAll(context)
            WeekWidget().updateAll(context)
            TasksWidget().updateAll(context)
            TasksLargeWidget().updateAll(context)
        }
    }
}

/** A habit's filled circle with its white glyph, drawn once per icon, colour and size and kept (Glance can't draw vectors). */
object HabitIconBitmaps {
    private val cache = HashMap<String, Bitmap>()

    fun get(symbol: String, color: String, dark: Boolean, sizePx: Int): Bitmap = synchronized(cache) {
        cache.getOrPut("$symbol|$color|$dark|$sizePx") { draw(symbol, HabitColor.of(color) ?: HabitColor.BLUE, dark, sizePx) }
    }

    private fun draw(symbol: String, habitColor: HabitColor, dark: Boolean, sizePx: Int): Bitmap {
        val image = ImageBitmap(sizePx, sizePx)
        val canvas = Canvas(image)
        val fill = (if (dark) AppColors.dark else AppColors.light).habit(habitColor)
        val circle = Paint().apply { this.color = fill; isAntiAlias = true }
        canvas.drawCircle(Offset(sizePx / 2f, sizePx / 2f), sizePx / 2f, circle)
        val vector = HabitIcons.icon(symbol)
        val glyph = sizePx * 0.55f
        val scale = glyph / vector.viewportWidth
        canvas.save()
        canvas.translate((sizePx - glyph) / 2f, (sizePx - glyph) / 2f)
        canvas.scale(scale, scale)
        val white = Paint().apply { this.color = Color.White; isAntiAlias = true }
        fun drawNode(node: VectorNode) {
            when (node) {
                is VectorPath -> {
                    val path = PathParser().addPathNodes(node.pathData).toPath()
                    path.fillType = if (node.pathFillType == PathFillType.EvenOdd) PathFillType.EvenOdd else PathFillType.NonZero
                    canvas.drawPath(path, white)
                }
                is VectorGroup -> for (child in node) drawNode(child)
            }
        }
        drawNode(vector.root)
        canvas.restore()
        return image.asAndroidBitmap()
    }

    @Suppress("unused") private val keep = Size.Zero
}
