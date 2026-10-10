import SwiftUI
import WidgetKit

/// The Watch's complications and Smart Stack widgets (E).
@main
struct OftenEnoughWatchWidgets: WidgetBundle {
    var body: some Widget {
        TodayComplication()
    }
}

struct TodayComplication: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "OftenEnough.Watch.Today", provider: TodayProvider()) { entry in
            Text(entry.text)
        }
        .configurationDisplayName("Today")
        .description("What's left today.")
        .supportedFamilies([.accessoryInline])
    }
}

struct TodayEntry: TimelineEntry {
    let date: Date
    let text: String
}

struct TodayProvider: TimelineProvider {
    func placeholder(in context: Context) -> TodayEntry { TodayEntry(date: .now, text: "Today") }
    func getSnapshot(in context: Context, completion: @escaping (TodayEntry) -> Void) { completion(placeholder(in: context)) }
    func getTimeline(in context: Context, completion: @escaping (Timeline<TodayEntry>) -> Void) {
        completion(Timeline(entries: [placeholder(in: context)], policy: .never))
    }
}
