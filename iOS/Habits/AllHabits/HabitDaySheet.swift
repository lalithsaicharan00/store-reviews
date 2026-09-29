import SwiftUI

/// One day of one habit, opened by tapping the day in the habit page's calendar (report "Filling In a Past Day From
/// the Habit Page", 29 Sep). It says what that day was, and changes it with the control the habit already uses:
/// Mark as Done for a tick, the number of times for "3 times a day", Log Amount / Log Time and each entry (with
/// Delete) for amounts and time, and the steps for a checklist. Skip and the day's note are here too.
///
/// A sheet, never a tap that changes the day by itself: users show a calendar that ticks or unticks on tap changes
/// history by mistake ("mistakenly click on previous days and unknowingly mark the habit undone").
struct HabitDaySheet: View {
    let habit: Habit
    let day: LocalDay
    /// Opens the page's note bar for this day (the note is written there, as everywhere else).
    let onNote: () -> Void
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var showLog = false

    /// The habit as it was that day: goal, unit and steps (goal history, Design Rules: editing).
    private var rule: Habit { store.rule(habit, on: day) }
    private var unit: String { HabitCopy.unit(of: rule) }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    LabeledContent {
                        Text(status).foregroundStyle(.secondary).accessibilityIdentifier("day-status")
                    } label: {
                        Label { Text(habit.name).lineLimit(2) } icon: { HabitIcon(symbol: habit.symbol, color: habit.color, size: 28) }
                    }
                } footer: {
                    if let period = periodLine { Text(period) }
                }
                if store.isSkipped(habit, on: day) {
                    Section {
                        Button("Undo Skip", systemImage: "arrow.uturn.backward") { store.setSkipped(habit, on: day, false) }
                    } footer: {
                        Text("A skipped day isn't a missed day: it doesn't count for or against the streak.")
                    }
                } else {
                    controls
                    if store.canSkip(habit) && store.loggedEntries(of: habit, on: day).isEmpty && !stepsTicked {
                        Section {
                            Button("Skip This Day", systemImage: "forward") { store.setSkipped(habit, on: day, true) }
                        } footer: {
                            Text("For a day that shouldn't count: ill, travelling, a rest day. The streak is kept.")
                        }
                    }
                }
                Section("Note") {
                    if let note = store.note(of: habit, on: day) {
                        Button { close(then: onNote) } label: {
                            Text(note).foregroundStyle(.primary).multilineTextAlignment(.leading)
                        }
                        .accessibilityHint("Edit the note")
                    } else {
                        Button("Add Note", systemImage: "square.and.pencil") { close(then: onNote) }
                    }
                }
            }
            .navigationTitle(day.date(calendar: store.calendar).formatted(.dateTime.weekday(.wide).day().month(.wide)))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) { Button("Done") { dismiss() }.fontWeight(.semibold) }
            }
            .sheet(isPresented: $showLog) { LogProgressView(habit: habit, day: day) }
        }
        .presentationDetents([.medium, .large])
        // Solid, like the other sheets over a page (Design Rules: notes).
        .presentationBackground(Color(.systemGroupedBackground))
    }

    private func close(then action: @escaping () -> Void) {
        dismiss()
        Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(350)) // the sheet is gone before the keyboard comes up
            action()
        }
    }

    private var stepsTicked: Bool {
        rule.kind == .checklist && rule.steps.contains { store.isStepDone($0, of: habit, on: day) }
    }

    // MARK: What the day was

    /// "Done", "Not done", "3 of 8 glasses", "12 min of 20 min", "2 of 4 steps", "Skipped".
    private var status: String {
        if store.isSkipped(habit, on: day) { return "Skipped" }
        let progress = store.dayProgress(of: rule, on: day)
        switch rule.kind {
        case .duration:
            return rule.frequency.isDayBased ? "\(Format.minutes(progress)) of \(Format.minutes(rule.goal))" : "\(Format.minutes(progress)) logged"
        case .amount:
            return rule.frequency.isDayBased ? "\(HabitCopy.number(progress)) of \(HabitCopy.amount(rule.goal, unit))"
                : "\(HabitCopy.amount(progress, unit)) logged"
        case .checklist:
            return "\(Int(progress)) of \(rule.steps.count) steps"
        default:
            if rule.frequency.isDayBased && rule.goal > 1 {
                return "\(HabitCopy.number(progress)) of \(HabitCopy.amount(rule.goal, unit.isEmpty ? "times" : unit))"
            }
            return progress > 0 ? "Done" : (day == store.today() ? "Not done yet" : "Not done")
        }
    }

    /// For a week, month or year goal: how that whole period went, since the day alone isn't the goal.
    private var periodLine: String? {
        switch rule.frequency {
        case .perWeek, .perMonth, .perYear:
            let noun = switch rule.frequency { case .perWeek: "week"; case .perMonth: "month"; default: "year" }
            let progress = store.progress(of: habit, on: day), goal = store.goal(of: rule)
            let amount = rule.kind == .duration ? "\(Format.minutes(progress)) of \(Format.minutes(goal))"
                : "\(HabitCopy.number(progress)) of \(HabitCopy.amount(goal, rule.kind == .check && unit.isEmpty ? "times" : unit))"
            return "That \(noun): \(amount)."
        case .flexible(let period, let needed):
            let count = store.flexibleProgress(habit, on: day) ?? 0
            return "That \(period.noun): \(count) of \(needed) \(needed == 1 ? "day" : "days")."
        default:
            return nil
        }
    }

    // MARK: Changing it

    @ViewBuilder private var controls: some View {
        switch rule.kind {
        case .check:
            let count = store.loggedEntries(of: habit, on: day).reduce(0) { $0 + $1.value }
            if rule.frequency.isDayBased && rule.goal > 1 {
                // "3 times a day": the number of times, one either way.
                Section {
                    Stepper(value: Binding(get: { Int(count) }, set: { set(times: $0, from: Int(count)) }), in: 0...999) {
                        Text("Done \(HabitCopy.times(Int(count)))").monospacedDigit()
                    }
                    .accessibilityIdentifier("day-times")
                }
            } else {
                Section {
                    if count > 0 {
                        Button("Mark as Not Done", systemImage: "xmark.circle") { store.clearDay(habit, on: day) }
                    } else {
                        Button("Mark as Done", systemImage: "checkmark.circle") { store.addProgress(habit, value: 1, on: day) }
                            .fontWeight(.semibold)
                            .tint(habit.color.color)
                    }
                }
                .accessibilityIdentifier("day-check")
            }
        case .amount, .duration:
            let timed = rule.kind == .duration
            let logged = store.loggedEntries(of: habit, on: day)
            Section {
                Button(timed ? "Log Time Manually" : "Log Amount Manually", systemImage: "square.and.pencil") { showLog = true }
                    .accessibilityIdentifier("day-log")
            }
            if !logged.isEmpty {
                Section {
                    ForEach(logged) { entry in
                        LabeledContent {
                            Button("Delete", systemImage: "trash", role: .destructive) { store.undoEntry(entry.id) }
                                .labelStyle(.iconOnly)
                                .buttonStyle(.borderless)
                                .accessibilityIdentifier("delete-entry")
                        } label: {
                            Text(timed ? Format.minutes(entry.value) : HabitCopy.amount(entry.value, unit)).monospacedDigit()
                        }
                    }
                    .onDelete { offsets in offsets.map { logged[$0].id }.forEach(store.undoEntry) }
                } header: {
                    Text("Logged that day")
                }
            }
        case .checklist:
            Section("Steps") {
                ForEach(rule.steps) { step in
                    let done = store.isStepDone(step, of: habit, on: day)
                    Button { store.toggleStep(step, of: habit, on: day) } label: {
                        Label { Text(step.name).foregroundStyle(.primary) } icon: {
                            Image(systemName: done ? "checkmark.circle.fill" : "circle").foregroundStyle(done ? habit.color.color : .secondary)
                        }
                    }
                    .accessibilityLabel(step.name)
                    .accessibilityValue(done ? "Done" : "Not done")
                }
            }
        case .quit, .task:
            EmptyView()
        }
    }

    /// Adds or takes out ticks until the day has `times`: one tap on the stepper is one tick either way.
    private func set(times: Int, from current: Int) {
        if times > current {
            store.addProgress(habit, value: 1, on: day)
        } else if times < current, let last = store.loggedEntries(of: habit, on: day).last {
            store.undoEntry(last.id)
        }
    }
}
