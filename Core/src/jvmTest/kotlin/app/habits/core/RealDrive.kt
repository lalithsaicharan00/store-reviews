package app.habits.core

import java.io.File
import java.net.URI
import java.net.http.HttpClient
import java.net.http.HttpRequest
import java.net.http.HttpResponse
import kotlin.system.exitProcess
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitAll
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.runBlocking

/**
 * Stage 2: Google Drive sync on the real Google Drive, with the test account the user made (never theirs). Run by
 * `.github/workflows/drive-real.yml` only, as plain JVM processes, so two "devices" are two processes with their own
 * HTTP clients and their own access tokens. Reads `GDRIVE_TEST_CLIENT_ID`, `GDRIVE_TEST_CLIENT_SECRET` and
 * `GDRIVE_TEST_REFRESH_TOKEN`; never prints a token, a request body or a file's content (D11), only IDs, names,
 * properties, sizes, status codes and times.
 *
 *   ids <count> <out>                      IDs reserved by this process
 *   race <role> <ids> <startMs> <out>      creates a file under each ID at a set moment (with the other processes)
 *   race-check <ids> <out>...              exactly one create per ID succeeded, every other got 409
 *   rounds                                 full DriveSync rounds with three devices
 *   behaviour                              how Drive itself behaves (list lag, IDs, half-written uploads, limits, speed)
 *   extreme <years>                        an extreme account (25,000 logs a year): first upload, a new device's download
 *   show <label>                           what's in the app folder
 *   clean                                  empties the app folder
 */
fun main(args: Array<String>) {
    val code = try {
        runBlocking { RealDrive.run(args.toList()) }
    } catch (e: DriveError.NotConnected) {
        println("NOT CONNECTED (${e.reason}): the refresh token has expired or was revoked. Renew it in the OAuth Playground.")
        3
    }
    exitProcess(code)
}

object RealDrive {
    private fun env(name: String) = System.getenv(name)?.takeIf { it.isNotBlank() } ?: error("$name is not set")

    fun drive(): GoogleDrive {
        val http = JvmDriveHttp()
        return GoogleDrive(http, RefreshTokenAccess(http, env("GDRIVE_TEST_CLIENT_ID"), env("GDRIVE_TEST_CLIENT_SECRET"), env("GDRIVE_TEST_REFRESH_TOKEN")))
    }

    private fun ms(start: Long) = (System.nanoTime() - start) / 1_000_000

    suspend fun run(args: List<String>): Int = when (args.firstOrNull()) {
        "ids" -> {
            val ids = drive().generateIds(args[1].toInt())
            File(args[2]).writeText(ids.joinToString("\n"))
            println("reserved ${ids.size} IDs (length ${ids.first().length})")
            0
        }
        "race" -> race(args[1], File(args[2]).readLines().filter { it.isNotBlank() }, args[3].toLong(), File(args[4]))
        "race-check" -> raceCheck(File(args[1]).readLines().filter { it.isNotBlank() }, args.drop(2).map(::File))
        "rounds" -> RealRounds().all()
        "behaviour" -> behaviour()
        "extreme" -> extreme(args.getOrElse(1) { "15" }.toInt())
        "show" -> { show(drive(), args.getOrElse(1) { "" }); 0 }
        "clean" -> { clean(drive()); 0 }
        else -> { println("usage: ids|race|race-check|rounds|behaviour|show|clean"); 2 }
    }

    // MARK: The deciding check: one ID, several processes, exactly one wins

    /** Round i starts at [start] + i × 1.5 s; each role waits its own offset for that round (0, 20 or 150 ms). */
    private suspend fun race(role: String, ids: List<String>, start: Long, out: File): Int {
        val drive = drive()
        drive.list() // the token is fetched before the first round, not during it
        val lines = mutableListOf<String>()
        for ((i, id) in ids.withIndex()) {
            val offset = offset(role, i)
            val at = start + i * 1_500L + offset
            val wait = at - System.currentTimeMillis()
            if (wait > 0) delay(wait)
            val t = System.nanoTime()
            val result = try {
                drive.create(id, "race-$i-$role", mapOf("oe" to "race", "role" to role, "round" to "$i"), "made by $role".encodeToByteArray())
                "created"
            } catch (_: DriveError.Conflict) {
                "409"
            } catch (e: DriveError) {
                "error:${e.message}"
            }
            lines += "$i $id $result ${ms(t)} $offset"
        }
        out.writeText(lines.joinToString("\n"))
        println("$role: ${lines.count { it.contains(" created ") }} created, ${lines.count { it.contains(" 409 ") }} refused with 409, ${lines.count { it.contains(" error:") }} other")
        return 0
    }

    private fun offset(role: String, round: Int): Long = when (round % 4) {
        0 -> 0 // the same instant
        1 -> if (role == "A") 0 else 20
        2 -> if (role == "A") 20 else 0
        else -> if (role.last().code % 2 == 0) 150 else 0
    }

    private suspend fun raceCheck(ids: List<String>, outs: List<File>): Int {
        val results = outs.map { f -> f.nameWithoutExtension to f.readLines().associate { line -> line.split(" ").let { it[1] to it[2] } } }
        val drive = drive()
        val files = drive.list().filter { it.properties["oe"] == "race" }.associateBy { it.id }
        var good = 0
        val bad = mutableListOf<String>()
        val latencies = outs.flatMap { f -> f.readLines().map { it.split(" ")[3].toLong() } }.sorted()
        for (id in ids) {
            val outcomes = results.map { (role, r) -> role to r[id] }
            val winners = outcomes.filter { it.second == "created" }
            val refused = outcomes.count { it.second == "409" }
            val file = files[id]
            val ok = winners.size == 1 && refused == outcomes.size - 1 && file != null && file.properties["role"] == winners.single().first
            if (ok) good++ else bad += "$id: ${outcomes.joinToString { "${it.first}=${it.second}" }}; on Drive: ${file?.properties?.get("role")}"
        }
        val sameName = files.values.groupBy { it.name.substringBeforeLast('-') }.count { it.value.size > 1 }
        println("RACE: ${ids.size} IDs, ${outs.size} processes: $good with exactly one save and every other refused with 409; ${bad.size} not")
        bad.take(20).forEach { println("  NOT SAFE: $it") }
        println("RACE: files on Drive under the race IDs: ${files.size} (one per ID expected), round names saved twice: $sameName")
        println("RACE: create latency ms: min ${latencies.first()}, median ${latencies[latencies.size / 2]}, p95 ${latencies[latencies.size * 95 / 100]}, max ${latencies.last()}")
        files.values.forEach { drive.delete(it.id) }
        return if (bad.isEmpty() && files.size == ids.size) 0 else 1
    }

    // MARK: How Drive behaves

    private suspend fun behaviour(): Int {
        val drive = drive()
        clean(drive)

        // IDs: what they look like, how many a call gives.
        val ids = drive.generateIds(1000)
        println("IDS: one call gave ${ids.size} IDs, lengths ${ids.minOf { it.length }}–${ids.maxOf { it.length }}, all different: ${ids.toSet().size == ids.size}")

        // List lag: is a file listed the moment it's made?
        val lags = mutableListOf<Long>()
        var listsNeeded = 0
        repeat(20) { i ->
            val id = ids[i]
            drive.create(id, "lag-$i", mapOf("oe" to "probe"), ByteArray(10))
            val t = System.nanoTime()
            var n = 0
            while (drive.list().none { it.id == id }) {
                n++
                if (ms(t) > 60_000) break
            }
            lags += ms(t)
            listsNeeded += n
        }
        println("LIST LAG: 20 new files; listed at once in ${lags.count { it < 2_000 } }/20 (extra lists needed in all: $listsNeeded); ms: ${lags.sorted()}")

        // The same ID twice from one client (a retry after a lost answer).
        val same = ids[100]
        drive.create(same, "same", mapOf("oe" to "probe"), ByteArray(1))
        val again = runCatching { drive.create(same, "same-again", mapOf("oe" to "probe"), ByteArray(1)) }.exceptionOrNull()
        println("SAME ID TWICE: second create → ${again?.let { it::class.simpleName } ?: "accepted!"}")

        // An ID nobody reserved.
        val madeUp = runCatching { drive.create("1madeUpIdNotFromGenerateIds00000", "made-up", mapOf("oe" to "probe"), ByteArray(1)) }
        println("MADE-UP ID: ${madeUp.exceptionOrNull()?.message ?: "accepted (id ${madeUp.getOrNull()?.id})"}")

        // An ID used, deleted, then used again.
        val reuse = ids[101]
        drive.create(reuse, "reuse-1", mapOf("oe" to "probe"), ByteArray(1))
        drive.delete(reuse)
        val reused = runCatching { drive.create(reuse, "reuse-2", mapOf("oe" to "probe"), ByteArray(1)) }
        println("ID AFTER DELETE: ${reused.exceptionOrNull()?.let { it::class.simpleName + " " + it.message } ?: "accepted again"}")

        // Reserved, then waited on: still accepted after a few minutes? (The pool keeps IDs up to a day.)
        // A half-written upload: a resumable upload started under a reserved ID and abandoned half-way.
        halfWritten(ids[102])

        // The checksum Drive gives back.
        val content = ByteArray(5000) { (it * 7).toByte() }
        val made = drive.create(ids[103], "checksum", mapOf("oe" to "probe"), content)
        println("CHECKSUM: Drive's sha256 matches ours: ${made.sha256 == Sha256.hex(content)}")
        val get = drive.get(ids[103])
        println("GET: size ${get?.size}, created ${get?.createdTime}, properties kept: ${get?.properties == mapOf("oe" to "probe")}")

        // Rate limits: 100 listings, 20 at a time.
        val t = System.nanoTime()
        val answers = coroutineScope {
            (0 until 100).map { async(Dispatchers.IO) { runCatching { drive.list() }.exceptionOrNull()?.let { it::class.simpleName } ?: "ok" } }.awaitAll()
        }
        println("BURST: 100 listings at once in ${ms(t)} ms: ${answers.groupingBy { it }.eachCount()}")

        // Speed of a single call.
        val listMs = List(10) { val s = System.nanoTime(); drive.list(); ms(s) }.sorted()
        println("LATENCY: list ms ${listMs}")
        val quota = drive.quota()
        println("QUOTA: ${quota.usage / 1024} KB used of ${quota.limit?.let { it / (1L shl 20) }} MB")
        clean(drive)
        return 0
    }

    /** An extreme account on the real Drive: its first upload, a new device's first download, one more log, an idle round. */
    private suspend fun extreme(years: Int): Int {
        clean(drive())
        var t = System.nanoTime()
        val phone = HabitRepository.openInMemory()
        val now = System.currentTimeMillis()
        val habits = List(12) { i ->
            HabitRecord("h$i", "Habit $i", "star", "blue", "amount", "glasses", 1.0, "anytime", 8.0, "day", null, "daily", null, null, false, null, i, 1_000, 1_000, null, null)
        }
        val entries = (0 until years).flatMap { y ->
            List(25_000) { i ->
                EntryRecord("e$y-$i", "h${i % 12}", null, "${2026 - y}-${(i % 12 + 1).toString().padStart(2, '0')}-${(i % 28 + 1).toString().padStart(2, '0')}", 1.0, now - i, "Europe/London", null, null, "today")
            }
        }
        phone.importAll(Snapshot(habits, emptyList(), emptyList(), entries, emptyList()))
        println("EXTREME: ${entries.size} logs over $years years made in ${ms(t)} ms")
        val phoneSync = DriveSync(phone, drive(), "Pixel 8", "android")
        phoneSync.connect("gdrive:real-extreme")
        t = System.nanoTime()
        val first = phoneSync.syncNow()
        println("EXTREME: first upload ${ms(t)} ms (${first.state}, ${first.waiting} waiting)")
        show(drive(), "extreme account")
        val fresh = HabitRepository.openInMemory()
        val freshSync = DriveSync(fresh, drive(), "Pixel 9", "android")
        freshSync.connect("gdrive:real-extreme")
        t = System.nanoTime()
        val came = freshSync.syncNow(allowUpload = false)
        val got = fresh.load().entries.size
        println("EXTREME: a new device's first download and merge ${ms(t)} ms (${came.state}): $got of ${entries.size} logs")
        phone.addEntry(EntryRecord("one-more", "h0", null, "2026-10-11", 1.0, System.currentTimeMillis(), "Europe/London", null, null, "today"))
        t = System.nanoTime()
        phoneSync.syncNow()
        println("EXTREME: a save after one more log ${ms(t)} ms")
        t = System.nanoTime()
        freshSync.syncNow()
        println("EXTREME: the other device takes it in ${ms(t)} ms")
        t = System.nanoTime()
        freshSync.syncNow()
        println("EXTREME: an idle round ${ms(t)} ms")
        clean(drive())
        return if (got == entries.size && first.waiting == 0) 0 else 1
    }

    /** Starts a resumable upload under [id], sends half, stops; then another client makes a file under the same ID. */
    private suspend fun halfWritten(id: String) {
        val http = HttpClient.newHttpClient()
        val token = RefreshTokenAccess(JvmDriveHttp(), env("GDRIVE_TEST_CLIENT_ID"), env("GDRIVE_TEST_CLIENT_SECRET"), env("GDRIVE_TEST_REFRESH_TOKEN")).accessToken(false)
        val metadata = """{"id":"$id","name":"half","parents":["appDataFolder"],"appProperties":{"oe":"probe"}}"""
        val start = http.send(
            HttpRequest.newBuilder(URI.create("https://www.googleapis.com/upload/drive/v3/files?uploadType=resumable"))
                .header("Authorization", "Bearer $token").header("Content-Type", "application/json; charset=UTF-8")
                .header("X-Upload-Content-Type", "application/octet-stream").header("X-Upload-Content-Length", "1048576")
                .POST(HttpRequest.BodyPublishers.ofString(metadata)).build(),
            HttpResponse.BodyHandlers.discarding(),
        )
        val session = start.headers().firstValue("location").orElse(null)
        if (session == null) {
            println("HALF-WRITTEN: couldn't start a resumable upload (${start.statusCode()})")
            return
        }
        val half = http.send(
            HttpRequest.newBuilder(URI.create(session)).header("Content-Range", "bytes 0-524287/1048576")
                .PUT(HttpRequest.BodyPublishers.ofByteArray(ByteArray(524288))).build(),
            HttpResponse.BodyHandlers.discarding(),
        )
        val drive = drive()
        val listed = drive.list().any { it.id == id }
        val byId = drive.get(id)
        val other = runCatching { drive.create(id, "after-half", mapOf("oe" to "probe"), ByteArray(3)) }
        println("HALF-WRITTEN: half sent (${half.statusCode()}); the file listed: $listed, found by ID: ${byId != null}; " +
            "another client's create under the same ID: ${other.exceptionOrNull()?.let { it::class.simpleName + " " + it.message } ?: "accepted"}")
        // The abandoned session, finished late: does it make a second file or overwrite?
        val late = http.send(
            HttpRequest.newBuilder(URI.create(session)).header("Content-Range", "bytes 524288-1048575/1048576")
                .PUT(HttpRequest.BodyPublishers.ofByteArray(ByteArray(524288))).build(),
            HttpResponse.BodyHandlers.discarding(),
        )
        val after = drive.get(id)
        println("HALF-WRITTEN: the abandoned upload finished late → ${late.statusCode()}; the file under the ID is now '${after?.name}' (${after?.size} bytes)")
    }

    suspend fun show(drive: DriveApi, label: String) {
        val files = drive.list()
        println("FOLDER $label: ${files.size} files")
        for (f in files.sortedWith(compareBy({ it.properties["oe"] }, { it.properties["chain"] }, { it.properties["seq"]?.toLongOrNull() }))) {
            val p = f.properties
            val what = when (p["oe"]) {
                "v" -> "version ${p["chain"]} #${p["seq"]} rows ${p["rows"]} live ${p["live"]} by ${p["by"]} prev ${p["prev"]?.take(8)} next ${p["next"]?.take(8)}" +
                    (p["abs"]?.let { " took in ${it.take(20)}" } ?: "")
                "d" -> "device ${p["name"]} (${p["platform"]}) checked in ${p["seen"]} sent ${p["sent"]}"
                else -> "other ${p["oe"]}"
            }
            println("  ${f.id.take(10)} ${f.name} ${f.size} B — $what")
        }
    }

    suspend fun clean(drive: DriveApi) {
        val files = drive.list()
        files.forEach { drive.delete(it.id) }
        println("CLEAN: ${files.size} files deleted from the app folder")
    }
}
