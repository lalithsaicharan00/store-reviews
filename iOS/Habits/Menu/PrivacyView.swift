import SwiftUI

/// ≡ → Privacy & Security (Current Work 58; spec "Privacy & Security — What to Build" §2): the lock, hiding names
/// outside the app, and what's shared. A native Form; rows appear only when they mean something. The lock's switch only
/// changes after Face ID (or the passcode, or the code in code mode) works here, so it can never lock someone out.
struct PrivacyView: View {
    @Environment(HabitStore.self) private var store
    @Environment(\.scenePhase) private var scenePhase
    @State private var lockOn = AppLock.isEnabled
    /// What this iPhone can lock with. Asking the system (`LAContext`) is slow on the main thread, so it's asked once
    /// off it when the page opens, and again on coming back (a passcode may have been set meanwhile).
    @State private var ability: AppLock.Ability?
    @State private var hideNames = HideNames.chosen
    @State private var usageOn = Analytics.shared.consented
    // Consent remains separate; no crash collector is present in this consolidated app.
    @State private var crashOn = UserDefaults.standard.bool(forKey: "privacy.crashConsent")
    @State private var settingCode = false
    @State private var changingCode = false

    private var lock: AppLock { AppModel.shared.lock }

    var body: some View {
        @Bindable var lock = lock
        Form {
            if lock.resetWaiting, let times = lock.resetTimes {
                Section {
                    VStack(alignment: .leading, spacing: 4) {
                        Label("Code reset asked for", systemImage: "hourglass").font(.headline)
                        Text("\(LockText.when(times.asked)). Ready \(LockText.when(times.ready)).").foregroundStyle(.secondary)
                    }
                    .accessibilityElement(children: .combine)
                    Button("Cancel Reset") { Task { await cancelReset() } }
                        .accessibilityIdentifier("privacy-cancel-reset")
                } footer: {
                    Text("If you didn't ask for this, cancel it.")
                }
            }
            lockSection
            Section {
                Toggle("Hide Names Outside the App", isOn: Binding(get: { hideNames || lockOn }, set: { setHideNames($0) }))
                    .disabled(lockOn)
                    .accessibilityIdentifier("privacy-hide-names")
            } header: {
                Text("Outside the App")
            } footer: {
                Text(hideNamesFooter)
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
                Text("Usage sharing is optional. It sends feature counts and estimated screen time with a random installation identifier. Habit and task names, notes, goals, logged values and account details are never sent. Turning it off deletes pending usage data. Crash sharing is separate and is not available yet.\n\nNo ads. An account is optional; without one, your habits stay on this phone unless you share them.")
            }
        }
        .analyticsScreen(.privacy)
        .navigationTitle("Privacy & Security")
        .task(id: scenePhase == .active) { if scenePhase == .active { ability = await AppLock.ability() } }
        .sheet(isPresented: $settingCode) {
            YourOwnCodeSheet(lock: lock) { chosen in
                settingCode = false
                if chosen { lockOn = true; publish() }
            }
        }
        .sheet(isPresented: $changingCode) {
            NewCodeSheet(lock: lock, title: "Change Code") { _ in changingCode = false }
        }
        .sheet(item: $lock.codeCheck) { check in CodeCheckSheet(lock: lock, check: check) }
    }

    // MARK: The lock

    @ViewBuilder private var lockSection: some View {
        Section {
            if let ability, lockOn || ability.available {
                Toggle("Lock with \(ability.method)", isOn: Binding(get: { lockOn }, set: { setLock($0) }))
                    .accessibilityIdentifier("privacy-lock")
                if lockOn {
                    NavigationLink {
                        UnlockWithPage(onChoose: chooseUnlock)
                    } label: {
                        LabeledContent("Unlock With", value: lock.mode == .code ? "Face ID or Often Enough Code" : "Face ID or iPhone Passcode")
                    }
                    .accessibilityIdentifier("privacy-unlock-with")
                    if lock.mode == .code {
                        Button("Change Code") { Task { if await lock.confirmOwner("Change your Often Enough code") { changingCode = true } } }
                            .foregroundStyle(Color.primary)
                            .accessibilityIdentifier("privacy-change-code")
                        if lock.faceIDOff && ability.biometrics {
                            Button("Use Face ID Again") { Task { await lock.useFaceIDAgain() } }
                                .accessibilityIdentifier("privacy-use-face-id-again")
                        }
                    }
                    NavigationLink {
                        AskAgainPage()
                    } label: {
                        LabeledContent("Ask Again", value: AskAgainPage.name(AppLock.askAgain))
                    }
                    .accessibilityIdentifier("privacy-ask-again")
                }
            }
        } footer: {
            if let ability { Text(lockFooter(ability)) }
        }
    }

    private func lockFooter(_ ability: AppLock.Ability) -> String {
        guard lockOn else {
            return ability.available
                ? "Asks for \(ability.method) each time you open Often Enough. Your iPhone checks your face; Often Enough never sees it."
                : "To lock Often Enough, set a passcode for this iPhone first: Settings → Face ID & Passcode."
        }
        if lock.mode == .code {
            let off = lock.faceIDOff ? "Face ID is off for Often Enough. Turn it back on with Use Face ID Again.\n\n" : ""
            return off + "Forgot the code? Face ID resets it. If Face ID can't, your iPhone passcode can reset it after a 24-hour wait, so no one can do it quickly without you seeing."
        }
        return "Locking your iPhone always locks Often Enough straight away."
    }

    private func setLock(_ on: Bool) {
        Task { @MainActor in
            if on {
                guard await AppLock.authenticate(reason: "Turn on the lock for Often Enough") else { return }
                AppLock.setEnabled(true)
            } else {
                guard await lock.confirmOwner("Turn off the lock for Often Enough") else { return }
                lock.turnOff()
            }
            lockOn = on
            store.analyticsConfiguration()
            publish()
        }
    }

    /// Unlock With: the code needs the iPhone's Face ID or passcode once, then the code twice; back to the iPhone's
    /// passcode needs Face ID or the code (never the passcode itself, spec §3.2).
    private func chooseUnlock(_ mode: AppLock.Mode) {
        guard mode != lock.mode else { return }
        Task { @MainActor in
            switch mode {
            case .code:
                guard await AppLock.authenticate(reason: "Set an Often Enough code") else { return }
                settingCode = true
            case .passcode:
                guard await lock.confirmOwner("Use your iPhone passcode for Often Enough") else { return }
                lock.removeCode()
                AppLock.setEnabled(true)
            }
        }
    }

    private func cancelReset() async {
        guard await lock.confirmOwner("Cancel the code reset") else { return }
        LockKeychain.update { $0.cancelReset() }
        lock.bump()
    }

    // MARK: Hide names

    private var hideNamesFooter: String {
        let what = "Widgets, reminders, alarms, the timer on the Lock Screen and Siri show icons and numbers without habit names. ✓ and + keep working."
        guard lockOn else { return what }
        return "On while App Lock is on. " + what + " To make a reminder say something you'll recognise, add \"Reminder says…\" in the habit's Reminders."
    }

    private func setHideNames(_ on: Bool) {
        guard !lockOn else { return }
        hideNames = on
        HideNames.setChosen(on)
        Analytics.shared.event(.preference, ["setting": .text("widget_privacy"), "value": .text(on ? "hidden" : "visible")], ticket: Analytics.shared.ticket)
        store.analyticsConfiguration()
        publish()
    }

    /// The next widget, reminder, alarm and timer already follow the change (spec §2.3).
    private func publish() {
        Task { await AppModel.shared.privacyChanged() }
    }
}

/// Unlock With (spec §2.2): two rows with a check, each with its line under it.
private struct UnlockWithPage: View {
    let onChoose: (AppLock.Mode) -> Void
    private var lock: AppLock { AppModel.shared.lock }

    var body: some View {
        Form {
            Section {
                row(.passcode, "Face ID or iPhone Passcode", "Nothing new to remember. Anyone who knows your iPhone passcode can open Often Enough.")
                row(.code, "Face ID or Often Enough Code", "Your iPhone passcode can't open it. If you forget the code, Face ID resets it.")
            } footer: {
                Text("Choose an Often Enough code if people around you know your iPhone passcode.")
            }
        }
        .navigationTitle("Unlock With")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func row(_ mode: AppLock.Mode, _ title: String, _ detail: String) -> some View {
        Button { onChoose(mode) } label: {
            HStack(alignment: .firstTextBaseline) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title).foregroundStyle(Color.primary)
                    Text(detail).font(.footnote).foregroundStyle(.secondary).fixedSize(horizontal: false, vertical: true)
                }
                Spacer(minLength: 8)
                if lock.mode == mode { Image(systemName: "checkmark").fontWeight(.semibold).foregroundStyle(Color.ink) }
            }
            .contentShape(Rectangle())
        }
        .accessibilityAddTraits(lock.mode == mode ? .isSelected : [])
        .accessibilityIdentifier(mode == .code ? "unlock-with-code" : "unlock-with-passcode")
    }
}

/// Ask Again (spec §2.2): Immediately, After 1 Minute, After 15 Minutes.
struct AskAgainPage: View {
    @State private var chosen = AppLock.askAgain

    static func name(_ seconds: Int) -> String {
        switch seconds { case 60: "After 1 Minute"; case 900: "After 15 Minutes"; default: "Immediately" }
    }

    var body: some View {
        Form {
            Section {
                ForEach([0, 60, 900], id: \.self) { seconds in
                    Button {
                        chosen = seconds
                        AppLock.askAgain = seconds
                    } label: {
                        HStack {
                            Text(Self.name(seconds)).foregroundStyle(Color.primary)
                            Spacer()
                            if chosen == seconds { Image(systemName: "checkmark").fontWeight(.semibold).foregroundStyle(Color.ink) }
                        }
                        .contentShape(Rectangle())
                    }
                    .accessibilityAddTraits(chosen == seconds ? .isSelected : [])
                    .accessibilityIdentifier("ask-again-\(seconds)")
                }
            } footer: {
                Text("How long Often Enough stays open after you switch to another app. Locking your iPhone always locks it straight away.")
            }
        }
        .navigationTitle("Ask Again")
        .navigationBarTitleDisplayMode(.inline)
    }
}
