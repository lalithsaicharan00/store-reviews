package app.habits.sync

import kotlin.random.Random
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertNotNull
import kotlin.test.assertNull
import kotlin.test.assertTrue
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonNull
import kotlinx.serialization.json.JsonPrimitive

class HlcTest {
    @Test fun stampsSortAsTextInTimeOrder() {
        val a = Hlc(5, 0, "a").encode()
        val b = Hlc(5, 1, "a").encode()
        val c = Hlc(40, 0, "a").encode()
        val d = Hlc(1_790_841_344_500, 0, "a").encode()
        assertEquals(listOf(a, b, c, d), listOf(d, c, b, a).sorted())
        assertEquals(Hlc(1_790_841_344_500, 7, "node-1"), Hlc.parse(Hlc(1_790_841_344_500, 7, "node-1").encode()))
        assertNull(Hlc.parse("12-3-x"))
    }

    @Test fun aDeviceNeverRepeatsOrGoesBackwards() {
        val clock = HlcClock("phone")
        val stamps = listOf(1000L, 1000, 1000, 999, 500, 1001, 1001).map { clock.now(it) }
        assertEquals(stamps.sorted(), stamps)
        assertEquals(stamps.size, stamps.toSet().size)
    }

    @Test fun anEditAfterSeeingAnotherDevicesChangeAlwaysSortsAfterIt() {
        // The iPad's clock is 10 minutes ahead. The phone sees its edit, then makes its own.
        val ipad = HlcClock("ipad").now(1_000_000 + 600_000)
        val phone = HlcClock("phone")
        phone.observe(ipad, wallMillis = 1_000_000)
        assertTrue(phone.now(1_000_001) > ipad)
    }

    @Test fun aClockSetAYearAheadCantWinForever() {
        val yearMs = 365L * 24 * 3600 * 1000
        val wrong = HlcClock("wrong")
        val futureEdit = wrong.now(1_000_000 + yearMs)
        // Another device sees that edit; its next real edit still wins.
        val other = HlcClock("other")
        other.observe(futureEdit, 1_000_100)
        assertTrue(other.now(1_000_200) > futureEdit)
        // The wrong device's clock is corrected; its edits keep moving forward, never back behind its own.
        assertTrue(wrong.now(1_000_300) > futureEdit)
    }
}

class SyncRulesTest {
    private fun op(id: String, hlc: Hlc, vararg fields: Pair<String, JsonElement>, row: String = "h1") =
        Op(id, "habit", row, fields.toMap(), hlc.encode(), schema = 6)

    private fun s(v: String) = JsonPrimitive(v)

    private fun fold(ops: List<Op>): SyncRecord? = ops.fold(null as SyncRecord?) { r, o -> SyncRules.merge(r, o) }

    @Test fun differentFieldsOnTwoDevicesAreBothKept() {
        val created = op("o1", Hlc(1, 0, "phone"), "name" to s("Water"), "color" to s("blue"))
        val phone = op("o2", Hlc(10, 0, "phone"), "name" to s("Drink water"))
        val ipad = op("o3", Hlc(10, 0, "ipad"), "color" to s("green"))
        val result = fold(listOf(created, ipad, phone))!!
        assertEquals(s("Drink water"), result.fields["name"])
        assertEquals(s("green"), result.fields["color"])
    }

    @Test fun theSameFieldGoesToTheLaterStamp() {
        val early = op("o1", Hlc(10, 0, "phone"), "name" to s("A"))
        val late = op("o2", Hlc(11, 0, "ipad"), "name" to s("B"))
        assertEquals(s("B"), fold(listOf(early, late))!!.fields["name"])
        assertEquals(s("B"), fold(listOf(late, early))!!.fields["name"])
    }

    @Test fun aDeleteWinsAndAnOldDeviceCantBringTheRecordBack() {
        val created = op("o1", Hlc(1, 0, "phone"), "name" to s("Run"), "deleted_at" to JsonNull)
        val deleted = op("o2", Hlc(100, 0, "phone"), "deleted_at" to JsonPrimitive(100))
        // An iPad offline for 400 days edits it and "undeletes" it, with a later (wrong-clock) stamp.
        val staleEdit = op("o3", Hlc(10_000, 0, "ipad"), "name" to s("Run!"), "deleted_at" to JsonNull)
        for (order in listOf(listOf(created, deleted, staleEdit), listOf(created, staleEdit, deleted), listOf(staleEdit, created, deleted))) {
            val result = fold(order)!!
            assertTrue(result.isDeleted, "deleted in order ${order.map { it.id }}")
            assertEquals(s("Run!"), result.fields["name"], "the edit itself is kept for the undo")
        }
    }

    @Test fun theSameOpTwiceChangesNothing() {
        val a = op("o1", Hlc(1, 0, "phone"), "name" to s("A"))
        val b = op("o2", Hlc(2, 0, "ipad"), "name" to s("B"))
        assertEquals(fold(listOf(a, b)), fold(listOf(a, b, a, b, b, a)))
    }

    @Test fun fieldsThisVersionDoesntKnowAreKept() {
        val old = op("o1", Hlc(1, 0, "old"), "name" to s("A"))
        val newer = op("o2", Hlc(2, 0, "new"), "future_field" to JsonPrimitive(42))
        val oldEdit = op("o3", Hlc(3, 0, "old"), "name" to s("B"))
        val result = fold(listOf(old, newer, oldEdit))!!
        assertEquals(JsonPrimitive(42), result.fields["future_field"])
        assertEquals(s("B"), result.fields["name"])
    }

    /** Three devices make random edits and deletes; every ordering of every op, with repeats, ends in the same record. */
    @Test fun anyOrderAnyRepeatsSameResult() {
        val random = Random(2026)
        val devices = listOf("phone", "ipad", "watch")
        repeat(500) { round ->
            val clocks = devices.associateWith { HlcClock(it) }
            val ops = (0 until 12).map { i ->
                val device = devices.random(random)
                val stamp = clocks.getValue(device).now(random.nextLong(0, 50))
                val field = listOf("name", "color", "position", "deleted_at", "archived_at").random(random)
                val value: JsonElement = when {
                    field == "deleted_at" && random.nextInt(3) == 0 -> JsonPrimitive(random.nextInt(1000))
                    random.nextInt(4) == 0 -> JsonNull
                    else -> JsonPrimitive("v$i")
                }
                op("r$round-$i", stamp, field to value)
            }
            val expected = fold(ops)
            repeat(20) {
                val shuffled = (ops + ops.shuffled(random).take(random.nextInt(ops.size))).shuffled(random)
                assertEquals(expected, fold(shuffled), "round $round")
            }
        }
    }

    @Test fun malformedOpsAreRefused() {
        val good = op("o1", Hlc(1, 0, "phone"), "name" to s("A"))
        assertNull(SyncRules.problem(good))
        assertNotNull(SyncRules.problem(good.copy(table = "DROP TABLE")))
        assertNotNull(SyncRules.problem(good.copy(hlc = "yesterday")))
        assertNotNull(SyncRules.problem(good.copy(fields = emptyMap())))
        assertNotNull(SyncRules.problem(good.copy(fields = mapOf("id" to s("x")))))
        assertNotNull(SyncRules.problem(good.copy(fields = mapOf("name" to s("x".repeat(40_000))))))
        assertNotNull(SyncRules.problem(good.copy(row = "")))
    }

    @Test fun opsAndRecordsRoundTripThroughJson() {
        val o = op("o1", Hlc(1, 2, "phone"), "name" to s("Café ☕ \"quoted\""), "goal" to JsonPrimitive(8.5), "deleted_at" to JsonNull)
        assertEquals(o, SyncRules.decodeOp(SyncRules.encodeOp(o)))
        val record = SyncRules.merge(null, o)
        assertEquals(record, SyncRules.decodeRecord(SyncRules.encodeRecord(record)))
        assertNull(SyncRules.decodeOp("{\"id\": 1}"))
    }
}
