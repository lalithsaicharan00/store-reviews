import SwiftUI
import WidgetKit

// A starter so the extension builds. The real widgets replace it.
@main
struct HabitsWidgets: WidgetBundle {
    var body: some Widget {
        StarterWidget()
    }
}

struct StarterEntry: TimelineEntry {
    let date: Date
}

struct StarterProvider: TimelineProvider {
    func placeholder(in context: Context) -> StarterEntry { StarterEntry(date: Date()) }

    func getSnapshot(in context: Context, completion: @escaping (StarterEntry) -> Void) {
        completion(StarterEntry(date: Date()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<StarterEntry>) -> Void) {
        completion(Timeline(entries: [StarterEntry(date: Date())], policy: .never))
    }
}

struct StarterWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "Starter", provider: StarterProvider()) { _ in
            Text("Often Enough")
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Often Enough")
    }
}
