import AppIntents
import SwiftUI
import WidgetKit

// The Watch's complications and Smart Stack widgets (E, WA11, R7). Every word, number and order comes from the snapshot
// the Watch app writes after each change (`WidgetPublisher`, the same projection the iPhone's widgets draw, U26); the
// extension never opens the database. A timeline entry at the next day start moves the face to the new day by itself
// (WA5). When the snapshot isn't for now (an older day), a habit shows without a count, never "all done" (WA11).

@main
struct OftenEnoughWatchWidgets: WidgetBundle {
    var body: some Widget {
        TodayComplication()
        HabitComplication()
        LogComplication()
    }
}

// MARK: - The timeline

struct TodayProvider: TimelineProvider {
    func placeholder(in context: Context) -> FaceEntry { FaceEntry(date: .now, snapshot: nil, frame: nil) }
    func getSnapshot(in context: Context, completion: @escaping (FaceEntry) -> Void) {
        completion(FaceTimeline.entries().first ?? placeholder(in: context))
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<FaceEntry>) -> Void) {
        completion(Timeline(entries: FaceTimeline.entries(), policy: .atEnd))
    }
}

// MARK: - Today: the day bar and what's left (E1, E3, E5)

struct TodayComplication: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "OftenEnough.Watch.Today", provider: TodayProvider()) { entry in
            FamilyReader { TodayFace(entry: entry, family: $0) }
                .widgetURL(URL(string: "oftenenough://watch/today"))
                .containerBackground(.clear, for: .widget)
        }
        .configurationDisplayName("Today")
        .description("What's left today, in your order.")
        .supportedFamilies([.accessoryRectangular, .accessoryCircular, .accessoryInline, .accessoryCorner])
    }
}

// MARK: - One habit (E1 circles, E5, E6)

struct HabitChoiceEntity: AppEntity {
    static let typeDisplayRepresentation: TypeDisplayRepresentation = "Habit"
    static let defaultQuery = HabitChoiceQuery()
    let id: String
    let name: String
    var displayRepresentation: DisplayRepresentation { DisplayRepresentation(title: "\(name)") }
}

struct HabitChoiceQuery: EntityQuery {
    func entities(for identifiers: [String]) async throws -> [HabitChoiceEntity] {
        try await suggestedEntities().filter { identifiers.contains($0.id) }
    }
    func suggestedEntities() async throws -> [HabitChoiceEntity] {
        (WidgetDisk.read()?.choices ?? []).map { HabitChoiceEntity(id: $0.id, name: $0.name) }
    }
}

struct HabitChoiceIntent: WidgetConfigurationIntent {
    static let title: LocalizedStringResource = "Habit"
    @Parameter(title: "Habit") var habit: HabitChoiceEntity?
    init() {}
    init(habit: HabitChoiceEntity) { self.habit = habit }
}

struct HabitProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> FaceEntry { FaceEntry(date: .now, snapshot: nil, frame: nil) }
    func snapshot(for configuration: HabitChoiceIntent, in context: Context) async -> FaceEntry {
        FaceTimeline.entries(habitID: configuration.habit?.id).first ?? placeholder(in: context)
    }
    func timeline(for configuration: HabitChoiceIntent, in context: Context) async -> Timeline<FaceEntry> {
        Timeline(entries: FaceTimeline.entries(habitID: configuration.habit?.id), policy: .atEnd)
    }
    /// Which habit a complication shows is chosen in Apple's own face editor (E6): one option per habit.
    func recommendations() -> [AppIntentRecommendation<HabitChoiceIntent>] {
        (WidgetDisk.read()?.choices ?? []).prefix(12).map { choice in
            AppIntentRecommendation(intent: HabitChoiceIntent(habit: HabitChoiceEntity(id: choice.id, name: choice.name)),
                                    description: Text(choice.name))
        }
    }
}

struct HabitComplication: Widget {
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: "OftenEnough.Watch.Habit", intent: HabitChoiceIntent.self, provider: HabitProvider()) { entry in
            FamilyReader { HabitFace(entry: entry, family: $0) }
                .widgetURL(URL(string: "oftenenough://watch/habit/\(entry.habitID ?? "")"))
                .containerBackground(.clear, for: .widget)
        }
        .configurationDisplayName("Habit")
        .description("One habit's progress today; a quit habit's run.")
        .supportedFamilies([.accessoryCircular, .accessoryRectangular, .accessoryInline, .accessoryCorner])
    }
}

// MARK: - Logging from the face (E2, E4)

struct LogComplication: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "OftenEnough.Watch.Log", provider: TodayProvider()) { entry in
            LogFace(entry: entry)
                .widgetURL(URL(string: "oftenenough://watch/today"))
                .containerBackground(.clear, for: .widget)
        }
        .configurationDisplayName("Log from the face")
        .description("The next habits left today, each a button that logs.")
        .supportedFamilies([.accessoryRectangular])
    }
}

/// Hands the widget's family to the shared face views.
struct FamilyReader<Content: View>: View {
    @Environment(\.widgetFamily) private var family
    let content: (WidgetFamily) -> Content
    var body: some View { content(family) }
}
