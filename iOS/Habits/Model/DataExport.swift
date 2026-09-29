import Foundation

/// A spreadsheet of everything logged, for reading in Numbers or Excel (report "Export and Backup — Keeping Your Own
/// Data", 29 Sep; Feature Ledger C020). One row per thing logged or noted, with the local calendar date it counts for
/// (never a UTC timestamp: users show exports whose days are shifted). Archived habits are included.
enum DataExport {
    static let header = ["Date", "Habit", "What", "Amount", "Unit", "Note"]

    static func csv(from store: HabitStore) -> String {
        let byID = Dictionary(uniqueKeysWithValues: store.habits.map { ($0.id, $0) })
        var rows: [(key: String, fields: [String])] = []
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
            rows.append((entry.day.key + habit.name, [entry.day.key, habit.name, what, amount, unit, ""]))
        }
        for habit in store.habits {
            for note in store.notes(of: habit) {
                rows.append((note.day.key + habit.name, [note.day.key, habit.name, "Note", "", "", note.text]))
            }
        }
        for (day, text) in store.dayNotes {
            rows.append((day.key, [day.key, "", "Note for the day", "", "", text]))
        }
        let body = rows.sorted { $0.key < $1.key }.map { line($0.fields) }
        return ([line(header)] + body).joined(separator: "\r\n") + "\r\n"
    }

    /// Writes the spreadsheet to a file named for today, ready to share.
    static func file(from store: HabitStore, now: Date = .now) throws -> URL {
        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent("Habits Export \(LocalDay(now, calendar: store.calendar).key).csv")
        try Data(csv(from: store).utf8).write(to: url, options: .atomic)
        return url
    }

    /// "8", "2.5": a plain number, no grouping, so spreadsheets read it as a number.
    private static func number(_ value: Double) -> String {
        value == value.rounded() ? String(Int(value)) : String(format: "%.2f", value)
    }

    /// Quotes a field that holds a comma, a quote or a line break (RFC 4180).
    static func line(_ fields: [String]) -> String {
        fields.map { field in
            guard field.contains(where: { $0 == "," || $0 == "\"" || $0 == "\n" || $0 == "\r" }) else { return field }
            return "\"" + field.replacingOccurrences(of: "\"", with: "\"\"") + "\""
        }.joined(separator: ",")
    }
}
