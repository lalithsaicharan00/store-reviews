import SwiftUI

/// Quantity and reset period, separate from Schedule. Period changes that replace the active
/// calendar rule are confirmed; the Schedule draft survives for restoration.
struct GoalEditor: View {
    @Binding var goal: GoalDraft
    @Binding var schedule: ScheduleDraft
    @State private var pendingPeriod: GoalPeriod?
    @State private var confirmPeriod = false
    let timed: Bool
    let check: Bool
    let usedUnits: [String]
    /// The user's week start (1 = Sunday), so the weekly copy names their own days.
    let weekStart: Int
    @FocusState private var typing: Bool

    private var value: Double? { goal.value(timed: timed, check: check) }

    private var periodNote: String {
        switch goal.period {
        case .day: return "Starts again each scheduled day."
        case .week:
            let first = Calendar.current.standaloneWeekdaySymbols[(weekStart - 1) % 7]
            return "Everything you log this week adds up. It starts again on \(first)."
        case .month: return "Everything you log this month adds up. It starts again on the 1st."
        case .year:
            let first = Calendar.current.date(from: DateComponents(year: 2026, month: 1, day: 1))!
            return "Everything you log this year adds up. It starts again on \(first.formatted(.dateTime.day().month(.wide)))."
        }
    }

    private var periodSelection: Binding<GoalPeriod> {
        Binding(get: { goal.period }, set: { proposed in
            guard proposed != goal.period else { return }
            typing = false
            if goal.period == .day || proposed == .day {
                pendingPeriod = proposed
                confirmPeriod = true
            } else { goal.period = proposed }
        })
    }
    private var oncePerPeriod: Bool {
        check && goal.amountValue(check: true) == 1 && pendingPeriod != .day
    }
    private var transitionTitle: String {
        if pendingPeriod == .day { return "Restore \(schedule.summary)?" }
        if oncePerPeriod { return "Use 1 day a \(pendingPeriod?.noun ?? "week")?" }
        return "Use Any Day?"
    }
    private func acceptPeriod() {
        guard let period = pendingPeriod else { return }
        if oncePerPeriod {
            schedule.mode = .flexible
            schedule.flexiblePeriod = period
            schedule.count = 1
            goal.period = .day
        } else { goal.period = period }
        pendingPeriod = nil
    }

    private var todayNote: String {
        if timed { return "On Today, ▶ starts a timer that keeps going when you leave the app. To type the time instead, tap the habit." }
        if check { return "Each tap on ✓ adds one. The unit names what you're counting." }
        return CountLogging.explanation(goal: value, unit: goal.trimmedUnit)
    }

    var body: some View {
        Form {
            Section {
                GoalReadBack(amount: goal.amountText(timed: timed, check: check), period: goal.period)
            }
            .listRowBackground(Color.clear)
            Section {
                Picker("Goal counts over", selection: periodSelection) {
                    ForEach(GoalPeriod.allCases) { Text($0.label).tag($0) }
                }
                .pickerStyle(.menu)
                .accessibilityIdentifier("goal-period")
            } footer: {
                Text(periodNote).formNote()
            }
            if timed {
                DurationInput(hours: $goal.hours, minutes: $goal.minutes, period: goal.period,
                              header: "Goal", note: todayNote)
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
                        UnitPicker(unit: $goal.unit, used: usedUnits, mode: check ? .tick : .amount, allowsNone: !check)
                    } label: {
                        LabeledContent("Unit") {
                            Text(goal.trimmedUnit.isEmpty ? "Optional" : goal.trimmedUnit)
                                .foregroundStyle(goal.trimmedUnit.isEmpty ? .tertiary : .secondary)
                        }
                    }
                    .accessibilityIdentifier("goal-unit")
                } header: {
                    Text("Goal")
                } footer: {
                    Text(entryError ?? todayNote).formNote()
                }
            }
        }
        // Compact, so the amount and unit stay above the number keyboard.
        .listSectionSpacing(.compact)
        .contentMargins(.top, 4, for: .scrollContent)
        .navigationTitle("Goal")
        .navigationBarTitleDisplayMode(.inline)
        .scrollDismissesKeyboard(.interactively)
        .selectsNumbersOnFocus()
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                if typing { Spacer(); Button("Done") { typing = false }.fontWeight(.semibold) }
            }
        }
        .alert(transitionTitle, isPresented: $confirmPeriod) {
            Button(pendingPeriod == .day ? "Restore Schedule" : oncePerPeriod ? "Use 1 Day" : "Use Any Day", action: acceptPeriod)
            if pendingPeriod == .day {
                Button("Every day") { schedule.mode = .daily; goal.period = .day; pendingPeriod = nil }
            }
            Button("Cancel", role: .cancel) { pendingPeriod = nil }
        } message: {
            Text(pendingPeriod == .day
                 ? "Your goal will start again each scheduled day."
                 : oncePerPeriod ? "One check-off in a period is one successful day. Schedule will count that day, with a goal of once a day."
                 : "Your \(pendingPeriod?.noun ?? "week") goal adds up across the period, so the current day schedule won't apply. Your previous schedule is kept for later.")
        }
        // Track an amount opens empty, so the keyboard is ready for its number.
        .task { if !timed && goal.amount.isEmpty { typing = true } }
    }

    /// Only when what's typed can't be used; otherwise the footer says what Today will do.
    private var entryError: String? {
        let text = goal.amount.trimmingCharacters(in: .whitespaces)
        guard !text.isEmpty, goal.amountValue(check: check) == nil else { return nil }
        return goal.wholeOnly(check: check) ? "Enter a whole number above 0." : "Enter a number above 0, with up to 2 decimal places."
    }
}

/// The goal said back, big and centred on the screen's background, like Fitness's Move goal: a result,
/// not a field. VoiceOver reads it as one line.
struct GoalReadBack: View {
    let amount: String?
    let period: GoalPeriod

    var body: some View {
        VStack(spacing: 2) {
            Text(amount ?? "—")
                .font(.system(.largeTitle, design: .rounded).weight(.bold).monospacedDigit())
                .foregroundStyle(amount == nil ? .tertiary : .primary)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .contentTransition(.numericText())
            Text(amount == nil ? "Set your goal below." : period.suffix)
                .font(.title3)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, -4)
        .animation(.snappy, value: amount)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(amount.map { "Your goal: \($0) \(period.suffix)" } ?? "No goal yet")
        .accessibilityIdentifier("goal-summary")
    }
}

/// Time stays hours + minutes. The wheels show straight away, like the Clock app's timer; Type is
/// there for exact or large durations (100 hours a year), so nobody scrolls a long wheel.
struct DurationInput: View {
    @Binding var hours: String
    @Binding var minutes: String
    var period: GoalPeriod = .day
    var header = "Time"
    /// Shown under the wheels when the time is valid (what Today does with it).
    var note: String? = nil
    @State private var exact = false
    private enum Part { case hours, minutes }
    @FocusState private var typing: Part?

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
            // On this one row, not the Section: a Section repeats its modifiers for every row inside it,
            // which put four Next buttons on the keyboard (reported 28 Sep).
            .onChange(of: exact) {
                // Type: the hours field is ready at once.
                typing = exact ? .hours : nil
                // Invalid typed input stays visible for correction; never normalize it silently.
                if !exact && !valid { exact = true }
            }
            .toolbar {
                // The number pad has no return key: Next moves from hours to minutes.
                ToolbarItemGroup(placement: .keyboard) {
                    if typing == .hours { Spacer(); Button("Next") { typing = .minutes }.fontWeight(.semibold) }
                    if typing == .minutes { Spacer(); Button("Done") { typing = nil }.fontWeight(.semibold) }
                }
            }
            if exact {
                // One row, "3 h 0 min", so both fields stay above the number keyboard.
                LabeledContent("Time") {
                    HStack(spacing: 6) {
                        TextField("0", text: $hours).keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing).focused($typing, equals: .hours)
                            .font(.body.monospacedDigit().weight(.semibold))
                            .frame(minWidth: 28, maxWidth: 72)
                            .accessibilityLabel("Hours").accessibilityIdentifier("duration-hours")
                        Text("h").foregroundStyle(.secondary)
                        TextField("0", text: $minutes).keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing).focused($typing, equals: .minutes)
                            .font(.body.monospacedDigit().weight(.semibold))
                            .frame(minWidth: 28, maxWidth: 44)
                            .accessibilityLabel("Minutes").accessibilityIdentifier("duration-minutes")
                        Text("min").foregroundStyle(.secondary)
                    }
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
            Text(header)
        } footer: {
            Text(footer).formNote()
        }
    }

    private var footer: String {
        if !valid {
            let most = Int(period.maxMinutes / 60)
            return "Enter whole hours and 0–59 minutes: more than 0, and at most \(most) hours in a \(period.noun)."
        }
        return note ?? (exact ? "Hours and minutes, typed exactly." : "Choose Type for more than \(wheelHours) hours.")
    }
}
