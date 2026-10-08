import Core
import Foundation

#if DEBUG
/// Debug builds only (Current Work 67): proves that what's on this phone is on the server. Launched with
/// `-sync-verify`, the app syncs, downloads the account's own export (`GET /v1/account/export`) and compares every log
/// and habit with this phone's, then writes the result to `Documents/sync-verify.txt` (read it with `devicectl`).
/// IDs and counts only: no names or values leave the phone's log.
enum SyncCheck {
    private static let iso = ISO8601DateFormatter()

    static func runIfAsked(store: HabitStore, sync: SyncService?) {
        guard ProcessInfo.processInfo.arguments.contains("-sync-verify") else { return }
        Task { @MainActor in await run(store: store, sync: sync) }
    }

    @MainActor
    static func run(store: HabitStore, sync: SyncService?) async {
        var lines = ["checked \(iso.string(from: .now))"]
        defer { write(lines) }
        guard let sync, sync.isPlus else { lines.append("result: NOT PLUS (nothing syncs)"); return }
        await store.flush()
        await sync.syncNow()
        if let status = await sync.status() {
            lines.append("waiting: \(status.waiting), kept aside: \(status.keptAside), last synced: "
                + (status.lastSyncedAt.map { iso.string(from: Date(timeIntervalSince1970: Double($0.int64Value) / 1000)) } ?? "never"))
        }
        guard let (status, data) = try? await sync.request("GET", "/v1/account/export"), status == 200,
              let json = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any],
              let records = json["records"] as? [[String: Any]] else {
            lines.append("result: EXPORT FAILED"); return
        }
        func live(_ table: String) -> [String: [String: Any]] {
            var rows: [String: [String: Any]] = [:]
            for r in records where r["table"] as? String == table {
                guard let row = r["row"] as? String, let fields = r["fields"] as? [String: Any] else { continue }
                if fields["deleted_at"] is NSNull || fields["deleted_at"] == nil { rows[row.lowercased()] = fields }
            }
            return rows
        }
        let serverEntries = live("entry")
        let phoneEntries = Dictionary(store.entries.map { ($0.id.uuidString.lowercased(), $0) }, uniquingKeysWith: { a, _ in a })
        let missing = phoneEntries.keys.filter { serverEntries[$0] == nil }
        let extra = serverEntries.keys.filter { phoneEntries[$0] == nil }
        let differ = phoneEntries.filter { id, entry in
            guard let fields = serverEntries[id] else { return false }
            let value = (fields["value"] as? NSNumber)?.doubleValue ?? .nan
            return abs(value - entry.value) > 0.000_001 || fields["day"] as? String != entry.day.key
        }.map(\.key)
        let serverHabits = Set(live("habit").keys)
        let phoneHabits = Set(store.habits.map { $0.id.uuidString.lowercased() })
        lines.append("logs: phone \(phoneEntries.count), server \(serverEntries.count); missing on server \(missing.count), "
            + "only on server \(extra.count), different \(differ.count)")
        lines.append("habits: phone \(phoneHabits.count), server \(serverHabits.count); missing on server "
            + "\(phoneHabits.subtracting(serverHabits).count), only on server \(serverHabits.subtracting(phoneHabits).count)")
        for id in missing.prefix(10) { lines.append("  missing on server: \(id)") }
        for id in extra.prefix(10) { lines.append("  only on server: \(id)") }
        for id in differ.prefix(10) { lines.append("  different: \(id)") }
        let match = missing.isEmpty && extra.isEmpty && differ.isEmpty && phoneHabits == serverHabits
        lines.append("result: " + (match ? "MATCH" : "MISMATCH"))
    }

    private static func write(_ lines: [String]) {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
            .appendingPathComponent("sync-verify.txt") else { return }
        try? Data((lines.joined(separator: "\n") + "\n").utf8).write(to: url, options: .atomic)
    }
}
#endif
