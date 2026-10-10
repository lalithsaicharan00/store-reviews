import Foundation

/// Asks iCloud itself which backup files the app's iCloud folder holds (10 Oct 2026; Rulebook D4). On a fresh install
/// (a reinstall, a new iPhone, an iPad on the same Apple Account) the folder on the iPhone starts empty and fills in as
/// iCloud brings its list down, so looking at the folder alone could say "No backup found" while one was on its way.
/// `NSMetadataQuery`, Apple's way to find files in iCloud, makes iCloud fetch that list, says when its first look is
/// finished, and knows the files that aren't on this iPhone yet (each is asked for here).
enum ICloudLookup {
    struct Result: Equatable, Sendable {
        /// iCloud's first look is finished (false: it's still fetching the list, so nothing found isn't an answer yet).
        var finished: Bool
        /// Indexes and older-layout copies iCloud knows of that aren't on this iPhone yet.
        var notHere: Int
    }

    /// One look at `Backups/`, waiting at most `timeout` for iCloud's first look to finish.
    static func look(timeout: Duration = .seconds(8)) async -> Result {
        let query = NSMetadataQuery()
        query.searchScopes = [NSMetadataQueryUbiquitousDataScope]
        query.predicate = NSPredicate(format: "%K LIKE %@", NSMetadataItemFSNameKey, "*")
        // On the main thread, whose run loop the query reports through.
        guard query.start() else { return Result(finished: true, notHere: 0) }
        defer { query.stop() }
        let clock = ContinuousClock()
        let until = clock.now.advanced(by: timeout)
        while query.isGathering && clock.now < until && !Task.isCancelled {
            try? await Task.sleep(for: .milliseconds(250))
        }
        query.disableUpdates()
        var result = Result(finished: !query.isGathering, notHere: 0)
        for case let item as NSMetadataItem in query.results {
            guard let url = item.value(forAttribute: NSMetadataItemURLKey) as? URL else { continue }
            let parent = url.deletingLastPathComponent()
            // A device's index (`Backups/<device>/index.json`), or a copy in the older layout (`Backups/<device>.zip`).
            let wanted = (url.lastPathComponent == "index.json" && parent.deletingLastPathComponent().lastPathComponent == "Backups")
                || (url.pathExtension == "zip" && parent.lastPathComponent == "Backups")
            guard wanted else { continue }
            let status = item.value(forAttribute: NSMetadataUbiquitousItemDownloadingStatusKey) as? String
            if status == NSMetadataUbiquitousItemDownloadingStatusNotDownloaded {
                try? FileManager.default.startDownloadingUbiquitousItem(at: url)
                result.notHere += 1
            }
        }
        query.enableUpdates()
        return result
    }
}
