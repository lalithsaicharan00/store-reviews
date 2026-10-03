import Foundation

// The habit page's History, Overall record, comparisons and milestones (the user, 3 Oct 2026; research "Habit Details
// Research"; checklist `Docs/Checklists/Habit Details Page — Build.md`). Worked out here from the records, once per data
// change (the page asks when its data version changes), never in a view's body (Rulebook S5). Nothing here is stored,
// so an edit, an undo or a restored backup can never leave a number that disagrees with the history.

/// One row of a habit's History: a day that was scheduled, or has an entry, a skip or a note.
struct HistoryDay: Hashable, Identifiable {
    let day: LocalDay
    /// The day's square, the same as Progress's.
    let heat: HeatCell
    /// "Sat 3".
    let title: String
    /// "Today", "Yesterday", or nil.
    let relative: String?
    /// "500 of 2,000 ml · 2 entries", "Skipped", "Nothing logged".
    let detail: String
    let hasNote: Bool
    var id: LocalDay { day }
}

/// One month's card in History, newest first.
struct HistoryMonth: Hashable, Identifiable {
    let first: LocalDay
    /// "October 2026".
    let title: String
    /// The month on the goal's own clock, as Progress's Month card says it: "Reached on 22 of 27 days".
    let summary: String
    /// Newest first.
    let days: [HistoryDay]
    /// Unique across the page's tabs, which share one lazy stack (lesson L11).
    var id: String { "history-" + first.key }
}

/// The Overall record card: the accumulated record since the habit began (research Progress revised, Overall record).
struct HabitOverall: Hashable {
    /// The main fact: "84 h 45 min recorded", "Done on 196 days".
    let headline: String
    /// The goal result with its denominator: "Goal met on 196 of 249 planned days"; nil when it would repeat the
    /// headline or nothing has ended yet.
    let detail: String?
    /// Goals met and goals that could be met (ended planned days or periods), for the optional percentage.
    let met: Int
    let eligible: Int
    /// "Since 1 Jan 2026".
    let since: String
    /// "Best day 26 laps · 6 Jan"; nil for once-a-day habits, where every done day is the same.
    let best: String?
    /// The day (or week, month) each goal-met count was reached: `metDates[k]` is when the total reached k + 1.
    let metDates: [LocalDay]
    /// "days", "weeks", "months": the unit of `met`.
    let unit: String
}

/// This period against the one before, on the same footing (research Progress revised, default comparisons): an open
/// period compares the same number of completed days; a period with nothing before it says so instead of a zero.
struct PeriodComparison: Hashable {
    /// "Same 3 days last week", "Last week", "Same 12 days last month".
    let title: String
    let thisLabel: String
    let previousLabel: String
    let thisText: String
    let previousText: String
    /// The two values on one scale, for the bars; nil for counts of days ("4 of 5 days"), which bars would mislead.
    let thisValue: Double?
    let previousValue: Double?
    /// "No earlier week to compare" when there's nothing before; then the rows are hidden.
    let note: String?
}

/// One milestone in a track.
struct MilestoneStep: Hashable, Identifiable {
    let value: Int
    /// The day it was reached, from the records; nil while not reached.
    let reached: LocalDay?
    var id: Int { value }
}

/// A row of milestones (report "Milestones on the Habit Page", 3 Oct 2026): in a row, or in total.
struct MilestoneTrack: Hashable, Identifiable {
    enum Kind: Hashable { case inARow, inTotal, sinceSlip }
    let kind: Kind
    /// "In a row", "In total", "Since the last slip".
    let title: String
    /// "days", "weeks", "times".
    let unit: String
    /// Where the person is now: the current run, the total, or days since the last slip.
    let current: Int
    /// The best run (in a row) or nil.
    let best: Int?
    let steps: [MilestoneStep]
    var id: Kind { kind }

    /// The first milestone not reached yet.
    var next: MilestoneStep? { steps.first { $0.reached == nil } }
}

extension HabitStore {
    // MARK: History

    /// Every month with a row, newest first. A row for each scheduled day up to today (the user, 3 Oct 2026: "each day
    /// whenever scheduled and whenever they log something"), and every day with an entry, a skip or a note. A quit habit
    /// has no scheduled days: its rows are slips and notes (research: never invent "no slip" rows). An unlogged
    /// scheduled day says "Nothing logged": not proof it wasn't done (research; Rulebook U3).
    func history(of habit: Habit, today: LocalDay) -> [HistoryMonth] {
        let start = habit.kind == .quit ? quitStartDay(of: habit) : startDay(of: habit)
        guard start <= today else { return [] }
        let monthNames = calendar.standaloneMonthSymbols
        let shortDays = calendar.shortStandaloneWeekdaySymbols
        let yesterday = today.adding(days: -1, calendar: calendar)
        let now = clock()
        var months: [HistoryMonth] = []
        var first = LocalDay(year: today.year, month: today.month, day: 1)
        while true {
            let span = period(.month, containing: first)
            if span.upperBound < start { break }
            let card = habit.kind == .quit ? weekQuitCard(habit, in: span, range: .month, today: today, now: now)
                : weekCard(habit, in: span, range: .month, today: today)
            let count = span.lowerBound.days(to: span.upperBound, calendar: calendar) + 1
            let heat = card.flatMap { $0.days.count == count ? $0.days.map(\.heat) : nil }
            var rows: [HistoryDay] = []
            var day = min(span.upperBound, today)
            let earliest = max(span.lowerBound, start)
            while day >= earliest {
                let entries = self.entries(of: habit.id, on: day)
                let hasNote = note(of: habit, on: day) != nil
                let skipped = isSkipped(habit, on: day)
                let due = habit.kind != .quit && rule(habit, on: day).frequency.isDayBased && isDue(habit, on: day)
                if due || !entries.isEmpty || hasNote || skipped {
                    let index = span.lowerBound.days(to: day, calendar: calendar)
                    rows.append(HistoryDay(
                        day: day,
                        heat: heat.map { index < $0.count ? $0[index] : .blank } ?? .blank,
                        title: "\(shortDays[day.weekday(calendar: calendar) - 1]) \(day.day)",
                        relative: day == today ? "Today" : day == yesterday ? "Yesterday" : nil,
                        detail: historyDetail(habit, on: day, entries: entries, skipped: skipped, today: today),
                        hasNote: hasNote))
                }
                day = day.adding(days: -1, calendar: calendar)
            }
            if !rows.isEmpty {
                let title = monthNames[first.month - 1] + " \(first.year)"
                months.append(HistoryMonth(first: first, title: title, summary: card?.headline ?? "", days: rows))
            }
            first = span.lowerBound.adding(days: -1, calendar: calendar)
            first = LocalDay(year: first.year, month: first.month, day: 1)
        }
        return months
    }

    /// What a History row says about its day.
    private func historyDetail(_ habit: Habit, on day: LocalDay, entries: [Entry], skipped: Bool, today: LocalDay) -> String {
        if isPaused(habit, on: day) && entries.isEmpty { return "Paused" }
        if skipped { return "Skipped" }
        if entries.isEmpty {
            if habit.kind == .quit { return "Note only" }
            return day == today ? "Nothing logged yet" : "Nothing logged"
        }
        if habit.kind == .quit { return entries.count == 1 ? "1 slip" : "\(entries.count) slips" }
        let result = dayResult(habit, on: day)
        let counted = entries.filter { $0.stepID == nil }.count
        let kind = rule(habit, on: day).kind
        // The number of entries matters where one day can hold several (amounts, time, counts).
        switch kind {
        case .amount, .duration: return counted == 1 ? result + " · 1 entry" : result + " · \(counted) entries"
        case .check where dayGoal(of: rule(habit, on: day)) > 1 && counted > 1: return result + " · \(counted) entries"
        default: return result
        }
    }

    // MARK: Overall record

    /// The habit's accumulated record since it began, walked once per data change.
    func habitRecord(of habit: Habit, today: LocalDay) -> HabitOverall {
        let start = startDay(of: habit)
        let since = "Since " + start.date(calendar: calendar).formatted(.dateTime.day().month(.abbreviated).year())
        let now = rule(habit, on: today)
        let shape = progressShape(now)
        let kind = periodKind(now)
        guard start <= today else {
            return HabitOverall(headline: "Not started yet", detail: nil, met: 0, eligible: 0, since: since, best: nil,
                               metDates: [], unit: "days")
        }
        var total = 0.0
        var bestValue = 0.0, bestDay: LocalDay?
        var doneDays = 0
        var met = 0, eligible = 0
        var metDates: [LocalDay] = []
        var day = start
        // Day by day: the amount recorded, and for day goals, each planned day that has ended (today only once met).
        while day <= today {
            let rule = rule(habit, on: day)
            let value = dayProgress(of: rule, on: day)
            total += value
            if value > bestValue { bestValue = value; bestDay = day }
            if value > 0 { doneDays += 1 }
            if periodKind(rule) == .day && !isPaused(habit, on: day) && !isSkipped(habit, on: day) && isDue(habit, on: day) {
                let isMet = isDayMet(habit, on: day)
                if day < today || isMet {
                    eligible += 1
                    if isMet { met += 1; metDates.append(day) }
                }
            }
            day = day.adding(days: 1, calendar: calendar)
        }
        // Week, month or year goals: each period that has ended, and the running one once it's met.
        if kind != .day {
            met = 0; eligible = 0; metDates = []
            var day = start
            while day <= today {
                let rule = rule(habit, on: day)
                guard let range = periodRange(rule, containing: day) else { day = day.adding(days: 1, calendar: calendar); continue }
                let ended = range.upperBound < today
                let isMet = !(rule.atMost && !ended) && isPeriodMet(habit, on: day)
                if (ended && !hasPause(habit, in: range)) || isMet {
                    eligible += 1
                    if isMet { met += 1; metDates.append(min(range.upperBound, today)) }
                }
                day = range.upperBound.adding(days: 1, calendar: calendar)
            }
        }
        let unit = kind == .week ? "weeks" : kind == .month ? "months" : kind == .year ? "years" : "days"
        func plannedDays(_ n: Int) -> String { n == 1 ? "1 planned day" : "\(n) planned days" }
        func periods(_ n: Int) -> String {
            let word = kind == .week ? "week" : kind == .month ? "month" : "year"
            return n == 1 ? "1 \(word)" : "\(n) \(word)s"
        }
        let headline: String
        var detail: String?
        switch shape {
        case .once:
            headline = doneDays == 1 ? "Done on 1 day" : "Done on \(doneDays) days"
            detail = eligible > 0 ? "Goal met on \(met) of \(plannedDays(eligible))" : nil
        case .checklist:
            headline = met == 1 ? "Every step on 1 day" : "Every step on \(met) days"
            detail = HabitCopy.amount(total, "steps") + " done in all"
        case .times, .amount, .time:
            headline = progressValue(total, now) + " recorded"
            detail = eligible > 0 ? "Goal met on \(met) of \(plannedDays(eligible))" : nil
        case .limitDay:
            headline = progressValue(total, now) + " recorded"
            detail = eligible > 0 ? "Within the limit on \(met) of \(eligible == 1 ? "1 day" : "\(eligible) days")" : nil
        case .periodTimes, .periodTotal, .periodDays:
            headline = (now.kind == .check ? HabitCopy.amount(total, now.checkUnit ?? "times") : progressValue(total, now)) + " recorded"
            detail = eligible > 0 ? "Goal met in \(met) of \(periods(eligible))" : nil
        case .limitPeriod:
            headline = progressValue(total, now) + " recorded"
            detail = eligible > 0 ? "Within the limit in \(met) of \(periods(eligible))" : nil
        }
        var best: String?
        if let bestDay, shape != .once, shape != .checklist, !now.atMost, bestValue > 0 {
            best = "Best day " + progressValue(bestValue, rule(habit, on: bestDay)) + " · "
                + bestDay.date(calendar: calendar).formatted(.dateTime.day().month(.abbreviated))
        }
        return HabitOverall(headline: headline, detail: detail, met: met, eligible: eligible, since: since, best: best,
                           metDates: metDates, unit: unit)
    }

    // MARK: Comparisons

    /// `span` against the period before it. While `span` is running, both sides cover the same completed days (today,
    /// still open, is left out of both); a habit that began after the earlier period started has nothing to compare.
    func periodComparison(of habit: Habit, in span: ClosedRange<LocalDay>, noun: String, today: LocalDay) -> PeriodComparison? {
        let start = habit.kind == .quit ? quitStartDay(of: habit) : startDay(of: habit)
        guard span.lowerBound <= today else { return nil }
        let previousStart = (noun == "week" ? span.lowerBound.adding(days: -7, calendar: calendar)
                             : period(.month, containing: span.lowerBound.adding(days: -1, calendar: calendar)).lowerBound)
        let previousFull = period(noun == "week" ? .week : .month, containing: previousStart)
        let running = span.contains(today)
        let completed = running ? span.lowerBound.days(to: today, calendar: calendar) : span.lowerBound.days(to: span.upperBound, calendar: calendar) + 1
        let thisLabel = running ? "This \(noun)" : (noun == "week" ? "That week" : monthName(span.lowerBound))
        let previousLabel = noun == "week" ? (running ? "Last week" : "The week before") : monthName(previousFull.lowerBound)
        if previousFull.lowerBound < start {
            return PeriodComparison(title: "Compared with the \(noun) before", thisLabel: thisLabel, previousLabel: previousLabel,
                                    thisText: "", previousText: "", thisValue: nil, previousValue: nil,
                                    note: "No earlier \(noun) to compare")
        }
        guard completed > 0 else {
            return PeriodComparison(title: "Compared with last \(noun)", thisLabel: thisLabel, previousLabel: previousLabel,
                                    thisText: "", previousText: "", thisValue: nil, previousValue: nil,
                                    note: "Compared once today is over")
        }
        let thisRange = span.lowerBound...span.lowerBound.adding(days: completed - 1, calendar: calendar)
        let previousLength = previousStart.days(to: previousFull.upperBound, calendar: calendar) + 1
        let previousRange = previousStart...previousStart.adding(days: min(completed, previousLength) - 1, calendar: calendar)
        let title: String
        if running {
            title = completed == 1 ? "Same first day last \(noun)" : "Same \(completed) days last \(noun)"
        } else {
            title = noun == "week" ? "Compared with the week before" : "Compared with the month before"
        }
        let rule = rule(habit, on: min(thisRange.upperBound, today))
        let shape = progressShape(rule)
        func amount(_ range: ClosedRange<LocalDay>) -> Double {
            days(in: range).reduce(0) { $0 + dayProgress(of: self.rule(habit, on: $1), on: $1) }
        }
        func goalDays(_ range: ClosedRange<LocalDay>) -> (met: Int, planned: Int) {
            var met = 0, planned = 0
            for day in days(in: range) where isDue(habit, on: day) {
                planned += 1
                if isDayMet(habit, on: day) { met += 1 }
            }
            return (met, planned)
        }
        if habit.kind == .quit {
            let a = days(in: thisRange).reduce(0) { $0 + entries(of: habit.id, on: $1).count }
            let b = days(in: previousRange).reduce(0) { $0 + entries(of: habit.id, on: $1).count }
            func slips(_ n: Int) -> String { n == 1 ? "1 slip" : "\(n) slips" }
            return PeriodComparison(title: title, thisLabel: thisLabel, previousLabel: previousLabel, thisText: slips(a),
                                    previousText: slips(b), thisValue: Double(a), previousValue: Double(b), note: nil)
        }
        switch shape {
        case .once, .checklist:
            let a = goalDays(thisRange), b = goalDays(previousRange)
            func text(_ x: (met: Int, planned: Int)) -> String { "\(x.met) of \(x.planned == 1 ? "1 day" : "\(x.planned) days")" }
            return PeriodComparison(title: title, thisLabel: thisLabel, previousLabel: previousLabel, thisText: text(a),
                                    previousText: text(b), thisValue: Double(a.met), previousValue: Double(b.met), note: nil)
        default:
            let a = amount(thisRange), b = amount(previousRange)
            let text: (Double) -> String = { value in
                rule.kind == .check ? HabitCopy.amount(value, rule.checkUnit ?? "times") : self.progressValue(value, rule)
            }
            return PeriodComparison(title: title, thisLabel: thisLabel, previousLabel: previousLabel, thisText: text(a),
                                    previousText: text(b), thisValue: a, previousValue: b, note: nil)
        }
    }

    private func monthName(_ day: LocalDay) -> String { calendar.standaloneMonthSymbols[day.month - 1] }

    // MARK: Milestones

    /// The milestone tracks for a habit (report "Milestones on the Habit Page", 3 Oct 2026): in a row, from the runs;
    /// in total, from the goals met; for a quit habit, time since the last slip. Every date comes from the records.
    func milestoneTracks(of habit: Habit, record: HabitOverall, today: LocalDay) -> [MilestoneTrack] {
        if habit.kind == .quit {
            let now = clock()
            let history = quitHistory(of: habit, now: now)
            let current = history.last.map { $0.endedBy == .ongoing ? Int($0.length(now: now) / 86400) : 0 } ?? 0
            let best = Int((history.map { $0.length(now: now) }.max() ?? 0) / 86400)
            let ladder = Self.quitMilestones(upTo: best).prefix { $0 <= max(best, 365) * 2 }
            let steps = ladder.map { n -> MilestoneStep in
                // Reached in the first run long enough: its start plus n days.
                let run = history.first { Int($0.length(now: now) / 86400) >= n }
                let date = run.map { self.today(now: $0.start.addingTimeInterval(Double(n) * 86400)) }
                return MilestoneStep(value: n, reached: date)
            }
            return [MilestoneTrack(kind: .sinceSlip, title: "Since the last slip", unit: "days", current: current, best: best,
                                   steps: Array(steps))]
        }
        guard habit.kind != .task else { return [] }
        var tracks: [MilestoneTrack] = []
        let unit = rule(habit, on: today).frequency.streakUnit
        let runs = runs(of: habit, today: today)
        let current = runs.last.map { $0.isCurrent ? $0.length : 0 } ?? 0
        let best = runs.map(\.length).max() ?? 0
        let ladder = unit.ladder(upTo: best)
        let steps = ladder.map { n -> MilestoneStep in
            guard let run = runs.first(where: { $0.length >= n }) else { return MilestoneStep(value: n, reached: nil) }
            return MilestoneStep(value: n, reached: nthCounted(n, of: habit, in: run, unit: unit, today: today))
        }
        tracks.append(MilestoneTrack(kind: .inARow, title: "In a row", unit: unit.plural, current: current, best: best, steps: steps))
        let totalLadder = [10, 25, 50, 100, 250, 500, 1000, 2500, 5000].filter { $0 <= max(record.met, 1000) * 5 }
        let totalSteps = totalLadder.map { n in
            MilestoneStep(value: n, reached: n <= record.metDates.count ? record.metDates[n - 1] : nil)
        }
        tracks.append(MilestoneTrack(kind: .inTotal, title: "In total", unit: record.unit == "days" ? "times" : record.unit,
                                     current: record.met, best: nil, steps: totalSteps))
        return tracks
    }

    /// The day a run reached its `n`th counted day (or week, month): walked from the run's start.
    private func nthCounted(_ n: Int, of habit: Habit, in run: Run, unit: StreakUnit, today: LocalDay) -> LocalDay? {
        var count = 0
        var day = run.start
        while day <= run.end {
            let rule = rule(habit, on: day)
            if periodKind(rule) == .day {
                if (isDue(habit, on: day) || day == today) && isDayMet(habit, on: day) { count += 1 }
                if count == n { return day }
                day = day.adding(days: 1, calendar: calendar)
            } else {
                guard let range = periodRange(rule, containing: day) else { day = day.adding(days: 1, calendar: calendar); continue }
                if isPeriodMet(habit, on: day) { count += 1 }
                if count == n { return min(range.upperBound, today) }
                day = range.upperBound.adding(days: 1, calendar: calendar)
            }
        }
        return nil
    }
}

extension StreakUnit {
    /// "days", "times", "weeks"…
    var plural: String {
        switch self {
        case .days: "days"
        case .times: "times"
        case .weeks: "weeks"
        case .months: "months"
        case .years: "years"
        }
    }

    /// The milestones in a row a habit page shows: every one up to the best, then the next few.
    func ladder(upTo best: Int) -> [Int] {
        var values: [Int] = []
        var n = 1
        while values.count < 64 {
            if isMilestone(n) { values.append(n) }
            if n > best && values.filter({ $0 > best }).count >= 3 { break }
            n += 1
        }
        return values
    }
}
