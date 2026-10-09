import Foundation

/// A test launch never touches the person's settings (Rulebook D8; Current Work 74, 8 Oct 2026). A `-uitest` launch on a
/// real iPhone shares the app's `UserDefaults` with the person, and resets some of them so each test starts the same
/// (T8: Hide Completed, done order, Progress's options …), so a UI test run on the phone used to leave the person's
/// Today with their own choices undone. Now the first test launch holds the person's settings aside, exactly as they
/// were, in a file of their own; test launches then change only their own; the next ordinary launch puts the person's
/// back, exactly as they were, before anything reads them. Widget files are kept apart the same way (`WidgetDisk`).
enum TestLaunchIsolation {
    /// A UI test's launch, on its own in-memory database (`-uitest`). `-dbname` launches are system tests that must look
    /// like the person's app to the widgets (WidgetSystemUITests), so they stay outside this.
    static let isTestLaunch = ProcessInfo.processInfo.arguments.contains("-uitest")

    /// The person's settings while test launches run.
    static var heldFile: URL? {
        FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first?
            .appendingPathComponent("person-settings-held-for-tests.plist")
    }

    /// First thing at launch, before any setting is read.
    static func begin() {
        guard let domainName = Bundle.main.bundleIdentifier, let file = heldFile else { return }
        let defaults = UserDefaults.standard
        let fm = FileManager.default
        if isTestLaunch {
            // Only the first test launch in a row holds them: a later one would hold the tests' own.
            guard !fm.fileExists(atPath: file.path) else { return }
            let domain = defaults.persistentDomain(forName: domainName) ?? [:]
            guard let data = try? PropertyListSerialization.data(fromPropertyList: domain, format: .binary, options: 0) else { return }
            try? fm.createDirectory(at: file.deletingLastPathComponent(), withIntermediateDirectories: true)
            try? data.write(to: file, options: [.atomic, .completeFileProtectionUntilFirstUserAuthentication])
        } else if fm.fileExists(atPath: file.path) {
            // A held copy that can't be read stays where it is, never replaced by the tests' settings.
            guard let data = try? Data(contentsOf: file),
                  let domain = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] else { return }
            defaults.setPersistentDomain(domain, forName: domainName)
            try? fm.removeItem(at: file)
        }
    }

    #if DEBUG
    /// `-testlaunch-report` (TestLaunchIsolationUITests): what an ordinary launch found, read before it publishes
    /// anything: the person's widget snapshot (its habits' IDs, which a test launch's demo habits never share) and two
    /// of the settings test launches reset.
    static var report = ""
    static func makeReport() {
        let snapshot = WidgetDisk.read()
        let ids = (snapshot?.frames.first?.items.map(\.id) ?? []).sorted()
        var hash: UInt64 = 1469598103934665603
        for byte in ids.joined(separator: ",").utf8 { hash = (hash ^ UInt64(byte)) &* 1099511628211 }
        let hide = UserDefaults.standard.bool(forKey: Preferences.hideDoneHabits)
        let order = UserDefaults.standard.string(forKey: Preferences.doneOrder) ?? "default"
        report = "widgets \(ids.count) \(String(hash, radix: 16)); hide \(hide); order \(order)"
    }
    #endif
}
