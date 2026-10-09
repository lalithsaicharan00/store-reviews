import Core
import SwiftUI
import UniformTypeIdentifiers

/// ≡ → Backup & Export → Restore, also from the welcome and the empty Today (Backup, Sync and Accounts §4.1, §4.6, §4.8):
/// whatever applies, most likely first. The account's copies (any of its devices), sign-in, and a file.
struct RestoreStartView: View {
    @Environment(BackupCenter.self) private var backup
    @Environment(\.dismiss) private var dismiss
    @State private var copies: [BackupCenter.ServerCopy] = []
    @State private var iCloud: [BackupCenter.ICloudCopy] = []
    @State private var iCloudDownloading = 0
    @State private var loading = false
    @State private var showSignIn = false
    @State private var importing = false
    @State private var pending: BackupCenter.Pending?
    @State private var failure: String?
    /// The result of importing an older backup file (one saved from Backup & Export before 1 Oct 2026).
    @State private var imported: String?

    var body: some View {
        Form {
            if BackupFeatures.iCloudBackup && (!iCloud.isEmpty || iCloudDownloading > 0) {
                Section {
                    ForEach(iCloud) { copy in
                        Button { Task { await openICloud(copy) } } label: {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(copy.title).foregroundStyle(Color.primary)
                                Text(copy.detail).font(.footnote).foregroundStyle(.secondary)
                            }
                        }
                    }
                    if iCloudDownloading > 0 {
                        Label("Getting \(iCloudDownloading == 1 ? "a backup" : "\(iCloudDownloading) backups") from iCloud…", systemImage: "icloud.and.arrow.down")
                            .foregroundStyle(.secondary)
                    }
                } header: {
                    Text("We found your backup in iCloud")
                }
            }
            if backup.isSignedIn {
                Section {
                    if loading && copies.isEmpty {
                        ProgressView()
                    } else if copies.isEmpty {
                        Text("No backups in your account yet.").foregroundStyle(.secondary)
                    }
                    ForEach(copies) { copy in
                        Button { Task { await open(copy) } } label: {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(copy.isThisDevice ? "\(copy.deviceName) (this device)" : copy.deviceName).foregroundStyle(Color.primary)
                                Text("\(BackupSyncView.when(copy.createdAt)) · \(Self.counts(habits: copy.habits, entries: copy.entries))")
                                    .font(.footnote).foregroundStyle(.secondary)
                            }
                        }
                    }
                } header: {
                    Text("From your account")
                } footer: {
                    if !backup.isPlus {
                        Text("Copy your habits here once. They won't stay in sync: on the free plan each device keeps its own habits. Same habits on both, kept in sync: Plus.")
                    }
                }
            } else {
                Section {
                    Button("Sign In") { showSignIn = true }
                        .accessibilityIdentifier("restore-sign-in")
                } footer: {
                    Text("If you made an account, sign in and your backup comes back.")
                }
            }
            Section {
                Button("Import a File") { importing = true }
                    .accessibilityIdentifier("restore-import")
            } footer: {
                Text("A file from \"Move to Another Device\" or \"Save a Backup File\", on this iPhone, in Files, or from AirDrop.")
            }
            if let imported {
                Section { Text(imported).accessibilityIdentifier("restore-imported") }
            }
            if let failure {
                Section { Text(failure).foregroundStyle(.red) }
            }
        }
        .navigationTitle("Restore Your Habits")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { ToolbarItem(placement: .cancellationAction) { Button("Close") { dismiss() } } }
        .task(id: backup.isSignedIn) { await loadCopies() }
        .task { await loadICloud() }
        .sheet(isPresented: $showSignIn) { SignInSheet(title: "Sign In") }
        .sheet(item: $pending) { pending in
            NavigationStack { RestorePreviewView(pending: pending) { dismiss() } }
        }
        .fileImporter(isPresented: $importing, allowedContentTypes: [.zip, .data], allowsMultipleSelection: false) { result in
            guard case .success(let urls) = result, let url = urls.first else { return }
            Task { await importFile(url) }
        }
    }

    static func counts(habits: Int, entries: Int) -> String {
        "\(habits) \(habits == 1 ? "habit" : "habits"), \(entries) \(entries == 1 ? "check-in" : "check-ins")"
    }

    private func loadCopies() async {
        guard backup.isSignedIn else { copies = []; return }
        loading = true
        defer { loading = false }
        copies = (try? await backup.serverCopies()) ?? []
    }

    /// iCloud brings copies that aren't on this device yet; look again until they're here (at most a minute).
    private func loadICloud() async {
        for _ in 0..<20 {
            (iCloud, iCloudDownloading) = await backup.iCloudCopies()
            if iCloudDownloading == 0 { return }
            try? await Task.sleep(for: .seconds(3))
        }
    }

    private func openICloud(_ copy: BackupCenter.ICloudCopy) async {
        failure = nil
        pending = await backup.open(copy)
        if pending == nil { failure = "Couldn't read this backup from iCloud. Please try again." }
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
                Button("Restore") { Task { await restore(.replace) } }
                    .accessibilityIdentifier("restore-replace")
            }
        } else {
            Section {
                Button("Replace What's on This Device") { Task { await restore(.replace) } }
                    .accessibilityIdentifier("restore-replace")
            } footer: {
                Text("This device becomes exactly the backup. " + Self.describe(preview.replace))
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
                Text("You can undo a restore for 30 days in Backup & Export.").font(.footnote).foregroundStyle(.secondary)
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
