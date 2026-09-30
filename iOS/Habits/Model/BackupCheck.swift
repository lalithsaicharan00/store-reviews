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
            let empty = HabitStore(repository: Persistence.inMemory().repository)
            await empty.load()
            let emptyFile = try await empty.backupFile()
            defer { try? FileManager.default.removeItem(at: emptyFile.deletingLastPathComponent()) }
            let emptyResult = try await target.restore(from: emptyFile)
            expect(!emptyResult.changed && target.habits.count == 1, "valid empty backup is harmless")
        } catch { failures.append("backup operation: \(error.localizedDescription)") }
        return failures
    }
}
#endif
