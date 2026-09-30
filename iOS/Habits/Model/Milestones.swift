import Foundation

/// Milestones (report "Milestones — Marking Progress Without Noise", 30 Sep; Feature Ledger C101). Users show a
/// round number reached is worth marking, and that a celebration which stops the next tap is worth a one-star review.
/// So a milestone is a line in the Undo bar the tap already shows, and a record on the habit's page: never a
/// pop-up, a screen, confetti or a notification. Everything here is calculated from the streak, never stored, so a
/// milestone can't be lost or disagree with the numbers.
extension StreakUnit {
    /// The streak lengths worth marking: a week, a month, a hundred, a year, then each year.
    func isMilestone(_ n: Int) -> Bool {
        switch self {
        case .days, .times: [7, 30, 100, 365, 500, 1000].contains(n) || (n > 365 && n % 365 == 0)
        case .weeks: [4, 12, 26, 52].contains(n) || (n > 52 && n % 52 == 0)
        case .months: [3, 6, 12].contains(n) || (n > 12 && n % 12 == 0)
        case .years: n >= 2
        }
    }

    /// Every milestone up to `n`, smallest first.
    func milestones(upTo n: Int) -> [Int] {
        n < 1 ? [] : (1...n).filter(isMilestone)
    }

    func nextMilestone(after n: Int) -> Int {
        var k = max(n, 0) + 1
        while !isMilestone(k) { k += 1 }
        return k
    }

    /// "30 days in a row", "12 weeks in a row".
    func inARow(_ n: Int) -> String {
        switch self {
        case .days: n == 1 ? "1 day in a row" : "\(n) days in a row"
        case .times: n == 1 ? "1 time in a row" : "\(n) times in a row"
        case .weeks: n == 1 ? "1 week in a row" : "\(n) weeks in a row"
        case .months: n == 1 ? "1 month in a row" : "\(n) months in a row"
        case .years: n == 1 ? "1 year in a row" : "\(n) years in a row"
        }
    }

    /// Just the numbers, for a list: "7, 30 and 100 days".
    func list(_ values: [Int]) -> String {
        let noun = switch self {
        case .days: "days"
        case .times: "times"
        case .weeks: "weeks"
        case .months: "months"
        case .years: "years"
        }
        return ListFormatter.localizedString(byJoining: values.map(String.init)) + " " + noun
    }
}

/// Time since the last slip, for quit habits: the first day, the first week, a month, three months, a year.
enum QuitMilestones {
    static let days = [1, 3, 7, 14, 30, 90, 180, 365]

    /// All reached in a run of `elapsed` seconds, then each further year.
    static func reached(_ elapsed: TimeInterval) -> [Int] {
        let d = Int(elapsed / 86400)
        let years = d >= 730 ? (2...(d / 365)).map { $0 * 365 } : []
        return days.filter { $0 <= d } + years
    }

    static func next(_ elapsed: TimeInterval) -> Int {
        let d = Int(elapsed / 86400)
        return days.first { $0 > d } ?? ((d / 365) + 1) * 365
    }

    /// "1 day", "1 week", "6 months", "1 year", "2 years".
    static func label(_ days: Int) -> String {
        switch days {
        case 1: "1 day"
        case 7: "1 week"
        case 14: "2 weeks"
        case 180: "6 months"
        case let d where d >= 365 && d % 365 == 0: d == 365 ? "1 year" : "\(d / 365) years"
        default: "\(days) days"
        }
    }
}
