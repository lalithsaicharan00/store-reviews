import SwiftUI

/// Day details: one habit (or task) on one day. The sheet a row on Today opens (the user, 3 Oct 2026), the habit page's
/// day rows open, and every "fix a day" path uses. Opening it never changes anything; its controls do.
///
/// Rebuilt 4 Oct 2026 from the Day-details handoff (`Research/Research Reports/Day Structure and Organization/Day Details
/// and Entry Editor Handoff/`, Rulebook U14–U18): the toolbar names the day (⋯ menu, Close icon); the habit's identity
/// row opens its page; then that day's activity as one group (its status, the habit's own buttons, the logs that can be
/// corrected one by one); the note for the day; Skip, which turns into Undo skip in the same place. No bottom ‹ day ›
/// pager: another day opens from Today or the habit's History (U5). Native Form sections and rows throughout (U1).
struct DaySheet: View {
    let habit: Habit
    /// Opened from Today: the identity row opens the habit page (from the habit page itself it would go nowhere new).
    var pageLink = false
    let day: LocalDay
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var perfEntry: Entry?
    @State private var destination: Destination?
    @State private var confirmingDelete = false
    @State private var showPlus = false
    @State private var showPage = false
    @ScaledMetric(relativeTo: .body) private var groupGap: CGFloat = 28
    @ScaledMetric(relativeTo: .body) private var noteToSkip: CGFloat = 24
    private enum Destination: String, Identifiable { case log, add, note, edit, pause; var id: Self { self } }

    init(habit: Habit, day: LocalDay, pageLink: Bool = false) {
        self.habit = habit
        self.pageLink = pageLink
        self.day = day
    }

    private var current: Habit { store.habits.first { $0.id == habit.id } ?? habit }
    private var ruled: Habit { store.rule(current, on: day) }
    private var editable: Bool { day <= store.today() && day >= store.startDay(of: current) }
    private var isTask: Bool { current.kind == .task }

    var body: some View {
        let _ = perfTimed("Count: the Day sheet drawn") { () }
        let today = store.today()
        NavigationStack {
            Form {
                identity
                    .listSectionSpacing(groupGap)
                DayActivity(habit: current, day: day, editable: editable, groupGap: groupGap,
                            logManually: { destination = .add }, resume: { store.resume(current) })
                noteSection
                    .listSectionSpacing(noteToSkip)
                if isTask {
                    taskSection
                } else if editable && current.kind != .quit {
                    skipSection
                }
            }
            // Its own id, so tests scroll this list and not Today's behind the sheet (Rulebook T9).
            .accessibilityIdentifier("day-form")
            .navigationDestination(item: $perfEntry) { EntryEditView(habit: ruled, entry: $0) }
            .navigationDestination(isPresented: $showPage) { HabitPageView(id: current.id) }
            .analyticsScreen(.historyDay)
            // The day, never the habit's name again: the identity row says whose day it is (U18; handoff).
            .navigationTitle(NoteSheet.dayText(day, today: today, calendar: store.calendar))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Edit, Pause, Archive and Delete in one menu, the lasting ones last; Delete asks first and offers
                // Archive (U14: 79 reviews say deleting is too easy, 63 couldn't find it at all).
                ToolbarItem(placement: .topBarLeading) { managementMenu }
                // The sheet saves as it goes (nothing to confirm): the standard Close symbol, named "Close" (U18).
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close", systemImage: "xmark") { dismiss() }
                        .accessibilityIdentifier("day-close")
                }
            }
            .sheet(item: $destination) { destination in
                switch destination {
                case .log: LogProgressView(habit: ruled, day: day, source: .daySheet)
                case .add: AddEntryView(habit: current, day: day)
                case .edit: EditHabitSheet(habit: current)
                case .pause: PauseSheet(habit: current)
                case .note:
                    NoteSheet(title: "Note", subtitle: current.name + " · " + NoteSheet.dayText(day, today: today, calendar: store.calendar),
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
                Button("Cancel", role: .cancel) {}
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

    // MARK: Identity

    /// Who: the habit's icon, name and plan, once. From Today the whole row opens the habit page (a task has none).
    @ViewBuilder private var identity: some View {
        Section {
            if pageLink && !isTask {
                NavigationLink { HabitPageView(id: current.id) } label: { DayIdentityRow(habit: current) }
                    .accessibilityHint("Opens the habit page")
                    .accessibilityIdentifier("day-open-page")
            } else {
                DayIdentityRow(habit: current)
            }
        }
    }

    // MARK: Note and Skip

    /// The note for this day: its text, or an invitation. A tap opens the note editor; nothing is typed here, and
    /// nothing ever asks for a note (handoff; report "Habit Notes and Day Notes").
    private var noteSection: some View {
        let note = store.note(of: current, on: day)
        return Section {
            Button { destination = .note } label: {
                Text(note ?? "Add a note…")
                    .foregroundStyle(note == nil ? Color.secondary : Color.primary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(8)
                    .frame(maxWidth: .infinity, minHeight: 32, alignment: .leading)
                    .contentShape(Rectangle())
            }
            .disabled(!editable)
            .accessibilityLabel(note.map { "Note for this day: " + $0 } ?? "Add a note for this day")
            .accessibilityIdentifier(note == nil ? "day-add-note" : "day-edit-note")
        } header: {
            Text("Note for this day")
        }
    }

    /// Skip changes only this day; the same button, in the same place, takes it back (U15). Logs and the note stay.
    @ViewBuilder private var skipSection: some View {
        let skipped = store.isSkipped(current, on: day)
        if skipped || (store.canSkip(ruled) && !store.isPaused(current, on: day)) {
            Section {
                DayButton(skipped ? "Undo skip" : (day == store.today() ? "Skip today" : "Skip this day"), id: "day-skip") {
                    store.setSkipped(current, on: day, !skipped)
                }
                .dayButtonRow()
            }
        }
    }

    /// A one-time task's own date and the most common change to it, one tap away (the user, 3 Oct 2026). A task has no
    /// Skip and no logs.
    @ViewBuilder private var taskSection: some View {
        if let due = current.dueDay {
            Section {
                if store.isDone(current, on: day) {
                    LabeledContent("Planned for", value: due.date(calendar: store.calendar).formatted(date: .abbreviated, time: .omitted))
                } else {
                    let today = store.today()
                    DatePicker("Date", selection: Binding(get: { due.date(calendar: store.calendar) },
                                                          set: { moveTask(to: LocalDay($0, calendar: store.calendar)) }),
                               in: today.date(calendar: store.calendar)..., displayedComponents: .date)
                        .accessibilityIdentifier("day-task-date")
                    Button("Do Tomorrow", systemImage: "arrow.turn.up.right") {
                        moveTask(to: today.adding(days: 1, calendar: store.calendar))
                        dismiss()
                    }
                    .accessibilityIdentifier("day-do-tomorrow")
                }
            }
        }
    }

    /// Moves a one-time task to another day. Only the task's date changes; its entries and day notes stay where they are.
    private func moveTask(to newDay: LocalDay) {
        guard var task = store.habits.first(where: { $0.id == habit.id }), task.dueDay != newDay else { return }
        task.dueDay = newDay
        store.update(task)
    }

    // MARK: Management

    /// The habit itself, in the order people need it: view, edit, pause; then archive and delete, last and apart.
    private var managementMenu: some View {
        Menu {
            Section {
                if pageLink && !isTask {
                    Button("View Habit", systemImage: "chart.bar.doc.horizontal") { showPage = true }
                }
                Button(isTask ? "Edit Task" : "Edit Habit", systemImage: "pencil") { destination = .edit }
                    .accessibilityIdentifier("day-edit-habit")
                if !isTask {
                    PauseMenuItems(habit: current, showPause: Binding(get: { destination == .pause },
                                                                      set: { destination = $0 ? .pause : (destination == .pause ? nil : destination) }))
                }
            }
            Section {
                if current.archived {
                    Button("Restore", systemImage: "arrow.uturn.backward") { if !store.restore(current) { showPlus = true } }
                } else {
                    Button("Archive", systemImage: "archivebox") { store.archive([current]); dismiss() }
                }
                Button(isTask ? "Delete Task…" : "Delete Habit…", systemImage: "trash", role: .destructive) {
                    confirmingDelete = true
                }
            }
        } label: {
            Label(isTask ? "Task actions" : "Habit actions", systemImage: "ellipsis")
        }
        .accessibilityIdentifier("day-more")
    }
}

// MARK: - Pieces shared with the log editor

/// Icon, name and plan: "8 glasses a day · Anytime", "Quitting since 19 Sep 2026", "Task · Planned for Sat, 4 Oct".
struct DayIdentityRow: View {
    let habit: Habit
    @Environment(HabitStore.self) private var store

    var body: some View {
        HStack(spacing: 12) {
            HabitIcon(symbol: habit.symbol, color: habit.color, size: 40)
            VStack(alignment: .leading, spacing: 2) {
                Text(habit.name).font(.headline)
                Text(Self.plan(habit, store: store))
                    .font(.subheadline).foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.vertical, 2)
        .accessibilityElement(children: .combine)
    }

    static func plan(_ habit: Habit, store: HabitStore) -> String {
        switch habit.kind {
        case .quit:
            return HabitPageView.sentence(habit, store: store)
        case .task:
            guard let due = habit.dueDay else { return "Task" }
            return "Task · Planned for " + PauseSheet.short(due, calendar: store.calendar)
        default:
            let parts = habit.parts == [.anytime] ? "Anytime"
                : HabitCopy.capitalized(HabitCopy.partsPhrase(habit.parts.map { store.section($0).name }))
            return HabitCopy.capitalized(HabitCopy.plan(habit, weekStart: store.settings.weekStart)) + " · " + parts
        }
    }
}

/// A full-width button of native size (U16): prominent for the step a positive goal asks for (Mark done, Add 1 glass,
/// Start timer), bordered for everything else (manual logging, a limit, a slip, Skip). Ink on the prominent one, with
/// its own text colour, so it reads in both appearances (U2; History's unreadable Add Entry, checklist item 26).
struct DayButton: View {
    let title: String
    var prominent = false
    var id: String? = nil
    let action: () -> Void

    init(_ title: String, prominent: Bool = false, id: String? = nil, action: @escaping () -> Void) {
        self.title = title
        self.prominent = prominent
        self.id = id
        self.action = action
    }

    var body: some View {
        if prominent {
            Button(action: action) {
                Text(title).fontWeight(.semibold).foregroundStyle(Color.onInk).frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.ink)
            .controlSize(.large)
            .accessibilityIdentifier(id ?? title)
        } else {
            Button(action: action) {
                Text(title).fontWeight(.semibold).frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .tint(.ink)
            .controlSize(.large)
            .accessibilityIdentifier(id ?? title)
        }
    }
}

extension View {
    /// A section that holds full-width buttons rather than rows: no card behind them, aligned with the cards around.
    func dayButtonRow() -> some View {
        listRowInsets(EdgeInsets()).listRowBackground(Color.clear)
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
