import SwiftUI

/// Every habit in one place (Build Plan #56), reached from the ≡ menu: "Habits" shows habits and quit habits,
/// "Tasks" shows tasks (the user, 30 Sep 2026; `Docs/Checklists/Sidebar Menu.md`). Tap one for its page; swipe to
/// archive or delete; Select to pause, archive or delete several at once; drag to reorder (Today follows the order).
/// Archive keeps all history and frees a free slot (Feature Ledger C016, C219); delete asks first.
struct AllHabitsView: View {
    enum Kind { case habits, tasks }
    var kind: Kind = .habits
    @Environment(HabitStore.self) private var store
    @State private var editMode: EditMode = .inactive
    @State private var selection = Set<UUID>()
    @State private var pausing: PauseTargets?
    @State private var deleting: [Habit] = []
    @State private var confirmingDelete = false
    @State private var showPlus = false
    @State private var addingTask = false
    /// Speed runs: a habit page opened by `PerfDriver`.
    @State private var perfPage: UUID?

    struct PauseTargets: Identifiable { let id = UUID(); let habits: [Habit] }

    /// The habits this page lists: habits and quit habits, or tasks.
    private var shown: [Habit] { store.habits.filter { ($0.kind == .task) == (kind == .tasks) } }
    private var active: [Habit] { shown.filter { !$0.archived } }
    private var chosen: [Habit] { shown.filter { selection.contains($0.id) } }

    var body: some View {
        // Selection only while Select is on. Always on, a tap on a row selected it instead of opening its page (each
        // row's tag is the same ID its link opens); found by `TodayUITests.testMenu`, 30 Sep.
        List(selection: editMode.isEditing ? $selection : nil) {
            switch kind {
            case .habits:
                let habits = active.filter { $0.kind != .quit }
                if store.groups.isEmpty {
                    group("Habits", habits)
                } else {
                    // With groups: one section per group in the groups' order, then the rest (groups spec §2).
                    ForEach(store.groups) { g in
                        group(g.name, habits.filter { store.groupOf[$0.id] == g.id }, color: g.color)
                    }
                    group("No Group", habits.filter { store.groupOf[$0.id] == nil })
                }
                group("Quitting", active.filter { $0.kind == .quit })
            case .tasks:
                group(nil, active)
            }
            let archived = shown.filter(\.archived)
            if !archived.isEmpty {
                Section {
                    ForEach(archived) { row($0) }
                } header: {
                    Text("Archived")
                } footer: {
                    Text(kind == .tasks ? "Archived tasks keep their history."
                         : "Archived habits keep their history and don't count toward the free limit.")
                }
            }
        }
        .overlay {
            if shown.isEmpty {
                switch kind {
                case .habits:
                    ContentUnavailableView("No Habits Yet", systemImage: "checklist", description: Text("Tap + on Today to add one."))
                case .tasks:
                    ContentUnavailableView("No Tasks Yet", systemImage: "list.bullet", description: Text("Tap + to add a task."))
                }
            }
        }
        .environment(\.editMode, $editMode)
        .analyticsScreen(kind == .tasks ? .myTasks : .allHabits)
        .navigationTitle(kind == .tasks ? "Tasks" : "Habits")
        .navigationDestination(for: UUID.self) { HabitPageView(id: $0) }
        .navigationDestination(item: $perfPage) { HabitPageView(id: $0) }
        .onPerfCommand { action in
            if case .openHabit(let name) = action { perfPage = store.habits.first { $0.name == name }?.id }
        }
        .toolbar {
            if kind == .tasks && !editMode.isEditing {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Task", systemImage: "plus") { addingTask = true }
                        .accessibilityIdentifier("tasks-add")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(editMode.isEditing ? "Done" : "Select") {
                    withAnimation { editMode = editMode.isEditing ? .inactive : .active; selection = [] }
                }
                .disabled(shown.isEmpty)
            }
            if editMode.isEditing {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("Pause") { pausing = PauseTargets(habits: chosen.filter { store.canPause($0) }) }
                        .disabled(!chosen.contains { store.canPause($0) })
                    Spacer()
                    Button("Archive") { store.archive(chosen.filter { !$0.archived }); finish() }
                        .disabled(!chosen.contains { !$0.archived })
                    Spacer()
                    Button("Delete", role: .destructive) { ask(chosen) }
                        .disabled(chosen.isEmpty)
                }
            }
        }
        .sheet(item: $pausing, onDismiss: finish) { PauseSheet(habits: $0.habits) }
        .sheet(isPresented: $addingTask) {
            NavigationStack { HabitForm(type: .task, onSaved: { _ in addingTask = false }) }
        }
        .sheet(isPresented: $showPlus) { PlusView() }
        .confirmationDialog(deleteTitle, isPresented: $confirmingDelete, titleVisibility: .visible) {
            Button("Delete", role: .destructive) { store.delete(deleting); finish() }
            if deleting.contains(where: { !$0.archived }) {
                Button("Archive Instead") { store.archive(deleting.filter { !$0.archived }); finish() }
            }
        } message: {
            Text("Their history and notes are deleted too, and this can't be undone. Archiving stops it and keeps its history."
                .replacingOccurrences(of: "Their", with: deleting.count == 1 ? "Its" : "Their"))
        }
    }

    private var deleteTitle: String {
        deleting.count == 1 ? "Delete \(deleting[0].name)?" : "Delete \(deleting.count) \(kind == .tasks ? "Tasks" : "Habits")?"
    }

    @ViewBuilder private func group(_ title: String?, _ list: [Habit], color: HabitColor? = nil) -> some View {
        if !list.isEmpty {
            Section {
                ForEach(list) { row($0) }
                    .onMove { from, to in
                        var ids = list.map(\.id)
                        ids.move(fromOffsets: from, toOffset: to)
                        store.reorder(ids)
                    }
            } header: {
                if let title {
                    HStack(spacing: 6) {
                        if let color { Circle().fill(color.color).frame(width: 8, height: 8) }
                        Text(title)
                    }
                }
            }
        }
    }

    private func row(_ habit: Habit) -> some View {
        let paused = store.isPaused(habit, on: store.today())
        // A link with its page, not a value: in a List with a selection, a value link only selected the row and the
        // page never opened (the speed test on GitHub, 30 Sep).
        return NavigationLink {
            HabitPageView(id: habit.id)
        } label: {
            HStack(spacing: 12) {
                HabitIcon(symbol: habit.symbol, color: habit.color)
                    .opacity(habit.archived || paused ? 0.5 : 1)
                VStack(alignment: .leading, spacing: 1) {
                    Text(habit.name).lineLimit(1)
                    Text(HabitPageView.summary(habit, store: store)).font(.subheadline).foregroundStyle(.secondary).lineLimit(1)
                }
            }
            .padding(.vertical, 2)
        }
        .tag(habit.id)
        .swipeActions(edge: .trailing) {
            Button("Delete", systemImage: "trash") { ask([habit]) }
                .tint(.red)
            if habit.archived {
                Button("Restore", systemImage: "arrow.uturn.backward") { if !store.restore(habit) { showPlus = true } }
                    .tint(.blue)
            } else {
                Button("Archive", systemImage: "archivebox") { store.archive([habit]) }
                    .tint(.gray)
            }
        }
    }

    private func ask(_ list: [Habit]) {
        guard !list.isEmpty else { return }
        deleting = list
        confirmingDelete = true
    }

    private func finish() {
        withAnimation { selection = []; editMode = .inactive }
    }
}
