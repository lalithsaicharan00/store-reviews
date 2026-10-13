package com.oftenenough.app.app.backup

import app.habits.core.DriveHttp
import app.habits.core.DriveRequest
import app.habits.core.DriveResponse
import java.net.HttpURLConnection
import java.net.URL
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

/**
 * Plain HTTPS for the core's [app.habits.core.GoogleDrive] (the core speaks Drive's protocol; the platform only sends).
 * Throws only when no answer came at all (offline, timed out, cut off); every status is an answer. Never logs a
 * request, a token or a file's content (D11).
 */
class HttpDrive(private val timeoutMillis: Int = 30_000) : DriveHttp {
    override suspend fun send(request: DriveRequest): DriveResponse = withContext(Dispatchers.IO) {
        val connection = URL(request.url).openConnection() as HttpURLConnection
        try {
            connection.requestMethod = if (request.method == "PATCH") "POST" else request.method
            if (request.method == "PATCH") connection.setRequestProperty("X-HTTP-Method-Override", "PATCH")
            connection.connectTimeout = timeoutMillis
            connection.readTimeout = timeoutMillis
            connection.instanceFollowRedirects = true
            for ((k, v) in request.headers) connection.setRequestProperty(k, v)
            val body = request.body
            if (body != null) {
                connection.doOutput = true
                connection.setFixedLengthStreamingMode(body.size)
                connection.outputStream.use { it.write(body) }
            }
            val status = connection.responseCode
            val stream = if (status >= 400) connection.errorStream else connection.inputStream
            val bytes = stream?.use { it.readBytes() } ?: ByteArray(0)
            val headers = connection.headerFields.filterKeys { it != null }.mapKeys { it.key.lowercase() }.mapValues { it.value.joinToString(",") }
            DriveResponse(status, headers, bytes)
        } finally {
            connection.disconnect()
        }
    }
}
