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

/// The locked cover: Unlock (iPhone-passcode mode), or the keypad with Use Face ID and Forgot App Passcode? (app-passcode mode), and a
/// waiting reset with Cancel Reset.
private struct LockedScreen: View {
    @Bindable var lock: AppLock

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                switch lock.mode {
                case .passcode:
                    LockTitle(title: "The app is locked", detail: nil)
                    Button { Task { await lock.unlock() } } label: {
                        Text("Unlock").fontWeight(.semibold).foregroundStyle(Color.onInk).frame(minWidth: 120)
                    }
                    .buttonStyle(.borderedProminent).tint(.ink)
                    .accessibilityIdentifier("app-unlock")
                case .code:
                    codeScreen
                }
            }
            .padding(.vertical, 24)
            .frame(maxWidth: .infinity)
        }
        .scrollBounceBehavior(.basedOnSize)
        .defaultScrollAnchor(.center)
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

    @ViewBuilder private var codeScreen: some View {
        if lock.step == .resetReady {
            LockTitle(title: "The app is locked", detail: "The 24 hours are up. Choose a new app passcode with your iPhone passcode.")
            Button {
                Task { if await lock.chooseNewCodeAfterReset() { lock.coverSheet = .newCode } }
            } label: {
                Text("Choose a New App Passcode").fontWeight(.semibold).foregroundStyle(Color.onInk).frame(minWidth: 180)
            }
            .buttonStyle(.borderedProminent).tint(.ink)
            .accessibilityIdentifier("lock-choose-new-code")
        } else {
            let changed = lock.faceIDChanged
            if changed {
                // Screen 9: the line under the title already asks, so the keypad's own prompt is left out.
                LockTitle(title: "Face ID was changed", detail: "Enter your app passcode to open the app.")
            } else {
                LockTitle(title: "The app is locked", detail: nil)
            }
            if let times = lock.resetTimes, lock.resetWaiting { ResetWaitingBox(lock: lock, asked: times.asked, ready: times.ready) }
            if lock.faceIDUsable {
                Button("Use Face ID") { Task { await lock.unlock() } }
                    .fontWeight(.semibold)
                    .accessibilityIdentifier("lock-use-face-id")
            }
            CodeEntry(prompt: changed ? "" : "Enter your app passcode", message: lock.message, shakes: lock.wrongCount, disabled: lock.waitText != nil) { code in
                await lock.enter(code)
            }
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
            Text("If you didn't ask for this, cancel it with Face ID or your app passcode.")
                .font(.subheadline).foregroundStyle(.secondary)
            Button("Cancel Reset") {
                Task { _ = await lock.cancelReset() }
            }
            .fontWeight(.semibold)
            .padding(.top, 4)
            .accessibilityIdentifier("lock-cancel-reset")
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
    let onCode: @MainActor (String) async -> Void

    @State private var typed = ""
    @State private var offset: CGFloat = 0
    @State private var busy = false

    var body: some View {
        VStack(spacing: 16) {
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
            CodeKeypad(disabled: disabled || busy) { key in press(key) }
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
    @ScaledMetric(relativeTo: .title) private var size: CGFloat = 68

    var body: some View {
        let side = min(size, 84)
        Grid(horizontalSpacing: 22, verticalSpacing: 12) {
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
    let onChosen: @MainActor (String) async -> Void
    @State private var first: String?
    @State private var message: String?
    @State private var mismatches = 0

    static let firstPrompt = "Enter a six-digit passcode"
    static let firstLine = "You'll only need it when Face ID doesn't work."
    static let mismatch = "The passcodes didn't match. Try again."

    var body: some View {
        CodeEntry(prompt: first == nil ? Self.firstPrompt : "Enter it again", message: first == nil ? (message ?? Self.firstLine) : nil,
                  shakes: mismatches) { code in
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

/// Set Up App Lock (spec §4, screens 3–6), in its own navigation: what opens the app when Face ID can't (iPhone
/// Passcode by default, no badge), then for an app passcode how it works, the owner's Face ID or passcode once, the
/// passcode and the passcode again. Nothing is saved until the second entry matches; ✕, a failed check, a mismatch or
/// leaving part-way changes nothing (the switch stays off).
struct AppLockSetupSheet: View {
    enum Start: String, Identifiable {
        /// From the switch: screen 3 first.
        case choose
        /// From If Face ID doesn't work → App Passcode: screen 4 first.
        case appPasscode
        var id: String { rawValue }
    }

    private enum Step: Hashable { case explain, enter, again(String) }

    let lock: AppLock
    let start: Start
    /// "Face ID", or the method this iPhone has.
    let method: String
    let onDone: (Bool) -> Void
    @State private var path: [Step] = []
    @State private var appPasscode = false
    @State private var mismatch = false
    @State private var mismatches = 0
    @State private var checking = false

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                switch start {
                case .choose: choose
                case .appPasscode: explain
                }
            }
            .toolbar { LockSheetClose { onDone(false) } }
            .navigationDestination(for: Step.self) { step in
                switch step {
                case .explain: explain
                case .enter: enter
                case .again(let first): again(first)
                }
            }
        }
        .interactiveDismissDisabled()
        .tint(.ink)
    }

    // MARK: Screen 3: If Face ID doesn't work

    private var choose: some View {
        Form {
            Section {
                VStack(alignment: .leading, spacing: 6) {
                    Text("If \(method) doesn't work").font(.title2.bold()).accessibilityAddTraits(.isHeader)
                    Text("\(method) is always tried first. Choose what opens the app when it can't recognise you.")
                        .foregroundStyle(.secondary)
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 0, leading: 4, bottom: 4, trailing: 4))
            }
            Section {
                option("iPhone Passcode", "Nothing new to remember. Anyone who knows your iPhone passcode can open the app.",
                       selected: !appPasscode, id: "setup-iphone-passcode") { appPasscode = false }
                option("App Passcode", "Six digits, just for this app. Your iPhone passcode won't open it. Good if people around you know it.",
                       selected: appPasscode, id: "setup-app-passcode") { appPasscode = true }
            }
        }
        .contentMargins(.top, 8, for: .scrollContent)
        .navigationTitle("Set Up App Lock")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            RecordBottomBar {
                if appPasscode {
                    DayButton("Continue", prominent: true, id: "setup-continue") { path.append(.explain) }
                } else {
                    DayButton("Turn On App Lock", prominent: true, id: "setup-turn-on") { Task { await turnOnWithIPhonePasscode() } }
                        .disabled(checking)
                }
            }
        }
    }

    private func option(_ title: String, _ detail: String, selected: Bool, id: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(alignment: .firstTextBaseline) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(title).foregroundStyle(Color.primary)
                    Text(detail).font(.subheadline).foregroundStyle(.secondary).fixedSize(horizontal: false, vertical: true)
                }
                Spacer(minLength: 8)
                if selected { Image(systemName: "checkmark").fontWeight(.semibold).foregroundStyle(Color.ink) }
            }
            .contentShape(Rectangle())
        }
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(selected ? [.isSelected, .isButton] : .isButton)
        .accessibilityIdentifier(id)
    }

    private func turnOnWithIPhonePasscode() async {
        checking = true
        defer { checking = false }
        guard await AppLock.authenticate(reason: "Turn on App Lock") else { return }
        AppLock.setEnabled(true)
        lock.bump()
        onDone(true)
    }

    // MARK: Screen 4: How your app passcode works

    private var explain: some View {
        Form {
            Section {
                Text("How your app passcode works").font(.title2.bold()).accessibilityAddTraits(.isHeader)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 0, leading: 4, bottom: 4, trailing: 4))
            }
            Section {
                rule("If you forget it", "Use \(method) to choose a new app passcode.")
                rule("If \(method) changes", "Whenever \(method) is changed on your iPhone, the app asks for your app passcode once, so no one else can get in with their face.")
                rule("If you forget it and \(method) can't help", "For example, if \(method) is broken or turned off. Your iPhone passcode can set a new app passcode after a 24-hour wait. The wait gives you time to notice and cancel it if it wasn't you.")
            } footer: {
                Text("Your habits are never deleted, whatever happens.")
            }
        }
        .contentMargins(.top, 8, for: .scrollContent)
        .navigationTitle("App Passcode")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            RecordBottomBar {
                DayButton("Create App Passcode", prominent: true, id: "setup-create-app-passcode") { Task { await createAppPasscode() } }
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

    /// The owner, this once: Face ID or the iPhone passcode (an app passcode doesn't exist yet).
    private func createAppPasscode() async {
        checking = true
        defer { checking = false }
        guard await AppLock.authenticate(reason: "Create your app passcode") else { return }
        mismatch = false
        path.append(.enter)
    }

    // MARK: Screens 5 and 6: Enter, then enter it again

    private var enter: some View {
        ScrollView {
            CodeEntry(prompt: CodeSetup.firstPrompt, message: mismatch ? CodeSetup.mismatch : CodeSetup.firstLine, shakes: mismatches) { code in
                mismatch = false
                path.append(.again(code))
            }
            .padding(.vertical, 24)
            .accessibilityElement(children: .contain)
            .accessibilityIdentifier("code-setup")
        }
        .scrollBounceBehavior(.basedOnSize)
        .navigationTitle("App Passcode")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func again(_ first: String) -> some View {
        ScrollView {
            CodeEntry(prompt: "Enter it again", message: nil, shakes: 0) { code in
                if code == first {
                    await lock.saveCode(code)
                    onDone(true)
                } else {
                    // Back to the first entry, cleared, saying why.
                    mismatch = true
                    mismatches += 1
                    path.removeLast()
                }
            }
            .padding(.vertical, 24)
            .accessibilityElement(children: .contain)
            .accessibilityIdentifier("code-setup")
        }
        .scrollBounceBehavior(.basedOnSize)
        .navigationTitle("App Passcode")
        .navigationBarTitleDisplayMode(.inline)
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
            ScrollView {
                CodeSetup { code in
                    await lock.saveCode(code)
                    finish(true)
                }
                .padding(.vertical, 24)
            }
            .scrollBounceBehavior(.basedOnSize)
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

/// "Forgot App Passcode" (spec §3.5): Face ID sets a new one at once; otherwise the 24-hour reset with the iPhone passcode.
struct ForgotCodeSheet: View {
    let lock: AppLock
    @State private var choosing = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Group {
                if choosing {
                    ScrollView {
                        CodeSetup { code in
                            await lock.saveCode(code)
                            lock.coverSheet = nil
                            dismiss()
                        }
                        .padding(.vertical, 24)
                    }
                    .scrollBounceBehavior(.basedOnSize)
                } else if lock.faceIDUsable {
                    Form {
                        Section { Text("Use Face ID to choose a new app passcode.") }
                    }
                    .safeAreaInset(edge: .bottom) {
                        RecordBottomBar {
                            DayButton("Use Face ID", prominent: true, id: "lock-forgot-face-id") {
                                Task { if await lock.forgotWithFaceID() { choosing = true } }
                            }
                        }
                    }
                } else {
                    Form {
                        Section {
                            Text("Your iPhone passcode can set a new app passcode after a 24-hour wait. The wait gives you time to notice and cancel it if it wasn't you. Your habits stay as they are.")
                        }
                    }
                    .safeAreaInset(edge: .bottom) {
                        RecordBottomBar {
                            DayButton("Start 24-Hour Reset", prominent: true, id: "lock-start-reset") {
                                Task { await lock.startReset(); if lock.resetWaiting { dismiss() } }
                            }
                            .disabled(lock.resetWaiting)
                        }
                    }
                }
            }
            .navigationTitle("Forgot App Passcode")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { LockSheetClose { lock.coverSheet = nil; dismiss() } }
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
            ScrollView {
                CodeEntry(prompt: "Enter your app passcode", message: lock.message, shakes: lock.wrongCount,
                          disabled: lock.waitText != nil) { code in
                    if await lock.check(code) {
                        lock.clearMessage()
                        check.finish(true)
                        dismiss()
                    }
                }
                .padding(.vertical, 24)
            }
            .scrollBounceBehavior(.basedOnSize)
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
