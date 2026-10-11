import Foundation

#if DEBUG
/// The paired-simulator check, Watch side (`-uitest -pair-test -pair-drive`; the iPhone side is `PairDriver`).
///  1. Waits for the first fill from the iPhone: "Pair water" with its 1 glass, and "Pair timer".
///  2. Opens a routine and logs +1 glass twice from it, while the iPhone app is open.
///  3. Starts "Pair timer" here; the iPhone stops it. Waits for the stop and its one log.
///  4. Waits for anything late, then checks: 3 glasses, one timer log, no timer running.
@MainActor
enum WatchPairDriver {
    static func startIfAsked(model: WatchModel, navigation: WatchNavigation) {
        guard WatchModel.pairTest, ProcessInfo.processInfo.arguments.contains("-pair-drive") else { return }
        Task { @MainActor in await run(model, navigation) }
    }

    private static func run(_ model: WatchModel, _ navigation: WatchNavigation) async {
        PairLog.reset()
        let store = model.store
        let day = store.today()
        func habit(_ name: String) -> Habit? { store.habits.first { $0.name == name } }
        PairLog.write("watch: waiting for the first fill")
        guard await PairLog.wait("the first fill (Pair water at 1 glass, Pair timer)", 300, {
            guard let water = habit("Pair water"), habit("Pair timer") != nil else { return false }
            return model.filled && glasses(store, water.id, day) == 1
        }) else { return }
        guard let water = habit("Pair water"), let timer = habit("Pair timer") else { return }
        let plan = TodayPlan.make(store)
        if let section = plan.sections.first(where: { section in !section.isQuitting && section.rows.contains { $0.habit.id == water.id } }) {
            navigation.routine = RoutineSession(part: section.id, title: section.title, day: plan.day, habits: section.rows.map(\.habit))
            PairLog.write("watch: opened the \(section.title) routine")
        }
        try? await Task.sleep(for: .seconds(1))
        for _ in 0..<2 {
            if let current = habit("Pair water") { store.increment(current, on: day, source: .watch) }
            try? await Task.sleep(for: .milliseconds(600))
        }
        await store.flush()
        PairLog.write("watch: +1 glass twice")
        try? await Task.sleep(for: .seconds(2))
        navigation.routine = nil
        store.startTimerOnWatch(timer)
        await store.flush()
        PairLog.write("watch: started Pair timer")
        guard await PairLog.wait("the iPhone stop the timer, with its one log", 300, {
            store.timers[timer.id] == nil && store.entries(of: timer.id, on: day).count == 1
        }) else { return }
        try? await Task.sleep(for: .seconds(20))
        let total = glasses(store, water.id, day)
        let logs = store.entries(of: timer.id, on: day).count
        let running = store.timers[timer.id] != nil
        PairLog.finish(total == 3 && logs == 1 && !running,
                       "watch: \(Int(total)) glasses, \(logs) timer log(s), timer \(running ? "still running" : "stopped")")
    }

    private static func glasses(_ store: HabitStore, _ id: UUID, _ day: LocalDay) -> Double {
        store.entries(of: id, on: day).reduce(0) { $0 + $1.value }
    }
}
#endif
