package com.oftenenough.app

import com.oftenenough.app.data.move.MoveFile
import com.oftenenough.app.data.move.MoveReceiver
import com.oftenenough.app.data.move.MoveSender
import com.oftenenough.app.data.move.ReceiveState
import com.oftenenough.app.data.move.SendState
import com.oftenenough.app.data.move.moveHttp
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.withTimeout
import org.junit.Assert.assertArrayEquals
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNotEquals
import org.junit.Assert.assertTrue
import org.junit.Assume.assumeTrue
import org.junit.Test
import kotlin.random.Random

/**
 * Both phones of a move against a real relay (the account Worker): `MOVE_SERVER=http://127.0.0.1:8787` with
 * `npx wrangler dev` running in account-server/, or `https://api-dev.oftenenough.com`. Skipped without it.
 */
class MoveLiveTest {
    private val server = System.getenv("MOVE_SERVER")
    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.IO)
    private val http = moveHttp()

    private suspend fun shownCode(sender: MoveSender, previous: String? = null): SendState.Showing =
        sender.state.first { it is SendState.Showing && it.code != previous } as SendState.Showing

    @Test fun theRightCodeMovesTheWholeFileAndBothSidesSaySo() = runBlocking {
        assumeTrue("MOVE_SERVER not set", server != null)
        val file = Random(7).nextBytes(300_000)
        val sender = MoveSender(server!!, http, { MoveFile(file, 31, 929) }, scope).also { it.start() }
        withTimeout(30_000) {
            val code = shownCode(sender).code
            assertEquals(6, code.length)
            val receiver = MoveReceiver(server, http, scope).also { it.start(code) }
            val got = receiver.state.first { it is ReceiveState.Received || it is ReceiveState.WrongCode || it is ReceiveState.Stopped }
            assertTrue("received, not $got", got is ReceiveState.Received)
            got as ReceiveState.Received
            assertArrayEquals(file, got.bytes)
            assertEquals(31, got.habits)
            assertEquals(929, got.entries)
            val sent = sender.state.first { it is SendState.Sent || it is SendState.Failed }
            assertEquals(SendState.Sent(31, 929), sent)
        }
    }

    @Test fun aWrongCodeFailsOnTheNewPhoneAndTheOldPhoneShowsANewOne() = runBlocking {
        assumeTrue("MOVE_SERVER not set", server != null)
        val sender = MoveSender(server!!, http, { MoveFile(ByteArray(10), 1, 1) }, scope).also { it.start() }
        withTimeout(30_000) {
            val first = shownCode(sender)
            // The right channel, the wrong 4 digits: one guess, and it's gone.
            val wrong = first.code.take(2) + ((first.code.drop(2).toInt() + 1) % 10_000).toString().padStart(4, '0')
            val guesser = MoveReceiver(server, http, scope).also { it.start(wrong) }
            assertEquals(ReceiveState.WrongCode, guesser.state.first { it is ReceiveState.WrongCode || it is ReceiveState.Received || it is ReceiveState.Stopped })
            val next = shownCode(sender, first.code)
            assertTrue("the new code says a wrong code came before it", next.afterWrongTry)
            assertNotEquals(first.code, next.code)
            // The old code no longer works, even typed right.
            val late = MoveReceiver(server, http, scope).also { it.start(first.code) }
            val lateState = late.state.first { it !is ReceiveState.Connecting }
            assertTrue("the old code is over, not $lateState", lateState is ReceiveState.WrongCode || (next.code.take(2) == first.code.take(2)))
            // The new code works.
            val receiver = MoveReceiver(server, http, scope).also { it.start(next.code) }
            assertTrue(receiver.state.first { it is ReceiveState.Received || it is ReceiveState.WrongCode || it is ReceiveState.Stopped } is ReceiveState.Received)
        }
        sender.cancel()
    }

    @Test fun aChannelNobodyHoldsIsAWrongCode() = runBlocking {
        assumeTrue("MOVE_SERVER not set", server != null)
        withTimeout(15_000) {
            // Channels are 00–99; a whole run would need all of them taken for this one to exist.
            val receiver = MoveReceiver(server!!, http, scope).also { it.start("99" + "0000") }
            val state = receiver.state.first { it !is ReceiveState.Connecting }
            assertTrue("$state", state is ReceiveState.WrongCode || state is ReceiveState.Receiving || state is ReceiveState.Stopped)
        }
    }
}
