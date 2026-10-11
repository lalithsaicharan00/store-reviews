#if DEBUG
import Foundation

/// Speed tests only (launched with `-perf-meter`, 30 Sep 2026): records every stretch of 17 ms or more that the main
/// thread worked without a break, from waking up to going back to sleep. Each one is at least one dropped frame; one
/// of 100 ms or more is a freeze a person feels. Lines of "<start, seconds since 1970> <milliseconds>" go to
/// `tmp/perf-stalls.txt` in the app's container, and `Tools/perf/measure_perf.sh` reads them for each test's window.
///
/// Measured inside the app because `sample` can't tell the app's work from the UI test's own screen reading (which
/// also runs on the app's main thread): one tap test read as "−37 % busy".
final class MainThreadMeter {
    private static var shared: MainThreadMeter?
    private var awake: CFAbsoluteTime?
    private let file: FileHandle?
    private var observers: [CFRunLoopObserver] = []

    static func startIfAsked() {
        guard shared == nil, ProcessInfo.processInfo.arguments.contains("-perf-meter") else { return }
        shared = MainThreadMeter()
    }

    private init() {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("perf-stalls.txt")
        // A speed run starts its own record: on an iPhone the script can't delete the last run's (2 Oct 2026).
        if ProcessInfo.processInfo.arguments.contains("-perf-drive") { try? FileManager.default.removeItem(at: url) }
        if !FileManager.default.fileExists(atPath: url.path) { FileManager.default.createFile(atPath: url.path, contents: nil) }
        file = try? FileHandle(forWritingTo: url)
        _ = try? file?.seekToEnd()
        // First on waking; last before sleeping, after SwiftUI and Core Animation have drawn.
        let wake = CFRunLoopObserverCreateWithHandler(nil, CFRunLoopActivity.afterWaiting.rawValue, true, CFIndex.min) { [weak self] _, _ in
            self?.awake = CFAbsoluteTimeGetCurrent()
        }
        let sleep = CFRunLoopObserverCreateWithHandler(nil, CFRunLoopActivity.beforeWaiting.rawValue, true, CFIndex.max) { [weak self] _, _ in
            self?.wentToSleep()
        }
        for observer in [wake, sleep].compactMap({ $0 }) {
            CFRunLoopAddObserver(CFRunLoopGetMain(), observer, .commonModes)
            observers.append(observer)
        }
    }

    /// A line for the speed-run script (a window's or opening's times), in the same record.
    static func mark(_ line: String) {
        try? shared?.file?.write(contentsOf: Data((line + "\n").utf8))
    }

    /// Times a piece of work during a speed run ("# TIME name|ms"); the script lists count, total and longest per name,
    /// so one run says which part of a slow moment costs what, without a profiler (PERFORMANCE-LESSONS, 2 Oct).
    /// Off speed runs it only runs `work`.
    @discardableResult
    static func time<T>(_ name: @autoclosure () -> String, _ work: () throws -> T) rethrows -> T {
        guard shared != nil else { return try work() }
        let start = CFAbsoluteTimeGetCurrent()
        defer { mark(String(format: "# TIME %@|%.2f", name(), (CFAbsoluteTimeGetCurrent() - start) * 1000)) }
        return try work()
    }

    private func wentToSleep() {
        guard let start = awake else { return }
        awake = nil
        let ms = (CFAbsoluteTimeGetCurrent() - start) * 1000
        guard ms >= 17 else { return }
        let line = String(format: "%.3f %.1f\n", start + kCFAbsoluteTimeIntervalSince1970, ms)
        try? file?.write(contentsOf: Data(line.utf8))
    }
}
#endif

/// Records how long something took since `start` (awaited work `perfTimed` can't wrap), in speed runs only.
func perfNote(_ name: @autoclosure () -> String, since start: CFAbsoluteTime) {
    #if DEBUG
    MainThreadMeter.mark(String(format: "# TIME %@|%.2f", name(), (CFAbsoluteTimeGetCurrent() - start) * 1000))
    #endif
}

/// Times `work` in speed runs (`MainThreadMeter.time`); in release builds it only runs `work`.
@inline(__always)
func perfTimed<T>(_ name: @autoclosure () -> String, _ work: () throws -> T) rethrows -> T {
    #if DEBUG
    return try MainThreadMeter.time(name(), work)
    #else
    return try work()
    #endif
}
