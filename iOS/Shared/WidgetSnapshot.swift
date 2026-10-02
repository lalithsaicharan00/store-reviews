import Foundation

/// Disposable display data only. SQLite and private notes never leave the app container.
nonisolated struct WidgetItem: Codable, Identifiable, Sendable {
    var id: String
    var name: String
    var symbol: String
    var color = "blue"
    var status: String
    var value: Double
    var goal: Double
    var done: Bool
    var planned: Bool
    var ongoing: Bool
    var isTask: Bool
    var isQuit = false
    var action: String?
    var stepLabel: String? = nil
    var unit: String? = nil
    var token: String
    var signature: String
    var counterStart: Date?
    var counterValidUntil: Date? = nil
    var history: [WidgetDay]
    var displayedValue: String { value.formatted(.number.precision(.fractionLength(0...2))) }
    var compactProgress: String {
        let number = FloatingPointFormatStyle<Double>.number.precision(.fractionLength(0...2))
        return "\(value.formatted(number))/\(goal.formatted(number))\(ongoing ? " limit" : "")\(unit.map { " " + $0 } ?? "")"
    }
    var url: URL { URL(string: "oftenenough://item/" + id) ?? URL(string: "oftenenough://today")! }
}
nonisolated struct WidgetDay: Codable, Identifiable, Sendable {
    var id: String
    var label: String
    var state: String
    var value: String
}
nonisolated struct WidgetFrame: Codable, Sendable {
    var day: String
    var start: Date
    var end: Date
    var items: [WidgetItem]
    var remaining: Int { items.filter { $0.planned && !$0.done && !$0.ongoing }.count }
    func agenda(completed: Bool) -> [WidgetItem] {
        items.filter { $0.planned && (completed || !$0.done || $0.ongoing) }
    }
}
nonisolated struct WidgetSnapshot: Codable, Sendable {
    static let version = 1
    var version = Self.version
    var generated: Date
    var timeZone: String
    var locale: String
    var plus: Bool
    var hidden: Bool
    var frames: [WidgetFrame]
    func frame(at now: Date, timeZone: String = TimeZone.current.identifier, locale: String = Locale.current.identifier) -> WidgetFrame? {
        guard version == Self.version, self.timeZone == timeZone, self.locale == locale, !hidden else { return nil }
        return frames.first { $0.start <= now && now < $0.end }
    }
}

nonisolated enum WidgetDisk {
    static let group = "group.com.oftenenough.app"
    static let privacyKey = "widgets.hideContent"
    static let maximumBytes = 16 * 1024 * 1024
    static var directory: URL? { FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: group) }
    static var url: URL? { directory?.appendingPathComponent("widget-snapshot-v1.json") }

    #if DEBUG
    // No names or identifiers: retained only to diagnose actual system-host intent dispatch in CI.
    static var diagnosticURL: URL? { directory?.appendingPathComponent("widget-intent-diagnostic.txt") }
    static func diagnose(_ stage: String) {
        guard let file = diagnosticURL else { return }
        try? Data(stage.utf8).write(to: file, options: .atomic)
    }
    static var diagnostic: String { diagnosticURL.flatMap { try? String(contentsOf: $0, encoding: .utf8) } ?? "intent not dispatched" }
    #endif

    static func decode(_ data: Data) -> WidgetSnapshot? {
        guard data.count <= maximumBytes, let snapshot = try? JSONDecoder().decode(WidgetSnapshot.self, from: data),
              snapshot.version == WidgetSnapshot.version, snapshot.frames.count <= 8,
              snapshot.frames.allSatisfy({ frame in
                  frame.start < frame.end && Set(frame.items.map(\.id)).count == frame.items.count
                      && frame.items.allSatisfy { item in
                          UUID(uuidString: item.id) != nil && item.value.isFinite && item.goal.isFinite
                              && (item.action == nil || (["check", "add"].contains(item.action!) && UUID(uuidString: item.token) != nil))
                      }
              }),
              zip(snapshot.frames, snapshot.frames.dropFirst()).allSatisfy({ $0.end == $1.start }) else { return nil }
        return snapshot
    }
    static func read(from file: URL? = url) -> WidgetSnapshot? {
        guard let file, let size = try? file.resourceValues(forKeys: [.fileSizeKey]).fileSize,
              size <= maximumBytes, let data = try? Data(contentsOf: file) else { return nil }
        return decode(data)
    }
    static func write(_ snapshot: WidgetSnapshot, to file: URL? = url) throws {
        guard let file else { throw CocoaError(.fileNoSuchFile) }
        let data = try JSONEncoder().encode(snapshot)
        guard data.count <= maximumBytes else { throw CocoaError(.fileWriteOutOfSpace) }
        try FileManager.default.createDirectory(at: file.deletingLastPathComponent(), withIntermediateDirectories: true)
        try data.write(to: file, options: [.atomic, .completeFileProtectionUntilFirstUserAuthentication])
    }
    /// Coordinated read-modify-write: paging is display state, never a log or database lock.
    static func page(key: String, delta: Int = 0, set: Int? = nil, onCommitted: (() -> Void)? = nil) -> Int {
        guard let directory else { return 0 }
        let file = directory.appendingPathComponent("widget-pages.json")
        let coordinator = NSFileCoordinator()
        var error: NSError?
        var result = 0
        coordinator.coordinate(writingItemAt: file, options: .forMerging, error: &error) { file in
            let size = (try? file.resourceValues(forKeys: [.fileSizeKey]).fileSize) ?? 0
            var pages = size <= 64 * 1024 ? (try? Data(contentsOf: file)).flatMap { try? JSONDecoder().decode([String: Int].self, from: $0) } ?? [:] : [:]
            let stored = max(0, min(100_000, pages[key] ?? 0))
            let shift = max(-100_000, min(100_000, delta))
            result = max(0, min(100_000, set ?? (stored + shift)))
            if delta != 0 || set != nil {
                pages[key] = result
                if let data = try? JSONEncoder().encode(pages) {
                    do { try data.write(to: file, options: .atomic); onCommitted?() } catch {}
                }
            }
        }
        return result
    }
}
