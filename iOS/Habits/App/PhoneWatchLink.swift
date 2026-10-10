import Core
import Foundation
import WatchConnectivity

/// The iPhone's side of the link with its Apple Watch (Architecture 12 §3.1, §5: the one new piece on the iPhone).
///
/// - When the Watch says hello, the iPhone starts keeping `peer_out` for it and sends the settings it follows.
/// - The Watch asks for its first fill a part at a time; each part is a checked file (`peerFillPart`) sent by
///   `transferFile`, with the part's cursor in its metadata.
/// - Changes go both ways in batches (`peer_out` → `transferUserInfo`), 0.5 s after the last change (S16); while our
///   complication is on the Watch face, by `transferCurrentComplicationUserInfo` (50 a day, Apple) so the face updates
///   promptly. Each batch leaves the queue only when the Watch acknowledges it; a repeat merges as nothing.
/// - What the Watch sends is merged in one transaction and passed on to iCloud with everything else (core: `receive`
///   from the peer goes to the outbox, never back to the Watch).
/// - The Watch app removed or the Watch unpaired: the queue stops and is dropped (the Watch's own copy stays there).
final class PhoneWatchLink: NSObject {
    private let repository: HabitRepository
    private let store: HabitStore
    /// After the Watch's changes are merged: Today, widgets and reminders catch up.
    var onReceived: (() -> Void)?
    private var sendTask: Task<Void, Never>?
    private var inFlight: Int64?
    private var inFlightSince: Date?
    private var lastContext: [String: String] = [:]

    init(repository: HabitRepository, store: HabitStore) {
        self.repository = repository
        self.store = store
        super.init()
    }

    func activate() {
        guard WCSession.isSupported() else { return }
        WCSession.default.delegate = self
        WCSession.default.activate()
    }

    private var session: WCSession? {
        guard WCSession.isSupported(), WCSession.default.activationState == .activated,
              WCSession.default.isPaired, WCSession.default.isWatchAppInstalled else { return nil }
        return WCSession.default
    }

    // MARK: Sending

    func scheduleSend() {
        sendTask?.cancel()
        sendTask = Task { @MainActor [weak self] in
            try? await Task.sleep(for: .milliseconds(500))
            guard !Task.isCancelled else { return }
            await self?.sendBatch()
        }
    }

    private func sendBatch() async {
        guard let session else { return }
        sendSettings(session)
        if inFlight != nil, let since = inFlightSince, Date.now.timeIntervalSince(since) < 120 { return }
        guard let batch = try? await repository.peerBatch(maxOps: 100), let seq = PeerMessage.seq(of: batch) else { inFlight = nil; return }
        inFlight = seq
        inFlightSince = .now
        let message: [String: Any] = [PeerMessage.kind: PeerMessage.ops, PeerMessage.batch: batch]
        if !session.isReachable && session.isComplicationEnabled && session.remainingComplicationUserInfoTransfers > 0 {
            session.transferCurrentComplicationUserInfo(message)
        } else {
            PeerMessage.deliver(message, on: session)
        }
    }

    /// The settings the Watch follows (Hide Names, Done Habits, Show Streaks), sent only when they change.
    private func sendSettings(_ session: WCSession) {
        let defaults = UserDefaults.standard
        let context: [String: String] = [
            PeerMessage.hideNames: HideNames.isOn ? "1" : "0",
            PeerMessage.doneOrder: defaults.string(forKey: Preferences.doneOrder) ?? DoneOrder.bottom.rawValue,
            PeerMessage.showStreaks: (defaults.object(forKey: ProgressOptions.showStreaks) as? Bool ?? true) ? "1" : "0",
        ]
        guard context != lastContext else { return }
        lastContext = context
        try? session.updateApplicationContext([
            PeerMessage.hideNames: context[PeerMessage.hideNames] == "1",
            PeerMessage.doneOrder: context[PeerMessage.doneOrder] ?? DoneOrder.bottom.rawValue,
            PeerMessage.showStreaks: context[PeerMessage.showStreaks] == "1",
        ])
    }

    /// A first-fill part from `cursor`, as a checked file: a message while the Watch app is open and the part is small,
    /// otherwise a file transfer.
    private func sendFill(from cursor: String) async {
        guard let session else { return }
        try? await repository.peerStart()
        guard let part = try? await repository.peerFillPart(cursor: cursor.isEmpty ? nil : cursor, maxRecords: 5_000) else { return }
        if session.isReachable && part.base64.utf8.count <= PeerMessage.largestMessagePart {
            PeerMessage.deliver([PeerMessage.kind: PeerMessage.fill, PeerMessage.cursor: cursor, PeerMessage.part: part.base64], on: session)
            return
        }
        guard let data = Data(base64Encoded: part.base64) else { return }
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("watch-fill-\(UUID().uuidString).zip")
        guard (try? data.write(to: url, options: .atomic)) != nil else { return }
        session.transferFile(url, metadata: [PeerMessage.kind: "fill", PeerMessage.cursor: cursor])
    }

    /// The iPhone's data was replaced (a restore): the Watch fills again.
    func dataReplaced() {
        if let session { PeerMessage.deliver([PeerMessage.kind: PeerMessage.refill], on: session) }
    }

    // MARK: Receiving

    @MainActor
    private func received(_ info: [String: Any]) async {
        guard let kind = info[PeerMessage.kind] as? String else { return }
        switch kind {
        case PeerMessage.hello:
            try? await repository.peerStart()
            if let session { lastContext = [:]; sendSettings(session) }
            await sendBatch()
        case PeerMessage.fillRequest:
            await sendFill(from: info[PeerMessage.cursor] as? String ?? "")
        case PeerMessage.ops:
            guard let batch = info[PeerMessage.batch] as? String,
                  let seq = try? await repository.acceptPeerBatch(batch: batch) else { return }
            if let session { PeerMessage.deliver([PeerMessage.kind: PeerMessage.ack, PeerMessage.seq: NSNumber(value: seq.int64Value)], on: session) }
            store.reloadAfterSync()
            onReceived?()
        case PeerMessage.ack:
            guard let seq = (info[PeerMessage.seq] as? NSNumber)?.int64Value else { return }
            try? await repository.ackPeer(seq: seq)
            if let sent = inFlight, seq >= sent { inFlight = nil }
            await sendBatch()
        default:
            break
        }
    }

    @MainActor
    private func watchStateChanged(paired: Bool, installed: Bool) async {
        if !paired || !installed { try? await repository.peerStop() }
    }
}

extension PhoneWatchLink: WCSessionDelegate {
    nonisolated func session(_ session: WCSession, activationDidCompleteWith state: WCSessionActivationState, error: Error?) {
        let paired = session.isPaired, installed = session.isWatchAppInstalled
        Task { @MainActor in
            await watchStateChanged(paired: paired, installed: installed)
            if paired && installed { await sendBatch() }
        }
    }

    nonisolated func sessionDidBecomeInactive(_ session: WCSession) {}

    nonisolated func sessionDidDeactivate(_ session: WCSession) {
        // Switching to another Watch: activate again for the new one (Apple's pattern).
        session.activate()
    }

    nonisolated func sessionWatchStateDidChange(_ session: WCSession) {
        let paired = session.isPaired, installed = session.isWatchAppInstalled
        Task { @MainActor in await watchStateChanged(paired: paired, installed: installed) }
    }

    nonisolated func session(_ session: WCSession, didReceiveUserInfo userInfo: [String: Any] = [:]) {
        let info = PeerMessage.Box(userInfo)
        Task { @MainActor in await received(info.value) }
    }

    nonisolated func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        let info = PeerMessage.Box(message)
        Task { @MainActor in await received(info.value) }
    }

    nonisolated func session(_ session: WCSession, didFinish fileTransfer: WCSessionFileTransfer, error: Error?) {
        try? FileManager.default.removeItem(at: fileTransfer.file.fileURL)
    }
}
