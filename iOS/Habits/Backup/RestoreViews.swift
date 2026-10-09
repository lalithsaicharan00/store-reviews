import Core
import SwiftUI
import UniformTypeIdentifiers

/// Backup & Export → Restore From a Backup (Account and Backup Redesign, screens 6, 6b and 6c; Current Work 76): "Where
/// is your backup stored?", by state, each place naming what it holds. Without an account: iCloud (and Google Drive,
/// once it works) and Backup File. Signed in, the account is the only backup place: Your Account (a free account's
/// last 7 days, Plus's last 90) and Backup File. Restoring replaces the habits here, or with Plus on every device, and
/// keeps an undo for 30 days (D5).
struct RestoreStartView: View {
    @Environment(BackupCenter.self) private var backup
    @State private var importing = false
    @State private var pending: BackupCenter.Pending?
    @State private var failure: String?
    /// The result of importing an older backup file (one saved from Backup & Export before 1 Oct 2026).
    @State private var imported: String?

    var body: some View {
        Form {
            Section {
                if backup.isSignedIn {
                    NavigationLink { AccountCopiesView() } label: {
                        PlaceRow(symbol: "person.crop.circle", title: "Your Account",
                                 line: backup.isPlus ? "Any day in the last 90 days" : "Any of the last 7 days")
                    }
                    .accessibilityIdentifier("restore-account")
                } else {
                    if BackupFeatures.iCloudBackup {
                        NavigationLink { ICloudCopiesView() } label: {
                            PlaceRow(symbol: "icloud", title: "iCloud", line: "Find a backup saved in iCloud.")
                        }
                        .accessibilityIdentifier("restore-icloud")
                    }
                    if BackupFeatures.googleDrive {
                        NavigationLink { GoogleDriveCopiesView() } label: {
                            PlaceRow(symbol: "externaldrive.badge.icloud", title: "Google Drive", line: "Find a backup saved in Google Drive.")
                        }
                        .accessibilityIdentifier("restore-google-drive")
                    }
                }
                Button { importing = true } label: {
                    HStack {
                        PlaceRow(symbol: "doc.zipper", title: "Backup File", line: "Open a backup file you've saved.")
                        Spacer()
                        Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary)
                    }
                    .contentShape(Rectangle())
                }
                .accessibilityIdentifier("restore-import")
            } header: {
                Text("Where is your backup stored?").font(.body).foregroundStyle(.secondary).textCase(nil)
            } footer: {
                Text(backup.isPlus ? "Restoring replaces your habits on all your devices, since they stay in sync. You can undo it for 30 days."
                                   : "Restoring replaces the habits on this iPhone. You can undo it for 30 days.")
            }
            if let imported {
                Section { Text(imported).accessibilityIdentifier("restore-imported") }
            }
            if let failure {
                Section { Text(failure).foregroundStyle(.red) }
            }
        }
        .navigationTitle("Restore From a Backup")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $pending) { pending in
            NavigationStack { RestorePreviewView(pending: pending) }
        }
        .fileImporter(isPresented: $importing, allowedContentTypes: [.zip, .data], allowsMultipleSelection: false) { result in
            guard case .success(let urls) = result, let url = urls.first else { return }
            Task { await importFile(url) }
        }
    }

    static func counts(habits: Int, entries: Int) -> String {
        "\(habits) \(habits == 1 ? "habit" : "habits"), \(entries) \(entries == 1 ? "check-in" : "check-ins")"
    }

    private func importFile(_ url: URL) async {
        failure = nil
        let scoped = url.startAccessingSecurityScopedResource()
        defer { if scoped { url.stopAccessingSecurityScopedResource() } }
        guard let data = try? Data(contentsOf: url) else { failure = "Couldn't open the file."; return }
        imported = nil
        if BackupCenter.isOlderBackupFile(data) {
            // The earlier "Save a Backup File" made a copy of the database itself. It only ever adds what's missing.
            do {
                let added = try await backup.importOlderFile(url)
                imported = added.changed
                    ? "Added \(added.habits) habits or tasks, \(added.entries) check-ins and \(added.settings) notes or settings. Everything already here was kept."
                    : "Everything in this file is already here. Nothing was changed."
            } catch {
                failure = error.localizedDescription
            }
            return
        }
        pending = await backup.check(data)
    }
}

/// A place a backup is kept: its symbol, its name and one line.
private struct PlaceRow: View {
    let symbol: String
    let title: String
    let line: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: symbol).font(.title3).frame(width: 28).foregroundStyle(Color.primary).accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 2) {
                Text(title).foregroundStyle(Color.primary)
                Text(line).font(.footnote).foregroundStyle(.secondary)
            }
        }
        .accessibilityElement(children: .combine)
    }
}

/// One copy to choose: what device and when, and what it holds.
private struct CopyRow: View {
    let title: String
    let line: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title).foregroundStyle(Color.primary)
                Text(line).font(.footnote).foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
        }
    }
}

/// Restore From a Backup → iCloud: each device's copies on this Apple Account, named by device, newest first
/// (`BackupFolder`). iCloud brings copies that aren't on this iPhone yet; it looks again until they're here.
struct ICloudCopiesView: View {
    @Environment(BackupCenter.self) private var backup
    @State private var copies: [BackupCenter.ICloudCopy] = []
    @State private var downloading = 0
    @State private var searched = false
    @State private var pending: BackupCenter.Pending?
    @State private var failure: String?

    var body: some View {
        Form {
            if copies.isEmpty {
                Section {
                    if downloading > 0 || !searched {
                        Label("Looking for a backup in iCloud…", systemImage: "icloud.and.arrow.down").foregroundStyle(.secondary)
                    } else if FileManager.default.ubiquityIdentityToken == nil {
                        Text("This iPhone isn't signed in to iCloud.").foregroundStyle(.secondary)
                    } else {
                        Text("No backup found in this iPhone's iCloud.").foregroundStyle(.secondary)
                    }
                }
            }
            ForEach(devices, id: \.self) { device in
                Section(copies.first { $0.deviceID == device }?.title ?? "") {
                    ForEach(copies.filter { $0.deviceID == device }) { copy in
                        CopyRow(title: copy.slot == BackupFolder.keptSlot ? "Kept before it shrank" : HabitCopy.capitalized(BackupSyncView.when(copy.modified)),
                                line: copy.habits.map { RestoreStartView.counts(habits: $0, entries: copy.entries ?? 0) } ?? "") {
                            Task { await open(copy) }
                        }
                        .accessibilityIdentifier("restore-icloud-copy")
                    }
                }
            }
            if downloading > 0 && !copies.isEmpty {
                Label("Getting \(downloading == 1 ? "a backup" : "\(downloading) backups") from iCloud…", systemImage: "icloud.and.arrow.down")
                    .foregroundStyle(.secondary)
            }
            if let failure { Section { Text(failure).foregroundStyle(.red) } }
        }
        .navigationTitle("iCloud")
        .navigationBarTitleDisplayMode(.inline)
        .task { await load() }
        .sheet(item: $pending) { pending in NavigationStack { RestorePreviewView(pending: pending) } }
    }

    /// This device first, then the others by their newest copy.
    private var devices: [String] {
        var seen: [String] = []
        for copy in copies.sorted(by: { ($0.isThisDevice ? 1 : 0, $0.modified) > ($1.isThisDevice ? 1 : 0, $1.modified) }) where !seen.contains(copy.deviceID) {
            seen.append(copy.deviceID)
        }
        return seen
    }

    private func load() async {
        for _ in 0..<20 {
            (copies, downloading) = await backup.iCloudCopies()
            searched = true
            if downloading == 0 || Task.isCancelled { return }
            try? await Task.sleep(for: .seconds(3))
        }
    }

    private func open(_ copy: BackupCenter.ICloudCopy) async {
        failure = nil
        pending = await backup.open(copy)
        if pending == nil { failure = "Couldn't read this backup from iCloud. Please try again." }
    }
}

/// Restore From a Backup → Your Account: a free account's copies (each of its devices, one a day for 7 days), or Plus's
/// days (90). Plus's day replaces the habits on every device, and its preview says so first.
struct AccountCopiesView: View {
    @Environment(BackupCenter.self) private var backup
    @State private var copies: [BackupCenter.ServerCopy] = []
    @State private var days: [BackupCenter.AccountDay] = []
    @State private var loading = true
    @State private var pending: BackupCenter.Pending?
    @State private var failure: String?

    var body: some View {
        Form {
            if loading {
                Section { ProgressView() }
            } else if backup.isPlus {
                Section {
                    if days.isEmpty { Text("No daily copies yet. The first is kept tonight.").foregroundStyle(.secondary) }
                    ForEach(days) { day in
                        CopyRow(title: day.takenAt.formatted(date: .complete, time: .omitted), line: "As it was that night") {
                            Task { await open(day) }
                        }
                        .accessibilityIdentifier("restore-account-day")
                    }
                } footer: {
                    Text("Restoring replaces your habits on all your devices, since they stay in sync. You can undo it for 30 days.")
                }
            } else {
                if copies.isEmpty {
                    Section { Text("No backups in your account yet.").foregroundStyle(.secondary) }
                }
                ForEach(devices, id: \.self) { device in
                    let mine = copies.filter { $0.device == device }
                    Section(mine.first.map { $0.isThisDevice ? "\($0.deviceName) (this device)" : $0.deviceName } ?? "") {
                        ForEach(mine) { copy in
                            CopyRow(title: copy.slot == "before-shrink" ? "Kept before it shrank" : HabitCopy.capitalized(BackupSyncView.when(copy.createdAt)),
                                    line: RestoreStartView.counts(habits: copy.habits, entries: copy.entries)) {
                                Task { await open(copy) }
                            }
                            .accessibilityIdentifier("restore-account-copy")
                        }
                    }
                }
            }
            if let failure { Section { Text(failure).foregroundStyle(.red) } }
        }
        .navigationTitle("Your Account")
        .navigationBarTitleDisplayMode(.inline)
        .task { await load() }
        .sheet(item: $pending) { pending in NavigationStack { RestorePreviewView(pending: pending) } }
    }

    private var devices: [String] {
        var seen: [String] = []
        for copy in copies.sorted(by: { ($0.isThisDevice ? 1 : 0, $0.createdAt) > ($1.isThisDevice ? 1 : 0, $1.createdAt) }) where !seen.contains(copy.device) {
            seen.append(copy.device)
        }
        return seen
    }

    private func load() async {
        loading = true
        defer { loading = false }
        do {
            if backup.isPlus { days = try await backup.accountDays() } else { copies = try await backup.serverCopies() }
        } catch {
            failure = "Couldn't reach your account. Check your connection and try again."
        }
    }

    private func open(_ copy: BackupCenter.ServerCopy) async {
        failure = nil
        do {
            pending = try await backup.download(copy)
            if pending == nil { failure = BackupCenter.words(for: "damaged") }
        } catch {
            failure = "Couldn't download this backup. Check your connection and try again."
        }
    }

    private func open(_ day: BackupCenter.AccountDay) async {
        failure = nil
        do {
            pending = try await backup.download(day)
            if pending == nil { failure = BackupCenter.words(for: "damaged") }
        } catch {
            failure = "Couldn't download this day. Check your connection and try again."
        }
    }
}

/// What a backup holds, what each choice would do, and the choice (03 §3.6). Nothing changes until a button is
/// tapped; an import that would add nothing says so instead of "success" with an empty screen (§4.8).
struct RestorePreviewView: View {
    @Environment(BackupCenter.self) private var backup
    @Environment(\.dismiss) private var dismiss
    let pending: BackupCenter.Pending
    var onDone: () -> Void = {}
    @State private var working = false
    @State private var done: String?
    @State private var failure: String?
    /// Plus: Replace waits for "Replace on all your devices?" (Account and Backup Redesign, screen 6c).
    @State private var confirmEverywhere = false

    var body: some View {
        Form {
            if let problem = pending.check.problem {
                Section { Text(BackupCenter.words(for: problem)) }
            } else if let preview = pending.check.preview {
                content(preview)
            }
        }
        .navigationTitle("Restore")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) { Button(done == nil ? "Cancel" : "Done") { finish() } }
            if working { ToolbarItem(placement: .topBarTrailing) { ProgressView() } }
        }
        .interactiveDismissDisabled(working)
        .confirmationDialog("Replace your habits on all your devices?", isPresented: $confirmEverywhere, titleVisibility: .visible) {
            Button("Replace on All Devices", role: .destructive) { Task { await restore(.replace) } }
                .accessibilityIdentifier("restore-replace-everywhere")
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Your devices stay in sync, so every one of them gets the habits from this backup. You can undo it for 30 days in Backup & Export.")
        }
    }

    /// Replace: with Plus, asked first, since it changes every device.
    private func replace() {
        if backup.isPlus { confirmEverywhere = true } else { Task { await restore(.replace) } }
    }

    @ViewBuilder private func content(_ preview: RestorePreview) -> some View {
        let made = Date(timeIntervalSince1970: Double(preview.createdAt) / 1000)
        Section {
            Text("\(RestoreStartView.counts(habits: Int(preview.fileHabits), entries: Int(preview.fileEntries))) from \u{201C}\(preview.deviceName)\u{201D}, \(made.formatted(date: .abbreviated, time: .shortened))")
                .accessibilityIdentifier("restore-summary")
            LabeledContent("On this device now", value: RestoreStartView.counts(habits: Int(preview.phoneHabits), entries: Int(preview.phoneEntries)))
        }
        if let done {
            Section { Label(done, systemImage: "checkmark.circle.fill") }
        } else if preview.replace.changesNothing && preview.merge.changesNothing {
            Section { Text("Everything in this backup is already here. Nothing needs to change.") }
        } else if preview.phoneHabits == 0 && preview.phoneEntries == 0 {
            Section {
                Button("Restore") { replace() }
                    .accessibilityIdentifier("restore-replace")
            }
        } else {
            Section {
                Button(backup.isPlus ? "Replace on All Devices" : "Replace What's on This Device") { replace() }
                    .accessibilityIdentifier("restore-replace")
            } footer: {
                Text((backup.isPlus ? "All your devices become exactly the backup. " : "This device becomes exactly the backup. ") + Self.describe(preview.replace))
            }
            Section {
                Button("Merge") { Task { await restore(.merge) } }
                    .disabled(preview.merge.changesNothing)
                    .accessibilityIdentifier("restore-merge")
            } footer: {
                Text(preview.merge.changesNothing ? "Merging adds nothing: everything in the backup is already here." : "Adds what's missing and keeps everything here. " + Self.describe(preview.merge))
            }
        }
        if let failure {
            Section { Text(failure).foregroundStyle(.red) }
        }
        if done == nil {
            Section {
                Text(backup.isPlus ? "Restoring replaces your habits on all your devices, since they stay in sync. You can undo it for 30 days in Backup & Export."
                                   : "You can undo a restore for 30 days in Backup & Export.").font(.footnote).foregroundStyle(.secondary)
            }
        }
    }

    static func describe(_ c: RestoreChanges) -> String {
        var parts: [String] = []
        if c.habitsAdded > 0 { parts.append("\(c.habitsAdded) \(c.habitsAdded == 1 ? "habit" : "habits") added") }
        if c.habitsRemoved > 0 { parts.append("\(c.habitsRemoved) removed") }
        if c.habitsUpdated > 0 { parts.append("\(c.habitsUpdated) updated") }
        if c.entriesAdded > 0 { parts.append("\(c.entriesAdded) \(c.entriesAdded == 1 ? "check-in" : "check-ins") added") }
        if c.entriesRemoved > 0 { parts.append("\(c.entriesRemoved) \(c.entriesRemoved == 1 ? "check-in" : "check-ins") removed") }
        let text = parts.joined(separator: ", ")
        guard let first = text.first else { return "" }
        return String(first).uppercased() + String(text.dropFirst()) + "."
    }

    private func restore(_ mode: RestoreMode) async {
        working = true
        failure = nil
        defer { working = false }
        do {
            let changes = try await backup.restore(pending, mode: mode)
            done = changes.changesNothing ? "Nothing needed to change." : "Restored. " + Self.describe(changes)
        } catch {
            failure = "Couldn't restore, so nothing was changed. Please try again."
        }
    }

    private func finish() {
        let restored = done != nil
        dismiss()
        if restored { onDone() }
    }
}
