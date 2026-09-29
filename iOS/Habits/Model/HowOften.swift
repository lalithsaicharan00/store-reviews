import Foundation

/// The New Habit form's "How often", in the words people use (Round 3 design §2.5). Each choice is
/// one whole sentence ending, so no choice can contradict another row, and nothing needs confirming.
/// It maps onto the stored `Frequency` the app already has: no schema change.
enum HowOften: Hashable {
    /// Every day (with an amount: that much a day).
    case everyDay
    /// Just do it, 2 or more times a day: each ✓ counts one ("Brush twice a day").
    case timesADay(Int)
    /// Just do it, N times a week, month or year, on any days: every ✓ counts, even two on one day.
    case times(GoalPeriod, Int)
    /// N different days a week, month or year. With an amount: the days you reach it ("5 km on 3 days a week").
    case days(GoalPeriod, Int)
    /// An amount in total over a week, month or year ("2 chapters a week").
    case total(GoalPeriod)
    /// On certain days of the week ("every Monday and Wednesday").
    case weekdays(Set<Int>)
    /// Every few weeks, counted from the start date, with no set days ("every other week"). Days are an
    /// add-on: choosing them makes it a calendar rule ("every other week on Saturday").
    case everyWeeks(Int)
    /// Every few days or weeks on set days, every few months, or on a date each month or year.
    case calendar(CalendarSchedule)
    /// Tasks only: comes back a while after it's done ("2 weeks after it's done"), counted from the day it
    /// was ticked, not from a fixed date. Habits keep fixed rhythms.
    case afterDone(Int, ScheduleUnit)

    /// The choice as the end of the person's sentence, for the How often row: "Every day", "Twice a day",
    /// "3 times a week", "A week (in total)", "Every Monday and Wednesday".
    func label(hasAmount: Bool, checklist: Bool = false, weekStart: Int) -> String {
        HabitCopy.capitalized(phrase(hasAmount: hasAmount, checklist: checklist, weekStart: weekStart))
    }

    func phrase(hasAmount: Bool, checklist: Bool = false, weekStart: Int) -> String {
        switch self {
        case .everyDay:
            return "every day"
        case .timesADay(let n):
            return "\(HabitCopy.times(n)) a day"
        case .times(let period, let n):
            // An amount or a checklist counts the days it's reached, so it reads as days.
            if hasAmount || checklist { return HowOften.days(period, n).phrase(hasAmount: hasAmount, weekStart: weekStart) }
            return "\(HabitCopy.times(n)) a \(period.noun)"
        case .days(let period, let n):
            return n == 1 ? "once a \(period.noun)" : (hasAmount ? "on " : "") + "\(n) days a \(period.noun)"
        case .total(let period):
            return "a \(period.noun)"
        case .weekdays(let days):
            return HabitCopy.dayText(days, weekStart: weekStart)
        case .everyWeeks(let n):
            return HabitCopy.everyN(n, "week")
        case .calendar(let rule):
            return HabitCopy.calendarText(rule, weekStart: weekStart)
        case .afterDone(let n, let unit):
            return HabitCopy.rhythm(.afterCompletion(n, unit), weekStart: weekStart)
        }
    }

    /// Where the habit stands on Today, and how its ✓ or amount counts. `goal` is the amount (nil: Just do it).
    func frequency(hasAmount: Bool, checklist: Bool) -> Frequency {
        switch self {
        case .everyDay, .timesADay:
            return .daily
        case .times(let period, let n):
            if hasAmount || checklist { return .flexible(period, n) }
            return period.frequency(count: n)
        case .days(let period, let n):
            return .flexible(period, n)
        case .total(let period):
            return period.frequency(count: 1)
        case .weekdays(let days):
            return days.count >= 7 ? .daily : .weekdays(days)
        case .everyWeeks(let n):
            return .everyNWeeks(n)
        case .calendar(let rule):
            return .calendar(rule)
        case .afterDone(let n, let unit):
            return .afterCompletion(n, unit)
        }
    }
}

/// Everything the New Habit form knows about how much and how often, as chosen. `apply` writes it into a
/// habit with the same rules for every type, so the read-back, Today and the reminders all agree.
struct HabitPlan {
    /// The unit that makes a habit timed: its amount is in minutes, set with hours and minutes.
    static let timeUnit = "minutes"

    /// nil: Just do it (check it off).
    var amount: Double?
    var unit = ""
    /// What one tap on + adds. nil: the suggested step (`suggestedStep`), shown on the form.
    var step: Double?
    /// "Ask how much": + opens the number pad instead of adding a step (saved as a step of 0; 29 Sep).
    var asks = false
    var often: HowOften = .everyDay
    /// Cut down: the amount is a limit, not a goal.
    var atMost = false
    /// A checklist: done when every step is ticked.
    var checklist = false

    var isTimed: Bool { amount != nil && unit == HabitPlan.timeUnit }
    var hasAmount: Bool { amount != nil }
    /// + adds a number only for amounts; ✓ and ▶ need no step.
    var hasStep: Bool { amount != nil && !isTimed && !checklist }

    /// The step + adds, as it will be saved.
    var stepValue: Double { step ?? HabitPlan.suggestedStep(amount: amount, unit: unit, often: often) }

    /// A step people can see and change ("Each + adds"), never a rule they can't (Round 3 §2.7):
    /// - "5 km on 3 days a week": each time, so + adds the whole 5 km.
    /// - Drinks by volume: one glass, 250 ml / 8 oz / 0.25 L.
    /// - Whole counts up to 20 (8 glasses, 12 books): 1.
    /// - Distances: 1 km or 1 mile.
    /// - Bigger counts: a round tenth of the goal (10,000 steps → 1,000; 100 push-ups → 10).
    static func suggestedStep(amount: Double?, unit: String, often: HowOften) -> Double {
        guard let amount, amount > 0 else { return 1 }
        let low = unit.trimmingCharacters(in: .whitespaces).lowercased()
        switch low {
        case "ml": return min(250, amount)
        case "l", "litre", "litres", "liter", "liters": return min(0.25, amount)
        case "oz": return min(8, amount)
        case "cl": return min(25, amount)
        default: break
        }
        if case .days = often { return amount }
        if case .times = often { return amount }
        if amount < 1 { return amount }
        if ["km", "kms", "mile", "miles", "mi"].contains(low) { return 1 }
        let whole = amount.rounded() == amount
        if whole && amount <= 20 { return 1 }
        let tenth = amount / 10
        let power = pow(10, floor(log10(tenth)))
        let scaled = tenth / power
        let nice: Double = scaled < 1.5 ? 1 : scaled < 3.5 ? 2 : scaled < 7.5 ? 5 : 10
        return max(1, nice * power)
    }

    /// Writes kind, goal, unit and frequency into the habit.
    func apply(to habit: inout Habit) {
        habit.checkUnit = nil
        habit.atMost = atMost
        if checklist {
            habit.kind = .checklist
            habit.goal = 1
        } else if let amount {
            habit.kind = isTimed ? .duration : .amount(unit: TextLimit.clean(unit, TextLimit.unit), increment: asks ? 0 : stepValue)
            habit.goal = amount
        } else {
            habit.kind = .check
            habit.goal = 1
        }
        habit.frequency = often.frequency(hasAmount: hasAmount, checklist: checklist)
        // Just do it counts its ✓: twice a day is a goal of 2, three times a week a goal of 3.
        if amount == nil && !checklist {
            switch often {
            case .timesADay(let n), .times(_, let n): habit.goal = Double(n)
            default: break
            }
        }
    }

    /// How much, for the form's row: "Just do it", "2 chapters", "30 min", "At most 3 coffees".
    var howMuchLabel: String {
        guard let amount else { return checklist ? "Steps" : "Just do it" }
        let text = isTimed ? HabitCopy.minutes(amount) : HabitCopy.amount(amount, unit)
        return atMost ? "At most \(text)" : text
    }
}

/// What the How often screen remembers while choosing, so switching between choices never loses a number
/// already set (3 times a week, the chosen days, the 15th). `often` is the one choice in force.
struct OftenDraft {
    enum Choice: Hashable { case everyDay, timesADay, times, total, weekdays, everyDays, everyWeeks, everyMonths, date, afterDone }

    var choice: Choice = .everyDay
    var perDay = 2
    var count = 3
    var countPeriod: GoalPeriod = .week
    /// Just do it: count different days ("3 days a week") instead of every ✓ ("3 times a week").
    var countsDays = false
    var totalPeriod: GoalPeriod = .week
    var weekdays: Set<Int> = []
    /// Every few days, weeks or months. Weeks may add set days (empty: counted from the start date).
    var daysInterval = 2
    var weeksInterval = 2
    var weeksDays: Set<Int> = []
    var monthsInterval = 3
    /// Tasks: again this long after it's done.
    var afterCount = 1
    var afterUnit: ScheduleUnit = .week
    private(set) var startDate = 1
    private(set) var anchorWeekStart = 2
    /// On a date each month or year (month or year units).
    var dateRule = CalendarSchedule(unit: .month, interval: 1)
    private(set) var seeded = false

    /// The chosen days start as the start date's own day, date and month.
    mutating func seed(start: Date, weekStart: Int, calendar: Calendar = .current) {
        guard !seeded else { return }
        seeded = true
        let weekday = calendar.component(.weekday, from: start)
        let date = calendar.component(.day, from: start)
        weekdays = [weekday]
        startDate = date
        anchorWeekStart = weekStart
        dateRule.dates = [date]
        dateRule.day = date
        dateRule.month = calendar.component(.month, from: start)
        dateRule.weekday = weekday
        dateRule.ordinal = min(5, (date - 1) / 7 + 1)
        dateRule.anchorWeekStart = weekStart
    }

    func often(hasAmount: Bool) -> HowOften {
        switch choice {
        case .everyDay: return .everyDay
        case .timesADay: return hasAmount ? .everyDay : .timesADay(max(2, perDay))
        // Just do it counts every time (the user, 29 Sep: "times" and "days" mean the same to people); an
        // amount counts the days it's reached.
        case .times: return hasAmount ? .days(countPeriod, max(1, count)) : .times(countPeriod, max(1, count))
        case .total: return hasAmount ? .total(totalPeriod) : .times(totalPeriod, 1)
        case .weekdays: return .weekdays(weekdays)
        case .everyDays: return .calendar(CalendarSchedule(unit: .day, interval: max(2, daysInterval)))
        case .everyWeeks:
            if weeksDays.isEmpty { return .everyWeeks(max(1, weeksInterval)) }
            return .calendar(CalendarSchedule(unit: .week, interval: max(1, weeksInterval), weekdays: weeksDays, anchorWeekStart: anchorWeekStart))
        case .everyMonths:
            return .calendar(CalendarSchedule(unit: .month, interval: max(1, monthsInterval), dates: [startDate], pattern: .dates,
                                              anchorWeekStart: anchorWeekStart))
        case .date: return .calendar(dateRule)
        case .afterDone: return .afterDone(max(1, afterCount), afterUnit)
        }
    }

    /// The most a count can be in its period: 7 days a week, 31 a month, 366 a year; ticks can go higher.
    func countMaximum(days: Bool) -> Int {
        switch countPeriod {
        case .week: days ? 7 : 99
        case .month: days ? 31 : 999
        case .year: days ? 366 : 9999
        case .day: 99
        }
    }
}
