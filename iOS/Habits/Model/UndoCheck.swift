#if DEBUG
import Core
import Foundation

/// Store invariants exercised by UndoUITests on GitHub's Mac, including derived stats and reminders.
enum UndoCheck {
    static func run() async -> [String] {
        var failures: [String] = []
        func expect(_ condition: Bool, _ name: String) { if !condition { failures.append(name) } }
        let persistence = Persistence.inMemory()
        let store = HabitStore(repository: persistence.repository)
        await store.load()
        let today = store.today()
        let yesterday = today.adding(days: -1, calendar: store.calendar)
        let water = Habit(name: "Water", symbol: "drop", color: .blue,
                          kind: .amount(unit: "glasses", increment: 1), goal: 8,
                          reminders: [ReminderTime(hour: 13, minute: 0)], startsOn: yesterday)
        store.add(water); await store.flush()
        store.addProgress(water, value: 8, on: yesterday, source: .daySheet)
        store.addProgress(water, value: 2, on: today, source: .manual)
        let first = store.entries(of: water.id, on: today).last!
        store.addProgress(water, value: 6, on: today, source: .reminder)
        let second = store.entries(of: water.id, on: today).last!
        expect(store.undoOffer?.id == first.id, "A reminder cannot replace the exact inline Undo")
        expect(store.streak(of: water, asOf: today) == 2, "Completed current day extends streak")
        expect(store.bestStreak(of: water) == 2, "Best streak cached before correction")
        _ = store.doneThisMonth(water, through: today)
        let scheduler = ReminderScheduler()
        let morning = store.calendar.startOfDay(for: today.date(calendar: store.calendar)).addingTimeInterval(12 * 3600)
        expect(!scheduler.plan(store, now: morning).contains { $0.day == today && $0.habit.id == water.id }, "Completed day stops reminders")
        store.editEntry(first.id, value: 1)
        expect(store.dayProgress(of: water, on: today) == 7, "Editing changes one value immediately")
        expect(store.entries(of: water.id, on: today).last?.id == second.id, "Editing older log preserves latest log order")
        expect(store.entries(of: water.id, on: today).first?.source == .manual, "Editing retains source")
        expect(store.dayMark(water, on: today) == .some, "Correction invalidates calendar result")
        expect(store.streak(of: water, asOf: today) == 1, "Correction invalidates streak")
        expect(store.bestStreak(of: water) == 1, "Correction invalidates best streak")
        expect(scheduler.plan(store, now: morning).contains { $0.day == today && $0.habit.id == water.id }, "Remaining reminders return below goal")
        store.undoEntry(first.id)
        expect(store.dayProgress(of: water, on: today) == 6, "Exact undo leaves newer reminder entry")
        store.editEntry(first.id, value: 9)
        expect(store.dayProgress(of: water, on: today) == 6, "An edit cannot revive a removed entry")
        store.editEntry(second.id, value: 8)
        store.undoEntry(second.id) // rapid edit, then delete, before the writes complete
        store.setSkipped(water, on: today, true)
        store.setSkipped(water, on: today, false)
        await store.flush()
        let loaded = HabitStore(repository: persistence.repository)
        await loaded.load()
        expect(loaded.entries(of: water.id, on: today).isEmpty, "Queued edit then delete survives reload")
        expect(!loaded.isSkipped(water, on: today), "Rapid skip then undo survives reload")
        expect(loaded.dayProgress(of: water, on: yesterday) == 8, "Today corrections leave yesterday intact")
        store.addProgress(water, value: 2, on: today, source: .routine)
        let persisted = store.entries(of: water.id, on: today).last!
        store.editEntry(persisted.id, value: 3)
        await store.flush(); await loaded.load()
        let reloaded = loaded.entries(of: water.id, on: today).last
        expect(reloaded?.id == persisted.id && reloaded?.day == today && reloaded?.source == .routine && reloaded?.value == 3
               && abs((reloaded?.createdAt ?? .distantPast).timeIntervalSince(persisted.createdAt)) < 0.001,
               "ID, day, time, source and edited value survive reload")
        let check = Habit(name: "Stretch", symbol: "figure.flexibility", color: .orange, kind: .check, goal: 3, startsOn: yesterday)
        store.add(check); await store.flush()
        store.setDayDone(true, of: check, on: yesterday)
        expect(store.dayProgress(of: check, on: yesterday) == 3, "Backfill uses selected day's check goal")
        store.setDayDone(false, of: check, on: yesterday)
        expect(store.entries(of: check.id, on: yesterday).isEmpty, "Not done removes only selected day's checks")
        await store.flush()
        expect(store.problem == nil, "All changes reached storage")
        return failures
    }
}

#endif
