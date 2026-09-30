import SwiftUI

/// The screens a group opens, on any navigation stack that registers `groupDestinations()`.
enum GroupPage: Hashable {
    /// The groups editor: every group with its total (report 18's "inventory").
    case list
    case new
    case edit(UUID)
}

extension View {
    /// The groups editor and the group form, pushed on this stack. One editor however many ways in (Navigation,
    /// Round 3, rule 2).
    func groupDestinations() -> some View {
        navigationDestination(for: GroupPage.self) { page in
            switch page {
            case .list: GroupsView()
            case .new: GroupForm(group: nil)
            case .edit(let id): GroupEditPage(id: id)
            }
        }
    }
}

/// Today's Filter (the button beside +): the home of groups (Navigation, Round 3; Today reports 13, 17, 18). Groups
/// has Edit on its heading line; each chip's number is how many habits it shows on the day open on Today.
struct FilterSheet: View {
    let day: LocalDay
    /// The chosen group's ID, or "" for All. Remembered when the app reopens.
    @Binding var selection: String
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var path = NavigationPath()
    /// Half height for choosing a chip (Today stays in view behind it), full height once a group screen opens.
    @State private var detent = PresentationDetent.medium

    var body: some View {
        let current = store.existingGroup(selection)
        NavigationStack(path: $path) {
            List {
                Section {
                    if store.groups.isEmpty {
                        // The first group: this is where people find groups (report 17).
                        Text("Group habits by area, like Health or Work, then filter by them here.")
                            .foregroundStyle(.secondary)
                            .accessibilityIdentifier("groups-first-line")
                        NewGroupChip { path.append(GroupPage.new) }
                    } else {
                        GroupChipRow(selection: current, counts: counts(), showNew: true,
                                     onSelect: { selection = $0?.uuidString ?? "" },
                                     onEmpty: { path.append(GroupPage.edit($0.id)) },
                                     onNew: { path.append(GroupPage.new) })
                    }
                } header: {
                    HStack {
                        Text("Groups")
                        Spacer()
                        if !store.groups.isEmpty {
                            Button("Edit") { path.append(GroupPage.list) }
                                .font(.subheadline.weight(.semibold))
                                .textCase(nil)
                                .accessibilityIdentifier("groups-edit")
                        }
                    }
                } footer: {
                    if !store.groups.isEmpty {
                        Text("Numbers show habits on \(dayText).")
                    }
                }
            }
            .navigationTitle("Filter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) { Button("Done") { dismiss() } }
            }
            .groupDestinations()
        }
        .presentationDetents([.medium, .large], selection: $detent)
        .onChange(of: path.count) { if path.count > 0 { withAnimation { detent = .large } } }
    }

    private var dayText: String {
        let today = store.today()
        if day == today { return "today" }
        return day.date(calendar: store.calendar).formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated))
    }

    /// Each chip's number, worked out only while the sheet is open. A group with no habits at all is left out ("–").
    private func counts() -> [UUID?: Int] {
        var counts: [UUID?: Int] = [UUID?.none: store.groupCount(nil, on: day) ?? 0]
        for group in store.groups { if let n = store.groupCount(group.id, on: day) { counts[group.id] = n } }
        return counts
    }
}

/// The groups editor: every group with its total, in order. Tap to edit; drag for your own order; swipe to delete.
struct GroupsView: View {
    @Environment(HabitStore.self) private var store
    @State private var deleting: HabitGroup?

    var body: some View {
        List {
            Section {
                ForEach(store.groups) { group in
                    let n = store.members(of: group).count
                    NavigationLink(value: GroupPage.edit(group.id)) {
                        HStack(spacing: 12) {
                            Circle().fill(group.color.color).frame(width: 12, height: 12)
                            VStack(alignment: .leading, spacing: 1) {
                                Text(group.name)
                                Text(n == 0 ? "No habits yet" : n == 1 ? "1 habit" : "\(n) habits")
                                    .font(.subheadline).foregroundStyle(.secondary)
                            }
                        }
                    }
                    .accessibilityIdentifier("groups-row-\(group.name)")
                    .swipeActions(edge: .trailing) {
                        Button("Delete", systemImage: "trash") { deleting = group }.tint(.red)
                    }
                }
                .onMove { store.moveGroups(from: $0, to: $1) }
                NavigationLink(value: GroupPage.new) {
                    Label("New Group", systemImage: "plus")
                }
                .accessibilityIdentifier("groups-new")
            } footer: {
                Text(store.groupsManual ? "Your order, the same on Today, Progress and the habit form."
                     : "A to Z. Drag a group to put them in your own order.")
            }
            if store.groupsManual {
                Section {
                    Button("Sort A to Z") { store.sortGroupsAZ() }
                        .accessibilityIdentifier("groups-sort-az")
                }
            }
        }
        .navigationTitle("Groups")
        .toolbar { ToolbarItem(placement: .topBarTrailing) { EditButton() } }
        .deleteGroupDialog($deleting)
    }
}

extension View {
    /// "Delete Health?" Its habits stay, with no group, and keep their history.
    func deleteGroupDialog(_ group: Binding<HabitGroup?>, onDelete: @escaping () -> Void = {}) -> some View {
        modifier(DeleteGroupDialog(group: group, onDelete: onDelete))
    }
}

private struct DeleteGroupDialog: ViewModifier {
    @Binding var group: HabitGroup?
    let onDelete: () -> Void
    @Environment(HabitStore.self) private var store

    func body(content: Content) -> some View {
        content.confirmationDialog("Delete \(group?.name ?? "Group")?",
                                   isPresented: Binding(get: { group != nil }, set: { if !$0 { group = nil } }),
                                   titleVisibility: .visible, presenting: group) { group in
            Button("Delete Group", role: .destructive) {
                store.deleteGroup(group.id)
                onDelete()
            }
        } message: { group in
            let n = store.members(of: group).count
            Text(n == 0 ? "No habits are in it." : "Its \(n == 1 ? "habit stays" : "\(n) habits stay"), with no group. Their history isn't touched."
                .replacingOccurrences(of: "Their", with: n == 1 ? "Its" : "Their"))
        }
    }
}

/// Opens a group by ID, as it is now; gone if it was deleted meanwhile.
private struct GroupEditPage: View {
    let id: UUID
    @Environment(HabitStore.self) private var store

    var body: some View {
        if let group = store.groups.first(where: { $0.id == id }) {
            GroupForm(group: group)
        } else {
            ContentUnavailableView("Group Deleted", systemImage: "folder")
        }
    }
}

/// New Group and Edit Group: name, colour, and which habits are in it (report 17). A habit is in one group at a time.
struct GroupForm: View {
    let original: HabitGroup?
    /// False from the habit form's picker: the habit being made joins it there.
    var showHabits = true
    var onSaved: (UUID) -> Void = { _ in }
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var name: String
    @State private var color: HabitColor?
    @State private var chosen: Set<UUID>
    @State private var deleting: HabitGroup?
    @State private var pausing: PauseList?
    @FocusState private var nameFocused: Bool

    struct PauseList: Identifiable { let id = UUID(); let habits: [Habit] }

    init(group: HabitGroup?, showHabits: Bool = true, onSaved: @escaping (UUID) -> Void = { _ in }) {
        original = group
        self.showHabits = showHabits
        self.onSaved = onSaved
        _name = State(initialValue: group?.name ?? "")
        _color = State(initialValue: group?.color)
        _chosen = State(initialValue: Set(group?.habits ?? []))
    }

    private var trimmed: String { TextLimit.clean(name, TextLimit.group) }
    private var taken: Bool {
        store.groups.contains { $0.id != original?.id && $0.name.localizedCaseInsensitiveCompare(trimmed) == .orderedSame }
    }
    private var candidates: [Habit] { store.habits.filter { !$0.archived } }
    private var changed: Bool {
        guard let original else { return true }
        return trimmed != original.name || color != original.color || chosen != Set(original.habits)
    }

    var body: some View {
        Form {
            Section {
                TextField("Name, like Health or Work", text: $name)
                    .focused($nameFocused)
                    .limitText($name, to: TextLimit.group)
                    .submitLabel(.done)
                    .onSubmit { nameFocused = false }
                    .accessibilityLabel("Group name")
                    .accessibilityIdentifier("group-name-field")
            } footer: {
                if taken { Text("You already have a group called \(trimmed).").formNote() }
                else if let note = TextLimit.note(name, TextLimit.group) { Text(note).formNote() }
            }
            Section("Colour") {
                ColorGrid(selection: Binding(get: { color ?? .green }, set: { color = $0 }))
            }
            if showHabits && !candidates.isEmpty {
                Section {
                    ForEach(candidates) { habit in
                        habitRow(habit)
                    }
                } header: {
                    Text("Habits")
                } footer: {
                    Text("A habit is in one group at a time. Habits with no group still show under All.")
                }
            }
            if let original {
                let members = store.members(of: original)
                if members.contains(where: { store.canPause($0) }) {
                    Section {
                        // Pause a group: holidays, travel (Day Structure report, Part 6).
                        Button("Pause These Habits…", systemImage: "pause.circle") {
                            pausing = PauseList(habits: members.filter { store.canPause($0) })
                        }
                        .accessibilityIdentifier("group-pause")
                    }
                }
                Section {
                    Button("Delete Group", role: .destructive) { deleting = original }
                        .frame(maxWidth: .infinity)
                        .accessibilityIdentifier("group-delete")
                }
            }
        }
        .navigationTitle(original == nil ? "New Group" : "Edit Group")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(original == nil || changed)
        .toolbar {
            if original == nil || changed {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button(original == nil ? "Add" : "Save") { save() }
                    .fontWeight(.semibold)
                    .disabled(trimmed.isEmpty || taken || !changed)
                    .accessibilityIdentifier("group-save")
            }
        }
        .onAppear {
            if color == nil { color = store.suggestedGroupColor() }
            if original == nil { nameFocused = true }
        }
        .sheet(item: $pausing) { PauseSheet(habits: $0.habits) }
        .deleteGroupDialog($deleting) { dismiss() }
    }

    private func habitRow(_ habit: Habit) -> some View {
        let isIn = chosen.contains(habit.id)
        let elsewhere: HabitGroup? = store.group(of: habit.id).flatMap { $0.id == original?.id ? nil : $0 }
        return Button {
            if isIn { chosen.remove(habit.id) } else { chosen.insert(habit.id) }
        } label: {
            HStack(spacing: 12) {
                HabitIcon(symbol: habit.symbol, color: habit.color)
                VStack(alignment: .leading, spacing: 1) {
                    Text(habit.name).foregroundStyle(Color.primary).lineLimit(1)
                    if let elsewhere {
                        Text(isIn ? "Moves from \(elsewhere.name)" : "In \(elsewhere.name)")
                            .font(.subheadline).foregroundStyle(.secondary)
                    }
                }
                Spacer(minLength: 8)
                Image(systemName: isIn ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .foregroundStyle(isIn ? Color.accentColor : Color.secondary)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(habit.name + (elsewhere.map { ", in \($0.name)" } ?? ""))
        .accessibilityAddTraits(isIn ? .isSelected : [])
        .accessibilityIdentifier("group-habit-\(habit.name)")
    }

    private func save() {
        guard !trimmed.isEmpty, !taken else { return }
        var group = original ?? HabitGroup(name: trimmed, color: color ?? .green)
        group.name = trimmed
        group.color = color ?? group.color
        if showHabits {
            // Archived members stay in it; the rest follow the habits' own order.
            let archived = Set(store.habits.filter(\.archived).map(\.id))
            group.habits = group.habits.filter { archived.contains($0) } + candidates.map(\.id).filter { chosen.contains($0) }
        }
        store.saveGroup(group)
        onSaved(group.id)
        dismiss()
    }
}

/// The habit form's Group row opens this: None, the groups in their order, and New Group.
struct GroupPicker: View {
    @Binding var selection: UUID?
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var creating = false

    var body: some View {
        List {
            Section {
                row("None", color: nil, id: nil)
                ForEach(store.groups) { row($0.name, color: $0.color, id: $0.id) }
            } footer: {
                Text("A habit is in one group at a time. Filter Today and Progress by group.")
            }
            Section {
                AddRow(title: "New Group") { creating = true }
                    .accessibilityIdentifier("group-picker-new")
            }
        }
        .navigationTitle("Group")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $creating) {
            GroupForm(group: nil, showHabits: false) { selection = $0 }
        }
    }

    private func row(_ title: String, color: HabitColor?, id: UUID?) -> some View {
        Button {
            selection = id
            dismiss()
        } label: {
            HStack(spacing: 12) {
                if let color { Circle().fill(color.color).frame(width: 12, height: 12) }
                Text(title).foregroundStyle(Color.primary)
                Spacer()
                if selection == id { Image(systemName: "checkmark").foregroundStyle(Color.accentColor).fontWeight(.semibold) }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(selection == id ? .isSelected : [])
        .accessibilityIdentifier("group-option-\(title)")
    }
}
