import Foundation

/// The backup copies one device keeps in a folder: the person's iCloud without an account (Current Work 75; Free Plan
/// Backups §2.2 and §7 step 1; Rulebook D4). The same rules as the server's copies (`server/src/backup.ts`):
///
/// - **One folder per device** (`Backups/<device ID>/`), so an iPhone and an iPad on one iCloud never write the same
///   file, and nothing syncs between them.
/// - **Seven copies, one per weekday** (`sun.zip` … `sat.zip`, the local day), overwritten in turn: a bad day never
///   destroys the other six.
/// - **Never an empty copy over one with habits** (a reinstalled iPhone's first launch, Current Work 75): it's not
///   written at all, and the copies stay as they were.
/// - **Shrink guard:** before a copy with far fewer records than the newest one is written, the newest is kept aside as
///   `before-shrink.zip`, so nothing can push the last good copy out.
/// - **Named by device:** `index.json` beside the copies says whose they are and what each holds ("Lalith's iPad ·
///   12 habits"), so Restore can tell them apart without opening every file.
/// - **Checked:** a copy counts only once it's read back and matches its SHA-256 (D4).
///
/// The layout before 10 Oct 2026, one `Backups/<device ID>.zip` per device, is still read (`list`) and never deleted.
/// Plain files, so `BackupCheck` proves every rule on a temporary folder standing in for iCloud (D8).
///
/// **A file iCloud hasn't brought to this iPhone yet is never taken for "no file"** (10 Oct 2026). On a fresh install
/// (a reinstall, a new iPhone, an iPad) the folder fills in as iCloud brings its list down, and a file that's listed but
/// not downloaded is either a `.name.icloud` stand-in or a file of its own name with no data (`place(of:)`). So `list`
/// counts it as coming, `write` never writes a new index over one that's still in iCloud, and a copy the index doesn't
/// name is still listed by its date.
nonisolated struct BackupFolder: Sendable {
    /// `Backups/` in the app's iCloud container (or a test's folder).
    let root: URL
    let deviceID: String

    static let weekdays = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"]
    static let keptSlot = "before-shrink"
    /// A copy with fewer records than this share of the newest one's keeps the newest aside…
    static let shrinkRatio = 0.5
    /// …once the newest is big enough for a drop to mean something (as the server).
    static let shrinkMinRecords = 20

    /// One copy, as the index describes it.
    nonisolated struct Copy: Codable, Equatable, Sendable {
        var slot: String
        var createdAt: Date
        var habits: Int
        var entries: Int
        var records: Int
        var sha256: String
        var size: Int
    }

    /// `index.json`: the device's name and its copies.
    nonisolated struct Index: Codable, Equatable, Sendable {
        var deviceID: String
        var deviceName: String
        var platform: String
        var copies: [Copy]
    }

    /// What's being backed up.
    nonisolated struct Upload: Sendable {
        let data: Data
        let sha256: String
        let createdAt: Date
        let habits: Int
        let entries: Int
        let records: Int
        let deviceName: String
        let platform: String
    }

    nonisolated enum Outcome: Equatable, Sendable {
        /// Written, read back and checked, into this weekday's slot.
        case written(slot: String, keptPrevious: Bool)
        /// The new copy is empty and this device's newest copy has habits: nothing was written (Rulebook D4).
        case keptOlder
        /// Read back, it didn't match.
        case damaged
        /// This device's index is in iCloud but not on this iPhone yet: nothing was written (it's asked for; try again).
        case notReady
    }

    /// Where a file is: on this iPhone, in iCloud only (not brought down yet), or nowhere.
    nonisolated enum Place: Equatable, Sendable { case here, inCloud, nowhere }

    /// A copy of any device, for Restore.
    nonisolated struct Listed: Identifiable, Hashable, Sendable {
        let url: URL
        let deviceID: String
        let deviceName: String
        let slot: String
        let createdAt: Date
        let habits: Int?
        let entries: Int?
        let isThisDevice: Bool
        /// The layout before 10 Oct 2026 (one file per device, no index).
        let isOlderLayout: Bool
        var id: URL { url }
    }

    var folder: URL { root.appending(path: deviceID, directoryHint: .isDirectory) }
    var indexURL: URL { folder.appending(path: "index.json") }
    /// The layout before 10 Oct 2026.
    var olderFile: URL { root.appending(path: "\(deviceID).zip") }

    func url(_ slot: String) -> URL { folder.appending(path: "\(slot).zip") }

    /// The local weekday's slot.
    static func slot(for date: Date, calendar: Calendar = .current) -> String {
        weekdays[(calendar.component(.weekday, from: date) - 1) % 7]
    }

    /// Older iOS shows a file that isn't downloaded as a `.name.icloud` stand-in; newer iOS keeps it under its own name
    /// with no data. Both are `.inCloud`. A plain folder (a test's) has only `.here` and `.nowhere`.
    static func place(of url: URL) -> Place {
        let fm = FileManager.default
        if fm.fileExists(atPath: url.path) {
            var fresh = url
            fresh.removeAllCachedResourceValues() // asked again while waiting for a download
            let values = try? fresh.resourceValues(forKeys: [.isUbiquitousItemKey, .ubiquitousItemDownloadingStatusKey])
            if values?.isUbiquitousItem == true, values?.ubiquitousItemDownloadingStatus == .notDownloaded { return .inCloud }
            return .here
        }
        let standIn = url.deletingLastPathComponent().appending(path: ".\(url.lastPathComponent).icloud")
        return fm.fileExists(atPath: standIn.path) ? .inCloud : .nowhere
    }

    /// The slot a file in a device's folder holds ("mon.zip", or its stand-in ".mon.zip.icloud"); nil for anything else.
    static func slot(ofFile name: String) -> String? {
        var name = name
        if name.hasPrefix("."), name.hasSuffix(".icloud") { name = String(name.dropFirst().dropLast(".icloud".count)) }
        guard name.hasSuffix(".zip") else { return nil }
        let slot = String(name.dropLast(4))
        return weekdays.contains(slot) || slot == keptSlot ? slot : nil
    }

    func readIndex() -> Index? {
        guard Self.place(of: indexURL) == .here, let data = try? Data(contentsOf: indexURL) else { return nil }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        return try? decoder.decode(Index.self, from: data)
    }

    private func writeIndex(_ index: Index) throws {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .millisecondsSince1970
        encoder.outputFormatting = [.sortedKeys]
        try encoder.encode(index).write(to: indexURL, options: .atomic)
    }

    /// This device's newest copy (not the one kept aside).
    func newest(in index: Index?) -> Copy? {
        index?.copies.filter { $0.slot != Self.keptSlot }.max { $0.createdAt < $1.createdAt }
    }

    /// Writes this weekday's copy with every rule above. `olderRecords`: the live habits and check-ins of this device's
    /// copy in the older layout, when there's no index yet (read from the file by the caller), so a reinstall's empty
    /// database can't replace that either.
    func write(_ upload: Upload, olderRecords: Int? = nil, calendar: Calendar = .current) throws -> Outcome {
        // A reinstall can back up before iCloud has brought this device's index down. A new index written then would
        // replace it (hiding the other days) and the guards below couldn't see what the newest copy holds.
        if Self.place(of: indexURL) == .inCloud {
            try? FileManager.default.startDownloadingUbiquitousItem(at: indexURL)
            return .notReady
        }
        try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        var index = readIndex() ?? Index(deviceID: deviceID, deviceName: upload.deviceName, platform: upload.platform, copies: [])
        let newest = newest(in: index)
        let newestHasHabits = (newest.map { $0.habits > 0 || $0.entries > 0 } ?? false) || (olderRecords ?? 0) > 0
        if upload.habits == 0 && upload.entries == 0 && newestHasHabits { return .keptOlder }

        var kept = false
        if let newest, newest.records >= Self.shrinkMinRecords, Double(upload.records) < Double(newest.records) * Self.shrinkRatio {
            let keptURL = url(Self.keptSlot)
            try? FileManager.default.removeItem(at: keptURL)
            try FileManager.default.copyItem(at: url(newest.slot), to: keptURL)
            index.copies.removeAll { $0.slot == Self.keptSlot }
            var aside = newest
            aside.slot = Self.keptSlot
            index.copies.append(aside)
            kept = true
        } else if newest == nil, let olderRecords, olderRecords >= Self.shrinkMinRecords,
                  Double(upload.records) < Double(olderRecords) * Self.shrinkRatio,
                  FileManager.default.fileExists(atPath: olderFile.path) {
            // The older layout's file stays where it is (never deleted), so it's already kept; nothing to copy.
            kept = true
        }

        let slot = Self.slot(for: upload.createdAt, calendar: calendar)
        let target = url(slot)
        // Written beside the slot and checked there first, so a copy that doesn't read back never replaces a good one.
        let writing = folder.appending(path: "writing-\(slot).tmp")
        try upload.data.write(to: writing, options: .atomic)
        guard SHA256Hex.of(try Data(contentsOf: writing)) == upload.sha256 else {
            try? FileManager.default.removeItem(at: writing)
            return .damaged
        }
        if FileManager.default.fileExists(atPath: target.path) {
            _ = try FileManager.default.replaceItemAt(target, withItemAt: writing)
        } else {
            try FileManager.default.moveItem(at: writing, to: target)
        }
        index.deviceName = upload.deviceName
        index.platform = upload.platform
        index.copies.removeAll { $0.slot == slot }
        index.copies.append(Copy(slot: slot, createdAt: upload.createdAt, habits: upload.habits, entries: upload.entries,
                                 records: upload.records, sha256: upload.sha256, size: upload.data.count))
        index.copies.sort { $0.createdAt > $1.createdAt }
        try writeIndex(index)
        return .written(slot: slot, keptPrevious: kept)
    }

    /// Every copy in `root`, any device, newest first; with how many files iCloud is still bringing (`downloading`).
    /// Placeholders (`.name.icloud`) are asked for, so they show on the next look.
    static func list(root: URL, thisDevice: String) -> (copies: [Listed], downloading: Int) {
        let fm = FileManager.default
        var copies: [Listed] = []
        var downloading = 0
        let items = (try? fm.contentsOfDirectory(at: root, includingPropertiesForKeys: [.contentModificationDateKey, .isDirectoryKey])) ?? []
        for item in items {
            let name = item.lastPathComponent
            if name.hasPrefix("."), name.hasSuffix(".zip.icloud") {
                let real = root.appending(path: String(name.dropFirst().dropLast(".icloud".count)))
                try? fm.startDownloadingUbiquitousItem(at: real)
                downloading += 1
            } else if name.hasSuffix(".zip") {
                // The layout before 10 Oct 2026: `<device ID>.zip`.
                let device = String(name.dropLast(4))
                let modified = (try? item.resourceValues(forKeys: [.contentModificationDateKey]).contentModificationDate) ?? .distantPast
                copies.append(Listed(url: item, deviceID: device, deviceName: "", slot: "older", createdAt: modified,
                                     habits: nil, entries: nil, isThisDevice: device == thisDevice, isOlderLayout: true))
            } else if (try? item.resourceValues(forKeys: [.isDirectoryKey]).isDirectory) == true {
                let folder = BackupFolder(root: root, deviceID: name)
                if Self.place(of: folder.indexURL) == .inCloud {
                    try? fm.startDownloadingUbiquitousItem(at: folder.indexURL)
                    downloading += 1
                    continue
                }
                let index = folder.readIndex()
                for copy in index?.copies ?? [] {
                    copies.append(Listed(url: folder.url(copy.slot), deviceID: name, deviceName: index?.deviceName ?? "", slot: copy.slot,
                                         createdAt: copy.createdAt, habits: copy.habits, entries: copy.entries,
                                         isThisDevice: name == thisDevice, isOlderLayout: false))
                }
                // A copy the index doesn't name (no index, or one written before iCloud brought the old one) is still
                // listed, by its date; its counts show once it's opened.
                let named = Set(index?.copies.map(\.slot) ?? [])
                var seen = Set<String>()
                let files = (try? fm.contentsOfDirectory(at: item, includingPropertiesForKeys: [.contentModificationDateKey])) ?? []
                for file in files {
                    guard let fileSlot = Self.slot(ofFile: file.lastPathComponent), !named.contains(fileSlot), seen.insert(fileSlot).inserted else { continue }
                    let modified = (try? file.resourceValues(forKeys: [.contentModificationDateKey]).contentModificationDate) ?? .distantPast
                    copies.append(Listed(url: folder.url(fileSlot), deviceID: name, deviceName: index?.deviceName ?? "", slot: fileSlot,
                                         createdAt: modified, habits: nil, entries: nil, isThisDevice: name == thisDevice, isOlderLayout: false))
                }
            }
        }
        return (copies.sorted { $0.createdAt > $1.createdAt }, downloading)
    }

    /// A copy's bytes, asking iCloud for it first if it isn't on this device yet (up to `wait` seconds).
    static func read(_ url: URL, wait: TimeInterval = 30) async -> Data? {
        let fm = FileManager.default
        if Self.place(of: url) == .here, let data = try? Data(contentsOf: url) { return data }
        try? fm.startDownloadingUbiquitousItem(at: url)
        let until = Date.now.addingTimeInterval(wait)
        while Date.now < until {
            try? await Task.sleep(for: .seconds(1))
            if Self.place(of: url) == .here, let data = try? Data(contentsOf: url) { return data }
        }
        return nil
    }
}
