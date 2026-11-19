import SwiftUI

/// Search one habit's notes (Figma's Notes search, 1053:9079), from History's Search notes: iOS's own search field,
/// active from the start with the keyboard up, and its ✕ to leave, as Habits & Tasks' search. Before a word, one line
/// says what it looks through; then every day whose note has the words, newest first, under a count ("2 notes"), the
/// words in bold; a row opens its day. No match: "No Notes with “swim”", pointing to Go to Date… for finding a day.
struct NotesSearchPage: View {
    let habit: Habit
    /// History's days that have a note, newest first (`HabitPageModel.noteHistory`).
    let months: [HistoryMonth]
    /// The chosen day; the habit page opens it once this page has gone.
    let open: (LocalDay) -> Void
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var query = ""
    /// The typed words once typing pauses (Rulebook S11): the results follow these, not every letter.
    @State private var words = ""
    @State private var active = true

    var body: some View {
        NavigationStack {
            NotesSearchResults(habit: habit, months: months, words: words, choose: choose)
                .equatable()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(Color(.systemGroupedBackground))
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $query, isPresented: $active, placement: .navigationBarDrawer(displayMode: .always),
                            prompt: "Search notes")
        }
        // The field's ✕ ends the search, and the page with it.
        .onChange(of: active) { _, isActive in if !isActive { dismiss() } }
        .onPerfCommand { action in if action == .close { active = false } }
        .task(id: query) {
            let typed = query.trimmingCharacters(in: .whitespacesAndNewlines)
            // Cleared or nothing yet: at once. Otherwise once typing pauses.
            if !typed.isEmpty && typed != words {
                try? await Task.sleep(for: .milliseconds(300))
                if Task.isCancelled { return }
            }
            words = typed
        }
    }

    /// The search ends first, so the keyboard is down before the page goes: closing the page with it up crashed
    /// UIKit's keyboard guide mid-transition (19 Nov 2026).
    private func choose(_ day: LocalDay) {
        open(day)
        active = false
    }
}

/// What the search shows for the settled words: a line before a word, the days whose note has them, or none found.
/// Equatable on what it shows, so a letter typed redraws only the field until the words settle.
private struct NotesSearchResults: View, Equatable {
    let habit: Habit
    let months: [HistoryMonth]
    let words: String
    let choose: (LocalDay) -> Void
    @Environment(HabitStore.self) private var store

    static func == (a: Self, b: Self) -> Bool { a.words == b.words && a.habit == b.habit && a.months == b.months }

    var body: some View { content }

    @ViewBuilder private var content: some View {
        if words.isEmpty {
            Text("Search \(habit.name)’s notes by any word.")
                .font(.subheadline).foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .padding(.top, 16)
        } else {
            let found = months.flatMap(\.days).filter { $0.note?.localizedStandardContains(words) == true }
            if found.isEmpty {
                ContentUnavailableView {
                    Label("No Notes with “\(words)”", systemImage: "magnifyingglass")
                } description: {
                    Text("Search looks through this habit’s notes. To find a day, use Go to Date…")
                }
            } else {
                List {
                    Section {
                        ForEach(found) { day in
                            Button { choose(day.day) } label: { row(day, words: words) }
                            .buttonStyle(.plain)
                            .accessibilityIdentifier("notes-result-\(day.day.key)")
                        }
                    } header: {
                        Text(found.count == 1 ? "1 note" : "\(found.count) notes")
                    }
                }
                .listStyle(.insetGrouped)
                .scrollDismissesKeyboard(.immediately)
            }
        }
    }

    /// History's day row, with the day's month ("Mon 19 Oct") since results span months.
    private func row(_ day: HistoryDay, words: String) -> some View {
        HStack(spacing: 16) {
            HeatSquare(cell: day.heat, color: habit.color, size: HeatSize.smallest, isToday: day.relative == "Today")
                .equatable()
                .frame(width: 36, height: 36)
            VStack(alignment: .leading, spacing: 0) {
                Text(day.title + " " + store.calendar.shortStandaloneMonthSymbols[day.day.month - 1])
                    .font(.body).foregroundStyle(.primary)
                Text(day.detail).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                if let note = day.note {
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Image(systemName: "note.text").foregroundStyle(.secondary)
                        Text(Self.marked(note, words)).lineLimit(2)
                    }
                    .font(.subheadline)
                    .padding(.top, 4)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary)
        }
        .padding(.vertical, 3)
        .contentShape(Rectangle())
        .accessibilityElement(children: .combine)
        .accessibilityHint("Opens the day")
    }

    /// The note with every place the words appear in bold (Figma's Results).
    static func marked(_ note: String, _ words: String) -> AttributedString {
        var text = AttributedString(note)
        var from = text.startIndex
        while from < text.endIndex,
              let range = text[from...].range(of: words, options: [.caseInsensitive, .diacriticInsensitive]) {
            text[range].font = .subheadline.weight(.semibold)
            from = range.upperBound
        }
        return text
    }
}
