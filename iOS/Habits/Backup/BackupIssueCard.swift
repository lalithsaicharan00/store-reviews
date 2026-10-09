import SwiftUI
import UIKit

/// The card at the top of Today when the main backup can't work (Backup, Sync and Accounts §4.4): what happened, what
/// is still safe, and the fix. "Not now" hides it for 7 days; it returns if the problem is still there. Nothing about
/// backup shows on Today while everything works. Only this small view reads backup state, so Today itself never
/// redraws for it.
struct BackupIssueSection: View {
    @Environment(BackupCenter.self) private var backup
    @State private var showSignIn = false

    var body: some View {
        if backup.showsCard, let issue = backup.issue {
            Section {
                VStack(alignment: .leading, spacing: 10) {
                    Label { Text(issue.text) } icon: { Image(systemName: "exclamationmark.icloud.fill").foregroundStyle(.red) }
                    HStack {
                        Button(issue.fixLabel) { fix(issue.fix) }
                            .buttonStyle(.borderedProminent).tint(.ink)
                            .accessibilityIdentifier("backup-card-fix")
                        Spacer()
                        Button("Not Now") { backup.notNow() }
                            .buttonStyle(.borderless)
                            .accessibilityIdentifier("backup-card-not-now")
                    }
                }
                .padding(.vertical, 4)
                .sheet(isPresented: $showSignIn) { SignInSheet(title: backup.issue?.fix == .signIn ? "Sign In" : "Create Account") }
            }
        }
    }

    private func fix(_ fix: BackupCenter.Issue.Fix) {
        switch fix {
        case .signIn, .backUpToAccount:
            showSignIn = true
        case .tryNow, .backUpNow:
            Task { await backup.backUpNow() }
        case .openSettings:
            if let url = URL(string: UIApplication.openSettingsURLString) { UIApplication.shared.open(url) }
        }
    }
}
