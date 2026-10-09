import CommonCrypto
import Foundation
import LocalAuthentication
import Observation
import Security
import UIKit
import UserNotifications

/// App Lock (≡ → Privacy & Security). Free, off by default. Current Work 58, decided by the user on 9 Oct 2026:
/// [Privacy & Security — What to Build](iOS/Docs/Specs/Privacy & Security — What to Build.md) and the report
/// "App Lock and Widget Privacy — What People Expect" §6c–§6d.
///
/// - **Unlock With:** the iPhone's own Face ID and passcode (the default, which can never lock anyone out), or Face ID
///   and an Often Enough code, for people whose family knows the phone's passcode. In code mode the iPhone passcode
///   never opens the app or turns the lock off.
/// - **The code** is six digits, kept only as a salted slow hash in this iPhone's Keychain
///   (`kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly`, never synced or backed up), with the wrong-code count, the
///   wait, a waiting reset and the trusted Face ID set (`LockVault`). It outlives deleting the app.
/// - **Face ID changed** (someone may have added a face): Face ID stops until the code is typed, and then the person is
///   asked; the new set is never trusted silently.
/// - **Forgot Code?** Face ID resets it at once; otherwise the iPhone passcode can, after a 24-hour wait counted on a
///   clock that changing the iPhone's time can't move (`LockClock`).
/// - **Ask Again:** Immediately, After 1 Minute or After 15 Minutes; locking the iPhone always locks the app at once.
///
/// Rules that hold whatever is chosen (report §6d): never ask while the app is in front; never for the iPhone's own
/// interruptions (the cover shows then); ask by itself on return; the cover sits over the app, so the screen, sheets and
/// typed text are kept; every way in (a notification, a widget, a link, a Shortcut) opens underneath and shows once
/// unlocked. Nothing here ever deletes or hides data (D-rules).
///
/// Test launches (`-uitest`, D8) keep the lock off and never touch the person's Keychain item. `-test-lock passcode|code`
/// turns it on with a fake authenticator (`FakeAuthenticator`) and the test's own Keychain service, so the cover, the
/// code, wrong-code waits, Face ID changed and the reset can be tested (`AppLockUITests`).
@MainActor @Observable
final class AppLock {
    /// Read before anything is drawn, so a locked app never shows a frame of habits at launch.
    nonisolated static let launchKey = "app_lock"

    enum Mode: String, Sendable { case passcode, code }

    /// What the cover asks for while locked.
    enum Step: Equatable {
        /// iPhone-passcode mode, or code mode with Face ID available: Face ID is (or was) asked for.
        case biometrics
        /// Code mode: the keypad.
        case code
        /// A reset whose 24 hours are up: Choose a New Code.
        case resetReady
    }

    private(set) var isLocked: Bool
    /// Shown under the keypad or the title: "That's not the code.", "Try again in 5 minutes.", "The code reset was cancelled."
    private(set) var message: String?
    /// Bumped on a wrong code, so the dots shake.
    private(set) var wrongCount = 0
    /// After the right code with a changed Face ID set: "Use Face ID again?" (spec §3.4).
    var askTrustFaceID = false
    /// A sheet the cover or the page shows: Forgot Your Code, or choosing a new code after a reset.
    var coverSheet: CoverSheet?
    /// The page's request for the code (in code mode, instead of the iPhone passcode).
    var codeCheck: CodeCheck?
    /// Bumped whenever the Keychain state changes, so views that show it redraw.
    private(set) var revision = 0

    enum CoverSheet: String, Identifiable { case forgot, newCode; var id: String { rawValue } }

    /// A question to the person: type the code to go on. Answered once.
    final class CodeCheck: Identifiable {
        let id = UUID()
        let title: String
        fileprivate var answer: ((Bool) -> Void)?
        init(title: String, answer: @escaping (Bool) -> Void) { self.title = title; self.answer = answer }
        func finish(_ ok: Bool) { answer?(ok); answer = nil }
    }

    private var unlocking = false
    /// Ask the next time the app is in front: at launch and after leaving it, but not after a cancelled prompt (the
    /// prompt itself makes the app inactive and active again, which would ask forever).
    private var promptWhenActive: Bool
    /// When the app left the screen (`LockClock`), for Ask Again.
    private var leftAt: TimeInterval?
    private var phoneLockObserver: NSObjectProtocol?
    private var phoneUnlockObserver: NSObjectProtocol?
    private var backgroundTask = UIBackgroundTaskIdentifier.invalid

    init() {
        Self.applyTestLaunch()
        let on = Self.isEnabled
        isLocked = on
        promptWhenActive = on
        phoneLockObserver = NotificationCenter.default.addObserver(
            forName: UIApplication.protectedDataWillBecomeUnavailableNotification, object: nil, queue: .main) { [weak self] _ in
            // Locking the iPhone always locks the app at once, whatever Ask Again says (spec §2.2).
            MainActor.assumeIsolated { self?.phoneLocked() }
        }
        phoneUnlockObserver = NotificationCenter.default.addObserver(
            forName: UIApplication.protectedDataDidBecomeAvailableNotification, object: nil, queue: .main) { [weak self] _ in
            // The iPhone was locked and unlocked while the app was away (heard on return): lock, as if heard then.
            MainActor.assumeIsolated {
                guard let self, UIApplication.shared.applicationState != .active else { return }
                self.phoneLocked()
            }
        }
    }

    // MARK: Settings

    /// A test launch: never the person's own lock (D8).
    nonisolated static var testing: Bool { ProcessInfo.processInfo.arguments.contains("-uitest") }
    nonisolated private static var prefix: String { testing ? "uitest." : "" }
    nonisolated static var enabledKey: String { prefix + launchKey }
    nonisolated static var askAgainKey: String { prefix + "app_lock.askAgain" }

    /// Whether the lock is on. In a test launch only the test's own switch counts. The Keychain says so too in code
    /// mode, so deleting and reinstalling the app doesn't remove a code lock (report §6c point 2).
    nonisolated static var isEnabled: Bool {
        if UserDefaults.standard.bool(forKey: enabledKey) { return true }
        return LockKeychain.cachedCodeMode
    }

    nonisolated static func setEnabled(_ on: Bool) {
        UserDefaults.standard.set(on, forKey: enabledKey)
    }

    var mode: Mode { _ = revision; return LockKeychain.vault.codeHash != nil ? .code : .passcode }

    /// Ask Again, in seconds: 0 (Immediately, the default), 60 or 900. Nothing past 15 minutes (report §6d).
    static var askAgain: Int {
        get { [0, 60, 900].contains(UserDefaults.standard.integer(forKey: askAgainKey)) ? UserDefaults.standard.integer(forKey: askAgainKey) : 0 }
        set { UserDefaults.standard.set([0, 60, 900].contains(newValue) ? newValue : 0, forKey: askAgainKey) }
    }

    static var authenticator: LockAuthenticator {
        #if DEBUG
        if testing { return FakeAuthenticator.shared }
        #endif
        return SystemAuthenticator()
    }

    // MARK: Leaving and coming back

    /// The app went to the background: with Ask Again at Immediately it locks now; otherwise the time is noted, and the
    /// app stays awake briefly to hear the iPhone being locked (which locks it at once).
    func lock() {
        guard Self.isEnabled else { return }
        if Self.askAgain == 0 {
            lockNow()
        } else {
            leftAt = LockClock.now
            keepListeningForPhoneLock()
        }
    }

    /// The iPhone was locked (its data protection is about to close): lock now.
    func phoneLocked() {
        guard Self.isEnabled else { return }
        lockNow()
        endListening()
    }

    private func lockNow() {
        isLocked = true
        promptWhenActive = true
        leftAt = nil
    }

    /// The app is in front again: lock if Ask Again's time has passed, then ask once.
    func appeared() async {
        endListening()
        if let leftAt, Self.isEnabled {
            self.leftAt = nil
            if LockClock.now - leftAt >= Double(Self.askAgain) { lockNow() }
        }
        guard promptWhenActive else { return }
        promptWhenActive = false
        await unlock()
    }

    private func keepListeningForPhoneLock() {
        endListening()
        backgroundTask = UIApplication.shared.beginBackgroundTask(withName: "Listen for the iPhone locking") { [weak self] in
            MainActor.assumeIsolated { self?.endListening() }
        }
    }

    private func endListening() {
        guard backgroundTask != .invalid else { return }
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }

    // MARK: Unlocking

    /// What the cover shows now.
    var step: Step {
        _ = revision
        guard mode == .code else { return .biometrics }
        if LockKeychain.vault.resetReady { return .resetReady }
        return .code
    }

    /// Face ID (or Touch ID) can open the app in code mode: available, not turned off, and the same set as when it was
    /// trusted.
    var faceIDUsable: Bool {
        _ = revision
        let vault = LockKeychain.vault
        guard !vault.faceIDOff, let trusted = vault.trustedDomainState else { return false }
        let auth = Self.authenticator
        return auth.biometricsAvailable && auth.domainState == trusted
    }

    /// The set of faces or fingers changed since it was trusted (spec §3.4); only in code mode.
    var faceIDChanged: Bool {
        _ = revision
        let vault = LockKeychain.vault
        guard mode == .code, !vault.faceIDOff, let trusted = vault.trustedDomainState else { return false }
        let auth = Self.authenticator
        return auth.biometricsAvailable && auth.domainState != trusted
    }

    var faceIDOff: Bool { _ = revision; return LockKeychain.vault.faceIDOff }

    /// Asked by itself on return and by Unlock: iPhone-passcode mode asks Face ID with the passcode fallback (as before);
    /// code mode asks Face ID only, and only when it's trusted; otherwise the keypad waits.
    func unlock() async {
        guard isLocked, !unlocking else { return }
        guard Self.isEnabled else { isLocked = false; return }
        unlocking = true
        defer { unlocking = false }
        switch mode {
        case .passcode:
            if await Self.authenticator.authenticate(.deviceOwner, reason: "Unlock your habits") { isLocked = false }
        case .code:
            guard step == .code, faceIDUsable, !LockKeychain.vault.resetWaiting else { return }
            if await Self.authenticator.authenticate(.biometrics, reason: "Unlock Often Enough") { opened() }
        }
    }

    /// The right code, Face ID or a new code: open, with every wait cleared.
    private func opened() {
        LockKeychain.update { $0.failures = 0; $0.waitEnds = nil }
        bump()
        isLocked = false
    }

    /// While a wait after wrong codes runs: "Try again in 5 minutes."
    var waitText: String? {
        _ = revision
        guard let left = LockKeychain.vault.waitLeft else { return nil }
        let minutes = Int((left / 60).rounded(.up))
        return minutes >= 60 ? "Try again in 1 hour." : minutes == 1 ? "Try again in 1 minute." : "Try again in \(minutes) minutes."
    }

    /// The keypad's code. Wrong: "That's not the code."; after 5 in a row, a wait of 1, 5, 15 minutes, then 1 hour
    /// after each further wrong code. Nothing is ever erased.
    func enter(_ code: String) async {
        guard LockKeychain.vault.waitLeft == nil else { message = waitText; return }
        let right = await LockKeychain.check(code)
        if right {
            let hadReset = LockKeychain.vault.resetAskedAt != nil
            let changed = faceIDChanged
            if hadReset { LockKeychain.update { $0.cancelReset() } }
            message = hadReset ? "The code reset was cancelled." : nil
            opened()
            if changed { askTrustFaceID = true }
        } else {
            LockKeychain.update { vault in
                vault.failures += 1
                if vault.failures >= 5 {
                    let waits: [Double] = [60, 300, 900, 3600]
                    vault.waitEnds = LockClock.now + waits[min(vault.failures - 5, waits.count - 1)]
                }
            }
            bump()
            wrongCount += 1
            message = waitText ?? "That's not the code."
        }
    }

    /// "Use Face ID again?": trust the set as it is now, or keep Face ID off (only the code opens the app).
    func trustFaceID(_ trust: Bool) {
        let state = Self.authenticator.domainState
        LockKeychain.update { vault in
            if trust { vault.trustedDomainState = state; vault.faceIDOff = false } else { vault.faceIDOff = true }
        }
        bump()
    }

    /// The page's Use Face ID Again: Face ID once, then trusted as it is now.
    func useFaceIDAgain() async {
        guard await Self.authenticator.authenticate(.biometrics, reason: "Use Face ID for Often Enough") else { return }
        trustFaceID(true)
    }

    func clearMessage() { message = nil }

    // MARK: Forgot code, and the 24-hour reset

    /// Forgot Code? with Face ID: Face ID, then a new code (spec §3.5).
    func forgotWithFaceID() async -> Bool {
        guard faceIDUsable else { return false }
        return await Self.authenticator.authenticate(.biometrics, reason: "Choose a new Often Enough code")
    }

    /// Start 24-Hour Reset: the iPhone passcode, then the wait begins, and a notification says so (no habit names).
    func startReset() async {
        guard await Self.authenticator.authenticate(.deviceOwner, reason: "Reset your Often Enough code") else { return }
        LockKeychain.update { $0.askReset(at: Date.now) }
        bump()
        coverSheet = nil
        let content = UNMutableNotificationContent()
        content.title = "Often Enough"
        content.body = "A code reset was asked for. If it wasn't you, open Often Enough and cancel it."
        content.sound = .default
        try? await UNUserNotificationCenter.current().add(UNNotificationRequest(identifier: "app-lock.reset", content: content, trigger: nil))
    }

    /// Cancel Reset: Face ID if trusted, otherwise the code (`enter` cancels it too).
    func cancelReset() async -> Bool {
        if faceIDUsable, await Self.authenticator.authenticate(.biometrics, reason: "Cancel the code reset") {
            LockKeychain.update { $0.cancelReset() }
            bump()
            message = "The code reset was cancelled."
            return true
        }
        return false
    }

    /// Choose a New Code after the wait: the iPhone passcode, then the new code (spec §3.5).
    func chooseNewCodeAfterReset() async -> Bool {
        guard LockKeychain.vault.resetReady else { return false }
        return await Self.authenticator.authenticate(.deviceOwner, reason: "Choose a new Often Enough code")
    }

    /// A new code is saved (first set, changed, or after a reset): Face ID is trusted as it is now.
    func saveCode(_ code: String) async {
        let state = Self.authenticator.domainState
        await LockKeychain.setCode(code, trusting: state)
        Self.setEnabled(true)
        bump()
        if isLocked { opened() }
    }

    /// Back to Face ID or iPhone Passcode: the code and everything kept with it go.
    func removeCode() {
        LockKeychain.clear()
        bump()
    }

    func turnOff() {
        LockKeychain.clear()
        Self.setEnabled(false)
        bump()
        isLocked = false
    }

    // MARK: The page's checks

    /// The owner, before the lock's settings change. iPhone-passcode mode: Face ID or the passcode (as before). Code
    /// mode: Face ID if trusted, otherwise the code; the iPhone passcode is never accepted (spec §3.2).
    func confirmOwner(_ reason: String) async -> Bool {
        switch mode {
        case .passcode:
            return await Self.authenticator.authenticate(.deviceOwner, reason: reason)
        case .code:
            if faceIDUsable, await Self.authenticator.authenticate(.biometrics, reason: reason) { return true }
            return await withCheckedContinuation { continuation in
                codeCheck = CodeCheck(title: "Enter Your Code") { continuation.resume(returning: $0) }
            }
        }
    }

    /// A code typed on the page's code sheet: right or not, counted like the cover's (waits included).
    func check(_ code: String) async -> Bool {
        guard LockKeychain.vault.waitLeft == nil else { message = waitText; return false }
        if await LockKeychain.check(code) {
            LockKeychain.update { $0.failures = 0; $0.waitEnds = nil }
            bump()
            return true
        }
        LockKeychain.update { vault in
            vault.failures += 1
            if vault.failures >= 5 {
                let waits: [Double] = [60, 300, 900, 3600]
                vault.waitEnds = LockClock.now + waits[min(vault.failures - 5, waits.count - 1)]
            }
        }
        bump()
        wrongCount += 1
        message = waitText ?? "That's not the code."
        return false
    }

    /// The reset as the cover and the page show it: when it was asked for and when it's ready ("Tue 10:14").
    var resetTimes: (asked: Date, ready: Date)? {
        _ = revision
        let vault = LockKeychain.vault
        guard let asked = vault.resetAskedAt, let left = vault.resetLeft else { return nil }
        return (asked, Date.now.addingTimeInterval(left))
    }
    var resetWaiting: Bool { _ = revision; return LockKeychain.vault.resetWaiting }
    var resetReady: Bool { _ = revision; return LockKeychain.vault.resetReady }

    /// Something in the Keychain changed: views redraw.
    func bump() { revision &+= 1 }

    // MARK: Test launches

    #if DEBUG
    /// Speed runs (`lock-keypad`): the test launch's own lock in code mode ("123456"), locked now, with no trusted Face
    /// ID, so the keypad shows straight away.
    func perfLock() async {
        guard Self.testing else { return }
        if LockKeychain.vault.codeHash == nil { await LockKeychain.setCode("123456", trusting: nil) }
        Self.setEnabled(true)
        bump()
        isLocked = true
    }
    #endif

    /// `-test-lock passcode|code` (with `-test-lock-code 123456` for a code), `-test-lock-fresh` (an empty test Keychain
    /// item), `-test-lock-ask 0|60|900`. Every test launch otherwise starts with the lock off (T8).
    nonisolated private static func applyTestLaunch() {
        guard testing else { return }
        let arguments = ProcessInfo.processInfo.arguments
        func value(_ flag: String) -> String? {
            arguments.firstIndex(of: flag).flatMap { $0 + 1 < arguments.count ? arguments[$0 + 1] : nil }
        }
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: enabledKey)
        defaults.removeObject(forKey: askAgainKey)
        defaults.removeObject(forKey: HideNames.key)
        if arguments.contains("-test-lock-fresh") || value("-test-lock") == nil { LockKeychain.clear() }
        if let ask = value("-test-lock-ask").flatMap(Int.init) { defaults.set(ask, forKey: askAgainKey) }
        guard let mode = value("-test-lock") else { return }
        defaults.set(true, forKey: enabledKey)
        if mode == "code", LockKeychain.vault.codeHash == nil {
            let code = value("-test-lock-code") ?? "123456"
            let semaphore = DispatchSemaphore(value: 0)
            Task.detached {
                await LockKeychain.setCode(code, trusting: FakeAuthenticator.startingDomainState)
                semaphore.signal()
            }
            semaphore.wait()
        }
    }
}

// MARK: - Hide Names Outside the App

/// Hide Names Outside the App (spec §2.3; report §6a, §6e): widgets, reminders, alarms, the timer's Live Activity and
/// Siri show icons and numbers without habit names. The person's own switch, held on while App Lock is on; turning the
/// lock off returns to their own choice. Replaces "Hide widget content" (`widgets.hideContent`), whose choice is carried
/// over once (`migrate`).
nonisolated enum HideNames {
    static var key: String { AppLock.testing ? "uitest.privacy.hideNames" : "privacy.hideNames" }
    /// "Hide widget content", before 9 Oct 2026.
    static let legacyKey = "widgets.hideContent"

    /// The person's own choice.
    static var chosen: Bool { UserDefaults.standard.bool(forKey: key) }
    static func setChosen(_ on: Bool) { UserDefaults.standard.set(on, forKey: key) }

    /// Names are hidden outside the app now.
    static var isOn: Bool { chosen || AppLock.isEnabled }

    /// Once, at launch: the old switch's value becomes the new one's, so nobody's choice is lost.
    static func migrate() {
        let defaults = UserDefaults.standard
        guard !AppLock.testing, defaults.object(forKey: key) == nil,
              let old = defaults.object(forKey: legacyKey) as? Bool else { return }
        defaults.set(old, forKey: key)
        defaults.removeObject(forKey: legacyKey)
    }
}

// MARK: - The clock for waits

/// Seconds on a clock that keeps counting while the iPhone sleeps and that changing the iPhone's time can't move
/// (`CLOCK_MONOTONIC` counts on through sleep on iOS). It starts again when the iPhone restarts, so the reset's time is
/// credited a piece at a time (`LockVault.resetLeft`) and a restart only ever makes the wait longer, never shorter.
nonisolated enum LockClock {
    static var now: TimeInterval {
        let raw = Double(clock_gettime_nsec_np(CLOCK_MONOTONIC)) / 1_000_000_000
        #if DEBUG
        // `-test-lock-advance N` (seconds) moves a test launch's clock on, for the waits and the 24-hour reset (T11).
        if AppLock.testing, let i = ProcessInfo.processInfo.arguments.firstIndex(of: "-test-lock-advance"),
           i + 1 < ProcessInfo.processInfo.arguments.count, let advance = Double(ProcessInfo.processInfo.arguments[i + 1]) {
            return raw + advance
        }
        #endif
        return raw
    }
}

// MARK: - What's kept in the Keychain

/// Everything the code lock keeps, in one Keychain item on this iPhone only (spec §5).
nonisolated struct LockVault: Codable, Equatable, Sendable {
    var codeHash: Data?
    var salt: Data?
    var iterations = 0
    /// Wrong codes in a row, and when the wait they set ends (`LockClock`).
    var failures = 0
    var waitEnds: TimeInterval?
    /// The 24-hour reset: when it was asked for (shown), and how much of the wait has passed so far: `credited` seconds
    /// up to the `LockClock` reading `mark`.
    var resetAskedAt: Date?
    var resetCredited: TimeInterval = 0
    var resetMark: TimeInterval = 0
    /// The Face ID set the code trusts (`LAContext.evaluatedPolicyDomainState`), and whether the person kept Face ID off.
    var trustedDomainState: Data?
    var faceIDOff = false

    static let resetWait: TimeInterval = 24 * 3600

    var waitLeft: TimeInterval? {
        guard let waitEnds else { return nil }
        let now = LockClock.now
        // A restart sets the clock back to zero: never wait longer than the longest wait.
        let left = waitEnds - now
        return left > 0 ? min(left, 3600) : nil
    }

    /// The reset's time passed: the credit so far plus the clock since the mark (or, after a restart, since the restart).
    var resetElapsed: TimeInterval {
        guard resetAskedAt != nil else { return 0 }
        let now = LockClock.now
        return resetCredited + (now >= resetMark ? now - resetMark : now)
    }
    var resetLeft: TimeInterval? { resetAskedAt == nil ? nil : max(0, Self.resetWait - resetElapsed) }
    var resetWaiting: Bool { resetAskedAt != nil && resetElapsed < Self.resetWait }
    var resetReady: Bool { resetAskedAt != nil && resetElapsed >= Self.resetWait }

    mutating func askReset(at date: Date) {
        resetAskedAt = date; resetCredited = 0; resetMark = LockClock.now
    }
    mutating func cancelReset() {
        resetAskedAt = nil; resetCredited = 0; resetMark = 0
    }
    /// Saves the time passed so far, so a restart only loses the time it was off.
    mutating func creditReset() {
        guard resetAskedAt != nil else { return }
        resetCredited = resetElapsed; resetMark = LockClock.now
    }
}

/// The Keychain item: this iPhone only, readable after the first unlock since a restart (never "when passcode set",
/// which iOS deletes if the passcode is removed, leaving a code no one can check).
nonisolated enum LockKeychain {
    private static var service: String { AppLock.testing ? "com.oftenenough.app.lock.uitest" : "com.oftenenough.app.lock" }
    private static let account = "app-lock"
    private static let lock = NSLock()
    nonisolated(unsafe) private static var cached: LockVault?

    /// The vault (read once, then kept in memory; every change is written straight through).
    static var vault: LockVault {
        lock.lock(); defer { lock.unlock() }
        if let cached { return cached }
        let read = load() ?? LockVault()
        cached = read
        return read
    }

    /// In code mode: read at launch, so a reinstalled app keeps its code lock.
    static var cachedCodeMode: Bool { vault.codeHash != nil }

    static func update(_ change: (inout LockVault) -> Void) {
        lock.lock(); defer { lock.unlock() }
        var value = cached ?? load() ?? LockVault()
        value.creditReset()
        change(&value)
        cached = value
        save(value)
    }

    static func clear() {
        lock.lock(); defer { lock.unlock() }
        cached = LockVault()
        SecItemDelete(query() as CFDictionary)
    }

    /// Hashes off the main thread (a slow hash on purpose: PBKDF2-SHA256).
    static func setCode(_ code: String, trusting state: Data?) async {
        let salt = Data((0..<16).map { _ in UInt8.random(in: 0...255) })
        let iterations = 120_000
        let hash = await Task.detached(priority: .userInitiated) { CodeHash.derive(code, salt: salt, iterations: iterations) }.value
        update { vault in
            vault.codeHash = hash; vault.salt = salt; vault.iterations = iterations
            vault.failures = 0; vault.waitEnds = nil
            vault.cancelReset()
            vault.trustedDomainState = state; vault.faceIDOff = false
        }
    }

    static func check(_ code: String) async -> Bool {
        let current = vault
        guard let hash = current.codeHash, let salt = current.salt, current.iterations > 0 else { return false }
        let derived = await Task.detached(priority: .userInitiated) { CodeHash.derive(code, salt: salt, iterations: current.iterations) }.value
        return CodeHash.equal(derived, hash)
    }

    private static func query() -> [String: Any] {
        [kSecClass as String: kSecClassGenericPassword, kSecAttrService as String: service, kSecAttrAccount as String: account]
    }

    private static func load() -> LockVault? {
        var q = query()
        q[kSecReturnData as String] = true
        q[kSecMatchLimit as String] = kSecMatchLimitOne
        var result: CFTypeRef?
        guard SecItemCopyMatching(q as CFDictionary, &result) == errSecSuccess, let data = result as? Data else { return nil }
        return try? JSONDecoder().decode(LockVault.self, from: data)
    }

    private static func save(_ value: LockVault) {
        guard let data = try? JSONEncoder().encode(value) else { return }
        let attributes: [String: Any] = [kSecValueData as String: data,
                                         kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly]
        if SecItemUpdate(query() as CFDictionary, attributes as CFDictionary) == errSecItemNotFound {
            var add = query()
            add.merge(attributes) { _, new in new }
            SecItemAdd(add as CFDictionary, nil)
        }
    }
}

nonisolated enum CodeHash {
    static func derive(_ code: String, salt: Data, iterations: Int) -> Data {
        var derived = Data(count: 32)
        let password = Array(code.utf8)
        let rounds = UInt32(max(1, iterations))
        _ = derived.withUnsafeMutableBytes { out in
            salt.withUnsafeBytes { saltBytes in
                CCKeyDerivationPBKDF(CCPBKDFAlgorithm(kCCPBKDF2), password.map { Int8(bitPattern: $0) }, password.count,
                                     saltBytes.bindMemory(to: UInt8.self).baseAddress, salt.count,
                                     CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA256), rounds,
                                     out.bindMemory(to: UInt8.self).baseAddress, 32)
            }
        }
        return derived
    }

    /// Compares every byte, whatever the first difference.
    static func equal(_ a: Data, _ b: Data) -> Bool {
        guard a.count == b.count else { return false }
        var difference: UInt8 = 0
        for (x, y) in zip(a, b) { difference |= x ^ y }
        return difference == 0
    }
}

// MARK: - Face ID, Touch ID and the passcode

nonisolated enum LockPolicy: Sendable {
    /// Face ID or Touch ID, falling back to the iPhone passcode.
    case deviceOwner
    /// Face ID or Touch ID only (code mode).
    case biometrics
}

/// What asks the system, so test launches can stand in for it (`FakeAuthenticator`).
protocol LockAuthenticator {
    var passcodeSet: Bool { get }
    var biometricsAvailable: Bool { get }
    /// The current set of faces or fingers, as iOS summarises it.
    var domainState: Data? { get }
    /// "Face ID", "Touch ID", "Optic ID" or "Passcode".
    var methodName: String { get }
    func authenticate(_ policy: LockPolicy, reason: String) async -> Bool
}

struct SystemAuthenticator: LockAuthenticator {
    var passcodeSet: Bool { LAContext().canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) }
    var biometricsAvailable: Bool { LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) }
    var domainState: Data? {
        let context = LAContext()
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) else { return nil }
        if #available(iOS 18, *) { return context.domainState.biometry.stateHash }
        return context.evaluatedPolicyDomainState
    }
    var methodName: String { AppLock.methodName(LAContext()) }
    func authenticate(_ policy: LockPolicy, reason: String) async -> Bool {
        let context = LAContext()
        let system: LAPolicy = policy == .biometrics ? .deviceOwnerAuthenticationWithBiometrics : .deviceOwnerAuthentication
        if policy == .biometrics { context.localizedFallbackTitle = "" }
        return (try? await context.evaluatePolicy(system, localizedReason: reason)) ?? false
    }
}

extension AppLock {
    /// Whether this iPhone can lock the app, and with what, asked off the main thread (asking the system is slow).
    nonisolated struct Ability: Sendable { let available: Bool; let method: String; let biometrics: Bool }

    nonisolated static func methodName(_ context: LAContext) -> String {
        _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        return switch context.biometryType {
        case .faceID: "Face ID"
        case .touchID: "Touch ID"
        case .opticID: "Optic ID"
        default: "Passcode"
        }
    }

    static func ability() async -> Ability {
        #if DEBUG
        if testing {
            let fake = FakeAuthenticator.shared
            return Ability(available: fake.passcodeSet, method: fake.methodName, biometrics: fake.biometricsAvailable)
        }
        #endif
        return await Task.detached(priority: .userInitiated) {
            let context = LAContext()
            let available = context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
            let biometrics = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
            return Ability(available: available, method: methodName(context), biometrics: biometrics)
        }.value
    }

    /// The page's own checks (turning the lock on, choosing a code): the iPhone's Face ID or passcode.
    static func authenticate(reason: String) async -> Bool {
        await authenticator.authenticate(.deviceOwner, reason: reason)
    }
}

#if DEBUG
/// A test launch's Face ID: a panel over everything (`FakeAuthPanel`) asks the test to tap Succeed, Passcode or Cancel,
/// so every path is testable without the system's prompt (D8: the person's own Face ID is never involved).
/// `-test-face none` means no Face ID on this "iPhone"; `-test-face-domain B` is a changed set of faces.
@MainActor @Observable
final class FakeAuthenticator: LockAuthenticator {
    static let shared = FakeAuthenticator()
    nonisolated static let startingDomainState = Data("A".utf8)

    struct Request: Identifiable {
        let id = UUID()
        let policy: LockPolicy
        let reason: String
    }

    private(set) var request: Request?
    @ObservationIgnored private var answer: CheckedContinuation<Bool, Never>?

    private nonisolated static func value(_ flag: String) -> String? {
        let arguments = ProcessInfo.processInfo.arguments
        return arguments.firstIndex(of: flag).flatMap { $0 + 1 < arguments.count ? arguments[$0 + 1] : nil }
    }

    nonisolated var passcodeSet: Bool { Self.value("-test-passcode") != "none" }
    nonisolated var biometricsAvailable: Bool { Self.value("-test-face") != "none" }
    nonisolated var domainState: Data? { biometricsAvailable ? Data((Self.value("-test-face-domain") ?? "A").utf8) : nil }
    nonisolated var methodName: String { biometricsAvailable ? "Face ID" : "Passcode" }

    func authenticate(_ policy: LockPolicy, reason: String) async -> Bool {
        if policy == .biometrics && !biometricsAvailable { return false }
        answer?.resume(returning: false)
        return await withCheckedContinuation { continuation in
            answer = continuation
            request = Request(policy: policy, reason: reason)
        }
    }

    /// The test's tap: Succeed (Face ID), Passcode (only for the iPhone-passcode policy) or Cancel.
    func respond(_ ok: Bool) {
        request = nil
        answer?.resume(returning: ok)
        answer = nil
    }
}
#endif
