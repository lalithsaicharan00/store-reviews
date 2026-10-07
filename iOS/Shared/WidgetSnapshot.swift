import Foundation

// The widgets' data (Implementation Spec — Every Widget, 6 Oct 2026). Worked out once in the app, after the data
// changes stop (Rulebook S5, S16), and read by the extension. Display data only: SQLite and private notes never leave
// the app container. Every word, number and order a widget shows is decided here, so the extension does no history
// walking, no formatting of amounts and no sorting (S8).

/// What one tap on a widget's round button does.
nonisolated enum WidgetAction: String, Codable, Sendable {
    /// ✓ toggles that day's tick: a done check unchecks that same day only (U14).
    case check
    /// +N adds exactly one saved increment; it never takes one back.
    case add
    /// ▶ starts the timer where it is (Open Timer Full Screen is off); the Live Activity shows it.
    case timerStart
    /// ⏸ stops the running timer and saves its session once.
    case timerPause
    /// The button opens `route` in the app: the amount entry, Record a slip, the named steps, the full-screen timer,
    /// or Day details.
    case open
}

/// One habit or task on one day.
nonisolated struct WidgetItem: Codable, Identifiable, Sendable {
    var id: String
    var name: String
    var symbol: String
    var color = "blue"
    /// check, count, amount, duration, checklist, quit, task.
    var type: String
    var isTask = false
    /// Cut down: the goal is a maximum. Never celebrated (U3, U25).
    var limit = false
    /// nil, or "skipped", "paused", "notPlanned": neutral states with quick logging off.
    var state: String?
    /// The Today cards it's on this day, in Today's order (`DaySection.id` or "quitting"); empty when it isn't on Today.
    var cards: [String] = []
    /// The row's line in a list showing one section ("3 of 8 glasses", "Done", "12 min today · 1 h a week", "5:00 PM"),
    /// and in a Today list, with the section first ("Anytime · 3 of 8 glasses").
    var line: String
    var todayLine: String = ""
    /// The first card's name ("Morning"), empty for Quit or Cut Down: put before a running timer's live clock.
    var place: String = ""
    /// The Small card's value line ("3 of 8 glasses", "1 of 2 cups max", "1h 12m of 3 h").
    var value: String
    /// The weekly Medium's big number and the goal after it ("3", "/ 8 glasses").
    var big: String = ""
    var goal: String = ""
    /// Small supporting text: the Small card's caption capsule and the weekly card's line under the name
    /// ("Daily limit", "Limit reached", "Best 45 days", "Skipped today").
    var caption: String?
    /// How full a list row is, 0…1, toward its goal, as Today's row: today's, or a week or month goal's (U25); and the
    /// Small and weekly cards' bar, toward the goal's own period. Capped when drawn; the text keeps the true value.
    var fraction: Double?
    var cardFraction: Double?
    /// A limit's neutral grey fill, never the habit's colour.
    var limitFill = false
    /// Positive completion: the button turns the habit's colour with white content.
    var done = false
    /// A + whose next tap meets the goal: the switch shows the habit's colour the moment it's touched (Current Work 66).
    /// Optional, so a snapshot written before it existed still reads.
    var completesNext: Bool?
    // LOCKED (widget taps, 8 Oct 2026): the widget draws the app's own next state, never its own (W3). Read iOS/Docs/Widgets — Taps and Updates (Locked).md before changing; changes need the user's say-so.
    /// Today's ✓ or +: this card as it will be after one tap (one element, or nil), worked out by the app. The widget
    /// draws it the moment the button is touched, so the whole card changes at once (Current Work 66).
    var after: [WidgetItem]?
    /// What today adds up to, and today's week square, as the app counted them (for `after`).
    var todayAmount: Double?
    var todayLevel: Int?
    /// Counted in a list's "2 of 5 done", and whether it's done for the day there (the day bar's own rule: positive
    /// items once; quit, cut down and skipped days are not counted, U10).
    var counts = false
    var countsDone = false
    /// Done for the day on Today (or skipped): it sinks below the rest when done habits move to the bottom (U13).
    var sinks = false
    var action: WidgetAction = .open
    /// What a + button says ("+1", "+500").
    var actionText: String?
    /// Where the button (`action == .open`) goes.
    var route: String?
    /// The drawn rendition's ID (the snapshot's checks require one per tappable item). A tap's log gets its own new ID
    /// (Current Work 66): two quick taps on the same drawing are two logs.
    var token: String
    var signature: String
    /// The Lock Screen circle's value on one line ("3/8", "12/20m", "4.2k/8k") and its ring (nil: no ring).
    var lock: String?
    var ring: Double?
    /// "12", "3×", "4 wk"; nil with no current streak (never a zero, U3) or with streaks hidden.
    var streak: String?
    /// Quit: when the current run began; the counter ends at `quitUntil` (a known pause or end).
    var quitStart: Date?
    var quitUntil: Date?
    /// Quit: the best earlier run in seconds (nil before any), for the bar and "New best"; and "Best 45 days".
    var quitBest: Double?
    var quitBestText: String?
    /// Quit: "Since 20 Sep" ("Since 14:21" for a slip today).
    var since: String?
    /// A running timer: when its clock read 0:00 (start minus what was already logged), and when it reaches the goal.
    var timerClock: Date?
    var timerGoalAt: Date?
    /// After the live clock: " of 30 min", " of 20 max".
    var timerGoal: String?
    /// The week's seven squares, in the person's week order: see `WidgetCell`.
    var week: [Int] = []
    /// Which of the seven is this item's day (the outlined one), or -1.
    var weekToday = -1
    /// The habit's five heat steps, light then dark, then dark mode's ✓ colour (`HeatPalette`), as 0xRRGGBB.
    var heat: [Int] = []
    var url: URL { URL(string: "oftenenough://item/" + id) ?? URL(string: "oftenenough://today")! }
    var routeURL: URL { route.flatMap(URL.init(string:)) ?? url }
}

/// A day's square in the weekly widget: the Progress Week's language (`HeatCell`), as a number.
nonisolated enum WidgetCell {
    static let blank = -1, upcoming = -2, notScheduled = -3, skipped = -4, paused = -5
    /// 0: not done (grey with ✕); 1–3: part of the day's goal; 4: goal met (✓); 5: more than the goal (✓).
}

/// A Today card that a list can show (a time of day, Anytime, or Quit or Cut Down), by its stable ID (U13).
nonisolated struct WidgetSection: Codable, Hashable, Sendable {
    var id: String
    var name: String
}

/// A habit offered in Edit Widget's habit picker, in the person's own order.
nonisolated struct WidgetChoice: Codable, Hashable, Sendable {
    var id: String
    var name: String
}

nonisolated struct WidgetFrame: Codable, Sendable {
    var day: String
    var start: Date
    var end: Date
    /// Every active habit and the day's tasks (a one-habit widget shows its habit even on a day it isn't planned).
    var items: [WidgetItem]
    /// Each list's items in Today's order: "habits" (Today), "habits:<section>", "tasks", "tasks:<section>".
    var lists: [String: [String]] = [:]
    /// The order shown until `settle`: nothing moves during a run of taps (U4); done rows sink after it (U13).
    var held: [String: [String]]?
    var settle: Date?

    func item(_ id: String?) -> WidgetItem? { id.flatMap { id in items.first { $0.id == id } } }

    /// One list's items, in the order shown at `date`.
    func list(_ key: String, at date: Date) -> [WidgetItem] {
        let holding = settle.map { date < $0 } ?? false
        let shown: [String]? = holding ? held?[key] : nil
        let ids = shown ?? lists[key] ?? []
        let byID = Dictionary(items.map { ($0.id, $0) }, uniquingKeysWith: { first, _ in first })
        return ids.compactMap { byID[$0] }
    }
}

nonisolated struct WidgetSnapshot: Codable, Sendable {
    static let version = 2
    var version = Self.version
    var generated: Date
    var timeZone: String
    var locale: String
    var plus: Bool
    var hidden: Bool
    /// The habit lists' cards in Today's order (the person's own, U13), and the task lists' (no Quit or Cut Down).
    var sections: [WidgetSection] = []
    var taskSections: [WidgetSection] = []
    var choices: [WidgetChoice] = []
    /// "Sun" … "Sat" in the person's week order (week start, D7).
    var weekdays: [String] = []
    /// ▶ opens the full-screen timer (Appearance → Open Timer Full Screen), or starts it in place.
    var timerOpensScreen = true
    /// Seven logical days from today, so the widgets move on at midnight (or the day start) without the app.
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
    static var url: URL? { directory?.appendingPathComponent("widget-snapshot-v2.json") }

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
                  let ids = Set(frame.items.map(\.id))
                  return frame.start < frame.end && ids.count == frame.items.count
                      && frame.items.allSatisfy { item in
                          UUID(uuidString: item.id) != nil
                              && (item.fraction.map(\.isFinite) ?? true) && (item.ring.map(\.isFinite) ?? true)
                              && ([.check, .add, .timerStart, .timerPause].contains(item.action) ? UUID(uuidString: item.token) != nil : true)
                              && (item.week.isEmpty || item.week.count == 7)
                      }
                      && frame.lists.values.allSatisfy { $0.allSatisfy(ids.contains) }
              }),
              zip(snapshot.frames, snapshot.frames.dropFirst()).allSatisfy({ $0.end == $1.start }) else { return nil }
        return snapshot
    }
    static func read(from file: URL? = url) -> WidgetSnapshot? {
        #if DEBUG
        let started = Date.now
        #endif
        guard let file, let size = try? file.resourceValues(forKeys: [.fileSizeKey]).fileSize,
              size <= maximumBytes, let data = try? Data(contentsOf: file) else {
            #if DEBUG
            WidgetTiming.mark("read: no snapshot file")
            #endif
            return nil
        }
        let snapshot = decode(data)
        #if DEBUG
        WidgetTiming.mark(String(format: "read: %d bytes decoded in %.0f ms%@", size, Date.now.timeIntervalSince(started) * 1000,
                                 snapshot == nil ? " (rejected)" : ""))
        #endif
        return snapshot
    }
    static func write(_ snapshot: WidgetSnapshot, to file: URL? = url) throws {
        guard let file else { throw CocoaError(.fileNoSuchFile) }
        let data = try JSONEncoder().encode(snapshot)
        guard data.count <= maximumBytes else { throw CocoaError(.fileWriteOutOfSpace) }
        try FileManager.default.createDirectory(at: file.deletingLastPathComponent(), withIntermediateDirectories: true)
        // LOCKED (widget taps, 8 Oct 2026): coordinated writes (W17). Read iOS/Docs/Widgets — Taps and Updates (Locked).md before changing; changes need the user's say-so.
        // Coordinated with a widget tap's own change to the same file (`applyTap`), so neither half-overwrites the other.
        var failure: Error?
        var coordination: NSError?
        NSFileCoordinator().coordinate(writingItemAt: file, options: .forReplacing, error: &coordination) { file in
            do { try data.write(to: file, options: [.atomic, .completeFileProtectionUntilFirstUserAuthentication]) } catch { failure = error }
        }
        if let error = failure ?? coordination { throw error }
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

/// Pages of a list (Implementation Spec §5): explicit pages, never scrolling; the last page keeps its rows at the top.
nonisolated enum WidgetPaging {
    static func pages(_ count: Int, capacity: Int) -> Int { max(1, (count + capacity - 1) / max(1, capacity)) }
    /// A page that no longer exists (items went) shows the last one instead, never an empty page.
    static func clamp(_ page: Int, count: Int, capacity: Int) -> Int { min(max(0, page), pages(count, capacity: capacity) - 1) }
    static func slice<T>(_ items: [T], page: Int, capacity: Int) -> [T] {
        let page = clamp(page, count: items.count, capacity: capacity)
        return Array(items.dropFirst(page * capacity).prefix(capacity))
    }
}
