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
                    AppLockRow(subtitle: AppLockText.rowSubtitle(ability, way: lockOn ? lock.way : nil), on: lockOn)
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

/// The words App Lock uses in more than one place (spec §2, §5, round 2): "the app", never the app's name; "app
/// passcode".
enum AppLockText {
    /// Off: "Lock the app with Face ID or a passcode"; on: how it opens ("Opens with Face ID").
    static func rowSubtitle(_ ability: AppLock.Ability?, way: LockWay?) -> String {
        switch way {
        case .faceID: "Opens with \(method(ability))"
        case .iPhonePasscode: "Opens with your iPhone passcode"
        case .appPasscode: "Opens with your app passcode"
        case nil: ability?.biometrics == false ? "Lock the app with a passcode" : "Lock the app with \(method(ability)) or a passcode"
        }
    }

    /// "Face ID", or Touch ID / Optic ID on those iPhones.
    static func method(_ ability: AppLock.Ability?) -> String {
        guard let ability, ability.method != "Passcode" else { return "Face ID" }
        return ability.method
    }

    /// A2–A5's Face ID line: what it does, or why it can't be used here.
    static func faceIDDetail(_ ability: AppLock.Ability?) -> String {
        let name = method(ability)
        guard let ability else { return "Quickest. If \(name) can't recognise you, your app passcode opens the app." }
        if !ability.available { return "Needs a passcode on this iPhone." }
        if ability.biometricsAllowed { return "Quickest. If \(name) can't recognise you, your app passcode opens the app." }
        if ability.biometrics { return "Can't be used: \(name) is turned off for this app in Settings." }
        return "Not set up on this iPhone. Set it up in Settings › Face ID & Passcode."
    }

    /// A2–A5's iPhone Passcode line. iOS asks Face ID first whenever the app may use it, so the line says so.
    static func iPhonePasscodeDetail(_ ability: AppLock.Ability?) -> String {
        guard let ability else { return "As when you unlock your iPhone: Face ID, or your iPhone passcode. Anyone who knows it can open the app." }
        if !ability.available { return "This iPhone has no passcode." }
        if ability.biometricsAllowed {
            return "As when you unlock your iPhone: \(method(ability)), or your iPhone passcode. Anyone who knows it can open the app."
        }
        return "Your iPhone passcode opens the app. Anyone who knows it can open the app."
    }

    /// A6–A8: what the app passcode is for in each way.
    static func explainer(_ way: LockWay, method: String) -> (heading: String, sub: String, rules: [(String, String)]) {
        switch way {
        case .faceID:
            ("Now create an app passcode", "It opens the app whenever \(method) can't.", [
                ("When it's asked", "If \(method) can't recognise you, is turned off for the app, or was changed on your iPhone."),
                ("If you forget it", "\(method) sets a new one straight away."),
                ("If \(method) can't help either", "Your iPhone passcode sets a new one after a 24-hour wait. The wait gives you time to cancel it if it wasn't you.")])
        case .iPhonePasscode:
            ("Now create an app passcode", "It opens the app if this iPhone's passcode is ever turned off.", [
                ("When it's asked", "Only if this iPhone has no passcode any more."),
                ("If you forget it", "Your iPhone passcode sets a new one straight away. With no iPhone passcode, after a 24-hour wait.")])
        case .appPasscode:
            ("Create your app passcode", "It's the only way into the app.", [
                ("Every time you open the app", "\(method) and your iPhone passcode won't open it."),
                ("If you forget it", "Ask for a reset. After 24 hours you choose a new app passcode."),
                ("Why the wait", "It gives you time to notice and cancel it if it wasn't you: entering your app passcode cancels it.")])
        }
    }

    /// Under the first entry's dots (5): when this passcode will be needed.
    static func whenNeeded(_ way: LockWay, method: String) -> String {
        switch way {
        case .faceID: "You'll need it when \(method) can't be used."
        case .iPhonePasscode: "You'll only need it if this iPhone's passcode is turned off."
        case .appPasscode: "You'll enter it each time you open the app."
        }
    }

    static func lockAgain(_ seconds: Int) -> String {
        switch seconds { case 60: "After 1 Minute"; case 900: "After 15 Minutes"; default: "Immediately" }
    }
}

/// App Lock (spec round 2, A1 and B1–B4): one switch, App Lock, never named for Face ID. Off, nothing else; turning it on
/// never sets anything by itself: it stays off and the setup sheet opens (`AppLockSetupSheet`), and it reads on only once
/// the app passcode is saved. On: a waiting reset, Open the app with (Face ID, iPhone Passcode, App Passcode, each saying
/// when it can't be used), Change App Passcode, Use Face ID Again and Lock Again. Nothing here can lock anyone out.
struct AppLockPage: View {
    @Environment(HabitStore.self) private var store
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.openURL) private var openURL
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
                Toggle("App Lock", isOn: Binding(get: { lock.isOn }, set: { setLock($0) }))
                    .accessibilityIdentifier("privacy-lock")
            } footer: {
                Text(on ? "Habit names are hidden on widgets, reminders and Siri while App Lock is on."
                        : "The app asks for \(method) or a passcode each time you open it.\n\nWidgets and reminders keep working, without habit names.")
            }
            if on {
                let way = lock.way
                Section {
                    wayRow(.faceID, method, detail: faceIDRowDetail(way, method: method), id: "unlock-face-id")
                    if ability?.biometrics == true && ability?.biometricsAllowed == false {
                        AllowFaceIDRow(method: method) {
                            if let url = URL(string: UIApplication.openSettingsURLString) { openURL(url) }
                        }
                    }
                    wayRow(.iPhonePasscode, "iPhone Passcode",
                           detail: ability?.available == false ? "This iPhone has no passcode." : nil, id: "unlock-iphone-passcode")
                    wayRow(.appPasscode, "App Passcode", detail: nil, id: "unlock-app-passcode")
                } header: {
                    Text("Open the app with")
                } footer: {
                    Text(wayFooter(way, method: method))
                }
                Section {
                    Button {
                        if lock.hasCode {
                            Task { if await lock.confirmOwner("Change your app passcode") { changingCode = true } }
                        } else {
                            // An older iPhone Passcode lock: its backup app passcode, made now.
                            Task { if await lock.confirmOwner("Create your app passcode") { setup = .create(.iPhonePasscode) } }
                        }
                    } label: {
                        HStack {
                            Text(lock.hasCode ? "Change App Passcode" : "Create App Passcode").foregroundStyle(Color.primary)
                            Spacer()
                            Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary)
                        }
                        .contentShape(Rectangle())
                    }
                    .accessibilityIdentifier("privacy-change-code")
                    if useFaceIDAgain {
                        Button("Use \(method) Again") { Task { await lock.useFaceIDAgain() } }
                            .accessibilityIdentifier("privacy-use-face-id-again")
                    }
                } footer: {
                    if useFaceIDAgain { Text("\(method) is off for the app. Turn it back on with Use \(method) Again.") }
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
        .task(id: scenePhase == .active) {
            if scenePhase == .active { ability = await AppLock.ability(); lock.bump() }
        }
        .onAppear { askAgain = AppLock.askAgain }
        .sheet(item: $setup) { start in
            AppLockSetupSheet(lock: lock, start: start, ability: ability) { turnedOn in
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

    /// The Face ID way, Face ID allowed for the app but not trusted (turned off on the cover, or the passcode was made
    /// while Face ID was switched off for the app).
    private var useFaceIDAgain: Bool { lock.way == .faceID && ability?.biometricsAllowed == true && lock.faceIDNotTrusted }

    /// Why Face ID can't be chosen, or (chosen) why it isn't opening the app now.
    private func faceIDRowDetail(_ way: LockWay, method: String) -> String? {
        guard let ability else { return nil }
        if !ability.available { return "Needs a passcode on this iPhone." }
        if ability.biometrics && !ability.biometricsAllowed { return "Turned off for this app in Settings." }
        if !ability.biometrics { return "Not set up on this iPhone." }
        return nil
    }

    private func wayFooter(_ way: LockWay, method: String) -> String {
        switch way {
        case .faceID:
            if ability?.available == false { return "This iPhone has no passcode now, so \(method) can't be used. Your app passcode opens the app." }
            if ability?.biometricsAllowed == false { return "Until \(method) is allowed, your app passcode opens the app." }
            return "If \(method) can't recognise you, your app passcode opens the app. Your iPhone passcode can't."
        case .iPhonePasscode:
            if ability?.available == false {
                return lock.hasCode ? "This iPhone has no passcode now. Your app passcode opens the app."
                                    : "This iPhone has no passcode now, so nothing can lock the app. Create an app passcode."
            }
            let opens = ability?.biometricsAllowed == true ? "\(method) or your iPhone passcode opens the app." : "Your iPhone passcode opens the app."
            return lock.hasCode ? opens + " Your app passcode is the backup if this iPhone's passcode is turned off."
                                : opens + " Create an app passcode as a backup, in case this iPhone's passcode is turned off."
        case .appPasscode:
            return "Only your app passcode opens the app. \(method) and your iPhone passcode can't."
        }
    }

    private func available(_ way: LockWay) -> Bool {
        switch way {
        case .faceID: ability?.biometricsAllowed == true
        case .iPhonePasscode: ability?.available != false
        case .appPasscode: true
        }
    }

    /// A way that can be chosen (or the one chosen) is a button; one that can't is plain text with its reason fully
    /// readable (a disabled button fades its whole label).
    @ViewBuilder private func wayRow(_ way: LockWay, _ title: String, detail: String?, id: String) -> some View {
        let selected = lock.way == way
        let enabled = selected || available(way)
        let label = HStack(alignment: detail == nil ? .center : .firstTextBaseline) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title).foregroundStyle(enabled ? Color.primary : Color.secondary)
                if let detail { Text(detail).font(.subheadline).foregroundStyle(.secondary) }
            }
            Spacer()
            if selected { Image(systemName: "checkmark").fontWeight(.semibold).foregroundStyle(Color.ink) }
        }
        if enabled {
            Button { choose(way) } label: { label.contentShape(Rectangle()) }
                .accessibilityElement(children: .combine)
                .accessibilityAddTraits(selected ? [.isSelected, .isButton] : .isButton)
                .accessibilityIdentifier(id)
        } else {
            label
                .accessibilityElement(children: .combine)
                .accessibilityIdentifier(id)
        }
    }

    /// On: always the setup sheet first (nothing turns on until the app passcode is saved). Off: the owner, by the
    /// everyday way (the App Passcode way only its passcode; the Face ID way never the iPhone passcode).
    private func setLock(_ on: Bool) {
        Task { @MainActor in
            if on {
                setup = .choose
                return
            }
            guard await lock.confirmOwner("Turn off App Lock") else { return }
            lock.turnOff()
            changed()
        }
    }

    /// Another everyday way: the current way confirms the owner first; the app passcode is already there (an older lock
    /// without one makes it now).
    private func choose(_ way: LockWay) {
        guard way != lock.way, available(way) else { return }
        Task { @MainActor in
            guard await lock.confirmOwner("Change how the app opens") else { return }
            if !lock.hasCode, way != .iPhonePasscode {
                setup = .create(way)
                return
            }
            if await lock.useWay(way) { changed() }
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
