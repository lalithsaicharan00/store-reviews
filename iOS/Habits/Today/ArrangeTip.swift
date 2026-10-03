import SwiftUI
import TipKit

/// The one tip, on Today's Edit (report 27, E; the user, 3 Oct 2026: "at the correct time, not randomly"). It shows only
/// when it's useful and the person knows the app a little: two or more habits share a time of day, and Today has been
/// opened on three different days. Shown once; gone for good as soon as Edit is used. Never in a test launch.
struct ArrangeTip: Tip {
    /// Today opened, counted once a day (`noteOpened`), so three donations are three different days.
    static let openedOnADay = Tips.Event(id: "today-opened-on-a-day")
    /// Some time of day holds two or more habits, so there's an order to choose.
    @Parameter static var hasOrderToChoose: Bool = false

    var title: Text { Text("Make Today Yours") }
    var message: Text? { Text("Tap Edit to put habits in your own order, and to rename, retime or add times of day.") }
    var image: Image? { Image(systemName: "arrow.up.arrow.down") }

    var rules: [Rule] {
        #Rule(Self.$hasOrderToChoose) { $0 == true }
        #Rule(Self.openedOnADay) { $0.donations.count >= 3 }
    }

    var options: [any TipOption] { [Tips.MaxDisplayCount(1)] }

    @MainActor private static var testLaunch = false

    /// Once at launch. Test launches and speed runs keep their own empty tip store and never show it (Rulebook D8).
    @MainActor static func configure() {
        let arguments = ProcessInfo.processInfo.arguments
        let test = arguments.contains("-uitest") || arguments.contains("-perf-drive") || arguments.contains { $0.hasSuffix("check") }
        testLaunch = test
        if test {
            Tips.hideAllTipsForTesting()
            let folder = FileManager.default.temporaryDirectory.appendingPathComponent("uitest-tips", isDirectory: true)
            try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
            try? Tips.configure([.datastoreLocation(.url(folder))])
        } else {
            try? Tips.configure([.displayFrequency(.immediate)])
        }
    }

    /// Today was opened on `day`: donated at most once a day (the last day kept in memory and UserDefaults, written
    /// only when the day changes, Rulebook S15).
    @MainActor static func noteOpened(on day: LocalDay) {
        guard !testLaunch else { return }
        let key = "tip.arrange.lastDay"
        guard UserDefaults.standard.string(forKey: key) != day.key else { return }
        UserDefaults.standard.set(day.key, forKey: key)
        Task { await openedOnADay.donate() }
    }

    /// Whether any time of day holds two or more habits; written only when it turns true.
    @MainActor static func update(_ store: HabitStore) {
        guard !hasOrderToChoose else { return }
        if store.cardMembers().values.contains(where: { $0.count >= 2 }) { hasOrderToChoose = true }
    }

    /// Edit was used: the tip's job is done.
    @MainActor static func used() {
        ArrangeTip().invalidate(reason: .actionPerformed)
    }
}
