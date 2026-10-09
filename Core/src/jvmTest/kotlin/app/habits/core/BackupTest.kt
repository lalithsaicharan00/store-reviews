package app.habits.core

import java.io.ByteArrayInputStream
import java.io.File
import java.security.MessageDigest
import java.util.Base64
import java.util.zip.ZipInputStream
import kotlin.random.Random
import kotlin.test.AfterTest
import kotlin.test.Test
import kotlin.test.assertContentEquals
import kotlin.test.assertEquals
import kotlin.test.assertFailsWith
import kotlin.test.assertNull
import kotlin.test.assertTrue
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive
import kotlinx.serialization.json.long

/**
 * The checked backup file and restore (Architecture 03 §3.2, §3.6): every check a file must pass before anything is
 * changed, what Replace and Merge do, undo, and that a restore on a synced device reaches the other devices.
 */
class BackupTest {
    private val dir = File(System.getProperty("java.io.tmpdir"), "habits-backup-${System.nanoTime()}").apply { mkdirs() }
    private val info = BackupInfo("Lalith’s iPhone", "ios", "1.0")
    private var wall = 1_790_000_000_000L
    private val opened = mutableListOf<HabitRepository>()

    @AfterTest fun cleanUp() {
        opened.forEach { it.close() }
        dir.deleteRecursively()
    }

    private fun repo(name: String) = HabitRepository.open(File(dir, "$name.db").path) { wall }.also { opened += it }

    private fun habit(id: String, name: String = "Water", updatedAt: Long = 1_000) = HabitRecord(
        id = id, name = name, symbol = "drop.fill", color = "blue", kind = "amount", unit = "glasses", increment = 1.0,
        part = "anytime", goal = 8.0, period = "day", scheduleDays = null, frequency = "daily", dueDay = null, dueMinute = null,
        atMost = false, quitSince = null, position = 0, createdAt = 1_000, updatedAt = updatedAt, archivedAt = null, deletedAt = null,
    )

    private fun entry(id: String, habitId: String, day: String = "2026-10-01", value: Double = 1.0) =
        EntryRecord(id, habitId, null, day, value, 2_000, "Europe/London", null, null)

    /** A device with a bit of everything: two habits (one with a step and a time), logs, an undone log, settings. */
    private suspend fun HabitRepository.fill() {
        saveHabit(habit("h1"), listOf(StepRecord("s1", "h1", "Fill bottle", 0, null)), listOf(ReminderRecord("r1", "h1", 9, 30, null)), 1)
        saveHabit(habit("h2", "=Read, \"slowly\"\nnow"), emptyList(), emptyList(), 1)
        addEntry(entry("e1", "h1"))
        addEntry(entry("e2", "h1", "2026-10-02", 3.0))
        addEntry(entry("e3", "h2"))
        removeEntry("e3", 3_000)
        saveSetting("week_start", "2")
        saveSetting("note.h1|2026-10-01", "Felt great ☀️")
        saveSetting("placement_v2", "done") // local to this device: never in a backup
    }

    /** What a person sees: habit names, logs (habit name, day, value) and settings, ignoring IDs. */
    private fun HabitRepository.content() = runBlocking {
        val s = load()
        val names = s.habits.associate { it.id to it.name }
        Triple(
            s.habits.map { it.name }.sorted(),
            s.entries.map { Triple(names[it.habitId], it.day, it.value) }.sortedBy { it.toString() },
            s.settings.filterNot { it.key.startsWith("placement") }.map { it.key.replace(Regex("^note\\.[^|]+"), "note.") to it.value }.sortedBy { it.first },
        )
    }

    private fun bytes(file: BackupFileData) = Base64.getDecoder().decode(file.base64)
    private fun base64(bytes: ByteArray) = Base64.getEncoder().encodeToString(bytes)

    // MARK: The file

    @Test fun theFileIsAPlainZipAnyToolCanOpen() = runBlocking {
        val phone = repo("phone").apply { fill() }
        val file = phone.backupFile(info)
        val entries = mutableMapOf<String, ByteArray>()
        ZipInputStream(ByteArrayInputStream(bytes(file))).use { zip ->
            while (true) { val e = zip.nextEntry ?: break; entries[e.name] = zip.readBytes() } // the JVM checks every CRC
        }
        assertEquals(setOf("manifest.json", "data.json", "csv/habits.csv", "csv/steps.csv", "csv/times.csv", "csv/logs.csv", "csv/settings.csv"), entries.keys)
        val manifest = Json.parseToJsonElement(entries.getValue("manifest.json").decodeToString()).jsonObject
        assertEquals(1, manifest.getValue("format").jsonPrimitive.content.toInt())
        assertEquals("Lalith’s iPhone", manifest.getValue("deviceName").jsonPrimitive.content)
        assertEquals(wall, manifest.getValue("createdAt").jsonPrimitive.long)
        val dataHash = MessageDigest.getInstance("SHA-256").digest(entries.getValue("data.json")).joinToString("") { "%02x".format(it) }
        assertEquals(dataHash, manifest.getValue("data").jsonObject.getValue("sha256").jsonPrimitive.content)
        // Counts every row, deleted ones too; the local-only setting is left out.
        assertEquals(2 to 2, file.habits to file.entries)
        assertEquals(2 + 1 + 1 + 3 + 2, file.records)
        assertTrue("placement_v2" !in entries.getValue("data.json").decodeToString())
        // Readable CSV: quoted when needed, formulas defused, logs carry their habit's name.
        val habits = entries.getValue("csv/habits.csv").decodeToString()
        assertTrue("\"'=Read, \"\"slowly\"\"\nnow\"" in habits, habits)
        assertTrue(entries.getValue("csv/logs.csv").decodeToString().lines()[1].startsWith("e1,Water,h1,"))
        assertTrue("e3,\"'=Read," in entries.getValue("csv/logs.csv").decodeToString())
        assertEquals(MessageDigest.getInstance("SHA-256").digest(bytes(file)).joinToString("") { "%02x".format(it) }, file.sha256)
    }

    @Test fun sha256MatchesTheJvms() {
        val random = Random(7)
        for (size in listOf(0, 1, 55, 56, 63, 64, 65, 119, 120, 1000, 100_000)) {
            val data = random.nextBytes(size)
            val expected = MessageDigest.getInstance("SHA-256").digest(data).joinToString("") { "%02x".format(it) }
            assertEquals(expected, Sha256.hex(data), "size $size")
        }
    }

    @Test fun aFileRoundTripsEveryRowIncludingDeletedOnes() = runBlocking {
        val phone = repo("phone").apply { fill() }
        val contents = BackupFile.read(phone.backupFile(info).base64)
        val all = phone.loadForRestore()
        assertEquals(all.habits.sortedBy { it.id }, contents.snapshot.habits.sortedBy { it.id })
        assertEquals(all.entries.sortedBy { it.id }, contents.snapshot.entries.sortedBy { it.id })
        assertEquals(all.steps, contents.snapshot.steps)
        assertEquals(all.reminders, contents.snapshot.reminders)
        assertEquals(all.settings.filterNot { it.key == "placement_v2" }.sortedBy { it.key }, contents.snapshot.settings.sortedBy { it.key })
        assertEquals("Lalith’s iPhone" to "ios", contents.deviceName to contents.platform)
    }

    /** "Reminder says…" (schema 8, Current Work 58) goes into the file and comes back with a restore (D5). */
    @Test fun reminderWordsRoundTripThroughAFileAndARestore() = runBlocking {
        val phone = repo("phone").apply {
            fill()
            saveHabit(habit("h3", "Meds").copy(reminderText = "The usual"), emptyList(), listOf(ReminderRecord("r3", "h3", 8, 0, null)), 1)
        }
        val file = phone.backupFile(info)
        assertEquals("The usual", BackupFile.read(file.base64).snapshot.habits.single { it.id == "h3" }.reminderText)
        val newPhone = repo("new-phone")
        newPhone.restore(file.base64, RestoreMode.REPLACE, info)
        assertEquals("The usual", newPhone.load().habits.single { it.name == "Meds" }.reminderText)
        assertEquals(null, newPhone.load().habits.single { it.name == "Water" }.reminderText)
    }

    // MARK: Checks before anything changes

    @Test fun aDamagedFileIsRefusedAndNothingChanges() = runBlocking {
        val source = repo("source").apply { fill() }
        val good = bytes(source.backupFile(info))
        val target = repo("target").apply { saveHabit(habit("mine", "Walk"), emptyList(), emptyList(), 1) }
        val before = target.content()

        // One byte flipped inside data.json: the zip's CRC catches it.
        val flipped = good.copyOf().also { val at = String(it, Charsets.ISO_8859_1).indexOf("Fill bottle"); it[at] = 'X'.code.toByte() }
        assertEquals(BackupProblem.DAMAGED, target.checkBackup(base64(flipped)).problem)
        assertEquals(BackupProblem.DAMAGED, assertFailsWith<BackupProblem> { target.restore(base64(flipped), RestoreMode.REPLACE, info) }.reason)

        // data.json changed and its CRC fixed up (a careful edit): the manifest's SHA-256 still catches it.
        val edited = rezip(good) { name, data -> if (name == "data.json") data.decodeToString().replace("Fill bottle", "Fill bottlX").encodeToByteArray() else data }
        assertEquals(BackupProblem.DAMAGED, target.checkBackup(base64(edited)).problem)

        // The counts don't match the manifest (a row lost).
        val shortened = rezipWithManifestFixed(good) { it.replace(Regex(""",\{"id":"e2"[^}]*\}"""), "") }
        assertEquals(BackupProblem.DAMAGED, target.checkBackup(base64(shortened)).problem)

        // A log for a habit that isn't in the file.
        val orphan = rezipWithManifestFixed(good) { it.replace("\"habit_id\":\"h2\"", "\"habit_id\":\"nope\"") }
        assertEquals(BackupProblem.DAMAGED, target.checkBackup(base64(orphan)).problem)

        // Cut short, as a half-finished download.
        assertEquals(BackupProblem.NOT_A_BACKUP, target.checkBackup(base64(good.copyOf(good.size / 2))).problem)
        assertEquals(BackupProblem.NOT_A_BACKUP, target.checkBackup(base64(Random(1).nextBytes(5000))).problem)
        assertEquals(BackupProblem.NOT_A_BACKUP, target.checkBackup("not base64 at all ☃").problem)

        assertEquals(before, target.content())
    }

    @Test fun aFileFromANewerAppSaysUpdateFirst() = runBlocking {
        val good = bytes(repo("source").apply { fill() }.backupFile(info))
        val newer = rezip(good) { name, data -> if (name == "manifest.json") data.decodeToString().replace("\"format\":1", "\"format\":${BackupFile.NEWEST_FORMAT + 1}").encodeToByteArray() else data }
        assertEquals(BackupProblem.NEWER_VERSION, repo("target").checkBackup(base64(newer)).problem)
    }

    @Test fun aFileZippedAgainByAnotherAppSaysUseTheOriginal() = runBlocking {
        val good = bytes(repo("source").apply { fill() }.backupFile(info))
        val out = java.io.ByteArrayOutputStream()
        java.util.zip.ZipOutputStream(out).use { zip -> // deflated, as Finder or Windows would zip it
            ZipInputStream(ByteArrayInputStream(good)).use { input ->
                while (true) { val e = input.nextEntry ?: break; zip.putNextEntry(java.util.zip.ZipEntry(e.name)); zip.write(input.readBytes()); zip.closeEntry() }
            }
        }
        assertEquals(BackupProblem.REPACKED, repo("target").checkBackup(base64(out.toByteArray())).problem)
    }

    /**
     * The automatic backups (iCloud, the account) leave out the CSV copies (Current Work 75, Free Plan Backups §7 step 2):
     * the same format, read and restored exactly as the full file, and measured here on a realistic history. Sizes are
     * printed for PERFORMANCE-LESSONS / the checklist.
     */
    @Test fun theAutomaticFileIsSmallerAndRestoresTheSame() = runBlocking {
        val phone = repo("phone").apply { fill() }
        val full = phone.backupFile(info)
        val auto = phone.automaticBackupFile(info)
        val names = mutableListOf<String>()
        ZipInputStream(ByteArrayInputStream(bytes(auto))).use { zip -> while (true) { names += (zip.nextEntry ?: break).name } }
        assertEquals(listOf(BackupFile.MANIFEST, BackupFile.DATA), names)
        assertEquals(full.records, auto.records)
        assertEquals(BackupFile.FORMAT_COMPACT, auto.format)
        assertEquals(BackupFile.FORMAT, full.format)
        // Any unzip tool opens it too (java.util.zip inflates data.json and checks its CRC).
        ZipInputStream(ByteArrayInputStream(bytes(auto))).use { zip ->
            while (true) { val e = zip.nextEntry ?: break; if (e.name == BackupFile.DATA) assertTrue(zip.readBytes().decodeToString().startsWith("{")) }
        }
        assertNull(repo("check").checkBackup(auto.base64).problem)
        val target = repo("target")
        target.restore(auto.base64, RestoreMode.REPLACE, info)
        assertEquals(phone.content(), target.content())

        // A year of history: 30 habits, about 712 check-ins (the 8 Oct dev copy) and a heavier one, 12 habits × 365 days.
        for ((label, habits, perHabit) in listOf(Triple("30 habits, 720 check-ins", 30, 24), Triple("12 habits, 4380 check-ins", 12, 365))) {
            val big = repo("big-$habits")
            repeat(habits) { h ->
                big.saveHabit(habit("hb$h", "Habit number $h"), emptyList(), listOf(ReminderRecord("rb$h", "hb$h", 8, 0, null)), 1)
                repeat(perHabit) { d ->
                    val day = java.time.LocalDate.of(2025, 10, 1).plusDays(d.toLong()).toString()
                    big.addEntry(entry("eb$h-$d", "hb$h", day, 1.0 + d % 3))
                }
            }
            val readable = bytes(big.backupFile(info)).size
            val automatic = bytes(big.automaticBackupFile(info)).size
            val gz = java.io.ByteArrayOutputStream().also { out -> java.util.zip.GZIPOutputStream(out).use { it.write(bytes(big.automaticBackupFile(info))) } }.size()
            println("BACKUP SIZE $label: full ${readable / 1024} KB, automatic ${automatic / 1024} KB (${100 * automatic / readable}%), automatic gzipped again ${gz / 1024} KB")
            assertTrue(automatic < readable * 0.25, "$label: automatic $automatic vs full $readable")
        }
    }

    /** A compact file whose other entries were deflated, or with a deflated data.json under format 1, is refused. */
    @Test fun onlyTheCompactFormatsDataIsDeflated() = runBlocking {
        val auto = bytes(repo("phone").apply { fill() }.automaticBackupFile(info))
        val files = Zip.read(auto).files
        val rezipped = Zip.write(files.map { (name, data) -> Zip.Entry(name, data, deflate = true) }, wall)
        assertEquals(BackupProblem.REPACKED, repo("target").checkBackup(base64(rezipped)).problem)
        val asFormat1 = Zip.write(listOf(
            Zip.Entry(BackupFile.MANIFEST, files.getValue(BackupFile.MANIFEST).decodeToString().replace("\"format\":2", "\"format\":1").encodeToByteArray()),
            Zip.Entry(BackupFile.DATA, files.getValue(BackupFile.DATA), deflate = true),
        ), wall)
        assertEquals(BackupProblem.REPACKED, repo("target2").checkBackup(base64(asFormat1)).problem)
        val newer = Zip.write(listOf(
            Zip.Entry(BackupFile.MANIFEST, files.getValue(BackupFile.MANIFEST).decodeToString().replace("\"format\":2", "\"format\":3").encodeToByteArray()),
            Zip.Entry(BackupFile.DATA, files.getValue(BackupFile.DATA), deflate = true),
        ), wall)
        assertEquals(BackupProblem.NEWER_VERSION, repo("target3").checkBackup(base64(newer)).problem)
    }

    /** Our DEFLATE against the JVM's zlib, both ways, on text, repeats, random bytes and nothing at all. */
    @Test fun deflateMatchesZlibBothWays() {
        val random = Random(7)
        val samples = listOf(
            ByteArray(0),
            "a".encodeToByteArray(),
            "{\"habit\":[{\"id\":\"h1\",\"name\":\"Water\"}]}".repeat(500).encodeToByteArray(),
            ByteArray(100_000) { 'x'.code.toByte() },
            ByteArray(70_000) { random.nextInt(256).toByte() },
            ByteArray(200_000) { (random.nextInt(20) + 'a'.code).toByte() },
        )
        for (sample in samples) {
            // Ours → zlib.
            val ours = Deflate.compress(sample)
            val inflater = java.util.zip.Inflater(true)
            inflater.setInput(ours)
            val out = ByteArray(sample.size + 1)
            val n = if (sample.isEmpty()) inflater.inflate(out) else generateSequence { 0 }.let { var total = 0; while (!inflater.finished() && total <= sample.size) { val k = inflater.inflate(out, total, out.size - total); if (k == 0 && inflater.needsInput()) break; total += k }; total }
            assertTrue(inflater.finished(), "zlib reads ours to the end")
            assertContentEquals(sample, out.copyOf(n))
            assertContentEquals(sample, Deflate.decompress(ours, sample.size))
            // zlib → ours, at every level (stored blocks at 0, dynamic Huffman above).
            for (level in listOf(0, 1, 6, 9)) {
                val deflater = java.util.zip.Deflater(level, true)
                deflater.setInput(sample); deflater.finish()
                val buffer = ByteArray(sample.size * 2 + 1024)
                val size = deflater.deflate(buffer)
                assertContentEquals(sample, Deflate.decompress(buffer.copyOf(size), sample.size), "level $level, ${sample.size} bytes")
            }
        }
        val text = samples[2]
        val packed = Deflate.compress(text)
        assertFailsWith<BackupProblem> { Deflate.decompress(packed.copyOf(packed.size / 2), text.size) }
        assertFailsWith<BackupProblem> { Deflate.decompress(packed, text.size - 1) }
        assertFailsWith<BackupProblem> { Deflate.decompress(packed, text.size + 1) }
        assertFailsWith<BackupProblem> { Deflate.decompress(byteArrayOf(0x07), 10) }
    }

    /** Every app version reads every older format (03 §3.2): the first file ever written stays readable. */
    @Test fun format1SampleStillReads() = runBlocking {
        val sample = File("src/jvmTest/resources/backups/format-1.zip")
        if (!sample.exists() && System.getenv("WRITE_BACKUP_SAMPLE") == "1") {
            sample.parentFile.mkdirs()
            sample.writeBytes(bytes(repo("sample").apply { fill() }.backupFile(info)))
        }
        val contents = BackupFile.read(sample.readBytes())
        assertEquals(1, contents.format)
        assertEquals(listOf("=Read, \"slowly\"\nnow", "Water"), contents.snapshot.habits.map { it.name }.sorted())
        assertEquals(3, contents.snapshot.entries.size)
        val target = repo("target")
        target.restore(base64(sample.readBytes()), RestoreMode.REPLACE, info)
        assertEquals(2, target.load().habits.size)
    }

    // MARK: Preview

    /** The compact automatic backup (format 2, 10 Oct 2026) stays readable by every later version. */
    @Test fun format2SampleStillReads() = runBlocking {
        val sample = File("src/jvmTest/resources/backups/format-2.zip")
        if (!sample.exists() && System.getenv("WRITE_BACKUP_SAMPLE") == "1") {
            sample.parentFile.mkdirs()
            sample.writeBytes(bytes(repo("sample").apply { fill() }.automaticBackupFile(info)))
        }
        val contents = BackupFile.read(sample.readBytes())
        assertEquals(2, contents.format)
        assertEquals(listOf("=Read, \"slowly\"\nnow", "Water"), contents.snapshot.habits.map { it.name }.sorted())
        assertEquals(3, contents.snapshot.entries.size)
        val target = repo("target")
        target.restore(base64(sample.readBytes()), RestoreMode.REPLACE, info)
        assertEquals(2, target.load().habits.size)
    }

    // MARK: Preview

    @Test fun thePreviewSaysWhatEachChoiceWouldDo() = runBlocking {
        val source = repo("source").apply { fill() }
        val file = source.backupFile(info)
        val target = repo("target").apply {
            saveHabit(habit("mine", "Walk"), emptyList(), emptyList(), 1)
            addEntry(entry("m1", "mine"))
        }
        val check = target.checkBackup(file.base64)
        assertNull(check.problem)
        val preview = check.preview!!
        assertEquals(Triple("Lalith’s iPhone", 2, 2), Triple(preview.deviceName, preview.fileHabits, preview.fileEntries))
        assertEquals(1 to 1, preview.phoneHabits to preview.phoneEntries)
        assertEquals(RestoreChanges(habitsAdded = 2, habitsRemoved = 1, habitsUpdated = 0, entriesAdded = 2, entriesRemoved = 1, settingsChanged = 2), preview.replace)
        assertEquals(RestoreChanges(habitsAdded = 2, habitsRemoved = 0, habitsUpdated = 0, entriesAdded = 2, entriesRemoved = 0, settingsChanged = 2), preview.merge)

        val result = target.restore(file.base64, RestoreMode.MERGE, info)
        assertEquals(preview.merge, result.changes)
        // Restoring the same file again: nothing new, and the preview says so.
        val again = target.checkBackup(file.base64).preview!!
        assertTrue(again.merge.changesNothing)
    }

    // MARK: Merge

    @Test fun mergeAddsWhatsMissingAndNeverRemovesAnything() = runBlocking {
        val source = repo("source").apply { fill() }
        val file = source.backupFile(info)
        val target = repo("target").apply {
            saveHabit(habit("mine", "Walk"), emptyList(), emptyList(), 1)
            addEntry(entry("m1", "mine"))
            saveSetting("week_start", "1") // set here: kept
        }
        target.restore(file.base64, RestoreMode.MERGE, info)
        val s = target.load()
        assertEquals(listOf("=Read, \"slowly\"\nnow", "Walk", "Water"), s.habits.map { it.name }.sorted())
        assertEquals(setOf("m1", "e1", "e2"), s.entries.map { it.id }.toSet()) // e3 was undone in the backup: stays undone
        assertEquals("1", s.settings.single { it.key == "week_start" }.value)
        assertEquals(listOf("s1"), s.steps.map { it.id })
    }

    @Test fun mergeTakesTheNewerEditAndADeleteHereStays() = runBlocking {
        val source = repo("source").apply { fill() }
        wall += 60_000
        source.saveHabit(habit("h1", "Drink water", updatedAt = 5_000), emptyList(), emptyList(), 5_000)
        val file = source.backupFile(info)

        val target = repo("target")
        target.restore(repo("old").apply { fill() }.backupFile(info).base64, RestoreMode.REPLACE, info)
        target.saveHabit(habit("h2", "Read more", updatedAt = 9_000), emptyList(), emptyList(), 9_000) // newer here
        target.saveHabit(habit("h1").copy(deletedAt = 4_000), emptyList(), emptyList(), 4_000)
        val result = target.restore(file.base64, RestoreMode.MERGE, info)
        val names = target.load().habits.map { it.name }
        assertEquals(listOf("Read more"), names) // h1 deleted here stays deleted; h2 here is newer
        assertEquals(0, result.changes.habitsUpdated)

        val third = repo("third").apply { fill() }
        assertEquals(1, third.restore(file.base64, RestoreMode.MERGE, info).changes.habitsUpdated)
        assertTrue("Drink water" in third.load().habits.map { it.name })
    }

    // MARK: Replace and undo

    @Test fun replaceMakesThisDeviceExactlyTheBackupEvenBringingBackDeletedHabits() = runBlocking {
        val phone = repo("phone").apply { fill() }
        val lastNight = phone.backupFile(info)
        val expected = phone.content()
        // The next day: a habit deleted by mistake (with its logs), a new one added, a setting changed.
        wall += 86_400_000
        phone.saveHabit(habit("h1").copy(deletedAt = wall), emptyList(), emptyList(), wall)
        phone.removeEntry("e1", wall)
        phone.saveHabit(habit("new", "Stretch"), emptyList(), emptyList(), wall)
        phone.saveSetting("week_start", "1")
        phone.removeSetting("note.h1|2026-10-01")

        val preview = phone.checkBackup(lastNight.base64).preview!!
        assertEquals(1 to 1, preview.replace.habitsAdded to preview.replace.habitsRemoved)
        val result = phone.restore(lastNight.base64, RestoreMode.REPLACE, info)
        assertEquals(preview.replace, result.changes)
        assertEquals(expected, phone.content())
        // The habit that came back is whole: its step, its time and its note, under its new ID.
        val water = phone.load().habits.single { it.name == "Water" }
        assertTrue(water.id != "h1")
        assertEquals(water.id, phone.load().steps.single().habitId)
        assertEquals(water.id, phone.load().reminders.single().habitId)
        assertTrue(phone.load().settings.any { it.key == "note.${water.id}|2026-10-01" })
        // Restoring the same file again changes nothing.
        assertTrue(phone.checkBackup(lastNight.base64).preview!!.replace.changesNothing)
    }

    @Test fun undoReturnsExactlyThePriorState() = runBlocking {
        val phone = repo("phone").apply { fill() }
        val other = repo("other").apply {
            saveHabit(habit("o1", "Meditate"), emptyList(), emptyList(), 1)
            addEntry(entry("o-e1", "o1"))
        }
        val before = phone.content()
        val result = phone.restore(other.backupFile(info).base64, RestoreMode.REPLACE, info)
        assertEquals(other.content().first, phone.content().first)
        phone.restore(result.undo.base64, RestoreMode.REPLACE, info)
        assertEquals(before, phone.content())
    }

    // MARK: Sync

    @Test fun aRestoreOnASyncedDeviceReachesTheOtherDevices() = runBlocking {
        val server = FakeServer()
        val phone = repo("phone").apply { bindAccount("acct"); fill() }
        val ipad = repo("ipad").apply { bindAccount("acct") }
        suspend fun HabitRepository.sync(device: String) { while (acceptSyncReply(server.handle(device, syncRequest()))) { } }
        phone.sync("phone"); ipad.sync("ipad")
        val lastNight = phone.backupFile(info)
        wall += 86_400_000
        phone.saveHabit(habit("h1").copy(deletedAt = wall), emptyList(), emptyList(), wall)
        phone.sync("phone"); ipad.sync("ipad")
        assertEquals(1, ipad.load().habits.size)

        phone.restore(lastNight.base64, RestoreMode.REPLACE, info)
        phone.sync("phone"); ipad.sync("ipad")
        assertEquals(phone.content(), ipad.content())
        assertEquals(2, ipad.load().habits.size)
    }

    // MARK: Erasing

    @Test fun eraseLeavesNothingAndTheDeviceStartsAfresh() = runBlocking {
        val phone = repo("phone").apply { bindAccount("acct"); fill() }
        phone.eraseAllData()
        assertEquals(Snapshot(emptyList(), emptyList(), emptyList(), emptyList(), emptyList()), phone.loadForRestore())
        val status = phone.syncStatus()
        assertEquals(null to 0, status.accountId to status.waiting) // no account, nothing waiting to go anywhere
        // It works as on first launch, and nothing reaches the old account.
        phone.saveHabit(habit("new", "Fresh start"), emptyList(), emptyList(), 1)
        assertEquals(listOf("Fresh start"), phone.load().habits.map { it.name })
        assertTrue(Json.parseToJsonElement(phone.syncRequest()).jsonObject.getValue("ops").toString() == "[]")
    }

    // MARK: Helpers

    /** Rewrites a backup's entries and zips it again the way BackupFile does (stored, fresh CRCs). */
    private fun rezip(file: ByteArray, change: (String, ByteArray) -> ByteArray): ByteArray {
        val entries = Zip.read(file).files.map { (name, data) -> Zip.Entry(name, change(name, data)) }
        return Zip.write(entries, wall)
    }

    /** Edits data.json and updates the manifest's hash to match, so only the deeper checks can catch the edit. */
    private fun rezipWithManifestFixed(file: ByteArray, edit: (String) -> String): ByteArray {
        val files = Zip.read(file).files
        val data = edit(files.getValue("data.json").decodeToString()).encodeToByteArray()
        val manifest = files.getValue("manifest.json").decodeToString()
            .replace(Regex("\"sha256\":\"[0-9a-f]{64}\""), "\"sha256\":\"${Sha256.hex(data)}\"")
        return Zip.write(listOf(Zip.Entry("manifest.json", manifest.encodeToByteArray()), Zip.Entry("data.json", data)), wall)
    }
}
