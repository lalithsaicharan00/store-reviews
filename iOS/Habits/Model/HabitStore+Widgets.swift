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
        prepareWidgetContext(now: now)
        let sectionOrder = Dictionary(uniqueKeysWithValues: sections.enumerated().map { ($1.id, $0) })
        let active = habits.enumerated().filter { !$0.element.archived }.sorted { a, b in
            if (a.element.kind == .task) != (b.element.kind == .task) { return a.element.kind != .task }
            let sa = placements(of: a.element).first.flatMap { sectionOrder[$0.section] } ?? 0
            let sb = placements(of: b.element).first.flatMap { sectionOrder[$0.section] } ?? 0
            return sa != sb ? sa < sb : a.offset < b.offset
        }.map(\.element)
        for habit in active where widgetProjectionCache[habit.id] == nil || timers[habit.id] != nil {
            widgetProjectionCache[habit.id] = widgetItems(habit, first: first, now: now)
        }
        let frames = (0..<7).map { offset -> WidgetFrame in
            let day = first.adding(days: offset, calendar: calendar), bounds = dayBounds(day)
            return WidgetFrame(day: day.key, start: bounds.lowerBound, end: bounds.upperBound.addingTimeInterval(1),
                               items: active.compactMap { widgetProjectionCache[$0.id]?[offset] })
        }
        return WidgetSnapshot(generated: now, timeZone: calendar.timeZone.identifier, locale: Locale.current.identifier,
                              plus: isPlus, hidden: hidden, frames: frames)
    }

    private func prepareWidgetContext(now: Date) {
        let context = "\(today(now: now).key)|\(calendar.timeZone.identifier)|\(Locale.current.identifier)|\(calendar.firstWeekday)|\(settings.dayEndHour)"
        if widgetProjectionContext != context { widgetProjectionCache = [:]; widgetProjectionContext = context }
    }

    /// Work stays on the store's actor; yield between items instead of blocking a frame for the whole corpus.
    func preparedWidgetSnapshot(now: Date = .now, hidden: Bool = false) async -> WidgetSnapshot {
        if hidden { return widgetSnapshot(now: now, hidden: true) }
        prepareWidgetContext(now: now)
        let first = today(now: now)
        for id in habits.filter({ !$0.archived }).map(\.id) {
            if Task.isCancelled { return widgetSnapshot(now: now, hidden: true) }
            // A previous yield may have allowed an edit or deletion; project the current rule.
            guard let habit = habits.first(where: { $0.id == id && !$0.archived }) else { continue }
            if widgetProjectionCache[habit.id] == nil || timers[habit.id] != nil {
                widgetProjectionCache[habit.id] = widgetItems(habit, first: first, now: now)
                await Task.yield()
            }
        }
        return widgetSnapshot(now: now)
    }

    private func widgetItems(_ habit: Habit, first: LocalDay, now: Date) -> [WidgetItem] {
        let history: [WidgetDay] = habit.kind == .task || habit.kind == .quit ? [] : (-30...0).map { offset in
            let day = first.adding(days: offset, calendar: calendar), historical = rule(habit, on: day)
            return WidgetDay(id: day.key, label: String(day.day), state: String(describing: dayMark(habit, on: day)),
                             value: progressValue(dayProgress(of: historical, on: day), historical))
        }
        let signature = Self.widgetSignature(habit)
        return (0..<7).map { offset in
            let day = first.adding(days: offset, calendar: calendar), bounds = dayBounds(day)
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
                              signature: signature, counterStart: start, counterValidUntil: counterUntil,
                              history: history.filter { $0.id >= day.adding(days: -30, calendar: calendar).key })
        }
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
        let ticket = WidgetPublicationOrder.next()
        var snapshot = await store.preparedWidgetSnapshot(hidden: hidden)
        guard !Task.isCancelled else { return }
        let currentHidden = UserDefaults.standard.bool(forKey: WidgetDisk.privacyKey) || AppLock.isEnabled
        if currentHidden != hidden { snapshot = store.widgetSnapshot(hidden: currentHidden) }
        do {
            // Detached I/O avoids encoding and file coordination on the UI thread.
            try await WidgetSnapshotWriter.shared.write(snapshot, to: testDestination ?? WidgetDisk.url, ticket: ticket)
            problem = nil
        } catch { problem = "Widgets couldn't be updated. Open the app and try again." }
    }
}

@MainActor private enum WidgetPublicationOrder {
    static var value: UInt64 = 0
    static func next() -> UInt64 { value &+= 1; return value }
}

private actor WidgetSnapshotWriter {
    static let shared = WidgetSnapshotWriter()
    private var latest: [URL: UInt64] = [:]
    func write(_ original: WidgetSnapshot, to file: URL?, ticket: UInt64) async throws {
        guard let file else { throw CocoaError(.fileNoSuchFile) }
        guard ticket >= (latest[file] ?? 0) else { return }
        var snapshot = original
        // A preparation that started before privacy was enabled cannot republish names afterward.
        let locked = !ProcessInfo.processInfo.arguments.contains("-uitest") && UserDefaults.standard.bool(forKey: "app_lock")
        if locked || UserDefaults.standard.bool(forKey: WidgetDisk.privacyKey) {
            snapshot.hidden = true
            snapshot.frames = snapshot.frames.map { frame in var hidden = frame; hidden.items = []; return hidden }
        }
        try WidgetDisk.write(snapshot, to: file)
        latest[file] = ticket
        // Uninstalled widgets need the snapshot for gallery configuration, but no timeline invalidation.
        let reload = await withCheckedContinuation { continuation in
            WidgetCenter.shared.getCurrentConfigurations { result in
                switch result {
                case .success(let widgets):
                    continuation.resume(returning: widgets.contains { $0.kind.hasPrefix("OftenEnough.") })
                case .failure: continuation.resume(returning: true)
                }
            }
        }
        if reload { WidgetCenter.shared.reloadAllTimelines() }
    }
}
