import Foundation

/// A spreadsheet of everything logged, for reading in Numbers or Excel (report "Export and Backup — Keeping Your Own
/// Data", 29 Sep; Feature Ledger C020). One row per thing logged or noted, with the local calendar date it counts for
/// (never a UTC timestamp: users show exports whose days are shifted). Archived habits are included.
enum DataExport {
    nonisolated static let header = ["Date", "Habit", "What", "Amount", "Unit", "Note"]

    nonisolated struct Row: Sendable { let key: String; let fields: [String] }

    static func rows(from store: HabitStore) -> [Row] {
        let byID = Dictionary(uniqueKeysWithValues: store.habits.map { ($0.id, $0) })
        var rows: [Row] = []
        for entry in store.entries {
            guard let habit = byID[entry.habitID] else { continue }
            let rule = store.rule(habit, on: entry.day)
            let what: String
            var amount = number(entry.value)
            var unit = HabitCopy.unit(of: rule)
            switch rule.kind {
            case .quit:
                what = "Slip"; amount = ""; unit = ""
            case .checklist:
                what = "Step: " + (rule.steps.first { $0.id == entry.stepID }?.name ?? "")
                amount = ""; unit = ""
            case .duration:
                what = "Time"; unit = "min"
            case .check, .task:
                what = "Done"
                if unit.isEmpty { unit = entry.value == 1 ? "time" : "times" }
            case .amount:
                what = "Amount"
            }
            rows.append(Row(key: entry.day.key + habit.id.uuidString + entry.id.uuidString, fields: [entry.day.key, spreadsheetText(habit.name), spreadsheetText(what), amount, spreadsheetText(unit), ""]))
        }
        for habit in store.habits {
            for note in store.notes(of: habit) {
                rows.append(Row(key: note.day.key + habit.name, fields: [note.day.key, spreadsheetText(habit.name), "Note", "", "", spreadsheetText(note.text)]))
            }
        }
        for (day, text) in store.dayNotes {
            rows.append(Row(key: day.key, fields: [day.key, "", "Note for the day", "", "", spreadsheetText(text)]))
        }
        return rows
    }

    nonisolated static func csv(rows: [Row]) -> String {
        let body = rows.sorted { $0.key < $1.key }.map { line($0.fields) }
        return ([line(header)] + body).joined(separator: "\r\n") + "\r\n"
    }

    /// File writing and CSV encoding run away from the UI, using immutable values.
    nonisolated static func file(rows: [Row], day: String) throws -> URL {
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent("Habits-\(UUID().uuidString)")
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        let url = directory.appendingPathComponent("Habits Export \(day).csv")
        do { try Data(csv(rows: rows).utf8).write(to: url, options: .atomic) } catch {
            try? FileManager.default.removeItem(at: directory)
            throw error
        }
        return url
    }

    private static func number(_ value: Double) -> String {
        guard value.isFinite else { return "" }
        let text = String(value)
        return text.hasSuffix(".0") ? String(text.dropLast(2)) : text
    }

    /// Treat user text as text, including spreadsheet formula prefixes.
    nonisolated static func spreadsheetText(_ value: String) -> String {
        guard let first = value.first, "=+-@\t\r\n".contains(first) else { return value }
        return "'" + value
    }

    /// Quotes a field that holds a comma, a quote or a line break (RFC 4180).
    nonisolated static func line(_ fields: [String]) -> String {
        fields.map { field in
            guard field.contains(where: { $0 == "," || $0 == "\"" || $0 == "\n" || $0 == "\r" }) else { return field }
            return "\"" + field.replacingOccurrences(of: "\"", with: "\"\"") + "\""
        }.joined(separator: ",")
    }
}
