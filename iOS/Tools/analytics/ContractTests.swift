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
        let disabled = Analytics(file: nil, disabled: true)
        disabled.setConsent(true)
        check(disabled.ticket == nil, "CI/debug fixtures cannot opt in to production")
        analytics.erase()
        check(!analytics.consented, "erase clears consent")

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
        for _ in 0..<300 { ledger.enqueue(.paywall, ["entry_point": .text("menu")], now: now) }
        check(ledger.outbox.count == 256 && ledger.loss == 47, "queue full drops telemetry without blocking")
        for _ in 0..<1100 { _ = ledger.once(UUID().uuidString) }
        check(ledger.seen.count == 1024, "callback guard bounded")
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
        print("Analytics contract: \(checks) checks passed; inspected \(batch.count) outgoing envelopes. No network requests.")
    }
}
