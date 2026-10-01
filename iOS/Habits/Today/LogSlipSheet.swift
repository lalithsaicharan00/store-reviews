import SwiftUI

/// "Log a Slip…" for a quit habit (Build Plan #60d; report §10.4): when it happened (now by default, any moment since
/// the habit's start) and an optional note. Saved as an event with its own time, so the run history, slip counts and
/// the slip list are true. Editing "Started" stays only for fixing a wrong start. Never "relapse" or "reset".
struct LogSlipSheet: View {
    let habit: Habit
    /// The saved slip, for Undo.
    let onSaved: (UUID) -> Void
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var moment = Date.now
    @State private var note = ""

    var body: some View {
        let earliest = min(habit.createdAt, habit.quitSince ?? habit.createdAt)
        NavigationStack {
            Form {
                Section {
                    DatePicker("When", selection: $moment, in: earliest...Date.now, displayedComponents: [.date, .hourAndMinute])
                        .accessibilityIdentifier("slip-when")
                } footer: {
                    Text("The run before it is kept, and a new one starts from this moment.")
                }
                Section("Note") {
                    TextField("What happened (optional)", text: $note, axis: .vertical)
                        .lineLimit(2...5)
                        .limitText($note, to: TextLimit.noteText)
                        .accessibilityIdentifier("slip-note")
                }
            }
            .analyticsScreen(nil)
            .navigationTitle("Log a Slip")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let id = store.logSlip(habit, at: min(moment, .now), note: note)
                        onSaved(id)
                        dismiss()
                    }
                    .accessibilityIdentifier("slip-save")
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
}

/// "Slip logged · Undo", shown for a few seconds after saving a slip (report §10.4: Undo right after).
struct SlipUndoLine: View {
    let id: UUID
    let onDone: () -> Void
    @Environment(HabitStore.self) private var store

    var body: some View {
        HStack(spacing: 8) {
            Text("Slip logged").font(.subheadline).foregroundStyle(.secondary)
            Button("Undo") {
                store.undoEntry(id)
                onDone()
            }
            .font(.subheadline.weight(.semibold))
            .buttonStyle(.borderless)
            .accessibilityIdentifier("slip-undo")
        }
        .task(id: id) {
            try? await Task.sleep(for: .seconds(8))
            onDone()
        }
    }
}
