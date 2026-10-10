import Core
import SwiftUI
import UIKit
import UniformTypeIdentifiers

/// ≡ → iCloud & Backup (Architecture 11 §17; replaces the Account page and Backup & Export, 10 Oct 2026). **What people
/// want to see first is whether their habits are safe** (W6; 14 of 44 reviews of iCloud failing in habit apps: "sync
/// stopped and the app said nothing"), so the page leads with sync's true status, in every state it can be in, with the
/// one thing to do about it; then the devices; then the backup files, restoring and exporting; then deleting.
/// Native rows, monochrome chrome (U1, U2); never red unless something needs the person (U3).
struct ICloudPage: View {
    @Environment(BackupCenter.self) private var backup
    @Environment(CloudSync.self) private var cloud
    @Environment(HabitStore.self) private var store
    @State private var sharing: URL?
    @State private var message: BackupAlert?
    @State private var confirmUndo = false
    @State private var confirmErase = false
    @State private var confirmDelete = false
    @State private var importing = false
    @State private var pending: BackupCenter.Pending?
    @State private var showPlus = false
    @State private var showRestore = false

    var body: some View {
        Form {
            Section {
                CloudStatusRow()
                actions
            } footer: {
                if let small = smallPrint { Text(small) }
            }

            devices

            Section {
                backupStatus
                if backup.place != .phone && backup.issue?.fix != .openSettings {
                    Button("Back Up Now") { Task { await backUpNow() } }
                        .disabled(backup.working)
                        .accessibilityIdentifier("backup-now")
                }
                if BackupFeatures.googleDrive { googleDriveRow }
                NavigationLink { RestoreStartView() } label: {
                    IconRow(symbol: "clock.arrow.circlepath", title: "Restore From a Backup", line: "Any day of the last week, month or six months")
                }
                .accessibilityIdentifier("backup-restore")
                if backup.undoFile != nil {
                    Button("Undo Last Restore") { confirmUndo = true }
                        .accessibilityIdentifier("backup-undo")
                }
            } header: {
                Text("Backups")
            } footer: {
                Text("A copy of your habits each day, kept apart from sync, so anything can be brought back.")
            }

            Section("Export and Import") {
                Button { Task { await share() } } label: {
                    IconRow(symbol: "doc.zipper", title: "Save a Backup File", line: "To keep, or to use on another device")
                }
                .accessibilityIdentifier("backup-save")
                Button { Task { await exportSpreadsheet() } } label: {
                    IconRow(symbol: "tablecells", title: "Export a Spreadsheet (CSV)", line: "To open in Numbers, Excel or Google Sheets")
                }
                .accessibilityIdentifier("backup-export-csv")
                Button { importing = true } label: {
                    IconRow(symbol: "square.and.arrow.down", title: "Import a Backup File", line: "From Files, AirDrop or Mail")
                }
                .accessibilityIdentifier("backup-import")
            }
            .foregroundStyle(Color.primary)

            Section {
                if showsDelete {
                    Button("Delete My Data From iCloud…", role: .destructive) { confirmDelete = true }
                        .accessibilityIdentifier("cloud-delete")
                }
                Button("Erase All My Data…", role: .destructive) { confirmErase = true }
                    .accessibilityIdentifier("backup-erase")
            }
        }
        .analyticsScreen(.backupSync)
        .navigationTitle("iCloud & Backup")
        .navigationBarTitleDisplayMode(.inline)
        .task { await backup.runIfDue() }
        .navigationDestination(isPresented: $showPlus) { MenuPage(place: .plus) }
        .navigationDestination(isPresented: $showRestore) { RestoreStartView() }
        .onPerfCommand { action in
            if action == .openRestore { showRestore = true }
        }
        .sheet(item: Binding(get: { sharing.map(SharedBackup.init) }, set: { sharing = $0?.url })) { item in
            ShareFileSheet(url: item.url, onFinish: { sharing = nil })
        }
        .sheet(item: $pending) { pending in NavigationStack { RestorePreviewView(pending: pending) } }
        .fileImporter(isPresented: $importing, allowedContentTypes: [.zip, .data], allowsMultipleSelection: false) { result in
            guard case .success(let urls) = result, let url = urls.first else { return }
            Task { await importFile(url) }
        }
        .alert(item: $message) { Alert(title: Text($0.title), message: Text($0.text)) }
        .confirmationDialog("Delete your data from iCloud?", isPresented: $confirmDelete, titleVisibility: .visible) {
            Button("Save a Backup File First") { Task { await share() } }
            Button("Delete From iCloud", role: .destructive) { Task { await deleteFromICloud(eraseHere: false) } }
                .accessibilityIdentifier("cloud-delete-confirm")
            Button("Delete From iCloud and This \(DeviceIdentity.name)", role: .destructive) { Task { await deleteFromICloud(eraseHere: true) } }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Your habits, logs and backup files are removed from iCloud, for all your devices. This \(DeviceIdentity.name) keeps everything unless you delete it here too.")
        }
        .confirmationDialog("Erase everything on this \(DeviceIdentity.name)?", isPresented: $confirmErase, titleVisibility: .visible) {
            Button("Save a Backup File First") { Task { await share() } }
            Button("Erase Everything", role: .destructive) { Task { await erase() } }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Your habits, check-ins, notes and settings leave this \(DeviceIdentity.name) and can't be brought back without a backup. iCloud sync is turned off here; your iCloud and files you saved keep their copies.")
        }
        .confirmationDialog("Undo the last restore?", isPresented: $confirmUndo, titleVisibility: .visible) {
            Button("Undo Restore") { Task { await undo() } }
        } message: {
            Text("This \(DeviceIdentity.name) goes back to exactly how it was just before the restore.")
        }
    }

    // MARK: Status (§17)

    /// The one or two things to do about the status: never more.
    @ViewBuilder private var actions: some View {
        switch cloud.phase {
        case .starting:
            EmptyView()
        case .off(.noAccount), .off(.restricted):
            Button("Open Settings") { openSettings() }
                .accessibilityIdentifier("cloud-open-settings")
        case .off(.unavailable):
            Button("Try Again") { Task { await cloud.syncNow() } }
                .accessibilityIdentifier("cloud-sync-now")
        case .off(.turnedOff), .off(.deleted):
            Button(cloud.phase == .off(.deleted) ? "Back Up to iCloud Again" : "Turn On iCloud Sync") { Task { await backup.turnICloudOn() } }
                .disabled(cloud.working)
                .accessibilityIdentifier("cloud-turn-on")
        case .asking(.removed):
            Button("Back Up Again") { Task { await cloud.backUpAgain() } }
                .disabled(cloud.working)
                .accessibilityIdentifier("cloud-back-up-again")
            Button("Not Now") { Task { await cloud.notNowAfterRemoval() } }
                .accessibilityIdentifier("cloud-not-now")
        case .asking(.differentAccount):
            Button("Add to This Account's iCloud") { Task { await cloud.addToThisAccount() } }
                .disabled(cloud.working)
                .accessibilityIdentifier("cloud-add-account")
            Button("Keep on This \(DeviceIdentity.name) Only") { Task { await cloud.keepOnThisIPhoneOnly() } }
                .accessibilityIdentifier("cloud-keep-local")
        case .otherDevice:
            Button("Move Here") { Task { await moveHere() } }
                .disabled(cloud.working)
                .accessibilityIdentifier("cloud-move-here")
        case .on:
            if cloud.heldDeletes > 0 {
                Button("Apply the Changes") { Task { await cloud.applyHeldChanges() } }
                    .disabled(cloud.working)
                    .accessibilityIdentifier("cloud-apply-held")
            } else if cloud.outgoingDeletes > 0 {
                Button("Send to iCloud") { Task { await cloud.sendWaitingDeletes() } }
                    .accessibilityIdentifier("cloud-send-deletes")
            } else if cloud.isFull {
                Button("Manage Storage") { openSettings() }
                    .accessibilityIdentifier("cloud-manage-storage")
                Button("Try Again") { Task { await cloud.syncNow() } }
                    .accessibilityIdentifier("cloud-sync-now")
            } else if cloud.bringingIn == nil {
                Button("Sync Now") { Task { await cloud.syncNow() } }
                    .disabled(cloud.working)
                    .accessibilityIdentifier("cloud-sync-now")
            }
            if cloud.heldDeletes > 0 || cloud.outgoingDeletes > 0 {
                Button("Restore From a Backup Instead") { showRestore = true }
                    .accessibilityIdentifier("cloud-restore-instead")
            }
        }
    }

    /// Changes that can't go, or came from a newer version: said, never hidden (§7, §8).
    private var smallPrint: String? {
        var parts: [String] = []
        if cloud.keptAside > 0 {
            parts.append("\(cloud.keptAside) \(cloud.keptAside == 1 ? "change can't" : "changes can't") be sent to iCloud. \(cloud.keptAside == 1 ? "It's" : "They're") kept on this \(DeviceIdentity.name).")
        }
        if cloud.unreadable > 0 {
            parts.append("Some changes from a newer version of \(Onboarding.appName) are kept until you update.")
        }
        return parts.isEmpty ? nil : parts.joined(separator: " ")
    }

    // MARK: Devices (§12, §17)

    @ViewBuilder private var devices: some View {
        switch cloud.phase {
        case .on where store.isPlus:
            Section {
                ForEach(cloud.devices.sorted { ($0.id == cloud.deviceID ? 1 : 0, $0.lastSync) > ($1.id == cloud.deviceID ? 1 : 0, $1.lastSync) }) { device in
                    TitleAndLine(title: device.id == cloud.deviceID ? "This \(device.name)" : device.name,
                                 line: "Synced " + ICloudPage.when(device.id == cloud.deviceID ? (cloud.lastSynced ?? device.lastSync) : device.lastSync))
                        .accessibilityIdentifier("cloud-device")
                }
            } header: {
                Text("Devices")
            } footer: {
                Text("With Plus, every device signed in to your Apple Account stays in sync.")
            }
        case .on:
            Section {
                IconRow(symbol: DeviceIdentity.name == "iPad" ? "ipad" : "iphone", title: "This \(DeviceIdentity.name) is the one syncing", line: nil)
                    .accessibilityIdentifier("cloud-device")
                Button("See Plus") { showPlus = true }
                    .accessibilityIdentifier("cloud-see-plus")
            } header: {
                Text("Devices")
            } footer: {
                Text("The free plan syncs one device at a time. With Plus, every device stays in sync.")
            }
        case .otherDevice(let name):
            Section {
                IconRow(symbol: name.localizedCaseInsensitiveContains("iPad") ? "ipad" : "iphone",
                        title: "\(HabitCopy.capitalized(BackupCenter.yourDevice(name))) is the one syncing", line: nil)
                    .accessibilityIdentifier("cloud-device")
                Button("See Plus") { showPlus = true }
                    .accessibilityIdentifier("cloud-see-plus")
            } header: {
                Text("Devices")
            } footer: {
                Text("The free plan syncs one device at a time. This \(DeviceIdentity.name) keeps everything it has.")
            }
        default:
            EmptyView()
        }
    }

    /// Delete My Data From iCloud: while there's an iCloud to delete from.
    private var showsDelete: Bool {
        switch cloud.phase {
        case .on, .otherDevice, .asking, .off(.turnedOff): true
        default: false
        }
    }

    // MARK: Backups (§13.3)

    @ViewBuilder private var backupStatus: some View {
        if let issue = backup.issue {
            VStack(alignment: .leading, spacing: 8) {
                Label { Text(issue.text) } icon: { Image(systemName: "exclamationmark.triangle.fill").foregroundStyle(.red) }
                    .foregroundStyle(.red)
                    .accessibilityElement(children: .combine)
                    .accessibilityIdentifier("backup-status")
                if issue.fix == .openSettings || issue.fix == .manageStorage {
                    Button(issue.fixLabel) { openSettings() }.accessibilityIdentifier("backup-fix")
                }
            }
        } else if backup.working {
            Label("Backing up…", systemImage: "arrow.triangle.2.circlepath")
                .accessibilityElement(children: .combine)
                .accessibilityIdentifier("backup-status")
        } else if backup.place == .phone {
            Label { TitleAndLine(title: "Backup files: only on this \(DeviceIdentity.name)", line: "Its own daily copies") } icon: { Image(systemName: "iphone") }
                .accessibilityElement(children: .combine)
                .accessibilityIdentifier("backup-status")
        } else if let last = backup.lastGood {
            Label {
                TitleAndLine(title: "Backed up", line: HabitCopy.capitalized(Self.when(last)) + " · " + (backup.place == .googleDrive ? "Google Drive" : "iCloud"))
            } icon: { Image(systemName: "checkmark.circle") }
                .accessibilityElement(children: .combine)
                .accessibilityIdentifier("backup-status")
        } else {
            Label { TitleAndLine(title: "Not backed up yet", line: backup.place == .googleDrive ? "Google Drive" : "iCloud") } icon: { Image(systemName: "clock") }
                .accessibilityElement(children: .combine)
                .accessibilityIdentifier("backup-status")
        }
    }

    /// Google Drive (Current Work 76), shown only once it truly works (`BackupFeatures.googleDrive`).
    private var googleDriveRow: some View {
        NavigationLink { GoogleDriveChoiceView() } label: {
            IconRow(symbol: "externaldrive.badge.icloud", title: "Google Drive", line: backup.usesGoogleDrive ? "Your Google account" : "Instead of iCloud")
        }
        .accessibilityIdentifier("backup-google-drive")
    }

    // MARK: Doing

    private func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) { UIApplication.shared.open(url) }
    }

    private func moveHere() async {
        if !(await cloud.moveHere()) {
            message = BackupAlert(title: "Couldn't Move Here", text: "Your habits are safe. Check your connection and try again.")
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
            message = BackupAlert(title: "Not Backed Up Yet", text: "Couldn't back up just now. Your habits are safe on this \(DeviceIdentity.name).")
        }
    }

    private func share() async {
        do { sharing = try await backup.makeFile() } catch {
            message = BackupAlert(title: "Couldn't Make the File", text: "Your habits are safe on this \(DeviceIdentity.name). Please try again.")
        }
    }

    private func importFile(_ url: URL) async {
        let scoped = url.startAccessingSecurityScopedResource()
        defer { if scoped { url.stopAccessingSecurityScopedResource() } }
        guard let data = try? Data(contentsOf: url) else {
            message = BackupAlert(title: "Couldn't Open the File", text: "Nothing was changed.")
            return
        }
        if BackupCenter.isOlderBackupFile(data) {
            do {
                let added = try await backup.importOlderFile(url)
                message = BackupAlert(title: added.changed ? "Imported" : "Nothing to Add", text: added.changed
                    ? "Added \(added.habits) habits or tasks, \(added.entries) check-ins and \(added.settings) notes or settings. Everything already here was kept."
                    : "Everything in this file is already here. Nothing was changed.")
            } catch {
                message = BackupAlert(title: "Couldn't Import", text: error.localizedDescription)
            }
            return
        }
        pending = await backup.check(data)
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
            message = BackupAlert(title: "Couldn't Export", text: "Your habits are safe on this \(DeviceIdentity.name). Please try again.")
        }
    }

    private func deleteFromICloud(eraseHere: Bool) async {
        do {
            try await backup.deleteFromICloud(eraseThisDevice: eraseHere)
            message = BackupAlert(title: "Deleted From iCloud", text: eraseHere
                ? "Your data is gone from iCloud and from this \(DeviceIdentity.name)."
                : "Your data is gone from iCloud. This \(DeviceIdentity.name) keeps everything, and nothing goes to iCloud until you turn it on again.")
        } catch {
            message = BackupAlert(title: "Couldn't Delete From iCloud", text: "Nothing was changed. Check your connection and try again.")
        }
    }

    private func erase() async {
        do {
            try await backup.eraseThisDevice()
            message = BackupAlert(title: "Erased", text: "Everything on this \(DeviceIdentity.name) is gone. You're starting fresh.")
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

/// Sync's status (§17): one symbol, one title, one line. Its own view, so only it redraws as counts change.
struct CloudStatusRow: View {
    @Environment(CloudSync.self) private var cloud
    @Environment(HabitStore.self) private var store

    var body: some View {
        let status = CloudStatus.of(cloud, isPlus: store.isPlus)
        Label {
            TitleAndLine(title: status.title, line: status.line)
        } icon: {
            if status.busy {
                ProgressView()
            } else {
                Image(systemName: status.symbol).foregroundStyle(status.needsYou ? Color.red : Color.primary)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("cloud-status")
    }
}

/// The status words, as a plain function the checks read (CopyCheck: no blame, no "failed").
struct CloudStatus: Equatable {
    var title: String
    var line: String
    var symbol: String
    var busy = false
    var needsYou = false

    static func of(_ cloud: CloudSync, isPlus: Bool) -> CloudStatus {
        let here = DeviceIdentity.name
        switch cloud.phase {
        case .starting:
            return CloudStatus(title: "Checking iCloud…", line: "Your habits are on this \(here).", symbol: "icloud", busy: true)
        case .off(.noAccount):
            return CloudStatus(title: "iCloud is off", line: "Not backed up to iCloud. Your habits are on this \(here). Sign in to iCloud in Settings to sync them.", symbol: "icloud.slash")
        case .off(.restricted):
            return CloudStatus(title: "iCloud isn't allowed on this \(here)", line: "Screen Time or this \(here)'s settings don't allow it. Your habits are on this \(here).", symbol: "icloud.slash")
        case .off(.unavailable):
            return CloudStatus(title: "iCloud isn't available right now", line: "Your habits are on this \(here). They sync when iCloud is back.", symbol: "icloud.slash")
        case .off(.turnedOff):
            return CloudStatus(title: "iCloud sync is off on this \(here)", line: "Your habits are on this \(here).", symbol: "icloud.slash")
        case .off(.deleted):
            return CloudStatus(title: "Your data was deleted from iCloud", line: "This \(here) keeps everything. Nothing goes to iCloud until you turn it on.", symbol: "icloud.slash")
        case .asking(.removed):
            return CloudStatus(title: "Your habits were removed from iCloud", line: "This \(here) still has all of them. Back them up to iCloud again?", symbol: "exclamationmark.icloud", needsYou: true)
        case .asking(.differentAccount):
            return CloudStatus(title: "This \(here) uses a different Apple Account", line: CloudWords.differentAccount(cloud.phase, here: cloud.habitCount()), symbol: "person.crop.circle.badge.questionmark", needsYou: true)
        case .otherDevice(let name):
            return CloudStatus(title: "\(HabitCopy.capitalized(BackupCenter.yourDevice(name))) is the one syncing", line: "The free plan syncs one device at a time. This \(here) keeps its habits.", symbol: "icloud")
        case .on:
            if cloud.heldDeletes > 0 {
                return CloudStatus(title: "Waiting for you: \(count(cloud.heldDeletes, "deletion", "deletions")) from iCloud",
                                   line: "Another device removed many habits or logs at once. Nothing is removed here until you say.", symbol: "hand.raised", needsYou: true)
            }
            if cloud.outgoingDeletes > 0 {
                return CloudStatus(title: "Waiting for you: \(count(cloud.outgoingDeletes, "deletion", "deletions"))",
                                   line: "This \(here) removed many habits or logs at once. iCloud keeps them until you say.", symbol: "hand.raised", needsYou: true)
            }
            if cloud.isFull {
                return CloudStatus(title: "iCloud is full", line: "\(count(cloud.waiting, "change", "changes")) waiting. Your habits are on this \(here).", symbol: "exclamationmark.icloud", needsYou: true)
            }
            if let fetched = cloud.bringingIn {
                return CloudStatus(title: "Bringing your habits from iCloud", line: "\(fetched.formatted()) so far", symbol: "icloud.and.arrow.down", busy: true)
            }
            if cloud.working {
                return CloudStatus(title: "Syncing…", line: "Your habits are on this \(here).", symbol: "icloud", busy: true)
            }
            if cloud.waiting > 0 {
                return CloudStatus(title: "Waiting for a connection", line: "\(count(cloud.waiting, "change", "changes")) not sent yet. Your habits are on this \(here).", symbol: "icloud")
            }
            if let last = cloud.lastSynced {
                return CloudStatus(title: "Synced with iCloud", line: HabitCopy.capitalized(ICloudPage.when(last)), symbol: "checkmark.icloud")
            }
            return CloudStatus(title: "Syncing with iCloud", line: "Your habits are on this \(here).", symbol: "icloud", busy: !cloud.firstLookDone)
        }
    }

    private static func count(_ n: Int, _ one: String, _ many: String) -> String { "\(n.formatted()) \(n == 1 ? one : many)" }
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
