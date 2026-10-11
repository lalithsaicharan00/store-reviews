package app.habits.core

import kotlin.test.Test
import kotlin.test.assertContentEquals
import kotlin.test.assertEquals
import kotlin.test.assertFailsWith
import kotlin.test.assertFalse
import kotlin.test.assertNull
import kotlin.test.assertTrue
import kotlinx.coroutines.runBlocking

/** Drive's REST protocol ([GoogleDrive], [RefreshTokenAccess]) against scripted answers: every error is the right state. */
class GoogleDriveTest {
    private class Scripted : DriveHttp {
        val answers = ArrayDeque<() -> DriveResponse>()
        val sent = mutableListOf<DriveRequest>()
        override suspend fun send(request: DriveRequest): DriveResponse {
            sent += request
            return answers.removeFirst()()
        }
        fun answer(status: Int, body: String = "{}", headers: Map<String, String> = emptyMap()) {
            answers += { DriveResponse(status, headers, body.encodeToByteArray()) }
        }
        fun error(status: Int, reason: String) = answer(status, """{"error":{"code":$status,"message":"m","errors":[{"reason":"$reason"}]}}""")
    }

    private class Tokens : DriveTokens {
        val asked = mutableListOf<Boolean>()
        override suspend fun accessToken(refresh: Boolean): String {
            asked += refresh
            return if (refresh) "fresh" else "old"
        }
    }

    private val file = """{"id":"f1","name":"n","size":"12","createdTime":"2026-10-11T17:39:00.123Z","appProperties":{"chain":"base"},"sha256Checksum":"ab"}"""

    @Test fun listsEveryPage() = runBlocking<Unit> {
        val http = Scripted()
        http.answer(200, """{"files":[$file],"nextPageToken":"p2"}""")
        http.answer(200, """{"files":[${file.replace("f1", "f2")}]}""")
        val files = GoogleDrive(http, Tokens()).list()
        assertEquals(listOf("f1", "f2"), files.map { it.id })
        assertEquals(mapOf("chain" to "base"), files[0].properties)
        assertEquals(1_791_740_340_123L, files[0].createdTime)
        assertEquals(12, files[0].size)
        assertTrue(http.sent[0].url.contains("spaces=appDataFolder"))
        assertTrue(http.sent[1].url.endsWith("pageToken=p2"))
        assertEquals("Bearer old", http.sent[0].headers["Authorization"])
    }

    @Test fun aRefusedTokenIsRenewedOnceThenNotConnected() = runBlocking<Unit> {
        val http = Scripted()
        val tokens = Tokens()
        http.answer(401); http.answer(200, """{"ids":["a","b"]}""")
        assertEquals(listOf("a", "b"), GoogleDrive(http, tokens).generateIds(2))
        assertEquals(listOf(false, true), tokens.asked)
        assertEquals("Bearer fresh", http.sent[1].headers["Authorization"])
        assertTrue(http.sent[1].url.contains("space=appDataFolder"))
        http.answer(401); http.answer(401)
        assertFailsWith<DriveError.NotConnected> { GoogleDrive(http, tokens).list() }
    }

    @Test fun drivesAnswersBecomeStates() = runBlocking<Unit> {
        val http = Scripted()
        val drive = GoogleDrive(http, Tokens())
        http.error(403, "storageQuotaExceeded")
        assertFailsWith<DriveError.Full> { drive.create("i", "n", emptyMap(), ByteArray(3)) }
        http.error(403, "userRateLimitExceeded")
        assertFailsWith<DriveError.RateLimited> { drive.list() }
        http.answer(429, "{}", mapOf("retry-after" to "5"))
        assertEquals(5_000L, assertFailsWith<DriveError.RateLimited> { drive.list() }.retryAfterMillis)
        http.error(409, "conflict")
        assertFailsWith<DriveError.Conflict> { drive.create("i", "n", emptyMap(), ByteArray(3)) }
        http.error(404, "notFound")
        assertNull(drive.get("gone"))
        http.error(404, "notFound")
        assertFailsWith<DriveError.NotFound> { drive.download("gone") }
        http.error(404, "notFound")
        drive.delete("gone") // already gone is fine
        http.error(503, "backendError")
        assertEquals(503, assertFailsWith<DriveError.ServerError> { drive.list() }.code)
        http.error(403, "appNotAuthorizedToFile")
        assertFailsWith<DriveError.NotConnected> { drive.list() }
        http.error(400, "badRequest")
        assertFailsWith<DriveError.Rejected> { drive.list() }
        http.answers += { throw java.io.IOException("connection reset") }
        assertFailsWith<DriveError.Offline> { drive.list() }
    }

    @Test fun createsInOneRequestOrResumable() = runBlocking<Unit> {
        val http = Scripted()
        val drive = GoogleDrive(http, Tokens())
        http.answer(200, file)
        val content = "hello".encodeToByteArray()
        drive.create("res1", "often-enough-base-000001", mapOf("seq" to "1"), content)
        val request = http.sent.single()
        assertEquals("POST", request.method)
        assertTrue(request.url.contains("uploadType=multipart"))
        val boundary = request.headers.getValue("Content-Type").substringAfter("boundary=")
        val body = request.body!!.decodeToString()
        assertTrue(body.startsWith("--$boundary\r\n"))
        assertTrue(body.contains(""""id":"res1""""))
        assertTrue(body.contains(""""parents":["appDataFolder"]"""))
        assertTrue(body.contains("\r\n\r\nhello\r\n--$boundary--"))

        val big = ByteArray(GoogleDrive.MULTIPART_LIMIT + 1) { it.toByte() }
        http.answer(200, "", mapOf("location" to "https://upload.example/session"))
        http.answer(200, file)
        drive.create("res2", "n", emptyMap(), big)
        assertTrue(http.sent[1].url.contains("uploadType=resumable"))
        assertEquals("PUT", http.sent[2].method)
        assertEquals("https://upload.example/session", http.sent[2].url)
        assertContentEquals(big, http.sent[2].body)
    }

    @Test fun aRefreshTokenGivesAccessTokens() = runBlocking<Unit> {
        val http = Scripted()
        var now = 0L
        val access = RefreshTokenAccess(http, "client", "secret", "refresh/token", clock = { now })
        http.answer(200, """{"access_token":"a1","expires_in":3600}""")
        assertEquals("a1", access.accessToken(false))
        assertEquals("a1", access.accessToken(false), "kept until it nearly expires")
        assertEquals(1, http.sent.size)
        assertTrue(http.sent[0].body!!.decodeToString().contains("refresh_token=refresh%2Ftoken"))
        now += 3_600_000
        http.answer(200, """{"access_token":"a2","expires_in":3600}""")
        assertEquals("a2", access.accessToken(false))
        http.answer(400, """{"error":"invalid_grant","error_description":"Token has been expired or revoked."}""")
        val expired = assertFailsWith<DriveError.NotConnected> { access.accessToken(true) }
        assertEquals("invalid_grant", expired.reason)
        assertFalse(expired.message!!.contains("refresh/token") || expired.message!!.contains("secret"), "no secret in the message")
    }

    @Test fun readsDrivesTimes() {
        assertEquals(0L, GoogleDrive.rfc3339("1970-01-01T00:00:00Z"))
        assertEquals(951_782_400_000L, GoogleDrive.rfc3339("2000-02-29T00:00:00.000Z"))
        assertNull(GoogleDrive.rfc3339("yesterday"))
    }
}
