import Foundation

/// The numbers behind Progress and a habit's page (Build Plan #60; report "Progress and Statistics — What People
/// Want", 29 Sep). Every number is counted on the habit's own rhythm (Feature Ledger C043): a day it was planned counts
/// once, and a week, month or year goal once for its week, month or year. Skipped, paused and not-its-days are neutral
/// (C016, C256). An unfinished today, or a week still going, never counts against, the same rule as the streak.
///
/// Built once per change (`HabitStore.revision`) and kept, never worked out on a redraw (Design Rules: Speed): it
/// reads the entries once into an index by habit and day.
struct HabitStats {
    /// Done out of planned: days, or weeks, months or years for a period goal.
    struct Tally: Equatable {
        var done = 0
        var planned = 0
        var rate: Double? { planned == 0 ? nil : Double(done) / Double(planned) }
        static func + (a: Tally, b: Tally) -> Tally { Tally(done: a.done + b.done, planned: a.planned + b.planned) }
    }

    let store: HabitStore
    let today: LocalDay
    /// Per habit and day: the total logged (checklist steps aside), and the steps ticked.
    private let sums: [UUID: [LocalDay: Double]]
    private let steps: [UUID: [LocalDay: Set<UUID>]]

    init(store: HabitStore) {
        self.store = store
        today = store.today()
        var sums: [UUID: [LocalDay: Double]] = [:]
        var steps: [UUID: [LocalDay: Set<UUID>]] = [:]
        for entry in store.entries {
            if let step = entry.stepID {
                steps[entry.habitID, default: [:]][entry.day, default: []].insert(step)
            } else {
                sums[entry.habitID, default: [:]][entry.day, default: 0] += entry.value
            }
        }
        self.sums = sums
        self.steps = steps
    }

    private var calendar: Calendar { store.calendar }

    /// Habits with progress: not tasks, not quit habits, not archived (archived ones keep their history on their page).
    var tracked: [Habit] { store.habits.filter { !$0.archived && $0.kind != .quit && $0.kind != .task } }
    var quitting: [Habit] { store.habits.filter { !$0.archived && $0.kind == .quit } }

    // MARK: One day

    func logged(_ habit: Habit, on day: LocalDay) -> Double { sums[habit.id]?[day] ?? 0 }

    /// What counts toward the day's goal: the steps ticked for a checklist, otherwise the day's total.
    func dayProgress(_ rule: Habit, on day: LocalDay) -> Double {
        if rule.kind == .checklist {
            let ticked = steps[rule.id]?[day] ?? []
            return Double(rule.steps.filter { ticked.contains($0.id) }.count)
        }
        return logged(rule, on: day)
    }

    func dayGoal(_ rule: Habit) -> Double { rule.kind == .checklist ? Double(max(rule.steps.count, 1)) : rule.goal }

    func isDayMet(_ rule: Habit, on day: LocalDay) -> Bool {
        let progress = dayProgress(rule, on: day)
        return rule.atMost ? progress <= dayGoal(rule) : progress >= dayGoal(rule)
    }

    /// How much of the day's goal was reached, 0...1; nil when the day isn't one of its days. For a habit's year grid.
    func dayShare(_ habit: Habit, on day: LocalDay) -> Double? {
        guard day <= today, day >= store.startDay(of: habit), store.isDue(habit, on: day) else { return nil }
        let rule = store.rule(habit, on: day)
        if rule.atMost { return isDayMet(rule, on: day) ? 1 : 0 }
        if !rule.frequency.isDayBased {
            // A week or month goal has no day goal: a day with something logged is a full square.
            return logged(rule, on: day) > 0 ? 1 : 0
        }
        return min(1, dayProgress(rule, on: day) / max(dayGoal(rule), 1))
    }

    /// The share of the day's planned habits that were done: day-by-day habits only. A weekly or monthly goal isn't a
    /// day's work (users show it dragging the daily figure down), and an "N days a week" habit counts on a day it was done.
    func dayTally(on day: LocalDay) -> Tally {
        var tally = Tally()
        for habit in tracked where store.startDay(of: habit) <= day {
            let rule = store.rule(habit, on: day)
            if rule.frequency.isFlexible {
                if store.isDue(habit, on: day) && isDayMet(rule, on: day) { tally.done += 1; tally.planned += 1 }
                continue
            }
            guard rule.frequency.isDayBased, store.isDue(habit, on: day) else { continue }
            tally.planned += 1
            if isDayMet(rule, on: day) { tally.done += 1 }
        }
        return tally
    }

    // MARK: A stretch of days

    /// Done out of planned for one habit over `range`, on its own rhythm.
    func tally(_ habit: Habit, in range: ClosedRange<LocalDay>) -> Tally {
        let start = store.startDay(of: habit)
        let first = max(range.lowerBound, start)
        let last = min(range.upperBound, today, habit.endsOn ?? range.upperBound)
        guard first <= last else { return Tally() }
        var tally = Tally()
        var periods = Set<LocalDay>()
        var day = first
        while day <= last {
            let rule = store.rule(habit, on: day)
            if let period = store.periodRange(rule, containing: day), period.lowerBound != period.upperBound {
                // Once per week, month or year. A period that began before the habit, or still going, counts only if met.
                if periods.insert(period.lowerBound).inserted {
                    if isPeriodMet(rule, in: period) {
                        tally.done += 1; tally.planned += 1
                    } else if period.upperBound < today, period.lowerBound >= start, !store.hasPause(habit, in: period) {
                        tally.planned += 1
                    }
                }
            } else if store.isDue(habit, on: day) {
                if isDayMet(rule, on: day) {
                    tally.done += 1; tally.planned += 1
                } else if day < today {
                    tally.planned += 1
                }
            }
            day = day.adding(days: 1, calendar: calendar)
        }
        return tally
    }

    /// Whether a week, month or year goal was met: ticks for "3 times a week", a total for "20 km a month", days that
    /// met the day's goal for "on 3 days a week".
    private func isPeriodMet(_ rule: Habit, in period: ClosedRange<LocalDay>) -> Bool {
        let days = Self.days(in: period, calendar: calendar).filter { $0 <= today }
        if case .flexible(_, let needed) = rule.frequency {
            return days.filter { isDayMet(rule, on: $0) }.count >= needed
        }
        if store.isTotal(rule) {
            let total = days.reduce(0) { $0 + logged(rule, on: $1) }
            return rule.atMost ? total <= rule.goal : total >= rule.goal
        }
        let needed: Double = switch rule.frequency {
        case .perWeek(let n), .perMonth(let n), .perYear(let n): Double(n)
        default: 1
        }
        if rule.kind == .check { return days.reduce(0) { $0 + logged(rule, on: $1) } >= needed }
        return Double(days.filter { isDayMet(rule, on: $0) }.count) >= needed
    }

    /// Everything logged in `range` in the habit's current unit: times, an amount or minutes. A unit that changed
    /// can't be converted, so days logged in an older unit are left out (spec §9).
    func total(_ habit: Habit, in range: ClosedRange<LocalDay>) -> Double {
        let unit = HabitCopy.unit(of: habit)
        return (sums[habit.id] ?? [:]).reduce(0) { sum, pair in
            guard range.contains(pair.key), HabitCopy.unit(of: store.rule(habit, on: pair.key)) == unit else { return sum }
            return sum + pair.value
        }
    }

    /// Days the habit's goal for the day was met in `range` (for "Done on 143 days").
    func daysDone(_ habit: Habit, in range: ClosedRange<LocalDay>) -> Int {
        let last = min(range.upperBound, today)
        guard range.lowerBound <= last else { return 0 }
        return Self.days(in: range.lowerBound...last, calendar: calendar).filter { day in
            store.isDue(habit, on: day) && isDayMet(store.rule(habit, on: day), on: day) && day >= store.startDay(of: habit)
        }.count
    }

    /// The first day of the habit's current unit, when an edit changed it (the totals start there).
    func unitSince(_ habit: Habit) -> LocalDay? {
        let unit = HabitCopy.unit(of: habit)
        guard let last = (store.rules[habit.id] ?? []).last(where: { rule in
            var old = habit
            rule.apply(to: &old)
            return HabitCopy.unit(of: old) != unit
        }) else { return nil }
        return last.until.adding(days: 1, calendar: calendar)
    }

    /// Slips of a quit habit whose moment falls in `range`.
    func slips(_ habit: Habit, in range: ClosedRange<LocalDay>) -> Int {
        store.entries.filter { $0.habitID == habit.id && range.contains(LocalDay($0.createdAt, calendar: calendar)) }.count
    }

    static func days(in range: ClosedRange<LocalDay>, calendar: Calendar) -> [LocalDay] {
        var days: [LocalDay] = []
        var day = range.lowerBound
        while day <= range.upperBound {
            days.append(day)
            day = day.adding(days: 1, calendar: calendar)
        }
        return days
    }
}

/// Week, month or year on Progress, stepped back with ‹ ›.
enum StatsPeriod: String, CaseIterable, Identifiable {
    case week, month, year
    var id: Self { self }
    var title: String { rawValue.capitalized }

    /// The period `offset` steps from the one containing `today` (0 = this one, -1 = the one before).
    func range(offset: Int, today: LocalDay, store: HabitStore) -> ClosedRange<LocalDay> {
        let calendar = store.calendar
        let component: Calendar.Component = switch self { case .week: .weekOfYear; case .month: .month; case .year: .year }
        let kind: HabitStore.PeriodKind = switch self { case .week: .week; case .month: .month; case .year: .year }
        let shifted = calendar.date(byAdding: component, value: offset, to: today.date(calendar: calendar))!
        return store.period(kind, containing: LocalDay(shifted, calendar: calendar))
    }

    /// "This week", "Last week", "15–21 Sep"; "This month", "August", "August 2025"; "This year", "2025".
    func label(_ range: ClosedRange<LocalDay>, offset: Int, today: LocalDay, calendar: Calendar) -> String {
        let start = range.lowerBound.date(calendar: calendar)
        switch self {
        case .week:
            if offset == 0 { return "This week" }
            if offset == -1 { return "Last week" }
            let end = range.upperBound.date(calendar: calendar)
            return (start..<end).formatted(.interval.day().month(.abbreviated))
        case .month:
            if offset == 0 { return "This month" }
            return range.lowerBound.year == today.year ? start.formatted(.dateTime.month(.wide))
                : start.formatted(.dateTime.month(.wide).year())
        case .year:
            return offset == 0 ? "This year" : String(range.lowerBound.year)
        }
    }

    /// "last week", "last month", "last year": the one before, for the comparison line.
    var previousName: String { "last " + rawValue }
    /// What a period goal's tally counts in: "weeks" for a weekly goal.
    static func noun(_ rule: Habit, _ count: Int) -> String {
        let word: String = switch rule.frequency {
        case .perWeek: "week"
        case .perMonth: "month"
        case .perYear: "year"
        case .flexible(let period, _) where period != .day: period.noun
        default: "day"
        }
        return count == 1 ? word : word + "s"
    }
}
