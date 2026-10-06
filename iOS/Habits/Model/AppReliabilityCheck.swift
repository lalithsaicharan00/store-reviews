#if DEBUG
import Core
import Foundation

/// The app under the same stress as the widgets (the user, 6 Oct 2026: "check app as well"): bursts of Today taps,
/// retried and out-of-order notification callbacks, ✓ on/off and ▶/⏸ storms, storms of saves and backups, a year of
/// history, midnight and the day start, daylight saving and time-zone travel. Runs in the iPhone app against the Kotlin
/// repository (`-appreliability`). What's shown must be what's stored: every burst is read back from storage.
enum AppReliabilityCheck {
    static func run() async -> [String] {
        var failures: [String] = []
        func expect(_ value: Bool, _ name: String) { if !value { failures.append(name) } }
        let persistence = Persistence.inMemory()
        let store = HabitStore(repository: persistence.repository)
        await store.load()
        let day = store.today()
        let start = day.adding(days: -30, calendar: store.calendar)
        let water = Habit(name: "Water", symbol: "drop.fill", color: .blue, kind: .amount(unit: "glasses", increment: 1), goal: 8, startsOn: start)
        let read = Habit(name: "Read", symbol: "book.fill", color: .orange, kind: .check, startsOn: start)
        let focus = Habit(name: "Focus", symbol: "timer", color: .purple, kind: .duration, goal: 20, startsOn: start)
        let time = ReminderTime(hour: 9, minute: 0)
        let pills = Habit(name: "Pills", symbol: "pills.fill", color: .red, kind: .amount(unit: "doses", increment: 1), goal: 10,
                          reminders: [time], remind: true, startsOn: start)
        for habit in [water, read, focus, pills] { store.add(habit) }
        await store.flush()
        func reloaded() async -> HabitStore {
            let fresh = HabitStore(repository: persistence.repository); await fresh.load(); return fresh
        }

        // MARK: A burst of Today taps and Undos, read back from storage

        for i in 0..<200 {
            store.increment(water, on: day)
            if i % 4 == 3 { store.undoProgress(water, on: day) }
        }
        await store.flush()
        expect(store.problem == nil && store.dayProgress(of: water, on: day) == 150, "200 + taps and 50 Undos: \(store.dayProgress(of: water, on: day))")
        var cold = await reloaded()
        expect(cold.dayProgress(of: water, on: day) == 150, "What the burst showed is what was stored")

        // MARK: ✓ on and off, quickly

        for _ in 0..<101 { store.toggleCheck(read, on: day) }
        await store.flush()
        expect(store.isDone(read, on: day) && store.entries(of: read.id, on: day).count == 1, "101 quick ✓ taps end ticked once")
        cold = await reloaded()
        expect(cold.entries(of: read.id, on: day).count == 1, "Stored once")

        // MARK: ▶ and ⏸, quickly; a retried ⏸ (the Live Activity's) saves once; a timer survives a restart

        for _ in 0..<20 { store.toggleTimer(focus) }
        expect(store.timers[focus.id] == nil, "Twenty quick ▶/⏸ taps end paused")
        store.toggleTimer(focus); await store.flush()
        cold = await reloaded()
        expect(cold.timers[focus.id] != nil, "A running timer survives the app being closed")
        try? await Task.sleep(for: .seconds(1.2))
        let sessions = store.entries(of: focus.id).count
        store.toggleTimer(focus)
        for _ in 0..<5 { store.stopTimer(focus, on: day) }
        await store.flush()
        expect(store.timers[focus.id] == nil && store.entries(of: focus.id).count == sessions + 1, "A repeated ⏸ saves the session once")

        // MARK: Notification callbacks retried and out of order

        let signature = ReminderIdentity.signature(pills)
        let events = (0..<6).map { _ in UUID() }
        for round in 0..<3 {
            for event in round % 2 == 0 ? events : events.reversed() {
                store.logFromReminder(pills, slot: nil, on: day, time: time.id, signature: signature, eventID: event)
            }
        }
        await store.flush()
        expect(store.dayProgress(of: pills, on: day) == 6, "Six notification Done taps, each delivered three times out of order, log six")
        store.logFromReminder(pills, slot: nil, on: day.adding(days: -2, calendar: store.calendar), time: time.id, signature: signature, eventID: UUID())
        await store.flush()
        expect(store.dayProgress(of: pills, on: day.adding(days: -2, calendar: store.calendar)) == 0, "A notification from two days ago logs nothing")

        // MARK: Storms of saves and backups

        var renamed = water
        for i in 0..<30 { renamed.name = "Water \(i)"; store.update(renamed) }
        await store.flush()
        cold = await reloaded()
        expect(cold.habits.first { $0.id == water.id }?.name == "Water 29", "Thirty quick edits store the last")
        var files: [URL] = []
        await withTaskGroup(of: URL?.self) { group in
            for _ in 0..<5 { group.addTask { @MainActor in try? await store.backupFile() } }
            for await file in group { if let file { files.append(file) } }
        }
        expect(files.count == 5, "Five backups at once all finish: \(files.count)")
        if let last = files.last {
            let restored = HabitStore(repository: Persistence.inMemory().repository)
            await restored.load()
            let summary = try? await restored.restore(from: last)
            expect(summary != nil && restored.habits.count == store.habits.count && restored.dayProgress(of: water, on: day) == 150,
                   "A backup made during the storm restores everything")
        }

        // MARK: Midnight and the day start (D7)

        do {
            var calendar = Calendar(identifier: .gregorian); calendar.timeZone = TimeZone(identifier: "Asia/Kolkata")!
            let night = HabitStore(repository: Persistence.inMemory().repository, calendar: calendar)
            await night.load()
            night.setDayEnd(3); await night.flush()
            let d = LocalDay(year: 2026, month: 10, day: 6)
            func at(_ dayOffset: Int, _ hour: Int, _ minute: Int) -> Date {
                calendar.date(from: DateComponents(year: 2026, month: 10, day: 6 + dayOffset, hour: hour, minute: minute))!
            }
            let walk = Habit(name: "Walk", symbol: "figure.walk", color: .green, kind: .check, startsOn: d.adding(days: -3, calendar: calendar))
            night.add(walk); await night.flush()
            for back in 1...3 { night.toggleCheck(walk, on: d.adding(days: -back, calendar: calendar)) }
            night.clock = { at(0, 23, 59) }
            expect(night.today() == d, "23:59 is still the day")
            night.toggleCheck(walk, on: night.today()); await night.flush()
            night.clock = { at(1, 0, 30) }
            expect(night.today() == d && night.isDone(walk, on: night.today()), "00:30, before a 3 AM day start, is still the same day, done")
            night.addProgress(walk, value: 1, on: d.adding(days: 1, calendar: calendar)); await night.flush()
            expect(night.entries(of: walk.id, on: d.adding(days: 1, calendar: calendar)).isEmpty, "Nothing logs into a day that hasn't started")
            night.clock = { at(1, 3, 0) }
            expect(night.today() == d.adding(days: 1, calendar: calendar) && !night.isDone(walk, on: night.today()),
                   "03:00 starts the new day, open")
            expect(night.streak(of: walk, asOf: night.today()) == 4, "An unfinished new day keeps the streak: \(night.streak(of: walk, asOf: night.today()))")
        }

        // MARK: Daylight saving and time-zone travel

        do {
            var newYork = Calendar(identifier: .gregorian); newYork.timeZone = TimeZone(identifier: "America/New_York")!
            var tokyo = Calendar(identifier: .gregorian); tokyo.timeZone = TimeZone(identifier: "Asia/Tokyo")!
            let shared = Persistence.inMemory()
            let home = HabitStore(repository: shared.repository, calendar: newYork)
            await home.load()
            for (month, date, hours) in [(3, 8, 23.0), (11, 1, 25.0)] {
                let bounds = home.dayBounds(LocalDay(year: 2026, month: month, day: date))
                expect(abs(bounds.upperBound.timeIntervalSince(bounds.lowerBound) + 1 - hours * 3600) < 1, "A \(Int(hours))-hour day across DST")
            }
            let today = home.today()
            let stretch = Habit(name: "Stretch", symbol: "figure.flexibility", color: .green, kind: .check,
                                startsOn: today.adding(days: -10, calendar: newYork))
            let quit = Habit(name: "No smoking", symbol: "nosign", color: .gray, kind: .quit,
                             startsOn: today.adding(days: -20, calendar: newYork), quitSince: Date.now.addingTimeInterval(-20 * 86_400))
            let timed = Habit(name: "Practice", symbol: "music.note", color: .indigo, kind: .duration, goal: 30,
                              startsOn: today.adding(days: -10, calendar: newYork))
            for habit in [stretch, quit, timed] { home.add(habit) }
            await home.flush()
            for back in 1...6 { home.toggleCheck(stretch, on: today.adding(days: -back, calendar: newYork)) }
            home.toggleTimer(timed)
            await home.flush()
            let yesterday = today.adding(days: -1, calendar: newYork)
            let homeStreak = home.streak(of: stretch, asOf: yesterday)
            let homeRun = home.quitRuns(of: quit).current
            // Landing in Tokyo: the same data opened with Tokyo's calendar.
            let away = HabitStore(repository: shared.repository, calendar: tokyo)
            await away.load()
            expect(away.entries(of: stretch.id).map(\.day).sorted() == home.entries(of: stretch.id).map(\.day).sorted(),
                   "Travelling never moves a logged day")
            expect(away.streak(of: stretch, asOf: yesterday) == homeStreak, "The streak survives travel: \(homeStreak)")
            expect(abs(away.quitRuns(of: quit).current - homeRun) < 5, "A quit run is real time: travel doesn't change it")
            expect(away.timers[timed.id] != nil, "A timer started at home is still running after landing")
            try? await Task.sleep(for: .seconds(1.2))
            away.toggleTimer(timed); await away.flush()
            expect(away.entries(of: timed.id).count == 1 && (away.entries(of: timed.id).first?.value ?? 0) > 0,
                   "Stopped after travelling, the session is saved once, with its real length")
        }

        // MARK: A year of history

        let yearData = Persistence.inMemory()
        let year = HabitStore(repository: yearData.repository)
        await year.load()
        let first = year.today().adding(days: -370, calendar: year.calendar)
        var habits: [Habit] = []
        for i in 0..<15 {
            let habit = Habit(name: "Year \(i)", symbol: "star", color: HabitColor.allCases[i % HabitColor.allCases.count],
                              kind: i % 3 == 0 ? .check : .amount(unit: "pages", increment: 5), goal: i % 3 == 0 ? 1 : 20, startsOn: first)
            year.add(habit); habits.append(habit)
        }
        await year.flush()
        let now = year.today()
        for habit in habits {
            for back in 1...365 where back % 9 != 4 {
                let d = now.adding(days: -back, calendar: year.calendar)
                if case .check = habit.kind { year.toggleCheck(habit, on: d) } else { year.addProgress(habit, value: Double(back % 25 + 1), on: d) }
            }
        }
        await year.flush()
        let started = Date.now
        let summary = year.daySummary(on: now)
        let streaks = habits.map { year.streak(of: $0, asOf: now) }
        let best = habits.map { year.bestStreak(of: $0) }
        _ = year.progressSnapshot(.month, containing: now)
        _ = year.progressSnapshot(.year, containing: now)
        let firstTime = Date.now.timeIntervalSince(started)
        let again = Date.now
        _ = habits.map { year.streak(of: $0, asOf: now) }
        _ = year.progressSnapshot(.month, containing: now)
        let cachedTime = Date.now.timeIntervalSince(again)
        expect(summary.total == 15 && streaks.allSatisfy { $0 >= 0 } && best.contains { $0 >= 3 }, "A year: Today, streaks and bests")
        expect(firstTime < 15 && cachedTime < 3, "A year of 15 habits: first \(firstTime) s, remembered \(cachedTime) s")
        let reread = HabitStore(repository: yearData.repository)
        await reread.load()
        expect(habits.map { reread.streak(of: $0, asOf: now) } == streaks, "A year's streaks read back the same after a restart")
        print("App reliability: a year of 15 habits, first \(firstTime) s, remembered \(cachedTime) s")
        return failures
    }
}
#endif
