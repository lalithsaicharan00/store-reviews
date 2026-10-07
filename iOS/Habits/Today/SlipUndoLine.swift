import SwiftUI

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
