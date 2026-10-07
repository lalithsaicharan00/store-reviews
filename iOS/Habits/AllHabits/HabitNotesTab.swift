import SwiftUI

// The habit page's Notes tab (the user, 3 Oct 2026; research Notes: browse → read → edit). The habit's own dated notes,
// newest first, independent of whether the day was done. Reading never changes progress; editing is explicit
// (Add note, Note and Edit note: the 7 October 2026 redesign, `NoteSheet.swift`).

/// Search across the top, Add Note under it, then a card per month that folds like History's, a row per day's note.
struct HabitNotesTab: View {
    let habit: Habit
    let months: [NoteMonth]
    @Environment(HabitStore.self) private var store
    /// The text searched for, caught up when typing pauses (Rulebook S11: typing redraws only the field).
    @State private var query = ""
    @State private var adding = false
    /// Months folded or opened by hand while the page is open (the newest two start open, as in History).
    @State private var toggled: Set<LocalDay> = []

    var body: some View {
        let today = store.today()
        // Search first, across the whole width, above the notes it filters; then Add Note on its own row, the same button
        // as History's (the user, 5 Oct 2026: Add Note was bigger than a cramped search field beside it; the 4 Oct
        // handoff: an inline search, not a separate search page, since it only filters this habit's notes). No search
        // while there's nothing to search.
        VStack(alignment: .leading, spacing: WeekSpacing.tight) {
            if !months.isEmpty { NoteSearchField { query = $0 } }
            Button { adding = true } label: {
                Label("Add note", systemImage: "plus")
            }
            .pageAction()
            .accessibilityIdentifier("notes-add")
        }
        .pageItem()
        .sheet(isPresented: $adding) { AddNoteView(habit: habit, day: today, picksDay: true) }
        let shown = Self.matching(months, query)
        if months.isEmpty {
            VStack(alignment: .leading, spacing: WeekSpacing.pair) {
                Text("No notes yet").font(.headline)
                Text("Add context to any day of this habit: what helped, what got in the way. Notes never change your progress.")
                    .font(.subheadline).foregroundStyle(.secondary).fixedSize(horizontal: false, vertical: true)
            }
            .pageCard()
            .pageItem()
            .accessibilityIdentifier("notes-empty")
        } else if shown.isEmpty {
            Text("No notes match “\(query)”.")
                .font(.subheadline).foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .pageCard()
                .pageItem()
        }
        // A card per month, like History's: its name and how many notes, folding from the header, a row per day's
        // note (the user, 5 Oct 2026). The newest two start open, as History's do; a search opens every month it finds.
        let searching = !query.trimmingCharacters(in: .whitespaces).isEmpty
        ForEach(Array(shown.enumerated()), id: \.element.id) { index, month in
            let isOpen = searching || (index < 2) != toggled.contains(month.first)
            NoteMonthCard(habit: habit, month: month, isOpen: isOpen) {
                withAnimation(.snappy(duration: 0.25)) {
                    if toggled.contains(month.first) { toggled.remove(month.first) } else { toggled.insert(month.first) }
                }
            }
            .pageItem()
        }
    }

    /// The notes whose text has the query, by month; every note while the query is empty.
    static func matching(_ months: [NoteMonth], _ query: String) -> [NoteMonth] {
        let query = query.trimmingCharacters(in: .whitespaces)
        guard !query.isEmpty else { return months }
        return months.compactMap { month in
            let notes = month.notes.filter { $0.text.localizedCaseInsensitiveContains(query) }
            return notes.isEmpty ? nil : NoteMonth(first: month.first, title: month.title, notes: notes)
        }
    }
}

/// A search field for one habit's notes. Its text lives here; the list hears it once typing pauses (0.3 s).
private struct NoteSearchField: View {
    let changed: (String) -> Void
    @State private var text = ""

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "magnifyingglass").foregroundStyle(.secondary)
            TextField("Search notes", text: $text)
                .submitLabel(.search)
                .autocorrectionDisabled()
                .accessibilityIdentifier("notes-search")
            if !text.isEmpty {
                Button { text = "" } label: { Image(systemName: "xmark.circle.fill").foregroundStyle(.tertiary) }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Clear search")
            }
        }
        .padding(.horizontal, 10)
        .frame(minHeight: 44)
        .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .task(id: text) {
            try? await Task.sleep(for: .milliseconds(300))
            guard !Task.isCancelled else { return }
            changed(text)
        }
    }
}

/// One month of notes, shaped as History's month card: the header folds it; each row is a day, its date as History
/// writes it, then the note's first lines, opening the note to read in full.
private struct NoteMonthCard: View {
    let habit: Habit
    let month: NoteMonth
    let isOpen: Bool
    let toggle: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: toggle) {
                HStack(alignment: .center, spacing: WeekSpacing.tight) {
                    VStack(alignment: .leading, spacing: WeekSpacing.label) {
                        Text(month.title).font(.headline).foregroundStyle(.primary)
                        Text(month.summary).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                    }
                    Spacer(minLength: WeekSpacing.tight)
                    // An accordion's chevron: down while folded, up while open (Design Rules).
                    Image(systemName: "chevron.down")
                        .font(.footnote.weight(.semibold)).foregroundStyle(.secondary)
                        .rotationEffect(.degrees(isOpen ? 180 : 0))
                }
                .padding(WeekSpacing.card)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityElement(children: .combine)
            .accessibilityValue(isOpen ? "Open" : "Folded")
            .accessibilityHint(isOpen ? "Folds the month" : "Shows the month's notes")
            .accessibilityIdentifier("notes-month-\(month.first.key)")
            if isOpen {
                Divider().padding(.leading, WeekSpacing.card)
                ForEach(month.notes) { note in
                    NavigationLink {
                        NoteView(habit: habit, day: note.day, linksDay: true)
                    } label: {
                        HStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: WeekSpacing.label) {
                                HStack(spacing: 6) {
                                    Text(note.title).font(.body.weight(.medium)).foregroundStyle(.primary)
                                    if let relative = note.relative {
                                        Text(relative).font(.subheadline).foregroundStyle(.secondary)
                                    }
                                }
                                Text(note.text).font(.subheadline).foregroundStyle(.secondary)
                                    .lineLimit(2).multilineTextAlignment(.leading)
                            }
                            Spacer(minLength: WeekSpacing.tight)
                            Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary)
                        }
                        .padding(.horizontal, WeekSpacing.card)
                        .padding(.vertical, 10)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(PageRowStyle())
                    .accessibilityIdentifier("note-\(note.day.key)")
                    if note.id != month.notes.last?.id {
                        Divider().padding(.leading, WeekSpacing.card)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.card, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
