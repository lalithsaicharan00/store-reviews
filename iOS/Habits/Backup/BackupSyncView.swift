import Core
import SwiftUI
import UIKit
import UniformTypeIdentifiers

/// ≡ → Backup & Export (report "Backup & Export and Your Account — What People Look For", 9 Oct 2026; the user: "clean
/// and easy to understand, easy to scan"). In the order people come for it: whether they're safe (when and where, with
/// Back Up Now), where the copies are, getting habits back or onto a new iPhone, and files to keep. One line at most under
/// a row, never a paragraph explaining the screen; places named as people name them ("your account", "iCloud", "this
/// iPhone"), never "our server". No Sync row: sync is part of the account, and backup and sync are never mixed. Free, with
/// or without an account (D10).
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
                if let issue = backup.issue, issue.fix != .backUpNow {
                    Button(issue.fixLabel) { fix(issue.fix) }
                        .accessibilityIdentifier("backup-fix")
                }
                if backup.place != .phone {
                    Button("Back Up Now") { Task { await backUpNow() } }
                        .disabled(backup.working)
                        .accessibilityIdentifier("backup-now")
                }
            }

            Section("Backed Up To") {
                if backup.isSignedIn {
                    NavigationLink { AccountView() } label: {
                        LabeledContent("Your Account", value: backup.isPlus ? "Plus" : "Free")
                    }
                    .accessibilityIdentifier("backup-account")
                    if BackupFeatures.iCloudBackup {
                        Toggle(isOn: Binding(get: { backup.iCloudCopyOn }, set: { backup.setICloudCopy($0) })) {
                            Text("iCloud")
                            if let note = backup.secondCopyNote { Text(note) }
                        }
                        .accessibilityIdentifier("backup-icloud")
                    }
                } else {
                    Button { showSignIn = true } label: {
                        LabeledContent("Your Account") { Text("Sign In").foregroundStyle(Color.ink) }
                    }
                    .foregroundStyle(Color.primary)
                    .accessibilityIdentifier("backup-sign-in")
                }
            }

            Section("Restore & Move") {
                Button("Restore Habits From a Backup…") { showRestore = true }
                    .accessibilityIdentifier("backup-restore")
                NavigationLink { MoveToNewIPhoneView() } label: { Text("Move to a New iPhone") }
                    .accessibilityIdentifier("backup-move")
                if backup.undoFile != nil {
                    Button("Undo Last Restore") { confirmUndo = true }
                        .accessibilityIdentifier("backup-undo")
                }
            }

            Section("Export") {
                Button { Task { await share() } } label: {
                    TitleAndLine(title: "Save a Backup File", line: "To restore later, here or on another iPhone")
                }
                .accessibilityIdentifier("backup-save")
                Button { Task { await exportSpreadsheet() } } label: {
                    TitleAndLine(title: "Export a Spreadsheet (CSV)", line: "To open in Numbers, Excel or Google Sheets")
                }
                .accessibilityIdentifier("backup-export-csv")
            }

            if !backup.isSignedIn {
                Section {
                    Button("Erase All My Data…", role: .destructive) { confirmErase = true }
                        .accessibilityIdentifier("backup-erase")
                }
            }
        }
        .analyticsScreen(.backupSync)
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
            Text("Your habits, check-ins, notes and settings leave this iPhone and can't be brought back without a backup. Copies in iCloud and files you saved stay yours.")
        }
        .confirmationDialog("Undo the last restore?", isPresented: $confirmUndo, titleVisibility: .visible) {
            Button("Undo Restore") { Task { await undo() } }
        } message: {
            Text("This iPhone goes back to exactly how it was just before the restore.")
        }
    }

    /// Whether they're safe: when, and where (one line under it). A problem says what happened, in red, with its fix.
    @ViewBuilder private var status: some View {
        if let issue = backup.issue {
            Label { Text(issue.text) } icon: { Image(systemName: "exclamationmark.triangle.fill").foregroundStyle(.red) }
                .foregroundStyle(.red)
                .accessibilityElement(children: .combine)
                .accessibilityIdentifier("backup-status")
        } else if backup.working {
            Label("Backing up…", systemImage: "arrow.triangle.2.circlepath")
                .accessibilityElement(children: .combine)
                .accessibilityIdentifier("backup-status")
        } else if backup.place == .phone {
            Label {
                TitleAndLine(title: "Only on this iPhone", line: "Deleting the app deletes your habits")
            } icon: { Image(systemName: "iphone") }
                .accessibilityElement(children: .combine)
                .accessibilityIdentifier("backup-status")
        } else if let last = backup.lastGood {
            Label {
                TitleAndLine(title: "Backed up " + Self.when(last), line: placeText)
            } icon: { Image(systemName: "checkmark.circle.fill").foregroundStyle(.green) }
                .accessibilityElement(children: .combine)
                .accessibilityIdentifier("backup-status")
        } else {
            Label {
                TitleAndLine(title: "Not backed up yet", line: placeText)
            } icon: { Image(systemName: "clock") }
                .accessibilityElement(children: .combine)
                .accessibilityIdentifier("backup-status")
        }
    }

    /// Where the copies are, the way people say it.
    private var placeText: String {
        switch backup.place {
        case .account: backup.iCloudCopyOn ? "In your account and iCloud" : "In your account"
        case .iCloud: "In iCloud"
        case .phone: "Only on this iPhone"
        }
    }

    private func fix(_ fix: BackupCenter.Issue.Fix) {
        switch fix {
        case .signIn, .backUpToAccount: showSignIn = true
        case .tryNow, .backUpNow: Task { await backUpNow() }
        case .openSettings:
            if let url = URL(string: UIApplication.openSettingsURLString) { UIApplication.shared.open(url) }
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
            message = BackupAlert(title: "Not Backed Up Yet", text: "Couldn't reach your account. Your habits are safe on this iPhone and back up when you're online.")
        }
    }

    private func share() async {
        do { sharing = try await backup.makeFile() } catch {
            message = BackupAlert(title: "Couldn't Make the File", text: "Your habits are safe on this iPhone. Please try again.")
        }
    }

    /// A spreadsheet for reading the history (not for restoring): one row per day's entry or note.
    private func exportSpreadsheet() async {
        let ticket = store.analytics.ticket
        await store.flush()
        guard store.problem == nil, store.isStorageReady else {
            backup.recordBackup("export", format: "csv", succeeded: false, ticket: ticket)
            message = BackupAlert(title: "Couldn't Export", text: HabitStore.BackupError.pendingSave.localizedDescription)
            return
        }
        let rows = DataExport.rows(from: store), day = store.today().key
        do {
            sharing = try await Task.detached { try DataExport.file(rows: rows, day: day) }.value
            backup.recordBackup("export", format: "csv", succeeded: true, ticket: ticket)
        } catch {
            backup.recordBackup("export", format: "csv", succeeded: false, ticket: ticket)
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

/// A row's title with one plain line under it: what it's for, never a paragraph.
struct TitleAndLine: View {
    let title: String
    let line: String

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
            Text(line).font(.footnote).foregroundStyle(.secondary)
        }
        .accessibilityElement(children: .combine)
    }
}

/// Backup & Export → Move to a New iPhone: the two steps for how this iPhone backs up, and a backup file to send either
/// way (users show moving phones goes well with clear steps: report "Backup & Export and Your Account", §2). It used to
/// be a second "Save a Backup File" row that did the same thing.
struct MoveToNewIPhoneView: View {
    @Environment(BackupCenter.self) private var backup
    @State private var sharing: URL?
    @State private var failed = false

    var body: some View {
        Form {
            Section {
                ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                    Label(step, systemImage: "\(index + 1).circle")
                }
            }
            Section {
                Button("Send a Backup File") { Task { await send() } }
                    .accessibilityIdentifier("backup-move-send")
            } footer: {
                Text(backup.place == .phone ? "With AirDrop, Messages or Files." : "If the new iPhone uses a different account or Apple Account.")
            }
        }
        .navigationTitle("Move to a New iPhone")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: Binding(get: { sharing.map(SharedBackup.init) }, set: { sharing = $0?.url })) { item in
            ShareFileSheet(url: item.url, onFinish: { sharing = nil })
        }
        .alert("Couldn't Make the File", isPresented: $failed) {} message: {
            Text("Your habits are safe on this iPhone. Please try again.")
        }
    }

    private var steps: [String] {
        switch backup.place {
        case .account: ["Install Often Enough on the new iPhone", "Sign in with the same account"]
        case .iCloud: ["Install Often Enough on the new iPhone", "Choose Restore Habits From a Backup"]
        case .phone: ["Send a backup file to the new iPhone", "Open it there with Often Enough"]
        }
    }

    private func send() async {
        do { sharing = try await backup.makeFile() } catch { failed = true }
    }
}
