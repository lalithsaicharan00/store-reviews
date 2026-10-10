import SwiftUI

/// One habit's own page (the user, 3 Oct 2026; research "Habit Details Research"; checklist "Habit Details Page — Build").
/// A small header (icon, name, the goal in words), then three jobs on a segmented control pinned under the navigation
/// bar: **History** (find a day, fix an exact entry), **Notes** (the habit's dated notes) and **Progress** (the record,
/// milestones, week, month and year). Editing the habit, pausing, archiving and deleting are in the ⋯ menu. It's never
/// the way to check off: a tap on Today's row keeps logging.
struct HabitPageView: View {
    let id: UUID
    /// Opened from Progress: the Progress tab, on Progress's range and period (research IA: keep the link's intent).
    var overTime: OverTimeStart? = nil
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var tab: HabitTab
    @State private var model = HabitPageModel()
    /// This visit's "What the squares mean" (`HeatKeyVisit`): History and Progress share it.
    @State private var heatVisit = HeatKeyVisit()
    /// False once the page is popped. All Habits pushes it from a link inside its list, and SwiftUI kept the page's
    /// state for the next push, so the next visit reused this one's key (HabitPageUITests, 5 Oct 2026).
    @Environment(\.isPresented) private var isPresented
    @State private var showEdit = false
    @State private var showPause = false
    /// An archived habit brought back past the free limit: the 6th-habit sheet first (Current Work 80).
    @State private var restoring: Habit?
    @State private var showGoTo = false
    @State private var confirmingDelete = false
    @State private var openDay: LocalDay?
    @State private var addEntryDay: LocalDay?
    /// The All milestones page, pushed from Milestones' "See all": held here, not by the card, so it stays while the
    /// Progress tab redraws under it (U27).
    @State private var showMilestones = false

    init(id: UUID, overTime: OverTimeStart? = nil) {
        self.id = id
        self.overTime = overTime
        _tab = State(initialValue: overTime == nil ? .history : .progress)
    }

    var body: some View {
        if let habit = store.habits.first(where: { $0.id == id }) {
            page(habit)
        } else {
            ContentUnavailableView("Habit Deleted", systemImage: "trash")
        }
    }

    private func page(_ habit: Habit) -> some View {
        let today = store.today()
        let key = HabitPageModel.Key(habit: habit, version: store.dataVersion, today: today)
        let tabs = HabitTab.tabs(for: habit)
        return ScrollViewReader { proxy in ScrollView {
            LazyVStack(alignment: .leading, spacing: 0, pinnedViews: [.sectionHeaders]) {
                header(habit, today: today)
                    .padding(.horizontal, WeekSpacing.card)
                    .padding(.top, WeekSpacing.tight)
                    .padding(.bottom, WeekSpacing.card)
                Section {
                    switch tabs.contains(tab) ? tab : .history {
                    case .history:
                        HabitHistoryTab(habit: habit, months: model.history,
                                        open: { openDay = $0 }, addEntry: { addEntryDay = today }, goToDate: { showGoTo = true })
                    case .notes:
                        HabitNotesTab(habit: habit, months: model.notes)
                    case .progress:
                        HabitProgressTab(habit: habit, model: model, start: overTime, openDay: { openDay = $0 },
                                         openMilestones: { showMilestones = true })
                    }
                } header: {
                    tabBar(tabs)
                }
            }
            .padding(.bottom, WeekSpacing.section)
        }
        .onPerfCommand { action in
            // Speed runs: the Milestones card at the top, so its shelf can be scrolled sideways.
            if action == .showMilestones { withAnimation(nil) { proxy.scrollTo(Self.milestonesCard, anchor: .top) } }
        }
        }
        .background(Color(.systemGroupedBackground))
        .environment(heatVisit)
        .onChange(of: isPresented) { if !isPresented { heatVisit = HeatKeyVisit() } }
        .onAppear { model.load(key, tab: tab, store: store) }
        .onChange(of: key) { model.load(key, tab: tab, store: store) }
        .onChange(of: tab) { model.load(key, tab: tab, store: store) }
        .navigationDestination(isPresented: $showMilestones) { AllMilestonesPage(model: model, color: habit.color) }
        .analyticsScreen(.habitDetail)
        .navigationTitle(habit.name.capped(HabitRow.nameShown))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) { menu(habit, today: today) }
        }
        .sheet(item: $openDay) { DaySheet(habit: habit, day: $0) }
        .sheet(item: $addEntryDay) { AddLogView(habit: habit, day: $0, source: .manual) }
        .sheet(isPresented: $showGoTo) {
            GoToDateSheet(habit: habit) { day in
                showGoTo = false
                // After the picker's sheet has gone: one sheet at a time.
                Task { @MainActor in
                    try? await Task.sleep(for: .milliseconds(350))
                    openDay = day
                }
            }
        }
        .onPerfCommand { action in
            switch action {
            case .openDay(let day): openDay = day
            case .openEdit: showEdit = true
            case .closeDay: openDay = nil; showEdit = false; showMilestones = false
            case .openMilestones: showMilestones = true
            case .habitTab(let index): if index < tabs.count { tab = tabs[index] }
            default: break
            }
        }
        .sheet(isPresented: $showEdit) { EditHabitSheet(habit: habit) }
        .sheet(isPresented: $showPause) { PauseSheet(habit: habit) }
        .restoringPastTheLimit($restoring)
        .confirmationDialog("Delete \(habit.name)?", isPresented: $confirmingDelete, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                dismiss()
                store.delete([habit])
            }
            if !habit.archived { Button("Archive Instead") { store.archive([habit]) } }
        } message: {
            Text("Its history and notes are deleted too, and this can't be undone. Archiving stops it and keeps its history.")
        }
    }

    /// The Milestones card's id on the page, for the speed runs' `showMilestones`.
    static let milestonesCard = "habit-milestones-card"

    // MARK: Header

    /// What the habit is, in a glance: its icon, name and goal in words, and a paused banner while paused. No numbers:
    /// they belong to Progress (research IA).
    @ViewBuilder private func header(_ habit: Habit, today: LocalDay) -> some View {
        VStack(alignment: .leading, spacing: WeekSpacing.card) {
            HStack(alignment: .center, spacing: 12) {
                HabitIcon(symbol: habit.symbol, color: habit.color, size: 48)
                VStack(alignment: .leading, spacing: WeekSpacing.label) {
                    Text(habit.name).font(.title2.weight(.bold)).lineLimit(2)
                    Text(Self.sentence(habit, store: store)).font(.subheadline).foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            if let description = store.description(of: habit) {
                Text(description).font(.callout).fixedSize(horizontal: false, vertical: true)
            }
            if let pause = store.pause(of: habit, on: today), pause.contains(today) {
                HStack(spacing: WeekSpacing.tight) {
                    Label(Self.pausedText(pause, store: store), systemImage: "pause.circle")
                        .font(.subheadline)
                    Spacer(minLength: WeekSpacing.tight)
                    Button("Resume") { store.resume(habit) }
                        .buttonStyle(.bordered)
                        .controlSize(.small)
                }
                .padding(12)
                .background(Color.card, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
        }
        .accessibilityElement(children: .contain)
    }

    /// History · Notes · Progress, pinned under the navigation bar while the page scrolls (as Progress's dates bar).
    private func tabBar(_ tabs: [HabitTab]) -> some View {
        Picker("Section", selection: $tab) {
            ForEach(tabs) { Text($0.title).tag($0) }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, WeekSpacing.card)
        .padding(.vertical, WeekSpacing.tight)
        .frame(maxWidth: .infinity)
        // Opaque, the page's own colour: cards slide under it cleanly.
        .background(Color(.systemGroupedBackground))
        .padding(.bottom, WeekSpacing.tight)
        .accessibilityIdentifier("habit-tabs")
    }

    // MARK: The ⋯ menu

    /// Editing the habit, pausing, archiving and deleting (research IA: management in the top-right menu; HIG: less
    /// frequent actions in a menu). Entries are edited in History, notes with the note.
    private func menu(_ habit: Habit, today: LocalDay) -> some View {
        let pause = store.pause(of: habit, on: today)
        return Menu {
            Button(habit.kind == .task ? "Edit Task" : "Edit Habit", systemImage: "pencil") { showEdit = true }
            if store.canPause(habit) || pause != nil {
                if let pause {
                    if pause.contains(today) {
                        Button("Resume", systemImage: "play.circle") { store.resume(habit) }
                    } else {
                        Button("Cancel Pause from \(PauseSheet.short(pause.from, calendar: store.calendar))", systemImage: "xmark.circle") {
                            store.resume(habit)
                        }
                    }
                } else {
                    Button("Pause…", systemImage: "pause.circle") { showPause = true }
                }
            }
            if habit.archived {
                Button("Restore", systemImage: "arrow.uturn.backward") { if !store.restore(habit) { restoring = habit } }
            } else {
                Button("Archive", systemImage: "archivebox") { store.archive([habit]) }
            }
            Divider()
            Button("Delete", systemImage: "trash", role: .destructive) { confirmingDelete = true }
        } label: {
            Image(systemName: "ellipsis.circle")
                .accessibilityLabel("More")
        }
        .accessibilityIdentifier("habit-menu")
    }

    // MARK: Words shared with All Habits

    /// The habit in one sentence, with its parts of the day: "Water 8 glasses a day, morning".
    static func sentence(_ habit: Habit, store: HabitStore) -> String {
        if habit.kind == .quit {
            let since = (habit.quitSince ?? habit.createdAt).formatted(.dateTime.day().month(.abbreviated).year())
            return "Quitting since \(since)"
        }
        if habit.kind == .task, let due = habit.dueDay {
            return "\(habit.name) on \(PauseSheet.short(due, calendar: store.calendar))"
        }
        let parts = habit.parts == [.anytime] ? "anytime" : HabitCopy.partsPhrase(habit.parts.map { store.section($0).name })
        return HabitCopy.sentence(habit, weekStart: store.settings.weekStart) + ", " + parts
    }

    /// The short line under a name in All Habits.
    static func summary(_ habit: Habit, store: HabitStore) -> String {
        if habit.archived { return "Archived" }
        let today = store.today()
        if let pause = store.pause(of: habit, on: today), pause.contains(today) { return pausedText(pause, store: store) }
        if habit.kind == .quit { return "Best run \(Format.days(store.quitRuns(of: habit).best))" }
        if habit.kind == .task, store.isDone(habit, on: today) { return habit.dueDay == nil ? "Done today" : "Completed" }
        if habit.kind == .task, let due = habit.dueDay { return "Planned for \(PauseSheet.short(due, calendar: store.calendar))" }
        return HabitCopy.capitalized(HabitCopy.plan(habit, weekStart: store.settings.weekStart, short: true))
    }

    static func pausedText(_ pause: HabitPause, store: HabitStore) -> String {
        guard let last = pause.through else { return "Paused until you turn it back on" }
        return "Paused · back " + PauseSheet.short(last.adding(days: 1, calendar: store.calendar), calendar: store.calendar)
    }

    static func firstOfMonth(_ day: LocalDay, _ calendar: Calendar) -> LocalDay {
        LocalDay(year: day.year, month: day.month, day: 1)
    }
}
