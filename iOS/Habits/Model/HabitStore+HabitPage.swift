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

/// One box of the Overall record (spec "Habit Progress — Overall Record, Streaks and Milestones" §2): its label, the
/// number with its unit after it, and an optional line under it. Every string is made here, once per data change (S8).
struct RecordFact: Hashable {
    /// "Current streak", "Best streak", "Goal met", "Best day".
    let title: String
    /// "6", "2 h 43 min", "$40".
    let number: String
    /// "days", "of 38 days", "min"; empty when the number says it all.
    let unit: String
    /// "26 Sep – 1 Oct", "This week: 2 of 3".
    let detail: String?
    /// "Best streak, 6 days, 26 September to 1 October" (spec §3.3).
    let spoken: String
}

/// The Overall record card: the accumulated record since the habit began (research Progress revised, Overall record),
/// with the streaks in it (spec §2).
struct HabitOverall: Hashable {
    /// The main fact in parts, so the value can be large and the words small: "Done on" · "196" · "days",
    /// "" · "2 h 43 min" · "recorded".
    let lead: String
    let value: String
    let trail: String
    /// Goals met and goals that could be met (ended planned days or periods of today's goal's kind, E2), for the
    /// optional percentage.
    let met: Int
    let eligible: Int
    /// "Since 1 Jan 2026".
    let since: String
    /// Current and best streak in today's goal's unit; nil for nothing (quit habits have their own card).
    let current: RecordFact?
    let best: RecordFact?
    /// "Goal met" / "Every step" / "Within the limit" · "7" · "of 38 days"; nil until a planned day or period has ended.
    let goalMet: RecordFact?
    /// "of planned days", "of days", "of weeks": after the percentage ("18% of planned days").
    let percentNoun: String
    /// "Best day" (amounts, time, several checks a day) or "Best week / month / year" (period goals); nil otherwise.
    let bestPeriod: RecordFact?
    /// The day each goal of today's kind was met (the day its goal was reached, E3): `metDates[k]` is when the total
    /// reached k + 1.
    let metDates: [LocalDay]
    /// Every kind of goal period the habit has had, for the milestones of earlier goals (E1).
    let kinds: Set<GoalPeriod>

    /// "Done on 196 days", "84 h 45 min recorded".
    var headline: String { [lead, value, trail].filter { !$0.isEmpty }.joined(separator: " ") }
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

/// One milestone reached (spec §3): a medal. Worked out from the records each time (never stored, E8); a value is
/// reached once, dated by the first run that reached it (E7), and earlier goals keep theirs in their own unit (E1).
struct Milestone: Hashable, Identifiable {
    enum Track: String, Hashable { case inARow, inTotal, sinceSlip }
    let track: Track
    let value: Int
    let reached: LocalDay
    /// On the medal: "30", or "1" for a year since a slip.
    let number: String
    /// "3 days in a row", "10 weeks of goals met", "30 days since a slip".
    let title: String
    /// The shelf's two lines: "30 in a row" / "20 Jan" for day goals, "8 weeks" / "in a row" for period goals.
    let shelfTop: String
    let shelfBottom: String
    /// The All milestones page: "30 days" / "20 Jan 2026".
    let pageCaption: String
    let pageDate: String
    /// "Reached 28 Sep".
    let reachedText: String
    /// "3 days in a row, reached 28 September 2026".
    let spoken: String
    /// Unique across eras: "inARow-weeks-8".
    let id: String
}

/// A track's next milestone (spec §3.1): only the next one is drawn, never the ones after it.
struct MilestoneNext: Hashable, Identifiable {
    let track: Milestone.Track
    /// The ring's number; nil once every milestone of the track is reached.
    let target: Int?
    let number: String
    /// "7 days in a row", "Every milestone reached".
    let title: String
    /// The All page's row: "Next: 50 days in a row".
    let pageTitle: String
    /// "32 to go · now 18, best 41", "3 to go · 7 so far".
    let detail: String?
    /// Current ÷ target: the current run against the next in-a-row milestone, the total against the next total one.
    let fraction: Double
    /// "Next: 50 days in a row, 32 to go. Now 18, best 41."
    let spoken: String
    var id: Milestone.Track { track }
}

/// Everything the Milestones card and the All milestones page show.
struct HabitMilestones: Hashable {
    /// Every milestone reached, newest first (every track and every goal there has been).
    let reached: [Milestone]
    /// One per track: In a row, then In total (quit habits: Since a slip).
    let next: [MilestoneNext]

    static let none = HabitMilestones(reached: [], next: [])

    /// Show Streaks off: no in-a-row medals or Next row (E9), and no days since a slip (a quit habit's run); a total a
    /// break can't take away stays.
    func shown(streaks: Bool) -> HabitMilestones {
        streaks ? self : HabitMilestones(reached: reached.filter { $0.track == .inTotal }, next: next.filter { $0.track == .inTotal })
    }
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
            return HabitOverall(lead: "", value: "Not started yet", trail: "", met: 0, eligible: 0, since: since, current: nil,
                                best: nil, goalMet: nil, percentNoun: "", bestPeriod: nil, metDates: [], kinds: [kind])
        }
        var total = 0.0
        var bestValue = 0.0, bestDay: LocalDay?
        var doneDays = 0
        var kinds: Set<GoalPeriod> = []
        var day = start
        while day <= today {
            let rule = rule(habit, on: day)
            kinds.insert(periodKind(rule))
            let value = dayProgress(of: rule, on: day)
            total += value
            if value > bestValue { bestValue = value; bestDay = day }
            if value > 0 { doneDays += 1 }
            day = day.adding(days: 1, calendar: calendar)
        }
        // Goals met count only periods of today's kind (E2), each dated the day its goal was reached (E3).
        let tally = goalTally(of: habit, kind: kind, today: today, best: kind != .day && !now.atMost)

        var lead = "", value = "", trail = ""
        switch shape {
        case .once:
            lead = "Done on"; value = HabitCopy.number(Double(doneDays)); trail = doneDays == 1 ? "day" : "days"
        case .checklist:
            value = HabitCopy.number(total); trail = HabitCopy.unitWord(total, "steps") + " done"
        default:
            let parts = amountParts(total, now)
            value = parts.number; trail = parts.unit.isEmpty ? "recorded" : parts.unit + " recorded"
        }

        // The streak, in today's goal's unit, as Today's row counts it (`runs`, `streak`).
        let unit = now.frequency.streakUnit
        let runs = runs(of: habit, today: today)
        let current = runs.last.map { $0.isCurrent ? $0.length : 0 } ?? 0
        let best = runs.map(\.length).max() ?? 0
        let bestRun = best > 0 ? runs.last(where: { $0.length == best }) : nil
        // A period goal's running week (month, year), so "3 weeks" doesn't look stale midweek; limits wait for the end.
        var thisPeriod: String?
        if kind != .day, !now.atMost, let range = periodRange(now, containing: today) {
            let name = "This " + kind.noun + ": "
            if isPeriodMet(habit, on: today) {
                thisPeriod = name + "done"
            } else if case .flexible(_, let needed) = now.frequency {
                thisPeriod = name + "\(flexibleProgress(now, on: today) ?? 0) of \(needed) days"
            } else if isTotal(now) {
                thisPeriod = name + progressValue(periodTotal(now, in: range), now) + " of " + progressValue(now.goal, now)
            } else {
                thisPeriod = name + HabitCopy.number(periodCount(now, in: range)) + " of " + HabitCopy.number(goal(of: now))
            }
        }
        let currentFact = RecordFact(title: "Current streak", number: HabitCopy.number(Double(current)), unit: unit.word(current),
                                     detail: thisPeriod,
                                     spoken: "Current streak, \(current) \(unit.word(current))" + (thisPeriod.map { ". " + $0 } ?? ""))
        let bestFact = RecordFact(title: "Best streak", number: HabitCopy.number(Double(best)), unit: unit.word(best),
                                  detail: bestRun.map { daySpan($0.start...$0.end, today: today) },
                                  spoken: "Best streak, \(best) \(unit.word(best))" + (bestRun.map { ", " + spokenSpan($0.start...$0.end, today: today) } ?? ""))

        func periods(_ n: Int) -> String {
            switch kind {
            case .day: n == 1 ? "day" : "days"
            case .week: n == 1 ? "week" : "weeks"
            case .month: n == 1 ? "month" : "months"
            case .year: n == 1 ? "year" : "years"
            }
        }
        let goalTitle = shape == .checklist ? "Every step" : now.atMost ? "Within the limit" : "Goal met"
        let goalMet = tally.eligible > 0
            ? RecordFact(title: goalTitle, number: HabitCopy.number(Double(tally.met)), unit: "of \(tally.eligible) \(periods(tally.eligible))",
                         detail: nil, spoken: "\(goalTitle), \(tally.met) of \(tally.eligible) \(periods(tally.eligible))")
            : nil
        let percentNoun = kind == .day ? (now.atMost ? "of days" : "of planned days") : "of " + periods(2)

        // Best day: only where a day can hold more than one (amounts, time, several checks a day). Best week, month or
        // year for a period goal: the period with the most recorded. Limits have neither.
        var bestPeriod: RecordFact?
        let countsAmounts = now.kind == .duration || { if case .amount = now.kind { return true }; return false }()
            || (now.kind == .check && dayGoal(of: now) > 1)
        if kind == .day, let bestDay, countsAmounts, !now.atMost, bestValue > 0 {
            let parts = amountParts(bestValue, rule(habit, on: bestDay))
            let date = shortDate(bestDay, today: today)
            bestPeriod = RecordFact(title: "Best day", number: parts.number, unit: parts.unit, detail: date,
                                    spoken: "Best day, " + [parts.number, parts.unit].filter { !$0.isEmpty }.joined(separator: " ")
                                        + ", " + spokenDate(bestDay, today: today))
        } else if kind != .day, let range = tally.bestRange, tally.bestValue > 0 {
            let parts = amountParts(tally.bestValue, now)
            let dates: String, spoken: String
            switch kind {
            case .week:
                dates = daySpan(range, today: today); spoken = spokenSpan(range, today: today)
            case .month:
                let year = range.lowerBound.year == today.year ? "" : " \(range.lowerBound.year)"
                dates = calendar.shortStandaloneMonthSymbols[range.lowerBound.month - 1] + year
                spoken = calendar.standaloneMonthSymbols[range.lowerBound.month - 1] + year
            default:
                dates = "\(range.lowerBound.year)"; spoken = dates
            }
            bestPeriod = RecordFact(title: "Best " + kind.noun, number: parts.number, unit: parts.unit, detail: dates,
                                    spoken: "Best \(kind.noun), " + [parts.number, parts.unit].filter { !$0.isEmpty }.joined(separator: " ")
                                        + ", " + spoken)
        }
        return HabitOverall(lead: lead, value: value, trail: trail, met: tally.met, eligible: tally.eligible, since: since,
                            current: currentFact, best: bestFact, goalMet: goalMet, percentNoun: percentNoun,
                            bestPeriod: bestPeriod, metDates: tally.dates, kinds: kinds)
    }

    /// Goals met in `kind`'s periods, out of those that could be met: each planned day (or week, month, year) that has
    /// ended, and the running one once met. Only periods of that kind count (E2: days under an earlier day goal never
    /// count as weeks), each dated the day its goal was reached (E3). `best`: also the period with the most recorded.
    struct GoalTally {
        var met = 0
        var eligible = 0
        var dates: [LocalDay] = []
        var bestValue = 0.0
        var bestRange: ClosedRange<LocalDay>?
    }

    func goalTally(of habit: Habit, kind: GoalPeriod, today: LocalDay, best: Bool = false) -> GoalTally {
        var tally = GoalTally()
        let start = startDay(of: habit)
        var day = start
        if kind == .day {
            while day <= today {
                let rule = rule(habit, on: day)
                if periodKind(rule) == .day && !isPaused(habit, on: day) && !isSkipped(habit, on: day) && isDue(habit, on: day) {
                    let isMet = isDayMet(habit, on: day)
                    if day < today || isMet {
                        tally.eligible += 1
                        if isMet { tally.met += 1; tally.dates.append(day) }
                    }
                }
                day = day.adding(days: 1, calendar: calendar)
            }
            return tally
        }
        while day <= today {
            let rule = rule(habit, on: day)
            guard periodKind(rule) == kind, let range = periodRange(rule, containing: day) else {
                day = day.adding(days: 1, calendar: calendar)
                continue
            }
            let ended = range.upperBound < today
            let isMet = !(rule.atMost && !ended) && isPeriodMet(habit, on: day)
            if (ended && !hasPause(habit, in: range)) || isMet {
                tally.eligible += 1
                if isMet { tally.met += 1; tally.dates.append(metDay(of: habit, rule: rule, in: range, today: today)) }
            }
            if best {
                var value = 0.0
                var d = max(range.lowerBound, start)
                while d <= min(range.upperBound, today) {
                    value += dayProgress(of: self.rule(habit, on: d), on: d)
                    d = d.adding(days: 1, calendar: calendar)
                }
                if value > tally.bestValue { tally.bestValue = value; tally.bestRange = range }
            }
            day = range.upperBound.adding(days: 1, calendar: calendar)
        }
        return tally
    }

    /// The day a week's (month's, year's) goal was reached: the day of the log that met it (E3), never the period's
    /// last day or today. A limit is kept when its period ends.
    private func metDay(of habit: Habit, rule: Habit, in range: ClosedRange<LocalDay>, today: LocalDay) -> LocalDay {
        let last = min(range.upperBound, today)
        guard !rule.atMost else { return last }
        let needed: Double
        if case .flexible(_, let n) = rule.frequency { needed = Double(n) } else { needed = isTotal(rule) ? rule.goal : goal(of: rule) }
        // As `periodCount` and `periodTotal` count: days met, or what was logged.
        let countsDays = rule.frequency.isFlexible || !(isTotal(rule) || rule.kind == .check)
        var sum = 0.0
        var day = max(range.lowerBound, startDay(of: habit))
        while day <= last {
            if countsDays {
                if isDayMet(habit, on: day) { sum += 1 }
            } else {
                sum += entries(of: habit.id, on: day).lazy.filter { $0.stepID == nil }.reduce(0) { $0 + $1.value }
            }
            if sum >= needed { return day }
            day = day.adding(days: 1, calendar: calendar)
        }
        return last
    }

    /// A value as a large number and a small unit: "46" / "glasses", "21" / "min", "5" / "times"; hours and minutes,
    /// and a currency, stay one ("2 h 43 min", "$40").
    func amountParts(_ value: Double, _ rule: Habit) -> (number: String, unit: String) {
        if rule.kind == .duration {
            return Int(value.rounded()) < 60 ? (HabitCopy.number(value.rounded()), "min") : (HabitCopy.minutes(value), "")
        }
        let unit = (rule.kind == .check ? (rule.checkUnit ?? "times") : HabitCopy.unit(of: rule)).trimmingCharacters(in: .whitespaces)
        if unit.isEmpty || HabitCopy.currencies.contains(unit) { return (HabitCopy.amount(value, unit), "") }
        return (HabitCopy.number(value), HabitCopy.unitWord(value, unit))
    }

    /// "8 Oct", "26 Sep – 1 Oct", "23–29 Aug"; with the year when it isn't this year. From the month names, with no
    /// date formatter (as `weekSpan`).
    func daySpan(_ range: ClosedRange<LocalDay>, today: LocalDay) -> String {
        let a = range.lowerBound, b = range.upperBound
        let months = calendar.shortStandaloneMonthSymbols
        let year = b.year == today.year ? "" : " \(b.year)"
        if a == b { return "\(b.day) \(months[b.month - 1])" + year }
        if a.year != b.year { return "\(a.day) \(months[a.month - 1]) \(a.year) – \(b.day) \(months[b.month - 1]) \(b.year)" }
        if a.month == b.month { return "\(a.day)–\(b.day) \(months[b.month - 1])" + year }
        return "\(a.day) \(months[a.month - 1]) – \(b.day) \(months[b.month - 1])" + year
    }

    /// "26 September to 1 October", for VoiceOver.
    private func spokenSpan(_ range: ClosedRange<LocalDay>, today: LocalDay) -> String {
        range.lowerBound == range.upperBound ? spokenDate(range.lowerBound, today: today)
            : spokenDate(range.lowerBound, today: today) + " to " + spokenDate(range.upperBound, today: today)
    }

    /// "28 September", or "28 September 2025" in another year.
    private func spokenDate(_ day: LocalDay, today: LocalDay) -> String {
        let date = day.date(calendar: calendar)
        return day.year == today.year ? date.formatted(.dateTime.day().month(.wide)) : date.formatted(.dateTime.day().month(.wide).year())
    }

    /// "8 Oct", or "8 Oct 2025" in another year.
    private func shortDate(_ day: LocalDay, today: LocalDay) -> String {
        let date = day.date(calendar: calendar)
        return day.year == today.year ? date.formatted(.dateTime.day().month(.abbreviated))
            : date.formatted(.dateTime.day().month(.abbreviated).year())
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
                                    note: start <= previousFull.upperBound
                                        // Began partway through it: say so, rather than "no earlier month" with September there.
                                        ? "Started on \(start.date(calendar: calendar).formatted(.dateTime.day().month(.abbreviated))), partway through \(noun == "week" ? previousLabel.lowercased() : previousLabel)"
                                        : "No earlier \(noun) to compare")
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

    /// The milestones a habit has reached and the next of each track (spec "Habit Progress" §3): in a row, from the
    /// runs; in total, from the goals met; for a quit habit, days since a slip. Every date comes from the records, so an
    /// edit moves or removes a medal honestly (E8). Earlier goals keep what was reached in them, in their own unit (E1);
    /// the Next rows follow today's goal.
    func habitMilestones(of habit: Habit, record: HabitOverall, today: LocalDay) -> HabitMilestones {
        if habit.kind == .quit { return quitMilestoneList(of: habit, today: today) }
        guard habit.kind != .task, startDay(of: habit) <= today else { return .none }
        let now = rule(habit, on: today)
        let kind = periodKind(now)
        let unit = now.frequency.streakUnit
        let runs = runs(of: habit, today: today)
        let current = runs.last.map { $0.isCurrent ? $0.length : 0 } ?? 0
        let best = runs.map(\.length).max() ?? 0
        var reached = rowMilestones(habit, runs: runs, unit: unit, today: today)
        reached += totalMilestones(dates: record.metDates, kind: kind, atMost: now.atMost, today: today)
        // Earlier goals of another kind (a week goal changed to a day goal): their runs and totals in their own unit.
        for other in record.kinds.subtracting([kind]).sorted(by: { $0.rawValue < $1.rawValue }) {
            let theirs = walkRuns(of: habit, today: today, kind: other)
            if let first = theirs.first {
                reached += rowMilestones(habit, runs: theirs, unit: rule(habit, on: first.start).frequency.streakUnit, today: today)
            }
            let tally = goalTally(of: habit, kind: other, today: today)
            if let first = tally.dates.first {
                reached += totalMilestones(dates: tally.dates, kind: other, atMost: rule(habit, on: first).atMost, today: today)
            }
        }
        reached.sort(by: Self.newestFirst)

        let target = unit.nextMilestone(after: best)
        let row = nextRow(.inARow, target: target, number: "\(target)", title: rowTitle(target, unit),
                          current: current, best: best)
        let ladder = TotalMilestones.ladder(for: kind)
        let totalTarget = ladder.first { $0 > record.met }
        let total = nextRow(.inTotal, target: totalTarget, number: totalTarget.map { "\($0)" } ?? "",
                            title: totalTarget.map { totalTitle($0, kind: kind, atMost: now.atMost) } ?? "",
                            current: record.met, best: nil)
        return HabitMilestones(reached: reached, next: [row, total])
    }

    /// Newest first; on one day, in a row before in total, then the larger.
    private static func newestFirst(_ a: Milestone, _ b: Milestone) -> Bool {
        if a.reached != b.reached { return a.reached > b.reached }
        if a.track != b.track { return a.track == .inARow }
        return a.value > b.value
    }

    /// Each in-a-row milestone reached, dated by the first run that reached it (E7): a run only adds the values above
    /// every run before it, so it's walked once for all of them.
    private func rowMilestones(_ habit: Habit, runs: [Run], unit: StreakUnit, today: LocalDay) -> [Milestone] {
        var reached: [Milestone] = []
        var longest = 0
        for run in runs where run.length > longest {
            let values = unit.milestones(upTo: run.length).filter { $0 > longest }
            longest = run.length
            guard !values.isEmpty else { continue }
            let days = countedDays(of: habit, in: run, values: values, today: today)
            for n in values {
                guard let day = days[n] else { continue }
                let daily = unit == .days || unit == .times
                reached.append(milestone(.inARow, n, key: "\(unit)", number: "\(n)", title: rowTitle(n, unit),
                                         shelfTop: daily ? "\(n) in a row" : "\(n) \(unit.word(n))", shelfBottom: daily ? nil : "in a row",
                                         pageCaption: "\(n) \(unit.word(n))", on: day, today: today))
            }
        }
        return reached
    }

    /// The total milestones reached: `dates[k]` is the day the goals met reached k + 1.
    private func totalMilestones(dates: [LocalDay], kind: GoalPeriod, atMost: Bool, today: LocalDay) -> [Milestone] {
        TotalMilestones.ladder(for: kind).filter { $0 <= dates.count }.map { n in
            let word = periodWord(n, kind: kind, atMost: atMost)
            return milestone(.inTotal, n, key: kind.rawValue + (atMost ? "-limit" : ""), number: "\(n)",
                             title: totalTitle(n, kind: kind, atMost: atMost),
                             shelfTop: kind == .day ? "\(n) in total" : "\(n) \(word)",
                             shelfBottom: kind == .day ? nil : atMost ? "within limit" : "goals met",
                             pageCaption: "\(n) \(word)", on: dates[n - 1], today: today)
        }
    }

    /// "7 days in a row", "8 weeks in a row" (spec §5.3).
    private func rowTitle(_ n: Int, _ unit: StreakUnit) -> String { "\(n) \(unit.word(n)) in a row" }

    /// "10 times in total", "10 weeks of goals met" (never "10 weeks in total", which reads as a length of time),
    /// "10 days within the limit".
    private func totalTitle(_ n: Int, kind: GoalPeriod, atMost: Bool) -> String {
        let word = periodWord(n, kind: kind, atMost: atMost)
        if atMost { return "\(n) \(word) within the limit" }
        return kind == .day ? "\(n) \(word) in total" : "\(n) \(word) of goals met"
    }

    /// What a total counts: "times" for day goals, days within a day limit, else the goal's period.
    private func periodWord(_ n: Int, kind: GoalPeriod, atMost: Bool) -> String {
        switch kind {
        case .day: atMost ? (n == 1 ? "day" : "days") : (n == 1 ? "time" : "times")
        case .week: n == 1 ? "week" : "weeks"
        case .month: n == 1 ? "month" : "months"
        case .year: n == 1 ? "year" : "years"
        }
    }

    /// A track's next milestone, measured from where the person is now (current ÷ target, spec §3.1).
    private func nextRow(_ track: Milestone.Track, target: Int?, number: String, title: String, current: Int, best: Int?) -> MilestoneNext {
        guard let target else {
            let detail = "\(HabitCopy.number(Double(current))) so far"
            return MilestoneNext(track: track, target: nil, number: "", title: "Every milestone reached",
                                 pageTitle: "Every milestone reached", detail: detail, fraction: 1,
                                 spoken: "Every milestone reached, \(detail).")
        }
        let toGo = max(0, target - current)
        var detail = "\(HabitCopy.number(Double(toGo))) to go"
        var spoken = "Next: \(title), \(toGo) to go."
        if track == .inTotal {
            if current > 0 { detail += " · \(HabitCopy.number(Double(current))) so far"; spoken += " \(current) so far." }
        } else if current > 0 {
            if let best, best > current {
                detail += " · now \(current), best \(best)"; spoken += " Now \(current), best \(best)."
            } else {
                detail += " · now \(current)"; spoken += " Now \(current)."
            }
        }
        return MilestoneNext(track: track, target: target, number: number, title: title, pageTitle: "Next: " + title,
                             detail: detail, fraction: min(1, Double(current) / Double(max(1, target))), spoken: spoken)
    }

    /// One medal's words, made once.
    private func milestone(_ track: Milestone.Track, _ n: Int, key: String, number: String, title: String, shelfTop: String,
                           shelfBottom: String?, pageCaption: String, on day: LocalDay, today: LocalDay) -> Milestone {
        let date = day.date(calendar: calendar)
        let thisYear = day.year == today.year
        let short = thisYear ? date.formatted(.dateTime.day().month(.abbreviated)) : date.formatted(.dateTime.month(.abbreviated).year())
        let full = date.formatted(.dateTime.day().month(.abbreviated).year())
        return Milestone(track: track, value: n, reached: day, number: number, title: title, shelfTop: shelfTop,
                         shelfBottom: shelfBottom ?? short, pageCaption: pageCaption, pageDate: full,
                         reachedText: "Reached " + shortDate(day, today: today),
                         spoken: title + ", reached " + date.formatted(.dateTime.day().month(.wide).year()),
                         id: "\(track.rawValue)-\(key)-\(n)")
    }

    /// The day a run reached each of `values` counted days (or weeks, months), in one walk from its start. A period
    /// is dated the day its goal was met (E3).
    private func countedDays(of habit: Habit, in run: Run, values: [Int], today: LocalDay) -> [Int: LocalDay] {
        var wanted = Set(values)
        var found: [Int: LocalDay] = [:]
        var count = 0
        var day = run.start
        while day <= run.end, !wanted.isEmpty {
            let rule = rule(habit, on: day)
            if periodKind(rule) == .day {
                if (isDue(habit, on: day) || day == today) && isDayMet(habit, on: day) {
                    count += 1
                    if wanted.remove(count) != nil { found[count] = day }
                }
                day = day.adding(days: 1, calendar: calendar)
            } else {
                guard let range = periodRange(rule, containing: day) else { day = day.adding(days: 1, calendar: calendar); continue }
                if isPeriodMet(habit, on: day) {
                    count += 1
                    if wanted.remove(count) != nil { found[count] = metDay(of: habit, rule: rule, in: range, today: today) }
                }
                day = range.upperBound.adding(days: 1, calendar: calendar)
            }
        }
        return found
    }

    /// A quit habit's one track, days since a slip: each value reached in the first run long enough, at its start plus
    /// that many days.
    private func quitMilestoneList(of habit: Habit, today: LocalDay) -> HabitMilestones {
        let now = clock()
        let history = quitHistory(of: habit, now: now)
        let current = history.last.map { $0.endedBy == .ongoing ? Int($0.length(now: now) / 86400) : 0 } ?? 0
        let best = Int((history.map { $0.length(now: now) }.max() ?? 0) / 86400)
        let ladder = Self.quitMilestones(upTo: best)
        func number(_ n: Int) -> String { n >= 365 && n % 365 == 0 ? "\(n / 365)" : "\(n)" }
        var reached: [Milestone] = []
        for n in ladder where n <= best {
            guard let run = history.first(where: { Int($0.length(now: now) / 86400) >= n }) else { continue }
            let day = self.today(now: run.start.addingTimeInterval(Double(n) * 86400))
            let name = Self.milestoneName(n)
            reached.append(milestone(.sinceSlip, n, key: "days", number: number(n), title: name + " since a slip", shelfTop: name,
                                     shelfBottom: "since a slip", pageCaption: name, on: day, today: today))
        }
        reached.sort(by: Self.newestFirst)
        let target = ladder.first { $0 > best }
        let next = nextRow(.sinceSlip, target: target, number: target.map(number) ?? "",
                           title: target.map { Self.milestoneName($0) + " since a slip" } ?? "", current: current, best: best)
        return HabitMilestones(reached: reached, next: [next])
    }
}
