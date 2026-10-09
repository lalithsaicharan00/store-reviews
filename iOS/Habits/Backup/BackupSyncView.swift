import Core
import SwiftUI
import UIKit
import UniformTypeIdentifiers

/// ≡ → Backup & Export (Account and Backup Redesign, screens 4, 4b and 4c; Current Work 76; the user: "clean and easy
/// to understand, easy to scan"). The same rows in every state; only their order and words change. First whether
/// they're safe (when and where, with Back Up Now), then where the backup goes (one place at a time: iCloud without an
/// account, the account when signed in, saying why iCloud isn't used then), then moving and getting habits back, then
/// files to keep. One line at most under a row; places named as people name them, never "our server". Free, with or
/// without an account (D10).
struct BackupSyncView: View {
    @Environment(BackupCenter.self) private var backup
    @Environment(HabitStore.self) private var store
    @State private var showSignIn = false
    @State private var sharing: URL?
    @State private var message: BackupAlert?
    @State private var confirmUndo = false
    @State private var confirmErase = false
    @State private var details: BackupCenter.AccountDetails?
    /// Speed runs only (`PerfDriver` "account", "backup-page"): Your Account and Restore, pushed as their rows push them.
    @State private var perfAccount = false
    @State private var perfRestore = false

    var body: some View {
        Form {
            Section {
                status
                if let issue = backup.issue, issue.fix != .backUpNow {
                    Button(issue.fixLabel) { fix(issue.fix) }
                        .accessibilityIdentifier("backup-fix")
                }
                // Not while iCloud can't take it (full, off): the problem's own fix is the one thing to tap.
                if backup.place != .phone && !(backup.place == .iCloud && iCloudBlocked) {
                    Button("Back Up Now") { Task { await backUpNow() } }
                        .disabled(backup.working)
                        .accessibilityIdentifier("backup-now")
                }
            }

            if backup.isSignedIn {
                Section {
                    accountRow
                } header: {
                    Text("Backed Up To")
                } footer: {
                    Text(backup.isPlus ? "Keeps every device in sync, with a copy of each day for 90 days. iCloud and Google Drive are used only when you're not signed in."
                                       : "Backed up as you go, with the last 7 days kept. iCloud and Google Drive are used only when you're not signed in.")
                }
            } else {
                Section {
                    if BackupFeatures.iCloudBackup { iCloudRow }
                    if BackupFeatures.googleDrive { googleDriveRow }
                } header: {
                    Text("Backed Up To")
                } footer: {
                    Text(BackupFeatures.googleDrive ? "Backed up automatically as you go, to the one you choose." : "Backed up automatically as you go.")
                }
                Section {
                    accountRow
                } footer: {
                    Text("Optional. If you sign in, your habits are backed up to your account instead.")
                }
            }

            Section("Move and Restore") {
                NavigationLink { TransferSendView() } label: {
                    IconRow(symbol: "iphone", title: "Move to Another Device", line: "A new phone or tablet")
                }
                .accessibilityIdentifier("backup-move")
                NavigationLink { RestoreStartView() } label: {
                    IconRow(symbol: "icloud.and.arrow.down", title: "Restore From a Backup", line: nil)
                }
                .accessibilityIdentifier("backup-restore")
                if backup.undoFile != nil {
                    Button("Undo Last Restore") { confirmUndo = true }
                        .accessibilityIdentifier("backup-undo")
                }
            }

            Section("Export") {
                Button { Task { await share() } } label: {
                    IconRow(symbol: "doc.zipper", title: "Save a Backup File", line: "To restore later, here or on another device")
                }
                .accessibilityIdentifier("backup-save")
                Button { Task { await exportSpreadsheet() } } label: {
                    IconRow(symbol: "tablecells", title: "Export a Spreadsheet (CSV)", line: "To open in Numbers, Excel or Google Sheets")
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
        .task(id: backup.isSignedIn) {
            if backup.isSignedIn { details = try? await backup.accountDetails() } else { details = nil }
        }
        .navigationDestination(isPresented: $perfAccount) { AccountView() }
        .navigationDestination(isPresented: $perfRestore) { RestoreStartView() }
        .onPerfCommand { action in
            switch action {
            case .openAccount: perfAccount = true
            case .openRestore: perfRestore = true
            default: break
            }
        }
        .sheet(isPresented: $showSignIn) { SignInSheet(title: "Sign In") }
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
                TitleAndLine(title: "Only on this iPhone", line: "No backup copy yet")
            } icon: { Image(systemName: "iphone") }
                .accessibilityElement(children: .combine)
                .accessibilityIdentifier("backup-status")
        } else if let last = backup.lastGood {
            Label {
                TitleAndLine(title: backup.isPlus ? "Backed up and in sync" : "Backed up", line: HabitCopy.capitalized(Self.when(last)) + " · " + placeText)
            } icon: { Image(systemName: backup.place == .iCloud ? "icloud.fill" : "checkmark.circle.fill").foregroundStyle(Color.primary) }
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

    /// Where the backup is, the way people say it (one place at a time).
    private var placeText: String {
        switch backup.place {
        case .account:
            guard backup.isPlus, let count = details?.devices.filter(\.signedIn).count, count > 1 else { return "Your account" }
            return "Your account · \(count) devices"
        case .iCloud: return "iCloud"
        case .googleDrive: return "Google Drive"
        case .phone: return "Only on this iPhone"
        }
    }

    /// Your Account: opens the Account page (Back returns here). Signed out it's an option; signed in, the place.
    private var accountRow: some View {
        NavigationLink { AccountView() } label: {
            if backup.isSignedIn {
                IconRow(symbol: "person.crop.circle", title: "Your Account", line: accountLine)
            } else {
                HStack {
                    IconRow(symbol: "person.crop.circle", title: "Your Account", line: nil)
                    Spacer()
                    Text("Not signed in").foregroundStyle(.secondary)
                }
            }
        }
        .accessibilityIdentifier("backup-account")
    }

    private var accountLine: String {
        if backup.isPlus { return "Plus · Keeps your devices in sync" }
        guard let provider = details?.signIns.first?.provider else { return "Free" }
        return "Free · Signed in with " + AccountView.providerName(provider)
    }

    /// iCloud can't take a backup now (full, signed out, off for the app).
    private var iCloudBlocked: Bool {
        guard let state = backup.iCloudState else { return false }
        return state != .accountChanged
    }

    /// iCloud without an account: the place, ✓ when it's the one in use, or what's wrong (Full, Off, New Apple Account)
    /// with its fix.
    @ViewBuilder private var iCloudRow: some View {
        let state = backup.iCloudState
        let problem = backup.place == .phone || (state != nil && state != .accountChanged)
        let line: String = {
            if backup.place == .phone { return "Off · This iPhone isn't using iCloud" }
            switch state {
            case .full: return "Full"
            case .signedOut, .offForApp: return "Off"
            case .accountChanged: return "New Apple Account"
            case nil: return "Your Apple Account"
            }
        }()
        Button {
            if problem { if state == .full { fix(.backUpToAccount) } else { fix(.openSettings) } }
        } label: {
            HStack {
                IconRow(symbol: "icloud", title: "iCloud", line: line)
                Spacer()
                if !problem { Image(systemName: "checkmark").fontWeight(.semibold).foregroundStyle(Color.ink) }
            }
            .contentShape(Rectangle())
        }
        .foregroundStyle(state == .full ? Color.red : Color.primary)
        .accessibilityAddTraits(problem ? [] : .isSelected)
        .accessibilityIdentifier("backup-icloud-status")
    }

    /// Google Drive (Step 6 of Current Work 76), shown only once it truly works (`BackupFeatures.googleDrive`).
    private var googleDriveRow: some View {
        NavigationLink { GoogleDriveChoiceView() } label: {
            IconRow(symbol: "externaldrive.badge.icloud", title: "Google Drive", line: "Your Google account")
        }
        .accessibilityIdentifier("backup-google-drive")
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
            message = BackupAlert(title: "Not Backed Up Yet", text: backup.place == .account
                ? "Couldn't reach your account. Your habits are safe on this iPhone and back up when you're online."
                : "Couldn't back up to iCloud just now. Your habits are safe on this iPhone.")
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

/// A row's symbol, title and, at most, one plain line under it.
struct IconRow: View {
    let symbol: String
    let title: String
    let line: String?

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: symbol).font(.title3).frame(width: 28).accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                if let line { Text(line).font(.footnote).foregroundStyle(.secondary) }
            }
        }
        .accessibilityElement(children: .combine)
    }
}
