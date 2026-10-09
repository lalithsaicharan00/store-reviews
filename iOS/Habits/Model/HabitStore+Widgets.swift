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
            choices: active.filter { $0.kind != .task }.map { WidgetChoice(id: $0.id.uuidString, name: $0.name, symbol: $0.symbol) },
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
            // LOCKED (widget taps, 8 Oct 2026): the "after" cards, a ✓ flipped and a + five taps ahead (W3). Read iOS/Docs/Widgets — Taps and Updates (Locked).md before changing; changes need the user's say-so.
            // Today's ✓ or +: the card as it will be after one tap, drawn by the widget the moment it's touched, so the
            // whole card changes at once while the app saves behind (the user, 8 Oct 2026, Current Work 66).
            if offset == 0, item.state == nil, item.action == .check || item.action == .add {
                if item.action == .check {
                    var after = widgetItem(habit, on: day, now: moment, isToday: true, signature: signature, showStreaks: showStreaks,
                                           adjust: WidgetAdjust(add: 0, flip: true), week: item.week)
                    after.heat = heat; after.token = item.token
                    item.after = [after]
                } else {
                    // A + tapped again before the widget redraws moves on again (the user, 8 Oct 2026: a second tap
                    // looked like an undo): the card after 1, 2 … `widgetTapsAhead` taps, each holding the next.
                    let step = item.type == "amount" ? (habit.quickIncrement ?? 0) : 1
                    var next: WidgetItem?
                    for taps in stride(from: Self.widgetTapsAhead, through: 1, by: -1) {
                        var after = widgetItem(habit, on: day, now: moment, isToday: true, signature: signature, showStreaks: showStreaks,
                                               adjust: WidgetAdjust(add: step * Double(taps), flip: false), week: item.week)
                        after.heat = heat; after.token = item.token
                        after.after = next.map { [$0] }
                        next = after
                    }
                    item.after = next.map { [$0] }
                }
            }
            return item
        }
    }

    /// One habit or task on one day, as every widget shows it.
    /// How many quick + taps in a row a widget shows at once before it redraws with the saved numbers.
    static let widgetTapsAhead = 5

    /// One tap's effect, for the card as it will be after it: a + adds `add`; a ✓ flips the day's tick.
    struct WidgetAdjust { var add: Double; var flip: Bool }

    func widgetItem(_ habit: Habit, on day: LocalDay, now: Date, isToday: Bool, signature: String, showStreaks: Bool,
                    adjust: WidgetAdjust? = nil, week: [Int]? = nil) -> WidgetItem {
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
        else if habit.kind == .task { fillTask(&item, habit, on: day, now: now, planned: due, adjust: adjust) }
        else { fillHabit(&item, habit, rule: rule, on: day, now: now, planned: due && !paused && !skipped, showStreaks: showStreaks, adjust: adjust) }
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
            // After one tap: done for the day as Today counts it (complete, or for a week or month goal anything today).
            if adjust != nil, item.counts {
                item.countsDone = item.done || (!rule.frequency.isDayBased && !rule.atMost && (item.todayAmount ?? 0) > 0)
            }
        }
        if !item.cards.isEmpty {
            // A carried-over task says where it came from instead of its section (`taskLine`).
            let carried = habit.kind == .task && habit.dueDay.map { $0 < day } == true
            item.place = item.cards[0] == .quittingCard || carried ? "" : widgetCardName(item.cards[0])
            item.todayLine = [item.place, item.line].filter { !$0.isEmpty }.joined(separator: " · ")
        }
        if let week, adjust != nil {
            // The week's squares after one tap: today's square follows the day's new state.
            item.week = week
            do {
                let span = period(.week, containing: day)
                let index = span.lowerBound.days(to: day, calendar: calendar)
                item.weekToday = index
                if week.indices.contains(index), let level = item.todayLevel { item.week[index] = level }
            }
        } else if habit.kind != .task {
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

    private func fillTask(_ item: inout WidgetItem, _ habit: Habit, on day: LocalDay, now: Date, planned: Bool, adjust: WidgetAdjust? = nil) {
        let done = adjust?.flip == true ? !isDone(habit, on: day) : isDone(habit, on: day)
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
                           showStreaks: Bool, adjust: WidgetAdjust? = nil) {
        var progress = progress(of: habit, on: day, now: now)
        let goal = goal(of: rule)
        let period = !rule.frequency.isDayBased ? periodKind(rule) : .day
        let running = timers[habit.id] != nil && day == today(now: now)
        let dayGoal = dayGoal(of: rule)
        var todayAmount = dayProgress(of: habit, on: day, now: now)
        var complete = isComplete(habit, on: day)
        // After one tap (`WidgetAdjust`): a ✓ flips the day's tick, a + adds its step; the rest follows from these.
        var tickedOverride: Bool?
        if let adjust {
            if adjust.flip {
                let ticked = !isTicked(habit, on: day)
                tickedOverride = ticked
                let delta: Double = ticked ? 1 : -min(1, todayAmount)
                progress += delta; todayAmount += delta
                complete = ticked
            } else {
                progress += adjust.add; todayAmount += adjust.add
                complete = !rule.atMost && progress >= goal
            }
        }
        item.todayAmount = todayAmount
        if !rule.atMost {
            item.todayLevel = complete ? (todayAmount > dayGoal && dayGoal > 0 && rule.frequency.isDayBased ? 5 : 4)
                : todayAmount <= 0 ? 0 : (dayGoal > 0 && rule.frequency.isDayBased ? (todayAmount / dayGoal <= 1.0 / 3 ? 1 : todayAmount / dayGoal <= 2.0 / 3 ? 2 : 3) : 4)
        }
        let slotted = !slots(of: habit).isEmpty
        if showStreaks {
            let n = streak(of: habit, asOf: day)
            item.streak = n > 0 ? rule.frequency.streakUnit.short(n) : nil
        }
        // The bar toward the goal's own period (Small and weekly cards), and the row fill toward the same goal Today's
        // row fills toward: today's for a daily goal, the period's for a week or month goal. Limits fill neutral grey.
        let periodFraction = goal > 0 ? max(0, progress / goal) : 0
        item.cardFraction = periodFraction
        item.ring = rule.atMost ? nil : min(1, periodFraction)
        if rule.atMost {
            item.limitFill = true
            item.fraction = periodFraction
        } else if period == .day {
            item.fraction = dayGoal > 0 ? max(0, todayAmount / dayGoal) : 0
        } else {
            // A week or month goal has no daily goal: it fills toward its week or month, as Today's row does (the user,
            // 8 Oct 2026: Call family's row didn't fill on the widget).
            item.fraction = periodFraction
        }
        // Positive completion only: a limit never turns the habit's colour (U2, U25).
        item.done = !rule.atMost && complete
        // Quit or Cut Down never sinks: nothing in it is "done" (Today's card keeps the person's order as it is).
        item.sinks = adjust != nil ? item.done : !rule.atMost && PartSectionDone.isDone(self, habit, on: day)
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
                let ticked = tickedOverride ?? isTicked(habit, on: day)
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
        // What the app opens (the user, 7 Oct 2026, Current Work 66): a timer opens its timer, steps their Day details, a
        // number to type its log sheet; checks, tasks and saved steps log from the widget.
        guard planned else { return }
        // A + whose next tap meets the goal: the switch shows the habit's colour the moment it's touched.
        let meetsWith: (Double) -> Bool = { step in !rule.atMost && !complete && progress + step >= goal }
        switch rule.kind {
        case .check:
            if slotted {
                let open = slots(of: habit).filter { !isSlotDone(habit, slot: $0, on: day) }
                if open.isEmpty {
                    item.action = .open; item.route = item.url.absoluteString
                } else {
                    item.action = .add; item.actionText = "+1"; item.completesNext = open.count == 1
                }
            } else if countsUp(habit, on: day) {
                item.action = .add; item.actionText = "+1"; item.completesNext = meetsWith(1)
            } else {
                item.action = .check
            }
        case .amount:
            if let step = habit.quickIncrement, step.isFinite, step > 0, step <= GoalNumber.maximum {
                item.action = .add; item.actionText = "+" + Format.amount(step); item.completesNext = meetsWith(step)
            } else {
                item.action = .open; item.route = "oftenenough://log/" + item.id
            }
        case .duration:
            // ▶ starts the timer right there, ⏸ stops it; the Live Activity and Dynamic Island show it. The app isn't
            // opened (the user, 8 Oct 2026, Current Work 66).
            item.action = running ? .timerPause : .timerStart
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

extension WidgetSnapshot {
    /// Hide Names Outside the App (Current Work 58; report §6a, §6b): the same snapshot without a word the person wrote.
    /// Habit names, task titles and section names go (in every item's "after" cards too, or a tap would flash the name);
    /// icons, colours, fills, counts, "N of M done", the ✓ / + / ▶ / ⏸ buttons, every item, list and token stay, so taps
    /// log exactly as before. Edit Widget's choices say "Habit 1", "Habit 2"… with their icons, sections "Section 1"….
    /// Done here in the app, never in the widget (U26). Not the old `hidden` (no items, taps refused).
    func discreet() -> WidgetSnapshot {
        var copy = self
        copy.discreet = true
        copy.hidden = false
        copy.sections = sections.enumerated().map { WidgetSection(id: $1.id, name: "Section \($0 + 1)") }
        copy.taskSections = taskSections.enumerated().map { WidgetSection(id: $1.id, name: "Section \($0 + 1)") }
        copy.choices = choices.enumerated().map { WidgetChoice(id: $1.id, name: "Habit \($0 + 1)", symbol: $1.symbol) }
        copy.frames = frames.map { frame in
            var shown = frame
            shown.items = frame.items.map(Self.discreet)
            return shown
        }
        return copy
    }

    /// One item without its words: no name, and no section before its line.
    static func discreet(_ item: WidgetItem) -> WidgetItem {
        var item = item
        item.name = ""
        item.place = ""
        item.todayLine = item.line
        item.after = item.after?.map(discreet)
        return item
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
            // LOCKED (widget taps, 8 Oct 2026): 0.5 s after the last change; at once on leaving the app (W11). Read iOS/Docs/Widgets — Taps and Updates (Locked).md before changing; changes need the user's say-so.
            // Half a second after the last change, so a run of taps pays for one publication, after the taps. Not
            // the 2 s of 2 Oct: a person who logged and went straight back to the Home Screen saw the old widget,
            // because the update came after the app had left the screen and iOS held it back (the user, 8 Oct 2026).
            // Each habit's week is remembered (S5), so a publication is a few ms. Leaving the app publishes at once.
            try? await Task.sleep(for: .milliseconds(500))
            guard !Task.isCancelled else { return }
            await publishNow(store, hold: false)
        }
    }
    /// - Parameter hold: a tap on a widget: today's lists keep the order on screen for 1.5 s, so the next tap in a run
    ///   lands where the finger is (U4); then done rows sink (U13).
    /// - Parameter immediate: ask iOS to redraw at once, without the short wait that merges close publications (a
    ///   widget tap, or leaving the app).
    func publish(_ store: HabitStore, hold: Bool = false, immediate: Bool = false) async {
        // Explicit flushes supersede the delayed update queued by the same committed change.
        scheduled?.cancel()
        scheduled = nil
        await publishNow(store, hold: hold, immediate: immediate || hold)
    }
    private func publishNow(_ store: HabitStore, hold: Bool, immediate: Bool = false) async {
        await store.flush()
        guard store.isLoaded, store.isStorageReady, store.problem == nil, !Task.isCancelled else { return }
        let telemetry = store.analytics.ticket
        // Hide Names Outside the App (Current Work 58): the same snapshot, every item and button kept, with the words
        // taken out here in the app (`discreet()`), so the names never reach the shared file (U26).
        let discreet = HideNames.isOn
        let ticket = WidgetPublicationOrder.next()
        latestTicket = ticket
        let destination = testDestination ?? WidgetDisk.url
        let now = Date.now
        let previous = hold ? WidgetDisk.read(from: destination) : nil
        #if DEBUG
        WidgetTiming.mark("publish: started")
        #endif
        var snapshot = await store.preparedWidgetSnapshot(now: now, previous: previous,
                                                          hold: hold ? now.addingTimeInterval(1.5) : nil)
        #if DEBUG
        WidgetTiming.mark("publish: snapshot prepared, \(snapshot.frames.first?.items.count ?? 0) items")
        #endif
        guard !Task.isCancelled else { return }
        if discreet || HideNames.isOn { snapshot = snapshot.discreet() }
        do {
            // Detached I/O avoids encoding and file coordination on the UI thread.
            // A widget tap (`hold`) or leaving the app reloads at once: the person is about to look at the widget.
            try await WidgetSnapshotWriter.shared.write(snapshot, to: destination, ticket: ticket, immediate: immediate)
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
    func write(_ original: WidgetSnapshot, to file: URL?, ticket: UInt64, immediate: Bool = false) async throws {
        guard let file else { throw CocoaError(.fileNoSuchFile) }
        guard ticket >= (latest[file] ?? 0) else { return }
        var snapshot = original
        // A preparation that started before names were hidden can't publish them afterwards.
        if HideNames.isOn && snapshot.discreet != true { snapshot = snapshot.discreet() }
        try WidgetDisk.write(snapshot, to: file)
        #if DEBUG
        WidgetTiming.mark("publish: snapshot written, \((try? file.resourceValues(forKeys: [.fileSizeKey]).fileSize) ?? -1) bytes")
        #endif
        latest[file] = ticket
        // Commit every snapshot immediately; coalesce closely spaced native host invalidations.
        // Await the surviving reload so a background intent cannot finish before it is requested.
        reloadTask?.cancel()
        reloadGeneration &+= 1
        var waitingFor = reloadGeneration
        var task = Task {
            if !immediate { try? await Task.sleep(for: .milliseconds(250)) }
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
        #if DEBUG
        WidgetTiming.mark("publish: reload requested (widgets installed: \(reload))")
        #endif
    }
}
