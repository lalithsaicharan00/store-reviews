import SwiftUI

/// One habit on one day. Opening history never changes it; controls inside this native Form do.
struct DaySheet: View {
    let habit: Habit
    @State private var day: LocalDay
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var perfEntry: Entry?
    @State private var destination: Destination?
    private enum Destination: String, Identifiable { case log, note; var id: Self { self } }

    init(habit: Habit, day: LocalDay) {
        self.habit = habit
        _day = State(initialValue: day)
    }

    private var current: Habit { store.habits.first { $0.id == habit.id } ?? habit }
    private var ruled: Habit { store.rule(current, on: day) }
    private var editable: Bool { day <= store.today() && day >= store.startDay(of: current) }

    var body: some View {
        let _ = perfTimed("Count: the Day sheet drawn") { () }
        NavigationStack {
            Form {
                Section {
                    Text(current.name).font(.headline)
                    if day >= store.startDay(of: current), store.startDay(of: current) <= store.today() {
                        DatePicker("Day", selection: Binding(get: { day.date(calendar: store.calendar) }, set: { day = LocalDay($0, calendar: store.calendar) }),
                                   in: store.startDay(of: current).date(calendar: store.calendar)...store.today().date(calendar: store.calendar), displayedComponents: .date)
                    } else {
                        Text(day.date(calendar: store.calendar).formatted(date: .complete, time: .omitted)).foregroundStyle(.secondary)
                    }
                    DayResultRow(habit: current, day: day)
                    if !ruled.frequency.isDayBased && !ruled.frequency.isFlexible {
                        LabeledContent("Goal", value: HabitCopy.capitalized(HabitCopy.plan(ruled, weekStart: store.settings.weekStart)))
                    }
                    if ruled.kind == .duration, day == store.today(), store.timers[habit.id] != nil {
                        Button("Pause timer and save time", systemImage: "pause.fill") {
                            store.stopTimer(current, on: day)
                        }
                    }
                }
                if editable {
                    actions
                }
                DayEntriesSection(habit: ruled, day: day)
                Section("Note") {
                    if let note = store.note(of: current, on: day) { Text(note) }
                    Button(store.note(of: current, on: day) == nil ? "Add Note" : "Edit Note", systemImage: "square.and.pencil") {
                        destination = .note
                    }
                    .disabled(!editable)
                }
            }
            .navigationDestination(item: $perfEntry) { EntryEditView(habit: habit, entry: $0) }
            .analyticsScreen(.historyDay)
            .navigationTitle(NoteSheet.dayText(day, today: store.today(), calendar: store.calendar) + " · " + current.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { ToolbarItem(placement: .confirmationAction) { Button("Done") { dismiss() } } }
            .sheet(item: $destination) { destination in
                switch destination {
                case .log: LogProgressView(habit: ruled, day: day, source: .daySheet)
                case .note:
                    NoteSheet(title: "Note", subtitle: current.name + " · " + NoteSheet.dayText(day, today: store.today(), calendar: store.calendar),
                              initial: store.note(of: current, on: day) ?? "") { store.setNote($0, of: current, on: day) }
                }
            }
            .alert("Couldn't save change", isPresented: Binding(get: { store.problem != nil }, set: { if !$0 { store.problem = nil } })) {
                Button("OK") { store.problem = nil }
            } message: { Text(store.problem ?? "") }
            .onPerfCommand { action in
                switch action {
                case .closeDay: dismiss()
                case .openEntry: if destination == nil { perfEntry = store.entries(of: habit.id, on: day).last }
                case .openLog: destination = .log
                default: break
                }
            }
        }
        .presentationDetents([.large])
        .presentationBackground(Color(.systemGroupedBackground))
    }

    @ViewBuilder private var actions: some View {
        let paused = store.isPaused(current, on: day)
        let skipped = store.isSkipped(current, on: day)
        Section {
            switch ruled.kind {
            case .amount, .duration:
                Button(ruled.kind == .duration ? "Log time manually" : "Log amount manually", systemImage: "plus") { destination = .log }
                    .accessibilityIdentifier("day-add-entry")
            case .check, .task:
                Toggle("Done", isOn: Binding(get: { store.isDayMet(ruled, on: day) }, set: { store.setDayDone($0, of: current, on: day) }))
                    .disabled(paused || skipped)
                    .accessibilityIdentifier("day-done")
                if ruled.kind == .check, store.dayGoal(of: ruled) > 1 {
                    Button("Log one more", systemImage: "plus") { store.addProgress(ruled, value: 1, on: day, source: .daySheet) }
                        .disabled(paused || skipped)
                }
            case .checklist:
                ForEach(ruled.steps) { step in
                    Toggle(step.name, isOn: Binding(get: { store.isStepDone(step, of: ruled, on: day) }, set: { checked in
                        if checked != store.isStepDone(step, of: ruled, on: day) { store.toggleStep(step, of: ruled, on: day, source: .daySheet) }
                    }))
                    .disabled(paused || skipped)
                }
            case .quit:
                NavigationLink("Record a slip") { SlipEntryView(habit: current, day: day) }
                    .disabled(paused)
            }
            if skipped {
                Button("Undo skip", systemImage: "arrow.uturn.backward") { store.setSkipped(current, on: day, false) }
            } else if store.canSkip(ruled) && !paused {
                Button(day == store.today() ? "Skip today" : "Skip this day", systemImage: "forward") { store.setSkipped(current, on: day, true) }
            }
        } footer: {
            if paused { Text("This day is paused. Its entries stay in your history and don't count toward your streak.") }
            else if skipped { Text("Skipped days don't count toward your streak. Undo skip to include this day again.") }
        }
    }
}

/// Only this native value row observes progress. Changing an entry does not rebuild the Form's
/// date picker, toolbar and actions along with its independently observed entries Section.
private struct DayResultRow: View {
    let habit: Habit
    let day: LocalDay
    @Environment(HabitStore.self) private var store
    var body: some View {
        LabeledContent("Result", value: store.dayResult(habit, on: day))
            .accessibilityIdentifier("day-result")
    }
}

/// A quit slip uses its actual time, including on a past tracking day.
struct SlipEntryView: View {
    let habit: Habit
    let day: LocalDay
    var source: EntrySource = .daySheet
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var time: Date?
    var body: some View {
        let bounds = store.dayBounds(day)
        let lower = max(bounds.lowerBound, min(habit.quitSince ?? habit.createdAt, habit.createdAt))
        let upper = min(bounds.upperBound, .now)
        Form {
            if lower <= upper {
                Section {
                    Text(habit.name)
                    DatePicker("Slipped at", selection: Binding(get: { time ?? upper }, set: { time = $0 }), in: lower...upper)
                }
                Section {
                    Button("Record slip") { store.slip(habit, on: day, at: time ?? upper, source: source); dismiss() }
                } footer: { Text("You can change or remove this entry later.") }
            } else { Text("This day is before this run started.").foregroundStyle(.secondary) }
        }
        .navigationTitle("Record a Slip")
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension HabitStore {
    /// One day's result, never a weekly total labelled Today.
    func dayResult(_ habit: Habit, on day: LocalDay) -> String {
        if isPaused(habit, on: day) { return "Paused" }
        if isSkipped(habit, on: day) { return "Skipped" }
        if day < startDay(of: habit) { return "Before it started" }
        let rule = rule(habit, on: day)
        let progress = dayProgress(of: rule, on: day)
        let goal = dayGoal(of: rule)
        // A period total has no invented daily target. This row describes only the selected day;
        // the saved weekly/monthly/yearly plan is shown separately in the sheet.
        if !rule.frequency.isDayBased && !rule.frequency.isFlexible {
            switch rule.kind {
            case .amount(let unit, _): return HabitCopy.amount(progress, unit) + " logged"
            case .duration: return Format.minutes(progress) + " logged"
            case .check: return HabitCopy.amount(progress, rule.checkUnit ?? "times") + " logged"
            default: break
            }
        }
        if rule.atMost {
            if rule.kind == .duration { return "\(Format.minutes(progress)) logged · limit \(Format.minutes(goal))" }
            if case .amount(let unit, _) = rule.kind { return "\(HabitCopy.amount(progress, unit)) logged · limit \(HabitCopy.amount(goal, unit))" }
        }
        switch rule.kind {
        case .quit: return entries(of: habit.id, on: day).isEmpty ? "No slips" : "Slipped"
        case .task: return progress > 0 ? "Done" : "Not done"
        case .check where goal <= 1: return progress > 0 ? "Done" : "Not done"
        default:
            var daily = rule
            daily.frequency = .daily
            return goalLine(daily, progress: progress, goal: goal)
        }
    }
}
