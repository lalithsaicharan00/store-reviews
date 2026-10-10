import Core
import Foundation
import Observation
import UIKit

/// Sync with the person's own iCloud (Architecture 11; Rulebook D16): one `CKSyncEngine` (behind `CloudTransport`), the
/// phone's database as the truth, the outbox as the record of what hasn't reached iCloud.
///
/// **Data is never lost** (the user, 10 Oct 2026: "that comes first"), so:
/// - A change leaves the outbox only when CloudKit confirms a saved record that contains it (`CloudStore.saved`). On every
///   launch, and whenever the app comes back, every row with changes waiting is put back on the engine's queue, which
///   can lose items (a full iCloud, a crash, a lost state, §7.4).
/// - Nothing in iCloud ever deletes anything here: not a sign-out, another Apple Account, a full iCloud, a deleted or
///   purged zone (§10–11). A different Apple Account or a purged zone asks first.
/// - Fetched changes are merged in one transaction before the event returns, so the engine's saved position never runs
///   ahead of the data (§8); fetched deletes beyond the brake are held until the person says (§13.2), and so are this
///   device's own, before they're sent.
/// - The free plan's old device sends what it has before it stops (§12).
/// - Nothing is sent until a fresh install's welcome is finished, so an empty phone never looks like the truth (§13.1).
///
/// The iCloud page reads its state; Today reads none of it (its small card reads `attention` alone).
@Observable
final class CloudSync: CloudTransportHandler {
    /// Where sync stands, as the iCloud page says it (§17), status first.
    enum Phase: Equatable {
        /// Working out the account and the plan (launch).
        case starting
        case off(Off)
        /// A question only the person can answer (§10–11): nothing syncs until they do.
        case asking(Question)
        /// Free plan: another device is the one syncing (§12).
        case otherDevice(name: String)
        case on
    }

    enum Off: Equatable {
        /// No Apple Account, or iCloud turned off for the app.
        case noAccount
        /// Screen Time or a managed device.
        case restricted
        /// iCloud can't be reached right now (account temporarily unavailable).
        case unavailable
        /// The person chose to keep this iPhone's habits off iCloud ("Keep on This iPhone Only", "Not Now").
        case turnedOff
        /// The person deleted their data from iCloud here.
        case deleted
    }

    enum Question: Equatable {
        /// This iPhone now uses a different Apple Account; its iCloud has this many habits (nil: not known).
        case differentAccount(iCloudHabits: Int?)
        /// The habits were removed from iCloud (by the person in Settings, or from another device).
        case removed
    }

    private(set) var phase: Phase = .starting
    /// Rows with changes not yet confirmed by iCloud.
    private(set) var waiting = 0
    /// Changes that can never be accepted (too large, refused), kept aside.
    private(set) var keptAside = 0
    /// Records fetched that this version can't read, kept aside.
    private(set) var unreadable = 0
    /// When iCloud last confirmed everything (nothing waiting) or changes last came in.
    private(set) var lastSynced: Date?
    /// iCloud is full (§7): the outbox keeps everything; retried when the app opens, the account changes, or a day passes.
    private(set) var isFull = false
    /// A big fetch is coming in (a new device, an extreme account): how many records so far (§8).
    private(set) var bringingIn: Int?
    /// Deletes fetched from iCloud that the brake is holding (§13.2).
    private(set) var heldDeletes = 0
    /// This device's own deletes the brake is holding before they're sent (§13.2).
    private(set) var outgoingDeletes = 0
    /// The free plan's syncing device, and every device that syncs (Plus) (§12, §17).
    private(set) var active: CloudActive?
    private(set) var devices: [CloudDevice] = []
    /// A fresh install has looked in iCloud once (the welcome waits for it, §13.1).
    private(set) var firstLookDone = false
    /// Sync Now, Move Here, Back Up Again… is running.
    private(set) var working = false
    /// The last thing that went wrong, for the page's small print and diagnostics; nil once something works.
    private(set) var lastProblem: String?
    /// The second-device sheet (§12; the Plus screens' image 16): shown once per device that became the syncing one.
    var secondDevice: SecondDeviceAsk?
    /// Shown once on the old device after a handover: "Your habits now sync on your iPad…".
    var handedOverTo: String?

    struct SecondDeviceAsk: Identifiable, Equatable {
        let id = UUID()
        let otherDevice: String
    }

    @ObservationIgnored let transport: CloudTransport
    @ObservationIgnored private let repository: HabitRepository
    @ObservationIgnored private let identity: DeviceIdentity
    /// This device's ID (the Keychain's, read when first needed, never at launch).
    var deviceID: String { identity.deviceID }
    /// Plus syncs every device; free, one (§12). Read when needed (StoreKit decides, the Plus screens).
    @ObservationIgnored var isPlus: () -> Bool = { false }
    /// Sending waits for a fresh install's welcome (§13.1): true once it's finished or there are habits.
    @ObservationIgnored var sendingAllowed: () -> Bool = { true }
    /// Live habits here, for the device record (§10's "its iCloud has 14 habits").
    @ObservationIgnored var habitCount: () -> Int = { 0 }
    /// Called after other devices' changes were merged in, so the screen re-reads them.
    @ObservationIgnored var onRemoteChanges: (() -> Void)?
    /// Called when changes are left waiting after a failure, so iOS is asked for a background retry.
    @ObservationIgnored var onWaitingAfterFailure: (() -> Void)?
    /// `identifierForVendor`, for the clone check (§13.4).
    @ObservationIgnored var vendorID: () -> String? = { UIDevice.current.identifierForVendor?.uuidString }

    @ObservationIgnored private var starting: Task<Void, Never>?
    @ObservationIgnored private var started = false
    @ObservationIgnored private var user: String?
    /// Records being sent, and the outbox position each was built at (`CloudStore.saved` removes up to it).
    @ObservationIgnored private var inflight: [String: Int64] = [:]
    /// Rows not put back on the queue until the next launch or return to the app (a failure that isn't theirs to fix).
    @ObservationIgnored private var parked: Set<String> = []
    /// This fetch run: live rows when it began, and how many fetched deletes went through (the brake, §13.2).
    @ObservationIgnored private var runLive = 0
    @ObservationIgnored private var runDeleted = 0
    @ObservationIgnored private var runFetched = 0
    /// The person chose "Delete My Data From iCloud" here: the zone deletion it causes is expected.
    @ObservationIgnored private var deletingEverything = false
    /// A save found no zone: why is learned from the next fetch before anything is uploaded again (§7, §11).
    @ObservationIgnored private var zoneMissing = false
    @ObservationIgnored private var reloadPending = false
    @ObservationIgnored private var lastRemoteChange = Date.distantPast
    /// Between the engine's "will fetch" and "did fetch".
    @ObservationIgnored private var fetching = false
    @ObservationIgnored private var reloadedThisFetch = false
    /// Work started in the background (the engine's start, a hand-over, a zone made again), so `idle()` can wait for it.
    @ObservationIgnored private var background: [UUID: Task<Void, Never>] = [:]

    /// Starts `work` in the background, tracked.
    private func track(_ work: @escaping @MainActor () async -> Void) {
        let id = UUID()
        background[id] = Task { [weak self] in
            await work()
            self?.background[id] = nil
        }
    }

    /// Waits until every piece of background work has finished (checks; also a background refresh's end).
    func idle() async {
        for _ in 0..<100 {
            guard let next = background.values.first else { return }
            await next.value
        }
    }

    /// Keys kept in the database beside the data (`CloudStore.state`), so they're backed up and restored together (§9).
    private enum Key {
        static let engine = "engine"
        static let user = "user"
        static let vendor = "vendor"
        /// "turnedOff" or "deleted": the person's choice to keep this device off iCloud.
        static let off = "off"
        /// The Apple Account the person chose to keep this iPhone's habits away from (§10).
        static let declined = "declined"
        /// "removed": waiting on "Back Up Again?" (§11).
        static let question = "question"
        static let fullSince = "fullSince"
        /// "1": the person said send this device's deletes (§13.2), until none are waiting.
        static let deletesApproved = "deletesApproved"
        /// "1": an apply failed after the engine moved on; the next start fetches everything again (§9).
        static let refetch = "refetch"
        /// The last syncing device this free device saw (its handover sheet shows once per device).
        static let askedFor = "askedFor"
        /// "1": this free device was the syncing one, so going offline doesn't stop it (§12).
        static let wasActive = "wasActive"
    }

    init(repository: HabitRepository, transport: CloudTransport, identity: DeviceIdentity) {
        self.repository = repository
        self.transport = transport
        self.identity = identity
        transport.handler = self
    }

    private var store: CloudStore { repository.cloud }

    // MARK: Starting (launch, account changes)

    /// At launch: the clone check, then the account and the plan decide whether the engine runs. Runs once; later
    /// callers wait for it. After that the engine's account events (and the app coming back) decide.
    func start() async {
        if started { return }
        if let starting { return await starting.value }
        let task = Task { [self] in
            await cloneCheck()
            _ = try? await store.retryKeptAside()
            await evaluate()
            await refreshCounts()
        }
        starting = task
        await task.value
        starting = nil
        started = true
    }

    /// A device restored from another iPhone's backup carries its database, and with it the same clock node: a new node,
    /// so two devices never make the same stamp (§13.4).
    private func cloneCheck() async {
        guard let vendor = vendorID() else { return }
        let stored = try? await store.state(key: Key.vendor)
        if let stored, stored != vendor { try? await store.renewNode() }
        if stored != vendor { try? await store.setState(key: Key.vendor, value: vendor) }
    }

    /// Decides from the account what happens now (§10).
    private func evaluate() async {
        let status = await transport.accountStatus()
        switch status {
        case .available(let user):
            self.user = user
            if let off = try? await store.state(key: Key.off) {
                stopEngine()
                phase = .off(off == "deleted" ? .deleted : .turnedOff)
                return
            }
            if (try? await store.state(key: Key.declined)) == user {
                stopEngine()
                phase = .off(.turnedOff)
                return
            }
            let mine = "icloud:" + user
            let bound = try? await store.account()
            if bound == mine {
                await resume()
            } else if let bound, bound.hasPrefix("icloud:") {
                // A different Apple Account: ask first, never a silent upload or wipe (§10).
                stopEngine()
                phase = .asking(.differentAccount(iCloudHabits: nil))
                await peekAtAccount()
            } else {
                // The first time (or after the server-era account): everything here goes up, merged by ID.
                do {
                    try await store.bind(account: mine)
                    try? await store.setState(key: Key.user, value: user)
                    await resume()
                } catch {
                    lastProblem = "\(error)"
                    phase = .off(.unavailable)
                }
            }
        case .noAccount:
            stopEngine()
            phase = .off(.noAccount)
        case .restricted:
            stopEngine()
            phase = .off(.restricted)
        case .temporarilyUnavailable, .couldNotDetermine:
            stopEngine()
            phase = .off(.unavailable)
        }
    }

    /// What the other Apple Account's iCloud holds, from its device records (§10).
    private func peekAtAccount() async {
        guard let control = try? await transport.readControl() else { return }
        let most = control.devices.map(\.habits).max() ?? 0
        if case .asking(.differentAccount) = phase { phase = .asking(.differentAccount(iCloudHabits: most)) }
    }

    /// The account is this device's: unless a question waits or another free device syncs, the engine runs.
    private func resume() async {
        if (try? await store.state(key: Key.question)) == "removed" {
            stopEngine()
            phase = .asking(.removed)
            return
        }
        if !isPlus() {
            guard await mayRunOnFreePlan() else { return }
        }
        run()
    }

    /// Free: one syncing device (§12). The first device takes it; another device asks (Move Here); offline, the device
    /// that was syncing keeps going (two offline devices: the first to reach iCloud keeps it, the other flushes and stops).
    private func mayRunOnFreePlan() async -> Bool {
        do {
            let (active, devices) = try await transport.readControl()
            self.active = active
            self.devices = devices
            if let active, active.deviceID != deviceID {
                stopEngine()
                try? await store.setState(key: Key.wasActive, value: nil)
                phase = .otherDevice(name: active.name)
                await askAboutSecondDevice(active)
                return false
            }
            if active == nil {
                self.active = try await transport.claimActive(thisDevice(), expected: nil)
            }
            try? await store.setState(key: Key.wasActive, value: "1")
            return true
        } catch CloudTransportError.changed(let current) {
            // Another device took it a moment ago.
            self.active = current
            stopEngine()
            phase = .otherDevice(name: current?.name ?? "")
            if let current { await askAboutSecondDevice(current) }
            return false
        } catch {
            // Offline: carry on only if this device was the syncing one.
            lastProblem = "\(error)"
            if (try? await store.state(key: Key.wasActive)) == "1" { return true }
            phase = .off(.unavailable)
            return false
        }
    }

    /// The second-device sheet, once per device that became the syncing one, and only when iCloud has habits (§12).
    private func askAboutSecondDevice(_ active: CloudActive) async {
        let key = active.deviceID + "@" + String(Int(active.at.timeIntervalSince1970))
        guard (try? await store.state(key: Key.askedFor)) != key else { return }
        try? await store.setState(key: Key.askedFor, value: key)
        secondDevice = SecondDeviceAsk(otherDevice: active.name)
    }

    private func thisDevice() -> CloudActive {
        CloudActive(deviceID: deviceID, name: DeviceIdentity.name, at: .now, system: nil)
    }

    /// Runs the engine from its saved state, puts every waiting row on its queue, fetches, then sends.
    private func run() {
        phase = .on
        guard !transport.isRunning else { return kick() }
        track { [self] in
            var state = (try? await store.state(key: Key.engine)).flatMap { Data(base64Encoded: $0) }
            if (try? await store.state(key: Key.refetch)) == "1" {
                // An apply failed after the engine moved on: everything again (merges are idempotent, §9).
                state = nil
                try? await store.setState(key: Key.refetch, value: nil)
            }
            transport.start(state: state)
            transport.ensureZone()
            await refill(force: true)
            await saveDeviceRecord()
            await fetchNow()
            await sendNow()
        }
    }

    private func kick() {
        track { [self] in
            await fetchNow()
            await sendNow()
        }
    }

    private func stopEngine() {
        transport.stop()
        bringingIn = nil
        fetching = false
    }

    // MARK: The queue (§7)

    /// Puts rows with changes waiting back on the engine's queue: a window of them, so its state stays small however
    /// long the outbox is (an extreme first upload); more as these go.
    private func refill(force: Bool = false) async {
        guard transport.isRunning else { return }
        let pending = transport.pendingSaves
        guard force || pending.count < Self.lowWater else { return }
        guard let names = try? await store.waitingRows(limit: Int32(Self.window)) else { return }
        let missing = names.filter { !pending.contains($0) && !parked.contains($0) }
        transport.addPendingSaves(missing)
    }

    static let window = 2_000
    static let lowWater = 500

    /// Sending is paused while the brake waits, a full iCloud waits, a fresh install's welcome isn't finished, or
    /// sync isn't on.
    private var canSend: Bool {
        phase == .on && heldDeletes == 0 && outgoingDeletes == 0 && !isFull && sendingAllowed()
    }

    func records(for names: [String]) async -> [CloudRowRecord] {
        guard canSend else { return [] }
        do {
            let batch = try await store.batch(names: names)
            let gone = batch.refused + batch.missing
            if !gone.isEmpty { transport.removePendingSaves(gone) }
            if !batch.refused.isEmpty { keptAside += batch.refused.count }
            if batch.deletes > 0 {
                // Deletes are going: the brake looks first, whoever started this send (§13.2).
                await checkOutgoingBrake()
                guard canSend else { return [] }
            }
            return batch.rows.map { row in
                // Built twice before an answer (never expected): the older position, so a confirmation never removes
                // more than the record it confirms held.
                inflight[row.name] = min(inflight[row.name] ?? row.upTo, row.upTo)
                return CloudRowRecord(name: row.name, table: row.table, row: row.row, fields: row.fields, clocks: row.clocks,
                                      schema: Int64(row.schema), format: Int64(CloudStore.companion.FORMAT),
                                      system: row.system.flatMap { Data(base64Encoded: $0) }, upTo: row.upTo)
            }
        } catch {
            lastProblem = "\(error)"
            return []
        }
    }

    // MARK: Events

    func handle(_ event: CloudEvent) async {
        switch event {
        case .stateUpdate(let data):
            try? await store.setState(key: Key.engine, value: data.base64EncodedString())
        case .account(let change):
            switch change {
            case .signOut:
                stopEngine()
                phase = .off(.noAccount)
            case .signIn, .switched:
                await evaluate()
            }
        case .willFetch:
            fetching = true
            reloadedThisFetch = false
            runLive = Int((try? await store.counts())?.liveRecords ?? 0)
            runDeleted = 0
            runFetched = 0
        case .fetchedRows(let rows):
            await apply(rows)
        case .fetchedControl(let devices, let active):
            for device in devices {
                if let at = self.devices.firstIndex(where: { $0.id == device.id }) { self.devices[at] = device } else { self.devices.append(device) }
            }
            if let active {
                self.active = active
                // Never from inside the engine's own event: the hand-over sends, and the engine is busy with this fetch.
                if !isPlus() && active.deviceID != deviceID && phase == .on { track { [self] in await handOver(to: active) } }
            }
        case .fetchedDeletions:
            break // a record that's gone from iCloud deletes nothing here: only its `deleted_at` field does (§8)
        case .zoneDeleted(let zone, let reason):
            guard zone == .habits else { return }
            await zoneDeleted(reason)
        case .didFetch:
            fetching = false
            bringingIn = nil
            firstLookDone = true
            zoneMissing = await zoneStillMissing()
            await refreshCounts()
        case .sent(let saved, let failed):
            await sent(saved, failed)
        case .zoneSaveFailed(_, let failure):
            if failure == .quotaExceeded { await markFull() } else { lastProblem = "zone: \(failure)" }
        case .didSend:
            await refreshCounts()
        }
    }

    /// Fetched rows, merged in one transaction before the engine moves on (§8), through the brake (§13.2).
    private func apply(_ rows: [CloudRowRecord]) async {
        let incoming = rows.map {
            CloudIncoming(name: $0.name, fields: $0.fields, clocks: $0.clocks, format: Int32(clamping: $0.format),
                          system: $0.system?.base64EncodedString())
        }
        do {
            let allowance = CloudStore.companion.incomingAllowance(liveAtStart: Int32(clamping: runLive), deletedSoFar: Int32(clamping: runDeleted))
            let applied = try await store.fetched(records: incoming, deleteAllowance: allowance, holdAll: heldDeletes > 0)
            if applied.held {
                heldDeletes = Int((try? await store.counts())?.heldDeletes ?? applied.deleted)
            } else {
                runDeleted += Int(applied.deleted)
                if applied.changed > 0 { remoteChanged() }
            }
            if applied.quarantined > 0 { unreadable += Int(applied.quarantined) }
            runFetched += rows.count
            if runFetched >= Self.bigFetch { bringingIn = runFetched }
        } catch {
            // Not applied, and the engine is about to move on: fetch everything again on the next start (§9).
            lastProblem = "\(error)"
            try? await store.setState(key: Key.refetch, value: "1")
        }
    }

    /// From this many records in one fetch, the page says it's bringing habits in.
    static let bigFetch = 500

    /// The screen re-reads once the changes stop (Rulebook S16), not once per page of a big fetch: re-reading a year's
    /// history every 300 ms of a 20,000-record fetch froze Today's taps, and every re-read (hundreds of ms with that
    /// much history) slowed the fetch and showed as a hitch (the speed runs, 10 Oct 2026). During a fetch it re-reads
    /// soon after the first page (habits come first, and the welcome says what has come), then every 15 s, and once
    /// it ends.
    private func remoteChanged() {
        lastRemoteChange = .now
        guard !reloadPending else { return }
        reloadPending = true
        let first = Date.now
        let gap: TimeInterval = reloadedThisFetch ? 15 : 1
        track { [self] in
            while true {
                try? await Task.sleep(for: .milliseconds(200))
                let waited = Date.now.timeIntervalSince(first)
                if fetching ? waited >= gap : (Date.now.timeIntervalSince(lastRemoteChange) >= 0.6 || waited >= 4) { break }
            }
            if fetching { reloadedThisFetch = true }
            reloadPending = false
            onRemoteChanges?()
        }
    }

    private func sent(_ saved: [CloudRowRecord], _ failed: [CloudSaveFailure]) async {
        let confirmed = saved.map { CloudSaved(name: $0.name, system: $0.system?.base64EncodedString(), upTo: inflight.removeValue(forKey: $0.name) ?? 0) }
        if !confirmed.isEmpty {
            do { _ = try await store.saved(results: confirmed) } catch { lastProblem = "\(error)" }
            lastProblem = nil
        }
        var again: [String] = []
        for failure in failed {
            inflight[failure.name] = nil
            switch failure.failure {
            case .conflict(let server):
                // iCloud has a newer copy: merge it in and send the merged row (the merge is the same on every device).
                await apply([server])
                if heldDeletes == 0 { again.append(failure.name) }
            case .unknownItem:
                try? await store.forgetSystemFields(names: [failure.name])
                again.append(failure.name)
            case .zoneNotFound:
                zoneMissing = true
            case .quotaExceeded:
                await markFull()
            case .limitExceeded:
                again.append(failure.name)
            case .invalidArguments(let why):
                try? await store.keepAside(name: failure.name, problem: "refused: " + String(why.prefix(80)))
                keptAside += 1
            case .other(let why):
                lastProblem = why
                parked.insert(failure.name)
            }
        }
        transport.addPendingSaves(again)
        if zoneMissing { track { [self] in await learnWhyTheZoneIsMissing() } }
        await refill()
        if !failed.isEmpty, again.isEmpty { onWaitingAfterFailure?() }
    }

    /// iCloud is full (§7): the outbox keeps everything; nothing is retried until the app opens, the account changes,
    /// or a day passes.
    private func markFull() async {
        isFull = true
        if (try? await store.state(key: Key.fullSince)) == nil {
            try? await store.setState(key: Key.fullSince, value: String(Int(Date.now.timeIntervalSince1970)))
        }
    }

    /// A save found no zone. A fetch says why (§11): removed by the person or another device asks first; otherwise the
    /// zone is made again and everything here goes up again.
    private func learnWhyTheZoneIsMissing() async {
        await fetchNow()
        guard zoneMissing, phase == .on else { return }
        zoneMissing = false
        transport.ensureZone()
        try? await store.uploadEverythingAgain()
        await refill(force: true)
        await sendNow()
    }

    private func zoneStillMissing() async -> Bool { zoneMissing && phase == .on }

    /// The `Habits` zone is gone (§11). Nothing here is deleted.
    private func zoneDeleted(_ reason: CloudZoneDeletion) async {
        zoneMissing = false
        try? await store.forgetAllSystemFields()
        switch reason {
        case .encryptedDataReset:
            // Apple's guidance: make the zone again and upload everything from the phone.
            transport.ensureZone()
            try? await store.uploadEverythingAgain()
            await refill(force: true)
        case .deleted where deletingEverything:
            break
        case .deleted, .purged:
            stopEngine()
            try? await store.setState(key: Key.question, value: "removed")
            phase = .asking(.removed)
        }
    }

    /// Free plan: another device became the syncing one (§12). This device first sends what it has (changes made
    /// before the handover), then stops, keeping everything. Its later changes stay here, in its outbox and backups.
    private func handOver(to active: CloudActive) async {
        for _ in 0..<5 where waiting > 0 || !transport.pendingSaves.isEmpty {
            await refill(force: true)
            do { try await transport.sendChanges() } catch { break }
            await refreshCounts()
        }
        stopEngine()
        try? await store.setState(key: Key.wasActive, value: nil)
        phase = .otherDevice(name: active.name)
        handedOverTo = active.name
    }

    // MARK: Asking iCloud

    private func fetchNow() async {
        guard transport.isRunning else { return }
        do {
            try await transport.fetchChanges()
            firstLookDone = true
        } catch {
            lastProblem = "\(error)"
        }
    }

    private func sendNow() async {
        guard transport.isRunning else { return }
        await checkOutgoingBrake()
        guard canSend else { return }
        do {
            try await transport.sendChanges()
        } catch {
            lastProblem = "\(error)"
            if waiting > 0 { onWaitingAfterFailure?() }
        }
        await refreshCounts()
    }

    /// The brake for this device's own deletes (§13.2): too many at once, not one action the person confirmed, waits.
    private func checkOutgoingBrake() async {
        guard let counts = try? await store.counts() else { return }
        if counts.waitingDeletes == 0 {
            try? await store.setState(key: Key.deletesApproved, value: nil)
            outgoingDeletes = 0
            return
        }
        let approved = (try? await store.state(key: Key.deletesApproved)) == "1"
        let trips = CloudStore.companion.outgoingBrake(deletes: counts.waitingDeletes, live: counts.liveRecords)
        outgoingDeletes = trips && !approved ? Int(counts.waitingDeletes) : 0
    }

    private func refreshCounts() async {
        guard let counts = try? await store.counts() else { return }
        waiting = Int(counts.waitingRows)
        keptAside = Int(counts.keptAside)
        unreadable = Int(counts.unreadable)
        heldDeletes = Int(counts.heldDeletes)
        let last = [counts.lastSent, counts.lastFetched].compactMap { $0.map { Date(timeIntervalSince1970: Double($0.int64Value) / 1000) } }.max()
        if waiting == 0, let last { lastSynced = last }
        if waiting == 0 && counts.waitingDeletes == 0 { try? await store.setState(key: Key.deletesApproved, value: nil) }
    }

    private func saveDeviceRecord() async {
        if let control = try? await transport.readControl() {
            if let active = control.active { self.active = active }
            devices = control.devices
        }
        let device = CloudDevice(id: deviceID, name: DeviceIdentity.name, platform: DeviceIdentity.platform, lastSync: .now, habits: habitCount())
        try? await transport.saveDevice(device)
        if let at = devices.firstIndex(where: { $0.id == deviceID }) { devices[at] = device } else { devices.append(device) }
    }

    // MARK: What the app and the person do

    /// Sync Now: retries what waits (a full iCloud too), fetches, sends.
    func syncNow() async {
        if phase == .starting || !transport.isRunning {
            await start()
            if !transport.isRunning { return }
        }
        working = true
        defer { working = false }
        parked = []
        if isFull {
            isFull = false
            try? await store.setState(key: Key.fullSince, value: nil)
        }
        await refill(force: true)
        await fetchNow()
        await sendNow()
    }

    /// The app is on screen again: everything waiting is retried (the engine's queue may have lost items, a full iCloud
    /// is tried again), the free plan's device checked, then fetch and send (pushes aren't guaranteed, §8).
    func appBecameActive() {
        track { [self] in
            await start()
            guard phase == .on else {
                // iCloud off, unavailable, or another free device syncing: see if that changed (no engine, no events).
                switch phase {
                case .otherDevice, .off(.noAccount), .off(.unavailable), .off(.restricted): await evaluate()
                default: break
                }
                return
            }
            if !isPlus() {
                let mayRun = await mayRunOnFreePlan()
                if !mayRun { return }
            }
            parked = []
            if isFull {
                isFull = false
                try? await store.setState(key: Key.fullSince, value: nil)
            }
            await refill(force: true)
            await fetchNow()
            await sendNow()
        }
    }

    /// Leaving the app: a change still waiting for its quiet moment goes now, with time from iOS.
    func appWentToBackground() {
        if debounce != nil { scheduleSoon() }
    }

    // MARK: Sending soon after a change (§15, D12)

    @ObservationIgnored private var debounce: Task<Void, Never>?
    @ObservationIgnored private var firstWaiting: Date?
    @ObservationIgnored private var awake = UIBackgroundTaskIdentifier.invalid
    @ObservationIgnored private var generation = 0

    /// After a change (in the app, or from a widget, a notification or the Live Activity, which save through the app):
    /// sent soon, as one request for a run of changes, while iOS keeps the app running for it (`beginBackgroundTask`),
    /// so it reaches iCloud without the app being opened (§15).
    /// - In front: 3 s of quiet, never more than 10 s after the first change waiting.
    /// - In the background: 2 s.
    func scheduleSoon() {
        guard phase == .on || phase == .starting else { return }
        holdAwake()
        generation += 1
        let mine = generation
        let now = Date.now
        let first = firstWaiting ?? now
        firstWaiting = first
        let quiet = UIApplication.shared.applicationState == .active ? Self.quietInFront : Self.quietInBackground
        let wait = max(0, min(quiet, first.addingTimeInterval(Self.longestWait).timeIntervalSince(now)))
        debounce?.cancel()
        debounce = Task { [weak self] in
            try? await Task.sleep(for: .seconds(wait))
            guard !Task.isCancelled, let self else { return }
            self.firstWaiting = nil
            self.debounce = nil
            await self.start()
            await self.refill(force: true)
            await self.sendNow()
            if self.generation == mine { self.releaseAwake() }
        }
    }

    static let quietInFront: TimeInterval = 3
    static let quietInBackground: TimeInterval = 2
    static let longestWait: TimeInterval = 10

    private func holdAwake() {
        guard awake == .invalid else { return }
        awake = UIApplication.shared.beginBackgroundTask(withName: "Send changes to iCloud") { [weak self] in
            MainActor.assumeIsolated { self?.releaseAwake() }
        }
    }

    private func releaseAwake() {
        guard awake != .invalid else { return }
        UIApplication.shared.endBackgroundTask(awake)
        awake = .invalid
    }

    // MARK: The person's answers

    /// A different Apple Account: add this iPhone's habits to its iCloud (a merge by ID; nothing is replaced) (§10).
    func addToThisAccount() async {
        guard let user else { return }
        working = true
        defer { working = false }
        do {
            try await store.bind(account: "icloud:" + user)
            try? await store.setState(key: Key.user, value: user)
            try? await store.setState(key: Key.declined, value: nil)
            await resume()
        } catch {
            lastProblem = "\(error)"
        }
    }

    /// A different Apple Account: keep this iPhone's habits on it only. Nothing is uploaded; the question stays answered
    /// for this account, and Turn On asks again later.
    func keepOnThisIPhoneOnly() async {
        if let user { try? await store.setState(key: Key.declined, value: user) }
        stopEngine()
        phase = .off(.turnedOff)
    }

    /// The habits were removed from iCloud: back everything here up again, as new records (§11).
    func backUpAgain() async {
        working = true
        defer { working = false }
        try? await store.setState(key: Key.question, value: nil)
        try? await store.forgetAllSystemFields()
        try? await store.uploadEverythingAgain()
        await resume()
        transport.ensureZone()
        await refill(force: true)
        await sendNow()
    }

    /// "Not Now" to backing up again: this device stops syncing until it's turned back on.
    func notNowAfterRemoval() async {
        try? await store.setState(key: Key.question, value: nil)
        try? await store.setState(key: Key.off, value: "turnedOff")
        stopEngine()
        phase = .off(.turnedOff)
    }

    /// Turn iCloud sync back on here (after Keep on This iPhone Only, Not Now, or Delete My Data From iCloud).
    func turnOn() async {
        working = true
        defer { working = false }
        let wasDeleted = (try? await store.state(key: Key.off)) == "deleted"
        try? await store.setState(key: Key.off, value: nil)
        try? await store.setState(key: Key.declined, value: nil)
        if wasDeleted {
            try? await store.forgetAllSystemFields()
            try? await store.uploadEverythingAgain()
        }
        await evaluate()
    }

    /// The brake (incoming): apply the deletes iCloud brought (§13.2).
    func applyHeldChanges() async {
        working = true
        defer { working = false }
        do {
            let applied = try await store.applyHeld()
            heldDeletes = 0
            if applied.changed > 0 { onRemoteChanges?() }
            await refill(force: true)
            await sendNow()
        } catch {
            lastProblem = "\(error)"
        }
    }

    /// The brake (outgoing): the person says send this device's deletes (§13.2).
    func sendWaitingDeletes() async {
        try? await store.setState(key: Key.deletesApproved, value: "1")
        outgoingDeletes = 0
        await sendNow()
    }

    /// Free plan: make this device the syncing one (Move Here). Saved only if the other device's claim is unchanged,
    /// so two devices can't both win; then everything comes down (§12).
    func moveHere() async -> Bool {
        working = true
        defer { working = false }
        do {
            active = try await transport.claimActive(thisDevice(), expected: active)
            try? await store.setState(key: Key.wasActive, value: "1")
            secondDevice = nil
            run()
            return true
        } catch CloudTransportError.changed(let current) {
            active = current
            return false
        } catch {
            lastProblem = "\(error)"
            return false
        }
    }

    /// Plus arrived or ended (§12): Plus syncs every device; when it ends, the device that notices keeps syncing only if
    /// it can be the one.
    func planChanged() {
        track { [self] in
            await start()
            if isPlus() {
                if case .otherDevice = phase { await evaluate() }
            } else if phase == .on, await !mayRunOnFreePlan() {
                // Another device is the one: what this device has goes first.
                if let active { await handOver(to: active) }
            }
        }
    }

    /// "Delete My Data From iCloud" (§11, §17): both zones go from iCloud, deliberately; this device keeps everything and
    /// stops syncing until it's turned on again.
    func deleteEverythingFromICloud() async throws {
        working = true
        defer { working = false }
        deletingEverything = true
        defer { deletingEverything = false }
        try await transport.deleteAllZones()
        stopEngine()
        try? await store.forgetAllSystemFields()
        try? await store.setState(key: Key.engine, value: nil)
        try? await store.setState(key: Key.off, value: "deleted")
        phase = .off(.deleted)
    }

    /// "Erase All My Data": sync stops first, so nothing half-erased is sent, and stays off afterwards.
    func stopForErase() async {
        debounce?.cancel()
        debounce = nil
        stopEngine()
    }

    /// The database is empty now (its sync state too): this device stays off iCloud until it's turned on again, so the
    /// erased habits don't come straight back.
    func erased() async {
        try? await store.setState(key: Key.off, value: "turnedOff")
        phase = .off(.turnedOff)
        waiting = 0
        keptAside = 0
        heldDeletes = 0
        outgoingDeletes = 0
    }

    /// A background refresh: anything waiting goes now.
    func backgroundRefresh() async {
        await start()
        guard phase == .on else { return }
        await refill(force: true)
        await sendNow()
        await fetchNow()
        await idle()
    }

    /// Whether `fullSince` is a day old (a full iCloud is tried again then).
    func retryFullIfADayPassed() async {
        guard isFull, let since = (try? await store.state(key: Key.fullSince)).flatMap(Double.init),
              Date.now.timeIntervalSince1970 - since > 86_400 else { return }
        isFull = false
        try? await store.setState(key: Key.fullSince, value: nil)
        await refill(force: true)
        await sendNow()
    }

    // MARK: For the screens

    /// Something on the iCloud page needs the person (Today's small card shows it, §17): a question, a full iCloud, the
    /// brake, or iCloud off for a device that synced before.
    var attention: Bool {
        if case .asking = phase { return true }
        return isFull || heldDeletes > 0 || outgoingDeletes > 0
    }

    #if DEBUG
    /// Checks only: the engine's pending names and the in-flight table, to prove nothing leaks.
    var debugInflight: Int { inflight.count }
    /// Checks only: a page's state without a real iCloud (`-test-cloud`, the speed runs). The engine stops, so nothing
    /// changes it after.
    func setForTest(phase: Phase, waiting: Int = 0, full: Bool = false, bringingIn: Int? = nil, held: Int = 0, outgoing: Int = 0,
                    devices: [CloudDevice] = [], active: CloudActive? = nil, lastSynced: Date? = nil) {
        transport.stop()
        self.phase = phase
        self.waiting = waiting
        isFull = full
        self.bringingIn = bringingIn
        heldDeletes = held
        outgoingDeletes = outgoing
        self.devices = devices
        self.active = active
        self.lastSynced = lastSynced
        firstLookDone = true
    }
    #endif
}
