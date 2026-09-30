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
