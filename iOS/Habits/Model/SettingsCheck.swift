#if DEBUG
import Core
import Foundation

/// Golden cases for ≡ → Day and Week (Build Plan #61; research "Ticking Off, Folding and Small Settings", §4–5), run in
/// the app against a real in-memory store with fixed moments in New York, where the clocks change on 8 March 2026
/// (2:00 → 3:00) and 1 November 2026 (2:00 → 1:00). `-settingscheck` shows "Settings: all checks passed" or what
/// differs; `TodayUITests.testSettingsChecks` reads it.
enum SettingsCheck {
    static func run() async -> [String] {
        var failures: [String] = []
        func expect(_ ok: Bool, _ name: String) { if !ok { failures.append(name) } }
        func same<T: Equatable>(_ got: T, _ want: T, _ name: String) { if got != want { failures.append("\(name): got \(got), want \(want)") } }

        // Every case on New York's clock, whatever the phone's own time zone.
        var ny = Calendar(identifier: .gregorian)
        ny.timeZone = TimeZone(identifier: "America/New_York")!

        func day(_ d: Int, _ m: Int, _ y: Int = 2026) -> LocalDay { LocalDay(year: y, month: m, day: d) }
        /// A wall-clock moment in New York; `later` picks the second 1:30 on the night the clocks go back.
        func at(_ d: Int, _ m: Int, _ hour: Int, _ minute: Int = 0, later: Bool = false) -> Date {
            let first = ny.date(from: DateComponents(year: 2026, month: m, day: d, hour: hour, minute: minute))!
            return later ? first.addingTimeInterval(3600) : first
        }
        func store() async -> (HabitStore, Persistence) {
            let persistence = Persistence.inMemory()
            let store = HabitStore(repository: persistence.repository)
            await store.load()
            store.fixedTimeZone = ny.timeZone
            return (store, persistence)
        }

        // D1: a day that starts at midnight.
        do {
            let (s, _) = await store()
            same(s.today(now: at(10, 6, 0, 30)), day(10, 6), "D1 00:30 is the same day")
            same(s.today(now: at(10, 6, 23, 59)), day(10, 6), "D1 23:59 is the same day")
        }

        // D2: a day that starts at 3 AM.
        do {
            let (s, _) = await store()
            s.setDayEnd(3); await s.flush()
            same(s.today(now: at(10, 6, 2, 59)), day(9, 6), "D2 2:59 counts for the day before")
            same(s.today(now: at(10, 6, 3, 0)), day(10, 6), "D2 3:00 starts the new day")
        }

        // D3: spring forward (8 Mar 2026, 2:00 → 3:00). With the day starting at 3 AM, 3:30 is the new day: the old
        // subtraction of three real hours landed on 7 March.
        do {
            let (s, _) = await store()
            s.setDayEnd(3); await s.flush()
            same(s.today(now: at(8, 3, 1, 30)), day(7, 3), "D3 1:30 before the change is still 7 March")
            same(s.today(now: at(8, 3, 3, 30)), day(8, 3), "D3 3:30 after the change is 8 March")
            same(s.today(now: at(8, 3, 4, 0)), day(8, 3), "D3 4:00 is 8 March")
        }

        // D4: fall back (1 Nov 2026, 2:00 → 1:00). Both 1:30s and 2:30 are before 3:00 on the clock: still 31 October.
        do {
            let (s, _) = await store()
            s.setDayEnd(3); await s.flush()
            same(s.today(now: at(1, 11, 1, 30)), day(31, 10), "D4 first 1:30 is 31 October")
            same(s.today(now: at(1, 11, 1, 30, later: true)), day(31, 10), "D4 second 1:30 is 31 October")
            same(s.today(now: at(1, 11, 2, 30)), day(31, 10), "D4 2:30 is 31 October (old: 1 November)")
            same(s.today(now: at(1, 11, 3, 0)), day(1, 11), "D4 3:00 starts 1 November")
        }

        // D5: the day start is saved, survives a reload, and Midnight removes it.
        do {
            let (s, persistence) = await store()
            s.setDayEnd(5); await s.flush()
            let again = HabitStore(repository: persistence.repository)
            await again.load()
            again.fixedTimeZone = ny.timeZone
            same(again.settings.dayEndHour, 5, "D5 reloaded day start")
            again.setDayEnd(0); await again.flush()
            let third = HabitStore(repository: persistence.repository)
            await third.load()
            same(third.settings.dayEndHour, 0, "D5 midnight after reload")
            s.setDayEnd(20); expect(s.settings.dayEndHour == 12, "D5 later than noon is kept at noon")
        }

        // W1: the week start moves the week; Automatic follows the iPhone and is saved as "nothing chosen".
        do {
            let (s, persistence) = await store()
            let friday = day(25, 9)
            s.setWeekStart(2); await s.flush()
            same(s.period(.week, containing: friday).lowerBound, day(21, 9), "W1 Monday week starts Mon 21")
            s.setWeekStart(1); await s.flush()
            same(s.period(.week, containing: friday).lowerBound, day(20, 9), "W1 Sunday week starts Sun 20")
            s.setWeekStart(7); await s.flush()
            same(s.period(.week, containing: friday).lowerBound, day(19, 9), "W1 Saturday week starts Sat 19")
            let again = HabitStore(repository: persistence.repository)
            await again.load()
            same(again.settings.weekStart, 7, "W1 reloaded week start")
            expect(again.settings.weekStartChosen, "W1 reloaded as chosen")
            again.setWeekStart(nil); await again.flush()
            same(again.settings.weekStart, Calendar.autoupdatingCurrent.firstWeekday, "W1 Automatic is the iPhone's")
            let third = HabitStore(repository: persistence.repository)
            await third.load()
            expect(!third.settings.weekStartChosen, "W1 Automatic after reload")
        }

        // W2: a weekly goal counts in the chosen weeks. Twice a week, ticked Sun 20 and Mon 21; on Fri 25 a Monday week
        // holds one tick and a Sunday week holds both.
        do {
            let (s, _) = await store()
            let fixed = at(25, 9, 12)
            s.clock = { fixed }
            let walk = Habit(name: "Walk", symbol: "figure.walk", color: .green, kind: .check, frequency: .perWeek(2), startsOn: day(1, 9))
            s.add(walk); await s.flush()
            s.toggleCheck(walk, on: day(20, 9)); s.toggleCheck(walk, on: day(21, 9)); await s.flush()
            s.setWeekStart(2); await s.flush()
            same(s.progress(of: walk, on: day(25, 9)), 1, "W2 Monday week: one this week")
            s.setWeekStart(1); await s.flush()
            same(s.progress(of: walk, on: day(25, 9)), 2, "W2 Sunday week: two this week")
            expect(s.isDone(walk, on: day(25, 9)), "W2 Sunday week: goal met")
        }

        // W3: changing either setting moves the data version, so Progress works its numbers out again.
        do {
            let (s, _) = await store()
            let before = s.dataVersion
            s.setDayEnd(2); await s.flush()
            expect(s.dataVersion != before, "W3 day start moves the data version")
            let middle = s.dataVersion
            s.setWeekStart(4); await s.flush()
            expect(s.dataVersion != middle, "W3 week start moves the data version")
        }
        return failures
    }
}
#endif
