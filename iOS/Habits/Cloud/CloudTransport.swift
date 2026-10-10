import Foundation

// What `CloudSync` needs from iCloud (Architecture 11 §5, §21 step 1): the real `CKSyncEngine` behind it on a phone
// (`CloudKitTransport`), and `FakeCloud` in tests, which reproduces every error and event of §4 and §19. Everything that
// crosses it is a plain value, so CloudKit's own types never leave the transport.

/// The two zones of the private database (§6). Names are fixed: the CloudKit schema never changes.
nonisolated enum CloudZone: String, Sendable, CaseIterable {
    /// One `Row` record per row of every synced table.
    case habits = "Habits"
    /// The free plan's syncing device (`activeDevice`) and the device list (`device:<id>`).
    case control = "Control"
}

/// One `Row` record (§6): `<table>:<row>`, its fields and per-field stamps as JSON, the schema that wrote it, the layout's
/// format (1), and its CloudKit system fields (`encodeSystemFields`), nil for a record never saved.
nonisolated struct CloudRowRecord: Sendable, Equatable {
    var name: String
    var table: String
    var row: String
    var fields: String
    var clocks: String
    var schema: Int64
    var format: Int64
    var system: Data?
    /// The outbox position the record was built at (sending only): a confirmed save removes the ops up to it.
    var upTo: Int64 = 0

    static let recordType = "Row"
}

/// A device that syncs, in the `Control` zone (`device:<id>`): what the iCloud page's Devices list shows (§17).
nonisolated struct CloudDevice: Sendable, Equatable, Codable, Identifiable {
    var id: String
    var name: String
    var platform: String
    var lastSync: Date
    /// Live habits on it at its last sync, so another device can say what this account's iCloud holds (§10).
    var habits: Int

    static let recordType = "Device"
}

/// The free plan's one syncing device (§12), `activeDevice` in `Control`. Saved only if unchanged, so two devices can't
/// both take it.
nonisolated struct CloudActive: Sendable, Equatable {
    var deviceID: String
    var name: String
    var at: Date
    var system: Data?

    static let recordType = "Active"
    static let recordName = "activeDevice"
}

/// Whether this iPhone has an Apple Account with iCloud on for the app (`CKContainer.accountStatus`).
nonisolated enum CloudAccountStatus: Sendable, Equatable {
    /// Signed in; the hash of the CloudKit user record's ID, which tells one Apple Account from another (§10).
    case available(user: String)
    case noAccount
    /// Screen Time or a managed device.
    case restricted
    case temporarilyUnavailable
    case couldNotDetermine
}

/// Why a zone went (§11).
nonisolated enum CloudZoneDeletion: String, Sendable, Equatable {
    /// By an app (ours, "Delete My Data From iCloud", on this or another device).
    case deleted
    /// By the person: Settings › Apple Account › iCloud › Manage Storage › Often Enough › Delete.
    case purged
    /// Account recovery reset the keys.
    case encryptedDataReset
}

/// Why CloudKit didn't save a record (§4, §7's table).
nonisolated enum CloudFailure: Sendable, Equatable {
    /// `serverRecordChanged`: iCloud has a newer copy, here it is.
    case conflict(server: CloudRowRecord)
    case zoneNotFound
    case unknownItem
    /// The person's iCloud is full. CloudKit doesn't retry it, and the engine drops the item from its queue.
    case quotaExceeded
    case limitExceeded
    case invalidArguments(String)
    case other(String)
}

nonisolated enum CloudAccountChange: Sendable, Equatable {
    case signIn(user: String)
    case signOut
    case switched(user: String)
}

/// What the engine reports, in its order. `CloudSync` handles each one completely before it returns, so the engine's
/// saved position never runs ahead of the data (§8).
nonisolated enum CloudEvent: Sendable {
    /// The engine's state, to keep (§9): saved on every update.
    case stateUpdate(Data)
    case account(CloudAccountChange)
    case willFetch
    /// Changed `Row` records, in a page.
    case fetchedRows([CloudRowRecord])
    /// Changed `Control` records.
    case fetchedControl(devices: [CloudDevice], active: CloudActive?)
    /// Records CloudKit says were deleted. Never a reason to delete anything here (§8): only counted.
    case fetchedDeletions(Int)
    case zoneDeleted(CloudZone, CloudZoneDeletion)
    case didFetch
    case sent(saved: [CloudRowRecord], failed: [CloudSaveFailure])
    case zoneSaveFailed(CloudZone, CloudFailure)
    case didSend
}

nonisolated struct CloudSaveFailure: Sendable, Equatable {
    var name: String
    var failure: CloudFailure
}

/// Something only the person or time can fix, thrown by the direct (non-engine) calls.
nonisolated enum CloudTransportError: Error, Equatable {
    /// "Save if unchanged" lost: another device took it first. The current value.
    case changed(CloudActive?)
    case noAccount
    case network
    case quotaExceeded
    case other(String)
}

/// The engine's side: everything it asks of the app.
@MainActor protocol CloudTransportHandler: AnyObject {
    /// One event, handled completely before returning.
    func handle(_ event: CloudEvent) async
    /// The records to send now, for these pending names (at most a request's worth is asked for). A name with nothing to
    /// send is left out and taken off the engine's queue by the handler.
    func records(for names: [String]) async -> [CloudRowRecord]
}

/// iCloud, as `CloudSync` uses it. One engine per database (§4): one transport per app.
@MainActor protocol CloudTransport: AnyObject {
    var handler: CloudTransportHandler? { get set }
    func accountStatus() async -> CloudAccountStatus
    /// Starts the engine from its saved state (nil: a new engine, which fetches everything again, §9).
    func start(state: Data?)
    /// Stops the engine. Nothing is deleted anywhere.
    func stop()
    var isRunning: Bool { get }
    /// Record names (`<table>:<row>`) the engine will ask for (§7.1).
    func addPendingSaves(_ names: [String])
    func removePendingSaves(_ names: [String])
    var pendingSaves: Set<String> { get }
    /// Queues the `Habits` zone's creation (idempotent).
    func ensureZone()
    func sendChanges() async throws
    func fetchChanges() async throws
    /// "Delete My Data From iCloud": both zones, deliberately (§11). The only CloudKit deletion the app ever makes.
    func deleteAllZones() async throws
    /// The `Control` zone, read directly (a free device that isn't syncing doesn't run the engine, §12).
    func readControl() async throws -> (active: CloudActive?, devices: [CloudDevice])
    /// Takes `activeDevice`, saved only if it's still `expected` (nil: none yet). Throws `.changed(current)` if not.
    func claimActive(_ active: CloudActive, expected: CloudActive?) async throws -> CloudActive
    func saveDevice(_ device: CloudDevice) async throws
}

extension CloudRowRecord {
    /// `<table>:<row>` → its two parts.
    nonisolated static func split(_ name: String) -> (table: String, row: String)? {
        guard let colon = name.firstIndex(of: ":"), colon != name.startIndex, name.index(after: colon) != name.endIndex else { return nil }
        return (String(name[..<colon]), String(name[name.index(after: colon)...]))
    }
}
