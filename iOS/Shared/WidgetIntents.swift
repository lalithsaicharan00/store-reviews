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
    var displayRepresentation: DisplayRepresentation { .init(title: "\(name)") }
}
nonisolated struct WidgetSelectionQuery: EntityStringQuery {
    func entities(for identifiers: [String]) async throws -> [WidgetSelection] {
        let choices = WidgetDisk.read()?.choices ?? []
        return identifiers.map { id in
            WidgetSelection(id: id, name: choices.first { $0.id == id }?.name ?? "Habit unavailable — choose another")
        }
    }
    func entities(matching string: String) async throws -> [WidgetSelection] {
        try await suggestedEntities().filter { $0.name.localizedStandardContains(string) }
    }
    /// The person's habits in their own order (U13). None while widget content is hidden.
    func suggestedEntities() async throws -> [WidgetSelection] {
        (WidgetDisk.read()?.choices ?? []).map { WidgetSelection(id: $0.id, name: $0.name) }
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

/// ✓ or + on a widget. Implemented in BOTH app and extension: a LiveActivityIntent runs in the app's process, where the
/// data is; the extension has no database and never reports a write it didn't make. Works from the Lock Screen
/// without unlocking (Implementation Spec §8).
struct WidgetLogIntent: LiveActivityIntent {
    static let title: LocalizedStringResource = "Log a habit"
    static var isDiscoverable: Bool { false }
    static var authenticationPolicy: IntentAuthenticationPolicy { .alwaysAllowed }
    @Parameter(title: "Item") var item: String
    @Parameter(title: "Day") var day: String
    @Parameter(title: "Event") var event: String
    @Parameter(title: "Configuration") var signature: String
    /// "check", "uncheck" or "add": what the drawn button did, so a retried callback can't do the opposite.
    @Parameter(title: "Mode") var mode: String
    init() {}
    init(item: WidgetItem, day: String) {
        self.item = item.id; self.day = day; event = item.token; signature = item.signature
        mode = item.action == .check ? (item.done ? "uncheck" : "check") : "add"
    }
    @MainActor func perform() async throws -> some IntentResult {
        #if HABITS_APP
        #if DEBUG
        WidgetDisk.diagnose("app intent started")
        #endif
        do {
            try await AppModel.shared.logFromWidget(item: item, day: day, event: event, signature: signature, mode: mode)
            #if DEBUG
            WidgetDisk.diagnose("app intent committed")
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
        #endif
        throw WidgetActionError.openApp
        #endif
        return .result()
    }
}

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
        try await AppModel.shared.timerFromWidget(item: item, day: day, start: start, signature: signature)
        #else
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
