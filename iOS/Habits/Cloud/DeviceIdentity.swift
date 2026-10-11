import Foundation
import Security
import UIKit

/// This device's ID (Architecture 01 §3.1, kept for iCloud, Architecture 11 §12): made once and kept in the Keychain on
/// this device only, never in a backup, so it outlives a reinstall (the Keychain survives deleting the app) and a phone
/// restored from another's backup gets its own. It names this device's folder of backup files in iCloud Drive
/// (`BackupFolder`) and, on the free plan, the one syncing device (`activeDevice`). The Keychain's names are the ones
/// the server-era build used, so every install keeps the ID it already has (and with it its iCloud backup folder).
final class DeviceIdentity {
    private let keychain: DeviceKeychain?
    private let fixed: String?

    /// - Parameter storeName: the database's name; UI tests use their own, so each simulated device has its own ID.
    init(storeName: String, reset: Bool = false) {
        let keychain = DeviceKeychain(service: "com.oftenenough.app.sync.\(storeName)")
        if reset { keychain.removeAll() }
        self.keychain = keychain
        fixed = nil
    }

    /// A simulated device in the checks: its own ID, no Keychain.
    init(fixedID: String) {
        keychain = nil
        fixed = fixedID
    }

    var deviceID: String {
        if let fixed { return fixed }
        guard let keychain else { return "unknown" }
        if let id = keychain.read(.deviceID) { return id }
        let id = UUID().uuidString.lowercased()
        keychain.write(.deviceID, id)
        return id
    }

    /// "iPhone" or "iPad" (iOS gives apps the model, not the person's own name for it).
    static var name: String { UIDevice.current.model }
    static var platform: String { UIDevice.current.userInterfaceIdiom == .pad ? "ipados" : "ios" }
    static var appVersion: String { Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0" }
}

/// Small Keychain wrapper: items readable after the first unlock (so background refresh works), on this device only
/// (never in an iPhone backup, so a phone restored from another's backup gets its own ID).
/// Values are also kept in memory, so a Keychain write that fails (an unsigned simulator build, a full or locked
/// Keychain) can't make a fresh sign-in look signed out; it then only lasts until the app quits.
///
/// The Keychain is only touched off the main thread (Current Work 11, 4 Oct 2026): its calls go through a system
/// service that can stall for tens of seconds on a busy phone or simulator, and a sign-in wrote the token on the main
/// thread, so the app stopped answering for ~74 s right after a signed-in launch (BackupUITests, 4 of 13 runs). Writes
/// queue in order behind the memory copy; the item is read ahead at launch; a read that still misses (rare) waits.
nonisolated final class DeviceKeychain: @unchecked Sendable {
    enum Item: String, CaseIterable { case deviceID = "device-id" }

    let service: String
    private let lock = NSLock()
    private var memory: [Item: String?] = [:]
    private let queue = DispatchQueue(label: "com.oftenenough.keychain", qos: .userInitiated)

    init(service: String) {
        self.service = service
        queue.async { [self] in for item in Item.allCases { _ = read(item) } }
    }

    private func query(_ item: Item) -> [String: Any] {
        [kSecClass as String: kSecClassGenericPassword, kSecAttrService as String: service, kSecAttrAccount as String: item.rawValue]
    }

    private func cached(_ item: Item) -> String?? {
        lock.lock(); defer { lock.unlock() }
        return memory[item]
    }

    func read(_ item: Item) -> String? {
        if let cached = cached(item) { return cached }
        var q = query(item)
        q[kSecReturnData as String] = true
        q[kSecMatchLimit as String] = kSecMatchLimitOne
        var result: AnyObject?
        let started = Date.now
        let found = SecItemCopyMatching(q as CFDictionary, &result) == errSecSuccess ? (result as? Data).flatMap { String(data: $0, encoding: .utf8) } : nil
        LaunchLog.took("Keychain read \(item.rawValue)", since: started)
        lock.lock(); defer { lock.unlock() }
        // A write that came first wins: it's newer than what was stored.
        if memory[item] == nil { memory[item] = .some(found) }
        return memory[item] ?? nil
    }

    func write(_ item: Item, _ value: String?) {
        lock.lock(); memory[item] = .some(value); lock.unlock()
        let match = query(item)
        queue.async {
            let started = Date.now
            SecItemDelete(match as CFDictionary)
            if let value {
                var q = match
                q[kSecValueData as String] = Data(value.utf8)
                q[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
                SecItemAdd(q as CFDictionary, nil)
            }
            LaunchLog.took("Keychain write \(item.rawValue)", since: started)
        }
    }

    func removeAll() {
        lock.lock(); memory.removeAll(); lock.unlock()
        let all = [kSecClass as String: kSecClassGenericPassword, kSecAttrService as String: service] as [String: Any]
        queue.async { SecItemDelete(all as CFDictionary) }
    }
}
