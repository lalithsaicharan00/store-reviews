import Foundation

/// The extension never sends analytics. This disposable, bounded mailbox holds only a consent generation,
/// UTC day and successful paging count. No widget key, selected item, configuration or content enters it.
nonisolated enum WidgetAnalyticsRelay {
    private struct State: Codable { var generation: UUID; var day: Int; var count: Int }
    private static func day(_ now: Date) -> Int { Int(floor(now.timeIntervalSince1970 / 86400)) }
    private static func file(_ directory: URL) -> URL {
        directory.appendingPathComponent("DisposableWidgetAnalytics/relay.json")
    }
    private static func read(_ file: URL) -> State? {
        guard let size = try? file.resourceValues(forKeys: [.fileSizeKey]).fileSize, size <= 4096,
              let data = try? Data(contentsOf: file), let state = try? JSONDecoder().decode(State.self, from: data),
              state.count >= 0, state.count <= 100_000 else { return nil }
        return state
    }
    private static func write(_ state: State, to file: URL, commit: (Data, URL) throws -> Void = {
        try $0.write(to: $1, options: [.atomic, .completeFileProtectionUntilFirstUserAuthentication])
    }) -> Bool {
        do { try commit(JSONEncoder().encode(state), file); return true }
        catch { return false }
    }
    /// App-only consent mirroring. A new opt-in rotates the generation; revocation invalidates pending callbacks.
    static func consent(_ enabled: Bool, directory: URL?, rotate: Bool = false, now: Date = .now) {
        guard let directory else { return }
        let file = file(directory)
        if enabled {
            do {
                try FileManager.default.createDirectory(at: file.deletingLastPathComponent(), withIntermediateDirectories: true)
                var excluded = URLResourceValues(); excluded.isExcludedFromBackup = true
                var folder = file.deletingLastPathComponent(); try folder.setResourceValues(excluded)
            } catch { return } // A telemetry mailbox must not become eligible for device backup.
        }
        let coordinator = NSFileCoordinator()
        var error: NSError?
        coordinator.coordinate(writingItemAt: file, options: .forMerging, error: &error) { target in
            if !enabled { try? FileManager.default.removeItem(at: target) }
            else if rotate || read(target) == nil { _ = write(State(generation: UUID(), day: day(now), count: 0), to: target) }
        }
    }
    static func ticket(directory: URL?) -> UUID? { directory.flatMap { read(file($0))?.generation } }
    /// Run off the widget's critical path, after the page file write succeeded. Stale generations are rejected.
    static func committed(ticket: UUID?, directory: URL?, now: Date = .now) {
        guard let ticket, let directory else { return }
        let file = file(directory), coordinator = NSFileCoordinator()
        var error: NSError?
        coordinator.coordinate(writingItemAt: file, options: .forMerging, error: &error) { target in
            guard var state = read(target), state.generation == ticket else { return }
            if state.day != day(now) { state.day = day(now); state.count = 0 }
            state.count = min(100_000, state.count + 1)
            _ = write(state, to: target)
        }
    }
    /// At-most-once mailbox drain: a crash can lose counts, never create extra logging operations.
    /// Older-day paging counts are deliberately dropped rather than attributed to a later day.
    static func drain(directory: URL?, now: Date = .now, commit: (Data, URL) throws -> Void = {
        try $0.write(to: $1, options: [.atomic, .completeFileProtectionUntilFirstUserAuthentication])
    }) -> Int {
        guard let directory else { return 0 }
        let file = file(directory), coordinator = NSFileCoordinator()
        var error: NSError?, count = 0
        coordinator.coordinate(writingItemAt: file, options: .forMerging, error: &error) { target in
            guard var state = read(target) else { return }
            let pending = state.day == day(now) ? state.count : 0
            state.count = 0; state.day = day(now)
            // Return a count only after its durable removal. A failed clear must not be counted again later.
            if write(state, to: target, commit: commit) { count = pending }
        }
        return count
    }
}
