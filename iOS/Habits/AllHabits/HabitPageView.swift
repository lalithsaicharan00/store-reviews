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
    @State private var showNotesSearch = false
    /// The day Notes search chose, opened once that page has gone (one sheet at a time).
    @State private var pendingDay: LocalDay?
    @State private var confirmingDelete = false
    @State private var openDay: LocalDay?
    /// The All milestones page, pushed from Milestones' "See all": held here, not by the card, so it stays while the
    /// Progress tab redraws under it (U27).
    @State private var showMilestones = false
    /// The name moves into the bar once the header has scrolled under it (Figma's Scrolled state), as a large title does.
    @State private var headerGone = false

    /// `milestones` opens it on its Progress tab with All Milestones pushed on top (the milestone pop-up's button).
    init(id: UUID, overTime: OverTimeStart? = nil, milestones: Bool = false) {
        self.id = id
        self.overTime = overTime
        _tab = State(initialValue: .progress)
        _showMilestones = State(initialValue: milestones)
    }

    var body: some View {
        if let habit = store.habits.first(where: { $0.id == id }) {
            // A task has no Progress, only its days (Figma's Task details).
            if habit.kind == .task { TaskPageView(task: habit) } else { page(habit) }
        } else {
            ContentUnavailableView("Habit Deleted", systemImage: "trash")
        }
    }

    private func openPendingDay() {
        if let day = pendingDay { pendingDay = nil; openDay = day }
    }

    private func page(_ habit: Habit) -> some View {
        let today = store.today()
        let key = HabitPageModel.Key(habit: habit, version: store.dataVersion, today: today)
        let tabs = HabitTab.tabs(for: habit)
        return ScrollViewReader { proxy in ScrollView {
            LazyVStack(alignment: .leading, spacing: 0, pinnedViews: [.sectionHeaders]) {
                header(habit, today: today)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                Section {
                    switch tabs.contains(tab) ? tab : .history {
                    case .history:
                        HabitHistoryTab(habit: habit, months: model.historyIsEmpty ? [] : model.history, noteMonths: model.noteHistory,
                                        open: { openDay = $0 },
                                        scrollTo: { month, day in
                                            // The month's card first, which the lazy stack may not have made yet, then its row.
                                            // The newest month is always made, and its jump would show.
                                            if let month { proxy.scrollTo(month, anchor: .top) }
                                            Task { @MainActor in
                                                // A turn wasn't enough for the card's rows to be laid out (seen on the Simulator).
                                                try? await Task.sleep(for: .milliseconds(60))
                                                withAnimation(.smooth(duration: 0.35)) { proxy.scrollTo(day, anchor: .center) }
                                            }
                                        },
                                        searchNotes: { showNotesSearch = true },
                                        restore: habit.archived ? { if !store.restore(habit) { restoring = habit } } : nil)
                    case .progress:
                        HabitProgressTab(habit: habit, model: model, start: overTime, openDay: { openDay = $0 },
                                         openMilestones: { showMilestones = true })
                    }
                } header: {
                    tabBar(tabs)
                }
            }
            // Room at the end for History's Add, so it never covers the last row.
            .padding(.bottom, tab == .history ? 80 : WeekSpacing.section)
        }
        .onScrollGeometryChange(for: Bool.self) { $0.contentOffset.y + $0.contentInsets.top > Self.headerHeight } action: { _, gone in
            withAnimation(.easeOut(duration: 0.15)) { headerGone = gone }
        }
        .onPerfCommand { action in
            // Speed runs: the Milestones card at the top, so its shelf can be scrolled sideways.
            if action == .showMilestones { withAnimation(nil) { proxy.scrollTo(Self.milestonesCard, anchor: .top) } }
        }
        }
        .pinnedTabsEdge()
        .background(Color(.systemGroupedBackground))
        // History's Add floats over the page at the bottom right (Figma), in reach of the thumb.
        .overlay(alignment: .bottomTrailing) {
            // Archived: nothing can be logged, so no Add (Figma's History · archived).
            if tabs.contains(.history) && (tab == .history || !tabs.contains(tab)) && !habit.archived {
                HistoryAddButton(habit: habit) { openDay = $0 }
                    .padding(.trailing, 16)
                    .padding(.bottom, 8)
            }
        }
        .environment(heatVisit)
        .onChange(of: isPresented) { if !isPresented { heatVisit = HeatKeyVisit() } }
        .onAppear { model.load(key, tab: tab, store: store) }
        .onChange(of: key) { model.load(key, tab: tab, store: store) }
        .onChange(of: tab) { model.load(key, tab: tab, store: store) }
        .navigationDestination(isPresented: $showMilestones) { AllMilestonesPage(model: model, name: habit.name, color: habit.color, quitting: habit.kind == .quit) }
        .analyticsScreen(.habitDetail)
        .navigationTitle(habit.name.capped(HabitRow.nameShown))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // No title while the header shows the name; it moves into the bar once the header has gone.
            ToolbarItem(placement: .principal) {
                Text(habit.name.capped(HabitRow.nameShown))
                    .font(.headline)
                    .lineLimit(1)
                    .opacity(headerGone ? 1 : 0)
                    .accessibilityHidden(!headerGone)
            }
            ToolbarItem(placement: .topBarTrailing) { menu(habit, today: today) }
        }
        .sheet(item: $openDay) { DaySheet(habit: habit, day: $0) }
        .fullScreenCover(isPresented: $showNotesSearch, onDismiss: openPendingDay) {
            NotesSearchPage(habit: habit, months: model.noteHistory) { pendingDay = $0 }
        }
        .onPerfCommand { action in
            switch action {
            case .openDay(let day): openDay = day
            case .openEdit: showEdit = true
            case .closeDay: openDay = nil; showEdit = false; showMilestones = false
            case .openMilestones: showMilestones = true
            case .openNotesSearch: showNotesSearch = true
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
        } message: {
            // Cancel and Delete only (D9); Archive is the row above Delete in the ⋯ menu.
            Text("Its history and notes are deleted too, and this can't be undone. Archiving stops it and keeps its history.")
        }
    }

    /// The Milestones card's id on the page, for the speed runs' `showMilestones`.
    static let milestonesCard = "habit-milestones-card"

    // MARK: Header

    /// The header's height, past which the name moves into the bar: the 56 icon (Figma's large title).
    static let headerHeight: CGFloat = 56

    /// What the habit is, in a glance: its icon, name and plan with its routine ("8 glasses a day | Anytime"), and a
    /// paused banner while paused. No numbers: they belong to Progress.
    @ViewBuilder private func header(_ habit: Habit, today: LocalDay) -> some View {
        VStack(alignment: .leading, spacing: WeekSpacing.card) {
            HStack(alignment: .center, spacing: 16) {
                HabitIcon(symbol: habit.symbol, color: habit.color, size: 56)
                VStack(alignment: .leading, spacing: 0) {
                    Text(habit.name).font(.title2.weight(.bold)).lineLimit(2)
                        .accessibilityAddTraits(.isHeader)
                    Text(Self.planLine(habit, store: store)).font(.subheadline).foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            if let description = store.description(of: habit) {
                HabitDescription(text: description)
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

    /// Under the name: how much and how often, then the habit's routine. "8 glasses a day | Anytime".
    static func planLine(_ habit: Habit, store: HabitStore) -> String {
        if habit.kind == .quit || habit.kind == .task { return sentence(habit, store: store) }
        let plan = HabitCopy.capitalized(HabitCopy.plan(habit, weekStart: store.settings.weekStart))
        guard let part = habit.parts.first else { return plan }
        return plan + " | " + store.section(part).name
    }

    /// Progress | History, pinned under the navigation bar while the page scrolls. A task has one tab, so none.
    @ViewBuilder private func tabBar(_ tabs: [HabitTab]) -> some View {
        if tabs.count > 1 { segmented(tabs) }
    }

    private func segmented(_ tabs: [HabitTab]) -> some View {
        Picker("Section", selection: $tab) {
            ForEach(tabs) { Text($0.title).tag($0) }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        // Opaque, the page's own colour: cards slide under it cleanly.
        .background(Color(.systemGroupedBackground))
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
            Image(systemName: "ellipsis")
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

    static func pausedText(_ pause: HabitPause, store: HabitStore) -> String { DayWords.paused(pause, calendar: store.calendar) }

    static func firstOfMonth(_ day: LocalDay, _ calendar: Calendar) -> LocalDay {
        LocalDay(year: day.year, month: day.month, day: 1)
    }
}

/// The habit's description under its name (Figma's With description and Description open): two lines, then More,
/// which shows the whole text and turns into Less. More shows only when the text runs past two lines.
private struct HabitDescription: View {
    let text: String
    @State private var open = false
    @State private var fullHeight: CGFloat = 0
    @State private var shortHeight: CGFloat = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(text)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(open ? nil : 2)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .onGeometryChange(for: CGFloat.self) { $0.size.height } action: { if !open { shortHeight = $0 } }
                // The whole text, measured unseen, says whether two lines cut it.
                .background(alignment: .topLeading) {
                    Text(text)
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                        .hidden()
                        .onGeometryChange(for: CGFloat.self) { $0.size.height } action: { fullHeight = $0 }
                        .accessibilityHidden(true)
                }
            if open || fullHeight > shortHeight + 1 {
                Button(open ? "Less" : "More") {
                    withAnimation(.easeOut(duration: 0.2)) { open.toggle() }
                }
                .buttonStyle(.borderless)
                .controlSize(.small)
                .font(.subheadline)
                .tint(Color.ink)
                .accessibilityIdentifier("habit-description-more")
            }
        }
        .padding(.top, -4)
    }
}

private extension View {
    /// Under the bar, the hard edge Apple asks for when a scroll view has a pinned header (Figma's Scrolled states):
    /// rows go under the tabs and stop, instead of showing through the soft edge above them. iOS 26 and later.
    @ViewBuilder func pinnedTabsEdge() -> some View {
        if #available(iOS 26.0, *) {
            scrollEdgeEffectStyle(.hard, for: .top)
        } else {
            self
        }
    }
}
