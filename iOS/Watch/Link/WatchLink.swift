import Core
import Foundation
import WatchConnectivity
import WatchKit

/// The Watch's side of the link with its iPhone (Architecture 12 §3.1), over WatchConnectivity.
///
/// - **First fill:** until the iPhone's whole copy has arrived, the Watch asks for it a part at a time (`peerFillPart`
///   on the iPhone, checked and merged here by `acceptPeerFill`); Today says "Getting your habits…" until then (WA2).
/// - **Changes both ways:** each side's `peer_out` goes over in batches by `transferUserInfo` (queued by the system,
///   delivered in the background, kept across restarts), 0.5 s after the last change (S16). The receiver merges a batch
///   in one transaction and acknowledges its highest sequence number; only then does it leave the sender's queue, so a
///   lost acknowledgement means a resend that merges as nothing (WA3, WA4).
/// - **Settings that follow the iPhone** (Hide Names, Done Habits, Show Streaks) arrive in the application context.
///
/// Every message is a dictionary with a `kind`; both apps' `WatchLink` speak the same ones (`PeerMessage`).
final class WatchLink: NSObject {
    weak var model: WatchModel?
    private let repository: HabitRepository?
    private let enabled: Bool
    private var sendTask: Task<Void, Never>?
    /// The highest sequence number sent and not yet acknowledged: no second batch while one is on its way.
    private var inFlight: Int64?
    private var inFlightSince: Date?
    private var heldTasks: [WKWatchConnectivityRefreshBackgroundTask] = []
    private var fillAsked: Date?

    init(repository: HabitRepository?, testLaunch: Bool) {
        self.repository = repository
        enabled = !testLaunch && repository != nil && WCSession.isSupported()
        super.init()
    }

    func activate() {
        guard enabled else { return }
        WCSession.default.delegate = self
        WCSession.default.activate()
    }

    private var session: WCSession? {
        guard enabled, WCSession.default.activationState == .activated else { return nil }
        return WCSession.default
    }

    // MARK: Sending

    /// After a change: one batch 0.5 s after the last of a run of taps (S16).
    func scheduleSend() {
        guard enabled else { return }
        sendTask?.cancel()
        sendTask = Task { @MainActor [weak self] in
            try? await Task.sleep(for: .milliseconds(500))
            guard !Task.isCancelled else { return }
            await self?.sendBatch()
        }
    }

    /// Leaving the app: send what's waiting now.
    func sendNow() {
        guard enabled else { return }
        sendTask?.cancel()
        Task { @MainActor in await sendBatch() }
    }

    private func sendBatch() async {
        guard let session, let repository else { return }
        // A batch already on its way: wait for its acknowledgement, unless it's been a long time (then send again; the
        // iPhone merges a repeat as nothing).
        if inFlight != nil, let since = inFlightSince, Date.now.timeIntervalSince(since) < 120 { return }
        guard let batch = try? await repository.peerBatch(maxOps: 100),
              let seq = PeerMessage.seq(of: batch) else { inFlight = nil; return }
        inFlight = seq
        inFlightSince = .now
        PeerMessage.deliver([PeerMessage.kind: PeerMessage.ops, PeerMessage.batch: batch], on: session)
    }

    /// Hello: the iPhone starts its queue for this Watch and sends its settings; and asks for the first fill if needed.
    private func hello() async {
        guard let session, let repository else { return }
        let status = try? await repository.peerStatus()
        PeerMessage.deliver([PeerMessage.kind: PeerMessage.hello, PeerMessage.filled: status?.filled ?? false], on: session)
        if status?.filled != true { askForFill(from: status?.fillCursor) }
        await sendBatch()
    }

    private func askForFill(from cursor: String?) {
        guard let session else { return }
        // Asked once a minute at most while waiting; the iPhone answers with a file.
        if let asked = fillAsked, Date.now.timeIntervalSince(asked) < 60 { return }
        fillAsked = .now
        PeerMessage.deliver([PeerMessage.kind: PeerMessage.fillRequest, PeerMessage.cursor: cursor ?? ""], on: session)
    }

    // MARK: Receiving

    @MainActor
    private func received(_ info: [String: Any]) async {
        guard let repository, let kind = info[PeerMessage.kind] as? String else { return }
        await model?.ensureLoaded()
        switch kind {
        case PeerMessage.ops:
            guard let batch = info[PeerMessage.batch] as? String,
                  let seq = try? await repository.acceptPeerBatch(batch: batch) else { return }
            if let session { PeerMessage.deliver([PeerMessage.kind: PeerMessage.ack, PeerMessage.seq: NSNumber(value: seq.int64Value)], on: session) }
            model?.receivedFromPhone()
        case PeerMessage.fill:
            // A first-fill part sent as a message (the app was open): the same check as a file.
            guard let part = info[PeerMessage.part] as? String else { return }
            await receivedFill(base64: part, cursor: info[PeerMessage.cursor] as? String)
            return
        case PeerMessage.ack:
            guard let seq = (info[PeerMessage.seq] as? NSNumber)?.int64Value else { return }
            try? await repository.ackPeer(seq: seq)
            if let sent = inFlight, seq >= sent { inFlight = nil }
            await sendBatch()
        case PeerMessage.refill:
            // The iPhone's data was replaced (a restore): fill again; what's here stays and merges.
            try? await repository.peerRefill()
            fillAsked = nil
            await model?.refreshPeerStatus()
            askForFill(from: nil)
        default:
            break
        }
        completeHeldTasks()
    }

    @MainActor
    private func receivedFill(at url: URL, cursor: String?) async {
        guard let data = try? Data(contentsOf: url) else { fillAsked = nil; askForFill(from: cursor); return }
        await receivedFill(base64: data.base64EncodedString(), cursor: cursor)
    }

    @MainActor
    private func receivedFill(base64: String, cursor: String?) async {
        guard let repository else { return }
        await model?.ensureLoaded()
        do {
            let receipt = try await repository.acceptPeerFill(base64: base64)
            fillAsked = nil
            model?.receivedFromPhone()
            if let next = receipt.next { askForFill(from: next) }
        } catch {
            // A damaged part is refused before anything changes: ask for the same part again.
            fillAsked = nil
            askForFill(from: cursor)
        }
        completeHeldTasks()
    }

    @MainActor
    private func applySettings(_ context: [String: Any]) {
        let defaults = UserDefaults.standard
        if let hide = context[PeerMessage.hideNames] as? Bool { defaults.set(hide, forKey: HideNames.key) }
        if let order = context[PeerMessage.doneOrder] as? String { defaults.set(order, forKey: Preferences.doneOrder) }
        if let streaks = context[PeerMessage.showStreaks] as? Bool { defaults.set(streaks, forKey: ProgressOptions.showStreaks) }
        Task { await model?.widgets.publish(WatchModel.shared.store) }
    }

    // MARK: Background

    /// A batch woke the app in the background: keep it until everything waiting has arrived and been merged.
    func hold(_ task: WKWatchConnectivityRefreshBackgroundTask) {
        heldTasks.append(task)
        if !enabled { completeHeldTasks() }
        activate()
        Task { @MainActor [weak self] in
            try? await Task.sleep(for: .seconds(20))
            self?.completeHeldTasks(force: true)
        }
    }

    private func completeHeldTasks(force: Bool = false) {
        guard force || !WCSession.default.hasContentPending else { return }
        let tasks = heldTasks
        heldTasks = []
        tasks.forEach { $0.setTaskCompletedWithSnapshot(false) }
    }
}

extension WatchLink: WCSessionDelegate {
    nonisolated func session(_ session: WCSession, activationDidCompleteWith state: WCSessionActivationState, error: Error?) {
        let context = PeerMessage.Box(session.receivedApplicationContext)
        Task { @MainActor in
            applySettings(context.value)
            await hello()
        }
    }

    nonisolated func session(_ session: WCSession, didReceiveUserInfo userInfo: [String: Any] = [:]) {
        let info = PeerMessage.Box(userInfo)
        Task { @MainActor in await received(info.value) }
    }

    nonisolated func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        let info = PeerMessage.Box(message)
        Task { @MainActor in await received(info.value) }
    }

    nonisolated func session(_ session: WCSession, didReceive file: WCSessionFile) {
        // The file is deleted when this returns: copy it first.
        let copy = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try? FileManager.default.copyItem(at: file.fileURL, to: copy)
        let cursor = file.metadata?[PeerMessage.cursor] as? String
        Task { @MainActor in
            await receivedFill(at: copy, cursor: cursor)
            try? FileManager.default.removeItem(at: copy)
        }
    }

    nonisolated func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {
        let context = PeerMessage.Box(applicationContext)
        Task { @MainActor in applySettings(context.value) }
    }

    nonisolated func sessionReachabilityDidChange(_ session: WCSession) {
        guard session.isReachable else { return }
        Task { @MainActor in await hello() }
    }
}
