import SwiftUI

/// ≡ → Privacy (Navigation, Round 3): lock with Face ID. Free. Report "App Lock — Private Without Lock-outs" (30 Sep):
/// the iPhone's own Face ID, Touch ID or passcode, never a separate code to forget; the switch only changes after Face ID
/// (or the passcode) works here, so it can never lock someone out.
struct PrivacyView: View {
    @State private var lockOn = AppLock.isEnabled

    var body: some View {
        Form {
            Section {
                if lockOn || AppLock.isAvailable {
                    Toggle("Lock with \(AppLock.methodName)", isOn: Binding(get: { lockOn }, set: { setLock($0) }))
                        .accessibilityIdentifier("privacy-lock")
                }
            } footer: {
                Text(footer)
            }
        }
        .navigationTitle("Privacy")
    }

    private var footer: String {
        let base = "No account, no ads and no tracking. Nothing leaves your phone unless you share it."
        if lockOn {
            return base + " Habits asks for \(AppLock.methodName), or your iPhone passcode, each time you open it."
        }
        return AppLock.isAvailable ? base : base + " To lock Habits, set a passcode for this iPhone first."
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
