import Foundation

// Progress, Phase 2 (Build Plan #60f; report §7.2 Year, §8.4–§8.6, §10, §16.6, §16.8).

/// A year of days as round dots: weeks run left to right in columns, weekdays top to bottom (report §7.2, §13.3).
/// Each list holds cell numbers (column × 7 + row) for one shade, so a grid draws as four shapes, not 365 views.
struct YearDots: Hashable, Sendable {
    var full: [Int] = []
    var high: [Int] = []
    var low: [Int] = []
    /// Not done (or a slip): an empty ring.
    var ring: [Int] = []
    /// Columns in the grid (53 or 54).
    var columns = 0
    /// The column each month starts in, for the month letters and for tapping a month.
    var months: [YearMonth] = []
    var isEmpty: Bool { full.isEmpty && high.isEmpty && low.isEmpty && ring.isEmpty }
}

struct YearMonth: Hashable, Sendable, Identifiable {
    let month: Int
    let column: Int
    let first: LocalDay
    var id: Int { month }
}

/// A quit habit's numbers for a range (report §10, §16.8).
struct QuitStats: Hashable {
    let slips: [Date]
    let cleanDays: Int
    /// Days in the range that count: from its start, up to today, not paused.
    let days: Int
    let longestRun: TimeInterval
    /// The mean of runs that ended in a slip; nil with none.
    let averageRun: TimeInterval?
    let marks: [ProgressMark]
}

/// One weekday's share of done (or its average amount) in a range (report §8.6).
struct WeekdayStat: Hashable, Identifiable {
    let weekday: Int
    let name: String
    let value: Double
    let days: Int
    var id: Int { weekday }
}

/// A point on the 30-day rate line (report §16.6).
struct RatePoint: Hashable, Identifiable {
    let date: Date
    let percent: Double
    var id: Date { date }
}

extension HabitStore {
    // MARK: Year dots

    /// The dots for a year: the grid starts on the week-start day on or before 1 January.
    func yearDots(_ year: ClosedRange<LocalDay>, shade: (LocalDay) -> ProgressMark?) -> YearDots {
        let first = period(.week, containing: year.lowerBound).lowerBound
        var dots = YearDots()
        var index = 0
        var day = first
        var lastMonth = 0
        while day <= year.upperBound {
            if day >= year.lowerBound {
                if day.month != lastMonth {
                    dots.months.append(YearMonth(month: day.month, column: index / 7, first: LocalDay(year: day.year, month: day.month, day: 1)))
                    lastMonth = day.month
                }
                if let mark = shade(day) {
                    switch mark.mark {
                    case .done: dots.full.append(index)
                    case .some: if mark.fraction >= 0.5 { dots.high.append(index) } else { dots.low.append(index) }
                    case .missed: dots.ring.append(index)
                    default: break
                    }
                }
            }
            index += 1
            day = day.adding(days: 1, calendar: calendar)
        }
        dots.columns = (index + 6) / 7
        return dots
    }

    /// The overview's year: each day's share of what was planned, in ink (report §7.2). Days with nothing planned,
    /// and later days, have no dot.
    func overviewYearDots(_ cells: [ProgressDay], year: ClosedRange<LocalDay>) -> YearDots {
        let byDay = Dictionary(uniqueKeysWithValues: cells.map { ($0.day, $0) })
        return yearDots(year) { day in
            guard let cell = byDay[day], !cell.isFuture, cell.score.planned > 0 else { return nil }
            let fraction = cell.score.fraction
            if cell.score.isFull { return ProgressMark(day: day, mark: .done, fraction: 1, over: false) }
            if fraction > 0 { return ProgressMark(day: day, mark: .some, fraction: fraction, over: false) }
            return cell.isToday ? nil : ProgressMark(day: day, mark: .missed, fraction: 0, over: false)
        }
    }

    // MARK: Quit habits

    /// The first day a quit habit counts from: when it was made, or an earlier "Started".
    func quitStartDay(of habit: Habit) -> LocalDay {
        today(now: min(habit.createdAt, habit.quitSince ?? habit.createdAt))
    }

    /// Slips, clean days and runs in a range (report §10.3, §16.8). A clean day is a day from the start up to today
    /// with no slip and not paused.
    func quitStats(of habit: Habit, in range: ClosedRange<LocalDay>, now: Date? = nil) -> QuitStats {
        let now = now ?? clock()
        let today = today(now: now)
        let start = quitStartDay(of: habit)
        let allSlips = slips(of: habit, now: now)
        let slipDays = Set(allSlips.map { self.today(now: $0) })
        var clean = 0, counted = 0
        var marks: [ProgressMark] = []
        for day in days(in: range) {
            let mark: DayMark
            if day < start { mark = .before }
            else if day > today { mark = .notItsDay }
            else if isPaused(habit, on: day) { mark = .paused }
            else if slipDays.contains(day) { mark = .missed; counted += 1 }
            else { mark = .done; clean += 1; counted += 1 }
            marks.append(ProgressMark(day: day, mark: mark, fraction: mark == .done ? 1 : 0, over: false))
        }
        let history = quitHistory(of: habit, now: now)
        let lower = dayStartMoment(range.lowerBound), upper = dayStartMoment(range.upperBound.adding(days: 1, calendar: calendar))
        // A run's part inside the range.
        let inRange = history.compactMap { run -> TimeInterval? in
            let from = max(run.start, lower), to = min(run.end ?? now, upper)
            return to > from ? to.timeIntervalSince(from) : nil
        }
        let ended = history.filter { $0.endedBy == .slip }
        return QuitStats(
            slips: allSlips.filter { range.contains(self.today(now: $0)) },
            cleanDays: clean, days: counted,
            longestRun: inRange.max() ?? 0,
            averageRun: ended.isEmpty ? nil : ended.map { $0.length(now: now) }.reduce(0, +) / Double(ended.count),
            marks: marks)
    }

    /// The moment a day begins, honouring the day end (the same as `dayStart`, which is private to the store file).
    func dayStartMoment(_ day: LocalDay) -> Date {
        calendar.startOfDay(for: day.date(calendar: calendar)).addingTimeInterval(Double(settings.dayEndHour) * 3600)
    }

    /// Milestones for a quit run: 1, 3, 7, 14, 30, 60, 90 and 180 days, then each year (report §10.3).
    static func quitMilestones(upTo days: Int) -> [Int] {
        var ladder = [1, 3, 7, 14, 30, 60, 90, 180]
        var year = 365
        while year <= max(days, 365) + 365 { ladder.append(year); year += 365 }
        return ladder
    }

    /// "Next: 14 days · in 2 days" for the run going on now; nil while paused.
    func nextMilestone(of habit: Habit, now: Date? = nil) -> String? {
        let now = now ?? clock()
        guard let run = quitHistory(of: habit, now: now).last, run.endedBy == .ongoing else { return nil }
        let days = Int(run.length(now: now) / 86400)
        guard let next = Self.quitMilestones(upTo: days).first(where: { $0 > days }) else { return nil }
        let left = next - days
        return "Next: \(Self.milestoneName(next)) · in \(left == 1 ? "1 day" : "\(left) days")"
    }

    /// "Reached: 1 day (3 Jan) · 7 days (9 Jan)" for the run going on now.
    func reachedMilestones(of habit: Habit, now: Date? = nil) -> String? {
        let now = now ?? clock()
        guard let run = quitHistory(of: habit, now: now).last, run.endedBy == .ongoing else { return nil }
        let days = Int(run.length(now: now) / 86400)
        let reached = Self.quitMilestones(upTo: days).filter { $0 <= days }
        guard !reached.isEmpty else { return nil }
        return "Reached: " + reached.map { n in
            let on = run.start.addingTimeInterval(Double(n) * 86400).formatted(.dateTime.day().month(.abbreviated))
            return "\(Self.milestoneName(n)) (\(on))"
        }.joined(separator: " · ")
    }

    static func milestoneName(_ days: Int) -> String {
        if days >= 365 && days % 365 == 0 { return days == 365 ? "1 year" : "\(days / 365) years" }
        return days == 1 ? "1 day" : "\(days) days"
    }

    /// "187 clean days since 2 Jan 2026 · 5 slips": a total a slip can't take away (report §10.3).
    func quitTotalLine(of habit: Habit, now: Date? = nil) -> String {
        let now = now ?? clock()
        let start = quitStartDay(of: habit)
        let stats = quitStats(of: habit, in: start...today(now: now), now: now)
        let since = start.date(calendar: calendar).formatted(.dateTime.day().month(.abbreviated).year())
        let slips = stats.slips.count
        return "\(stats.cleanDays == 1 ? "1 clean day" : "\(stats.cleanDays) clean days") since \(since) · \(slips == 1 ? "1 slip" : "\(slips) slips")"
    }

    // MARK: Runs (report §8.5)

    /// "40 days · 3 Mar – 11 Apr 2026", in the streak's own unit.
    func runText(_ run: Run, unit: StreakUnit) -> String {
        let words: String
        switch unit {
        case .days: words = run.length == 1 ? "1 day" : "\(run.length) days"
        case .times: words = run.length == 1 ? "1 time" : "\(run.length) times"
        case .weeks: words = run.length == 1 ? "1 week" : "\(run.length) weeks"
        case .months: words = run.length == 1 ? "1 month" : "\(run.length) months"
        case .years: words = run.length == 1 ? "1 year" : "\(run.length) years"
        }
        let start = run.start.date(calendar: calendar), end = run.end.date(calendar: calendar)
        let dates = run.start == run.end ? end.formatted(.dateTime.day().month(.abbreviated).year())
            : (start..<end).formatted(.interval.day().month(.abbreviated).year())
        return "\(words) · \(dates)" + (run.isCurrent ? " · now" : "")
    }

    // MARK: By weekday (report §8.6, §16.8a)

    /// Each weekday in the person's week order: the share done of its planned days (check-offs) or the average on
    /// them (amounts and time). Empty when the range has fewer than 28 planned days.
    func byWeekday(_ habit: Habit, in range: ClosedRange<LocalDay>, today: LocalDay? = nil) -> [WeekdayStat] {
        let today = today ?? self.today()
        let start = startDay(of: habit)
        guard start <= min(range.upperBound, today) else { return [] }
        let rule = rule(habit, on: min(range.upperBound, today))
        guard rule.frequency.isDayBased, !rule.frequency.isFlexible else { return [] }
        var done = [Int: Double](), planned = [Int: Int]()
        let averages: Bool = { switch rule.kind { case .amount, .duration: return true; default: return false } }()
        var total = 0
        for day in days(in: max(range.lowerBound, start)...min(range.upperBound, today)) {
            let mark = dayMark(habit, on: day)
            guard mark == .done || (day < today && (mark == .some || mark == .missed)) else { continue }
            let weekday = calendar.component(.weekday, from: day.date(calendar: calendar))
            planned[weekday, default: 0] += 1
            total += 1
            if averages { done[weekday, default: 0] += dayProgress(of: self.rule(habit, on: day), on: day) }
            else if mark == .done { done[weekday, default: 0] += 1 }
        }
        guard total >= 28 else { return [] }
        let names = calendar.shortWeekdaySymbols
        return (0..<7).map { i in
            let weekday = (calendar.firstWeekday - 1 + i) % 7 + 1
            let n = planned[weekday] ?? 0
            let value = n == 0 ? 0 : (done[weekday] ?? 0) / Double(n) * (averages ? 1 : 100)
            return WeekdayStat(weekday: weekday, name: names[weekday - 1], value: value, days: n)
        }
    }

    /// "Most often done on Mon and Wed." Never names a worst day.
    static func weekdayCaption(_ stats: [WeekdayStat], averages: Bool) -> String? {
        let planned = stats.filter { $0.days > 0 }
        guard let top = planned.map(\.value).max(), top > 0 else { return nil }
        let best = planned.filter { $0.value >= top - 0.0001 }.map(\.name)
        guard best.count < planned.count else { return nil }
        let list = best.count == 1 ? best[0] : best.dropLast().joined(separator: ", ") + " and " + best.last!
        return averages ? "Most on \(list)." : "Most often done on \(list)."
    }

    // MARK: 30-day rate (report §16.6)

    /// Of the planned days in the 30 days up to each week's end, how many were done; one point a week.
    func rate30(_ habit: Habit, today: LocalDay? = nil) -> [RatePoint] {
        let today = today ?? self.today()
        let start = startDay(of: habit)
        guard start <= today, rule(habit, on: today).frequency.isDayBased else { return [] }
        let list = days(in: start...today)
        guard list.count >= 30 else { return [] }
        // Prefix sums of counted and done days, so each window is two subtractions.
        var counted = [0], done = [0]
        for day in list {
            let mark = dayMark(habit, on: day)
            let counts = mark == .done || (day < today && (mark == .some || mark == .missed))
            counted.append(counted.last! + (counts ? 1 : 0))
            done.append(done.last! + (mark == .done ? 1 : 0))
        }
        var points: [RatePoint] = []
        var i = list.count
        while i >= 30 {
            let c = counted[i] - counted[i - 30], d = done[i] - done[i - 30]
            if c > 0 { points.append(RatePoint(date: list[i - 1].date(calendar: calendar), percent: Double(d) / Double(c) * 100)) }
            i -= 7
        }
        return points.reversed()
    }
}
