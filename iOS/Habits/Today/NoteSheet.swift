import SwiftUI

/// Writing one note: a habit's note for a day, a note for the whole day, or nothing else. Optional, never
/// prompted; Save with empty text removes the note (report "Habit Notes and Day Notes", 29 Sep).
struct NoteSheet: View {
    let title: String
    /// "Read · Mon, 29 Sep": what the note belongs to.
    let subtitle: String
    let initial: String
    let onSave: (String) -> Void
    @Environment(\.dismiss) private var dismiss
    @State private var text: String
    @FocusState private var focused: Bool

    init(title: String, subtitle: String, initial: String, onSave: @escaping (String) -> Void) {
        self.title = title
        self.subtitle = subtitle
        self.initial = initial
        self.onSave = onSave
        _text = State(initialValue: initial)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    // A growing field in a Form stays above the keyboard as it scrolls (a fixed editor was hidden
                    // behind it in other apps, reviews `0cda4235…`).
                    TextField("Write a note", text: $text, axis: .vertical)
                        .lineLimit(4...)
                        .focused($focused)
                        .limitText($text, to: TextLimit.noteText)
                        .accessibilityIdentifier("note-field")
                } header: {
                    Text(subtitle)
                } footer: {
                    if let note = TextLimit.note(text, TextLimit.noteText) { Text(note).formNote() }
                }
                if !initial.isEmpty {
                    Section {
                        Button("Delete Note", role: .destructive) { onSave(""); dismiss() }
                    }
                }
            }
            .analyticsScreen(nil)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { onSave(text); dismiss() }
                        .fontWeight(.semibold)
                        .disabled(TextLimit.clean(text, TextLimit.noteText) == TextLimit.clean(initial, TextLimit.noteText))
                }
            }
            .onAppear { focused = true }
        }
        .presentationDetents([.medium, .large])
        // Solid, like the calendar sheet: see-through, Today's rows showed through behind the text (29 Sep).
        .presentationBackground(Color(.systemGroupedBackground))
    }

    /// "Today", "Yesterday", or "Mon, 29 Sep": the words people use for the last two days.
    static func dayText(_ day: LocalDay, today: LocalDay, calendar: Calendar) -> String {
        if day == today { return "Today" }
        if day == today.adding(days: -1, calendar: calendar) { return "Yesterday" }
        return day.date(calendar: calendar).formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated))
    }
}

/// One habit's notes, newest first; tap one to change it.
struct HabitNotesView: View {
    let habit: Habit
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var editing: LocalDay?

    var body: some View {
        NavigationStack {
            List {
                let notes = store.notes(of: habit)
                if notes.isEmpty {
                    ContentUnavailableView("No Notes", systemImage: "note.text",
                                           description: Text("Long-press the habit on any day and choose Add Note."))
                }
                ForEach(notes, id: \.day) { note in
                    Button { editing = note.day } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(NoteSheet.dayText(note.day, today: store.today(), calendar: store.calendar))
                                .font(.subheadline.weight(.semibold)).foregroundStyle(.secondary)
                            Text(note.text).foregroundStyle(.primary)
                        }
                        .padding(.vertical, 2)
                    }
                }
            }
            .analyticsScreen(nil)
            .navigationTitle("\(habit.name) Notes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { ToolbarItem(placement: .confirmationAction) { Button("Done") { dismiss() } } }
            .sheet(item: $editing) { day in
                NoteSheet(title: "Note", subtitle: habit.name + " · " + NoteSheet.dayText(day, today: store.today(), calendar: store.calendar),
                          initial: store.note(of: habit, on: day) ?? "") { store.setNote($0, of: habit, on: day) }
            }
        }
    }
}

extension LocalDay: Identifiable {
    nonisolated var id: String { key }
}
