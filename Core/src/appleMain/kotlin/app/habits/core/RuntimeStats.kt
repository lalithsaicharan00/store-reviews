package app.habits.core

import kotlin.native.runtime.GC
import kotlin.native.runtime.NativeRuntimeApi

/**
 * The Kotlin runtime, for speed runs (Current Work 92): beside a long stall of the app's main thread, what the Kotlin
 * collector last did, so a stall can be told apart from the collector stopping the threads.
 */
@OptIn(NativeRuntimeApi::class, ExperimentalStdlibApi::class)
object RuntimeStats {
    /** The collector's last run: its number, how long it stopped the threads (and how long they took to stop) and how
     *  long it took, in ms. A stall whose note names a new number came with a collection. */
    fun lastCollection(): String {
        val info = GC.lastGCInfo ?: return "no collection yet"
        fun ms(ns: Long) = (ns / 100_000) / 10.0
        val first = "stopped ${ms(info.firstPauseEndTimeNs - info.firstPauseStartTimeNs)} ms " +
            "(after waiting ${ms(info.firstPauseStartTimeNs - info.firstPauseRequestTimeNs)} ms)"
        val start2 = info.secondPauseStartTimeNs
        val end2 = info.secondPauseEndTimeNs
        val second = if (start2 != null && end2 != null) ", then ${ms(end2 - start2)} ms" else ""
        return "collection ${info.epoch}: $first$second, took ${ms(info.endTimeNs - info.startTimeNs)} ms"
    }
}
