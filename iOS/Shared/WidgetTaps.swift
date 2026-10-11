import Foundation

// LOCKED (widget taps, 8 Oct 2026): the waiting-taps file and the card swap on tap (W3, W4, W5). Read iOS/Docs/Widgets — Taps and Updates (Locked).md before changing; what it does needs the user's say-so to change, speed work that keeps it doesn't (§8).

// A widget tap (Current Work 66, the user, 8 Oct 2026): "visually things should look instant; in the background the app
// can do its work, but the data is never lost." Two halves:
//
// 1. In the widget's own process (`WidgetTapIntent`), at once: the card switches to its "after one tap" version, which
//    the app worked out ahead (`WidgetItem.after`, never computed here, U26), and the tap is written to a small file
//    the app shares. iOS redraws the widget about 0.2 s after a widget-process intent returns, so a quick second tap
//    lands on the new card and moves on again. An app-process intent took ~3 s to show (L24).
// 2. In the app's process, straight after (`WidgetSaveIntent`, which iOS runs in the background when the first one
//    returns it; measured on the iPhone, 8 Oct 2026: the app never came to the front): every waiting tap, in order, is
//    saved in the database, then synced and backed up; reminders follow; the widgets are redrawn from the database.
//    The app also saves waiting taps whenever it starts or comes back, so a tap is never only in this file for long.
//
// Each tap is saved idempotently: a + by its own ID (never twice), a ✓ as the state it set ("check"/"uncheck"), so
// saving the same tap again changes nothing.

/// One waiting widget tap.
nonisolated struct WidgetTap: Codable, Sendable, Equatable {
    var event: String
    var item: String
    var day: String
    /// "add", "check" or "uncheck".
    var mode: String
    var signature: String
    var at: Date
}

nonisolated enum WidgetTaps {
    static var url: URL? { WidgetDisk.directory?.appendingPathComponent("widget-taps.json") }
    /// A safety limit: far more than anyone taps before the app saves them.
    static let maximum = 500

    /// The waiting taps, oldest first.
    static func read() -> [WidgetTap] {
        guard let url else { return [] }
        var taps: [WidgetTap] = []
        var error: NSError?
        NSFileCoordinator().coordinate(readingItemAt: url, options: [], error: &error) { file in
            taps = (try? Data(contentsOf: file)).flatMap { try? JSONDecoder().decode([WidgetTap].self, from: $0) } ?? []
        }
        return taps
    }

    /// Adds a tap at the end. Returns false if it couldn't be written.
    @discardableResult
    static func append(_ tap: WidgetTap) -> Bool {
        change { taps in
            guard taps.count < maximum else { return false }
            taps.append(tap); return true
        }
    }

    /// Takes away the taps the app has saved.
    static func remove(_ events: Set<String>) {
        _ = change { taps in taps.removeAll { events.contains($0.event) }; return true }
    }

    private static func change(_ edit: (inout [WidgetTap]) -> Bool) -> Bool {
        guard let url else { return false }
        var ok = false
        var error: NSError?
        NSFileCoordinator().coordinate(writingItemAt: url, options: .forMerging, error: &error) { file in
            var taps = (try? Data(contentsOf: file)).flatMap { try? JSONDecoder().decode([WidgetTap].self, from: $0) } ?? []
            guard edit(&taps), let data = try? JSONEncoder().encode(taps) else { return }
            do {
                try data.write(to: file, options: [.atomic, .completeFileProtectionUntilFirstUserAuthentication])
                ok = true
            } catch {}
        }
        return ok && error == nil
    }
}

nonisolated extension WidgetDisk {
    /// A tap on `itemID`'s ✓ or +: today's card becomes its "after one tap" version, everywhere it's drawn, and that
    /// version holds the one after it (a ✓'s is the card as it was, so taps go back and forth; a +'s is the app's next
    /// step). Returns the saved change ("add", "check", "uncheck"), or nil when the tap can't be taken here (another
    /// day, hidden content, a changed habit): then nothing changes.
    static func applyTap(itemID: String, day: String, signature: String, now: Date = .now) -> String? {
        guard let file = url else { return nil }
        var result: String?
        var error: NSError?
        NSFileCoordinator().coordinate(writingItemAt: file, options: .forMerging, error: &error) { file in
            guard let data = try? Data(contentsOf: file), var snapshot = decode(data), !snapshot.hidden,
                  let f = snapshot.frames.firstIndex(where: { $0.start <= now && now < $0.end && $0.day == day }),
                  let i = snapshot.frames[f].items.firstIndex(where: { $0.id == itemID }) else { return }
            let item = snapshot.frames[f].items[i]
            guard item.signature == signature, item.state == nil, item.action == .check || item.action == .add else { return }
            if item.action == .check {
                guard var after = item.after?.first else { return }
                var before = item; before.after = nil
                after.after = [before]
                snapshot.frames[f].items[i] = after
                result = after.done ? "check" : "uncheck"
            } else {
                result = "add"
                // Past the steps worked out ahead, the tap is still saved; the card waits for the app's redraw.
                if let after = item.after?.first { snapshot.frames[f].items[i] = after }
            }
            if let encoded = try? JSONEncoder().encode(snapshot), encoded.count <= maximumBytes {
                try? encoded.write(to: file, options: [.atomic, .completeFileProtectionUntilFirstUserAuthentication])
            }
        }
        return result
    }
}
