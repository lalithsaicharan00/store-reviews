#if DEBUG
import Foundation

enum TaskFixture {
    static func install(in store: HabitStore) async {
        guard store.habits.isEmpty else { return }
        let today = store.today(), start = today.adding(days: -30)
        for (i, name) in ["Old task", "Future task", "Completed task", "Repeating task", "Archived task"].enumerated() {
            var task = Habit(name: name, symbol: "checkmark", color: .blue, kind: .task,
                             dueDay: i == 3 ? nil : today.adding(days: i == 1 ? 14 : -3), remind: false)
            task.createdAt = start.date()
            if i == 3 { task.frequency = .afterCompletion(2, .day); task.startsOn = start }
            if i == 4 { task.archived = true }
            store.add(task); await store.flush()
            if i == 2 { store.toggleCheck(task, on: today.adding(days: -3)); await store.flush() }
        }
    }
}

enum TaskCheck {
    static func run() async -> [String] {
        var failures: [String] = []
        func expect(_ value: Bool, _ name: String) { if !value { failures.append(name) } }
        let persistence = Persistence.inMemory()
        let store = HabitStore(repository: persistence.repository)
        await store.load(); await TaskFixture.install(in: store)
        expect(store.habits.filter { $0.kind == .task }.count == 5, "all five task types are loaded")
        expect(store.activeHabitCount == 0 && store.canAddHabit, "tasks do not consume free habit slots")
        for _ in 0..<5 { store.add(Habit(name: "Habit", symbol: "star", color: .blue, kind: .check)) }
        await store.flush()
        expect(!store.canAddHabit, "five habits still enforce the habit cap")
        let archived = store.habits.first { $0.name == "Archived task" }!
        expect(store.restore(archived), "archived task restores for free at the habit cap")
        await store.flush()
        for original in store.habits.filter({ $0.kind == .task }) {
            var task = original; task.name += " edited"
            store.update(task); await store.flush()
            let read = HabitStore(repository: persistence.repository); await read.load()
            let saved = read.habits.first { $0.id == task.id }
            expect(saved?.name == task.name && saved?.dueDay == original.dueDay && saved?.frequency == original.frequency,
                   "task name, date and recurrence persist: \(original.name)")
            if original.name == "Completed task" {
                expect(saved.map { read.isDone($0, on: read.today()) } == true, "editing keeps completion")
            }
        }
        return failures
    }
}
#endif
