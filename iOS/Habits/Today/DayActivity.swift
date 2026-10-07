import SwiftUI

/// Day details' **This day** card and the day's logs (7 October 2026 redesign; Rulebook U15–U17). One card holds the
/// day's status and its detail line, the logging buttons in one row (the suggested one filled, U16), a checklist's
/// steps, and the day's note (one line on the smallest screens, two when there's room). Then the logs: one to three
/// shown as they are; four or more, the two newest and "All N logs ›". Only this view reads the day's entries, so a log
/// redraws this group and never the identity, Skip or menu around it (S6).
///
///   amount, quick step    4 of 8 glasses              +1 | Log manually (VoiceOver: "Add 1 glass")
///   amount, no step       £15 this month              Log amount
///   time, today           12 of 20 min                Start timer | Log manually; running: Stop and save | Log manually
///   time, another day     25 of 20 min                Log time
///   once a day, N a week  Done / Not done             Mark done · Undo done
///   counted check         4 of 3 times                Add a check, always; each check with its own Undo
///   checklist             2 of 3 steps done           the steps themselves
///   limit                 1 cup today · Limit 2       the same words, both bordered (U16)
///   quit                  No slips recorded           Record a slip · Record another slip, bordered
///   task                  Not done                    Mark done · Undo done
///   paused                Paused                      Resume habit | Log manually
///   skipped               Skipped                     the usual buttons, in place, turned off (U15)
struct DayActivity: View {
    let habit: Habit
    let day: LocalDay
    let editable: Bool
    let spacing: DaySpacing
    let logManually: () -> Void
    let resume: () -> Void
    let addNote: () -> Void
    @Environment(HabitStore.self) private var store
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let _ = perfTimed("Count: the Day sheet's activity drawn") { () }
        let ruled = store.rule(habit, on: day)
        let logs = showsLogs(ruled) ? store.dayLogs(of: habit, on: day) : []
        let actions = makeActions(ruled, hasLogs: !logs.isEmpty)
        let steps = ruled.kind == .checklist && day >= store.startDay(of: habit) ? ruled.steps : []
        let status = DayStatus.make(habit, on: day, store: store)

        Section {
            VStack(alignment: .leading, spacing: 0) {
                Text("This day")
                    .font(.footnote).textCase(.uppercase).foregroundStyle(.secondary)
                    .accessibilityAddTraits(.isHeader)
                Text(status.title)
                    .font(.title2.weight(.bold))
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 2)
                    .accessibilityIdentifier("day-result")
                if let start = status.running {
                    // The system moves this clock; nothing here redraws while it runs (Rulebook S3).
                    Text("Timer running · \(Text(start, style: .timer))").monospacedDigit()
                        .font(.subheadline).foregroundStyle(.secondary)
                        .accessibilityIdentifier("day-running")
                }
                if let detail = status.detail {
                    Text(detail).font(.subheadline).foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                        .accessibilityIdentifier("day-detail")
                }
                if !actions.isEmpty {
                    buttons(actions)
                        .padding(.top, spacing.gap(14, 18))
                }
            }
            .padding(.vertical, spacing.gap(14, 16) - 8)
            if !steps.isEmpty { stepRows(ruled, steps: steps) }
            noteRow
        }
        .listSectionSpacing(logs.isEmpty ? spacing.gap(28, 36) : spacing.gap(20, 28))

        if !logs.isEmpty {
            logsSection(ruled, logs: logs)
                .listSectionSpacing(spacing.gap(28, 36))
        }
    }

    private var isToday: Bool { day == store.today() }

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
        /// What VoiceOver says, when the button's words are short ("+1" is "Add 1 glass").
        var spoken: String? = nil
        let run: () -> Void
    }

    /// The logging buttons in one row, the same size, style saying which is suggested (U16). At the accessibility text
    /// sizes they stack, chosen from the text size, never measured (`ViewThatFits` laid out every option, S10).
    @ViewBuilder private func buttons(_ actions: [Action]) -> some View {
        let layout = typeSize.isAccessibilitySize ? AnyLayout(VStackLayout(spacing: 8)) : AnyLayout(HStackLayout(spacing: 8))
        layout {
            ForEach(actions) { action in
                DayButton(action.title, prominent: action.prominent, id: action.id, action: action.run)
                    .disabled(!action.enabled)
                    .accessibilityLabel(action.spoken ?? action.title)
            }
        }
    }

    /// The habit's own buttons for this day, one rule per kind (design decisions §8). Prominent only for the step a
    /// positive goal asks for (U16). Skipped: every way to add stays in place, turned off (U15). Paused: Resume, and
    /// typing a log, which still goes to history.
    private func makeActions(_ ruled: Habit, hasLogs: Bool) -> [Action] {
        guard editable else { return [] }
        let today = store.today()
        let skipped = store.isSkipped(habit, on: day)
        let source = EntrySource.daySheet
        if store.isPaused(habit, on: day) {
            var list: [Action] = []
            if store.pause(of: habit, on: today)?.contains(today) == true {
                list.append(Action(title: "Resume habit", prominent: true, id: "day-resume", run: resume))
            }
            switch ruled.kind {
            case .amount: list.append(Action(title: list.isEmpty ? "Log amount" : "Log manually", id: "day-add-entry", run: logManually))
            case .duration: list.append(Action(title: list.isEmpty ? "Log time" : "Log manually", id: "day-add-entry", run: logManually))
            default: break
            }
            return list
        }
        switch ruled.kind {
        case .task:
            let done = store.isDone(habit, on: day)
            return [Action(title: done ? "Undo done" : "Mark done", prominent: !done, id: "day-done") {
                store.toggleCheck(habit, on: day, source: source)
            }]
        case .check:
            if store.countsUp(habit, on: day) {
                // Several a day, or N a week, month or year: "Add a check", whatever unit it has; each tap adds one and a
                // log's own Undo takes one back. A limit stays plainly available, never a prominent invitation (U16).
                return [Action(title: "Add a check", prominent: !ruled.atMost, enabled: !skipped, id: "day-add-one") {
                    store.addProgress(habit, value: 1, on: day, source: source)
                }]
            }
            let done = store.isDayMet(ruled, on: day)
            return [Action(title: done ? "Undo done" : "Mark done", prominent: !done, enabled: !skipped, id: "day-done") {
                store.setDayDone(!done, of: habit, on: day)
            }]
        case .checklist:
            return []
        case .amount(let unit, _):
            guard let step = ruled.quickIncrement else {
                return [Action(title: "Log amount", prominent: !ruled.atMost, enabled: !skipped, id: "day-add-entry", run: logManually)]
            }
            // "+1", "+250", exactly as Today's round button: the step, never the unit (U16).
            return [Action(title: "+" + Format.amount(step), prominent: !ruled.atMost, enabled: !skipped, id: "day-add-step",
                           spoken: "Add " + HabitCopy.amount(step, unit)) {
                        store.increment(habit, on: day, source: source)
                    },
                    Action(title: "Log manually", enabled: !skipped, id: "day-add-entry", run: logManually)]
        case .duration:
            guard isToday else {
                // No timer on another day: typing is the one way.
                return [Action(title: "Log time", prominent: !ruled.atMost, enabled: !skipped, id: "day-add-entry", run: logManually)]
            }
            let first = store.timers[habit.id] != nil
                ? Action(title: "Stop and save", prominent: !ruled.atMost, id: "day-stop-timer") { store.stopTimer(habit, on: day) }
                : Action(title: "Start timer", prominent: !ruled.atMost, enabled: !skipped, id: "day-start-timer") { store.toggleTimer(habit) }
            return [first, Action(title: "Log manually", enabled: !skipped, id: "day-add-entry", run: logManually)]
        case .quit:
            return [Action(title: hasLogs ? "Record another slip" : "Record a slip", id: "day-add-entry", run: logManually)]
        }
    }

    // MARK: Steps

    /// A checklist's steps are both the work and the correction: tap one to tick it or take it back.
    @ViewBuilder private func stepRows(_ ruled: Habit, steps: [Step]) -> some View {
        let locked = !editable || store.isSkipped(habit, on: day) || store.isPaused(habit, on: day)
        ForEach(Array(steps.enumerated()), id: \.element.id) { index, step in
            let done = store.isStepDone(step, of: ruled, on: day)
            Button { store.toggleStep(step, of: ruled, on: day, source: .daySheet) } label: {
                Label {
                    Text(step.name).foregroundStyle(.primary)
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

    // MARK: The note

    /// The day's note, inside the card: "NOTE" and its text (one or two lines), opening the Note view; with none, "Add a
    /// note…", opening Add note. Nothing is typed here, and nothing ever asks for a note.
    @ViewBuilder private var noteRow: some View {
        if let note = store.note(of: habit, on: day) {
            NavigationLink {
                NoteView(habit: habit, day: day)
            } label: {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Note").font(.footnote).textCase(.uppercase).foregroundStyle(.secondary)
                    Text(note).foregroundStyle(.primary).lineLimit(spacing.noteLines).multilineTextAlignment(.leading)
                }
                .padding(.vertical, spacing.gap(12, 14) - 8)
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Note for this day: " + note)
            .accessibilityIdentifier("day-edit-note")
        } else {
            Button(action: addNote) {
                HStack {
                    Text("Add a note…").foregroundStyle(.secondary)
                    Spacer(minLength: 8)
                    Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary)
                }
                .padding(.vertical, spacing.gap(12, 14) - 8)
                .contentShape(Rectangle())
            }
            .disabled(!editable)
            .accessibilityLabel("Add a note for this day")
            .accessibilityIdentifier("day-add-note")
        }
    }

    // MARK: Logs

    /// At most three rows (U17): one to three logs as they are; four or more, the two newest and "All N logs ›".
    private func logsSection(_ ruled: Habit, logs: [Entry]) -> some View {
        Section {
            ForEach(logs.count <= 3 ? logs : Array(logs.prefix(2))) { entry in
                DayLogRow(entry: entry, habit: ruled)
            }
            if logs.count > 3 {
                NavigationLink {
                    AllLogsView(habit: habit, day: day)
                } label: {
                    Text("All " + DayLogRow.count(logs.count, habit: ruled))
                }
                .accessibilityIdentifier("day-all-logs")
            }
        } header: {
            Text(DayLogRow.title(ruled, day: day, store: store))
        }
    }

    private func showsLogs(_ ruled: Habit) -> Bool {
        switch ruled.kind {
        case .amount, .duration, .quit: true
        case .check: store.countsUp(habit, on: day)
        case .task, .checklist: false
        }
    }
}

/// How Day details spaces itself on this screen (design decisions §3): every gap between its minimum (the iPhone SE)
/// and its maximum (a mini and every taller iPhone), by one share of its range worked out when the sheet's height or
/// the text size changes, never per row (S6, S8). Larger text uses the spare height first; then the note gets its
/// second line.
struct DaySpacing: Equatable {
    var share: Double = 1
    var noteLines = 2

    func gap(_ minimum: CGFloat, _ maximum: CGFloat) -> CGFloat { minimum + (maximum - minimum) * share }

    /// From the full sheet's height (637 pt on the SE, 752 on a mini) and the text size.
    static func make(height: CGFloat, typeSize: DynamicTypeSize) -> DaySpacing {
        var share = Double(min(max((height - 637) / (752 - 637), 0), 1))
        let steps: [DynamicTypeSize] = [.xLarge, .xxLarge, .xxxLarge]
        for size in steps where typeSize >= size { share -= 0.35 }
        if typeSize.isAccessibilitySize { share = 0 }
        share = max(0, share)
        return DaySpacing(share: share, noteLines: share >= 0.5 ? 2 : 1)
    }
}

/// The day's status: its title ("4 of 8 glasses"), the line under it, and a running timer's start.
struct DayStatus {
    var title: String
    var detail: String?
    /// A running timer's start: the detail line becomes a live clock.
    var running: Date?

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
                                 detail: "\(HabitCopy.number(period)) of \(HabitCopy.amount(goal, unit))" + DayActivity.periodWord(ruled.frequency))
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
                                 detail: "\(count) of \(needed) \(needed == 1 ? "day" : "days")" + DayActivity.periodWord(ruled.frequency))
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
                let period = DayActivity.periodWord(ruled.frequency)
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
                let days = "\(count) of \(needed) \(needed == 1 ? "day" : "days")" + DayActivity.periodWord(ruled.frequency)
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
