import Core
import Foundation
import Observation
import StoreKit
import UIKit
import UserNotifications

/// The backup files on this device: where they go, whether they're working, restoring and exporting (Architecture 03;
/// Architecture 11 §13.3; Rulebook D4, D5, D10). Sync itself is `CloudSync`: every change goes to the person's iCloud as
/// it's made; these files are the separate safety net outside sync, so a bad state that syncs everywhere can still be
/// undone (§13.3).
///
/// **One backup place:** the person's own iCloud Drive (`BackupFolder`: per device, the last 7 days, 4 weeks and 6
/// months, never replaced by a much smaller copy), or Google Drive for someone who keeps iCloud off (kept exactly as it
/// was, the user, 10 Oct 2026), else it stays on this iPhone (its own daily copies, `Persistence`).
///
/// **Backed up as you go** (Current Work 75): on leaving the app when something changed, at least 10 minutes after the
/// last upload; after a log from a widget, a notification or the Live Activity (with background time, D12); and at
/// least once a day.
///
/// A backup only counts once it's read back and its checksum matches. Problems are told at once: red on the iCloud
/// page, a card on Today (§4.4). Nothing about backup shows on Today otherwise.
@Observable
final class BackupCenter {
    enum Place { case iCloud, googleDrive, phone }

    struct Issue: Equatable {
        enum Fix: Equatable { case tryNow, openSettings, backUpNow, manageStorage }
        let id: String
        let text: String
        let fix: Fix

        var fixLabel: String {
            switch fix {
            case .tryNow: "Try Now"
            case .openSettings: "Open Settings"
            case .backUpNow: "Back Up Now"
            case .manageStorage: "Manage Storage"
            }
        }
    }

    /// A backup file waiting for "Replace or Merge?": opened from another app, the file picker or iCloud.
    struct Pending: Identifiable {
        let id = UUID()
        let base64: String
        let check: Core.BackupCheck
    }

    @ObservationIgnored private let repository: HabitRepository
    @ObservationIgnored private let identity: DeviceIdentity
    /// iCloud sync (nil without a database): a restore reaches every syncing device; deleting from iCloud stops it.
    @ObservationIgnored let cloud: CloudSync?
    @ObservationIgnored private let store: HabitStore
    @ObservationIgnored private let defaults: UserDefaults
    /// A test launch (`-uitest`, an in-memory database): its backup state, folders and iCloud are kept apart from the
    /// app's own, so a test run on a real iPhone can't back its demo habits up over the person's backups, offer them as
    /// an undo, or erase the person's local copies (2 Oct 2026). iCloud counts as absent, as on the simulator.
    @ObservationIgnored private let sandboxed: Bool
    #if DEBUG
    /// Test launches only: `-test-icloud ok|full|signedOut|offForApp` stands in for this iPhone's iCloud, which a test
    /// launch never uses (D8) and the simulator doesn't have, so Backup & Export's iCloud states can be checked.
    @ObservationIgnored private let testICloud: String?
    #endif

    /// When the main backup last succeeded and was checked.
    private(set) var lastGood: Date? = nil
    /// What's wrong with the iCloud copy, if anything (full, off, a different Apple Account): Backup & Export's iCloud row.
    private(set) var iCloudState: ICloudProblem? = nil
    /// A problem with the main backup, told at once (§4.4).
    private(set) var issue: Issue? = nil
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
        /// "Delete My Data From iCloud": no backup files go to iCloud until it's turned on again here.
        static let iCloudOff = "backup.iCloudCopyOff"
        static let iCloudIdentity = "backup.iCloudIdentity"
        static let iCloudProblem = "backup.iCloudProblem"
        static let notified = "backup.notifiedIssue"
        /// Without an account, Google Drive instead of iCloud (the person's choice; `BackupFeatures.googleDrive`).
        static let googleDrive = "backup.googleDrive"
    }

    /// Where a backup is written: one place at a time.
    nonisolated enum Lane: Hashable, Sendable { case iCloud, googleDrive }

    /// The place one backup goes (the one-place rule, as a plain function the checks can test): Google Drive if chosen,
    /// else iCloud if this iPhone has it, else nowhere but this iPhone.
    nonisolated static func lanes(iCloudAvailable: Bool, googleDrive: Bool = false) -> Set<Lane> {
        googleDrive ? [.googleDrive] : iCloudAvailable ? [.iCloud] : []
    }

    /// What starts a backup by itself (Current Work 75).
    nonisolated enum Trigger: Sendable { case open, leaving, outside }

    /// At least this long between uploads that start by themselves (the server takes about 12 an hour; Back Up Now is
    /// never held back).
    nonisolated static let asYouGoGap: TimeInterval = 10 * 60

    /// Whether a backup is due (as a plain function the checks can test, with a set clock: T11).
    /// - Leaving the app, or a log made outside it: something changed (or there's no backup yet), and the last upload
    ///   was at least 10 minutes ago.
    /// - Opening the app, or iOS's background refresh: the daily floor (something changed and the last good backup is
    ///   20 hours old), a first backup, or a week with none; after a failure, an hour before trying again.
    nonisolated static func isDue(_ trigger: Trigger, now: Date, lastGood: Date?, lastAttempt: Date?, dirty: Bool) -> Bool {
        let sinceAttempt = lastAttempt.map { now.timeIntervalSince($0) } ?? .infinity
        let sinceGood = lastGood.map { now.timeIntervalSince($0) } ?? .infinity
        guard sinceAttempt >= asYouGoGap else { return false }
        switch trigger {
        case .leaving, .outside:
            return dirty || lastGood == nil
        case .open:
            let failedSince = (lastAttempt ?? .distantPast) > (lastGood ?? .distantPast)
            if failedSince && sinceAttempt < 3600 { return false }
            return lastGood == nil || (dirty && sinceGood >= 20 * 3600) || sinceGood >= 7 * 86_400
        }
    }

    init(repository: HabitRepository, identity: DeviceIdentity, cloud: CloudSync?, store: HabitStore, sandboxed: Bool = false) {
        self.repository = repository
        self.identity = identity
        self.cloud = cloud
        self.store = store
        self.sandboxed = sandboxed
        #if DEBUG
        let arguments = ProcessInfo.processInfo.arguments
        testICloud = sandboxed ? arguments.firstIndex(of: "-test-icloud").flatMap { $0 + 1 < arguments.count ? arguments[$0 + 1] : nil } : nil
        #endif
        defaults = sandboxed ? UserDefaults(suiteName: "com.oftenenough.app.uitest") ?? .standard : .standard
        if sandboxed { Self.sandboxFolder = FileManager.default.temporaryDirectory.appending(path: "uitest", directoryHint: .isDirectory) }
        if let id = defaults.string(forKey: Key.hiddenID) {
            hidden = (id, Date(timeIntervalSince1970: defaults.double(forKey: Key.hiddenUntil)))
        }
        refresh()
        // Apple's advice: set up the iCloud container early, off the main thread, so iCloud starts bringing its list
        // down while the welcome is read (a fresh install's restore looks there, 10 Oct 2026).
        if BackupFeatures.iCloudBackup && !sandboxed {
            Task.detached(priority: .utility) { _ = FileManager.default.url(forUbiquityContainerIdentifier: nil) }
        }
    }

    // MARK: State

    var place: Place { usesGoogleDrive ? .googleDrive : (iCloudAvailable ? .iCloud : .phone) }

    /// A restore here reaches every device: with Plus, every device on this Apple Account syncs (Architecture 11 §12).
    var restoresEverywhere: Bool {
        guard let cloud, store.isPlus, cloud.phase == .on else { return false }
        return cloud.devices.count > 1
    }

    /// Google Drive is the backup place without an account (chosen, connected, and switched on: `BackupFeatures`).
    var usesGoogleDrive: Bool {
        _ = driveRevision
        return BackupFeatures.googleDrive && !sandboxed && defaults.bool(forKey: Key.googleDrive) && GoogleDrive.shared.isConnected
    }
    private var driveRevision = 0

    /// iCloud or Google Drive, one at a time; the first backup goes to the new place at once. The old place's copies
    /// are never deleted.
    func chooseGoogleDrive(_ on: Bool) {
        defaults.set(on, forKey: Key.googleDrive)
        driveRevision += 1
        refresh()
        Task { await backUpNow() }
    }

    /// This iPhone's own iCloud, the backup place (§4.2). A phone that has never had iCloud keeps its habits on the phone
    /// (and says so); one whose iCloud worked before and has gone away stays on iCloud, so the "isn't signed in to
    /// iCloud" card says what's wrong (found on GitHub's simulator, 2 Oct). Off after "Delete My Data From iCloud", until
    /// iCloud is turned on here again.
    var iCloudAvailable: Bool {
        #if DEBUG
        if testICloud != nil { return true }
        #endif
        guard BackupFeatures.iCloudBackup, !sandboxed, !defaults.bool(forKey: Key.iCloudOff) else { return false }
        return FileManager.default.ubiquityIdentityToken != nil || defaults.data(forKey: Key.iCloudIdentity) != nil
            || defaults.string(forKey: Key.iCloudProblem) != nil
    }

    /// Where the backups go now.
    var lanes: Set<Lane> { Self.lanes(iCloudAvailable: iCloudAvailable, googleDrive: usesGoogleDrive) }

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
        lastGood = date(Key.lastGood)
        undoFile = Self.newestUndo()
        var iCloudProblem = defaults.string(forKey: Key.iCloudProblem).flatMap(ICloudProblem.init(rawValue:))
        #if DEBUG
        if let testICloud {
            iCloudProblem = ICloudProblem(rawValue: testICloud)
            if iCloudProblem == nil && lastGood == nil { lastGood = Date.now.addingTimeInterval(-30) }
        }
        #endif
        iCloudState = place == .iCloud ? iCloudProblem : nil
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
        if place == .iCloud, let iCloudProblem { return iCloudProblem.issue }
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
        BackupInfo(deviceName: UIDevice.current.name, platform: DeviceIdentity.platform, appVersion: DeviceIdentity.appVersion)
    }

    // MARK: Backing up

    /// After every change: the next backup has something new to keep.
    func dataChanged() {
        // Called after every change: write the flag only when it flips, not on every tap.
        if !defaults.bool(forKey: Key.dirty) { defaults.set(true, forKey: Key.dirty) }
    }

    /// At every open and background refresh (and, with a trigger, on leaving and after a log made outside the app):
    /// backs up when due (`isDue`), and re-checks for problems.
    func runIfDue(_ trigger: Trigger = .open) async {
        refresh()
        #if DEBUG
        if testICloud != nil { return }
        #endif
        guard place != .phone, !working, mayBackUp else { return }
        if Self.isDue(trigger, now: .now, lastGood: lastGood, lastAttempt: date(Key.lastAttempt), dirty: defaults.bool(forKey: Key.dirty)) {
            await backUpNow()
        }
    }

    /// The app is leaving the screen (Current Work 75): if something changed and the last upload was 10 minutes ago or
    /// more, back up now, with time from iOS to finish (the app may be suspended straight after).
    func appLeaving() {
        guard place != .phone, mayBackUp,
              Self.isDue(.leaving, now: .now, lastGood: lastGood, lastAttempt: date(Key.lastAttempt), dirty: defaults.bool(forKey: Key.dirty)) else { return }
        withBackgroundTime("Back up on leaving") { await self.backUpNow() }
    }

    @ObservationIgnored private var outsideWait: Task<Void, Never>?

    /// A log made outside the app (a widget, a notification, the Live Activity) while it isn't on screen: backed up a
    /// moment later, once the taps stop, with background time (D12); within 10 minutes of the last upload, iOS's
    /// background refresh is asked for when the gap is over, so the last tap of a run isn't left for the next open.
    func changedOutside() {
        guard place != .phone else { return }
        outsideWait?.cancel()
        outsideWait = Task { [weak self] in
            try? await Task.sleep(for: .seconds(2))
            guard let self, !Task.isCancelled, self.mayBackUp else { return }
            let last = self.date(Key.lastAttempt)
            if Self.isDue(.outside, now: .now, lastGood: self.lastGood, lastAttempt: last, dirty: self.defaults.bool(forKey: Key.dirty)) {
                self.withBackgroundTime("Back up a log made outside the app") { await self.backUpNow() }
            } else if let last {
                self.onRetryLater?(max(60, Self.asYouGoGap - Date.now.timeIntervalSince(last)))
            }
        }
    }

    /// Asks iOS for a background refresh after this many seconds (`AppModel.scheduleRefresh`).
    @ObservationIgnored var onRetryLater: ((TimeInterval) -> Void)?

    /// Runs `work` while holding iOS's background time, so a backup started as the app leaves can finish.
    private func withBackgroundTime(_ name: String, _ work: @escaping @MainActor () async -> Void) {
        let hold = BackgroundHold()
        hold.id = UIApplication.shared.beginBackgroundTask(withName: name) {
            MainActor.assumeIsolated { hold.end() }
        }
        Task { @MainActor in
            await work()
            hold.end()
        }
    }

    /// Backs up now, to wherever the backup files go. True when it worked.
    @discardableResult
    func backUpNow() async -> Bool {
        guard !working else { return false }
        #if DEBUG
        if let testICloud { return testICloud == "ok" }
        #endif
        guard place != .phone, mayBackUp else { return false }
        working = true
        defer { working = false; refresh() }
        await store.flush()
        setDate(Key.lastAttempt, .now)
        defaults.set(false, forKey: Key.dirty) // a change made during the upload marks it again
        let file: BackupFileData
        do {
            // Without the CSV copies (Current Work 75): smaller, and imported the same way by every version (D5).
            file = try await repository.automaticBackupFile(info: Self.info)
        } catch {
            dataChanged()
            return false
        }
        var ok = true
        var keptOlder = false
        let targets = self.lanes
        if targets.contains(.iCloud) {
            switch await backUpToICloud(file) {
            case .backedUp: break
            case .keptOlder: keptOlder = true
            case .failed: ok = false
            }
        }
        if targets.contains(.googleDrive) {
            switch await backUpToGoogleDrive(file) {
            case .backedUp: break
            case .keptOlder: keptOlder = true
            case .failed: ok = false
            }
        }
        if ok && !keptOlder {
            setDate(Key.lastGood, .now)
        } else if !ok {
            dataChanged()
        }
        return ok
    }

    /// No backup until the welcome is finished on a fresh install (Current Work 75, Free Plan Backups §2.2 #1): a
    /// reinstalled iPhone's empty database would otherwise reach its own iCloud copy within seconds of the first launch,
    /// before "I've used it before → Restore a backup". Someone who already has habits (an update from a build before the
    /// welcome) backs up as before. Test launches have their own folders and no iCloud (D8).
    var mayBackUp: Bool {
        sandboxed || Self.backupAllowed(welcomeFinished: UserDefaults.standard.bool(forKey: Onboarding.doneKey), hasHabits: !store.habits.isEmpty)
    }

    nonisolated static func backupAllowed(welcomeFinished: Bool, hasHabits: Bool) -> Bool {
        welcomeFinished || hasHabits
    }

    // MARK: The iCloud copy (switched on with the Apple Developer account)

    enum ICloudProblem: String {
        case full, signedOut, offForApp, accountChanged

        var issue: BackupCenter.Issue {
            switch self {
            case .full: .init(id: "icloud-full", text: "Your habits can't be backed up: your iCloud is full. They're safe on this iPhone.", fix: .manageStorage)
            case .signedOut: .init(id: "icloud-signed-out", text: "Your habits aren't being backed up: this iPhone isn't signed in to iCloud, or iCloud Drive is off.", fix: .openSettings)
            case .offForApp: .init(id: "icloud-off", text: "Backup to iCloud is turned off for Often Enough in your iPhone's iCloud settings.", fix: .openSettings)
            case .accountChanged: .init(id: "icloud-changed", text: "This iPhone now uses a different Apple Account, so your backup moved to a new iCloud. Your old backup is still in the other account.", fix: .backUpNow)
            }
        }

    }

    enum ICloudResult { case backedUp, keptOlder, failed }

    /// Writes this weekday's copy to the app's hidden iCloud folder (not shown in Files), with every rule of
    /// `BackupFolder`: per device, 7 weekday copies, never an empty copy over one with habits, the shrink guard, named
    /// by device, read back and compared (Current Work 75; Rulebook D4).
    private func backUpToICloud(_ file: BackupFileData) async -> ICloudResult {
        let identity = FileManager.default.ubiquityIdentityToken
        let identityData = identity.flatMap { try? NSKeyedArchiver.archivedData(withRootObject: $0, requiringSecureCoding: true) }
        let previous = defaults.data(forKey: Key.iCloudIdentity)
        defaults.set(identityData, forKey: Key.iCloudIdentity)
        guard identity != nil else { return iCloudFailed(.signedOut) }
        guard let data = Data(base64Encoded: file.base64) else { return .failed }
        let deviceID = identity.deviceID
        // This install's first iCloud backup (a reinstall's included) waits for iCloud's list of the folder first, so
        // the copies already there are seen before anything is written beside them (10 Oct 2026).
        if previous == nil { _ = await ICloudLookup.look(timeout: .seconds(15)) }
        let upload = BackupFolder.Upload(data: data, sha256: file.sha256, createdAt: Date(timeIntervalSince1970: Double(file.createdAt) / 1000),
                                         habits: Int(file.habits), entries: Int(file.entries), records: Int(file.records),
                                         deviceName: UIDevice.current.name, platform: DeviceIdentity.platform)
        // The layout before 10 Oct 2026 (`Backups/<device>.zip`): what it holds, so a reinstall can't replace it either.
        let older: Data? = await Task.detached {
            guard let container = FileManager.default.url(forUbiquityContainerIdentifier: nil) else { return nil }
            let folder = BackupFolder(root: container.appending(path: "Backups", directoryHint: .isDirectory), deviceID: deviceID)
            guard BackupFolder.place(of: folder.indexURL) == .nowhere else { return nil }
            return await BackupFolder.read(folder.olderFile, wait: 10)
        }.value
        var olderRecords: Int?
        if let older, let preview = await check(older)?.check.preview {
            olderRecords = Int(preview.fileHabits + preview.fileEntries)
        }
        let records = olderRecords
        let result: Int = await Task.detached {
            guard let container = FileManager.default.url(forUbiquityContainerIdentifier: nil) else { return 1 }
            let folder = BackupFolder(root: container.appending(path: "Backups", directoryHint: .isDirectory), deviceID: deviceID)
            // This device's index is in iCloud but not here yet (a reinstall): wait for it rather than write a new one.
            if BackupFolder.place(of: folder.indexURL) == .inCloud { _ = await BackupFolder.read(folder.indexURL, wait: 20) }
            do {
                switch try folder.write(upload, olderRecords: records) {
                case .written: return 0
                case .keptOlder: return 4
                case .damaged, .notReady: return 3
                }
            } catch let error as CocoaError where error.code == .fileWriteOutOfSpace {
                return 2
            } catch {
                return 3
            }
        }.value
        switch result {
        case 0, 4:
            if previous != nil && identityData != previous {
                defaults.set(ICloudProblem.accountChanged.rawValue, forKey: Key.iCloudProblem)
            } else {
                defaults.removeObject(forKey: Key.iCloudProblem)
            }
            return result == 0 ? .backedUp : .keptOlder
        case 1: return iCloudFailed(.offForApp)
        case 2: return iCloudFailed(.full)
        default: return .failed
        }
    }

    /// This weekday's copy in the person's Google Drive (`GoogleDrive`), with iCloud's rules: per device, never an empty
    /// copy over one with habits, the newest kept aside before a much smaller one, checked by Drive's own SHA-256 (D4).
    private func backUpToGoogleDrive(_ file: BackupFileData) async -> ICloudResult {
        guard let data = Data(base64Encoded: file.base64) else { return .failed }
        let drive = GoogleDrive.shared
        let device = identity.deviceID
        do {
            let mine = try await drive.list().filter { $0.properties["deviceID"] == device && $0.name != "\(device)-\(BackupFolder.keptSlot).zip" }
            let newest = mine.max { $0.modified < $1.modified }
            let newestRecords = newest.flatMap { $0.properties["records"].flatMap(Int.init) } ?? 0
            let newestHasHabits = newest.map { ($0.properties["habits"].flatMap(Int.init) ?? 0) + ($0.properties["entries"].flatMap(Int.init) ?? 0) > 0 } ?? false
            if file.habits == 0 && file.entries == 0 && newestHasHabits { return .keptOlder }
            if let newest, newestRecords >= BackupFolder.shrinkMinRecords, Double(file.records) < Double(newestRecords) * BackupFolder.shrinkRatio {
                let old = try await drive.download(newest)
                _ = try await drive.put(old, name: "\(device)-\(BackupFolder.keptSlot).zip", sha256: Self.sha256(old), properties: newest.properties)
            }
            let slot = BackupFolder.slot(for: Date(timeIntervalSince1970: Double(file.createdAt) / 1000))
            let properties = ["deviceID": device, "deviceName": UIDevice.current.name, "slot": slot, "habits": String(file.habits),
                              "entries": String(file.entries), "records": String(file.records), "createdAt": String(file.createdAt)]
            return try await drive.put(data, name: "\(device)-\(slot).zip", sha256: file.sha256, properties: properties) ? .backedUp : .failed
        } catch {
            return .failed
        }
    }

    private func iCloudFailed(_ problem: ICloudProblem) -> ICloudResult {
        defaults.set(problem.rawValue, forKey: Key.iCloudProblem)
        return .failed
    }

    nonisolated static func sha256(_ data: Data) -> String {
        SHA256Hex.of(data)
    }

    /// "your iPad" for a device named by its kind (the app sends the model, "iPhone" or "iPad"); a name as it is.
    nonisolated static func yourDevice(_ name: String) -> String {
        if name.isEmpty { return "another device" }
        return ["iPhone", "iPad", "iPod touch", "Android", "Mac", "Website"].contains(name) ? "your \(name)" : name
    }

    /// "Erase All My Data" (09 §7): this iPhone's habits and its own copies. Copies in their iCloud and files they
    /// exported stay theirs; iCloud sync is turned off here, so the erased habits don't come straight back from iCloud
    /// (turning it on again brings them back).
    func eraseThisDevice() async throws {
        await store.flush()
        await cloud?.stopForErase()
        try await repository.eraseAllData()
        await cloud?.erased()
        Self.eraseLocalCopies()
        for key in [Key.lastGood, Key.failingSince, Key.checkFailures, Key.lastAttempt, Key.dirty, Key.notified] { defaults.removeObject(forKey: key) }
        store.reloadAfterSync()
        refresh()
    }

    /// "Delete My Data From iCloud" (Architecture 11 §11, §17; replaces deleting the account, D9): the synced habits and
    /// the backup files go from the person's iCloud, on every device of this Apple Account; this iPhone keeps everything
    /// (and stops backing up to iCloud), unless `eraseThisDevice` too. Nothing is uploaded again until iCloud is turned on
    /// here again.
    func deleteFromICloud(eraseThisDevice: Bool) async throws {
        await store.flush()
        try await cloud?.deleteEverythingFromICloud()
        defaults.set(true, forKey: Key.iCloudOff)
        if !sandboxed {
            await Task.detached(priority: .userInitiated) {
                guard let container = FileManager.default.url(forUbiquityContainerIdentifier: nil) else { return }
                try? FileManager.default.removeItem(at: container.appending(path: "Backups", directoryHint: .isDirectory))
            }.value
        }
        for key in [Key.lastGood, Key.failingSince, Key.checkFailures, Key.lastAttempt, Key.iCloudProblem] { defaults.removeObject(forKey: key) }
        if eraseThisDevice { try await self.eraseThisDevice() }
        refresh()
    }

    /// iCloud on again here, after "Delete My Data From iCloud", "Keep on This iPhone Only" or "Not Now": sync starts
    /// (everything here goes up again, merged by ID) and so do the backup files.
    func turnICloudOn() async {
        defaults.removeObject(forKey: Key.iCloudOff)
        await cloud?.turnOn()
        dataChanged()
        refresh()
        await backUpNow()
    }

    /// The daily copies (`Persistence`) and restore-undo files: with the data erased, no copy of it stays behind.
    private static func eraseLocalCopies() {
        guard let support = supportFolder(create: false) else { return }
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

    /// A copy in the person's own iCloud (§4.1 "We found your backup in iCloud"): 7 weekday copies per device of their
    /// Apple Account, named by device (`BackupFolder`), and the older one-file-per-device layout.
    struct ICloudCopy: Identifiable, Hashable {
        let url: URL
        let modified: Date
        let isThisDevice: Bool
        let deviceID: String
        let deviceName: String
        let slot: String
        let habits: Int?
        let entries: Int?
        var id: URL { url }

        /// "Lalith's iPad", or for an older copy with no name, which device it is.
        var title: String {
            if !deviceName.isEmpty { return isThisDevice ? "\(deviceName) (this device)" : deviceName }
            return isThisDevice ? "This device's backup" : "Another device's backup"
        }

        /// "today 9:41 · 12 habits, 400 check-ins".
        var detail: String {
            let when = ICloudPage.when(modified)
            guard let habits, let entries else { return when }
            return when + " · " + RestoreStartView.counts(habits: habits, entries: entries)
        }
    }

    /// The copies in the app's hidden iCloud folder, newest first. Copies not yet on this device are asked for; they
    /// show once iCloud has brought them (`downloading` > 0 means try again shortly).
    ///
    /// iCloud's own list comes first (`ICloudLookup`): while its first look isn't finished, that counts as one more on its
    /// way, so a fresh install never reads "nothing yet" as "no backup".
    func iCloudCopies() async -> (copies: [ICloudCopy], downloading: Int) {
        guard canLookInICloud else { return ([], 0) }
        let me = identity.deviceID
        let lookup = await ICloudLookup.look()
        let (found, listing): ([BackupFolder.Listed], Int) = await Task.detached {
            guard let container = FileManager.default.url(forUbiquityContainerIdentifier: nil) else { return ([], 0) }
            return BackupFolder.list(root: container.appending(path: "Backups", directoryHint: .isDirectory), thisDevice: me)
        }.value
        let copies = found.map { ICloudCopy(url: $0.url, modified: $0.createdAt, isThisDevice: $0.isThisDevice, deviceID: $0.deviceID,
                                            deviceName: $0.deviceName, slot: $0.slot, habits: $0.habits, entries: $0.entries) }
        return (copies, max(listing, lookup.notHere) + (lookup.finished ? 0 : 1))
    }

    /// This iPhone's iCloud can be looked in (signed in, not a test launch).
    var canLookInICloud: Bool { BackupFeatures.iCloudBackup && !sandboxed && FileManager.default.ubiquityIdentityToken != nil }

    /// How long a restore keeps looking in iCloud when it has found nothing and nothing is on its way: iCloud's list of
    /// the folder can reach a fresh install a little after its first look (10 Oct 2026).
    nonisolated static let iCloudFirstLook: TimeInterval = 20

    /// Whether a restore looks in iCloud again (every 3 s, at most a minute): while copies are still coming, and for
    /// `iCloudFirstLook` seconds while nothing at all has been found.
    nonisolated static func keepLooking(found: Bool, downloading: Int, elapsed: TimeInterval) -> Bool {
        downloading > 0 || (!found && elapsed < iCloudFirstLook)
    }

    /// Each device's newest copy, this device's first (Free Plan Backups §7: a reinstall picks its own copy, not just
    /// the newest of any device), then newest first.
    static func newestPerDevice(_ copies: [ICloudCopy]) -> [ICloudCopy] {
        var newest: [String: ICloudCopy] = [:]
        for copy in copies where copy.habits != 0 || copy.entries != 0 || copy.habits == nil {
            if let seen = newest[copy.deviceID], seen.modified >= copy.modified { continue }
            newest[copy.deviceID] = copy
        }
        return newest.values.sorted { ($0.isThisDevice ? 1 : 0, $0.modified) > ($1.isThisDevice ? 1 : 0, $1.modified) }
    }

    /// Reads an iCloud copy and prepares its preview.
    func open(_ copy: ICloudCopy) async -> Pending? {
        let url = copy.url
        guard let data = await Task.detached(operation: { await BackupFolder.read(url) }).value else { return nil }
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

    /// Set for a test launch (`sandboxed`): its own folder instead of Application Support.
    private static var sandboxFolder: URL?

    private static func supportFolder(create: Bool) -> URL? {
        if let sandboxFolder {
            try? FileManager.default.createDirectory(at: sandboxFolder, withIntermediateDirectories: true)
            return sandboxFolder
        }
        return try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: create)
    }

    private static var undoFolder: URL? {
        guard let support = supportFolder(create: true) else { return nil }
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

/// iOS's background time for one piece of work, ended once (when the work is done or the time runs out).
@MainActor private final class BackgroundHold {
    var id = UIBackgroundTaskIdentifier.invalid
    func end() {
        guard id != .invalid else { return }
        UIApplication.shared.endBackgroundTask(id)
        id = .invalid
    }
}
