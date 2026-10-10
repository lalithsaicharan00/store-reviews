import Foundation

// The words the app shows (rows, Day details, logs), worked out from the store and nothing else. Shared by the iPhone and
// the Apple Watch, so a habit reads the same on both (Apple Watch build prompt §3: "always the iPhone's words"). Moved
// here unchanged from Components, TodayRows, DayActivity and RecordParts (10 Oct 2026).

// MARK: - Formatting

enum Format {
    /// Numbers as entered: whole stays whole ("8"), decimals up to two places ("0.25", "2.5"),
    /// and from 1,000 the k suffix with at most one decimal ("1k", "5.2k", "12.5k").
    static func amount(_ v: Double) -> String {
        if abs(v) >= 1000 {
            let k = (v / 100).rounded() / 10
            return trimmed(k, places: 1) + "k"
        }
        return trimmed(v, places: 2)
    }

    /// Minutes as hours and minutes: "45 min", "1 h", "1 h 25 min". Never decimals or "k".
    static func minutes(_ v: Double) -> String {
        let total = Int(v.rounded())
        let h = total / 60, m = total % 60
        if h == 0 { return "\(m) min" }
        return m == 0 ? "\(h) h" : "\(h) h \(m) min"
    }

    /// A running timer's clock, counting up: "0:07", "7:42", "1:07:42". Minutes in, whole seconds out.
    static func clock(_ minutes: Double) -> String {
        let total = max(0, Int((minutes * 60).rounded(.down)))
        let h = total / 3600, m = total / 60 % 60, s = total % 60
        return h > 0 ? String(format: "%d:%02d:%02d", h, m, s) : String(format: "%d:%02d", m, s)
    }

    /// One formatter per number of places, made once (PERFORMANCE.md rule 8): a new `NumberFormatter` for each
    /// number was nearly all of a Today row's own time, and of the New Habit preview's (profile, 1 Oct 2026).
    /// `autoupdatingCurrent` follows a change of region while the app runs.
    private static var trimmers: [Int: NumberFormatter] = [:]

    private static func trimmed(_ v: Double, places: Int) -> String {
        let f = trimmers[places] ?? {
            let f = NumberFormatter()
            f.minimumFractionDigits = 0
            f.maximumFractionDigits = places
            f.usesGroupingSeparator = false
            f.locale = .autoupdatingCurrent
            trimmers[places] = f
            return f
        }()
        return f.string(from: NSNumber(value: v)) ?? String(v)
    }

    /// "12d 11:23:07"
    static func elapsed(_ t: TimeInterval) -> String {
        let s = Int(t)
        return String(format: "%dd %02d:%02d:%02d", s / 86400, s % 86400 / 3600, s % 3600 / 60, s % 60)
    }

    static func days(_ t: TimeInterval) -> String {
        let d = Int(t / 86400)
        return d == 1 ? "1 day" : "\(d) days"
    }
}

/// A quit run's length: "15 d 22 h", "3 h 20 min" (moved from ProgressQuitRowView).
enum RunWords {
    static func short(_ t: TimeInterval) -> String {
        let minutes = max(0, Int(t / 60))
        let d = minutes / 1440, h = minutes % 1440 / 60, m = minutes % 60
        return d > 0 ? "\(d) d \(h) h" : "\(h) h \(m) min"
    }
}

/// A running timer's goal alert, moved from TimerPresence so the Apple Watch says the same (D3).
enum TimerWords {
    static func period(_ habit: Habit) -> String {
        switch habit.frequency {
        case .perWeek: " this week"
        case .perMonth: " this month"
        case .perYear: " this year"
        default: ""
        }
    }

    /// "20 min done." / "That's your 1 h limit for today." Says what counts, never "failed" or
    /// "overdue" (Design Rules, copy).
    static func goalMessage(_ habit: Habit, goal: Double) -> String {
        let amount = Format.minutes(goal)
        let period = period(habit)
        if habit.atMost {
            return "That's your \(amount) limit for \(period.isEmpty ? "today" : String(period.dropFirst()))."
        }
        return "\(amount) done\(period). The timer keeps going until you stop it."
    }
}

// MARK: - Today's rows

/// "3/8 glasses", "12/20 min", "2/3 this week", "1/4 steps", "1/3 times", "0/2 cups max": one format for every habit.
/// While a timer runs, time is a live clock instead: "7:42/20 min" ("Timing a Habit", 28 Sep).
func goalLine(_ habit: Habit, progress: Double, goal: Double, running: Bool = false) -> String {
    let period = switch habit.frequency {
    case .perWeek: " this week"
    case .perMonth: " this month"
    case .perYear: " this year"
    default: ""
    }
    // A limit reads like any count, with "max" after it (as the player says it): "1/2 cups max" (3 Oct 2026).
    let max = habit.atMost ? " max" : ""
    switch habit.kind {
    case .duration:
        // Time is always hours and minutes: "12 min/1 h 30 min".
        let done = running ? Format.clock(progress) : Format.minutes(progress.rounded(.down))
        return "\(done)/\(Format.minutes(goal))\(max)\(period)"
    case .amount(let unit, _):
        // No unit: just the numbers ("3/8").
        return "\(Format.amount(progress))/\(Format.amount(goal))\(unit.isEmpty ? "" : " " + unit)\(max)\(period)"
    case .checklist:
        return "\(Format.amount(progress))/\(Format.amount(goal)) steps\(period)"
    case .check where habit.checkUnit != nil:
        return "\(Format.amount(progress))/\(Format.amount(goal)) \(habit.checkUnit!)\(period)"
    case .check:
        // Counted with no unit of its own: "1/3 times", so the number never stands alone.
        return "\(Format.amount(progress))/\(Format.amount(goal))\(habit.frequency.isDayBased ? " times" : "")\(max)\(period)"
    case .quit, .task:
        return "\(Format.amount(progress))/\(Format.amount(goal))\(max)\(period)"
    }
}

/// A task's line always says it's a task (report "Today's Rows — The Line Under the Name": people want tasks and habits
/// told apart), then its time if set, or where it came from if it moved forward: "Task", "Task · 5:00 PM".
func taskLine(_ habit: Habit, shownOn day: LocalDay, calendar: Calendar) -> String {
    var parts = ["Task"]
    if let due = habit.dueDay, due < day {
        parts.append("From " + due.date(calendar: calendar).formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated)))
    }
    if let minute = habit.dueMinute {
        let time = calendar.date(bySettingHour: minute / 60, minute: minute % 60, second: 0, of: .now)!
        parts.append(time.formatted(date: .omitted, time: .shortened))
    }
    return parts.joined(separator: " · ")
}

extension HabitStore {
    /// The line under the name (report "Today's Rows — The Line Under the Name", 3 Oct 2026): what today asks of this
    /// habit, the same kind of fact on every row. Counted: how much and how far along ("3/8 glasses", "2/3 this week",
    /// "1/4 steps", "1/2 cups max"). A single tick: how often ("Every day", "Every Mon, Wed and Fri"), since the ✓ is
    /// its done-or-not and "0/1" says nothing. Then its time. A task says it's a task; a skipped day says so.
    func rowLine(_ habit: Habit, on day: LocalDay, slot: String?, time: ReminderTime?, progress: Double, goal: Double, running isRunning: Bool) -> String {
        if habit.kind == .task { return taskLine(habit, shownOn: day, calendar: calendar) }
        let time = time.map { " · " + DaySection.clock($0.minuteOfDay) } ?? ""
        if isSkipped(habit, on: day) { return (day == today() ? "Skipped today" : "Skipped") + time }
        if case .flexible(let period, let needed) = habit.frequency, let count = flexibleProgress(habit, on: day) {
            let days = "\(count)/\(needed) \(needed == 1 ? "day" : "days") this \(period.noun)"
            // A tick on some days a week: the days are the progress. An amount or a time: today's, then the days.
            return (habit.kind == .check ? days : goalLine(habit, progress: progress, goal: goal, running: isRunning) + " · " + days) + time
        }
        if habit.kind == .check && habit.frequency.isDayBased && (slot != nil || goal <= 1) {
            return HabitCopy.capitalized(HabitCopy.rhythm(habit.frequency, weekStart: settings.weekStart, short: true)) + time
        }
        return goalLine(habit, progress: progress, goal: goal, running: isRunning) + time
    }
}

// MARK: - Days, logs and Day details

/// The words for a day, the way people say them.
enum DayWords {
    /// "Today", "Yesterday", or "Mon, 29 Sep".
    static func day(_ day: LocalDay, today: LocalDay, calendar: Calendar) -> String {
        if day == today { return "Today" }
        if day == today.adding(days: -1, calendar: calendar) { return "Yesterday" }
        return short(day, calendar: calendar)
    }

    /// "Today" or "Yesterday" beside a date picker; nothing for other days (the picker says the date).
    static func relative(_ day: LocalDay, today: LocalDay, calendar: Calendar) -> String? {
        if day == today { return "Today" }
        if day == today.adding(days: -1, calendar: calendar) { return "Yesterday" }
        return nil
    }

    /// "Today, 7 Oct", "Yesterday, 6 Oct", "Sun, 4 Oct": a record's fixed date.
    static func withDate(_ day: LocalDay, today: LocalDay, calendar: Calendar) -> String {
        let date = day.date(calendar: calendar)
        if let word = relative(day, today: today, calendar: calendar) {
            return word + ", " + date.formatted(.dateTime.day().month(.abbreviated))
        }
        return short(day, calendar: calendar)
    }

    /// "Tue, 6 Oct".
    static func short(_ day: LocalDay, calendar: Calendar) -> String {
        day.date(calendar: calendar).formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated))
    }

    /// "Paused · back Mon, 13 Oct", or "Paused until you turn it back on" (moved from HabitPageView).
    static func paused(_ pause: HabitPause, calendar: Calendar) -> String {
        guard let last = pause.through else { return "Paused until you turn it back on" }
        return "Paused · back " + short(last.adding(days: 1, calendar: calendar), calendar: calendar)
    }

    /// "9:40 PM", in the given calendar's zone.
    static func clock(_ date: Date, calendar: Calendar) -> String {
        date.formatted(Date.FormatStyle(date: .omitted, time: .shortened, calendar: calendar, timeZone: calendar.timeZone))
    }
}

extension Entry {
    func description(for habit: Habit) -> String {
        if let stepID { return habit.steps.first { $0.id == stepID }?.name ?? "Checklist step" }
        switch habit.kind {
        case .amount(let unit, _): return HabitCopy.amount(value, unit)
        case .duration: return value < 1 ? "\(HabitCopy.number(value * 60)) sec" : Format.minutes(value)
        case .quit: return "Slip"
        case .check: return value == 1 ? "Check" : HabitCopy.amount(value, habit.checkUnit ?? "checks")
        case .task: return "Done"
        case .checklist: return "Step checked"
        }
    }

    /// Says what Undo takes back, before it's tapped (the user, 3 Oct 2026; report "Today's Rows"): always this one
    /// entry, never the day. "Undo +1 glass", "Undo 20 min", "Undo +1", "Undo Done", "Undo Slip", "Undo Cleanser".
    /// A step's is "Undo Last Step", never the step's own name: a long name pushed Today's after-log buttons off the
    /// row (the user, 9 Oct 2026). Where one step's own row is shown, `undoSpoken(for:)` names it for VoiceOver.
    func undoLabel(for habit: Habit) -> String {
        if stepID != nil { return "Undo Last Step" }
        switch habit.kind {
        case .amount: return "Undo +" + description(for: habit)
        case .duration: return "Undo " + description(for: habit)
        case .check where habit.frequency.isDayBased && habit.goal > 1:
            return "Undo +" + (habit.checkUnit.map { HabitCopy.amount(value, $0) } ?? HabitCopy.number(value))
        case .check, .task: return "Undo Done"
        case .quit: return "Undo Slip"
        case .checklist: return "Undo"
        }
    }

    /// VoiceOver's name for Undo on this log's own row (Day details' logs), where the step is the one beside it.
    func undoSpoken(for habit: Habit) -> String {
        if let stepID, let step = habit.steps.first(where: { $0.id == stepID }) { return "Undo " + step.name }
        return undoLabel(for: habit)
    }

    /// Whether this log has a fact of its own to see and correct in the Log view (U19): an amount, a time, a slip's
    /// moment, or an older record holding several checks. A single check, a step or a task is corrected where it's shown,
    /// with its own named Undo.
    func opensRecord(for habit: Habit) -> Bool {
        guard stepID == nil else { return false }
        switch habit.kind {
        case .amount, .duration, .quit: return true
        case .check: return value != 1
        case .task, .checklist: return false
        }
    }

    /// "Logged with Log manually.": where it came from, in the Log view's footer. Nil for old logs whose origin was
    /// never recorded.
    func originLine(slip: Bool) -> String? {
        guard let source else { return nil }
        let verb = slip ? "Recorded" : "Logged"
        switch source {
        case .manual: return slip ? "Recorded with Record a slip." : "Logged with Log manually."
        case .today: return "\(verb) from Today."
        case .routine: return "\(verb) in the routine player."
        case .reminder: return "\(verb) from a reminder."
        case .timer: return "\(verb) with the timer."
        case .daySheet: return "\(verb) in Day details."
        case .shortcut: return "\(verb) with Siri or Shortcuts."
        case .widget: return "\(verb) from a widget."
        case .watch: return "\(verb) on Apple Watch."
        }
    }
}

extension HabitStore {
    /// A log's clock time where it was recorded, with that zone's name when it isn't the phone's own.
    func clockText(of entry: Entry) -> String {
        let c = recordingCalendar(for: entry)
        let text = DayWords.clock(entry.createdAt, calendar: c)
        return c.timeZone == calendar.timeZone ? text : text + " " + (c.timeZone.abbreviation(for: entry.createdAt) ?? entry.timeZone)
    }

    /// A day's logs (no checklist steps), newest first by their time; logs at the same moment newest-made first.
    /// One day's handful, sorted when that day's logs change.
    func dayLogs(of habit: Habit, on day: LocalDay) -> [Entry] {
        let list = entries(of: habit.id, on: day)
        return list.indices.filter { list[$0].stepID == nil }
            .sorted { list[$0].createdAt != list[$1].createdAt ? list[$0].createdAt > list[$1].createdAt : $0 > $1 }
            .map { list[$0] }
    }
}

/// The day's status: its title ("4 of 8 glasses"), the line under it, and a running timer's start.
struct DayStatus {
    var title: String
    var detail: String?
    /// A running timer's start: the detail line becomes a live clock.
    var running: Date?

    /// " this week", " this month", " this year", or nothing for a day goal.
    static func periodWord(_ frequency: Frequency) -> String {
        switch frequency {
        case .perWeek: return " this week"
        case .perMonth: return " this month"
        case .perYear: return " this year"
        case .flexible(let period, _):
            switch period { case .week: return " this week"; case .month: return " this month"; case .year: return " this year"; case .day: return "" }
        default: return ""
        }
    }

    static func make(_ habit: Habit, on day: LocalDay, store: HabitStore) -> DayStatus {
        Maker(habit: habit, day: day, store: store).make()
    }

    private struct Maker {
        let habit: Habit
        let day: LocalDay
        let store: HabitStore

        private var isToday: Bool { day == store.today() }
        private var dayWord: String { isToday ? "today" : "this day" }
        private var shortDay: String { DayWords.short(day, calendar: store.calendar) }

        func make() -> DayStatus {
            let ruled = store.rule(habit, on: day)
            let entries = store.entries(of: habit.id, on: day).filter { $0.stepID == nil }
            if store.isPaused(habit, on: day) {
                return DayStatus(title: "Paused", detail: entries.isEmpty ? "Paused days don't count toward your streak"
                                 : "Progress already recorded stays in your history")
            }
            if store.isSkipped(habit, on: day) {
                let saved = savedText(ruled, entries: entries)
                return DayStatus(title: "Skipped", detail: (saved.map { $0 + " · " } ?? "") + "Doesn't count toward your streak")
            }
            if day < store.startDay(of: habit) { return DayStatus(title: "Before it started") }
            switch ruled.kind {
            case .quit:
                let n = entries.count
                return n == 0 ? DayStatus(title: "No slips recorded")
                    : DayStatus(title: "\(n) \(n == 1 ? "slip" : "slips") recorded", detail: "Tap a slip to see or change it")
            case .task:
                let done = store.isDone(habit, on: day)
                let last = (ruled.dueDay == nil ? entries : store.entries(of: habit.id)).last
                guard done, let last else { return DayStatus(title: done ? "Done" : "Not done") }
                let when = last.day == day ? store.clockText(of: last)
                    : DayWords.short(last.day, calendar: store.calendar) + " at " + store.clockText(of: last)
                return DayStatus(title: "Done", detail: "Completed " + (last.day == day ? "at " : "on ") + when)
            case .checklist:
                let done = Int(store.dayProgress(of: ruled, on: day)), all = ruled.steps.count
                let left = all - done
                return DayStatus(title: "\(done) of \(all) steps done",
                                 detail: left <= 0 ? "All steps done" : left == 1 ? "One step left" : "\(left) steps left")
            case .check:
                return checkStatus(ruled, entries: entries)
            case .amount, .duration:
                return amountStatus(ruled, entries: entries)
            }
        }

        private func checkStatus(_ ruled: Habit, entries: [Entry]) -> DayStatus {
            let unit = ruled.checkUnit ?? "times"
            let progress = store.dayProgress(of: ruled, on: day)
            if !ruled.frequency.isDayBased {
                // The selected day's own checks, then the period as context: never the week's total called today's.
                // Every check counts, even two on one day (Current Work 54).
                let period = store.progress(of: habit, on: day), goal = store.goal(of: habit)
                return DayStatus(title: progress > 0 ? HabitCopy.amount(progress, unit) + " " + dayWord : "Not checked " + dayWord,
                                 detail: "\(HabitCopy.number(period)) of \(HabitCopy.amount(goal, unit))" + DayStatus.periodWord(ruled.frequency))
            }
            if store.countsUp(habit, on: day) {
                let goal = store.dayGoal(of: ruled), left = goal - progress
                let detail = left <= 0 ? "Goal reached"
                    : isToday ? (left == 1 ? "One more reaches today's goal" : "\(HabitCopy.number(left)) more reach today's goal")
                    : "For " + shortDay
                return DayStatus(title: "\(HabitCopy.number(progress)) of \(HabitCopy.amount(goal, unit))", detail: detail)
            }
            let done = store.isDayMet(ruled, on: day)
            if case .flexible(_, let needed) = ruled.frequency, let count = store.flexibleProgress(habit, on: day) {
                return DayStatus(title: done ? "Done" : "Not done",
                                 detail: "\(count) of \(needed) \(needed == 1 ? "day" : "days")" + DayStatus.periodWord(ruled.frequency))
            }
            if done, let last = entries.last { return DayStatus(title: "Done", detail: "Checked at " + store.clockText(of: last)) }
            return DayStatus(title: done ? "Done" : "Not done")
        }

        private func amountStatus(_ ruled: Habit, entries: [Entry]) -> DayStatus {
            let timed = ruled.kind == .duration
            let unit = HabitCopy.unit(of: ruled)
            func text(_ v: Double) -> String { timed ? Format.minutes(v.rounded(.down)) : HabitCopy.amount(v, unit) }
            // What's saved; a running timer's time shows as its own clock, not folded into a number that can't tick.
            let saved = entries.reduce(0) { $0 + $1.value }
            let running = timed && isToday ? store.timers[habit.id] : nil
            let goal = store.dayGoal(of: ruled)
            if store.isTotal(ruled) {
                let total = store.progress(of: habit, on: day)
                let period = DayStatus.periodWord(ruled.frequency)
                return DayStatus(title: "\(text(saved)) \(dayWord)",
                                 detail: ruled.atMost ? "\(text(total))\(period) · limit \(text(goal))" : "\(text(total)) of \(text(goal))\(period)",
                                 running: running)
            }
            if ruled.atMost {
                // A limit is a fact, not a bar to fill: no "to go", no colour, nothing about going over (U3/U16).
                return DayStatus(title: "\(text(saved)) \(dayWord)",
                                 detail: "Limit \(text(goal))" + (saved <= goal ? " · within limit" : ""), running: running)
            }
            let title = timed
                ? (goal < 60 && saved < 60 ? "\(Int(saved.rounded(.down))) of \(Format.minutes(goal))" : "\(text(saved)) of \(Format.minutes(goal))")
                : (HabitCopy.currencies.contains(unit.trimmingCharacters(in: .whitespaces))
                   ? "\(HabitCopy.amount(saved, unit)) of \(HabitCopy.amount(goal, unit))"
                   : "\(HabitCopy.number(saved)) of \(HabitCopy.amount(goal, unit))")
            // While the timer runs, its clock is the detail: "to go" from the saved time alone would be wrong.
            var detail = running != nil ? nil : saved >= goal ? "Goal reached" : isToday ? "\(text(goal - saved)) to go" : "For " + shortDay
            // Some days a week: the days count too (it was in the routine player's Habit options, U5).
            if case .flexible(_, let needed) = ruled.frequency, let count = store.flexibleProgress(habit, on: day) {
                let days = "\(count) of \(needed) \(needed == 1 ? "day" : "days")" + DayStatus.periodWord(ruled.frequency)
                detail = detail.map { $0 + " · " + days } ?? days
            }
            return DayStatus(title: title, detail: detail, running: running)
        }

        /// "2 glasses saved": what a skipped day keeps.
        private func savedText(_ ruled: Habit, entries: [Entry]) -> String? {
            guard !entries.isEmpty else { return nil }
            let total = entries.reduce(0) { $0 + $1.value }
            switch ruled.kind {
            case .amount(let unit, _): return HabitCopy.amount(total, unit) + " saved"
            case .duration: return Format.minutes(total) + " saved"
            case .check where store.countsUp(habit, on: day): return HabitCopy.amount(total, ruled.checkUnit ?? "checks") + " saved"
            default: return nil
            }
        }
    }
}
