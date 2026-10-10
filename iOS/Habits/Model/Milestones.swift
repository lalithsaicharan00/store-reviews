import Foundation

/// Milestones (report "Milestones — Marking Progress Without Noise", 30 Sep; Feature Ledger C101). Users show a
/// round number reached is worth marking, and that a celebration which stops the next tap is worth a one-star review.
/// So a milestone is a line beside the row's Undo the tap already shows, and a record on the habit's page: never a
/// pop-up, a screen, confetti or a notification. Everything here is calculated from the streak, never stored, so a
/// milestone can't be lost or disagree with the numbers. Ported from the 30 Sep feature branch on 1 Oct 2026 (quit
/// habits' milestones were already on their page, from Progress Phase 2).
extension StreakUnit {
    /// The streak lengths worth marking. The 3 Oct 2026 ladders (report "Milestones on the Habit Page": the lengths people
    /// write most are 3 and 7 days, then 30 and 100) with the user's 11 Oct additions in between, about 15 per ladder
    /// (spec "Habit Progress — Overall Record, Streaks and Milestones" §4.1). Every earlier value stays.
    /// - days and times: 3, 7, 10, 14, 30, 50, 75, 100, 150, 200, 250, 365, 500, 730, 1,000, then every 365 after 730;
    /// - weeks: 2, 3, 4, 6, 8, 10, 12, 16, 20, 26, 39, 52, 78, 104, then every 52;
    /// - months: 2, 3, 4, 5, 6, 9, 12, 15, 18, 24, 30, 36, then every 12;
    /// - years: every year from 1.
    func isMilestone(_ n: Int) -> Bool {
        switch self {
        case .days, .times: Self.dayLadder.contains(n) || (n > 730 && n % 365 == 0)
        case .weeks: Self.weekLadder.contains(n) || (n > 104 && n % 52 == 0)
        case .months: Self.monthLadder.contains(n) || (n > 36 && n % 12 == 0)
        case .years: n >= 1
        }
    }

    static let dayLadder: Set<Int> = [3, 7, 10, 14, 30, 50, 75, 100, 150, 200, 250, 365, 500, 730, 1000]
    static let weekLadder: Set<Int> = [2, 3, 4, 6, 8, 10, 12, 16, 20, 26, 39, 52, 78, 104]
    static let monthLadder: Set<Int> = [2, 3, 4, 5, 6, 9, 12, 15, 18, 24, 30, 36]

    /// Every milestone up to `n`, smallest first.
    func milestones(upTo n: Int) -> [Int] {
        n < 1 ? [] : (1...n).filter(isMilestone)
    }

    func nextMilestone(after n: Int) -> Int {
        var k = max(n, 0) + 1
        while !isMilestone(k) { k += 1 }
        return k
    }

    /// "day" or "days" for `n`: a streak's length in its own unit.
    func word(_ n: Int) -> String {
        switch self {
        case .days: n == 1 ? "day" : "days"
        case .times: n == 1 ? "time" : "times"
        case .weeks: n == 1 ? "week" : "weeks"
        case .months: n == 1 ? "month" : "months"
        case .years: n == 1 ? "year" : "years"
        }
    }

    /// The goal's period as a word, for "This week: 2 of 3": nil for day-based goals.
    var periodNoun: String? {
        switch self {
        case .days, .times: nil
        case .weeks: "week"
        case .months: "month"
        case .years: "year"
        }
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

/// The In total ladders (spec §4.2): goals met 10, 25, 50, 100, 250, 500, 1,000, 2,500 and 5,000 times for every goal;
/// month goals add 3 and 6 first, year goals 2 and 5 (the user, 11 Oct 2026), so a first marker comes after a season
/// or a few years, not after almost a decade.
enum TotalMilestones {
    static let common = [10, 25, 50, 100, 250, 500, 1000, 2500, 5000]

    static func ladder(for period: GoalPeriod) -> [Int] {
        switch period {
        case .month: [3, 6] + common
        case .year: [2, 5] + common
        case .day, .week: common
        }
    }
}
