import SwiftUI
import UniformTypeIdentifiers

struct BackupExportView: View {
    @Environment(HabitStore.self) private var store
    @State private var working = false
    @State private var sharing: SharedFile?
    @State private var sharedDirectory: URL?
    @State private var importing = false
    @State private var message: BackupMessage?

    var body: some View {
        Form {
            Section {
                Label("Saved on this iPhone", systemImage: "iphone")
                Text("Your data is eligible for your iPhone’s device backup. Whether a backup exists depends on your iPhone settings.")
                    .foregroundStyle(.secondary)
            }
            Section {
                Button("Export a Spreadsheet (CSV)") { export() }
                    .accessibilityIdentifier("backup-export-csv")
                Button("Save a Backup File") { backup() }
                    .accessibilityIdentifier("backup-save")
                Button("Restore from a Backup File…") { importing = true }
                    .accessibilityIdentifier("backup-restore")
            } footer: {
                Text("A spreadsheet is for reading your history. A backup holds your habits, tasks, logs, notes and settings. Restoring adds missing data and keeps anything already here. All three are free.")
            }
            .disabled(working)
            Section("Before You Delete the App") {
                Text("Deleting Habits removes its data and recovery copies from this iPhone. Reinstalling alone does not bring them back.")
                Text("Save a Backup File to a folder outside Habits in Files first. After reinstalling, use Restore from a Backup File. A file saved inside Habits’ own folder is deleted with the app.")
                Text("Offload App in iPhone Settings keeps Documents & Data. Delete App removes them.")
                    .foregroundStyle(.secondary)
            }
        }
        .analyticsScreen(.backupSync)
        .navigationTitle("Backup & Export")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if working { ToolbarItem(placement: .topBarTrailing) { ProgressView().accessibilityLabel("Working") } }
        }
        .sheet(item: $sharing, onDismiss: cleanSharedFile) { ShareFileSheet(url: $0.url, onFinish: { sharing = nil }) }
        .fileImporter(isPresented: $importing, allowedContentTypes: [.database, .data], allowsMultipleSelection: false) { result in
            switch result {
            case .success(let urls): if let url = urls.first { restore(url) }
            case .failure(let error): message = BackupMessage(title: "Couldn’t Open the File", text: error.localizedDescription)
            }
        }
        .alert(item: $message) { Alert(title: Text($0.title), message: Text($0.text)) }
    }

    private func export() {
        working = true
        Task { @MainActor in
            defer { working = false }
            await store.flush()
            guard store.problem == nil, store.isStorageReady else {
                message = BackupMessage(title: "Couldn’t Export", text: HabitStore.BackupError.pendingSave.localizedDescription)
                return
            }
            let rows = DataExport.rows(from: store), day = store.today().key
            do {
                let url = try await Task.detached { try DataExport.file(rows: rows, day: day) }.value
                share(url)
            } catch { message = BackupMessage(title: "Couldn’t Export", text: error.localizedDescription) }
        }
    }

    private func backup() {
        working = true
        Task { @MainActor in
            defer { working = false }
            do { share(try await store.backupFile()) }
            catch { message = BackupMessage(title: "Couldn’t Make a Backup", text: error.localizedDescription) }
        }
    }

    private func restore(_ url: URL) {
        working = true
        Task { @MainActor in
            defer { working = false }
            do {
                let added = try await store.restore(from: url)
                message = BackupMessage(title: added.changed ? "Backup Restored" : "Nothing New",
                    text: added.changed
                        ? "Added \(added.habits) habits or tasks, \(added.entries) logged entries and \(added.settings) notes or settings. Anything already here was kept."
                        : "Everything in this backup is already here. Nothing was changed.")
            } catch { message = BackupMessage(title: "Couldn’t Restore", text: error.localizedDescription) }
        }
    }

    private func cleanSharedFile() {
        // The share controller retains its URL until dismissal; only our UUID-named temp folder is removed.
        if let sharedDirectory { try? FileManager.default.removeItem(at: sharedDirectory) }
        sharedDirectory = nil
        sharing = nil
    }

    private func share(_ url: URL) {
        sharedDirectory = url.deletingLastPathComponent()
        sharing = SharedFile(url: url)
    }
}

struct SharedFile: Identifiable { let id = UUID(); let url: URL }
struct BackupMessage: Identifiable { let id = UUID(); let title: String; let text: String }

struct ShareFileSheet: UIViewControllerRepresentable {
    let url: URL
    let onFinish: @MainActor () -> Void
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        controller.completionWithItemsHandler = { _, _, _, _ in
            Task { @MainActor in onFinish() }
        }
        return controller
    }
    func updateUIViewController(_ controller: UIActivityViewController, context: Context) {}
}

/// Blank by the user's request; content and contact details will be provided later.
struct BlankMenuPage: View {
    let title: String
    var body: some View {
        Color(.systemGroupedBackground).ignoresSafeArea()
            .navigationTitle(title).navigationBarTitleDisplayMode(.inline)
    }
}
