import SwiftUI

/// ≡ → Privacy (Navigation, Round 3): lock with Face ID. Free. Report "App Lock — Private Without Lock-outs" (30 Sep):
/// the iPhone's own Face ID, Touch ID or passcode, never a separate code to forget; the switch only changes after Face ID
/// (or the passcode) works here, so it can never lock someone out. Usage sharing is optional (analytics).
struct PrivacyView: View {
    @Environment(HabitStore.self) private var store
    @Environment(\.scenePhase) private var scenePhase
    @State private var lockOn = AppLock.isEnabled
    /// What this iPhone can lock with. Asking the system (`LAContext`) is slow on the main thread, so it's asked once
    /// off it when the page opens, and again on coming back (a passcode may have been set meanwhile).
    @State private var lock: AppLock.Ability?
    @State private var usageOn = Analytics.shared.consented
    // Consent remains separate; no crash collector is present in this consolidated app.
    @State private var crashOn = UserDefaults.standard.bool(forKey: "privacy.crashConsent")

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
            Section {
                Toggle("Share Usage", isOn: $usageOn)
                    .accessibilityIdentifier("privacy-usage")
                    .onChange(of: usageOn) {
                        Analytics.shared.setConsent(usageOn)
                        WidgetAnalyticsAdapter.consentChanged(usageOn)
                        if usageOn { AnalyticsInteractionObserver.install(); store.analyticsConfiguration() }
                    }
                Toggle("Share Crash Diagnostics", isOn: $crashOn)
                    .disabled(true)
                    .accessibilityIdentifier("privacy-crashes")
            } header: {
                Text("Help Improve Often Enough")
            } footer: {
                Text("Usage sharing is optional. It sends feature counts and estimated screen time with a random installation identifier. Habit and task names, notes, goals, logged values and account details are never sent. Turning it off deletes pending usage data. Crash sharing is separate and is not available yet.")
            }
        }
        .analyticsScreen(.privacy)
        .navigationTitle("Privacy")
        .task(id: scenePhase == .active) { if scenePhase == .active { lock = await AppLock.ability() } }
    }

    private func footer(_ lock: AppLock.Ability) -> String {
        let base = "No ads. An account is optional; without one, your habits stay on this phone unless you share them. Usage sharing is optional."
        if lockOn {
            return base + " Often Enough asks for \(lock.method), or your iPhone passcode, each time you open it."
        }
        return lock.available ? base : base + " To lock Often Enough, set a passcode for this iPhone first."
    }

    private func setLock(_ on: Bool) {
        Task { @MainActor in
            guard await AppLock.authenticate(reason: on ? "Turn on the lock for Often Enough" : "Turn off the lock for Often Enough") else { return }
            AppLock.setEnabled(on)
            lockOn = on
            store.analyticsConfiguration()
            await AppModel.shared.widgets.publish(AppModel.shared.store)
        }
    }
}
