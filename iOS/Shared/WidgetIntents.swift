import AppIntents
import Foundation
import WidgetKit

// What Edit Widget offers (touch and hold a widget → Edit Widget), and what a widget's buttons do. Choices are saved by
// stable ID, so renaming a habit or a section keeps the widget's choice, and a deleted one says so instead of quietly
// showing something else (Accepted Widget Contract; Feature Ledger C040: widgets that lost their configuration).

/// A habit for the one-habit widgets (Small, the weekly Medium, the Lock Screen circle and line).
nonisolated struct WidgetSelection: AppEntity {
    static let typeDisplayRepresentation: TypeDisplayRepresentation = "Habit"
    static let defaultQuery = WidgetSelectionQuery()
    var id: String
    var name: String
    var symbol: String? = nil
    var displayRepresentation: DisplayRepresentation {
        .init(title: "\(name)", image: symbol.map { DisplayRepresentation.Image(systemName: $0) })
    }
}
nonisolated struct WidgetSelectionQuery: EntityStringQuery {
    func entities(for identifiers: [String]) async throws -> [WidgetSelection] {
        let choices = WidgetDisk.read()?.choices ?? []
        return identifiers.map { id in
            let choice = choices.first { $0.id == id }
            return WidgetSelection(id: id, name: choice?.name ?? "Habit unavailable — choose another", symbol: choice?.symbol)
        }
    }
    func entities(matching string: String) async throws -> [WidgetSelection] {
        try await suggestedEntities().filter { $0.name.localizedStandardContains(string) }
    }
    /// The person's habits in their own order (U13), with their icons. While names are hidden outside the app, the app
    /// wrote "Habit 1", "Habit 2"… instead of the names (Current Work 58).
    func suggestedEntities() async throws -> [WidgetSelection] {
        (WidgetDisk.read()?.choices ?? []).map { WidgetSelection(id: $0.id, name: $0.name, symbol: $0.symbol) }
    }
}

/// What a habit list shows: Today (every section, the default) or one of Today's cards.
nonisolated struct WidgetListSection: AppEntity {
    static let typeDisplayRepresentation: TypeDisplayRepresentation = "Section"
    static let defaultQuery = WidgetListSectionQuery()
    static let today = "today"
    var id: String
    var name: String
    var displayRepresentation: DisplayRepresentation { .init(title: "\(name)") }
}
nonisolated struct WidgetListSectionQuery: EntityQuery {
    func entities(for identifiers: [String]) async throws -> [WidgetListSection] {
        let sections = WidgetDisk.read()?.sections ?? []
        return identifiers.map { id in
            id == WidgetListSection.today ? WidgetListSection(id: id, name: "Today")
                : WidgetListSection(id: id, name: sections.first { $0.id == id }?.name ?? "Section unavailable")
        }
    }
    func suggestedEntities() async throws -> [WidgetListSection] {
        [WidgetListSection(id: WidgetListSection.today, name: "Today")]
            + (WidgetDisk.read()?.sections ?? []).map { WidgetListSection(id: $0.id, name: $0.name) }
    }
    func defaultResult() async -> WidgetListSection? { WidgetListSection(id: WidgetListSection.today, name: "Today") }
}

/// What a task list shows: all of today's tasks (the default) or one time of day's.
nonisolated struct WidgetTaskSection: AppEntity {
    static let typeDisplayRepresentation: TypeDisplayRepresentation = "Section"
    static let defaultQuery = WidgetTaskSectionQuery()
    var id: String
    var name: String
    var displayRepresentation: DisplayRepresentation { .init(title: "\(name)") }
}
nonisolated struct WidgetTaskSectionQuery: EntityQuery {
    func entities(for identifiers: [String]) async throws -> [WidgetTaskSection] {
        let sections = WidgetDisk.read()?.taskSections ?? []
        return identifiers.map { id in
            id == WidgetListSection.today ? WidgetTaskSection(id: id, name: "All tasks")
                : WidgetTaskSection(id: id, name: sections.first { $0.id == id }?.name ?? "Section unavailable")
        }
    }
    func suggestedEntities() async throws -> [WidgetTaskSection] {
        [WidgetTaskSection(id: WidgetListSection.today, name: "All tasks")]
            + (WidgetDisk.read()?.taskSections ?? []).map { WidgetTaskSection(id: $0.id, name: $0.name) }
    }
    func defaultResult() async -> WidgetTaskSection? { WidgetTaskSection(id: WidgetListSection.today, name: "All tasks") }
}

/// The Small one-habit widget and the Lock Screen circle and line.
struct ItemWidgetConfiguration: WidgetConfigurationIntent {
    static let title: LocalizedStringResource = "Choose a habit"
    static let description = IntentDescription("Choose the habit this widget shows.")
    @Parameter(title: "Habit") var item: WidgetSelection?
}
/// The habit lists (Medium and Large) and the Lock Screen's Today rectangle and line.
struct AgendaWidgetConfiguration: WidgetConfigurationIntent {
    static let title: LocalizedStringResource = "Today"
    static let description = IntentDescription("Show all of Today, or one section of your day.")
    @Parameter(title: "Show") var view: WidgetListSection?
}
/// The task lists (Medium and Large).
struct TasksWidgetConfiguration: WidgetConfigurationIntent {
    static let title: LocalizedStringResource = "Tasks"
    static let description = IntentDescription("Show all of today's tasks, or one section's.")
    @Parameter(title: "Show") var view: WidgetTaskSection?
}
/// The weekly Medium: one habit, this week.
struct HistoryWidgetConfiguration: WidgetConfigurationIntent {
    static let title: LocalizedStringResource = "Choose a habit"
    static let description = IntentDescription("Choose the habit this widget shows.")
    @Parameter(title: "Habit") var item: WidgetSelection?
}

/// ✓ or + on a widget, drawn as a switch (`WidgetRoundToggleStyle`) so iOS changes it the moment it's touched, before
/// any of this runs (Apple: a Toggle "will optimistically update its presentation… without having to wait for a
/// roundtrip"). Implemented in BOTH app and extension: a LiveActivityIntent runs in the app's process, where the data
/// is, so every tap is saved in the database, synced and backed up even when the app is never opened (Current Work 66).
/// The extension has no database and never reports a write it didn't make. Works from the Lock Screen without
/// unlocking (Implementation Spec §8).
///
/// Every tap counts (Current Work 66): a ✓ flips the day's saved tick, taps saved strictly in order, so a quick run of
/// taps ends where the switch shows; a + adds one with its own new ID, so a second tap before the widget redraws is a
/// second log, never a duplicate of the first.
struct WidgetLogIntent: LiveActivityIntent, SetValueIntent {
    static let title: LocalizedStringResource = "Log a habit"
    static var isDiscoverable: Bool { false }
    static var authenticationPolicy: IntentAuthenticationPolicy { .alwaysAllowed }
    @Parameter(title: "Item") var item: String
    @Parameter(title: "Day") var day: String
    @Parameter(title: "Configuration") var signature: String
    /// "toggle" (a ✓ that ticks and unticks the day) or "add" (a + that adds one).
    @Parameter(title: "Mode") var mode: String
    /// The switch's new state as iOS sets it (`SetValueIntent`); kept for the switch, not relied on (see `perform`).
    @Parameter(title: "Value") var value: Bool
    init() {}
    init(item: WidgetItem, day: String) {
        self.item = item.id; self.day = day; signature = item.signature
        mode = item.action == .check ? "toggle" : "add"
        value = !item.done
    }
    @MainActor func perform() async throws -> some IntentResult {
        #if HABITS_APP
        #if DEBUG
        WidgetDisk.diagnose("app intent started")
        WidgetTiming.mark("tap: log intent started")
        #endif
        // A ✓ flips what's saved (see `HabitStore.logFromWidget`); `value` isn't relied on: on a second quick tap iOS
        // sent the first tap's value again (measured on the iPhone, 8 Oct 2026).
        let change = mode == "toggle" ? "flip" : "add"
        do {
            try await AppModel.shared.logFromWidget(item: item, day: day, event: UUID().uuidString, signature: signature, mode: change)
            #if DEBUG
            WidgetDisk.diagnose("app intent committed")
            WidgetTiming.mark("tap: log intent returns")
            #endif
        } catch {
            #if DEBUG
            WidgetDisk.diagnose("app intent failed: \(error)")
            #endif
            throw error
        }
        #else
        #if DEBUG
        WidgetDisk.diagnose("extension intent invoked")
        WidgetTiming.mark("tap: log intent ran in the WIDGET process (throws openApp)")
        #endif
        throw WidgetActionError.openApp
        #endif
        return .result()
    }
}

// LOCKED (widget taps, 8 Oct 2026): a tap runs here in the widget's process and hands over to the app (W1); never make it an app-process intent. Read iOS/Docs/Widgets — Taps and Updates (Locked).md before changing; changes need the user's say-so.
/// ✓ or + on a widget (Current Work 66): runs in the widget's own process, so the widget redraws about 0.2 s later;
/// shows the card after the tap (`WidgetDisk.applyTap`), keeps the tap safe in the shared file (`WidgetTaps`), then
/// hands over to the app in the background (`WidgetSaveIntent`), which saves it in the database, syncs and backs up.
struct WidgetTapIntent: AppIntent {
    static let title: LocalizedStringResource = "Log a habit"
    static var isDiscoverable: Bool { false }
    static var authenticationPolicy: IntentAuthenticationPolicy { .alwaysAllowed }
    @Parameter(title: "Item") var item: String
    @Parameter(title: "Day") var day: String
    @Parameter(title: "Configuration") var signature: String
    init() {}
    init(item: WidgetItem, day: String) {
        self.item = item.id; self.day = day; signature = item.signature
    }
    func perform() async throws -> some IntentResult & OpensIntent {
        #if DEBUG
        WidgetTiming.mark("tap: widget intent started")
        #endif
        let now = Date.now
        if let mode = WidgetDisk.applyTap(itemID: item, day: day, signature: signature, now: now) {
            WidgetTaps.append(WidgetTap(event: UUID().uuidString, item: item, day: day, mode: mode, signature: signature, at: now))
        }
        // The other widgets showing this habit redraw too (the tapped one always does when this returns).
        WidgetCenter.shared.reloadAllTimelines()
        #if DEBUG
        WidgetTiming.mark("tap: widget intent returns")
        #endif
        return .result(opensIntent: WidgetSaveIntent())
    }
}

/// Saves every waiting widget tap in the app's process, in the background (iOS runs it when `WidgetTapIntent`
/// returns it): the database, then sync, backup, reminders and the widgets' redraw from the saved data.
struct WidgetSaveIntent: LiveActivityIntent {
    static let title: LocalizedStringResource = "Save widget taps"
    static var isDiscoverable: Bool { false }
    static var authenticationPolicy: IntentAuthenticationPolicy { .alwaysAllowed }
    init() {}
    @MainActor func perform() async throws -> some IntentResult {
        #if HABITS_APP
        #if DEBUG
        WidgetTiming.mark("tap: save intent started")
        #endif
        await AppModel.shared.saveWidgetTaps()
        #if DEBUG
        WidgetTiming.mark("tap: save intent returns")
        #endif
        #endif
        return .result()
    }
}

// LOCKED (widget taps, 8 Oct 2026): timers start and stop on the widget, never opening the app (W7). Read iOS/Docs/Widgets — Taps and Updates (Locked).md before changing; changes need the user's say-so.
/// ▶ or ⏸ on a widget: the same timer as Today's row, with its Live Activity and Dynamic Island. ▶ only starts and ⏸
/// only stops and saves, so a retried callback never undoes itself.
struct WidgetTimerIntent: LiveActivityIntent {
    static let title: LocalizedStringResource = "Start or pause a timer"
    static var isDiscoverable: Bool { false }
    static var authenticationPolicy: IntentAuthenticationPolicy { .alwaysAllowed }
    @Parameter(title: "Item") var item: String
    @Parameter(title: "Day") var day: String
    @Parameter(title: "Start") var start: Bool
    @Parameter(title: "Configuration") var signature: String
    init() {}
    init(item: WidgetItem, day: String) {
        self.item = item.id; self.day = day; start = item.action == .timerStart; signature = item.signature
    }
    @MainActor func perform() async throws -> some IntentResult {
        #if HABITS_APP
        #if DEBUG
        WidgetTiming.mark("tap: timer intent started")
        #endif
        try await AppModel.shared.timerFromWidget(item: item, day: day, start: start, signature: signature)
        #if DEBUG
        WidgetTiming.mark("tap: timer intent returns")
        #endif
        #else
        #if DEBUG
        WidgetTiming.mark("tap: timer intent ran in the WIDGET process (throws openApp)")
        #endif
        throw WidgetActionError.openApp
        #endif
        return .result()
    }
}

/// ‹ and › on a list: the page is display state for that list, kept in the shared container.
struct WidgetPageIntent: AppIntent {
    static let title: LocalizedStringResource = "Change widget page"
    static var isDiscoverable: Bool { false }
    static var authenticationPolicy: IntentAuthenticationPolicy { .alwaysAllowed }
    @Parameter(title: "View") var key: String
    @Parameter(title: "Page") var page: Int
    @Parameter(title: "Kind") var kind: String
    init() {}
    init(key: String, page: Int, kind: String) { self.key = key; self.page = page; self.kind = kind }
    @MainActor func perform() async throws -> some IntentResult {
        let directory = WidgetDisk.directory
        let telemetry = WidgetAnalyticsRelay.ticket(directory: directory)
        _ = WidgetDisk.page(key: key, set: page) {
            DispatchQueue.global(qos: .utility).async {
                WidgetAnalyticsRelay.committed(ticket: telemetry, directory: directory)
            }
        }
        if kind.isEmpty { WidgetCenter.shared.reloadAllTimelines() } else { WidgetCenter.shared.reloadTimelines(ofKind: kind) }
        return .result()
    }
}

nonisolated enum WidgetActionError: Error, CustomLocalizedStringResourceConvertible {
    case openApp, stale, save
    var localizedStringResource: LocalizedStringResource {
        switch self {
        case .openApp: "Open the app to unlock your data or log this item."
        case .stale: "This widget has changed. Open the app to refresh it."
        case .save: "That couldn't be saved. Open the app and try again."
        }
    }
}

#if DEBUG
/// Debug only (Current Work 65): stand-ins for the log button that change no data, to find out on the iPhone whether a
/// widget tap opens the app because the intent must run in the app's process. Chosen with `debug.probeIntent` in the
/// shared group ("live" or "extension"); `WidgetLatencyDeviceTests` sets it through a launch argument.
struct WidgetProbeLiveIntent: LiveActivityIntent {
    static let title: LocalizedStringResource = "Probe (app process)"
    static var isDiscoverable: Bool { false }
    static var authenticationPolicy: IntentAuthenticationPolicy { .alwaysAllowed }
    init() {}
    func perform() async throws -> some IntentResult {
        WidgetTiming.mark("probe: live intent ran in the \(Bundle.main.bundleURL.pathExtension == "appex" ? "WIDGET" : "app") process")
        return .result()
    }
}
struct WidgetProbeExtensionIntent: AppIntent {
    static let title: LocalizedStringResource = "Probe (widget process)"
    static var isDiscoverable: Bool { false }
    static var authenticationPolicy: IntentAuthenticationPolicy { .alwaysAllowed }
    init() {}
    func perform() async throws -> some IntentResult {
        WidgetTiming.mark("probe: plain intent ran in the \(Bundle.main.bundleURL.pathExtension == "appex" ? "widget" : "APP") process")
        return .result()
    }
}
/// Debug comparison: runs in the widget's process, then asks iOS to run an app-process intent. Does that one run in the
/// background, without opening the app?
struct WidgetProbeChainIntent: AppIntent {
    static let title: LocalizedStringResource = "Probe (widget, then app)"
    static var isDiscoverable: Bool { false }
    static var authenticationPolicy: IntentAuthenticationPolicy { .alwaysAllowed }
    init() {}
    func perform() async throws -> some IntentResult & OpensIntent {
        WidgetTiming.mark("probe: chain intent ran in the \(Bundle.main.bundleURL.pathExtension == "appex" ? "widget" : "APP") process")
        return .result(opensIntent: WidgetProbeLiveIntent())
    }
}
nonisolated enum WidgetProbe {
    static var mode: String? { UserDefaults(suiteName: WidgetDisk.group)?.string(forKey: "debug.probeIntent") }
    /// "live": ‹ › run in the app's process, to compare when the screen shows a change against the widget's own.
    static var pageMode: String? { UserDefaults(suiteName: WidgetDisk.group)?.string(forKey: "debug.pageProbe") }
}
/// ‹ and › exactly as `WidgetPageIntent`, but run in the app's process (debug comparison only).
struct WidgetPageLiveProbeIntent: LiveActivityIntent {
    static let title: LocalizedStringResource = "Change widget page (app process)"
    static var isDiscoverable: Bool { false }
    static var authenticationPolicy: IntentAuthenticationPolicy { .alwaysAllowed }
    @Parameter(title: "View") var key: String
    @Parameter(title: "Page") var page: Int
    @Parameter(title: "Kind") var kind: String
    init() {}
    init(key: String, page: Int, kind: String) { self.key = key; self.page = page; self.kind = kind }
    func perform() async throws -> some IntentResult {
        WidgetTiming.mark("probe: page intent in the \(Bundle.main.bundleURL.pathExtension == "appex" ? "WIDGET" : "app") process")
        _ = WidgetDisk.page(key: key, set: page)
        if kind.isEmpty { WidgetCenter.shared.reloadAllTimelines() } else { WidgetCenter.shared.reloadTimelines(ofKind: kind) }
        return .result()
    }
}
#endif
