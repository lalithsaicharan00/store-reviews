package app.habits.core

import java.net.URI
import java.net.http.HttpClient
import java.net.http.HttpRequest
import java.net.http.HttpResponse
import java.time.Duration
import kotlinx.coroutines.future.await

/** Plain HTTPS for [GoogleDrive] on the desktop JVM (and the real-Drive checks on GitHub), with Java's own client. */
class JvmDriveHttp(private val timeout: Duration = Duration.ofSeconds(60)) : DriveHttp {
    private val client: HttpClient = HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(20)).build()

    override suspend fun send(request: DriveRequest): DriveResponse {
        val body = request.body?.let { HttpRequest.BodyPublishers.ofByteArray(it) } ?: HttpRequest.BodyPublishers.noBody()
        val builder = HttpRequest.newBuilder(URI.create(request.url)).timeout(timeout).method(request.method, body)
        // Java sets Content-Length and Host itself, and refuses them here.
        request.headers.forEach { (name, value) -> builder.header(name, value) }
        val response = client.sendAsync(builder.build(), HttpResponse.BodyHandlers.ofByteArray()).await()
        val headers = response.headers().map().mapNotNull { (name, values) -> values.firstOrNull()?.let { name.lowercase() to it } }.toMap()
        return DriveResponse(response.statusCode(), headers, response.body() ?: ByteArray(0))
    }
}
