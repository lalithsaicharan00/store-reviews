package app.habits.core

import java.security.MessageDigest
import kotlin.random.Random
import kotlinx.coroutines.CompletableDeferred

/**
 * Google Drive's app folder, in memory, as faithful as the tests need: IDs reserved with `generateIds` and only those
 * accepted; a second file with a taken ID refused with 409 (the version chain's protection); files created whole or
 * not at all; Drive's own SHA-256 of what it stored. Each device gets its own [Client], whose faults can be set:
 * offline, list lag (a new file not yet listed), an upload cut off before or after Drive kept it, a file stored
 * damaged, 403/429/5xx answers, a full Drive, a revoked sign-in, or the app killed mid-call.
 *
 * With a [Turns] scheduler, every call waits for its turn, and the turns are given out in a seeded random order: several
 * devices syncing "at once" interleave call by call, so races (two saves under one reserved ID) happen, repeatably.
 */
class FakeDrive(private val random: Random = Random(0)) {
    class Stored(var file: DriveFile, val content: ByteArray, val listedFrom: Long)

    private val lock = Any()
    val files = LinkedHashMap<String, Stored>()
    private val reserved = mutableSetOf<String>()
    private val deleted = mutableSetOf<String>()
    private var nextId = 0
    /** Drive's clock for list lag: the test moves it on. */
    var tick = 0L

    /** What happened, for the checks: who created what after what (the chain's safety), downloads, and conflicts. */
    val log = mutableListOf<Event>()
    sealed class Event {
        data class Created(val by: String, val id: String, val prev: String, val chain: String) : Event()
        data class Downloaded(val by: String, val id: String) : Event()
        data class Conflict(val by: String, val id: String) : Event()
    }

    var turns: Turns? = null
    var calls = 0

    /** The app killed mid-call: not an Exception, so nothing in the app catches it. */
    class Killed : Error("killed")

    inner class Client(val name: String) : DriveApi {
        var offline = false
        /** A file created by someone else stays out of listings for this many ticks. */
        var listLag = 0L
        /** Faults for the next calls, used up one by one: each is thrown by the next call. */
        val faults = ArrayDeque<Fault>()
        /** Faults for the next uploads (creates) only. */
        val createFaults = ArrayDeque<Fault>()
        var callsMade = 0

        private suspend fun begin(): Fault? {
            turns?.turn()
            callsMade++
            synchronized(lock) { calls++ }
            if (offline) throw DriveError.Offline()
            return faults.removeFirstOrNull()
        }

        private fun throwIfError(fault: Fault?) {
            when (fault) {
                is Fault.Answer -> throw fault.error()
                Fault.Kill -> throw Killed()
                else -> Unit
            }
        }

        override suspend fun list(): List<DriveFile> {
            throwIfError(begin())
            return synchronized(lock) { files.values.filter { it.listedFrom <= tick }.map { it.file } }
        }

        override suspend fun get(id: String): DriveFile? {
            throwIfError(begin())
            return synchronized(lock) { files[id]?.file }
        }

        override suspend fun generateIds(count: Int): List<String> {
            throwIfError(begin())
            return synchronized(lock) { List(count) { "id${nextId++}x${random.nextInt(1000, 9999)}" }.also { reserved += it } }
        }

        override suspend fun create(id: String, name: String, properties: Map<String, String>, content: ByteArray): DriveFile {
            throwIfError(begin())
            val fault = createFaults.removeFirstOrNull()
            if (fault == Fault.CutBefore) throw DriveError.Offline()
            if (fault is Fault.Answer) throw fault.error()
            val stored = synchronized(lock) {
                if (id in files) {
                    log += Event.Conflict(this.name, id)
                    throw DriveError.Conflict()
                }
                if (id !in reserved) throw DriveError.Rejected(400, "fileIdNotUsable")
                // Drive never takes a deleted file's ID again (measured on the real Drive, 11 Oct 2026).
                if (id in deleted) throw DriveError.Rejected(400, "invalid")
                if (fullQuota) throw DriveError.Full()
                val kept = if (fault == Fault.StoreDamaged) content.copyOf(content.size / 2) else content
                val file = DriveFile(id, name, properties, kept.size.toLong(), tick, sha256(kept))
                files[id] = Stored(file, kept, tick + listLag)
                if (properties["oe"] == "v") {
                    log += Event.Created(this.name, id, properties["prev"].orEmpty(), properties["chain"].orEmpty())
                    history[id] = Stored(file, kept, 0)
                }
                file
            }
            // Drive kept it, but the answer never came back (the network dropped, or the app was killed).
            if (fault == Fault.CutAfter) throw DriveError.Offline()
            if (fault == Fault.Kill) throw Killed()
            return stored
        }

        override suspend fun updateProperties(id: String, properties: Map<String, String>): DriveFile {
            throwIfError(begin())
            return synchronized(lock) {
                val stored = files[id] ?: throw DriveError.NotFound()
                stored.file = stored.file.copy(properties = properties)
                stored.file
            }
        }

        override suspend fun download(id: String): ByteArray {
            throwIfError(begin())
            return synchronized(lock) {
                val stored = files[id] ?: throw DriveError.NotFound()
                log += Event.Downloaded(this.name, id)
                stored.content
            }
        }

        override suspend fun delete(id: String) {
            throwIfError(begin())
            synchronized(lock) { if (files.remove(id) != null) deleted += id }
        }

        override suspend fun quota(): DriveQuota {
            throwIfError(begin())
            return DriveQuota(15L shl 30, synchronized(lock) { files.values.sumOf { it.content.size.toLong() } })
        }
    }

    var fullQuota = false
    /** Every version ever saved, deleted ones too, for the checks. */
    val history = LinkedHashMap<String, Stored>()

    fun client(name: String) = Client(name)

    sealed class Fault {
        /** The upload never reached Drive. */
        data object CutBefore : Fault()
        /** Drive kept the file; the answer was lost. */
        data object CutAfter : Fault()
        /** Drive kept half the file (as a hostile or broken writer would leave it). */
        data object StoreDamaged : Fault()
        /** The app was killed during this call (an upload: just after Drive kept the file). */
        data object Kill : Fault()
        /** Drive answered with an error. */
        class Answer(val error: () -> DriveError) : Fault()
    }

    fun versions(chain: String? = null): List<DriveFile> = synchronized(lock) {
        files.values.map { it.file }.filter { it.properties["oe"] == "v" && (chain == null || it.properties["chain"] == chain) }
    }

    fun totalBytes(): Long = synchronized(lock) { files.values.sumOf { it.content.size.toLong() } }

    companion object {
        fun sha256(bytes: ByteArray): String = MessageDigest.getInstance("SHA-256").digest(bytes).joinToString("") { "%02x".format(it) }
    }
}

/**
 * Gives Drive calls their turns in a seeded random order. Every device's sync runs on its own coroutine; a call waits
 * here until every running sync is waiting too, then one, picked at random, goes on until its next call or its end.
 * Between two calls a device works only on its own database, so the outcome depends only on the seed.
 */
class Turns(private val random: Random) {
    private val lock = Object()
    private val waiting = mutableListOf<CompletableDeferred<Unit>>()
    private var running = 0

    suspend fun turn() {
        val mine = CompletableDeferred<Unit>()
        synchronized(lock) {
            waiting += mine
            lock.notifyAll()
        }
        mine.await()
    }

    /** Runs [work] at once, interleaved call by call, and waits for all of it. */
    fun <T> all(work: List<suspend () -> T>): List<Result<T>> {
        val results = arrayOfNulls<Result<T>>(work.size)
        synchronized(lock) { running = work.size }
        val threads = work.mapIndexed { i, w ->
            Thread {
                results[i] = runCatching { kotlinx.coroutines.runBlocking { w() } }
                synchronized(lock) {
                    running--
                    lock.notifyAll()
                }
            }.apply { start() }
        }
        synchronized(lock) {
            while (true) {
                while (waiting.size < running) lock.wait()
                if (running == 0) break
                val next = waiting.removeAt(random.nextInt(waiting.size))
                // That one goes on until its next call or its end; the loop then waits for it.
                next.complete(Unit)
            }
        }
        threads.forEach { it.join() }
        @Suppress("UNCHECKED_CAST")
        return results.map { it as Result<T> }
    }
}
