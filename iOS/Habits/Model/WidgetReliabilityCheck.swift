#if DEBUG
import Core
import Foundation

/// The widgets under stress (the user, 6 Oct 2026: "widgets need to be very reliable"; Feature Ledger C040, widgets that
/// went blank, stale or wrong, the most-reported widget failure). Runs in the iPhone app against the Kotlin repository
/// (`-widgetreliability`). Every case is a way a real widget gets used or abused: quick bursts of taps, iOS retrying a
/// callback, a tap from a widget drawn before an edit or before midnight, privacy switched on mid-run, a habit deleted
/// while taps are queued, many publications at once, a year of history, travel and a damaged file.
enum WidgetReliabilityCheck {
    static func run() async -> [String] {
        var failures: [String] = []
        func expect(_ value: Bool, _ name: String) { if !value { failures.append(name) } }
        HideNames.setChosen(false)
        UserDefaults.standard.set(DoneOrder.bottom.rawValue, forKey: Preferences.doneOrder)
        UserDefaults.standard.set(false, forKey: Preferences.timerScreen)
        defer { UserDefaults.standard.set(true, forKey: Preferences.timerScreen) }
        let persistence = Persistence.inMemory()
        let store = HabitStore(repository: persistence.repository)
        await store.load(); await WidgetFixture.install(in: store)
        let now = Date.now, day = store.today(now: now)
        func habit(_ name: String) -> Habit { store.habits.first { $0.name == name }! }
        func signature(_ habit: Habit) -> String { HabitStore.widgetSignature(habit) }
        let water = habit("Widget water"), check = habit("Widget check"), timer = habit("Widget timer")

        // MARK: A burst of taps, with the app tapping too, then every callback retried out of order

        var events: [UUID] = []
        for i in 0..<40 {
            let event = UUID(); events.append(event)
            store.logFromWidget(id: water.id, day: day, event: event, signature: signature(water), now: now)
            if i % 4 == 0 { store.addProgress(water, value: 1, on: day, source: .today) }
        }
        await store.flush()
        expect(store.problem == nil && store.dayProgress(of: water, on: day) == 50,
               "40 widget taps and 10 app taps in one burst keep every one: \(store.dayProgress(of: water, on: day))")
        for _ in 0..<3 { for event in events.reversed() { store.logFromWidget(id: water.id, day: day, event: event, signature: signature(water), now: now) } }
        await store.flush()
        expect(store.dayProgress(of: water, on: day) == 50, "120 retried callbacks, out of order, add nothing")
        let cold = HabitStore(repository: persistence.repository); await cold.load()
        expect(cold.dayProgress(of: water, on: day) == 50 && cold.entries(of: water.id).filter { $0.source == .widget }.count == 40,
               "After a cold start every widget tap is still there, once")
        let afterBurst = store.widgetSnapshot(now: now).frames[0].item(water.id.uuidString)
        expect(afterBurst?.value == "50 of 8 glasses" && afterBurst?.done == true && afterBurst?.action == .add,
               "The widget agrees with the store after the burst: \(afterBurst?.value ?? "nil")")

        // MARK: ✓ tapped on and off quickly

        for i in 0..<21 {
            store.logFromWidget(id: check.id, day: day, event: UUID(), signature: signature(check), mode: i % 2 == 0 ? "check" : "uncheck", now: now)
        }
        await store.flush()
        expect(store.entries(of: check.id, on: day).count == 1, "21 quick ✓ taps end ticked once, never twice")
        for _ in 0..<5 { store.logFromWidget(id: check.id, day: day, event: UUID(), signature: signature(check), mode: "check", now: now) }
        await store.flush()
        expect(store.entries(of: check.id, on: day).count == 1, "A done ✓ tapped again from a stale widget never adds a second tick")

        // MARK: ▶ and ⏸ tapped quickly; retried ⏸ never saves twice

        for i in 0..<10 { store.timerFromWidget(id: timer.id, day: day, start: i % 2 == 0, signature: signature(timer), now: now) }
        expect(store.timers[timer.id] == nil, "Ten quick ▶/⏸ taps end paused")
        for _ in 0..<5 { store.timerFromWidget(id: timer.id, day: day, start: true, signature: signature(timer), now: now) }
        expect(store.timers.count == 1, "Repeated ▶ starts one timer")
        try? await Task.sleep(for: .seconds(1.2))
        let sessions = store.entries(of: timer.id).count
        for _ in 0..<5 { store.timerFromWidget(id: timer.id, day: day, start: false, signature: signature(timer), now: now) }
        await store.flush()
        expect(store.timers[timer.id] == nil && store.entries(of: timer.id).count == sessions + 1, "Repeated ⏸ saves the session once")

        // MARK: A widget drawn before an edit

        let cut = habit("Widget cut down")
        let drawn = store.widgetSnapshot(now: now).frames[0].item(cut.id.uuidString)!
        var edited = cut; edited.goal = 5; store.update(edited); await store.flush()
        let beforeEdit = store.dayProgress(of: edited, on: day)
        store.logFromWidget(id: cut.id, day: day, event: UUID(uuidString: drawn.token)!, signature: drawn.signature, now: now)
        await store.flush()
        expect(store.dayProgress(of: edited, on: day) == beforeEdit && store.problem != nil, "A button drawn before an edit is refused")
        store.problem = nil

        // MARK: Names hidden in the middle of a run of taps (Current Work 58): every tap still counts, once, in order

        for _ in 0..<5 { store.logFromWidget(id: cut.id, day: day, event: UUID(), signature: signature(edited), now: now) }
        await store.flush()
        HideNames.setChosen(true)
        let discreetEvents = (0..<5).map { _ in UUID() }
        for event in discreetEvents { store.logFromWidget(id: cut.id, day: day, event: event, signature: signature(edited), now: now) }
        // iOS retrying the same callbacks: each counts once.
        for event in discreetEvents { store.logFromWidget(id: cut.id, day: day, event: event, signature: signature(edited), now: now) }
        await store.flush()
        HideNames.setChosen(false)
        expect(store.dayProgress(of: edited, on: day) == beforeEdit + 10 && store.problem == nil,
               "Taps after names are hidden still log, each once")
        let order = store.entries(of: cut.id).filter { discreetEvents.contains($0.id) }.map(\.id)
        expect(order == discreetEvents, "Taps with names hidden are saved in the order made")
        store.problem = nil

        // MARK: Undo, then the undone tap retried

        let undone = UUID()
        store.logFromWidget(id: water.id, day: day, event: undone, signature: signature(water), now: now); await store.flush()
        store.undoEntry(undone); await store.flush()
        for _ in 0..<3 { store.logFromWidget(id: water.id, day: day, event: undone, signature: signature(water), now: now) }
        await store.flush()
        expect(!store.entries(of: water.id).contains { $0.id == undone }, "An undone widget tap never comes back when retried")

        // MARK: A habit deleted while its taps are still queued

        let doomed = Habit(name: "Widget doomed", symbol: "trash", color: .gray, kind: .amount(unit: "", increment: 1), goal: 3,
                           startsOn: day.adding(days: -2, calendar: store.calendar))
        store.add(doomed); await store.flush()
        for _ in 0..<3 { store.logFromWidget(id: doomed.id, day: day, event: UUID(), signature: signature(doomed), now: now) }
        store.delete([doomed])
        store.logFromWidget(id: doomed.id, day: day, event: UUID(), signature: signature(doomed), now: now)
        await store.flush()
        expect(!store.habits.contains { $0.id == doomed.id } && store.widgetSnapshot(now: now).frames[0].item(doomed.id.uuidString) == nil,
               "A deleted habit is never revived by taps queued around its deletion")
        store.problem = nil

        // MARK: The snapshot always agrees with Today and Progress

        let snapshot = store.widgetSnapshot(now: now)
        for item in snapshot.frames[0].items where !item.isTask {
            guard let h = store.habits.first(where: { $0.id.uuidString == item.id }) else { failures.append("A widget row with no habit"); continue }
            let cells = store.heatCells(h, in: store.period(.week, containing: day), range: .week, today: day).map(HabitStore.widgetCell)
            expect(item.week == cells, "\(h.name): the widget's week is Progress's week")
            if h.kind != .quit && !h.atMost && item.state == nil {
                expect(item.done == store.isComplete(h, on: day), "\(h.name): done on the widget is done in the app")
            }
        }
        for frame in snapshot.frames {
            for (key, ids) in frame.lists {
                expect(Set(ids).count == ids.count, "\(frame.day) \(key): no row twice")
                expect(ids.allSatisfy { id in frame.items.contains { $0.id == id } }, "\(frame.day) \(key): every row exists")
            }
            let listed = Set(frame.lists.filter { !$0.key.contains(":") }.values.flatMap { $0 })
            for item in frame.items where !item.cards.isEmpty {
                expect(listed.contains(item.id), "\(frame.day): \(item.name) is on Today, so it's on its widget list")
            }
        }

        // MARK: Many publications at once: the newest wins and the file is never half written

        let directory = FileManager.default.temporaryDirectory.appendingPathComponent("WidgetReliability-" + UUID().uuidString)
        defer { try? FileManager.default.removeItem(at: directory) }
        let file = directory.appendingPathComponent("snapshot.json")
        let publisher = WidgetPublisher(file: file)
        var tasks: [Task<Void, Never>] = []
        for i in 0..<20 {
            if i == 10 { store.addProgress(water, value: 1, on: day, source: .today) }
            let task = Task { await publisher.publish(store, hold: i % 3 == 0) }
            if i % 5 == 4 { task.cancel() }
            tasks.append(task)
        }
        for task in tasks { await task.value }
        await publisher.publish(store)
        let published = WidgetDisk.read(from: file)
        expect(published != nil && publisher.problem == nil, "Twenty overlapping publications leave a readable snapshot")
        expect(published?.frames[0].item(water.id.uuidString)?.value == "\(Int(store.dayProgress(of: water, on: day))) of 8 glasses",
               "The last change is the one on disk")

        // MARK: A damaged file, travel, and midnight

        if let data = try? Data(contentsOf: file) {
            try? data.prefix(data.count / 2).write(to: file, options: .atomic)
            let damaged = PhoneWidgetTimeline.entries(snapshot: WidgetDisk.read(from: file), now: now, listKey: "habits") { _ in }
            expect(WidgetDisk.read(from: file) == nil && damaged.first?.status == .stale, "A half-written file shows Open to update, never blank")
        } else { failures.append("No published file to damage") }
        var travelled = snapshot
        travelled.timeZone = TimeZone.current.identifier == "Pacific/Kiritimati" ? "America/New_York" : "Pacific/Kiritimati"
        expect(PhoneWidgetTimeline.entries(snapshot: travelled, now: now, listKey: "habits") { _ in }.first?.status == .stale,
               "After travelling to another time zone the widget asks the app to update")
        let midnight = store.dayBounds(day).upperBound
        let late = store.widgetSnapshot(now: midnight.addingTimeInterval(-30))
        let next = day.adding(days: 1, calendar: store.calendar)
        expect(late.frame(at: midnight.addingTimeInterval(30))?.day == next.key, "Just after midnight the widget shows the new day by itself")
        expect(PhoneWidgetTimeline.entries(snapshot: late, now: midnight.addingTimeInterval(-30), listKey: "habits") { _ in }
                .contains { abs($0.date.timeIntervalSince(midnight)) < 2 }, "The timeline redraws at the day's start")
        let lateCount = store.dayProgress(of: water, on: day)
        store.logFromWidget(id: water.id, day: day, event: UUID(), signature: signature(water), now: midnight.addingTimeInterval(30))
        await store.flush()
        expect(store.dayProgress(of: water, on: day) == lateCount && store.problem != nil, "Yesterday's button tapped after midnight is refused")
        store.problem = nil
        store.logFromWidget(id: water.id, day: next, event: UUID(), signature: signature(water), now: midnight.addingTimeInterval(30))
        await store.flush()
        expect(store.dayProgress(of: water, on: next) == 1, "The new day's button logs into the new day")

        // MARK: A year of history, many habits

        let big = HabitStore(repository: Persistence.inMemory().repository)
        await big.load()
        let first = big.today(now: now).adding(days: -370, calendar: big.calendar)
        var bigHabits: [Habit] = []
        for i in 0..<12 {
            let h = Habit(name: "Year \(i)", symbol: "star", color: HabitColor.allCases[i % HabitColor.allCases.count],
                          kind: i % 3 == 0 ? .check : .amount(unit: "pages", increment: 5), goal: i % 3 == 0 ? 1 : 20, startsOn: first)
            big.add(h); bigHabits.append(h)
        }
        await big.flush()
        let today = big.today(now: now)
        for h in bigHabits {
            for back in 1...365 where back % 7 != 3 {
                if case .check = h.kind { big.toggleCheck(h, on: today.adding(days: -back, calendar: big.calendar)) }
                else { big.addProgress(h, value: Double(back % 25 + 1), on: today.adding(days: -back, calendar: big.calendar)) }
            }
        }
        await big.flush()
        let started = Date.now
        let year = await big.preparedWidgetSnapshot(now: now)
        let firstTime = Date.now.timeIntervalSince(started)
        let again = Date.now
        _ = big.widgetSnapshot(now: now)
        let cachedTime = Date.now.timeIntervalSince(again)
        let encoded = try? JSONEncoder().encode(year)
        expect(encoded.map { WidgetDisk.decode($0) != nil && $0.count < WidgetDisk.maximumBytes } == true,
               "A year of history fits and reads back")
        expect(year.frames[0].items.filter { !$0.isTask }.allSatisfy { $0.week.count == 7 } && year.frames[0].items.contains { $0.streak != nil },
               "Week squares and streaks for a year-old habit")
        expect(firstTime < 10 && cachedTime < 2, "A year of 12 habits: first \(firstTime) s, remembered \(cachedTime) s")
        print("Widget reliability: a year of 12 habits, first snapshot \(firstTime) s, remembered \(cachedTime) s, \(encoded?.count ?? 0) bytes")
        return failures
    }
}
#endif
