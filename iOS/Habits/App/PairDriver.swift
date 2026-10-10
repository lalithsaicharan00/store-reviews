import Foundation

#if DEBUG
/// The paired-simulator check, iPhone side (`-uitest -empty -pair-test -pair-drive`; `Tools/ci/watch_pair.sh` runs the
/// Watch side, `WatchPairDriver`, at the same time on its paired Watch simulator). Each step is written to `PairLog`.
///  1. Adds "Pair water" (+1 glass) and "Pair timer" and logs +1 glass here: the Watch's first fill brings all three.
///  2. Waits for the Watch's two +1s, logged from a routine on the Watch while this app is open (3 glasses here).
///  3. Waits for the timer the Watch starts, and stops it here: one log on both devices.
///  4. Waits for anything late, then checks: 3 glasses, one timer log, no timer running.
@MainActor
enum PairDriver {
    static func startIfAsked(store: HabitStore) {
        guard AppModel.pairTest, ProcessInfo.processInfo.arguments.contains("-pair-drive") else { return }
        Task { @MainActor in await run(store) }
    }

    private static func run(_ store: HabitStore) async {
        PairLog.reset()
        let day = store.today()
        let water = Habit(name: "Pair water", symbol: "drop.fill", color: .blue, kind: .amount(unit: "glasses", increment: 1), goal: 8, remind: false)
        let timer = Habit(name: "Pair timer", symbol: "timer", color: .purple, kind: .duration, goal: 20, remind: false)
        store.add(water)
        store.add(timer)
        await store.flush()
        guard let saved = store.habits.first(where: { $0.id == water.id }) else { return PairLog.finish(false, "phone: couldn't add the habits") }
        store.increment(saved, on: day, source: .today)
        await store.flush()
        PairLog.write("phone: added Pair water and Pair timer, +1 glass")
        guard await PairLog.wait("the Watch's two +1s (3 glasses)", 300, { glasses(store, water.id, day) >= 3 }) else { return }
        guard await PairLog.wait("the timer started on the Watch", 240, { store.timers[timer.id] != nil }) else { return }
        try? await Task.sleep(for: .seconds(3))
        if let current = store.habits.first(where: { $0.id == timer.id }) { store.stopTimer(current, on: store.today()) }
        await store.flush()
        PairLog.write("phone: stopped the timer")
        try? await Task.sleep(for: .seconds(25))
        let total = glasses(store, water.id, day)
        let logs = store.entries(of: timer.id, on: day).count
        let running = store.timers[timer.id] != nil
        PairLog.finish(total == 3 && logs == 1 && !running,
                       "phone: \(Int(total)) glasses, \(logs) timer log(s), timer \(running ? "still running" : "stopped")")
    }

    private static func glasses(_ store: HabitStore, _ id: UUID, _ day: LocalDay) -> Double {
        store.entries(of: id, on: day).reduce(0) { $0 + $1.value }
    }
}
#endif
