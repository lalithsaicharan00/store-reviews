import Foundation

/// Progress's view options (report §7.6). Stored per phone; Today's rows and the habit page read them too.
enum ProgressOptions {
    static let showPercentages = "progress.showPercentages"
    static let showStreaks = "progress.showStreaks"
    static let range = "progress.range"
    /// Phase 3: what counts as a full day, in percent: 100 (default), 80 or 60.
    static let fullDay = "progress.fullDay"
}

/// Week, Month or Year on Progress (Year: Phase 2, Build Plan #60f).
enum ProgressRange: String, CaseIterable, Identifiable, Hashable, Sendable {
    case week, month, year
    var id: Self { self }
    var title: String { rawValue.capitalized }
    var noun: String { rawValue }
    var kind: HabitStore.PeriodKind {
        switch self { case .week: .week; case .month: .month; case .year: .year }
    }
    var goalPeriod: GoalPeriod {
        switch self { case .week: .week; case .month: .month; case .year: .year }
    }
}

/// How a habit's numbers are shown: ten shapes cover every type and rule (report §9).
enum ProgressShape: Hashable, Sendable {
    /// Check it off once a day (A), several times a day (B), an amount (C), time (D), a checklist (E).
    case once, times, amount, time, checklist
    /// Times a week or month (F), a total a week or month (G), an amount on N days a week (H).
    case periodTimes, periodTotal, periodDays
    /// Cut down: a daily limit (I-day), a weekly or monthly limit (I-period).
    case limitDay, limitPeriod
}

/// One day of the overview: its ring.
struct ProgressDay: Hashable, Identifiable {
    let day: LocalDay
    let score: HabitStore.DayScore
    let isToday: Bool
    let isFuture: Bool
    var id: LocalDay { day }
}

/// The overview's numbers for a period (report §7.2): done of planned up to today, and full days. Today adds only
/// what's done, so it never lowers the numbers.
struct ProgressTally: Hashable {
    var done = 0
    var planned = 0
    var fullDays = 0
    var percent: Int? { ProgressMath.percent(Double(done), Double(planned)) }
}

/// Week or month goals met in a period (tile 3). Hidden when there are none.
struct ProgressGoals: Hashable {
    var met = 0
    var total = 0
    var kinds: Set<GoalPeriod> = []
    var running = false
    var caption: String {
        let name = kinds == [.week] ? "Weekly goals met" : kinds == [.month] ? "Monthly goals met" : "Goals met"
        return running ? name + " so far" : name
    }
}

/// One day's mark in a habit's strip.
struct ProgressMark: Hashable, Identifiable {
    let day: LocalDay
    let mark: HabitStore.DayMark
    /// 0...1: how much of the day's goal was reached, for part-done marks.
    let fraction: Double
    /// A limit's day that went over.
    let over: Bool
    var id: LocalDay { day }
}

/// One habit's row on Progress.
struct ProgressHabitRow: Hashable, Identifiable {
    let habit: Habit
    let marks: [ProgressMark]
    /// The subtitle without its percentage ("4 of 5 days"); the view adds " · 80%" while percentages are shown.
    let text: String
    let percent: Int?
    /// VoiceOver: the whole row is one element (report §21).
    let accessibility: String
    /// Year only: the habit's own year of dots.
    var yearDots: YearDots? = nil
    var id: UUID { habit.id }
}

/// A quit habit's row (report §10.2): the run going on (ticking once a minute on screen), the best run, the slips in
/// the period, and a strip of clean days and slip days.
struct ProgressQuitRow: Hashable, Identifiable {
    let habit: Habit
    /// The start of the run going on now; nil while paused, or in a past period.
    let runStart: Date?
    let paused: Bool
    let text: String
    let marks: [ProgressMark]
    var yearDots: YearDots? = nil
    var id: UUID { habit.id }
}

/// Everything Progress shows for one range and period, worked out once per change (report §20).
struct ProgressSnapshot {
    let range: ProgressRange
    let period: ClosedRange<LocalDay>
    let today: LocalDay
    let title: String
    let days: [ProgressDay]
    let tally: ProgressTally
    let goals: ProgressGoals?
    /// "Last week: 31 of 42"; nil when there was no earlier period with anything planned.
    let previous: (title: String, tally: ProgressTally)?
    let rows: [ProgressHabitRow]
    let archived: [ProgressHabitRow]
    let quitting: [ProgressQuitRow]
    /// Year only: the overview's grid of days.
    var yearDots: YearDots? = nil
    /// What counts as a full day (1, 0.8 or 0.6).
    var fullAt: Double = 1
    let canGoBack: Bool
    let canGoForward: Bool
    /// Any habit that Progress can show (tasks never are).
    let hasHabits: Bool

    var isRunning: Bool { period.contains(today) }
    /// The overview shows when any day in the period has something planned.
    var hasPlan: Bool { days.contains { $0.score.planned > 0 } }
}

/// One habit's line in the Day sheet (report §7.4) and the habit page's day popover (§8.2).
struct ProgressDayRow: Hashable, Identifiable {
    let habit: Habit
    let mark: HabitStore.DayMark
    let fraction: Double
    let atMost: Bool
    let value: String
    let note: String?
    var id: UUID { habit.id }
}

struct ProgressDayDetail {
    let day: LocalDay
    let score: HabitStore.DayScore
    let isToday: Bool
    let rows: [ProgressDayRow]
    let dayNote: String?
}

/// A week, month or year goal's result in one of its periods (report §16.3).
struct ProgressPeriodResult: Hashable {
    let period: ClosedRange<LocalDay>
    let value: Double
    let goal: Double
    /// True or false once the period is over; while it runs, true once met and nil before (not counted yet).
    let met: Bool?
}

enum ProgressMath {
    /// A whole percentage, shown only when something is planned and something is done. Never rounds up to 100.
    static func percent(_ done: Double, _ planned: Double) -> Int? {
        guard planned > 0, done > 0 else { return nil }
        if done >= planned { return 100 }
        return min(99, Int((done / planned * 100).rounded()))
    }
}

extension HabitStore.DayMark {
    /// The mark's name, as the legend and VoiceOver say it (report §19). A limit's marks say what they mean for a
    /// limit: within it, or over it.
    func words(atMost: Bool = false) -> String {
        switch self {
        case .done: atMost ? "Within the limit" : "Done"
        case .some: atMost ? "Logged" : "Part done"
        case .missed: atMost ? "Over the limit" : "Not done"
        case .open: "Not done yet"
        case .skipped: "Skipped"
        case .paused: "Paused"
        case .notItsDay: "Not one of its days"
        case .upcoming: "Coming up"
        case .before: "Before it started"
        }
    }
}

// MARK: - The numbers

extension HabitStore {
    /// The days of a period, in order.
    func days(in range: ClosedRange<LocalDay>) -> [LocalDay] {
        var list: [LocalDay] = []
        var day = range.lowerBound
        while day <= range.upperBound {
            list.append(day)
            day = day.adding(days: 1, calendar: calendar)
        }
        return list
    }

    /// The first day any habit Progress shows counts from: ‹ stops at the period holding it.
    func earliestProgressDay() -> LocalDay? {
        habits.filter { $0.kind != .task }.map { startDay(of: $0) }.min()
    }

    /// The shape a habit's numbers take, from the rule in force (report §9).
    func progressShape(_ rule: Habit) -> ProgressShape {
        let f = rule.frequency
        if rule.atMost { return f.isDayBased ? .limitDay : .limitPeriod }
        if f.isFlexible { return .periodDays }
        if !f.isDayBased { return isTotal(rule) ? .periodTotal : .periodTimes }
        switch rule.kind {
        case .amount: return .amount
        case .duration: return .time
        case .checklist: return .checklist
        default: return dayGoal(of: rule) > 1 ? .times : .once
        }
    }

    /// An amount in the habit's own words: "46 glasses", "3 h 20 min", "12".
    func progressValue(_ value: Double, _ rule: Habit) -> String {
        rule.kind == .duration ? HabitCopy.minutes(value) : HabitCopy.amount(value, HabitCopy.unit(of: rule))
    }

    /// Everything Progress shows for `range` around `anchor`. Reads the store's own functions only; nothing here
    /// changes data.
    func progressSnapshot(_ range: ProgressRange, containing anchor: LocalDay, today: LocalDay? = nil,
                          fullAt: Double = 1) -> ProgressSnapshot {
        let today = today ?? self.today()
        let span = period(range.kind, containing: anchor)
        let tracked = habits.filter { $0.kind != .task && $0.kind != .quit }
        let cells = days(in: span).map { day in
            ProgressDay(day: day, score: dayScore(on: day, habits: tracked, today: today), isToday: day == today, isFuture: day > today)
        }
        let earliest = earliestProgressDay()

        var previous: (title: String, tally: ProgressTally)?
        let before = period(range.kind, containing: span.lowerBound.adding(days: -1, calendar: calendar))
        if let earliest, before.upperBound >= earliest {
            let tally = progressTally(days(in: before).map { day in
                ProgressDay(day: day, score: dayScore(on: day, habits: tracked, today: today), isToday: day == today, isFuture: day > today)
            }, fullAt: fullAt)
            if tally.planned > 0 { previous = (previousTitle(range, before, today: today), tally) }
        }

        var rows: [ProgressHabitRow] = [], archived: [ProgressHabitRow] = []
        var goals = ProgressGoals(running: span.contains(today))
        for habit in tracked {
            guard let row = progressRow(habit, in: span, range: range, today: today) else { continue }
            if habit.archived { archived.append(row) } else { rows.append(row) }
            // Tile 3: week (and, on Month, month) goals whose period ends in this range. Limits aren't goals met.
            let rule = rule(habit, on: max(min(span.upperBound, today), startDay(of: habit)))
            let kind = periodKind(rule)
            guard !rule.atMost, kind != .day, Self.rank(kind) <= Self.rank(range.goalPeriod) else { continue }
            for result in progressPeriodResults(habit, in: span, today: today) {
                goals.total += 1
                if result.met == true { goals.met += 1 }
                goals.kinds.insert(kind)
            }
        }

        var quitting: [ProgressQuitRow] = []
        let now = clock()
        for habit in habits where habit.kind == .quit && !habit.archived && quitStartDay(of: habit) <= min(span.upperBound, today) {
            let stats = quitStats(of: habit, in: span, now: now)
            let history = quitHistory(of: habit, now: now)
            let best = history.map { $0.length(now: now) }.max() ?? 0
            let running = span.contains(today)
            let current = running ? history.last.flatMap { $0.endedBy == .ongoing ? $0.start : nil } : nil
            let when = running ? "this \(range.noun)" : range == .week ? "that week"
                : range == .month ? "in " + span.lowerBound.date(calendar: calendar).formatted(.dateTime.month(.wide))
                : "in \(span.lowerBound.year)"
            let slips = stats.slips.isEmpty ? "no slips \(when)" : stats.slips.count == 1 ? "1 slip \(when)" : "\(stats.slips.count) slips \(when)"
            var row = ProgressQuitRow(habit: habit, runStart: current, paused: running && isPaused(habit, on: today),
                                      text: "Best \(Format.days(best)) · \(slips)", marks: stats.marks)
            if range == .year {
                let byDay = Dictionary(uniqueKeysWithValues: stats.marks.map { ($0.day, $0) })
                row.yearDots = yearDots(span) { byDay[$0] }
            }
            quitting.append(row)
        }

        if range == .year {
            for i in rows.indices { rows[i].yearDots = rowYearDots(rows[i], span) }
            for i in archived.indices { archived[i].yearDots = rowYearDots(archived[i], span) }
        }
        return ProgressSnapshot(
            range: range, period: span, today: today, title: periodTitle(range, span, today: today),
            days: cells, tally: progressTally(cells, fullAt: fullAt), goals: goals.total > 0 ? goals : nil, previous: previous,
            rows: rows, archived: archived, quitting: quitting,
            canGoBack: earliest.map { $0 < span.lowerBound } ?? false,
            canGoForward: span.upperBound < today,
            hasHabits: habits.contains { $0.kind != .task },
            yearDots: range == .year ? overviewYearDots(cells, year: span, fullAt: fullAt) : nil, fullAt: fullAt)
    }

    static func rank(_ k: GoalPeriod) -> Int {
        switch k { case .day: 0; case .week: 1; case .month: 2; case .year: 3 }
    }

    private func rowYearDots(_ row: ProgressHabitRow, _ span: ClosedRange<LocalDay>) -> YearDots {
        let byDay = Dictionary(uniqueKeysWithValues: row.marks.map { ($0.day, $0) })
        return yearDots(span) { byDay[$0] }
    }

    /// Done of planned up to today: today adds only what's done (report §7.2, §16.4).
    func progressTally(_ cells: [ProgressDay], fullAt: Double = 1) -> ProgressTally {
        var tally = ProgressTally()
        for cell in cells where !cell.isFuture {
            tally.done += cell.score.done
            tally.planned += cell.isToday ? cell.score.done : cell.score.planned
            if cell.score.isFull(at: fullAt) { tally.fullDays += 1 }
        }
        return tally
    }

    /// "This week", "Last week", "22–28 Sep"; "September 2026".
    func periodTitle(_ range: ProgressRange, _ period: ClosedRange<LocalDay>, today: LocalDay) -> String {
        switch range {
        case .week:
            if period.contains(today) { return "This week" }
            if period.contains(today.adding(days: -7, calendar: calendar)) { return "Last week" }
            return weekSpan(period)
        case .month:
            return period.lowerBound.date(calendar: calendar).formatted(.dateTime.month(.wide).year())
        case .year:
            return String(period.lowerBound.year)
        }
    }

    /// "Last week", "15–21 Sep"; "August", or "December 2025" in another year.
    private func previousTitle(_ range: ProgressRange, _ period: ClosedRange<LocalDay>, today: LocalDay) -> String {
        switch range {
        case .week:
            return period.contains(today.adding(days: -7, calendar: calendar)) ? "Last week" : weekSpan(period)
        case .month:
            let date = period.lowerBound.date(calendar: calendar)
            return period.lowerBound.year == today.year ? date.formatted(.dateTime.month(.wide))
                : date.formatted(.dateTime.month(.wide).year())
        case .year:
            return String(period.lowerBound.year)
        }
    }

    func weekSpan(_ period: ClosedRange<LocalDay>) -> String {
        let start = period.lowerBound.date(calendar: calendar), end = period.upperBound.date(calendar: calendar)
        return (start..<end).formatted(.interval.day().month(.abbreviated))
    }

    // MARK: A habit's row

    /// One habit's row for a period, or nil when it has nothing in it (report §7.3, §9.1).
    func progressRow(_ habit: Habit, in period: ClosedRange<LocalDay>, range: ProgressRange, today: LocalDay) -> ProgressHabitRow? {
        let start = startDay(of: habit)
        let running = period.contains(today)
        let dayList = days(in: period)
        // Not begun yet: shown only in the current period, saying when it starts.
        if start > today {
            guard running && !habit.archived else { return nil }
            let text = "Starts " + PauseSheet.short(start, calendar: calendar)
            let marks = dayList.map { ProgressMark(day: $0, mark: dayMark(habit, on: $0), fraction: 0, over: false) }
            return ProgressHabitRow(habit: habit, marks: marks, text: text, percent: nil, accessibility: habit.name + ". " + text)
        }
        guard start <= period.upperBound else { return nil }
        let last = min(period.upperBound, today)
        let rule = rule(habit, on: max(last, start))
        let marks = dayList.map { day -> ProgressMark in
            let mark = dayMark(habit, on: day)
            let fraction = mark == .done ? 1 : mark == .some ? dayFraction(habit, on: day) : 0
            return ProgressMark(day: day, mark: mark, fraction: fraction, over: mark == .missed && self.rule(habit, on: day).atMost)
        }
        // Days that count: done any day up to today; part done or not done only once the day is over.
        let counted = marks.filter { $0.mark == .done || ($0.day < today && ($0.mark == .some || $0.mark == .missed)) }
        let doneDays = counted.filter { $0.mark == .done }.count
        let soFar = running ? " so far" : ""
        func daysWord(_ n: Int) -> String { n == 1 ? "1 day" : "\(n) days" }

        var text: String
        var percent: Int?
        var hasDays = !counted.isEmpty
        switch progressShape(rule) {
        case .once:
            text = "\(doneDays) of \(daysWord(counted.count))\(soFar)"
            percent = ProgressMath.percent(Double(doneDays), Double(counted.count))
        case .times:
            var done = 0.0, planned = 0.0
            for mark in counted {
                let dayRule = self.rule(habit, on: mark.day)
                let goal = dayGoal(of: dayRule)
                planned += goal
                done += min(dayProgress(of: dayRule, on: mark.day), goal)
            }
            let unit = HabitCopy.unit(of: rule)
            text = "\(HabitCopy.number(done)) of \(HabitCopy.number(planned)) \(unit.isEmpty ? "times" : unit)\(soFar)"
            percent = ProgressMath.percent(done, planned)
        case .amount, .time:
            // Every day's amount in the period, in the current unit (report §16.7, §18).
            let unit = HabitCopy.unit(of: rule)
            var total = 0.0
            for day in dayList where day >= start && day <= last && !isArchived(habit, on: day) {
                let dayRule = self.rule(habit, on: day)
                guard HabitCopy.unit(of: dayRule) == unit, (dayRule.kind == .duration) == (rule.kind == .duration) else { continue }
                total += dayProgress(of: dayRule, on: day)
            }
            hasDays = hasDays || total > 0
            text = "\(progressValue(total, rule)) · \(doneDays) of \(daysWord(counted.count))\(soFar)"
        case .checklist:
            var done = 0.0, planned = 0.0
            for mark in counted {
                let dayRule = self.rule(habit, on: mark.day)
                planned += dayGoal(of: dayRule)
                done += dayProgress(of: dayRule, on: mark.day)
            }
            text = "\(HabitCopy.number(done)) of \(HabitCopy.number(planned)) steps\(soFar) · \(doneDays == 1 ? "1 full day" : "\(doneDays) full days")"
            percent = ProgressMath.percent(done, planned)
        case .limitDay:
            // Judged days only: today waits for the day to end (report §11.2).
            let judged = counted.filter { $0.day < today }
            let total = judged.reduce(0.0) { $0 + dayProgress(of: self.rule(habit, on: $1.day), on: $1.day) }
            if judged.isEmpty {
                let now = running && today >= start ? dayProgress(of: rule, on: today) : 0
                text = running ? "\(progressValue(now, rule)) of \(progressValue(rule.goal, rule)) so far today"
                    : "Limit \(progressValue(rule.goal, rule)) a day"
            } else {
                let average = (total / Double(judged.count) * 10).rounded() / 10
                text = "Avg \(progressValue(average, rule)) a day · limit \(progressValue(rule.goal, rule))"
            }
        case .periodTimes, .periodTotal, .periodDays, .limitPeriod:
            let result = periodRowText(habit, rule: rule, period: period, range: range, today: today, hasDays: hasDays)
            text = result.0
            hasDays = result.1
        }

        let loggedAny = marks.contains { $0.mark == .done || $0.mark == .some }
        if !hasDays && !loggedAny {
            // Nothing in it: past periods (and archived habits) leave it out; the current one says so.
            guard running && !habit.archived else { return nil }
            if start == today { text = "Started today" }
            else if marks.contains(where: { $0.mark == .open || $0.mark == .upcoming }) { text = "Nothing counted yet this \(range.noun)" }
            else { text = "Nothing planned this \(range.noun)" }
            percent = nil
        }
        if running, !habit.archived, let pause = pause(of: habit, on: today), pause.contains(today) {
            text = HabitPageView.pausedText(pause, store: self)
            percent = nil
        }

        var spoken = habit.name + ". " + text + "."
        if range == .week {
            let names = calendar.weekdaySymbols
            spoken += " " + marks.map { names[calendar.component(.weekday, from: $0.day.date(calendar: calendar)) - 1] + " " + $0.mark.words(atMost: rule.atMost).lowercased() }
                .joined(separator: ", ") + "."
        }
        return ProgressHabitRow(habit: habit, marks: marks, text: text, percent: percent, accessibility: spoken)
    }

    /// Week, month and year goals' row text (shapes F, G, H, I-period; report §9.1).
    private func periodRowText(_ habit: Habit, rule: Habit, period: ClosedRange<LocalDay>, range: ProgressRange,
                               today: LocalDay, hasDays: Bool) -> (String, Bool) {
        let shape = progressShape(rule)
        let kind = periodKind(rule)
        let running = period.contains(today)
        let last = min(period.upperBound, today)
        let start = startDay(of: habit)
        func rank(_ k: GoalPeriod) -> Int {
            switch k { case .day: 0; case .week: 1; case .month: 2; case .year: 3 }
        }
        func amountText(_ v: Double) -> String { shape == .periodTimes ? HabitCopy.number(v) : progressValue(v, rule) }
        let isAmount: Bool
        switch rule.kind {
        case .amount, .duration: isAmount = true
        default: isAmount = false
        }

        if kind == range.goalPeriod, let result = progressPeriodResults(habit, in: period, today: today).last {
            // "42 of 60 km", "2 of 3", "30 min of 1 h".
            let v = rule.kind == .duration ? HabitCopy.minutes(result.value) : HabitCopy.number(result.value)
            let g = amountText(result.goal)
            let reached = rule.atMost ? result.value <= result.goal : result.value >= result.goal
            switch shape {
            case .limitPeriod:
                return (running ? "\(v) of \(g) this \(range.noun)" : reached ? "\(v) of \(g) · within the limit" : "\(v) of \(g)", true)
            case .periodDays:
                let total = isAmount ? " · " + progressValue(periodTotal(rule, in: period), rule) : ""
                return ("\(HabitCopy.number(result.value)) of \(HabitCopy.number(result.goal)) days\(reached ? " · met" : running ? " so far" : "")\(total)", true)
            default:
                return ("\(v) of \(g)\(reached ? " · met" : running ? " so far" : "")", true)
            }
        }
        let results = rank(kind) < rank(range.goalPeriod) ? progressPeriodResults(habit, in: period, today: today) : []
        if !results.isEmpty {
            // Week goals seen over a month: how many weeks were met, and what was done (report §9.1).
            let met = results.filter { $0.met == true }.count
            let noun = kind == .week ? "weeks" : "months"
            if shape == .limitPeriod { return ("Within the limit \(met) of \(results.count) \(noun)", true) }
            let inRange = max(period.lowerBound, start)...last
            let done: String
            switch shape {
            case .periodDays:
                let reached = days(in: inRange).filter { isDayMet(habit, on: $0) && dayProgress(of: self.rule(habit, on: $0), on: $0) > 0 }.count
                done = reached == 1 ? "1 day" : "\(reached) days"
            case .periodTotal: done = progressValue(periodTotal(rule, in: inRange), rule)
            default:
                let times = periodCount(rule, in: inRange)
                done = times == 1 ? "1 time" : "\(HabitCopy.number(times)) times"
            }
            return ("Met \(met) of \(results.count) \(noun) · \(done)", true)
        }
        // A month or year goal seen in a week (or a week goal with no week ending in this month yet): what was done.
        guard last >= start else { return ("", hasDays) }
        let inRange = max(period.lowerBound, start)...last
        let this = running ? " this \(range.noun)" : ""
        switch shape {
        case .periodDays:
            let reached = days(in: inRange).filter { isDayMet(habit, on: $0) && dayProgress(of: self.rule(habit, on: $0), on: $0) > 0 }.count
            return ((reached == 1 ? "1 day" : "\(reached) days") + this, reached > 0 || hasDays)
        case .periodTimes:
            let times = periodCount(rule, in: inRange)
            return ((times == 1 ? "1 time" : "\(HabitCopy.number(times)) times") + this, times > 0 || hasDays)
        default:
            let total = periodTotal(rule, in: inRange)
            return (progressValue(total, rule) + this, total > 0 || hasDays)
        }
    }

    /// Each week, month or year of a period goal that ends inside `range` and has begun (report §16.3). A period
    /// that wasn't met but had a pause, or ended after archiving, doesn't count against anyone and is left out.
    func progressPeriodResults(_ habit: Habit, in range: ClosedRange<LocalDay>, today: LocalDay) -> [ProgressPeriodResult] {
        let start = startDay(of: habit)
        let last = min(range.upperBound, today)
        guard last >= start else { return [] }
        let goalPeriod = periodKind(rule(habit, on: last))
        let kind: PeriodKind
        switch goalPeriod {
        case .day: return []
        case .week: kind = .week
        case .month: kind = .month
        case .year: kind = .year
        }
        var results: [ProgressPeriodResult] = []
        var cursor = range.lowerBound
        while cursor <= range.upperBound {
            let p = period(kind, containing: cursor)
            cursor = p.upperBound.adding(days: 1, calendar: calendar)
            guard range.contains(p.upperBound), p.upperBound >= start, p.lowerBound <= today else { continue }
            let judgeDay = min(p.upperBound, today)
            let rule = rule(habit, on: judgeDay)
            guard periodKind(rule) == goalPeriod else { continue }
            if isArchived(habit, on: max(p.lowerBound, start)) { continue }
            let value: Double, goal: Double
            if case .flexible(_, let needed) = rule.frequency {
                value = Double(flexibleProgress(rule, on: judgeDay) ?? 0)
                goal = Double(needed)
            } else if isTotal(rule) {
                value = periodTotal(rule, in: p)
                goal = rule.goal
            } else {
                value = periodCount(rule, in: p)
                goal = self.goal(of: rule)
            }
            let reached = rule.atMost ? value <= goal : value >= goal
            let met: Bool?
            if p.upperBound >= today {
                // Running: a goal counts once met; a limit waits for the period to end.
                met = !rule.atMost && reached ? true : nil
            } else {
                if !reached && (hasPause(habit, in: p) || isArchived(habit, on: p.upperBound)) { continue }
                met = reached
            }
            results.append(ProgressPeriodResult(period: p, value: value, goal: goal, met: met))
        }
        return results
    }

    // MARK: A day

    /// The Day sheet: every habit planned that day with its mark and value, week goals logged that day, and the
    /// day's notes (report §7.4). Tasks and quit habits aren't in it.
    func progressDayDetail(on day: LocalDay, today: LocalDay? = nil) -> ProgressDayDetail {
        let today = today ?? self.today()
        let tracked = habits.filter { $0.kind != .task && $0.kind != .quit && startDay(of: $0) <= day }
        var rows: [ProgressDayRow] = []
        for habit in tracked {
            if let row = progressDayRow(habit, on: day, today: today) { rows.append(row) }
        }
        return ProgressDayDetail(day: day, score: dayScore(on: day, habits: tracked, today: today), isToday: day == today,
                                 rows: rows, dayNote: dayNote(on: day))
    }

    /// One habit on one day, in words: "6 of 8 glasses", "Done", "Skipped", "1 time (2 of 3 this week)". Nil when the
    /// day isn't one of its days and nothing was logged.
    func progressDayRow(_ habit: Habit, on day: LocalDay, today: LocalDay? = nil) -> ProgressDayRow? {
        let today = today ?? self.today()
        guard day >= startDay(of: habit), day <= today else { return nil }
        let rule = rule(habit, on: day)
        let mark = dayMark(habit, on: day)
        let progress = dayProgress(of: rule, on: day)
        let target = dayGoal(of: rule)
        let note = self.note(of: habit, on: day)
        func of(_ v: Double, _ g: Double) -> String {
            switch rule.kind {
            case .duration: return "\(HabitCopy.minutes(v)) of \(HabitCopy.minutes(g))"
            case .checklist: return "\(HabitCopy.number(v)) of \(HabitCopy.number(g)) steps"
            default:
                let unit = HabitCopy.unit(of: rule)
                if unit.isEmpty && rule.kind == .check { return "\(HabitCopy.number(v)) of \(HabitCopy.number(g)) times" }
                return "\(HabitCopy.number(v)) of \(HabitCopy.amount(g, unit))"
            }
        }
        let value: String
        if !rule.frequency.isDayBased {
            // A week, month or year goal: only on days with something logged.
            guard progress > 0, let range = periodRange(rule, containing: day) else {
                if mark == .paused { return ProgressDayRow(habit: habit, mark: mark, fraction: 0, atMost: rule.atMost, value: "Paused", note: note) }
                return note == nil ? nil : ProgressDayRow(habit: habit, mark: .notItsDay, fraction: 0, atMost: rule.atMost, value: "Nothing logged", note: note)
            }
            let noun = periodKind(rule).noun
            let when = range.contains(today) ? "this \(noun)" : "that \(noun)"
            if isTotal(rule) {
                let total = periodTotal(rule, in: range)
                value = "\(progressValue(progress, rule)) (\(HabitCopy.number(total)) of \(progressValue(rule.goal, rule)) \(when))"
            } else {
                let count = periodCount(rule, in: range)
                value = "\(progress == 1 ? "1 time" : "\(HabitCopy.number(progress)) times") (\(HabitCopy.number(count)) of \(HabitCopy.number(goal(of: rule))) \(when))"
            }
            return ProgressDayRow(habit: habit, mark: rule.atMost ? .some : .done, fraction: 1, atMost: rule.atMost, value: value, note: note)
        }
        switch mark {
        case .skipped: value = "Skipped"
        case .paused: value = "Paused"
        case .done:
            if rule.atMost { value = "Within the limit · " + of(progress, target) }
            else if rule.kind == .check && target <= 1 { value = "Done" }
            else { value = of(progress, target) }
        case .some: value = rule.atMost ? of(progress, target) + " so far" : of(progress, target)
        case .missed: value = rule.atMost ? "Over the limit · " + of(progress, target) : "Not done"
        case .open: value = progress > 0 ? of(progress, target) + " so far" : "Not done yet"
        case .notItsDay, .upcoming, .before:
            guard progress > 0 || note != nil else { return nil }
            value = progress > 0 ? of(progress, target) : "Not one of its days"
        }
        let fraction = mark == .done ? 1 : mark == .some ? dayFraction(habit, on: day) : 0
        return ProgressDayRow(habit: habit, mark: mark, fraction: fraction, atMost: rule.atMost, value: value, note: note)
    }
}
