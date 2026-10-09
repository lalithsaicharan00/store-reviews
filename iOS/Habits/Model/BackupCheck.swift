#if DEBUG
import Foundation

enum BackupCheck {
    static func run() async -> [String] {
        var failures: [String] = []
        func expect(_ condition: Bool, _ name: String) { if !condition { failures.append(name) } }
        let source = HabitStore(repository: Persistence.inMemory().repository)
        await source.load()
        let day = source.today()
        var water = Habit(name: "水, \"Water\"", symbol: "drop", color: .blue,
                          kind: .amount(unit: "L", increment: 0.25), goal: 2)
        source.add(water)
        source.setNote("Line one\nLine two", of: water, on: day)
        source.setDayNote("=SUM(1,2)", on: day)
        await source.flush()
        source.addProgress(water, value: 0.25, on: day)
        await source.flush()
        do {
            let file = try await source.backupFile()
            defer { try? FileManager.default.removeItem(at: file.deletingLastPathComponent()) }
            let target = HabitStore(repository: Persistence.inMemory().repository)
            await target.load()
            target.isPlus = false
            let first = try await target.restore(from: file)
            expect(first.habits == 1 && first.entries == 1, "restore complete on an empty free installation")
            expect(target.note(of: water, on: day) == "Line one\nLine two", "multiline note survives")
            let second = try await target.restore(from: file)
            expect(!second.changed, "restoring twice adds nothing")
            water.name = "New name"
            target.update(water)
            target.setNote("", of: water, on: day)
            await target.flush()
            _ = try await target.restore(from: file)
            expect(target.habits.first?.name == "New name", "older backup does not replace edits")
            expect(target.note(of: water, on: day) == nil, "removed note does not return")
            let csv = DataExport.csv(rows: DataExport.rows(from: source))
            expect(csv.contains("0.25"), "CSV retains amount precision")
            expect(csv.contains("\"水, \"\"Water\"\"\""), "CSV quotes Unicode name with comma and quotes")
            expect(csv.contains("\"Line one\nLine two\""), "CSV quotes multiline notes")
            expect(csv.contains("'=SUM"), "spreadsheet formula is text")
            expect(DataExport.line(["a,b", "c\"d"]) == "\"a,b\",\"c\"\"d\"", "RFC 4180 escaping")
            let invalid = FileManager.default.temporaryDirectory.appendingPathComponent("invalid-\(UUID().uuidString).db")
            defer { try? FileManager.default.removeItem(at: invalid) }
            try Data("not a backup".utf8).write(to: invalid)
            do { _ = try await target.restore(from: invalid); failures.append("invalid file accepted") } catch {}
            expect(target.habits.first?.name == "New name", "invalid restore leaves data unchanged")
            var newer = try Data(contentsOf: file)
            newer.replaceSubrange(60..<64, with: [0, 0, 0, 255])
            try newer.write(to: invalid)
            do { _ = try await target.restore(from: invalid); failures.append("newer schema accepted") }
            catch { expect(error as? HabitStore.BackupError == .newerVersion, "newer schema has a clear error") }
            var corrupt = try Data(contentsOf: file)
            corrupt[100] = 255 // valid SQLite header/version, invalid first b-tree page
            try corrupt.write(to: invalid)
            do { _ = try await target.restore(from: invalid); failures.append("corrupt SQLite backup accepted") }
            catch { expect(error as? HabitStore.BackupError == .unreadable, "SQLite read failure reaches Swift recovery") }
            expect(target.habits.first?.name == "New name", "corrupt backup leaves existing data unchanged")
            let empty = HabitStore(repository: Persistence.inMemory().repository)
            await empty.load()
            let emptyFile = try await empty.backupFile()
            defer { try? FileManager.default.removeItem(at: emptyFile.deletingLastPathComponent()) }
            let emptyResult = try await target.restore(from: emptyFile)
            expect(!emptyResult.changed && target.habits.count == 1, "valid empty backup is harmless")
            var oversized = water; oversized.goal = 1e99
            source.update(oversized); await source.flush()
            let oversizedFile = try await source.backupFile()
            defer { try? FileManager.default.removeItem(at: oversizedFile.deletingLastPathComponent()) }
            do { _ = try await target.restore(from: oversizedFile); failures.append("unsafe numeric backup accepted") } catch {}
            expect(target.habits.first?.name == "New name" && target.habits.first?.goal == 2, "unsafe backup leaves destination unchanged")

        } catch { failures.append("backup operation: \(error.localizedDescription)") }
        failures += folderFailures()
        return failures
    }

    /// The iCloud lane's rules (`BackupFolder`, Current Work 75; Rulebook D4), on a temporary folder standing in for
    /// iCloud (D8): 7 weekday copies per device, never an empty copy over one with habits (a reinstall), the shrink guard's
    /// `before-shrink`, copies named by device, the older layout kept and listed, and no backup before the welcome ends.
    static func folderFailures() -> [String] {
        var failures: [String] = []
        func expect(_ condition: Bool, _ name: String) { if !condition { failures.append("folder: " + name) } }
        let root = FileManager.default.temporaryDirectory.appending(path: "folder-check-\(UUID().uuidString)", directoryHint: .isDirectory)
        defer { try? FileManager.default.removeItem(at: root) }
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        // Sunday 4 Oct 2026, noon UTC, then a day at a time.
        let sunday = Date(timeIntervalSince1970: 1_791_115_200)
        func day(_ n: Int) -> Date { sunday.addingTimeInterval(Double(n) * 86_400) }
        func upload(_ text: String, at date: Date, habits: Int, entries: Int, records: Int, name: String = "Lalith's iPhone") -> BackupFolder.Upload {
            let data = Data(text.utf8)
            return .init(data: data, sha256: SHA256Hex.of(data), createdAt: date, habits: habits, entries: entries, records: records,
                         deviceName: name, platform: "ios")
        }
        let iPhone = BackupFolder(root: root, deviceID: "11111111-1111-1111-1111-111111111111")
        let iPad = BackupFolder(root: root, deviceID: "22222222-2222-2222-2222-222222222222")
        do {
            expect(BackupFolder.slot(for: sunday, calendar: calendar) == "sun" && BackupFolder.slot(for: day(6), calendar: calendar) == "sat", "weekday slots")
            // A week of copies, then an eighth day overwrites the first weekday only.
            for n in 0..<8 {
                let out = try iPhone.write(upload("day \(n)", at: day(n), habits: 10, entries: 100 + n, records: 120 + n), calendar: calendar)
                expect(out == .written(slot: BackupFolder.slot(for: day(n), calendar: calendar), keptPrevious: false), "day \(n) written to its weekday")
            }
            let index = iPhone.readIndex()
            expect(index?.copies.count == 7, "7 weekday copies kept (\(index?.copies.count ?? 0))")
            expect(index?.deviceName == "Lalith's iPhone", "copies are named by device")
            expect((try? String(contentsOf: iPhone.url("sun"), encoding: .utf8)) == "day 7", "the 8th day replaces the 1st weekday only")
            expect((try? String(contentsOf: iPhone.url("mon"), encoding: .utf8)) == "day 1", "the other days stay")

            // A reinstall: the first launch's database is empty. Nothing is written; every copy stays.
            let empty = try iPhone.write(upload("empty", at: day(8), habits: 0, entries: 0, records: 0), calendar: calendar)
            expect(empty == .keptOlder, "an empty copy never replaces one with habits")
            expect((try? String(contentsOf: iPhone.url("mon"), encoding: .utf8)) == "day 1", "Monday's copy is untouched by the empty one")

            // Much smaller (a bug that lost most of the data): the newest copy is kept aside first.
            let shrunk = try iPhone.write(upload("shrunk", at: day(9), habits: 2, entries: 5, records: 10), calendar: calendar)
            expect(shrunk == .written(slot: "tue", keptPrevious: true), "a much smaller copy keeps the newest aside (\(shrunk))")
            expect((try? String(contentsOf: iPhone.url(BackupFolder.keptSlot), encoding: .utf8)) == "day 7", "before-shrink holds the last good copy")
            // The next small copy compares with the small one now: no second keep, and before-shrink stays.
            let next = try iPhone.write(upload("small again", at: day(10), habits: 2, entries: 6, records: 11), calendar: calendar)
            expect(next == .written(slot: "wed", keptPrevious: false), "a copy like the last one isn't a shrink")
            expect((try? String(contentsOf: iPhone.url(BackupFolder.keptSlot), encoding: .utf8)) == "day 7", "before-shrink isn't replaced")

            // A damaged write is caught by reading it back.
            var bad = upload("x", at: day(11), habits: 2, entries: 6, records: 11)
            bad = .init(data: bad.data, sha256: String(repeating: "0", count: 64), createdAt: bad.createdAt, habits: 2, entries: 6, records: 11, deviceName: "Lalith's iPhone", platform: "ios")
            expect(try iPhone.write(bad, calendar: calendar) == .damaged, "a copy that doesn't read back the same doesn't count")
            expect((try? String(contentsOf: iPhone.url("thu"), encoding: .utf8)) == "day 4", "and the day's good copy stays")

            // A first backup after a reinstall, when only the older layout's file exists (it held 40 habits and check-ins).
            let older = BackupFolder(root: root, deviceID: "33333333-3333-3333-3333-333333333333")
            try FileManager.default.createDirectory(at: root, withIntermediateDirectories: true)
            try Data("older layout".utf8).write(to: older.olderFile)
            expect(try older.write(upload("empty", at: day(1), habits: 0, entries: 0, records: 0), olderRecords: 40, calendar: calendar) == .keptOlder,
                   "an empty copy never replaces the older layout's copy")
            expect(FileManager.default.fileExists(atPath: older.olderFile.path), "the older layout's file is never deleted")

            // Another device on the same iCloud: its own folder; Restore tells them apart.
            _ = try iPad.write(upload("ipad", at: day(3), habits: 4, entries: 30, records: 40, name: "Lalith's iPad"), calendar: calendar)
            let listed = BackupFolder.list(root: root, thisDevice: iPhone.deviceID).copies
            expect(listed.contains { $0.deviceName == "Lalith's iPad" && !$0.isThisDevice && $0.habits == 4 }, "the iPad's copy is listed by name")
            expect(listed.contains { $0.isOlderLayout && $0.deviceID == older.deviceID }, "the older layout's copy is listed")
            expect(listed.filter { $0.deviceID == iPhone.deviceID }.count == 8, "this device's 7 days and before-shrink are listed")
            let copies = listed.map { BackupCenter.ICloudCopy(url: $0.url, modified: $0.createdAt, isThisDevice: $0.isThisDevice, deviceID: $0.deviceID,
                                                               deviceName: $0.deviceName, slot: $0.slot, habits: $0.habits, entries: $0.entries) }
            let newest = BackupCenter.newestPerDevice(copies)
            expect(newest.first?.isThisDevice == true, "this device's own copy comes first, not just the newest")
            expect(Set(newest.map(\.deviceID)).count == newest.count, "one row per device")
        } catch {
            failures.append("folder: \(error.localizedDescription)")
        }

        // No backup before the welcome is finished on a fresh install; an update with habits backs up as before.
        expect(!BackupCenter.backupAllowed(welcomeFinished: false, hasHabits: false), "a fresh install backs up nothing during the welcome")
        expect(BackupCenter.backupAllowed(welcomeFinished: true, hasHabits: false), "after the welcome, it backs up")
        expect(BackupCenter.backupAllowed(welcomeFinished: false, hasHabits: true), "an update with habits backs up")
        return failures
    }
}
#endif
