import Core
import SwiftUI
import UIKit

/// Backup & Sync (Figma 1178:960: Backed up, Not backed up, Backed up · end of the list; 21 Nov 2026). **What people
/// want to see first is whether their habits are safe** (W6; 14 of 44 reviews of iCloud failing in habit apps: "sync
/// stopped and the app said nothing"), so one Card notice leads with that and its one fix; then Restore, Export, and
/// the two deletes in red. Figma's variants are this one screen's states: the card says Backed Up or Not Backed Up, and
/// the end of the list is it scrolled.
///
/// The card shows more states than Figma draws, because the data rules need them (D3, D4): a question iCloud is waiting
/// on (another Apple Account, data removed from iCloud), a full iCloud, iCloud off or not allowed, or a backup that
/// can't be written all take the card's place with their own words and fix, from the same `CloudStatus` Today's card
/// reads. Gone with Figma: the Devices section (every feature is free, so there's no one-device plan to explain), Import
/// a Backup File (Restore from a Backup opens files too) and Google Drive (the iPhone backs up to iCloud only, D4).
/// Undo Last Restore stays, as a row under Restore, only while there's a restore to undo (D5).
struct ICloudPage: View {
    @Environment(BackupCenter.self) private var backup
    @Environment(CloudSync.self) private var cloud
    @Environment(HabitStore.self) private var store
    /// A spreadsheet to hand to Numbers or Excel: the share sheet.
    @State private var sharing: URL?
    /// A backup file to keep: iOS's own Save to Files (Figma's system part 1179:1034).
    @State private var saving: URL?
    @State private var message: BackupAlert?
    @State private var confirmUndo = false
    @State private var confirmErase = false
    @State private var confirmDelete = false
    @State private var showRestore = false

    var body: some View {
        List {
            Section {
                card
            } footer: {
                if let small = smallPrint { Text(small) }
            }

            Section("Restore") {
                NavigationLink { RestoreStartView() } label: {
                    SettingsRow(symbol: "arrow.counterclockwise", title: "Restore from a Backup", line: "From iCloud or a file")
                }
                .accessibilityIdentifier("backup-restore")
                if backup.undoFile != nil {
                    Button { confirmUndo = true } label: {
                        SettingsRow(symbol: "arrow.uturn.backward", title: "Undo Last Restore", line: "Back to just before it")
                    }
                    .accessibilityIdentifier("backup-undo")
                }
            }

            Section("Export") {
                Button { Task { await saveFile() } } label: {
                    SettingsRow(symbol: "square.and.arrow.down", title: "Save a Backup File", line: "To restore later, on any phone")
                }
                .accessibilityIdentifier("backup-save")
                Button { Task { await exportSpreadsheet() } } label: {
                    SettingsRow(symbol: "tablecells", title: "Export a Spreadsheet (CSV)", line: "To open in Numbers or Excel")
                }
                .accessibilityIdentifier("backup-export-csv")
            }

            Section {
                if showsDelete {
                    Button { confirmDelete = true } label: {
                        SettingsRow(symbol: "trash", title: "Delete My Data from iCloud…", line: "This \(DeviceIdentity.name) keeps everything",
                                    tint: .destructive)
                    }
                    .accessibilityIdentifier("cloud-delete")
                }
                Button { confirmErase = true } label: {
                    SettingsRow(symbol: "trash", title: "Erase All My Data…", line: "From this \(DeviceIdentity.name)", tint: .destructive)
                }
                .accessibilityIdentifier("backup-erase")
            }
        }
        .listStyle(.insetGrouped)
        // As on Settings: iOS's own room above a header makes Figma's 24 between sections 8 here.
        .listSectionSpacing(8)
        .contentMargins(.top, 8, for: .scrollContent)
        .analyticsScreen(.backupSync)
        .navigationTitle("Backup & Sync")
        .navigationBarTitleDisplayMode(.inline)
        .task { await backup.runIfDue() }
        .navigationDestination(isPresented: $showRestore) { RestoreStartView() }
        .onPerfCommand { action in
            if action == .openRestore { showRestore = true }
        }
        .sheet(item: Binding(get: { sharing.map(SharedBackup.init) }, set: { sharing = $0?.url })) { item in
            ShareFileSheet(url: item.url, onFinish: { sharing = nil })
        }
        .sheet(item: Binding(get: { saving.map(SharedBackup.init) }, set: { saving = $0?.url })) { item in
            SaveToFiles(url: item.url) { saving = nil }.ignoresSafeArea()
        }
        .alert(item: $message) { Alert(title: Text($0.title), message: Text($0.text)) }
        // Two choices only, the action in red (D9): where the habits stay is said in the words, not in more buttons.
        .alert("Delete Your Data from iCloud?", isPresented: $confirmDelete) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) { Task { await deleteFromICloud() } }
                .accessibilityIdentifier("cloud-delete-confirm")
        } message: {
            Text("Your habits, logs and backup files are removed from iCloud, for all your devices. This \(DeviceIdentity.name) keeps everything.")
        }
        .alert("Erase Everything on This \(DeviceIdentity.name)?", isPresented: $confirmErase) {
            Button("Cancel", role: .cancel) {}
            Button("Erase", role: .destructive) { Task { await erase() } }
                .accessibilityIdentifier("backup-erase-confirm")
        } message: {
            Text("Your habits, logs, notes and settings leave this \(DeviceIdentity.name). iCloud sync is turned off here; your iCloud and any backup files you saved keep their copies.")
        }
        .alert("Undo the Last Restore?", isPresented: $confirmUndo) {
            Button("Cancel", role: .cancel) {}
            Button("Undo Restore") { Task { await undo() } }
        } message: {
            Text("This \(DeviceIdentity.name) goes back to exactly how it was just before the restore.")
        }
    }

    // MARK: The card (§13.3, §17)

    /// What the card says, in order: a backup that can't be written, then anything iCloud is waiting on the person for,
    /// then iCloud not there at all, then Figma's two: Backed Up, or Not Backed Up.
    @ViewBuilder private var card: some View {
        let status = CloudStatus.of(cloud, isPlus: store.isPlus)
        if let issue = backup.issue {
            CardNotice(symbol: "exclamationmark.icloud", title: issue.title, message: issue.text, id: "backup-status") {
                if issue.fix == .openSettings || issue.fix == .manageStorage {
                    Button(issue.fixLabel) { openSettings() }.accessibilityIdentifier("backup-fix")
                }
            }
        } else if cloud.attention || Self.speaksForItself(cloud.phase) {
            CardNotice(symbol: status.symbol, title: status.title, message: status.line, problem: status.needsYou, id: "cloud-status") {
                actions
            }
        } else if let last = Self.lastBackedUp(backup: backup, cloud: cloud) {
            CardNotice(symbol: "checkmark.icloud", title: "Backed Up",
                       message: BackupWords.at(last) + ", to your iCloud. It backs up by itself as you go.",
                       problem: false, id: "cloud-status") {
                Button("Back Up Now") { Task { await backUpNow() } }
                    .disabled(backup.working || cloud.working)
                    .accessibilityIdentifier("backup-now")
            }
        } else if status.busy {
            CardNotice(symbol: status.symbol, title: status.title, message: status.line, problem: false, id: "cloud-status") {
                EmptyView()
            }
        } else {
            CardNotice(symbol: "icloud.slash", title: "Not Backed Up",
                       message: "Your habits are only on this \(DeviceIdentity.name). Back them up to your iCloud to keep them safe.",
                       id: "cloud-status") {
                Button("Back Up to iCloud") { Task { await backUpToICloud() } }
                    .disabled(backup.working || cloud.working)
                    .accessibilityIdentifier("cloud-turn-on")
            }
        }
    }

    /// iCloud states the plain card can't speak for: signed out, not allowed, unavailable, deleted, or another phone.
    private static func speaksForItself(_ phase: CloudSync.Phase) -> Bool {
        switch phase {
        case .off(.noAccount), .off(.restricted), .off(.unavailable), .off(.deleted), .otherDevice: true
        default: false
        }
    }

    /// The newer of the last checked backup file and the last sync: either one means the habits are in iCloud.
    static func lastBackedUp(backup: BackupCenter?, cloud: CloudSync?) -> Date? {
        [backup?.lastGood, cloud?.lastSynced].compactMap { $0 }.max()
    }

    /// The card's fix for a state Figma doesn't draw. A question keeps both of its answers (D3), side by side.
    @ViewBuilder private var actions: some View {
        switch cloud.phase {
        case .starting, .off(.turnedOff):
            EmptyView()
        case .off(.noAccount), .off(.restricted):
            Button("Open Settings") { openSettings() }
                .accessibilityIdentifier("cloud-open-settings")
        case .off(.unavailable):
            Button("Try Again") { Task { await cloud.syncNow() } }
                .accessibilityIdentifier("cloud-sync-now")
        case .off(.deleted):
            Button("Back Up to iCloud Again") { Task { await backup.turnICloudOn() } }
                .disabled(cloud.working)
                .accessibilityIdentifier("cloud-turn-on")
        case .asking(.removed):
            HStack {
                Button("Back Up Again") { Task { await cloud.backUpAgain() } }
                    .disabled(cloud.working)
                    .accessibilityIdentifier("cloud-back-up-again")
                Button("Not Now") { Task { await cloud.notNowAfterRemoval() } }
                    .accessibilityIdentifier("cloud-not-now")
            }
        case .asking(.differentAccount):
            ViewThatFits(in: .horizontal) {
                HStack { differentAccountAnswers }
                VStack(alignment: .leading) { differentAccountAnswers }
            }
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
            }
        }
    }

    @ViewBuilder private var differentAccountAnswers: some View {
        Button("Add to This Account’s iCloud") { Task { await cloud.addToThisAccount() } }
            .disabled(cloud.working)
            .accessibilityIdentifier("cloud-add-account")
        Button("Keep on This \(DeviceIdentity.name) Only") { Task { await cloud.keepOnThisIPhoneOnly() } }
            .accessibilityIdentifier("cloud-keep-local")
    }

    /// Changes that can't go, or came from a newer version: said, never hidden (§7, §8).
    private var smallPrint: String? {
        var parts: [String] = []
        if cloud.keptAside > 0 {
            parts.append("\(cloud.keptAside) \(cloud.keptAside == 1 ? "change can’t" : "changes can’t") be sent to iCloud. \(cloud.keptAside == 1 ? "It’s" : "They’re") kept on this \(DeviceIdentity.name).")
        }
        if cloud.unreadable > 0 {
            parts.append("Some changes from a newer version of \(Onboarding.appName) are kept until you update.")
        }
        return parts.isEmpty ? nil : parts.joined(separator: " ")
    }

    /// Delete My Data from iCloud: while there's an iCloud to delete from.
    private var showsDelete: Bool {
        switch cloud.phase {
        case .on, .otherDevice, .asking, .off(.turnedOff): true
        default: false
        }
    }

    // MARK: Doing

    private func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) { UIApplication.shared.open(url) }
    }

    private func moveHere() async {
        if !(await cloud.moveHere()) {
            message = BackupAlert(title: "Couldn’t Move Here", text: "Your habits are safe. Check your connection and try again.")
        }
    }

    /// "just now", "today 09:14", "yesterday 21:40", or a date (Restore's list of copies and the backup files' names).
    static func when(_ date: Date) -> String {
        if Date.now.timeIntervalSince(date) < 120 { return "just now" }
        let time = date.formatted(date: .omitted, time: .shortened)
        if Calendar.current.isDateInToday(date) { return "today " + time }
        if Calendar.current.isDateInYesterday(date) { return "yesterday " + time }
        return date.formatted(date: .abbreviated, time: .shortened)
    }

    /// Not Backed Up's one fix: iCloud sync on if it was turned off here, then a backup now.
    private func backUpToICloud() async {
        if cloud.phase == .off(.turnedOff) { await backup.turnICloudOn() }
        await backUpNow()
    }

    private func backUpNow() async {
        if !(await backup.backUpNow()), backup.issue == nil {
            message = BackupAlert(title: "Not Backed Up Yet", text: "Couldn’t back up just now. Your habits are safe on this \(DeviceIdentity.name).")
        }
    }

    private func saveFile() async {
        do { saving = try await backup.makeFile() } catch {
            message = BackupAlert(title: "Couldn’t Make the File", text: "Your habits are safe on this \(DeviceIdentity.name). Please try again.")
        }
    }

    /// A spreadsheet for reading the history (not for restoring): one row per day's entry or note.
    private func exportSpreadsheet() async {
        let ticket = store.analytics.ticket
        await store.flush()
        guard store.problem == nil, store.isStorageReady else {
            backup.recordBackup("export", format: "csv", succeeded: false, ticket: ticket)
            message = BackupAlert(title: "Couldn’t Export", text: HabitStore.BackupError.pendingSave.localizedDescription)
            return
        }
        let rows = DataExport.rows(from: store), day = store.today().key
        do {
            sharing = try await Task.detached { try DataExport.file(rows: rows, day: day) }.value
            backup.recordBackup("export", format: "csv", succeeded: true, ticket: ticket)
        } catch {
            backup.recordBackup("export", format: "csv", succeeded: false, ticket: ticket)
            message = BackupAlert(title: "Couldn’t Export", text: "Your habits are safe on this \(DeviceIdentity.name). Please try again.")
        }
    }

    private func deleteFromICloud() async {
        do {
            try await backup.deleteFromICloud(eraseThisDevice: false)
            message = BackupAlert(title: "Deleted from iCloud", text: "Your data is gone from iCloud. This \(DeviceIdentity.name) keeps everything, and nothing goes to iCloud until you turn it on again.")
        } catch {
            message = BackupAlert(title: "Couldn’t Delete from iCloud", text: "Nothing was changed. Check your connection and try again.")
        }
    }

    private func erase() async {
        do {
            try await backup.eraseThisDevice()
            message = BackupAlert(title: "Erased", text: "Everything on this \(DeviceIdentity.name) is gone. You’re starting fresh.")
        } catch {
            message = BackupAlert(title: "Couldn’t Erase", text: "Nothing was changed. Please try again.")
        }
    }

    private func undo() async {
        do { try await backup.undoLastRestore() } catch {
            message = BackupAlert(title: "Couldn’t Undo", text: "Nothing was changed. Please try again.")
        }
    }
}

/// iOS's own Save to Files (Figma's system part 1179:1034): the file's name, where to save it, Save. The file is
/// copied, so the one the app made stays where it is until the share folder is cleaned.
struct SaveToFiles: UIViewControllerRepresentable {
    let url: URL
    let onFinish: () -> Void

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forExporting: [url], asCopy: true)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ picker: UIDocumentPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator { Coordinator(onFinish: onFinish) }

    final class Coordinator: NSObject, UIDocumentPickerDelegate {
        let onFinish: () -> Void
        init(onFinish: @escaping () -> Void) { self.onFinish = onFinish }
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) { onFinish() }
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) { onFinish() }
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
