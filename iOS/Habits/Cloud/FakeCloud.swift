#if DEBUG
import Foundation

/// iCloud in memory, for tests (Architecture 11 §19; Rulebook D8: a test launch never touches the person's iCloud).
/// `FakeCloud` is the server side (the person's private database, per Apple Account); `FakeCloudTransport` is one
/// device's engine, behaving as `CKSyncEngine` does: 250 records a request, "save if unchanged" with the server's
/// record back on a conflict, a change feed fetched page by page with the state saved after each page, account changes,
/// and items dropped from its queue on a full iCloud.
///
/// Every error and event of §4 and §19 can be made to happen: conflicts on chosen records, `quotaExceeded` until space
/// frees, throttling, the network lost mid-batch (saved in iCloud, the answer never arriving), `zoneNotFound`,
/// `unknownItem`, a purged zone, an encrypted-data reset, sign-out and a switch of account, changes delivered twice or
/// out of order, the app dying between applying a page and saving the engine's state, and a lost engine state.
@MainActor
final class FakeCloud {
    struct Stored {
        var record: CloudRowRecord
        var tag: Int64
    }

    final class Space {
        var habitsZone = true
        var controlZone = false
        var rows: [String: Stored] = [:]
        /// The change feed: record name by the tag of its latest save, and every tag in order (a tag whose record was
        /// saved again since is skipped), so a fetch finds its place by binary search however long the feed is.
        var feed: [Int64: String] = [:]
        var tags: [Int64] = []
        var active: CloudActive?
        var activeTag: Int64 = 0
        var devices: [String: CloudDevice] = [:]
        var controlTag: Int64 = 0
        /// Bumped when the `Habits` zone is deleted, with why: every engine sees it once.
        var zoneGeneration = 0
        var zoneDeletion: CloudZoneDeletion?
    }

    private(set) var spaces: [String: Space] = [:]
    /// The Apple Account signed in on "this iPhone" (every simulated device shares it), nil when signed out.
    private(set) var user: String?
    var status: CloudAccountStatus { user.map { .available(user: $0) } ?? statusWhenSignedOut }
    var statusWhenSignedOut: CloudAccountStatus = .noAccount
    private var nextTag: Int64 = 1
    private var transports: [WeakTransport] = []

    // MARK: Faults (§19)

    /// iCloud is full: every save fails with `quotaExceeded` until this is false again.
    var full = false
    /// These records conflict once each: iCloud gets a newer copy just before the save.
    var conflictOnce: Set<String> = []
    /// The next this many sends are throttled (`requestRateLimited`): nothing is saved, the engine waits and goes on.
    var throttleSends = 0
    /// The next send saves this many records in iCloud, then the network goes: the answer never arrives.
    var loseNetworkAfter: Int?
    /// These records are refused as invalid.
    var invalid: Set<String> = []
    /// Fetch pages come twice, and in reverse order within a page.
    var deliverTwice = false
    var outOfOrder = false
    /// The next fetch applies one page and the app dies before the engine saves its state.
    var dieAfterApplying = false
    /// The network is down: every call fails, nothing changes.
    var offline = false
    /// Records a fetch delivers at a time.
    var pageSize = 200
    /// Records a request may carry (`limitExceeded` beyond it, which Apple's batcher never lets happen).
    let requestLimit = 250

    /// Statistics for checks.
    private(set) var requests = 0

    init(user: String? = "test-user") {
        self.user = user
        if let user { spaces[user] = Space() }
    }

    var space: Space? { user.flatMap { spaces[$0] } }

    func register(_ transport: FakeCloudTransport) {
        transports.removeAll { $0.value == nil }
        transports.append(WeakTransport(value: transport))
    }

    // MARK: The account

    func signOut() async {
        user = nil
        for t in transports.compactMap(\.value) { await t.accountChanged(.signOut) }
    }

    func signIn(_ name: String) async {
        let switched = user != nil && user != name
        user = name
        if spaces[name] == nil { spaces[name] = Space() }
        for t in transports.compactMap(\.value) { await t.accountChanged(switched ? .switched(user: name) : .signIn(user: name)) }
    }

    // MARK: Zones

    /// The person deleted the app's iCloud data in Settings (§11), or an app deleted the zones.
    func deleteZones(_ reason: CloudZoneDeletion) {
        guard let space else { return }
        space.rows = [:]
        space.feed = [:]
        space.tags = []
        space.habitsZone = false
        space.controlZone = false
        space.active = nil
        space.devices = [:]
        space.zoneGeneration += 1
        space.zoneDeletion = reason
    }

    /// The zone's records, for checks.
    func rows() -> [String: CloudRowRecord] { (space?.rows ?? [:]).mapValues(\.record) }

    // MARK: Saving (what the engine sends)

    enum SaveResult { case saved(CloudRowRecord), failed(CloudFailure) }

    func save(_ record: CloudRowRecord) -> SaveResult {
        guard let space else { return .failed(.other("notAuthenticated")) }
        guard space.habitsZone else { return .failed(.zoneNotFound) }
        if full { return .failed(.quotaExceeded) }
        if invalid.contains(record.name) { return .failed(.invalidArguments("refused by the fake")) }
        if conflictOnce.remove(record.name) != nil, var existing = space.rows[record.name] {
            // Another device saved it first: a newer copy with the same content and a new tag.
            existing.tag = take()
            existing.record.system = Self.system(existing.tag)
            space.rows[record.name] = existing
        }
        let existing = space.rows[record.name]
        switch (existing, record.system) {
        case (nil, .some):
            return .failed(.unknownItem) // system fields of a record that isn't in iCloud
        case (.some(let stored), let system) where system != stored.record.system:
            return .failed(.conflict(server: stored.record))
        default:
            break
        }
        if let existing { space.feed[existing.tag] = nil }
        let tag = take()
        var saved = record
        saved.system = Self.system(tag)
        saved.upTo = 0
        space.rows[record.name] = Stored(record: saved, tag: tag)
        space.feed[tag] = record.name
        space.tags.append(tag)
        return .saved(saved)
    }

    func ensureZone() {
        space?.habitsZone = true
    }

    /// Changes after `token`: each record's latest version, in order, at most `limit`.
    func changes(after token: Int64, limit: Int) -> (rows: [CloudRowRecord], next: Int64) {
        guard let space else { return ([], token) }
        var low = 0, high = space.tags.count
        while low < high {
            let mid = (low + high) / 2
            if space.tags[mid] <= token { low = mid + 1 } else { high = mid }
        }
        var rows: [CloudRowRecord] = []
        var last = token
        var at = low
        while at < space.tags.count && rows.count < limit {
            let tag = space.tags[at]
            at += 1
            last = tag
            guard let name = space.feed[tag], let stored = space.rows[name] else { continue }
            rows.append(stored.record)
        }
        return (rows, last)
    }

    // MARK: Control (§12)

    func claim(_ active: CloudActive, expected: CloudActive?) throws -> CloudActive {
        guard !offline else { throw CloudTransportError.network }
        guard let space else { throw CloudTransportError.noAccount }
        if space.active?.system != expected?.system { throw CloudTransportError.changed(space.active) }
        space.controlZone = true
        space.activeTag = take()
        var saved = active
        saved.system = Self.system(space.activeTag)
        space.active = saved
        space.controlTag = space.activeTag
        return saved
    }

    func saveDevice(_ device: CloudDevice) throws {
        guard !offline else { throw CloudTransportError.network }
        guard let space else { throw CloudTransportError.noAccount }
        space.controlZone = true
        space.devices[device.id] = device
        space.controlTag = take()
    }

    fileprivate func take() -> Int64 {
        defer { nextTag += 1 }
        return nextTag
    }

    nonisolated static func system(_ tag: Int64) -> Data { Data("tag-\(tag)".utf8) }

    private struct WeakTransport { weak var value: FakeCloudTransport? }
}

/// One device's engine against `FakeCloud`.
@MainActor
final class FakeCloudTransport: CloudTransport {
    weak var handler: CloudTransportHandler?
    let cloud: FakeCloud
    private(set) var isRunning = false
    private var pending: [String] = []
    private var pendingSet: Set<String> = []
    private var zonePending = false
    private var token: Int64 = 0
    private var controlSeen: Int64 = 0
    private var zoneGeneration = 0
    /// The app "died" (`FakeCloud.dieAfterApplying`): the engine stops where it was, its last saved state kept.
    private(set) var died = false
    /// This device alone has no network (another device can still reach iCloud).
    var offline = false
    private var down: Bool { offline || cloud.offline }

    init(cloud: FakeCloud) {
        self.cloud = cloud
        cloud.register(self)
    }

    private struct State: Codable {
        var token: Int64
        var pending: [String]
        var controlSeen: Int64
        var zoneGeneration: Int
    }

    func accountStatus() async -> CloudAccountStatus { cloud.status }

    func start(state: Data?) {
        guard !isRunning else { return }
        let saved = state.flatMap { try? JSONDecoder().decode(State.self, from: $0) }
        token = saved?.token ?? 0
        pending = saved?.pending ?? []
        pendingSet = Set(pending)
        controlSeen = saved?.controlSeen ?? 0
        zoneGeneration = saved?.zoneGeneration ?? (cloud.space?.zoneGeneration ?? 0)
        died = false
        isRunning = true
    }

    func stop() { isRunning = false }

    func addPendingSaves(_ names: [String]) {
        for name in names where pendingSet.insert(name).inserted { pending.append(name) }
    }

    func removePendingSaves(_ names: [String]) {
        let gone = Set(names)
        pending.removeAll { gone.contains($0) }
        pendingSet.subtract(gone)
    }

    var pendingSaves: Set<String> { pendingSet }

    func ensureZone() { zonePending = true }

    private func saveState() async {
        let state = State(token: token, pending: pending, controlSeen: controlSeen, zoneGeneration: zoneGeneration)
        if let data = try? JSONEncoder().encode(state) { await handler?.handle(.stateUpdate(data)) }
    }

    func accountChanged(_ change: CloudAccountChange) async {
        guard isRunning else { return }
        await handler?.handle(.account(change))
    }

    func sendChanges() async throws {
        guard isRunning, !died, let handler else { return }
        guard !down else { throw CloudTransportError.network }
        guard cloud.space != nil else { throw CloudTransportError.noAccount }
        if zonePending {
            cloud.ensureZone()
            zonePending = false
        }
        var rounds = 0
        var stalls = 0
        while isRunning && !pending.isEmpty && rounds < 10_000 && stalls < 3 {
            rounds += 1
            if cloud.throttleSends > 0 {
                cloud.throttleSends -= 1
                throw CloudTransportError.network
            }
            let names = Array(pending.prefix(CloudKitTransport.namesPerBatch))
            let records = Array(await handler.records(for: names).prefix(cloud.requestLimit))
            guard !records.isEmpty, isRunning else { break }
            cloud.countRequest()
            var saved: [CloudRowRecord] = []
            var failed: [CloudSaveFailure] = []
            for (i, record) in records.enumerated() {
                if let after = cloud.loseNetworkAfter, i >= after {
                    cloud.loseNetworkAfter = nil
                    throw CloudTransportError.network // the ones before are in iCloud; this device never heard
                }
                switch cloud.save(record) {
                case .saved(let row): saved.append(row)
                case .failed(let failure): failed.append(CloudSaveFailure(name: record.name, failure: failure))
                }
            }
            // The engine takes every answered item off its queue; the app puts back what it wants sent again.
            removePendingSaves(records.map(\.name))
            await handler.handle(.sent(saved: saved, failed: failed))
            await saveState()
            // Nothing went (a conflict re-queued, a full iCloud): the engine tries again, but not for ever.
            stalls = saved.isEmpty ? stalls + 1 : 0
        }
        await handler.handle(.didSend)
    }

    func fetchChanges() async throws {
        guard isRunning, !died, let handler else { return }
        guard !down else { throw CloudTransportError.network }
        guard let space = cloud.space else { throw CloudTransportError.noAccount }
        await handler.handle(.willFetch)
        if space.zoneGeneration != zoneGeneration {
            zoneGeneration = space.zoneGeneration
            token = 0
            if let reason = space.zoneDeletion { await handler.handle(.zoneDeleted(.habits, reason)) }
            await saveState()
            guard isRunning else { return }
        }
        while isRunning {
            let (rows, next) = cloud.changes(after: token, limit: cloud.pageSize)
            if rows.isEmpty { break }
            let page = cloud.outOfOrder ? Array(rows.reversed()) : rows
            await handler.handle(.fetchedRows(page))
            if cloud.deliverTwice { await handler.handle(.fetchedRows(page)) }
            if cloud.dieAfterApplying {
                cloud.dieAfterApplying = false
                died = true
                isRunning = false
                return
            }
            token = next
            await saveState()
        }
        if space.controlTag > controlSeen {
            controlSeen = space.controlTag
            await handler.handle(.fetchedControl(devices: Array(space.devices.values), active: space.active))
            await saveState()
        }
        await handler.handle(.didFetch)
    }

    func deleteAllZones() async throws {
        guard !down else { throw CloudTransportError.network }
        cloud.deleteZones(.deleted)
    }

    func readControl() async throws -> (active: CloudActive?, devices: [CloudDevice]) {
        guard !down else { throw CloudTransportError.network }
        guard let space = cloud.space else { throw CloudTransportError.noAccount }
        return (space.active, Array(space.devices.values))
    }

    func claimActive(_ active: CloudActive, expected: CloudActive?) async throws -> CloudActive {
        guard !down else { throw CloudTransportError.network }
        return try cloud.claim(active, expected: expected)
    }

    func saveDevice(_ device: CloudDevice) async throws {
        guard !down else { throw CloudTransportError.network }
        try cloud.saveDevice(device)
    }
}

extension FakeCloud {
    func countRequest() { requests += 1 }

    /// Records already in iCloud (saved by "another device"): a fixture for big fetches.
    func seed(_ records: [CloudRowRecord]) {
        guard let space else { return }
        space.habitsZone = true
        for record in records {
            let tag = take()
            var saved = record
            saved.system = Self.system(tag)
            if let existing = space.rows[record.name] { space.feed[existing.tag] = nil }
            space.rows[record.name] = Stored(record: saved, tag: tag)
            space.feed[tag] = record.name
            space.tags.append(tag)
        }
    }
}
#endif
