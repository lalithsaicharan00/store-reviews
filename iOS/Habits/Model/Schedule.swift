import Foundation

/// Calendar recurrence and distinct-day quotas are separate from aggregate quantity goals.
/// Existing Frequency cases retain their original meaning when older records are loaded.
enum ScheduleUnit: String, CaseIterable, Codable, Sendable, Identifiable {
    case day, week, month, year
    var id: Self { self }
    var plural: String { rawValue + "s" }
    var component: Calendar.Component {
        switch self { case .day: .day; case .week: .weekOfYear; case .month: .month; case .year: .year }
    }
}

struct CalendarSchedule: Codable, Hashable, Sendable {
    enum MonthPattern: String, CaseIterable, Codable, Identifiable {
        case dates = "Dates", last = "Last day", weekday = "Weekday"
        var id: Self { self }
    }
    var unit: ScheduleUnit = .day
    var interval = 2
    var weekdays: Set<Int> = []
    var dates: Set<Int> = []
    var pattern: MonthPattern = .dates
    var ordinal = 1 // 1…5 or -1 for last
    var weekday = 1
    var month = 1
    var day = 1
    var useLastDay = true
    /// Captured with the rule; later changes to display week start cannot shift occurrences.
    var anchorWeekStart = 2

    func matches(_ date: LocalDay, start: LocalDay, calendar: Calendar) -> Bool {
        guard date >= start else { return false }
        let n = max(1, interval)
        let d = date.date(calendar: calendar)
        let anchor = start.date(calendar: calendar)
        let last = calendar.range(of: .day, in: .month, for: d)!.count
        switch unit {
        case .day:
            return (calendar.dateComponents([.day], from: anchor, to: d).day ?? 0) % n == 0
        case .week:
            var stable = calendar
            stable.firstWeekday = anchorWeekStart
            let week = stable.dateInterval(of: .weekOfYear, for: anchor)!.start
            let gap = stable.dateComponents([.day], from: week, to: d).day ?? 0
            return (gap / 7) % n == 0 && weekdays.contains(stable.component(.weekday, from: d))
        case .month:
            let gap = (date.year - start.year) * 12 + date.month - start.month
            guard gap % n == 0 else { return false }
            switch pattern {
            case .dates: return dates.contains(date.day) || (useLastDay && date.day == last && dates.contains { $0 > last })
            case .last: return date.day == last
            case .weekday:
                guard calendar.component(.weekday, from: d) == weekday else { return false }
                return ordinal == -1 ? date.day + 7 > last : (date.day - 1) / 7 + 1 == ordinal
            }
        case .year:
            guard (date.year - start.year) % n == 0, date.month == month else { return false }
            return date.day == (useLastDay ? min(day, last) : day)
        }
    }

    func next(from date: LocalDay, start: LocalDay, end: LocalDay? = nil, calendar: Calendar) -> LocalDay? {
        var cursor = max(date, start)
        // Up to 20 years, including leap-year gaps and every-20-years rules.
        for _ in 0...8000 {
            if let end, cursor > end { return nil }
            if matches(cursor, start: start, calendar: calendar) { return cursor }
            cursor = cursor.adding(days: 1, calendar: calendar)
        }
        return nil
    }
}

struct ScheduleDraft {
    enum Mode: String, CaseIterable, Identifiable {
        case daily = "Every day", specific = "Specific days", interval = "Every…", flexible = "A number of days", after = "After completion"
        var id: Self { self }
    }
    var mode: Mode = .daily
    var weekdays: Set<Int> = []
    var rule = CalendarSchedule()
    var flexiblePeriod: GoalPeriod = .week
    var weekDays = 3
    var monthDays = 5
    var yearDays = 12
    var afterCount = 1
    var afterUnit: ScheduleUnit = .week
    var seeded = false
    var intervalCounts: [ScheduleUnit: Int] = [.day: 2, .week: 2, .month: 1, .year: 1]

    mutating func seed(start: Date, weekStart: Int) {
        guard !seeded else { return }
        seeded = true
        let cal = Calendar.current
        let weekday = cal.component(.weekday, from: start)
        weekdays = [weekday]
        rule.weekdays = [weekday]
        rule.dates = [cal.component(.day, from: start)]
        rule.day = cal.component(.day, from: start)
        rule.month = cal.component(.month, from: start)
        rule.weekday = weekday
        rule.ordinal = (rule.day - 1) / 7 + 1
        rule.anchorWeekStart = weekStart
    }

    var count: Int {
        get { switch flexiblePeriod { case .week: weekDays; case .month: monthDays; case .year: yearDays; case .day: 1 } }
        set { switch flexiblePeriod { case .week: weekDays = newValue; case .month: monthDays = newValue; case .year: yearDays = newValue; case .day: break } }
    }
    var frequency: Frequency {
        switch mode {
        case .daily: .daily
        case .specific: weekdays.count == 7 ? .daily : .weekdays(weekdays)
        case .interval: .calendar(rule)
        case .flexible: .flexible(flexiblePeriod, count)
        case .after: .afterCompletion(afterCount, afterUnit)
        }
    }
    func dayNames(_ days: Set<Int>, full: Bool = false) -> String {
        let cal = Calendar.current
        let symbols = full ? cal.standaloneWeekdaySymbols : cal.shortStandaloneWeekdaySymbols
        let order = (0..<7).map { (rule.anchorWeekStart - 1 + $0) % 7 + 1 }
        return order.filter(days.contains).map { symbols[$0 - 1] }.formatted(.list(type: .and))
    }
    /// The Repeat row and screen, in the shared habit words ("Every Monday and Wednesday", "Every other week on
    /// Friday", "2 weeks after it's done"), so a task reads the way a habit does.
    var summary: String {
        if mode == .flexible { return "\(count) \(count == 1 ? "day" : "days") \(flexiblePeriod.suffix)" }
        return HabitCopy.capitalized(HabitCopy.rhythm(frequency, weekStart: rule.anchorWeekStart))
    }
    func explanation(start: Date, checklist: Bool = false) -> String {
        switch mode {
        case .daily: return "Every day is on the schedule."
        case .specific: return "On \(dayNames(weekdays, full: true))."
        case .flexible: return "\(checklist ? "Finish the checklist" : "Reach the daily goal") on any \(count) different \(count == 1 ? "day" : "days") each \(flexiblePeriod.noun)."
        case .after: return "The next task is scheduled \(summary), using the day you actually finish it."
        case .interval:
            let date = start.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated).year())
            let cadence = rule.interval == 1 ? "every \(rule.unit.rawValue)" : "every \(rule.interval) \(rule.unit.plural)"
            let sentenceCadence = "E" + cadence.dropFirst()
            switch rule.unit {
            case .day: return "\(sentenceCadence), starting \(date)."
            case .week:
                var cal = Calendar.current; cal.firstWeekday = rule.anchorWeekStart
                let week = cal.dateInterval(of: .weekOfYear, for: start)!.start
                return "\(sentenceCadence) on \(dayNames(rule.weekdays, full: true)), starting with the week of \(week.formatted(.dateTime.day().month(.abbreviated).year()))."
            case .month:
                let pattern: String
                switch rule.pattern {
                case .dates: pattern = rule.dates.sorted().map(Self.ordinal).formatted(.list(type: .and))
                case .last: pattern = "last day"
                case .weekday: pattern = "\(Self.ordinalName(rule.ordinal).lowercased()) \(Calendar.current.standaloneWeekdaySymbols[rule.weekday - 1])"
                }
                let policy = rule.pattern == .dates && rule.dates.contains { $0 > 28 }
                    ? (rule.useLastDay ? " Shorter months use the last day." : " Dates missing from a month are skipped.") : ""
                return "On the \(pattern) \(cadence), starting \(date).\(policy)"
            case .year:
                let on = Calendar.current.date(from: DateComponents(year: 2024, month: rule.month, day: rule.day))!
                    .formatted(.dateTime.day().month(.wide))
                let policy = rule.month == 2 && rule.day == 29
                    ? (rule.useLastDay ? " Years without 29 Feb use 28 Feb." : " Years without 29 Feb are skipped.") : ""
                return "\(sentenceCadence) on \(on), starting \(date).\(policy)"
            }
        }
    }
    /// "1st", "22nd". One formatter, made once (PERFORMANCE.md rule 8).
    static func ordinal(_ n: Int) -> String {
        ordinalFormatter.string(from: NSNumber(value: n)) ?? String(n)
    }
    private static let ordinalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter
    }()
    static func ordinalName(_ n: Int) -> String {
        switch n { case 1: "First"; case 2: "Second"; case 3: "Third"; case 4: "Fourth"; case 5: "Fifth"; default: "Last" }
    }
}

extension Frequency {
    var isFlexible: Bool { if case .flexible = self { return true }; return false }
}
