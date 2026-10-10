import CommonCrypto
import CryptoKit
import Foundation
import Observation

/// Move from another device (Current Work 73.1; through the server since 10 Oct 2026, the user: "it should be server
/// based … like WhatsApp", mainly for people without an account). The old device makes a fresh, checked backup file and
/// shows a code (Backup & Export → Move to Another Device); the new device, in onboarding, types that code and gets the
/// file through our server, so the two can be anywhere, on any network, and later iPhone or Android. No account is
/// needed, so it works on the free plan (D10). The new device then restores it like any backup file: checked first, an
/// undo file kept (D5).
///
/// **The code is the key, and the server never sees it** (`server/src/transfer.ts`): both devices stretch the code
/// (PBKDF2-SHA256, 100,000 rounds, 64 bytes). The first 32 bytes are the AES-256-GCM key the old device seals the file
/// with; the SHA-256 of the last 32 is the transfer's ID, all the server is given. A code works once, for an hour at
/// most, and only while the old device's screen is open; the server deletes the file the moment it has arrived.
nonisolated enum TransferCode {
    /// Crockford's base32: digits and letters with no I, L, O or U, so nothing looks like something else.
    static let alphabet = Array("0123456789ABCDEFGHJKMNPQRSTVWXYZ")
    static let length = 8

    /// Debug builds only: `-transfer-code XXXXXXXX` fixes the old device's code, so a test can type it on another.
    static var debugCode: String? {
        #if DEBUG
        let arguments = ProcessInfo.processInfo.arguments
        if let at = arguments.firstIndex(of: "-transfer-code"), at + 1 < arguments.count { return normalize(arguments[at + 1]) }
        #endif
        return nil
    }

    /// Eight random characters (40 bits).
    static func make() -> String {
        var bytes = [UInt8](repeating: 0, count: length)
        _ = SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)
        return String(bytes.map { alphabet[Int($0) % alphabet.count] })
    }

    /// What was typed, as the code: capitals, O read as 0 and I or L as 1 (as Crockford intends), anything else
    /// (spaces, the dash) dropped, at most eight characters.
    static func normalize(_ typed: String) -> String {
        var out = ""
        for character in typed.uppercased() {
            let mapped: Character
            switch character {
            case "O": mapped = "0"
            case "I", "L": mapped = "1"
            default: mapped = character
            }
            if alphabet.contains(mapped) { out.append(mapped) }
            if out.count == length { break }
        }
        return out
    }

    /// "K7PQ 49XM": two groups of four, easy to read out and type.
    static func display(_ code: String) -> String {
        guard code.count > 4 else { return code }
        return String(code.prefix(4)) + " " + String(code.dropFirst(4))
    }

    /// What both devices make from a code: the key that seals the file and the transfer's ID on the server.
    nonisolated struct Secrets: Sendable, Equatable {
        let key: Data
        let id: String
    }

    /// Slow on purpose (~0.1 s on an iPhone): run it off the main thread. Android follows the same recipe.
    static func secrets(for code: String) -> Secrets {
        let password = Array(code.utf8).map { Int8(bitPattern: $0) }
        let salt = Array("com.oftenenough.app.transfer.v2".utf8)
        var out = [UInt8](repeating: 0, count: 64)
        _ = CCKeyDerivationPBKDF(CCPBKDFAlgorithm(kCCPBKDF2), password, password.count, salt, salt.count,
                                 CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA256), 100_000, &out, out.count)
        let id = SHA256.hash(data: Data(out[32..<64])).map { String(format: "%02x", $0) }.joined()
        return Secrets(key: Data(out[0..<32]), id: id)
    }

    /// Whether the sending device was signed in (Account and Backup Redesign §7 item 3, decided 10 Oct 2026). Sign-ins
    /// never travel between devices; the new one only learns to ask "Sign in to keep your account".
    nonisolated enum Account: UInt8, Sendable { case none = 0, free = 1, plus = 2 }

    /// What's sealed: "OEX1", the sending device's account byte, then the backup file.
    static let magic = Data("OEX1".utf8)

    static func seal(_ file: Data, account: Account, key: Data) throws -> Data {
        let plain = magic + Data([account.rawValue]) + file
        guard let sealed = try AES.GCM.seal(plain, using: SymmetricKey(data: key)).combined else { throw CocoaError(.coderInvalidValue) }
        return sealed
    }

    /// The file and the sender's account, or nil when it wasn't sealed with this key or arrived damaged (GCM checks both).
    static func open(_ sealed: Data, key: Data) -> (file: Data, account: Account)? {
        guard let box = try? AES.GCM.SealedBox(combined: sealed),
              let plain = try? AES.GCM.open(box, using: SymmetricKey(data: key)),
              plain.count > magic.count + 1, plain.prefix(magic.count) == magic else { return nil }
        let account = Account(rawValue: plain[plain.startIndex + magic.count]) ?? .none
        return (Data(plain.dropFirst(magic.count + 1)), account)
    }
}

/// The server's half of a move (`server/src/transfer.ts`): no account, only the ID the code makes.
nonisolated struct TransferServer: Sendable {
    let api: URL
    let id: String

    nonisolated enum Problem: Error, Equatable {
        /// Nothing under this ID: a wrong code, or one that has expired or was cancelled.
        case notFound
        case tooLarge
        case server(Int)
    }

    private func url(_ suffix: String = "") -> URL { api.appending(path: "/v1/transfer/\(id)\(suffix)") }

    private func send(_ method: String, _ suffix: String = "", body: Data? = nil) async throws -> (Int, Data) {
        var request = URLRequest(url: url(suffix), timeoutInterval: (body?.count ?? 0) > 1_000_000 ? 120 : 30)
        request.httpMethod = method
        let data: Data
        let response: URLResponse
        if let body {
            request.setValue("application/octet-stream", forHTTPHeaderField: "content-type")
            (data, response) = try await URLSession.shared.upload(for: request, from: body)
        } else {
            (data, response) = try await URLSession.shared.data(for: request)
        }
        return ((response as? HTTPURLResponse)?.statusCode ?? 0, data)
    }

    func upload(_ sealed: Data) async throws {
        let (status, _) = try await send("PUT", body: sealed)
        guard status == 201 else { throw status == 413 ? Problem.tooLarge : Problem.server(status) }
    }

    func download() async throws -> Data {
        let (status, data) = try await send("GET")
        if status == 404 { throw Problem.notFound }
        guard status == 200 else { throw Problem.server(status) }
        return data
    }

    /// The new device has the file, opened and checked: the server deletes it, and the old device sees "Done".
    func received() async throws {
        _ = try await send("POST", "/received")
    }

    /// "waiting", "received" or "gone".
    func status() async throws -> String {
        let (status, data) = try await send("GET", "/status")
        guard status == 200 else { throw Problem.server(status) }
        return ((try? JSONSerialization.jsonObject(with: data)) as? [String: Any])?["state"] as? String ?? "waiting"
    }

    func cancel() async throws {
        _ = try await send("DELETE")
    }
}

/// The old device's side: seals the file with the code, hands it to the server, and waits until the new device has it.
@Observable
final class TransferSender {
    enum State: Equatable {
        case preparing
        case waiting
        case sent
        /// The hour is over, or the file went: a new code is needed.
        case expired
        case failed(String)
    }

    private(set) var state: State = .preparing
    let code = TransferCode.debugCode ?? TransferCode.make()
    @ObservationIgnored private var server: TransferServer?
    @ObservationIgnored private var polling: Task<Void, Never>?
    @ObservationIgnored private var stopped = false

    /// Sends `file`, the backup the new device will get, with whether this device is signed in, through `api`.
    func start(file: Data, account: TransferCode.Account = .none, api: URL) async {
        let code = code
        do {
            let (server, sealed) = try await Task.detached {
                let secrets = TransferCode.secrets(for: code)
                return (TransferServer(api: api, id: secrets.id), try TransferCode.seal(file, account: account, key: secrets.key))
            }.value
            self.server = server
            try await server.upload(sealed)
            // The screen was left while it uploaded: the file mustn't wait on the server for nobody.
            guard !stopped else {
                self.server = nil
                Task.detached { try? await server.cancel() }
                return
            }
            state = .waiting
            poll(server)
        } catch TransferServer.Problem.tooLarge {
            state = .failed("Your data is too large to move with a code. Save a backup file and open it on the other device instead.")
        } catch {
            state = .failed("Couldn't reach the server. Check your connection and try again. Your habits are safe on this device.")
        }
    }

    /// Asks every 5 s whether the file has arrived (well inside the server's 60 a minute per address).
    private func poll(_ server: TransferServer) {
        polling = Task { [weak self] in
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(5))
                guard !Task.isCancelled else { return }
                guard let state = try? await server.status() else { continue }
                guard let self else { return }
                if state == "received" { self.state = .sent; self.server = nil; return }
                if state == "gone" { self.state = .expired; self.server = nil; return }
            }
        }
    }

    /// Something went wrong before the upload (the backup couldn't be made).
    func fail(_ text: String) {
        stop()
        state = .failed(text)
    }

    /// Leaving the screen ends the code: the file is deleted from the server unless it has already arrived.
    func stop() {
        stopped = true
        polling?.cancel()
        polling = nil
        if let server, state != .sent {
            self.server = nil
            Task.detached { try? await server.cancel() }
        }
    }
}

/// The new device's side: gets the file the code points to, and opens it with the code.
@Observable
final class TransferReceiver {
    enum Failure: Error, Equatable {
        /// Nothing for this code: mistyped, expired, or the old device left its screen.
        case wrongCode
        case unreachable
        case damaged
    }

    /// Whether the sending device was signed in (sealed with the file).
    private(set) var senderAccount = TransferCode.Account.none
    @ObservationIgnored private var server: TransferServer?

    /// The file from the old device, through `api`.
    func receive(code: String, api: URL) async throws -> Data {
        let secrets = await Task.detached { TransferCode.secrets(for: code) }.value
        let server = TransferServer(api: api, id: secrets.id)
        let sealed: Data
        do {
            sealed = try await server.download()
        } catch TransferServer.Problem.notFound {
            throw Failure.wrongCode
        } catch is CancellationError {
            throw CancellationError()
        } catch let error as URLError where error.code == .cancelled {
            throw CancellationError()
        } catch {
            throw Failure.unreachable
        }
        guard let opened = TransferCode.open(sealed, key: secrets.key) else { throw Failure.damaged }
        self.server = server
        senderAccount = opened.account
        return opened.file
    }

    /// The file was checked and can be restored: the server deletes it, and the old device says "Done".
    func confirm() async {
        guard let server else { return }
        self.server = nil
        try? await server.received()
    }
}
