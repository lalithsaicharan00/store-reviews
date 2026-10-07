import Foundation

#if DEBUG
/// Debug builds only: how long each step of a widget tap and a widget redraw takes on the iPhone (Current Work 65).
/// Each line: wall time, which process, milliseconds since that process started, the step. The extension can write
/// only to the shared group; the app copies those lines into its own Documents (readable with `devicectl`) whenever it
/// writes one of its own. No names or identifiers are logged.
/// Read it: `xcrun devicectl device copy from --domain-type appDataContainer --domain-identifier com.oftenenough.app
/// --source Documents/widget-timing.log …` after opening the app once (that copies the widget's lines across).
nonisolated enum WidgetTiming {
    private static let lock = NSLock()
    /// When this process was started by the system (a cold launch for a widget tap starts here).
    static let processStart: Date = {
        var info = kinfo_proc()
        var size = MemoryLayout<kinfo_proc>.stride
        var mib: [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
        guard sysctl(&mib, 4, &info, &size, nil, 0) == 0 else { return .now }
        let start = info.kp_proc.p_starttime
        return Date(timeIntervalSince1970: Double(start.tv_sec) + Double(start.tv_usec) / 1_000_000)
    }()
    private static var groupLog: URL? { WidgetDisk.directory?.appendingPathComponent("widget-timing.log") }
    private static var appLog: URL? {
        Bundle.main.bundleURL.pathExtension == "appex" ? nil
            : FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("widget-timing.log")
    }

    /// Off unless the app was launched with `-widget-timing on` (`-widget-timing off` turns it off again), so the
    /// person's own Debug build never writes this log.
    static let enabled = UserDefaults(suiteName: WidgetDisk.group)?.bool(forKey: "debug.widgetTiming") == true

    static func mark(_ stage: String) {
        guard enabled else { return }
        let now = Date.now
        let process = Bundle.main.bundleURL.pathExtension == "appex" ? "widget" : "app"
        let line = String(format: "%@ %@ +%.0f ms %@\n", ISO8601DateFormatter.string(from: now, timeZone: .current,
                          formatOptions: [.withFullTime, .withFractionalSeconds]), process,
                          now.timeIntervalSince(processStart) * 1000, stage)
        lock.lock(); defer { lock.unlock() }
        if let appLog {
            var text = ""
            if let groupLog, let pending = try? String(contentsOf: groupLog, encoding: .utf8), !pending.isEmpty {
                text += pending
                try? Data().write(to: groupLog)
            }
            append(text + line, to: appLog)
        } else if let groupLog {
            append(line, to: groupLog)
        }
    }

    private static func append(_ text: String, to file: URL) {
        let data = Data(text.utf8)
        if let handle = try? FileHandle(forWritingTo: file) {
            defer { try? handle.close() }
            _ = try? handle.seekToEnd()
            try? handle.write(contentsOf: data)
        } else {
            try? data.write(to: file)
        }
    }
}
#endif
