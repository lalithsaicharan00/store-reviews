package app.habits.rules

import kotlin.random.Random
import kotlin.test.Test
import kotlin.test.assertEquals

/** `Day.parse` reads every log's day on a load; its one-pass form must answer exactly as the first, split-based one. */
class DayParseTest {
    private fun reference(key: String?): Int? {
        if (key == null) return null
        val parts = key.split("-")
        if (parts.size != 3 || parts.any { p -> p.isEmpty() || p.any { it !in '0'..'9' } }) return null
        val y = parts[0].toIntOrNull() ?: return null
        val m = parts[1].toIntOrNull() ?: return null
        val d = parts[2].toIntOrNull() ?: return null
        if (y !in 1..9999 || m !in 1..12 || d !in 1..Day.daysInMonth(y, m)) return null
        return Day.of(y, m, d)
    }

    @Test
    fun answersAsTheSplitVersion() {
        val fixed = listOf(
            null, "", "-", "--", "2026-10-12", "2026-1-2", "02026-010-012", "2026-10-12-", "-2026-10-12", "2026--12",
            "2026-10-", "2026-13-01", "2026-00-10", "2026-02-29", "2024-02-29", "0000-01-01", "9999-12-31", "10000-01-01",
            "2026-10-1x", "2026 -10-12", "+2026-10-12", "2026-10-12\n", "99999999999999999999-01-01", "2026-10-99999999999",
            "٢٠٢٦-10-12", "1-1-1", "2026-10-12-01",
        )
        for (key in fixed) assertEquals(reference(key), Day.parse(key), "key $key")
        val random = Random(92)
        val alphabet = "0123456789-0123456789-x "
        repeat(200_000) {
            val key = buildString { repeat(random.nextInt(0, 14)) { append(alphabet[random.nextInt(alphabet.length)]) } }
            assertEquals(reference(key), Day.parse(key), "key $key")
        }
        repeat(50_000) {
            val key = "%d-%d-%d".format(random.nextInt(-5, 10_010), random.nextInt(-1, 14), random.nextInt(-1, 33))
            assertEquals(reference(key), Day.parse(key), "key $key")
        }
    }
}
