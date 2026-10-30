package com.oftenenough.app.ui.progress

import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableLongStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.runtime.withFrameNanos
import androidx.compose.ui.text.buildAnnotatedString
import androidx.compose.ui.text.withStyle
import com.oftenenough.app.data.Format
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.ProgressRange
import com.oftenenough.app.data.ProgressSnapshot
import com.oftenenough.app.data.progressBuilder
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.delay

/**
 * Today's day number, moved on at each new day's start (a new day makes new numbers: "This week" kept from before the
 * day's start would be last week). Wakes once a day, never on a ticker (S3).
 */
@Composable
internal fun rememberToday(store: HabitStore): Int {
    var today by remember { mutableIntStateOf(store.today()) }
    LaunchedEffect(store) {
        while (true) {
            val t = store.today()
            today = t
            delay(maxOf(1_000L, store.rules.dayStart(t + 1) - store.clock()))
        }
    }
    return today
}

/**
 * The period's numbers for [range] around [anchor] (null: the current period): kept ones at once; otherwise the period
 * and its first cards now (one frame's worth) and the rest a few per frame, so even a year of many habits never holds a
 * frame (S5, S16). For Habits & Tasks (the Habits tab is Progress, A54).
 */
@Composable
internal fun rememberProgressSnapshot(store: HabitStore, range: ProgressRange, anchor: Int?, today: Int, groupId: String): ProgressSnapshot {
    val key = SnapshotKey(range, anchor, store.dataVersion, groupId, today, store.weekStart, System.identityHashCode(store))
    val builder = remember(key) { if (ProgressCache.peek(key) != null) null else store.progressBuilder(range, anchor ?: today, today, groupId) }
    var snap by remember(key) { mutableStateOf(ProgressCache.peek(key) ?: builder!!.also { it.step(FIRST_BUDGET) }.snapshot()) }
    LaunchedEffect(key) {
        val b = builder ?: return@LaunchedEffect
        while (!b.isDone) {
            withFrameNanos { }
            b.step(FRAME_BUDGET)
            snap = b.snapshot()
        }
        ProgressCache.put(key, snap)
    }
    return snap
}

/** The anchor one period before ([step] < 0) or after [snap]'s: null when that's the current one. */
internal fun movedAnchor(store: HabitStore, snap: ProgressSnapshot, step: Int): Int? {
    val day = if (step < 0) snap.first - 1 else snap.last + 1
    return if (snap.today in store.rules.period(snap.range.kind, day)) null else day
}

/** The first frame's share of the cards' work, and each later frame's (a Year card is ~23 ms: one a frame). */
private const val FIRST_BUDGET = 20_000_000L
private const val FRAME_BUDGET = 6_000_000L

/** One snapshot per range, period, data version, group, day and week start (and store, for a test's own). */
private data class SnapshotKey(
    val range: ProgressRange, val anchor: Int?, val version: Int, val group: String, val today: Int, val weekStart: Int, val store: Int,
)

/**
 * The Habits tab's numbers, kept between openings (one for the app): going back to a period with nothing changed shows
 * the numbers already worked out (the iPhone's `ProgressModel`).
 */
private object ProgressCache {
    private val made = HashMap<SnapshotKey, ProgressSnapshot>()

    fun peek(key: SnapshotKey): ProgressSnapshot? = made[key]

    fun put(key: SnapshotKey, snapshot: ProgressSnapshot) {
        made.keys.removeAll { it.version != key.version || it.store != key.store || it.today != key.today }
        if (made.size > 80) made.clear()
        made[key] = snapshot
    }
}

private val headlineStyle = AppType.titleLargeEmphasized

/**
 * A quit card's headline: the run going on now, "12 d 11 h current run". Only this text ticks, once a minute, on the
 * run's own minutes (S3, S4).
 */
@Composable
internal fun QuitRunClock(start: Long, clock: () -> Long) {
    val c = appColors
    var now by remember(start) { mutableLongStateOf(clock()) }
    LaunchedEffect(start) {
        while (true) {
            val t = clock()
            now = t
            delay(60_000L - Math.floorMod(t - start, 60_000L))
        }
    }
    Text(
        buildAnnotatedString {
            withStyle(AppType.titleLargeEmphasized.toSpanStyle().copy(color = c.ink)) { append(Format.run((now - start) / 1000.0)) }
            withStyle(AppType.bodyMedium.toSpanStyle().copy(color = c.secondary)) { append(" current run") }
        },
        style = headlineStyle.copy(fontFeatureSettings = "tnum"),
    )
}
