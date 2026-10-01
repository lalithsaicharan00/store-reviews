import Foundation

/// A local consent generation and random operation guard, never a business-object identity.
nonisolated struct AnalyticsTicket: Sendable { fileprivate let generation: UUID; fileprivate let operation = UUID() }

nonisolated final class Analytics: @unchecked Sendable {
    static let shared: Analytics = {
        let bundle = Bundle.main
        var config = AnalyticsDeliveryConfiguration()
        config.projectToken = bundle.object(forInfoDictionaryKey: "AnalyticsProjectToken") as? String ?? ""
        config.productionEnabled = bundle.object(forInfoDictionaryKey: "AnalyticsProductionEnabled") as? Bool ?? false
        #if !DEBUG
        config.releaseChannel = "production"
        #endif
        config.appVersion = bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0"
        config.appBuild = bundle.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "0"
        config.osMajor = ProcessInfo.processInfo.operatingSystemVersion.majorVersion
        #if DEBUG
        let perfConsent = ProcessInfo.processInfo.arguments.contains("-perf-analytics")
        #else
        let perfConsent = false
        #endif
        let excluded = !perfConsent && (ProcessInfo.processInfo.arguments.contains("-uitest") || ProcessInfo.processInfo.arguments.contains("-perf-drive"))
        let base = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
        let engine = Analytics(file: base?.appendingPathComponent(perfConsent ? "DisposableAnalyticsFixture/state.json" : "DisposableAnalytics/state.json"), configuration: config, disabled: excluded)
        // Explicit synthetic consent exercises real queue/file/touch overhead in native performance runs.
        // DEBUG channel can never send to the production project; fixture state is independent of user consent.
        if perfConsent { engine.setConsent(true) }
        return engine
    }()
    private let queue = DispatchQueue(label: "app.analytics", qos: .utility)
    private let gate = NSLock()
    private var generation: UUID?
    private let file: URL?
    private let disabled: Bool
    private let config: AnalyticsDeliveryConfiguration
    private let transport: any AnalyticsSending
    private var ledger: AnalyticsLedger?
    private var attention = AnalyticsAttention()
    private var surfaces: [(UUID, AnalyticsScreen?)] = []
    private var active = false
    private var locked = false
    private var lastWall: Date?
    private var saving = false
    private var sending = false
    private var retryAfter = Date.distantPast
    private var failures = 0

    init(file: URL?, configuration: AnalyticsDeliveryConfiguration = .init(), disabled: Bool = false, transport: any AnalyticsSending = AnalyticsTransport()) {
        self.file = file; self.config = configuration; self.disabled = disabled; self.transport = transport
        // A single bounded launch read, never the database/history. No file or identity is created before consent.
        if !disabled, let file,
           let size = try? file.resourceValues(forKeys: [.fileSizeKey]).fileSize, size <= 512_000,
           let data = try? Data(contentsOf: file), var loaded = try? JSONDecoder().decode(AnalyticsLedger.self, from: data) {
            loaded.prune(now: .now)
            if loaded.outbox.count <= AnalyticsLedger.queueLimit, loaded.seen.count <= 1024 {
                ledger = loaded; generation = UUID()
            }
        }
    }
    var sharingAvailable: Bool { config.eligible && !disabled }
    var consented: Bool { gate.lock(); defer { gate.unlock() }; return generation != nil }
    var ticket: AnalyticsTicket? {
        gate.lock(); defer { gate.unlock() }
        return generation.map { AnalyticsTicket(generation: $0) }
    }
    /// Revokes synchronously, cancels any in-flight request, then deletes independent telemetry state.
    /// An already received request cannot be recalled. No opt-out event is generated.
    func setConsent(_ enabled: Bool, now: Date = .now) {
        gate.lock()
        generation = enabled && !disabled ? UUID() : nil
        let current = generation
        gate.unlock()
        queue.sync { [self] in
            transport.cancel(); sending = false; failures = 0; retryAfter = .distantPast
            ledger = current == nil ? nil : AnalyticsLedger(now: now)
            attention = AnalyticsAttention(); lastWall = nil
            if current == nil { if let file { try? FileManager.default.removeItem(at: file) } }
            else {
                attention.foreground = active && !locked
                attention.screen = surfaces.last?.1
                attention.last = ProcessInfo.processInfo.systemUptime
                attention.interaction(uptime: ProcessInfo.processInfo.systemUptime)
                if active && !locked { markVisit() }
                save()
            }
        }
    }
    func erase() { setConsent(false) }
    private func valid(_ ticket: AnalyticsTicket?) -> Bool {
        guard let ticket else { return false }
        gate.lock(); defer { gate.unlock() }
        return generation == ticket.generation
    }
    private var sampled: Bool { ledger.map { $0.sampleBucket < max(0, min(1, config.sampleRate)) } ?? false }
    private func mutate(ticket: AnalyticsTicket?, now: Date = .now, _ body: @escaping @Sendable (inout AnalyticsLedger) -> Void) {
        guard valid(ticket) else { return }
        queue.async { [self] in
            guard valid(ticket), ledger != nil else { return }
            settle(now: now, uptime: ProcessInfo.processInfo.systemUptime)
            advance(now: now)
            if sampled { body(&ledger!) }
            save()
        }
    }
    func event(_ event: AnalyticsEvent, _ properties: [String: AnalyticsValue], ticket: AnalyticsTicket?, origin: AnalyticsOrigin = .today) {
        guard AnalyticsContract.valid(event, properties), let ticket else { return }
        mutate(ticket: ticket) { state in
            guard state.once(ticket.operation.uuidString + event.rawValue) else { return }
            state.enqueue(event, properties, origin: origin, now: .now)
        }
    }
    func cohort(_ value: String, ticket: AnalyticsTicket?) {
        guard ["fresh_first_run", "restored", "existing"].contains(value) else { return }
        mutate(ticket: ticket) { state in
            if state.cohort == nil || value == "restored" { state.cohort = value }
        }
    }
    /// Counts a bounded, content-free relay only for today's UTC period; older paging counts are discarded.
    func widgetPages(_ count: Int, ticket: AnalyticsTicket?) {
        guard count > 0, let ticket else { return }
        mutate(ticket: ticket) { state in
            guard state.once(ticket.operation.uuidString + "widget_pages") else { return }
            state.external = true
            let key = AnalyticsCounter.widgetPage.rawValue
            state.counters[key] = min(AnalyticsContract.maximumCount, (state.counters[key] ?? 0) + min(count, 100_000))
        }
    }
    func created(_ type: AnalyticsHabitType, suggestion: Bool = false, ticket: AnalyticsTicket?) {
        event(.entityCreated, ["entity_type": .text(type.entity), "habit_type": .text(type.rawValue), "creation_origin": .text(suggestion ? "suggestion" : "manual")], ticket: ticket)
    }
    func tracking(_ type: AnalyticsHabitType, origin: AnalyticsOrigin, ticket: AnalyticsTicket?) {
        guard let ticket else { return }
        mutate(ticket: ticket) { state in
            guard state.once(ticket.operation.uuidString + "tracking") else { return }
            state.increment("tracking_write_count")
            state.increment(type == .notApplicable ? "task_write_count" : "habit_write_" + type.rawValue)
            state.increment("write_origin_" + origin.rawValue)
            if type == .notApplicable { state.increment(AnalyticsCounter.taskCompleted.rawValue) }
            if origin == .history { state.increment(AnalyticsCounter.historyLog.rawValue) }
            if origin == .widget { state.increment(AnalyticsCounter.widgetAccepted.rawValue) }
            if origin == .shortcut { state.increment(AnalyticsCounter.shortcutAccepted.rawValue) }
            if origin.surface != "app" { state.external = true }
            if !state.activationObserved {
                state.activationObserved = true
                state.enqueue(.activation, ["milestone": .text("first_observed_tracking_write"), "entity_type": .text(type.entity), "habit_type": .text(type.rawValue), "cohort": .text(state.cohort ?? "unknown")], origin: origin, now: .now)
            }
        }
    }
    func count(_ counter: AnalyticsCounter, ticket: AnalyticsTicket?) {
        guard let ticket else { return }
        mutate(ticket: ticket) { state in
            guard state.once(ticket.operation.uuidString + counter.rawValue) else { return }
            state.increment(counter.rawValue, flag: counter.isFlag)
        }
    }
    func reliability(_ subsystem: String, succeeded: Bool, ticket: AnalyticsTicket?) {
        guard ["storage", "backup", "sync", "widget", "reminder"].contains(subsystem) else { return }
        mutate(ticket: ticket) { state in
            state.increment(subsystem + (succeeded ? "_success_count" : "_failure_count"))
            let wasDegraded = state.degraded.contains(subsystem)
            if succeeded { state.degraded.remove(subsystem) } else { state.degraded.insert(subsystem) }
            guard succeeded ? wasDegraded : !wasDegraded else { return }
            let transition = succeeded ? "recovered" : "degraded"
            guard state.transitions.insert(subsystem + transition).inserted else { return }
            state.enqueue(.reliability, ["subsystem": .text(subsystem), "state": .text(transition), "failure_code": .text(succeeded ? "none" : subsystem == "storage" ? "storage_write" : "unknown")], now: .now)
        }
    }
    func configuration(_ properties: [String: AnalyticsValue]) {
        guard AnalyticsContract.valid(.configuration, properties) else { return }
        mutate(ticket: ticket) { $0.configuration.merge(properties) { _, new in new } }
    }
    // Lifecycle state is kept without collecting telemetry before consent, so an opt-in can observe only the
    // currently visible screen. Tokens never leave memory or enter a payload.
    func surface(_ token: UUID, screen: AnalyticsScreen?, appeared: Bool) {
        queue.async { [self] in
            let old = surfaces.last?.0
            settle(now: .now, uptime: ProcessInfo.processInfo.systemUptime)
            surfaces.removeAll { $0.0 == token }
            if appeared { surfaces.append((token, screen)) }
            attention.screen = surfaces.last?.1
            if old != surfaces.last?.0 { attention.interaction(uptime: ProcessInfo.processInfo.systemUptime); markVisit() }
            save()
        }
    }
    func lifecycle(active: Bool, locked: Bool) {
        queue.async { [self] in
            settle(now: .now, uptime: ProcessInfo.processInfo.systemUptime)
            let was = attention.foreground
            self.active = active; self.locked = locked
            attention.foreground = active && !locked
            if attention.foreground && !was { attention.interaction(uptime: ProcessInfo.processInfo.systemUptime); markVisit() }
            save(); flushOnQueue()
        }
    }
    func interaction() {
        // Called by a content-blind native gesture observer, no touch coordinates/text captured.
        guard consented else { return }
        queue.async { [self] in
            let uptime = ProcessInfo.processInfo.systemUptime
            settle(now: .now, uptime: uptime); attention.interaction(uptime: uptime)
            save()
        }
    }
    private func advance(now: Date) {
        let included = sampled
        ledger?.advance(now: now, sampled: included)
    }
    private func markVisit() {
        guard consented, ledger != nil, attention.foreground else { return }
        ledger?.foreground = true
        if let screen = attention.screen {
            let old = ledger?.visits[screen.rawValue] ?? 0
            ledger?.visits[screen.rawValue] = min(100_000, old + 1)
        }
    }
    private func settle(now: Date, uptime: TimeInterval) {
        let interval = attention.settle(uptime: uptime)
        defer { lastWall = now }
        guard consented, ledger != nil else { return }
        // Split the eligible interval at UTC midnight. Wall-clock changes never create extra attention.
        if let (screen, duration) = interval, duration > 0, let lastWall {
            let midnight = Double(AnalyticsLedger.day(now))
            let before = min(duration, max(0, midnight - lastWall.timeIntervalSince1970))
            if before > 0 { ledger?.seconds[screen.rawValue, default: 0] += before }
            advance(now: now)
            ledger?.seconds[screen.rawValue, default: 0] += duration - before
        } else { advance(now: now) }
        if attention.foreground { ledger?.foreground = true }
    }
    func flush() { queue.async { [self] in settle(now: .now, uptime: ProcessInfo.processInfo.systemUptime); save(); flushOnQueue() } }
    private func flushOnQueue() {
        guard consented, config.eligible else { return }
        // A development/beta ledger must never be forwarded to the sole production project after upgrading.
        if let count = ledger?.outbox.count {
            ledger?.outbox.removeAll { $0.observation?.releaseChannel != "production" }
            let retained = ledger?.outbox.count ?? 0
            let loss = ledger?.loss ?? 0
            ledger?.loss = min(100_000, loss + count - retained)
        }
        guard !sending, Date.now >= retryAfter, let ledger, !ledger.outbox.isEmpty,
              let ticket, let data = try? config.payload(Array(ledger.outbox.prefix(20)), installation: ledger.installation) else { return }
        let ids = Set(ledger.outbox.prefix(20).map(\.id))
        sending = true
        transport.send(data) { [weak self] success, code in
            guard let self else { return }
            self.queue.async {
                guard self.valid(ticket) else { return }
                self.sending = false
                if success { self.ledger?.outbox.removeAll { ids.contains($0.id) }; self.failures = 0 }
                else {
                    self.failures = min(8, self.failures + 1)
                    self.retryAfter = Date.now.addingTimeInterval(min(3600, pow(2, Double(self.failures)) * 30))
                    // No response bodies/raw errors are retained. Invalid records cannot stall the queue forever.
                    if code == 400 || code == 413 { self.ledger?.outbox.removeAll { ids.contains($0.id) }; self.ledger?.loss += ids.count }
                }
                self.save()
                // Further batches/retries wait for eligible lifecycle/explicit flush, never wake the app.
            }
        }
    }
    private func save() {
        // Freeze metadata at observation, not at a later upload after an app/OS/sampling update.
        if let count = ledger?.outbox.count {
            for index in 0..<count where ledger?.outbox[index].observation == nil {
                ledger?.outbox[index].observation = config.observation
            }
        }
        guard !saving, file != nil else { return }
        saving = true
        queue.asyncAfter(deadline: .now() + 0.5) { [self] in
            saving = false
            guard consented, let ledger, let file, let data = try? JSONEncoder().encode(ledger), data.count <= 512_000 else { return }
            do {
                let folder = file.deletingLastPathComponent()
                try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
                var excludedFolder = folder
                var values = URLResourceValues(); values.isExcludedFromBackup = true
                try excludedFolder.setResourceValues(values)
                #if os(iOS)
                try data.write(to: file, options: [.atomic, .completeFileProtectionUntilFirstUserAuthentication])
                #else
                try data.write(to: file, options: .atomic)
                #endif
            } catch { /* Telemetry loss is allowed; never changes the app's storage/backup error state. */ }
        }
    }
    #if DEBUG
    /// Native tests inspect the exact ledger/payload; never enabled by a production event or remote flag.
    func inspect() -> AnalyticsLedger? { queue.sync { ledger } }
    func drain() { queue.sync {} }
    func retryForTesting() { queue.sync { retryAfter = .distantPast; flushOnQueue() } }
    #endif
}
