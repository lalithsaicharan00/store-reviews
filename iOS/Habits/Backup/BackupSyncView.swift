import Core
import SwiftUI
import UIKit
import UniformTypeIdentifiers

/// ≡ → Backup & Export (Backup, Sync and Accounts §4.3; the menu's name, Design Rules "Sidebar"): one screen, two
/// clearly separate parts. Backup is "a copy so you never lose your habits"; sync is "the same habits on all your
/// devices". The two words are never mixed. Free, with or without an account: a backup file, a spreadsheet, restore.
struct BackupSyncView: View {
    @Environment(BackupCenter.self) private var backup
    @Environment(HabitStore.self) private var store
    @State private var showSignIn = false
    @State private var showRestore = false
    @State private var sharing: URL?
    @State private var message: BackupAlert?
    @State private var confirmUndo = false
    @State private var confirmErase = false

    var body: some View {
        Form {
            Section {
                status
                LabeledContent("Where", value: whereText)
                    .accessibilityIdentifier("backup-where")
                if BackupFeatures.iCloudBackup && backup.isSignedIn {
                    Toggle("Also a copy in your iCloud", isOn: Binding(get: { backup.iCloudCopyOn }, set: { backup.setICloudCopy($0) }))
                }
                if let note = backup.secondCopyNote {
                    Text(note).font(.footnote).foregroundStyle(.secondary)
                }
                if backup.place != .phone {
                    Button("Back Up Now") { Task { await backUpNow() } }
                        .disabled(backup.working)
                        .accessibilityIdentifier("backup-now")
                }
                Button("Restore…") { showRestore = true }
                    .accessibilityIdentifier("backup-restore")
                Button("Move to Another Device") { Task { await share() } }
                    .accessibilityIdentifier("backup-move")
                Button("Save a Backup File") { Task { await share() } }
                    .accessibilityIdentifier("backup-save")
                Button("Export a Spreadsheet (CSV)") { Task { await exportSpreadsheet() } }
                    .accessibilityIdentifier("backup-export-csv")
                if backup.undoFile != nil {
                    Button("Undo Last Restore") { confirmUndo = true }
                        .accessibilityIdentifier("backup-undo")
                }
            } header: {
                Text("Backup")
            } footer: {
                Text(backupFooter)
            }

            Section {
                if backup.isPlus {
                    LabeledContent("Sync", value: "On")
                    Text("Your habits sync to every device you sign in on.")
                        .font(.footnote).foregroundStyle(.secondary)
                } else {
                    Text("Sync is part of Plus. Your devices talk through your account.")
                        .accessibilityIdentifier("sync-plus-only")
                }
            } header: {
                Text("Sync")
            } footer: {
                Text("Sync keeps the same habits on all your devices.")
            }

            if !backup.isSignedIn {
                Section {
                    Button("Erase All My Data…", role: .destructive) { confirmErase = true }
                        .accessibilityIdentifier("backup-erase")
                } footer: {
                    Text("Removes your habits, check-ins, notes and settings from this iPhone, with its backup copies. Copies in your iCloud and files you exported stay yours.")
                }
            }

            Section("Account") {
                if backup.isSignedIn {
                    NavigationLink { AccountView() } label: {
                        LabeledContent("Your account", value: backup.isPlus ? "Plus" : "Free")
                    }
                    .accessibilityIdentifier("backup-account")
                } else {
                    Button("Sign In to Back Up to Your Account") { showSignIn = true }
                        .accessibilityIdentifier("backup-sign-in")
                }
            }

            if backup.place == .phone {
                Section("Before You Delete the App") {
                    Text("Deleting Often Enough removes its data from this iPhone. Reinstalling alone does not bring it back.")
                    Text("Sign in, or save a backup file somewhere outside the app (Files, AirDrop, Mail), first. After reinstalling, choose Restore.")
                    Text("Offload App in iPhone Settings keeps your data. Delete App removes it.")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("Backup & Export")
        .navigationBarTitleDisplayMode(.inline)
        .task { await backup.runIfDue() }
        .sheet(isPresented: $showSignIn) { SignInSheet() }
        .sheet(isPresented: $showRestore) { NavigationStack { RestoreStartView() } }
        .sheet(item: Binding(get: { sharing.map(SharedBackup.init) }, set: { sharing = $0?.url })) { item in
            ShareFileSheet(url: item.url, onFinish: { sharing = nil })
        }
        .alert(item: $message) { Alert(title: Text($0.title), message: Text($0.text)) }
        .confirmationDialog("Erase everything on this iPhone?", isPresented: $confirmErase, titleVisibility: .visible) {
            Button("Save a Backup File First") { Task { await share() } }
            Button("Erase Everything", role: .destructive) { Task { await erase() } }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Your habits and their history can't be brought back after this, unless you have a backup or an exported file.")
        }
        .confirmationDialog("Undo the last restore?", isPresented: $confirmUndo, titleVisibility: .visible) {
            Button("Undo Restore") { Task { await undo() } }
        } message: {
            Text("This iPhone goes back to exactly how it was just before the restore.")
        }
    }

    @ViewBuilder private var status: some View {
        if let issue = backup.issue {
            Label { Text(issue.text) } icon: { Image(systemName: "exclamationmark.triangle.fill").foregroundStyle(.red) }
                .foregroundStyle(.red)
                .accessibilityIdentifier("backup-status")
        } else if backup.working {
            Label("Backing up…", systemImage: "arrow.triangle.2.circlepath")
                .accessibilityIdentifier("backup-status")
        } else if backup.place == .phone {
            Label("Saved only on this iPhone", systemImage: "iphone")
                .accessibilityIdentifier("backup-status")
        } else if let last = backup.lastGood {
            Label { Text("Backed up · " + Self.when(last)) } icon: { Image(systemName: "checkmark.circle.fill").foregroundStyle(.green) }
                .accessibilityIdentifier("backup-status")
        } else {
            Label("Not backed up yet", systemImage: "clock")
                .accessibilityIdentifier("backup-status")
        }
    }

    private var whereText: String {
        switch backup.place {
        case .account: "Your account (our server)"
        case .iCloud: "Your iCloud"
        case .phone: "This iPhone only"
        }
    }

    private var backupFooter: String {
        switch backup.place {
        case .account: "A copy so you never lose your habits. On a new phone, just sign in. We store your habits only to back them up and sync them, never sell them or use them for ads."
        case .iCloud: "A copy so you never lose your habits, in your own iCloud. We can't see it."
        case .phone: "Your habits are in this iPhone's own backup (if it's on in your iPhone's settings). If this iPhone is lost without one, your habits are lost too. Sign in, or export a file, to keep a copy elsewhere."
        }
    }

    /// "just now", "today 09:14", "yesterday 21:40", or a date.
    static func when(_ date: Date) -> String {
        if Date.now.timeIntervalSince(date) < 120 { return "just now" }
        let time = date.formatted(date: .omitted, time: .shortened)
        if Calendar.current.isDateInToday(date) { return "today " + time }
        if Calendar.current.isDateInYesterday(date) { return "yesterday " + time }
        return date.formatted(date: .abbreviated, time: .shortened)
    }

    private func backUpNow() async {
        if !(await backup.backUpNow()), backup.issue == nil {
            message = BackupAlert(title: "Not Backed Up Yet", text: "We couldn't reach our server. Your habits are safe on this iPhone; we'll try again soon.")
        }
    }

    private func share() async {
        do { sharing = try await backup.makeFile() } catch {
            message = BackupAlert(title: "Couldn't Make the File", text: "Your habits are safe on this iPhone. Please try again.")
        }
    }

    /// A spreadsheet for reading the history (not for restoring): one row per day's entry or note.
    private func exportSpreadsheet() async {
        await store.flush()
        guard store.problem == nil, store.isStorageReady else {
            message = BackupAlert(title: "Couldn't Export", text: HabitStore.BackupError.pendingSave.localizedDescription)
            return
        }
        let rows = DataExport.rows(from: store), day = store.today().key
        do {
            sharing = try await Task.detached { try DataExport.file(rows: rows, day: day) }.value
        } catch {
            message = BackupAlert(title: "Couldn't Export", text: "Your habits are safe on this iPhone. Please try again.")
        }
    }

    private func erase() async {
        do {
            try await backup.eraseThisDevice()
            message = BackupAlert(title: "Erased", text: "Everything on this iPhone is gone. You're starting fresh.")
        } catch {
            message = BackupAlert(title: "Couldn't Erase", text: "Nothing was changed. Please try again.")
        }
    }

    private func undo() async {
        do { try await backup.undoLastRestore() } catch {
            message = BackupAlert(title: "Couldn't Undo", text: "Nothing was changed. Please try again.")
        }
    }
}

struct BackupAlert: Identifiable {
    let id = UUID()
    let title: String
    let text: String
}

private struct SharedBackup: Identifiable {
    let url: URL
    var id: URL { url }
}
