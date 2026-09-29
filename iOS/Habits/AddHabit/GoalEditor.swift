import SwiftUI

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
