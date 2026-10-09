import Core
import Foundation

#if DEBUG
/// Debug builds only (Current Work 67): proves that what's on this phone is on the server. Launched with
/// `-sync-verify`, the app syncs, downloads the account's own export (`GET /v1/account/export`) and compares every log
/// and habit with this phone's, then writes the result to `Documents/sync-verify.txt` (read it with `devicectl`).
/// IDs and counts only: no names or values leave the phone's log.
enum SyncCheck {
    private static let iso = ISO8601DateFormatter()

    /// `-delete-listed-habits`: deletes exactly the habits whose IDs are listed in `Documents/delete-habits.txt` (one per
    /// line, put there with `devicectl … copy to`), taking back their logs first, so both go from the account through
    /// sync. For cleaning up test or demo habits by ID only, never by name (8 Oct 2026: demo habits share real names).
    static func deleteListedIfAsked(store: HabitStore) async {
        guard ProcessInfo.processInfo.arguments.contains("-delete-listed-habits"),
              let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("delete-habits.txt"),
              let text = try? String(contentsOf: url, encoding: .utf8) else { return }
        let ids = Set(text.split(whereSeparator: \.isNewline).compactMap { UUID(uuidString: String($0).trimmingCharacters(in: .whitespaces)) })
        let habits = store.habits.filter { ids.contains($0.id) }
        let logs = store.entries.filter { ids.contains($0.habitID) }
        for entry in logs { store.undoEntry(entry.id) }
        store.delete(habits)
        await store.flush()
        try? FileManager.default.removeItem(at: url)
        write(["deleted \(habits.count) listed habit(s) and \(logs.count) log(s); \(ids.count) IDs listed"])
    }

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
        // `-sync-export`: the account's whole export, saved as it came, for a field-by-field comparison on the Mac.
        if ProcessInfo.processInfo.arguments.contains("-sync-export"),
           let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("account-export.json") {
            try? data.write(to: url, options: .atomic)
            lines.append("export saved: \(data.count) bytes, \(records.count) records")
        }
        func live(_ table: String) -> [String: [String: Any]] {
            var rows: [String: [String: Any]] = [:]
            for r in records where r["table"] as? String == table {
                guard let row = r["row"] as? String, let fields = r["fields"] as? [String: Any] else { continue }
                if fields["deleted_at"] is NSNull || fields["deleted_at"] == nil { rows[row.lowercased()] = fields }
            }
            return rows
        }
        // A deleted habit's logs stay stored on both sides (D6) but aren't shown, so only live habits' logs are compared.
        let serverHabitIDs = Set(live("habit").keys)
        let serverEntries = live("entry").filter { ($0.value["habit_id"] as? String).map { serverHabitIDs.contains($0.lowercased()) } ?? false }
        let phoneEntries = Dictionary(store.entries.map { ($0.id.uuidString.lowercased(), $0) }, uniquingKeysWith: { a, _ in a })
        let missing = phoneEntries.keys.filter { serverEntries[$0] == nil }
        let extra = serverEntries.keys.filter { phoneEntries[$0] == nil }
        let differ = phoneEntries.filter { id, entry in
            guard let fields = serverEntries[id] else { return false }
            let value = (fields["value"] as? NSNumber)?.doubleValue ?? .nan
            return abs(value - entry.value) > 0.000_001 || fields["day"] as? String != entry.day.key
        }.map(\.key)
        let serverHabits = serverHabitIDs
        let phoneHabits = Set(store.habits.map { $0.id.uuidString.lowercased() })
        lines.append("logs: phone \(phoneEntries.count), server \(serverEntries.count); missing on server \(missing.count), "
            + "only on server \(extra.count), different \(differ.count)")
        lines.append("habits: phone \(phoneHabits.count), server \(serverHabits.count); missing on server "
            + "\(phoneHabits.subtracting(serverHabits).count), only on server \(serverHabits.subtracting(phoneHabits).count)")
        let recent = store.entries.filter { $0.createdAt > Date.now.addingTimeInterval(-3600) }
        let bySource = Dictionary(grouping: recent, by: { $0.source?.rawValue ?? "unknown" }).mapValues(\.count)
        lines.append("logs made in the last hour: \(recent.count) \(bySource.sorted { $0.key < $1.key })")
        for entry in recent.sorted(by: { $0.createdAt < $1.createdAt }).suffix(12) {
            lines.append("  \(iso.string(from: entry.createdAt)) \(entry.source?.rawValue ?? "?") day \(entry.day.key)")
        }
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
