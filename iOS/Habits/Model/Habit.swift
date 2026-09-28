import Foundation

/// A calendar day in the user's own reckoning ("2026-09-27"), independent of time zone.
/// Entries store the day they count for, so travelling never moves them (Architecture 05 §4.1).
nonisolated struct LocalDay: Hashable, Comparable, Codable, Sendable {
    let year: Int
    let month: Int
    let day: Int

    init(year: Int, month: Int, day: Int) {
        self.year = year; self.month = month; self.day = day
    }

    init(_ date: Date, calendar: Calendar = .current) {
        let c = calendar.dateComponents([.year, .month, .day], from: date)
        self.init(year: c.year!, month: c.month!, day: c.day!)
    }

    /// Noon on this day, a safe anchor for calendar arithmetic across daylight-saving changes.
    func date(calendar: Calendar = .current) -> Date {
        calendar.date(from: DateComponents(year: year, month: month, day: day, hour: 12))!
    }

    func adding(days: Int, calendar: Calendar = .current) -> LocalDay {
        LocalDay(calendar.date(byAdding: .day, value: days, to: date(calendar: calendar))!, calendar: calendar)
    }

    static func < (a: LocalDay, b: LocalDay) -> Bool {
        (a.year, a.month, a.day) < (b.year, b.month, b.day)
    }
}

/// A day section: Anytime, or a named part of the day with a start time ("Day sections" research,
/// Today reports 8, 16 and 25). Sections sort by start time; a section ends where the next begins,
/// and only the latest has its own end.
struct DaySection: Identifiable, Codable, Hashable, Sendable {
    /// Stable ID: "anytime", "morning", "afternoon", "evening", or a UUID for the user's own.
    var id: String
    var name: String
    /// Minutes after midnight; nil only for Anytime.
    var start: Int?
    /// Only the latest section keeps an end; minutes after midnight, up to 24:00 plus the day end.
    var end: Int?

    var isAnytime: Bool { start == nil }

    static let defaults: [DaySection] = [
        DaySection(id: .anytime, name: "Anytime", start: nil, end: nil),
        DaySection(id: .morning, name: "Morning", start: 6 * 60, end: nil),
        DaySection(id: .afternoon, name: "Afternoon", start: 12 * 60, end: nil),
        DaySection(id: .evening, name: "Evening", start: 18 * 60, end: 24 * 60),
    ]

    static func clock(_ minutes: Int) -> String {
        // The phone's own time format (7:00 AM or 07:00), matching the system time pickers.
        let m = minutes % (24 * 60)
        let date = Calendar.current.date(bySettingHour: m / 60, minute: m % 60, second: 0, of: .now) ?? .now
        return date.formatted(date: .omitted, time: .shortened)
    }
}

extension String {
    static let anytime = "anytime"
    static let morning = "morning"
    static let afternoon = "afternoon"
    static let evening = "evening"
}

/// What a habit measures. One mental model: every habit shows "amount/goal unit".
enum HabitKind: Codable, Hashable, Sendable {
    /// Done or not done, once or more a day ("Do it").
    case check
    /// An amount with a unit, logged in steps of `increment` ("Reach an amount"; with `atMost`, "Cut back").
    case amount(unit: String, increment: Double)
    /// Minutes, logged with a timer ("Spend time").
    case duration
    /// A list of items, all ticked to finish the day ("Follow a checklist").
    case checklist
    /// Time since the last slip, counted up live.
    case quit
    /// Done once, on a day. No streak, no stats.
    case task
}

/// How often a habit is due. Day rules have a per-day goal. Period rules: for Check it off and
/// checklists, n completions on any days; for amounts, minutes and limits, a total for the period
/// (the goal is the habit's `goal`, and n is 1).
enum Frequency: Codable, Hashable, Sendable {
    case daily
    /// Weekday numbers as in `Calendar` (1 = Sunday … 7 = Saturday).
    case weekdays(Set<Int>)
    /// Every n days, counted from the day the habit was made.
    case everyNDays(Int)
    /// Every n weeks, on the weekday the habit was made.
    case everyNWeeks(Int)
    /// On these dates of each month (1…31; 29–31 fall on the month's last day when it is shorter).
    case monthDates(Set<Int>)
    /// n completions a week, on any days.
    case perWeek(Int)
    /// n completions a month, on any days.
    case perMonth(Int)
    /// n completions a year, on any days.
    case perYear(Int)

    var isDayBased: Bool {
        switch self {
        case .daily, .weekdays, .everyNDays, .everyNWeeks, .monthDates: true
        case .perWeek, .perMonth, .perYear: false
        }
    }
}

/// One of a habit's times, in the user's local clock (Architecture 05 §4.4: "local time" reminders).
/// A time places the habit on Today; with Remind Me on, it also notifies. (Called "reminders" in
/// storage, which predates times placing habits.)
struct ReminderTime: Codable, Hashable, Sendable, Identifiable {
    var id: UUID = UUID()
    var hour: Int
    var minute: Int

    var minuteOfDay: Int { hour * 60 + minute }
}

/// How a habit's times alert: a notification, or (iOS 26+) an AlarmKit alarm that rings on silent.
enum AlertStyle: String, Codable, Hashable, Sendable {
    case notification, alarm
}

struct Step: Identifiable, Codable, Hashable, Sendable {
    var id: UUID = UUID()
    var name: String
}

/// Palette names map to system colours so they adapt to light and dark mode.
enum HabitColor: String, CaseIterable, Codable, Sendable {
    case red, orange, yellow, green, mint, teal, cyan, blue, indigo, purple, pink, brown, gray
}

struct Habit: Identifiable, Codable, Hashable, Sendable {
    var id: UUID = UUID()
    var name: String
    var symbol: String
    var color: HabitColor
    var kind: HabitKind
    /// The day section for a habit with no times (`DaySection.id`); unknown IDs show under Anytime.
    /// Ignored while it has times: they decide where it shows (`HabitStore.placements(of:)`).
    var parts: [String] = [.anytime]
    /// Day rules: the goal for each due day (times, amount or minutes). Period rules: taken from the frequency.
    var goal: Double = 1
    var frequency: Frequency = .daily
    /// Amount habits: the goal is a maximum ("no more than 2 coffees"), not a minimum.
    var atMost = false
    /// One-time tasks: the day it is for, and an optional time (minutes after midnight).
    var dueDay: LocalDay?
    var dueMinute: Int?
    var steps: [Step] = []
    /// The habit's times. They place it on Today, and notify when `remind` is on.
    var reminders: [ReminderTime] = []
    /// "Remind Me": whether the times notify.
    var remind = true
    var alert: AlertStyle = .notification
    /// "Remind Again If Not Done": minutes between repeats (15, 30 or 60), at most 3; nil when off.
    var followUpMinutes: Int?
    /// The first day it counts (past or future); nil means the day it was made.
    var startsOn: LocalDay?
    /// The last day it's due; nil means it never ends.
    var endsOn: LocalDay?
    /// Quit habits: when the current run started (the last slip, or when the habit was made).
    var quitSince: Date?
    var createdAt: Date = .now
    var archived = false
}

/// One thing the user logged. Taps are events with their own ID, so a retried write
/// can never count twice, and two real taps always count twice (Architecture 05 §3.2).
struct Entry: Identifiable, Codable, Hashable, Sendable {
    var id: UUID = UUID()
    var habitID: UUID
    /// Step entries tick one step of a habit with steps.
    var stepID: UUID?
    var day: LocalDay
    var value: Double
    var createdAt: Date = .now
    var timeZone: String = TimeZone.current.identifier
    /// For a habit in several day sections: the section this tick was for.
    var slot: String?
}

/// What a streak counts, so its number is never mistaken for days.
enum StreakUnit {
    case days, times, weeks, months, years

    /// Beside the flame: "6", "6×", "3 wk", "2 mo", "1 yr". Only a daily habit's streak is a bare number.
    func short(_ n: Int) -> String {
        switch self {
        case .days: "\(n)"
        case .times: "\(n)×"
        case .weeks: "\(n) wk"
        case .months: "\(n) mo"
        case .years: "\(n) yr"
        }
    }

    /// The sentence shown when the streak is tapped, and read by VoiceOver.
    func explained(_ n: Int) -> String {
        switch self {
        case .days: n == 1 ? "Done 1 day in a row" : "Done \(n) days in a row"
        case .times: n == 1 ? "Done the last time it was due" : "Done the last \(n) times it was due, in a row"
        case .weeks: n == 1 ? "Goal met 1 week in a row" : "Goal met \(n) weeks in a row"
        case .months: n == 1 ? "Goal met 1 month in a row" : "Goal met \(n) months in a row"
        case .years: n == 1 ? "Goal met 1 year in a row" : "Goal met \(n) years in a row"
        }
    }
}

extension Frequency {
    var streakUnit: StreakUnit {
        switch self {
        case .daily: .days
        case .weekdays(let days): days.count == 7 ? .days : .times
        case .everyNDays, .everyNWeeks, .monthDates: .times
        case .perWeek: .weeks
        case .perMonth: .months
        case .perYear: .years
        }
    }
}

extension String {
    /// At most `limit` characters, then "…". Used where a name must stay on one line.
    func capped(_ limit: Int) -> String {
        count > limit ? prefix(limit).trimmingCharacters(in: .whitespaces) + "…" : self
    }
}

/// Longest text a person can type in each field. Generous, so real names never hit them;
/// they only stop pasted paragraphs from breaking the layout.
enum TextLimit {
    static let name = 100      // habit and to-do names
    static let checklistPart = 60
    static let section = 30    // day section names
    static let unit = 24       // "tablespoons of chia seed"

    /// Trimmed and cut to `limit` characters.
    static func clean(_ text: String, _ limit: Int) -> String {
        String(text.trimmingCharacters(in: .whitespacesAndNewlines).prefix(limit))
    }
}
