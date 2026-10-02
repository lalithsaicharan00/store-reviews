import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

nonisolated struct AnalyticsObservation: Codable, Sendable {
    let appVersion: String
    let appBuild: String
    let osMajor: Int
    let releaseChannel: String
    let sampleRate: Double
    let samplingVersion: Int
}

nonisolated struct AnalyticsDeliveryConfiguration: Sendable {
    var projectToken = ""
    /// Explicit release gate; no-billing account confirmed by owner, published free allowance checked.
    /// Billing API verification remains separately documented; this flag never enables paid services.
    var productionEnabled = false
    var releaseChannel = "development"
    var appVersion = "0"
    var appBuild = "0"
    var osMajor = 0
    var sampleRate = 1.0
    var samplingVersion = 1
    static func channel(debugBuild: Bool, sandboxReceipt: Bool, configured: String?) -> String {
        if debugBuild { return "development" }
        if sandboxReceipt { return "beta" }
        guard let configured, ["production", "beta", "development"].contains(configured) else { return "development" }
        return configured
    }
    var eligible: Bool { productionEnabled && releaseChannel == "production" && projectToken.hasPrefix("phc_") && sampleRate.isFinite && sampleRate > 0 && sampleRate <= 1 && (1...100_000).contains(samplingVersion) }
    var observation: AnalyticsObservation {
        AnalyticsObservation(appVersion: safeVersion(appVersion), appBuild: safeVersion(appBuild), osMajor: max(0, min(100, osMajor)),
            releaseChannel: ["production", "beta", "development"].contains(releaseChannel) ? releaseChannel : "development", sampleRate: sampleRate, samplingVersion: samplingVersion)
    }

    func payload(_ records: [AnalyticsRecord], installation: UUID) throws -> Data {
        guard sampleRate.isFinite, sampleRate >= 0, sampleRate <= 1, records.allSatisfy({ AnalyticsContract.valid($0.event, $0.properties) && ($0.observation?.sampleRate.isFinite ?? true) && (0...1).contains($0.observation?.sampleRate ?? sampleRate) }) else { throw CocoaError(.coderInvalidValue) }
        let events = records.map { record -> [String: Any] in
            let captured = record.observation ?? observation
            var properties = record.properties.mapValues(\.json)
            properties.merge(["schema_version": 1, "platform": "ios", "form_factor": "phone", "app_version": safeVersion(captured.appVersion),
                "app_build": safeVersion(captured.appBuild), "os_major": max(0, min(100, captured.osMajor)), "release_channel": ["production", "beta", "development"].contains(captured.releaseChannel) ? captured.releaseChannel : "development",
                "origin_surface": record.origin.surface, "plan": "unknown", "sample_rate": captured.sampleRate, "sampling_version": max(1, min(100_000, captured.samplingVersion)),
                "analytics_record_id": record.id.uuidString, "$process_person_profile": false, "$geoip_disable": true,
                "$ip": "0.0.0.0"]) { _, new in new }
            return ["uuid": record.id.uuidString, "event": record.event.rawValue, "distinct_id": installation.uuidString,
                    "timestamp": Self.timestampFormat.format(record.created), "properties": properties]
        }
        return try JSONSerialization.data(withJSONObject: ["api_key": projectToken, "batch": events], options: [.sortedKeys])
    }
    private static let timestampFormat = Date.ISO8601FormatStyle()
    private func safeVersion(_ raw: String) -> String {
        raw.count <= 32 && raw.range(of: "^[0-9]+([.][0-9]+)*$", options: .regularExpression) != nil ? raw : "0"
    }
}

/// Explicit HTTP events only: no SDK initialization, autocapture, replay, profiles, flags, surveys,
/// crash handler, device metadata, URL/referrer capture or tracing headers. No account credentials.
nonisolated protocol AnalyticsSending: Sendable {
    func send(_ data: Data, completion: @escaping @Sendable (Bool, Int?) -> Void)
    func cancel()
}

nonisolated final class AnalyticsTransport: AnalyticsSending, @unchecked Sendable {
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
