import SwiftUI
import UniformTypeIdentifiers

/// Restore from a Backup File: the file picker, the merge that only adds, and what it added (report "Export and
/// Backup"). Used from the first screen of a fresh install, for people who have used Habits before (report "The First
/// Run — Start in One Tap", 30 Sep; Data Safety B4: never make someone set up from scratch before they can restore).
struct RestoreBackup: ViewModifier {
    @Binding var isPresented: Bool
    @Environment(HabitStore.self) private var store
    @State private var message: SettingsView.DataMessage?

    func body(content: Content) -> some View {
        content
            .fileImporter(isPresented: $isPresented, allowedContentTypes: [.item]) { result in
                guard case .success(let url) = result else { return }
                Task { @MainActor in
                    do {
                        message = Self.summary(try await store.restore(from: url))
                    } catch {
                        message = SettingsView.DataMessage(title: "Couldn't Restore", text: error.localizedDescription)
                    }
                }
            }
            .alert(item: $message) { Alert(title: Text($0.title), message: Text($0.text)) }
    }

    /// "Added 3 habits and 412 logged entries. Nothing already here was changed." or "Nothing New".
    static func summary(_ added: (habits: Int, entries: Int)) -> SettingsView.DataMessage {
        if added.habits + added.entries == 0 {
            return SettingsView.DataMessage(title: "Nothing New", text: "Everything in this backup is already on this iPhone.")
        }
        let habits = added.habits == 1 ? "1 habit" : "\(added.habits) habits"
        let entries = added.entries == 1 ? "1 logged entry" : "\(added.entries) logged entries"
        return SettingsView.DataMessage(title: "Restored", text: "Added \(habits) and \(entries). Nothing already here was changed.")
    }
}

extension View {
    func restoreBackup(isPresented: Binding<Bool>) -> some View {
        modifier(RestoreBackup(isPresented: isPresented))
    }
}
