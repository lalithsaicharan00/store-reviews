import Core
import Foundation
import Security
import UIKit

/// Keeps this device in step with the account's other devices (Architecture 05 §11, 06 §7).
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
    private var accessToken: String?
    private var running: Task<Void, Never>?
    private var debounce: Task<Void, Never>?
    private var poll: Task<Void, Never>?

    /// Called after other devices' changes were merged into the database, so the screen re-reads them.
    var onRemoteChanges: (() -> Void)?
    /// The last failure, for diagnostics; nil after a successful sync.
    private(set) var lastError: String?

    /// - Parameter storeName: the database's name; UI tests use their own, so each simulated device has its own identity.
    init(repository: HabitRepository, storeName: String, api: URL, reset: Bool = false) {
        self.repository = repository
        self.api = api
        keychain = Keychain(service: "com.oftenenough.app.sync.\(storeName)")
        if reset { keychain.removeAll() }
    }

    var isSignedIn: Bool { keychain.read(.refreshToken) != nil }

    /// This device's ID: made once and kept in the Keychain on this device only, never in a backup (01 §3.1).
    var deviceID: String {
        if let id = keychain.read(.deviceID) { return id }
        let id = UUID().uuidString.lowercased()
        keychain.write(.deviceID, id)
        return id
    }

    // MARK: Signing in

    /// Signs in through `path` (`/v1/auth/apple`, …) with the provider's details in `body`, then starts syncing
    /// this device's data with the account.
    func signIn(path: String, body: [String: Any]) async throws {
        var body = body
        body["device"] = [
            "id": deviceID,
            "platform": UIDevice.current.userInterfaceIdiom == .pad ? "ipados" : "ios",
            "name": UIDevice.current.model,
            "appVersion": Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0",
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
        try await repository.bindAccount(accountId: accountID)
        await syncNow()
    }

    // MARK: When sync runs (05 §11.1)

    /// After a change: wait for 3 seconds of quiet, then send.
    func scheduleSoon() {
        guard isSignedIn else { return }
        debounce?.cancel()
        debounce = Task { [weak self] in
            try? await Task.sleep(for: .seconds(3))
            guard !Task.isCancelled else { return }
            await self?.syncNow()
        }
    }

    /// The app is open: sync now, then pull every 60 seconds as a fallback to push.
    func appBecameActive() {
        guard isSignedIn else { return }
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
        guard isSignedIn else { return }
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
                let (status, data) = try await send("/v1/sync", body: Data(request.utf8), authorized: true)
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
        let (status, data) = try await send(path, body: try JSONSerialization.data(withJSONObject: json), authorized: authorized)
        return (status, (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] ?? [:])
    }

    /// Sends a request; with `authorized`, refreshes the access token when it's missing or expired, once.
    private func send(_ path: String, body: Data, authorized: Bool, retried: Bool = false) async throws -> (Int, Data) {
        if authorized && accessToken == nil { try await refresh() }
        var request = URLRequest(url: api.appending(path: path), timeoutInterval: 20)
        request.httpMethod = "POST"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        if authorized, let accessToken { request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "authorization") }
        let (data, response) = try await URLSession.shared.data(for: request)
        let status = (response as? HTTPURLResponse)?.statusCode ?? 0
        if authorized && status == 401 && !retried {
            if Self.errorCode(data) == "signed_out" { signedOut(); throw ServerError(status: 401, code: "signed_out") }
            accessToken = nil
            return try await send(path, body: body, authorized: true, retried: true)
        }
        return (status, data)
    }

    private func refresh() async throws {
        guard let token = keychain.read(.refreshToken) else { throw ServerError(status: 401, code: "signed_out") }
        let (status, json) = try await post("/v1/auth/refresh", json: ["refreshToken": token], authorized: false)
        if status == 401 { signedOut(); throw ServerError(status: 401, code: "signed_out") }
        guard status == 200, let access = json["accessToken"] as? String, let next = json["refreshToken"] as? String else {
            throw ServerError(status: status, code: json["error"] as? String ?? "unexpected")
        }
        // Saved before it's used: if the app dies now, the server still accepts this token (or the old one, briefly).
        keychain.write(.refreshToken, next)
        accessToken = access
    }

    /// The session is over (signed out elsewhere, or deleted). Everything on this device is kept; only the tokens go.
    private func signedOut() {
        keychain.write(.refreshToken, nil)
        accessToken = nil
        poll?.cancel()
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
private final class Keychain {
    enum Item: String { case refreshToken = "refresh-token", deviceID = "device-id" }

    let service: String
    private var memory: [Item: String?] = [:]

    init(service: String) { self.service = service }

    private func query(_ item: Item) -> [String: Any] {
        [kSecClass as String: kSecClassGenericPassword, kSecAttrService as String: service, kSecAttrAccount as String: item.rawValue]
    }

    func read(_ item: Item) -> String? {
        if let cached = memory[item] { return cached }
        var q = query(item)
        q[kSecReturnData as String] = true
        q[kSecMatchLimit as String] = kSecMatchLimitOne
        var result: AnyObject?
        let value = SecItemCopyMatching(q as CFDictionary, &result) == errSecSuccess ? (result as? Data).flatMap { String(data: $0, encoding: .utf8) } : nil
        memory[item] = .some(value)
        return value
    }

    func write(_ item: Item, _ value: String?) {
        memory[item] = .some(value)
        SecItemDelete(query(item) as CFDictionary)
        guard let value else { return }
        var q = query(item)
        q[kSecValueData as String] = Data(value.utf8)
        q[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        SecItemAdd(q as CFDictionary, nil)
    }

    func removeAll() {
        memory.removeAll()
        SecItemDelete([kSecClass as String: kSecClassGenericPassword, kSecAttrService as String: service] as CFDictionary)
    }
}
