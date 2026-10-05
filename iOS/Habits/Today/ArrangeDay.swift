import SwiftUI

/// Edit on Today: "Arrange Your Day" (the user, 3 Oct 2026; report 27, B). Today itself turns into the arranging view:
/// every habit in each time of day (not only today's), with handles to put them in order, and each card's ··· menu to
/// rename, retime, sort or delete a time of day, or to move Anytime and Quit or Cut Down. Done (in Today's top bar) goes back.
///
/// Timed sections follow their times; only Anytime and Quit or Cut Down are moved by hand. Habits and tasks share one order in
/// each card, and both can be dragged (report 27, "Tasks in a time of day").
struct ArrangeDayView: View {
    @Environment(HabitStore.self) private var store
    @State private var adding = false
    @State private var retiming: DaySection?
    @State private var renaming: DaySection?
    @State private var newName = ""
    @State private var deleting: DaySection?

    var body: some View {
        let _ = perfTimed("Count: Arrange Your Day drawn") { () }
        let cards = store.todayCards
        let members = perfTimed("Arrange: each card's habits") { store.cardMembers() }
        List {
            Section {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Arrange Your Day")
                        .font(.title2.weight(.bold))
                        .accessibilityAddTraits(.isHeader)
                    Text("All your habits, not only today's. Drag \(Image(systemName: "line.3.horizontal")) to change their order in a time of day. Use \(Image(systemName: "ellipsis.circle")) to rename, retime, sort or delete a time of day, or to move Anytime and Quit or Cut Down up or down.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
                .accessibilityElement(children: .combine)
                .accessibilityIdentifier("arrange-heading")
            }
            ForEach(cards, id: \.self) { card in
                // Quit or Cut Down only when it holds something, as on Today.
                if card != .quittingCard || members[card]?.isEmpty == false {
                    ArrangeCard(card: card, habits: members[card] ?? [], cards: cards,
                                onRename: { newName = $0.name; renaming = $0 },
                                onRetime: { retiming = $0 }, onDelete: { deleting = $0 })
                }
            }
            Section {
                AddRow(title: "Add Time of Day") { adding = true }
                    .accessibilityIdentifier("arrange-add-section")
            } footer: {
                Text("A new time of day that overlaps others splits them; you'll see how first.")
            }
        }
        .listStyle(.insetGrouped)
        .listSectionSpacing(14)
        // Handles on every habit row, at once: no second Edit to find.
        .environment(\.editMode, .constant(.active))
        .sheet(isPresented: $adding) {
            NavigationStack { SectionEditor(existing: nil) { _ in } }
        }
        .sheet(item: $retiming) { section in
            NavigationStack { SectionEditor(existing: section) { _ in } }
        }
        .alert("Rename \(renaming?.name ?? "")", isPresented: Binding(get: { renaming != nil }, set: { if !$0 { renaming = nil } })) {
            TextField("Name", text: $newName)
                .accessibilityIdentifier("arrange-rename-field")
            Button("Cancel", role: .cancel) { renaming = nil }
            Button("Rename") { rename() }
        } message: {
            Text("Up to \(TextLimit.section) letters.")
        }
        .confirmationDialog("Delete \(deleting?.name ?? "")?", isPresented: Binding(get: { deleting != nil }, set: { if !$0 { deleting = nil } }),
                            titleVisibility: .visible, presenting: deleting) { section in
            Button("Delete Time of Day", role: .destructive) {
                store.saveSections(store.sections.filter { $0.id != section.id })
            }
        } message: { _ in
            Text("Its habits move to Anytime. Nothing else changes.")
        }
    }

    private func rename() {
        guard let section = renaming else { return }
        renaming = nil
        let name = TextLimit.clean(newName, TextLimit.section)
        guard !name.isEmpty, name != section.name else { return }
        store.saveSections(store.sections.map { $0.id == section.id ? DaySection(id: $0.id, name: name, start: $0.start, end: $0.end) : $0 })
    }
}

/// One card in Arrange Your Day: its heading with the ··· menu, then its habits and tasks with handles.
private struct ArrangeCard: View {
    let card: String
    let habits: [Habit]
    let cards: [String]
    let onRename: (DaySection) -> Void
    let onRetime: (DaySection) -> Void
    let onDelete: (DaySection) -> Void
    @Environment(HabitStore.self) private var store

    private var section: DaySection? { card == .quittingCard ? nil : store.section(card) }
    private var title: String { section?.name ?? TodayView.quittingTitle }
    private var movable: Bool { card == .anytime || card == .quittingCard }

    var body: some View {
        Section {
            heading
            if habits.isEmpty {
                Text("No habits here yet.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            ForEach(habits) { ArrangeRow(habit: $0, card: card) }
                .onMove { move(habits, $0, $1) }
        }
    }

    private func move(_ list: [Habit], _ from: IndexSet, _ to: Int) {
        var list = list
        list.move(fromOffsets: from, toOffset: to)
        store.reorder(list.map(\.id))
    }

    private var range: String? {
        guard let section, !section.isAnytime else { return section == nil ? nil : "No set time" }
        let end = store.timedSections.first { $0.section.id == section.id }?.end ?? 0
        return "\(DaySection.clock(section.start ?? 0))–\(DaySection.clock(end))"
    }

    private var heading: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 1) {
                Text(title).font(.headline).lineLimit(1)
                if let range {
                    Text(range).font(.footnote).monospacedDigit().foregroundStyle(.secondary).lineLimit(1)
                }
            }
            .accessibilityElement(children: .combine)
            Spacer(minLength: 8)
            Menu {
                menuItems
            } label: {
                Image(systemName: "ellipsis.circle")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
            }
            .accessibilityLabel("\(title) options")
            .accessibilityIdentifier("arrange-menu-\(title)")
        }
        .frame(minHeight: 44)
        .moveDisabled(true)
    }

    @ViewBuilder private var menuItems: some View {
        if let section, !section.isAnytime {
            Button("Rename", systemImage: "pencil") { onRename(section) }
            Button("Change Time", systemImage: "clock") { onRetime(section) }
        }
        if habits.count > 1 {
            Section("Sort") {
                if store.hasReminderTimes(inCard: card) {
                    Button("By Reminder Time", systemImage: "bell") { withAnimation { store.sortCard(card, by: .reminderTime) } }
                }
                Button("A to Z", systemImage: "textformat") { withAnimation { store.sortCard(card, by: .name) } }
            }
        }
        if movable {
            let index = cards.firstIndex(of: card) ?? 0
            Section("Move \(title)") {
                if index > 0 {
                    Button("Move to Top", systemImage: "arrow.up.to.line") { store.moveCard(card, .top) }
                    Button("Move Up", systemImage: "arrow.up") { store.moveCard(card, .up) }
                }
                if index < cards.count - 1 {
                    Button("Move Down", systemImage: "arrow.down") { store.moveCard(card, .down) }
                    Button("Move to Bottom", systemImage: "arrow.down.to.line") { store.moveCard(card, .bottom) }
                }
            }
        }
        if let section, !section.isAnytime {
            Button("Delete", systemImage: "trash", role: .destructive) { onDelete(section) }
        }
    }
}

/// A habit or task in Arrange Your Day: icon, name and a short line, with the list's handle beside it.
private struct ArrangeRow: View {
    let habit: Habit
    let card: String
    @Environment(HabitStore.self) private var store

    var body: some View {
        HStack(spacing: 12) {
            HabitIcon(symbol: habit.symbol, color: habit.color, size: 28)
            VStack(alignment: .leading, spacing: 1) {
                Text(habit.name).lineLimit(1)
                if let line { Text(line).font(.footnote).foregroundStyle(.secondary).lineLimit(1) }
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("arrange-row-\(habit.name)")
    }

    /// What tells it apart here: a task, paused, or its reminder time in this card.
    private var line: String? {
        if habit.kind == .task { return "Task" }
        if store.isPaused(habit, on: store.today()) { return "Paused" }
        let time = store.placements(of: habit).first { $0.section == card }?.times.first
        return time.map { DaySection.clock($0.minuteOfDay) }
    }
}
