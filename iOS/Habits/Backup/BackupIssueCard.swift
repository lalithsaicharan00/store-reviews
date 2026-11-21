import SwiftUI
import UIKit

/// The card at the top of Today when something needs the person (Backup, Sync and Accounts §4.4; Architecture 11 §17):
/// the backup files can't be written, or iCloud sync is waiting on them (a question, a full iCloud, the brake). What
/// happened, what is still safe, and the fix, drawn as Figma's Card notice (`CardNotice`). The ✕ (Not Now) hides a backup
/// problem for 7 days; it returns if it's still there. iCloud sync waiting on the person has no ✕: it can't wait.
/// Nothing about backup or sync shows on Today while everything works. Only this small view reads their state, so
/// Today itself never redraws for it.
struct BackupIssueSection: View {
    @Environment(BackupCenter.self) private var backup
    @Environment(MenuModel.self) private var menu

    var body: some View {
        if let cloud = backup.cloud, cloud.attention {
            let status = CloudStatus.of(cloud, isPlus: false)
            Section {
                CardNotice(symbol: status.symbol, title: status.title, message: status.line, problem: status.needsYou,
                           id: "cloud-card") {
                    Button("Open Backup & Sync") { open() }
                        .accessibilityIdentifier("cloud-card-open")
                }
            }
        } else if backup.showsCard, let issue = backup.issue {
            Section {
                CardNotice(symbol: "exclamationmark.icloud", title: issue.title, message: issue.text, id: "backup-card",
                           onClose: { backup.notNow() }, closeID: "backup-card-not-now") {
                    Button(issue.fixLabel) { fix(issue.fix) }
                        .accessibilityIdentifier("backup-card-fix")
                }
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
