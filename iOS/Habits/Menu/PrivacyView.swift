import SwiftUI

/// ≡ → Privacy (Navigation, Round 3): lock with Face ID. Free. Report "App Lock — Private Without Lock-outs" (30 Sep):
/// the iPhone's own Face ID, Touch ID or passcode, never a separate code to forget; the switch only changes after Face ID
/// (or the passcode) works here, so it can never lock someone out.
struct PrivacyView: View {
    @Environment(HabitStore.self) private var store
    @State private var lockOn = AppLock.isEnabled
    @State private var usageOn = Analytics.shared.consented
    // Consent remains separate; no crash collector is present in this consolidated app.
    @State private var crashOn = UserDefaults.standard.bool(forKey: "privacy.crashConsent")

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
            Section("Help Improve Often Enough") {
                Toggle("Share Usage", isOn: $usageOn)
                    .accessibilityIdentifier("privacy-usage")
                    .onChange(of: usageOn) {
                        Analytics.shared.setConsent(usageOn)
                        if usageOn { AnalyticsInteractionObserver.install(); store.analyticsConfiguration() }
                    }
                Toggle("Share Crash Diagnostics", isOn: $crashOn)
                    .disabled(true)
                    .accessibilityIdentifier("privacy-crashes")
            } footer: {
                Text("Usage sharing is optional. It sends feature counts and estimated screen time with a random installation identifier. Habit and task names, notes, goals, logged values and account details are never sent. Turning it off deletes pending usage data. Crash sharing is separate and is not available yet.")
            }
        }
        .analyticsScreen(.privacy)
        .navigationTitle("Privacy")
    }

    private var footer: String {
        let base = "Your habit content stays on this phone unless you share it. Usage sharing is optional."
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
        }
    }
}
