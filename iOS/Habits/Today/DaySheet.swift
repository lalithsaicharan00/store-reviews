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
    @Environment(\.dynamicTypeSize) private var typeSize
    @State private var perfEntry: Entry?
    /// All logs, pushed from "All N logs" (and by the speed runs).
    @State private var perfAllLogs = false
    @State private var perfNote = false
    @State private var destination: Destination?
    @State private var confirmingDelete = false
    @State private var showPlus = false
    @State private var showPage = false
    /// The days Another day… offers, worked out when it's tapped.
    @State private var pickingDays: ClosedRange<LocalDay>?
    /// The sheet's full height, read when it changes: the gaps and the note's lines follow it (design decisions §3).
    @State private var height: CGFloat = 0
    private enum Destination: String, Identifiable { case add, note, edit, pause; var id: Self { self } }

    init(habit: Habit, day: LocalDay, pageLink: Bool = false) {
        self.habit = habit
        self.pageLink = pageLink
        self.day = day
    }

    private var current: Habit { store.habits.first { $0.id == habit.id } ?? habit }
    private var ruled: Habit { store.rule(current, on: day) }
    private var editable: Bool { day <= store.today() && day >= store.startDay(of: current) }
    private var isTask: Bool { current.kind == .task }
    /// The identity row's trim on the iPhone SE (`DaySpacing.trim`).
    private var identityTrim: CGFloat { height > 0 && DaySpacing.make(height: height, typeSize: typeSize).trim > 0 ? 4 : 0 }

    var body: some View {
        let _ = perfTimed("Count: the Day sheet drawn") { () }
        let today = store.today()
        let spacing = height > 0 ? DaySpacing.make(height: height, typeSize: typeSize) : DaySpacing()
        NavigationStack {
            Form {
                identity
                    .listSectionSpacing(spacing.gap(24, 32))
                DayActivity(habit: current, day: day, editable: editable, spacing: spacing,
                            logManually: { destination = .add }, resume: { store.resume(current) },
                            addNote: { destination = .note }, openAllLogs: { perfAllLogs = true })
                if isTask {
                    taskSection
                } else if editable && current.kind != .quit {
                    skipSection
                }
            }
            .contentMargins(.top, spacing.gap(14, 18), for: .scrollContent)
            // Rows and the gap above the first card as designed (44 pt rows; 14–18 above the habit): the Form's own
            // defaults (52-pt rows, a 35-pt first gap) pushed Skip today off the iPhone SE (7 Oct 2026).
            .environment(\.defaultMinListRowHeight, 44)
            .environment(\.defaultMinListHeaderHeight, spacing.gap(14, 18))
            // The gap above the first card follows the container's section spacing; each section sets its own after.
            .listSectionSpacing(.compact)
            // Its own id, so tests scroll this list and not Today's behind the sheet (Rulebook T9).
            .accessibilityIdentifier("day-form")
            .onGeometryChange(for: CGFloat.self) { proxy in proxy.size.height.rounded() } action: { _ in
                // Read the window's height when the sheet's size changes (a rotation, a new sheet), never per row.
                let window = ScreenRoom.windowHeight()
                if abs(window - height) >= 1 { height = window }
            }
            .navigationDestination(item: $perfEntry) { LogRecordView(habit: ruled, entry: $0) }
            .navigationDestination(isPresented: $perfAllLogs) { AllLogsView(habit: current, day: day) }
            .navigationDestination(isPresented: $perfNote) { NoteView(habit: current, day: day) }
            .navigationDestination(isPresented: $showPage) { HabitPageView(id: current.id) }
            .analyticsScreen(.historyDay)
            // The day, never the habit's name again: the identity row says whose day it is. "Today" only when it is
            // today (U21): a date opened from History is titled by that date.
            .navigationTitle(DayWords.day(day, today: today, calendar: store.calendar))
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
                case .add: AddLogView(habit: current, day: day, source: .manual)
                case .edit: EditHabitSheet(habit: current)
                case .pause: PauseSheet(habit: current)
                case .note: AddNoteView(habit: current, day: day, picksDay: false)
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
                case .openEntry: if destination == nil { perfEntry = store.dayLogs(of: habit, on: day).first { $0.opensRecord(for: ruled) } }
                case .openLog: destination = .add
                case .openAllLogs: perfAllLogs = true
                case .openNote:
                    if store.note(of: current, on: day) == nil { destination = .note } else { perfNote = true }
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
                NavigationLink { HabitPageView(id: current.id) } label: { DayIdentityRow(habit: current, trim: identityTrim) }
                    .accessibilityHint("Opens the habit page")
                    .accessibilityIdentifier("day-open-page")
            } else {
                DayIdentityRow(habit: current, trim: identityTrim)
            }
        }
    }

    // MARK: Skip

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

    /// Reschedule: Do Tomorrow and Another Day… (the user, 4 Oct 2026). No date row: the line under the task's name
    /// already says when it's planned. A repeating task moves only today's occurrence, and only to a day before its
    /// next one; the calendar offers just those days. A done task, or a daily one, has nothing to move. No Skip.
    @ViewBuilder private var taskSection: some View {
        if store.canReschedule(current, shownOn: day) {
            Section("Reschedule") {
                Button("Do tomorrow", systemImage: "arrow.turn.up.right") {
                    reschedule(to: store.today().adding(days: 1, calendar: store.calendar))
                }
                .accessibilityIdentifier("day-do-tomorrow")
                Button("Another day…", systemImage: "calendar") {
                    pickingDays = store.rescheduleRange(of: current, shownOn: day)
                }
                .accessibilityIdentifier("day-another-day")
                .sheet(isPresented: Binding(get: { pickingDays != nil }, set: { if !$0 { pickingDays = nil } })) {
                    if let range = pickingDays {
                        RescheduleSheet(range: range, current: current.dueDay ?? day) { reschedule(to: $0) }
                    }
                }
            }
        }
    }

    /// Moves the task, then closes the sheet: it has left the day shown. A one-time task changes its date; a repeating
    /// one moves only this occurrence. Its logs and day notes stay where they are.
    private func reschedule(to newDay: LocalDay) {
        if current.dueDay != nil {
            guard var task = store.habits.first(where: { $0.id == habit.id }), task.dueDay != newDay else { return }
            task.dueDay = newDay
            store.update(task)
        } else {
            store.moveOccurrence(current, from: day, to: newDay)
        }
        dismiss()
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

/// Another Day…: the system calendar showing only the days the task can move to (no message about the others).
private struct RescheduleSheet: View {
    let range: ClosedRange<LocalDay>
    /// The day the task is on now: Move stays off until another day is picked.
    let current: LocalDay
    let onMove: (LocalDay) -> Void
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var picked: Date?

    var body: some View {
        let c = store.calendar
        let first = range.lowerBound.date(calendar: c)
        let selection = picked ?? first
        NavigationStack {
            VStack(spacing: 0) {
                DatePicker("Day", selection: Binding(get: { selection }, set: { picked = $0 }),
                           in: first...range.upperBound.date(calendar: c), displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .labelsHidden()
                    .padding(.horizontal)
                    .accessibilityIdentifier("reschedule-calendar")
                Spacer(minLength: 0)
            }
                .navigationTitle("Another Day")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } }
                    ToolbarItem(placement: .confirmationAction) {
                        let day = LocalDay(selection, calendar: c)
                        // Moving closes Day details too, and this sheet with it.
                        Button("Move") { onMove(day) }
                            .fontWeight(.semibold)
                            .disabled(day == current)
                            .accessibilityIdentifier("reschedule-move")
                    }
                }
        }
        .presentationDetents([.medium, .large])
    }
}

// MARK: - Pieces shared with the log editor

/// Icon, name and plan: "8 glasses a day · Anytime", "Quitting since 19 Sep 2026", "Task · Planned for Sat, 4 Oct".
struct DayIdentityRow: View {
    let habit: Habit
    /// Points taken off the row's own insets above and below (the iPhone SE, `DaySpacing.trim`).
    var trim: CGFloat = 0
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
        .padding(.vertical, 2 - trim)
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("day-identity")
    }

    static func plan(_ habit: Habit, store: HabitStore) -> String {
        switch habit.kind {
        case .quit:
            return HabitPageView.sentence(habit, store: store)
        case .task:
            guard let due = habit.dueDay else {
                // A repeating task says how often: "Task · Every Monday".
                return "Task · " + HabitCopy.capitalized(HabitCopy.plan(habit, weekStart: store.settings.weekStart))
            }
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
