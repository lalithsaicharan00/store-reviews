#if DEBUG
import Foundation

/// The placement rules' test cases (iOS/Pending to Implement.md §2), run against an in-memory store.
/// The app has no unit-test target, so a UI test launches with `-placementcheck` and reads the result.
enum PlacementCheck {
    static func run() async -> [String] {
        var failures: [String] = []
        let store = HabitStore(repository: Persistence.inMemory().repository)
        await store.load()
        func expect(_ ok: Bool, _ name: String) { if !ok { failures.append(name) } }
        func habit(_ parts: [String], _ times: [(Int, Int)] = [], kind: HabitKind = .check, frequency: Frequency = .daily) -> Habit {
            Habit(name: "T", symbol: "star", color: .blue, kind: kind, parts: parts, frequency: frequency,
                  reminders: times.map { ReminderTime(hour: $0.0, minute: $0.1) })
        }

        expect(store.section(forMinute: 7 * 60).id == .morning, "7:00 is in Morning")
        expect(store.section(forMinute: 5 * 60 + 30).id == .morning, "5:30 is in Morning (before the first)")
        expect(store.section(forMinute: 12 * 60).id == .afternoon, "12:00 is in Afternoon (a start is inclusive)")
        store.settings.dayEndHour = 3
        expect(store.section(forMinute: 60).id == .evening, "1:00 with day end 3 is in the last")
        store.settings.dayEndHour = 0
        let two = store.placements(of: habit([.morning, .evening], [(7, 0), (21, 0)]))
        expect(two.map(\.slot) == [.morning, .evening] && two.map { $0.times.map(\.hour) } == [[7], [21]], "Morning + Evening → 2 ticks, each with its reminder")
        let away = store.placements(of: habit([.morning], [(21, 0)]))
        expect(away.map(\.section) == [.morning], "A reminder never moves the habit")
        let stray = store.placements(of: habit([.morning, .evening], [(13, 0)]))
        expect(stray[0].times.map(\.hour) == [13] && stray[1].times.isEmpty, "A reminder outside them belongs to the tick before it")
        let water = store.placements(of: habit([.morning, .evening], kind: .amount(unit: "glasses", increment: 1)))
        expect(water.count == 1 && water[0].section == .morning, "An amount is one row")
        let weekly = store.placements(of: habit([.morning, .evening], frequency: .perWeek(3)))
        expect(weekly.count == 1, "A few times a week is one row")
        expect(store.placements(of: habit([])).first?.section == .anytime, "No time of day → Anytime")
        store.saveSections(store.sections.filter { $0.id != .evening })
        await store.flush()
        expect(store.placements(of: habit(["gone"])).first?.section == .anytime, "An unknown time of day shows in Anytime")
        return failures
    }
}
#endif
