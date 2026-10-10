import SwiftUI
import UIKit

// The lock's screens (Privacy & Security spec §3): the cover, the keypad, choosing a code, Forgot Your Code, and the
// code question the page asks in code mode. Native parts only (U1), monochrome chrome (U2), plain words (U11).

/// What shows instead of the app while it's locked, or while it isn't in front (so the app switcher shows this, not the
/// habits). In its own window (`LockWindow`), hidden while the app is unlocked and in front, so it costs nothing then (S6).
struct LockCover: View {
    let lock: AppLock
    /// false: only covering (the app isn't in front), nothing to answer.
    let locked: Bool

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            if locked {
                LockedScreen(lock: lock)
            } else {
                LockTitle(title: "The app is locked", detail: nil)
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("app-lock-cover")
    }
}

/// The cover's own window, above the app's window, so it covers everything the app shows: sheets, alerts and pushed
/// pages too. An overlay on the app's root view sat under a presented sheet, and a half-typed New Habit form showed
/// over the locked cover (AppLockUITests, run 37883781520). Shown while locked, or while the app isn't in front (the app
/// switcher's picture). Locking ends typing (`AppLock.lockNow`): the keyboard sits above every window.
@MainActor enum LockWindow {
    private static var window: UIWindow?

    static func show(_ shown: Bool, lock: AppLock) {
        if shown {
            guard let window = window ?? make(lock) else { return }
            guard window.isHidden else { return }
            if let scene = window.windowScene {
                window.overrideUserInterfaceStyle = scene.windows.first { $0 !== window }?.overrideUserInterfaceStyle ?? .unspecified
            }
            window.makeKeyAndVisible()
        } else if let window, !window.isHidden {
            // Anything still open on the cover (Forgot Your Code, a code sheet) goes with it, so it never comes back
            // over the next lock.
            window.rootViewController?.presentedViewController?.dismiss(animated: false)
            window.isHidden = true
            window.windowScene?.windows.first { $0 !== window && $0.windowLevel == .normal }?.makeKey()
        }
    }

    private static func make(_ lock: AppLock) -> UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene }).first else { return nil }
        let host = UIHostingController(rootView: LockWindowRoot(lock: lock))
        host.view.backgroundColor = .clear
        let made = UIWindow(windowScene: scene)
        made.windowLevel = .alert
        made.rootViewController = host
        made.isHidden = true
        window = made
        return made
    }
}

private struct LockWindowRoot: View {
    let lock: AppLock
    var body: some View {
        LockCover(lock: lock, locked: lock.isLocked).tint(.ink)
    }
}

private struct LockTitle: View {
    let title: String
    let detail: String?

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "lock.fill")
                .font(.system(size: 36, weight: .semibold))
                .foregroundStyle(.secondary)
                .accessibilityHidden(true)
            Text(title).font(.title3.weight(.semibold)).multilineTextAlignment(.center)
                .accessibilityIdentifier("lock-title")
            if let detail {
                Text(detail).font(.subheadline).foregroundStyle(.secondary).multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.horizontal, 24)
    }
}

/// The locked cover (spec round 2, C1–C6): Unlock for the iPhone Passcode way; otherwise the keypad, with Use Face ID
/// when Face ID is trusted, the reason when it can't be used, a waiting reset, and Forgot App Passcode?.
private struct LockedScreen: View {
    @Bindable var lock: AppLock

    var body: some View {
        // With room, the screen's parts are spread over the whole height, as the iPhone's own lock screen (the keypad
        // sat high with the bottom empty, 10 Oct 2026); with text too large to fit, the same parts scroll.
        ViewThatFits(in: .vertical) {
            content(spread: true)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            ScrollView {
                content(spread: false)
                    .padding(.vertical, 24)
                    .frame(maxWidth: .infinity)
            }
            .scrollBounceBehavior(.basedOnSize)
            .defaultScrollAnchor(.center)
        }
        // After a wait the keypad takes codes again by itself.
        .task(id: lock.waitText) { await lock.waitOut() }
        .sheet(item: $lock.coverSheet) { sheet in
            switch sheet {
            case .forgot: ForgotCodeSheet(lock: lock)
            case .newCode: NewCodeSheet(lock: lock, title: "Choose a New App Passcode")
            }
        }
        // Asked once, on the cover, before the app opens (spec screen 10; T16). An alert, not a sheet: the app asks, the
        // person didn't start it, and it can't be swiped away unanswered. No is the cancel role: the bold, safe default.
        .alert("Did you change Face ID?", isPresented: $lock.askTrustFaceID) {
            Button("Yes, Use Face ID") { lock.trustFaceID(true) }
            Button("No, Turn It Off", role: .cancel) { lock.trustFaceID(false) }
        } message: {
            Text("If not, someone may have added their face. Turn it off and check Settings → Face ID & Passcode.")
        }
    }

    @ViewBuilder private func content(spread: Bool) -> some View {
        VStack(spacing: 20) {
            if spread { Spacer(minLength: 0) }
            switch lock.step {
            case .iPhonePasscode, .open:
                LockTitle(title: "The app is locked", detail: nil)
                Button { Task { await lock.unlock() } } label: {
                    Text("Unlock").fontWeight(.semibold).foregroundStyle(Color.onInk).frame(minWidth: 120)
                }
                .buttonStyle(.borderedProminent).tint(.ink)
                .accessibilityIdentifier("app-unlock")
            case .resetReady:
                resetReadyScreen
            case .code:
                codeScreen(spread: spread)
            }
            if spread { Spacer(minLength: 0) }
        }
    }

    /// C6: the 24 hours are up. The Face ID way on an iPhone with a passcode asks the iPhone passcode first.
    @ViewBuilder private var resetReadyScreen: some View {
        LockTitle(title: "The 24 hours are up",
                  detail: lock.way == .faceID && lock.passcodeSet
                      ? "Choose a new app passcode with your iPhone passcode."
                      : "You can choose a new app passcode now.")
        Button {
            Task { if await lock.chooseNewCodeAfterReset() { lock.coverSheet = .newCode } }
        } label: {
            Text("Choose a New App Passcode").fontWeight(.semibold).foregroundStyle(Color.onInk).frame(minWidth: 180)
        }
        .buttonStyle(.borderedProminent).tint(.ink)
        .accessibilityIdentifier("lock-choose-new-code")
    }

    /// C1–C5 and screen 9: the keypad, and why Face ID isn't being asked when it isn't.
    @ViewBuilder private func codeScreen(spread: Bool) -> some View {
        let changed = lock.faceIDChanged
        if changed {
            // Screen 9: the line under the title already asks, so the keypad's own prompt is left out.
            LockTitle(title: "Face ID was changed", detail: "Enter your app passcode to open the app.")
        } else if lock.way != .appPasscode && !lock.passcodeSet {
            // C3: the iPhone passcode (and Face ID with it) was turned off; the backup app passcode opens the app.
            LockTitle(title: "This iPhone has no passcode now", detail: nil)
        } else if lock.faceIDNotAllowed {
            // C2: Face ID was switched off for the app in Settings after it was chosen.
            LockTitle(title: "The app is locked", detail: "Face ID is turned off for the app in Settings.")
        } else {
            LockTitle(title: "The app is locked", detail: nil)
        }
        if let times = lock.resetTimes, lock.resetWaiting { ResetWaitingBox(lock: lock, asked: times.asked, ready: times.ready) }
        if lock.faceIDUsable {
            Button("Use Face ID") { Task { await lock.unlock() } }
                .fontWeight(.semibold)
                .accessibilityIdentifier("lock-use-face-id")
        }
        CodeEntry(prompt: changed ? "" : "Enter your app passcode", message: lock.message, shakes: lock.wrongCount,
                  disabled: lock.waitText != nil, spread: spread) { code in
            await lock.enter(code)
        }
        if !lock.resetWaiting {
            Button("Forgot App Passcode?") { lock.coverSheet = .forgot }
                .accessibilityIdentifier("lock-forgot")
        }
    }
}

/// "App passcode reset asked for · Tue 10:14. You can choose a new app passcode from Wed 10:14." with Cancel Reset.
private struct ResetWaitingBox: View {
    let lock: AppLock
    let asked: Date
    let ready: Date

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Label("App passcode reset asked for", systemImage: "hourglass").font(.headline)
            Text("\(LockText.when(asked)). You can choose a new app passcode from \(LockText.when(ready)).")
                .font(.subheadline)
            Text(lock.faceIDUsable
                 ? "If you didn't ask for this, cancel it with Face ID or your app passcode."
                 : "If you didn't ask for this, enter your app passcode to cancel it.")
                .font(.subheadline).foregroundStyle(.secondary)
            if lock.faceIDUsable {
                Button("Cancel Reset") {
                    Task { _ = await lock.cancelReset() }
                }
                .fontWeight(.semibold)
                .padding(.top, 4)
                .accessibilityIdentifier("lock-cancel-reset")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 12, style: .continuous).fill(Color(.secondarySystemGroupedBackground)))
        .padding(.horizontal, 24)
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("lock-reset-waiting")
    }
}

enum LockText {
    /// "Tue 10:14", in the person's own clock style.
    static func when(_ date: Date) -> String {
        date.formatted(.dateTime.weekday(.abbreviated).hour().minute())
    }
}

// MARK: - The keypad

/// Six dots and a number pad, as the iPhone's own (spec §3.1): the code is handed on when the sixth digit is typed.
struct CodeEntry: View {
    let prompt: String
    let message: String?
    /// Changes on each wrong code: the dots shake.
    let shakes: Int
    var disabled = false
    /// On a passcode screen with room to spare (`CodeScreen`): the prompt and dots stay up, the keypad goes low, as the
    /// iPhone's own passcode screen.
    var spread = false
    let onCode: @MainActor (String) async -> Void

    @State private var typed = ""
    @State private var offset: CGFloat = 0
    @State private var busy = false

    var body: some View {
        VStack(spacing: 16) {
            // The stack's own spacing keeps the gaps; the spacers only share what's left (minimums made the cover too
            // tall to fit, so it fell back to scrolling).
            if spread { Spacer(minLength: 0) }
            if !prompt.isEmpty { Text(prompt).font(.headline).accessibilityIdentifier("code-prompt") }
            HStack(spacing: 16) {
                ForEach(0..<6, id: \.self) { i in
                    Circle()
                        .strokeBorder(Color.primary, lineWidth: 1.5)
                        .background(Circle().fill(i < typed.count ? Color.primary : .clear))
                        .frame(width: 13, height: 13)
                }
            }
            .offset(x: offset)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("\(typed.count) of 6 digits entered")
            .accessibilityIdentifier("code-dots")
            Text(message ?? " ")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .frame(minHeight: 20)
                .accessibilityIdentifier("code-message")
            if spread { Spacer(minLength: 0) }
            CodeKeypad(disabled: disabled || busy) { key in press(key) }
            // The room left is shared evenly above the prompt, between the dots and the keypad, and below it, as on
            // the iPhone's own lock screen (a keypad pushed to the bottom left a gap in the middle, 10 Oct 2026).
            if spread { Spacer(minLength: 0) }
        }
        .padding(.horizontal, 24)
        .onChange(of: shakes) { shake() }
        .onPerfCommand { action in
            switch action {
            case .codeKey(let digit): press(.digit(digit))
            case .codeDelete: press(.delete)
            default: break
            }
        }
    }

    private func press(_ key: CodeKeypad.Key) {
        switch key {
        case .digit(let d):
            guard typed.count < 6 else { return }
            typed.append(String(d))
            guard typed.count == 6 else { return }
            let code = typed
            busy = true
            Task {
                await onCode(code)
                typed = ""
                busy = false
            }
        case .delete:
            if !typed.isEmpty { typed.removeLast() }
        }
    }

    private func shake() {
        UINotificationFeedbackGenerator().notificationOccurred(.error)
        withAnimation(.spring(response: 0.08, dampingFraction: 0.2)) { offset = 12 }
        Task {
            try? await Task.sleep(for: .milliseconds(90))
            withAnimation(.spring(response: 0.25, dampingFraction: 0.35)) { offset = 0 }
        }
    }
}

/// 1–9, 0 and Delete, in round keys that grow with the text and fit the iPhone SE.
struct CodeKeypad: View {
    enum Key: Equatable { case digit(Int), delete }
    var disabled = false
    let onKey: (Key) -> Void
    /// The iPhone's own passcode keys are about 78 pt; ours match, growing with the text up to 88.
    @ScaledMetric(relativeTo: .title) private var size: CGFloat = 76

    var body: some View {
        let side = min(size, 88)
        Grid(horizontalSpacing: 24, verticalSpacing: 14) {
            ForEach(0..<3, id: \.self) { row in
                GridRow {
                    ForEach(1...3, id: \.self) { column in key(row * 3 + column, side: side) }
                }
            }
            GridRow {
                Color.clear.frame(width: side, height: side)
                key(0, side: side)
                Button { onKey(.delete) } label: {
                    Image(systemName: "delete.left").font(.title2).frame(width: side, height: side).contentShape(Circle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Delete")
                .accessibilityIdentifier("code-delete")
            }
        }
        .disabled(disabled)
        .opacity(disabled ? 0.4 : 1)
    }

    private func key(_ digit: Int, side: CGFloat) -> some View {
        Button { onKey(.digit(digit)) } label: {
            Text("\(digit)").font(.title.weight(.medium)).monospacedDigit()
                .frame(width: side, height: side)
                .background(Circle().fill(Color(.tertiarySystemFill)))
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(digit)")
        .accessibilityIdentifier("code-key-\(digit)")
    }
}

/// Enter a six-digit passcode, then Enter it again; different: "The passcodes didn't match. Try again." and back to
/// the first (spec screens 5 and 6).
struct CodeSetup: View {
    /// Under the first entry's dots: when it will be needed (the everyday way's line), or nothing.
    var line: String? = nil
    var spread = false
    let onChosen: @MainActor (String) async -> Void
    @State private var first: String?
    @State private var message: String?
    @State private var mismatches = 0

    static let firstPrompt = "Enter a six-digit passcode"
    static let mismatch = "The passcodes didn't match. Try again."

    var body: some View {
        CodeEntry(prompt: first == nil ? Self.firstPrompt : "Enter it again", message: first == nil ? (message ?? line) : nil,
                  shakes: mismatches, spread: spread) { code in
            if let first {
                if first == code {
                    await onChosen(code)
                } else {
                    self.first = nil
                    message = Self.mismatch
                    mismatches += 1
                }
            } else {
                first = code
                message = nil
            }
        }
        .id(first == nil ? "first" : "second")
        // A code sheet over the locked cover has its own keypad; the container tells the two apart (T9).
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("code-setup")
    }
}

/// A passcode screen in a sheet (the user's iPhone check, 10 Oct 2026: the keypad sat high with the bottom of the screen
/// empty). With room, the prompt and dots sit near the top and the keypad low, as the iPhone's own passcode screen; with
/// text too large to fit, the same entry scrolls.
struct CodeScreen<Content: View>: View {
    /// The entry, told whether it has the whole height to spread over.
    @ViewBuilder let content: (Bool) -> Content

    var body: some View {
        ViewThatFits(in: .vertical) {
            content(true)
                .padding(.vertical, 16)
                .frame(maxHeight: .infinity)
            ScrollView {
                content(false).padding(.vertical, 24)
            }
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}

// MARK: - Sheets

/// The ✕ that closes a lock sheet without changing anything (U18).
private struct LockSheetClose: ToolbarContent {
    let action: () -> Void
    var body: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button(action: action) { Image(systemName: "xmark") }
                .accessibilityLabel("Cancel")
                .accessibilityIdentifier("lock-sheet-cancel")
        }
    }
}

/// Set Up App Lock (spec round 2, A2–A8, then 5–6), in its own navigation: how the app opens day to day (Face ID by
/// default, iPhone Passcode or App Passcode, each saying when it can't be used and why), then the app passcode, which is
/// always made: what it's for in the chosen way, the owner's Face ID or iPhone passcode once (not for App Passcode), the
/// six digits and the six digits again. Nothing is saved until the second entry matches; ✕, a failed check, a mismatch
/// or leaving part-way changes nothing (the switch stays off).
struct AppLockSetupSheet: View {
    enum Start: Identifiable, Equatable {
        /// From the switch: A2 first.
        case choose
        /// An older lock with no app passcode moving to another way: straight to its app passcode (the owner was
        /// confirmed on the page).
        case create(LockWay)
        var id: String { switch self { case .choose: "choose"; case .create(let way): way.rawValue } }
    }

    private enum Step: Hashable { case explain(LockWay), enter(LockWay), again(LockWay, String) }

    let lock: AppLock
    let start: Start
    /// What this iPhone can do, as the page last asked (asked again here on coming back from Settings).
    let ability: AppLock.Ability?
    let onDone: (Bool) -> Void
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.openURL) private var openURL
    @State private var path: [Step] = []
    @State private var picked: LockWay?
    @State private var fresh: AppLock.Ability?
    @State private var mismatch = false
    @State private var mismatches = 0
    @State private var checking = false

    private var can: AppLock.Ability? { fresh ?? ability }
    private var method: String { AppLockText.method(can) }
    private var faceIDAllowed: Bool { can?.biometricsAllowed == true }
    private var passcodeSet: Bool { can?.available != false }

    /// Face ID when the app may use it, otherwise the iPhone passcode, otherwise the app passcode.
    private var selected: LockWay {
        if let picked, available(picked) { return picked }
        return faceIDAllowed ? .faceID : passcodeSet ? .iPhonePasscode : .appPasscode
    }

    private func available(_ way: LockWay) -> Bool {
        switch way {
        case .faceID: faceIDAllowed
        case .iPhonePasscode: passcodeSet
        case .appPasscode: true
        }
    }

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                switch start {
                case .choose: choose
                case .create(let way): explain(way)
                }
            }
            .toolbar { LockSheetClose { onDone(false) } }
            .navigationDestination(for: Step.self) { step in
                switch step {
                case .explain(let way): explain(way)
                case .enter(let way): enter(way)
                case .again(let way, let first): again(way, first)
                }
            }
        }
        .interactiveDismissDisabled()
        .tint(.ink)
        .task(id: scenePhase == .active) { if scenePhase == .active { fresh = await AppLock.ability() } }
    }

    // MARK: A2–A5: How do you want to open the app?

    private var choose: some View {
        Form {
            Section {
                VStack(alignment: .leading, spacing: 6) {
                    Text("How do you want to open the app?").font(.title2.bold()).accessibilityAddTraits(.isHeader)
                    Text("Choose your everyday way. You can change it later in App Lock.")
                        .foregroundStyle(.secondary)
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 0, leading: 4, bottom: 4, trailing: 4))
            }
            Section {
                option(.faceID, method, AppLockText.faceIDDetail(can), id: "setup-face-id")
                if can?.biometrics == true && !faceIDAllowed {
                    AllowFaceIDRow(method: method) { openSettings() }
                }
                option(.iPhonePasscode, "iPhone Passcode", AppLockText.iPhonePasscodeDetail(can), id: "setup-iphone-passcode")
                option(.appPasscode, "App Passcode",
                       "Six digits, every time. \(method) and your iPhone passcode won't open it. Good if people around you know your iPhone passcode.",
                       id: "setup-app-passcode")
            } footer: {
                if !passcodeSet { Text("To use \(method) or your iPhone passcode, set a passcode in Settings › Face ID & Passcode.") }
            }
        }
        .contentMargins(.top, 8, for: .scrollContent)
        .navigationTitle("Set Up App Lock")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            RecordBottomBar {
                DayButton("Continue", prominent: true, id: "setup-continue") { path.append(.explain(selected)) }
            }
        }
    }

    /// A way that can be chosen is a button; one that can't is plain text whose title is greyed and whose reason stays
    /// fully readable (a disabled button fades its whole label, the reason too: the user's iPhone, 10 Oct 2026).
    @ViewBuilder private func option(_ way: LockWay, _ title: String, _ detail: String, id: String) -> some View {
        let isSelected = selected == way
        let label = HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title).foregroundStyle(available(way) ? Color.primary : Color.secondary)
                Text(detail).font(.subheadline).foregroundStyle(.secondary).fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 8)
            if isSelected { Image(systemName: "checkmark").fontWeight(.semibold).foregroundStyle(Color.ink) }
        }
        if available(way) {
            Button { picked = way } label: { label.contentShape(Rectangle()) }
                .accessibilityElement(children: .combine)
                .accessibilityAddTraits(isSelected ? [.isSelected, .isButton] : .isButton)
                .accessibilityIdentifier(id)
        } else {
            label
                .accessibilityElement(children: .combine)
                .accessibilityIdentifier(id)
        }
    }

    private func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) { openURL(url) }
    }

    // MARK: A6–A8: the app passcode, for the chosen way

    private func explain(_ way: LockWay) -> some View {
        let text = AppLockText.explainer(way, method: method)
        return Form {
            Section {
                VStack(alignment: .leading, spacing: 6) {
                    Text(text.heading).font(.title2.bold()).accessibilityAddTraits(.isHeader)
                    Text(text.sub).foregroundStyle(.secondary)
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 0, leading: 4, bottom: 4, trailing: 4))
            }
            Section {
                ForEach(text.rules, id: \.0) { rule($0.0, $0.1) }
            } footer: {
                Text("Your habits are never deleted, whatever happens.")
            }
        }
        .contentMargins(.top, 8, for: .scrollContent)
        .navigationTitle("App Passcode")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            RecordBottomBar {
                DayButton("Create App Passcode", prominent: true, id: "setup-create-app-passcode") { Task { await createAppPasscode(way) } }
                    .disabled(checking)
            }
        }
    }

    private func rule(_ title: String, _ detail: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title).fontWeight(.semibold)
            Text(detail).font(.subheadline).foregroundStyle(.secondary).fixedSize(horizontal: false, vertical: true)
        }
        .padding(.vertical, 2)
        .accessibilityElement(children: .combine)
    }

    /// Face ID or the iPhone passcode once (iOS asks "Allow Face ID?" here the first time), so the way chosen is shown
    /// to work; the App Passcode way has nothing else to check. Not again for an older lock moving ways (the page
    /// confirmed the owner).
    private func createAppPasscode(_ way: LockWay) async {
        checking = true
        defer { checking = false }
        if way != .appPasscode, start == .choose {
            guard await AppLock.authenticate(reason: "Create your app passcode") else { return }
        }
        mismatch = false
        path.append(.enter(way))
    }

    // MARK: 5 and 6: Enter, then enter it again

    private func enter(_ way: LockWay) -> some View {
        CodeScreen { spread in
            CodeEntry(prompt: CodeSetup.firstPrompt, message: mismatch ? CodeSetup.mismatch : AppLockText.whenNeeded(way, method: method),
                      shakes: mismatches, spread: spread) { code in
                mismatch = false
                path.append(.again(way, code))
            }
            .accessibilityElement(children: .contain)
            .accessibilityIdentifier("code-setup")
        }
        .navigationTitle("App Passcode")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func again(_ way: LockWay, _ first: String) -> some View {
        CodeScreen { spread in
            CodeEntry(prompt: "Enter it again", message: nil, shakes: 0, spread: spread) { code in
                if code == first {
                    await lock.saveCode(code, way: way)
                    onDone(true)
                } else {
                    // Back to the first entry, cleared, saying why.
                    mismatch = true
                    mismatches += 1
                    path.removeLast()
                }
            }
            .accessibilityElement(children: .contain)
            .accessibilityIdentifier("code-setup")
        }
        .navigationTitle("App Passcode")
        .navigationBarTitleDisplayMode(.inline)
    }
}

/// "Allow Face ID in Settings": Face ID is set up but switched off for the app; iOS lets an app open only its own page
/// in Settings, which has the switch (A3, B4).
struct AllowFaceIDRow: View {
    let method: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text("Allow \(method) in Settings").fontWeight(.semibold).foregroundStyle(Color.primary)
                Spacer()
                Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary)
            }
            .contentShape(Rectangle())
        }
        .accessibilityIdentifier("privacy-allow-face-id")
    }
}

/// Change App Passcode, or a new app passcode after a reset: the passcode twice.
struct NewCodeSheet: View {
    let lock: AppLock
    let title: String
    var onDone: ((Bool) -> Void)? = nil
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            CodeScreen { spread in
                CodeSetup(line: AppLockText.whenNeeded(lock.way, method: "Face ID"), spread: spread) { code in
                    await lock.saveCode(code)
                    finish(true)
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { LockSheetClose { finish(false) } }
        }
        .interactiveDismissDisabled()
    }

    private func finish(_ saved: Bool) {
        if let onDone { onDone(saved) } else { lock.coverSheet = nil; dismiss() }
    }
}

/// "Forgot App Passcode" (spec round 2, D1–D4): the way back in follows the everyday way. Face ID (unchanged) or the
/// iPhone passcode (the iPhone Passcode way) sets a new one at once; when Face ID can't help, the iPhone passcode starts
/// a 24-hour wait; the App Passcode way, or an iPhone with no passcode, has the wait alone. Nothing is ever deleted.
struct ForgotCodeSheet: View {
    let lock: AppLock
    @State private var choosing = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Group {
                if choosing {
                    CodeScreen { spread in
                        CodeSetup(spread: spread) { code in
                            await lock.saveCode(code)
                            lock.coverSheet = nil
                            dismiss()
                        }
                    }
                } else {
                    let forgot = lock.forgotWay
                    Form {
                        Section {
                            VStack(alignment: .leading, spacing: 12) {
                                Text(Self.heading(forgot)).font(.title2.bold()).accessibilityAddTraits(.isHeader)
                                ForEach(Self.lines(forgot), id: \.self) { Text($0).fixedSize(horizontal: false, vertical: true) }
                                if lock.resetWaiting { Text("A reset is already waiting.").foregroundStyle(.secondary) }
                            }
                            .listRowBackground(Color.clear)
                            .listRowInsets(EdgeInsets(top: 0, leading: 4, bottom: 4, trailing: 4))
                        }
                    }
                    .contentMargins(.top, 8, for: .scrollContent)
                    .safeAreaInset(edge: .bottom) {
                        RecordBottomBar {
                            switch forgot {
                            case .faceID, .iPhonePasscode:
                                DayButton(forgot == .faceID ? "Use Face ID" : "Use iPhone Passcode", prominent: true,
                                          id: forgot == .faceID ? "lock-forgot-face-id" : "lock-forgot-iphone-passcode") {
                                    Task { if await lock.forgotAtOnce() { choosing = true } }
                                }
                            case .resetWithPasscode, .resetAlone:
                                DayButton("Start 24-Hour Reset", prominent: true, id: "lock-start-reset") {
                                    Task { await lock.startReset(); if lock.resetWaiting { dismiss() } }
                                }
                                .disabled(lock.resetWaiting)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Forgot App Passcode")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { LockSheetClose { lock.coverSheet = nil; dismiss() } }
        }
    }

    static func heading(_ forgot: AppLock.ForgotWay) -> String {
        switch forgot {
        case .faceID, .iPhonePasscode: "Choose a new app passcode"
        case .resetWithPasscode, .resetAlone: "Reset your app passcode"
        }
    }

    static func lines(_ forgot: AppLock.ForgotWay) -> [String] {
        switch forgot {
        case .faceID: ["Face ID can prove it's you.", "Your habits stay as they are."]
        case .iPhonePasscode: ["Your iPhone passcode can prove it's you.", "Your habits stay as they are."]
        case .resetWithPasscode: ["Face ID can't help right now.",
                                  "Your iPhone passcode can set a new app passcode after a 24-hour wait. The wait gives you time to notice and cancel it if it wasn't you.",
                                  "Your habits stay as they are."]
        case .resetAlone: ["After a 24-hour wait you can choose a new app passcode.",
                           "Entering your app passcode before then cancels it, so if it wasn't you, nothing changes.",
                           "Your habits stay as they are."]
        }
    }
}

/// The page's question in code mode: the code instead of the iPhone passcode (spec §3.2).
struct CodeCheckSheet: View {
    let lock: AppLock
    let check: AppLock.CodeCheck
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            CodeScreen { spread in
                CodeEntry(prompt: "Enter your app passcode", message: lock.message, shakes: lock.wrongCount,
                          disabled: lock.waitText != nil, spread: spread) { code in
                    if await lock.check(code) {
                        lock.clearMessage()
                        check.finish(true)
                        dismiss()
                    }
                }
            }
            .task(id: lock.waitText) { await lock.waitOut() }
            .navigationTitle(check.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { LockSheetClose { check.finish(false); dismiss() } }
        }
        .onDisappear { check.finish(false) }
    }
}

#if DEBUG
// MARK: - A test launch's Face ID

/// The stand-in for the system's Face ID prompt in a test launch (`FakeAuthenticator`), in its own window above
/// everything, sheets included.
struct FakeAuthPanel: View {
    let fake: FakeAuthenticator

    var body: some View {
        if let request = fake.request {
            VStack(spacing: 8) {
                Text(request.policy == .biometrics ? "Test Face ID" : "Test Face ID or Passcode").font(.headline)
                Text(request.reason).font(.subheadline).accessibilityIdentifier("fake-auth-reason")
                HStack(spacing: 24) {
                    Button("Cancel") { fake.respond(false) }.accessibilityIdentifier("fake-auth-cancel")
                    Button("Succeed") { fake.respond(true) }.fontWeight(.semibold).accessibilityIdentifier("fake-auth-ok")
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemBackground)).shadow(radius: 8))
            .padding(.horizontal, 16)
            .accessibilityElement(children: .contain)
            .accessibilityIdentifier("fake-auth")
        }
    }
}

/// Puts the panel in a window of its own over the app's, shown only while a request waits. While shown it takes every
/// touch, as the system's Face ID prompt does: a window that passed touches through to the app lost the panel's own
/// buttons too, since a SwiftUI hosting view answers `hitTest` with itself (iOS 18; AppLockUITests, run 37875404027).
@MainActor enum FakeAuthWindow {
    private static var window: UIWindow?

    static func install() {
        guard AppLock.testing, window == nil,
              let scene = UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene }).first else { return }
        let host = UIHostingController(rootView: FakeAuthPanel(fake: FakeAuthenticator.shared))
        host.view.backgroundColor = .clear
        let made = UIWindow(windowScene: scene)
        made.windowLevel = .alert + 1
        made.rootViewController = host
        made.isHidden = FakeAuthenticator.shared.request == nil
        window = made
    }

    static func show(_ showing: Bool) {
        window?.isHidden = !showing
    }
}
#endif
