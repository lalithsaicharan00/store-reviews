import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

nonisolated struct AnalyticsDeliveryConfiguration: Sendable {
    var projectToken = ""
    /// Set only after allowance, organization usage, zero paid limit, retention and payload review are verified.
    var productionVerified = false
    var releaseChannel = "development"
    var appVersion = "0"
    var appBuild = "0"
    var osMajor = 0
    var sampleRate = 1.0
    var samplingVersion = 1
    var eligible: Bool { productionVerified && releaseChannel == "production" && projectToken.hasPrefix("phc_") }

    func payload(_ records: [AnalyticsRecord], installation: UUID) throws -> Data {
        let events = records.map { record -> [String: Any] in
            var properties = record.properties.mapValues(\.json)
            properties.merge(["schema_version": 1, "platform": "ios", "form_factor": "phone", "app_version": safeVersion(appVersion),
                "app_build": safeVersion(appBuild), "os_major": max(0, min(100, osMajor)), "release_channel": releaseChannel,
                "origin_surface": record.origin.surface, "plan": "unknown", "sample_rate": sampleRate, "sampling_version": samplingVersion,
                "analytics_record_id": record.id.uuidString, "$process_person_profile": false, "$geoip_disable": true,
                "$ip": "0.0.0.0"]) { _, new in new }
            return ["uuid": record.id.uuidString, "event": record.event.rawValue, "distinct_id": installation.uuidString,
                    "timestamp": ISO8601DateFormatter().string(from: record.created), "properties": properties]
        }
        return try JSONSerialization.data(withJSONObject: ["api_key": projectToken, "batch": events])
    }
    private func safeVersion(_ raw: String) -> String {
        raw.count <= 32 && raw.range(of: "^[0-9]+([.][0-9]+)*$", options: .regularExpression) != nil ? raw : "0"
    }
}

/// Explicit HTTP events only: no SDK initialization, autocapture, replay, profiles, flags, surveys,
/// crash handler, device metadata, URL/referrer capture or tracing headers. No account credentials.
nonisolated final class AnalyticsTransport: @unchecked Sendable {
    private var session: URLSession?
    private var task: URLSessionDataTask?
    func send(_ data: Data, completion: @escaping @Sendable (Bool, Int?) -> Void) {
        let config = URLSessionConfiguration.ephemeral
        config.httpCookieStorage = nil; config.urlCredentialStorage = nil; config.urlCache = nil
        config.httpShouldSetCookies = false; config.timeoutIntervalForRequest = 10; config.timeoutIntervalForResource = 15
        let session = URLSession(configuration: config)
        self.session = session
        var request = URLRequest(url: URL(string: "https://eu.i.posthog.com/batch/")!)
        request.httpMethod = "POST"; request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        task = session.dataTask(with: request) { _, response, error in
            let code = (response as? HTTPURLResponse)?.statusCode
            completion(error == nil && code.map { (200..<300).contains($0) } == true, code)
            session.finishTasksAndInvalidate()
        }
        task?.resume()
    }
    func cancel() { task?.cancel(); session?.invalidateAndCancel(); task = nil; session = nil }
}
