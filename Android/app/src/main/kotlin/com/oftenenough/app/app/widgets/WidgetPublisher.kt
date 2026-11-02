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
import androidx.compose.ui.graphics.asAndroidPath
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.graphics.vector.PathParser
import androidx.compose.ui.graphics.vector.VectorGroup
import androidx.compose.ui.graphics.vector.VectorNode
import androidx.compose.ui.graphics.vector.VectorPath
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.widgets.WidgetItems
import com.oftenenough.app.ui.components.medalColors
import com.oftenenough.app.ui.components.starPath
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
            pending = null // publish cancels what's pending, which is no longer this job
            publish(context.applicationContext, store)
        }
    }

    /** Publishes now. [hold]: a widget tap; today's lists keep their order for 1.5 s (U4), then done rows sink (U13). */
    suspend fun publish(context: Context, store: HabitStore, hold: Boolean = false) {
        pending?.cancel()
        store.flush()
        if (!store.isLoaded || store.problem != null) return
        // D8: a test launch never writes or redraws the person's widgets.
        if (AppGraph.isTest) return
        val prefs = AppGraph.prefs
        val now = store.clock()
        val previous = if (hold) withContext(Dispatchers.IO) { WidgetDisk.read(context) } else null
        // A widget's lists always put what's done after what's still to do (A99).
        var snapshot = WidgetItems.snapshot(store, now, sinkDone = true, timerOpensScreen = prefs.timerScreen,
            previous = previous, hold = if (hold) now + 1_500 else null)
        if (AppGraph.hidesNames) snapshot = snapshot.withoutNames()
        withContext(Dispatchers.IO) { WidgetDisk.write(context, snapshot) }
        updateAll(context)
        if (hold) scope.launch { delay(1_600); publish(context, store) }
    }

    private val widgets: List<androidx.glance.appwidget.GlanceAppWidget> =
        listOf(OneHabitWidget(), TodayWidget(), TodayLargeWidget(), WeekWidget(), TasksWidget(), TasksLargeWidget())

    /** Every placed widget redraws from the snapshot (its state's version moves, so its composition reads the file again). */
    suspend fun updateAll(context: Context) {
        val manager = androidx.glance.appwidget.GlanceAppWidgetManager(context)
        val version = System.nanoTime()
        for (widget in widgets) runCatching {
            for (id in manager.getGlanceIds(widget.javaClass)) {
                androidx.glance.appwidget.state.updateAppWidgetState(context, id) { it[VERSION_KEY] = version }
                widget.update(context, id)
            }
        }
        WidgetDayReceiver.plan(context, store = if (AppGraph.isOpen) AppGraph.store else null)
    }

    /**
     * The phone's mode changed while the app was running: every widget draws again, so its pictures (the habit's medal)
     * follow the colours that switch by themselves (A98). A test launch never redraws the person's widgets (D8).
     */
    fun phoneModeChanged(context: Context) {
        if (AppGraph.isTest) return
        scope.launch { updateAll(context.applicationContext) }
    }

    /** One widget redraws (a page turned). */
    suspend fun updateOne(context: Context, id: androidx.glance.GlanceId) {
        val manager = androidx.glance.appwidget.GlanceAppWidgetManager(context)
        val appWidgetId = manager.getAppWidgetId(id)
        val provider = android.appwidget.AppWidgetManager.getInstance(context).getAppWidgetInfo(appWidgetId)?.provider?.className ?: return
        val widget = widgets.firstOrNull { provider.endsWith(it.javaClass.simpleName + "Receiver") } ?: return
        androidx.glance.appwidget.state.updateAppWidgetState(context, id) { it[VERSION_KEY] = System.nanoTime() }
        widget.update(context, id)
    }
}

/** A habit's filled circle with its white glyph, drawn once per icon, colour and size and kept (Glance can't draw vectors). */
object HabitIconBitmaps {
    private val cache = HashMap<String, Bitmap>()

    fun get(symbol: String, color: String, dark: Boolean, sizePx: Int): Bitmap = synchronized(cache) {
        cache.getOrPut("$symbol|$color|$dark|$sizePx") { draw(symbol, HabitColor.of(color) ?: HabitColor.BLUE, dark, sizePx) }
    }

    /** The glyph alone, white on clear: a notification's small icon, which Android tints (the timer's Live Update). */
    fun glyph(symbol: String, sizePx: Int): Bitmap = synchronized(cache) {
        cache.getOrPut("$symbol|glyph|$sizePx") { draw(symbol, null, false, sizePx) }
    }

    private fun draw(symbol: String, habitColor: HabitColor?, dark: Boolean, sizePx: Int): Bitmap {
        val image = ImageBitmap(sizePx, sizePx)
        val canvas = Canvas(image)
        if (habitColor != null) {
            val fill = (if (dark) AppColors.dark else AppColors.light).habit(habitColor)
            val circle = Paint().apply { this.color = fill; isAntiAlias = true }
            canvas.drawCircle(Offset(sizePx / 2f, sizePx / 2f), sizePx / 2f, circle)
        }
        val vector = HabitIcons.icon(symbol)
        val glyph = sizePx * (if (habitColor == null) 1f else 0.55f)
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
                // A group's own move, mirror and turn (every Material symbol sits at y −960, moved down by its group).
                is VectorGroup -> {
                    canvas.save()
                    canvas.translate(node.translationX + node.pivotX, node.translationY + node.pivotY)
                    canvas.rotate(node.rotation)
                    canvas.scale(node.scaleX, node.scaleY)
                    canvas.translate(-node.pivotX, -node.pivotY)
                    for (child in node) drawNode(child)
                    canvas.restore()
                }
            }
        }
        drawNode(vector.root)
        canvas.restore()
        return image.asAndroidBitmap()
    }

    @Suppress("unused") private val keep = Size.Zero
}

/**
 * A habit's medal (Medal.kt, Figma's Medal): the nine-point star in the habit's Medal gradient, its inner ring a white
 * line at 60 %, a soft shadow; the number is the widget's own text over it. Drawn once per colour, mode and size and
 * kept: a widget can't draw a gradient star, and the medal's colours differ in dark ([medalColors]).
 */
object MedalBitmaps {
    private val cache = HashMap<String, Bitmap>()

    fun get(color: String, dark: Boolean, sizePx: Int): Bitmap = synchronized(cache) {
        cache.getOrPut("$color|$dark|$sizePx") { draw(HabitColor.of(color) ?: HabitColor.BLUE, dark, sizePx) }
    }

    private fun draw(habit: HabitColor, dark: Boolean, sizePx: Int): Bitmap {
        val colors = medalColors(if (dark) AppColors.dark else AppColors.light, habit)
        // Room under the star for its shadow (2 down, a 6 blur at 72), as Medal draws past its box.
        val bitmap = Bitmap.createBitmap(sizePx, sizePx, Bitmap.Config.ARGB_8888)
        val canvas = android.graphics.Canvas(bitmap)
        val inset = sizePx * 0.06f
        val k = (sizePx - 2 * inset) / 72f
        val shape = androidx.compose.ui.graphics.Path().apply {
            addPath(starPath)
            transform(androidx.compose.ui.graphics.Matrix().apply { translate(inset, inset); scale(k, k) })
        }.asAndroidPath()
        val fill = android.graphics.Paint(android.graphics.Paint.ANTI_ALIAS_FLAG).apply {
            color = colors.bottom.toArgb()
            setShadowLayer(6f * k, 0f, 2f * k, colors.shadow.toArgb())
        }
        canvas.drawPath(shape, fill)
        fill.clearShadowLayer()
        fill.shader = android.graphics.LinearGradient(0f, inset, 0f, sizePx - inset, colors.top.toArgb(), colors.bottom.toArgb(), android.graphics.Shader.TileMode.CLAMP)
        canvas.drawPath(shape, fill)
        // The inner ring: the same star at 82 % about the centre, 1.2 at the 40 size (the Small medal), white at 60 %.
        val ring = android.graphics.Paint(android.graphics.Paint.ANTI_ALIAS_FLAG).apply {
            style = android.graphics.Paint.Style.STROKE
            strokeWidth = 1.2f * sizePx / 40f / 0.82f
            strokeCap = android.graphics.Paint.Cap.ROUND
            color = Color.White.copy(alpha = 0.6f).toArgb()
        }
        canvas.save()
        canvas.scale(0.82f, 0.82f, sizePx / 2f, sizePx / 2f)
        canvas.drawPath(shape, ring)
        canvas.restore()
        return bitmap
    }
}

