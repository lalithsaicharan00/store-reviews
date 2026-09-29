import SwiftUI

/// Writing a note: a bar docked above the keyboard, like Messages' compose bar. It names what the note is for
/// ("Water · Today") so the row it belongs to stays in view above it. Chosen over typing in the row (hidden by
/// the keyboard, too cramped for longer notes) and over a full screen (loses sight of the habit); research:
/// "Habit Notes and Day Notes", 29 Sep. Optional and never opened by itself.
struct NoteBar: View {
    /// "Water · Today", "Note for the day · Mon, 28 Sep".
    let title: String
    let initial: String
    let onSave: (String) -> Void
    let onClose: () -> Void
    @State private var text: String
    @FocusState private var focused: Bool

    init(title: String, initial: String, onSave: @escaping (String) -> Void, onClose: @escaping () -> Void) {
        self.title = title
        self.initial = initial
        self.onSave = onSave
        self.onClose = onClose
        _text = State(initialValue: initial)
    }

    private var changed: Bool { TextLimit.clean(text, TextLimit.noteText) != TextLimit.clean(initial, TextLimit.noteText) }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 12) {
                Label(title, systemImage: "note.text")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                Spacer(minLength: 8)
                if !initial.isEmpty {
                    // Deleting is one tap, not "clear the text" (the only way before, 29 Sep).
                    Button("Delete Note", systemImage: "trash", role: .destructive) { onSave(""); onClose() }
                        .labelStyle(.iconOnly)
                        .accessibilityIdentifier("note-bar-delete")
                }
                Button("Cancel") { onClose() }
                    .foregroundStyle(.secondary)
                Button("Save") { onSave(text); onClose() }
                    .fontWeight(.semibold)
                    .disabled(!changed)
                    .accessibilityIdentifier("note-bar-save")
            }
            .buttonStyle(.borderless)
            TextField("Add a note", text: $text, axis: .vertical)
                .lineLimit(1...6)
                .focused($focused)
                .limitText($text, to: TextLimit.noteText)
                .padding(.horizontal, 12).padding(.vertical, 9)
                .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 18))
                .accessibilityIdentifier("note-bar-field")
            if let note = TextLimit.note(text, TextLimit.noteText) { Text(note).font(.caption).foregroundStyle(.secondary) }
        }
        .padding(14)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 22))
        .shadow(color: .black.opacity(0.12), radius: 12, y: 2)
        .padding(.horizontal, 12)
        .padding(.bottom, 6)
        .onAppear { focused = true }
        .accessibilityIdentifier("note-bar")
    }
}
