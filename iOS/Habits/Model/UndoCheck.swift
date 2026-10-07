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
        let doneBefore = store.doneThisMonth(water, through: today)
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
        expect(store.doneThisMonth(water, through: today) == doneBefore - 1, "Correction invalidates done-this-month cache")
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
        store.setSkipped(check, on: today, true)
        var changed = check
        changed.frequency = .perWeek(3)
        store.update(changed); await store.flush()
        store.setSkipped(changed, on: today, false)
        expect(!store.isSkipped(changed, on: today), "Undo skip remains available after changing the schedule")
        await store.flush()
        store.addProgress(changed, value: 2, on: today, source: .daySheet)
        expect(store.dayResult(changed, on: today) == "2 times logged", "A period total does not invent a daily target")
        let limit = Habit(name: "Coffee", symbol: "cup.and.saucer", color: .brown, kind: .amount(unit: "cups", increment: 1), goal: 2, atMost: true, startsOn: yesterday)
        store.add(limit); await store.flush()
        store.addProgress(limit, value: 1, on: yesterday, source: .daySheet)
        expect(!store.dayResult(limit, on: yesterday).contains("today"), "A past limit result never says today")
        let origin = Date.now.addingTimeInterval(-3600)
        let quit = Habit(name: "Quit", symbol: "nosign", color: .gray, kind: .quit, quitSince: origin, createdAt: origin)
        store.add(quit); await store.flush()
        let slippedAt = Date.now
        let slipDay = store.today(now: slippedAt)
        store.slip(quit, on: slipDay, at: slippedAt)
        let slipID = store.entries(of: quit.id, on: slipDay).last!.id
        expect(abs(store.quitRuns(of: quit, now: slippedAt.addingTimeInterval(60)).current - 60) < 0.001, "Slip starts a new quit run")
        store.undoEntry(slipID)
        expect(store.quitRuns(of: quit, now: slippedAt.addingTimeInterval(60)).current >= 3660, "Undo slip restores the previous quit run")
        await store.flush()
        expect(store.problem == nil, "All changes reached storage")
        // Editing after travelling must validate against the entry's saved zone, not today's zone.
        let traveled = Habit(name: "Quit while travelling", symbol: "nosign", color: .gray, kind: .quit,
                             quitSince: Date(timeIntervalSince1970: 0), createdAt: Date(timeIntervalSince1970: 0))
        store.add(traveled); await store.flush()
        var tokyo = store.calendar
        tokyo.timeZone = TimeZone(identifier: "Asia/Tokyo")!
        let recordedAt = tokyo.date(from: DateComponents(year: 2000, month: 1, day: 3, hour: 0, minute: 30))!
        let recordedDay = LocalDay(recordedAt, calendar: tokyo)
        let foreign = Entry(habitID: traveled.id, day: recordedDay, value: 1, createdAt: recordedAt,
                            timeZone: "Asia/Tokyo", source: .daySheet)
        do {
            try await persistence.repository.addEntry(entry: foreign.record)
            await store.load()
            store.editEntry(foreign.id, value: 1, at: recordedAt.addingTimeInterval(60))
            await store.flush(); await loaded.load()
            let edited = loaded.entries(of: traveled.id, on: recordedDay).first
            expect(edited?.timeZone == foreign.timeZone && edited?.day == recordedDay
                   && abs((edited?.createdAt ?? .distantPast).timeIntervalSince(recordedAt.addingTimeInterval(60))) < 0.001,
                   "Slip time can be corrected after travelling without moving its day or zone")
        } catch { failures.append("Travel fixture could not be saved") }
        failures += await logTimes()
        let savedEnd = store.settings.dayEndHour
        store.settings.dayEndHour = 3
        var newYork = store.calendar
        newYork.timeZone = TimeZone(identifier: "America/New_York")!
        let springDay = LocalDay(year: 2026, month: 3, day: 8)
        let bounds = store.dayBounds(springDay, calendar: newYork)
        expect(LocalDay(bounds.upperBound.addingTimeInterval(-3 * 3600), calendar: newYork) == springDay
               && LocalDay(bounds.upperBound.addingTimeInterval(1 - 3 * 3600), calendar: newYork) == springDay.adding(days: 1),
               "Past slip picker ends at the tracking-day boundary across daylight saving")
        store.settings.dayEndHour = savedEnd
        return failures
    }

    /// The time of a log (7 Oct 2026 redesign; U19, D7): Add passes the chosen time, which stays inside the chosen
    /// day and never later than now; an edit changes the time only within the log's own day; one check per add; old
    /// multi-check logs keep working; the edited time survives a reload and a backup restored on another phone.
    static func logTimes() async -> [String] {
        var failures: [String] = []
        func expect(_ condition: Bool, _ name: String) { if !condition { failures.append(name) } }
        func near(_ a: Date?, _ b: Date) -> Bool { a.map { abs($0.timeIntervalSince(b)) < 0.001 } ?? false }
        let persistence = Persistence.inMemory()
        let store = HabitStore(repository: persistence.repository)
        await store.load()
        let c = store.calendar
        let now = Date.now
        store.clock = { now }
        let today = store.today()
        let yesterday = today.adding(days: -1, calendar: c)
        let before = today.adding(days: -3, calendar: c)
        let water = Habit(name: "Water", symbol: "drop", color: .blue, kind: .amount(unit: "glasses", increment: 1), goal: 8,
                          startsOn: before)
        store.add(water); await store.flush()
        let bounds = store.dayBounds(yesterday)
        let evening = c.date(bySettingHour: 21, minute: 40, second: 0, of: yesterday.date(calendar: c))!
        store.addProgress(water, value: 2, on: yesterday, at: evening, source: .manual)
        let past = store.entries(of: water.id, on: yesterday).last
        expect(past?.day == yesterday && near(past?.createdAt, evening), "A past day's log keeps the chosen day and time")
        store.addProgress(water, value: 1, on: yesterday, source: .daySheet)
        let quick = store.entries(of: water.id, on: yesterday).last
        expect(quick.map { bounds.contains($0.createdAt) } == true, "A past day's quick log is stamped inside that day, not today")
        store.addProgress(water, value: 1, on: today, at: now.addingTimeInterval(3600), source: .manual)
        let future = store.entries(of: water.id, on: today).last
        expect(future.map { $0.createdAt <= now && $0.day == today } == true, "A log is never stamped later than now")
        store.addProgress(water, value: 1, on: yesterday, at: bounds.lowerBound.addingTimeInterval(-7200), source: .manual)
        let early = store.entries(of: water.id, on: yesterday).last
        expect(early?.day == yesterday && near(early?.createdAt, bounds.lowerBound), "A time before the day is pulled to its start, never another day")
        store.addProgress(water, value: 1, on: today.adding(days: 1, calendar: c), at: now, source: .manual)
        expect(store.entries(of: water.id, on: today.adding(days: 1, calendar: c)).isEmpty, "No log on a future day")

        // Same-day time edits for every log, keeping its record.
        guard let first = past else { return failures + ["No past log to edit"] }
        let morning = c.date(bySettingHour: 8, minute: 5, second: 0, of: yesterday.date(calendar: c))!
        store.editEntry(first.id, value: 3, at: morning)
        let edited = store.entries(of: water.id, on: yesterday).first { $0.id == first.id }
        expect(edited?.value == 3 && near(edited?.createdAt, morning) && edited?.day == yesterday && edited?.source == .manual
               && edited?.timeZone == first.timeZone, "An amount log's time changes within its day, keeping ID, day, source and zone")
        store.editEntry(first.id, value: 3, at: c.date(byAdding: .day, value: -1, to: morning)!)
        expect(near(store.entries(of: water.id, on: yesterday).first { $0.id == first.id }?.createdAt, morning),
               "A time on another day is refused, never moving the log")
        store.editEntry(first.id, value: 4, at: now.addingTimeInterval(600))
        expect(store.entries(of: water.id, on: yesterday).first { $0.id == first.id }?.value == 3, "A future time is refused")
        expect(store.entries(of: water.id, on: today).allSatisfy { $0.id != first.id }, "An edit never moves a log into today")

        let read = Habit(name: "Read", symbol: "book", color: .orange, kind: .duration, goal: 20, startsOn: before)
        store.add(read); await store.flush()
        let finished = c.date(bySettingHour: 13, minute: 30, second: 0, of: yesterday.date(calendar: c))!
        store.addProgress(read, value: 15.5, on: yesterday, at: finished, source: .manual)
        if let session = store.entries(of: read.id, on: yesterday).last {
            store.editEntry(session.id, value: 3, at: finished.addingTimeInterval(-1800))
            let changed = store.entries(of: read.id, on: yesterday).last
            expect(changed?.value == 3 && near(changed?.createdAt, finished.addingTimeInterval(-1800)), "A session's time and length change together")
        } else { failures.append("Time log not added") }

        // One check per add; an old log of several checks still corrects.
        let stretch = Habit(name: "Stretch", symbol: "figure.flexibility", color: .purple, kind: .check, goal: 3, startsOn: before)
        store.add(stretch); await store.flush()
        store.addProgress(stretch, value: 1, on: yesterday, at: evening, source: .manual)
        expect(store.entries(of: stretch.id, on: yesterday).map(\.value) == [1], "Add a check adds one check")
        store.addProgress(stretch, value: 2, on: yesterday, at: morning, source: .manual)
        if let old = store.entries(of: stretch.id, on: yesterday).last {
            store.editEntry(old.id, value: 3, at: morning.addingTimeInterval(60))
            expect(store.entries(of: stretch.id, on: yesterday).last?.value == 3, "An older multi-check log still corrects")
        }
        let vitamins = Habit(name: "Vitamins", symbol: "pills", color: .green, kind: .check, goal: 1, startsOn: before)
        store.add(vitamins); await store.flush()
        store.setDayDone(true, of: vitamins, on: yesterday, at: evening, source: .manual)
        expect(near(store.entries(of: vitamins.id, on: yesterday).last?.createdAt, evening), "Mark a day done records the chosen time")
        let desk = Habit(name: "Desk", symbol: "lamp.desk", color: .teal, kind: .checklist,
                         steps: [Step(name: "Papers"), Step(name: "Pens")], startsOn: before)
        store.add(desk); await store.flush()
        store.toggleStep(desk.steps[0], of: desk, on: yesterday, at: evening, source: .manual)
        expect(near(store.entries(of: desk.id, on: yesterday).last?.createdAt, evening), "Tick steps records the chosen time")

        // The same clock time on another day, with a 3 AM day start (1:30 AM belongs to the next calendar date).
        let savedEnd = store.settings.dayEndHour
        store.settings.dayEndHour = 3
        let night = c.date(bySettingHour: 1, minute: 30, second: 0, of: now)!
        let moved = store.sameClockTime(as: night, on: before)
        expect(store.dayBounds(before).contains(moved) && c.component(.hour, from: moved) == 1, "1:30 AM on another day stays in that tracking day")
        store.settings.dayEndHour = savedEnd

        // Reload and a backup restored on an empty phone carry the edited time (D4, D5).
        await store.flush()
        let reloaded = HabitStore(repository: persistence.repository)
        await reloaded.load()
        expect(near(reloaded.entries(of: water.id, on: yesterday).first { $0.id == first.id }?.createdAt, morning), "An edited time survives a reload")
        do {
            let file = try await store.backupFile()
            defer { try? FileManager.default.removeItem(at: file.deletingLastPathComponent()) }
            let target = HabitStore(repository: Persistence.inMemory().repository)
            await target.load()
            _ = try await target.restore(from: file)
            let restored = target.entries(of: water.id, on: yesterday).first { $0.id == first.id }
            expect(restored?.day == yesterday && near(restored?.createdAt, morning) && restored?.value == 3,
                   "An edited time survives a backup restored on another phone")
        } catch { failures.append("Backup of edited times failed: \(error)") }
        expect(store.problem == nil, "Log times reached storage")
        return failures
    }
}

#endif
