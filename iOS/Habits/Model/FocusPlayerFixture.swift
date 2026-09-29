#if DEBUG
import Core
import Foundation

/// Explicit test-only mixed routine; uses normal writes and never replaces an existing database.
enum FocusPlayerFixture {
    static func install(in store: HabitStore, shortTimer: Bool = false) async {
        guard store.habits.isEmpty else { return }
        let water = Habit(name: "Drink water", symbol: "drop.fill", color: .blue,
                          kind: .amount(unit: "glasses", increment: 1), goal: 2)
        let check = Habit(name: "Stretch", symbol: "figure.flexibility", color: .orange, kind: .check, goal: 3)
        let checklist = Habit(name: "Clean kitchen", symbol: "sparkles", color: .teal, kind: .checklist,
                              steps: [Step(name: "Wash dishes"), Step(name: "Wipe the counter"), Step(name: "Sweep the floor")])
        let timed = Habit(name: "Read a little", symbol: "book.fill", color: .purple, kind: .duration, goal: shortTimer ? 0.05 : 20)
        let limit = Habit(name: "Less coffee", symbol: "cup.and.saucer.fill", color: .brown,
                          kind: .amount(unit: "cups", increment: 1), goal: 2, atMost: true)
        let task = Habit(name: "Water the plants", symbol: "leaf.fill", color: .green, kind: .task,
                         dueDay: store.today())
        if ProcessInfo.processInfo.arguments.contains("-focus-limit-only") {
            store.add(limit); await store.flush(); return
        }
        for habit in [water, check, checklist, timed, limit, task] { store.add(habit) }
        if ProcessInfo.processInfo.arguments.contains("-focus-period-fixture") {
            let weekly = Habit(name: "Call family", symbol: "phone", color: .green, kind: .check, frequency: .perWeek(3))
            let monthly = Habit(name: "Monthly reading", symbol: "book", color: .purple, kind: .duration, goal: 60, frequency: .perMonth(1))
            let yearly = Habit(name: "Yearly distance", symbol: "figure.walk", color: .blue, kind: .amount(unit: "km", increment: 5), goal: 100, frequency: .perYear(1))
            let flexible = Habit(name: "Flexible reading", symbol: "book", color: .purple, kind: .duration, goal: 20, frequency: .flexible(.week, 3))
            for habit in [weekly, monthly, yearly, flexible] { store.add(habit) }
            await store.flush()
            store.toggleCheck(weekly, on: store.today())
            store.toggleCheck(weekly, on: store.today())
        }
        await store.flush()
        store.increment(water, on: store.today())
        store.toggleStep(checklist.steps[0], of: checklist, on: store.today())
        await store.flush()
    }
}

/// Persistence invariants that cannot be tested reliably by waiting for midnight in a UI test.
enum FocusPlayerCheck {
    static func run() async -> [String] {
        var failures: [String] = []
        func expect(_ result: Bool, _ name: String) { if !result { failures.append(name) } }
        let persistence = Persistence.inMemory()
        let store = HabitStore(repository: persistence.repository)
        await store.load()
        let day = LocalDay(year: 2026, month: 1, day: 1)
        let timed = Habit(name: "Read", symbol: "book", color: .blue, kind: .duration, goal: 20, startsOn: day)
        let water = Habit(name: "Water", symbol: "drop", color: .blue, kind: .amount(unit: "ml", increment: 250), goal: 2000, startsOn: day)
        store.add(timed); store.add(water); await store.flush()
        let start = Date.now.addingTimeInterval(-120)
        do {
            try await persistence.repository.saveSetting(key: "timer." + timed.id.uuidString, value: String(start.millis))
        } catch { return ["Could not set up persisted timer"] }
        await store.load()
        expect(store.timers[timed.id] != nil, "Running timer restored")
        store.stopTimer(timed, on: day, through: start.addingTimeInterval(60))
        await store.flush()
        let saved = store.entries.first { $0.habitID == timed.id }
        expect(saved?.day == day, "Stopping uses the session tracking day")
        expect(abs((saved?.value ?? 0) - 1) < 0.001, "Only time through the supplied boundary is saved")
        store.stopTimer(timed, on: day); await store.flush()
        expect(store.entries.filter { $0.habitID == timed.id }.count == 1, "Repeated stop cannot duplicate time")
        expect(store.timers[timed.id] == nil, "Repeated stop cannot restart a timer")
        store.addProgress(water, value: 250, on: day); await store.flush()
        let first = store.entries.last!.id
        store.addProgress(water, value: 500, on: day); await store.flush()
        store.undoEntry(first); await store.flush()
        expect(store.dayProgress(of: water, on: day) == 500, "Undo removes its exact entry, not a newer log")
        let reload = HabitStore(repository: persistence.repository); await reload.load()
        expect(reload.timers[timed.id] == nil, "Stopped marker stays removed after reload")
        expect(reload.dayProgress(of: water, on: day) == 500, "Undo persists after reload")
        expect(abs(reload.dayProgress(of: timed, on: day) - 1) < 0.001, "Elapsed time persists after reload")
        return failures
    }
}
#endif
