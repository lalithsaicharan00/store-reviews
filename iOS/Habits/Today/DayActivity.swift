import SwiftUI

/// Day details' activity group: what happened on this day, the habit's own buttons, and the logs that can be corrected
/// one by one (handoff "Day Details Wireframes"; Rulebook U14–U17). Only this view reads the day's entries, so a log
/// redraws this group and never the identity, note or menu around it (S6).
///
///   once a day, task     Done / Not done             Mark done · Undo done
///   week / month count   Checked today · 2 of 3      Mark done · Undo today's check
///   several a day        2 of 3 checks               Add a check · each check with its own Undo
///   checklist            2 of 3 steps done           the steps themselves
///   amount, time         2 of 8 glasses              Add 1 glass · Log amount manually · each log opens Edit Log
///   limit                1 cup today · Limit 2       both bordered: recording isn't the goal (U16)
///   quit                 No slips recorded           Record a slip · each slip opens Edit Slip
///
/// No empty "entries" card anywhere: logs show only when there are some. Skipped: the buttons stay where they were,
/// disabled, and saved logs stay correctable (U15).
struct DayActivity: View {
    let habit: Habit
    let day: LocalDay
    let editable: Bool
    let groupGap: CGFloat
    let logManually: () -> Void
    let resume: () -> Void
    @Environment(HabitStore.self) private var store
    @ScaledMetric(relativeTo: .body) private var tight: CGFloat = 10
    @ScaledMetric(relativeTo: .body) private var toLogs: CGFloat = 12
    @ScaledMetric(relativeTo: .body) private var buttonGap: CGFloat = 8

    var body: some View {
        let _ = perfTimed("Count: the Day sheet's activity drawn") { () }
        let ruled = store.rule(habit, on: day)
        let entries = store.entries(of: habit.id, on: day).filter { $0.stepID == nil }
        let logs = showsLogs(ruled) ? entries : []
        let actions = makeActions(ruled, entries: entries)
        let steps = ruled.kind == .checklist && day >= store.startDay(of: habit) ? ruled.steps : []
        let afterButtons = logs.isEmpty ? groupGap : toLogs
        let status = makeStatus(ruled, entries: entries)

        Section {
            VStack(alignment: .leading, spacing: 4) {
                Text(status.title)
                    .font(.title2.weight(.bold))
                    .fixedSize(horizontal: false, vertical: true)
                    .accessibilityIdentifier("day-result")
                if let start = status.running {
                    // The system moves this clock; nothing here redraws while it runs (Rulebook S3).
                    Text("Timer running · \(Text(start, style: .timer))").monospacedDigit()
                        .font(.subheadline).foregroundStyle(.secondary)
                }
                if let detail = status.detail {
                    Text(detail).font(.subheadline).foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                        .accessibilityIdentifier("day-detail")
                }
            }
            .padding(.vertical, 4)
        } header: {
            Text("This day")
        }
        .listSectionSpacing(!steps.isEmpty || !actions.isEmpty ? tight : afterButtons)

        if !steps.isEmpty {
            stepsSection(ruled, steps: steps)
                .listSectionSpacing(actions.isEmpty ? afterButtons : tight)
        }
        if !actions.isEmpty {
            Section {
                VStack(spacing: buttonGap) {
                    ForEach(actions) { action in
                        DayButton(action.title, prominent: action.prominent, id: action.id, action: action.run)
                            .disabled(!action.enabled)
                    }
                }
                .dayButtonRow()
            }
            .listSectionSpacing(afterButtons)
        }
        if !logs.isEmpty {
            logsSection(ruled, logs: logs)
                .listSectionSpacing(groupGap)
        }
    }

    // MARK: Status

    private struct Status {
        var title: String
        var detail: String?
        /// A running timer's start: the detail line becomes a live clock.
        var running: Date?
    }

    private var isToday: Bool { day == store.today() }
    private var dayWord: String { isToday ? "today" : "this day" }
    private var shortDay: String { PauseSheet.short(day, calendar: store.calendar) }

    private func makeStatus(_ ruled: Habit, entries: [Entry]) -> Status {
        if store.isPaused(habit, on: day) {
            return Status(title: "Paused", detail: entries.isEmpty ? "Paused days don't count toward your streak"
                          : "Progress already recorded stays in your history")
        }
        if store.isSkipped(habit, on: day) {
            let saved = savedText(ruled, entries: entries)
            return Status(title: "Skipped", detail: (saved.map { $0 + " · " } ?? "") + "Doesn't count toward your streak")
        }
        if day < store.startDay(of: habit) { return Status(title: "Before it started") }
        switch ruled.kind {
        case .quit:
            let n = entries.count
            return n == 0 ? Status(title: "No slips recorded")
                : Status(title: "\(n) \(n == 1 ? "slip" : "slips") recorded", detail: "Tap a slip below to change its time")
        case .task:
            let done = store.isDone(habit, on: day)
            let last = (ruled.dueDay == nil ? entries : store.entries(of: habit.id)).last
            guard done, let last else { return Status(title: done ? "Done" : "Not done") }
            let when = last.day == day ? store.clockText(of: last)
                : PauseSheet.short(last.day, calendar: store.calendar) + " at " + store.clockText(of: last)
            return Status(title: "Done", detail: "Completed " + (last.day == day ? "at " : "on ") + when)
        case .checklist:
            let done = Int(store.dayProgress(of: ruled, on: day)), all = ruled.steps.count
            let left = all - done
            return Status(title: "\(done) of \(all) steps done",
                          detail: left <= 0 ? "All steps done" : left == 1 ? "One step left" : "\(left) steps left")
        case .check:
            return checkStatus(ruled, entries: entries)
        case .amount, .duration:
            return amountStatus(ruled, entries: entries)
        }
    }

    private func checkStatus(_ ruled: Habit, entries: [Entry]) -> Status {
        let unit = ruled.checkUnit ?? "checks"
        let progress = store.dayProgress(of: ruled, on: day)
        if store.countsUp(habit, on: day) {
            let goal = store.dayGoal(of: ruled), left = goal - progress
            let detail = left <= 0 ? "Goal reached"
                : isToday ? (left == 1 ? "One more reaches today's goal" : "\(HabitCopy.number(left)) more reach today's goal")
                : "For " + shortDay
            return Status(title: "\(HabitCopy.number(progress)) of \(HabitCopy.amount(goal, unit))", detail: detail)
        }
        if !ruled.frequency.isDayBased {
            // The selected day's own check, then the period as context: never the week's total called today's.
            let period = store.progress(of: habit, on: day), goal = store.goal(of: habit)
            return Status(title: (progress > 0 ? "Checked " : "Not checked ") + dayWord,
                          detail: "\(HabitCopy.number(period)) of \(HabitCopy.amount(goal, unit))" + Self.periodWord(ruled.frequency))
        }
        let done = store.isDayMet(ruled, on: day)
        if case .flexible(_, let needed) = ruled.frequency, let count = store.flexibleProgress(habit, on: day) {
            return Status(title: done ? "Done" : "Not done",
                          detail: "\(count) of \(needed) \(needed == 1 ? "day" : "days")" + Self.periodWord(ruled.frequency))
        }
        if done, let last = entries.last { return Status(title: "Done", detail: "Checked at " + store.clockText(of: last)) }
        return Status(title: done ? "Done" : "Not done")
    }

    private func amountStatus(_ ruled: Habit, entries: [Entry]) -> Status {
        let timed = ruled.kind == .duration
        let unit = HabitCopy.unit(of: ruled)
        func text(_ v: Double) -> String { timed ? Format.minutes(v.rounded(.down)) : HabitCopy.amount(v, unit) }
        // What's saved; a running timer's time shows as its own clock, not folded into a number that can't tick.
        let saved = entries.reduce(0) { $0 + $1.value }
        let running = timed && isToday ? store.timers[habit.id] : nil
        let goal = store.dayGoal(of: ruled)
        if store.isTotal(ruled) {
            let total = store.progress(of: habit, on: day)
            let period = Self.periodWord(ruled.frequency)
            return Status(title: "\(text(saved)) \(dayWord)",
                          detail: ruled.atMost ? "\(text(total))\(period) · limit \(text(goal))" : "\(text(total)) of \(text(goal))\(period)",
                          running: running)
        }
        if ruled.atMost {
            // A limit is a fact, not a bar to fill: no "to go", no colour, nothing about going over (U3/U16).
            return Status(title: "\(text(saved)) \(dayWord)",
                          detail: "Limit \(text(goal))" + (saved <= goal ? " · within limit" : ""), running: running)
        }
        let title = timed
            ? (goal < 60 && saved < 60 ? "\(Int(saved.rounded(.down))) of \(Format.minutes(goal))" : "\(text(saved)) of \(Format.minutes(goal))")
            : "\(HabitCopy.number(saved)) of \(HabitCopy.amount(goal, unit))"
        // While the timer runs, its clock is the detail: "to go" from the saved time alone would be wrong.
        let detail = running != nil ? nil : saved >= goal ? "Goal reached" : isToday ? "\(text(goal - saved)) to go" : "For " + shortDay
        return Status(title: title, detail: detail, running: running)
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

    // MARK: Buttons

    private struct Action: Identifiable {
        let title: String
        var prominent = false
        var enabled = true
        let id: String
        let run: () -> Void
    }

    /// The habit's own buttons for this day. Prominent only for the step a positive goal asks for (U16). Skipped:
    /// every way to add stays in place, disabled (U15). Paused: Resume, and typing a log, which still goes to history.
    private func makeActions(_ ruled: Habit, entries: [Entry]) -> [Action] {
        guard editable else { return [] }
        let today = store.today()
        let skipped = store.isSkipped(habit, on: day)
        let paused = store.isPaused(habit, on: day)
        if paused {
            var list: [Action] = []
            if store.pause(of: habit, on: today)?.contains(today) == true {
                list.append(Action(title: "Resume habit", prominent: true, id: "day-resume", run: resume))
            }
            switch ruled.kind {
            case .amount: list.append(Action(title: "Log amount manually", id: "day-add-entry", run: logManually))
            case .duration: list.append(Action(title: "Log time manually", id: "day-add-entry", run: logManually))
            default: break
            }
            return list
        }
        let source = EntrySource.daySheet
        switch ruled.kind {
        case .task:
            let done = store.isDone(habit, on: day)
            return [Action(title: done ? "Undo done" : "Mark done", prominent: !done, id: "day-done") {
                store.toggleCheck(habit, on: day, source: source)
            }]
        case .check:
            if store.countsUp(habit, on: day) {
                let title = ruled.checkUnit.map { "Add " + HabitCopy.amount(1, $0) } ?? "Add a check"
                return [Action(title: title, prominent: true, enabled: !skipped, id: "day-add-one") {
                    store.addProgress(habit, value: 1, on: day, source: source)
                }]
            }
            if !ruled.frequency.isDayBased {
                // This day's check only: a check on another day of the week is never this day's to take back.
                let ticked = store.dayProgress(of: ruled, on: day) > 0
                return [Action(title: ticked ? "Undo \(isToday ? "today's" : "this day's") check" : "Mark done",
                               prominent: !ticked, enabled: !skipped, id: "day-done") {
                    if ticked { store.setDayDone(false, of: habit, on: day) } else { store.addProgress(habit, value: 1, on: day, source: source) }
                }]
            }
            let done = store.isDayMet(ruled, on: day)
            return [Action(title: done ? "Undo done" : "Mark done", prominent: !done, enabled: !skipped, id: "day-done") {
                store.setDayDone(!done, of: habit, on: day)
            }]
        case .checklist:
            return []
        case .amount(let unit, _):
            var list: [Action] = []
            if let step = ruled.quickIncrement {
                list.append(Action(title: "Add " + HabitCopy.amount(step, unit), prominent: !ruled.atMost, enabled: !skipped, id: "day-add-step") {
                    store.increment(habit, on: day, source: source)
                })
            }
            list.append(Action(title: "Log amount manually", prominent: list.isEmpty && !ruled.atMost, enabled: !skipped,
                               id: "day-add-entry", run: logManually))
            return list
        case .duration:
            var list: [Action] = []
            if isToday {
                if store.timers[habit.id] != nil {
                    list.append(Action(title: "Pause timer and save time", prominent: true, id: "day-stop-timer") {
                        store.stopTimer(habit, on: day)
                    })
                } else {
                    list.append(Action(title: "Start timer", prominent: !ruled.atMost, enabled: !skipped, id: "day-start-timer") {
                        store.toggleTimer(habit)
                    })
                }
            }
            list.append(Action(title: "Log time manually", prominent: list.isEmpty && !ruled.atMost, enabled: !skipped,
                               id: "day-add-entry", run: logManually))
            return list
        case .quit:
            return [Action(title: entries.isEmpty ? "Record a slip" : "Record another slip", id: "day-add-entry", run: logManually)]
        }
    }

    // MARK: Steps

    /// A checklist's steps are both the work and the correction: tap one to tick it or take it back.
    private func stepsSection(_ ruled: Habit, steps: [Step]) -> some View {
        let locked = !editable || store.isSkipped(habit, on: day) || store.isPaused(habit, on: day)
        return Section {
            ForEach(Array(steps.enumerated()), id: \.element.id) { index, step in
                let done = store.isStepDone(step, of: ruled, on: day)
                Button { store.toggleStep(step, of: ruled, on: day, source: .daySheet) } label: {
                    Label {
                        Text(step.name)
                    } icon: {
                        Image(systemName: done ? "checkmark.circle.fill" : "circle")
                            .font(.title3)
                            .foregroundStyle(done ? habit.color.color : Color.secondary)
                    }
                }
                .disabled(locked)
                .accessibilityValue(done ? "Done" : "Not done")
                .accessibilityAddTraits(done ? .isSelected : [])
                .accessibilityIdentifier("day-step-\(index)")
            }
        }
    }

    // MARK: Logs

    /// Only logs that exist, one row each, in a native section (the user, 4 Oct 2026: "the heading, and then each
    /// thing should be a row"). A row with a value to correct opens Edit Log or Edit Slip; a single check has its own
    /// named Undo instead of a "Times 1" form (U19).
    private func logsSection(_ ruled: Habit, logs: [Entry]) -> some View {
        Section {
            ForEach(logs.reversed()) { entry in
                if entry.opensEditor(for: ruled) {
                    NavigationLink {
                        EntryEditView(habit: ruled, entry: entry)
                    } label: {
                        DayLogLabel(entry: entry, habit: ruled)
                    }
                    .accessibilityIdentifier("entry-\(entry.id)")
                } else {
                    HStack {
                        DayLogLabel(entry: entry, habit: ruled)
                        Spacer(minLength: 12)
                        Button("Undo") { store.undoEntry(entry.id) }
                            .buttonStyle(.borderless)
                            .accessibilityLabel(entry.undoLabel(for: ruled) + " at " + store.clockText(of: entry))
                            .accessibilityIdentifier("undo-entry-\(entry.id)")
                    }
                }
            }
        } header: {
            Text(logsTitle(ruled))
        }
    }

    private func showsLogs(_ ruled: Habit) -> Bool {
        switch ruled.kind {
        case .amount, .duration, .quit: true
        case .check: store.countsUp(habit, on: day)
        case .task, .checklist: false
        }
    }

    private func logsTitle(_ ruled: Habit) -> String {
        switch ruled.kind {
        case .quit: isToday ? "Slips today" : "Slips on " + shortDay
        case .check: isToday ? "Checks today" : "Checks on " + shortDay
        default: isToday ? "Today's logs" : "Logs for " + shortDay
        }
    }
}

/// One saved log: what it was, then when and from where ("1 glass" · "11:20 AM · Manual log").
struct DayLogLabel: View {
    let entry: Entry
    let habit: Habit
    @Environment(HabitStore.self) private var store

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(entry.description(for: habit)).foregroundStyle(.primary)
            Text(store.clockText(of: entry) + (entry.source.map { " · " + $0.label } ?? ""))
                .font(.caption).foregroundStyle(.secondary)
        }
        .accessibilityElement(children: .combine)
    }
}

extension HabitStore {
    /// A log's clock time where it was recorded, with that zone's name when it isn't the phone's own.
    func clockText(of entry: Entry) -> String {
        let c = recordingCalendar(for: entry)
        let text = entry.createdAt.formatted(Date.FormatStyle(date: .omitted, time: .shortened, calendar: c, timeZone: c.timeZone))
        return c.timeZone == calendar.timeZone ? text : text + " " + (c.timeZone.abbreviation(for: entry.createdAt) ?? entry.timeZone)
    }
}

extension Entry {
    /// Whether this log has a fact of its own to correct in Edit Log / Edit Slip (U19): an amount, a time, a slip's
    /// moment, or a record holding several checks. A single check, a step or a task is corrected where it's shown.
    func opensEditor(for habit: Habit) -> Bool {
        guard stepID == nil else { return false }
        switch habit.kind {
        case .amount, .duration, .quit: return true
        case .check: return value != 1
        case .task, .checklist: return false
        }
    }
}
