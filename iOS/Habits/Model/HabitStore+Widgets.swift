import Foundation
import Observation
import WidgetKit

// The widgets' snapshot (Implementation Spec — Every Widget, 6 Oct 2026). Every number, word and order is worked out
// here from the store's own functions, the ones Today and Progress use, so a widget never disagrees with the app
// (Feature Ledger C040). Each habit's seven days are remembered (`widgetProjectionCache`) until that habit's data
// changes (S5); the lists are put together from them in Today's order (U13).

extension HabitStore {
    static func widgetSignature(_ habit: Habit) -> String {
        ReminderIdentity.signature(habit)
    }

    /// The name a Today card has on a widget ("Morning", "Quit or Cut Down").
    func widgetCardName(_ card: String) -> String {
        card == .quittingCard ? "Quit or Cut Down" : section(card).name
    }

    /// - Parameters:
    ///   - previous: the snapshot the widgets show now. With `hold`, today's lists keep its order until `hold`
    ///     (a run of taps on a widget moves nothing, U4); afterwards done rows sink (U13).
    func widgetSnapshot(now: Date = .now, hidden: Bool = false, previous: WidgetSnapshot? = nil, hold: Date? = nil) -> WidgetSnapshot {
        let first = today(now: now)
        let weekdays = widgetWeekdays(first)
        if hidden {
            let frames = (0..<7).map { offset in
                let day = first.adding(days: offset, calendar: calendar), bounds = dayBounds(day)
                return WidgetFrame(day: day.key, start: bounds.lowerBound, end: bounds.upperBound.addingTimeInterval(1), items: [])
            }
            return WidgetSnapshot(generated: now, timeZone: calendar.timeZone.identifier, locale: Locale.current.identifier,
                                  plus: isPlus, hidden: true, weekdays: weekdays, frames: frames)
        }
        prepareWidgetContext(now: now)
        let active = habits.filter { !$0.archived }
        for habit in active where widgetProjectionCache[habit.id] == nil || timers[habit.id] != nil {
            widgetProjectionCache[habit.id] = widgetItems(habit, first: first, now: now)
        }
        let cards = todayCards
        let sinkDone = (UserDefaults.standard.string(forKey: Preferences.doneOrder) ?? DoneOrder.bottom.rawValue) != DoneOrder.inPlace.rawValue
        var frames = (0..<7).map { offset -> WidgetFrame in
            let day = first.adding(days: offset, calendar: calendar), bounds = dayBounds(day)
            let items = active.compactMap { widgetProjectionCache[$0.id]?[offset] }
            return WidgetFrame(day: day.key, start: bounds.lowerBound, end: bounds.upperBound.addingTimeInterval(1),
                               items: items, lists: Self.widgetLists(items, cards: cards, sinkDone: sinkDone))
        }
        if let hold, hold > now, let previous, let shown = previous.frames.first(where: { $0.day == frames[0].day }) {
            // Today's lists keep the order on screen now (the held one, if it's still holding), with anything new at
            // its settled place's end and anything gone left out.
            let stillHolding = shown.settle.map { now < $0 } ?? false
            let onScreen = (stillHolding ? shown.held : nil) ?? shown.lists
            var held: [String: [String]] = [:]
            for (key, settled) in frames[0].lists {
                let members = Set(settled)
                let kept = (onScreen[key] ?? []).filter { members.contains($0) }
                let keptSet = Set(kept)
                held[key] = kept + settled.filter { !keptSet.contains($0) }
            }
            frames[0].held = held
            frames[0].settle = hold
        }
        let taskCards = cards.filter { $0 != .quittingCard }
        return WidgetSnapshot(
            generated: now, timeZone: calendar.timeZone.identifier, locale: Locale.current.identifier, plus: isPlus, hidden: false,
            sections: cards.map { WidgetSection(id: $0, name: widgetCardName($0)) },
            taskSections: taskCards.map { WidgetSection(id: $0, name: widgetCardName($0)) },
            choices: active.filter { $0.kind != .task }.map { WidgetChoice(id: $0.id.uuidString, name: $0.name) },
            weekdays: weekdays,
            timerOpensScreen: UserDefaults.standard.bool(forKey: Preferences.timerScreen),
            frames: frames)
    }

    /// Each list in Today's order: the cards as the person arranged them, and in each card the person's own order of
    /// habits and tasks, done ones last when they sink (`PartSection`, U13). A habit in two sections shows in each
    /// section's list and once in the Today list, at its first.
    static func widgetLists(_ items: [WidgetItem], cards: [String], sinkDone: Bool) -> [String: [String]] {
        var lists: [String: [String]] = [:]
        var habitsToday: [String] = [], tasksToday: [String] = []
        var seenHabits = Set<String>(), seenTasks = Set<String>()
        for card in cards {
            let members = items.filter { $0.cards.contains(card) }
            let ordered = sinkDone ? members.filter { !$0.sinks } + members.filter(\.sinks) : members
            let habits = ordered.filter { !$0.isTask }.map(\.id), tasks = ordered.filter(\.isTask).map(\.id)
            lists["habits:" + card] = habits
            if card != .quittingCard { lists["tasks:" + card] = tasks }
            for id in habits where seenHabits.insert(id).inserted { habitsToday.append(id) }
            for id in tasks where seenTasks.insert(id).inserted { tasksToday.append(id) }
        }
        lists["habits"] = habitsToday
        lists["tasks"] = tasksToday
        return lists
    }

    /// "Sun" … "Sat" from the person's week start.
    private func widgetWeekdays(_ day: LocalDay) -> [String] {
        let span = period(.week, containing: day)
        return weekColumns(span, today: day).map(\.short)
    }

    private func prepareWidgetContext(now: Date) {
        let streaks = (UserDefaults.standard.object(forKey: ProgressOptions.showStreaks) as? Bool) ?? true
        let screen = UserDefaults.standard.bool(forKey: Preferences.timerScreen)
        let context = "\(today(now: now).key)|\(calendar.timeZone.identifier)|\(Locale.current.identifier)|\(settings.weekStart)|\(settings.dayEndHour)|\(streaks)|\(screen)|\(todayCards)"
        if widgetProjectionContext != context { widgetProjectionCache = [:]; widgetProjectionContext = context }
    }

    /// Work stays on the store's actor; yield between items instead of blocking a frame for the whole corpus.
    func preparedWidgetSnapshot(now: Date = .now, hidden: Bool = false, previous: WidgetSnapshot? = nil, hold: Date? = nil) async -> WidgetSnapshot {
        if hidden { return widgetSnapshot(now: now, hidden: true) }
        prepareWidgetContext(now: now)
        let first = today(now: now)
        for id in habits.filter({ !$0.archived }).map(\.id) {
            if Task.isCancelled { return widgetSnapshot(now: now, hidden: true) }
            // A previous yield may have allowed an edit or deletion; project the current rule.
            guard let habit = habits.first(where: { $0.id == id && !$0.archived }) else { continue }
            if widgetProjectionCache[habit.id] == nil || timers[habit.id] != nil {
                widgetProjectionCache[habit.id] = perfTimed("Widgets: one habit's week") { widgetItems(habit, first: first, now: now) }
                await Task.yield()
            }
        }
        return perfTimed("Widgets: the snapshot") { widgetSnapshot(now: now, previous: previous, hold: hold) }
    }

    // MARK: One habit's seven days

    private func widgetItems(_ habit: Habit, first: LocalDay, now: Date) -> [WidgetItem] {
        let signature = Self.widgetSignature(habit)
        let showStreaks = (UserDefaults.standard.object(forKey: ProgressOptions.showStreaks) as? Bool) ?? true
        let heat = habit.kind == .task ? [] : HeatPalette.widgetSteps(habit.color)
        return (0..<7).map { offset in
            let day = first.adding(days: offset, calendar: calendar)
            let moment = max(now, dayBounds(day).lowerBound)
            var item = widgetItem(habit, on: day, now: moment, isToday: offset == 0, signature: signature, showStreaks: showStreaks)
            item.heat = heat
            return item
        }
    }

    /// One habit or task on one day, as every widget shows it.
    func widgetItem(_ habit: Habit, on day: LocalDay, now: Date, isToday: Bool, signature: String, showStreaks: Bool) -> WidgetItem {
        let id = habit.id.uuidString
        let rule = rule(habit, on: day)
        let paused = isPaused(habit, on: day)
        let skipped = isSkipped(habit, on: day)
        let started = startDay(of: habit) <= day
        let ended = habit.endsOn.map { day > $0 } ?? false
        let quit = habit.kind == .quit
        let due = quit ? (started && !paused && !ended) : isDue(habit, on: day, now: now, countingSkips: false)
        var item = WidgetItem(id: id, name: habit.name, symbol: habit.symbol, color: habit.color.rawValue,
                              type: Self.widgetType(rule), isTask: habit.kind == .task, limit: rule.atMost && habit.kind != .task,
                              line: "", value: "", token: UUID().uuidString, signature: signature)
        // Where Today shows it on this day (`TodayView`): quit habits and limits in Quit or Cut Down, the rest in their
        // times of day. Paused habits aren't in the lists (Today folds them into Paused).
        if due && !paused {
            if habit.isQuitOrLimit { item.cards = [.quittingCard] }
            else {
                var seen = Set<String>()
                item.cards = placements(of: habit).map(\.section).filter { seen.insert($0).inserted }
            }
        }
        if paused {
            item.state = "paused"
            let through = pause(of: habit, on: day)?.through
            item.value = "Paused"; item.line = "Paused"; item.big = "Paused"
            item.caption = through.map { "Until " + PauseSheet.short($0.adding(days: 1, calendar: calendar), calendar: calendar) } ?? "Paused"
        } else if skipped && !quit {
            item.state = "skipped"
            item.value = isToday ? "Skipped today" : "Skipped"; item.line = item.value; item.big = "Skipped"
            item.caption = item.value
            item.sinks = true
        } else if !due {
            item.state = "notPlanned"
            if habit.kind == .task, let date = habit.dueDay, date > day {
                item.value = "Planned for " + PauseSheet.short(date, calendar: calendar)
            } else {
                item.value = "Not planned today"
            }
            item.line = item.value; item.big = "Not planned"; item.caption = "Not planned"
        }
        if quit { fillQuit(&item, habit, on: day, now: now, planned: due && !paused) }
        else if habit.kind == .task { fillTask(&item, habit, on: day, now: now, planned: due) }
        else { fillHabit(&item, habit, rule: rule, on: day, now: now, planned: due && !paused && !skipped, showStreaks: showStreaks) }
        // A neutral row opens Day details for that day: quick logging is off (Implementation Spec §3).
        if item.state != nil {
            item.action = .open
            item.route = item.url.absoluteString
            item.actionText = nil
            item.done = false
        }
        // The day bar's own counting (`outcome`): positive items once; quit, cut down and skipped days aren't counted.
        if !item.cards.isEmpty && !skipped {
            switch outcome(habit, on: day, today: day) {
            case .done: item.counts = true; item.countsDone = true
            case .part, .notDone, .open: item.counts = true
            case .neutral: break
            }
        }
        if !item.cards.isEmpty {
            // A carried-over task says where it came from instead of its section (`taskLine`).
            let carried = habit.kind == .task && habit.dueDay.map { $0 < day } == true
            item.place = item.cards[0] == .quittingCard || carried ? "" : widgetCardName(item.cards[0])
            item.todayLine = [item.place, item.line].filter { !$0.isEmpty }.joined(separator: " · ")
        }
        if habit.kind != .task {
            let span = period(.week, containing: day)
            let cells = heatCells(habit, in: span, range: .week, today: day)
            item.week = cells.map(Self.widgetCell)
            item.weekToday = span.lowerBound.days(to: day, calendar: calendar)
        }
        return item
    }

    static func widgetCell(_ cell: HeatCell) -> Int {
        switch cell {
        case .blank: WidgetCell.blank
        case .upcoming: WidgetCell.upcoming
        case .off(.notScheduled): WidgetCell.notScheduled
        case .off(.skipped): WidgetCell.skipped
        case .off(.paused): WidgetCell.paused
        case .level(let n): max(0, min(5, n))
        }
    }

    static func widgetType(_ rule: Habit) -> String {
        switch rule.kind {
        case .check: "check"
        case .amount: "amount"
        case .duration: "duration"
        case .checklist: "checklist"
        case .quit: "quit"
        case .task: "task"
        }
    }

    // MARK: Words and numbers

    private func fillTask(_ item: inout WidgetItem, _ habit: Habit, on day: LocalDay, now: Date, planned: Bool) {
        let done = isDone(habit, on: day)
        if item.state == nil {
            var parts: [String] = []
            if let due = habit.dueDay, due < day {
                parts.append("From " + due.date(calendar: calendar).formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated)))
            }
            if let minute = habit.dueMinute { parts.append(DaySection.clock(minute)) }
            item.line = parts.joined(separator: " · ")
            item.value = done ? "Done" : "For today"
            item.big = done ? "Done" : "Not yet"
            item.action = .check
            item.done = done
            item.sinks = done
            item.fraction = done ? 1 : nil
            item.cardFraction = done ? 1 : 0
        }
    }

    private func fillQuit(_ item: inout WidgetItem, _ habit: Habit, on day: LocalDay, now: Date, planned: Bool) {
        let history = quitHistory(of: habit, now: now)
        let current = planned ? history.last.flatMap { $0.endedBy == .ongoing ? $0.start : nil } : nil
        let earlier = history.filter { $0.endedBy != .ongoing }.map { $0.length(now: now) }.max()
        item.quitStart = current
        item.quitBest = earlier.flatMap { $0 > 0 ? $0 : nil }
        item.quitBestText = item.quitBest.map { "Best " + Self.widgetRunText($0) }
        if let current {
            let sameDay = today(now: current) == today(now: now)
            item.since = "Since " + (sameDay ? current.formatted(date: .omitted, time: .shortened)
                                     : current.formatted(.dateTime.day().month(.abbreviated)))
            // The counter is a stable fact: it runs on past the snapshot's week, up to a known pause or end.
            let nextPause = (pauses[habit.id] ?? []).filter { $0.from > day }.map { dayBounds($0.from).lowerBound }.min()
            let ending = habit.endsOn.map { dayBounds($0).upperBound.addingTimeInterval(1) }
            item.quitUntil = min(nextPause ?? .distantFuture, ending ?? .distantFuture)
        }
        if item.state == nil {
            item.line = item.since ?? ""
            item.value = item.since ?? ""
            item.caption = item.quitBestText ?? item.since
            item.lock = current.map { Self.widgetRunText(now.timeIntervalSince($0), compact: true) }
        }
        // Record a slip opens straight on its sheet; a slip is never logged from a widget tap (C090).
        item.action = .open
        item.route = "oftenenough://slip/" + item.id
    }

    private func fillHabit(_ item: inout WidgetItem, _ habit: Habit, rule: Habit, on day: LocalDay, now: Date, planned: Bool,
                           showStreaks: Bool) {
        let progress = progress(of: habit, on: day, now: now)
        let goal = goal(of: rule)
        let period = !rule.frequency.isDayBased ? periodKind(rule) : .day
        let running = timers[habit.id] != nil && day == today(now: now)
        let dayGoal = dayGoal(of: rule)
        let todayAmount = dayProgress(of: habit, on: day, now: now)
        let complete = isComplete(habit, on: day)
        let slotted = !slots(of: habit).isEmpty
        if showStreaks {
            let n = streak(of: habit, asOf: day)
            item.streak = n > 0 ? rule.frequency.streakUnit.short(n) : nil
        }
        // The bar toward the goal's own period (Small and weekly cards), and today's row fill only toward a real daily
        // goal (U25). Limits fill neutral grey.
        let periodFraction = goal > 0 ? max(0, progress / goal) : 0
        item.cardFraction = periodFraction
        item.ring = rule.atMost ? nil : min(1, periodFraction)
        if rule.atMost {
            item.limitFill = true
            item.fraction = periodFraction
        } else if period == .day {
            item.fraction = dayGoal > 0 ? max(0, todayAmount / dayGoal) : 0
        }
        // Positive completion only: a limit never turns the habit's colour (U2, U25).
        item.done = !rule.atMost && complete
        // Quit or Cut Down never sinks: nothing in it is "done" (Today's card keeps the person's order as it is).
        item.sinks = !rule.atMost && PartSectionDone.isDone(self, habit, on: day)
        guard item.state == nil else {
            item.fraction = nil
            item.cardFraction = nil
            return
        }

        let periodWord = period == .week ? "a week" : period == .month ? "a month" : period == .year ? "a year" : ""
        switch rule.kind {
        case .check:
            let unit = rule.checkUnit ?? "times"
            if !slotted && !countsUp(habit, on: day) {
                let ticked = isTicked(habit, on: day)
                item.line = ticked ? "Done" : "Not yet"
                item.value = ticked ? "Checked" : "Not checked"
                item.big = item.value
                item.lock = nil
            } else if period != .day {
                item.value = "\(Format.amount(progress)) of \(Format.amount(goal)) \(unit)"
                item.line = "\(Format.amount(todayAmount)) today · \(Format.amount(goal)) \(periodWord)"
                item.big = Format.amount(progress)
                item.goal = "/ \(Format.amount(goal)) \(period == .week ? "this week" : period == .month ? "this month" : "this year")"
                item.lock = "\(Format.amount(progress))/\(Format.amount(goal))"
            } else {
                item.value = "\(Format.amount(progress)) of \(Format.amount(goal)) \(unit)"
                item.line = item.value
                item.big = Format.amount(progress)
                item.goal = "/ \(Format.amount(goal)) \(unit)"
                item.lock = "\(Format.amount(progress))/\(Format.amount(goal))"
            }
        case .amount(let unit, _):
            let named = unit.isEmpty ? "" : " " + unit
            let maxWord = rule.atMost ? " max" : ""
            item.value = "\(Format.amount(progress)) of \(Format.amount(goal))\(named)\(maxWord)"
            item.big = Format.amount(progress)
            item.goal = "/ \(Format.amount(goal))\(named)" + (period == .week ? " this week" : period == .month ? " this month" : "")
            item.lock = "\(Format.amount(progress))/\(Format.amount(goal))"
            if period != .day && !rule.atMost {
                item.line = "\(Format.amount(todayAmount))\(named) today · \(Format.amount(goal))\(named) \(periodWord)"
            } else {
                item.line = "\(Format.amount(progress)) of \(Format.amount(goal))\(named)"
            }
        case .duration:
            let maxWord = rule.atMost ? " max" : ""
            let (done, of) = Self.widgetMinutes(progress, goal: goal)
            item.value = "\(done) of \(of)\(maxWord)"
            item.big = done
            item.goal = "/ \(of)" + (period == .week ? " a week" : period == .month ? " a month" : "")
            item.lock = Self.widgetCompactMinutes(progress, goal: goal)
            if period != .day && !rule.atMost {
                item.line = "\(Format.minutes(todayAmount)) today · \(of) \(periodWord)"
            } else {
                item.line = "\(done) of \(of)"
            }
            if running {
                // The clock counts up from what was already logged, as the Live Activity's does.
                let clock = now.addingTimeInterval(-progress * 60)
                item.timerClock = clock
                item.timerGoalAt = clock.addingTimeInterval(goal * 60)
                item.timerGoal = rule.atMost ? " of \(Format.amount(goal)) max" : " of \(of)"
            }
        case .checklist:
            item.value = "\(Format.amount(progress)) of \(Format.amount(goal)) steps"
            item.line = item.value
            item.big = Format.amount(progress)
            item.goal = "/ \(Format.amount(goal)) steps"
            item.lock = "\(Format.amount(progress))/\(Format.amount(goal))"
        case .quit, .task:
            break
        }
        if rule.atMost {
            // The state in words, never red and never shame (U3): Daily limit, Limit reached, Over the limit.
            let state = progress > goal ? "Over the limit" : progress == goal ? "Limit reached"
                : period == .week ? "Weekly limit" : period == .month ? "Monthly limit" : "Daily limit"
            item.caption = state
            item.line = item.line + " · " + state
            item.ring = nil
        }

        // The one button (U14): ✓ toggles today, + adds one saved step, ▶/⏸ the timer; anything that needs a screen
        // opens it directly (the amount entry, the named steps, the full-screen timer).
        guard planned else { return }
        switch rule.kind {
        case .check:
            if slotted {
                if slots(of: habit).allSatisfy({ isSlotDone(habit, slot: $0, on: day) }) {
                    item.action = .open; item.route = item.url.absoluteString
                } else {
                    item.action = .add; item.actionText = "+1"
                }
            } else if countsUp(habit, on: day) {
                item.action = .add; item.actionText = "+1"
            } else {
                item.action = .check
            }
        case .amount:
            if let step = habit.quickIncrement, step.isFinite, step > 0, step <= GoalNumber.maximum {
                item.action = .add; item.actionText = "+" + Format.amount(step)
            } else {
                item.action = .open; item.route = "oftenenough://log/" + item.id
            }
        case .duration:
            if running { item.action = .timerPause }
            else if UserDefaults.standard.bool(forKey: Preferences.timerScreen) {
                item.action = .open; item.route = "oftenenough://timer/\(item.id)?start=1"
            } else { item.action = .timerStart }
        case .checklist:
            item.action = .open; item.route = item.url.absoluteString
        case .quit, .task:
            break
        }
    }

    /// "12" and "20 min", "1h 12m" and "3 h": short enough for a Small card (Implementation Spec §4).
    static func widgetMinutes(_ progress: Double, goal: Double) -> (String, String) {
        func short(_ v: Double) -> String {
            let total = Int(v.rounded(.down)), h = total / 60, m = total % 60
            return h == 0 ? "\(m)m" : m == 0 ? "\(h)h" : "\(h)h \(m)m"
        }
        let goalText = Format.minutes(goal)
        if goal < 60 && progress < 60 { return ("\(Int(progress.rounded(.down)))", goalText) }
        return (progress < 1 ? "0" : short(progress), goalText)
    }

    /// The Lock Screen circle's "12/20m", "1.5/3h".
    static func widgetCompactMinutes(_ progress: Double, goal: Double) -> String {
        if goal < 60 { return "\(Int(progress.rounded(.down)))/\(Int(goal.rounded()))m" }
        func hours(_ v: Double) -> String { Format.amount((v / 6).rounded(.down) / 10) }
        return "\(hours(progress))/\(hours(goal))h"
    }

    /// A quit run: "45 days", "1 day", "14 hours"; compact for the Lock Screen: "15d", "14h".
    static func widgetRunText(_ seconds: TimeInterval, compact: Bool = false) -> String {
        let days = Int(seconds / 86_400), hours = Int(seconds / 3600)
        if compact { return days >= 1 ? "\(days)d" : "\(hours)h" }
        if days >= 1 { return days == 1 ? "1 day" : "\(days) days" }
        return hours == 1 ? "1 hour" : "\(hours) hours"
    }
}

/// Today's "done" for one row (`PartSection.isDone`): skipped, or done for the day (a section's own tick for a habit
/// ticked per section counts once all are). Used to sink done rows the way Today does.
enum PartSectionDone {
    static func isDone(_ store: HabitStore, _ habit: Habit, on day: LocalDay) -> Bool {
        if store.isSkipped(habit, on: day) { return true }
        let slots = store.slots(of: habit)
        if !slots.isEmpty { return slots.allSatisfy { store.isSlotDone(habit, slot: $0, on: day) } }
        return store.isSatisfied(habit, on: day)
    }
}

/// Coalesces publication after committed changes. Cancellation never cancels database writes.
@Observable final class WidgetPublisher {
    @ObservationIgnored private var scheduled: Task<Void, Never>?
    @ObservationIgnored private var latestTicket: UInt64 = 0
    @ObservationIgnored private let testDestination: URL?
    init(file: URL? = nil) { testDestination = file }
    private(set) var problem: String?
    func schedule(_ store: HabitStore) {
        scheduled?.cancel()
        scheduled = Task {
            // Two seconds after the last change, not 180 ms (2 Oct 2026): widgets can't be seen while the app is in
            // front, and going to the background publishes at once (`HabitsApp.finishWrites`). Each publication
            // projects the changed habit's week on the main thread, so a run of taps pays for one, after the taps.
            try? await Task.sleep(for: .seconds(2))
            guard !Task.isCancelled else { return }
            await publishNow(store, hold: false)
        }
    }
    /// - Parameter hold: a tap on a widget: today's lists keep the order on screen for 1.5 s, so the next tap in a run
    ///   lands where the finger is (U4); then done rows sink (U13).
    func publish(_ store: HabitStore, hold: Bool = false) async {
        // Explicit flushes supersede the delayed update queued by the same committed change.
        scheduled?.cancel()
        scheduled = nil
        await publishNow(store, hold: hold)
    }
    private func publishNow(_ store: HabitStore, hold: Bool) async {
        await store.flush()
        guard store.isLoaded, store.isStorageReady, store.problem == nil, !Task.isCancelled else { return }
        let telemetry = store.analytics.ticket
        let hidden = UserDefaults.standard.bool(forKey: WidgetDisk.privacyKey) || AppLock.isEnabled
        let ticket = WidgetPublicationOrder.next()
        latestTicket = ticket
        let destination = testDestination ?? WidgetDisk.url
        let now = Date.now
        let previous = hold ? WidgetDisk.read(from: destination) : nil
        var snapshot = await store.preparedWidgetSnapshot(now: now, hidden: hidden, previous: previous,
                                                          hold: hold ? now.addingTimeInterval(1.5) : nil)
        guard !Task.isCancelled else { return }
        let currentHidden = UserDefaults.standard.bool(forKey: WidgetDisk.privacyKey) || AppLock.isEnabled
        if currentHidden != hidden { snapshot = store.widgetSnapshot(hidden: currentHidden) }
        do {
            // Detached I/O avoids encoding and file coordination on the UI thread.
            try await WidgetSnapshotWriter.shared.write(snapshot, to: destination, ticket: ticket)
            store.analytics.reliability("widget", succeeded: true, ticket: telemetry)
            if ticket == latestTicket { problem = nil }
        } catch {
            store.analytics.reliability("widget", succeeded: false, ticket: telemetry)
            if ticket == latestTicket { problem = "Widgets couldn't be updated. Open the app and try again." }
        }
    }
}

@MainActor private enum WidgetPublicationOrder {
    static var value: UInt64 = 0
    static func next() -> UInt64 { value &+= 1; return value }
}

private actor WidgetSnapshotWriter {
    static let shared = WidgetSnapshotWriter()
    private var latest: [URL: UInt64] = [:]
    private var reloadTask: Task<Void, Never>?
    private var reloadGeneration: UInt64 = 0
    func write(_ original: WidgetSnapshot, to file: URL?, ticket: UInt64) async throws {
        guard let file else { throw CocoaError(.fileNoSuchFile) }
        guard ticket >= (latest[file] ?? 0) else { return }
        var snapshot = original
        // A preparation that started before privacy was enabled cannot republish names afterward.
        let locked = !ProcessInfo.processInfo.arguments.contains("-uitest") && UserDefaults.standard.bool(forKey: "app_lock")
        if locked || UserDefaults.standard.bool(forKey: WidgetDisk.privacyKey) {
            snapshot.hidden = true
            snapshot.sections = []; snapshot.taskSections = []; snapshot.choices = []
            snapshot.frames = snapshot.frames.map { frame in
                var hidden = frame; hidden.items = []; hidden.lists = [:]; hidden.held = nil; return hidden
            }
        }
        try WidgetDisk.write(snapshot, to: file)
        latest[file] = ticket
        // Commit every snapshot immediately; coalesce closely spaced native host invalidations.
        // Await the surviving reload so a background intent cannot finish before it is requested.
        reloadTask?.cancel()
        reloadGeneration &+= 1
        var waitingFor = reloadGeneration
        var task = Task {
            try? await Task.sleep(for: .milliseconds(250))
            guard !Task.isCancelled else { return }
            await self.reloadInstalledWidgets()
        }
        reloadTask = task
        while true {
            await task.value
            guard waitingFor != reloadGeneration, let newest = reloadTask else { break }
            waitingFor = reloadGeneration
            task = newest
        }
    }
    private func reloadInstalledWidgets() async {
        // Uninstalled widgets need the snapshot for gallery configuration, but no timeline invalidation.
        let reload = await withCheckedContinuation { continuation in
            WidgetCenter.shared.getCurrentConfigurations { result in
                switch result {
                case .success(let widgets):
                    continuation.resume(returning: widgets.contains { $0.kind.hasPrefix("OftenEnough.") })
                case .failure: continuation.resume(returning: true)
                }
            }
        }
        if reload && !Task.isCancelled { WidgetCenter.shared.reloadAllTimelines() }
    }
}
