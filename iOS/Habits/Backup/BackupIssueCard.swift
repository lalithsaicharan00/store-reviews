import SwiftUI
import UIKit

/// The card at the top of Today when something needs the person (Backup, Sync and Accounts §4.4; Architecture 11 §17):
/// the backup files can't be written, or iCloud sync is waiting on them (a question, a full iCloud, the brake). What
/// happened, what is still safe, and the fix. "Not now" hides a backup problem for 7 days; it returns if it's still
/// there. Nothing about backup or sync shows on Today while everything works. Only this small view reads their state,
/// so Today itself never redraws for it.
struct BackupIssueSection: View {
    @Environment(BackupCenter.self) private var backup
    @Environment(MenuModel.self) private var menu

    var body: some View {
        if let cloud = backup.cloud, cloud.attention {
            Section {
                VStack(alignment: .leading, spacing: 10) {
                    Label { Text(CloudStatus.of(cloud, isPlus: false).title) } icon: { Image(systemName: "exclamationmark.icloud.fill").foregroundStyle(.red) }
                        .accessibilityElement(children: .combine)
                        .accessibilityIdentifier("cloud-card")
                    Button("Open iCloud & Backup") { open() }
                        .buttonStyle(.borderedProminent).tint(.ink)
                        .accessibilityIdentifier("cloud-card-open")
                }
                .padding(.vertical, 4)
            }
        } else if backup.showsCard, let issue = backup.issue {
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
            }
        }
    }

    private func open() {
        menu.reset()
        menu.path.append(MenuPlace.backup)
    }

    private func fix(_ fix: BackupCenter.Issue.Fix) {
        switch fix {
        case .tryNow, .backUpNow:
            Task { await backup.backUpNow() }
        case .openSettings, .manageStorage:
            if let url = URL(string: UIApplication.openSettingsURLString) { UIApplication.shared.open(url) }
        }
    }
}
