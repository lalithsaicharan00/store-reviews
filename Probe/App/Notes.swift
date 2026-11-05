import SwiftUI

struct NoteEntry: View {
    var fullSheet = false
    var typed = true
    @State private var text = ""
    @FocusState private var focused: Bool
    var body: some View {
        NavigationStack {
            Group {
                if fullSheet {
                    VStack(alignment: .leading, spacing: 8) {
                        HabitRowLabel().padding(.horizontal, 20)
                        TextEditor(text: $text).focused($focused).scrollContentBackground(.hidden)
                            .padding(.horizontal, 15)
                            .overlay(alignment: .topLeading) { if text.isEmpty { Text("Note").foregroundStyle(.tertiary).padding(.horizontal, 20).padding(.top, 8).allowsHitTesting(false) } }
                    }
                    .background(Color(.systemBackground))
                } else {
                    Form {
                        Section { HabitRowLabel() }
                        Section {
                            TextField("Note", text: $text, axis: .vertical).lineLimit(6...12).focused($focused)
                        } footer: { Text("Saved on today, 21 Oct.") }
                    }
                }
            }
            .navigationTitle("Add Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button { } label: { Image(systemName: "xmark") } }
                ToolbarItem(placement: .confirmationAction) { Button("Add") { }.fontWeight(.semibold).disabled(text.isEmpty) }
            }
            .onAppear { if typed { text = "Office bottle was half full." }; DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { focused = true } }
        }
    }
}

struct NoteView: View {
    var body: some View {
        NavigationStack {
            Color.clear.navigationDestination(isPresented: .constant(true)) {
                Form {
                    Section { HStack { HabitRowLabel(); Spacer(); Text("21 Oct 2026").foregroundStyle(.secondary) } }
                    Section { Text("Office bottle was half full.") }
                    Section { Button("Delete Note", role: .destructive) { } }
                }
                .navigationTitle("Note").navigationBarTitleDisplayMode(.inline)
                .toolbar { ToolbarItem(placement: .topBarTrailing) { Button("Edit") { } } }
            }
        }
    }
}
