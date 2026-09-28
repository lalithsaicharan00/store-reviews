#if DEBUG
import Foundation

/// Deterministic integration checks, exercised through the simulator against a real in-memory repository.
enum ScheduleCheck {
    static func run() async -> [String] {
        var failures: [String] = []
        func expect(_ result: Bool, _ name: String) { if !result { failures.append(name) } }
        let persistence = Persistence.inMemory()
        let store = HabitStore(repository: persistence.repository)
        await store.load()
        store.settings.weekStart = 2
        let start = LocalDay(year: 2024, month: 1, day: 1) // Monday
        let cal = store.calendar
        func date(_ y: Int, _ m: Int, _ d: Int) -> LocalDay { LocalDay(year: y, month: m, day: d) }
        var rule = CalendarSchedule(unit: .day, interval: 3)
        expect(rule.matches(start, start: start, calendar: cal), "Start is included")
        expect(rule.matches(start.adding(days: 3), start: start, calendar: cal), "Every 3 days")
        expect(!rule.matches(start.adding(days: 2), start: start, calendar: cal), "Interval off day")
        expect(!rule.matches(start.adding(days: -3), start: start, calendar: cal), "No occurrence before Starts")
        rule = CalendarSchedule(unit: .week, interval: 2, weekdays: [2, 5], anchorWeekStart: 2)
        expect(rule.matches(date(2024, 1, 4), start: start, calendar: cal), "Chosen Thursday")
        expect(!rule.matches(date(2024, 1, 8), start: start, calendar: cal), "Skip alternate week")
        expect(rule.matches(date(2024, 1, 15), start: start, calendar: cal), "Second Monday")
        var changedWeek = cal; changedWeek.firstWeekday = 1
        for n in 0...35 {
            let day = start.adding(days: n)
            expect(rule.matches(day, start: start, calendar: cal) == rule.matches(day, start: start, calendar: changedWeek), "Fixed weekly anchor survives preference change \(n)")
        }
        rule = CalendarSchedule(unit: .month, interval: 1, dates: [30, 31])
        expect(rule.matches(date(2024, 2, 29), start: start, calendar: cal), "Short month clamps dates to one last day")
        rule.useLastDay = false
        expect(!rule.matches(date(2024, 2, 29), start: start, calendar: cal), "Skip missing dates")
        rule.pattern = .last
        expect(rule.matches(date(2024, 2, 29), start: start, calendar: cal), "Explicit last day")
        rule.pattern = .weekday; rule.ordinal = 1; rule.weekday = 7
        expect(rule.matches(date(2024, 2, 3), start: start, calendar: cal), "First Saturday")
        expect(!rule.matches(date(2024, 2, 10), start: start, calendar: cal), "Not second Saturday")
        rule.ordinal = -1
        expect(rule.matches(date(2024, 2, 24), start: start, calendar: cal), "Last Saturday")
        rule.ordinal = 5
        expect(rule.next(from: date(2024, 2, 1), start: start, calendar: cal) == date(2024, 3, 30), "Missing fifth weekday is skipped")
        rule = CalendarSchedule(unit: .month, interval: 3, dates: [1])
        expect(rule.matches(date(2024, 4, 1), start: start, calendar: cal), "Every three months")
        expect(!rule.matches(date(2024, 2, 1), start: start, calendar: cal), "Monthly interval excludes intervening month")
        rule = CalendarSchedule(unit: .year, interval: 1, month: 2, day: 29)
        expect(rule.matches(date(2025, 2, 28), start: start, calendar: cal), "Leap-day fallback")
        rule.useLastDay = false
        expect(!rule.matches(date(2025, 2, 28), start: start, calendar: cal), "Leap-day skip")
        expect(rule.next(from: date(2025, 1, 1), start: start, calendar: cal) == date(2028, 2, 29), "Next leap date")
        expect(rule.next(from: date(2025, 1, 1), start: start, end: date(2026, 1, 1), calendar: cal) == nil, "End date respected")
        var pacific = cal; pacific.timeZone = TimeZone(identifier: "America/Los_Angeles")!
        var india = cal; india.timeZone = TimeZone(identifier: "Asia/Kolkata")!
        rule = CalendarSchedule(unit: .day, interval: 3)
        for d in 8...14 {
            let day = date(2024, 3, d)
            expect(rule.matches(day, start: start, calendar: pacific) == rule.matches(day, start: start, calendar: india), "Local dates survive DST/travel \(d)")
        }
        let frequencies: [Frequency] = [.daily, .weekdays([2,4,6]), .everyNDays(3), .everyNWeeks(2), .monthDates([31]), .perWeek(3), .perMonth(4), .perYear(12), .calendar(rule), .flexible(.week, 4), .flexible(.month, 5), .flexible(.year, 12), .afterCompletion(6, .week)]
        for frequency in frequencies {
            expect(Frequency(storageKey: frequency.storageKey) == frequency, "Frequency round trip \(frequency)")
        }
        expect(Frequency(storageKey: "") == nil, "Reject empty frequency")
        expect(Frequency(storageKey: "v2:bad") == nil, "Reject malformed new frequency")
        var habit = Habit(name: "Read", symbol: "book", color: .blue, kind: .duration, goal: 30, frequency: .flexible(.week, 2), startsOn: start)
        store.add(habit); await store.flush()
        store.addProgress(habit, value: 15, on: start); await store.flush()
        expect(store.flexibleProgress(habit, on: start) == 0, "Partial quantity is not a qualifying day")
        store.addProgress(habit, value: 15, on: start); await store.flush()
        store.addProgress(habit, value: 30, on: start); await store.flush()
        expect(store.flexibleProgress(habit, on: start) == 1, "Two daily goals on same date count once")
        expect(store.progress(of: habit, on: start) == 60, "Daily quantity is preserved")
        expect(store.goal(of: habit) == 30, "Daily goal is not replaced by quota")
        expect(!store.isPeriodMet(habit, on: start), "One day is below two-day quota")
        store.addProgress(habit, value: 30, on: start.adding(days: 2)); await store.flush()
        expect(store.isPeriodMet(habit, on: start), "Two distinct days meet quota")
        expect(store.streak(of: habit, asOf: start.adding(days: 7)) == 1, "An open next week does not break streak")
        store.addProgress(habit, value: 30, on: start.adding(days: 3)); await store.flush()
        expect(store.flexibleProgress(habit, on: start) == 3, "Extra days remain loggable")
        expect(store.isSatisfied(habit, on: start.adding(days: 4)), "Quota completion stops remaining count and reminders")
        expect(!store.isDone(habit, on: start.adding(days: 4)), "Extra-day action remains available")
        expect(store.flexibleProgress(habit, on: start.adding(days: 7)) == 0, "Weekly quota resets")
        store.undoProgress(habit, on: start.adding(days: 4)); await store.flush()
        expect(store.flexibleProgress(habit, on: start) == 3, "Undo on empty day cannot remove another day")
        let reload = HabitStore(repository: persistence.repository); await reload.load()
        expect(reload.habits.first?.frequency == habit.frequency, "Repository preserves distinct-day rule")
        expect(reload.entries.count == store.entries.count, "Repository preserves logs")
        habit = Habit(name: "Sessions", symbol: "star", color: .blue, kind: .check, goal: 3, frequency: .perWeek(3), startsOn: start)
        store.add(habit); await store.flush()
        for _ in 0..<2 { store.toggleCheck(habit, on: start); await store.flush() }
        expect(store.progress(of: habit, on: start) == 2, "Legacy aggregate checks count same-day repetitions")
        let legacy = Habit(record: habit.record(position: 0), steps: [], reminders: [])!
        expect(legacy.frequency == .perWeek(3), "Legacy period semantics remain unchanged")
        var total = GoalDraft(period: .week, amount: "100", unit: "pages")
        total.apply(to: &habit, timed: false, check: false)
        expect(habit.frequency == .perWeek(1) && habit.goal == 100, "Aggregate amount applies one clock")
        total.period = .day; habit.frequency = .flexible(.week, 4)
        total.apply(to: &habit, timed: false, check: false)
        expect(habit.frequency == .flexible(.week, 4), "Daily goal keeps flexible schedule")
        let countHabit = Habit(name: "Pages", symbol: "book", color: .blue, kind: .amount(unit: "pages", increment: 1), goal: 5, frequency: .flexible(.year, 2), startsOn: start)
        store.add(countHabit); await store.flush()
        store.addProgress(countHabit, value: 4, on: start); await store.flush()
        store.addProgress(countHabit, value: 1, on: start); await store.flush()
        expect(store.flexibleProgress(countHabit, on: start) == 1, "Amount-on-days counts only completed daily quantity")
        expect(store.flexibleProgress(countHabit, on: date(2025, 1, 1)) == 0, "Year quota resets")
        let sunday = date(2024, 1, 7)
        store.addProgress(countHabit, value: 5, on: sunday); await store.flush()
        var weeklyDays = countHabit; weeklyDays.frequency = .flexible(.week, 2)
        expect(store.flexibleProgress(weeklyDays, on: date(2024, 1, 8)) == 0, "Monday week start excludes Sunday")
        store.settings.weekStart = 1
        expect(store.flexibleProgress(weeklyDays, on: date(2024, 1, 8)) == 1, "Sunday week start includes Sunday")
        store.settings.weekStart = 2
        expect(store.streak(of: weeklyDays, asOf: date(2024, 1, 15)) == 0, "Closed empty week breaks quota streak")
        let checkDays = Habit(name: "Gym", symbol: "star", color: .blue, kind: .check, goal: 2, frequency: .flexible(.week, 3), startsOn: start)
        store.add(checkDays); await store.flush()
        store.toggleCheck(checkDays, on: start); await store.flush()
        expect(store.flexibleProgress(checkDays, on: start) == 0, "Check daily goal must be reached")
        store.toggleCheck(checkDays, on: start); await store.flush()
        expect(store.flexibleProgress(checkDays, on: start) == 1, "Two daily checks count one successful day")
        store.toggleCheck(checkDays, on: start); await store.flush()
        expect(store.flexibleProgress(checkDays, on: start) == 0, "Undo removes qualifying day")
        let task = Habit(name: "Filter", symbol: "star", color: .blue, kind: .task, frequency: .afterCompletion(6, .week), startsOn: start)
        store.add(task); await store.flush()
        store.toggleCheck(task, on: start.adding(days: 4)); await store.flush()
        expect(!store.isDue(task, on: start.adding(days: 42)), "Late completion shifts next task")
        expect(store.isDue(task, on: start.adding(days: 46)), "Six weeks after actual completion")
        store.toggleCheck(task, on: start.adding(days: 4)); await store.flush()
        expect(store.isDue(task, on: start.adding(days: 5)), "Undo completion restores outstanding task")
        let checklist = Habit(name: "Checklist", symbol: "star", color: .blue, kind: .checklist, frequency: .flexible(.month, 2), steps: [Step(name: "One"), Step(name: "Two")], startsOn: start)
        store.add(checklist); await store.flush()
        store.toggleStep(checklist.steps[0], of: checklist, on: start); await store.flush()
        expect(store.flexibleProgress(checklist, on: start) == 0, "Checklist partial is not a successful day")
        store.toggleStep(checklist.steps[1], of: checklist, on: start); await store.flush()
        expect(store.flexibleProgress(checklist, on: start) == 1, "Completed checklist counts one day")
        return failures
    }
}
#endif
