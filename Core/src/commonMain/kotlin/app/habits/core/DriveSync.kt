package app.habits.core

import kotlin.coroutines.cancellation.CancellationException
import kotlin.random.Random
import kotlinx.coroutines.delay
import kotlinx.coroutines.sync.Mutex
import kotlinx.coroutines.sync.withLock
import kotlinx.coroutines.withContext
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.booleanOrNull
import kotlinx.serialization.json.jsonArray
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive
import kotlinx.serialization.json.longOrNull

/**
 * Sync through the person's own Google Drive (Android/Docs decisions A4, A5, A9; Rulebook D16): download, merge,
 * upload, never replace. The same outbox, merge rules, brake and fresh-install rule as iCloud; only the carrier
 * differs. The app decides when it runs (on opening, a few seconds after changes, about once a minute on screen, in
 * the background): this has one [syncNow] and a [status], and no timers of its own.
 *
 * **On Drive** (the app's hidden folder): one file per year of logs and one "base" file for everything else, each a
 * **version chain**, and one small file per device ("Pixel 8 last synced…").
 *
 * **The version chain** (the protection): every saved version carries an ID reserved for the next one (Drive's
 * `generateIds`). Saving is creating a file with that ID, and Drive refuses a second file with the same ID (409), so
 * a device that loses the race downloads the winner, merges it, and tries the winner's reserved ID. A version is never
 * changed in place, and every version holds everything its predecessor held, so no device can overwrite another.
 * Two devices starting the same file at once make two first versions: every device merges every newest version
 * ("heads"), saves after the longest, and names the others as taken in; those go once a few newer versions exist.
 *
 * **A round:** list the folder (one call) → download and merge each newest version not yet merged here, through the
 * brake → for each file this device has changes for, build it from this device's data and save it through the chain →
 * confirm: only then do the changes it contained leave the outbox (by outbox position) → check in → tidy old versions.
 */
class DriveSync(
    private val repo: HabitRepository,
    private val drive: DriveApi,
    /** Shown on the person's other devices ("Pixel 8"). */
    private val deviceName: String,
    /** "android", "ios", "ipados", "macos". */
    private val platform: String,
    private val clock: () -> Long = ::currentTimeMillis,
    private val pause: suspend (Long) -> Unit = { delay(it) },
    private val random: Random = Random.Default,
) {
    /** Told how many files have been saved, while the person watches a full re-send ([sendEverythingAgain]). */
    private var onSave: ((Int, Int) -> Unit)? = null

    private val store = repo.drive
    private val cloud = repo.cloud
    private val mutex = Mutex()

    /**
     * Starts keeping every change for this Google account ("gdrive:<the account's ID hash>"). The first time, or for
     * another account, everything on this device is queued, and what Drive holds is downloaded and merged before
     * anything goes up, so nothing is replaced by what's (or isn't) there: both merge by ID.
     */
    @Throws(Exception::class)
    suspend fun connect(account: String) {
        require(account.startsWith(ACCOUNT_PREFIX)) { "a Google Drive account is \"$ACCOUNT_PREFIX…\"" }
        if (cloud.account() == account) return
        store.forget()
        cloud.bind(account)
    }

    /**
     * One round (above). [allowUpload] false on a fresh install until its welcome is finished: it downloads and merges,
     * and sends nothing (D4, D14). Never throws for Drive's or the network's problems: they're the status's state.
     */
    @Throws(Exception::class)
    suspend fun syncNow(allowUpload: Boolean = true): DriveStatus = withContext(databaseDispatcher) {
        mutex.withLock {
            val (state, problem) = try {
                round(allowUpload)
            } catch (e: CancellationException) {
                throw e
            } catch (e: DriveError) {
                stateOf(e) to e.message
            } catch (e: Exception) {
                DriveState.PROBLEM to (e.message ?: e::class.simpleName)
            }
            store.setState(STATE, state.name)
            store.setState(PROBLEM, problem)
            status()
        }
    }

    /**
     * **Back up again** (A39): everything this device holds goes up as new records, every year, not only the files
     * that changed. A backup rewrites a file only when something in it changed, so after the Drive copy is deleted
     * the years with nothing new would never be written again and the backup would look whole while missing them.
     * Nothing local changes, and nothing goes up until the person chooses it (the deletion may have been deliberate).
     */
    @Throws(Exception::class)
    suspend fun sendEverythingAgain(progress: (saved: Int, of: Int) -> Unit = { _, _ -> }): DriveStatus {
        store.forget()
        cloud.uploadEverythingAgain()
        onSave = progress
        return try { syncNow() } finally { onSave = null }
    }

    /** The brake (incoming): the person chose to apply the deletes Drive brought (Architecture 11 §13.2). */
    @Throws(Exception::class)
    suspend fun applyHeldDeletes(): DriveStatus {
        store.setState(ALLOW_DELETES, "1")
        return syncNow()
    }

    /** The brake (outgoing): the person said to send this device's deletes. */
    @Throws(Exception::class)
    suspend fun sendWaitingDeletes(): DriveStatus {
        store.setState(DELETES_APPROVED, "1")
        return syncNow()
    }

    /** Where things stand, without asking Drive: the last round's state, what's waiting, and the person's devices. */
    @Throws(Exception::class)
    suspend fun status(): DriveStatus {
        val counts = cloud.counts()
        val state = store.state(STATE)?.let { name -> DriveState.entries.firstOrNull { it.name == name } }
            ?: if (cloud.account()?.startsWith(ACCOUNT_PREFIX) == true) DriveState.SYNCED else DriveState.OFF
        return DriveStatus(
            state = state,
            waiting = counts.waitingOps,
            lastSynced = store.state(LAST_SYNCED)?.toLongOrNull(),
            lastSent = store.state(LAST_SENT)?.toLongOrNull(),
            heldDeletes = store.state(HELD)?.toIntOrNull() ?: 0,
            waitingDeletes = if (state == DriveState.DELETES_WAITING) counts.waitingDeletes else 0,
            devices = store.state(DEVICES)?.let(::decodeDevices) ?: emptyList(),
            problem = store.state(PROBLEM),
        )
    }

    // MARK: A round

    private class Gone : Exception("a file went while it was being read")

    private class Round(val allowUpload: Boolean, val liveAtStart: Int, val allowDeletes: Boolean) {
        var deleted = 0
        var held = false
        var sent = false
        var outgoing = 0
        var blocked = false
        var problem: String? = null
    }

    private suspend fun round(allowUpload: Boolean): Pair<DriveState, String?> {
        if (cloud.account()?.startsWith(ACCOUNT_PREFIX) != true) return DriveState.OFF to null
        // The brake is holding Drive's deletes: nothing else is applied or sent until the person says (D17).
        if (store.state(HELD) != null && store.state(ALLOW_DELETES) != "1") return DriveState.HELD to null
        unblockAfterUpdate()
        repeat(MAX_RESTARTS) {
            val round = Round(allowUpload, cloud.counts().liveRecords, store.state(ALLOW_DELETES) == "1")
            try {
                val listing = Listing(call { drive.list() })
                if (backupRemoved(listing)) return DriveState.REMOVED to null
                if (!pull(listing, round)) return DriveState.HELD to null
                if (round.allowDeletes) {
                    store.setState(ALLOW_DELETES, null)
                    store.setState(HELD, null)
                }
                store.setState(LAST_SYNCED, clock().toString())
                if (allowUpload) {
                    push(listing, round)
                    if (round.held) return DriveState.HELD to null
                    checkIn(listing, round)
                    cleanUp(listing)
                }
                rememberDevices(listing)
                return when {
                    round.outgoing > 0 -> DriveState.DELETES_WAITING
                    round.problem != null -> DriveState.PROBLEM
                    round.blocked -> DriveState.UPDATE_NEEDED
                    !allowUpload -> DriveState.PAUSED
                    else -> DriveState.SYNCED
                } to round.problem
            } catch (_: Gone) {
                // Another device tidied a file away while this one read it: start again from a fresh listing.
            }
        }
        return DriveState.BUSY to "files kept changing during sync"
    }

    /**
     * **A39: is the app's Drive copy gone?** A file this device has saved to or merged from before is no longer
     * there. With nothing saved yet there is nothing to miss: that is a first backup, not a deletion.
     */
    private suspend fun backupRemoved(listing: Listing): Boolean {
        val known = store.states(SEEN).keys.filter(DriveStore::isChain)
        if (known.isEmpty()) return false
        val there = listing.chains().toSet()
        return known.any { it !in there }
    }

    /** Downloads and merges every newest version this device hasn't merged. False when the brake holds one. */
    private suspend fun pull(listing: Listing, round: Round): Boolean {
        for (chain in listing.chains().sortedWith(CHAIN_ORDER)) {
            val seen = seen(chain)
            val merged = mutableSetOf<String>()
            for (head in listing.heads(chain).sortedByDescending { it.seq }) {
                // A version whose successor was merged here is in it already (each version holds its predecessor): the
                // listing lags behind this device's own save.
                if (head.next in seen) {
                    merged += head.next
                    continue
                }
                if (head.id !in seen && !absorb(listing, head, round)) return false
                merged += head.id
            }
            store.setState(SEEN + chain, merged.joinToString(","))
        }
        return true
    }

    /**
     * Downloads [version] and merges it. A damaged one (checksums don't match) is skipped for the newest readable
     * version before it; one from a newer app blocks the file from being written here. False when the brake holds it.
     */
    private suspend fun absorb(listing: Listing, version: Version, round: Round): Boolean {
        var at: Version? = version
        while (at != null) {
            val current: Version = at
            val bytes = try { call { drive.download(current.id) } } catch (_: DriveError.NotFound) { throw Gone() }
            val contents = try {
                DriveSnapshot.read(bytes)
            } catch (p: BackupProblem) {
                if (p.reason == BackupProblem.NEWER_VERSION) {
                    block(current.chain, "format")
                    round.blocked = true
                    return true
                }
                null
            }
            if (contents != null && contents.chain == current.chain) return merge(current.chain, contents.rows, round)
            // Damaged: what it added is still with the device that saved it (not confirmed there), and comes again.
            at = predecessor(listing, current)
        }
        return true
    }

    private suspend fun predecessor(listing: Listing, version: Version): Version? {
        if (version.prev.isEmpty()) return null
        listing.version(version.prev)?.let { return it }
        return call { drive.get(version.prev) }?.let { Version(it) }?.takeIf { it.valid && it.chain == version.chain }
    }

    private suspend fun merge(chain: String, rows: List<SyncRows.Row>, round: Round): Boolean {
        val allowance = if (round.allowDeletes) Int.MAX_VALUE else CloudStore.incomingAllowance(round.liveAtStart, round.deleted)
        val merged = store.merge(chain, rows, allowance)
        if (merged.held) {
            store.setState(HELD, merged.deleted.toString())
            round.held = true
            return false
        }
        round.deleted += merged.deleted
        val held = store.state(ROWS_MERGED + chain)?.toLongOrNull() ?: 0
        if (rows.size > held) store.setState(ROWS_MERGED + chain, rows.size.toString())
        if (merged.unreadable > 0) {
            block(chain, "records")
            round.blocked = true
        }
        if (merged.moved > 0) {
            val before = store.state(MOVED + chain)?.toLongOrNull() ?: 0
            store.setState(MOVED + chain, maxOf(before, merged.moved.toLong()).toString())
            merged.dirty.forEach { store.setState(DIRTY + it, "1") }
        }
        return true
    }

    /** Saves each file this device has changes for, years first (a log moving out of base lands before base drops it). */
    private suspend fun push(listing: Listing, round: Round) {
        val chains = (store.waitingChains() + store.states(DIRTY).keys).filter(DriveStore::isChain).toSet().sortedWith(SAVE_ORDER)
        if (chains.isEmpty()) return
        val counts = cloud.counts()
        // The brake (outgoing): too many of this device's own deletes at once wait for the person (D17).
        if (CloudStore.outgoingBrake(counts.waitingDeletes, counts.liveRecords) && store.state(DELETES_APPROVED) != "1") {
            round.outgoing = counts.waitingDeletes
            return
        }
        var saved = 0
        onSave?.invoke(0, chains.size)
        for (chain in chains) {
            if (store.state(BLOCKED + chain) != null) {
                round.blocked = true
                continue
            }
            if (!save(listing, chain, round)) return
            onSave?.invoke(++saved, chains.size)
        }
        if (cloud.counts().waitingDeletes == 0) store.setState(DELETES_APPROVED, null)
    }

    /** Saves one file through its version chain. False when the brake holds a version met on the way. */
    private suspend fun save(listing: Listing, chain: String, round: Round): Boolean {
        var target = listing.canonical(chain)
        repeat(MAX_CONFLICTS) {
            var seen = seen(chain)
            // A newer version this device already merged (a listing can lag behind): save after that one.
            while (true) {
                val next = target?.next?.takeIf { it in seen } ?: break
                val newer = call { drive.get(next) }?.let { Version(it) }?.takeIf { it.valid && it.chain == chain } ?: throw Gone()
                listing.add(newer.file)
                target = newer
            }
            // The version saved after must be in this device's data first.
            val after = target
            if (after != null && after.id !in seen) {
                if (!absorb(listing, after, round)) return false
                seen = seen + after.id
            }
            val built = store.build(chain)
            val moved = store.state(MOVED + chain)?.toLongOrNull() ?: 0
            val merged = store.state(ROWS_MERGED + chain)?.toLongOrNull() ?: 0
            if (built.rows.size < merged - moved) {
                // Never shrink (D4): a version never holds fewer records than the largest one this device merged into
                // this file (deletes are kept as deletes). Its data is missing something: save nothing, keep the larger.
                round.problem = "shrink:$chain"
                return true
            }
            val id = after?.next ?: freshId()
            val seq = (after?.seq ?: 0) + 1
            val node = cloud.node() ?: "unknown"
            val taken = listing.heads(chain).filter { it.id != after?.id && it.id in seen && !listing.absorbed(chain, it.id) }.take(2)
            val reserved = freshId()
            val properties = buildMap {
                put(KIND, VERSION); put(CHAIN, chain); put(SEQ, seq.toString()); put(NEXT, reserved); put(PREV, after?.id ?: "")
                put(FORMAT, DriveSnapshot.FORMAT.toString()); put(ROWS, built.rows.size.toString()); put(LIVE, built.live.toString())
                put(HABITS, built.habits.toString()); put(BY, node)
                if (taken.isNotEmpty()) put(ABSORBED, taken.joinToString(",") { it.id })
            }
            val bytes = DriveSnapshot.write(chain, seq, built.rows, node, clock())
            val file = try {
                call { drive.create(id, "often-enough-$chain-${seq.toString().padStart(6, '0')}", properties, bytes) }
            } catch (e: DriveError) {
                // Another device saved first (409), or saved and the version was since tidied away (Drive refuses a
                // deleted file's ID with 400): take the winner in and try the one after it, or start again.
                if (e !is DriveError.Conflict && !(e is DriveError.Rejected && e.code == 400)) throw e
                val winner = call { drive.get(id) }?.let { Version(it) }?.takeIf { it.valid && it.chain == chain } ?: throw Gone()
                listing.add(winner.file)
                if (!absorb(listing, winner, round)) return false
                store.setState(SEEN + chain, (seen - (after?.id ?: "") + winner.id).joinToString(","))
                target = winner
                return@repeat
            }
            listing.add(file)
            store.setState(SEEN + chain, (seen - (after?.id ?: "") + file.id).joinToString(","))
            if (file.sha256 != null && file.sha256 != Sha256.hex(bytes)) {
                // Drive stored something else (cut off, changed on the way): not confirmed. The changes stay queued
                // and go in the next save, after this version.
                round.problem = "checksum:$chain"
                return true
            }
            store.confirm(chain, built.upTo)
            store.setState(ROWS_MERGED + chain, built.rows.size.toString())
            store.setState(DIRTY + chain, null)
            store.setState(MOVED + chain, null)
            store.setState(LAST_SENT, clock().toString())
            round.sent = true
            return true
        }
        throw DriveError.RateLimited(null) // saved over and over by other devices: try again next round
    }

    /** This device's own small file: name, platform, when it last checked in and last sent (for the other devices). */
    private suspend fun checkIn(listing: Listing, round: Round) {
        val node = cloud.node() ?: return
        val now = clock()
        val mine = store.state(DEVICE_FILE)?.let { listing.byId[it] } ?: listing.devices.firstOrNull { it.properties[NODE] == node }
        val written = store.state(DEVICE_WRITTEN)?.toLongOrNull() ?: 0
        if (mine != null && !round.sent && now - written < CHECK_IN_EVERY) return
        val sent = store.state(LAST_SENT)
        val properties = buildMap {
            put(KIND, DEVICE); put(NODE, node); put(NAME, deviceName.take(40)); put(PLATFORM, platform.take(20)); put(CHECKED_IN, now.toString())
            sent?.let { put(SENT, it) }
        }
        val file = mine?.let {
            try { call { drive.updateProperties(it.id, properties) } } catch (_: DriveError.NotFound) { null }
        } ?: call { drive.create(freshId(), "often-enough-device-$node", properties, ByteArray(0)) }
        listing.add(file)
        store.setState(DEVICE_FILE, file.id)
        store.setState(DEVICE_WRITTEN, now.toString())
    }

    /**
     * Deletes versions only once [KEEP_VERSIONS] newer ones exist on the main line (each newer one holds it), and a
     * second line (two first versions) once a version that took it in has that many newer ones. A device that was
     * still reading one finds it gone and starts again. A few at a time, so a round stays cheap.
     */
    private suspend fun cleanUp(listing: Listing) {
        var budget = MAX_DELETES
        for (chain in listing.chains().toList()) {
            if (store.state(BLOCKED + chain) != null) continue
            val all = listing.versions[chain] ?: continue
            val head = listing.canonical(chain) ?: continue
            val line = listing.line(chain)
            val absorbedBy = line.filter { head.seq - it.seq >= KEEP_VERSIONS }.flatMap { it.absorbed }.toSet()
            val others = all.values.filter { it.id !in line.map(Version::id) && listing.forkHead(it).id in absorbedBy }
            val old = line.filter { head.seq - it.seq >= KEEP_VERSIONS }
            for (version in others.sortedBy { it.seq } + old.sortedBy { it.seq }) {
                if (budget-- <= 0) return
                call { drive.delete(version.id) }
                listing.remove(version.id)
            }
        }
        val node = cloud.node()
        for (device in listing.devices.toList()) {
            val checkedIn = device.properties[CHECKED_IN]?.toLongOrNull() ?: continue
            if (device.properties[NODE] == node || clock() - checkedIn < FORGET_DEVICE_AFTER) continue
            if (budget-- <= 0) return
            call { drive.delete(device.id) }
            listing.remove(device.id)
        }
    }

    private suspend fun rememberDevices(listing: Listing) {
        val node = cloud.node()
        val devices = listing.devices.mapNotNull { f ->
            val p = f.properties
            DriveDevice(
                node = p[NODE] ?: return@mapNotNull null, name = p[NAME] ?: "", platform = p[PLATFORM] ?: "",
                lastCheckIn = p[CHECKED_IN]?.toLongOrNull() ?: return@mapNotNull null, lastSent = p[SENT]?.toLongOrNull(),
                thisDevice = p[NODE] == node,
            )
        }.sortedByDescending { it.lastCheckIn }
        store.setState(DEVICES, encodeDevices(devices))
    }

    // MARK: Helpers

    private suspend fun seen(chain: String): Set<String> = store.state(SEEN + chain)?.split(',')?.filter { it.isNotEmpty() }?.toSet() ?: emptySet()

    private suspend fun block(chain: String, why: String) = store.setState(BLOCKED + chain, "${DriveSnapshot.FORMAT}:$why")

    /** A file blocked by an older version of this app is read again once the app is newer. */
    private suspend fun unblockAfterUpdate() {
        for ((chain, value) in store.states(BLOCKED)) {
            val format = value.substringBefore(':').toIntOrNull() ?: 0
            if (format < DriveSnapshot.FORMAT) {
                store.setState(BLOCKED + chain, null)
                store.setState(SEEN + chain, null)
            }
        }
    }

    /** An ID Drive reserved for a file not yet made, from a small pool kept on the device (a day at most). */
    private suspend fun freshId(): String {
        val now = clock()
        var pool = store.state(IDS)?.split(',')?.filter { it.isNotEmpty() } ?: emptyList()
        val at = store.state(IDS_AT)?.toLongOrNull() ?: 0
        if (pool.isEmpty() || now - at > ID_LIFETIME || now < at) {
            pool = call { drive.generateIds(ID_BATCH) }
            store.setState(IDS_AT, now.toString())
        }
        store.setState(IDS, pool.drop(1).joinToString(","))
        return pool.first()
    }

    /** Rate limits and Drive's own errors are retried with exponential backoff and jitter; anything else isn't. */
    private suspend fun <T> call(work: suspend () -> T): T {
        var attempt = 0
        while (true) {
            try {
                return work()
            } catch (e: DriveError.RateLimited) {
                if (++attempt > MAX_RETRIES) throw e
                pause(maxOf(e.retryAfterMillis ?: 0, backoff(attempt)))
            } catch (e: DriveError.ServerError) {
                if (++attempt > MAX_RETRIES) throw e
                pause(backoff(attempt))
            }
        }
    }

    private fun backoff(attempt: Int): Long = minOf(MAX_BACKOFF, BASE_BACKOFF shl (attempt - 1)) + random.nextLong(0, BASE_BACKOFF)

    private fun stateOf(e: DriveError): DriveState = when (e) {
        is DriveError.Offline -> DriveState.OFFLINE
        is DriveError.NotConnected -> DriveState.NOT_CONNECTED
        is DriveError.Full -> DriveState.FULL
        is DriveError.RateLimited, is DriveError.ServerError, is DriveError.Conflict, is DriveError.NotFound -> DriveState.BUSY
        is DriveError.Rejected -> DriveState.PROBLEM
    }

    // MARK: What a listing says

    internal class Version(val file: DriveFile) {
        val id = file.id
        val chain = file.properties[CHAIN].orEmpty()
        val seq = file.properties[SEQ]?.toLongOrNull() ?: 0
        val next = file.properties[NEXT].orEmpty()
        val prev = file.properties[PREV].orEmpty()
        val rows = file.properties[ROWS]?.toLongOrNull() ?: 0
        val absorbed = file.properties[ABSORBED]?.split(',')?.filter { it.isNotEmpty() }?.toSet() ?: emptySet()
        val valid = file.properties[KIND] == VERSION && DriveStore.isChain(chain) && seq > 0 && next.isNotEmpty()
    }

    internal class Listing(files: List<DriveFile>) {
        val byId = LinkedHashMap<String, DriveFile>()
        val versions = mutableMapOf<String, MutableMap<String, Version>>()
        val devices = mutableListOf<DriveFile>()

        init { files.forEach(::add) }

        fun add(file: DriveFile) {
            remove(file.id)
            byId[file.id] = file
            when (file.properties[KIND]) {
                VERSION -> Version(file).takeIf { it.valid }?.let { versions.getOrPut(it.chain) { mutableMapOf() }[it.id] = it }
                DEVICE -> devices += file
            }
        }

        fun remove(id: String) {
            byId.remove(id)
            versions.values.forEach { it.remove(id) }
            devices.removeAll { it.id == id }
        }

        fun chains(): Set<String> = versions.filterValues { it.isNotEmpty() }.keys

        fun version(id: String): Version? = versions.values.firstNotNullOfOrNull { it[id] }

        /** The newest versions: those whose reserved next ID no file has taken. Usually one. */
        fun heads(chain: String): List<Version> = versions[chain]?.values?.filter { it.next !in byId }.orEmpty()

        /** The head new versions are saved after: the longest line, then the smallest ID, the same on every device. */
        fun canonical(chain: String): Version? = heads(chain).maxWithOrNull(compareBy<Version> { it.seq }.thenByDescending { it.id })

        /** The canonical head and the versions before it. */
        fun line(chain: String): List<Version> {
            val all = versions[chain] ?: return emptyList()
            val line = LinkedHashMap<String, Version>()
            var at = canonical(chain)
            while (at != null && line.put(at.id, at) == null) at = all[at.prev]
            return line.values.toList()
        }

        /** The newest version on [version]'s own line. */
        fun forkHead(version: Version): Version {
            val all = versions[version.chain] ?: return version
            var at = version
            val visited = mutableSetOf(at.id)
            while (true) {
                val next = all[at.next] ?: return at
                if (!visited.add(next.id)) return at
                at = next
            }
        }

        /** A version some version on the main line already took in. */
        fun absorbed(chain: String, id: String): Boolean = line(chain).any { id in it.absorbed }
    }

    companion object {
        const val ACCOUNT_PREFIX = "gdrive:"

        /** Old versions are deleted once this many newer ones exist. */
        const val KEEP_VERSIONS = 3
        private const val MAX_DELETES = 10
        private const val MAX_RETRIES = 5
        private const val MAX_RESTARTS = 5
        private const val MAX_CONFLICTS = 50
        private const val BASE_BACKOFF = 1_000L
        private const val MAX_BACKOFF = 32_000L
        private const val ID_BATCH = 10
        private const val ID_LIFETIME = 24 * 60 * 60 * 1000L
        /** This device's file is rewritten after a save, or this often anyway (the other devices' "last synced"). */
        const val CHECK_IN_EVERY = 15 * 60 * 1000L
        private const val FORGET_DEVICE_AFTER = 180L * 24 * 60 * 60 * 1000

        // The files' properties (Drive's appProperties: 124 bytes a key and value).
        internal const val KIND = "oe"
        internal const val VERSION = "v"
        internal const val DEVICE = "d"
        internal const val CHAIN = "chain"
        internal const val SEQ = "seq"
        internal const val NEXT = "next"
        internal const val PREV = "prev"
        internal const val FORMAT = "fmt"
        internal const val ROWS = "rows"
        internal const val LIVE = "live"
        internal const val HABITS = "habits"
        internal const val BY = "by"
        internal const val ABSORBED = "abs"
        internal const val NODE = "node"
        internal const val NAME = "name"
        internal const val PLATFORM = "platform"
        internal const val CHECKED_IN = "seen"
        internal const val SENT = "sent"

        // This device's Drive state (`drive.*` in local_state).
        private const val SEEN = "seen."
        private const val DIRTY = "dirty."
        private const val MOVED = "moved."
        private const val BLOCKED = "blocked."
        /** The most records this device has merged from, or saved to, each file: the never-shrink guard's measure. */
        private const val ROWS_MERGED = "rows."
        private const val IDS = "ids"
        private const val IDS_AT = "idsAt"
        private const val DEVICE_FILE = "deviceFile"
        private const val DEVICE_WRITTEN = "deviceWritten"
        private const val DEVICES = "devices"
        private const val LAST_SYNCED = "lastSynced"
        private const val LAST_SENT = "lastSent"
        private const val STATE = "state"
        private const val PROBLEM = "problem"
        private const val HELD = "heldDeletes"
        private const val ALLOW_DELETES = "allowDeletes"
        private const val DELETES_APPROVED = "deletesApproved"

        /** Base first when merging (habits before their logs); years first when saving (see [push]). */
        private val CHAIN_ORDER = compareBy<String> { it != DriveStore.BASE }.thenBy { it }
        private val SAVE_ORDER = compareBy<String> { it == DriveStore.BASE }.thenBy { it }

        private fun encodeDevices(devices: List<DriveDevice>): String = JsonArray(devices.map { d ->
            JsonObject(buildMap {
                put("node", JsonPrimitive(d.node)); put("name", JsonPrimitive(d.name)); put("platform", JsonPrimitive(d.platform))
                put("seen", JsonPrimitive(d.lastCheckIn)); d.lastSent?.let { put("sent", JsonPrimitive(it)) }; put("self", JsonPrimitive(d.thisDevice))
            })
        }).toString()

        private fun decodeDevices(text: String): List<DriveDevice> = runCatching {
            Json.parseToJsonElement(text).jsonArray.map { e ->
                val o = e.jsonObject
                DriveDevice(
                    node = o.getValue("node").jsonPrimitive.content, name = o.getValue("name").jsonPrimitive.content,
                    platform = o.getValue("platform").jsonPrimitive.content, lastCheckIn = o.getValue("seen").jsonPrimitive.longOrNull ?: 0,
                    lastSent = o["sent"]?.jsonPrimitive?.longOrNull, thisDevice = o["self"]?.jsonPrimitive?.booleanOrNull ?: false,
                )
            }
        }.getOrDefault(emptyList())
    }
}

/** What the app shows on the Google Drive page and, when there's something to say, at the end of Today (A6, A7). */
enum class DriveState {
    /** Drive sync isn't on. */
    OFF,
    /** Everything this device has is on Drive, and Drive's newest is here. */
    SYNCED,
    /** A fresh install before its welcome is finished: Drive's data came down; nothing goes up yet (D4, D14). */
    PAUSED,
    /** No network: everything is saved on this device and goes when it's back. */
    OFFLINE,
    /** Signed out, access removed, or the sign-in expired: "Google Drive isn't connected". */
    NOT_CONNECTED,
    /**
     * **The app's files aren't in the person's Drive any more** (A39): they cleared the hidden folder, or another
     * device deleted the backup. Nothing goes up until they choose **Back up again** ([sendEverythingAgain]): a
     * backup saves only the files that changed, so a quiet carry-on would leave the untouched years missing, and the
     * deletion may have been deliberate. Nothing on this phone is touched either way.
     */
    REMOVED,
    /** "Google Drive is full": nothing is lost; it waits. */
    FULL,
    /** Drive asked us to slow down, or had trouble, after several tries: it tries again next time. */
    BUSY,
    /** Deletes from Drive wait for the person (the brake, D17). */
    HELD,
    /** This device's own deletes wait for the person (the brake, D17). */
    DELETES_WAITING,
    /** Another device has a newer app: this one reads what it can and writes nothing it can't keep whole. */
    UPDATE_NEEDED,
    /** Something unexpected; [DriveStatus.problem] says what. Nothing is lost. */
    PROBLEM,
}

data class DriveStatus(
    val state: DriveState,
    /** Changes on this device not yet on Drive. */
    val waiting: Int,
    /** When a round last brought Drive's newest here (epoch ms). */
    val lastSynced: Long?,
    /** When this device last saved to Drive. */
    val lastSent: Long?,
    /** Deletes from Drive the brake holds ([DriveState.HELD]). */
    val heldDeletes: Int,
    /** This device's deletes waiting for the person ([DriveState.DELETES_WAITING]). */
    val waitingDeletes: Int,
    /** Every device on this Google Drive, newest check-in first ("Pixel 8 last synced at 9:14 AM"). */
    val devices: List<DriveDevice>,
    val problem: String?,
)

data class DriveDevice(val node: String, val name: String, val platform: String, val lastCheckIn: Long, val lastSent: Long?, val thisDevice: Boolean)
