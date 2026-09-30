import SwiftUI

/// An addition, never a replacement of the day's or period's total.
struct LogProgressView: View {
    let habit: Habit
    let day: LocalDay
    var source: EntrySource = .manual
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var perfEntry: Entry?
    @State private var draft: ProgressValueDraft
    @State private var saving = false
    @State private var showDay = false
    @FocusState private var typing: Bool

    init(habit: Habit, day: LocalDay, source: EntrySource = .manual) {
        self.habit = habit
        self.day = day
        self.source = source
        _draft = State(initialValue: ProgressValueDraft(kind: habit.kind))
    }

    private var timed: Bool { habit.kind == .duration }
    private var unit: String { if case .amount(let unit, _) = habit.kind { unit } else { "" } }
    /// The last amount logged for this habit: most logs repeat it (a 250 ml glass, a 5 km run),
    /// so it's one tap instead of typing, with no "Each tap adds" setting to configure.
    private var lastAmount: Double? {
        // For time, a whole minute or more: a few seconds between Pause and Resume isn't an amount to repeat
        // ("Add 0 min again", found by hand 29 Sep).
        let smallest: Double = timed ? 1 : 0.0001
        let entry = store.entries(of: habit.id).last { (e: Entry) -> Bool in e.stepID == nil && e.value >= smallest }
        guard let value = entry?.value else { return nil }
        return timed ? value.rounded() : value
    }
    /// "1 glass", "5,200 steps", "25 min": whole numbers in sentences ("k" is only for Today's compact rows).
    private func text(_ v: Double) -> String {
        timed ? Format.minutes(v) : HabitCopy.amount(v, unit)
    }

    /// "12 min of 20 min", "5,200 of 8,000 steps".
    private var progressText: String {
        let progress = store.progress(of: habit, on: day), goal = store.goal(of: habit)
        if timed { return "\(Format.minutes(progress)) of \(Format.minutes(goal))" }
        return "\(HabitCopy.number(progress)) of \(HabitCopy.amount(goal, unit))"
    }

    private var value: Double? { draft.value }

    var body: some View {
        NavigationStack {
            Form {
                // The habit and, for another day, the date; today needs no date line (the sheet opened over it).
                Section {
                    LabeledContent(habit.name, value: progressText)
                        .accessibilityIdentifier("log-progress")
                    if day != store.today() {
                        Text(day.date(calendar: store.calendar).formatted(date: .abbreviated, time: .omitted))
                            .foregroundStyle(.secondary)
                    }
                } footer: {
                    Text(habit.atMost ? "Record what happened. Your limit stays the same."
                         : "This adds to your progress. You can go beyond your goal.")
                }
                if timed {
                    DurationInput(hours: draft.binding(\.hours), minutes: draft.binding(\.minutes))
                } else {
                    Section {
                        LabeledContent("Amount") {
                            HStack(spacing: 6) {
                                TextField("0", text: draft.binding(\.amount))
                                    .keyboardType(.decimalPad).multilineTextAlignment(.trailing)
                                    .font(.body.monospacedDigit().weight(.semibold))
                                    .focused($typing).accessibilityLabel("Amount to add, in \(unit)")
                                    .accessibilityIdentifier("log-amount")
                                if !unit.isEmpty { Text(unit).foregroundStyle(.secondary) }
                            }
                        }
                    } footer: {
                        Text("Enter what you did, not your total so far. Up to 2 decimal places.")
                    }
                }
                if let lastAmount {
                    Section {
                        Button("Log \(text(lastAmount)) again") { add(lastAmount) }
                            .disabled(saving)
                            .accessibilityIdentifier("log-same-again")
                    } footer: {
                        Text("The same as last time, in one tap.")
                    }
                }
                DayEntriesSection(habit: habit, day: day)
                Section {
                    Button("Edit This Day's Progress…") { showDay = true }
                }
            }
            .sheet(isPresented: $showDay) { DaySheet(habit: habit, day: day) }
            .selectsNumbersOnFocus()
            .scrollDismissesKeyboard(.immediately)
            .accessibilityIdentifier("log-form")
            .task { if !timed { typing = true } }
            // "Log", never "Add Time": this records time done by hand; "add time" reads as adding extra (the user, 29 Sep).
            .navigationDestination(item: $perfEntry) { EntryEditView(habit: habit, entry: $0) }
            .navigationTitle(timed ? "Log Time" : "Log Amount")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() }.disabled(saving) }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Log") { if let value { add(value) } }
                        .fontWeight(.semibold)
                        .disabled(!draft.isValid || saving)
                }
                ToolbarItemGroup(placement: .keyboard) {
                    if typing { Spacer(); Button("Done") { typing = false } }
                }
            }
            .onPerfCommand { action in
                switch action {
                case .openEntry: perfEntry = store.entries(of: habit.id, on: day).last
                case .closeLog: dismiss()
                case .logAgain: if let lastAmount { add(lastAmount) }
                case .logAmount(let text): draft.binding(\.amount).wrappedValue = text
                default: break
                }
            }
            // Time needs the wheels, the Scroll/Type switch and "again" in view at once: open it at full height
            // (at half height the wheels were cut off and had to be dragged up, found by hand 29 Sep).
            .presentationDetents([.large])
            .alert("Couldn't save progress", isPresented: Binding(get: { store.problem != nil }, set: { if !$0 { store.problem = nil } })) {
                Button("OK") { store.problem = nil }
            } message: { Text(store.problem ?? "") }
            .interactiveDismissDisabled(saving)
        }
    }

    private func add(_ value: Double) {
        saving = true
        store.addProgress(habit, value: value, on: day, source: source)
        Task { @MainActor in
            await store.flush()
            saving = false
            if store.problem == nil { dismiss() }
        }
    }
}
