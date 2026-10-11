import Foundation
import WatchConnectivity

/// The messages the iPhone and its Apple Watch send each other over WatchConnectivity (Architecture 12 §3.1). One
/// file, compiled by both apps, so they always speak the same words. Every message is a property-list dictionary with
/// a `kind`.
nonisolated enum PeerMessage {
    static let kind = "kind"

    /// The Watch says it's there (and whether its first fill has arrived): the iPhone starts its queue for it.
    static let hello = "hello"
    static let filled = "filled"
    /// The Watch asks for the first fill from `cursor` ("" for the start); the iPhone answers with a file whose metadata
    /// carries the same `cursor`.
    static let fillRequest = "fill-request"
    static let cursor = "cursor"
    /// A batch of changes: `batch` is `{"seq": N, "ops": [...]}` from `HabitRepository.peerBatch`.
    static let ops = "ops"
    static let batch = "batch"
    /// "Saved everything up to `seq`": those changes leave the sender's queue.
    static let ack = "ack"
    static let seq = "seq"
    /// The iPhone's data was replaced (a restore): the Watch fills again, merging.
    static let refill = "refill"
    /// A first-fill part sent as a message while the Watch app is open (`part`: the checked file in base64), instead of
    /// a file transfer: the same part, the same check.
    static let fill = "fill"
    static let part = "part"
    /// The biggest part sent as a message; bigger ones go by `transferFile`.
    static let largestMessagePart = 48 * 1024

    // The application context: the iPhone's settings the Watch follows (Design Notes, "follows the iPhone by itself").
    static let hideNames = "hideNames"
    static let doneOrder = "doneOrder"
    static let showStreaks = "showStreaks"

    /// The highest sequence number in a batch.
    static func seq(of batch: String) -> Int64? {
        guard let data = batch.data(using: .utf8),
              let object = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return nil }
        return (object["seq"] as? NSNumber)?.int64Value
    }

    /// Sends a message the quickest way: at once while the other app is reachable (both running), otherwise queued by
    /// the system (`transferUserInfo`: delivered in the background, kept across restarts). If the quick way fails, the
    /// message is queued as well. Arriving twice is harmless: a batch is merged by its changes' own stamps and
    /// acknowledged by sequence number, and the rest are requests that are answered again.
    static func deliver(_ message: [String: Any], on session: WCSession) {
        guard session.isReachable else { session.transferUserInfo(message); return }
        let box = Box(message)
        session.sendMessage(message, replyHandler: nil) { _ in WCSession.default.transferUserInfo(box.value) }
    }

    /// A received dictionary carried onto the main actor (property-list values only, so it's safe to pass).
    struct Box: @unchecked Sendable {
        let value: [String: Any]
        init(_ value: [String: Any]) { self.value = value }
    }
}
