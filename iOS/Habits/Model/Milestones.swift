import Foundation

/// Milestones (report "Milestones — Marking Progress Without Noise", 30 Sep; Feature Ledger C101). Users show a
/// round number reached is worth marking, and that a celebration which stops the next tap is worth a one-star review.
/// So a milestone is a line beside the row's Undo the tap already shows, and a record on the habit's page: never a
/// pop-up, a screen, confetti or a notification. Everything here is calculated from the streak, never stored, so a
/// milestone can't be lost or disagree with the numbers. Ported from the 30 Sep feature branch on 1 Oct 2026 (quit
/// habits' milestones were already on their page, from Progress Phase 2).
extension StreakUnit {
    /// The streak lengths worth marking (report "Milestones on the Habit Page", 3 Oct 2026: the lengths people write
    /// most are 3 and 7 days, then 30 and 100): 3, 7, 14, 30, 50, 100, 200, 365, 500, 1,000, then each year.
    func isMilestone(_ n: Int) -> Bool {
        switch self {
        case .days, .times: [3, 7, 14, 30, 50, 100, 200, 365, 500, 1000].contains(n) || (n > 365 && n % 365 == 0)
        case .weeks: [2, 4, 8, 12, 26, 52].contains(n) || (n > 52 && n % 52 == 0)
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
