import AppIntents
import Foundation
import WidgetKit

nonisolated struct WidgetSelection: AppEntity {
    static let typeDisplayRepresentation: TypeDisplayRepresentation = "Habit or task"
    static let defaultQuery = WidgetSelectionQuery()
    var id: String
    var name: String
    var displayRepresentation: DisplayRepresentation { .init(title: "\(name)") }
}
nonisolated struct WidgetSelectionQuery: EntityStringQuery {
    func entities(for identifiers: [String]) async throws -> [WidgetSelection] {
        let items = WidgetDisk.read()?.frames.first?.items ?? []
        return identifiers.map { id in
            WidgetSelection(id: id, name: items.first { $0.id == id }?.name ?? "Unavailable item — choose another")
        }
    }
    func entities(matching string: String) async throws -> [WidgetSelection] {
        try await suggestedEntities().filter { $0.name.localizedStandardContains(string) }
    }
    func suggestedEntities() async throws -> [WidgetSelection] {
        (WidgetDisk.read()?.frames.first?.items ?? []).map { WidgetSelection(id: $0.id, name: $0.name) }
    }
}
struct ItemWidgetConfiguration: WidgetConfigurationIntent {
    static let title: LocalizedStringResource = "Choose an item"
    static let description = IntentDescription("Choose a habit or unlimited task. Quit counters never have a reset button.")
    @Parameter(title: "Habit or task") var item: WidgetSelection?
}
struct AgendaWidgetConfiguration: WidgetConfigurationIntent {
    static let title: LocalizedStringResource = "Today"
    @Parameter(title: "Show completed", default: false) var completed: Bool
    @Parameter(title: "Tasks only", default: false) var tasksOnly: Bool
}
nonisolated enum WidgetHistoryRange: String, AppEnum {
    case week, month
    static let typeDisplayRepresentation: TypeDisplayRepresentation = "History"
    static let caseDisplayRepresentations: [Self: DisplayRepresentation] = [.week: "Last 7 days", .month: "Last 31 days"]
}
struct HistoryWidgetConfiguration: WidgetConfigurationIntent {
    static let title: LocalizedStringResource = "Habit history · Plus"
    @Parameter(title: "Habit") var item: WidgetSelection?
    @Parameter(title: "Range", default: .week) var range: WidgetHistoryRange
}

/// Implemented in BOTH app and extension. LiveActivityIntent dispatches to the app process;
/// the extension has no SQLite/Kotlin access and must never report a successful local write.
struct WidgetLogIntent: LiveActivityIntent {
    static let title: LocalizedStringResource = "Log one step"
    static var isDiscoverable: Bool { false }
    @Parameter(title: "Item") var item: String
    @Parameter(title: "Day") var day: String
    @Parameter(title: "Event") var event: String
    @Parameter(title: "Configuration") var signature: String
    init() {}
    init(item: WidgetItem, day: String) {
        self.item = item.id; self.day = day; event = item.token; signature = item.signature
    }
    @MainActor func perform() async throws -> some IntentResult {
        #if HABITS_APP
        try await AppModel.shared.logFromWidget(item: item, day: day, event: event, signature: signature)
        #else
        throw WidgetActionError.openApp
        #endif
        return .result()
    }
}
struct WidgetPageIntent: AppIntent {
    static let title: LocalizedStringResource = "Change widget page"
    static var isDiscoverable: Bool { false }
    @Parameter(title: "View") var key: String
    @Parameter(title: "Page") var page: Int
    init() {}
    init(key: String, page: Int) { self.key = key; self.page = page }
    @MainActor func perform() async throws -> some IntentResult {
        _ = WidgetDisk.page(key: key, set: page)
        WidgetCenter.shared.reloadAllTimelines()
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
