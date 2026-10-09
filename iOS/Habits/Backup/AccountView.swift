import LocalAuthentication
import SwiftUI

/// ≡ → Account, and Backup & Export → Your Account (report "Backup & Export and Your Account — What People Look For",
/// 9 Oct 2026): where people look for signing in and out. Signed out, Sign In and one line. Signed in, how you sign in
/// and your plan, your devices, then Sign Out and Delete Account at the bottom (Architecture 01 §3.7, 09 §7). Signing out
/// leaves this page on its signed-out state.
struct AccountView: View {
    @Environment(BackupCenter.self) private var backup
    @State private var details: BackupCenter.AccountDetails?
    @State private var failed = false
    @State private var confirmSignOut = false
    @State private var showDelete = false
    @State private var showSignIn = false

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
            Text("Your habits stay on this iPhone. They won't be backed up to your account until you sign in again.")
        }
        .sheet(isPresented: $showDelete) { NavigationStack { DeleteAccountView() } }
        .sheet(isPresented: $showSignIn) { SignInSheet() }
    }

    @ViewBuilder private var signedOut: some View {
        Section {
            Button("Sign In") { showSignIn = true }
                .accessibilityIdentifier("account-sign-in")
        } footer: {
            Text("Back up to your account, and with Plus, use your habits on all your devices.")
        }
    }

    @ViewBuilder private var signedIn: some View {
        Section("Signed In With") {
            if let details {
                ForEach(details.signIns) { key in
                    LabeledContent(Self.providerName(key.provider), value: key.isPrivateEmail ? "Private email" : (key.email ?? ""))
                }
            } else if failed {
                Text("Couldn't load your account. Check your connection.").foregroundStyle(.secondary)
            } else {
                ProgressView()
            }
            LabeledContent("Plan", value: backup.isPlus ? "Plus" : "Free")
                .accessibilityIdentifier("account-plan")
        }
        if let details, !details.devices.isEmpty {
            Section("Devices") {
                ForEach(details.devices) { device in
                    VStack(alignment: .leading, spacing: 2) {
                        Text(device.isThis ? "\(device.name) (this device)" : device.name)
                        Text(device.signedIn ? "Last used \(BackupSyncView.when(device.lastSeen))" : "Signed out")
                            .font(.footnote).foregroundStyle(.secondary)
                    }
                    .accessibilityElement(children: .combine)
                }
            }
        }
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
            Text("If you keep them, Often Enough keeps working on this iPhone without an account.")
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
