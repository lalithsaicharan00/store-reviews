import SwiftUI
import WatchKit

/// Log manually (B3, B15–B18): an amount turned with the Digital Crown (− and + by touch, tap the number to say or type
/// it), or a time in hours and minutes wheels. Always for today, ending now (U19: another time of day is set on the
/// iPhone). The one main action at the bottom says exactly what will be added.
struct LogManuallyScreen: View {
    let habitID: UUID
    @Environment(HabitStore.self) private var store

    var body: some View {
        if let habit = store.habits.first(where: { $0.id == habitID }) {
            let ruled = store.rule(habit, on: store.today())
            if ruled.kind == .duration {
                TimeEntry(habit: habit)
            } else {
                AmountEntry(habit: habit, ruled: ruled)
            }
        }
    }
}

/// An amount, with the Crown's focus on the number (B3). An amount that asks how much opens at the last value logged, so
/// most entries are a short turn; decimals step by one place (B16, B17).
struct AmountEntry: View {
    let habit: Habit
    let ruled: Habit
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var value: Double = 1
    @State private var crown: Double = 1
    @State private var typing = false
    @State private var typed = ""
    @State private var started = false
    @FocusState private var focused: Bool

    private var unit: String { HabitCopy.unit(of: ruled) }
    private var last: Entry? { store.entries(of: habit.id).last { $0.stepID == nil } }
    private var step: Double {
        if let increment = ruled.quickIncrement { return increment }
        if let last, last.value.rounded() != last.value { return 0.1 }
        return 1
    }

    /// The Crown's end: a few times the goal or the number shown, never the app's maximum (9 trillion in steps of one
    /// made the Crown's detents uncountable and the app stopped, run 38113615094). − and + and typing still reach any
    /// number; the end moves up with the number.
    private var crownLimit: Double {
        let goal = store.dayGoal(of: ruled)
        let far = max(step * 200, max(goal, value) * 3)
        return min(GoalNumber.maximum, (far / step).rounded(.up) * step)
    }

    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 6) {
                Button { change(-step) } label: { Image(systemName: "minus").font(.body.weight(.bold)).frame(width: 34, height: 34) }
                    .buttonStyle(.bordered).buttonBorderShape(.circle)
                    .accessibilityLabel("Less")
                    .accessibilityIdentifier("minus")
                Text(HabitCopy.number(value))
                    .font(.system(size: 34, weight: .bold, design: .rounded).monospacedDigit())
                    .minimumScaleFactor(0.5).lineLimit(1)
                    .frame(maxWidth: .infinity, minHeight: 52)
                    .background(RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(focused ? Color.green : Color.white.opacity(0.3), lineWidth: 2.5))
                    .focusable()
                    .focused($focused)
                    .digitalCrownRotation($crown, from: 0, through: crownLimit, by: step, sensitivity: .medium,
                                          isContinuous: false, isHapticFeedbackEnabled: true)
                    .onChange(of: crown) { _, new in value = (new / step).rounded() * step }
                    .onTapGesture { typed = HabitCopy.number(value); typing = true }
                    .accessibilityLabel(HabitCopy.amount(value, unit))
                    .accessibilityAdjustableAction { direction in change(direction == .increment ? step : -step) }
                    .accessibilityIdentifier("amount")
                Button { change(step) } label: { Image(systemName: "plus").font(.body.weight(.bold)).frame(width: 34, height: 34) }
                    .buttonStyle(.bordered).buttonBorderShape(.circle)
                    .accessibilityLabel("More")
                    .accessibilityIdentifier("plus")
            }
            if !unit.isEmpty { Text(unit).font(.footnote).foregroundStyle(.secondary) }
            if ruled.asksHowMuch, let last {
                Text("Last: " + HabitCopy.amount(last.value, unit) + ", " + DayWords.day(last.day, today: store.today(), calendar: store.calendar))
                    .font(.footnote).foregroundStyle(.secondary).lineLimit(1).minimumScaleFactor(0.8)
            }
            Text("Turn the Digital Crown").font(.footnote).foregroundStyle(.secondary)
        }
        .navigationTitle(habit.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("Add " + HabitCopy.amount(value, unit)) { save() }
                    .buttonStyle(.borderedProminent).tint(.white).foregroundStyle(.black)
                    .disabled(value <= 0)
                    .handGestureShortcut(.primaryAction)
                    .accessibilityIdentifier("add")
            }
        }
        .sheet(isPresented: $typing) {
            // Apple's own input (B18): dictation, Scribble, or the keyboard on larger watches. We draw nothing of it.
            VStack {
                TextField("Amount", text: $typed)
                    .accessibilityIdentifier("typed")
                Button("Done") {
                    if let number = Double(typed.replacingOccurrences(of: ",", with: ".")), number.isFinite, number >= 0 {
                        value = min(GoalNumber.maximum, number); crown = value
                    }
                    typing = false
                }
            }
        }
        .background {
            #if DEBUG
            // Speed runs only: the driver turns the Crown (WatchPerfControl).
            Color.clear.onChange(of: WatchPerfControl.shared.crownStep) { _, tick in change(tick % 20 < 10 ? step : -step) }
            #endif
        }
        .onAppear {
            guard !started else { return }
            started = true
            value = ruled.asksHowMuch ? (last?.value ?? 1) : step
            crown = value
            focused = true
        }
    }

    private func change(_ by: Double) {
        value = max(0, min(GoalNumber.maximum, ((value + by) / step).rounded() * step))
        crown = value
        WKInterfaceDevice.current().play(.click)
    }

    private func save() {
        store.addProgress(habit, value: value, on: store.today(), source: .watch)
        dismiss()
    }
}

/// A time (B15): hours and minutes wheels, as in Apple's own Timers; the Crown turns the focused wheel. No seconds on the
/// Watch. Ends now.
struct TimeEntry: View {
    let habit: Habit
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var hours = 0
    @State private var minutes = 25

    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 4) {
                Picker("hours", selection: $hours) {
                    ForEach(0..<24, id: \.self) { Text("\($0)").tag($0) }
                }
                .accessibilityIdentifier("hours")
                Text(":").font(.title2.weight(.bold))
                Picker("minutes", selection: $minutes) {
                    ForEach(0..<60, id: \.self) { Text("\($0)").tag($0) }
                }
                .accessibilityIdentifier("minutes")
            }
            .pickerStyle(.wheel)
            .frame(height: 92)
            Text("Finished now, " + DayWords.clock(store.clock(), calendar: store.calendar))
                .font(.footnote).foregroundStyle(.secondary)
        }
        .navigationTitle(habit.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("Add " + Format.minutes(Double(hours * 60 + minutes))) {
                    store.addProgress(habit, value: Double(hours * 60 + minutes), on: store.today(), at: store.clock(), source: .watch)
                    dismiss()
                }
                .buttonStyle(.borderedProminent).tint(.white).foregroundStyle(.black)
                .disabled(hours == 0 && minutes == 0)
                .handGestureShortcut(.primaryAction)
                .accessibilityIdentifier("add")
            }
        }
    }
}

/// One log (B11): what, which habit, when, where it came from. Editing is on the iPhone; Delete asks first (B12), and the
/// view goes back before the log is removed (U27).
struct LogScreen: View {
    let entryID: UUID
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var asking = false

    var body: some View {
        if let entry = store.entries.first(where: { $0.id == entryID }),
           let habit = store.habits.first(where: { $0.id == entry.habitID }) {
            let ruled = store.rule(habit, on: entry.day)
            ScrollView {
                VStack(spacing: 6) {
                    Text(LogWords.what(entry, habit: ruled))
                        .font(.system(size: 26, weight: .bold, design: .rounded)).minimumScaleFactor(0.6).lineLimit(1)
                    Text(habit.name).font(.body)
                    Text(DayWords.day(entry.day, today: store.today(), calendar: store.calendar) + ", " + store.clockText(of: entry))
                        .foregroundStyle(.secondary)
                    if let origin = entry.originLine(slip: ruled.kind == .quit) {
                        Text(origin.replacingOccurrences(of: ".", with: "")).font(.footnote).foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    Button("Delete", role: .destructive) { asking = true }
                        .foregroundStyle(.red)
                        .padding(.top, 10)
                        .accessibilityIdentifier("delete")
                }
                .frame(maxWidth: .infinity)
            }
            .navigationTitle(ruled.kind == .quit ? "Slip" : "Log")
            .navigationBarTitleDisplayMode(.inline)
            .confirmationDialog("Delete this log?", isPresented: $asking, titleVisibility: .visible) {
                Button("Delete", role: .destructive) {
                    let id = entry.id
                    dismiss()
                    Task { @MainActor in
                        try? await Task.sleep(for: .milliseconds(350))
                        store.undoEntry(id)
                    }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("\(LogWords.what(entry, habit: ruled)) at \(store.clockText(of: entry)) from \(habit.name).")
            }
        }
    }
}

/// Every log of today, when there are four or more (U17).
struct AllLogsScreen: View {
    let habitID: UUID
    @Environment(HabitStore.self) private var store
    @Environment(WatchNavigation.self) private var navigation

    var body: some View {
        if let habit = store.habits.first(where: { $0.id == habitID }) {
            let ruled = store.rule(habit, on: store.today())
            List(store.dayLogs(of: habit, on: store.today())) { entry in
                Button { navigation.path.append(.log(entry.id)) } label: { LogLine(entry: entry, habit: ruled) }
            }
            .navigationTitle("All logs")
        }
    }
}
