import CommonCrypto
import CryptoKit
import Foundation
import Network
import Observation

/// Move from another device (Current Work 73.1, 9 Oct 2026): the user asked for it to work "very similar to WhatsApp's
/// transfer chats". The old iPhone makes a fresh, checked backup file and shows a code (Backup & Export → Move to a New
/// iPhone → Show a Transfer Code); the new iPhone, in onboarding, types that code and the file comes straight from the
/// old one over the local network (Wi‑Fi, or peer-to-peer when they share none). Nothing passes through our server and
/// no account is needed, so it works on the free plan (D10). The new iPhone then restores it like any backup file:
/// checked first, an undo file kept (D5).
///
/// **The code is the key.** Both phones turn it into a TLS pre-shared key (Apple's own pattern for local peer-to-peer
/// apps), so only the phone that knows the code can connect, and everything sent is encrypted. The key is stretched
/// (PBKDF2, 100,000 rounds), so trying codes against a recorded connection costs years, not hours. A code lasts only
/// while its screen is open, and is used once.
nonisolated enum TransferCode {
    /// Crockford's base32: digits and letters with no I, L, O or U, so nothing looks like something else.
    static let alphabet = Array("0123456789ABCDEFGHJKMNPQRSTVWXYZ")
    static let length = 8
    static let serviceType = "_oftenenough._tcp"

    /// Debug builds only: `-transfer-code XXXXXXXX` fixes the old iPhone's code, so two simulators can be checked
    /// against each other.
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

    /// The pre-shared key for a code. Slow on purpose (~50 ms on an iPhone), so run it off the main thread.
    static func key(for code: String) -> Data {
        let password = Array(code.utf8).map { Int8(bitPattern: $0) }
        let salt = Array("com.oftenenough.app.transfer".utf8)
        var key = [UInt8](repeating: 0, count: 32)
        _ = CCKeyDerivationPBKDF(CCPBKDFAlgorithm(kCCPBKDF2), password, password.count, salt, salt.count,
                                 CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA256), 100_000, &key, key.count)
        return Data(key)
    }

    /// TCP with TLS keyed by the code (`key(for:)`). Peer-to-peer is on, so two iPhones with no Wi‑Fi in common still
    /// find each other.
    static func parameters(key: Data) -> NWParameters {
        let tls = NWProtocolTLS.Options()
        let secret = key.withUnsafeBytes { DispatchData(bytes: $0) }
        let identity = Data("OftenEnough".utf8).withUnsafeBytes { DispatchData(bytes: $0) }
        sec_protocol_options_add_pre_shared_key(tls.securityProtocolOptions, secret as __DispatchData, identity as __DispatchData)
        sec_protocol_options_append_tls_ciphersuite(tls.securityProtocolOptions, tls_ciphersuite_t(rawValue: UInt16(TLS_PSK_WITH_AES_128_GCM_SHA256))!)
        let tcp = NWProtocolTCP.Options()
        tcp.enableKeepalive = true
        tcp.keepaliveIdle = 2
        let parameters = NWParameters(tls: tls, tcp: tcp)
        parameters.includePeerToPeer = true
        return parameters
    }

    /// What goes over the connection: "OET1", the file's length (8 bytes) and SHA-256 (32 bytes), then the file. The
    /// new iPhone answers one byte, 1, once the file has arrived whole and its checksum matches.
    static let magic = Data("OET1".utf8)
    static let headerLength = 4 + 8 + 32

    static func header(for file: Data) -> Data {
        var length = UInt64(file.count).bigEndian
        return magic + Data(bytes: &length, count: 8) + Data(SHA256.hash(data: file))
    }

    /// The length and checksum from a header, or nil if it isn't one.
    static func read(header: Data) -> (length: Int, sha256: Data)? {
        guard header.count == headerLength, header.prefix(4) == magic else { return nil }
        let length = header.dropFirst(4).prefix(8).reduce(UInt64(0)) { $0 << 8 | UInt64($1) }
        guard length > 0, length < 512 * 1024 * 1024 else { return nil }
        return (Int(length), Data(header.suffix(32)))
    }

    /// A local-network permission refusal: iOS reports it as a DNS-SD "policy denied".
    static func isPermissionDenied(_ error: NWError) -> Bool {
        if case .dns(let code) = error, code == DNSServiceErrorType(kDNSServiceErr_PolicyDenied) { return true }
        return false
    }
}

/// The old iPhone's side: shows the code, waits for the new iPhone, and sends the file once.
@Observable
final class TransferSender {
    enum State: Equatable {
        case preparing
        case waiting
        case sending(Double)
        case sent
        case needsPermission
        case failed(String)
    }

    private(set) var state: State = .preparing
    let code = TransferCode.debugCode ?? TransferCode.make()
    @ObservationIgnored private var listener: NWListener?
    @ObservationIgnored private var connection: NWConnection?
    @ObservationIgnored private var file = Data()

    /// Starts listening with `file`, the backup the new iPhone will get.
    func start(file: Data) async {
        self.file = file
        let code = code
        let key = await Task.detached { TransferCode.key(for: code) }.value
        do {
            let listener = try NWListener(using: TransferCode.parameters(key: key))
            listener.service = NWListener.Service(name: "Often Enough " + String(UUID().uuidString.prefix(6)), type: TransferCode.serviceType)
            listener.stateUpdateHandler = { [weak self] state in
                MainActor.assumeIsolated { self?.listenerChanged(state) }
            }
            listener.newConnectionHandler = { [weak self] connection in
                MainActor.assumeIsolated { self?.accept(connection) }
            }
            self.listener = listener
            listener.start(queue: .main)
        } catch {
            state = .failed("Couldn't get ready to send. Please try again.")
        }
    }

    /// Something went wrong before waiting started (the backup couldn't be made).
    func fail(_ text: String) {
        stop()
        state = .failed(text)
    }

    func stop() {
        listener?.cancel()
        listener = nil
        connection?.cancel()
        connection = nil
    }

    private func listenerChanged(_ new: NWListener.State) {
        switch new {
        case .ready:
            if state == .preparing { state = .waiting }
        case .waiting(let error):
            if TransferCode.isPermissionDenied(error) { state = .needsPermission }
        case .failed(let error):
            state = TransferCode.isPermissionDenied(error) ? .needsPermission : .failed("Stopped waiting for your new iPhone. Please try again.")
            stop()
        default: break
        }
    }

    /// The first phone that knows the code; a phone with the wrong code never gets past the TLS handshake, and the
    /// code is used once.
    private func accept(_ new: NWConnection) {
        guard state == .waiting else { new.cancel(); return }
        // A connection still shaking hands (a wrong code can hang there) never blocks the next phone.
        connection?.cancel()
        connection = new
        new.stateUpdateHandler = { [weak self, weak new] state in
            MainActor.assumeIsolated {
                guard let self, let new, self.connection === new else { return }
                switch state {
                case .ready: self.send(on: new)
                case .failed, .cancelled:
                    // A wrong code, or the new iPhone went away before the end: keep waiting for the right one.
                    if case .sending = self.state { self.state = .failed("The connection to your new iPhone was lost. Please try again.") }
                    self.connection = nil
                default: break
                }
            }
        }
        new.start(queue: .main)
    }

    private func send(on connection: NWConnection) {
        state = .sending(0)
        listener?.cancel() // used once: nobody else can connect with this code now
        connection.send(content: TransferCode.header(for: file), completion: .idempotent)
        sendChunk(from: 0, on: connection)
    }

    /// The file in 256 KB pieces, so the screen can show how far it's got.
    private func sendChunk(from offset: Int, on connection: NWConnection) {
        let end = min(offset + 256 * 1024, file.count)
        connection.send(content: file.subdata(in: offset..<end), completion: .contentProcessed { [weak self] error in
            MainActor.assumeIsolated {
                guard let self else { return }
                if error != nil { self.state = .failed("The connection to your new iPhone was lost. Please try again."); return }
                self.state = .sending(Double(end) / Double(max(self.file.count, 1)))
                if end < self.file.count { self.sendChunk(from: end, on: connection) } else { self.waitForAnswer(on: connection) }
            }
        })
    }

    private func waitForAnswer(on connection: NWConnection) {
        connection.receive(minimumIncompleteLength: 1, maximumLength: 1) { [weak self] data, _, _, _ in
            MainActor.assumeIsolated {
                guard let self else { return }
                self.state = data == Data([1]) ? .sent : .failed("Your new iPhone couldn't read the data. Please try again.")
                self.stop()
            }
        }
    }
}

/// The new iPhone's side: finds the old iPhone that shows this code and receives the file.
@Observable
final class TransferReceiver {
    enum Failure: Error, Equatable {
        /// No old iPhone answered at all.
        case notFound
        /// An old iPhone answered, but not with this code.
        case wrongCode
        case needsPermission
        case lost
        case damaged
    }

    /// 0…1 once the file is arriving; nil while looking.
    private(set) var progress: Double?
    @ObservationIgnored private var browser: NWBrowser?
    @ObservationIgnored private var connections: [NWConnection] = []
    @ObservationIgnored private var tried: Set<NWEndpoint> = []
    /// Phones offering a transfer that turned this code away (checked in the simulator, 9 Oct 2026: the handshake
    /// fails as a reset connection, not always as a TLS error, so any failure to a phone that was just found counts).
    @ObservationIgnored private var refused: Set<NWEndpoint> = []
    @ObservationIgnored private var continuation: CheckedContinuation<Data, Error>?
    @ObservationIgnored private var received = Data()
    @ObservationIgnored private var expected: (length: Int, sha256: Data)?
    @ObservationIgnored private var receiving: NWConnection?
    @ObservationIgnored private var key = Data()

    /// The file from the old iPhone. Gives up after `timeout` seconds without one (it keeps going while a file is
    /// arriving).
    func receive(code: String, timeout: Double = 30) async throws -> Data {
        // A fresh start each time (Try again): every phone nearby is worth trying again.
        tried = []
        refused = []
        received = Data()
        expected = nil
        progress = nil
        let key = await Task.detached { TransferCode.key(for: code) }.value
        self.key = key
        return try await withTaskCancellationHandler {
            try await withCheckedThrowingContinuation { continuation in
                self.continuation = continuation
                self.browse()
                Task { [weak self] in
                    try? await Task.sleep(for: .seconds(timeout))
                    guard let self, self.receiving == nil else { return }
                    self.finish(.failure(self.refused.isEmpty ? Failure.notFound : Failure.wrongCode))
                }
            }
        } onCancel: {
            Task { @MainActor [weak self] in self?.finish(.failure(CancellationError())) }
        }
    }

    private func browse() {
        let browser = NWBrowser(for: .bonjour(type: TransferCode.serviceType, domain: nil), using: TransferCode.parameters(key: key))
        browser.stateUpdateHandler = { [weak self] state in
            MainActor.assumeIsolated {
                switch state {
                case .waiting(let error) where TransferCode.isPermissionDenied(error), .failed(let error) where TransferCode.isPermissionDenied(error):
                    self?.finish(.failure(Failure.needsPermission))
                default: break
                }
            }
        }
        browser.browseResultsChangedHandler = { [weak self] results, _ in
            MainActor.assumeIsolated {
                for result in results { self?.connect(to: result.endpoint) }
            }
        }
        self.browser = browser
        browser.start(queue: .main)
    }

    /// Tries each old iPhone that's offering a transfer; only the one showing this code completes the handshake.
    private func connect(to endpoint: NWEndpoint) {
        guard receiving == nil, tried.insert(endpoint).inserted else { return }
        let connection = NWConnection(to: endpoint, using: TransferCode.parameters(key: key))
        connections.append(connection)
        connection.stateUpdateHandler = { [weak self, weak connection] state in
            MainActor.assumeIsolated {
                guard let self, let connection else { return }
                switch state {
                case .ready:
                    guard self.receiving == nil else { connection.cancel(); return }
                    self.receiving = connection
                    self.readHeader(on: connection)
                case .waiting, .failed:
                    if self.receiving !== connection {
                        // A phone showing a different code.
                        connection.cancel()
                        self.refused.insert(endpoint)
                        self.giveUpIfAllRefused()
                    } else if case .failed = state {
                        self.finish(.failure(Failure.lost))
                    }
                default: break
                }
            }
        }
        connection.start(queue: .main)
        // A phone with a different code doesn't always fail the handshake: it can simply never answer (seen in the
        // simulator, 9 Oct 2026). Five seconds without one counts as turning the code away.
        Task { [weak self, weak connection] in
            try? await Task.sleep(for: .seconds(5))
            guard let self, let connection, self.receiving !== connection, self.continuation != nil else { return }
            if case .ready = connection.state { return }
            connection.cancel()
            self.refused.insert(endpoint)
            self.giveUpIfAllRefused()
        }
    }

    /// Every phone found so far turned the code away: wait a few seconds for another to appear, then say the code
    /// doesn't match, rather than wait out the whole time.
    private func giveUpIfAllRefused() {
        Task { [weak self] in
            try? await Task.sleep(for: .seconds(3))
            guard let self, self.receiving == nil, !self.refused.isEmpty, self.refused == self.tried else { return }
            self.finish(.failure(Failure.wrongCode))
        }
    }

    private func readHeader(on connection: NWConnection) {
        connection.receive(minimumIncompleteLength: TransferCode.headerLength, maximumLength: TransferCode.headerLength) { [weak self] data, _, _, error in
            MainActor.assumeIsolated {
                guard let self else { return }
                guard error == nil, let data, let header = TransferCode.read(header: data) else {
                    return self.finish(.failure(error == nil ? Failure.damaged : Failure.lost))
                }
                self.expected = header
                self.received = Data(capacity: header.length)
                self.progress = 0
                self.readBody(on: connection)
            }
        }
    }

    private func readBody(on connection: NWConnection) {
        guard let expected else { return }
        connection.receive(minimumIncompleteLength: 1, maximumLength: min(256 * 1024, expected.length - received.count)) { [weak self] data, _, complete, error in
            MainActor.assumeIsolated {
                guard let self, let expected = self.expected else { return }
                if let data { self.received.append(data) }
                self.progress = Double(self.received.count) / Double(expected.length)
                if self.received.count >= expected.length {
                    guard Data(SHA256.hash(data: self.received)) == expected.sha256 else { return self.finish(.failure(Failure.damaged)) }
                    // Tell the old iPhone it arrived whole, then hand the file over once that's sent.
                    let file = self.received
                    connection.send(content: Data([1]), completion: .contentProcessed { [weak self] _ in
                        MainActor.assumeIsolated { self?.finish(.success(file)) }
                    })
                } else if error != nil || complete {
                    self.finish(.failure(Failure.lost))
                } else {
                    self.readBody(on: connection)
                }
            }
        }
    }

    private func finish(_ result: Result<Data, Error>) {
        guard let continuation else { return }
        self.continuation = nil
        browser?.cancel()
        browser = nil
        for connection in connections { connection.cancel() }
        connections = []
        receiving = nil
        continuation.resume(with: result)
    }
}
