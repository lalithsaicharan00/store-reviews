import SwiftUI

/// An addition, never a replacement of the day's or period's total.
struct LogProgressView: View {
    let habit: Habit
    let day: LocalDay
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var amount = ""
    @State private var hours = "0"
    @State private var minutes = "0"
    @State private var saving = false
    @FocusState private var typing: Bool

    private var timed: Bool { habit.kind == .duration }
    private var unit: String { if case .amount(let unit, _) = habit.kind { unit } else { "" } }
    /// The last amount logged for this habit: most logs repeat it (a 250 ml glass, a 5 km run),
    /// so it's one tap instead of typing, with no "Each tap adds" setting to configure.
    private var lastAmount: Double? {
        store.entries.last { $0.habitID == habit.id && $0.stepID == nil && $0.value > 0 }?.value
    }
    /// "1", "250 ml", "25 min": a count of one never gets a plural unit ("1 glasses").
    private func text(_ v: Double) -> String {
        if timed { return Format.minutes(v) }
        return v == 1 || unit.isEmpty ? Format.amount(v) : "\(Format.amount(v)) \(unit)"
    }

    private var value: Double? {
        if timed { return GoalDraft(hours: hours, minutes: minutes).duration }
        guard let n = GoalNumber.parse(amount), n > 0 else { return nil }
        return n
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text(habit.name)
                    Text(day.date(calendar: store.calendar).formatted(date: .abbreviated, time: .omitted))
                        .foregroundStyle(.secondary)
                }
                if timed {
                    DurationInput(hours: $hours, minutes: $minutes)
                } else {
                    Section {
                        LabeledContent("Amount") {
                            HStack(spacing: 6) {
                                TextField("0", text: $amount)
                                    .keyboardType(.decimalPad).multilineTextAlignment(.trailing)
                                    .font(.body.monospacedDigit().weight(.semibold))
                                    .focused($typing).accessibilityLabel("Amount to add, in \(unit)")
                                    .accessibilityIdentifier("log-amount")
                                if !unit.isEmpty { Text(unit).foregroundStyle(.secondary) }
                            }
                        }
                    } footer: {
                        Text("Enter the amount to add, not your total. Up to 2 decimal places.")
                    }
                }
                if let lastAmount {
                    Section {
                        Button("Add \(text(lastAmount)) again") { add(lastAmount) }
                            .disabled(saving)
                            .accessibilityIdentifier("log-same-again")
                    } footer: {
                        Text("The same as last time, in one tap.")
                    }
                }
                Section {
                    LabeledContent("Progress", value: goalLine(habit, progress: store.progress(of: habit, on: day), goal: store.goal(of: habit)))
                } footer: {
                    Text("This entry adds to your progress. You can go beyond your goal.")
                }
            }
            .selectsNumbersOnFocus()
            .navigationTitle(timed ? "Add Time" : "Add Amount")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() }.disabled(saving) }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") { if let value { add(value) } }
                        .fontWeight(.semibold)
                        .disabled(value == nil || saving)
                }
                ToolbarItemGroup(placement: .keyboard) {
                    if typing { Spacer(); Button("Done") { typing = false } }
                }
            }
            .task { if !timed { typing = true } }
            .presentationDetents([.medium, .large])
            .alert("Couldn't save progress", isPresented: Binding(get: { store.problem != nil }, set: { if !$0 { store.problem = nil } })) {
                Button("OK") { store.problem = nil }
            } message: { Text(store.problem ?? "") }
            .interactiveDismissDisabled(saving)
        }
    }

    private func add(_ value: Double) {
        saving = true
        store.addProgress(habit, value: value, on: day)
        Task { @MainActor in
            await store.flush()
            saving = false
            if store.problem == nil { dismiss() }
        }
    }
}
