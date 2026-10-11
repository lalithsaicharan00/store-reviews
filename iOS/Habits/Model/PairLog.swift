import Foundation

/// The paired-simulator check's record (`Tools/ci/watch_pair.sh`): both apps, running at once on a paired iPhone and
/// Watch simulator, write each step to `tmp/pair.txt` in their own container; the script reads both. Debug only.
#if DEBUG
@MainActor
enum PairLog {
    private static let url = FileManager.default.temporaryDirectory.appendingPathComponent("pair.txt")
    private static let started = Date.now

    static func reset() { try? FileManager.default.removeItem(at: url) }

    static func write(_ line: String) {
        let text = String(format: "%7.1f s  ", Date.now.timeIntervalSince(started)) + line + "\n"
        if let handle = try? FileHandle(forWritingTo: url) {
            handle.seekToEndOfFile()
            handle.write(Data(text.utf8))
            try? handle.close()
        } else {
            try? Data(text.utf8).write(to: url)
        }
    }

    /// Waits up to `seconds` for `condition`, checking twice a second; says how long it took, or that it never came.
    static func wait(_ what: String, _ seconds: Double, _ condition: () -> Bool) async -> Bool {
        let start = Date.now
        while Date.now.timeIntervalSince(start) < seconds {
            if condition() {
                write(String(format: "saw %@ after %.1f s", what, Date.now.timeIntervalSince(start)))
                return true
            }
            try? await Task.sleep(for: .milliseconds(500))
        }
        finish(false, "never saw \(what) in \(Int(seconds)) s")
        return false
    }

    static func finish(_ ok: Bool, _ line: String) {
        write(line)
        write(ok ? "# PAIR DONE ok" : "# PAIR DONE failed")
    }
}
#endif
