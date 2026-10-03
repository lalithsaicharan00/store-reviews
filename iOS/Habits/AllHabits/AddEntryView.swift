import SwiftUI

/// Add Entry (the user, 3 Oct 2026: "create an add entry screen … it might be changing depending upon the habit type …
/// for adding an entry the mental model from any habit page should be same"; research History). One screen with the same
/// shape for every habit: the habit and the day's result, the date (today, or the day it was opened from), then what
/// happened in the habit's own terms, then the day's entries. Add saves one entry; it never replaces the day's total.
///
///   amount        a number in the habit's unit (a limit: "record what happened")
///   time          hours and minutes
///   several a day the number of times
///   once a day    marks the day done
///   checklist     the steps done
///   quit          when the slip happened
struct AddEntryView: View {
    let habit: Habit
    @State private var day: LocalDay
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var draft: ProgressValueDraft
    @State private var times = 1
    @State private var steps: Set<UUID> = []
    @State private var slipTime = Date.now
    @State private var saving = false
    @State private var focused = false
    @FocusState private var typing: Bool

    init(habit: Habit, day: LocalDay) {
        self.habit = habit
        _day = State(initialValue: day)
        _draft = State(initialValue: ProgressValueDraft(kind: habit.kind))
    }

    private var current: Habit { store.habits.first { $0.id == habit.id } ?? habit }
    private var first: LocalDay { habit.kind == .quit ? store.quitStartDay(of: current) : store.startDay(of: current) }

    var body: some View {
        let calendar = store.calendar
        let today = store.today()
        let ruled = store.rule(current, on: day)
        NavigationStack {
            Form {
                Section {
                    LabeledContent(current.name, value: store.dayResult(current, on: day))
                        .accessibilityIdentifier("add-entry-result")
                    DatePicker("Date", selection: Binding(get: { day.date(calendar: calendar) },
                                                          set: { day = LocalDay($0, calendar: calendar) }),
                               in: min(first, today).date(calendar: calendar)...today.date(calendar: calendar),
                               displayedComponents: .date)
                        .accessibilityIdentifier("add-entry-date")
                } footer: {
                    if store.isPaused(current, on: day) {
                        Text("This day is paused. An entry still goes into your history.")
                    } else if store.isSkipped(current, on: day) {
                        Text("This day is skipped. Adding an entry keeps the skip; undo it in the day's details.")
                    }
                }
                valueSection(ruled)
                DayEntriesSection(habit: ruled, day: day)
            }
            .accessibilityIdentifier("log-form")
            .selectsNumbersOnFocus()
            .scrollDismissesKeyboard(.immediately)
            .navigationTitle("Add Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() }.disabled(saving) }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") { add(ruled) }
                        .fontWeight(.semibold)
                        .disabled(!canAdd(ruled) || saving)
                        .accessibilityIdentifier("add-entry-save")
                }
                ToolbarItemGroup(placement: .keyboard) {
                    if typing { Spacer(); Button("Done") { typing = false } }
                }
            }
            .task {
                // The amount field takes the keyboard at once: typing is the whole job (as Log Amount).
                if !focused { focused = true; if case .amount = ruled.kind { typing = true } }
            }
            .onChange(of: day) { slipTime = slipBounds.upperBound }
            .alert("Couldn't save the entry", isPresented: Binding(get: { store.problem != nil }, set: { if !$0 { store.problem = nil } })) {
                Button("OK") { store.problem = nil }
            } message: { Text(store.problem ?? "") }
        }
        .presentationDetents([.large])
        .interactiveDismissDisabled(saving)
    }

    // MARK: What happened, by type

    @ViewBuilder private func valueSection(_ ruled: Habit) -> some View {
        switch ruled.kind {
        case .amount(let unit, _):
            Section {
                LabeledContent("Amount") {
                    HStack(spacing: 6) {
                        DraftTextField(draft: draft, key: \.amount, placeholder: "0", keyboard: .decimalPad)
                            .multilineTextAlignment(.trailing)
                            .font(.body.monospacedDigit().weight(.semibold))
                            .focused($typing)
                            .accessibilityLabel("Amount, in \(unit)")
                            .accessibilityIdentifier("log-amount")
                        if !unit.isEmpty { Text(unit).foregroundStyle(.secondary) }
                    }
                }
            } footer: {
                Text(ruled.atMost ? "Record what happened. Your limit stays the same."
                     : "What you did this time, not your total so far. Up to 2 decimal places.")
            }
        case .duration:
            DurationInput(hours: draft.binding(\.hours), minutes: draft.binding(\.minutes))
        case .check where countsTimes(ruled):
            Section {
                Stepper(value: $times, in: 1...99) {
                    LabeledContent("Times", value: "\(times)").monospacedDigit()
                }
                .accessibilityIdentifier("add-entry-times")
            } footer: {
                Text("Adds to what's already logged on this day.")
            }
        case .check, .task:
            Section {
                if store.isDayMet(ruled, on: day) {
                    Label("Already done on this day", systemImage: "checkmark.circle")
                        .foregroundStyle(.secondary)
                } else {
                    Label("Marks this day done", systemImage: "checkmark.circle")
                }
            }
        case .checklist:
            Section("Steps") {
                ForEach(ruled.steps) { step in
                    let done = store.isStepDone(step, of: ruled, on: day)
                    Toggle(step.name, isOn: Binding(get: { done || steps.contains(step.id) },
                                                    set: { on in if on { steps.insert(step.id) } else { steps.remove(step.id) } }))
                        .disabled(done)
                }
            }
        case .quit:
            let bounds = slipBounds
            Section {
                if bounds.lowerBound <= bounds.upperBound {
                    DatePicker("Slipped at", selection: $slipTime, in: bounds, displayedComponents: .hourAndMinute)
                        .accessibilityIdentifier("add-entry-slip-time")
                } else {
                    Text("This day is before this run started.").foregroundStyle(.secondary)
                }
            } footer: {
                Text("A slip is recorded with its time. You can change or remove it later.")
            }
        }
    }

    /// Several times a day, or a number of times in a week or month: count them. Once a day: done.
    private func countsTimes(_ ruled: Habit) -> Bool {
        store.dayGoal(of: ruled) > 1 || !ruled.frequency.isDayBased
    }

    private var slipBounds: ClosedRange<Date> {
        let bounds = store.dayBounds(day)
        let lower = max(bounds.lowerBound, min(current.quitSince ?? current.createdAt, current.createdAt))
        let upper = min(bounds.upperBound, .now)
        return lower <= upper ? lower...upper : upper...upper
    }

    private func canAdd(_ ruled: Habit) -> Bool {
        switch ruled.kind {
        case .amount, .duration: draft.isValid
        case .check where countsTimes(ruled): times >= 1
        case .check, .task: !store.isDayMet(ruled, on: day)
        case .checklist: ruled.steps.contains { steps.contains($0.id) && !store.isStepDone($0, of: ruled, on: day) }
        case .quit: day <= store.today()
        }
    }

    private func add(_ ruled: Habit) {
        saving = true
        switch ruled.kind {
        case .amount, .duration:
            if let value = draft.value { store.addProgress(ruled, value: value, on: day, source: .manual) }
        case .check where countsTimes(ruled):
            store.addProgress(ruled, value: Double(times), on: day, source: .manual)
        case .check, .task:
            store.setDayDone(true, of: current, on: day)
        case .checklist:
            for step in ruled.steps where steps.contains(step.id) && !store.isStepDone(step, of: ruled, on: day) {
                store.toggleStep(step, of: ruled, on: day, source: .manual)
            }
        case .quit:
            let bounds = slipBounds
            store.slip(current, on: day, at: min(max(slipTime, bounds.lowerBound), bounds.upperBound), source: .manual)
        }
        // The entry is on screen at once and the write follows (Rulebook S7): waiting for the database kept the sheet
        // open for seconds behind a busy write queue (a year of demo history, CI 3 Oct 2026). A failed write reloads
        // and says so on the screen underneath (Today's and the Day sheet's alert).
        dismiss()
    }
}
