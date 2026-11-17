import SwiftUI

/// Figma's Today, no habits yet (547:2419): SwiftUI's own `ContentUnavailableView`, centred between the bars, with one
/// clear main action and a quiet second one. New Habit is `.borderedProminent` at `.controlSize(.large)` in Ink; Restore
/// from a Backup is a plain button in Ink that opens Apple's file picker straight away (`FileRestore`).
///
/// Nothing about iCloud here: habits in iCloud come back by themselves, and if iCloud is off the iCloud page says so.
/// The view's own spacing, sizes and fonts are iOS's; only the words, the symbol and the two actions are ours.
struct EmptyToday: View {
    var onNewHabit: () -> Void
    @State private var restore = FileRestore()

    var body: some View {
        ContentUnavailableView {
            Label("No Habits Yet", systemImage: "checklist")
        } description: {
            Text("Add something you’d like to do often enough.")
        } actions: {
            Button(action: onNewHabit) {
                // On Ink in both appearances: iOS's white label would vanish on dark mode's near-white Ink.
                Text("New Habit").foregroundStyle(Color.onInk)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .accessibilityIdentifier("empty-new-habit")
            Button("Restore from a Backup") { restore.choose() }
                .accessibilityIdentifier("empty-restore-backup")
        }
        .tint(.ink)
        .background(Color(.systemGroupedBackground))
        .restoresBackupFile(restore)
    }
}

/// Figma's Today, Nothing planned (791:35769): there are habits, but none on this day. The same `ContentUnavailableView`
/// as the empty Today, with New Habit as its one action and no restore (the habits are here).
struct NothingPlanned: View {
    let isToday: Bool
    var onNewHabit: () -> Void

    var body: some View {
        ContentUnavailableView {
            Label(isToday ? "Nothing Planned Today" : "Nothing Planned", systemImage: "calendar.badge.checkmark")
        } description: {
            Text("Your habits are planned for other days. Each shows up on its days.")
        } actions: {
            Button(action: onNewHabit) {
                Text("New Habit").foregroundStyle(Color.onInk)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .accessibilityIdentifier("nothing-planned-new-habit")
        }
        .tint(.ink)
        .background(Color(.systemGroupedBackground))
    }
}
