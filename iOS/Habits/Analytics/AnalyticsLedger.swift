import Foundation

/// Disposable state, separate from the habit database, backups, exports and account requests.
nonisolated struct AnalyticsRecord: Codable, Sendable {
    let id: UUID
    let event: AnalyticsEvent
    let created: Date
    let origin: AnalyticsOrigin
    let properties: [String: AnalyticsValue]
    var observation: AnalyticsObservation? = nil
}
nonisolated struct AnalyticsLedger: Codable, Sendable {
    var installation = UUID()
    var sampleBucket = Double.random(in: 0..<1)
    var period: Int
    var partial = true
    var foreground = false
    var external = false
    var widgetInventory: [String: AnalyticsValue]? = nil
    var widgetInventoryPeriod: Int? = nil
    var cohort: String? = nil
    var activationObserved = false
    var counters: [String: Int] = [:]
    var visits: [String: Int] = [:]
    var seconds: [String: Double] = [:]
    var configuration: [String: AnalyticsValue] = [:]
    var outbox: [AnalyticsRecord] = []
    var seen: [String] = []
    var transitions: Set<String> = []
    var degraded: Set<String> = []
    var loss = 0
    var explicitEvents = 0
    static let explicitDailyLimit = 100
    static let queueLimit = 256
    static let retention: TimeInterval = 7 * 86400
    static func day(_ date: Date) -> Int { Int(floor(date.timeIntervalSince1970 / 86400)) * 86400 }
    init(now: Date) { period = Self.day(now) }

    mutating func increment(_ key: String, flag: Bool = false) {
        guard AnalyticsContract.counterKeys.contains(key) else { return }
        counters[key] = flag ? 1 : min(AnalyticsContract.maximumCount, (counters[key] ?? 0) + 1)
    }
    mutating func once(_ key: String) -> Bool {
        guard !seen.contains(key) else { return false }
        seen.append(key)
        if seen.count > 1024 { seen.removeFirst(seen.count - 1024) }
        return true
    }
    mutating func enqueue(_ event: AnalyticsEvent, _ properties: [String: AnalyticsValue], origin: AnalyticsOrigin = .today, now: Date) {
        guard AnalyticsContract.valid(event, properties) else { return }
        prune(now: now)
        // Protect against runaway terminal callbacks. Summaries retain loss/coverage even when flows are capped.
        if ![.features, .screens, .configuration].contains(event) {
            guard explicitEvents < Self.explicitDailyLimit else { loss = min(100_000, loss + 1); return }
            explicitEvents += 1
        }
        if outbox.count >= Self.queueLimit { outbox.removeFirst(); loss = min(100_000, loss + 1) }
        outbox.append(AnalyticsRecord(id: UUID(), event: event, created: now, origin: origin, properties: properties))
    }
    mutating func prune(now: Date) {
        let count = outbox.count
        outbox.removeAll { now.timeIntervalSince($0.created) > Self.retention || $0.created.timeIntervalSince(now) > 86400 }
        loss = min(100_000, loss + count - outbox.count)
    }
    mutating func advance(now: Date, sampled: Bool) {
        let next = Self.day(now)
        guard next > period else { prune(now: now); return }
        // No midnight wake, no synthetic inactive days. A week offline retains only recent frozen records.
        if sampled, now.timeIntervalSince1970 - Double(period) <= Self.retention {
            let common: [String: AnalyticsValue] = ["period_start_utc": .number(period), "period_end_utc": .number(period + 86400),
                "collection_started_mid_period": .flag(partial), "foreground_active": .flag(foreground), "external_action_active": .flag(external),
                "coverage_complete": .flag(false), "coverage_version": .number(2), "delivery_loss_count": .number(loss)]
            if foreground || external || !counters.isEmpty {
                let measured = Dictionary(uniqueKeysWithValues: AnalyticsContract.measuredCounterKeys.map { ($0, AnalyticsValue.number(counters[$0] ?? 0)) })
                enqueue(.features, common.merging(measured) { _, new in new }, now: Date(timeIntervalSince1970: Double(period + 86400)))
            }
            if foreground {
                var engagement = common
                for (screen, count) in visits { engagement["visits_" + screen] = .number(count) }
                for (screen, time) in seconds { engagement["active_seconds_" + screen] = .number(min(86400, Int(time))) }
                enqueue(.screens, engagement, now: Date(timeIntervalSince1970: Double(period + 86400)))
                enqueue(.configuration, common.merging(configuration) { _, new in new }, now: Date(timeIntervalSince1970: Double(period + 86400)))
            }
        }
        counters = [:]; visits = [:]; seconds = [:]; transitions = []; foreground = false; external = false
        explicitEvents = 0
        period = next; partial = false // false for a continuously consented installation
        prune(now: now)
    }
}

/// Pure monotonic clock accounting. A running habit timer never extends the 30-second attention window.
nonisolated struct AnalyticsAttention: Sendable {
    var screen: AnalyticsScreen?
    var foreground = false
    var last: TimeInterval?
    var idleDeadline: TimeInterval = 0
    mutating func settle(uptime: TimeInterval) -> (AnalyticsScreen, Double)? {
        defer { last = uptime }
        guard foreground, let screen, let last, uptime >= last else { return nil }
        return (screen, max(0, min(uptime, idleDeadline) - last))
    }
    mutating func interaction(uptime: TimeInterval) { idleDeadline = uptime + 30 }
}
