import Core
import Foundation
import Security
import UIKit

/// Keeps this device in step with the account's other devices (Architecture 05 §11, 06 §7), and holds the
/// account's session. Accounts are optional and free; **only Plus syncs** (Backup, Sync and Accounts, rule 1): the
/// server says whether the account has Plus with every token, and a free account's data never enters the outbox.
/// A free account's backup goes to the server through `BackupCenter` instead.
///
/// It is never in the way: every change is already saved on the phone before sync hears of it, nothing waits for
/// the network, failures are retried quietly on the next trigger, and a failed session never clears any data
/// (01 §3.5). The Kotlin core decides what to send and merges what comes back; this class only moves the bytes
/// and keeps the tokens.
@MainActor
final class SyncService {
    private let repository: HabitRepository
    private let api: URL
    private let keychain: Keychain
    private let defaults: UserDefaults = .standard
    private let storeName: String
    private var accessToken: String?
    private var running: Task<Void, Never>?
    private var debounce: Task<Void, Never>?
    private var poll: Task<Void, Never>?

    /// Called after other devices' changes were merged into the database, so the screen re-reads them.
    var onRemoteChanges: (() -> Void)?
    /// The last failure, for diagnostics; nil after a successful sync.
    private(set) var lastError: String?
    /// Called when signing in or out, Plus arriving or going, or the server ending the session.
    var onAccountChange: (() -> Void)?

    /// - Parameter storeName: the database's name; UI tests use their own, so each simulated device has its own identity.
    init(repository: HabitRepository, storeName: String, api: URL, reset: Bool = false) {
        self.repository = repository
        self.api = api
        self.storeName = storeName
        keychain = Keychain(service: "com.oftenenough.app.sync.\(storeName)")
        if reset {
            keychain.removeAll()
            for key in [Key.account, Key.plus, Key.sessionEnded] { defaults.removeObject(forKey: key + storeName) }
        }
    }

    private enum Key {
        static let account = "account.id."
        static let plus = "account.plus."
        static let sessionEnded = "account.sessionEnded."
    }

    var isSignedIn: Bool { keychain.read(.refreshToken) != nil }
    /// The account this device is signed in to (kept after the server ends a session, so "Sign in" can say so).
    var accountID: String? { defaults.string(forKey: Key.account + storeName) }
    /// The account had Plus at the last sign-in or refresh. Only Plus syncs.
    var isPlus: Bool { isSignedIn && defaults.bool(forKey: Key.plus + storeName) }
    /// The server ended this device's session (signed out elsewhere, or the account was deleted). Cleared by signing
    /// in again or signing out here. Backup & Sync and Today say so (Backup, Sync and Accounts §4.4).
    var sessionEnded: Bool { defaults.bool(forKey: Key.sessionEnded + storeName) }

    /// This device's ID: made once and kept in the Keychain on this device only, never in a backup (01 §3.1).
    var deviceID: String {
        if let id = keychain.read(.deviceID) { return id }
        let id = UUID().uuidString.lowercased()
        keychain.write(.deviceID, id)
        return id
    }

    // MARK: Signing in

    /// Signs in through `path` (`/v1/auth/apple`, …) with the provider's details in `body`. With Plus, this device's
    /// data starts syncing with the account; without, nothing is queued. Throws `ServerError` (`unknown_key` when
    /// there's no account for this sign-in and `create` wasn't sent).
    func signIn(path: String, body: [String: Any]) async throws {
        var body = body
        body["device"] = [
            "id": deviceID,
            "platform": Self.platform,
            "name": UIDevice.current.model,
            "appVersion": Self.appVersion,
        ]
        let (status, json) = try await post(path, json: body, authorized: false)
        guard status == 200 || status == 201,
              let accountID = json["accountId"] as? String,
              let access = json["accessToken"] as? String,
              let refresh = json["refreshToken"] as? String else {
            throw ServerError(status: status, code: json["error"] as? String ?? "unexpected")
        }
        keychain.write(.refreshToken, refresh)
        accessToken = access
        defaults.set(accountID, forKey: Key.account + storeName)
        defaults.set(false, forKey: Key.sessionEnded + storeName)
        try await setPlus(json["plus"] as? Bool ?? false)
        onAccountChange?()
        await syncNow()
    }

    /// Signs this device out, on purpose. Everything stays on the phone; only the session ends (01 §3.5).
    func signOut() async {
        if isSignedIn { _ = try? await send("POST", "/v1/account/signout", body: Data("{}".utf8), authorized: true) }
        forgetAccount()
    }

    /// Deletes the account on the server (Architecture 09 §7): directory first, then its data, backups and snapshots.
    /// Then this device forgets the account; what's on the phone is the caller's choice.
    func deleteAccount() async throws {
        let (status, data) = try await send("POST", "/v1/account/delete", body: Data("{}".utf8), authorized: true)
        guard status == 200 else { throw ServerError(status: status, code: Self.errorCode(data)) }
        forgetAccount()
    }

    /// The account's sign-in methods and devices, for Settings → Account.
    func accountSummary() async throws -> [String: Any] {
        let (status, data) = try await send("GET", "/v1/account", body: nil, authorized: true)
        guard status == 200, let json = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] else {
            throw ServerError(status: status, code: Self.errorCode(data))
        }
        return json
    }

    private func forgetAccount() {
        keychain.write(.refreshToken, nil)
        accessToken = nil
        poll?.cancel()
        for key in [Key.plus, Key.sessionEnded, Key.account] { defaults.removeObject(forKey: key + storeName) }
        onAccountChange?()
    }

    /// Records whether the account has Plus. Plus arriving starts sync: everything here is queued once (05 §5).
    /// Plus going (a refund) stops it; nothing on the phone changes.
    private func setPlus(_ plus: Bool) async throws {
        let was = defaults.bool(forKey: Key.plus + storeName)
        defaults.set(plus, forKey: Key.plus + storeName)
        if plus, let accountID { try await repository.bindAccount(accountId: accountID) }
        if plus != was { onAccountChange?() }
    }

    static var platform: String { UIDevice.current.userInterfaceIdiom == .pad ? "ipados" : "ios" }
    static var appVersion: String { Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0" }

    // MARK: When sync runs (05 §11.1)

    /// After a change: wait for 3 seconds of quiet, then send.
    func scheduleSoon() {
        guard isPlus else { return }
        debounce?.cancel()
        debounce = Task { [weak self] in
            try? await Task.sleep(for: .seconds(3))
            guard !Task.isCancelled else { return }
            await self?.syncNow()
        }
    }

    /// The app is open: sync now, then pull every 60 seconds as a fallback to push.
    func appBecameActive() {
        guard isPlus else { return }
        Task { await syncNow() }
        poll?.cancel()
        poll = Task { [weak self] in
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(60))
                guard !Task.isCancelled else { return }
                await self?.syncNow()
            }
        }
    }

    func appWentToBackground() {
        poll?.cancel()
        poll = nil
    }

    /// One full sync. Calls that arrive while one is running wait for it, then run once more, so nothing is missed.
    func syncNow() async {
        guard isPlus else { return }
        while let running { await running.value }
        let task = Task { await run() }
        running = task
        await task.value
        if running == task { running = nil }
    }

    private func run() async {
        do {
            var more = true
            var rounds = 0
            while more && rounds < 50 {
                rounds += 1
                let request = try await repository.syncRequest(maxOps: 500)
                var (status, data) = try await send("POST", "/v1/sync", body: Data(request.utf8), authorized: true)
                if status == 403 && Self.errorCode(data) == "plus_required" {
                    // The token may be older than a purchase: refresh once, which also re-reads Plus.
                    accessToken = nil
                    try await refresh()
                    guard isPlus else { lastError = nil; return }
                    (status, data) = try await send("POST", "/v1/sync", body: Data(request.utf8), authorized: true)
                }
                guard status == 200, let reply = String(data: data, encoding: .utf8) else {
                    throw ServerError(status: status, code: Self.errorCode(data))
                }
                more = try await repository.acceptSyncReply(reply: reply).boolValue
                if Self.hasOps(data) { onRemoteChanges?() }
            }
            lastError = nil
        } catch {
            // Kept in the outbox; the next trigger tries again. Never shown as "synced" (05 §11.2).
            lastError = "\(error)"
        }
    }

    // MARK: HTTP and tokens

    private func post(_ path: String, json: [String: Any], authorized: Bool) async throws -> (Int, [String: Any]) {
        let (status, data) = try await send("POST", path, body: try JSONSerialization.data(withJSONObject: json), authorized: authorized)
        return (status, (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] ?? [:])
    }

    /// A request on the signed-in account (backups): the status and body. Throws `ServerError` `signed_out` when
    /// the session is over.
    func request(_ method: String, _ path: String, body: Data? = nil, headers: [String: String] = [:]) async throws -> (Int, Data) {
        guard isSignedIn else { throw ServerError(status: 401, code: "signed_out") }
        return try await send(method, path, body: body, authorized: true, headers: headers)
    }

    /// Sends a request; with `authorized`, refreshes the access token when it's missing or expired, once.
    private func send(_ method: String, _ path: String, body: Data?, authorized: Bool, headers: [String: String] = [:], retried: Bool = false) async throws -> (Int, Data) {
        if authorized && accessToken == nil { try await refresh() }
        var request = URLRequest(url: api.appending(path: path), timeoutInterval: body.map { $0.count > 100_000 ? 60 : 20 } ?? 20)
        request.httpMethod = method
        request.httpBody = body
        if body != nil { request.setValue("application/json", forHTTPHeaderField: "content-type") }
        for (name, value) in headers { request.setValue(value, forHTTPHeaderField: name) }
        if authorized, let accessToken { request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "authorization") }
        let (data, response) = try await URLSession.shared.data(for: request)
        let status = (response as? HTTPURLResponse)?.statusCode ?? 0
        if authorized && status == 401 && !retried {
            let code = Self.errorCode(data)
            if code == "signed_out" || code == "account_deleted" { signedOut(deleted: code == "account_deleted"); throw ServerError(status: 401, code: code) }
            accessToken = nil
            return try await send(method, path, body: body, authorized: true, headers: headers, retried: true)
        }
        return (status, data)
    }

    private func refresh() async throws {
        guard let token = keychain.read(.refreshToken) else { throw ServerError(status: 401, code: "signed_out") }
        let (status, json) = try await post("/v1/auth/refresh", json: ["refreshToken": token], authorized: false)
        if status == 401 {
            let deleted = json["error"] as? String == "account_deleted"
            signedOut(deleted: deleted)
            throw ServerError(status: 401, code: deleted ? "account_deleted" : "signed_out")
        }
        guard status == 200, let access = json["accessToken"] as? String, let next = json["refreshToken"] as? String else {
            throw ServerError(status: status, code: json["error"] as? String ?? "unexpected")
        }
        // Saved before it's used: if the app dies now, the server still accepts this token (or the old one, briefly).
        keychain.write(.refreshToken, next)
        accessToken = access
        try await setPlus(json["plus"] as? Bool ?? false)
    }

    /// The session is over: signed out elsewhere, or the account deleted (from another device or the website).
    /// Everything on this device is kept; only the tokens go. A deleted account isn't a problem to fix, so only an
    /// ended session asks the person to sign in again (Backup, Sync and Accounts §4.4).
    private func signedOut(deleted: Bool = false) {
        if deleted {
            forgetAccount()
            return
        }
        keychain.write(.refreshToken, nil)
        accessToken = nil
        poll?.cancel()
        defaults.set(true, forKey: Key.sessionEnded + storeName)
        onAccountChange?()
    }

    private static func errorCode(_ data: Data) -> String {
        ((try? JSONSerialization.jsonObject(with: data)) as? [String: Any])?["error"] as? String ?? "unexpected"
    }

    private static func hasOps(_ data: Data) -> Bool {
        guard let json = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any], let ops = json["ops"] as? [Any] else { return false }
        return !ops.isEmpty
    }
}

/// An error reply from our server: its HTTP status and error code (`signed_out`, `unknown_key`, …).
nonisolated struct ServerError: Error, CustomStringConvertible {
    let status: Int
    let code: String
    var description: String { "\(status) \(code)" }
}

/// Small Keychain wrapper: items readable after the first unlock (so background refresh works), on this device only.
/// Values are also kept in memory, so a Keychain write that fails (an unsigned simulator build, a full or locked
/// Keychain) can't make a fresh sign-in look signed out; it then only lasts until the app quits.
///
/// The Keychain is only touched off the main thread (Current Work 11, 4 Oct 2026): its calls go through a system
/// service that can stall for tens of seconds on a busy phone or simulator, and a sign-in wrote the token on the main
/// thread, so the app stopped answering for ~74 s right after a signed-in launch (BackupUITests, 4 of 13 runs). Writes
/// queue in order behind the memory copy; both items are read ahead at launch; a read that still misses (rare) waits.
nonisolated private final class Keychain: @unchecked Sendable {
    enum Item: String, CaseIterable { case refreshToken = "refresh-token", deviceID = "device-id" }

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
