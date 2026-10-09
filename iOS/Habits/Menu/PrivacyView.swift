import SwiftUI

/// ≡ → Privacy & Security (Current Work 58; spec "Privacy & Security — What to Build" §2, redesigned as "App Lock
/// Redesign — What to Build", 9 Oct 2026, Current Work 58.13): the App Lock row (what it's for, and whether it's on),
/// hiding names outside the app, and what's shared. A native Form. App Lock's own page holds the switch and its options
/// (`AppLockPage`).
struct PrivacyView: View {
    @Environment(HabitStore.self) private var store
    @Environment(\.scenePhase) private var scenePhase
    /// What this iPhone can lock with. Asking the system (`LAContext`) is slow on the main thread, so it's asked once
    /// off it when the page opens, and again on coming back (a passcode may have been set meanwhile).
    @State private var ability: AppLock.Ability?
    @State private var hideNames = HideNames.chosen
    @State private var usageOn = Analytics.shared.consented
    // Consent remains separate; no crash collector is present in this consolidated app.
    @State private var crashOn = UserDefaults.standard.bool(forKey: "privacy.crashConsent")
    /// Speed runs only (`PerfDriver` "app-lock"): the App Lock page, pushed as the row pushes it.
    @State private var perfAppLock = false

    private var lock: AppLock { AppModel.shared.lock }

    var body: some View {
        let lockOn = lock.isOn
        Form {
            Section {
                NavigationLink { AppLockPage() } label: {
                    AppLockRow(subtitle: AppLockText.rowSubtitle(ability), on: lockOn)
                }
                .accessibilityIdentifier("privacy-app-lock")
            }
            Section {
                Toggle("Hide Names Outside the App", isOn: Binding(get: { hideNames || lockOn }, set: { setHideNames($0) }))
                    .disabled(lockOn)
                    .accessibilityIdentifier("privacy-hide-names")
            } header: {
                Text("Outside the App")
            } footer: {
                Text(lockOn ? "On while App Lock is on. " + Self.hideNamesLine : Self.hideNamesLine)
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
                Text("Help Improve the App")
            } footer: {
                Text("Usage sharing is optional. It sends feature counts and estimated screen time with a random installation identifier. Habit and task names, notes, goals, logged values and account details are never sent. Turning it off deletes pending usage data. Crash sharing is separate and is not available yet.\n\nNo ads. An account is optional; without one, your habits stay on this phone unless you share them.")
            }
        }
        .analyticsScreen(.privacy)
        .navigationTitle("Privacy & Security")
        .task(id: scenePhase == .active) { if scenePhase == .active { ability = await AppLock.ability() } }
        .navigationDestination(isPresented: $perfAppLock) { AppLockPage() }
        .onPerfCommand { action in
            if case .openAppLock = action { perfAppLock = true }
        }
    }

    /// The footer under Hide Names Outside the App (spec §4, screen 1). The rest (the timer on the Lock Screen, ✓ and +
    /// keep working, Reminder Says) is in Help → "Hide names outside the app" (U5).
    static let hideNamesLine = "Widgets, reminders, alarms and Siri show icons and numbers instead of habit names."

    private func setHideNames(_ on: Bool) {
        guard !lock.isOn else { return }
        hideNames = on
        HideNames.setChosen(on)
        Analytics.shared.event(.preference, ["setting": .text("widget_privacy"), "value": .text(on ? "hidden" : "visible")], ticket: Analytics.shared.ticket)
        store.analyticsConfiguration()
        Task { await AppModel.shared.privacyChanged() }
    }
}

/// The App Lock row (spec §4, screen 1): a grey tile with a lock, as iOS Settings rows, "App Lock", what it's for under
/// it, and Off or On.
private struct AppLockRow: View {
    let subtitle: String
    let on: Bool

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "lock.fill")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 29, height: 29)
                .background(RoundedRectangle(cornerRadius: 7, style: .continuous).fill(Color.gray))
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 2) {
                Text("App Lock").foregroundStyle(Color.primary)
                Text(subtitle).font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer(minLength: 8)
            Text(on ? "On" : "Off").foregroundStyle(.secondary)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("App Lock, \(on ? "On" : "Off"), \(subtitle)")
    }
}

/// The words App Lock uses in more than one place (spec §2, §5): "the app", never the app's name; "app passcode".
enum AppLockText {
    /// "Lock the app with Face ID" (Touch ID, Optic ID); with no biometrics, "…with your passcode".
    static func rowSubtitle(_ ability: AppLock.Ability?) -> String {
        guard let ability, ability.biometrics else { return ability == nil ? "Lock the app with Face ID" : "Lock the app with your passcode" }
        return "Lock the app with \(ability.method)"
    }

    /// "Face ID", or the method this iPhone has.
    static func method(_ ability: AppLock.Ability?) -> String {
        guard let ability, ability.biometrics else { return "Face ID" }
        return ability.method
    }

    static func lockAgain(_ seconds: Int) -> String {
        switch seconds { case 60: "After 1 Minute"; case 900: "After 15 Minutes"; default: "Immediately" }
    }
}

/// App Lock (spec §4, screens 2 and 7): one switch, off by default, like a messaging app's App lock. Everything else
/// appears only once it's on: the waiting reset, If Face ID doesn't work (inline), Change App Passcode, Use Face ID
/// Again and Lock Again. Turning the switch on never sets anything by itself: it stays off and the setup sheet opens
/// (`AppLockSetupSheet`); it reads on only once setup finishes. Nothing here can lock anyone out.
struct AppLockPage: View {
    @Environment(HabitStore.self) private var store
    @Environment(\.scenePhase) private var scenePhase
    @State private var ability: AppLock.Ability?
    @State private var askAgain = AppLock.askAgain
    @State private var setup: AppLockSetupSheet.Start?
    @State private var changingCode = false

    private var lock: AppLock { AppModel.shared.lock }

    var body: some View {
        @Bindable var lock = lock
        let on = lock.isOn
        let method = AppLockText.method(ability)
        Form {
            if on, lock.resetWaiting, let times = lock.resetTimes {
                Section {
                    VStack(alignment: .leading, spacing: 4) {
                        Label("App passcode reset asked for", systemImage: "hourglass").font(.headline)
                        Text("\(LockText.when(times.asked)). Ready \(LockText.when(times.ready)).").foregroundStyle(.secondary)
                    }
                    .accessibilityElement(children: .combine)
                    Button("Cancel Reset") { Task { await cancelReset() } }
                        .accessibilityIdentifier("privacy-cancel-reset")
                } footer: {
                    Text("If you didn't ask for this, cancel it.")
                }
            }
            Section {
                Toggle("Lock with \(ability?.method ?? "Face ID")", isOn: Binding(get: { lock.isOn }, set: { setLock($0) }))
                    .disabled(!on && ability?.available != true)
                    .accessibilityIdentifier("privacy-lock")
            } footer: {
                Text(lockFooter(on: on, method: ability?.method ?? "Face ID"))
            }
            if on {
                if ability?.biometrics == true || lock.mode == .code {
                    Section {
                        modeRow(.passcode, "iPhone Passcode", id: "unlock-iphone-passcode")
                        modeRow(.code, "App Passcode", id: "unlock-app-passcode")
                    } header: {
                        Text("If \(method) doesn't work")
                    } footer: {
                        Text(lock.mode == .code
                             ? "Only \(method) or your app passcode opens the app. Your iPhone passcode can't."
                             : "Anyone who knows your iPhone passcode can open the app.")
                    }
                }
                if lock.mode == .code {
                    Section {
                        Button {
                            Task { if await lock.confirmOwner("Change your app passcode") { changingCode = true } }
                        } label: {
                            HStack {
                                Text("Change App Passcode").foregroundStyle(Color.primary)
                                Spacer()
                                Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary)
                            }
                            .contentShape(Rectangle())
                        }
                        .accessibilityIdentifier("privacy-change-code")
                        if lock.faceIDOff && ability?.biometrics == true {
                            Button("Use \(method) Again") { Task { await lock.useFaceIDAgain() } }
                                .accessibilityIdentifier("privacy-use-face-id-again")
                        }
                    } footer: {
                        if lock.faceIDOff { Text("\(method) is off for the app. Turn it back on with Use \(method) Again.") }
                    }
                }
                Section {
                    Picker("Lock Again", selection: Binding(get: { askAgain }, set: { askAgain = $0; AppLock.askAgain = $0 })) {
                        ForEach([0, 60, 900], id: \.self) { Text(AppLockText.lockAgain($0)).tag($0) }
                    }
                    .pickerStyle(.menu)
                    .accessibilityIdentifier("privacy-lock-again")
                } footer: {
                    Text("After you leave the app. Locking your iPhone always locks the app straight away.")
                }
            }
        }
        .navigationTitle("App Lock")
        .navigationBarTitleDisplayMode(.inline)
        .task(id: scenePhase == .active) { if scenePhase == .active { ability = await AppLock.ability() } }
        .onAppear { askAgain = AppLock.askAgain }
        .sheet(item: $setup) { start in
            AppLockSetupSheet(lock: lock, start: start, method: method) { turnedOn in
                setup = nil
                if turnedOn { changed() }
            }
        }
        .sheet(isPresented: $changingCode) {
            NewCodeSheet(lock: lock, title: "Change App Passcode") { _ in changingCode = false }
        }
        .sheet(item: $lock.codeCheck) { check in CodeCheckSheet(lock: lock, check: check) }
        .onPerfCommand { action in
            switch action {
            case .openLockSetup: setup = .choose
            case .close: setup = nil
            default: break
            }
        }
    }

    private func lockFooter(on: Bool, method: String) -> String {
        if on { return "Habit names are hidden on widgets, reminders and Siri while App Lock is on." }
        if ability?.available == false { return "To use App Lock, set a passcode for this iPhone first: Settings → Face ID & Passcode." }
        return "The app will ask for \(method) each time you open it.\n\nWidgets and reminders keep working, without habit names."
    }

    private func modeRow(_ mode: AppLock.Mode, _ title: String, id: String) -> some View {
        let selected = lock.mode == mode
        return Button { choose(mode) } label: {
            HStack {
                Text(title).foregroundStyle(Color.primary)
                Spacer()
                if selected { Image(systemName: "checkmark").fontWeight(.semibold).foregroundStyle(Color.ink) }
            }
            .contentShape(Rectangle())
        }
        .accessibilityAddTraits(selected ? .isSelected : [])
        .accessibilityIdentifier(id)
    }

    /// On: the setup sheet first (nothing turns on until it finishes); an iPhone with no Face ID or Touch ID turns on in
    /// iPhone-passcode mode straight away (an app passcode there could only be reset by the 24-hour wait). Off: Face ID
    /// or, in app-passcode mode, the app passcode (never the iPhone passcode).
    private func setLock(_ on: Bool) {
        Task { @MainActor in
            if on {
                guard let ability, ability.available else { return }
                if ability.biometrics {
                    setup = .choose
                    return
                }
                guard await AppLock.authenticate(reason: "Turn on App Lock") else { return }
                AppLock.setEnabled(true)
                lock.bump()
            } else {
                guard await lock.confirmOwner("Turn off App Lock") else { return }
                lock.turnOff()
            }
            changed()
        }
    }

    /// If Face ID doesn't work: App Passcode opens the setup sheet at "How your app passcode works"; back to iPhone
    /// Passcode needs Face ID or the app passcode (never the iPhone passcode itself).
    private func choose(_ mode: AppLock.Mode) {
        guard mode != lock.mode else { return }
        Task { @MainActor in
            switch mode {
            case .code:
                setup = .appPasscode
            case .passcode:
                guard await lock.confirmOwner("Use your iPhone passcode for the app") else { return }
                lock.removeCode()
                AppLock.setEnabled(true)
                lock.bump()
            }
        }
    }

    private func cancelReset() async {
        guard await lock.confirmOwner("Cancel the reset") else { return }
        LockKeychain.update { $0.cancelReset() }
        lock.bump()
    }

    /// The next widget, reminder, alarm and timer already follow the change (spec §2.3).
    private func changed() {
        store.analyticsConfiguration()
        Task { await AppModel.shared.privacyChanged() }
    }
}
