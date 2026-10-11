package app.habits.core

import kotlin.coroutines.cancellation.CancellationException
import kotlin.random.Random
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.contentOrNull
import kotlinx.serialization.json.jsonArray
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive
import kotlinx.serialization.json.longOrNull

/*
 * Google Drive sync's two seams (Android/Docs, "Google Drive Sync — Download, Merge, Upload, and the Version Chain"):
 *
 * - [DriveApi]: the few Drive calls sync makes, all in the app's hidden folder (`appDataFolder`, scope
 *   `drive.appdata`). [DriveSync] uses only this, so tests run it against a stand-in Drive.
 * - [DriveHttp] and [DriveTokens]: what each platform supplies (plain HTTP and an access token from its own sign-in).
 *   [GoogleDrive] speaks Drive's REST protocol over them, here in the core, so every platform reads Drive's answers
 *   and errors the same way (the Shared Core Decision keeps HTTP itself with the platform).
 */

/** One file in the app's hidden Drive folder, as a listing shows it. [createdTime] is epoch ms. */
data class DriveFile(
    val id: String,
    val name: String,
    val properties: Map<String, String>,
    val size: Long,
    val createdTime: Long,
    /** Drive's own SHA-256 of what it stored (hex), when it gave one. */
    val sha256: String?,
)

/** How much of the person's Google storage is used and how much there is (bytes); [limit] is null when unlimited. */
data class DriveQuota(val limit: Long?, val usage: Long)

/** Why a Drive call didn't do what was asked. Each one is a state the app can show (see [DriveState]). */
sealed class DriveError(message: String, cause: Throwable? = null) : Exception(message, cause) {
    /** No answer came: no network, timed out, or cut off half-way. Nothing is lost; sync waits. */
    class Offline(cause: Throwable? = null) : DriveError("offline", cause)
    /** Signed out, access removed, or the refresh token expired (`invalid_grant`): "Google Drive isn't connected". */
    class NotConnected(val reason: String) : DriveError("not connected: $reason")
    /** 403 `storageQuotaExceeded`: "Google Drive is full". */
    class Full : DriveError("storage full")
    /** 403 rate limits or 429: retried with backoff; [retryAfterMillis] when Drive said how long. */
    class RateLimited(val retryAfterMillis: Long?) : DriveError("rate limited")
    /** 5xx: retried with backoff. */
    class ServerError(val code: Int) : DriveError("server error $code")
    /** 409: a file with this ID already exists (the version chain: another device saved first). */
    class Conflict : DriveError("conflict")
    /** 404: the file is gone (cleaned up by another device). */
    class NotFound : DriveError("not found")
    /** Anything else Drive refused (a bug on our side): not retried. */
    class Rejected(val code: Int, val reason: String) : DriveError("rejected $code $reason")
}

/** The Drive calls sync makes. Every file is in `appDataFolder`; nothing here ever touches the person's own files. */
interface DriveApi {
    /** Every file in the app's folder, with its properties (one cheap call: a few dozen small files). */
    @Throws(Exception::class)
    suspend fun list(): List<DriveFile>

    /** One file's details, or null if it's gone. */
    @Throws(Exception::class)
    suspend fun get(id: String): DriveFile?

    /** IDs Drive reserves for files not yet made (`files.generateIds`, space `appDataFolder`). */
    @Throws(Exception::class)
    suspend fun generateIds(count: Int): List<String>

    /** Makes a file with the given ID. Throws [DriveError.Conflict] if a file with that ID exists: only one save wins. */
    @Throws(Exception::class)
    suspend fun create(id: String, name: String, properties: Map<String, String>, content: ByteArray): DriveFile

    /** Changes a file's properties. Used only for this device's own small device file, which no one else writes. */
    @Throws(Exception::class)
    suspend fun updateProperties(id: String, properties: Map<String, String>): DriveFile

    /** A file's content. Throws [DriveError.NotFound] if it's gone. */
    @Throws(Exception::class)
    suspend fun download(id: String): ByteArray

    /** Deletes a file; one already gone is fine. */
    @Throws(Exception::class)
    suspend fun delete(id: String)

    @Throws(Exception::class)
    suspend fun quota(): DriveQuota
}

/** A short-lived access token for `drive.appdata`, from the platform's own Google sign-in. */
interface DriveTokens {
    /** [refresh]: the last token was refused, so don't hand it out again. Throws [DriveError.NotConnected] when no
     *  token can be had (signed out, access removed, refresh token expired). */
    @Throws(Exception::class)
    suspend fun accessToken(refresh: Boolean): String
}

/** One HTTP request, as the platform's HTTP client sends it. */
class DriveRequest(val method: String, val url: String, val headers: Map<String, String>, val body: ByteArray?)

/** The answer. Header names are lower case. */
class DriveResponse(val status: Int, val headers: Map<String, String>, val body: ByteArray)

/** Plain HTTPS, from the platform (java.net.http on the JVM, OkHttp on Android, URLSession on Apple devices). */
interface DriveHttp {
    /** Sends one request. Throws only when no answer came at all (offline, timed out, cut off). */
    @Throws(Exception::class)
    suspend fun send(request: DriveRequest): DriveResponse
}

/**
 * Drive's REST protocol (v3) over the platform's HTTP: the calls [DriveApi] names, and Drive's answers turned into
 * [DriveError]s. A refused token is renewed once per call before "not connected" is said. Never logs a token, a request
 * body or a file's content (Rulebook D11): errors carry only the status code and Drive's reason word.
 */
class GoogleDrive(private val http: DriveHttp, private val tokens: DriveTokens) : DriveApi {

    override suspend fun list(): List<DriveFile> {
        val files = mutableListOf<DriveFile>()
        var page: String? = null
        do {
            val url = "$API/files?spaces=appDataFolder&pageSize=1000&fields=" + enc("nextPageToken,files($FIELDS)") +
                (page?.let { "&pageToken=" + enc(it) } ?: "")
            val o = json(send("GET", url))
            o["files"]?.jsonArray?.forEach { files += file(it.jsonObject) }
            page = (o["nextPageToken"] as? JsonPrimitive)?.contentOrNull
        } while (page != null)
        return files
    }

    override suspend fun get(id: String): DriveFile? = try {
        file(json(send("GET", "$API/files/${enc(id)}?fields=" + enc(FIELDS))))
    } catch (_: DriveError.NotFound) {
        null
    }

    override suspend fun generateIds(count: Int): List<String> =
        json(send("GET", "$API/files/generateIds?count=$count&space=appDataFolder&type=files"))
            .getValue("ids").jsonArray.map { it.jsonPrimitive.content }

    override suspend fun create(id: String, name: String, properties: Map<String, String>, content: ByteArray): DriveFile {
        val metadata = JsonObject(
            mapOf(
                "id" to JsonPrimitive(id), "name" to JsonPrimitive(name),
                "parents" to JsonArray(listOf(JsonPrimitive("appDataFolder"))),
                "appProperties" to JsonObject(properties.mapValues { JsonPrimitive(it.value) }),
            ),
        ).toString().encodeToByteArray()
        // One request carries the details and the content (multipart, up to 5 MB); larger files go resumable, still
        // created in one step at the end, so a file cut off half-way never exists.
        return if (content.size <= MULTIPART_LIMIT) {
            val boundary = "often-enough-" + Random.nextLong().toULong().toString(16)
            val body = multipart(boundary, metadata, content)
            file(json(send("POST", "$UPLOAD/files?uploadType=multipart&fields=" + enc(FIELDS), body, "multipart/related; boundary=$boundary")))
        } else {
            val start = send("POST", "$UPLOAD/files?uploadType=resumable&fields=" + enc(FIELDS), metadata, "application/json; charset=UTF-8", extra = mapOf("X-Upload-Content-Type" to "application/octet-stream"))
            val session = start.headers["location"] ?: throw DriveError.Rejected(start.status, "no upload session")
            file(json(send("PUT", session, content, "application/octet-stream")))
        }
    }

    override suspend fun updateProperties(id: String, properties: Map<String, String>): DriveFile {
        val body = JsonObject(mapOf("appProperties" to JsonObject(properties.mapValues { JsonPrimitive(it.value) }))).toString().encodeToByteArray()
        return file(json(send("PATCH", "$API/files/${enc(id)}?fields=" + enc(FIELDS), body, "application/json; charset=UTF-8")))
    }

    override suspend fun download(id: String): ByteArray = send("GET", "$API/files/${enc(id)}?alt=media").body

    override suspend fun delete(id: String) {
        try {
            send("DELETE", "$API/files/${enc(id)}")
        } catch (_: DriveError.NotFound) {
        }
    }

    override suspend fun quota(): DriveQuota {
        val q = json(send("GET", "$API/about?fields=storageQuota")).getValue("storageQuota").jsonObject
        return DriveQuota(limit = q["limit"]?.jsonPrimitive?.contentOrNull?.toLongOrNull(), usage = q["usage"]?.jsonPrimitive?.contentOrNull?.toLongOrNull() ?: 0)
    }

    /** One call: the token added, renewed once if refused, and Drive's answer checked. */
    private suspend fun send(method: String, url: String, body: ByteArray? = null, type: String? = null, extra: Map<String, String> = emptyMap()): DriveResponse {
        var refresh = false
        while (true) {
            val token = tokens.accessToken(refresh)
            val headers = buildMap {
                put("Authorization", "Bearer $token")
                type?.let { put("Content-Type", it) }
                putAll(extra)
            }
            val response = try {
                http.send(DriveRequest(method, url, headers, body))
            } catch (e: CancellationException) {
                throw e
            } catch (e: DriveError) {
                throw e
            } catch (e: Exception) {
                throw DriveError.Offline(e)
            }
            if (response.status == 401 && !refresh) {
                refresh = true
                continue
            }
            if (response.status in 200..299) return response
            throw error(response)
        }
    }

    private fun json(response: DriveResponse): JsonObject = try {
        Json.parseToJsonElement(response.body.decodeToString()).jsonObject
    } catch (_: Exception) {
        throw DriveError.Rejected(response.status, "unreadable answer")
    }

    private fun file(o: JsonObject): DriveFile = DriveFile(
        id = o.getValue("id").jsonPrimitive.content,
        name = (o["name"] as? JsonPrimitive)?.contentOrNull ?: "",
        properties = (o["appProperties"] as? JsonObject)?.mapValues { it.value.jsonPrimitive.content } ?: emptyMap(),
        size = (o["size"] as? JsonPrimitive)?.contentOrNull?.toLongOrNull() ?: 0,
        createdTime = (o["createdTime"] as? JsonPrimitive)?.contentOrNull?.let { rfc3339(it) } ?: 0,
        sha256 = (o["sha256Checksum"] as? JsonPrimitive)?.contentOrNull,
    )

    companion object {
        private const val API = "https://www.googleapis.com/drive/v3"
        private const val UPLOAD = "https://www.googleapis.com/upload/drive/v3"
        private const val FIELDS = "id,name,size,createdTime,appProperties,sha256Checksum"
        const val MULTIPART_LIMIT = 5 * 1024 * 1024

        /** Drive's error answer as a [DriveError]: the status and the first reason word decide. */
        fun error(response: DriveResponse): DriveError {
            val o = runCatching { Json.parseToJsonElement(response.body.decodeToString()).jsonObject }.getOrNull()
            val err = o?.get("error") as? JsonObject
            val reason = (err?.get("errors") as? JsonArray)?.firstOrNull()?.let { (it as? JsonObject)?.get("reason") as? JsonPrimitive }?.contentOrNull
                ?: (err?.get("status") as? JsonPrimitive)?.contentOrNull
                ?: (o?.get("error") as? JsonPrimitive)?.contentOrNull // the token endpoint: {"error": "invalid_grant"}
                ?: ""
            val retryAfter = response.headers["retry-after"]?.trim()?.toLongOrNull()?.times(1000)
            return when {
                response.status == 401 -> DriveError.NotConnected(reason.ifEmpty { "unauthorized" })
                response.status == 403 && reason == "storageQuotaExceeded" -> DriveError.Full()
                response.status == 403 && reason in RATE_REASONS -> DriveError.RateLimited(retryAfter)
                response.status == 403 -> DriveError.NotConnected(reason.ifEmpty { "forbidden" })
                response.status == 404 -> DriveError.NotFound()
                response.status == 409 -> DriveError.Conflict()
                response.status == 429 -> DriveError.RateLimited(retryAfter)
                response.status >= 500 -> DriveError.ServerError(response.status)
                reason == "invalid_grant" -> DriveError.NotConnected(reason)
                else -> DriveError.Rejected(response.status, reason)
            }
        }

        private val RATE_REASONS = setOf("userRateLimitExceeded", "rateLimitExceeded", "dailyLimitExceeded", "sharingRateLimitExceeded", "RESOURCE_EXHAUSTED")

        private fun multipart(boundary: String, metadata: ByteArray, content: ByteArray): ByteArray {
            val head = "--$boundary\r\nContent-Type: application/json; charset=UTF-8\r\n\r\n".encodeToByteArray()
            val middle = "\r\n--$boundary\r\nContent-Type: application/octet-stream\r\n\r\n".encodeToByteArray()
            val tail = "\r\n--$boundary--\r\n".encodeToByteArray()
            return head + metadata + middle + content + tail
        }

        /** Percent-encodes a query value or path part. */
        fun enc(text: String): String = buildString {
            for (b in text.encodeToByteArray()) {
                val c = b.toInt() and 0xff
                if (c in 'a'.code..'z'.code || c in 'A'.code..'Z'.code || c in '0'.code..'9'.code || c in "-_.~".map { it.code }) append(c.toChar())
                else append('%').append("0123456789ABCDEF"[c shr 4]).append("0123456789ABCDEF"[c and 15])
            }
        }

        /** `2026-10-11T17:39:00.123Z` → epoch ms (Drive always answers in UTC). */
        fun rfc3339(text: String): Long? {
            val m = Regex("(\\d{4})-(\\d{2})-(\\d{2})T(\\d{2}):(\\d{2}):(\\d{2})(?:\\.(\\d{1,9}))?Z").matchEntire(text) ?: return null
            val (y, mo, d, h, mi, s, frac) = m.destructured
            val days = daysFromCivil(y.toInt(), mo.toInt(), d.toInt())
            val millis = frac.padEnd(3, '0').take(3).ifEmpty { "0" }.toLong()
            return ((days * 24 + h.toLong()) * 60 + mi.toLong()) * 60_000 + s.toLong() * 1000 + millis
        }

        private fun daysFromCivil(year: Int, month: Int, day: Int): Long {
            val y = if (month <= 2) year - 1 else year
            val era = (if (y >= 0) y else y - 399) / 400
            val yoe = y - era * 400
            val doy = (153 * (month + (if (month > 2) -3 else 9)) + 2) / 5 + day - 1
            val doe = yoe * 365 + yoe / 4 - yoe / 100 + doy
            return era * 146097L + doe - 719468
        }
    }
}

/**
 * An access token from a refresh token (OAuth's `refresh_token` grant), kept until a minute before it expires. For
 * the real-Drive checks on GitHub and for desktop builds; the phone apps use their platform's own sign-in instead.
 * `invalid_grant` (the refresh token expired or was revoked) is [DriveError.NotConnected].
 */
class RefreshTokenAccess(
    private val http: DriveHttp,
    private val clientId: String,
    private val clientSecret: String,
    private val refreshToken: String,
    private val clock: () -> Long = ::currentTimeMillis,
) : DriveTokens {
    private var token: String? = null
    private var expires = 0L

    override suspend fun accessToken(refresh: Boolean): String {
        val held = token
        if (!refresh && held != null && clock() < expires) return held
        val form = listOf("client_id" to clientId, "client_secret" to clientSecret, "refresh_token" to refreshToken, "grant_type" to "refresh_token")
            .joinToString("&") { (k, v) -> k + "=" + GoogleDrive.enc(v) }
        val response = try {
            http.send(DriveRequest("POST", "https://oauth2.googleapis.com/token", mapOf("Content-Type" to "application/x-www-form-urlencoded"), form.encodeToByteArray()))
        } catch (e: CancellationException) {
            throw e
        } catch (e: Exception) {
            throw DriveError.Offline(e)
        }
        if (response.status !in 200..299) {
            // The token endpoint answers 400 for an expired or revoked refresh token (`invalid_grant`) and a wrong client.
            val e = GoogleDrive.error(response)
            throw if (e is DriveError.Rejected) DriveError.NotConnected(e.reason.ifEmpty { "refused" }) else e
        }
        val o = Json.parseToJsonElement(response.body.decodeToString()).jsonObject
        val fresh = o.getValue("access_token").jsonPrimitive.content
        val lifetime = (o["expires_in"] as? JsonPrimitive)?.longOrNull ?: 3600
        token = fresh
        expires = clock() + (lifetime - 60) * 1000
        return fresh
    }
}
