import AppIntents
import Foundation
import UserNotifications
import WidgetKit

/// What the app and the Today widget share, through the App Group (report "Widgets — Tick Without Opening the App",
/// 30 Sep). Built into both the app and the widget extension.
///
/// The app writes today's and tomorrow's rows after every change; the widget only reads them, so it can never disagree
/// with the app (Feature Ledger C040). A tap on the widget is saved as its own small file with its own entry ID; the
/// app adds it the next time it runs, and adding the same ID twice counts once, so no tap is lost or doubled.
nonisolated enum WidgetShared {
    static let appGroup = "group.com.lalithsaicharan.habits"
    static let kind = "HabitsToday"
    static var container: URL? { FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) }
    static var snapshotURL: URL? { container?.appendingPathComponent("widget-days.json") }
    static var tapsFolder: URL? { container?.appendingPathComponent("WidgetTaps", isDirectory: true) }
}

/// One day of Today, as the widget draws it.
nonisolated struct WidgetDay: Codable, Hashable, Sendable {
    nonisolated struct Row: Codable, Hashable, Sendable, Identifiable {
        /// The habit's UUID.
        var id: String
        var name: String
        var symbol: String
        /// `HabitColor` raw value ("blue").
        var color: String
        /// Progress toward what the row shows (a day's goal, or a week's for a weekly goal).
        var progress: Double
        var goal: Double
        /// After the numbers: " glasses", " this week", " steps". Empty for a single tick, which shows no numbers.
        var suffix: String
        /// Whether the row shows "3/8 glasses" (false for a once-a-day tick).
        var showsCount: Bool
        /// What one tap on the widget adds; nil when the widget opens the app instead (timers, checklists, amounts
        /// typed each time).
        var step: Double?
        /// The button's words: "✓", "+1", "+250".
        var stepLabel: String
        /// A limit ("at most 2 coffees"): never "done", and logging never stops.
        var isLimit: Bool
        var done: Bool

        /// "3/8 glasses", "2/3 this week", or "" for a once-a-day tick.
        var line: String {
            guard showsCount else { return "" }
            return "\(Self.number(progress))/\(Self.number(goal))\(suffix)"
        }

        /// As on Today's rows (`Format.amount`): "8", "2.5", "0.25", "1k", "5.2k".
        static func number(_ v: Double) -> String {
            if abs(v) >= 1000 { return trimmed((v / 100).rounded() / 10, places: 1) + "k" }
            return trimmed(v, places: 2)
        }

        private static func trimmed(_ v: Double, places: Int) -> String {
            var text = String(format: "%.\(places)f", v)
            while text.contains("."), text.hasSuffix("0") { text.removeLast() }
            if text.hasSuffix(".") { text.removeLast() }
            return text
        }
    }

    /// "2026-09-29".
    var day: String
    /// When this day begins on the person's clock (after their day end).
    var starts: Date
    /// Unfinished first, then done, each in Today's order.
    var rows: [Row]

    var done: Int { rows.filter { $0.done }.count }
    var total: Int { rows.filter { !$0.isLimit }.count }
    var next: Row? { rows.first { !$0.done && !$0.isLimit } }
}

nonisolated struct WidgetFile: Codable, Sendable {
    /// A day is shown for this long after it begins, and no longer: an unknown next day reads "Open Habits", never
    /// yesterday's list (C040).
    static let dayLength: TimeInterval = 24 * 3600

    /// Today and tomorrow, so the widget turns over at the start of the day without the app.
    var days: [WidgetDay]

    /// The day showing at `date`: the latest one that has begun, as long as it hasn't ended.
    func day(at date: Date) -> WidgetDay? {
        guard let day = days.filter({ $0.starts <= date }).max(by: { $0.starts < $1.starts }) else { return nil }
        return date < day.starts.addingTimeInterval(Self.dayLength) ? day : nil
    }

    static func read() -> WidgetFile? {
        guard let url = WidgetShared.snapshotURL, let data = try? Data(contentsOf: url) else { return nil }
        return try? JSONDecoder().decode(WidgetFile.self, from: data)
    }

    func write() {
        guard let url = WidgetShared.snapshotURL, let data = try? JSONEncoder().encode(self) else { return }
        try? data.write(to: url, options: .atomic)
    }
}

/// A tap on the widget, waiting for the app to add it to the database.
nonisolated struct WidgetTap: Codable, Sendable {
    /// Made at the tap: adding the same tap twice counts once.
    var entryID: String
    var habitID: String
    var day: String
    var value: Double
    var at: Date

    func save() {
        guard let folder = WidgetShared.tapsFolder, let data = try? JSONEncoder().encode(self) else { return }
        try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        try? data.write(to: folder.appendingPathComponent(entryID + ".json"), options: .atomic)
    }

    /// Every waiting tap, with the file each came from (deleted once the tap is saved in the database).
    static func pending() -> [(tap: WidgetTap, file: URL)] {
        guard let folder = WidgetShared.tapsFolder,
              let files = try? FileManager.default.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil) else { return [] }
        return files.compactMap { file in
            guard let data = try? Data(contentsOf: file), let tap = try? JSONDecoder().decode(WidgetTap.self, from: data) else { return nil }
            return (tap, file)
        }.sorted { $0.tap.at < $1.tap.at }
    }
}

/// ✓ or + on the Today widget: logs one step without opening the app (C023). Only ever adds, like a notification's
/// Done (a wrong tap is undone in the app; C090). The row updates at once, and its reminders for the day stop once it's
/// done (C039).
nonisolated struct LogHabitFromWidget: AppIntent {
    static let title: LocalizedStringResource = "Log a Habit"
    static let isDiscoverable = false

    @Parameter(title: "Habit") var habitID: String
    @Parameter(title: "Day") var day: String

    init() {}

    init(habitID: String, day: String) {
        self.habitID = habitID
        self.day = day
    }

    func perform() async throws -> some IntentResult {
        guard var file = WidgetFile.read(),
              let d = file.days.firstIndex(where: { $0.day == day }),
              let r = file.days[d].rows.firstIndex(where: { $0.id == habitID }),
              let step = file.days[d].rows[r].step,
              !file.days[d].rows[r].done else { return .result() }
        WidgetTap(entryID: UUID().uuidString, habitID: habitID, day: day, value: step, at: .now).save()
        var row = file.days[d].rows[r]
        row.progress += step
        if !row.isLimit && row.progress >= row.goal { row.done = true }
        file.days[d].rows[r] = row
        // Unfinished first, then done, as on Today.
        file.days[d].rows = file.days[d].rows.filter { !$0.done } + file.days[d].rows.filter { $0.done }
        file.write()
        if row.done { await Self.stopReminders(habitID: habitID, day: day) }
        WidgetCenter.shared.reloadTimelines(ofKind: WidgetShared.kind)
        return .result()
    }

    /// The day's reminders for this habit (their IDs name the habit and the day, "2026-9-29").
    private static func stopReminders(habitID: String, day: String) async {
        let parts = day.split(separator: "-").compactMap { Int($0) }
        guard parts.count == 3 else { return }
        let tag = "\(parts[0])-\(parts[1])-\(parts[2])"
        let center = UNUserNotificationCenter.current()
        let ids = await center.pendingNotificationRequests().map(\.identifier)
            .filter { $0.contains(habitID) && $0.contains(tag) }
        center.removePendingNotificationRequests(withIdentifiers: ids)
    }
}
