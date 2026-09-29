import Foundation

/// What a name suggests for how much ("Drink water" → 8 glasses, "Walk" → 10,000 steps, "Meditate" →
/// 10 min). Shown only as the amount field's hint: an amount depends on the person, so the form never fills
/// one in (the user, 29 Sep, after a quick review pass: see the Round 4 checklist). How often starts as
/// every day for everyone ("How People Describe a Habit": every day is the most common shape).
struct HabitDefaults: Equatable {
    var amount: Double
    var unit: String
    var often: HowOften

    private static var metric: Bool { Locale.current.measurementSystem != .us }

    /// Words at the start of any word in the name: "Drink water" matches "water", "Push-ups" matches "push".
    private static func matches(_ name: String, _ keys: [String]) -> Bool {
        let words = name.lowercased().split(whereSeparator: { !$0.isLetter })
        return words.contains { word in keys.contains { word.hasPrefix($0) } }
    }

    static func suggest(_ type: ItemType, name: String) -> HabitDefaults {
        let n = name
        switch type {
        case .amount:
            let pick: (Double, String)
            if matches(n, ["water", "drink", "hydrat"]) { pick = (8, "glasses") }
            else if matches(n, ["step", "walk"]) { pick = (10_000, "steps") }
            else if matches(n, ["run", "jog"]) { pick = metric ? (5, "km") : (3, "miles") }
            else if matches(n, ["cycl", "bike", "ride", "biking"]) { pick = metric ? (10, "km") : (5, "miles") }
            else if matches(n, ["swim"]) { pick = (20, "laps") }
            else if matches(n, ["read", "book"]) { pick = (10, "pages") }
            else if matches(n, ["write", "writing", "journal"]) { pick = (300, "words") }
            else if matches(n, ["push"]) { pick = (20, "push-ups") }
            else if matches(n, ["squat"]) { pick = (20, "squats") }
            else if matches(n, ["sit"]) { pick = (20, "sit-ups") }
            else if matches(n, ["pray"]) { pick = (5, "prayers") }
            else if matches(n, ["fruit", "veg"]) { pick = (5, "servings") }
            else { pick = (1, "") }
            return HabitDefaults(amount: pick.0, unit: pick.1, often: .everyDay)
        case .time:
            let minutes: Double
            if matches(n, ["meditat", "breath", "stretch"]) { minutes = 10 }
            else if matches(n, ["study", "learn", "code", "coding"]) { minutes = 60 }
            else if matches(n, ["practi", "piano", "guitar", "violin", "sing", "draw", "paint"]) { minutes = 30 }
            else if matches(n, ["exercis", "workout", "gym", "walk", "run", "jog", "cycl", "bike"]) { minutes = 30 }
            else { minutes = 20 }
            return HabitDefaults(amount: minutes, unit: HabitPlan.timeUnit, often: .everyDay)
        case .doIt, .checklist:
            // How often starts as every day for every habit (the user, 29 Sep): the most common shape, and
            // one value that fits most people.
            return HabitDefaults(amount: 0, unit: "", often: .everyDay)
        case .cutBack:
            let pick: (Double, String)
            if matches(n, ["coffee", "caffeine"]) { pick = (2, "coffees") }
            else if matches(n, ["smok", "cigar", "vap"]) { pick = (5, "cigarettes") }
            else if matches(n, ["alcohol", "drink", "beer", "wine"]) { pick = (2, "drinks") }
            else if matches(n, ["snack", "sugar", "sweet", "candy", "chocolate", "soda"]) { pick = (1, "snacks") }
            else { pick = (3, "") }
            return HabitDefaults(amount: pick.0, unit: pick.1, often: .everyDay)
        case .quit, .task:
            return HabitDefaults(amount: 0, unit: "", often: .everyDay)
        }
    }
}

extension OftenDraft {
    /// A draft whose choice is `often`, keeping the draft's other remembered numbers.
    mutating func choose(_ often: HowOften) {
        switch often {
        case .everyDay: choice = .everyDay
        case .timesADay(let n): choice = .timesADay; perDay = n
        case .times(let period, let n): choice = .times; countPeriod = period; count = n; countsDays = false
        case .days(let period, let n): choice = .times; countPeriod = period; count = n; countsDays = true
        case .total(let period): choice = .total; totalPeriod = period
        case .weekdays(let days): choice = .weekdays; weekdays = days
        case .everyWeeks(let n): choice = .everyWeeks; weeksInterval = n; weeksDays = []
        case .afterDone(let n, let unit): choice = .afterDone; afterCount = n; afterUnit = unit
        case .calendar(let rule):
            switch rule.unit {
            case .day: choice = .everyDays; daysInterval = rule.interval
            case .week: choice = .everyWeeks; weeksInterval = rule.interval; weeksDays = rule.weekdays
            default: choice = .date; dateRule = rule
            }
        }
    }
}
