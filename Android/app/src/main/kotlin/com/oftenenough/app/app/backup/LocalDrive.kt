package com.oftenenough.app.app.backup

import app.habits.core.DriveApi
import app.habits.core.DriveError
import app.habits.core.DriveFile
import app.habits.core.DriveQuota
import java.io.File
import java.security.MessageDigest
import java.security.SecureRandom
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive
import kotlinx.serialization.json.longOrNull

/**
 * A stand-in for the app's hidden Google Drive folder, kept in a directory on this phone: for debug builds and tests
 * until the Android OAuth client exists (build prompt §5). It answers exactly as Drive does where sync depends on it: a
 * second save under a reserved ID is a [DriveError.Conflict], and a deleted file's ID counts as taken (Rulebook D16).
 */
class LocalDrive(private val folder: File) : DriveApi {
    private val random = SecureRandom()
    private val lock = Any()

    init { folder.mkdirs() }

    private fun meta(id: String) = File(folder, "$id.json")
    private fun content(id: String) = File(folder, "$id.bin")
    private fun taken(id: String) = File(folder, "$id.taken")

    private fun read(id: String): DriveFile? {
        val f = meta(id)
        if (!f.exists()) return null
        val o = Json.parseToJsonElement(f.readText()).jsonObject
        val props = (o["properties"] as? JsonObject)?.mapValues { it.value.jsonPrimitive.content } ?: emptyMap()
        return DriveFile(id, o.getValue("name").jsonPrimitive.content, props, o["size"]?.jsonPrimitive?.longOrNull ?: 0,
            o["createdTime"]?.jsonPrimitive?.longOrNull ?: 0, (o["sha256"] as? JsonPrimitive)?.content)
    }

    private fun write(file: DriveFile) {
        val o = JsonObject(mapOf(
            "name" to JsonPrimitive(file.name), "size" to JsonPrimitive(file.size), "createdTime" to JsonPrimitive(file.createdTime),
            "sha256" to JsonPrimitive(file.sha256 ?: ""), "properties" to JsonObject(file.properties.mapValues { JsonPrimitive(it.value) }),
        ))
        meta(file.id).writeText(o.toString())
    }

    override suspend fun list(): List<DriveFile> = io { folder.listFiles { f -> f.name.endsWith(".json") }.orEmpty().mapNotNull { read(it.name.removeSuffix(".json")) } }

    override suspend fun get(id: String): DriveFile? = io { read(id) }

    override suspend fun generateIds(count: Int): List<String> = io {
        List(count) { val b = ByteArray(16); random.nextBytes(b); "L" + b.joinToString("") { "%02x".format(it) } }
    }

    override suspend fun create(id: String, name: String, properties: Map<String, String>, content: ByteArray): DriveFile = io {
        synchronized(lock) {
            if (taken(id).exists()) throw DriveError.Conflict()
            taken(id).writeText("")
            val digest = MessageDigest.getInstance("SHA-256").digest(content).joinToString("") { "%02x".format(it) }
            content(id).writeBytes(content)
            val file = DriveFile(id, name, properties, content.size.toLong(), System.currentTimeMillis(), digest)
            write(file)
            file
        }
    }

    override suspend fun updateProperties(id: String, properties: Map<String, String>): DriveFile = io {
        synchronized(lock) {
            val file = read(id) ?: throw DriveError.NotFound()
            file.copy(properties = file.properties + properties).also(::write)
        }
    }

    override suspend fun download(id: String): ByteArray = io {
        val f = content(id)
        if (!meta(id).exists() || !f.exists()) throw DriveError.NotFound()
        f.readBytes()
    }

    override suspend fun delete(id: String) = io {
        synchronized(lock) { meta(id).delete(); content(id).delete() }
        Unit
    }

    override suspend fun quota(): DriveQuota = io { DriveQuota(null, folder.listFiles().orEmpty().sumOf { it.length() }) }

    /** Everything gone, IDs included (Delete my data from Google Drive, for the stand-in). */
    fun clear() { folder.listFiles().orEmpty().forEach { it.delete() } }

    private suspend fun <T> io(work: () -> T): T = withContext(Dispatchers.IO) { work() }
}
