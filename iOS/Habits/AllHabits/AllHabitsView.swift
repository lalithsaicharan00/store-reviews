import SwiftUI

/// Every habit in one place, behind the top-bar ☑︎ button (Build Plan #56). Tap one for its page; swipe to archive
/// or delete; Select to pause, archive or delete several at once; drag to reorder (Today follows the order).
/// Archive keeps all history and frees a free slot (Feature Ledger C016, C219); delete asks first.
struct AllHabitsView: View {
    @Environment(HabitStore.self) private var store
    @State private var editMode: EditMode = .inactive
    @State private var selection = Set<UUID>()
    @State private var pausing: PauseTargets?
    @State private var deleting: [Habit] = []
    @State private var confirmingDelete = false
    @State private var showPlus = false

    struct PauseTargets: Identifiable { let id = UUID(); let habits: [Habit] }

    private var active: [Habit] { store.habits.filter { !$0.archived } }
    private var chosen: [Habit] { store.habits.filter { selection.contains($0.id) } }

    var body: some View {
        List(selection: $selection) {
            group("Habits", active.filter { $0.kind != .quit && $0.kind != .task })
            group("Quitting", active.filter { $0.kind == .quit })
            group("Tasks", active.filter { $0.kind == .task })
            let archived = store.habits.filter(\.archived)
            if !archived.isEmpty {
                Section {
                    ForEach(archived) { row($0) }
                } header: {
                    Text("Archived")
                } footer: {
                    Text("Archived habits keep their history and don't count toward the free limit.")
                }
            }
        }
        .overlay {
            if store.habits.isEmpty {
                ContentUnavailableView("No Habits Yet", systemImage: "checklist", description: Text("Tap + on Today to add one."))
            }
        }
        .environment(\.editMode, $editMode)
        .navigationTitle("All Habits")
        .navigationDestination(for: UUID.self) { HabitPageView(id: $0) }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(editMode.isEditing ? "Done" : "Select") {
                    withAnimation { editMode = editMode.isEditing ? .inactive : .active; selection = [] }
                }
                .disabled(store.habits.isEmpty)
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
        .sheet(isPresented: $showPlus) { PlusView() }
        .confirmationDialog(deleteTitle, isPresented: $confirmingDelete, titleVisibility: .visible) {
            Button("Delete", role: .destructive) { store.delete(deleting); finish() }
            if deleting.contains(where: { !$0.archived }) {
                Button("Archive Instead") { store.archive(deleting.filter { !$0.archived }); finish() }
            }
        } message: {
            Text("Their history and notes are deleted too, and this can't be undone. Archiving stops a habit and keeps its history."
                .replacingOccurrences(of: "Their", with: deleting.count == 1 ? "Its" : "Their"))
        }
    }

    private var deleteTitle: String {
        deleting.count == 1 ? "Delete \(deleting[0].name)?" : "Delete \(deleting.count) Habits?"
    }

    @ViewBuilder private func group(_ title: String, _ list: [Habit]) -> some View {
        if !list.isEmpty {
            Section(title) {
                ForEach(list) { row($0) }
                    .onMove { from, to in
                        var ids = list.map(\.id)
                        ids.move(fromOffsets: from, toOffset: to)
                        store.reorder(ids)
                    }
            }
        }
    }

    private func row(_ habit: Habit) -> some View {
        let paused = store.isPaused(habit, on: store.today())
        return NavigationLink(value: habit.id) {
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
