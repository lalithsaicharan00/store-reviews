import SwiftUI

/// Edit on Today: Edit Today (Figma's Edit Today, 827:39487, 17 Nov 2026). Today itself turns into one list in edit
/// mode: every habit and task in each routine (not only today's), each with its handle.
///
/// - A routine with a set time has its name and hours as a heading, with **Edit** on the right (a borderless word, as
///   Health's section headers say Edit), which opens Edit Routine: its name, start and Delete.
/// - Anytime and Quitting move as whole sections by their own handle; timed routines follow their times.
/// - Any habit moves by its handle, also into another routine (never into or out of Quitting, which holds what's quit
///   or cut down by what it is). An empty routine says "Drag a habit here".
/// - Add Routine is a list row of its own after the timed routines: a filled plus in Ink, as Contacts adds a phone.
///
/// One flat `ForEach`, so the system's own drag carries a row into another routine: `List` only moves rows inside
/// one `ForEach`. Each row draws its own piece of its card.
struct ArrangeDayView: View {
    @Environment(HabitStore.self) private var store
    @State private var adding = false
    @State private var editing: DaySection?
    /// How many times each row was put back after a drop that changes nothing (into or out of Quitting, or the empty
    /// routine's own placeholder). The List has already drawn the row where it was dropped, and a list whose data
    /// didn't change never draws it again, so the row gets a new identity and goes back where it belongs (seen on the
    /// Simulator, 17 Nov 2026: Smoking stayed drawn in Anytime).
    @State private var putBack: [String: Int] = [:]

    var body: some View {
        let _ = perfTimed("Count: Arrange Your Day drawn") { () }
        let entries = perfTimed("Arrange: each card's habits") { Self.entries(store: store) }
        List {
            ForEach(entries.map { Keyed(entry: $0, id: $0.id + "#\(putBack[$0.id, default: 0])") }) { keyed in
                row(keyed.entry, in: entries)
                    .listRowSeparator(.hidden)
                    .moveDisabled(!keyed.entry.moves)
            }
            .onMove { move(entries, $0, $1) }
        }
        .listStyle(.plain)
        // The cards' 16 from the screen's edges is the list's own, so the system's handle sits 16 inside a card, as in
        // Figma (it's placed from the row's edge, whatever the insets).
        .padding(.horizontal, 16)
        .scrollContentBackground(.hidden)
        .background(Color(.systemGroupedBackground))
        .contentMargins(.bottom, 40, for: .scrollContent)
        .environment(\.defaultMinListRowHeight, 0)
        // Not the list's edit mode: its handles would show on the rows that only hold a place (`start`, `end`). A touch
        // and hold lifts a row, as in Reminders, and the ≡ each row draws says it can be moved.
        .navigationTitle("Edit Today")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $adding) {
            NavigationStack { SectionEditor(existing: nil) { _ in } }
        }
        .sheet(item: $editing) { section in
            NavigationStack { SectionEditor(existing: section) { _ in } }
        }
    }

    // MARK: The rows

    enum Entry: Identifiable, Hashable {
        case heading(String)
        case habit(String, Habit, first: Bool, last: Bool)
        /// An empty routine's "Drag a habit here", in place of its end.
        case empty(String)
        /// The start and end of a card: rows the List can drop beside. `List` only drops a row next to one that moves
        /// itself, so without them an empty routine (a heading and "Drag a habit here") could never take a habit, and
        /// a card's first and last places couldn't be reached from outside it (seen on the Simulator, 17 Nov 2026).
        /// 1 pt tall and hidden, so nothing can lift them; the placeholder can be lifted, and goes back (`putBack`).
        case start(String)
        case end(String)
        case addRoutine

        var id: String {
            switch self {
            case .heading(let card): "heading-" + card
            case .habit(let card, let habit, _, _): card + "-" + habit.id.uuidString
            case .empty(let card): "empty-" + card
            case .start(let card): "start-" + card
            case .end(let card): "end-" + card
            case .addRoutine: "add-routine"
            }
        }

        /// Habits move by their handle; Anytime and Quitting by their heading's.
        var moves: Bool {
            switch self {
            case .habit, .start, .end, .empty: true
            case .heading(let card): card == .anytime || card == .quittingCard
            default: false
            }
        }

        /// The routine a row belongs to; nil for Add Routine.
        var card: String? {
            switch self {
            case .heading(let card), .empty(let card), .start(let card), .end(let card), .habit(let card, _, _, _): card
            case .addRoutine: nil
            }
        }

        static func == (a: Entry, b: Entry) -> Bool { a.id == b.id }
        func hash(into hasher: inout Hasher) { hasher.combine(id) }
    }

    /// Every card from top to bottom, its heading then its habits (or "Drag a habit here"); Add Routine after the last
    /// timed routine. Quitting only when it holds something, as on Today.
    static func entries(store: HabitStore) -> [Entry] {
        let cards = store.todayCards
        let members = store.cardMembers()
        let shown = cards.filter { $0 != .quittingCard || members[$0]?.isEmpty == false }
        let lastTimed = shown.lastIndex { $0 != .anytime && $0 != .quittingCard }
        var list: [Entry] = []
        if lastTimed == nil { list.append(.addRoutine) }
        for (i, card) in shown.enumerated() {
            list.append(.heading(card))
            list.append(.start(card))
            let habits = members[card] ?? []
            for (j, habit) in habits.enumerated() {
                list.append(.habit(card, habit, first: j == 0, last: j == habits.count - 1))
            }
            list.append(habits.isEmpty ? .empty(card) : .end(card))
            if i == lastTimed { list.append(.addRoutine) }
        }
        return list
    }

    @ViewBuilder private func row(_ entry: Entry, in entries: [Entry]) -> some View {
        switch entry {
        case .heading(let card):
            ArrangeHeading(card: card, isFirst: entries.first == entry, onEdit: { editing = $0 })
        case .habit(let card, let habit, let first, let last):
            ArrangeRow(habit: habit, card: card, first: first, last: last)
        case .empty:
            Text("Drag a habit here")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, minHeight: 56)
                .background(RoundedRectangle(cornerRadius: 24)
                    .strokeBorder(Color(.systemGray), style: StrokeStyle(lineWidth: 1, dash: [4, 4])))
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                .accessibilityIdentifier("arrange-empty")
        case .start, .end:
            Color.clear.frame(height: 1)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                .accessibilityHidden(true)
        case .addRoutine:
            Button { adding = true } label: {
                HStack(spacing: 16) {
                    // Figma: a filled plus in Ink (Contacts draws it green; the chrome stays neutral here).
                    Image(systemName: "plus.circle.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.onInk, Color.ink)
                        .font(.system(size: 22))
                        .frame(width: 24)
                    Text("Add Routine").foregroundStyle(.primary)
                    Spacer(minLength: 0)
                }
                .padding(.vertical, 14)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .listRowInsets(EdgeInsets(top: entries.first == entry ? 0 : 16, leading: 16, bottom: 0, trailing: 16))
            .listRowBackground(CardPiece(first: true, last: true, top: entries.first == entry ? 0 : 16))
            .accessibilityIdentifier("arrange-add-section")
        }
    }

    // MARK: Moving

    /// A habit dropped in its own routine changes its place there; dropped in another, it moves to that routine
    /// (never into or out of Quitting). Anytime's or Quitting's heading dropped among the cards moves that card.
    private func move(_ entries: [Entry], _ from: IndexSet, _ to: Int) {
        guard let index = from.first else { return }
        var after = entries
        after.move(fromOffsets: from, toOffset: to)
        let moved = entries[index]
        guard let landed = after.firstIndex(of: moved) else { return }
        switch moved {
        case .habit(let source, let habit, _, _):
            // The routine is the nearest heading above where it landed.
            guard let target = after[..<landed].last(where: { if case .heading = $0 { true } else { false } })?.card
            else { return putBack[moved.id, default: 0] += 1 }
            guard (source == .quittingCard) == (target == .quittingCard) else { return putBack[moved.id, default: 0] += 1 }
            if target != source {
                var changed = habit
                var parts = habit.parts.map { $0 == source ? target : $0 }
                if !parts.contains(target) { parts = [target] }
                changed.parts = parts.reduce(into: []) { if !$0.contains($1) { $0.append($1) } }
                store.update(changed)
            }
            let order = after.compactMap { entry -> UUID? in
                if case .habit(let card, let h, _, _) = entry, card == target || h.id == habit.id { return h.id }
                return nil
            }
            store.reorder(order)
        case .heading(let card):
            // Before the next card's heading below where it landed; the end if there is none.
            let next = after[(landed + 1)...].first { if case .heading = $0 { true } else { false } }?.card
            store.placeCard(card, before: next)
        default:
            putBack[moved.id, default: 0] += 1
        }
    }
}

/// A row with the identity it's drawn under (`putBack`).
private struct Keyed: Identifiable {
    let entry: ArrangeDayView.Entry
    let id: String
}

/// A card's heading: Morning · 6 AM – 12 PM and Edit; Anytime and Quitting with their handle (the list's own).
private struct ArrangeHeading: View {
    let card: String
    let isFirst: Bool
    let onEdit: (DaySection) -> Void
    @Environment(HabitStore.self) private var store

    private var section: DaySection? { card == .quittingCard ? nil : store.section(card) }
    private var title: String { card == .quittingCard ? "Quitting" : (section?.name ?? "") }
    private var movable: Bool { card == .anytime || card == .quittingCard }

    /// "Morning · 6 AM – 12 PM": a timed routine's hours after its name.
    private var label: String {
        guard let section, !section.isAnytime, let start = section.start else { return title }
        let end = store.timedSections.first { $0.section.id == section.id }?.end ?? 0
        return "\(title) · \(Self.short(start)) – \(Self.short(end))"
    }

    private static func short(_ minutes: Int) -> String { String(DaySection.startsText(minutes).dropFirst("Starts ".count)) }

    var body: some View {
        HStack(spacing: 8) {
            Text(label)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.primary)
                .accessibilityAddTraits(.isHeader)
                .frame(maxWidth: .infinity, alignment: .leading)
            if movable {
                Handle(strong: true).frame(width: 44, height: 44)
            } else if let section, !section.isAnytime {
                // A word, not a pencil or ⓘ: it says the routine can be changed here (the user, 6 Nov 2026).
                Button("Edit") { onEdit(section) }
                    .buttonStyle(.borderless)
                    .font(.subheadline)
                    .tint(.ink)
                    .padding(.horizontal, 10)
                    .frame(minHeight: 44)
                    .contentShape(Rectangle())
                    .accessibilityLabel("Edit \(title)")
                    .accessibilityIdentifier("arrange-edit-\(title)")
            }
        }
        .frame(minHeight: 48)
        .padding(.top, isFirst ? 0 : 16)
        .padding(.bottom, 8)
        // Edit's word ends 16 inside the card's edge.
        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 6))
        .listRowBackground(Color.clear)
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("arrange-heading-\(title)")
        // The handle is for a finger; VoiceOver moves the card with these.
        .accessibilityActions {
            if movable {
                Button("Move Up") { store.moveCard(card, .up) }
                Button("Move Down") { store.moveCard(card, .down) }
            }
        }
    }
}

/// A habit or task in Edit Today: its symbol in Secondary Label (no colour here: this list is about order), the name
/// and what tells it apart (Paused, a task, its days), with the list's handle beside it.
private struct ArrangeRow: View {
    let habit: Habit
    let card: String
    let first: Bool
    let last: Bool
    @Environment(HabitStore.self) private var store

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: habit.symbol)
                .symbolVariant(.fill)
                .font(.system(size: 20))
                .foregroundStyle(.secondary)
                .frame(width: 24)
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 0) {
                Text(habit.name).lineLimit(1)
                if let line { Text(line).font(.subheadline).foregroundStyle(.secondary).lineLimit(1) }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Handle()
        }
        .padding(.vertical, line == nil ? 14 : 15)
        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .listRowBackground(CardPiece(first: first, last: last, separator: !last))
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("arrange-row-\(habit.name)")
    }

    /// What tells it apart here: a task, paused, or how often when it isn't every day ("Mon, Wed, Fri",
    /// "3 times a week").
    private var line: String? {
        if habit.kind == .task { return "Task" }
        if store.isPaused(habit, on: store.today()) { return "Paused" }
        switch habit.frequency {
        case .daily: return nil
        case .perWeek(let n): return n == 1 ? "Once a week" : "\(n) times a week"
        case .perMonth(let n): return n == 1 ? "Once a month" : "\(n) times a month"
        case .perYear(let n): return n == 1 ? "Once a year" : "\(n) times a year"
        default:
            let words = HabitCopy.rhythm(habit.frequency, weekStart: store.settings.weekStart, short: true)
            return words.isEmpty ? nil : HabitCopy.capitalized(words)
        }
    }
}

/// The ≡ on a row that moves: Tertiary Label on a habit, as the list's own handle (Figma's Trailing icon), and Label on
/// a section's heading (Figma's Anytime and Quitting). A touch and hold anywhere on the row lifts it.
private struct Handle: View {
    var strong = false

    var body: some View {
        Image(systemName: "line.3.horizontal")
            .font(.system(size: 17))
            .foregroundStyle(strong ? .primary : .tertiary)
            .frame(width: 24)
            .accessibilityHidden(true)
    }
}

/// One row's piece of its card: Secondary System Grouped Background, 26 on the card's outer corners, and the line under
/// it from the text to 16 before the edge.
private struct CardPiece: View {
    let first: Bool
    let last: Bool
    var separator = false
    var top: CGFloat = 0

    var body: some View {
        UnevenRoundedRectangle(topLeadingRadius: first ? 26 : 0, bottomLeadingRadius: last ? 26 : 0,
                               bottomTrailingRadius: last ? 26 : 0, topTrailingRadius: first ? 26 : 0)
            .fill(Color(.secondarySystemGroupedBackground))
            .overlay(alignment: .bottom) {
                if separator {
                    Rectangle().fill(Color(.separator)).frame(height: 1 / 3)
                        .padding(.leading, 56).padding(.trailing, 16)
                }
            }
            .padding(.top, top)
    }
}
