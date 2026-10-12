package app.habits.core

import kotlinx.cinterop.ExperimentalForeignApi
import kotlinx.cinterop.addressOf
import kotlinx.cinterop.usePinned
import platform.Foundation.NSData
import platform.Foundation.dataWithBytes

/**
 * [LiveRules.days] as one block of bytes (the doubles in order): Swift reads it in one go, where reading the array back
 * crossed into Kotlin once per number, six a day (Current Work 92, checkpoint 2).
 */
@OptIn(ExperimentalForeignApi::class)
fun LiveRules.daysData(h: RuleHabit, first: Int, last: Int, reference: Int, now: Long): NSData {
    val values = days(h, first, last, reference, now)
    if (values.isEmpty()) return NSData()
    return values.usePinned { NSData.dataWithBytes(it.addressOf(0), (values.size * 8).toULong()) }
}
