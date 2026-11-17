import Core
import SwiftUI
import UniformTypeIdentifiers
import UIKit

// Restore from a Backup on the empty Today (Figma's onboarding flows 3, 6 and 7): Apple's file picker straight away,
// then Restoring Your Habits… while it's read and written, then Today with the habits back. A file that can't be used
// is an alert over Today that says what to do, and nothing has changed.
//
// Everything here is iOS's own: `.fileImporter` (the picker is drawn by iOS), `.fullScreenCover` with `ProgressView`,
// and `.alert`. The only thing of ours is the state that decides which one shows (`FileRestore`).

/// What a restore from a file is doing, read only by the modifier that shows it, so the empty Today never redraws for
/// it (S6).
@Observable
final class FileRestore {
    /// Apple's file picker is open.
    var choosing = false
    /// Restoring Your Habits… is on screen.
    private(set) var restoring = false
    /// Cancel shows until writing starts: a restore half written can't be stopped.
    private(set) var canCancel = true
    /// The alert over Today.
    var problem: BackupFileProblem?
    /// A problem found while Restoring was on screen: shown once it has gone, because iOS won't put an alert over a
    /// screen that's leaving.
    @ObservationIgnored private var problemAfterCover: BackupFileProblem?
    @ObservationIgnored private var work: Task<Void, Never>?

    /// Restore from a Backup, and Choose File in the alert.
    func choose() {
        problem = nil
        choosing = true
    }

    /// The person picked a file in the picker (or cancelled it, which does nothing).
    func picked(_ result: Result<[URL], any Error>, backup: BackupCenter?, store: HabitStore) {
        guard case .success(let urls) = result, let url = urls.first else { return }
        guard let backup else { return show(.unreadable) }
        work?.cancel()
        canCancel = true
        work = Task { await restore(url, backup, store) }
    }

    /// Cancel on Restoring Your Habits…: nothing has been written, so nothing has changed.
    func cancel() {
        guard canCancel else { return }
        work?.cancel()
        work = nil
        restoring = false
    }

    /// Restoring has left the screen: now the alert can show.
    func coverDismissed() {
        if let waiting = problemAfterCover {
            problemAfterCover = nil
            problem = waiting
        }
    }

    private func restore(_ url: URL, _ backup: BackupCenter, _ store: HabitStore) async {
        let started = ContinuousClock.now
        // A small file is checked before anything shows, so a wrong one goes straight to its alert (flow 6); a big one
        // shows Restoring while it's read.
        let showing = Task { [weak self] in
            try? await Task.sleep(for: .milliseconds(400))
            guard !Task.isCancelled else { return }
            self?.restoring = true
        }
        defer { showing.cancel() }

        let data = await Task.detached {
            let scoped = url.startAccessingSecurityScopedResource()
            defer { if scoped { url.stopAccessingSecurityScopedResource() } }
            return try? Data(contentsOf: url)
        }.value
        guard !Task.isCancelled else { return }
        guard let data, let pending = await backup.check(data) else { return show(.unreadable) }
        guard !Task.isCancelled else { return }
        if let reason = pending.check.problem { return show(BackupFileProblem(reason: reason)) }

        showing.cancel()
        restoring = true
        canCancel = false
        do {
            // Merge, never replace: on an empty iPhone it brings back everything, and if anything is here after all
            // (an archived habit, a log from a widget) it's kept (D rules). The restore keeps its undo file (D5).
            _ = try await backup.restore(pending, mode: .merge)
            // Restored, but is there anything to show? A backup with no habits in it is never shown as restored (D5):
            // without this the person is left on the same empty Today with no word of what happened. The store's
            // reload is queued behind the restore, so wait for it before looking.
            await store.flush()
            guard !store.habits.isEmpty else {
                canCancel = true
                return show(.noHabits)
            }
            Onboarding.markDone()
        } catch {
            canCancel = true
            return show(.couldNotRestore)
        }
        // At least a second on screen, so a quick restore reads as a step, not a flicker.
        let left = Duration.seconds(1) - (ContinuousClock.now - started)
        if left > .zero { try? await Task.sleep(for: left) }
        restoring = false
        canCancel = true
    }

    private func show(_ found: BackupFileProblem) {
        if restoring {
            problemAfterCover = found
            restoring = false
        } else {
            problem = found
        }
    }
}

/// Why a picked file wasn't restored. Nothing has changed in any of them. Each is one `.alert`: what happened as the
/// title, what to do as the message, Cancel on the left and a verb on the right (Figma's That isn't a backup, 4172:6415).
enum BackupFileProblem: Identifiable {
    case notABackup, newerVersion, repacked, damaged, unreadable, couldNotRestore, noHabits

    init(reason: String) {
        switch reason {
        case BackupProblem.companion.NEWER_VERSION: self = .newerVersion
        case BackupProblem.companion.REPACKED: self = .repacked
        case BackupProblem.companion.DAMAGED: self = .damaged
        default: self = .notABackup
        }
    }

    var id: Self { self }

    var title: String {
        switch self {
        case .notABackup: "This File Isn’t a Backup"
        case .newerVersion: "Update to Open This Backup"
        case .repacked: "This File Was Zipped Again"
        case .damaged: "This Backup Is Damaged"
        case .unreadable: "Couldn’t Open This File"
        case .couldNotRestore: "Couldn’t Restore This Backup"
        case .noHabits: "No Habits in This Backup"
        }
    }

    var message: String {
        switch self {
        case .notABackup: "Choose a file whose name starts with “Often Enough backup”."
        case .newerVersion: "Update Often Enough to bring it back. Nothing has changed yet."
        case .repacked: "Choose the original file Often Enough made. Nothing has changed."
        case .damaged: "Try another copy of your backup. Nothing has changed."
        case .unreadable: "Try again, or choose another copy. Nothing has changed."
        case .couldNotRestore: "Nothing has changed. Try again."
        case .noHabits: "There’s nothing in it to bring back. Choose another backup."
        }
    }

    /// The button on the right.
    var action: String { self == .newerVersion ? "Update" : "Choose File" }
}

/// The app's page on the App Store, for Update. Set the ID once the app exists in App Store Connect; until then Update
/// opens the App Store, where Updates is one tap away.
enum AppStoreLink {
    static let appID: String? = nil

    static var page: URL {
        if let appID, let url = URL(string: "itms-apps://apps.apple.com/app/id\(appID)") { return url }
        return URL(string: "itms-apps://apps.apple.com")!
    }
}

extension View {
    /// Apple's file picker, Restoring Your Habits… and the alerts, for one `FileRestore`.
    func restoresBackupFile(_ restore: FileRestore) -> some View {
        modifier(FileRestoreModifier(restore: restore))
    }
}

private struct FileRestoreModifier: ViewModifier {
    @Bindable var restore: FileRestore
    @Environment(BackupCenter.self) private var backup: BackupCenter?
    @Environment(HabitStore.self) private var store
    @Environment(\.openURL) private var openURL

    func body(content: Content) -> some View {
        content
            .fileImporter(isPresented: $restore.choosing, allowedContentTypes: [.zip]) { result in
                restore.picked(result.map { [$0] }, backup: backup, store: store)
            }
            .fullScreenCover(isPresented: Binding(get: { restore.restoring }, set: { if !$0 { restore.cancel() } }),
                             onDismiss: { restore.coverDismissed() }) {
                RestoringView(label: "Restoring Your Habits…", onCancel: restore.canCancel ? { restore.cancel() } : nil)
            }
            .alert(restore.problem?.title ?? "", isPresented: Binding(get: { restore.problem != nil },
                                                                      set: { if !$0 { restore.problem = nil } }),
                   presenting: restore.problem) { problem in
                Button("Cancel", role: .cancel) {}
                Button(problem.action) {
                    if problem == .newerVersion { openURL(AppStoreLink.page) } else { restore.choose() }
                }
            } message: { problem in
                Text(problem.message)
            }
    }
}

/// Figma's Restoring (582:7893): iOS's own spinner with its label, large, centred, on Today's background, and nothing
/// else. Cancel sits under it while there's something to cancel. No bars: there's nothing else to do here.
struct RestoringView: View {
    let label: String
    var onCancel: (() -> Void)?

    var body: some View {
        VStack(spacing: 20) {
            ProgressView { Text(label) }
                .controlSize(.large)
            if let onCancel {
                Button("Cancel", action: onCancel)
                    .tint(.ink)
                    .accessibilityIdentifier("restoring-cancel")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .interactiveDismissDisabled()
        .accessibilityIdentifier("restoring")
    }
}
