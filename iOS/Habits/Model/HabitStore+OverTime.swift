import Foundation

/// The habit page's Over Time ranges (report §8.3). All runs from the habit's first day to today.
enum OverTimeRange: String, CaseIterable, Identifiable, Hashable, Sendable {
    case week, month, year, all
    var id: Self { self }
    var title: String { rawValue == "all" ? "All" : rawValue.capitalized }
    var kind: HabitStore.PeriodKind? {
        switch self {
        case .week: .week
        case .month: .month
        case .year: .year
        case .all: nil
        }
    }
}

/// Where Over Time opens when the page comes from Progress: Progress's range and period.
struct OverTimeStart: Hashable {
    let range: OverTimeRange
    let anchor: LocalDay
}

struct OverTimeTile: Hashable, Identifiable {
    let value: String
    let caption: String
    var percent: Int? = nil
    var id: String { caption }
}

/// One bar of the Over Time chart: a day, a week or a month.
struct OverTimeBar: Hashable, Identifiable {
    let start: Date
    let end: Date
    let value: Double
    /// The goal or limit in force for that bar; the line steps where the goal changed.
    let goal: Double?
    /// Part done: drawn lighter.
    let light: Bool
    /// A limit went over: a small ▲ above the bar.
    let over: Bool
    /// "6 of 8 glasses · Wed 24 Sep", for the tap callout and VoiceOver.
    let label: String
    var id: Date { start }
}

enum OverTimeScale: Hashable {
    case percent, minutes, amount(String)
}

/// Done · Part done · Not done · Skipped · Paused, in that order (report §8.3). Limits read Within · Over.
struct OverTimeCounts: Hashable {
    var done = 0, part = 0, notDone = 0, skipped = 0, paused = 0
    var atMost = false
    var total: Int { done + part + notDone + skipped + paused }
}

/// Everything Over Time shows for one range and period, worked out once per change.
struct OverTimeSnapshot {
    let range: OverTimeRange
    let span: ClosedRange<LocalDay>
    let title: String
    let canGoBack: Bool
    let canGoForward: Bool
    let tiles: [OverTimeTile]
    /// Weekly or monthly totals and limits: "18 km to go · 5 days left", "Reached on 24 Sep".
    let pace: String?
    /// Limits only: "Down from 5.1 a day in August" (report §11.2).
    let change: String?
    let counts: OverTimeCounts?
    let bars: [OverTimeBar]
    let scale: OverTimeScale
    let bucket: Calendar.Component
    let isLimit: Bool
    let footnotes: [String]
    /// Checklists: each step and the planned days it was ticked, in the habit's own step order, never sorted worst
    /// first (report §9.2).
    var steps: [OverTimeStep] = []
    /// Totals and limits for a week or month, in their own range: the running total day by day, and a straight line
    /// from 0 to the goal or limit across the period (report §9.3, shapes G and I-period).
    var running: [OverTimePoint] = []
    var paceLine: (start: Date, end: Date, goal: Double)? = nil
    /// Day-based habits with 28 or more planned days in the range (report §8.6).
    var weekdays: [WeekdayStat] = []
    var weekdayCaption: String? = nil
    var weekdayAverages = false
    /// All only, day-based habits: the 30-day rate, a point a week (report §16.6).
    var rate: [RatePoint] = []
}

struct OverTimePoint: Hashable, Identifiable {
    let date: Date
    let total: Double
    let label: String
    var id: Date { date }
}

struct OverTimeStep: Hashable, Identifiable {
    let id: UUID
    let name: String
    let ticked: Int
    let days: Int
    var percent: Int? { days > 0 ? Int((Double(ticked) / Double(days) * 100).rounded()) : nil }
}

extension HabitStore {
    /// "213 days done since 12 Mar 2025", "1,204 km in all since 12 Mar 2025", "Goal met 31 weeks since …" (§8.1): a
    /// number a break can't take away.
    /// Works out `totalLine` (remembered by `HabitStore.totalLine`): it walks the habit's whole history.
    func workOutTotalLine(of habit: Habit, today: LocalDay) -> String? {
        guard habit.kind != .quit, habit.kind != .task else { return nil }
        let start = startDay(of: habit)
        guard start <= today else { return nil }
        let since = " since " + start.date(calendar: calendar).formatted(.dateTime.day().month(.abbreviated).year())
        let rule = rule(habit, on: today)
        let met = runs(of: habit, today: today).reduce(0) { $0 + $1.length }
        switch periodKind(rule) {
        case .week: return "Goal met \(met == 1 ? "1 week" : "\(met) weeks")\(since)"
        case .month: return "Goal met \(met == 1 ? "1 month" : "\(met) months")\(since)"
        case .year: return "Goal met \(met == 1 ? "1 year" : "\(met) years")\(since)"
        case .day: break
        }
        if rule.atMost { return "Within the limit \(met == 1 ? "1 day" : "\(met) days")\(since)" }
        switch rule.kind {
        case .amount, .duration:
            // Every entry in the current unit (report §18: a unit change starts a new total).
            let unit = HabitCopy.unit(of: rule)
            var total = 0.0
            for day in days(in: start...today) where !isArchived(habit, on: day) {
                let dayRule = self.rule(habit, on: day)
                guard HabitCopy.unit(of: dayRule) == unit else { continue }
                total += dayProgress(of: dayRule, on: day)
            }
            return "\(progressValue(total, rule)) in all\(since)"
        default:
            return "\(met == 1 ? "1 day" : "\(met) days") done\(since)"
        }
    }

    /// Over Time for one habit (report §8.3, §9.2, §9.3, §11.3).
    func overTime(_ habit: Habit, range: OverTimeRange, anchor: LocalDay, today: LocalDay? = nil) -> OverTimeSnapshot {
        let today = today ?? self.today()
        let start = startDay(of: habit)
        let span: ClosedRange<LocalDay> = range.kind.map { period($0, containing: anchor) } ?? (min(start, today)...today)
        let last = min(span.upperBound, today)
        let rule = rule(habit, on: max(min(last, today), start))
        let shape = progressShape(rule)
        var isAmount = rule.kind == .duration
        if case .amount = rule.kind { isAmount = true }
        let scale: OverTimeScale = rule.kind == .duration ? .minutes : .amount(HabitCopy.unit(of: rule))
        let showsDays = [.once, .times, .amount, .time, .checklist, .limitDay].contains(shape)

        // Each day once: its mark, what was logged and the goal in force (report §16).
        struct Day { let day: LocalDay; let mark: DayMark; let value: Double; let goal: Double; let rule: Habit }
        var list: [Day] = []
        if start <= last {
            for day in days(in: max(span.lowerBound, start)...last) {
                let dayRule = self.rule(habit, on: day)
                list.append(Day(day: day, mark: dayMark(habit, on: day), value: dayProgress(of: dayRule, on: day),
                                goal: dayGoal(of: dayRule), rule: dayRule))
            }
        }
        let counted = list.filter { $0.mark == .done || ($0.day < today && ($0.mark == .some || $0.mark == .missed)) }
        let doneDays = counted.filter { $0.mark == .done }
        func daysText(_ n: Int) -> String { n == 1 ? "1 day" : "\(n) days" }
        func dayText(_ day: LocalDay) -> String { day.date(calendar: calendar).formatted(.dateTime.day().month(.abbreviated)) }
        func value(_ v: Double) -> String { progressValue(v, rule) }

        var counts: OverTimeCounts?
        if showsDays {
            var c = OverTimeCounts(atMost: rule.atMost)
            for d in list {
                switch d.mark {
                case .done: c.done += 1
                case .some where d.day < today: c.part += 1
                case .missed: c.notDone += 1
                case .skipped: c.skipped += 1
                case .paused: c.paused += 1
                default: break
                }
            }
            if c.total > 0 { counts = c }
        }

        // Week, month and year goals: their periods in this range.
        let results = showsDays ? [] : progressPeriodResults(habit, in: span, today: today)
        let ended = results.filter { $0.period.upperBound < today }
        let goalNoun = periodKind(rule).noun
        func periodName(_ p: ClosedRange<LocalDay>) -> String {
            switch periodKind(rule) {
            case .month: p.lowerBound.date(calendar: calendar).formatted(.dateTime.month(.abbreviated))
            case .year: String(p.lowerBound.year)
            default: dayText(p.lowerBound)
            }
        }
        // The goal period holding the range's last day: "This week" (or the last one in a past range).
        let focusKind: PeriodKind = switch periodKind(rule) { case .month: .month; case .year: .year; default: .week }
        let focus = showsDays ? nil : period(focusKind, containing: last)
        var focusValue = 0.0
        if let p = focus {
            if case .flexible = rule.frequency { focusValue = Double(flexibleProgress(rule, on: min(p.upperBound, today)) ?? 0) }
            else { focusValue = isTotal(rule) ? periodTotal(rule, in: p) : periodCount(rule, in: p) }
        }
        var focusGoal = isTotal(rule) ? rule.goal : goal(of: rule)
        if case .flexible(_, let n) = rule.frequency { focusGoal = Double(n) }
        let focusRunning = focus.map { $0.contains(today) } ?? false
        let focusCaption = focusRunning ? "This \(goalNoun)" : "That \(goalNoun)"
        let percentOn = { (a: Double, b: Double) in ProgressMath.percent(a, b) }

        var tiles: [OverTimeTile] = []
        var pace: String?
        var change: String?
        switch shape {
        case .once:
            tiles.append(OverTimeTile(value: "\(doneDays.count) of \(daysText(counted.count))", caption: "Done",
                                      percent: percentOn(Double(doneDays.count), Double(counted.count))))
            var run = 0, longest = 0
            for d in counted { if d.mark == .done { run += 1; longest = max(longest, run) } else { run = 0 } }
            tiles.append(OverTimeTile(value: daysText(longest), caption: "Longest run"))
            if let c = counts, c.skipped > 0 { tiles.append(OverTimeTile(value: "\(c.skipped)", caption: "Skipped")) }
            if let c = counts, c.paused > 0 { tiles.append(OverTimeTile(value: "\(c.paused)", caption: "Paused")) }
        case .times, .checklist:
            let done = counted.reduce(0.0) { $0 + min($1.value, $1.goal) }
            let planned = counted.reduce(0.0) { $0 + $1.goal }
            let unit = shape == .checklist ? "" : (HabitCopy.unit(of: rule).isEmpty ? " times" : " " + HabitCopy.unit(of: rule))
            tiles.append(OverTimeTile(value: "\(HabitCopy.number(done)) of \(HabitCopy.number(planned))\(unit)",
                                      caption: shape == .checklist ? "Steps" : "Done", percent: percentOn(done, planned)))
            tiles.append(OverTimeTile(value: "\(doneDays.count) of \(counted.count)", caption: "Full days"))
            tiles.append(OverTimeTile(value: "\(counts?.part ?? 0)", caption: "Partial"))
        case .amount, .time:
            let total = list.reduce(0.0) { $0 + $1.value }
            tiles.append(OverTimeTile(value: value(total), caption: "Total"))
            if !counted.isEmpty {
                let average = (counted.reduce(0.0) { $0 + $1.value } / Double(counted.count) * 10).rounded() / 10
                tiles.append(OverTimeTile(value: value(average), caption: "Average a planned day"))
            }
            tiles.append(OverTimeTile(value: "\(doneDays.count) of \(daysText(counted.count))", caption: "Goal reached"))
            if let best = list.max(by: { $0.value < $1.value }), best.value > 0 {
                tiles.append(OverTimeTile(value: "\(value(best.value)) · \(dayText(best.day))", caption: shape == .time ? "Longest day" : "Best day"))
            }
        case .limitDay:
            let judged = counted.filter { $0.day < today }
            if !judged.isEmpty {
                let average = (judged.reduce(0.0) { $0 + $1.value } / Double(judged.count) * 10).rounded() / 10
                tiles.append(OverTimeTile(value: "\(value(average)) a day", caption: "Average"))
                tiles.append(OverTimeTile(value: "\(judged.filter { $0.mark == .done }.count) of \(daysText(judged.count))", caption: "Within the limit"))
                tiles.append(OverTimeTile(value: "\(judged.filter { $0.value == 0 }.count)", caption: "Days with none"))
                if let high = judged.max(by: { $0.value < $1.value }), high.value > 0 {
                    tiles.append(OverTimeTile(value: "\(value(high.value)) · \(dayText(high.day))", caption: "Highest day"))
                }
                // The one trend stated in words, the same colour both ways: for a limit, lower is the goal (§11.2).
                if let kind = range.kind, start < span.lowerBound {
                    let before = period(kind, containing: span.lowerBound.adding(days: -1, calendar: calendar))
                    let earlier = days(in: max(before.lowerBound, start)...before.upperBound)
                        .filter { isDue(habit, on: $0) }
                    if !earlier.isEmpty {
                        let old = (earlier.reduce(0.0) { $0 + dayProgress(of: self.rule(habit, on: $1), on: $1) } / Double(earlier.count) * 10).rounded() / 10
                        let name = range == .week ? "last week" : range == .month
                            ? "in " + before.lowerBound.date(calendar: calendar).formatted(.dateTime.month(.wide)) : "in \(before.lowerBound.year)"
                        if old != average { change = "\(average < old ? "Down" : "Up") from \(value(old)) a day \(name)" }
                    }
                }
            } else {
                tiles.append(OverTimeTile(value: value(rule.goal) + " a day", caption: "Limit"))
            }
        case .periodTimes, .periodTotal, .periodDays, .limitPeriod:
            let isLimit = shape == .limitPeriod
            let focusText = shape == .periodDays ? "\(HabitCopy.number(focusValue)) of \(HabitCopy.number(focusGoal)) days"
                : shape == .periodTimes ? "\(HabitCopy.number(focusValue)) of \(HabitCopy.number(focusGoal))"
                : "\(HabitCopy.number(focusValue)) of \(value(focusGoal))"
            let reached = isLimit ? focusValue <= focusGoal : focusValue >= focusGoal
            tiles.append(OverTimeTile(value: focusText + (focusRunning && !(reached && !isLimit) ? " so far" : ""), caption: focusCaption))
            if !results.isEmpty {
                let met = results.filter { $0.met == true }.count
                tiles.append(OverTimeTile(value: "\(met) of \(results.count)", caption: isLimit ? "Periods within" : "Periods met"))
            }
            switch shape {
            case .periodTimes:
                let times = start <= last ? periodCount(rule, in: max(span.lowerBound, start)...last) : 0
                tiles.append(OverTimeTile(value: HabitCopy.number(times), caption: "Times"))
            case .periodDays:
                let reachedDays = list.filter { $0.mark == .done }.count
                tiles.append(OverTimeTile(value: "\(reachedDays)", caption: "Days reached"))
                if isAmount { tiles.append(OverTimeTile(value: value(list.reduce(0.0) { $0 + $1.value }), caption: "Total")) }
            default: break
            }
            if !ended.isEmpty && shape != .periodDays {
                let average = (ended.reduce(0.0) { $0 + $1.value } / Double(ended.count) * 10).rounded() / 10
                tiles.append(OverTimeTile(value: "\(shape == .periodTimes ? HabitCopy.number(average) : value(average)) a \(goalNoun)", caption: "Average"))
            }
            if shape == .periodTotal, let best = ended.max(by: { $0.value < $1.value }), best.value > 0 {
                tiles.append(OverTimeTile(value: "\(value(best.value)) · \(periodName(best.period))", caption: "Best \(goalNoun)"))
            }
            if isLimit, let low = ended.min(by: { $0.value < $1.value }) {
                tiles.append(OverTimeTile(value: "\(value(low.value)) · \(periodName(low.period))", caption: "Lowest \(goalNoun)"))
            }
            // The pace line for totals and limits in the period running now (report §9.2).
            if let focus, focusRunning, shape == .periodTotal || isLimit {
                let left = days(in: today...focus.upperBound).count
                let leftText = left == 1 ? "1 day left" : "\(left) days left"
                if isLimit {
                    pace = "\(HabitCopy.number(focusValue)) of \(value(focusGoal)) so far · \(leftText)"
                } else if reached {
                    var sum = 0.0
                    let on = days(in: focus.lowerBound...today).first { sum += dayProgress(of: self.rule(habit, on: $0), on: $0); return sum >= focusGoal }
                    pace = on.map { "Reached on \(dayText($0))" }
                } else {
                    pace = "\(value(focusGoal - focusValue)) to go · \(leftText)"
                }
            }
        }

        // The chart (report §9.3): days for a week or month; weeks or months for longer ranges and period goals.
        var bucket: Calendar.Component = .day
        var bars: [OverTimeBar] = []
        var runningTotal: [OverTimePoint] = []
        var paceLine: (start: Date, end: Date, goal: Double)?
        let dateText = { (d: LocalDay) in d.date(calendar: self.calendar).formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated)) }
        func barDate(_ d: LocalDay) -> Date { calendar.startOfDay(for: d.date(calendar: calendar)) }
        let daily = range == .week || range == .month
        if showsDays && daily && !(shape == .once && range == .week) {
            if shape == .once {
                bucket = .weekOfYear
                bars = buckets(of: list.map(\.day), kind: .week, span: span).compactMap { p -> OverTimeBar? in
                    let days = counted.filter { p.contains($0.day) }
                    guard !days.isEmpty else { return nil }
                    let pct = Double(days.filter { $0.mark == .done }.count) / Double(days.count) * 100
                    return OverTimeBar(start: barDate(p.lowerBound), end: barDate(p.upperBound.adding(days: 1, calendar: calendar)),
                                       value: pct, goal: nil, light: false, over: false,
                                       label: "\(Int(pct.rounded()))% · week of \(dayText(p.lowerBound))")
                }
            } else {
                bars = list.filter { $0.mark != .before && $0.mark != .notItsDay || $0.value > 0 }.map { d -> OverTimeBar in
                    OverTimeBar(start: barDate(d.day), end: barDate(d.day.adding(days: 1, calendar: calendar)), value: d.value,
                                goal: d.goal, light: d.mark == .some && !d.rule.atMost, over: d.rule.atMost && d.mark == .missed,
                                label: "\(progressValue(d.value, d.rule)) of \(progressValue(d.goal, d.rule)) · \(dateText(d.day))")
                }
            }
        } else if showsDays && !daily {
            bucket = .month
            bars = buckets(of: list.map(\.day), kind: .month, span: span).compactMap { p -> OverTimeBar? in
                let inMonth = list.filter { p.contains($0.day) }
                let countedIn = counted.filter { p.contains($0.day) }
                let name = p.lowerBound.date(calendar: calendar).formatted(.dateTime.month(.wide).year())
                let s = barDate(p.lowerBound), e = barDate(p.upperBound.adding(days: 1, calendar: calendar))
                switch shape {
                case .amount, .time:
                    let total = inMonth.reduce(0.0) { $0 + $1.value }
                    return OverTimeBar(start: s, end: e, value: total, goal: nil, light: false, over: false, label: "\(value(total)) · \(name)")
                case .limitDay:
                    let judged = countedIn.filter { $0.day < today }
                    guard !judged.isEmpty else { return nil }
                    let average = judged.reduce(0.0) { $0 + $1.value } / Double(judged.count)
                    let limit = judged.last?.goal ?? rule.goal
                    return OverTimeBar(start: s, end: e, value: average, goal: limit, light: false, over: average > limit,
                                       label: "Avg \(value((average * 10).rounded() / 10)) a day · \(name)")
                default:
                    guard !countedIn.isEmpty else { return nil }
                    let done = shape == .once ? Double(countedIn.filter { $0.mark == .done }.count)
                        : countedIn.reduce(0.0) { $0 + min($1.value, $1.goal) }
                    let planned = shape == .once ? Double(countedIn.count) : countedIn.reduce(0.0) { $0 + $1.goal }
                    let pct = planned > 0 ? done / planned * 100 : 0
                    return OverTimeBar(start: s, end: e, value: pct, goal: nil, light: false, over: false, label: "\(Int(pct.rounded()))% · \(name)")
                }
            }
        } else if !showsDays {
            // Week, month or year goals: each day's log inside one of its periods; each period over longer ranges.
            let periodKindNow = periodKind(rule)
            let ownSize = (periodKindNow == .week && range == .week) || (periodKindNow == .month && range == .month)
            if ownSize && (shape == .periodTotal || shape == .limitPeriod) {
                var sum = 0.0
                runningTotal = list.map { d -> OverTimePoint in
                    sum += d.value
                    return OverTimePoint(date: barDate(d.day), total: sum, label: "\(value(sum)) by \(dateText(d.day))")
                }
                if let focus {
                    paceLine = (barDate(focus.lowerBound), barDate(focus.upperBound), focusGoal)
                }
            } else if ownSize || range == .week {
                bars = list.filter { $0.value > 0 }.map { d -> OverTimeBar in
                    OverTimeBar(start: barDate(d.day), end: barDate(d.day.adding(days: 1, calendar: calendar)), value: d.value,
                                goal: shape == .periodDays ? d.goal : nil, light: shape == .periodDays && d.mark == .some, over: false,
                                label: "\(progressValue(d.value, d.rule)) · \(dateText(d.day))")
                }
            } else {
                bucket = periodKindNow == .week ? .weekOfYear : periodKindNow == .year ? .year : .month
                bars = results.map { r -> OverTimeBar in
                    OverTimeBar(start: barDate(r.period.lowerBound), end: barDate(r.period.upperBound.adding(days: 1, calendar: calendar)),
                                value: r.value, goal: r.goal, light: r.met == nil, over: shape == .limitPeriod && r.value > r.goal,
                                label: (shape == .periodDays ? "\(HabitCopy.number(r.value)) days" : value(r.value)) + " · " + periodName(r.period))
                }
            }
        }
        let chartScale: OverTimeScale = bucket != .day && showsDays && [.once, .times, .checklist].contains(shape) ? .percent
            : (shape == .periodDays && bucket != .day) || shape == .periodTimes ? .amount("") : scale

        // By step (checklists): each step's share of the planned days that count.
        var steps: [OverTimeStep] = []
        if shape == .checklist {
            for step in rule.steps {
                let days = counted.filter { d in d.rule.steps.contains { $0.id == step.id } }
                let ticked = days.filter { isStepDone(step, of: habit, on: $0.day) }.count
                steps.append(OverTimeStep(id: step.id, name: step.name, ticked: ticked, days: days.count))
            }
        }

        let weekdays = showsDays && shape != .limitDay ? byWeekday(habit, in: span, today: today) : []
        let averagesByDay = shape == .amount || shape == .time

        return OverTimeSnapshot(
            range: range, span: span, title: overTimeTitle(range, span, today: today),
            canGoBack: range != .all && start < span.lowerBound,
            canGoForward: range != .all && span.upperBound < today,
            tiles: tiles, pace: pace, change: change, counts: counts, bars: bars, scale: chartScale, bucket: bucket,
            isLimit: rule.atMost, footnotes: footnotes(habit, span: span, today: today), steps: steps,
            running: runningTotal, paceLine: paceLine,
            weekdays: weekdays, weekdayCaption: HabitStore.weekdayCaption(weekdays, averages: averagesByDay),
            weekdayAverages: averagesByDay,
            rate: range == .all && showsDays && shape != .limitDay ? rate30(habit, today: today) : [])
    }

    /// The weeks or months overlapping `span`, holding at least one of `days`.
    private func buckets(of days: [LocalDay], kind: PeriodKind, span: ClosedRange<LocalDay>) -> [ClosedRange<LocalDay>] {
        var list: [ClosedRange<LocalDay>] = []
        for day in days where list.last.map({ !$0.contains(day) }) ?? true {
            list.append(period(kind, containing: day))
        }
        return list
    }

    func overTimeTitle(_ range: OverTimeRange, _ span: ClosedRange<LocalDay>, today: LocalDay) -> String {
        switch range {
        case .week: periodTitle(.week, span, today: today)
        case .month: periodTitle(.month, span, today: today)
        case .year: String(span.lowerBound.year)
        case .all: "All time"
        }
    }

    /// Plain sentences, only when they apply (report §8.3): "Goal changed from 10 to 15 min on 15 Sep.", "Counted in
    /// miles before 3 Sep.", "This habit started on 12 Mar."
    func footnotes(_ habit: Habit, span: ClosedRange<LocalDay>, today: LocalDay) -> [String] {
        var notes: [String] = []
        func dayText(_ d: LocalDay) -> String { d.date(calendar: calendar).formatted(.dateTime.day().month(.abbreviated)) }
        let start = startDay(of: habit)
        if span.contains(start) && start <= today { notes.append("This habit started on \(dayText(start)).") }
        let list = rules[habit.id] ?? []
        for (i, old) in list.enumerated() {
            let changed = old.until.adding(days: 1, calendar: calendar)
            guard span.contains(changed), changed <= today else { continue }
            var before = habit, after = habit
            old.apply(to: &before)
            if i + 1 < list.count { list[i + 1].apply(to: &after) }
            let oldUnit = HabitCopy.unit(of: before), newUnit = HabitCopy.unit(of: after)
            if oldUnit != newUnit && !oldUnit.isEmpty && !newUnit.isEmpty {
                notes.append("Counted in \(newUnit) from \(dayText(changed)); in \(oldUnit) before.")
            } else if before.goal != after.goal && before.frequency == after.frequency {
                let from = before.kind == .duration ? HabitCopy.minutes(before.goal) : HabitCopy.number(before.goal)
                let to = after.kind == .duration ? HabitCopy.minutes(after.goal) : HabitCopy.number(after.goal)
                notes.append("Goal changed from \(from) to \(to) on \(dayText(changed)).")
            } else if before.frequency != after.frequency {
                notes.append("How often changed on \(dayText(changed)): \(HabitCopy.plan(before, weekStart: settings.weekStart)) before, \(HabitCopy.plan(after, weekStart: settings.weekStart)) from then.")
            }
        }
        return notes
    }
}
