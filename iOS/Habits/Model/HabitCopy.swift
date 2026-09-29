import Foundation

/// A habit in words, the way a person says it: "Read 2 chapters a week", "Gym every Monday and Wednesday",
/// "Run every Sunday to Thursday", "Pay rent on the 1st of every month" (Round 3 design, "Creating a Habit —
/// Round 3, The User's Own Words" §2; the user's copy rules of 29 Sep: the copy is the value).
///
/// One place for this copy, used by the New Habit read-back, its rows, Today and the reminders, so they can
/// never disagree. It mirrors `iOS/Tools/copy_oracle/copy_oracle.py` rule for rule; `CopyCheck` compares
/// the two on the phone with the cases reviewed there.
enum HabitCopy {
    /// English, like the rest of the app's copy, so every phone reads the same sentence.
    static let fullDays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    static let shortDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    static let monthNames = ["January", "February", "March", "April", "May", "June", "July", "August",
                             "September", "October", "November", "December"]
    /// Numbers are grouped the phone's way ("10,000"); `CopyCheck` fixes it to en_US.
    nonisolated(unsafe) static var locale = Locale.current

    // MARK: Small words

    /// "1st", "2nd", "3rd", "11th", "22nd".
    static func ordinal(_ n: Int) -> String {
        let suffix: String
        if (10...20).contains(n % 100) {
            suffix = "th"
        } else {
            switch n % 10 {
            case 1: suffix = "st"
            case 2: suffix = "nd"
            case 3: suffix = "rd"
            default: suffix = "th"
            }
        }
        return "\(n)\(suffix)"
    }

    /// "first" … "fifth", "last" (the ordinal weekday of a month).
    static func ordinalWord(_ n: Int) -> String {
        switch n {
        case 1: return "first"
        case 2: return "second"
        case 3: return "third"
        case 4: return "fourth"
        case 5: return "fifth"
        default: return "last"
        }
    }

    /// "A", "A and B", "A, B and C".
    static func join(_ items: [String]) -> String {
        switch items.count {
        case 0: return ""
        case 1: return items[0]
        case 2: return "\(items[0]) and \(items[1])"
        default: return items.dropLast().joined(separator: ", ") + " and " + items[items.count - 1]
        }
    }

    /// "once", "twice", "3 times".
    static func times(_ n: Int) -> String {
        n == 1 ? "once" : n == 2 ? "twice" : "\(n) times"
    }

    /// "every day", "every other week", "every 3 months".
    static func everyN(_ n: Int, _ unit: String) -> String {
        n <= 1 ? "every \(unit)" : n == 2 ? "every other \(unit)" : "every \(n) \(unit)s"
    }

    /// The first letter in capitals, for a phrase that starts a line: "Every Mon and Wed".
    static func capitalized(_ text: String) -> String {
        guard let first = text.first else { return text }
        return first.uppercased() + text.dropFirst()
    }

    // MARK: Days of the week

    /// Chosen days, in the user's week order, as unbroken runs. A run through the end of the week and on
    /// into its start ("Saturday to Monday") is one run, said first.
    static func dayRuns(_ days: Set<Int>, weekStart: Int) -> [[Int]] {
        let order = (0..<7).map { (weekStart - 1 + $0) % 7 + 1 }
        var runs: [[Int]] = []
        var current: [Int] = []
        for day in order {
            if days.contains(day) {
                current.append(day)
            } else if !current.isEmpty {
                runs.append(current)
                current = []
            }
        }
        if !current.isEmpty { runs.append(current) }
        if runs.count > 1, days.contains(order[0]), days.contains(order[6]) {
            let wrapped = runs[runs.count - 1] + runs[0]
            runs = [wrapped] + Array(runs[1..<(runs.count - 1)])
        }
        return runs
    }

    /// The whole phrase, its first word included: "every day", "on weekdays", "on weekends",
    /// "every day except Sunday", "every Sunday to Thursday", "every Monday and Wednesday".
    static func dayText(_ days: Set<Int>, weekStart: Int, short: Bool = false) -> String {
        let names = short ? shortDays : fullDays
        func name(_ day: Int) -> String { names[(day - 1 + 7) % 7] }
        let days = days.filter { (1...7).contains($0) }
        let count = days.count
        if count == 0 { return "on no days yet" }
        if count == 7 { return "every day" }
        if days == [2, 3, 4, 5, 6] { return "on weekdays" }
        if days == [1, 7] { return "on weekends" }
        let missing = (1...7).filter { !days.contains($0) }
            .sorted { (($0 - weekStart) % 7 + 7) % 7 < (($1 - weekStart) % 7 + 7) % 7 }
        if count == 6 { return "every day except \(name(missing[0]))" }
        let runs = dayRuns(days, weekStart: weekStart)
        if runs.count == 1, runs[0].count >= 3 {
            return "every \(name(runs[0][0])) to \(name(runs[0][runs[0].count - 1]))"
        }
        if count == 5 { return "every day except " + join(missing.map(name)) }
        // Ranges only for one unbroken run: "Monday, Wednesday, Thursday and Friday" reads more clearly
        // than "Monday, and Wednesday to Friday".
        return "every " + join(runs.flatMap { $0 }.map(name))
    }

    /// "every other week on Monday and Wednesday", "every 3 weeks, Sunday to Thursday".
    static func weekText(every n: Int, days: Set<Int>, weekStart: Int, short: Bool = false) -> String {
        let lead = everyN(n, "week")
        let body = dayText(days, weekStart: weekStart, short: short)
        if body == "every day" { return "every day, \(lead)" }
        if body.hasPrefix("on ") { return "\(lead) \(body)" }
        if body.hasPrefix("every day except") { return "\(lead), \(body)" }
        let rest = String(body.dropFirst("every ".count))
        return rest.contains(" to ") ? "\(lead), \(rest)" : "\(lead) on \(rest)"
    }

    // MARK: Dates of the month

    static let oddDates = Set(stride(from: 1, through: 31, by: 2))
    static let evenDates = Set(stride(from: 2, through: 30, by: 2))
    /// More separate dates than this read as "on 12 dates each month".
    static let manyDates = 6

    /// "1st", "15th", "1st to 5th" (three or more dates in a row).
    static func dateParts(_ dates: Set<Int>) -> (parts: [String], hasRange: Bool) {
        var runs: [[Int]] = []
        var current: [Int] = []
        for date in dates.sorted() {
            if let last = current.last, date == last + 1 {
                current.append(date)
            } else {
                if !current.isEmpty { runs.append(current) }
                current = [date]
            }
        }
        if !current.isEmpty { runs.append(current) }
        var parts: [String] = []
        var hasRange = false
        for run in runs {
            if run.count >= 3 {
                parts.append("\(ordinal(run[0])) to \(ordinal(run[run.count - 1]))")
                hasRange = true
            } else {
                parts += run.map(ordinal)
            }
        }
        return (parts, hasRange)
    }

    /// "on the 1st of every month", "on the 15th, every 3 months".
    static func monthTail(_ phrase: String, every interval: Int) -> String {
        interval <= 1 ? "\(phrase) of every month" : "\(phrase), \(everyN(interval, "month"))"
    }

    /// "on the 1st and 15th of every month", "on the last day of every month", "on odd dates",
    /// "every day except the 31st", "on 7 dates each month".
    static func monthDates(_ dates: Set<Int>, useLastDay: Bool = true, every interval: Int = 1) -> String {
        let dates = dates.filter { (1...31).contains($0) }
        let months = everyN(interval, "month")
        if dates.isEmpty { return "on no dates yet" }
        if dates.count == 31 { return interval <= 1 ? "every day" : "every day, \(months)" }
        if dates == oddDates { return interval <= 1 ? "on odd dates" : "on odd dates, \(months)" }
        if dates == evenDates { return interval <= 1 ? "on even dates" : "on even dates, \(months)" }
        if dates == [31] && useLastDay { return monthTail("on the last day", every: interval) }
        if dates.count >= 28 {
            // Nearly every date: say the few it isn't on.
            let missing = (1...31).filter { !dates.contains($0) }
            let text = "every day except the " + join(missing.map(ordinal))
            return interval <= 1 ? text : "\(text), \(months)"
        }
        let (parts, hasRange) = dateParts(dates)
        if parts.count > manyDates {
            return interval <= 1 ? "on \(dates.count) dates each month" : "on \(dates.count) dates, \(months)"
        }
        // With a range in it, each part gets its "the": "the 1st to 3rd and the 15th".
        let listed = hasRange ? join(parts.map { "the " + $0 }) : "the " + join(parts)
        return monthTail("on " + listed, every: interval)
    }

    /// "every year on October 1", "every other year on December 25".
    static func yearText(month: Int, day: Int, every interval: Int = 1) -> String {
        "\(everyN(interval, "year")) on \(monthNames[(month - 1 + 12) % 12]) \(day)"
    }

    /// Any calendar rule, in words.
    static func calendarText(_ rule: CalendarSchedule, weekStart: Int, short: Bool = false) -> String {
        let n = max(1, rule.interval)
        switch rule.unit {
        case .day:
            return everyN(n, "day")
        case .week:
            return n == 1 ? dayText(rule.weekdays, weekStart: weekStart, short: short)
                : weekText(every: n, days: rule.weekdays, weekStart: weekStart, short: short)
        case .month:
            switch rule.pattern {
            case .last:
                return monthTail("on the last day", every: n)
            case .weekday:
                let names = short ? shortDays : fullDays
                return monthTail("on the \(ordinalWord(rule.ordinal)) \(names[(rule.weekday - 1 + 7) % 7])", every: n)
            case .dates:
                return monthDates(rule.dates, useLastDay: rule.useLastDay, every: n)
            }
        case .year:
            return yearText(month: rule.month, day: rule.day, every: n)
        }
    }

    /// How often, alone, for rules that name days: "every Monday and Wednesday", "every other day".
    /// Empty for counts over a period ("3 times a week"), which `plan` words with their number.
    static func rhythm(_ frequency: Frequency, weekStart: Int, short: Bool = false) -> String {
        switch frequency {
        case .daily: return "every day"
        case .weekdays(let days): return dayText(days, weekStart: weekStart, short: short)
        case .everyNDays(let n): return everyN(n, "day")
        case .everyNWeeks(let n): return everyN(n, "week")
        case .monthDates(let dates): return monthDates(dates)
        case .calendar(let rule): return calendarText(rule, weekStart: weekStart, short: short)
        case .afterCompletion(let n, let unit): return "\(n) \(n == 1 ? unit.rawValue : unit.plural) after it's done"
        case .perWeek, .perMonth, .perYear, .flexible: return ""
        }
    }

    // MARK: Amounts and units

    /// Units whose name doesn't change with the number.
    static let unchangingUnits: Set<String> = ["ml", "l", "oz", "km", "kg", "g", "mg", "kcal", "cal", "mi", "m", "cl",
                                               "$", "€", "£", "₹"]
    /// Units the plain rules below would get wrong.
    static let singularUnits: [String: String] = ["glasses": "glass", "lbs": "lb", "push-ups": "push-up", "pushups": "pushup",
                                                  "sit-ups": "sit-up", "pull-ups": "pull-up", "coffees": "coffee",
                                                  "series": "series", "news": "news"]
    static let currencies: Set<String> = ["$", "€", "£", "₹"]

    /// "1 glass", never "1 glasses"; the unit as it is for any other number.
    static func unitWord(_ value: Double, _ unit: String) -> String {
        guard value == 1, !unit.isEmpty else { return unit }
        let low = unit.lowercased()
        if unchangingUnits.contains(low) { return unit }
        if let singular = singularUnits[low] {
            if unit == low { return singular }
            return unit.first?.isUppercase == true ? capitalized(singular) : unit
        }
        if ["ches", "shes", "sses", "xes"].contains(where: { low.hasSuffix($0) }) { return String(unit.dropLast(2)) }
        if low.hasSuffix("ies") && low.count > 4 { return String(unit.dropLast(3)) + "y" }
        if low.hasSuffix("s") && !["ss", "us", "is"].contains(where: { low.hasSuffix($0) }) && low.count > 2 {
            return String(unit.dropLast())
        }
        return unit
    }

    /// The whole number, grouped, as people read it: "10,000", "2.5", "0.25".
    static func number(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: value)) ?? String(value)
    }

    /// "8 glasses", "1 glass", "2,000 ml", "$100", "8" (no unit).
    static func amount(_ value: Double, _ unit: String) -> String {
        let unit = unit.trimmingCharacters(in: .whitespaces)
        if currencies.contains(unit) { return unit + number(value) }
        return unit.isEmpty ? number(value) : "\(number(value)) \(unitWord(value, unit))"
    }

    /// "10 min", "1 h 30 min", "3 h".
    static func minutes(_ value: Double) -> String {
        let total = Int(value.rounded())
        let h = total / 60, m = total % 60
        if h == 0 { return "\(m) min" }
        return m == 0 ? "\(h) h" : "\(h) h \(m) min"
    }

    // MARK: The habit

    /// How much, or nil for "done or not": "8 glasses", "30 min", "2,000 ml".
    static func howMuch(_ habit: Habit) -> String? {
        switch habit.kind {
        case .duration: return minutes(habit.goal)
        case .amount(let unit, _): return amount(habit.goal, unit)
        case .check:
            if let unit = habit.checkUnit, !unit.isEmpty { return amount(habit.goal, unit) }
            return nil
        default: return nil
        }
    }

    /// The unit the habit is counted in, if any.
    static func unit(of habit: Habit) -> String {
        switch habit.kind {
        case .amount(let unit, _): return unit
        case .check: return habit.checkUnit ?? ""
        default: return ""
        }
    }

    /// How much and how often, without the name: "2 chapters a week", "twice a day", "3 times a week",
    /// "5 km on 3 days a week", "every Monday and Wednesday", "at most 3 coffees a day".
    static func plan(_ habit: Habit, weekStart: Int, short: Bool = false) -> String {
        let frequency = habit.frequency
        let much = howMuch(habit)
        if habit.atMost {
            let per: String
            switch frequency {
            case .perWeek: per = "a week"
            case .perMonth: per = "a month"
            case .perYear: per = "a year"
            default: per = "a day"
            }
            return "at most \(much ?? number(habit.goal)) \(per)"
        }
        switch frequency {
        case .perWeek(let n), .perMonth(let n), .perYear(let n):
            let per = frequency.periodNoun
            if let much { return "\(much) a \(per)" }
            return "\(times(n)) a \(per)"
        case .flexible(let period, let n):
            let per = period.noun
            if n == 1 { return much.map { "\($0), once a \(per)" } ?? "once a \(per)" }
            let days = "\(n) days a \(per)"
            return much.map { "\($0) on \(days)" } ?? days
        default:
            break
        }
        let base = rhythm(frequency, weekStart: weekStart, short: short)
        if let much {
            if case .daily = frequency { return "\(much) a day" }
            return "\(much) \(base)"
        }
        if habit.kind == .check && habit.goal > 1 {
            let count = times(Int(habit.goal))
            if case .daily = frequency { return "\(count) a day" }
            return "\(count) a day, \(base)"
        }
        return base
    }

    /// "Push-ups" counted in push-ups: the name is the unit, so it isn't said twice.
    static func namesUnit(_ name: String, _ unit: String) -> Bool {
        let name = name.trimmingCharacters(in: .whitespaces).lowercased()
        return !unit.isEmpty && (name == unit.lowercased() || name == unitWord(1, unit).lowercased())
    }

    /// The habit said back as one sentence: "Read 2 chapters a week", "Gym every Monday and Wednesday",
    /// "100 push-ups a day", "Coffee: at most 3 coffees a day".
    static func sentence(_ habit: Habit, weekStart: Int) -> String {
        let text = plan(habit, weekStart: weekStart)
        let name = habit.name.trimmingCharacters(in: .whitespaces)
        if name.isEmpty || namesUnit(name, unit(of: habit)) { return capitalized(text) }
        if habit.atMost { return "\(name): \(text)" }
        return "\(name) \(text)"
    }

    /// Today's extra line for rules that name days ("Every Mon and Wed", "On the 1st of every month").
    /// Empty when the progress line already says how often ("1/3 this week", "0/8 glasses").
    static func todayCaption(_ habit: Habit, weekStart: Int) -> String {
        if habit.atMost { return "" }
        switch habit.frequency {
        case .daily, .perWeek, .perMonth, .perYear, .flexible: return ""
        default: return capitalized(rhythm(habit.frequency, weekStart: weekStart, short: true))
        }
    }
}

extension Frequency {
    /// "week", "month", "year" for a count over a period; "day" otherwise.
    var periodNoun: String {
        switch self {
        case .perWeek: "week"
        case .perMonth: "month"
        case .perYear: "year"
        case .flexible(let period, _): period.noun
        default: "day"
        }
    }
}
