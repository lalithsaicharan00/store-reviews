import SwiftUI

// The habit page's Notes tab (the user, 3 Oct 2026; research Notes: browse → read → edit). The habit's own dated notes,
// newest first, independent of whether the day was done. Reading never changes progress; editing is explicit.

/// Search and Add Note at the top, then a card per month that folds like History's, a row per day's note.
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
        HStack(spacing: WeekSpacing.tight) {
            NoteSearchField { query = $0 }
            Button { adding = true } label: {
                Label("Add Note", systemImage: "square.and.pencil")
            }
            // A secondary action like History's (Current Work 26): the filled style put white text on dark mode's
            // off-white ink.
            .buttonStyle(.bordered)
            .controlSize(.regular)
            .font(.subheadline.weight(.semibold))
            .accessibilityIdentifier("notes-add")
        }
        .pageItem()
        .sheet(isPresented: $adding) { NoteEditorView(habit: habit, day: today, editing: false) }
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

/// Reading one note (research Notes B): the date, the full text, then View Day and Delete Note. Edit is explicit, top
/// right; the keyboard stays closed while reading.
struct NoteReaderView: View {
    let habit: Habit
    let day: LocalDay
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var editing = false
    @State private var showDay = false
    @State private var confirmingDelete = false

    var body: some View {
        let calendar = store.calendar
        let date = day.date(calendar: calendar).formatted(.dateTime.weekday(.wide).day().month(.wide).year())
        ScrollView {
            VStack(alignment: .leading, spacing: WeekSpacing.card) {
                VStack(alignment: .leading, spacing: WeekSpacing.label) {
                    Text(date).font(.title3.weight(.semibold))
                    Text(habit.name).font(.subheadline).foregroundStyle(.secondary)
                }
                if let note = store.note(of: habit, on: day) {
                    Text(note)
                        .font(.body)
                        .textSelection(.enabled)
                        .fixedSize(horizontal: false, vertical: true)
                        .pageCard()
                        .accessibilityIdentifier("note-text")
                } else {
                    Text("This note was deleted.").foregroundStyle(.secondary).pageCard()
                }
                VStack(spacing: 0) {
                    Button { showDay = true } label: {
                        HStack {
                            Label("View Day", systemImage: "calendar").foregroundStyle(.primary)
                            Spacer()
                            Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary)
                        }
                        .padding(.horizontal, WeekSpacing.card)
                        .frame(minHeight: 48)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(PageRowStyle())
                    .accessibilityIdentifier("note-view-day")
                    Divider().padding(.leading, WeekSpacing.card)
                    Button(role: .destructive) { confirmingDelete = true } label: {
                        HStack {
                            Label("Delete Note", systemImage: "trash")
                            Spacer()
                        }
                        .padding(.horizontal, WeekSpacing.card)
                        .frame(minHeight: 48)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(PageRowStyle())
                    .foregroundStyle(.red)
                    .disabled(store.note(of: habit, on: day) == nil)
                    .accessibilityIdentifier("note-delete")
                }
                .background(Color.card, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            .padding(WeekSpacing.card)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Note")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") { editing = true }
                    .disabled(store.note(of: habit, on: day) == nil)
                    .accessibilityIdentifier("note-edit")
            }
        }
        .sheet(isPresented: $editing) { NoteEditorView(habit: habit, day: day, editing: true) }
        .sheet(isPresented: $showDay) { DaySheet(habit: habit, day: day) }
        .confirmationDialog("Delete this note?", isPresented: $confirmingDelete, titleVisibility: .visible) {
            Button("Delete Note", role: .destructive) {
                store.setNote("", of: habit, on: day)
                dismiss()
            }
        } message: {
            Text("The note for \(date) is deleted. That day's progress stays as it is.")
        }
    }
}

/// Writing a note (research Notes C): the date (today when adding; fixed when editing), a comfortable multi-line field,
/// Save and Cancel in reach. Leaving with unsaved text asks first, so an interrupted draft isn't lost by a swipe.
struct NoteEditorView: View {
    let habit: Habit
    let editing: Bool
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var day: LocalDay
    @State private var text: String
    @State private var initial: String
    @State private var confirmingDiscard = false
    @FocusState private var focused: Bool

    init(habit: Habit, day: LocalDay, editing: Bool) {
        self.habit = habit
        self.editing = editing
        _day = State(initialValue: day)
        _text = State(initialValue: "")
        _initial = State(initialValue: "")
    }

    private var dirty: Bool { TextLimit.clean(text, TextLimit.noteText) != TextLimit.clean(initial, TextLimit.noteText) }

    var body: some View {
        let calendar = store.calendar
        let today = store.today()
        let first = habit.kind == .quit ? store.quitStartDay(of: habit) : store.startDay(of: habit)
        NavigationStack {
            Form {
                Section {
                    if editing {
                        LabeledContent("Date", value: day.date(calendar: calendar).formatted(.dateTime.weekday(.wide).day().month(.wide).year()))
                    } else {
                        DatePicker("Date", selection: Binding(get: { day.date(calendar: calendar) }, set: { day = LocalDay($0, calendar: calendar) }),
                                   in: min(first, today).date(calendar: calendar)...today.date(calendar: calendar), displayedComponents: .date)
                            .accessibilityIdentifier("note-date")
                    }
                } footer: {
                    if !editing && !initial.isEmpty { Text("This day already has a note; you're changing it.") }
                }
                Section {
                    // A growing field in a Form stays above the keyboard as it scrolls (NoteSheet's lesson).
                    TextField("Write a note", text: $text, axis: .vertical)
                        .lineLimit(8...)
                        .focused($focused)
                        .limitText($text, to: TextLimit.noteText)
                        .accessibilityIdentifier("note-field")
                } footer: {
                    if let note = TextLimit.note(text, TextLimit.noteText) { Text(note).formNote() }
                }
            }
            .navigationTitle(editing ? "Edit Note" : "Add Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { if dirty { confirmingDiscard = true } else { dismiss() } }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { store.setNote(text, of: habit, on: day); dismiss() }
                        .fontWeight(.semibold)
                        .disabled(!dirty)
                        .accessibilityIdentifier("note-save")
                }
            }
            .confirmationDialog("Discard this note?", isPresented: $confirmingDiscard, titleVisibility: .visible) {
                Button("Discard Changes", role: .destructive) { dismiss() }
                Button("Keep Writing", role: .cancel) {}
            }
            .onAppear {
                let existing = store.note(of: habit, on: day) ?? ""
                text = existing
                initial = existing
                focused = true
            }
            .onChange(of: day) {
                // Another day: its own note, if it has one, unless something new has been written already.
                guard !dirty else { return }
                let existing = store.note(of: habit, on: day) ?? ""
                text = existing
                initial = existing
            }
        }
        .interactiveDismissDisabled(dirty)
        .presentationBackground(Color(.systemGroupedBackground))
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
                        NoteReaderView(habit: habit, day: note.day)
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
