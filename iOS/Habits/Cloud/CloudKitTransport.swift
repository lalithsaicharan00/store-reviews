@preconcurrency import CloudKit
import Foundation

/// iCloud through `CKSyncEngine` (Architecture 11 §4–9): the person's private database, container
/// `iCloud.com.oftenenough.app`, zones `Habits` and `Control`, one `Row` record per row with fixed fields (§6), so the
/// CloudKit schema never has to change. **No encrypted fields** (§16, the user's decision): ordinary fields can be read
/// again after an account recovery.
///
/// The engine runs the schedule, the 250-record batches, pushes and the retries it can do; everything it reports goes to
/// `CloudSync` as plain values, one event at a time. Apple's sample deletes local data on sign-out and on a switch of
/// account: **nothing here deletes anything**, except `deleteAllZones`, which only "Delete My Data From iCloud" calls.
final class CloudKitTransport: CloudTransport, @preconcurrency CKSyncEngineDelegate {
    weak var handler: CloudTransportHandler?
    private let container = CKContainer(identifier: "iCloud.com.oftenenough.app")
    private var database: CKDatabase { container.privateCloudDatabase }
    private var engine: CKSyncEngine?

    static let habitsZone = CKRecordZone.ID(zoneName: CloudZone.habits.rawValue, ownerName: CKCurrentUserDefaultName)
    static let controlZone = CKRecordZone.ID(zoneName: CloudZone.control.rawValue, ownerName: CKCurrentUserDefaultName)

    var isRunning: Bool { engine != nil }

    func accountStatus() async -> CloudAccountStatus {
        do {
            switch try await container.accountStatus() {
            case .available:
                let id = try await container.userRecordID()
                return .available(user: Self.hash(id.recordName))
            case .noAccount: return .noAccount
            case .restricted: return .restricted
            case .temporarilyUnavailable: return .temporarilyUnavailable
            case .couldNotDetermine: return .couldNotDetermine
            @unknown default: return .couldNotDetermine
            }
        } catch {
            return .couldNotDetermine
        }
    }

    /// The Apple Account, as a hash of its CloudKit user ID: enough to tell one from another, nothing more (§10).
    nonisolated static func hash(_ recordName: String) -> String { String(SHA256Hex.of(Data(recordName.utf8)).prefix(24)) }

    func start(state: Data?) {
        guard engine == nil else { return }
        let serialization = state.flatMap { try? JSONDecoder().decode(CKSyncEngine.State.Serialization.self, from: $0) }
        var configuration = CKSyncEngine.Configuration(database: database, stateSerialization: serialization, delegate: self)
        configuration.automaticallySync = true
        engine = CKSyncEngine(configuration)
    }

    func stop() {
        engine = nil
    }

    func addPendingSaves(_ names: [String]) {
        guard let engine, !names.isEmpty else { return }
        engine.state.add(pendingRecordZoneChanges: names.map { .saveRecord(Self.id($0)) })
    }

    func removePendingSaves(_ names: [String]) {
        guard let engine, !names.isEmpty else { return }
        engine.state.remove(pendingRecordZoneChanges: names.map { .saveRecord(Self.id($0)) })
    }

    var pendingSaves: Set<String> {
        guard let engine else { return [] }
        var names = Set<String>()
        for change in engine.state.pendingRecordZoneChanges {
            if case .saveRecord(let id) = change, id.zoneID == Self.habitsZone { names.insert(id.recordName) }
        }
        return names
    }

    func ensureZone() {
        engine?.state.add(pendingDatabaseChanges: [.saveZone(CKRecordZone(zoneID: Self.habitsZone))])
    }

    func sendChanges() async throws {
        guard let engine else { return }
        try await engine.sendChanges()
    }

    func fetchChanges() async throws {
        guard let engine else { return }
        try await engine.fetchChanges()
    }

    func deleteAllZones() async throws {
        let (_, deletes) = try await database.modifyRecordZones(saving: [], deleting: [Self.habitsZone, Self.controlZone])
        for (_, result) in deletes {
            // A zone that's already gone is what was asked for.
            if case .failure(let error) = result, (error as? CKError)?.code != .zoneNotFound {
                throw (error as? CKError).map(Self.transportError) ?? CloudTransportError.other("\(error)")
            }
        }
    }

    // MARK: The Control zone, read and written directly (§12)

    private static let activeID = CKRecord.ID(recordName: CloudActive.recordName, zoneID: controlZone)

    func readControl() async throws -> (active: CloudActive?, devices: [CloudDevice]) {
        do {
            var active: CloudActive?
            var devices: [CloudDevice] = []
            var token: CKServerChangeToken?
            var more = true
            while more {
                let changes = try await database.recordZoneChanges(inZoneWith: Self.controlZone, since: token)
                for (_, result) in changes.modificationResultsByID {
                    guard case .success(let modification) = result else { continue }
                    let record = modification.record
                    if record.recordType == CloudActive.recordType { active = Self.active(record) }
                    if record.recordType == CloudDevice.recordType, let device = Self.device(record) { devices.append(device) }
                }
                token = changes.changeToken
                more = changes.moreComing
            }
            return (active, devices)
        } catch let error as CKError where error.code == .zoneNotFound || error.code == .unknownItem || error.code == .userDeletedZone {
            return (nil, [])
        } catch let error as CKError {
            throw Self.transportError(error)
        }
    }

    func claimActive(_ active: CloudActive, expected: CloudActive?) async throws -> CloudActive {
        let record = expected?.system.flatMap(Self.decodeSystemFields) ?? CKRecord(recordType: CloudActive.recordType, recordID: Self.activeID)
        record["deviceID"] = active.deviceID
        record["name"] = active.name
        record["at"] = active.at
        do {
            let saved = try await saveControl(record)
            return Self.active(saved) ?? active
        } catch let error as CKError where error.code == .serverRecordChanged {
            throw CloudTransportError.changed((error.serverRecord).flatMap(Self.active))
        } catch let error as CKError {
            throw Self.transportError(error)
        }
    }

    func saveDevice(_ device: CloudDevice) async throws {
        let id = CKRecord.ID(recordName: "device:" + device.id, zoneID: Self.controlZone)
        let existing = try? await database.record(for: id)
        let record = existing ?? CKRecord(recordType: CloudDevice.recordType, recordID: id)
        record["deviceID"] = device.id
        record["name"] = device.name
        record["platform"] = device.platform
        record["lastSync"] = device.lastSync
        record["habits"] = Int64(device.habits)
        do {
            _ = try await saveControl(record, policy: .changedKeys)
        } catch let error as CKError {
            throw Self.transportError(error)
        }
    }

    /// Saves one `Control` record, making the zone first if it isn't there yet.
    private func saveControl(_ record: CKRecord, policy: CKModifyRecordsOperation.RecordSavePolicy = .ifServerRecordUnchanged) async throws -> CKRecord {
        func attempt() async throws -> CKRecord {
            let (saved, _) = try await database.modifyRecords(saving: [record], deleting: [], savePolicy: policy, atomically: true)
            guard let result = saved[record.recordID] else { throw CKError(.unknownItem) }
            return try result.get()
        }
        do {
            return try await attempt()
        } catch let error as CKError where error.code == .zoneNotFound || error.code == .userDeletedZone {
            _ = try await database.modifyRecordZones(saving: [CKRecordZone(zoneID: Self.controlZone)], deleting: [])
            return try await attempt()
        }
    }

    // MARK: The engine's delegate

    func handleEvent(_ event: CKSyncEngine.Event, syncEngine: CKSyncEngine) async {
        guard let handler else { return }
        switch event {
        case .stateUpdate(let update):
            if let data = try? JSONEncoder().encode(update.stateSerialization) { await handler.handle(.stateUpdate(data)) }
        case .accountChange(let change):
            switch change.changeType {
            case .signIn(let user): await handler.handle(.account(.signIn(user: Self.hash(user.recordName))))
            case .signOut: await handler.handle(.account(.signOut))
            case .switchAccounts(_, let user): await handler.handle(.account(.switched(user: Self.hash(user.recordName))))
            @unknown default: break
            }
        case .willFetchChanges:
            await handler.handle(.willFetch)
        case .fetchedDatabaseChanges(let changes):
            for deletion in changes.deletions {
                guard let zone = CloudZone(rawValue: deletion.zoneID.zoneName) else { continue }
                let reason: CloudZoneDeletion = switch deletion.reason {
                case .purged: .purged
                case .encryptedDataReset: .encryptedDataReset
                default: .deleted
                }
                await handler.handle(.zoneDeleted(zone, reason))
            }
        case .fetchedRecordZoneChanges(let changes):
            var rows: [CloudRowRecord] = []
            var devices: [CloudDevice] = []
            var active: CloudActive?
            for modification in changes.modifications {
                let record = modification.record
                switch record.recordType {
                case CloudRowRecord.recordType: if let row = Self.row(record) { rows.append(row) }
                case CloudDevice.recordType: if let device = Self.device(record) { devices.append(device) }
                case CloudActive.recordType: active = Self.active(record)
                default: break // a record type a newer app version uses: left in iCloud, untouched
                }
            }
            if !rows.isEmpty { await handler.handle(.fetchedRows(rows)) }
            if !devices.isEmpty || active != nil { await handler.handle(.fetchedControl(devices: devices, active: active)) }
            if !changes.deletions.isEmpty { await handler.handle(.fetchedDeletions(changes.deletions.count)) }
        case .didFetchChanges:
            await handler.handle(.didFetch)
        case .sentDatabaseChanges(let sent):
            for failed in sent.failedZoneSaves {
                guard let zone = CloudZone(rawValue: failed.zone.zoneID.zoneName) else { continue }
                await handler.handle(.zoneSaveFailed(zone, Self.failure(failed.error)))
            }
        case .sentRecordZoneChanges(let sent):
            let saved = sent.savedRecords.compactMap(Self.row)
            let failed = sent.failedRecordSaves.map { CloudSaveFailure(name: $0.record.recordID.recordName, failure: Self.failure($0.error)) }
            await handler.handle(.sent(saved: saved, failed: failed))
        case .didSendChanges:
            await handler.handle(.didSend)
        default:
            break
        }
    }

    func nextRecordZoneChangeBatch(_ context: CKSyncEngine.SendChangesContext, syncEngine: CKSyncEngine) async -> CKSyncEngine.RecordZoneChangeBatch? {
        guard let handler else { return nil }
        let scope = context.options.scope
        let pending = syncEngine.state.pendingRecordZoneChanges.filter { scope.contains($0) }
        // More names than one request holds, in case some have nothing to send; Apple's batcher stops at the limit.
        var names: [String] = []
        var changes: [CKSyncEngine.PendingRecordZoneChange] = []
        for change in pending {
            guard case .saveRecord(let id) = change, id.zoneID == Self.habitsZone else { continue }
            names.append(id.recordName)
            changes.append(change)
            if names.count >= Self.namesPerBatch { break }
        }
        guard !names.isEmpty else { return nil }
        let rows = await handler.records(for: names)
        var records: [String: CKRecord] = [:]
        for row in rows { records[row.name] = Self.record(row) }
        let built = records
        let ready = changes.filter { change in
            guard case .saveRecord(let id) = change else { return false }
            return built[id.recordName] != nil
        }
        guard !ready.isEmpty else { return nil }
        return await CKSyncEngine.RecordZoneChangeBatch(pendingChanges: ready) { id in built[id.recordName] }
    }

    /// How many pending names one batch is built from (Apple's batcher sends at most 250 a request, §4).
    static let namesPerBatch = 300

    // MARK: Records ⇄ values

    private static func id(_ name: String) -> CKRecord.ID { CKRecord.ID(recordName: name, zoneID: habitsZone) }

    /// A `Row` record to save: from the stored system fields when it was saved before (so the save isn't a conflict),
    /// else new; the six fields from the row's current merged state (§7.2).
    private static func record(_ row: CloudRowRecord) -> CKRecord {
        let record = row.system.flatMap(decodeSystemFields) ?? CKRecord(recordType: CloudRowRecord.recordType, recordID: id(row.name))
        record["table"] = row.table
        record["row"] = row.row
        record["fields"] = row.fields
        record["clocks"] = row.clocks
        record["schema"] = row.schema
        record["format"] = row.format
        return record
    }

    private static func row(_ record: CKRecord) -> CloudRowRecord? {
        guard record.recordType == CloudRowRecord.recordType, record.recordID.zoneID == habitsZone,
              let fields = record["fields"] as? String, let clocks = record["clocks"] as? String else { return nil }
        let parts = CloudRowRecord.split(record.recordID.recordName)
        return CloudRowRecord(name: record.recordID.recordName, table: record["table"] as? String ?? parts?.table ?? "",
                              row: record["row"] as? String ?? parts?.row ?? "", fields: fields, clocks: clocks,
                              schema: (record["schema"] as? NSNumber)?.int64Value ?? 0, format: (record["format"] as? NSNumber)?.int64Value ?? 1,
                              system: encodeSystemFields(record))
    }

    private static func device(_ record: CKRecord) -> CloudDevice? {
        guard let id = record["deviceID"] as? String else { return nil }
        return CloudDevice(id: id, name: record["name"] as? String ?? "", platform: record["platform"] as? String ?? "",
                           lastSync: record["lastSync"] as? Date ?? .distantPast, habits: (record["habits"] as? NSNumber)?.intValue ?? 0)
    }

    private static func active(_ record: CKRecord) -> CloudActive? {
        guard record.recordType == CloudActive.recordType, let id = record["deviceID"] as? String else { return nil }
        return CloudActive(deviceID: id, name: record["name"] as? String ?? "", at: record["at"] as? Date ?? .distantPast,
                           system: encodeSystemFields(record))
    }

    static func encodeSystemFields(_ record: CKRecord) -> Data {
        let coder = NSKeyedArchiver(requiringSecureCoding: true)
        record.encodeSystemFields(with: coder)
        coder.finishEncoding()
        return coder.encodedData
    }

    static func decodeSystemFields(_ data: Data) -> CKRecord? {
        guard let coder = try? NSKeyedUnarchiver(forReadingFrom: data) else { return nil }
        coder.requiresSecureCoding = true
        defer { coder.finishDecoding() }
        return CKRecord(coder: coder)
    }

    private static func failure(_ error: CKError) -> CloudFailure {
        switch error.code {
        case .serverRecordChanged:
            if let server = error.serverRecord, let row = row(server) { return .conflict(server: row) }
            return .other("serverRecordChanged without a record")
        case .zoneNotFound, .userDeletedZone: return .zoneNotFound
        case .unknownItem: return .unknownItem
        case .quotaExceeded: return .quotaExceeded
        case .limitExceeded: return .limitExceeded
        case .invalidArguments: return .invalidArguments(error.localizedDescription)
        default: return .other("\(error.code.rawValue)")
        }
    }

    private static func transportError(_ error: CKError) -> CloudTransportError {
        switch error.code {
        case .notAuthenticated: .noAccount
        case .networkFailure, .networkUnavailable, .serviceUnavailable, .requestRateLimited, .zoneBusy: .network
        case .quotaExceeded: .quotaExceeded
        default: .other("\(error.code.rawValue)")
        }
    }
}
