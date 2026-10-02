import Foundation

@main
struct ContractTests {
    static func main() throws {
        var checks = 0
        func check(_ passes: Bool, _ label: String) {
            checks += 1
            if !passes { fatalError("Analytics check failed: " + label) }
        }
        let analytics = Analytics(file: nil)
        check(analytics.ticket == nil && analytics.inspect() == nil, "no pre-consent identity or queue")
        analytics.created(.check, ticket: analytics.ticket)
        analytics.drain()
        check(analytics.inspect() == nil, "pre-consent actions discarded")
        analytics.setConsent(true)
        let ticket = analytics.ticket
        analytics.created(.cutDown, ticket: ticket)
        analytics.created(.cutDown, ticket: ticket)
        analytics.tracking(.cutDown, origin: .history, ticket: ticket)
        analytics.tracking(.cutDown, origin: .history, ticket: ticket)
        analytics.drain()
        let captured = analytics.inspect()!
        check(captured.outbox.filter { $0.event == .entityCreated }.count == 1, "duplicate terminal callback suppressed")
        check(captured.counters["tracking_write_count"] == 1 && captured.counters["habit_write_cut_down"] == 1, "write and type once")
        check(captured.counters["write_origin_history"] == 1 && captured.counters["history_log_count"] == 1, "historical origin")
        check(captured.outbox.filter { $0.event == .activation }.count == 1, "activation once after consent")
        check(captured.counters["habit_write_amount"] == nil, "cut down is separate")
        analytics.tracking(.notApplicable, origin: .shortcut, ticket: analytics.ticket)
        analytics.drain()
        check(analytics.inspect()?.counters["task_write_count"] == 1, "task subtype")
        check(analytics.inspect()?.counters["shortcut_action_accepted_count"] == 1, "external accepted action")
        check(analytics.inspect()?.external == true, "external-only eligibility")
        analytics.setConsent(false)
        analytics.created(.check, ticket: ticket)
        analytics.drain()
        check(analytics.inspect() == nil && !analytics.consented, "offline opt out purges counters records and identity")
        analytics.setConsent(true)
        analytics.created(.check, ticket: ticket)
        analytics.drain()
        check(analytics.inspect()?.outbox.isEmpty == true, "old pending write rejected after reconsent")
        check(analytics.inspect()?.installation != captured.installation, "old identity not revived")
        check(AnalyticsDeliveryConfiguration.channel(debugBuild: true, sandboxReceipt: false, configured: "production") == "development", "debug can never inherit production channel")
        check(AnalyticsDeliveryConfiguration.channel(debugBuild: false, sandboxReceipt: true, configured: "production") == "beta", "TestFlight sandbox receipt excludes production sending")
        check(AnalyticsDeliveryConfiguration.channel(debugBuild: false, sandboxReceipt: false, configured: "production") == "production", "explicit release channel permits production only outside sandbox")
        check(AnalyticsDeliveryConfiguration.channel(debugBuild: false, sandboxReceipt: false, configured: nil) == "development", "missing release channel fails closed")
        let reliabilityEngine = Analytics(file: nil)
        reliabilityEngine.setConsent(true)
        let failedAttempt = reliabilityEngine.ticket
        reliabilityEngine.reliability("storage", succeeded: false, ticket: failedAttempt)
        reliabilityEngine.reliability("storage", succeeded: false, ticket: failedAttempt)
        reliabilityEngine.drain()
        check(reliabilityEngine.inspect()?.counters["storage_failure_count"] == 1 && reliabilityEngine.inspect()?.outbox.count == 1, "duplicate terminal reliability callback is one failed attempt")
        reliabilityEngine.reliability("storage", succeeded: true, ticket: failedAttempt)
        reliabilityEngine.drain()
        check(reliabilityEngine.inspect()?.counters["storage_success_count"] == nil, "same attempt cannot report conflicting terminal success")
        reliabilityEngine.reliability("storage", succeeded: true, ticket: reliabilityEngine.ticket)
        reliabilityEngine.drain()
        check(reliabilityEngine.inspect()?.counters["storage_success_count"] == 1 && reliabilityEngine.inspect()?.outbox.count == 2, "distinct successful retry records recovery once")
        let disabled = Analytics(file: nil, disabled: true)
        disabled.setConsent(true)
        check(disabled.ticket == nil, "CI/debug fixtures cannot opt in to production")
        analytics.erase()
        check(!analytics.consented, "erase clears consent")

        let relayFolder = URL(fileURLWithPath: "Research/Temp/analytics/relay-" + UUID().uuidString)
        defer { try? FileManager.default.removeItem(at: relayFolder) }
        check(WidgetAnalyticsRelay.ticket(directory: relayFolder) == nil, "widget relay absent before consent")
        WidgetAnalyticsRelay.committed(ticket: nil, directory: relayFolder)
        check(!FileManager.default.fileExists(atPath: relayFolder.path), "widget callbacks create no preconsent file")
        WidgetAnalyticsRelay.consent(true, directory: relayFolder)
        let relayTicket = WidgetAnalyticsRelay.ticket(directory: relayFolder)
        WidgetAnalyticsRelay.committed(ticket: relayTicket, directory: relayFolder)
        check(WidgetAnalyticsRelay.drain(directory: relayFolder) == 1, "durable widget page callback counted")
        check(WidgetAnalyticsRelay.drain(directory: relayFolder) == 0, "widget relay drain does not duplicate")
        WidgetAnalyticsRelay.committed(ticket: relayTicket, directory: relayFolder)
        check(WidgetAnalyticsRelay.drain(directory: relayFolder, commit: { _, _ in throw CocoaError(.fileWriteOutOfSpace) }) == 0, "failed widget mailbox clear emits no count")
        check(WidgetAnalyticsRelay.drain(directory: relayFolder) == 1 && WidgetAnalyticsRelay.drain(directory: relayFolder) == 0, "widget mailbox clear retry consumes pending count exactly once")
        WidgetAnalyticsRelay.committed(ticket: relayTicket, directory: relayFolder, now: Date(timeIntervalSince1970: 86400))
        check(WidgetAnalyticsRelay.drain(directory: relayFolder) == 0, "old widget page not attributed to new day")
        WidgetAnalyticsRelay.consent(false, directory: relayFolder)
        WidgetAnalyticsRelay.committed(ticket: relayTicket, directory: relayFolder)
        check(WidgetAnalyticsRelay.ticket(directory: relayFolder) == nil, "widget optout purges pending relay and rejects callback")
        WidgetAnalyticsRelay.consent(true, directory: relayFolder)
        WidgetAnalyticsRelay.committed(ticket: relayTicket, directory: relayFolder)
        check(WidgetAnalyticsRelay.drain(directory: relayFolder) == 0, "widget consent generation rejects previous session")
        let cohortEngine = Analytics(file: nil)
        cohortEngine.cohort("fresh_first_run", ticket: cohortEngine.ticket)
        cohortEngine.setConsent(true)
        cohortEngine.tracking(.check, origin: .today, ticket: cohortEngine.ticket); cohortEngine.drain()
        check(cohortEngine.inspect()?.outbox.first?.properties["cohort"] == .text("unknown"), "preconsent onboarding does not reconstruct fresh cohort")
        cohortEngine.setConsent(true)
        cohortEngine.cohort("fresh_first_run", ticket: cohortEngine.ticket)
        cohortEngine.tracking(.check, origin: .widget, ticket: cohortEngine.ticket); cohortEngine.drain()
        check(cohortEngine.inspect()?.outbox.first?.properties["cohort"] == .text("fresh_first_run"), "observed consenting onboarding classifies activation")
        check(cohortEngine.inspect()?.counters["widget_action_accepted_count"] == 1, "widget acceptance counted separately")
        let inventory: [String: AnalyticsValue] = ["query_supported": .flag(true), "query_result": .text("success"), "host": .text("unknown"), "kind_today_count": .number(1)]
        cohortEngine.widgetInventory(inventory, ticket: cohortEngine.ticket)
        cohortEngine.widgetInventory(inventory, ticket: cohortEngine.ticket); cohortEngine.drain()
        check(cohortEngine.inspect()?.outbox.filter { $0.event == .widgetInventory }.count == 1, "unchanged widget inventory suppressed persistently")
        var changedInventory = inventory; changedInventory["kind_today_count"] = .number(2)
        cohortEngine.widgetInventory(changedInventory, ticket: cohortEngine.ticket); cohortEngine.drain()
        check(cohortEngine.inspect()?.outbox.filter { $0.event == .widgetInventory }.count == 1, "inventory limited to one changed snapshot per UTC day")
        var coveredDay = AnalyticsLedger(now: Date(timeIntervalSince1970: 86400))
        coveredDay.foreground = true
        coveredDay.advance(now: Date(timeIntervalSince1970: 172800), sampled: true)
        let coveredProperties = coveredDay.outbox.first { $0.event == .features }!.properties
        check(coveredProperties["routine_started_count"] == .number(0), "covered unused feature has an explicit zero denominator")
        check(coveredProperties["year_share_started_count"] == nil && coveredProperties["write_origin_watch"] == nil, "unsupported counters remain unknown")
        var periodLedger = AnalyticsLedger(now: Date(timeIntervalSince1970: 86400))
        let oldObservation = AnalyticsDeliveryConfiguration().observation
        periodLedger.periodObservation = oldObservation
        periodLedger.foreground = true
        periodLedger.advance(now: Date(timeIntervalSince1970: 172800), sampled: true)
        check(periodLedger.outbox.count == 3 && periodLedger.outbox.allSatisfy { $0.observation?.appVersion == oldObservation.appVersion && $0.observation?.sampleRate == oldObservation.sampleRate }, "closed daily records retain collection-period metadata before an upgrade")
        let consentMirrorFolder = relayFolder.appendingPathComponent("erase-mirror")
        let mirroredEngine = Analytics(file: nil, consentChanged: { enabled in
            WidgetAnalyticsRelay.consent(enabled, directory: consentMirrorFolder, rotate: true)
        })
        mirroredEngine.setConsent(true)
        let mirroredTicket = WidgetAnalyticsRelay.ticket(directory: consentMirrorFolder)
        WidgetAnalyticsRelay.committed(ticket: mirroredTicket, directory: consentMirrorFolder)
        mirroredEngine.erase()
        check(WidgetAnalyticsRelay.ticket(directory: consentMirrorFolder) == nil && WidgetAnalyticsRelay.drain(directory: consentMirrorFolder) == 0, "engine erase revokes and purges the extension consent mirror")
        let oldWidgetTicket = cohortEngine.ticket
        cohortEngine.setConsent(false)
        cohortEngine.widgetPages(100, ticket: oldWidgetTicket); cohortEngine.drain()
        check(cohortEngine.inspect() == nil, "late widget mailbox never revives telemetry after optout")

        let storageFolder = URL(fileURLWithPath: "Research/Temp/analytics/" + UUID().uuidString)
        let storageFile = storageFolder.appendingPathComponent("state.json")
        defer { try? FileManager.default.removeItem(at: storageFolder) }
        let samplingFolder = storageFolder.appendingPathComponent("sampling")
        try FileManager.default.createDirectory(at: samplingFolder, withIntermediateDirectories: true)
        var nextPolicy = AnalyticsDeliveryConfiguration()
        nextPolicy.appVersion = "99"; nextPolicy.sampleRate = 0.5; nextPolicy.samplingVersion = 2
        var previousPolicy = AnalyticsDeliveryConfiguration()
        let samplingFile = samplingFolder.appendingPathComponent("state.json")
        var samplingState = AnalyticsLedger(now: .now)
        samplingState.sampleBucket = 0.75; samplingState.periodObservation = previousPolicy.observation
        try JSONEncoder().encode(samplingState).write(to: samplingFile, options: .atomic)
        let reducedSampling = Analytics(file: samplingFile, configuration: nextPolicy)
        reducedSampling.created(.check, ticket: reducedSampling.ticket); reducedSampling.drain()
        check(reducedSampling.inspect()?.outbox.count == 1, "sampling reduction keeps open-period inclusion after upgrade")
        let reducedRecord = reducedSampling.inspect()!.outbox[0]
        check(reducedRecord.observation?.sampleRate == 1 && reducedRecord.observation?.samplingVersion == 1 && reducedRecord.observation?.appVersion == "99", "new flows retain period sampling policy with current app metadata")
        reducedSampling.erase()
        previousPolicy.sampleRate = 0.5
        samplingState.periodObservation = previousPolicy.observation
        nextPolicy.sampleRate = 1
        try JSONEncoder().encode(samplingState).write(to: samplingFile, options: .atomic)
        let expandedSampling = Analytics(file: samplingFile, configuration: nextPolicy)
        expandedSampling.created(.check, ticket: expandedSampling.ticket); expandedSampling.drain()
        check(expandedSampling.inspect()?.outbox.isEmpty == true, "sampling expansion cannot admit unobserved open-period flows")
        expandedSampling.erase()
        samplingState.period = AnalyticsLedger.day(.now) - 86400
        try JSONEncoder().encode(samplingState).write(to: samplingFile, options: .atomic)
        let nextPeriodSampling = Analytics(file: samplingFile, configuration: nextPolicy)
        nextPeriodSampling.created(.check, ticket: nextPeriodSampling.ticket); nextPeriodSampling.drain()
        check(nextPeriodSampling.inspect()?.outbox.count == 1 && nextPeriodSampling.inspect()?.outbox.first?.observation?.sampleRate == 1 && nextPeriodSampling.inspect()?.outbox.first?.observation?.samplingVersion == 2, "new UTC period adopts new inclusion and sampling metadata together")
        nextPeriodSampling.erase()
        let persisted = Analytics(file: storageFile)
        persisted.created(.check, ticket: persisted.ticket); persisted.drain()
        check(!FileManager.default.fileExists(atPath: storageFile.path), "no telemetry file before consent")
        persisted.setConsent(true); persisted.created(.check, ticket: persisted.ticket); persisted.drain()
        Thread.sleep(forTimeInterval: 0.8)
        let beforeRestart = persisted.inspect()!
        let resumed = Analytics(file: storageFile)
        check(resumed.consented && resumed.inspect()?.installation == beforeRestart.installation, "consented installation survives restart independently")
        check(resumed.inspect()?.outbox.map(\.id) == beforeRestart.outbox.map(\.id), "offline frozen records survive restart with stable ids")
        check((try? storageFolder.resourceValues(forKeys: [.isExcludedFromBackupKey]).isExcludedFromBackup) == true, "telemetry folder excluded from device backup")
        var release = AnalyticsDeliveryConfiguration()
        release.projectToken = "phc_test_capture_only"; release.releaseChannel = "production"; release.productionEnabled = true
        let releaseNetwork = TestTransport()
        let releaseResume = Analytics(file: storageFile, configuration: release, transport: releaseNetwork)
        releaseResume.flush(); releaseResume.drain()
        check(releaseNetwork.bodies.isEmpty && releaseResume.inspect()?.outbox.isEmpty == true, "release upgrade never forwards development records to production project")
        resumed.erase()
        releaseResume.erase()
        check(!FileManager.default.fileExists(atPath: storageFile.path), "opt out removes persisted offline state")
        persisted.erase()

        let sentinel = "PRIVATE habit note goal schedule token account-id"
        var props: [String: AnalyticsValue] = ["entity_type": .text("habit"), "habit_type": .text("check"), "creation_origin": .text("manual")]
        for key in ["name", "note", "goal", "logged_value", "schedule", "account_id", "token", "$current_url", "$set", "$ip"] {
            var bad = props; bad[key] = .text(sentinel)
            check(!AnalyticsContract.valid(.entityCreated, bad), "reject leakage field " + key)
        }
        props["habit_type"] = .text(sentinel)
        check(!AnalyticsContract.valid(.entityCreated, props), "reject arbitrary string in allowed field")
        props["habit_type"] = .text("not_applicable")
        check(!AnalyticsContract.valid(.entityCreated, props), "reject inconsistent task classification")
        check(!AnalyticsContract.valid(.features, ["tracking_write_count": .number(-1)]), "reject negative counter")
        check(!AnalyticsContract.valid(.features, ["tracking_write_count": .number(Int.max)]), "reject unbounded counter")
        check(!AnalyticsContract.valid(.configuration, ["capability_widgets": .text("true")]), "reject incorrect scalar type")

        let now = Date(timeIntervalSince1970: 1_790_870_400 + 600)
        var ledger = AnalyticsLedger(now: now)
        ledger.foreground = true; ledger.increment("tracking_write_count")
        ledger.visits["today"] = 2; ledger.seconds["today"] = 29.7
        ledger.advance(now: now.addingTimeInterval(86400), sampled: true)
        let frozen = ledger.outbox
        check(frozen.count == 3, "at most three daily envelopes")
        check(frozen.first?.properties["period_start_utc"] == .number(AnalyticsLedger.day(now)), "UTC independent of user day timezone DST")
        check(frozen.first?.properties["collection_started_mid_period"] == .flag(true), "partial consent day disclosed")
        check(frozen[1].properties["active_seconds_today"] == .number(29), "integer active seconds")
        ledger.advance(now: now.addingTimeInterval(86400), sampled: true)
        check(ledger.outbox.map(\.id) == frozen.map(\.id), "period frozen once")
        ledger.advance(now: now, sampled: true)
        check(ledger.outbox.map(\.id) == frozen.map(\.id), "wall clock rollback cannot duplicate period")
        ledger.advance(now: now.addingTimeInterval(86400 * 2), sampled: true)
        check(ledger.outbox.count == 3, "no background heartbeat or inactive-day summaries")
        ledger.prune(now: now.addingTimeInterval(86400 * 10))
        check(ledger.outbox.isEmpty && ledger.loss == 3, "offline retention bounded with loss disclosed")
        for _ in 0..<300 { ledger.enqueue(.features, ["tracking_write_count": .number(1)], now: now) }
        check(ledger.outbox.count == 256 && ledger.loss == 47, "queue full drops telemetry without blocking")
        for _ in 0..<1100 { _ = ledger.once(UUID().uuidString) }
        check(ledger.seen.count == 1024, "callback guard bounded")
        var limited = AnalyticsLedger(now: now)
        for _ in 0..<150 { limited.enqueue(.paywall, ["entry_point": .text("menu")], now: now) }
        check(limited.outbox.count == 100 && limited.loss == 50, "terminal flow volume capped per collection day")
        var excluded = AnalyticsLedger(now: now)
        excluded.foreground = true
        excluded.advance(now: now.addingTimeInterval(86400), sampled: false)
        check(excluded.outbox.isEmpty, "same excluded daily cohort for all envelopes")

        var attention = AnalyticsAttention()
        attention.screen = .today; attention.foreground = true; attention.last = 100
        attention.interaction(uptime: 100)
        check(attention.settle(uptime: 120)?.1 == 20, "active attention")
        check(attention.settle(uptime: 180)?.1 == 10, "idle cap excludes running timer time")
        check(attention.settle(uptime: 200)?.1 == 0, "idle stays paused")
        attention.interaction(uptime: 200)
        check(attention.settle(uptime: 207)?.1 == 7, "interaction resumes attention")
        attention.foreground = false
        check(attention.settle(uptime: 300) == nil, "background lock inactive stop attention")
        attention.foreground = true; attention.screen = nil
        check(attention.settle(uptime: 301) == nil, "unmeasured modal suspends attribution")

        var config = AnalyticsDeliveryConfiguration()
        config.projectToken = "phc_test_capture_only"
        let data = try config.payload(frozen, installation: ledger.installation)
        let outgoing = try JSONSerialization.jsonObject(with: data) as! [String: Any]
        let batch = outgoing["batch"] as! [[String: Any]]
        check(batch.count == 3, "inspect actual outgoing batch")
        let first = batch[0], payload = first["properties"] as! [String: Any]
        check(first["uuid"] as? String == frozen[0].id.uuidString, "retry uses stable uuid")
        check(payload["analytics_record_id"] as? String == frozen[0].id.uuidString, "dashboard retry dedup key")
        check(payload["$process_person_profile"] as? Bool == false && payload["$geoip_disable"] as? Bool == true, "no profiles or geoip")
        check(!String(decoding: data, as: UTF8.self).contains(sentinel), "no sensitive content in wire body")
        check(!config.eligible, "production is fail-closed")
        config.releaseChannel = "production"; config.productionEnabled = true
        check(config.eligible, "explicit production configuration")
        config.releaseChannel = "development"
        check(!config.eligible, "development never reaches sole production project")
        // Real engine delivery lifecycle, with a deterministic network boundary rather than provider traffic.
        config.releaseChannel = "production"
        let network = TestTransport()
        let delivery = Analytics(file: nil, configuration: config, transport: network)
        delivery.setConsent(true)
        delivery.created(.check, ticket: delivery.ticket)
        delivery.drain(); delivery.flush(); delivery.drain()
        let original = network.bodies.last!
        let frozenRecord = delivery.inspect()!.outbox[0]
        var upgraded = config; upgraded.appVersion = "99"; upgraded.sampleRate = 0.5
        let upgradePayload = try JSONSerialization.jsonObject(with: upgraded.payload([frozenRecord], installation: delivery.inspect()!.installation)) as! [String: Any]
        let upgradeProperties = (upgradePayload["batch"] as! [[String: Any]])[0]["properties"] as! [String: Any]
        check(upgradeProperties["app_version"] as? String == config.appVersion && upgradeProperties["sample_rate"] as? Double == 1, "queued metadata retains observation version and sampling across upgrade")
        network.complete(false, 503); delivery.drain()
        check(delivery.inspect()?.outbox.count == 1, "offline/server failure retains queue")
        delivery.flush(); delivery.drain()
        check(network.bodies.count == 1, "retry backoff suppresses repeated flush")
        delivery.retryForTesting()
        check(network.bodies.last == original && network.bodies.count == 2, "retry preserves exact payload and record identity")
        delivery.setConsent(false)
        network.complete(true, 200); delivery.drain()
        check(delivery.inspect() == nil && network.cancelled, "late request acknowledgement cannot revive opted-out ledger")
        delivery.setConsent(true); delivery.created(.quit, ticket: delivery.ticket); delivery.drain()
        delivery.flush(); delivery.drain(); network.complete(true, 200); delivery.drain()
        check(delivery.inspect()?.outbox.isEmpty == true, "successful acknowledgement removes only sent records")
        delivery.created(.amount, ticket: delivery.ticket); delivery.drain(); delivery.flush(); delivery.drain()
        network.complete(false, 400); delivery.drain()
        check(delivery.inspect()?.outbox.isEmpty == true && delivery.inspect()?.loss == 1, "invalid batch cannot permanently stall queue")
        check(!AnalyticsContract.valid(.purchase, ["product_tier": .text("plus"), "result": .text("success"), "verification": .text("store"), "failure_code": .text("none")]), "optimistic purchase success rejected")
        check(!AnalyticsContract.valid(.account, ["action": .text("register"), "provider": .text("apple"), "result": .text("failed"), "new_account": .text("true"), "failure_code": .text("unknown")]), "failed registration cannot claim new account")
        print("Analytics contract: \(checks) checks passed; inspected \(batch.count) outgoing envelopes. No network requests.")
    }
}

nonisolated final class TestTransport: AnalyticsSending, @unchecked Sendable {
    private let lock = NSLock()
    private var pending: (@Sendable (Bool, Int?) -> Void)?
    private var captured: [Data] = []
    private var didCancel = false
    var bodies: [Data] { lock.lock(); defer { lock.unlock() }; return captured }
    var cancelled: Bool { lock.lock(); defer { lock.unlock() }; return didCancel }
    func send(_ data: Data, completion: @escaping @Sendable (Bool, Int?) -> Void) {
        lock.lock(); captured.append(data); pending = completion; lock.unlock()
    }
    func cancel() { lock.lock(); didCancel = true; lock.unlock() }
    func complete(_ success: Bool, _ code: Int) {
        lock.lock(); let callback = pending; pending = nil; lock.unlock()
        callback?(success, code)
    }
}
