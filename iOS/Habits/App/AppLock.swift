import LocalAuthentication
import SwiftUI

/// Lock with Face ID (report "App Lock — Private Without Lock-outs", 30 Sep; Feature Ledger C017, C096). Free.
///
/// Users show the three ways a lock fails: a forgotten app passcode locks people out of their own history (1★), the
/// list shows for an instant before the lock or in the app switcher, and the widget shows it anyway. So: the iPhone's
/// own Face ID, Touch ID or passcode (never a separate code to forget); a cover whenever the app isn't in front, from
/// the very first frame; and the installed widgets publish a content-hidden state while the lock is enabled.
/// Ported from the 29–30 Sep feature branch on 1 Oct 2026, with the Face ID usage text it was missing (without it
/// iOS ends the app the moment Face ID is asked for).
@Observable
final class AppLock {
    /// Read before anything is drawn, so a locked app never shows a frame of habits at launch. Kept in step with the
    /// setting (the database is read after the first frame).
    static let launchKey = "app_lock"

    private(set) var isLocked: Bool
    private var unlocking = false
    /// Ask for Face ID the next time the app is in front: at launch and after leaving it, but not after a cancelled
    /// prompt (the prompt itself makes the app inactive and active again, which would ask forever).
    private var promptWhenActive: Bool

    init() {
        let on = Self.isEnabled
        isLocked = on
        promptWhenActive = on
    }

    /// Never in UI tests, so a lock left on in the simulator can't block them.
    static var isEnabled: Bool {
        !ProcessInfo.processInfo.arguments.contains("-uitest") && UserDefaults.standard.bool(forKey: launchKey)
    }

    static func setEnabled(_ on: Bool) {
        UserDefaults.standard.set(on, forKey: launchKey)
    }

    /// Leaving the app locks it, when the lock is on.
    func lock() {
        if Self.isEnabled { isLocked = true; promptWhenActive = true }
    }

    /// The app is in front again: ask once.
    func appeared() async {
        guard promptWhenActive else { return }
        promptWhenActive = false
        await unlock()
    }

    /// Face ID or Touch ID, falling back to the iPhone passcode, so no one is ever locked out of their own habits.
    func unlock() async {
        guard isLocked, !unlocking else { return }
        guard Self.isEnabled else { isLocked = false; return }
        unlocking = true
        defer { unlocking = false }
        if await Self.authenticate(reason: "Unlock your habits") { isLocked = false }
    }

    /// Whether this iPhone can lock the app: it needs a passcode at least.
    static var isAvailable: Bool {
        LAContext().canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
    }

    /// "Face ID", "Touch ID", "Optic ID" or "Passcode", for the switch in Settings.
    static var methodName: String {
        let context = LAContext()
        _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        return switch context.biometryType {
        case .faceID: "Face ID"
        case .touchID: "Touch ID"
        case .opticID: "Optic ID"
        default: "Passcode"
        }
    }

    static func authenticate(reason: String) async -> Bool {
        (try? await LAContext().evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason)) ?? false
    }
}

/// What shows instead of the app while it's locked, or while it isn't in front (so the app switcher shows this, not
/// the habits).
struct LockCover: View {
    let locked: Bool
    let onUnlock: () -> Void

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            VStack(spacing: 16) {
                Image(systemName: "lock.fill")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundStyle(.secondary)
                    .accessibilityHidden(true)
                Text("Habits is locked").font(.title3.weight(.semibold))
                if locked {
                    Button { onUnlock() } label: {
                        Text("Unlock").fontWeight(.semibold).foregroundStyle(Color.onInk).frame(minWidth: 120)
                    }
                    .buttonStyle(.borderedProminent).tint(.ink)
                    .accessibilityIdentifier("app-unlock")
                }
            }
        }
        .accessibilityIdentifier("app-lock-cover")
    }
}
