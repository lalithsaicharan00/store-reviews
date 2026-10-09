import SwiftUI

/// Making an account, optional and free (Backup, Sync and Accounts §4.5): one screen that says what an account does,
/// what we keep, and that saying no is fine. Offered only where it helps, never as a nudge.
struct SignInSheet: View {
    @Environment(BackupCenter.self) private var backup
    @Environment(\.dismiss) private var dismiss
    @State private var working = false
    @State private var unknown: ProviderToken?
    @State private var failure: String?
    @State private var google = GoogleSignIn()
    @State private var apple = AppleSignIn()
    var onSignedIn: () -> Void = {}
    /// "Create Account" where people come to make one; "Sign In" where the account already exists (restoring from it,
    /// or signing back in after the account ended the session).
    var title = "Create Account"

    var body: some View {
        NavigationStack {
            Form {
                // Why make an account, one short line each (the user, 9 Oct 2026, Current Work 58.12): daily backups,
                // encrypted (in transit and at rest; Architecture 06), a new phone just signs in, and devices in sync
                // with Plus. No "we", no "our server", no paragraphs.
                Section {
                    Label("Backed up every day, automatically", systemImage: "clock.arrow.circlepath")
                    Label("Encrypted and stored safely", systemImage: "lock")
                    Label("Back on a new phone just by signing in", systemImage: "iphone")
                    Label("With Plus, all your devices stay in sync", systemImage: "arrow.triangle.2.circlepath")
                } footer: {
                    Text("Used only to back up and sync your habits. Never sold, never for ads.")
                }
                Section {
                    if BackupFeatures.appleSignIn {
                        Button { start { try await apple.signIn() } } label: {
                            Label("Continue with Apple", systemImage: "apple.logo")
                        }
                    }
                    if BackupFeatures.googleSignIn {
                        Button { start { try await google.signIn() } } label: {
                            Label("Continue with Google", systemImage: "g.circle")
                        }
                        .accessibilityIdentifier("sign-in-google")
                    }
                } footer: {
                    Text((BackupFeatures.iCloudBackup ? "Not now? Your habits stay on this one device, backed up to iCloud." : "Not now? Your habits stay on this one device.")
                         + " Have an account already? These sign you in.")
                }
                .disabled(working)
                if let failure {
                    Section { Text(failure).foregroundStyle(.red) }
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } }
                if working { ToolbarItem(placement: .topBarTrailing) { ProgressView() } }
            }
            .confirmationDialog("No account yet", isPresented: Binding(get: { unknown != nil }, set: { if !$0 { unknown = nil } }), titleVisibility: .visible) {
                Button("Create an Account") {
                    guard let token = unknown else { return }
                    unknown = nil
                    finish(token, create: true)
                }
                Button("Cancel", role: .cancel) { unknown = nil }
            } message: {
                Text("There's no Often Enough account for this sign-in yet. If you've used Often Enough before with a different sign-in, use that one instead.")
            }
        }
    }

    private func start(_ provider: @escaping @MainActor () async throws -> ProviderToken) {
        working = true
        failure = nil
        Task {
            do {
                let token = try await provider()
                finish(token, create: false)
            } catch is CancellationError {
                working = false
            } catch {
                working = false
                failure = "Couldn't sign in. Check your connection and try again."
            }
        }
    }

    private func finish(_ token: ProviderToken, create: Bool) {
        working = true
        Task {
            defer { working = false }
            do {
                try await backup.signIn(with: token, create: create)
                onSignedIn()
                dismiss()
            } catch let error as ServerError where error.code == "unknown_key" {
                unknown = token
            } catch {
                failure = "Couldn't sign in. Check your connection and try again."
            }
        }
    }
}
