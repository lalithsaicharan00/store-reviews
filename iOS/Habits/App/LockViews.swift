import SwiftUI
import UIKit

// The lock's screens (Privacy & Security spec §3): the cover, the keypad, choosing a code, Forgot Your Code, and the
// code question the page asks in code mode. Native parts only (U1), monochrome chrome (U2), plain words (U11).

/// What shows instead of the app while it's locked, or while it isn't in front (so the app switcher shows this, not the
/// habits). Drawn only while it's needed: it costs nothing while the app is unlocked and in front (S6).
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
                LockTitle(title: "Often Enough is locked", detail: nil)
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("app-lock-cover")
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

/// The locked cover: Unlock (iPhone-passcode mode), or the keypad with Use Face ID and Forgot Code? (code mode), and a
/// waiting reset with Cancel Reset.
private struct LockedScreen: View {
    @Bindable var lock: AppLock

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                switch lock.mode {
                case .passcode:
                    LockTitle(title: "Often Enough is locked", detail: nil)
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
        .sheet(item: $lock.coverSheet) { sheet in
            switch sheet {
            case .forgot: ForgotCodeSheet(lock: lock)
            case .newCode: NewCodeSheet(lock: lock, title: "Choose a New Code")
            }
        }
        .alert("Use Face ID again?", isPresented: $lock.askTrustFaceID) {
            Button("Use Face ID Again") { lock.trustFaceID(true) }
            Button("Keep Face ID Off", role: .cancel) { lock.trustFaceID(false) }
        } message: {
            Text("If you changed Face ID yourself, use it again. If you didn't, someone may have added their face: keep Face ID off and check Settings → Face ID & Passcode.")
        }
    }

    @ViewBuilder private var codeScreen: some View {
        if lock.step == .resetReady {
            LockTitle(title: "Often Enough is locked", detail: "The 24 hours are up. Choose a new code with your iPhone passcode.")
            Button {
                Task { if await lock.chooseNewCodeAfterReset() { lock.coverSheet = .newCode } }
            } label: {
                Text("Choose a New Code").fontWeight(.semibold).foregroundStyle(Color.onInk).frame(minWidth: 180)
            }
            .buttonStyle(.borderedProminent).tint(.ink)
            .accessibilityIdentifier("lock-choose-new-code")
        } else {
            if lock.faceIDChanged {
                LockTitle(title: "Face ID has changed on this iPhone",
                          detail: "A face or a fingerprint was added or removed in Settings. Enter your Often Enough code to continue.")
            } else {
                LockTitle(title: "Often Enough is locked", detail: nil)
            }
            if let times = lock.resetTimes, lock.resetWaiting { ResetWaitingBox(lock: lock, asked: times.asked, ready: times.ready) }
            if lock.faceIDUsable {
                Button("Use Face ID") { Task { await lock.unlock() } }
                    .fontWeight(.semibold)
                    .accessibilityIdentifier("lock-use-face-id")
            }
            CodeEntry(prompt: "Enter your code", message: lock.message, shakes: lock.wrongCount, disabled: lock.waitText != nil) { code in
                await lock.enter(code)
            }
            Button("Forgot Code?") { lock.coverSheet = .forgot }
                .accessibilityIdentifier("lock-forgot")
        }
    }
}

/// "Code reset asked for · Tue 10:14. You can choose a new code from Wed 10:14." with Cancel Reset (spec §3.5).
private struct ResetWaitingBox: View {
    let lock: AppLock
    let asked: Date
    let ready: Date

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Label("Code reset asked for", systemImage: "hourglass").font(.headline)
            Text("\(LockText.when(asked)). You can choose a new code from \(LockText.when(ready)).")
                .font(.subheadline)
            Text("If you didn't ask for this, cancel it with Face ID or your code.")
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
            Text(prompt).font(.headline).accessibilityIdentifier("code-prompt")
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

/// Enter a code, then Enter it again; different: "The two codes are different. Try again." and back to the first.
struct CodeSetup: View {
    let onChosen: @MainActor (String) async -> Void
    @State private var first: String?
    @State private var message: String?
    @State private var mismatches = 0

    var body: some View {
        CodeEntry(prompt: first == nil ? "Enter a code" : "Enter it again", message: message, shakes: mismatches) { code in
            if let first {
                if first == code {
                    await onChosen(code)
                } else {
                    self.first = nil
                    message = "The two codes are different. Try again."
                    mismatches += 1
                }
            } else {
                first = code
                message = nil
            }
        }
        .id(first == nil ? "first" : "second")
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

/// "Your Own Code": what choosing a code means, then the code twice (spec §3.1).
struct YourOwnCodeSheet: View {
    let lock: AppLock
    let onDone: (Bool) -> Void
    @State private var choosing = false

    var body: some View {
        NavigationStack {
            Group {
                if choosing {
                    ScrollView { CodeSetup { code in await lock.saveCode(code); onDone(true) }.padding(.vertical, 24) }
                        .scrollBounceBehavior(.basedOnSize)
                } else {
                    Form {
                        Section {
                            Label("Only Face ID or this code opens Often Enough. Your iPhone passcode won't.", systemImage: "lock")
                            Label("Forgot it? Face ID resets it straight away.", systemImage: "faceid")
                            Label("If Face ID can't help, your iPhone passcode resets it after 24 hours. Often Enough tells you on its lock screen while a reset is waiting, so you can cancel it.", systemImage: "hourglass")
                        }
                    }
                    .safeAreaInset(edge: .bottom) {
                        RecordBottomBar {
                            DayButton("Choose a Code", prominent: true, id: "lock-choose-code") { choosing = true }
                        }
                    }
                }
            }
            .navigationTitle("Your Own Code")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { LockSheetClose { onDone(false) } }
        }
        .interactiveDismissDisabled()
    }
}

/// Change Code, or a new code after a reset: the code twice.
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

/// "Forgot Your Code" (spec §3.5): Face ID resets it at once; otherwise the 24-hour reset with the iPhone passcode.
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
                        Section { Text("Use Face ID to choose a new code.") }
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
                            Text("Your iPhone passcode can reset the code after a 24-hour wait. The wait keeps someone who knows your passcode from doing it quickly without you seeing. Your habits stay as they are.")
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
            .navigationTitle("Forgot Your Code")
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
                CodeEntry(prompt: "Enter your Often Enough code", message: lock.message, shakes: lock.wrongCount,
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

/// Puts the panel in a window of its own over the app's, shown only while a request waits.
@MainActor enum FakeAuthWindow {
    private static var window: UIWindow?

    static func install() {
        guard AppLock.testing, window == nil,
              let scene = UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene }).first else { return }
        let host = UIHostingController(rootView: FakeAuthPanel(fake: FakeAuthenticator.shared))
        host.view.backgroundColor = .clear
        let made = PassThroughWindow(windowScene: scene)
        made.windowLevel = .alert + 1
        made.rootViewController = host
        made.isHidden = false
        window = made
    }
}

/// Touches go through to the app except on the panel itself.
private final class PassThroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hit = super.hitTest(point, with: event)
        return hit === rootViewController?.view ? nil : hit
    }
}
#endif
