import Foundation
import Observation
import WidgetKit

extension HabitStore {
    static func widgetSignature(_ habit: Habit) -> String {
        ReminderIdentity.signature(habit)
    }

    func widgetSnapshot(now: Date = .now, hidden: Bool = false) -> WidgetSnapshot {
        let first = today(now: now)
        if hidden {
            let frames = (0..<7).map { offset in
                let day = first.adding(days: offset, calendar: calendar), bounds = dayBounds(day)
                return WidgetFrame(day: day.key, start: bounds.lowerBound, end: bounds.upperBound.addingTimeInterval(1), items: [])
            }
            return WidgetSnapshot(generated: now, timeZone: calendar.timeZone.identifier, locale: Locale.current.identifier,
                                  plus: isPlus, hidden: true, frames: frames)
        }
        var histories: [UUID: [WidgetDay]] = [:]
        // At most a month per habit; tasks never get fabricated habit statistics.
        for habit in habits where !habit.archived && habit.kind != .task && habit.kind != .quit {
            histories[habit.id] = (-30...0).map { offset in
                let day = first.adding(days: offset, calendar: calendar)
                return WidgetDay(id: day.key, label: String(day.day), state: String(describing: dayMark(habit, on: day)),
                                 value: progressValue(dayProgress(of: rule(habit, on: day), on: day), rule(habit, on: day)))
            }
        }
        let signatures = Dictionary(uniqueKeysWithValues: habits.filter { !$0.archived }.map { ($0.id, Self.widgetSignature($0)) })
        let frames = (0..<7).map { offset -> WidgetFrame in
            let day = first.adding(days: offset, calendar: calendar)
            let bounds = dayBounds(day)
            let ordered = shortcutDay(day).map(\.habit)
            let active = habits.filter { !$0.archived }
            let orderedIDs = Set(ordered.map(\.id))
            let rest = active.filter { !orderedIDs.contains($0.id) }
            let items = (ordered + rest).map { habit -> WidgetItem in
                let rule = rule(habit, on: day)
                let planned = startDay(of: habit) <= day && !isPaused(habit, on: day) && !isSkipped(habit, on: day)
                    && (habit.endsOn.map { day <= $0 } ?? true)
                    && (habit.kind == .quit || isDue(habit, on: day, now: max(now, bounds.lowerBound)))
                let value = progress(of: habit, on: day, now: now)
                let done = !rule.atMost && habit.kind != .quit && isSatisfied(habit, on: day)
                let start = habit.kind == .quit && planned ? quitHistory(of: habit, now: max(now, bounds.lowerBound)).last.flatMap { $0.endedBy == .ongoing ? $0.start : nil } : nil
                let nextPause = (pauses[habit.id] ?? []).filter { $0.from > day }.map { dayBounds($0.from).lowerBound }.min()
                let ending = habit.endsOn.map { dayBounds($0).upperBound.addingTimeInterval(1) }
                let counterUntil = habit.kind == .quit && start != nil ? min(nextPause ?? .distantFuture, ending ?? .distantFuture) : nil
                let action: String?
                switch rule.kind {
                case .check, .task: action = planned && !isDone(habit, on: day) ? "check" : nil
                case .amount: action = planned && (rule.atMost || !isDone(habit, on: day)) && rule.quickIncrement != nil ? "add" : nil
                default: action = nil
                }
                let goal = goal(of: rule)
                let status: String
                if done && habit.kind == .task { status = "Done" }
                else if !planned {
                    if isPaused(habit, on: day) { status = "Paused" }
                    else if let date = habit.dueDay, habit.kind == .task, date > day {
                        status = "Planned for \(date.date(calendar: calendar).formatted(date: .abbreviated, time: .omitted))"
                    } else { status = "Not planned today" }
                }
                else if habit.kind == .quit { status = "Since last slip" }
                else if habit.kind == .task { status = done ? "Done" : "For today" }
                else if rule.atMost { status = goalLine(rule, progress: value, goal: goal) + " · so far" }
                else if goal > 1 || rule.kind != .check { status = goalLine(rule, progress: value, goal: goal) }
                else { status = done ? "Done" : "For today" }
                return WidgetItem(id: habit.id.uuidString, name: habit.name, symbol: habit.symbol, color: habit.color.rawValue, status: status,
                                  value: value, goal: goal, done: done, planned: planned, ongoing: rule.atMost || habit.kind == .quit,
                                  isTask: habit.kind == .task, isQuit: habit.kind == .quit, action: action,
                                  stepLabel: rule.quickIncrement.map { progressValue($0, rule) }, token: UUID().uuidString,
                                  signature: signatures[habit.id] ?? "", counterStart: start, counterValidUntil: counterUntil,
                                  history: (histories[habit.id] ?? []).filter { $0.id >= day.adding(days: -30, calendar: calendar).key })
            }
            return WidgetFrame(day: day.key, start: bounds.lowerBound, end: bounds.upperBound.addingTimeInterval(1), items: hidden ? [] : items)
        }
        return WidgetSnapshot(generated: now, timeZone: calendar.timeZone.identifier, locale: Locale.current.identifier,
                              plus: isPlus, hidden: hidden, frames: frames)
    }
}

/// Coalesces publication after committed changes. Cancellation never cancels database writes.
@Observable final class WidgetPublisher {
    @ObservationIgnored private var scheduled: Task<Void, Never>?
    @ObservationIgnored private let testDestination: URL?
    init(file: URL? = nil) { testDestination = file }
    private(set) var problem: String?
    func schedule(_ store: HabitStore) {
        scheduled?.cancel()
        scheduled = Task {
            try? await Task.sleep(for: .milliseconds(180))
            guard !Task.isCancelled else { return }
            await publish(store)
        }
    }
    func publish(_ store: HabitStore) async {
        await store.flush()
        guard store.isLoaded, store.isStorageReady, store.problem == nil, !Task.isCancelled else { return }
        let hidden = UserDefaults.standard.bool(forKey: WidgetDisk.privacyKey) || AppLock.isEnabled
        let snapshot = store.widgetSnapshot(hidden: hidden)
        do {
            // Detached I/O avoids encoding and file coordination on the UI thread.
            try await WidgetSnapshotWriter.shared.write(snapshot, to: testDestination ?? WidgetDisk.url)
            problem = nil
            WidgetCenter.shared.reloadAllTimelines()
        } catch { problem = "Widgets couldn't be updated. Open the app and try again." }
    }
}

private actor WidgetSnapshotWriter {
    static let shared = WidgetSnapshotWriter()
    func write(_ snapshot: WidgetSnapshot, to file: URL?) throws { try WidgetDisk.write(snapshot, to: file) }
}
