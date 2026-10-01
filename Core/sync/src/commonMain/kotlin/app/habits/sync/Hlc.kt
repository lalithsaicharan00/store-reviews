package app.habits.sync

/**
 * A hybrid logical clock stamp (Architecture 05 §6): wall-clock milliseconds, a counter for events in the same
 * millisecond, and the device that made it. Stamps sort as text, so any platform (and the server) compares them
 * with a plain string comparison, and two devices can never make the same stamp.
 *
 * Encoded as `000001790841344500-00000-<node>`: 18 digits of milliseconds, 5 of counter, then the node.
 */
data class Hlc(val millis: Long, val counter: Int, val node: String) : Comparable<Hlc> {
    init {
        require(millis in 0..MAX_MILLIS) { "millis out of range: $millis" }
        require(counter in 0..MAX_COUNTER) { "counter out of range: $counter" }
        require(NODE.matches(node)) { "invalid node: $node" }
    }

    fun encode(): String = millis.toString().padStart(18, '0') + "-" + counter.toString().padStart(5, '0') + "-" + node

    override fun compareTo(other: Hlc): Int = encode().compareTo(other.encode())

    override fun toString(): String = encode()

    companion object {
        const val MAX_MILLIS = 999_999_999_999_999_999L
        const val MAX_COUNTER = 99_999
        private val NODE = Regex("[0-9a-zA-Z_-]{1,64}")
        private val ENCODED = Regex("(\\d{18})-(\\d{5})-([0-9a-zA-Z_-]{1,64})")

        fun parse(text: String): Hlc? {
            val match = ENCODED.matchEntire(text) ?: return null
            val (millis, counter, node) = match.destructured
            return Hlc(millis.toLong(), counter.toInt(), node)
        }

        fun isValid(text: String): Boolean = ENCODED.matches(text)
    }
}

/**
 * Makes stamps for one device. Every stamp is later than every stamp this device has made *or seen*, so an edit
 * made after receiving another device's change always wins over it, even if this device's clock is behind.
 * A device whose clock runs a year ahead can't make edits that win forever either: other devices that see its
 * stamps move past them, and its own counter keeps moving forward once its clock is corrected.
 */
class HlcClock(private val node: String, last: Hlc? = null) {
    var last: Hlc? = last
        private set

    /** A stamp for a change made now, on this device. */
    fun now(wallMillis: Long): Hlc {
        val previous = last
        val next = when {
            previous == null || wallMillis > previous.millis -> Hlc(wallMillis, 0, node)
            previous.counter < Hlc.MAX_COUNTER -> Hlc(previous.millis, previous.counter + 1, node)
            else -> Hlc(previous.millis + 1, 0, node) // 100,000 changes in one millisecond: borrow the next one
        }
        last = next
        return next
    }

    /** Moves past a stamp received from another device, so this device's next change sorts after it. */
    fun observe(remote: Hlc, wallMillis: Long) {
        val previous = last
        val latest = listOfNotNull(previous, remote).maxOf { it.millis }
        val millis = maxOf(latest, wallMillis)
        val counter = when {
            millis == wallMillis && millis > latest -> 0
            previous != null && previous.millis == millis && remote.millis == millis -> maxOf(previous.counter, remote.counter) + 1
            previous != null && previous.millis == millis -> previous.counter + 1
            remote.millis == millis -> remote.counter + 1
            else -> 0
        }
        last = if (counter > Hlc.MAX_COUNTER) Hlc(millis + 1, 0, node) else Hlc(millis, counter, node)
    }
}
