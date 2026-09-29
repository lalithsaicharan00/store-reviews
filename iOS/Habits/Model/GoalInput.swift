import Foundation

/// Shared validation for goal entry and actual progress; never silently rounds a user's input.
enum GoalNumber {
    // A representation safety bound, not a product goal cap (keeps integer formatting safe).
    static let maximum = 9_000_000_000_000.0

    static func parse(_ text: String, decimals: Int = 2, locale: Locale = .current) -> Double? {
        let raw = text.trimmingCharacters(in: .whitespacesAndNewlines)
        let normalized = raw.replacingOccurrences(of: locale.decimalSeparator ?? ".", with: ".")
        let pattern = decimals == 0 ? #"^[0-9]+$"# : "^[0-9]+(?:\\.[0-9]{0,\(decimals)})?$"
        guard normalized.range(of: pattern, options: .regularExpression) != nil,
              let value = Double(normalized), value.isFinite, value <= maximum else { return nil }
        return value
    }

    static func text(_ value: Double) -> String {
        value.formatted(.number.grouping(.never).precision(.fractionLength(0...2)))
    }
}

/// The period a goal is for. Each one stands alone: a week, month or year goal never needs a daily
/// goal underneath it ("Goals — Periods, Entry and What + Adds", 28 Sep). Named the way reviewers
/// name them: "daily goal", "8 glasses a day" ("Goal Screen Round 2", T4).
enum GoalPeriod: String, CaseIterable, Identifiable, Codable, Hashable, Sendable {
    case day, week, month, year
    var id: Self { self }
    /// Values in the labelled "Goal counts over" menu.
    var label: String {
        switch self {
        case .day: "A day"
        case .week: "A week"
        case .month: "A month"
        case .year: "A year"
        }
    }
    /// After an amount: "a day", "a week".
    var suffix: String { "a " + noun }
    var noun: String { rawValue }

    /// Longest time that fits in one period, so a time goal can't ask for 30 hours a day.
    var maxMinutes: Double {
        switch self {
        case .day: 24 * 60
        case .week: 7 * 24 * 60
        case .month: 31 * 24 * 60
        case .year: 366 * 24 * 60
        }
    }

    func frequency(count: Int = 1, daily: Frequency = .daily) -> Frequency {
        switch self {
        case .day: daily
        case .week: .perWeek(count)
        case .month: .perMonth(count)
        case .year: .perYear(count)
        }
    }
}

/// What the Goal screen edits, as typed. Check it off starts at "1 time per day"; Count it starts empty
/// so the number and unit are the user's own; Time it starts at 20 minutes.
struct GoalDraft {
    var period: GoalPeriod = .day
    var amount = "1"
    var unit = "times"
    var hours = "0"
    var minutes = "20"

    var trimmedUnit: String { TextLimit.clean(unit, TextLimit.unit) }

    var duration: Double? { duration(max: GoalNumber.maximum) }

    func duration(max: Double) -> Double? {
        guard let h = GoalNumber.parse(hours, decimals: 0),
              let m = GoalNumber.parse(minutes, decimals: 0), m < 60,
              h * 60 + m > 0, h * 60 + m <= max else { return nil }
        return h * 60 + m
    }

    /// Check it off is always whole ticks, whatever the unit; amounts take up to 2 decimal places.
    func wholeOnly(check: Bool) -> Bool { check }

    func amountValue(check: Bool) -> Double? {
        guard let n = GoalNumber.parse(amount, decimals: wholeOnly(check: check) ? 0 : 2), n > 0 else { return nil }
        return n
    }

    func value(timed: Bool, check: Bool) -> Double? {
        if timed { return duration(max: period.maxMinutes) }
        // The unit is optional: "8 a day" is a goal too (the user's decision, 28 Sep).
        return amountValue(check: check)
    }

    /// The big part of the read-back: "8 glasses", "3 times", "Once", "1 h 30 min".
    func amountText(timed: Bool, check: Bool) -> String? {
        guard let value = value(timed: timed, check: check) else { return nil }
        if timed { return Format.minutes(value) }
        if trimmedUnit == "times" { return value == 1 ? "Once" : "\(Format.amount(value)) times" }
        return trimmedUnit.isEmpty ? Format.amount(value) : "\(Format.amount(value)) \(trimmedUnit)"
    }

    /// One line, for the form's Goal row and VoiceOver: "8 glasses a day", "Once a day", "3 h a week".
    func summary(timed: Bool, check: Bool) -> String? {
        amountText(timed: timed, check: check).map { "\($0) \(period.suffix)" }
    }

    /// Check it off stays a check-off whatever the unit; the unit only names each tick ("Goal Screen Round 2", T7).
    func apply(to habit: inout Habit, timed: Bool, check: Bool) {
        habit.goal = value(timed: timed, check: check) ?? 1
        habit.kind = timed ? .duration : check ? .check : .amount(unit: trimmedUnit, increment: 1)
        habit.checkUnit = check && trimmedUnit != "times" && !trimmedUnit.isEmpty ? trimmedUnit : nil
        habit.frequency = period.frequency(count: habit.kind == .check ? Int(habit.goal) : 1, daily: habit.frequency)
    }
}

extension Habit {
    /// What one tap on + adds: always the step saved with the habit and shown on the button ("+250"), never
    /// a rule that changes with the goal's size (Round 3 §2.7, replacing `CountLogging`'s "+1 or ask").
    /// nil for an amount habit set to "Ask how much" (a saved step of 0): + opens the number pad (29 Sep).
    var quickIncrement: Double? {
        guard case .amount(_, let increment) = kind, increment > 0 else { return nil }
        return increment
    }

    /// Tapping + asks how much instead of adding a set step.
    var asksHowMuch: Bool {
        if case .amount(_, let increment) = kind { return increment <= 0 }
        return false
    }
}
