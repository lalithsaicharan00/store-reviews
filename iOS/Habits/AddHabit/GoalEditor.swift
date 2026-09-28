import SwiftUI

/// The Goal screen for Check it off, Count it and Time it: the period first, then how much, then one
/// sentence saying the goal back and what + will do on Today. Native Form controls only
/// (spec: iOS/New Habit Goal and Time of Day.md §3).
struct GoalEditor: View {
    @Binding var goal: GoalDraft
    let timed: Bool
    let check: Bool
    let usedUnits: [String]
    let periodDates: (GoalPeriod) -> String
    @FocusState private var typing: Bool

    private var value: Double? { goal.value(timed: timed, check: check) }

    private var periodNote: String {
        if goal.period == .day { return "The goal is for each day it's due. Repeat, on the form, sets which days." }
        let what = timed ? "all the time you log" : goal.wholeOnly(check: check) ? "every tick" : "everything you log"
        return "Any days you like: \(what) in the \(goal.period.noun) adds up. There's no daily minimum. \(periodDates(goal.period))"
    }

    private var todayNote: String {
        if timed { return "On Today, ▶ starts a timer. You can also add time by touching and holding the habit." }
        if goal.wholeOnly(check: check) {
            let v = value ?? 1
            return v == 1 && goal.period == .day ? "On Today, tap ✓ when it's done."
                : "On Today, each tap on ✓ ticks it once, even twice in one day."
        }
        return CountLogging.explanation(goal: value, unit: goal.trimmedUnit)
    }

    var body: some View {
        Form {
            Section {
                Picker("Per", selection: $goal.period.animation()) {
                    ForEach(GoalPeriod.allCases) { Text($0.rawValue).tag($0) }
                }
                .pickerStyle(.segmented)
                .accessibilityIdentifier("goal-period")
            } header: {
                Text("Per")
            } footer: {
                Text(periodNote).formNote()
            }
            if timed {
                DurationInput(hours: $goal.hours, minutes: $goal.minutes, period: goal.period)
            } else {
                Section {
                    LabeledContent("Amount") {
                        TextField(check ? "1" : "e.g. 8", text: $goal.amount)
                            .keyboardType(goal.wholeOnly(check: check) ? .numberPad : .decimalPad)
                            .multilineTextAlignment(.trailing)
                            .font(.body.monospacedDigit().weight(.semibold))
                            .focused($typing)
                            .accessibilityLabel("Goal amount")
                            .accessibilityIdentifier("goal-amount")
                    }
                    NavigationLink {
                        UnitPicker(unit: $goal.unit, used: usedUnits)
                    } label: {
                        LabeledContent("Unit") {
                            Text(goal.trimmedUnit.isEmpty ? "Choose" : goal.trimmedUnit)
                                .foregroundStyle(goal.trimmedUnit.isEmpty ? .tertiary : .secondary)
                        }
                    }
                    .accessibilityIdentifier("goal-unit")
                } header: {
                    Text("Goal")
                } footer: {
                    if let note = entryNote { Text(note).formNote() }
                }
            }
            Section {
                LabeledContent("Your goal", value: goal.summary(timed: timed, check: check) ?? "Not set yet")
                    .accessibilityIdentifier("goal-summary")
            } footer: {
                Text(todayNote).formNote()
            }
        }
        .selectsNumbersOnFocus()
        .navigationTitle("Goal")
        .navigationBarTitleDisplayMode(.inline)
        .scrollDismissesKeyboard(.interactively)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                if typing { Spacer(); Button("Done") { typing = false }.fontWeight(.semibold) }
            }
        }
        // Count it opens empty, so the keyboard is ready for its number.
        .task { if !timed && goal.amount.isEmpty { typing = true } }
    }

    /// What's wrong with the amount or unit, or for Check it off, what choosing another unit does.
    private var entryNote: String? {
        let text = goal.amount.trimmingCharacters(in: .whitespaces)
        if !text.isEmpty && goal.amountValue(check: check) == nil {
            return goal.wholeOnly(check: check) ? "Enter a whole number above 0." : "Enter a number above 0, with up to 2 decimal places."
        }
        if check { return "Keep “times” for a tick. Choose another unit, like glasses or pages, to count an amount with +." }
        return nil
    }
}

/// Time stays hours + minutes. The wheels show straight away, like the Clock app's timer; Type is
/// there for exact or large durations (100 hours a year), so nobody scrolls a long wheel.
struct DurationInput: View {
    @Binding var hours: String
    @Binding var minutes: String
    var period: GoalPeriod = .day
    @State private var exact = false
    @FocusState private var typing: Bool

    private var hourValue: Int { Int(GoalNumber.parse(hours, decimals: 0) ?? 0) }
    private var minuteValue: Int { min(59, Int(GoalNumber.parse(minutes, decimals: 0) ?? 0)) }
    private var wheelHours: Int { period == .day ? 23 : 99 }
    private var hourChoices: [Int] { Array(0...wheelHours) + (hourValue > wheelHours ? [hourValue] : []) }
    private var valid: Bool { GoalDraft(hours: hours, minutes: minutes).duration(max: period.maxMinutes) != nil }

    var body: some View {
        Section {
            Picker("Enter time", selection: $exact) {
                Text("Scroll").tag(false)
                Text("Type").tag(true)
            }
            .pickerStyle(.segmented)
            .accessibilityIdentifier("duration-entry-mode")
            if exact {
                LabeledContent("Hours") {
                    TextField("0", text: $hours).keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing).focused($typing)
                        .font(.body.monospacedDigit().weight(.semibold))
                        .accessibilityLabel("Hours").accessibilityIdentifier("duration-hours")
                }
                LabeledContent("Minutes") {
                    TextField("0", text: $minutes).keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing).focused($typing)
                        .font(.body.monospacedDigit().weight(.semibold))
                        .accessibilityLabel("Minutes").accessibilityIdentifier("duration-minutes")
                }
            } else {
                HStack(spacing: 0) {
                    Picker("Hours", selection: Binding(get: { hourValue }, set: { hours = String($0) })) {
                        ForEach(hourChoices, id: \.self) { Text("\($0) h").tag($0) }
                    }
                    .accessibilityIdentifier("hours-wheel")
                    Picker("Minutes", selection: Binding(get: { minuteValue }, set: { minutes = String($0) })) {
                        ForEach(0..<60) { Text("\($0) min").tag($0) }
                    }
                    .accessibilityIdentifier("minutes-wheel")
                }
                .pickerStyle(.wheel)
                .frame(height: 160)
            }
        } header: {
            Text("Goal")
        } footer: {
            Text(footer).formNote()
        }
        .onChange(of: exact) {
            typing = false
            // Invalid typed input stays visible for correction; never normalize it silently.
            if !exact && !valid { exact = true }
        }
    }

    private var footer: String {
        if !valid {
            let most = Int(period.maxMinutes / 60)
            return "Enter whole hours and 0–59 minutes: more than 0, and at most \(most) hours in a \(period.noun)."
        }
        return exact ? "Hours and minutes, typed exactly." : "Choose Type for an exact time, or more than \(wheelHours) hours."
    }
}
