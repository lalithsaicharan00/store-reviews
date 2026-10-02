import Core
import Foundation
import Observation
import StoreKit
import UIKit
import UserNotifications

/// Backup on this device: where it goes, whether it's working, moving and restoring
/// (Backup, Sync and Accounts — One Seamless Experience §4; Architecture 03).
///
/// - **No account:** the backup goes to the person's own iCloud (`BackupFeatures.iCloudBackup`, waiting for the Apple
///   Developer account), else it stays on this iPhone (its own backup and the daily copies, `Persistence`).
/// - **Free account:** the checked backup file goes to our server, once on each day something changed.
/// - **Plus:** every change goes to the server through sync; "backed up" is the last sync with nothing waiting.
///
/// A backup only counts once its checksum is confirmed (the server's, or a read-back). Problems with the main
/// backup are told at once: red in Settings, a card on Today (§4.4). Nothing about backup shows on Today otherwise.
@Observable
final class BackupCenter {
    enum Place { case account, iCloud, phone }

    struct Issue: Equatable {
        enum Fix: Equatable { case signIn, tryNow, openSettings, backUpNow, backUpToAccount }
        let id: String
        let text: String
        let fix: Fix

        var fixLabel: String {
            switch fix {
            case .signIn: "Sign In"
            case .tryNow: "Try Now"
            case .openSettings: "Open Settings"
            case .backUpNow: "Back Up Now"
            case .backUpToAccount: "Back Up to Your Account Instead"
            }
        }
    }

    /// A copy on our server, any device of this account.
    struct ServerCopy: Identifiable, Hashable {
        let device: String
        let slot: String
        let deviceName: String
        let createdAt: Date
        let habits: Int
        let entries: Int
        let sha256: String
        let isThisDevice: Bool
        var id: String { device + "/" + slot }
    }

    /// A backup file waiting for "Replace or Merge?": opened from another app, the file picker or the server.
    struct Pending: Identifiable {
        let id = UUID()
        let base64: String
        let check: Core.BackupCheck
    }

    @ObservationIgnored private let repository: HabitRepository
    @ObservationIgnored private let sync: SyncService
    @ObservationIgnored private let store: HabitStore
    @ObservationIgnored private let defaults = UserDefaults.standard

    private(set) var isSignedIn = false
    private(set) var isPlus = false
    /// When the main backup last succeeded and was checked.
    private(set) var lastGood: Date? = nil
    /// A problem with the main backup, told at once (§4.4).
    private(set) var issue: Issue? = nil
    /// A problem with the second copy only: a grey line in Settings, nothing more.
    private(set) var secondCopyNote: String? = nil
    private(set) var working = false
    /// The file that undoes the last restore, kept 30 days (03 §3.6 step 3).
    private(set) var undoFile: URL? = nil
    /// "Not now" on Today's card hides it for 7 days; it returns if the problem is still there.
    private(set) var hidden: (id: String, until: Date)? = nil
    /// A file opened from another app, shown as the restore preview.
    var incoming: Pending? = nil

    private enum Key {
        static let lastGood = "backup.lastGood"
        static let lastAttempt = "backup.lastAttempt"
        static let failingSince = "backup.failingSince"
        static let checkFailures = "backup.checkFailures"
        static let dirty = "backup.dirty"
        static let hiddenID = "backup.hiddenIssue"
        static let hiddenUntil = "backup.hiddenUntil"
        static let iCloudOff = "backup.iCloudCopyOff"
        static let iCloudIdentity = "backup.iCloudIdentity"
        static let iCloudProblem = "backup.iCloudProblem"
        static let notified = "backup.notifiedIssue"
    }

    init(repository: HabitRepository, sync: SyncService, store: HabitStore) {
        self.repository = repository
        self.sync = sync
        self.store = store
        if let id = defaults.string(forKey: Key.hiddenID) {
            hidden = (id, Date(timeIntervalSince1970: defaults.double(forKey: Key.hiddenUntil)))
        }
        refresh()
    }

    // MARK: State

    var place: Place { isSignedIn ? .account : (iCloudCopyOn ? .iCloud : .phone) }

    /// The copy in their own iCloud: on by default where it exists (§4.2), turned off only in Settings.
    var iCloudCopyOn: Bool { BackupFeatures.iCloudBackup && !defaults.bool(forKey: Key.iCloudOff) }

    func setICloudCopy(_ on: Bool) {
        defaults.set(!on, forKey: Key.iCloudOff)
        refresh()
        if on { Task { await backUpNow() } }
    }

    var showsCard: Bool {
        guard let issue else { return false }
        if let hidden, hidden.id == issue.id, hidden.until > .now { return false }
        return true
    }

    func notNow() {
        guard let issue else { return }
        let until = Date.now.addingTimeInterval(7 * 86_400)
        hidden = (issue.id, until)
        defaults.set(issue.id, forKey: Key.hiddenID)
        defaults.set(until.timeIntervalSince1970, forKey: Key.hiddenUntil)
    }

    /// Re-reads everything the screens show. Cheap: no database or network.
    func refresh() {
        isSignedIn = sync.isSignedIn
        isPlus = sync.isPlus
        lastGood = date(Key.lastGood)
        undoFile = Self.newestUndo()
        let iCloudProblem = defaults.string(forKey: Key.iCloudProblem).flatMap(ICloudProblem.init(rawValue:))
        secondCopyNote = place == .account && iCloudCopyOn ? iCloudProblem?.secondCopyNote : nil
        issue = currentIssue(iCloudProblem: iCloudProblem)
        // Fixed: the next problem, even the same kind, may notify again.
        if issue == nil { defaults.removeObject(forKey: Key.notified) }
    }

    /// The one notification when a backup finds a problem while the app is closed (§4.4): once per problem, never
    /// while the app is open (the card is there), and only if notifications are allowed (we never ask for this).
    /// Tapping it opens Backup & Export.
    func notifyIfClosed() async {
        guard let issue, UIApplication.shared.applicationState != .active, defaults.string(forKey: Key.notified) != issue.id else { return }
        let center = UNUserNotificationCenter.current()
        let status = await center.notificationSettings().authorizationStatus
        guard status == .authorized || status == .provisional else { return }
        let content = UNMutableNotificationContent()
        content.title = "Your habits aren't being backed up"
        content.body = issue.text
        content.userInfo = [Self.notificationKey: issue.id]
        try? await center.add(UNNotificationRequest(identifier: "backup-problem", content: content, trigger: nil))
        defaults.set(issue.id, forKey: Key.notified)
    }

    /// The user-info key that marks the backup notification, so a tap opens Backup & Export.
    nonisolated static let notificationKey = "backupProblem"

    private func currentIssue(iCloudProblem: ICloudProblem?) -> Issue? {
        if sync.sessionEnded && !sync.isSignedIn {
            return Issue(id: "signed-out", text: "You're signed out, so your habits aren't being backed up to your account. They're safe on this iPhone.", fix: .signIn)
        }
        if place == .iCloud, let iCloudProblem { return iCloudProblem.issue }
        guard place == .account, !isPlus else { return nil }
        if defaults.integer(forKey: Key.checkFailures) >= 2 {
            return Issue(id: "check-failed", text: "Last night's backup didn't save correctly. We'll try again tonight; the one before is safe.", fix: .backUpNow)
        }
        // Short gaps are normal (no signal, a trip): nothing for the first 2 days.
        if let since = date(Key.failingSince), Date.now.timeIntervalSince(since) > 2 * 86_400 {
            return Issue(id: "unreachable", text: "Your habits haven't been backed up for 2 days: we can't reach our server. They're safe on this iPhone.", fix: .tryNow)
        }
        return nil
    }

    private func date(_ key: String) -> Date? {
        let value = defaults.double(forKey: key)
        return value > 0 ? Date(timeIntervalSince1970: value) : nil
    }

    private func setDate(_ key: String, _ value: Date?) {
        if let value { defaults.set(value.timeIntervalSince1970, forKey: key) } else { defaults.removeObject(forKey: key) }
    }

    static var info: BackupInfo {
        BackupInfo(deviceName: UIDevice.current.name, platform: SyncService.platform, appVersion: SyncService.appVersion)
    }

    // MARK: Backing up

    /// After every change: the next backup has something new to keep.
    func dataChanged() {
        // Called after every change: write the flag only when it flips, not on every tap.
        if !defaults.bool(forKey: Key.dirty) { defaults.set(true, forKey: Key.dirty) }
    }

    /// At every open and background refresh: backs up when due, and re-checks for problems.
    func runIfDue() async {
        refresh()
        if isPlus { await readSyncStatus(); return }
        guard place != .phone, !working else { return }
        let now = Date.now
        let sinceGood = now.timeIntervalSince(lastGood ?? .distantPast)
        let sinceAttempt = now.timeIntervalSince(date(Key.lastAttempt) ?? .distantPast)
        // Once on each day something changed (Server Cost and Capacity §4.1); after a failure, again an hour later.
        let due = lastGood == nil || (defaults.bool(forKey: Key.dirty) && sinceGood > 20 * 3600) || sinceGood > 7 * 86_400
        if due && sinceAttempt > 3600 { await backUpNow() }
    }

    /// Backs up now, to wherever the main backup goes (and the iCloud copy beside an account). True when it worked.
    @discardableResult
    func backUpNow() async -> Bool {
        guard !working else { return false }
        if isPlus {
            await sync.syncNow()
            await readSyncStatus()
            return lastGood.map { Date.now.timeIntervalSince($0) < 60 } ?? false
        }
        guard place != .phone else { return false }
        working = true
        defer { working = false; refresh() }
        await store.flush()
        setDate(Key.lastAttempt, .now)
        defaults.set(false, forKey: Key.dirty) // a change made during the upload marks it again
        let file: BackupFileData
        do {
            file = try await repository.backupFile(info: Self.info)
        } catch {
            dataChanged()
            return false
        }
        var ok = true
        if iCloudCopyOn { ok = await backUpToICloud(file) || place == .account }
        if place == .account { ok = await backUpToAccount(file) }
        if ok {
            setDate(Key.lastGood, .now)
        } else {
            dataChanged()
        }
        return ok
    }

    private func backUpToAccount(_ file: BackupFileData) async -> Bool {
        guard let data = Data(base64Encoded: file.base64) else { return false }
        let headers = [
            "content-type": "application/zip",
            "x-backup-sha256": file.sha256,
            "x-backup-device-name": Self.headerSafe(UIDevice.current.name),
            "x-backup-platform": SyncService.platform,
            "x-backup-app-version": SyncService.appVersion,
            "x-backup-format": String(file.format),
            "x-backup-created-at": String(file.createdAt),
            "x-backup-habits": String(file.habits),
            "x-backup-entries": String(file.entries),
            "x-backup-records": String(file.records),
        ]
        do {
            let (status, body) = try await sync.request("PUT", "/v1/backup", body: data, headers: headers)
            let reply = (try? JSONSerialization.jsonObject(with: body)) as? [String: Any]
            if status == 201, reply?["sha256"] as? String == file.sha256 {
                setDate(Key.failingSince, nil)
                defaults.set(0, forKey: Key.checkFailures)
                return true
            }
            if status == 400, reply?["error"] as? String == "checksum_mismatch" {
                defaults.set(defaults.integer(forKey: Key.checkFailures) + 1, forKey: Key.checkFailures)
            }
        } catch {
            // Offline, or signed out (SyncService records that; refresh() turns it into the issue).
        }
        if date(Key.failingSince) == nil { setDate(Key.failingSince, .now) }
        return false
    }

    /// Percent-encodes everything but plain ASCII letters and digits (`CharacterSet.alphanumerics` also lets "é" or "中"
    /// through, which a header can't carry), so the server's `decodeURIComponent` gets the name back exactly.
    nonisolated static func headerSafe(_ text: String) -> String {
        let plain = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        return text.addingPercentEncoding(withAllowedCharacters: plain) ?? "iPhone"
    }

    /// Plus: backed up = the server acknowledged everything (05 §11.2).
    private func readSyncStatus() async {
        guard let status = try? await repository.syncStatus() else { return }
        if status.waiting == 0, let at = status.lastSyncedAt {
            lastGood = Date(timeIntervalSince1970: Double(at.int64Value) / 1000)
            setDate(Key.lastGood, lastGood)
        }
    }

    // MARK: The iCloud copy (switched on with the Apple Developer account)

    enum ICloudProblem: String {
        case full, signedOut, offForApp, accountChanged

        var issue: BackupCenter.Issue {
            switch self {
            case .full: .init(id: "icloud-full", text: "Your habits can't be backed up: your iCloud is full. They're safe on this iPhone.", fix: .backUpToAccount)
            case .signedOut: .init(id: "icloud-signed-out", text: "Your habits aren't being backed up: this iPhone isn't signed in to iCloud, or iCloud Drive is off.", fix: .openSettings)
            case .offForApp: .init(id: "icloud-off", text: "Backup to iCloud is turned off for Often Enough in your iPhone's iCloud settings.", fix: .openSettings)
            case .accountChanged: .init(id: "icloud-changed", text: "This iPhone now uses a different Apple Account, so your backup moved to a new iCloud. Your old backup is still in the other account.", fix: .backUpNow)
            }
        }

        var secondCopyNote: String {
            switch self {
            case .full: "Copy in your iCloud: paused, iCloud is full"
            case .signedOut, .offForApp: "Copy in your iCloud: paused, iCloud is off"
            case .accountChanged: "Copy in your iCloud: now in a different Apple Account"
            }
        }
    }

    /// Writes the file to the app's hidden iCloud folder (not shown in Files), reads it back and compares.
    private func backUpToICloud(_ file: BackupFileData) async -> Bool {
        let identity = FileManager.default.ubiquityIdentityToken
        let identityData = identity.flatMap { try? NSKeyedArchiver.archivedData(withRootObject: $0, requiringSecureCoding: true) }
        let previous = defaults.data(forKey: Key.iCloudIdentity)
        defaults.set(identityData, forKey: Key.iCloudIdentity)
        guard identity != nil else { return iCloudFailed(.signedOut) }
        let deviceID = sync.deviceID
        let base64 = file.base64
        let expected = file.sha256
        let result: Int = await Task.detached {
            guard let container = FileManager.default.url(forUbiquityContainerIdentifier: nil) else { return 1 }
            let folder = container.appending(path: "Backups", directoryHint: .isDirectory)
            let target = folder.appending(path: "\(deviceID).zip")
            do {
                try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
                try Data(base64Encoded: base64)?.write(to: target, options: .atomic)
                let back = try Data(contentsOf: target)
                return Self.sha256(back) == expected ? 0 : 3
            } catch let error as CocoaError where error.code == .fileWriteOutOfSpace {
                return 2
            } catch {
                return 3
            }
        }.value
        switch result {
        case 0:
            if previous != nil && identityData != previous {
                defaults.set(ICloudProblem.accountChanged.rawValue, forKey: Key.iCloudProblem)
                return true
            }
            defaults.removeObject(forKey: Key.iCloudProblem)
            return true
        case 1: return iCloudFailed(.offForApp)
        case 2: return iCloudFailed(.full)
        default: return false
        }
    }

    private func iCloudFailed(_ problem: ICloudProblem) -> Bool {
        defaults.set(problem.rawValue, forKey: Key.iCloudProblem)
        return false
    }

    nonisolated static func sha256(_ data: Data) -> String {
        SHA256Hex.of(data)
    }

    // MARK: Accounts

    /// Signs in with a provider's token. Without `create`, an unknown sign-in throws `ServerError` `unknown_key`, so
    /// someone who used Apple before isn't silently given a second account through Google (01 §3.3).
    func signIn(with token: ProviderToken, create: Bool) async throws {
        var body: [String: Any] = ["idToken": token.idToken, "nonce": token.nonce]
        if create {
            body["create"] = true
            if let country = await Storefront.current?.countryCode { body["country"] = country }
        }
        try await sync.signIn(path: token.path, body: body)
        dataChanged()
        refresh()
        await backUpNow()
    }

    /// Everything stays on this iPhone; only the session ends.
    func signOut() async {
        await sync.signOut()
        for key in [Key.lastGood, Key.failingSince, Key.checkFailures, Key.lastAttempt] { defaults.removeObject(forKey: key) }
        refresh()
    }

    /// The account's sign-in methods and devices (Settings → Account).
    struct AccountDetails {
        struct SignIn: Identifiable { let provider: String; let email: String?; let isPrivateEmail: Bool; var id: String { provider } }
        struct Device: Identifiable { let id: String; let name: String; let platform: String; let lastSeen: Date; let signedIn: Bool; let isThis: Bool }
        let signIns: [SignIn]
        let devices: [Device]
    }

    func accountDetails() async throws -> AccountDetails {
        let json = try await sync.accountSummary()
        let me = sync.deviceID
        let signIns = (json["keys"] as? [[String: Any]] ?? []).compactMap { k -> AccountDetails.SignIn? in
            guard let provider = k["provider"] as? String else { return nil }
            return .init(provider: provider, email: k["email"] as? String, isPrivateEmail: k["isPrivateEmail"] as? Bool ?? false)
        }
        let devices = (json["devices"] as? [[String: Any]] ?? []).compactMap { d -> AccountDetails.Device? in
            guard let id = d["id"] as? String else { return nil }
            return .init(id: id, name: d["name"] as? String ?? "", platform: d["platform"] as? String ?? "",
                         lastSeen: Date(timeIntervalSince1970: (d["lastSeen"] as? Double ?? 0) / 1000),
                         signedIn: d["signedIn"] as? Bool ?? false, isThis: id == me)
        }
        return AccountDetails(signIns: signIns, devices: devices)
    }

    /// Deletes the account and everything on our server (Architecture 09 §7). With `eraseThisDevice`, this iPhone's
    /// habits and its local copies go too; otherwise it keeps working as a local-only app. Returns the date by which
    /// every copy (point-in-time recovery included) is gone.
    func deleteAccount(eraseThisDevice: Bool) async throws -> Date {
        await store.flush()
        try await sync.deleteAccount()
        for key in [Key.lastGood, Key.failingSince, Key.checkFailures, Key.lastAttempt] { defaults.removeObject(forKey: key) }
        if eraseThisDevice {
            try await repository.eraseAllData()
            Self.eraseLocalCopies()
            store.reloadAfterSync()
        }
        refresh()
        return Date.now.addingTimeInterval(30 * 86_400)
    }

    /// "Erase all my data" without an account (09 §7): this iPhone's habits and its own copies. Copies in their iCloud and
    /// files they exported stay theirs. With an account, deleting the account (and erasing this iPhone) is the way.
    func eraseThisDevice() async throws {
        await store.flush()
        try await repository.eraseAllData()
        Self.eraseLocalCopies()
        for key in [Key.lastGood, Key.failingSince, Key.checkFailures, Key.lastAttempt, Key.dirty, Key.notified] { defaults.removeObject(forKey: key) }
        store.reloadAfterSync()
        refresh()
    }

    /// The daily copies (`Persistence`) and restore-undo files: with the data erased, no copy of it stays behind.
    private static func eraseLocalCopies() {
        guard let support = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else { return }
        for folder in ["Backups", "Restore Undo"] {
            let url = support.appending(path: folder, directoryHint: .isDirectory)
            for file in (try? FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)) ?? [] {
                try? FileManager.default.removeItem(at: file)
            }
        }
    }

    // MARK: Moving and restoring

    /// The checked backup file, written for sharing ("Move to another device", "Export a file"), read back first.
    func makeFile() async throws -> URL {
        let ticket = store.analytics.ticket
        do {
            let url = try await writeFile()
            recordBackup("manual_backup", format: "checked_backup", succeeded: true, ticket: ticket)
            return url
        } catch {
            recordBackup("manual_backup", format: "checked_backup", succeeded: false, ticket: ticket)
            throw error
        }
    }

    private func writeFile() async throws -> URL {
        await store.flush()
        let file = try await repository.backupFile(info: Self.info)
        guard let data = Data(base64Encoded: file.base64) else { throw CocoaError(.fileWriteUnknown) }
        let folder = FileManager.default.temporaryDirectory.appending(path: "Share-\(UUID().uuidString)", directoryHint: .isDirectory)
        try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        let url = folder.appending(path: "Often Enough \(Self.stamp(.now)).zip")
        try data.write(to: url, options: .atomic)
        guard Self.sha256(try Data(contentsOf: url)) == file.sha256 else { throw CocoaError(.fileWriteUnknown) }
        return url
    }

    /// Checks a file and prepares its preview. Nothing changes until the person chooses.
    func check(_ data: Data) async -> Pending? {
        let base64 = data.base64EncodedString()
        guard let check = try? await repository.checkBackup(file: base64) else { return nil }
        return Pending(base64: base64, check: check)
    }

    /// A file opened from another app (AirDrop, Files, Mail): shown as the restore preview.
    func open(_ url: URL) async {
        let scoped = url.startAccessingSecurityScopedResource()
        defer { if scoped { url.stopAccessingSecurityScopedResource() } }
        guard let data = try? Data(contentsOf: url) else { return }
        incoming = await check(data)
    }

    /// A backup file from before the current format: a copy of the database itself (Backup & Export, until 1 Oct 2026).
    static func isOlderBackupFile(_ data: Data) -> Bool {
        data.starts(with: Data("SQLite format 3\0".utf8))
    }

    /// Adds what an older backup file has and this iPhone doesn't; never removes or overwrites anything. Checked on a
    /// copy before anything changes (`HabitStore.restore(from:)`).
    func importOlderFile(_ url: URL) async throws -> HabitStore.RestoreSummary {
        let ticket = store.analytics.ticket
        let added: HabitStore.RestoreSummary
        do { added = try await store.restore(from: url) } catch {
            recordBackup("restore", format: "legacy", mode: "merge", succeeded: false, ticket: ticket)
            throw error
        }
        recordBackup("restore", format: "legacy", mode: "merge", succeeded: true, ticket: ticket)
        if added.changed {
            dataChanged()
            store.onChange?() // reminders, widgets, Siri's phrases and sync follow the restored habits
        }
        refresh()
        return added
    }

    /// Restores, keeps the undo file, and shows the result. On a synced device the change syncs like any edit.
    func restore(_ pending: Pending, mode: RestoreMode) async throws -> RestoreChanges {
        let ticket = store.analytics.ticket
        let restoreMode = mode == .replace ? "replace" : "merge"
        await store.flush()
        let result: RestoreResult
        do { result = try await repository.restore(file: pending.base64, mode: mode, info: Self.info) } catch {
            recordBackup("restore", provider: "unknown", format: "checked_backup", mode: restoreMode, succeeded: false, ticket: ticket)
            throw error
        }
        recordBackup("restore", provider: "unknown", format: "checked_backup", mode: restoreMode, succeeded: true, ticket: ticket)
        if let data = Data(base64Encoded: result.undo.base64) { Self.saveUndo(data) }
        store.reloadAfterSync()
        dataChanged()
        refresh()
        return result.changes
    }

    /// Usage sharing (optional, content-free; `AnalyticsContract`): what a backup action did. Never names or values.
    func recordBackup(_ operation: String, provider: String = "local", format: String, mode: String = "not_applicable",
                      succeeded: Bool, ticket: AnalyticsTicket?) {
        store.analytics.event(.backup, ["operation": .text(operation), "provider": .text(provider), "format": .text(format),
            "restore_mode": .text(mode), "result": .text(succeeded ? "success" : "failed"),
            "failure_code": .text(succeeded ? "none" : "unknown")], ticket: ticket)
        if operation == "restore" && succeeded { store.analytics.cohort("restored", ticket: ticket) }
        store.analytics.reliability("backup", succeeded: succeeded, ticket: ticket)
    }

    /// Puts this device back exactly as it was before the last restore.
    func undoLastRestore() async throws {
        guard let url = undoFile else { return }
        let data = try Data(contentsOf: url)
        await store.flush()
        _ = try await repository.restore(file: data.base64EncodedString(), mode: .replace, info: Self.info)
        try? FileManager.default.removeItem(at: url)
        store.reloadAfterSync()
        dataChanged()
        refresh()
    }

    /// Every copy on our server, newest first.
    func serverCopies() async throws -> [ServerCopy] {
        let (status, body) = try await sync.request("GET", "/v1/backup")
        guard status == 200, let json = (try? JSONSerialization.jsonObject(with: body)) as? [String: Any],
              let copies = json["copies"] as? [[String: Any]] else { throw ServerError(status: status, code: "unexpected") }
        let me = sync.deviceID
        return copies.compactMap { c in
            guard let device = c["device"] as? String, let slot = c["slot"] as? String else { return nil }
            return ServerCopy(
                device: device, slot: slot, deviceName: c["deviceName"] as? String ?? "",
                createdAt: Date(timeIntervalSince1970: (c["createdAt"] as? Double ?? 0) / 1000),
                habits: c["habits"] as? Int ?? 0, entries: c["entries"] as? Int ?? 0,
                sha256: c["sha256"] as? String ?? "", isThisDevice: device == me
            )
        }
    }

    /// Downloads a server copy and prepares its preview. The file must match the checksum the server stored.
    func download(_ copy: ServerCopy) async throws -> Pending? {
        let (status, body) = try await sync.request("GET", "/v1/backup/\(copy.device)/\(copy.slot)")
        guard status == 200, Self.sha256(body) == copy.sha256 else { throw ServerError(status: status, code: "download_failed") }
        return await check(body)
    }

    /// A copy in the person's own iCloud (§4.1 "We found your backup in iCloud"), one per device of their Apple Account.
    struct ICloudCopy: Identifiable, Hashable {
        let url: URL
        let modified: Date
        let isThisDevice: Bool
        var id: URL { url }
    }

    /// The copies in the app's hidden iCloud folder, newest first. Copies not yet on this device are asked for; they
    /// show once iCloud has brought them (`downloading` > 0 means try again shortly).
    func iCloudCopies() async -> (copies: [ICloudCopy], downloading: Int) {
        guard BackupFeatures.iCloudBackup, FileManager.default.ubiquityIdentityToken != nil else { return ([], 0) }
        let me = sync.deviceID
        let (found, downloading): ([(URL, Date)], Int) = await Task.detached {
            guard let container = FileManager.default.url(forUbiquityContainerIdentifier: nil) else { return ([], 0) }
            let folder = container.appending(path: "Backups", directoryHint: .isDirectory)
            let files = (try? FileManager.default.contentsOfDirectory(at: folder, includingPropertiesForKeys: [.contentModificationDateKey])) ?? []
            var found: [(URL, Date)] = []
            var downloading = 0
            for file in files {
                let name = file.lastPathComponent
                if name.hasPrefix("."), name.hasSuffix(".zip.icloud") {
                    // Not on this device yet: iCloud keeps a placeholder named ".<name>.icloud".
                    let real = folder.appending(path: String(name.dropFirst().dropLast(".icloud".count)))
                    try? FileManager.default.startDownloadingUbiquitousItem(at: real)
                    downloading += 1
                } else if name.hasSuffix(".zip") {
                    found.append((file, (try? file.resourceValues(forKeys: [.contentModificationDateKey]).contentModificationDate) ?? .distantPast))
                }
            }
            return (found, downloading)
        }.value
        let copies = found.map { ICloudCopy(url: $0.0, modified: $0.1, isThisDevice: $0.0.lastPathComponent == "\(me).zip") }
        return (copies.sorted { $0.modified > $1.modified }, downloading)
    }

    /// Reads an iCloud copy and prepares its preview.
    func open(_ copy: ICloudCopy) async -> Pending? {
        let url = copy.url
        guard let data = await Task.detached(operation: { try? Data(contentsOf: url) }).value else { return nil }
        return await check(data)
    }

    /// The person's words for a file that can't be used. Nothing was changed.
    static func words(for problem: String) -> String {
        switch problem {
        case "repacked": "This file was zipped again by another app. Use the original file Often Enough made."
        case "damaged": "This backup file is damaged, so nothing was changed. Try another copy."
        case "newer_version": "This backup was made by a newer version of Often Enough. Update the app, then try again."
        default: "This isn't an Often Enough backup file. Nothing was changed."
        }
    }

    // MARK: Files

    private static var undoFolder: URL? {
        guard let support = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else { return nil }
        let folder = support.appending(path: "Restore Undo", directoryHint: .isDirectory)
        try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        var values = URLResourceValues()
        values.isExcludedFromBackup = true
        var excluded = folder
        try? excluded.setResourceValues(values)
        return folder
    }

    private static func saveUndo(_ data: Data) {
        guard let folder = undoFolder else { return }
        try? data.write(to: folder.appending(path: "undo-\(Int(Date.now.timeIntervalSince1970)).zip"), options: .atomic)
    }

    /// The newest undo file younger than 30 days; older ones are deleted.
    private static func newestUndo() -> URL? {
        guard let folder = undoFolder,
              let files = try? FileManager.default.contentsOfDirectory(at: folder, includingPropertiesForKeys: [.contentModificationDateKey]) else { return nil }
        let cutoff = Date.now.addingTimeInterval(-30 * 86_400)
        var newest: (URL, Date)?
        for file in files {
            let modified = (try? file.resourceValues(forKeys: [.contentModificationDateKey]).contentModificationDate) ?? .distantPast
            if modified < cutoff { try? FileManager.default.removeItem(at: file); continue }
            if newest == nil || modified > newest!.1 { newest = (file, modified) }
        }
        return newest?.0
    }

    private static let stampFormat = Date.VerbatimFormatStyle(
        format: "\(year: .defaultDigits)-\(month: .twoDigits)-\(day: .twoDigits) \(hour: .twoDigits(clock: .twentyFourHour, hourCycle: .zeroBased))\(minute: .twoDigits)",
        timeZone: .current, calendar: Calendar(identifier: .gregorian))

    /// "2026-10-01 1814" in local time, for a file name.
    private static func stamp(_ date: Date) -> String { date.formatted(stampFormat) }
}
