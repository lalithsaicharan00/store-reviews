import SwiftUI

/// ≡ → Privacy (Navigation, Round 3): lock with Face ID. Free. Report "App Lock — Private Without Lock-outs" (30 Sep):
/// the iPhone's own Face ID, Touch ID or passcode, never a separate code to forget; the switch only changes after Face ID
/// (or the passcode) works here, so it can never lock someone out.
struct PrivacyView: View {
    @Environment(\.scenePhase) private var scenePhase
    @State private var lockOn = AppLock.isEnabled
    /// What this iPhone can lock with. Asking the system (`LAContext`) is slow on the main thread, so it's asked once
    /// off it when the page opens, and again on coming back (a passcode may have been set meanwhile).
    @State private var lock: AppLock.Ability?

    var body: some View {
        Form {
            Section {
                if let lock, lockOn || lock.available {
                    Toggle("Lock with \(lock.method)", isOn: Binding(get: { lockOn }, set: { setLock($0) }))
                        .accessibilityIdentifier("privacy-lock")
                }
            } footer: {
                if let lock { Text(footer(lock)) }
            }
        }
        .navigationTitle("Privacy")
        .task(id: scenePhase == .active) { if scenePhase == .active { lock = await AppLock.ability() } }
    }

    private func footer(_ lock: AppLock.Ability) -> String {
        let base = "No ads and no tracking. An account is optional; without one, nothing leaves your phone unless you share it."
        if lockOn {
            return base + " Habits asks for \(lock.method), or your iPhone passcode, each time you open it."
        }
        return lock.available ? base : base + " To lock Habits, set a passcode for this iPhone first."
    }

    private func setLock(_ on: Bool) {
        Task { @MainActor in
            guard await AppLock.authenticate(reason: on ? "Turn on the lock for Habits" : "Turn off the lock for Habits") else { return }
            AppLock.setEnabled(on)
            lockOn = on
            await AppModel.shared.widgets.publish(AppModel.shared.store)
        }
    }
}
