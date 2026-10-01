import Core
import Foundation

/// Owns the database file and its safety copies (Architecture: Local Database Decision, safety nets 1–2).
///
/// - The database lives in Application Support: private to the app, included in the phone's own
///   backup, and readable after the first unlock so reminders and widgets work after a restart.
/// - Before a schema upgrade, the file is copied aside, so a failed upgrade can never lose data.
/// - Once a day, a consistent copy is kept: the last 7 days, plus one a week for 5 weeks.
final class Persistence {
    let repository: HabitRepository
    private let backups: URL?

    private static let schemaKey = "database.schemaVersion"

    private init(repository: HabitRepository, backups: URL?) {
        self.repository = repository
        self.backups = backups
    }

    /// A throwaway database, for UI tests.
    static func inMemory() -> Persistence {
        Persistence(repository: HabitRepository.companion.openInMemory(), backups: nil)
    }

    /// - Parameters:
    ///   - name: the file name; UI tests pass their own, so they never touch the user's data.
    ///   - reset: delete that file first (tests only).
    static func onDisk(name: String = "habits", reset: Bool = false) throws -> Persistence {
        let fm = FileManager.default
        let support = try fm.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let dataDir = support.appendingPathComponent("Data", isDirectory: true)
        var backupsDir = support.appendingPathComponent("Backups", isDirectory: true)
        try fm.createDirectory(at: dataDir, withIntermediateDirectories: true)
        try fm.createDirectory(at: backupsDir, withIntermediateDirectories: true)
        // The database itself is in the phone's backup; the local copies don't need to be.
        var values = URLResourceValues()
        values.isExcludedFromBackup = true
        try backupsDir.setResourceValues(values)

        let database = dataDir.appendingPathComponent(name + ".db")
        if reset {
            for suffix in ["", "-wal", "-shm"] { try? fm.removeItem(atPath: database.path + suffix) }
        }
        let current = Int(HabitRepository.companion.SCHEMA_VERSION)
        let stored = UserDefaults.standard.integer(forKey: schemaKey)
        if fm.fileExists(atPath: database.path), stored < current {
            try copyAside(database, to: backupsDir, name: "before-schema-\(current)-\(Self.stamp())")
        }
        return Persistence(repository: try HabitRepository.companion.open(path: database.path), backups: backupsDir)
    }

    /// Call after the first successful load: the schema on disk is now current.
    func markSchemaCurrent() {
        guard backups != nil else { return }
        UserDefaults.standard.set(Int(HabitRepository.companion.SCHEMA_VERSION), forKey: Self.schemaKey)
    }

    /// Keeps one consistent copy per day and prunes old ones.
    func dailySnapshotIfNeeded(now: Date = .now) async {
        guard let backups else { return }
        let fm = FileManager.default
        let name = "daily-\(Self.day(now)).db"
        let target = backups.appendingPathComponent(name)
        if !fm.fileExists(atPath: target.path) {
            do {
                try await repository.snapshot(path: target.path)
            } catch {
                try? fm.removeItem(at: target) // never keep a half-written copy
                return
            }
        }
        prune(backups, now: now)
    }

    private func prune(_ dir: URL, now: Date) {
        let fm = FileManager.default
        let formatter = Self.dayFormatter
        let dailies = ((try? fm.contentsOfDirectory(atPath: dir.path)) ?? [])
            .filter { $0.hasPrefix("daily-") && $0.hasSuffix(".db") }
            .compactMap { name -> (String, Date)? in
                formatter.date(from: String(name.dropFirst(6).dropLast(3))).map { (name, $0) }
            }
            .sorted { $0.1 > $1.1 }
        var keptWeeks = Set<Int>()
        for (name, date) in dailies {
            let age = now.timeIntervalSince(date) / 86400
            let week = Int(age / 7)
            if age <= 7 { continue }
            if age <= 35, !keptWeeks.contains(week) { keptWeeks.insert(week); continue }
            try? fm.removeItem(at: dir.appendingPathComponent(name))
        }
    }

    private static func copyAside(_ database: URL, to dir: URL, name: String) throws {
        let fm = FileManager.default
        for suffix in ["", "-wal", "-shm"] {
            let source = URL(fileURLWithPath: database.path + suffix)
            guard fm.fileExists(atPath: source.path) else { continue }
            try fm.copyItem(at: source, to: dir.appendingPathComponent(name + ".db" + suffix))
        }
    }

    private static let dayFormatter: DateFormatter = {
        let f = DateFormatter()
        f.calendar = Calendar(identifier: .gregorian)
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "yyyy-MM-dd"
        return f
    }()

    private static func day(_ date: Date) -> String { dayFormatter.string(from: date) }
    private static func stamp() -> String { day(.now) + "-\(Int(Date.now.timeIntervalSince1970))" }
}
