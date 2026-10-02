import Foundation

// The Week view's cards (report "Weekly Habit Cards — What Each Card Shows", 2 Oct 2026): one card per habit, with the
// goal in words, a headline on the goal's own clock, at most one further fact that no other line already says, and a
// Sun–Sat strip with each day's own mark and value. Worked out once per week in the store and kept in the snapshot,
// never in a view's body (PERFORMANCE.md rules 5 and 8).

/// One column of the week: the day and its names, made once per snapshot (not per card or per cell).
struct WeekColumn: Hashable, Identifiable {
    let day: LocalDay
    /// "Sun", in the person's language.
    let short: String
    /// "S", for the largest text sizes.
    let letter: String
    /// "Sunday 27 September", for VoiceOver.
    let spoken: String
    let isToday: Bool
    var id: LocalDay { day }
}

/// One day on a card's strip.
struct WeekCardDay: Hashable, Identifiable {
    let day: LocalDay
    let mark: HabitStore.DayMark
    /// 0...1: how much of the day's goal was reached, for part-done marks.
    let fraction: Double
    /// A limit's day that went over.
    let over: Bool
    /// Done on a day it wasn't due (shown, never dropped; report §5 row 2).
    let extra: Bool
    /// A quit habit's day with a slip.
    let slip: Bool
    /// The day's own number under the mark ("8.2k", "25m", "3"); empty for none.
    let value: String
    var id: LocalDay { day }
}

/// One habit's card for a week.
struct ProgressWeekCard: Hashable, Identifiable {
    let habit: Habit
    /// The goal in words, under the name: "8,000 steps a day", "3 times a week", "At most 10 a week".
    let goal: String
    /// The week on the goal's own clock: "4 of 5 days so far", "2 of 3 this week", "October: 1 of 2".
    let headline: String
    /// One different fact, or nil when it would only repeat the headline or the strip.
    let detail: String?
    let days: [WeekCardDay]
    /// VoiceOver: the whole card is one element (report §9).
    let accessibility: String
    /// Quit: the run going on now, shown live in place of the headline; nil while paused or in a past week.
    var runStart: Date? = nil
    var isQuit = false
    var id: UUID { habit.id }
}

extension HabitStore {
    /// The week's columns, in the person's week order.
    func weekColumns(_ span: ClosedRange<LocalDay>, today: LocalDay) -> [WeekColumn] {
        let calendar = calendar
        let short = calendar.shortStandaloneWeekdaySymbols
        let full = weekdayNames.full
        let letters = weekdayNames.veryShort
        let months = calendar.standaloneMonthSymbols
        return days(in: span).map { day in
            let w = day.weekday(calendar: calendar) - 1
            return WeekColumn(day: day, short: short[w], letter: letters[w],
                              spoken: "\(full[w]) \(day.day) \(months[day.month - 1])", isToday: day == today)
        }
    }

    /// "21–27 Sep", "27 Sep – 3 Oct"; with the year when the week isn't in the current one ("28 Dec 2025 – 3 Jan
    /// 2026", "7–13 Dec 2025"). Built from the month names, with no date formatter (as `weekSpan`).
    func weekTitle(_ span: ClosedRange<LocalDay>, today: LocalDay) -> String {
        let a = span.lowerBound, b = span.upperBound
        let months = calendar.shortStandaloneMonthSymbols
        let otherYear = a.year != today.year || b.year != today.year
        if a.year != b.year {
            return "\(a.day) \(months[a.month - 1]) \(a.year) – \(b.day) \(months[b.month - 1]) \(b.year)"
        }
        let year = otherYear ? " \(b.year)" : ""
        if a.month == b.month { return "\(a.day)–\(b.day) \(months[b.month - 1])\(year)" }
        return "\(a.day) \(months[a.month - 1]) – \(b.day) \(months[b.month - 1])\(year)"
    }

    /// "October", or "October 2025" in another year.
    func monthTitle(_ span: ClosedRange<LocalDay>, today: LocalDay) -> String {
        let name = calendar.standaloneMonthSymbols[span.lowerBound.month - 1]
        return span.lowerBound.year == today.year ? name : "\(name) \(span.lowerBound.year)"
    }

    /// "This month", "Last month", or nil for older months.
    func monthCaption(_ span: ClosedRange<LocalDay>, today: LocalDay) -> String? {
        if span.contains(today) { return "This month" }
        let lastMonth = period(.month, containing: today).lowerBound.adding(days: -1, calendar: calendar)
        return span.contains(lastMonth) ? "Last month" : nil
    }

    /// The month grid's empty places before the 1st, in the person's week order.
    func monthLead(_ span: ClosedRange<LocalDay>) -> Int {
        (span.lowerBound.weekday(calendar: calendar) - calendar.firstWeekday + 7) % 7
    }

    /// The weekday letters in the person's week order: "S M T W T F S".
    func orderedWeekdayLetters() -> [String] {
        let letters = weekdayNames.veryShort
        let first = calendar.firstWeekday - 1
        return (0..<7).map { letters[(first + $0) % 7] }
    }

    /// "This week", "Last week", or nil for older weeks (the dates say it).
    func weekCaption(_ span: ClosedRange<LocalDay>, today: LocalDay) -> String? {
        if span.contains(today) { return "This week" }
        if span.contains(today.adding(days: -7, calendar: calendar)) { return "Last week" }
        return nil
    }

    /// Every card for the week: the habits in their order, then quit habits, and archived habits apart.
    func progressWeekCards(_ tracked: [Habit], quitting: [Habit], in span: ClosedRange<LocalDay>, range: ProgressRange = .week,
                           today: LocalDay) -> (cards: [ProgressWeekCard], archived: [ProgressWeekCard]) {
        var cards: [ProgressWeekCard] = [], archived: [ProgressWeekCard] = []
        for habit in tracked {
            guard let card = perfTimed("Progress \(range): one card", { weekCard(habit, in: span, range: range, today: today) }) else { continue }
            if habit.archived { archived.append(card) } else { cards.append(card) }
        }
        let now = clock()
        for habit in quitting {
            cards.append(perfTimed("Progress \(range): one quit card") { weekQuitCard(habit, in: span, range: range, today: today, now: now) })
        }
        return (cards, archived)
    }

    // MARK: One habit

    /// One habit's card, or nil when the week has nothing to say about it (a past week before it began, or an archived
    /// habit with nothing that week).
    /// Week or Month (the user, 2 Oct 2026: Month the same as Week, for seeing patterns). Month cards carry no values
    /// under the marks; their headlines count the month on the goal's own clock.
    func weekCard(_ habit: Habit, in span: ClosedRange<LocalDay>, range: ProgressRange = .week, today: LocalDay) -> ProgressWeekCard? {
        let noun = range.noun
        let start = startDay(of: habit)
        let running = span.contains(today)
        let dayList = days(in: span)
        // Not begun yet: shown only in the current week, saying when it starts.
        if start > today {
            guard running && !habit.archived else { return nil }
            let strip = dayList.map { WeekCardDay(day: $0, mark: .before, fraction: 0, over: false, extra: false, slip: false, value: "") }
            let text = "Starts " + PauseSheet.short(start, calendar: calendar)
            return ProgressWeekCard(habit: habit, goal: weekGoalText(habit), headline: text, detail: nil, days: strip,
                                    accessibility: habit.name + ". " + text + ".")
        }
        guard start <= span.upperBound else { return nil }
        let last = min(span.upperBound, today)
        let rule = rule(habit, on: max(last, start))
        let shape = progressShape(rule)
        let unit = HabitCopy.unit(of: rule)

        // Each day: its mark, its value, and whether it was an extra day (done on a day it wasn't due).
        var strip: [WeekCardDay] = []
        var amounts: [LocalDay: Double] = [:]
        for day in dayList {
            var mark = dayMark(habit, on: day, relativeTo: today)
            let dayRule = self.rule(habit, on: day)
            let amount = day >= start && day <= today ? dayProgress(of: dayRule, on: day) : 0
            amounts[day] = amount
            // A week, month or year goal names no day, so a day still to come isn't "due later": nothing is asked of it.
            if mark == .upcoming && (!dayRule.frequency.isDayBased || dayRule.frequency.isFlexible) { mark = .notItsDay }
            var extra = false
            if mark == .notItsDay && amount > 0 && dayRule.frequency.isDayBased && !dayRule.frequency.isFlexible && !dayRule.atMost {
                extra = true
                mark = isDayMet(dayRule, on: day) ? .done : .some
            }
            let fraction = mark == .done ? 1 : mark == .some ? min(1, amount / max(dayGoal(of: dayRule), 1)) : 0
            strip.append(WeekCardDay(day: day, mark: mark, fraction: fraction, over: mark == .missed && dayRule.atMost,
                                    extra: extra, slip: false, value: range == .week ? weekValue(amount, dayRule, shape: shape, mark: mark) : ""))
        }

        // Days that count for a day goal: done (not extra) any day up to today; part done or not done once it's over.
        let counted = strip.filter { !$0.extra && ($0.mark == .done || ($0.day < today && ($0.mark == .some || $0.mark == .missed))) }
        let doneDays = counted.filter { $0.mark == .done }.count
        let extraDays = strip.filter { $0.extra && $0.mark == .done }.count
        let soFar = running ? " so far" : ""
        let when = running ? "this \(noun)" : "that \(noun)"
        let total = strip.reduce(0.0) { $0 + (amounts[$1.day] ?? 0) }
        func dayCount(_ n: Int) -> String { n == 1 ? "1 day" : "\(n) days" }
        func of(_ done: Int, _ all: Int) -> String { "\(done) of \(dayCount(all))\(soFar)" }
        func plusExtra() -> String? { extraDays == 0 ? nil : extraDays == 1 ? "+1 extra day" : "+\(extraDays) extra days" }

        var headline: String
        var detail: String?
        switch shape {
        case .once:
            headline = of(doneDays, counted.count)
            detail = plusExtra()
        case .times:
            headline = "Full on " + of(doneDays, counted.count)
            detail = total > 0 ? HabitCopy.amount(total, unit.isEmpty ? "times" : unit) + " " + when : plusExtra()
        case .amount, .time:
            headline = "Reached on " + of(doneDays, counted.count)
            detail = total > 0 ? progressValue(total, rule) + " " + when : plusExtra()
        case .checklist:
            headline = "Every step on " + of(doneDays, counted.count)
            detail = checklistDetail(habit, counted: counted.map(\.day))
        case .limitDay:
            // Judged once each day is over (report §11.2): today waits.
            let judged = counted.filter { $0.day < today }
            let within = judged.filter { $0.mark == .done }.count
            if judged.isEmpty {
                let now = amounts[today] ?? 0
                headline = running ? "\(progressValue(now, rule)) of \(progressValue(rule.goal, rule)) so far today"
                    : "Nothing judged that \(noun)"
            } else {
                headline = "Within limit on \(within) of \(dayCount(judged.count))"
            }
            detail = total > 0 && !judged.isEmpty ? progressValue(total, rule) + " " + when : nil
        case .periodTimes, .periodTotal, .periodDays, .limitPeriod:
            (headline, detail) = weekPeriodText(habit, rule: rule, shape: shape, span: span, range: range, today: today, strip: strip,
                                                amounts: amounts, total: total)
        }

        // Day goals with nothing to count yet: say what the week holds instead of "0 of 0 days".
        if counted.isEmpty && shape != .limitDay && rule.frequency.isDayBased && !rule.frequency.isFlexible {
            let next = strip.first { $0.mark == .upcoming || $0.mark == .open || ($0.day == today && $0.mark == .some && !$0.extra) }
            if start == today && running {
                headline = "Started today"
            } else if let next {
                headline = next.day == today ? "Due today"
                    : range == .week ? "Due " + weekdayNames.full[next.day.weekday(calendar: calendar) - 1]
                    : "Due " + PauseSheet.short(next.day, calendar: calendar)
            } else {
                headline = running ? "Not due this \(noun)" : "Not due that \(noun)"
                if extraDays == 0 && total == 0 { detail = running ? nextDueText(habit, after: span.upperBound) : nil }
            }
        }
        if running, !habit.archived, let pause = pause(of: habit, on: today), pause.contains(today) {
            headline = HabitPageView.pausedText(pause, store: self)
            detail = nil
        }
        // An archived habit with nothing in the week is left out.
        let anything = strip.contains { $0.mark == .done || $0.mark == .some || $0.mark == .missed }
        if habit.archived && !anything && total == 0 { return nil }

        return ProgressWeekCard(habit: habit, goal: weekGoalText(rule), headline: headline, detail: detail, days: strip,
                                accessibility: weekSpoken(habit.name, headline: headline, detail: detail,
                                                          days: range == .week ? strip : [], atMost: rule.atMost))
    }

    /// Week, month and year goals (shapes F, G, H and I-period) seen in a week.
    private func weekPeriodText(_ habit: Habit, rule: Habit, shape: ProgressShape, span: ClosedRange<LocalDay>,
                                range: ProgressRange, today: LocalDay, strip: [WeekCardDay], amounts: [LocalDay: Double],
                                total: Double) -> (String, String?) {
        let running = span.contains(today)
        let kind = periodKind(rule)
        let noun = range.noun
        let this = running ? " this \(noun)" : ""
        let thisOrThat = running ? " this \(noun)" : " that \(noun)"
        let loggedDays = strip.filter { (amounts[$0.day] ?? 0) > 0 }.count
        func count(_ v: Double) -> String { HabitCopy.number(v) }
        func onDays(_ n: Int) -> String? { n == 0 ? nil : n == 1 ? "on 1 day" : "on \(n) days" }
        let isAmount: Bool
        switch rule.kind {
        case .amount, .duration: isAmount = true
        default: isAmount = false
        }

        if kind == range.goalPeriod {
            guard let result = progressPeriodResults(habit, in: span, today: today).last else {
                return (running ? "Nothing yet this \(noun)" : "Nothing that \(noun)", nil)
            }
            let v = result.value, g = result.goal
            let daysLeft = running ? today.days(to: span.upperBound, calendar: calendar) + 1 : 0
            func toGo(_ left: Double, _ word: String) -> String {
                let rest = daysLeft == 1 ? "1 day left" : "\(daysLeft) days left"
                return "\(count(left)) \(word) · \(rest)"
            }
            switch shape {
            case .limitPeriod:
                let head = "\(progressValue(v, rule)) of \(progressValue(g, rule))" + this
                let over = v > g ? progressValue(v - g, rule) + " over" : nil
                return (head, [over, onDays(loggedDays)].compactMap { $0 }.joined(separator: " · ").nilIfEmpty)
            case .periodTotal:
                return ("\(progressValue(v, rule)) of \(progressValue(g, rule))", onDays(loggedDays))
            case .periodDays:
                let head = "\(count(min(v, g))) of \(count(g)) days" + this
                if isAmount && total > 0 { return (head, progressValue(total, rule) + thisOrThat) }
                if v > g { return (head, v - g == 1 ? "+1 extra day" : "+\(count(v - g)) extra days") }
                if running && v < g { return (head, toGo(g - v, "to go")) }
                return (head, nil)
            default: // .periodTimes
                let head = "\(count(min(v, g))) of \(count(g))" + this
                if v > g { return (head, "+\(count(v - g)) extra") }
                if running && v < g { return (head, toGo(g - v, "to go")) }
                return (head, nil)
            }
        }

        // A shorter goal seen over a longer view (a week goal on Month): how many of its weeks were met, and what was
        // done in all. The week still running counts once it's met.
        if Self.rank(kind) < Self.rank(range.goalPeriod) {
            let results = progressPeriodResults(habit, in: span, today: today)
            let met = results.filter { $0.met == true }.count
            let judged = results.filter { $0.met != nil }.count
            func periods(_ n: Int) -> String { kind == .week ? (n == 1 ? "week" : "weeks") : (n == 1 ? "month" : "months") }
            let head: String
            if shape == .limitPeriod {
                head = "Within the limit \(met) of \(judged) \(periods(judged))"
            } else {
                head = "Met \(met) of \(results.count) \(periods(results.count))" + (running ? " so far" : "")
            }
            let done: String?
            switch shape {
            case .periodTotal, .limitPeriod: done = total > 0 ? progressValue(total, rule) + thisOrThat : nil
            case .periodDays:
                done = isAmount && total > 0 ? progressValue(total, rule) + thisOrThat
                    : loggedDays == 0 ? nil : (loggedDays == 1 ? "1 day" : "\(loggedDays) days") + thisOrThat
            default:
                let times = periodCount(rule, in: span)
                done = times == 0 ? nil : (times == 1 ? "1 time" : "\(count(times)) times") + thisOrThat
            }
            return (results.isEmpty ? (running ? "Nothing yet this \(noun)" : "Nothing that \(noun)") : head, done)
        }

        // A longer goal (a month or year goal on Week, a year goal on Month): the period that holds today (or, for a
        // past view, its last day), named.
        let anchor = running ? today : span.upperBound
        let periodSpan = period(kind == .year ? .year : .month, containing: anchor)
        let name = kind == .year ? String(periodSpan.lowerBound.year)
            : calendar.standaloneMonthSymbols[periodSpan.lowerBound.month - 1]
        let week = thisOrThat
        let detail: String?
        switch shape {
        case .periodTimes:
            let times = periodCount(rule, in: span)
            detail = times == 0 ? nil : (times == 1 ? "1 time" : "\(count(times)) times") + week
        case .periodDays:
            detail = isAmount && total > 0 ? progressValue(total, rule) + week
                : loggedDays == 0 ? nil : (loggedDays == 1 ? "1 day" : "\(loggedDays) days") + week
        default:
            detail = total > 0 ? progressValue(total, rule) + week : nil
        }
        guard let result = progressPeriodResults(habit, in: periodSpan, today: today).last else {
            return ("\(name): nothing yet", detail)
        }
        let value: String, goal: String
        switch shape {
        case .periodTotal, .limitPeriod:
            value = progressValue(result.value, rule); goal = progressValue(result.goal, rule)
        default:
            value = count(result.value); goal = count(result.goal)
        }
        return ("\(name): \(value) of \(goal)", detail)
    }

    /// "22 of 24 steps · SPF missed twice"; nil when every step was done on every counted day.
    private func checklistDetail(_ habit: Habit, counted: [LocalDay]) -> String? {
        var done = 0, planned = 0
        var missed: [UUID: Int] = [:]
        var names: [UUID: String] = [:]
        var order: [UUID] = []
        for day in counted {
            let dayRule = rule(habit, on: day)
            let ticked = Set(entries(of: habit.id, on: day).compactMap(\.stepID))
            for step in dayRule.steps {
                planned += 1
                if ticked.contains(step.id) { done += 1; continue }
                if names[step.id] == nil { names[step.id] = step.name; order.append(step.id) }
                missed[step.id, default: 0] += 1
            }
        }
        guard planned > 0, done < planned else { return nil }
        let steps = "\(done) of \(planned) steps"
        // The step missed most; the first in the list when several are missed as often.
        guard let most = missed.values.max(), let first = order.first(where: { missed[$0] == most }),
              let name = names[first], !name.isEmpty else { return steps }
        return "\(steps) · \(name) missed " + (most == 1 ? "once" : most == 2 ? "twice" : "\(most) times")
    }

    /// "Next due Mon 12 Oct" for a schedule whose next due day is after this week; nil when none within four months.
    private func nextDueText(_ habit: Habit, after day: LocalDay) -> String? {
        var cursor = day.adding(days: 1, calendar: calendar)
        for _ in 0..<124 {
            if isDue(habit, on: cursor) { return "Next due " + PauseSheet.short(cursor, calendar: calendar) }
            cursor = cursor.adding(days: 1, calendar: calendar)
        }
        return nil
    }

    /// The goal in words under a card's name.
    func weekGoalText(_ habit: Habit) -> String {
        if habit.kind == .checklist {
            let n = habit.steps.count
            let steps = n == 1 ? "1 step" : "\(n) steps"
            if case .daily = habit.frequency { return "\(steps) a day" }
            let rhythm = HabitCopy.rhythm(habit.frequency, weekStart: settings.weekStart, short: true)
            return rhythm.isEmpty ? steps : "\(steps), \(rhythm)"
        }
        return HabitCopy.capitalized(HabitCopy.plan(habit, weekStart: settings.weekStart, short: true))
    }

    /// The number under a day's mark: counted habits only, and only when something was logged.
    private func weekValue(_ amount: Double, _ rule: Habit, shape: ProgressShape, mark: DayMark) -> String {
        guard amount > 0 else { return "" }
        switch rule.kind {
        case .duration: return Self.compactMinutes(amount)
        case .checklist:
            return mark == .some ? "\(Int(amount))/\(Int(dayGoal(of: rule)))" : ""
        case .check:
            // A plain tick says nothing a mark doesn't; several in a day say how many.
            return dayGoal(of: rule) > 1 || amount > 1 ? Self.compactNumber(amount) : ""
        default:
            return Self.compactNumber(amount)
        }
    }

    /// "8", "2.5", "9.1k", "10k", "123k", "1.2M": short enough for a seventh of the card.
    nonisolated static func compactNumber(_ value: Double) -> String {
        func trimmed(_ v: Double) -> String {
            let r = (v * 10).rounded() / 10
            return r == r.rounded() ? String(Int(r)) : String(format: "%.1f", r)
        }
        switch value {
        case ..<1000: return trimmed(value)
        case ..<100_000: return trimmed(value / 1000) + "k"
        case ..<1_000_000: return String(Int((value / 1000).rounded())) + "k"
        default: return trimmed(value / 1_000_000) + "M"
        }
    }

    /// "25m", "2h", "1h30".
    nonisolated static func compactMinutes(_ value: Double) -> String {
        let total = Int(value.rounded())
        if total < 60 { return "\(total)m" }
        let h = total / 60, m = total % 60
        return m == 0 ? "\(h)h" : "\(h)h\(m < 10 ? "0" : "")\(m)"
    }

    private func weekSpoken(_ name: String, headline: String, detail: String?, days: [WeekCardDay], atMost: Bool) -> String {
        let full = weekdayNames.full
        var spoken = name + ". " + headline + "."
        if let detail { spoken += " " + detail + "." }
        // Month cards say their numbers only: thirty-one days read aloud is noise.
        guard !days.isEmpty else { return spoken }
        spoken += " " + days.compactMap { day -> String? in
            guard day.mark != .before else { return nil }
            var words = full[day.day.weekday(calendar: calendar) - 1] + " " + (day.extra ? "extra, " : "")
                + (day.slip ? "slip" : day.mark.words(atMost: atMost).lowercased())
            if !day.value.isEmpty { words += ", " + day.value }
            return words
        }.joined(separator: ", ") + "."
        return spoken
    }

    // MARK: Quit

    /// A quit habit's card: the run going on now, and this week's slips (report §5 row 15). Best and average runs stay
    /// on the habit's page.
    func weekQuitCard(_ habit: Habit, in span: ClosedRange<LocalDay>, range: ProgressRange = .week, today: LocalDay,
                      now: Date) -> ProgressWeekCard {
        let stats = quitStats(of: habit, in: span, now: now)
        let running = span.contains(today)
        var perDay: [LocalDay: Int] = [:]
        for slip in stats.slips { perDay[self.today(now: slip), default: 0] += 1 }
        let strip = stats.marks.map { mark -> WeekCardDay in
            let n = perDay[mark.day] ?? 0
            // A day still to come is "due later this week" for a quit habit too (every day counts), not "not scheduled".
            let shown: DayMark = mark.day > today && mark.mark == .notItsDay ? .upcoming : mark.mark
            return WeekCardDay(day: mark.day, mark: shown, fraction: mark.fraction, over: false, extra: false,
                               slip: n > 0, value: n > 1 && range == .week ? "\(n)×" : "")
        }
        let count = stats.slips.count
        let when = running ? "this \(range.noun)" : "that \(range.noun)"
        let slips = count == 0 ? "No slips \(when)" : count == 1 ? "1 slip \(when)" : "\(count) slips \(when)"
        let paused = running && isPaused(habit, on: today)
        var card: ProgressWeekCard
        if running && !paused {
            let current = quitHistory(of: habit, now: now).last.flatMap { $0.endedBy == .ongoing ? $0.start : nil }
            let headline = current.map { "Current run " + ProgressQuitRowView.short(now.timeIntervalSince($0)) } ?? slips
            card = ProgressWeekCard(habit: habit, goal: quitGoalText(habit), headline: headline,
                                    detail: current == nil ? nil : slips, days: strip,
                                    accessibility: weekSpoken(habit.name, headline: headline, detail: current == nil ? nil : slips,
                                                              days: range == .week ? strip : [], atMost: false))
            card.runStart = current
        } else {
            let headline = paused ? "Paused" : slips
            let detail = paused ? slips : nil
            card = ProgressWeekCard(habit: habit, goal: quitGoalText(habit), headline: headline, detail: detail, days: strip,
                                    accessibility: weekSpoken(habit.name, headline: headline, detail: detail,
                                                              days: range == .week ? strip : [], atMost: false))
        }
        card.isQuit = true
        return card
    }

    /// "Quit · since 20 Sep".
    private func quitGoalText(_ habit: Habit) -> String {
        "Quit · since " + PauseSheet.short(quitStartDay(of: habit), calendar: calendar)
    }
}

private extension String {
    var nilIfEmpty: String? { isEmpty ? nil : self }
}
