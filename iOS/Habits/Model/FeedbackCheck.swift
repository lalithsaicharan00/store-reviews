#if DEBUG
import Foundation

/// The completion sound's rule (Current Work 18, 5 Oct 2026), checked on an in-memory store: each log records `true`
/// (the completion) or `false` (a light tap). Launch with `-feedbackcheck`; `FeedbackUITests` reads the result.
enum FeedbackCheck {
    static func run() async -> [String] {
        var failures: [String] = []
        let persistence = Persistence.inMemory()
        let store = HabitStore(repository: persistence.repository)
        await store.load()
        let log = Heard()
        store.onLog = { log.items.append($0) }
        let today = store.today()
        func expect(_ name: String, _ want: [Bool], _ steps: () -> Void) {
            log.items = []
            steps()
            if log.items != want { failures.append("\(name): expected \(want), heard \(log.items)") }
        }
        func add(_ habit: Habit) async { store.add(habit); await store.flush() }

        // Checklist: only the last of 4 steps.
        let kitchen = Habit(name: "Kitchen", symbol: "sparkles", color: .teal, kind: .checklist,
                            steps: [Step(name: "A"), Step(name: "B"), Step(name: "C"), Step(name: "D")])
        await add(kitchen)
        expect("Checklist", [false, false, false, true]) {
            for step in kitchen.steps { store.toggleStep(step, of: kitchen, on: today) }
        }

        // An amount: nothing on the way, the log that crosses 10 (9 → 11), nothing after.
        let water = Habit(name: "Water", symbol: "drop", color: .blue, kind: .amount(unit: "glasses", increment: 1), goal: 10)
        await add(water)
        expect("Amount crossing", [false, true, false]) {
            store.addProgress(water, value: 9, on: today)
            store.addProgress(water, value: 2, on: today)
            store.addProgress(water, value: 1, on: today)
        }

        // Typed and then corrected: an edit that takes 8 to 12 completes it.
        let pages = Habit(name: "Pages", symbol: "book", color: .purple, kind: .amount(unit: "pages", increment: 1), goal: 10)
        await add(pages)
        expect("Edit crossing", [false, true]) {
            store.addProgress(pages, value: 8, on: today)
            if let id = store.entries(of: pages.id, on: today).last?.id { store.editEntry(id, value: 12) }
        }

        // A check counted 3 times a day: the third.
        let teeth = Habit(name: "Teeth", symbol: "mouth", color: .blue, kind: .check, goal: 3)
        await add(teeth)
        expect("Three a day", [false, false, true]) {
            for _ in 0..<3 { store.addProgress(teeth, value: 1, on: today) }
        }

        // A week goal: the log that meets the week.
        let gym = Habit(name: "Gym", symbol: "dumbbell", color: .orange, kind: .check, frequency: .perWeek(3))
        await add(gym)
        expect("Week goal", [false, false, true]) {
            for _ in 0..<3 { store.addProgress(gym, value: 1, on: today) }
        }

        // A one-time task.
        let rent = Habit(name: "Rent", symbol: "house", color: .green, kind: .task, dueDay: today)
        await add(rent)
        expect("Task", [true]) { store.toggleCheck(rent, on: today) }

        // Time: a stop that passes the goal completes it; a later session doesn't again.
        let read = Habit(name: "Read", symbol: "book", color: .purple, kind: .duration, goal: 20)
        await add(read)
        expect("Timer stop crossing", [true, false]) {
            store.toggleTimer(read)
            store.stopTimer(read, on: today, through: .now.addingTimeInterval(25 * 60))
            store.toggleTimer(read)
            store.stopTimer(read, on: today, through: .now.addingTimeInterval(5 * 60))
        }

        // A running timer reaching its goal plays it then, once; stopping afterwards is only a tap.
        let breathe = Habit(name: "Breathe", symbol: "wind", color: .teal, kind: .duration, goal: 0.02) // 1.2 s
        await add(breathe)
        log.items = []
        store.toggleTimer(breathe)
        try? await Task.sleep(for: .seconds(2.5))
        store.stopTimer(breathe, on: today)
        if log.items != [true, false] { failures.append("Timer goal moment: expected [true, false], heard \(log.items)") }

        // Undone and logged again: a new crossing plays it again.
        let walk = Habit(name: "Walk", symbol: "figure.walk", color: .green, kind: .amount(unit: "km", increment: 1), goal: 2)
        await add(walk)
        expect("Undo and again", [true, true]) {
            store.addProgress(walk, value: 2, on: today)
            if let id = store.entries(of: walk.id, on: today).last?.id { store.undoEntry(id) }
            store.addProgress(walk, value: 2, on: today)
        }

        // Limits and quit habits: never the completion.
        let coffee = Habit(name: "Coffee", symbol: "cup.and.saucer", color: .brown, kind: .amount(unit: "cups", increment: 1),
                           goal: 2, atMost: true)
        await add(coffee)
        expect("Limit", [false, false, false]) {
            for _ in 0..<3 { store.addProgress(coffee, value: 1, on: today) }
        }
        let smoking = Habit(name: "Smoking", symbol: "nosign", color: .gray, kind: .quit)
        await add(smoking)
        expect("Quit slip", []) { _ = store.logSlip(smoking, at: .now) }

        await store.flush()
        store.onLog = nil
        return failures
    }

    /// What the logs played, in order (a box the store's main-actor closure can append to).
    private final class Heard { var items: [Bool] = [] }
}
#endif
