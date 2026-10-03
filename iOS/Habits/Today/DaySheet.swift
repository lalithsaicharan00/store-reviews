import SwiftUI

/// One habit on one day: the sheet a habit's row opens (the user, 3 Oct 2026), the habit page's day rows open, and every
/// "fix a day" path uses. Opening it never changes anything; its controls do. One shape for every habit (report
/// "Today's Rows — Tap, Swipe, the Day Sheet and Delete"): who and which day, that day's result and its own control,
/// that day's entries, that day's actions, then the habit's. The day is shown by the same ‹ day › control as Today's
/// bottom bar, so everything in the sheet reads as that day's without a sentence saying so.
struct DaySheet: View {
    let habit: Habit
    /// Opened from Today: the sheet offers Open Habit Page (from the habit page itself it would go nowhere new).
    var pageLink = false
    @State private var day: LocalDay
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var perfEntry: Entry?
    @State private var destination: Destination?
    @State private var confirmingDelete = false
    @State private var showPlus = false
    private enum Destination: String, Identifiable { case log, add, note, edit, pause; var id: Self { self } }

    init(habit: Habit, day: LocalDay, pageLink: Bool = false) {
        self.habit = habit
        self.pageLink = pageLink
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
                    // Who: the habit's own icon, name and plan.
                    HStack(spacing: 12) {
                        HabitIcon(symbol: current.symbol, color: current.color, size: 40)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(current.name).font(.headline)
                            Text(HabitPageView.sentence(current, store: store))
                                .font(.subheadline).foregroundStyle(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    .accessibilityElement(children: .combine)
                    DayResultRow(habit: current, day: day)
                    if !ruled.frequency.isDayBased && !ruled.frequency.isFlexible {
                        LabeledContent("Goal", value: HabitCopy.capitalized(HabitCopy.plan(ruled, weekStart: store.settings.weekStart)))
                    }
                }
                if editable {
                    logSection
                }
                DayEntriesSection(habit: ruled, day: day)
                dayActions
                habitActions
            }
            // Its own id, so tests scroll this list and not Today's behind the sheet (Rulebook T9).
            .accessibilityIdentifier("day-form")
            .navigationDestination(item: $perfEntry) { EntryEditView(habit: habit, entry: $0) }
            .analyticsScreen(.historyDay)
            .navigationTitle(NoteSheet.dayText(day, today: store.today(), calendar: store.calendar) + " · " + current.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) { Button("Done") { dismiss() } }
                // Archive and Delete, the rare and lasting actions, in one menu that asks first: never a red button in
                // view (report "Today's Rows": 79 reviews say deleting is too easy, 63 couldn't find it at all).
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        if current.archived {
                            Button("Restore", systemImage: "arrow.uturn.backward") { if !store.restore(current) { showPlus = true } }
                        } else {
                            Button("Archive", systemImage: "archivebox") { store.archive([current]); dismiss() }
                        }
                        Button(current.kind == .task ? "Delete Task…" : "Delete Habit…", systemImage: "trash", role: .destructive) {
                            confirmingDelete = true
                        }
                    } label: {
                        Label("More", systemImage: "ellipsis.circle")
                    }
                    .accessibilityIdentifier("day-more")
                }
                // The day, as Today's bottom bar shows it: ‹ the date ›. Moving it changes the whole sheet.
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("Previous Day", systemImage: "chevron.left") { day = day.adding(days: -1, calendar: store.calendar) }
                        .disabled(day <= store.startDay(of: current))
                        .accessibilityIdentifier("day-previous")
                    Spacer()
                    DatePicker("Day", selection: Binding(get: { day.date(calendar: store.calendar) },
                                                         set: { day = LocalDay($0, calendar: store.calendar) }),
                               in: min(store.startDay(of: current), store.today()).date(calendar: store.calendar)...store.today().date(calendar: store.calendar),
                               displayedComponents: .date)
                        .labelsHidden()
                        .accessibilityIdentifier("day-picker")
                    Spacer()
                    Button("Next Day", systemImage: "chevron.right") { day = day.adding(days: 1, calendar: store.calendar) }
                        .disabled(day >= store.today())
                        .accessibilityIdentifier("day-next")
                }
            }
            .sheet(item: $destination) { destination in
                switch destination {
                case .log: LogProgressView(habit: ruled, day: day, source: .daySheet)
                case .add: AddEntryView(habit: current, day: day)
                case .edit: EditHabitSheet(habit: current)
                case .pause: PauseSheet(habit: current)
                case .note:
                    NoteSheet(title: "Note", subtitle: current.name + " · " + NoteSheet.dayText(day, today: store.today(), calendar: store.calendar),
                              initial: store.note(of: current, on: day) ?? "") { store.setNote($0, of: current, on: day) }
                }
            }
            .sheet(isPresented: $showPlus) { PlusView() }
            .confirmationDialog("Delete \(current.name)?", isPresented: $confirmingDelete, titleVisibility: .visible) {
                Button("Delete", role: .destructive) {
                    dismiss()
                    store.delete([current])
                }
                if !current.archived { Button("Archive Instead") { store.archive([current]); dismiss() } }
            } message: {
                Text("Its history and notes are deleted too, and this can't be undone. Archiving stops it and keeps its history.")
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

    /// The habit's own control for this day: one tap for the usual, Add Entry for anything else (same screen everywhere).
    @ViewBuilder private var logSection: some View {
        let paused = store.isPaused(current, on: day)
        let skipped = store.isSkipped(current, on: day)
        Section {
            switch ruled.kind {
            case .check, .task:
                // The day done or not: on fills it (every tick a several-a-day habit needs), off clears it.
                Toggle("Done", isOn: Binding(get: { store.isDayMet(ruled, on: day) }, set: { store.setDayDone($0, of: current, on: day) }))
                    .disabled(paused || skipped)
                    .accessibilityIdentifier("day-done")
                if store.countsUp(current, on: day) {
                    // Several times a day: each tap adds one, as the row's +1 does (Undo, named, takes one back).
                    Button("Add 1", systemImage: "plus.circle") { store.addProgress(current, value: 1, on: day, source: .daySheet) }
                        .disabled(paused || skipped)
                        .accessibilityIdentifier("day-add-one")
                }
            case .checklist:
                ForEach(ruled.steps) { step in
                    Toggle(step.name, isOn: Binding(get: { store.isStepDone(step, of: ruled, on: day) }, set: { checked in
                        if checked != store.isStepDone(step, of: ruled, on: day) { store.toggleStep(step, of: ruled, on: day, source: .daySheet) }
                    }))
                    .disabled(paused || skipped)
                }
            case .amount(let unit, _):
                if let step = ruled.quickIncrement {
                    Button("Add \(HabitCopy.amount(step, unit))", systemImage: "plus.circle") { store.increment(current, on: day, source: .daySheet) }
                        .disabled(paused || skipped)
                        .accessibilityIdentifier("day-add-step")
                }
            case .duration:
                if day == store.today() {
                    if store.timers[habit.id] != nil {
                        Button("Pause timer and save time", systemImage: "pause.fill") { store.stopTimer(current, on: day) }
                    } else {
                        Button("Start Timer", systemImage: "play.fill") { store.toggleTimer(current) }
                            .disabled(paused || skipped)
                            .accessibilityIdentifier("day-start-timer")
                    }
                }
            case .quit:
                EmptyView()
            }
            // One way to add any entry, the same for every habit (the user, 3 Oct 2026).
            if ruled.kind != .checklist && ruled.kind != .task {
                Button(ruled.kind == .quit ? "Log a Slip…" : "Add Entry", systemImage: ruled.kind == .quit ? "arrow.uturn.backward.circle" : "plus") { destination = .add }
                    .disabled(ruled.kind == .quit && paused)
                    .accessibilityIdentifier("day-add-entry")
            }
        } footer: {
            if paused { Text("This day is paused. Its entries stay in your history and don't count toward your streak.") }
            else if skipped { Text("Skipped days don't count toward your streak. Undo skip to include this day again.") }
        }
    }

    /// What belongs to this day only: skipping it, and its note.
    @ViewBuilder private var dayActions: some View {
        let paused = store.isPaused(current, on: day)
        Section(day == store.today() ? "Today" : "This Day") {
            if editable && current.kind != .quit {
                if store.isSkipped(current, on: day) {
                    Button("Undo skip", systemImage: "arrow.uturn.backward") { store.setSkipped(current, on: day, false) }
                } else if store.canSkip(ruled) && !paused {
                    Button(day == store.today() ? "Skip today" : "Skip this day", systemImage: "forward") { store.setSkipped(current, on: day, true) }
                }
            }
            if let note = store.note(of: current, on: day) { Text(note) }
            Button(store.note(of: current, on: day) == nil ? "Add Note" : "Edit Note", systemImage: "square.and.pencil") {
                destination = .note
            }
            .disabled(!editable)
        }
    }

    /// The habit itself: its page, its settings, a break from it.
    @ViewBuilder private var habitActions: some View {
        Section(current.kind == .task ? "Task" : "Habit") {
            if pageLink && current.kind != .task {
                NavigationLink {
                    HabitPageView(id: current.id)
                } label: {
                    Label("Open Habit Page", systemImage: "chart.bar.doc.horizontal")
                }
                .accessibilityIdentifier("day-open-page")
            }
            Button(current.kind == .task ? "Edit Task" : "Edit Habit", systemImage: "pencil") { destination = .edit }
                .accessibilityIdentifier("day-edit-habit")
            if current.kind != .task {
                PauseMenuItems(habit: current, showPause: Binding(get: { destination == .pause },
                                                                  set: { destination = $0 ? .pause : (destination == .pause ? nil : destination) }))
            }
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
