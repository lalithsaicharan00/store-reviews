package com.oftenenough.app.data.move

import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer
import java.security.MessageDigest
import java.security.SecureRandom
import java.util.Base64
import java.util.concurrent.TimeUnit
import javax.crypto.Cipher
import javax.crypto.spec.GCMParameterSpec
import javax.crypto.spec.SecretKeySpec
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody.Companion.toRequestBody
import okhttp3.Response
import okhttp3.WebSocket
import okhttp3.WebSocketListener
import okio.ByteString
import okio.ByteString.Companion.toByteString
import org.json.JSONObject

// MOVE TO CORE: the move's protocol, so the iPhone speaks it too (Rulebook D15).

/*
 * Moving to a new phone with a code (Rulebook D15, Current Work 136; the relay: account-server/src/move.ts).
 *
 * The old phone asks the relay for a channel (2 digits) and adds 4 digits of its own that never leave it: the 6 digits
 * it shows (and its QR code) are the whole code. The new phone joins the channel; both run SPAKE2 on the whole code
 * (Spake2.kt) and confirm the keys match. Only then does the old phone send its checked backup file (the same file
 * Save a backup file makes, D5), encrypted with AES-256-GCM under the agreed key, in chunks. The new phone checks the
 * file's SHA-256 and says it has it; nothing on it changes until the person chooses Bring them back (a restore with
 * its 30-day undo).
 *
 * One guess per code: when the new phone's confirmation doesn't match, the old phone tells the relay ("wrong"), the
 * relay closes both, and the old phone makes a new code at once ("Someone typed a wrong code. Here's a new one.").
 */

object MoveProtocol {
    val ID_NEW = "often-enough new phone".toByteArray()
    val ID_OLD = "often-enough old phone".toByteArray()
    const val CODE_LENGTH = 6
    const val CHUNK = 48 * 1024
    // The relay's close codes (move.ts, CLOSE).
    const val CLOSE_WRONG = 4001
    const val CLOSE_USED = 4002
    const val CLOSE_PEER_LEFT = 4003
    const val CLOSE_EXPIRED = 4004
    const val CLOSE_FINISHED = 4005
    // The encrypted frames' first byte.
    const val META: Byte = 1
    const val CHUNK_FRAME: Byte = 2
    const val END: Byte = 3
    const val GOT: Byte = 4

    /** "482913": the relay's 2 digits and 4 random ones made here. */
    fun code(channel: String): String {
        val random = SecureRandom()
        return channel + (0 until CODE_LENGTH - channel.length).joinToString("") { random.nextInt(10).toString() }
    }

    /** A code read from a QR code ("oftenenough://move/482913", or just the digits), or null. */
    fun fromQr(text: String): String? {
        val digits = text.trim().removePrefix("oftenenough://move/").removePrefix("https://oftenenough.com/move/")
        return digits.takeIf { it.length == CODE_LENGTH && it.all(Char::isDigit) }
    }

    fun qr(code: String) = "oftenenough://move/$code"

    fun text(type: String, vararg fields: Pair<String, String>): String =
        JSONObject().apply { put("t", type); fields.forEach { (k, v) -> put(k, v) } }.toString()

    fun b64(bytes: ByteArray): String = Base64.getEncoder().encodeToString(bytes)
    fun unb64(text: String): ByteArray = Base64.getDecoder().decode(text)
    fun sha256(bytes: ByteArray): String = MessageDigest.getInstance("SHA-256").digest(bytes).joinToString("") { "%02x".format(it) }
}

/**
 * The encrypted frames, one direction each: AES-256-GCM with a key from SPAKE2's Ke (HKDF), a 12-byte nonce of the
 * direction and a counter that only grows, so a frame can be neither changed, replayed nor reordered unseen.
 */
class MoveCipher(ke: ByteArray, private val fromOldPhone: Boolean) {
    private val key = SecretKeySpec(Spake2.hkdf(ke, ByteArray(0), "often-enough move v1 payload".toByteArray(), 32), "AES")
    private var sent = 0L
    private var received = 0L

    private fun nonce(oldToNew: Boolean, counter: Long): ByteArray =
        ByteBuffer.allocate(12).put(if (oldToNew) 1 else 2).put(0).put(0).put(0).putLong(counter).array()

    fun seal(type: Byte, body: ByteArray = ByteArray(0)): ByteArray {
        val n = nonce(fromOldPhone, sent++)
        val c = Cipher.getInstance("AES/GCM/NoPadding").apply { init(Cipher.ENCRYPT_MODE, key, GCMParameterSpec(128, n)) }
        return c.doFinal(byteArrayOf(type) + body)
    }

    /** The frame's type and body; throws on anything changed, replayed or out of order. */
    fun open(frame: ByteArray): Pair<Byte, ByteArray> {
        val n = nonce(!fromOldPhone, received++)
        val c = Cipher.getInstance("AES/GCM/NoPadding").apply { init(Cipher.DECRYPT_MODE, key, GCMParameterSpec(128, n)) }
        val plain = c.doFinal(frame)
        return plain[0] to plain.copyOfRange(1, plain.size)
    }
}

/** What the old phone sends: its checked backup file and what it holds. */
class MoveFile(val bytes: ByteArray, val habits: Int, val entries: Int)

/** One socket's events, in order. */
private sealed interface Event {
    data class Text(val text: String) : Event
    class Binary(val bytes: ByteArray) : Event
    data class Closed(val code: Int) : Event
    data class Failed(val httpCode: Int?) : Event
}

private fun OkHttpClient.socket(request: Request, events: Channel<Event>): WebSocket = newWebSocket(request, object : WebSocketListener() {
    override fun onMessage(webSocket: WebSocket, text: String) { events.trySend(Event.Text(text)) }
    override fun onMessage(webSocket: WebSocket, bytes: ByteString) { events.trySend(Event.Binary(bytes.toByteArray())) }
    override fun onClosing(webSocket: WebSocket, code: Int, reason: String) { webSocket.close(1000, null); events.trySend(Event.Closed(code)) }
    override fun onClosed(webSocket: WebSocket, code: Int, reason: String) { events.trySend(Event.Closed(code)) }
    override fun onFailure(webSocket: WebSocket, t: Throwable, response: Response?) { events.trySend(Event.Failed(response?.code)) }
})

fun moveHttp(): OkHttpClient = OkHttpClient.Builder()
    .connectTimeout(15, TimeUnit.SECONDS).readTimeout(0, TimeUnit.SECONDS).pingInterval(20, TimeUnit.SECONDS).build()

private fun wsUrl(base: String) = base.replaceFirst("https://", "wss://").replaceFirst("http://", "ws://")

// ------------------------------------------------------------------ The old phone

/** The old phone's page (Backup & Sync › Move to a new phone, Figma 3–3.3). */
sealed interface SendState {
    data object Starting : SendState
    /** Showing [code]; [afterWrongTry]: someone typed a wrong code, so this is a new one (3.3). */
    data class Showing(val code: String, val afterWrongTry: Boolean) : SendState
    data object Sending : SendState
    data class Sent(val habits: Int, val entries: Int) : SendState
    /** No internet or the relay can't be reached ([busy]: every channel is taken), or the move stopped halfway. */
    data class Failed(val stoppedHalfway: Boolean, val busy: Boolean = false) : SendState
}

/**
 * Shows a code until a new phone has the habits: a new code after a wrong try, a used code or 10 minutes, by itself.
 * [file] makes the backup file when a phone has paired (never before: it's the habits as they are at that moment).
 */
class MoveSender(private val base: String, private val http: OkHttpClient, private val file: suspend () -> MoveFile, private val scope: CoroutineScope) {
    private val _state = MutableStateFlow<SendState>(SendState.Starting)
    val state: StateFlow<SendState> = _state
    private var job: Job? = null
    private var socket: WebSocket? = null

    fun start() {
        job?.cancel()
        // Anything unexpected ends the move as stopped, never the app (found on Android 11, BigInteger.TWO).
        job = scope.launch(Dispatchers.IO) {
            try { run() } catch (e: kotlinx.coroutines.CancellationException) { throw e } catch (e: Throwable) {
                socket?.close(1000, null)
                _state.value = SendState.Failed(stoppedHalfway = _state.value == SendState.Sending)
            }
        }
    }

    fun cancel() {
        job?.cancel()
        socket?.close(1000, "cancelled")
    }

    private suspend fun run() {
        var afterWrongTry = false
        while (true) {
            _state.value = if (afterWrongTry) _state.value.takeIf { it is SendState.Showing } ?: SendState.Starting else SendState.Starting
            val made = try { newCode() } catch (e: Exception) { null }
            if (made == null) { _state.value = SendState.Failed(stoppedHalfway = false); return }
            if (made.busy) { _state.value = SendState.Failed(stoppedHalfway = false, busy = true); return }
            val code = MoveProtocol.code(made.channel)
            val events = Channel<Event>(Channel.UNLIMITED)
            val ws = http.socket(Request.Builder().url(wsUrl(base) + "/v1/move/send?move=" + made.move)
                .header("Authorization", "Bearer " + made.token).build(), events)
            socket = ws
            _state.value = SendState.Showing(code, afterWrongTry)
            when (val outcome = exchange(ws, events, code)) {
                Outcome.NEW_CODE_WRONG -> afterWrongTry = true
                Outcome.NEW_CODE -> afterWrongTry = false
                Outcome.DONE -> return
                Outcome.STOPPED -> { _state.value = SendState.Failed(stoppedHalfway = true); return }
                Outcome.OFFLINE -> {
                    // The socket dropped while only showing a code: try again shortly, keeping the page as it is.
                    delay(2_000)
                    afterWrongTry = false
                }
            }
        }
    }

    private enum class Outcome { NEW_CODE, NEW_CODE_WRONG, DONE, STOPPED, OFFLINE }

    private suspend fun exchange(ws: WebSocket, events: Channel<Event>, code: String): Outcome {
        val pake = Spake2(Spake2.Role.B, MoveProtocol.ID_NEW, MoveProtocol.ID_OLD, Spake2.passwordScalar(code))
        var keys: Spake2.Keys? = null
        var cipher: MoveCipher? = null
        var sending = false
        var sent: MoveFile? = null
        for (event in events) {
            when (event) {
                is Event.Text -> {
                    val json = runCatching { JSONObject(event.text) }.getOrNull() ?: continue
                    when (json.optString("t")) {
                        "pake" -> if (keys == null) {
                            val k = runCatching { pake.finish(MoveProtocol.unb64(json.getString("m"))) }.getOrNull()
                            if (k == null) { ws.send(MoveProtocol.text("wrong")); continue }
                            keys = k
                            ws.send(MoveProtocol.text("pake", "m" to MoveProtocol.b64(pake.message)))
                        }
                        "confirm" -> {
                            val k = keys ?: continue
                            if (!k.confirms(MoveProtocol.unb64(json.getString("c")))) {
                                // The new phone used another code: its one guess is gone, and so is this code.
                                ws.send(MoveProtocol.text("wrong"))
                                continue
                            }
                            ws.send(MoveProtocol.text("paired"))
                            ws.send(MoveProtocol.text("confirm", "c" to MoveProtocol.b64(k.myConfirmation)))
                            _state.value = SendState.Sending
                            sending = true
                            val c = MoveCipher(k.ke, fromOldPhone = true).also { cipher = it }
                            val f = withContext(Dispatchers.IO) { file() }
                            sent = f
                            val meta = JSONObject().put("size", f.bytes.size).put("sha256", MoveProtocol.sha256(f.bytes))
                                .put("habits", f.habits).put("entries", f.entries)
                            ws.send(c.seal(MoveProtocol.META, meta.toString().toByteArray()).toByteString())
                            var at = 0
                            while (at < f.bytes.size) {
                                val end = minOf(at + MoveProtocol.CHUNK, f.bytes.size)
                                ws.send(c.seal(MoveProtocol.CHUNK_FRAME, f.bytes.copyOfRange(at, end)).toByteString())
                                at = end
                            }
                            ws.send(c.seal(MoveProtocol.END).toByteString())
                        }
                        "used" -> return Outcome.NEW_CODE_WRONG
                    }
                }
                is Event.Binary -> {
                    val c = cipher ?: continue
                    val (type, _) = runCatching { c.open(event.bytes) }.getOrNull() ?: return Outcome.STOPPED
                    if (type == MoveProtocol.GOT) {
                        ws.send(MoveProtocol.text("finished"))
                        val f = sent!!
                        _state.value = SendState.Sent(f.habits, f.entries)
                        return Outcome.DONE
                    }
                }
                is Event.Closed -> return when {
                    sending -> Outcome.STOPPED
                    event.code == MoveProtocol.CLOSE_WRONG || event.code == MoveProtocol.CLOSE_USED -> Outcome.NEW_CODE_WRONG
                    event.code == MoveProtocol.CLOSE_EXPIRED -> Outcome.NEW_CODE
                    else -> Outcome.OFFLINE
                }
                is Event.Failed -> return if (sending) Outcome.STOPPED else Outcome.OFFLINE
            }
        }
        return Outcome.OFFLINE
    }

    private class Made(val channel: String, val move: String, val token: String, val busy: Boolean)

    private fun newCode(): Made {
        val request = Request.Builder().url("$base/v1/move/codes").post("{}".toRequestBody("application/json".toMediaType())).build()
        http.newCall(request).execute().use { response ->
            if (response.code == 503) return Made("", "", "", busy = true)
            check(response.isSuccessful) { "codes ${response.code}" }
            val json = JSONObject(response.body!!.string())
            return Made(json.getString("channel"), json.getString("move"), json.getString("token"), busy = false)
        }
    }
}

// ------------------------------------------------------------------ The new phone

/** The new phone's side (coming back's 5.2–5.4, Backup & Sync's 4.3–4.3.2). */
sealed interface ReceiveState {
    data object Connecting : ReceiveState
    data object Receiving : ReceiveState
    /** The whole file, checked against its SHA-256: nothing is restored until the person says so. */
    class Received(val bytes: ByteArray, val habits: Int, val entries: Int) : ReceiveState
    /** That code didn't work (5.2.1): no such channel, or the codes didn't match (the old phone shows a new one). */
    data object WrongCode : ReceiveState
    /** The move stopped (5.3.1): a phone closed the app or lost its connection; nothing changed on either. */
    data object Stopped : ReceiveState
}

class MoveReceiver(private val base: String, private val http: OkHttpClient, private val scope: CoroutineScope) {
    private val _state = MutableStateFlow<ReceiveState>(ReceiveState.Connecting)
    val state: StateFlow<ReceiveState> = _state
    private var job: Job? = null
    private var socket: WebSocket? = null

    fun start(code: String) {
        job?.cancel()
        _state.value = ReceiveState.Connecting
        job = scope.launch(Dispatchers.IO) {
            _state.value = try { run(code) } catch (e: kotlinx.coroutines.CancellationException) { throw e } catch (e: Throwable) {
                socket?.close(1000, null)
                ReceiveState.Stopped
            }
        }
    }

    fun cancel() {
        job?.cancel()
        socket?.close(1000, "cancelled")
    }

    private suspend fun run(code: String): ReceiveState {
        val events = Channel<Event>(Channel.UNLIMITED)
        val ws = http.socket(Request.Builder().url(wsUrl(base) + "/v1/move/receive?channel=" + code.take(2)).build(), events)
        socket = ws
        val pake = Spake2(Spake2.Role.A, MoveProtocol.ID_NEW, MoveProtocol.ID_OLD, Spake2.passwordScalar(code))
        ws.send(MoveProtocol.text("pake", "m" to MoveProtocol.b64(pake.message)))
        var keys: Spake2.Keys? = null
        var cipher: MoveCipher? = null
        var paired = false
        var meta: JSONObject? = null
        val out = ByteArrayOutputStream()
        for (event in events) {
            when (event) {
                is Event.Text -> {
                    val json = runCatching { JSONObject(event.text) }.getOrNull() ?: continue
                    when (json.optString("t")) {
                        "pake" -> if (keys == null) {
                            val k = runCatching { pake.finish(MoveProtocol.unb64(json.getString("m"))) }.getOrNull() ?: return ReceiveState.WrongCode.also { ws.close(1000, null) }
                            keys = k
                            ws.send(MoveProtocol.text("confirm", "c" to MoveProtocol.b64(k.myConfirmation)))
                        }
                        "paired" -> { paired = true; _state.value = ReceiveState.Receiving }
                        "confirm" -> {
                            val k = keys ?: continue
                            // The old phone proves it had the same code too; then everything after is under the key.
                            if (!k.confirms(MoveProtocol.unb64(json.getString("c")))) return ReceiveState.Stopped.also { ws.close(1000, null) }
                            cipher = MoveCipher(k.ke, fromOldPhone = false)
                        }
                    }
                }
                is Event.Binary -> {
                    val c = cipher ?: return ReceiveState.Stopped.also { ws.close(1000, null) }
                    val (type, body) = runCatching { c.open(event.bytes) }.getOrNull() ?: return ReceiveState.Stopped.also { ws.close(1000, null) }
                    when (type) {
                        MoveProtocol.META -> meta = JSONObject(String(body))
                        MoveProtocol.CHUNK_FRAME -> {
                            out.write(body)
                            // Never more than the old phone said it would send.
                            if (out.size() > (meta?.optInt("size") ?: 0)) return ReceiveState.Stopped.also { ws.close(1000, null) }
                        }
                        MoveProtocol.END -> {
                            val m = meta ?: return ReceiveState.Stopped
                            val bytes = out.toByteArray()
                            if (bytes.size != m.getInt("size") || MoveProtocol.sha256(bytes) != m.getString("sha256")) return ReceiveState.Stopped.also { ws.close(1000, null) }
                            ws.send(c.seal(MoveProtocol.GOT).toByteString())
                            return ReceiveState.Received(bytes, m.optInt("habits"), m.optInt("entries"))
                        }
                    }
                }
                is Event.Closed -> return if (paired) ReceiveState.Stopped else ReceiveState.WrongCode
                // 404: no phone holds that channel now. Anything else before pairing is a connection problem.
                is Event.Failed -> return if (event.httpCode == 404 || (!paired && keys != null)) ReceiveState.WrongCode else ReceiveState.Stopped
            }
        }
        return ReceiveState.Stopped
    }
}
