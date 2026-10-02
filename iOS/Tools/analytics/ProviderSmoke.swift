import Foundation

/// An explicit integration-test boundary, not part of the app or its delivery gate.
/// Two content-free synthetic development records, retried once with the same IDs.
/// Uses only the public project capture key; never print the key, payload or response body.
@main
struct ProviderSmoke {
    static func main() async throws {
        let plist = try Data(contentsOf: URL(fileURLWithPath: "iOS/Habits-Info.plist"))
        let info = try PropertyListSerialization.propertyList(from: plist, format: nil) as! [String: Any]
        var config = AnalyticsDeliveryConfiguration()
        config.projectToken = info["AnalyticsProjectToken"] as? String ?? ""
        guard config.projectToken.hasPrefix("phc_") else { throw CocoaError(.coderInvalidValue) }
        config.releaseChannel = "development" // Intentionally excluded from every production insight.
        let installation = UUID()
        let now = Date.now
        let end = AnalyticsLedger.day(now)
        let records = [
            AnalyticsRecord(id: UUID(), event: .entityCreated, created: now, origin: .manual,
                properties: ["entity_type": .text("habit"), "habit_type": .text("check"), "creation_origin": .text("manual")]),
            AnalyticsRecord(id: UUID(), event: .features, created: now, origin: .manual,
                properties: ["period_start_utc": .number(end - 86400), "period_end_utc": .number(end),
                    "collection_started_mid_period": .flag(true), "foreground_active": .flag(true),
                    "external_action_active": .flag(false), "coverage_complete": .flag(false),
                    "coverage_version": .number(1), "delivery_loss_count": .number(0), "tracking_write_count": .number(1),
                    "habit_write_check": .number(1), "write_origin_manual": .number(1)])
        ]
        let payload = try config.payload(records, installation: installation)
        let metadata: [String: Any] = ["installation": installation.uuidString, "record_ids": records.map { $0.id.uuidString },
            "release_channel": "development", "transmissions": 2, "synthetic_records": records.count]
        let folder = URL(fileURLWithPath: "Research/Temp/analytics")
        try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        try JSONSerialization.data(withJSONObject: metadata, options: [.sortedKeys]).write(to: folder.appendingPathComponent("provider-smoke.json"))
        for attempt in 1...2 {
            let success = await withCheckedContinuation { continuation in
                let transport = AnalyticsTransport()
                transport.send(payload) { accepted, code in
                    print("Provider smoke transmission \(attempt): HTTP \(code ?? 0); accepted=\(accepted)")
                    continuation.resume(returning: accepted)
                    withExtendedLifetime(transport) {}
                }
            }
            guard success else { throw CocoaError(.fileWriteUnknown) }
        }
        print("Provider smoke: two synthetic development records sent twice, stable UUIDs; installation=\(installation.uuidString); record_ids=\(records.map { $0.id.uuidString }.joined(separator: ","))")
    }
}
