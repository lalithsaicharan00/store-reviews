import LocalAuthentication
import SwiftUI

/// ≡ → Account, and Backup & Export → Your Account (Account and Backup Redesign, screens 2, 3 and 3b; Current Work 76).
/// It leads with what people come for (users show, report §4a): who they are here, then the actions by their own names.
///
/// - **Signed out:** "Not signed in" and where the habits are; **Sign In** and **Create Account** as two plain rows,
///   each opening its own sheet; two facts, never a list of benefits or a push.
/// - **Signed in:** which account, the plan (Plus says lifetime), Last Synced (free and Plus both sync, Current Work 78),
///   the devices with how to get on another one, Sign Out and Delete Account (Architecture 01 §3.7, 09 §7). Signing out
///   leaves this page signed out.
struct AccountView: View {
    @Environment(BackupCenter.self) private var backup
    @State private var details: BackupCenter.AccountDetails?
    @State private var failed = false
    @State private var confirmSignOut = false
    @State private var showDelete = false
    @State private var sheet: String?

    var body: some View {
        Form {
            if backup.isSignedIn { signedIn } else { signedOut }
        }
        .analyticsScreen(.account)
        .navigationTitle("Account")
        .navigationBarTitleDisplayMode(.inline)
        .task(id: backup.isSignedIn) { if backup.isSignedIn { await load() } else { details = nil } }
        .confirmationDialog("Sign out?", isPresented: $confirmSignOut, titleVisibility: .visible) {
            Button("Sign Out", role: .destructive) { Task { await backup.signOut() } }
        } message: {
            Text(backup.signOutLine)
        }
        .sheet(isPresented: $showDelete) { NavigationStack { DeleteAccountView() } }
        .sheet(item: Binding(get: { sheet.map(SheetTitle.init) }, set: { sheet = $0?.title })) { item in
            SignInSheet(title: item.title)
        }
    }

    // MARK: Signed out (screen 2)

    @ViewBuilder private var signedOut: some View {
        Section {
            Identity(symbol: "person.crop.circle.fill", filled: false, title: "Not signed in", line: backup.whereHabitsAre)
                .accessibilityIdentifier("account-identity")
        }
        Section {
            row("Sign In", id: "account-sign-in") { sheet = "Sign In" }
            row("Create Account", id: "account-create") { sheet = "Create Account" }
        } footer: {
            VStack(alignment: .leading, spacing: 8) {
                Text("A free account syncs your habits on one device and brings them back when you sign in on a new device.")
                Text("Plus syncs across your devices.")
            }
        }
    }

    private func row(_ title: String, id: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(title).foregroundStyle(Color.primary)
                Spacer()
                Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary)
            }
            .contentShape(Rectangle())
        }
        .accessibilityIdentifier(id)
    }

    // MARK: Signed in (screens 3 and 3b)

    @ViewBuilder private var signedIn: some View {
        Section {
            if let key = details?.signIns.first {
                Identity(symbol: key.provider == "apple" ? "apple.logo" : "person.crop.circle.fill", filled: true,
                         title: "Signed in with \(Self.providerName(key.provider))",
                         line: key.isPrivateEmail ? "Email hidden by Apple" : (key.email ?? ""))
                    .accessibilityIdentifier("account-identity")
            } else if failed {
                Text("Couldn't load your account. Check your connection.").foregroundStyle(.secondary)
            } else {
                ProgressView()
            }
        }
        Section {
            NavigationLink { PlusView(fromMenu: true) } label: {
                LabeledContent("Plan", value: backup.isPlus ? "Plus (lifetime)" : "Free")
            }
            .accessibilityIdentifier("account-plan")
            LabeledContent("Last Synced", value: lastSynced.map { HabitCopy.capitalized(BackupSyncView.when($0)) } ?? "Not yet")
                .accessibilityIdentifier("account-last-synced")
        } footer: {
            Text(backup.isPlus ? "Syncs across your devices, with a copy of each day for 90 days."
                               : "Free syncs one device, with a copy of each of the last 7 days.")
        }
        Section {
            if let details {
                ForEach(details.devices) { device in
                    HStack(spacing: 14) {
                        Image(systemName: device.platform == "ipados" ? "ipad" : "iphone").font(.title3).frame(width: 26)
                            .accessibilityHidden(true)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(device.isThis ? "\(device.name) (this device)" : device.name)
                            Text(deviceLine(device)).font(.footnote).foregroundStyle(.secondary)
                        }
                    }
                    .accessibilityElement(children: .combine)
                }
            }
        } header: {
            Text("Devices")
        } footer: {
            Text(backup.isPlus ? "To add a device, sign in on it with this account."
                               : "To use another phone or tablet instead, sign in on it. This iPhone is then signed out and keeps its habits.")
        }
        .accessibilityIdentifier("account-devices")
        Section {
            Button("Sign Out") { confirmSignOut = true }
                .accessibilityIdentifier("account-sign-out")
        } footer: {
            Text("Your habits stay on this iPhone.")
        }
        Section {
            Button("Delete Account…", role: .destructive) { showDelete = true }
                .accessibilityIdentifier("account-delete")
        }
    }

    /// When this iPhone last synced: this session's last sync, else the last time the server had everything.
    private var lastSynced: Date? { backup.lastSynced ?? backup.lastGood }

    private func deviceLine(_ device: BackupCenter.AccountDetails.Device) -> String {
        if !device.signedIn { return "Signed out" }
        if device.isThis, let last = lastSynced { return "Synced " + BackupSyncView.when(last) }
        return "Last used " + BackupSyncView.when(device.lastSeen)
    }

    private func load() async {
        failed = false
        do { details = try await backup.accountDetails() } catch { failed = true }
    }

    static func providerName(_ provider: String) -> String {
        switch provider {
        case "apple": "Apple"
        case "google": "Google"
        default: provider.capitalized
        }
    }
}

private struct SheetTitle: Identifiable {
    let title: String
    var id: String { title }
}

/// Who you are here, the top of the Account page in every state: a round mark, a title and one line.
private struct Identity: View {
    let symbol: String
    let filled: Bool
    let title: String
    let line: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: symbol)
                .font(.system(size: filled ? 20 : 36))
                .foregroundStyle(filled ? Color.onInk : Color.secondary)
                .frame(width: 40, height: 40)
                .background(Circle().fill(filled ? Color.ink : Color(.tertiarySystemFill)))
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.headline)
                if !line.isEmpty { Text(line).font(.subheadline).foregroundStyle(.secondary) }
            }
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
    }
}

/// Deleting the account (09 §7): offer an export first, say that Plus stays theirs, confirm with Face ID or the
/// passcode, then ask whether this iPhone's habits go too (default: keep them). Never an email round-trip or a form.
struct DeleteAccountView: View {
    @Environment(BackupCenter.self) private var backup
    @Environment(\.dismiss) private var dismiss
    @State private var sharing: URL?
    @State private var askErase = false
    @State private var working = false
    @State private var goneBy: Date?
    @State private var failure: String?

    var body: some View {
        Form {
            if let goneBy {
                Section {
                    Label("Your account is deleted.", systemImage: "checkmark.circle.fill")
                        .accessibilityIdentifier("account-deleted")
                    Text("Everything in your account is gone now. Every copy, backups included, is gone by \(goneBy.formatted(date: .long, time: .omitted)).")
                }
            } else {
                Section {
                    Text("Deleting your account removes everything in it: your backups, synced habits, devices and sign-ins. Other devices are signed out and keep what's on them.")
                    if backup.isPlus {
                        Text("Plus stays yours: restore it from the App Store on this or any new account.")
                    }
                }
                Section {
                    Button("Save a Backup File First") { Task { await export() } }
                } footer: {
                    Text("A copy of your habits to keep. You can import it later, with or without an account.")
                }
                Section {
                    Button("Delete Account", role: .destructive) { Task { await confirm() } }
                        .disabled(working)
                        .accessibilityIdentifier("account-delete-confirm")
                }
                if let failure {
                    Section { Text(failure).foregroundStyle(.red) }
                }
            }
        }
        .navigationTitle("Delete Account")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) { Button(goneBy == nil ? "Cancel" : "Done") { dismiss() } }
            if working { ToolbarItem(placement: .topBarTrailing) { ProgressView() } }
        }
        .interactiveDismissDisabled(working)
        .confirmationDialog("Also erase this iPhone's habits?", isPresented: $askErase, titleVisibility: .visible) {
            Button("Keep My Habits on This iPhone") { Task { await delete(erase: false) } }
            Button("Erase This iPhone Too", role: .destructive) { Task { await delete(erase: true) } }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("If you keep them, the app keeps working on this iPhone without an account.")
        }
        .sheet(item: Binding(get: { sharing.map(SharedFileItem.init) }, set: { sharing = $0?.url })) { item in
            ShareFileSheet(url: item.url, onFinish: { sharing = nil })
        }
    }

    /// Face ID, Touch ID or the passcode. A device with no lock at all has nothing to check with, so it goes on.
    private func confirm() async {
        #if DEBUG
        // UI tests can't answer Face ID or a passcode (BackupUITests); real builds always ask.
        if ProcessInfo.processInfo.arguments.contains("-skip-device-auth") { askErase = true; return }
        #endif
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            do {
                guard try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Confirm deleting your account") else { return }
            } catch {
                return // cancelled or failed: nothing happens
            }
        }
        askErase = true
    }

    private func delete(erase: Bool) async {
        working = true
        failure = nil
        defer { working = false }
        do {
            goneBy = try await backup.deleteAccount(eraseThisDevice: erase)
        } catch {
            failure = backup.isSignedIn
                ? "Couldn't delete the account. Check your connection and try again; nothing was changed."
                : "Your account is deleted, but this iPhone's habits couldn't all be erased. Please try again from Backup & Export."
        }
    }

    private func export() async {
        do { sharing = try await backup.makeFile() } catch { failure = "Couldn't make the file. Please try again." }
    }
}

private struct SharedFileItem: Identifiable {
    let url: URL
    var id: URL { url }
}
