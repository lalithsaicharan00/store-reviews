import SwiftUI

/// The same native entry rows in both sheets. Reads the indexed habit/day bucket, never all history.
struct DayEntriesSection: View {
    let habit: Habit
    let day: LocalDay
    @Environment(HabitStore.self) private var store

    var body: some View {
        let entries = store.entries(of: habit.id, on: day)
        Section(day == store.today() ? "Today's Entries" : "Entries") {
            if entries.isEmpty {
                Text("No entries yet").foregroundStyle(.secondary)
            }
            ForEach(entries.reversed()) { entry in
                if entry.stepID == nil && habit.kind != .task {
                    NavigationLink {
                        EntryEditView(habit: habit, entry: entry)
                    } label: { label(entry) }
                    .accessibilityIdentifier("entry-\(entry.id)")
                    .swipeActions { delete(entry) }
                } else {
                    label(entry)
                        .swipeActions { delete(entry) }
                }
            }
        }
    }

    private func label(_ entry: Entry) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(entry.description(for: habit)).foregroundStyle(.primary)
            Text(entry.createdAt.formatted(date: .omitted, time: .shortened) + " · " + (entry.source?.label ?? "Source not recorded"))
                .font(.caption).foregroundStyle(.secondary)
        }
        .accessibilityElement(children: .combine)
    }

    private func delete(_ entry: Entry) -> some View {
        Button("Delete", systemImage: "trash", role: .destructive) { store.undoEntry(entry.id) }
    }
}

/// Editing one entry replaces its value, never the day total. All controls are standard Form controls.
struct EntryEditView: View {
    let habit: Habit
    let entry: Entry
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var amount: String
    @State private var hours: String
    @State private var minutes: String
    @State private var seconds: String
    @State private var slipTime: Date
    @FocusState private var typing: Bool

    init(habit: Habit, entry: Entry) {
        self.habit = habit
        self.entry = entry
        _amount = State(initialValue: GoalNumber.text(entry.value))
        _hours = State(initialValue: String(Int(entry.value / 60)))
        _minutes = State(initialValue: String(Int(entry.value) % 60))
        _seconds = State(initialValue: GoalNumber.text((entry.value * 60).truncatingRemainder(dividingBy: 60)))
        _slipTime = State(initialValue: entry.createdAt)
    }

    private var value: Double? {
        if habit.kind == .quit { return 1 }
        if habit.kind == .duration {
            guard let h = GoalNumber.parse(hours, decimals: 0), let m = GoalNumber.parse(minutes, decimals: 0), m < 60,
                  let s = GoalNumber.parse(seconds), s < 60 else { return nil }
            let v = h * 60 + m + s / 60
            return v > 0 && v <= GoalNumber.maximum ? v : nil
        }
        guard let v = GoalNumber.parse(amount, decimals: habit.kind == .check ? 0 : 2), v > 0 else { return nil }
        return v
    }

    private var validSlipTime: Bool {
        habit.kind != .quit || (store.today(now: slipTime) == entry.day && slipTime <= .now
                               && slipTime >= min(habit.quitSince ?? habit.createdAt, habit.createdAt))
    }

    var body: some View {
        Form {
            Section {
                Text(habit.name).font(.headline)
                Text(entry.day.date(calendar: store.calendar).formatted(date: .complete, time: .omitted)).foregroundStyle(.secondary)
                LabeledContent("Source", value: entry.source?.label ?? "Source not recorded")
            }
            if habit.kind == .duration {
                DurationInput(hours: $hours, minutes: $minutes)
                Section {
                    LabeledContent("Seconds") {
                        TextField("0", text: $seconds).keyboardType(.decimalPad).focused($typing)
                            .multilineTextAlignment(.trailing)
                            .accessibilityIdentifier("entry-seconds")
                    }
                }
            } else if habit.kind == .quit {
                let start = store.calendar.startOfDay(for: entry.day.date(calendar: store.calendar)).addingTimeInterval(Double(store.settings.dayEndHour) * 3600)
                let end = store.calendar.date(byAdding: .day, value: 1, to: start)!.addingTimeInterval(-1)
                Section { DatePicker("Slipped at", selection: $slipTime, in: max(start, min(habit.quitSince ?? habit.createdAt, habit.createdAt))...max(max(start, min(habit.quitSince ?? habit.createdAt, habit.createdAt)), min(end, .now))) }
            } else {
                Section {
                    LabeledContent(habit.kind == .check ? "Times" : "Amount") {
                        TextField("Amount", text: $amount).keyboardType(habit.kind == .check ? .numberPad : .decimalPad)
                            .multilineTextAlignment(.trailing).focused($typing)
                            .accessibilityIdentifier("entry-amount")
                    }
                } footer: { Text("Change this entry only. Other entries stay as they are.") }
            }
            Section { Button("Delete Entry", role: .destructive) { store.undoEntry(entry.id); dismiss() } }
        }
        .selectsNumbersOnFocus()
        .navigationTitle("Edit Entry")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    if let value { store.editEntry(entry.id, value: value, at: habit.kind == .quit ? slipTime : nil); dismiss() }
                }.disabled(value == nil || !validSlipTime)
            }
            ToolbarItemGroup(placement: .keyboard) { if typing { Spacer(); Button("Done") { typing = false } } }
        }
        #if DEBUG
        .task {
            // Open the real number keyboard before the profiling driver's typing window.
            if ProcessInfo.processInfo.arguments.contains("-perf-drive"), habit.kind != .duration && habit.kind != .quit { typing = true }
        }
        #endif
        .onPerfCommand { action in
            switch action {
            case .editAmount(let text): amount = text
            case .saveEntry: if let value { store.editEntry(entry.id, value: value); dismiss() }
            default: break
            }
        }
    }
}

extension Entry {
    func description(for habit: Habit) -> String {
        if let stepID { return habit.steps.first { $0.id == stepID }?.name ?? "Checklist step" }
        switch habit.kind {
        case .amount(let unit, _): return HabitCopy.amount(value, unit)
        case .duration: return value < 1 ? "\(HabitCopy.number(value * 60)) sec" : Format.minutes(value)
        case .quit: return "Slipped"
        case .check: return value == 1 ? "Check" : HabitCopy.amount(value, habit.checkUnit ?? "times")
        case .task: return "Done"
        case .checklist: return "Step checked"
        }
    }
    func undoLabel(for habit: Habit) -> String {
        switch habit.kind {
        case .amount: return "Undo +" + description(for: habit)
        case .duration: return "Undo " + description(for: habit)
        default: return "Undo"
        }
    }
}
